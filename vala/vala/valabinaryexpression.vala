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
 */
public class Vala.BinaryExpression : Expression {
	/**
	 * The binary operator.
	 */
	public BinaryOperator operator { get; set; }
	
	/**
	 * The left operand.
	 */
	public Expression! left { get; set construct; }
	
	/**
	 * The right operand.
	 */
	public Expression! right { get; set construct; }
	
	/**
	 * Creates a new binary expression.
	 *
	 * @param op binary operator
	 * @param left left operand
	 * @param right right operand
	 * @param source reference to source code
	 * @return newly created binary expression
	 */
	public static ref BinaryExpression! new (BinaryOperator op, Expression! left, Expression! right, SourceReference source) {
		return (new BinaryExpression (operator = op, left = left, right = right, source_reference = source));
	}
	
	public override void accept (CodeVisitor! visitor) {
		left.accept (visitor);
		right.accept (visitor);			

		visitor.visit_binary_expression (this);
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
