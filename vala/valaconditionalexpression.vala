/* valaconditionalexpression.vala
 *
 * Copyright (C) 2006-2011  Jürg Billeter
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
	public Expression condition {
		get {
			return _condition;
		}
		private set {
			_condition = value;
			_condition.parent_node = this;
		}
	}

	/**
	 * The expression to be evaluated if the condition holds.
	 */
	public Expression true_expression {
		get {
			return _true_expression;
		}
		private set {
			_true_expression = value;
			_true_expression.parent_node = this;
		}
	}

	/**
	 * The expression to be evaluated if the condition doesn't hold.
	 */
	public Expression false_expression {
		get {
			return _false_expression;
		}
		private set {
			_false_expression = value;
			_false_expression.parent_node = this;
		}
	}

	Expression _condition;
	Expression _true_expression;
	Expression _false_expression;

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
		visitor.visit_conditional_expression (this);

		visitor.visit_expression (this);
	}

	public override void accept_children (CodeVisitor visitor) {
		condition.accept (visitor);
		true_expression.accept (visitor);
		false_expression.accept (visitor);
	}

	public override bool is_pure () {
		return condition.is_pure () && true_expression.is_pure () && false_expression.is_pure ();
	}

	public override bool is_accessible (Symbol sym) {
		return condition.is_accessible (sym) && true_expression.is_accessible (sym) && false_expression.is_accessible (sym);
	}

	public override void get_error_types (Collection<DataType> collection, SourceReference? source_reference = null) {
		condition.get_error_types (collection, source_reference);
		true_expression.get_error_types (collection, source_reference);
		false_expression.get_error_types (collection, source_reference);
	}

	public override string to_string () {
		return "(%s ? %s : %s)".printf (condition.to_string (), true_expression.to_string (), false_expression.to_string ());
	}

	public override void replace_expression (Expression old_node, Expression new_node) {
		if (condition == old_node) {
			condition = new_node;
		}
		if (true_expression == old_node) {
			true_expression = new_node;
		}
		if (false_expression == old_node) {
			false_expression = new_node;
		}
	}

	public override void get_defined_variables (Collection<Variable> collection) {
		condition.get_defined_variables (collection);
		true_expression.get_defined_variables (collection);
		false_expression.get_defined_variables (collection);
	}

	public override void get_used_variables (Collection<Variable> collection) {
		condition.get_used_variables (collection);
		true_expression.get_used_variables (collection);
		false_expression.get_used_variables (collection);
	}

	public override bool check (CodeContext context) {
		if (checked) {
			return !error;
		}

		checked = true;

		if (!(context.analyzer.get_current_non_local_symbol (this) is Block)) {
			Report.error (source_reference, "Conditional expressions may only be used in blocks");
			error = true;
			return false;
		}

		true_expression.target_type = target_type;
		false_expression.target_type = target_type;

		if (!condition.check (context) || !true_expression.check (context) || !false_expression.check (context)) {
			error = true;
			return false;
		}

		if (false_expression.value_type.compatible (true_expression.value_type)) {
			value_type = true_expression.value_type.copy ();
		} else if (true_expression.value_type.compatible (false_expression.value_type)) {
			value_type = false_expression.value_type.copy ();
		} else {
			error = true;
			Report.error (condition.source_reference, "Incompatible expressions");
			return false;
		}

		value_type.value_owned = (true_expression.value_type.value_owned || false_expression.value_type.value_owned);
		value_type.floating_reference = false;
		value_type.check (context);

		true_expression.target_type = value_type;
		false_expression.target_type = value_type;

		return true;
	}
}
