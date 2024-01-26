/* valagerrormodule.vala
 *
 * Copyright (C) 2008-2010  Jürg Billeter
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public
 * License as published by the Free Software Foundation; either
 * version 2.1 of the License, or (at your option) any later version.

 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * Lesser General Public License for more details.

 * You should have received a copy of the GNU Lesser General Public
 * License along with this library; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301  USA
 *
 * Author:
 *	Jürg Billeter <j@bitron.ch>
 *	Thijs Vermeir <thijsvermeir@gmail.com>
 */

using GLib;

public class Vala.GErrorModule : CCodeDelegateModule {
	private bool is_in_catch = false;

	public override void generate_error_domain_declaration (ErrorDomain edomain, CCodeFile decl_space) {
		if (add_symbol_declaration (decl_space, edomain, get_ccode_name (edomain))) {
			return;
		}

		generate_type_declaration (gquark_type, decl_space);

		var cenum = new CCodeEnum (get_ccode_name (edomain));

		foreach (ErrorCode ecode in edomain.get_codes ()) {
			if (ecode.value == null) {
				cenum.add_value (new CCodeEnumValue (get_ccode_name (ecode)));
			} else {
				ecode.value.emit (this);
				cenum.add_value (new CCodeEnumValue (get_ccode_name (ecode), get_cvalue (ecode.value)));
			}
		}

		decl_space.add_type_definition (cenum);

		string quark_fun_name = get_ccode_lower_case_prefix (edomain) + "quark";

		var error_domain_define = new CCodeMacroReplacement (get_ccode_upper_case_name (edomain), quark_fun_name + " ()");
		decl_space.add_type_definition (error_domain_define);

		var cquark_fun = new CCodeFunction (quark_fun_name, get_ccode_name (gquark_type.type_symbol));
		cquark_fun.modifiers |= CCodeModifiers.EXTERN;
		requires_vala_extern = true;

		decl_space.add_function_declaration (cquark_fun);
		decl_space.add_type_definition (new CCodeNewline ());

		if (!get_ccode_has_type_id (edomain)) {
			return;
		}

		decl_space.add_include ("glib-object.h");
		decl_space.add_type_declaration (new CCodeNewline ());

		var fun_name = get_ccode_type_function (edomain);

		var macro = "(%s ())".printf (fun_name);
		decl_space.add_type_declaration (new CCodeMacroReplacement (get_ccode_type_id (edomain), macro));

		var regfun = new CCodeFunction (fun_name, "GType");
		regfun.modifiers = CCodeModifiers.CONST;

		if (edomain.is_private_symbol ()) {
			// avoid C warning as this function is not always used
			regfun.modifiers |= CCodeModifiers.STATIC | CCodeModifiers.UNUSED;
		} else if (context.hide_internal && edomain.is_internal_symbol ()) {
			regfun.modifiers |= CCodeModifiers.INTERNAL;
		} else {
			regfun.modifiers |= CCodeModifiers.EXTERN;
			requires_vala_extern = true;
		}

		decl_space.add_function_declaration (regfun);
	}

	public override void visit_error_domain (ErrorDomain edomain) {
		if (edomain.comment != null) {
			cfile.add_type_definition (new CCodeComment (edomain.comment.content));
		}

		generate_error_domain_declaration (edomain, cfile);

		if (!edomain.is_internal_symbol ()) {
			generate_error_domain_declaration (edomain, header_file);
		}
		if (!edomain.is_private_symbol ()) {
			generate_error_domain_declaration (edomain, internal_header_file);
		}

		edomain.accept_children (this);

		string quark_fun_name = get_ccode_lower_case_prefix (edomain) + "quark";

		var cquark_fun = new CCodeFunction (quark_fun_name, get_ccode_name (gquark_type.type_symbol));
		push_function (cquark_fun);

		var cquark_call = new CCodeFunctionCall (new CCodeIdentifier ("g_quark_from_static_string"));
		cquark_call.add_argument (new CCodeConstant ("\"" + get_ccode_quark_name (edomain) + "\""));

		ccode.add_return (cquark_call);

		pop_function ();
		cfile.add_function (cquark_fun);
	}

