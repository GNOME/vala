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
	public struct Allocation {
		public int x;
		public int y;
		public int width;
		public int height;
	}

	public class Widget {
		public extern Widget (GLib.Type type, ...);

		[CCode (cname = "GTK_WIDGET_FLAGS")]
		public extern WidgetFlags get_flags ();

		[CCode (cname = "GTK_WIDGET_SET_FLAGS")]
		public extern void set_flags (WidgetFlags flags);

		[CCode (cname = "GTK_WIDGET_UNSET_FLAGS")]
		public extern void unset_flags (WidgetFlags flags);
	}

	public interface FileChooserEmbed {
	}

	public static delegate void CallbackMarshal (Object object, void* data, Arg[] args);

	public delegate void ActionCallback (Action action);

	public delegate void RadioActionCallback (Action action, Action current);

	public delegate bool TreeViewSearchEqualFunc (TreeModel model, int column, string key, TreeIter iter);

	public delegate string CalendarDetailFunc (Gtk.Calendar calendar, uint year, uint month, uint day);
}
