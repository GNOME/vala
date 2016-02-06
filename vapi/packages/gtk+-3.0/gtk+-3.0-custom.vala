/* gtk+-2.0.vala
 *
 * Copyright (C) 2006-2008  Jürg Billeter
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public
 * License as published by the Free Software Foundation; either
 * version 2.1 of the License, or (at your option) any later version.

 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * Lesser General Public License for more details.

 * You should have received a copy of the GNU Lesser General Public
 * License along with this library; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301  USA
 *
 * Author:
 * 	Jürg Billeter <j@bitron.ch>
 */

namespace Gtk {
	[CCode (type_id = "gtk_accel_group_get_type ()")]
	public class AccelGroup {
		public Gtk.AccelKey* find (Gtk.AccelGroupFindFunc find_func);
	}

	public struct BindingArg {
		[CCode (cname = "d.long_data")]
		public long long_data;
		[CCode (cname = "d.double_data")]
		public double double_data;
		[CCode (cname = "d.string_data")]
		public weak string string_data;
	}

	public struct Allocation : Gdk.Rectangle {
	}

	[Compact]
	public class BindingSet {
		public static unowned BindingSet @new (string name);
	}

	[CCode (type_id = "gtk_container_get_type ()")]
	public abstract class Container {
		[CCode (vfunc_name = "forall")]
		[NoWrapper]
		public virtual void forall_internal(bool include_internal, Gtk.Callback callback);
		public class unowned GLib.ParamSpec? class_find_child_property (string property_name);
		public class (unowned GLib.ParamSpec)[] class_list_child_properties ();
	}

	public class CssProvider {
		[CCode (cname = "gtk_css_provider_load_from_data")]
		public bool load_from_buffer ([CCode (array_length_cname = "length", array_length_pos = 1.1, array_length_type = "gssize")] uint8[] data) throws GLib.Error;
	}

	[CCode (type_id = "gtk_notebook_get_type ()")]
	public class Notebook {
		public int page_num (Widget child);
	}

	[CCode (type_id = "gtk_status_icon_get_type ()")]
	public class StatusIcon {
		[CCode (instance_pos = -1)]
		public void position_menu (Gtk.Menu menu, ref int x, ref int y, out bool push_in);
	}

	[CCode (type_id = "gtk_ui_manager_get_type ()")]
	public class UIManager {
		public uint new_merge_id ();
	}

	[CCode (type_id = "gtk_widget_get_type ()")]
	public class Widget {
		[CCode (has_new_function = false, construct_function = "gtk_widget_new")]
		public extern Widget (...);
		public class uint activate_signal;
		[CCode (vfunc_name = "get_preferred_height")]
		[NoWrapper]
		public virtual void get_preferred_height_internal (out int minimum_height, out int natural_height);
		[CCode (vfunc_name = "get_preferred_width")]
		[NoWrapper]
		public virtual void get_preferred_width_internal (out int minimum_width, out int natural_width);
		[CCode (vfunc_name = "compute_expand")]
		[NoWrapper]
		public virtual void compute_expand_internal (out bool hexpand, out bool vexpand);
		[CCode (vfunc_name = "get_preferred_width_for_height")]
		[NoWrapper]
		public virtual void get_preferred_width_for_height_internal (int height, out int minimum_width, out int natural_width);
		[CCode (vfunc_name = "get_preferred_height_for_width")]
		[NoWrapper]
		public virtual void get_preferred_height_for_width_internal (int width, out int minimum_height, out int natural_height);
	}

	public interface CellAccessibleParent : GLib.Object {
	}

	[CCode (type_cname = "GtkEditableInterface")]
	public interface Editable : GLib.Object {
		[CCode (vfunc_name = "set_selection_bounds")]
		public abstract void select_region (int start_pos, int end_pos);
	}

	public interface FileChooserEmbed : GLib.Object {
	}

	public interface FileChooser: GLib.Object {
		public GLib.SList<GLib.File> get_files ();
	}

	public interface StyleProvider : GLib.Object {
	}

	public interface TreeDragDest : GLib.Object {
	}

	public interface TreeDragSource : GLib.Object {
	}

	[CCode (cname = "gint")]
	public enum SortColumn {
		[CCode (cname = "GTK_TREE_SORTABLE_DEFAULT_SORT_COLUMN_ID")]
		DEFAULT,
		[CCode (cname = "GTK_TREE_SORTABLE_UNSORTED_SORT_COLUMN_ID")]
		UNSORTED
	}

