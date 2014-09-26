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
	public class AboutDialog {
		public static void set_email_hook (owned Gtk.AboutDialogActivateLinkFunc func);
		public static void set_url_hook (owned Gtk.AboutDialogActivateLinkFunc func);
	}

	public class AccelGroup {
		public Gtk.AccelKey* find (Gtk.AccelGroupFindFunc find_func);
	}

	public struct Allocation : Gdk.Rectangle {
	}

	[Compact]
	public class BindingSet {
		public static unowned BindingSet @new (string name);
	}

	[CCode (cheader_filename = "gtk/gtk.h")]
	public class ComboBoxEntry : Gtk.ComboBox, Atk.Implementor, Gtk.Buildable, Gtk.CellEditable, Gtk.CellLayout {
		[CCode (has_construct_function = false, type = "GtkWidget*")]
		public ComboBoxEntry ();
		public int get_text_column ();
		public void set_text_column (int text_column);
		[CCode (has_construct_function = false, type = "GtkWidget*")]
		public ComboBoxEntry.text ();
		[CCode (has_construct_function = false, type = "GtkWidget*")]
		public ComboBoxEntry.with_model (Gtk.TreeModel model, int text_column);
		public int text_column { get; set; }
	}

	public class Container {
		[CCode (vfunc_name = "forall")]
		public virtual void forall_internal(bool include_internal, Gtk.Callback callback);
	}

	[CCode (cheader_filename = "gtk/gtk.h")]
	public class Curve : Gtk.DrawingArea, Atk.Implementor, Gtk.Buildable {
		[CCode (array_length = false)]
		public weak float[] ctlpoint;
		public int cursor_type;
		public int grab_point;
		public int height;
		public int last;
		public int num_ctlpoints;
		public int num_points;
		public weak Gdk.Pixmap pixmap;
		public Gdk.Point point;
		[CCode (has_construct_function = false, type = "GtkWidget*")]
		public Curve ();
		public void get_vector (int veclen, float[] vector);
		public void reset ();
		public void set_curve_type (Gtk.CurveType type);
		public void set_gamma (float gamma_);
		public void set_range (float min_x, float max_x, float min_y, float max_y);
		public void set_vector (int veclen, float[] vector);
		[NoAccessorMethod]
		public Gtk.CurveType curve_type { get; set; }
		[NoAccessorMethod]
		public float max_x { get; set; }
		[NoAccessorMethod]
		public float max_y { get; set; }
		[NoAccessorMethod]
		public float min_x { get; set; }
		[NoAccessorMethod]
		public float min_y { get; set; }
		public virtual signal void curve_type_changed ();
	}

	public class Fixed {
		public bool get_has_window ();
		public void set_has_window (bool has_window);
	}

	[CCode (cheader_filename = "gtk/gtk.h")]
	public class GammaCurve : Gtk.VBox, Atk.Implementor, Gtk.Buildable, Gtk.Orientable {
		[CCode (array_length = false)]
		public weak Gtk.Widget[] button;
		public weak Gtk.Widget curve;
		public float gamma;
		public weak Gtk.Widget gamma_dialog;
		public weak Gtk.Widget gamma_text;
		public weak Gtk.Widget table;
		[CCode (has_construct_function = false, type = "GtkWidget*")]
		public GammaCurve ();
	}

	[CCode (cheader_filename = "gtk/gtk.h")]
	public class HRuler : Gtk.Ruler, Atk.Implementor, Gtk.Buildable, Gtk.Orientable {
		[CCode (has_construct_function = false, type = "GtkWidget*")]
		public HRuler ();
	}

	[CCode (cheader_filename = "gtk/gtk.h")]
	public class InputDialog : Gtk.Dialog, Atk.Implementor, Gtk.Buildable {
		[CCode (array_length = false)]
		public weak Gtk.Widget[] axis_items;
		public weak Gtk.Widget axis_list;
		public weak Gtk.Widget axis_listbox;
		public weak Gtk.Widget close_button;
		public weak Gdk.Device current_device;
		public weak Gtk.Widget keys_list;
		public weak Gtk.Widget keys_listbox;
		public weak Gtk.Widget mode_optionmenu;
		public weak Gtk.Widget save_button;
		[CCode (has_construct_function = false, type = "GtkWidget*")]
		public InputDialog ();
		public virtual signal void disable_device (Gdk.Device device);
		public virtual signal void enable_device (Gdk.Device device);
	}

	public class LinkButton {
		public static void set_uri_hook (owned Gtk.LinkButtonUriFunc func);
	}

	public class Notebook {
		public void* get_group ();
		public int page_num (Widget child);
		public void query_tab_label_packing (Gtk.Widget child, bool? expand, bool? fill, Gtk.PackType? pack_type);
		public void set_group (void* group);
		public void set_tab_label_packing (Gtk.Widget child, bool expand, bool fill, Gtk.PackType pack_type);
		public static void set_window_creation_hook (owned Gtk.NotebookWindowCreationFunc func);
	}

	public class Range {
		public Gtk.UpdateType get_update_policy ();
		public void set_update_policy (Gtk.UpdateType policy);
	}

	[CCode (cheader_filename = "gtk/gtk.h")]
	public class Ruler : Gtk.Widget, Atk.Implementor, Gtk.Buildable, Gtk.Orientable {
		public weak Gdk.Pixmap backing_store;
		public weak Gdk.GC non_gr_exp_gc;
		public int slider_size;
		public int xsrc;
		public int ysrc;
		[CCode (has_construct_function = false)]
		protected Ruler ();
		public virtual void draw_pos ();
		public virtual void draw_ticks ();
		public Gtk.MetricType get_metric ();
		public void get_range (double lower, double upper, double position, double max_size);
		public void set_metric (Gtk.MetricType metric);
		public void set_range (double lower, double upper, double position, double max_size);
		[NoAccessorMethod]
		public double lower { get; set; }
		[NoAccessorMethod]
		public double max_size { get; set; }
		public Gtk.MetricType metric { get; set; }
		[NoAccessorMethod]
		public double position { get; set; }
		[NoAccessorMethod]
		public double upper { get; set; }
	}

	[CCode (cheader_filename = "gtk/gtk.h")]
	[Compact]
	public class RulerMetric {
		public weak string abbrev;
		public weak string metric_name;
		public double pixels_per_unit;
		[CCode (array_length = false)]
		public weak double[] ruler_scale;
		[CCode (array_length = false)]
		public weak int[] subdivide;
	}

	public class StatusIcon {
		[CCode (instance_pos = -1)]
		public void position_menu (Gtk.Menu menu, out int x, out int y, out bool push_in);
	}

	public class UIManager {
		public uint new_merge_id ();
	}

	[CCode (cheader_filename = "gtk/gtk.h")]
	public class VRuler : Gtk.Ruler, Atk.Implementor, Gtk.Buildable, Gtk.Orientable {
		[CCode (has_construct_function = false, type = "GtkWidget*")]
		public VRuler ();
	}

	public class Widget {
		[CCode (has_new_function = false, construct_function = "gtk_widget_new")]
		public extern Widget (...);

		[CCode (cname = "GTK_WIDGET_FLAGS")]
		public extern WidgetFlags get_flags ();

		[CCode (cname = "GTK_WIDGET_TOPLEVEL")]
		public extern bool is_toplevel ();

		[CCode (cname = "GTK_WIDGET_NO_WINDOW")]
		public extern bool is_no_window ();

		[CCode (cname = "GTK_WIDGET_REALIZED")]
		public extern bool is_realized ();

		[CCode (cname = "GTK_WIDGET_MAPPED")]
		public extern bool is_mapped ();

 		[CCode (cname = "GTK_WIDGET_DRAWABLE")]
		public extern bool is_drawable ();

 		[CCode (cname = "GTK_WIDGET_PARENT_SENSITIVE")]
		public extern bool is_parent_sensitive ();    
    
 		[CCode (cname = "GTK_WIDGET_HAS_GRAB")]
		public extern bool has_grab ();

 		[CCode (cname = "GTK_WIDGET_RC_STYLE")]
		public extern bool is_rc_style ();

 		[CCode (cname = "GTK_WIDGET_DOUBLE_BUFFERED")]
		public extern bool is_double_buffered ();    

 		[CCode (cname = "GTK_WIDGET_SET_FLAGS")]
		public extern void set_flags (WidgetFlags flags);

		[CCode (cname = "GTK_WIDGET_UNSET_FLAGS")]
		public extern void unset_flags (WidgetFlags flags);

		public class uint set_scroll_adjustments_signal;
	}

	public class Window {
		public void get_frame_dimensions (int left, int top, int right, int bottom);
		public bool get_has_frame ();
		public void set_frame_dimensions (int left, int top, int right, int bottom);
		public void set_has_frame (bool setting);
	}

	public interface Editable : GLib.Object {
		[CCode (vfunc_name = "set_selection_bounds")]
		public abstract void select_region (int start_pos, int end_pos);
	}

	public interface FileChooserEmbed : GLib.Object {
	}

	public interface FileChooser: Gtk.Widget {
		public GLib.SList<GLib.File> get_files ();
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

	[CCode (cheader_filename = "gtk/gtk.h")]
	public class Style {
		[NoWrapper]
		[CCode (instance_pos = -1, vfunc_name = "copy")]
		public virtual void copy_to (Gtk.Style dest);
	}

	[CCode (has_target = false)]
	public delegate void CallbackMarshal (Object object, void* data, Arg[] args);

	[CCode (type_cname = "GCallback")]
	public delegate void ActionCallback (Action action);

	[CCode (type_cname = "GCallback")]
	public delegate void RadioActionCallback (Action action, Action current);

	[CCode (cheader_filename = "gtk/gtk.h")]
	public static unowned string set_locale ();

	[Deprecated (since = "vala-0.12", replacement = "Gtk.Stock.ABOUT")]
	public const string STOCK_ABOUT;
	[Deprecated (since = "vala-0.12", replacement = "Gtk.Stock.ADD")]
	public const string STOCK_ADD;
	[Deprecated (since = "vala-0.12", replacement = "Gtk.Stock.APPLY")]
	public const string STOCK_APPLY;
	[Deprecated (since = "vala-0.12", replacement = "Gtk.Stock.BOLD")]
	public const string STOCK_BOLD;
	[Deprecated (since = "vala-0.12", replacement = "Gtk.Stock.CANCEL")]
	public const string STOCK_CANCEL;
	[Deprecated (since = "vala-0.12", replacement = "Gtk.Stock.CAPS_LOCK_WARNING")]
	public const string STOCK_CAPS_LOCK_WARNING;
	[Deprecated (since = "vala-0.12", replacement = "Gtk.Stock.CDROM")]
	public const string STOCK_CDROM;
	[Deprecated (since = "vala-0.12", replacement = "Gtk.Stock.CLEAR")]
	public const string STOCK_CLEAR;
	[Deprecated (since = "vala-0.12", replacement = "Gtk.Stock.CLOSE")]
	public const string STOCK_CLOSE;
	[Deprecated (since = "vala-0.12", replacement = "Gtk.Stock.COLOR_PICKER")]
	public const string STOCK_COLOR_PICKER;
	[Deprecated (since = "vala-0.12", replacement = "Gtk.Stock.CONNECT")]
	public const string STOCK_CONNECT;
	[Deprecated (since = "vala-0.12", replacement = "Gtk.Stock.CONVERT")]
	public const string STOCK_CONVERT;
	[Deprecated (since = "vala-0.12", replacement = "Gtk.Stock.COPY")]
	public const string STOCK_COPY;
	[Deprecated (since = "vala-0.12", replacement = "Gtk.Stock.CUT")]
	public const string STOCK_CUT;
	[Deprecated (since = "vala-0.12", replacement = "Gtk.Stock.DELETE")]
	public const string STOCK_DELETE;
	[Deprecated (since = "vala-0.12", replacement = "Gtk.Stock.DIALOG_AUTHENTICATION")]
	public const string STOCK_DIALOG_AUTHENTICATION;
	[Deprecated (since = "vala-0.12", replacement = "Gtk.Stock.DIALOG_ERROR")]
	public const string STOCK_DIALOG_ERROR;
	[Deprecated (since = "vala-0.12", replacement = "Gtk.Stock.DIALOG_INFO")]
	public const string STOCK_DIALOG_INFO;
	[Deprecated (since = "vala-0.12", replacement = "Gtk.Stock.DIALOG_QUESTION")]
	public const string STOCK_DIALOG_QUESTION;
	[Deprecated (since = "vala-0.12", replacement = "Gtk.Stock.DIALOG_WARNING")]
	public const string STOCK_DIALOG_WARNING;
	[Deprecated (since = "vala-0.12", replacement = "Gtk.Stock.DIRECTORY")]
	public const string STOCK_DIRECTORY;
	[Deprecated (since = "vala-0.12", replacement = "Gtk.Stock.DISCARD")]
	public const string STOCK_DISCARD;
	[Deprecated (since = "vala-0.12", replacement = "Gtk.Stock.DISCONNECT")]
	public const string STOCK_DISCONNECT;
	[Deprecated (since = "vala-0.12", replacement = "Gtk.Stock.DND")]
	public const string STOCK_DND;
	[Deprecated (since = "vala-0.12", replacement = "Gtk.Stock.DND_MULTIPLE")]
	public const string STOCK_DND_MULTIPLE;
	[Deprecated (since = "vala-0.12", replacement = "Gtk.Stock.EDIT")]
	public const string STOCK_EDIT;
	[Deprecated (since = "vala-0.12", replacement = "Gtk.Stock.EXECUTE")]
	public const string STOCK_EXECUTE;
	[Deprecated (since = "vala-0.12", replacement = "Gtk.Stock.FILE")]
	public const string STOCK_FILE;
	[Deprecated (since = "vala-0.12", replacement = "Gtk.Stock.FIND")]
	public const string STOCK_FIND;
	[Deprecated (since = "vala-0.12", replacement = "Gtk.Stock.FIND_AND_REPLACE")]
	public const string STOCK_FIND_AND_REPLACE;
	[Deprecated (since = "vala-0.12", replacement = "Gtk.Stock.FLOPPY")]
	public const string STOCK_FLOPPY;
	[Deprecated (since = "vala-0.12", replacement = "Gtk.Stock.FULLSCREEN")]
	public const string STOCK_FULLSCREEN;
	[Deprecated (since = "vala-0.12", replacement = "Gtk.Stock.GOTO_BOTTOM")]
	public const string STOCK_GOTO_BOTTOM;
	[Deprecated (since = "vala-0.12", replacement = "Gtk.Stock.GOTO_FIRST")]
	public const string STOCK_GOTO_FIRST;
	[Deprecated (since = "vala-0.12", replacement = "Gtk.Stock.GOTO_LAST")]
	public const string STOCK_GOTO_LAST;
	[Deprecated (since = "vala-0.12", replacement = "Gtk.Stock.GOTO_TOP")]
	public const string STOCK_GOTO_TOP;
	[Deprecated (since = "vala-0.12", replacement = "Gtk.Stock.GO_BACK")]
	public const string STOCK_GO_BACK;
	[Deprecated (since = "vala-0.12", replacement = "Gtk.Stock.GO_DOWN")]
	public const string STOCK_GO_DOWN;
	[Deprecated (since = "vala-0.12", replacement = "Gtk.Stock.GO_FORWARD")]
	public const string STOCK_GO_FORWARD;
	[Deprecated (since = "vala-0.12", replacement = "Gtk.Stock.GO_UP")]
	public const string STOCK_GO_UP;
	[Deprecated (since = "vala-0.12", replacement = "Gtk.Stock.HARDDISK")]
	public const string STOCK_HARDDISK;
	[Deprecated (since = "vala-0.12", replacement = "Gtk.Stock.HELP")]
	public const string STOCK_HELP;
	[Deprecated (since = "vala-0.12", replacement = "Gtk.Stock.HOME")]
	public const string STOCK_HOME;
	[Deprecated (since = "vala-0.12", replacement = "Gtk.Stock.INDENT")]
	public const string STOCK_INDENT;
	[Deprecated (since = "vala-0.12", replacement = "Gtk.Stock.INDEX")]
	public const string STOCK_INDEX;
	[Deprecated (since = "vala-0.12", replacement = "Gtk.Stock.INFO")]
	public const string STOCK_INFO;
	[Deprecated (since = "vala-0.12", replacement = "Gtk.Stock.ITALIC")]
	public const string STOCK_ITALIC;
	[Deprecated (since = "vala-0.12", replacement = "Gtk.Stock.JUMP_TO")]
	public const string STOCK_JUMP_TO;
	[Deprecated (since = "vala-0.12", replacement = "Gtk.Stock.JUSTIFY_CENTER")]
	public const string STOCK_JUSTIFY_CENTER;
	[Deprecated (since = "vala-0.12", replacement = "Gtk.Stock.JUSTIFY_FILL")]
	public const string STOCK_JUSTIFY_FILL;
	[Deprecated (since = "vala-0.12", replacement = "Gtk.Stock.JUSTIFY_LEFT")]
	public const string STOCK_JUSTIFY_LEFT;
	[Deprecated (since = "vala-0.12", replacement = "Gtk.Stock.JUSTIFY_RIGHT")]
	public const string STOCK_JUSTIFY_RIGHT;
	[Deprecated (since = "vala-0.12", replacement = "Gtk.Stock.FULLSCREEN")]
	public const string STOCK_LEAVE_FULLSCREEN;
	[Deprecated (since = "vala-0.12", replacement = "Gtk.Stock.MEDIA_FORWARD")]
	public const string STOCK_MEDIA_FORWARD;
	[Deprecated (since = "vala-0.12", replacement = "Gtk.Stock.MEDIA_NEXT")]
	public const string STOCK_MEDIA_NEXT;
	[Deprecated (since = "vala-0.12", replacement = "Gtk.Stock.MEDIA_PAUSE")]
	public const string STOCK_MEDIA_PAUSE;
	[Deprecated (since = "vala-0.12", replacement = "Gtk.Stock.MEDIA_PLAY")]
	public const string STOCK_MEDIA_PLAY;
	[Deprecated (since = "vala-0.12", replacement = "Gtk.Stock.MEDIA_PREVIOUS")]
	public const string STOCK_MEDIA_PREVIOUS;
	[Deprecated (since = "vala-0.12", replacement = "Gtk.Stock.MEDIA_RECORD")]
	public const string STOCK_MEDIA_RECORD;
	[Deprecated (since = "vala-0.12", replacement = "Gtk.Stock.MEDIA_REWIND")]
	public const string STOCK_MEDIA_REWIND;
	[Deprecated (since = "vala-0.12", replacement = "Gtk.Stock.MEDIA_STOP")]
	public const string STOCK_MEDIA_STOP;
	[Deprecated (since = "vala-0.12", replacement = "Gtk.Stock.MISSING_IMAGE")]
	public const string STOCK_MISSING_IMAGE;
	[Deprecated (since = "vala-0.12", replacement = "Gtk.Stock.NETWORK")]
	public const string STOCK_NETWORK;
	[Deprecated (since = "vala-0.12", replacement = "Gtk.Stock.NEW")]
	public const string STOCK_NEW;
	[Deprecated (since = "vala-0.12", replacement = "Gtk.Stock.NO")]
	public const string STOCK_NO;
	[Deprecated (since = "vala-0.12", replacement = "Gtk.Stock.OK")]
	public const string STOCK_OK;
	[Deprecated (since = "vala-0.12", replacement = "Gtk.Stock.OPEN")]
	public const string STOCK_OPEN;
	[Deprecated (since = "vala-0.12", replacement = "Gtk.Stock.ORIENTATION_LANDSCAPE")]
	public const string STOCK_ORIENTATION_LANDSCAPE;
	[Deprecated (since = "vala-0.12", replacement = "Gtk.Stock.ORIENTATION_PORTRAIT")]
	public const string STOCK_ORIENTATION_PORTRAIT;
	[Deprecated (since = "vala-0.12", replacement = "Gtk.Stock.ORIENTATION_REVERSE_LANDSCAPE")]
	public const string STOCK_ORIENTATION_REVERSE_LANDSCAPE;
	[Deprecated (since = "vala-0.12", replacement = "Gtk.Stock.ORIENTATION_REVERSE_PORTRAIT")]
	public const string STOCK_ORIENTATION_REVERSE_PORTRAIT;
	[Deprecated (since = "vala-0.12", replacement = "Gtk.Stock.PAGE_SETUP")]
	public const string STOCK_PAGE_SETUP;
	[Deprecated (since = "vala-0.12", replacement = "Gtk.Stock.PASTE")]
	public const string STOCK_PASTE;
	[Deprecated (since = "vala-0.12", replacement = "Gtk.Stock.PREFERENCES")]
	public const string STOCK_PREFERENCES;
	[Deprecated (since = "vala-0.12", replacement = "Gtk.Stock.PRINT")]
	public const string STOCK_PRINT;
	[Deprecated (since = "vala-0.12", replacement = "Gtk.Stock.PRINT_ERROR")]
	public const string STOCK_PRINT_ERROR;
	[Deprecated (since = "vala-0.12", replacement = "Gtk.Stock.PRINT_PAUSED")]
	public const string STOCK_PRINT_PAUSED;
	[Deprecated (since = "vala-0.12", replacement = "Gtk.Stock.PRINT_PREVIEW")]
	public const string STOCK_PRINT_PREVIEW;
	[Deprecated (since = "vala-0.12", replacement = "Gtk.Stock.PRINT_REPORT")]
	public const string STOCK_PRINT_REPORT;
	[Deprecated (since = "vala-0.12", replacement = "Gtk.Stock.PRINT_WARNING")]
	public const string STOCK_PRINT_WARNING;
	[Deprecated (since = "vala-0.12", replacement = "Gtk.Stock.PROPERTIES")]
	public const string STOCK_PROPERTIES;
	[Deprecated (since = "vala-0.12", replacement = "Gtk.Stock.QUIT")]
	public const string STOCK_QUIT;
	[Deprecated (since = "vala-0.12", replacement = "Gtk.Stock.REDO")]
	public const string STOCK_REDO;
	[Deprecated (since = "vala-0.12", replacement = "Gtk.Stock.REFRESH")]
	public const string STOCK_REFRESH;
	[Deprecated (since = "vala-0.12", replacement = "Gtk.Stock.REMOVE")]
	public const string STOCK_REMOVE;
	[Deprecated (since = "vala-0.12", replacement = "Gtk.Stock.REVERT_TO_SAVED")]
	public const string STOCK_REVERT_TO_SAVED;
	[Deprecated (since = "vala-0.12", replacement = "Gtk.Stock.SAVE")]
	public const string STOCK_SAVE;
	[Deprecated (since = "vala-0.12", replacement = "Gtk.Stock.SAVE_AS")]
	public const string STOCK_SAVE_AS;
	[Deprecated (since = "vala-0.12", replacement = "Gtk.Stock.SELECT_ALL")]
	public const string STOCK_SELECT_ALL;
	[Deprecated (since = "vala-0.12", replacement = "Gtk.Stock.SELECT_COLOR")]
	public const string STOCK_SELECT_COLOR;
	[Deprecated (since = "vala-0.12", replacement = "Gtk.Stock.SELECT_FONT")]
	public const string STOCK_SELECT_FONT;
	[Deprecated (since = "vala-0.12", replacement = "Gtk.Stock.SORT_ASCENDING")]
	public const string STOCK_SORT_ASCENDING;
	[Deprecated (since = "vala-0.12", replacement = "Gtk.Stock.SORT_DESCENDING")]
	public const string STOCK_SORT_DESCENDING;
	[Deprecated (since = "vala-0.12", replacement = "Gtk.Stock.SPELL_CHECK")]
	public const string STOCK_SPELL_CHECK;
	[Deprecated (since = "vala-0.12", replacement = "Gtk.Stock.STOP")]
	public const string STOCK_STOP;
	[Deprecated (since = "vala-0.12", replacement = "Gtk.Stock.STRIKETHROUGH")]
	public const string STOCK_STRIKETHROUGH;
	[Deprecated (since = "vala-0.12", replacement = "Gtk.Stock.UNDELETE")]
	public const string STOCK_UNDELETE;
	[Deprecated (since = "vala-0.12", replacement = "Gtk.Stock.UNDERLINE")]
	public const string STOCK_UNDERLINE;
	[Deprecated (since = "vala-0.12", replacement = "Gtk.Stock.UNDO")]
	public const string STOCK_UNDO;
	[Deprecated (since = "vala-0.12", replacement = "Gtk.Stock.UNINDENT")]
	public const string STOCK_UNINDENT;
	[Deprecated (since = "vala-0.12", replacement = "Gtk.Stock.YES")]
	public const string STOCK_YES;
	[Deprecated (since = "vala-0.12", replacement = "Gtk.Stock.ZOOM_100")]
	public const string STOCK_ZOOM_100;
	[Deprecated (since = "vala-0.12", replacement = "Gtk.Stock.ZOOM_FIT")]
	public const string STOCK_ZOOM_FIT;
	[Deprecated (since = "vala-0.12", replacement = "Gtk.Stock.ZOOM_IN")]
	public const string STOCK_ZOOM_IN;
	[Deprecated (since = "vala-0.12", replacement = "Gtk.Stock.ZOOM_OUT")]
	public const string STOCK_ZOOM_OUT;

	[Deprecated (since = "vala-0.12", replacement = "Gtk.Stock.add")]
	public static void stock_add (Gtk.StockItem[] items);
	[Deprecated (since = "vala-0.12", replacement = "Gtk.Stock.add_static")]
	public static void stock_add_static (Gtk.StockItem[] items);
	[Deprecated (since = "vala-0.12", replacement = "Gtk.Stock.list_ids")]
	public static GLib.SList<string> stock_list_ids ();
	[Deprecated (since = "vala-0.26", replacement = "Gtk.Stock.set_translate_func")]
	public static void stock_set_translate_func (string domain, owned Gtk.TranslateFunc func);
}
