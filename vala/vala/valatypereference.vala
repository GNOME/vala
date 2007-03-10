/* valatypereference.vala
 *
 * Copyright (C) 2006-2007  Jürg Billeter, Raffaele Sandrini
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
 *	Raffaele Sandrini <rasa@gmx.ch>
 */

using GLib;

/**
 * A reference to a data type. This is used to specify static types of
 * expressions.
 */
public class Vala.TypeReference : CodeNode {
	/**
	 * Specifies that the expression is a reference to a value type.
	 * References to value types are used in ref parameters.
	 */
	public bool reference_to_value_type { get; set; }
	
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
	 * Specifies that the expression is a reference to a reference type.
	 * References to reference types are used in out parameters.
	 */
	public bool is_out { get; set; }
	
	/**
	 * Specifies that the expression is guaranteed not to be null.
	 */
	public bool non_null { get; set; }
	
	/**
	 * The referred data type.
	 */
	public weak DataType data_type { get; set; }
	
	/**
	 * The referred generic type parameter.
	 */
	public TypeParameter type_parameter { get; set; }
	
	/**
	 * Specifies that the expression transfers a floating reference.
	 */
	public bool floating_reference { get; set; }
	
	/**
	 * The name of the namespace containing the referred data type. May only
	 * be used with unresolved type references.
	 */
	public string namespace_name { get; set; }
	
	/**
	 * The name of the referred data type. May only be used with unresolved
	 * type references.
	 */
	public string type_name { get; set; }
	
	/**
	 * Specifies the rank of the array this reference is possibly referring to. "0" indicates no array.
	 * WARNING: This property may only be set by the parser and only be read by the symbol resolver.
	 */
	public int array_rank { get; set; }
	
	/**
	 * The ref modifier has been specified, may only be used with unresolved
	 * type references.
	 */
	public bool is_ref { get; set; }
	
	/**
	 * The weak modifier has been specified. May only be used with
	 * unresolved type references.
	 */
	public bool is_weak { get; set; }

	private List<TypeReference> type_argument_list;
	
	public TypeReference () {
	}

	/**
	 * Creates a new type reference.
	 *
	 * @param ns        optional namespace name
	 * @param type_name type symbol name
	 * @param source    reference to source code
	 * @return          newly created type reference
	 */
	public TypeReference.from_name (string ns, string! type, SourceReference source = null) {
		namespace_name = ns;
		type_name = type;
		source_reference = source;
	}

	/**
	 * Creates a new type reference from a code expression.
	 *
	 * @param expr   member access expression
	 * @param source reference to source code
	 * @return       newly created type reference
	 */
	public static ref TypeReference new_from_expression (Expression! expr) {
		string ns = null;
		string type_name = null;
		if (expr is MemberAccess) {
			TypeReference type_ref = null;
		
			MemberAccess ma = (MemberAccess) expr;
			if (ma.inner != null) {
				if (ma.inner is MemberAccess) {
					var simple = (MemberAccess) ma.inner;
					type_ref = new TypeReference.from_name (simple.member_name, ma.member_name, ma.source_reference);
				}
			} else {
				type_ref = new TypeReference.from_name (null, ma.member_name, ma.source_reference);
			}
			
			if (type_ref != null) {
				var type_args = ma.get_type_arguments ();
				foreach (TypeReference arg in type_args) {
					type_ref.add_type_argument (arg);
				}
				
				return type_ref;
			}
		}
		
		Report.error (expr.source_reference, "Type reference must be simple name or member access expression");
		return null;
	}
	
	/**
	 * Appends the specified type as generic type argument.
	 *
	 * @param arg a type reference
	 */
	public void add_type_argument (TypeReference! arg) {
		type_argument_list.append (arg);
	}
	
	/**
	 * Returns a copy of the list of generic type arguments.
	 *
	 * @return type argument list
	 */
	public ref List<weak TypeReference> get_type_arguments () {
		return type_argument_list.copy ();
	}
	
	public override void accept (CodeVisitor! visitor) {
		foreach (TypeReference type_arg in type_argument_list) {
			type_arg.accept (visitor);
		}
	
		visitor.visit_type_reference (this);
	}

	/**
	 * Returns the name and qualifiers of this type as it is used in C code.
	 *
	 * @return the type string to be used in C code
	 */
	public ref string get_cname (bool var_type = false, bool const_type = false) {
		if (data_type == null && type_parameter == null) {
			if (var_type) {
				return "gpointer";
			} else {
				return "void";
			}
		}
		
		string ptr;
		string arr;
		if (type_parameter != null || (!data_type.is_reference_type () && !reference_to_value_type)) {
			ptr = "";
		} else if ((data_type.is_reference_type () && !is_out) || reference_to_value_type) {
			ptr = "*";
		} else {
			ptr = "**";
		}
		if (data_type != null) {
			return data_type.get_cname (const_type).concat (ptr, arr, null);
		} else if (type_parameter != null) {
			return "gpointer".concat (ptr, arr, null);
		} else {
			/* raise error */
			Report.error (source_reference, "unresolved type reference");
			return null;
		}
	}

	/**
	 * Returns the name and qualifiers of this type as it is used in C code
	 * in a const declaration.
	 *
	 * @return the type string to be used in C code const declarations
	 */
	public ref string get_const_cname () {
		string ptr;
		DataType t;
		/* FIXME: dirty hack to make constant arrays possible */
		if (data_type is Array) {
			t = ((Array) data_type).element_type;
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
	 * Returns a user-readable name of the type corresponding to this type
	 * reference.
	 *
	 * @return display name
	 */
	public ref string! to_string () {
		if (data_type != null) {
			return data_type.symbol.get_full_name ();
		} else if (type_parameter != null) {
			return type_parameter.name;
		} else {
			return "null";
		}
	}
	
	/**
	 * Creates a shallow copy of this type reference. May only be used with
	 * resolved type references.
	 *
	 * @return copy of this type reference
	 */
	public ref TypeReference! copy () {
		var result = new TypeReference ();
		result.reference_to_value_type = reference_to_value_type;
		result.transfers_ownership = transfers_ownership;
		result.takes_ownership = takes_ownership;
		result.is_out = is_out;
		result.non_null = non_null;
		result.data_type = data_type;
		result.type_parameter = type_parameter;
		
		foreach (TypeReference arg in type_argument_list) {
			result.type_argument_list.append (arg.copy ());
		}
		
		return result;
	}
	
	/**
	 * Checks two type references for equality. May only be used with
	 * resolved type references.
	 *
	 * @param type2 a type reference
	 * @return      true if this type reference is equal to type2, false
	 *              otherwise
	 */
	public bool equals (TypeReference! type2) {
		if (type2.reference_to_value_type != reference_to_value_type) {
			return false;
		}
		if (type2.transfers_ownership != transfers_ownership) {
			return false;
		}
		if (type2.takes_ownership != takes_ownership) {
			return false;
		}
		if (type2.is_out != is_out) {
			return false;
		}
		if (type2.non_null != non_null) {
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
	public bool stricter (TypeReference! type2) {
		if (type2.reference_to_value_type != reference_to_value_type) {
			return false;
		}
		if (type2.transfers_ownership != transfers_ownership) {
			return false;
		}
		if (type2.takes_ownership != takes_ownership) {
			return false;
		}
		if (type2.is_out != is_out) {
			return false;
		}
		
		if (type2.non_null && !non_null) {
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
}
