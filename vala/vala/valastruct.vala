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
	List<TypeParameter> type_parameters;
	List<Constant> constants;
	List<Field> fields;
	List<Method> methods;
	
	string cname;
	string dup_function;
	string free_function;
	string type_id;
	string lower_case_cprefix;
	string lower_case_csuffix;
	bool reference_type;
	string marshaller_type_name;
	
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
	public ref List<Field> get_fields () {
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
	public ref List<Method> get_methods () {
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
	
	/**
	 * Process all associated attributes.
	 */
	public void process_attributes () {
		foreach (Attribute a in attributes) {
			if (a.name == "CCode") {
				process_ccode_attribute (a);
			} else if (a.name == "ReferenceType") {
				process_ref_type_attribute (a);
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
}
