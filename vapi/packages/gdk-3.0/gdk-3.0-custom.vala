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

	public struct Rectangle {
		public int x;
		public int y;
		public int width;
		public int height;
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
	public static void selection_send_notify (Gdk.Window requestor, Gdk.Atom selection, Gdk.Atom target, Gdk.Atom property, uint32 time_);
	[Deprecated (since = "vala-0.12", replacement = "Selection.send_notify_for_display")]
	public static void selection_send_notify_for_display (Gdk.Display display, Gdk.Window requestor, Gdk.Atom selection, Gdk.Atom target, Gdk.Atom property, uint32 time_);
}
