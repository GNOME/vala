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
[IntegerType (rank = 1)]
public struct char {
	[InstanceLast ()]
	[CCode (cname = "g_strdup_printf")]
	public ref string! to_string (string! format = "%hhi");
}

[CCode (cname = "unsigned char", cheader_filename = "glib.h", type_id = "G_TYPE_UCHAR", marshaller_type_name = "UCHAR")]
[IntegerType (rank = 2)]
public struct uchar {
	[InstanceLast ()]
	[CCode (cname = "g_strdup_printf")]
	public ref string! to_string (string! format = "%hhu");
}

[CCode (cheader_filename = "glib.h", type_id = "G_TYPE_INT", marshaller_type_name = "INT")]
[IntegerType (rank = 7)]
public struct int {
	[InstanceLast ()]
	[CCode (cname = "g_strdup_printf")]
	public ref string! to_string (string! format = "%i");
}

[CCode (cname = "unsigned int", cheader_filename = "glib.h", type_id = "G_TYPE_UINT", marshaller_type_name = "UINT")]
[IntegerType (rank = 8)]
public struct uint {
	[InstanceLast ()]
	[CCode (cname = "g_strdup_printf")]
	public ref string! to_string (string! format = "%u");
}

[CCode (cheader_filename = "glib.h")]
[IntegerType (rank = 3)]
public struct short {
	[InstanceLast ()]
	[CCode (cname = "g_strdup_printf")]
	public ref string! to_string (string! format = "%hi");
}

[CCode (cname = "unsigned short", cheader_filename = "glib.h")]
[IntegerType (rank = 4)]
public struct ushort {
	[InstanceLast ()]
	[CCode (cname = "g_strdup_printf")]
	public ref string! to_string (string! format = "%hu");
}

[CCode (cheader_filename = "glib.h", type_id = "G_TYPE_LONG", marshaller_type_name = "LONG")]
[IntegerType (rank = 12)]
public struct long {
	[InstanceLast ()]
	[CCode (cname = "g_strdup_printf")]
	public ref string! to_string (string! format = "%li");
}

[CCode (cname = "unsigned long", cheader_filename = "glib.h", type_id = "G_TYPE_ULONG", marshaller_type_name = "ULONG")]
[IntegerType (rank = 13)]
public struct ulong {
	[InstanceLast ()]
	[CCode (cname = "g_strdup_printf")]
	public ref string! to_string (string! format = "%lu");
}

[CCode (cname = "gint16", cheader_filename = "glib.h")]
[IntegerType (rank = 5)]
public struct int16 {
}

[CCode (cname = "guint16", cheader_filename = "glib.h")]
[IntegerType (rank = 6)]
public struct uint16 {
}

[CCode (cname = "gint32", cheader_filename = "glib.h")]
[IntegerType (rank = 9)]
public struct int32 {
}

[CCode (cname = "guint32", cheader_filename = "glib.h")]
[IntegerType (rank = 10)]
public struct uint32 {
}

[CCode (cname = "gint64", cheader_filename = "glib.h", type_id = "G_TYPE_INT64", marshaller_type_name = "INT64")]
[IntegerType (rank = 14)]
public struct int64 {
	[InstanceLast ()]
	[CCode (cname = "g_strdup_printf")]
	public ref string! to_string (string! format = "%lli");
}

[CCode (cname = "guint64", cheader_filename = "glib.h", type_id = "G_TYPE_UINT64", marshaller_type_name = "UINT64")]
[IntegerType (rank = 15)]
public struct uint64 {
	[InstanceLast ()]
	[CCode (cname = "g_strdup_printf")]
	public ref string! to_string (string! format = "%llu");
}

[CCode (cname = "float", cheader_filename = "glib.h", type_id = "G_TYPE_FLOAT", marshaller_type_name = "FLOAT")]
[FloatingType (rank = 1)]
public struct float {
}

[CCode (cname = "double", cheader_filename = "glib.h", type_id = "G_TYPE_DOUBLE", marshaller_type_name = "DOUBLE")]
[FloatingType (rank = 2)]
public struct double {
}

[CCode (cname = "gunichar", cheader_filename = "glib.h")]
[IntegerType (rank = 11)]
public struct unichar {
	[CCode (cname = "g_unichar_isalnum")]
	public bool isalnum ();
	[CCode (cname = "g_unichar_isdigit")]
	public bool isdigit ();
	[CCode (cname = "g_unichar_isupper")]
	public bool isupper ();
	[CCode (cname = "g_unichar_isxdigit")]
	public bool isxdigit ();
	[CCode (cname = "g_unichar_toupper")]
	public unichar toupper ();
	[CCode (cname = "g_unichar_tolower")]
	public unichar tolower ();
	[CCode (cname = "g_unichar_digit_value")]
	public int digit_value ();
	[CCode (cname = "g_unichar_xdigit_value")]
	public int xdigit_value ();
	
