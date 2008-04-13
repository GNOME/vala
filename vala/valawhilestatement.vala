/* valawhilestatement.vala
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

using GLib;

/**
 * Represents a while iteration statement in the source code.
 */
public class Vala.WhileStatement : CodeNode, Statement {
	/**
	 * Specifies the loop condition.
	 */
	public Expression condition {
		get {
			return _condition;
		}
		set construct {
			_condition = value;
			_condition.parent_node = this;
		}
	}
	
	/**
	 * Specifies the loop body.
	 */
	public Block body {
		get {
			return _body;
		}
		set {
			_body = value;
			_body.parent_node = this;
		}
	}

	private Expression _condition;
	private Block _body;

	/**
	 * Creates a new while statement.
	 *
	 * @param cond   loop condition
	 * @param body   loop body
	 * @param source reference to source code
	 * @return       newly created while statement
	 */
	public WhileStatement (construct Expression condition, construct Block body, construct SourceReference source_reference = null) {
	}
	
	public override void accept (CodeVisitor visitor) {
		visitor.visit_while_statement (this);
	}

	public override void accept_children (CodeVisitor visitor) {
		condition.accept (visitor);
		
		visitor.visit_end_full_expression (condition);

		body.accept (visitor);
	}

	public override void replace_expression (Expression old_node, Expression new_node) {
		if (condition == old_node) {
			condition = new_node;
		}
	}
}
