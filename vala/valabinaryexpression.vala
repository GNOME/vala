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
	
	public bool chained;

	private Expression _left;
	private Expression _right;
	
	/**
	 * Creates a new binary expression.
	 *
	 * @param op     binary operator
	 * @param left   left operand
	 * @param right  right operand
	 * @param source reference to source code
	 * @return       newly created binary expression
	 */
	public BinaryExpression (BinaryOperator op, Expression _left, Expression _right, SourceReference? source = null) {
		operator = op;
		left = _left;
		right = _right;
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

	public string get_operator_string () {
		switch (_operator) {
		case BinaryOperator.PLUS: return "+";
		case BinaryOperator.MINUS: return "-";
		case BinaryOperator.MUL: return "*";
		case BinaryOperator.DIV: return "/";
		case BinaryOperator.MOD: return "%";
		case BinaryOperator.SHIFT_LEFT: return "<<";
		case BinaryOperator.SHIFT_RIGHT: return ">>";
		case BinaryOperator.LESS_THAN: return "<";
		case BinaryOperator.GREATER_THAN: return ">";
		case BinaryOperator.LESS_THAN_OR_EQUAL: return "<=";
		case BinaryOperator.GREATER_THAN_OR_EQUAL: return ">=";
		case BinaryOperator.EQUALITY: return "==";
		case BinaryOperator.INEQUALITY: return "!=";
		case BinaryOperator.BITWISE_AND: return "&";
		case BinaryOperator.BITWISE_OR: return "|";
		case BinaryOperator.BITWISE_XOR: return "^";
		case BinaryOperator.AND: return "&&";
		case BinaryOperator.OR: return "||";
		case BinaryOperator.IN: return "in";
		case BinaryOperator.COALESCE: return "??";
		default: assert_not_reached ();
		}
	}

	public override string to_string () {
		return _left.to_string () + get_operator_string () + _right.to_string ();
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
			decl.check (context);

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

			if (!if_stmt.check (context)) {
				error = true;
				return false;
			}

			var ma = new MemberAccess.simple (local.name, source_reference);
			ma.target_type = target_type;
			ma.check (context);

			parent_node.replace_expression (this, ma);

			return true;
		}

		if (operator == BinaryOperator.COALESCE) {
			var local = new LocalVariable (null, get_temp_name (), left, source_reference);
			var decl = new DeclarationStatement (local, source_reference);
			decl.check (context);

			var right_stmt = new ExpressionStatement (new Assignment (new MemberAccess.simple (local.name, right.source_reference), right, AssignmentOperator.SIMPLE, right.source_reference), right.source_reference);

			var true_block = new Block (source_reference);

			true_block.add_statement (right_stmt);

			var cond = new BinaryExpression (BinaryOperator.EQUALITY, new MemberAccess.simple (local.name, left.source_reference), new NullLiteral (source_reference), source_reference);

			var if_stmt = new IfStatement (cond, true_block, null, source_reference);

			insert_statement (context.analyzer.insert_block, decl);
			insert_statement (context.analyzer.insert_block, if_stmt);

			if (!if_stmt.check (context)) {
				error = true;
				return false;
			}

			var ma = new MemberAccess.simple (local.name, source_reference);
			ma.target_type = target_type;
			ma.check (context);

			parent_node.replace_expression (this, ma);

			return true;
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

		if (operator != BinaryOperator.IN && right.value_type == null) {
			Report.error (right.source_reference, "invalid right operand");
			error = true;
			return false;
		}

		left.target_type = left.value_type.copy ();
		left.target_type.value_owned = false;
		right.target_type = right.value_type.copy ();
		right.target_type.value_owned = false;

		if (left.value_type.data_type == context.analyzer.string_type.data_type
		    && operator == BinaryOperator.PLUS) {
			// string concatenation

			if (context.profile == Profile.DOVA) {
				var concat_call = new MethodCall (new MemberAccess (left, "concat", source_reference), source_reference);
				concat_call.add_argument (right);
				concat_call.target_type = target_type;
				parent_node.replace_expression (this, concat_call);
				return concat_call.check (context);
			}

			if (right.value_type == null || right.value_type.data_type != context.analyzer.string_type.data_type) {
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
		} else if (context.profile == Profile.DOVA && left.value_type.data_type == context.analyzer.list_type.data_type
		    && operator == BinaryOperator.PLUS) {
			// list concatenation

			var concat_call = new MethodCall (new MemberAccess (left, "concat", source_reference), source_reference);
			concat_call.add_argument (right);
			concat_call.target_type = target_type;
			parent_node.replace_expression (this, concat_call);
			return concat_call.check (context);
		} else if (context.profile != Profile.DOVA && left.value_type is ArrayType && operator == BinaryOperator.PLUS) {
			// array concatenation

			var array_type = (ArrayType) left.value_type;

			if (right.value_type == null || !right.value_type.compatible (array_type.element_type)) {
				error = true;
				Report.error (source_reference, "Incompatible operand");
				return false;
			}

			right.target_type = array_type.element_type.copy ();

			value_type = array_type.copy ();
			value_type.value_owned = true;
		} else if (operator == BinaryOperator.PLUS
			   || operator == BinaryOperator.MINUS
			   || operator == BinaryOperator.MUL
			   || operator == BinaryOperator.DIV) {
			// check for pointer arithmetic
			if (left.value_type is PointerType) {
				var pointer_type = (PointerType) left.value_type;
				if (pointer_type.base_type is VoidType) {
					error = true;
					Report.error (source_reference, "Pointer arithmetic not supported for `void*'");
					return false;
				}

				var offset_type = right.value_type.data_type as Struct;
				if (offset_type != null && offset_type.is_integer_type ()) {
					if (operator == BinaryOperator.PLUS
					    || operator == BinaryOperator.MINUS) {
						// pointer arithmetic: pointer +/- offset
						value_type = left.value_type.copy ();
					}
				} else if (right.value_type is PointerType) {
					// pointer arithmetic: pointer - pointer
					if (context.profile == Profile.DOVA) {
						value_type = context.analyzer.long_type;
					} else {
						value_type = context.analyzer.size_t_type;
					}
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
		} else if (operator == BinaryOperator.MOD
			   || operator == BinaryOperator.SHIFT_LEFT
			   || operator == BinaryOperator.SHIFT_RIGHT
			   || operator == BinaryOperator.BITWISE_XOR) {
			left.target_type.nullable = false;
			right.target_type.nullable = false;

			value_type = context.analyzer.get_arithmetic_result_type (left.target_type, right.target_type);

			if (value_type == null) {
				error = true;
				Report.error (source_reference, "Arithmetic operation not supported for types `%s' and `%s'".printf (left.value_type.to_string (), right.value_type.to_string ()));
				return false;
			}
		} else if (operator == BinaryOperator.LESS_THAN
			   || operator == BinaryOperator.GREATER_THAN
			   || operator == BinaryOperator.LESS_THAN_OR_EQUAL
			   || operator == BinaryOperator.GREATER_THAN_OR_EQUAL) {
			if (left.value_type.compatible (context.analyzer.string_type)
			    && right.value_type.compatible (context.analyzer.string_type)) {
				// string comparison
				} else if (left.value_type is PointerType && right.value_type is PointerType) {
					// pointer arithmetic
			} else {
				DataType resulting_type;

				if (chained) {
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

				if (!chained) {
					left.target_type = resulting_type.copy ();
				}
				right.target_type = resulting_type.copy ();
				left.target_type.nullable = false;
				right.target_type.nullable = false;
			}

			value_type = context.analyzer.bool_type;
		} else if (operator == BinaryOperator.EQUALITY
			   || operator == BinaryOperator.INEQUALITY) {
			/* relational operation */

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
				// if only one operand is nullable, make sure the other operand is promoted to nullable as well
				if (!left.value_type.nullable) {
					left.target_type.nullable = true;
				} else if (!right.value_type.nullable) {
					right.target_type.nullable = true;
				}
			}

			if (left.value_type.compatible (context.analyzer.string_type)
			    && right.value_type.compatible (context.analyzer.string_type)) {
				// string comparison
				if (context.profile == Profile.DOVA) {
					var string_ma = new MemberAccess.simple ("string", source_reference);
					string_ma.qualified = true;
					var equals_call = new MethodCall (new MemberAccess (string_ma, "equals", source_reference), source_reference);
					equals_call.add_argument (left);
					equals_call.add_argument (right);
					if (operator == BinaryOperator.EQUALITY) {
						parent_node.replace_expression (this, equals_call);
						return equals_call.check (context);
					} else {
						var not = new UnaryExpression (UnaryOperator.LOGICAL_NEGATION, equals_call, source_reference);
						parent_node.replace_expression (this, not);
						return not.check (context);
					}
				}
			}

			value_type = context.analyzer.bool_type;
		} else if (operator == BinaryOperator.BITWISE_AND
			   || operator == BinaryOperator.BITWISE_OR) {
			// integer type or flags type
			left.target_type.nullable = false;
			right.target_type.nullable = false;

			value_type = left.target_type.copy ();
		} else if (operator == BinaryOperator.AND
			   || operator == BinaryOperator.OR) {
			if (!left.value_type.compatible (context.analyzer.bool_type) || !right.value_type.compatible (context.analyzer.bool_type)) {
				error = true;
				Report.error (source_reference, "Operands must be boolean");
			}
			left.target_type.nullable = false;
			right.target_type.nullable = false;

			value_type = context.analyzer.bool_type;
		} else if (operator == BinaryOperator.IN) {
			if (left.value_type.compatible (context.analyzer.int_type)
			    && right.value_type.compatible (context.analyzer.int_type)) {
				// integers or enums
				left.target_type.nullable = false;
				right.target_type.nullable = false;
			} else if (right.value_type is ArrayType) {
				if (!left.value_type.compatible (((ArrayType) right.value_type).element_type)) {
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
			
		} else {
			assert_not_reached ();
		}

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
	COALESCE
}
