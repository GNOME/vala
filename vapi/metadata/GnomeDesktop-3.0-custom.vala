namespace Gnome {
	[CCode (cheader_filename = "libgnome-desktop/gnome-bg.h", type_id = "gnome_bg_get_type ()")]
	public class BG : GLib.Object {
		//FIXME public Cairo.Surface create_surface (Gdk.Window window, int width, int height, bool root);
		//FIXME public void draw (Gdk.Pixbuf dest, Gdk.Screen screen, bool is_root);
		[Version (deprecated = true, deprecated_since = "3.36")]
		public static Cairo.Surface get_surface_from_root (Gdk.Screen screen);
		[Version (deprecated = true, deprecated_since = "3.36")]
		public static void set_surface_as_root (Gdk.Screen screen, Cairo.Surface surface);
		[Version (deprecated = true, deprecated_since = "3.36")]
		public static Gnome.BGCrossfade set_surface_as_root_with_crossfade (Gdk.Screen screen, Cairo.Surface surface);
	}

	[CCode (cheader_filename = "libgnome-desktop/gnome-bg-slide-show.h", type_id = "gnome_bg_slide_show_get_type ()")]
	public class BGSlideShow : GLib.Object {
		public void load_async (GLib.Cancellable? cancellable, GLib.AsyncReadyCallback callback);

		[NoAccessorMethod]
		[Version (deprecated = true, deprecated_since = "3.34")]
		public string filename { owned get; construct; }
	}
	[CCode (cheader_filename = "libgnome-desktop/gnome-idle-monitor.h", type_id = "gnome_idle_monitor_get_type ()")]
	public class IdleMonitor : GLib.Object {
		[CCode (has_construct_function = false)]
		[Version (deprecated = true, deprecated_since = "3.36")]
		public IdleMonitor.for_device (Gdk.Device device) throws GLib.Error;
		[NoAccessorMethod]
		[Version (deprecated = true, deprecated_since = "3.36")]
		public Gdk.Device device { owned get; construct; }
	}
}
