/* valaccodetransformer.vala
 *
 * Copyright (C) 2012  Luca Bruno
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
 * 	Luca Bruno <lucabru@src.gnome.org>
 */

/**
 * Code visitor for simplyfing the code tree for the C codegen.
 */
public class Vala.CCodeTransformer : CodeTransformer {
	public override void visit_source_file (SourceFile source_file) {
		source_file.accept_children (head);
	}

	public override void visit_class (Class cl) {
		cl.accept_children (head);
	}

	public override void visit_struct (Struct st) {
		st.accept_children (head);
	}

	public override void visit_interface (Interface iface) {
		iface.accept_children (head);
	}

	public override void visit_enum (Enum en) {
		en.accept_children (head);
	}

	public override void visit_enum_value (EnumValue ev) {
		ev.accept_children (head);
	}

	public override void visit_error_domain (ErrorDomain edomain) {
		edomain.accept_children (head);
	}

	public override void visit_error_code (ErrorCode ecode) {
		ecode.accept_children (head);
	}

	public override void visit_delegate (Delegate d) {
		d.accept_children (head);
	}

	public override void visit_constant (Constant c) {
		c.active = true;
		c.accept_children (head);
	}

	public override void visit_field (Field f) {
		f.accept_children (head);
	}

	public override void visit_method (Method m) {
		m.accept_children (head);
	}

	public override void visit_creation_method (CreationMethod m) {
		m.accept_children (head);
	}

	public override void visit_formal_parameter (Parameter p) {
		p.accept_children (head);
	}

	public override void visit_property (Property prop) {
		prop.accept_children (head);
	}

	public override void visit_property_accessor (PropertyAccessor acc) {
		acc.accept_children (head);
	}

	public override void visit_signal (Signal sig) {
		sig.accept_children (head);
	}

	public override void visit_constructor (Constructor c) {
		c.accept_children (head);
	}

	public override void visit_destructor (Destructor d) {
		d.accept_children (head);
	}

	public override void visit_block (Block b) {
		b.accept_children (head);

		foreach (LocalVariable local in b.get_local_variables ()) {
			local.active = false;
		}
		foreach (Constant constant in b.get_local_constants ()) {
			constant.active = false;
		}
	}

	public override void visit_declaration_statement (DeclarationStatement stmt) {
		stmt.accept_children (head);
	}

	public override void visit_local_variable (LocalVariable local) {
		local.active = true;
		local.accept_children (head);
	}

	public override void visit_initializer_list (InitializerList list) {
		list.accept_children (head);
	}

	public override void visit_expression_statement (ExpressionStatement stmt) {
		stmt.accept_children (head);
	}

	public override void visit_if_statement (IfStatement stmt) {
		stmt.accept_children (head);
	}

	public override void visit_switch_statement (SwitchStatement stmt) {
		stmt.accept_children (head);
	}

	public override void visit_switch_section (SwitchSection section) {
		section.accept_children (head);
	}

	public override void visit_switch_label (SwitchLabel label) {
		label.accept_children (head);
	}

	public override void visit_loop (Loop loop) {
		loop.accept_children (head);
	}

	public override void visit_while_statement (WhileStatement stmt) {
		// convert to simple loop
		begin_replace_statement (stmt);

		if (!always_false (stmt.condition)) {
			b.open_loop ();
			if (!always_true (stmt.condition)) {
				statements ("if (!%?) { break; }", {stmt.condition});
			}
			b.add_statement (stmt.body);
			b.close ();
		}

		stmt.body.checked = false;
		end_replace_statement ();
	}

	public override void visit_do_statement (DoStatement stmt) {
		// convert to simple loop
		begin_replace_statement (stmt);

		b.open_loop ();
		// do not generate variable and if block if condition is always true
		if (!always_true (stmt.condition)) {
			var notfirst = b.add_temp_declaration (null, expression ("false"));
			statements (@"if ($notfirst) {
							if (!%?) {
								break;
							}
						} else {
							$notfirst = true;
						}", {stmt.condition});
		}
		stmt.body.checked = false;
		b.add_statement (stmt.body);
		b.close ();

		end_replace_statement ();
	}

