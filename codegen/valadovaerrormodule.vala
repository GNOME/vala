/* valadovaerrormodule.vala
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

internal class Vala.DovaErrorModule : DovaDelegateModule {
	private int current_try_id = 0;
	private int next_try_id = 0;
	private bool is_in_catch = false;

	public DovaErrorModule (CCodeGenerator codegen, CCodeModule? next) {
		base (codegen, next);
	}

	public override void visit_throw_statement (ThrowStatement stmt) {
		stmt.accept_children (codegen);

		var cfrag = new CCodeFragment ();

		// method will fail
		current_method_inner_error = true;
		var cassign = new CCodeAssignment (get_variable_cexpression ("_inner_error_"), (CCodeExpression) stmt.error_expression.ccodenode);
		cfrag.append (new CCodeExpressionStatement (cassign));

		head.add_simple_check (stmt, cfrag, true);

		stmt.ccodenode = cfrag;

		create_temp_decl (stmt, stmt.error_expression.temp_vars);
	}

	public virtual CCodeStatement return_with_exception () {
		// propagate error
		var cerror_block = new CCodeBlock ();
		cerror_block.add_statement (new CCodeExpressionStatement (new CCodeAssignment (new CCodeUnaryExpression (CCodeUnaryOperator.POINTER_INDIRECTION, new CCodeIdentifier ("error")), get_variable_cexpression ("_inner_error_"))));
		cerror_block.add_statement (new CCodeExpressionStatement (new CCodeAssignment (get_variable_cexpression ("_inner_error_"), new CCodeConstant ("NULL"))));

		// free local variables
		var free_frag = new CCodeFragment ();
		append_local_free (current_symbol, free_frag, false);
		cerror_block.add_statement (free_frag);

		if (current_method is CreationMethod) {
			var cl = current_method.parent_symbol as Class;
			var unref_call = new CCodeFunctionCall (new CCodeIdentifier (cl.get_unref_function ()));
			unref_call.add_argument (new CCodeIdentifier ("self"));
			cerror_block.add_statement (new CCodeExpressionStatement (unref_call));
			cerror_block.add_statement (new CCodeReturnStatement (new CCodeConstant ("NULL")));
		} else if (current_return_type is VoidType) {
			cerror_block.add_statement (new CCodeReturnStatement ());
		} else {
			cerror_block.add_statement (new CCodeReturnStatement (default_value_for_type (current_return_type, false)));
		}

		return cerror_block;
	}

	CCodeStatement uncaught_error_statement (CCodeExpression inner_error, CCodeBlock? block = null, bool unexpected = false) {
		var cerror_block = block;
		if (cerror_block == null) {
			cerror_block = new CCodeBlock ();
		}

		// free local variables
		var free_frag = new CCodeFragment ();
		append_local_free (current_symbol, free_frag, false);
		cerror_block.add_statement (free_frag);

		// TODO log uncaught error as critical warning

		if (current_method is CreationMethod) {
			cerror_block.add_statement (new CCodeReturnStatement (new CCodeConstant ("NULL")));
		} else if (current_return_type is VoidType) {
			cerror_block.add_statement (new CCodeReturnStatement ());
		} else if (current_return_type != null) {
			cerror_block.add_statement (new CCodeReturnStatement (default_value_for_type (current_return_type, false)));
		}

		return cerror_block;
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

	public override void add_simple_check (CodeNode node, CCodeFragment cfrag, bool always_fails = false) {
		current_method_inner_error = true;

		var inner_error = get_variable_cexpression ("_inner_error_");

		CCodeStatement cerror_handler = null;

		if (current_try != null) {
			// surrounding try found
			var cerror_block = new CCodeBlock ();

			// free local variables
			var free_frag = new CCodeFragment ();
			append_error_free (current_symbol, free_frag, current_try);
			cerror_block.add_statement (free_frag);

			var error_types = new ArrayList<DataType> ();
			foreach (DataType node_error_type in node.get_error_types ()) {
				error_types.add (node_error_type);
			}

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

					// go to catch clause if error domain matches
					var cgoto_stmt = new CCodeGotoStatement (clause.clabel_name);

					if (clause.error_type.equals (new ObjectType (error_class))) {
						// general catch clause, this should be the last one
						has_general_catch_clause = true;
						cerror_block.add_statement (cgoto_stmt);
						break;
					} else {
						var catch_type = clause.error_type as ObjectType;
						var cgoto_block = new CCodeBlock ();
						cgoto_block.add_statement (cgoto_stmt);

						var type_check = new CCodeFunctionCall (new CCodeIdentifier ("dova_object_is_a"));
						type_check.add_argument (inner_error);
						type_check.add_argument (new CCodeFunctionCall (new CCodeIdentifier ("%s_type_get".printf (catch_type.type_symbol.get_lower_case_cname ()))));

						cerror_block.add_statement (new CCodeIfStatement (type_check, cgoto_block));
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
				cerror_block.add_statement (new CCodeGotoStatement ("__finally%d".printf (current_try_id)));
			} else if (in_finally_block (node)) {
				// do not check unexpected errors happening within finally blocks
				// as jump out of finally block is not supported
			} else {
				// should never happen with correct bindings
				uncaught_error_statement (inner_error, cerror_block, true);
			}

			cerror_handler = cerror_block;
		} else if (current_method != null && current_method.get_error_types ().size > 0) {
			// current method can fail, propagate error
			CCodeExpression ccond = null;

			foreach (DataType error_type in current_method.get_error_types ()) {
				// If Dova.Error is allowed we propagate everything
				if (error_type.equals (new ObjectType (error_class))) {
					ccond = null;
					break;
				}

				// Check the allowed error domains to propagate
				var type_check = new CCodeFunctionCall (new CCodeIdentifier ("dova_object_is_a"));
				type_check.add_argument (inner_error);
				type_check.add_argument (new CCodeFunctionCall (new CCodeIdentifier ("%s_type_get".printf (error_class.get_lower_case_cname ()))));
				if (ccond == null) {
					ccond = type_check;
				} else {
					ccond = new CCodeBinaryExpression (CCodeBinaryOperator.OR, ccond, type_check);
				}
			}

			if (ccond == null) {
				cerror_handler = return_with_exception ();
			} else {
				var cerror_block = new CCodeBlock ();
				cerror_block.add_statement (new CCodeIfStatement (ccond,
					return_with_exception (),
					uncaught_error_statement (inner_error)));
				cerror_handler = cerror_block;
			}
		} else {
			cerror_handler = uncaught_error_statement (inner_error);
		}

		if (always_fails) {
			// inner_error is always set, avoid unnecessary if statement
			// eliminates C warnings
			cfrag.append (cerror_handler);
		} else {
			var ccond = new CCodeBinaryExpression (CCodeBinaryOperator.INEQUALITY, inner_error, new CCodeConstant ("NULL"));
			cfrag.append (new CCodeIfStatement (ccond, cerror_handler));
		}
	}

	public override void visit_try_statement (TryStatement stmt) {
		int this_try_id = next_try_id++;

		var old_try = current_try;
		var old_try_id = current_try_id;
		var old_is_in_catch = is_in_catch;
		current_try = stmt;
		current_try_id = this_try_id;
		is_in_catch = true;

		foreach (CatchClause clause in stmt.get_catch_clauses ()) {
			clause.clabel_name = "__catch%d_%s".printf (this_try_id, clause.error_type.get_lower_case_cname ());
		}

		if (stmt.finally_body != null) {
			stmt.finally_body.accept (codegen);
		}

		is_in_catch = false;
		stmt.body.accept (codegen);
		is_in_catch = true;

		foreach (CatchClause clause in stmt.get_catch_clauses ()) {
			clause.accept (codegen);
		}

		current_try = old_try;
		current_try_id = old_try_id;
		is_in_catch = old_is_in_catch;

		var cfrag = new CCodeFragment ();
		cfrag.append (stmt.body.ccodenode);

		foreach (CatchClause clause in stmt.get_catch_clauses ()) {
			cfrag.append (new CCodeGotoStatement ("__finally%d".printf (this_try_id)));
			cfrag.append (clause.ccodenode);
		}

		cfrag.append (new CCodeLabel ("__finally%d".printf (this_try_id)));
		if (stmt.finally_body != null) {
			cfrag.append (stmt.finally_body.ccodenode);
		}

		// check for errors not handled by this try statement
		// may be handled by outer try statements or propagated
		add_simple_check (stmt, cfrag, !stmt.after_try_block_reachable);

		stmt.ccodenode = cfrag;
	}

	public override void visit_catch_clause (CatchClause clause) {
		if (clause.error_variable != null) {
			clause.error_variable.active = true;
		}

		current_method_inner_error = true;

		generate_type_declaration (clause.error_type, source_declarations);

		clause.accept_children (codegen);

		var cfrag = new CCodeFragment ();
		cfrag.append (new CCodeLabel (clause.clabel_name));

		var cblock = new CCodeBlock ();

		string variable_name;
		if (clause.variable_name != null) {
			variable_name = get_variable_cname (clause.variable_name);
		} else {
			variable_name = "__err";
		}

		if (clause.variable_name != null) {
			var cdecl = new CCodeDeclaration (clause.error_type.get_cname ());
			cdecl.add_declarator (new CCodeVariableDeclarator (variable_name, get_variable_cexpression ("_inner_error_")));
			cblock.add_statement (cdecl);
		} else {
			// error object is not used within catch statement, clear it
			var cclear = new CCodeFunctionCall (new CCodeIdentifier ("dova_object_unref"));
			cclear.add_argument (get_variable_cexpression ("_inner_error_"));
			cblock.add_statement (new CCodeExpressionStatement (cclear));
		}
		cblock.add_statement (new CCodeExpressionStatement (new CCodeAssignment (get_variable_cexpression ("_inner_error_"), new CCodeConstant ("NULL"))));

		cblock.add_statement (clause.body.ccodenode);

		cfrag.append (cblock);

		clause.ccodenode = cfrag;
	}

	public override void append_local_free (Symbol sym, CCodeFragment cfrag, bool stop_at_loop = false) {
		var finally_block = (Block) null;
		if (sym.parent_node is TryStatement) {
			finally_block = (sym.parent_node as TryStatement).finally_body;
		} else if (sym.parent_node is CatchClause) {
			finally_block = (sym.parent_node.parent_node as TryStatement).finally_body;
		}

		if (finally_block != null) {
			cfrag.append (finally_block.ccodenode);
		}

		base.append_local_free (sym, cfrag, stop_at_loop);
	}
}

// vim:sw=8 noet
