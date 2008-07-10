/* glib-2.0.vala
 *
 * Copyright (C) 2006-2008  Jürg Billeter, Raffaele Sandrini
 * Copyright (C) 2007  Mathias Hasselmann
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
 * 	Jürg Billeter <j@bitron.ch>
 *	Raffaele Sandrini <rasa@gmx.ch>
 *	Mathias Hasselmann <mathias.hasselmann@gmx.de>
 */

[SimpleType]
[CCode (cname = "gboolean", cheader_filename = "glib.h", type_id = "G_TYPE_BOOLEAN", marshaller_type_name = "BOOLEAN", get_value_function = "g_value_get_boolean", set_value_function = "g_value_set_boolean", default_value = "FALSE", type_signature = "b")]
public struct bool {
	public string to_string () {
		if (this) {
			return "true";
		} else {
			return "false";
		}
	}
}

[SimpleType]
[CCode (cname = "gconstpointer", cheader_filename = "glib.h", type_id = "G_TYPE_POINTER", marshaller_type_name = "POINTER", get_value_function = "g_value_get_pointer", set_value_function = "g_value_set_pointer", default_value = "NULL")]
public struct constpointer {
}

[SimpleType]
[CCode (cname = "gchar", cprefix = "g_ascii_", cheader_filename = "glib.h", type_id = "G_TYPE_CHAR", marshaller_type_name = "CHAR", get_value_function = "g_value_get_char", set_value_function = "g_value_set_char", default_value = "\'\\0\'", type_signature = "y")]
[IntegerType (rank = 2, min = 0, max = 127)]
public struct char {
	[CCode (cname = "g_strdup_printf", instance_pos = -1)]
	public string to_string (string format = "%hhi");
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

	[CCode (cname = "MIN")]
	public static char min (char a, char b);
	[CCode (cname = "MAX")]
	public static char max (char a, char b);
	[CCode (cname = "CLAMP")]
	public char clamp (char low, char high);
}

[SimpleType]
[CCode (cname = "guchar", cheader_filename = "glib.h", type_id = "G_TYPE_UCHAR", marshaller_type_name = "UCHAR", get_value_function = "g_value_get_uchar", set_value_function = "g_value_set_uchar", default_value = "\'\\0\'")]
[IntegerType (rank = 3, min = 0, max = 255)]
public struct uchar {
	[CCode (cname = "g_strdup_printf", instance_pos = -1)]
	public string to_string (string format = "%hhu");

	[CCode (cname = "MIN")]
	public static uchar min (uchar a, uchar b);
	[CCode (cname = "MAX")]
	public static uchar max (uchar a, uchar b);
	[CCode (cname = "CLAMP")]
	public uchar clamp (uchar low, uchar high);
}

[SimpleType]
[CCode (cname = "gint", cheader_filename = "glib.h", type_id = "G_TYPE_INT", marshaller_type_name = "INT", get_value_function = "g_value_get_int", set_value_function = "g_value_set_int", default_value = "0", type_signature = "i")]
[IntegerType (rank = 6)]
public struct int {
	[CCode (cname = "G_MININT")]
	public static int MIN;
	[CCode (cname = "G_MAXINT")]
	public static int MAX;

	[CCode (cname = "g_strdup_printf", instance_pos = -1)]
	public string to_string (string format = "%i");

	[CCode (cname = "MIN")]
	public static int min (int a, int b);
	[CCode (cname = "MAX")]
	public static int max (int a, int b);
	[CCode (cname = "CLAMP")]
	public int clamp (int low, int high);

	[CCode (cname = "GINT_TO_POINTER")]
	public void* to_pointer ();
}

[SimpleType]
[CCode (cname = "guint", cheader_filename = "glib.h", type_id = "G_TYPE_UINT", marshaller_type_name = "UINT", get_value_function = "g_value_get_uint", set_value_function = "g_value_set_uint", default_value = "0U", type_signature = "u")]
[IntegerType (rank = 7)]
public struct uint {
	[CCode (cname = "0")]
	public static uint MIN;
	[CCode (cname = "G_MAXUINT")]
	public static uint MAX;

	[CCode (cname = "g_strdup_printf", instance_pos = -1)]
	public string to_string (string format = "%u");

	[CCode (cname = "MIN")]
	public static uint min (uint a, uint b);
	[CCode (cname = "MAX")]
	public static uint max (uint a, uint b);
	[CCode (cname = "CLAMP")]
	public uint clamp (uint low, uint high);

	[CCode (cname = "GUINT_TO_POINTER")]
	public void* to_pointer ();
}

[SimpleType]
[CCode (cname = "gshort", cheader_filename = "glib.h", default_value = "0", type_signature = "n")]
[IntegerType (rank = 4, min = -32768, max = 32767)]
public struct short {
	[CCode (cname = "G_MINSHORT")]
	public static short MIN;
	[CCode (cname = "G_MAXSHORT")]
	public static short MAX;

	[CCode (cname = "g_strdup_printf", instance_pos = -1)]
	public string to_string (string format = "%hi");

	[CCode (cname = "MIN")]
	public static short min (short a, short b);
	[CCode (cname = "MAX")]
	public static short max (short a, short b);
	[CCode (cname = "CLAMP")]
	public short clamp (short low, short high);
}

[SimpleType]
[CCode (cname = "gushort", cheader_filename = "glib.h", default_value = "0U", type_signature = "q")]
[IntegerType (rank = 5, min = 0, max = 65535)]
public struct ushort {
	[CCode (cname = "0U")]
	public static ushort MIN;
	[CCode (cname = "G_MAXUSHORT")]
	public static ushort MAX;

	[CCode (cname = "g_strdup_printf", instance_pos = -1)]
	public string to_string (string format = "%hu");

	[CCode (cname = "MIN")]
	public static ushort min (ushort a, ushort b);
	[CCode (cname = "MAX")]
	public static ushort max (ushort a, ushort b);
	[CCode (cname = "CLAMP")]
	public ushort clamp (ushort low, ushort high);
}

[SimpleType]
[CCode (cname = "glong", cheader_filename = "glib.h", type_id = "G_TYPE_LONG", marshaller_type_name = "LONG", get_value_function = "g_value_get_long", set_value_function = "g_value_set_long", default_value = "0L")]
[IntegerType (rank = 8)]
public struct long {
	[CCode (cname = "G_MINLONG")]
	public static long MIN;
	[CCode (cname = "G_MAXLONG")]
	public static long MAX;

	[CCode (cname = "g_strdup_printf", instance_pos = -1)]
	public string to_string (string format = "%li");

	[CCode (cname = "MIN")]
	public static long min (long a, long b);
	[CCode (cname = "MAX")]
	public static long max (long a, long b);
	[CCode (cname = "CLAMP")]
	public long clamp (long low, long high);
}

[SimpleType]
[CCode (cname = "gulong", cheader_filename = "glib.h", type_id = "G_TYPE_ULONG", marshaller_type_name = "ULONG", get_value_function = "g_value_get_ulong", set_value_function = "g_value_set_ulong", default_value = "0UL")]
[IntegerType (rank = 9)]
public struct ulong {
	[CCode (cname = "0UL")]
	public static ulong MIN;
	[CCode (cname = "G_MAXULONG")]
	public static ulong MAX;

	[CCode (cname = "g_strdup_printf", instance_pos = -1)]
	public string to_string (string format = "%lu");

	[CCode (cname = "MIN")]
	public static ulong min (ulong a, ulong b);
	[CCode (cname = "MAX")]
	public static ulong max (ulong a, ulong b);
	[CCode (cname = "CLAMP")]
	public ulong clamp (ulong low, ulong high);
}

[SimpleType]
[CCode (cname = "gsize", cheader_filename = "glib.h", type_id = "G_TYPE_ULONG", marshaller_type_name = "ULONG", get_value_function = "g_value_get_ulong", set_value_function = "g_value_set_ulong", default_value = "0UL")]
[IntegerType (rank = 9)]
public struct size_t {
	[CCode (cname = "0UL")]
	public static ulong MIN;
	[CCode (cname = "G_MAXSIZE")]
	public static ulong MAX;

	[CCode (cname = "G_GSIZE_FORMAT")]
	public const string FORMAT;
	[CCode (cname = "G_GSIZE_MODIFIER")]
	public const string FORMAT_MODIFIER;

	[CCode (cname = "g_strdup_printf", instance_pos = -1)]
	public string to_string (string format = "%zu");

	[CCode (cname = "GSIZE_TO_POINTER")]
	public void* to_pointer ();

	[CCode (cname = "MIN")]
	public static size_t min (size_t a, size_t b);
	[CCode (cname = "MAX")]
	public static size_t max (size_t a, size_t b);
	[CCode (cname = "CLAMP")]
	public size_t clamp (size_t low, size_t high);
}

[SimpleType]
[CCode (cname = "gssize", cheader_filename = "glib.h", type_id = "G_TYPE_LONG", marshaller_type_name = "LONG", get_value_function = "g_value_get_long", set_value_function = "g_value_set_long", default_value = "0L")]
[IntegerType (rank = 8)]
public struct ssize_t {
	[CCode (cname = "G_MINSSIZE")]
	public static long MIN;
	[CCode (cname = "G_MAXSSIZE")]
	public static long MAX;

	[CCode (cname = "G_GSSIZE_FORMAT")]
	public const string FORMAT;
	[CCode (cname = "G_GSIZE_MODIFIER")]
	public const string FORMAT_MODIFIER;

	[CCode (cname = "g_strdup_printf", instance_pos = -1)]
	public string to_string (string format = "%zi");

	[CCode (cname = "MIN")]
	public static ssize_t min (ssize_t a, ssize_t b);
	[CCode (cname = "MAX")]
	public static ssize_t max (ssize_t a, ssize_t b);
	[CCode (cname = "CLAMP")]
	public ssize_t clamp (ssize_t low, ssize_t high);
}

[SimpleType]
[CCode (cname = "gint8", cheader_filename = "glib.h", type_id = "G_TYPE_CHAR", marshaller_type_name = "CHAR", get_value_function = "g_value_get_char", set_value_function = "g_value_set_char", default_value = "0", type_signature = "y")]
[IntegerType (rank = 1, min = -128, max = 127)]
public struct int8 {
	[CCode (cname = "G_MININT8")]
	public static int8 MIN;
	[CCode (cname = "G_MAXINT8")]
	public static int8 MAX;

	[CCode (cname = "g_strdup_printf", instance_pos = -1)]
	public string to_string (string format = "%hhi");

	[CCode (cname = "MIN")]
	public static int8 min (int8 a, int8 b);
	[CCode (cname = "MAX")]
	public static int8 max (int8 a, int8 b);
	[CCode (cname = "CLAMP")]
	public int8 clamp (int8 low, int8 high);
}

[SimpleType]
[CCode (cname = "guint8", cheader_filename = "glib.h", type_id = "G_TYPE_UCHAR", marshaller_type_name = "UCHAR", get_value_function = "g_value_get_uchar", set_value_function = "g_value_set_uchar", default_value = "0U", type_signature = "y")]
[IntegerType (rank = 3, min = 0, max = 255)]
public struct uint8 {
	[CCode (cname = "0U")]
	public static uint8 MIN;
	[CCode (cname = "G_MAXUINT8")]
	public static uint8 MAX;

	[CCode (cname = "g_strdup_printf", instance_pos = -1)]
	public string to_string (string format = "%hhu");

	[CCode (cname = "MIN")]
	public static uint8 min (uint8 a, uint8 b);
	[CCode (cname = "MAX")]
	public static uint8 max (uint8 a, uint8 b);
	[CCode (cname = "CLAMP")]
	public uint8 clamp (uint8 low, uint8 high);
}

[SimpleType]
[CCode (cname = "gint16", cheader_filename = "glib.h", default_value = "0", type_signature = "n")]
[IntegerType (rank = 4, min = -32768, max = 32767)]
public struct int16 {
	[CCode (cname = "G_MININT16")]
	public static int16 MIN;
	[CCode (cname = "G_MAXINT16")]
	public static int16 MAX;

	[CCode (cname = "G_GINT16_FORMAT")]
	public const string FORMAT;
	[CCode (cname = "G_GINT16_MODIFIER")]
	public const string FORMAT_MODIFIER;

	[CCode (cname = "g_strdup_printf", instance_pos = -1)]
	public string to_string (string format = "%hi");

	[CCode (cname = "MIN")]
	public static int16 min (int16 a, int16 b);
	[CCode (cname = "MAX")]
	public static int16 max (int16 a, int16 b);
	[CCode (cname = "CLAMP")]
	public int16 clamp (int16 low, int16 high);
}

[SimpleType]
[CCode (cname = "guint16", cheader_filename = "glib.h", default_value = "0U", type_signature = "q")]
[IntegerType (rank = 5, min = 0, max = 65535)]
public struct uint16 {
	[CCode (cname = "0U")]
	public static uint16 MIN;
	[CCode (cname = "G_MAXUINT16")]
	public static uint16 MAX;

	[CCode (cname = "G_GUINT16_FORMAT")]
	public const string FORMAT;
	[CCode (cname = "G_GINT16_MODIFIER")]
	public const string FORMAT_MODIFIER;

	[CCode (cname = "g_strdup_printf", instance_pos = -1)]
	public string to_string (string format = "%hu");

