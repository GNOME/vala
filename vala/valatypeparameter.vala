/* valatypeparameter.vala
 *
 * Copyright (C) 2006-2007  Jürg Billeter
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
 * Represents a generic type parameter in the source code.
 */
public class Vala.TypeParameter : Symbol {
	/**
	 * The generic type declaring this parameter.
	 */
	public weak DataType type;

	/* holds the array types of this type; each rank is a separate one */
	/* FIXME: uses string because int does not work as key yet */
	private HashTable<string,Array> array_types = new HashTable.full (str_hash, str_equal, g_free, g_object_unref);

	/**
	 * Creates a new generic type parameter.
	 *
	 * @param name   parameter name
	 * @param source reference to source code
	 * @return       newly created generic type parameter
	 */	
	public TypeParameter (string! _name, SourceReference source) {
		name = _name;
		source_reference = source;
	}

	public override void accept (CodeVisitor! visitor) {
		visitor.visit_type_parameter (this);
	}
	
	/**
	 * Returns the array type for elements of this type parameter.
	 *
	 * @param rank the rank the array should be of
	 * @return array type for this type parameter
	 */
	public Array! get_array (int rank) {
		Array array_type = (Array) array_types.lookup (rank.to_string ());
		
		if (array_type == null) {
			var new_array_type = new Array.with_type_parameter (this, rank, source_reference);
			parent_symbol.scope.add (new_array_type.name, new_array_type);

			/* add internal length field */
			new_array_type.scope.add (new_array_type.get_length_field ().name, new_array_type.get_length_field ());
			/* add internal resize method */
			new_array_type.scope.add (new_array_type.get_resize_method ().name, new_array_type.get_resize_method ());

			/* link the array type to the same source as the container type */
			new_array_type.source_reference = this.source_reference;
			
			array_types.insert (rank.to_string (), new_array_type);
			
			array_type = new_array_type;
		}
		
		return array_type;
	}

	/**
	 * Checks two type parameters for equality.
	 *
	 * @param param2 a type parameter
	 * @return      true if this type parameter is equal to param2, false
	 *              otherwise
	 */
	public bool equals (TypeParameter! param2) {
		// FIXME check whether the corresponding data type of one of the
		//       parameters is a base type of the corresponding data
		//       type of the other parameter and check along the path
		//       whether one parameter maps to the other
		return true;
	}
}
