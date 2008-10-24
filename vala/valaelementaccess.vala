/* valaelementaccess.vala
 *
 * Copyright (C) 2006-2008  Raffaele Sandrini, Jürg Billeter
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
 * 	Raffaele Sandrini <raffaele@sandrini.ch>
 * 	Jürg Billeter <j@bitron.ch>
 */

using GLib;
using Gee;

/**
 * Represents an array access expression e.g. "a[1,2]".
 */
public class Vala.ElementAccess : Expression {
	/**
	 * Expression representing the container on wich we want to access.
	 */
	public Expression container { get; set; }
	
	/**
	 * Expressions representing the indices we want to access inside the container.
	 */
	private Gee.List<Expression> indices = new ArrayList<Expression> ();

	public void append_index (Expression index) {
		indices.add (index);
		index.parent_node = this;
	}

	public Gee.List<Expression> get_indices () {
		return new ReadOnlyList<Expression> (indices);
	}
	
	public ElementAccess (Expression container, SourceReference source_reference) {
		this.source_reference = source_reference;
		this.container = container;
	}
	
	public override void accept (CodeVisitor visitor) {
		visitor.visit_element_access (this);

		visitor.visit_expression (this);
	}

	public override void accept_children (CodeVisitor visitor) {
		container.accept (visitor);
		foreach (Expression e in indices) {
			e.accept (visitor);
		}
	}

	public override void replace_expression (Expression old_node, Expression new_node) {
		if (container == old_node) {
			container = new_node;
		}
		
		int index = indices.index_of (old_node);
		if (index >= 0 && new_node.parent_node == null) {
			indices[index] = new_node;
			new_node.parent_node = this;
		}
	}

	public override bool is_pure () {
		foreach (Expression index in indices) {
			if (!index.is_pure ()) {
				return false;
			}
		}
		return container.is_pure ();
	}
}
