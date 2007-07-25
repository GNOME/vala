/* valaarray.vala
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
	
	public Array (DataType! _element_type, int _rank, SourceReference _source_reference) {
		rank = _rank;
		element_type = _element_type;
		source_reference = _source_reference;
	}
	
	public Array.with_type_parameter (TypeParameter! _element_type_parameter, int _rank, SourceReference _source_reference) {
		rank = _rank;
		element_type_parameter = _element_type_parameter;
		source_reference = _source_reference;
	}

	construct {
		/* FIXME: this implementation reveals compiler bugs 
		string commas = "";
		int i = rank - 1;
		
		while (i > 0) {
			string += ",";
			i--;
		}
			
		name = "%s[%s]".printf (element_type.name, commas); */
		
		if (rank < 1) {
			Report.error (null, "internal: attempt to create an array with rank smaller than 1");
		}
		
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
	}

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

	public override bool is_reference_type () {
		return true;
	}

	public override string get_upper_case_cname (string infix) {
		return null;
	}

	public override string get_lower_case_cname (string infix) {
		return null;
	}

	public override string get_free_function () {
		return "g_free";
	}

	public override List<weak string> get_cheader_filenames () {
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
		if (length_field == null) {
			length_field = new ArrayLengthField (source_reference);

			length_field.access = MemberAccessibility.PUBLIC;

			var root_symbol = source_reference.file.context.root;
			length_field.type_reference = new TypeReference ();
			length_field.type_reference.data_type = (DataType) root_symbol.scope.lookup ("int");

		}
		return length_field;
	}

	public ArrayResizeMethod get_resize_method () {
		if (resize_method == null) {
			resize_method = new ArrayResizeMethod (source_reference);

			resize_method.return_type = new TypeReference ();
			resize_method.access = MemberAccessibility.PUBLIC;

			resize_method.set_cname ("g_renew");
			
			var root_symbol = source_reference.file.context.root;
			var int_type = new TypeReference ();
			int_type.data_type = (DataType) root_symbol.scope.lookup ("int");

			resize_method.add_parameter (new FormalParameter ("length", int_type));
			
			resize_method.returns_modified_pointer = true;
		}
		return resize_method;
	}
}
