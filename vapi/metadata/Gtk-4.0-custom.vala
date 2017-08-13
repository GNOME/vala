namespace Gtk {
	public delegate bool AccelGroupActivate (Gtk.AccelGroup accel_group, GLib.Object acceleratable, uint keyval, Gdk.ModifierType modifier);

	[CCode (has_type_id = false)]
	[Compact]
	class BindingEntry {
		public static void add_signal (Gtk.BindingSet binding_set, uint keyval, Gdk.ModifierType modifiers, string signal_name, uint n_args, ...);
	}

	[CCode (has_type_id = false)]
	[Compact]
	public class BindingSet {
		public static unowned BindingSet @new (string name);
	}

	[CCode (type_id = "gtk_container_accessible_get_type ()")]
	public class ContainerAccessible : Gtk.WidgetAccessible {
		[NoWrapper]
		public virtual int add_gtk (Gtk.Widget widget, void* data);
		[NoWrapper]
		public virtual int remove_gtk (Gtk.Widget widget, void* data);
	}

	[CCode (cheader_filename = "gtk/gtk.h", has_copy_function = false, has_destroy_function = false, has_type_id = false)]
	public struct RecentData {
	}

	[CCode (type_id = "gtk_tree_model_get_type ()")]
	public interface TreeModel : GLib.Object {
		[HasEmitter]
		public virtual signal void rows_reordered (Gtk.TreePath path, Gtk.TreeIter iter, [CCode (array_length = false)] int[] new_order);
	}

	[CCode (type_id = "gtk_widget_accessible_get_type ()")]
	public class WidgetAccessible : Gtk.Accessible {
		[NoWrapper]
		public virtual void notify_gtk (GLib.ParamSpec pspec);
	}

	[CCode (type_id = "gtk_editable_get_type ()")]
	public interface Editable : GLib.Object {
		[NoWrapper]
		public abstract void do_insert_text (string new_text, int new_text_length, ref int position);
		[NoWrapper]
		public abstract void do_delete_text (int start_pos, int end_pos);
	}

	[CCode (has_type_id = false)]
	public struct BindingArg {
		[CCode (cname = "d.long_data")]
		public long long_data;
		[CCode (cname = "d.double_data")]
		public double double_data;
		[CCode (cname = "d.string_data")]
		public weak string string_data;
	}
}
