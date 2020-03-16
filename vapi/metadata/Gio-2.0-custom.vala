namespace GLib {
	[CCode (cheader_filename = "glib.h", cname = "g_realloc")]
	public static GLib.ReallocFunc g_realloc;

	[CCode (cheader_filename = "gio/gio.h")]
	namespace Bus {
		public async GLib.DBusConnection get (GLib.BusType bus_type, GLib.Cancellable? cancellable = null) throws GLib.IOError;
		public GLib.DBusConnection get_sync (GLib.BusType bus_type, GLib.Cancellable? cancellable = null) throws GLib.IOError;
		public async T get_proxy<T> (GLib.BusType bus_type, string name, string object_path, GLib.DBusProxyFlags flags = 0, GLib.Cancellable? cancellable = null) throws GLib.IOError;
		public T get_proxy_sync<T> (GLib.BusType bus_type, string name, string object_path, GLib.DBusProxyFlags flags = 0, GLib.Cancellable? cancellable = null) throws GLib.IOError;
	}

	public struct ActionEntry {
		public weak string name;
		[CCode (delegate_target = false)]
		public weak GLib.SimpleActionActivateCallback? activate;
		public weak string? parameter_type;
		public weak string? state;
		[CCode (delegate_target = false)]
		public weak GLib.SimpleActionChangeStateCallback? change_state;
	}

	public class Cancellable : GLib.Object {
		[Version (since = "2.28", deprecated_since = "vala-0.44", replacement = "CancellableSource")]
		public GLib.CancellableSource source_new ();
	}

	[Compact]
	[CCode (cname = "GSource", ref_function = "g_source_ref", unref_function = "g_source_unref")]
	public class CancellableSource : GLib.Source {
		[CCode (cname = "g_source_set_callback")]
		public void set_callback ([CCode (type = "GSourceFunc")] owned CancellableSourceFunc func);
	}

	[CCode (cheader_filename = "gio/gio.h", type_id = "g_dbus_connection_get_type ()")]
	public class DBusConnection : GLib.Object {
		[CCode (cname = "g_dbus_connection_new", finish_name = "g_dbus_connection_new_finish")]
		[Version (deprecated_since = "vala-0.36", replacement = "DBusConnection")]
		public static async GLib.DBusConnection @new (GLib.IOStream stream, string? guid, GLib.DBusConnectionFlags flags, GLib.DBusAuthObserver? observer = null, GLib.Cancellable? cancellable = null) throws GLib.Error;
		[CCode (cname = "g_dbus_connection_new_for_address", finish_name = "g_dbus_connection_new_for_address_finish")]
		[Version (deprecated_since = "vala-0.36", replacement = "DBusConnection.for_address")]
		public static async GLib.DBusConnection @new_for_address (string address, GLib.DBusConnectionFlags flags, GLib.DBusAuthObserver? observer = null, GLib.Cancellable? cancellable = null) throws GLib.Error;
		public async T get_proxy<T> (string? name, string object_path, GLib.DBusProxyFlags flags = 0, GLib.Cancellable? cancellable = null) throws GLib.IOError; 
		public T get_proxy_sync<T> (string? name, string object_path, GLib.DBusProxyFlags flags = 0, GLib.Cancellable? cancellable = null) throws GLib.IOError;
		public uint register_object<T> (string object_path, T object) throws GLib.IOError;
	}

	[CCode (cheader_filename = "gio/gio.h", type_id = "g_dbus_object_manager_client_get_type ()")]
	public class DBusObjectManagerClient : GLib.Object {
		[CCode (cname = "g_dbus_object_manager_client_new", finish_name = "g_dbus_object_manager_client_new_finish")]
		[Version (deprecated_since = "vala-0.36", replacement = "DBusObjectManagerClient")]
		public static async GLib.DBusObjectManagerClient @new (GLib.DBusConnection connection, GLib.DBusObjectManagerClientFlags flags, string name, string object_path, [CCode (delegate_target_pos = 5.33333, destroy_notify_pos = 5.66667)] owned GLib.DBusProxyTypeFunc? get_proxy_type_func, GLib.Cancellable? cancellable = null) throws GLib.Error;
		[CCode (cname = "g_dbus_object_manager_client_new_for_bus", finish_name = "g_dbus_object_manager_client_new_for_bus_finish")]
		[Version (deprecated_since = "vala-0.36", replacement = "DBusObjectManagerClient.for_bus")]
		public static async GLib.DBusObjectManagerClient @new_for_bus (GLib.BusType bus_type, GLib.DBusObjectManagerClientFlags flags, string name, string object_path, [CCode (delegate_target_pos = 5.33333, destroy_notify_pos = 5.66667)] owned GLib.DBusProxyTypeFunc? get_proxy_type_func, GLib.Cancellable? cancellable = null) throws GLib.Error;
	}

	public class DBusProxy : GLib.Object {
		[CCode (cname = "g_dbus_proxy_new", finish_name = "g_dbus_proxy_new_finish")]
		[Version (deprecated_since = "vala-0.36", replacement = "DBusProxy")]
		public static async GLib.DBusProxy @new (GLib.DBusConnection connection, GLib.DBusProxyFlags flags, GLib.DBusInterfaceInfo? info, string? name, string object_path, string interface_name, GLib.Cancellable? cancellable = null) throws GLib.IOError;
		[CCode (cname = "g_dbus_proxy_new_for_bus", finish_name = "g_dbus_proxy_new_for_bus_finish")]
		[Version (deprecated_since = "vala-0.36", replacement = "DBusProxy.for_bus")]
		public static async GLib.DBusProxy create_for_bus (GLib.BusType bus_type, GLib.DBusProxyFlags flags, GLib.DBusInterfaceInfo? info, string name, string object_path, string interface_name, GLib.Cancellable? cancellable = null) throws GLib.IOError;
	}

	public class DataInputStream : GLib.BufferedInputStream {
		[CCode (cname = "g_data_input_stream_read_line_async", finish_name = "g_data_input_stream_read_line_finish_utf8")]
		public async string? read_line_utf8_async (int io_priority = GLib.Priority.DEFAULT, GLib.Cancellable? cancellable = null, out size_t length = null) throws GLib.IOError;
	}

	[CCode (cheader_filename = "gio/gio.h", type_id = "g_file_monitor_get_type ()")]
	public abstract class FileMonitor : GLib.Object {
		[Version (deprecated_since = "2.46")]
		public GLib.MainContext context { construct; }
	}

	[Compact]
	public class IOModuleScope {
		[CCode (has_construct_function = false)]
		public IOModuleScope (GLib.IOModuleScopeFlags flags);
	}

	public class MemoryOutputStream : GLib.OutputStream {
		[CCode (has_construct_function = false, type = "GOutputStream*")]
		public MemoryOutputStream ([CCode (array_length_type = "gsize")] owned uint8[]? data, GLib.ReallocFunc? realloc_function = GLib.g_realloc, GLib.DestroyNotify? destroy_function = GLib.g_free);
	}

	public abstract class NativeVolumeMonitor : GLib.VolumeMonitor {
		[NoWrapper]
		public abstract GLib.Mount get_mount_for_mount_path (string mount_path, GLib.Cancellable? cancellable = null);
	}

	[Compact]
	[CCode (cname = "GSource", ref_function = "g_source_ref", unref_function = "g_source_unref")]
	public class PollableSource : GLib.Source {
		[CCode (cname = "g_source_set_callback")]
		public void set_callback ([CCode (type = "GSourceFunc")] owned PollableSourceFunc func);
	}

	[CCode (cheader_filename = "gio/gio.h", type_id = "g_settings_get_type ()")]
	public class Settings : GLib.Object {
		public void bind_with_mapping (string key, GLib.Object object, string property, GLib.SettingsBindFlags flags, GLib.SettingsBindGetMappingShared get_mapping, GLib.SettingsBindSetMappingShared set_mapping, void* user_data, GLib.DestroyNotify? notify);
	}

	public class SimpleAsyncResult : GLib.Object {
		[CCode (has_construct_function = false)]
		public SimpleAsyncResult (GLib.Object? source_object, void* source_tag);
		[CCode (has_construct_function = false)]
		[PrintfFormat]
		public SimpleAsyncResult.error (GLib.Object? source_object, GLib.Quark domain, int code, string format, ...);
		[CCode (has_construct_function = false)]
		public SimpleAsyncResult.from_error (GLib.Object? source_object, GLib.Error error);
		[CCode (simple_generics = true)]
		public unowned T get_op_res_gpointer<T> ();
		[CCode (simple_generics = true)]
		public void set_op_res_gpointer<T> (owned T op_res);
	}

	[Compact]
	[CCode (cname = "GSource", ref_function = "g_source_ref", unref_function = "g_source_unref")]
	public class SocketSource : GLib.Source {
		[CCode (cname = "g_source_set_callback")]
		public void set_callback ([CCode (type = "GSourceFunc")] owned SocketSourceFunc func);
	}

	public class Task : GLib.Object {
		[CCode (has_construct_function = false)]
		[Version (since = "2.36")]
		public Task (GLib.Object? source_object, GLib.Cancellable? cancellable, [CCode (scope = "async")] GLib.TaskReadyCallback callback);
		[Version (since = "2.36")]
		public static void report_error (GLib.Object? source_object, [CCode (scope = "async")] GLib.TaskReadyCallback callback, void* source_tag, owned GLib.Error error);
		[PrintfFormat]
		[Version (since = "2.36")]
		public static void report_new_error (GLib.Object? source_object, [CCode (scope = "async")] GLib.TaskReadyCallback callback, void* source_tag, GLib.Quark domain, int code, string format, ...);
	}

	public class VolumeMonitor : GLib.Object {
		[NoWrapper]
		public virtual bool is_supported ();
	}

	public interface AsyncInitable : GLib.Object {
		[CCode (finish_name = "g_async_initable_new_finish")]
		public static async GLib.Object new_async (GLib.Type object_type, int io_priority = GLib.Priority.DEFAULT, GLib.Cancellable? cancellable, ...) throws GLib.Error;
		[CCode (finish_name = "g_async_initable_new_finish")]
		public static async GLib.Object new_valist_async (GLib.Type object_type, string first_property_name, va_list var_args, int io_priority = GLib.Priority.DEFAULT, GLib.Cancellable? cancellable = null);
		[CCode (finish_name = "g_async_initable_new_finish")]
		[Version (deprecated = true, deprecated_since = "2.54", since = "2.22")]
		public static async GLib.Object newv_async (GLib.Type object_type, [CCode (array_length_pos = 1.1)] GLib.Parameter[] parameters, int io_priority = GLib.Priority.DEFAULT, GLib.Cancellable? cancellable = null);
	}

	public interface File : GLib.Object {
		public virtual async bool copy_async (GLib.File destination, GLib.FileCopyFlags flags, int io_priority = GLib.Priority.DEFAULT, GLib.Cancellable? cancellable = null, GLib.FileProgressCallback? progress_callback = null) throws GLib.Error;
		public async bool load_partial_contents_async (GLib.Cancellable? cancellable = null, [CCode (delegate_target_pos = -0.9)] GLib.FileReadMoreCallback read_more_callback, [CCode (array_length_cname = "length", array_length_pos = 2.5, array_length_type = "gsize")] out uint8[] contents, out string etag_out) throws GLib.Error;
		[Version (since = "2.56")]
		public static GLib.File new_build_filename (string first_element, ...);
	}

	public interface Icon : GLib.Object {
		[NoWrapper]
		public virtual bool to_tokens (GLib.GenericArray<string> tokens, out int out_version);
		[NoWrapper]
		public virtual GLib.Icon? from_tokens (string[] tokens, int version) throws GLib.Error;
	}

	public errordomain IOError {
		[CCode (cname = "vala_g_io_error_from_errno")]
		public static GLib.IOError from_errno (int err_no) {
			return (GLib.IOError) new GLib.Error (GLib.IOError.quark (), GLib.IOError._from_errno (err_no), "%s", GLib.strerror (err_no));
		}
		[CCode (cname = "g_io_error_from_win32_error")]
		public static int _from_win32_error (int error_code);
		[CCode (cname = "vala_g_io_error_from_win32_error")]
		public static GLib.IOError from_win32_error (int error_code) {
			return (GLib.IOError) new GLib.Error (GLib.IOError.quark (), GLib.IOError._from_win32_error (error_code), "%s", GLib.Win32.error_message (error_code));
		}
	}

	public delegate void SimpleActionActivateCallback (SimpleAction action, Variant? parameter);
	public delegate void SimpleActionChangeStateCallback (SimpleAction action, Variant value);
	[CCode (cheader_filename = "gio/gio.h", cname = "GAsyncReadyCallback", instance_pos = 2.9)]
	public delegate void TaskReadyCallback (GLib.Object? source_object, GLib.Task task);
	[CCode (has_target = false, cname = "GSourceFunc")]
	public delegate bool TaskSourceFunc (Task task);

	[CCode (cheader_filename = "gio/gio.h", has_target = false, cname = "GSettingsBindGetMapping")]
	public delegate bool SettingsBindGetMappingShared (GLib.Value value, GLib.Variant variant, void* user_data);
	[CCode (cheader_filename = "gio/gio.h", has_target = false, cname = "GSettingsBindSetMapping")]
	public delegate GLib.Variant SettingsBindSetMappingShared (GLib.Value value, GLib.VariantType expected_type, void* user_data);
}
