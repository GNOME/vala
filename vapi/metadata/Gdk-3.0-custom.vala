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

	[CCode (cheader_filename = "gdk/gdk.h", copy_function = "g_boxed_copy", free_function = "g_boxed_free", type_id = "gdk_event_get_type ()")]
	[Compact]
	public class Event {
		public Gdk.EventAny any { [CCode (cname = "(GdkEventAny *)")] get; }
		public Gdk.EventButton button { [CCode (cname = "(GdkEventButton *)")] get; }
		public Gdk.EventConfigure configure { [CCode (cname = "(GdkEventConfigure *)")] get; }
		public Gdk.EventCrossing crossing { [CCode (cname = "(GdkEventCrossing *)")] get; }
		public Gdk.EventDND dnd { [CCode (cname = "(GdkEventDND *)")] get; }
		public Gdk.EventExpose expose { [CCode (cname = "(GdkEventExpose *)")] get; }
		public Gdk.EventFocus focus_change { [CCode (cname = "(GdkEventFocus *)")] get; }
		public Gdk.EventGrabBroken grab_broken { [CCode (cname = "(GdkEventGrabBroken *)")] get; }
		public Gdk.EventKey key { [CCode (cname = "(GdkEventKey *)")] get; }
		public Gdk.EventMotion motion { [CCode (cname = "(GdkEventMotion *)")] get; }
		public Gdk.EventOwnerChange owner_change { [CCode (cname = "(GdkEventOwnerChange *)")] get; }
		public Gdk.EventProperty property { [CCode (cname = "(GdkEventProperty *)")] get; }
		public Gdk.EventProximity proximity { [CCode (cname = "(GdkEventProximity *)")] get; }
		public Gdk.EventScroll scroll { [CCode (cname = "(GdkEventScroll *)")] get; }
		public Gdk.EventSelection selection { [CCode (cname = "(GdkEventSelection *)")] get; }
		public Gdk.EventSetting setting { [CCode (cname = "(GdkEventSetting *)")] get; }
		public Gdk.EventTouch touch { [CCode (cname = "(GdkEventTouch *)")] get; }
		public Gdk.EventVisibility visibility { [CCode (cname = "(GdkEventVisibility *)")] get; }
		public Gdk.EventWindowState window_state { [CCode (cname = "(GdkEventWindowState *)")] get; }
	}

	[CCode (cheader_filename = "gdk/gdk.h", copy_function = "g_boxed_copy", free_function = "g_boxed_free", type_id = "gdk_event_get_type ()")]
	[Compact]
	public class EventKey : Event {
		[CCode (cname = "string")]
		public string str;
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
