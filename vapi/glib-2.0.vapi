/* glib-2.0.vala
 *
 * Copyright (C) 2006-2009  Jürg Billeter
 * Copyright (C) 2006-2008  Raffaele Sandrini
 * Copyright (C) 2007  Mathias Hasselmann
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public
 * License as published by the Free Software Foundation; either
 * version 2.1 of the License, or (at your option) any later version.
 *
 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public
 * License along with this library; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301  USA
 *
 * As a special exception, if you use inline functions from this file, this
 * file does not by itself cause the resulting executable to be covered by
 * the GNU Lesser General Public License.
 * 
 * Author:
 * 	Jürg Billeter <j@bitron.ch>
 *	Raffaele Sandrini <rasa@gmx.ch>
 *	Mathias Hasselmann <mathias.hasselmann@gmx.de>
 */

[SimpleType]
[CCode (cname = "gboolean", cheader_filename = "glib.h", type_id = "G_TYPE_BOOLEAN", marshaller_type_name = "BOOLEAN", get_value_function = "g_value_get_boolean", set_value_function = "g_value_set_boolean", default_value = "FALSE", type_signature = "b")]
[BooleanType]
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

	[CCode (cname = "abs")]
	public int abs ();

	[CCode (cname = "GINT_TO_BE")]
	public int to_big_endian ();
	[CCode (cname = "GINT_TO_LE")]
	public int to_little_endian ();

	[CCode (cname = "GINT_FROM_BE")]
	public static int from_big_endian (int val);
	[CCode (cname = "GINT_FROM_LE")]
	public static int from_little_endian (int val);
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

	[CCode (cname = "GUINT_TO_BE")]
	public uint to_big_endian ();
	[CCode (cname = "GUINT_TO_LE")]
	public uint to_little_endian ();

	[CCode (cname = "GUINT_FROM_BE")]
	public static uint from_big_endian (uint val);
	[CCode (cname = "GUINT_FROM_LE")]
	public static uint from_little_endian (uint val);
}

[SimpleType]
[CCode (cname = "gshort", cheader_filename = "glib.h", has_type_id = false, default_value = "0", type_signature = "n")]
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
[CCode (cname = "gushort", cheader_filename = "glib.h", has_type_id = false, default_value = "0U", type_signature = "q")]
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
	[CCode (cname = "labs")]
	public long abs ();

	[CCode (cname = "GLONG_TO_BE")]
	public long to_big_endian ();
	[CCode (cname = "GLONG_TO_LE")]
	public long to_little_endian ();

	[CCode (cname = "GLONG_FROM_BE")]
	public static long from_big_endian (long val);
	[CCode (cname = "GLONG_FROM_LE")]
	public static long from_little_endian (long val);
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

	[CCode (cname = "GULONG_TO_BE")]
	public ulong to_big_endian ();
	[CCode (cname = "GULONG_TO_LE")]
	public ulong to_little_endian ();

	[CCode (cname = "GULONG_FROM_BE")]
	public static ulong from_big_endian (ulong val);
	[CCode (cname = "GULONG_FROM_LE")]
	public static ulong from_little_endian (ulong val);
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

	[CCode (cname = "GINT16_TO_BE")]
	public int16 to_big_endian ();
	[CCode (cname = "GINT16_TO_LE")]
	public int16 to_little_endian ();

	[CCode (cname = "GINT16_FROM_BE")]
	public static int16 from_big_endian (int16 val);
	[CCode (cname = "GINT16_FROM_LE")]
	public static int16 from_little_endian (int16 val);
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

	[CCode (cname = "GUINT16_TO_BE")]
	public uint16 to_big_endian ();
	[CCode (cname = "GUINT16_TO_LE")]
	public uint16 to_little_endian ();

	[CCode (cname = "GUINT16_FROM_BE")]
	public static uint16 from_big_endian (uint16 val);
	[CCode (cname = "GUINT16_FROM_LE")]
	public static uint16 from_little_endian (uint16 val);
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

	[CCode (cname = "GINT32_TO_BE")]
	public int32 to_big_endian ();
	[CCode (cname = "GINT32_TO_LE")]
	public int32 to_little_endian ();

	[CCode (cname = "GINT32_FROM_BE")]
	public static int32 from_big_endian (int32 val);
	[CCode (cname = "GINT32_FROM_LE")]
	public static int32 from_little_endian (int32 val);
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

	[CCode (cname = "GUINT32_TO_BE")]
	public uint32 to_big_endian ();
	[CCode (cname = "GUINT32_TO_LE")]
	public uint32 to_little_endian ();

	[CCode (cname = "GUINT32_FROM_BE")]
	public static uint32 from_big_endian (uint32 val);
	[CCode (cname = "GUINT32_FROM_LE")]
	public static uint32 from_little_endian (uint32 val);
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
	[CCode (cname = "llabs")]
	public int64 abs ();

	[CCode (cname = "GINT64_TO_BE")]
	public int64 to_big_endian ();
	[CCode (cname = "GINT64_TO_LE")]
	public int64 to_little_endian ();

	[CCode (cname = "GINT64_FROM_BE")]
	public static int64 from_big_endian (int64 val);
	[CCode (cname = "GINT64_FROM_LE")]
	public static int64 from_little_endian (int64 val);
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

	[CCode (cname = "GUINT64_TO_BE")]
	public uint64 to_big_endian ();
	[CCode (cname = "GUINT64_TO_LE")]
	public uint64 to_little_endian ();

	[CCode (cname = "GUINT64_FROM_BE")]
	public static uint64 from_big_endian (uint64 val);
	[CCode (cname = "GUINT64_FROM_LE")]
	public static uint64 from_little_endian (uint64 val);
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

	[CCode (cname = "MIN")]
	public static double min (double a, double b);
	[CCode (cname = "MAX")]
	public static double max (double a, double b);
	[CCode (cname = "CLAMP")]
	public double clamp (double low, double high);

	[CCode (cname = "G_ASCII_DTOSTR_BUF_SIZE")]
	public const int DTOSTR_BUF_SIZE;
	[CCode (cname = "g_ascii_dtostr", instance_pos = -1)]
	public weak string to_str (char[] buffer);
	[CCode (cname = "g_ascii_formatd", instance_pos = -1)]
	public weak string format (char[] buffer, string format = "%g");

	public string to_string () {
		return this.to_str(new char[DTOSTR_BUF_SIZE]);
	}
}

[CCode (cheader_filename = "time.h")]
[ByRef]
[IntegerType (rank = 8)]
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