	public override void visit_throw_statement (ThrowStatement stmt) {
		// method will fail
		current_method_inner_error = true;
		ccode.add_assignment (get_inner_error_cexpression (), get_cvalue (stmt.error_expression));

		add_simple_check (stmt, true);
	}

	public virtual void return_with_exception (CCodeExpression error_expr) {
		var cpropagate = new CCodeFunctionCall (new CCodeIdentifier ("g_propagate_error"));
		cpropagate.add_argument (new CCodeIdentifier ("error"));
		cpropagate.add_argument (error_expr);

		ccode.add_expression (cpropagate);

		// free local variables
		append_local_free (current_symbol);

		// free possibly already assigned out-parameter
		append_out_param_free (current_method);

		if (current_method is CreationMethod && current_method.parent_symbol is Class) {
			var cl = (Class) current_method.parent_symbol;
			ccode.add_expression (destroy_value (new GLibValue (new ObjectType (cl), new CCodeIdentifier ("self"), true)));
			ccode.add_return (new CCodeConstant ("NULL"));
		} else if (is_in_coroutine ()) {
			ccode.add_return (new CCodeConstant ("FALSE"));
		} else {
			return_default_value (current_return_type, true);
		}
	}

	void uncaught_error_statement (CCodeExpression inner_error, bool unexpected = false, CodeNode? start_at = null) {
		// free local variables
		if (start_at is TryStatement) {
			append_local_free (start_at.parent_node as Block);
		} else {
			append_local_free (current_symbol);
		}

		// free possibly already assigned out-parameter
		append_out_param_free (current_method);

		cfile.add_include ("glib.h");

		var ccritical = new CCodeFunctionCall (new CCodeIdentifier ("g_critical"));
		ccritical.add_argument (new CCodeConstant (unexpected ? "\"file %s: line %d: unexpected error: %s (%s, %d)\"" : "\"file %s: line %d: uncaught error: %s (%s, %d)\""));
		ccritical.add_argument (new CCodeConstant ("__FILE__"));
		ccritical.add_argument (new CCodeConstant ("__LINE__"));
		ccritical.add_argument (new CCodeMemberAccess.pointer (inner_error, "message"));
		var domain_name = new CCodeFunctionCall (new CCodeIdentifier ("g_quark_to_string"));
		domain_name.add_argument (new CCodeMemberAccess.pointer (inner_error, "domain"));
		ccritical.add_argument (domain_name);
		ccritical.add_argument (new CCodeMemberAccess.pointer (inner_error, "code"));

		var cclear = new CCodeFunctionCall (new CCodeIdentifier ("g_clear_error"));
		cclear.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, inner_error));

		// print critical message
		ccode.add_expression (ccritical);
		ccode.add_expression (cclear);

		if (is_in_coroutine ()) {
			var unref = new CCodeFunctionCall (new CCodeIdentifier ("g_object_unref"));
			unref.add_argument (get_variable_cexpression ("_async_result"));
			ccode.add_expression (unref);
			ccode.add_return (new CCodeConstant ("FALSE"));
		} else if (is_in_constructor () || is_in_destructor ()) {
			// just print critical, do not return prematurely
		} else if (current_method is CreationMethod) {
			if (current_method.parent_symbol is Struct) {
				ccode.add_return ();
			} else {
				ccode.add_return (new CCodeConstant ("NULL"));
			}
		} else if (current_return_type != null) {
			return_default_value (current_return_type, true);
		}
	}

	bool in_finally_block (CodeNode node) {
		var current_node = node;
		while (current_node != null) {
			var try_stmt = current_node.parent_node as TryStatement;
			if (try_stmt != null && try_stmt.finally_body == current_node) {
				return true;
			}
			current_node = current_node.parent_node;
		}
		return false;
	}

	public override void add_simple_check (CodeNode node, bool always_fails = false) {
		current_method_inner_error = true;

		if (always_fails) {
			// inner_error is always set, avoid unnecessary if statement
			// eliminates C warnings
		} else {
			var ccond = new CCodeBinaryExpression (CCodeBinaryOperator.INEQUALITY, get_inner_error_cexpression (), new CCodeConstant ("NULL"));
			var unlikely = new CCodeFunctionCall (new CCodeIdentifier ("G_UNLIKELY"));
			unlikely.add_argument (ccond);
			ccode.open_if (unlikely);
		}

		if (current_try != null) {
			// surrounding try found

			// free local variables
			if (is_in_catch) {
				append_local_free (current_symbol, null, current_catch);
			} else {
				append_local_free (current_symbol, null, current_try);
			}

			var error_types = new ArrayList<DataType> ();
			node.get_error_types (error_types);

			bool has_general_catch_clause = false;

			if (!is_in_catch) {
				var handled_error_types = new ArrayList<DataType> ();
				foreach (CatchClause clause in current_try.get_catch_clauses ()) {
					// keep track of unhandled error types
					foreach (DataType node_error_type in error_types) {
						if (clause.error_type == null || node_error_type.compatible (clause.error_type)) {
							handled_error_types.add (node_error_type);
						}
					}
					foreach (DataType handled_error_type in handled_error_types) {
						error_types.remove (handled_error_type);
					}
					handled_error_types.clear ();

					if (clause.error_type.equals (gerror_type)) {
						// general catch clause, this should be the last one
						has_general_catch_clause = true;
						ccode.add_goto (clause.get_attribute_string ("CCode", "cname"));
						break;
					} else {
						unowned ErrorType catch_type = (ErrorType) clause.error_type;

						if (catch_type.error_code != null) {
							/* catch clause specifies a specific error code */
							var error_match = new CCodeFunctionCall (new CCodeIdentifier ("g_error_matches"));
							error_match.add_argument (get_inner_error_cexpression ());
							error_match.add_argument (new CCodeIdentifier (get_ccode_upper_case_name (catch_type.error_domain)));
							error_match.add_argument (new CCodeIdentifier (get_ccode_name (catch_type.error_code)));

							ccode.open_if (error_match);
						} else {
							/* catch clause specifies a full error domain */
							var ccond = new CCodeBinaryExpression (CCodeBinaryOperator.EQUALITY,
									new CCodeMemberAccess.pointer (get_inner_error_cexpression (), "domain"), new CCodeIdentifier
									(get_ccode_upper_case_name (catch_type.error_domain)));

							ccode.open_if (ccond);
						}

						// go to catch clause if error domain matches
						ccode.add_goto (clause.get_attribute_string ("CCode", "cname"));
						ccode.close ();
					}
				}
			}

			if (has_general_catch_clause) {
				// every possible error is already caught
				// as there is a general catch clause
				// no need to do anything else
			} else if (error_types.size > 0) {
				// go to finally clause if no catch clause matches
				// and there are still unhandled error types
				ccode.add_goto ("__finally%d".printf (current_try_id));
			} else if (in_finally_block (node)) {
				// do not check unexpected errors happening within finally blocks
				// as jump out of finally block is not supported
			} else {
				// should never happen with correct bindings
				uncaught_error_statement (get_inner_error_cexpression (), true, current_try);
			}
		} else if (current_method != null && current_method.tree_can_fail) {
			// current method can fail, propagate error
			CCodeBinaryExpression ccond = null;

			var error_types = new ArrayList<DataType> ();
			current_method.get_error_types (error_types);
			foreach (DataType error_type in error_types) {
				// If GLib.Error is allowed we propagate everything
				if (error_type.equals (gerror_type)) {
					ccond = null;
					break;
				}

				// Check the allowed error domains to propagate
				var domain_check = new CCodeBinaryExpression (CCodeBinaryOperator.EQUALITY, new CCodeMemberAccess.pointer
					(get_inner_error_cexpression (), "domain"), new CCodeIdentifier (get_ccode_upper_case_name (((ErrorType) error_type).error_domain)));
				if (ccond == null) {
					ccond = domain_check;
				} else {
					ccond = new CCodeBinaryExpression (CCodeBinaryOperator.OR, ccond, domain_check);
				}
			}

			if (ccond != null) {
				ccode.open_if (ccond);
				return_with_exception (get_inner_error_cexpression ());

				ccode.add_else ();
				uncaught_error_statement (get_inner_error_cexpression ());
				ccode.close ();
			} else {
				return_with_exception (get_inner_error_cexpression ());
			}
		} else {
			uncaught_error_statement (get_inner_error_cexpression ());
		}

		if (!always_fails) {
			ccode.close ();
		}
	}

	public override void visit_try_statement (TryStatement stmt) {
		int this_try_id = next_try_id++;

		var old_try = current_try;
		var old_try_id = current_try_id;
		var old_is_in_catch = is_in_catch;
		var old_catch = current_catch;
		current_try = stmt;
		current_try_id = this_try_id;
		is_in_catch = true;

		foreach (CatchClause clause in stmt.get_catch_clauses ()) {
			clause.set_attribute_string ("CCode", "cname", "__catch%d_%s".printf (this_try_id, get_ccode_lower_case_name (clause.error_type)));
		}

		is_in_catch = false;
		stmt.body.emit (this);
		is_in_catch = true;

		foreach (CatchClause clause in stmt.get_catch_clauses ()) {
			current_catch = clause;
			ccode.add_goto ("__finally%d".printf (this_try_id));
			clause.emit (this);
		}

		current_try = old_try;
		current_try_id = old_try_id;
		is_in_catch = old_is_in_catch;
		current_catch = old_catch;

		ccode.add_label ("__finally%d".printf (this_try_id));
		if (stmt.finally_body != null) {
			// use a dedicated inner_error variable, if there
			// is some error handling happening in finally-block
			current_inner_error_id++;
			stmt.finally_body.emit (this);
			current_inner_error_id--;
		}

		// check for errors not handled by this try statement
		// may be handled by outer try statements or propagated
		add_simple_check (stmt, !stmt.after_try_block_reachable);
	}

	public override void visit_catch_clause (CatchClause clause) {
		current_method_inner_error = true;

		var error_type = (ErrorType) clause.error_type;
		if (error_type.error_domain != null) {
			generate_error_domain_declaration (error_type.error_domain, cfile);
		}

		ccode.add_label (clause.get_attribute_string ("CCode", "cname"));

		ccode.open_block ();

		if (clause.error_variable != null && clause.error_variable.used) {
			visit_local_variable (clause.error_variable);
			ccode.add_assignment (get_variable_cexpression (get_local_cname (clause.error_variable)), get_inner_error_cexpression ());
			ccode.add_assignment (get_inner_error_cexpression (), new CCodeConstant ("NULL"));
		} else {
			if (clause.error_variable != null) {
				clause.error_variable.unreachable = true;
			}
			// error object is not used within catch statement, clear it
			cfile.add_include ("glib.h");
			var cclear = new CCodeFunctionCall (new CCodeIdentifier ("g_clear_error"));
			cclear.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, get_inner_error_cexpression ()));
			ccode.add_expression (cclear);
		}

		clause.body.emit (this);

		ccode.close ();
	}

	protected override void append_scope_free (Symbol sym, CodeNode? stop_at = null) {
		base.append_scope_free (sym, stop_at);

		if (!(stop_at is TryStatement || stop_at is CatchClause)) {
			var finally_block = (Block) null;
			if (sym.parent_node is TryStatement) {
				finally_block = ((TryStatement) sym.parent_node).finally_body;
			} else if (sym.parent_node is CatchClause) {
				finally_block = ((TryStatement) sym.parent_node.parent_node).finally_body;
			}

			if (finally_block != null && finally_block != sym) {
				finally_block.emit (this);
			}
		}
	}
}

// vim:sw=8 noet