	public override void visit_for_statement (ForStatement stmt) {
		// convert to simple loop
		begin_replace_statement (stmt);

		// initializer
		foreach (var init_expr in stmt.get_initializer ()) {
			b.add_expression (init_expr);
		}

		if (stmt.condition == null || !always_false (stmt.condition)) {
			b.open_loop ();
			var notfirst = b.add_temp_declaration (null, expression ("false"));
			b.open_if (expression (notfirst));
			foreach (var it_expr in stmt.get_iterator ()) {
				b.add_expression (it_expr);
			}
			b.add_else ();
			statements (@"$notfirst = true;");
			b.close ();

			if (stmt.condition != null && !always_true (stmt.condition)) {
				statements ("if (!%?) break;", {stmt.condition});
			}
			b.add_statement (stmt.body);

			b.close ();
		}

		stmt.body.checked = false;
		end_replace_statement ();
	}

	public override void visit_foreach_statement (ForeachStatement stmt) {
		begin_replace_statement (stmt);

		var collection = b.add_temp_declaration (stmt.collection.value_type, stmt.collection);

		stmt.body.remove_local_variable (stmt.element_variable);
		stmt.element_variable.checked = false;
		var decl = new DeclarationStatement (stmt.element_variable, stmt.element_variable.source_reference);

		switch (stmt.foreach_iteration) {
		case ForeachIteration.ARRAY:
		case ForeachIteration.GVALUE_ARRAY:
			// array or GValueArray
			var array = collection;
			if (stmt.foreach_iteration == ForeachIteration.GVALUE_ARRAY) {
				array = collection+".values";
			}
			var i = b.add_temp_declaration (null, expression ("0"));
			b.open_for (null, expression (@"$i < $array.length"), expression (@"$i++"));
			stmt.element_variable.initializer = expression (@"$array[$i]");
			break;
		case ForeachIteration.GLIST:
			// GList or GSList
			var iter_type = stmt.collection.value_type.copy ();
			iter_type.value_owned = false;
			var iter = b.add_temp_declaration (iter_type, expression (collection));
			b.open_for (null, expression (@"$iter != null"), expression (@"$iter = $iter.next"));
			stmt.element_variable.initializer = expression (@"$iter.data");
			break;
		case ForeachIteration.INDEX:
			// get()+size
			var size = b.add_temp_declaration (null, expression (@"$collection.size"));
			var i = b.add_temp_declaration (null, expression ("0"));
			b.open_for (null, expression (@"$i < $size"), expression (@"$i++"));
			stmt.element_variable.initializer = expression (@"$collection.get ($i)");
			break;
		case ForeachIteration.NEXT_VALUE:
			// iterator+next_value()
			var iterator = b.add_temp_declaration (null, expression (@"$collection.iterator ()"));
			var temp = b.add_temp_declaration (stmt.type_reference);
			b.open_while (expression (@"($temp = $iterator.next_value ()) != null"));
			stmt.element_variable.initializer = expression (temp);
			break;
		case ForeachIteration.NEXT_GET:
			// iterator+next()+get()
			var iterator = b.add_temp_declaration (null, expression (@"$collection.iterator ()"));
			b.open_while (expression (@"$iterator.next ()"));
			stmt.element_variable.initializer = expression (@"$iterator.get ()");
			break;
		default:
			assert_not_reached ();
		}

		stmt.body.insert_statement (0, decl);
		b.add_statement (stmt.body);
		b.close ();

		stmt.body.checked = false;
		end_replace_statement ();
	}

	public override void visit_break_statement (BreakStatement stmt) {
		stmt.accept_children (head);
	}

	public override void visit_continue_statement (ContinueStatement stmt) {
		stmt.accept_children (head);
	}

	public override void visit_return_statement (ReturnStatement stmt) {
		stmt.accept_children (head);
	}

	public override void visit_yield_statement (YieldStatement stmt) {
		stmt.accept_children (head);
	}

	public override void visit_throw_statement (ThrowStatement stmt) {
		stmt.accept_children (head);
	}

	public override void visit_try_statement (TryStatement stmt) {
		stmt.accept_children (head);
	}

	public override void visit_catch_clause (CatchClause clause) {
		clause.accept_children (head);
	}

	public override void visit_lock_statement (LockStatement stmt) {
		stmt.accept_children (head);
	}

	public override void visit_unlock_statement (UnlockStatement stmt) {
		stmt.accept_children (head);
	}

	public override void visit_delete_statement (DeleteStatement stmt) {
		stmt.accept_children (head);
	}

