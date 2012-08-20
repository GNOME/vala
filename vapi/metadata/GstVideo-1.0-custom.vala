namespace Gst {
	namespace Video {
		[CCode (cheader_filename = "gst/video/gstvideoutils.h", copy_function = "g_boxed_copy", free_function = "g_boxed_free", type_id = "gst_video_codec_frame_get_type ()")]
		[Compact]
		[GIR (name = "VideoCodecFrame")]
		public class CodecFrame {
			[CCode (simple_generics = true)]
			public T get_user_data<T> ();
			[CCode (simple_generics = true)]
			public void set_user_data<T> (owned T user_data);
		}
	}
}
