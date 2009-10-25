/* field.vala
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

public class Valadoc.Api.Field : Member {
	public Field (Vala.Field symbol, Node parent) {
		base (symbol, parent);
		field_type = new TypeReference (symbol.field_type, this);
	}

	public string? get_cname () {
		return ((Vala.Field) symbol).get_cname();
	}

	public TypeReference? field_type { private set; get; }

	public bool is_static {
		get {
			if (this.parent is Namespace) {
				return false;
			}

			return ((Vala.Field) symbol).binding == MemberBinding.STATIC;
		}
	}

	public bool is_volatile {
		get {
			return ((Vala.Field) symbol).is_volatile;
		}
	}

	protected override void resolve_type_references (Tree root) {
		field_type.resolve_type_references (root);

		base.resolve_type_references (root);
	}

	protected override Inline build_signature () {
		var signature = new SignatureBuilder ();

		signature.append_keyword (get_accessibility_modifier ());
		if (is_static) {
			signature.append_keyword ("static");
		}
		if (is_volatile) {
			signature.append_keyword ("volatile");
		}

		signature.append_content (field_type.signature);
		signature.append_symbol (this);
		return signature.get ();
	}

	public override NodeType node_type { get { return NodeType.FIELD; } }

	public override void accept (Visitor visitor) {
		visitor.visit_field (this);
	}
}

