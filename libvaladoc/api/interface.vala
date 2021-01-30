/* interface.vala
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
 * Represents a interface declaration in the source code.
 */
public class Valadoc.Api.Interface : TypeSymbol {
	private string? interface_macro_name;
	private string? dbus_name;
	private string? cname;
	private string? type_id;

	public Interface (Node parent, SourceFile file, string name, Vala.SymbolAccessibility accessibility,
					  SourceComment? comment,
					  Vala.Interface data)
	{
		base (parent, file, name, accessibility, comment, false, data);

		this.interface_macro_name = Vala.get_ccode_type_get_function (data);
		this.dbus_name = Vala.GDBusModule.get_dbus_name (data);
		this.cname = Vala.get_ccode_name (data);
		this.type_id = Vala.get_ccode_type_id (data);
	}

	/**
	 * A list of preconditioned interfaces
	 */
	private Vala.ArrayList<TypeReference> interfaces = new Vala.ArrayList<TypeReference> ();

	/**
	 * Add a newpreconditioned interface to the list
	 */
	public void add_interface (TypeReference iface) {
		interfaces.add (iface);
	}

	/**
	 * Returns a list of newly preconditioned interfaces
	 */
	public Vala.Collection<TypeReference> get_implemented_interface_list () {
		return this.interfaces;
	}


	/**
	 * A list of all preconditioned interfaces
	 */
	private Vala.Collection<TypeReference> _full_implemented_interfaces = null;

	/**
	 * Returns a list of all preconditioned interfaces
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

	/**
	 * Returns the name of this interface as it is used in C.
	 */
	public string? get_cname () {
		return cname;
	}

	/**
	 * Returns the C symbol representing the runtime type id for this data type.
	 */
	public string? get_type_id () {
		return type_id;
	}

	/**
	 * Returns the dbus-name.
	 */
	public string? get_dbus_name () {
		return dbus_name;
	}

	/**
	 * Gets the name of the GType macro which returns the interface struct.
	 */
	public string get_interface_macro_name () {
		return interface_macro_name;
	}

	/**
	 * A preconditioned class or null
	 */
	public TypeReference? base_type {
		set;
		get;
	}

	/**
	 * {@inheritDoc}
	 */
	public override NodeType node_type {
		get { return NodeType.INTERFACE; }
	}

	/**
	 * {@inheritDoc}
	 */
	public override void accept (Visitor visitor) {
		visitor.visit_interface (this);
	}

	/**
	 * A list of all known related (sub-)interfaces
	 */
	private Vala.Set<Interface> _known_related_interfaces = new Vala.HashSet<Interface> ();

	/**
	 * A list of all known implementations of this interface
	 */
	private Vala.Set<Class> _known_implementations = new Vala.HashSet<Class> ();

	/**
	 * Returns a list of all known implementations of this interface
	 */
	public Vala.Collection<Class> get_known_implementations () {
		return _known_implementations;
	}

	/**
	 * Returns a list of all known related (sub-)interfaces
	 */
	public Vala.Collection<Interface> get_known_related_interfaces () {
		return _known_related_interfaces;
	}

	public void register_related_interface (Interface iface) {
		_known_related_interfaces.add (iface);
	}

	public void register_implementation (Class cl) {
		_known_implementations.add (cl);
	}

	/**
	 * {@inheritDoc}
	 */
	protected override Inline build_signature () {
		var signature = new SignatureBuilder ();

		signature.append_keyword (accessibility.to_string ());
		signature.append_keyword ("interface");
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

