/* valaccodebinaryexpression.vala
 *
 * Copyright (C) 2006-2008  Jürg Billeter
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

using GLib;

/**
 * Represents an expression with two operands in C code.
 */
public class Vala.CCodeBinaryExpression : CCodeExpression {
	/**
	 * The binary operator.
	 */
	public CCodeBinaryOperator operator { get; set; }

	/**
	 * The left operand.
	 */
	public CCodeExpression left { get; set; }

	/**
	 * The right operand.
	 */
	public CCodeExpression right { get; set; }
	
	public CCodeBinaryExpression (CCodeBinaryOperator op, CCodeExpression l, CCodeExpression r) {
		operator = op;
		left = l;
		right = r;
	}
	
	public override void write (CCodeWriter writer) {
		left.write_inner (writer);

		writer.write_string (" ");
		if (operator == CCodeBinaryOperator.PLUS) {
			writer.write_string ("+");
		} else if (operator == CCodeBinaryOperator.MINUS) {
			writer.write_string ("-");
		} else if (operator == CCodeBinaryOperator.MUL) {
			writer.write_string ("*");
		} else if (operator == CCodeBinaryOperator.DIV) {
			writer.write_string ("/");
		} else if (operator == CCodeBinaryOperator.MOD) {
			writer.write_string ("%");
		} else if (operator == CCodeBinaryOperator.SHIFT_LEFT) {
			writer.write_string ("<<");
		} else if (operator == CCodeBinaryOperator.SHIFT_RIGHT) {
			writer.write_string (">>");
		} else if (operator == CCodeBinaryOperator.LESS_THAN) {
			writer.write_string ("<");
		} else if (operator == CCodeBinaryOperator.GREATER_THAN) {
			writer.write_string (">");
		} else if (operator == CCodeBinaryOperator.LESS_THAN_OR_EQUAL) {
			writer.write_string ("<=");
		} else if (operator == CCodeBinaryOperator.GREATER_THAN_OR_EQUAL) {
			writer.write_string (">=");
		} else if (operator == CCodeBinaryOperator.EQUALITY) {
			writer.write_string ("==");
		} else if (operator == CCodeBinaryOperator.INEQUALITY) {
			writer.write_string ("!=");
		} else if (operator == CCodeBinaryOperator.BITWISE_AND) {
			writer.write_string ("&");
		} else if (operator == CCodeBinaryOperator.BITWISE_OR) {
			writer.write_string ("|");
		} else if (operator == CCodeBinaryOperator.BITWISE_XOR) {
			writer.write_string ("^");
		} else if (operator == CCodeBinaryOperator.AND) {
			writer.write_string ("&&");
		} else if (operator == CCodeBinaryOperator.OR) {
			writer.write_string ("||");
		}

		writer.write_string (" ");

		right.write_inner (writer);
	}

	public override void write_inner (CCodeWriter writer) {
		writer.write_string ("(");
		this.write (writer);
		writer.write_string (")");
	}
}

public enum Vala.CCodeBinaryOperator {
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