[CCode (cname = "GUnicodeType", cprefix = "G_UNICODE_", has_type_id = false)]
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

[CCode (cname = "GUnicodeBreakType", cprefix = "G_UNICODE_BREAK_", has_type_id = false)]
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

[CCode (cname = "GNormalizeMode", cprefix = "G_NORMALIZE_", has_type_id = false)]
public enum NormalizeMode {
	DEFAULT,
	NFD,
	DEFAULT_COMPOSE,
	NFC,
	ALL,
	NFKD,
	ALL_COMPOSE,
	NFKC
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
	[CCode (cname = "sscanf", cheader_filename = "stdio.h"), ScanfFormat]
	public int scanf (...);
	[CCode (cname = "g_strconcat")]
	public string concat (string string2, ...);
	[CCode (cname = "g_strescape")]
	public string escape (string exceptions);
	[CCode (cname = "g_strcompress")]
	public string compress ();
	[CCode (cname = "g_strsplit", array_length = false, array_null_terminated = true)]
	[NoArrayLength]
	public string[] split (string delimiter, int max_tokens = 0);
	[CCode (cname = "g_strsplit_set", array_length = false, array_null_terminated = true)]
	public string[] split_set (string delimiters, int max_tokens = 0);
	[CCode (cname = "g_strjoinv")]
	[NoArrayLength]
	public static string joinv (string separator, [CCode (array_length = false, array_null_terminated = true)] string[] str_array);
	[CCode (cname = "g_strjoin")]
	public static string join (string separator, ...);
	[CCode (cname = "g_strnfill")]
	public static string nfill (size_t length, char fill_char);

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
	public long len (ssize_t max = -1);
	[CCode (cname = "g_utf8_strchr")]
	public weak string chr (ssize_t len, unichar c);
	[CCode (cname = "g_utf8_strrchr")]
	public weak string rchr (ssize_t len, unichar c);
	[CCode (cname = "g_utf8_strreverse")]
	public string reverse (ssize_t len = -1);
	[CCode (cname = "g_utf8_validate")]
	public bool validate (ssize_t max_len = -1, out string end = null);
	[CCode (cname = "g_utf8_normalize")]
	public string normalize (ssize_t len = -1, NormalizeMode mode = NormalizeMode.DEFAULT);
	
	[CCode (cname = "g_utf8_strup")]
	public string up (ssize_t len = -1);
	[CCode (cname = "g_utf8_strdown")]
	public string down (ssize_t len = -1);
	[CCode (cname = "g_utf8_casefold")]
	public string casefold (ssize_t len = -1);
	[CCode (cname = "g_utf8_collate")]
	public int collate (string str2);

	[CCode (cname = "g_locale_to_utf8")]
	public string locale_to_utf8 (ssize_t len, out size_t bytes_read, out size_t bytes_written, out GLib.Error error = null);
  
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
	[CCode (cname = "g_ascii_strtod")]
	public double to_double (out weak string endptr = null);
	[CCode (cname = "strtoul")]
	public ulong to_ulong (out weak string endptr = null, int _base = 0);
	[CCode (cname = "g_ascii_strtoll")]
	public int64 to_int64 (out weak string endptr = null, int _base = 0);
	public bool to_bool () {
		if (this == "true") {
			return true;
		} else {
			return false;
		}
	}

	[CCode (cname = "strlen")]
	public size_t size ();

	[CCode (cname = "g_utf8_skip")]
	public static char[] skip;

	/* modifies string in place */
	[CCode (cname = "g_strcanon")]
	public void canon (string valid_chars, char substitutor);

	// n is size in bytes, not length in characters
	[CCode (cname = "g_strndup")]
	public string ndup (size_t n);

	public string substring (long offset, long len = -1) {
		long string_length = this.len ();
		if (offset < 0) {
			offset = string_length + offset;
			GLib.return_val_if_fail (offset >= 0, null);
		} else {
			GLib.return_val_if_fail (offset <= string_length, null);
		}
		if (len < 0) {
			len = string_length - offset;
		}
		GLib.return_val_if_fail (offset + len <= string_length, null);
		weak string start = this.offset (offset);
		return start.ndup (((char*) start.offset (len)) - ((char*) start));
	}

	public bool contains (string needle) {
		return this.str (needle) != null;
	}

	public string replace (string old, string replacement) {
		try {
			var regex = new GLib.Regex (GLib.Regex.escape_string (old));
			return regex.replace_literal (this, -1, 0, replacement);
		} catch (GLib.RegexError e) {
			GLib.assert_not_reached ();
		}
	}

	public long length {
		get { return this.len (); }
	}
}

[CCode (cprefix = "G", lower_case_cprefix = "g_", cheader_filename = "glib.h")]
namespace GLib {
	[CCode (lower_case_cprefix = "", cheader_filename = "math.h")]
	namespace Math {
		[CCode (cname = "G_E")]
		public const double E;
		
		[CCode (cname = "G_PI")]
		public const double PI;

		[CCode (cname = "G_LN2")]
		public const double LN2;

		[CCode (cname = "G_LN10")]
		public const double LN10;

		[CCode (cname = "G_PI_2")]
		public const double PI_2;

		[CCode (cname = "G_PI_4")]
		public const double PI_4;

		[CCode (cname = "G_SQRT2")]
		public const double SQRT2;

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
		public static void sincos (double x, out double sinx, out double cosx);
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
	
	namespace Priority {
		public const int HIGH;
		public const int DEFAULT;
		public const int HIGH_IDLE;
		public const int DEFAULT_IDLE;
		public const int LOW;
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
		public int query (int max_priority, out int timeout_, PollFD[] fds);
		[CCode (array_length = false)]
		public int check (int max_priority, PollFD[] fds, int n_fds);
		public void dispatch ();
		public void set_poll_func (PollFunc func);
		public PollFunc get_poll_func ();
		public void add_poll (ref PollFD fd, int priority);
		public void remove_poll (ref PollFD fd);
		public int depth ();
		[CCode (cname = "g_main_current_source")]
		public static weak Source current_source ();
	}
	
	[CCode (has_target = false)]
	public delegate int PollFunc (PollFD[] ufds, uint nfsd, int timeout_);

	[CCode (cname = "GSource")]
	public class TimeoutSource : Source {
		public TimeoutSource (uint interval);
	}

	namespace Timeout {
		public static uint add (uint interval, SourceFunc function);
		public static uint add_full (int priority, uint interval, owned SourceFunc function);
		public static uint add_seconds (uint interval, SourceFunc function);
		public static uint add_seconds_full (int priority, uint interval, owned SourceFunc function);
	}

