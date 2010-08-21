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

	[Deprecated (since = "vala-0.12", replacement = "Gtk.Stock.ABOUT")]
	[CCode (cheader_filename = "gtk/gtk.h")]
	public const string STOCK_ABOUT;
	[Deprecated (since = "vala-0.12", replacement = "Gtk.Stock.ADD")]
	[CCode (cheader_filename = "gtk/gtk.h")]
	public const string STOCK_ADD;
	[Deprecated (since = "vala-0.12", replacement = "Gtk.Stock.APPLY")]
	[CCode (cheader_filename = "gtk/gtk.h")]
	public const string STOCK_APPLY;
	[Deprecated (since = "vala-0.12", replacement = "Gtk.Stock.BOLD")]
	[CCode (cheader_filename = "gtk/gtk.h")]
	public const string STOCK_BOLD;
	[Deprecated (since = "vala-0.12", replacement = "Gtk.Stock.CANCEL")]
	[CCode (cheader_filename = "gtk/gtk.h")]
	public const string STOCK_CANCEL;
	[Deprecated (since = "vala-0.12", replacement = "Gtk.Stock.CAPS_LOCK_WARNING")]
	[CCode (cheader_filename = "gtk/gtk.h")]
	public const string STOCK_CAPS_LOCK_WARNING;
	[Deprecated (since = "vala-0.12", replacement = "Gtk.Stock.CDROM")]
	[CCode (cheader_filename = "gtk/gtk.h")]
	public const string STOCK_CDROM;
	[Deprecated (since = "vala-0.12", replacement = "Gtk.Stock.CLEAR")]
	[CCode (cheader_filename = "gtk/gtk.h")]
	public const string STOCK_CLEAR;
	[Deprecated (since = "vala-0.12", replacement = "Gtk.Stock.CLOSE")]
	[CCode (cheader_filename = "gtk/gtk.h")]
	public const string STOCK_CLOSE;
	[Deprecated (since = "vala-0.12", replacement = "Gtk.Stock.COLOR_PICKER")]
	[CCode (cheader_filename = "gtk/gtk.h")]
	public const string STOCK_COLOR_PICKER;
	[Deprecated (since = "vala-0.12", replacement = "Gtk.Stock.CONNECT")]
	[CCode (cheader_filename = "gtk/gtk.h")]
	public const string STOCK_CONNECT;
	[Deprecated (since = "vala-0.12", replacement = "Gtk.Stock.CONVERT")]
	[CCode (cheader_filename = "gtk/gtk.h")]
	public const string STOCK_CONVERT;
	[Deprecated (since = "vala-0.12", replacement = "Gtk.Stock.COPY")]
	[CCode (cheader_filename = "gtk/gtk.h")]
	public const string STOCK_COPY;
	[Deprecated (since = "vala-0.12", replacement = "Gtk.Stock.CUT")]
	[CCode (cheader_filename = "gtk/gtk.h")]
	public const string STOCK_CUT;
	[Deprecated (since = "vala-0.12", replacement = "Gtk.Stock.DELETE")]
	[CCode (cheader_filename = "gtk/gtk.h")]
	public const string STOCK_DELETE;
	[Deprecated (since = "vala-0.12", replacement = "Gtk.Stock.DIALOG_AUTHENTICATION")]
	[CCode (cheader_filename = "gtk/gtk.h")]
	public const string STOCK_DIALOG_AUTHENTICATION;
	[Deprecated (since = "vala-0.12", replacement = "Gtk.Stock.DIALOG_ERROR")]
	[CCode (cheader_filename = "gtk/gtk.h")]
	public const string STOCK_DIALOG_ERROR;
	[Deprecated (since = "vala-0.12", replacement = "Gtk.Stock.DIALOG_INFO")]
	[CCode (cheader_filename = "gtk/gtk.h")]
	public const string STOCK_DIALOG_INFO;
	[Deprecated (since = "vala-0.12", replacement = "Gtk.Stock.DIALOG_QUESTION")]
	[CCode (cheader_filename = "gtk/gtk.h")]
	public const string STOCK_DIALOG_QUESTION;
	[Deprecated (since = "vala-0.12", replacement = "Gtk.Stock.DIALOG_WARNING")]
	[CCode (cheader_filename = "gtk/gtk.h")]
	public const string STOCK_DIALOG_WARNING;
	[Deprecated (since = "vala-0.12", replacement = "Gtk.Stock.DIRECTORY")]
	[CCode (cheader_filename = "gtk/gtk.h")]
	public const string STOCK_DIRECTORY;
	[Deprecated (since = "vala-0.12", replacement = "Gtk.Stock.DISCARD")]
	[CCode (cheader_filename = "gtk/gtk.h")]
	public const string STOCK_DISCARD;
	[Deprecated (since = "vala-0.12", replacement = "Gtk.Stock.DISCONNECT")]
	[CCode (cheader_filename = "gtk/gtk.h")]
	public const string STOCK_DISCONNECT;
	[Deprecated (since = "vala-0.12", replacement = "Gtk.Stock.DND")]
	[CCode (cheader_filename = "gtk/gtk.h")]
	public const string STOCK_DND;
	[Deprecated (since = "vala-0.12", replacement = "Gtk.Stock.DND_MULTIPLE")]
	[CCode (cheader_filename = "gtk/gtk.h")]
	public const string STOCK_DND_MULTIPLE;
	[Deprecated (since = "vala-0.12", replacement = "Gtk.Stock.EDIT")]
	[CCode (cheader_filename = "gtk/gtk.h")]
	public const string STOCK_EDIT;
	[Deprecated (since = "vala-0.12", replacement = "Gtk.Stock.EXECUTE")]
	[CCode (cheader_filename = "gtk/gtk.h")]
	public const string STOCK_EXECUTE;
	[Deprecated (since = "vala-0.12", replacement = "Gtk.Stock.FILE")]
	[CCode (cheader_filename = "gtk/gtk.h")]
	public const string STOCK_FILE;
	[Deprecated (since = "vala-0.12", replacement = "Gtk.Stock.FIND")]
	[CCode (cheader_filename = "gtk/gtk.h")]
	public const string STOCK_FIND;
	[Deprecated (since = "vala-0.12", replacement = "Gtk.Stock.FIND_AND_REPLACE")]
	[CCode (cheader_filename = "gtk/gtk.h")]
	public const string STOCK_FIND_AND_REPLACE;
	[Deprecated (since = "vala-0.12", replacement = "Gtk.Stock.FLOPPY")]
	[CCode (cheader_filename = "gtk/gtk.h")]
	public const string STOCK_FLOPPY;
	[Deprecated (since = "vala-0.12", replacement = "Gtk.Stock.FULLSCREEN")]
	[CCode (cheader_filename = "gtk/gtk.h")]
	public const string STOCK_FULLSCREEN;
	[Deprecated (since = "vala-0.12", replacement = "Gtk.Stock.GOTO_BOTTOM")]
	[CCode (cheader_filename = "gtk/gtk.h")]
	public const string STOCK_GOTO_BOTTOM;
	[Deprecated (since = "vala-0.12", replacement = "Gtk.Stock.GOTO_FIRST")]
	[CCode (cheader_filename = "gtk/gtk.h")]
	public const string STOCK_GOTO_FIRST;
	[Deprecated (since = "vala-0.12", replacement = "Gtk.Stock.GOTO_LAST")]
	[CCode (cheader_filename = "gtk/gtk.h")]
	public const string STOCK_GOTO_LAST;
	[Deprecated (since = "vala-0.12", replacement = "Gtk.Stock.GOTO_TOP")]
	[CCode (cheader_filename = "gtk/gtk.h")]
	public const string STOCK_GOTO_TOP;
	[Deprecated (since = "vala-0.12", replacement = "Gtk.Stock.GO_BACK")]
	[CCode (cheader_filename = "gtk/gtk.h")]
	public const string STOCK_GO_BACK;
	[Deprecated (since = "vala-0.12", replacement = "Gtk.Stock.GO_DOWN")]
	[CCode (cheader_filename = "gtk/gtk.h")]
	public const string STOCK_GO_DOWN;
	[Deprecated (since = "vala-0.12", replacement = "Gtk.Stock.GO_FORWARD")]
	[CCode (cheader_filename = "gtk/gtk.h")]
	public const string STOCK_GO_FORWARD;
	[Deprecated (since = "vala-0.12", replacement = "Gtk.Stock.GO_UP")]
	[CCode (cheader_filename = "gtk/gtk.h")]
	public const string STOCK_GO_UP;
	[Deprecated (since = "vala-0.12", replacement = "Gtk.Stock.HARDDISK")]
	[CCode (cheader_filename = "gtk/gtk.h")]
	public const string STOCK_HARDDISK;
	[Deprecated (since = "vala-0.12", replacement = "Gtk.Stock.HELP")]
	[CCode (cheader_filename = "gtk/gtk.h")]
	public const string STOCK_HELP;
	[Deprecated (since = "vala-0.12", replacement = "Gtk.Stock.HOME")]
	[CCode (cheader_filename = "gtk/gtk.h")]
	public const string STOCK_HOME;
	[Deprecated (since = "vala-0.12", replacement = "Gtk.Stock.INDENT")]
	[CCode (cheader_filename = "gtk/gtk.h")]
	public const string STOCK_INDENT;
	[Deprecated (since = "vala-0.12", replacement = "Gtk.Stock.INDEX")]
	[CCode (cheader_filename = "gtk/gtk.h")]
	public const string STOCK_INDEX;
	[Deprecated (since = "vala-0.12", replacement = "Gtk.Stock.INFO")]
	[CCode (cheader_filename = "gtk/gtk.h")]
	public const string STOCK_INFO;
	[Deprecated (since = "vala-0.12", replacement = "Gtk.Stock.ITALIC")]
	[CCode (cheader_filename = "gtk/gtk.h")]
	public const string STOCK_ITALIC;
	[Deprecated (since = "vala-0.12", replacement = "Gtk.Stock.JUMP_TO")]
	[CCode (cheader_filename = "gtk/gtk.h")]
	public const string STOCK_JUMP_TO;
	[Deprecated (since = "vala-0.12", replacement = "Gtk.Stock.JUSTIFY_CENTER")]
	[CCode (cheader_filename = "gtk/gtk.h")]
	public const string STOCK_JUSTIFY_CENTER;
	[Deprecated (since = "vala-0.12", replacement = "Gtk.Stock.JUSTIFY_FILL")]
	[CCode (cheader_filename = "gtk/gtk.h")]
	public const string STOCK_JUSTIFY_FILL;
	[Deprecated (since = "vala-0.12", replacement = "Gtk.Stock.JUSTIFY_LEFT")]
	[CCode (cheader_filename = "gtk/gtk.h")]
	public const string STOCK_JUSTIFY_LEFT;
	[Deprecated (since = "vala-0.12", replacement = "Gtk.Stock.JUSTIFY_RIGHT")]
	[CCode (cheader_filename = "gtk/gtk.h")]
	public const string STOCK_JUSTIFY_RIGHT;
	[Deprecated (since = "vala-0.12", replacement = "Gtk.Stock.FULLSCREEN")]
	[CCode (cheader_filename = "gtk/gtk.h")]
	public const string STOCK_LEAVE_FULLSCREEN;
	[Deprecated (since = "vala-0.12", replacement = "Gtk.Stock.MEDIA_FORWARD")]
	[CCode (cheader_filename = "gtk/gtk.h")]
	public const string STOCK_MEDIA_FORWARD;
	[Deprecated (since = "vala-0.12", replacement = "Gtk.Stock.MEDIA_NEXT")]
	[CCode (cheader_filename = "gtk/gtk.h")]
	public const string STOCK_MEDIA_NEXT;
	[Deprecated (since = "vala-0.12", replacement = "Gtk.Stock.MEDIA_PAUSE")]
	[CCode (cheader_filename = "gtk/gtk.h")]
	public const string STOCK_MEDIA_PAUSE;
	[Deprecated (since = "vala-0.12", replacement = "Gtk.Stock.MEDIA_PLAY")]
	[CCode (cheader_filename = "gtk/gtk.h")]
	public const string STOCK_MEDIA_PLAY;
	[Deprecated (since = "vala-0.12", replacement = "Gtk.Stock.MEDIA_PREVIOUS")]
	[CCode (cheader_filename = "gtk/gtk.h")]
	public const string STOCK_MEDIA_PREVIOUS;
	[Deprecated (since = "vala-0.12", replacement = "Gtk.Stock.MEDIA_RECORD")]
	[CCode (cheader_filename = "gtk/gtk.h")]
	public const string STOCK_MEDIA_RECORD;
	[Deprecated (since = "vala-0.12", replacement = "Gtk.Stock.MEDIA_REWIND")]
	[CCode (cheader_filename = "gtk/gtk.h")]
	public const string STOCK_MEDIA_REWIND;
	[Deprecated (since = "vala-0.12", replacement = "Gtk.Stock.MEDIA_STOP")]
	[CCode (cheader_filename = "gtk/gtk.h")]
	public const string STOCK_MEDIA_STOP;
	[Deprecated (since = "vala-0.12", replacement = "Gtk.Stock.MISSING_IMAGE")]
	[CCode (cheader_filename = "gtk/gtk.h")]
	public const string STOCK_MISSING_IMAGE;
	[Deprecated (since = "vala-0.12", replacement = "Gtk.Stock.NETWORK")]
	[CCode (cheader_filename = "gtk/gtk.h")]
	public const string STOCK_NETWORK;
	[Deprecated (since = "vala-0.12", replacement = "Gtk.Stock.NEW")]
	[CCode (cheader_filename = "gtk/gtk.h")]
	public const string STOCK_NEW;
	[Deprecated (since = "vala-0.12", replacement = "Gtk.Stock.NO")]
	[CCode (cheader_filename = "gtk/gtk.h")]
	public const string STOCK_NO;
	[Deprecated (since = "vala-0.12", replacement = "Gtk.Stock.OK")]
	[CCode (cheader_filename = "gtk/gtk.h")]
	public const string STOCK_OK;
	[Deprecated (since = "vala-0.12", replacement = "Gtk.Stock.OPEN")]
	[CCode (cheader_filename = "gtk/gtk.h")]
	public const string STOCK_OPEN;
	[Deprecated (since = "vala-0.12", replacement = "Gtk.Stock.ORIENTATION_LANDSCAPE")]
	[CCode (cheader_filename = "gtk/gtk.h")]
	public const string STOCK_ORIENTATION_LANDSCAPE;
	[Deprecated (since = "vala-0.12", replacement = "Gtk.Stock.ORIENTATION_PORTRAIT")]
	[CCode (cheader_filename = "gtk/gtk.h")]
	public const string STOCK_ORIENTATION_PORTRAIT;
	[Deprecated (since = "vala-0.12", replacement = "Gtk.Stock.ORIENTATION_REVERSE_LANDSCAPE")]
	[CCode (cheader_filename = "gtk/gtk.h")]
	public const string STOCK_ORIENTATION_REVERSE_LANDSCAPE;
	[Deprecated (since = "vala-0.12", replacement = "Gtk.Stock.ORIENTATION_REVERSE_PORTRAIT")]
	[CCode (cheader_filename = "gtk/gtk.h")]
	public const string STOCK_ORIENTATION_REVERSE_PORTRAIT;
	[Deprecated (since = "vala-0.12", replacement = "Gtk.Stock.PAGE_SETUP")]
	[CCode (cheader_filename = "gtk/gtk.h")]
	public const string STOCK_PAGE_SETUP;
	[Deprecated (since = "vala-0.12", replacement = "Gtk.Stock.PASTE")]
	[CCode (cheader_filename = "gtk/gtk.h")]
	public const string STOCK_PASTE;
	[Deprecated (since = "vala-0.12", replacement = "Gtk.Stock.PREFERENCES")]
	[CCode (cheader_filename = "gtk/gtk.h")]
	public const string STOCK_PREFERENCES;
	[Deprecated (since = "vala-0.12", replacement = "Gtk.Stock.PRINT")]
	[CCode (cheader_filename = "gtk/gtk.h")]
	public const string STOCK_PRINT;
	[Deprecated (since = "vala-0.12", replacement = "Gtk.Stock.PRINT_ERROR")]
	[CCode (cheader_filename = "gtk/gtk.h")]
	public const string STOCK_PRINT_ERROR;
	[Deprecated (since = "vala-0.12", replacement = "Gtk.Stock.PRINT_PAUSED")]
	[CCode (cheader_filename = "gtk/gtk.h")]
	public const string STOCK_PRINT_PAUSED;
	[Deprecated (since = "vala-0.12", replacement = "Gtk.Stock.PRINT_PREVIEW")]
	[CCode (cheader_filename = "gtk/gtk.h")]
	public const string STOCK_PRINT_PREVIEW;
	[Deprecated (since = "vala-0.12", replacement = "Gtk.Stock.PRINT_REPORT")]
	[CCode (cheader_filename = "gtk/gtk.h")]
	public const string STOCK_PRINT_REPORT;
	[Deprecated (since = "vala-0.12", replacement = "Gtk.Stock.PRINT_WARNING")]
	[CCode (cheader_filename = "gtk/gtk.h")]
	public const string STOCK_PRINT_WARNING;
	[Deprecated (since = "vala-0.12", replacement = "Gtk.Stock.PROPERTIES")]
	[CCode (cheader_filename = "gtk/gtk.h")]
	public const string STOCK_PROPERTIES;
	[Deprecated (since = "vala-0.12", replacement = "Gtk.Stock.QUIT")]
	[CCode (cheader_filename = "gtk/gtk.h")]
	public const string STOCK_QUIT;
	[Deprecated (since = "vala-0.12", replacement = "Gtk.Stock.REDO")]
	[CCode (cheader_filename = "gtk/gtk.h")]
	public const string STOCK_REDO;
	[Deprecated (since = "vala-0.12", replacement = "Gtk.Stock.REFRESH")]
	[CCode (cheader_filename = "gtk/gtk.h")]
	public const string STOCK_REFRESH;
	[Deprecated (since = "vala-0.12", replacement = "Gtk.Stock.REMOVE")]
	[CCode (cheader_filename = "gtk/gtk.h")]
	public const string STOCK_REMOVE;
	[Deprecated (since = "vala-0.12", replacement = "Gtk.Stock.REVERT_TO_SAVED")]
	[CCode (cheader_filename = "gtk/gtk.h")]
	public const string STOCK_REVERT_TO_SAVED;
	[Deprecated (since = "vala-0.12", replacement = "Gtk.Stock.SAVE")]
	[CCode (cheader_filename = "gtk/gtk.h")]
	public const string STOCK_SAVE;
	[Deprecated (since = "vala-0.12", replacement = "Gtk.Stock.SAVE_AS")]
	[CCode (cheader_filename = "gtk/gtk.h")]
	public const string STOCK_SAVE_AS;
	[Deprecated (since = "vala-0.12", replacement = "Gtk.Stock.SELECT_ALL")]
	[CCode (cheader_filename = "gtk/gtk.h")]
	public const string STOCK_SELECT_ALL;
	[Deprecated (since = "vala-0.12", replacement = "Gtk.Stock.SELECT_COLOR")]
	[CCode (cheader_filename = "gtk/gtk.h")]
	public const string STOCK_SELECT_COLOR;
	[Deprecated (since = "vala-0.12", replacement = "Gtk.Stock.SELECT_FONT")]
	[CCode (cheader_filename = "gtk/gtk.h")]
	public const string STOCK_SELECT_FONT;
	[Deprecated (since = "vala-0.12", replacement = "Gtk.Stock.SORT_ASCENDING")]
	[CCode (cheader_filename = "gtk/gtk.h")]
	public const string STOCK_SORT_ASCENDING;
	[Deprecated (since = "vala-0.12", replacement = "Gtk.Stock.SORT_DESCENDING")]
	[CCode (cheader_filename = "gtk/gtk.h")]
	public const string STOCK_SORT_DESCENDING;
	[Deprecated (since = "vala-0.12", replacement = "Gtk.Stock.SPELL_CHECK")]
	[CCode (cheader_filename = "gtk/gtk.h")]
	public const string STOCK_SPELL_CHECK;
	[Deprecated (since = "vala-0.12", replacement = "Gtk.Stock.STOP")]
	[CCode (cheader_filename = "gtk/gtk.h")]
	public const string STOCK_STOP;
	[Deprecated (since = "vala-0.12", replacement = "Gtk.Stock.STRIKETHROUGH")]
	[CCode (cheader_filename = "gtk/gtk.h")]
	public const string STOCK_STRIKETHROUGH;
	[Deprecated (since = "vala-0.12", replacement = "Gtk.Stock.UNDELETE")]
	[CCode (cheader_filename = "gtk/gtk.h")]
	public const string STOCK_UNDELETE;
	[Deprecated (since = "vala-0.12", replacement = "Gtk.Stock.UNDERLINE")]
	[CCode (cheader_filename = "gtk/gtk.h")]
	public const string STOCK_UNDERLINE;
	[Deprecated (since = "vala-0.12", replacement = "Gtk.Stock.UNDO")]
	[CCode (cheader_filename = "gtk/gtk.h")]
	public const string STOCK_UNDO;
	[Deprecated (since = "vala-0.12", replacement = "Gtk.Stock.UNINDENT")]
	[CCode (cheader_filename = "gtk/gtk.h")]
	public const string STOCK_UNINDENT;
	[Deprecated (since = "vala-0.12", replacement = "Gtk.Stock.YES")]
	[CCode (cheader_filename = "gtk/gtk.h")]
	public const string STOCK_YES;
	[Deprecated (since = "vala-0.12", replacement = "Gtk.Stock.ZOOM_100")]
	[CCode (cheader_filename = "gtk/gtk.h")]
	public const string STOCK_ZOOM_100;
	[Deprecated (since = "vala-0.12", replacement = "Gtk.Stock.ZOOM_FIT")]
	[CCode (cheader_filename = "gtk/gtk.h")]
	public const string STOCK_ZOOM_FIT;
	[Deprecated (since = "vala-0.12", replacement = "Gtk.Stock.ZOOM_IN")]
	[CCode (cheader_filename = "gtk/gtk.h")]
	public const string STOCK_ZOOM_IN;
	[Deprecated (since = "vala-0.12", replacement = "Gtk.Stock.ZOOM_OUT")]
	[CCode (cheader_filename = "gtk/gtk.h")]
	public const string STOCK_ZOOM_OUT;
}
