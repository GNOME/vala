namespace Rsvg {
	public class Handle : GLib.Object {
		[Deprecated (since = "2.36")]
		public unowned string get_desc ();
		[Deprecated (replacement = "GLib.Object.unref")]
		public void free ();
		[Deprecated (replacement = "render_cairo")]
		public void set_size_callback (owned Rsvg.SizeFunc size_func);
		[Deprecated (since = "2.36")]
		public unowned string get_title ();
		[Deprecated (since = "2.36")]
		public unowned string get_metadata ();
	}

	namespace Version {
		[CCode (cname = "LIBRSVG_CHECK_VERSION")]
		public static bool check (int major, int minor, int micro);
	}

	[Deprecated]
	public delegate void SizeFunc (ref int width, ref int height);

	[Deprecated (since = "2.36")]
	public static void init ();
	[Deprecated]
	public static Gdk.Pixbuf pixbuf_from_file (string file_name) throws GLib.Error;
	[Deprecated]
	public static Gdk.Pixbuf pixbuf_from_file_at_max_size (string file_name, int max_width, int max_height) throws GLib.Error;
	[Deprecated]
	public static Gdk.Pixbuf pixbuf_from_file_at_size (string file_name, int width, int height) throws GLib.Error;
	[Deprecated]
	public static Gdk.Pixbuf pixbuf_from_file_at_zoom (string file_name, double x_zoom, double y_zoom) throws GLib.Error;
	[Deprecated]
	public static Gdk.Pixbuf pixbuf_from_file_at_zoom_with_max (string file_name, double x_zoom, double y_zoom, int max_width, int max_height) throws GLib.Error;
	[Deprecated (since = "2.36")]
	public static void term ();
}
