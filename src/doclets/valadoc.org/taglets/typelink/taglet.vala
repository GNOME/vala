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



public class Valadoc.ValdocOrg.TypeLinkInlineTaglet : Valadoc.InlineTaglet {
	private string typename = null;

	protected override string to_string () {
		return this.typename;
	}

	protected override bool write (void* res, int max, int index) {
		((GLib.FileStream)res).printf ("{@link %s}", this.typename);
		return true;
	}

	protected override bool parse (Settings settings, Tree tree, Documented self, string content, ref ErrorLevel errlvl, out string? errmsg) {
		Valadoc.DocumentedElement? element = tree.search_symbol_str ( (self is DocumentedElement)? (DocumentedElement)self : null, content.strip() );
		if (element == null) {
			errmsg = "Linked type is not available";
			errlvl = ErrorLevel.ERROR;
			return false;
		}

		this.typename = element.package.name+"/"+element.full_name ();
		return true;
	}
}


[ModuleInit]
public GLib.Type register_plugin (Gee.HashMap<string, Type> taglets) {
	GLib.Type type = typeof (Valadoc.ValdocOrg.TypeLinkInlineTaglet);
	taglets.set ("link", type);
	return type;
}

