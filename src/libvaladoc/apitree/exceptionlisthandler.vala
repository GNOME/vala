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


// rename to ExceptionListHandler
public interface Valadoc.ExceptionHandler : Basic {
	protected abstract Gee.ArrayList<DocumentedElement> err_domains {
		protected set;
		get;
	}

	public Gee.ReadOnlyCollection<DocumentedElement> get_error_domains ( ) {
		return new Gee.ReadOnlyCollection<DocumentedElement> ( this.err_domains );
	}

	public void add_exception_list ( Gee.Collection<Vala.DataType> vexceptions ) {
		foreach ( Vala.DataType vtype in vexceptions  ) {
				if ( ((Vala.ErrorType)vtype).error_domain == null ) {
					this.err_domains.add ( glib_error );
				}
				else {
					ErrorDomain type = (ErrorDomain)this.head.search_vala_symbol ( ((Vala.ErrorType)vtype).error_domain );
					this.err_domains.add ( type );
				}
		}
	}
}

