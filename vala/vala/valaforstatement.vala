/* valaforstatement.vala
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
 * Represents a for iteration statement in the source code.
 */
public class Vala.ForStatement : Statement {
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
	
	/**
	 * Specifies the loop body.
	 */
	public Statement body { get; set; }

	private List<Expression> initializer;
	private List<Expression> iterator;

	private Expression! _condition;

	/**
	 * Creates a new for statement.
	 *
	 * @param cond   loop condition
	 * @param body   loop body
	 * @param source reference to source code
	 * @return       newly created for statement
	 */
	public ForStatement (Expression cond, Statement _body, SourceReference source) {
		condition = cond;
		body = _body;
		source_reference = source;
	}
	
	/**
	 * Appends the specified expression to the list of initializers.
	 *
	 * @param init an initializer expression
	 */
	public void add_initializer (Expression! init) {
		init.parent_node = this;
		initializer.append (init);
	}
	
	/**
	 * Returns a copy of the list of initializers.
	 *
	 * @return initializer list
	 */
	public ref List<weak Expression> get_initializer () {
		return initializer.copy ();
	}
	
	/**
	 * Appends the specified expression to the iterator.
	 *
	 * @param iter an iterator expression
	 */
	public void add_iterator (Expression! iter) {
		iter.parent_node = this;
		iterator.append (iter);
	}
	
	/**
	 * Returns a copy of the iterator.
	 *
	 * @return iterator
	 */
	public ref List<weak Expression> get_iterator () {
		return iterator.copy ();
	}
	
	public override void accept (CodeVisitor! visitor) {
		foreach (Expression init_expr in initializer) {
			init_expr.accept (visitor);
		}

		condition.accept (visitor);
		
		visitor.visit_end_full_expression (condition);

		foreach (Expression it_expr in iterator) {
			it_expr.accept (visitor);
		}
		
		body.accept (visitor);

		visitor.visit_for_statement (this);
	}

	public override void replace (CodeNode! old_node, CodeNode! new_node) {
		weak List<Expression> iter;
		
		if (condition == old_node) {
			condition = (Expression) new_node;
			return;
		}

		for (iter = initializer; iter != null; iter = iter.next) {
			if (iter.data == old_node) {
				weak List<Expression> silbling = iter.next;
				initializer.delete_link (iter);
				initializer.insert_before (silbling, new_node);
				return;
			}
		}

		for (iter = iterator; iter != null; iter = iter.next) {
			if (iter.data == old_node) {
				weak List<Expression> silbling = iter.next;
				iterator.delete_link (iter);
				iterator.insert_before (silbling, new_node);
				return;
			}
		}		
	}
}
