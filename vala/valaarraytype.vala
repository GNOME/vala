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
	
	private ArrayLengthField length_field;
	private ArrayResizeMethod resize_method;
	private ArrayMoveMethod move_method;

	public ArrayType (DataType element_type, int rank, SourceReference? source_reference) {
		this.element_type = element_type;
		this.rank = rank;
		this.source_reference = source_reference;
	}

	public override Symbol? get_member (string member_name) {
		if (member_name == "length") {
			return get_length_field ();
		} else if (member_name == "move") {
			return get_move_method ();
		} else if (member_name == "resize") {
			return get_resize_method ();
		}
		return null;
	}

	private ArrayLengthField get_length_field () {
		if (length_field == null) {
			length_field = new ArrayLengthField (source_reference);

			length_field.access = SymbolAccessibility.PUBLIC;

			var root_symbol = source_reference.file.context.root;
			if (rank > 1) {
				// length is an int[] containing the dimensions of the array, starting at 0
				ValueType integer = new ValueType((Typesymbol) root_symbol.scope.lookup("int"));
				length_field.type_reference = new ArrayType (integer, 1, source_reference);
				length_field.type_reference.add_type_argument (integer);
			} else {
				length_field.type_reference = new ValueType ((Typesymbol) root_symbol.scope.lookup ("int"));
			}

		}
		return length_field;
	}

	private ArrayResizeMethod get_resize_method () {
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

	private ArrayMoveMethod get_move_method () {
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

	public override DataType copy () {
		var result = new ArrayType (element_type, rank, source_reference);
		result.transfers_ownership = transfers_ownership;
		result.takes_ownership = takes_ownership;
		result.is_out = is_out;
		result.nullable = nullable;
		result.floating_reference = floating_reference;
		result.is_ref = is_ref;
		
		foreach (DataType arg in get_type_arguments ()) {
			result.add_type_argument (arg.copy ());
		}
		
		return result;
	}

	public override string get_cname (bool var_type, bool const_type) {
		return element_type.get_cname () + "*";
	}

	public override bool is_array () {
		return true;
	}

	public override string to_string () {
		return element_type.to_string () + "[]";
	}

	public override bool compatible (DataType target_type) {
		if (target_type is PointerType || (target_type.data_type != null && target_type.data_type.get_attribute ("PointerType") != null)) {
			/* any array type can be cast to a generic pointer */
			return true;
		}

		/* temporarily ignore type parameters */
		if (target_type.type_parameter != null) {
			return true;
		}

		var target_array_type = target_type as ArrayType;
		if (target_array_type == null) {
			return false;
		}

		if (element_type.compatible (target_array_type.element_type)
		    && target_array_type.element_type.compatible (element_type)) {
			return true;
		}

		return false;
	}

	public override bool is_reference_type_or_type_parameter () {
		return true;
	}
}
