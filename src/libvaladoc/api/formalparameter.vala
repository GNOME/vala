/* formalparameter.vala
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

public class Valadoc.Api.FormalParameter : Symbol {
	public FormalParameter (Vala.FormalParameter symbol, Node parent) {
		base (symbol, parent);
		parameter_type = new TypeReference (symbol.variable_type, this);
	}

	public bool is_out {
		get {
			return ((Vala.FormalParameter) symbol).direction == Vala.ParameterDirection.OUT;
		}
	}

	public bool is_ref {
		get {
			return ((Vala.FormalParameter) symbol).direction == Vala.ParameterDirection.REF;
		}
	}

	public bool has_default_value {
		get {
			return ((Vala.FormalParameter) symbol).initializer != null; //
		}
	}

	public TypeReference? parameter_type { private set; get; }

	public bool ellipsis {
		get {
			return ((Vala.FormalParameter) symbol).ellipsis;
		}
	}

	public override NodeType node_type { get { return NodeType.FORMAL_PARAMETER; } }

	public override void accept (Visitor visitor) {
		visitor.visit_formal_parameter (this);
	}

	internal override void resolve_type_references (Tree root) {
		if (ellipsis) {
			return;
		}

		parameter_type.resolve_type_references (root);

		base.resolve_type_references (root);
	}

	protected override Inline build_signature () {
		var signature = new SignatureBuilder ();

		if (ellipsis) {
			signature.append ("...");
		} else {
			if (is_out) {
				signature.append_keyword ("out");
			} else if (is_ref) {
				signature.append_keyword ("ref");
			}

			signature.append_content (parameter_type.signature);
			signature.append (name);

			if (has_default_value) {
				signature.append ("=");
				signature.append (((Vala.FormalParameter) symbol).initializer.to_string ());
			}
		}

		return signature.get ();
	}
}

