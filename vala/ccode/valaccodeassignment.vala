/* valaccodeassignment.vala
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
 * Represents an assignment expression in the C code.
 */
public class Vala.CCodeAssignment : CCodeExpression {
	/**
	 * Left hand side of the assignment.
	 */
	public CCodeExpression left { get; construct; }
	
	/**
	 * Assignment operator.
	 */
	public CCodeAssignmentOperator operator { get; set; }

	/**
	 * Right hand side of the assignment.
	 */
	public CCodeExpression right { get; construct; }
	
	public override void write (CCodeWriter! writer) {
		if (left != null) {
			left.write (writer);
		}
		writer.write_string (" ");
		
		if (operator == CCodeAssignmentOperator.BITWISE_OR) {
			writer.write_string ("|");
		} else if (operator == CCodeAssignmentOperator.BITWISE_AND) {
			writer.write_string ("&");
		} else if (operator == CCodeAssignmentOperator.BITWISE_XOR) {
			writer.write_string ("^");
		} else if (operator == CCodeAssignmentOperator.ADD) {
			writer.write_string ("+");
		} else if (operator == CCodeAssignmentOperator.SUB) {
			writer.write_string ("-");
		} else if (operator == CCodeAssignmentOperator.MUL) {
			writer.write_string ("*");
		} else if (operator == CCodeAssignmentOperator.DIV) {
			writer.write_string ("/");
		} else if (operator == CCodeAssignmentOperator.PERCENT) {
			writer.write_string ("%");
		} else if (operator == CCodeAssignmentOperator.SHIFT_LEFT) {
			writer.write_string ("<<");
		} else if (operator == CCodeAssignmentOperator.SHIFT_RIGHT) {
			writer.write_string (">>");
		}
		
		writer.write_string ("= ");
		if (right != null) {
			right.write (writer);
		}
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
