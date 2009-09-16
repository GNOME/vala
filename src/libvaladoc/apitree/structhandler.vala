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


public interface Valadoc.StructHandler : Basic {
	protected abstract Gee.ArrayList<Struct> structs {
		set;
		get;
	} 

	protected DocumentedElement? search_struct_vala ( Gee.ArrayList<Vala.Symbol> params, int pos ) {
		foreach ( Struct stru in this.structs ) {
			DocumentedElement? element = stru.search_element_vala ( params, pos+1 );
			if ( element != null )
				return element;
		}
		return null;
	}


	protected DocumentedElement? search_struct ( string[] params, int pos ) {
		foreach ( Struct stru in this.structs ) {
			DocumentedElement? element = stru.search_element ( params, pos+1 );
			if ( element != null )
				return element;
		}
		return null;
	}

	public Gee.Collection<Struct> get_struct_list ( ) {
		var lst = new Gee.ArrayList<Struct> ();
		foreach ( Struct stru in this.structs ) {
			if ( !stru.is_type_visitor_accessible ( this ) )
				continue ;

			lst.add ( stru );
		}

		return new Gee.ReadOnlyCollection<Struct>( lst );
	}

	public void add_struct ( Vala.Struct vstru ) {
		Struct stru = new Struct ( this.settings, vstru, this, this.head );
		this.structs.add( stru );
	}

	public void add_structs ( Gee.Collection<Vala.Struct> vstructs ) {
		foreach ( Vala.Struct vstru in vstructs ) {
			this.add_struct ( vstru );
		}
	}

	public void visit_structs ( Doclet doclet ) {
		foreach ( Struct stru in this.get_struct_list() ) {
			stru.visit ( doclet );
		}
	}

	protected void set_struct_type_references ( ) {
		foreach ( Struct stru in this.structs ) {
			stru.set_type_references ( );
		}
	}

	protected void parse_struct_comments ( Valadoc.Parser docparser ) {
		foreach ( Struct stru in this.structs ) {
			stru.parse_comments ( docparser );
		}
	}
}

