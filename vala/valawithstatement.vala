/* valalockstatement.vala
 *
 * Copyright (C) 2009  Jiří Zárevúcky
 * Copyright (C) 2006-2010  Jürg Billeter
 * Copyright (C) 2006-2007  Raffaele Sandrini
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

public class Vala.WithStatement : Symbol, Statement {
	/**
	 * Expression representing the expression to be locked.
	 */
	public Expression expression {
		get { return _expression; }
		set {
			_expression = value;
			_expression.parent_node = this;
		}
	}

	/**
	 * The statement during its execution the expression is locked.
	 */
	public Block? body {
		get { return _body; }
		set {
			_body = value;
			if (_body != null) {
				_body.parent_node = this;
			}
		}
	}

	private Expression _expression;
	private Block _body;

	public WithStatement (Expression expression, Block? body, SourceReference? source_reference = null) {
		base(null, source_reference);
		this.body = body;
		this.source_reference = source_reference;
		this.expression = expression;
	}

	public override void accept (CodeVisitor visitor) {
		visitor.visit_with_statement (this);
	}

	public override void accept_children(CodeVisitor visitor) {
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
		expression.check(context);

		var old_symbol = context.analyzer.current_symbol;
		owner = context.analyzer.current_symbol.scope;
		context.analyzer.current_symbol = this;

		body.check(context);

		context.analyzer.current_symbol = old_symbol;
		return true;
	}

	public override void emit (CodeGenerator codegen) {
		expression.emit (codegen);
		body.emit (codegen);
	}
}
