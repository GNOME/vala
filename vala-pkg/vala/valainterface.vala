/* valainterface.vala
 *
 * Copyright (C) 2006-2007  Jürg Billeter
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
 * Represents a class declaration in the source code.
 */
public class Vala.Interface : DataType {
	/**
	 * Specifies whether this interface is static. Static interfaces are not
	 * available at run-time. They can be implemented by structs.
	 */
	public bool is_static { get; set; }

	private List<TypeParameter> type_parameters;
	
	private List<TypeReference> prerequisites;

	private List<Method> methods;
	private List<Property> properties;
	private List<Signal> signals;
	
	private string cname;
	private string lower_case_csuffix;
	private string type_cname;
	private string type_id;
	
	/**
	 * Creates a new interface.
	 *
	 * @param name   type name
	 * @param source reference to source code
	 * @return       newly created interface
	 */
	public Interface (string! _name, SourceReference source = null) {
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
	 * Adds the specified interface or class to the list of prerequisites of
	 * this interface.
	 *
	 * @param type an interface or class reference
	 */
	public void add_prerequisite (TypeReference! type) {
		prerequisites.append (type);
	}

	/**
	 * Returns a copy of the base type list.
	 *
	 * @return list of base types
	 */
	public ref List<weak TypeReference> get_prerequisites () {
		return prerequisites.copy ();
	}
	
	/**
	 * Adds the specified method as a member to this interface.
	 *
	 * @param m a method
	 */
	public void add_method (Method! m) {
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
	
	/**
	 * Adds the specified property as a member to this interface.
	 *
	 * @param prop a property
	 */
	public void add_property (Property! prop) {
		properties.append (prop);
	}
	
	/**
	 * Returns a copy of the list of properties.
	 *
	 * @return list of properties
	 */
	public ref List<weak Property> get_properties () {
		return properties.copy ();
	}
	
	/**
	 * Adds the specified signal as a member to this interface.
	 *
	 * @param sig a signal
	 */
	public void add_signal (Signal! sig) {
		signals.append (sig);
	}
	
	/**
	 * Returns a copy of the list of signals.
	 *
	 * @return list of signals
	 */
	public ref List<weak Signal> get_signals () {
		return signals.copy ();
	}
	
	public override string get_cname (bool const_type = false) {
		if (cname == null) {
			cname = "%s%s".printf (@namespace.get_cprefix (), name);
		}
		return cname;
	}
	
	/**
	 * Returns the string to be prepended to the name of members of this
	 * interface when used in C code.
	 *
	 * @return the suffix to be used in C code
	 */
	public string! get_lower_case_csuffix () {
		if (lower_case_csuffix == null) {
			lower_case_csuffix = Namespace.camel_case_to_lower_case (name);
		}
		return lower_case_csuffix;
	}
	
	/**
	 * Sets the string to be prepended to the name of members of this
	 * interface when used in C code.
	 *
	 * @param csuffix the suffix to be used in C code
	 */
	public void set_lower_case_csuffix (string! csuffix) {
		this.lower_case_csuffix = csuffix;
	}
	
	public override ref string get_lower_case_cname (string infix) {
		if (infix == null) {
			infix = "";
		}
		return "%s%s%s".printf (@namespace.get_lower_case_cprefix (), infix, get_lower_case_csuffix ());
	}
	
	public override ref string get_lower_case_cprefix () {
		return "%s_".printf (get_lower_case_cname (null));
	}
	
	public override ref string get_upper_case_cname (string infix) {
		return get_lower_case_cname (infix).up ();
	}
	
	public override void accept (CodeVisitor! visitor) {
		visitor.visit_begin_interface (this);
		
		foreach (TypeReference type in prerequisites) {
			type.accept (visitor);
		}

		foreach (TypeParameter p in type_parameters) {
			p.accept (visitor);
		}
		
		foreach (Method m in methods) {
			m.accept (visitor);
		}
		
		foreach (Property prop in properties) {
			prop.accept (visitor);
		}
		
		foreach (Signal sig in signals) {
			sig.accept (visitor);
		}

		visitor.visit_end_interface (this);
	}

	public override bool is_reference_type () {
		return true;
	}

	public override bool is_reference_counting () {
		return true;
	}
	
	public override string get_ref_function () {
		return "g_object_ref";
	}
	
	public override string get_unref_function () {
		return "g_object_unref";
	}

	public override bool is_subtype_of (DataType! t) {
		foreach (TypeReference prerequisite in prerequisites) {
			if (prerequisite.data_type == t ||
			    prerequisite.data_type.is_subtype_of (t)) {
				return true;
			}
		}
		
		return false;
	}
	
	private void process_ccode_attribute (Attribute! a) {
		if (a.has_argument ("type_cname")) {
			set_type_cname (a.get_string ("type_cname"));
		}
	}
	
	/**
	 * Process all associated attributes.
	 */
	public void process_attributes () {
		foreach (Attribute a in attributes) {
			if (a.name == "CCode") {
				process_ccode_attribute (a);
			}
		}
	}
	
	/**
	 * Returns the name of the type struct as it is used in C code.
	 *
	 * @return the type struct name to be used in C code
	 */
	public string get_type_cname () {
		if (type_cname == null) {
			type_cname = "%sIface".printf (get_cname ());
		}
		return type_cname;
	}
	
	/**
	 * Sets the name of the type struct as it is used in C code.
	 *
	 * @param type_cname the type struct name to be used in C code
	 */
	public void set_type_cname (string! type_cname) {
		this.type_cname = type_cname;
	}

	public override string get_marshaller_type_name () {
		return "OBJECT";
	}

	public override string get_get_value_function () {
		return "g_value_get_object";
	}
	
	public override string get_set_value_function () {
		return "g_value_set_object";
	}

	public override string get_type_id () {
		if (type_id == null) {
			type_id = get_upper_case_cname ("TYPE_");
		}
		
		return type_id;
	}

	public override int get_type_parameter_index (string! name) {
		int i = 0;
		foreach (TypeParameter parameter in type_parameters) {
			if (parameter.name == name) {
				return i;
			}
			i++;
		}
		return -1;
	}
}
