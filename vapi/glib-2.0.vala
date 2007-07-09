/* glib-2.0.vala
 *
 * Copyright (C) 2006-2007  Jürg Billeter, Raffaele Sandrini
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

[CCode (cname = "gboolean", cheader_filename = "glib.h", type_id = "G_TYPE_BOOLEAN", marshaller_type_name = "BOOLEAN", get_value_function = "g_value_get_boolean", set_value_function = "g_value_set_boolean", default_value = "FALSE")]
public struct bool {
}

[CCode (cname = "gpointer", cheader_filename = "glib.h", type_id = "G_TYPE_POINTER", marshaller_type_name = "POINTER", get_value_function = "g_value_get_pointer", set_value_function = "g_value_set_pointer", default_value = "NULL")]
public struct pointer {
}

[CCode (cname = "gconstpointer", cheader_filename = "glib.h", type_id = "G_TYPE_POINTER", marshaller_type_name = "POINTER", get_value_function = "g_value_get_pointer", set_value_function = "g_value_set_pointer", default_value = "NULL")]
public struct constpointer {
}

[CCode (cname = "gchar", cprefix = "g_ascii_", cheader_filename = "glib.h", type_id = "G_TYPE_CHAR", marshaller_type_name = "CHAR", get_value_function = "g_value_get_char", set_value_function = "g_value_set_char", default_value = "\'\\0\'")]
[IntegerType (rank = 1)]
public struct char {
	[InstanceLast ()]
	[CCode (cname = "g_strdup_printf")]
	public string! to_string (string! format = "%hhi");
	public bool isalnum ();
	public bool isalpha ();
	public bool iscntrl ();
	public bool isdigit ();
	public bool isgraph ();
	public bool islower ();
	public bool isprint ();
	public bool ispunct ();
	public bool isspace ();
	public bool isupper ();
	public bool isxdigit ();
	public int digit_value ();
	public int xdigit_value ();
	public char tolower ();
	public char toupper ();
}

[CCode (cname = "guchar", cheader_filename = "glib.h", type_id = "G_TYPE_UCHAR", marshaller_type_name = "UCHAR", get_value_function = "g_value_get_uchar", set_value_function = "g_value_set_uchar", default_value = "\'\\0\'")]
[IntegerType (rank = 2)]
public struct uchar {
	[InstanceLast ()]
	[CCode (cname = "g_strdup_printf")]
	public string! to_string (string! format = "%hhu");
}

[CCode (cname = "gint", cheader_filename = "glib.h", type_id = "G_TYPE_INT", marshaller_type_name = "INT", get_value_function = "g_value_get_int", set_value_function = "g_value_set_int", default_value = "0")]
[IntegerType (rank = 9)]
public struct int {
	[CCode (cname = "G_MININT")]
	public static int MIN;
	[CCode (cname = "G_MAXINT")]
	public static int MAX;

	[InstanceLast ()]
	[CCode (cname = "g_strdup_printf")]
	public string! to_string (string! format = "%i");

	[CCode (cname = "CLAMP")]
	public int clamp (int low, int high);
}

[CCode (cname = "guint", cheader_filename = "glib.h", type_id = "G_TYPE_UINT", marshaller_type_name = "UINT", get_value_function = "g_value_get_uint", set_value_function = "g_value_set_uint", default_value = "0U")]
[IntegerType (rank = 10)]
public struct uint {
	[CCode (cname = "0")]
	public static uint MIN;
	[CCode (cname = "G_MAXUINT")]
	public static uint MAX;

	[InstanceLast ()]
	[CCode (cname = "g_strdup_printf")]
	public string! to_string (string! format = "%u");

	[CCode (cname = "CLAMP")]
	public uint clamp (uint low, uint high);
}

[CCode (cname = "gshort", cheader_filename = "glib.h", default_value = "0")]
[IntegerType (rank = 5)]
public struct short {
	[CCode (cname = "G_MINSHORT")]
	public static short MIN;
	[CCode (cname = "G_MAXSHORT")]
	public static short MAX;

	[InstanceLast ()]
	[CCode (cname = "g_strdup_printf")]
	public string! to_string (string! format = "%hi");
}

[CCode (cname = "gushort", cheader_filename = "glib.h", default_value = "0U")]
[IntegerType (rank = 6)]
public struct ushort {
	[CCode (cname = "0U")]
	public static ushort MIN;
	[CCode (cname = "G_MAXUSHORT")]
	public static ushort MAX;

	[InstanceLast ()]
	[CCode (cname = "g_strdup_printf")]
	public string! to_string (string! format = "%hu");
}

[CCode (cname = "glong", cheader_filename = "glib.h", type_id = "G_TYPE_LONG", marshaller_type_name = "LONG", get_value_function = "g_value_get_long", set_value_function = "g_value_set_long", default_value = "0L")]
[IntegerType (rank = 14)]
public struct long {
	[CCode (cname = "G_MINLONG")]
	public static long MIN;
	[CCode (cname = "G_MAXLONG")]
	public static long MAX;

	[InstanceLast ()]
	[CCode (cname = "g_strdup_printf")]
	public string! to_string (string! format = "%li");
}

[CCode (cname = "gulong", cheader_filename = "glib.h", type_id = "G_TYPE_ULONG", marshaller_type_name = "ULONG", get_value_function = "g_value_get_ulong", set_value_function = "g_value_set_ulong", default_value = "0UL")]
[IntegerType (rank = 15)]
public struct ulong {
	[CCode (cname = "0UL")]
	public static ulong MIN;
	[CCode (cname = "G_MAXULONG")]
	public static ulong MAX;

	[InstanceLast ()]
	[CCode (cname = "g_strdup_printf")]
	public string! to_string (string! format = "%lu");
}

[CCode (cname = "gint8", cheader_filename = "glib.h", type_id = "G_TYPE_CHAR", marshaller_type_name = "CHAR", get_value_function = "g_value_get_char", set_value_function = "g_value_set_char", default_value = "0")]
[IntegerType (rank = 3)]
public struct int8 {
	[CCode (cname = "G_MININT8")]
	public static int8 MIN;
	[CCode (cname = "G_MAXINT8")]
	public static int8 MAX;

	[CCode (cname = "g_strdup_printf"), InstanceLast]
	public string! to_string (string! format = "%hhi");
}

[CCode (cname = "guint8", cheader_filename = "glib.h", default_value = "0U")]
[IntegerType (rank = 4)]
public struct uint8 {
	[CCode (cname = "0U")]
	public static uint8 MIN;
	[CCode (cname = "G_MAXUINT8")]
	public static uint8 MAX;

	[CCode (cname = "g_strdup_printf"), InstanceLast]
	public string! to_string (string! format = "%hhu");
}

[CCode (cname = "gint16", cheader_filename = "glib.h", default_value = "0")]
[IntegerType (rank = 7)]
public struct int16 {
	[CCode (cname = "G_MININT16")]
	public static int16 MIN;
	[CCode (cname = "G_MAXINT16")]
	public static int16 MAX;

	[CCode (cname = "g_strdup_printf"), InstanceLast]
	public string! to_string (string! format = "%hi");
}

[CCode (cname = "guint16", cheader_filename = "glib.h", default_value = "0U")]
[IntegerType (rank = 8)]
public struct uint16 {
	[CCode (cname = "0U")]
	public static uint16 MIN;
	[CCode (cname = "G_MAXUINT16")]
	public static uint16 MAX;

	[CCode (cname = "g_strdup_printf"), InstanceLast]
	public string! to_string (string! format = "%hu");
}

[CCode (cname = "gint32", cheader_filename = "glib.h", default_value = "0")]
[IntegerType (rank = 11)]
public struct int32 {
	[CCode (cname = "G_MININT32")]
	public static int32 MIN;
	[CCode (cname = "G_MAXINT32")]
	public static int32 MAX;

	[CCode (cname = "g_strdup_printf"), InstanceLast]
	public string! to_string (string! format = "%i");
}

[CCode (cname = "guint32", cheader_filename = "glib.h", default_value = "0U")]
[IntegerType (rank = 12)]
public struct uint32 {
	[CCode (cname = "0U")]
	public static uint32 MIN;
	[CCode (cname = "G_MAXUINT32")]
	public static uint32 MAX;

	[InstanceLast ()]
	[CCode (cname = "g_strdup_printf")]
	public string! to_string (string! format = "%u");
}

[CCode (cname = "gint64", cheader_filename = "glib.h", type_id = "G_TYPE_INT64", marshaller_type_name = "INT64", get_value_function = "g_value_get_int64", set_value_function = "g_value_set_int64", default_value = "0LL")]
[IntegerType (rank = 16)]
public struct int64 {
	[CCode (cname = "G_MININT64")]
	public static int64 MIN;
	[CCode (cname = "G_MAXINT64")]
	public static int64 MAX;

	[InstanceLast ()]
	[CCode (cname = "g_strdup_printf")]
	public string! to_string (string! format = "%lli");
}

[CCode (cname = "guint64", cheader_filename = "glib.h", type_id = "G_TYPE_UINT64", marshaller_type_name = "UINT64", get_value_function = "g_value_get_uint64", set_value_function = "g_value_set_uint64", default_value = "0ULL")]
[IntegerType (rank = 17)]
public struct uint64 {
	[CCode (cname = "0ULL")]
	public static uint64 MIN;
	[CCode (cname = "G_MAXUINT64")]
	public static uint64 MAX;

	[InstanceLast ()]
	[CCode (cname = "g_strdup_printf")]
	public string! to_string (string! format = "%llu");
}

[CCode (cname = "float", cheader_filename = "glib.h,float.h,math.h", type_id = "G_TYPE_FLOAT", marshaller_type_name = "FLOAT", get_value_function = "g_value_get_float", set_value_function = "g_value_set_float", default_value = "0.0F")]
[FloatingType (rank = 1)]
public struct float {
	[CCode (cname = "FLT_MANT_DIG")]
	public static int MANT_DIG;
	[CCode (cname = "FLT_DIG")]
	public static int DIG;

	[CCode (cname = "FLT_MIN_EXP")]
	public static int MIN_EXP;
	[CCode (cname = "FLT_MAX_EXP")]
	public static int MAX_EXP;

	[CCode (cname = "FLT_MIN_10_EXP")]
	public static int MIN_10_EXP;
	[CCode (cname = "FLT_MAX_10_EXP")]
	public static int MAX_10_EXP;

	[CCode (cname = "FLT_EPSILON")]
	public static float EPSILON;
	[CCode (cname = "FLT_MIN")]
	public static float MIN;
	[CCode (cname = "FLT_MAX")]
	public static float MAX;

	[CCode (cname = "NAN")]
	public static float NAN;
	[CCode (cname = "INFINITY")]
	public static float INFINITY;

	[CCode (cname = "isnan")]
	public bool is_nan ();
	[CCode (cname = "isfinite")]
	public bool is_finite ();
	[CCode (cname = "isnormal")]
	public bool is_normal ();
	[CCode (cname = "isinf")]
	public int is_infinity ();

	[CCode (cname = "g_strdup_printf"), InstanceLast]
	public string! to_string (string! format = "%g");
}

[CCode (cname = "double", cheader_filename = "glib.h,float.h,math.h", type_id = "G_TYPE_DOUBLE", marshaller_type_name = "DOUBLE", get_value_function = "g_value_get_double", set_value_function = "g_value_set_double", default_value = "0.0")]
[FloatingType (rank = 2)]
public struct double {
	[CCode (cname = "DBL_MANT_DIG")]
	public static int MANT_DIG;
	[CCode (cname = "DBL_DIG")]
	public static int DIG;

	[CCode (cname = "DBL_MIN_EXP")]
	public static int MIN_EXP;
	[CCode (cname = "DBL_MAX_EXP")]
	public static int MAX_EXP;

	[CCode (cname = "DBL_MIN_10_EXP")]
	public static int MIN_10_EXP;
	[CCode (cname = "DBL_MAX_10_EXP")]
	public static int MAX_10_EXP;

	[CCode (cname = "DBL_EPSILON")]
	public static double EPSILON;
	[CCode (cname = "DBL_MIN")]
	public static double MIN;
	[CCode (cname = "DBL_MAX")]
	public static double MAX;

	[CCode (cname = "((double) NAN)")]
	public static double NAN;
	[CCode (cname = "((double) INFINITY)")]
	public static double INFINITY;

	[CCode (cname = "isnan")]
	public bool is_nan ();
	[CCode (cname = "isfinite")]
	public bool is_finite ();
	[CCode (cname = "isnormal")]
	public bool is_normal ();
	[CCode (cname = "isinf")]
	public int is_infinity ();

	[CCode (cname = "g_strdup_printf"), InstanceLast]
	public string! to_string (string! format = "%g");
}

[CCode (cname = "gunichar", cprefix = "g_unichar_", cheader_filename = "glib.h", get_value_function = "g_value_get_int", set_value_function = "g_value_set_int", default_value = "0U")]
[IntegerType (rank = 13)]
public struct unichar {
	public bool validate ();
	public bool isalnum ();
	public bool isalpha ();
	public bool iscntrl ();
	public bool isdigit ();
	public bool isgraph ();
	public bool islower ();
	public bool isprint ();
	public bool ispunct ();
	public bool isspace ();
	public bool isupper ();
	public bool isxdigit ();
	public bool istitle ();
	public bool isdefined ();
	public bool iswide ();
	public bool iswide_cjk ();
	public bool iszerowidth ();
	public unichar toupper ();
	public unichar tolower ();
	public unichar totitle ();
	public int digit_value ();
	public int xdigit_value ();
	public UnicodeType type ();
	public UnicodeBreakType break_type ();

	public int to_utf8 (string outbuf);
}

[CCode (cprefix = "G_UNICODE_")]
public enum UnicodeType {
	CONTROL,
	FORMAT,
	UNASSIGNED,
	PRIVATE_USE,
	SURROGATE,
	LOWERCASE_LETTER,
	MODIFIER_LETTER,
	OTHER_LETTER,
	TITLECASE_LETTER,
	UPPERCASE_LETTER,
	COMBINING_MARK,
	ENCLOSING_MARK,
	NON_SPACING_MARK,
	DECIMAL_NUMBER,
	LETTER_NUMBER,
	OTHER_NUMBER,
	CONNECT_PUNCTUATION,
	DASH_PUNCTUATION,
	CLOSE_PUNCTUATION,
	FINAL_PUNCTUATION,
	INITIAL_PUNCTUATION,
	OTHER_PUNCTUATION,
	OPEN_PUNCTUATION,
	CURRENCY_SYMBOL,
	MODIFIER_SYMBOL,
	MATH_SYMBOL,
	OTHER_SYMBOL,
	LINE_SEPARATOR,
	PARAGRAPH_SEPARATOR,
	SPACE_SEPARATOR
}

[CCode (cprefix = "G_UNICODE_BREAK_")]
public enum UnicodeBreakType {
	MANDATORY,
	CARRIAGE_RETURN,
	LINE_FEED,
	COMBINING_MARK,
	SURROGATE,
	ZERO_WIDTH_SPACE,
	INSEPARABLE,
	NON_BREAKING_GLUE,
	CONTINGENT,
	SPACE,
	AFTER,
	BEFORE,
	BEFORE_AND_AFTER,
	HYPHEN,
	NON_STARTER,
	OPEN_PUNCTUATION,
	CLOSE_PUNCTUATION,
	QUOTATION,
	EXCLAMATION,
	IDEOGRAPHIC,
	NUMERIC,
	INFIX_SEPARATOR,
	SYMBOL,
	ALPHABETIC,
	PREFIX,
	POSTFIX,
	COMPLEX_CONTEXT,
	AMBIGUOUS,
	UNKNOWN,
	NEXT_LINE,
	WORD_JOINER,
	HANGUL_L_JAMO,
	HANGUL_V_JAMO,
	HANGUL_T_JAMO,
	HANGUL_LV_SYLLABLE,
	HANGUL_LVT_SYLLABLE
}

[ReferenceType (dup_function = "g_strdup", free_function = "g_free", type_id = "G_TYPE_STRING")]
[CCode (cname = "char", const_cname = "const char", cheader_filename = "stdlib.h,string.h,glib.h", type_id = "G_TYPE_STRING", marshaller_type_name = "STRING", get_value_function = "g_value_get_string", set_value_function = "g_value_set_string")]
public struct string {
	[CCode (cname = "strstr")]
	public weak string str (string! needle);
	[CCode (cname = "g_str_has_prefix")]
	public bool has_prefix (string! prefix);
	[CCode (cname = "g_str_has_suffix")]
	public bool has_suffix (string! suffix);
	[CCode (cname = "g_strdup_printf"), PrintfFormat]
	public string printf (...);
	[CCode (cname = "g_strconcat")]
	public string concat (string string2, ...);
	[CCode (cname = "g_strndup")]
	public string ndup (ulong n); /* FIXME: only UTF-8 */
	[CCode (cname = "g_strcompress")]
	public string compress ();
	[CCode (cname = "g_strsplit")]
	[NoArrayLength]
	public string[] split (string! delimiter, int max_tokens = 0);
	[CCode (cname = "g_strsplit_set")]
	[NoArrayLength]
	public string[] split_set (string! delimiters, int max_tokens = 0);
	[CCode (cname = "g_strjoinv")]
	[NoArrayLength]
	public static string joinv (string! separator, string[] str_array);
	
	[CCode (cname = "g_utf8_next_char")]
	public weak string next_char ();
	[CCode (cname = "g_utf8_get_char")]
	public unichar get_char ();
	[CCode (cname = "g_utf8_get_char_validated")]
	public unichar get_char_validated (long max_len = -1);
	[CCode (cname = "g_utf8_offset_to_pointer")]
	[PlusOperator ()]
	public weak string offset (long offset);
	[CCode (cname = "g_utf8_pointer_to_offset")]
	public long pointer_to_offset (string pos);
	[CCode (cname = "g_utf8_prev_char")]
	public weak string prev_char ();
	[CCode (cname = "g_utf8_strlen")]
	public long len (long max = -1);
	[CCode (cname = "g_utf8_strchr")]
	public weak string chr (long len, unichar c);
	[CCode (cname = "g_utf8_strrchr")]
	public weak string rchr (long len, unichar c);
	[CCode (cname = "g_utf8_strreverse")]
	public string! reverse (int len = -1);
	[CCode (cname = "g_utf8_validate")]
	public bool validate (long max_len = -1, out string end = null);
	
	[CCode (cname = "g_utf8_strup")]
	public string up (long len = -1);
	[CCode (cname = "g_utf8_strdown")]
	public string down (long len = -1);
	[CCode (cname = "g_utf8_casefold")]
	public string casefold (long len = -1);
	[CCode (cname = "g_utf8_collate")]
	public int collate (string str2);

	[CCode (cname = "g_locale_to_utf8")]
	public string! locale_to_utf8 (long len, out ulong bytes_read, out ulong bytes_written, out GLib.Error error = null);
  
	[CCode (cname = "g_strchomp")]
	public weak string chomp();
	[CCode (cname = "g_strchug")]
	public weak string chug();
	
	[CCode (cname = "g_str_hash")]
	public uint hash ();
	
	[CCode (cname = "atoi")]
	public int to_int ();
	[CCode (cname = "g_ascii_strtoll")]
	public int64 to_int64 (out string endptr = null, int _base = 0);
	[CCode (cname = "strlen")]
	public long size ();

	[CCode (cname = "g_utf8_skip")]
	public static char[] skip;
}

