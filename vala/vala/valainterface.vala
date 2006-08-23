/* valainterface.vala
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
 * Represents a class declaration in the source code.
 */
public class Vala.Interface : DataType {
	private List<TypeParameter> type_parameters;
	
	private List<TypeReference> base_types;

	private List<Method> methods;
	private List<Property> properties;
	private List<Signal> signals;
	
	/**
	 * Creates a new interface.
	 *
	 * @param name   type name
	 * @param source reference to source code
	 * @return       newly created interface
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
	 * Adds the specified interface to the list of prerequisites of this
	 * interface.
	 *
	 * @param type an interface reference
	 */
	public void add_base_type (TypeReference! type) {
		base_types.append (type);
	}

	/**
	 * Returns a copy of the base type list.
	 *
	 * @return list of base types
	 */
	public ref List<TypeReference> get_base_types () {
		return base_types.copy ();
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
	public ref List<Method> get_methods () {
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
	public ref List<Property> get_properties () {
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
	public ref List<Signal> get_signals () {
		return signals.copy ();
	}
	
	private string cname;
	private string lower_case_csuffix;
	
	public override string get_cname () {
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
		
		foreach (TypeReference type in base_types) {
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
		foreach (TypeReference base_type in base_types) {
			if (base_type.data_type == t ||
			    base_type.data_type.is_subtype_of (t)) {
				return true;
			}
		}
		
		return false;
	}
}
