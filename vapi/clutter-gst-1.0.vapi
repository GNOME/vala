[CCode (cprefix = "ClutterGst", lower_case_cprefix = "clutter_gst_", cheader_filename = "clutter-gst/clutter-gst.h")]
namespace ClutterGst {
	[CCode (lower_case_cprefix = "")]
	namespace Version {
		[CCode (cname = "CLUTTER_GST_MAJOR_VERSION")]
		public const int MAJOR;
		[CCode (cname = "CLUTTER_GST_MINOR_VERSION")]
		public const int MINOR;
		[CCode (cname = "CLUTTER_GST_MICRO_VERSION")]
		public const int MICRO;
		[CCode (cname = "CLUTTER_GST_VERSION_HEX")]
		public const int HEX;
		[CCode (cname = "CLUTTER_GST_VERSION_S")]
		public const string STRING;
		[CCode (cname = "CLUTTER_GST_CHECK_VERSION")]
		public bool check(int major, int minor, int micro);
	}
	public class VideoSink : Gst.BaseSink {
		[CCode (type = "GstElement*", has_construct_function = false)]
		public VideoSink (Clutter.Texture texture);
		[NoAccessorMethod]
		public Clutter.Texture texture { get; set; }
		[NoAccessorMethod]
		public int update_priority { get; set; }
	}
	public class VideoTexture : Clutter.Texture, Clutter.Media {
		[CCode (type = "ClutterActor*", has_construct_function = false)]
		public VideoTexture ();
		[CCode (type = "GstElement*")]
		public unowned Gst.Pipeline get_pipeline ();
		public string user_agent { owned get; set; }
		public Cogl.Handle idle_material { get; set; }
	}
	public static Clutter.InitError init ([CCode (array_length_pos = 0.9)] ref unowned string[] argv);
	public static Clutter.InitError init_with_args ([CCode (array_length_pos = 0.9)] ref unowned string[] argv, string parameter_string, [CCode (array_length = false)] GLib.OptionEntry[] entries, string translation_domain) throws GLib.OptionError;
}
