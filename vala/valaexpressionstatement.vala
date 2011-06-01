/* valaexpressionstatement.vala
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


/**
 * A code statement that evaluates a given expression. The value computed by the
 * expression, if any, is discarded.
 */
public class Vala.ExpressionStatement : CodeNode, Statement {
	/**
	 * Specifies the expression to evaluate.
	 */
	public Expression expression {
		get {
			return _expression;
		}
		set {
			_expression = value;
			_expression.parent_node = this;
		}
	}

	private Expression _expression;

	/**
	 * Creates a new expression statement.
	 *
	 * @param expr   expression to evaluate
	 * @param source reference to source code
	 * @return       newly created expression statement
	 */
	public ExpressionStatement (Expression expression, SourceReference? source_reference = null) {
		this.source_reference = source_reference;
		this.expression = expression;
	}

	public override void accept (CodeVisitor visitor) {
		visitor.visit_expression_statement (this);
	}

	public override void accept_children (CodeVisitor visitor) {
		expression.accept (visitor);
	}

	public override void replace_expression (Expression old_node, Expression new_node) {
		if (expression == old_node) {
			expression = new_node;
		}
	}

	public override bool check (CodeContext context) {
		if (checked) {
			return !error;
		}

		checked = true;

		if (!expression.check (context)) {
			// ignore inner error
			error = true;
			return false;
		}

		add_error_types (expression.get_error_types ());

		return !error;
	}

	public override void emit (CodeGenerator codegen) {
		expression.emit (codegen);

		codegen.visit_expression_statement (this);
	}

	public override void get_defined_variables (Collection<Variable> collection) {
		expression.get_defined_variables (collection);
	}

	public override void get_used_variables (Collection<Variable> collection) {
		expression.get_used_variables (collection);
	}
}
