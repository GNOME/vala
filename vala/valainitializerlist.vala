/* valainitializerlist.vala
 *
 * Copyright (C) 2006-2008  Jürg Billeter, Raffaele Sandrini
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
 * 	Raffaele Sandrini <raffaele@sandrini.ch>
 */

using GLib;
using Gee;

/**
 * Represents an array or struct initializer list in the source code.
 */
public class Vala.InitializerList : Expression {
	private Gee.List<Expression> initializers = new ArrayList<Expression> ();
	
	/**
	 * Appends the specified expression to this initializer list.
	 *
	 * @param expr an expression
	 */
	public void append (Expression expr) {
		initializers.add (expr);
		expr.parent_node = this;
	}
	
	/**
	 * Returns a copy of the expression list.
	 *
	 * @return expression list
	 */
	public Collection<Expression> get_initializers () {
		return new ReadOnlyCollection<Expression> (initializers);
	}

	/**
	 * Returns the initializer count in this initializer list.
	 */
	public int size {
		get { return initializers.size; }
	}

	/**
	 * Creates a new initializer list.
	 *
	 * @param source_reference reference to source code
	 * @return                 newly created initializer list
	 */
	public InitializerList (SourceReference source_reference) {
		this.source_reference = source_reference;
	}

	public override void accept_children (CodeVisitor visitor) {
		foreach (Expression expr in initializers) {
			expr.accept (visitor);
		}
	}

	public override void accept (CodeVisitor visitor) {
		visitor.visit_initializer_list (this);
	}

	public override bool is_pure () {
		foreach (Expression initializer in initializers) {
			if (!initializer.is_pure ()) {
				return false;
			}
		}
		return true;
	}

	public override void replace_expression (Expression old_node, Expression new_node) {
		for (int i = 0; i < initializers.size; i++) {
			if (initializers[i] == old_node) {
				initializers[i] = new_node;
			}
		}
	}
}
