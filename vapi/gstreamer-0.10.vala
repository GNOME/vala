[CCode (cprefix = "Gst", lower_case_cprefix = "gst_")]
namespace Gst {
	[CCode (cprefix = "GST_ACTIVATE_", cheader_filename = "gst/gst.h")]
	public enum ActivateMode {
		NONE,
		PUSH,
		PULL,
	}
	[CCode (cprefix = "GST_ALLOC_TRACE_", cheader_filename = "gst/gst.h")]
	public enum AllocTraceFlags {
		LIVE,
		MEM_LIVE,
	}
	[CCode (cprefix = "GST_ASSOCIATION_FLAG_", cheader_filename = "gst/gst.h")]
	public enum AssocFlags {
		NONE,
		KEY_UNIT,
		DELTA_UNIT,
		LAST,
	}
	[CCode (cprefix = "GST_BIN_FLAG_", cheader_filename = "gst/gst.h")]
	public enum BinFlags {
		LAST,
	}
	[CCode (cprefix = "GST_BUFFER_COPY_", cheader_filename = "gst/gst.h")]
	public enum BufferCopyFlags {
		FLAGS,
		TIMESTAMPS,
		CAPS,
	}
	[CCode (cprefix = "GST_BUFFER_FLAG_", cheader_filename = "gst/gst.h")]
	public enum BufferFlag {
		READONLY,
		PREROLL,
		DISCONT,
		IN_CAPS,
		GAP,
		DELTA_UNIT,
		LAST,
	}
	[CCode (cprefix = "GST_BUS_", cheader_filename = "gst/gst.h")]
	public enum BusFlags {
		FLUSHING,
		FLAG_LAST,
	}
	[CCode (cprefix = "GST_BUS_", cheader_filename = "gst/gst.h")]
	public enum BusSyncReply {
		DROP,
		PASS,
		ASYNC,
	}
	[CCode (cprefix = "GST_CAPS_FLAGS_", cheader_filename = "gst/gst.h")]
	public enum CapsFlags {
		ANY,
	}
	[CCode (cprefix = "GST_CLOCK_ENTRY_", cheader_filename = "gst/gst.h")]
	public enum ClockEntryType {
		SINGLE,
		PERIODIC,
	}
	[CCode (cprefix = "GST_CLOCK_FLAG_", cheader_filename = "gst/gst.h")]
	public enum ClockFlags {
		CAN_DO_SINGLE_SYNC,
		CAN_DO_SINGLE_ASYNC,
		CAN_DO_PERIODIC_SYNC,
		CAN_DO_PERIODIC_ASYNC,
		CAN_SET_RESOLUTION,
		CAN_SET_MASTER,
		LAST,
	}
	[CCode (cprefix = "GST_CLOCK_", cheader_filename = "gst/gst.h")]
	public enum ClockReturn {
		OK,
		EARLY,
		UNSCHEDULED,
		BUSY,
		BADTIME,
		ERROR,
		UNSUPPORTED,
	}
	[CCode (cprefix = "GST_CORE_ERROR_", cheader_filename = "gst/gst.h")]
	public enum CoreError {
		FAILED,
		TOO_LAZY,
		NOT_IMPLEMENTED,
		STATE_CHANGE,
		PAD,
		THREAD,
		NEGOTIATION,
		EVENT,
		SEEK,
		CAPS,
		TAG,
		MISSING_PLUGIN,
		CLOCK,
		DISABLED,
		NUM_ERRORS,
	}
	[CCode (cprefix = "GST_DEBUG_", cheader_filename = "gst/gst.h")]
	public enum DebugColorFlags {
		FG_BLACK,
		FG_RED,
		FG_GREEN,
		FG_YELLOW,
		FG_BLUE,
		FG_MAGENTA,
		FG_CYAN,
		FG_WHITE,
		BG_BLACK,
		BG_RED,
		BG_GREEN,
		BG_YELLOW,
		BG_BLUE,
		BG_MAGENTA,
		BG_CYAN,
		BG_WHITE,
		BOLD,
		UNDERLINE,
	}
	[CCode (cprefix = "GST_LEVEL_", cheader_filename = "gst/gst.h")]
	public enum DebugLevel {
		NONE,
		ERROR,
		WARNING,
		INFO,
		DEBUG,
		LOG,
		COUNT,
	}
	[CCode (cprefix = "GST_ELEMENT_", cheader_filename = "gst/gst.h")]
	public enum ElementFlags {
		LOCKED_STATE,
		IS_SINK,
		UNPARENTING,
		FLAG_LAST,
	}
	[CCode (cprefix = "GST_EVENT_", cheader_filename = "gst/gst.h")]
	public enum EventType {
		UNKNOWN,
		FLUSH_START,
		FLUSH_STOP,
		EOS,
		NEWSEGMENT,
		TAG,
		BUFFERSIZE,
		QOS,
		SEEK,
		NAVIGATION,
		LATENCY,
		CUSTOM_UPSTREAM,
		CUSTOM_DOWNSTREAM,
		CUSTOM_DOWNSTREAM_OOB,
		CUSTOM_BOTH,
		CUSTOM_BOTH_OOB,
	}
	[CCode (cprefix = "GST_EVENT_TYPE_", cheader_filename = "gst/gst.h")]
	public enum EventTypeFlags {
		UPSTREAM,
		DOWNSTREAM,
		SERIALIZED,
	}
	[CCode (cprefix = "GST_FLOW_", cheader_filename = "gst/gst.h")]
	public enum FlowReturn {
		CUSTOM_SUCCESS,
		RESEND,
		OK,
		NOT_LINKED,
		WRONG_STATE,
		UNEXPECTED,
		NOT_NEGOTIATED,
		ERROR,
		NOT_SUPPORTED,
		CUSTOM_ERROR,
	}
	[CCode (cprefix = "GST_FORMAT_", cheader_filename = "gst/gst.h")]
	public enum Format {
		UNDEFINED,
		DEFAULT,
		BYTES,
		TIME,
		BUFFERS,
		PERCENT,
	}
	[CCode (cprefix = "GST_INDEX_", cheader_filename = "gst/gst.h")]
	public enum IndexCertainty {
		UNKNOWN,
		CERTAIN,
		FUZZY,
	}
	[CCode (cprefix = "GST_INDEX_ENTRY_", cheader_filename = "gst/gst.h")]
	public enum IndexEntryType {
		ID,
		ASSOCIATION,
		OBJECT,
		FORMAT,
	}
	[CCode (cprefix = "GST_INDEX_", cheader_filename = "gst/gst.h")]
	public enum IndexFlags {
		WRITABLE,
		READABLE,
		FLAG_LAST,
	}
	[CCode (cprefix = "GST_INDEX_LOOKUP_", cheader_filename = "gst/gst.h")]
	public enum IndexLookupMethod {
		EXACT,
		BEFORE,
		AFTER,
	}
	[CCode (cprefix = "GST_INDEX_RESOLVER_", cheader_filename = "gst/gst.h")]
	public enum IndexResolverMethod {
		CUSTOM,
		GTYPE,
		PATH,
	}
	[CCode (cprefix = "GST_ITERATOR_ITEM_", cheader_filename = "gst/gst.h")]
	public enum IteratorItem {
		SKIP,
		PASS,
		END,
	}
	[CCode (cprefix = "GST_ITERATOR_", cheader_filename = "gst/gst.h")]
	public enum IteratorResult {
		DONE,
		OK,
		RESYNC,
		ERROR,
	}
	[CCode (cprefix = "GST_LIBRARY_ERROR_", cheader_filename = "gst/gst.h")]
	public enum LibraryError {
		FAILED,
		TOO_LAZY,
		INIT,
		SHUTDOWN,
		SETTINGS,
		ENCODE,
		NUM_ERRORS,
	}
	[CCode (cprefix = "GST_MESSAGE_", cheader_filename = "gst/gst.h")]
	public enum MessageType {
		UNKNOWN,
		EOS,
		ERROR,
		WARNING,
		INFO,
		TAG,
		BUFFERING,
		STATE_CHANGED,
		STATE_DIRTY,
		STEP_DONE,
		CLOCK_PROVIDE,
		CLOCK_LOST,
		NEW_CLOCK,
		STRUCTURE_CHANGE,
		STREAM_STATUS,
		APPLICATION,
		ELEMENT,
		SEGMENT_START,
		SEGMENT_DONE,
		DURATION,
		LATENCY,
		ASYNC_START,
		ASYNC_DONE,
		ANY,
	}
	[CCode (cprefix = "GST_MINI_OBJECT_FLAG_", cheader_filename = "gst/gst.h")]
	public enum MiniObjectFlags {
		READONLY,
		LAST,
	}
	[CCode (cprefix = "GST_OBJECT_", cheader_filename = "gst/gst.h")]
	public enum ObjectFlags {
		DISPOSING,
		FLOATING,
		FLAG_LAST,
	}
	[CCode (cprefix = "GST_PAD_", cheader_filename = "gst/gst.h")]
	public enum PadDirection {
		UNKNOWN,
		SRC,
		SINK,
	}
	[CCode (cprefix = "GST_PAD_", cheader_filename = "gst/gst.h")]
	public enum PadFlags {
		BLOCKED,
		FLUSHING,
		IN_GETCAPS,
		IN_SETCAPS,
		BLOCKING,
		FLAG_LAST,
	}
	[CCode (cprefix = "GST_PAD_LINK_", cheader_filename = "gst/gst.h")]
	public enum PadLinkReturn {
		OK,
		WRONG_HIERARCHY,
		WAS_LINKED,
		WRONG_DIRECTION,
		NOFORMAT,
		NOSCHED,
		REFUSED,
	}
	[CCode (cprefix = "GST_PAD_", cheader_filename = "gst/gst.h")]
	public enum PadPresence {
		ALWAYS,
		SOMETIMES,
		REQUEST,
	}
	[CCode (cprefix = "GST_PAD_TEMPLATE_", cheader_filename = "gst/gst.h")]
	public enum PadTemplateFlags {
		FIXED,
		FLAG_LAST,
	}
	[CCode (cprefix = "GST_PARSE_ERROR_", cheader_filename = "gst/gst.h")]
	public enum ParseError {
		SYNTAX,
		NO_SUCH_ELEMENT,
		NO_SUCH_PROPERTY,
		LINK,
		COULD_NOT_SET_PROPERTY,
		EMPTY_BIN,
		EMPTY,
	}
	[CCode (cprefix = "GST_PIPELINE_FLAG_", cheader_filename = "gst/gst.h")]
	public enum PipelineFlags {
		FIXED_CLOCK,
		LAST,
	}
	[CCode (cprefix = "GST_PLUGIN_ERROR_", cheader_filename = "gst/gst.h")]
	public enum PluginError {
		MODULE,
		DEPENDENCIES,
		NAME_MISMATCH,
	}
	[CCode (cprefix = "GST_PLUGIN_FLAG_", cheader_filename = "gst/gst.h")]
	public enum PluginFlags {
		CACHED,
	}
	[CCode (cprefix = "GST_QUARK_", cheader_filename = "gst/gst.h")]
	public enum QuarkId {
		FORMAT,
		CURRENT,
		DURATION,
		RATE,
		SEEKABLE,
		SEGMENT_START,
		SEGMENT_END,
		SRC_FORMAT,
		SRC_VALUE,
		DEST_FORMAT,
		DEST_VALUE,
		START_FORMAT,
		START_VALUE,
		STOP_FORMAT,
		STOP_VALUE,
		MAX,
	}
	[CCode (cprefix = "GST_QUERY_", cheader_filename = "gst/gst.h")]
	public enum QueryType {
		NONE,
		POSITION,
		DURATION,
		LATENCY,
		JITTER,
		RATE,
		SEEKING,
		SEGMENT,
		CONVERT,
		FORMATS,
	}
	[CCode (cprefix = "GST_RANK_", cheader_filename = "gst/gst.h")]
	public enum Rank {
		NONE,
		MARGINAL,
		SECONDARY,
		PRIMARY,
	}
	[CCode (cprefix = "GST_RESOURCE_ERROR_", cheader_filename = "gst/gst.h")]
	public enum ResourceError {
		FAILED,
		TOO_LAZY,
		NOT_FOUND,
		BUSY,
		OPEN_READ,
		OPEN_WRITE,
		OPEN_READ_WRITE,
		CLOSE,
		READ,
		WRITE,
		SEEK,
		SYNC,
		SETTINGS,
		NO_SPACE_LEFT,
		NUM_ERRORS,
	}
	[CCode (cprefix = "GST_SEEK_FLAG_", cheader_filename = "gst/gst.h")]
	public enum SeekFlags {
		NONE,
		FLUSH,
		ACCURATE,
		KEY_UNIT,
		SEGMENT,
	}
	[CCode (cprefix = "GST_SEEK_TYPE_", cheader_filename = "gst/gst.h")]
	public enum SeekType {
		NONE,
		CUR,
		SET,
		END,
	}
	[CCode (cprefix = "GST_STATE_", cheader_filename = "gst/gst.h")]
	public enum State {
		VOID_PENDING,
		NULL,
		READY,
		PAUSED,
		PLAYING,
	}
	[CCode (cprefix = "GST_STATE_CHANGE_", cheader_filename = "gst/gst.h")]
	public enum StateChange {
		NULL_TO_READY,
		READY_TO_PAUSED,
		PAUSED_TO_PLAYING,
		PLAYING_TO_PAUSED,
		PAUSED_TO_READY,
		READY_TO_NULL,
	}
	[CCode (cprefix = "GST_STATE_CHANGE_", cheader_filename = "gst/gst.h")]
	public enum StateChangeReturn {
		FAILURE,
		SUCCESS,
		ASYNC,
		NO_PREROLL,
	}
	[CCode (cprefix = "GST_STREAM_ERROR_", cheader_filename = "gst/gst.h")]
	public enum StreamError {
		FAILED,
		TOO_LAZY,
		NOT_IMPLEMENTED,
		TYPE_NOT_FOUND,
		WRONG_TYPE,
		CODEC_NOT_FOUND,
		DECODE,
		ENCODE,
		DEMUX,
		MUX,
		FORMAT,
		NUM_ERRORS,
	}
	[CCode (cprefix = "GST_TAG_FLAG_", cheader_filename = "gst/gst.h")]
	public enum TagFlag {
		UNDEFINED,
		META,
		ENCODED,
		DECODED,
		COUNT,
	}
	[CCode (cprefix = "GST_TAG_MERGE_", cheader_filename = "gst/gst.h")]
	public enum TagMergeMode {
		UNDEFINED,
		REPLACE_ALL,
		REPLACE,
		APPEND,
		PREPEND,
		KEEP,
		KEEP_ALL,
		COUNT,
	}
	[CCode (cprefix = "GST_TASK_", cheader_filename = "gst/gst.h")]
	public enum TaskState {
		STARTED,
		STOPPED,
		PAUSED,
	}
	[CCode (cprefix = "GST_TYPE_FIND_", cheader_filename = "gst/gst.h")]
	public enum TypeFindProbability {
		MINIMUM,
		POSSIBLE,
		LIKELY,
		NEARLY_CERTAIN,
		MAXIMUM,
	}
	[CCode (cprefix = "GST_URI_", cheader_filename = "gst/gst.h")]
	public enum URIType {
		UNKNOWN,
		SINK,
		SRC,
	}
	[CCode (cheader_filename = "gst/gst.h")]
	public class Bin : Gst.Element, Gst.ChildProxy {
		public int numchildren;
		public weak GLib.List children;
		public uint children_cookie;
		public weak Gst.Bus child_bus;
		public weak GLib.List messages;
		public bool polling;
		public bool state_dirty;
		public bool clock_dirty;
		public weak Gst.Clock provided_clock;
		public weak Gst.Element clock_provider;
		public bool add (Gst.Element element);
		public void add_many (Gst.Element element_1);
		public weak Gst.Pad find_unconnected_pad (Gst.PadDirection direction);
		public weak Gst.Element get_by_interface (GLib.Type iface);
		public weak Gst.Element get_by_name (string name);
		public weak Gst.Element get_by_name_recurse_up (string name);
		public static GLib.Type get_type ();
		public weak Gst.Iterator iterate_all_by_interface (GLib.Type iface);
		public weak Gst.Iterator iterate_elements ();
		public weak Gst.Iterator iterate_recurse ();
		public weak Gst.Iterator iterate_sinks ();
		public weak Gst.Iterator iterate_sorted ();
		public weak Gst.Iterator iterate_sources ();
		public Bin (string name);
		public bool remove (Gst.Element element);
		public void remove_many (Gst.Element element_1);
		[NoAccessorMethod]
		public weak bool async_handling { get; set; }
		public signal void element_added (Gst.Element child);
		public signal void element_removed (Gst.Element child);
	}
	[CCode (cheader_filename = "gst/gst.h")]
	public class Buffer : Gst.MiniObject {
		public uchar data;
		public uint size;
		public uint64 timestamp;
		public uint64 duration;
		public weak Gst.Caps caps;
		public uint64 offset;
		public uint64 offset_end;
		public uchar malloc_data;
		public void copy_metadata (Gst.Buffer src, Gst.BufferCopyFlags flags);
		public weak Gst.Buffer create_sub (uint offset, uint size);
		public weak Gst.Caps get_caps ();
		public static GLib.Type get_type ();
		public bool is_metadata_writable ();
		public bool is_span_fast (Gst.Buffer buf2);
		public weak Gst.Buffer join (Gst.Buffer buf2);
		public weak Gst.Buffer make_metadata_writable ();
		public weak Gst.Buffer merge (Gst.Buffer buf2);
		public Buffer ();
		public Buffer.and_alloc (uint size);
		public void set_caps (Gst.Caps caps);
		public weak Gst.Buffer span (uint offset, Gst.Buffer buf2, uint len);
		public static weak Gst.Buffer try_new_and_alloc (uint size);
	}
	[CCode (cheader_filename = "gst/gst.h")]
	public class Bus : Gst.Object {
		public void add_signal_watch ();
		public void add_signal_watch_full (int priority);
		public uint add_watch (Gst.BusFunc func, pointer user_data);
		public uint add_watch_full (int priority, Gst.BusFunc func, pointer user_data, GLib.DestroyNotify notify);
		public bool async_signal_func (Gst.Message message, pointer data);
		public weak GLib.Source create_watch ();
		public void disable_sync_message_emission ();
		public void enable_sync_message_emission ();
		public static GLib.Type get_type ();
		public bool have_pending ();
		public Bus ();
		public weak Gst.Message peek ();
		public weak Gst.Message poll (Gst.MessageType events, int64 timeout);
		public weak Gst.Message pop ();
		public bool post (Gst.Message message);
		public void remove_signal_watch ();
		public void set_flushing (bool flushing);
		public void set_sync_handler (Gst.BusSyncHandler func, pointer data);
		public Gst.BusSyncReply sync_signal_handler (Gst.Message message, pointer data);
		public weak Gst.Message timed_pop (uint64 timeout);
		public signal void sync_message (Gst.Message message);
		public signal void message (Gst.Message message);
	}
	[CCode (cheader_filename = "gst/gst.h")]
	public class Clock : Gst.Object {
		public bool add_observation (uint64 slave, uint64 master, double r_squared);
		public uint64 adjust_unlocked (uint64 internal);
		public void get_calibration (uint64 internal, uint64 external, uint64 rate_num, uint64 rate_denom);
		public virtual uint64 get_internal_time ();
		public weak Gst.Clock get_master ();
		public virtual uint64 get_resolution ();
		public uint64 get_time ();
		public static GLib.Type get_type ();
		public static int id_compare_func (pointer id1, pointer id2);
		public static uint64 id_get_time (pointer id);
		public static pointer id_ref (pointer id);
		public static void id_unref (pointer id);
		public static void id_unschedule (pointer id);
		public static Gst.ClockReturn id_wait (pointer id, int64 jitter);
		public static Gst.ClockReturn id_wait_async (pointer id, Gst.ClockCallback func, pointer user_data);
		public Clock.periodic_id (uint64 start_time, uint64 interval);
		public Clock.single_shot_id (uint64 time);
		public void set_calibration (uint64 internal, uint64 external, uint64 rate_num, uint64 rate_denom);
		public bool set_master (Gst.Clock master);
		public uint64 set_resolution (uint64 resolution);
		public uint64 unadjust_unlocked (uint64 external);
		[NoAccessorMethod]
		public weak bool stats { get; set; }
		[NoAccessorMethod]
		public weak int window_size { get; set; }
		[NoAccessorMethod]
		public weak int window_threshold { get; set; }
		[NoAccessorMethod]
		public weak uint64 timeout { get; set; }
	}
	[CCode (cheader_filename = "gst/gst.h")]
	public class Element : Gst.Object {
		public pointer state_lock;
		public weak GLib.Cond state_cond;
		public uint state_cookie;
		public Gst.State current_state;
		public Gst.State next_state;
		public Gst.State pending_state;
		public Gst.StateChangeReturn last_return;
		public weak Gst.Bus bus;
		public weak Gst.Clock clock;
		public int64 base_time;
		public ushort numpads;
		public weak GLib.List pads;
		public ushort numsrcpads;
		public weak GLib.List srcpads;
		public ushort numsinkpads;
		public weak GLib.List sinkpads;
		public uint pads_cookie;
		public void abort_state ();
		public bool add_pad (Gst.Pad pad);
		public virtual Gst.StateChangeReturn change_state (Gst.StateChange transition);
		public static void class_add_pad_template (pointer klass, Gst.PadTemplate templ);
		public static weak Gst.PadTemplate class_get_pad_template (pointer element_class, string name);
		public static weak GLib.List class_get_pad_template_list (pointer element_class);
		public static void class_install_std_props (pointer klass, ...);
		public static void class_set_details (pointer klass, Gst.ElementDetails details);
		public static void class_set_details_simple (pointer klass, string longname, string classification, string description, string author);
		public Gst.StateChangeReturn continue_state (Gst.StateChangeReturn ret);
		public void create_all_pads ();
		public void found_tags (Gst.TagList list);
		public void found_tags_for_pad (Gst.Pad pad, Gst.TagList list);
		public uint64 get_base_time ();
		public weak Gst.Bus get_bus ();
		public weak Gst.Clock get_clock ();
		public weak Gst.Pad get_compatible_pad (Gst.Pad pad, Gst.Caps caps);
		public weak Gst.PadTemplate get_compatible_pad_template (Gst.PadTemplate compattempl);
		public weak Gst.ElementFactory get_factory ();
		public virtual weak Gst.Index get_index ();
		public weak Gst.Pad get_pad (string name);
		public weak Gst.Pad get_request_pad (string name);
		public virtual Gst.StateChangeReturn get_state (Gst.State state, Gst.State pending, uint64 timeout);
		public weak Gst.Pad get_static_pad (string name);
		public static GLib.Type get_type ();
		public bool implements_interface (GLib.Type iface_type);
		public bool is_indexable ();
		public bool is_locked_state ();
		public weak Gst.Iterator iterate_pads ();
		public weak Gst.Iterator iterate_sink_pads ();
		public weak Gst.Iterator iterate_src_pads ();
		public bool link (Gst.Element dest);
		public bool link_filtered (Gst.Element dest, Gst.Caps filter);
		public bool link_many (Gst.Element element_2);
		public bool link_pads (string srcpadname, Gst.Element dest, string destpadname);
		public bool link_pads_filtered (string srcpadname, Gst.Element dest, string destpadname, Gst.Caps filter);
		public void lost_state ();
		public static weak Gst.Element make_from_uri (Gst.URIType type, string uri, string elementname);
		public void message_full (Gst.MessageType type, GLib.Quark domain, int code, string text, string debug, string file, string function, int line);
		public bool post_message (Gst.Message message);
		public virtual weak Gst.Clock provide_clock ();
		public bool provides_clock ();
		public virtual bool query (Gst.Query query);
		public bool query_convert (Gst.Format src_format, int64 src_val, Gst.Format dest_format, int64 dest_val);
		public bool query_duration (Gst.Format format, int64 duration);
		public bool query_position (Gst.Format format, int64 cur);
		public static bool register (Gst.Plugin plugin, string name, uint rank, GLib.Type type);
		public void release_request_pad (Gst.Pad pad);
		public bool remove_pad (Gst.Pad pad);
		public bool requires_clock ();
		public bool seek (double rate, Gst.Format format, Gst.SeekFlags flags, Gst.SeekType cur_type, int64 cur, Gst.SeekType stop_type, int64 stop);
		public bool seek_simple (Gst.Format format, Gst.SeekFlags seek_flags, int64 seek_pos);
		public virtual bool send_event (Gst.Event event);
		public void set_base_time (uint64 time);
		public virtual void set_bus (Gst.Bus bus);
		public virtual bool set_clock (Gst.Clock clock);
		public virtual void set_index (Gst.Index index);
		public bool set_locked_state (bool locked_state);
		public virtual Gst.StateChangeReturn set_state (Gst.State state);
		public static weak string state_change_return_get_name (Gst.StateChangeReturn state_ret);
		public static weak string state_get_name (Gst.State state);
		public bool sync_state_with_parent ();
		public void unlink (Gst.Element dest);
		public void unlink_many (Gst.Element element_2);
		public void unlink_pads (string srcpadname, Gst.Element dest, string destpadname);
		public signal void pad_removed (Gst.Pad pad);
		[HasEmitter]
		public signal void no_more_pads ();
	}
	[CCode (cheader_filename = "gst/gst.h")]
	public class ElementFactory : Gst.PluginFeature {
		public bool can_sink_caps (Gst.Caps caps);
		public bool can_src_caps (Gst.Caps caps);
		public weak Gst.Element create (string name);
		public static weak Gst.ElementFactory find (string name);
		public weak string get_author ();
		public weak string get_description ();
		public GLib.Type get_element_type ();
		public weak string get_klass ();
		public weak string get_longname ();
		public uint get_num_pad_templates ();
		public weak GLib.List get_static_pad_templates ();
		public static GLib.Type get_type ();
		public weak string get_uri_protocols ();
		public int get_uri_type ();
		public bool has_interface (string interfacename);
		public static weak Gst.Element make (string factoryname, string name);
	}
	[CCode (cheader_filename = "gst/gst.h")]
	public class Event : Gst.MiniObject {
		public Gst.EventType type;
		public uint64 timestamp;
		public weak Gst.Object src;
		public weak Gst.Structure structure;
		public weak Gst.Structure get_structure ();
		public static GLib.Type get_type ();
		public Event.buffer_size (Gst.Format format, int64 minsize, int64 maxsize, bool async);
		public Event.custom (Gst.EventType type, Gst.Structure structure);
		public Event.eos ();
		public Event.flush_start ();
		public Event.flush_stop ();
		public Event.latency (uint64 latency);
		public Event.navigation (Gst.Structure structure);
		public Event.new_segment (bool update, double rate, Gst.Format format, int64 start, int64 stop, int64 position);
		public Event.new_segment_full (bool update, double rate, double applied_rate, Gst.Format format, int64 start, int64 stop, int64 position);
		public Event.qos (double proportion, int64 diff, uint64 timestamp);
		public Event.seek (double rate, Gst.Format format, Gst.SeekFlags flags, Gst.SeekType start_type, int64 start, Gst.SeekType stop_type, int64 stop);
		public Event.tag (Gst.TagList taglist);
		public void parse_buffer_size (Gst.Format format, int64 minsize, int64 maxsize, bool async);
		public void parse_latency (uint64 latency);
		public void parse_new_segment (bool update, double rate, Gst.Format format, int64 start, int64 stop, int64 position);
		public void parse_new_segment_full (bool update, double rate, double applied_rate, Gst.Format format, int64 start, int64 stop, int64 position);
		public void parse_qos (double proportion, int64 diff, uint64 timestamp);
		public void parse_seek (double rate, Gst.Format format, Gst.SeekFlags flags, Gst.SeekType start_type, int64 start, Gst.SeekType stop_type, int64 stop);
		public void parse_tag (Gst.TagList taglist);
		public static Gst.EventTypeFlags type_get_flags (Gst.EventType type);
		public static weak string type_get_name (Gst.EventType type);
		public static GLib.Quark type_to_quark (Gst.EventType type);
	}
	[CCode (cheader_filename = "gst/gst.h")]
	public class Index : Gst.Object {
		public weak Gst.IndexEntry add_association (int id, Gst.AssocFlags flags, Gst.Format format, int64 value);
		public weak Gst.IndexEntry add_associationv (int id, Gst.AssocFlags flags, int n, Gst.IndexAssociation list);
		public weak Gst.IndexEntry add_format (int id, Gst.Format format);
		public weak Gst.IndexEntry add_id (int id, string description);
		public weak Gst.IndexEntry add_object (int id, string key, GLib.Type type, pointer object);
		public virtual void commit (int id);
		public virtual weak Gst.IndexEntry get_assoc_entry (int id, Gst.IndexLookupMethod method, Gst.AssocFlags flags, Gst.Format format, int64 value);
		public weak Gst.IndexEntry get_assoc_entry_full (int id, Gst.IndexLookupMethod method, Gst.AssocFlags flags, Gst.Format format, int64 value, GLib.CompareDataFunc func, pointer user_data);
		public Gst.IndexCertainty get_certainty ();
		public int get_group ();
		public static GLib.Type get_type ();
		public virtual bool get_writer_id (Gst.Object writer, int id);
		public Index ();
		public Index.group ();
		public void set_certainty (Gst.IndexCertainty certainty);
		public void set_filter (Gst.IndexFilter filter, pointer user_data);
		public void set_filter_full (Gst.IndexFilter filter, pointer user_data, GLib.DestroyNotify user_data_destroy);
		public bool set_group (int groupnum);
		public void set_resolver (Gst.IndexResolver resolver, pointer user_data);
		[NoAccessorMethod]
		public weak Gst.IndexResolver resolver { get; set; }
		public signal void entry_added (Gst.IndexEntry entry);
	}
	[CCode (cheader_filename = "gst/gst.h")]
	public class IndexFactory : Gst.PluginFeature {
		public weak Gst.Index create ();
		public void destroy ();
		public static weak Gst.IndexFactory find (string name);
		public static GLib.Type get_type ();
		public static weak Gst.Index make (string name);
		public IndexFactory (string name, string longdesc, GLib.Type type);
	}
	[CCode (cheader_filename = "gst/gst.h")]
	public class Message : Gst.MiniObject {
		public Gst.MessageType type;
		public uint64 timestamp;
		public weak Gst.Object src;
		public weak Gst.Structure structure;
		public weak Gst.Structure get_structure ();
		public static GLib.Type get_type ();
		public Message.application (Gst.Object src, Gst.Structure structure);
		public Message.async_done (Gst.Object src);
		public Message.async_start (Gst.Object src, bool new_base_time);
		public Message.buffering (Gst.Object src, int percent);
		public Message.clock_lost (Gst.Object src, Gst.Clock clock);
		public Message.clock_provide (Gst.Object src, Gst.Clock clock, bool ready);
		public Message.custom (Gst.MessageType type, Gst.Object src, Gst.Structure structure);
		public Message.duration (Gst.Object src, Gst.Format format, int64 duration);
		public Message.element (Gst.Object src, Gst.Structure structure);
		public Message.eos (Gst.Object src);
		public Message.error (Gst.Object src, GLib.Error error, string debug);
		public Message.info (Gst.Object src, GLib.Error error, string debug);
		public Message.latency (Gst.Object src);
		public Message.new_clock (Gst.Object src, Gst.Clock clock);
		public Message.segment_done (Gst.Object src, Gst.Format format, int64 position);
		public Message.segment_start (Gst.Object src, Gst.Format format, int64 position);
		public Message.state_changed (Gst.Object src, Gst.State oldstate, Gst.State newstate, Gst.State pending);
		public Message.state_dirty (Gst.Object src);
		public Message.tag (Gst.Object src, Gst.TagList tag_list);
		public Message.warning (Gst.Object src, GLib.Error error, string debug);
		public void parse_async_start (bool new_base_time);
		public void parse_buffering (int percent);
		public void parse_clock_lost (Gst.Clock clock);
		public void parse_clock_provide (Gst.Clock clock, bool ready);
		public void parse_duration (Gst.Format format, int64 duration);
		public void parse_error (GLib.Error gerror, string debug);
		public void parse_info (GLib.Error gerror, string debug);
		public void parse_new_clock (Gst.Clock clock);
		public void parse_segment_done (Gst.Format format, int64 position);
		public void parse_segment_start (Gst.Format format, int64 position);
		public void parse_state_changed (Gst.State oldstate, Gst.State newstate, Gst.State pending);
		public void parse_tag (Gst.TagList tag_list);
		public void parse_warning (GLib.Error gerror, string debug);
		public static weak string type_get_name (Gst.MessageType type);
		public static GLib.Quark type_to_quark (Gst.MessageType type);
	}
	[CCode (cheader_filename = "gst/gst.h")]
	public class MiniObject : GLib.TypeInstance, GLib.Object {
		public int refcount;
		public uint flags;
		public weak Gst.MiniObject copy ();
		public static GLib.Type get_type ();
		public bool is_writable ();
		public weak Gst.MiniObject make_writable ();
		public MiniObject (GLib.Type type);
		public weak Gst.MiniObject @ref ();
		public void replace (Gst.MiniObject newdata);
		public void unref ();
	}
	[CCode (cheader_filename = "gst/gst.h")]
	public class Object : GLib.Object {
		public int refcount;
		public weak GLib.Mutex @lock;
		public weak string name_prefix;
		public weak Gst.Object parent;
		public uint flags;
		public static bool check_uniqueness (GLib.List list, string name);
		public static void default_deep_notify (GLib.Object object, Gst.Object orig, GLib.ParamSpec pspec, string excluded_props);
		public void default_error (GLib.Error error, string debug);
		public weak string get_name ();
		public weak string get_name_prefix ();
		public weak Gst.Object get_parent ();
		public weak string get_path_string ();
		public static GLib.Type get_type ();
		public bool has_ancestor (Gst.Object ancestor);
		public static pointer @ref (pointer object);
		public void replace (Gst.Object newobj);
		public virtual void restore_thyself (pointer self);
		public virtual pointer save_thyself (pointer parent);
		public bool set_name (string name);
		public void set_name_prefix (string name_prefix);
		public bool set_parent (Gst.Object parent);
		public static void sink (pointer object);
		public void unparent ();
		public static void unref (pointer object);
		public weak string name { get; set construct; }
		public signal void parent_set (Gst.Object parent);
		public signal void parent_unset (Gst.Object parent);
		public signal void object_saved (pointer parent);
		public signal void deep_notify (Gst.Object orig, GLib.ParamSpec pspec);
	}
	[CCode (cheader_filename = "gst/gst.h")]
	public class Pad : Gst.Object {
		public pointer element_private;
		public weak Gst.PadTemplate padtemplate;
		public pointer stream_rec_lock;
		public weak Gst.Task task;
		public weak GLib.Mutex preroll_lock;
		public weak GLib.Cond preroll_cond;
		public weak GLib.Cond block_cond;
		public Gst.PadBlockCallback block_callback;
		public pointer block_data;
		public Gst.PadGetCapsFunction getcapsfunc;
		public Gst.PadSetCapsFunction setcapsfunc;
		public Gst.PadAcceptCapsFunction acceptcapsfunc;
		public Gst.PadFixateCapsFunction fixatecapsfunc;
		public Gst.PadActivateFunction activatefunc;
		public Gst.PadActivateModeFunction activatepushfunc;
		public Gst.PadActivateModeFunction activatepullfunc;
		public Gst.PadLinkFunction linkfunc;
		public Gst.PadUnlinkFunction unlinkfunc;
		public weak Gst.Pad peer;
		public pointer sched_private;
		public Gst.PadChainFunction chainfunc;
		public Gst.PadCheckGetRangeFunction checkgetrangefunc;
		public Gst.PadGetRangeFunction getrangefunc;
		public Gst.PadEventFunction eventfunc;
		public Gst.ActivateMode mode;
		public Gst.PadQueryFunction queryfunc;
		public Gst.PadIntLinkFunction intlinkfunc;
		public Gst.PadBufferAllocFunction bufferallocfunc;
		public int do_buffer_signals;
		public int do_event_signals;
		public bool accept_caps (Gst.Caps caps);
		public bool activate_pull (bool active);
		public bool activate_push (bool active);
		public ulong add_buffer_probe (GLib.Callback handler, pointer data);
		public ulong add_data_probe (GLib.Callback handler, pointer data);
		public ulong add_event_probe (GLib.Callback handler, pointer data);
		public Gst.FlowReturn alloc_buffer (uint64 offset, int size, Gst.Caps caps, Gst.Buffer buf);
		public Gst.FlowReturn alloc_buffer_and_set_caps (uint64 offset, int size, Gst.Caps caps, Gst.Buffer buf);
		public bool can_link (Gst.Pad sinkpad);
		public Gst.FlowReturn chain (Gst.Buffer buffer);
		public bool check_pull_range ();
		public bool dispatcher (Gst.PadDispatcherFunction dispatch, pointer data);
		public bool event_default (Gst.Event event);
		public void fixate_caps (Gst.Caps caps);
		public weak Gst.Caps get_allowed_caps ();
		public weak Gst.Caps get_caps ();
		public Gst.PadDirection get_direction ();
		public pointer get_element_private ();
		public weak Gst.Caps get_fixed_caps_func ();
		public weak GLib.List get_internal_links ();
		public weak GLib.List get_internal_links_default ();
		public weak Gst.Caps get_negotiated_caps ();
		public weak Gst.PadTemplate get_pad_template ();
		public weak Gst.Caps get_pad_template_caps ();
		public weak Gst.Element get_parent_element ();
		public weak Gst.Pad get_peer ();
		public Gst.QueryType get_query_types ();
		public Gst.QueryType get_query_types_default ();
		public Gst.FlowReturn get_range (uint64 offset, uint size, Gst.Buffer buffer);
		public static GLib.Type get_type ();
		public bool is_active ();
		public bool is_blocked ();
		public bool is_blocking ();
		public bool is_linked ();
		public Gst.PadLinkReturn link (Gst.Pad sinkpad);
		public void load_and_link (Gst.Object parent);
		public Pad (string name, Gst.PadDirection direction);
		public Pad.from_static_template (Gst.StaticPadTemplate templ, string name);
		public Pad.from_template (Gst.PadTemplate templ, string name);
		public bool pause_task ();
		public bool peer_accept_caps (Gst.Caps caps);
		public weak Gst.Caps peer_get_caps ();
		public weak Gst.Caps proxy_getcaps ();
		public bool proxy_setcaps (Gst.Caps caps);
		public Gst.FlowReturn pull_range (uint64 offset, uint size, Gst.Buffer buffer);
		public Gst.FlowReturn push (Gst.Buffer buffer);
		public bool push_event (Gst.Event event);
		public bool query (Gst.Query query);
		public bool query_convert (Gst.Format src_format, int64 src_val, Gst.Format dest_format, int64 dest_val);
		public bool query_default (Gst.Query query);
		public bool query_duration (Gst.Format format, int64 duration);
		public bool query_peer_convert (Gst.Format src_format, int64 src_val, Gst.Format dest_format, int64 dest_val);
		public bool query_peer_duration (Gst.Format format, int64 duration);
		public bool query_peer_position (Gst.Format format, int64 cur);
		public bool query_position (Gst.Format format, int64 cur);
		public void remove_buffer_probe (uint handler_id);
		public void remove_data_probe (uint handler_id);
		public void remove_event_probe (uint handler_id);
		public bool send_event (Gst.Event event);
		public void set_acceptcaps_function (Gst.PadAcceptCapsFunction acceptcaps);
		public void set_activate_function (Gst.PadActivateFunction activate);
		public void set_activatepull_function (Gst.PadActivateModeFunction activatepull);
		public void set_activatepush_function (Gst.PadActivateModeFunction activatepush);
		public bool set_active (bool active);
		public bool set_blocked (bool blocked);
		public bool set_blocked_async (bool blocked, Gst.PadBlockCallback callback, pointer user_data);
		public void set_bufferalloc_function (Gst.PadBufferAllocFunction bufalloc);
		public bool set_caps (Gst.Caps caps);
		public void set_chain_function (Gst.PadChainFunction chain);
		public void set_checkgetrange_function (Gst.PadCheckGetRangeFunction check);
		public void set_element_private (pointer priv);
		public void set_event_function (Gst.PadEventFunction event);
		public void set_fixatecaps_function (Gst.PadFixateCapsFunction fixatecaps);
		public void set_getcaps_function (Gst.PadGetCapsFunction getcaps);
		public void set_getrange_function (Gst.PadGetRangeFunction get);
		public void set_internal_link_function (Gst.PadIntLinkFunction intlink);
		public void set_link_function (Gst.PadLinkFunction link);
		public void set_query_function (Gst.PadQueryFunction query);
		public void set_setcaps_function (Gst.PadSetCapsFunction setcaps);
		public void set_unlink_function (Gst.PadUnlinkFunction unlink);
		public bool start_task (Gst.TaskFunction func, pointer data);
		public bool stop_task ();
		public bool unlink (Gst.Pad sinkpad);
		public void use_fixed_caps ();
		public weak Gst.Caps caps { get; }
		[NoAccessorMethod]
		public weak Gst.PadDirection direction { get; construct; }
		[NoAccessorMethod]
		public weak Gst.PadTemplate template { get; set; }
		public signal void linked (Gst.Pad peer);
		public signal void unlinked (Gst.Pad peer);
		public signal void request_link ();
		public signal bool have_data (Gst.MiniObject data);
	}
	[CCode (cheader_filename = "gst/gst.h")]
	public class PadTemplate : Gst.Object {
		public weak Gst.Caps get_caps ();
		public static GLib.Type get_type ();
		public PadTemplate (string name_template, Gst.PadDirection direction, Gst.PadPresence presence, Gst.Caps caps);
		[HasEmitter]
		public signal void pad_created (Gst.Pad pad);
	}
	[CCode (cheader_filename = "gst/gst.h")]
	public class ParamSpecFraction : GLib.ParamSpec, GLib.Object {
		public static GLib.Type get_type ();
	}
	[CCode (cheader_filename = "gst/gst.h")]
	public class Pipeline : Gst.Bin {
		public weak Gst.Clock fixed_clock;
		public uint64 stream_time;
		public void auto_clock ();
		public bool get_auto_flush_bus ();
		public weak Gst.Bus get_bus ();
		public weak Gst.Clock get_clock ();
		public uint64 get_delay ();
		public uint64 get_last_stream_time ();
		public static GLib.Type get_type ();
		public Pipeline (string name);
		public void set_auto_flush_bus (bool auto_flush);
		public bool set_clock (Gst.Clock clock);
		public void set_delay (uint64 delay);
		public void set_new_stream_time (uint64 time);
		public void use_clock (Gst.Clock clock);
		public weak uint64 delay { get; set; }
		public weak bool auto_flush_bus { get; set; }
	}
	[CCode (cheader_filename = "gst/gst.h")]
	public class Plugin : Gst.Object {
		public static GLib.Quark error_quark ();
		public weak string get_description ();
		public weak string get_filename ();
		public weak string get_license ();
		public weak GLib.Module get_module ();
		public weak string get_name ();
		public weak string get_origin ();
		public weak string get_package ();
		public weak string get_source ();
		public static GLib.Type get_type ();
		public weak string get_version ();
		public bool is_loaded ();
		public static void list_free (GLib.List list);
		public weak Gst.Plugin load ();
		public static weak Gst.Plugin load_by_name (string name);
		public static weak Gst.Plugin load_file (string filename, GLib.Error error);
		public bool name_filter (string name);
	}
	[CCode (cheader_filename = "gst/gst.h")]
	public class PluginFeature : Gst.Object {
		public bool check_version (uint min_major, uint min_minor, uint min_micro);
		public weak string get_name ();
		public uint get_rank ();
		public static GLib.Type get_type ();
		public static void list_free (GLib.List list);
		public void set_name (string name);
		public void set_rank (uint rank);
		public bool type_name_filter (Gst.TypeNameData data);
	}
	[CCode (cheader_filename = "gst/gst.h")]
	public class Query : Gst.MiniObject {
		public Gst.QueryType type;
		public weak Gst.Structure structure;
		public weak Gst.Structure get_structure ();
		public static GLib.Type get_type ();
		public Query.application (Gst.QueryType type, Gst.Structure structure);
		public Query.convert (Gst.Format src_format, int64 value, Gst.Format dest_format);
		public Query.duration (Gst.Format format);
		public Query.formats ();
		public Query.latency ();
		public Query.position (Gst.Format format);
		public Query.seeking (Gst.Format format);
		public Query.segment (Gst.Format format);
		public void parse_convert (Gst.Format src_format, int64 src_value, Gst.Format dest_format, int64 dest_value);
		public void parse_duration (Gst.Format format, int64 duration);
		public void parse_formats_length (uint n_formats);
		public void parse_formats_nth (uint nth, Gst.Format format);
		public void parse_latency (bool live, uint64 min_latency, uint64 max_latency);
		public void parse_position (Gst.Format format, int64 cur);
		public void parse_seeking (Gst.Format format, bool seekable, int64 segment_start, int64 segment_end);
		public void parse_segment (double rate, Gst.Format format, int64 start_value, int64 stop_value);
		public void set_convert (Gst.Format src_format, int64 src_value, Gst.Format dest_format, int64 dest_value);
		public void set_duration (Gst.Format format, int64 duration);
		public void set_formats (int n_formats);
		public void set_formatsv (int n_formats, Gst.Format formats);
		public void set_latency (bool live, uint64 min_latency, uint64 max_latency);
		public void set_position (Gst.Format format, int64 cur);
		public void set_seeking (Gst.Format format, bool seekable, int64 segment_start, int64 segment_end);
		public void set_segment (double rate, Gst.Format format, int64 start_value, int64 stop_value);
		public static Gst.QueryType type_get_by_nick (string nick);
		public static weak Gst.QueryTypeDefinition type_get_details (Gst.QueryType type);
		public static weak string type_get_name (Gst.QueryType query);
		public static weak Gst.Iterator type_iterate_definitions ();
		public static Gst.QueryType type_register (string nick, string description);
		public static GLib.Quark type_to_quark (Gst.QueryType query);
		public static bool types_contains (Gst.QueryType types, Gst.QueryType type);
	}
	[CCode (cheader_filename = "gst/gst.h")]
	public class Registry : Gst.Object {
		public bool add_feature (Gst.PluginFeature feature);
		public bool add_plugin (Gst.Plugin plugin);
		public bool binary_read_cache (string location);
		public bool binary_write_cache (string location);
		public weak GLib.List feature_filter (Gst.PluginFeatureFilter filter, bool first, pointer user_data);
		public weak Gst.PluginFeature find_feature (string name, GLib.Type type);
		public weak Gst.Plugin find_plugin (string name);
		public static bool fork_is_enabled ();
		public static void fork_set_enabled (bool enabled);
		public static weak Gst.Registry get_default ();
		public weak GLib.List get_feature_list (GLib.Type type);
		public weak GLib.List get_feature_list_by_plugin (string name);
		public weak GLib.List get_path_list ();
		public weak GLib.List get_plugin_list ();
		public static GLib.Type get_type ();
		public weak Gst.Plugin lookup (string filename);
		public weak Gst.PluginFeature lookup_feature (string name);
		public weak GLib.List plugin_filter (Gst.PluginFilter filter, bool first, pointer user_data);
		public void remove_feature (Gst.PluginFeature feature);
		public void remove_plugin (Gst.Plugin plugin);
		public bool scan_path (string path);
		public bool xml_read_cache (string location);
		public bool xml_write_cache (string location);
		public signal void plugin_added (Gst.Plugin plugin);
		public signal void feature_added (Gst.PluginFeature feature);
	}
	[CCode (cheader_filename = "gst/gst.h")]
	public class SystemClock : Gst.Clock {
		public static GLib.Type get_type ();
		public static weak Gst.Clock obtain ();
	}
	[CCode (cheader_filename = "gst/gst.h")]
	public class Task : Gst.Object {
		public Gst.TaskState state;
		public weak GLib.Cond cond;
		public pointer @lock;
		public Gst.TaskFunction func;
		public pointer data;
		public bool running;
		public static void cleanup_all ();
		public static weak Gst.Task create (Gst.TaskFunction func, pointer data);
		public Gst.TaskState get_state ();
		public static GLib.Type get_type ();
		public bool join ();
		public bool pause ();
		public void set_lock (pointer mutex);
		public bool start ();
		public bool stop ();
	}
	[CCode (cheader_filename = "gst/gst.h")]
	public class TypeFindFactory : Gst.PluginFeature {
		public void call_function (Gst.TypeFind find);
		public weak Gst.Caps get_caps ();
		public weak string get_extensions ();
		public static weak GLib.List get_list ();
		public static GLib.Type get_type ();
	}
	[CCode (cheader_filename = "gst/gst.h")]
	public class XML : Gst.Object {
		public weak GLib.List topelements;
		public pointer ns;
		[NoArrayLength]
		public weak Gst.Element get_element (uchar[] name);
		public weak GLib.List get_topelements ();
		public static GLib.Type get_type ();
		public static weak Gst.Element make_element (pointer cur, Gst.Object parent);
		public XML ();
		[NoArrayLength]
		public bool parse_doc (pointer doc, uchar[] root);
		[NoArrayLength]
		public bool parse_file (uchar[] fname, uchar[] root);
		[NoArrayLength]
		public bool parse_memory (uchar[] buffer, uint size, string root);
		public static pointer write (Gst.Element element);
		public static int write_file (Gst.Element element, GLib.FileStream @out);
		public signal void object_loaded (Gst.Object object, pointer self);
	}
	[CCode (cheader_filename = "gst/gst.h")]
	public class cast_t : GLib.Object {
	}
	[CCode (cheader_filename = "gst/gst.h")]
	public interface ChildProxy {
		public static void child_added (Gst.Object object, Gst.Object child);
		public static void get (Gst.Object object, ...);
		public abstract weak Gst.Object get_child_by_index (uint index);
		public weak Gst.Object get_child_by_name (string name);
		public abstract uint get_children_count ();
		public static void get_property (Gst.Object object, string name, GLib.Value value);
		public static GLib.Type get_type ();
		public static void get_valist (Gst.Object object, string first_property_name, pointer var_args);
		public static bool lookup (Gst.Object object, string name, Gst.Object target, GLib.ParamSpec pspec);
		public static void set (Gst.Object object, ...);
		public static void set_property (Gst.Object object, string name, GLib.Value value);
		public static void set_valist (Gst.Object object, string first_property_name, pointer var_args);
		[HasEmitter]
		public signal void child_removed (Gst.Object child);
	}
	[CCode (cheader_filename = "gst/gst.h")]
	public interface ImplementsInterface {
		public static pointer cast (pointer from, GLib.Type type);
		public static bool check (pointer from, GLib.Type type);
		public static GLib.Type get_type ();
	}
	[CCode (cheader_filename = "gst/gst.h")]
	public interface TagSetter {
		public void add_tag_valist (Gst.TagMergeMode mode, string tag, pointer var_args);
		public void add_tag_valist_values (Gst.TagMergeMode mode, string tag, pointer var_args);
		public void add_tag_values (Gst.TagMergeMode mode, string tag);
		public void add_tags (Gst.TagMergeMode mode, string tag);
		public weak Gst.TagList get_tag_list ();
		public Gst.TagMergeMode get_tag_merge_mode ();
		public static GLib.Type get_type ();
		public void merge_tags (Gst.TagList list, Gst.TagMergeMode mode);
		public void set_tag_merge_mode (Gst.TagMergeMode mode);
	}
	[CCode (cheader_filename = "gst/gst.h")]
	public interface URIHandler {
		public abstract weak string get_protocols ();
		public static GLib.Type get_type ();
		public abstract weak string get_uri ();
		public uint get_uri_type ();
		public abstract void new_uri (string uri);
		public abstract bool set_uri (string uri);
	}
	[ReferenceType]
	[CCode (cheader_filename = "gst/gst.h")]
	public struct AllocTrace {
		public weak string name;
		public int flags;
		public int live;
		public weak GLib.SList mem_live;
		public static bool available ();
		public static weak Gst.AllocTrace get (string name);
		public static weak GLib.List list ();
		public static int live_all ();
		public void print ();
		public static void print_all ();
		public static void print_live ();
		public void set_flags (Gst.AllocTraceFlags flags);
		public static void set_flags_all (Gst.AllocTraceFlags flags);
	}
	[ReferenceType]
	[CCode (cheader_filename = "gst/gst.h")]
	public struct BinaryChunk {
	}
	[ReferenceType]
	[CCode (cheader_filename = "gst/gst.h")]
	public struct BinaryElementFactory {
	}
	[ReferenceType]
	[CCode (cheader_filename = "gst/gst.h")]
	public struct BinaryPadTemplate {
	}
	[ReferenceType]
	[CCode (cheader_filename = "gst/gst.h")]
	public struct BinaryPluginElement {
	}
	[ReferenceType]
	[CCode (cheader_filename = "gst/gst.h")]
	public struct BinaryPluginFeature {
	}
	[ReferenceType]
	[CCode (cheader_filename = "gst/gst.h")]
	public struct BinaryRegistryMagic {
	}
	[ReferenceType]
	[CCode (cheader_filename = "gst/gst.h")]
	public struct BinaryTypeFindFactory {
	}
	[ReferenceType (dup_function = "gst_caps_ref", free_function = "gst_caps_unref")]
	[CCode (cheader_filename = "gst/gst.h")]
	public struct Caps {
		public GLib.Type type;
		public int refcount;
		public Gst.CapsFlags flags;
		public void append (Gst.Caps caps2);
		public void append_structure (Gst.Structure structure);
		public weak Gst.Caps copy ();
		public weak Gst.Caps copy_nth (uint nth);
		public bool do_simplify ();
		public static weak Gst.Caps from_string (string string);
		public uint get_size ();
		public weak Gst.Structure get_structure (uint index);
		public static GLib.Type get_type ();
		public weak Gst.Caps intersect (Gst.Caps caps2);
		public bool is_always_compatible (Gst.Caps caps2);
		public bool is_any ();
		public bool is_empty ();
		public bool is_equal (Gst.Caps caps2);
		public bool is_equal_fixed (Gst.Caps caps2);
		public bool is_fixed ();
		public bool is_subset (Gst.Caps superset);
		public static weak Gst.Caps load_thyself (pointer parent);
		public weak Gst.Caps make_writable ();
		public void merge (Gst.Caps caps2);
		public void merge_structure (Gst.Structure structure);
		public Caps.any ();
		public Caps.empty ();
		public Caps.full (Gst.Structure struct1);
		public Caps.full_valist (Gst.Structure structure, pointer var_args);
		public Caps.simple (string media_type, string fieldname);
		public weak Gst.Caps normalize ();
		public void remove_structure (uint idx);
		public void replace (Gst.Caps newcaps);
		public pointer save_thyself (pointer parent);
		public void set_simple (string field);
		public void set_simple_valist (string field, pointer varargs);
		public weak Gst.Caps subtract (Gst.Caps subtrahend);
		public weak string to_string ();
		public void truncate ();
		public weak Gst.Caps union (Gst.Caps caps2);
	}
	[ReferenceType]
	[CCode (cheader_filename = "gst/gst.h")]
	public struct ClockEntry {
		public int refcount;
		public weak Gst.Clock clock;
		public Gst.ClockEntryType type;
		public uint64 time;
		public uint64 interval;
		public Gst.ClockReturn status;
		public Gst.ClockCallback func;
		public pointer user_data;
	}
	[ReferenceType]
	[CCode (cheader_filename = "gst/gst.h")]
	public struct DebugCategory {
	}
	[ReferenceType]
	[CCode (cheader_filename = "gst/gst.h")]
	public struct DebugMessage {
	}
	[ReferenceType]
	[CCode (cheader_filename = "gst/gst.h")]
	public struct ElementDetails {
		public weak string longname;
		public weak string klass;
		public weak string description;
		public weak string author;
	}
	[ReferenceType]
	[CCode (cheader_filename = "gst/gst.h")]
	public struct FormatDefinition {
		public Gst.Format value;
		public weak string nick;
		public weak string description;
		public GLib.Quark quark;
	}
	[ReferenceType]
	[CCode (cheader_filename = "gst/gst.h")]
	public struct IndexAssociation {
		public Gst.Format format;
		public int64 value;
	}
	[ReferenceType (free_function = "gst_index_entry_free")]
	[CCode (cheader_filename = "gst/gst.h")]
	public struct IndexEntry {
		public bool assoc_map (Gst.Format format, int64 value);
		public weak Gst.IndexEntry copy ();
		public static GLib.Type get_type ();
	}
	[ReferenceType]
	[CCode (cheader_filename = "gst/gst.h")]
	public struct IndexGroup {
	}
	[ReferenceType]
	[CCode (cheader_filename = "gst/gst.h")]
	public struct Iterator {
		public Gst.IteratorNextFunction next;
		public Gst.IteratorItemFunction item;
		public Gst.IteratorResyncFunction resync;
		public Gst.IteratorFreeFunction free;
		public weak Gst.Iterator pushed;
		public GLib.Type type;
		public weak GLib.Mutex @lock;
		public uint cookie;
		public uint master_cookie;
		public weak Gst.Iterator filter (GLib.CompareFunc func, pointer user_data);
		public pointer find_custom (GLib.CompareFunc func, pointer user_data);
		public Gst.IteratorResult fold (Gst.IteratorFoldFunction func, GLib.Value ret, pointer user_data);
		public Gst.IteratorResult @foreach (GLib.Func func, pointer user_data);
		public Iterator (uint size, GLib.Type type, GLib.Mutex @lock, uint master_cookie, Gst.IteratorNextFunction next, Gst.IteratorItemFunction item, Gst.IteratorResyncFunction resync, Gst.IteratorFreeFunction free);
		public Iterator.list (GLib.Type type, GLib.Mutex @lock, uint master_cookie, GLib.List list, pointer owner, Gst.IteratorItemFunction item, Gst.IteratorDisposeFunction free);
		public void push (Gst.Iterator other);
	}
	[ReferenceType]
	[CCode (cheader_filename = "gst/gst.h")]
	public struct PluginDesc {
		public int major_version;
		public int minor_version;
		public weak string name;
		public weak string description;
		public Gst.PluginInitFunc plugin_init;
		public weak string version;
		public weak string license;
		public weak string source;
		public weak string package;
		public weak string origin;
		public pointer _gst_reserved;
	}
	[ReferenceType]
	[CCode (cheader_filename = "gst/gst.h")]
	public struct QueryTypeDefinition {
		public Gst.QueryType value;
		public weak string nick;
		public weak string description;
		public GLib.Quark quark;
	}
	[ReferenceType]
	[CCode (cheader_filename = "gst/gst.h")]
	public struct Segment {
		public double rate;
		public double abs_rate;
		public Gst.Format format;
		public Gst.SeekFlags flags;
		public int64 start;
		public int64 stop;
		public int64 time;
		public int64 accum;
		public int64 last_stop;
		public int64 duration;
		public double applied_rate;
		public bool clip (Gst.Format format, int64 start, int64 stop, int64 clip_start, int64 clip_stop);
		public static GLib.Type get_type ();
		public void init (Gst.Format format);
		public Segment ();
		public void set_duration (Gst.Format format, int64 duration);
		public void set_last_stop (Gst.Format format, int64 position);
		public void set_newsegment (bool update, double rate, Gst.Format format, int64 start, int64 stop, int64 time);
		public void set_newsegment_full (bool update, double rate, double applied_rate, Gst.Format format, int64 start, int64 stop, int64 time);
		public void set_seek (double rate, Gst.Format format, Gst.SeekFlags flags, Gst.SeekType start_type, int64 start, Gst.SeekType stop_type, int64 stop, bool update);
		public int64 to_running_time (Gst.Format format, int64 position);
		public int64 to_stream_time (Gst.Format format, int64 position);
	}
	[ReferenceType]
	[CCode (cheader_filename = "gst/gst.h")]
	public struct StaticCaps {
		public weak Gst.Caps caps;
		public weak string string;
		public weak Gst.Caps get ();
		public static GLib.Type get_type ();
	}
	[ReferenceType]
	[CCode (cheader_filename = "gst/gst.h")]
	public struct StaticPadTemplate {
		public weak string name_template;
		public Gst.PadDirection direction;
		public Gst.PadPresence presence;
		public weak Gst.StaticCaps static_caps;
		public weak Gst.PadTemplate get ();
		public weak Gst.Caps get_caps ();
		public static GLib.Type get_type ();
	}
	[ReferenceType]
	[CCode (cheader_filename = "gst/gst.h")]
	public struct Structure {
		public GLib.Type type;
		public weak Gst.Structure copy ();
		public static weak Gst.Structure empty_new (string name);
		public bool fixate_field_boolean (string field_name, bool target);
		public bool fixate_field_nearest_double (string field_name, double target);
		public bool fixate_field_nearest_fraction (string field_name, int target_numerator, int target_denominator);
		public bool fixate_field_nearest_int (string field_name, int target);
		public bool @foreach (Gst.StructureForeachFunc func, pointer user_data);
		public static weak Gst.Structure from_string (string string, string end);
		public bool get_boolean (string fieldname, bool value);
		public bool get_clock_time (string fieldname, uint64 value);
		public bool get_date (string fieldname, GLib.Date value);
		public bool get_double (string fieldname, double value);
		public bool get_enum (string fieldname, GLib.Type enumtype, int value);
		public GLib.Type get_field_type (string fieldname);
		public bool get_fourcc (string fieldname, uint value);
		public bool get_fraction (string fieldname, int value_numerator, int value_denominator);
		public bool get_int (string fieldname, int value);
		public weak string get_name ();
		public GLib.Quark get_name_id ();
		public weak string get_string (string fieldname);
		public static GLib.Type get_type ();
		public weak GLib.Value get_value (string fieldname);
		public bool has_field (string fieldname);
		public bool has_field_typed (string fieldname, GLib.Type type);
		public bool has_name (string name);
		public static weak Gst.Structure id_empty_new (GLib.Quark quark);
		public weak GLib.Value id_get_value (GLib.Quark field);
		public void id_set (GLib.Quark fieldname);
		public void id_set_valist (GLib.Quark fieldname, pointer varargs);
		public void id_set_value (GLib.Quark field, GLib.Value value);
		public bool map_in_place (Gst.StructureMapFunc func, pointer user_data);
		public int n_fields ();
		public Structure (string name, string firstfield);
		public Structure.valist (string name, string firstfield, pointer varargs);
		public weak string nth_field_name (uint index);
		public void remove_all_fields ();
		public void remove_field (string fieldname);
		public void remove_fields (string fieldname);
		public void remove_fields_valist (string fieldname, pointer varargs);
		public void set (string fieldname);
		public void set_name (string name);
		public void set_parent_refcount (int refcount);
		public void set_valist (string fieldname, pointer varargs);
		public void set_value (string fieldname, GLib.Value value);
		public weak string to_string ();
	}
	[ReferenceType]
	[CCode (cheader_filename = "gst/gst.h")]
	public struct TagList {
		public GLib.Type type;
		public void add (Gst.TagMergeMode mode, string tag);
		public void add_valist (Gst.TagMergeMode mode, string tag, pointer var_args);
		public void add_valist_values (Gst.TagMergeMode mode, string tag, pointer var_args);
		public void add_values (Gst.TagMergeMode mode, string tag);
		public weak Gst.TagList copy ();
		public static bool copy_value (GLib.Value dest, Gst.TagList list, string tag);
		public void @foreach (Gst.TagForeachFunc func, pointer user_data);
		public bool get_boolean (string tag, bool value);
		public bool get_boolean_index (string tag, uint index, bool value);
		public bool get_char (string tag, string value);
		public bool get_char_index (string tag, uint index, string value);
		public bool get_date (string tag, GLib.Date value);
		public bool get_date_index (string tag, uint index, GLib.Date value);
		public bool get_double (string tag, double value);
		public bool get_double_index (string tag, uint index, double value);
		public bool get_float (string tag, float value);
		public bool get_float_index (string tag, uint index, float value);
		public bool get_int (string tag, int value);
		public bool get_int64 (string tag, int64 value);
		public bool get_int64_index (string tag, uint index, int64 value);
		public bool get_int_index (string tag, uint index, int value);
		public bool get_long (string tag, long value);
		public bool get_long_index (string tag, uint index, long value);
		public bool get_pointer (string tag, pointer value);
		public bool get_pointer_index (string tag, uint index, pointer value);
		public bool get_string (string tag, string value);
		public bool get_string_index (string tag, uint index, string value);
		public uint get_tag_size (string tag);
		public static GLib.Type get_type ();
		[NoArrayLength]
		public bool get_uchar (string tag, uchar[] value);
		[NoArrayLength]
		public bool get_uchar_index (string tag, uint index, uchar[] value);
		public bool get_uint (string tag, uint value);
		public bool get_uint64 (string tag, uint64 value);
		public bool get_uint64_index (string tag, uint index, uint64 value);
		public bool get_uint_index (string tag, uint index, uint value);
		public bool get_ulong (string tag, ulong value);
		public bool get_ulong_index (string tag, uint index, ulong value);
		public weak GLib.Value get_value_index (string tag, uint index);
		public void insert (Gst.TagList from, Gst.TagMergeMode mode);
		public bool is_empty ();
		public weak Gst.TagList merge (Gst.TagList list2, Gst.TagMergeMode mode);
		public TagList ();
		public void remove_tag (string tag);
	}
	[ReferenceType]
	[CCode (cheader_filename = "gst/gst.h")]
	public struct Trace {
		public void destroy ();
		public void flush ();
		public Trace (string filename, int size);
		public static void read_tsc (int64 dst);
		public void set_default ();
		public void text_flush ();
	}
	[ReferenceType]
	[CCode (cheader_filename = "gst/gst.h")]
	public struct TraceEntry {
		public int64 timestamp;
		public uint sequence;
		public uint data;
		public char message;
	}
	[ReferenceType]
	[CCode (cheader_filename = "gst/gst.h")]
	public struct TypeFind {
		public pointer data;
		public pointer _gst_reserved;
		public uint64 get_length ();
		public static GLib.Type get_type ();
		public uchar peek (int64 offset, uint size);
		public static bool register (Gst.Plugin plugin, string name, uint rank, Gst.TypeFindFunction func, string extensions, Gst.Caps possible_caps, pointer data, GLib.DestroyNotify data_notify);
		public void suggest (uint probability, Gst.Caps caps);
	}
	[ReferenceType]
	[CCode (cheader_filename = "gst/gst.h")]
	public struct TypeNameData {
		public weak string name;
		public GLib.Type type;
	}
	[ReferenceType]
	[CCode (cheader_filename = "gst/gst.h")]
	public struct ValueTable {
		public GLib.Type type;
		public Gst.ValueCompareFunc compare;
		public Gst.ValueSerializeFunc serialize;
		public Gst.ValueDeserializeFunc deserialize;
	}
	[ReferenceType]
	[CCode (cheader_filename = "gst/gst.h")]
	public struct Debug {
		public static void print_stack_trace ();
		public static uint remove_log_function (Gst.LogFunction func);
		public static uint remove_log_function_by_data (pointer data);
	}
	[ReferenceType]
	[CCode (cheader_filename = "gst/gst.h")]
	public struct Flow {
		public static weak string get_name (Gst.FlowReturn ret);
		public static GLib.Quark to_quark (Gst.FlowReturn ret);
	}
	[ReferenceType]
	[CCode (cheader_filename = "gst/gst.h")]
	public struct Fraction {
		public static GLib.Type get_type ();
		public static GLib.Type range_get_type ();
	}
	[ReferenceType]
	[CCode (cheader_filename = "gst/gst.h")]
	public struct Init {
		public static bool check (int argc, string argv, GLib.Error err);
		public static weak GLib.OptionGroup get_option_group ();
	}
	[ReferenceType]
	[CCode (cheader_filename = "gst/gst.h")]
	public struct Param {
		public static weak GLib.ParamSpec spec_fraction (string name, string nick, string blurb, int min_num, int min_denom, int max_num, int max_denom, int default_num, int default_denom, GLib.ParamFlags flags);
		public static weak GLib.ParamSpec spec_mini_object (string name, string nick, string blurb, GLib.Type object_type, GLib.ParamFlags flags);
	}
	[ReferenceType]
	[CCode (cheader_filename = "gst/gst.h")]
	public struct Print {
		public static void element_args (GLib.String buf, int indent, Gst.Element element);
		public static void pad_caps (GLib.String buf, int indent, Gst.Pad pad);
	}
	[ReferenceType]
	[CCode (cheader_filename = "gst/gst.h")]
	public struct Segtrap {
		public static bool is_enabled ();
		public static void set_enabled (bool enabled);
	}
	[ReferenceType]
	[CCode (cheader_filename = "gst/gst.h")]
	public struct Tag {
		public static bool exists (string tag);
		public static weak string get_description (string tag);
		public static Gst.TagFlag get_flag (string tag);
		public static weak string get_nick (string tag);
		public static GLib.Type get_type (string tag);
		public static bool is_fixed (string tag);
		public static void merge_strings_with_comma (GLib.Value dest, GLib.Value src);
		public static void merge_use_first (GLib.Value dest, GLib.Value src);
		public static void register (string name, Gst.TagFlag flag, GLib.Type type, string nick, string blurb, Gst.TagMergeFunc func);
	}
	[ReferenceType]
	[CCode (cheader_filename = "gst/gst.h")]
	public struct Uri {
		public static weak string @construct (string protocol, string location);
		public static weak string get_location (string uri);
		public static weak string get_protocol (string uri);
		public static bool has_protocol (string uri, string protocol);
		public static bool is_valid (string uri);
		public static bool protocol_is_supported (Gst.URIType type, string protocol);
		public static bool protocol_is_valid (string protocol);
	}
	[ReferenceType]
	[CCode (cheader_filename = "gst/gst.h")]
	public struct Util {
		[NoArrayLength]
		public static void dump_mem (uchar[] mem, uint size);
		public static uint64 gdouble_to_guint64 (double value);
		public static double guint64_to_gdouble (uint64 value);
		public static void set_object_arg (GLib.Object object, string name, string value);
		public static void set_value_from_string (GLib.Value value, string value_str);
		public static uint64 uint64_scale (uint64 val, uint64 num, uint64 denom);
		public static uint64 uint64_scale_int (uint64 val, int num, int denom);
	}
	[ReferenceType]
	[CCode (cheader_filename = "gst/gst.h")]
	public struct Value {
		public static void array_append_value (GLib.Value value, GLib.Value append_value);
		public static uint array_get_size (GLib.Value value);
		public static GLib.Type array_get_type ();
		public static weak GLib.Value array_get_value (GLib.Value value, uint index);
		public static void array_prepend_value (GLib.Value value, GLib.Value prepend_value);
		public static bool can_compare (GLib.Value value1, GLib.Value value2);
		public static bool can_intersect (GLib.Value value1, GLib.Value value2);
		public static bool can_subtract (GLib.Value minuend, GLib.Value subtrahend);
		public static bool can_union (GLib.Value value1, GLib.Value value2);
		public static int compare (GLib.Value value1, GLib.Value value2);
		public static bool deserialize (GLib.Value dest, string src);
		public static bool fraction_multiply (GLib.Value product, GLib.Value factor1, GLib.Value factor2);
		public static bool fraction_subtract (GLib.Value dest, GLib.Value minuend, GLib.Value subtrahend);
		public static weak Gst.Caps get_caps (GLib.Value value);
		public static weak GLib.Date get_date (GLib.Value value);
		public static double get_double_range_max (GLib.Value value);
		public static double get_double_range_min (GLib.Value value);
		public static uint get_fourcc (GLib.Value value);
		public static int get_fraction_denominator (GLib.Value value);
		public static int get_fraction_numerator (GLib.Value value);
		public static weak GLib.Value get_fraction_range_max (GLib.Value value);
		public static weak GLib.Value get_fraction_range_min (GLib.Value value);
		public static int get_int_range_max (GLib.Value value);
		public static int get_int_range_min (GLib.Value value);
		public static weak Gst.MiniObject get_mini_object (GLib.Value value);
		public static void init_and_copy (GLib.Value dest, GLib.Value src);
		public static bool intersect (GLib.Value dest, GLib.Value value1, GLib.Value value2);
		public static bool is_fixed (GLib.Value value);
		public static void list_append_value (GLib.Value value, GLib.Value append_value);
		public static void list_concat (GLib.Value dest, GLib.Value value1, GLib.Value value2);
		public static uint list_get_size (GLib.Value value);
		public static GLib.Type list_get_type ();
		public static weak GLib.Value list_get_value (GLib.Value value, uint index);
		public static void list_prepend_value (GLib.Value value, GLib.Value prepend_value);
		public static void register (Gst.ValueTable table);
		public static void register_intersect_func (GLib.Type type1, GLib.Type type2, Gst.ValueIntersectFunc func);
		public static void register_subtract_func (GLib.Type minuend_type, GLib.Type subtrahend_type, Gst.ValueSubtractFunc func);
		public static void register_union_func (GLib.Type type1, GLib.Type type2, Gst.ValueUnionFunc func);
		public static weak string serialize (GLib.Value value);
		public static void set_caps (GLib.Value value, Gst.Caps caps);
		public static void set_date (GLib.Value value, GLib.Date date);
		public static void set_double_range (GLib.Value value, double start, double end);
		public static void set_fourcc (GLib.Value value, uint fourcc);
		public static void set_fraction (GLib.Value value, int numerator, int denominator);
		public static void set_fraction_range (GLib.Value value, GLib.Value start, GLib.Value end);
		public static void set_fraction_range_full (GLib.Value value, int numerator_start, int denominator_start, int numerator_end, int denominator_end);
		public static void set_int_range (GLib.Value value, int start, int end);
		public static void set_mini_object (GLib.Value value, Gst.MiniObject mini_object);
		public static bool subtract (GLib.Value dest, GLib.Value minuend, GLib.Value subtrahend);
		public static void take_mini_object (GLib.Value value, Gst.MiniObject mini_object);
		public static bool union (GLib.Value dest, GLib.Value value1, GLib.Value value2);
	}
	public static delegate bool BusFunc (Gst.Bus bus, Gst.Message message, pointer data);
	public static delegate Gst.BusSyncReply BusSyncHandler (Gst.Bus bus, Gst.Message message, pointer data);
	public static delegate bool ClockCallback (Gst.Clock clock, uint64 time, pointer id, pointer user_data);
	public static delegate bool FilterFunc (pointer obj, pointer user_data);
	public static delegate bool IndexFilter (Gst.Index index, Gst.IndexEntry entry, pointer user_data);
	public static delegate bool IndexResolver (Gst.Index index, Gst.Object writer, string writer_string, pointer user_data);
	public static delegate void IteratorDisposeFunction (pointer owner);
	public static delegate bool IteratorFoldFunction (pointer item, GLib.Value ret, pointer user_data);
	public static delegate void IteratorFreeFunction (Gst.Iterator it);
	public static delegate Gst.IteratorItem IteratorItemFunction (Gst.Iterator it, pointer item);
	public static delegate Gst.IteratorResult IteratorNextFunction (Gst.Iterator it, pointer result);
	public static delegate void IteratorResyncFunction (Gst.Iterator it);
	public static delegate void LogFunction (Gst.DebugCategory category, Gst.DebugLevel level, string file, string function, int line, GLib.Object object, Gst.DebugMessage message, pointer data);
	public static delegate weak Gst.MiniObject MiniObjectCopyFunction (Gst.MiniObject obj);
	public static delegate void MiniObjectFinalizeFunction (Gst.MiniObject obj);
	public static delegate bool PadAcceptCapsFunction (Gst.Pad pad, Gst.Caps caps);
	public static delegate bool PadActivateFunction (Gst.Pad pad);
	public static delegate bool PadActivateModeFunction (Gst.Pad pad, bool active);
	public static delegate void PadBlockCallback (Gst.Pad pad, bool blocked, pointer user_data);
	public static delegate Gst.FlowReturn PadBufferAllocFunction (Gst.Pad pad, uint64 offset, uint size, Gst.Caps caps, Gst.Buffer buf);
	public static delegate Gst.FlowReturn PadChainFunction (Gst.Pad pad, Gst.Buffer buffer);
	public static delegate bool PadCheckGetRangeFunction (Gst.Pad pad);
	public static delegate bool PadDispatcherFunction (Gst.Pad pad, pointer data);
	public static delegate bool PadEventFunction (Gst.Pad pad, Gst.Event event);
	public static delegate void PadFixateCapsFunction (Gst.Pad pad, Gst.Caps caps);
	public static delegate weak Gst.Caps PadGetCapsFunction (Gst.Pad pad);
	public static delegate Gst.FlowReturn PadGetRangeFunction (Gst.Pad pad, uint64 offset, uint length, Gst.Buffer buffer);
	public static delegate weak GLib.List PadIntLinkFunction (Gst.Pad pad);
	public static delegate Gst.PadLinkReturn PadLinkFunction (Gst.Pad pad, Gst.Pad peer);
	public static delegate bool PadQueryFunction (Gst.Pad pad, Gst.Query query);
	public static delegate bool PadSetCapsFunction (Gst.Pad pad, Gst.Caps caps);
	public static delegate void PadUnlinkFunction (Gst.Pad pad);
	public static delegate bool PluginFeatureFilter (Gst.PluginFeature feature, pointer user_data);
	public static delegate bool PluginFilter (Gst.Plugin plugin, pointer user_data);
	public static delegate bool PluginInitFunc (Gst.Plugin plugin);
	public static delegate bool StructureForeachFunc (GLib.Quark field_id, GLib.Value value, pointer user_data);
	public static delegate bool StructureMapFunc (GLib.Quark field_id, GLib.Value value, pointer user_data);
	public static delegate void TagForeachFunc (Gst.TagList list, string tag, pointer user_data);
	public static delegate void TagMergeFunc (GLib.Value dest, GLib.Value src);
	public static delegate void TaskFunction (pointer data);
	public static delegate void TypeFindFunction (Gst.TypeFind find, pointer data);
	public static delegate int ValueCompareFunc (GLib.Value value1, GLib.Value value2);
	public static delegate bool ValueDeserializeFunc (GLib.Value dest, string s);
	public static delegate bool ValueIntersectFunc (GLib.Value dest, GLib.Value value1, GLib.Value value2);
	public static delegate weak string ValueSerializeFunc (GLib.Value value1);
	public static delegate bool ValueSubtractFunc (GLib.Value dest, GLib.Value minuend, GLib.Value subtrahend);
	public static delegate bool ValueUnionFunc (GLib.Value dest, GLib.Value value1, GLib.Value value2);
	public static void init (ref string[] args);
	public static void atomic_int_set (int atomic_int, int value);
	public static void class_signal_emit_by_name (Gst.Object object, string name, pointer self);
	public static GLib.Quark core_error_quark ();
	public static GLib.Type date_get_type ();
	public static bool default_registry_check_feature_version (string feature_name, uint min_major, uint min_minor, uint min_micro);
	public static GLib.Type double_range_get_type ();
	public static weak string error_get_message (GLib.Quark domain, int code);
	public static weak GLib.List filter_run (GLib.List list, Gst.FilterFunc func, bool first, pointer user_data);
	public static Gst.Format format_get_by_nick (string nick);
	public static weak Gst.FormatDefinition format_get_details (Gst.Format format);
	public static weak string format_get_name (Gst.Format format);
	public static weak Gst.Iterator format_iterate_definitions ();
	public static Gst.Format format_register (string nick, string description);
	public static GLib.Quark format_to_quark (Gst.Format format);
	public static bool formats_contains (Gst.Format formats, Gst.Format format);
	public static GLib.Type fourcc_get_type ();
	public static GLib.Type g_error_get_type ();
	public static GLib.Type int_range_get_type ();
	public static bool is_tag_list (pointer p);
	public static GLib.Quark library_error_quark ();
	public static weak Gst.Element parse_bin_from_description (string bin_description, bool ghost_unconnected_pads, GLib.Error err);
	public static GLib.Quark parse_error_quark ();
	public static weak Gst.Element parse_launch (string pipeline_description, GLib.Error error);
	[NoArrayLength]
	public static weak Gst.Element parse_launchv (string[] argv, GLib.Error error);
	public static GLib.Quark resource_error_quark ();
	public static GLib.Quark stream_error_quark ();
	public static bool update_registry ();
	public static weak string version_string ();
}
