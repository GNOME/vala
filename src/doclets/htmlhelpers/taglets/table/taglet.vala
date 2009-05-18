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
	public class TableDocElement : Valadoc.TableDocElement {
		private Gee.ArrayList<Gee.ArrayList<TableCellDocElement>> cells;

		public override void parse ( Gee.ArrayList<Gee.ArrayList<TableCellDocElement>> cells ) {
			this.cells = cells;
		}

		public override bool write ( void* res, int max, int index ) {
			weak GLib.FileStream file = (GLib.FileStream)res;

			file.printf ( "<table border=\"1\" class=\"%s\">\n", css_wiki_table );
			foreach ( Gee.ArrayList<TableCellDocElement> row in this.cells ) {
				int _max = row.size;
				int _index = 0;

				file.puts ( "\t<tr>\n" );
				foreach ( TableCellDocElement cell in row ) {
					cell.write ( res, _max, _index );
					_index++;
				}
				file.puts ( "\t</tr>\n" );

			}
			file.puts ( "</table>\n" );
			return true;
		}
	}
}


[ModuleInit]
public GLib.Type register_plugin ( Gee.HashMap<string, Type> taglets ) {
	return typeof ( Valadoc.Html.TableDocElement );
}


