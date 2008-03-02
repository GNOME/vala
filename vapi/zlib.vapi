/* glib-2.0.vala
 *
 * Copyright (C) 2006-2008  Raffaele Sandrini, Jürg Billeter
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public
 * License as published by the Free Software Foundation; either
 * version 2.1 of the License, or (at your option) any later version.

 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * Lesser General Public License for more details.

 * You should have received a copy of the GNU Lesser General Public
 * License along with this library; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301  USA
 *
 * Author:
 *	Raffaele Sandrini <raffaele@sandrini.ch>
 * 	Jürg Billeter <j@bitron.ch>
 */

using GLib;

[CCode (lower_case_cprefix = "", cheader_filename = "zlib.h")]
namespace ZLib {
	[CCode (cname = "gzFile", cprefix = "gz", free_function = "gzclose")]
	public class GZFileStream {
		public static GZFileStream open (string path, string mode);
		public static GZFileStream dopen (int fd, string mode);
		public int setparams (int level, int strategy);
		public int read (char[] buf);
		public int write (char[] buf);
		[PrintfFormat]
		public int printf (string format, ...);
		public int puts (string s);
		public weak string gets (char[] buf);
		public int flush (int flush);
		public int rewind ();
		public bool eof ();
		public bool direct ();
	}
}
