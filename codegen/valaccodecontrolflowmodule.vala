/* valaccodecontrolflowmodule.vala
 *
 * Copyright (C) 2006-2009  Jürg Billeter
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

public class Vala.CCodeControlFlowModule : CCodeMethodModule {
	public override void visit_if_statement (IfStatement stmt) {
		ccode.open_if ((CCodeExpression) stmt.condition.ccodenode);

		stmt.true_statement.emit (this);

		if (stmt.false_statement != null) {
			ccode.add_else ();
			stmt.false_statement.emit (this);
		}

		ccode.close ();
	}

	void visit_string_switch_statement (SwitchStatement stmt) {
		// we need a temporary variable to save the property value
		var temp_var = get_temp_variable (stmt.expression.value_type, stmt.expression.value_type.value_owned, stmt, false);
		emit_temp_var (temp_var);

		var ctemp = get_variable_cexpression (temp_var.name);
		var cinit = new CCodeAssignment (ctemp, (CCodeExpression) stmt.expression.ccodenode);
		var czero = new CCodeConstant ("0");

		var free_call = new CCodeFunctionCall (new CCodeIdentifier ("g_free"));
		free_call.add_argument (ctemp);

		var cisnull = new CCodeBinaryExpression (CCodeBinaryOperator.EQUALITY, new CCodeConstant ("NULL"), ctemp);
		var cquark = new CCodeFunctionCall (new CCodeIdentifier ("g_quark_from_string"));
		cquark.add_argument (ctemp);

		var ccond = new CCodeConditionalExpression (cisnull, new CCodeConstant ("0"), cquark);

		temp_var = get_temp_variable (gquark_type);
		emit_temp_var (temp_var);

		int label_count = 0;

		foreach (SwitchSection section in stmt.get_sections ()) {
			if (section.has_default_label ()) {
				continue;
			}

			foreach (SwitchLabel label in section.get_labels ()) {
				label.expression.emit (this);
				var cexpr = (CCodeExpression) label.expression.ccodenode;

				if (is_constant_ccode_expression (cexpr)) {
					var cname = "%s_label%d".printf (temp_var.name, label_count++);

					ccode.add_declaration (gquark_type.get_cname (), new CCodeVariableDeclarator (cname, czero), CCodeModifiers.STATIC);
				}
			}
		}

		ccode.add_expression (cinit);

		ctemp = get_variable_cexpression (temp_var.name);
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
				var cexpr = (CCodeExpression) label.expression.ccodenode;

				if (is_constant_ccode_expression (cexpr)) {
					var cname = new CCodeIdentifier ("%s_label%d".printf (temp_var.name, label_count++));
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

		ccode.close ();
	}

	public override void visit_switch_statement (SwitchStatement stmt) {
		if (stmt.expression.value_type.compatible (string_type)) {
			visit_string_switch_statement (stmt);
			return;
		}

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
		if (((SwitchStatement) label.section.parent_node).expression.value_type.compatible (string_type)) {
			return;
		}

		if (label.expression != null) {
			label.expression.emit (this);

			visit_end_full_expression (label.expression);

			ccode.add_case ((CCodeExpression) label.expression.ccodenode);
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
		var collection_type = collection_backup.variable_type.copy ();

		var array_type = collection_type as ArrayType;
		if (array_type != null) {
			// avoid assignment issues
			array_type.fixed_length = false;
		}

		if (current_method != null && current_method.coroutine) {
			closure_struct.add_field (collection_type.get_cname (), collection_backup.name);
		} else {
			var ccolvardecl = new CCodeVariableDeclarator (collection_backup.name);
			ccode.add_declaration (collection_type.get_cname (), ccolvardecl);
		}
		ccode.add_expression (new CCodeAssignment (get_variable_cexpression (collection_backup.name), (CCodeExpression) stmt.collection.ccodenode));
		
		if (stmt.tree_can_fail && stmt.collection.tree_can_fail) {
			// exception handling
			add_simple_check (stmt.collection);
		}

		if (stmt.collection.value_type is ArrayType) {
			array_type = (ArrayType) stmt.collection.value_type;
			
			var array_len = get_array_length_cexpression (stmt.collection);

			// store array length for use by _vala_array_free
			if (current_method != null && current_method.coroutine) {
				closure_struct.add_field ("int", get_array_length_cname (collection_backup.name, 1));
			} else {
				ccode.add_declaration ("int", new CCodeVariableDeclarator (get_array_length_cname (collection_backup.name, 1)));
			}
			ccode.add_expression (new CCodeAssignment (get_variable_cexpression (get_array_length_cname (collection_backup.name, 1)), array_len));

			var it_name = (stmt.variable_name + "_it");
		
			if (current_method != null && current_method.coroutine) {
				closure_struct.add_field ("int", it_name);
			} else {
				ccode.add_declaration ("int", new CCodeVariableDeclarator (it_name));
			}

			var ccond = new CCodeBinaryExpression (CCodeBinaryOperator.LESS_THAN, get_variable_cexpression (it_name), array_len);

			ccode.open_for (new CCodeAssignment (get_variable_cexpression (it_name), new CCodeConstant ("0")),
			                   ccond,
			                   new CCodeAssignment (get_variable_cexpression (it_name), new CCodeBinaryExpression (CCodeBinaryOperator.PLUS, get_variable_cexpression (it_name), new CCodeConstant ("1"))));

			CCodeExpression element_expr = new CCodeElementAccess (get_variable_cexpression (collection_backup.name), get_variable_cexpression (it_name));

			var element_type = array_type.element_type.copy ();
			element_type.value_owned = false;
			element_expr = transform_expression (element_expr, element_type, stmt.type_reference);

			if (current_method != null && current_method.coroutine) {
				closure_struct.add_field (stmt.type_reference.get_cname (), stmt.variable_name);
			} else {
				ccode.add_declaration (stmt.type_reference.get_cname (), new CCodeVariableDeclarator (stmt.variable_name));
			}
			ccode.add_expression (new CCodeAssignment (get_variable_cexpression (stmt.variable_name), element_expr));

			// add array length variable for stacked arrays
			if (stmt.type_reference is ArrayType) {
				var inner_array_type = (ArrayType) stmt.type_reference;
				for (int dim = 1; dim <= inner_array_type.rank; dim++) {
					if (current_method != null && current_method.coroutine) {
						closure_struct.add_field ("int", get_array_length_cname (stmt.variable_name, dim));
						ccode.add_expression (new CCodeAssignment (get_variable_cexpression (get_array_length_cname (stmt.variable_name, dim)), new CCodeConstant ("-1")));
					} else {
						ccode.add_declaration ("int", new CCodeVariableDeclarator (get_array_length_cname (stmt.variable_name, dim), new CCodeConstant ("-1")));
					}
				}
			}

			stmt.body.emit (this);

			ccode.close ();
		} else if (stmt.collection.value_type.compatible (new ObjectType (glist_type)) || stmt.collection.value_type.compatible (new ObjectType (gslist_type))) {
			// iterating over a GList or GSList

			var it_name = "%s_it".printf (stmt.variable_name);
		
			if (current_method != null && current_method.coroutine) {
				closure_struct.add_field (collection_type.get_cname (), it_name);
			} else {
				ccode.add_declaration (collection_type.get_cname (), new CCodeVariableDeclarator (it_name));
			}
			
			var ccond = new CCodeBinaryExpression (CCodeBinaryOperator.INEQUALITY, get_variable_cexpression (it_name), new CCodeConstant ("NULL"));

			ccode.open_for (new CCodeAssignment (get_variable_cexpression (it_name), get_variable_cexpression (collection_backup.name)),
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
			element_expr = transform_expression (element_expr, element_data_type, stmt.type_reference);

			if (current_method != null && current_method.coroutine) {
				closure_struct.add_field (stmt.type_reference.get_cname (), stmt.variable_name);
			} else {
				ccode.add_declaration (stmt.type_reference.get_cname (), new CCodeVariableDeclarator (stmt.variable_name));
			}
			ccode.add_expression (new CCodeAssignment (get_variable_cexpression (stmt.variable_name), element_expr));

			stmt.body.emit (this);

			ccode.close ();
		} else if (stmt.collection.value_type.compatible (new ObjectType (gvaluearray_type))) {
			// iterating over a GValueArray

			var arr_index = "%s_index".printf (stmt.variable_name);

			if (current_method != null && current_method.coroutine) {
				closure_struct.add_field (uint_type.get_cname (), arr_index);
			} else {
				ccode.add_declaration (uint_type.get_cname (), new CCodeVariableDeclarator (arr_index));
			}

			var ccond = new CCodeBinaryExpression (CCodeBinaryOperator.LESS_THAN, get_variable_cexpression (arr_index), new CCodeMemberAccess.pointer (get_variable_cexpression (collection_backup.name), "n_values"));

			ccode.open_for (new CCodeAssignment (get_variable_cexpression (arr_index), new CCodeConstant ("0")),
			                   ccond,
			                   new CCodeAssignment (get_variable_cexpression (arr_index), new CCodeBinaryExpression (CCodeBinaryOperator.PLUS, get_variable_cexpression (arr_index), new CCodeConstant ("1"))));

			var get_item = new CCodeFunctionCall (new CCodeIdentifier ("g_value_array_get_nth"));
			get_item.add_argument (get_variable_cexpression (collection_backup.name));
			get_item.add_argument (get_variable_cexpression (arr_index));

			CCodeExpression element_expr = new CCodeUnaryExpression (CCodeUnaryOperator.POINTER_INDIRECTION, get_item);

			if (stmt.type_reference.value_owned) {
				element_expr = get_ref_cexpression (stmt.type_reference, element_expr, null, new StructValueType (gvalue_type));
			}

			if (current_method != null && current_method.coroutine) {
				closure_struct.add_field (stmt.type_reference.get_cname (), stmt.variable_name);
			} else {
				ccode.add_declaration (stmt.type_reference.get_cname (), new CCodeVariableDeclarator (stmt.variable_name));
			}
			ccode.add_expression (new CCodeAssignment (get_variable_cexpression (stmt.variable_name), element_expr));

			stmt.body.emit (this);

			ccode.close ();
		}

		foreach (LocalVariable local in stmt.get_local_variables ()) {
			if (requires_destroy (local.variable_type)) {
				var ma = new MemberAccess.simple (local.name);
				ma.symbol_reference = local;
				ccode.add_expression (get_unref_expression (get_variable_cexpression (local.name), local.variable_type, ma));
			}
		}

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

