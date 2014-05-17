namespace Atk {
	[Compact]
	public class AttributeSet : GLib.SList<Atk.Attribute?> {
	}
	[CCode (cheader_filename = "atk/atk.h", type_id = "atk_document_get_type ()")]
	public interface Document : GLib.Object {
		[Version (replacement = "Document.get_locale", deprecated_since = "vala-0.22")]
		public virtual unowned string get_document_locale ();
	}
	public interface Implementor : GLib.Object {
		public abstract unowned Atk.Object ref_accessible ();
	}
	public class Registry : GLib.Object {
		[Version (deprecated = true)]
		public weak GLib.HashTable<GLib.Type,Atk.ObjectFactory> factory_singleton_cache;
		[Version (deprecated = true)]
		public weak GLib.HashTable<GLib.Type,GLib.Type> factory_type_registry;
	}
	public class Relation : GLib.Object {
		[Version (replacement = "RelationType.for_name", deprecated_since = "vala-0.16")]
		public static Atk.RelationType type_for_name (string name);
		[Version (replacement = "RelationType.get_name", deprecated_since = "vala-0.16")]
		public static unowned string type_get_name (Atk.RelationType type);
		[Version (replacement = "RelationType.register", deprecated_since = "vala-0.16")]
		public static Atk.RelationType type_register (string name);
	}
	[SimpleType]
	public struct State : uint64 {
		[Version (replacement = "StateType.for_name", deprecated_since = "vala-0.16")]
		public static Atk.StateType type_for_name (string name);
		[Version (replacement = "StateType.get_name", deprecated_since = "vala-0.16")]
		public static unowned string type_get_name (Atk.StateType type);
		[Version (replacement = "StateType.register", deprecated_since = "vala-0.16")]
		public static Atk.StateType type_register (string name);
	}
	public interface Text : GLib.Object {
		[Version (since = "1.3")]
		[CCode (array_length = false, array_null_terminated = true, cname = "atk_text_get_bounded_ranges")]
		public virtual Atk.TextRange[] get_bounded_ranges (Atk.TextRectangle rect, Atk.CoordType coord_type, Atk.TextClipType x_clip_type, Atk.TextClipType y_clip_type);
		[Version (replacement = "TextAttribute.for_name", deprecated_since = "vala-0.16")]
		public static Atk.TextAttribute attribute_for_name (string name);
		[Version (replacement = "TextAttribute.get_name", deprecated_since = "vala-0.16")]
		public static unowned string attribute_get_name (Atk.TextAttribute attr);
		[Version (replacement = "TextAttribute.get_value", deprecated_since = "vala-0.16")]
		public static unowned string attribute_get_value (Atk.TextAttribute attr, int index_);
		[Version (replacement = "TextAttribute.register", deprecated_since = "vala-0.16")]
		public static Atk.TextAttribute attribute_register (string name);
	}

	[CCode (cheader_filename = "atk/atk.h", cprefix = "ATK_ROLE_", type_id = "atk_role_get_type ()")]
	public enum Role {
		[Version (replacement = "Role.ACCELERATOR_LABEL", deprecated_since = "vala-0.22")]
		ACCEL_LABEL
	}

	[CCode (cname = "GSignalEmissionHook", has_target = false)]
	public delegate bool SignalEmissionHook (GLib.SignalInvocationHint ihint, [CCode (array_length_pos = 1.9)] Value[] param_values, void* data);

	[Version (replacement = "Atk.Util.add_focus_tracker", deprecated_since = "vala-0.16")]
	public static uint add_focus_tracker (Atk.EventListener focus_tracker);
	[Version (replacement = "Atk.Util.add_global_event_listener", deprecated_since = "vala-0.16")]
	public static uint add_global_event_listener (GLib.SignalEmissionHook listener, string event_type);
	[Version (replacement = "Atk.Util.focus_tracker_init", deprecated_since = "vala-0.16")]
	public static void focus_tracker_init (Atk.EventListenerInit init);
	[Version (replacement = "Atk.Util.focus_tracker_notify", deprecated_since = "vala-0.16")]
	public static void focus_tracker_notify (Atk.Object object);
	[Version (replacement = "Atk.Registry.get_default.", deprecated_since = "vala-0.16")]
	public static unowned Atk.Registry get_default_registry ();
	[Version (replacement = "Atk.Util.get_focus_object", deprecated_since = "vala-0.16")]
	public static unowned Atk.Object get_focus_object ();
	[Version (replacement = "Atk.Util.get_root", deprecated_since = "vala-0.16")]
	public static unowned Atk.Object get_root ();
	[Version (replacement = "Atk.Util.get_toolkit_name", deprecated_since = "vala-0.16")]
	public static unowned string get_toolkit_name ();
	[Version (replacement = "Atk.Util.get_toolkit_version", deprecated_since = "vala-0.16")]
	public static unowned string get_toolkit_version ();
	[Version (replacement = "Atk.Util.get_version", deprecated_since = "vala-0.16")]
	public static unowned string get_version ();
	[Version (replacement = "Atk.Util.remove_focus_tracker", deprecated_since = "vala-0.16")]
	public static void remove_focus_tracker (uint tracker_id);
	[Version (replacement = "Atk.Util.remove_global_event_listener", deprecated_since = "vala-0.16")]
	public static void remove_global_event_listener (uint listener_id);
	[Version (replacement = "Atk.Util.remove_key_event_listener", deprecated_since = "vala-0.16")]
	public static void remove_key_event_listener (uint listener_id);
	[Version (replacement = "Atk.Role.for_name", deprecated_since = "vala-0.16")]
	public static Atk.Role role_for_name (string name);
	[Version (replacement = "Atk.Role.get_localized_name", deprecated_since = "vala-0.16")]
	public static unowned string role_get_localized_name (Atk.Role role);
	[Version (replacement = "Atk.Role.get_name", deprecated_since = "vala-0.16")]
	public static unowned string role_get_name (Atk.Role role);
	[Version (replacement = "Atk.Role.register", deprecated_since = "vala-0.16")]
	public static Atk.Role role_register (string name);
}
