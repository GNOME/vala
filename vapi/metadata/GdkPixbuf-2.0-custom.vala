namespace Gdk {
	public class Pixbuf : GLib.Object {
		[CCode (has_construct_function = false, cname = "gdk_pixbuf_new_from_data")]
		public Pixbuf.with_unowned_data ([CCode (array_length = false)] uint8[] data, Gdk.Colorspace colorspace, bool has_alpha, int bits_per_sample, int width, int height, int rowstride, [CCode (type = "GdkPixbufDestroyNotify")] Gdk.PixbufDestroyNotify? destroy_fn = null);
		[Version (deprecated_since = "vala-0.18", replacement = "Pixbuf.from_stream_async")]
		[CCode (cname = "gdk_pixbuf_new_from_stream_async", finish_name = "gdk_pixbuf_new_from_stream_finish")]
		public static async Gdk.Pixbuf new_from_stream_async (GLib.InputStream stream, GLib.Cancellable? cancellable = null) throws GLib.Error;
		[Version (deprecated_since = "vala-0.18", replacement = "Pixbuf.from_stream_at_scale_async")]
		[CCode (cname = "gdk_pixbuf_new_from_stream_at_scale_async", finish_name = "gdk_pixbuf_new_from_stream_finish")]
		public static async Gdk.Pixbuf new_from_stream_at_scale_async (GLib.InputStream stream, int width, int height, bool preserve_aspect_ratio, GLib.Cancellable? cancellable = null) throws GLib.Error;
	}

	[CCode (cheader_filename = "gdk-pixbuf/gdk-pixdata.h", instance_pos = -0.9)]
	public delegate bool PixbufSaveFunc ([CCode (array_length_type = "gsize")] uint8[] buf) throws GLib.Error;
}
