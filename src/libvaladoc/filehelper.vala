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

	public string realpath (string name) {
		string rpath;

		if (name.get_char () != '/') {
			// relative path
			rpath = Environment.get_current_dir ();
		}
		else {
			rpath = "/";
		}

		weak string start;
		weak string end;

		for (start = end = name; start.get_char () != 0; start = end) {
			// skip sequence of multiple path-separators
			while (start.get_char () == '/') {
				start = start.next_char ();
			}

			// find end of path component
			long len = 0;
			for (end = start; end.get_char () != 0 && end.get_char () != '/'; end = end.next_char ()) {
				len++;
			}

			if (len == 0) {
				break;
			}
			else if (len == 1 && start.get_char () == '.') {
				// do nothing
			}
			else if (len == 2 && start.has_prefix ("..")) {
				// back up to previous component, ignore if at root already
				if (rpath.len () > 1) {
					do {
						rpath = rpath.substring (0, rpath.len () - 1);
					}
					while (!rpath.has_suffix ("/"));
				}
			}
			else {
				if (!rpath.has_suffix ("/")) {
					rpath += "/";
				}

				rpath += start.substring (0, len);
			}
		}

		if (rpath.len () > 1 && rpath.has_suffix ("/")) {
			rpath = rpath.substring (0, rpath.len () - 1);
		}

		return rpath;
	}
}

