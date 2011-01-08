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
		set {
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
		set {
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
		set {
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
			Report.error (condition.source_reference, "Incompatible expressions");
			return false;
		}

		value_type.value_owned = (true_expression.value_type.value_owned || false_expression.value_type.value_owned);

		local.variable_type = value_type;
		decl.check (context);

		true_expression.target_type = value_type;
		false_expression.target_type = value_type;

		var true_stmt = new ExpressionStatement (new Assignment (new MemberAccess.simple (local.name, true_expression.source_reference), true_expression, AssignmentOperator.SIMPLE, true_expression.source_reference), true_expression.source_reference);
		true_stmt.check (context);

		var false_stmt = new ExpressionStatement (new Assignment (new MemberAccess.simple (local.name, false_expression.source_reference), false_expression, AssignmentOperator.SIMPLE, false_expression.source_reference), false_expression.source_reference);
		false_stmt.check (context);

		true_block.replace_statement (true_decl, true_stmt);
		false_block.replace_statement (false_decl, false_stmt);

		var ma = new MemberAccess.simple (local.name, source_reference);
		ma.formal_target_type = formal_target_type;
		ma.target_type = target_type;
		ma.check (context);

		parent_node.replace_expression (this, ma);

		return true;
	}
}
