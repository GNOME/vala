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
using Gee;


public class Valadoc.ValadocOrg.SeeTaglet : MainTaglet {
	public override int order { get { return 400; } }
	private string typename;

	protected override bool write_block_start (void* res) {
		return true;
	}

	protected override bool write_block_end (void* res) {
		return true;
	}

	protected override bool write (void* res, int max, int index) {
		((GLib.FileStream)res).printf (" @see %s\n", this.typename);
		return true;
	}

	public override bool parse (Settings settings, Tree tree, Api.Node me, Gee.Collection<DocElement> content, ref ErrorLevel errlvl, out string errmsg) {
		if (content.size != 1) {
			errmsg = "Type name was expected";
			errlvl = ErrorLevel.ERROR;
			return false;
		}

		Gee.Iterator<DocElement> it = content.iterator ();
		it.next ();

		DocElement element = it.get ();
		if (element is StringTaglet == false) {
			errmsg = "Type name was expected";
			errlvl = ErrorLevel.ERROR;
			return false;
		}

		Valadoc.Api.Node? node = tree.search_symbol_str (me, ((StringTaglet)element).content.strip ());
		if (node == null) {
			errmsg = "Linked type is not available";
			errlvl = ErrorLevel.ERROR;
			return false;
		}

		this.typename = node.full_name ();
		return true;
	}
}