	[CCode (cname = "MIN")]
	public static uint16 min (uint16 a, uint16 b);
	[CCode (cname = "MAX")]
	public static uint16 max (uint16 a, uint16 b);
	[CCode (cname = "CLAMP")]
	public uint16 clamp (uint16 low, uint16 high);
}

[SimpleType]
[CCode (cname = "gint32", cheader_filename = "glib.h", type_id = "G_TYPE_INT", marshaller_type_name = "INT", get_value_function = "g_value_get_int", set_value_function = "g_value_set_int", default_value = "0", type_signature = "i")]
[IntegerType (rank = 6)]
public struct int32 {
	[CCode (cname = "G_MININT32")]
	public static int32 MIN;
	[CCode (cname = "G_MAXINT32")]
	public static int32 MAX;

	[CCode (cname = "G_GINT32_FORMAT")]
	public const string FORMAT;
	[CCode (cname = "G_GINT32_MODIFIER")]
	public const string FORMAT_MODIFIER;

	[CCode (cname = "g_strdup_printf", instance_pos = -1)]
	public string to_string (string format = "%i");

	[CCode (cname = "MIN")]
	public static int32 min (int32 a, int32 b);
	[CCode (cname = "MAX")]
	public static int32 max (int32 a, int32 b);
	[CCode (cname = "CLAMP")]
	public int32 clamp (int32 low, int32 high);
}

[SimpleType]
[CCode (cname = "guint32", cheader_filename = "glib.h", type_id = "G_TYPE_UINT", marshaller_type_name = "UINT", get_value_function = "g_value_get_uint", set_value_function = "g_value_set_uint", default_value = "0U", type_signature = "u")]
[IntegerType (rank = 7)]
public struct uint32 {
	[CCode (cname = "0U")]
	public static uint32 MIN;
	[CCode (cname = "G_MAXUINT32")]
	public static uint32 MAX;

	[CCode (cname = "G_GUINT32_FORMAT")]
	public const string FORMAT;
	[CCode (cname = "G_GINT32_MODIFIER")]
	public const string FORMAT_MODIFIER;

	[CCode (cname = "g_strdup_printf", instance_pos = -1)]
	public string to_string (string format = "%u");

	[CCode (cname = "MIN")]
	public static uint32 min (uint32 a, uint32 b);
	[CCode (cname = "MAX")]
	public static uint32 max (uint32 a, uint32 b);
	[CCode (cname = "CLAMP")]
	public uint32 clamp (uint32 low, uint32 high);
}

[SimpleType]
[CCode (cname = "gint64", cheader_filename = "glib.h", type_id = "G_TYPE_INT64", marshaller_type_name = "INT64", get_value_function = "g_value_get_int64", set_value_function = "g_value_set_int64", default_value = "0LL", type_signature = "x")]
[IntegerType (rank = 10)]
public struct int64 {
	[CCode (cname = "G_MININT64")]
	public static int64 MIN;
	[CCode (cname = "G_MAXINT64")]
	public static int64 MAX;

	[CCode (cname = "G_GINT64_FORMAT")]
	public const string FORMAT;
	[CCode (cname = "G_GINT64_MODIFIER")]
	public const string FORMAT_MODIFIER;

	[CCode (cname = "g_strdup_printf", instance_pos = -1)]
	public string to_string (string format = "%lli");

	[CCode (cname = "MIN")]
	public static int64 min (int64 a, int64 b);
	[CCode (cname = "MAX")]
	public static int64 max (int64 a, int64 b);
	[CCode (cname = "CLAMP")]
	public int64 clamp (int64 low, int64 high);
}

[SimpleType]
[CCode (cname = "guint64", cheader_filename = "glib.h", type_id = "G_TYPE_UINT64", marshaller_type_name = "UINT64", get_value_function = "g_value_get_uint64", set_value_function = "g_value_set_uint64", default_value = "0ULL", type_signature = "t")]
[IntegerType (rank = 11)]
public struct uint64 {
	[CCode (cname = "0ULL")]
	public static uint64 MIN;
	[CCode (cname = "G_MAXUINT64")]
	public static uint64 MAX;

	[CCode (cname = "G_GUINT64_FORMAT")]
	public const string FORMAT;
	[CCode (cname = "G_GINT64_MODIFIER")]
	public const string FORMAT_MODIFIER;

	[CCode (cname = "g_strdup_printf", instance_pos = -1)]
	public string to_string (string format = "%llu");

	[CCode (cname = "MIN")]
	public static uint64 min (uint64 a, uint64 b);
	[CCode (cname = "MAX")]
	public static uint64 max (uint64 a, uint64 b);
	[CCode (cname = "CLAMP")]
	public uint64 clamp (uint64 low, uint64 high);
}

[SimpleType]
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

	[CCode (cname = "g_strdup_printf", instance_pos = -1)]
	public string to_string (string format = "%g");

	[CCode (cname = "MIN")]
	public static float min (float a, float b);
	[CCode (cname = "MAX")]
	public static float max (float a, float b);
	[CCode (cname = "CLAMP")]
	public float clamp (float low, float high);
}

[SimpleType]
[CCode (cname = "double", cheader_filename = "glib.h,float.h,math.h", type_id = "G_TYPE_DOUBLE", marshaller_type_name = "DOUBLE", get_value_function = "g_value_get_double", set_value_function = "g_value_set_double", default_value = "0.0", type_signature = "d")]
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

	[CCode (cname = "g_strdup_printf", instance_pos = -1)]
	public string to_string (string format = "%g");

	[CCode (cname = "MIN")]
	public static double min (double a, double b);
	[CCode (cname = "MAX")]
	public static double max (double a, double b);
	[CCode (cname = "CLAMP")]
	public double clamp (double low, double high);
}

[CCode (cheader_filename = "time.h")]
public struct time_t {
	[CCode (cname = "time")]
	public time_t ();
}

[SimpleType]
[CCode (cname = "gunichar", cprefix = "g_unichar_", cheader_filename = "glib.h", type_id = "G_TYPE_UINT", marshaller_type_name = "UINT", get_value_function = "g_value_get_uint", set_value_function = "g_value_set_uint", default_value = "0U", type_signature = "u")]
[IntegerType (rank = 7)]
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

	public int to_utf8 (string? outbuf);

	[CCode (cname = "MIN")]
	public static unichar min (unichar a, unichar b);
	[CCode (cname = "MAX")]
	public static unichar max (unichar a, unichar b);
	[CCode (cname = "CLAMP")]
	public unichar clamp (unichar low, unichar high);
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

[Compact]
[Immutable]
[CCode (cname = "char", const_cname = "const char", copy_function = "g_strdup", free_function = "g_free", cheader_filename = "stdlib.h,string.h,glib.h", type_id = "G_TYPE_STRING", marshaller_type_name = "STRING", get_value_function = "g_value_get_string", set_value_function = "g_value_set_string", type_signature = "s")]
public class string {
	[CCode (cname = "strstr")]
	public weak string? str (string needle);
	[CCode (cname = "g_str_has_prefix")]
	public bool has_prefix (string prefix);
	[CCode (cname = "g_str_has_suffix")]
	public bool has_suffix (string suffix);
	[CCode (cname = "g_strdup_printf"), PrintfFormat]
	public string printf (...);
	[CCode (cname = "sscanf", cheader_filename = "stdio.h")]
	public int scanf (...);
	[CCode (cname = "g_strconcat")]
	public string concat (string string2, ...);
	[CCode (cname = "g_strndup")]
	public string ndup (ulong n); /* FIXME: only UTF-8 */
	[CCode (cname = "g_strescape")]
	public string escape (string exceptions);
	[CCode (cname = "g_strcompress")]
	public string compress ();
	[CCode (cname = "g_strsplit")]
	[NoArrayLength]
	public string[] split (string delimiter, int max_tokens = 0);
	[CCode (cname = "g_strsplit_set")]
	[NoArrayLength]
	public string[] split_set (string delimiters, int max_tokens = 0);
	[CCode (cname = "g_strjoinv")]
	[NoArrayLength]
	public static string joinv (string separator, string[] str_array);
	[CCode (cname = "g_strnfill")]
	public static string nfill (ulong length, char fill_char);

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
	public string reverse (int len = -1);
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
	public string locale_to_utf8 (long len, out ulong bytes_read, out ulong bytes_written, out GLib.Error error = null);
  
	[CCode (cname = "g_strchomp")]
	public weak string chomp();
	[CCode (cname = "g_strchug")]
	public weak string chug();
	[CCode (cname = "g_strstrip")]
	public weak string strip ();
	
	[CCode (cname = "g_str_hash")]
	public uint hash ();
	
	[CCode (cname = "atoi")]
	public int to_int ();
	[CCode (cname = "atol")]
	public long to_long ();
	[CCode (cname = "strtod")]
	public double to_double (out string endptr = null);
	[CCode (cname = "strtoul")]
	public ulong to_ulong (out string endptr = null, int _base = 0);
	[CCode (cname = "g_ascii_strtoll")]
	public int64 to_int64 (out string endptr = null, int _base = 0);
	[CCode (cname = "strlen")]
	public long size ();

	[CCode (cname = "g_utf8_skip")]
	public static char[] skip;

	public string substring (long offset, long len);

	public long length {
		get { return this.len (); }
	}
}

[Import ()]
[CCode (cprefix = "G", lower_case_cprefix = "g_", cheader_filename = "glib.h")]
namespace GLib {
	[CCode (type_id = "G_TYPE_GTYPE", marshaller_type_name = "GTYPE", get_value_function = "g_value_get_gtype", set_value_function = "g_value_set_gtype")]
	public struct Type : ulong {
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
		
		public Type[] children ();
		public uint depth ();
		public static Type from_name (string name);
		public Type[] interfaces ();
		public bool is_a (Type is_a_type);
		public weak string name ();
		public Quark qname ();
		public Type parent ();

		public void query (out TypeQuery query);

		public TypeClass class_ref ();
		public weak TypeClass class_peek ();

		[CCode (cname = "G_TYPE_INVALID")]
		public static Type INVALID;
	}

	public struct TypeQuery {
		public Type type;
		public weak string type_name;
		public uint class_size;
		public uint instance_size;
	}

	// deprecated
	[CCode (has_type_id = true)]
	public class TypeInstance {
	}

	[Compact]
	[CCode (ref_function = "g_type_class_ref", unref_function = "g_type_class_unref")]
	public class TypeClass {
		[CCode (cname = "G_TYPE_FROM_CLASS")]
		public Type get_type ();
	}

	[CCode (cprefix = "G_TYPE_DEBUG_")]
	public enum TypeDebugFlags {
		NONE,
		OBJECTS,
		SIGNALS,
		MASK
	}

	public interface TypePlugin {
	}

	[CCode (lower_case_csuffix = "type_module")]
	public class TypeModule : Object, TypePlugin {
		public bool use ();
		public void unuse ();
		public void set_name (string name);
		[NoWrapper]
		public virtual bool load ();
		[NoWrapper]
		public virtual void unload ();
	}

	[CCode (ref_function = "g_param_spec_ref", unref_function = "g_param_spec_unref")]
	public class ParamSpec {
		public string name;
		public ParamFlags flags;
		public Type value_type;
		public Type owner_type;
	}

	public class ParamSpecEnum : ParamSpec {
		[CCode (cname = "g_param_spec_enum")]
		public ParamSpecEnum (string name, string nick, string blurb, Type enum_type, int default_value, ParamFlags flags);
	}

	public class ParamSpecFloat : ParamSpec {
		[CCode (cname = "g_param_spec_float")]
		public ParamSpecFloat (string name, string nick, string blurb, float minimum, float maximum, float default_value, ParamFlags flags);
	}

	public class ParamSpecInt : ParamSpec {
		[CCode (cname = "g_param_spec_int")]
		public ParamSpecInt (string name, string nick, string blurb, int minimum, int maximum, int default_value, ParamFlags flags);
	}

	public class ParamSpecUInt : ParamSpec {
		[CCode (cname = "g_param_spec_uint")]
		public ParamSpecUInt (string name, string nick, string blurb, uint minimum, uint maximum, uint default_value, ParamFlags flags);
	}

	[CCode (cprefix = "G_PARAM_")]
	public enum ParamFlags {
		READABLE,
		WRITABLE,
		CONSTRUCT,
		CONSTRUCT_ONLY,
		LAX_VALIDATION,
		STATIC_NAME,
		STATIC_NICK,
		STATIC_BLURB,
		READWRITE,
		STATIC_STRINGS
	}

	[CCode (lower_case_csuffix = "object_class")]
	public class ObjectClass : TypeClass {
		public weak ParamSpec find_property (string property_name);
		public weak ParamSpec[] list_properties ();
	}
	
	public struct ObjectConstructParam {
	}

	public static delegate void ObjectGetPropertyFunc (Object object, uint property_id, Value value, ParamSpec pspec);
	public static delegate void ObjectSetPropertyFunc (Object object, uint property_id, Value value, ParamSpec pspec);
	public static delegate void WeakNotify (void *data, Object object);

	[CCode (ref_function = "g_object_ref", unref_function = "g_object_unref", marshaller_type_name = "OBJECT", get_value_function = "g_value_get_object", set_value_function = "g_value_set_object", cheader_filename = "glib-object.h")]
	public class Object : TypeInstance {
		public static Object @new (Type type, ...);

