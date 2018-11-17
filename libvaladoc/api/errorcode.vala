/* errorcode.vala
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
 * Represents an errordomain member in the source code.
 */
public class Valadoc.Api.ErrorCode : Symbol {
	private string? dbus_name;
	private string? cname;

	public ErrorCode (ErrorDomain parent, SourceFile file, string name, SourceComment? comment,
					  Vala.ErrorCode data)
	{
		base (parent, file, name, parent.accessibility, comment, data);

		this.dbus_name = Vala.GDBusModule.get_dbus_name_for_member (data);
		this.cname = Vala.get_ccode_name (data);
	}

	/**
	 * Returns the name of this class as it is used in C.
	 */
	public string get_cname () {
		return cname;
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
	public override NodeType node_type {
		get { return NodeType.ERROR_CODE; }
	}

	/**
	 * {@inheritDoc}
	 */
	public override void accept (Visitor visitor) {
		visitor.visit_error_code (this);
	}

	/**
	 * {@inheritDoc}
	 */
	protected override Inline build_signature () {
		return new SignatureBuilder ()
			.append_symbol (this)
			.get ();
	}
}

