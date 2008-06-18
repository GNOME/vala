/* gstreamer-0.10-custom.vala
 *
 * Copyright (C) 2007-2008  Jürg Billeter
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
 */
namespace Gst {
	public extern void init ([CCode (array_length_pos = 0.9)] ref weak string[] args);

	public struct ClockTime : uint64 {
	}

	public struct ClockTimeDiff : int64 {
	}

	[CCode (ref_function = "gst_object_ref", unref_function = "gst_object_unref")]
	public class Object {
		public weak Object @ref ();
		public void unref ();
		public void sink ();
	}
	[CCode (ref_function = "gst_buffer_ref", unref_function = "gst_buffer_unref")]
	public class Buffer : Gst.MiniObject {
		public Buffer ();
		public weak Buffer @ref ();
		public void unref ();
	}

	[CCode (cname = "GValue")]
	public struct Value : GLib.Value {

		public static GLib.Type array_get_type ();
		public static GLib.Type list_get_type ();

		[CCode (cname = "GST_MAKE_FOURCC")]
		public static uint make_fourcc (char a, char b, char c, char d);
		[CCode (cname = "GST_STR_FOURCC")]
		public static uint str_fourcc (string str);

		public void set_fourcc (uint fourcc);
		public uint get_fourcc ();

		public void set_int_range (int start, int end);
		public int get_int_range_min ();
		public int get_int_range_max ();

		public void set_double_range (double start, double end);
		public double get_double_range_min ();
		public double get_double_range_max ();

		public void  list_append_value (Gst.Value append_value);
		public void  list_prepend_value (Gst.Value prepend_value);
		public void list_concat (Gst.Value value1, Gst.Value value2);
		public uint list_get_size ();
		public weak Gst.Value? list_get_value (uint index);

		public void set_fraction (int numerator, int denominator);
		public int get_fraction_numerator ();
		public int get_fraction_denominator ();
		public static bool fraction_multiply (GLib.Value product, GLib.Value factor1, GLib.Value factor2);
		public static bool fraction_subtract (GLib.Value dest, GLib.Value minuend, GLib.Value subtrahend);

		public void set_fraction_range (Gst.Value start, Gst.Value end);
		public weak Gst.Value? get_fraction_range_min ();
		public weak Gst.Value? get_fraction_range_max ();
		public void set_fraction_range_full (int numerator_start, int denominator_start, int numerator_end, int denominator_end);

		public void set_date (Date date);
		public Date get_date ();

		public void set_caps (Caps caps);
		public Caps get_caps ();

		public void set_structure (Structure structure);
		public weak Structure get_structure ();

		public weak Buffer get_buffer ();
		public void set_buffer (Buffer b);
		public void take_buffer (Buffer b);

		public bool is_fixed ();

		public static void register (Gst.ValueTable table);

		public void init_and_copy (Gst.Value src);

		public string serialize ();
		public bool deserialize (string src);

		public static bool can_compare (Gst.Value value1, Gst.Value value2);
		public static int compare (Gst.Value value1, Gst.Value value2);

		public static void register_union_func (GLib.Type type1, GLib.Type type2, Gst.ValueUnionFunc func);
		public static bool union (Gst.Value dest, Gst.Value value1, Gst.Value value2);
		public static bool can_union (Gst.Value value1, Gst.Value value2);

		public static void register_subtract_func (GLib.Type minuend_type, GLib.Type subtrahend_type, Gst.ValueSubtractFunc func);
		public static bool subtract (Gst.Value dest, Gst.Value minuend, Gst.Value subtrahend);
		public static bool can_subtract (Gst.Value minuend, Gst.Value subtrahend);

		public static void register_intersect_func (GLib.Type type1, GLib.Type type2, Gst.ValueIntersectFunc func);
		public static bool intersect (Gst.Value dest, Gst.Value value1, Gst.Value value2);
		public static bool can_intersect (Gst.Value value1, Gst.Value value2);

		public void array_append_value (Gst.Value append_value);
		public uint array_get_size ();
		public weak Gst.Value? array_get_value (uint index);
		public void array_prepend_value (Gst.Value prepend_value);
	} 
}
