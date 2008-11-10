/* valathrowstatement.vala
 *
 * Copyright (C) 2007-2008  Jürg Billeter
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
 * Represents a throw statement in the source code.
 */
public class Vala.ThrowStatement : CodeNode, Statement {
	/**
	 * The error expression to throw.
	 */
	public Expression error_expression {
		get {
			return _error_expression;
		}
		set {
			_error_expression = value;
			if (_error_expression != null) {
				_error_expression.parent_node = this;
			}
		}
	}

	private Expression _error_expression;

	/**
	 * Creates a new throw statement.
	 *
	 * @param error_expression the error expression
	 * @param source_reference reference to source code
	 * @return                 newly created throw statement
	 */
	public ThrowStatement (Expression error_expression, SourceReference? source_reference = null) {
		this.source_reference = source_reference;
		this.error_expression = error_expression;
	}

	public override void accept (CodeVisitor visitor) {
		visitor.visit_throw_statement (this);
	}

	public override void accept_children (CodeVisitor visitor) {
		if (error_expression != null) {
			error_expression.accept (visitor);

			visitor.visit_end_full_expression (error_expression);
		}
	}

	public override void replace_expression (Expression old_node, Expression new_node) {
		if (error_expression == old_node) {
			error_expression = new_node;
		}
	}

	public override bool check (SemanticAnalyzer analyzer) {
		if (checked) {
			return !error;
		}

		checked = true;

		error_expression.target_type = new ErrorType (null, null, source_reference);
		error_expression.target_type.value_owned = true;

		if (error_expression != null) {
			error_expression.check (analyzer);
		}

		var error_type = error_expression.value_type.copy ();
		error_type.source_reference = source_reference;

		add_error_type (error_type);

		return !error;
	}
}
