namespace Atk {
	[Compact]
	public class AttributeSet : GLib.SList<Atk.Attribute?> {
	}
	[CCode (cheader_filename = "atk/atk.h", type_id = "atk_implementor_get_type ()")]
	public interface Implementor : GLib.Object {
		public abstract Atk.Object ref_accessible ();
	}
	public class Registry : GLib.Object {
		[Version (deprecated = true)]
		public weak GLib.HashTable<GLib.Type,Atk.ObjectFactory> factory_singleton_cache;
		[Version (deprecated = true)]
		public weak GLib.HashTable<GLib.Type,GLib.Type> factory_type_registry;
	}
	public interface Text : GLib.Object {
		[Version (since = "1.3")]
		[CCode (array_length = false, array_null_terminated = true, cname = "atk_text_get_bounded_ranges")]
		public virtual Atk.TextRange[] get_bounded_ranges (Atk.TextRectangle rect, Atk.CoordType coord_type, Atk.TextClipType x_clip_type, Atk.TextClipType y_clip_type);
	}

	[CCode (cname = "GSignalEmissionHook", has_target = false)]
	public delegate bool SignalEmissionHook (GLib.SignalInvocationHint ihint, [CCode (array_length_pos = 1.9)] Value[] param_values, void* data);
}
