/* glib-2.0.vala
 *
 * Copyright (C) 2006  Jürg Billeter, Raffaele Sandrini
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
 *	Raffaele Sandrini <rasa@gmx.ch>
 */

[CCode (cname = "gboolean", cheader_filename = "glib.h", type_id = "G_TYPE_BOOLEAN", marshaller_type_name = "BOOLEAN", get_value_function = "g_value_get_boolean", set_value_function = "g_value_set_boolean")]
public struct bool {
}

[CCode (cname = "gpointer", cheader_filename = "glib.h", type_id = "G_TYPE_POINTER", marshaller_type_name = "POINTER", get_value_function = "g_value_get_pointer", set_value_function = "g_value_set_pointer")]
public struct pointer {
}

[CCode (cname = "gconstpointer", cheader_filename = "glib.h", type_id = "G_TYPE_POINTER", marshaller_type_name = "POINTER", get_value_function = "g_value_get_pointer", set_value_function = "g_value_set_pointer")]
public struct constpointer {
}

[CCode (cheader_filename = "glib.h", type_id = "G_TYPE_CHAR", marshaller_type_name = "CHAR", get_value_function = "g_value_get_char", set_value_function = "g_value_set_char")]
[IntegerType (rank = 1)]
public struct char {
	[InstanceLast ()]
	[CCode (cname = "g_strdup_printf")]
	public ref string! to_string (string! format = "%hhi");
}

[CCode (cname = "unsigned char", cheader_filename = "glib.h", type_id = "G_TYPE_UCHAR", marshaller_type_name = "UCHAR", get_value_function = "g_value_get_uchar", set_value_function = "g_value_set_uchar")]
[IntegerType (rank = 2)]
public struct uchar {
	[InstanceLast ()]
	[CCode (cname = "g_strdup_printf")]
	public ref string! to_string (string! format = "%hhu");
}

[CCode (cheader_filename = "glib.h", type_id = "G_TYPE_INT", marshaller_type_name = "INT", get_value_function = "g_value_get_int", set_value_function = "g_value_set_int")]
[IntegerType (rank = 7)]
public struct int {
	[InstanceLast ()]
	[CCode (cname = "g_strdup_printf")]
	public ref string! to_string (string! format = "%i");
}

[CCode (cname = "unsigned int", cheader_filename = "glib.h", type_id = "G_TYPE_UINT", marshaller_type_name = "UINT", get_value_function = "g_value_get_uint", set_value_function = "g_value_set_uint")]
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

[CCode (cheader_filename = "glib.h", type_id = "G_TYPE_LONG", marshaller_type_name = "LONG", get_value_function = "g_value_get_long", set_value_function = "g_value_set_long")]
[IntegerType (rank = 12)]
public struct long {
	[InstanceLast ()]
	[CCode (cname = "g_strdup_printf")]
	public ref string! to_string (string! format = "%li");
}

[CCode (cname = "unsigned long", cheader_filename = "glib.h", type_id = "G_TYPE_ULONG", marshaller_type_name = "ULONG", get_value_function = "g_value_get_ulong", set_value_function = "g_value_set_ulong")]
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

[CCode (cname = "gint64", cheader_filename = "glib.h", type_id = "G_TYPE_INT64", marshaller_type_name = "INT64", get_value_function = "g_value_get_int64", set_value_function = "g_value_set_int64")]
[IntegerType (rank = 14)]
public struct int64 {
	[InstanceLast ()]
	[CCode (cname = "g_strdup_printf")]
	public ref string! to_string (string! format = "%lli");
}

[CCode (cname = "guint64", cheader_filename = "glib.h", type_id = "G_TYPE_UINT64", marshaller_type_name = "UINT64", get_value_function = "g_value_get_uint64", set_value_function = "g_value_set_uint64")]
[IntegerType (rank = 15)]
public struct uint64 {
	[InstanceLast ()]
	[CCode (cname = "g_strdup_printf")]
	public ref string! to_string (string! format = "%llu");
}

