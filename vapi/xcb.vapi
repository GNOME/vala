/* xcb.vapi
 *
 * Copyright (C) 2009  Jürg Billeter
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
 * Author:
 * 	Jürg Billeter <j@bitron.ch>
 */

[CCode (lower_case_cprefix = "xcb_", cheader_filename = "xcb/xcb.h")]
namespace Xcb {
	[Compact]
	[CCode (cname = "xcb_connection_t", cprefix = "xcb_", ref_function = "", unref_function = "xcb_disconnect")]
	public class Connection {
		[CCode (cname = "xcb_connect")]
		public Connection (string? display = null, out int screen = null);

		public void flush ();
		public uint32 generate_id ();
		public Setup get_setup ();
		public GenericEvent wait_for_event ();
		public int get_file_descriptor ();
		public VoidCookie create_window (uint8 depth, Window wid, Window parent, int16 x, int16 y, uint16 width, uint16 height, uint16 border_width, uint16 _class, VisualID visual, uint32 value_mask, [CCode (array_length = false)] uint32[]? value_list);
		public VoidCookie map_window (Window wid);
		public VoidCookie change_window_attributes (Window wid, uint32 value_mask, [CCode (array_length = false)] uint32[]? value_list);
		public QueryTreeCookie query_tree (Window wid);
		public QueryTreeReply query_tree_reply (QueryTreeCookie cookie, out GenericError? e);
	}

	[Compact]
	[CCode (cname = "xcb_setup_t", ref_function = "", unref_function = "")]
	public class Setup {
		public int roots_length ();
		public ScreenIterator roots_iterator ();
	}

	public const char COPY_FROM_PARENT;

	[CCode (cname = "xcb_window_class_t")]
	public enum WindowClass {
		COPY_FROM_PARENT,
		INPUT_OUTPUT,
		INPUT_ONLY
	}

	[Compact]
	[CCode (cname = "xcb_generic_event_t", ref_function = "", unref_function = "")]
	public class GenericEvent {
		public uint8 response_type;
	}

	[Compact]
	[CCode (cname = "xcb_generic_error_t", ref_function = "", unref_function = "")]
	public class GenericError {
		public uint8 response_type;
		public uint8 error_code;
		public uint16 sequence;
		public uint32 resource_id;
		public uint16 minor_code;
		public uint8 major_code;
	}

	public const uint8 BUTTON_PRESS;
	public const uint8 BUTTON_RELEASE;
	public const uint8 EXPOSE;
	public const uint8 MOTION_NOTIFY;
	public const uint8 ENTER_NOTIFY;
	public const uint8 LEAVE_NOTIFY;

	[CCode (cname = "xcb_button_press_event_t", ref_function = "", unref_function = "")]
	public class ButtonPressEvent : GenericEvent {
		public Button detail;
		public Window root;
		public Window event;
		public Window child;
		public uint16 root_x;
		public uint16 root_y;
		public uint16 event_x;
		public uint16 event_y;
	}

	[CCode (cname = "xcb_button_release_event_t", ref_function = "", unref_function = "")]
	public class ButtonReleaseEvent : GenericEvent {
		public Button detail;
		public Window root;
		public Window event;
		public Window child;
		public uint16 root_x;
		public uint16 root_y;
		public uint16 event_x;
		public uint16 event_y;
	}

	[CCode (cname = "xcb_motion_notify_event_t", ref_function = "", unref_function = "")]
	public class MotionNotifyEvent : GenericEvent {
		public Window root;
		public Window event;
		public Window child;
		public uint16 root_x;
		public uint16 root_y;
		public uint16 event_x;
		public uint16 event_y;
	}

	[CCode (cname = "xcb_expose_event_t", ref_function = "", unref_function = "")]
	public class ExposeEvent : GenericEvent {
		public Window window;
		public uint16 x;
		public uint16 y;
		public uint16 width;
		public uint16 height;
	}

	[CCode (cname = "xcb_cw_t")]
	public enum CW {
		BACK_PIXMAP,
		BACK_PIXEL,
		BORDER_PIXMAP,
		BORDER_PIXEL,
		BIT_GRAVITY,
		WIN_GRAVITY,
		BACKING_STORE,
		BACKING_PLANES,
		BACKING_PIXEL,
		OVERRIDE_REDIRECT,
		SAVE_UNDER,
		EVENT_MASK,
		DONT_PROPAGATE,
		COLORMAP,
		CURSOR
	}

