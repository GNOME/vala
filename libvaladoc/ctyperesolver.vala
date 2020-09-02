/* ctyperesolver.vala
 *
 * Copyright (C) 2010 Florian Brosch
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


using Valadoc.Api;

/**
 * Resolves symbols by C-names
 */
public class Valadoc.CTypeResolver : Visitor {
	private Vala.Map<string, Api.TypeSymbol> types = new Vala.HashMap<string, Api.TypeSymbol> (str_hash, str_equal);
	private Vala.Map<string, Api.Node> nodes = new Vala.HashMap<string, Api.Node> (str_hash, str_equal);
	private Api.Tree tree;

	public CTypeResolver (Api.Tree tree) {
		tree.accept (this);
		this.tree = tree;
	}

	private string convert_array_to_camelcase (string[] elements) {
		StringBuilder builder = new StringBuilder ();

		foreach (string element in elements) {
			builder.append_c (((char[])element)[0].toupper ());
			builder.append (element.next_char ().ascii_down ());
		}

		return (owned) builder.str;
	}

	private bool is_capitalized_and_underscored (string name) {
		unowned string pos;

		unichar c = name.get_char ();


		if (c < 'A' || c > 'Z') {
			return false;
		}

		bool last_was_underscore = false;
		for (c = (pos = name).get_char (); c != '\0' ; c = (pos = pos.next_char ()).get_char ()) {
			if ((c != '_'  && !(c >= 'A' && c <= 'Z')) || (last_was_underscore && c == '_')) {
				return false;
			}

			last_was_underscore = (c == '_');
		}

		return !last_was_underscore;
	}

	private string? translate_cname_to_g (string name) {
		if (is_capitalized_and_underscored (name)) {
			string[] segments = name.split ("_");
			unowned string last_segment = segments[segments.length - 1];
			if (last_segment != "ERROR") {
				return null;
			}

			return convert_array_to_camelcase (segments);
		}

		int length = name.length;
		if (length > 5 && name.has_suffix ("Iface")) {
			return name.substring (0, length - 5);
		} else if (length > 5 && name.has_suffix ("Class")) {
			return name.substring (0, length - 5);
		}

		return null;
	}

	public Api.TypeSymbol? resolve_symbol_type (string name) {
		TypeSymbol? symbol = types.get (name);
		if (symbol != null) {
			return symbol;
		}

		if (is_capitalized_and_underscored (name)) {
			string[] segments = name.split ("_");

			if (segments[segments.length - 1] == "TYPE") {
				segments.resize (segments.length - 1);
				return types.get (convert_array_to_camelcase (segments));
			} else if (segments.length > 2 && segments[1] == "TYPE") {
				string[] _segments = segments[1:segments.length];
				_segments[0] = segments[0];
				return types.get (convert_array_to_camelcase (_segments));
			}
		}

		return null;
	}

	/**
	 * Resolves symbols by C-names
	 *
	 * @param _name a C-name
	 * @return the resolved node or null
	 */
	public Api.Node? resolve_symbol (Api.Node? element, string _name) {
		string name = _name.replace ("->", ".").replace ("-", "_");

		if (element != null && name.has_prefix (":")) {
			Item parent = element;
			while (parent != null && !(parent is Class || parent is Interface)) {
				parent = parent.parent;
			}

			if (parent is Class && ((Class) parent).get_cname () != null) {
				name = ((Class) parent).get_cname () + name;
			} else if (parent is Interface && ((Interface) parent).get_cname () != null) {
				name = ((Interface) parent).get_cname () + name;
			} else {
				return null;
			}

		}

		Api.Node? node = nodes.get (name);
		if (node != null) {
			return node;
		}

		string? alternative = translate_cname_to_g (name);
		if (alternative != null) {
			return nodes.get (alternative);
		}

		if (element != null && name.has_prefix (":")) {
			if (element is Class && ((Class) element).get_cname () != null) {
				return nodes.get (((Class) element).get_cname () + "." + name);
			} else if (element is Struct && ((Struct) element).get_cname () != null) {
				return nodes.get (((Struct) element).get_cname () + "." + name);
			}
		}

		if (name == "dgettext") {
			return nodes.get ("g_dgettext");
		} else if (name == "printf") {
			return this.tree.search_symbol_str (null, "GLib.FileStream.printf");
		}

		int dotpos = name.index_of_char ('.');
		if (dotpos > 0) {
			string fst = name.substring (0, dotpos);
			string snd = name.substring (dotpos + 1);
			return nodes.get (fst + ":" + snd);
		}

		return null;
	}

	private void register_symbol_type (string? name, Api.TypeSymbol symbol) {
		if (name != null) {
			types.set (name, symbol);
		}
	}

	private void register_symbol (string? name, Api.Node node) {
		if (name != null) {
			nodes.set (name.replace ("-", "_"), node);
		}
	}

	private string? get_parent_type_cname (Item item) {
		string parent_cname = null;
		if (item.parent is Class) {
			parent_cname = ((Class) item.parent).get_cname ();
		} else if (item.parent is Interface) {
			parent_cname = ((Interface) item.parent).get_cname ();
		} else if (item.parent is Struct) {
			parent_cname = ((Struct) item.parent).get_cname ();
		} else if (item.parent is ErrorDomain) {
			parent_cname = ((ErrorDomain) item.parent).get_cname ();
		} else if (item.parent is Api.Enum) {
			parent_cname = ((Api.Enum) item.parent).get_cname ();
		} else {
			assert (true);
		}
		return parent_cname;
	}

