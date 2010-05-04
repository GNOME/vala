/* errorcode.vala
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

public class Valadoc.Api.ErrorCode : TypeSymbol {
	public ErrorCode (Vala.ErrorCode symbol, Node parent) {
		base (symbol, parent);
	}

	public override bool is_public {
		get {
			return ((ErrorDomain)parent).is_public;
		}
	}

	public override bool is_protected {
		get {
			return ((ErrorDomain)parent).is_protected;
		}
	}

	public override bool is_internal {
		get {
			return ((ErrorDomain)parent).is_internal;
		}
	}

	public override bool is_private {
		get {
			return ((ErrorDomain)parent).is_private;
		}
	}

	public string get_cname () {
		return ((Vala.ErrorCode) symbol).get_cname ();
	}

	public string get_dbus_name () {
		return Vala.DBusModule.get_dbus_name_for_member (symbol);
	}

	public override NodeType node_type { get { return NodeType.ERROR_CODE; } }

	public override void accept (Visitor visitor) {
		visitor.visit_error_code (this);
	}

	protected override Inline build_signature () {
		return new SignatureBuilder ()
			.append_symbol (this)
			.get ();
	}
}

