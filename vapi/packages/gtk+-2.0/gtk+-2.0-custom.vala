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
		public void position_menu (Gtk.Menu menu, ref int x, ref int y, out bool push_in);
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

	[CCode (cname = "GCallback")]
	public delegate void ActionCallback (Action action);

	[CCode (cname = "GCallback")]
	public delegate void RadioActionCallback (Action action, Action current);

	[CCode (cheader_filename = "gtk/gtk.h")]
	public static unowned string set_locale ();

	[Version (deprecated_since = "vala-0.26", replacement = "Gtk.Stock.set_translate_func")]
	public static void stock_set_translate_func (string domain, owned Gtk.TranslateFunc func);
}
