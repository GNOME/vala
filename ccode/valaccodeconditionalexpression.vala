/* valaccodeconditionalexpression.vala
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
 * Represents a conditional expression in C code.
 */
public class Vala.CCodeConditionalExpression : CCodeExpression {
	/**
	 * The condition.
	 */
	public CCodeExpression condition { get; set; }
	
	/**
	 * The expression to be evaluated if the condition holds.
	 */
	public CCodeExpression true_expression { get; set; }
	
	/**
	 * The expression to be evaluated if the condition doesn't hold.
	 */
	public CCodeExpression false_expression { get; set; }
	
	public CCodeConditionalExpression (CCodeExpression cond, CCodeExpression true_expr, CCodeExpression false_expr) {
		condition = cond;
		true_expression = true_expr;
		false_expression = false_expr;
	}
	
	public override void write (CCodeWriter writer) {
		condition.write_inner (writer);
		writer.write_string (" ? ");
		true_expression.write_inner (writer);
		writer.write_string (" : ");
		false_expression.write_inner (writer);
	}

	public override void write_inner (CCodeWriter writer) {
		writer.write_string ("(");
		this.write (writer);
		writer.write_string (")");
	}
}