[Import ()]
[CCode (cprefix = "G", lower_case_cprefix = "g_", cheader_filename = "glib.h")]
namespace GLib {
	public struct Type {
		[CCode (cname = "G_TYPE_IS_OBJECT")]
		public bool is_object ();
		[CCode (cname = "G_TYPE_IS_ABSTRACT")]
		public bool is_abstract ();
		[CCode (cname = "G_TYPE_IS_CLASSED")]
		public bool is_classed ();
		[CCode (cname = "G_TYPE_IS_DERIVABLE")]
		public bool is_derivable ();
		[CCode (cname = "G_TYPE_IS_DEEP_DERIVABLE")]
		public bool is_deep_derivable ();
		[CCode (cname = "G_TYPE_IS_DERIVED")]
		public bool is_derived ();
		[CCode (cname = "G_TYPE_IS_FUNDAMENTAL")]
		public bool is_fundamental ();
		[CCode (cname = "G_TYPE_IS_INSTANTIATABLE")]
		public bool is_instantiatable ();
		[CCode (cname = "G_TYPE_IS_INTERFACE")]
		public bool is_interface ();
		[CCode (cname = "G_TYPE_IS_VALUE_TYPE")]
		public bool is_value_type ();
		
		//public Type[] children (out uint n_children = null);
		public uint depth ();
		public static Type from_name (string! name);
		//public Type[] interfaces (out uint n_interfaces = null);
		public bool is_a (Type is_a_type);
		public string! name ();
		public Type parent ();
				
