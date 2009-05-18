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


using Valadoc;
using GLib;
using Gee;


namespace Valadoc.Html {
	public abstract class SeeTaglet : MainTaglet {
		public override int order { get { return 400; } }
		private string name;
		private string link;
		private string css;

		protected override bool write_block_start ( void* res ) {
			weak GLib.FileStream file = (GLib.FileStream)res;
			file.printf ( "<h2 class=\"%s\">See:</h2>\n", css_title );
			return true;
		}

		protected override bool write_block_end ( void* res ) {
			return true;
		}

		protected override bool write ( void* res, int max, int index ) {
			weak GLib.FileStream file = (GLib.FileStream)res;
			file.printf ( "<a class=\"%s\" href=\"%s\">%s</a>", this.css, this.link, this.name );
			if ( max != index+1 )
				file.printf ( ", " );

			return true;
		}

		protected override bool parse ( Settings settings, Tree tree, DocumentedElement me, Gee.Collection<DocElement> content, out string[] errmsg ) {
			if ( content.size != 1 ) {
				errmsg = new string[1];
				errmsg[0] = "Type name was expected.";
				return false;
			}

			Gee.Iterator<DocElement> it = content.iterator ();
			it.next ();

			DocElement element = it.get ();
			if ( element is StringTaglet == false ) {
				errmsg = new string[1];
				errmsg[0] = "Type name was expected.";
				return false;
			}

			Valadoc.DocumentedElement? node = tree.search_symbol_str ( me, ((StringTaglet)element).content.strip ( ) );
			if ( node == null ) {
				errmsg = new string[1];
				errmsg[0] = "Linked type is not available.";
				return false;
			}

			this.name = node.full_name ( );
			this.css = get_html_content_link_css_class ( node );
			this.link = get_html_link ( settings, node, me );
			//this.link = this.get_link ( settings, tree, node, me );
			return true;
		}
	}
}


[ModuleInit]
public GLib.Type register_plugin ( Gee.HashMap<string, Type> taglets ) {
	    GLib.Type type = typeof ( Valadoc.Html.SeeTaglet );
		taglets.set ( "see", type );
		return type;
}


