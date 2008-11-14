/* valareturnstatement.vala
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

using Gee;

/**
 * Represents a return statement in the source code.
 */
public class Vala.ReturnStatement : CodeNode, Statement {
	/**
	 * The optional expression to return.
	 */
	public Expression? return_expression {
		get { return _return_expression; }
		set {
			_return_expression = value;
			if (_return_expression != null) {
				_return_expression.parent_node = this;
			}
		}
	}

	private Expression _return_expression;

	/**
	 * Creates a new return statement.
	 *
	 * @param return_expression the return expression
	 * @param source_reference  reference to source code
	 * @return                  newly created return statement
	 */
	public ReturnStatement (Expression? return_expression = null, SourceReference? source_reference = null) {
		this.source_reference = source_reference;
		this.return_expression = return_expression;
	}

	public override void accept (CodeVisitor visitor) {
		visitor.visit_return_statement (this);
	}

	public override void accept_children (CodeVisitor visitor) {
		if (return_expression != null) {
			return_expression.accept (visitor);
		
			visitor.visit_end_full_expression (return_expression);
		}
	}

	public override void replace_expression (Expression old_node, Expression new_node) {
		if (return_expression == old_node) {
			return_expression = new_node;
		}
	}

	public override bool check (SemanticAnalyzer analyzer) {
		if (checked) {
			return !error;
		}

		checked = true;

		if (return_expression != null) {
			return_expression.target_type = analyzer.current_return_type;
		}

		if (return_expression != null && !return_expression.check (analyzer)) {
			// ignore inner error
			error = true;
			return false;
		}

		if (analyzer.current_return_type == null) {
			error = true;
			Report.error (source_reference, "Return not allowed in this context");
			return false;
		}

		if (return_expression == null) {
			if (!(analyzer.current_return_type is VoidType)) {
				error = true;
				Report.error (source_reference, "Return without value in non-void function");
			}
			return !error;
		}

		if (analyzer.current_return_type is VoidType) {
			Report.error (source_reference, "Return with value in void function");
			return false;
		}

		if (return_expression.value_type == null) {
			error = true;
			Report.error (source_reference, "Invalid expression in return value");
			return false;
		}

		if (!return_expression.value_type.compatible (analyzer.current_return_type)) {
			error = true;
			Report.error (source_reference, "Return: Cannot convert from `%s' to `%s'".printf (return_expression.value_type.to_string (), analyzer.current_return_type.to_string ()));
			return false;
		}

		if (return_expression.value_type.is_disposable () &&
		    !analyzer.current_return_type.value_owned) {
			error = true;
			Report.error (source_reference, "Return value transfers ownership but method return type hasn't been declared to transfer ownership");
			return false;
		}

		if (return_expression.symbol_reference is LocalVariable &&
		    return_expression.value_type.is_disposable () &&
		    !analyzer.current_return_type.value_owned) {
			Report.warning (source_reference, "Local variable with strong reference used as return value and method return type hasn't been declared to transfer ownership");
		}

		if (analyzer.context.non_null && return_expression is NullLiteral
		    && !analyzer.current_return_type.nullable) {
			Report.warning (source_reference, "`null' incompatible with return type `%s`".printf (analyzer.current_return_type.to_string ()));
		}

		add_error_types (return_expression.get_error_types ());

		return !error;
	}

	public override void get_defined_variables (Collection<LocalVariable> collection) {
		if (return_expression != null) {
			return_expression.get_defined_variables (collection);
		}
	}

	public override void get_used_variables (Collection<LocalVariable> collection) {
		if (return_expression != null) {
			return_expression.get_used_variables (collection);
		}
	}
}
