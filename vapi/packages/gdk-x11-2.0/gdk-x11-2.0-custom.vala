namespace Gdk {
	[CCode (cheader_filename = "gdk/gdkx.h")]
	public static unowned X.Display x11_gc_get_xdisplay (Gdk.GC gc);

	[CCode (cheader_filename = "gdk/gdkx.h")]
	public static X.GC x11_gc_get_xgc (Gdk.GC gc);

	[CCode (cheader_filename = "gdk/gdkx.h", cname = "gdk_net_wm_supports")]
	public static bool x11_net_wm_supports (Gdk.Atom property);

	[CCode (cheader_filename = "gdk/gdkx.h", cname = "gdkx_visual_get")]
	public static unowned Gdk.Visual x11_visual_get (X.VisualID xvisualid);

	[CCode (cheader_filename = "gdk/gdkx.h", cname = "gdk_xid_table_lookup")]
	public static void* x11_xid_table_lookup (X.ID xid);
	[CCode (cheader_filename = "gdk/gdkx.h", cname = "gdk_xid_table_lookup_for_display")]
	public static void* x11_xid_table_lookup_for_display (Gdk.Display display, X.ID xid);
}
