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
}
