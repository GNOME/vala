/* hal.vala
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

[CCode (cheader_filename = "libhal.h", cprefix = "LibHal")]
namespace Hal {
	public static delegate void DeviceAdded (Context ctx, string udi);
	public static delegate void DeviceRemoved (Context ctx, string udi);

	[ReferenceType (free_function = "libhal_ctx_free")]
	[CCode (cprefix = "libhal_ctx_")]
	public struct Context {
		public Context ();
		public bool init (ref DBus.RawError error);
		public bool set_dbus_connection (DBus.RawConnection conn);
		public bool set_user_data (pointer user_data);
		public pointer get_user_data ();
		public bool set_device_added (DeviceAdded _callback);
		public bool set_device_removed (DeviceRemoved _callback);
		[NoArrayLength]
		[CCode (cname = "libhal_find_device_by_capability")]
		public string[] find_device_by_capability (string capability, ref int num_devices, ref DBus.RawError error);

		[CCode (cname = "libhal_device_get_property_string")]
		public string device_get_property_string (string udi, string key, ref DBus.RawError error);
		[CCode (cname = "libhal_device_get_property_int")]
		public int device_get_property_int (string udi, string key, ref DBus.RawError error);
		[CCode (cname = "libhal_device_get_property_uint64")]
		public uint64 device_get_property_uint64 (string udi, string key, ref DBus.RawError error);
		[CCode (cname = "libhal_device_query_capability")]
		public bool device_query_capability (string udi, string capability, ref DBus.RawError error);
	}
}
