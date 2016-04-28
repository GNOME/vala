namespace Gtk {
	[CCode (type_cname = "GCallback")]
	[Version (deprecated_since = "3.10")]
	public delegate void ActionCallback (Action action);
	public delegate bool AccelGroupActivate (Gtk.AccelGroup accel_group, GLib.Object acceleratable, uint keyval, Gdk.ModifierType modifier);
	[CCode (type_cname = "GCallback")]
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

	[CCode (cheader_filename = "gtk/gtk.h", copy_function = "gtk_icon_info_copy", free_function = "gtk_icon_info_free", type_id = "gtk_icon_info_get_type ()")]
	[Compact]
	public class IconInfo {
	}

	[CCode (cheader_filename = "gtk/gtk.h", has_copy_function = false, has_destroy_function = false, has_type_id = false)]
	public struct RecentData {
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
	public class Widget : GLib.Object {
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

	[Version (deprecated_since = "vala-0.12", replacement = "Gtk.Stock.ABOUT")]
	public const string STOCK_ABOUT;
	[Version (deprecated_since = "vala-0.12", replacement = "Gtk.Stock.ADD")]
	public const string STOCK_ADD;
	[Version (deprecated_since = "vala-0.12", replacement = "Gtk.Stock.APPLY")]
	public const string STOCK_APPLY;
	[Version (deprecated_since = "vala-0.12", replacement = "Gtk.Stock.BOLD")]
	public const string STOCK_BOLD;
	[Version (deprecated_since = "vala-0.12", replacement = "Gtk.Stock.CANCEL")]
	public const string STOCK_CANCEL;
	[Version (deprecated_since = "vala-0.12", replacement = "Gtk.Stock.CAPS_LOCK_WARNING")]
	public const string STOCK_CAPS_LOCK_WARNING;
	[Version (deprecated_since = "vala-0.12", replacement = "Gtk.Stock.CDROM")]
	public const string STOCK_CDROM;
	[Version (deprecated_since = "vala-0.12", replacement = "Gtk.Stock.CLEAR")]
	public const string STOCK_CLEAR;
	[Version (deprecated_since = "vala-0.12", replacement = "Gtk.Stock.CLOSE")]
	public const string STOCK_CLOSE;
	[Version (deprecated_since = "vala-0.12", replacement = "Gtk.Stock.COLOR_PICKER")]
	public const string STOCK_COLOR_PICKER;
	[Version (deprecated_since = "vala-0.12", replacement = "Gtk.Stock.CONNECT")]
	public const string STOCK_CONNECT;
	[Version (deprecated_since = "vala-0.12", replacement = "Gtk.Stock.CONVERT")]
	public const string STOCK_CONVERT;
	[Version (deprecated_since = "vala-0.12", replacement = "Gtk.Stock.COPY")]
	public const string STOCK_COPY;
	[Version (deprecated_since = "vala-0.12", replacement = "Gtk.Stock.CUT")]
	public const string STOCK_CUT;
	[Version (deprecated_since = "vala-0.12", replacement = "Gtk.Stock.DELETE")]
	public const string STOCK_DELETE;
	[Version (deprecated_since = "vala-0.12", replacement = "Gtk.Stock.DIALOG_AUTHENTICATION")]
	public const string STOCK_DIALOG_AUTHENTICATION;
	[Version (deprecated_since = "vala-0.12", replacement = "Gtk.Stock.DIALOG_ERROR")]
	public const string STOCK_DIALOG_ERROR;
	[Version (deprecated_since = "vala-0.12", replacement = "Gtk.Stock.DIALOG_INFO")]
	public const string STOCK_DIALOG_INFO;
	[Version (deprecated_since = "vala-0.12", replacement = "Gtk.Stock.DIALOG_QUESTION")]
	public const string STOCK_DIALOG_QUESTION;
	[Version (deprecated_since = "vala-0.12", replacement = "Gtk.Stock.DIALOG_WARNING")]
	public const string STOCK_DIALOG_WARNING;
	[Version (deprecated_since = "vala-0.12", replacement = "Gtk.Stock.DIRECTORY")]
	public const string STOCK_DIRECTORY;
	[Version (deprecated_since = "vala-0.12", replacement = "Gtk.Stock.DISCARD")]
	public const string STOCK_DISCARD;
	[Version (deprecated_since = "vala-0.12", replacement = "Gtk.Stock.DISCONNECT")]
	public const string STOCK_DISCONNECT;
	[Version (deprecated_since = "vala-0.12", replacement = "Gtk.Stock.DND")]
	public const string STOCK_DND;
	[Version (deprecated_since = "vala-0.12", replacement = "Gtk.Stock.DND_MULTIPLE")]
	public const string STOCK_DND_MULTIPLE;
	[Version (deprecated_since = "vala-0.12", replacement = "Gtk.Stock.EDIT")]
	public const string STOCK_EDIT;
	[Version (deprecated_since = "vala-0.12", replacement = "Gtk.Stock.EXECUTE")]
	public const string STOCK_EXECUTE;
	[Version (deprecated_since = "vala-0.12", replacement = "Gtk.Stock.FILE")]
	public const string STOCK_FILE;
	[Version (deprecated_since = "vala-0.12", replacement = "Gtk.Stock.FIND")]
	public const string STOCK_FIND;
	[Version (deprecated_since = "vala-0.12", replacement = "Gtk.Stock.FIND_AND_REPLACE")]
	public const string STOCK_FIND_AND_REPLACE;
	[Version (deprecated_since = "vala-0.12", replacement = "Gtk.Stock.FLOPPY")]
	public const string STOCK_FLOPPY;
	[Version (deprecated_since = "vala-0.12", replacement = "Gtk.Stock.FULLSCREEN")]
	public const string STOCK_FULLSCREEN;
	[Version (deprecated_since = "vala-0.12", replacement = "Gtk.Stock.GOTO_BOTTOM")]
	public const string STOCK_GOTO_BOTTOM;
	[Version (deprecated_since = "vala-0.12", replacement = "Gtk.Stock.GOTO_FIRST")]
	public const string STOCK_GOTO_FIRST;
	[Version (deprecated_since = "vala-0.12", replacement = "Gtk.Stock.GOTO_LAST")]
	public const string STOCK_GOTO_LAST;
	[Version (deprecated_since = "vala-0.12", replacement = "Gtk.Stock.GOTO_TOP")]
	public const string STOCK_GOTO_TOP;
	[Version (deprecated_since = "vala-0.12", replacement = "Gtk.Stock.GO_BACK")]
	public const string STOCK_GO_BACK;
	[Version (deprecated_since = "vala-0.12", replacement = "Gtk.Stock.GO_DOWN")]
	public const string STOCK_GO_DOWN;
	[Version (deprecated_since = "vala-0.12", replacement = "Gtk.Stock.GO_FORWARD")]
	public const string STOCK_GO_FORWARD;
	[Version (deprecated_since = "vala-0.12", replacement = "Gtk.Stock.GO_UP")]
	public const string STOCK_GO_UP;
	[Version (deprecated_since = "vala-0.12", replacement = "Gtk.Stock.HARDDISK")]
	public const string STOCK_HARDDISK;
	[Version (deprecated_since = "vala-0.12", replacement = "Gtk.Stock.HELP")]
	public const string STOCK_HELP;
	[Version (deprecated_since = "vala-0.12", replacement = "Gtk.Stock.HOME")]
	public const string STOCK_HOME;
	[Version (deprecated_since = "vala-0.12", replacement = "Gtk.Stock.INDENT")]
	public const string STOCK_INDENT;
	[Version (deprecated_since = "vala-0.12", replacement = "Gtk.Stock.INDEX")]
	public const string STOCK_INDEX;
	[Version (deprecated_since = "vala-0.12", replacement = "Gtk.Stock.INFO")]
	public const string STOCK_INFO;
	[Version (deprecated_since = "vala-0.12", replacement = "Gtk.Stock.ITALIC")]
	public const string STOCK_ITALIC;
	[Version (deprecated_since = "vala-0.12", replacement = "Gtk.Stock.JUMP_TO")]
	public const string STOCK_JUMP_TO;
	[Version (deprecated_since = "vala-0.12", replacement = "Gtk.Stock.JUSTIFY_CENTER")]
	public const string STOCK_JUSTIFY_CENTER;
	[Version (deprecated_since = "vala-0.12", replacement = "Gtk.Stock.JUSTIFY_FILL")]
	public const string STOCK_JUSTIFY_FILL;
	[Version (deprecated_since = "vala-0.12", replacement = "Gtk.Stock.JUSTIFY_LEFT")]
	public const string STOCK_JUSTIFY_LEFT;
	[Version (deprecated_since = "vala-0.12", replacement = "Gtk.Stock.JUSTIFY_RIGHT")]
	public const string STOCK_JUSTIFY_RIGHT;
	[Version (deprecated_since = "vala-0.12", replacement = "Gtk.Stock.FULLSCREEN")]
	public const string STOCK_LEAVE_FULLSCREEN;
	[Version (deprecated_since = "vala-0.12", replacement = "Gtk.Stock.MEDIA_FORWARD")]
	public const string STOCK_MEDIA_FORWARD;
	[Version (deprecated_since = "vala-0.12", replacement = "Gtk.Stock.MEDIA_NEXT")]
	public const string STOCK_MEDIA_NEXT;
	[Version (deprecated_since = "vala-0.12", replacement = "Gtk.Stock.MEDIA_PAUSE")]
	public const string STOCK_MEDIA_PAUSE;
	[Version (deprecated_since = "vala-0.12", replacement = "Gtk.Stock.MEDIA_PLAY")]
	public const string STOCK_MEDIA_PLAY;
	[Version (deprecated_since = "vala-0.12", replacement = "Gtk.Stock.MEDIA_PREVIOUS")]
	public const string STOCK_MEDIA_PREVIOUS;
	[Version (deprecated_since = "vala-0.12", replacement = "Gtk.Stock.MEDIA_RECORD")]
	public const string STOCK_MEDIA_RECORD;
	[Version (deprecated_since = "vala-0.12", replacement = "Gtk.Stock.MEDIA_REWIND")]
	public const string STOCK_MEDIA_REWIND;
	[Version (deprecated_since = "vala-0.12", replacement = "Gtk.Stock.MEDIA_STOP")]
	public const string STOCK_MEDIA_STOP;
	[Version (deprecated_since = "vala-0.12", replacement = "Gtk.Stock.MISSING_IMAGE")]
	public const string STOCK_MISSING_IMAGE;
	[Version (deprecated_since = "vala-0.12", replacement = "Gtk.Stock.NETWORK")]
	public const string STOCK_NETWORK;
	[Version (deprecated_since = "vala-0.12", replacement = "Gtk.Stock.NEW")]
	public const string STOCK_NEW;
	[Version (deprecated_since = "vala-0.12", replacement = "Gtk.Stock.NO")]
	public const string STOCK_NO;
	[Version (deprecated_since = "vala-0.12", replacement = "Gtk.Stock.OK")]
	public const string STOCK_OK;
	[Version (deprecated_since = "vala-0.12", replacement = "Gtk.Stock.OPEN")]
	public const string STOCK_OPEN;
	[Version (deprecated_since = "vala-0.12", replacement = "Gtk.Stock.ORIENTATION_LANDSCAPE")]
	public const string STOCK_ORIENTATION_LANDSCAPE;
	[Version (deprecated_since = "vala-0.12", replacement = "Gtk.Stock.ORIENTATION_PORTRAIT")]
	public const string STOCK_ORIENTATION_PORTRAIT;
	[Version (deprecated_since = "vala-0.12", replacement = "Gtk.Stock.ORIENTATION_REVERSE_LANDSCAPE")]
	public const string STOCK_ORIENTATION_REVERSE_LANDSCAPE;
	[Version (deprecated_since = "vala-0.12", replacement = "Gtk.Stock.ORIENTATION_REVERSE_PORTRAIT")]
	public const string STOCK_ORIENTATION_REVERSE_PORTRAIT;
	[Version (deprecated_since = "vala-0.12", replacement = "Gtk.Stock.PAGE_SETUP")]
	public const string STOCK_PAGE_SETUP;
	[Version (deprecated_since = "vala-0.12", replacement = "Gtk.Stock.PASTE")]
	public const string STOCK_PASTE;
	[Version (deprecated_since = "vala-0.12", replacement = "Gtk.Stock.PREFERENCES")]
	public const string STOCK_PREFERENCES;
	[Version (deprecated_since = "vala-0.12", replacement = "Gtk.Stock.PRINT")]
	public const string STOCK_PRINT;
	[Version (deprecated_since = "vala-0.12", replacement = "Gtk.Stock.PRINT_ERROR")]
	public const string STOCK_PRINT_ERROR;
	[Version (deprecated_since = "vala-0.12", replacement = "Gtk.Stock.PRINT_PAUSED")]
	public const string STOCK_PRINT_PAUSED;
	[Version (deprecated_since = "vala-0.12", replacement = "Gtk.Stock.PRINT_PREVIEW")]
	public const string STOCK_PRINT_PREVIEW;
	[Version (deprecated_since = "vala-0.12", replacement = "Gtk.Stock.PRINT_REPORT")]
	public const string STOCK_PRINT_REPORT;
	[Version (deprecated_since = "vala-0.12", replacement = "Gtk.Stock.PRINT_WARNING")]
	public const string STOCK_PRINT_WARNING;
	[Version (deprecated_since = "vala-0.12", replacement = "Gtk.Stock.PROPERTIES")]
	public const string STOCK_PROPERTIES;
	[Version (deprecated_since = "vala-0.12", replacement = "Gtk.Stock.QUIT")]
	public const string STOCK_QUIT;
	[Version (deprecated_since = "vala-0.12", replacement = "Gtk.Stock.REDO")]
	public const string STOCK_REDO;
	[Version (deprecated_since = "vala-0.12", replacement = "Gtk.Stock.REFRESH")]
	public const string STOCK_REFRESH;
	[Version (deprecated_since = "vala-0.12", replacement = "Gtk.Stock.REMOVE")]
	public const string STOCK_REMOVE;
	[Version (deprecated_since = "vala-0.12", replacement = "Gtk.Stock.REVERT_TO_SAVED")]
	public const string STOCK_REVERT_TO_SAVED;
	[Version (deprecated_since = "vala-0.12", replacement = "Gtk.Stock.SAVE")]
	public const string STOCK_SAVE;
	[Version (deprecated_since = "vala-0.12", replacement = "Gtk.Stock.SAVE_AS")]
	public const string STOCK_SAVE_AS;
	[Version (deprecated_since = "vala-0.12", replacement = "Gtk.Stock.SELECT_ALL")]
	public const string STOCK_SELECT_ALL;
	[Version (deprecated_since = "vala-0.12", replacement = "Gtk.Stock.SELECT_COLOR")]
	public const string STOCK_SELECT_COLOR;
	[Version (deprecated_since = "vala-0.12", replacement = "Gtk.Stock.SELECT_FONT")]
	public const string STOCK_SELECT_FONT;
	[Version (deprecated_since = "vala-0.12", replacement = "Gtk.Stock.SORT_ASCENDING")]
	public const string STOCK_SORT_ASCENDING;
	[Version (deprecated_since = "vala-0.12", replacement = "Gtk.Stock.SORT_DESCENDING")]
	public const string STOCK_SORT_DESCENDING;
	[Version (deprecated_since = "vala-0.12", replacement = "Gtk.Stock.SPELL_CHECK")]
	public const string STOCK_SPELL_CHECK;
	[Version (deprecated_since = "vala-0.12", replacement = "Gtk.Stock.STOP")]
	public const string STOCK_STOP;
	[Version (deprecated_since = "vala-0.12", replacement = "Gtk.Stock.STRIKETHROUGH")]
	public const string STOCK_STRIKETHROUGH;
	[Version (deprecated_since = "vala-0.12", replacement = "Gtk.Stock.UNDELETE")]
	public const string STOCK_UNDELETE;
	[Version (deprecated_since = "vala-0.12", replacement = "Gtk.Stock.UNDERLINE")]
	public const string STOCK_UNDERLINE;
	[Version (deprecated_since = "vala-0.12", replacement = "Gtk.Stock.UNDO")]
	public const string STOCK_UNDO;
	[Version (deprecated_since = "vala-0.12", replacement = "Gtk.Stock.UNINDENT")]
	public const string STOCK_UNINDENT;
	[Version (deprecated_since = "vala-0.12", replacement = "Gtk.Stock.YES")]
	public const string STOCK_YES;
	[Version (deprecated_since = "vala-0.12", replacement = "Gtk.Stock.ZOOM_100")]
	public const string STOCK_ZOOM_100;
	[Version (deprecated_since = "vala-0.12", replacement = "Gtk.Stock.ZOOM_FIT")]
	public const string STOCK_ZOOM_FIT;
	[Version (deprecated_since = "vala-0.12", replacement = "Gtk.Stock.ZOOM_IN")]
	public const string STOCK_ZOOM_IN;
	[Version (deprecated_since = "vala-0.12", replacement = "Gtk.Stock.ZOOM_OUT")]
	public const string STOCK_ZOOM_OUT;

	[Version (deprecated_since = "3.10")]
	[CCode (cheader_filename = "gtk/gtk.h")]
	namespace Stock {
		public static void add (Gtk.StockItem[] items);
		public static void add_static (Gtk.StockItem[] items);
		public static GLib.SList<string> list_ids ();
		public static bool lookup (string stock_id, out Gtk.StockItem item);
		public static void set_translate_func (string domain, owned Gtk.TranslateFunc func);
	}

	[Version (deprecated_since = "vala-0.16", replacement = "StyleContext.render_focus")]
	public static void render_focus (Gtk.StyleContext context, Cairo.Context cr, double x, double y, double width, double height);
	[Version (deprecated_since = "vala-0.16", replacement = "StyleContext.render_frame")]
	public static void render_frame (Gtk.StyleContext context, Cairo.Context cr, double x, double y, double width, double height);
	[Version (deprecated_since = "vala-0.16", replacement = "StyleContext.render_frame_gap")]
	public static void render_frame_gap (Gtk.StyleContext context, Cairo.Context cr, double x, double y, double width, double height, Gtk.PositionType gap_side, double xy0_gap, double xy1_gap);
	[Version (deprecated_since = "vala-0.16", replacement = "StyleContext.render_handle")]
	public static void render_handle (Gtk.StyleContext context, Cairo.Context cr, double x, double y, double width, double height);
	[Version (deprecated_since = "vala-0.16", replacement = "StyleContext.render_icon")]
	public static void render_icon (Gtk.StyleContext context, Cairo.Context cr, Gdk.Pixbuf pixbuf, double x, double y);
	[Version (deprecated_since = "vala-0.16", replacement = "StyleContext.render_icon_pixbuf")]
	public static Gdk.Pixbuf render_icon_pixbuf (Gtk.StyleContext context, Gtk.IconSource source, Gtk.IconSize size);
	public static void render_icon_surface (Gtk.StyleContext context, Cairo.Context cr, Cairo.Surface surface, double x, double y);
	public static void render_insertion_cursor (Gtk.StyleContext context, Cairo.Context cr, double x, double y, Pango.Layout layout, int index, Pango.Direction direction);
	[Version (deprecated_since = "vala-0.16", replacement = "StyleContext.render_layout")]
	public static void render_layout (Gtk.StyleContext context, Cairo.Context cr, double x, double y, Pango.Layout layout);
	[Version (deprecated_since = "vala-0.16", replacement = "StyleContext.render_activity")]
	public static void render_activity (Gtk.StyleContext context, Cairo.Context cr, double x, double y, double width, double height);
	[Version (deprecated_since = "vala-0.16", replacement = "StyleContext.render_arrow")]
	public static void render_arrow (Gtk.StyleContext context, Cairo.Context cr, double angle, double x, double y, double size);
	[Version (deprecated_since = "vala-0.16", replacement = "StyleContext.render_background")]
	public static void render_background (Gtk.StyleContext context, Cairo.Context cr, double x, double y, double width, double height);
	[Version (deprecated_since = "vala-0.16", replacement = "StyleContext.render_check")]
	public static void render_check (Gtk.StyleContext context, Cairo.Context cr, double x, double y, double width, double height);
	[Version (deprecated_since = "vala-0.16", replacement = "StyleContext.render_expander")]
	public static void render_expander (Gtk.StyleContext context, Cairo.Context cr, double x, double y, double width, double height);
	[Version (deprecated_since = "vala-0.16", replacement = "StyleContext.render_extension")]
	public static void render_extension (Gtk.StyleContext context, Cairo.Context cr, double x, double y, double width, double height, Gtk.PositionType gap_side);
	[Version (deprecated_since = "vala-0.16", replacement = "StyleContext.render_line")]
	public static void render_line (Gtk.StyleContext context, Cairo.Context cr, double x0, double y0, double x1, double y1);
	[CCode (cheader_filename = "gtk/gtk.h")]
	[Version (deprecated_since = "vala-0.16", replacement = "StyleContext.render_option")]
	public static void render_option (Gtk.StyleContext context, Cairo.Context cr, double x, double y, double width, double height);
	[CCode (cheader_filename = "gtk/gtk.h")]
	[Version (deprecated_since = "vala-0.16", replacement = "StyleContext.render_slider")]
	public static void render_slider (Gtk.StyleContext context, Cairo.Context cr, double x, double y, double width, double height, Gtk.Orientation orientation);
}
