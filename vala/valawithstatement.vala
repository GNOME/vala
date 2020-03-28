/* valawithtatement.vala
 *
 * Copyright (C) 2020 Nick Schrader
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
 * Authors:
 * 	Nick Schrader <nick.schrader@mailbox.org>
 */

using GLib;

public class Vala.WithStatement : Block {
	/**
	 * Expression representing the type of body's dominant scope.
	 */
	public Expression expression {
		get { return _expression; }
		private set {
			_expression = value;
			_expression.parent_node = this;
		}
	}

	/**
	 * The block which dominant scope is type of expression.
	 */
	public Block body {
		get { return _body; }
		private set {
			_body = value;
			if (_body != null) {
				_body.parent_node = this;
			}
		}
	}

	private Expression _expression;
	private Block _body;

	public WithStatement (Expression expression, Block body, SourceReference? source_reference = null) {
		base (source_reference);
		this.expression = expression;
		this.body = body;
	}

	public override void accept (CodeVisitor visitor) {
		visitor.visit_with_statement (this);
	}

	public override void accept_children (CodeVisitor visitor) {
		expression.accept (visitor);
		if (body != null) {
			body.accept (visitor);
		}
	}

	public override void replace_expression (Expression old_node, Expression new_node) {
		if (expression == old_node) {
			expression = new_node;
		}
	}

	public override bool check (CodeContext context) {
		expression.check (context);

		var old_symbol = context.analyzer.current_symbol;
		owner = context.analyzer.current_symbol.scope;
		context.analyzer.current_symbol = this;

		body.check (context);

		context.analyzer.current_symbol = old_symbol;

		return true;
	}

	public override void emit (CodeGenerator codegen) {
		expression.emit (codegen);
		body.emit (codegen);
	}
}
