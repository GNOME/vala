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
	[CCode (cname = "xcb_connection_t", cprefix = "xcb_", ref_function = "", unref_function = "")]
	public class Connection {
		public void disconnect ();
		public void flush ();
		public uint32 generate_id ();
		public Setup get_setup ();
	}

	[Compact]
	[CCode (cname = "xcb_setup_t", ref_function = "", unref_function = "")]
	public class Setup {
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
		public VisualID root_visual;
		public DepthIterator allowed_depths_iterator ();
	}

	[CCode (cname = "xcb_screen_iterator_t")]
	public struct ScreenIterator {
		public unowned Screen data;
		public int rem;
		public int next;
	}

	[Compact]
	[CCode (cname = "xcb_depth_t", ref_function = "", unref_function = "")]
	public class Depth {
		public uint8 depth;
		public VisualTypeIterator visuals_iterator ();
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

	public Connection connect (string? display = null, out int screen = null);
	public VoidCookie create_window (Connection connection, uint8 depth, Window wid, Window parent, int16 x, int16 y, uint16 width, uint16 height, uint16 border_width, uint16 _class, VisualID visual, uint32 value_mask, [CCode (array_length = false)] uint32[] value_list);
	public VoidCookie map_window (Connection connection, Window wid);

	public struct VoidCookie {
	}

	public struct VisualID : uint32 {
	}

	public struct Button : uint8 {
	}

	[CCode (cname = "xcb_drawable_t")]
	public struct Drawable : uint32 {
	}

	[CCode (cname = "xcb_window_t")]
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

