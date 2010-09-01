/* method.vala
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

public class Valadoc.Api.Method : Member {
	public Method (Vala.Method symbol, Node parent) {
		base (symbol, parent);
		return_type = new TypeReference (symbol.return_type, this);
	}

	public string? get_cname () {
		return ((Vala.Method) symbol).get_cname ();
	}

	public string? get_finish_function_cname () {
		return ((Vala.Method) symbol).get_finish_cname ();
	}

	public string get_dbus_name () {
		return Vala.DBusModule.get_dbus_name_for_member (symbol);
	}

	public string get_dbus_result_name () {
		return Vala.DBusServerModule.dbus_result_name ((Vala.Method) symbol);
	}

	public Method? base_method { private set; get; }

	public TypeReference? return_type { private set; get; }

	public bool is_yields {
		get {
			return ((Vala.Method) symbol).coroutine;
		}
	}

	public bool is_abstract {
		get {
			return ((Vala.Method) symbol).is_abstract;
		}
	}

	public bool is_virtual {
		get {
			return ((Vala.Method) symbol).is_virtual;
		}
	}

	public bool is_override {
		get {
			return ((Vala.Method) symbol).overrides;
		}
	}

	public bool is_static {
		get {
			if (is_constructor) {
				return false;
			}
			return ((Vala.Method) symbol).binding == MemberBinding.STATIC;
		}
	}

	public bool is_constructor {
		get {
			return symbol is Vala.CreationMethod;
		}
	}

	public bool is_inline {
		get {
			return ((Vala.Method) symbol).is_inline;
		}
	}

	public bool is_dbus_visible {
		get {
			return Vala.DBusServerModule.is_dbus_visible (symbol);
		}
	}

	public override string? name {
		owned get {
			if (this.is_constructor) {
				if (symbol.name == ".new") {
					return ((Node) parent).name;
				} else {
					return ((Node) parent).name + "." + symbol.name;
				}
			}
			else {
				return symbol.name;
			}
		}
	}

	internal override void resolve_type_references (Tree root) {
		Vala.Method vala_method = symbol as Vala.Method;
		Vala.Method? base_vala_method = null;
		if (vala_method.base_method != null) {
			base_vala_method = vala_method.base_method;
		} else if (vala_method.base_interface_method != null) {
			base_vala_method = vala_method.base_interface_method;
		}
		if (base_vala_method == vala_method
		    && vala_method.base_interface_method != null) {
			base_vala_method = vala_method.base_interface_method;
		}
		if (base_vala_method != null) {
			this.base_method = (Method?) root.search_vala_symbol (base_vala_method);
		}

		return_type.resolve_type_references (root);

		base.resolve_type_references (root);
	}

	protected override Inline build_signature () {
		var signature = new SignatureBuilder ();

		signature.append_keyword (get_accessibility_modifier ());

		if (!is_constructor) {
			if (is_static) {
				signature.append_keyword ("static");
			} else if (is_abstract) {
				signature.append_keyword ("abstract");
			} else if (is_override) {
				signature.append_keyword ("override");
			} else if (is_virtual) {
				signature.append_keyword ("virtual");
			}
			if (is_inline) {
				signature.append_keyword ("inline");
			}
			if (is_yields) {
				signature.append_keyword ("async");
			}

			signature.append_content (return_type.signature);
		}

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

		signature.append ("(");

		bool first = true;
		foreach (Node param in get_children_by_type (NodeType.FORMAL_PARAMETER)) {
			if (!first) {
				signature.append (",", false);
			}
			signature.append_content (param.signature, !first);
			first = false;
		}

		signature.append (")", false);

		var exceptions = get_children_by_types ({NodeType.ERROR_DOMAIN, NodeType.CLASS});
		if (exceptions.size > 0) {
			signature.append_keyword ("throws");
			first = true;
			foreach (Node param in exceptions) {
				if (!first) {
					signature.append (",", false);
				}
				signature.append_type (param);
				first = false;
			}
		}

		return signature.get ();
	}

	public override NodeType node_type {
		get {
			return is_constructor ? NodeType.CREATION_METHOD :
			       is_static ? NodeType.STATIC_METHOD : NodeType.METHOD;
		}
	}

	public override void accept (Visitor visitor) {
		visitor.visit_method (this);
	}
}

