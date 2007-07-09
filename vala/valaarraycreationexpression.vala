/* valaarraycreationexpression.vala
 *
 * Copyright (C) 2006-2007  Raffaele Sandrini, Jürg Billeter
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
 * 	Raffaele Sandrini <rasa@gmx.ch>
 * 	Jürg Billeter <j@bitron.ch>
 */

using GLib;

/**
 * Represents an array creation expression e.g. "new int[] {1,2,3}".
 */
public class Vala.ArrayCreationExpression : Expression {
	/**
	 * The type of the elements of the array.
	 */
	public TypeReference element_type { get; set construct; }
	
	/**
	 * The rank of the array.
	 */
	public int rank { get; set construct; }
	
	/**
	 * The size for each dimension ascending from left to right.
	 */
	private List<Expression> sizes;
	
	/**
	 * The root array initializer list.
	 */
	public InitializerList initializer_list { get; set construct; }
	
	/**
	 * Add a size expression.
	 */
	public void append_size (Expression! size) {
		sizes.append (size);
	}
	
	/**
	 * Get the sizes for all dimensions ascending from left to right.
	 */
	public List<weak Expression> get_sizes () {
		return sizes.copy ();
	}
	
	public ArrayCreationExpression (TypeReference _element_type, int _rank, InitializerList _initializer, SourceReference source) {
		element_type = _element_type;
		rank = _rank;
		initializer_list = _initializer;
		source_reference = source;
	}
	
	public override void accept (CodeVisitor! visitor) {
		if (element_type != null) {
			element_type.accept (visitor);
		}
		
		if (sizes != null) {
			foreach (Expression e in sizes) {
				e.accept (visitor);
			}
		}
		
		visitor.visit_begin_array_creation_expression (this);
		
		if (initializer_list != null) {
			initializer_list.accept (visitor);
		}
		
		visitor.visit_end_array_creation_expression (this);
	}
}