	[CCode (cname = "xcb_event_mask_t")]
	public enum EventMask {
		NO_EVENT,
		KEY_PRESS,
		KEY_RELEASE,
		BUTTON_PRESS,
		BUTTON_RELEASE,
		ENTER_WINDOW,
		LEAVE_WINDOW,
		POINTER_MOTION,
		POINTER_MOTION_HINT,
		BUTTON_1MOTION,
		BUTTON_2MOTION,
		BUTTON_3MOTION,
		BUTTON_4MOTION,
		BUTTON_5MOTION,
		BUTTON_MOTION,
		KEYMAP_STATE,
		EXPOSURE,
		VISIBILITY_CHANGE,
		STRUCTURE_NOTIFY,
		RESIZE_REDIRECT,
		SUBSTRUCTURE_NOTIFY,
		SUBSTRUCTURE_REDIRECT,
		FOCUS_CHANGE,
		PROPERTY_CHANGE,
		COLOR_MAP_CHANGE,
		OWNER_GRAB_BUTTON
	}

	[Compact]
	[CCode (cname = "xcb_screen_t", ref_function = "", unref_function = "")]
	public class Screen {
		public Window root;
		public uint32 white_pixel;
		public uint32 black_pixel;
		public uint16 width_in_pixels;
		public uint16 height_in_pixels;
		public uint16 width_in_millimeters;
		public uint16 height_in_millimeters;
		public VisualID root_visual;
		public DepthIterator allowed_depths_iterator ();
	}

	[SimpleType]
	[CCode (cname = "xcb_screen_iterator_t")]
	public struct ScreenIterator {
		public unowned Screen data;
		public int rem;
		public int index;
		public static void next (ref ScreenIterator iter);
	}

	[Compact]
	[CCode (cname = "xcb_depth_t", ref_function = "", unref_function = "")]
	public class Depth {
		public uint8 depth;
		public VisualTypeIterator visuals_iterator ();
	}

	[Compact]
	[CCode (cname = "xcb_query_tree_reply_t", ref_function = "", unref_function = "")]
	public class QueryTreeReply {
		public Window root;
		public Window parent;
		public uint16 children_len;
		[CCode (cname = "xcb_query_tree_children", array_length = false)]
		public Window* children();
	}

	[CCode (cname = "xcb_depth_iterator_t")]
	public struct DepthIterator {
		public unowned Depth data;
		public int rem;
		[CCode (cname = "xcb_depth_next")]
		public void next ();
	}

	[CCode (cname = "xcb_visualtype_iterator_t")]
	public struct VisualTypeIterator {
		public unowned VisualType data;
		public int rem;
		[CCode (cname = "xcb_visualtype_next")]
		public void next ();
	}

	[Deprecated (since = "vala-0.14", replacement = "Xcb.Connection")]
	public Connection connect (string? display = null, out int screen = null);
	[Deprecated (since = "vala-0.14", replacement = "Xcb.Connection.create_window")]
	public VoidCookie create_window (Connection connection, uint8 depth, Window wid, Window parent, int16 x, int16 y, uint16 width, uint16 height, uint16 border_width, uint16 _class, VisualID visual, uint32 value_mask, [CCode (array_length = false)] uint32[] value_list);
	[Deprecated (since = "vala-0.14", replacement = "Xcb.Connection.map_window")]
	public VoidCookie map_window (Connection connection, Window wid);

	[SimpleType]
	[CCode (cname = "xcb_void_cookie_t")]
	public struct VoidCookie {
	}

	[SimpleType]
	[CCode (cname = "xcb_query_tree_cookie_t")]
	public struct QueryTreeCookie {
	}

	[CCode (cname = "xcb_rectangle_t")]
	public struct Rectangle {
		public int16 x;
		public int16 y;
		public uint16 width;
		public uint16 height;
	}

	public struct VisualID : uint32 {
	}

	public struct Button : uint8 {
	}

	[SimpleType]
	[IntegerType (rank = 9)]
	[CCode (cname = "xcb_drawable_t", type_id = "G_TYPE_INT",
			marshaller_type_name = "INT",
			get_value_function = "g_value_get_int",
			set_value_function = "g_value_set_int", default_value = "0",
			type_signature = "i")]
	public struct Drawable : uint32 {
	}

	[SimpleType]
	[IntegerType (rank = 9)]
	[CCode (cname = "xcb_window_t", type_id = "G_TYPE_INT",
			marshaller_type_name = "INT",
			get_value_function = "g_value_get_int",
			set_value_function = "g_value_set_int", default_value = "0",
			type_signature = "i")]
	public struct Window : Drawable {
	}

	[Compact]
	[CCode (cname = "xcb_visualtype_t", ref_function = "", unref_function = "")]
	public class VisualType {
		public VisualID visual_id;
		public uint8 _class;
		public uint8 bits_per_rgb_value;
	}
}