[CCode (cname = "float", cheader_filename = "glib.h", type_id = "G_TYPE_FLOAT", marshaller_type_name = "FLOAT", get_value_function = "g_value_get_float", set_value_function = "g_value_set_float")]
[FloatingType (rank = 1)]
public struct float {
}

[CCode (cname = "double", cheader_filename = "glib.h", type_id = "G_TYPE_DOUBLE", marshaller_type_name = "DOUBLE", get_value_function = "g_value_get_double", set_value_function = "g_value_set_double")]
[FloatingType (rank = 2)]
public struct double {
}

[CCode (cname = "gunichar", cheader_filename = "glib.h", get_value_function = "g_value_get_int", set_value_function = "g_value_set_int")]
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

[ReferenceType (dup_function = "g_strdup", free_function = "g_free", type_id = "G_TYPE_STRING")]
[CCode (cname = "char", const_cname = "const char", cheader_filename = "stdlib.h,string.h,glib.h", type_id = "G_TYPE_STRING", marshaller_type_name = "STRING", get_value_function = "g_value_get_string", set_value_function = "g_value_set_string")]
public struct string {
	[CCode (cname = "g_strstr")]
	public string str (string! needle);
	[CCode (cname = "g_str_has_prefix")]
	public bool has_prefix (string! prefix);
	[CCode (cname = "g_str_has_suffix")]
	public bool has_suffix (string! suffix);
	[CCode (cname = "g_strdup_printf")]
	[PrintfFormat ()]
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
	[CCode (cname = "g_utf8_strreverse")]
	public string reverse (int len = -1);
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
	
