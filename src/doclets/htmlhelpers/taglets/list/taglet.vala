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
using Gee;


namespace Valadoc.Html {
	public class ListDocElement : Valadoc.ListDocElement {
		private Gee.ArrayList<ListEntryDocElement> entries;
		private ListType type;

		public override bool parse ( Settings settings, Tree tree, DocumentedElement me, ListType type, Gee.ArrayList<ListEntryDocElement> entries ) {
			this.entries = entries;
			this.type = type;
			return true;
		}

		public override bool write ( void* res, int max, int index ) {
			weak GLib.FileStream file = (GLib.FileStream)res;
			int _max = this.entries.size;
			int _index = 0;

			file.printf ( (this.type == ListType.UNSORTED)? "<ul>\n" : "<ol>\n" );

			foreach ( ListEntryDocElement entry in this.entries ) {
				entry.write ( res, _max, _index );
				_index++;
			}

			file.printf ( (this.type == ListType.UNSORTED)? "</ul>\n" : "</ol>\n" );
			return true;
		}
	}
}


[ModuleInit]
public GLib.Type register_plugin ( Gee.HashMap<string, Type> taglets ) {
	return typeof ( Valadoc.Html.ListDocElement );
}


