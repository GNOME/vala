namespace Atk {
	[CCode (cheader_filename = "atk/atk.h", has_destroy_function = false)]
	public struct Attribute {
		public string name;
		public string value;
	}
	public interface Implementor : GLib.Object {
		public abstract unowned Atk.Object ref_accessible ();
	}
	public class Registry : GLib.Object {
		[Deprecated]
		public weak GLib.HashTable<GLib.Type,Atk.ObjectFactory> factory_singleton_cache;
		[Deprecated]
		public weak GLib.HashTable<GLib.Type,GLib.Type> factory_type_registry;
     }
	public class Relation : GLib.Object {
		[Deprecated (replacement = "RelationType.for_name", since = "vala-0.16")]
		public static Atk.RelationType type_for_name (string name);
		[Deprecated (replacement = "RelationType.get_name", since = "vala-0.16")]
		public static unowned string type_get_name (Atk.RelationType type);
		[Deprecated (replacement = "RelationType.register", since = "vala-0.16")]
		public static Atk.RelationType type_register (string name);
	}
	[SimpleType]
	public struct State : uint64 {
		[Deprecated (replacement = "StateType.for_name", since = "vala-0.16")]
		public static Atk.StateType type_for_name (string name);
		[Deprecated (replacement = "StateType.get_name", since = "vala-0.16")]
		public static unowned string type_get_name (Atk.StateType type);
		[Deprecated (replacement = "StateType.register", since = "vala-0.16")]
		public static Atk.StateType type_register (string name);
	}
	[CCode (copy_function = "g_boxed_copy", free_function = "g_boxed_free", type_id = "atk_text_range_get_type ()", has_destroy_function = false)]
	[Compact]
	public class TextRange {
		public string content;
	}
	public interface Text : GLib.Object {
		[Deprecated (replacement = "TextAttribute.for_name", since = "vala-0.16")]
		public static Atk.TextAttribute attribute_for_name (string name);
		[Deprecated (replacement = "TextAttribute.get_name", since = "vala-0.16")]
		public static unowned string attribute_get_name (Atk.TextAttribute attr);
		[Deprecated (replacement = "TextAttribute.get_value", since = "vala-0.16")]
		public static unowned string attribute_get_value (Atk.TextAttribute attr, int index_);
		[Deprecated (replacement = "TextAttribute.register", since = "vala-0.16")]
		public static Atk.TextAttribute attribute_register (string name);
		[CCode (array_length = false, array_null_terminated = true)]
		public virtual Atk.TextRange[] get_bounded_ranges (Atk.TextRectangle rect, Atk.CoordType coord_type, Atk.TextClipType x_clip_type, Atk.TextClipType y_clip_type);
	}

	public delegate bool Function ();
	public delegate int KeySnoopFunc (Atk.KeyEventStruct event);
	[CCode (has_target = false)]
	public delegate void PropertyChangeHandler (Atk.Object Param1, Atk.PropertyValues Param2);

	[Deprecated (replacement = "Atk.Util.add_focus_tracker", since = "vala-0.16")]
	public static uint add_focus_tracker (Atk.EventListener focus_tracker);
	[Deprecated (replacement = "Atk.Util.add_global_event_listener", since = "vala-0.16")]
	public static uint add_global_event_listener (GLib.SignalEmissionHook listener, string event_type);
	[Deprecated (replacement = "Atk.Util.focus_tracker_init", since = "vala-0.16")]
	public static void focus_tracker_init (Atk.EventListenerInit init);
	[Deprecated (replacement = "Atk.Util.focus_tracker_notify", since = "vala-0.16")]
	public static void focus_tracker_notify (Atk.Object object);
	[Deprecated (replacement = "Atk.Registry.get_default.", since = "vala-0.16")]
	public static unowned Atk.Registry get_default_registry ();
	[Deprecated (replacement = "Atk.Util.get_focus_object", since = "vala-0.16")]
	public static unowned Atk.Object get_focus_object ();
	[Deprecated (replacement = "Atk.Util.get_root", since = "vala-0.16")]
	public static unowned Atk.Object get_root ();
	[Deprecated (replacement = "Atk.Util.get_toolkit_name", since = "vala-0.16")]
	public static unowned string get_toolkit_name ();
	[Deprecated (replacement = "Atk.Util.get_toolkit_version", since = "vala-0.16")]
	public static unowned string get_toolkit_version ();
	[Deprecated (replacement = "Atk.Util.get_version", since = "vala-0.16")]
	public static unowned string get_version ();
	[Deprecated (replacement = "Atk.Util.remove_focus_tracker", since = "vala-0.16")]
	public static void remove_focus_tracker (uint tracker_id);
	[Deprecated (replacement = "Atk.Util.remove_global_event_listener", since = "vala-0.16")]
	public static void remove_global_event_listener (uint listener_id);
	[Deprecated (replacement = "Atk.Util.remove_key_event_listener", since = "vala-0.16")]
	public static void remove_key_event_listener (uint listener_id);
	[Deprecated (replacement = "Atk.Role.for_name", since = "vala-0.16")]
	public static Atk.Role role_for_name (string name);
	[Deprecated (replacement = "Atk.Role.get_localized_name", since = "vala-0.16")]
	public static unowned string role_get_localized_name (Atk.Role role);
	[Deprecated (replacement = "Atk.Role.get_name", since = "vala-0.16")]
	public static unowned string role_get_name (Atk.Role role);
	[Deprecated (replacement = "Atk.Role.register", since = "vala-0.16")]
	public static Atk.Role role_register (string name);
}