	[CCode (cname = "GSource")]
	public class IdleSource : Source {
		public IdleSource ();
	}

	namespace Idle {
		public static uint add (SourceFunc function);
		public static uint add_full (int priority, owned SourceFunc function);
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
		public static uint add_full (int priority, Pid pid, owned ChildWatchFunc function);
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
		public void set_callback (owned SourceFunc func);
		public void set_callback_indirect (void* callback_data, SourceCallbackFuncs callback_funcs);
		public void add_poll (ref PollFD fd);
		public void remove_poll (ref PollFD fd);
		public void get_current_time (out TimeVal timeval);
		public static void remove (uint id);
		public static bool remove_by_funcs_user_data (void* user_data);
		public static bool remove_by_user_data (void* user_data);
	}

	[CCode (has_target = false)]
	public delegate void SourceDummyMarshal ();

	[CCode (has_target = false)]
	public delegate bool SourcePrepareFunc (Source source, out int timeout_);
	[CCode (has_target = false)]
	public delegate bool SourceCheckFunc (Source source);
	[CCode (has_target = false)]
	public delegate bool SourceDispatchFunc (Source source, SourceFunc _callback);
	[CCode (has_target = false)]
	public delegate void SourceFinalizeFunc (Source source);

	[Compact]
	public class SourceFuncs {
		public SourcePrepareFunc prepare;
		public SourceCheckFunc check;
		public SourceDispatchFunc dispatch;
		public SourceFinalizeFunc finalize;
	}

	[CCode (has_target = false)]
	public delegate void SourceCallbackRefFunc (void* cb_data);
	[CCode (has_target = false)]
	public delegate void SourceCallbackUnrefFunc (void* cb_data);
	[CCode (has_target = false)]
	public delegate void SourceCallbackGetFunc (void* cb_data, Source source, SourceFunc func);

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

	public delegate void* ThreadFunc ();
	public delegate void Func (void* data);
	
	[CCode (has_type_id = false)]
	public enum ThreadPriority {
		LOW,
		NORMAL,
		HIGH,
		URGENT
	}
	
	[Compact]
	public class Thread {
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

	[CCode (destroy_function = "g_static_mutex_free")]
	public struct StaticMutex {
		public StaticMutex ();
		public void lock ();
		public bool trylock ();
		public void unlock ();
		public void lock_full ();
	}

	[CCode (destroy_function = "g_static_rec_mutex_free")]
	public struct StaticRecMutex {
		public StaticRecMutex ();
		public void lock ();
		public bool trylock ();
		public void unlock ();
		public void lock_full ();
	}

	[CCode (destroy_function = "g_static_rw_lock_free")]
	public struct StaticRWLock {
		public StaticRWLock ();
		public void reader_lock ();
		public bool reader_trylock ();
		public void reader_unlock ();
		public void writer_lock ();
		public bool writer_trylock ();
		public void writer_unlock ();
	}

	[Compact]
	[CCode (ref_function = "", unref_function = "")]
	public class Private {
		public Private (DestroyNotify destroy_func);
		public void* get ();
		public void set (void* data);
	}

	[CCode (destroy_function = "g_static_private_free")]
	public struct StaticPrivate {
		public StaticPrivate ();
		public void* get ();
		public void set (void* data, DestroyNotify? destroy_func);
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
		public ThreadPool (Func func, int max_threads, bool exclusive) throws ThreadError;
		public void push (void* data) throws ThreadError;
		public void set_max_threads (int max_threads) throws ThreadError;
		public int get_max_threads ();
		public uint get_num_threads ();
		public uint unprocessed ();
		public static void set_max_unused_threads (int max_threads);
		public static int get_max_unused_threads ();
		public static uint get_num_unused_threads ();
		public static void stop_unused_threads ();
		public void set_sort_function (CompareDataFunc func);
		public static void set_max_idle_time (uint interval);
		public static uint get_max_idle_time ();
	}
	
	/* Asynchronous Queues */

	[Compact]
	[CCode (ref_function = "g_async_queue_ref", unref_function = "g_async_queue_unref")]
	public class AsyncQueue<G> {
		public AsyncQueue ();
		public void push (owned G data);
		public void push_sorted (owned G data, CompareDataFunc func);
		public G pop ();
		public G try_pop ();
		public G timed_pop (ref TimeVal end_time);
		public int length ();
		public void sort (CompareDataFunc func);
		public void @lock ();
		public void unlock ();
		public void ref_unlocked ();
		public void unref_and_unlock ();
		public void push_unlocked (owned G data);
		public void push_sorted_unlocked (owned G data, CompareDataFunc func);
		public G pop_unlocked ();
		public G try_pop_unlocked ();
		public G timed_pop_unlocked (ref TimeVal end_time);
		public int length_unlocked ();
		public void sort_unlocked (CompareDataFunc func);
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
		[CCode (cname = "memset")]
		public static void* set (void* dest, int src, size_t n);
		[CCode (cname = "g_memmove")]
		public static void* move (void* dest, void* src, size_t n);
		[CCode (cname = "g_memdup")]
		public static void* dup (void* mem, uint n);
	}

	/* IO Channels */

	[Compact]
	[CCode (ref_function = "g_io_channel_ref", unref_function = "g_io_channel_unref")]
	public class IOChannel {
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
		[CCode (cname = "g_io_add_watch_full")]
		public uint add_watch_full (int priority, IOCondition condition, owned IOFunc func);
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

	[CCode (cprefix = "G_SEEK_", has_type_id = false)]
	public enum SeekType {
		CUR,
		SET,
		END
	}
	
	[CCode (has_type_id = false)]
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

	[Flags]
	[CCode (cprefix = "G_IO_")]
	public enum IOCondition {
		IN,
		OUT,
		PRI,
		ERR,
		HUP,
		NVAL
	}

	public delegate bool IOFunc (IOChannel source, IOCondition condition);

	[CCode (cprefix = "G_IO_FLAG_", has_type_id = false)]
	public enum IOFlags {
		APPEND,
		NONBLOCK,
		IS_READABLE,
		IS_WRITEABLE,
		IS_SEEKABLE,
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
	[CCode (has_target = false)]
	public delegate void PrintFunc (string text);
	[PrintfFormat]
	public static void printerr (string format, ...);
	public static void set_printerr_handler (PrintFunc func);

	public static void return_if_fail (bool expr);
	[CCode (sentinel = "")]
	public static void return_val_if_fail (bool expr, ...);
	[NoReturn]
	public static void return_if_reached ();
	[NoReturn]
	[CCode (sentinel = "")]
	public static void return_val_if_reached (...);
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
	
