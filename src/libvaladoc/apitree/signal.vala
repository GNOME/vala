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


public class Valadoc.Signal : DocumentedElement, ParameterListHandler, SymbolAccessibility, ReturnTypeHandler, Visitable {
	private Vala.Signal vsignal;

	public Signal (Valadoc.Settings settings, Vala.Signal vsignal, SignalHandler parent, Tree head) {
		this.param_list = new Gee.ArrayList<FormalParameter> ();

		this.vcomment = vsignal.comment;
		this.settings = settings;
		this.vsymbol = vsignal;
		this.vsignal = vsignal;
		this.parent = parent;
		this.head = head;

		var vparamlst = this.vsignal.get_parameters ();
		this.add_parameter_list (vparamlst);

		var ret = this.vsignal.return_type;
		this.set_ret_type (ret);
	}

	internal bool is_vsignal (Vala.Signal vsig) {
		return (this.vsignal == vsig);
	}

	public string? get_cname () {
		return this.vsignal.get_cname();
	}

	public TypeReference? type_reference {
		protected set;
		get;
	}

	protected Gee.ArrayList<FormalParameter> param_list {
		protected set;
		get;
	}

	internal void set_type_references ( ) {
		this.set_parameter_list_type_references ( );
		this.set_return_type_references ( );
	}

	internal void parse_comment (DocumentationParser docparser) {
		this.parse_comment_helper (docparser);
	}

	public bool is_virtual {
		get {
			return this.vsignal.is_virtual;
		}
	}

	public void visit (Doclet doclet) {
		if ( !this.is_visitor_accessible () )
			return ;

		doclet.visit_signal (this);
	}

	public void write (Langlet langlet, void* ptr) {
		langlet.write_signal (this, ptr);
	}
}
