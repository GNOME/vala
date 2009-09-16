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


public class Valadoc.Delegate : DocumentedElement, SymbolAccessibility, Visitable, ParameterListHandler, ReturnTypeHandler, TemplateParameterListHandler, ExceptionHandler {
	private Vala.Delegate vdelegate;

	public Delegate ( Valadoc.Settings settings, Vala.Delegate vdelegate, DelegateHandler parent, Tree head ) {
		this.template_param_lst = new Gee.ArrayList<TypeParameter> ();
		this.param_list = new Gee.ArrayList<FormalParameter>();
		this.err_domains = new Gee.ArrayList<DocumentedElement>();

		this.vcomment = vdelegate.comment;
		this.settings = settings;
		this.vdelegate = vdelegate;
		this.vsymbol = vdelegate;
		this.parent = parent;
		this.head = head;

		var ret = this.vdelegate.return_type;
		this.set_ret_type ( ret );

		var vparamlst = this.vdelegate.get_parameters ();
		this.add_parameter_list ( vparamlst );
	}

	public string? get_cname () {
		return this.vdelegate.get_cname();
	}

	public TypeReference? type_reference {
		protected set;
		get;
	}

	public void visit ( Doclet doclet ) {
		if ( !this.is_visitor_accessible ( ) )
			return ;

		doclet.visit_delegate ( this );
	}

	public Gee.ArrayList<TypeParameter> template_param_lst {
		protected set;
		get;
	}

	protected Gee.ArrayList<FormalParameter> param_list {
		protected set;
		get;
	}

	protected Gee.ArrayList<DocumentedElement> err_domains {
		protected set;
		get;
	}

	public bool is_static {
		get {
			return this.vdelegate.has_target;
		}
	}

	internal void set_type_references ( ) {
		this.set_return_type_references ( );
		this.set_parameter_list_type_references ( );

		var vexceptionlst = this.vdelegate.get_error_types ();
		this.add_exception_list ( vexceptionlst );
	}

	internal void parse_comment ( DocumentationParser docparser ) {
		this.parse_comment_helper ( docparser );
	}

	internal bool is_vdelegate (Vala.Delegate vdel) {
		return (this.vdelegate == vdel);
	}

	public void write (Langlet langlet, void* ptr) {
		langlet.write_delegate (this, ptr);
	}
}