	[CCode (cname = "g_unichar_to_utf8")]
	public int to_utf8 (string outbuf);
}

[ReferenceType (dup_function = "g_strdup", free_function = "g_free", type_id = "G_TYPE_STRING", ref_function = "g_strdup")]
[CCode (cname = "char", cheader_filename = "stdlib.h,string.h,glib.h", type_id = "G_TYPE_STRING", marshaller_type_name = "STRING")]
public struct string {
	[CCode (cname = "g_strstr")]
	public string str (string! needle);
	[CCode (cname = "g_str_has_prefix")]
	public bool has_prefix (string! prefix);
	[CCode (cname = "g_str_has_suffix")]
	public bool has_suffix (string! suffix);
	[CCode (cname = "g_strdup_printf")]
	public ref string printf (...);
	[CCode (cname = "g_strconcat")]
	public ref string concat (string string2, ...);
	[CCode (cname = "g_strndup")]
	public ref string ndup (ulong n); /* FIXME: only UTF-8 */
	[CCode (cname = "g_strcompress")]
	public ref string compress ();
	[CCode (cname = "g_strsplit")]
	public ref string[] split (string! delimiter, int max_tokens = 0);
	[CCode (cname = "g_strsplit_set")]
	public ref string[] split_set (string! delimiters, int max_tokens = 0);
	
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
	public long len (long max = -1);
	[CCode (cname = "g_utf8_strchr")]
	public string chr (long len, unichar c);
	[CCode (cname = "g_utf8_validate")]
	public bool validate (long max_len = -1, out string end = null);
	
	[CCode (cname = "g_utf8_strup")]
	public ref string up (long len = -1);
	[CCode (cname = "g_utf8_casefold")]
	public ref string casefold (long len = -1);
	[CCode (cname = "g_utf8_collate")]
	public int collate (string str2);
	
	[CCode (cname = "g_str_hash")]
	public uint hash ();
	
