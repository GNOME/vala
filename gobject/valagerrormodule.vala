/* valagerrormodule.vala
 *
 * Copyright (C) 2008  Jürg Billeter
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
 * 	Jürg Billeter <j@bitron.ch>
 */

using GLib;
using Gee;

public class Vala.GErrorModule : CCodeDynamicSignalModule {
	public GErrorModule (CCodeGenerator codegen, CCodeModule? next) {
		base (codegen, next);
	}

	public override void visit_throw_statement (ThrowStatement stmt) {
		stmt.accept_children (codegen);

		var cfrag = new CCodeFragment ();

		// method will fail
		codegen.current_method_inner_error = true;
		var cassign = new CCodeAssignment (new CCodeIdentifier ("inner_error"), (CCodeExpression) stmt.error_expression.ccodenode);
		cfrag.append (new CCodeExpressionStatement (cassign));

		head.add_simple_check (stmt, cfrag);

		stmt.ccodenode = cfrag;

		codegen.create_temp_decl (stmt, stmt.error_expression.temp_vars);
	}

	public override void add_simple_check (CodeNode node, CCodeFragment cfrag) {
		codegen.current_method_inner_error = true;

		var cprint_frag = new CCodeFragment ();
		var ccritical = new CCodeFunctionCall (new CCodeIdentifier ("g_critical"));
		ccritical.add_argument (new CCodeConstant ("\"file %s: line %d: uncaught error: %s\""));
		ccritical.add_argument (new CCodeConstant ("__FILE__"));
		ccritical.add_argument (new CCodeConstant ("__LINE__"));
		ccritical.add_argument (new CCodeMemberAccess.pointer (new CCodeIdentifier ("inner_error"), "message"));
		cprint_frag.append (new CCodeExpressionStatement (ccritical));
		var cclear = new CCodeFunctionCall (new CCodeIdentifier ("g_clear_error"));
		cclear.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, new CCodeIdentifier ("inner_error")));
		cprint_frag.append (new CCodeExpressionStatement (cclear));

		if (codegen.current_try != null) {
			// surrounding try found
			// TODO might be the wrong one when using nested try statements

			var cerror_block = new CCodeBlock ();
			foreach (CatchClause clause in codegen.current_try.get_catch_clauses ()) {
				// go to catch clause if error domain matches
				var cgoto_stmt = new CCodeGotoStatement (clause.clabel_name);

				if (clause.error_type.equals (codegen.gerror_type)) {
					// general catch clause
					cerror_block.add_statement (cgoto_stmt);
				} else {
					var ccond = new CCodeBinaryExpression (CCodeBinaryOperator.EQUALITY, new CCodeMemberAccess.pointer (new CCodeIdentifier ("inner_error"), "domain"), new CCodeIdentifier (clause.error_type.data_type.get_upper_case_cname ()));

					var cgoto_block = new CCodeBlock ();
					cgoto_block.add_statement (cgoto_stmt);

					cerror_block.add_statement (new CCodeIfStatement (ccond, cgoto_block));
				}
			}
			// print critical message if no catch clause matches
			cerror_block.add_statement (cprint_frag);

			// check error domain if expression failed
			var ccond = new CCodeBinaryExpression (CCodeBinaryOperator.INEQUALITY, new CCodeIdentifier ("inner_error"), new CCodeConstant ("NULL"));

			cfrag.append (new CCodeIfStatement (ccond, cerror_block));
		} else if (codegen.current_method != null && codegen.current_method.get_error_types ().size > 0) {
			// current method can fail, propagate error
			// TODO ensure one of the error domains matches

			var cpropagate = new CCodeFunctionCall (new CCodeIdentifier ("g_propagate_error"));
			cpropagate.add_argument (new CCodeIdentifier ("error"));
			cpropagate.add_argument (new CCodeIdentifier ("inner_error"));

			var cerror_block = new CCodeBlock ();
			cerror_block.add_statement (new CCodeExpressionStatement (cpropagate));

			// free local variables
			var free_frag = new CCodeFragment ();
			codegen.append_local_free (codegen.current_symbol, free_frag, false);
			cerror_block.add_statement (free_frag);

			if (codegen.current_return_type is VoidType) {
				cerror_block.add_statement (new CCodeReturnStatement ());
			} else {
				cerror_block.add_statement (new CCodeReturnStatement (codegen.default_value_for_type (codegen.current_return_type, false)));
			}

			var ccond = new CCodeBinaryExpression (CCodeBinaryOperator.INEQUALITY, new CCodeIdentifier ("inner_error"), new CCodeConstant ("NULL"));

			cfrag.append (new CCodeIfStatement (ccond, cerror_block));
		} else {
			// unhandled error

			var cerror_block = new CCodeBlock ();
			// print critical message
			cerror_block.add_statement (cprint_frag);

			// check error domain if expression failed
			var ccond = new CCodeBinaryExpression (CCodeBinaryOperator.INEQUALITY, new CCodeIdentifier ("inner_error"), new CCodeConstant ("NULL"));

			cfrag.append (new CCodeIfStatement (ccond, cerror_block));
		}
	}
}
