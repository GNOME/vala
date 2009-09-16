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


public interface Valadoc.DelegateHandler : Basic {
	protected abstract Gee.ArrayList<Delegate> delegates {
		set;
		get;
	}

	protected DocumentedElement? search_delegate_vala ( Gee.ArrayList<Vala.Symbol> params, int pos ) {
		Vala.Symbol velement = params[pos+1];
		if ( velement is Vala.Delegate == false )
			return null;

		foreach ( Delegate del in this.delegates ) {
			if ( del.is_vdelegate ( (Vala.Delegate)velement ) ) {
				return del;
			}
		}
		return null;
	}

	protected DocumentedElement? search_delegate ( string[] params, int pos ) {
		pos++;

		if ( params[pos+1] != null )
			return null;

		foreach ( Delegate del in this.delegates ) {
			if ( del.name == params[pos] )
				return del;
		}
		return null;
	}

	public Gee.Collection<Delegate> get_delegate_list ( ) {
		var lst = new Gee.ArrayList<Delegate> ();
		foreach ( Delegate del in this.delegates ) {
			if ( !del.is_type_visitor_accessible ( this ) )
				continue ;

			lst.add ( del );
		}

		return new Gee.ReadOnlyCollection<Delegate>( lst );
	}

	public void visit_delegates ( Doclet doclet ) {
		foreach ( Delegate del in this.delegates ) {
			del.visit ( doclet );
		}
	}

	public void add_delegates ( Gee.Collection<Vala.Delegate> vdels ) {
		foreach ( Vala.Delegate vdel in vdels ) {
			this.add_delegate ( vdel );
		}
	}

	public void add_delegate ( Vala.Delegate vdel ) {
		var tmp = new Delegate ( this.settings, vdel, this, this.head );
		this.delegates.add ( tmp );
	}

	public void set_delegate_type_references ( ) {
		foreach ( Delegate del in this.delegates ) {
			del.set_type_references ( );
		}
	}

	public void parse_delegate_comments ( Valadoc.Parser docparser ) {
		foreach ( Delegate del in this.delegates ) {
			del.parse_comment ( docparser );
		}
	}
}

