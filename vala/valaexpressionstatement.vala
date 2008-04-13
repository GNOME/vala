/* valaexpressionstatement.vala
 *
 * Copyright (C) 2006-2007  Jürg Billeter
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
		set construct {
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
	public ExpressionStatement (construct Expression expression, construct SourceReference source_reference = null) {
	}
	
	public override void accept (CodeVisitor visitor) {
		expression.accept (visitor);

		visitor.visit_expression_statement (this);
	}

	public override void replace_expression (Expression old_node, Expression new_node) {
		if (expression == old_node) {
			expression = new_node;
		}
	}

	/**
	 * Returns the property this statement sets, if any.
	 *
	 * @return the property this statement sets, or null if it doesn't set
	 *         a property
	 */
	public Property assigned_property () {
		if (expression is Assignment) {
			var assign = (Assignment) expression;
			if (assign.left is MemberAccess) {
				var ma = (MemberAccess) assign.left;
				if (ma.symbol_reference is Property) {
					return (Property) ma.symbol_reference;
				}
			}
		}

		return null;
	}
}
