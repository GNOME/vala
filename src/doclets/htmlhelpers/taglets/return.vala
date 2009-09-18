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


public class Valadoc.Html.ReturnTaglet : Valadoc.MainTaglet {
	public override int order { get { return 300; } }
	private Gee.Collection<DocElement> content;


	public override bool parse ( Settings settings, Tree tree, DocumentedElement me, Gee.Collection<DocElement> content, ref ErrorLevel errlvl, out string errmsg ) {
		if ( !(me is Valadoc.Method || me is Valadoc.Signal || me is Valadoc.Delegate) ) {
			errmsg = "Tag @return cannot be used in this context";
			errlvl = ErrorLevel.ERROR;
			return false;
		}
		this.content = content;
		return true;
	}

	public override bool write ( void* res, int max, int index ) {
		int _max = this.content.size;
		int _index = 0;

		foreach ( DocElement element in this.content ) {
			element.write ( res, _max, _index );
			_index++;
		}
		return true;
	}

	public override bool write_block_start ( void* res ) {
		weak GLib.FileStream file = (GLib.FileStream)res;
		file.printf ( "<h2 class=\"%s\">Returns:</h2>\n", css_title );
		return true;
	}

	public override bool write_block_end ( void* res ) {
		return true;
	}
}