	[Version (deprecated_since = "3.0", replacement = "StyleContext")]
	[CCode (cheader_filename = "gtk/gtk.h")]
	public class Style {
		[NoWrapper]
		[CCode (instance_pos = -1, vfunc_name = "copy")]
		public virtual void copy_to (Gtk.Style dest);
	}

	[CCode (cheader_filename = "gtk/gtk.h", type_id = "gtk_style_context_get_type ()")]
	public class StyleContext {
		[CCode (cname = "gtk_render_activity")]
		public void render_activity (Cairo.Context cr, double x, double y, double width, double height);
		[CCode (cname = "gtk_render_arrow")]
		public void render_arrow (Cairo.Context cr, double angle, double x, double y, double size);
		[CCode (cname = "gtk_render_background")]
		public void render_background (Cairo.Context cr, double x, double y, double width, double height);
		[CCode (cname = "gtk_render_background_get_clip")]
		public Gdk.Rectangle render_background_get_clip (double x, double y, double width, double height);
		[CCode (cname = "gtk_render_check")]
		public void render_check (Cairo.Context cr, double x, double y, double width, double height);
		[CCode (cname = "gtk_render_expander")]
		public void render_expander (Cairo.Context cr, double x, double y, double width, double height);
		[CCode (cname = "gtk_render_extension")]
		public void render_extension (Cairo.Context cr, double x, double y, double width, double height, Gtk.PositionType gap_side);
		[CCode (cname = "gtk_render_focus")]
		public void render_focus (Cairo.Context cr, double x, double y, double width, double height);
		[CCode (cname = "gtk_render_frame")]
		public void render_frame (Cairo.Context cr, double x, double y, double width, double height);
		[CCode (cname = "gtk_render_frame_gap")]
		public void render_frame_gap (Cairo.Context cr, double x, double y, double width, double height, Gtk.PositionType gap_side, double xy0_gap, double xy1_gap);
		[CCode (cname = "gtk_render_handle")]
		public void render_handle (Cairo.Context cr, double x, double y, double width, double height);
		[CCode (cname = "gtk_render_icon")]
		public void render_icon (Cairo.Context cr, Gdk.Pixbuf pixbuf, double x, double y);
		[CCode (cname = "gtk_render_icon_pixbuf")]
		public Gdk.Pixbuf render_icon_pixbuf (Gtk.IconSource source, Gtk.IconSize size);
		[CCode (cname = "gtk_render_layout")]
		public void render_layout (Cairo.Context cr, double x, double y, Pango.Layout layout);
		[CCode (cname = "gtk_render_line")]
		public void render_line (Cairo.Context cr, double x0, double y0, double x1, double y1);
		[CCode (cname = "gtk_render_option")]
		public void render_option (Cairo.Context cr, double x, double y, double width, double height);
		[CCode (cname = "gtk_render_slider")]
		public void render_slider (Cairo.Context cr, double x, double y, double width, double height, Gtk.Orientation orientation);
	}

	[CCode (type_cname = "GCallback")]
	public delegate void ActionCallback (Action action);

	[CCode (type_cname = "GCallback")]
	public delegate void RadioActionCallback (Action action, Action current);

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

	[Version (deprecated_since = "vala-0.12", replacement = "Gtk.Stock.add")]
	public static void stock_add (Gtk.StockItem[] items);
	[Version (deprecated_since = "vala-0.12", replacement = "Gtk.Stock.add_static")]
	public static void stock_add_static (Gtk.StockItem[] items);
	[Version (deprecated_since = "vala-0.12", replacement = "Gtk.Stock.list_ids")]
	public static GLib.SList<string> stock_list_ids ();

	[Version (deprecated_since = "vala-0.22", replacement = "Gtk.Stock.set_translate_func")]
	public static void stock_set_translate_func (string domain, owned Gtk.TranslateFunc func);

	[Version (deprecated_since = "3.10")]
	[CCode (cheader_filename = "gtk/gtk.h")]
	namespace Stock {
		public static void add (Gtk.StockItem[] items);
		public static void add_static (Gtk.StockItem[] items);
		public static GLib.SList<string> list_ids ();
		public static bool lookup (string stock_id, out Gtk.StockItem item);
		public static void set_translate_func (string domain, owned Gtk.TranslateFunc func);
	}
}
