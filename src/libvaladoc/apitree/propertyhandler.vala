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


public interface Valadoc.PropertyHandler : Basic {
	protected abstract Gee.ArrayList<Property> properties {
		get;
		set;
	}

	protected DocumentedElement? search_property_vala ( Gee.ArrayList<Vala.Symbol> params, int pos ) {
		Vala.Symbol velement = params[pos+1];
		if ( velement is Vala.Property == false )
			return null;

		if ( params.size != pos+2 )
			return null;

		foreach ( Property prop in this.properties ) {
			if ( prop.is_vproperty ( (Vala.Property)velement ) ) {
				return prop;
			}
		}
		return null;
	}

	protected DocumentedElement? search_property ( string[] params, int pos ) {
		pos++;

		if ( params[pos+1] != null )
			return null;

		foreach ( Property prop in this.properties ) {
			if ( prop.name == params[pos] )
				return prop;
		}
		return null;
	}

	protected bool is_overwritten_property ( Property prop ) {
		foreach ( Property p in this.properties ) {
			if ( p.parent != this )
				continue ;

			if ( !p.is_override )
				continue ;

			if ( p.equals ( prop ) )
				return true;
		}
		return false;
	}

	public Gee.ReadOnlyCollection<Property> get_property_list ( ) {
		var lst = new Gee.ArrayList<Property> ();
		foreach ( Property p in this.properties ) {
			if ( !p.is_type_visitor_accessible ( this ) )
				continue ;

			lst.add ( p );
		}

		return new Gee.ReadOnlyCollection<Property>( lst );
	}

	protected void parse_property_comments ( Valadoc.Parser docparser ) {
		foreach ( Property prop in this.properties ) {
			prop.parse_comment ( docparser );
		}
	}

	public void visit_properties ( Doclet doclet ) {
		foreach ( Property prop in this.get_property_list () )
			prop.visit ( doclet );
	}

	protected void set_property_type_references () {
		foreach ( Property prop in this.properties ) {
			prop.set_type_references ( );
		}
	}

	protected void add_properties ( Gee.Collection<Vala.Property> vproperties ) {
		foreach ( Vala.Property vprop in vproperties ) {
			var tmp = new Property ( this.settings, vprop, this, this.head );
			this.properties.add ( tmp );
		}
	}
}

