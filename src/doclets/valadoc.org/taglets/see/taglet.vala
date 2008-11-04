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


public class SeeHtmlTaglet : MainTaglet, LinkHelper {
	private string name;
	private string path;

	public override int order {
		get { return 500; }
	}

	public Settings settings {
		construct set;
		get;
	}

	public override bool write_block_start ( void* ptr ) {
		weak GLib.FileStream file = (GLib.FileStream)ptr;

		file.printf ( "<h2 class=\"%s\">See:</h2>\n", css_title );
		file.printf ( "<ul class=\"%s\">", css_see_list );
		return true;
	}

	public override bool write_block_end ( void* ptr ) {
		weak GLib.FileStream file = (GLib.FileStream)ptr;

		file.puts ( "</ul>" );
		return true;
	}

	public override bool parse ( Valadoc.Settings settings, Valadoc.Tree tree, Valadoc.Reporter reporter, string line_start, int line, int pos, Valadoc.Basic me, Gee.ArrayList<Taglet> content ) {
		if ( content.size == 0 ) {
			string error_start = this.extract_lines ( line_start, 0, 0 );
			reporter.add_error ( 0, pos, 0, pos+4, "Expected a symbol name.\n", error_start );
			return false;
		}

		Taglet tag = content.get ( 0 );
		if ( tag is StringTaglet == false ) {
			string error_start = this.extract_lines ( line_start, 0, 0 );
			reporter.add_error ( 0, pos, 0, pos+4, "Expected a symbol name.\n", error_start );
			return false;
		}

		string[] arr = ((StringTaglet)tag).content.split ( "\n" );
		string str = string.joinv ("", arr ).strip();

		Valadoc.Basic? element = tree.search_symbol_str ( me, str );
		if ( element == null ) {
			string error_start = this.extract_lines ( line_start, 0, 0 );
			reporter.add_error ( 0, pos, 0, pos+4, "Linked type is not available.\n", error_start );
			return false;
		}

		this.settings = settings;
		this.path = this.get_html_link ( settings, element );
		this.name = element.full_name ();
		return true;
	}

	public override bool write ( void* ptr, int max, int index ) {
		weak GLib.FileStream file = (GLib.FileStream)ptr;

		file.printf ( "\t<li class=\"%s\"><a href=\"%s\">%s</a></li>\n", css_see_list, this.path, this.name );
		return true;
	}
}



[ModuleInit]
public GLib.Type register_plugin ( Gee.HashMap<string, Type> taglets ) {
        GLib.Type type = typeof ( SeeHtmlTaglet );
		taglets.set ( "see", type );
		return type;
}

