/* struct.vala
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

public class Valadoc.Api.Struct : TypeSymbol {
	public Struct (Vala.Struct symbol, Node parent) {
		base (symbol, parent);
	}

	public TypeReference? base_type { private set; get; }

	public string? get_cname () {
		return ((Vala.Struct) symbol).get_cname();
	}

	public string? get_dup_function_cname () {
		return ((Vala.Struct) symbol).get_dup_function ();
	}

	public string? get_free_function_cname () {
		return ((Vala.Struct) symbol).get_free_function ();
	}

	public override NodeType node_type { get { return NodeType.STRUCT; } }

	public override void accept (Visitor visitor) {
		visitor.visit_struct (this);
	}

	private void set_parent_references (Tree root) {
		Vala.ValueType? basetype = ((Vala.Struct) symbol).base_type as Vala.ValueType;
		if (basetype == null) {
			return ;
		}
		this.base_type = new TypeReference (basetype, this);
		this.base_type.resolve_type_references (root);
	}

	internal override void resolve_type_references (Tree root) {
		this.set_parent_references (root);

		base.resolve_type_references (root);
	}

	protected override Inline build_signature () {
		var signature = new SignatureBuilder ();

		signature.append_keyword (get_accessibility_modifier ());
		signature.append_keyword ("struct");
		signature.append_symbol (this);

		var type_parameters = get_children_by_type (NodeType.TYPE_PARAMETER, false);
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

		if (base_type != null) {
			signature.append (":");

			signature.append_content (base_type.signature);
		}

		return signature.get ();
	}
}

