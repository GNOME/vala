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


public interface Valadoc.MethodHandler : Basic {
	protected abstract Gee.ArrayList<Method> methods {
		set;
		get;
	}

	protected DocumentedElement? search_method_vala ( Gee.ArrayList<Vala.Symbol> params, int pos ) {
		Vala.Symbol velement = params[pos+1];
		if ( velement is Vala.Method == false )
			return null;

		if ( params.size != pos+2 )
			return null;

		foreach ( Method m in this.methods ) {
			if ( m.is_vmethod ( (Vala.Method)velement ) ) {
				return m;
			}
		}
		return null;
	}

	internal DocumentedElement? search_method ( string[] params, int pos ) {
		pos++;

		if ( params[pos+1] != null )
			return null;

		foreach ( Method m in this.methods ) {
			if ( m.name == params[pos] )
				return m;
		}
		return null;
	}

	internal void set_method_type_references ( ) {
		foreach ( Method m in this.methods ) {
			m.set_type_references ( );
		}
	}

	internal void parse_method_comments ( DocumentationParser docparser ) {
		foreach ( Method m in this.methods ) {
			m.parse_comment ( docparser );
		}
	}

	protected void add_method ( Vala.Method vmethod ) {
		var tmp = new Method ( this.settings, vmethod, this, this.head );
		this.methods.add ( tmp );
	}

	protected void add_methods ( Gee.Collection<Vala.Method> vmethods ) {
		foreach ( Vala.Method vm in vmethods ) {
			this.add_method ( vm );
		}
	}

	public void visit_methods ( Doclet doclet ) {
		foreach ( Method m in this.get_method_list() ) {
			m.visit ( doclet, this );
		}
	}

	public Gee.Collection<Method> get_method_list ( ) {
		var lst = new Gee.ArrayList<Method> ();
		foreach ( Method m in this.methods ) {
			if ( !m.is_type_visitor_accessible ( this ) )
				continue ;

			lst.add ( m );
		}

		return lst.read_only_view;
	}
}


