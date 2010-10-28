/* valaifstatement.vala
 *
 * Copyright (C) 2006-2010  Jürg Billeter
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
 * Represents an if selection statement in the source code.
 */
public class Vala.IfStatement : CodeNode, Statement {
	/**
	 * The boolean condition to evaluate.
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
	 * The statement to be evaluated if the condition holds.
	 */
	public Block true_statement {
		get { return _true_statement; }
		set {
			_true_statement = value;
			_true_statement.parent_node = this;
		}
	}
	
	/**
	 * The optional statement to be evaluated if the condition doesn't hold.
	 */
	public Block? false_statement {
		get { return _false_statement; }
		set {
			_false_statement = value;
			if (_false_statement != null)
				_false_statement.parent_node = this;
		}
	}

	private Expression _condition;
	private Block _true_statement;
	private Block _false_statement;

	/**
	 * Creates a new if statement.
	 *
	 * @param cond       a boolean condition
	 * @param true_stmt  statement to be evaluated if condition is true
	 * @param false_stmt statement to be evaluated if condition is false
	 * @return           newly created if statement
	 */
	public IfStatement (Expression cond, Block true_stmt, Block? false_stmt, SourceReference? source) {
		condition = cond;
		true_statement = true_stmt;
		false_statement = false_stmt;
		source_reference = source;
	}
	
	public override void accept (CodeVisitor visitor) {
		visitor.visit_if_statement (this);
	}

	public override void accept_children (CodeVisitor visitor) {
		condition.accept (visitor);
		
		visitor.visit_end_full_expression (condition);
		
		true_statement.accept (visitor);
		if (false_statement != null) {
			false_statement.accept (visitor);
		}
	}

	public override void replace_expression (Expression old_node, Expression new_node) {
		if (condition == old_node) {
			condition = new_node;
		}
	}

	public override bool check (CodeContext context) {
		if (checked) {
			return !error;
		}

		checked = true;

		condition.target_type = context.analyzer.bool_type.copy ();

		condition.check (context);

		true_statement.check (context);
		if (false_statement != null) {
			false_statement.check (context);
		}

		if (condition.error) {
			/* if there was an error in the condition, skip this check */
			error = true;
			return false;
		}

		if (condition.value_type == null || !condition.value_type.compatible (context.analyzer.bool_type)) {
			error = true;
			Report.error (condition.source_reference, "Condition must be boolean");
			return false;
		}

		add_error_types (condition.get_error_types ());
		add_error_types (true_statement.get_error_types ());

		if (false_statement != null) {
			add_error_types (false_statement.get_error_types ());
		}

		return !error;
	}

	public override void emit (CodeGenerator codegen) {
		condition.emit (codegen);

		codegen.visit_end_full_expression (condition);

		codegen.visit_if_statement (this);
	}
}
