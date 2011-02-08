/* filehelper.vala
 *
 * Copyright (C) 2008-2009 Florian Brosch
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public
 * License as published by the Free Software Foundation; either
 * version 2.1 of the License, or (at your option) any later version.
 *
 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public
 * License along with this library; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301  USA
 *
 * Author:
 * 	Brosch Florian <flo.brosch@gmail.com>
 */
using Gee;


namespace Valadoc {
	[CCode (cprefix = "", cname = "PACKAGE_ICONDIR")]
	public extern const string icons_dir;

	public bool copy_file (string src, string dest) {
		GLib.FileStream fsrc = GLib.FileStream.open (src, "rb");
		if (fsrc == null) {
			return false;
		}

		GLib.FileStream fdest = GLib.FileStream.open (dest, "wb");
		if (fdest == null) {
			return false;
		}

		for (int c = fsrc.getc() ; !fsrc.eof() ; c = fsrc.getc()) {
			fdest.putc ((char)c);
		}

		return true;
	}

	public bool copy_directory (string src, string dest) {
		string _src = (src.has_suffix ( "/" ))? src : src + "/";
		string _dest = (dest.has_suffix ( "/" ))? dest : dest + "/";

		try {
			GLib.Dir dir = GLib.Dir.open (_src);
			for (weak string name = dir.read_name (); name != null ; name = dir.read_name ()) {
				if (!copy_file (_src+name, _dest+name)) {
					return false;
				}
			}
		}
		catch (GLib.FileError err) {
			return false;
		}
		return true;
	}

	public bool remove_directory (string rpath) {
		try {
			GLib.Dir dir = GLib.Dir.open ( rpath );
			if (dir == null)
				return false;

			for (weak string entry = dir.read_name(); entry != null ; entry = dir.read_name()) {
				string path = rpath + entry;

				bool is_dir = GLib.FileUtils.test (path, GLib.FileTest.IS_DIR);
				if (is_dir == true) {
					bool tmp = remove_directory (path);
					if (tmp == false) {
						return false;
					}
				} else {
					int tmp = GLib.FileUtils.unlink (path);
					if (tmp > 0) {
						return false;
					}
				}
			}
		} catch (GLib.FileError err) {
			return false;
		}

		return true;
	}

	public string realpath (string basedir) {
		return Vala.CodeContext.realpath (basedir);
	}
}

