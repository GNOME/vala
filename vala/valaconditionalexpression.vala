/* valaconditionalexpression.vala
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
 * Represents a conditional expression in the source code.
 */
public class Vala.ConditionalExpression : Expression {
	/**
	 * The condition.
	 */
	public Expression condition { get; set; }
	
	/**
	 * The expression to be evaluated if the condition holds.
	 */
	public Expression true_expression { get; set; }

	/**
	 * The expression to be evaluated if the condition doesn't hold.
	 */
	public Expression false_expression { get; set; }
	
	/**
	 * Creates a new conditional expression.
	 *
	 * @param cond       a condition
	 * @param true_expr  expression to be evaluated if condition is true
	 * @param false_expr expression to be evaluated if condition is false
	 * @return           newly created conditional expression
	 */
	public ConditionalExpression (Expression cond, Expression true_expr, Expression false_expr, SourceReference source) {
		condition = cond;
		true_expression = true_expr;
		false_expression = false_expr;
		source_reference = source;
	}
	
	public override void accept (CodeVisitor visitor) {
		condition.accept (visitor);
		true_expression.accept (visitor);
		false_expression.accept (visitor);			

		visitor.visit_conditional_expression (this);

		visitor.visit_expression (this);
	}

	public override bool is_pure () {
		return condition.is_pure () && true_expression.is_pure () && false_expression.is_pure ();
	}

	public override bool check (SemanticAnalyzer analyzer) {
		if (checked) {
			return !error;
		}

		checked = true;

		if (condition.error || false_expression.error || true_expression.error) {
			return false;
		}

		if (!condition.value_type.compatible (analyzer.bool_type)) {
			error = true;
			Report.error (condition.source_reference, "Condition must be boolean");
			return false;
		}

		/* FIXME: support memory management */
		if (false_expression.value_type.compatible (true_expression.value_type)) {
			value_type = true_expression.value_type.copy ();
		} else if (true_expression.value_type.compatible (false_expression.value_type)) {
			value_type = false_expression.value_type.copy ();
		} else {
			error = true;
			Report.error (condition.source_reference, "Incompatible expressions");
			return false;
		}

		return !error;
	}
}
