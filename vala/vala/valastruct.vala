/* valastruct.vala
 *
 * Copyright (C) 2006  Jürg Billeter
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
 */

using GLib;

/**
 * Represents a struct declaration in the source code.
 */
public class Vala.Struct : DataType {
	private List<TypeParameter> type_parameters;
	private List<Constant> constants;
	private List<Field> fields;
	private List<Method> methods;

	private List<TypeReference> base_types;
	
	private string cname;
	private string dup_function;
	private string free_function;
	private string type_id;
	private string lower_case_cprefix;
	private string lower_case_csuffix;
	private bool reference_type;
	private bool integer_type;
	private bool floating_type;
	private int rank;
	private string marshaller_type_name;
	private string get_value_function;
	private string set_value_function;
	
	/**
	 * Specifies the default construction method.
	 */
	public Method default_construction_method { get; set; }
	
	/**
	 * Creates a new struct.
	 *
	 * @param name   type name
	 * @param source reference to source code
	 * @return       newly created struct
	 */
	public construct (string! _name, SourceReference source = null) {
		name = _name;
		source_reference = source;
	}

	/**
	 * Appends the specified parameter to the list of type parameters.
	 *
	 * @param p a type parameter
	 */
	public void add_type_parameter (TypeParameter! p) {
		type_parameters.append (p);
		p.type = this;
	}
	
	/**
	 * Adds the specified constant as a member to this struct.
	 *
	 * @param c a constant
	 */
	public void add_constant (Constant! c) {
		constants.append (c);
	}
	
	/**
	 * Adds the specified field as a member to this struct.
	 *
	 * @param f a field
	 */
	public void add_field (Field! f) {
		fields.append (f);
	}
	
	/**
	 * Returns a copy of the list of fields.
	 *
	 * @return list of fields
	 */
	public ref List<weak Field> get_fields () {
		return fields.copy ();
	}
	
	/**
	 * Adds the specified method as a member to this struct.
	 *
	 * @param m a method
	 */
	public void add_method (Method! m) {
		return_if_fail (m != null);
		
		methods.append (m);
	}
	
	/**
	 * Returns a copy of the list of methods.
	 *
	 * @return list of methods
	 */
	public ref List<weak Method> get_methods () {
		return methods.copy ();
	}
	
	public override void accept (CodeVisitor! visitor) {
		visitor.visit_begin_struct (this);
		
		foreach (TypeParameter p in type_parameters) {
			p.accept (visitor);
		}
		
		foreach (Field f in fields) {
			f.accept (visitor);
		}
		
		foreach (Constant c in constants) {
			c.accept (visitor);
		}
		
		foreach (Method m in methods) {
			m.accept (visitor);
		}

		visitor.visit_end_struct (this);
	}
	
	public override string get_cname () {
		if (cname == null) {
			cname = "%s%s".printf (@namespace.get_cprefix (), name);
		}
		return cname;
	}
	
	private void set_cname (string! cname) {
		this.cname = cname;
	}
	
	public override ref string get_lower_case_cprefix () {
		if (lower_case_cprefix == null) {
			lower_case_cprefix = "%s_".printf (get_lower_case_cname (null));
		}
		return lower_case_cprefix;
	}
	
	private string get_lower_case_csuffix () {
		if (lower_case_csuffix == null) {
			lower_case_csuffix = Namespace.camel_case_to_lower_case (name);
		}
		return lower_case_csuffix;
	}
	
	private void set_lower_case_csuffix (string! csuffix) {
		this.lower_case_csuffix = csuffix;
	}
	
	public override ref string get_lower_case_cname (string infix) {
		if (infix == null) {
			infix = "";
		}
		return "%s%s%s".printf (@namespace.get_lower_case_cprefix (), infix, get_lower_case_csuffix ());
	}
	
	public override ref string get_upper_case_cname (string infix) {
		return get_lower_case_cname (infix).up ();
	}
	
	public override bool is_reference_type () {
		return reference_type;
	}
	
