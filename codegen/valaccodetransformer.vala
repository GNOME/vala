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
	public override void visit_constant (Constant c) {
		c.active = true;
		c.accept_children (this);
	}

	public override void visit_method (Method m) {
		if (m.body == null) {
			return;
		}

		m.accept_children (this);
	}

	public override void visit_creation_method (CreationMethod m) {
		if (m.body == null) {
			return;
		}

		m.accept_children (this);
	}

	public override void visit_block (Block b) {
		b.accept_children (this);

		foreach (LocalVariable local in b.get_local_variables ()) {
			local.active = false;
		}
		foreach (Constant constant in b.get_local_constants ()) {
			constant.active = false;
		}
	}

	public override void visit_local_variable (LocalVariable local) {
		local.active = true;
		local.accept_children (this);
	}

	public override void visit_while_statement (WhileStatement stmt) {
		// convert to simple loop
		begin_replace_statement (stmt);

		if (!always_false (stmt.condition)) {
			b.open_loop ();
			if (!always_true (stmt.condition)) {
				var cond = expression (@"!$(stmt.condition)");
				b.open_if (cond);
				b.add_break ();
				b.close ();
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
			b.open_if (expression (notfirst));
			b.open_if (new UnaryExpression (UnaryOperator.LOGICAL_NEGATION, stmt.condition, stmt.source_reference));
			b.add_break ();
			b.close ();
			b.add_else ();
			b.add_assignment (expression (notfirst), expression ("true"));
			b.close ();
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
				statements (@"if (!$(stmt.condition)) break;");
			}
			b.add_statement (stmt.body);

			b.close ();
		}

		stmt.body.checked = false;
		end_replace_statement ();
	}

	public override void visit_foreach_statement (ForeachStatement stmt) {
		begin_replace_statement (stmt);

		stmt.body.remove_local_variable (stmt.element_variable);
		stmt.element_variable.checked = false;
		var decl = new DeclarationStatement (stmt.element_variable, stmt.element_variable.source_reference);

		switch (stmt.foreach_iteration) {
		case ForeachIteration.ARRAY:
			var array_type = (ArrayType) stmt.collection.value_type.copy ();
			array_type.fixed_length = false;
			array_type.inline_allocated = false;
			string collection;
			string length;
			// multidimensonal array
			if (array_type.rank > 1) {
				length = @"$(stmt.collection).length[0]";
				var dim = 1;
				while (dim < array_type.rank) {
					length += @" * $(stmt.collection).length[$dim]";
					dim++;
				}
				collection = b.add_temp_declaration (new ArrayType (array_type.element_type, 1, null), expression (@"($(array_type.element_type)[]) ($(stmt.collection))"));
			} else {
				collection = b.add_temp_declaration (array_type, stmt.collection);
				length = @"$collection.length";
			}
			var i = b.add_temp_declaration (array_type.length_type, expression ("0"));
			b.open_for (null, expression (@"$i < $length"), expression (@"$i++"));
			stmt.element_variable.initializer = expression (@"$collection[$i]");
			break;
		case ForeachIteration.GVALUE_ARRAY:
			// GValueArray
			var collection = b.add_temp_declaration (null, expression (@"$(stmt.collection).values"));
			var i = b.add_temp_declaration (null, expression ("0"));
			b.open_for (null, expression (@"$i < $collection.length"), expression (@"$i++"));
			stmt.element_variable.initializer = expression (@"$collection[$i]");
			break;
		case ForeachIteration.GLIST:
			// GList or GSList
			var collection = b.add_temp_declaration (stmt.collection.value_type, stmt.collection);
			var iter = b.add_temp_declaration (copy_type (stmt.collection.value_type, false, true), expression (collection));
			b.open_for (null, expression (@"$iter != null"), expression (@"$iter = ((!) $iter).next"));
			stmt.element_variable.initializer = expression (@"((!) $iter).data");
			break;
		case ForeachIteration.INDEX:
			// get() + size
			var collection = b.add_temp_declaration (stmt.collection.value_type, stmt.collection);
			var size = b.add_temp_declaration (null, expression (@"$collection.size"));
			var i = b.add_temp_declaration (null, expression ("0"));
			b.open_for (null, expression (@"$i < $size"), expression (@"$i++"));
			stmt.element_variable.initializer = expression (@"$collection.get ($i)");
			break;
		case ForeachIteration.NEXT_VALUE:
			// iterator + next_value()
			var collection = b.add_temp_declaration (stmt.collection.value_type, stmt.collection);
			var iterator = b.add_temp_declaration (null, expression (@"$collection.iterator ()"));
			var temp = b.add_temp_declaration (copy_type (stmt.type_reference, null, true));
			b.open_while (expression (@"($temp = $iterator.next_value ()) != null"));
			stmt.element_variable.initializer = expression (@"(!) $temp");
			break;
		case ForeachIteration.NEXT_GET:
			// iterator + next() + get()
			var collection = b.add_temp_declaration (stmt.collection.value_type, stmt.collection);
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

	public override void visit_expression (Expression expr) {
		if (expr in context.analyzer.replaced_nodes) {
			return;
		}

		base.visit_expression (expr);
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

		base.visit_method_call (expr);
	}

	public override void visit_conditional_expression (ConditionalExpression expr) {
		// convert to if statement
		Expression replacement = null;
		var formal_target_type = copy_type (expr.target_type);
		var target_type = copy_type (expr.target_type);
		begin_replace_expression (expr);

		var result = b.add_temp_declaration (expr.value_type);
		statements (@"if ($(expr.condition)) {
					$result = $(expr.true_expression);
					} else {
					$result = $(expr.false_expression);
					}");

		replacement = return_temp_access (result, expr.value_type, target_type, formal_target_type);
		end_replace_expression (replacement);
	}

	public override void visit_binary_expression (BinaryExpression expr) {
		var parent_statement = expr.parent_statement;
		if (parent_statement == null) {
			base.visit_binary_expression (expr);
			return;
		}

		Expression replacement = null;
		var target_type = copy_type (expr.target_type);
		begin_replace_expression (expr);

		if (context.analyzer.get_current_non_local_symbol (expr) is Block
		    && (expr.operator == BinaryOperator.AND || expr.operator == BinaryOperator.OR)) {
			var is_and = expr.operator == BinaryOperator.AND;
			var result = b.add_temp_declaration (data_type ("bool"));
			b.open_if (expr.left);
			if (is_and) {
				b.add_assignment (expression (result), expr.right);
			} else {
				b.add_expression (expression (@"$result = true"));
			}
			b.add_else ();
			if (is_and) {
				b.add_expression (expression (@"$result = false"));
			} else {
				b.add_assignment (expression (result), expr.right);
			}
			b.close ();
			replacement = expression (result);
		} else if (expr.operator == BinaryOperator.COALESCE) {
			var result = b.add_temp_declaration (copy_type (expr.value_type, null, true), expr.left);

			b.open_if (expression (@"$result == null"));
			b.add_assignment (expression (result), expr.right);
			b.close ();

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
			base.visit_binary_expression (expr);
		}
	}
}
