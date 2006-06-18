/* gtk+-2.0.vala
 *
 * Copyright (C) 2006  Jürg Billeter
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public
 * License as published by the Free Software Foundation; either
 * version 2 of the License, or (at your option) any later version.

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

[CCode (cheader_filename = "gtk/gtk.h")]
namespace Gtk {
	public static void init (ref int argc, out string[] argv);
	public static void main ();
	public static void main_quit ();
	
	[CCode (cprefix = "GTK_WINDOW_")]
	public enum WindowType {
		TOPLEVEL,
		POPUP
	}
	
	public class Dialog : Window {
		[FloatingReference ()]
		public static ref Widget new ();
		[FloatingReference ()]
		public static ref Widget new_with_buttons (string title, Window parent, DialogFlags @flags, string first_button_text, ...);
		public int run ();
		public void response (int response_id);
		public Widget add_button (string button_text, int response_id);
		public void add_buttons (string first_button_text, ...);
	}
	
	public enum DialogFlags {
		MODAL,
		DESTROY_WITH_PARENT,
		NO_SEPARATOR
	}
	
	public class MessageDialog : Dialog {
		[FloatingReference ()]
		public static ref Widget new (Window parent, DialogFlags @flags, MessageType type, ButtonsType buttons, string message_format, ...);
	}

	public enum MessageType {
		INFO,
		WARNING,
		QUESTION,
		ERROR
	}
	
	public enum ButtonsType {
		NONE,
		OK,
		CLOSE,
		CANCEL,
		YES_NO,
		OK_CANCEL
	}
	
	public class Window : Container {
		public string title { get; set construct; }
		public WindowType type { get; construct; }
	
		public void set_title (string title);
	}
	
	public class Label : Misc {
		public string label { get; set; }
		public bool use_markup { get; set; }
	}
	
	public class Button : Container {
		[FloatingReference ()]
		public static ref Button new_with_label (string label);
		
		public string label { get; construct; }
		
		public signal void activate ();
		public signal void clicked ();
		public signal void enter ();
	}
	
	public class Entry : Widget {
		[FloatingReference ()]
		public static ref Entry new ();
	}
	
	public class TextBuffer {
	}
	
	public class TextView : Container {
	}
	
	public interface TreeModel {
	}
	
	public struct TreeIter {
		public int stamp;
		public pointer user_data;
		public pointer user_data2;
		public pointer user_data3;
	}
	
	public class TreeViewColumn : Object {
		[FloatingReference ()]
		public static ref TreeViewColumn new_with_attributes (string title, CellRenderer cell, ...);
	}
	
	public class TreeView : Container {
		public TreeModel model { get; set; }
		
		public int append_column (TreeViewColumn column);
	}
	
	public abstract class CellRenderer : Object {
	}
	
	public class CellRendererText : CellRenderer {
		[NoAccessorMethod ()]
		public Pango.Style style { get; set; }
	}
	
	public class TreeStore : TreeModel {
		public static ref TreeStore new (int n_columns, ...);
		public void @set (ref TreeIter iter, ...);
		public void append (ref TreeIter iter, ref TreeIter parent);
	}
	
	public class Menu : MenuShell {
		[FloatingReference ()]
		public static ref Menu new ();
	}
	
	public class MenuBar : MenuShell {
		[FloatingReference ()]
		public static ref MenuBar new ();
	}
	
	public class MenuItem : Item {
		[FloatingReference ()]
		public static ref MenuItem new_with_label (string label);
		public void set_submenu (Menu submenu);
	}
	
	public abstract class MenuShell : Container {
		public void append (MenuItem child);
	}
	
	public class Toolbar : Container {
		[FloatingReference ()]
		public static ref Toolbar new ();
	}
	
	public class HBox : Box {
		[FloatingReference ()]
		public static ref HBox new (bool homogeneous, int spacing);
	}
	
	public class VBox : Box {
		[FloatingReference ()]
		public static ref VBox new (bool homogeneous, int spacing);
	}
	
	public class Notebook : Container {
		public int append_page (Widget child, Widget tab_label);
	}
	
	public class ScrolledWindow : Bin {
	}
	
	public abstract class Bin : Container {
	}
	
	public abstract class Box : Container {
		public bool homogeneous { get; set; }
		public int spacing { get; set; }
	
		public void pack_start (Widget child, bool expand, bool fill, uint padding);
		public void pack_start_defaults (Widget widget);
	}
	
	public abstract class Container : Widget {
		public void add (Widget w);
	}
	
	public abstract class Item : Bin {
	}
	
	public abstract class Misc : Widget {
	}
	
	public abstract class Object : GLib.InitiallyUnowned {
		public signal void destroy ();
	}
	
	public abstract class Widget : Object {
		public void show ();
		public void show_all ();
	}
}
