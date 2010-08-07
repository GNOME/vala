/* valadovacontrolflowmodule.vala
 *
 * Copyright (C) 2006-2010  Jürg Billeter
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

public class Vala.DovaControlFlowModule : DovaMethodModule {
	public override void visit_if_statement (IfStatement stmt) {
		stmt.true_statement.emit (this);
		if (stmt.false_statement != null) {
			stmt.false_statement.emit (this);
		}

		if (stmt.false_statement != null) {
			stmt.ccodenode = new CCodeIfStatement ((CCodeExpression) stmt.condition.ccodenode, (CCodeStatement) stmt.true_statement.ccodenode, (CCodeStatement) stmt.false_statement.ccodenode);
		} else {
			stmt.ccodenode = new CCodeIfStatement ((CCodeExpression) stmt.condition.ccodenode, (CCodeStatement) stmt.true_statement.ccodenode);
		}

		create_temp_decl (stmt, stmt.condition.temp_vars);
	}

	public override void visit_switch_statement (SwitchStatement stmt) {
		foreach (SwitchSection section in stmt.get_sections ()) {
			section.emit (this);
		}

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

	public override void visit_switch_label (SwitchLabel label) {
		if (label.expression != null) {
			label.expression.emit (this);

			visit_end_full_expression (label.expression);
		}
	}

	public override void visit_loop (Loop stmt) {
		stmt.body.emit (this);

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

