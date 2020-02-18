/* valabinaryexpression.vala
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


/**
 * Represents an expression with two operands in the source code.
 *
 * Supports +, -, *, /, %, <<, >>, <, >, <=, >=, ==, !=, &, |, ^, &&, ||, ??.
 */
public class Vala.BinaryExpression : Expression {
	/**
	 * The binary operator.
	 */
	public BinaryOperator operator { get; set; }

	/**
	 * The left operand.
	 */
	public Expression left {
		get {
			return _left;
		}
		set {
			_left = value;
			_left.parent_node = this;
		}
	}

	/**
	 * The right operand.
	 */
	public Expression right {
		get {
			return _right;
		}
		set {
			_right = value;
			_right.parent_node = this;
		}
	}

	public bool is_chained { get; private set; }

	private Expression _left;
	private Expression _right;

	/**
	 * Creates a new binary expression.
	 *
	 * @param op      binary operator
	 * @param _left   left operand
	 * @param _right  right operand
	 * @param source  reference to source code
	 * @return        newly created binary expression
	 */
	public BinaryExpression (BinaryOperator op, Expression _left, Expression _right, SourceReference? source = null) {
		operator = op;
		left = _left;
		right = _right;
		is_chained = false;
		source_reference = source;
	}

	public BinaryExpression.chained (BinaryOperator op, Expression _left, Expression _right, SourceReference? source = null) {
		operator = op;
		left = _left;
		right = _right;
		is_chained = true;
		source_reference = source;
	}

	public override void accept (CodeVisitor visitor) {
		visitor.visit_binary_expression (this);

		visitor.visit_expression (this);
	}

	public override void accept_children (CodeVisitor visitor) {
		left.accept (visitor);
		right.accept (visitor);
	}

	public override void replace_expression (Expression old_node, Expression new_node) {
		if (left == old_node) {
			left = new_node;
		}
		if (right == old_node) {
			right = new_node;
		}
	}

	public override string to_string () {
		return "(%s %s %s)".printf (_left.to_string (), operator.to_string (), _right.to_string ());
	}

	public override bool is_constant () {
		return left.is_constant () && right.is_constant ();
	}

	public override bool is_pure () {
		return left.is_pure () && right.is_pure ();
	}

	public override bool is_non_null () {
		return left.is_non_null () && right.is_non_null ();
	}

	public override bool is_accessible (Symbol sym) {
		return left.is_accessible (sym) && right.is_accessible (sym);
	}

	public override void get_error_types (Collection<DataType> collection, SourceReference? source_reference = null) {
		left.get_error_types (collection, source_reference);
		right.get_error_types (collection, source_reference);
	}

