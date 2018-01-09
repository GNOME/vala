/* valaforstatement.vala
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
 * Represents a for iteration statement in the source code.
 */
public class Vala.ForStatement : Loop, Statement {
	private List<Expression> initializer = new ArrayList<Expression> ();
	private List<Expression> iterator = new ArrayList<Expression> ();

	/**
	 * Creates a new for statement.
	 *
	 * @param condition        loop condition
	 * @param body             loop body
	 * @param source_reference reference to source code
	 * @return                 newly created for statement
	 */
	public ForStatement (Expression? condition, Block body, SourceReference? source_reference = null) {
		base (condition, body, source_reference);
	}

	/**
	 * Appends the specified expression to the list of initializers.
	 *
	 * @param init an initializer expression
	 */
	public void add_initializer (Expression init) {
		init.parent_node = this;
		initializer.add (init);
	}

	/**
	 * Returns the list of initializers.
	 *
	 * @return initializer list
	 */
	public unowned List<Expression> get_initializer () {
		return initializer;
	}

	/**
	 * Appends the specified expression to the iterator.
	 *
	 * @param iter an iterator expression
	 */
	public void add_iterator (Expression iter) {
		iter.parent_node = this;
		iterator.add (iter);
	}

	/**
	 * Returns the iterator.
	 *
	 * @return iterator
	 */
	public unowned List<Expression> get_iterator () {
		return iterator;
	}

	public override void accept (CodeVisitor visitor) {
		visitor.visit_for_statement (this);
	}

	public override void accept_children (CodeVisitor visitor) {
		foreach (Expression init_expr in initializer) {
			init_expr.accept (visitor);
			visitor.visit_end_full_expression (init_expr);
		}

		if (condition != null) {
			condition.accept (visitor);

			visitor.visit_end_full_expression (condition);
		}

		foreach (Expression it_expr in iterator) {
			it_expr.accept (visitor);
			visitor.visit_end_full_expression (it_expr);
		}

		body.accept (visitor);
	}

	public override void replace_expression (Expression old_node, Expression new_node) {
		base.replace_expression (old_node, new_node);

		for (int i=0; i < initializer.size; i++) {
			if (initializer[i] == old_node) {
				initializer[i] = new_node;
				new_node.parent_node = this;
			}
		}
		for (int i=0; i < iterator.size; i++) {
			if (iterator[i] == old_node) {
				iterator[i] = new_node;
				new_node.parent_node = this;
			}
		}
	}

	public override bool check (CodeContext context) {
		if (checked) {
			return !error;
		}

		checked = true;

		// convert to simple loop

		var block = new Block (source_reference);

		// initializer
		foreach (var init_expr in initializer) {
			block.add_statement (new ExpressionStatement (init_expr, init_expr.source_reference));
		}

		// do not generate if block if condition is always true
		if (condition == null || condition.is_always_true ()) {
		} else if (condition.is_always_false ()) {
			// do not generate if block if condition is always false
			body.insert_statement (0, new BreakStatement (condition.source_reference));
		} else {
			// condition
			var if_condition = new UnaryExpression (UnaryOperator.LOGICAL_NEGATION, condition, condition.source_reference);
			var true_block = new Block (condition.source_reference);
			true_block.add_statement (new BreakStatement (condition.source_reference));
			var if_stmt = new IfStatement (if_condition, true_block, null, condition.source_reference);
			body.insert_statement (0, if_stmt);
		}

		// iterator
		var first_local = new LocalVariable (context.analyzer.bool_type.copy (), get_temp_name (), new BooleanLiteral (true, source_reference), source_reference);
		block.add_statement (new DeclarationStatement (first_local, source_reference));

		var iterator_block = new Block (source_reference);
		foreach (var it_expr in iterator) {
			iterator_block.add_statement (new ExpressionStatement (it_expr, it_expr.source_reference));
		}

		var first_if = new IfStatement (new UnaryExpression (UnaryOperator.LOGICAL_NEGATION, new MemberAccess.simple (first_local.name, source_reference), source_reference), iterator_block, null, source_reference);
		body.insert_statement (0, first_if);
		body.insert_statement (1, new ExpressionStatement (new Assignment (new MemberAccess.simple (first_local.name, source_reference), new BooleanLiteral (false, source_reference), AssignmentOperator.SIMPLE, source_reference), source_reference));

		block.add_statement (new LoopStatement (body, source_reference));

		unowned Block parent_block = (Block) parent_node;
		parent_block.replace_statement (this, block);

		if (!block.check (context)) {
			error = true;
		}

		return !error;
	}
}
