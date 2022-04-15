/* wayland-client.vapi
 *
 * Copyright 2022 Corentin Noël <corentin.noel@collabora.com>
 *
 * Permission is hereby granted, free of charge, to any person obtaining
 * a copy of this software and associated documentation files (the
 * "Software"), to deal in the Software without restriction, including
 * without limitation the rights to use, copy, modify, merge, publish,
 * distribute, sublicense, and/or sell copies of the Software, and to
 * permit persons to whom the Software is furnished to do so, subject to
 * the following conditions:
 *
 * The above copyright notice and this permission notice (including the
 * next paragraph) shall be included in all copies or substantial
 * portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
 * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
 * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
 * NONINFRINGEMENT.  IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
 * BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
 * ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
 * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 * SOFTWARE.
 *
 * Authors:
 * 	Corentin Noël <corentin.noel@collabora.com>
 */

[CCode (cprefix = "wl_", lower_case_cprefix = "wl_", cheader_filename = "wayland-client.h")]
namespace Wl {
	[Compact]
	[CCode (cname = "struct wl_display", free_function = "wl_display_disconnect")]
	public class Display {
		[CCode (cname = "wl_display_connect")]
		public Display.connect (string name);
		[CCode (cname = "wl_display_connect_to_fd")]
		public Display.connect_to_fd (int fd);
		public int get_fd ();
		public int dispatch ();
		public int dispatch_queue (Wl.EventQueue queue);
		public int dispatch_queue_pending (Wl.EventQueue queue);
		public int get_error ();
		public int dispatch_pending ();
		public uint32 get_protocol_error (out unowned Wl.Interface interface, out uint32 id);
		public int flush ();
		public int roundtrip_queue (Wl.EventQueue queue);
		public int roundtrip ();
		public Wl.EventQueue create_queue ();
		public int prepare_read_queue (Wl.EventQueue queue);
		public int prepare_read ();
		public void cancel_read ();
		public int read_events ();
		public Wl.Callback sync ();
		public Wl.Registry get_registry ();
	}

	[Compact]
	[CCode (cname = "struct wl_compositor", free_function = "wl_compositor_destroy")]
	public class Compositor {
		public void set_user_data (void* user_data);
		public void* get_user_data ();
		public uint32 get_version ();
		public Wl.Surface create_surface ();
		public Wl.Region create_region ();
	}

	[Compact]
	[CCode (cname = "struct wl_callback", free_function = "wl_callback_destroy")]
	public class Callback {
		public int add_listener (Wl.CallbackListener listener, void* data);
		public void set_user_data (void* user_data);
		public void* get_user_data ();
		public uint32 get_version ();
	}

	[Compact]
	[CCode (cname = "struct wl_data_offer", free_function = "wl_data_offer_destroy")]
	public class DataOffer {
		public void set_user_data (void* user_data);
		public void* get_user_data ();
		public uint32 get_version ();
	}

	[Compact]
	[CCode (cname = "struct wl_data_source", free_function = "wl_data_source_destroy")]
	public class DataSource {
		public void set_user_data (void* user_data);
		public void* get_user_data ();
		public uint32 get_version ();
	}

	[Compact]
	[CCode (cname = "struct wl_data_device", free_function = "wl_data_device_destroy")]
	public class DataDevice {
		public void set_user_data (void* user_data);
		public void* get_user_data ();
		public uint32 get_version ();
	}

	[Compact]
	[CCode (cname = "struct wl_data_device_manager", free_function = "wl_data_device_manager_destroy")]
	public class DataDeviceManager {
		public void set_user_data (void* user_data);
		public void* get_user_data ();
		public uint32 get_version ();
	}

	[Compact]
	[CCode (cname = "struct wl_event_queue", free_function = "wl_event_queue_destroy")]
	public class EventQueue {
	}

	[Compact]
	[CCode (cname = "struct wl_proxy", free_function = "wl_proxy_destroy")]
	public class Proxy {
		public void set_user_data (void* user_data);
		public void* get_user_data ();
		public uint32 get_version ();
		public uint32 get_id ();
		public void set_tag ([CCode (array_length = false)] string[] tag);
		[CCode (array_length = false)]
		public unowned string[] get_tag ();
		public unowned string get_class ();
	}

	[Compact]
	[CCode (cname = "struct wl_surface", free_function = "wl_surface_destroy")]
	public class Surface : Wl.Proxy {
		public void set_user_data (void* user_data);
		public void* get_user_data ();
		public uint32 get_version ();
		public void attach (Wl.Buffer buffer, int32 x, int32 y);
		public void damage (int32 x, int32 y, int32 width, int32 height);
		public unowned Wl.Callback frame ();
		public void set_opaque_region (Wl.Region? region);
		public void set_input_region (Wl.Region? region);
		public void commit ();
		public void set_buffer_transform (int32 transform);
		public void set_buffer_scale (int32 transform);
		public void damage_buffer (int32 x, int32 y, int32 width, int32 height);
	}