	public override bool check (CodeContext context) {
		if (checked) {
			return !error;
		}

		checked = true;

		// some expressions are not in a block,
		// for example, expressions in method contracts
		if (context.analyzer.current_symbol is Block
		    && (operator == BinaryOperator.AND || operator == BinaryOperator.OR)) {
			// convert conditional expression into if statement
			// required for flow analysis and exception handling

			var local = new LocalVariable (context.analyzer.bool_type.copy (), get_temp_name (), null, source_reference);
			var decl = new DeclarationStatement (local, source_reference);

			var right_stmt = new ExpressionStatement (new Assignment (new MemberAccess.simple (local.name, right.source_reference), right, AssignmentOperator.SIMPLE, right.source_reference), right.source_reference);

			var stmt = new ExpressionStatement (new Assignment (new MemberAccess.simple (local.name, left.source_reference), new BooleanLiteral ((operator == BinaryOperator.OR), left.source_reference), AssignmentOperator.SIMPLE, left.source_reference), left.source_reference);

			var true_block = new Block (source_reference);
			var false_block = new Block (source_reference);

			if (operator == BinaryOperator.AND) {
				true_block.add_statement (right_stmt);
				false_block.add_statement (stmt);
			} else {
				true_block.add_statement (stmt);
				false_block.add_statement (right_stmt);
			}

			var if_stmt = new IfStatement (left, true_block, false_block, source_reference);

			insert_statement (context.analyzer.insert_block, decl);
			insert_statement (context.analyzer.insert_block, if_stmt);

			decl.check (context);

			if (!if_stmt.check (context)) {
				error = true;
				return false;
			}

			var ma = new MemberAccess.simple (local.name, source_reference);
			ma.target_type = target_type;
			ma.formal_target_type = formal_target_type;

			parent_node.replace_expression (this, ma);

			ma.check (context);

			return true;
		}

		if (operator == BinaryOperator.COALESCE) {
			if (target_type != null) {
				left.target_type = target_type.copy ();
				right.target_type = target_type.copy ();
			}

			if (!left.check (context)) {
				error = true;
				return false;
			}

			string temp_name = get_temp_name ();

			// right expression is checked under a block (required for short-circuiting)
			var right_local = new LocalVariable (null, temp_name, right, right.source_reference);
			var right_decl = new DeclarationStatement (right_local, right.source_reference);
			var true_block = new Block (source_reference);
			true_block.add_statement (right_decl);

			if (!true_block.check (context)) {
				error = true;
				return false;
			}

			// right expression may have been replaced by the check
			right = right_local.initializer;

			DataType local_type = null;
			bool cast_non_null = false;
			if (left.value_type is NullType && right.value_type != null) {
				Report.warning (left.source_reference, "left operand is always null");
				local_type = right.value_type.copy ();
				local_type.nullable = true;
				if (!right.value_type.nullable) {
					cast_non_null = true;
				}
			} else if (left.value_type != null) {
				local_type = left.value_type.copy ();
				if (right.value_type != null && right.value_type.value_owned) {
					// value owned if either left or right is owned
					local_type.value_owned = true;
				}
				if (context.experimental_non_null) {
					if (!local_type.nullable) {
						Report.warning (left.source_reference, "left operand is never null");
						if (right.value_type != null && right.value_type.nullable) {
							local_type.nullable = true;
							cast_non_null = true;
						}
					} else if (right.value_type != null && !right.value_type.nullable) {
						cast_non_null = true;
					}
				}
			} else if (right.value_type != null) {
				local_type = right.value_type.copy ();
			}

			if (local_type != null && right.value_type is ValueType && !right.value_type.nullable) {
				// immediate values in the right expression must always be boxed,
				// otherwise the local variable may receive a stale pointer to the stack
				local_type.value_owned = true;
			}

			var local = new LocalVariable (local_type, temp_name, left, source_reference);
			var decl = new DeclarationStatement (local, source_reference);

			insert_statement (context.analyzer.insert_block, decl);

			if (!decl.check (context)) {
				error = true;
				return false;
			}

			// replace the temporary local variable used to compute the type of the right expression by an assignment
			var right_stmt = new ExpressionStatement (new Assignment (new MemberAccess.simple (local.name, right.source_reference), right, AssignmentOperator.SIMPLE, right.source_reference), right.source_reference);

			true_block.remove_local_variable (right_local);
			true_block.replace_statement (right_decl, right_stmt);

			if (!right_stmt.check (context)) {
				error = true;
				return false;
			}

			var cond = new BinaryExpression (BinaryOperator.EQUALITY, new MemberAccess.simple (local.name, left.source_reference), new NullLiteral (source_reference), source_reference);

			var if_stmt = new IfStatement (cond, true_block, null, source_reference);

			insert_statement (context.analyzer.insert_block, if_stmt);

			if (!if_stmt.check (context)) {
				error = true;
				return false;
			}

			var replace_expr = SemanticAnalyzer.create_temp_access (local, target_type);
			if (cast_non_null && replace_expr.target_type != null) {
				var cast = new CastExpression.non_null (replace_expr, source_reference);
				cast.target_type = replace_expr.target_type.copy ();
				cast.target_type.nullable = false;
				replace_expr = cast;
			}

			parent_node.replace_expression (this, replace_expr);

			replace_expr.check (context);

			return true;
		}

		// enum-type inference
		if (target_type != null && target_type.type_symbol is Enum
		    && (operator == BinaryOperator.BITWISE_AND || operator == BinaryOperator.BITWISE_OR)) {
			left.target_type = target_type.copy ();
			right.target_type = target_type.copy ();
		}
		left.check (context);
		if (left.value_type != null && left.value_type.type_symbol is Enum
		    && (operator == BinaryOperator.EQUALITY || operator == BinaryOperator.INEQUALITY)) {
			right.target_type = left.value_type.copy ();
		}
		right.check (context);
		if (right.value_type != null && right.value_type.type_symbol is Enum
		    && (operator == BinaryOperator.EQUALITY || operator == BinaryOperator.INEQUALITY)) {
			left.target_type = right.value_type.copy ();
			//TODO bug 666035 -- re-check left how?
		}

		if (!left.check (context) || !right.check (context)) {
			/* if there were any errors in inner expressions, skip type check */
			error = true;
			return false;
		}

		if (left.value_type == null) {
			Report.error (left.source_reference, "invalid left operand");
			error = true;
			return false;
		}

		if (right.value_type == null) {
			Report.error (right.source_reference, "invalid right operand");
			error = true;
			return false;
		}

		if (left.value_type is FieldPrototype || left.value_type is PropertyPrototype) {
			error = true;
			Report.error (left.source_reference, "Access to instance member `%s' denied".printf (left.symbol_reference.get_full_name ()));
			return false;
		}
		if (right.value_type is FieldPrototype || right.value_type is PropertyPrototype) {
			error = true;
			Report.error (right.source_reference, "Access to instance member `%s' denied".printf (right.symbol_reference.get_full_name ()));
			return false;
		}

		left.target_type = left.value_type.copy ();
		left.target_type.value_owned = false;
		right.target_type = right.value_type.copy ();
		right.target_type.value_owned = false;

		if (operator == BinaryOperator.PLUS
		    && left.value_type.type_symbol == context.analyzer.string_type.type_symbol) {
			// string concatenation

			if (right.value_type == null || right.value_type.type_symbol != context.analyzer.string_type.type_symbol) {
				error = true;
				Report.error (source_reference, "Operands must be strings");
				return false;
			}

			value_type = context.analyzer.string_type.copy ();
			if (left.is_constant () && right.is_constant ()) {
				value_type.value_owned = false;
			} else {
				value_type.value_owned = true;
			}

			value_type.check (context);
			return !error;
		} else if (operator == BinaryOperator.PLUS && left.value_type is ArrayType) {
			// array concatenation

			unowned ArrayType array_type = (ArrayType) left.value_type;

			if (array_type.inline_allocated) {
				error = true;
				Report.error (source_reference, "Array concatenation not supported for fixed length arrays");
			}
			if (right.value_type == null || !right.value_type.compatible (array_type.element_type)) {
				error = true;
				Report.error (source_reference, "Incompatible operand");
				return false;
			}

			right.target_type = array_type.element_type.copy ();

			value_type = array_type.copy ();
			value_type.value_owned = true;

			value_type.check (context);
			return !error;
		}

		switch (operator) {
		case BinaryOperator.PLUS:
		case BinaryOperator.MINUS:
		case BinaryOperator.MUL:
		case BinaryOperator.DIV:
			// check for pointer arithmetic
			if (left.value_type is PointerType) {
				unowned PointerType pointer_type = (PointerType) left.value_type;
				if (pointer_type.base_type is VoidType) {
					error = true;
					Report.error (source_reference, "Pointer arithmetic not supported for `void*'");
					return false;
				}

				unowned Struct? offset_type = right.value_type.type_symbol as Struct;
				if (offset_type != null && offset_type.is_integer_type ()) {
					if (operator == BinaryOperator.PLUS
					    || operator == BinaryOperator.MINUS) {
						// pointer arithmetic: pointer +/- offset
						value_type = left.value_type.copy ();
					}
				} else if (right.value_type is PointerType) {
					// pointer arithmetic: pointer - pointer
					value_type = context.analyzer.size_t_type;
				}
			} else {
				left.target_type.nullable = false;
				right.target_type.nullable = false;
			}

			if (value_type == null) {
				value_type = context.analyzer.get_arithmetic_result_type (left.target_type, right.target_type);
			}

			if (value_type == null) {
				error = true;
				Report.error (source_reference, "Arithmetic operation not supported for types `%s' and `%s'".printf (left.value_type.to_string (), right.value_type.to_string ()));
				return false;
			}
			break;
		case BinaryOperator.MOD:
		case BinaryOperator.SHIFT_LEFT:
		case BinaryOperator.SHIFT_RIGHT:
			left.target_type.nullable = false;
			right.target_type.nullable = false;

			value_type = context.analyzer.get_arithmetic_result_type (left.target_type, right.target_type);

			if (value_type == null) {
				error = true;
				Report.error (source_reference, "Arithmetic operation not supported for types `%s' and `%s'".printf (left.value_type.to_string (), right.value_type.to_string ()));
				return false;
			}
			break;
		case BinaryOperator.LESS_THAN:
		case BinaryOperator.GREATER_THAN:
		case BinaryOperator.LESS_THAN_OR_EQUAL:
		case BinaryOperator.GREATER_THAN_OR_EQUAL:
			if (left.value_type.compatible (context.analyzer.string_type)
			    && right.value_type.compatible (context.analyzer.string_type)) {
				// string comparison
				} else if (left.value_type is PointerType && right.value_type is PointerType) {
					// pointer arithmetic
			} else {
				DataType resulting_type;

				if (is_chained) {
					var lbe = (BinaryExpression) left;
					resulting_type = context.analyzer.get_arithmetic_result_type (lbe.right.target_type, right.target_type);
				} else {
					resulting_type = context.analyzer.get_arithmetic_result_type (left.target_type, right.target_type);
				}

				if (resulting_type == null) {
					error = true;
					Report.error (source_reference, "Relational operation not supported for types `%s' and `%s'".printf (left.value_type.to_string (), right.value_type.to_string ()));
					return false;
				}

				if (!is_chained) {
					left.target_type = resulting_type.copy ();
				}
				right.target_type = resulting_type.copy ();
				left.target_type.nullable = false;
				right.target_type.nullable = false;
			}

			value_type = context.analyzer.bool_type;
			break;
		case BinaryOperator.EQUALITY:
		case BinaryOperator.INEQUALITY:
			/* relational operation */

			if (context.profile == Profile.GOBJECT) {
				// Implicit cast for comparsion expression of GValue with other type
				var gvalue_type = context.analyzer.gvalue_type.type_symbol;
				if ((left.target_type.type_symbol == gvalue_type && right.target_type.type_symbol != gvalue_type)
					|| (left.target_type.type_symbol != gvalue_type && right.target_type.type_symbol == gvalue_type)) {
					Expression gvalue_expr;
					DataType target_type;
					if (left.target_type.type_symbol == gvalue_type) {
						gvalue_expr = left;
						target_type = right.target_type;
					} else {
						gvalue_expr = right;
						target_type = left.target_type;
					}

					var cast_expr = new CastExpression (gvalue_expr, target_type, gvalue_expr.source_reference);
					replace_expression (gvalue_expr, cast_expr);
					checked = false;
					return check (context);
				}
			}

			if (!right.value_type.compatible (left.value_type)
			    && !left.value_type.compatible (right.value_type)) {
				Report.error (source_reference, "Equality operation: `%s' and `%s' are incompatible".printf (right.value_type.to_string (), left.value_type.to_string ()));
				error = true;
				return false;
			}

			var resulting_type = context.analyzer.get_arithmetic_result_type (left.target_type, right.target_type);
			if (resulting_type != null) {
				// numeric operation
				left.target_type = resulting_type.copy ();
				right.target_type = resulting_type.copy ();
			}

			left.target_type.value_owned = false;
			right.target_type.value_owned = false;

			if (left.value_type.nullable != right.value_type.nullable) {
				// if only one operand is nullable, make sure the other
				// operand is promoted to nullable as well,
				// reassign both, as get_arithmetic_result_type doesn't
				// take nullability into account
				left.target_type.nullable = true;
				right.target_type.nullable = true;
			}

			value_type = context.analyzer.bool_type;
			break;
		case BinaryOperator.BITWISE_AND:
		case BinaryOperator.BITWISE_OR:
		case BinaryOperator.BITWISE_XOR:
			// integer type or flags type
			left.target_type.nullable = false;
			right.target_type.nullable = false;

			// Don't falsely resolve to bool
			if (left.value_type.compatible (context.analyzer.bool_type)
			    && !right.value_type.compatible (context.analyzer.bool_type)) {
				value_type = right.target_type.copy ();
			} else {
				value_type = left.target_type.copy ();
			}
			break;
		case BinaryOperator.AND:
		case BinaryOperator.OR:
			if (!left.value_type.compatible (context.analyzer.bool_type) || !right.value_type.compatible (context.analyzer.bool_type)) {
				error = true;
				Report.error (source_reference, "Operands must be boolean");
			}
			left.target_type.nullable = false;
			right.target_type.nullable = false;

			value_type = context.analyzer.bool_type;
			break;
		case BinaryOperator.IN:
			if (left.value_type.compatible (context.analyzer.int_type)
			    && right.value_type.compatible (context.analyzer.int_type)) {
				// integers or enums
				left.target_type.nullable = false;
				right.target_type.nullable = false;
			} else if (right.value_type is ArrayType) {
				if (!left.value_type.compatible (((ArrayType) right.value_type).element_type)) {
					error = true;
					Report.error (source_reference, "Cannot look for `%s' in `%s'".printf (left.value_type.to_string (), right.value_type.to_string ()));
				}
			} else {
				// otherwise require a bool contains () method
				var contains_method = right.value_type.get_member ("contains") as Method;
				if (contains_method == null) {
					Report.error (source_reference, "`%s' does not have a `contains' method".printf (right.value_type.to_string ()));
					error = true;
					return false;
				}
				if (contains_method.get_parameters ().size != 1) {
					Report.error (source_reference, "`%s' must have one parameter".printf (contains_method.get_full_name ()));
					error = true;
					return false;
				}
				if (!contains_method.return_type.compatible (context.analyzer.bool_type)) {
					Report.error (source_reference, "`%s' must return a boolean value".printf (contains_method.get_full_name ()));
					error = true;
					return false;
				}

				var contains_call = new MethodCall (new MemberAccess (right, "contains", source_reference), source_reference);
				contains_call.add_argument (left);
				parent_node.replace_expression (this, contains_call);
				return contains_call.check (context);
			}

			value_type = context.analyzer.bool_type;
			break;
		default:
			error = true;
			Report.error (source_reference, "internal error: unsupported binary operator");
			return false;
		}

		value_type.check (context);

		return !error;
	}

