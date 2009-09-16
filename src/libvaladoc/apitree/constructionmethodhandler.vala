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


public interface Valadoc.ConstructionMethodHandler : Basic, MethodHandler {
	protected abstract Gee.ArrayList<Method> construction_methods {
		set;
		get;
	}

	protected DocumentedElement? search_construction_method_vala ( Gee.ArrayList<Vala.Symbol> params, int pos ) {
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

	protected DocumentedElement? search_construction_method ( string[] params, int pos ) {
		pos++;

		if ( params[pos+1] == null )
			return null;

		if ( params[pos+2] != null )
			return null;

		string name = params[pos] + "." + params[pos+1];

		foreach ( Method m in this.construction_methods ) {
			if ( m.name == name )
				return m;
		}
		return null;
	}

	public Gee.ReadOnlyCollection<Method> get_construction_method_list ( ) {
		var lst = new Gee.ArrayList<Method> ();
		foreach ( Method cm in this.construction_methods ) {
			if ( !cm.is_type_visitor_accessible ( this ) )
				continue ;

			lst.add ( cm );
		}

		return new Gee.ReadOnlyCollection<Method>( lst );
	}

	protected void parse_construction_method_comments ( Valadoc.Parser docparser ) {
		foreach ( Method cm in this.construction_methods ) {
			cm.parse_comment ( docparser );
		}
	}

	protected void set_construction_method_references ( ) {
		foreach ( Method cm in this.construction_methods ) {
			cm.set_type_references ( );
		}
	}

	public void visit_construction_methods ( Doclet doclet ) {
		foreach ( Method m in this.get_construction_method_list() ) {
			m.visit ( doclet, this );
		}
	}

	protected void add_construction_method ( Vala.CreationMethod vm ) {
		var tmp = new Method ( this.settings, vm, this, this.head );
		this.construction_methods.add ( tmp );
	}

	protected void add_methods_and_construction_methods ( Gee.Collection<Vala.Method> vmethods ) {
		foreach ( Vala.Method vm in vmethods ) {
			if ( vm is Vala.CreationMethod ) {
				this.add_construction_method ( (Vala.CreationMethod)vm );
			}
			else {
				this.add_method ( vm );
			}
		}
	}
}

