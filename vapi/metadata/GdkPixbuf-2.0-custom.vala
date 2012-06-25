namespace Gdk {
	public class Pixbuf : GLib.Object {
		[CCode (has_construct_function = false)]
		public Pixbuf.from_data ([CCode (array_length = false)] owned uint8[] data, Gdk.Colorspace colorspace, bool has_alpha, int bits_per_sample, int width, int height, int rowstride, [CCode (type = "GdkPixbufDestroyNotify")] Gdk.PixbufDestroyNotify? destroy_fn = GLib.free);
		[CCode (has_construct_function = false, cname = "gdk_pixbuf_new_from_data")]
		public Pixbuf.with_unowned_data ([CCode (array_length = false)] uint8[] data, Gdk.Colorspace colorspace, bool has_alpha, int bits_per_sample, int width, int height, int rowstride, [CCode (type = "GdkPixbufDestroyNotify")] Gdk.PixbufDestroyNotify? destroy_fn = null);
		[Deprecated (since = "vala-0.18", replacement = "Pixbuf.from_stream_async")]
		[CCode (cname = "gdk_pixbuf_new_from_stream_async", finish_name = "gdk_pixbuf_new_from_stream_finish")]
		public static async Gdk.Pixbuf new_from_stream_async (GLib.InputStream stream, GLib.Cancellable? cancellable = null) throws GLib.Error;
		[Deprecated (since = "vala-0.18", replacement = "Pixbuf.from_stream_at_scale_async")]
		[CCode (cname = "gdk_pixbuf_new_from_stream_at_scale_async", finish_name = "gdk_pixbuf_new_from_stream_finish")]
		public static async Gdk.Pixbuf new_from_stream_at_scale_async (GLib.InputStream stream, int width, int height, bool preserve_aspect_ratio, GLib.Cancellable? cancellable = null) throws GLib.Error;
		[CCode (cname = "gdk_pixbuf_new_from_stream_at_scale_async", finish_name = "gdk_pixbuf_new_from_stream_finish")]
		public async Pixbuf.from_stream_at_scale_async (GLib.InputStream stream, int width, int height, bool preserve_aspect_ratio, GLib.Cancellable? cancellable = null) throws GLib.Error;
		[CCode (has_construct_function = false)]
		public Pixbuf.subpixbuf (Gdk.Pixbuf src_pixbuf, int src_x, int src_y, int width, int height);
		public bool save (string filename, string type, ...) throws GLib.Error;
		public bool save_to_buffer ([CCode (array_length_type = "gsize", type = "gchar**")] out uint8[] buffer, string type, ...) throws GLib.Error;
		public bool save_to_callback (Gdk.PixbufSaveFunc save_func, string type, ...) throws GLib.Error;
		public bool save_to_stream (GLib.OutputStream stream, string type, GLib.Cancellable? cancellable = null) throws GLib.Error;
		[CCode (finish_name = "gdk_pixbuf_save_to_stream_finish")]
		public async bool save_to_stream_async (GLib.OutputStream stream, string type, GLib.Cancellable? cancellable = null) throws GLib.Error;
	}

	[CCode (cheader_filename = "gdk-pixbuf/gdk-pixdata.h", instance_pos = -0.9)]
	public delegate bool PixbufSaveFunc ([CCode (array_length_type = "gsize")] uint8[] buf) throws GLib.Error;
}
