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
public class Vala.ForStatement : CodeNode, Statement {
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

	private List<Expression> initializer = new ArrayList<Expression> ();
	private List<Expression> iterator = new ArrayList<Expression> ();

	private Expression _condition;
	private Block _body;

	/**
	 * Creates a new for statement.
	 *
	 * @param condition        loop condition
	 * @param body             loop body
	 * @param source_reference reference to source code
	 * @return                 newly created for statement
	 */
	public ForStatement (Expression? condition, Block body, SourceReference? source_reference = null) {
		this.condition = condition;
		this.body = body;
		this.source_reference = source_reference;
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
		if (condition == old_node) {
			condition = new_node;
		}
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

		// initializer
		foreach (var init_expr in initializer) {
			if (!init_expr.check (context)) {
				error = true;
			}
		}

		// condition
		if (condition != null) {
			condition.target_type = context.analyzer.bool_type.copy ();
			if (!condition.check (context)) {
				error = true;
			}

			if (condition.value_type == null || !condition.value_type.compatible (context.analyzer.bool_type)) {
				error = true;
				Report.error (condition.source_reference, "Condition must be boolean");
			}
		}

		// iterator
		foreach (var it_expr in iterator) {
			if (!it_expr.check (context)) {
				error = true;
			}
		}

		// body
		if (!body.check (context)) {
			error = true;
		}

		return !error;
	}
}
