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


public interface Valadoc.ErrorDomainHandler : Basic {
	protected abstract Gee.ArrayList<ErrorDomain> errdoms {
		set;
		get;
	}

	protected DocumentedElement? search_error_domain_vala ( Gee.ArrayList<Vala.Symbol> params, int pos ) {
		foreach ( ErrorDomain errdom in this.errdoms ) {
			DocumentedElement? element = errdom.search_element_vala ( params, pos+1 );
			if ( element != null )
				return element;
		}
		return null;
	}

	protected DocumentedElement? search_error_domain ( string[] params, int pos ) {
		foreach ( ErrorDomain errdom in this.errdoms ) {
			DocumentedElement? element = errdom.search_element ( params, pos+1 );
			if ( element != null )
				return element;
		}
		return null;
	}

	public Gee.Collection<ErrorDomain> get_error_domain_list ( ) {
		var lst = new Gee.ArrayList<ErrorDomain> ();
		foreach ( ErrorDomain errdom in this.errdoms ) {
			if ( !errdom.is_type_visitor_accessible ( this ) )
				continue ;

			lst.add ( errdom );
		}

		return lst.read_only_view;
	}

	internal ErrorDomain? find_errordomain ( Vala.ErrorDomain ver ) {
		foreach ( ErrorDomain errdom in this.errdoms ) {
			if ( errdom.is_verrordomain( ver ) )
				return errdom;
		}
		return null;
	}

	public void visit_error_domains ( Doclet doclet ) {
		foreach ( ErrorDomain errdom in this.errdoms ) {
			errdom.visit ( doclet );
		}
	}

	public void add_error_domains ( Gee.Collection<Vala.ErrorDomain> verrdoms ) {
		foreach ( Vala.ErrorDomain verrdom in  verrdoms ) {
			this.add_error_domain ( verrdom );
		}
	}

	public void add_error_domain ( Vala.ErrorDomain verrdom ) {
		var tmp = new ErrorDomain ( this.settings, verrdom, this, this.head );
		this.errdoms.add ( tmp );
	}

	protected void set_errordomain_type_referenes ( ) {
		foreach ( ErrorDomain errdom in this.errdoms ) {
			errdom.set_type_references ( );
		}
	}

	protected void parse_errordomain_comments ( Valadoc.Parser docparser ) {
		foreach ( ErrorDomain errdom in this.errdoms ) {
			errdom.parse_comments ( docparser );
		}
	}
}

