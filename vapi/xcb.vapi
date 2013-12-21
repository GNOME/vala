/* xcb.vapi
 *
 * Copyright (C) 2009  Jürg Billeter
 * Copyright (C) 2013  Sergio Costas
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
 * Authors:
 * 	Jürg Billeter <j@bitron.ch>
 *  Sergio Costas <raster@rastersoft.com>
 */

[CCode (lower_case_cprefix = "xcb_", cheader_filename = "xcb/xcb.h,xcb/xproto.h")]
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
		public GenericEvent poll_for_event();
		public int get_file_descriptor ();
		public VoidCookie create_window (uint8 depth, Window wid, Window parent, int16 x, int16 y, uint16 width, uint16 height, uint16 border_width, uint16 _class, VisualID visual, uint32 value_mask, [CCode (array_length = false)] uint32[]? value_list);
		public VoidCookie create_window_checked (uint8 depth, Window wid, Window parent, int16 x, int16 y, uint16 width, uint16 height, uint16 border_width, uint16 _class, VisualID visual, uint32 value_mask, [CCode (array_length = false)] uint32[]? value_list);
		public VoidCookie map_window (Window wid);
		public VoidCookie map_window_checked (Window wid);
		public VoidCookie unmap_window (Window wid);
		public VoidCookie unmap_window_checked (Window wid);
		public GetWindowAttributesCookie get_window_attributes (Window wid);
		public GetWindowAttributesCookie get_window_attributes_unchecked (Window wid);
		public GetWindowAttributesReply get_window_attributes_reply(GetWindowAttributesCookie cookie, out GenericError? e);
		public VoidCookie change_window_attributes (Window wid, uint32 value_mask, [CCode (array_length = false)] uint32[]? value_list);
		public VoidCookie change_window_attributes_checked (Window wid, uint32 value_mask, [CCode (array_length = false)] uint32[]? value_list);
		public QueryTreeCookie query_tree (Window wid);
		public QueryTreeCookie query_tree_unchecked (Window wid);
		public QueryTreeReply query_tree_reply (QueryTreeCookie cookie, out GenericError? e);

		[CCode (cname = "xcb_intern_atom")]
		private InternAtomCookie vala_intern_atom(bool only_if_exists,uint16 len, string name);
		[CCode (cname = "vala_xcb_intern_atom")]
		public InternAtomCookie intern_atom(bool only_if_exists,string name) {
			return this.vala_intern_atom(only_if_exists,(uint16)name.length,name);
		}
		[CCode (cname = "xcb_intern_atom_unchecked")]
		private InternAtomCookie vala_intern_atom_unchecked(bool only_if_exists,uint16 len, string name);
		[CCode (cname = "vala_xcb_intern_atom_unchecked")]
		public InternAtomCookie intern_atom_unchecked(bool only_if_exists,string name) {
			return this.vala_intern_atom(only_if_exists,(uint16)name.length,name);
		}
		public InternAtomReply intern_atom_reply(InternAtomCookie cookie, out GenericError? e);
		
		[CCode (cname = "xcb_change_property")]
		private VoidCookie vala_change_property(PropMode mode, Window window, AtomT property, AtomT type, uint8 format, uint32 len, void *data);
		[CCode (cname = "vala_xcb_change_property")]
		public VoidCookie change_property_uint8(PropMode mode, Window window, AtomT property, AtomT type, uint32 len, uint8 *data) {
			return this.vala_change_property(mode,window,property,type, 8, len, (void *)data);
		}
		public VoidCookie change_property_uint16(PropMode mode, Window window, AtomT property, AtomT type, uint32 len, uint16 *data) {
			return this.vala_change_property(mode,window,property,type, 16, len, (void *)data);
		}
		public VoidCookie change_property_uint32(PropMode mode, Window window, AtomT property, AtomT type, uint32 len, uint32 *data) {
			return this.vala_change_property(mode,window,property,type, 32, len, (void *)data);
		}
		public VoidCookie change_property_atom(PropMode mode, Window window, AtomT property, AtomT type, uint32 len, AtomT *data) {
			return this.vala_change_property(mode,window,property,type, 32, len, (void *)data);
		}
		public VoidCookie change_property_string(PropMode mode, Window window, AtomT property, AtomT type, string data) {
			return this.vala_change_property(mode,window,property,type, 8, data.length, (void *)data.data);
		}
		
		[CCode (cname = "xcb_change_property_checked")]
		private VoidCookie vala_change_property_checked(PropMode mode, Window window, AtomT property, AtomT type, uint8 format, uint32 len, void *data);
		[CCode (cname = "vala_xcb_change_property_checked")]
		public VoidCookie change_property_checked_uint8(PropMode mode, Window window, AtomT property, AtomT type, uint32 len, uint8 *data) {
			return this.vala_change_property(mode,window,property,type, 8, len, (void *)data);
		}
		public VoidCookie change_property_checked_uint16(PropMode mode, Window window, AtomT property, AtomT type, uint32 len, uint16 *data) {
			return this.vala_change_property(mode,window,property,type, 16, len, (void *)data);
		}
		public VoidCookie change_property_checked_uint32(PropMode mode, Window window, AtomT property, AtomT type, uint32 len, uint32 *data) {
			return this.vala_change_property(mode,window,property,type, 32, len, (void *)data);
		}
		public VoidCookie change_property_checked_atom(PropMode mode, Window window, AtomT property, AtomT type, uint32 len, AtomT *data) {
			return this.vala_change_property(mode,window,property,type, 32, len, (void *)data);
		}
		public VoidCookie change_property_checked_string(PropMode mode, Window window, AtomT property, AtomT type, string data) {
			return this.vala_change_property(mode,window,property,type, 8, data.length, (void *)data.data);
		}
		
		public GetPropertyCookie get_property(bool _delete, Window window, AtomT property, AtomT type, uint32 long_offset, uint32 long_length);
		public GetPropertyCookie get_property_unchecked(bool _delete, Window window, AtomT property, AtomT type, uint32 long_offset, uint32 long_length);
		public GetPropertyReply ? get_property_reply(GetPropertyCookie cookie, out GenericError? e);

		public VoidCookie configure_window(Window window, uint16 value_mask, uint32 *value_list);
		
		public VoidCookie reparent_window(Window window, Window parent, uint16 x, uint16 y);
		public VoidCookie reparent_window_checked(Window window, Window parent, uint16 x, uint16 y);

		public GetGeometryCookie get_geometry(Drawable drawable);
		public GetGeometryCookie get_geometry_unchecked(Drawable drawable);
		public GetGeometryReply ? get_geometry_reply(GetGeometryCookie cookie, out GenericError ? e);
	}
 
	[SimpleType]
	[IntegerType (rank = 9)]
	[CCode (cname = "xcb_get_geometry_cookie_t", has_type_id = false)]
	public struct GetGeometryCookie {
	}

	[CCode (cname = "xcb_get_geometry_reply_t", ref_function = "", unref_function = "free")]
	public class GetGeometryReply {
		public uint8      response_type;
		public uint8      depth;
		public uint16     sequence;
		public uint32     length;
		public Window     root;
		public int16      x;
		public int16      y;
		public uint16     width;
		public uint16     height;
		public uint16     border_width;
		public uint8      pad0[2];
	}

	[SimpleType]
	[IntegerType (rank = 9)]
	[CCode (cname = "xcb_intern_atom_cookie_t", has_type_id = false)]
	public struct InternAtomCookie {
	}

	[SimpleType]
	[IntegerType (rank = 9)]
	[CCode (cname = "xcb_get_window_attributes_cookie_t", has_type_id = false)]
	public struct GetWindowAttributesCookie {
	}

	[Compact]
	[CCode (cname = "xcb_get_window_attributes_reply_t", ref_function = "", unref_function = "")]
	public class GetWindowAttributesReply {
		public uint8        response_type;
		public uint8        backing_store;
		public uint16       sequence;
		public uint32       length;
		public VisualID     visual;
		public uint16       _class;
		public uint8        bit_gravity;
		public uint8        win_gravity;
		public uint32       backing_planes;
		public uint32       backing_pixel;
		public uint8        save_under;
		public uint8        map_is_installed;
		public uint8        map_state;
		public uint8        override_redirect;
		public Colormap     colormap;
		public uint32       all_event_masks;
		public uint32       your_event_mask;
		public uint16       do_not_propagate_mask;
		public uint8        pad0[2];
	}

	[SimpleType]
	[IntegerType (rank = 9)]
	[CCode (cname = "xcb_get_property_cookie_t", has_type_id = false)]
	public struct GetPropertyCookie {
	}

	[Compact]
	[CCode (cname = "xcb_get_property_reply_t", ref_function = "", unref_function = "free")]
	public class GetPropertyReply {
		public uint8 format;
		public Atom type;
		[CCode (cname = "xcb_get_property_value_length")]
		public int32 value_length();
		[CCode (cname = "xcb_get_property_value")]
		public unowned void *value();
	}

	[Compact]
	[CCode (cname = "xcb_intern_atom_reply_t", ref_function = "", unref_function = "free")]
	public class InternAtomReply {
		private uint8    response_type;
		private uint8    pad0;
		private uint16   sequence;
		public  uint32   length;
		public  AtomT    atom;
	}
	
	[SimpleType]
	[IntegerType (rank = 9)]
	[CCode (cname = "xcb_atom_t", has_type_id = false)]
	public struct AtomT {
	}
	
	[CCode (cname = "xcb_prop_mode_t", has_type_id = false)]
	public enum PropMode {
		REPLACE,
		PREPEND,
		APPEND
	}
	
	[CCode (cname = "xcb_atom_enum_t", has_type_id = false)]
	public enum Atom {
		NONE,
		ANY,
		PRIMARY,
		SECONDARY,
		ARC,
		ATOM,
		BITMAP,
		CARDINAL,
		COLORMAP,
		CURSOR,
		CUT_BUFFER0,
		CUT_BUFFER1,
		CUT_BUFFER2,
		CUT_BUFFER3,
		CUT_BUFFER4,
		CUT_BUFFER5,
		CUT_BUFFER6,
		CUT_BUFFER7,
		DRAWABLE,
		FONT,
		INTEGER,
		PIXMAP,
		POINT,
		RECTANGLE,
		RESOURCE_MANAGER,
		RGB_COLOR_MAP,
		RGB_BEST_MAP,
		RGB_BLUE_MAP,
		RGB_DEFAULT_MAP,
		RGB_GRAY_MAP,
		RGB_GREEN_MAP,
		RGB_RED_MAP,
		STRING,
		VISUALID,
		WINDOW,
		WM_COMMAND,
		WM_HINTS,
		WM_CLIENT_MACHINE,
		WM_ICON_NAME,
		WM_ICON_SIZE,
		WM_NAME,
		WM_NORMAL_HINTS,
		WM_SIZE_HINTS,
		WM_ZOOM_HINTS,
		MIN_SPACE,
		NORM_SPACE,
		MAX_SPACE,
		END_SPACE,
		SUPERSCRIPT_X,
		SUPERSCRIPT_Y,
		SUBSCRIPT_X,
		SUBSCRIPT_Y,
		UNDERLINE_POSITION,
		UNDERLINE_THICKNESS,
		STRIKEOUT_ASCENT,
		STRIKEOUT_DESCENT,
		ITALIC_ANGLE,
		X_HEIGHT,
		QUAD_WIDTH,
		WEIGHT,
		POINT_SIZE,
		RESOLUTION,
		COPYRIGHT,
		NOTICE,
		FONT_NAME,
		FAMILY_NAME,
		FULL_NAME,
		CAP_HEIGHT,
		WM_CLASS,
		WM_TRANSIENT_FOR
	}
	
	public const uint8 KEY_PRESS;
	public const uint8 KEY_RELEASE;
	public const uint8 BUTTON_PRESS;
	public const uint8 BUTTON_RELEASE;
	public const uint8 MOTION_NOTIFY;
	public const uint8 ENTER_NOTIFY;
	public const uint8 LEAVE_NOTIFY;
	public const uint8 FOCUS_IN;
	public const uint8 FOCUS_OUT;
	public const uint8 KEYMAP_NOTIFY;
	public const uint8 EXPOSE;
	public const uint8 GRAPHICS_EXPOSURE;
	public const uint8 NO_EXPOSURE;
	public const uint8 VISIBILITY_NOTIFY;
	public const uint8 CREATE_NOTIFY;
	public const uint8 DESTROY_NOTIFY;
	public const uint8 UNMAP_NOTIFY;
	public const uint8 MAP_NOTIFY;
	public const uint8 MAP_REQUEST;
	public const uint8 REPARENT_NOTIFY;
	public const uint8 CONFIGURE_NOTIFY;
	public const uint8 CONFIGURE_REQUEST;
	public const uint8 GRAVITY_NOTIFY;
	public const uint8 RESIZE_REQUEST;
	public const uint8 CIRCULATE_NOTIFY;
	public const uint8 CIRCULATE_REQUEST;
	public const uint8 PROPERTY_NOTIFY;
	public const uint8 SELECTION_CLEAR;
	public const uint8 SELECTION_REQUEST;
	public const uint8 SELECTION_NOTIFY;
	public const uint8 COLORMAP_NOTIFY;
	public const uint8 CLIENT_MESSAGE;
	public const uint8 MAPPING_NOTIFY;
	
	public enum ConfigWindow {
		X,
		Y,
		WIDTH,
		HEIGHT,
		BORDER_WIDTH,
		SIBLING,
		STACK_MODE
	}
	
	[Compact]
	[CCode (cname = "xcb_setup_t", ref_function = "", unref_function = "")]
	public class Setup {
		public int roots_length ();
		public ScreenIterator roots_iterator ();
	}

	public const char COPY_FROM_PARENT;

	[CCode (cname = "xcb_window_class_t", has_type_id = false)]
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
	
	[SimpleType]
	[CCode (cname = "xcb_timestamp_t", has_type_id = false)]
	public struct Timestamp : uint32 {
	}

	[SimpleType]
	[CCode (cname = "xcb_keycode_t", has_type_id = false)]
	public struct Keycode : uint8 {
	}
	
	[SimpleType]
	[CCode (cname = "xcb_colormap_t", has_type_id = false)]
	public struct Colormap : uint32 {
	}

	[Compact]
	[CCode (cname = "xcb_key_press_event_t", ref_function = "", unref_function = "")]
	public class KeyPressEvent : GenericEvent {
		Keycode detail;
		uint16 sequence;
		Timestamp time;
		Window root;
		Window event;
		Window child;
		uint16 root_x;
		uint16 root_y;
		uint16 event_x;
		uint16 event_y;
		uint16 state;
		uint8 same_screen;
		uint8 pad0;
	}

	[Compact]
	[CCode (cname = "xcb_key_release_event_t", ref_function = "", unref_function = "")]
	public class KeyReleaseEvent : GenericEvent {
		Keycode detail;
		uint16 sequence;
		Timestamp time;
		Window root;
		Window event;
		Window child;
		uint16 root_x;
		uint16 root_y;
		uint16 event_x;
		uint16 event_y;
		uint16 state;
		uint8 same_screen;
		uint8 pad0;
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

	[Compact]
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

	[Compact]
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

	[Compact]
	[CCode (cname = "xcb_motion_notify_event_t", ref_function = "", unref_function = "")]
	public class MotionNotifyEvent : GenericEvent {
		uint8 detail;
		uint16 sequence;
		Timestamp time;
		public Window root;
		public Window event;
		public Window child;
		public uint16 root_x;
		public uint16 root_y;
		public uint16 event_x;
		public uint16 event_y;
		public uint16 state;
		public uint8 same_screen;
		public uint8 pad0;
	}

	[Compact]
	[CCode (cname = "xcb_expose_event_t", ref_function = "", unref_function = "")]
	public class ExposeEvent : GenericEvent {
		public uint8 pad0;
		public uint16 sequence;
		public Window window;
		public uint16 x;
		public uint16 y;
		public uint16 width;
		public uint16 height;
		public uint16 count;
		public uint8 pad1[2];
	}

	[Compact]
	[CCode (cname = "xcb_create_notify_event_t", ref_function = "", unref_function = "")]
	public class CreateNotifyEvent {
		public uint8 response_type;
		public uint8 pad0;
		public uint16 sequence;
		public Window parent;
		public Window window;
		public int16 x;
		public int16 y;
		public uint16 width;
		public uint16 height;
		public uint16 border_width;
		public uint8 override_redirect;
		public uint8 pad1;
	}

	[Compact]
	[CCode (cname = "xcb_destroy_notify_event_t", ref_function = "", unref_function = "")]
	public class DestroyNotifyEvent {
		public uint8 response_type;
		public uint8 pad0;
		public uint16 sequence;
		public Window event;
		public Window window;
	}

	[Compact]
	[CCode (cname = "xcb_unmap_notify_event_t", ref_function = "", unref_function = "")]
	public class UnmapNotifyEvent {
		public uint8 response_type;
		public uint8 pad0;
		public uint16 sequence;
		public Window event;
		public Window window;
		public uint8 from_configure;
		public uint8 pad1[3];
	}

	[Compact]
	[CCode (cname = "xcb_map_notify_event_t", ref_function = "", unref_function = "")]
	public class MapNotifyEvent {
		public uint8 response_type;
		public uint8 pad0;
		public uint16 sequence;
		public Window event;
		public Window window;
		public uint8 override_redirect;
		public uint8 pad1[3];
	}

	[Compact]
	[CCode (cname = "xcb_map_request_event_t", ref_function = "", unref_function = "")]
	public class MapRequestEvent {
		public uint8 response_type;
		public uint8 pad0;
		public uint16 sequence;
		public Window parent;
		public Window window;
	}

	[Compact]
	[CCode (cname = "xcb_configure_request_event_t", ref_function = "", unref_function = "")]
	public class ConfigureRequestEvent {
		public uint8 response_type;
		public uint8 stack_mode;
		public uint16 sequence;
		public Window parent;
		public Window window;
		public Window sibling;
		public int16 x;
		public int16 y;
		public uint16 width;
		public uint16 height;
		public uint16 border_width;
		public uint16 value_mask;
	}

	[Compact]
	[CCode (cname = "xcb_configure_notify_event_t", ref_function = "", unref_function = "")]
	public class ConfigureNotifyEvent {
		public uint8      response_type;
		public uint8      pad0;
		public uint16     sequence;
		public Window     event;
		public Window     window;
		public Window     above_sibling;
		public int16      x;
		public int16      y;
		public uint16     width;
		public uint16     height;
		public uint16     border_width;
		public uint8      override_redirect;
		public uint8      pad1;
	}

	[CCode (cname = "xcb_cw_t", has_type_id = false)]
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

	[CCode (cname = "xcb_event_mask_t", has_type_id = false)]
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
		BUTTON_1_MOTION,
		BUTTON_2_MOTION,
		BUTTON_3_MOTION,
		BUTTON_4_MOTION,
		BUTTON_5_MOTION,
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
	[CCode (cname = "xcb_screen_iterator_t", has_type_id = false)]
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

	[CCode (cname = "xcb_depth_iterator_t", has_type_id = false)]
	public struct DepthIterator {
		public unowned Depth data;
		public int rem;
		[CCode (cname = "xcb_depth_next")]
		public void next ();
	}

	[CCode (cname = "xcb_visualtype_iterator_t", has_type_id = false)]
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
	[CCode (cname = "xcb_void_cookie_t", has_type_id = false)]
	public struct VoidCookie {
	}

	[SimpleType]
	[CCode (cname = "xcb_query_tree_cookie_t", has_type_id = false)]
	public struct QueryTreeCookie {
	}

	[CCode (cname = "xcb_rectangle_t", has_type_id = false)]
	public struct Rectangle {
		public int16 x;
		public int16 y;
		public uint16 width;
		public uint16 height;
	}

	[SimpleType]
	[CCode (cname = "xcb_visualid_t", has_type_id = false)]
	public struct VisualID : uint32 {
	}

	[SimpleType]
	[CCode (cname = "xcb_button_t", has_type_id = false)]
	public struct Button : uint8 {
	}

	[SimpleType]
	[CCode (cname = "xcb_drawable_t", has_type_id = false)]
	public struct Drawable : uint32 {
	}

	[SimpleType]
	[CCode (cname = "xcb_window_t", has_type_id = false)]
	public struct Window : uint32 {
	}

	[Compact]
	[CCode (cname = "xcb_visualtype_t", ref_function = "", unref_function = "")]
	public class VisualType {
		public VisualID visual_id;
		public uint8 _class;
		public uint8 bits_per_rgb_value;
	}
}

