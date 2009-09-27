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


public interface Valadoc.SignalHandler : Basic {
	protected abstract Gee.ArrayList<Signal> signals {
		get;
		set;
	}

	protected DocumentedElement? search_signal_vala ( Gee.ArrayList<Vala.Symbol> params, int pos ) {
		Vala.Symbol velement = params[pos+1];
		if ( velement is Vala.Signal == false )
			return null;

		if ( params.size != pos+2 )
			return null;

		foreach ( Signal sig in this.signals ) {
			if ( sig.is_vsignal ( (Vala.Signal)velement ) ) {
				return sig;
			}
		}
		return null;
	}

	protected DocumentedElement? search_signal ( string[] params, int pos ) {
		pos++;

		if ( params[pos+1] != null )
			return null;

		foreach ( Signal sig in this.signals ) {
			if ( sig.name == params[pos] )
				return sig;
		}
		return null;
	}

	internal void add_signals ( Gee.Collection<Vala.Signal> vsignals ) {
		foreach ( Vala.Signal vsig in vsignals ) {
			var tmp = new Signal ( this.settings, vsig, this, this.head );
			this.signals.add ( tmp );
		}
	}

	public void visit_signals ( Doclet doclet ) {
		foreach ( Signal sig in this.get_signal_list ( ) ) {
			sig.visit ( doclet );
		}
	}

	public Gee.Collection<Signal> get_signal_list () {
		var lst = new Gee.ArrayList<Signal> ();
		foreach ( Signal sig in this.signals ) {
			if ( !sig.is_type_visitor_accessible ( this ) )
				continue ;

			lst.add ( sig );
		}

		return lst.read_only_view;
	}

	internal void set_signal_type_references () {
		foreach ( Signal sig in this.signals ) {
			sig.set_type_references ( );
		}
	}

	internal void parse_signal_comments ( Valadoc.Parser docparser ) {
		foreach ( Signal sig in this.signals ) {
			sig.parse_comment ( docparser );
		}
	}
}

