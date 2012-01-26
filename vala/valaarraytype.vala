/* valaarraytype.vala
 *
 * Copyright (C) 2007-2011  Jürg Billeter
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
	public DataType element_type {
		get { return _element_type; }
		set {
			_element_type = value;
			_element_type.parent_node = this;
		}
	}

	public bool invalid_syntax { get; set; }

	public bool inline_allocated { get; set; }

	public bool fixed_length { get; set; }

	/**
	 * The length of this fixed-length array.
	 */
	public int length { get; set; }

	/**
	 * The rank of this array.
	 */
	public int rank { get; set; }

	private DataType _element_type;

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
				ValueType integer = new IntegerType ((Struct) root_symbol.scope.lookup ("int"));
				length_field.variable_type = new ArrayType (integer, 1, source_reference);
			} else {
				length_field.variable_type = new IntegerType ((Struct) root_symbol.scope.lookup ("int"));
			}

		}
		return length_field;
	}

	private ArrayResizeMethod get_resize_method () {
		if (resize_method == null) {
			resize_method = new ArrayResizeMethod (source_reference);

			resize_method.return_type = new VoidType ();
			resize_method.access = SymbolAccessibility.PUBLIC;

			resize_method.set_attribute_string ("CCode", "cname", "g_renew");
			
			var root_symbol = source_reference.file.context.root;
			var int_type = new IntegerType ((Struct) root_symbol.scope.lookup ("int"));

			resize_method.add_parameter (new Parameter ("length", int_type));
			
			resize_method.returns_modified_pointer = true;
		}
		return resize_method;
	}

	private ArrayMoveMethod get_move_method () {
		if (move_method == null) {
			move_method = new ArrayMoveMethod (source_reference);

			move_method.return_type = new VoidType ();
			move_method.access = SymbolAccessibility.PUBLIC;

			move_method.set_attribute_string ("CCode", "cname", "_vala_array_move");

			var root_symbol = source_reference.file.context.root;
			var int_type = new IntegerType ((Struct) root_symbol.scope.lookup ("int"));

			move_method.add_parameter (new Parameter ("src", int_type));
			move_method.add_parameter (new Parameter ("dest", int_type));
			move_method.add_parameter (new Parameter ("length", int_type));
		}
		return move_method;
	}

	public override DataType copy () {
		var result = new ArrayType (element_type.copy (), rank, source_reference);
		result.value_owned = value_owned;
		result.nullable = nullable;
		result.floating_reference = floating_reference;

		result.inline_allocated = inline_allocated;
		if (fixed_length) {
			result.fixed_length = true;
			result.length = length;
		}

		return result;
	}

	public override bool is_array () {
		return true;
	}

	public override string to_qualified_string (Scope? scope) {
		return "%s[%s]%s".printf (element_type.to_qualified_string (scope), string.nfill (rank - 1, ','), nullable ? "?" : "");
	}

	public override bool compatible (DataType target_type) {
		if (CodeContext.get ().profile == Profile.GOBJECT && target_type.data_type != null) {
			if (target_type.data_type.is_subtype_of (CodeContext.get ().analyzer.gvalue_type.data_type) && element_type.data_type == CodeContext.get ().root.scope.lookup ("string")) {
				// allow implicit conversion from string[] to GValue
				return true;
			}

			if (target_type.data_type.is_subtype_of (CodeContext.get ().analyzer.gvariant_type.data_type)) {
				// allow implicit conversion to GVariant
				return true;
			}
		}

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

		if (target_array_type.rank != rank) {
			return false;
		}

		if (element_type is ValueType && element_type.nullable != target_array_type.element_type.nullable) {
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

	public override void accept_children (CodeVisitor visitor) {
		element_type.accept (visitor);
	}

	public override void replace_type (DataType old_type, DataType new_type) {
		if (element_type == old_type) {
			element_type = new_type;
		}
	}

	public override bool is_accessible (Symbol sym) {
		return element_type.is_accessible (sym);
	}

	public override bool check (CodeContext context) {
		if (invalid_syntax) {
			Report.error (source_reference, "syntax error, no expression allowed between array brackets");
			error = true;
			return false;
		}
		return element_type.check (context);
	}

	public override DataType get_actual_type (DataType? derived_instance_type, MemberAccess? method_access, CodeNode node_reference) {
		if (derived_instance_type == null && method_access == null) {
			return this;
		}

		ArrayType result = this;

		if (element_type is GenericType || element_type.has_type_arguments ()) {
			result = (ArrayType) result.copy ();
			result.element_type = result.element_type.get_actual_type (derived_instance_type, method_access, node_reference);
		}

		return result;
	}

	public override bool is_disposable () {
		if (fixed_length) {
			return element_type.is_disposable ();
		} else if (CodeContext.get ().profile == Profile.DOVA) {
			return false;
		} else {
			return base.is_disposable ();
		}
	}
}