		public TypeClass class_ref ();
		
	}
	
	[ReferenceType]
	public struct TypeClass {
		[CCode (cname = "G_TYPE_FROM_CLASS")]
		public Type get_type ();
	}

	public interface TypePlugin {
	}

	public class TypeModule : TypePlugin {
		public bool use ();
		public void unuse ();
		public void set_name (string! name);
	}

	[ReferenceType ()]
	public struct ParamSpec {
	}
	
	[ReferenceType ()]
	public struct ObjectClass {
		public ParamSpec[] list_properties (out int n_properties);
	}
	
	public struct ObjectConstructParam {
	}

	[CCode (cheader_filename = "glib-object.h")]
	public class Object {
		[CCode (cname = "G_TYPE_FROM_INSTANCE")]
		public Type get_type ();
		public Object @ref ();
		public void unref ();
		public Object ref_sink ();
	}
	
	public class InitiallyUnowned : Object {
	}

	public /* static */ interface Boxed<G> {
		public abstract G copy ();
		public abstract void free ();
	}

	[ReferenceType (free_function = "g_free")]
	public struct Value {
		public weak Object get_object ();
	}
	
	public struct SignalInvocationHint {
		public uint signal_id;
		public Quark detail;
		public SignalFlags run_type;
	}
	
	[NoArrayLength ()]
	public static delegate bool SignalEmissionHook (SignalInvocationHint ihint, uint n_param_values, Value[] param_values, pointer data);
	
