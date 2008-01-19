/* libgnomeui-2.0.vapi generated by lt-vapigen, do not modify. */

[CCode (cprefix = "Gnome", lower_case_cprefix = "gnome_")]
namespace Gnome {
	[CCode (cprefix = "GNOME_CLIENT_", cheader_filename = "libgnomeui/libgnomeui.h")]
	public enum ClientState {
		IDLE,
		SAVING_PHASE_1,
		WAITING_FOR_PHASE_2,
		SAVING_PHASE_2,
		FROZEN,
		DISCONNECTED,
		REGISTERING,
	}
	[CCode (cprefix = "GNOME_DIALOG_", cheader_filename = "libgnomeui/libgnomeui.h")]
	public enum DialogType {
		ERROR,
		NORMAL,
	}
	[CCode (cprefix = "GNOME_EDGE_", cheader_filename = "libgnomeui/libgnomeui.h")]
	public enum EdgePosition {
		START,
		FINISH,
		OTHER,
		LAST,
	}
	[CCode (cprefix = "GNOME_FONT_PICKER_MODE_", cheader_filename = "libgnomeui/libgnomeui.h")]
	public enum FontPickerMode {
		PIXMAP,
		FONT_INFO,
		USER_WIDGET,
		UNKNOWN,
	}
	[CCode (cprefix = "GNOME_ICON_LIST_", cheader_filename = "libgnomeui/libgnomeui.h")]
	public enum IconListMode {
		ICONS,
		TEXT_BELOW,
		TEXT_RIGHT,
	}
	[CCode (cprefix = "GNOME_INTERACT_", cheader_filename = "libgnomeui/libgnomeui.h")]
	public enum InteractStyle {
		NONE,
		ERRORS,
		ANY,
	}
	[CCode (cprefix = "GNOME_MDI_", cheader_filename = "libgnomeui/libgnomeui.h")]
	public enum MDIMode {
		NOTEBOOK,
		TOPLEVEL,
		MODAL,
		DEFAULT_MODE,
	}
	[CCode (cprefix = "GNOME_PASSWORD_DIALOG_REMEMBER_", cheader_filename = "libgnomeui/libgnomeui.h")]
	public enum PasswordDialogRemember {
		NOTHING,
		SESSION,
		FOREVER,
	}
	[CCode (cprefix = "GNOME_PREFERENCES_", cheader_filename = "libgnomeui/libgnomeui.h")]
	public enum PreferencesType {
		NEVER,
		USER,
		ALWAYS,
	}
	[CCode (cprefix = "GNOME_RESTART_", cheader_filename = "libgnomeui/libgnomeui.h")]
	public enum RestartStyle {
		IF_RUNNING,
		ANYWAY,
		IMMEDIATELY,
		NEVER,
	}
	[CCode (cprefix = "GNOME_SAVE_", cheader_filename = "libgnomeui/libgnomeui.h")]
	public enum SaveStyle {
		GLOBAL,
		LOCAL,
		BOTH,
	}
	[CCode (cprefix = "GNOME_THUMBNAIL_SIZE_", cheader_filename = "libgnomeui/libgnomeui.h")]
	public enum ThumbnailSize {
		NORMAL,
		LARGE,
	}
	[CCode (cprefix = "GNOME_APP_CONFIGURABLE_ITEM_", cheader_filename = "libgnomeui/libgnomeui.h")]
	public enum UIInfoConfigurableTypes {
		NEW,
		OPEN,
		SAVE,
		SAVE_AS,
		REVERT,
		PRINT,
		PRINT_SETUP,
		CLOSE,
		QUIT,
		CUT,
		COPY,
		PASTE,
		CLEAR,
		UNDO,
		REDO,
		FIND,
		FIND_AGAIN,
		REPLACE,
		PROPERTIES,
		PREFERENCES,
		ABOUT,
		SELECT_ALL,
		NEW_WINDOW,
		CLOSE_WINDOW,
		NEW_GAME,
		PAUSE_GAME,
		RESTART_GAME,
		UNDO_MOVE,
		REDO_MOVE,
		HINT,
		SCORES,
		END_GAME,
	}
	[CCode (cprefix = "GNOME_APP_UI_", cheader_filename = "libgnomeui/libgnomeui.h")]
	public enum UIInfoType {
		ENDOFINFO,
		ITEM,
		TOGGLEITEM,
		RADIOITEMS,
		SUBTREE,
		SEPARATOR,
		HELP,
		BUILDER_DATA,
		ITEM_CONFIGURABLE,
		SUBTREE_STOCK,
		INCLUDE,
	}
	[CCode (cprefix = "GNOME_APP_PIXMAP_", cheader_filename = "libgnomeui/libgnomeui.h")]
	public enum UIPixmapType {
		NONE,
		STOCK,
		DATA,
		FILENAME,
	}
	[CCode (cprefix = "GNOME_CLIENT_", cheader_filename = "libgnomeui/libgnomeui.h")]
	[Flags]
	public enum ClientFlags {
		IS_CONNECTED,
		RESTARTED,
		RESTORED,
	}
	[CCode (cprefix = "GNOME_DATE_EDIT_", cheader_filename = "libgnomeui/libgnomeui.h")]
	[Flags]
	public enum DateEditFlags {
		SHOW_TIME,
		24_HR,
		WEEK_STARTS_ON_MONDAY,
		DISPLAY_SECONDS,
	}
	[CCode (cprefix = "GNOME_ICON_LOOKUP_FLAGS_", cheader_filename = "libgnomeui/libgnomeui.h")]
	[Flags]
	public enum IconLookupFlags {
		NONE,
		EMBEDDING_TEXT,
		SHOW_SMALL_IMAGES_AS_THEMSELVES,
		ALLOW_SVG_AS_THEMSELVES,
	}
	[CCode (cprefix = "GNOME_ICON_LOOKUP_RESULT_FLAGS_", cheader_filename = "libgnomeui/libgnomeui.h")]
	[Flags]
	public enum IconLookupResultFlags {
		NONE,
		THUMBNAIL,
	}
	[CCode (cheader_filename = "libgnomeui/libgnomeui.h")]
	public class AppBarMsg {
	}
	[CCode (cheader_filename = "libgnomeui/libgnomeui.h")]
	public class GdkPixbufAsyncHandle {
	}
	[CCode (cheader_filename = "libgnomeui/libgnomeui.h")]
	public class PasswordDialogDetails {
	}
	[CCode (cheader_filename = "libgnomeui/libgnomeui.h")]
	public class UIBuilderData {
		public Gnome.UISignalConnectFunc connect_func;
		public pointer data;
		public bool is_interp;
		public Gtk.CallbackMarshal relay_func;
		public Gtk.DestroyNotify destroy_func;
	}
	[CCode (cheader_filename = "libgnomeui/libgnomeui.h")]
	public class UIInfo {
		public Gnome.UIInfoType type;
		public weak string label;
		public weak string hint;
		public pointer moreinfo;
		public pointer user_data;
		public pointer unused_data;
		public Gnome.UIPixmapType pixmap_type;
		public pointer pixmap_info;
		public uint accelerator_key;
		public Gdk.ModifierType ac_mods;
		public weak Gtk.Widget widget;
	}
	[CCode (cheader_filename = "libgnomeui/libgnomeui.h")]
	public class App : Gtk.Window, Atk.Implementor, Gtk.Buildable {
		public weak string name;
		public weak string prefix;
		public weak Gtk.Widget dock;
		public weak Gtk.Widget statusbar;
		public weak Gtk.Widget vbox;
		public weak Gtk.Widget menubar;
		public weak Gtk.Widget contents;
		public weak Gtk.AccelGroup accel_group;
		public void @construct (string appname, string title);
		public void create_menus (Gnome.UIInfo uiinfo);
		public void create_menus_custom (Gnome.UIInfo uiinfo, Gnome.UIBuilderData uibdata);
		public void create_menus_interp (Gnome.UIInfo uiinfo, Gtk.CallbackMarshal relay_func, pointer data, Gtk.DestroyNotify destroy_func);
		public void create_menus_with_data (Gnome.UIInfo uiinfo, pointer user_data);
		public void create_toolbar (Gnome.UIInfo uiinfo);
		public void create_toolbar_custom (Gnome.UIInfo uiinfo, Gnome.UIBuilderData uibdata);
		public void create_toolbar_interp (Gnome.UIInfo uiinfo, Gtk.CallbackMarshal relay_func, pointer data, Gtk.DestroyNotify destroy_func);
		public void create_toolbar_with_data (Gnome.UIInfo uiinfo, pointer user_data);
		public void enable_layout_config (bool enable);
		public static void fill_menu (Gtk.MenuShell menu_shell, Gnome.UIInfo uiinfo, Gtk.AccelGroup accel_group, bool uline_accels, int pos);
		public static void fill_menu_custom (Gtk.MenuShell menu_shell, Gnome.UIInfo uiinfo, Gnome.UIBuilderData uibdata, Gtk.AccelGroup accel_group, bool uline_accels, int pos);
		public static void fill_menu_with_data (Gtk.MenuShell menu_shell, Gnome.UIInfo uiinfo, Gtk.AccelGroup accel_group, bool uline_accels, int pos, pointer user_data);
		public static void fill_toolbar (Gtk.Toolbar toolbar, Gnome.UIInfo uiinfo, Gtk.AccelGroup accel_group);
		public static void fill_toolbar_custom (Gtk.Toolbar toolbar, Gnome.UIInfo uiinfo, Gnome.UIBuilderData uibdata, Gtk.AccelGroup accel_group);
		public static void fill_toolbar_with_data (Gtk.Toolbar toolbar, Gnome.UIInfo uiinfo, Gtk.AccelGroup accel_group, pointer user_data);
		public static weak Gtk.Widget find_menu_pos (Gtk.Widget parent, string path, int pos);
		public static weak string helper_gettext (string string);
		public void insert_menus (string path, Gnome.UIInfo menuinfo);
		public void insert_menus_custom (string path, Gnome.UIInfo uiinfo, Gnome.UIBuilderData uibdata);
		public void insert_menus_interp (string path, Gnome.UIInfo menuinfo, Gtk.CallbackMarshal relay_func, pointer data, Gtk.DestroyNotify destroy_func);
		public void insert_menus_with_data (string path, Gnome.UIInfo menuinfo, pointer data);
		public static void install_appbar_menu_hints (Gnome.AppBar appbar, Gnome.UIInfo uiinfo);
		public void install_menu_hints (Gnome.UIInfo uiinfo);
		public static void install_statusbar_menu_hints (Gtk.Statusbar bar, Gnome.UIInfo uiinfo);
		public App (string appname, string title);
		public void remove_menu_range (string path, int start, int items);
		public void remove_menus (string path, int items);
		public void set_contents (Gtk.Widget contents);
		public void set_menus (Gtk.MenuBar menubar);
		public void set_statusbar (Gtk.Widget statusbar);
		public void set_statusbar_custom (Gtk.Widget container, Gtk.Widget statusbar);
		public void set_toolbar (Gtk.Toolbar toolbar);
		public static void ui_configure_configurable (Gnome.UIInfo uiinfo);
		[NoAccessorMethod]
		public weak string app_id { get; set construct; }
	}
	[CCode (cheader_filename = "libgnomeui/libgnomeui.h")]
	public class AppBar : Gtk.HBox, Atk.Implementor, Gtk.Buildable {
		[CCode (cname = "gnome_appbar_clear_stack")]
		public void clear_stack ();
		[CCode (cname = "gnome_appbar_get_progress")]
		public weak Gtk.ProgressBar get_progress ();
		[CCode (cname = "gnome_appbar_get_response")]
		public weak string get_response ();
		[CCode (cname = "gnome_appbar_get_status")]
		public weak Gtk.Widget get_status ();
		[CCode (cname = "gnome_appbar_new")]
		public AppBar (bool has_progress, bool has_status, Gnome.PreferencesType interactivity);
		[CCode (cname = "gnome_appbar_pop")]
		public void pop ();
		[CCode (cname = "gnome_appbar_push")]
		public void push (string status);
		[CCode (cname = "gnome_appbar_refresh")]
		public void refresh ();
		[CCode (cname = "gnome_appbar_set_default")]
		public void set_default (string default_status);
		[CCode (cname = "gnome_appbar_set_progress_percentage")]
		public void set_progress_percentage (float percentage);
		[CCode (cname = "gnome_appbar_set_prompt")]
		public void set_prompt (string prompt, bool modal);
		[CCode (cname = "gnome_appbar_set_status")]
		public void set_status (string status);
		[NoAccessorMethod]
		public weak bool has_progress { get; set construct; }
		[NoAccessorMethod]
		public weak bool has_status { get; set construct; }
		[NoAccessorMethod]
		public weak Gnome.PreferencesType interactivity { get; set construct; }
		[HasEmitter]
		public signal void clear_prompt ();
		public signal void user_response ();
	}
	[CCode (cheader_filename = "libgnomeui/libgnomeui.h")]
	public class Client : Gtk.Object {
		public pointer smc_conn;
		public weak string client_id;
		public weak string previous_id;
		public weak string config_prefix;
		public weak string global_config_prefix;
		public weak GLib.List static_args;
		public weak string clone_command;
		public weak string current_directory;
		public weak string discard_command;
		public weak GLib.HashTable environment;
		public int process_id;
		public weak string program;
		public weak string resign_command;
		public weak string restart_command;
		public Gnome.RestartStyle restart_style;
		public weak string shutdown_command;
		public weak string user_id;
		public weak GLib.SList interaction_keys;
		public int input_id;
		public uint save_style;
		public uint interact_style;
		public uint state;
		public uint shutdown;
		public uint fast;
		public uint save_phase_2_requested;
		public uint save_successfull;
		public uint save_yourself_emitted;
		public pointer reserved;
		public void add_static_arg ();
		public void flush ();
		public weak string get_config_prefix ();
		public weak string get_desktop_id ();
		public Gnome.ClientFlags get_flags ();
		public weak string get_global_config_prefix ();
		public weak string get_id ();
		public weak string get_previous_id ();
		public static weak Gnome.ModuleInfo module_info_get ();
		public Client ();
		public Client.without_connection ();
		public void request_interaction (Gnome.DialogType dialog_type, Gnome.InteractFunction function, pointer data);
		public void request_interaction_interp (Gnome.DialogType dialog_type, Gtk.CallbackMarshal function, pointer data, Gtk.DestroyNotify destroy);
		public void request_phase_2 ();
		public void request_save (Gnome.SaveStyle save_style, bool shutdown, Gnome.InteractStyle interact_style, bool fast, bool global);
		public void save_any_dialog (Gtk.Dialog dialog);
		public void save_error_dialog (Gtk.Dialog dialog);
		[NoArrayLength]
		public void set_clone_command (int argc, string[] argv);
		public void set_current_directory (string dir);
		[NoArrayLength]
		public void set_discard_command (int argc, string[] argv);
		public void set_environment (string name, string value);
		public void set_global_config_prefix (string prefix);
		public void set_id (string id);
		public void set_priority (uint priority);
		public void set_process_id (int pid);
		public void set_program (string program);
		[NoArrayLength]
		public void set_resign_command (int argc, string[] argv);
		[NoArrayLength]
		public void set_restart_command (int argc, string[] argv);
		public void set_restart_style (Gnome.RestartStyle style);
		[NoArrayLength]
		public void set_shutdown_command (int argc, string[] argv);
		public void set_user_id (string id);
		[HasEmitter]
		public signal void connect (bool restarted);
		public signal void die ();
		[HasEmitter]
		public signal void disconnect ();
		public signal void save_complete ();
		public signal bool save_yourself (int phase, Gnome.SaveStyle save_style, bool shutdown, Gnome.InteractStyle interact_style, bool fast);
		public signal void shutdown_cancelled ();
	}
	[CCode (cheader_filename = "libgnomeui/libgnomeui.h")]
	public class DateEdit : Gtk.HBox, Atk.Implementor, Gtk.Buildable {
		public void @construct (ulong the_time, Gnome.DateEditFlags flags);
		public int get_flags ();
		public ulong get_initial_time ();
		public ulong get_time ();
		public DateEdit (ulong the_time, bool show_time, bool use_24_format);
		public DateEdit.flags (ulong the_time, Gnome.DateEditFlags flags);
		public void set_flags (Gnome.DateEditFlags flags);
		public void set_popup_range (int low_hour, int up_hour);
		public void set_time (ulong the_time);
		[NoAccessorMethod]
		public weak Gnome.DateEditFlags dateedit_flags { get; set; }
		[NoAccessorMethod]
		public weak ulong initial_time { get; set; }
		[NoAccessorMethod]
		public weak int lower_hour { get; set; }
		public weak ulong time { get; set; }
		[NoAccessorMethod]
		public weak int upper_hour { get; set; }
		public signal void date_changed ();
		public signal void time_changed ();
	}
	[CCode (cheader_filename = "libgnomeui/libgnomeui.h")]
	public class IconEntry : Gtk.VBox, Atk.Implementor, Gtk.Buildable {
		public void @construct (string history_id, string browse_dialog_title);
		public weak string get_filename ();
		public weak Gtk.Widget gnome_entry ();
		public weak Gtk.Widget gnome_file_entry ();
		public weak Gtk.Widget gtk_entry ();
		public IconEntry (string history_id, string browse_dialog_title);
		[CCode (cname = "gnome_icon_entry_pick_dialog")]
		public weak Gtk.Widget get_pick_dialog ();
		public void set_browse_dialog_title (string browse_dialog_title);
		public bool set_filename (string filename);
		public void set_history_id (string history_id);
		public void set_icon (string filename);
		public void set_max_saved (uint max_saved);
		public void set_pixmap_subdir (string subdir);
		[NoAccessorMethod]
		public weak string browse_dialog_title { get; set; }
		public weak string filename { get; set; }
		[NoAccessorMethod]
		public weak string history_id { get; set; }
		[NoAccessorMethod]
		public weak Gtk.Dialog pick_dialog { get; }
		[NoAccessorMethod]
		public weak string pixmap_subdir { get; set; }
		public signal void browse ();
		public signal void changed ();
	}
	[CCode (cheader_filename = "libgnomeui/libgnomeui.h")]
	public class IconSelection : Gtk.VBox, Atk.Implementor, Gtk.Buildable {
		public void add_defaults ();
		public void add_directory (string dir);
		public void clear (bool not_shown);
		public weak Gtk.Widget get_box ();
		public weak Gtk.Widget get_gil ();
		public weak string get_icon (bool full_path);
		public IconSelection ();
		public void select_icon (string filename);
		public void show_icons ();
		public void stop_loading ();
	}
	[CCode (cheader_filename = "libgnomeui/libgnomeui.h")]
	public class PasswordDialog : Gtk.Dialog, Atk.Implementor, Gtk.Buildable {
		public weak Gnome.PasswordDialogDetails details;
		public bool anon_selected ();
		public weak string get_domain ();
		public weak string get_new_password ();
		public weak string get_password ();
		public Gnome.PasswordDialogRemember get_remember ();
		public weak string get_username ();
		public PasswordDialog (string dialog_title, string message, string username, string password, bool readonly_username);
		public bool run_and_block ();
		public void set_domain (string domain);
		public void set_new_password (string password);
		public void set_password (string password);
		public void set_password_quality_func (Gnome.PasswordDialogQualityFunc func, pointer data, GLib.DestroyNotify dnotify);
		public void set_readonly_domain (bool readonly);
		public void set_readonly_username (bool readonly);
		public void set_remember (Gnome.PasswordDialogRemember remember);
		public void set_show_domain (bool show);
		public void set_show_new_password (bool show);
		public void set_show_new_password_quality (bool show);
		public void set_show_password (bool show);
		public void set_show_remember (bool show_remember);
		public void set_show_username (bool show);
		public void set_show_userpass_buttons (bool show_userpass_buttons);
		public void set_username (string username);
		[NoAccessorMethod]
		public weak bool anonymous { get; set; }
		public weak string domain { get; set; }
		[NoAccessorMethod]
		public weak string message { get; set; }
		[NoAccessorMethod]
		public weak string message_markup { get; set; }
		public weak string new_password { get; set; }
		public weak string password { get; set; }
		[NoAccessorMethod]
		public weak bool readonly_domain { get; set; }
		[NoAccessorMethod]
		public weak bool readonly_username { get; set; }
		[NoAccessorMethod]
		public weak Gnome.PasswordDialogRemember remember_mode { get; set; }
		[NoAccessorMethod]
		public weak bool show_domain { get; set; }
		[NoAccessorMethod]
		public weak bool show_new_password { get; set; }
		[NoAccessorMethod]
		public weak bool show_new_password_quality { get; set; }
		[NoAccessorMethod]
		public weak bool show_password { get; set; }
		[NoAccessorMethod]
		public weak bool show_remember { get; set; }
		[NoAccessorMethod]
		public weak bool show_username { get; set; }
		[NoAccessorMethod]
		public weak bool show_userpass_buttons { get; set; }
		public weak string username { get; set; }
	}
	[CCode (cheader_filename = "libgnomeui/libgnomeui.h")]
	public class ThumbnailFactory : GLib.Object {
		public bool can_thumbnail (string uri, string mime_type, ulong mtime);
		public void create_failed_thumbnail (string uri, ulong mtime);
		public weak Gdk.Pixbuf generate_thumbnail (string uri, string mime_type);
		public bool has_valid_failed_thumbnail (string uri, ulong mtime);
		public weak string lookup (string uri, ulong mtime);
		public ThumbnailFactory (Gnome.ThumbnailSize size);
		public void save_thumbnail (Gdk.Pixbuf thumbnail, string uri, ulong original_mtime);
	}
	public static delegate void GdkPixbufDoneCallback (Gnome.GdkPixbufAsyncHandle handle, pointer cb_data);
	public static delegate void GdkPixbufLoadCallback (Gnome.GdkPixbufAsyncHandle handle, GnomeVFS.Result error, Gdk.Pixbuf pixbuf, pointer cb_data);
	public static delegate void InteractFunction (Gnome.Client client, int key, Gnome.DialogType dialog_type, pointer data);
	public static delegate double PasswordDialogQualityFunc (Gnome.PasswordDialog password_dialog, string password, pointer user_data);
	public static delegate void ReplyCallback (int reply, pointer data);
	public static delegate void StringCallback (string string, pointer data);
	public static delegate void UISignalConnectFunc (Gnome.UIInfo uiinfo, string signal_name, Gnome.UIBuilderData uibdata);
	public const string GNOMEUIINFO_KEY_UIBDATA;
	public const string GNOMEUIINFO_KEY_UIDATA;
	public const string APP_MENUBAR_NAME;
	public const string APP_TOOLBAR_NAME;
	public const int CANCEL;
	public const string CLIENT_PARAM_SM_CONNECT;
	public const int KEY_MOD_CLEAR;
	public const int KEY_MOD_CLOSE_WINDOW;
	public const int KEY_MOD_NEW_WINDOW;
	public const int KEY_MOD_PAUSE_GAME;
	public const int KEY_MOD_PRINT_SETUP;
	public const int KEY_MOD_REDO;
	public const int KEY_MOD_REDO_MOVE;
	public const int KEY_MOD_SAVE_AS;
	public const int KEY_NAME_CLEAR;
	public const int KEY_NAME_CLOSE_WINDOW;
	public const int KEY_NAME_NEW_WINDOW;
	public const int KEY_NAME_PRINT_SETUP;
	public const string MESSAGE_BOX_ERROR;
	public const string MESSAGE_BOX_GENERIC;
	public const string MESSAGE_BOX_INFO;
	public const string MESSAGE_BOX_QUESTION;
	public const string MESSAGE_BOX_WARNING;
	public const int NO;
	public const int OK;
	public const int PAD;
	public const int PAD_BIG;
	public const int PAD_SMALL;
	public const string PROPERTY_BOX_DIRTY;
	public const string STOCK_ABOUT;
	public const string STOCK_ATTACH;
	public const string STOCK_AUTHENTICATION;
	public const string STOCK_BLANK;
	public const string STOCK_BOOK_BLUE;
	public const string STOCK_BOOK_GREEN;
	public const string STOCK_BOOK_OPEN;
	public const string STOCK_BOOK_RED;
	public const string STOCK_BOOK_YELLOW;
	public const string STOCK_LINE_IN;
	public const string STOCK_MAIL;
	public const string STOCK_MAIL_FWD;
	public const string STOCK_MAIL_NEW;
	public const string STOCK_MAIL_RCV;
	public const string STOCK_MAIL_RPL;
	public const string STOCK_MAIL_SND;
	public const string STOCK_MIC;
	public const string STOCK_MIDI;
	public const string STOCK_MULTIPLE_FILE;
	public const string STOCK_NOT;
	public const string STOCK_SCORES;
	public const string STOCK_TABLE_BORDERS;
	public const string STOCK_TABLE_FILL;
	public const string STOCK_TEXT_BULLETED_LIST;
	public const string STOCK_TEXT_INDENT;
	public const string STOCK_TEXT_NUMBERED_LIST;
	public const string STOCK_TEXT_UNINDENT;
	public const string STOCK_TIMER;
	public const string STOCK_TIMER_STOP;
	public const string STOCK_TRASH;
	public const string STOCK_TRASH_FULL;
	public const string STOCK_VOLUME;
	public const int YES;
	public const string LIBGNOMEUI_PARAM_CRASH_DIALOG;
	public const string LIBGNOMEUI_PARAM_DEFAULT_ICON;
	public const string LIBGNOMEUI_PARAM_DISPLAY;
	[CCode (cname = "LIBGNOMEUI_MODULE")]
	public Gnome.ModuleInfo libgnomeui_module;
	public static void accelerators_sync ();
	public static bool authentication_manager_dialog_is_visible ();
	public static void authentication_manager_init ();
	public static weak Gdk.Pixbuf gdk_pixbuf_new_from_uri (string uri);
	public static weak Gnome.GdkPixbufAsyncHandle gdk_pixbuf_new_from_uri_async (string uri, Gnome.GdkPixbufLoadCallback load_callback, Gnome.GdkPixbufDoneCallback done_callback, pointer callback_data);
	public static weak Gdk.Pixbuf gdk_pixbuf_new_from_uri_at_scale (string uri, int width, int height, bool preserve_aspect_ratio);
	public static void gdk_pixbuf_new_from_uri_cancel (Gnome.GdkPixbufAsyncHandle handle);
	public static weak Gnome.ModuleInfo gtk_module_info_get ();
	public static bool help_display_desktop_on_screen (Gnome.Program program, string doc_id, string file_name, string link_id, Gdk.Screen screen) throws GLib.Error;
	public static bool help_display_on_screen (string file_name, string link_id, Gdk.Screen screen) throws GLib.Error;
	public static bool help_display_uri_on_screen (string help_uri, Gdk.Screen screen) throws GLib.Error;
	public static bool help_display_with_doc_id_on_screen (Gnome.Program program, string doc_id, string file_name, string link_id, Gdk.Screen screen) throws GLib.Error;
	public static void ice_init ();
	public static weak string icon_lookup (Gtk.IconTheme icon_theme, Gnome.ThumbnailFactory thumbnail_factory, string file_uri, string custom_icon, GnomeVFS.FileInfo file_info, string mime_type, Gnome.IconLookupFlags flags, Gnome.IconLookupResultFlags _result);
	public static weak string icon_lookup_sync (Gtk.IconTheme icon_theme, Gnome.ThumbnailFactory thumbnail_factory, string file_uri, string custom_icon, Gnome.IconLookupFlags flags, Gnome.IconLookupResultFlags _result);
	public static void interaction_key_return (int key, bool cancel_shutdown);
	[CCode (cname = "libgnomeui_module_info_get")]
	public static weak Gnome.ModuleInfo libgnomeui_module_info_get ();
	public static weak Gnome.Client master_client ();
	public static bool thumbnail_has_uri (Gdk.Pixbuf pixbuf, string uri);
	public static bool thumbnail_is_valid (Gdk.Pixbuf pixbuf, string uri, ulong mtime);
	public static weak string thumbnail_md5 (string uri);
	public static weak string thumbnail_path_for_uri (string uri, Gnome.ThumbnailSize size);
	public static weak Gdk.Pixbuf thumbnail_scale_down_pixbuf (Gdk.Pixbuf pixbuf, int dest_width, int dest_height);
	public static bool url_show_on_screen (string url, Gdk.Screen screen) throws GLib.Error;
}