	[Compact]
	[CCode (cname = "struct wl_buffer", free_function = "wl_buffer_destroy")]
	public class Buffer : Wl.Proxy {
		public void set_user_data (void* user_data);
		public void* get_user_data ();
		public uint32 get_version ();
	}

	[Compact]
	[CCode (cname = "struct wl_region", free_function = "wl_region_destroy")]
	public class Region : Wl.Proxy {
		public void set_user_data (void* user_data);
		public void* get_user_data ();
		public uint32 get_version ();
		public void add (int32 x, int32 y, int32 width, int32 height);
		public void subtract (int32 x, int32 y, int32 width, int32 height);
	}

	[Compact]
	[CCode (cname = "struct wl_interface")]
	public class Interface {
		public string name;
		public int version;
		[CCode (array_length = "method_count")]
		public Wl.Message[] methods;
		[CCode (array_length = "event_count")]
		public Wl.Message[] events;
	}

	[Compact]
	[CCode (cname = "struct wl_message")]
	public class Message {
		public string name;
		public string signature;
		[CCode (array_length = false)]
		public Wl.Interface?[] types;
	}

	[Compact]
	[CCode (cname = "struct wl_seat", free_function = "wl_seat_destroy")]
	public class Seat : Wl.Proxy {
		public void set_user_data (void* user_data);
		public void* get_user_data ();
		public uint32 get_version ();
		public Wl.Pointer get_pointer ();
		public Wl.Keyboard get_keyboard ();
		public Wl.Touch get_touch ();
		[DestroysInstance]
		public void release ();
	}

	[Compact]
	[CCode (cname = "struct wl_shell", free_function = "wl_shell_destroy")]
	public class Shell : Wl.Proxy {
		public void set_user_data (void* user_data);
		public void* get_user_data ();
		public uint32 get_version ();
		public Wl.ShellSurface get_shell_surface (Wl.Surface surface);
	}

	[Compact]
	[CCode (cname = "struct wl_shell_surface", free_function = "wl_shell_surface_destroy")]
	public class ShellSurface : Wl.Proxy {
		public void set_user_data (void* user_data);
		public void* get_user_data ();
		public uint32 get_version ();
		public void pong (uint32 serial);
		public void move (Wl.Seat seat, uint32 serial);
		public void resize (Wl.Seat seat, uint32 serial, uint32 edges);
		public void set_toplevel ();
		public void set_transient (Wl.Surface surface, int32 x, int32 y, uint32 flags);
		public void set_fullscreen (uint32 method, uint32 framerate, Wl.Output output);
		public void set_popup (Wl.Seat seat, uint32 serial, Wl.Surface parent, int32 x, int32 y, uint32 flags);
		public void set_maximized (Wl.Output output);
		public void set_title (string title);
		public void set_class (string class_);
	}

	[Compact]
	[CCode (cname = "struct wl_pointer", free_function = "wl_pointer_destroy")]
	public class Pointer : Wl.Proxy {
		public void set_user_data (void* user_data);
		public void* get_user_data ();
		public uint32 get_version ();
		[DestroysInstance]
		public void release ();
	}

	[Compact]
	[CCode (cname = "struct wl_registry", free_function = "wl_registry_destroy")]
	public class Registry {
		public void set_user_data (void* user_data);
		public void* get_user_data ();
		public uint32 get_version ();
	}

	[Compact]
	[CCode (cname = "struct wl_keyboard", free_function = "wl_keyboard_destroy")]
	public class Keyboard : Wl.Proxy {
		public void set_user_data (void* user_data);
		public void* get_user_data ();
		public uint32 get_version ();
		[DestroysInstance]
		public void release ();
	}

	[Compact]
	[CCode (cname = "struct wl_touch", free_function = "wl_touch_destroy")]
	public class Touch : Wl.Proxy {
		public void set_user_data (void* user_data);
		public void* get_user_data ();
		public uint32 get_version ();
		[DestroysInstance]
		public void release ();
	}

	[Compact]
	[CCode (cname = "struct wl_output", free_function = "wl_output_destroy")]
	public class Output : Wl.Proxy {
		public void set_user_data (void* user_data);
		public void* get_user_data ();
		public uint32 get_version ();
		[DestroysInstance]
		public void release ();
		public int add_listener (Wl.OutputListener listener, void* data);
	}

	[CCode (cname = "struct wl_callback_listener", has_type_id = false)]
	public struct CallbackListener {
		public Wl.CallbackListenerDone done;
	}

	[CCode (cprefix = "WL_SHELL_SURFACE_RESIZE_", cname = "enum wl_shell_surface_resize", has_type_id = false)]
	public enum ShellSurfaceResize {
		NONE,
		TOP,
		BOTTOM,
		LEFT,
		TOP_LEFT,
		BOTTOM_LEFT,
		RIGHT,
		TOP_RIGHT,
		BOTTOM_RIGHT
	}

