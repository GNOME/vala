/* valainterface.vala
 *
 * Copyright (C) 2006-2009  Jürg Billeter
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
 * Represents a class declaration in the source code.
 */
public class Vala.Interface : ObjectTypeSymbol {
	private List<DataType> prerequisites = new ArrayList<DataType> ();

	private List<Method> methods = new ArrayList<Method> ();
	private List<Field> fields = new ArrayList<Field> ();
	private List<Constant> constants = new ArrayList<Constant> ();
	private List<Property> properties = new ArrayList<Property> ();
	private List<Signal> signals = new ArrayList<Signal> ();

	// inner types
	private List<Class> classes = new ArrayList<Class> ();
	private List<Struct> structs = new ArrayList<Struct> ();
	private List<Enum> enums = new ArrayList<Enum> ();
	private List<Delegate> delegates = new ArrayList<Delegate> ();

	private string cname;
	private string lower_case_csuffix;
	private string type_cname;
	private string type_id;

	/**
	 * Returns a copy of the list of classes.
	 *
	 * @return list of classes
	 */
	public List<Class> get_classes () {
		return new ReadOnlyList<Class> (classes);
	}

	/**
	 * Returns a copy of the list of structs.
	 *
	 * @return list of structs
	 */
	public List<Struct> get_structs () {
		return new ReadOnlyList<Struct> (structs);
	}

	/**
	 * Returns a copy of the list of enums.
	 *
	 * @return list of enums
	 */
	public List<Enum> get_enums () {
		return new ReadOnlyList<Enum> (enums);
	}

	/**
	 * Returns a copy of the list of delegates.
	 *
	 * @return list of delegates
	 */
	public List<Delegate> get_delegates () {
		return new ReadOnlyList<Delegate> (delegates);
	}

	/**
	 * Creates a new interface.
	 *
	 * @param name   type name
	 * @param source reference to source code
	 * @return       newly created interface
	 */
	public Interface (string name, SourceReference? source_reference = null, Comment? comment = null) {
		base (name, source_reference, comment);
	}

	/**
	 * Adds the specified interface or class to the list of prerequisites of
	 * this interface.
	 *
	 * @param type an interface or class reference
	 */
	public void add_prerequisite (DataType type) {
		prerequisites.add (type);
		type.parent_node = this;
	}

	/**
	 * Prepends the specified interface or class to the list of
	 * prerequisites of this interface.
	 *
	 * @param type an interface or class reference
	 */
	public void prepend_prerequisite (DataType type) {
		prerequisites.insert (0, type);
	}

	/**
	 * Returns a copy of the base type list.
	 *
	 * @return list of base types
	 */
	public List<DataType> get_prerequisites () {
		return new ReadOnlyList<DataType> (prerequisites);
	}
	
	/**
	 * Adds the specified method as a member to this interface.
	 *
	 * @param m a method
	 */
	public void add_method (Method m) {
		if (m is CreationMethod) {
			Report.error (m.source_reference, "construction methods may only be declared within classes and structs");
		
			m.error = true;
			return;
		}
		if (m.binding == MemberBinding.INSTANCE) {
			m.this_parameter = new FormalParameter ("this", new ObjectType (this));
			m.scope.add (m.this_parameter.name, m.this_parameter);
		}
		if (!(m.return_type is VoidType) && m.get_postconditions ().size > 0) {
			m.result_var = new LocalVariable (m.return_type.copy (), "result");
			m.result_var.is_result = true;
		}

		methods.add (m);
		scope.add (m.name, m);
	}
	
	/**
	 * Returns a copy of the list of methods.
	 *
	 * @return list of methods
	 */
	public override List<Method> get_methods () {
		return new ReadOnlyList<Method> (methods);
	}
	
	/**
	 * Adds the specified field as a member to this interface. The field
	 * must be private and static.
	 *
	 * @param f a field
	 */
	public void add_field (Field f) {
		fields.add (f);
		scope.add (f.name, f);
	}

	/**
	 * Returns a copy of the list of fields.
	 *
	 * @return list of fields
	 */
	public List<Field> get_fields () {
		return new ReadOnlyList<Field> (fields);
	}

	/**
	 * Adds the specified constant as a member to this interface.
	 *
	 * @param c a constant
	 */
	public void add_constant (Constant c) {
		constants.add (c);
		scope.add (c.name, c);
	}

	/**
	 * Returns a copy of the list of constants.
	 *
	 * @return list of constants
	 */
	public List<Constant> get_constants () {
		return new ReadOnlyList<Constant> (constants);
	}

	/**
	 * Adds the specified property as a member to this interface.
	 *
	 * @param prop a property
	 */
	public void add_property (Property prop) {
		properties.add (prop);
		scope.add (prop.name, prop);

		prop.this_parameter = new FormalParameter ("this", new ObjectType (this));
		prop.scope.add (prop.this_parameter.name, prop.this_parameter);
	}
	
	/**
	 * Returns a copy of the list of properties.
	 *
	 * @return list of properties
	 */
	public override List<Property> get_properties () {
		return new ReadOnlyList<Property> (properties);
	}
	
