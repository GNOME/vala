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
	public string? get_html_link ( Valadoc.Settings? settings, Valadoc.Basic element ) {
		GLib.StringBuilder str = new GLib.StringBuilder ( "" );
		Valadoc.Basic pos = element;

		if ( element is Valadoc.Package == false ) {
			if ( element is Valadoc.EnumValue || element is Valadoc.ErrorCode ) {
				str.append_unichar ( '#' );
				str.append ( element.name );
				pos = element.parent;
			}

			while ( pos != null ) {
				if ( pos.name == null )
					str.prepend ( "0" );
				else
					str.prepend ( pos.name );

				str.prepend ( "::" );

				if ( pos.parent is Valadoc.Package )
					break;

				pos = pos.parent;
			}
		}

		str.prepend ( element.file.name );
		str.prepend ( "?path=" );
		return str.str;
	}
}
