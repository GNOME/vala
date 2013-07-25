namespace Gst {
	namespace Video {
		[CCode (cheader_filename = "gst/video/gstvideoutils.h", ref_function = "gst_video_codec_frame_ref", type_id = "gst_video_codec_frame_get_type ()", unref_function = "gst_video_codec_frame_unref")]
		[Compact]
		[GIR (name = "VideoCodecFrame")]
		public class CodecFrame {
			[CCode (simple_generics = true)]
			public T get_user_data<T> ();
			[CCode (simple_generics = true)]
			public void set_user_data<T> (owned T user_data);
		}

		[CCode (cheader_filename = "gst/video/video-overlay-composition.h", ref_function = "gst_video_overlay_composition_ref", type_id = "gst_video_overlay_composition_get_type ()", unref_function = "gst_video_overlay_composition_unref")]
		[Compact]
		[GIR (name = "VideoOverlayComposition")]
		public class OverlayComposition {
		}

		[CCode (cheader_filename = "gst/video/video-overlay-composition.h", ref_function = "gst_video_overlay_rectangle_ref", type_id = "gst_video_overlay_rectangle_get_type ()", unref_function = "gst_video_overlay_rectangle_unref")]
		[Compact]
		[GIR (name = "VideoOverlayRectangle")]
		public class OverlayRectangle {
		}
	}
}
