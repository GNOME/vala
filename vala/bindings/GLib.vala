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

[CCode (cname = "gunichar")]
public struct unichar {
}

[ReferenceType ()]
[AllowPointerArithmetic ()]
[CCode (cname = "char")]
public struct string {
	[CCode (cname = "g_str_has_suffix")]
	public bool has_suffix (string suffix);
	[CCode (cname = "g_strdup_printf")]
	public ref string printf (string args);
	[CCode (cname = "g_strconcat")]
	public ref string concat (string string2);
	[CCode (cname = "g_strdup")]
	public ref string dup ();
	[CCode (cname = "g_strndup")]
	public ref string ndup (int n);
	[CCode (cname = "strlen")]
	public int len ();
	[CCode (cname = "g_strcompress")]
	public string# compress ();
	[CCode (cname = "strcmp")]
	public int cmp ();
}

[ReferenceType ()]
[CCode (cname = "char")]
public struct ustring {
	[CCode (cname = "g_utf8_offset_to_pointer")]
	[PlusOperator ()]
	public string offset (long offset);
	[CCode (cname = "g_utf8_strlen")]
	public long len (long max /*= -1*/);
}

[Import ()]
[CCode (cname = "g", cprefix = "G", include_filename = "glib.h")]
namespace GLib {
	public struct Path {
		public static ref ustring get_basename (ustring file_name);
	}

	public struct Type {
	}
	
	public struct ObjectConstructParam {
	}

	public class Object {
		public virtual Object constructor (Type type, uint n_construct_properties, ObjectConstructParam[] construct_properties);
	}

	[ReferenceType ()]
	public struct Error {
	}
	
	[ReferenceType ()]
	[CCode (cname = "FILE")]
	public struct File {
		[CCode (cname = "fopen")]
		public static File# open (string path, string mode);
		[CCode (cname = "fprintf")]
		public void printf (string format);
		[InstanceLast ()]
		[CCode (cname = "fputc")]
		public void putc (char c);
		[InstanceLast ()]
		[CCode (cname = "fputs")]
		public void puts (string s);
		[CCode (cname = "fclose")]
		public void close ();
	}
	
	[CCode (cname = "stderr")]
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
	
	[ReferenceType ()]
	public struct HashTable<K,V> {
		public static HashTable# new (HashFunc hash_func, EqualFunc key_equal_func);
		public void insert (K key, V value);
		public V lookup (K key);
	}
	
	public struct HashFunc {
	}
	
	public struct EqualFunc {
	}
	
	[CCode (cname = "g_str_hash")]
	public static GLib.HashFunc str_hash;
	[CCode (cname = "g_str_equal")]
	public static GLib.EqualFunc str_equal;
	
	
}
