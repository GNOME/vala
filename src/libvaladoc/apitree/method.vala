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

public class Valadoc.Method : Api.MemberNode, ParameterListHandler, ExceptionHandler, TemplateParameterListHandler, ReturnTypeHandler {
	private Vala.Method vmethod;

	public Method (Vala.Method symbol, Api.Node parent) {
		base (symbol, parent);
		this.vmethod = symbol;

		var vret = this.vmethod.return_type;
		this.set_ret_type (vret);
	}

	public string? get_cname () {
		return this.vmethod.get_cname ();
	}

	public Method? base_method {
		private set;
		get;
	}

	public TypeReference? type_reference {
		protected set;
		get;
	}

	public bool is_yields {
		get {
			return this.vmethod.coroutine;
		}
	}

	public bool is_abstract {
		get {
			return this.vmethod.is_abstract;
		}
	}

	public bool is_virtual {
		get {
			return this.vmethod.is_virtual;
		}
	}

	public bool is_override {
		get {
			return this.vmethod.overrides;
		}
	}

	public bool is_static {
		get {
			if (this.parent is Namespace || this.is_constructor) {
				return false;
			}
			return this.vmethod.binding == MemberBinding.STATIC;
		}
	}

	public bool is_constructor {
		get {
			return ( this.vmethod is Vala.CreationMethod );
		}
	}

	public bool is_inline {
		get {
			return this.vmethod.is_inline;
		}
	}

	public override string? name {
		owned get {
			if (this.is_constructor) {
				if (this.vmethod.name == ".new") {
					return ((Api.Node)this.parent).name;
				} else {
					return ((Api.Node)this.parent).name + "." + this.vmethod.name;
				}
			}
			else {
				return this.vmethod.name;
			}
		}
	}

	protected override void resolve_type_references (Tree root) {
		Vala.Method? vm = null;
		if (vmethod.base_method != null) {
			vm = vmethod.base_method;
		} else if (vmethod.base_interface_method != null) {
			vm = vmethod.base_interface_method;
		}
		if (vm == vmethod && vmethod.base_interface_method != null) {
			vm = vmethod.base_interface_method;
		}
		if (vm != null) {
			this.base_method = (Method?) root.search_vala_symbol (vm);
		}

		var vexceptionlst = this.vmethod.get_error_types ();
		this.add_exception_list (root, vexceptionlst);

		this.set_return_type_references (root);

		base.resolve_type_references (root);
	}

	protected override Inline build_signature () {
		var signature = new Api.SignatureBuilder ();

		signature.append_keyword (get_accessibility_modifier ());
		if (is_static) {
			signature.append_keyword ("static");
		} else if (is_abstract) {
			signature.append_keyword ("abstract");
		} else if (is_override) {
			signature.append_keyword ("override");
		} else if (is_virtual) {
			signature.append_keyword ("virtual");
		}
		if (is_inline) {
			signature.append_keyword ("inline");
		}
		if (is_yields) {
			signature.append_keyword ("async");
		}

		signature.append_content (type_reference.signature);
		signature.append_symbol (this);

		var type_parameters = get_children_by_type (Api.NodeType.TYPE_PARAMETER, false);
		if (type_parameters.size > 0) {
			signature.append ("<", false);
			bool first = true;
			foreach (Api.Item param in type_parameters) {
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
		foreach (Api.Node param in get_children_by_type (Api.NodeType.FORMAL_PARAMETER)) {
			if (!first) {
				signature.append (",", false);
			}
			signature.append_content (param.signature, !first);
			first = false;
		}

		signature.append (")", false);

		var exceptions = get_children_by_type (Api.NodeType.ERROR_DOMAIN);
		if (exceptions.size > 0) {
			signature.append_keyword ("throws");

			foreach (Api.Node param in exceptions) {
				if (!first) {
					signature.append (",", false);
				}
				signature.append_content (param.signature, !first);
				first = false;
			}
		}

		return signature.get ();
	}

	public void visit (Doclet doclet, Valadoc.MethodHandler in_type) {
		doclet.visit_method (this, in_type);
	}

	public override Api.NodeType node_type {
		get {
			return is_constructor ? Api.NodeType.CREATION_METHOD : Api.NodeType.METHOD;
		}
	}

	public override void accept (Doclet doclet) {
		visit (doclet, (MethodHandler) parent);
	}
}
