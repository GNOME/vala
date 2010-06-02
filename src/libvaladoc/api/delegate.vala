/* delegate.vala
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

public class Valadoc.Api.Delegate : TypeSymbol {
	public Delegate (Vala.Delegate symbol, Node parent) {
		base (symbol, parent);
		return_type = new TypeReference (symbol.return_type, this);
	}

	public string? get_cname () {
		return ((Vala.Delegate) symbol).get_cname ();
	}

	public TypeReference? return_type { private set; get; }

	public override NodeType node_type { get { return NodeType.DELEGATE; } }

	public override void accept (Visitor visitor) {
		visitor.visit_delegate (this);
	}

	public bool is_static {
		get {
			return !((Vala.Delegate) symbol).has_target;
		}
	}

	internal override void resolve_type_references (Tree root) {
		return_type.resolve_type_references (root);

		base.resolve_type_references (root);
	}

	protected override Inline build_signature () {
		var signature = new SignatureBuilder ();

		signature.append_keyword (get_accessibility_modifier ());
		if (is_static) {
			signature.append_keyword ("static");
		}

		signature.append_content (return_type.signature);
		signature.append_symbol (this);

		var type_parameters = get_children_by_type (NodeType.TYPE_PARAMETER);
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

		var exceptions = get_children_by_type (NodeType.ERROR_DOMAIN);
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
}

