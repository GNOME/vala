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

[CCode (cname = "gboolean", cheader_filename = "glib.h", type_id = "G_TYPE_BOOLEAN", marshaller_type_name = "BOOLEAN")]
public struct bool {
}

[CCode (cname = "gpointer", cheader_filename = "glib.h", type_id = "G_TYPE_POINTER", marshaller_type_name = "POINTER")]
public struct pointer {
}

[CCode (cheader_filename = "glib.h", type_id = "G_TYPE_CHAR", marshaller_type_name = "CHAR")]
public struct char {
}

[CCode (cname = "unsigned char", cheader_filename = "glib.h", type_id = "G_TYPE_UCHAR", marshaller_type_name = "UCHAR")]
public struct uchar {
}

[CCode (cheader_filename = "glib.h", type_id = "G_TYPE_INT", marshaller_type_name = "INT")]
public struct int {
}

[CCode (cname = "unsigned int", cheader_filename = "glib.h", type_id = "G_TYPE_UINT", marshaller_type_name = "UINT")]
public struct uint {
}

[CCode (cheader_filename = "glib.h")]
public struct short {
}

[CCode (cname = "unsigned short", cheader_filename = "glib.h")]
public struct ushort {
}

[CCode (cheader_filename = "glib.h", type_id = "G_TYPE_LONG", marshaller_type_name = "LONG")]
public struct long {
}

[CCode (cname = "unsigned long", cheader_filename = "glib.h", type_id = "G_TYPE_ULONG", marshaller_type_name = "ULONG")]
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

[CCode (cname = "gint64", cheader_filename = "glib.h", type_id = "G_TYPE_INT64", marshaller_type_name = "INT64")]
public struct int64 {
}

[CCode (cname = "guint64", cheader_filename = "glib.h", type_id = "G_TYPE_UINT64", marshaller_type_name = "UINT64")]
public struct uint64 {
}

[CCode (cname = "float", cheader_filename = "glib.h", type_id = "G_TYPE_FLOAT", marshaller_type_name = "FLOAT")]
public struct float {
}

[CCode (cname = "double", cheader_filename = "glib.h", type_id = "G_TYPE_DOUBLE", marshaller_type_name = "DOUBLE")]
public struct double {
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

[ReferenceType (dup_function = "g_strdup", free_function = "g_free", type_id = "G_TYPE_STRING", ref_function = "g_strdup")]
[CCode (cname = "char", cheader_filename = "string.h,glib.h", type_id = "G_TYPE_STRING", marshaller_type_name = "STRING")]
public struct string {
	[CCode (cname = "g_str_has_suffix")]
	public bool has_suffix (string suffix);
	[CCode (cname = "g_strdup_printf")]
	public ref string printf (...);
	[CCode (cname = "g_strconcat")]
	public ref string concat (string string2, ...);
	[CCode (cname = "g_strndup")]
	public ref string ndup (uint n); /* FIXME: only UTF-8 */
	[CCode (cname = "g_strcompress")]
	public ref string compress ();
	[CCode (cname = "g_strsplit")]
	public ref string[] split (string delimiter, int max_tokens = 0);
	
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
	public long len (int max = -1);
	[CCode (cname = "g_utf8_strchr")]
	public string chr (int len, unichar c);
	
	[CCode (cname = "g_utf8_strup")]
	public ref string up (int len = -1);
	[CCode (cname = "g_utf8_collate")]
	public int collate (string str2);
}

[Import ()]
[CCode (cprefix = "G", lower_case_cprefix = "g_", cheader_filename = "glib.h")]
namespace GLib {
	public struct Type {
		[CCode (cname = "G_TYPE_IS_OBJECT")]
		public bool is_object ();
		
		public ref TypeClass class_ref ();
	}
	
	[ReferenceType ()]
	public struct TypeClass {
		
	}
	
	[ReferenceType ()]
	public struct ParamSpec {
	}
	
	[ReferenceType ()]
	public struct ObjectClass {
		public ParamSpec[] list_properties (ref int n_properties);
	}
	
	public struct ObjectConstructParam {
	}

	[CCode (cheader_filename = "glib-object.h")]
	public abstract class Object {
		public virtual Object constructor (Type type, uint n_construct_properties, ObjectConstructParam[] construct_properties);
	}
	
	public abstract class InitiallyUnowned : Object {
	}
	
	[ReferenceType (dup_function = "g_main_loop_ref", free_function = "g_main_loop_unref")]
	public struct MainLoop {
		public static ref MainLoop new (MainContext context, bool is_running);
		public void run ();
		public void quit ();
		public bool is_running ();
		public MainContext get_context ();
	}
	
	[ReferenceType (dup_function = "g_main_context_ref", free_function = "g_main_context_unref")]
	public struct MainContext {
		public static ref MainContext new ();
		public static MainContext default ();
		public bool iteration (bool may_block);
		public bool pending ();
		public void wakeup ();
		public bool acquire ();
		public void release ();
		public bool is_owner ();
	}
	
