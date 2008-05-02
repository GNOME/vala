/* valadatatype.vala
 *
 * Copyright (C) 2006-2008  Jürg Billeter, Raffaele Sandrini
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
 *	Raffaele Sandrini <raffaele@sandrini.ch>
 */

using GLib;
using Gee;

/**
 * A reference to a data type. This is used to specify static types of
 * expressions.
 */
public abstract class Vala.DataType : CodeNode {
	/**
	 * Specifies that the expression transfers ownership of its value.
	 */
	public bool transfers_ownership { get; set; }
	
	/**
	 * Specifies that the expression assumes ownership if used as an lvalue
	 * in an assignment.
	 */
	public bool takes_ownership { get; set; }

	/**
	 * Specifies that the expression may be null.
	 */
	public bool nullable { get; set; }

	/**
	 * The referred data type.
	 */
	public weak Typesymbol data_type { get; set; }
	
	/**
	 * The referred generic type parameter.
	 */
	public TypeParameter type_parameter { get; set; }
	
	/**
	 * Specifies that the expression transfers a floating reference.
	 */
	public bool floating_reference { get; set; }

	/**
	 * Specifies that the type supports dynamic lookup.
	 */
	public bool is_dynamic { get; set; }

	private Gee.List<DataType> type_argument_list = new ArrayList<DataType> ();

	/**
	 * Appends the specified type as generic type argument.
	 *
	 * @param arg a type reference
	 */
	public void add_type_argument (DataType arg) {
		type_argument_list.add (arg);
		arg.parent_node = this;
	}
	
	/**
	 * Returns a copy of the list of generic type arguments.
	 *
	 * @return type argument list
	 */
	public Gee.List<DataType> get_type_arguments () {
		return new ReadOnlyList<DataType> (type_argument_list);
	}

	/**
	 * Removes all generic type arguments.
	 */
	public void remove_all_type_arguments () {
		type_argument_list.clear ();
	}

	public override void accept (CodeVisitor visitor) {
		if (type_argument_list.size > 0) {
			foreach (DataType type_arg in type_argument_list) {
				type_arg.accept (visitor);
			}
		}
	
		visitor.visit_data_type (this);
	}

	/**
	 * Returns the name and qualifiers of this type as it is used in C code.
	 *
	 * @return the type string to be used in C code
	 */
	public virtual string? get_cname () {
		// raise error
		Report.error (source_reference, "unresolved type reference");
		return null;
	}

	/**
	 * Returns the name and qualifiers of this type as it is used in C code
	 * in a const declaration.
	 *
	 * @return the type string to be used in C code const declarations
	 */
	public string get_const_cname () {
		string ptr;
		Typesymbol t;
		// FIXME: workaround to make constant arrays possible
		if (this is ArrayType) {
			t = ((ArrayType) this).element_type.data_type;
		} else {
			t = data_type;
		}
		if (!t.is_reference_type ()) {
			ptr = "";
		} else {
			ptr = "*";
		}
		
		return "const %s%s".printf (t.get_cname (), ptr);
	}

	/**
	 * Returns the C name of this data type in lower case. Words are
	 * separated by underscores.
	 *
	 * @param infix a string to be placed between namespace and data type
	 *              name or null
	 * @return      the lower case name to be used in C code
	 */
	public virtual string? get_lower_case_cname (string? infix = null) {
		return data_type.get_lower_case_cname (infix);
	}

	public override string to_string () {
		string s;

		if (data_type != null) {
			s = data_type.get_full_name ();
		} else if (type_parameter != null) {
			s = type_parameter.name;
		} else {
			s = "null";
		}

		var type_args = get_type_arguments ();
		if (!(this is ArrayType) && type_args.size > 0) {
			s += "<";
			bool first = true;
			foreach (DataType type_arg in type_args) {
				if (!first) {
					s += ",";
				} else {
					first = false;
				}
				if (type_arg.is_reference_type_or_type_parameter () && !type_arg.takes_ownership) {
					s += "weak ";
				}
				s += type_arg.to_string ();
			}
			s += ">";
		}
		if (nullable) {
			s += "?";
		}

		return s;
	}
	
	/**
	 * Creates a shallow copy of this type reference.
	 *
	 * @return copy of this type reference
	 */
	public abstract DataType copy ();

	/**
	 * Checks two type references for equality. May only be used with
	 * resolved type references.
	 *
	 * @param type2 a type reference
	 * @return      true if this type reference is equal to type2, false
	 *              otherwise
	 */
	public virtual bool equals (DataType type2) {
		if (type2.transfers_ownership != transfers_ownership) {
			return false;
		}
		if (type2.takes_ownership != takes_ownership) {
			return false;
		}
		if (type2.nullable != nullable) {
			return false;
		}
		if (type2.data_type != data_type) {
			return false;
		}
		if (type2.type_parameter != null || type_parameter != null) {
			if (type2.type_parameter == null || type_parameter == null) {
				return false;
			}
			if (!type2.type_parameter.equals (type_parameter)) {
				return false;
			}
		}
		if (type2.floating_reference != floating_reference) {
			return false;
		}
	
		return true;
	}
	
