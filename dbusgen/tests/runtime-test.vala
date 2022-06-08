/* runtime-test.vala
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

int main () {
	OrgGnomeExample example;
	try {
		example = Bus.get_proxy_sync (BusType.SESSION, "org.gnome.Example",
                                                    "/org/gnome/Example");
        uint64 r_int;
        example.ret_int (out r_int);
        assert (r_int == 42);
		string r_string;
		example.ret_string (out r_string);
		assert (r_string == "Vala💙äöüß");
		GLib.HashTable<string, Variant> r_dict;
		example.ret_dict (out r_dict);
		assert (r_dict.length == 3);
		assert (r_dict["a_bool"].get_boolean ());
		assert (r_dict["a_int"].get_int64 () == -1);
		assert (r_dict["a_string"].get_string () == "string");
		uint64[] r_array;
		example.ret_array (out r_array);
		assert (r_array.length == 5);
		assert (r_array[0] == 3 && r_array[1] == 1 && r_array[2] == 4 && r_array[3] == 1 && r_array[4] == 5);
		DBusProxyStruct_1ii_1si1_1_ r_obj;
		example.ret_object (out r_obj);
		assert (r_obj.arg0 == -1);
		assert (r_obj.arg1 == 5);
		assert (r_obj.arg2.arg0 == "foo");
		assert (r_obj.arg2.arg1 == -1);

	} catch (Error e) {
		error ("Caught error: %s", e.message);
	}
	try {
		example.exit ();
	} catch (Error e) {
		//  Ignore, as it is expected to throw exception
	}
	return 0;
}
