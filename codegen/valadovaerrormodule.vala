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

public class Vala.DovaErrorModule : DovaDelegateModule {
	private int current_try_id = 0;
	private int next_try_id = 0;
	private bool is_in_catch = false;

	public override void visit_throw_statement (ThrowStatement stmt) {
		ccode.add_expression (new CCodeAssignment (new CCodeIdentifier ("dova_error"), (CCodeExpression) stmt.error_expression.ccodenode));

		add_simple_check (stmt, true);
	}

	public void return_with_exception () {
		// propagate error
		// nothing to do

		// free local variables
		append_local_free (current_symbol, false);

		if (current_method is CreationMethod && current_method.parent_symbol is Class) {
			var cl = current_method.parent_symbol as Class;
			var unref_call = new CCodeFunctionCall (new CCodeIdentifier (cl.get_unref_function ()));
			unref_call.add_argument (new CCodeIdentifier ("this"));
			ccode.add_expression (unref_call);
			ccode.add_return ();
		} else if (current_return_type is VoidType) {
			ccode.add_return ();
		} else {
			ccode.add_return (default_value_for_type (current_return_type, false));
		}
	}

	void uncaught_error_statement () {
		// free local variables
		append_local_free (current_symbol, false);

		// TODO log uncaught error as critical warning

		if (current_method is CreationMethod) {
			ccode.add_return ();
		} else if (current_return_type is VoidType) {
			ccode.add_return ();
		} else if (current_return_type != null) {
			ccode.add_return (default_value_for_type (current_return_type, false));
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
		if (always_fails) {
			// inner_error is always set, avoid unnecessary if statement
			// eliminates C warnings
		} else {
			var ccond = new CCodeBinaryExpression (CCodeBinaryOperator.INEQUALITY, new CCodeIdentifier ("dova_error"), new CCodeConstant ("NULL"));
			ccode.open_if (ccond);
		}

		if (current_try != null) {
			// surrounding try found

			// free local variables
			append_error_free (current_symbol, current_try);

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

					if (clause.error_type.equals (new ObjectType (error_class))) {
						// general catch clause, this should be the last one
						has_general_catch_clause = true;
						ccode.add_goto (clause.clabel_name);
						break;
					} else {
						var catch_type = clause.error_type as ObjectType;

						var type_check = new CCodeFunctionCall (new CCodeIdentifier ("any_is_a"));
						type_check.add_argument (new CCodeIdentifier ("dova_error"));
						type_check.add_argument (new CCodeFunctionCall (new CCodeIdentifier ("%s_type_get".printf (catch_type.type_symbol.get_lower_case_cname ()))));

						ccode.open_if (type_check);

						// go to catch clause if error domain matches
						ccode.add_goto (clause.clabel_name);
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
				assert_not_reached ();
			}
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
				var type_check = new CCodeFunctionCall (new CCodeIdentifier ("any_is_a"));
				type_check.add_argument (new CCodeIdentifier ("dova_error"));
				type_check.add_argument (new CCodeFunctionCall (new CCodeIdentifier ("%s_type_get".printf (error_class.get_lower_case_cname ()))));
				if (ccond == null) {
					ccond = type_check;
				} else {
					ccond = new CCodeBinaryExpression (CCodeBinaryOperator.OR, ccond, type_check);
				}
			}

			if (ccond == null) {
				return_with_exception ();
			} else {
				ccode.open_if (ccond);
				return_with_exception ();
				ccode.add_else ();
				uncaught_error_statement ();
				ccode.close ();
			}
		} else {
			uncaught_error_statement ();
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
		current_try = stmt;
		current_try_id = this_try_id;
		is_in_catch = true;

		foreach (CatchClause clause in stmt.get_catch_clauses ()) {
			clause.clabel_name = "__catch%d_%s".printf (this_try_id, clause.error_type.get_lower_case_cname ());
		}

		is_in_catch = false;
		stmt.body.emit (this);
		is_in_catch = true;

		foreach (CatchClause clause in stmt.get_catch_clauses ()) {
			ccode.add_goto ("__finally%d".printf (this_try_id));
			clause.emit (this);
		}

		current_try = old_try;
		current_try_id = old_try_id;
		is_in_catch = old_is_in_catch;

		ccode.add_label ("__finally%d".printf (this_try_id));
		if (stmt.finally_body != null) {
			stmt.finally_body.emit (this);
		}

		// check for errors not handled by this try statement
		// may be handled by outer try statements or propagated
		add_simple_check (stmt, !stmt.after_try_block_reachable);
	}

	public override void visit_catch_clause (CatchClause clause) {
		generate_type_declaration (clause.error_type, cfile);

		ccode.add_label (clause.clabel_name);

		ccode.open_block ();

		string variable_name;
		if (clause.variable_name != null) {
			variable_name = get_variable_cname (clause.variable_name);
		} else {
			variable_name = "__err";
		}

		if (clause.variable_name != null) {
			var cdecl = new CCodeDeclaration (clause.error_type.get_cname ());
			cdecl.add_declarator (new CCodeVariableDeclarator (variable_name, new CCodeIdentifier ("dova_error")));
			ccode.add_statement (cdecl);
		} else {
			// error object is not used within catch statement, clear it
			var cclear = new CCodeFunctionCall (new CCodeIdentifier ("dova_object_unref"));
			cclear.add_argument (new CCodeIdentifier ("dova_error"));
			ccode.add_statement (new CCodeExpressionStatement (cclear));
		}
		ccode.add_statement (new CCodeExpressionStatement (new CCodeAssignment (new CCodeIdentifier ("dova_error"), new CCodeConstant ("NULL"))));

		clause.body.emit (this);

		ccode.close ();
	}

	public override void append_local_free (Symbol sym, bool stop_at_loop = false) {
		var finally_block = (Block) null;
		if (sym.parent_node is TryStatement) {
			finally_block = (sym.parent_node as TryStatement).finally_body;
		} else if (sym.parent_node is CatchClause) {
			finally_block = (sym.parent_node.parent_node as TryStatement).finally_body;
		}

		if (finally_block != null) {
			finally_block.emit (this);
		}

		base.append_local_free (sym, stop_at_loop);
	}
}

// vim:sw=8 noet