	/**
	 * {@inheritDoc}
	 */
	public override void visit_tree (Api.Tree item) {
		item.accept_children (this);
	}

	/**
	 * {@inheritDoc}
	 */
	public override void visit_package (Package item) {
		item.accept_all_children (this, false);
	}

	/**
	 * {@inheritDoc}
	 */
	public override void visit_namespace (Namespace item) {
		item.accept_all_children (this, false);
	}

	/**
	 * {@inheritDoc}
	 */
	public override void visit_interface (Interface item) {
		register_symbol_type (item.get_type_id (), item);
		register_symbol (item.get_cname (), item);
		item.accept_all_children (this, false);
	}

	/**
	 * {@inheritDoc}
	 */
	public override void visit_class (Class item) {
		register_symbol_type (item.get_type_id (), item);
		register_symbol (item.get_cname (), item);
		item.accept_all_children (this, false);
	}

	/**
	 * {@inheritDoc}
	 */
	public override void visit_struct (Struct item) {
		register_symbol_type (item.get_type_id (), item);
		register_symbol (item.get_cname (), item);
		item.accept_all_children (this, false);
	}

	/**
	 * {@inheritDoc}
	 */
	public override void visit_property (Property item) {
		string parent_cname = get_parent_type_cname (item);
		assert (parent_cname != null);

		string cname = item.get_cname ();
		register_symbol (parent_cname+":"+cname, item);


		Vala.Collection<Interface> interfaces;
		Vala.Collection<Class> classes;

		if (item.parent is Interface) {
			interfaces = ((Api.Interface) item.parent).get_known_related_interfaces ();
			classes = ((Api.Interface) item.parent).get_known_implementations ();
		} else if (item.parent is Class) {
			interfaces = ((Api.Class) item.parent).get_known_derived_interfaces ();
			classes = ((Api.Class) item.parent).get_known_child_classes ();
		} else if (item.parent is Struct) {
			// Properties are allowed here, similar to compact classes
			return;
		} else {
			assert_not_reached ();
		}

		foreach (Interface iface in interfaces) {
			register_symbol (iface.get_cname () + ":" + cname, item);
		}

		foreach (Class cl in classes) {
			register_symbol (cl.get_cname () + ":" + cname, item);
		}
	}

	/**
	 * {@inheritDoc}
	 */
	public override void visit_field (Field item) {
		if (item.parent is Namespace || item.is_static) {
			register_symbol (item.get_cname (), item);
		} else {
			string parent_cname = get_parent_type_cname (item);
			if (parent_cname != null) {
				register_symbol (parent_cname + "." + item.get_cname (), item);
			}
		}
	}

	/**
	 * {@inheritDoc}
	 */
	public override void visit_constant (Constant item) {
		register_symbol (item.get_cname (), item);
	}

	/**
	 * {@inheritDoc}
	 */
	public override void visit_delegate (Delegate item) {
		register_symbol (item.get_cname (), item);
	}

	/**
	 * {@inheritDoc}
	 */
	public override void visit_signal (Api.Signal item) {
		string parent_cname = get_parent_type_cname (item);
		assert (parent_cname != null);

		string? default_impl_cname = item.get_default_impl_cname ();
		string cname = item.get_cname ();
		register_symbol (parent_cname+"::"+cname, item);

		if (item.is_virtual) {
			// only supported by classes
			register_symbol (parent_cname + "Class." + item.name, item);
		}

		Vala.Collection<Interface> interfaces = null;
		Vala.Collection<Class> classes = null;

		if (item.parent is Interface) {
			interfaces = ((Api.Interface) item.parent).get_known_related_interfaces ();
			classes = ((Api.Interface) item.parent).get_known_implementations ();
		} else if (item.parent is Class) {
			interfaces = ((Api.Class) item.parent).get_known_derived_interfaces ();
			classes = ((Api.Class) item.parent).get_known_child_classes ();
		}

		foreach (Interface iface in interfaces) {
			register_symbol (iface.get_cname () + "::" + cname, item);
		}

		foreach (Class cl in classes) {
			register_symbol (cl.get_cname () + "::" + cname, item);
		}

		if (default_impl_cname != null) {
			register_symbol (default_impl_cname, item);
		}
	}

	/**
	 * {@inheritDoc}
	 */
	public override void visit_method (Method item) {
		if (item.is_abstract || item.is_virtual || item.is_override) {
			string parent_cname = get_parent_type_cname (item);

			if (item.parent is Class) {
				register_symbol (parent_cname + "Class." + item.name, item);
			} else {
				register_symbol (parent_cname + "Iface." + item.name, item);
			}

			// Allow to resolve invalid links:
			register_symbol (parent_cname + "." + item.name, item);
		}

		register_symbol (item.get_cname (), item);
	}

	/**
	 * {@inheritDoc}
	 */
	public override void visit_error_domain (ErrorDomain item) {
		register_symbol (item.get_cname (), item);
		item.accept_all_children (this, false);
	}

	/**
	 * {@inheritDoc}
	 */
	public override void visit_error_code (ErrorCode item) {
		register_symbol (item.get_cname (), item);
	}

	/**
	 * {@inheritDoc}
	 */
	public override void visit_enum (Api.Enum item) {
		register_symbol_type (item.get_type_id (), item);
		register_symbol (item.get_cname (), item);
		item.accept_all_children (this, false);
	}

	/**
	 * {@inheritDoc}
	 */
	public override void visit_enum_value (Api.EnumValue item) {
		register_symbol (item.get_cname (), item);
	}
}


