/* valaproperty.vala
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
 *	Raffaele Sandrini <raffaele@sandrini.ch>
 */

using GLib;

/**
 * Represents a property declaration in the source code.
 */
public class Vala.Property : Symbol, Lockable {
	/**
	 * The property type.
	 */
	public DataType? property_type {
		get { return _data_type; }
		set {
			_data_type = value;
			if (value != null) {
				_data_type.parent_node = this;
			}
		}
	}

	/**
	 * The get accessor of this property if available.
	 */
	public PropertyAccessor? get_accessor {
		get { return _get_accessor; }
		set {
			_get_accessor = value;
			if (value != null) {
				value.owner = scope;
			}
		}
	}

	/**
	 * The set/construct accessor of this property if available.
	 */
	public PropertyAccessor? set_accessor {
		get { return _set_accessor; }
		set {
			_set_accessor = value;
			if (value != null) {
				value.owner = scope;
			}
		}
	}

	/**
	 * Represents the generated `this` parameter in this property.
	 */
	public Parameter this_parameter { get; set; }

	/**
	 * Specifies whether automatic accessor code generation should be
	 * disabled.
	 */
	public bool interface_only { get; set; }

	/**
	 * Specifies whether this property is abstract. Abstract properties have
	 * no accessor bodies, may only be specified within abstract classes and
	 * interfaces, and must be overriden by derived non-abstract classes.
	 */
	public bool is_abstract { get; set; }

	/**
	 * Specifies whether this property is virtual. Virtual properties may be
	 * overridden by derived classes.
	 */
	public bool is_virtual { get; set; }

	/**
	 * Specifies whether this property overrides a virtual or abstract
	 * property of a base type.
	 */
	public bool overrides { get; set; }

	/**
	 * Reference the Field that holds this property
	 */
	public Field? field {
		get {
			if (!_field_checked) {
				if (!is_abstract && source_type == SourceFileType.SOURCE) {
					bool has_get = (get_accessor != null);
					bool get_has_body = (has_get && get_accessor.body != null);
					bool has_set = (set_accessor != null);
					bool set_has_body = (has_set && set_accessor.body != null);
					if (set_has_body && (has_get && !get_has_body)) {
						error = true;
						Report.error (source_reference, "Property getter must have a body");
					}
					if (get_has_body && (has_set && !set_has_body)) {
						error = true;
						Report.error (source_reference, "Property setter must have a body");
					}
					if (!get_has_body && !set_has_body) {
						/* automatic property accessor body generation */
						_field = new Field ("_%s".printf (name), property_type.copy (), initializer, source_reference);
						_field.access = SymbolAccessibility.PRIVATE;
						_field.binding = binding;
						// apply gtk-child attribute to backing field for gtk-template support
						if (get_attribute ("GtkChild") != null) {
							_field.set_attribute_string ("GtkChild", "name", get_attribute_string ("GtkChild", "name", name));
							_field.set_attribute_bool ("GtkChild", "internal", get_attribute_bool ("GtkChild", "internal"));
						}
					}
				}
				_field_checked = true;
			}
			return _field;
		}
	}

	/**
	 * Specifies whether this field may only be accessed with an instance of
	 * the contained type.
	 */
	public MemberBinding binding { get; set; default = MemberBinding.INSTANCE; }

	/**
	 * The nick of this property
	 */
	public string nick {
		get {
			if (_nick == null) {
				_nick = get_attribute_string ("Description", "nick");
				if (_nick == null) {
					_nick = name.replace ("_", "-");
				}
			}
			return _nick;
		}
	}

	/**
	 * The blurb of this property
	 */
	public string blurb {
		get {
			if (_blurb == null) {
				_blurb = get_attribute_string ("Description", "blurb");
				if (_blurb == null) {
					_blurb = name.replace ("_", "-");
				}
			}
			return _blurb;
		}
	}

	/**
	 * Specifies whether this a property triggers a notify.
	 */
	public bool notify {
		get {
			if (_notify == null) {
				_notify = get_attribute_bool ("CCode", "notify", true);
			}
			return _notify;
		}
	}

	/**
	 * Specifies the virtual or abstract property this property overrides.
	 * Reference must be weak as virtual properties set base_property to
	 * themselves.
	 */
	public Property base_property {
		get {
			find_base_properties ();
			return _base_property;
		}
	}

	/**
	 * Specifies the abstract interface property this property implements.
	 */
	public Property base_interface_property {
		get {
			find_base_properties ();
			return _base_interface_property;
		}
	}

