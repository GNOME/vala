/*
 * Valadoc.Api.- a documentation tool for vala.
 * Copyright (C) 2008 Florian Brosch
 * 
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public License
 * as published by the Free Software Foundation; either version 2
 * of the License.
 * 
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 * 
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
 */

using Gee;
using Valadoc.Content;

public class Valadoc.Api.ErrorCode : TypeSymbol {
	private Vala.ErrorCode verrcode;

	public ErrorCode (Vala.ErrorCode symbol, Node parent) {
		base (symbol, parent);
		this.verrcode = symbol;
	}

	public string get_cname () {
		return this.verrcode.get_cname ();
	}

	public bool is_verrorcode (Vala.ErrorCode verrcode) {
		return this.verrcode == verrcode;
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
