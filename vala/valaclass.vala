/* valaclass.vala
 *
 * Copyright (C) 2006-2012  Jürg Billeter
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
	 * Specifies whether this class is sealed. Sealed classes may not be
	 * sub-classed.
	 */
	public bool is_sealed { get; set; }

	/**
	 * Instances of compact classes are fast to create and have a
	 * compact memory layout. Compact classes don't support runtime
	 * type information or virtual methods.
	 */
	public bool is_compact {
		get {
			if (_is_compact == null) {
				if (base_class != null && !base_class.is_subtype_of (this)) {
					_is_compact = base_class.is_compact;
				} else {
					_is_compact = get_attribute ("Compact") != null;
				}
			}
			return _is_compact;
		}
		set {
			_is_compact = value;
			set_attribute ("Compact", value);
		}
	}

	/**
	 * Instances of immutable classes are immutable after construction.
	 */
	public bool is_immutable {
		get {
			if (_is_immutable == null) {
				if (base_class != null && !base_class.is_subtype_of (this)) {
					_is_immutable = base_class.is_immutable;
				} else {
					_is_immutable = get_attribute ("Immutable") != null;
				}
			}
			return _is_immutable;
		}
		set {
			_is_immutable = value;
			set_attribute ("Immutable", value);
		}
	}

	/**
	 * Instances of immutable classes are immutable after construction.
	 */
	public bool is_singleton {
		get {
			if (_is_singleton == null) {
				_is_singleton = get_attribute ("SingleInstance") != null;
			}
			return _is_singleton;
		}
		set {
			_is_singleton = value;
			set_attribute ("SingleInstance", value);
		}
	}

	/**
	 * Specifies whether this class has private fields.
	 */
	public bool has_private_fields { get; set; }

	/**
	 * Specifies whether this class has class fields.
	 */
	public bool has_class_private_fields { get; private set; }

	private bool? _is_compact;
	private bool? _is_immutable;
	private bool? _is_singleton;

	private List<DataType> base_types = new ArrayList<DataType> ();
	private HashMap<Method,Method> implicit_implementations = new HashMap<Method,Method> (Symbol.hash_func, Symbol.equal_func);

	/**
	 * Specifies the default construction method.
	 */
	public CreationMethod? default_construction_method { get; private set; }

	/**
	 * Specifies the instance constructor.
	 */
	public Constructor? constructor {
		get { return _constructor; }
		private set {
			_constructor = value;
			if (_constructor != null) {
				_constructor.owner = scope;
			}
		}
	}

	/**
	 * Specifies the class constructor.
	 */
	public Constructor? class_constructor {
		get { return _class_constructor; }
		private set {
			_class_constructor = value;
			if (_class_constructor != null) {
				_class_constructor.owner = scope;
			}
		}
	}

	/**
	 * Specifies the static class constructor.
	 */
	public Constructor? static_constructor {
		get { return _static_constructor; }
		private set {
			_static_constructor = value;
			if (_static_constructor != null) {
				_static_constructor.owner = scope;
			}
		}
	}

	/**
	 * Specifies the instance destructor.
	 */
	public Destructor? destructor {
		get { return _destructor; }
		private set {
			_destructor = value;
			if (_destructor != null) {
				_destructor.owner = scope;
			}
		}
	}

	/**
	 * Specifies the class destructor.
	 */
	public Destructor? static_destructor {
		get { return _static_destructor; }
		private set {
			_static_destructor = value;
			if (_static_destructor != null) {
				_static_destructor.owner = scope;
			}
		}
	}

	/**
	 * Specifies the class destructor.
	 */
	public Destructor? class_destructor {
		get { return _class_destructor; }
		private set {
			_class_destructor = value;
			if (_class_destructor != null) {
				_class_destructor.owner = scope;
			}
		}
	}

	/**
	 * Specifies whether this class denotes an error base.
	 */
	public bool is_error_base {
		get {
			return get_attribute ("ErrorBase") != null;
		}
	}

	Constructor? _constructor;
	Constructor? _class_constructor;
	Constructor? _static_constructor;
	Destructor? _destructor;
	Destructor? _class_destructor;
	Destructor? _static_destructor;

	/**
	 * Creates a new class.
	 *
	 * @param name             type name
	 * @param source_reference reference to source code
	 * @param comment          class documentation
	 * @return                 newly created class
	 */
	public Class (string name, SourceReference? source_reference = null, Comment? comment = null) {
		base (name, source_reference, comment);
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
	 * Returns the base type list.
	 *
	 * @return list of base types
	 */
	public unowned List<DataType> get_base_types () {
		return base_types;
	}

	/**
	 * Adds the specified field as a member to this class.
	 *
	 * @param f a field
	 */
	public override void add_field (Field f) {
		base.add_field (f);

		if (f.access == SymbolAccessibility.PRIVATE && f.binding == MemberBinding.INSTANCE) {
			has_private_fields = true;
		} else if (f.access == SymbolAccessibility.PRIVATE && f.binding == MemberBinding.CLASS) {
			has_class_private_fields = true;
		}
	}

	/**
	 * Adds the specified method as a member to this class.
	 *
	 * @param m a method
	 */
	public override void add_method (Method m) {
		if (m.binding != MemberBinding.STATIC || m is CreationMethod) {
			if (m.this_parameter != null) {
				m.scope.remove (m.this_parameter.name);
			}
			m.this_parameter = new Parameter ("this", SemanticAnalyzer.get_this_type (m, this), m.source_reference);
			m.scope.add (m.this_parameter.name, m.this_parameter);
		}
		if (!(m.return_type is VoidType) && m.get_postconditions ().size > 0) {
			if (m.result_var != null) {
				m.scope.remove (m.result_var.name);
			}
			m.result_var = new LocalVariable (m.return_type.copy (), "result", null, m.source_reference);
			m.result_var.is_result = true;
		}
		if (m is CreationMethod) {
			if (m.name == null) {
				default_construction_method = (CreationMethod) m;
				m.name = ".new";
			}

			unowned CreationMethod cm = (CreationMethod) m;
			if (cm.class_name != null && cm.class_name != name) {
				// class_name is null for constructors generated by GIdlParser
				Report.error (m.source_reference, "missing return type in method `%s.%s´".printf (get_full_name (), cm.class_name));
				m.error = true;
				return;
			}
			if (is_abstract && cm.access == SymbolAccessibility.PUBLIC) {
				//TODO Report an error for external constructors too
				if (external_package) {
					Report.warning (m.source_reference, "Creation method of abstract class cannot be public.");
				} else {
					Report.error (m.source_reference, "Creation method of abstract class cannot be public.");
					error = true;
					return;
				}
			}
		}

		base.add_method (m);
	}

	public HashMap<Method,Method> get_implicit_implementations () {
		return implicit_implementations;
	}

	/**
	 * Adds the specified property as a member to this class.
	 *
	 * @param prop a property
	 */
	public override void add_property (Property prop) {
		base.add_property (prop);

		if (prop.binding != MemberBinding.STATIC) {
			prop.this_parameter = new Parameter ("this", SemanticAnalyzer.get_this_type (prop, this), prop.source_reference);
			prop.scope.add (prop.this_parameter.name, prop.this_parameter);
		}

		if (prop.field != null) {
			add_field (prop.field);
		}
	}

	public override void add_constructor (Constructor c) {
		switch (c.binding) {
		case MemberBinding.INSTANCE:
			if (constructor != null) {
				Report.error (c.source_reference, "class already contains a constructor");
			}
			constructor = c;
			break;
		case MemberBinding.CLASS:
			if (class_constructor != null) {
				Report.error (c.source_reference, "class already contains a class constructor");
			}
			class_constructor = c;
			break;
		case MemberBinding.STATIC:
			if (static_constructor != null) {
				Report.error (c.source_reference, "class already contains a static constructor");
			}
			static_constructor = c;
			break;
		default:
			assert_not_reached ();
		}

		if (c.binding != MemberBinding.STATIC) {
			if (c.this_parameter != null) {
				c.scope.remove (c.this_parameter.name);
			}
			c.this_parameter = new Parameter ("this", SemanticAnalyzer.get_this_type (c, this), c.source_reference);
			c.scope.add (c.this_parameter.name, c.this_parameter);
		}
	}

	public override void add_destructor (Destructor d) {
		switch (d.binding) {
		case MemberBinding.INSTANCE:
			if (destructor != null) {
				Report.error (d.source_reference, "class already contains a destructor");
			}
			destructor = d;
			break;
		case MemberBinding.CLASS:
			if (class_destructor != null) {
				Report.error (d.source_reference, "class already contains a class destructor");
			}
			class_destructor = d;
			break;
		case MemberBinding.STATIC:
			if (static_destructor != null) {
				Report.error (d.source_reference, "class already contains a static destructor");
			}
			static_destructor = d;
			break;
		default:
			assert_not_reached ();
		}

		if (d.binding != MemberBinding.STATIC) {
			if (d.this_parameter != null) {
				d.scope.remove (d.this_parameter.name);
			}
			d.this_parameter = new Parameter ("this", SemanticAnalyzer.get_this_type (d, this), d.source_reference);
			d.scope.add (d.this_parameter.name, d.this_parameter);
		}
	}

	public override void accept (CodeVisitor visitor) {
		visitor.visit_class (this);
	}

	public override void accept_children (CodeVisitor visitor) {
		foreach (DataType type in base_types) {
			type.accept (visitor);
		}

		// Invoke common implementation in ObjectTypeSymbol
		base.accept_children (visitor);

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

		if (static_destructor != null) {
			static_destructor.accept (visitor);
		}

		if (class_destructor != null) {
			class_destructor.accept (visitor);
		}
	}

	public override bool is_reference_type () {
		return true;
	}

	public bool is_fundamental () {
		if (!is_compact && base_class == null) {
			return true;
		}
		return false;
	}

	public override bool is_subtype_of (TypeSymbol t) {
		if (this == t) {
			return true;
		}

		foreach (DataType base_type in base_types) {
			if (base_type.type_symbol != null && base_type.type_symbol != this
			    && base_type.type_symbol.is_subtype_of (t)) {
				return true;
			}
		}

		return false;
	}

	public override void replace_type (DataType old_type, DataType new_type) {
		for (int i = 0; i < base_types.size; i++) {
			if (base_types[i] == old_type) {
				base_types[i] = new_type;
				new_type.parent_node = this;
				return;
			}
		}
	}

	private void get_all_prerequisites (Interface iface, List<TypeSymbol> list) {
		foreach (DataType prereq in iface.get_prerequisites ()) {
			TypeSymbol type = prereq.type_symbol;
			/* skip on previous errors */
			if (type == null) {
				continue;
			}

			list.add (type);
			if (type is Interface) {
				get_all_prerequisites ((Interface) type, list);

			}
		}
	}

	public bool is_a (ObjectTypeSymbol t) {
		if (this == t) {
			return true;
		}

		foreach (DataType base_type in get_base_types ()) {
			if (base_type.type_symbol is Class) {
				if (((Class) base_type.type_symbol).is_a (t)) {
					return true;
				}
			} else if (base_type.type_symbol == t) {
				return true;
			}
		}

		return false;
	}

	public bool implements (Interface i) {
		foreach (DataType base_type in get_base_types ()) {
			if (base_type.type_symbol == i) {
				return true;
			}
		}

		return false;
	}

	public override bool check (CodeContext context) {
		if (checked) {
			return !error;
		}

		if (!base.check (context)) {
			return false;
		}

		checked = true;

		var old_source_file = context.analyzer.current_source_file;
		var old_symbol = context.analyzer.current_symbol;

		if (source_reference != null) {
			context.analyzer.current_source_file = source_reference.file;
		}
		context.analyzer.current_symbol = this;

		foreach (DataType base_type_reference in get_base_types ()) {
			if (!base_type_reference.check (context)) {
				error = true;
				return false;
			}

			if (!(base_type_reference is ObjectType)) {
				error = true;
				Report.error (source_reference, "base type `%s' of class `%s' is not an object type".printf (base_type_reference.to_string (), get_full_name ()));
				return false;
			}

			// check whether base type is at least as accessible as the class
			if (!context.analyzer.is_type_accessible (this, base_type_reference)) {
				error = true;
				Report.error (source_reference, "base type `%s' is less accessible than class `%s'".printf (base_type_reference.to_string (), get_full_name ()));
				return false;
			}

			// check whether there is the expected amount of type-arguments
			if (!base_type_reference.check_type_arguments (context)) {
				error = true;
				return false;
			}
		}

		foreach (DataType type in base_types) {
			type.check (context);
			context.analyzer.check_type (type);
		}

		foreach (TypeParameter p in get_type_parameters ()) {
			p.check (context);
		}

		if (base_class != null && base_class.is_singleton) {
			error = true;
			Report.error (source_reference, "`%s' cannot inherit from SingleInstance class `%s'".printf (get_full_name (), base_class.get_full_name ()));
		}

		if (is_singleton && !is_subtype_of (context.analyzer.object_type)) {
			error = true;
			Report.error (source_reference, "SingleInstance class `%s' requires inheritance from `GLib.Object'".printf (get_full_name ()));
		}

		/* singleton classes require an instance constructor */
		if (is_singleton && constructor == null) {
			var c = new Constructor (source_reference);
			c.body = new Block (source_reference);
			add_constructor (c);
		}

		if (base_class != null && base_class.is_sealed) {
			error = true;
			Report.error (source_reference, "`%s' cannot inherit from sealed class `%s'".printf (get_full_name (), base_class.get_full_name ()));
		}

		if (is_sealed) {
			if (is_compact) {
				error = true;
				Report.error (source_reference, "Sealed class `%s' cannot be compact".printf (get_full_name ()));
				return false;
			}
			if (is_abstract) {
				error = true;
				Report.error (source_reference, "Sealed class `%s' cannot be abstract".printf (get_full_name ()));
				return false;
			}
			if (!external_package) {
				error = true;
				Report.error (source_reference, "Sealed classes are not fully supported yet");
				return false;
			}
		}

		/* process enums first to avoid order problems in C code */
		foreach (Enum en in get_enums ()) {
			en.check (context);
		}

		foreach (Field f in get_fields ()) {
			if (is_compact && f.binding != MemberBinding.STATIC) {
				//FIXME Should external bindings follow this too?
				if (!external_package && f.access == SymbolAccessibility.PRIVATE) {
					Report.error (source_reference, "private fields are not supported in compact classes");
					error = true;
				}
				if (f.binding == MemberBinding.CLASS) {
					Report.error (f.source_reference, "class fields are not supported in compact classes");
					error = true;
				}
			}

			f.check (context);
		}

		foreach (Constant c in get_constants ()) {
			c.check (context);
		}

		foreach (Method m in get_methods ()) {
			m.check (context);
		}

		foreach (Property prop in get_properties ()) {
			if (prop.get_attribute ("NoAccessorMethod") != null && !is_subtype_of (context.analyzer.object_type)) {
				error = true;
				Report.error (prop.source_reference, "NoAccessorMethod is only allowed for properties in classes derived from GLib.Object");
				return false;
			}
			prop.check (context);
		}

		foreach (Signal sig in get_signals ()) {
			sig.check (context);
		}

		if (constructor != null) {
			constructor.check (context);
		}

		if (class_constructor != null) {
			class_constructor.check (context);
		}

		if (static_constructor != null) {
			static_constructor.check (context);
		}

		if (destructor != null) {
			destructor.check (context);
		}

		if (static_destructor != null) {
			static_destructor.check (context);
		}

		if (class_destructor != null) {
			class_destructor.check (context);
		}

		foreach (Class cl in get_classes ()) {
			cl.check (context);
		}

		foreach (Interface iface in get_interfaces ()) {
			iface.check (context);
		}

		foreach (Struct st in get_structs ()) {
			st.check (context);
		}

		foreach (Delegate d in get_delegates ()) {
			d.check (context);
		}

		/* compact classes cannot implement interfaces */
		if (is_compact) {
			foreach (DataType base_type in get_base_types ()) {
				if (base_type.type_symbol is Interface) {
					error = true;
					Report.error (source_reference, "compact classes `%s' may not implement interfaces".printf (get_full_name ()));
				}
			}

			if (!external && !external_package && base_class != null && base_class != context.analyzer.gsource_type) {
				foreach (Field f in get_fields ()) {
					if (f.binding == MemberBinding.INSTANCE) {
						error = true;
						Report.error (source_reference, "derived compact classes may not have instance fields");
						break;
					}
				}
			}
		}

		/* gather all prerequisites */
		List<TypeSymbol> prerequisites = new ArrayList<TypeSymbol> ();
		foreach (DataType base_type in get_base_types ()) {
			if (base_type.type_symbol is Interface) {
				get_all_prerequisites ((Interface) base_type.type_symbol, prerequisites);
			}
		}
		/* check whether all prerequisites are met */
		List<string> missing_prereqs = new ArrayList<string> (str_equal);
		foreach (TypeSymbol prereq in prerequisites) {
			if (!is_a ((ObjectTypeSymbol) prereq)) {
				missing_prereqs.insert (0, prereq.get_full_name ());
			}
		}
		/* report any missing prerequisites */
		if (missing_prereqs.size > 0) {
			error = true;

			string error_string = "%s: some prerequisites (".printf (get_full_name ());
			bool first = true;
			foreach (string s in missing_prereqs) {
				if (first) {
					error_string = "%s`%s'".printf (error_string, s);
					first = false;
				} else {
					error_string = "%s, `%s'".printf (error_string, s);
				}
			}
			error_string += ") are not met";
			Report.error (source_reference, error_string);
		}

		/* VAPI classes don't have to specify overridden methods */
		if (source_type == SourceFileType.SOURCE) {
			/* all abstract symbols defined in base types have to be at least defined (or implemented) also in this type */
			foreach (DataType base_type in get_base_types ()) {
				if (base_type.type_symbol is Interface) {
					unowned Interface iface = (Interface) base_type.type_symbol;

					if (base_class != null && base_class.is_subtype_of (iface)) {
						// reimplementation of interface, class is not required to reimplement all methods
						break;
					}

					/* We do not need to do expensive equality checking here since this is done
					 * already. We only need to guarantee the symbols are present.
					 */

					/* check methods */
					foreach (Method m in iface.get_methods ()) {
						if (m.is_abstract) {
							var implemented = false;
							unowned Class? base_class = this;
							while (base_class != null && !implemented) {
								foreach (var impl in base_class.get_methods ()) {
									if (impl.base_interface_method == m || (base_class != this
									    && impl.base_interface_method == null && impl.name == m.name
									    && (impl.base_interface_type == null || impl.base_interface_type.type_symbol == iface)
									    && impl.compatible_no_error (m))) {
										// method is used as interface implementation, so it is not unused
										impl.version.check (source_reference);
										impl.used = true;
										implemented = true;
										if (impl.base_interface_method == null) {
											implicit_implementations.set (m, impl);
										}
										break;
									}
								}
								base_class = base_class.base_class;
							}
							if (!implemented) {
								error = true;
								Report.error (source_reference, "`%s' does not implement interface method `%s'".printf (get_full_name (), m.get_full_name ()));
							}
						}
					}

					/* check properties */
					foreach (Property prop in iface.get_properties ()) {
						if (prop.is_abstract) {
							Symbol sym = null;
							unowned Class? base_class = this;
							while (base_class != null && !(sym is Property)) {
								sym = base_class.scope.lookup (prop.name);
								base_class = base_class.base_class;
							}
							if (sym is Property) {
								var base_prop = (Property) sym;
								string? invalid_match = null;
								// No check at all for "new" classified properties, really?
								if (!base_prop.hides && !base_prop.compatible (prop, out invalid_match)) {
									error = true;
									Report.error (source_reference, "Type and/or accessors of inherited properties `%s' and `%s' do not match: %s.".printf (prop.get_full_name (), base_prop.get_full_name (), invalid_match));
								}
								// property is used as interface implementation, so it is not unused
								sym.version.check (source_reference);
								sym.used = true;
							} else {
								error = true;
								Report.error (source_reference, "`%s' does not implement interface property `%s'".printf (get_full_name (), prop.get_full_name ()));
							}
						}
					}
				}
			}

			/* all abstract symbols defined in base classes have to be implemented in non-abstract classes */
			if (!is_abstract) {
				unowned Class? base_class = base_class;
				while (base_class != null && base_class.is_abstract) {
					foreach (Method base_method in base_class.get_methods ()) {
						if (base_method.is_abstract) {
							var override_method = SemanticAnalyzer.symbol_lookup_inherited (this, base_method.name) as Method;
							if (override_method == null || !override_method.overrides) {
								error = true;
								Report.error (source_reference, "`%s' does not implement abstract method `%s'".printf (get_full_name (), base_method.get_full_name ()));
							}
						}
					}
					foreach (Property base_property in base_class.get_properties ()) {
						if (base_property.is_abstract) {
							var override_property = SemanticAnalyzer.symbol_lookup_inherited (this, base_property.name) as Property;
							if (override_property == null || !override_property.overrides) {
								error = true;
								Report.error (source_reference, "`%s' does not implement abstract property `%s'".printf (get_full_name (), base_property.get_full_name ()));
							}
						}
					}
					base_class = base_class.base_class;
				}
			}
		}

		context.analyzer.current_source_file = old_source_file;
		context.analyzer.current_symbol = old_symbol;

		return !error;
	}
}

// vim:sw=8 noet
