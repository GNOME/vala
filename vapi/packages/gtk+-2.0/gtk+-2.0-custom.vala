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
	public class AccelGroup {
		public Gtk.AccelKey* find (Gtk.AccelGroupFindFunc find_func);
	}

	public struct Allocation {
		public int x;
		public int y;
		public int width;
		public int height;
	}

	public class Container {
		[CCode (vfunc_name = "forall")]
		public virtual void forall_internal(bool include_internal, Gtk.Callback callback);
	}

	public class Notebook {
		public int page_num (Widget child);
	}

	public class StatusIcon {
		[CCode (instance_pos = -1)]
		public void position_menu (Gtk.Menu menu, out int x, out int y, out bool push_in);
	}

	public class UIManager {
		public uint new_merge_id ();
	}

	public class Widget {
		public extern Widget (GLib.Type type, ...);

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
	}

	public interface Editable {
		[CCode (vfunc_name = "set_selection_bounds")]
		public abstract void select_region (int start_pos, int end_pos);
	}

	public interface FileChooserEmbed {
	}

	public interface FileChooser: Gtk.Widget {
		public GLib.SList<GLib.File> get_files ();
	}

	[CCode (has_target = false)]
	public delegate void CallbackMarshal (Object object, void* data, Arg[] args);

	public delegate void ActionCallback (Action action);

	public delegate void MenuPositionFunc (Gtk.Menu menu, out int x, out int y, out bool push_in);

	public delegate void RadioActionCallback (Action action, Action current);

	public delegate bool TreeViewSearchEqualFunc (TreeModel model, int column, string key, TreeIter iter);

	public delegate string CalendarDetailFunc (Gtk.Calendar calendar, uint year, uint month, uint day);
}
