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
	public class TypeLinkInlineTaglet : Valadoc.InlineTaglet {
		private string? link = null;
		private string? name = null;
		private string? css = null;

		protected override string to_string ( ) {
			return this.name;
		}

		protected override bool write ( void* res, int max, int index ) {
			if ( this.link == null ) {
				((GLib.FileStream)res).printf ( "<span class=\"%s\">%s</span>", this.css, this.name );
			}
			else {
				((GLib.FileStream)res).printf ( "<a class=\"%s\" href=\"%s\">%s</a>", this.css, this.link, this.name );
			}

			return true;
		}

		protected override bool parse ( Settings settings, Tree tree, Documentation self, string content, ref ErrorLevel errlvl, out string? errmsg ) {
			Valadoc.DocumentedElement? element = tree.search_symbol_str ( (self is DocumentedElement)? (DocumentedElement)self : null, content.strip() );
			if ( element == null ) {
				errmsg = "Linked type is not available";
				errlvl = ErrorLevel.ERROR;
				return false;
			}

			this.name = element.full_name ();
			this.css = get_html_content_link_css_class ( element );
			this.link = get_html_link ( settings, element, self );
			return true;
		}
	}
}


[ModuleInit]
public GLib.Type register_plugin ( Gee.HashMap<string, Type> taglets ) {
	GLib.Type type = typeof ( Valadoc.Html.TypeLinkInlineTaglet );
	taglets.set ( "link", type );
	return type;
}

