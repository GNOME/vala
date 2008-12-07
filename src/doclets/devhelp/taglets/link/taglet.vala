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


public class Valadoc.LinkDevhelpTaglet : Valadoc.LinkHtmlHelperTaglet, HtmlHelper {
	protected override string? get_link ( Settings settings, Tree tree, Basic element, Basic? pos ) {
		return this.get_html_link ( settings, element, pos );
	}

	public override string to_string () {
		return to_string_imp ( );
	}

	public override bool write ( void* res, int max, int index ) {
		return write_imp ( res, max, index );
	}

	public override bool parse ( Settings settings, Tree tree, Basic me, string content, out string[] errmsg ) {
		return this.parse_imp ( settings, tree, me, content, out errmsg );
	}
}


[ModuleInit]
public GLib.Type register_plugin ( Gee.HashMap<string, Type> taglets ) {
        GLib.Type type = typeof ( LinkDevhelpTaglet );
		taglets.set ( "link", type );
		return type;
}


