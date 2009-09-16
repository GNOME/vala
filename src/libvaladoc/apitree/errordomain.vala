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


public class Valadoc.ErrorDomain : DocumentedElement, SymbolAccessibility, Visitable, MethodHandler {
	private Gee.ArrayList<ErrorCode> errcodes = new Gee.ArrayList<ErrorCode> ();
	private Vala.ErrorDomain verrdom;

	public ErrorDomain ( Valadoc.Settings settings, Vala.ErrorDomain verrdom, ErrorDomainHandler parent, Tree head ) {
		this.vcomment = verrdom.comment;
		this.settings = settings;
		this.vsymbol = verrdom;
		this.verrdom = verrdom;
		this.parent = parent;
		this.head = head;

		Gee.Collection<Vala.Method> vmethods = this.verrdom.get_methods ();
		this.methods = new Gee.ArrayList<Method> ();
		this.add_methods ( vmethods );

		Gee.Collection<Vala.ErrorCode> verrcodes = this.verrdom.get_codes ();
		this.append_error_code ( verrcodes );
	}

	public string? get_cname () {
		return this.verrdom.get_cname();
	}

	protected Gee.ArrayList<Method> methods {
		protected set;
		get;
	}

	internal bool is_verrordomain ( Vala.ErrorDomain ver ) {
		return ( this.verrdom == ver );
	}

	private DocumentedElement? search_error_code ( string[] params, int pos ) {
		pos++;

		if ( params[pos+1] != null )
			return null;

		foreach ( ErrorCode errcode in this.errcodes ) {
			if ( errcode.name == params[pos] )
				return errcode;
		}
		return null;
	}

	private DocumentedElement? search_error_code_vala ( Gee.ArrayList<Vala.Symbol> params, int pos ) {
		Vala.Symbol velement = params[pos+1];
		if ( velement is Vala.ErrorCode == false )
			return null;

		if ( params.size != pos+2 )
			return null;

		foreach ( ErrorCode errc in this.errcodes ) {
			if ( errc.is_verrorcode ( (Vala.ErrorCode)velement ) ) {
				return errc;
			}
		}
		return null;
	}

	internal override DocumentedElement? search_element_vala ( Gee.ArrayList<Vala.Symbol> params, int pos ) {
		Vala.Symbol velement = params[pos];

		if ( velement is Vala.ErrorDomain == false )
			return null;

		if ( !this.is_verrordomain ( (Vala.ErrorDomain)velement ) )
			return null;

		if ( params.size == pos+1 )
			return this;

		velement = params[pos+1];

		DocumentedElement? element = null;

		if ( velement is Vala.ErrorCode ) {
			element = this.search_error_code_vala ( params, pos );
		}
		else if ( velement is Vala.Method ) {
			element = this.search_method_vala ( params, pos );
		}
		return element;
	}

	internal override DocumentedElement? search_element ( string[] params, int pos ) {
		if ( this.name != params[pos] )
			return null;

		if ( params[pos+1] == null )
			return this;

		DocumentedElement? element = this.search_method ( params, pos );
		if ( element != null )
			return element;

		element = this.search_error_code ( params, pos );
		if ( element != null )
			return element;

		return null;
	}

	internal void parse_comments ( Valadoc.Parser docparser ) {
		this.parse_comment_helper ( docparser );
		this.parse_method_comments ( docparser );

		foreach ( ErrorCode errcode in this.errcodes ) {
			errcode.parse_comment ( docparser );
		}
	}

	public void visit_error_codes ( Doclet doclet ) {
		foreach ( ErrorCode errcode in this.errcodes )
			errcode.visit ( doclet );
	}

	public Gee.ReadOnlyCollection<ErrorCode> get_error_code_list ( ) {
		return new Gee.ReadOnlyCollection<ErrorCode> ( this.errcodes );
	}

	public void visit ( Doclet doclet ) {
		if ( !this.is_visitor_accessible ( ) )
			return ;

		doclet.visit_error_domain ( this );
	}

	public void write ( Langlet langlet, void* ptr ) {
		langlet.write_error_domain ( this, ptr );
	}

	private inline void append_error_code ( Gee.Collection<Vala.ErrorCode> verrcodes ) {
		foreach ( Vala.ErrorCode verrcode in verrcodes ) {
			var tmp = new ErrorCode ( this.settings, verrcode, this, this.head );
			this.errcodes.add ( tmp );
		}
	}

	internal void set_type_references ( ) {
		this.set_method_type_references ( );
	}
}