	/**
	 * Adds the specified signal as a member to this interface.
	 *
	 * @param sig a signal
	 */
	public void add_signal (Signal sig) {
		signals.add (sig);
		scope.add (sig.name, sig);
	}
	
	/**
	 * Returns a copy of the list of signals.
	 *
	 * @return list of signals
	 */
	public override List<Signal> get_signals () {
		return new ReadOnlyList<Signal> (signals);
	}

	/**
	 * Adds the specified class as an inner class.
	 *
	 * @param cl a class
	 */
	public void add_class (Class cl) {
		classes.add (cl);
		scope.add (cl.name, cl);
	}

	/**
	 * Adds the specified struct as an inner struct.
	 *
	 * @param st a struct
	 */
	public void add_struct (Struct st) {
		structs.add (st);
		scope.add (st.name, st);
	}

	/**
	 * Adds the specified enum as an inner enum.
	 *
	 * @param en an enum
	 */
	public void add_enum (Enum en) {
		enums.add (en);
		scope.add (en.name, en);
	}

	/**
	 * Adds the specified delegate as an inner delegate.
	 *
	 * @param d a delegate
	 */
	public void add_delegate (Delegate d) {
		delegates.add (d);
		scope.add (d.name, d);
	}

	public override string get_cprefix () {
		return get_cname ();
	}

	public override string get_cname (bool const_type = false) {
		if (cname == null) {
			var attr = get_attribute ("CCode");
			if (attr != null) {
				cname = attr.get_string ("cname");
			}
			if (cname == null) {
				cname = "%s%s".printf (parent_symbol.get_cprefix (), name);
			}
		}
		return cname;
	}

	public void set_cname (string cname) {
		this.cname = cname;
	}
	
	/**
	 * Returns the string to be prepended to the name of members of this
	 * interface when used in C code.
	 *
	 * @return the suffix to be used in C code
	 */
	public string get_lower_case_csuffix () {
		if (lower_case_csuffix == null) {
			lower_case_csuffix = get_default_lower_case_csuffix ();
		}
		return lower_case_csuffix;
	}

	/**
	 * Returns default string to be prepended to the name of members of this
	 * interface when used in C code.
	 *
	 * @return the suffix to be used in C code
	 */
	public string get_default_lower_case_csuffix () {
		string result = camel_case_to_lower_case (name);

		// remove underscores in some cases to avoid conflicts of type macros
		if (result.has_prefix ("type_")) {
			result = "type" + result.offset ("type_".len ());
		} else if (result.has_prefix ("is_")) {
			result = "is" + result.offset ("is_".len ());
		}
		if (result.has_suffix ("_class")) {
			result = result.substring (0, result.len () - "_class".len ()) + "class";
		}

		return result;
	}
	
	/**
	 * Sets the string to be prepended to the name of members of this
	 * interface when used in C code.
	 *
	 * @param csuffix the suffix to be used in C code
	 */
	public void set_lower_case_csuffix (string csuffix) {
		this.lower_case_csuffix = csuffix;
	}
	
	public override string? get_lower_case_cname (string? infix) {
		if (infix == null) {
			infix = "";
		}
		return "%s%s%s".printf (parent_symbol.get_lower_case_cprefix (), infix, get_lower_case_csuffix ());
	}
	
	public override string get_lower_case_cprefix () {
		return "%s_".printf (get_lower_case_cname (null));
	}
	
	public override string? get_upper_case_cname (string? infix) {
		return get_lower_case_cname (infix).up ();
	}

	public override void accept (CodeVisitor visitor) {
		visitor.visit_interface (this);
	}

	public override void accept_children (CodeVisitor visitor) {
		foreach (DataType type in prerequisites) {
			type.accept (visitor);
		}

		foreach (TypeParameter p in get_type_parameters ()) {
			p.accept (visitor);
		}

		/* process enums first to avoid order problems in C code */
		foreach (Enum en in enums) {
			en.accept (visitor);
		}

		foreach (Method m in methods) {
			m.accept (visitor);
		}
		
		foreach (Field f in fields) {
			f.accept (visitor);
		}

		foreach (Constant c in constants) {
			c.accept (visitor);
		}

		foreach (Property prop in properties) {
			prop.accept (visitor);
		}
		
		foreach (Signal sig in signals) {
			sig.accept (visitor);
		}
		
		foreach (Class cl in classes) {
			cl.accept (visitor);
		}
		
		foreach (Struct st in structs) {
			st.accept (visitor);
		}

		foreach (Delegate d in delegates) {
			d.accept (visitor);
		}
	}

	public override bool is_reference_type () {
		return true;
	}

	public override bool is_reference_counting () {
		return true;
	}
	
	public override string? get_ref_function () {
		foreach (DataType prerequisite in prerequisites) {
			string ref_func = prerequisite.data_type.get_ref_function ();
			if (ref_func != null) {
				return ref_func;
			}
		}
		return null;
	}
	
