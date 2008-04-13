/* valaarraycreationexpression.vala
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
 * Represents an array creation expression e.g. "new int[] {1,2,3}".
 */
public class Vala.ArrayCreationExpression : Expression {
	/**
	 * The type of the elements of the array.
	 */
	public DataType element_type {
		get { return _element_type; }
		set {
			_element_type = value;
			_element_type.parent_node = this;
		}
	}
	
	/**
	 * The rank of the array.
	 */
	public int rank { get; set construct; }
	
	/**
	 * The size for each dimension ascending from left to right.
	 */
	private Gee.List<Expression> sizes = new ArrayList<Expression> ();
	
	/**
	 * The root array initializer list.
	 */
	public InitializerList? initializer_list { get; set construct; }

	private DataType _element_type;

	/**
	 * Add a size expression.
	 */
	public void append_size (Expression size) {
		sizes.add (size);
	}
	
	/**
	 * Get the sizes for all dimensions ascending from left to right.
	 */
	public Gee.List<Expression> get_sizes () {
		return new ReadOnlyList<Expression> (sizes);
	}
	
	public ArrayCreationExpression (DataType element_type, int rank, InitializerList? initializer_list, SourceReference source_reference) {
		this.element_type = element_type;
		this.rank = rank;
		this.initializer_list = initializer_list;
		this.source_reference = source_reference;
	}

	public override void accept_children (CodeVisitor visitor) {
		if (element_type != null) {
			element_type.accept (visitor);
		}

		foreach (Expression e in sizes) {
			e.accept (visitor);
		}

		if (initializer_list != null) {
			initializer_list.accept (visitor);
		}
	}

	public override void accept (CodeVisitor visitor) {
		visitor.visit_array_creation_expression (this);
	}

	public override bool is_pure () {
		return false;
	}

	public override void replace_type (DataType old_type, DataType new_type) {
		if (element_type == old_type) {
			element_type = new_type;
		}
	}
}
