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


public class Valadoc.Field : DocumentedElement, SymbolAccessibility, ReturnTypeHandler, Visitable {
	private Vala.Field vfield;

	public Field ( Valadoc.Settings settings, Vala.Field vfield, FieldHandler parent, Tree head ) {
		this.vcomment = vfield.comment;
		this.settings = settings;
		this.vsymbol = vfield;
		this.vfield = vfield;
		this.parent = parent;
		this.head = head;

		var vret = this.vfield.field_type;
		this.set_ret_type ( vret );
	}

	internal bool is_vfield ( Vala.Field vfield ) {
		return ( this.vfield == vfield );
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
			if ( this.parent is Namespace )
				return false;

			return this.vfield.binding == MemberBinding.STATIC;
		}
	}

	public bool is_volatile {
		get {
			return this.vfield.is_volatile;
		}
	}

	internal void set_type_references ( ) {
		((ReturnTypeHandler)this).set_return_type_references ( );
	}

	internal void parse_comment ( DocumentationParser docparser ) {
		this.parse_comment_helper ( docparser );
	}

	public void visit ( Doclet doclet, FieldHandler? parent ) {
		if ( !this.is_visitor_accessible ( ) )
			return ;

		doclet.visit_field ( this, parent );
	}

	public void write ( Langlet langlet, void* ptr, FieldHandler parent ) {
		langlet.write_field ( this, parent, ptr );
	}
}

