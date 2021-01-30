/* class.vala
 *
 * Copyright (C) 2008-2011  Florian Brosch
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public
 * License as published by the Free Software Foundation; either
 * version 2.1 of the License, or (at your option) any later version.
 *
 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public
 * License along with this library; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301  USA
 *
 * Author:
 * 	Florian Brosch <flo.brosch@gmail.com>
 */


using Valadoc.Content;

/**
 * Represents a class declaration.
 */
public class Valadoc.Api.Class : TypeSymbol {
	private Vala.ArrayList<TypeReference> interfaces;

	private string? dbus_name;
	private string? take_value_function_cname;
	private string? get_value_function_cname;
	private string? set_value_function_cname;
	private string? unref_function_name;
	private string? ref_function_name;
	private string? free_function_name;
	private string? param_spec_function_name;
	private string? type_id;
	private string? is_class_type_macro_name;
	private string? class_type_macro_name;
	private string? class_macro_name;
	private string? private_cname;
	private string? cname;

	public Class (Node parent, SourceFile file, string name, Vala.SymbolAccessibility accessibility,
				  SourceComment? comment,
				  Vala.Class data)
	{
		bool is_basic_type = data.base_class == null && data.name == "string";

		base (parent, file, name, accessibility, comment, is_basic_type, data);

		this.interfaces = new Vala.ArrayList<TypeReference> ();

		if (!data.is_compact) {
			this.is_class_type_macro_name = Vala.get_ccode_class_type_check_function (data);
			this.class_type_macro_name = Vala.get_ccode_class_type_function (data);
			this.class_macro_name = Vala.get_ccode_type_get_function (data);
			this.private_cname = _get_private_cname (data);
		}
		this.dbus_name = Vala.GDBusModule.get_dbus_name (data);
		this.type_id = Vala.get_ccode_type_id (data);
		this.cname = Vala.get_ccode_name (data);

		this.param_spec_function_name = Vala.get_ccode_param_spec_function (data);

		this.unref_function_name = Vala.get_ccode_unref_function (data);
		this.ref_function_name = Vala.get_ccode_ref_function (data);
		this.free_function_name = (data.is_compact ? Vala.get_ccode_free_function (data) : null);

		this.take_value_function_cname = Vala.get_ccode_take_value_function (data);
		this.get_value_function_cname = Vala.get_ccode_get_value_function (data);
		this.set_value_function_cname = Vala.get_ccode_set_value_function (data);

		this.is_fundamental = data.is_fundamental ();
		this.is_abstract = data.is_abstract;
		this.is_sealed = data.is_sealed;
	}

	string? _get_private_cname (Vala.Class element) {
		if (element.is_compact) {
			return null;
		}

		string? cname = Vala.get_ccode_name (element);
		return (cname != null ? cname + "Private" : null);
	}

	/**
	 * Specifies the base class.
	 */
	public TypeReference? base_type {
		set;
		get;
	}

	/**
	 * Returns the name of this class as it is used in C.
	 */
	public string? get_cname () {
		return cname;
	}

	/**
	 * Returns the name of this class' private data structure as it is used in C.
	 */
	public string? get_private_cname () {
		return private_cname;
	}

	/**
	 * Returns the C symbol representing the runtime type id for this data type.
	 */
	public string? get_type_id () {
		return type_id;
	}

	/**
	 * Returns the C function name that increments the reference count of
	 * instances of this data type.
	 *
	 * @return the name of the C function or null if this data type does not
	 *         support reference counting
	 */
	public string? get_ref_function_cname () {
		return ref_function_name;
	}

	/**
	 * Returns the C function name that decrements the reference count of
	 * instances of this data type.
	 *
	 * @return the name of the C function or null if this data type does not
	 *         support reference counting
	 */
	public string? get_unref_function_cname () {
		return unref_function_name;
	}

	/**
	 * Returns the C function name that frees the
	 * instances of this data type.
	 *
	 * @return the name of the C function or null
	 */
	public string? get_free_function_name () {
		return free_function_name;
	}

	/**
	 * Returns the cname of the GValue parameter spec function.
	 */
	public string? get_param_spec_function_cname () {
		return param_spec_function_name;
	}

	/**
	 * Returns the cname of the GValue setter function.
	 */
	public string? get_set_value_function_cname () {
		return set_value_function_cname;
	}

	/**
	 * Returns the cname of the GValue getter function.
	 */
	public string? get_get_value_function_cname () {
		return get_value_function_cname;
	}

