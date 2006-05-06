/* GLib.vala
 *
 * Copyright (C) 2006  Jürg Billeter
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
 * 	Jürg Billeter <j@bitron.ch>
 */

using Vala;

[CCode (cname = "gboolean")]
public struct bool {
}

[CCode (cname = "gpointer")]
public struct pointer {
}

public struct char {
}

[CCode (cname = "unsigned char")]
public struct uchar {
}

public struct int {
}

[CCode (cname = "unsigned int")]
public struct uint {
}

public struct short {
}

[CCode (cname = "unsigned short")]
public struct ushort {
}

public struct long {
}

[CCode (cname = "unsigned long")]
public struct ulong {
}

[CCode (cname = "gint8")]
public struct int8 {
}

[CCode (cname = "guint8")]
public struct uint8 {
}

[CCode (cname = "gint16")]
public struct int16 {
}

[CCode (cname = "guint16")]
public struct uint16 {
}

[CCode (cname = "gint32")]
public struct int32 {
}

[CCode (cname = "guint32")]
public struct uint32 {
}

[CCode (cname = "gint64")]
public struct int64 {
}

[CCode (cname = "guint64")]
public struct uint64 {
}

[ReferenceType ()]
[CCode (cname = "char")]
public struct string {
	[CCode (cname = "g_str_has_suffix")]
	public bool has_suffix (string suffix);
	[CCode (cname = "g_strdup_printf")]
	public string# printf (string args);
	[CCode (cname = "g_strconcat")]
	public string# concat (string string2);
}

[Import ()]
[CCode (cname = "g", cprefix = "G", include_filename = "glib/glib.h")]
namespace GLib {
	[ReferenceType ()]
	public struct Error {
	}
	
	[ReferenceType ()]
	[CCode (cname = "FILE")]
	public struct File {
		[CCode (cname = "fprintf")]
		public void printf (string format);
	}
	
	public static GLib.File stderr;

	[Unknown (reference_type = true)]
	[ReferenceType ()]
	public struct OptionContext {
		public static OptionContext# @new (string parameter_string);
		public bool parse (ref int argc, out string[] argv, out Error error);
		public void set_help_enabled (bool help_enabled);
		public void add_main_entries (OptionEntry[] entries, string translation_domain);
	}
	
	public enum OptionArg {
		NONE,
		STRING,
		INT,
		CALLBACK,
		FILENAME,
		STRING_ARRAY,
		FILENAME_ARRAY
	}
	
	public flags OptionFlags {
		HIDDEN,
		IN_MAIN,
		REVERSE,
		NO_ARG,
		FILENMAE,
		OPTIONAL_ARG,
		NOALIAS
	}
	
	public struct OptionEntry {
		string long_name;
		char short_name;
		int flags_;
		
		OptionArg arg;
		pointer arg_data;
		
		string description;
		string arg_description;
	}
	
	[ReferenceType ()]
	public struct List<G> {
		[ReturnsModifiedPointer ()]
		public void append (G data);
		[ReturnsModifiedPointer ()]
		public void prepend (G data);
		[ReturnsModifiedPointer ()]
		public void insert (G data, int position);
		[ReturnsModifiedPointer ()]
		public void insert_before (List<G> sibling, G data);
		[ReturnsModifiedPointer ()]
		public void remove (G data);
		[ReturnsModifiedPointer ()]
		public void remove_link (List<G> llink);
		[ReturnsModifiedPointer ()]
		public void remove_all (G data);
		public void free ();
		
		public uint length ();
		public List<G># copy ();
		[ReturnsModifiedPointer ()]
		public void reverse ();
		[ReturnsModifiedPointer ()]
		public void concat (List<G># list2);
		
		public List<G> first ();
		public List<G> last ();
		public List<G> nth (uint n);
		public pointer nth_data (uint n);
		public List<G> nth_prev (uint n);
		
		public List<G> find (G data);
		public int position (List<G> llink);
		public int index (G data);
		
		public G data;
		public List<G> next;
		public List<G> prev;
	}
}