		[CCode (cname = "G_TYPE_FROM_INSTANCE")]
		public Type get_type ();
		public weak Object @ref ();
		public void unref ();
		public Object ref_sink ();
		public void weak_ref (WeakNotify notify, void *data);
		public void weak_unref (WeakNotify notify, void *data);
		public void add_weak_pointer (void **data);
		public void remove_weak_pointer (void **data);
		public void get (...);
		public void set (...);
		public void get_property (string property_name, Value value);
		public void* get_data (string key);
		public void set_data (string key, void* data);
		public void set_data_full (string key, void* data, DestroyNotify? destroy);
		public void* steal_data (string key);
		public void* get_qdata (Quark quark);
		public void set_qdata (Quark quark, void* data);
		public void set_qdata_full (Quark quark, void* data, DestroyNotify? destroy);
		public void* steal_qdata (Quark quark);
		public void freeze_notify ();
		public void thaw_notify ();
		public virtual void dispose ();
		public virtual void finalize ();
		public virtual void constructed ();

		public signal void notify (ParamSpec pspec);

		public weak Object connect (string signal_spec, ...);
	}

	public struct Parameter {
		public string name;
		public Value value;
	}

	public class InitiallyUnowned : Object {
	}

	[CCode (lower_case_csuffix = "enum")]
	public class EnumClass : TypeClass {
		public weak EnumValue? get_value (int value);
		public weak EnumValue? get_value_by_name (string name);
		public weak EnumValue? get_value_by_nick (string name);
	}

	[Compact]
	public class EnumValue {
		public int value;
		public weak string value_name;
		public weak string value_nick;
	}

	[CCode (lower_case_csuffix = "flags")]
	public class FlagsClass : TypeClass {
		public weak FlagsValue? get_first_value ();
		public weak FlagsValue? get_value_by_name (string name);
		public weak FlagsValue? get_value_by_nick (string name);
	}

	[Compact]
	public class FlagsValue {
		public int value;
		public weak string value_name;
		public weak string value_nick;
	}

	[Compact]
	[CCode (cname = "gpointer", has_type_id = true, type_id = "G_TYPE_BOXED", marshaller_type_name = "BOXED", get_value_function = "g_value_get_boxed", set_value_function = "g_value_set_boxed")]
	public abstract class Boxed {
	}

	public static delegate void ValueTransform (Value src_value, out Value dest_value);

	[CCode (type_id = "G_TYPE_VALUE")]
	public struct Value {
		[CCode (cname = "G_VALUE_HOLDS")]
		public bool holds (Type type);
		[CCode (cname = "G_VALUE_TYPE")]
		public Type type ();
		[CCode (cname = "G_VALUE_TYPE_NAME")]
		public weak string type_name ();

