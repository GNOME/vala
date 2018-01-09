/* valaloop.vala
 *
 * Copyright (C) 2021  Rico Tzschichholz
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
 * 	Rico Tzschichholz <ricotz@ubuntu.com>
 */

/**
 * Base class for all loop statements.
 */
public abstract class Vala.Loop : CodeNode {
	/**
	 * Specifies the loop condition.
	 */
	public Expression? condition {
		get {
			return _condition;
		}
		private set {
			_condition = value;
			if (_condition != null) {
				_condition.parent_node = this;
			}
		}
	}

	/**
	 * Specifies the loop body.
	 */
	public Block body {
		get {
			return _body;
		}
		private set {
			_body = value;
			_body.parent_node = this;
		}
	}

	Expression _condition;
	Block _body;

	protected Loop (Expression? condition, Block body, SourceReference? source_reference = null) {
		this.condition = condition;
		this.body = body;
		this.source_reference = source_reference;
	}

	public override void replace_expression (Expression old_node, Expression new_node) {
		if (condition == old_node) {
			condition = new_node;
		}
	}
}
