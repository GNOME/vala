namespace Gst {
	namespace Base {
		public class Adapter : GLib.Object {
			[CCode (array_length = false)]
			public unowned uint8[]? map (size_t size);
			[CCode (array_length = false)]
			public uint8[]? take (size_t nbytes);
		}
		// Keep backwards compat with < 1.13/1.14
		[CCode (cheader_filename = "gst/base/base.h", cname = "GstFlowCombiner", copy_function = "g_boxed_copy", free_function = "g_boxed_free", lower_case_cprefix = "gst_flow_combiner_", type_id = "gst_flow_combiner_get_type ()")]
		[Compact]
		public class FlowCombiner {
		}
	}
}
