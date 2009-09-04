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


public class Valadoc.ValdocOrg.SinceTaglet : Valadoc.MainTaglet {
	public override int order { get { return 400; } }
	private StringTaglet content;

	public override bool write_block_start (void* ptr) {
		return true;
	}

	public override bool write_block_end (void* res) {
		return true;
	}

	public override bool write (void* res, int max, int index) {
		if (max != index+1 )
			((GLib.FileStream)res).printf (" @since %s\n", this.content.content);

		return true;
	}

	public override bool parse (Settings settings, Tree tree, DocumentedElement me, Gee.Collection<DocElement> content, ref ErrorLevel errlvl, out string errmsg) {
		if (content.size != 1) {
			errmsg = "Version name was expected";
			errlvl = ErrorLevel.ERROR;
			return false;
		}

		Gee.Iterator<DocElement> it = content.iterator ();
		it.next ();

		DocElement element = it.get ();
		if (element is StringTaglet == false) {
			errmsg = "Version name was expected";
			errlvl = ErrorLevel.ERROR;
			return false;
		}

		this.content = (StringTaglet)element;
		return true;
	}
}



[ModuleInit]
public GLib.Type register_plugin (Gee.HashMap<string, Type> taglets) {
    GLib.Type type = typeof (Valadoc.ValdocOrg.SinceTaglet);
	taglets.set ("since", type);
	return type;
}

