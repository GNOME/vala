/* valastruct.vala
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
using Gee;

/**
 * Represents a struct declaration in the source code.
 */
public class Vala.Struct : TypeSymbol {
	private Gee.List<TypeParameter> type_parameters = new ArrayList<TypeParameter> ();
	private Gee.List<Constant> constants = new ArrayList<Constant> ();
	private Gee.List<Field> fields = new ArrayList<Field> ();
	private Gee.List<Method> methods = new ArrayList<Method> ();
	private Gee.List<Property> properties = new ArrayList<Property> ();
	private DataType _base_type = null;

	private string cname;
	private string const_cname;
	private string type_id;
	private string lower_case_cprefix;
	private string lower_case_csuffix;
	private bool boolean_type;
	private bool integer_type;
	private bool floating_type;
	private int rank;
	private string marshaller_type_name;
	private string get_value_function;
	private string set_value_function;
	private string default_value = null;
	private string? type_signature;
	private string copy_function;
	private string destroy_function;

	/**
	 * Specifies the base type.
	 */
	public DataType? base_type {
		get {
			return _base_type;
		}
		set {
			value.parent_node = this;
			_base_type = value;
		}
	}

	/**
	 * Specifies the base Struct.
	 */
	public Struct? base_struct {
		get {
			if (_base_type != null) {
				return _base_type.data_type as Struct;
			}
			return null;
		}
	}

	/**
	 * Specifies the default construction method.
	 */
	public Method default_construction_method { get; set; }

	/**
	 * Specifies if 'const' should be emitted for input parameters
	 * of this type.
	 */
	public bool use_const { get; set; default = true; }

	/**
	 * Specifies whether this struct has a registered GType.
	 */
	public bool has_type_id { get; set; default = true; }

	public int width { get; set; default = 32; }

	public bool signed { get; set; default = true; }

	/**
	 * Creates a new struct.
	 *
	 * @param name             type name
	 * @param source_reference reference to source code
	 * @return                 newly created struct
	 */
	public Struct (string name, SourceReference? source_reference = null, Comment? comment = null) {
		base (name, source_reference, comment);
	}