	public override void visit_expression (Expression expr) {
		expr.accept_children (head);
	}

	public override void visit_method_call (MethodCall expr) {
		if (expr.tree_can_fail) {
			if (expr.parent_node is LocalVariable || expr.parent_node is ExpressionStatement) {
				// simple statements, no side effects after method call
			} else if (!(context.analyzer.get_current_non_local_symbol (expr) is Block)) {
				// can't handle errors in field initializers
				Report.error (expr.source_reference, "Field initializers must not throw errors");
			} else {
				var formal_target_type = copy_type (expr.target_type);
				var target_type = copy_type (expr.target_type);
				begin_replace_expression (expr);

				var local = b.add_temp_declaration (copy_type (expr.value_type), expr);
				var replacement = return_temp_access (local, expr.value_type, target_type, formal_target_type);

				end_replace_expression (replacement);
				return;
			}
		}

		expr.accept_children (head);
	}

	public override void visit_conditional_expression (ConditionalExpression expr) {
		// convert to if statement
		Expression replacement = null;
		var formal_target_type = copy_type (expr.target_type);
		var target_type = copy_type (expr.target_type);
		begin_replace_expression (expr);

		var result = b.add_temp_declaration (expr.value_type);
		statements (@"if (%?) {
					$result = %?;
					} else {
					$result = %?;
					}", {expr.condition, expr.true_expression, expr.false_expression});

		replacement = return_temp_access (result, expr.value_type, target_type, formal_target_type);
		end_replace_expression (replacement);
	}

	public override void visit_binary_expression (BinaryExpression expr) {
		var parent_statement = expr.parent_statement;
		if (parent_statement == null) {
			return;
		}

		Expression replacement = null;
		var target_type = copy_type (expr.target_type);
		begin_replace_expression (expr);

		if (context.analyzer.get_current_non_local_symbol (expr) is Block
		    && (expr.operator == BinaryOperator.AND || expr.operator == BinaryOperator.OR)) {
			var is_and = expr.operator == BinaryOperator.AND;
			var result = b.add_temp_declaration (data_type ("bool"));

			if (is_and) {
				statements (@"if (%?) {
							$result = %?;
							} else {
							$result = false;
							}", {expr.left, expr.right});
			} else {
				statements (@"if (%?) {
							$result = true;
							} else {
							$result = %?;
							}", {expr.left, expr.right});
			}

			replacement = expression (result);
		} else if (expr.operator == BinaryOperator.COALESCE) {
			var result = b.add_temp_declaration (copy_type (expr.value_type), expr.left);

			statements (@"if ($result == null) { $result = %?; }", {expr.right});

			replacement = return_temp_access (result, expr.value_type, target_type);
		} else if (expr.operator == BinaryOperator.IN && !(expr.left.value_type.compatible (context.analyzer.int_type) && expr.right.value_type.compatible (context.analyzer.int_type)) && !(expr.right.value_type is ArrayType)) {
			// neither enums nor array, it's contains()
			var call = new MethodCall (new MemberAccess (expr.right, "contains", expr.source_reference), expr.source_reference);
			call.add_argument (expr.left);
			replacement = call;
		}

		if (replacement != null) {
			replacement.target_type = target_type;
			end_replace_expression (replacement);
		} else {
			end_replace_expression (null);
			expr.accept_children (head);
		}
	}

	public override void visit_unary_expression (UnaryExpression expr) {
		var parent_statement = expr.parent_statement;
		if (parent_statement == null) {
			return;
		}

		if (expr.operator == UnaryOperator.INCREMENT || expr.operator == UnaryOperator.DECREMENT) {
			var target_type = copy_type (expr.target_type);
			begin_replace_expression (expr);

			Expression replacement;
			if (expr.operator == UnaryOperator.INCREMENT) {
				replacement = expression (@"$(expr.inner) = $(expr.inner) + 1");
			} else {
				replacement = expression (@"$(expr.inner) = $(expr.inner) - 1");
			}
			replacement.target_type = target_type;

			end_replace_expression (replacement);
			return;
		}

		expr.accept_children (head);
	}