	[CCode (cprefix = "WL_SHELL_SURFACE_TRANSIENT_", cname = "enum wl_shell_surface_transient", has_type_id = false)]
	public enum ShellSurfaceTranscient {
		INACTIVE
	}

	[CCode (cprefix = "WL_SHELL_SURFACE_FULLSCREEN_METHOD_", cname = "enum wl_shell_surface_fullscreen_method", has_type_id = false)]
	public enum ShellSurfaceFullscreenMethod {
		DEFAULT,
		SCALE,
		DRIVER,
		FILL
	}

	[CCode (cprefix = "WL_SEAT_CAPABILITY_", cname = "enum wl_seat_capability", has_type_id = false)]
	public enum SeatCapability {
		POINTER,
		KEYBOARD,
		TOUCH
	}

	[CCode (cprefix = "WL_POINTER_BUTTON_STATE_", cname = "enum wl_pointer_button_state", has_type_id = false)]
	public enum PointerButtonState {
		RELEASED,
		PRESSED
	}

	[CCode (cprefix = "WL_POINTER_AXIS_", cname = "enum wl_pointer_axis", has_type_id = false)]
	public enum PointerAxis {
		VERTICAL_SCROLL,
		HORIZONTAL_SCROLL
	}

	[CCode (cprefix = "WL_POINTER_AXIS_SOURCE_", cname = "enum wl_pointer_axis_source", has_type_id = false)]
	public enum PointerAxisSource {
		WHEEL,
		FINGER,
		CONTINUOUS,
		WHEEL_TILT
	}

	[CCode (cprefix = "WL_KEYBOARD_KEYMAP_FORMAT_", cname = "enum wl_keyboard_keymap_format", has_type_id = false)]
	public enum KeyboardKeymapFormat {
		NO_KEYMAP,
		XKB_V1
	}

	[CCode (cprefix = "WL_KEYBOARD_KEY_STATE_", cname = "enum wl_keyboard_key_state", has_type_id = false)]
	public enum KeyboardKeyState {
		RELEASED,
		PRESSED
	}

	[CCode (cname = "struct wl_output_listener", has_type_id = false)]
	public struct OutputListener {
		public Wl.OutputListenerGeometry geometry;
		public Wl.OutputListenerMode mode;
		public Wl.OutputListenerDone done;
		public Wl.OutputListenerScale scale;
	}

	[CCode (cprefix = "WL_OUTPUT_SUBPIXEL_", cname = "enum wl_output_subpixel", has_type_id = false)]
	public enum OutputSubpixel {
		UNKNOWN,
		NONE,
		HORIZONTAL_RGB,
		HORIZONTAL_BGR,
		VERTICAL_RGB,
		VERTICAL_BGR
	}

	[CCode (cprefix = "WL_OUTPUT_TRANSFORM_", cname = "enum wl_output_transform", has_type_id = false)]
	public enum OutputTransform {
		NORMAL,
		[CCode (cname = "WL_OUTPUT_TRANSFORM_90")]
		_90,
		[CCode (cname = "WL_OUTPUT_TRANSFORM_180")]
		_180,
		[CCode (cname = "WL_OUTPUT_TRANSFORM_270")]
		_270,
		FLIPPED,
		FLIPPED_90,
		FLIPPED_180,
		FLIPPED_270
	}

	[CCode (cprefix = "WL_OUTPUT_MODE_", cname = "enum wl_output_mode", has_type_id = false)]
	public enum OutputMode {
		CURRENT,
		PREFERRED
	}

	[CCode (has_target = false, has_typedef = false)]
	public delegate void CallbackListenerDone (void *data, Wl.Callback wl_callback, uint32 callback_data);

	[CCode (has_target = false, has_typedef = false)]
	public delegate void OutputListenerGeometry (void *data, Wl.Output wl_output, int32 x, int32 y, int32 physical_width, int32 physical_height, int32 subpixel, string make, string model, int32 transform);
	[CCode (has_target = false, has_typedef = false)]
	public delegate void OutputListenerMode (void *data, Wl.Output wl_output, uint32 flags, int32 width, int32 height, int32 refresh);
	[CCode (has_target = false, has_typedef = false)]
	public delegate void OutputListenerDone (void *data, Wl.Output wl_output);
	[CCode (has_target = false, has_typedef = false)]
	public delegate void OutputListenerScale (void *data, Wl.Output wl_output, int32 factor);

	[CCode (cname = "WAYLAND_VERSION_MAJOR")]
	public const int VERSION_MAJOR;
	[CCode (cname = "WAYLAND_VERSION_MINOR")]
	public const int VERSION_MINOR;
	[CCode (cname = "WAYLAND_VERSION_MICRO")]
	public const int VERSION_MICRO;
	[CCode (cname = "WAYLAND_VERSION")]
	public const string VERSION;
}
