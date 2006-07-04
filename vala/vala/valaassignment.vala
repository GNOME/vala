/* valaassignment.vala
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
 * Represents an assignment expression in the source code.
 */
public class Vala.Assignment : Expression {
	/**
	 * Left hand side of the assignment.
	 */
	public Expression! left { get; set construct; }
	
	/**
	 * Assignment operator.
	 */
	public AssignmentOperator operator { get; set; }
	
	/**
	 * Right hand side of the assignment.
	 */
	public Expression! right { get; set construct; }
	
	/**
	 * Creates a new assignment.
	 *
	 * @param left left hand side
	 * @param op assignment operator
	 * @param right right hand side
	 * @param source reference to source code
	 * @return newly created assignment
	 */
	public static ref Assignment! new (Expression! left, AssignmentOperator op, Expression! right, SourceReference source) {
		return (new Assignment (left = left, operator = op, right = right, source_reference = source));
	}
	
	public override void accept (CodeVisitor! visitor) {
		left.accept (visitor);
		right.accept (visitor);

		visitor.visit_assignment (this);
	}
}
	
public enum Vala.AssignmentOperator {
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
