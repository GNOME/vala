/* valayieldstatement.vala
 *
 * Copyright (C) 2008-2010  Jürg Billeter
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

/**
 * Represents a yield statement in the source code.
 */
public class Vala.YieldStatement : CodeNode, Statement {
	/**
	 * The expression to yield or the method call to yield to.
	 */
	public Expression? yield_expression {
		get { return _yield_expression; }
		set {
			_yield_expression = value;
			if (_yield_expression != null) {
				_yield_expression.parent_node = this;
			}
		}
	}

	private Expression _yield_expression;

	/**
	 * Creates a new yield statement.
	 *
	 * @param yield_expression the yield expression
	 * @param source_reference reference to source code
	 * @return                 newly created yield statement
	 */
	public YieldStatement (Expression? yield_expression, SourceReference? source_reference = null) {
		this.yield_expression = yield_expression;
		this.source_reference = source_reference;
	}

	public override void accept (CodeVisitor visitor) {
		visitor.visit_yield_statement (this);
	}

	public override void accept_children (CodeVisitor visitor) {
		if (yield_expression != null) {
			yield_expression.accept (visitor);

			visitor.visit_end_full_expression (yield_expression);
		}
	}

	public override void replace_expression (Expression old_node, Expression new_node) {
		if (yield_expression == old_node) {
			yield_expression = new_node;
		}
	}

	public override bool check (CodeContext context) {
		if (yield_expression != null) {
			yield_expression.check (context);
			error = yield_expression.error;
		}

		context.analyzer.current_method.yield_count++;

		return !error;
	}

	public override void emit (CodeGenerator codegen) {
		if (yield_expression != null) {
			yield_expression.emit (codegen);

			codegen.visit_end_full_expression (yield_expression);
		}

		codegen.visit_yield_statement (this);
	}
}

