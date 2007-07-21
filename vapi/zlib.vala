/* glib-2.0.vala
 *
 * Copyright (C) 2006-2007  Raffaele Sandrini
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public
 * License as published by the Free Software Foundation; either
 * version 2 of the License, or (at your option) any later version.

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
 */

using GLib;

[CCode (lower_case_cprefix = "", cheader_filename = "zlib.h")]
namespace ZLib {
	[CCode (cprefix = "gz")]
	//[ReferenceType (free_function = "gzclose")]
	[CCode (cname = "gzFile")]
	public struct GZFileStream {
		public static GZFileStream open (string path, string mode);
		public static GZFileStream dopen (int fd, string mode);
		public int setparams (int level, int strategy);
		public int read (string buf, uint len);
		public int write (string buf, uint len);
		[PrintfFormat ()]
		public int printf (string format, ...);
		public int puts (string s);
		public weak string gets (string buf, uint len);
		public int flush (int flush);
		public int rewind ();
		public bool eof ();
		public bool direct ();
		public int close ();
	}
}
