/* errordomain.vala
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
 * Represents an error domain declaration.
 */
public class Valadoc.Api.ErrorDomain : TypeSymbol {
	private string? quark_function_name;
	private string? quark_macro_name;
	private string? dbus_name;
	private string? cname;

	public ErrorDomain (Node parent, SourceFile file, string name, SymbolAccessibility accessibility,
						SourceComment? comment, string? cname, string? quark_macro_name,
						string? quark_function_name, string? dbus_name, void* data)
	{
		base (parent, file, name, accessibility, comment, null, null, null, null, false, data);

		this.quark_function_name = quark_function_name;
		this.quark_macro_name = quark_macro_name;
		this.dbus_name = dbus_name;
		this.cname = cname;
	}

	/**
	 * Returns the name of this errordomain as it is used in C.
	 */
	public string? get_cname () {
		return this.cname;
	}

	/**
	 * Returns the dbus-name.
	 */
	public string? get_dbus_name () {
		return dbus_name;
	}

	/**
	 * Gets the name of the quark() function which represents the error domain
	 */
	public string get_quark_function_name () {
		return quark_function_name;
	}

	/**
	 * Gets the name of the quark macro which represents the error domain
	 */
	public string get_quark_macro_name () {
		return quark_macro_name;
	}

	/**
	 * {@inheritDoc}
	 */
	public override NodeType node_type {
		get { return NodeType.ERROR_DOMAIN; }
	}

	/**
	 * {@inheritDoc}
	 */
	public override void accept (Visitor visitor) {
		visitor.visit_error_domain (this);
	}

	/**
	 * {@inheritDoc}
	 */
	protected override Inline build_signature () {
		return new SignatureBuilder ()
			.append_keyword (accessibility.to_string ())
			.append_keyword ("errordomain")
			.append_symbol (this)
			.get ();
	}
}