	/**
	 * Appends the specified parameter to the list of type parameters.
	 *
	 * @param p a type parameter
	 */
	public void add_type_parameter (TypeParameter p) {
		type_parameters.add (p);
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
	 * Adds the specified constant as a member to this struct.
	 *
	 * @param c a constant
	 */
	public void add_constant (Constant c) {
		constants.add (c);
		scope.add (c.name, c);
	}
	
	/**
	 * Adds the specified field as a member to this struct.
	 *
	 * @param f a field
	 */
	public void add_field (Field f) {
		// TODO report error when `private' or `protected' has been specified
		f.access = SymbolAccessibility.PUBLIC;

		fields.add (f);
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
	 * Returns a copy of the list of constants.
	 *
	 * @return list of constants
	 */
	public Gee.List<Constant> get_constants () {
		return new ReadOnlyList<Constant> (constants);
	}

	/**
	 * Adds the specified method as a member to this struct.
	 *
	 * @param m a method
	 */
	public void add_method (Method m) {
		return_if_fail (m != null);
		
		if (m.binding == MemberBinding.INSTANCE || m is CreationMethod) {
			m.this_parameter = new FormalParameter ("this", SemanticAnalyzer.get_data_type_for_symbol (this));
			m.scope.add (m.this_parameter.name, m.this_parameter);
		}
		if (!(m.return_type is VoidType) && m.get_postconditions ().size > 0) {
			m.result_var = new LocalVariable (m.return_type.copy (), "result");
			m.result_var.is_result = true;
		}
		if (m is CreationMethod) {
			if (m.name == null) {
				default_construction_method = m;
				m.name = ".new";
			}

			var cm = (CreationMethod) m;
			if (cm.class_name != null && cm.class_name != name) {
				// type_name is null for constructors generated by GIdlParser
				Report.error (m.source_reference, "missing return type in method `%s.%s´".printf (get_full_name (), cm.class_name));
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
	public Gee.List<Method> get_methods () {
		return new ReadOnlyList<Method> (methods);
	}

	/**
	 * Adds the specified property as a member to this struct.
	 *
	 * @param prop a property
	 */
	public void add_property (Property prop) {
		properties.add (prop);
		scope.add (prop.name, prop);

		prop.this_parameter = new FormalParameter ("this", SemanticAnalyzer.get_data_type_for_symbol (this));
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
	public Gee.List<Property> get_properties () {
		return new ReadOnlyList<Property> (properties);
	}

	public override void accept (CodeVisitor visitor) {
		visitor.visit_struct (this);
	}

	public override void accept_children (CodeVisitor visitor) {
		if (base_type != null) {
			base_type.accept (visitor);
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
	}

	public override string get_cname (bool const_type = false) {
		if (const_type && const_cname != null) {
			return const_cname;
		}
		
		if (cname == null) {
			var attr = get_attribute ("CCode");
			if (attr != null) {
				cname = attr.get_string ("cname");
			}
			if (cname == null) {
				cname = get_default_cname ();
			}
		}
		return cname;
	}

	public void set_cname (string cname) {
		this.cname = cname;
	}

	/**
	 * Returns the default name of this struct as it is used in C code.
	 *
	 * @return the name to be used in C code by default
	 */
	public string get_default_cname () {
		return "%s%s".printf (parent_symbol.get_cprefix (), name);
	}

	private void set_const_cname (string cname) {
		this.const_cname = cname;
	}
	
	public override string get_lower_case_cprefix () {
		if (lower_case_cprefix == null) {
			lower_case_cprefix = "%s_".printf (get_lower_case_cname (null));
		}
		return lower_case_cprefix;
	}
	
	private string get_lower_case_csuffix () {
		if (lower_case_csuffix == null) {
			lower_case_csuffix = camel_case_to_lower_case (name);
		}
		return lower_case_csuffix;
	}

	public override string? get_lower_case_cname (string? infix) {
		if (infix == null) {
			infix = "";
		}
		return "%s%s%s".printf (parent_symbol.get_lower_case_cprefix (), infix, get_lower_case_csuffix ());
	}
	
	public override string? get_upper_case_cname (string? infix) {
		return get_lower_case_cname (infix).up ();
	}

	public override string? get_type_signature () {
		if (type_signature == null) {
			var str = new StringBuilder ();
			str.append_c ('(');
			foreach (Field f in fields) {
				if (f.binding == MemberBinding.INSTANCE) {
					str.append (f.field_type.get_type_signature ());
				}
			}
			str.append_c (')');
			return str.str;
		}
		return type_signature;
	}

	/**
	 * Returns whether this is a boolean type.
	 *
	 * @return true if this is a boolean type, false otherwise
	 */
	public bool is_boolean_type () {
		if (base_type != null) {
			var st = base_struct;
			if (st != null && st.is_boolean_type ()) {
				return true;
			}
		}
		return boolean_type;
	}

	/**
	 * Returns whether this is an integer type.
	 *
	 * @return true if this is an integer type, false otherwise
	 */
	public bool is_integer_type () {
		if (base_type != null) {
			var st = base_struct;
			if (st != null && st.is_integer_type ()) {
				return true;
			}
		}
		return integer_type;
	}
	
	/**
	 * Returns whether this is a floating point type.
	 *
	 * @return true if this is a floating point type, false otherwise
	 */
	public bool is_floating_type () {
		if (base_type != null) {
			var st = base_struct;
			if (st != null && st.is_floating_type ()) {
				return true;
			}
		}
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

	private void process_ccode_attribute (Attribute a) {
		if (a.has_argument ("const_cname")) {
			set_const_cname (a.get_string ("const_cname"));
		}
		if (a.has_argument ("cprefix")) {
			lower_case_cprefix = a.get_string ("cprefix");
		}
		if (a.has_argument ("cheader_filename")) {
			var val = a.get_string ("cheader_filename");
			foreach (string filename in val.split (",")) {
				add_cheader_filename (filename);
			}
		}
		if (a.has_argument ("has_type_id")) {
			has_type_id = a.get_bool ("has_type_id");
		}
		if (a.has_argument ("type_id")) {
			set_type_id (a.get_string ("type_id"));
		}
		if (a.has_argument ("marshaller_type_name")) {
			set_marshaller_type_name (a.get_string ("marshaller_type_name"));
		}
		if (a.has_argument ("get_value_function")) {
			set_get_value_function (a.get_string ("get_value_function"));
		}
		if (a.has_argument ("set_value_function")) {
			set_set_value_function (a.get_string ("set_value_function"));
		}
		if (a.has_argument ("default_value")) {
			set_default_value (a.get_string ("default_value"));
		}
		if (a.has_argument ("type_signature")) {
			type_signature = a.get_string ("type_signature");
		}
		if (a.has_argument ("copy_function")) {
			set_copy_function (a.get_string ("copy_function"));
		}
		if (a.has_argument ("destroy_function")) {
			set_destroy_function (a.get_string ("destroy_function"));
		}
		if (a.has_argument ("use_const")) {
			use_const = a.get_bool ("use_const");
		}
	}

	private void process_boolean_type_attribute (Attribute a) {
		boolean_type = true;
	}

	private void process_integer_type_attribute (Attribute a) {
		integer_type = true;
		if (a.has_argument ("rank")) {
			rank = a.get_integer ("rank");
		}
		if (a.has_argument ("width")) {
			width = a.get_integer ("width");
		}
		if (a.has_argument ("signed")) {
			signed = a.get_bool ("signed");
		}
	}

	private void process_floating_type_attribute (Attribute a) {
		floating_type = true;
		if (a.has_argument ("rank")) {
			rank = a.get_integer ("rank");
		}
		if (a.has_argument ("width")) {
			width = a.get_integer ("width");
		}
	}
	
	/**
	 * Process all associated attributes.
	 */
	public void process_attributes () {
		foreach (Attribute a in attributes) {
			if (a.name == "CCode") {
				process_ccode_attribute (a);
			} else if (a.name == "BooleanType") {
				process_boolean_type_attribute (a);
			} else if (a.name == "IntegerType") {
				process_integer_type_attribute (a);
			} else if (a.name == "FloatingType") {
				process_floating_type_attribute (a);
			}
		}
	}

	public override string? get_type_id () {
		if (type_id == null) {
			if (!has_type_id) {
				if (base_type != null) {
					var st = base_struct;
					if (st != null) {
						return st.get_type_id ();
					}
				}
				if (is_simple_type ()) {
					return null;
				} else {
					return "G_TYPE_POINTER";
				}
			} else {
				type_id = get_upper_case_cname ("TYPE_");
			}
		}
		return type_id;
	}
	
	public void set_type_id (string? name) {
		this.type_id = name;
	}

	public override string? get_marshaller_type_name () {
		if (marshaller_type_name == null) {
			if (base_type != null) {
				var st = base_struct;
				if (st != null) {
					return st.get_marshaller_type_name ();
				}
			}
			if (is_simple_type ()) {
				Report.error (source_reference, "The type `%s` doesn't declare a marshaller type name".printf (get_full_name ()));
			} else if (has_type_id) {
				return "BOXED";
			} else {
				return "POINTER";
			}
		}
		return marshaller_type_name;
	}
	
	private void set_marshaller_type_name (string? name) {
		this.marshaller_type_name = name;
	}
	
	public override string? get_get_value_function () {
		if (get_value_function == null) {
			if (base_type != null) {
				var st = base_struct;
				if (st != null) {
					return st.get_get_value_function ();
				}
			}
			if (is_simple_type ()) {
				Report.error (source_reference, "The value type `%s` doesn't declare a GValue get function".printf (get_full_name ()));
				return null;
			} else if (has_type_id) {
				return "g_value_get_boxed";
			} else {
				return "g_value_get_pointer";
			}
		} else {
			return get_value_function;
		}
	}
	
	public override string? get_set_value_function () {
		if (set_value_function == null) {
			if (base_type != null) {
				var st = base_struct;
				if (st != null) {
					return st.get_set_value_function ();
				}
			}
			if (is_simple_type ()) {
				Report.error (source_reference, "The value type `%s` doesn't declare a GValue set function".printf (get_full_name ()));
				return null;
			} else if (has_type_id) {
				return "g_value_set_boxed";
			} else {
				return "g_value_set_pointer";
			}
		} else {
			return set_value_function;
		}
	}
	
	private void set_get_value_function (string? function) {
		get_value_function = function;
	}
	
	private void set_set_value_function (string? function) {
		set_value_function = function;
	}

	public override string? get_default_value () {
		if (default_value != null) {
			return default_value;
		}

		// inherit default value from base type
		if (base_type != null) {
			var st = base_struct;
			if (st != null) {
				return st.get_default_value ();
			}
		}
		return null;
	}

	private void set_default_value (string? value) {
		default_value = value;
	}

	public override int get_type_parameter_index (string name) {
		int i = 0;
		
		foreach (TypeParameter p in type_parameters) {
			if (p.name == name) {
				return (i);
			}
			i++;
		}
		
		return -1;
	}

	/**
	 * Returns whether this struct is a simple type, i.e. whether
	 * instances are passed by value.
	 */
	public bool is_simple_type () {
		if (base_type != null) {
			var st = base_struct;
			if (st != null && st.is_simple_type ()) {
				return true;
			}
		}
		if (get_attribute ("ByRef") != null) {
			// used by time_t
			return false;
		}
		return (boolean_type || integer_type || floating_type
		        || get_attribute ("SimpleType") != null);
	}

	/**
	 * Marks this struct as simple type, i.e. instances will be passed by
	 * value.
	 */
	public void set_simple_type (bool simple_type) {
		attributes.append (new Attribute ("SimpleType"));
	}

	public override void replace_type (DataType old_type, DataType new_type) {
		if (base_type == old_type) {
			base_type = new_type;
		}
	}

	public override bool is_subtype_of (TypeSymbol t) {
		if (this == t) {
			return true;
		}

		if (base_type != null) {
			if (base_type.data_type != null && base_type.data_type.is_subtype_of (t)) {
				return true;
			}
		}

		return false;
	}

	public override string? get_dup_function () {
		// TODO use attribute check instead
		if (external_package) {
			return null;
		} else {
			return get_lower_case_cprefix () + "dup";
		}
	}
	
	public override string? get_free_function () {
		// TODO use attribute check instead
		if (external_package) {
			return null;
		} else {
			return get_lower_case_cprefix () + "free";
		}
	}

	public string get_default_copy_function () {
		return get_lower_case_cprefix () + "copy";
	}

	public override string? get_copy_function () {
		if (copy_function == null) {
			copy_function = get_default_copy_function ();
		}
		return copy_function;
	}

	public void set_copy_function (string name) {
		this.copy_function = name;
	}

	public string get_default_destroy_function () {
		return get_lower_case_cprefix () + "destroy";
	}

	public override string? get_destroy_function () {
		if (destroy_function == null) {
			destroy_function = get_default_destroy_function ();
		}
		return destroy_function;
	}

	public void set_destroy_function (string name) {
		this.destroy_function = name;
	}

	public bool is_disposable () {
		if (destroy_function != null) {
			return true;
		}

		foreach (Field f in fields) {
			if (f.binding == MemberBinding.INSTANCE
			    && f.field_type.is_disposable ()) {
				return true;
			}
		}

		return false;
	}

	bool is_recursive_value_type (DataType type) {
		var struct_type = type as StructValueType;
		if (struct_type != null) {
			var st = (Struct) struct_type.type_symbol;
			if (st == this) {
				return true;
			}
			foreach (Field f in st.fields) {
				if (f.binding == MemberBinding.INSTANCE && is_recursive_value_type (f.field_type)) {
					return true;
				}
			}
		}
		return false;
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

		if (base_type != null) {
			base_type.check (analyzer);

			if (!(base_type is ValueType)) {
				error = true;
				Report.error (source_reference, "The base type `%s` of struct `%s` is not a struct".printf (base_type.to_string (), get_full_name ()));
				return false;
			}
		}

		foreach (TypeParameter p in type_parameters) {
			p.check (analyzer);
		}

		foreach (Field f in fields) {
			f.check (analyzer);

			if (f.binding == MemberBinding.INSTANCE && is_recursive_value_type (f.field_type)) {
				error = true;
				Report.error (f.source_reference, "Recursive value types are not allowed");
				return false;
			}
		}

		foreach (Constant c in constants) {
			c.check (analyzer);
		}

		foreach (Method m in methods) {
			m.check (analyzer);
		}

		foreach (Property prop in properties) {
			prop.check (analyzer);
		}

		if (!external && !external_package && base_type == null && get_fields ().size == 0
		    && !is_boolean_type () && !is_integer_type () && !is_floating_type ()) {
			error = true;
			Report.error (source_reference, "structs cannot be empty: %s".printf(name));
		}

		analyzer.current_source_file = old_source_file;
		analyzer.current_symbol = old_symbol;

		return !error;
	}
}

// vim:sw=8 noet
