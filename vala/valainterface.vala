/* valainterface.vala
 *
 * Copyright (C) 2006-2007  Jürg Billeter
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
using Gee;

/**
 * Represents a class declaration in the source code.
 */
public class Vala.Interface : Typesymbol {
	/**
	 * Specifies whether this interface is static. Static interfaces are not
	 * available at run-time. They can be implemented by structs.
	 */
	public bool is_static { get; set; }

	public bool declaration_only { get; set; }

	private Gee.List<TypeParameter> type_parameters = new ArrayList<TypeParameter> ();
	
	private Gee.List<DataType> prerequisites = new ArrayList<DataType> ();

	private Gee.List<Method> methods = new ArrayList<Method> ();
	private Gee.List<Field> fields = new ArrayList<Field> ();
	private Gee.List<Property> properties = new ArrayList<Property> ();
	private Gee.List<Signal> signals = new ArrayList<Signal> ();
	
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
	public Interface (construct string! name, construct SourceReference source_reference = null) {
	}

	/**
	 * Appends the specified parameter to the list of type parameters.
	 *
	 * @param p a type parameter
	 */
	public void add_type_parameter (TypeParameter! p) {
		type_parameters.add (p);
		p.type = this;
		scope.add (p.name, p);
	}

	/**
	 * Returns a copy of the type parameter list.
	 *
	 * @return list of type parameters
	 */
	public Collection<TypeParameter> get_type_parameters () {
		return new ReadOnlyCollection<TypeParameter> (type_parameters);
	}

	/**
	 * Adds the specified interface or class to the list of prerequisites of
	 * this interface.
	 *
	 * @param type an interface or class reference
	 */
	public void add_prerequisite (DataType! type) {
		prerequisites.add (type);
		type.parent_node = this;
	}

	/**
	 * Prepends the specified interface or class to the list of
	 * prerequisites of this interface.
	 *
	 * @param type an interface or class reference
	 */
	public void prepend_prerequisite (DataType! type) {
		prerequisites.insert (0, type);
	}

	/**
	 * Returns a copy of the base type list.
	 *
	 * @return list of base types
	 */
	public Collection<DataType> get_prerequisites () {
		return new ReadOnlyCollection<DataType> (prerequisites);
	}
	
	/**
	 * Adds the specified method as a member to this interface.
	 *
	 * @param m a method
	 */
	public void add_method (Method! m) {
		if (m is CreationMethod) {
			Report.error (m.source_reference, "construction methods may only be declared within classes and structs");
		
			m.error = true;
			return;
		}
		if (m.instance) {
			m.this_parameter = new FormalParameter ("this", new InterfaceType (this));
			m.scope.add (m.this_parameter.name, m.this_parameter);
		}

		methods.add (m);
		scope.add (m.name, m);
	}
	
	/**
	 * Returns a copy of the list of methods.
	 *
	 * @return list of methods
	 */
	public Collection<Method> get_methods () {
		return new ReadOnlyCollection<Method> (methods);
	}
	
	/**
	 * Adds the specified field as a member to this interface. The field
	 * must be private and static.
	 *
	 * @param f a field
	 */
	public void add_field (Field! f) {
		// non_null fields not yet supported due to initialization issues
		f.type_reference.non_null = false;
		fields.add (f);
		scope.add (f.name, f);
	}

	/**
	 * Returns a copy of the list of fields.
	 *
	 * @return list of fields
	 */
	public Collection<Field> get_fields () {
		return new ReadOnlyCollection<Field> (fields);
	}

	/**
	 * Adds the specified property as a member to this interface.
	 *
	 * @param prop a property
	 */
	public void add_property (Property! prop) {
		properties.add (prop);
		scope.add (prop.name, prop);
	}
	
	/**
	 * Returns a copy of the list of properties.
	 *
	 * @return list of properties
	 */
	public Collection<Property> get_properties () {
		return new ReadOnlyCollection<Property> (properties);
	}
	
	/**
	 * Adds the specified signal as a member to this interface.
	 *
	 * @param sig a signal
	 */
	public void add_signal (Signal! sig) {
		signals.add (sig);
		scope.add (sig.name, sig);
	}
	
	/**
	 * Returns a copy of the list of signals.
	 *
	 * @return list of signals
	 */
	public Collection<Signal> get_signals () {
		return new ReadOnlyCollection<Signal> (signals);
	}
	
	public override string get_cname (bool const_type = false) {
		if (cname == null) {
			cname = "%s%s".printf (parent_symbol.get_cprefix (), name);
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
			lower_case_csuffix = camel_case_to_lower_case (name);

			// remove underscores in some cases to avoid conflicts of type macros
			if (lower_case_csuffix.has_prefix ("type_")) {
				lower_case_csuffix = "type" + lower_case_csuffix.offset ("type_".len ());
			} else if (lower_case_csuffix.has_prefix ("is_")) {
				lower_case_csuffix = "is" + lower_case_csuffix.offset ("is_".len ());
			}
			if (lower_case_csuffix.has_suffix ("_class")) {
				lower_case_csuffix = lower_case_csuffix.substring (0, lower_case_csuffix.len () - "_class".len ()) + "class";
			}
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
	
	public override string get_lower_case_cname (string infix) {
		if (infix == null) {
			infix = "";
		}
		return "%s%s%s".printf (parent_symbol.get_lower_case_cprefix (), infix, get_lower_case_csuffix ());
	}
	
	public override string! get_lower_case_cprefix () {
		return "%s_".printf (get_lower_case_cname (null));
	}
	
	public override string get_upper_case_cname (string infix) {
		return get_lower_case_cname (infix).up ();
	}

	public override void accept (CodeVisitor! visitor) {
		visitor.visit_interface (this);
	}

	public override void accept_children (CodeVisitor! visitor) {
		foreach (DataType type in prerequisites) {
			type.accept (visitor);
		}

		foreach (TypeParameter p in type_parameters) {
			p.accept (visitor);
		}
		
		foreach (Method m in methods) {
			m.accept (visitor);
		}
		
		foreach (Field f in fields) {
			f.accept (visitor);
		}
		
		foreach (Property prop in properties) {
			prop.accept (visitor);
		}
		
		foreach (Signal sig in signals) {
			sig.accept (visitor);
		}
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

	public override bool is_subtype_of (Typesymbol! t) {
		if (this == t) {
			return true;
		}

		foreach (DataType prerequisite in prerequisites) {
			if (prerequisite.data_type != null && prerequisite.data_type.is_subtype_of (t)) {
				return true;
			}
		}
		
		return false;
	}
	
	private void process_ccode_attribute (Attribute! a) {
		if (a.has_argument ("type_cname")) {
			set_type_cname (a.get_string ("type_cname"));
		}
		if (a.has_argument ("cheader_filename")) {
			var val = a.get_string ("cheader_filename");
			foreach (string filename in val.split (",")) {
				add_cheader_filename (filename);
			}
		}
	}

	private void process_dbus_interface_attribute (Attribute! a) {
		if (declaration_only) {
			cname = "DBusGProxy";
		}
	}

	/**
	 * Process all associated attributes.
	 */
	public void process_attributes () {
		foreach (Attribute a in attributes) {
			if (a.name == "CCode") {
				process_ccode_attribute (a);
			} else if (a.name == "DBusInterface") {
				process_dbus_interface_attribute (a);
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

	public override void replace_type (DataType! old_type, DataType! new_type) {
		for (int i = 0; i < prerequisites.size; i++) {
			if (prerequisites[i] == old_type) {
				prerequisites[i] = new_type;
				return;
			}
		}
	}
}
