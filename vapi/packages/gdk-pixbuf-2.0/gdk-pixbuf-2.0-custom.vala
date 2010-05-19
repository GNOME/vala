/* gdk-pixbuf-2.0-custom.vala
 *
 * Copyright (C) 2010  Jakob Westhoff
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
 *  Jakob Westhoff <jakob@westhoffswelt.de>
 */

namespace Gdk {
	public class Pixbuf {
		public bool save_to_buffer ([CCode (array_length_type = "gsize")] out char[] buffer, string type, ...) throws GLib.Error;
		public bool save_to_bufferv ([CCode (array_length_type = "gsize")] out char[] buffer, string type, string[] option_keys, string[] option_values) throws GLib.Error;
    }
}
