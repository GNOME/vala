/* gdk-2.0-custom.vala
 *
 * Copyright (C) 2008  Jürg Billeter
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

namespace Gdk {
	public const Atom SELECTION_PRIMARY;
	public const Atom SELECTION_SECONDARY;
	public const Atom SELECTION_CLIPBOARD;

	[CCode (cheader_filename = "gdk/gdk.h")]
	[SimpleType]
	public struct Atom {
		[CCode (cname="GDK_NONE")]
		public static Atom NONE;
	}

	[CCode (ref_function = "g_object_ref", unref_function = "g_object_unref")]
	public class Bitmap {
	}

	public class Drawable {
		[CCode (cname = "gdk_draw_arc")]
		public virtual void draw_arc (Gdk.GC gc, bool filled, int x, int y, int width, int height, int angle1, int angle2);
		[CCode (cname = "gdk_draw_drawable")]
		public virtual void draw_drawable (Gdk.GC gc, Gdk.Drawable src, int xsrc, int ysrc, int xdest, int ydest, int width, int height);
		[CCode (cname = "gdk_draw_glyphs")]
		public virtual void draw_glyphs (Gdk.GC gc, Pango.Font font, int x, int y, Pango.GlyphString glyphs);
		[CCode (cname = "gdk_draw_glyphs_transformed")]
		public virtual void draw_glyphs_transformed (Gdk.GC gc, Pango.Matrix matrix, Pango.Font font, int x, int y, Pango.GlyphString glyphs);
		[CCode (cname = "gdk_draw_image")]
		public virtual void draw_image (Gdk.GC gc, Gdk.Image image, int xsrc, int ysrc, int xdest, int ydest, int width, int height);
		[CCode (cname = "gdk_draw_lines")]
		public virtual void draw_lines (Gdk.GC gc, Gdk.Point[] points);
		[CCode (cname = "gdk_draw_pixbuf")]
		public virtual void draw_pixbuf (Gdk.GC? gc, Gdk.Pixbuf pixbuf, int src_x, int src_y, int dest_x, int dest_y, int width, int height, Gdk.RgbDither dither, int x_dither, int y_dither);
		[CCode (cname = "gdk_draw_points")]
		public virtual void draw_points (Gdk.GC gc, Gdk.Point[] points);
		[CCode (cname = "gdk_draw_polygon")]
		public virtual void draw_polygon (Gdk.GC gc, bool filled, Gdk.Point[] points);
		[CCode (cname = "gdk_draw_rectangle")]
		public virtual void draw_rectangle (Gdk.GC gc, bool filled, int x, int y, int width, int height);
		[CCode (cname = "gdk_draw_segments")]
		public virtual void draw_segments (Gdk.GC gc, Gdk.Segment[] segs);
		[CCode (cname = "gdk_draw_text")]
		public virtual void draw_text (Gdk.Font font, Gdk.GC gc, int x, int y, string text, int text_length);
		[CCode (cname = "gdk_draw_text_wc")]
		public virtual void draw_text_wc (Gdk.Font font, Gdk.GC gc, int x, int y, Gdk.WChar text, int text_length);
		[CCode (cname = "gdk_draw_trapezoids")]
		public virtual void draw_trapezoids (Gdk.GC gc, Gdk.Trapezoid[] trapezoids);
	}

	[CCode (cheader_filename = "gdk/gdk.h")]
	namespace Selection {
		public static void convert (Gdk.Window requestor, Gdk.Atom selection, Gdk.Atom target, uint32 time_);
		public static unowned Gdk.Window owner_get (Gdk.Atom selection);
		public static unowned Gdk.Window owner_get_for_display (Gdk.Display display, Gdk.Atom selection);
		public static bool owner_set (Gdk.Window owner, Gdk.Atom selection, uint32 time_, bool send_event);
		public static bool owner_set_for_display (Gdk.Display display, Gdk.Window owner, Gdk.Atom selection, uint32 time_, bool send_event);
		public static int property_get (Gdk.Window requestor, uchar[] data, out Gdk.Atom prop_type, int prop_format);
		public static void send_notify (Gdk.NativeWindow requestor, Gdk.Atom selection, Gdk.Atom target, Gdk.Atom property, uint32 time_);
		public static void send_notify_for_display (Gdk.Display display, Gdk.NativeWindow requestor, Gdk.Atom selection, Gdk.Atom target, Gdk.Atom property, uint32 time_);
	}

	[Deprecated (since = "vala-0.12", replacement = "Selection.convert")]
	public static void selection_convert (Gdk.Window requestor, Gdk.Atom selection, Gdk.Atom target, uint32 time_);
	[Deprecated (since = "vala-0.12", replacement = "Selection.owner_get")]
	public static unowned Gdk.Window selection_owner_get (Gdk.Atom selection);
	[Deprecated (since = "vala-0.12", replacement = "Selection.owner_get_for_display")]
	public static unowned Gdk.Window selection_owner_get_for_display (Gdk.Display display, Gdk.Atom selection);
	[Deprecated (since = "vala-0.12", replacement = "Selection.owner_set")]
	public static bool selection_owner_set (Gdk.Window owner, Gdk.Atom selection, uint32 time_, bool send_event);
	[Deprecated (since = "vala-0.12", replacement = "Selection.owner_set_for_display")]
	public static bool selection_owner_set_for_display (Gdk.Display display, Gdk.Window owner, Gdk.Atom selection, uint32 time_, bool send_event);
	[Deprecated (since = "vala-0.12", replacement = "Selection.property_get")]
	public static int selection_property_get (Gdk.Window requestor, uchar[] data, out Gdk.Atom prop_type, int prop_format);
	[Deprecated (since = "vala-0.12", replacement = "Selection.send_notify")]
	public static void selection_send_notify (Gdk.NativeWindow requestor, Gdk.Atom selection, Gdk.Atom target, Gdk.Atom property, uint32 time_);
	[Deprecated (since = "vala-0.12", replacement = "Selection.send_notify_for_display")]
	public static void selection_send_notify_for_display (Gdk.Display display, Gdk.NativeWindow requestor, Gdk.Atom selection, Gdk.Atom target, Gdk.Atom property, uint32 time_);
}
