/* dbus-glib-1.vala
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

[CCode (cheader_filename = "dbus/dbus-glib-lowlevel.h")]
namespace DBus {
	[CCode (cprefix = "DBUS_BUS_")]
	public enum BusType {
		SESSION,
		SYSTEM,
		STARTER
	}

	public struct Bus {
		public static Connection get (BusType type, ref Error error);
	}

	[ReferenceType (dup_function = "dbus_connection_ref", free_function = "dbus_connection_unref")]
	public struct Connection {
		[CCode (cname = "dbus_connection_setup_with_g_main")]
		public void setup_with_main (GLib.MainContext context);
	}

	public struct Error {
		public string name;
		public string message;

		[InstanceByReference]
		public void init ();
		[InstanceByReference]
		public bool has_name (string name);
		[InstanceByReference]
		public bool is_set ();
	}
}
