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
	private static int next_with_id = 0;

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
	 * Specifies the with-variable.
	 */
	public LocalVariable with_variable { get; private set; }

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
		if (expression.symbol_reference == with_variable) {
			expression.accept (visitor);
		}
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

		LocalVariable local_var = expression.symbol_reference as LocalVariable;
		if (local_var == null) {
			local_var = new LocalVariable (expression.value_type, "_with_local%d_".printf (next_with_id++), expression, source_reference);
			body.insert_statement (0, new DeclarationStatement (local_var, source_reference));
		}
		with_variable = local_var;

		var old_symbol = context.analyzer.current_symbol;
		owner = context.analyzer.current_symbol.scope;
		context.analyzer.current_symbol = this;

		body.check (context);

		context.analyzer.current_symbol = old_symbol;

		return true;
	}

	public override void emit (CodeGenerator codegen) {
		if (expression.symbol_reference == with_variable) {
			expression.emit (codegen);
		}
		body.emit (codegen);
	}

	public override void get_error_types (Collection<DataType> collection, SourceReference? source_reference = null) {
		if (source_reference == null) {
			source_reference = this.source_reference;
		}
		expression.get_error_types (collection, source_reference);
		body.get_error_types (collection, source_reference);
	}

	public override void get_defined_variables (Collection<Variable> collection) {
		if (expression.symbol_reference != with_variable) {
			collection.add (with_variable);
		}
	}
}