		public Value (Type g_type);
		public void copy (ref Value dest_value);
		public weak Value? reset ();
		public void init (Type g_type);
		public void unset ();
		public void set_instance (void* instance);
		public bool fits_pointer ();
		public void* peek_pointer ();
		public static bool type_compatible (Type src_type, Type dest_type);
		public static bool type_transformable (Type src_type, Type dest_type);
		public bool transform (ref Value dest_value);
		[CCode (cname = "g_strdup_value_contents")]
		public string strdup_contents ();
		public static void register_transform_func (Type src_type, Type dest_type, ValueTransform transform);
		public void set_boolean (bool v_boolean);
		public bool get_boolean ();
		public void set_char (char v_char);
		public char get_char ();
		public void set_uchar (uchar v_uchar);
		public uchar get_uchar ();
		public void set_int (int v_int);
		public int get_int ();
		public void set_uint (uint v_uint);
		public uint get_uint ();
		public void set_long (long v_long);
		public long get_long ();
		public void set_ulong (ulong v_ulong);
		public ulong get_ulong ();
		public void set_int64 (int64 v_int64);
		public int64 get_int64 ();
		public void set_uint64 (uint64 v_uint64);
		public uint64 get_uint64 ();
		public void set_float (float v_float);
		public float get_float ();
		public void set_double (double v_double);
		public double get_double ();
		public void set_enum (int v_enum);
		public int get_enum ();
		public void set_flags (uint v_flags);
		public uint get_flags ();
		public void set_string (string v_string);
		public void set_static_string (string v_string);
		public void take_string (string# v_string);
		public weak string get_string ();
		public string dup_string ();
		public void set_pointer (void* v_pointer);
		public void* get_pointer ();
		public void set_boxed (Boxed v_boxed);
		public void take_boxed (Boxed# v_boxed);
		public weak Boxed get_boxed ();
		public Boxed dup_boxed ();
		public void set_object (Object v_object);
		public void take_object (Object# v_object);
		public weak Object get_object ();
		public Object dup_object ();
		public void set_gtype (Type v_gtype);
		public Type get_gtype ();
	}
	
	public struct SignalInvocationHint {
		public uint signal_id;
		public Quark detail;
		public SignalFlags run_type;
	}

	public delegate bool SignalEmissionHook (SignalInvocationHint ihint, [CCode (array_length_pos = 1.9)] Value[] param_values);

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

	[Compact]
	public class Closure : Boxed {
	}

	public static delegate void ClosureNotify (void* data, Closure closure);

	[CCode (type_id = "G_TYPE_VALUE_ARRAY")]
	public struct ValueArray {
	}

	[CCode (lower_case_cprefix = "", cheader_filename = "math.h")]
	namespace Math {
		[CCode (cname = "G_E")]
		public static double E;
		
		[CCode (cname = "G_PI")]
		public static double PI;

		/* generated from <bits/mathcalls.h> of glibc */
		public static double acos (double x);
		public static float acosf (float x);
		public static double asin (double x);
		public static float asinf (float x);
		public static double atan (double x);
		public static float atanf (float x);
		public static double atan2 (double y, double x);
		public static float atan2f (float y, float x);
		public static double cos (double x);
		public static float cosf (float x);
		public static double sin (double x);
		public static float sinf (float x);
		public static double tan (double x);
		public static float tanf (float x);
		public static double cosh (double x);
		public static float coshf (float x);
		public static double sinh (double x);
		public static float sinhf (float x);
		public static double tanh (double x);
		public static float tanhf (float x);
		public static void sincos (double x, out double sinx, ref double cosx);
		public static void sincosf (float x, out float sinx, out float cosx);
		public static double acosh (double x);
		public static float acoshf (float x);
		public static double asinh (double x);
		public static float asinhf (float x);
		public static double atanh (double x);
		public static float atanhf (float x);
		public static double exp (double x);
		public static float expf (float x);
		public static double frexp (double x, out int exponent);
		public static float frexpf (float x, out int exponent);
		public static double ldexp (double x, int exponent);
		public static float ldexpf (float x, int exponent);
		public static double log (double x);
		public static float logf (float x);
		public static double log10 (double x);
		public static float log10f (float x);
		public static double modf (double x, out double iptr);
		public static float modff (float x, out float iptr);
		public static double exp10 (double x);
		public static float exp10f (float x);
		public static double pow10 (double x);
		public static float pow10f (float x);
		public static double expm1 (double x);
		public static float expm1f (float x);
		public static double log1p (double x);
		public static float log1pf (float x);
		public static double logb (double x);
		public static float logbf (float x);
		public static double exp2 (double x);
		public static float exp2f (float x);
		public static double log2 (double x);
		public static float log2f (float x);
		public static double pow (double x, double y);
		public static float powf (float x, float y);
		public static double sqrt (double x);
		public static float sqrtf (float x);
		public static double hypot (double x, double y);
		public static float hypotf (float x, float y);
		public static double cbrt (double x);
		public static float cbrtf (float x);
		public static double ceil (double x);
		public static float ceilf (float x);
		public static double fabs (double x);
		public static float fabsf (float x);
		public static double floor (double x);
		public static float floorf (float x);
		public static double fmod (double x, double y);
		public static float fmodf (float x, float y);
		public static int isinf (double value);
		public static int isinff (float value);
		public static int finite (double value);
		public static int finitef (float value);
		public static double drem (double x, double y);
		public static float dremf (float x, float y);
		public static double significand (double x);
		public static float significandf (float x);
		public static double copysign (double x, double y);
		public static float copysignf (float x, float y);
		public static double nan (string tagb);
		public static float nanf (string tagb);
		public static int isnan (double value);
		public static int isnanf (float value);
		public static double j0 (double x0);
		public static float j0f (float x0);
		public static double j1 (double x0);
		public static float j1f (float x0);
		public static double jn (int x0, double x1);
		public static float jnf (int x0, float x1);
		public static double y0 (double x0);
		public static float y0f (float x0);
		public static double y1 (double x0);
		public static float y1f (float x0);
		public static double yn (int x0, double x1);
		public static float ynf (int x0, float x1);
		public static double erf (double x0);
		public static float erff (float x0);
		public static double erfc (double x0);
		public static float erfcf (float x0);
		public static double lgamma (double x0);
		public static float lgammaf (float x0);
		public static double tgamma (double x0);
		public static float tgammaf (float x0);
		public static double gamma (double x0);
		public static float gammaf (float x0);
		public static double lgamma_r (double x0, out int signgamp);
		public static float lgamma_rf (float x0, out int signgamp);
		public static double rint (double x);
		public static float rintf (float x);
		public static double nextafter (double x, double y);
		public static float nextafterf (float x, float y);
		public static double nexttoward (double x, double y);
		public static float nexttowardf (float x, double y);
		public static double remainder (double x, double y);
		public static float remainderf (float x, float y);
		public static double scalbn (double x, int n);
		public static float scalbnf (float x, int n);
		public static int ilogb (double x);
		public static int ilogbf (float x);
		public static double scalbln (double x, long n);
		public static float scalblnf (float x, long n);
		public static double nearbyint (double x);
		public static float nearbyintf (float x);
		public static double round (double x);
		public static float roundf (float x);
		public static double trunc (double x);
		public static float truncf (float x);
		public static double remquo (double x, double y, out int quo);
		public static float remquof (float x, float y, out int quo);
		public static long lrint (double x);
		public static long lrintf (float x);
		public static int64 llrint (double x);
		public static int64 llrintf (float x);
		public static long lround (double x);
		public static long lroundf (float x);
		public static int64 llround (double x);
		public static int64 llroundf (float x);
		public static double fdim (double x, double y);
		public static float fdimf (float x, float y);
		public static double fmax (double x, double y);
		public static float fmaxf (float x, float y);
		public static double fmin (double x, double y);
		public static float fminf (float x, float y);
		public static double fma (double x, double y, double z);
		public static float fmaf (float x, float y, float z);
		public static double scalb (double x, double n);
		public static float scalbf (float x, float n);
	}

	/* Byte order */
	namespace ByteOrder {
		[CCode (cname = "G_BYTE_ORDER")]
		public const int HOST;
		[CCode (cname = "G_LITTLE_ENDIAN")]
		public const int LITTLE_ENDIAN;
		[CCode (cname = "G_BIG_ENDIAN")]
		public const int BIG_ENDIAN;
		[CCode (cname = "G_PDP_ENDIAN")]
		public const int PDP_ENDIAN;
	}

	/* Atomic Operations */

	namespace AtomicInt {
		public static int get (ref int atomic);
		public static void set (ref int atomic, int newval);
		public static void add (ref int atomic, int val);
		public static int exchange_and_add (ref int atomic, int val);
		public static bool compare_and_exchange (ref int atomic, int oldval, int newval);
		public static void inc (ref int atomic);
		public static bool dec_and_test (ref int atomic);
	}

	namespace AtomicPointer {
		public static void* get (void** atomic);
		public static void set (void** atomic, void* newval);
		public static bool compare_and_exchange (void** atomic, void* oldval, void* newval);
	}

	/* The Main Event Loop */

	[Compact]
	[CCode (ref_function = "g_main_loop_ref", unref_function = "g_main_loop_unref")]
	public class MainLoop {
		public MainLoop (MainContext? context, bool is_running);
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

	[Compact]
	[CCode (ref_function = "g_main_context_ref", unref_function = "g_main_context_unref")]
	public class MainContext {
		public MainContext ();
		public static weak MainContext @default ();
		public bool iteration (bool may_block);
		public bool pending ();
		public weak Source find_source_by_id (uint source_id);
		public weak Source find_source_by_user_data (void* user_data);
		public weak Source find_source_by_funcs_user_data (SourceFuncs funcs, void* user_data);
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

	[CCode (cname = "GSource")]
	public class TimeoutSource : Source {
		public TimeoutSource (uint interval);
	}

	namespace Timeout {
		public static uint add (uint interval, SourceFunc function);
		public static uint add_full (int priority, uint interval, SourceFunc# function);
		public static uint add_seconds (uint interval, SourceFunc function);
		public static uint add_seconds_full (int priority, uint interval, SourceFunc function, DestroyNotify? notify);
	}

	[CCode (cname = "GSource")]
	public class IdleSource : Source {
		public IdleSource ();
	}

	namespace Idle {
		public static uint add (SourceFunc function);
		public static uint add_full (int priority, SourceFunc# function);
		public static bool remove_by_data (void* data);
	}

	[SimpleType]
	[CCode (default_value = "0")]
	public struct Pid {
	}

	public delegate void ChildWatchFunc (Pid pid, int status);
	
	public class ChildWatchSource : Source {
		public ChildWatchSource (Pid pid, int status, void* data);
	}
	
	namespace ChildWatch {
		public static uint add (Pid pid, ChildWatchFunc function);
		public static uint add_full (int priority, Pid pid, ChildWatchFunc# function);
	}
	
	public struct PollFD {
		public int fd;
		public IOCondition events;
		public IOCondition revents;
	}

	[Compact]
	[CCode (ref_function = "g_source_ref", unref_function = "g_source_unref")]
	public class Source {
		public Source (SourceFuncs source_funcs, uint struct_size /* = sizeof (Source) */);
		public void set_funcs (SourceFuncs funcs);
		public uint attach (MainContext? context);
		public void destroy ();
		public bool is_destroyed ();
		public void set_priority (int priority);
		public int get_priority ();
		public void set_can_recurse (bool can_recurse);
		public bool get_can_recurse ();
		public uint get_id ();
		public weak MainContext get_context ();
		public void set_callback (SourceFunc func, DestroyNotify? notify);
		public void set_callback_indirect (void* callback_data, SourceCallbackFuncs callback_funcs);
		public void add_poll (ref PollFD fd);
		public void remove_poll (ref PollFD fd);
		public void get_current_time (out TimeVal timeval);
		public static void remove (uint id);
		public static bool remove_by_funcs_user_data (void* user_data);
		public static bool remove_by_user_data (void* user_data);
	}
	
	public static delegate void SourceDummyMarshal ();
	
	public static delegate bool SourcePrepareFunc (Source source, out int timeout_);
	public static delegate bool SourceCheckFunc (Source source);
	public static delegate bool SourceDispatchFunc (Source source, SourceFunc _callback);
	public static delegate void SourceFinalizeFunc (Source source);
	
	[Compact]
	public class SourceFuncs {
		public SourcePrepareFunc prepare;
		public SourceCheckFunc check;
		public SourceDispatchFunc dispatch;
		public SourceFinalizeFunc finalize;
	}
	
	public static delegate void SourceCallbackRefFunc (void* cb_data);
	public static delegate void SourceCallbackUnrefFunc (void* cb_data);
	public static delegate void SourceCallbackGetFunc (void* cb_data, Source source, SourceFunc func);
	
	[Compact]
	public class SourceCallbackFuncs {
		public SourceCallbackRefFunc @ref;
		public SourceCallbackUnrefFunc unref;
		public SourceCallbackGetFunc @get;
	}
	
	public delegate bool SourceFunc ();

	public errordomain ThreadError {
		AGAIN
	}

	/* Thread support */
	[Compact]
	public class ThreadFunctions {
	}
	
	public delegate void* ThreadFunc ();
	public delegate void Func (void* data);
	
	public enum ThreadPriority {
		LOW,
		NORMAL,
		HIGH,
		URGENT
	}
	
	[Compact]
	public class Thread {
		public static void init (ThreadFunctions? vtable = null);
		public static bool supported ();
		public static weak Thread create (ThreadFunc func, bool joinable) throws ThreadError;
		public static weak Thread create_full (ThreadFunc func, ulong stack_size, bool joinable, bool bound, ThreadPriority priority) throws ThreadError;
		public static weak Thread self ();
		public void* join ();
		public void set_priority (ThreadPriority priority);
		public static void yield ();
		public static void exit (void* retval);
		public static void @foreach (Func thread_func);
		
		[CCode (cname = "g_usleep")]
		public static void usleep (ulong microseconds);
	}
	
	[Compact]
	[CCode (free_function = "g_mutex_free")]
	public class Mutex {
		public Mutex ();
		public void @lock ();
		public bool trylock ();
		public void unlock ();
	}

	[CCode (destroy_function = "g_static_rec_mutex_free")]
	public struct StaticRecMutex {
		public StaticRecMutex ();
		public void lock ();
		public bool trylock ();
		public void unlock ();
		public void lock_full ();
	}

	[Compact]
	[CCode (free_function = "g_cond_free")]
	public class Cond {
		public Cond ();
		public void @signal ();
		public void broadcast ();
		public void wait (Mutex mutex);
		public bool timed_wait (Mutex mutex, TimeVal abs_time);
	}
	
	/* Thread Pools */

	[Compact]
	[CCode (free_function = "g_thread_pool_free")]
	public class ThreadPool {
		public ThreadPool (Func func, void* user_data, int max_threads, bool exclusive) throws ThreadError;
		public void push (void* data) throws ThreadError;
		public void set_max_threads (int max_threads) throws ThreadError;
		public int get_max_threads ();
		public uint get_num_threads ();
		public uint unprocessed ();
		public static void set_max_unused_threads (int max_threads);
		public static int get_max_unused_threads ();
		public static uint get_num_unused_threads ();
		public static void stop_unused_threads ();
		public void set_sort_function (CompareDataFunc func, void* user_data);
		public static void set_max_idle_time (uint interval);
		public static uint get_max_idle_time ();
	}
	
	/* Asynchronous Queues */

	[Compact]
	[CCode (ref_function = "g_async_queue_ref", unref_function = "g_async_queue_unref")]
	public class AsyncQueue {
		public AsyncQueue ();
		public void push (void* data);
		public void push_sorted (void* data, CompareDataFunc func, void* user_data);
		public void* pop ();
		public void* try_pop ();
		public void* timed_pop (ref TimeVal end_time);
		public int length ();
		public void sort (CompareDataFunc func, void* user_data);
		public void @lock ();
		public void unlock ();
		public void ref_unlocked ();
		public void unref_and_unlock ();
		public void push_unlocked (void* data);
		public void push_sorted_unlocked (void* data, CompareDataFunc func, void* user_data);
		public void* pop_unlocked ();
		public void* try_pop_unlocked ();
		public void* timed_pop_unlocked (ref TimeVal end_time);
		public int length_unlocked ();
		public void sort_unlocked (CompareDataFunc func, void* user_data);
	}

	/* Memory Allocation */
	
	public static void* malloc (ulong n_bytes);
	public static void* malloc0 (ulong n_bytes);
	public static void* realloc (void* mem, ulong n_bytes);

	public static void* try_malloc (ulong n_bytes);
	public static void* try_malloc0 (ulong n_bytes);
	public static void* try_realloc (void* mem, ulong n_bytes);
	
	public static void free (void* mem);

	public class MemVTable {
	}

	[CCode (cname = "glib_mem_profiler_table")]
	public static MemVTable mem_profiler_table;

	public static void mem_set_vtable (MemVTable vtable);
	public static void mem_profile ();

	[CCode (cheader_filename = "string.h")]
	namespace Memory {
		[CCode (cname = "memcmp")]
		public static int cmp (void* s1, void* s2, size_t n);
		[CCode (cname = "memcpy")]
		public static void* copy (void* dest, void* src, size_t n);
		[CCode (cname = "g_memmove")]
		public static void* move (void* dest, void* src, size_t n);
		[CCode (cname = "g_memdup")]
		public static void* dup (void* mem, uint n);
	}

	/* IO Channels */

	[Compact]
	[CCode (ref_function = "g_io_channel_ref", unref_function = "g_io_channel_unref")]
	public class IOChannel : Boxed {
		[CCode (cname = "g_io_channel_unix_new")]
		public IOChannel.unix_new (int fd);
		public int unix_get_fd ();
		[CCode (cname = "g_io_channel_win32_new_fd")]
		public IOChannel.win32_new_fd (int fd);
		public void init ();
		public IOChannel.file (string filename, string mode) throws FileError;
		public IOStatus read_chars (char[] buf, out size_t bytes_read) throws ConvertError, IOChannelError;
		public IOStatus read_unichar (out unichar thechar) throws ConvertError, IOChannelError;
		public IOStatus read_line (out string str_return, out size_t length, out size_t terminator_pos) throws ConvertError, IOChannelError;
		public IOStatus read_line_string (StringBuilder buffer, out size_t terminator_pos) throws ConvertError, IOChannelError;
		public IOStatus read_to_end (out string str_return, out size_t length) throws ConvertError, IOChannelError;
		public IOStatus write_chars (char[] buf, out size_t bytes_written) throws ConvertError, IOChannelError;
		public IOStatus write_unichar (unichar thechar) throws ConvertError, IOChannelError;
		public IOStatus flush () throws IOChannelError;
		public IOStatus seek_position (int64 offset, SeekType type) throws IOChannelError;
		public IOStatus shutdown (bool flush) throws IOChannelError;
		[CCode (cname = "g_io_create_watch")]
		public GLib.Source create_watch (IOCondition condition);
		[CCode (cname = "g_io_add_watch")]
		public uint add_watch (IOCondition condition, IOFunc func);
		public size_t get_buffer_size ();
		public void set_buffer_size (size_t size);
		public IOCondition get_buffer_condition ();
		public IOFlags get_flags ();
		public IOStatus set_flags (IOFlags flags) throws IOChannelError;
		public weak string get_line_term (out int length);
		public void set_line_term (string line_term, int length);
		public bool get_buffered ();
		public void set_buffered (bool buffered);
		public weak string get_encoding ();
		public IOStatus set_encoding (string? encoding) throws IOChannelError;
		public bool get_close_on_unref ();
		public void set_close_on_unref (bool do_close);
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

	public errordomain IOChannelError {
		FBIG,
		INVAL,
		IO,
		ISDIR,
		NOSPC,
		NXIO,
		OVERFLOW,
		PIPE,
		FAILED
	}

	[CCode (cprefix = "G_IO_", type_id = "G_TYPE_IO_CONDITION")]
	public enum IOCondition {
		IN,
		OUT,
		PRI,
		ERR,
		HUP,
		NVAL
	}

	public delegate bool IOFunc (IOChannel source, IOCondition condition);

	[CCode (cprefix = "G_IO_FLAG_")]
	public enum IOFlags {
		APPEND,
		NONBLOCK,
		READABLE,
		WRITEABLE,
		SEEKABLE,
		MASK,
		GET_MASK,
		SET_MASK
	}

	/* Error Reporting */

	[Compact]
	[ErrorBase]
	[CCode (copy_function = "g_error_copy", free_function = "g_error_free")]
	public class Error {
		public Error (Quark domain, int code, string format, ...);
		public Error copy ();
		public bool matches (Quark domain, int code);

		public Quark domain;
		public int code;
		public string message;
	}
	
	/* Message Output and Debugging Functions */

	[PrintfFormat]
	public static void print (string format, ...);
	public static void set_print_handler (PrintFunc func);
	public static delegate void PrintFunc (string text);
	public static void printerr (string format, ...);
	public static void set_printerr_handler (PrintFunc func);

	public static void return_if_fail (bool expr);
	public static void return_if_reached ();
	public static void warn_if_fail (bool expr);
	public static void warn_if_reached ();

	public static void assert (bool expr);
	[NoReturn]
	public static void assert_not_reached ();

	public static void on_error_query (string? prg_name = null);
	public static void on_error_stack_trace (string? prg_name = null);
	[CCode (cname = "G_BREAKPOINT")]
	public static void breakpoint ();

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

	public delegate void LogFunc (string? log_domain, LogLevelFlags log_levels, string message);

	namespace Log {
		public uint set_handler (string? log_domain, LogLevelFlags log_levels, LogFunc log_func);
	}

	/* String Utility Functions */

	[NoArrayLength]
	public uint strv_length (string[] str_array);

	/* Character Set Conversions */
	
	public static string convert (string str, long len, string to_codeset, string from_codeset, out int bytes_read = null, out int bytes_written = null) throws ConvertError;

	public struct IConv {
		[CCode (cname = "g_iconv_open")]
		public IConv (string to_codeset, string from_codeset);
		[CCode (cname = "g_iconv")]
		public uint iconv (out string inbuf, out uint inbytes_left, out string outbuf, out uint outbytes_left);
		public int close ();
	}

	namespace Filename {
		public static string to_utf8 (string opsysstring, out ulong bytes_read, out ulong bytes_written) throws ConvertError;
		public static string from_utf8 (string utf8string, long len, out ulong bytes_read, out ulong bytes_written) throws ConvertError;
		public static string from_uri (string uri, out string hostname = null) throws ConvertError;
		public static string to_uri (string filename, string? hostname = null) throws ConvertError;
		public static string display_name (string filename);
		public static string display_basename (string filename);
	}

	public errordomain ConvertError {
		NO_CONVERSION,
		ILLEGAL_SEQUENCE,
		FAILED,
		PARTIAL_INPUT,
		BAD_URI,
		NOT_ABSOLUTE_PATH
	}

	/* Base64 Encoding */
	
	namespace Base64 {
		public static size_t encode_step (uchar[] _in, bool break_lines, char* _out, ref int state, ref int save);
		public static size_t encode_close (bool break_lines, char* _out, ref int state, ref int save);
		public static string encode (uchar[] data);
		public static size_t decode_step (char[] _in, uchar* _out, ref int state, ref uint save);
		[NoArrayLength]
		public static uchar[] decode (string text, out size_t out_len);
	}

	/* Data Checksums */

	[CCode (cprefix = "G_CHECKSUM_")]
	public enum ChecksumType {
		MD5,
		SHA1,
		SHA256;

		public ssize_t get_length ();
	}

	[Compact]
	[CCode (free_function = "g_checksum_free")]
	public class Checksum {
		public Checksum (ChecksumType checksum_type);
		public Checksum copy ();
		[NoArrayLength]
		public void update (uchar[] data, size_t length);
		public weak string get_string ();
		[NoArrayLength]
		public void get_digest (uint8[] buffer, ref size_t digest_len);
		[NoArrayLength]
		public static string compute_for_data (ChecksumType checksum_type, uchar[] data, size_t length);
		public static string compute_for_string (ChecksumType checksum_type, string str, size_t length);
	}

	/* Date and Time Functions */
	
	public struct TimeVal {
		public long tv_sec;
		public long tv_usec;

		[CCode (cname = "g_get_current_time")]
		public void get_current_time ();
		public void add (long microseconds);
		[CCode (instance_pos = -1)]
		public bool from_iso8601 (string iso_date);
		[InstanceByReference]
		public string to_iso8601 ();
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
		DECEMBER;

		[CCode (cname = "g_date_get_days_in_month")]
		public uchar get_days_in_month (DateYear year);
		[CCode (cname = "g_date_valid_month")]
		public bool valid (); 
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
		SUNDAY;

		[CCode (cname = "g_date_valid_weekday")]
		public bool valid (); 
	}

	public struct Date {
		public void clear (uint n_dates = 1);
		public void set_day (DateDay day);
		public void set_month (DateMonth month);
		public void set_year (DateYear year);
		public void set_dmy (DateDay day, int month, DateYear y);
		public void set_julian (uint julian_day);
		public void set_time_val (TimeVal timeval);
		public void set_parse (string str);
		public void add_days (uint n_days);
		public void subtract_days (uint n_days);
		public void add_months (uint n_months);
		public void subtract_months (uint n_months);
		public void add_years (uint n_years);
		public void subtract_years (uint n_years);
		public int days_between (Date date2);
		public int compare (Date rhs);
		public void clamp (Date min_date, Date max_date);
		public void order (Date date2);
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
		[CCode (instance_pos = -1)]
		public size_t strftime (char[] s, string format);
		[CCode (cname = "g_date_to_struct_tm")]
		public void to_time (out Time tm);
		public bool valid ();
		public static uchar get_days_in_month (DateMonth month, DateYear year);
		public static bool valid_day (DateDay day);
		public static bool valid_dmy (DateDay day, DateMonth month, DateYear year);
		public static bool valid_julian (uint julian_date);
		public static bool valid_weekday (DateWeekday weekday);
	}

	[CCode (cname = "struct tm", cheader_filename="time.h")]
	public struct Time {
		[CCode (cname = "tm_sec")]
		public int second;
		[CCode (cname = "tm_min")]
		public int minute;
		[CCode (cname = "tm_hour")]
		public int hour;
		[CCode (cname = "tm_mday")]
		public int day;
		[CCode (cname = "tm_mon")]
		public int month;
		[CCode (cname = "tm_year")]
		public int year;
		[CCode (cname = "tm_wday")]
		public int weekday;
		[CCode (cname = "tm_yday")]
		public int day_of_year;
		[CCode (cname = "tm_isdst")]
		public int isdst;

		[CCode (cname = "gmtime_r", instance_pos = -1)]
		public Time.gm (time_t time);
		[CCode (cname = "localtime_r", instance_pos = -1)]
		public Time.local (time_t time);

		[CCode (cname = "asctime_r")]
		public string to_string (char* buffer = new char[26]);

		[CCode (cname = "mktime")]
		public time_t mktime ();

		[CCode (instance_pos = -1)]
		public size_t strftime (char[] s, string format);
		[CCode (instance_pos = -1)]
		public weak string? strptime (string buf, string format);
	}

	/* Random Numbers */

	[Compact]
	[CCode (copy_function = "g_rand_copy", free_function = "g_rand_free")]
	public class Rand {
		public Rand.with_seed (uint32 seed);
		[NoArrayLength ()]
		public Rand.with_seed_array (uint32[] seed, uint seed_length);
		public Rand ();
		public void set_seed (uint32 seed);
		[NoArrayLength ()]
		public void set_seed_array (uint32[] seed, uint seed_length);
		public bool boolean ();
		[CCode (cname = "g_rand_int")]
		public uint32 next_int ();
		public int32 int_range (int32 begin, int32 end);
		[CCode (cname = "g_rand_double")]
		public double next_double ();
		public double double_range (double begin, double end);
	}
	
	namespace Random {
		public static void set_seed (uint32 seed);
		public static bool boolean ();
		[CCode (cname = "g_random_int")]
		public static uint32 next_int ();
		public static int32 int_range (int32 begin, int32 end);
		[CCode (cname = "g_random_double")]
		public static double next_double ();
		public static double double_range (double begin, double end);
	}
	
	/* Miscellaneous Utility Functions */
	
	namespace Environment {
		[CCode (cname = "g_get_application_name")]
		public static weak string? get_application_name ();
		[CCode (cname = "g_set_application_name")]
		public static void set_application_name (string application_name);
		[CCode (cname = "g_get_prgname")]
		public static weak string get_prgname ();
		[CCode (cname = "g_set_prgname")]
		public static void set_prgname (string application_name);
		[CCode (cname = "g_getenv")]
		public static weak string? get_variable (string variable);
		[CCode (cname = "g_setenv")]
		public static bool set_variable (string variable, string value, bool overwrite);
		[CCode (cname = "g_listenv")]
		[NoArrayLength]
		public static string[] list_variables ();
		[CCode (cname = "g_get_user_name")]
		public static weak string get_user_name ();
		[CCode (cname = "g_get_user_cache_dir")]
		public static weak string get_user_cache_dir ();
		[CCode (cname = "g_get_user_data_dir")]
		public static weak string get_user_data_dir ();
		[CCode (cname = "g_get_user_config_dir")]
		public static weak string get_user_config_dir ();
		[CCode (cname = "g_get_user_special_dir")]
		public static weak string get_user_special_dir (UserDirectory directory);
		[CCode (cname = "g_get_system_data_dirs"), NoArrayLength]
		public static weak string[] get_system_data_dirs ();
		[CCode (cname = "g_get_system_config_dirs"), NoArrayLength]
		public static weak string[] get_system_config_dirs ();
		[CCode (cname = "g_get_host_name")]
		public static weak string get_host_name ();
		[CCode (cname = "g_get_home_dir")]
		public static weak string get_home_dir ();
		[CCode (cname = "g_get_tmp_dir")]
		public static weak string get_tmp_dir ();
		[CCode (cname = "g_get_current_dir")]
		public static string get_current_dir ();
		[CCode (cname = "g_find_program_in_path")]
		public static string find_program_in_path (string program);
		[CCode (cname = "g_atexit")]
		public static void atexit (VoidFunc func);
	}

	public enum UserDirectory {
		DESKTOP,
		DOCUMENTS,
		DOWNLOAD,
		MUSIC,
		PICTURES,
		PUBLIC_SHARE,
		TEMPLATES,
		VIDEOS
	}

	namespace Path {
		public static bool is_absolute (string file_name);
		public static weak string skip_root (string file_name);
		public static string get_basename (string file_name);
		public static string get_dirname (string file_name);
		[CCode (cname = "g_build_filename")]
		public static string build_filename (string first_element, ...);

		[CCode (cname = "G_DIR_SEPARATOR")]
		public const char DIR_SEPARATOR;
		[CCode (cname = "G_DIR_SEPARATOR_S")]
		public const string DIR_SEPARATOR_S;
		[CCode (cname = "G_IS_DIR_SEPARATOR")]
		public static bool is_dir_separator (unichar c);
	}

	namespace Bit {
		public static int nth_lsf (ulong mask, int nth_bit);
		public static int nth_msf (ulong mask, int nth_bit);
		public static uint storage (ulong number);
	}

	namespace SpacedPrimes {
		public static uint closest (uint num);
	}

	public static delegate void FreeFunc (void* data);
	public static delegate void VoidFunc ();

	/* Lexical Scanner */

	[Compact]
	[CCode (free_function = "g_scanner_destroy")]
	public class Scanner {
		public Scanner (ScannerConfig config_templ);
		public void input_file (int input_fd);
		public void sync_file_offset ();
		public void input_text (string text, uint text_len);
		public TokenType peek_next_token ();
		public TokenType get_next_token ();
		public bool eof ();
		public uint cur_line ();
		public uint cur_position ();
		public TokenType cur_token ();
		public TokenValue cur_value ();
		public uint set_scope (uint scope_id);
		public void scope_add_symbol (uint scope_id, string symbol, void* value);
		public void scope_foreach_symbol (uint scope_id, HFunc func);
		public void* scope_lookup_symbol (uint scope_id, string symbol);
		public void scope_remove_symbol (uint scope_id, string symbol);
		public void* lookup_symbol (string symbol);
		[PrintfFormat]
		public void warn (string format, ...);
		[PrintfFormat]
		public void error (string format, ...);
		public void unexp_token (TokenType expected_token, string identifier_spec, string symbol_spec, string symbol_name, string message, int is_error);
	}

	public struct ScannerConfig {
		public string cset_skip_characters;
		public string cset_identifier_first;
		public string cset_identifier_nth;
		public string cpair_comment_single;
		public uint case_sensitive;
		public uint skip_comment_multi;
		public uint skip_comment_single;
		public uint scan_comment_multi;
		public uint scan_identifier;
		public uint scan_identifier_1char;
		public uint scan_identifier_NULL;
		public uint scan_symbols;
		public uint scan_binary;
		public uint scan_octal;
		public uint scan_float;
		public uint scan_hex;
		public uint scan_hex_dollar;
		public uint scan_string_sq;
		public uint scan_string_dq;
		public uint numbers_2_int;
		public uint int_2_float;
		public uint identifier_2_string;
		public uint char_2_token;
		public uint symbol_2_token;
		public uint scope_0_fallback;
		public uint store_int64;
	}

	namespace CharacterSet {
		[CCode (cname = "G_CSET_A_2_Z")]
		public const string A_2_Z;
		[CCode (cname = "G_CSET_a_2_z")]
		public const string a_2_z;
		[CCode (cname = "G_CSET_DIGITS")]
		public const string DIGITS;
		[CCode (cname = "G_CSET_LATINC")]
		public const string LATINC;
		[CCode (cname = "G_CSET_LATINS")]
		public const string LATINS;
	}

	[CCode (cprefix = "G_TOKEN_")]
	public enum TokenType
	{
		EOF,
		LEFT_PAREN,
		RIGHT_PAREN,
		LEFT_CURLY,
		RIGHT_CURLY,
		LEFT_BRACE,
		RIGHT_BRACE,
		EQUAL_SIGN,
		COMMA,
		NONE,
		ERROR,
		CHAR,
		BINARY,
		OCTAL,
		INT,
		HEX,
		FLOAT,
		STRING,
		SYMBOL,
		IDENTIFIER,
		IDENTIFIER_NULL,
		COMMENT_SINGLE,
		COMMENT_MULTI,
		LAST
	}

	[SimpleType]
	public struct TokenValue {
		public void* v_symbol;
		public string v_identifier;
		public ulong v_binary;
		public ulong v_octal;
		public ulong v_int;
		public ulong v_int64;
		public double v_float;
		public ulong v_hex;
		public string v_string;
		public string v_comment;
		public uchar v_char;
		public uint v_error;
	}

	[CCode (cprefix = "G_ERR_")]
	public enum ErrorType
	{
		UNKNOWN,
		UNEXP_EOF,
		UNEXP_EOF_IN_STRING,
		UNEXP_EOF_IN_COMMENT,
		NON_DIGIT_IN_CONST,
		DIGIT_RADIX,
		FLOAT_RADIX,
		FLOAT_MALFORMED
	}

	/* Timers */

	[Compact]
	[CCode (free_function = "g_timer_destroy")]
	public class Timer {
		public Timer ();
		public void start ();
		public void stop ();
		public void @continue ();
		public double elapsed (out ulong microseconds = null);
		public void reset ();
	}

	/* Spawning Processes */

	public errordomain SpawnError {
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
		LEAVE_DESCRIPTORS_OPEN,
		DO_NOT_REAP_CHILD,
		SEARCH_PATH,
		STDOUT_TO_DEV_NULL,
		STDERR_TO_DEV_NULL,
		CHILD_INHERITS_STDIN,
		FILE_AND_ARGV_ZERO
	}

	public delegate void SpawnChildSetupFunc ();

	[CCode (lower_case_cprefix = "g_")]
	namespace Process {
		[NoArrayLength ()]
		public static bool spawn_async_with_pipes (string? working_directory, string[] argv, string[]? envp, SpawnFlags _flags, SpawnChildSetupFunc? child_setup, out Pid child_pid, out int standard_input = null, out int standard_output = null, out int standard_error = null) throws SpawnError;
		[NoArrayLength ()]
		public static bool spawn_async (string? working_directory, string[] argv, string[]? envp, SpawnFlags _flags, SpawnChildSetupFunc? child_setup, out Pid child_pid) throws SpawnError;
		[NoArrayLength ()]
		public static bool spawn_sync (string? working_directory, string[] argv, string[]? envp, SpawnFlags _flags, SpawnChildSetupFunc? child_setup, out string standard_output = null, out string standard_error = null, out int exit_status = null) throws SpawnError;
		public static bool spawn_command_line_async (string command_line) throws SpawnError;
		public static bool spawn_command_line_sync (string command_line, out string standard_output = null, out string standard_error = null, out int exit_status = null) throws SpawnError;
		[CCode (cname = "g_spawn_close_pid")]
		public static void close_pid (Pid pid);
		
		/* these macros are required to examine the exit status of a process */
		[CCode (cname = "WIFEXITED")]
		public static bool if_exited (int status);
		[CCode (cname = "WEXITSTATUS")]
		public static int exit_status (int status);
		[CCode (cname = "WIFSIGNALED")]
		public static bool if_signaled (int status);
		[CCode (cname = "WTERMSIG")]
		public static ProcessSignal term_sig (int status);
		[CCode (cname = "WCOREDUMP")]
		public static bool core_dump (int status);
		[CCode (cname = "WIFSTOPPED")]
		public static bool if_stopped (int status);
		[CCode (cname = "WSTOPSIG")]
		public static ProcessSignal stop_sig (int status);
		[CCode (cname = "WIFCONTINUED")]
		public static bool if_continued (int status);
	}
	
	public enum ProcessSignal {
		HUP,
		INT,
		QUIT,
		ILL,
		TRAP,
		ABRT,
		BUS,
		FPE,
		KILL,
		SEGV,
		PIPE,
		ALRM,
		TERM,
		USR1,
		USR2,
		CHLD,
		CONT,
		STOP,
		TSTP,
		TTIN,
		TTOU
	}
		
	
	/* File Utilities */

	public errordomain FileError {
		EXIST,
		ISDIR,
		ACCES,
		NAMETOOLONG,
		NOENT,
		NOTDIR,
		NXIO,
		NODEV,
		ROFS,
		TXTBSY,
		FAULT,
		LOOP,
		NOSPC,
		NOMEM,
		MFILE,
		NFILE,
		BADF,
		INVAL,
		PIPE,
		AGAIN,
		INTR,
		IO,
		PERM,
		NOSYS,
		FAILED
	}

	public enum FileTest {
		IS_REGULAR,
		IS_SYMLINK,
		IS_DIR,
		IS_EXECUTABLE,
		EXISTS
	}

	[Compact]
	[CCode (cname = "FILE", free_function = "fclose", cheader_filename = "stdio.h")]
	public class FileStream {
		[CCode (cname = "fopen")]
		public static FileStream open (string path, string mode);
		[CCode (cname = "fdopen")]
		public static FileStream fdopen (int fildes, string mode);
		[CCode (cname = "fprintf")]
		[PrintfFormat ()]
		public void printf (string format, ...);
		[CCode (cname = "fputc", instance_pos = -1)]
		public void putc (char c);
		[CCode (cname = "fputs", instance_pos = -1)]
		public void puts (string s);
		[CCode (cname = "fgetc")]
		public int getc ();
		[CCode (cname = "fgets", instance_pos = -1)]
		public weak string gets (string s, int size);
		[CCode (cname = "feof")]
		public bool eof ();
		[CCode (cname = "fscanf")]
		public int scanf (string format, ...);
		[CCode (cname = "fflush")]
		public int flush ();
	}

	[CCode (lower_case_cprefix = "g_file_", cheader_filename = "glib/gstdio.h")]
	namespace FileUtils {
		public static bool get_contents (string filename, out string contents, out ulong length = null) throws FileError;
		public static bool set_contents (string filename, string contents, long length = -1) throws FileError;
		public static bool test (string filename, FileTest test);
		public static int open_tmp (string tmpl, out string name_used) throws FileError;
		public static string read_link (string filename) throws FileError;
		
		[CCode (cname = "g_mkstemp")]
		public static int mkstemp (string tmpl);
		[CCode (cname = "g_rename")]
		public static int rename (string oldfilename, string newfilename);
		[CCode (cname = "g_unlink")]
		public static int unlink (string filename);
		[CCode (cname = "g_chmod")]
		public static int chmod (string filename, int mode);
		
		[CCode (cname = "symlink")]
		public static int symlink (string oldpath, string newpath);
	}

	[CCode (cname = "stat")]
	public struct Stat {
	}

	[Compact]
	[CCode (free_function = "g_dir_close")]
	public class Dir {
		public static Dir open (string filename, uint _flags = 0) throws FileError;
		public weak string read_name ();
		public void rewind ();
	}
	
	namespace DirUtils {
		[CCode (cname = "g_mkdir")]
		public static int create (string pathname, int mode);
		[CCode (cname = "g_mkdir_with_parents")]
		public static int create_with_parents (string pathname, int mode);
		[CCode (cname = "mkdtemp")]
		public static weak string mkdtemp (string template);
	}

	[Compact]
	[CCode (free_function = "g_mapped_file_free")]
	public class MappedFile {
		public MappedFile (string filename, bool writable) throws FileError;
		public void free ();
		public long get_length ();
		public char* get_contents ();
	}

	[CCode (cname = "stdin", cheader_filename = "stdio.h")]
	public static FileStream stdin;

	[CCode (cname = "stdout", cheader_filename = "stdio.h")]
	public static FileStream stdout;
	
	[CCode (cname = "stderr", cheader_filename = "stdio.h")]
	public static FileStream stderr;

	/* URI Functions */

	namespace Uri {
		public const string RESERVED_CHARS_ALLOWED_IN_PATH;
		public const string RESERVED_CHARS_ALLOWED_IN_PATH_ELEMENT;
		public const string RESERVED_CHARS_ALLOWED_IN_USERINFO;
		public const string RESERVED_CHARS_GENERIC_DELIMITERS;
		public const string RESERVED_CHARS_SUBCOMPONENT_DELIMITERS;

		public static string escape_string (string unescaped, string reserved_chars_allowed, bool allow_utf8);
		public static string get_scheme (string uri);
		public static string unescape_segment (string escaped_string, string escaped_string_end, string illegal_characters);
		public static string unescape_string (string escaped_string, string illegal_characters);
	}

	/* Shell-related Utilities */

	public errordomain ShellError {
		BAD_QUOTING,
		EMPTY_STRING,
		FAILED
	}

	namespace Shell {
		public static bool parse_argv (string command_line, [CCode (array_length_pos = 1.9)] out string[] argvp) throws ShellError;
		public static string quote (string unquoted_string);
		public static string unquote (string quoted_string) throws ShellError;
	}

	/* Commandline option parser */

	public errordomain OptionError {
		UNKNOWN_OPTION,
		BAD_VALUE,
		FAILED
	}

	[Compact]
	[CCode (free_function = "g_option_context_free")]
	public class OptionContext {
		public OptionContext (string parameter_string);
		public void set_summary (string summary);
		public weak string get_summary ();
		public void set_description (string description);
		public void get_description ();
		public void set_translate_func (TranslateFunc func, DestroyNotify? destroy_notify);
		public void set_translation_domain (string domain);
		public bool parse ([CCode (array_length_pos = 0.9)] ref weak string[] argv) throws OptionError;
		public void set_help_enabled (bool help_enabled);
		public bool get_help_enabled ();
		public void set_ignore_unknown_options (bool ignore_unknown);
		public bool get_ignore_unknown_options ();
		public string get_help (bool main_help, OptionGroup? group);
		[NoArrayLength]
		public void add_main_entries (OptionEntry[] entries, string? translation_domain);
		public void add_group (OptionGroup# group);
		public void set_main_group (OptionGroup# group);
		public weak OptionGroup get_main_group ();
	}

	public delegate weak string TranslateFunc (string str);

	public enum OptionArg {
		NONE,
		STRING,
		INT,
		CALLBACK,
		FILENAME,
		STRING_ARRAY,
		FILENAME_ARRAY,
		DOUBLE,
		INT64
	}
	
	[Flags]
	[CCode (cprefix = "G_OPTION_FLAG_")]
	public enum OptionFlags {
		HIDDEN,
		IN_MAIN,
		REVERSE,
		NO_ARG,
		FILENAME,
		OPTIONAL_ARG,
		NOALIAS
	}
	
	public struct OptionEntry {
		public weak string long_name;
		public char short_name;
		public int flags;

		public OptionArg arg;
		public void* arg_data;

		public weak string description;
		public weak string arg_description;
	}

	[Compact]
	[CCode (free_function = "g_option_group_free")]
	public class OptionGroup {
		public OptionGroup (string name, string description, string help_description, void* user_data, DestroyNotify? destroy);
		[NoArrayLength]
		public void add_entries (OptionEntry[] entries);
		public void set_parse_hooks (OptionParseFunc pre_parse_func, OptionParseFunc post_parse_hook);
		public void set_error_hook (OptionErrorFunc error_func);
		public void set_translate_func (TranslateFunc func, DestroyNotify? destroy_notify);
		public void set_translation_domain (string domain);
	}

	public static delegate bool OptionParseFunc (OptionContext context, OptionGroup group, void* data) throws OptionError;
	public static delegate void OptionErrorFunc (OptionContext context, OptionGroup group, void* data, ref Error error);

	/* Perl-compatible regular expressions */

	public errordomain RegexError {
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

	[Compact]
	[CCode (ref_function = "g_regex_ref", unref_function = "g_regex_unref")]
	public class Regex : Boxed {
		public Regex (string pattern, RegexCompileFlags compile_options = 0, RegexMatchFlags match_options = 0) throws RegexError;
		public string get_pattern ();
		public int get_max_backref ();
		public int get_capture_count ();
		public int get_string_number (string name);
		public static string escape_string (string str, int length = -1);
		public static bool match_simple (string pattern, string str, RegexCompileFlags compile_options = 0, RegexMatchFlags match_options = 0);
		public bool match (string str, RegexMatchFlags match_options = 0, out MatchInfo match_info = null);
		public bool match_full (string str, long string_len = -1, int start_position = 0, RegexMatchFlags match_options = 0, out MatchInfo match_info = null) throws RegexError;
		public bool match_all (string str, RegexMatchFlags match_options = 0, out MatchInfo match_info = null);
		public bool match_all_full (string str, long string_len = -1, int start_position = 0, RegexMatchFlags match_options = 0, out MatchInfo match_info = null) throws RegexError;
		[NoArrayLength]
		public static string[] split_simple (string pattern, string str, RegexCompileFlags compile_options = 0, RegexMatchFlags match_options = 0);
		[NoArrayLength]
		public string[] split (string str, RegexMatchFlags match_options = 0);
		[NoArrayLength]
		public bool split_full (string str, long string_len = -1, int start_position = 0, RegexMatchFlags match_options = 0, int max_tokens = 0) throws RegexError;
		public string replace (string str, long string_len, int start_position, string replacement, RegexMatchFlags match_options = 0) throws RegexError;
		public string replace_literal (string str, long string_len, int start_position, string replacement, RegexMatchFlags match_options = 0) throws RegexError;
		public string replace_eval (string str, long string_len, int start_position, RegexMatchFlags match_options = 0, RegexEvalCallback eval, void* user_data) throws RegexError;
		public static bool check_replacement (out bool has_references = null) throws RegexError;
	}

	public static delegate bool RegexEvalCallback (MatchInfo match_info, StringBuilder result, void* user_data);

	[Compact]
	[CCode (free_function = "g_match_info_free")]
	public class MatchInfo {
		public weak Regex get_regex ();
		public weak string get_string ();
		public bool matches ();
		public bool next () throws RegexError;
		public int get_match_count ();
		public bool is_partial_match ();
		public string expand_references (string string_to_expand) throws RegexError;
		public string fetch (int match_num);
		public bool fetch_pos (int match_num, out int start_pos, out int end_pos);
		public string fetch_named (string name);
		public bool fetch_named_pos (string name, out int start_pos, out int end_pos);
		[NoArrayLength]
		public string[] fetch_all ();
	}

	/* Simple XML Subset Parser */

	public errordomain MarkupError {
		BAD_UTF8,
		EMPTY,
		PARSE,
		UNKNOWN_ELEMENT,
		UNKNOWN_ATTRIBUTE,
		INVALID_CONTENT
	}

	[CCode (cprefix = "G_MARKUP_")]
	public enum MarkupParseFlags {
		TREAT_CDATA_AS_TEXT
	}

	[Compact]
	[CCode (free_function = "g_markup_parse_context_free")]
	public class MarkupParseContext {
		public MarkupParseContext (MarkupParser parser, MarkupParseFlags _flags, void* user_data, DestroyNotify? user_data_dnotify);
		public bool parse (string text, long text_len) throws MarkupError;
		public weak string get_element ();
		public weak SList<string> get_element_stack ();
	}
	
	[NoArrayLength]
	public static delegate void MarkupParserStartElementFunc (MarkupParseContext context, string element_name, string[] attribute_names, string[] attribute_values, void* user_data) throws MarkupError;
	
	public static delegate void MarkupParserEndElementFunc (MarkupParseContext context, string element_name, void* user_data) throws MarkupError;
	
	public static delegate void MarkupParserTextFunc (MarkupParseContext context, string text, ulong text_len, void* user_data) throws MarkupError;
	
	public static delegate void MarkupParserPassthroughFunc (MarkupParseContext context, string passthrough_text, ulong text_len, void* user_data) throws MarkupError;
	
	public static delegate void MarkupParserErrorFunc (MarkupParseContext context, Error error, void* user_data);
	
	public struct MarkupParser {
		public MarkupParserStartElementFunc start_element;
		public MarkupParserEndElementFunc end_element;
		public MarkupParserTextFunc text;
		public MarkupParserPassthroughFunc passthrough;
		public MarkupParserErrorFunc error;
	}

	namespace Markup {
		public static string escape_text (string text, long length = -1);
		[PrintfFormat]
		public static string printf_escaped (string format, ...);
	}

	/* Key-value file parser */

	public errordomain KeyFileError {
		UNKNOWN_ENCODING,
		PARSE,
		NOT_FOUND,
		KEY_NOT_FOUND,
		GROUP_NOT_FOUND,
		INVALID_VALUE
	}

	[Compact]
	[CCode (free_function = "g_key_file_free")]
	public class KeyFile {
		public KeyFile ();
		public void set_list_separator (char separator);
		public bool load_from_file (string file, KeyFileFlags @flags) throws KeyFileError;
		public bool load_from_data (string data, ulong length, KeyFileFlags @flags) throws KeyFileError;
		public bool load_from_data_dirs (string file, out string full_path, KeyFileFlags @flags) throws KeyFileError;
		public string to_data (out size_t length) throws KeyFileError;
		public string get_start_group ();
		[CCode (array_length_type = "gsize")]
		public string[] get_groups ();
		[CCode (array_length_type = "gsize")]
		public string[] get_keys (string group_name) throws KeyFileError;
		public bool has_group (string group_name);
		public bool has_key (string group_name, string key) throws KeyFileError;
		public string get_value (string group_name, string key) throws KeyFileError;
		public string get_string (string group_name, string key) throws KeyFileError;
		public string get_locale_string (string group_name, string key, string locale) throws KeyFileError;
		public bool get_boolean (string group_name, string key) throws KeyFileError;
		public int get_integer (string group_name, string key) throws KeyFileError;
		public double get_double (string group_name, string key) throws KeyFileError;
		[CCode (array_length_type = "gsize")]
		public string[] get_string_list (string group_name, string key) throws KeyFileError;
		[CCode (array_length_type = "gsize")]
		public string[] get_locale_string_list (string group_name, string key, string locale) throws KeyFileError;
		[CCode (array_length_type = "gsize")]
		public bool[] get_boolean_list (string group_name, string key) throws KeyFileError;
		[CCode (array_length_type = "gsize")]
		public int[] get_integer_list (string group_name, string key) throws KeyFileError;
		[CCode (array_length_type = "gsize")]
		public double[] get_double_list (string group_name, string key) throws KeyFileError;
		public string get_comment (string group_name, string key) throws KeyFileError;
		public void set_value (string group_name, string key, string value);
		public void set_string (string group_name, string key, string str);
		public void set_locale_string (string group_name, string key, string locale, string str);
		public void set_boolean (string group_name, string key, bool value);
		public void set_integer (string group_name, string key, int value);
		public void set_double (string group_name, string key, double value);
		public void set_string_list (string group_name, string key, string[] list);
		public void set_locale_string_list (string group_name, string key, string locale, string[] list);
		public void set_boolean_list (string group_name, string key, bool[] list);
		public void set_integer_list (string group_name, string key, int[] list);
		public void set_double_list (string group_name, string key, double[] list);
		public void set_comment (string group_name, string key, string comment);
		public void remove_group (string group_name) throws KeyFileError;
		public void remove_key (string group_name, string key) throws KeyFileError;
		public void remove_comment (string group_name, string key) throws KeyFileError;
	}
	
	[CCode (cprefix = "G_KEY_FILE_")]
	public enum KeyFileFlags {
		NONE,
		KEEP_COMMENTS,
		KEEP_TRANSLATIONS
	}

	/* Bookmark file parser */

	[Compact]
	[CCode (free_function = "g_bookmark_file_free")]
	public class BookmarkFile {
		public BookmarkFile ();
		public bool load_from_file (string file) throws BookmarkFileError;
		public bool load_from_data (string data, size_t length) throws BookmarkFileError;
		public bool load_from_data_dirs (string file, out string full_path) throws BookmarkFileError;
		public string to_data (out size_t length) throws BookmarkFileError;
		public bool to_file (string filename) throws BookmarkFileError;
		public bool has_item (string uri);
		public bool has_group (string uri, string group) throws BookmarkFileError;
		public bool has_application (string uri, string name) throws BookmarkFileError;
		public int get_size ();
		public string[] get_uris ();
		public string get_title (string uri) throws BookmarkFileError;
		public string get_description (string uri) throws BookmarkFileError;
		public string get_mime_type (string uri) throws BookmarkFileError;
		public bool get_is_private (string uri) throws BookmarkFileError;
		public bool get_icon (string uri, out string href, out string mime_type) throws BookmarkFileError;
		public long get_added (string uri) throws BookmarkFileError;
		public long get_modified (string uri) throws BookmarkFileError;
		public long get_visited (string uri) throws BookmarkFileError;
		public string[] get_groups (string uri) throws BookmarkFileError;
		public string[] get_applications (string uri) throws BookmarkFileError;
		public bool get_app_info (string uri, string name, out string exec, out uint count, out long stamp) throws BookmarkFileError;
		public void set_title (string uri, string title);
		public void set_description (string uri, string description);
		public void set_mime_type (string uri, string mime_type);
		public void set_is_private (string uri, bool is_private);
		public void set_icon (string uri, string href, string mime_type);
		public void set_added (string uri, long time_);
		public void set_groups (string uri, string[] groups);
		public void set_modified (string uri, long time_);
		public void set_visited (string uri, long time_);
		public bool set_app_info (string uri, string name, string exec, int count, long time_) throws BookmarkFileError;
		public void add_group (string uri, string group);
		public void add_application (string uri, string name, string exec);
		public bool remove_group (string uri, string group) throws BookmarkFileError;
		public bool remove_application (string uri, string name) throws BookmarkFileError;
		public bool remove_item (string uri) throws BookmarkFileError;
		public bool move_item (string old_uri, string new_uri) throws BookmarkFileError;
	}

	public errordomain BookmarkFileError {
		INVALID_URI,
		INVALID_VALUE,
		APP_NOT_REGISTERED,
		URI_NOT_FOUND,
		READ,
		UNKNOWN_ENCODING,
		WRITE,
		FILE_NOT_FOUND
	}

	/* Testing */

	namespace Test {
		[PrintfFormat]
		public static void minimized_result (double minimized_quantity, string format, ...);
		[PrintfFormat]
		public static void maximized_result (double maximized_quantity, string format, ...);
		public static void init ([CCode (array_length_pos = 0.9)] ref weak string[] args, ...);
		public static bool quick ();
		public static bool slow ();
		public static bool thorough ();
		public static bool perf ();
		public static bool verbose ();
		public static bool quiet ();
		public static int run ();
		public static void add_func (string testpath, Callback test_funcvoid);
		[PrintfFormat]
		public static void message (string format, ...);
		public static void bug_base (string uri_pattern);
		public static void bug (string bug_uri_snippet);
		public static void timer_start ();
		public static double timer_elapsed ();
		public static double timer_last ();
		public static bool trap_fork (uint64 usec_timeout, TestTrapFlags test_trap_flags);
		public static bool trap_has_passed ();
		public static bool trap_reached_timeout ();
		public static void trap_assert_passed ();
		public static void trap_assert_failed ();
		public static void trap_assert_stdout (string soutpattern);
		public static void trap_assert_stdout_unmatched (string soutpattern);
		public static void trap_assert_stderr (string serrpattern);
		public static void trap_assert_stderr_unmatched (string serrpattern);
		public static bool rand_bit ();
		public static int32 rand_int ();
		public static int32 rand_int_range (int32 begin, int32 end);
		public static double rand_double ();
		public static double rand_double_range ();
	}

	[Flags]
	[CCode (cprefix = "G_TEST_TRAP_")]
	public enum TestTrapFlags {
		SILENCE_STDOUT,
		SILENCE_STDERR,
		INHERIT_STDIN
	}

	/* Doubly-Linked Lists */

	[Compact]
	[CCode (dup_function = "g_list_copy", free_function = "g_list_free")]
	public class List<G> {
		[ReturnsModifiedPointer ()]
		public void append (G# data);
		[ReturnsModifiedPointer ()]
		public void prepend (G# data);
		[ReturnsModifiedPointer ()]
		public void insert (G# data, int position);
		[ReturnsModifiedPointer ()]
		public void insert_before (List<G> sibling, G# data);
		[ReturnsModifiedPointer ()]
		public void insert_sorted (G# data, CompareFunc compare_func);
		[ReturnsModifiedPointer ()]
		public void remove (G data);
		[ReturnsModifiedPointer ()]
		public void remove_link (List<G> llink);
		[ReturnsModifiedPointer ()]
		public void delete_link (List<G> link_);
		[ReturnsModifiedPointer ()]
		public void remove_all (G data);
		
		public uint length ();
		public List<weak G> copy ();
		[ReturnsModifiedPointer ()]
		public void reverse ();
		[ReturnsModifiedPointer ()]
		public void sort (CompareFunc compare_func);
		[ReturnsModifiedPointer ()]
		public void insert_sorted_with_data (G# data, CompareDataFunc compare_func);
		[ReturnsModifiedPointer ()]
		public void sort_with_data (CompareDataFunc compare_func);
		[ReturnsModifiedPointer ()]
		public void concat (List<G># list2);
		public void @foreach (Func func);

		public weak List<G> first ();
		public weak List<G> last ();
		public weak List<G> nth (uint n);
		public weak G nth_data (uint n);
		public weak List<G> nth_prev (uint n);
		
		public weak List<G> find (G data);
		public weak List<G> find_custom (G data, CompareFunc func);
		public int position (List<G> llink);
		public int index (G data);
		
		public G data;
		public List<G> next;
		public weak List<G> prev;
	}
	
	/* Singly-Linked Lists */

	[Compact]
	[CCode (dup_function = "g_slist_copy", free_function = "g_slist_free")]
	public class SList<G> {
		[ReturnsModifiedPointer ()]
		public void append (G# data);
		[ReturnsModifiedPointer ()]
		public void prepend (G# data);
		[ReturnsModifiedPointer ()]
		public void insert (G# data, int position);
		[ReturnsModifiedPointer ()]
		public void insert_before (SList<G> sibling, G# data);
		[ReturnsModifiedPointer ()]
		public void insert_sorted (G# data, CompareFunc compare_func);
		[ReturnsModifiedPointer ()]
		public void remove (G data);
		[ReturnsModifiedPointer ()]
		public void remove_link (SList<G> llink);
		[ReturnsModifiedPointer ()]
		public void delete_link (SList<G> link_);
		[ReturnsModifiedPointer ()]
		public void remove_all (G data);

		public uint length ();
		public SList<weak G> copy ();
		[ReturnsModifiedPointer ()]
		public void reverse ();
		[ReturnsModifiedPointer ()]
		public void insert_sorted_with_data (G# data, CompareDataFunc compare_func);
		[ReturnsModifiedPointer ()]
		public void sort (CompareFunc compare_func);
		[ReturnsModifiedPointer ()]
		public void sort_with_data (CompareDataFunc compare_func);
		[ReturnsModifiedPointer ()]
		public void concat (SList<G># list2);
		public void @foreach (Func func);

		public weak SList<G> last ();
		public weak SList<G> nth (uint n);
		public weak G nth_data (uint n);

		public weak SList<G> find (G data);
		public weak SList<G> find_custom (G data, CompareFunc func);
		public int position (SList<G> llink);
		public int index (G data);

		public G data;
		public SList<G> next;
	}
	
	public static delegate int CompareFunc (void* a, void* b);

	public delegate int CompareDataFunc (void* a, void* b);
	
	[CCode (cname = "strcmp")]
	public static GLib.CompareFunc strcmp;
	
	/* Double-ended Queues */

	[Compact]
	[CCode (dup_function = "g_queue_copy", free_function = "g_queue_free")]
	public class Queue<G> {
		public weak List<G> head;
		public weak List<G> tail;
		public uint length;
	
		public Queue ();

		public void clear ();
		public bool is_empty ();
		public uint get_length ();
		public void reverse ();
		public Queue copy ();
		public weak List<G> find (G data);
		public weak List<G> find_custom (G data, CompareFunc func);
		public void sort (CompareDataFunc compare_func, void* user_data);
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
		public void insert_sorted (List<G> sibling, G# data, CompareDataFunc func, void* user_data);
	}

	/* Sequences */

	[Compact]
	[CCode (free_function = "g_sequence_free")]
	public class Sequence<G> {
		public Sequence (DestroyNotify? data_destroy);
		public int get_length ();
		public void @foreach (Func func);
		public static void foreach_range (SequenceIter<G> begin, SequenceIter<G> end, Func func);
		public void sort (CompareDataFunc cmp_func);
		public void sort_iter (SequenceIterCompareFunc<G> func);
		public weak SequenceIter<G> get_begin_iter ();
		public weak SequenceIter<G> get_end_iter ();
		public weak SequenceIter<G> get_iter_at_pos (int pos);
		public weak SequenceIter<G> append (G# data);
		public weak SequenceIter<G> prepend (G# data);
		public static weak SequenceIter<G> insert_before (SequenceIter<G> iter, G# data);
		public static void move (SequenceIter<G> src, SequenceIter<G> dest);
		public static void swap (SequenceIter<G> src, SequenceIter<G> dest);
		public weak SequenceIter<G> insert_sorted (G# data, CompareDataFunc cmp_func);
		public weak SequenceIter<G> insert_sorted_iter (G# data, SequenceIterCompareFunc<G> iter_cmp);
		public static void sort_changed (SequenceIter<G> iter, CompareDataFunc cmp_func);
		public static void sort_changed_iter (SequenceIter<G> iter, SequenceIterCompareFunc<G> iter_cmp);
		public static void remove (SequenceIter<G> iter);
		public static void remove_range (SequenceIter<G> begin, SequenceIter<G> end);
		public static void move_range (SequenceIter<G> dest, SequenceIter<G> begin, SequenceIter<G> end);
		public weak SequenceIter<G> search (G data, CompareDataFunc cmp_func);
		public weak SequenceIter<G> search_iter (G data, SequenceIterCompareFunc<G> iter_cmp);
		public static weak G get (SequenceIter<G> iter);
		public static void set (SequenceIter<G> iter, G# data);
		public static weak SequenceIter<G> range_get_midpoint (SequenceIter<G> begin, SequenceIter<G> end);
	}

	[Compact]
	[CCode (ref_function = "", unref_function = "")]
	public class SequenceIter<G> {
		public bool is_begin ();
		public bool is_end ();
		public weak SequenceIter<G> next ();
		public weak SequenceIter<G> prev ();
		public int get_position ();
		public weak SequenceIter<G> move (int delta);
		public weak Sequence<G> get_sequence ();
		public int compare (SequenceIter<G> other);
	}

	public delegate int SequenceIterCompareFunc<G> (SequenceIter<G> a, SequenceIter<G> b);

	/* Hash Tables */

	[Compact]
	[CCode (ref_function = "g_hash_table_ref", unref_function = "g_hash_table_unref")]
	public class HashTable<K,V> : Boxed {
		public HashTable (HashFunc hash_func, EqualFunc key_equal_func);
		public HashTable.full (HashFunc hash_func, EqualFunc key_equal_func, DestroyNotify? key_destroy_func, DestroyNotify? value_destroy_func);
		public void insert (K# key, V# value);
		public void replace (K# key, V# value);
		public weak V lookup (K key);
		public bool remove (K key);
		public void remove_all ();
		public List<weak K> get_keys ();
		public List<weak V> get_values ();
		[CCode (cname = "g_hash_table_foreach")]
		public void for_each (HFunc func);
		public uint size ();
	}
	
	public static delegate uint HashFunc (void* key);
	public static delegate bool EqualFunc (void* a, void* b);
	public delegate void HFunc (void* key, void* value);

	public static delegate void DestroyNotify (void* data);
	
	[CCode (cname = "g_direct_hash")]
	public static GLib.HashFunc direct_hash;
	[CCode (cname = "g_direct_equal")]
	public static GLib.EqualFunc direct_equal;
	[CCode (cname = "g_int_hash")]
	public static GLib.HashFunc int_hash;
	[CCode (cname = "g_int_equal")]
	public static GLib.EqualFunc int_equal;
	[CCode (cname = "g_str_hash")]
	public static GLib.HashFunc str_hash;
	[CCode (cname = "g_str_equal")]
	public static GLib.EqualFunc str_equal;
	[CCode (cname = "g_free")]
	public static GLib.DestroyNotify g_free;
	[CCode (cname = "g_object_unref")]
	public static GLib.DestroyNotify g_object_unref;
	[CCode (cname = "g_list_free")]
	public static GLib.DestroyNotify g_list_free;

	/* Strings */

	[Compact]
	[CCode (cname = "GString", cprefix = "g_string_", free_function = "g_string_free", type_id = "G_TYPE_GSTRING")]
	public class StringBuilder : Boxed {
		public StringBuilder (string init = "");
		[CCode (cname = "g_string_sized_new")]
		public StringBuilder.sized (ulong dfl_size);
		public weak StringBuilder assign (string rval);
		public weak StringBuilder append (string val);
		public weak StringBuilder append_c (char c);
		public weak StringBuilder append_unichar (unichar wc);
		public weak StringBuilder append_len (string val, long len);
		public weak StringBuilder prepend (string val);
		public weak StringBuilder prepend_c (char c);
		public weak StringBuilder prepend_unichar (unichar wc);
		public weak StringBuilder prepend_len (string val, long len);
		public weak StringBuilder insert (long pos, string val);
		public weak StringBuilder erase (long pos, long len);

		[PrintfFormat]
		public void printf (string format, ...);
		[PrintfFormat]
		public void append_printf (string format, ...);

		public string str;
		public long len;
		public long allocated_len;
	}

	/* Pointer Arrays */

	[Compact]
	[CCode (free_function = "g_ptr_array_free")]
	public class PtrArray {
	}

	/* Byte Arrays */

	[Compact]
	[CCode (free_function = "g_byte_array_free")]
	public class ByteArray {
	}

	/* N-ary Trees */

	[Compact]
	[CCode (free_function = "g_node_destroy")]
	public class Node<G> {
		public G data;
		public Node next;
		public Node prev;
		public Node parent;
		public Node children;
	}

	/* Quarks */
	
	public struct Quark : uint32 {
		public static Quark from_string (string str);
		public weak string to_string ();
	}

	/* Keyed Data Lists */

	[CCode (cname = "GData*")]
	public struct Datalist<G> {
		public Datalist ();
		public void clear ();
		public G id_get_data (Quark key_id);
		public void id_set_data (Quark key_id, G# data);
		public void id_set_data_full (Quark key_id, G# data, DestroyNotify? destroy_func);
		public void id_remove_data (Quark key_id);
		public G id_remove_no_notify (Quark key_id);
		public void @foreach (DataForeachFunc func);
		public G get_data (string key);
		public void set_data_full (string key, G# data, DestroyNotify? destry_func);
		public G remove_no_notify (string key);
		public void set_data (string key, G# data);
		public void remove_data (string key);
	}

	public delegate void DataForeachFunc<G> (Quark key_id, G data);

	/* GArray */

	[Compact]
	public class Array<G> {
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
		public void sort_with_data (CompareDataFunc compare_func, void* user_data);
		[ReturnsModifiedPointer ()]
		public void set_size (uint length);
		public string free (bool free_segment);
	}
	
	/* GTree */
	
	public static delegate int TraverseFunc (void* key, void* value, void* data);
	
	[CCode (c_prefix="C_")]
	public enum TraverseType {
		IN_ORDER,
		PRE_ORDER,
		POST_ORDER,
		LEVEL_ORDER
	}

	[Compact]
	[CCode (free_function = "g_tree_destroy")]
	public class Tree<K,V> {
		public Tree (CompareFunc key_compare_func);
		public Tree.with_data (CompareFunc key_compare_func, void* key_compare_data);
		public Tree.full (CompareFunc key_compare_func, void* key_compare_data, DestroyNotify? key_destroy_func, DestroyNotify? value_destroy_func);
		public void insert (K key, V value);
		public void replace (K key, V value);
		public int nnodes ();
		public int height ();
		public weak V lookup (K key);
		public bool lookup_extended (K lookup_key, K orig_key, V value);
		public void tree_foreach (TraverseFunc traverse_func, TraverseType traverse_type, void* user_data);
		public weak V tree_search (CompareFunc search_func, void* user_data);
		public bool remove (K key);
		public bool steal (K key);
	}
	
	/* Internationalization */
	
	[CCode (cname = "_", cheader_filename = "glib.h,glib/gi18n-lib.h")]
	public static weak string _ (string str);
	[CCode (cname = "Q_", cheader_filename = "glib.h,glib/gi18n-lib.h")]
	public static weak string Q_ (string str);
	[CCode (cname = "N_", cheader_filename = "glib.h,glib/gi18n-lib.h")]
	public static weak string N_ (string str);
	
	[CCode (cprefix = "LC_", cheader_filename = "locale.h")]
	public enum LocaleCategory {
		ALL,
		COLLATE,
		CTYPE,
		MESSAGES,
		MONETARY,
		NUMERIC,
		TIME
	}
	
	namespace Intl {
		[CCode (cname = "setlocale", cheader_filename = "locale.h")]
		public static weak string? setlocale (LocaleCategory category, string? locale);
		[CCode (cname = "bindtextdomain", cheader_filename = "glib/gi18n-lib.h")]
		public static weak string? bindtextdomain (string domainname, string? dirname);
		[CCode (cname = "textdomain", cheader_filename = "glib/gi18n-lib.h")]
		public static weak string? textdomain (string? domainname);
		[CCode (cname = "bind_textdomain_codeset", cheader_filename = "glib/gi18n-lib.h")]
		public static weak string? bind_textdomain_codeset (string domainname, string? codeset);
	}

	namespace Signal {
		public static void query (uint signal_id, out SignalQuery query);
		public static uint lookup (string name, Type itype);
		public static weak string name (uint signal_id);
		public static uint[] list_ids (Type itype);
		public static void emit (void* instance, uint signal_id, Quark detail, ...);
		public static void emit_by_name (void* instance, string detailed_signal, ...);
		public static ulong connect (void* instance, string detailed_signal, Callback handler, void* data);
		public static ulong connect_after (void* instance, string detailed_signal, Callback handler, void* data);
		public static ulong connect_swapped (void* instance, string detailed_signal, Callback handler, void* data);
		public static ulong connect_object (void* instance, string detailed_signal, Callback handler, Object gobject, ConnectFlags flags);
		public static ulong connect_data (void* instance, string detailed_signal, Callback handler, void* data, ClosureNotify destroy_data, ConnectFlags flags);
		public static ulong connect_closure (void* instance, string detailed_signal, Closure closure, bool after);
		public static ulong connect_closure_by_id (void* instance, uint signal_id, Quark detail, Closure closure, bool after);
		public static bool has_handler_pending (void* instance, uint signal_id, Quark detail, bool may_be_blocked);
		public static void stop_emission (void* instance, uint signal_id, Quark detail);
		public static void stop_emission_by_name (void* instance, string detailed_signal);
		public static void override_class_closure (uint signal_id, Type instance_type, Closure class_closure);
		[NoArrayLength]
		public static void chain_from_overridden (Value[] instance_and_params, out Value return_value);
		public static ulong add_emission_hook (uint signal_id, Quark detail, SignalEmissionHook hook_func, DestroyNotify? data_destroy);
		public static void remove_emission_hook (uint signal_id, ulong hook_id);
		public static bool parse_name (string detailed_signal, Type itype, out uint signal_id, out Quark detail, bool force_detail_quark);
	}

	namespace SignalHandler {
		public static void block (void* instance, ulong handler_id);
		public static void unblock (void* instance, ulong handler_id);
		public static void disconnect (void* instance, ulong handler_id);
		public static ulong find (void* instance, SignalMatchType mask, uint signal_id, Quark detail, Closure? closure, void* func, void* data);
		public static bool is_connected (void* instance, ulong handler_id);

		[CCode (cname = "g_signal_handlers_block_matched")]
		public static uint block_matched (void* instance, SignalMatchType mask, uint signal_id, Quark detail, Closure? closure, void* func, void* data);
		[CCode (cname = "g_signal_handlers_unblock_matched")]
		public static uint unblock_matched (void* instance, SignalMatchType mask, uint signal_id, Quark detail, Closure? closure, void* func, void* data);
		[CCode (cname = "g_signal_handlers_disconnect_matched")]
		public static uint disconnect_matched (void* instance, SignalMatchType mask, uint signal_id, Quark detail, Closure? closure, void* func, void* data);
		[CCode (cname = "g_signal_handlers_block_by_func")]
		public static uint block_by_func (void* instance, void* func, void* data);
		[CCode (cname = "g_signal_handlers_unblock_by_func")]
		public static uint unblock_by_func (void* instance, void* func, void* data);
		[CCode (cname = "g_signal_handlers_disconnect_by_func")]
		public static uint disconnect_by_func (void* instance, void* func, void* data);
	}

	public struct SignalQuery {
		public uint signal_id;
		public weak string signal_name;
		public Type itype;
		public SignalFlags signal_flags;
		public Type return_type;
		public uint n_params;
		[NoArrayLength]
		public weak Type[] param_types;
	}

	[CCode (cprefix = "G_SIGNAL_MATCH_")]
	public enum SignalMatchType {
		ID,
		DETAIL,
		CLOSURE,
		FUNC,
		DATA,
		UNBLOCKED
	}

	[Compact]
	public class PatternSpec {
		public PatternSpec (string pattern);
		public bool equal (PatternSpec pspec);
		[CCode (cname = "g_pattern_match")]
		public bool match (uint string_length, string str, string? str_reversed);
		[CCode (cname = "g_pattern_match_string")]
		public bool match_string (string str);
		[CCode (cname = "g_pattern_match_simple")]
		public static bool match_simple (string pattern, string str);
	}
}
