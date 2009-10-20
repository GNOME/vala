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

public class Valadoc.Api.Field : Member {
	private Vala.Field vfield;

	public Field (Vala.Field symbol, Node parent) {
		base (symbol, parent);
		this.vfield = symbol;

		type_reference = new TypeReference (symbol.field_type, this);
	}

	public string? get_cname () {
		return this.vfield.get_cname();
	}

	public TypeReference? type_reference {
		protected set;
		get;
	}

	public bool is_static {
		get {
			if (this.parent is Namespace) {
				return false;
			}

			return this.vfield.binding == MemberBinding.STATIC;
		}
	}

	public bool is_volatile {
		get {
			return this.vfield.is_volatile;
		}
	}

	protected override void resolve_type_references (Tree root) {
		type_reference.resolve_type_references (root);

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

		signature.append_content (type_reference.signature);
		signature.append_symbol (this);
		return signature.get ();
	}

	public override NodeType node_type { get { return NodeType.FIELD; } }

	public override void accept (Visitor visitor) {
		visitor.visit_field (this);
	}
}

