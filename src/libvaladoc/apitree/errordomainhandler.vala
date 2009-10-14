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

public interface Valadoc.ErrorDomainHandler : Api.Node {
	public Gee.Collection<ErrorDomain> get_error_domain_list () {
		return get_children_by_type (Api.NodeType.ERROR_DOMAIN);
	}

	public void visit_error_domains (Doclet doclet) {
		accept_children_by_type (Api.NodeType.ERROR_DOMAIN, doclet);
	}

	public void add_error_domains (Gee.Collection<Vala.ErrorDomain> verrdoms) {
		foreach ( Vala.ErrorDomain verrdom in  verrdoms ) {
			this.add_error_domain ( verrdom );
		}
	}

	public void add_error_domain ( Vala.ErrorDomain verrdom ) {
		var tmp = new ErrorDomain ( this.settings, verrdom, this, this.head );
		add_child ( tmp );
	}
}