	/**
	 * Returns whether this is an integer type.
	 *
	 * @return true if this is an integer type, false otherwise
	 */
	public bool is_integer_type () {
		return integer_type;
	}
	
	/**
	 * Returns whether this is a floating point type.
	 *
	 * @return true if this is a floating point type, false otherwise
	 */
	public bool is_floating_type () {
		return floating_type;
	}
	
	/**
	 * Returns the rank of this integer or floating point type.
	 *
	 * @return the rank if this is an integer or floating point type
	 */
	public int get_rank () {
		return rank;
	}
	
	/**
	 * Sets whether this data type has value or reference type semantics.
	 *
	 * @param ref_type true if this data type has reference type semantics
	 */
	public void set_is_reference_type (bool ref_type) {
		reference_type = ref_type;
	}
	
	private void process_ccode_attribute (Attribute! a) {
		foreach (NamedArgument arg in a.args) {
			if (arg.name == "cname") {
				/* this will already be checked during semantic analysis */
				if (arg.argument is LiteralExpression) {
					var lit = ((LiteralExpression) arg.argument).literal;
					if (lit is StringLiteral) {
						set_cname (((StringLiteral) lit).eval ());
					}
				}
			} else if (arg.name == "cprefix") {
				/* this will already be checked during semantic analysis */
				if (arg.argument is LiteralExpression) {
					var lit = ((LiteralExpression) arg.argument).literal;
					if (lit is StringLiteral) {
						lower_case_cprefix = ((StringLiteral) lit).eval ();
					}
				}
			} else if (arg.name == "cheader_filename") {
				/* this will already be checked during semantic analysis */
				if (arg.argument is LiteralExpression) {
					var lit = ((LiteralExpression) arg.argument).literal;
					if (lit is StringLiteral) {
						var val = ((StringLiteral) lit).eval ();
						foreach (string filename in val.split (",", 0)) {
							add_cheader_filename (filename);
						}
					}
				}
			} else if (arg.name == "type_id") {
				/* this will already be checked during semantic analysis */
				if (arg.argument is LiteralExpression) {
					var lit = ((LiteralExpression) arg.argument).literal;
					if (lit is StringLiteral) {
						set_type_id (((StringLiteral) lit).eval ());
					}
				}
			} else if (arg.name == "marshaller_type_name") {
				/* this will already be checked during semantic analysis */
				if (arg.argument is LiteralExpression) {
					var lit = ((LiteralExpression) arg.argument).literal;
					if (lit is StringLiteral) {
						set_marshaller_type_name (((StringLiteral) lit).eval ());
					}
				}
			} else if (arg.name == "get_value_function") {
				/* this will already be checked during semantic analysis */
				if (arg.argument is LiteralExpression) {
					var lit = ((LiteralExpression) arg.argument).literal;
					if (lit is StringLiteral) {
						set_get_value_function (((StringLiteral) lit).eval ());
					}
				}
			} else if (arg.name == "set_value_function") {
				/* this will already be checked during semantic analysis */
				if (arg.argument is LiteralExpression) {
					var lit = ((LiteralExpression) arg.argument).literal;
					if (lit is StringLiteral) {
						set_set_value_function (((StringLiteral) lit).eval ());
					}
				}
			}
		}
	}
	
	private void process_ref_type_attribute (Attribute! a) {
		reference_type = true;
		foreach (NamedArgument arg in a.args) {
			if (arg.name == "dup_function") {
				/* this will already be checked during semantic analysis */
				if (arg.argument is LiteralExpression) {
					var lit = ((LiteralExpression) arg.argument).literal;
					if (lit is StringLiteral) {
						set_dup_function (((StringLiteral) lit).eval ());
					}
				}
			} else if (arg.name == "free_function") {
				/* this will already be checked during semantic analysis */
				if (arg.argument is LiteralExpression) {
					var lit = ((LiteralExpression) arg.argument).literal;
					if (lit is StringLiteral) {
						set_free_function (((StringLiteral) lit).eval ());
					}
				}
			}
		}
	}
	
