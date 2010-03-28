/* hildon.vala
 *
 * Copyright (C) 2009  Philipp Zabel
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
 * 	Philipp Zabel <philipp.zabel@gmail.com>
 */

namespace Hildon {
	[CCode (cprefix = "HILDON_GTK_INPUT_MODE_", has_type_id = false, cheader_filename = "gtk/gtk.h")]
	public enum GtkInputMode {
		ALPHA,
		NUMERIC,
		SPECIAL,
		HEXA,
		TELE,
		FULL,
		MULTILINE,
		INVISIBLE,
		AUTOCAP,
		DICTIONARY
	}
	[CCode (cprefix = "HILDON_", has_type_id = false, cheader_filename = "gtk/gtk.h")]
	public enum Mode {
		DIABLO,
		FREMANTLE
	}
	[CCode (cprefix = "HILDON_SIZE_", has_type_id = false, cheader_filename = "gtk/gtk.h")]
	public enum SizeType {
		AUTO_WIDTH,
		HALFSCREEN_WIDTH,
		FULLSCREEN_WIDTH,
		AUTO_HEIGHT,
		FINGER_HEIGHT,
		THUMB_HEIGHT,
		AUTO
	}
	[CCode (cprefix = "HILDON_UI_MODE_", has_type_id = false, cheader_filename = "gtk/gtk.h")]
	public enum UIMode {
		NORMAL,
		EDIT
	}
	[CCode (cheader_filename = "gtk/gtk.h")]
	public static void gtk_widget_set_theme_size (Gtk.Widget widget, Hildon.SizeType size);
}
