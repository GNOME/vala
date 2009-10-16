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

public class Valadoc.Api.Constant : MemberNode, ReturnTypeHandler {
	private Vala.Constant vconst;

	public TypeReference? type_reference {
		protected set;
		get;
	}

	public bool is_vconstant (Vala.Constant vconst) {
		return (this.vconst == vconst);
	}

	public Constant (Vala.Constant symbol, Node parent) {
		base (symbol, parent);
		this.vconst = symbol;

		var vret = this.vconst.type_reference;
		this.set_ret_type (vret);
	}

	public string get_cname () {
		return this.vconst.get_cname ();
	}

	protected override void resolve_type_references (Tree root) {
		this.set_return_type_references (root);
	}

	protected override Inline build_signature () {
		return new SignatureBuilder ()
			.append_keyword (get_accessibility_modifier ())
			.append_keyword ("const")
			.append_content (type_reference.signature)
			.append_symbol (this)
			.get ();
	}

	public void visit (Doclet doclet, ConstantHandler? parent) {
		doclet.visit_constant (this, parent);
	}

	public override NodeType node_type { get { return NodeType.CONSTANT; } }

	public override void accept (Doclet doclet) {
		visit (doclet, (ConstantHandler)parent);
	}
}
