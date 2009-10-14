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


using Vala;
using GLib;
using Gee;


public class Valadoc.Method : Api.MemberNode, ParameterListHandler, ExceptionHandler, TemplateParameterListHandler, ReturnTypeHandler {
	private Vala.Method vmethod;

	public Method (Valadoc.Settings settings, Vala.Method symbol, Api.Node parent, Tree root) {
		base (settings, symbol, parent, root);
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
			if (this.parent is Namespace || this.is_constructor)
				return false;

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
				if (this.vmethod.name == ".new")
					return ((DocumentedElement)this.parent).name;
				else
					return ((DocumentedElement)this.parent).name + "." + this.vmethod.name;
			}
			else {
				return this.vmethod.name;
			}
		}
	}

	protected override void resolve_type_references () {
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
			this.base_method = (Method?) this.head.search_vala_symbol (vm);
		}

		var vexceptionlst = this.vmethod.get_error_types ();
		this.add_exception_list ( vexceptionlst );

		this.set_return_type_references ();

		base.resolve_type_references ( );
	}

	public void visit ( Doclet doclet, Valadoc.MethodHandler in_type ) {
		if ( !this.is_visitor_accessible ( ) )
			return ;

		doclet.visit_method ( this, in_type );
	}

	public override Api.NodeType node_type {
		get {
			return is_constructor ? Api.NodeType.CREATION_METHOD : Api.NodeType.METHOD;
		}
	}

	public override void accept (Doclet doclet) {
		visit (doclet, (MethodHandler) parent);
	}

	public void write ( Langlet langlet, void* ptr, Valadoc.MethodHandler parent ) {
		langlet.write_method ( ptr, this, parent );
	}
}

