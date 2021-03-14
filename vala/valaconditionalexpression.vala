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
	public ConditionalExpression (Expression cond, Expression true_expr, Expression false_expr, SourceReference? source = null) {
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

		if (!(context.analyzer.current_symbol is Block)) {
			Report.error (source_reference, "Conditional expressions may only be used in blocks");
			error = true;
			return false;
		}

		// convert ternary expression into if statement
		// required for flow analysis and exception handling

		string temp_name = get_temp_name ();

		true_expression.target_type = target_type;
		false_expression.target_type = target_type;

		var local = new LocalVariable (null, temp_name, null, source_reference);
		var decl = new DeclarationStatement (local, source_reference);

		var true_local = new LocalVariable (null, temp_name, true_expression, true_expression.source_reference);
		var true_block = new Block (true_expression.source_reference);
		var true_decl = new DeclarationStatement (true_local, true_expression.source_reference);
		true_block.add_statement (true_decl);

		var false_local = new LocalVariable (null, temp_name, false_expression, false_expression.source_reference);
		var false_block = new Block (false_expression.source_reference);
		var false_decl = new DeclarationStatement (false_local, false_expression.source_reference);
		false_block.add_statement (false_decl);

		var if_stmt = new IfStatement (condition, true_block, false_block, source_reference);

		insert_statement (context.analyzer.insert_block, decl);
		insert_statement (context.analyzer.insert_block, if_stmt);

		if (!if_stmt.check (context) || true_expression.error || false_expression.error) {
			error = true;
			return false;
		}

		true_expression = true_local.initializer;
		false_expression = false_local.initializer;

		true_block.remove_local_variable (true_local);
		false_block.remove_local_variable (false_local);

		if (false_expression.value_type.compatible (true_expression.value_type)) {
			value_type = true_expression.value_type.copy ();
		} else if (true_expression.value_type.compatible (false_expression.value_type)) {
			value_type = false_expression.value_type.copy ();
		} else {
			error = true;
			var source_reference = new SourceReference (true_expression.source_reference.file, true_expression.source_reference.begin, false_expression.source_reference.end);
			Report.error (source_reference, "Cannot resolve target type from `%s' and `%s'", true_expression.value_type.to_prototype_string (), false_expression.value_type.to_prototype_string ());
			return false;
		}

		value_type.value_owned = (true_expression.value_type.value_owned || false_expression.value_type.value_owned);
		value_type.floating_reference = false;
		value_type.check (context);

		local.variable_type = value_type;
		decl.check (context);

		true_expression.target_type = value_type;
		false_expression.target_type = value_type;

		var true_stmt = new ExpressionStatement (new Assignment (new MemberAccess.simple (local.name, true_expression.source_reference), true_expression, AssignmentOperator.SIMPLE, true_expression.source_reference), true_expression.source_reference);

		var false_stmt = new ExpressionStatement (new Assignment (new MemberAccess.simple (local.name, false_expression.source_reference), false_expression, AssignmentOperator.SIMPLE, false_expression.source_reference), false_expression.source_reference);

		true_block.replace_statement (true_decl, true_stmt);
		false_block.replace_statement (false_decl, false_stmt);
		true_stmt.check (context);
		false_stmt.check (context);

		var ma = new MemberAccess.simple (local.name, source_reference);
		ma.formal_target_type = formal_target_type;
		ma.target_type = target_type;

		parent_node.replace_expression (this, ma);
		ma.check (context);

		return true;
	}
}
