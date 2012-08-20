namespace Gst {
	namespace Check {
		[CCode (cheader_filename = "gst/check/gstbufferstraw.h,gst/check/gstcheck.h,gst/check/gstconsistencychecker.h,gst/check/internal-check.h", cname = "GstStreamConsistency", lower_case_cprefix = "gst_consistency_checker_")]
		[Compact]
		public class StreamConsistency {
			public StreamConsistency (Gst.Pad pad);
			public bool add_pad (Gst.Pad pad);
			public void free ();
			public void reset ();
		}
	}
}
