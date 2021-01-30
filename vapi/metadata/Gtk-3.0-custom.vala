namespace Gtk {
	[CCode (cname = "GCallback")]
	[Version (deprecated_since = "3.10")]
	public delegate void ActionCallback (Action action);
	public delegate bool AccelGroupActivate (Gtk.AccelGroup accel_group, GLib.Object acceleratable, uint keyval, Gdk.ModifierType modifier);
	[CCode (cname = "GCallback")]
	public delegate void RadioActionCallback (Gtk.Action action, Gtk.Action current);

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

	[CCode (type_id = "gtk_container_get_type ()")]
	public abstract class Container : Gtk.Widget {
		[CCode (vfunc_name = "forall")]
		[NoWrapper]
		public virtual void forall_internal (bool include_internal, Gtk.Callback callback);
		[HasEmitter]
		public virtual signal void set_focus_child (Gtk.Widget? child);

		[Version (deprecated_since = "vala-0.40", replacement = "find_child_property")]
		public class unowned GLib.ParamSpec? class_find_child_property (string property_name);
		[Version (deprecated_since = "vala-0.40", replacement = "list_child_properties")]
		public class (unowned GLib.ParamSpec)[] class_list_child_properties ();
	}

	[CCode (type_id = "gtk_container_accessible_get_type ()")]
	public class ContainerAccessible : Gtk.WidgetAccessible {
		[NoWrapper]
		public virtual int add_gtk (Gtk.Widget widget, void* data);
		[NoWrapper]
		public virtual int remove_gtk (Gtk.Widget widget, void* data);
	}

	[CCode (type_id = "gtk_css_provider_get_type ()")]
	public class CssProvider : GLib.Object {
		public bool load_from_data (string data, ssize_t length = -1) throws GLib.Error;
	}

	[CCode (cheader_filename = "gtk/gtk.h", has_copy_function = false, has_destroy_function = false, has_type_id = false)]
	public struct RecentData {
	}

	public class StatusIcon : GLib.Object {
		[CCode (instance_pos = -1)]
		[Version (since = "2.10")]
		public void position_menu (Gtk.Menu menu, ref int x, ref int y, out bool push_in);
	}

	[CCode (type_id = "gtk_style_get_type ()")]
	public class Style : GLib.Object {
		[NoWrapper]
		public virtual Gtk.Style clone ();
		public Gtk.Style copy ();
		[CCode (instance_pos = -1, vfunc_name = "copy")]
		[NoWrapper]
		public virtual void copy_to (Gtk.Style dest);
	}

	[CCode (has_type_id = false)]
	public struct ActionEntry {
		public weak string name;
		public weak string stock_id;
		public weak string label;
		public weak string accelerator;
		public weak string tooltip;
		[CCode (delegate_target = false, type = "GCallback")]
		public weak Gtk.ActionCallback callback;
	}

	[CCode (has_type_id = false)]
	public struct ToggleActionEntry {
		public weak string name;
		public weak string stock_id;
		public weak string label;
		public weak string accelerator;
		public weak string tooltip;
		[CCode (delegate_target = false, type = "GCallback")]
		public weak Gtk.ActionCallback callback;
		public bool is_active;
	}

	[CCode (type_id = "gtk_tree_model_get_type ()")]
	public interface TreeModel : GLib.Object {
		[HasEmitter]
		public virtual signal void rows_reordered (Gtk.TreePath path, Gtk.TreeIter iter, [CCode (array_length = false)] int[] new_order);
	}

	[CCode (type_id = "gtk_widget_get_type ()")]
	public class Widget : GLib.InitiallyUnowned {
		[CCode (construct_function = "gtk_widget_new", has_new_function = false)]
		public Widget (...);
		[NoWrapper, Version (deprecated = true), CCode (vfunc_name = "get_preferred_height_for_width")]
		public virtual void get_preferred_height_for_width_internal (int width, out int minimum_height, out int natural_height);
		[NoWrapper, Version (deprecated = true), CCode (vfunc_name = "get_preferred_height")]
		public virtual void get_preferred_height_internal (out int minimum_height, out int natural_height);
		[NoWrapper, Version (deprecated = true), CCode (vfunc_name = "get_preferred_width_for_height")]
		public virtual void get_preferred_width_for_height_internal (int height, out int minimum_width, out int natural_width);
		[NoWrapper, Version (deprecated = true), CCode (vfunc_name = "get_preferred_width")]
		public virtual void get_preferred_width_internal (out int minimum_width, out int natural_width);
	}

	[CCode (type_id = "gtk_widget_accessible_get_type ()")]
	public class WidgetAccessible : Gtk.Accessible {
		[NoWrapper]
		public virtual void notify_gtk (GLib.ParamSpec pspec);
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

	[Version (deprecated_since = "3.10")]
	public static Gtk.IconSize icon_size_from_name (string name);
	[Version (deprecated_since = "3.10")]
	public static unowned string icon_size_get_name (Gtk.IconSize size);
	public static bool icon_size_lookup (Gtk.IconSize size, out int width, out int height);
	[Version (deprecated_since = "3.10")]
	public static bool icon_size_lookup_for_settings (Gtk.Settings settings, Gtk.IconSize size, out int width, out int height);
	[Version (deprecated_since = "3.10")]
	public static Gtk.IconSize icon_size_register (string name, int width, int height);
	[Version (deprecated_since = "3.10")]
	public static void icon_size_register_alias (string alias, Gtk.IconSize target);

	[CCode (type_id = "gtk_number_up_layout_get_type ()")]
	public enum NumberUpLayout {
		[Version (deprecated_since = "vala-0.40", replacement = "LRTB")]
		LEFT_TO_RIGHT_TOP_TO_BOTTOM,
		[Version (deprecated_since = "vala-0.40", replacement = "LRBT")]
		LEFT_TO_RIGHT_BOTTOM_TO_TOP,
		[Version (deprecated_since = "vala-0.40", replacement = "RLTB")]
		RIGHT_TO_LEFT_TOP_TO_BOTTOM,
		[Version (deprecated_since = "vala-0.40", replacement = "RLBT")]
		RIGHT_TO_LEFT_BOTTOM_TO_TOP,
		[Version (deprecated_since = "vala-0.40", replacement = "TBLR")]
		TOP_TO_BOTTOM_LEFT_TO_RIGHT,
		[Version (deprecated_since = "vala-0.40", replacement = "TBRL")]
		TOP_TO_BOTTOM_RIGHT_TO_LEFT,
		[Version (deprecated_since = "vala-0.40", replacement = "BTLR")]
		BOTTOM_TO_TOP_LEFT_TO_RIGHT,
		[Version (deprecated_since = "vala-0.40", replacement = "BTRL")]
		BOTTOM_TO_TOP_RIGHT_TO_LEFT
	}

	[CCode (cname = "gint", has_type_id = false)]
	public enum SortColumn {
		[CCode (cname = "GTK_TREE_SORTABLE_DEFAULT_SORT_COLUMN_ID")]
		DEFAULT,
		[CCode (cname = "GTK_TREE_SORTABLE_UNSORTED_SORT_COLUMN_ID")]
		UNSORTED
	}

	[Version (deprecated_since = "3.10")]
	[CCode (cheader_filename = "gtk/gtk.h")]
	namespace Stock {
		public static void add (Gtk.StockItem[] items);
		public static void add_static (Gtk.StockItem[] items);
		public static GLib.SList<string> list_ids ();
		public static bool lookup (string stock_id, out Gtk.StockItem item);
		public static void set_translate_func (string domain, owned Gtk.TranslateFunc func);
	}

	public static void render_icon_surface (Gtk.StyleContext context, Cairo.Context cr, Cairo.Surface surface, double x, double y);
	public static void render_insertion_cursor (Gtk.StyleContext context, Cairo.Context cr, double x, double y, Pango.Layout layout, int index, Pango.Direction direction);
}
