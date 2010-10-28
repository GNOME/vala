/* valawhilestatement.vala
 *
 * Copyright (C) 2006-2010  Jürg Billeter
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
		set {
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
	public WhileStatement (Expression condition, Block body, SourceReference? source_reference = null) {
		this.body = body;
		this.source_reference = source_reference;
		this.condition = condition;
	}
	
	public override void accept (CodeVisitor visitor) {
		visitor.visit_while_statement (this);
	}

	public override void accept_children (CodeVisitor visitor) {
		condition.accept (visitor);
		
		visitor.visit_end_full_expression (condition);

		body.accept (visitor);
	}

	bool always_true (Expression condition) {
		var literal = condition as BooleanLiteral;
		return (literal != null && literal.value);
	}

	bool always_false (Expression condition) {
		var literal = condition as BooleanLiteral;
		return (literal != null && !literal.value);
	}

	public override bool check (CodeContext context) {
		// convert to simple loop

		if (always_true (condition)) {
			// do not generate if block if condition is always true
		} else if (always_false (condition)) {
			// do not generate if block if condition is always false
			body.insert_statement (0, new BreakStatement (condition.source_reference));
		} else {
			var if_condition = new UnaryExpression (UnaryOperator.LOGICAL_NEGATION, condition, condition.source_reference);
			var true_block = new Block (condition.source_reference);
			true_block.add_statement (new BreakStatement (condition.source_reference));
			var if_stmt = new IfStatement (if_condition, true_block, null, condition.source_reference);
			body.insert_statement (0, if_stmt);
		}

		var loop = new Loop (body, source_reference);

		var parent_block = (Block) parent_node;
		parent_block.replace_statement (this, loop);

		return loop.check (context);
	}
}

