/* valatype.vala
 *
 * Copyright (C) 2006  Raffaele Sandrini
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
 */

using GLib;

/**
 * Represents an array type i.e. everything with direct accessable elements.
 */
public class Vala.Array : DataType {

	/**
	 * DataType of which this is an array of.
	 */
	public DataType! element_type { get; set construct; }
	
	private string cname;
	
	public construct (DataType! type) {
		element_type = type;
	}

	Array () {
		name = "%s[]".printf (element_type.name);
	}
	
	/**
	 * Returns the name of this data type as it is used in C code.
	 *
	 * @return the name to be used in C code
	 */
	public override string get_cname () {
		if (cname == null) {
			if (element_type.is_reference_type ()) {
				cname = "%s*".printf (element_type.get_cname ());
			} else {
				cname = element_type.get_cname ();
			}
		}
		
		return cname;
	}
	
	/**
	 * Checks whether this data type has value or reference type semantics.
	 *
	 * @return true if this data type has reference type semantics
	 */
	public override bool is_reference_type () {
		return true;
	}
	
	/**
	 * Returns the C name of this data type in upper case. Words are
	 * separated by underscores. The upper case C name of the namespace is
	 * prefix of the result.
	 *
	 * @param infix a string to be placed between namespace and data type
	 *              name or null
	 * @return      the upper case name to be used in C code
	 */
	public override ref string get_upper_case_cname (string infix) {
		return null;
	}
	
	/**
	 * Returns the C name of this data type in lower case. Words are
	 * separated by underscores. The lower case C name of the namespace is
	 * prefix of the result.
	 *
	 * @param infix a string to be placed between namespace and data type
	 *              name or null
	 * @return      the lower case name to be used in C code
	 */
	public override ref string get_lower_case_cname (string infix) {
		return null;
	}
	
	/**
	 * Returns the C function name that frees instances of this data type.
	 * This is only valid for data types with reference type semantics that
	 * do not support reference counting. The specified C function must
	 * accept one argument pointing to the instance to be freed.
	 *
	 * @return the name of the C function or null if this data type is not a
	 *         reference type or if it supports reference counting
	 */
	public override string get_free_function () {
		return "g_free";
	}
	
	/**
	 * Returns a list of C header filenames users of this data type must
	 * include.
	 *
	 * @return list of C header filenames for this data type
	 */
	public override ref List<string> get_cheader_filenames () {
		return element_type.get_cheader_filenames ();
	}
}
