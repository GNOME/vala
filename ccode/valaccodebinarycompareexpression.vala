/* valaccodebinarycompareexpression.vala
 *
 * Copyright (C) 2022  Rico Tzschichholz
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
 * 	Rico Tzschichholz <ricotz@ubuntu.com>
 */

/**
 * Represents an expression comparing two operands checking against a non-boolean result in C code.
 */
public class Vala.CCodeBinaryCompareExpression : CCodeBinaryExpression {
	/**
	 * The compare function.
	 */
	public CCodeExpression call { get; set; }

	/**
	 * The expected result.
	 */
	public CCodeExpression result { get; set; }

	public CCodeBinaryCompareExpression (CCodeExpression cmp, CCodeBinaryOperator op, CCodeExpression l, CCodeExpression r, CCodeExpression res) {
		base (op, l, r);
		call = cmp;
		result = res;
	}

	public override void write (CCodeWriter writer) {
		call.write_inner (writer);
		writer.write_string (" (");
		left.write (writer);
		writer.write_string (", ");
		right.write (writer);
		writer.write_string (")");

		switch (operator) {
		case CCodeBinaryOperator.LESS_THAN: writer.write_string (" < "); break;
		case CCodeBinaryOperator.GREATER_THAN: writer.write_string (" > "); break;
		case CCodeBinaryOperator.LESS_THAN_OR_EQUAL: writer.write_string (" <= "); break;
		case CCodeBinaryOperator.GREATER_THAN_OR_EQUAL: writer.write_string (" >= "); break;
		case CCodeBinaryOperator.EQUALITY: writer.write_string (" == "); break;
		case CCodeBinaryOperator.INEQUALITY: writer.write_string (" != "); break;
		default: assert_not_reached ();
		}

		result.write_inner (writer);
	}
}
