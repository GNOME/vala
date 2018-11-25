/* signal.vala
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
 * Represents an signal.
 */
public class Valadoc.Api.Signal : Symbol, Callable {
	private string? default_impl_cname;
	private string? dbus_name;
	private string? cname;


	/**
	 * {@inheritDoc}
	 */
	internal string? implicit_array_length_cparameter_name {
		get;
		set;
	}


	public Signal (Node parent, SourceFile file, string name, Vala.SymbolAccessibility accessibility,
				   SourceComment? comment,
				   Vala.Signal data)
	{
		base (parent, file, name, accessibility, comment, data);

		this.default_impl_cname = (data.default_handler != null ? Vala.get_ccode_name (data.default_handler) : null);
		this.dbus_name = Vala.GDBusModule.get_dbus_name_for_member (data);
		this.cname = Vala.get_ccode_name (data);

		this.is_dbus_visible = Vala.GDBusModule.is_dbus_visible (data);
		this.is_virtual = data.is_virtual;
	}

	/**
	 * Returns the name of this signal as it is used in C.
	 */
	public string? get_cname () {
		return cname;
	}

	public string? get_default_impl_cname () {
		return default_impl_cname;
	}

	/**
	 * Returns the dbus-name.
	 */
	public string get_dbus_name () {
		return dbus_name;
	}

	/**
	 * {@inheritDoc}
	 */
	public TypeReference? return_type {
		set;
		get;
	}

	/**
	 * Specifies whether this signal is virtual
	 */
	public bool is_virtual {
		private set;
		get;
	}

	/**
	 * Specifies whether this signal is visible for dbus
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
		if (is_virtual) {
			signature.append_keyword ("virtual");
		}

		signature.append_keyword ("signal");

		signature.append_content (return_type.signature);
		signature.append_symbol (this);
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

		return signature.get ();
	}

	/**
	 * {@inheritDoc}
	 */
	public override NodeType node_type {
		get { return NodeType.SIGNAL; }
	}

	/**
	 * {@inheritDoc}
	 */
	public override void accept (Visitor visitor) {
		visitor.visit_signal (this);
	}
}

