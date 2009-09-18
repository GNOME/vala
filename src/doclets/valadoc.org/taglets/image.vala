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


public class Valadoc.ValadocOrg.ImageDocElement : Valadoc.ImageDocElement {
	private string imgpath;
	private string path;
	private string alt;

	public override bool parse (Settings settings, Documentation pos, owned string path, owned string alt) {
		if ( GLib.FileUtils.test (path, GLib.FileTest.EXISTS | GLib.FileTest.IS_REGULAR ) == false) {
			return false;
		}

		this.imgpath = (pos is DocumentedElement)?
			Path.build_filename (settings.path, ((DocumentedElement)pos).package.name, "wiki-images", Path.get_basename (path)) :
			Path.build_filename (settings.path, settings.pkg_name, "wiki-images", Path.get_basename (path));

		this.path = path;
		this.alt = alt;

		return true;
	}

	public override bool write (void* res, int max, int index) {
		bool tmp = copy_file (this.path, this.imgpath);
		if (tmp == false) {
			return false;
		}

		((GLib.FileStream)res).printf ("{{%s|%s}}", this.imgpath, (this.alt==null||this.alt=="")? this.imgpath: this.alt);
		return true;
	}
}


