/* valastruct.vala
 *
 * Copyright (C) 2006-2010  Jürg Billeter
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
 * Represents a struct declaration in the source code.
 */
public class Vala.Struct : TypeSymbol {
	private List<TypeParameter> type_parameters = new ArrayList<TypeParameter> ();
	private List<Constant> constants = new ArrayList<Constant> ();
	private List<Field> fields = new ArrayList<Field> ();
	private List<Method> methods = new ArrayList<Method> ();
	private List<Property> properties = new ArrayList<Property> ();
	private DataType _base_type = null;

	private bool? boolean_type;
	private bool? integer_type;
	private bool? floating_type;
	private bool? decimal_floating_type;
	private bool? simple_type;
	private int? rank;
	private int? _width;
	private bool? _signed;
	private bool? _is_immutable;

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
	public bool is_immutable {
		get {
			if (_is_immutable == null) {
				_is_immutable = get_attribute ("Immutable") != null;
			}
			return _is_immutable;
		}
		set {
			_is_immutable = value;
			set_attribute ("Immutable", value);
		}
	}

	public int width {
		get {
			if (_width == null) {
				if (is_integer_type ()) {
					_width = get_attribute_integer ("IntegerType", "width", 32);
				} else {
					_width = get_attribute_integer ("FloatingType", "width", 32);
				}
			}
			return _width;
		}
		set {
			_width = value;
			if (is_integer_type ()) {
				set_attribute_integer ("IntegerType", "width", value);
			} else {
				set_attribute_integer ("FloatingType", "width", value);
			}
		}
	}

	public bool signed {
		get {
			if (_signed == null) {
				_signed = get_attribute_bool ("IntegerType", "signed", true);
			}
			return _signed;
		}
		set {
			_signed = value;
			set_attribute_bool ("IntegerType", "signed", value);
		}
	}

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
	public List<TypeParameter> get_type_parameters () {
		return type_parameters;
	}

	/**
	 * Adds the specified constant as a member to this struct.
	 *
	 * @param c a constant
	 */
	public override void add_constant (Constant c) {
		constants.add (c);
		scope.add (c.name, c);
	}
	
