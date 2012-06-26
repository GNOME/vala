namespace GLib {
	[CCode (cheader_filename = "gio/gio.h")]
	namespace Bus {
		public async GLib.DBusConnection get (GLib.BusType bus_type, GLib.Cancellable? cancellable = null) throws GLib.IOError;
		public GLib.DBusConnection get_sync (GLib.BusType bus_type, GLib.Cancellable? cancellable = null) throws GLib.IOError;
		public async T get_proxy<T> (GLib.BusType bus_type, string name, string object_path, GLib.DBusProxyFlags flags = 0, GLib.Cancellable? cancellable = null) throws GLib.IOError;
		public T get_proxy_sync<T> (GLib.BusType bus_type, string name, string object_path, GLib.DBusProxyFlags flags = 0, GLib.Cancellable? cancellable = null) throws GLib.IOError;
	}

	[Compact]
	[CCode (cname = "GSource", ref_function = "g_source_ref", unref_function = "g_source_unref")]
	public class CancellableSource : GLib.Source {
		[CCode (cname = "g_source_set_callback")]
		public void set_callback ([CCode (type = "GSourceFunc")] owned CancellableSourceFunc func);
	}

	public class DBusConnection : GLib.Object, GLib.AsyncInitable, GLib.Initable {
		[CCode (cname = "g_dbus_connection_new", finish_function = "g_dbus_connection_new_finish")]
		public static async GLib.DBusConnection @new (GLib.IOStream stream, string guid, GLib.DBusConnectionFlags flags, GLib.DBusAuthObserver? observer = null, GLib.Cancellable? cancellable = null) throws GLib.Error;
		[CCode (cname = "g_dbus_connection_new_for_address", finish_function = "g_dbus_connection_new_for_address_finish")]
		public static async GLib.DBusConnection @new_for_address (string address, GLib.DBusConnectionFlags flags, GLib.DBusAuthObserver? observer = null, GLib.Cancellable? cancellable = null) throws GLib.Error;
		public async T get_proxy<T> (string? name, string object_path, GLib.DBusProxyFlags flags = 0, GLib.Cancellable? cancellable = null) throws GLib.IOError; 
		public T get_proxy_sync<T> (string? name, string object_path, GLib.DBusProxyFlags flags = 0, GLib.Cancellable? cancellable = null) throws GLib.IOError;
		public uint register_object<T> (string object_path, T object) throws GLib.IOError;
	}

	public class DBusMessage : GLib.Object {
		[CCode (has_construct_function = false)]
		public DBusMessage.method_call (string name, string path, string interface_, string method);
		[PrintfFormat, CCode (has_construct_function = false)]
		public DBusMessage.method_error (GLib.DBusMessage method_call_message, string error_name, string error_message_format, ...);
		[CCode (has_construct_function = false)]
		public DBusMessage.method_error_literal (GLib.DBusMessage method_call_message, string error_name, string error_message);
		[CCode (has_construct_function = false)]
		public DBusMessage.method_error_valist (GLib.DBusMessage method_call_message, string error_name, string error_message_format, va_list var_args); 
		[CCode (has_construct_function = false)]
		public DBusMessage.method_reply (GLib.DBusMessage method_call_message);
	}

	[CCode (cheader_filename = "gio/gio.h", type_id = "g_dbus_object_manager_client_get_type ()")]
	public class DBusObjectManagerClient : GLib.Object, GLib.AsyncInitable, GLib.DBusObjectManager, GLib.Initable {
		[CCode (cname = "g_dbus_object_manager_client_new", finish_function = "g_dbus_object_manager_client_new_finish")]
		public static async GLib.DBusObjectManagerClient @new (GLib.DBusConnection connection, GLib.DBusObjectManagerClientFlags flags, string name, string object_path, [CCode (delegate_target_pos = 5.33333, destroy_notify_pos = 5.66667)] owned GLib.DBusProxyTypeFunc get_proxy_type_func, GLib.Cancellable? cancellable = null);
		[CCode (cname = "g_dbus_object_manager_client_new_for_bus", finish_function = "g_dbus_object_manager_client_new_for_bus_finish")]
		public static async GLib.DBusObjectManagerClient @new_for_bus (GLib.BusType bus_type, GLib.DBusObjectManagerClientFlags flags, string name, string object_path, [CCode (delegate_target_pos = 5.33333, destroy_notify_pos = 5.66667)] owned GLib.DBusProxyTypeFunc get_proxy_type_func, GLib.Cancellable? cancellable = null);
	}

	public class DBusProxy : GLib.Object, GLib.AsyncInitable, GLib.DBusInterface, GLib.Initable {
		[CCode (cname = "g_dbus_proxy_new", finish_function = "g_dbus_proxy_new_finish")]
		public static async GLib.DBusProxy @new (GLib.DBusConnection connection, GLib.DBusProxyFlags flags, GLib.DBusInterfaceInfo? info, string? name, string object_path, string interface_name, GLib.Cancellable? cancellable = null);
		[CCode (cname = "g_dbus_proxy_new_for_bus", finish_function = "g_dbus_proxy_new_for_bus_finish")]
		public static async GLib.DBusProxy create_for_bus (GLib.BusType bus_type, GLib.DBusProxyFlags flags, GLib.DBusInterfaceInfo? info, string name, string object_path, string interface_name, GLib.Cancellable? cancellable = null);
	}

	public class DataInputStream : GLib.BufferedInputStream {
		[CCode (cname = "g_data_input_stream_read_line_async", finish_function = "g_data_input_stream_read_line_finish_utf8")]
		public async string? read_line_utf8_async (int io_priority = GLib.Priority.DEFAULT, GLib.Cancellable? cancellable = null, out size_t length) throws GLib.IOError, GLib.IOError;
	}

	[Compact]
	public class IOModuleScope {
		[CCode (has_construct_function = false)]
		public IOModuleScope (GLib.IOModuleScopeFlags flags);
	}

	public abstract class IOStream : GLib.Object {
		[CCode (vfunc_name = "close_fn")]
		public virtual bool close (GLib.Cancellable? cancellable = null) throws GLib.IOError;
		public virtual async bool close_async (int io_priority = GLib.Priority.DEFAULT, GLib.Cancellable? cancellable = null) throws GLib.IOError;

	}

	public abstract class InputStream : GLib.Object {
		[CCode (vfunc_name = "close_fn")]
		public abstract bool close (GLib.Cancellable? cancellable = null) throws GLib.IOError;
		[CCode (vfunc_name = "read_fn")]
		public abstract ssize_t read ([CCode (array_length_type = "gsize")] uint8[] buffer, GLib.Cancellable? cancellable = null) throws GLib.IOError;
	}

	public class MemoryOutputStream : GLib.OutputStream {
		[CCode (has_construct_function = false, type = "GOutputStream*")]
		public MemoryOutputStream ([CCode (array_length_type = "gsize")] owned uint8[]? data, GLib.ReallocFunc? realloc_function, GLib.DestroyNotify? destroy_function);
	}

	public abstract class NativeVolumeMonitor : GLib.VolumeMonitor {
		[NoWrapper]
		public abstract GLib.Mount get_mount_for_mount_path (string mount_path, GLib.Cancellable? cancellable = null);
	}

	public abstract class OutputStream : GLib.Object {
		[CCode (vfunc_name = "close_fn")]
		public abstract bool close (GLib.Cancellable? cancellable = null) throws GLib.IOError;
		[CCode (vfunc_name = "write_fn")]
		public abstract ssize_t write ([CCode (array_length_type = "gsize")] uint8[] buffer, GLib.Cancellable? cancellable = null) throws GLib.IOError;
	}

	[Compact]
	[CCode (cname = "GSource", ref_function = "g_source_ref", unref_function = "g_source_unref")]
	public class PollableSource : GLib.Source {
		[CCode (type = "GSource*")]
		public PollableSource (GLib.Object pollable_stream);
		[CCode (type = "GSource*")]
		public PollableSource.full (GLib.Object pollable_stream, GLib.Source? child_source, GLib.Cancellable? cancellable = null);
		[CCode (cname = "g_source_set_callback")]
		public void set_callback ([CCode (type = "GSourceFunc")] owned PollableSourceFunc func);
	}

	public class Resolver : GLib.Object {
		[CCode (finish_function = "g_resolver_lookup_service_finish")]
		public async GLib.List<GLib.SrvTarget> lookup_service_async (string service, string protocol, string domain, GLib.Cancellable? cancellable = null) throws GLib.Error;
		[NoWrapper, CCode (vfunc_name = "lookup_service_async", finish_function = "g_resolver_lookup_service_finish")]
		public virtual async GLib.List<GLib.SrvTarget> lookup_service_fn_async (string rrname, GLib.Cancellable? cancellable = null);
	}

	public class Settings : GLib.Object {
		[NoAccessorMethod]
		public GLib.SettingsBackend backend { owned get; construct; }
		public virtual signal bool change_event (GLib.Quark[]? keys);
		public void bind_with_mapping (string key, GLib.Object object, string property, GLib.SettingsBindFlags flags, GLib.SettingsBindGetMappingShared get_mapping, GLib.SettingsBindSetMappingShared set_mapping, void* user_data, GLib.DestroyNotify? notify);
	}

	public class SettingsBackend : GLib.Object {
	}

	public class SimpleAsyncResult : GLib.Object, GLib.AsyncResult {
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

	public class SocketConnection : GLib.IOStream {
		public static GLib.SocketConnection factory_create_connection (GLib.Socket socket);
	}

	public class TlsPassword : GLib.Object {
		[CCode (vfunc_name = "set_value")]
		public virtual void set_value_full ([CCode (array_length_cname = "length", array_length_pos = 1.5, array_length_type = "gssize", type = "guchar*")] owned uint8[] value, GLib.DestroyNotify? notify = GLib.free);
	}

	public class VolumeMonitor : GLib.Object {
		[NoWrapper]
		public virtual bool is_supported ();
	}

	public interface AsyncInitable : GLib.Object {
		[CCode (finish_function = "g_async_initable_new_finish")]
		public static async GLib.Object new_async (GLib.Type object_type, int io_priority = GLib.Priority.DEFAULT, GLib.Cancellable? cancellable, ...) throws GLib.Error;
		[CCode (finish_function = "g_async_initable_new_finish")]
		public static async GLib.Object new_valist_async (GLib.Type object_type, string first_property_name, va_list var_args, int io_priority = GLib.Priority.DEFAULT, GLib.Cancellable? cancellable = null);
		[CCode (finish_function = "g_async_initable_new_finish")]
		public static async GLib.Object newv_async (GLib.Type object_type, [CCode (array_length_pos = 1.1)] GLib.Parameter[] parameters, int io_priority = GLib.Priority.DEFAULT, GLib.Cancellable? cancellable = null);
	}

	public interface File : GLib.Object {
		[NoWrapper, Deprecated (since = "vala-0.16", replacement = "has_prefix")]
		public abstract bool prefix_matches (GLib.File file);
		[NoWrapper, Deprecated (since = "vala-0.16", replacement = "read")]
		public abstract unowned GLib.FileInputStream read_fn (GLib.Cancellable? cancellable = null) throws GLib.Error;
	}

	public interface Icon : GLib.Object {
		[NoWrapper]
		public virtual bool to_tokens (GLib.GenericArray<string> tokens, out int out_version);
		[NoWrapper]
		public virtual GLib.Icon? from_tokens (string[] tokens, int version) throws GLib.Error;
	}

	public interface Initable : GLib.Object {
		public static GLib.Object @new (GLib.Type object_type, GLib.Cancellable? cancellable = null, ...) throws GLib.Error;
	}

	[Flags]
	public enum ConverterFlags {
		[Deprecated (since = "vala-0.16", replacement = "ConverterFlags.NONE")]
		NO_FLAGS
	}

	public delegate void SimpleActionActivateCallback (SimpleAction action, Variant? parameter);
	public delegate void SimpleActionChangeStateCallback (SimpleAction action, Variant value);
	[CCode (cheader_filename = "gio/gio.h", instance_pos = 6.9)]
	public delegate GLib.Variant DBusInterfaceGetPropertyFunc (GLib.DBusConnection connection, string sender, string object_path, string interface_name, string property_name) throws GLib.Error;
	[CCode (cheader_filename = "gio/gio.h", instance_pos = 7.9)]
	public delegate bool DBusInterfaceSetPropertyFunc (GLib.DBusConnection connection, string sender, string object_path, string interface_name, string property_name, GLib.Variant value) throws GLib.Error;
	[Deprecated (since = "vala-0.16", replacement = "File.equal")]
	public static GLib.EqualFunc file_equal;
	[Deprecated (since = "vala-0.16", replacement = "File.hash")]
	public static GLib.HashFunc file_hash;
	[Deprecated (since = "vala-0.12", replacement = "GLib.ContentType.can_be_executable")]
	[CCode (cname = "g_content_type_can_be_executable", cheader_filename = "gio/gio.h")]
	public static bool g_content_type_can_be_executable (string type);
	[Deprecated (since = "vala-0.12", replacement = "GLib.ContentType.equals")]
	[CCode (cname = "g_content_type_equals", cheader_filename = "gio/gio.h")]
	public static bool g_content_type_equals (string type1, string type2);
	[Deprecated (since = "vala-0.12", replacement = "GLib.ContentType.from_mime_type")]
	[CCode (cname = "g_content_type_from_mime_type", cheader_filename = "gio/gio.h")]
	public static string? g_content_type_from_mime_type (string mime_type);
	[Deprecated (since = "vala-0.12", replacement = "GLib.ContentType.get_description")]
	[CCode (cname = "g_content_type_get_description", cheader_filename = "gio/gio.h")]
	public static string g_content_type_get_description (string type);
	[Deprecated (since = "vala-0.12", replacement = "GLib.ContentType.get_icon")]
	[CCode (cname = "g_content_type_get_icon", cheader_filename = "gio/gio.h")]
	public static GLib.Icon g_content_type_get_icon (string type);
	[Deprecated (since = "vala-0.12", replacement = "GLib.ContentType.get_mime_type")]
	[CCode (cname = "g_content_type_get_mime_type", cheader_filename = "gio/gio.h")]
	public static string? g_content_type_get_mime_type (string type);
	[Deprecated (since = "vala-0.12", replacement = "GLib.ContentType.guess")]
	[CCode (cname = "g_content_type_guess", cheader_filename = "gio/gio.h")]
	public static string g_content_type_guess (string filename, uchar[] data, out bool result_uncertain);
	[Deprecated (since = "vala-0.12", replacement = "GLib.ContentType.guess_for_tree")]
	[CCode (cname = "g_content_type_guess_for_tree", cheader_filename = "gio/gio.h")]
	public static string g_content_type_guess_for_tree (GLib.File root);
	[Deprecated (since = "vala-0.12", replacement = "GLib.ContentType.is_a")]
	[CCode (cname = "g_content_type_is_a", cheader_filename = "gio/gio.h")]
	public static bool g_content_type_is_a (string type, string supertype);
	[Deprecated (since = "vala-0.12", replacement = "GLib.ContentType.is_unknown")]
	[CCode (cname = "g_content_type_is_unknown", cheader_filename = "gio/gio.h")]
	public static bool g_content_type_is_unknown (string type);

	[Deprecated (since = "vala-0.16", replacement = "FileAttribute.ACCESS_CAN_DELETE")]
	public const string FILE_ATTRIBUTE_ACCESS_CAN_DELETE;
	[Deprecated (since = "vala-0.16", replacement = "FileAttribute.ACCESS_CAN_EXECUTE")]
	public const string FILE_ATTRIBUTE_ACCESS_CAN_EXECUTE;
	[Deprecated (since = "vala-0.16", replacement = "FileAttribute.ACCESS_CAN_READ")]
	public const string FILE_ATTRIBUTE_ACCESS_CAN_READ;
	[Deprecated (since = "vala-0.16", replacement = "FileAttribute.ACCESS_CAN_RENAME")]
	public const string FILE_ATTRIBUTE_ACCESS_CAN_RENAME;
	[Deprecated (since = "vala-0.16", replacement = "FileAttribute.ACCESS_CAN_TRASH")]
	public const string FILE_ATTRIBUTE_ACCESS_CAN_TRASH;
	[Deprecated (since = "vala-0.16", replacement = "FileAttribute.ACCESS_CAN_WRITE")]
	public const string FILE_ATTRIBUTE_ACCESS_CAN_WRITE;
	[Deprecated (since = "vala-0.16", replacement = "FileAttribute.DOS_IS_ARCHIVE")]
	public const string FILE_ATTRIBUTE_DOS_IS_ARCHIVE;
	[Deprecated (since = "vala-0.16", replacement = "FileAttribute.DOS_IS_SYSTEM")]
	public const string FILE_ATTRIBUTE_DOS_IS_SYSTEM;
	[Deprecated (since = "vala-0.16", replacement = "FileAttribute.ETAG_VALUE")]
	public const string FILE_ATTRIBUTE_ETAG_VALUE;
	[Deprecated (since = "vala-0.16", replacement = "FileAttribute.FILESYSTEM_FREE")]
	public const string FILE_ATTRIBUTE_FILESYSTEM_FREE;
	[Deprecated (since = "vala-0.16", replacement = "FileAttribute.FILESYSTEM_READONLY")]
	public const string FILE_ATTRIBUTE_FILESYSTEM_READONLY;
	[Deprecated (since = "vala-0.16", replacement = "FileAttribute.FILESYSTEM_SIZE")]
	public const string FILE_ATTRIBUTE_FILESYSTEM_SIZE;
	[Deprecated (since = "vala-0.16", replacement = "FileAttribute.FILESYSTEM_TYPE")]
	public const string FILE_ATTRIBUTE_FILESYSTEM_TYPE;
	[Deprecated (since = "vala-0.16", replacement = "FileAttribute.FILESYSTEM_USE_PREVIEW")]
	public const string FILE_ATTRIBUTE_FILESYSTEM_USE_PREVIEW;
	[Deprecated (since = "vala-0.16", replacement = "FileAttribute.GVFS_BACKEND")]
	public const string FILE_ATTRIBUTE_GVFS_BACKEND;
	[Deprecated (since = "vala-0.16", replacement = "FileAttribute.ID_FILE")]
	public const string FILE_ATTRIBUTE_ID_FILE;
	[Deprecated (since = "vala-0.16", replacement = "FileAttribute.ID_FILESYSTEM")]
	public const string FILE_ATTRIBUTE_ID_FILESYSTEM;
	[Deprecated (since = "vala-0.16", replacement = "FileAttribute.MOUNTABLE_CAN_EJECT")]
	public const string FILE_ATTRIBUTE_MOUNTABLE_CAN_EJECT;
	[Deprecated (since = "vala-0.16", replacement = "FileAttribute.MOUNTABLE_CAN_MOUNT")]
	public const string FILE_ATTRIBUTE_MOUNTABLE_CAN_MOUNT;
	[Deprecated (since = "vala-0.16", replacement = "FileAttribute.MOUNTABLE_CAN_POLL")]
	public const string FILE_ATTRIBUTE_MOUNTABLE_CAN_POLL;
	[Deprecated (since = "vala-0.16", replacement = "FileAttribute.MOUNTABLE_CAN_START")]
	public const string FILE_ATTRIBUTE_MOUNTABLE_CAN_START;
	[Deprecated (since = "vala-0.16", replacement = "FileAttribute.MOUNTABLE_CAN_START_DEGRADED")]
	public const string FILE_ATTRIBUTE_MOUNTABLE_CAN_START_DEGRADED;
	[Deprecated (since = "vala-0.16", replacement = "FileAttribute.MOUNTABLE_CAN_STOP")]
	public const string FILE_ATTRIBUTE_MOUNTABLE_CAN_STOP;
	[Deprecated (since = "vala-0.16", replacement = "FileAttribute.MOUNTABLE_CAN_UNMOUNT")]
	public const string FILE_ATTRIBUTE_MOUNTABLE_CAN_UNMOUNT;
	[Deprecated (since = "vala-0.16", replacement = "FileAttribute.MOUNTABLE_HAL_UDI")]
	public const string FILE_ATTRIBUTE_MOUNTABLE_HAL_UDI;
	[Deprecated (since = "vala-0.16", replacement = "FileAttribute.MOUNTABLE_IS_MEDIA_CHECK_AUTOMATIC")]
	public const string FILE_ATTRIBUTE_MOUNTABLE_IS_MEDIA_CHECK_AUTOMATIC;
	[Deprecated (since = "vala-0.16", replacement = "FileAttribute.MOUNTABLE_START_STOP_TYPE")]
	public const string FILE_ATTRIBUTE_MOUNTABLE_START_STOP_TYPE;
	[Deprecated (since = "vala-0.16", replacement = "FileAttribute.MOUNTABLE_UNIX_DEVICE")]
	public const string FILE_ATTRIBUTE_MOUNTABLE_UNIX_DEVICE;
	[Deprecated (since = "vala-0.16", replacement = "FileAttribute.MOUNTABLE_UNIX_DEVICE_FILE")]
	public const string FILE_ATTRIBUTE_MOUNTABLE_UNIX_DEVICE_FILE;
	[Deprecated (since = "vala-0.16", replacement = "FileAttribute.OWNER_GROUP")]
	public const string FILE_ATTRIBUTE_OWNER_GROUP;
	[Deprecated (since = "vala-0.16", replacement = "FileAttribute.OWNER_USER")]
	public const string FILE_ATTRIBUTE_OWNER_USER;
	[Deprecated (since = "vala-0.16", replacement = "FileAttribute.OWNER_USER_REAL")]
	public const string FILE_ATTRIBUTE_OWNER_USER_REAL;
	[Deprecated (since = "vala-0.16", replacement = "FileAttribute.PREVIEW_ICON")]
	public const string FILE_ATTRIBUTE_PREVIEW_ICON;
	[Deprecated (since = "vala-0.16", replacement = "FileAttribute.SELINUX_CONTEXT")]
	public const string FILE_ATTRIBUTE_SELINUX_CONTEXT;
	[Deprecated (since = "vala-0.16", replacement = "FileAttribute.STANDARD_ALLOCATED_SIZE")]
	public const string FILE_ATTRIBUTE_STANDARD_ALLOCATED_SIZE;
	[Deprecated (since = "vala-0.16", replacement = "FileAttribute.STANDARD_CONTENT_TYPE")]
	public const string FILE_ATTRIBUTE_STANDARD_CONTENT_TYPE;
	[Deprecated (since = "vala-0.16", replacement = "FileAttribute.STANDARD_COPY_NAME")]
	public const string FILE_ATTRIBUTE_STANDARD_COPY_NAME;
	[Deprecated (since = "vala-0.16", replacement = "FileAttribute.STANDARD_DESCRIPTION")]
	public const string FILE_ATTRIBUTE_STANDARD_DESCRIPTION;
	[Deprecated (since = "vala-0.16", replacement = "FileAttribute.STANDARD_DISPLAY_NAME")]
	public const string FILE_ATTRIBUTE_STANDARD_DISPLAY_NAME;
	[Deprecated (since = "vala-0.16", replacement = "FileAttribute.STANDARD_EDIT_NAME")]
	public const string FILE_ATTRIBUTE_STANDARD_EDIT_NAME;
	[Deprecated (since = "vala-0.16", replacement = "FileAttribute.STANDARD_FAST_CONTENT_TYPE")]
	public const string FILE_ATTRIBUTE_STANDARD_FAST_CONTENT_TYPE;
	[Deprecated (since = "vala-0.16", replacement = "FileAttribute.STANDARD_ICON")]
	public const string FILE_ATTRIBUTE_STANDARD_ICON;
	[Deprecated (since = "vala-0.16", replacement = "FileAttribute.STANDARD_IS_BACKUP")]
	public const string FILE_ATTRIBUTE_STANDARD_IS_BACKUP;
	[Deprecated (since = "vala-0.16", replacement = "FileAttribute.STANDARD_IS_HIDDEN")]
	public const string FILE_ATTRIBUTE_STANDARD_IS_HIDDEN;
	[Deprecated (since = "vala-0.16", replacement = "FileAttribute.STANDARD_IS_SYMLINK")]
	public const string FILE_ATTRIBUTE_STANDARD_IS_SYMLINK;
	[Deprecated (since = "vala-0.16", replacement = "FileAttribute.STANDARD_IS_VIRTUAL")]
	public const string FILE_ATTRIBUTE_STANDARD_IS_VIRTUAL;
	[Deprecated (since = "vala-0.16", replacement = "FileAttribute.STANDARD_NAME")]
	public const string FILE_ATTRIBUTE_STANDARD_NAME;
	[Deprecated (since = "vala-0.16", replacement = "FileAttribute.STANDARD_SIZE")]
	public const string FILE_ATTRIBUTE_STANDARD_SIZE;
	[Deprecated (since = "vala-0.16", replacement = "FileAttribute.STANDARD_SORT_ORDER")]
	public const string FILE_ATTRIBUTE_STANDARD_SORT_ORDER;
	[Deprecated (since = "vala-0.16", replacement = "FileAttribute.STANDARD_SYMLINK_TARGET")]
	public const string FILE_ATTRIBUTE_STANDARD_SYMLINK_TARGET;
	[Deprecated (since = "vala-0.16", replacement = "FileAttribute.STANDARD_TARGET_URI")]
	public const string FILE_ATTRIBUTE_STANDARD_TARGET_URI;
	[Deprecated (since = "vala-0.16", replacement = "FileAttribute.STANDARD_TYPE")]
	public const string FILE_ATTRIBUTE_STANDARD_TYPE;
	[Deprecated (since = "vala-0.16", replacement = "FileAttribute.THUMBNAILING_FAILED")]
	public const string FILE_ATTRIBUTE_THUMBNAILING_FAILED;
	[Deprecated (since = "vala-0.16", replacement = "FileAttribute.THUMBNAIL_PATH")]
	public const string FILE_ATTRIBUTE_THUMBNAIL_PATH;
	[Deprecated (since = "vala-0.16", replacement = "FileAttribute.TIME_ACCESS")]
	public const string FILE_ATTRIBUTE_TIME_ACCESS;
	[Deprecated (since = "vala-0.16", replacement = "FileAttribute.TIME_ACCESS_USEC")]
	public const string FILE_ATTRIBUTE_TIME_ACCESS_USEC;
	[Deprecated (since = "vala-0.16", replacement = "FileAttribute.TIME_CHANGED")]
	public const string FILE_ATTRIBUTE_TIME_CHANGED;
	[Deprecated (since = "vala-0.16", replacement = "FileAttribute.TIME_CHANGED_USEC")]
	public const string FILE_ATTRIBUTE_TIME_CHANGED_USEC;
	[Deprecated (since = "vala-0.16", replacement = "FileAttribute.TIME_CREATED")]
	public const string FILE_ATTRIBUTE_TIME_CREATED;
	[Deprecated (since = "vala-0.16", replacement = "FileAttribute.TIME_CREATED_USEC")]
	public const string FILE_ATTRIBUTE_TIME_CREATED_USEC;
	[Deprecated (since = "vala-0.16", replacement = "FileAttribute.TIME_MODIFIED")]
	public const string FILE_ATTRIBUTE_TIME_MODIFIED;
	[Deprecated (since = "vala-0.16", replacement = "FileAttribute.TIME_MODIFIED_USEC")]
	public const string FILE_ATTRIBUTE_TIME_MODIFIED_USEC;
	[Deprecated (since = "vala-0.16", replacement = "FileAttribute.TRASH_DELETION_DATE")]
	public const string FILE_ATTRIBUTE_TRASH_DELETION_DATE;
	[Deprecated (since = "vala-0.16", replacement = "FileAttribute.TRASH_ITEM_COUNT")]
	public const string FILE_ATTRIBUTE_TRASH_ITEM_COUNT;
	[Deprecated (since = "vala-0.16", replacement = "FileAttribute.TRASH_ORIG_PATH")]
	public const string FILE_ATTRIBUTE_TRASH_ORIG_PATH;
	[Deprecated (since = "vala-0.16", replacement = "FileAttribute.UNIX_BLOCKS")]
	public const string FILE_ATTRIBUTE_UNIX_BLOCKS;
	[Deprecated (since = "vala-0.16", replacement = "FileAttribute.UNIX_BLOCK_SIZE")]
	public const string FILE_ATTRIBUTE_UNIX_BLOCK_SIZE;
	[Deprecated (since = "vala-0.16", replacement = "FileAttribute.UNIX_DEVICE")]
	public const string FILE_ATTRIBUTE_UNIX_DEVICE;
	[Deprecated (since = "vala-0.16", replacement = "FileAttribute.UNIX_GID")]
	public const string FILE_ATTRIBUTE_UNIX_GID;
	[Deprecated (since = "vala-0.16", replacement = "FileAttribute.UNIX_INODE")]
	public const string FILE_ATTRIBUTE_UNIX_INODE;
	[Deprecated (since = "vala-0.16", replacement = "FileAttribute.UNIX_IS_MOUNTPOINT")]
	public const string FILE_ATTRIBUTE_UNIX_IS_MOUNTPOINT;
	[Deprecated (since = "vala-0.16", replacement = "FileAttribute.UNIX_MODE")]
	public const string FILE_ATTRIBUTE_UNIX_MODE;
	[Deprecated (since = "vala-0.16", replacement = "FileAttribute.UNIX_NLINK")]
	public const string FILE_ATTRIBUTE_UNIX_NLINK;
	[Deprecated (since = "vala-0.16", replacement = "FileAttribute.UNIX_RDEV")]
	public const string FILE_ATTRIBUTE_UNIX_RDEV;
	[Deprecated (since = "vala-0.16", replacement = "FileAttribute.UNIX_UID")]
	public const string FILE_ATTRIBUTE_UNIX_UID;
	[Deprecated (since = "vala-0.16", replacement = "Menu.ATTRIBUTE_ACTION")]
	public const string MENU_ATTRIBUTE_ACTION;
	[Deprecated (since = "vala-0.16", replacement = "Menu.ATTRIBUTE_LABEL")]
	public const string MENU_ATTRIBUTE_LABEL;
	[Deprecated (since = "vala-0.16", replacement = "Menu.ATTRIBUTE_TARGET")]
	public const string MENU_ATTRIBUTE_TARGET;
	[Deprecated (since = "vala-0.16", replacement = "Menu.LINK_SECTION_SECTION")]
	public const string MENU_LINK_SECTION;
	[Deprecated (since = "vala-0.16", replacement = "Menu.LINK_SUBMENU")]
	public const string MENU_LINK_SUBMENU;
	[Deprecated (since = "vala-0.16", replacement = "IOExtensionPoint.NETWORK_MONITOR")]
	public const string NETWORK_MONITOR_EXTENSION_POINT_NAME;
	[Deprecated (since = "vala-0.16", replacement = "IOExtensionPoint.NATIVE_VOLUME_MONITOR")]
	public const string NATIVE_VOLUME_MONITOR_EXTENSION_POINT_NAME;
	[Deprecated (since = "vala-0.16", replacement = "IOExtensionPoint.PROXY")]
	public const string PROXY_EXTENSION_POINT_NAME;
	[Deprecated (since = "vala-0.16", replacement = "IOExtensionPoint.PROXY_RESOLVER")]
	public const string PROXY_RESOLVER_EXTENSION_POINT_NAME;
	[Deprecated (since = "vala-0.16", replacement = "IOExtensionPoint.TLS_BACKEND")]
	public const string TLS_BACKEND_EXTENSION_POINT_NAME;
	[Deprecated (since = "vala-0.16", replacement = "TlsDatabase.PURPOSE_AUTHENTICATE_CLIENT")]
	public const string TLS_DATABASE_PURPOSE_AUTHENTICATE_CLIENT;
	[Deprecated (since = "vala-0.16", replacement = "TlsDatabase.PURPOSE_AUTHENTICATE_SERVER")]
	public const string TLS_DATABASE_PURPOSE_AUTHENTICATE_SERVER;
	[Deprecated (since = "vala-0.16", replacement = "IOExtensionPoint.VFS")]
	public const string VFS_EXTENSION_POINT_NAME;
	[Deprecated (since = "vala-0.16", replacement = "GLib.VolumeIdentifier.HAL_UDI")]
	public const string VOLUME_IDENTIFIER_KIND_HAL_UDI;
	[Deprecated (since = "vala-0.16", replacement = "GLib.VolumeIdentifier.LABEL")]
	public const string VOLUME_IDENTIFIER_KIND_LABEL;
	[Deprecated (since = "vala-0.16", replacement = "GLib.VolumeIdentifier.NFS_MOUNT")]
	public const string VOLUME_IDENTIFIER_KIND_NFS_MOUNT;
	[Deprecated (since = "vala-0.16", replacement = "GLib.VolumeIdentifier.UNIX_DEVICE")]
	public const string VOLUME_IDENTIFIER_KIND_UNIX_DEVICE;
	[Deprecated (since = "vala-0.16", replacement = "GLib.VolumeIdentifier.UUID")]
	public const string VOLUME_IDENTIFIER_KIND_UUID;
	[Deprecated (since = "vala-0.16", replacement = "IOExtensionPoint.VOLUME_MONITOR")]
	public const string VOLUME_MONITOR_EXTENSION_POINT_NAME;

	[Deprecated (since = "vala-0.16", replacement = "ContentType.list_registered")]
	[CCode (cheader_filename = "gio/gio.h", cname = "g_content_types_get_registered")]
	public static GLib.List<string> g_content_types_get_registered ();
	[Deprecated (since = "vala-0.16", replacement = "BusType.get_address_sync")]
	[CCode (cheader_filename = "gio/gio.h", cname = "g_dbus_address_get_for_bus_sync")]
	public static unowned string g_dbus_address_get_for_bus_sync (GLib.BusType bus_type, GLib.Cancellable? cancellable = null) throws GLib.Error;
	[Deprecated (since = "vala-0.16", replacement = "DBus.address_get_stream")]
	[CCode (cheader_filename = "gio/gio.h", cname = "g_dbus_address_get_stream")]
	public static async void g_dbus_address_get_stream (string address, GLib.Cancellable? cancellable = null);
	[Deprecated (since = "vala-0.16", replacement = "DBus.address_get_stream_finish")]
	[CCode (cheader_filename = "gio/gio.h", cname = "g_dbus_address_get_stream_finish")]
	public static unowned GLib.IOStream g_dbus_address_get_stream_finish (GLib.AsyncResult res, string out_guid) throws GLib.Error;
	[Deprecated (since = "vala-0.16", replacement = "DBus.address_get_stream_sync")]
	[CCode (cheader_filename = "gio/gio.h", cname = "g_dbus_address_get_stream_sync")]
	public static unowned GLib.IOStream g_dbus_address_get_stream_sync (string address, string out_guid, GLib.Cancellable? cancellable = null) throws GLib.Error;
	[Deprecated (since = "vala-0.16", replacement = "DBusError.encode_gerror")]
	[CCode (cheader_filename = "gio/gio.h", cname = "g_dbus_error_encode_gerror")]
	public static unowned string g_dbus_error_encode_gerror (GLib.Error error);
	[Deprecated (since = "vala-0.16", replacement = "DBusError.get_remote_error")]
	[CCode (cheader_filename = "gio/gio.h", cname = "g_dbus_error_get_remote_error")]
	public static unowned string g_dbus_error_get_remote_error (GLib.Error error);
	[Deprecated (since = "vala-0.16", replacement = "DBusError.error_is_remote_error")]
	[CCode (cheader_filename = "gio/gio.h", cname = "g_dbus_error_is_remote_error")]
	public static bool g_dbus_error_is_remote_error (GLib.Error error);
	[Deprecated (since = "vala-0.16", replacement = "DBusError.new_for_dbus_error")]
	[CCode (cheader_filename = "gio/gio.h", cname = "g_dbus_error_new_for_dbus_error")]
	public static unowned GLib.Error g_dbus_error_new_for_dbus_error (string dbus_error_name, string dbus_error_message);
	[Deprecated (since = "vala-0.16", replacement = "DBusError.quark")]
	[CCode (cheader_filename = "gio/gio.h", cname = "g_dbus_error_quark")]
	public static GLib.Quark g_dbus_error_quark ();
	[Deprecated (since = "vala-0.16", replacement = "DBusError.register_error")]
	[CCode (cheader_filename = "gio/gio.h", cname = "g_dbus_error_register_error")]
	public static bool g_dbus_error_register_error (GLib.Quark error_domain, int error_code, string dbus_error_name);
	[Deprecated (since = "vala-0.16", replacement = "DBusError.register_error_domain")]
	[CCode (cheader_filename = "gio/gio.h", cname = "g_dbus_error_register_error_domain")]
	public static void g_dbus_error_register_error_domain (string error_domain_quark_name, size_t quark_volatile, GLib.DBusErrorEntry entries, uint num_entries);
	[Deprecated (since = "vala-0.16", replacement = "DBusError.set_dbus_error")]
	[CCode (cheader_filename = "gio/gio.h", cname = "g_dbus_error_set_dbus_error")]
	public static void g_dbus_error_set_dbus_error (string dbus_error_name, string dbus_error_message, string format) throws GLib.Error;
	[Deprecated (since = "vala-0.16", replacement = "DBusError.set_dbus_error_valist")]
	[CCode (cheader_filename = "gio/gio.h", cname = "g_dbus_error_set_dbus_error_valist")]
	public static void g_dbus_error_set_dbus_error_valist (string dbus_error_name, string dbus_error_message, string format, void* var_args) throws GLib.Error;
	[Deprecated (since = "vala-0.16", replacement = "DBusError.strip_remote_error")]
	[CCode (cheader_filename = "gio/gio.h", cname = "g_dbus_error_strip_remote_error")]
	public static bool g_dbus_error_strip_remote_error (GLib.Error error);
	[Deprecated (since = "vala-0.16", replacement = "DBusError.unregister_error")]
	[CCode (cheader_filename = "gio/gio.h", cname = "g_dbus_error_unregister_error")]
	public static bool g_dbus_error_unregister_error (GLib.Quark error_domain, int error_code, string dbus_error_name);
	[Deprecated (since = "vala-0.16", replacement = "DBus.generate_guid")]
	[CCode (cheader_filename = "gio/gio.h", cname = "g_dbus_generate_guid")]
	public static unowned string g_dbus_generate_guid ();
	[Deprecated (since = "vala-0.16", replacement = "DBus.gvalue_to_gvariant")]
	[CCode (cheader_filename = "gio/gio.h", cname = "g_dbus_gvalue_to_gvariant")]
	public static unowned GLib.Variant g_dbus_gvalue_to_gvariant (GLib.Value gvalue, GLib.VariantType type);
	[Deprecated (since = "vala-0.16", replacement = "DBus.gvariant_to_gvalue")]
	[CCode (cheader_filename = "gio/gio.h", cname = "g_dbus_gvariant_to_gvalue")]
	public static void g_dbus_gvariant_to_gvalue (GLib.Variant value, GLib.Value out_gvalue);
	[Deprecated (since = "vala-0.16", replacement = "DBus.is_address")]
	[CCode (cheader_filename = "gio/gio.h", cname = "g_dbus_is_address")]
	public static bool g_dbus_is_address (string str);
	[Deprecated (since = "vala-0.16", replacement = "DBus.is_guid")]
	[CCode (cheader_filename = "gio/gio.h", cname = "g_dbus_is_guid")]
	public static bool g_dbus_is_guid (string str);
	[Deprecated (since = "vala-0.16", replacement = "DBus.is_interface_name")]
	[CCode (cheader_filename = "gio/gio.h", cname = "g_dbus_is_interface_name")]
	public static bool g_dbus_is_interface_name (string str);
	[Deprecated (since = "vala-0.16", replacement = "DBus.is_member_name")]
	[CCode (cheader_filename = "gio/gio.h", cname = "g_dbus_is_member_name")]
	public static bool g_dbus_is_member_name (string str);
	[Deprecated (since = "vala-0.16", replacement = "DBus.is_name")]
	[CCode (cheader_filename = "gio/gio.h", cname = "g_dbus_is_name")]
	public static bool g_dbus_is_name (string str);
	[Deprecated (since = "vala-0.16", replacement = "DBus.is_supported_address")]
	[CCode (cheader_filename = "gio/gio.h", cname = "g_dbus_is_supported_address")]
	public static bool g_dbus_is_supported_address (string str) throws GLib.Error;
	[Deprecated (since = "vala-0.16", replacement = "DBus.is_unique_name")]
	[CCode (cheader_filename = "gio/gio.h", cname = "g_dbus_is_unique_name")]
	public static bool g_dbus_is_unique_name (string str);

	[Deprecated (since = "vala-0.16", replacement = "IOError.from_errno")]
	[CCode (cheader_filename = "gio/gio.h", cname = "g_io_error_from_errno")]
	public static unowned GLib.IOError g_io_error_from_errno (int err_no);
	[Deprecated (since = "vala-0.16", replacement = "IOError.quark")]
	[CCode (cheader_filename = "gio/gio.h", cname = "g_io_error_quark")]
	public static GLib.Quark g_io_error_quark ();

	[Deprecated (since = "vala-0.16", replacement = "IOModule.load_all_in_directory")]
	[CCode (cheader_filename = "gio/gio.h", cname = "g_io_modules_load_all_in_directory")]
	public static GLib.List<weak GLib.TypeModule> g_io_modules_load_all_in_directory (string dirname);
	[Deprecated (since = "vala-0.16", replacement = "IOModule.load_all_in_directory_with_scope")]
	[CCode (cheader_filename = "gio/gio.h", cname = "g_io_modules_load_all_in_directory_with_scope")]
	public static unowned GLib.List g_io_modules_load_all_in_directory_with_scope (string dirname, GLib.IOModuleScope scope);
	[Deprecated (since = "vala-0.16", replacement = "IOModule.scan_all_in_directory")]
	[CCode (cheader_filename = "gio/gio.h", cname = "g_io_modules_scan_all_in_directory")]
	public static void g_io_modules_scan_all_in_directory (string dirname);
	[Deprecated (since = "vala-0.16", replacement = "IOModule.xscan_all_in_directory_with_scope")]
	[CCode (cheader_filename = "gio/gio.h", cname = "g_io_modules_scan_all_in_directory_with_scope")]
	public static void g_io_modules_scan_all_in_directory_with_scope (string dirname, GLib.IOModuleScope scope);

	[Deprecated (since = "vala-0.16", replacement = "IOSchedulerJob.cancel_all")]
	[CCode (cheader_filename = "gio/gio.h", cname = "g_io_scheduler_cancel_all_jobs")]
	public static void g_io_scheduler_cancel_all_jobs ();
	[Deprecated (since = "vala-0.16", replacement = "IOSchedulerJob.push")]
	[CCode (cheader_filename = "gio/gio.h", cname = "g_io_scheduler_push_job")]
	public static void g_io_scheduler_push_job (owned GLib.IOSchedulerJobFunc job_func, int io_priority = GLib.Priority.DEFAULT, GLib.Cancellable? cancellable = null);

	[Deprecated (since = "vala-0.16", replacement = "PollableSource")]
	[CCode (cheader_filename = "gio/gio.h", cname = "g_pollable_source_new")]
	public static unowned GLib.TimeoutSource g_pollable_source_new (GLib.Object pollable_stream);

	[Deprecated (since = "vala-0.16", replacement = "report_error_in_idle")]
	[CCode (cheader_filename = "gio/gio.h", cname = "g_simple_async_report_error_in_idle")]
	public static void g_simple_async_report_error_in_idle (GLib.Object object, GLib.AsyncReadyCallback callback, GLib.Quark domain, int code, string format);
	[Deprecated (since = "vala-0.16", replacement = "report_gerror_in_idle")]
	[CCode (cheader_filename = "gio/gio.h", cname = "g_simple_async_report_gerror_in_idle")]
	public static void g_simple_async_report_gerror_in_idle (GLib.Object object, GLib.AsyncReadyCallback callback, GLib.Error error);
	[Deprecated (since = "vala-0.16", replacement = "report_take_gerror_in_idle")]
	[CCode (cheader_filename = "gio/gio.h", cname = "g_simple_async_report_take_gerror_in_idle")]
	public static void g_simple_async_report_take_gerror_in_idle (GLib.Object object, GLib.AsyncReadyCallback callback, GLib.Error error);

	[Deprecated (since = "vala-0.16", replacement = "TlsError.quark")]
	[CCode (cheader_filename = "gio/gio.h", cname = "g_tls_error_quark")]
	public static GLib.Quark g_tls_error_quark ();

	/*** Bug #: GIR parser doesn't pick up ref/unref functions ***/

	[CCode (cheader_filename = "gio/gio.h", ref_function = "g_dbus_annotation_info_ref", type_id = "g_dbus_annotation_info_get_type ()", unref_function = "g_dbus_annotation_info_unref")]
	[Compact]
	public class DBusAnnotationInfo {
	}

	[CCode (cheader_filename = "gio/gio.h", ref_function = "g_dbus_arg_info_ref", type_id = "g_dbus_arg_info_get_type ()", unref_function = "g_dbus_arg_info_unref")]
	[Compact]
	public class DBusArgInfo {
	}

	[CCode (ref_function = "g_dbus_interface_info_ref", type_id = "g_dbus_interface_info_get_type ()", unref_function = "g_dbus_interface_info_unref")]
	[Compact]
	public class DBusInterfaceInfo {
	}

	[CCode (ref_function = "g_dbus_method_info_ref", type_id = "g_dbus_method_info_get_type ()", unref_function = "g_dbus_method_info_unref")]
	[Compact]
	public class DBusMethodInfo {
	}

	[CCode (ref_function = "g_dbus_node_info_ref", type_id = "g_dbus_node_info_get_type ()", unref_function = "g_dbus_node_info_unref")]
	[Compact]
	public class DBusNodeInfo {
	}

	[CCode (ref_function = "g_dbus_signal_info_ref", type_id = "g_dbus_signal_info_get_type ()", unref_function = "g_dbus_signal_info_unref")]
	[Compact]
	public class DBusSignalInfo {
	}

	[CCode (ref_function = "g_file_attribute_info_list_ref", type_id = "g_file_attribute_info_list_get_type ()", unref_function = "g_file_attribute_info_list_unref")]
	[Compact]
	public class FileAttributeInfoList {
	}

	[CCode (ref_function = "g_file_attribute_matcher_ref", type_id = "g_file_attribute_matcher_get_type ()", unref_function = "g_file_attribute_matcher_unref")]
	[Compact]
	public class FileAttributeMatcher {
	}

	[CCode (ref_function = "g_resource_ref", type_id = "g_resource_get_type ()", unref_function = "g_resource_unref")]
	[Compact]
	public class Resource {
	}

	[CCode (cheader_filename = "gio/gio.h", has_target = false, cname = "GSettingsBindGetMapping")]
	public delegate bool SettingsBindGetMappingShared (GLib.Value value, GLib.Variant variant, void* user_data);
	[CCode (cheader_filename = "gio/gio.h", has_target = false, cname = "GSettingsBindSetMapping")]
	public delegate GLib.Variant SettingsBindSetMappingShared (GLib.Value value, GLib.VariantType expected_type, void* user_data);
}