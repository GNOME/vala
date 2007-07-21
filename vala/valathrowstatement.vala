/* valathrowstatement.vala
 *
 * Copyright (C) 2007  Jürg Billeter
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

	private Expression! _error_expression;

	/**
	 * Creates a new throw statement.
	 *
	 * @param error_expression the error expression
	 * @param source_reference reference to source code
	 * @return                 newly created throw statement
	 */
	public ThrowStatement (construct Expression! error_expression, construct SourceReference source_reference = null) {
	}

	public override void accept (CodeVisitor! visitor) {
		visitor.visit_throw_statement (this);
	}

	public override void accept_children (CodeVisitor! visitor) {
		if (error_expression != null) {
			error_expression.accept (visitor);
		
			visitor.visit_end_full_expression (error_expression);
		}
	}

	public override void replace (CodeNode! old_node, CodeNode! new_node) {
		if (error_expression == old_node) {
			error_expression = (Expression) new_node;
		}
	}
}
