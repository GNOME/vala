/* valatype.vala
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
 * Represents an array type i.e. everything with direct accessable elements.
 */
public class Vala.Array : DataType {

	/**
	 * DataType of which this is an array of.
	 */
	public DataType element_type { get; set construct; }
	
	/**
	 * TypeParameter of which this is an array of.
	 */
	public TypeParameter element_type_parameter { get; set construct; }
	
	/**
	 * The rank of this array.
	 */
	public int rank { get; set construct; }
	
	private string cname;
	
	private ArrayLengthField length_field;
	
	private ArrayResizeMethod resize_method;
	
	public construct (DataType! _element_type, int _rank, SourceReference! _source_reference) {
		rank = _rank;
		element_type = _element_type;
		source_reference = _source_reference;
		
		if (_rank < 1) {
			Report.error (null, "internal: attempt to create an array with rank smaller than 1");
		}
	}
	
	public construct with_type_parameter (TypeParameter! _element_type_parameter, int _rank, SourceReference! _source_reference) {
		rank = _rank;
		element_type_parameter = _element_type_parameter;
		source_reference = _source_reference;
		
		if (_rank < 1) {
			Report.error (null, "internal: attempt to create an array with rank smaller than 1");
		}
	}

	Array () {
		/* FIXME: this implementation reveals compiler bugs 
		string commas = "";
		int i = rank - 1;
		
		while (i > 0) {
			string += ",";
			i--;
		}
			
		name = "%s[%s]".printf (element_type.name, commas); */
		
		int i = rank - 1;
		if (element_type != null) {
			name = "%s[".printf (element_type.name);
		} else {
			name = "%s[".printf (element_type_parameter.name);
		}
		while (i > 0) {
			name = "%s,".printf (name);
			i--;
		}
		name = "%s]".printf (name);
		
		length_field = new ArrayLengthField (source_reference);
		length_field.symbol = new Symbol (length_field);
		
		resize_method = new ArrayResizeMethod (source_reference);
		resize_method.symbol = new Symbol (resize_method);
	}
	
	/**
	 * Returns the name of this data type as it is used in C code.
	 *
	 * @return the name to be used in C code
	 */
	public override string get_cname (bool const_type = false) {
		if (cname == null) {
			if (element_type != null) {
				if (element_type.is_reference_type ()) {
					cname = "%s*".printf (element_type.get_cname ());
				} else {
					cname = element_type.get_cname ();
				}
			} else {
				cname = "gpointer";
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
		if (element_type != null) {
			return element_type.get_cheader_filenames ();
		} else {
			return null;
		}
	}
	
	public override string get_marshaller_type_name () {
		return "POINTER";
	}

	public override string get_get_value_function () {
		return "g_value_get_pointer";
	}
	
	public override string get_set_value_function () {
		return "g_value_set_pointer";
	}

	public ArrayLengthField get_length_field () {
		return length_field;
	}

	public ArrayResizeMethod get_resize_method () {
		return resize_method;
	}
}
