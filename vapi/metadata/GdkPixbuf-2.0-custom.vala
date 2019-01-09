namespace Gdk {
	public class Pixbuf : GLib.Object {
		[CCode (has_construct_function = false, cname = "gdk_pixbuf_new_from_data")]
		public Pixbuf.with_unowned_data ([CCode (array_length = false)] uint8[] data, Gdk.Colorspace colorspace, bool has_alpha, int bits_per_sample, int width, int height, int rowstride, [CCode (type = "GdkPixbufDestroyNotify")] Gdk.PixbufDestroyNotify? destroy_fn = null);
		[CCode (has_construct_function = false)]
		[Version (deprecated = true, deprecated_since = "2.32")]
		public Pixbuf.from_inline ([CCode (array_length_cname = "data_length", array_length_pos = 0.5)] uint8[] data, bool copy_pixels = true) throws GLib.Error;
		[CCode (cheader_filename = "gdk-pixbuf/gdk-pixdata.h")]
		[Version (deprecated = true, deprecated_since = "2.32")]
		public static Gdk.Pixbuf from_pixdata (Gdk.Pixdata pixdata, bool copy_pixels = true) throws GLib.Error;
	}
}