	/**
	 * Specifies the default value of this property.
	 */
	public Expression initializer {
		get {
			return _initializer;
		}
		set {
			_initializer = value;
			_initializer.parent_node = this;
		}
	}

	public bool lock_used { get; set; }

	private Expression _initializer;

	private DataType _data_type;

	private weak Property _base_property;
	private Property _base_interface_property;
	private bool base_properties_valid;
	PropertyAccessor? _get_accessor;
	PropertyAccessor? _set_accessor;
	private string? _nick;
	private string? _blurb;
	private bool? _notify;
	private Field? _field;
	private bool _field_checked;

	/**
	 * Creates a new property.
	 *
	 * @param name              property name
	 * @param property_type     property type
	 * @param get_accessor      get accessor
	 * @param set_accessor      set/construct accessor
	 * @param source_reference  reference to source code
	 * @return                  newly created property
	 */
	public Property (string name, DataType? property_type, PropertyAccessor? get_accessor, PropertyAccessor? set_accessor, SourceReference? source_reference = null, Comment? comment = null) {
		base (name, source_reference, comment);
		this.property_type = property_type;
		this.get_accessor = get_accessor;
		this.set_accessor = set_accessor;
	}

	public override void accept (CodeVisitor visitor) {
		visitor.visit_property (this);
	}

	public override void accept_children (CodeVisitor visitor) {
		property_type.accept (visitor);

		if (get_accessor != null) {
			get_accessor.accept (visitor);
		}
		if (set_accessor != null) {
			set_accessor.accept (visitor);
		}

		if (initializer != null) {
			initializer.accept (visitor);
		}
	}

	/**
	 * Checks whether the accessors of this property are compatible
	 * with the specified base property.
	 *
	 * @param base_property a property
	 * @param invalid_match error string about which check failed
	 * @return true if the specified property is compatible to this property
	 */
	public bool compatible (Property base_property, out string? invalid_match) {
		if ((get_accessor == null && base_property.get_accessor != null) ||
		    (get_accessor != null && base_property.get_accessor == null)) {
			invalid_match = "incompatible get accessor";
			return false;
		}

		if ((set_accessor == null && base_property.set_accessor != null) ||
		    (set_accessor != null && base_property.set_accessor == null)) {
			invalid_match = "incompatible set accessor";
			return false;
		}

		var object_type = SemanticAnalyzer.get_data_type_for_symbol (parent_symbol);

		if (get_accessor != null) {
			// check accessor value_type instead of property_type
			// due to possible ownership differences
			var actual_base_type = base_property.get_accessor.value_type.get_actual_type (object_type, null, this);
			if (!actual_base_type.equals (get_accessor.value_type)) {
				invalid_match = "incompatible get accessor type";
				return false;
			}
		}

		if (set_accessor != null) {
			// check accessor value_type instead of property_type
			// due to possible ownership differences
			var actual_base_type = base_property.set_accessor.value_type.get_actual_type (object_type, null, this);
			if (!actual_base_type.equals (set_accessor.value_type)) {
				invalid_match = "incompatible set accessor type";
				return false;
			}

			if (set_accessor.writable != base_property.set_accessor.writable) {
				invalid_match = "incompatible set accessor";
				return false;
			}
			if (set_accessor.construction != base_property.set_accessor.construction) {
				invalid_match = "incompatible set accessor";
				return false;
			}
		}

		invalid_match = null;
		return true;
	}

	public override void replace_type (DataType old_type, DataType new_type) {
		if (property_type == old_type) {
			property_type = new_type;
		}
	}

	public override void replace_expression (Expression old_node, Expression new_node) {
		if (initializer == old_node) {
			initializer = new_node;
		}
	}

	private void find_base_properties () {
		if (base_properties_valid) {
			return;
		}

		if (parent_symbol is Class) {
			find_base_interface_property ((Class) parent_symbol);
			if (is_virtual || overrides) {
				find_base_class_property ((Class) parent_symbol);
			}
		} else if (parent_symbol is Interface) {
			if (is_virtual || is_abstract) {
				_base_interface_property = this;
			}
		}

		base_properties_valid = true;
	}

	private void find_base_class_property (Class cl) {
		var sym = cl.scope.lookup (name);
		if (sym is Property) {
			var base_property = (Property) sym;
			if (base_property.is_abstract || base_property.is_virtual) {
				string invalid_match;
				if (!compatible (base_property, out invalid_match)) {
					error = true;
					Report.error (source_reference, "Type and/or accessors of overriding property `%s' do not match overridden property `%s': %s.".printf (get_full_name (), base_property.get_full_name (), invalid_match));
					return;
				}

				_base_property = base_property;
				return;
			}
		}

		if (cl.base_class != null) {
			find_base_class_property (cl.base_class);
		}
	}

