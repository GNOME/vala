namespace Gnome {
	[CCode (cheader_filename = "libgnome-desktop/gnome-bg-slide-show.h", type_id = "gnome_bg_slide_show_get_type ()")]
	public class BGSlideShow : GLib.Object {
		public void load_async (GLib.Cancellable? cancellable, GLib.AsyncReadyCallback callback);

		[NoAccessorMethod]
		[Version (deprecated = true, deprecated_since = "3.34")]
		public string filename { owned get; construct; }
	}
}