	public override void visit_object_creation_expression (ObjectCreationExpression expr) {
		if (expr.tree_can_fail) {
			if (expr.parent_node is LocalVariable || expr.parent_node is ExpressionStatement) {
				// simple statements, no side effects after method call
			} else if (!(context.analyzer.get_current_non_local_symbol (expr) is Block)) {
				// can't handle errors in field initializers
				Report.error (expr.source_reference, "Field initializers must not throw errors");
			} else {
				var target_type = copy_type (expr.target_type);
				var formal_target_type = copy_type (expr.formal_target_type);
				begin_replace_expression (expr);

				var local = b.add_temp_declaration (expr.value_type, expr);
				var replacement = return_temp_access (local, expr.value_type, target_type, formal_target_type);

				end_replace_expression (replacement);
				return;
			}
		}

		expr.accept_children (head);
	}

	public override void visit_template (Template expr) {
		begin_replace_expression (expr);

		Expression replacement;

		var expression_list = expr.get_expressions ();
		if (expression_list.size == 0) {
			replacement = expression ("\"\"");
		} else {
			replacement = stringify (expression_list[0]);
			if (expression_list.size > 1) {
				var concat = (MethodCall) expression ("%?.concat()", {replacement});
				for (int i = 1; i < expression_list.size; i++) {
					concat.add_argument (stringify (expression_list[i]));
				}
				replacement = concat;
			}
		}
		replacement.target_type = expr.target_type;

		end_replace_expression (replacement);
	}

	public override void visit_postfix_expression (PostfixExpression expr) {
		begin_replace_expression (expr);

		var result = b.add_temp_declaration (copy_type (expr.value_type), expr.inner);
		var op = expr.increment ? "+ 1" : "- 1";
		statements (@"$(expr.inner) = $result $op;");

		var replacement = return_temp_access (result, expr.value_type, expr.target_type);

		end_replace_expression (replacement);
	}

	public override void visit_assignment (Assignment a) {
		a.accept_children (head);
	}

	public override void visit_cast_expression (CastExpression expr) {
		expr.accept_children (head);
	}

	public override void visit_lambda_expression (LambdaExpression expr) {
		expr.accept_children (head);
	}


	public override void visit_array_creation_expression (ArrayCreationExpression expr) {
		expr.accept_children (head);
	}

	public override void visit_member_access (MemberAccess expr) {
		expr.accept_children (head);
	}

	public override void visit_element_access (ElementAccess expr) {
		expr.accept_children (head);
	}

	public override void visit_slice_expression (SliceExpression expr) {
		expr.accept_children (head);
	}

	public override void visit_base_access (BaseAccess expr) {
		expr.accept_children (head);
	}

	public override void visit_sizeof_expression (SizeofExpression expr) {
		expr.accept_children (head);
	}

	public override void visit_typeof_expression (TypeofExpression expr) {
		expr.accept_children (head);
	}

	public override void visit_named_argument (NamedArgument expr) {
		expr.accept_children (head);
	}

	public override void visit_pointer_indirection (PointerIndirection expr) {
		expr.accept_children (head);
	}

	public override void visit_addressof_expression (AddressofExpression expr) {
		expr.accept_children (head);
	}

	public override void visit_reference_transfer_expression (ReferenceTransferExpression expr) {
		expr.accept_children (head);
	}

	public override void visit_type_check (TypeCheck expr) {
		expr.accept_children (head);
	}

	public override void visit_type_parameter (TypeParameter p) {
		p.accept_children (head);
	}

	public override void visit_using_directive (UsingDirective ns) {
		ns.accept_children (head);
	}

	public override void visit_data_type (DataType type) {
		type.accept_children (head);
	}

	public override void visit_end_full_expression (Expression expr) {
		expr.accept_children (head);
	}

	public override void visit_boolean_literal (BooleanLiteral lit) {
		lit.accept_children (head);
	}

	public override void visit_character_literal (CharacterLiteral lit) {
		lit.accept_children (head);
	}

	public override void visit_integer_literal (IntegerLiteral lit) {
		lit.accept_children (head);
	}

	public override void visit_real_literal (RealLiteral lit) {
		lit.accept_children (head);
	}

	public override void visit_regex_literal (RegexLiteral lit) {
		lit.accept_children (head);
	}

	public override void visit_string_literal (StringLiteral lit) {
		lit.accept_children (head);
	}

	public override void visit_tuple (Tuple tuple) {
		tuple.accept_children (head);
	}

	public override void visit_null_literal (NullLiteral lit) {
		lit.accept_children (head);
	}
}