	private void process_integer_type_attribute (Attribute! a) {
		integer_type = true;
		foreach (NamedArgument arg in a.args) {
			if (arg.name == "rank") {
				/* this will already be checked during semantic analysis */
				if (arg.argument is LiteralExpression) {
					var lit = ((LiteralExpression) arg.argument).literal;
					if (lit is IntegerLiteral) {
						rank = ((IntegerLiteral) lit).value.to_int ();
					}
				}
			}
		}
	}
	
	private void process_floating_type_attribute (Attribute! a) {
		floating_type = true;
		foreach (NamedArgument arg in a.args) {
			if (arg.name == "rank") {
				/* this will already be checked during semantic analysis */
				if (arg.argument is LiteralExpression) {
					var lit = ((LiteralExpression) arg.argument).literal;
					if (lit is IntegerLiteral) {
						rank = ((IntegerLiteral) lit).value.to_int ();
					}
				}
			}
		}
	}
	
	/**
	 * Process all associated attributes.
	 */
	public void process_attributes () {
		foreach (Attribute a in attributes) {
			if (a.name == "CCode") {
				process_ccode_attribute (a);
			} else if (a.name == "ReferenceType") {
				process_ref_type_attribute (a);
			} else if (a.name == "IntegerType") {
				process_integer_type_attribute (a);
			} else if (a.name == "FloatingType") {
				process_floating_type_attribute (a);
			}
		}
	}

	public override bool is_reference_counting () {
		return false;
	}
	
	public override string get_dup_function () {
		if (dup_function == null) {
			Report.error (source_reference, "The type `%s` doesn't contain a copy function".printf (symbol.get_full_name ()));
		}
		return dup_function;
	}
	
	public void set_dup_function (string! name) {
		this.dup_function = name;
	}
	
	public override string get_free_function () {
		if (free_function == null) {
			Report.error (source_reference, "The type `%s` doesn't contain a free function".printf (symbol.get_full_name ()));
		}
		return free_function;
	}
	
	private void set_free_function (string! name) {
		this.free_function = name;
	}
	
	public override string get_type_id () {
		if (type_id == null) {
			Report.error (source_reference, "The type `%s` doesn't declare a type id".printf (symbol.get_full_name ()));
		}
		return type_id;
	}
	
	private void set_type_id (string! name) {
		this.type_id = name;
	}

	public override string get_marshaller_type_name () {
		if (marshaller_type_name == null) {
			Report.error (source_reference, "The type `%s` doesn't declare a marshaller type name".printf (symbol.get_full_name ()));
		}
		return marshaller_type_name;
	}
	
	private void set_marshaller_type_name (string! name) {
		this.marshaller_type_name = name;
	}
	
	public override string get_get_value_function () {
		if (get_value_function == null) {
			if (is_reference_type ()) {
				return "g_value_get_pointer";
			} else {
				Report.error (source_reference, "The value type `%s` doesn't declare a GValue get function".printf (symbol.get_full_name ()));
			}
		} else {
			return get_value_function;
		}
	}
	
	public override string get_set_value_function () {
		if (set_value_function == null) {
			if (is_reference_type ()) {
				return "g_value_set_pointer";
			} else {
				Report.error (source_reference, "The value type `%s` doesn't declare a GValue set function".printf (symbol.get_full_name ()));
			}
		} else {
			return set_value_function;
		}
	}
	
	private void set_get_value_function (string! function) {
		get_value_function = function;
	}
	
	private void set_set_value_function (string! function) {
		set_value_function = function;
	}

	/**
	 * Adds the specified struct to the list of base types of this struct.
	 *
	 * @param type a class or interface reference
	 */
	public void add_base_type (TypeReference! type) {
		base_types.append (type);
	}

	/**
	 * Returns a copy of the base type list.
	 *
	 * @return list of base types
	 */
	public ref List<weak TypeReference> get_base_types () {
		return base_types.copy ();
	}
	
	public override int get_type_parameter_index (string! name) {
		int i = 0;
		
		foreach (TypeParameter p in type_parameters) {
			if (p.name == name) {
				return (i);
			}
			i++;
		}
		
		return -1;
	}
}
