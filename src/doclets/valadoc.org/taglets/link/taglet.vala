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
using Vala;
using Gee;



public class LinkHtmlTaglet : InlineTaglet, LinkHelper {
	private string content;
	private string path;

	public Settings settings {
		construct set;
		get;
	}

	public override bool parse ( Valadoc.Settings settings, Valadoc.Tree tree, Valadoc.Reporter reporter, string line_start, int line, int pos, Valadoc.Basic me, string content ) {
		string[] arr = content.split ( "\n" );
		string str = string.joinv ("", arr ).strip();

		Valadoc.Basic? element = tree.search_symbol_str ( me, str );
		if ( element == null ) {
			string error_start = this.extract_lines ( line_start, 0, 0 );
			reporter.add_error ( 0, pos, 0, pos+5, "Linked Type is not available.\n", error_start );
			return false;
		}

		this.settings = settings;
		this.path = this.get_html_link ( settings, element );
		this.content = element.full_name ();
		return true;
	}


	public override bool write ( void* res, int max, int index ) {
		if ( this.path == null )
			((GLib.FileStream)res).printf ( "<i>%s</i>", this.content );
		else
			((GLib.FileStream)res).printf ( "<a href=\"%s\">%s</a>", this.path, this.content );

		return true;
	}
}



[ModuleInit]
public GLib.Type register_plugin ( Gee.HashMap<string, Type> taglets ) {
        GLib.Type type = typeof ( LinkHtmlTaglet );
		taglets.set ( "link", type );
		return type;
}

