/* valaexpressionstatement.vala
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
 * A code statement that evaluates a given expression. The value computed by the
 * expression, if any, is discarded.
 */
public class Vala.ExpressionStatement : Statement {
	/**
	 * Specifies the expression to evaluate.
	 */
	public Expression! expression { get; set construct; }

	/**
	 * Creates a new expression statement.
	 *
	 * @param expr   expression to evaluate
	 * @param source reference to source code
	 * @return       newly created expression statement
	 */
	public static ref ExpressionStatement! new (Expression! expr, SourceReference source) {
		return (new ExpressionStatement (expression = expr, source_reference = source));
	}
	
	public override void accept (CodeVisitor! visitor) {
		expression.accept (visitor);

		visitor.visit_expression_statement (this);
	}
}
