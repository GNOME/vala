/* valaclass.vala
 *
 * Copyright (C) 2006-2008  Jürg Billeter
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
public class Vala.Class : ObjectTypeSymbol {
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
	 * Instances of compact classes are fast to create and have a
	 * compact memory layout. Compact classes don't support runtime
	 * type information or virtual methods.
	 */
	public bool is_compact {
		get {
			if (base_class != null) {
				return base_class.is_compact;
			}
			return _is_compact;
		}
		set {
			_is_compact = value;
		}
	}

	/**
	 * Instances of immutable classes are immutable after construction.
	 */
	public bool is_immutable {
		get {
			if (base_class != null) {
				return base_class.is_immutable;
			}
			return _is_immutable;
		}
		set {
			_is_immutable = value;
		}
	}

	/**
	 * Specifies whether this class has private fields.
	 */
	public bool has_private_fields { get; private set; }

	private string cname;
	private string const_cname;
	private string lower_case_cprefix;
	private string lower_case_csuffix;
	private string type_id;
	private string ref_function;
	private string unref_function;
	private string copy_function;
	private string free_function;
	private string marshaller_type_name;
	private string get_value_function;
	private string set_value_function;
	private string? type_signature;
	private bool _is_compact;
	private bool _is_immutable;

	private Gee.List<TypeParameter> type_parameters = new ArrayList<TypeParameter> ();

	private Gee.List<DataType> base_types = new ArrayList<DataType> ();

	private Gee.List<Constant> constants = new ArrayList<Constant> ();
	private Gee.List<Field> fields = new ArrayList<Field> ();
	private Gee.List<Method> methods = new ArrayList<Method> ();
	private Gee.List<Property> properties = new ArrayList<Property> ();
	private Gee.List<Signal> signals = new ArrayList<Signal> ();

	// inner types
	private Gee.List<Class> classes = new ArrayList<Class> ();
	private Gee.List<Struct> structs = new ArrayList<Struct> ();
	private Gee.List<Enum> enums = new ArrayList<Enum> ();
	private Gee.List<Delegate> delegates = new ArrayList<Delegate> ();

	/**
	 * Specifies the default construction method.
	 */
	public Method default_construction_method { get; set; }
	
	/**
	 * Specifies the instance constructor.
	 */
	public Constructor constructor { get; set; }

	/**
	 * Specifies the class constructor.
	 */
	public Constructor class_constructor { get; set; }

	/**
	 * Specifies the static class constructor.
	 */
	public Constructor static_constructor { get; set; }

	/**
	 * Specifies the instance destructor.
	 */
	public Destructor? destructor {
		get { return _destructor; }
		set {
			_destructor = value;
			if (_destructor != null) {
				if (_destructor.this_parameter != null) {
					_destructor.scope.remove (_destructor.this_parameter.name);
				}
				_destructor.this_parameter = new FormalParameter ("this", new ObjectType (this));
				_destructor.scope.add (_destructor.this_parameter.name, _destructor.this_parameter);
			}
		}
	}

	/**
	 * Specifies whether this class denotes an error base.
	 */
	public bool is_error_base { get; set ; }

	Destructor? _destructor;

	/**
	 * Creates a new class.
	 *
	 * @param name   type name
	 * @param source reference to source code
	 * @return       newly created class
	 */
	public Class (string name, SourceReference? source_reference = null) {
		this.source_reference = source_reference;
		this.name = name;
	}

	/**
	 * Adds the specified class or interface to the list of base types of
	 * this class.
	 *
	 * @param type a class or interface reference
	 */
	public void add_base_type (DataType type) {
		base_types.add (type);
		type.parent_node = this;
	}

	/**
	 * Returns a copy of the base type list.
	 *
	 * @return list of base types
	 */
	public Gee.List<DataType> get_base_types () {
		return new ReadOnlyList<DataType> (base_types);
	}

	/**
	 * Appends the specified parameter to the list of type parameters.
	 *
	 * @param p a type parameter
	 */
	public void add_type_parameter (TypeParameter p) {
		type_parameters.add (p);
		p.type = this;
		scope.add (p.name, p);
	}

	/**
	 * Returns a copy of the type parameter list.
	 *
	 * @return list of type parameters
	 */
	public Gee.List<TypeParameter> get_type_parameters () {
		return new ReadOnlyList<TypeParameter> (type_parameters);
	}

	/**
	 * Adds the specified constant as a member to this class.
	 *
	 * @param c a constant
	 */
	public void add_constant (Constant c) {
		constants.add (c);
		scope.add (c.name, c);
	}
	
	/**
	 * Adds the specified field as a member to this class.
	 *
	 * @param f a field
	 */
	public void add_field (Field f) {
		fields.add (f);
		if (f.access == SymbolAccessibility.PRIVATE && f.binding == MemberBinding.INSTANCE) {
			has_private_fields = true;
		}
		scope.add (f.name, f);
	}
	
	/**
	 * Returns a copy of the list of fields.
	 *
	 * @return list of fields
	 */
	public Gee.List<Field> get_fields () {
		return new ReadOnlyList<Field> (fields);
	}
	
	/**
	 * Adds the specified method as a member to this class.
	 *
	 * @param m a method
	 */
	public void add_method (Method m) {
		if (m.binding == MemberBinding.INSTANCE || m is CreationMethod) {
			if (m.this_parameter != null) {
				m.scope.remove (m.this_parameter.name);
			}
			m.this_parameter = new FormalParameter ("this", new ObjectType (this));
			m.scope.add (m.this_parameter.name, m.this_parameter);
		}
		if (!(m.return_type is VoidType) && m.get_postconditions ().size > 0) {
			if (m.result_var != null) {
				m.scope.remove (m.result_var.name);
			}
			m.result_var = new LocalVariable (m.return_type.copy (), "result");
			m.scope.add (m.result_var.name, m.result_var);
		}
		if (m is CreationMethod) {
			if (m.name == null) {
				default_construction_method = m;
				m.name = ".new";
			} else {
				m.name = ".new." + m.name;
			}

			var cm = (CreationMethod) m;
			if (cm.type_name != null && cm.type_name != name) {
				// type_name is null for constructors generated by GIdlParser
				Report.error (m.source_reference, "missing return type in method `%s.%s´".printf (get_full_name (), cm.type_name));
				m.error = true;
				return;
			}
		}

		methods.add (m);
		scope.add (m.name, m);
	}
	
	/**
	 * Returns a copy of the list of methods.
	 *
	 * @return list of methods
	 */
	public override Gee.List<Method> get_methods () {
		return new ReadOnlyList<Method> (methods);
	}
	
	/**
	 * Adds the specified property as a member to this class.
	 *
	 * @param prop a property
	 */
	public void add_property (Property prop) {
		properties.add (prop);
		scope.add (prop.name, prop);

		prop.this_parameter = new FormalParameter ("this", new ObjectType (this));
		prop.scope.add (prop.this_parameter.name, prop.this_parameter);

		if (prop.field != null) {
			add_field (prop.field);
		}
	}
	
	/**
	 * Returns a copy of the list of properties.
	 *
	 * @return list of properties
	 */
	public override Gee.List<Property> get_properties () {
		return new ReadOnlyList<Property> (properties);
	}
	
	/**
	 * Adds the specified signal as a member to this class.
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
	public override Gee.List<Signal> get_signals () {
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

	public override void accept (CodeVisitor visitor) {
		visitor.visit_class (this);
	}

	public override void accept_children (CodeVisitor visitor) {
		foreach (DataType type in base_types) {
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

		if (class_constructor != null) {
			class_constructor.accept (visitor);
		}

		if (static_constructor != null) {
			static_constructor.accept (visitor);
		}

		if (destructor != null) {
			destructor.accept (visitor);
		}
		
		foreach (Class cl in classes) {
			cl.accept (visitor);
		}
		
		foreach (Struct st in structs) {
			st.accept (visitor);
		}

		foreach (Enum en in enums) {
			en.accept (visitor);
		}

		foreach (Delegate d in delegates) {
			d.accept (visitor);
		}
	}

	public override string get_cprefix () {
		return get_cname ();
	}

	public override string get_cname (bool const_type = false) {
		if (const_type && const_cname != null) {
			return const_cname;
		}

		if (cname == null) {
			cname = get_default_cname ();
		}
		return cname;
	}

	/**
	 * Returns the default name of this class as it is used in C code.
	 *
	 * @return the name to be used in C code by default
	 */
	public string get_default_cname () {
		return "%s%s".printf (parent_symbol.get_cprefix (), name);
	}

	/**
	 * Sets the name of this class as it is used in C code.
	 *
	 * @param cname the name to be used in C code
	 */
	public void set_cname (string cname) {
		this.cname = cname;
	}
	
	private string get_lower_case_csuffix () {
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

	public override string? get_lower_case_cname (string? infix) {
		if (infix == null) {
			infix = "";
		}
		return "%s%s%s".printf (parent_symbol.get_lower_case_cprefix (), infix, get_lower_case_csuffix ());
	}
	
	public override string get_lower_case_cprefix () {
		if (lower_case_cprefix == null) {
			lower_case_cprefix = "%s_".printf (get_lower_case_cname (null));
		}
		return lower_case_cprefix;
	}
	
	public override string? get_upper_case_cname (string? infix) {
		return get_lower_case_cname (infix).up ();
	}

	public override string? get_type_signature () {
		return type_signature;
	}

	public override bool is_reference_type () {
		return true;
	}
	
	private void process_ccode_attribute (Attribute a) {
		if (a.has_argument ("ref_function")) {
			set_ref_function (a.get_string ("ref_function"));
		}
		if (a.has_argument ("unref_function")) {
			set_unref_function (a.get_string ("unref_function"));
		}
		if (a.has_argument ("copy_function")) {
			set_dup_function (a.get_string ("copy_function"));
		}
		if (a.has_argument ("free_function")) {
			set_free_function (a.get_string ("free_function"));
		}
		if (a.has_argument ("type_id")) {
			type_id = a.get_string ("type_id");
		}
		if (a.has_argument ("marshaller_type_name")) {
			marshaller_type_name = a.get_string ("marshaller_type_name");
		}
		if (a.has_argument ("get_value_function")) {
			get_value_function = a.get_string ("get_value_function");
		}
		if (a.has_argument ("set_value_function")) {
			set_value_function = a.get_string ("set_value_function");
		}

		if (a.has_argument ("cname")) {
			set_cname (a.get_string ("cname"));
		}
		if (a.has_argument ("const_cname")) {
			const_cname = a.get_string ("const_cname");
		}
		if (a.has_argument ("cprefix")) {
			lower_case_cprefix = a.get_string ("cprefix");
		}
		if (a.has_argument ("lower_case_csuffix")) {
			lower_case_csuffix = a.get_string ("lower_case_csuffix");
		}
		if (a.has_argument ("cheader_filename")) {
			var val = a.get_string ("cheader_filename");
			foreach (string filename in val.split (",")) {
				add_cheader_filename (filename);
			}
		}
		if (a.has_argument ("type_signature")) {
			type_signature = a.get_string ("type_signature");
		}
	}
	
	/**
	 * Process all associated attributes.
	 */
	public void process_attributes () {
		foreach (Attribute a in attributes) {
			if (a.name == "CCode") {
				process_ccode_attribute (a);
			} else if (a.name == "ErrorBase") {
				is_error_base = true;
			} else if (a.name == "Compact") {
				is_compact = true;
			} else if (a.name == "Immutable") {
				is_immutable = true;
			}
		}
	}

	public override string? get_type_id () {
		if (type_id == null) {
			if (!is_compact) {
				type_id = get_upper_case_cname ("TYPE_");
			} else {
				type_id = "G_TYPE_POINTER";
			}
		}
		
		return type_id;
	}

	public void set_type_id (string type_id) {
		this.type_id = type_id;
	}

	public override string? get_marshaller_type_name () {
		if (marshaller_type_name == null) {
			if (base_class != null) {
				marshaller_type_name = base_class.get_marshaller_type_name ();
			} else {
				marshaller_type_name = "POINTER";
			}
		}

		return marshaller_type_name;
	}

	public override string? get_get_value_function () {
		if (get_value_function == null) {
			if (base_class != null) {
				get_value_function = base_class.get_get_value_function ();
			} else {
				get_value_function = "g_value_get_pointer";
			}
		}

		return get_value_function;
	}
	
	public override string? get_set_value_function () {
		if (set_value_function == null) {
			if (base_class != null) {
				set_value_function = base_class.get_set_value_function ();
			} else {
				set_value_function = "g_value_set_pointer";
			}
		}

		return set_value_function;
	}

	public override bool is_reference_counting () {
		return get_ref_function () != null;
	}

	bool is_fundamental () {
		if (!is_compact && base_class == null) {
			return true;
		}
		return false;
	}

	public override string? get_ref_function () {
		if (ref_function == null && is_fundamental ()) {
			ref_function = get_lower_case_cprefix () + "ref";
		}

		if (ref_function == null && base_class != null) {
			return base_class.get_ref_function ();
		} else {
			return ref_function;
		}
	}

	public void set_ref_function (string? name) {
		this.ref_function = name;
	}

	public override string? get_unref_function () {
		if (unref_function == null && is_fundamental ()) {
			unref_function = get_lower_case_cprefix () + "unref";
		}

		if (unref_function == null && base_class != null) {
			return base_class.get_unref_function ();
		} else {
			return unref_function;
		}
	}

	public void set_unref_function (string? name) {
		this.unref_function = name;
	}

	public override string? get_dup_function () {
		return copy_function;
	}

	public void set_dup_function (string? name) {
		this.copy_function = name;
	}

	public string get_default_free_function () {
		return get_lower_case_cprefix () + "free";
	}

	public override string? get_free_function () {
		if (free_function == null) {
			free_function = get_default_free_function ();
		}
		return free_function;
	}
	
	public void set_free_function (string name) {
		this.free_function = name;
	}
	
	public override bool is_subtype_of (TypeSymbol t) {
		if (this == t) {
			return true;
		}

		foreach (DataType base_type in base_types) {
			if (base_type.data_type != null && base_type.data_type.is_subtype_of (t)) {
				return true;
			}
		}
		
		return false;
	}

	public override int get_type_parameter_index (string name) {
		int i = 0;
		foreach (TypeParameter parameter in type_parameters) {
			if (parameter.name == name) {
				return i;
			}
			i++;
		}
		return -1;
	}

	public override void replace_type (DataType old_type, DataType new_type) {
		for (int i = 0; i < base_types.size; i++) {
			if (base_types[i] == old_type) {
				base_types[i] = new_type;
				return;
			}
		}
	}

	public override CodeBinding? create_code_binding (CodeGenerator codegen) {
		return codegen.create_class_binding (this);
	}
}

