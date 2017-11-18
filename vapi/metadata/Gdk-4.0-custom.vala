namespace Gdk {
	[CCode (cheader_filename = "gdk/gdk.h")]
	public struct Rectangle : Cairo.RectangleInt {
	}

	[CCode (ref_function = "", unref_function = "")]
	[Compact]
	public class XEvent {
	}

	[CCode (cheader_filename = "gdk/gdk.h")]
	public const Gdk.Atom NONE;
	[CCode (cheader_filename = "gdk/gdk.h")]
	public const Gdk.Atom SELECTION_CLIPBOARD;
	[CCode (cheader_filename = "gdk/gdk.h")]
	public const Gdk.Atom SELECTION_PRIMARY;
	[CCode (cheader_filename = "gdk/gdk.h")]
	public const Gdk.Atom SELECTION_SECONDARY;
	[CCode (cheader_filename = "gdk/gdk.h")]
	public const Gdk.Atom TARGET_BITMAP;
	[CCode (cheader_filename = "gdk/gdk.h")]
	public const Gdk.Atom TARGET_COLORMAP;
	[CCode (cheader_filename = "gdk/gdk.h")]
	public const Gdk.Atom TARGET_DRAWABLE;
	[CCode (cheader_filename = "gdk/gdk.h")]
	public const Gdk.Atom TARGET_PIXMAP;
	[CCode (cheader_filename = "gdk/gdk.h")]
	public const Gdk.Atom TARGET_STRING;
	[CCode (cheader_filename = "gdk/gdk.h")]
	public const Gdk.Atom SELECTION_TYPE_ATOM;
	[CCode (cheader_filename = "gdk/gdk.h")]
	public const Gdk.Atom SELECTION_TYPE_BITMAP;
	[CCode (cheader_filename = "gdk/gdk.h")]
	public const Gdk.Atom SELECTION_TYPE_COLORMAP;
	[CCode (cheader_filename = "gdk/gdk.h")]
	public const Gdk.Atom SELECTION_TYPE_DRAWABLE;
	[CCode (cheader_filename = "gdk/gdk.h")]
	public const Gdk.Atom SELECTION_TYPE_INTEGER;
	[CCode (cheader_filename = "gdk/gdk.h")]
	public const Gdk.Atom SELECTION_TYPE_PIXMAP;
	[CCode (cheader_filename = "gdk/gdk.h")]
	public const Gdk.Atom SELECTION_TYPE_WINDOW;
	[CCode (cheader_filename = "gdk/gdk.h")]
	public const Gdk.Atom SELECTION_TYPE_STRING;
}
