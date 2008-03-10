/* valaarray.vala
 *
 * Copyright (C) 2006-2007  Raffaele Sandrini, Jürg Billeter
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
 * Represents an array type i.e. everything with direct accessable elements.
 */
public class Vala.Array : Typesymbol {

	/**
	 * Typesymbol of which this is an array of.
	 */
	public weak Typesymbol element_type { get; set construct; }
	
	/**
	 * TypeParameter of which this is an array of.
	 */
	public weak TypeParameter element_type_parameter { get; set construct; }
	
	/**
	 * The rank of this array.
	 */
	public int rank { get; set construct; }
	
	private string cname;
	
	private ArrayLengthField length_field;
	private ArrayResizeMethod resize_method;
	private ArrayMoveMethod move_method;
	
	public Array (Typesymbol! _element_type, int _rank, SourceReference _source_reference) {
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
		assert (rank >= 1);

		string commas = string.nfill (rank - 1, ',');

		if (element_type != null) {
			name = "%s[%s]".printf (element_type.name, commas);
		} else {
			name = "%s[%s]".printf (element_type_parameter.name, commas);
		}
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

	public override Collection<string> get_cheader_filenames () {
		if (element_type != null) {
			return element_type.get_cheader_filenames ();
		} else {
			return base.get_cheader_filenames ();
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

	public override string get_type_id () {
		if (element_type == source_reference.file.context.root.scope.lookup ("string")) {
			return "G_TYPE_STRV";
		} else {
			return null;
		}
	}

	public ArrayLengthField get_length_field () {
		if (length_field == null) {
			length_field = new ArrayLengthField (source_reference);

			length_field.access = SymbolAccessibility.PUBLIC;

			var root_symbol = source_reference.file.context.root;
			if (rank > 1) {
				// length is an int[] containing the dimensions of the array, starting at 0
				ValueType integer = new ValueType((Typesymbol) root_symbol.scope.lookup("int"));
				length_field.type_reference = new ArrayType (integer, 1);
				length_field.type_reference.add_type_argument (integer);
			} else {
				length_field.type_reference = new ValueType ((Typesymbol) root_symbol.scope.lookup ("int"));
			}

		}
		return length_field;
	}

	public ArrayResizeMethod get_resize_method () {
		if (resize_method == null) {
			resize_method = new ArrayResizeMethod (source_reference);

			resize_method.return_type = new VoidType ();
			resize_method.access = SymbolAccessibility.PUBLIC;

			resize_method.set_cname ("g_renew");
			
			var root_symbol = source_reference.file.context.root;
			var int_type = new ValueType ((Typesymbol) root_symbol.scope.lookup ("int"));

			resize_method.add_parameter (new FormalParameter ("length", int_type));
			
			resize_method.returns_modified_pointer = true;
		}
		return resize_method;
	}

	public ArrayMoveMethod get_move_method () {
		if (move_method == null) {
			move_method = new ArrayMoveMethod (source_reference);

			move_method.return_type = new VoidType ();
			move_method.access = SymbolAccessibility.PUBLIC;

			move_method.set_cname ("_vala_array_move");

			var root_symbol = source_reference.file.context.root;
			var int_type = new ValueType ((Typesymbol) root_symbol.scope.lookup ("int"));

			move_method.add_parameter (new FormalParameter ("src", int_type));
			move_method.add_parameter (new FormalParameter ("dest", int_type));
			move_method.add_parameter (new FormalParameter ("length", int_type));
		}
		return move_method;
	}
}
