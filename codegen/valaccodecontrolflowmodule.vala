/* valaccodecontrolflowmodule.vala
 *
 * Copyright (C) 2006-2011  Jürg Billeter
 * Copyright (C) 2006-2008  Raffaele Sandrini
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
 *	Raffaele Sandrini <raffaele@sandrini.ch>
 */

using GLib;

public abstract class Vala.CCodeControlFlowModule : CCodeMethodModule {
	public override void visit_if_statement (IfStatement stmt) {
		ccode.open_if (get_cvalue (stmt.condition));

		stmt.true_statement.emit (this);

		if (stmt.false_statement != null) {
			ccode.add_else ();
			stmt.false_statement.emit (this);
		}

		ccode.close ();
	}

	void visit_string_switch_statement (SwitchStatement stmt) {
		// we need a temporary variable to save the property value
		var temp_value = create_temp_value (stmt.expression.value_type, false, stmt);
		var ctemp = get_cvalue_ (temp_value);

		var cinit = new CCodeAssignment (ctemp, get_cvalue (stmt.expression));
		var czero = new CCodeConstant ("0");

		var free_call = new CCodeFunctionCall (new CCodeIdentifier ("g_free"));
		free_call.add_argument (ctemp);

		var cisnull = new CCodeBinaryExpression (CCodeBinaryOperator.EQUALITY, new CCodeConstant ("NULL"), ctemp);
		var cquark = new CCodeFunctionCall (new CCodeIdentifier ("g_quark_from_string"));
		cquark.add_argument (ctemp);

		var ccond = new CCodeConditionalExpression (cisnull, new CCodeConstant ("0"), cquark);

		int label_temp_id = next_temp_var_id++;

		temp_value = create_temp_value (gquark_type, true, stmt);

		int label_count = 0;

		foreach (SwitchSection section in stmt.get_sections ()) {
			if (section.has_default_label ()) {
				continue;
			}

			foreach (SwitchLabel label in section.get_labels ()) {
				label.expression.emit (this);
				var cexpr = get_cvalue (label.expression);

				if (is_constant_ccode_expression (cexpr)) {
					var cname = "_tmp%d_label%d".printf (label_temp_id, label_count++);

					ccode.add_declaration (get_ccode_name (gquark_type), new CCodeVariableDeclarator (cname, czero), CCodeModifiers.STATIC);
				}
			}
		}

		ccode.add_expression (cinit);

		ctemp = get_cvalue_ (temp_value);
		cinit = new CCodeAssignment (ctemp, ccond);

		ccode.add_expression (cinit);

		if (stmt.expression.value_type.value_owned) {
			// free owned string
			ccode.add_expression (free_call);
		}

		SwitchSection default_section = null;
		label_count = 0;

		int n = 0;

		foreach (SwitchSection section in stmt.get_sections ()) {
			if (section.has_default_label ()) {
				default_section = section;
				continue;
			}

			CCodeBinaryExpression cor = null;
			foreach (SwitchLabel label in section.get_labels ()) {
				label.expression.emit (this);
				var cexpr = get_cvalue (label.expression);

				if (is_constant_ccode_expression (cexpr)) {
					var cname = new CCodeIdentifier ("_tmp%d_label%d".printf (label_temp_id, label_count++));
					var ccondition = new CCodeBinaryExpression (CCodeBinaryOperator.INEQUALITY, czero, cname);
					var ccall = new CCodeFunctionCall (new CCodeIdentifier ("g_quark_from_static_string"));
					cinit = new CCodeAssignment (cname, ccall);

					ccall.add_argument (cexpr);

					cexpr = new CCodeConditionalExpression (ccondition, cname, cinit);
				} else {
					var ccall = new CCodeFunctionCall (new CCodeIdentifier ("g_quark_from_string"));
					ccall.add_argument (cexpr);
					cexpr = ccall;
				}

				var ccmp = new CCodeBinaryExpression (CCodeBinaryOperator.EQUALITY, ctemp, cexpr);

				if (cor == null) {
					cor = ccmp;
				} else {
					cor = new CCodeBinaryExpression (CCodeBinaryOperator.OR, cor, ccmp);
				}
			}

			if (n > 0) {
				ccode.else_if (cor);
			} else {
				ccode.open_if (cor);
			}

			ccode.open_switch (new CCodeConstant ("0"));
			ccode.add_default ();

			section.emit (this);

			ccode.close ();

			n++;
		}

		if (default_section != null) {
			if (n > 0) {
				ccode.add_else ();
			}

			ccode.open_switch (new CCodeConstant ("0"));
			ccode.add_default ();

			default_section.emit (this);

			ccode.close ();
		}

		if (n > 0) {
			ccode.close ();
		}
	}

	public override void visit_switch_statement (SwitchStatement stmt) {
		if (stmt.expression.value_type.compatible (string_type)) {
			visit_string_switch_statement (stmt);
			return;
		}

		ccode.open_switch (get_cvalue (stmt.expression));

		bool has_default = false;

		foreach (SwitchSection section in stmt.get_sections ()) {
			if (section.has_default_label ()) {
				ccode.add_default ();
				has_default = true;
			}
			section.emit (this);
		}

		if (!has_default) {
			// silence C compiler
			ccode.add_default ();
			ccode.add_break ();
		}

		ccode.close ();
	}

	public override void visit_switch_label (SwitchLabel label) {
		if (((SwitchStatement) label.section.parent_node).expression.value_type.compatible (string_type)) {
			return;
		}

		if (label.expression != null) {
			label.expression.emit (this);

			visit_end_full_expression (label.expression);

			ccode.add_case (get_cvalue (label.expression));
		}
	}

	public override void visit_loop (Loop stmt) {
		if (context.profile == Profile.GOBJECT) {
			ccode.open_while (new CCodeConstant ("TRUE"));
		} else {
			cfile.add_include ("stdbool.h");
			ccode.open_while (new CCodeConstant ("true"));
		}

		stmt.body.emit (this);

		ccode.close ();
	}

	public override void visit_break_statement (BreakStatement stmt) {
		append_local_free (current_symbol, stmt);

		ccode.add_break ();
	}

	public override void visit_continue_statement (ContinueStatement stmt) {
		append_local_free (current_symbol, stmt);

		ccode.add_continue ();
	}
}