	private void find_base_interface_property (Class cl) {
		// FIXME report error if multiple possible base properties are found
		foreach (DataType type in cl.get_base_types ()) {
			if (type.data_type is Interface) {
				var sym = type.data_type.scope.lookup (name);
				if (sym is Property) {
					var base_property = (Property) sym;
					if (base_property.is_abstract || base_property.is_virtual) {
						string invalid_match;
						if (!compatible (base_property, out invalid_match)) {
							error = true;
							Report.error (source_reference, "Type and/or accessors of overriding property `%s' do not match overridden property `%s': %s.".printf (get_full_name (), base_property.get_full_name (), invalid_match));
							return;
						}

						_base_interface_property = base_property;
						return;
					}
				}
			}
		}
	}

	public override bool check (CodeContext context) {
		if (checked) {
			return !error;
		}

		checked = true;

		if (parent_symbol is Class && (is_abstract || is_virtual)) {
			var cl = (Class) parent_symbol;
			if (cl.is_compact && cl.base_class != null) {
				error = true;
				Report.error (source_reference, "Abstract and virtual properties may not be declared in derived compact classes");
				return false;
			}
		}

		if (is_abstract) {
			if (parent_symbol is Class) {
				var cl = (Class) parent_symbol;
				if (!cl.is_abstract) {
					error = true;
					Report.error (source_reference, "Abstract properties may not be declared in non-abstract classes");
					return false;
				}
			} else if (!(parent_symbol is Interface)) {
				error = true;
				Report.error (source_reference, "Abstract properties may not be declared outside of classes and interfaces");
				return false;
			}
		} else if (is_virtual) {
			if (!(parent_symbol is Class) && !(parent_symbol is Interface)) {
				error = true;
				Report.error (source_reference, "Virtual properties may not be declared outside of classes and interfaces");
				return false;
			}
		} else if (overrides) {
			if (!(parent_symbol is Class)) {
				error = true;
				Report.error (source_reference, "Properties may not be overridden outside of classes");
				return false;
			}
		} else if (access == SymbolAccessibility.PROTECTED) {
			if (!(parent_symbol is Class) && !(parent_symbol is Interface)) {
				error = true;
				Report.error (source_reference, "Protected properties may not be declared outside of classes and interfaces");
				return false;
			}
		}

		if (property_type is VoidType) {
			error = true;
			Report.error (source_reference, "'void' not supported as property type");
			return false;
		}

		property_type.check (context);

		if (get_accessor == null && set_accessor == null) {
			error = true;
			Report.error (source_reference, "Property `%s' must have a `get' accessor and/or a `set' mutator".printf (get_full_name ()));
			return false;
		}

		if (get_accessor != null) {
			get_accessor.check (context);
		}
		if (set_accessor != null) {
			set_accessor.check (context);
		}

		if (initializer != null && field == null && !is_abstract) {
			Report.error (source_reference, "Property `%s' with custom `get' accessor and/or `set' mutator cannot have `default' value".printf (get_full_name ()));
		}

		if (initializer != null) {
			initializer.check (context);
		}

		// check whether property type is at least as accessible as the property
		if (!context.analyzer.is_type_accessible (this, property_type)) {
			error = true;
			Report.error (source_reference, "property type `%s' is less accessible than property `%s'".printf (property_type.to_string (), get_full_name ()));
		}

		if (overrides && base_property == null) {
			Report.error (source_reference, "%s: no suitable property found to override".printf (get_full_name ()));
		}

		if (!external_package && !overrides && !hides && get_hidden_member () != null) {
			Report.warning (source_reference, "%s hides inherited property `%s'. Use the `new' keyword if hiding was intentional".printf (get_full_name (), get_hidden_member ().get_full_name ()));
		}

		/* construct properties must be public */
		if (set_accessor != null && set_accessor.construction) {
			if (access != SymbolAccessibility.PUBLIC) {
				error = true;
				Report.error (source_reference, "%s: construct properties must be public".printf (get_full_name ()));
			}
		}

		if (initializer != null && !initializer.error && initializer.value_type != null && !(initializer.value_type.compatible (property_type))) {
			error = true;
			Report.error (initializer.source_reference, "Expected initializer of type `%s' but got `%s'".printf (property_type.to_string (), initializer.value_type.to_string ()));
		}

		return !error;
	}
}