	[CCode (cprefix = "G_LOG_", has_type_id = false)]
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
		public static uint set_handler (string? log_domain, LogLevelFlags log_levels, LogFunc log_func);
		public static void set_default_handler (LogFunc log_func);

		public const string FILE;
		public const int LINE;
		public const string METHOD;
	}

	/* String Utility Functions */

	public uint strv_length ([CCode (array_length = false, array_null_terminated = true)] string[] str_array);

	[CCode (cname = "errno", cheader_filename = "errno.h")]
	public int errno;
	public weak string strerror (int errnum);

	/* Character Set Conversions */
	
	public static string convert (string str, long len, string to_codeset, string from_codeset, out int bytes_read = null, out int bytes_written = null) throws ConvertError;
	public static bool get_charset (out weak string charset);

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
		[CCode (array_length = false)]
		public static uchar[] decode (string text, out size_t out_len);
	}

	/* Data Checksums */

	[CCode (cprefix = "G_CHECKSUM_", has_type_id = false)]
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
		public void update ([CCode (array_length = false)] uchar[] data, size_t length);
		public weak string get_string ();
		public void get_digest ([CCode (array_length = false)] uint8[] buffer, ref size_t digest_len);
		[CCode (cname = "g_compute_checksum_for_data")]
		public static string compute_for_data (ChecksumType checksum_type, uchar[] data);
		[CCode (cname = "g_compute_checksum_for_string")]
		public static string compute_for_string (ChecksumType checksum_type, string str, size_t length = -1);
	}

	/* Date and Time Functions */

	[CCode (has_type_id = false)]
	public struct TimeVal {
		public long tv_sec;
		public long tv_usec;

		[CCode (cname = "g_get_current_time")]
		public TimeVal ();
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

	[CCode (cprefix = "G_DATE_", has_type_id = false)]
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

	[CCode (cprefix = "G_DATE_", has_type_id = false)]
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

	[CCode (cprefix = "G_DATE_", has_type_id = false)]
	public enum DateDMY {
		DAY,
		MONTH,
		YEAR
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

	[CCode (cname = "struct tm", cheader_filename = "time.h", has_type_id = false)]
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

		public string to_string () {
			return "%04d-%02d-%02d %02d:%02d:%02d".printf (year + 1900, month + 1, day, hour, minute, second);
		}

		public string format (string format) {
			var buffer = new char[64];
			this.strftime (buffer, format);
			return (string) buffer;
		}

		[CCode (cname = "mktime")]
		public time_t mktime ();

		[CCode (cname = "strftime", instance_pos = -1)]
		public size_t strftime (char[] s, string format);
		[CCode (cname = "strptime", instance_pos = -1)]
		public weak string? strptime (string buf, string format);
	}

	/* Random Numbers */

	[Compact]
	[CCode (copy_function = "g_rand_copy", free_function = "g_rand_free")]
	public class Rand {
		public Rand.with_seed (uint32 seed);
		public Rand.with_seed_array ([CCode (array_length = false)] uint32[] seed, uint seed_length);
		public Rand ();
		public void set_seed (uint32 seed);
		public void set_seed_array ([CCode (array_length = false)] uint32[] seed, uint seed_length);
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
		[CCode (cname = "g_unsetenv")]
		public static void unset_variable (string variable);
		[CCode (cname = "g_listenv", array_length = false, array_null_terminated = true)]
		public static string[] list_variables ();
		[CCode (cname = "g_get_user_name")]
		public static weak string get_user_name ();
		[CCode (cname = "g_get_real_name")]
		public static weak string get_real_name ();
		[CCode (cname = "g_get_user_cache_dir")]
		public static weak string get_user_cache_dir ();
		[CCode (cname = "g_get_user_data_dir")]
		public static weak string get_user_data_dir ();
		[CCode (cname = "g_get_user_config_dir")]
		public static weak string get_user_config_dir ();
		[CCode (cname = "g_get_user_special_dir")]
		public static weak string get_user_special_dir (UserDirectory directory);
		[CCode (cname = "g_get_system_data_dirs", array_length = false, array_null_terminated = true)]
		[NoArrayLength]
		public static weak string[] get_system_data_dirs ();
		[CCode (cname = "g_get_system_config_dirs", array_length = false, array_null_terminated = true)]
		[NoArrayLength]
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
		public static string? find_program_in_path (string program);
		[CCode (cname = "g_atexit")]
		public static void atexit (VoidFunc func);
		[CCode (cname = "g_chdir")]
		public static int set_current_dir (string path);
	}

	[CCode (has_type_id = false)]
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
		[CCode (cname = "G_SEARCHPATH_SEPARATOR")]
		public const char SEARCHPATH_SEPARATOR;
		[CCode (cname = "G_SEARCHPATH_SEPARATOR_S")]
		public const string SEARCHPATH_SEPARATOR_S;
	}

	namespace Bit {
		public static int nth_lsf (ulong mask, int nth_bit);
		public static int nth_msf (ulong mask, int nth_bit);
		public static uint storage (ulong number);
	}

	namespace SpacedPrimes {
		public static uint closest (uint num);
	}

	[CCode (has_target = false)]
	public delegate void FreeFunc (void* data);
	[CCode (has_target = false)]
	public delegate void VoidFunc ();

	public string format_size_for_display (int64 size);

	/* Lexical Scanner */

	[Compact]
	[CCode (free_function = "g_scanner_destroy")]
	public class Scanner {
		public weak string input_name;
		public TokenType token;
		public TokenValue value;
		public uint line;
		public uint position;
		public TokenType next_token;
		public TokenValue next_value;
		public uint next_line;
		public uint next_position;
		public Scanner (ScannerConfig? config_templ);
		public void input_file (int input_fd);
		public void sync_file_offset ();
		public void input_text (string text, uint text_len);
		public TokenType peek_next_token ();
		public TokenType get_next_token ();
		public bool eof ();
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
		public void unexp_token (TokenType expected_token, string? identifier_spec, string? symbol_spec, string? symbol_name, string? message, bool is_error);
	}

