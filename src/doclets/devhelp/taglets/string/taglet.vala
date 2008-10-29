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




public class StringHtmlTaglet : StringTaglet {
	public override bool parse ( Valadoc.Settings settings, Valadoc.Tree tree, string content ) {
		this.content = content;
		return true;
	}

	public override bool write ( void* res, int max , int index ) {
		try {
			string str = new Regex ( Regex.escape_string ("\n")).replace_literal ( this.content, -1, 0, "\n<br>" );
			((GLib.FileStream)res).puts ( str );
		}
		catch ( RegexError err ) {
			return false;
		}
		return true;
	}
}



[ModuleInit]
public GLib.Type register_plugin ( Gee.HashMap<string, Type> taglets ) {
        GLib.Type type = typeof ( StringHtmlTaglet );
		taglets.set ( "", type );
		return type;
}