	/**
	 * Adds the specified field as a member to this struct.
	 *
	 * @param f a field
	 */
	public override void add_field (Field f) {
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
	public List<Field> get_fields () {
		return fields;
	}

	/**
	 * Returns a copy of the list of constants.
	 *
	 * @return list of constants
	 */
	public List<Constant> get_constants () {
		return constants;
	}

	/**
	 * Adds the specified method as a member to this struct.
	 *
	 * @param m a method
	 */
	public override void add_method (Method m) {
		return_if_fail (m != null);
		
		if (m.binding == MemberBinding.INSTANCE || m is CreationMethod) {
			m.this_parameter = new Parameter ("this", SemanticAnalyzer.get_data_type_for_symbol (this));
			m.scope.add (m.this_parameter.name, m.this_parameter);
		}
		if (!(m.return_type is VoidType) && (CodeContext.get ().profile == Profile.DOVA || m.get_postconditions ().size > 0)) {
			m.result_var = new LocalVariable (m.return_type.copy (), "result", null, source_reference);
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
	public List<Method> get_methods () {
		return methods;
	}

	/**
	 * Adds the specified property as a member to this struct.
	 *
	 * @param prop a property
	 */
	public override void add_property (Property prop) {
		properties.add (prop);
		scope.add (prop.name, prop);

		prop.this_parameter = new Parameter ("this", SemanticAnalyzer.get_data_type_for_symbol (this));
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
	public List<Property> get_properties () {
		return properties;
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

	/**
	 * Returns whether this is a boolean type.
	 *
	 * @return true if this is a boolean type, false otherwise
	 */
	public bool is_boolean_type () {
		var st = base_struct;
		if (st != null && st.is_boolean_type ()) {
			return true;
		}
		if (boolean_type == null) {
			boolean_type = get_attribute ("BooleanType") != null;
		}
		return boolean_type;
	}

	/**
	 * Returns whether this is an integer type.
	 *
	 * @return true if this is an integer type, false otherwise
	 */
	public bool is_integer_type () {
		var st = base_struct;
		if (st != null && st.is_integer_type ()) {
			return true;
		}
		if (integer_type == null) {
			integer_type = get_attribute ("IntegerType") != null;
		}
		return integer_type;
	}
	
	/**
	 * Returns whether this is a floating point type.
	 *
	 * @return true if this is a floating point type, false otherwise
	 */
	public bool is_floating_type () {
		var st = base_struct;
		if (st != null && st.is_floating_type ()) {
			return true;
		}
		if (floating_type == null) {
			floating_type = get_attribute ("FloatingType") != null;
		}
		return floating_type;
	}

	public bool is_decimal_floating_type () {
		var st = base_struct;
		if (st != null && st.is_decimal_floating_type ()) {
			return true;
		}
		if (decimal_floating_type == null) {
			decimal_floating_type = get_attribute_bool ("FloatingType", "decimal");
		}
		return decimal_floating_type;
	}

	/**
	 * Returns the rank of this integer or floating point type.
	 *
	 * @return the rank if this is an integer or floating point type
	 */
	public int get_rank () {
		if (rank == null) {
			if (is_integer_type () && has_attribute_argument ("IntegerType", "rank")) {
				rank = get_attribute_integer ("IntegerType", "rank");
			} else if (has_attribute_argument ("FloatingType", "rank")) {
				rank = get_attribute_integer ("FloatingType", "rank");
			} else {
				var st = base_struct;
				if (st != null) {
					rank = st.get_rank ();
				}
			}
		}
		return rank;
	}

	/**
	 * Sets the rank of this integer or floating point type.
	 *
	 * @return the rank if this is an integer or floating point type
	 */
	public void set_rank (int rank) {
		this.rank = rank;
		if (is_integer_type ()) {
			set_attribute_integer ("IntegerType", "rank", rank);
		} else {
			set_attribute_integer ("FloatingType", "rank", rank);
		}
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
		if (CodeContext.get ().profile == Profile.DOVA) {
			return true;
		}
		var st = base_struct;
		if (st != null && st.is_simple_type ()) {
			return true;
		}
		if (simple_type == null) {
			simple_type = get_attribute ("SimpleType") != null || get_attribute ("BooleanType") != null || get_attribute ("IntegerType") != null || get_attribute ("FloatingType") != null;
		}
		return simple_type;
	}

	/**
	 * Marks this struct as simple type, i.e. instances will be passed by
	 * value.
	 */
	public void set_simple_type (bool simple_type) {
		this.simple_type = simple_type;
		set_attribute ("SimpleType", simple_type);
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

	public bool is_disposable () {
		if (get_attribute_string ("CCode", "destroy_function") != null) {
			return true;
		}

		foreach (Field f in fields) {
			if (f.binding == MemberBinding.INSTANCE
			    && f.variable_type.is_disposable ()) {
				return true;
			}
		}

		return false;
	}

	bool is_recursive_value_type (DataType type) {
		var struct_type = type as StructValueType;
		if (struct_type != null && !struct_type.nullable) {
			var st = (Struct) struct_type.type_symbol;
			if (st == this) {
				return true;
			}
			foreach (Field f in st.fields) {
				if (f.binding == MemberBinding.INSTANCE && is_recursive_value_type (f.variable_type)) {
					return true;
				}
			}
		}
		return false;
	}

	public override bool check (CodeContext context) {
		if (checked) {
			return !error;
		}

		checked = true;

		var old_source_file = context.analyzer.current_source_file;
		var old_symbol = context.analyzer.current_symbol;

		if (source_reference != null) {
			context.analyzer.current_source_file = source_reference.file;
		}
		context.analyzer.current_symbol = this;

		if (base_type != null) {
			base_type.check (context);

			if (!(base_type is ValueType)) {
				error = true;
				Report.error (source_reference, "The base type `%s` of struct `%s` is not a struct".printf (base_type.to_string (), get_full_name ()));
				return false;
			}
		}

		foreach (TypeParameter p in type_parameters) {
			p.check (context);
		}

		foreach (Field f in fields) {
			f.check (context);

			if (f.binding == MemberBinding.INSTANCE && is_recursive_value_type (f.variable_type)) {
				error = true;
				Report.error (f.source_reference, "Recursive value types are not allowed");
				return false;
			}

			if (f.binding == MemberBinding.INSTANCE && f.initializer != null) {
				error = true;
				Report.error (f.source_reference, "Instance field initializers not supported");
				return false;
			}
		}

		foreach (Constant c in constants) {
			c.check (context);
		}

		foreach (Method m in methods) {
			m.check (context);
		}

		foreach (Property prop in properties) {
			prop.check (context);
		}

		if (!external && !external_package) {
			if (base_type == null && get_fields ().size == 0 && !is_boolean_type () && !is_integer_type () && !is_floating_type ()) {
				error = true;
				Report.error (source_reference, "structs cannot be empty: %s".printf(name));
			} else if (base_type != null) {
				foreach (Field f in fields) {
					if (f.binding == MemberBinding.INSTANCE) {
						error = true;
						Report.error (source_reference, "derived structs may not have instance fields");
						break;
					}
				}
			}
		}

		context.analyzer.current_source_file = old_source_file;
		context.analyzer.current_symbol = old_symbol;

		return !error;
	}
}

// vim:sw=8 noet
