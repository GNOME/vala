/* valadatatype.vala
 *
 * Copyright (C) 2006-2007  Jürg Billeter, Raffaele Sandrini
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
 *	Raffaele Sandrini <rasa@gmx.ch>
 */

using GLib;
using Gee;

/**
 * A reference to a data type. This is used to specify static types of
 * expressions.
 */
public class Vala.DataType : CodeNode {
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
	 * Specifies that the expression is a reference used in out parameters.
	 */
	public bool is_out { get; set; }
	
	/**
	 * Specifies that the expression is guaranteed not to be null.
	 */
	public bool non_null { get; set; }
	
	/**
	 * Specifies that the expression is known to be null.
	 */
	public bool is_null { get; set; }
	
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
	 * Specifies that the expression is a reference used in ref parameters.
	 */
	public bool is_ref { get; set; }

	private Gee.List<DataType> type_argument_list = new ArrayList<DataType> ();
	
	public DataType () {
	}

	/**
	 * Appends the specified type as generic type argument.
	 *
	 * @param arg a type reference
	 */
	public void add_type_argument (DataType! arg) {
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

	public override void accept (CodeVisitor! visitor) {
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
	public virtual string get_cname (bool var_type = false, bool const_type = false) {
		if (data_type == null && type_parameter == null) {
			if (var_type) {
				return "gpointer";
			} else {
				return "void";
			}
		}
		
		string ptr;
		if (type_parameter != null || (!data_type.is_reference_type () && !is_ref && !is_out)) {
			ptr = "";
		} else if ((data_type.is_reference_type () && !is_ref && !is_out) || (!data_type.is_reference_type () && (is_ref || is_out))) {
			ptr = "*";
		} else {
			ptr = "**";
		}
		if (data_type != null) {
			return data_type.get_cname (const_type) + ptr;
		} else if (type_parameter != null) {
			if (const_type) {
				return "gconstpointer";
			} else {
				return "gpointer";
			}
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
	public string get_const_cname () {
		string ptr;
		Typesymbol t;
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

	public override string! to_string () {
		string s;

		if (data_type != null) {
			s = data_type.get_full_name ();
		} else if (type_parameter != null) {
			s = type_parameter.name;
		} else {
			s = "null";
		}

		var type_args = get_type_arguments ();
		if (!(data_type is Array) && type_args.size > 0) {
			s += "<";
			bool first = true;
			foreach (DataType type_arg in type_args) {
				if (!first) {
					s += ",";
				} else {
					first = false;
				}
				if (!type_arg.takes_ownership) {
					s += "weak ";
				}
				if (type_arg.data_type != null) {
					s += type_arg.data_type.get_full_name ();
				} else {
					s += type_arg.type_parameter.name;
				}
			}
			s += ">";
		}
		if (non_null) {
			s += "!";
		}

		return s;
	}
	
	/**
	 * Creates a shallow copy of this type reference.
	 *
	 * @return copy of this type reference
	 */
	public virtual DataType! copy () {
		var result = new DataType ();
		result.source_reference = source_reference;
		result.transfers_ownership = transfers_ownership;
		result.takes_ownership = takes_ownership;
		result.is_out = is_out;
		result.non_null = non_null;
		result.data_type = data_type;
		result.type_parameter = type_parameter;
		result.floating_reference = floating_reference;
		result.is_ref = is_ref;
		
		foreach (DataType arg in type_argument_list) {
			result.type_argument_list.add (arg.copy ());
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
	public bool equals (DataType! type2) {
		if (type2.transfers_ownership != transfers_ownership) {
			return false;
		}
		if (type2.takes_ownership != takes_ownership) {
			return false;
		}
		if (type2.is_ref != is_ref) {
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
	public virtual bool stricter (DataType! type2) {
		if (type2.transfers_ownership != transfers_ownership) {
			return false;
		}
		if (type2.takes_ownership != takes_ownership) {
			return false;
		}
		if (type2.is_ref != is_ref) {
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

	public override void replace_type (DataType! old_type, DataType! new_type) {
		for (int i = 0; i < type_argument_list.size; i++) {
			if (type_argument_list[i] == old_type) {
				type_argument_list[i] = new_type;
				return;
			}
		}
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
	public virtual DataType get_return_type () {
		return null;
	}

	/**
	 * Returns copy of the list of invocation parameters.
	 *
	 * @return parameter list
	 */
	public virtual Collection<FormalParameter> get_parameters () {
		return null;
	}
}
