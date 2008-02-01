/* valaarraytype.vala
 *
 * Copyright (C) 2007-2008  Jürg Billeter
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
 * An array type.
 */
public class Vala.ArrayType : ReferenceType {
	/**
	 * The element type.
	 */
	public weak DataType element_type { get; construct set; }

	/**
	 * The rank of this array.
	 */
	public int rank { get; construct set; }

	public ArrayType (construct DataType! element_type, construct int rank) {
	}

	construct {
		if (element_type.data_type != null) {
			data_type = element_type.data_type.get_array (rank);
		} else {
			data_type = element_type.type_parameter.get_array (rank);
		}
	}

	public override DataType! copy () {
		var result = new ArrayType (element_type, rank);
		result.source_reference = source_reference;
		result.transfers_ownership = transfers_ownership;
		result.takes_ownership = takes_ownership;
		result.is_out = is_out;
		result.nullable = nullable;
		result.requires_null_check = requires_null_check;
		result.floating_reference = floating_reference;
		result.is_ref = is_ref;
		
		foreach (DataType arg in get_type_arguments ()) {
			result.add_type_argument (arg.copy ());
		}
		
		return result;
	}

	public override bool is_array () {
		return true;
	}
}
