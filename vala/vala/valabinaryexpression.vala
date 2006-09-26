/* valabinaryexpression.vala
 *
 * Copyright (C) 2006  Jürg Billeter
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public
 * License as published by the Free Software Foundation; either
 * version 2 of the License, or (at your option) any later version.

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

using GLib;

/**
 * Represents an expression with two operands in the source code.
 *
 * Supports +, -, *, /, %, <<, >>, <, >, <=, >=, ==, !=, &, |, ^, &&, ||.
 */
public class Vala.BinaryExpression : Expression {
	/**
	 * The binary operator.
	 */
	public BinaryOperator operator { get; set; }
	
	/**
	 * The left operand.
	 */
	public Expression! left {
		get {
			return _left;
		}
		set construct {
			_left = value;
			_left.parent_node = this;
		}
	}
	
	/**
	 * The right operand.
	 */
	public Expression! right {
		get {
			return _right;
		}
		set construct {
			_right = value;
			_right.parent_node = this;
		}
	}
	
	private Expression! _left;
	private Expression! _right;
	
	/**
	 * Creates a new binary expression.
	 *
	 * @param op     binary operator
	 * @param left   left operand
	 * @param right  right operand
	 * @param source reference to source code
	 * @return       newly created binary expression
	 */
	public construct (BinaryOperator op, Expression! _left, Expression! _right, SourceReference source) {
		operator = op;
		left = _left;
		right = _right;
		source_reference = source;
	}
	
	public override void accept (CodeVisitor! visitor) {
		left.accept (visitor);
		right.accept (visitor);			

		visitor.visit_binary_expression (this);
	}

	public override void replace (CodeNode! old_node, CodeNode! new_node) {
		if (left == old_node) {
			left = (Expression) new_node;
		}
		if (right == old_node) {
			right = (Expression) new_node;
		}
	}
}

public enum Vala.BinaryOperator {
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
	OR
}
