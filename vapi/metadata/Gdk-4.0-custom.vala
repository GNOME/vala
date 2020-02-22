namespace Gdk {
	[CCode (cheader_filename = "gdk/gdk.h")]
	public struct Rectangle : Cairo.RectangleInt {
	}

	[CCode (cheader_filename = "gdk/gdk.h", cname = "GdkEvent", ref_function = "gdk_event_ref", type_id = "gdk_event_get_type ()", unref_function = "gdk_event_unref")]
	public class ButtonEvent : Gdk.Event {
	}
	[CCode (cheader_filename = "gdk/gdk.h", cname = "GdkEvent", ref_function = "gdk_event_ref", type_id = "gdk_event_get_type ()", unref_function = "gdk_event_unref")]
	public class ConfigureEvent : Gdk.Event {
	}
	[CCode (cheader_filename = "gdk/gdk.h", cname = "GdkEvent", ref_function = "gdk_event_ref", type_id = "gdk_event_get_type ()", unref_function = "gdk_event_unref")]
	public class CrossingEvent : Gdk.Event {
	}
	[CCode (cheader_filename = "gdk/gdk.h", cname = "GdkEvent", ref_function = "gdk_event_ref", type_id = "gdk_event_get_type ()", unref_function = "gdk_event_unref")]
	public class FocusEvent : Gdk.Event {
	}
	[CCode (cheader_filename = "gdk/gdk.h", cname = "GdkEvent", ref_function = "gdk_event_ref", type_id = "gdk_event_get_type ()", unref_function = "gdk_event_unref")]
	public class GrabBrokenEvent : Gdk.Event {
	}
	[CCode (cheader_filename = "gdk/gdk.h", cname = "GdkEvent", ref_function = "gdk_event_ref", type_id = "gdk_event_get_type ()", unref_function = "gdk_event_unref")]
	public class KeyEvent : Gdk.Event {
	}
	[CCode (cheader_filename = "gdk/gdk.h", cname = "GdkEvent", ref_function = "gdk_event_ref", type_id = "gdk_event_get_type ()", unref_function = "gdk_event_unref")]
	public class PadAxisEvent : Gdk.Event {
	}
	[CCode (cheader_filename = "gdk/gdk.h", cname = "GdkEvent", ref_function = "gdk_event_ref", type_id = "gdk_event_get_type ()", unref_function = "gdk_event_unref")]
	public class PadButtonEvent : Gdk.Event {
	}
	[CCode (cheader_filename = "gdk/gdk.h", cname = "GdkEvent", ref_function = "gdk_event_ref", type_id = "gdk_event_get_type ()", unref_function = "gdk_event_unref")]
	public class PadEvent : Gdk.Event {
	}
	[CCode (cheader_filename = "gdk/gdk.h", cname = "GdkEvent", ref_function = "gdk_event_ref", type_id = "gdk_event_get_type ()", unref_function = "gdk_event_unref")]
	public class ScrollEvent : Gdk.Event {
	}
	[CCode (cheader_filename = "gdk/gdk.h", cname = "GdkEvent", ref_function = "gdk_event_ref", type_id = "gdk_event_get_type ()", unref_function = "gdk_event_unref")]
	public class TouchEvent : Gdk.Event {
	}
	[CCode (cheader_filename = "gdk/gdk.h", cname = "GdkEvent", ref_function = "gdk_event_ref", type_id = "gdk_event_get_type ()", unref_function = "gdk_event_unref")]
	public class TouchpadEvent : Gdk.Event {
	}
	[CCode (cheader_filename = "gdk/gdk.h", cname = "GdkEvent", ref_function = "gdk_event_ref", type_id = "gdk_event_get_type ()", unref_function = "gdk_event_unref")]
	public class TouchpadPinchEvent : Gdk.Event {
	}
}
