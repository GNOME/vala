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

using GLib;




public interface Valadoc.LinkHelper {
	protected string get_html_top_link ( DocumentedElement? postag ) {
		GLib.StringBuilder str = new GLib.StringBuilder ( "" );
		Valadoc.Basic pos = postag;

		while ( pos != null ) {
			str.append ( "../" );
			pos = pos.parent;
		}
		return str.str;
	}

	protected string? get_html_link ( Valadoc.Settings settings, DocumentedElement element, DocumentedElement? pos2 ) {
		Package pkg = ( element is Package )? (Package)element : element.package;
		if ( pkg.is_visitor_accessible () == false )
			return null;

		GLib.StringBuilder str = new GLib.StringBuilder ( "" );
		DocumentedElement pos = element;
		string? link_id = null;

		if ( element is Valadoc.Package == false ) {
			if ( element is Valadoc.EnumValue || element is Valadoc.ErrorCode ) {
				link_id = "#" + element.name;
				pos = (DocumentedElement)pos.parent;
			}
			else if ( element is Visitable ) {
				if ( !((Visitable)element).is_visitor_accessible() )
					return null;
			}

			while ( pos is Package == false ) {
				string name = pos.name;
				if ( name == null )
					str.prepend ( "0" );
				else
					str.prepend ( name );

				str.prepend ( "/" );
				pos = (DocumentedElement)pos.parent;
			}
		}

		str.prepend ( pos.package.name );
		str.prepend ( this.get_html_top_link ( pos2 ) );
		str.append ( "/index.html" );

		if ( link_id != null )
			str.append ( link_id );

		return str.str;
	}
}

