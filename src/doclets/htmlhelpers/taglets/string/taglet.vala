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
	public class StringTaglet : Valadoc.StringTaglet {
		public override bool parse ( Settings settings, Tree tree, DocumentedElement me, string content ) {
			this.content = content;
			return true;
		}

		public override bool write ( void* res, int max, int index ) {
			weak GLib.FileStream file = (GLib.FileStream)res;
			unichar chr = content[0];
			long lpos = 0;
			int i = 0;

			for ( i = 0; chr != '\0' ; i++, chr = content[i] ) {
				switch ( chr ) {
				case '\n':
					file.puts ( content.substring (lpos, i-lpos) ); 
					file.puts ( "<br />" );
					lpos = i+1;
					break;
				case '<':
					file.puts ( content.substring (lpos, i-lpos) ); 
					file.puts ( "&lt;" );
					lpos = i+1;
					break;
				case '>':
					file.puts ( content.substring (lpos, i-lpos) ); 
					file.puts ( "&gt;" );
					lpos = i+1;
					break;
				case '&':
					file.puts ( content.substring (lpos, i-lpos) ); 
					file.puts ( "&amp;" );
					lpos = i+1;
					break;
				}
			}
			file.puts ( content.substring (lpos, i-lpos) ); 
			return true;
		}
	}
}


[ModuleInit]
public GLib.Type register_plugin ( Gee.HashMap<string, Type> taglets ) {
	GLib.Type type = typeof ( Valadoc.Html.StringTaglet );
	taglets.set ( "", type );
	return type;
}