	[CCode (cprefix = "G_SIGNAL_")]
	public enum SignalFlags {
		RUN_FIRST,
		RUN_LAST,
		RUN_CLEANUP,
		DETAILED,
		ACTION,
		NO_HOOKS
	}

	[CCode (cprefix = "G_CONNECT_")]
	public enum ConnectFlags {
		AFTER,
		SWAPPED
	}

	public static delegate void Callback ();
	
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
		public MainLoop (MainContext context, bool is_running);
		public void run ();
		public void quit ();
		public bool is_running ();
		public weak MainContext get_context ();
	}
	
	public enum Priority {
		HIGH,
		DEFAULT,
		HIGH_IDLE,
		DEFAULT_IDLE,
		LOW
	}
	
	[ReferenceType (dup_function = "g_main_context_ref", free_function = "g_main_context_unref")]
	public struct MainContext {
		public MainContext ();
		public static weak MainContext @default ();
		public bool iteration (bool may_block);
		public bool pending ();
		public weak Source find_source_by_id (uint source_id);
		public weak Source find_source_by_user_data (pointer user_data);
		public weak Source find_source_by_funcs_user_data (SourceFuncs funcs, pointer user_data);
		public void wakeup ();
		public bool acquire ();
		public void release ();
		public bool is_owner ();
		public bool wait (Cond cond, Mutex mutex);
		public bool prepare (out int priority);
		[NoArrayLength ()]
		public int query (int max_priority, out int timeout_, PollFD[] fds, int n_fds);
		public int check (int max_priority, PollFD[] fds, int n_fds);
		public void dispatch ();
		public void set_poll_func (PollFunc func);
		public PollFunc get_poll_func ();
		public void add_poll (ref PollFD fd, int priority);
		public void remove_poll (ref PollFD fd);
		public int depth ();
		public weak Source current_source ();
	}
	
	public static delegate int PollFunc (PollFD[] ufds, uint nfsd, int timeout_);
	
	public struct TimeoutSource : Source {
		public TimeoutSource (uint interval);
	}

	public struct Timeout {
		public static uint add (uint interval, SourceFunc function, pointer data);
		public static uint add_full (int priority, uint interval, SourceFunc function, pointer data, DestroyNotify notify);
	}
	
	[ReferenceType ()]
	public struct IdleSource : Source {
		public IdleSource ();
	}

	public struct Idle {
		public static uint add (SourceFunc function, pointer data);
		public static uint add_full (int priority, SourceFunc function, pointer data, DestroyNotify notify);
		public static bool remove_by_data (pointer data);
	}
	
	public struct Pid {
	}
	
	public static delegate void ChildWatchFunc (Pid pid, int status, pointer data);
	
	[ReferenceType ()]
	public struct ChildWatchSource : Source {
		public ChildWatchSource (Pid pid, int status, pointer data);
	}
	
	public struct ChildWatch {
		public static uint add (Pid pid, ChildWatchFunc function, pointer data);
		public static uint add_full (int priority, Pid pid, ChildWatchFunc function, pointer data, DestroyNotify notify);
	}
	
	public struct PollFD {
		public int fd;
		public IOCondition events;
		public IOCondition revents;
	}
	
	[ReferenceType (dup_function = "g_source_ref", free_function = "g_source_unref")]
	public struct Source {
		public Source (SourceFuncs source_funcs, uint struct_size /* = sizeof (Source) */);
		public void set_funcs (SourceFuncs funcs);
		public uint attach (MainContext context);
		public void destroy ();
		public bool is_destroyed ();
		public void set_priority (int priority);
		public int get_priority ();
		public void set_can_recurse (bool can_recurse);
		public bool get_can_recurse ();
		public uint get_id ();
		public weak MainContext get_context ();
		public void set_callback (SourceFunc func, pointer data, DestroyNotify notify);
		public void set_callback_indirect (pointer callback_data, SourceCallbackFuncs callback_funcs);
		public void add_poll (ref PollFD fd);
		public void remove_poll (ref PollFD fd);
		public void get_current_time (out TimeVal timeval);
		public static void remove (uint id);
		public static bool remove_by_funcs_user_data (pointer user_data);
		public static bool remove_by_user_data (pointer user_data);
	}
	
	public static delegate void SourceDummyMarshal ();
	
	public static delegate bool SourcePrepareFunc (Source source, out int timeout_);
	public static delegate bool SourceCheckFunc (Source source);
	public static delegate bool SourceDispatchFunc (Source source, SourceFunc _callback, pointer user_data);
	public static delegate void SourceFinalizeFunc (Source source);
	
	[ReferenceType ()]
	public struct SourceFuncs {
		public SourcePrepareFunc prepare;
		public SourceCheckFunc check;
		public SourceDispatchFunc dispatch;
		public SourceFinalizeFunc finalize;
	}
	
	public static delegate void SourceCallbackRefFunc (pointer cb_data);
	public static delegate void SourceCallbackUnrefFunc (pointer cb_data);
	public static delegate void SourceCallbackGetFunc (pointer cb_data, Source source, SourceFunc func, pointer data);
	
	[ReferenceType ()]
	public struct SourceCallbackFuncs {
		public SourceCallbackRefFunc @ref;
		public SourceCallbackUnrefFunc unref;
		public SourceCallbackGetFunc @get;
	}
	
	public static delegate bool SourceFunc (pointer data);
	
	/* Thread support */
	[ReferenceType ()]
	public struct ThreadFunctions {
	}
	
	public static delegate pointer ThreadFunc (pointer data);
	public static delegate void Func (pointer data, pointer user_data);
	
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
		public static weak Thread create (ThreadFunc func, pointer data, bool joinable, out Error error);
		public static weak Thread create_full (ThreadFunc func, pointer data, ulong stack_size, bool joinable, bool bound, ThreadPriority priority, out Error error);
		public static weak Thread self ();
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
		public Mutex ();
		public void @lock ();
		public bool try_lock ();
		public void unlock ();
	}
	
	[ReferenceType (free_function = "g_cond_free")]
	public struct Cond {
		public Cond ();
		public void @signal ();
		public void broadcast ();
		public void wait (Mutex mutex);
		public bool timed_wait (Mutex mutex, TimeVal abs_time);
	}
	
	/* Thread Pools */
	
	[ReferenceType (free_function = "g_thread_pool_free")]
	public struct ThreadPool {
		public ThreadPool (Func func, pointer user_data, int max_threads, bool exclusive, out Error error);
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
		public AsyncQueue ();
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
		public static string build_path (string directory, string module_name);
		public static Module open (string file_name, ModuleFlags @flags);
		public bool symbol (string! symbol_name, out pointer symbol);
		public weak string name ();
		public void make_resident ();
		public weak string error ();
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
		public IOChannel.file (string! filename, string! mode, out Error error);
		public IOStatus read_chars (string! buf, ulong count, out ulong bytes_read, out Error error);
		public IOStatus read_unichar (out unichar thechar, out Error error);
		public IOStatus read_line (out string str_return, out ulong length, out ulong terminator_pos, out Error error);
		public IOStatus read_line_string (String! buffer, out ulong terminator_pos, out Error error);
		public IOStatus read_to_end (out string str_return, out ulong length, out Error error);
		public IOStatus write_chars (string! buf, long count, out ulong bytes_written, out Error error);
		public IOStatus write_unichar (unichar thechar, out Error error);
		public IOStatus flush (out Error error);
		public IOStatus seek_position (int64 offset, SeekType type, out Error error);
		public IOStatus shutdown (bool flush, out Error error);
	}

	[CCode (cprefix = "G_IO_")]
	public enum IOCondition {
		IN,
		OUT,
		PRI,
		ERR,
		HUP,
		NVAL
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

	[ReferenceType (dup_function = "g_error_copy", free_function = "g_error_free")]
	public struct Error {
		public Error (Quark domain, int code, string! format, ...);
		public int code;
		public string message;
	}
	
	/* Message Output and Debugging Functions */
	
	public static void return_if_fail (bool expr);
	public static void assert (bool expr);
	public static void assert_not_reached ();

	/* Message Logging */
	
	[CCode (cprefix = "G_LOG_")]
	public enum LogLevelFlags {
		/* log flags */
		FLAG_RECURSION,
		FLAG_FATAL,

		/* GLib log levels */
		LEVEL_ERROR,
		LEVEL_CRITICAL,
		LEVEL_WARNING,
		LEVEL_MESSAGE,
		LEVEL_INFO,
		LEVEL_DEBUG,

		LEVEL_MASK
	}
	
	[Diagnostics]
	[PrintfFormat]
	public void log (string log_domain, LogLevelFlags log_level, string format, ...);
	
	[Diagnostics]
	[PrintfFormat]
	public void message (string format, ...);
	[Diagnostics]
	[PrintfFormat]
	public void warning (string format, ...);
	[Diagnostics]
	[PrintfFormat]
	public void critical (string format, ...);
	[Diagnostics]
	[PrintfFormat]
	public void error (string format, ...);
	[Diagnostics]
	[PrintfFormat]
	public void debug (string format, ...);
	
	/* Character Set Conversions */
	
	public static string convert (string! str, long len, string! to_codeset, string! from_codeset, out int bytes_read, out int bytes_written, out Error error);

	public struct IConv {
		[CCode (cname = "g_iconv_open")]
		public Iconv (string to_codeset, string from_codeset);
		[CCode (cname = "g_iconv")]
		public uint iconv (out string inbuf, out uint inbytes_left, out string outbuf, out uint outbytes_left);
		public int close ();
	}

	public struct Filename {
		public static string from_uri (string! uri, out string hostname = null, out Error error = null);
		public static string to_uri (string! filename, string hostname = null, out Error error = null);
		public static string display_basename (string! filename);
	}
	
	/* Base64 Encoding */
	
	public struct Base64 {
		public static int encode_step (string! _in, int len, bool break_lines, string _out, out int state, out int save);
		public static int encode_close (bool break_lines, string _out, out int state, out int save);
		public static string encode (string! data, int len);
		public static int decode_step (string! _in, int len, out int state, out uint save);
		public static string decode (string! text, out ulong out_len);
	}
	
	/* Date and Time Functions */
	
	public struct TimeVal {
		public long tv_sec;
		public long tv_usec;

		[CCode (cname = "g_get_current_time")]
		[InstanceByReference]
		public void get_current_time ();
		public void add (long microseconds);
		[InstanceByReference]
		[InstanceLast]
		public bool from_iso8601 (string iso_date);
		[InstanceByReference]
		public string! to_iso8601 ();
	}

	public struct DateDay : uchar {
		[CCode (cname = "G_DATE_BAD_DAY")]
		public static DateDay BAD_DAY;

		[CCode (cname = "g_date_valid_day")]
		public bool valid ();
	}

	[CCode (cprefix = "G_DATE_")]
	public enum DateMonth {
		BAD_MONTH,
		JANUARY,
		FEBRUARY,
		MARCH,
		APRIL,
		MAY,
		JUNE,
		JULY,
		AUGUST,
		SEPTEMBER,
		OCTOBER,
		NOVEMBER,
		DECEMBER

		// [CCode (cname = "g_date_get_days_in_month")]
		// public uchar get_days_in_month (DateYear year);
		// [CCode (cname = "g_date_valid_month")]
		// public bool valid (); 
	}

	public struct DateYear : ushort {
		[CCode (cname = "G_DATE_BAD_YEAR")]
		public static DateDay BAD_YEAR;

		[CCode (cname = "g_date_is_leap_year")]
		public bool is_leap_year ();
		[CCode (cname = "g_date_get_monday_weeks_in_year")]
		public uchar get_monday_weeks_in_year ();
		[CCode (cname = "g_date_get_sunday_weeks_in_year")]
		public uchar get_sunday_weeks_in_year ();
		[CCode (cname = "g_date_valid_year")]
		public bool valid ();
	}

	[CCode (cprefix = "G_DATE_")]
	public enum DateWeekday {
		BAD_WEEKDAY,
		MONDAY,
		TUESDAY,
		WEDNESDAY,
		THURSDAY,
		FRIDAY,
		SATURDAY,
		SUNDAY

		// [CCode (cname = "g_date_valid_weekday")]
		// public bool valid (); 
	}

	[ReferenceType (free_function = "g_date_free")]
	public struct Date {
		public Date ();
		public Date.dmy (DateDay day, DateMonth month, DateYear year);
		public Date.julian (uint julian_day);
		public void clear (uint n_dates = 1);
		public void set_day (DateDay day);
		public void set_month (DateMonth month);
		public void set_year (DateYear year);
		public void set_dmy (DateDay day, DateMonth month, DateYear y);
		public void set_julian (uint julian_day);
		public void set_time_val (TimeVal timeval);
		public void set_parse (string! str);
		public void add_days (uint n_days);
		public void subtract_days (uint n_days);
		public void add_months (uint n_months);
		public void subtract_months (uint n_months);
		public void add_years (uint n_years);
		public void subtract_years (uint n_years);
		public int days_between (Date! date2);
		public int compare (Date! rhs);
		public void clamp (Date min_date, Date max_date);
		public void order (Date! date2);
		public DateDay get_day ();
		public DateMonth get_month ();
		public DateYear get_year ();
		public uint get_julian ();
		public DateWeekday get_weekday ();
		public uint get_day_of_year ();
		public bool is_first_of_month ();
		public bool is_last_of_month ();
		public uint get_monday_week_of_year ();
		public uint get_sunday_week_of_year ();
		public uint get_iso8601_week_of_year ();
		public bool valid ();
		public static uchar get_days_in_month (DateMonth month, DateYear year);
		public static bool valid_day (DateDay day);
		public static bool valid_dmy (DateDay day, DateMonth month, DateYear year);
		public static bool valid_julian (uint julian_date);
		public static bool valid_weekday (DateWeekday weekday);
	}

	/* Random Numbers */
	
	[ReferenceType (dup_function = "g_rand_copy", free_function = "g_rand_free")]
	public struct Rand {
		public Rand.with_seed (uint32 seed);
		[NoArrayLength ()]
		public Rand.with_seed_array (uint32[] seed, uint seed_length);
		public Rand ();
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
		public static weak string get_application_name ();
		[CCode (cname = "g_set_application_name")]
		public static void set_application_name (string application_name);
		[CCode (cname = "g_getenv")]
		public static weak string get_variable (string! variable);
		[CCode (cname = "g_setenv")]
		public static bool set_variable (string! variable, string! value, bool overwrite);
		[CCode (cname = "g_get_user_name")]
		public static weak string get_user_name ();
		[CCode (cname = "g_get_host_name")]
		public static weak string! get_host_name ();
		[CCode (cname = "g_get_home_dir")]
		public static weak string get_home_dir ();
		[CCode (cname = "g_get_current_dir")]
		public static string get_current_dir ();
	}
	
	public struct Path {
		public static bool is_absolute (string! file_name);
		public static weak string skip_root (string! file_name);
		public static string get_basename (string file_name);
		public static string get_dirname (string file_name);
		[CCode (cname = "g_build_filename")]
		public static string build_filename (string first_element, ...);
	}

	public static class Bit {
		public static int nth_lsf (ulong mask, int nth_bit);
		public static int nth_msf (ulong mask, int nth_bit);
		public static uint storage (ulong number);
	}

	public static class SpacedPrimes {
		public static uint closest (uint num);
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
	
	public static delegate void SpawnChildSetupFunc (pointer user_data);
	
	[CCode (cprefix = "g_")]
	public struct Process {
		[NoArrayLength ()]
		public static bool spawn_async_with_pipes (string working_directory, string[] argv, string[] envp, SpawnFlags _flags, SpawnChildSetupFunc child_setup, pointer user_data, Pid child_pid, out int standard_input, out int standard_output, out int standard_error, out Error error);
		[NoArrayLength ()]
		public static bool spawn_async (string working_directory, string[] argv, string[] envp, SpawnFlags _flags, SpawnChildSetupFunc child_setup, pointer user_data, Pid child_pid, out Error error);
		[NoArrayLength ()]
		public static bool spawn_sync (string working_directory, string[] argv, string[] envp, SpawnFlags _flags, SpawnChildSetupFunc child_setup, pointer user_data, out string standard_output, out string standard_error, out int exit_status, out Error error);
		public static bool spawn_command_line_async (string! command_line, out Error error);
		public static bool spawn_command_line_sync (string! command_line, out string standard_output, out string standard_error, out int exit_status, out Error error);
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
	[CCode (cname = "FILE", cheader_filename = "stdio.h")]
	public struct FileStream {
		[CCode (cname = "fopen")]
		public static FileStream open (string path, string mode);
		[CCode (cname = "fdopen")]
		public static FileStream fdopen (int fildes, string mode);
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
	}

	[CCode (cprefix = "g_file_", cheader_filename = "glib/gstdio.h")]
	public struct FileUtils {
		public static bool get_contents (string! filename, out string contents, out long length, out Error error);
		public static bool set_contents (string! filename, string contents, long length, out Error error);
		public static bool test (string filename, FileTest test);
		public static int open_tmp (string tmpl, out string name_used, out Error error);
		public static string read_link (string filename, out Error error);
		
		[CCode (cname = "g_rename")]
		public static int rename (string oldfilename, string newfilename);
		[CCode (cname = "g_unlink")]
		public static int unlink (string filename);
		
		[CCode (cname = "symlink")]
		public static int symlink (string! oldpath, string! newpath);
	}

	[ReferenceType (free_function = "g_dir_close")]
	public struct Dir {
		public static Dir open (string filename, uint _flags, out Error error);
		public weak string read_name ();
		
		[CCode (cname = "g_mkdir")]
		public static int create (string pathname, int mode);
		[CCode (cname = "g_mkdir_with_parents")]
		public static int create_with_parents (string pathname, int mode);
	}
	
	[ReferenceType (free_function = "g_mapped_file_free")]
	public struct MappedFile {
		public MappedFile (string filename, bool writable, out Error error);
		public void free ();
		public long get_length ();
		[NoArrayLength]
		public weak char[] get_contents ();
	}
	
	[ReferenceType ()]
	[CCode (cname = "char", cheader_filename = "string.h")]
	public struct Memory {
		[CCode (cname = "memcmp")]
		[NoArrayLength ()]
		public static int cmp (char[] s1, char[] s2, long n);
	}
	
	[CCode (cname = "stdout", cheader_filename = "stdio.h")]
	public static FileStream stdout;
	
	[CCode (cname = "stderr", cheader_filename = "stdio.h")]
	public static FileStream stderr;

	/* Shell-related Utilities */

	public struct Shell {
		public static bool parse_argv (string! command_line, out int argcp, out string[] argvp, out Error error);
		public static string! quote (string! unquoted_string);
		public static string! unquote (string! quoted_string, out Error error);
	}

	/* Commandline option parser */

	[ReferenceType (free_function = "g_option_context_free")]
	public struct OptionContext {
		public OptionContext (string parameter_string);
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

	/* Perl-compatible regular expressions */

	public enum RegexError {
		COMPILE,
		OPTIMIZE,
		REPLACE,
		MATCH
	}

	[CCode (cprefix = "G_REGEX_")]
	public enum RegexCompileFlags {
		CASELESS,
		MULTILINE,
		DOTALL,
		EXTENDED,
		ANCHORED,
		DOLLAR_ENDONLY,
		UNGREEDY,
		RAW,
		NO_AUTO_CAPTURE,
		OPTIMIZE,
		DUPNAMES,
		NEWLINE_CR,
		NEWLINE_LF,
		NEWLINE_CRLF
	}

	[CCode (cprefix = "G_REGEX_MATCH_")]
	public enum RegexMatchFlags {
		ANCHORED,
		NOTBOL,
		NOTEOL,
		NOTEMPTY,
		PARTIAL,
		NEWLINE_CR,
		NEWLINE_LF,
		NEWLINE_CRLF,
		NEWLINE_ANY
	}

	[ReferenceType (dup_function = "g_regex_ref", free_function = "g_regex_unref")]
	public struct Regex {
		public Regex (string! pattern, RegexCompileFlags compile_options = 0, RegexMatchFlags match_options = 0, out Error error = null);
		public string! get_pattern ();
		public int get_max_backref ();
		public int get_capture_count ();
		public int get_string_number (string! name);
		public string! escape_string (string! string, int length = -1);
		public static bool match_simple (string! pattern, string! string, RegexCompileFlags compile_options = 0, RegexMatchFlags match_options = 0);
		public bool match (string! string, RegexMatchFlags match_options = 0, out MatchInfo match_info = null);
		public bool match_full (string! string, long string_len = -1, int start_position = 0, RegexMatchFlags match_options = 0, out MatchInfo match_info = null, out Error error = null);
		public bool match_all (string! string, RegexMatchFlags match_options = 0, out MatchInfo match_info = null);
		public bool match_all_full (string! string, long string_len = -1, int start_position = 0, RegexMatchFlags match_options = 0, out MatchInfo match_info = null, out Error error = null);
		[NoArrayLength]
		public static string[] split_simple (string! pattern, string! string, RegexCompileFlags compile_options = 0, RegexMatchFlags match_options = 0);
		[NoArrayLength]
		public string[] split (string! string, RegexMatchFlags match_options = 0);
		[NoArrayLength]
		public bool split_full (string! string, long string_len = -1, int start_position = 0, RegexMatchFlags match_options = 0, int max_tokens = 0, out Error error = null);
		public string replace (string! string, long string_len, int start_position, string! replacement, RegexMatchFlags match_options = 0, out Error error = null);
		public string replace_literal (string! string, long string_len, int start_position, string! replacement, RegexMatchFlags match_options = 0, out Error error = null);
		public string replace_eval (string! string, long string_len, int start_position, RegexMatchFlags match_options = 0, RegexEvalCallback eval, pointer user_data, out Error error = null);
		public static bool check_replacement (out bool has_references = null, out Error error = null);
	}

	public static delegate bool RegexEvalCallback (MatchInfo match_info, String result, pointer user_data);

	[ReferenceType (free_function = "g_match_info_free")]
	public struct MatchInfo {
		public weak Regex get_regex ();
		public weak string get_string ();
		public bool matches ();
		public bool next (out Error error = null);
		public int get_match_count ();
		public bool is_partial_match ();
		public string! expand_references (string! string_to_expand, out Error error = null);
		public string fetch (int match_num);
		public bool fetch_pos (int match_num, out int start_pos, out int end_pos);
		public weak string fetch_named (string! name);
		public bool fetch_named_pos (string! name, out int start_pos, out int end_pos);
		[NoArrayLength]
		public string[] fetch_all ();
	}

	/* Simple XML Subset Parser */
	
	[CCode (cprefix = "G_MARKUP_")]
	public enum MarkupParseFlags {
		TREAT_CDATA_AS_TEXT
	}
	
	[ReferenceType (free_function = "g_markup_parse_context_free")]
	public struct MarkupParseContext {
		public MarkupParseContext (MarkupParser parser, MarkupParseFlags _flags, pointer user_data, DestroyNotify user_data_dnotify);
		public bool parse (string text, long text_len, out Error error);
	}
	
	[NoArrayLength]
	public static delegate void MarkupParserStartElementFunc (MarkupParseContext context, string element_name, string[] attribute_names, string[] attribute_values, pointer user_data, out Error error);
	
	public static delegate void MarkupParserEndElementFunc (MarkupParseContext context, string element_name, pointer user_data, out Error error);
	
	public static delegate void MarkupParserTextFunc (MarkupParseContext context, string text, ulong text_len, pointer user_data, out Error error);
	
	public static delegate void MarkupParserPassthroughFunc (MarkupParseContext context, string passthrough_text, ulong text_len, pointer user_data, out Error error);
	
	public static delegate void MarkupParserErrorFunc (MarkupParseContext context, Error error, pointer user_data);
	
	[ReferenceType (free_function = "g_free")]
	public struct MarkupParser {
		public MarkupParserStartElementFunc start_element;
		public MarkupParserEndElementFunc end_element;
		public MarkupParserTextFunc text;
		public MarkupParserPassthroughFunc passthrough;
		public MarkupParserErrorFunc error;
	}

	public struct Markup {
		public static string! escape_text (string! text, long length = -1);
		[PrintfFormat]
		public static string! printf_escaped (string! format, ...);
	}

	/* Key-value file parser */
	
	[ReferenceType (free_function = "g_key_file_free")]
	public struct KeyFile {
		public KeyFile ();
		public void set_list_separator (char separator);
		public bool load_from_file (string! file, KeyFileFlags @flags, out Error error);
		public bool load_from_data (string! data, ulong length, KeyFileFlags @flags, out Error error);
		public bool load_from_data_dirs (string! file, out string full_path, KeyFileFlags @flags, out Error error);
		public string to_data (out ulong length, out Error error);
		public string get_start_group ();
		public string[] get_groups (out ulong length);
		public string[] get_keys (string! group_name, out ulong length, out Error error);
		public bool has_group (string! group_name);
		public bool has_key (string! group_name, string! key, out Error error);
		public string get_value (string! group_name, string! key, out Error error);
		public string get_string (string! group_name, string! key, out Error error);
		public string get_locale_string (string! group_name, string! key, string! locale, out Error error);
		public bool get_boolean (string! group_name, string! key, out Error error);
		public int get_integer (string! group_name, string! key, out Error error);
		public double get_double (string! group_name, string! key, out Error error);
		public string[] get_string_list (string! group_name, string! key, out ulong length, out Error error);
		public string[] get_locale_string_list (string! group_name, string! key, string! locale, out ulong length, out Error error);
		public bool[] get_boolean_list (string! group_name, string! key, out ulong length, out Error error);
		public int[] get_integer_list (string! group_name, string! key, out ulong length, out Error error);
		public double[] get_double_list (string! group_name, string! key, out ulong length, out Error error);
		public string get_comment (string! group_name, string! key, out Error error);
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
		public void append (G# data);
		[ReturnsModifiedPointer ()]
		public void prepend (G# data);
		[ReturnsModifiedPointer ()]
		public void insert (G# data, int position);
		[ReturnsModifiedPointer ()]
		public void insert_before (List<G> sibling, G# data);
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
		public List<weak G> copy ();
		[ReturnsModifiedPointer ()]
		public void reverse ();
		[ReturnsModifiedPointer ()]
		public void sort (CompareFunc compare_func);
		[ReturnsModifiedPointer ()]
		public void concat (List<G># list2);
		
		public weak List<G> first ();
		public weak List<G> last ();
		public weak List<G> nth (uint n);
		public weak G nth_data (uint n);
		public weak List<G> nth_prev (uint n);
		
		public weak List<G> find_custom (G data, CompareFunc func);
		
		public weak List<G> find (G data);
		public int position (List<G> llink);
		public int index (G data);
		
		public G data;
		public weak List<G> next;
		public weak List<G> prev;
	}
	
	/* Singly-Linked Lists */
	
	[ReferenceType (dup_function = "g_slist_copy", free_function = "g_slist_free")]
	public struct SList<G> {
		[ReturnsModifiedPointer ()]
		public void append (G# data);
		[ReturnsModifiedPointer ()]
		public void prepend (G# data);
		[ReturnsModifiedPointer ()]
		public void insert (G# data, int position);
		[ReturnsModifiedPointer ()]
		public void insert_before (SList<G> sibling, G# data);
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
		public SList<weak G> copy ();
		[ReturnsModifiedPointer ()]
		public void reverse ();
		[ReturnsModifiedPointer ()]
		public void sort (CompareFunc compare_func);
		[ReturnsModifiedPointer ()]
		public void concat (SList<G># list2);
		
		public weak SList<G> last ();
		public weak SList<G> nth (uint n);
		public weak G nth_data (uint n);
		
		public weak SList<G> find (G data);
		public weak SList<G> find_custom (G data, CompareFunc func);
		public int position (SList<G> llink);
		public int index (G data);
		
		public weak G data;
		public weak SList<G> next;
	}
	
	public static delegate int CompareFunc (pointer a, pointer b);

	public static delegate int CompareDataFunc (pointer a, pointer b, pointer user_data);
	
	[CCode (cname = "strcmp")]
	public static GLib.CompareFunc strcmp;
	
	/* Double-ended Queues */
	
	[ReferenceType (dup_function = "g_queue_copy", free_function = "g_queue_free")]
	public struct Queue<G> {
		public weak List<G> head;
		public weak List<G> tail;
		public uint length;
	
		public Queue ();
		
		public bool is_empty ();
		public uint get_length ();
		public void reverse ();
		public Queue copy ();
		public weak List<G> find (G data);
		public weak List<G> find_custom (G data, CompareFunc func);
		public void sort (CompareDataFunc compare_func, pointer user_data);
		public void push_head (G# data);
		public void push_tail (G# data);
		public void push_nth (G# data);
		public G pop_head ();
		public G pop_tail ();
		public G pop_nth ();
		public weak G peek_head ();
		public weak G peek_tail ();
		public weak G peek_nth ();
		public int index (G data);
		public void remove (G data);
		public void remove_all (G data);
		public void insert_before (List<G> sibling, G# data);
		public void insert_after (List<G> sibling, G# data);
		public void insert_sorted (List<G> sibling, G# data, CompareDataFunc func, pointer user_data);
	}
	
	/* Hash Tables */
	
	[ReferenceType (dup_function = "g_hash_table_ref", free_function = "g_hash_table_unref")]
	public struct HashTable<K,V> {
		public HashTable (HashFunc hash_func, EqualFunc key_equal_func);
		public HashTable.full (HashFunc hash_func, EqualFunc key_equal_func, DestroyNotify key_destroy_func, DestroyNotify value_destroy_func);
		public void insert (K# key, V# value);
		public void replace (K# key, V# value);
		public weak V lookup (K key);
		public bool remove (K key);
	}
	
	public static delegate uint HashFunc (pointer key);
	public static delegate bool EqualFunc (pointer a, pointer b);
	public static delegate void HFunc (pointer key, pointer value, pointer user_data);

	public static delegate void DestroyNotify (pointer data);
	
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
		public String (string init = "");
		[CCode (cname = "g_string_sized_new")]
		public String.sized (ulong dfl_size);
		public weak String assign (string! rval);
		public weak String append (string! val);
		public weak String append_c (char c);
		public weak String append_unichar (unichar wc);
		public weak String append_len (string! val, long len);
		public weak String prepend (string! val);
		public weak String prepend_c (char c);
		public weak String prepend_unichar (unichar wc);
		public weak String prepend_len (string! val, long len);
		public weak String insert (long pos, string! val);
		public weak String erase (long pos, long len);
		
		public string str;
		public long len;
		public long allocated_len;
	}
	
	/* Pointer Arrays */
	
	[ReferenceType (free_function = "g_ptr_array_free")]
	public struct PtrArray {
	}

	/* Byte Arrays */

	[ReferenceType (free_function = "g_byte_array_free")]
	public struct ByteArray {
	}

	/* Quarks */
	
	public struct Quark {
		public static Quark from_string (string string);
		public weak string to_string ();
	}
	
	/* GArray */
	
	[ReferenceType ()]
	public struct Array<G> {
		public Array (bool zero_terminated, bool clear, uint element_size);
		[CCode (cname = "g_array_sized_new")]
		public Array.sized (bool zero_terminated, bool clear, uint element_size, uint reserved_size);
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
	
	public static delegate int TraverseFunc (pointer key, pointer value, pointer data);
	
	[CCode (c_prefix="C_")]
	public enum TraverseType {
		IN_ORDER,
		PRE_ORDER,
		POST_ORDER,
		LEVEL_ORDER
	}
	
	[ReferenceType (free_function = "g_tree_destroy")]
	public struct Tree<K,V> {
		public Tree (CompareFunc key_compare_func);
		public Tree.with_data (CompareFunc key_compare_func, pointer key_compare_data);
		public Tree.full (CompareFunc key_compare_func, pointer key_compare_data, DestroyNotify key_destroy_func, DestroyNotify value_destroy_func);
		public void insert (K key, V value);
		public void replace (K key, V value);
		public int nnodes ();
		public int height ();
		public weak V lookup (K key);
		public bool lookup_extended (K lookup_key, K orig_key, V value);
		public void tree_foreach (TraverseFunc traverse_func, TraverseType traverse_type, pointer user_data);
		public weak V tree_search (CompareFunc search_func, pointer user_data);
		public bool remove (K key);
		public bool steal (K key);
	}
}
