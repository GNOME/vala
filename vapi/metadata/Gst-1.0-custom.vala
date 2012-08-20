namespace Gst {
	[CCode (cheader_filename = "gst/gst.h", copy_function = "g_boxed_copy", free_function = "g_boxed_free", type_id = "gst_buffer_get_type ()")]
	[Compact]
	public class Buffer {
		[CCode (has_construct_function = false, simple_generics = true)]
		public static Buffer new_wrapped_full<T> (Gst.MemoryFlags flags, [CCode (array_length_cname = "size", array_length_pos = 4.5, array_length_type = "gsize")] uint8[] data, size_t maxsize, size_t offset, owned T user_data);
	}


	[CCode (cheader_filename = "gst/gst.h", ref_function = "gst_mini_object_ref", unref_function = "gst_mini_object_unref")]
	[Compact]
	public abstract class MiniObject {
		[CCode (simple_generics = true)]
		public T get_qdata<T> (GLib.Quark quark);
		[CCode (simple_generics = true)]
		public void set_qdata<T> (GLib.Quark quark, owned T data);
	}

	[CCode (cheader_filename = "gst/gst.h", copy_function = "g_boxed_copy", free_function = "g_boxed_free", type_id = "gst_atomic_queue_get_type ()")]
	[Compact]
	public class AtomicQueue<T> {
		public unowned T? peek<T> ();
		public T pop ();
		public void push (owned T data);
	}

	[CCode (cheader_filename = "gst/gst.h", cprefix = "GST_FLOW_")]
	public enum FlowReturn {
		CUSTOM_ERROR_2;
		[CCode (cname = "gst_flow_get_name")]
		public unowned string get_name ();
	}
}