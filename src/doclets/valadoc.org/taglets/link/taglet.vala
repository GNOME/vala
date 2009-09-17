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


public class Valadoc.ValdocOrg.LinkDocElement : Valadoc.LinkDocElement {
	private string desc;
	private string path;

	public override bool parse (Settings settings, Tree tree, Documentation pos, owned string path, owned string desc) {
		if ( path.has_suffix(".valadoc")&&path.has_prefix("/") ) {
			if ( tree.wikitree == null ) {
				return false;
			}

			WikiPage? wikipage = tree.wikitree.search(path.offset(1));
			if ( wikipage == null ) {
				return false;
			}

			this.path = settings.pkg_name+"/"+path.substring (0, path.len()-8);
			this.desc = desc;
			return true;
		}

		this.path = path;
		this.desc = desc;
		return true;
	}

	public override bool write (void* res, int max, int index) {
		weak GLib.FileStream file = (GLib.FileStream)res;
		file.printf ("[[%s|%s]]", this.path, (this.desc==null||this.desc=="")? this.path: this.desc);
		return true;
	}
}


[ModuleInit]
public GLib.Type register_plugin (Gee.HashMap<string, Type> taglets) {
	return typeof (Valadoc.ValdocOrg.LinkDocElement);
}