	public struct ScannerConfig {
		public string* cset_skip_characters;
		public string* cset_identifier_first;
		public string* cset_identifier_nth;
		public string* cpair_comment_single;
		public bool case_sensitive;
		public bool skip_comment_multi;
		public bool skip_comment_single;
		public bool scan_comment_multi;
		public bool scan_identifier;
		public bool scan_identifier_1char;
		public bool scan_identifier_NULL;
		public bool scan_symbols;
		public bool scan_binary;
		public bool scan_octal;
		public bool scan_float;
		public bool scan_hex;
		public bool scan_hex_dollar;
		public bool scan_string_sq;
		public bool scan_string_dq;
		public bool numbers_2_int;
		public bool int_2_float;
		public bool identifier_2_string;
		public bool char_2_token;
		public bool symbol_2_token;
		public bool scope_0_fallback;
		public bool store_int64;
	}

	[CCode (lower_case_cprefix="G_CSET_")]
	namespace CharacterSet {
		public const string A_2_Z;
		public const string a_2_z;
		public const string DIGITS;
		public const string LATINC;
		public const string LATINS;
	}

	[CCode (cprefix = "G_TOKEN_", has_type_id = false)]
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
		[CCode (cname="v_symbol")]
		public void* symbol;
		[CCode (cname="v_identifier")]
		public string identifier;
		[CCode (cname="v_binary")]
		public ulong binary;
		[CCode (cname="v_octal")]
		public ulong octal;
		[CCode (cname="v_int")]
		public ulong int;
		[CCode (cname="v_int64")]
		public ulong int64;
		[CCode (cname="v_float")]
		public double float;
		[CCode (cname="v_hex")]
		public ulong hex;
		[CCode (cname="v_string")]
		public string string;
		[CCode (cname="v_comment")]
		public string comment;
		[CCode (cname="v_char")]
		public uchar char;
		[CCode (cname="v_error")]
		public uint error;
	}

	[CCode (cprefix = "G_ERR_", has_type_id = false)]
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

	/* Automatic String Completion */

	[Compact]
	[CCode (free_function = "g_completion_free")]
	public class Completion {
		public Completion (CompletionFunc? func = null);
		public List<void*> items;
		public CompletionFunc func;
		public string prefix;
		public List<void*> cache;
		public CompletionStrncmpFunc strncmp_func;
		public void add_items (List<void*> items);
		public void remove_items (List<void*> items);
		public void clear_items ();
		public weak List<void*> complete (string prefix, out string? new_prefix = null);
		public weak List<void*> complete_utf8 (string prefix, out string? new_prefix = null);
	}

	[CCode (has_target = false)]
	public delegate string CompletionFunc (void* item);
	[CCode (has_target = false)]
	public delegate int CompletionStrncmpFunc (string s1, string s2, size_t n);

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

	[CCode (cprefix = "G_SPAWN_", has_type_id = false)]
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
		public static bool spawn_async_with_pipes (string? working_directory, [CCode (array_length = false, array_null_terminated = true)] string[] argv, [CCode (array_length = false, array_null_terminated = true)] string[]? envp, SpawnFlags _flags, SpawnChildSetupFunc? child_setup, out Pid child_pid, out int standard_input = null, out int standard_output = null, out int standard_error = null) throws SpawnError;
		public static bool spawn_async (string? working_directory, [CCode (array_length = false, array_null_terminated = true)] string[] argv, [CCode (array_length = false, array_null_terminated = true)] string[]? envp, SpawnFlags _flags, SpawnChildSetupFunc? child_setup, out Pid child_pid) throws SpawnError;
		public static bool spawn_sync (string? working_directory, [CCode (array_length = false, array_null_terminated = true)] string[] argv, [CCode (array_length = false, array_null_terminated = true)] string[]? envp, SpawnFlags _flags, SpawnChildSetupFunc? child_setup, out string standard_output = null, out string standard_error = null, out int exit_status = null) throws SpawnError;
		public static bool spawn_command_line_async (string command_line) throws SpawnError;
		public static bool spawn_command_line_sync (string command_line, out string standard_output = null, out string standard_error = null, out int exit_status = null) throws SpawnError;
		[CCode (cname = "g_spawn_close_pid")]
		public static void close_pid (Pid pid);
		
