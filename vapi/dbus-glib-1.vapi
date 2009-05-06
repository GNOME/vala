/* dbus-glib-1.vala
 *
 * Copyright (C) 2007-2009  Jürg Billeter
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

[CCode (cheader_filename = "dbus/dbus-glib-lowlevel.h,dbus/dbus-glib.h")]
namespace DBus {
	[CCode (cprefix = "DBUS_BUS_")]
	public enum BusType {
		SESSION,
		SYSTEM,
		STARTER
	}

	namespace RawBus {
		[CCode (cname = "dbus_bus_get")]
		public static RawConnection get (BusType type, ref RawError error);
	}

	[CCode (ref_function = "dbus_connection_ref", unref_function = "dbus_connection_unref", cname = "DBusConnection")]
	public class RawConnection {
		[CCode (cname = "dbus_connection_setup_with_g_main")]
		public void setup_with_main (GLib.MainContext? context = null);
		[CCode (cname = "dbus_connection_get_g_connection")]
		public Connection get_g_connection ();
		[CCode (cname = "dbus_connection_register_g_object")]
		public void register_object (string at_path, GLib.Object object);
	}

	[CCode (cname = "DBusError", cprefix = "dbus_error_", destroy_function = "dbus_error_free")]
	public struct RawError {
		public string name;
		public string message;

		public RawError ();
		public bool has_name (string name);
		public bool is_set ();
	}

	[DBus (name = "org.freedesktop.DBus.Error")]
	[CCode (cname = "DBusGError", lower_case_csuffix = "gerror", cprefix = "DBUS_GERROR_")]
	public errordomain Error {
		FAILED,
		NO_MEMORY,
		SERVICE_UNKNOWN,
		NAME_HAS_NO_OWNER,
		NO_REPLY,
		[DBus (name = "IOError")]
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
		[DBus (name = "Spawn.ExecFailed")]
		SPAWN_EXEC_FAILED,
		[DBus (name = "Spawn.ForkFailed")]
		SPAWN_FORK_FAILED,
		[DBus (name = "Spawn.ChildExited")]
		SPAWN_CHILD_EXITED,
		[DBus (name = "Spawn.ChildSignaled")]
		SPAWN_CHILD_SIGNALED,
		[DBus (name = "Spawn.Failed")]
		SPAWN_FAILED,
		UNIX_PROCESS_ID_UNKNOWN,
		INVALID_SIGNATURE,
		INVALID_FILE_CONTENT,
		[DBus (name = "SELinuxSecurityContextUnknown")]
		SELINUX_SECURITY_CONTEXT_UNKNOWN,
		REMOTE_EXCEPTION
	}

	public struct Bus {
		[CCode (cname = "dbus_g_bus_get")]
		public static Connection get (BusType type) throws Error;
	}

	[Compact]
	[CCode (ref_function = "dbus_g_connection_ref", unref_function = "dbus_g_connection_unref", cname = "DBusGConnection")]
	public class Connection {
		[CCode (cname = "dbus_g_proxy_new_for_name")]
		public Object get_object (string name, string path, string? interface_ = null);
		[CCode (cname = "dbus_g_proxy_new_from_type")]
		public GLib.Object get_object_from_type (string name, string path, string interface_, GLib.Type type);
		[CCode (cname = "dbus_g_connection_register_g_object")]
		public void register_object (string at_path, GLib.Object object);
		[CCode (cname = "dbus_g_connection_lookup_g_object")]
		public weak GLib.Object lookup_object (string at_path);
		[CCode (cname = "dbus_g_connection_get_connection")]
		public RawConnection get_connection ();
	}

	[CCode (cname = "DBusGProxy", lower_case_csuffix = "g_proxy")]
	public class Object : GLib.Object {
		public bool call (string method, out GLib.Error error, GLib.Type first_arg_type, ...);
		public weak ProxyCall begin_call (string method, ProxyCallNotify notify, GLib.DestroyNotify destroy, GLib.Type first_arg_type, ...);
		public bool end_call (ProxyCall call, out GLib.Error error, GLib.Type first_arg_type, ...);
		public void cancel_call (ProxyCall call);
		public weak string get_path ();
		public weak string get_bus_name ();
		public weak string get_interface ();
	}

	[CCode (cname = "char", const_cname = "const char", copy_function = "g_strdup", free_function = "g_free", cheader_filename = "stdlib.h,string.h,glib.h", type_id = "DBUS_TYPE_G_OBJECT_PATH", marshaller_type_name = "STRING", get_value_function = "g_value_get_string", set_value_function = "g_value_set_string", type_signature = "o")]
	public class ObjectPath : string {
		[CCode (cname = "g_strdup")]
		public ObjectPath (string path);
	}

	[CCode (cname = "char", const_cname = "const char", copy_function = "g_strdup", free_function = "g_free", cheader_filename = "stdlib.h,string.h,glib.h", type_id = "DBUS_TYPE_G_OBJECT_PATH", marshaller_type_name = "STRING", get_value_function = "g_value_get_string", set_value_function = "g_value_set_string")]
	public class BusName : string {
		[CCode (cname = "g_strdup")]
		public BusName (string bus_name);
	}

	[CCode (cname = "DBusGProxyCallNotify")]
	public delegate void ProxyCallNotify (Object obj, ProxyCall call_id);

	[CCode (cname = "DBusGProxyCall")]
	public class ProxyCall {
	}

	[Flags]
	public enum NameFlag {
		ALLOW_REPLACEMENT,
		REPLACE_EXISTING,
		DO_NOT_QUEUE
	}

	public enum RequestNameReply {
		PRIMARY_OWNER,
		IN_QUEUE,
		EXISTS,
		ALREADY_OWNER
	}
}
