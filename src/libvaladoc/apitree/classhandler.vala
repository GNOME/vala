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


public interface Valadoc.ClassHandler : Basic {
	protected abstract Gee.ArrayList<Class> classes {
		set;
		get;
	}

	protected DocumentedElement? search_class_vala ( Gee.ArrayList<Vala.Symbol> params, int pos ) {
		foreach ( Class cl in this.classes ) {
			DocumentedElement? element = cl.search_element_vala ( params, pos+1 );
			if ( element != null )
				return element;			
		}
		return null;
	}

	protected DocumentedElement? search_class ( string[] params, int pos ) {
		foreach ( Class cl in this.classes ) {
			DocumentedElement? element = cl.search_element ( params, pos+1 );
			if ( element != null )
				return element;
		}
		return null;
	}

	protected Class? find_vclass ( Vala.Class vcl ) {
		foreach ( Class cl in this.classes ) {
			if ( cl.is_vclass ( vcl ) )
				return cl;

			var tmp = cl.find_vclass ( vcl );
			if ( tmp != null )
				return tmp;
		}
		return null;
	}

	public Gee.Collection<Class> get_class_list ( ) {
		var lst = new Gee.ArrayList<Class> ();
		foreach ( Class cl in this.classes ) {
			if ( !cl.is_type_visitor_accessible ( this ) )
				continue ;

			lst.add ( cl );
		}

		return lst.read_only_view;
	}

	internal void add_class ( Vala.Class vcl ) {
		Class cl = new Class ( this.settings, vcl, this, this.head );
		this.classes.add ( cl );
	}

	public void add_classes ( Gee.Collection<Vala.Class> vclasses ) {
		foreach ( Vala.Class vcl in vclasses ) {
			this.add_class ( vcl );
		}
	}


	public void visit_classes ( Doclet doclet ) {
		foreach ( Class cl in this.get_class_list() ) {
			cl.visit ( doclet );
		}
	}

	protected void set_class_type_references ( ) {
		foreach ( Class cl in this.classes ) {
			cl.set_type_references ();
		}
	}

	protected void parse_class_comments ( DocumentationParser docparser ) {
		foreach ( Class cl in this.classes ) {
			cl.parse_comments ( docparser );
		}
	}
}