	[CCode (cname = "atoi")]
	public int to_int ();
	[CCode (cname = "strtoll")]
	public int64 to_int64 (out string endptr = null, int _base = 0);
	[CCode (cname = "strlen")]
	public long size ();
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
		[NoArrayLength ()]
		public virtual Object constructor (Type type, uint n_construct_properties, ObjectConstructParam[] construct_properties);
	}
	
	public abstract class InitiallyUnowned : Object {
	}
	
	[ReferenceType (free_function = "g_free")]
	public struct Value {
		public Object get_object ();
	}
	
	public struct SignalInvocationHint {
		public uint signal_id;
		public Quark detail;
		public SignalFlags run_type;
	}
	
	[NoArrayLength ()]
	public callback bool SignalEmissionHook (SignalInvocationHint ihint, uint n_param_values, Value[] param_values, pointer data);
	
	[CCode (cprefix = "G_SIGNAL_")]
	public enum SignalFlags {
		RUN_FIRST,
		RUN_LAST,
		RUN_CLEANUP,
		DETAILED,
		ACTION,
		NO_HOOKS
	}
	
	public callback void Callback ();
	
	public struct Closure {
	}
	
	public struct ValueArray {
	}

	[CCode (cheader_filename = "math.h")]
	public struct Math {
		[CCode (cname = "sqrt")]
		public static double sqrt (double v);
		
		[CCode (cname = "G_E")]
		public static double E;
		
		[CCode (cname = "G_PI")]
		public static double PI;
	}
	
	[ReferenceType (dup_function = "g_main_loop_ref", free_function = "g_main_loop_unref")]
	public struct MainLoop {
		public construct (MainContext context, bool is_running);
		public void run ();
		public void quit ();
		public bool is_running ();
		public MainContext get_context ();
	}
	
	[ReferenceType (dup_function = "g_main_context_ref", free_function = "g_main_context_unref")]
	public struct MainContext {
		public construct ();
		public static MainContext @default ();
		public bool iteration (bool may_block);
		public bool pending ();
		public void wakeup ();
		public bool acquire ();
		public void release ();
		public bool is_owner ();
	}
	
	public struct Timeout {
		public static uint add (uint interval, SourceFunc function, pointer data);
	}
	
	[ReferenceType ()]
	public struct IdleSource {
		public construct ();
		public static uint add (SourceFunc function, pointer data);
	}
	
	[ReferenceType (dup_function = "g_source_ref", free_function = "g_source_unref")]
	public struct Source {
		public construct (SourceFuncs source_funcs, uint struct_size);
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
		
		[CCode (cname = "g_usleep")]
		public static void usleep (ulong microseconds);
	}
	
	public static pointer malloc0 (ulong n_bytes);
	
	[ReferenceType ()]
	public struct IOChannel {
	}

	[ReferenceType ()]
	public struct Error {
		public int code;
		public string message;
	}
	
	public static void return_if_fail (bool expr);
	public static void assert (bool expr);
	public static void assert_not_reached ();
	
	public static ref string convert (string! str, long len, string! to_codeset, string! from_codeset, ref int bytes_read, ref int bytes_written, out Error error);
	
	public struct Base64 {
		public static int encode_step (string! _in, int len, bool break_lines, string _out, ref int state, ref int save);
		public static int encode_close (bool break_lines, string _out, ref int state, ref int save);
		public static ref string encode (string! data, int len);
		public static int decode_step (string! _in, int len, ref int state, ref uint save);
		public static ref string decode (string! text, ref ulong out_len);
	}
	
	public struct TimeVal {
	}
	
	public struct Environment {
		[CCode (cname = "g_get_application_name")]
		public static string get_application_name ();
		[CCode (cname = "g_set_application_name")]
		public static void set_application_name (string application_name);
		[CCode (cname = "g_get_user_name")]
		public static string get_user_name ();
		[CCode (cname = "g_get_host_name")]
		public static string! get_host_name ();
		[CCode (cname = "g_get_home_dir")]
		public static string get_home_dir ();
	}
	
	public struct Path {
		public static ref string get_basename (string file_name);
		public static ref string get_dirname (string file_name);
		[CCode (cname = "g_build_filename")]
		public static ref string build_filename (string first_element, ...);
	}
	
	[ReferenceType (free_function = "g_scanner_destroy")]
	public struct Scanner {
	}
	
	public enum SpawnFlags {
	}
	
	public callback void SpawnChildSetupFunc (pointer user_data);

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
		
		public static bool get_contents (string! filename, out string contents, ref long length, out Error error);
		public static bool set_contents (string! filename, string contents, long length, out Error error);
		public static bool test (string filename, FileTest test);
		public static int open_tmp (string tmpl, out string name_used, out Error error);
		public static ref string read_link (string filename, out Error error);
		
		[CCode (cname = "g_rename")]
		public static int rename (string oldfilename, string newfilename);
		[CCode (cname = "g_unlink")]
		public static int unlink (string filename);
		
		[CCode (cname = "symlink")]
		public static int symlink (string! oldpath, string! newpath);
	}
	
	[ReferenceType (free_function = "g_dir_close")]
	public struct Dir {
		public static ref Dir open (string filename, uint _flags, out Error error);
		public string read_name ();
		
		[CCode (cname = "g_mkdir")]
		public static int create (string pathname, int mode);
		[CCode (cname = "g_mkdir_with_parents")]
		public static int create_with_parents (string pathname, int mode);
	}
	
	[ReferenceType (free_function = "g_mapped_file_free")]
	public struct MappedFile {
		public construct (string filename, bool writable, out Error error);
		public void free ();
		public long get_length ();
		public char[] get_contents ();
	}
	
	[ReferenceType ()]
	[CCode (cname = "char", cheader_filename = "string.h")]
	public struct Memory {
		[CCode (cname = "memcmp")]
		[NoArrayLength ()]
		public static int cmp (char[] s1, char[] s2, long n);
	}
	
	[CCode (cname = "stdout", cheader_filename = "stdio.h")]
	public static File stdout;
	
	[CCode (cname = "stderr", cheader_filename = "stdio.h")]
	public static File stderr;

	[ReferenceType (free_function = "g_option_context_free")]
	public struct OptionContext {
		public construct (string parameter_string);
		public bool parse (out string[] argv, out Error error);
		public void set_help_enabled (bool help_enabled);
		[NoArrayLength ()]
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
	public struct OptionGroup {
	}
	
	[CCode (cprefix = "G_MARKUP_")]
	public enum MarkupParseFlags {
		TREAT_CDATA_AS_TEXT
	}
	
	[ReferenceType (free_function = "g_markup_parse_context_free")]
	public struct MarkupParseContext {
		public construct (MarkupParser parser, MarkupParseFlags _flags, pointer user_data, DestroyNotify user_data_dnotify);
		public bool parse (string text, long text_len, out Error error);
	}
	
		[NoArrayLength ()]
	public callback void MarkupParserStartElementFunc (MarkupParseContext context, string element_name, string[] attribute_names, string[] attribute_values, pointer user_data, out Error error);
	
	public callback void MarkupParserEndElementFunc (MarkupParseContext context, string element_name, pointer user_data, out Error error);
	
	public callback void MarkupParserTextFunc (MarkupParseContext context, string text, ulong text_len, pointer user_data, out Error error);
	
	public callback void MarkupParserPassthroughFunc (MarkupParseContext context, string passthrough_text, ulong text_len, pointer user_data, out Error error);
	
	public callback void MarkupParserErrorFunc (MarkupParseContext context, Error error, pointer user_data);
	
	[ReferenceType (free_function = "g_free")]
	public struct MarkupParser {
		public MarkupParserStartElementFunc start_element;
		public MarkupParserEndElementFunc end_element;
		public MarkupParserTextFunc text;
		public MarkupParserPassthroughFunc passthrough;
		public MarkupParserErrorFunc error;
	}
	
	[ReferenceType (dup_function = "g_list_copy", free_function = "g_list_free")]
	public struct List<G> {
		[ReturnsModifiedPointer ()]
		public void append (ref G data);
		[ReturnsModifiedPointer ()]
		public void prepend (ref G data);
		[ReturnsModifiedPointer ()]
		public void insert (ref G data, int position);
		[ReturnsModifiedPointer ()]
		public void insert_before (List<G> sibling, ref G data);
		[ReturnsModifiedPointer ()]
		public void remove (G data);
		[ReturnsModifiedPointer ()]
		public void remove_link (List<G> llink);
		[ReturnsModifiedPointer ()]
		public void delete_link (List<G> link_);
		[ReturnsModifiedPointer ()]
		public void remove_all (G data);
		public void free ();
		
		public uint length ();
		public ref List<G> copy ();
		[ReturnsModifiedPointer ()]
		public void reverse ();
		[ReturnsModifiedPointer ()]
		public void sort (CompareFunc compare_func);
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
	
	[ReferenceType (dup_function = "g_slist_copy", free_function = "g_slist_free")]
	public struct SList<G> {
		[ReturnsModifiedPointer ()]
		public void append (ref G data);
		[ReturnsModifiedPointer ()]
		public void prepend (ref G data);
		[ReturnsModifiedPointer ()]
		public void insert (ref G data, int position);
		[ReturnsModifiedPointer ()]
		public void insert_before (SList<G> sibling, ref G data);
		[ReturnsModifiedPointer ()]
		public void remove (G data);
		[ReturnsModifiedPointer ()]
		public void remove_link (SList<G> llink);
		[ReturnsModifiedPointer ()]
		public void delete_link (SList<G> link_);
		[ReturnsModifiedPointer ()]
		public void remove_all (G data);
		public void free ();
		
		public uint length ();
		public ref SList<G> copy ();
		[ReturnsModifiedPointer ()]
		public void reverse ();
		[ReturnsModifiedPointer ()]
		public void concat (ref SList<G> list2);
		
		public SList<G> last ();
		public SList<G> nth (uint n);
		public pointer nth_data (uint n);
		
		public SList<G> find (G data);
		public SList<G> find_custom (G data, CompareFunc func);
		public int position (SList<G> llink);
		public int index (G data);
		
		public G data;
		public SList<G> next;
	}
	
	public struct CompareFunc {
	}
	
	[CCode (cname = "strcmp")]
	public static GLib.CompareFunc strcmp;
	
	[ReferenceType (dup_function = "g_hash_table_ref", free_function = "g_hash_table_unref", ref_function = "g_hash_table_ref")]
	public struct HashTable<K,V> {
		public construct (HashFunc hash_func, EqualFunc key_equal_func);
		public construct full (HashFunc hash_func, EqualFunc key_equal_func, DestroyNotify key_destroy_func, DestroyNotify value_destroy_func);
		public void insert (ref K key, ref V value);
		public void replace (ref K key, ref V value);
		public V lookup (K key);
		public bool remove (K key);
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
		public construct (string init = "");
		[CCode (cname = "g_string_sized_new")]
		public construct sized (ulong dfl_size);
		public String assign (string! rval);
		public String append (string! val);
		public String append_c (char c);
		public String append_unichar (unichar wc);
		public String append_len (string! val, long len);
		public String prepend (string! val);
		public String prepend_c (char c);
		public String prepend_unichar (unichar wc);
		public String prepend_len (string! val, long len);
		public String insert (long pos, string! val);
		public String erase (long pos, long len);
		
		public string str;
		public long len;
		public long allocated_len;
	}
	
	[ReferenceType (free_function = "g_ptr_array_free")]
	public struct PtrArray {
	}
	
	public struct Quark {
		public static Quark from_string (string string);
		public string to_string ();
	}
}
