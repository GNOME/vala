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


public class Valadoc.Html.TypeLinkInlineTaglet : Valadoc.InlineTaglet {
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
		if (self is DocumentedElement) {
			var doc_element = (DocumentedElement) self;
			var doc_element_name = doc_element.full_name ();

			if (this.name == doc_element_name) {
				this.name = element.name;
			} else if (this.name.has_prefix (doc_element_name)) {
				this.name = this.name.substring (doc_element_name.length + 1);
			} else if (doc_element.parent != null && doc_element.parent is DocumentedElement) {
				var doc_parent_element_name = ((DocumentedElement) doc_element.parent).full_name ();
				if (this.name == doc_parent_element_name) {
					this.name = element.name;
				} else if (this.name.has_prefix (doc_parent_element_name)) {
					this.name = this.name.substring (doc_parent_element_name.length + 1);
				}
			}
		}
		this.css = get_html_content_link_css_class ( element );
		this.link = get_html_link ( settings, element, self );
		return true;
	}
}


