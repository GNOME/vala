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


public interface Valadoc.FieldHandler : Basic {
	protected abstract Gee.ArrayList<Field> fields {
		protected set;
		get;
	}

	protected DocumentedElement? search_field_vala ( Gee.ArrayList<Vala.Symbol> params, int pos ) {
		Vala.Symbol velement = params[pos+1];
		if ( velement is Vala.Field == false )
			return null;

		if ( params.size != pos+2 )
			return null;

		foreach ( Field f in this.fields ) {
			if ( f.is_vfield ( (Vala.Field)velement ) ) {
				return f;
			}
		}
		return null;
	}

	internal DocumentedElement? search_field ( string[] params, int pos ) {
		pos++;

		if ( params[pos+1] != null )
			return null;

		foreach ( Field f in this.fields ) {
			if ( f.name == params[pos] )
				return f;
		}
		return null;
	}

	public Gee.Collection<Field> get_field_list ( ) {
		var lstd = new Gee.ArrayList<Field> ();
		foreach ( Field f in this.fields ) {
			if ( !f.is_type_visitor_accessible ( this ) )
				continue ;

			lstd.add ( f );
		}

		return lstd.read_only_view;
	}

	internal void add_fields ( Gee.Collection<Vala.Field> vfields ) {
		foreach ( Vala.Field vf in vfields ) {
			this.add_field ( vf );
		}
	}

	internal void add_field ( Vala.Field vf ) {
		//if ( vf.generated == true )
		//	return ;

		var tmp = new Field ( this.settings, vf, this, this.head );
		this.fields.add ( tmp );
	}

	internal void set_field_type_references ( ) {
		foreach ( Field field in this.fields ) {
			field.set_type_references ( );
		}
	}

	internal void parse_field_comments ( DocumentationParser docparser ) {
		foreach ( Field field in this.fields ) {
			field.parse_comment ( docparser );
		}
	}

	public void visit_fields ( Doclet doclet ) {
		foreach ( Field field in this.get_field_list() ) {
			field.visit ( doclet, this );
		}
	}
}

