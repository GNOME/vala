/* valareturnstatement.vala
 *
 * Copyright (C) 2006  Jürg Billeter
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
 * Represents a return statement in the source code.
 */
public class Vala.ReturnStatement : Statement {
	/**
	 * The optional expression to return.
	 */
	public Expression return_expression {
		get {
			return _return_expression;
		}
		set {
			_return_expression = value;
			if (_return_expression != null) {
				_return_expression.parent_node = this;
			}
		}
	}

	private Expression! _return_expression;

	/**
	 * Creates a new return statement.
	 *
	 * @param result the return expression
	 * @param source reference to source code
	 * @return       newly created return statement
	 */
	public construct (Expression result = null, SourceReference source = null) {
		return_expression = result;
		source_reference = source;
	}
	
	public override void accept (CodeVisitor! visitor) {
		visitor.visit_begin_return_statement (this);

		if (return_expression != null) {
			return_expression.accept (visitor);
		
			visitor.visit_end_full_expression (return_expression);
		}

		visitor.visit_end_return_statement (this);
	}

	public override void replace (CodeNode! old_node, CodeNode! new_node) {
		if (return_expression == old_node) {
			return_expression = new_node;
		}
	}
}
