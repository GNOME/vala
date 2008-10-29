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




public class VersionHtmlTaglet : MainTaglet {
	private string version;

	public override int order {
		get { return 400; }
	}

	public override bool write_block_start ( void* ptr ) {
		weak GLib.FileStream file = (GLib.FileStream)ptr;

		file.printf ( "<h2 class=\"%s\">Version:</h2>\n", css_title );
		return true;
	}

	public override bool write_block_end ( void* res ) {
		return true;
	}

	public override bool parse ( Valadoc.Settings settings, Valadoc.Tree tree, Valadoc.Reporter reporter, string line_start, int line, int pos, Valadoc.Basic me, Gee.ArrayList<Taglet> content ) {
		if ( content.size != 1 ) {
			string error_start = this.extract_lines ( line_start, 0, 0 );
			reporter.add_error ( 0, pos, 0, pos+7, "Inline taglets are not allowed here.\n", error_start );
			return false;
		}

		Taglet tag = content.get ( 0 );
		if ( tag is StringTaglet == false ) {
			string error_start = this.extract_lines ( line_start, 0, 0 );
			reporter.add_error ( 0, pos, 0, pos+7, "Inline taglets are not allowed here.\n", error_start );
			return false;
		}

		string str = ((StringTaglet)tag).content;
		this.version = str.strip ( );
		return true;
	}

	public override bool write ( void* res, int max, int index ) {
		((GLib.FileStream)res).printf ( "%s", this.version );
		if ( max != index+1 )
			((GLib.FileStream)res).puts ( ", " );

		return true;
	}
}



[ModuleInit]
public GLib.Type register_plugin ( Gee.HashMap<string, Type> taglets ) {
        GLib.Type type = typeof ( VersionHtmlTaglet );
		taglets.set ( "version", type );
		return type;
}

