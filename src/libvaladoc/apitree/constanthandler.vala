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


public interface Valadoc.ConstantHandler : Basic {
	protected abstract Gee.ArrayList<Constant> constants {
		protected set;
		get;
	}

	protected DocumentedElement? search_constant_vala ( Gee.ArrayList<Vala.Symbol> params, int pos ) {
		Vala.Symbol velement = params[pos+1];
		if ( velement is Vala.Constant == false )
			return null;

		if ( params.size != pos+2 )
			return null;

		foreach ( Constant c in this.constants ) {
			if ( c.is_vconstant ( (Vala.Constant)velement ) ) {
				return c;
			}
		}
		return null;
	}

	internal DocumentedElement? search_constant ( string[] params, int pos ) {
		pos++;

		if ( params[pos+1] != null )
			return null;

		foreach ( Constant c in this.constants ) {
			if ( c.name == params[pos] )
				return c;
		}
		return null;
	}

	public Gee.Collection<Constant> get_constant_list ( ) {
		var lstd = new Gee.ArrayList<Constant> ();
		foreach (Constant c in this.constants) {
			if (!c.is_type_visitor_accessible (this) )
				continue ;

			lstd.add (c);
		}

		return lstd.read_only_view;
	}

	internal void add_constants (Gee.Collection<Vala.Constant> vconstants) {
		foreach (Vala.Constant vc in vconstants) {
			this.add_constant (vc);
		}
	}

	internal void add_constant (Vala.Constant vc) {
		var tmp = new Constant (this.settings, vc, this, this.head);
		this.constants.add ( tmp );
	}

	internal void set_constant_type_references ( ) {
		foreach ( Constant c in this.constants ) {
			c.set_type_references ( );
		}
	}

	internal void parse_constant_comments ( Valadoc.Parser docparser ) {
		foreach ( Constant c in this.constants ) {
			c.parse_comment ( docparser );
		}
	}

	public void visit_constants ( Doclet doclet ) {
		foreach ( Constant c in this.get_constant_list() ) {
			c.visit ( doclet, this );
		}
	}
}

