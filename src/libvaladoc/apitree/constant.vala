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


public class Valadoc.Constant : DocumentedElement, SymbolAccessibility, Visitable, ReturnTypeHandler {
	private Vala.Constant vconst;

	public TypeReference? type_reference {
		protected set;
		get;
	}

	public bool is_vconstant ( Vala.Constant vconst ) {
		return ( this.vconst == vconst );
	}

	public Constant ( Valadoc.Settings settings, Vala.Constant vconst, ConstantHandler parent, Tree head ) {
		this.vcomment = vconst.comment;
		this.settings = settings;
		this.vsymbol = vconst;
		this.vconst = vconst;
		this.parent = parent;
		this.head = head;

		var vret = this.vconst.type_reference;
		this.set_ret_type ( vret );
	}

	public string get_cname () {
		return this.vconst.get_cname ();
	}

	internal void set_type_references ( ) {
		((ReturnTypeHandler)this).set_return_type_references ( );
	}

	internal void parse_comment ( Valadoc.Parser docparser ) {
		this.parse_comment_helper ( docparser );
	}

	public void visit ( Doclet doclet, ConstantHandler? parent ) {
		if ( !this.is_visitor_accessible ( ) )
			return ;

		doclet.visit_constant ( this, parent );
	}

	public void write ( Langlet langlet, void* ptr, ConstantHandler parent ) {
		langlet.write_constant ( this, parent, ptr );
	}
}