		/* these macros are required to examine the exit status of a process */
		[CCode (cname = "WIFEXITED", cheader_filename = "sys/wait.h")]
		public static bool if_exited (int status);
		[CCode (cname = "WEXITSTATUS", cheader_filename = "sys/wait.h")]
		public static int exit_status (int status);
		[CCode (cname = "WIFSIGNALED", cheader_filename = "sys/wait.h")]
		public static bool if_signaled (int status);
		[CCode (cname = "WTERMSIG", cheader_filename = "sys/wait.h")]
		public static ProcessSignal term_sig (int status);
		[CCode (cname = "WCOREDUMP", cheader_filename = "sys/wait.h")]
		public static bool core_dump (int status);
		[CCode (cname = "WIFSTOPPED", cheader_filename = "sys/wait.h")]
		public static bool if_stopped (int status);
		[CCode (cname = "WSTOPSIG", cheader_filename = "sys/wait.h")]
		public static ProcessSignal stop_sig (int status);
		[CCode (cname = "WIFCONTINUED", cheader_filename = "sys/wait.h")]
		public static bool if_continued (int status);
	}
	
	[CCode (cname = "int", has_type_id = false, cheader_filename = "signal.h", cprefix = "SIG")]
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

	[CCode (has_type_id = false)]
	public enum FileTest {
		IS_REGULAR,
		IS_SYMLINK,
		IS_DIR,
		IS_EXECUTABLE,
		EXISTS
	}

	[CCode (cprefix = "SEEK_", has_type_id = false)]
	public enum FileSeek {
		SET,
		CUR,
		END
	}

	[Compact]
	[CCode (cname = "FILE", free_function = "fclose", cheader_filename = "stdio.h")]
	public class FileStream {
		[CCode (cname = "EOF", cheader_filename = "stdio.h")]
		public const int EOF;

		[CCode (cname = "fopen")]
		public static FileStream? open (string path, string mode);
		[CCode (cname = "fdopen")]
		public static FileStream? fdopen (int fildes, string mode);
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
		public weak string gets (char[] s);
		[CCode (cname = "feof")]
		public bool eof ();
		[CCode (cname = "fscanf"), ScanfFormat]
		public int scanf (string format, ...);
		[CCode (cname = "fflush")]
		public int flush ();
		[CCode (cname = "fseek")]
		public int seek (long offset, FileSeek whence);
		[CCode (cname = "ftell")]
		public long tell ();
		[CCode (cname = "rewind")]
		public void rewind ();
		[CCode (cname = "fileno")]
		public int fileno ();
		[CCode (cname = "ferror")]
		public int error ();
		[CCode (cname = "clearerr")]
		public void clearerr ();

		public string? read_line () {
			int c;
			StringBuilder ret = null;
			while ((c = getc ()) != EOF) {
				if (ret == null) {
					ret = new StringBuilder ();
				}
				if (c == '\n') {
					break;
				}
				ret.append_c ((char) c);
			}
			return ret == null ? null : ret.str;
		}
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
		[CCode (cname = "g_remove")]
		public static int remove (string filename);
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
		[CCode (cname = "g_rmdir")]
		public static int remove (string filename);
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

		public static string parse_scheme (string uri);
		public static string escape_string (string unescaped, string reserved_chars_allowed, bool allow_utf8);
		public static string unescape_string (string escaped_string, string? illegal_characters = null);
		public static string unescape_segment (string escaped_string, string escaped_string_end, string? illegal_characters = null);
		[CCode (array_length = false, array_null_terminated = true)]
		public static string[] list_extract_uris (string uri_list);
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
		public void add_main_entries ([CCode (array_length = false)] OptionEntry[] entries, string? translation_domain);
		public void add_group (owned OptionGroup group);
		public void set_main_group (owned OptionGroup group);
		public weak OptionGroup get_main_group ();
	}

	public delegate weak string TranslateFunc (string str);

	[CCode (has_type_id = false)]
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
	[CCode (cprefix = "G_OPTION_FLAG_", has_type_id = false)]
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
		public void add_entries ([CCode (array_length = false)] OptionEntry[] entries);
		public void set_parse_hooks (OptionParseFunc pre_parse_func, OptionParseFunc post_parse_hook);
		public void set_error_hook (OptionErrorFunc error_func);
		public void set_translate_func (TranslateFunc func, DestroyNotify? destroy_notify);
		public void set_translation_domain (string domain);
	}

	[CCode (has_target = false)]
	public delegate bool OptionParseFunc (OptionContext context, OptionGroup group, void* data) throws OptionError;
	[CCode (has_target = false)]
	public delegate void OptionErrorFunc (OptionContext context, OptionGroup group, void* data, ref Error error);

	/* Perl-compatible regular expressions */

	public errordomain RegexError {
		COMPILE,
		OPTIMIZE,
		REPLACE,
		MATCH
	}

	[CCode (cprefix = "G_REGEX_", has_type_id = false)]
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

	[CCode (cprefix = "G_REGEX_MATCH_", has_type_id = false)]
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
	public class Regex {
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
		[CCode (array_length = false, array_null_terminated = true)]
		public static string[] split_simple (string pattern, string str, RegexCompileFlags compile_options = 0, RegexMatchFlags match_options = 0);
		[CCode (array_length = false, array_null_terminated = true)]
		public string[] split (string str, RegexMatchFlags match_options = 0);
		[CCode (array_length = false, array_null_terminated = true)]
		public string[] split_full (string str, long string_len = -1, int start_position = 0, RegexMatchFlags match_options = 0, int max_tokens = 0) throws RegexError;
		public string replace (string str, long string_len, int start_position, string replacement, RegexMatchFlags match_options = 0) throws RegexError;
		public string replace_literal (string str, long string_len, int start_position, string replacement, RegexMatchFlags match_options = 0) throws RegexError;
		public string replace_eval (string str, long string_len, int start_position, RegexMatchFlags match_options = 0, RegexEvalCallback eval, void* user_data) throws RegexError;
		public static bool check_replacement (out bool has_references = null) throws RegexError;
	}

	[CCode (has_target = false)]
	public delegate bool RegexEvalCallback (MatchInfo match_info, StringBuilder result, void* user_data);

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
		public string? fetch (int match_num);
		public bool fetch_pos (int match_num, out int start_pos, out int end_pos);
		public string? fetch_named (string name);
		public bool fetch_named_pos (string name, out int start_pos, out int end_pos);
		[CCode (array_length = false, array_null_terminated = true)]
		public string[] fetch_all ();
	}

	/* Simple XML Subset Parser */

	public errordomain MarkupError {
		BAD_UTF8,
		EMPTY,
		PARSE,
		UNKNOWN_ELEMENT,
		UNKNOWN_ATTRIBUTE,
		INVALID_CONTENT,
		MISSING_ATTRIBUTE
	}

	[CCode (cprefix = "G_MARKUP_", has_type_id = false)]
	public enum MarkupParseFlags {
		TREAT_CDATA_AS_TEXT
	}

	[Compact]
	[CCode (free_function = "g_markup_parse_context_free")]
	public class MarkupParseContext {
		public MarkupParseContext (MarkupParser parser, MarkupParseFlags _flags, void* user_data, DestroyNotify? user_data_dnotify);
		public bool parse (string text, long text_len) throws MarkupError;
		public bool end_parse () throws MarkupError;
		public weak string get_element ();
		public weak SList<string> get_element_stack ();
		public void get_position (out int line_number, out int char_number);
		public void push (MarkupParser parser, void* user_data);
		public void* pop (MarkupParser parser);
	}
	
	public delegate void MarkupParserStartElementFunc (MarkupParseContext context, string element_name, [CCode (array_length = false, array_null_terminated = true)] string[] attribute_names, [CCode (array_length = false, array_null_terminated = true)] string[] attribute_values) throws MarkupError;
	
	public delegate void MarkupParserEndElementFunc (MarkupParseContext context, string element_name) throws MarkupError;
	
	public delegate void MarkupParserTextFunc (MarkupParseContext context, string text, ulong text_len) throws MarkupError;
	
	public delegate void MarkupParserPassthroughFunc (MarkupParseContext context, string passthrough_text, ulong text_len) throws MarkupError;
	
	public delegate void MarkupParserErrorFunc (MarkupParseContext context, Error error);
	
	public struct MarkupParser {
		public MarkupParserStartElementFunc start_element;
		public MarkupParserEndElementFunc end_element;
		public MarkupParserTextFunc text;
		public MarkupParserPassthroughFunc passthrough;
		public MarkupParserErrorFunc error;
	}

	namespace Markup {
		[CCode (cprefix = "G_MARKUP_COLLECT_", has_type_id = false)]
		public enum CollectType {
			INVALID,
			STRING,
			STRDUP,
			BOOLEAN,
			TRISTATE,
			OPTIONAL
		}

		public static string escape_text (string text, long length = -1);
		[PrintfFormat]
		public static string printf_escaped (string format, ...);
		[CCode (sentinel = "G_MARKUP_COLLECT_INVALID")]
		public static bool collect_attributes (string element_name, string[] attribute_names, string[] attribute_values, ...) throws MarkupError;
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
		public bool load_from_file (string file, KeyFileFlags @flags) throws KeyFileError, FileError;
		public bool load_from_dirs (string file, [CCode (array_length = false, array_null_terminated = true)] string[] search_dirs, out string full_path, KeyFileFlags @flags) throws KeyFileError, FileError;
		public bool load_from_data (string data, ulong length, KeyFileFlags @flags) throws KeyFileError;
		public bool load_from_data_dirs (string file, out string full_path, KeyFileFlags @flags) throws KeyFileError, FileError;
		// g_key_file_to_data never throws an error according to the documentation
		public string to_data (out size_t length = null, out GLib.Error error = null);
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
	
	[CCode (cprefix = "G_KEY_FILE_", has_type_id = false)]
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
		public static void add_data_func (string testpath, [CCode (delegate_target_pos = 1.9)] DataTestFunc test_funcvoid);
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

	[Compact]
	[CCode (cname = "GTestCase", ref_function = "", unref_function = "")]
	public class TestCase {
		[CCode (cname = "g_test_create_case")]
		public TestCase (string test_name, size_t data_size, [CCode (delegate_target_pos = 2.9)] TestFunc data_setupvoid, [CCode (delegate_target_pos = 2.9)] TestFunc data_funcvoid, [CCode (delegate_target_pos = 2.9)] TestFunc data_teardownvoid);
	}

	[Compact]
	[CCode (cname = "GTestSuite", ref_function = "", unref_function = "")]
	public class TestSuite {
		[CCode (cname = "g_test_create_suite")]
		public TestSuite (string name);
		[CCode (cname = "g_test_get_root")]
		public static TestSuite get_root ();
		[CCode (cname = "g_test_suite_add")]
		public void add (TestCase test_case);
		[CCode (cname = "g_test_suite_add_suite")]
		public void add_suite (TestSuite test_suite);
	}

	public delegate void TestFunc (void* fixture);
	public delegate void DataTestFunc ();

	[Flags]
	[CCode (cprefix = "G_TEST_TRAP_", has_type_id = false)]
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
		public void append (owned G data);
		[ReturnsModifiedPointer ()]
		public void prepend (owned G data);
		[ReturnsModifiedPointer ()]
		public void insert (owned G data, int position);
		[ReturnsModifiedPointer ()]
		public void insert_before (List<G> sibling, owned G data);
		[ReturnsModifiedPointer ()]
		public void insert_sorted (owned G data, CompareFunc compare_func);
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
		public void insert_sorted_with_data (owned G data, CompareDataFunc compare_func);
		[ReturnsModifiedPointer ()]
		public void sort_with_data (CompareDataFunc compare_func);
		[ReturnsModifiedPointer ()]
		public void concat (owned List<G> list2);
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
		public void append (owned G data);
		[ReturnsModifiedPointer ()]
		public void prepend (owned G data);
		[ReturnsModifiedPointer ()]
		public void insert (owned G data, int position);
		[ReturnsModifiedPointer ()]
		public void insert_before (SList<G> sibling, owned G data);
		[ReturnsModifiedPointer ()]
		public void insert_sorted (owned G data, CompareFunc compare_func);
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
		public void insert_sorted_with_data (owned G data, CompareDataFunc compare_func);
		[ReturnsModifiedPointer ()]
		public void sort (CompareFunc compare_func);
		[ReturnsModifiedPointer ()]
		public void sort_with_data (CompareDataFunc compare_func);
		[ReturnsModifiedPointer ()]
		public void concat (owned SList<G> list2);
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

	[CCode (has_target = false)]
	public delegate int CompareFunc (void* a, void* b);

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
		public void sort (CompareDataFunc compare_func);
		public void push_head (owned G data);
		public void push_tail (owned G data);
		public void push_nth (owned G data, int n);
		public G pop_head ();
		public G pop_tail ();
		public G pop_nth (uint n);
		public weak G peek_head ();
		public weak G peek_tail ();
		public weak G peek_nth (uint n);
		public int index (G data);
		public void remove (G data);
		public void remove_all (G data);
		public void insert_before (List<G> sibling, owned G data);
		public void insert_after (List<G> sibling, owned G data);
		public void insert_sorted (owned G data, CompareDataFunc func);
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
		public SequenceIter<G> get_begin_iter ();
		public SequenceIter<G> get_end_iter ();
		public SequenceIter<G> get_iter_at_pos (int pos);
		public SequenceIter<G> append (owned G data);
		public SequenceIter<G> prepend (owned G data);
		public static SequenceIter<G> insert_before (SequenceIter<G> iter, owned G data);
		public static void move (SequenceIter<G> src, SequenceIter<G> dest);
		public static void swap (SequenceIter<G> src, SequenceIter<G> dest);
		public SequenceIter<G> insert_sorted (owned G data, CompareDataFunc cmp_func);
		public SequenceIter<G> insert_sorted_iter (owned G data, SequenceIterCompareFunc<G> iter_cmp);
		public static void sort_changed (SequenceIter<G> iter, CompareDataFunc cmp_func);
		public static void sort_changed_iter (SequenceIter<G> iter, SequenceIterCompareFunc<G> iter_cmp);
		public static void remove (SequenceIter<G> iter);
		public static void remove_range (SequenceIter<G> begin, SequenceIter<G> end);
		public static void move_range (SequenceIter<G> dest, SequenceIter<G> begin, SequenceIter<G> end);
		public SequenceIter<G> search (G data, CompareDataFunc cmp_func);
		public SequenceIter<G> search_iter (G data, SequenceIterCompareFunc<G> iter_cmp);
		public static weak G get (SequenceIter<G> iter);
		public static void set (SequenceIter<G> iter, owned G data);
		public static SequenceIter<G> range_get_midpoint (SequenceIter<G> begin, SequenceIter<G> end);
	}

	[Compact]
	[CCode (ref_function = "", unref_function = "")]
	public class SequenceIter<G> {
		public bool is_begin ();
		public bool is_end ();
		public SequenceIter<G> next ();
		public SequenceIter<G> prev ();
		public int get_position ();
		public SequenceIter<G> move (int delta);
		public Sequence<G> get_sequence ();
		public int compare (SequenceIter<G> other);

		[CCode (cname = "g_sequence_get")]
		public weak G get ();
	}

	public delegate int SequenceIterCompareFunc<G> (SequenceIter<G> a, SequenceIter<G> b);

	/* Hash Tables */

	[Compact]
	[CCode (ref_function = "g_hash_table_ref", unref_function = "g_hash_table_unref", type_id = "G_TYPE_HASH_TABLE", type_signature = "a{%s}")]
	public class HashTable<K,V> {
		public HashTable (HashFunc? hash_func, EqualFunc? key_equal_func);
		public HashTable.full (HashFunc? hash_func, EqualFunc? key_equal_func, DestroyNotify? key_destroy_func, DestroyNotify? value_destroy_func);
		public void insert (owned K key, owned V value);
		public void replace (owned K key, owned V value);
		public weak V lookup (K key);
		public bool remove (K key);
		public void remove_all ();
		public List<weak K> get_keys ();
		public List<weak V> get_values ();
		[CCode (cname = "g_hash_table_foreach")]
		public void for_each (HFunc func);
		public uint size ();
		public bool steal (K key);
		public void steal_all ();
	}

	public struct HashTableIter<K,V> {
		public HashTableIter (GLib.HashTable<K,V> table);
		public bool next (out unowned K key, out unowned V value);
		public void remove ();
		public void steal ();
		public unowned GLib.HashTable<K,V> get_hash_table ();
	}

	[CCode (has_target = false)]
	public static delegate uint HashFunc (void* key);
	[CCode (has_target = false)]
	public static delegate bool EqualFunc (void* a, void* b);
	public delegate void HFunc (void* key, void* value);

	[CCode (has_target = false)]
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
	public class StringBuilder {
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
		public weak StringBuilder truncate (size_t len);

		[PrintfFormat]
		public void printf (string format, ...);
		[PrintfFormat]
		public void append_printf (string format, ...);

		public string str;
		public long len;
		public long allocated_len;
	}

	/* String Chunks */

	[Compact]
	[CCode (free_function = "g_string_chunk_free")]
	public class StringChunk {
		public StringChunk (size_t size);
		public weak string insert (string str);
		public weak string insert_const (string str);
		public weak string insert_len (string str, ssize_t len);
		public void clear ();
	}

	/* Pointer Arrays */

	[Compact]
	[CCode (free_function = "g_ptr_array_free")]
	public class PtrArray {
		public PtrArray ();
		[CCode (cname = "g_ptr_array_sized_new")]
		public PtrArray.sized (uint reserved_size);
		public void add (void* data);
		public bool remove (void* data);
		public void* remove_index (uint index);
		public bool remove_fast (void *data);
		public void remove_range (uint index, uint length);
		public void sort (CompareFunc compare_func);
		public void sort_with_data (CompareDataFunc compare_func);
		public void set_size (uint length);

		public uint len;
		public void** pdata;
	}

	/* Byte Arrays */

	[Compact]
	[CCode (cprefix = "g_byte_array_", free_function = "g_byte_array_free")]
	public class ByteArray {
		public ByteArray ();
		[CCode (cname = "g_byte_array_sized_new")]
		public ByteArray.sized (uint reserved_size);
		public void append (uint8[] data);
		public void prepend (uint8[] data);
		public void remove_index (uint index);
		public void remove_index_fast (uint index);
		public void remove_range (uint index, uint length);
		public void sort (CompareFunc compare_func);
		public void sort_with_data (CompareDataFunc compare_func);
		public void set_size (uint length);

		public uint len;
		[CCode (array_length_cname = "len", array_length_type = "guint")]
		public uint8[] data;
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

	[CCode (type_id = "G_TYPE_UINT")]
	public struct Quark : uint32 {
		public static Quark from_string (string str);
		public static Quark try_string (string str);
		public weak string to_string ();
	}

	/* Keyed Data Lists */

	[CCode (cname = "GData*")]
	public struct Datalist<G> {
		public Datalist ();
		public void clear ();
		public weak G id_get_data (Quark key_id);
		public void id_set_data (Quark key_id, owned G data);
		public void id_set_data_full (Quark key_id, owned G data, DestroyNotify? destroy_func);
		public void id_remove_data (Quark key_id);
		public G id_remove_no_notify (Quark key_id);
		public void @foreach (DataForeachFunc func);
		public weak G get_data (string key);
		public void set_data_full (string key, owned G data, DestroyNotify? destry_func);
		public G remove_no_notify (string key);
		public void set_data (string key, owned G data);
		public void remove_data (string key);
	}

	public delegate void DataForeachFunc<G> (Quark key_id, G data);

	/* GArray */

	[Compact]
	public class Array<G> {
		[CCode (cname = "len")]
		public uint length;

		public Array (bool zero_terminated, bool clear, uint element_size);
		[CCode (cname = "g_array_sized_new")]
		public Array.sized (bool zero_terminated, bool clear, uint element_size, uint reserved_size);
		public void append_val (G value);
		public void append_vals (void* data, uint len);
		public void prepend_val (G value);
		public void prepend_vals (void* data, uint len);
		public void insert_val (uint index, G value);
		public void insert_vals (uint index, void* data, uint len);
		public void remove_index (uint index);
		public void remove_index_fast (uint index);
		public void remove_range (uint index, uint length);
		public void sort (CompareFunc compare_func);
		public void sort_with_data (CompareDataFunc compare_func);
		public G index (uint index);
		public void set_size (uint length);
	}
	
	/* GTree */
	
	public delegate int TraverseFunc (void* key, void* value);
	
	[CCode (c_prefix="C_", has_type_id = false)]
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
		public Tree.with_data (CompareDataFunc key_compare_func);
		public Tree.full (CompareDataFunc key_compare_func, DestroyNotify? key_destroy_func, DestroyNotify? value_destroy_func);
		public void insert (owned K key, owned V value);
		public void replace (owned K key, owned V value);
		public int nnodes ();
		public int height ();
		public weak V lookup (K key);
		public bool lookup_extended (K lookup_key, K orig_key, V value);
		public void foreach (TraverseFunc traverse_func);
		public weak V search (CompareFunc search_func, void* user_data);
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
	[CCode (cname = "ngettext", cheader_filename = "glib.h,glib/gi18n-lib.h")]
	public static weak string ngettext (string msgid, string msgid_plural, ulong n);
	
	[CCode (cname = "int", cprefix = "LC_", cheader_filename = "locale.h", has_type_id = false)]
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

	namespace Win32 {
		public string error_message (int error);
		public string getlocale ();
		public string get_package_installation_directory_of_module (void* hmodule);
		public uint get_windows_version ();
		public string locale_filename_from_utf8 (string utf8filename);
		[CCode (cname = "G_WIN32_HAVE_WIDECHAR_API")]
		public bool have_widechar_api ();
		[CCode (cname = "G_WIN32_IS_NT_BASED")]
		public bool is_nt_based ();
	}
}
