/* valadostatement.vala
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
 * Represents a do iteration statement in the source code.
 */
public class Vala.DoStatement : Statement {
	/**
	 * Specifies the loop body.
	 */
	public Statement body { get; set; }

	/**
	 * Specifies the loop condition.
	 */
	public Expression! condition {
		get {
			return _condition;
		}
		set construct {
			_condition = value;
			_condition.parent_node = this;
		}
	}

	private Expression! _condition;
	
	/**
	 * Creates a new do statement.
	 *
	 * @param cond   loop condition
	 * @param body   loop body
	 * @param source reference to source code
	 * @return       newly created do statement
	 */
	public DoStatement (Statement! _body, Expression! cond, SourceReference source) {
		body = _body;
		condition = cond;
		source_reference = source;
	}
	
	public override void accept (CodeVisitor! visitor) {
		body.accept (visitor);

		condition.accept (visitor);
		
		visitor.visit_end_full_expression (condition);

		visitor.visit_do_statement (this);
	}

	public override void replace (CodeNode! old_node, CodeNode! new_node) {
		if (condition == old_node) {
			condition = (Expression) new_node;
		}
	}
}
