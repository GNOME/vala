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

	public delegate void ActionCallback (Action action);

	public delegate void MenuPositionFunc (Gtk.Menu menu, out int x, out int y, out bool push_in);

	public delegate void RadioActionCallback (Action action, Action current);

	public delegate bool TreeViewSearchEqualFunc (TreeModel model, int column, string key, TreeIter iter);

	public delegate string CalendarDetailFunc (Gtk.Calendar calendar, uint year, uint month, uint day);

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
}
