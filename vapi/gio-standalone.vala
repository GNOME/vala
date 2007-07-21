[CCode (cprefix = "G", lower_case_cprefix = "g_")]
namespace GLib {
	[CCode (cprefix = "G_DIRECTORY_MONITOR_EVENT_", cheader_filename = "gio/gvfs.h, glib.h")]
	public enum DirectoryMonitorEvent {
		CHANGED,
		DELETED,
		CREATED,
		ATTRIBUTE_CHANGED,
		UNMOUNTED,
	}
	[CCode (cprefix = "G_FILE_ATTRIBUTE_TYPE_", cheader_filename = "gio/gvfs.h, glib.h")]
	public enum FileAttributeType {
		INVALID,
		STRING,
		BYTE_STRING,
		UINT32,
		INT32,
		UINT64,
		INT64,
	}
	[CCode (cprefix = "G_FILE_COPY_", cheader_filename = "gio/gvfs.h, glib.h")]
	public enum FileCopyFlags {
		OVERWRITE,
		BACKUP,
	}
	[CCode (cprefix = "G_FILE_FLAG_", cheader_filename = "gio/gvfs.h, glib.h")]
	public enum FileFlags {
		HIDDEN,
		SYMLINK,
		LOCAL,
		VIRTUAL,
	}
	[CCode (cprefix = "G_FILE_GET_INFO_NOFOLLOW_", cheader_filename = "gio/gvfs.h, glib.h")]
	public enum FileGetInfoFlags {
		SYMLINKS,
	}
	[CCode (cprefix = "G_FILE_MONITOR_EVENT_", cheader_filename = "gio/gvfs.h, glib.h")]
	public enum FileMonitorEvent {
		CHANGED,
		DELETED,
		CREATED,
		ATTRIBUTE_CHANGED,
		UNMOUNTED,
	}
	[CCode (cprefix = "G_FILE_TYPE_", cheader_filename = "gio/gvfs.h, glib.h")]
	public enum FileType {
		UNKNOWN,
		REGULAR,
		DIRECTORY,
		SYMBOLIC_LINK,
		SPECIAL,
		SHORTCUT,
		MOUNTABLE,
	}
	[CCode (cprefix = "G_IO_ERROR_", cheader_filename = "gio/gvfs.h, glib.h")]
	public enum IOErrorEnum {
		FAILED,
		NOT_FOUND,
		EXISTS,
		IS_DIRECTORY,
		NOT_DIRECTORY,
		NOT_EMPTY,
		NOT_REGULAR_FILE,
		NOT_SYMBOLIC_LINK,
		NOT_MOUNTABLE,
		FILENAME_TOO_LONG,
		INVALID_FILENAME,
		TOO_MANY_LINKS,
		NO_SPACE,
		INVALID_ARGUMENT,
		PERMISSION_DENIED,
		NOT_SUPPORTED,
		NOT_MOUNTED,
		ALREADY_MOUNTED,
		CLOSED,
		CANCELLED,
		PENDING,
		READ_ONLY,
		CANT_CREATE_BACKUP,
		WRONG_MTIME,
		TIMED_OUT,
	}
	[CCode (cprefix = "G_PASSWORD_FLAGS_", cheader_filename = "gio/gvfs.h, glib.h")]
	public enum PasswordFlags {
		NEED_PASSWORD,
		NEED_USERNAME,
		NEED_DOMAIN,
		SAVING_SUPPORTED,
		ANON_SUPPORTED,
	}
	[CCode (cprefix = "G_PASSWORD_SAVE_", cheader_filename = "gio/gvfs.h, glib.h")]
	public enum PasswordSave {
		NEVER,
		FOR_SESSION,
		PERMANENTLY,
	}
	[CCode (cprefix = "G_UNIX_MOUNT_TYPE_", cheader_filename = "gio/gvfs.h, glib.h")]
	public enum UnixMountType {
		UNKNOWN,
		FLOPPY,
		CDROM,
		NFS,
		ZIP,
		JAZ,
		MEMSTICK,
		CF,
		SM,
		SDMMC,
		IPOD,
		CAMERA,
		HD,
	}
	[CCode (cheader_filename = "gio/gvfs.h, glib.h")]
	public class BufferedInputStream : GLib.FilterInputStream {
		public static GLib.Type get_type ();
		public BufferedInputStream (GLib.InputStream base_stream);
		public BufferedInputStream.sized (GLib.InputStream base_stream, uint size);
		[NoAccessorMethod]
		public weak uint buffer_size { get; construct; }
	}
	[CCode (cheader_filename = "gio/gvfs.h, glib.h")]
	public class BufferedOutputStream : GLib.FilterOutputStream {
		public static GLib.Type get_type ();
		public BufferedOutputStream (GLib.OutputStream base_stream);
		public BufferedOutputStream.sized (GLib.OutputStream base_stream, uint size);
		[NoAccessorMethod]
		public weak uint buffer_size { get; construct; }
	}
	[CCode (cheader_filename = "gio/gvfs.h, glib.h")]
	public class Cancellable : GLib.Object {
		public void cancel ();
		public int get_fd ();
		public static GLib.Type get_type ();
		public bool is_cancelled ();
		public Cancellable ();
		public void reset ();
		public signal void cancelled ();
	}
	[CCode (cheader_filename = "gio/gvfs.h, glib.h")]
	public class DesktopAppInfo : GLib.Object, GLib.AppInfo {
		public static GLib.Type get_type ();
		public DesktopAppInfo (string desktop_id);
	}
	[CCode (cheader_filename = "gio/gvfs.h, glib.h")]
	public class DirectoryMonitor : GLib.Object {
		public virtual bool cancel ();
		public void emit_event (GLib.File child, GLib.File other_file, GLib.DirectoryMonitorEvent event_type);
		public static GLib.Type get_type ();
		public void set_rate_limit (int limit_msecs);
		public signal void changed (GLib.File child, GLib.File other_file, GLib.DirectoryMonitorEvent event_type);
	}
	[CCode (cheader_filename = "gio/gvfs.h, glib.h")]
	public class FileEnumerator : GLib.Object {
		public static GLib.Type get_type ();
		public bool has_pending ();
		public bool is_stopped ();
		public virtual weak GLib.FileInfo next_file (GLib.Cancellable cancellable, GLib.Error error);
		public virtual void next_files_async (int num_files, int io_priority, GLib.AsyncNextFilesCallback callback, pointer user_data, GLib.Cancellable cancellable);
		public void set_pending (bool pending);
		public virtual bool stop (GLib.Cancellable cancellable, GLib.Error error);
		public virtual void stop_async (int io_priority, GLib.AsyncStopEnumeratingCallback callback, pointer user_data, GLib.Cancellable cancellable);
	}
	[CCode (cheader_filename = "gio/gvfs.h, glib.h")]
	public class FileIcon : GLib.Object, GLib.Icon, GLib.LoadableIcon {
		public weak GLib.File get_file ();
		public static GLib.Type get_type ();
		public FileIcon (GLib.File file);
	}
	[CCode (cheader_filename = "gio/gvfs.h, glib.h")]
	public class FileInfo : GLib.Object {
		public weak GLib.FileInfo copy ();
		public weak string get_attribute_as_string (string attribute);
		public weak string get_attribute_byte_string (string attribute);
		public int get_attribute_int32 (string attribute);
		public int64 get_attribute_int64 (string attribute);
		public weak string get_attribute_string (string attribute);
		public GLib.FileAttributeType get_attribute_type (string attribute);
		public uint get_attribute_uint32 (string attribute);
		public uint64 get_attribute_uint64 (string attribute);
		public weak string get_content_type ();
		public weak string get_display_name ();
		public weak string get_edit_name ();
		public GLib.FileType get_file_type ();
		public GLib.FileFlags get_flags ();
		public weak string get_icon ();
		public void get_modification_time (GLib.TimeVal result);
		public weak string get_name ();
		public int64 get_size ();
		public weak string get_symlink_target ();
		public static GLib.Type get_type ();
		public bool has_attribute (string attribute);
		public weak string list_attributes (string name_space);
		public FileInfo ();
		public void remove_attribute (string attribute);
		public void set_attribute_byte_string (string attribute, string value);
		public void set_attribute_int32 (string attribute, int value);
		public void set_attribute_int64 (string attribute, int64 value);
		public void set_attribute_string (string attribute, string value);
		public void set_attribute_uint32 (string attribute, uint value);
		public void set_attribute_uint64 (string attribute, uint64 value);
		public void set_content_type (string content_type);
		public void set_display_name (string display_name);
		public void set_edit_name (string edit_name);
		public void set_file_type (GLib.FileType type);
		public void set_flags (GLib.FileFlags flags);
		public void set_icon (string icon);
		public void set_modification_time (GLib.TimeVal mtime);
		public void set_name (string name);
		public void set_size (int64 size);
		public void set_symlink_target (string symlink_target);
	}
	[CCode (cheader_filename = "gio/gvfs.h, glib.h")]
	public class FileInputStream : GLib.InputStream, GLib.Seekable {
		public virtual weak GLib.FileInfo get_file_info (string attributes, GLib.Cancellable cancellable, GLib.Error error);
		public static GLib.Type get_type ();
	}
	[CCode (cheader_filename = "gio/gvfs.h, glib.h")]
	public class FileMonitor : GLib.Object {
		public virtual bool cancel ();
		public static weak GLib.DirectoryMonitor directory (GLib.File file);
		public void emit_event (GLib.File file, GLib.File other_file, GLib.FileMonitorEvent event_type);
		public static weak GLib.FileMonitor file (GLib.File file);
		public static GLib.Type get_type ();
		public void set_rate_limit (int limit_msecs);
		public signal void changed (GLib.File file, GLib.File other_file, GLib.FileMonitorEvent event_type);
	}
	[CCode (cheader_filename = "gio/gvfs.h, glib.h")]
	public class FileOutputStream : GLib.OutputStream {
		public virtual weak GLib.FileInfo get_file_info (string attributes, GLib.Cancellable cancellable, GLib.Error error);
		public void get_final_mtime (GLib.TimeVal mtime);
		public bool get_should_get_final_mtime ();
		public static GLib.Type get_type ();
		public void set_final_mtime (GLib.TimeVal final_mtime);
		public void set_should_get_final_mtime (bool get_final_mtime);
	}
	[CCode (cheader_filename = "gio/gvfs.h, glib.h")]
	public class FilterInputStream : GLib.InputStream {
		public weak GLib.InputStream get_base_stream ();
		public static GLib.Type get_type ();
		[NoAccessorMethod]
		public weak GLib.InputStream base_stream { get; construct; }
	}
	[CCode (cheader_filename = "gio/gvfs.h, glib.h")]
	public class FilterOutputStream : GLib.OutputStream {
		public weak GLib.OutputStream get_base_stream ();
		public static GLib.Type get_type ();
		[NoAccessorMethod]
		public weak GLib.OutputStream base_stream { get; construct; }
	}
	[CCode (cheader_filename = "gio/gvfs.h, glib.h")]
	public class InputStream : GLib.Object {
		public virtual bool close (GLib.Cancellable cancellable, GLib.Error error);
		public virtual void close_async (int io_priority, GLib.Cancellable cancellable, GLib.AsyncReadyCallback callback, pointer user_data);
		public virtual bool close_finish (GLib.AsyncResult result, GLib.Error error);
		public static GLib.Type get_type ();
		public bool has_pending ();
		public bool is_closed ();
		public virtual long read (pointer buffer, ulong count, GLib.Cancellable cancellable, GLib.Error error);
		public bool read_all (pointer buffer, ulong count, ulong bytes_read, GLib.Cancellable cancellable, GLib.Error error);
		public virtual void read_async (pointer buffer, ulong count, int io_priority, GLib.Cancellable cancellable, GLib.AsyncReadyCallback callback, pointer user_data);
		public virtual long read_finish (GLib.AsyncResult result, GLib.Error error);
		public void set_pending (bool pending);
		public virtual long skip (ulong count, GLib.Cancellable cancellable, GLib.Error error);
		public virtual void skip_async (ulong count, int io_priority, GLib.Cancellable cancellable, GLib.AsyncReadyCallback callback, pointer user_data);
		public virtual long skip_finish (GLib.AsyncResult result, GLib.Error error);
	}
	[CCode (cheader_filename = "gio/gvfs.h, glib.h")]
	public class LocalDirectoryMonitor : GLib.DirectoryMonitor {
		public static GLib.Type get_type ();
		public static weak GLib.DirectoryMonitor start (string dirname);
	}
	[CCode (cheader_filename = "gio/gvfs.h, glib.h")]
	public class LocalFile : GLib.Object, GLib.File {
		public static GLib.Type get_type ();
		public static weak GLib.FileInfo info_get (string basename, string path, GLib.FileAttributeMatcher attribute_matcher, GLib.FileGetInfoFlags flags, GLib.LocalParentFileInfo parent_info, GLib.Error error);
		public static weak GLib.FileInfo info_get_from_fd (int fd, string attributes, GLib.Error error);
		public static void info_get_parent_info (string dir, GLib.FileAttributeMatcher attribute_matcher, GLib.LocalParentFileInfo parent_info);
		public LocalFile (string filename);
	}
	[CCode (cheader_filename = "gio/gvfs.h, glib.h")]
	public class LocalFileEnumerator : GLib.FileEnumerator {
		public static GLib.Type get_type ();
		public LocalFileEnumerator (string filename, string attributes, GLib.FileGetInfoFlags flags, GLib.Cancellable cancellable, GLib.Error error);
	}
	[CCode (cheader_filename = "gio/gvfs.h, glib.h")]
	public class LocalFileInputStream : GLib.FileInputStream {
		public static GLib.Type get_type ();
		public LocalFileInputStream (int fd);
	}
	[CCode (cheader_filename = "gio/gvfs.h, glib.h")]
	public class LocalFileMonitor : GLib.FileMonitor {
		public static GLib.Type get_type ();
		public static weak GLib.FileMonitor start (string dirname);
	}
	[CCode (cheader_filename = "gio/gvfs.h, glib.h")]
	public class LocalFileOutputStream : GLib.FileOutputStream {
		public static weak GLib.FileOutputStream append (string filename, GLib.Cancellable cancellable, GLib.Error error);
		public static weak GLib.FileOutputStream create (string filename, GLib.Cancellable cancellable, GLib.Error error);
		public static GLib.Type get_type ();
		public static weak GLib.FileOutputStream replace (string filename, ulong mtime, bool make_backup, GLib.Cancellable cancellable, GLib.Error error);
	}
	[CCode (cheader_filename = "gio/gvfs.h, glib.h")]
	public class LocalVfs : GLib.Object, GLib.Vfs {
		public static GLib.Type get_type ();
		public LocalVfs ();
	}
	[CCode (cheader_filename = "gio/gvfs.h, glib.h")]
	public class MemoryInputStream : GLib.InputStream, GLib.Seekable {
		public static weak GLib.InputStream from_data (pointer data, ulong len);
		public static GLib.Type get_type ();
	}
	[CCode (cheader_filename = "gio/gvfs.h, glib.h")]
	public class MemoryOutputStream : GLib.OutputStream, GLib.Seekable {
		public static GLib.Type get_type ();
		public MemoryOutputStream (GLib.ByteArray data);
		public void set_max_size (uint max_size);
		[NoAccessorMethod]
		public weak pointer data { get; set construct; }
		[NoAccessorMethod]
		public weak bool free_array { get; set; }
		[NoAccessorMethod]
		public weak uint size_limit { get; set; }
	}
	[CCode (cheader_filename = "gio/gvfs.h, glib.h")]
	public class MountOperation : GLib.Object {
		public bool get_anonymous ();
		public int get_choice ();
		public weak string get_domain ();
		public weak string get_password ();
		public GLib.PasswordSave get_password_save ();
		public static GLib.Type get_type ();
		public weak string get_username ();
		public MountOperation ();
		public void set_anonymous (bool anonymous);
		public void set_choice (int choice);
		public void set_domain (string domain);
		public void set_password (string password);
		public void set_password_save (GLib.PasswordSave save);
		public void set_username (string username);
		public signal bool ask_password (string message, string default_user, string default_domain, GLib.PasswordFlags flags);
		public signal bool ask_question (string message, string[] choices);
		[HasEmitter]
		public signal void reply (bool abort);
	}
	[CCode (cheader_filename = "gio/gvfs.h, glib.h")]
	public class OutputStream : GLib.Object {
		public virtual bool close (GLib.Cancellable cancellable, GLib.Error error);
		public virtual void close_async (int io_priority, GLib.Cancellable cancellable, GLib.AsyncReadyCallback callback, pointer user_data);
		public virtual bool close_finish (GLib.AsyncResult result, GLib.Error error);
		public virtual bool flush (GLib.Cancellable cancellable, GLib.Error error);
		public virtual void flush_async (int io_priority, GLib.Cancellable cancellable, GLib.AsyncReadyCallback callback, pointer user_data);
		public virtual bool flush_finish (GLib.AsyncResult result, GLib.Error error);
		public static GLib.Type get_type ();
		public bool has_pending ();
		public bool is_closed ();
		public void set_pending (bool pending);
		public virtual long write (pointer buffer, ulong count, GLib.Cancellable cancellable, GLib.Error error);
		public bool write_all (pointer buffer, ulong count, ulong bytes_written, GLib.Cancellable cancellable, GLib.Error error);
		public virtual void write_async (pointer buffer, ulong count, int io_priority, GLib.Cancellable cancellable, GLib.AsyncReadyCallback callback, pointer user_data);
		public virtual long write_finish (GLib.AsyncResult result, GLib.Error error);
	}
	[CCode (cheader_filename = "gio/gvfs.h, glib.h")]
	public class SimpleAsyncResult : GLib.Object, GLib.AsyncResult {
		public void complete ();
		public void complete_in_idle ();
		public bool get_op_res_gboolean ();
		public pointer get_op_res_gpointer ();
		public long get_op_res_gssize ();
		public pointer get_source_tag ();
		public static GLib.Type get_type ();
		public SimpleAsyncResult (GLib.Object source_object, GLib.AsyncReadyCallback callback, pointer user_data, pointer source_tag);
		public SimpleAsyncResult.error (GLib.Object source_object, GLib.AsyncReadyCallback callback, pointer user_data, GLib.Quark domain, int code, string format);
		public SimpleAsyncResult.from_error (GLib.Object source_object, GLib.AsyncReadyCallback callback, pointer user_data, GLib.Error error);
		public bool propagate_error (GLib.Error dest);
		public void run_in_thread (GLib.SimpleAsyncThreadFunc func, int io_priority, GLib.Cancellable cancellable);
		public void set_error (GLib.Quark domain, int code, string format);
		public void set_error_va (GLib.Quark domain, int code, string format, pointer args);
		public void set_from_error (GLib.Error error);
		public void set_handle_cancellation (bool handle_cancellation);
		public void set_op_res_gboolean (bool op_res);
		public void set_op_res_gpointer (pointer op_res, GLib.DestroyNotify destroy_op_res);
		public void set_op_res_gssize (long op_res);
	}
	[CCode (cheader_filename = "gio/gvfs.h, glib.h")]
	public class SocketInputStream : GLib.InputStream {
		public static GLib.Type get_type ();
		public SocketInputStream (int fd, bool close_fd_at_close);
	}
	[CCode (cheader_filename = "gio/gvfs.h, glib.h")]
	public class SocketOutputStream : GLib.OutputStream {
		public static GLib.Type get_type ();
		public SocketOutputStream (int fd, bool close_fd_at_close);
	}
	[CCode (cheader_filename = "gio/gvfs.h, glib.h")]
	public class ThemedIcon : GLib.Object, GLib.Icon {
		public weak string get_names ();
		public static GLib.Type get_type ();
		public ThemedIcon (string iconname);
		public ThemedIcon.from_names (string iconnames);
	}
	[CCode (cheader_filename = "gio/gvfs.h, glib.h")]
	public class UnionDrive : GLib.Object, GLib.Drive {
		public bool child_is_for_monitor (GLib.VolumeMonitor child_monitor);
		public static GLib.Type get_type ();
		public bool is_for_child_drive (GLib.Drive child_drive);
		public UnionDrive (GLib.VolumeMonitor union_monitor, GLib.Drive child_drive, GLib.VolumeMonitor child_monitor);
	}
	[CCode (cheader_filename = "gio/gvfs.h, glib.h")]
	public class UnionVolume : GLib.Object, GLib.Volume {
		public void add_volume (GLib.Volume volume, GLib.VolumeMonitor monitor);
		public weak GLib.Volume get_child_for_monitor (GLib.VolumeMonitor child_monitor);
		public static GLib.Type get_type ();
		public bool has_child_volume (GLib.Volume child_volume);
		public bool is_last_child (GLib.Volume child_volume);
		public UnionVolume (GLib.VolumeMonitor union_monitor, GLib.Volume volume, GLib.VolumeMonitor monitor);
		public void remove_volume (GLib.Volume volume);
	}
	[CCode (cheader_filename = "gio/gvfs.h, glib.h")]
	public class UnionVolumeMonitor : GLib.VolumeMonitor {
		public weak GLib.Drive convert_drive (GLib.Drive child_drive);
		public weak GLib.List convert_volumes (GLib.List child_volumes);
		public static GLib.Type get_type ();
	}
	[CCode (cheader_filename = "gio/gvfs.h, glib.h")]
	public class UnixDrive : GLib.Object, GLib.Drive {
		public void disconnected ();
		public static GLib.Type get_type ();
		public bool has_mountpoint (string mountpoint);
		public UnixDrive (GLib.VolumeMonitor volume_monitor, GLib.UnixMountPoint mountpoint);
		public void set_volume (GLib.UnixVolume volume);
		public void unset_volume (GLib.UnixVolume volume);
	}
	[CCode (cheader_filename = "gio/gvfs.h, glib.h")]
	public class UnixVolume : GLib.Object, GLib.Volume {
		public static GLib.Type get_type ();
		public bool has_mountpoint (string mountpoint);
		public UnixVolume (GLib.VolumeMonitor volume_monitor, GLib.UnixMount mount);
		public void unmounted ();
		public void unset_drive (GLib.UnixDrive drive);
	}
	[CCode (cheader_filename = "gio/gvfs.h, glib.h")]
	public class UnixVolumeMonitor : GLib.VolumeMonitor {
		public static GLib.Type get_type ();
		public weak GLib.UnixDrive lookup_drive_for_mountpoint (string mountpoint);
		public UnixVolumeMonitor ();
	}
	[CCode (cheader_filename = "gio/gvfs.h, glib.h")]
	public class VolumeMonitor : GLib.Object {
		public virtual weak GLib.List get_connected_drives ();
		public virtual weak GLib.List get_mounted_volumes ();
		public static GLib.Type get_type ();
		public signal void volume_mounted (GLib.Volume volume);
		public signal void volume_pre_unmount (GLib.Volume volume);
		public signal void volume_unmounted (GLib.Volume volume);
		public signal void drive_connected (GLib.Drive drive);
		public signal void drive_disconnected (GLib.Drive drive);
	}
	[CCode (cheader_filename = "gio/gvfs.h, glib.h")]
	public class Win32AppInfo : GLib.Object, GLib.AppInfo {
		public static GLib.Type get_type ();
	}
	[CCode (cheader_filename = "gio/gvfs.h, glib.h")]
	public interface AppInfo {
		public static weak GLib.AppInfo create_from_commandline (string commandline, string application_name, GLib.Error error);
		public virtual weak GLib.AppInfo dup ();
		public virtual bool equal (GLib.AppInfo appinfo2);
		public virtual weak string get_description ();
		public virtual weak string get_icon ();
		public virtual weak string get_name ();
		public static GLib.Type get_type ();
		public virtual bool launch (GLib.List filenames, string envp, GLib.Error error);
		public virtual bool launch_uris (GLib.List uris, string envp, GLib.Error error);
		public virtual bool set_as_default_for_type (string content_type, GLib.Error error);
		public virtual bool should_show (string desktop_env);
		public virtual bool supports_uris ();
		public virtual bool supports_xdg_startup_notify ();
	}
	[CCode (cheader_filename = "gio/gvfs.h, glib.h")]
	public interface AsyncResult {
		public virtual weak GLib.Object get_source_object ();
		public static GLib.Type get_type ();
		public virtual pointer get_user_data ();
	}
	[CCode (cheader_filename = "gio/gvfs.h, glib.h")]
	public interface Drive {
		public virtual bool can_eject ();
		public virtual bool can_mount ();
		public virtual void eject (GLib.AsyncReadyCallback callback, pointer user_data);
		public virtual bool eject_finish (GLib.AsyncResult result, GLib.Error error);
		public virtual weak string get_icon ();
		public virtual weak string get_name ();
		public weak string get_platform_id ();
		public static GLib.Type get_type ();
		public virtual weak GLib.List get_volumes ();
		public virtual bool is_automounted ();
		public virtual void mount (GLib.MountOperation mount_operation, GLib.AsyncReadyCallback callback, pointer user_data);
		public virtual bool mount_finish (GLib.AsyncResult result, GLib.Error error);
		public signal void changed ();
	}
	[CCode (cheader_filename = "gio/gfile.h")]
	public interface File {
		public virtual weak GLib.FileOutputStream append_to (GLib.Cancellable cancellable, GLib.Error error);
		public virtual bool copy (GLib.File destination, GLib.FileCopyFlags flags, GLib.Cancellable cancellable, GLib.FileProgressCallback progress_callback, pointer progress_callback_data, GLib.Error error);
		public virtual weak GLib.FileOutputStream create (GLib.Cancellable cancellable, GLib.Error error);
		public bool delete (GLib.Cancellable cancellable, GLib.Error error);
		public virtual weak GLib.File dup ();
		public virtual void eject_mountable (GLib.Cancellable cancellable, GLib.AsyncReadyCallback callback, pointer user_data);
		public virtual bool eject_mountable_finish (GLib.AsyncResult result, GLib.Error error);
		public virtual weak GLib.FileEnumerator enumerate_children (string attributes, GLib.FileGetInfoFlags flags, GLib.Cancellable cancellable, GLib.Error error);
		public virtual bool equal (GLib.File file2);
		public virtual weak string get_basename ();
		public weak GLib.File get_child (string name);
		public virtual weak GLib.File get_child_for_display_name (string display_name, GLib.Error error);
		public void get_contents_async (GLib.Cancellable cancellable, GLib.AsyncReadyCallback callback, pointer user_data);
		public bool get_contents_finish (GLib.AsyncResult res, string contents, ulong length, GLib.Error error);
		public virtual weak GLib.FileInfo get_filesystem_info (string attributes, GLib.Cancellable cancellable, GLib.Error error);
		public static weak GLib.File get_for_commandline_arg (string arg);
		public static weak GLib.File get_for_path (string path);
		public static weak GLib.File get_for_uri (string uri);
		public virtual weak GLib.FileInfo get_info (string attributes, GLib.FileGetInfoFlags flags, GLib.Cancellable cancellable, GLib.Error error);
		public virtual weak GLib.File get_parent ();
		public virtual weak string get_parse_name ();
		public virtual weak string get_path ();
		public static GLib.Type get_type ();
		public virtual weak string get_uri ();
		public static uint hash (pointer file);
		public virtual bool is_native ();
		public virtual bool make_directory (GLib.Cancellable cancellable, GLib.Error error);
		public virtual bool make_symbolic_link (string symlink_value, GLib.Cancellable cancellable, GLib.Error error);
		public virtual void mount_mountable (GLib.MountOperation mount_operation, GLib.Cancellable cancellable, GLib.AsyncReadyCallback callback, pointer user_data);
		public virtual weak GLib.File mount_mountable_finish (GLib.AsyncResult result, GLib.Error error);
		public virtual bool move (GLib.File destination, GLib.FileCopyFlags flags, GLib.Cancellable cancellable, GLib.FileProgressCallback progress_callback, pointer progress_callback_data, GLib.Error error);
		public static weak GLib.File parse_name (string parse_name);
		public virtual weak GLib.FileInputStream read (GLib.Cancellable cancellable, GLib.Error error);
		public virtual void read_async (int io_priority, GLib.Cancellable cancellable, GLib.AsyncReadyCallback callback, pointer user_data);
		public virtual weak GLib.FileInputStream read_finish (GLib.AsyncResult res, GLib.Error error);
		public virtual weak GLib.FileOutputStream replace (ulong mtime, bool make_backup, GLib.Cancellable cancellable, GLib.Error error);
		public virtual weak GLib.File resolve_relative (string relative_path);
		public virtual bool set_attribute (string attribute, GLib.FileAttributeType type, pointer value, GLib.FileGetInfoFlags flags, GLib.Cancellable cancellable, GLib.Error error);
		public bool set_attribute_byte_string (string attribute, string value, GLib.FileGetInfoFlags flags, GLib.Cancellable cancellable, GLib.Error error);
		public bool set_attribute_int32 (string attribute, string value, GLib.FileGetInfoFlags flags, GLib.Cancellable cancellable, GLib.Error error);
		public bool set_attribute_int64 (string attribute, int64 value, GLib.FileGetInfoFlags flags, GLib.Cancellable cancellable, GLib.Error error);
		public bool set_attribute_string (string attribute, string value, GLib.FileGetInfoFlags flags, GLib.Cancellable cancellable, GLib.Error error);
		public bool set_attribute_uint32 (string attribute, uint value, GLib.FileGetInfoFlags flags, GLib.Cancellable cancellable, GLib.Error error);
		public bool set_attribute_uint64 (string attribute, uint64 value, GLib.FileGetInfoFlags flags, GLib.Cancellable cancellable, GLib.Error error);
		public virtual weak GLib.File set_display_name (string display_name, GLib.Cancellable cancellable, GLib.Error error);
		public virtual bool trash (GLib.Cancellable cancellable, GLib.Error error);
		public virtual void unmount_mountable (GLib.Cancellable cancellable, GLib.AsyncReadyCallback callback, pointer user_data);
		public virtual bool unmount_mountable_finish (GLib.AsyncResult result, GLib.Error error);
	}
	[CCode (cheader_filename = "gio/gvfs.h, glib.h")]
	public interface Icon {
		public virtual bool equal (GLib.Icon icon2);
		public static GLib.Type get_type ();
		public static uint hash (pointer icon);
	}
	[CCode (cheader_filename = "gio/gvfs.h, glib.h")]
	public interface LoadableIcon {
		public static GLib.Type get_type ();
		public virtual weak GLib.InputStream load (int size, string type, GLib.Cancellable cancellable, GLib.Error error);
		public virtual void load_async (int size, GLib.Cancellable cancellable, GLib.AsyncReadyCallback callback, pointer user_data);
		public virtual weak GLib.InputStream load_finish (GLib.AsyncResult res, string type, GLib.Error error);
	}
	[CCode (cheader_filename = "gio/gvfs.h, glib.h")]
	public interface Seekable {
		public virtual bool can_seek ();
		public virtual bool can_truncate ();
		public static GLib.Type get_type ();
		public virtual bool seek (int64 offset, GLib.SeekType type, GLib.Cancellable cancellable, GLib.Error err);
		public virtual int64 tell ();
		public virtual bool truncate (int64 offset, GLib.Cancellable cancellable, GLib.Error err);
	}
	[CCode (cheader_filename = "gio/gvfs.h, glib.h")]
	public interface Vfs {
		public static weak GLib.Vfs get ();
		public virtual weak GLib.File get_file_for_path (string path);
		public virtual weak GLib.File get_file_for_uri (string uri);
		public static GLib.Type get_type ();
		public virtual weak GLib.File parse_name (string parse_name);
	}
	[CCode (cheader_filename = "gio/gvfs.h, glib.h")]
	public interface Volume {
		public virtual bool can_eject ();
		public virtual bool can_unmount ();
		public virtual void eject (GLib.AsyncReadyCallback callback, pointer user_data);
		public virtual bool eject_finish (GLib.AsyncResult result, GLib.Error error);
		public virtual weak GLib.Drive get_drive ();
		public virtual weak string get_icon ();
		public virtual weak string get_name ();
		public virtual weak string get_platform_id ();
		public virtual weak GLib.File get_root ();
		public static GLib.Type get_type ();
		public virtual void unmount (GLib.AsyncReadyCallback callback, pointer user_data);
		public virtual bool unmount_finish (GLib.AsyncResult result, GLib.Error error);
		public signal void changed ();
	}
	[ReferenceType]
	[CCode (cheader_filename = "gio/gvfs.h, glib.h")]
	public struct AsyncResultData {
		public pointer async_object;
		public weak GLib.Error error;
		public pointer user_data;
	}
	[ReferenceType]
	[CCode (cheader_filename = "gio/gvfs.h, glib.h")]
	public struct FileAttributeMatcher {
		public bool enumerate_namespace (string @namespace);
		public weak string enumerate_next ();
		public void free ();
		public bool matches (string full_name);
		public bool matches_only (string full_name);
		public FileAttributeMatcher (string attributes);
	}
	[ReferenceType]
	[CCode (cheader_filename = "gio/gvfs.h, glib.h")]
	public struct IOJob {
		public void send_to_mainloop (GLib.IODataFunc func, pointer user_data, GLib.DestroyNotify notify, bool block);
	}
	[ReferenceType]
	[CCode (cheader_filename = "gio/gvfs.h, glib.h")]
	public struct LocalParentFileInfo {
		public bool writable;
		public bool is_sticky;
		public int owner;
	}
	[ReferenceType]
	[CCode (cheader_filename = "gio/gvfs.h, glib.h")]
	public struct UnixMount {
		public weak string mount_path;
		public weak string device_path;
		public weak string filesystem_type;
		public bool is_read_only;
	}
	[ReferenceType]
	[CCode (cheader_filename = "gio/gvfs.h, glib.h")]
	public struct UnixMountPoint {
		public weak string mount_path;
		public weak string device_path;
		public weak string filesystem_type;
		public weak string dev_opt;
		public bool is_read_only;
		public bool is_user_mountable;
		public bool is_loopback;
	}
	public static delegate void AsyncNextFilesCallback (GLib.FileEnumerator enumerator, GLib.List files, int num_files, pointer user_data, GLib.Error error);
	public static delegate void AsyncReadyCallback (GLib.Object source_object, GLib.AsyncResult res, pointer user_data);
	public static delegate void AsyncStopEnumeratingCallback (GLib.FileEnumerator enumerator, bool result, pointer user_data, GLib.Error error);
	public static delegate bool FDSourceFunc (pointer user_data, GLib.IOCondition condition, int fd);
	public static delegate void FileProgressCallback (int64 current_num_bytes, int64 total_num_bytes, pointer user_data);
	public static delegate void IODataFunc (pointer user_data);
	public static delegate void IOJobFunc (GLib.IOJob job, GLib.Cancellable cancellable, pointer user_data);
	public static delegate void SimpleAsyncThreadFunc (GLib.SimpleAsyncResult res, GLib.Object object, GLib.Cancellable cancellable);
	public static delegate void UnixMountCallback (pointer user_data);
}
