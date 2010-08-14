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
		ccode.open_if ((CCodeExpression) stmt.condition.ccodenode);

		stmt.true_statement.emit (this);

		if (stmt.false_statement != null) {
			ccode.add_else ();
			stmt.false_statement.emit (this);
		}

		ccode.close ();
	}

	public override void visit_switch_statement (SwitchStatement stmt) {
		ccode.open_switch ((CCodeExpression) stmt.expression.ccodenode);

		foreach (SwitchSection section in stmt.get_sections ()) {
			if (section.has_default_label ()) {
				ccode.add_default ();
			}
			section.emit (this);
		}

		ccode.close ();
	}

	public override void visit_switch_label (SwitchLabel label) {
		if (label.expression != null) {
			label.expression.emit (this);

			visit_end_full_expression (label.expression);

			ccode.add_case ((CCodeExpression) label.expression.ccodenode);
		}
	}

	public override void visit_loop (Loop stmt) {
		ccode.open_while (new CCodeConstant ("true"));

		stmt.body.emit (this);

		ccode.close ();
	}

	public override void visit_break_statement (BreakStatement stmt) {
		append_local_free (current_symbol, true);

		ccode.add_break ();
	}

	public override void visit_continue_statement (ContinueStatement stmt) {
		append_local_free (current_symbol, true);

		ccode.add_continue ();
	}
}

