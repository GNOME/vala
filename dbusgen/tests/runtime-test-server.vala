/* runtime-test-server.vala
 *
 * Copyright 2022 JCWasmx86 <JCWasmx86@t-online.de>
 *
 * This file is free software; you can redistribute it and/or modify it
 * under the terms of the GNU Lesser General Public License as
 * published by the Free Software Foundation; either version 3 of the
 * License, or (at your option) any later version.
 *
 * This file is distributed in the hope that it will be useful, but
 * WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public
 * License along with this program.  If not, see <http://www.gnu.org/licenses/>.
 *
 * SPDX-License-Identifier: LGPL-3.0-or-later
 */

[DBus (name = "org.gnome.Example")]
class DbusTestServer : GLib.Object, OrgGnomeExample {
	public void ret_int (out uint64 ret) throws GLib.DBusError, GLib.IOError {
		ret = 42;
	}
	public void ret_string (out string ret) throws GLib.DBusError, GLib.IOError {
		// Unicode test
		ret = "Vala💙äöüß";
	}
	public void ret_dict (out GLib.HashTable<string,GLib.Variant> ret) throws GLib.DBusError, GLib.IOError {
		ret = new GLib.HashTable<string, Variant> (str_hash, str_equal);
		ret["a_bool"] = new Variant.boolean (true);
		ret["a_int"] = new Variant.int64 (-1);
		ret["a_string"] = new Variant.string ("string");
	}

	public void ret_array (out uint64[] ret) throws GLib.DBusError, GLib.IOError {
		ret = new uint64[5];
		ret[0] = 3;
		ret[1] = 1;
		ret[2] = 4;
		ret[3] = 1;
		ret[4] = 5;
	}

	public void trigger_signal () throws GLib.DBusError, GLib.IOError {
		cnter_property++;
		// Does not work
		emit_signal (42);
	}
	public void ret_object (out DBusProxyStruct_1ii_1si1_1_ ret) throws GLib.DBusError, GLib.IOError {
		ret = DBusProxyStruct_1ii_1si1_1_ () {
			arg0 = -1,
			arg1 = 5,
			arg2 = DBusProxyStruct_1si1_ () {
				arg0 = "foo",
				arg1 = -1,
			}
		};
	}
	public void exit () throws GLib.DBusError, GLib.IOError {
		Process.exit (0);
	}

	public override int32 cnter_property {get; set;}
}

void on_bus_aquired (DBusConnection conn) {
    try {
        conn.register_object ("/org/gnome/Example", new DbusTestServer ());
    } catch (IOError e) {
        stderr.printf ("Could not register service\n");
    }
}

int main () {
	Bus.own_name (BusType.SESSION, "org.gnome.Example", BusNameOwnerFlags.REPLACE, on_bus_aquired, null, () => {
		info ("Lost connection");
	});
	new MainLoop ().run ();
	return 0;
}
