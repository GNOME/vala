namespace Gst {
	[Compact, CCode (copy_function = "gst_allocation_params_copy", free_function = "gst_allocation_params_free", type_id = "gst_allocation_params_get_type ()")]
	public class AllocationParams {
	}

	[CCode (type_id = "gst_bin_get_type ()")]
	public class Bin : Gst.Element {
		public void add_many (params Gst.Element[] elements);
		public void remove_many (params Gst.Element[] elements);
  }

	[Compact, CCode (ref_function = "gst_buffer_ref", type_id = "gst_buffer_get_type ()", unref_function = "gst_buffer_unref")]
	public class Buffer {
		[CCode (has_construct_function = false, simple_generics = true)]
		public static Buffer new_wrapped_full<T> (Gst.MemoryFlags flags, [CCode (array_length_cname = "size", array_length_pos = 4.5, array_length_type = "gsize")] uint8[] data, size_t maxsize, size_t offset, owned T user_data);
	}

	[Compact, CCode (ref_function = "gst_buffer_list_ref", type_id = "gst_buffer_list_get_type ()", unref_function = "gst_buffer_list_unref")]
	public class BufferList {
	}

	[Compact, CCode (ref_function = "gst_caps_ref", type_id = "gst_caps_get_type ()", unref_function = "gst_caps_unref")]
	public class Caps {
		[CCode (has_construct_function = false)]
		public Caps.full (params Gst.Structure[] structure);
	}

	[Compact, CCode (copy_function = "g_boxed_copy", free_function = "g_boxed_free", type_id = "gst_caps_features_get_type ()")]
	public class CapsFeatures {
		[CCode (has_construct_function = false)]
		public CapsFeatures.id (params GLib.Quark[] features);
	}

	[CCode (type_id = "gst_control_binding_get_type ()")]
	public abstract class ControlBinding : Gst.Object {
		public virtual bool get_value_array<T> (Gst.ClockTime timestamp, Gst.ClockTime interval, [CCode (array_length_pos = 2.5, array_length_type = "guint")] T[] values);
	}

	[Compact, CCode (ref_function = "gst_date_time_ref", type_id = "gst_date_time_get_type ()", unref_function = "gst_date_time_unref")]
	public class DateTime {
	}

	[CCode (type_id = "gst_element_get_type ()")]
	public abstract class Element : Gst.Object {
		public bool link_many (params Gst.Element[] elements);
		public void unlink_many (params Gst.Element[] elements);
  }

	[Compact, CCode (ref_function = "gst_event_ref", type_id = "gst_event_get_type ()", unref_function = "gst_event_unref")]
	public class Event {
	}

	[Compact, CCode (copy_function = "gst_iterator_copy", free_function = "gst_iterator_free", type_id = "gst_iterator_get_type ()")]
	public class Iterator {
		[CCode (simple_generics = true)]
		public Gst.Iterator filter<T> ([CCode (type = "GCompareFunc")] GLib.SearchFunc<GLib.Value,T> func, T user_data);
		[CCode (simple_generics = true)]
		public bool find_custom<T> ([CCode (type = "GCompareFunc")] GLib.SearchFunc<GLib.Value,T> func, out GLib.Value elem, T user_data);
	}

	[Compact, CCode (ref_function = "gst_mini_object_ref", unref_function = "gst_mini_object_unref")]
	public abstract class MiniObject {
		[CCode (simple_generics = true)]
		public T get_qdata<T> (GLib.Quark quark);
		[CCode (simple_generics = true)]
		public void set_qdata<T> (GLib.Quark quark, owned T data);
	}

	[Compact, CCode (ref_function = "gst_memory_ref", type_id = "gst_memory_get_type ()", unref_function = "gst_memory_unref")]
	public class Memory {
	}

	[Compact, CCode (ref_function = "gst_message_ref", type_id = "gst_message_get_type ()", unref_function = "gst_message_unref")]
	public class Message {
	}

	[Compact, CCode (free_function = "gst_parse_context_free", type_id = "gst_parse_context_get_type ()")]
	public class ParseContext {
	}

	[Compact, CCode (ref_function = "gst_query_ref", type_id = "gst_query_get_type ()", unref_function = "gst_query_unref")]
	public class Query {
    [CCode (sentinel = "")]
    public void set_formats (int n_formats, params Gst.Format[] formats);
	}

	[Compact, CCode (ref_function = "gst_sample_ref", type_id = "gst_sample_get_type ()", unref_function = "gst_sample_unref")]
	public class Sample {
	}

	[Compact, CCode (copy_function = "gst_segment_copy", free_function = "gst_segment_free", type_id = "gst_segment_get_type ()")]
	public class Segment {
	}

	[Compact, CCode (copy_function = "gst_structure_copy", free_function = "gst_structure_free", type_id = "gst_structure_get_type ()")]
	public class Structure {
		public void remove_fields (params string[] field_names);
	}

	[Compact, CCode (ref_function = "gst_tag_list_ref", type_id = "gst_tag_list_get_type ()", unref_function = "gst_tag_list_unref")]
	public class TagList {
	}

	[Compact, CCode (ref_function = "gst_toc_ref", type_id = "gst_toc_get_type ()", unref_function = "gst_toc_unref")]
	public class Toc {
	}

	[Compact, CCode (ref_function = "gst_toc_entry_ref", type_id = "gst_toc_entry_get_type ()", unref_function = "gst_toc_entry_unref")]
	public class TocEntry {
	}

	[Compact, CCode (ref_function = "gst_atomic_queue_ref", type_id = "gst_atomic_queue_get_type ()", unref_function = "gst_atomic_queue_unref")]
	public class AtomicQueue<T> {
		public unowned T? peek<T> ();
		public T pop ();
		public void push (owned T data);
	}
}
