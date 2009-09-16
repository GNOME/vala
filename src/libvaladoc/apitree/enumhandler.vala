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


public interface Valadoc.EnumHandler : Basic {
	protected abstract Gee.ArrayList<Enum> enums {
		set;
		get;
	}

	protected void set_enum_type_references ( ) {
		foreach ( Enum en in this.enums ) {
			en.set_type_references ( );
		}
	}

	protected DocumentedElement? search_enum_vala ( Gee.ArrayList<Vala.Symbol> params, int pos ) {
		foreach ( Enum en in this.enums ) {
			DocumentedElement element = en.search_element_vala ( params, pos+1 );
			if ( element != null )
				return element;			
		}
		return null;
	}

	protected DocumentedElement? search_enum ( string[] params, int pos ) {
		foreach ( Enum en in this.enums ) {
			DocumentedElement element = en.search_element ( params, pos+1 );
			if ( element != null )
				return element;
		}
		return null;
	}

	public Gee.Collection<Enum> get_enum_list ( ) {
		var lst = new Gee.ArrayList<Enum> ();
		foreach ( Enum en in this.enums ) {
			if ( !en.is_type_visitor_accessible ( this ) )
				continue ;

			lst.add ( en );
		}

		return new Gee.ReadOnlyCollection<Enum>( lst );
	}

	public void visit_enums ( Doclet doclet ) {
		foreach ( Enum en in this.enums ) {
			en.visit( doclet );
		}
	}

	public void add_enums ( Gee.Collection<Vala.Enum> venums ) {
		foreach ( Vala.Enum venum in venums ) {
			this.add_enum ( venum );
		}
	}

	public void add_enum ( Vala.Enum venum ) {
		Enum tmp = new Enum ( this.settings, venum, this, this.head );
		this.enums.add( tmp );
	}

	protected void parse_enum_comments ( Valadoc.Parser docparser ) {
		foreach ( Enum en in this.enums ) {
			en.parse_comments ( docparser );
		}
	}
}

