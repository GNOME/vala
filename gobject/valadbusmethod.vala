/* valadbusmethod.vala
 *
 * Copyright (C) 2007  Jürg Billeter
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

using GLib;
using Gee;

/**
 * Represents a dynamic bound DBus method.
 */
public class Vala.DBusMethod : Method {
	public DBusMethod (construct string name, construct TypeReference return_type, construct SourceReference source_reference = null) {
	}

	public override Collection<string> get_cheader_filenames () {
		return new ReadOnlyCollection<string> ();
	}

	public override string! get_default_cname () {
		return "dbus_g_proxy_begin_call";
	}
}
