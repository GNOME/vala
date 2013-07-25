namespace Gst {
	[CCode (cheader_filename = "gst/gst.h", copy_function = "gst_allocation_params_copy", free_function = "gst_allocation_params_free", type_id = "gst_allocation_params_get_type ()")]
	[Compact]
	public class AllocationParams {
	}

	[CCode (cheader_filename = "gst/gst.h", ref_function = "gst_buffer_ref", type_id = "gst_buffer_get_type ()", unref_function = "gst_buffer_unref")]
	[Compact]
	public class Buffer {
		[CCode (has_construct_function = false, simple_generics = true)]
		public static Buffer new_wrapped_full<T> (Gst.MemoryFlags flags, [CCode (array_length_cname = "size", array_length_pos = 4.5, array_length_type = "gsize")] uint8[] data, size_t maxsize, size_t offset, owned T user_data);
	}

	[CCode (cheader_filename = "gst/gst.h", ref_function = "gst_buffer_list_ref", type_id = "gst_buffer_list_get_type ()", unref_function = "gst_buffer_list_unref")]
	[Compact]
	public class BufferList {
	}

	[CCode (cheader_filename = "gst/gst.h", ref_function = "gst_caps_ref", type_id = "gst_caps_get_type ()", unref_function = "gst_caps_unref")]
	[Compact]
	public class Caps {
	}

	[CCode (cheader_filename = "gst/gst.h", ref_function = "gst_date_time_ref", type_id = "gst_date_time_get_type ()", unref_function = "gst_date_time_unref")]
	[Compact]
	public class DateTime {
	}

	[CCode (cheader_filename = "gst/gst.h", ref_function = "gst_event_ref", type_id = "gst_event_get_type ()", unref_function = "gst_event_unref")]
	[Compact]
	public class Event {
	}

	[CCode (cheader_filename = "gst/gst.h", copy_function = "gst_iterator_copy", free_function = "gst_iterator_free", type_id = "gst_iterator_get_type ()")]
	[Compact]
	public class Iterator {
	}

	[CCode (cheader_filename = "gst/gst.h", ref_function = "gst_mini_object_ref", unref_function = "gst_mini_object_unref")]
	[Compact]
	public abstract class MiniObject {
		[CCode (simple_generics = true)]
		public T get_qdata<T> (GLib.Quark quark);
		[CCode (simple_generics = true)]
		public void set_qdata<T> (GLib.Quark quark, owned T data);
	}

	[CCode (cheader_filename = "gst/gst.h", ref_function = "gst_memory_ref", type_id = "gst_memory_get_type ()", unref_function = "gst_memory_unref")]
	[Compact]
	public class Memory {
	}

	[CCode (cheader_filename = "gst/gst.h", ref_function = "gst_message_ref", type_id = "gst_message_get_type ()", unref_function = "gst_message_unref")]
	[Compact]
	public class Message {
	}

	[CCode (cheader_filename = "gst/gst.h", free_function = "gst_parse_context_free", type_id = "gst_parse_context_get_type ()")]
	[Compact]
	public class ParseContext {
	}

	[CCode (cheader_filename = "gst/gst.h", ref_function = "gst_query_ref", type_id = "gst_query_get_type ()", unref_function = "gst_query_unref")]
	[Compact]
	public class Query {
	}

	[CCode (cheader_filename = "gst/gst.h", ref_function = "gst_sample_ref", type_id = "gst_sample_get_type ()", unref_function = "gst_sample_unref")]
	[Compact]
	public class Sample {
	}

	[CCode (cheader_filename = "gst/gst.h", copy_function = "gst_segment_copy", free_function = "gst_segment_free", type_id = "gst_segment_get_type ()")]
	[Compact]
	public class Segment {
	}

	[CCode (cheader_filename = "gst/gst.h", copy_function = "gst_structure_copy", free_function = "gst_structure_free", type_id = "gst_structure_get_type ()")]
	[Compact]
	public class Structure {
	}

	[CCode (cheader_filename = "gst/gst.h", ref_function = "gst_tag_list_ref", type_id = "gst_tag_list_get_type ()", unref_function = "gst_tag_list_unref")]
	[Compact]
	public class TagList {
	}

	[CCode (cheader_filename = "gst/gst.h", ref_function = "gst_toc_ref", type_id = "gst_toc_get_type ()", unref_function = "gst_toc_unref")]
	[Compact]
	public class Toc {
	}

	[CCode (cheader_filename = "gst/gst.h", ref_function = "gst_toc_entry_ref", type_id = "gst_toc_entry_get_type ()", unref_function = "gst_toc_entry_unref")]
	[Compact]
	public class TocEntry {
	}

	[CCode (cheader_filename = "gst/gst.h", ref_function = "gst_atomic_queue_ref", type_id = "gst_atomic_queue_get_type ()", unref_function = "gst_atomic_queue_unref")]
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
