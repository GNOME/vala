namespace Gtk {
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

	public interface Editable {
		[NoWrapper]
		public abstract void do_insert_text (string text, int length, ref int position);
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

	[CCode (has_typedef = false)]
	public delegate void BuildableParserStartElementFunc (BuildableParseContext context, string element_name, [CCode (array_length = false, array_null_terminated = true)] string[] attribute_names, [CCode (array_length = false, array_null_terminated = true)] string[] attribute_values) throws GLib.Error;
	[CCode (has_typedef = false)]
	public delegate void BuildableParserEndElementFunc (BuildableParseContext context, string element_name) throws GLib.Error;
	[CCode (has_typedef = false)]
	public delegate void BuildableParserTextFunc (BuildableParseContext context, string text, size_t text_len) throws GLib.Error;
	[CCode (has_typedef = false)]
	public delegate void BuildableParserErrorFunc (BuildableParseContext context, GLib.Error error);

	[CCode (cheader_filename = "gtk/gtk.h", has_type_id = false)]
	public struct BuildableParser {
		[CCode (delegate_target = false)]
		public unowned Gtk.BuildableParserStartElementFunc start_element;
		[CCode (delegate_target = false)]
		public unowned Gtk.BuildableParserEndElementFunc end_element;
		[CCode (delegate_target = false)]
		public unowned Gtk.BuildableParserTextFunc text;
		[CCode (delegate_target = false)]
		public unowned Gtk.BuildableParserErrorFunc error;
	}
}
