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

public class Valadoc.Api.Delegate : TypeSymbolNode, ParameterListHandler, ReturnTypeHandler, TemplateParameterListHandler, ExceptionHandler {
	private Vala.Delegate vdelegate;

	public Delegate (Vala.Delegate symbol, Node parent) {
		base (symbol, parent);

		this.vdelegate = symbol;

		var ret = this.vdelegate.return_type;
		this.set_ret_type (ret);
	}

	public string? get_cname () {
		return this.vdelegate.get_cname ();
	}

	public TypeReference? type_reference {
		protected set;
		get;
	}

	public void visit (Doclet doclet) {
		doclet.visit_delegate (this);
	}

	public override NodeType node_type { get { return NodeType.DELEGATE; } }

	public override void accept (Doclet doclet) {
		visit (doclet);
	}

	public bool is_static {
		get {
			return this.vdelegate.has_target;
		}
	}

	protected override void resolve_type_references (Tree root) {
		this.set_return_type_references (root);

		var vexceptionlst = this.vdelegate.get_error_types ();
		this.add_exception_list (root, vexceptionlst);

		base.resolve_type_references (root);
	}

	protected override Inline build_signature () {
		var signature = new SignatureBuilder ();

		signature.append_keyword (get_accessibility_modifier ());
		if (is_static) {
			signature.append_keyword ("static");
		}

		signature.append_content (type_reference.signature);
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

			foreach (Node param in exceptions) {
				if (!first) {
					signature.append (",", false);
				}
				signature.append_content (param.signature, !first);
				first = false;
			}
		}

		return signature.get ();
	}
}
