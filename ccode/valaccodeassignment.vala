/* valaccodeassignment.vala
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
 * Represents an assignment expression in the C code.
 */
public class Vala.CCodeAssignment : CCodeExpression {
	/**
	 * Left hand side of the assignment.
	 */
	public CCodeExpression left { get; set; }

	/**
	 * Assignment operator.
	 */
	public CCodeAssignmentOperator operator { get; set; }

	/**
	 * Right hand side of the assignment.
	 */
	public CCodeExpression right { get; set; }

	public CCodeAssignment (CCodeExpression l, CCodeExpression r, CCodeAssignmentOperator op = CCodeAssignmentOperator.SIMPLE) {
		left = l;
		operator = op;
		right = r;
	}

	public override void write (CCodeWriter writer) {
		left.write (writer);

		switch (operator) {
		case CCodeAssignmentOperator.SIMPLE: writer.write_string (" = "); break;
		case CCodeAssignmentOperator.BITWISE_OR: writer.write_string (" |= "); break;
		case CCodeAssignmentOperator.BITWISE_AND: writer.write_string (" &= "); break;
		case CCodeAssignmentOperator.BITWISE_XOR: writer.write_string (" ^= "); break;
		case CCodeAssignmentOperator.ADD: writer.write_string (" += "); break;
		case CCodeAssignmentOperator.SUB: writer.write_string (" -= "); break;
		case CCodeAssignmentOperator.MUL: writer.write_string (" *= "); break;
		case CCodeAssignmentOperator.DIV: writer.write_string (" /= "); break;
		case CCodeAssignmentOperator.PERCENT: writer.write_string (" %= "); break;
		case CCodeAssignmentOperator.SHIFT_LEFT: writer.write_string (" <<= "); break;
		case CCodeAssignmentOperator.SHIFT_RIGHT: writer.write_string (" >>= "); break;
		default: assert_not_reached ();
		}

		right.write (writer);
	}

	public override void write_inner (CCodeWriter writer) {
		writer.write_string ("(");
		this.write (writer);
		writer.write_string (")");
	}
}

public enum Vala.CCodeAssignmentOperator {
	SIMPLE,
	BITWISE_OR,
	BITWISE_AND,
	BITWISE_XOR,
	ADD,
	SUB,
	MUL,
	DIV,
	PERCENT,
	SHIFT_LEFT,
	SHIFT_RIGHT
}
