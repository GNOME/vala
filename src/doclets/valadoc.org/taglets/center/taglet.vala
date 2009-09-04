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


public class Valadoc.ValdocOrg.CenterDocElement : Valadoc.CenterDocElement {
	private Gee.ArrayList<DocElement> content;

	public override bool parse (Gee.ArrayList<DocElement> content) {
		this.content = content;
		return true;
	}

	public override bool write (void* res, int max, int index) {
		weak GLib.FileStream file = (GLib.FileStream)res;
		int _max = this.content.size;
		int _index = 0;

		file.puts ("\n)( ");

		foreach (DocElement element in this.content) {
			element.write ( res, _max, _index );
			_index++;
		}

		file.puts ("\n");
		return true;
	}
}


[ModuleInit]
public GLib.Type register_plugin (Gee.HashMap<string, Type> taglets) {
	return typeof (Valadoc.ValdocOrg.CenterDocElement);
}

