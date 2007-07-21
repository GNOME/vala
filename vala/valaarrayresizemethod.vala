/* valaarrayresizemethod.vala
 *
 * Copyright (C) 2007  Jürg Billeter
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
 * Represents the Array.resize method.
 */
public class Vala.ArrayResizeMethod : Method {
	construct {
		access = MemberAccessibility.PUBLIC;

		set_cname ("g_renew");
		
		var root_symbol = source_reference.file.context.root;
		var int_type = new TypeReference ();
		int_type.data_type = (DataType) root_symbol.scope.lookup ("int");

		add_parameter (new FormalParameter ("length", int_type));
		
		returns_modified_pointer = true;
	}

	/**
	 * Creates a new array resize method.
	 *
	 * @return newly created method
	 */
	public ArrayResizeMethod (SourceReference! _source_reference) {
		name = "resize";
		return_type = new TypeReference ();
		source_reference = _source_reference;
	}
}
