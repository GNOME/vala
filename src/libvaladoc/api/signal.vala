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

public class Valadoc.Api.Signal : Member {
	private Vala.Signal vsignal;

	public Signal (Vala.Signal symbol, Node parent) {
		base (symbol, parent);

		this.vsignal = symbol;

		type_reference = new TypeReference (symbol.return_type, this);
	}

	public string? get_cname () {
		return this.vsignal.get_cname();
	}

	public TypeReference? type_reference {
		protected set;
		get;
	}

	protected override void resolve_type_references (Tree root) {
		type_reference.resolve_type_references (root);

		base.resolve_type_references (root);
	}

	public bool is_virtual {
		get {
			return this.vsignal.is_virtual;
		}
	}

	protected override Inline build_signature () {
		var signature = new SignatureBuilder ();

		signature.append_keyword (get_accessibility_modifier ());
		if (is_virtual) {
			signature.append_keyword ("virtual");
		}

		signature.append_content (type_reference.signature);
		signature.append_symbol (this);
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

		return signature.get ();
	}

	public override NodeType node_type { get { return NodeType.SIGNAL; } }

	public override void accept (Visitor visitor) {
		visitor.visit_signal (this);
	}
}