	public override void emit (CodeGenerator codegen) {
		left.emit (codegen);
		right.emit (codegen);

		codegen.visit_binary_expression (this);

		codegen.visit_expression (this);
	}

	public override void get_defined_variables (Collection<Variable> collection) {
		left.get_defined_variables (collection);
		right.get_defined_variables (collection);
	}

	public override void get_used_variables (Collection<Variable> collection) {
		left.get_used_variables (collection);
		right.get_used_variables (collection);
	}
}

public enum Vala.BinaryOperator {
	NONE,
	PLUS,
	MINUS,
	MUL,
	DIV,
	MOD,
	SHIFT_LEFT,
	SHIFT_RIGHT,
	LESS_THAN,
	GREATER_THAN,
	LESS_THAN_OR_EQUAL,
	GREATER_THAN_OR_EQUAL,
	EQUALITY,
	INEQUALITY,
	BITWISE_AND,
	BITWISE_OR,
	BITWISE_XOR,
	AND,
	OR,
	IN,
	COALESCE;

	public unowned string to_string () {
		switch (this) {
		case PLUS: return "+";
		case MINUS: return "-";
		case MUL: return "*";
		case DIV: return "/";
		case MOD: return "%";
		case SHIFT_LEFT: return "<<";
		case SHIFT_RIGHT: return ">>";
		case LESS_THAN: return "<";
		case GREATER_THAN: return ">";
		case LESS_THAN_OR_EQUAL: return "<=";
		case GREATER_THAN_OR_EQUAL: return ">=";
		case EQUALITY: return "==";
		case INEQUALITY: return "!=";
		case BITWISE_AND: return "&";
		case BITWISE_OR: return "|";
		case BITWISE_XOR: return "^";
		case AND: return "&&";
		case OR: return "||";
		case IN: return "in";
		case COALESCE: return "??";
		default: assert_not_reached ();
		}
	}
}
