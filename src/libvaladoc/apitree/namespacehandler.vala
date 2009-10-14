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

public interface Valadoc.NamespaceHandler : Api.Node {
	public Gee.Collection<Namespace> get_namespace_list () {
		return get_children_by_type (Api.NodeType.NAMESPACE);
	}

	public void visit_namespaces ( Doclet doclet ) {
		accept_children_by_type (Api.NodeType.NAMESPACE, doclet);
	}

	private Gee.ArrayList<Vala.Namespace> create_parent_vnamespace_list ( Vala.Symbol vsymbol ) {
		var lst = new Gee.ArrayList<Vala.Namespace> ();

		while ( vsymbol != null ) {
			if ( vsymbol is Vala.Namespace ) {
				lst.insert ( 0, (Vala.Namespace)vsymbol );
			}
			vsymbol = vsymbol.parent_symbol;
		}
		return lst;
	}

	internal Namespace get_namespace_helper ( Vala.Symbol node, Gee.List<Vala.Namespace> vnspaces, int pos ) {
		Vala.Namespace vns = vnspaces.get( pos );

		Namespace ns = this.find_namespace_without_childs ( vns );
		if ( ns == null ) {
			ns = new Namespace( this.settings, vns, this, this.head );
			add_child ( ns );
		}

		if ( vnspaces.size == pos+1 ) {
			return ns;
		}

		return ns.get_namespace_helper ( node, vnspaces, pos+1 );
	}

	protected Namespace get_namespace ( Vala.Symbol node ) {
		Vala.Symbol vnd = ((Vala.Symbol)node).parent_symbol;
		if ( vnd is Vala.Namespace == false )
			vnd = vnd.parent_symbol;

		Vala.Namespace vnspace = (Vala.Namespace)vnd;
		var nspace = this.find_namespace ( vnspace );
		if ( nspace != null )
			return nspace;

		var vnspaces = this.create_parent_vnamespace_list ( node );

		if ( vnspaces.size > 2 ) {
			return this.get_namespace_helper ( node, vnspaces, 1 );
		}
		else {
			var ns = new Namespace( this.settings, vnspace, this, this.head );
			add_child ( ns );
			return ns;
		}
	}

	internal Namespace? find_vnamespace_helper ( Gee.List<Vala.Namespace> vnspaces, int pos ) {
		Vala.Namespace? vns = vnspaces.get ( pos );
		if ( vns == null )
			return null;

		foreach ( Namespace ns in get_namespace_list () ) {
			if ( !ns.is_vnspace( vns ) )
				continue ;

			if ( pos+1 == vnspaces.size )
				return ns;

			return ns.find_vnamespace_helper ( vnspaces, pos+1 );
		}

		return null;
	}

	internal Namespace find_namespace_without_childs ( Vala.Namespace vns ) {
		Namespace ns2 = null;

		foreach ( Namespace ns in get_namespace_list () ) {
			if ( ns.is_vnspace(vns) )
				ns2 = ns;
		}

		return ns2;
	}

	internal Namespace find_namespace ( Vala.Namespace vns ) {
		var vnspaces = this.create_parent_vnamespace_list ( vns );

		return this.find_vnamespace_helper ( vnspaces, vnspaces.index_of( vns ) );
	}
}
