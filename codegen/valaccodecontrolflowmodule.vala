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

	public override void visit_foreach_statement (ForeachStatement stmt) {
		ccode.open_block ();

		var collection_backup = stmt.collection_variable;
		var collection_type = collection_backup.variable_type;

		var array_type = collection_type as ArrayType;
		if (array_type != null) {
			// avoid assignment issues
			array_type.inline_allocated = false;
			array_type.fixed_length = false;
		}

		visit_local_variable (collection_backup);
		ccode.add_assignment (get_variable_cexpression (get_local_cname (collection_backup)), get_cvalue (stmt.collection));

		if (stmt.tree_can_fail && stmt.collection.tree_can_fail) {
			// exception handling
			add_simple_check (stmt.collection);
		}

		if (stmt.collection.value_type is ArrayType) {
			array_type = (ArrayType) stmt.collection.value_type;

			var array_len = get_variable_cexpression (get_array_length_cname (get_local_cname (collection_backup), 1));

			// store array length for use by _vala_array_free
			ccode.add_assignment (array_len, get_array_length_cexpression (stmt.collection));

			var iterator_variable = new LocalVariable (array_type.length_type.copy (), stmt.variable_name + "_it");
			visit_local_variable (iterator_variable);
			var it_name = get_local_cname (iterator_variable);

			var ccond = new CCodeBinaryExpression (CCodeBinaryOperator.LESS_THAN, get_variable_cexpression (it_name), array_len);

			ccode.open_for (new CCodeAssignment (get_variable_cexpression (it_name), new CCodeConstant ("0")),
			                   ccond,
			                   new CCodeAssignment (get_variable_cexpression (it_name), new CCodeBinaryExpression (CCodeBinaryOperator.PLUS, get_variable_cexpression (it_name), new CCodeConstant ("1"))));

			CCodeExpression element_expr = new CCodeElementAccess (get_variable_cexpression (get_local_cname (collection_backup)), get_variable_cexpression (it_name));

			var element_type = array_type.element_type.copy ();
			element_type.value_owned = false;
			element_expr = get_cvalue_ (transform_value (new GLibValue (element_type, element_expr, true), stmt.type_reference, stmt));

			visit_local_variable (stmt.element_variable);
			ccode.add_assignment (get_variable_cexpression (get_local_cname (stmt.element_variable)), element_expr);

			// set array length for stacked arrays
			if (stmt.type_reference is ArrayType) {
				var inner_array_type = (ArrayType) stmt.type_reference;
				for (int dim = 1; dim <= inner_array_type.rank; dim++) {
					ccode.add_assignment (get_variable_cexpression (get_array_length_cname (get_local_cname (stmt.element_variable), dim)), new CCodeConstant ("-1"));
				}
			}

			stmt.body.emit (this);

			ccode.close ();
		} else if (stmt.collection.value_type.compatible (new ObjectType (glist_type)) || stmt.collection.value_type.compatible (new ObjectType (gslist_type))) {
			// iterating over a GList or GSList

			var iterator_variable = new LocalVariable (collection_type.copy (), stmt.variable_name + "_it");
			visit_local_variable (iterator_variable);
			var it_name = get_local_cname (iterator_variable);

			var ccond = new CCodeBinaryExpression (CCodeBinaryOperator.INEQUALITY, get_variable_cexpression (it_name), new CCodeConstant ("NULL"));

			ccode.open_for (new CCodeAssignment (get_variable_cexpression (it_name), get_variable_cexpression (get_local_cname (collection_backup))),
							ccond,
							new CCodeAssignment (get_variable_cexpression (it_name), new CCodeMemberAccess.pointer (get_variable_cexpression (it_name), "next")));

			CCodeExpression element_expr = new CCodeMemberAccess.pointer (get_variable_cexpression (it_name), "data");

			if (collection_type.get_type_arguments ().size != 1) {
				Report.error (stmt.source_reference, "internal error: missing generic type argument");
				stmt.error = true;
				return;
			}

			var element_data_type = collection_type.get_type_arguments ().get (0).copy ();
			element_data_type.value_owned = false;
			element_expr = convert_from_generic_pointer (element_expr, element_data_type);
			element_expr = get_cvalue_ (transform_value (new GLibValue (element_data_type, element_expr), stmt.type_reference, stmt));

			visit_local_variable (stmt.element_variable);
			ccode.add_assignment (get_variable_cexpression (get_local_cname (stmt.element_variable)), element_expr);

			stmt.body.emit (this);

			ccode.close ();
		} else if (stmt.collection.value_type.compatible (new ObjectType (gvaluearray_type))) {
			// iterating over a GValueArray

			var iterator_variable = new LocalVariable (uint_type.copy (), "%s_index".printf (stmt.variable_name));
			visit_local_variable (iterator_variable);
			var arr_index = get_variable_cname (get_local_cname (iterator_variable));

			var ccond = new CCodeBinaryExpression (CCodeBinaryOperator.LESS_THAN, get_variable_cexpression (arr_index), new CCodeMemberAccess.pointer (get_variable_cexpression (get_local_cname (collection_backup)), "n_values"));

			ccode.open_for (new CCodeAssignment (get_variable_cexpression (arr_index), new CCodeConstant ("0")),
			                   ccond,
			                   new CCodeAssignment (get_variable_cexpression (arr_index), new CCodeBinaryExpression (CCodeBinaryOperator.PLUS, get_variable_cexpression (arr_index), new CCodeConstant ("1"))));

			var get_item = new CCodeFunctionCall (new CCodeIdentifier ("g_value_array_get_nth"));
			get_item.add_argument (get_variable_cexpression (get_local_cname (collection_backup)));
			get_item.add_argument (get_variable_cexpression (arr_index));

			CCodeExpression element_expr = new CCodeUnaryExpression (CCodeUnaryOperator.POINTER_INDIRECTION, get_item);

			if (stmt.type_reference.value_owned) {
				element_expr = get_cvalue_ (copy_value (new GLibValue (stmt.type_reference, element_expr), new StructValueType (gvalue_type)));
			}

			visit_local_variable (stmt.element_variable);
			ccode.add_assignment (get_variable_cexpression (get_local_cname (stmt.element_variable)), element_expr);

			stmt.body.emit (this);

			ccode.close ();
		} else {
			Report.error (stmt.source_reference, "internal error: unsupported collection type");
			stmt.error = true;
			return;
		}

		foreach (LocalVariable local in stmt.get_local_variables ()) {
			if (requires_destroy (local.variable_type)) {
				ccode.add_expression (destroy_local (local));
			}
		}

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

