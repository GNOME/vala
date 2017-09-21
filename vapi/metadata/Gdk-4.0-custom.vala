namespace Gdk {
	[SimpleType]
	public struct Atom : uint {
		[CCode (cname = "GDK_NONE")]
		public static Gdk.Atom NONE;
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
