/* method.vala
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
 * Represents a function or a method.
 */
public class Valadoc.Api.Method : Symbol, Callable {
	private string? finish_function_cname;
	private string? dbus_result_name;
	private string? dbus_name;
	private string? cname;

	/**
	 * {@inheritDoc}
	 */
	internal string? implicit_array_length_cparameter_name {
		get;
		set;
	}


	public Method (Node parent, SourceFile file, string name, Vala.SymbolAccessibility accessibility,
				   SourceComment? comment, Vala.Method data)
	{
		base (parent, file, name, accessibility, comment, data);

		this.finish_function_cname = (data.coroutine ? Vala.get_ccode_finish_name (data) : null);
		this.dbus_result_name = Vala.GDBusModule.dbus_result_name (data);
		this.dbus_name = Vala.GDBusModule.get_dbus_name_for_member (data);
		this.cname = Vala.get_ccode_name (data);

		this.is_dbus_visible = Vala.GDBusModule.is_dbus_visible (data);
		this.is_constructor = data is Vala.CreationMethod;
		this.is_yields = data.coroutine;
	}

	/**
	 * Returns the name of this method as it is used in C.
	 */
	public string? get_cname () {
		return cname;
	}

	/**
	 * Returns the name of the finish function as it is used in C.
	 */
	public string? get_finish_function_cname () {
		return finish_function_cname;
	}

	/**
	 * Returns the dbus-name.
	 */
	public string get_dbus_name () {
		return dbus_name;
	}

	public string get_dbus_result_name () {
		return dbus_result_name;
	}

	/**
	 * Specifies the virtual or abstract method this method overrides.
	 */
	public weak Method? base_method {
		set;
		get;
	}

	/**
	 * {@inheritDoc}
	 */
	public TypeReference? return_type {
		set;
		get;
	}

	/**
	 * Specifies whether this method is asynchronous
	 */
	public bool is_yields {
		private set;
		get;
	}

	/**
	 * Specifies whether this method is abstract
	 */
	public bool is_abstract {
		get {
			return ((Vala.Method) data).is_abstract;
		}
	}

	/**
	 * Specifies whether this method is virtual
	 */
	public bool is_virtual {
		get {
			return ((Vala.Method) data).is_virtual;
		}
	}

	/**
	 * Specifies whether this method overrides another one
	 */
	public bool is_override {
		get {
			return ((Vala.Method) data).overrides;
		}
	}

	/**
	 * Specifies whether this method is static
	 */
	public bool is_static {
		get {
			return !is_constructor && ((Vala.Method) data).binding == Vala.MemberBinding.STATIC
				&& parent is Namespace == false;
		}
	}

	/**
	 * Specifies whether this method is a class method
	 */
	public bool is_class {
		get {
			return ((Vala.Method) data).binding == Vala.MemberBinding.CLASS;
		}
	}

	/**
	 * Specifies whether this method is a creation method
	 */
	public bool is_constructor {
		private set;
		get;
	}

	/**
	 * Specifies whether this method is inline
	 */
	public bool is_inline {
		get {
			return ((Vala.Method) data).is_inline;
		}
	}

	/**
	 * Specifies whether this method is visible for dbus
	 */
	public bool is_dbus_visible {
		private set;
		get;
	}

	/**
	 * {@inheritDoc}
	 */
	protected override Inline build_signature () {
		var signature = new SignatureBuilder ();

		signature.append_keyword (accessibility.to_string ());

		if (!is_constructor) {
			if (is_static) {
				signature.append_keyword ("static");
			} else if (is_class) {
				signature.append_keyword ("class");
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
		}

		if (is_yields) {
			signature.append_keyword ("async");
		}

		if (!is_constructor) {
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
		foreach (Node param in get_children_by_type (NodeType.FORMAL_PARAMETER, false)) {
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

	/**
	 * {@inheritDoc}
	 */
	public override NodeType node_type {
		get {
			return is_constructor ? NodeType.CREATION_METHOD :
			       is_static ? NodeType.STATIC_METHOD : NodeType.METHOD;
		}
	}

	/**
	 * {@inheritDoc}
	 */
	public override void accept (Visitor visitor) {
		visitor.visit_method (this);
	}
}

