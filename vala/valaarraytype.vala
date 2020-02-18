/* valaarraytype.vala
 *
 * Copyright (C) 2007-2012  Jürg Billeter
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

	/**
	 * The length type.
	 */
	public DataType? length_type {
		get { return _length_type; }
		set {
			_length_type = value;
			if (_length_type != null) {
				_length_type.parent_node = this;
			}
		}
	}

	public bool invalid_syntax { get; set; }

	public bool inline_allocated { get; set; }

	public bool fixed_length { get; set; }

	/**
	 * The length of this fixed-length array.
	 */
	public Expression? length {
		get { return _length; }
		set {
			_length = value;
			if (_length != null) {
				_length.parent_node = this;
			}
		}
	}

	/**
	 * The rank of this array.
	 */
	public int rank { get; set; }

	private DataType _element_type;
	private DataType _length_type;
	private Expression _length;

	private ArrayLengthField length_field;
	private ArrayResizeMethod resize_method;
	private ArrayMoveMethod move_method;
	private ArrayCopyMethod copy_method;

	public ArrayType (DataType element_type, int rank, SourceReference? source_reference) {
		base (null);
		this.element_type = element_type;
		this.rank = rank;
		this.source_reference = source_reference;
	}

	public override Symbol? get_member (string member_name) {
		if (error) {
			// don't try anything
		} else if (member_name == "length") {
			return get_length_field ();
		} else if (member_name == "move") {
			return get_move_method ();
		} else if (member_name == "resize") {
			if (rank > 1) {
				return null;
			}
			return get_resize_method ();
		} else if (member_name == "copy") {
			return get_copy_method ();
		}
		return null;
	}

	unowned ArrayLengthField get_length_field () {
		if (length_field == null) {
			length_field = new ArrayLengthField (source_reference);

			length_field.access = SymbolAccessibility.PUBLIC;

			if (rank > 1) {
				// length is an int[] containing the dimensions of the array, starting at 0
				length_field.variable_type = new ArrayType (length_type.copy (), 1, source_reference);
			} else {
				length_field.variable_type = length_type.copy ();
			}

		}
		return length_field;
	}

	unowned ArrayResizeMethod get_resize_method () {
		if (resize_method == null) {
			resize_method = new ArrayResizeMethod (source_reference);

			resize_method.return_type = new VoidType ();
			resize_method.access = SymbolAccessibility.PUBLIC;

			if (CodeContext.get ().profile == Profile.POSIX) {
				resize_method.set_attribute_string ("CCode", "cname", "realloc");
			} else {
				resize_method.set_attribute_string ("CCode", "cname", "g_renew");
			}

			resize_method.add_parameter (new Parameter ("length", length_type));

			resize_method.returns_modified_pointer = true;
		}
		return resize_method;
	}

	unowned ArrayMoveMethod get_move_method () {
		if (move_method == null) {
			move_method = new ArrayMoveMethod (source_reference);

			move_method.return_type = new VoidType ();
			move_method.access = SymbolAccessibility.PUBLIC;

			move_method.set_attribute_string ("CCode", "cname", "_vala_array_move");

			move_method.add_parameter (new Parameter ("src", length_type));
			move_method.add_parameter (new Parameter ("dest", length_type));
			move_method.add_parameter (new Parameter ("length", length_type));
		}
		return move_method;
	}

	unowned ArrayCopyMethod get_copy_method () {
		if (copy_method == null) {
			copy_method = new ArrayCopyMethod (source_reference);

			copy_method.return_type = this.copy ();
			copy_method.return_type.value_owned = true;
			copy_method.access = SymbolAccessibility.PUBLIC;

			copy_method.set_attribute_string ("CCode", "cname", "_vala_array_copy");
		}
		return copy_method;
	}

	public override DataType copy () {
		var result = new ArrayType (element_type.copy (), rank, source_reference);
		if (length_type != null) {
			result.length_type = length_type.copy ();
		}

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

	public override string to_qualified_string (Scope? scope) {
		var elem_str = element_type.to_qualified_string (scope);
		if (element_type.is_weak () && !(parent_node is Constant)) {
			elem_str = "(unowned %s)".printf (elem_str);
		}

		if (!fixed_length) {
			return "%s[%s]%s".printf (elem_str, string.nfill (rank - 1, ','), nullable ? "?" : "");
		} else {
			return elem_str;
		}
	}

	public override bool compatible (DataType target_type) {
		if (CodeContext.get ().profile == Profile.GOBJECT && target_type.type_symbol != null) {
			if (target_type.type_symbol.is_subtype_of (CodeContext.get ().analyzer.gvalue_type.type_symbol) && element_type.type_symbol == CodeContext.get ().root.scope.lookup ("string")) {
				// allow implicit conversion from string[] to GValue
				return true;
			}

			if (target_type.type_symbol.is_subtype_of (CodeContext.get ().analyzer.gvariant_type.type_symbol)) {
				// allow implicit conversion to GVariant
				return true;
			}
		}

		if (target_type is PointerType || (target_type.type_symbol != null && target_type.type_symbol.get_attribute ("PointerType") != null)) {
			/* any array type can be cast to a generic pointer */
			return true;
		}

		/* temporarily ignore type parameters */
		if (target_type is GenericType) {
			return true;
		}

		unowned ArrayType? target_array_type = target_type as ArrayType;
		if (target_array_type == null) {
			return false;
		}

		if (target_array_type.rank != rank) {
			return false;
		}

		if (element_type is ValueType && element_type.nullable != target_array_type.element_type.nullable) {
			return false;
		}

		if (!length_type.compatible (target_array_type.length_type)) {
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
		if (length_type != null) {
			length_type.accept (visitor);
		}
	}

	public override void replace_type (DataType old_type, DataType new_type) {
		if (element_type == old_type) {
			element_type = new_type;
		}
		if (length_type == old_type) {
			length_type = new_type;
		}
	}

	public override bool is_accessible (Symbol sym) {
		if (length_type != null && !length_type.is_accessible (sym)) {
			return false;
		}
		return element_type.is_accessible (sym);
	}

	public override bool check (CodeContext context) {
		if (invalid_syntax) {
			Report.error (source_reference, "syntax error, no expression allowed between array brackets");
			error = true;
			return false;
		}

		if (fixed_length && length != null) {
			length.check (context);

			if (length.value_type == null || !(length.value_type is IntegerType) || !length.is_constant ()) {
				error = true;
				Report.error (length.source_reference, "Expression of constant integer type expected");
				return false;
			}
		}

		if (element_type is ArrayType) {
			error = true;
			Report.error (source_reference, "Stacked arrays are not supported");
			return false;
		} else if (element_type is DelegateType) {
			var delegate_type = (DelegateType) element_type;
			if (delegate_type.delegate_symbol.has_target) {
				error = true;
				Report.error (source_reference, "Delegates with target are not supported as array element type");
				return false;
			}
		}

		if (length_type == null) {
			// Make sure that "int" is still picked up as default
			length_type = context.analyzer.int_type.copy ();
		} else {
			length_type.check (context);
			if (!(length_type is IntegerType)) {
				error = true;
				Report.error (length_type.source_reference, "Expected integer type as length type of array");
				return false;
			}
		}

		return element_type.check (context);
	}

	public override DataType get_actual_type (DataType? derived_instance_type, List<DataType>? method_type_arguments, CodeNode? node_reference) {
		ArrayType result = (ArrayType) this.copy ();

		if (derived_instance_type == null && method_type_arguments == null) {
			return result;
		}

		if (element_type is GenericType || element_type.has_type_arguments ()) {
			result.element_type = result.element_type.get_actual_type (derived_instance_type, method_type_arguments, node_reference);
		}

		return result;
	}

	public override DataType? infer_type_argument (TypeParameter type_param, DataType value_type) {
		unowned ArrayType? array_type = value_type as ArrayType;
		if (array_type != null) {
			return element_type.infer_type_argument (type_param, array_type.element_type);
		}

		return null;
	}

	public override bool is_disposable () {
		if (fixed_length) {
			return element_type.is_disposable ();
		} else {
			return base.is_disposable ();
		}
	}
}
