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

	/* cp from valacompiler.vala, ported from glibc */
	private static bool ends_with_dir_separator (string s) {
		return Path.is_dir_separator (s.offset (s.length - 1).get_char ());
	}

	public string realpath (string name) {
		string rpath;

		// start of path component
		weak string start;
		// end of path component
		weak string end;

		if (!Path.is_absolute (name)) {
			// relative path
			rpath = Environment.get_current_dir ();

			start = end = name;
		} else {
			// set start after root
			start = end = Path.skip_root (name);

			// extract root
			rpath = name.substring (0, name.pointer_to_offset (start));
		}

		long root_len = rpath.pointer_to_offset (Path.skip_root (rpath));

		for (; start.get_char () != 0; start = end) {
			// skip sequence of multiple path-separators
			while (Path.is_dir_separator (start.get_char ())) {
				start = start.next_char ();
			}

			// find end of path component
			long len = 0;
			for (end = start; end.get_char () != 0 && !Path.is_dir_separator (end.get_char ()); end = end.next_char ()) {
				len++;
			}

			if (len == 0) {
				break;
			} else if (len == 1 && start.get_char () == '.') {
				// do nothing
			} else if (len == 2 && start.has_prefix ("..")) {
				// back up to previous component, ignore if at root already
				if (rpath.length > root_len) {
					do {
						rpath = rpath.substring (0, rpath.length - 1);
					} while (!ends_with_dir_separator (rpath));
				}
			} else {
				if (!ends_with_dir_separator (rpath)) {
					rpath += Path.DIR_SEPARATOR_S;
				}

				rpath += start.substring (0, len);
			}
		}

		if (rpath.length > root_len && ends_with_dir_separator (rpath)) {
			rpath = rpath.substring (0, rpath.length - 1);
		}

		if (Path.DIR_SEPARATOR != '/') {
			// don't use backslashes internally,
			// to avoid problems in #include directives
			string[] components = rpath.split ("\\");
			rpath = string.joinv ("/", components);
		}

		return rpath;
	}
}

