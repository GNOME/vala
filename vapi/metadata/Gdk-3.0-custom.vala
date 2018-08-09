namespace Gdk {
	[IntegerType]
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
		public Gdk.EventPadAxis pad_axis { [CCode (cname = "(GdkEventPadAxis *)")] get; }
		public Gdk.EventPadButton pad_button { [CCode (cname = "(GdkEventPadButton *)")] get; }
		public Gdk.EventPadGroupMode pad_group_mode { [CCode (cname = "(GdkEventPadGroupMode *)")] get; }
		public Gdk.EventProperty property { [CCode (cname = "(GdkEventProperty *)")] get; }
		public Gdk.EventProximity proximity { [CCode (cname = "(GdkEventProximity *)")] get; }
		public Gdk.EventScroll scroll { [CCode (cname = "(GdkEventScroll *)")] get; }
		public Gdk.EventSelection selection { [CCode (cname = "(GdkEventSelection *)")] get; }
		public Gdk.EventSetting setting { [CCode (cname = "(GdkEventSetting *)")] get; }
		public Gdk.EventTouch touch { [CCode (cname = "(GdkEventTouch *)")] get; }
		public Gdk.EventTouchpadPinch touchpad_pinch { [CCode (cname = "(GdkEventTouchpadPinch *)")] get; }
		public Gdk.EventTouchpadSwipe touchpad_swipe { [CCode (cname = "(GdkEventTouchpadSwipe *)")] get; }
		public Gdk.EventVisibility visibility { [CCode (cname = "(GdkEventVisibility *)")] get; }
		public Gdk.EventWindowState window_state { [CCode (cname = "(GdkEventWindowState *)")] get; }
	}

	[CCode (cheader_filename = "gdk/gdk.h")]
	public struct Rectangle : Cairo.RectangleInt {
	}

	[CCode (ref_function = "", unref_function = "")]
	[Compact]
	public class XEvent {
	}

	[CCode (cheader_filename = "gdk/gdk.h")]
	public const Gdk.Atom SELECTION_CLIPBOARD;
	[CCode (cheader_filename = "gdk/gdk.h")]
	public const Gdk.Atom SELECTION_PRIMARY;
	[CCode (cheader_filename = "gdk/gdk.h")]
	public const Gdk.Atom SELECTION_SECONDARY;
}