	public override string? get_unref_function () {
		foreach (DataType prerequisite in prerequisites) {
			string unref_func = prerequisite.data_type.get_unref_function ();
			if (unref_func != null) {
				return unref_func;
			}
		}
		return null;
	}

	public override string? get_ref_sink_function () {
		foreach (DataType prerequisite in prerequisites) {
			string ref_sink_func = prerequisite.data_type.get_ref_sink_function ();
			if (ref_sink_func != null) {
				return ref_sink_func;
			}
		}
		return null;
	}

	public override bool is_subtype_of (TypeSymbol t) {
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
	
	private void process_ccode_attribute (Attribute a) {
		if (a.has_argument ("type_cname")) {
			set_type_cname (a.get_string ("type_cname"));
		}
		if (a.has_argument ("cheader_filename")) {
			var val = a.get_string ("cheader_filename");
			foreach (string filename in val.split (",")) {
				add_cheader_filename (filename);
			}
		}
		if (a.has_argument ("lower_case_csuffix")) {
			lower_case_csuffix = a.get_string ("lower_case_csuffix");
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
	public void set_type_cname (string type_cname) {
		this.type_cname = type_cname;
	}

	public override string? get_marshaller_type_name () {
		return "OBJECT";
	}

	public override string? get_get_value_function () {
		return "g_value_get_object";
	}
	
	public override string? get_set_value_function () {
		return "g_value_set_object";
	}

	public override string? get_type_id () {
		if (type_id == null) {
			type_id = get_upper_case_cname ("TYPE_");
		}
		
		return type_id;
	}

	public override void replace_type (DataType old_type, DataType new_type) {
		for (int i = 0; i < prerequisites.size; i++) {
			if (prerequisites[i] == old_type) {
				prerequisites[i] = new_type;
				return;
			}
		}
	}

	public override string? get_param_spec_function () {
		foreach (DataType prerequisite in prerequisites) {
			var prereq = prerequisite as ObjectType;
			var cl = prereq.type_symbol as Class;
			if (cl != null) {
				return cl.get_param_spec_function ();
			}
			var interf = prereq.type_symbol as Interface;
			if (interf != null) {
				var param_spec_function = interf.get_param_spec_function ();
				if (param_spec_function != null) {
					return param_spec_function;
				}
			}
		}

		return null;
	}

	public override bool check (SemanticAnalyzer analyzer) {
		if (checked) {
			return !error;
		}

		checked = true;

		process_attributes ();

		var old_source_file = analyzer.current_source_file;
		var old_symbol = analyzer.current_symbol;

		if (source_reference != null) {
			analyzer.current_source_file = source_reference.file;
		}
		analyzer.current_symbol = this;

		foreach (DataType prerequisite_reference in get_prerequisites ()) {
			// check whether prerequisite is at least as accessible as the interface
			if (!analyzer.is_type_accessible (this, prerequisite_reference)) {
				error = true;
				Report.error (source_reference, "prerequisite `%s` is less accessible than interface `%s`".printf (prerequisite_reference.to_string (), get_full_name ()));
				return false;
			}
		}

		/* check prerequisites */
		Class prereq_class = null;
		foreach (DataType prereq in get_prerequisites ()) {
			TypeSymbol class_or_interface = prereq.data_type;
			/* skip on previous errors */
			if (class_or_interface == null) {
				error = true;
				continue;
			}

			if (!(class_or_interface is ObjectTypeSymbol)) {
				error = true;
				Report.error (source_reference, "Prerequisite `%s` of interface `%s` is not a class or interface".printf (get_full_name (), class_or_interface.to_string ()));
				return false;
			}

			/* interfaces are not allowed to have multiple instantiable prerequisites */
			if (class_or_interface is Class) {
				if (prereq_class != null) {
					error = true;
					Report.error (source_reference, "%s: Interfaces cannot have multiple instantiable prerequisites (`%s' and `%s')".printf (get_full_name (), class_or_interface.get_full_name (), prereq_class.get_full_name ()));
					return false;
				}

				prereq_class = (Class) class_or_interface;
			}
		}

		foreach (DataType type in prerequisites) {
			type.check (analyzer);
		}

		foreach (TypeParameter p in get_type_parameters ()) {
			p.check (analyzer);
		}

		foreach (Enum en in enums) {
			en.check (analyzer);
		}

		foreach (Method m in methods) {
			m.check (analyzer);
		}
		
		foreach (Field f in fields) {
			f.check (analyzer);
		}

		foreach (Constant c in constants) {
			c.check (analyzer);
		}

		foreach (Property prop in properties) {
			prop.check (analyzer);
		}
		
		foreach (Signal sig in signals) {
			sig.check (analyzer);
		}
		
		foreach (Class cl in classes) {
			cl.check (analyzer);
		}
		
		foreach (Struct st in structs) {
			st.check (analyzer);
		}

		foreach (Delegate d in delegates) {
			d.check (analyzer);
		}

		analyzer.current_source_file = old_source_file;
		analyzer.current_symbol = old_symbol;

		return !error;
	}
}
