/* valaccodeunaryexpression.vala
 *
 * Copyright (C) 2006-2009  Jürg Billeter
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
 * Represents an expression with one operand in the C code.
 */
public class Vala.CCodeUnaryExpression : CCodeExpression {
	/**
	 * The unary operator.
	 */
	public CCodeUnaryOperator operator { get; set; }
	
	/**
	 * The operand.
	 */
	public CCodeExpression inner { get; set; }
	
	public CCodeUnaryExpression (CCodeUnaryOperator op, CCodeExpression expr) {
		operator = op;
		inner = expr;
	}
	
	public override void write (CCodeWriter writer) {
		if (operator == CCodeUnaryOperator.PLUS) {
			writer.write_string ("+");
		} else if (operator == CCodeUnaryOperator.MINUS) {
			writer.write_string ("-");
		} else if (operator == CCodeUnaryOperator.LOGICAL_NEGATION) {
			writer.write_string ("!");
		} else if (operator == CCodeUnaryOperator.BITWISE_COMPLEMENT) {
			writer.write_string ("~");
		} else if (operator == CCodeUnaryOperator.POINTER_INDIRECTION) {
			var inner_unary = inner as CCodeUnaryExpression;
			if (inner_unary != null && inner_unary.operator == CCodeUnaryOperator.ADDRESS_OF) {
				// simplify expression
				inner_unary.inner.write (writer);
				return;
			}
			writer.write_string ("*");
		} else if (operator == CCodeUnaryOperator.ADDRESS_OF) {
			var inner_unary = inner as CCodeUnaryExpression;
			if (inner_unary != null && inner_unary.operator == CCodeUnaryOperator.POINTER_INDIRECTION) {
				// simplify expression
				inner_unary.inner.write (writer);
				return;
			}
			writer.write_string ("&");
		} else if (operator == CCodeUnaryOperator.PREFIX_INCREMENT) {
			writer.write_string ("++");
		} else if (operator == CCodeUnaryOperator.PREFIX_DECREMENT) {
			writer.write_string ("--");
		}

		inner.write_inner (writer);

		if (operator == CCodeUnaryOperator.POSTFIX_INCREMENT) {
			writer.write_string ("++");
		} else if (operator == CCodeUnaryOperator.POSTFIX_DECREMENT) {
			writer.write_string ("--");
		}
	}

	public override void write_inner (CCodeWriter writer) {
		writer.write_string ("(");
		this.write (writer);
		writer.write_string (")");
	}
}

public enum Vala.CCodeUnaryOperator {
	PLUS,
	MINUS,
	LOGICAL_NEGATION,
	BITWISE_COMPLEMENT,
	POINTER_INDIRECTION,
	ADDRESS_OF,
	PREFIX_INCREMENT,
	PREFIX_DECREMENT,
	POSTFIX_INCREMENT,
	POSTFIX_DECREMENT
}