	/* The Main Event Loop */
	
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
		public Source find_source_by_id (uint source_id);
		public Source find_source_by_user_data (pointer user_data);
		public Source find_source_by_funcs_user_data (SourceFuncs funcs, pointer user_data);
		public void wakeup ();
		public bool acquire ();
		public void release ();
		public bool is_owner ();
		public bool wait (Cond cond, Mutex mutex);
		public bool prepare (ref int priority);
		[NoArrayLength ()]
		public int query (int max_priority, ref int timeout_, PollFD[] fds, int n_fds);
		public int check (int max_priority, PollFD[] fds, int n_fds);
		public void dispatch ();
		public void set_poll_func (PollFunc func);
		public PollFunc get_poll_func ();
		public void add_poll (ref PollFD fd, int priority);
		public void remove_poll (ref PollFD fd);
		public int depth ();
		public Source current_source ();
	}
	
	public callback int PollFunc (PollFD[] ufds, uint nfsd, int timeout_);
	
	public struct TimeoutSource : Source {
		public construct (uint interval);
	}

	public struct Timeout {
		public static uint add (uint interval, SourceFunc function, pointer data);
		public static uint add_full (int priority, uint interval, SourceFunc function, pointer data, DestroyNotify notify);
	}
	
	[ReferenceType ()]
	public struct IdleSource : Source {
		public construct ();
	}

	public struct Idle {
		public static uint add (SourceFunc function, pointer data);
		public static uint add_full (int priority, SourceFunc function, pointer data, DestroyNotify notify);
		public static bool remove_by_data (pointer data);
	}
	
	public struct Pid {
	}
	
	public callback void ChildWatchFunc (Pid pid, int status, pointer data);
	
	[ReferenceType ()]
	public struct ChildWatchSource : Source {
		public construct (Pid pid, int status, pointer data);
	}
	
	public struct ChildWatch {
		public static uint add (Pid pid, ChildWatchFunc function, pointer data);
		public static uint add_full (int priority, Pid pid, ChildWatchFunc function, pointer data, DestroyNotify notify);
	}
	
	public struct PollFD {
	}
	
	[ReferenceType (dup_function = "g_source_ref", free_function = "g_source_unref")]
	public struct Source {
		public construct (SourceFuncs source_funcs, uint struct_size);
		public void set_funcs (SourceFuncs funcs);
		public uint attach (MainContext context);
		public void destroy ();
		public bool is_destroyed ();
		public void set_priority (int priority);
		public int get_priority ();
		public void set_can_recurse (bool can_recurse);
		public bool get_can_recurse ();
		public uint get_id ();
		public MainContext get_context ();
		public void set_callback (SourceFunc func, pointer data, DestroyNotify notify);
		public void set_callback_indirect (pointer callback_data, SourceCallbackFuncs callback_funcs);
		public void add_poll (ref PollFD fd);
		public void remove_poll (ref PollFD fd);
		public void get_current_time (ref TimeVal timeval);
		public static void remove (uint id);
		public static bool remove_by_funcs_user_data (pointer user_data);
		public static bool remove_by_user_data (pointer user_data);
	}
	
	public callback void SourceDummyMarshal ();
	
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
	
	public callback void SourceCallbackRefFunc (pointer cb_data);
	public callback void SourceCallbackUnrefFunc (pointer cb_data);
	public callback void SourceCallbackGetFunc (pointer cb_data, Source source, SourceFunc func, pointer data);
	
	[ReferenceType ()]
	public struct SourceCallbackFuncs {
		public SourceCallbackRefFunc @ref;
		public SourceCallbackUnrefFunc unref;
		public SourceCallbackGetFunc @get;
	}
	
	public callback bool SourceFunc (pointer data);
	
	/* Thread support */
	[ReferenceType ()]
	public struct ThreadFunctions {
	}
	
	public callback pointer ThreadFunc (pointer data);
	public callback void Func (pointer data, pointer user_data);
	
	public enum ThreadPriority {
		LOW,
		NORMAL,
		HIGH,
		URGENT
	}
	
	[ReferenceType ()]
	public struct Thread {
		public static void init (ThreadFunctions vtable = null);
		public static bool supported ();
		public static Thread create (ThreadFunc func, pointer data, bool joinable, out Error error);
		public static Thread create_full (ThreadFunc func, pointer data, ulong stack_size, bool joinable, bool bound, ThreadPriority priority, out Error error);
		public static Thread self ();
		public pointer join ();
		public void set_priority (ThreadPriority priority);
		public static void yield ();
		public static void exit (pointer retval);
		public static void @foreach (Func thread_func, pointer user_data);
		
		[CCode (cname = "g_usleep")]
		public static void usleep (ulong microseconds);
	}
	
	[ReferenceType (free_function = "g_mutex_free")]
	public struct Mutex {
		public construct ();
		public void @lock ();
		public bool try_lock ();
		public void unlock ();
	}
	
	[ReferenceType (free_function = "g_cond_free")]
	public struct Cond {
		public construct ();
		public void @signal ();
		public void broadcast ();
		public void wait (Mutex mutex);
		public bool timed_wait (Mutex mutex, TimeVal abs_time);
	}
	
	/* Thread Pools */
	
	[ReferenceType (free_function = "g_thread_pool_free")]
	public struct ThreadPool {
		public construct (Func func, pointer user_data, int max_threads, bool exclusive, out Error error);
		public void push (pointer data, out Error error);
		public void set_max_threads (int max_threads, out Error error);
		public int get_max_threads ();
		public uint get_num_threads ();
		public uint unprocessed ();
		public static void set_max_unused_threads (int max_threads);
		public static int get_max_unused_threads ();
		public static uint get_num_unused_threads ();
		public static void stop_unused_threads ();
		public void set_sort_function (CompareDataFunc func, pointer user_data);
		public static void set_max_idle_time (uint interval);
		public static uint get_max_idle_time ();
	}
	
	/* Asynchronous Queues */
	
	[ReferenceType (dup_function = "g_async_queue_ref", free_function = "g_async_queue_unref")]
	public struct AsyncQueue {
		public construct ();
		public void push (pointer data);
		public void push_sorted (pointer data, CompareDataFunc func, pointer user_data);
		public pointer pop ();
		public pointer try_pop ();
		public pointer timed_pop (ref TimeVal end_time);
		public int length ();
		public void sort (CompareDataFunc func, pointer user_data);
		public void @lock ();
		public void unlock ();
		public void ref_unlocked ();
		public void unref_and_unlock ();
		public void push_unlocked (pointer data);
		public void push_sorted_unlocked (pointer data, CompareDataFunc func, pointer user_data);
		public pointer pop_unlocked ();
		public pointer try_pop_unlocked ();
		public pointer timed_pop_unlocked (ref TimeVal end_time);
		public int length_unlocked ();
		public void sort_unlocked (CompareDataFunc func, pointer user_data);
	}
	
	/* Dynamic Loading of Modules */
	
	[ReferenceType (free_function = "g_module_close")]
	public struct Module {
		public static bool supported ();
		public static ref string build_path (string directory, string module_name);
		public static ref Module open (string file_name, ModuleFlags @flags);
		public bool symbol (string! symbol_name, ref pointer symbol);
		public string name ();
		public void make_resident ();
		public string error ();
	}
	
	[CCode (cprefix = "G_MODULE_")]
	public enum ModuleFlags {
		BIND_LAZY,
		BIND_LOCAL,
		BIND_MASK
	}
	
	/* Memory Allocation */
	
	public static pointer malloc (ulong n_bytes);
	public static pointer malloc0 (ulong n_bytes);
	public static pointer realloc (pointer mem, ulong n_bytes);

	public static pointer try_malloc (ulong n_bytes);
	public static pointer try_malloc0 (ulong n_bytes);
	public static pointer try_realloc (pointer mem, ulong n_bytes);
	
	public static void free (pointer mem);
	
	/* IO Channels */
	
	[ReferenceType (dup_function = "g_io_channel_ref", free_function = "g_io_channel_unref")]
	public struct IOChannel {
		public construct file (string! filename, string! mode, out Error error);
		public IOStatus read_chars (string! buf, ulong count, ref ulong bytes_read, out Error error);
		public IOStatus read_unichar (ref unichar thechar, out Error error);
		public IOStatus read_line (out string str_return, ref ulong length, ref ulong terminator_pos, out Error error);
		public IOStatus read_line_string (String! buffer, ref ulong terminator_pos, out Error error);
		public IOStatus read_to_end (out string str_return, ref ulong length, out Error error);
		public IOStatus write_chars (string! buf, long count, ref ulong bytes_written, out Error error);
		public IOStatus write_unichar (unichar thechar, out Error error);
		public IOStatus flush (out Error error);
		public IOStatus seek_position (int64 offset, SeekType type, out Error error);
		public IOStatus shutdown (bool flush, out Error error);
	}
	
	[CCode (cprefix = "G_SEEK_")]
	public enum SeekType {
		CUR,
		SET,
		END
	}
	
	public enum IOStatus {
		ERROR,
		NORMAL,
		EOF,
		AGAIN
	}
	
	/* Error Reporting */

	[ReferenceType ()]
	public struct Error {
		public int code;
		public string message;
	}
	
	/* Message Output and Debugging Functions */
	
	public static void return_if_fail (bool expr);
	public static void assert (bool expr);
	public static void assert_not_reached ();
	
	/* Character Set Conversions */
	
	public static ref string convert (string! str, long len, string! to_codeset, string! from_codeset, ref int bytes_read, ref int bytes_written, out Error error);
	
	public struct Filename {
		public static ref string from_uri (string! uri, out string hostname = null, out Error error = null);
		public static ref string to_uri (string! filename, string hostname = null, out Error error = null);
		public static ref string display_basename (string! filename);
	}
	
	/* Base64 Encoding */
	
	public struct Base64 {
		public static int encode_step (string! _in, int len, bool break_lines, string _out, ref int state, ref int save);
		public static int encode_close (bool break_lines, string _out, ref int state, ref int save);
		public static ref string encode (string! data, int len);
		public static int decode_step (string! _in, int len, ref int state, ref uint save);
		public static ref string decode (string! text, ref ulong out_len);
	}
	
	/* Date and Time Functions */
	
	[ReferenceType (free_function = "g_free")]
	public struct TimeVal {
		[CCode (cname = "g_get_current_time")]
		public void get_current_time ();
		public void add (long microseconds);
		[InstanceLast ()]
		public bool from_iso8601 (string iso_date);
		public string to_iso8601 ();
		
	}
	
	/* Random Numbers */
	
	[ReferenceType (dup_function = "g_rand_copy", free_function = "g_rand_free")]
	public struct Rand {
		public construct with_seed (uint32 seed);
		[NoArrayLength ()]
		public construct with_seed_array (uint32[] seed, uint seed_length);
		public construct ();
		public void set_seed (uint32 seed);
		[NoArrayLength ()]
		public void set_seed_array (uint32[] seed, uint seed_length);
		public bool boolean ();
		public uint32 @int ();
		public int32 int_range (int32 begin, int32 end);
		public double @double ();
		public double double_range (double begin, double end);
	}
	
	public struct Random {
		public static void set_seed (uint32 seed);
		public static bool boolean ();
		public static uint32 @int ();
		public static int32 int_range (int32 begin, int32 end);
		public static double @double ();
		public static double double_range (double begin, double end);
	}
	
	/* Miscellaneous Utility Functions */
	
	public struct Environment {
		[CCode (cname = "g_get_application_name")]
		public static string get_application_name ();
		[CCode (cname = "g_set_application_name")]
		public static void set_application_name (string application_name);
		[CCode (cname = "g_getenv")]
		public static string get_variable (string! variable);
		[CCode (cname = "g_setenv")]
		public static bool set_variable (string! variable, string! value, bool overwrite);
		[CCode (cname = "g_get_user_name")]
		public static string get_user_name ();
		[CCode (cname = "g_get_host_name")]
		public static string! get_host_name ();
		[CCode (cname = "g_get_home_dir")]
		public static string get_home_dir ();
		[CCode (cname = "g_get_current_dir")]
		public static ref string get_current_dir ();
	}
	
	public struct Path {
		public static bool is_absolute (string! file_name);
		public static string skip_root (string! file_name);
		public static ref string get_basename (string file_name);
		public static ref string get_dirname (string file_name);
		[CCode (cname = "g_build_filename")]
		public static ref string build_filename (string first_element, ...);
	}
	
	/* Lexical Scanner */
	
	[ReferenceType (free_function = "g_scanner_destroy")]
	public struct Scanner {
	}
	
	/* Spawning Processes */
	
	public enum SpawnError {
		FORK,
		READ,
		CHDIR,
		ACCES,
		PERM,
		TOOBIG,
		NOEXEC,
		NAMETOOLONG,
		NOENT,
		NOMEM,
		NOTDIR,
		LOOP,
		TXTBUSY,
		IO,
		NFILE,
		MFILE,
		INVAL,
		ISDIR,
		LIBBAD,
		FAILED
	}
	
	[CCode (cprefix = "G_SPAWN_")]
	public enum SpawnFlags {
		LEAVE_DESCRIPTOR_OPEN,
		DO_NOT_REAP_CHILD,
		SEARCH_PATH,
		STDOUT_TO_DEV_NULL,
		STDERR_TO_DEV_NULL,
		CHILS_INHERITS_STDIN,
		FILE_AND_ARGV_ZERO
	}
	
	public callback void SpawnChildSetupFunc (pointer user_data);
	
	[CCode (cprefix = "g_")]
	public struct Process {
		public static bool spawn_async_with_pipes (string working_directory, string[] argv, string[] envp, SpawnFlags _flags, SpawnChildSetupFunc child_setup, pointer user_data, Pid child_pid, ref int standard_input, ref int standard_output, ref int standard_error, out Error error);
		public static bool spawn_async (string working_directory, string[] argv, string[] envp, SpawnFlags _flags, SpawnChildSetupFunc child_setup, pointer user_data, Pid child_pid, out Error error);
		public static bool spawn_sync (string working_directory, string[] argv, string[] envp, SpawnFlags _flags, SpawnChildSetupFunc child_setup, pointer user_data, out string standard_output, out string standard_error, ref int exit_status, out Error error);
		public static bool spawn_command_line_async (string! command_line, out Error error);
		public static bool spawn_command_line_sync (string! command_line, out string standard_output, out string standard_error, ref int exit_status, out Error error);
		public static void close_pid (Pid pid);
	}
	
	/* File Utilities */

	public enum FileTest {
		IS_REGULAR,
		IS_SYMLINK,
		IS_DIR,
		IS_EXECUTABLE,
		EXISTS
	}
	
	[ReferenceType (free_function = "fclose")]
	[CCode (cname = "FILE", cheader_filename = "stdio.h,glib/gstdio.h")]
	public struct File {
		[CCode (cname = "fopen")]
		public static ref File open (string path, string mode);
		[CCode (cname = "fdopen")]
		public static ref File fdopen (int fildes, string mode);
		[CCode (cname = "fprintf")]
		[PrintfFormat ()]
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

	/* Commandline option parser */

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
	
	/* Simple XML Subset Parser */
	
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
	
	/* Key-value file parser */
	
	[ReferenceType (free_function = "g_key_file_free")]
	public struct KeyFile {
		public construct ();
		public void set_list_separator (char separator);
		public bool load_from_file (string! file, KeyFileFlags @flags, out Error error);
		public bool load_from_data (string! data, ulong length, KeyFileFlags @flags, out Error error);
		public bool load_from_data_dirs (string! file, out string full_path, KeyFileFlags @flags, out Error error);
		public string to_data (ref ulong length, out Error error);
		public string get_start_group ();
		public ref string[] get_groups (ref ulong length);
		public ref string[] get_keys (string! group_name, ref ulong length, out Error error);
		public bool has_group (string! group_name);
		public bool has_key (string! group_name, string! key, out Error error);
		public ref string get_value (string! group_name, string! key, out Error error);
		public ref string get_string (string! group_name, string! key, out Error error);
		public ref string get_locale_string (string! group_name, string! key, string! locale, out Error error);
		public bool get_boolean (string! group_name, string! key, out Error error);
		public int get_integer (string! group_name, string! key, out Error error);
		public double get_double (string! group_name, string! key, out Error error);
		public ref string[] get_string_list (string! group_name, string! key, ref ulong length, out Error error);
		public ref string[] get_locale_string_list (string! group_name, string! key, string! locale, ref ulong length, out Error error);
		public ref bool[] get_boolean_list (string! group_name, string! key, ref ulong length, out Error error);
		public ref int[] get_integer_list (string! group_name, string! key, ref ulong length, out Error error);
		public ref double[] get_double_list (string! group_name, string! key, ref ulong length, out Error error);
		public ref string get_comment (string! group_name, string! key, out Error error);
		public void set_value (string! group_name, string! key, string! value, out Error error);
		public void set_string (string! group_name, string! key, string! string, out Error error);
		public void set_locale_string (string! group_name, string! key, string! locale, string! string, out Error error);
		public void set_boolean (string! group_name, string! key, bool value, out Error error);
		public void set_integer (string! group_name, string! key, int value, out Error error);
		public void set_double (string! group_name, string! key, double value, out Error error);
		public void set_string_list (string! group_name, string! key);
		public void set_locale_string_list (string! group_name, string! key, string! locale);
		public void set_boolean_list (string! group_name, string! key, bool[] list, ulong length);
		public void set_integer_list (string! group_name, string! key, int[] list, ulong length);
		public void set_double_list (string! group_name, string! key, double[] list, ulong length);
		public void set_comment (string! group_name, string! key, string! comment, out Error error);
		public void remove_group (string! group_name, out Error error);
		public void remove_key (string! group_name, string! key, out Error error);
		public void remove_comment (string! group_name, string! key, out Error error);
	}
	
	[CCode (cprefix = "G_KEY_FILE_")]
	public enum KeyFileFlags {
		NONE,
		KEEP_COMMENTS,
		KEEP_TRANSLATIONS
	}
	
	/* Doubly-Linked Lists */
	
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
		public ref List<weak G> copy ();
		[ReturnsModifiedPointer ()]
		public void reverse ();
		[ReturnsModifiedPointer ()]
		public void sort (CompareFunc compare_func);
		[ReturnsModifiedPointer ()]
		public void concat (ref List<G> list2);
		
		public List<G> first ();
		public List<G> last ();
		public List<G> nth (uint n);
		public G nth_data (uint n);
		public List<G> nth_prev (uint n);
		
		public List<G> find_custom (G data, CompareFunc func);
		
		public List<G> find (G data);
		public int position (List<G> llink);
		public int index (G data);
		
		public G data;
		public List<G> next;
		public List<G> prev;
	}
	
	/* Singly-Linked Lists */
	
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
	
	public callback int CompareFunc (pointer a, pointer b);

	public callback int CompareDataFunc (pointer a, pointer b, pointer user_data);
	
	[CCode (cname = "strcmp")]
	public static GLib.CompareFunc strcmp;
	
	/* Hash Tables */
	
	[ReferenceType (dup_function = "g_hash_table_ref", free_function = "g_hash_table_unref")]
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
	
	[CCode (cname = "g_direct_hash")]
	public static GLib.HashFunc direct_hash;
	[CCode (cname = "g_direct_equal")]
	public static GLib.EqualFunc direct_equal;
	[CCode (cname = "g_str_hash")]
	public static GLib.HashFunc str_hash;
	[CCode (cname = "g_str_equal")]
	public static GLib.EqualFunc str_equal;
	[CCode (cname = "g_free")]
	public static GLib.DestroyNotify g_free;
	[CCode (cname = "g_object_unref")]
	public static GLib.DestroyNotify g_object_unref;
	
	/* Strings */
	
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
	
	/* Pointer Arrays */
	
	[ReferenceType (free_function = "g_ptr_array_free")]
	public struct PtrArray {
	}
	
	/* Quarks */
	
	public struct Quark {
		public static Quark from_string (string string);
		public string to_string ();
	}
	
	/* GArray */
	
	[ReferenceType ()]
	public struct Array<G> {
		public construct (bool zero_terminated, bool clear, uint element_size);
		[CCode (cname = "g_array_sized_new")]
		public construct sized (bool zero_terminated, bool clear, uint element_size, uint reserved_size);
		[ReturnsModifiedPointer ()]
		public void append_val (G value);
		[ReturnsModifiedPointer ()]
		public void append_vals (constpointer data, uint len);
		[ReturnsModifiedPointer ()]
		public void prepend_val (G value);
		[ReturnsModifiedPointer ()]
		public void prepend_vals (constpointer data, uint len);
		[ReturnsModifiedPointer ()]
		public void insert_val (uint index, G value);
		[ReturnsModifiedPointer ()]
		public void insert_vals (uint index, constpointer data, uint len);
		[ReturnsModifiedPointer ()]
		public void remove_index (uint index);
		[ReturnsModifiedPointer ()]
		public void remove_index_fast (uint index);
		[ReturnsModifiedPointer ()]
		public void remove_range (uint index, uint length);
		public void sort (CompareFunc compare_func);
		public void sort_with_data (CompareDataFunc compare_func, pointer user_data);
		[ReturnsModifiedPointer ()]
		public void set_size (uint length);
		public string free (bool free_segment);
	}
	
	/* GTree */
	
	public callback int TraverseFunc (pointer key, pointer value, pointer data);
	
	[CCode (c_prefix="C_")]
	public enum TraverseType {
		IN_ORDER,
		PRE_ORDER,
		POST_ORDER,
		LEVEL_ORDER
	}
	
	[ReferenceType (free_function = "g_tree_destroy")]
	public struct Tree<K,V> {
		public construct (CompareFunc key_compare_func);
		public construct with_data (CompareFunc key_compare_func, pointer key_compare_data);
		public construct full (CompareFunc key_compare_func, pointer key_compare_data, DestroyNotify key_destroy_func, DestroyNotify value_destroy_func);
		public void insert (K key, V value);
		public void replace (K key, V value);
		public int nnodes ();
		public int height ();
		public V lookup (K key);
		public bool lookup_extended (K lookup_key, K orig_key, V value);
		public void tree_foreach (TraverseFunc traverse_func, TraverseType traverse_type, pointer user_data);
		public V tree_search (CompareFunc search_func, pointer user_data);
		public bool remove (K key);
		public bool steal (K key);
	}
}