	[ReferenceType ()]
	public struct IdleSource {
		public static Source new ();
		public static uint add (SourceFunc function, pointer data);
	}
	
	[ReferenceType (dup_function = "g_source_ref", free_function = "g_source_unref")]
	public struct Source {
		public static ref Source new (SourceFuncs source_funcs, uint struct_size);
		public uint attach (MainContext context);
		public void set_callback (SourceFunc func, pointer data, DestroyNotify notify);
	}
	
	public callback bool SourcePrepareFunc (Source source, ref int timeout_);
	public callback bool SourceCheckFunc (Source source);
	public callback bool SourceDispatchFunc (Source source, SourceFunc _callback, pointer user_data);
	public callback void SourceFinalizeFunc (Source source);
	
	[ReferenceType ()]
	public struct SourceFuncs {
		public SourcePrepareFunc prepare;
		public SourceCheckFunc check;
		public SourceDispatchFunc dispatch;
		public SourceFinalizeFunc finalize;
	}
	
	public callback bool SourceFunc (pointer data);
	
	[ReferenceType ()]
	public struct ThreadFunctions {
	}
	
	[ReferenceType ()]
	public struct Thread {
		public static void init (ThreadFunctions vtable);
		public static bool supported ();
	}
	
	public static pointer malloc0 (ulong n_bytes);

	[ReferenceType ()]
	public struct Error {
	}
	
	public static void return_if_fail (bool expr);
	public static void assert (bool expr);
	public static void assert_not_reached ();
	
	public struct Path {
		public static ref string get_basename (string file_name);
		[CCode (cname = "g_build_filename")]
		public static ref string build_filename (string first_element, ...);
	}

	public enum FileTest {
		IS_REGULAR,
		IS_SYMLINK,
		IS_DIR,
		IS_EXECUTABLE,
		EXISTS
	}
	
	[ReferenceType (free_function = "fclose")]
	[CCode (cname = "FILE", cheader_filename = "stdio.h")]
	public struct File {
		[CCode (cname = "fopen")]
		public static ref File open (string path, string mode);
		[CCode (cname = "fdopen")]
		public static ref File fdopen (int fildes, string mode);
		[CCode (cname = "fprintf")]
		public void printf (string format, ...);
		[InstanceLast ()]
		[CCode (cname = "fputc")]
		public void putc (char c);
		[InstanceLast ()]
		[CCode (cname = "fputs")]
		public void puts (string s);
		[CCode (cname = "fclose")]
		public void close ();
		
		public static bool test (string filename, FileTest test);
		public static int open_tmp (string tmpl, out string name_used, out Error error);
		
		[CCode (cname = "g_rename")]
		public static int rename (string oldfilename, string newfilename);
		[CCode (cname = "g_unlink")]
		public static int unlink (string filename);
	}
	
	[ReferenceType (free_function = "g_mapped_file_free")]
	public struct MappedFile {
		public static ref MappedFile new (string filename, bool writable, out Error error);
		public void free ();
		public long get_length ();
		public char[] get_contents ();
	}
	
	[ReferenceType ()]
	[CCode (cname = "char", cheader_filename = "string.h")]
	public struct Memory {
		[CCode (cname = "memcmp")]
		public static int cmp (char[] s1, char[] s2, long n);
	}
	
	[CCode (cname = "stdout", cheader_filename = "stdio.h")]
	public static File stdout;
	
	[CCode (cname = "stderr", cheader_filename = "stdio.h")]
	public static File stderr;

	[ReferenceType (free_function = "g_option_context_free")]
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
	
	[ReferenceType (dup_function = "g_list_copy", free_function = "g_list_free", ref_function = "g_list_copy")]
	public struct List<G> {
		[ReturnsModifiedPointer ()]
		public void append (ref G data);
		[ReturnsModifiedPointer ()]
		public void prepend (ref G data);
		[ReturnsModifiedPointer ()]
		public void insert (ref G data, int position);
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
	
	[ReferenceType (dup_function = "g_hash_table_ref", free_function = "g_hash_table_unref", ref_function = "g_hash_table_ref")]
	public struct HashTable<K,V> {
		public static ref HashTable new (HashFunc hash_func, EqualFunc key_equal_func);
		public static ref HashTable new_full (HashFunc hash_func, EqualFunc key_equal_func, DestroyNotify key_destroy_func, DestroyNotify value_destroy_func);
		public void insert (ref K key, ref V value);
		public V lookup (K key);
	}
	
	public struct HashFunc {
	}
	
	public struct EqualFunc {
	}
	
	public callback void DestroyNotify (pointer data);
	
	[CCode (cname = "g_str_hash")]
	public static GLib.HashFunc str_hash;
	[CCode (cname = "g_str_equal")]
	public static GLib.EqualFunc str_equal;
	[CCode (cname = "g_free")]
	public static GLib.DestroyNotify g_free;
	[CCode (cname = "g_object_unref")]
	public static GLib.DestroyNotify g_object_unref;
	
	[ReferenceType (free_function = "g_string_free")]
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
