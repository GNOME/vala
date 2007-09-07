/* valaconditionalexpression.vala
 *
 * Copyright (C) 2006  Jürg Billeter
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
 * Represents a conditional expression in the source code.
 */
public class Vala.ConditionalExpression : Expression {
	/**
	 * The condition.
	 */
	public Expression! condition { get; set construct; }
	
	/**
	 * The expression to be evaluated if the condition holds.
	 */
	public Expression! true_expression { get; set construct; }

	/**
	 * The expression to be evaluated if the condition doesn't hold.
	 */
	public Expression! false_expression { get; set construct; }
	
	/**
	 * Creates a new conditional expression.
	 *
	 * @param cond       a condition
	 * @param true_expr  expression to be evaluated if condition is true
	 * @param false_expr expression to be evaluated if condition is false
	 * @return           newly created conditional expression
	 */
	public ConditionalExpression (Expression! cond, Expression! true_expr, Expression! false_expr, SourceReference source) {
		condition = cond;
		true_expression = true_expr;
		false_expression = false_expr;
		source_reference = source;
	}
	
	public override void accept (CodeVisitor! visitor) {
		condition.accept (visitor);
		true_expression.accept (visitor);
		false_expression.accept (visitor);			

		visitor.visit_conditional_expression (this);
	}
}
