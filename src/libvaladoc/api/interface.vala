/* interface.vala
 *
 * Copyright (C) 2008  Florian Brosch
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

using Gee;
using Valadoc.Content;

public class Valadoc.Api.Interface : TypeSymbol {
	public Interface (Vala.Interface symbol, Node parent) {
		base (symbol, parent);
	}

	private ArrayList<TypeReference> interfaces = new ArrayList<TypeReference> ();

	public Collection<TypeReference> get_implemented_interface_list () {
		return this.interfaces;
	}


	private Collection<TypeReference> _full_implemented_interfaces = null;

	public Collection<TypeReference> get_all_implemented_interface_list () {
		if (_full_implemented_interfaces == null) {
			_full_implemented_interfaces = new HashSet<TypeReference> ();
			_full_implemented_interfaces.add_all (this.interfaces);

			if (base_type != null) {
				_full_implemented_interfaces.add_all (((Class) base_type.data_type).get_full_implemented_interface_list ());
			}
		}

		return _full_implemented_interfaces;
	}

	public string? get_cname () {
		return ((Vala.Interface) symbol).get_cname ();
	}

	public string? get_dbus_name () {
		return Vala.DBusModule.get_dbus_name ((Vala.TypeSymbol) symbol);
	}

	public TypeReference? base_type { private set; get; }

	public override NodeType node_type { get { return NodeType.INTERFACE; } }

	public override void accept (Visitor visitor) {
		visitor.visit_interface (this);
	}

	private void set_prerequisites (Tree root, Vala.Collection<Vala.DataType> lst) {
		if (this.interfaces.size != 0) {
			return;
		}

		foreach (Vala.DataType vtyperef in lst) {
			var inherited = new TypeReference (vtyperef, this);
			inherited.resolve_type_references (root);

			if (inherited.data_type is Class) {
				this.base_type = inherited;
			} else {
				this.interfaces.add (inherited);
			}
		}
	}

	private Set<Interface> _known_related_interfaces = new TreeSet<Interface> ();
	private Set<Class> _known_implementations = new TreeSet<Class> ();

	public Collection<Class> get_known_implementations () {
		return _known_implementations;
	}

	public Collection<Interface> get_known_related_interfaces () {
		return _known_related_interfaces;
	}

	internal void register_related_interface (Interface iface) {
		_known_related_interfaces.add (iface);
	}

	internal void register_implementation (Class cl) {
		_known_implementations.add (cl);
	}

	internal override void resolve_children (Tree root) {
		if (base_type != null) {
			((Class) this.base_type.data_type).register_derived_interface (this);
		}

		foreach (var iface in get_all_implemented_interface_list ()) {
			((Interface) iface.data_type).register_related_interface (this);
		}

		base.resolve_children (root);
	}

	internal override void resolve_type_references (Tree root) {
		var prerequisites = ((Vala.Interface) symbol).get_prerequisites ();
		this.set_prerequisites (root, prerequisites);

		base.resolve_type_references (root);
	}

	protected override Inline build_signature () {
		var signature = new SignatureBuilder ();

		signature.append_keyword (get_accessibility_modifier ());
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

