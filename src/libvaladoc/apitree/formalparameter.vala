/*
 * Valadoc - a documentation tool for vala.
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

public class Valadoc.FormalParameter : Api.SymbolNode, ReturnTypeHandler {
	private Vala.FormalParameter vformalparam;

	public FormalParameter (Vala.FormalParameter symbol, Api.Node parent) {
		base (symbol, parent);
		this.vformalparam = symbol;

		var vformparam = this.vformalparam.parameter_type;
		this.set_ret_type (vformparam);
	}

	public bool is_out {
		get {
			return this.vformalparam.direction == Vala.ParameterDirection.OUT;
		}
	}

	public bool is_ref {
		get {
			return this.vformalparam.direction == Vala.ParameterDirection.REF;
		}
	}

	public bool has_default_value {
		get {
			return this.vformalparam.default_expression != null;
		}
	}

	public TypeReference? type_reference {
		protected set;
		get;
	}

	public bool ellipsis {
		get {
			return this.vformalparam.ellipsis;
		}
	}

	public override Api.NodeType node_type { get { return Api.NodeType.FORMAL_PARAMETER; } }

	public override void accept (Doclet doclet) {
	}

	protected override void resolve_type_references (Tree root) {
		if (this.vformalparam.ellipsis) {
			return;
		}

		this.set_return_type_references (root);

		base.resolve_type_references (root);
	}

	protected override Inline build_signature () {
		var signature = new Api.SignatureBuilder ();

		if (ellipsis) {
			signature.append ("...");
		} else {
			if (is_out) {
				signature.append_keyword ("out");
			} else if (is_ref) {
				signature.append_keyword ("ref");
			}

			signature.append_content (type_reference.signature);
			signature.append (name);

			if (has_default_value) {
				signature.append ("=");
				signature.append (this.vformalparam.default_expression.to_string ());
			}
		}

		return signature.get ();
	}
}
