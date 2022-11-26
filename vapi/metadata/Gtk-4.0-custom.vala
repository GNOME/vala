namespace Gtk {
	[CCode (cheader_filename = "gtk/gtk.h", has_copy_function = false, has_destroy_function = false, has_type_id = false)]
	public struct RecentData {
	}

	[CCode (type_id = "gtk_tree_model_get_type ()")]
	public interface TreeModel : GLib.Object {
		[HasEmitter]
		public virtual signal void rows_reordered (Gtk.TreePath path, Gtk.TreeIter iter, [CCode (array_length = false)] int[] new_order);
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

	public class DropTarget : Gtk.EventController {
		[CCode (cname = "drop")]
		[Version (replacement = "DropTarget.drop", deprecated_since = "vala-0.58")]
		public signal bool on_drop (GLib.Value value, double x, double y);
	}
}
