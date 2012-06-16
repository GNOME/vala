namespace Gdk {
	public class Screen : GLib.Object {
		public void get_monitor_geometry (int monitor_num, out Gdk.Rectangle dest);
	}

	public class Window : GLib.Object {
		public void get_frame_extents (out Gdk.Rectangle rect);
	}

	[SimpleType]
	public struct Atom : uint {
		[CCode (cname = "GDK_NONE")]
		public static Gdk.Atom NONE;
	}

	[CCode (cheader_filename = "gdk/gdk.h", has_type_id = false)]
	public struct EventKey {
		[CCode (cname = "string")]
		public weak string str;
	}

	public struct Rectangle : Cairo.RectangleInt {
		public bool intersect (Gdk.Rectangle src2, out Gdk.Rectangle dest);
		public void union (Gdk.Rectangle src2, out Gdk.Rectangle dest);
	}

	[CCode (ref_function = "", unref_function = "")]
	[Compact]
	public class XEvent {
	}

	public const Gdk.Atom SELECTION_CLIPBOARD;
	[CCode (cheader_filename = "gdk/gdk.h")]
	public const Gdk.Atom SELECTION_PRIMARY;
	[CCode (cheader_filename = "gdk/gdk.h")]
	public const Gdk.Atom SELECTION_SECONDARY;
	[CCode (cheader_filename = "gdk/gdk.h")]

	public static bool events_get_angle (Gdk.Event event1, Gdk.Event event2, double angle);
	[CCode (cheader_filename = "gdk/gdk.h")]
	public static bool events_get_center (Gdk.Event event1, Gdk.Event event2, double x, double y);
	[CCode (cheader_filename = "gdk/gdk.h")]
	public static bool events_get_distance (Gdk.Event event1, Gdk.Event event2, double distance);

	[Deprecated (replacement = "Selection.convert", since = "vala-0.12")]
	public static void selection_convert (Gdk.Window requestor, Gdk.Atom selection, Gdk.Atom target, uint32 time_);
	[Deprecated (replacement = "Selection.owner_get", since = "vala-0.12")]
	public static unowned Gdk.Window selection_owner_get (Gdk.Atom selection);
	[CCode (cheader_filename = "gdk/gdk.h")]
	[Deprecated (replacement = "Selection.owner_get_for_display", since = "vala-0.12")]
	public static unowned Gdk.Window selection_owner_get_for_display (Gdk.Display display, Gdk.Atom selection);
	[Deprecated (replacement = "Selection.owner_set", since = "vala-0.12")]
	public static bool selection_owner_set (Gdk.Window owner, Gdk.Atom selection, uint32 time_, bool send_event);
	[Deprecated (replacement = "Selection.owner_set_for_display", since = "vala-0.12")]
	public static bool selection_owner_set_for_display (Gdk.Display display, Gdk.Window owner, Gdk.Atom selection, uint32 time_, bool send_event);
	[Deprecated (replacement = "Selection.property_get", since = "vala-0.12")]
	public static int selection_property_get (Gdk.Window requestor, uchar[] data, out Gdk.Atom prop_type, int prop_format);
	[Deprecated (replacement = "Selection.send_notify", since = "vala-0.12")]
	public static void selection_send_notify (Gdk.Window requestor, Gdk.Atom selection, Gdk.Atom target, Gdk.Atom property, uint32 time_);
	[Deprecated (replacement = "Selection.send_notify_for_display", since = "vala-0.12")]
	public static void selection_send_notify_for_display (Gdk.Display display, Gdk.Window requestor, Gdk.Atom selection, Gdk.Atom target, Gdk.Atom property, uint32 time_);
}
