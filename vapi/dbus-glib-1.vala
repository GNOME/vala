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

[CCode (cheader_filename = "dbus/dbus-glib-lowlevel.h,dbus/dbus-glib.h")]
namespace DBus {
	[CCode (cprefix = "DBUS_BUS_")]
	public enum BusType {
		SESSION,
		SYSTEM,
		STARTER
	}

	public struct RawBus {
		[CCode (cname = "dbus_bus_get")]
		public static RawConnection get (BusType type, ref Error error);
	}

	[ReferenceType (dup_function = "dbus_connection_ref", free_function = "dbus_connection_unref")]
	[CCode (cname = "DBusConnection")]
	public struct RawConnection {
		[CCode (cname = "dbus_connection_setup_with_g_main")]
		public void setup_with_main (GLib.MainContext context = null);
	}

	[CCode (cname = "DBusError")]
	public struct RawError {
		public string name;
		public string message;

		[InstanceByReference]
		public void init ();
		[InstanceByReference]
		public bool has_name (string name);
		[InstanceByReference]
		public bool is_set ();
	}

	[ErrorDomain]
	[CCode (cname = "DBusGError", lower_case_csuffix = "gerror", cprefix = "DBUS_GERROR_")]
	public enum Error {
		FAILED,
		NO_MEMORY,
		SERVICE_UNKNOWN,
		NAME_HAS_NO_OWNER,
		NO_REPLY,
		IO_ERROR,
		BAD_ADDRESS,
		NOT_SUPPORTED,
		LIMITS_EXCEEDED,
		ACCESS_DENIED,
		AUTH_FAILED,
		NO_SERVER,
		TIMEOUT,
		NO_NETWORK,
		ADDRESS_IN_USE,
		DISCONNECTED,
		INVALID_ARGS,
		FILE_NOT_FOUND,
		FILE_EXISTS,
		UNKNOWN_METHOD,
		TIMED_OUT,
		MATCH_RULE_NOT_FOUND,
		MATCH_RULE_INVALID,
		SPAWN_EXEC_FAILED,
		SPAWN_FORK_FAILED,
		SPAWN_CHILD_EXITED,
		SPAWN_CHILD_SIGNALED,
		SPAWN_FAILED,
		UNIX_PROCESS_ID_UNKNOWN,
		INVALID_SIGNATURE,
		INVALID_FILE_CONTENT,
		SELINUX_SECURITY_CONTEXT_UNKNOWN,
		REMOTE_EXCEPTION
	}

	public struct Bus {
		[CCode (cname = "dbus_g_bus_get")]
		public static Connection get (BusType type) throws Error;
		
	}

	[ReferenceType (dup_function = "dbus_g_connection_ref", free_function = "dbus_g_connection_unref")]
	[CCode (cname = "DBusGConnection")]
	public struct Connection {
	}

	[CCode (cname = "DBusGProxy", lower_case_csuffix = "g_proxy")]
	public class Proxy {
		public Proxy.for_name (Connection! connection, string! name, string! path, string! interface_);
		public bool call (string! method, out GLib.Error error, GLib.Type first_arg_type, ...);
		public weak ProxyCall begin_call (string! method, ProxyCallNotify notify, pointer data, GLib.DestroyNotify destroy, GLib.Type first_arg_type, ...);
		public bool end_call (ProxyCall call, out GLib.Error error, GLib.Type first_arg_type, ...);
		public void cancel_call (ProxyCall call);
	}

	[CCode (cname = "DBusGProxyCallNotify")]
	public static delegate void ProxyCallNotify (Proxy proxy, ProxyCall call_id, pointer user_data);

	[ReferenceType]
	public struct ProxyCall {
	}
}
