/* valaclass.vala
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
public class Vala.Class : DataType {
	/**
	 * Specifies the base class.
	 */
	public Class base_class { get; set; }
	
	/**
	 * Specifies whether this class is abstract. Abstract classes may not be
	 * instantiated.
	 */
	public bool is_abstract { get; set; }

	/**
	 * Specifies whether this class is static. Static classes may not be
	 * instantiated and may only contain static members.
	 */
	public bool is_static { get; set; }

	/**
	 * Specifies whether this class has private fields.
	 */
	public bool has_private_fields {
		get {
			return _has_private_fields;
		}
	}
	
	private string cname;
	private string lower_case_csuffix;
	private string type_id;
	
	private bool _has_private_fields;
	
	private List<TypeParameter> type_parameters;

	private List<TypeReference> base_types;

	private List<Constant> constants;
	private List<Field> fields;
	private List<Method> methods;
	private List<Property> properties;
	private List<Signal> signals;
	
	/**
	 * Specifies the default construction method.
	 */
	public Method default_construction_method { get; set; }
	
	/**
	 * Specifies the instance constructor.
	 */
	public Constructor constructor { get; set; }
	
	/**
	 * Specifies the instance destructor.
	 */
	public Destructor destructor { get; set; }
	
	/**
	 * Creates a new class.
	 *
	 * @param name   type name
	 * @param source reference to source code
	 * @return       newly created class
	 */
	public Class (string! _name, SourceReference source = null) {
		name = _name;
		source_reference = source;
	}

	/**
	 * Adds the specified class or interface to the list of base types of
	 * this class.
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
	 * Returns a copy of the type parameter list.
	 *
	 * @return list of type parameters
	 */
	public List<weak TypeParameter> get_type_parameters () {
		return type_parameters.copy ();
	}

	/**
	 * Adds the specified constant as a member to this class.
	 *
	 * @param c a constant
	 */
	public void add_constant (Constant! c) {
		constants.append (c);
	}
	
	/**
	 * Adds the specified field as a member to this class.
	 *
	 * @param f a field
	 */
	public void add_field (Field! f) {
		// non_null fields not yet supported due to initialization issues
		f.type_reference.non_null = false;
		fields.append (f);
		if (f.access == MemberAccessibility.PRIVATE && f.instance) {
			_has_private_fields = true;
		}
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
	 * Adds the specified method as a member to this class.
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
	 * Adds the specified property as a member to this class.
	 *
	 * @param prop a property
	 */
	public void add_property (Property! prop, bool no_field = false) {
		properties.append (prop);
		
		if (!no_field && prop.set_accessor != null && prop.set_accessor.body == null &&
		    source_reference != null && !source_reference.file.pkg) {
			/* automatic property accessor body generation */
			var field_type = prop.type_reference.copy ();
			// non_null fields not yet supported due to initialization issues
			field_type.non_null = false;
			var f = new Field ("_%s".printf (prop.name), field_type, null, prop.source_reference);
			f.access = MemberAccessibility.PRIVATE;
			add_field (f);
		}
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
	 * Adds the specified signal as a member to this class.
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

	public override void accept (CodeVisitor! visitor) {
		visitor.visit_class (this);
	}

	public override void accept_children (CodeVisitor! visitor) {
		foreach (TypeReference type in base_types) {
			type.accept (visitor);
		}

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
		
		foreach (Property prop in properties) {
			prop.accept (visitor);
		}
		
		foreach (Signal sig in signals) {
			sig.accept (visitor);
		}
		
		if (constructor != null) {
			constructor.accept (visitor);
		}

		if (destructor != null) {
			destructor.accept (visitor);
		}
	}

	public override string get_cname (bool const_type = false) {
		if (cname == null) {
			cname = "%s%s".printf (@namespace.get_cprefix (), name);
		}
		return cname;
	}
	
	/**
	 * Sets the name of this class as it is used in C code.
	 *
	 * @param cname the name to be used in C code
	 */
	public void set_cname (string! cname) {
		this.cname = cname;
	}
	
	private string get_lower_case_csuffix () {
		if (lower_case_csuffix == null) {
			lower_case_csuffix = Namespace.camel_case_to_lower_case (name);
		}
		return lower_case_csuffix;
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

	public override bool is_reference_type () {
		return true;
	}
	
	private void process_ccode_attribute (Attribute! a) {
		if (a.has_argument ("cname")) {
			set_cname (a.get_string ("cname"));
		}
		if (a.has_argument ("cheader_filename")) {
			var val = a.get_string ("cheader_filename");
			foreach (string filename in val.split (",")) {
				add_cheader_filename (filename);
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
			}
		}
	}

	public override string get_type_id () {
		if (type_id == null) {
			type_id = get_upper_case_cname ("TYPE_");
		}
		
		return type_id;
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

