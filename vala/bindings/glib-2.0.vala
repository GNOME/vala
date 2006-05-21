/* glib-2.0.vala
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

[CCode (cname = "gboolean", cheader_filename = "glib.h")]
public struct bool {
}

[CCode (cname = "gpointer", cheader_filename = "glib.h")]
public struct pointer {
}

[CCode (cheader_filename = "glib.h")]
public struct char {
}

[CCode (cname = "unsigned char", cheader_filename = "glib.h")]
public struct uchar {
}

[CCode (cheader_filename = "glib.h")]
public struct int {
}

[CCode (cname = "unsigned int", cheader_filename = "glib.h")]
public struct uint {
}

[CCode (cheader_filename = "glib.h")]
public struct short {
}

[CCode (cname = "unsigned short", cheader_filename = "glib.h")]
public struct ushort {
}

[CCode (cheader_filename = "glib.h")]
public struct long {
}

[CCode (cname = "unsigned long", cheader_filename = "glib.h")]
public struct ulong {
}

[CCode (cname = "gint8", cheader_filename = "glib.h")]
public struct int8 {
}

[CCode (cname = "guint8", cheader_filename = "glib.h")]
public struct uint8 {
}

[CCode (cname = "gint16", cheader_filename = "glib.h")]
public struct int16 {
}

[CCode (cname = "guint16", cheader_filename = "glib.h")]
public struct uint16 {
}

[CCode (cname = "gint32", cheader_filename = "glib.h")]
public struct int32 {
}

[CCode (cname = "guint32", cheader_filename = "glib.h")]
public struct uint32 {
}

[CCode (cname = "gint64", cheader_filename = "glib.h")]
public struct int64 {
}

[CCode (cname = "guint64", cheader_filename = "glib.h")]
public struct uint64 {
}

[CCode (cname = "gunichar", cheader_filename = "glib.h")]
public struct unichar {
	[CCode (cname = "g_unichar_isalnum")]
	public bool isalnum ();
	[CCode (cname = "g_unichar_isupper")]
	public bool isupper ();
	[CCode (cname = "g_unichar_toupper")]
	public unichar toupper ();
	[CCode (cname = "g_unichar_tolower")]
	public unichar tolower ();
}

[ReferenceType ()]
[AllowPointerArithmetic ()]
[CCode (cname = "char", cheader_filename = "string.h,glib.h")]
public struct astring {
	[CCode (cname = "g_str_has_suffix")]
	public bool has_suffix (string suffix);
	[CCode (cname = "g_strdup_printf")]
	public ref astring printf (string args);
	[CCode (cname = "g_ascii_strup")]
	public ref astring up (long len /* = -1 */);
	[CCode (cname = "g_ascii_strdown")]
	public ref astring down (long len /* = -1 */);
	[CCode (cname = "g_strconcat")]
	public ref astring concat (string string2);
	[CCode (cname = "g_strdup")]
	public ref astring dup ();
	[CCode (cname = "g_strndup")]
	public ref astring ndup (int n);
	[CCode (cname = "strlen")]
	public int len ();
	[CCode (cname = "g_strcompress")]
	public ref astring compress ();
	[CCode (cname = "strcmp")]
	public int cmp ();
}

[ReferenceType ()]
[CCode (cname = "char", cheader_filename = "string.h,glib.h")]
public struct string {
	[CCode (cname = "g_str_has_suffix")]
	public bool has_suffix (string suffix);
	[CCode (cname = "g_strdup_printf")]
	public ref string printf (string args);
	[CCode (cname = "g_strconcat")]
	public ref string concat (string string2);
	[CCode (cname = "g_strndup")]
	public ref string ndup (int n);
	[CCode (cname = "g_strcompress")]
	public ref string compress ();
	[CCode (cname = "g_strsplit")]
	public ref string[] split (string delimiter, int max_tokens /* = 0 */);
	
	[CCode (cname = "g_utf8_next_char")]
	public string next_char ();
	[CCode (cname = "g_utf8_get_char")]
	public unichar get_char ();
	[CCode (cname = "g_utf8_offset_to_pointer")]
	[PlusOperator ()]
	public string offset (long offset);
	[CCode (cname = "g_utf8_pointer_to_offset")]
	public long pointer_to_offset (string pos);
	[CCode (cname = "g_utf8_prev_char")]
	public string prev_char ();
	[CCode (cname = "g_utf8_strlen")]
	public long len (long max /*= -1*/);
	[CCode (cname = "g_utf8_strchr")]
	public string chr (long len, unichar c);
	
	[CCode (cname = "g_utf8_strup")]
	public ref string up (long len /*= -1*/);
	[CCode (cname = "g_utf8_collate")]
	public int collate (string str2);
}

[Import ()]
[CCode (cprefix = "G", lower_case_cprefix = "g_", cheader_filename = "glib.h")]
namespace GLib {
	public struct Path {
		public static ref string get_basename (string file_name);
		[CCode (cname = "g_build_filename")]
		public static ref string build_filename (string first_element);
	}

	public struct Type {
	}
	
	public struct ObjectConstructParam {
	}

	[CCode (cheader_filename = "glib-object.h")]
	public abstract class Object {
		public virtual Object constructor (Type type, uint n_construct_properties, ObjectConstructParam[] construct_properties);
	}

	[ReferenceType ()]
	public struct Error {
	}
	
	public static void return_if_fail (bool expr);
	
	[ReferenceType ()]
	[CCode (cname = "FILE", cheader_filename = "stdio.h")]
	public struct File {
		[CCode (cname = "fopen")]
		public static ref File open (string path, string mode);
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
	
	[CCode (cname = "stderr", cheader_filename = "stdio.h")]
	public static GLib.File stderr;

	[Unknown (reference_type = true)]
	[ReferenceType ()]
	public struct OptionContext {
		public static ref OptionContext new (string parameter_string);
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
		public ref List<G> copy ();
		[ReturnsModifiedPointer ()]
		public void reverse ();
		[ReturnsModifiedPointer ()]
		public void concat (ref List<G> list2);
		
		public List<G> first ();
		public List<G> last ();
		public List<G> nth (uint n);
		public pointer nth_data (uint n);
		public List<G> nth_prev (uint n);
		
		public List<G> find_custom (G data, CompareFunc func);
		
		public List<G> find (G data);
		public int position (List<G> llink);
		public int index (G data);
		
		public G data;
		public List<G> next;
		public List<G> prev;
	}
	
	public struct CompareFunc {
	}
	
	[CCode (cname = "strcmp")]
	public static GLib.CompareFunc strcmp;
	
	[ReferenceType ()]
	public struct HashTable<K,V> {
		public static ref HashTable new (HashFunc hash_func, EqualFunc key_equal_func);
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
	
	[ReferenceType ()]
	public struct String {
		public static ref String new (string init);
		public String append (string val);
		public String append_c (char c);
		public String append_unichar (unichar wc);
		public String erase (long pos, long len);
		
		public string str;
		public long len;
		public long allocated_len;
	}
}