	/**
	 * Checks whether this type reference is at least as strict as the
	 * specified type reference type2.
	 *
	 * @param type2 a type reference
	 * @return      true if this type reference is stricter or equal
	 */
	public virtual bool stricter (DataType type2) {
		if (type2.transfers_ownership != transfers_ownership) {
			return false;
		}
		if (type2.takes_ownership != takes_ownership) {
			return false;
		}
		
		if (!type2.nullable && nullable) {
			return false;
		}

		if (type2.data_type != data_type) {
			// FIXME: allow this type reference to refer to a
			//        subtype of the type type2 is referring to
			return false;
		}
		if (type2.type_parameter != type_parameter) {
			return false;
		}
		if (type2.floating_reference != floating_reference) {
			return false;
		}
		
		return true;
	}

	public override void replace_type (DataType old_type, DataType new_type) {
		for (int i = 0; i < type_argument_list.size; i++) {
			if (type_argument_list[i] == old_type) {
				type_argument_list[i] = new_type;
				return;
			}
		}
	}

	public virtual bool compatible (DataType target_type) {
		if (target_type is DelegateType && this is DelegateType) {
			return ((DelegateType) target_type).delegate_symbol == ((DelegateType) this).delegate_symbol;
		}

		/* only null is compatible to null */
		if (!(target_type is PointerType) && target_type.data_type == null && target_type.type_parameter == null) {
			return (data_type == null && type_parameter == null);
		}

		if (target_type is PointerType || (target_type.data_type != null && target_type.data_type.get_attribute ("PointerType") != null)) {
			/* any reference or array type or pointer type can be cast to a generic pointer */
			if (type_parameter != null ||
				(data_type != null && (
					data_type.is_reference_type () ||
					this is DelegateType ||
					data_type.get_attribute ("PointerType") != null))) {
				return true;
			}

			return false;
		}

		/* temporarily ignore type parameters */
		if (target_type.type_parameter != null) {
			return true;
		}

		if (this is ArrayType != target_type is ArrayType) {
			return false;
		}

		if (data_type is Enum && target_type.data_type is Struct && ((Struct) target_type.data_type).is_integer_type ()) {
			return true;
		}

		if (data_type == target_type.data_type) {
			return true;
		}

		if (data_type is Struct && target_type.data_type is Struct) {
			var expr_struct = (Struct) data_type;
			var expect_struct = (Struct) target_type.data_type;

			/* integer types may be implicitly cast to floating point types */
			if (expr_struct.is_integer_type () && expect_struct.is_floating_type ()) {
				return true;
			}

			if ((expr_struct.is_integer_type () && expect_struct.is_integer_type ()) ||
			    (expr_struct.is_floating_type () && expect_struct.is_floating_type ())) {
				if (expr_struct.get_rank () <= expect_struct.get_rank ()) {
					return true;
				}
			}
		}

		if (data_type != null && target_type.data_type != null && data_type.is_subtype_of (target_type.data_type)) {
			return true;
		}

		return false;
	}

	/**
	 * Returns whether instances of this type are invokable.
	 *
	 * @return true if invokable, false otherwise
	 */
	public virtual bool is_invokable () {
		return false;
	}

	/**
	 * Returns the return type of this invokable.
	 *
	 * @return return type
	 */
	public virtual DataType? get_return_type () {
		return null;
	}

	/**
	 * Returns copy of the list of invocation parameters.
	 *
	 * @return parameter list
	 */
	public virtual Collection<FormalParameter>? get_parameters () {
		return null;
	}

	public virtual bool is_reference_type_or_type_parameter () {
		return (data_type != null &&
		        data_type.is_reference_type ()) ||
		       type_parameter != null;
	}

	public virtual bool is_array () {
		return false;
	}

	/**
	 * Returns a list of symbols that define this type.
	 *
	 * @return symbol list
	 */
	public virtual Collection<Symbol> get_symbols () {
		var symbols = new ArrayList<Symbol> ();
		if (data_type != null) {
			symbols.add (data_type);
		}
		return symbols;
	}

	public virtual Symbol? get_member (string member_name) {
		if (data_type != null) {
			return SemanticAnalyzer.symbol_lookup_inherited (data_type, member_name);
		}
		return null;
	}

	public virtual Symbol? get_pointer_member (string member_name) {
		return null;
	}

	/**
	 * Checks whether this data type references a real struct. A real struct
	 * is a struct which is not a simple (fundamental) type.
	 */
	public virtual bool is_real_struct_type () {
		var s = data_type as Struct;
		if (s != null && !s.is_simple_type ()) {
			return true;
		}
		return false;
	}

	public virtual string? get_type_id () {
		if (data_type != null) {
			return data_type.get_type_id ();
		} else {
			return null;
		}
	}

	/**
	 * Returns type signature as used for GVariant and D-Bus.
	 */
	public virtual string? get_type_signature () {
		if (data_type != null) {
			return data_type.get_type_signature ();
		} else {
			return null;
		}
	}
}
