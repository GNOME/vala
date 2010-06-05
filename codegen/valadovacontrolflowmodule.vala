/* valadovacontrolflowmodule.vala
 *
 * Copyright (C) 2006-2009  Jürg Billeter
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

internal class Vala.DovaControlFlowModule : DovaMethodModule {
	public DovaControlFlowModule (CCodeGenerator codegen, CCodeModule? next) {
		base (codegen, next);
	}

	public override void visit_if_statement (IfStatement stmt) {
		stmt.accept_children (codegen);

		if (stmt.false_statement != null) {
			stmt.ccodenode = new CCodeIfStatement ((CCodeExpression) stmt.condition.ccodenode, (CCodeStatement) stmt.true_statement.ccodenode, (CCodeStatement) stmt.false_statement.ccodenode);
		} else {
			stmt.ccodenode = new CCodeIfStatement ((CCodeExpression) stmt.condition.ccodenode, (CCodeStatement) stmt.true_statement.ccodenode);
		}

		create_temp_decl (stmt, stmt.condition.temp_vars);
	}

	public override void visit_switch_statement (SwitchStatement stmt) {
		stmt.accept_children (codegen);

		var cswitch = new CCodeSwitchStatement ((CCodeExpression) stmt.expression.ccodenode);
		stmt.ccodenode = cswitch;

		foreach (SwitchSection section in stmt.get_sections ()) {
			if (section.has_default_label ()) {
				cswitch.add_statement (new CCodeLabel ("default"));
				var cdefaultblock = new CCodeBlock ();
				cswitch.add_statement (cdefaultblock);
				foreach (CodeNode default_stmt in section.get_statements ()) {
					cdefaultblock.add_statement (default_stmt.ccodenode);
				}
				continue;
			}

			foreach (SwitchLabel label in section.get_labels ()) {
				cswitch.add_statement (new CCodeCaseStatement ((CCodeExpression) label.expression.ccodenode));
			}

			var cblock = new CCodeBlock ();
			cswitch.add_statement (cblock);
			foreach (CodeNode body_stmt in section.get_statements ()) {
				cblock.add_statement (body_stmt.ccodenode);
			}
		}

		create_temp_decl (stmt, stmt.expression.temp_vars);
	}

	public override void visit_switch_section (SwitchSection section) {
		visit_block (section);
	}

	public override void visit_switch_label (SwitchLabel label) {
		label.accept_children (codegen);
	}

	public override void visit_loop (Loop stmt) {
		stmt.accept_children (codegen);

		source_declarations.add_include ("stdbool.h");
		stmt.ccodenode = new CCodeWhileStatement (new CCodeConstant ("true"), (CCodeStatement) stmt.body.ccodenode);
	}

	public override void visit_break_statement (BreakStatement stmt) {
		stmt.ccodenode = new CCodeBreakStatement ();

		create_local_free (stmt, true);
	}

	public override void visit_continue_statement (ContinueStatement stmt) {
		stmt.ccodenode = new CCodeContinueStatement ();

		create_local_free (stmt, true);
	}
}

