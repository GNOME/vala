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


public interface Valadoc.InterfaceHandler : Basic {
	protected abstract Gee.ArrayList<Interface> interfaces {
		set;
		get;
	}

	protected DocumentedElement? search_interface_vala ( Gee.ArrayList<Vala.Symbol> params, int pos ) {
		foreach ( Interface iface in this.interfaces ) {
			DocumentedElement? element = iface.search_element_vala ( params, pos+1 );
			if ( element != null )
				return element;
		}
		return null;
	}

	protected DocumentedElement? search_interface ( string[] params, int pos ) {
		foreach ( Interface iface in this.interfaces ) {
			DocumentedElement? element = iface.search_element ( params, pos+1 );
			if ( element != null )
				return element;
		}
		return null;
	}

	public Gee.Collection<Interface> get_interface_list ( ) {
		var lst = new Gee.ArrayList<Interface> ();
		foreach ( Interface iface in this.interfaces ) {
			if ( !iface.is_type_visitor_accessible ( this ) )
				continue ;

			lst.add ( iface );
		}

		return new Gee.ReadOnlyCollection<Interface>( lst );
	}

	public void visit_interfaces ( Doclet doclet ) {
		foreach ( Interface iface in this.interfaces ) {
			iface.visit( doclet );
		}
	}

	protected void add_interfaces ( Gee.Collection<Vala.Interface> vifaces ) {
		foreach ( Vala.Interface viface in vifaces ) {
			this.add_interface ( viface );
		}
	}

	internal void add_interface ( Vala.Interface viface ) {
		var tmp = new Interface ( this.settings, viface, this, this.head );
		this.interfaces.add ( tmp );
	}

	protected void set_interface_type_references ( ) {
		foreach ( Interface iface in this.interfaces ) {
			iface.set_type_references ( );
		}
	}

	protected void parse_interface_comments ( Valadoc.Parser docparser ) {
		foreach ( Interface iface in this.interfaces ) {
			iface.parse_comments ( docparser );
		}
	}
}