	/**
	 * Returns the cname of the GValue taker function.
	 */
	public string? get_take_value_function_cname () {
		return take_value_function_cname;
	}

	/**
	 * Returns the dbus-name.
	 */
	public string? get_dbus_name () {
		return dbus_name;
	}

	/**
	 * Gets the name of the GType macro which returns the class struct.
	 */
	public string get_class_macro_name () {
		return class_macro_name;
	}

	/**
	 * Gets the name of the GType macro which returns the type of the class.
	 */
	public string get_class_type_macro_name () {
		return class_type_macro_name;
	}

	/**
	 * Gets the name of the GType macro which returns whether a class instance is of a given type.
	 */
	public string get_is_class_type_macro_name () {
		return is_class_type_macro_name;
	}

	/**
	 * Returns a list of all newly implemented interfaces.
	 *
	 * @see get_full_implemented_interface_list
	 */
	public Vala.Collection<TypeReference> get_implemented_interface_list () {
		return this.interfaces;
	}

	private Vala.Collection<TypeReference> _full_implemented_interfaces = null;

	/**
	 * Returns a list of all implemented interfaces.
	 *
	 * @see get_implemented_interface_list
	 */
	public Vala.Collection<TypeReference> get_full_implemented_interface_list () {
		if (_full_implemented_interfaces == null) {
			_full_implemented_interfaces = new Vala.ArrayList<TypeReference> ();
			_full_implemented_interfaces.add_all (this.interfaces);

			if (base_type != null) {
				_full_implemented_interfaces.add_all (((Class) base_type.data_type).get_full_implemented_interface_list ());
			}
		}

		return _full_implemented_interfaces;
	}

	public void add_interface (TypeReference iface) {
		interfaces.add (iface);
	}

	/**
	 * Specifies whether this class is abstract.
	 */
	public bool is_abstract {
		private set;
		get;
	}

	/**
	 * Specifies whether this class is sealed. Sealed classes may not be
	 * sub-classed.
	 */
	public bool is_sealed {
		private set;
		get;
	}

	/**
	 * Specifies whether this class is fundamental.
	 */
	public bool is_fundamental {
		private set;
		get;
	}

	public bool is_compact {
		get {
			return ((Vala.Class) data).is_compact;
		}
	}

	/**
	 * {@inheritDoc}
	 */
	public override NodeType node_type { get { return NodeType.CLASS; } }

	/**
	 * {@inheritDoc}
	 */
	public override void accept (Visitor visitor) {
		visitor.visit_class (this);
	}

	private Vala.Set<Interface> _known_derived_interfaces = new Vala.HashSet<Interface> ();
	private Vala.Set<Class> _known_child_classes = new Vala.HashSet<Class> ();

	/**
	 * Returns a list of all known classes based on this class
	 */
	public Vala.Collection<Class> get_known_child_classes () {
		return _known_child_classes;
	}

	/**
	 * Returns a list of all known interfaces based on this class
	 */
	public Vala.Collection<Interface> get_known_derived_interfaces () {
		return _known_derived_interfaces;
	}

	public void register_derived_interface (Interface iface) {
		_known_derived_interfaces.add (iface);
	}

	public void register_child_class (Class cl) {
		if (this.base_type != null) {
			((Class) this.base_type.data_type).register_child_class (cl);
		}

		_known_child_classes.add (cl);
	}

	/**
	 * {@inheritDoc}
	 */
	protected override Inline build_signature () {
		var signature = new SignatureBuilder ();

		signature.append_keyword (accessibility.to_string ());
		if (is_abstract) {
			signature.append_keyword ("abstract");
		}
		if (is_sealed) {
			signature.append_keyword ("sealed");
		}
		signature.append_keyword ("class");
		signature.append_symbol (this);

		var type_parameters = get_children_by_type (NodeType.TYPE_PARAMETER, false);
		if (type_parameters.size > 0) {
			signature.append ("<", false);
			bool first = true;
			foreach (Item param in type_parameters) {
				if (!first) {
					signature.append (",", false);
				}
				signature.append_content (param.signature, false);
				first = false;
			}
			signature.append (">", false);
		}

		bool first = true;
		if (base_type != null) {
			signature.append (":");

			signature.append_content (base_type.signature);
			first = false;
		}

		if (interfaces.size > 0) {
			if (first) {
				signature.append (":");
			}

			foreach (Item implemented_interface in interfaces) {
				if (!first) {
					signature.append (",", false);
				}
				signature.append_content (implemented_interface.signature);
				first = false;
			}
		}

		return signature.get ();
	}
}

