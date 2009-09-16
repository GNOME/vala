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
using Gee;

internal class Vala.CCodeControlFlowModule : CCodeMethodModule {
	public CCodeControlFlowModule (CCodeGenerator codegen, CCodeModule? next) {
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

	void visit_string_switch_statement (SwitchStatement stmt) {
		// we need a temporary variable to save the property value
		var temp_var = get_temp_variable (stmt.expression.value_type, stmt.expression.value_type.value_owned, stmt);
		stmt.expression.temp_vars.insert (0, temp_var);

		var ctemp = get_variable_cexpression (temp_var.name);
		var cinit = new CCodeAssignment (ctemp, (CCodeExpression) stmt.expression.ccodenode);
		var czero = new CCodeConstant ("0");

		var free_call = new CCodeFunctionCall (new CCodeIdentifier ("g_free"));
		free_call.add_argument (ctemp);

		var cswitchblock = new CCodeFragment ();
		stmt.ccodenode = cswitchblock;

		var cisnull = new CCodeBinaryExpression (CCodeBinaryOperator.EQUALITY, new CCodeConstant ("NULL"), ctemp);
		var cquark = new CCodeFunctionCall (new CCodeIdentifier ("g_quark_from_string"));
		cquark.add_argument (ctemp);

		var ccond = new CCodeConditionalExpression (cisnull, new CCodeConstant ("0"), cquark);

		temp_var = get_temp_variable (gquark_type);
		stmt.expression.temp_vars.insert (0, temp_var);

		int label_count = 0;

		foreach (SwitchSection section in stmt.get_sections ()) {
			if (section.has_default_label ()) {
				continue;
			}

			foreach (SwitchLabel label in section.get_labels ()) {
				var cexpr = (CCodeExpression) label.expression.ccodenode;

				if (is_constant_ccode_expression (cexpr)) {
					var cname = "%s_label%d".printf (temp_var.name, label_count++);
					var cdecl = new CCodeDeclaration (gquark_type.get_cname ());

					cdecl.modifiers = CCodeModifiers.STATIC;
					cdecl.add_declarator (new CCodeVariableDeclarator (cname, czero));

					cswitchblock.append (cdecl);
				}
			}
		}

		cswitchblock.append (new CCodeExpressionStatement (cinit));

		ctemp = get_variable_cexpression (temp_var.name);
		cinit = new CCodeAssignment (ctemp, ccond);

		cswitchblock.append (new CCodeExpressionStatement (cinit));
		create_temp_decl (stmt, stmt.expression.temp_vars);

		if (stmt.expression.value_type.value_owned) {
			// free owned string
			cswitchblock.append (new CCodeExpressionStatement (free_call));
		}

		Gee.List<Statement> default_statements = null;
		label_count = 0;

		// generate nested if statements		
		CCodeStatement ctopstmt = null;
		CCodeIfStatement coldif = null;

		foreach (SwitchSection section in stmt.get_sections ()) {
			if (section.has_default_label ()) {
				default_statements = section.get_statements ();
				continue;
			}

			CCodeBinaryExpression cor = null;
			foreach (SwitchLabel label in section.get_labels ()) {
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

			var cblock = new CCodeBlock ();
			foreach (CodeNode body_stmt in section.get_statements ()) {
				if (body_stmt.ccodenode is CCodeFragment) {
					foreach (CCodeNode cstmt in ((CCodeFragment) body_stmt.ccodenode).get_children ()) {
						cblock.add_statement (cstmt);
					}
				} else {
					cblock.add_statement (body_stmt.ccodenode);
				}
			}

			var cdo = new CCodeDoStatement (cblock, new CCodeConstant ("0"));
			var cif = new CCodeIfStatement (cor, cdo);

			if (coldif != null) {
				coldif.false_statement = cif;
			} else {
				ctopstmt = cif;
			}

			coldif = cif;
		}
	
		if (default_statements != null) {
			var cblock = new CCodeBlock ();
			foreach (CodeNode body_stmt in default_statements) {
				cblock.add_statement (body_stmt.ccodenode);
			}
		
			var cdo = new CCodeDoStatement (cblock, new CCodeConstant ("0"));

			if (coldif == null) {
				// there is only one section and that section
				// contains a default label
				ctopstmt = cdo;
			} else {
				coldif.false_statement = cdo;
			}
		}
	
		cswitchblock.append (ctopstmt);
	}

	public override void visit_switch_statement (SwitchStatement stmt) {
		stmt.accept_children (codegen);

		if (stmt.expression.value_type.compatible (string_type)) {
			visit_string_switch_statement (stmt);
			return;
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

	public override void visit_switch_section (SwitchSection section) {
		visit_block (section);
	}

	public override void visit_switch_label (SwitchLabel label) {
		label.accept_children (codegen);
	}

	public override void visit_loop (Loop stmt) {
		stmt.accept_children (codegen);

		if (context.profile == Profile.GOBJECT) {
			stmt.ccodenode = new CCodeWhileStatement (new CCodeConstant ("TRUE"), (CCodeStatement) stmt.body.ccodenode);
		} else {
			source_declarations.add_include ("stdbool.h");
			stmt.ccodenode = new CCodeWhileStatement (new CCodeConstant ("true"), (CCodeStatement) stmt.body.ccodenode);
		}
	}

	public override void visit_foreach_statement (ForeachStatement stmt) {
		stmt.element_variable.active = true;
		stmt.collection_variable.active = true;
		if (stmt.iterator_variable != null) {
			stmt.iterator_variable.active = true;
		}

		visit_block (stmt);

		var cblock = new CCodeBlock ();
		// sets #line
		stmt.ccodenode = cblock;

		var cfrag = new CCodeFragment ();
		append_temp_decl (cfrag, stmt.collection.temp_vars);
		cblock.add_statement (cfrag);
		
		var collection_backup = stmt.collection_variable;
		var collection_type = collection_backup.variable_type.copy ();

		var array_type = collection_type as ArrayType;
		if (array_type != null) {
			// avoid assignment issues
			array_type.fixed_length = false;
		}

		if (current_method != null && current_method.coroutine) {
			closure_struct.add_field (collection_type.get_cname (), collection_backup.name);
			cblock.add_statement (new CCodeExpressionStatement (new CCodeAssignment (get_variable_cexpression (collection_backup.name), (CCodeExpression) stmt.collection.ccodenode)));
		} else {
			var ccoldecl = new CCodeDeclaration (collection_type.get_cname ());
			var ccolvardecl = new CCodeVariableDeclarator (collection_backup.name, (CCodeExpression) stmt.collection.ccodenode);
			ccolvardecl.line = cblock.line;
			ccoldecl.add_declarator (ccolvardecl);
			cblock.add_statement (ccoldecl);
		}
		
		if (stmt.tree_can_fail && stmt.collection.tree_can_fail) {
			// exception handling
			cfrag = new CCodeFragment ();
			head.add_simple_check (stmt.collection, cfrag);
			cblock.add_statement (cfrag);
		}

		if (stmt.collection.value_type is ArrayType) {
			array_type = (ArrayType) stmt.collection.value_type;
			
			var array_len = head.get_array_length_cexpression (stmt.collection);

			// store array length for use by _vala_array_free
			if (current_method != null && current_method.coroutine) {
				closure_struct.add_field ("int", head.get_array_length_cname (collection_backup.name, 1));
				cblock.add_statement (new CCodeExpressionStatement (new CCodeAssignment (get_variable_cexpression (head.get_array_length_cname (collection_backup.name, 1)), array_len)));
			} else {
				var clendecl = new CCodeDeclaration ("int");
				clendecl.add_declarator (new CCodeVariableDeclarator (head.get_array_length_cname (collection_backup.name, 1), array_len));
				cblock.add_statement (clendecl);
			}

			var it_name = (stmt.variable_name + "_it");
		
			if (current_method != null && current_method.coroutine) {
				closure_struct.add_field ("int", it_name);
			} else {
				var citdecl = new CCodeDeclaration ("int");
				citdecl.add_declarator (new CCodeVariableDeclarator (it_name));
				cblock.add_statement (citdecl);
			}
			
			var cbody = new CCodeBlock ();

			CCodeExpression element_expr = new CCodeElementAccess (get_variable_cexpression (collection_backup.name), get_variable_cexpression (it_name));

			var element_type = array_type.element_type.copy ();
			element_type.value_owned = false;
			element_expr = transform_expression (element_expr, element_type, stmt.type_reference);

			cfrag = new CCodeFragment ();
			append_temp_decl (cfrag, temp_vars);
			cbody.add_statement (cfrag);
			temp_vars.clear ();

			if (current_method != null && current_method.coroutine) {
				closure_struct.add_field (stmt.type_reference.get_cname (), stmt.variable_name);
				cbody.add_statement (new CCodeExpressionStatement (new CCodeAssignment (get_variable_cexpression (stmt.variable_name), element_expr)));
			} else {
				var cdecl = new CCodeDeclaration (stmt.type_reference.get_cname ());
				cdecl.add_declarator (new CCodeVariableDeclarator (stmt.variable_name, element_expr));
				cbody.add_statement (cdecl);
			}

			// add array length variable for stacked arrays
			if (stmt.type_reference is ArrayType) {
				var inner_array_type = (ArrayType) stmt.type_reference;
				for (int dim = 1; dim <= inner_array_type.rank; dim++) {
					if (current_method != null && current_method.coroutine) {
						closure_struct.add_field ("int", head.get_array_length_cname (stmt.variable_name, dim));
						cbody.add_statement (new CCodeExpressionStatement (new CCodeAssignment (get_variable_cexpression (head.get_array_length_cname (stmt.variable_name, dim)), new CCodeConstant ("-1"))));
					} else {
						var cdecl = new CCodeDeclaration ("int");
						cdecl.add_declarator (new CCodeVariableDeclarator (head.get_array_length_cname (stmt.variable_name, dim), new CCodeConstant ("-1")));
						cbody.add_statement (cdecl);
					}
				}
			}

			cbody.add_statement (stmt.body.ccodenode);
			
			var ccond = new CCodeBinaryExpression (CCodeBinaryOperator.LESS_THAN, get_variable_cexpression (it_name), array_len);

			var cfor = new CCodeForStatement (ccond, cbody);
			cfor.add_initializer (new CCodeAssignment (get_variable_cexpression (it_name), new CCodeConstant ("0")));
			cfor.add_iterator (new CCodeAssignment (get_variable_cexpression (it_name), new CCodeBinaryExpression (CCodeBinaryOperator.PLUS, get_variable_cexpression (it_name), new CCodeConstant ("1"))));
			cblock.add_statement (cfor);
		} else if (stmt.collection.value_type.compatible (new ObjectType (glist_type)) || stmt.collection.value_type.compatible (new ObjectType (gslist_type))) {
			// iterating over a GList or GSList

			var it_name = "%s_it".printf (stmt.variable_name);
		
			if (current_method != null && current_method.coroutine) {
				closure_struct.add_field (collection_type.get_cname (), it_name);
			} else {
				var citdecl = new CCodeDeclaration (collection_type.get_cname ());
				var citvardecl = new CCodeVariableDeclarator (it_name);
				citvardecl.line = cblock.line;
				citdecl.add_declarator (citvardecl);
				cblock.add_statement (citdecl);
			}
			
			var cbody = new CCodeBlock ();

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

			cfrag = new CCodeFragment ();
			append_temp_decl (cfrag, temp_vars);
			cbody.add_statement (cfrag);
			temp_vars.clear ();

			if (current_method != null && current_method.coroutine) {
				closure_struct.add_field (stmt.type_reference.get_cname (), stmt.variable_name);
				cbody.add_statement (new CCodeExpressionStatement (new CCodeAssignment (get_variable_cexpression (stmt.variable_name), element_expr)));
			} else {
				var cdecl = new CCodeDeclaration (stmt.type_reference.get_cname ());
				var cvardecl = new CCodeVariableDeclarator (stmt.variable_name, element_expr);
				cvardecl.line = cblock.line;
				cdecl.add_declarator (cvardecl);
				cbody.add_statement (cdecl);
			}
			
			cbody.add_statement (stmt.body.ccodenode);
			
			var ccond = new CCodeBinaryExpression (CCodeBinaryOperator.INEQUALITY, get_variable_cexpression (it_name), new CCodeConstant ("NULL"));
			
			var cfor = new CCodeForStatement (ccond, cbody);
			
			cfor.add_initializer (new CCodeAssignment (get_variable_cexpression (it_name), get_variable_cexpression (collection_backup.name)));

			cfor.add_iterator (new CCodeAssignment (get_variable_cexpression (it_name), new CCodeMemberAccess.pointer (get_variable_cexpression (it_name), "next")));
			cblock.add_statement (cfor);
		} else if (stmt.collection.value_type.compatible (new ObjectType (gvaluearray_type))) {
			// iterating over a GValueArray

			var arr_index = "%s_index".printf (stmt.variable_name);

			if (current_method != null && current_method.coroutine) {
				closure_struct.add_field (uint_type.get_cname (), arr_index);
			} else {
				var citdecl = new CCodeDeclaration (uint_type.get_cname ());
				var citvardecl = new CCodeVariableDeclarator (arr_index);
				citvardecl.line = cblock.line;
				citdecl.add_declarator (citvardecl);
				cblock.add_statement (citdecl);
			}

			var cbody = new CCodeBlock ();

			var get_item = new CCodeFunctionCall (new CCodeIdentifier ("g_value_array_get_nth"));
			get_item.add_argument (get_variable_cexpression (collection_backup.name));
			get_item.add_argument (get_variable_cexpression (arr_index));

			CCodeExpression element_expr = new CCodeUnaryExpression (CCodeUnaryOperator.POINTER_INDIRECTION, get_item);

			if (stmt.type_reference.value_owned) {
				element_expr = get_ref_cexpression (stmt.type_reference, element_expr, null, new StructValueType (gvalue_type));
			}

			cfrag = new CCodeFragment ();
			append_temp_decl (cfrag, temp_vars);
			cbody.add_statement (cfrag);
			temp_vars.clear ();

			if (current_method != null && current_method.coroutine) {
				closure_struct.add_field (stmt.type_reference.get_cname (), stmt.variable_name);
				cbody.add_statement (new CCodeExpressionStatement (new CCodeAssignment (get_variable_cexpression (stmt.variable_name), element_expr)));
			} else {
				var cdecl = new CCodeDeclaration (stmt.type_reference.get_cname ());
				var cvardecl = new CCodeVariableDeclarator (stmt.variable_name, element_expr);
				cvardecl.line = cblock.line;
				cdecl.add_declarator (cvardecl);
				cbody.add_statement (cdecl);
			}

			cbody.add_statement (stmt.body.ccodenode);

			var ccond = new CCodeBinaryExpression (CCodeBinaryOperator.LESS_THAN, get_variable_cexpression (arr_index), new CCodeMemberAccess.pointer (get_variable_cexpression (collection_backup.name), "n_values"));

			var cfor = new CCodeForStatement (ccond, cbody);

			cfor.add_initializer (new CCodeAssignment (get_variable_cexpression (arr_index), new CCodeConstant ("0")));

			cfor.add_iterator (new CCodeAssignment (get_variable_cexpression (arr_index), new CCodeBinaryExpression (CCodeBinaryOperator.PLUS, get_variable_cexpression (arr_index), new CCodeConstant ("1"))));

			cblock.add_statement (cfor);
		}

		foreach (LocalVariable local in stmt.get_local_variables ()) {
			if (requires_destroy (local.variable_type)) {
				var ma = new MemberAccess.simple (local.name);
				ma.symbol_reference = local;
				var cunref = new CCodeExpressionStatement (get_unref_expression (get_variable_cexpression (local.name), local.variable_type, ma));
				cunref.line = cblock.line;
				cblock.add_statement (cunref);
			}
		}
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

