[CCode (cheader_filename = "gtk/gtk.h")]
namespace Gtk {
	[CCode (cprefix = "GTK_ACCEL_")]
	public enum AccelFlags {
		VISIBLE,
		LOCKED,
		MASK,
	}
	[CCode (cprefix = "GTK_ANCHOR_")]
	public enum AnchorType {
		CENTER,
		NORTH,
		NORTH_WEST,
		NORTH_EAST,
		SOUTH,
		SOUTH_WEST,
		SOUTH_EAST,
		WEST,
		EAST,
		N,
		NW,
		NE,
		S,
		SW,
		SE,
		W,
		E,
	}
	[CCode (cprefix = "GTK_ARG_")]
	public enum ArgFlags {
		READABLE,
		WRITABLE,
		CONSTRUCT,
		CONSTRUCT_ONLY,
		CHILD_ARG,
	}
	[CCode (cprefix = "GTK_ARROW_")]
	public enum ArrowType {
		UP,
		DOWN,
		LEFT,
		RIGHT,
		NONE,
	}
	[CCode (cprefix = "GTK_ASSISTANT_PAGE_")]
	public enum AssistantPageType {
		CONTENT,
		INTRO,
		CONFIRM,
		SUMMARY,
		PROGRESS,
	}
	[CCode (cprefix = "GTK_")]
	public enum AttachOptions {
		EXPAND,
		SHRINK,
		FILL,
	}
	[CCode (cprefix = "GTK_BUTTONBOX_")]
	public enum ButtonBoxStyle {
		DEFAULT_STYLE,
		SPREAD,
		EDGE,
		START,
		END,
	}
	[CCode (cprefix = "GTK_BUTTONS_")]
	public enum ButtonsType {
		NONE,
		OK,
		CLOSE,
		CANCEL,
		YES_NO,
		OK_CANCEL,
	}
	[CCode (cprefix = "GTK_CALENDAR_")]
	public enum CalendarDisplayOptions {
		SHOW_HEADING,
		SHOW_DAY_NAMES,
		NO_MONTH_CHANGE,
		SHOW_WEEK_NUMBERS,
		WEEK_START_MONDAY,
	}
	[CCode (cprefix = "GTK_CELL_RENDERER_ACCEL_MODE_")]
	public enum CellRendererAccelMode {
		GTK,
		OTHER,
	}
	[CCode (cprefix = "GTK_CELL_RENDERER_MODE_")]
	public enum CellRendererMode {
		INERT,
		ACTIVATABLE,
		EDITABLE,
	}
	[CCode (cprefix = "GTK_CELL_RENDERER_")]
	public enum CellRendererState {
		SELECTED,
		PRELIT,
		INSENSITIVE,
		SORTED,
		FOCUSED,
	}
	[CCode (cprefix = "GTK_CORNER_")]
	public enum CornerType {
		TOP_LEFT,
		BOTTOM_LEFT,
		TOP_RIGHT,
		BOTTOM_RIGHT,
	}
	[CCode (cprefix = "GTK_CURVE_TYPE_")]
	public enum CurveType {
		LINEAR,
		SPLINE,
		FREE,
	}
	[CCode (cprefix = "GTK_DEBUG_")]
	public enum DebugFlag {
		MISC,
		PLUGSOCKET,
		TEXT,
		TREE,
		UPDATES,
		KEYBINDINGS,
		MULTIHEAD,
		MODULES,
		GEOMETRY,
		ICONTHEME,
		PRINTING,
	}
	[CCode (cprefix = "GTK_DELETE_")]
	public enum DeleteType {
		CHARS,
		WORD_ENDS,
		WORDS,
		DISPLAY_LINES,
		DISPLAY_LINE_ENDS,
		PARAGRAPH_ENDS,
		PARAGRAPHS,
		WHITESPACE,
	}
	[CCode (cprefix = "GTK_DEST_DEFAULT_")]
	public enum DestDefaults {
		MOTION,
		HIGHLIGHT,
		DROP,
		ALL,
	}
	[CCode (cprefix = "GTK_DIALOG_")]
	public enum DialogFlags {
		MODAL,
		DESTROY_WITH_PARENT,
		NO_SEPARATOR,
	}
	[CCode (cprefix = "GTK_DIR_")]
	public enum DirectionType {
		TAB_FORWARD,
		TAB_BACKWARD,
		UP,
		DOWN,
		LEFT,
		RIGHT,
	}
	[CCode (cprefix = "GTK_EXPANDER_")]
	public enum ExpanderStyle {
		COLLAPSED,
		SEMI_COLLAPSED,
		SEMI_EXPANDED,
		EXPANDED,
	}
	[CCode (cprefix = "GTK_FILE_CHOOSER_ACTION_")]
	public enum FileChooserAction {
		OPEN,
		SAVE,
		SELECT_FOLDER,
		CREATE_FOLDER,
	}
	[CCode (cprefix = "GTK_FILE_CHOOSER_CONFIRMATION_")]
	public enum FileChooserConfirmation {
		CONFIRM,
		ACCEPT_FILENAME,
		SELECT_AGAIN,
	}
	[CCode (cprefix = "GTK_FILE_CHOOSER_ERROR_")]
	public enum FileChooserError {
		NONEXISTENT,
		BAD_FILENAME,
		ALREADY_EXISTS,
	}
	[CCode (cprefix = "GTK_FILE_FILTER_")]
	public enum FileFilterFlags {
		FILENAME,
		URI,
		DISPLAY_NAME,
		MIME_TYPE,
	}
	[CCode (cprefix = "GTK_IM_PREEDIT_")]
	public enum IMPreeditStyle {
		NOTHING,
		CALLBACK,
		NONE,
	}
	[CCode (cprefix = "GTK_IM_STATUS_")]
	public enum IMStatusStyle {
		NOTHING,
		CALLBACK,
		NONE,
	}
	[CCode (cprefix = "GTK_ICON_LOOKUP_")]
	public enum IconLookupFlags {
		NO_SVG,
		FORCE_SVG,
		USE_BUILTIN,
	}
	[CCode (cprefix = "GTK_ICON_SIZE_")]
	public enum IconSize {
		INVALID,
		MENU,
		SMALL_TOOLBAR,
		LARGE_TOOLBAR,
		BUTTON,
		DND,
		DIALOG,
	}
	[CCode (cprefix = "GTK_ICON_THEME_")]
	public enum IconThemeError {
		NOT_FOUND,
		FAILED,
	}
	[CCode (cprefix = "GTK_ICON_VIEW_")]
	public enum IconViewDropPosition {
		NO_DROP,
		DROP_INTO,
		DROP_LEFT,
		DROP_RIGHT,
		DROP_ABOVE,
		DROP_BELOW,
	}
	[CCode (cprefix = "GTK_IMAGE_")]
	public enum ImageType {
		EMPTY,
		PIXMAP,
		IMAGE,
		PIXBUF,
		STOCK,
		ICON_SET,
		ANIMATION,
		ICON_NAME,
	}
	[CCode (cprefix = "GTK_JUSTIFY_")]
	public enum Justification {
		LEFT,
		RIGHT,
		CENTER,
		FILL,
	}
	[CCode (cprefix = "GTK_MATCH_")]
	public enum MatchType {
		ALL,
		ALL_TAIL,
		HEAD,
		TAIL,
		EXACT,
		LAST,
	}
	[CCode (cprefix = "GTK_MENU_DIR_")]
	public enum MenuDirectionType {
		PARENT,
		CHILD,
		NEXT,
		PREV,
	}
	[CCode (cprefix = "GTK_MESSAGE_")]
	public enum MessageType {
		INFO,
		WARNING,
		QUESTION,
		ERROR,
		OTHER,
	}
	[CCode (cprefix = "GTK_")]
	public enum MetricType {
		PIXELS,
		INCHES,
		CENTIMETERS,
	}
	[CCode (cprefix = "GTK_MOVEMENT_")]
	public enum MovementStep {
		LOGICAL_POSITIONS,
		VISUAL_POSITIONS,
		WORDS,
		DISPLAY_LINES,
		DISPLAY_LINE_ENDS,
		PARAGRAPHS,
		PARAGRAPH_ENDS,
		PAGES,
		BUFFER_ENDS,
		HORIZONTAL_PAGES,
	}
	[CCode (cprefix = "GTK_NOTEBOOK_TAB_")]
	public enum NotebookTab {
		FIRST,
		LAST,
	}
	[CCode (cprefix = "GTK_")]
	public enum ObjectFlags {
		IN_DESTRUCTION,
		FLOATING,
		RESERVED_1,
		RESERVED_2,
	}
	[CCode (cprefix = "GTK_ORIENTATION_")]
	public enum Orientation {
		HORIZONTAL,
		VERTICAL,
	}
	[CCode (cprefix = "GTK_PACK_DIRECTION_")]
	public enum PackDirection {
		LTR,
		RTL,
		TTB,
		BTT,
	}
	[CCode (cprefix = "GTK_PACK_")]
	public enum PackType {
		START,
		END,
	}
	[CCode (cprefix = "GTK_PAGE_ORIENTATION_")]
	public enum PageOrientation {
		PORTRAIT,
		LANDSCAPE,
		REVERSE_PORTRAIT,
		REVERSE_LANDSCAPE,
	}
	[CCode (cprefix = "GTK_PAGE_SET_")]
	public enum PageSet {
		ALL,
		EVEN,
		ODD,
	}
	[CCode (cprefix = "GTK_PATH_PRIO_")]
	public enum PathPriorityType {
		LOWEST,
		GTK,
		APPLICATION,
		THEME,
		RC,
		HIGHEST,
	}
	[CCode (cprefix = "GTK_PATH_")]
	public enum PathType {
		WIDGET,
		WIDGET_CLASS,
		CLASS,
	}
	[CCode (cprefix = "GTK_POLICY_")]
	public enum PolicyType {
		ALWAYS,
		AUTOMATIC,
		NEVER,
	}
	[CCode (cprefix = "GTK_POS_")]
	public enum PositionType {
		LEFT,
		RIGHT,
		TOP,
		BOTTOM,
	}
	[CCode (cprefix = "GTK_PREVIEW_")]
	public enum PreviewType {
		COLOR,
		GRAYSCALE,
	}
	[CCode (cprefix = "GTK_PRINT_BACKEND_ERROR_")]
	public enum PrintBackendError {
		GENERIC,
	}
	[CCode (cprefix = "GTK_PRINT_CAPABILITY_")]
	public enum PrintCapabilities {
		PAGE_SET,
		COPIES,
		COLLATE,
		REVERSE,
		SCALE,
		GENERATE_PDF,
		GENERATE_PS,
		PREVIEW,
	}
	[CCode (cprefix = "GTK_PRINT_DUPLEX_")]
	public enum PrintDuplex {
		SIMPLEX,
		HORIZONTAL,
		VERTICAL,
	}
	[CCode (cprefix = "GTK_PRINT_ERROR_")]
	public enum PrintError {
		GENERAL,
		INTERNAL_ERROR,
		NOMEM,
	}
	[CCode (cprefix = "GTK_PRINT_OPERATION_ACTION_")]
	public enum PrintOperationAction {
		PRINT_DIALOG,
		PRINT,
		PREVIEW,
		EXPORT,
	}
	[CCode (cprefix = "GTK_PRINT_OPERATION_RESULT_")]
	public enum PrintOperationResult {
		ERROR,
		APPLY,
		CANCEL,
		IN_PROGRESS,
	}
	[CCode (cprefix = "GTK_PRINT_PAGES_")]
	public enum PrintPages {
		ALL,
		CURRENT,
		RANGES,
	}
	[CCode (cprefix = "GTK_PRINT_QUALITY_")]
	public enum PrintQuality {
		LOW,
		NORMAL,
		HIGH,
		DRAFT,
	}
	[CCode (cprefix = "GTK_PRINT_STATUS_")]
	public enum PrintStatus {
		INITIAL,
		PREPARING,
		GENERATING_DATA,
		SENDING_DATA,
		PENDING,
		PENDING_ISSUE,
		PRINTING,
		FINISHED,
		FINISHED_ABORTED,
	}
	[CCode (cprefix = "GTK_PRINTER_OPTION_TYPE_")]
	public enum PrinterOptionType {
		BOOLEAN,
		PICKONE,
		PICKONE_PASSWORD,
		PICKONE_PASSCODE,
		PICKONE_REAL,
		PICKONE_INT,
		PICKONE_STRING,
		ALTERNATIVE,
		STRING,
		FILESAVE,
	}
	[CCode (cprefix = "GTK_PROGRESS_")]
	public enum ProgressBarOrientation {
		LEFT_TO_RIGHT,
		RIGHT_TO_LEFT,
		BOTTOM_TO_TOP,
		TOP_TO_BOTTOM,
	}
	[CCode (cprefix = "GTK_PROGRESS_")]
	public enum ProgressBarStyle {
		CONTINUOUS,
		DISCRETE,
	}
	[CCode (cprefix = "GTK_RC_")]
	public enum RcFlags {
		FG,
		BG,
		TEXT,
		BASE,
	}
	[CCode (cprefix = "GTK_RC_TOKEN_")]
	public enum RcTokenType {
		INVALID,
		INCLUDE,
		NORMAL,
		ACTIVE,
		PRELIGHT,
		SELECTED,
		INSENSITIVE,
		FG,
		BG,
		TEXT,
		BASE,
		XTHICKNESS,
		YTHICKNESS,
		FONT,
		FONTSET,
		FONT_NAME,
		BG_PIXMAP,
		PIXMAP_PATH,
		STYLE,
		BINDING,
		BIND,
		WIDGET,
		WIDGET_CLASS,
		CLASS,
		LOWEST,
		GTK,
		APPLICATION,
		THEME,
		RC,
		HIGHEST,
		ENGINE,
		MODULE_PATH,
		IM_MODULE_PATH,
		IM_MODULE_FILE,
		STOCK,
		LTR,
		RTL,
		COLOR,
		LAST,
	}
	[CCode (cprefix = "GTK_RECENT_CHOOSER_ERROR_")]
	public enum RecentChooserError {
		NOT_FOUND,
		INVALID_URI,
	}
	[CCode (cprefix = "GTK_RECENT_CHOOSER_PROP_")]
	public enum RecentChooserProp {
		FIRST,
		RECENT_MANAGER,
		SHOW_PRIVATE,
		SHOW_NOT_FOUND,
		SHOW_TIPS,
		SHOW_ICONS,
		SELECT_MULTIPLE,
		LIMIT,
		LOCAL_ONLY,
		SORT_TYPE,
		FILTER,
		LAST,
	}
	[CCode (cprefix = "GTK_RECENT_FILTER_")]
	public enum RecentFilterFlags {
		URI,
		DISPLAY_NAME,
		MIME_TYPE,
		APPLICATION,
		GROUP,
		AGE,
	}
	[CCode (cprefix = "GTK_RECENT_MANAGER_ERROR_")]
	public enum RecentManagerError {
		NOT_FOUND,
		INVALID_URI,
		INVALID_ENCODING,
		NOT_REGISTERED,
		READ,
		WRITE,
		UNKNOWN,
	}
	[CCode (cprefix = "GTK_RECENT_SORT_")]
	public enum RecentSortType {
		NONE,
		MRU,
		LRU,
		CUSTOM,
	}
	[CCode (cprefix = "GTK_RELIEF_")]
	public enum ReliefStyle {
		NORMAL,
		HALF,
		NONE,
	}
	[CCode (cprefix = "GTK_RESIZE_")]
	public enum ResizeMode {
		PARENT,
		QUEUE,
		IMMEDIATE,
	}
	[CCode (cprefix = "GTK_RESPONSE_")]
	public enum ResponseType {
		NONE,
		REJECT,
		ACCEPT,
		DELETE_EVENT,
		OK,
		CANCEL,
		CLOSE,
		YES,
		NO,
		APPLY,
		HELP,
	}
	[CCode (cprefix = "GTK_SCROLL_")]
	public enum ScrollStep {
		STEPS,
		PAGES,
		ENDS,
		HORIZONTAL_STEPS,
		HORIZONTAL_PAGES,
		HORIZONTAL_ENDS,
	}
	[CCode (cprefix = "GTK_SCROLL_")]
	public enum ScrollType {
		NONE,
		JUMP,
		STEP_BACKWARD,
		STEP_FORWARD,
		PAGE_BACKWARD,
		PAGE_FORWARD,
		STEP_UP,
		STEP_DOWN,
		PAGE_UP,
		PAGE_DOWN,
		STEP_LEFT,
		STEP_RIGHT,
		PAGE_LEFT,
		PAGE_RIGHT,
		START,
		END,
	}
	[CCode (cprefix = "GTK_SELECTION_")]
	public enum SelectionMode {
		NONE,
		SINGLE,
		BROWSE,
		MULTIPLE,
		EXTENDED,
	}
	[CCode (cprefix = "GTK_SENSITIVITY_")]
	public enum SensitivityType {
		AUTO,
		ON,
		OFF,
	}
	[CCode (cprefix = "GTK_SHADOW_")]
	public enum ShadowType {
		NONE,
		IN,
		OUT,
		ETCHED_IN,
		ETCHED_OUT,
	}
	[CCode (cprefix = "GTK_SIDE_")]
	public enum SideType {
		TOP,
		BOTTOM,
		LEFT,
		RIGHT,
	}
	[CCode (cprefix = "GTK_RUN_")]
	public enum SignalRunType {
		FIRST,
		LAST,
		BOTH,
		NO_RECURSE,
		ACTION,
		NO_HOOKS,
	}
	[CCode (cprefix = "GTK_SIZE_GROUP_")]
	public enum SizeGroupMode {
		NONE,
		HORIZONTAL,
		VERTICAL,
		BOTH,
	}
	[CCode (cprefix = "GTK_SORT_")]
	public enum SortType {
		ASCENDING,
		DESCENDING,
	}
	[CCode (cprefix = "GTK_UPDATE_")]
	public enum SpinButtonUpdatePolicy {
		ALWAYS,
		IF_VALID,
	}
	[CCode (cprefix = "GTK_SPIN_")]
	public enum SpinType {
		STEP_FORWARD,
		STEP_BACKWARD,
		PAGE_FORWARD,
		PAGE_BACKWARD,
		HOME,
		END,
		USER_DEFINED,
	}
	[CCode (cprefix = "GTK_STATE_")]
	public enum StateType {
		NORMAL,
		ACTIVE,
		PRELIGHT,
		SELECTED,
		INSENSITIVE,
	}
	[CCode (cprefix = "GTK_DIRECTION_")]
	public enum SubmenuDirection {
		LEFT,
		RIGHT,
	}
	[CCode (cprefix = "GTK_")]
	public enum SubmenuPlacement {
		TOP_BOTTOM,
		LEFT_RIGHT,
	}
	[CCode (cprefix = "GTK_TARGET_SAME_")]
	public enum TargetFlags {
		APP,
		WIDGET,
	}
	[CCode (cprefix = "GTK_TEXT_BUFFER_TARGET_INFO_")]
	public enum TextBufferTargetInfo {
		BUFFER_CONTENTS,
		RICH_TEXT,
		TEXT,
	}
	[CCode (cprefix = "GTK_TEXT_DIR_")]
	public enum TextDirection {
		NONE,
		LTR,
		RTL,
	}
	[CCode (cprefix = "GTK_TEXT_SEARCH_")]
	public enum TextSearchFlags {
		VISIBLE_ONLY,
		TEXT_ONLY,
	}
	[CCode (cprefix = "GTK_TEXT_WINDOW_")]
	public enum TextWindowType {
		PRIVATE,
		WIDGET,
		TEXT,
		LEFT,
		RIGHT,
		TOP,
		BOTTOM,
	}
	[CCode (cprefix = "GTK_TOOLBAR_CHILD_")]
	public enum ToolbarChildType {
		SPACE,
		BUTTON,
		TOGGLEBUTTON,
		RADIOBUTTON,
		WIDGET,
	}
	[CCode (cprefix = "GTK_TOOLBAR_SPACE_")]
	public enum ToolbarSpaceStyle {
		EMPTY,
		LINE,
	}
	[CCode (cprefix = "GTK_TOOLBAR_")]
	public enum ToolbarStyle {
		ICONS,
		TEXT,
		BOTH,
		BOTH_HORIZ,
	}
	[CCode (cprefix = "GTK_TREE_MODEL_")]
	public enum TreeModelFlags {
		ITERS_PERSIST,
		LIST_ONLY,
	}
	[CCode (cprefix = "GTK_TREE_VIEW_COLUMN_")]
	public enum TreeViewColumnSizing {
		GROW_ONLY,
		AUTOSIZE,
		FIXED,
	}
	[CCode (cprefix = "GTK_TREE_VIEW_DROP_")]
	public enum TreeViewDropPosition {
		BEFORE,
		AFTER,
		INTO_OR_BEFORE,
		INTO_OR_AFTER,
	}
	[CCode (cprefix = "GTK_TREE_VIEW_GRID_LINES_")]
	public enum TreeViewGridLines {
		NONE,
		HORIZONTAL,
		VERTICAL,
		BOTH,
	}
	[CCode (cprefix = "GTK_UI_MANAGER_")]
	public enum UIManagerItemType {
		AUTO,
		MENUBAR,
		MENU,
		TOOLBAR,
		PLACEHOLDER,
		POPUP,
		MENUITEM,
		TOOLITEM,
		SEPARATOR,
		ACCELERATOR,
	}
	[CCode (cprefix = "GTK_UNIT_")]
	public enum Unit {
		PIXEL,
		POINTS,
		INCH,
		MM,
	}
	[CCode (cprefix = "GTK_UPDATE_")]
	public enum UpdateType {
		CONTINUOUS,
		DISCONTINUOUS,
		DELAYED,
	}
	[CCode (cprefix = "GTK_VISIBILITY_")]
	public enum Visibility {
		NONE,
		PARTIAL,
		FULL,
	}
	[CCode (cprefix = "GTK_")]
	public enum WidgetFlags {
		TOPLEVEL,
		NO_WINDOW,
		REALIZED,
		MAPPED,
		VISIBLE,
		SENSITIVE,
		PARENT_SENSITIVE,
		CAN_FOCUS,
		HAS_FOCUS,
		CAN_DEFAULT,
		HAS_DEFAULT,
		HAS_GRAB,
		RC_STYLE,
		COMPOSITE_CHILD,
		NO_REPARENT,
		APP_PAINTABLE,
		RECEIVES_DEFAULT,
		DOUBLE_BUFFERED,
		NO_SHOW_ALL,
	}
	[CCode (cprefix = "GTK_WIDGET_HELP_")]
	public enum WidgetHelpType {
		TOOLTIP,
		WHATS_THIS,
	}
	[CCode (cprefix = "GTK_WIN32_EMBED_")]
	public enum Win32EmbedMessageType {
		WINDOW_ACTIVATE,
		WINDOW_DEACTIVATE,
		FOCUS_IN,
		FOCUS_OUT,
		MODALITY_ON,
		MODALITY_OFF,
		PARENT_NOTIFY,
		EVENT_PLUG_MAPPED,
		PLUG_RESIZED,
		REQUEST_FOCUS,
		FOCUS_NEXT,
		FOCUS_PREV,
		GRAB_KEY,
		UNGRAB_KEY,
		LAST,
	}
	[CCode (cprefix = "GTK_WIN_POS_")]
	public enum WindowPosition {
		NONE,
		CENTER,
		MOUSE,
		CENTER_ALWAYS,
		CENTER_ON_PARENT,
	}
	[CCode (cprefix = "GTK_WINDOW_")]
	public enum WindowType {
		TOPLEVEL,
		POPUP,
	}
	[CCode (cprefix = "GTK_WRAP_")]
	public enum WrapMode {
		NONE,
		CHAR,
		WORD,
		WORD_CHAR,
	}
	public class AboutDialog : Gtk.Dialog {
		[NoArrayLength ()]
		public string get_artists ();
		[NoArrayLength ()]
		public string get_authors ();
		[NoArrayLength ()]
		public string get_comments ();
		[NoArrayLength ()]
		public string get_copyright ();
		[NoArrayLength ()]
		public string get_documenters ();
		[NoArrayLength ()]
		public string get_license ();
		[NoArrayLength ()]
		public Gdk.Pixbuf get_logo ();
		[NoArrayLength ()]
		public string get_logo_icon_name ();
		[NoArrayLength ()]
		public string get_name ();
		[NoArrayLength ()]
		public string get_translator_credits ();
		[NoArrayLength ()]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		public string get_version ();
		[NoArrayLength ()]
		public string get_website ();
		[NoArrayLength ()]
		public string get_website_label ();
		[NoArrayLength ()]
		public bool get_wrap_license ();
		[NoArrayLength ()]
		public construct ();
		[NoArrayLength ()]
		public void set_artists (string artists);
		[NoArrayLength ()]
		public void set_authors (string authors);
		[NoArrayLength ()]
		public void set_comments (string comments);
		[NoArrayLength ()]
		public void set_copyright (string copyright);
		[NoArrayLength ()]
		public void set_documenters (string documenters);
		[NoArrayLength ()]
		public static Gtk.AboutDialogActivateLinkFunc set_email_hook (Gtk.AboutDialogActivateLinkFunc func, pointer data, GLib.DestroyNotify destroy);
		[NoArrayLength ()]
		public void set_license (string license);
		[NoArrayLength ()]
		public void set_logo (Gdk.Pixbuf logo);
		[NoArrayLength ()]
		public void set_logo_icon_name (string icon_name);
		[NoArrayLength ()]
		public void set_name (string name);
		[NoArrayLength ()]
		public void set_translator_credits (string translator_credits);
		[NoArrayLength ()]
		public static Gtk.AboutDialogActivateLinkFunc set_url_hook (Gtk.AboutDialogActivateLinkFunc func, pointer data, GLib.DestroyNotify destroy);
		[NoArrayLength ()]
		public void set_version (string version);
		[NoArrayLength ()]
		public void set_website (string website);
		[NoArrayLength ()]
		public void set_website_label (string website_label);
		[NoArrayLength ()]
		public void set_wrap_license (bool wrap_license);
		public weak string name { get; set; }
		public weak string version { get; set; }
		public weak string copyright { get; set; }
		public weak string comments { get; set; }
		public weak string license { get; set; }
		public weak string website { get; set; }
		public weak string website_label { get; set; }
		public weak string[] authors { get; set; }
		public weak string[] documenters { get; set; }
		public weak string[] artists { get; set; }
		public weak string translator_credits { get; set; }
		public weak Gdk.Pixbuf logo { get; set; }
		public weak string logo_icon_name { get; set; }
		public weak bool wrap_license { get; set; }
	}
	public class AccelGroup : GLib.Object {
		[NoArrayLength ()]
		public bool activate (GLib.Quark accel_quark, GLib.Object acceleratable, uint accel_key, Gdk.ModifierType accel_mods);
		[NoArrayLength ()]
		public void connect (uint accel_key, Gdk.ModifierType accel_mods, Gtk.AccelFlags accel_flags, GLib.Closure closure);
		[NoArrayLength ()]
		public void connect_by_path (string accel_path, GLib.Closure closure);
		[NoArrayLength ()]
		public bool disconnect (GLib.Closure closure);
		[NoArrayLength ()]
		public bool disconnect_key (uint accel_key, Gdk.ModifierType accel_mods);
		[NoArrayLength ()]
		public Gtk.AccelKey find (Gtk.AccelGroupFindFunc find_func, pointer data);
		[NoArrayLength ()]
		public static Gtk.AccelGroup from_accel_closure (GLib.Closure closure);
		[NoArrayLength ()]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		public void @lock ();
		[NoArrayLength ()]
		public construct ();
		[NoArrayLength ()]
		public Gtk.AccelGroupEntry query (uint accel_key, Gdk.ModifierType accel_mods, uint n_entries);
		[NoArrayLength ()]
		public void unlock ();
		public signal bool accel_activate (GLib.Object p0, uint p1, Gdk.ModifierType p2);
		public signal void accel_changed (uint keyval, Gdk.ModifierType modifier, GLib.Closure accel_closure);
	}
	public class AccelLabel : Gtk.Label {
		[NoArrayLength ()]
		public Gtk.Widget get_accel_widget ();
		[NoArrayLength ()]
		public uint get_accel_width ();
		[NoArrayLength ()]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		public construct (string string);
		[NoArrayLength ()]
		public bool refetch ();
		[NoArrayLength ()]
		public void set_accel_closure (GLib.Closure accel_closure);
		[NoArrayLength ()]
		public void set_accel_widget (Gtk.Widget accel_widget);
		[NoAccessorMethod ()]
		public weak GLib.Closure accel_closure { get; set; }
		public weak Gtk.Widget accel_widget { get; set; }
	}
	public class AccelMap : GLib.Object {
		[NoArrayLength ()]
		public static void add_entry (string accel_path, uint accel_key, Gdk.ModifierType accel_mods);
		[NoArrayLength ()]
		public static void add_filter (string filter_pattern);
		[NoArrayLength ()]
		public static bool change_entry (string accel_path, uint accel_key, Gdk.ModifierType accel_mods, bool replace);
		[NoArrayLength ()]
		public static void @foreach (pointer data, Gtk.AccelMapForeach foreach_func);
		[NoArrayLength ()]
		public static void foreach_unfiltered (pointer data, Gtk.AccelMapForeach foreach_func);
		[NoArrayLength ()]
		public static Gtk.AccelMap @get ();
		[NoArrayLength ()]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		public static void load (string file_name);
		[NoArrayLength ()]
		public static void load_fd (int fd);
		[NoArrayLength ()]
		public static void load_scanner (GLib.Scanner scanner);
		[NoArrayLength ()]
		public static void lock_path (string accel_path);
		[NoArrayLength ()]
		public static bool lookup_entry (string accel_path, Gtk.AccelKey key);
		[NoArrayLength ()]
		public static void save (string file_name);
		[NoArrayLength ()]
		public static void save_fd (int fd);
		[NoArrayLength ()]
		public static void unlock_path (string accel_path);
		public signal void changed (string p0, uint p1, Gdk.ModifierType p2);
	}
	public class Accessible : Atk.Object {
		[NoArrayLength ()]
		public virtual void connect_widget_destroyed ();
		[NoArrayLength ()]
		public static GLib.Type get_type ();
	}
	public class Action : GLib.Object {
		[NoArrayLength ()]
		public void block_activate_from (Gtk.Widget proxy);
		[NoArrayLength ()]
		public void connect_accelerator ();
		[NoArrayLength ()]
		public virtual void connect_proxy (Gtk.Widget proxy);
		[NoArrayLength ()]
		public Gtk.Widget create_icon (Gtk.IconSize icon_size);
		[NoArrayLength ()]
		public virtual Gtk.Widget create_menu_item ();
		[NoArrayLength ()]
		public virtual Gtk.Widget create_tool_item ();
		[NoArrayLength ()]
		public void disconnect_accelerator ();
		[NoArrayLength ()]
		public virtual void disconnect_proxy (Gtk.Widget proxy);
		[NoArrayLength ()]
		public GLib.Closure get_accel_closure ();
		[NoArrayLength ()]
		public string get_accel_path ();
		[NoArrayLength ()]
		public string get_name ();
		[NoArrayLength ()]
		public GLib.SList get_proxies ();
		[NoArrayLength ()]
		public bool get_sensitive ();
		[NoArrayLength ()]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		public bool get_visible ();
		[NoArrayLength ()]
		public bool is_sensitive ();
		[NoArrayLength ()]
		public bool is_visible ();
		[NoArrayLength ()]
		public construct (string name, string label, string tooltip, string stock_id);
		[NoArrayLength ()]
		public void set_accel_group (Gtk.AccelGroup accel_group);
		[NoArrayLength ()]
		public void set_accel_path (string accel_path);
		[NoArrayLength ()]
		public void set_sensitive (bool sensitive);
		[NoArrayLength ()]
		public void set_visible (bool visible);
		[NoArrayLength ()]
		public void unblock_activate_from (Gtk.Widget proxy);
		[NoAccessorMethod ()]
		public weak string name { get; construct; }
		[NoAccessorMethod ()]
		public weak string label { get; set; }
		[NoAccessorMethod ()]
		public weak string short_label { get; set; }
		[NoAccessorMethod ()]
		public weak string tooltip { get; set; }
		[NoAccessorMethod ()]
		public weak string stock_id { get; set; }
		[NoAccessorMethod ()]
		public weak string icon_name { get; set; }
		[NoAccessorMethod ()]
		public weak bool visible_horizontal { get; set; }
		[NoAccessorMethod ()]
		public weak bool visible_overflown { get; set; }
		[NoAccessorMethod ()]
		public weak bool visible_vertical { get; set; }
		[NoAccessorMethod ()]
		public weak bool is_important { get; set; }
		[NoAccessorMethod ()]
		public weak bool hide_if_empty { get; set; }
		public weak bool sensitive { get; set; }
		public weak bool visible { get; set; }
		[NoAccessorMethod ()]
		public weak Gtk.ActionGroup action_group { get; set; }
		[HasEmitter ()]
		public signal void activate ();
	}
	public class ActionGroup : GLib.Object {
		[NoArrayLength ()]
		public void add_action (Gtk.Action action);
		[NoArrayLength ()]
		public void add_action_with_accel (Gtk.Action action, string accelerator);
		[NoArrayLength ()]
		public void add_actions (Gtk.ActionEntry entries, uint n_entries, pointer user_data);
		[NoArrayLength ()]
		public void add_actions_full (Gtk.ActionEntry entries, uint n_entries, pointer user_data, GLib.DestroyNotify destroy);
		[NoArrayLength ()]
		public void add_radio_actions (Gtk.RadioActionEntry entries, uint n_entries, int value, GLib.Callback on_change, pointer user_data);
		[NoArrayLength ()]
		public void add_radio_actions_full (Gtk.RadioActionEntry entries, uint n_entries, int value, GLib.Callback on_change, pointer user_data, GLib.DestroyNotify destroy);
		[NoArrayLength ()]
		public void add_toggle_actions (Gtk.ToggleActionEntry entries, uint n_entries, pointer user_data);
		[NoArrayLength ()]
		public void add_toggle_actions_full (Gtk.ToggleActionEntry entries, uint n_entries, pointer user_data, GLib.DestroyNotify destroy);
		[NoArrayLength ()]
		public virtual Gtk.Action get_action (string action_name);
		[NoArrayLength ()]
		public string get_name ();
		[NoArrayLength ()]
		public bool get_sensitive ();
		[NoArrayLength ()]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		public bool get_visible ();
		[NoArrayLength ()]
		public GLib.List list_actions ();
		[NoArrayLength ()]
		public construct (string name);
		[NoArrayLength ()]
		public void remove_action (Gtk.Action action);
		[NoArrayLength ()]
		public void set_sensitive (bool sensitive);
		[NoArrayLength ()]
		public void set_translate_func (Gtk.TranslateFunc func, pointer data, Gtk.DestroyNotify notify);
		[NoArrayLength ()]
		public void set_translation_domain (string domain);
		[NoArrayLength ()]
		public void set_visible (bool visible);
		[NoArrayLength ()]
		public string translate_string (string string);
		[NoAccessorMethod ()]
		public weak string name { get; construct; }
		public weak bool sensitive { get; set; }
		public weak bool visible { get; set; }
		public signal void connect_proxy (Gtk.Action p0, Gtk.Widget p1);
		public signal void disconnect_proxy (Gtk.Action p0, Gtk.Widget p1);
		public signal void pre_activate (Gtk.Action p0);
		public signal void post_activate (Gtk.Action p0);
	}
	public class Adjustment : Gtk.Object {
		[NoArrayLength ()]
		public void clamp_page (double lower, double upper);
		[NoArrayLength ()]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		public double get_value ();
		[NoArrayLength ()]
		public construct (double value, double lower, double upper, double step_increment, double page_increment, double page_size);
		[NoArrayLength ()]
		public void set_value (double value);
		public weak double value { get; set; }
		[NoAccessorMethod ()]
		public weak double lower { get; set; }
		[NoAccessorMethod ()]
		public weak double upper { get; set; }
		[NoAccessorMethod ()]
		public weak double step_increment { get; set; }
		[NoAccessorMethod ()]
		public weak double page_increment { get; set; }
		[NoAccessorMethod ()]
		public weak double page_size { get; set; }
		[HasEmitter ()]
		public signal void changed ();
		[HasEmitter ()]
		public signal void value_changed ();
	}
	public class Alignment : Gtk.Bin {
		[NoArrayLength ()]
		public void get_padding (uint padding_top, uint padding_bottom, uint padding_left, uint padding_right);
		[NoArrayLength ()]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		public construct (float xalign, float yalign, float xscale, float yscale);
		[NoArrayLength ()]
		public void @set (float xalign, float yalign, float xscale, float yscale);
		[NoArrayLength ()]
		public void set_padding (uint padding_top, uint padding_bottom, uint padding_left, uint padding_right);
		[NoAccessorMethod ()]
		public weak float xalign { get; set; }
		[NoAccessorMethod ()]
		public weak float yalign { get; set; }
		[NoAccessorMethod ()]
		public weak float xscale { get; set; }
		[NoAccessorMethod ()]
		public weak float yscale { get; set; }
		[NoAccessorMethod ()]
		public weak uint top_padding { get; set; }
		[NoAccessorMethod ()]
		public weak uint bottom_padding { get; set; }
		[NoAccessorMethod ()]
		public weak uint left_padding { get; set; }
		[NoAccessorMethod ()]
		public weak uint right_padding { get; set; }
	}
	public class Arrow : Gtk.Misc {
		[NoArrayLength ()]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		public construct (Gtk.ArrowType arrow_type, Gtk.ShadowType shadow_type);
		[NoArrayLength ()]
		public void @set (Gtk.ArrowType arrow_type, Gtk.ShadowType shadow_type);
		[NoAccessorMethod ()]
		public weak Gtk.ArrowType arrow_type { get; set; }
		[NoAccessorMethod ()]
		public weak Gtk.ShadowType shadow_type { get; set; }
	}
	public class AspectFrame : Gtk.Frame {
		[NoArrayLength ()]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		public construct (string label, float xalign, float yalign, float ratio, bool obey_child);
		[NoArrayLength ()]
		public void @set (float xalign, float yalign, float ratio, bool obey_child);
		[NoAccessorMethod ()]
		public weak float xalign { get; set; }
		[NoAccessorMethod ()]
		public weak float yalign { get; set; }
		[NoAccessorMethod ()]
		public weak float ratio { get; set; }
		[NoAccessorMethod ()]
		public weak bool obey_child { get; set; }
	}
	public class Assistant : Gtk.Window {
		[NoArrayLength ()]
		public void add_action_widget (Gtk.Widget child);
		[NoArrayLength ()]
		public int append_page (Gtk.Widget page);
		[NoArrayLength ()]
		public int get_current_page ();
		[NoArrayLength ()]
		public int get_n_pages ();
		[NoArrayLength ()]
		public Gtk.Widget get_nth_page (int page_num);
		[NoArrayLength ()]
		public bool get_page_complete (Gtk.Widget page);
		[NoArrayLength ()]
		public Gdk.Pixbuf get_page_header_image (Gtk.Widget page);
		[NoArrayLength ()]
		public Gdk.Pixbuf get_page_side_image (Gtk.Widget page);
		[NoArrayLength ()]
		public string get_page_title (Gtk.Widget page);
		[NoArrayLength ()]
		public Gtk.AssistantPageType get_page_type (Gtk.Widget page);
		[NoArrayLength ()]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		public int insert_page (Gtk.Widget page, int position);
		[NoArrayLength ()]
		public construct ();
		[NoArrayLength ()]
		public int prepend_page (Gtk.Widget page);
		[NoArrayLength ()]
		public void remove_action_widget (Gtk.Widget child);
		[NoArrayLength ()]
		public void set_current_page (int page_num);
		[NoArrayLength ()]
		public void set_forward_page_func (Gtk.AssistantPageFunc page_func, pointer data, GLib.DestroyNotify destroy);
		[NoArrayLength ()]
		public void set_page_complete (Gtk.Widget page, bool complete);
		[NoArrayLength ()]
		public void set_page_header_image (Gtk.Widget page, Gdk.Pixbuf pixbuf);
		[NoArrayLength ()]
		public void set_page_side_image (Gtk.Widget page, Gdk.Pixbuf pixbuf);
		[NoArrayLength ()]
		public void set_page_title (Gtk.Widget page, string title);
		[NoArrayLength ()]
		public void set_page_type (Gtk.Widget page, Gtk.AssistantPageType type);
		[NoArrayLength ()]
		public void update_buttons_state ();
		public signal void cancel ();
		public signal void prepare (Gtk.Widget page);
		public signal void apply ();
		public signal void close ();
	}
	public class Bin : Gtk.Container {
		[NoArrayLength ()]
		public Gtk.Widget get_child ();
		[NoArrayLength ()]
		public static GLib.Type get_type ();
	}
	public class Box : Gtk.Container {
		public weak GLib.List children;
		[NoArrayLength ()]
		public bool get_homogeneous ();
		[NoArrayLength ()]
		public int get_spacing ();
		[NoArrayLength ()]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		public void pack_end (Gtk.Widget child, bool expand, bool fill, uint padding);
		[NoArrayLength ()]
		public void pack_end_defaults (Gtk.Widget widget);
		[NoArrayLength ()]
		public void pack_start (Gtk.Widget child, bool expand, bool fill, uint padding);
		[NoArrayLength ()]
		public void pack_start_defaults (Gtk.Widget widget);
		[NoArrayLength ()]
		public void query_child_packing (Gtk.Widget child, bool expand, bool fill, uint padding, Gtk.PackType pack_type);
		[NoArrayLength ()]
		public void reorder_child (Gtk.Widget child, int position);
		[NoArrayLength ()]
		public void set_child_packing (Gtk.Widget child, bool expand, bool fill, uint padding, Gtk.PackType pack_type);
		[NoArrayLength ()]
		public void set_homogeneous (bool homogeneous);
		[NoArrayLength ()]
		public void set_spacing (int spacing);
		public weak int spacing { get; set; }
		public weak bool homogeneous { get; set; }
	}
	public class Button : Gtk.Bin {
		[NoArrayLength ()]
		public static GLib.Type action_get_type ();
		[NoArrayLength ()]
		public void get_alignment (float xalign, float yalign);
		[NoArrayLength ()]
		public bool get_focus_on_click ();
		[NoArrayLength ()]
		public Gtk.Widget get_image ();
		[NoArrayLength ()]
		public Gtk.PositionType get_image_position ();
		[NoArrayLength ()]
		public string get_label ();
		[NoArrayLength ()]
		public Gtk.ReliefStyle get_relief ();
		[NoArrayLength ()]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		public bool get_use_stock ();
		[NoArrayLength ()]
		public bool get_use_underline ();
		[NoArrayLength ()]
		public construct ();
		[NoArrayLength ()]
		public construct from_stock (string stock_id);
		[NoArrayLength ()]
		public construct with_label (string label);
		[NoArrayLength ()]
		public construct with_mnemonic (string label);
		[NoArrayLength ()]
		public void set_alignment (float xalign, float yalign);
		[NoArrayLength ()]
		public void set_focus_on_click (bool focus_on_click);
		[NoArrayLength ()]
		public void set_image (Gtk.Widget image);
		[NoArrayLength ()]
		public void set_image_position (Gtk.PositionType position);
		[NoArrayLength ()]
		public void set_label (string label);
		[NoArrayLength ()]
		public void set_relief (Gtk.ReliefStyle newstyle);
		[NoArrayLength ()]
		public void set_use_stock (bool use_stock);
		[NoArrayLength ()]
		public void set_use_underline (bool use_underline);
		public weak string label { get; set construct; }
		public weak bool use_underline { get; set construct; }
		public weak bool use_stock { get; set construct; }
		public weak bool focus_on_click { get; set; }
		public weak Gtk.ReliefStyle relief { get; set; }
		[NoAccessorMethod ()]
		public weak float xalign { get; set; }
		[NoAccessorMethod ()]
		public weak float yalign { get; set; }
		public weak Gtk.Widget image { get; set; }
		public weak Gtk.PositionType image_position { get; set; }
		[HasEmitter ()]
		public signal void pressed ();
		[HasEmitter ()]
		public signal void released ();
		[HasEmitter ()]
		public signal void clicked ();
		[HasEmitter ()]
		public signal void enter ();
		[HasEmitter ()]
		public signal void leave ();
		public signal void activate ();
	}
	public class ButtonBox : Gtk.Box {
		[NoArrayLength ()]
		public bool get_child_secondary (Gtk.Widget child);
		[NoArrayLength ()]
		public Gtk.ButtonBoxStyle get_layout ();
		[NoArrayLength ()]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		public void set_child_secondary (Gtk.Widget child, bool is_secondary);
		[NoArrayLength ()]
		public void set_layout (Gtk.ButtonBoxStyle layout_style);
		[NoAccessorMethod ()]
		public weak Gtk.ButtonBoxStyle layout_style { get; set; }
	}
	public class Calendar : Gtk.Widget {
		[NoArrayLength ()]
		public void clear_marks ();
		[NoArrayLength ()]
		public void get_date (uint year, uint month, uint day);
		[NoArrayLength ()]
		public Gtk.CalendarDisplayOptions get_display_options ();
		[NoArrayLength ()]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		public bool mark_day (uint day);
		[NoArrayLength ()]
		public construct ();
		[NoArrayLength ()]
		public void select_day (uint day);
		[NoArrayLength ()]
		public bool select_month (uint month, uint year);
		[NoArrayLength ()]
		public void set_display_options (Gtk.CalendarDisplayOptions @flags);
		[NoArrayLength ()]
		public bool unmark_day (uint day);
		[NoAccessorMethod ()]
		public weak int year { get; set; }
		[NoAccessorMethod ()]
		public weak int month { get; set; }
		[NoAccessorMethod ()]
		public weak int day { get; set; }
		[NoAccessorMethod ()]
		public weak bool show_heading { get; set; }
		[NoAccessorMethod ()]
		public weak bool show_day_names { get; set; }
		[NoAccessorMethod ()]
		public weak bool no_month_change { get; set; }
		[NoAccessorMethod ()]
		public weak bool show_week_numbers { get; set; }
		public signal void month_changed ();
		public signal void day_selected ();
		public signal void day_selected_double_click ();
		public signal void prev_month ();
		public signal void next_month ();
		public signal void prev_year ();
		public signal void next_year ();
	}
	public class CellRenderer : Gtk.Object {
		[NoArrayLength ()]
		public virtual bool activate (Gdk.Event event, Gtk.Widget widget, string path, Gdk.Rectangle background_area, Gdk.Rectangle cell_area, Gtk.CellRendererState @flags);
		[NoArrayLength ()]
		public void get_fixed_size (int width, int height);
		[NoArrayLength ()]
		public virtual void get_size (Gtk.Widget widget, Gdk.Rectangle cell_area, int x_offset, int y_offset, int width, int height);
		[NoArrayLength ()]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		public virtual void render (Gdk.Window window, Gtk.Widget widget, Gdk.Rectangle background_area, Gdk.Rectangle cell_area, Gdk.Rectangle expose_area, Gtk.CellRendererState @flags);
		[NoArrayLength ()]
		public void set_fixed_size (int width, int height);
		[NoArrayLength ()]
		public virtual Gtk.CellEditable start_editing (Gdk.Event event, Gtk.Widget widget, string path, Gdk.Rectangle background_area, Gdk.Rectangle cell_area, Gtk.CellRendererState @flags);
		[NoArrayLength ()]
		public void stop_editing (bool canceled);
		[NoAccessorMethod ()]
		public weak Gtk.CellRendererMode mode { get; set; }
		[NoAccessorMethod ()]
		public weak bool visible { get; set; }
		[NoAccessorMethod ()]
		public weak bool sensitive { get; set; }
		[NoAccessorMethod ()]
		public weak float xalign { get; set; }
		[NoAccessorMethod ()]
		public weak float yalign { get; set; }
		[NoAccessorMethod ()]
		public weak uint xpad { get; set; }
		[NoAccessorMethod ()]
		public weak uint ypad { get; set; }
		[NoAccessorMethod ()]
		public weak int width { get; set; }
		[NoAccessorMethod ()]
		public weak int height { get; set; }
		[NoAccessorMethod ()]
		public weak bool is_expander { get; set; }
		[NoAccessorMethod ()]
		public weak bool is_expanded { get; set; }
		[NoAccessorMethod ()]
		public weak string cell_background { set; }
		[NoAccessorMethod ()]
		public weak Gdk.Color cell_background_gdk { get; set; }
		public signal void editing_canceled ();
		public signal void editing_started (Gtk.CellEditable editable, string path);
	}
	public class CellRendererAccel : Gtk.CellRendererText {
		[NoArrayLength ()]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		public construct ();
		[NoAccessorMethod ()]
		public weak uint accel_key { get; set; }
		[NoAccessorMethod ()]
		public weak Gdk.ModifierType accel_mods { get; set; }
		[NoAccessorMethod ()]
		public weak uint keycode { get; set; }
		[NoAccessorMethod ()]
		public weak Gtk.CellRendererAccelMode accel_mode { get; set; }
		public signal void accel_edited (string path_string, uint accel_key, Gdk.ModifierType accel_mods, uint hardware_keycode);
		public signal void accel_cleared (string path_string);
	}
	public class CellRendererCombo : Gtk.CellRendererText {
		[NoArrayLength ()]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		public construct ();
		[NoAccessorMethod ()]
		public weak Gtk.TreeModel model { get; set; }
		[NoAccessorMethod ()]
		public weak int text_column { get; set; }
		[NoAccessorMethod ()]
		public weak bool has_entry { get; set; }
	}
	public class CellRendererPixbuf : Gtk.CellRenderer {
		[NoArrayLength ()]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		public construct ();
		[NoAccessorMethod ()]
		public weak Gdk.Pixbuf pixbuf { get; set; }
		[NoAccessorMethod ()]
		public weak Gdk.Pixbuf pixbuf_expander_open { get; set; }
		[NoAccessorMethod ()]
		public weak Gdk.Pixbuf pixbuf_expander_closed { get; set; }
		[NoAccessorMethod ()]
		public weak string stock_id { get; set; }
		[NoAccessorMethod ()]
		public weak uint stock_size { get; set; }
		[NoAccessorMethod ()]
		public weak string stock_detail { get; set; }
		[NoAccessorMethod ()]
		public weak string icon_name { get; set; }
		[NoAccessorMethod ()]
		public weak bool follow_state { get; set; }
	}
	public class CellRendererProgress : Gtk.CellRenderer {
		[NoArrayLength ()]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		public construct ();
		[NoAccessorMethod ()]
		public weak int value { get; set; }
		[NoAccessorMethod ()]
		public weak string text { get; set; }
	}
	public class CellRendererSpin : Gtk.CellRendererText {
		[NoArrayLength ()]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		public construct ();
		[NoAccessorMethod ()]
		public weak Gtk.Adjustment adjustment { get; set; }
		[NoAccessorMethod ()]
		public weak double climb_rate { get; set; }
		[NoAccessorMethod ()]
		public weak uint digits { get; set; }
	}
	public class CellRendererText : Gtk.CellRenderer {
		[NoArrayLength ()]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		public construct ();
		[NoArrayLength ()]
		public void set_fixed_height_from_font (int number_of_rows);
		[NoAccessorMethod ()]
		public weak string text { get; set; }
		[NoAccessorMethod ()]
		public weak string markup { set; }
		[NoAccessorMethod ()]
		public weak Pango.AttrList attributes { get; set; }
		[NoAccessorMethod ()]
		public weak bool single_paragraph_mode { get; set; }
		[NoAccessorMethod ()]
		public weak string background { set; }
		[NoAccessorMethod ()]
		public weak Gdk.Color background_gdk { get; set; }
		[NoAccessorMethod ()]
		public weak string foreground { set; }
		[NoAccessorMethod ()]
		public weak Gdk.Color foreground_gdk { get; set; }
		[NoAccessorMethod ()]
		public weak bool editable { get; set; }
		[NoAccessorMethod ()]
		public weak string font { get; set; }
		[NoAccessorMethod ()]
		public weak Pango.FontDescription font_desc { get; set; }
		[NoAccessorMethod ()]
		public weak string family { get; set; }
		[NoAccessorMethod ()]
		public weak Pango.Style style { get; set; }
		[NoAccessorMethod ()]
		public weak Pango.Variant variant { get; set; }
		[NoAccessorMethod ()]
		public weak int weight { get; set; }
		[NoAccessorMethod ()]
		public weak Pango.Stretch stretch { get; set; }
		[NoAccessorMethod ()]
		public weak int size { get; set; }
		[NoAccessorMethod ()]
		public weak double size_points { get; set; }
		[NoAccessorMethod ()]
		public weak double scale { get; set; }
		[NoAccessorMethod ()]
		public weak int rise { get; set; }
		[NoAccessorMethod ()]
		public weak bool strikethrough { get; set; }
		[NoAccessorMethod ()]
		public weak Pango.Underline underline { get; set; }
		[NoAccessorMethod ()]
		public weak string language { get; set; }
		[NoAccessorMethod ()]
		public weak Pango.EllipsizeMode ellipsize { get; set; }
		[NoAccessorMethod ()]
		public weak int width_chars { get; set; }
		[NoAccessorMethod ()]
		public weak Pango.WrapMode wrap_mode { get; set; }
		[NoAccessorMethod ()]
		public weak int wrap_width { get; set; }
		[NoAccessorMethod ()]
		public weak Pango.Alignment alignment { get; set; }
		public signal void edited (string path, string new_text);
	}
	public class CellRendererToggle : Gtk.CellRenderer {
		[NoArrayLength ()]
		public bool get_active ();
		[NoArrayLength ()]
		public bool get_radio ();
		[NoArrayLength ()]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		public construct ();
		[NoArrayLength ()]
		public void set_active (bool setting);
		[NoArrayLength ()]
		public void set_radio (bool radio);
		public weak bool active { get; set; }
		[NoAccessorMethod ()]
		public weak bool inconsistent { get; set; }
		[NoAccessorMethod ()]
		public weak bool activatable { get; set; }
		public weak bool radio { get; set; }
		[NoAccessorMethod ()]
		public weak int indicator_size { get; set; }
		public signal void toggled (string path);
	}
	public class CellView : Gtk.Widget, Gtk.CellLayout {
		[NoArrayLength ()]
		public GLib.List get_cell_renderers ();
		[NoArrayLength ()]
		public Gtk.TreePath get_displayed_row ();
		[NoArrayLength ()]
		public bool get_size_of_row (Gtk.TreePath path, Gtk.Requisition requisition);
		[NoArrayLength ()]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		public construct ();
		[NoArrayLength ()]
		public construct with_markup (string markup);
		[NoArrayLength ()]
		public construct with_pixbuf (Gdk.Pixbuf pixbuf);
		[NoArrayLength ()]
		public construct with_text (string text);
		[NoArrayLength ()]
		public void set_background_color (Gdk.Color color);
		[NoArrayLength ()]
		public void set_displayed_row (Gtk.TreePath path);
		[NoArrayLength ()]
		public void set_model (Gtk.TreeModel model);
		[NoAccessorMethod ()]
		public weak string background { set; }
		[NoAccessorMethod ()]
		public weak Gdk.Color background_gdk { get; set; }
		[NoAccessorMethod ()]
		public weak Gtk.TreeModel model { get; set; }
	}
	public class CheckButton : Gtk.ToggleButton {
		[NoArrayLength ()]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		public construct ();
		[NoArrayLength ()]
		public construct with_label (string label);
		[NoArrayLength ()]
		public construct with_mnemonic (string label);
	}
	public class CheckMenuItem : Gtk.MenuItem {
		[NoArrayLength ()]
		public bool get_active ();
		[NoArrayLength ()]
		public bool get_draw_as_radio ();
		[NoArrayLength ()]
		public bool get_inconsistent ();
		[NoArrayLength ()]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		public construct ();
		[NoArrayLength ()]
		public construct with_label (string label);
		[NoArrayLength ()]
		public construct with_mnemonic (string label);
		[NoArrayLength ()]
		public void set_active (bool is_active);
		[NoArrayLength ()]
		public void set_draw_as_radio (bool draw_as_radio);
		[NoArrayLength ()]
		public void set_inconsistent (bool setting);
		public weak bool active { get; set; }
		public weak bool inconsistent { get; set; }
		public weak bool draw_as_radio { get; set; }
		[HasEmitter ()]
		public signal void toggled ();
	}
	public class Clipboard : GLib.Object {
		[NoArrayLength ()]
		public void clear ();
		[NoArrayLength ()]
		public static Gtk.Clipboard @get (Gdk.Atom selection);
		[NoArrayLength ()]
		public Gdk.Display get_display ();
		[NoArrayLength ()]
		public static Gtk.Clipboard get_for_display (Gdk.Display display, Gdk.Atom selection);
		[NoArrayLength ()]
		public GLib.Object get_owner ();
		[NoArrayLength ()]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		public void request_contents (Gdk.Atom target, Gtk.ClipboardReceivedFunc @callback, pointer user_data);
		[NoArrayLength ()]
		public void request_image (Gtk.ClipboardImageReceivedFunc @callback, pointer user_data);
		[NoArrayLength ()]
		public void request_rich_text (Gtk.TextBuffer buffer, Gtk.ClipboardRichTextReceivedFunc @callback, pointer user_data);
		[NoArrayLength ()]
		public void request_targets (Gtk.ClipboardTargetsReceivedFunc @callback, pointer user_data);
		[NoArrayLength ()]
		public void request_text (Gtk.ClipboardTextReceivedFunc @callback, pointer user_data);
		[NoArrayLength ()]
		public void set_can_store (Gtk.TargetEntry targets, int n_targets);
		[NoArrayLength ()]
		public void set_image (Gdk.Pixbuf pixbuf);
		[NoArrayLength ()]
		public void set_text (string text, int len);
		[NoArrayLength ()]
		public bool set_with_data (Gtk.TargetEntry targets, uint n_targets, Gtk.ClipboardGetFunc get_func, Gtk.ClipboardClearFunc clear_func, pointer user_data);
		[NoArrayLength ()]
		public bool set_with_owner (Gtk.TargetEntry targets, uint n_targets, Gtk.ClipboardGetFunc get_func, Gtk.ClipboardClearFunc clear_func, GLib.Object owner);
		[NoArrayLength ()]
		public void store ();
		[NoArrayLength ()]
		public Gtk.SelectionData wait_for_contents (Gdk.Atom target);
		[NoArrayLength ()]
		public Gdk.Pixbuf wait_for_image ();
		[NoArrayLength ()]
		public uchar wait_for_rich_text (Gtk.TextBuffer buffer, Gdk.Atom format, ulong length);
		[NoArrayLength ()]
		public bool wait_for_targets (Gdk.Atom targets, int n_targets);
		[NoArrayLength ()]
		public string wait_for_text ();
		[NoArrayLength ()]
		public bool wait_is_image_available ();
		[NoArrayLength ()]
		public bool wait_is_rich_text_available (Gtk.TextBuffer buffer);
		[NoArrayLength ()]
		public bool wait_is_target_available (Gdk.Atom target);
		[NoArrayLength ()]
		public bool wait_is_text_available ();
		public signal void owner_change (Gdk.EventOwnerChange event);
	}
	public class ColorButton : Gtk.Button {
		[NoArrayLength ()]
		public ushort get_alpha ();
		[NoArrayLength ()]
		public void get_color (Gdk.Color color);
		[NoArrayLength ()]
		public string get_title ();
		[NoArrayLength ()]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		public bool get_use_alpha ();
		[NoArrayLength ()]
		public construct ();
		[NoArrayLength ()]
		public construct with_color (Gdk.Color color);
		[NoArrayLength ()]
		public void set_alpha (ushort alpha);
		[NoArrayLength ()]
		public void set_color (Gdk.Color color);
		[NoArrayLength ()]
		public void set_title (string title);
		[NoArrayLength ()]
		public void set_use_alpha (bool use_alpha);
		public weak bool use_alpha { get; set; }
		public weak string title { get; set; }
		public weak Gdk.Color color { get; set; }
		public weak uint alpha { get; set; }
		public signal void color_set ();
	}
	public class ColorSelection : Gtk.VBox {
		[NoArrayLength ()]
		public ushort get_current_alpha ();
		[NoArrayLength ()]
		public void get_current_color (Gdk.Color color);
		[NoArrayLength ()]
		public bool get_has_opacity_control ();
		[NoArrayLength ()]
		public bool get_has_palette ();
		[NoArrayLength ()]
		public ushort get_previous_alpha ();
		[NoArrayLength ()]
		public void get_previous_color (Gdk.Color color);
		[NoArrayLength ()]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		public bool is_adjusting ();
		[NoArrayLength ()]
		public construct ();
		[NoArrayLength ()]
		public static bool palette_from_string (string str, Gdk.Color colors, int n_colors);
		[NoArrayLength ()]
		public static string palette_to_string (Gdk.Color colors, int n_colors);
		[NoArrayLength ()]
		public static Gtk.ColorSelectionChangePaletteWithScreenFunc set_change_palette_with_screen_hook (Gtk.ColorSelectionChangePaletteWithScreenFunc func);
		[NoArrayLength ()]
		public void set_current_alpha (ushort alpha);
		[NoArrayLength ()]
		public void set_current_color (Gdk.Color color);
		[NoArrayLength ()]
		public void set_has_opacity_control (bool has_opacity);
		[NoArrayLength ()]
		public void set_has_palette (bool has_palette);
		[NoArrayLength ()]
		public void set_previous_alpha (ushort alpha);
		[NoArrayLength ()]
		public void set_previous_color (Gdk.Color color);
		public weak bool has_opacity_control { get; set; }
		public weak bool has_palette { get; set; }
		public weak Gdk.Color current_color { get; set; }
		public weak uint current_alpha { get; set; }
		public signal void color_changed ();
	}
	public class ColorSelectionDialog : Gtk.Dialog {
		[NoArrayLength ()]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		public construct (string title);
	}
	public class Combo : Gtk.HBox {
		public weak Gtk.Widget entry;
		public weak Gtk.Widget list;
		[NoAccessorMethod ()]
		public weak bool enable_arrow_keys { get; set; }
		[NoAccessorMethod ()]
		public weak bool enable_arrows_always { get; set; }
		[NoAccessorMethod ()]
		public weak bool case_sensitive { get; set; }
		[NoAccessorMethod ()]
		public weak bool allow_empty { get; set; }
		[NoAccessorMethod ()]
		public weak bool value_in_list { get; set; }
	}
	public class ComboBox : Gtk.Bin, Gtk.CellLayout, Gtk.CellEditable {
		[NoArrayLength ()]
		public void append_text (string text);
		[NoArrayLength ()]
		public int get_active ();
		[NoArrayLength ()]
		public bool get_active_iter (Gtk.TreeIter iter);
		[NoArrayLength ()]
		public virtual string get_active_text ();
		[NoArrayLength ()]
		public bool get_add_tearoffs ();
		[NoArrayLength ()]
		public int get_column_span_column ();
		[NoArrayLength ()]
		public bool get_focus_on_click ();
		[NoArrayLength ()]
		public Gtk.TreeModel get_model ();
		[NoArrayLength ()]
		public Atk.Object get_popup_accessible ();
		[NoArrayLength ()]
		public Gtk.TreeViewRowSeparatorFunc get_row_separator_func ();
		[NoArrayLength ()]
		public int get_row_span_column ();
		[NoArrayLength ()]
		public string get_title ();
		[NoArrayLength ()]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		public int get_wrap_width ();
		[NoArrayLength ()]
		public void insert_text (int position, string text);
		[NoArrayLength ()]
		public construct ();
		[NoArrayLength ()]
		public construct text ();
		[NoArrayLength ()]
		public construct with_model (Gtk.TreeModel model);
		[NoArrayLength ()]
		public void popdown ();
		[NoArrayLength ()]
		public void popup ();
		[NoArrayLength ()]
		public void prepend_text (string text);
		[NoArrayLength ()]
		public void remove_text (int position);
		[NoArrayLength ()]
		public void set_active (int index_);
		[NoArrayLength ()]
		public void set_active_iter (Gtk.TreeIter iter);
		[NoArrayLength ()]
		public void set_add_tearoffs (bool add_tearoffs);
		[NoArrayLength ()]
		public void set_column_span_column (int column_span);
		[NoArrayLength ()]
		public void set_focus_on_click (bool focus_on_click);
		[NoArrayLength ()]
		public void set_model (Gtk.TreeModel model);
		[NoArrayLength ()]
		public void set_row_separator_func (Gtk.TreeViewRowSeparatorFunc func, pointer data, Gtk.DestroyNotify destroy);
		[NoArrayLength ()]
		public void set_row_span_column (int row_span);
		[NoArrayLength ()]
		public void set_title (string title);
		[NoArrayLength ()]
		public void set_wrap_width (int width);
		public weak Gtk.TreeModel model { get; set; }
		public weak int wrap_width { get; set; }
		public weak int row_span_column { get; set; }
		public weak int column_span_column { get; set; }
		public weak int active { get; set; }
		public weak bool add_tearoffs { get; set; }
		[NoAccessorMethod ()]
		public weak bool has_frame { get; set; }
		public weak bool focus_on_click { get; set; }
		[NoAccessorMethod ()]
		public weak string tearoff_title { get; set; }
		[NoAccessorMethod ()]
		public weak bool popup_shown { get; }
		public signal void changed ();
	}
	public class ComboBoxEntry : Gtk.ComboBox {
		[NoArrayLength ()]
		public int get_text_column ();
		[NoArrayLength ()]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		public construct ();
		[NoArrayLength ()]
		public construct text ();
		[NoArrayLength ()]
		public construct with_model (Gtk.TreeModel model, int text_column);
		[NoArrayLength ()]
		public void set_text_column (int text_column);
		public weak int text_column { get; set; }
	}
	public class Container : Gtk.Widget {
		[NoArrayLength ()]
		public void add_with_properties (Gtk.Widget widget, string first_prop_name);
		[NoArrayLength ()]
		public void child_get (Gtk.Widget child, string first_prop_name);
		[NoArrayLength ()]
		public void child_get_property (Gtk.Widget child, string property_name, GLib.Value value);
		[NoArrayLength ()]
		public void child_get_valist (Gtk.Widget child, string first_property_name, pointer var_args);
		[NoArrayLength ()]
		public void child_set (Gtk.Widget child, string first_prop_name);
		[NoArrayLength ()]
		public void child_set_property (Gtk.Widget child, string property_name, GLib.Value value);
		[NoArrayLength ()]
		public void child_set_valist (Gtk.Widget child, string first_property_name, pointer var_args);
		[NoArrayLength ()]
		public virtual GLib.Type child_type ();
		[NoArrayLength ()]
		public static GLib.ParamSpec class_find_child_property (pointer cclass, string property_name);
		[NoArrayLength ()]
		public static void class_install_child_property (pointer cclass, uint property_id, GLib.ParamSpec pspec);
		[NoArrayLength ()]
		public static GLib.ParamSpec class_list_child_properties (pointer cclass, uint n_properties);
		[NoArrayLength ()]
		public virtual void forall (Gtk.Callback @callback, pointer callback_data);
		[NoArrayLength ()]
		public void @foreach (Gtk.Callback @callback, pointer callback_data);
		[NoArrayLength ()]
		public uint get_border_width ();
		[NoArrayLength ()]
		public GLib.List get_children ();
		[NoArrayLength ()]
		public bool get_focus_chain (GLib.List focusable_widgets);
		[NoArrayLength ()]
		public Gtk.Adjustment get_focus_hadjustment ();
		[NoArrayLength ()]
		public Gtk.Adjustment get_focus_vadjustment ();
		[NoArrayLength ()]
		public Gtk.ResizeMode get_resize_mode ();
		[NoArrayLength ()]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		public void propagate_expose (Gtk.Widget child, Gdk.EventExpose event);
		[NoArrayLength ()]
		public void resize_children ();
		[NoArrayLength ()]
		public void set_border_width (uint border_width);
		[NoArrayLength ()]
		public void set_focus_chain (GLib.List focusable_widgets);
		[NoArrayLength ()]
		public void set_focus_hadjustment (Gtk.Adjustment adjustment);
		[NoArrayLength ()]
		public void set_focus_vadjustment (Gtk.Adjustment adjustment);
		[NoArrayLength ()]
		public void set_reallocate_redraws (bool needs_redraws);
		[NoArrayLength ()]
		public void set_resize_mode (Gtk.ResizeMode resize_mode);
		[NoArrayLength ()]
		public void unset_focus_chain ();
		public weak Gtk.ResizeMode resize_mode { get; set; }
		public weak uint border_width { get; set; }
		[NoAccessorMethod ()]
		public weak Gtk.Widget child { set; }
		[HasEmitter ()]
		public signal void add (Gtk.Widget widget);
		[HasEmitter ()]
		public signal void remove (Gtk.Widget widget);
		[HasEmitter ()]
		public signal void check_resize ();
		[HasEmitter ()]
		public signal void set_focus_child (Gtk.Widget widget);
	}
	public class Curve : Gtk.DrawingArea {
		[NoArrayLength ()]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		public void get_vector (int veclen, float[] vector);
		[NoArrayLength ()]
		public construct ();
		[NoArrayLength ()]
		public void reset ();
		[NoArrayLength ()]
		public void set_curve_type (Gtk.CurveType type);
		[NoArrayLength ()]
		public void set_gamma (float gamma_);
		[NoArrayLength ()]
		public void set_range (float min_x, float max_x, float min_y, float max_y);
		[NoArrayLength ()]
		public void set_vector (int veclen, float[] vector);
		[NoAccessorMethod ()]
		public weak Gtk.CurveType curve_type { get; set; }
		[NoAccessorMethod ()]
		public weak float min_x { get; set; }
		[NoAccessorMethod ()]
		public weak float max_x { get; set; }
		[NoAccessorMethod ()]
		public weak float min_y { get; set; }
		[NoAccessorMethod ()]
		public weak float max_y { get; set; }
		public signal void curve_type_changed ();
	}
	public class Dialog : Gtk.Window {
		public weak Gtk.Widget vbox;
		public weak Gtk.Widget action_area;
		[NoArrayLength ()]
		public void add_action_widget (Gtk.Widget child, int response_id);
		[NoArrayLength ()]
		public Gtk.Widget add_button (string button_text, int response_id);
		[NoArrayLength ()]
		public void add_buttons (string first_button_text);
		[NoArrayLength ()]
		public bool get_has_separator ();
		[NoArrayLength ()]
		public int get_response_for_widget (Gtk.Widget widget);
		[NoArrayLength ()]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		public construct ();
		[NoArrayLength ()]
		public construct with_buttons (string title, Gtk.Window parent, Gtk.DialogFlags @flags, string first_button_text);
		[NoArrayLength ()]
		public int run ();
		[NoArrayLength ()]
		public void set_alternative_button_order (int first_response_id);
		[NoArrayLength ()]
		public void set_alternative_button_order_from_array (int n_params, int new_order);
		[NoArrayLength ()]
		public void set_default_response (int response_id);
		[NoArrayLength ()]
		public void set_has_separator (bool setting);
		[NoArrayLength ()]
		public void set_response_sensitive (int response_id, bool setting);
		public weak bool has_separator { get; set; }
		[HasEmitter ()]
		public signal void response (int response_id);
		public signal void close ();
	}
	public class DrawingArea : Gtk.Widget {
		[NoArrayLength ()]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		public construct ();
	}
	public class Entry : Gtk.Widget, Gtk.Editable, Gtk.CellEditable {
		[NoArrayLength ()]
		public bool get_activates_default ();
		[NoArrayLength ()]
		public float get_alignment ();
		[NoArrayLength ()]
		public Gtk.EntryCompletion get_completion ();
		[NoArrayLength ()]
		public bool get_has_frame ();
		[NoArrayLength ()]
		public Gtk.Border get_inner_border ();
		[NoArrayLength ()]
		public unichar get_invisible_char ();
		[NoArrayLength ()]
		public Pango.Layout get_layout ();
		[NoArrayLength ()]
		public void get_layout_offsets (int x, int y);
		[NoArrayLength ()]
		public int get_max_length ();
		[NoArrayLength ()]
		public string get_text ();
		[NoArrayLength ()]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		public bool get_visibility ();
		[NoArrayLength ()]
		public int get_width_chars ();
		[NoArrayLength ()]
		public int layout_index_to_text_index (int layout_index);
		[NoArrayLength ()]
		public construct ();
		[NoArrayLength ()]
		public void set_activates_default (bool setting);
		[NoArrayLength ()]
		public void set_alignment (float xalign);
		[NoArrayLength ()]
		public void set_completion (Gtk.EntryCompletion completion);
		[NoArrayLength ()]
		public void set_has_frame (bool setting);
		[NoArrayLength ()]
		public void set_inner_border (Gtk.Border border);
		[NoArrayLength ()]
		public void set_invisible_char (unichar ch);
		[NoArrayLength ()]
		public void set_max_length (int max);
		[NoArrayLength ()]
		public void set_text (string text);
		[NoArrayLength ()]
		public void set_visibility (bool visible);
		[NoArrayLength ()]
		public void set_width_chars (int n_chars);
		[NoArrayLength ()]
		public int text_index_to_layout_index (int text_index);
		[NoAccessorMethod ()]
		public weak int cursor_position { get; }
		[NoAccessorMethod ()]
		public weak int selection_bound { get; }
		[NoAccessorMethod ()]
		public weak bool editable { get; set; }
		public weak int max_length { get; set; }
		public weak bool visibility { get; set; }
		public weak bool has_frame { get; set; }
		public weak Gtk.Border inner_border { get; set; }
		public weak unichar invisible_char { get; set; }
		public weak bool activates_default { get; set; }
		public weak int width_chars { get; set; }
		[NoAccessorMethod ()]
		public weak int scroll_offset { get; }
		public weak string text { get; set; }
		[NoAccessorMethod ()]
		public weak float xalign { get; set; }
		[NoAccessorMethod ()]
		public weak bool truncate_multiline { get; set; }
		public signal void populate_popup (Gtk.Menu menu);
		public signal void activate ();
		public signal void move_cursor (Gtk.MovementStep step, int count, bool extend_selection);
		public signal void insert_at_cursor (string str);
		public signal void delete_from_cursor (Gtk.DeleteType type, int count);
		public signal void backspace ();
		public signal void cut_clipboard ();
		public signal void copy_clipboard ();
		public signal void paste_clipboard ();
		public signal void toggle_overwrite ();
	}
	public class EntryCompletion : GLib.Object, Gtk.CellLayout {
		[NoArrayLength ()]
		public void complete ();
		[NoArrayLength ()]
		public void delete_action (int index_);
		[NoArrayLength ()]
		public Gtk.Widget get_entry ();
		[NoArrayLength ()]
		public bool get_inline_completion ();
		[NoArrayLength ()]
		public int get_minimum_key_length ();
		[NoArrayLength ()]
		public Gtk.TreeModel get_model ();
		[NoArrayLength ()]
		public bool get_popup_completion ();
		[NoArrayLength ()]
		public bool get_popup_set_width ();
		[NoArrayLength ()]
		public bool get_popup_single_match ();
		[NoArrayLength ()]
		public int get_text_column ();
		[NoArrayLength ()]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		public void insert_action_markup (int index_, string markup);
		[NoArrayLength ()]
		public void insert_action_text (int index_, string text);
		[NoArrayLength ()]
		public construct ();
		[NoArrayLength ()]
		public void set_inline_completion (bool inline_completion);
		[NoArrayLength ()]
		public void set_match_func (Gtk.EntryCompletionMatchFunc func, pointer func_data, GLib.DestroyNotify func_notify);
		[NoArrayLength ()]
		public void set_minimum_key_length (int length);
		[NoArrayLength ()]
		public void set_model (Gtk.TreeModel model);
		[NoArrayLength ()]
		public void set_popup_completion (bool popup_completion);
		[NoArrayLength ()]
		public void set_popup_set_width (bool popup_set_width);
		[NoArrayLength ()]
		public void set_popup_single_match (bool popup_single_match);
		[NoArrayLength ()]
		public void set_text_column (int column);
		public weak Gtk.TreeModel model { get; set; }
		public weak int minimum_key_length { get; set; }
		public weak int text_column { get; set; }
		public weak bool inline_completion { get; set; }
		public weak bool popup_completion { get; set; }
		public weak bool popup_set_width { get; set; }
		public weak bool popup_single_match { get; set; }
		[HasEmitter ()]
		public signal bool insert_prefix (string prefix);
		public signal bool match_selected (Gtk.TreeModel model, Gtk.TreeIter iter);
		public signal void action_activated (int index_);
	}
	public class EventBox : Gtk.Bin {
		[NoArrayLength ()]
		public bool get_above_child ();
		[NoArrayLength ()]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		public bool get_visible_window ();
		[NoArrayLength ()]
		public construct ();
		[NoArrayLength ()]
		public void set_above_child (bool above_child);
		[NoArrayLength ()]
		public void set_visible_window (bool visible_window);
		public weak bool visible_window { get; set; }
		public weak bool above_child { get; set; }
	}
	public class Expander : Gtk.Bin {
		[NoArrayLength ()]
		public bool get_expanded ();
		[NoArrayLength ()]
		public string get_label ();
		[NoArrayLength ()]
		public Gtk.Widget get_label_widget ();
		[NoArrayLength ()]
		public int get_spacing ();
		[NoArrayLength ()]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		public bool get_use_markup ();
		[NoArrayLength ()]
		public bool get_use_underline ();
		[NoArrayLength ()]
		public construct (string label);
		[NoArrayLength ()]
		public construct with_mnemonic (string label);
		[NoArrayLength ()]
		public void set_expanded (bool expanded);
		[NoArrayLength ()]
		public void set_label (string label);
		[NoArrayLength ()]
		public void set_label_widget (Gtk.Widget label_widget);
		[NoArrayLength ()]
		public void set_spacing (int spacing);
		[NoArrayLength ()]
		public void set_use_markup (bool use_markup);
		[NoArrayLength ()]
		public void set_use_underline (bool use_underline);
		public weak bool expanded { get; set construct; }
		public weak string label { get; set construct; }
		public weak bool use_underline { get; set construct; }
		public weak bool use_markup { get; set construct; }
		public weak int spacing { get; set; }
		public weak Gtk.Widget label_widget { get; set; }
		public signal void activate ();
	}
	public class FileChooserButton : Gtk.HBox, Gtk.FileChooser {
		[NoArrayLength ()]
		public bool get_focus_on_click ();
		[NoArrayLength ()]
		public string get_title ();
		[NoArrayLength ()]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		public int get_width_chars ();
		[NoArrayLength ()]
		public construct (string title, Gtk.FileChooserAction action);
		[NoArrayLength ()]
		public construct with_backend (string title, Gtk.FileChooserAction action, string backend);
		[NoArrayLength ()]
		public construct with_dialog (Gtk.Widget dialog);
		[NoArrayLength ()]
		public void set_focus_on_click (bool focus_on_click);
		[NoArrayLength ()]
		public void set_title (string title);
		[NoArrayLength ()]
		public void set_width_chars (int n_chars);
		[NoAccessorMethod ()]
		public weak Gtk.FileChooserDialog dialog { construct; }
		public weak bool focus_on_click { get; set; }
		public weak string title { get; set; }
		public weak int width_chars { get; set; }
	}
	public class FileChooserDialog : Gtk.Dialog, Gtk.FileChooser {
		[NoArrayLength ()]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		public construct (string title, Gtk.Window parent, Gtk.FileChooserAction action, string first_button_text);
		[NoArrayLength ()]
		public construct with_backend (string title, Gtk.Window parent, Gtk.FileChooserAction action, string backend, string first_button_text);
	}
	public class FileChooserWidget : Gtk.VBox, Gtk.FileChooser {
		[NoArrayLength ()]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		public construct (Gtk.FileChooserAction action);
		[NoArrayLength ()]
		public construct with_backend (Gtk.FileChooserAction action, string backend);
	}
	public class FileFilter : Gtk.Object {
		[NoArrayLength ()]
		public void add_custom (Gtk.FileFilterFlags needed, Gtk.FileFilterFunc func, pointer data, GLib.DestroyNotify notify);
		[NoArrayLength ()]
		public void add_mime_type (string mime_type);
		[NoArrayLength ()]
		public void add_pattern (string pattern);
		[NoArrayLength ()]
		public void add_pixbuf_formats ();
		[NoArrayLength ()]
		public bool filter (Gtk.FileFilterInfo filter_info);
		[NoArrayLength ()]
		public string get_name ();
		[NoArrayLength ()]
		public Gtk.FileFilterFlags get_needed ();
		[NoArrayLength ()]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		public construct ();
		[NoArrayLength ()]
		public void set_name (string name);
	}
	public class FileSelection : Gtk.Dialog {
		public weak Gtk.Widget dir_list;
		public weak Gtk.Widget file_list;
		public weak Gtk.Widget selection_entry;
		public weak Gtk.Widget selection_text;
		public weak Gtk.Widget main_vbox;
		public weak Gtk.Widget ok_button;
		public weak Gtk.Widget cancel_button;
		public weak Gtk.Widget help_button;
		public weak Gtk.Widget history_pulldown;
		public weak Gtk.Widget history_menu;
		public weak GLib.List history_list;
		public weak Gtk.Widget fileop_dialog;
		public weak Gtk.Widget fileop_entry;
		public weak string fileop_file;
		public weak pointer cmpl_state;
		public weak Gtk.Widget fileop_c_dir;
		public weak Gtk.Widget fileop_del_file;
		public weak Gtk.Widget fileop_ren_file;
		public weak Gtk.Widget button_area;
		public weak Gtk.Widget action_area;
		[NoArrayLength ()]
		public void complete (string pattern);
		[NoArrayLength ()]
		public string get_filename ();
		[NoArrayLength ()]
		public bool get_select_multiple ();
		[NoArrayLength ()]
		public string get_selections ();
		[NoArrayLength ()]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		public void hide_fileop_buttons ();
		[NoArrayLength ()]
		public construct (string title);
		[NoArrayLength ()]
		public void set_filename (string filename);
		[NoArrayLength ()]
		public void set_select_multiple (bool select_multiple);
		[NoArrayLength ()]
		public void show_fileop_buttons ();
		public weak string filename { get; set; }
		[NoAccessorMethod ()]
		public weak bool show_fileops { get; set; }
		public weak bool select_multiple { get; set; }
	}
	public class Fixed : Gtk.Container {
		[NoArrayLength ()]
		public bool get_has_window ();
		[NoArrayLength ()]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		public void move (Gtk.Widget widget, int x, int y);
		[NoArrayLength ()]
		public construct ();
		[NoArrayLength ()]
		public void put (Gtk.Widget widget, int x, int y);
		[NoArrayLength ()]
		public void set_has_window (bool has_window);
	}
	public class FontButton : Gtk.Button {
		[NoArrayLength ()]
		public string get_font_name ();
		[NoArrayLength ()]
		public bool get_show_size ();
		[NoArrayLength ()]
		public bool get_show_style ();
		[NoArrayLength ()]
		public string get_title ();
		[NoArrayLength ()]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		public bool get_use_font ();
		[NoArrayLength ()]
		public bool get_use_size ();
		[NoArrayLength ()]
		public construct ();
		[NoArrayLength ()]
		public construct with_font (string fontname);
		[NoArrayLength ()]
		public bool set_font_name (string fontname);
		[NoArrayLength ()]
		public void set_show_size (bool show_size);
		[NoArrayLength ()]
		public void set_show_style (bool show_style);
		[NoArrayLength ()]
		public void set_title (string title);
		[NoArrayLength ()]
		public void set_use_font (bool use_font);
		[NoArrayLength ()]
		public void set_use_size (bool use_size);
		public weak string title { get; set; }
		public weak string font_name { get; set; }
		public weak bool use_font { get; set; }
		public weak bool use_size { get; set; }
		public weak bool show_style { get; set; }
		public weak bool show_size { get; set; }
		public signal void font_set ();
	}
	public class FontSelection : Gtk.VBox {
		[NoArrayLength ()]
		public string get_font_name ();
		[NoArrayLength ()]
		public string get_preview_text ();
		[NoArrayLength ()]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		public construct ();
		[NoArrayLength ()]
		public bool set_font_name (string fontname);
		[NoArrayLength ()]
		public void set_preview_text (string text);
		public weak string font_name { get; set; }
		[NoAccessorMethod ()]
		public weak Gdk.Font font { get; }
		public weak string preview_text { get; set; }
	}
	public class FontSelectionDialog : Gtk.Dialog {
		public weak Gtk.Widget ok_button;
		public weak Gtk.Widget apply_button;
		public weak Gtk.Widget cancel_button;
		[NoArrayLength ()]
		public string get_font_name ();
		[NoArrayLength ()]
		public string get_preview_text ();
		[NoArrayLength ()]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		public construct (string title);
		[NoArrayLength ()]
		public bool set_font_name (string fontname);
		[NoArrayLength ()]
		public void set_preview_text (string text);
	}
	public class Frame : Gtk.Bin {
		[NoArrayLength ()]
		public string get_label ();
		[NoArrayLength ()]
		public void get_label_align (float xalign, float yalign);
		[NoArrayLength ()]
		public Gtk.Widget get_label_widget ();
		[NoArrayLength ()]
		public Gtk.ShadowType get_shadow_type ();
		[NoArrayLength ()]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		public construct (string label);
		[NoArrayLength ()]
		public void set_label (string label);
		[NoArrayLength ()]
		public void set_label_align (float xalign, float yalign);
		[NoArrayLength ()]
		public void set_label_widget (Gtk.Widget label_widget);
		[NoArrayLength ()]
		public void set_shadow_type (Gtk.ShadowType type);
		public weak string label { get; set; }
		[NoAccessorMethod ()]
		public weak float label_xalign { get; set; }
		[NoAccessorMethod ()]
		public weak float label_yalign { get; set; }
		[NoAccessorMethod ()]
		public weak Gtk.ShadowType shadow { get; set; }
		public weak Gtk.ShadowType shadow_type { get; set; }
		public weak Gtk.Widget label_widget { get; set; }
	}
	public class GammaCurve : Gtk.VBox {
		[NoArrayLength ()]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		public construct ();
	}
	public class HandleBox : Gtk.Bin {
		[NoArrayLength ()]
		public Gtk.PositionType get_handle_position ();
		[NoArrayLength ()]
		public Gtk.ShadowType get_shadow_type ();
		[NoArrayLength ()]
		public Gtk.PositionType get_snap_edge ();
		[NoArrayLength ()]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		public construct ();
		[NoArrayLength ()]
		public void set_handle_position (Gtk.PositionType position);
		[NoArrayLength ()]
		public void set_shadow_type (Gtk.ShadowType type);
		[NoArrayLength ()]
		public void set_snap_edge (Gtk.PositionType edge);
		[NoAccessorMethod ()]
		public weak Gtk.ShadowType shadow { get; set; }
		public weak Gtk.ShadowType shadow_type { get; set; }
		public weak Gtk.PositionType handle_position { get; set; }
		public weak Gtk.PositionType snap_edge { get; set; }
		[NoAccessorMethod ()]
		public weak bool snap_edge_set { get; set; }
		public signal void child_attached (Gtk.Widget child);
		public signal void child_detached (Gtk.Widget child);
	}
	public class HBox : Gtk.Box {
		[NoArrayLength ()]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		public construct (bool homogeneous, int spacing);
	}
	public class HButtonBox : Gtk.ButtonBox {
		[NoArrayLength ()]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		public construct ();
	}
	public class HPaned : Gtk.Paned {
		[NoArrayLength ()]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		public construct ();
	}
	public class HRuler : Gtk.Ruler {
		[NoArrayLength ()]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		public construct ();
	}
	public class HScale : Gtk.Scale {
		[NoArrayLength ()]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		public construct (Gtk.Adjustment adjustment);
		[NoArrayLength ()]
		public construct with_range (double min, double max, double step);
	}
	public class HScrollbar : Gtk.Scrollbar {
		[NoArrayLength ()]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		public construct (Gtk.Adjustment adjustment);
	}
	public class HSeparator : Gtk.Separator {
		[NoArrayLength ()]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		public construct ();
	}
	public class HSV : Gtk.Widget {
		[NoArrayLength ()]
		public void get_color (double h, double s, double v);
		[NoArrayLength ()]
		public void get_metrics (int size, int ring_width);
		[NoArrayLength ()]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		public bool is_adjusting ();
		[NoArrayLength ()]
		public construct ();
		[NoArrayLength ()]
		public void set_color (double h, double s, double v);
		[NoArrayLength ()]
		public void set_metrics (int size, int ring_width);
		[NoArrayLength ()]
		public static void to_rgb (double h, double s, double v, double r, double g, double b);
		public signal void changed ();
		public signal void move (Gtk.DirectionType type);
	}
	public class IconFactory : GLib.Object {
		[NoArrayLength ()]
		public void add (string stock_id, Gtk.IconSet icon_set);
		[NoArrayLength ()]
		public void add_default ();
		[NoArrayLength ()]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		public Gtk.IconSet lookup (string stock_id);
		[NoArrayLength ()]
		public static Gtk.IconSet lookup_default (string stock_id);
		[NoArrayLength ()]
		public construct ();
		[NoArrayLength ()]
		public void remove_default ();
	}
	public class IconTheme : GLib.Object {
		[NoArrayLength ()]
		public static void add_builtin_icon (string icon_name, int size, Gdk.Pixbuf pixbuf);
		[NoArrayLength ()]
		public void append_search_path (string path);
		[NoArrayLength ()]
		public static GLib.Quark error_quark ();
		[NoArrayLength ()]
		public static Gtk.IconTheme get_default ();
		[NoArrayLength ()]
		public string get_example_icon_name ();
		[NoArrayLength ()]
		public static Gtk.IconTheme get_for_screen (Gdk.Screen screen);
		[NoArrayLength ()]
		public int[] get_icon_sizes (string icon_name);
		[NoArrayLength ()]
		public void get_search_path (string path, int n_elements);
		[NoArrayLength ()]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		public bool has_icon (string icon_name);
		[NoArrayLength ()]
		public GLib.List list_icons (string context);
		[NoArrayLength ()]
		public Gdk.Pixbuf load_icon (string icon_name, int size, Gtk.IconLookupFlags @flags, GLib.Error error);
		[NoArrayLength ()]
		public Gtk.IconInfo lookup_icon (string icon_name, int size, Gtk.IconLookupFlags @flags);
		[NoArrayLength ()]
		public construct ();
		[NoArrayLength ()]
		public void prepend_search_path (string path);
		[NoArrayLength ()]
		public bool rescan_if_needed ();
		[NoArrayLength ()]
		public void set_custom_theme (string theme_name);
		[NoArrayLength ()]
		public void set_screen (Gdk.Screen screen);
		[NoArrayLength ()]
		public void set_search_path (string[] path, int n_elements);
		public signal void changed ();
	}
	public class IconView : Gtk.Container, Gtk.CellLayout {
		[NoArrayLength ()]
		public Gdk.Pixmap create_drag_icon (Gtk.TreePath path);
		[NoArrayLength ()]
		public void enable_model_drag_dest (Gtk.TargetEntry targets, int n_targets, Gdk.DragAction actions);
		[NoArrayLength ()]
		public void enable_model_drag_source (Gdk.ModifierType start_button_mask, Gtk.TargetEntry targets, int n_targets, Gdk.DragAction actions);
		[NoArrayLength ()]
		public int get_column_spacing ();
		[NoArrayLength ()]
		public int get_columns ();
		[NoArrayLength ()]
		public bool get_cursor (Gtk.TreePath path, Gtk.CellRenderer cell);
		[NoArrayLength ()]
		public bool get_dest_item_at_pos (int drag_x, int drag_y, Gtk.TreePath path, Gtk.IconViewDropPosition pos);
		[NoArrayLength ()]
		public void get_drag_dest_item (Gtk.TreePath path, Gtk.IconViewDropPosition pos);
		[NoArrayLength ()]
		public bool get_item_at_pos (int x, int y, Gtk.TreePath path, Gtk.CellRenderer cell);
		[NoArrayLength ()]
		public int get_item_width ();
		[NoArrayLength ()]
		public int get_margin ();
		[NoArrayLength ()]
		public int get_markup_column ();
		[NoArrayLength ()]
		public Gtk.TreeModel get_model ();
		[NoArrayLength ()]
		public Gtk.Orientation get_orientation ();
		[NoArrayLength ()]
		public Gtk.TreePath get_path_at_pos (int x, int y);
		[NoArrayLength ()]
		public int get_pixbuf_column ();
		[NoArrayLength ()]
		public bool get_reorderable ();
		[NoArrayLength ()]
		public int get_row_spacing ();
		[NoArrayLength ()]
		public GLib.List get_selected_items ();
		[NoArrayLength ()]
		public Gtk.SelectionMode get_selection_mode ();
		[NoArrayLength ()]
		public int get_spacing ();
		[NoArrayLength ()]
		public int get_text_column ();
		[NoArrayLength ()]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		public bool get_visible_range (Gtk.TreePath start_path, Gtk.TreePath end_path);
		[NoArrayLength ()]
		public construct ();
		[NoArrayLength ()]
		public construct with_model (Gtk.TreeModel model);
		[NoArrayLength ()]
		public bool path_is_selected (Gtk.TreePath path);
		[NoArrayLength ()]
		public void scroll_to_path (Gtk.TreePath path, bool use_align, float row_align, float col_align);
		[NoArrayLength ()]
		public void select_path (Gtk.TreePath path);
		[NoArrayLength ()]
		public void selected_foreach (Gtk.IconViewForeachFunc func, pointer data);
		[NoArrayLength ()]
		public void set_column_spacing (int column_spacing);
		[NoArrayLength ()]
		public void set_columns (int columns);
		[NoArrayLength ()]
		public void set_cursor (Gtk.TreePath path, Gtk.CellRenderer cell, bool start_editing);
		[NoArrayLength ()]
		public void set_drag_dest_item (Gtk.TreePath path, Gtk.IconViewDropPosition pos);
		[NoArrayLength ()]
		public void set_item_width (int item_width);
		[NoArrayLength ()]
		public void set_margin (int margin);
		[NoArrayLength ()]
		public void set_markup_column (int column);
		[NoArrayLength ()]
		public void set_model (Gtk.TreeModel model);
		[NoArrayLength ()]
		public void set_orientation (Gtk.Orientation orientation);
		[NoArrayLength ()]
		public void set_pixbuf_column (int column);
		[NoArrayLength ()]
		public void set_reorderable (bool reorderable);
		[NoArrayLength ()]
		public void set_row_spacing (int row_spacing);
		[NoArrayLength ()]
		public void set_selection_mode (Gtk.SelectionMode mode);
		[NoArrayLength ()]
		public void set_spacing (int spacing);
		[NoArrayLength ()]
		public void set_text_column (int column);
		[NoArrayLength ()]
		public void unselect_path (Gtk.TreePath path);
		[NoArrayLength ()]
		public void unset_model_drag_dest ();
		[NoArrayLength ()]
		public void unset_model_drag_source ();
		public weak Gtk.SelectionMode selection_mode { get; set; }
		public weak int pixbuf_column { get; set; }
		public weak int text_column { get; set; }
		public weak int markup_column { get; set; }
		public weak Gtk.TreeModel model { get; set; }
		public weak int columns { get; set; }
		public weak int item_width { get; set; }
		public weak int spacing { get; set; }
		public weak int row_spacing { get; set; }
		public weak int column_spacing { get; set; }
		public weak int margin { get; set; }
		public weak Gtk.Orientation orientation { get; set; }
		public weak bool reorderable { get; set; }
		public signal void set_scroll_adjustments (Gtk.Adjustment hadjustment, Gtk.Adjustment vadjustment);
		[HasEmitter ()]
		public signal void item_activated (Gtk.TreePath path);
		public signal void selection_changed ();
		public signal void select_all ();
		public signal void unselect_all ();
		public signal void select_cursor_item ();
		public signal void toggle_cursor_item ();
		public signal bool activate_cursor_item ();
		public signal bool move_cursor (Gtk.MovementStep step, int count);
	}
	public class Image : Gtk.Misc {
		[NoArrayLength ()]
		public void clear ();
		[NoArrayLength ()]
		public Gdk.PixbufAnimation get_animation ();
		[NoArrayLength ()]
		public void get_icon_name (string icon_name, Gtk.IconSize size);
		[NoArrayLength ()]
		public void get_icon_set (Gtk.IconSet icon_set, Gtk.IconSize size);
		[NoArrayLength ()]
		public void get_image (Gdk.Image gdk_image, Gdk.Bitmap mask);
		[NoArrayLength ()]
		public Gdk.Pixbuf get_pixbuf ();
		[NoArrayLength ()]
		public int get_pixel_size ();
		[NoArrayLength ()]
		public void get_pixmap (Gdk.Pixmap pixmap, Gdk.Bitmap mask);
		[NoArrayLength ()]
		public void get_stock (string stock_id, Gtk.IconSize size);
		[NoArrayLength ()]
		public Gtk.ImageType get_storage_type ();
		[NoArrayLength ()]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		public construct ();
		[NoArrayLength ()]
		public construct from_animation (Gdk.PixbufAnimation animation);
		[NoArrayLength ()]
		public construct from_file (string filename);
		[NoArrayLength ()]
		public construct from_icon_name (string icon_name, Gtk.IconSize size);
		[NoArrayLength ()]
		public construct from_icon_set (Gtk.IconSet icon_set, Gtk.IconSize size);
		[NoArrayLength ()]
		public construct from_image (Gdk.Image image, Gdk.Bitmap mask);
		[NoArrayLength ()]
		public construct from_pixbuf (Gdk.Pixbuf pixbuf);
		[NoArrayLength ()]
		public construct from_pixmap (Gdk.Pixmap pixmap, Gdk.Bitmap mask);
		[NoArrayLength ()]
		public construct from_stock (string stock_id, Gtk.IconSize size);
		[NoArrayLength ()]
		public void set_from_animation (Gdk.PixbufAnimation animation);
		[NoArrayLength ()]
		public void set_from_file (string filename);
		[NoArrayLength ()]
		public void set_from_icon_name (string icon_name, Gtk.IconSize size);
		[NoArrayLength ()]
		public void set_from_icon_set (Gtk.IconSet icon_set, Gtk.IconSize size);
		[NoArrayLength ()]
		public void set_from_image (Gdk.Image gdk_image, Gdk.Bitmap mask);
		[NoArrayLength ()]
		public void set_from_pixbuf (Gdk.Pixbuf pixbuf);
		[NoArrayLength ()]
		public void set_from_pixmap (Gdk.Pixmap pixmap, Gdk.Bitmap mask);
		[NoArrayLength ()]
		public void set_from_stock (string stock_id, Gtk.IconSize size);
		[NoArrayLength ()]
		public void set_pixel_size (int pixel_size);
		[NoAccessorMethod ()]
		public weak Gdk.Pixbuf pixbuf { get; set; }
		[NoAccessorMethod ()]
		public weak Gdk.Pixmap pixmap { get; set; }
		[NoAccessorMethod ()]
		public weak Gdk.Image image { get; set; }
		[NoAccessorMethod ()]
		public weak Gdk.Pixmap mask { get; set; }
		[NoAccessorMethod ()]
		public weak string file { get; set; }
		[NoAccessorMethod ()]
		public weak string stock { get; set; }
		[NoAccessorMethod ()]
		public weak Gtk.IconSet icon_set { get; set; }
		[NoAccessorMethod ()]
		public weak int icon_size { get; set; }
		public weak int pixel_size { get; set; }
		[NoAccessorMethod ()]
		public weak Gdk.PixbufAnimation pixbuf_animation { get; set; }
		[NoAccessorMethod ()]
		public weak string icon_name { get; set; }
		public weak Gtk.ImageType storage_type { get; }
	}
	public class ImageMenuItem : Gtk.MenuItem {
		[NoArrayLength ()]
		public Gtk.Widget get_image ();
		[NoArrayLength ()]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		public construct ();
		[NoArrayLength ()]
		public construct from_stock (string stock_id, Gtk.AccelGroup accel_group);
		[NoArrayLength ()]
		public construct with_label (string label);
		[NoArrayLength ()]
		public construct with_mnemonic (string label);
		[NoArrayLength ()]
		public void set_image (Gtk.Widget image);
		public weak Gtk.Widget image { get; set; }
	}
	public class IMContext : GLib.Object {
		[NoArrayLength ()]
		public virtual bool filter_keypress (Gdk.EventKey event);
		[NoArrayLength ()]
		public virtual void focus_in ();
		[NoArrayLength ()]
		public virtual void focus_out ();
		[NoArrayLength ()]
		public virtual void get_preedit_string (string str, Pango.AttrList attrs, int cursor_pos);
		[NoArrayLength ()]
		public virtual bool get_surrounding (string text, int cursor_index);
		[NoArrayLength ()]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		public virtual void reset ();
		[NoArrayLength ()]
		public virtual void set_client_window (Gdk.Window window);
		[NoArrayLength ()]
		public virtual void set_cursor_location (Gdk.Rectangle area);
		[NoArrayLength ()]
		public virtual void set_surrounding (string text, int len, int cursor_index);
		[NoArrayLength ()]
		public virtual void set_use_preedit (bool use_preedit);
		public signal void preedit_start ();
		public signal void preedit_end ();
		public signal void preedit_changed ();
		public signal void commit (string str);
		public signal bool retrieve_surrounding ();
		[HasEmitter ()]
		public signal bool delete_surrounding (int offset, int n_chars);
	}
	public class IMContextSimple : Gtk.IMContext {
		[NoArrayLength ()]
		public void add_table (ushort data, int max_seq_len, int n_seqs);
		[NoArrayLength ()]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		public construct ();
	}
	public class IMMulticontext : Gtk.IMContext {
		[NoArrayLength ()]
		public void append_menuitems (Gtk.MenuShell menushell);
		[NoArrayLength ()]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		public construct ();
	}
	public class InputDialog : Gtk.Dialog {
		[NoArrayLength ()]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		public construct ();
		public signal void enable_device (Gdk.Device device);
		public signal void disable_device (Gdk.Device device);
	}
	public class Invisible : Gtk.Widget {
		[NoArrayLength ()]
		public Gdk.Screen get_screen ();
		[NoArrayLength ()]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		public construct ();
		[NoArrayLength ()]
		public construct for_screen (Gdk.Screen screen);
		[NoArrayLength ()]
		public void set_screen (Gdk.Screen screen);
		public weak Gdk.Screen screen { get; set; }
	}
	public class Item : Gtk.Bin {
		[NoArrayLength ()]
		public static GLib.Type get_type ();
		[HasEmitter ()]
		public signal void select ();
		[HasEmitter ()]
		public signal void deselect ();
		[HasEmitter ()]
		public signal void toggle ();
	}
	public class ItemFactory : Gtk.Object {
	}
	public class Label : Gtk.Misc {
		[NoArrayLength ()]
		public double get_angle ();
		[NoArrayLength ()]
		public Pango.AttrList get_attributes ();
		[NoArrayLength ()]
		public Pango.EllipsizeMode get_ellipsize ();
		[NoArrayLength ()]
		public Gtk.Justification get_justify ();
		[NoArrayLength ()]
		public string get_label ();
		[NoArrayLength ()]
		public Pango.Layout get_layout ();
		[NoArrayLength ()]
		public void get_layout_offsets (int x, int y);
		[NoArrayLength ()]
		public bool get_line_wrap ();
		[NoArrayLength ()]
		public Pango.WrapMode get_line_wrap_mode ();
		[NoArrayLength ()]
		public int get_max_width_chars ();
		[NoArrayLength ()]
		public uint get_mnemonic_keyval ();
		[NoArrayLength ()]
		public Gtk.Widget get_mnemonic_widget ();
		[NoArrayLength ()]
		public bool get_selectable ();
		[NoArrayLength ()]
		public bool get_selection_bounds (int start, int end);
		[NoArrayLength ()]
		public bool get_single_line_mode ();
		[NoArrayLength ()]
		public string get_text ();
		[NoArrayLength ()]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		public bool get_use_markup ();
		[NoArrayLength ()]
		public bool get_use_underline ();
		[NoArrayLength ()]
		public int get_width_chars ();
		[NoArrayLength ()]
		public construct (string str);
		[NoArrayLength ()]
		public construct with_mnemonic (string str);
		[NoArrayLength ()]
		public void select_region (int start_offset, int end_offset);
		[NoArrayLength ()]
		public void set_angle (double angle);
		[NoArrayLength ()]
		public void set_attributes (Pango.AttrList attrs);
		[NoArrayLength ()]
		public void set_ellipsize (Pango.EllipsizeMode mode);
		[NoArrayLength ()]
		public void set_justify (Gtk.Justification jtype);
		[NoArrayLength ()]
		public void set_label (string str);
		[NoArrayLength ()]
		public void set_line_wrap (bool wrap);
		[NoArrayLength ()]
		public void set_line_wrap_mode (Pango.WrapMode wrap_mode);
		[NoArrayLength ()]
		public void set_markup (string str);
		[NoArrayLength ()]
		public void set_markup_with_mnemonic (string str);
		[NoArrayLength ()]
		public void set_max_width_chars (int n_chars);
		[NoArrayLength ()]
		public void set_mnemonic_widget (Gtk.Widget widget);
		[NoArrayLength ()]
		public void set_pattern (string pattern);
		[NoArrayLength ()]
		public void set_selectable (bool setting);
		[NoArrayLength ()]
		public void set_single_line_mode (bool single_line_mode);
		[NoArrayLength ()]
		public void set_text (string str);
		[NoArrayLength ()]
		public void set_text_with_mnemonic (string str);
		[NoArrayLength ()]
		public void set_use_markup (bool setting);
		[NoArrayLength ()]
		public void set_use_underline (bool setting);
		[NoArrayLength ()]
		public void set_width_chars (int n_chars);
		public weak string label { get; set; }
		public weak Pango.AttrList attributes { get; set; }
		public weak bool use_markup { get; set; }
		public weak bool use_underline { get; set; }
		public weak Gtk.Justification justify { get; set; }
		public weak string pattern { set; }
		[NoAccessorMethod ()]
		public weak bool wrap { get; set; }
		[NoAccessorMethod ()]
		public weak Pango.WrapMode wrap_mode { get; set; }
		public weak bool selectable { get; set; }
		public weak uint mnemonic_keyval { get; }
		public weak Gtk.Widget mnemonic_widget { get; set; }
		[NoAccessorMethod ()]
		public weak int cursor_position { get; }
		[NoAccessorMethod ()]
		public weak int selection_bound { get; }
		public weak Pango.EllipsizeMode ellipsize { get; set; }
		public weak int width_chars { get; set; }
		public weak bool single_line_mode { get; set; }
		public weak double angle { get; set; }
		public weak int max_width_chars { get; set; }
		public signal void move_cursor (Gtk.MovementStep step, int count, bool extend_selection);
		public signal void copy_clipboard ();
		public signal void populate_popup (Gtk.Menu menu);
	}
	public class Layout : Gtk.Container {
		public weak Gdk.Window bin_window;
		[NoArrayLength ()]
		public Gtk.Adjustment get_hadjustment ();
		[NoArrayLength ()]
		public void get_size (uint width, uint height);
		[NoArrayLength ()]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		public Gtk.Adjustment get_vadjustment ();
		[NoArrayLength ()]
		public void move (Gtk.Widget child_widget, int x, int y);
		[NoArrayLength ()]
		public construct (Gtk.Adjustment hadjustment, Gtk.Adjustment vadjustment);
		[NoArrayLength ()]
		public void put (Gtk.Widget child_widget, int x, int y);
		[NoArrayLength ()]
		public void set_hadjustment (Gtk.Adjustment adjustment);
		[NoArrayLength ()]
		public void set_size (uint width, uint height);
		[NoArrayLength ()]
		public void set_vadjustment (Gtk.Adjustment adjustment);
		public weak Gtk.Adjustment hadjustment { get; set; }
		public weak Gtk.Adjustment vadjustment { get; set; }
		[NoAccessorMethod ()]
		public weak uint width { get; set; }
		[NoAccessorMethod ()]
		public weak uint height { get; set; }
		public signal void set_scroll_adjustments (Gtk.Adjustment hadjustment, Gtk.Adjustment vadjustment);
	}
	public class LinkButton : Gtk.Button {
		[NoArrayLength ()]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		public string get_uri ();
		[NoArrayLength ()]
		public construct (string uri);
		[NoArrayLength ()]
		public construct with_label (string uri, string label);
		[NoArrayLength ()]
		public void set_uri (string uri);
		[NoArrayLength ()]
		public static Gtk.LinkButtonUriFunc set_uri_hook (Gtk.LinkButtonUriFunc func, pointer data, GLib.DestroyNotify destroy);
		public weak string uri { get; set; }
	}
	public class ListStore : GLib.Object, Gtk.TreeModel, Gtk.TreeDragSource, Gtk.TreeDragDest, Gtk.TreeSortable {
		[NoArrayLength ()]
		public void append (Gtk.TreeIter iter);
		[NoArrayLength ()]
		public void clear ();
		[NoArrayLength ()]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		public void insert (Gtk.TreeIter iter, int position);
		[NoArrayLength ()]
		public void insert_after (Gtk.TreeIter iter, Gtk.TreeIter sibling);
		[NoArrayLength ()]
		public void insert_before (Gtk.TreeIter iter, Gtk.TreeIter sibling);
		[NoArrayLength ()]
		public void insert_with_values (Gtk.TreeIter iter, int position, ...);
		[NoArrayLength ()]
		public void insert_with_valuesv (Gtk.TreeIter iter, int position, int columns, GLib.Value values, int n_values);
		[NoArrayLength ()]
		public bool iter_is_valid (Gtk.TreeIter iter);
		[NoArrayLength ()]
		public void move_after (Gtk.TreeIter iter, Gtk.TreeIter position);
		[NoArrayLength ()]
		public void move_before (Gtk.TreeIter iter, Gtk.TreeIter position);
		[NoArrayLength ()]
		public construct (int n_columns, ...);
		[NoArrayLength ()]
		public construct newv (int n_columns, GLib.Type types);
		[NoArrayLength ()]
		public void prepend (Gtk.TreeIter iter);
		[NoArrayLength ()]
		public bool remove (Gtk.TreeIter iter);
		[NoArrayLength ()]
		public void reorder (int new_order);
		[NoArrayLength ()]
		public void @set (Gtk.TreeIter iter);
		[NoArrayLength ()]
		public void set_column_types (int n_columns, GLib.Type types);
		[NoArrayLength ()]
		public void set_valist (Gtk.TreeIter iter, pointer var_args);
		[NoArrayLength ()]
		public void set_value (Gtk.TreeIter iter, int column, GLib.Value value);
		[NoArrayLength ()]
		public void swap (Gtk.TreeIter a, Gtk.TreeIter b);
	}
	public class Menu : Gtk.MenuShell {
		[NoArrayLength ()]
		public void attach (Gtk.Widget child, uint left_attach, uint right_attach, uint top_attach, uint bottom_attach);
		[NoArrayLength ()]
		public void attach_to_widget (Gtk.Widget attach_widget, Gtk.MenuDetachFunc detacher);
		[NoArrayLength ()]
		public void detach ();
		[NoArrayLength ()]
		public Gtk.AccelGroup get_accel_group ();
		[NoArrayLength ()]
		public Gtk.Widget get_active ();
		[NoArrayLength ()]
		public Gtk.Widget get_attach_widget ();
		[NoArrayLength ()]
		public static GLib.List get_for_attach_widget (Gtk.Widget widget);
		[NoArrayLength ()]
		public bool get_tearoff_state ();
		[NoArrayLength ()]
		public string get_title ();
		[NoArrayLength ()]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		public construct ();
		[NoArrayLength ()]
		public void popdown ();
		[NoArrayLength ()]
		public void popup (Gtk.Widget parent_menu_shell, Gtk.Widget parent_menu_item, Gtk.MenuPositionFunc func, pointer data, uint button, uint activate_time);
		[NoArrayLength ()]
		public void reorder_child (Gtk.Widget child, int position);
		[NoArrayLength ()]
		public void reposition ();
		[NoArrayLength ()]
		public void set_accel_group (Gtk.AccelGroup accel_group);
		[NoArrayLength ()]
		public void set_accel_path (string accel_path);
		[NoArrayLength ()]
		public void set_active (uint index_);
		[NoArrayLength ()]
		public void set_monitor (int monitor_num);
		[NoArrayLength ()]
		public void set_screen (Gdk.Screen screen);
		[NoArrayLength ()]
		public void set_tearoff_state (bool torn_off);
		[NoArrayLength ()]
		public void set_title (string title);
		[NoAccessorMethod ()]
		public weak string tearoff_title { get; set; }
		public weak bool tearoff_state { get; set; }
	}
	public class MenuBar : Gtk.MenuShell {
		[NoArrayLength ()]
		public Gtk.PackDirection get_child_pack_direction ();
		[NoArrayLength ()]
		public Gtk.PackDirection get_pack_direction ();
		[NoArrayLength ()]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		public construct ();
		[NoArrayLength ()]
		public void set_child_pack_direction (Gtk.PackDirection child_pack_dir);
		[NoArrayLength ()]
		public void set_pack_direction (Gtk.PackDirection pack_dir);
		public weak Gtk.PackDirection pack_direction { get; set; }
		public weak Gtk.PackDirection child_pack_direction { get; set; }
	}
	public class MenuItem : Gtk.Item {
		[NoArrayLength ()]
		public void deselect ();
		[NoArrayLength ()]
		public bool get_right_justified ();
		[NoArrayLength ()]
		public Gtk.Widget get_submenu ();
		[NoArrayLength ()]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		public construct ();
		[NoArrayLength ()]
		public construct with_label (string label);
		[NoArrayLength ()]
		public construct with_mnemonic (string label);
		[NoArrayLength ()]
		public void remove_submenu ();
		[NoArrayLength ()]
		public void select ();
		[NoArrayLength ()]
		public void set_accel_path (string accel_path);
		[NoArrayLength ()]
		public void set_right_justified (bool right_justified);
		[NoArrayLength ()]
		public void set_submenu (Gtk.Widget submenu);
		[HasEmitter ()]
		public signal void activate ();
		public signal void activate_item ();
		[HasEmitter ()]
		public signal void toggle_size_request (int requisition);
		[HasEmitter ()]
		public signal void toggle_size_allocate (int allocation);
	}
	public class MenuShell : Gtk.Container {
		[NoArrayLength ()]
		public void activate_item (Gtk.Widget menu_item, bool force_deactivate);
		[NoArrayLength ()]
		public void append (Gtk.Widget child);
		[NoArrayLength ()]
		public void deselect ();
		[NoArrayLength ()]
		public bool get_take_focus ();
		[NoArrayLength ()]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		public virtual void insert (Gtk.Widget child, int position);
		[NoArrayLength ()]
		public void prepend (Gtk.Widget child);
		[NoArrayLength ()]
		public void select_first (bool search_sensitive);
		[NoArrayLength ()]
		public virtual void select_item (Gtk.Widget menu_item);
		[NoArrayLength ()]
		public void set_take_focus (bool take_focus);
		public weak bool take_focus { get; set; }
		[HasEmitter ()]
		public signal void deactivate ();
		public signal void selection_done ();
		public signal void move_current (Gtk.MenuDirectionType direction);
		public signal void activate_current (bool force_hide);
		[HasEmitter ()]
		public signal void cancel ();
	}
	public class MenuToolButton : Gtk.ToolButton {
		[NoArrayLength ()]
		public Gtk.Widget get_menu ();
		[NoArrayLength ()]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		public construct (Gtk.Widget icon_widget, string label);
		[NoArrayLength ()]
		public construct from_stock (string stock_id);
		[NoArrayLength ()]
		public void set_arrow_tooltip (Gtk.Tooltips tooltips, string tip_text, string tip_private);
		[NoArrayLength ()]
		public void set_menu (Gtk.Widget menu);
		public weak Gtk.Menu menu { get; set; }
		public signal void show_menu ();
	}
	public class MessageDialog : Gtk.Dialog {
		[NoArrayLength ()]
		public void format_secondary_markup (string message_format);
		[NoArrayLength ()]
		public void format_secondary_text (string message_format);
		[NoArrayLength ()]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		public construct (Gtk.Window parent, Gtk.DialogFlags @flags, Gtk.MessageType type, Gtk.ButtonsType buttons, string message_format);
		[NoArrayLength ()]
		public construct with_markup (Gtk.Window parent, Gtk.DialogFlags @flags, Gtk.MessageType type, Gtk.ButtonsType buttons, string message_format);
		[NoArrayLength ()]
		public void set_image (Gtk.Widget image);
		[NoArrayLength ()]
		public void set_markup (string str);
		[NoAccessorMethod ()]
		public weak Gtk.MessageType message_type { get; set construct; }
		[NoAccessorMethod ()]
		public weak Gtk.ButtonsType buttons { construct; }
		[NoAccessorMethod ()]
		public weak string text { get; set; }
		[NoAccessorMethod ()]
		public weak bool use_markup { get; set; }
		[NoAccessorMethod ()]
		public weak string secondary_text { get; set; }
		[NoAccessorMethod ()]
		public weak bool secondary_use_markup { get; set; }
		[NoAccessorMethod ()]
		public weak Gtk.Widget image { get; set; }
	}
	public class Misc : Gtk.Widget {
		[NoArrayLength ()]
		public void get_alignment (float xalign, float yalign);
		[NoArrayLength ()]
		public void get_padding (int xpad, int ypad);
		[NoArrayLength ()]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		public void set_alignment (float xalign, float yalign);
		[NoArrayLength ()]
		public void set_padding (int xpad, int ypad);
		[NoAccessorMethod ()]
		public weak float xalign { get; set; }
		[NoAccessorMethod ()]
		public weak float yalign { get; set; }
		[NoAccessorMethod ()]
		public weak int xpad { get; set; }
		[NoAccessorMethod ()]
		public weak int ypad { get; set; }
	}
	public class Notebook : Gtk.Container {
		[NoArrayLength ()]
		public int append_page (Gtk.Widget child, Gtk.Widget tab_label);
		[NoArrayLength ()]
		public int append_page_menu (Gtk.Widget child, Gtk.Widget tab_label, Gtk.Widget menu_label);
		[NoArrayLength ()]
		public int get_current_page ();
		[NoArrayLength ()]
		public int get_group_id ();
		[NoArrayLength ()]
		public Gtk.Widget get_menu_label (Gtk.Widget child);
		[NoArrayLength ()]
		public string get_menu_label_text (Gtk.Widget child);
		[NoArrayLength ()]
		public int get_n_pages ();
		[NoArrayLength ()]
		public Gtk.Widget get_nth_page (int page_num);
		[NoArrayLength ()]
		public bool get_scrollable ();
		[NoArrayLength ()]
		public bool get_show_border ();
		[NoArrayLength ()]
		public bool get_show_tabs ();
		[NoArrayLength ()]
		public bool get_tab_detachable (Gtk.Widget child);
		[NoArrayLength ()]
		public Gtk.Widget get_tab_label (Gtk.Widget child);
		[NoArrayLength ()]
		public string get_tab_label_text (Gtk.Widget child);
		[NoArrayLength ()]
		public Gtk.PositionType get_tab_pos ();
		[NoArrayLength ()]
		public bool get_tab_reorderable (Gtk.Widget child);
		[NoArrayLength ()]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		public virtual int insert_page (Gtk.Widget child, Gtk.Widget tab_label, int position);
		[NoArrayLength ()]
		public int insert_page_menu (Gtk.Widget child, Gtk.Widget tab_label, Gtk.Widget menu_label, int position);
		[NoArrayLength ()]
		public construct ();
		[NoArrayLength ()]
		public void next_page ();
		[NoArrayLength ()]
		public void popup_disable ();
		[NoArrayLength ()]
		public void popup_enable ();
		[NoArrayLength ()]
		public int prepend_page (Gtk.Widget child, Gtk.Widget tab_label);
		[NoArrayLength ()]
		public int prepend_page_menu (Gtk.Widget child, Gtk.Widget tab_label, Gtk.Widget menu_label);
		[NoArrayLength ()]
		public void prev_page ();
		[NoArrayLength ()]
		public void query_tab_label_packing (Gtk.Widget child, bool expand, bool fill, Gtk.PackType pack_type);
		[NoArrayLength ()]
		public void remove_page (int page_num);
		[NoArrayLength ()]
		public void reorder_child (Gtk.Widget child, int position);
		[NoArrayLength ()]
		public void set_current_page (int page_num);
		[NoArrayLength ()]
		public void set_group_id (int group_id);
		[NoArrayLength ()]
		public void set_menu_label (Gtk.Widget child, Gtk.Widget menu_label);
		[NoArrayLength ()]
		public void set_menu_label_text (Gtk.Widget child, string menu_text);
		[NoArrayLength ()]
		public void set_scrollable (bool scrollable);
		[NoArrayLength ()]
		public void set_show_border (bool show_border);
		[NoArrayLength ()]
		public void set_show_tabs (bool show_tabs);
		[NoArrayLength ()]
		public void set_tab_detachable (Gtk.Widget child, bool detachable);
		[NoArrayLength ()]
		public void set_tab_label (Gtk.Widget child, Gtk.Widget tab_label);
		[NoArrayLength ()]
		public void set_tab_label_packing (Gtk.Widget child, bool expand, bool fill, Gtk.PackType pack_type);
		[NoArrayLength ()]
		public void set_tab_label_text (Gtk.Widget child, string tab_text);
		[NoArrayLength ()]
		public void set_tab_pos (Gtk.PositionType pos);
		[NoArrayLength ()]
		public void set_tab_reorderable (Gtk.Widget child, bool reorderable);
		[NoArrayLength ()]
		public static void set_window_creation_hook (Gtk.NotebookWindowCreationFunc func, pointer data, GLib.DestroyNotify destroy);
		[NoAccessorMethod ()]
		public weak int page { get; set; }
		public weak Gtk.PositionType tab_pos { get; set; }
		[NoAccessorMethod ()]
		public weak uint tab_border { set; }
		[NoAccessorMethod ()]
		public weak uint tab_hborder { get; set; }
		[NoAccessorMethod ()]
		public weak uint tab_vborder { get; set; }
		public weak bool show_tabs { get; set; }
		public weak bool show_border { get; set; }
		public weak bool scrollable { get; set; }
		[NoAccessorMethod ()]
		public weak bool enable_popup { get; set; }
		[NoAccessorMethod ()]
		public weak bool homogeneous { get; set; }
		public weak int group_id { get; set; }
		public signal void switch_page (Gtk.NotebookPage page, uint page_num);
		public signal bool focus_tab (Gtk.NotebookTab type);
		public signal bool select_page (bool move_focus);
		public signal void change_current_page (int offset);
		public signal void move_focus_out (Gtk.DirectionType direction);
		public signal void reorder_tab (Gtk.DirectionType direction, bool move_to_last);
		public signal void page_reordered (Gtk.Widget p0, uint p1);
		public signal void page_removed (Gtk.Widget p0, uint p1);
		public signal void page_added (Gtk.Widget p0, uint p1);
	}
	public class Object : GLib.InitiallyUnowned {
		[NoArrayLength ()]
		public static Gtk.Type get_type ();
		[NoAccessorMethod ()]
		public weak pointer user_data { get; set; }
		public signal void destroy ();
	}
	public class OptionMenu : Gtk.Button {
		[NoAccessorMethod ()]
		public weak Gtk.Menu menu { get; set; }
		public signal void changed ();
	}
	public class PageSetup : GLib.Object {
		[NoArrayLength ()]
		public Gtk.PageSetup copy ();
		[NoArrayLength ()]
		public double get_bottom_margin (Gtk.Unit unit);
		[NoArrayLength ()]
		public double get_left_margin (Gtk.Unit unit);
		[NoArrayLength ()]
		public Gtk.PageOrientation get_orientation ();
		[NoArrayLength ()]
		public double get_page_height (Gtk.Unit unit);
		[NoArrayLength ()]
		public double get_page_width (Gtk.Unit unit);
		[NoArrayLength ()]
		public double get_paper_height (Gtk.Unit unit);
		[NoArrayLength ()]
		public Gtk.PaperSize get_paper_size ();
		[NoArrayLength ()]
		public double get_paper_width (Gtk.Unit unit);
		[NoArrayLength ()]
		public double get_right_margin (Gtk.Unit unit);
		[NoArrayLength ()]
		public double get_top_margin (Gtk.Unit unit);
		[NoArrayLength ()]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		public construct ();
		[NoArrayLength ()]
		public void set_bottom_margin (double margin, Gtk.Unit unit);
		[NoArrayLength ()]
		public void set_left_margin (double margin, Gtk.Unit unit);
		[NoArrayLength ()]
		public void set_orientation (Gtk.PageOrientation orientation);
		[NoArrayLength ()]
		public void set_paper_size (Gtk.PaperSize size);
		[NoArrayLength ()]
		public void set_paper_size_and_default_margins (Gtk.PaperSize size);
		[NoArrayLength ()]
		public void set_right_margin (double margin, Gtk.Unit unit);
		[NoArrayLength ()]
		public void set_top_margin (double margin, Gtk.Unit unit);
	}
	public class PageSetupUnixDialog : Gtk.Dialog {
		[NoArrayLength ()]
		public Gtk.PageSetup get_page_setup ();
		[NoArrayLength ()]
		public Gtk.PrintSettings get_print_settings ();
		[NoArrayLength ()]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		public construct (string title, Gtk.Window parent);
		[NoArrayLength ()]
		public void set_page_setup (Gtk.PageSetup page_setup);
		[NoArrayLength ()]
		public void set_print_settings (Gtk.PrintSettings print_settings);
	}
	public class Paned : Gtk.Container {
		[NoArrayLength ()]
		public void add1 (Gtk.Widget child);
		[NoArrayLength ()]
		public void add2 (Gtk.Widget child);
		[NoArrayLength ()]
		public Gtk.Widget get_child1 ();
		[NoArrayLength ()]
		public Gtk.Widget get_child2 ();
		[NoArrayLength ()]
		public int get_position ();
		[NoArrayLength ()]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		public void pack1 (Gtk.Widget child, bool resize, bool shrink);
		[NoArrayLength ()]
		public void pack2 (Gtk.Widget child, bool resize, bool shrink);
		[NoArrayLength ()]
		public void set_position (int position);
		public weak int position { get; set; }
		[NoAccessorMethod ()]
		public weak bool position_set { get; set; }
		[NoAccessorMethod ()]
		public weak int min_position { get; }
		[NoAccessorMethod ()]
		public weak int max_position { get; }
		public signal bool cycle_child_focus (bool reverse);
		public signal bool toggle_handle_focus ();
		public signal bool move_handle (Gtk.ScrollType scroll);
		public signal bool cycle_handle_focus (bool reverse);
		public signal bool accept_position ();
		public signal bool cancel_position ();
	}
	public class Plug : Gtk.Window {
		[NoArrayLength ()]
		public void @construct (pointer socket_id);
		[NoArrayLength ()]
		public void construct_for_display (Gdk.Display display, pointer socket_id);
		[NoArrayLength ()]
		public pointer get_id ();
		[NoArrayLength ()]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		public construct (pointer socket_id);
		[NoArrayLength ()]
		public construct for_display (Gdk.Display display, pointer socket_id);
		public signal void embedded ();
	}
	public class Printer : GLib.Object {
		[NoArrayLength ()]
		public int compare (Gtk.Printer b);
		[NoArrayLength ()]
		public Gtk.PrintBackend get_backend ();
		[NoArrayLength ()]
		public string get_description ();
		[NoArrayLength ()]
		public string get_icon_name ();
		[NoArrayLength ()]
		public int get_job_count ();
		[NoArrayLength ()]
		public string get_location ();
		[NoArrayLength ()]
		public string get_name ();
		[NoArrayLength ()]
		public string get_state_message ();
		[NoArrayLength ()]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		public bool is_active ();
		[NoArrayLength ()]
		public bool is_default ();
		[NoArrayLength ()]
		public bool is_new ();
		[NoArrayLength ()]
		public construct (string name, Gtk.PrintBackend backend, bool virtual_);
		[NoArrayLength ()]
		public bool set_description (string description);
		[NoArrayLength ()]
		public void set_has_details (bool val);
		[NoArrayLength ()]
		public void set_icon_name (string icon);
		[NoArrayLength ()]
		public void set_is_active (bool active);
		[NoArrayLength ()]
		public void set_is_default (bool val);
		[NoArrayLength ()]
		public void set_is_new (bool val);
		[NoArrayLength ()]
		public bool set_job_count (int count);
		[NoArrayLength ()]
		public bool set_location (string location);
		[NoArrayLength ()]
		public bool set_state_message (string message);
		[NoAccessorMethod ()]
		public weak string name { get; construct; }
		[NoAccessorMethod ()]
		public weak Gtk.PrintBackend backend { get; construct; }
		[NoAccessorMethod ()]
		public weak bool is_virtual { get; construct; }
		[NoAccessorMethod ()]
		public weak bool accepts_pdf { get; construct; }
		[NoAccessorMethod ()]
		public weak bool accepts_ps { get; construct; }
		public weak string state_message { get; }
		public weak string location { get; }
		public weak string icon_name { get; }
		public weak int job_count { get; }
		public signal void details_acquired (bool success);
	}
	public class PrinterOption : GLib.Object {
		[NoArrayLength ()]
		public void allocate_choices (int num);
		[NoArrayLength ()]
		public void choices_from_array (int num_choices, string[] choices, string[] choices_display);
		[NoArrayLength ()]
		public void clear_has_conflict ();
		[NoArrayLength ()]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		public bool has_choice (string choice);
		[NoArrayLength ()]
		public construct (string name, string display_text, Gtk.PrinterOptionType type);
		[NoArrayLength ()]
		public void @set (string value);
		public signal void changed ();
	}
	public class PrinterOptionSet : GLib.Object {
		[NoArrayLength ()]
		public void add (Gtk.PrinterOption option);
		[NoArrayLength ()]
		public static void boolean (Gtk.PrinterOption option, bool value);
		[NoArrayLength ()]
		public void clear_conflicts ();
		[NoArrayLength ()]
		public void @foreach (Gtk.PrinterOptionSetFunc func, pointer user_data);
		[NoArrayLength ()]
		public void foreach_in_group (string group, Gtk.PrinterOptionSetFunc func, pointer user_data);
		[NoArrayLength ()]
		public GLib.List get_groups ();
		[NoArrayLength ()]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		public static void has_conflict (Gtk.PrinterOption option, bool has_conflict);
		[NoArrayLength ()]
		public Gtk.PrinterOption lookup (string name);
		[NoArrayLength ()]
		public construct ();
		[NoArrayLength ()]
		public void remove (Gtk.PrinterOption option);
		public signal void changed ();
	}
	public class PrinterOptionWidget : Gtk.HBox {
		[NoArrayLength ()]
		public Gtk.Widget get_external_label ();
		[NoArrayLength ()]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		public string get_value ();
		[NoArrayLength ()]
		public bool has_external_label ();
		[NoArrayLength ()]
		public construct (Gtk.PrinterOption source);
		[NoArrayLength ()]
		public void set_source (Gtk.PrinterOption source);
		[NoAccessorMethod ()]
		public weak Gtk.PrinterOption source { get; set construct; }
		public signal void changed ();
	}
	public class PrintBackend : GLib.Object {
		[NoArrayLength ()]
		public void add_printer (Gtk.Printer printer);
		[NoArrayLength ()]
		public void destroy ();
		[NoArrayLength ()]
		public static GLib.Quark error_quark ();
		[NoArrayLength ()]
		public Gtk.Printer find_printer (string printer_name);
		[NoArrayLength ()]
		public GLib.List get_printer_list ();
		[NoArrayLength ()]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		public static GLib.List load_modules ();
		[NoArrayLength ()]
		public virtual void print_stream (Gtk.PrintJob job, GLib.IOChannel data_io, Gtk.PrintJobCompleteFunc @callback, pointer user_data, GLib.DestroyNotify dnotify);
		[NoArrayLength ()]
		public bool printer_list_is_done ();
		[NoArrayLength ()]
		public void remove_printer (Gtk.Printer printer);
		[NoArrayLength ()]
		public void set_list_done ();
		public signal void printer_list_changed ();
		public signal void printer_list_done ();
		public signal void printer_added (Gtk.Printer printer);
		public signal void printer_removed (Gtk.Printer printer);
		public signal void printer_status_changed (Gtk.Printer printer);
	}
	public class PrintContext : GLib.Object {
		[NoArrayLength ()]
		public Pango.Context create_pango_context ();
		[NoArrayLength ()]
		public Pango.Layout create_pango_layout ();
		[NoArrayLength ()]
		public Cairo.Context get_cairo_context ();
		[NoArrayLength ()]
		public double get_dpi_x ();
		[NoArrayLength ()]
		public double get_dpi_y ();
		[NoArrayLength ()]
		public double get_height ();
		[NoArrayLength ()]
		public Gtk.PageSetup get_page_setup ();
		[NoArrayLength ()]
		public Pango.FontMap get_pango_fontmap ();
		[NoArrayLength ()]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		public double get_width ();
		[NoArrayLength ()]
		public void set_cairo_context (Cairo.Context cr, double dpi_x, double dpi_y);
	}
	public class PrintJob : GLib.Object {
		[NoArrayLength ()]
		public Gtk.Printer get_printer ();
		[NoArrayLength ()]
		public Gtk.PrintSettings get_settings ();
		[NoArrayLength ()]
		public Gtk.PrintStatus get_status ();
		[NoArrayLength ()]
		public Cairo.Surface get_surface (GLib.Error error);
		[NoArrayLength ()]
		public string get_title ();
		[NoArrayLength ()]
		public bool get_track_print_status ();
		[NoArrayLength ()]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		public construct (string title, Gtk.Printer printer, Gtk.PrintSettings settings, Gtk.PageSetup page_setup);
		[NoArrayLength ()]
		public void send (Gtk.PrintJobCompleteFunc @callback, pointer user_data, GLib.DestroyNotify dnotify);
		[NoArrayLength ()]
		public bool set_source_file (string filename, GLib.Error error);
		[NoArrayLength ()]
		public void set_track_print_status (bool track_status);
		[NoAccessorMethod ()]
		public weak string title { get; construct; }
		[NoAccessorMethod ()]
		public weak Gtk.Printer printer { get; construct; }
		[NoAccessorMethod ()]
		public weak Gtk.PrintSettings settings { get; construct; }
		[NoAccessorMethod ()]
		public weak Gtk.PageSetup page_setup { get; construct; }
		public weak bool track_print_status { get; set; }
		public signal void status_changed ();
	}
	public class PrintOperation : GLib.Object, Gtk.PrintOperationPreview {
		[NoArrayLength ()]
		public void cancel ();
		[NoArrayLength ()]
		public Gtk.PageSetup get_default_page_setup ();
		[NoArrayLength ()]
		public void get_error (GLib.Error error);
		[NoArrayLength ()]
		public Gtk.PrintSettings get_print_settings ();
		[NoArrayLength ()]
		public Gtk.PrintStatus get_status ();
		[NoArrayLength ()]
		public string get_status_string ();
		[NoArrayLength ()]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		public bool is_finished ();
		[NoArrayLength ()]
		public construct ();
		[NoArrayLength ()]
		public Gtk.PrintOperationResult run (Gtk.PrintOperationAction action, Gtk.Window parent, GLib.Error error);
		[NoArrayLength ()]
		public void set_allow_async (bool allow_async);
		[NoArrayLength ()]
		public void set_current_page (int current_page);
		[NoArrayLength ()]
		public void set_custom_tab_label (string label);
		[NoArrayLength ()]
		public void set_default_page_setup (Gtk.PageSetup default_page_setup);
		[NoArrayLength ()]
		public void set_export_filename (string filename);
		[NoArrayLength ()]
		public void set_job_name (string job_name);
		[NoArrayLength ()]
		public void set_n_pages (int n_pages);
		[NoArrayLength ()]
		public void set_print_settings (Gtk.PrintSettings print_settings);
		[NoArrayLength ()]
		public void set_show_progress (bool show_progress);
		[NoArrayLength ()]
		public void set_track_print_status (bool track_status);
		[NoArrayLength ()]
		public void set_unit (Gtk.Unit unit);
		[NoArrayLength ()]
		public void set_use_full_page (bool full_page);
		public weak Gtk.PageSetup default_page_setup { get; set; }
		public weak Gtk.PrintSettings print_settings { get; set; }
		[NoAccessorMethod ()]
		public weak string job_name { get; set; }
		[NoAccessorMethod ()]
		public weak int n_pages { get; set; }
		[NoAccessorMethod ()]
		public weak int current_page { get; set; }
		[NoAccessorMethod ()]
		public weak bool use_full_page { get; set; }
		[NoAccessorMethod ()]
		public weak bool track_print_status { get; set; }
		[NoAccessorMethod ()]
		public weak Gtk.Unit unit { get; set; }
		[NoAccessorMethod ()]
		public weak bool show_progress { get; set; }
		[NoAccessorMethod ()]
		public weak bool allow_async { get; set; }
		[NoAccessorMethod ()]
		public weak string export_filename { get; set; }
		public weak Gtk.PrintStatus status { get; }
		public weak string status_string { get; }
		[NoAccessorMethod ()]
		public weak string custom_tab_label { get; set; }
		public signal void done (Gtk.PrintOperationResult result);
		public signal void begin_print (Gtk.PrintContext context);
		public signal bool paginate (Gtk.PrintContext context);
		public signal void request_page_setup (Gtk.PrintContext context, int page_nr, Gtk.PageSetup setup);
		public signal void draw_page (Gtk.PrintContext context, int page_nr);
		public signal void end_print (Gtk.PrintContext context);
		public signal void status_changed ();
		public signal Gtk.Widget create_custom_widget ();
		public signal void custom_widget_apply (Gtk.Widget widget);
		public signal bool preview (Gtk.PrintOperationPreview preview, Gtk.PrintContext context, Gtk.Window parent);
	}
	public class PrintSettings : GLib.Object {
		[NoArrayLength ()]
		public Gtk.PrintSettings copy ();
		[NoArrayLength ()]
		public void @foreach (Gtk.PrintSettingsFunc func, pointer user_data);
		[NoArrayLength ()]
		public string @get (string key);
		[NoArrayLength ()]
		public bool get_bool (string key);
		[NoArrayLength ()]
		public bool get_collate ();
		[NoArrayLength ()]
		public string get_default_source ();
		[NoArrayLength ()]
		public string get_dither ();
		[NoArrayLength ()]
		public double get_double (string key);
		[NoArrayLength ()]
		public double get_double_with_default (string key, double def);
		[NoArrayLength ()]
		public Gtk.PrintDuplex get_duplex ();
		[NoArrayLength ()]
		public string get_finishings ();
		[NoArrayLength ()]
		public int get_int (string key);
		[NoArrayLength ()]
		public int get_int_with_default (string key, int def);
		[NoArrayLength ()]
		public double get_length (string key, Gtk.Unit unit);
		[NoArrayLength ()]
		public string get_media_type ();
		[NoArrayLength ()]
		public int get_n_copies ();
		[NoArrayLength ()]
		public int get_number_up ();
		[NoArrayLength ()]
		public Gtk.PageOrientation get_orientation ();
		[NoArrayLength ()]
		public string get_output_bin ();
		[NoArrayLength ()]
		public Gtk.PageRange get_page_ranges (int num_ranges);
		[NoArrayLength ()]
		public Gtk.PageSet get_page_set ();
		[NoArrayLength ()]
		public double get_paper_height (Gtk.Unit unit);
		[NoArrayLength ()]
		public Gtk.PaperSize get_paper_size ();
		[NoArrayLength ()]
		public double get_paper_width (Gtk.Unit unit);
		[NoArrayLength ()]
		public Gtk.PrintPages get_print_pages ();
		[NoArrayLength ()]
		public string get_printer ();
		[NoArrayLength ()]
		public Gtk.PrintQuality get_quality ();
		[NoArrayLength ()]
		public int get_resolution ();
		[NoArrayLength ()]
		public bool get_reverse ();
		[NoArrayLength ()]
		public double get_scale ();
		[NoArrayLength ()]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		public bool get_use_color ();
		[NoArrayLength ()]
		public bool has_key (string key);
		[NoArrayLength ()]
		public construct ();
		[NoArrayLength ()]
		public void @set (string key, string value);
		[NoArrayLength ()]
		public void set_bool (string key, bool value);
		[NoArrayLength ()]
		public void set_collate (bool collate);
		[NoArrayLength ()]
		public void set_default_source (string default_source);
		[NoArrayLength ()]
		public void set_dither (string dither);
		[NoArrayLength ()]
		public void set_double (string key, double value);
		[NoArrayLength ()]
		public void set_duplex (Gtk.PrintDuplex duplex);
		[NoArrayLength ()]
		public void set_finishings (string finishings);
		[NoArrayLength ()]
		public void set_int (string key, int value);
		[NoArrayLength ()]
		public void set_length (string key, double value, Gtk.Unit unit);
		[NoArrayLength ()]
		public void set_media_type (string media_type);
		[NoArrayLength ()]
		public void set_n_copies (int num_copies);
		[NoArrayLength ()]
		public void set_number_up (int number_up);
		[NoArrayLength ()]
		public void set_orientation (Gtk.PageOrientation orientation);
		[NoArrayLength ()]
		public void set_output_bin (string output_bin);
		[NoArrayLength ()]
		public void set_page_ranges (Gtk.PageRange page_ranges, int num_ranges);
		[NoArrayLength ()]
		public void set_page_set (Gtk.PageSet page_set);
		[NoArrayLength ()]
		public void set_paper_height (double height, Gtk.Unit unit);
		[NoArrayLength ()]
		public void set_paper_size (Gtk.PaperSize paper_size);
		[NoArrayLength ()]
		public void set_paper_width (double width, Gtk.Unit unit);
		[NoArrayLength ()]
		public void set_print_pages (Gtk.PrintPages pages);
		[NoArrayLength ()]
		public void set_printer (string printer);
		[NoArrayLength ()]
		public void set_quality (Gtk.PrintQuality quality);
		[NoArrayLength ()]
		public void set_resolution (int resolution);
		[NoArrayLength ()]
		public void set_reverse (bool reverse);
		[NoArrayLength ()]
		public void set_scale (double scale);
		[NoArrayLength ()]
		public void set_use_color (bool use_color);
		[NoArrayLength ()]
		public void unset (string key);
	}
	public class PrintUnixDialog : Gtk.Dialog {
		[NoArrayLength ()]
		public void add_custom_tab (Gtk.Widget child, Gtk.Widget tab_label);
		[NoArrayLength ()]
		public int get_current_page ();
		[NoArrayLength ()]
		public Gtk.PageSetup get_page_setup ();
		[NoArrayLength ()]
		public Gtk.Printer get_selected_printer ();
		[NoArrayLength ()]
		public Gtk.PrintSettings get_settings ();
		[NoArrayLength ()]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		public construct (string title, Gtk.Window parent);
		[NoArrayLength ()]
		public void set_current_page (int current_page);
		[NoArrayLength ()]
		public void set_manual_capabilities (Gtk.PrintCapabilities capabilities);
		[NoArrayLength ()]
		public void set_page_setup (Gtk.PageSetup page_setup);
		[NoArrayLength ()]
		public void set_settings (Gtk.PrintSettings settings);
		public weak Gtk.PageSetup page_setup { get; set; }
		public weak int current_page { get; set; }
		[NoAccessorMethod ()]
		public weak Gtk.PrintSettings print_settings { get; set; }
		public weak Gtk.Printer selected_printer { get; }
	}
	public class Progress : Gtk.Widget {
		[NoAccessorMethod ()]
		public weak bool activity_mode { get; set; }
		[NoAccessorMethod ()]
		public weak bool show_text { get; set; }
		[NoAccessorMethod ()]
		public weak float text_xalign { get; set; }
		[NoAccessorMethod ()]
		public weak float text_yalign { get; set; }
	}
	public class ProgressBar : Gtk.Progress {
		[NoArrayLength ()]
		public Pango.EllipsizeMode get_ellipsize ();
		[NoArrayLength ()]
		public double get_fraction ();
		[NoArrayLength ()]
		public Gtk.ProgressBarOrientation get_orientation ();
		[NoArrayLength ()]
		public double get_pulse_step ();
		[NoArrayLength ()]
		public string get_text ();
		[NoArrayLength ()]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		public construct ();
		[NoArrayLength ()]
		public void pulse ();
		[NoArrayLength ()]
		public void set_ellipsize (Pango.EllipsizeMode mode);
		[NoArrayLength ()]
		public void set_fraction (double fraction);
		[NoArrayLength ()]
		public void set_orientation (Gtk.ProgressBarOrientation orientation);
		[NoArrayLength ()]
		public void set_pulse_step (double fraction);
		[NoArrayLength ()]
		public void set_text (string text);
		[NoAccessorMethod ()]
		public weak Gtk.Adjustment adjustment { get; set; }
		public weak Gtk.ProgressBarOrientation orientation { get; set; }
		[NoAccessorMethod ()]
		public weak Gtk.ProgressBarStyle bar_style { get; set; }
		[NoAccessorMethod ()]
		public weak uint activity_step { get; set; }
		[NoAccessorMethod ()]
		public weak uint activity_blocks { get; set; }
		[NoAccessorMethod ()]
		public weak uint discrete_blocks { get; set; }
		public weak double fraction { get; set; }
		public weak double pulse_step { get; set; }
		public weak string text { get; set; }
		public weak Pango.EllipsizeMode ellipsize { get; set; }
	}
	public class RadioAction : Gtk.ToggleAction {
		[NoArrayLength ()]
		public int get_current_value ();
		[NoArrayLength ()]
		public GLib.SList get_group ();
		[NoArrayLength ()]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		public construct (string name, string label, string tooltip, string stock_id, int value);
		[NoArrayLength ()]
		public void set_current_value (int current_value);
		[NoArrayLength ()]
		public void set_group (GLib.SList group);
		[NoAccessorMethod ()]
		public weak int value { get; set; }
		public weak Gtk.RadioAction group { set; }
		public weak int current_value { get; set; }
		public signal void changed (Gtk.RadioAction current);
	}
	public class RadioButton : Gtk.CheckButton {
		[NoArrayLength ()]
		public GLib.SList get_group ();
		[NoArrayLength ()]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		public construct (GLib.SList group);
		[NoArrayLength ()]
		public construct from_widget ();
		[NoArrayLength ()]
		public construct with_label (GLib.SList group, string label);
		[NoArrayLength ()]
		public construct with_label_from_widget (string label);
		[NoArrayLength ()]
		public construct with_mnemonic (GLib.SList group, string label);
		[NoArrayLength ()]
		public construct with_mnemonic_from_widget (string label);
		[NoArrayLength ()]
		public void set_group (GLib.SList group);
		public weak Gtk.RadioButton group { set; }
		public signal void group_changed ();
	}
	public class RadioMenuItem : Gtk.CheckMenuItem {
		[NoArrayLength ()]
		public GLib.SList get_group ();
		[NoArrayLength ()]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		public construct (GLib.SList group);
		[NoArrayLength ()]
		public construct from_widget ();
		[NoArrayLength ()]
		public construct with_label (GLib.SList group, string label);
		[NoArrayLength ()]
		public construct with_label_from_widget (string label);
		[NoArrayLength ()]
		public construct with_mnemonic (GLib.SList group, string label);
		[NoArrayLength ()]
		public construct with_mnemonic_from_widget (string label);
		[NoArrayLength ()]
		public void set_group (GLib.SList group);
		public weak Gtk.RadioMenuItem group { set; }
		public signal void group_changed ();
	}
	public class RadioToolButton : Gtk.ToggleToolButton {
		[NoArrayLength ()]
		public GLib.SList get_group ();
		[NoArrayLength ()]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		public construct (GLib.SList group);
		[NoArrayLength ()]
		public construct from_stock (GLib.SList group, string stock_id);
		[NoArrayLength ()]
		public construct from_widget ();
		[NoArrayLength ()]
		public construct with_stock_from_widget (string stock_id);
		[NoArrayLength ()]
		public void set_group (GLib.SList group);
		public weak Gtk.RadioToolButton group { set; }
	}
	public class Range : Gtk.Widget {
		[NoArrayLength ()]
		public Gtk.Adjustment get_adjustment ();
		[NoArrayLength ()]
		public bool get_inverted ();
		[NoArrayLength ()]
		public Gtk.SensitivityType get_lower_stepper_sensitivity ();
		[NoArrayLength ()]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		public Gtk.UpdateType get_update_policy ();
		[NoArrayLength ()]
		public Gtk.SensitivityType get_upper_stepper_sensitivity ();
		[NoArrayLength ()]
		public double get_value ();
		[NoArrayLength ()]
		public void set_adjustment (Gtk.Adjustment adjustment);
		[NoArrayLength ()]
		public void set_increments (double step, double page);
		[NoArrayLength ()]
		public void set_inverted (bool setting);
		[NoArrayLength ()]
		public void set_lower_stepper_sensitivity (Gtk.SensitivityType sensitivity);
		[NoArrayLength ()]
		public void set_range (double min, double max);
		[NoArrayLength ()]
		public void set_update_policy (Gtk.UpdateType policy);
		[NoArrayLength ()]
		public void set_upper_stepper_sensitivity (Gtk.SensitivityType sensitivity);
		[NoArrayLength ()]
		public void set_value (double value);
		public weak Gtk.UpdateType update_policy { get; set; }
		public weak Gtk.Adjustment adjustment { get; set construct; }
		public weak bool inverted { get; set; }
		public weak Gtk.SensitivityType lower_stepper_sensitivity { get; set; }
		public weak Gtk.SensitivityType upper_stepper_sensitivity { get; set; }
		public signal void value_changed ();
		public signal void adjust_bounds (double new_value);
		public signal void move_slider (Gtk.ScrollType scroll);
		public signal bool change_value (Gtk.ScrollType scroll, double new_value);
	}
	public class RcStyle : GLib.Object {
		public weak string name;
		public weak string bg_pixmap_name;
		public weak Pango.FontDescription font_desc;
		public weak Gtk.RcFlags color_flags;
		public weak Gdk.Color fg;
		public weak Gdk.Color bg;
		public weak Gdk.Color text;
		public weak Gdk.Color @base;
		public weak int xthickness;
		public weak int ythickness;
		[NoArrayLength ()]
		public Gtk.RcStyle copy ();
		[NoArrayLength ()]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		public construct ();
		[NoArrayLength ()]
		public void @ref ();
		[NoArrayLength ()]
		public void unref ();
	}
	public class RecentChooserDefault : Gtk.VBox, Gtk.RecentChooser {
	}
	public class RecentChooserDialog : Gtk.Dialog, Gtk.RecentChooser {
		[NoArrayLength ()]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		public construct (string title, Gtk.Window parent, string first_button_text);
		[NoArrayLength ()]
		public construct for_manager (string title, Gtk.Window parent, Gtk.RecentManager manager, string first_button_text);
	}
	public class RecentChooserMenu : Gtk.Menu, Gtk.RecentChooser {
		[NoArrayLength ()]
		public bool get_show_numbers ();
		[NoArrayLength ()]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		public construct ();
		[NoArrayLength ()]
		public construct for_manager (Gtk.RecentManager manager);
		[NoArrayLength ()]
		public void set_show_numbers (bool show_numbers);
		public weak bool show_numbers { get; set; }
	}
	public class RecentChooserWidget : Gtk.VBox, Gtk.RecentChooser {
		[NoArrayLength ()]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		public construct ();
		[NoArrayLength ()]
		public construct for_manager (Gtk.RecentManager manager);
	}
	public class RecentFilter : Gtk.Object {
		[NoArrayLength ()]
		public void add_age (int days);
		[NoArrayLength ()]
		public void add_application (string application);
		[NoArrayLength ()]
		public void add_custom (Gtk.RecentFilterFlags needed, Gtk.RecentFilterFunc func, pointer data, GLib.DestroyNotify data_destroy);
		[NoArrayLength ()]
		public void add_group (string group);
		[NoArrayLength ()]
		public void add_mime_type (string mime_type);
		[NoArrayLength ()]
		public void add_pattern (string pattern);
		[NoArrayLength ()]
		public void add_pixbuf_formats ();
		[NoArrayLength ()]
		public bool filter (Gtk.RecentFilterInfo filter_info);
		[NoArrayLength ()]
		public string get_name ();
		[NoArrayLength ()]
		public Gtk.RecentFilterFlags get_needed ();
		[NoArrayLength ()]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		public construct ();
		[NoArrayLength ()]
		public void set_name (string name);
	}
	public class RecentManager : GLib.Object {
		[NoArrayLength ()]
		public bool add_full (string uri, Gtk.RecentData recent_data);
		[NoArrayLength ()]
		public bool add_item (string uri);
		[NoArrayLength ()]
		public static GLib.Quark error_quark ();
		[NoArrayLength ()]
		public static Gtk.RecentManager get_default ();
		[NoArrayLength ()]
		public static Gtk.RecentManager get_for_screen (Gdk.Screen screen);
		[NoArrayLength ()]
		public GLib.List get_items ();
		[NoArrayLength ()]
		public int get_limit ();
		[NoArrayLength ()]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		public bool has_item (string uri);
		[NoArrayLength ()]
		public Gtk.RecentInfo lookup_item (string uri, GLib.Error error);
		[NoArrayLength ()]
		public bool move_item (string uri, string new_uri, GLib.Error error);
		[NoArrayLength ()]
		public construct ();
		[NoArrayLength ()]
		public int purge_items (GLib.Error error);
		[NoArrayLength ()]
		public bool remove_item (string uri, GLib.Error error);
		[NoArrayLength ()]
		public void set_limit (int limit);
		[NoArrayLength ()]
		public void set_screen (Gdk.Screen screen);
		[NoAccessorMethod ()]
		public weak string filename { get; construct; }
		public weak int limit { get; set; }
		[NoAccessorMethod ()]
		public weak int size { get; }
		public signal void changed ();
	}
	public class Ruler : Gtk.Widget {
		[NoArrayLength ()]
		public virtual void draw_pos ();
		[NoArrayLength ()]
		public virtual void draw_ticks ();
		[NoArrayLength ()]
		public Gtk.MetricType get_metric ();
		[NoArrayLength ()]
		public void get_range (double lower, double upper, double position, double max_size);
		[NoArrayLength ()]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		public void set_metric (Gtk.MetricType metric);
		[NoArrayLength ()]
		public void set_range (double lower, double upper, double position, double max_size);
		[NoAccessorMethod ()]
		public weak double lower { get; set; }
		[NoAccessorMethod ()]
		public weak double upper { get; set; }
		[NoAccessorMethod ()]
		public weak double position { get; set; }
		[NoAccessorMethod ()]
		public weak double max_size { get; set; }
		public weak Gtk.MetricType metric { get; set; }
	}
	public class Scale : Gtk.Range {
		[NoArrayLength ()]
		public int get_digits ();
		[NoArrayLength ()]
		public bool get_draw_value ();
		[NoArrayLength ()]
		public Pango.Layout get_layout ();
		[NoArrayLength ()]
		public virtual void get_layout_offsets (int x, int y);
		[NoArrayLength ()]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		public Gtk.PositionType get_value_pos ();
		[NoArrayLength ()]
		public void set_digits (int digits);
		[NoArrayLength ()]
		public void set_draw_value (bool draw_value);
		[NoArrayLength ()]
		public void set_value_pos (Gtk.PositionType pos);
		public weak int digits { get; set; }
		public weak bool draw_value { get; set; }
		public weak Gtk.PositionType value_pos { get; set; }
		public signal string format_value (double value);
	}
	public class Scrollbar : Gtk.Range {
		[NoArrayLength ()]
		public static GLib.Type get_type ();
	}
	public class ScrolledWindow : Gtk.Bin {
		public weak Gtk.Widget hscrollbar;
		public weak Gtk.Widget vscrollbar;
		[NoArrayLength ()]
		public void add_with_viewport (Gtk.Widget child);
		[NoArrayLength ()]
		public Gtk.Adjustment get_hadjustment ();
		[NoArrayLength ()]
		public Gtk.Widget get_hscrollbar ();
		[NoArrayLength ()]
		public Gtk.CornerType get_placement ();
		[NoArrayLength ()]
		public void get_policy (Gtk.PolicyType hscrollbar_policy, Gtk.PolicyType vscrollbar_policy);
		[NoArrayLength ()]
		public Gtk.ShadowType get_shadow_type ();
		[NoArrayLength ()]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		public Gtk.Adjustment get_vadjustment ();
		[NoArrayLength ()]
		public Gtk.Widget get_vscrollbar ();
		[NoArrayLength ()]
		public construct (Gtk.Adjustment hadjustment, Gtk.Adjustment vadjustment);
		[NoArrayLength ()]
		public void set_hadjustment (Gtk.Adjustment hadjustment);
		[NoArrayLength ()]
		public void set_placement (Gtk.CornerType window_placement);
		[NoArrayLength ()]
		public void set_policy (Gtk.PolicyType hscrollbar_policy, Gtk.PolicyType vscrollbar_policy);
		[NoArrayLength ()]
		public void set_shadow_type (Gtk.ShadowType type);
		[NoArrayLength ()]
		public void set_vadjustment (Gtk.Adjustment vadjustment);
		[NoArrayLength ()]
		public void unset_placement ();
		public weak Gtk.Adjustment hadjustment { get; set construct; }
		public weak Gtk.Adjustment vadjustment { get; set construct; }
		[NoAccessorMethod ()]
		public weak Gtk.PolicyType hscrollbar_policy { get; set; }
		[NoAccessorMethod ()]
		public weak Gtk.PolicyType vscrollbar_policy { get; set; }
		[NoAccessorMethod ()]
		public weak Gtk.CornerType window_placement { get; set; }
		[NoAccessorMethod ()]
		public weak bool window_placement_set { get; set; }
		public weak Gtk.ShadowType shadow_type { get; set; }
		public signal void scroll_child (Gtk.ScrollType scroll, bool horizontal);
		public signal void move_focus_out (Gtk.DirectionType direction);
	}
	public class Separator : Gtk.Widget {
		[NoArrayLength ()]
		public static GLib.Type get_type ();
	}
	public class SeparatorMenuItem : Gtk.MenuItem {
		[NoArrayLength ()]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		public construct ();
	}
	public class SeparatorToolItem : Gtk.ToolItem {
		[NoArrayLength ()]
		public bool get_draw ();
		[NoArrayLength ()]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		public construct ();
		[NoArrayLength ()]
		public void set_draw (bool draw);
		public weak bool draw { get; set; }
	}
	public class Settings : GLib.Object {
		[NoArrayLength ()]
		public static Gtk.Settings get_default ();
		[NoArrayLength ()]
		public static Gtk.Settings get_for_screen (Gdk.Screen screen);
		[NoArrayLength ()]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		public static void install_property (GLib.ParamSpec pspec);
		[NoArrayLength ()]
		public static void install_property_parser (GLib.ParamSpec pspec, Gtk.RcPropertyParser parser);
		[NoArrayLength ()]
		public void set_double_property (string name, double v_double, string origin);
		[NoArrayLength ()]
		public void set_long_property (string name, long v_long, string origin);
		[NoArrayLength ()]
		public void set_property_value (string name, Gtk.SettingsValue svalue);
		[NoArrayLength ()]
		public void set_string_property (string name, string v_string, string origin);
		[NoAccessorMethod ()]
		public weak GLib.HashTable color_hash { get; }
	}
	public class SizeGroup : GLib.Object {
		[NoArrayLength ()]
		public void add_widget (Gtk.Widget widget);
		[NoArrayLength ()]
		public bool get_ignore_hidden ();
		[NoArrayLength ()]
		public Gtk.SizeGroupMode get_mode ();
		[NoArrayLength ()]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		public GLib.SList get_widgets ();
		[NoArrayLength ()]
		public construct (Gtk.SizeGroupMode mode);
		[NoArrayLength ()]
		public void remove_widget (Gtk.Widget widget);
		[NoArrayLength ()]
		public void set_ignore_hidden (bool ignore_hidden);
		[NoArrayLength ()]
		public void set_mode (Gtk.SizeGroupMode mode);
		public weak Gtk.SizeGroupMode mode { get; set; }
		public weak bool ignore_hidden { get; set; }
	}
	public class Socket : Gtk.Container {
		[NoArrayLength ()]
		public void add_id (pointer window_id);
		[NoArrayLength ()]
		public pointer get_id ();
		[NoArrayLength ()]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		public construct ();
		public signal void plug_added ();
		public signal bool plug_removed ();
	}
	public class SpinButton : Gtk.Entry, Gtk.Editable {
		[NoArrayLength ()]
		public void configure (Gtk.Adjustment adjustment, double climb_rate, uint digits);
		[NoArrayLength ()]
		public Gtk.Adjustment get_adjustment ();
		[NoArrayLength ()]
		public uint get_digits ();
		[NoArrayLength ()]
		public void get_increments (double step, double page);
		[NoArrayLength ()]
		public bool get_numeric ();
		[NoArrayLength ()]
		public void get_range (double min, double max);
		[NoArrayLength ()]
		public bool get_snap_to_ticks ();
		[NoArrayLength ()]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		public Gtk.SpinButtonUpdatePolicy get_update_policy ();
		[NoArrayLength ()]
		public double get_value ();
		[NoArrayLength ()]
		public int get_value_as_int ();
		[NoArrayLength ()]
		public bool get_wrap ();
		[NoArrayLength ()]
		public construct (Gtk.Adjustment adjustment, double climb_rate, uint digits);
		[NoArrayLength ()]
		public construct with_range (double min, double max, double step);
		[NoArrayLength ()]
		public void set_adjustment (Gtk.Adjustment adjustment);
		[NoArrayLength ()]
		public void set_digits (uint digits);
		[NoArrayLength ()]
		public void set_increments (double step, double page);
		[NoArrayLength ()]
		public void set_numeric (bool numeric);
		[NoArrayLength ()]
		public void set_range (double min, double max);
		[NoArrayLength ()]
		public void set_snap_to_ticks (bool snap_to_ticks);
		[NoArrayLength ()]
		public void set_update_policy (Gtk.SpinButtonUpdatePolicy policy);
		[NoArrayLength ()]
		public void set_value (double value);
		[NoArrayLength ()]
		public void set_wrap (bool wrap);
		[NoArrayLength ()]
		public void spin (Gtk.SpinType direction, double increment);
		[NoArrayLength ()]
		public void update ();
		public weak Gtk.Adjustment adjustment { get; set; }
		[NoAccessorMethod ()]
		public weak double climb_rate { get; set; }
		public weak uint digits { get; set; }
		public weak bool snap_to_ticks { get; set; }
		public weak bool numeric { get; set; }
		public weak bool wrap { get; set; }
		public weak Gtk.SpinButtonUpdatePolicy update_policy { get; set; }
		public weak double value { get; set; }
		public signal int input (double new_value);
		public signal int output ();
		public signal void value_changed ();
		public signal void wrapped ();
		public signal void change_value (Gtk.ScrollType scroll);
	}
	public class Statusbar : Gtk.HBox {
		[NoArrayLength ()]
		public uint get_context_id (string context_description);
		[NoArrayLength ()]
		public bool get_has_resize_grip ();
		[NoArrayLength ()]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		public construct ();
		[NoArrayLength ()]
		public void pop (uint context_id);
		[NoArrayLength ()]
		public uint push (uint context_id, string text);
		[NoArrayLength ()]
		public void remove (uint context_id, uint message_id);
		[NoArrayLength ()]
		public void set_has_resize_grip (bool setting);
		public weak bool has_resize_grip { get; set; }
		public signal void text_pushed (uint context_id, string text);
		public signal void text_popped (uint context_id, string text);
	}
	public class StatusIcon : GLib.Object {
		[NoArrayLength ()]
		public bool get_blinking ();
		[NoArrayLength ()]
		public bool get_geometry (Gdk.Screen screen, Gdk.Rectangle area, Gtk.Orientation orientation);
		[NoArrayLength ()]
		public string get_icon_name ();
		[NoArrayLength ()]
		public Gdk.Pixbuf get_pixbuf ();
		[NoArrayLength ()]
		public int get_size ();
		[NoArrayLength ()]
		public string get_stock ();
		[NoArrayLength ()]
		public Gtk.ImageType get_storage_type ();
		[NoArrayLength ()]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		public bool get_visible ();
		[NoArrayLength ()]
		public bool is_embedded ();
		[NoArrayLength ()]
		public construct ();
		[NoArrayLength ()]
		public construct from_file (string filename);
		[NoArrayLength ()]
		public construct from_icon_name (string icon_name);
		[NoArrayLength ()]
		public construct from_pixbuf (Gdk.Pixbuf pixbuf);
		[NoArrayLength ()]
		public construct from_stock (string stock_id);
		[NoArrayLength ()]
		public static void position_menu (Gtk.Menu menu, int x, int y, bool push_in, pointer user_data);
		[NoArrayLength ()]
		public void set_blinking (bool blinking);
		[NoArrayLength ()]
		public void set_from_file (string filename);
		[NoArrayLength ()]
		public void set_from_icon_name (string icon_name);
		[NoArrayLength ()]
		public void set_from_pixbuf (Gdk.Pixbuf pixbuf);
		[NoArrayLength ()]
		public void set_from_stock (string stock_id);
		[NoArrayLength ()]
		public void set_tooltip (string tooltip_text);
		[NoArrayLength ()]
		public void set_visible (bool visible);
		[NoAccessorMethod ()]
		public weak Gdk.Pixbuf pixbuf { get; set; }
		[NoAccessorMethod ()]
		public weak string file { set; }
		[NoAccessorMethod ()]
		public weak string stock { get; set; }
		[NoAccessorMethod ()]
		public weak string icon_name { get; set; }
		public weak Gtk.ImageType storage_type { get; }
		public weak int size { get; }
		public weak bool blinking { get; set; }
		public weak bool visible { get; set; }
		public signal void activate ();
		public signal void popup_menu (uint button, uint activate_time);
		public signal bool size_changed (int size);
	}
	public class Style : GLib.Object {
		public weak Gdk.Color fg;
		public weak Gdk.Color bg;
		public weak Gdk.Color light;
		public weak Gdk.Color dark;
		public weak Gdk.Color mid;
		public weak Gdk.Color text;
		public weak Gdk.Color @base;
		public weak Gdk.Color text_aa;
		public weak Gdk.Color black;
		public weak Gdk.Color white;
		public weak Pango.FontDescription font_desc;
		public weak int xthickness;
		public weak int ythickness;
		public weak Gdk.GC fg_gc;
		public weak Gdk.GC bg_gc;
		public weak Gdk.GC light_gc;
		public weak Gdk.GC dark_gc;
		public weak Gdk.GC mid_gc;
		public weak Gdk.GC text_gc;
		public weak Gdk.GC base_gc;
		public weak Gdk.GC text_aa_gc;
		public weak Gdk.GC black_gc;
		public weak Gdk.GC white_gc;
		public weak Gdk.Pixmap bg_pixmap;
		[NoArrayLength ()]
		public void apply_default_background (Gdk.Window window, bool set_bg, Gtk.StateType state_type, Gdk.Rectangle area, int x, int y, int width, int height);
		[NoArrayLength ()]
		public Gtk.Style attach (Gdk.Window window);
		[NoArrayLength ()]
		public virtual Gtk.Style copy ();
		[NoArrayLength ()]
		public void detach ();
		[NoArrayLength ()]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		public bool lookup_color (string color_name, Gdk.Color color);
		[NoArrayLength ()]
		public Gtk.IconSet lookup_icon_set (string stock_id);
		[NoArrayLength ()]
		public construct ();
		[NoArrayLength ()]
		public virtual Gdk.Pixbuf render_icon (Gtk.IconSource source, Gtk.TextDirection direction, Gtk.StateType state, Gtk.IconSize size, Gtk.Widget widget, string detail);
		[NoArrayLength ()]
		public virtual void set_background (Gdk.Window window, Gtk.StateType state_type);
		public signal void realize ();
		public signal void unrealize ();
	}
	public class Table : Gtk.Container {
		[NoArrayLength ()]
		public void attach (Gtk.Widget child, uint left_attach, uint right_attach, uint top_attach, uint bottom_attach, Gtk.AttachOptions xoptions, Gtk.AttachOptions yoptions, uint xpadding, uint ypadding);
		[NoArrayLength ()]
		public void attach_defaults (Gtk.Widget widget, uint left_attach, uint right_attach, uint top_attach, uint bottom_attach);
		[NoArrayLength ()]
		public uint get_col_spacing (uint column);
		[NoArrayLength ()]
		public uint get_default_col_spacing ();
		[NoArrayLength ()]
		public uint get_default_row_spacing ();
		[NoArrayLength ()]
		public bool get_homogeneous ();
		[NoArrayLength ()]
		public uint get_row_spacing (uint row);
		[NoArrayLength ()]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		public construct (uint rows, uint columns, bool homogeneous);
		[NoArrayLength ()]
		public void resize (uint rows, uint columns);
		[NoArrayLength ()]
		public void set_col_spacing (uint column, uint spacing);
		[NoArrayLength ()]
		public void set_col_spacings (uint spacing);
		[NoArrayLength ()]
		public void set_homogeneous (bool homogeneous);
		[NoArrayLength ()]
		public void set_row_spacing (uint row, uint spacing);
		[NoArrayLength ()]
		public void set_row_spacings (uint spacing);
		[NoAccessorMethod ()]
		public weak uint n_rows { get; set; }
		[NoAccessorMethod ()]
		public weak uint n_columns { get; set; }
		public weak uint row_spacing { get; set; }
		[NoAccessorMethod ()]
		public weak uint column_spacing { get; set; }
		public weak bool homogeneous { get; set; }
	}
	public class TearoffMenuItem : Gtk.MenuItem {
		[NoArrayLength ()]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		public construct ();
	}
	public class TextBuffer : GLib.Object {
		[NoArrayLength ()]
		public void add_selection_clipboard (Gtk.Clipboard clipboard);
		[NoArrayLength ()]
		public void apply_tag_by_name (string name, Gtk.TextIter start, Gtk.TextIter end);
		[NoArrayLength ()]
		public bool backspace (Gtk.TextIter iter, bool interactive, bool default_editable);
		[NoArrayLength ()]
		public void copy_clipboard (Gtk.Clipboard clipboard);
		[NoArrayLength ()]
		public Gtk.TextChildAnchor create_child_anchor (Gtk.TextIter iter);
		[NoArrayLength ()]
		public Gtk.TextMark create_mark (string mark_name, Gtk.TextIter where, bool left_gravity);
		[NoArrayLength ()]
		public Gtk.TextTag create_tag (string tag_name, string first_property_name);
		[NoArrayLength ()]
		public void cut_clipboard (Gtk.Clipboard clipboard, bool default_editable);
		[NoArrayLength ()]
		public void delete (Gtk.TextIter start, Gtk.TextIter end);
		[NoArrayLength ()]
		public bool delete_interactive (Gtk.TextIter start_iter, Gtk.TextIter end_iter, bool default_editable);
		[NoArrayLength ()]
		public void delete_mark (Gtk.TextMark mark);
		[NoArrayLength ()]
		public void delete_mark_by_name (string name);
		[NoArrayLength ()]
		public bool delete_selection (bool interactive, bool default_editable);
		[NoArrayLength ()]
		public bool deserialize (Gtk.TextBuffer content_buffer, Gdk.Atom format, Gtk.TextIter iter, uchar data, ulong length, GLib.Error error);
		[NoArrayLength ()]
		public bool deserialize_get_can_create_tags (Gdk.Atom format);
		[NoArrayLength ()]
		public void deserialize_set_can_create_tags (Gdk.Atom format, bool can_create_tags);
		[NoArrayLength ()]
		public void get_bounds (Gtk.TextIter start, Gtk.TextIter end);
		[NoArrayLength ()]
		public int get_char_count ();
		[NoArrayLength ()]
		public Gtk.TargetList get_copy_target_list ();
		[NoArrayLength ()]
		public Gdk.Atom get_deserialize_formats (int n_formats);
		[NoArrayLength ()]
		public void get_end_iter (Gtk.TextIter iter);
		[NoArrayLength ()]
		public bool get_has_selection ();
		[NoArrayLength ()]
		public Gtk.TextMark get_insert ();
		[NoArrayLength ()]
		public void get_iter_at_child_anchor (Gtk.TextIter iter, Gtk.TextChildAnchor anchor);
		[NoArrayLength ()]
		public void get_iter_at_line (Gtk.TextIter iter, int line_number);
		[NoArrayLength ()]
		public void get_iter_at_line_index (Gtk.TextIter iter, int line_number, int byte_index);
		[NoArrayLength ()]
		public void get_iter_at_line_offset (Gtk.TextIter iter, int line_number, int char_offset);
		[NoArrayLength ()]
		public void get_iter_at_mark (Gtk.TextIter iter, Gtk.TextMark mark);
		[NoArrayLength ()]
		public void get_iter_at_offset (Gtk.TextIter iter, int char_offset);
		[NoArrayLength ()]
		public int get_line_count ();
		[NoArrayLength ()]
		public Gtk.TextMark get_mark (string name);
		[NoArrayLength ()]
		public bool get_modified ();
		[NoArrayLength ()]
		public Gtk.TargetList get_paste_target_list ();
		[NoArrayLength ()]
		public Gtk.TextMark get_selection_bound ();
		[NoArrayLength ()]
		public bool get_selection_bounds (Gtk.TextIter start, Gtk.TextIter end);
		[NoArrayLength ()]
		public Gdk.Atom get_serialize_formats (int n_formats);
		[NoArrayLength ()]
		public string get_slice (Gtk.TextIter start, Gtk.TextIter end, bool include_hidden_chars);
		[NoArrayLength ()]
		public void get_start_iter (Gtk.TextIter iter);
		[NoArrayLength ()]
		public Gtk.TextTagTable get_tag_table ();
		[NoArrayLength ()]
		public string get_text (Gtk.TextIter start, Gtk.TextIter end, bool include_hidden_chars);
		[NoArrayLength ()]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		public void insert (Gtk.TextIter iter, string text, int len);
		[NoArrayLength ()]
		public void insert_at_cursor (string text, int len);
		[NoArrayLength ()]
		public bool insert_interactive (Gtk.TextIter iter, string text, int len, bool default_editable);
		[NoArrayLength ()]
		public bool insert_interactive_at_cursor (string text, int len, bool default_editable);
		[NoArrayLength ()]
		public void insert_range (Gtk.TextIter iter, Gtk.TextIter start, Gtk.TextIter end);
		[NoArrayLength ()]
		public bool insert_range_interactive (Gtk.TextIter iter, Gtk.TextIter start, Gtk.TextIter end, bool default_editable);
		[NoArrayLength ()]
		public void insert_with_tags (Gtk.TextIter iter, string text, int len, Gtk.TextTag first_tag);
		[NoArrayLength ()]
		public void insert_with_tags_by_name (Gtk.TextIter iter, string text, int len, string first_tag_name);
		[NoArrayLength ()]
		public void move_mark (Gtk.TextMark mark, Gtk.TextIter where);
		[NoArrayLength ()]
		public void move_mark_by_name (string name, Gtk.TextIter where);
		[NoArrayLength ()]
		public construct (Gtk.TextTagTable table);
		[NoArrayLength ()]
		public void paste_clipboard (Gtk.Clipboard clipboard, Gtk.TextIter override_location, bool default_editable);
		[NoArrayLength ()]
		public void place_cursor (Gtk.TextIter where);
		[NoArrayLength ()]
		public Gdk.Atom register_deserialize_format (string mime_type, Gtk.TextBufferDeserializeFunc function, pointer user_data, GLib.DestroyNotify user_data_destroy);
		[NoArrayLength ()]
		public Gdk.Atom register_deserialize_tagset (string tagset_name);
		[NoArrayLength ()]
		public Gdk.Atom register_serialize_format (string mime_type, Gtk.TextBufferSerializeFunc function, pointer user_data, GLib.DestroyNotify user_data_destroy);
		[NoArrayLength ()]
		public Gdk.Atom register_serialize_tagset (string tagset_name);
		[NoArrayLength ()]
		public void remove_all_tags (Gtk.TextIter start, Gtk.TextIter end);
		[NoArrayLength ()]
		public void remove_selection_clipboard (Gtk.Clipboard clipboard);
		[NoArrayLength ()]
		public void remove_tag_by_name (string name, Gtk.TextIter start, Gtk.TextIter end);
		[NoArrayLength ()]
		public void select_range (Gtk.TextIter ins, Gtk.TextIter bound);
		[NoArrayLength ()]
		public uchar serialize (Gtk.TextBuffer content_buffer, Gdk.Atom format, Gtk.TextIter start, Gtk.TextIter end, ulong length);
		[NoArrayLength ()]
		public void set_modified (bool setting);
		[NoArrayLength ()]
		public void set_text (string text, int len);
		[NoArrayLength ()]
		public void unregister_deserialize_format (Gdk.Atom format);
		[NoArrayLength ()]
		public void unregister_serialize_format (Gdk.Atom format);
		[NoAccessorMethod ()]
		public weak Gtk.TextTagTable tag_table { get; construct; }
		public weak string text { get; set; }
		public weak bool has_selection { get; }
		[NoAccessorMethod ()]
		public weak int cursor_position { get; }
		public weak Gtk.TargetList copy_target_list { get; }
		public weak Gtk.TargetList paste_target_list { get; }
		public signal void insert_text (Gtk.TextIter pos, string text, int length);
		[HasEmitter ()]
		public signal void insert_pixbuf (Gtk.TextIter pos, Gdk.Pixbuf pixbuf);
		[HasEmitter ()]
		public signal void insert_child_anchor (Gtk.TextIter pos, Gtk.TextChildAnchor anchor);
		public signal void delete_range (Gtk.TextIter start, Gtk.TextIter end);
		public signal void changed ();
		public signal void modified_changed ();
		public signal void mark_set (Gtk.TextIter location, Gtk.TextMark mark);
		public signal void mark_deleted (Gtk.TextMark mark);
		[HasEmitter ()]
		public signal void apply_tag (Gtk.TextTag tag, Gtk.TextIter start_char, Gtk.TextIter end_char);
		[HasEmitter ()]
		public signal void remove_tag (Gtk.TextTag tag, Gtk.TextIter start_char, Gtk.TextIter end_char);
		[HasEmitter ()]
		public signal void begin_user_action ();
		[HasEmitter ()]
		public signal void end_user_action ();
	}
	public class TextChildAnchor : GLib.Object {
		[NoArrayLength ()]
		public bool get_deleted ();
		[NoArrayLength ()]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		public GLib.List get_widgets ();
		[NoArrayLength ()]
		public construct ();
	}
	public class TextMark : GLib.Object {
		[NoArrayLength ()]
		public Gtk.TextBuffer get_buffer ();
		[NoArrayLength ()]
		public bool get_deleted ();
		[NoArrayLength ()]
		public bool get_left_gravity ();
		[NoArrayLength ()]
		public string get_name ();
		[NoArrayLength ()]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		public bool get_visible ();
		[NoArrayLength ()]
		public void set_visible (bool setting);
	}
	public class TextTag : GLib.Object {
		[NoArrayLength ()]
		public int get_priority ();
		[NoArrayLength ()]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		public construct (string name);
		[NoArrayLength ()]
		public void set_priority (int priority);
		[NoAccessorMethod ()]
		public weak string name { get; construct; }
		[NoAccessorMethod ()]
		public weak string background { set; }
		[NoAccessorMethod ()]
		public weak Gdk.Color background_gdk { get; set; }
		[NoAccessorMethod ()]
		public weak bool background_full_height { get; set; }
		[NoAccessorMethod ()]
		public weak Gdk.Pixmap background_stipple { get; set; }
		[NoAccessorMethod ()]
		public weak string foreground { set; }
		[NoAccessorMethod ()]
		public weak Gdk.Color foreground_gdk { get; set; }
		[NoAccessorMethod ()]
		public weak Gdk.Pixmap foreground_stipple { get; set; }
		[NoAccessorMethod ()]
		public weak Gtk.TextDirection direction { get; set; }
		[NoAccessorMethod ()]
		public weak bool editable { get; set; }
		[NoAccessorMethod ()]
		public weak string font { get; set; }
		[NoAccessorMethod ()]
		public weak Pango.FontDescription font_desc { get; set; }
		[NoAccessorMethod ()]
		public weak string family { get; set; }
		[NoAccessorMethod ()]
		public weak Pango.Style style { get; set; }
		[NoAccessorMethod ()]
		public weak Pango.Variant variant { get; set; }
		[NoAccessorMethod ()]
		public weak int weight { get; set; }
		[NoAccessorMethod ()]
		public weak Pango.Stretch stretch { get; set; }
		[NoAccessorMethod ()]
		public weak int size { get; set; }
		[NoAccessorMethod ()]
		public weak double scale { get; set; }
		[NoAccessorMethod ()]
		public weak double size_points { get; set; }
		[NoAccessorMethod ()]
		public weak Gtk.Justification justification { get; set; }
		[NoAccessorMethod ()]
		public weak string language { get; set; }
		[NoAccessorMethod ()]
		public weak int left_margin { get; set; }
		[NoAccessorMethod ()]
		public weak int right_margin { get; set; }
		[NoAccessorMethod ()]
		public weak int indent { get; set; }
		[NoAccessorMethod ()]
		public weak int rise { get; set; }
		[NoAccessorMethod ()]
		public weak int pixels_above_lines { get; set; }
		[NoAccessorMethod ()]
		public weak int pixels_below_lines { get; set; }
		[NoAccessorMethod ()]
		public weak int pixels_inside_wrap { get; set; }
		[NoAccessorMethod ()]
		public weak bool strikethrough { get; set; }
		[NoAccessorMethod ()]
		public weak Pango.Underline underline { get; set; }
		[NoAccessorMethod ()]
		public weak Gtk.WrapMode wrap_mode { get; set; }
		[NoAccessorMethod ()]
		public weak Pango.TabArray tabs { get; set; }
		[NoAccessorMethod ()]
		public weak bool invisible { get; set; }
		[NoAccessorMethod ()]
		public weak string paragraph_background { set; }
		[NoAccessorMethod ()]
		public weak Gdk.Color paragraph_background_gdk { get; set; }
		[HasEmitter ()]
		public signal bool event (GLib.Object event_object, Gdk.Event event, Gtk.TextIter iter);
	}
	public class TextTagTable : GLib.Object {
		[NoArrayLength ()]
		public void add (Gtk.TextTag tag);
		[NoArrayLength ()]
		public void @foreach (Gtk.TextTagTableForeach func, pointer data);
		[NoArrayLength ()]
		public int get_size ();
		[NoArrayLength ()]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		public Gtk.TextTag lookup (string name);
		[NoArrayLength ()]
		public construct ();
		[NoArrayLength ()]
		public void remove (Gtk.TextTag tag);
		public signal void tag_changed (Gtk.TextTag tag, bool size_changed);
		public signal void tag_added (Gtk.TextTag tag);
		public signal void tag_removed (Gtk.TextTag tag);
	}
	public class TextView : Gtk.Container {
		[NoArrayLength ()]
		public void add_child_at_anchor (Gtk.Widget child, Gtk.TextChildAnchor anchor);
		[NoArrayLength ()]
		public void add_child_in_window (Gtk.Widget child, Gtk.TextWindowType which_window, int xpos, int ypos);
		[NoArrayLength ()]
		public bool backward_display_line (Gtk.TextIter iter);
		[NoArrayLength ()]
		public bool backward_display_line_start (Gtk.TextIter iter);
		[NoArrayLength ()]
		public void buffer_to_window_coords (Gtk.TextWindowType win, int buffer_x, int buffer_y, int window_x, int window_y);
		[NoArrayLength ()]
		public bool forward_display_line (Gtk.TextIter iter);
		[NoArrayLength ()]
		public bool forward_display_line_end (Gtk.TextIter iter);
		[NoArrayLength ()]
		public bool get_accepts_tab ();
		[NoArrayLength ()]
		public int get_border_window_size (Gtk.TextWindowType type);
		[NoArrayLength ()]
		public Gtk.TextBuffer get_buffer ();
		[NoArrayLength ()]
		public bool get_cursor_visible ();
		[NoArrayLength ()]
		public Gtk.TextAttributes get_default_attributes ();
		[NoArrayLength ()]
		public bool get_editable ();
		[NoArrayLength ()]
		public int get_indent ();
		[NoArrayLength ()]
		public void get_iter_at_location (Gtk.TextIter iter, int x, int y);
		[NoArrayLength ()]
		public void get_iter_at_position (Gtk.TextIter iter, int trailing, int x, int y);
		[NoArrayLength ()]
		public void get_iter_location (Gtk.TextIter iter, Gdk.Rectangle location);
		[NoArrayLength ()]
		public Gtk.Justification get_justification ();
		[NoArrayLength ()]
		public int get_left_margin ();
		[NoArrayLength ()]
		public void get_line_at_y (Gtk.TextIter target_iter, int y, int line_top);
		[NoArrayLength ()]
		public void get_line_yrange (Gtk.TextIter iter, int y, int height);
		[NoArrayLength ()]
		public bool get_overwrite ();
		[NoArrayLength ()]
		public int get_pixels_above_lines ();
		[NoArrayLength ()]
		public int get_pixels_below_lines ();
		[NoArrayLength ()]
		public int get_pixels_inside_wrap ();
		[NoArrayLength ()]
		public int get_right_margin ();
		[NoArrayLength ()]
		public Pango.TabArray get_tabs ();
		[NoArrayLength ()]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		public void get_visible_rect (Gdk.Rectangle visible_rect);
		[NoArrayLength ()]
		public Gdk.Window get_window (Gtk.TextWindowType win);
		[NoArrayLength ()]
		public Gtk.TextWindowType get_window_type (Gdk.Window window);
		[NoArrayLength ()]
		public Gtk.WrapMode get_wrap_mode ();
		[NoArrayLength ()]
		public void move_child (Gtk.Widget child, int xpos, int ypos);
		[NoArrayLength ()]
		public bool move_mark_onscreen (Gtk.TextMark mark);
		[NoArrayLength ()]
		public bool move_visually (Gtk.TextIter iter, int count);
		[NoArrayLength ()]
		public construct ();
		[NoArrayLength ()]
		public construct with_buffer (Gtk.TextBuffer buffer);
		[NoArrayLength ()]
		public bool place_cursor_onscreen ();
		[NoArrayLength ()]
		public void scroll_mark_onscreen (Gtk.TextMark mark);
		[NoArrayLength ()]
		public bool scroll_to_iter (Gtk.TextIter iter, double within_margin, bool use_align, double xalign, double yalign);
		[NoArrayLength ()]
		public void scroll_to_mark (Gtk.TextMark mark, double within_margin, bool use_align, double xalign, double yalign);
		[NoArrayLength ()]
		public void set_accepts_tab (bool accepts_tab);
		[NoArrayLength ()]
		public void set_border_window_size (Gtk.TextWindowType type, int size);
		[NoArrayLength ()]
		public void set_buffer (Gtk.TextBuffer buffer);
		[NoArrayLength ()]
		public void set_cursor_visible (bool setting);
		[NoArrayLength ()]
		public void set_editable (bool setting);
		[NoArrayLength ()]
		public void set_indent (int indent);
		[NoArrayLength ()]
		public void set_justification (Gtk.Justification justification);
		[NoArrayLength ()]
		public void set_left_margin (int left_margin);
		[NoArrayLength ()]
		public void set_overwrite (bool overwrite);
		[NoArrayLength ()]
		public void set_pixels_above_lines (int pixels_above_lines);
		[NoArrayLength ()]
		public void set_pixels_below_lines (int pixels_below_lines);
		[NoArrayLength ()]
		public void set_pixels_inside_wrap (int pixels_inside_wrap);
		[NoArrayLength ()]
		public void set_right_margin (int right_margin);
		[NoArrayLength ()]
		public void set_tabs (Pango.TabArray tabs);
		[NoArrayLength ()]
		public void set_wrap_mode (Gtk.WrapMode wrap_mode);
		[NoArrayLength ()]
		public bool starts_display_line (Gtk.TextIter iter);
		[NoArrayLength ()]
		public void window_to_buffer_coords (Gtk.TextWindowType win, int window_x, int window_y, int buffer_x, int buffer_y);
		public weak int pixels_above_lines { get; set; }
		public weak int pixels_below_lines { get; set; }
		public weak int pixels_inside_wrap { get; set; }
		public weak bool editable { get; set; }
		public weak Gtk.WrapMode wrap_mode { get; set; }
		public weak Gtk.Justification justification { get; set; }
		public weak int left_margin { get; set; }
		public weak int right_margin { get; set; }
		public weak int indent { get; set; }
		public weak Pango.TabArray tabs { get; set; }
		public weak bool cursor_visible { get; set; }
		public weak Gtk.TextBuffer buffer { get; set; }
		public weak bool overwrite { get; set; }
		public weak bool accepts_tab { get; set; }
		public signal void move_cursor (Gtk.MovementStep step, int count, bool extend_selection);
		public signal void page_horizontally (int count, bool extend_selection);
		public signal void set_anchor ();
		public signal void insert_at_cursor (string str);
		public signal void delete_from_cursor (Gtk.DeleteType type, int count);
		public signal void backspace ();
		public signal void cut_clipboard ();
		public signal void copy_clipboard ();
		public signal void paste_clipboard ();
		public signal void toggle_overwrite ();
		public signal void move_focus (Gtk.DirectionType direction);
		public signal void set_scroll_adjustments (Gtk.Adjustment hadjustment, Gtk.Adjustment vadjustment);
		public signal void populate_popup (Gtk.Menu menu);
	}
	public class ToggleAction : Gtk.Action {
		[NoArrayLength ()]
		public bool get_active ();
		[NoArrayLength ()]
		public bool get_draw_as_radio ();
		[NoArrayLength ()]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		public construct (string name, string label, string tooltip, string stock_id);
		[NoArrayLength ()]
		public void set_active (bool is_active);
		[NoArrayLength ()]
		public void set_draw_as_radio (bool draw_as_radio);
		public weak bool draw_as_radio { get; set; }
		public weak bool active { get; set; }
		[HasEmitter ()]
		public signal void toggled ();
	}
	public class ToggleButton : Gtk.Button {
		[NoArrayLength ()]
		public bool get_active ();
		[NoArrayLength ()]
		public bool get_inconsistent ();
		[NoArrayLength ()]
		public bool get_mode ();
		[NoArrayLength ()]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		public construct ();
		[NoArrayLength ()]
		public construct with_label (string label);
		[NoArrayLength ()]
		public construct with_mnemonic (string label);
		[NoArrayLength ()]
		public void set_active (bool is_active);
		[NoArrayLength ()]
		public void set_inconsistent (bool setting);
		[NoArrayLength ()]
		public void set_mode (bool draw_indicator);
		public weak bool active { get; set; }
		public weak bool inconsistent { get; set; }
		[NoAccessorMethod ()]
		public weak bool draw_indicator { get; set; }
		[HasEmitter ()]
		public signal void toggled ();
	}
	public class ToggleToolButton : Gtk.ToolButton {
		[NoArrayLength ()]
		public bool get_active ();
		[NoArrayLength ()]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		public construct ();
		[NoArrayLength ()]
		public construct from_stock (string stock_id);
		[NoArrayLength ()]
		public void set_active (bool is_active);
		public weak bool active { get; set; }
		public signal void toggled ();
	}
	public class Toolbar : Gtk.Container {
		public weak int num_children;
		public weak GLib.List children;
		public weak Gtk.ToolbarStyle style;
		[NoArrayLength ()]
		public int get_drop_index (int x, int y);
		[NoArrayLength ()]
		public Gtk.IconSize get_icon_size ();
		[NoArrayLength ()]
		public int get_item_index (Gtk.ToolItem item);
		[NoArrayLength ()]
		public int get_n_items ();
		[NoArrayLength ()]
		public Gtk.ToolItem get_nth_item (int n);
		[NoArrayLength ()]
		public Gtk.Orientation get_orientation ();
		[NoArrayLength ()]
		public Gtk.ReliefStyle get_relief_style ();
		[NoArrayLength ()]
		public bool get_show_arrow ();
		[NoArrayLength ()]
		public Gtk.ToolbarStyle get_style ();
		[NoArrayLength ()]
		public bool get_tooltips ();
		[NoArrayLength ()]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		public void insert (Gtk.ToolItem item, int pos);
		[NoArrayLength ()]
		public construct ();
		[NoArrayLength ()]
		public void set_drop_highlight_item (Gtk.ToolItem tool_item, int index_);
		[NoArrayLength ()]
		public void set_orientation (Gtk.Orientation orientation);
		[NoArrayLength ()]
		public void set_show_arrow (bool show_arrow);
		[NoArrayLength ()]
		public void set_style (Gtk.ToolbarStyle style);
		[NoArrayLength ()]
		public void set_tooltips (bool enable);
		[NoArrayLength ()]
		public void unset_style ();
		public weak Gtk.Orientation orientation { get; set; }
		[NoAccessorMethod ()]
		public weak Gtk.ToolbarStyle toolbar_style { get; set; }
		public weak bool show_arrow { get; set; }
		public weak bool tooltips { get; set; }
		[NoAccessorMethod ()]
		public weak Gtk.IconSize icon_size { get; set; }
		[NoAccessorMethod ()]
		public weak bool icon_size_set { get; set; }
		public signal void orientation_changed (Gtk.Orientation orientation);
		public signal void style_changed (Gtk.ToolbarStyle style);
		public signal bool popup_context_menu (int x, int y, int button_number);
	}
	public class Tooltips : Gtk.Object {
		[NoArrayLength ()]
		public void disable ();
		[NoArrayLength ()]
		public void enable ();
		[NoArrayLength ()]
		public void force_window ();
		[NoArrayLength ()]
		public static bool get_info_from_tip_window (Gtk.Window tip_window, Gtk.Tooltips tooltips, Gtk.Widget current_widget);
		[NoArrayLength ()]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		public construct ();
		[NoArrayLength ()]
		public void set_tip (Gtk.Widget widget, string tip_text, string tip_private);
	}
	public class ToolButton : Gtk.ToolItem {
		[NoArrayLength ()]
		public string get_icon_name ();
		[NoArrayLength ()]
		public Gtk.Widget get_icon_widget ();
		[NoArrayLength ()]
		public string get_label ();
		[NoArrayLength ()]
		public Gtk.Widget get_label_widget ();
		[NoArrayLength ()]
		public string get_stock_id ();
		[NoArrayLength ()]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		public bool get_use_underline ();
		[NoArrayLength ()]
		public construct (Gtk.Widget icon_widget, string label);
		[NoArrayLength ()]
		public construct from_stock (string stock_id);
		[NoArrayLength ()]
		public void set_icon_name (string icon_name);
		[NoArrayLength ()]
		public void set_icon_widget (Gtk.Widget icon_widget);
		[NoArrayLength ()]
		public void set_label (string label);
		[NoArrayLength ()]
		public void set_label_widget (Gtk.Widget label_widget);
		[NoArrayLength ()]
		public void set_stock_id (string stock_id);
		[NoArrayLength ()]
		public void set_use_underline (bool use_underline);
		public weak string label { get; set; }
		public weak bool use_underline { get; set; }
		public weak Gtk.Widget label_widget { get; set; }
		public weak string stock_id { get; set; }
		public weak string icon_name { get; set; }
		public weak Gtk.Widget icon_widget { get; set; }
		public signal void clicked ();
	}
	public class ToolItem : Gtk.Bin {
		[NoArrayLength ()]
		public bool get_expand ();
		[NoArrayLength ()]
		public bool get_homogeneous ();
		[NoArrayLength ()]
		public Gtk.IconSize get_icon_size ();
		[NoArrayLength ()]
		public bool get_is_important ();
		[NoArrayLength ()]
		public Gtk.Orientation get_orientation ();
		[NoArrayLength ()]
		public Gtk.Widget get_proxy_menu_item (string menu_item_id);
		[NoArrayLength ()]
		public Gtk.ReliefStyle get_relief_style ();
		[NoArrayLength ()]
		public Gtk.ToolbarStyle get_toolbar_style ();
		[NoArrayLength ()]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		public bool get_use_drag_window ();
		[NoArrayLength ()]
		public bool get_visible_horizontal ();
		[NoArrayLength ()]
		public bool get_visible_vertical ();
		[NoArrayLength ()]
		public construct ();
		[NoArrayLength ()]
		public void rebuild_menu ();
		[NoArrayLength ()]
		public Gtk.Widget retrieve_proxy_menu_item ();
		[NoArrayLength ()]
		public void set_expand (bool expand);
		[NoArrayLength ()]
		public void set_homogeneous (bool homogeneous);
		[NoArrayLength ()]
		public void set_is_important (bool is_important);
		[NoArrayLength ()]
		public void set_proxy_menu_item (string menu_item_id, Gtk.Widget menu_item);
		[NoArrayLength ()]
		public void set_use_drag_window (bool use_drag_window);
		[NoArrayLength ()]
		public void set_visible_horizontal (bool visible_horizontal);
		[NoArrayLength ()]
		public void set_visible_vertical (bool visible_vertical);
		public weak bool visible_horizontal { get; set; }
		public weak bool visible_vertical { get; set; }
		public weak bool is_important { get; set; }
		public signal bool create_menu_proxy ();
		public signal void toolbar_reconfigured ();
		[HasEmitter ()]
		public signal bool set_tooltip (Gtk.Tooltips tooltips, string tip_text, string tip_private);
	}
	public class TrayIcon : Gtk.Plug {
		[NoArrayLength ()]
		public static GLib.Type get_type ();
		[NoAccessorMethod ()]
		public weak Gtk.Orientation orientation { get; }
	}
	public class TreeModelFilter : GLib.Object, Gtk.TreeModel, Gtk.TreeDragSource {
		[NoArrayLength ()]
		public void clear_cache ();
		[NoArrayLength ()]
		public bool convert_child_iter_to_iter (Gtk.TreeIter filter_iter, Gtk.TreeIter child_iter);
		[NoArrayLength ()]
		public Gtk.TreePath convert_child_path_to_path (Gtk.TreePath child_path);
		[NoArrayLength ()]
		public void convert_iter_to_child_iter (Gtk.TreeIter child_iter, Gtk.TreeIter filter_iter);
		[NoArrayLength ()]
		public Gtk.TreePath convert_path_to_child_path (Gtk.TreePath filter_path);
		[NoArrayLength ()]
		public Gtk.TreeModel get_model ();
		[NoArrayLength ()]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		public construct (Gtk.TreeModel child_model, Gtk.TreePath root);
		[NoArrayLength ()]
		public void refilter ();
		[NoArrayLength ()]
		public void set_modify_func (int n_columns, GLib.Type types, Gtk.TreeModelFilterModifyFunc func, pointer data, Gtk.DestroyNotify destroy);
		[NoArrayLength ()]
		public void set_visible_column (int column);
		[NoArrayLength ()]
		public void set_visible_func (Gtk.TreeModelFilterVisibleFunc func, pointer data, Gtk.DestroyNotify destroy);
		[NoAccessorMethod ()]
		public weak Gtk.TreeModel child_model { get; construct; }
		[NoAccessorMethod ()]
		public weak Gtk.TreePath virtual_root { get; construct; }
	}
	public class TreeModelSort : GLib.Object, Gtk.TreeModel, Gtk.TreeSortable, Gtk.TreeDragSource {
		[NoArrayLength ()]
		public void clear_cache ();
		[NoArrayLength ()]
		public void convert_child_iter_to_iter (Gtk.TreeIter sort_iter, Gtk.TreeIter child_iter);
		[NoArrayLength ()]
		public Gtk.TreePath convert_child_path_to_path (Gtk.TreePath child_path);
		[NoArrayLength ()]
		public void convert_iter_to_child_iter (Gtk.TreeIter child_iter, Gtk.TreeIter sorted_iter);
		[NoArrayLength ()]
		public Gtk.TreePath convert_path_to_child_path (Gtk.TreePath sorted_path);
		[NoArrayLength ()]
		public Gtk.TreeModel get_model ();
		[NoArrayLength ()]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		public bool iter_is_valid (Gtk.TreeIter iter);
		[NoArrayLength ()]
		public construct with_model (Gtk.TreeModel child_model);
		[NoArrayLength ()]
		public void reset_default_sort_func ();
		[NoAccessorMethod ()]
		public weak Gtk.TreeModel model { get; construct; }
	}
	public class TreeSelection : GLib.Object {
		[NoArrayLength ()]
		public int count_selected_rows ();
		[NoArrayLength ()]
		public Gtk.SelectionMode get_mode ();
		[NoArrayLength ()]
		public bool get_selected (Gtk.TreeModel model, Gtk.TreeIter iter);
		[NoArrayLength ()]
		public GLib.List get_selected_rows (Gtk.TreeModel model);
		[NoArrayLength ()]
		public Gtk.TreeView get_tree_view ();
		[NoArrayLength ()]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		public pointer get_user_data ();
		[NoArrayLength ()]
		public bool iter_is_selected (Gtk.TreeIter iter);
		[NoArrayLength ()]
		public bool path_is_selected (Gtk.TreePath path);
		[NoArrayLength ()]
		public void select_all ();
		[NoArrayLength ()]
		public void select_iter (Gtk.TreeIter iter);
		[NoArrayLength ()]
		public void select_path (Gtk.TreePath path);
		[NoArrayLength ()]
		public void select_range (Gtk.TreePath start_path, Gtk.TreePath end_path);
		[NoArrayLength ()]
		public void selected_foreach (Gtk.TreeSelectionForeachFunc func, pointer data);
		[NoArrayLength ()]
		public void set_mode (Gtk.SelectionMode type);
		[NoArrayLength ()]
		public void set_select_function (Gtk.TreeSelectionFunc func, pointer data, Gtk.DestroyNotify destroy);
		[NoArrayLength ()]
		public void unselect_all ();
		[NoArrayLength ()]
		public void unselect_iter (Gtk.TreeIter iter);
		[NoArrayLength ()]
		public void unselect_path (Gtk.TreePath path);
		[NoArrayLength ()]
		public void unselect_range (Gtk.TreePath start_path, Gtk.TreePath end_path);
		public signal void changed ();
	}
	public class TreeStore : GLib.Object, Gtk.TreeModel, Gtk.TreeDragSource, Gtk.TreeDragDest, Gtk.TreeSortable {
		[NoArrayLength ()]
		public void append (Gtk.TreeIter iter, Gtk.TreeIter parent);
		[NoArrayLength ()]
		public void clear ();
		[NoArrayLength ()]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		public void insert (Gtk.TreeIter iter, Gtk.TreeIter parent, int position);
		[NoArrayLength ()]
		public void insert_after (Gtk.TreeIter iter, Gtk.TreeIter parent, Gtk.TreeIter sibling);
		[NoArrayLength ()]
		public void insert_before (Gtk.TreeIter iter, Gtk.TreeIter parent, Gtk.TreeIter sibling);
		[NoArrayLength ()]
		public void insert_with_values (Gtk.TreeIter iter, Gtk.TreeIter parent, int position);
		[NoArrayLength ()]
		public void insert_with_valuesv (Gtk.TreeIter iter, Gtk.TreeIter parent, int position, int columns, GLib.Value values, int n_values);
		[NoArrayLength ()]
		public bool is_ancestor (Gtk.TreeIter iter, Gtk.TreeIter descendant);
		[NoArrayLength ()]
		public int iter_depth (Gtk.TreeIter iter);
		[NoArrayLength ()]
		public bool iter_is_valid (Gtk.TreeIter iter);
		[NoArrayLength ()]
		public void move_after (Gtk.TreeIter iter, Gtk.TreeIter position);
		[NoArrayLength ()]
		public void move_before (Gtk.TreeIter iter, Gtk.TreeIter position);
		[NoArrayLength ()]
		public construct (int n_columns);
		[NoArrayLength ()]
		public construct newv (int n_columns, GLib.Type types);
		[NoArrayLength ()]
		public void prepend (Gtk.TreeIter iter, Gtk.TreeIter parent);
		[NoArrayLength ()]
		public bool remove (Gtk.TreeIter iter);
		[NoArrayLength ()]
		public void reorder (Gtk.TreeIter parent, int new_order);
		[NoArrayLength ()]
		public void @set (Gtk.TreeIter iter);
		[NoArrayLength ()]
		public void set_column_types (int n_columns, GLib.Type types);
		[NoArrayLength ()]
		public void set_valist (Gtk.TreeIter iter, pointer var_args);
		[NoArrayLength ()]
		public void set_value (Gtk.TreeIter iter, int column, GLib.Value value);
		[NoArrayLength ()]
		public void swap (Gtk.TreeIter a, Gtk.TreeIter b);
	}
	public class TreeView : Gtk.Container {
		[NoArrayLength ()]
		public int append_column (Gtk.TreeViewColumn column);
		[NoArrayLength ()]
		public void collapse_all ();
		[NoArrayLength ()]
		public bool collapse_row (Gtk.TreePath path);
		[NoArrayLength ()]
		public void columns_autosize ();
		[NoArrayLength ()]
		public Gdk.Pixmap create_row_drag_icon (Gtk.TreePath path);
		[NoArrayLength ()]
		public void enable_model_drag_dest (Gtk.TargetEntry targets, int n_targets, Gdk.DragAction actions);
		[NoArrayLength ()]
		public void enable_model_drag_source (Gdk.ModifierType start_button_mask, Gtk.TargetEntry targets, int n_targets, Gdk.DragAction actions);
		[NoArrayLength ()]
		public void expand_all ();
		[NoArrayLength ()]
		public bool expand_row (Gtk.TreePath path, bool open_all);
		[NoArrayLength ()]
		public void expand_to_path (Gtk.TreePath path);
		[NoArrayLength ()]
		public void get_background_area (Gtk.TreePath path, Gtk.TreeViewColumn column, Gdk.Rectangle rect);
		[NoArrayLength ()]
		public Gdk.Window get_bin_window ();
		[NoArrayLength ()]
		public void get_cell_area (Gtk.TreePath path, Gtk.TreeViewColumn column, Gdk.Rectangle rect);
		[NoArrayLength ()]
		public Gtk.TreeViewColumn get_column (int n);
		[NoArrayLength ()]
		public GLib.List get_columns ();
		[NoArrayLength ()]
		public void get_cursor (Gtk.TreePath path, Gtk.TreeViewColumn focus_column);
		[NoArrayLength ()]
		public bool get_dest_row_at_pos (int drag_x, int drag_y, Gtk.TreePath path, Gtk.TreeViewDropPosition pos);
		[NoArrayLength ()]
		public void get_drag_dest_row (Gtk.TreePath path, Gtk.TreeViewDropPosition pos);
		[NoArrayLength ()]
		public bool get_enable_search ();
		[NoArrayLength ()]
		public bool get_enable_tree_lines ();
		[NoArrayLength ()]
		public Gtk.TreeViewColumn get_expander_column ();
		[NoArrayLength ()]
		public bool get_fixed_height_mode ();
		[NoArrayLength ()]
		public Gtk.TreeViewGridLines get_grid_lines ();
		[NoArrayLength ()]
		public Gtk.Adjustment get_hadjustment ();
		[NoArrayLength ()]
		public bool get_headers_clickable ();
		[NoArrayLength ()]
		public bool get_headers_visible ();
		[NoArrayLength ()]
		public bool get_hover_expand ();
		[NoArrayLength ()]
		public bool get_hover_selection ();
		[NoArrayLength ()]
		public Gtk.TreeModel get_model ();
		[NoArrayLength ()]
		public bool get_path_at_pos (int x, int y, Gtk.TreePath path, Gtk.TreeViewColumn column, int cell_x, int cell_y);
		[NoArrayLength ()]
		public bool get_reorderable ();
		[NoArrayLength ()]
		public Gtk.TreeViewRowSeparatorFunc get_row_separator_func ();
		[NoArrayLength ()]
		public bool get_rubber_banding ();
		[NoArrayLength ()]
		public bool get_rules_hint ();
		[NoArrayLength ()]
		public int get_search_column ();
		[NoArrayLength ()]
		public Gtk.Entry get_search_entry ();
		[NoArrayLength ()]
		public Gtk.TreeViewSearchEqualFunc get_search_equal_func ();
		[NoArrayLength ()]
		public Gtk.TreeViewSearchPositionFunc get_search_position_func ();
		[NoArrayLength ()]
		public Gtk.TreeSelection get_selection ();
		[NoArrayLength ()]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		public Gtk.Adjustment get_vadjustment ();
		[NoArrayLength ()]
		public bool get_visible_range (Gtk.TreePath start_path, Gtk.TreePath end_path);
		[NoArrayLength ()]
		public void get_visible_rect (Gdk.Rectangle visible_rect);
		[NoArrayLength ()]
		public int insert_column (Gtk.TreeViewColumn column, int position);
		[NoArrayLength ()]
		public int insert_column_with_attributes (int position, string title, Gtk.CellRenderer cell, ...);
		[NoArrayLength ()]
		public int insert_column_with_data_func (int position, string title, Gtk.CellRenderer cell, Gtk.TreeCellDataFunc func, pointer data, GLib.DestroyNotify dnotify);
		[NoArrayLength ()]
		public void map_expanded_rows (Gtk.TreeViewMappingFunc func, pointer data);
		[NoArrayLength ()]
		public static GLib.Type mode_get_type ();
		[NoArrayLength ()]
		public void move_column_after (Gtk.TreeViewColumn column, Gtk.TreeViewColumn base_column);
		[NoArrayLength ()]
		public construct ();
		[NoArrayLength ()]
		public construct with_model (Gtk.TreeModel model);
		[NoArrayLength ()]
		public int remove_column (Gtk.TreeViewColumn column);
		[NoArrayLength ()]
		public void scroll_to_cell (Gtk.TreePath path, Gtk.TreeViewColumn column, bool use_align, float row_align, float col_align);
		[NoArrayLength ()]
		public void scroll_to_point (int tree_x, int tree_y);
		[NoArrayLength ()]
		public void set_column_drag_function (Gtk.TreeViewColumnDropFunc func, pointer user_data, Gtk.DestroyNotify destroy);
		[NoArrayLength ()]
		public void set_cursor (Gtk.TreePath path, Gtk.TreeViewColumn focus_column, bool start_editing);
		[NoArrayLength ()]
		public void set_cursor_on_cell (Gtk.TreePath path, Gtk.TreeViewColumn focus_column, Gtk.CellRenderer focus_cell, bool start_editing);
		[NoArrayLength ()]
		public void set_destroy_count_func (Gtk.TreeDestroyCountFunc func, pointer data, Gtk.DestroyNotify destroy);
		[NoArrayLength ()]
		public void set_drag_dest_row (Gtk.TreePath path, Gtk.TreeViewDropPosition pos);
		[NoArrayLength ()]
		public void set_enable_search (bool enable_search);
		[NoArrayLength ()]
		public void set_enable_tree_lines (bool enabled);
		[NoArrayLength ()]
		public void set_expander_column (Gtk.TreeViewColumn column);
		[NoArrayLength ()]
		public void set_fixed_height_mode (bool enable);
		[NoArrayLength ()]
		public void set_grid_lines (Gtk.TreeViewGridLines grid_lines);
		[NoArrayLength ()]
		public void set_hadjustment (Gtk.Adjustment adjustment);
		[NoArrayLength ()]
		public void set_headers_clickable (bool setting);
		[NoArrayLength ()]
		public void set_headers_visible (bool headers_visible);
		[NoArrayLength ()]
		public void set_hover_expand (bool expand);
		[NoArrayLength ()]
		public void set_hover_selection (bool hover);
		[NoArrayLength ()]
		public void set_model (Gtk.TreeModel model);
		[NoArrayLength ()]
		public void set_reorderable (bool reorderable);
		[NoArrayLength ()]
		public void set_row_separator_func (Gtk.TreeViewRowSeparatorFunc func, pointer data, Gtk.DestroyNotify destroy);
		[NoArrayLength ()]
		public void set_rubber_banding (bool enable);
		[NoArrayLength ()]
		public void set_rules_hint (bool setting);
		[NoArrayLength ()]
		public void set_search_column (int column);
		[NoArrayLength ()]
		public void set_search_entry (Gtk.Entry entry);
		[NoArrayLength ()]
		public void set_search_equal_func (Gtk.TreeViewSearchEqualFunc search_equal_func, pointer search_user_data, Gtk.DestroyNotify search_destroy);
		[NoArrayLength ()]
		public void set_search_position_func (Gtk.TreeViewSearchPositionFunc func, pointer data, GLib.DestroyNotify destroy);
		[NoArrayLength ()]
		public void set_vadjustment (Gtk.Adjustment adjustment);
		[NoArrayLength ()]
		public void tree_to_widget_coords (int tx, int ty, int wx, int wy);
		[NoArrayLength ()]
		public void unset_rows_drag_dest ();
		[NoArrayLength ()]
		public void unset_rows_drag_source ();
		[NoArrayLength ()]
		public void widget_to_tree_coords (int wx, int wy, int tx, int ty);
		public weak Gtk.TreeModel model { get; set; }
		public weak Gtk.Adjustment hadjustment { get; set; }
		public weak Gtk.Adjustment vadjustment { get; set; }
		public weak bool headers_visible { get; set; }
		public weak bool headers_clickable { get; set; }
		public weak Gtk.TreeViewColumn expander_column { get; set; }
		public weak bool reorderable { get; set; }
		public weak bool rules_hint { get; set; }
		public weak bool enable_search { get; set; }
		public weak int search_column { get; set; }
		public weak bool fixed_height_mode { get; set; }
		public weak bool hover_selection { get; set; }
		public weak bool hover_expand { get; set; }
		[NoAccessorMethod ()]
		public weak bool show_expanders { get; set; }
		[NoAccessorMethod ()]
		public weak int level_indentation { get; set; }
		public weak bool rubber_banding { get; set; }
		[NoAccessorMethod ()]
		public weak Gtk.TreeViewGridLines enable_grid_lines { get; set; }
		public weak bool enable_tree_lines { get; set; }
		public signal void set_scroll_adjustments (Gtk.Adjustment hadjustment, Gtk.Adjustment vadjustment);
		[HasEmitter ()]
		public signal void row_activated (Gtk.TreePath path, Gtk.TreeViewColumn column);
		public signal bool test_expand_row (Gtk.TreeIter iter, Gtk.TreePath path);
		public signal bool test_collapse_row (Gtk.TreeIter iter, Gtk.TreePath path);
		[HasEmitter ()]
		public signal void row_expanded (Gtk.TreeIter iter, Gtk.TreePath path);
		public signal void row_collapsed (Gtk.TreeIter iter, Gtk.TreePath path);
		public signal void columns_changed ();
		public signal void cursor_changed ();
		public signal bool move_cursor (Gtk.MovementStep step, int count);
		public signal bool select_all ();
		public signal bool unselect_all ();
		public signal bool select_cursor_row (bool start_editing);
		public signal bool toggle_cursor_row ();
		public signal bool expand_collapse_cursor_row (bool logical, bool expand, bool open_all);
		public signal bool select_cursor_parent ();
		public signal bool start_interactive_search ();
	}
	public class TreeViewColumn : Gtk.Object, Gtk.CellLayout {
		[NoArrayLength ()]
		public void add_attribute (Gtk.CellRenderer cell_renderer, string attribute, int column);
		[NoArrayLength ()]
		public bool cell_get_position (Gtk.CellRenderer cell_renderer, int start_pos, int width);
		[NoArrayLength ()]
		public void cell_get_size (Gdk.Rectangle cell_area, int x_offset, int y_offset, int width, int height);
		[NoArrayLength ()]
		public bool cell_is_visible ();
		[NoArrayLength ()]
		public void cell_set_cell_data (Gtk.TreeModel tree_model, Gtk.TreeIter iter, bool is_expander, bool is_expanded);
		[NoArrayLength ()]
		public void clear ();
		[NoArrayLength ()]
		public void clear_attributes (Gtk.CellRenderer cell_renderer);
		[NoArrayLength ()]
		public void focus_cell (Gtk.CellRenderer cell);
		[NoArrayLength ()]
		public float get_alignment ();
		[NoArrayLength ()]
		public GLib.List get_cell_renderers ();
		[NoArrayLength ()]
		public bool get_clickable ();
		[NoArrayLength ()]
		public bool get_expand ();
		[NoArrayLength ()]
		public int get_fixed_width ();
		[NoArrayLength ()]
		public int get_max_width ();
		[NoArrayLength ()]
		public int get_min_width ();
		[NoArrayLength ()]
		public bool get_reorderable ();
		[NoArrayLength ()]
		public bool get_resizable ();
		[NoArrayLength ()]
		public Gtk.TreeViewColumnSizing get_sizing ();
		[NoArrayLength ()]
		public int get_sort_column_id ();
		[NoArrayLength ()]
		public bool get_sort_indicator ();
		[NoArrayLength ()]
		public Gtk.SortType get_sort_order ();
		[NoArrayLength ()]
		public int get_spacing ();
		[NoArrayLength ()]
		public string get_title ();
		[NoArrayLength ()]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		public bool get_visible ();
		[NoArrayLength ()]
		public Gtk.Widget get_widget ();
		[NoArrayLength ()]
		public int get_width ();
		[NoArrayLength ()]
		public construct ();
		[NoArrayLength ()]
		public construct with_attributes (string title, Gtk.CellRenderer cell, ...);
		[NoArrayLength ()]
		public void pack_end (Gtk.CellRenderer cell, bool expand);
		[NoArrayLength ()]
		public void pack_start (Gtk.CellRenderer cell, bool expand);
		[NoArrayLength ()]
		public void queue_resize ();
		[NoArrayLength ()]
		public void set_alignment (float xalign);
		[NoArrayLength ()]
		public void set_attributes (Gtk.CellRenderer cell_renderer);
		[NoArrayLength ()]
		public void set_cell_data_func (Gtk.CellRenderer cell_renderer, Gtk.TreeCellDataFunc func, pointer func_data, Gtk.DestroyNotify destroy);
		[NoArrayLength ()]
		public void set_clickable (bool clickable);
		[NoArrayLength ()]
		public void set_expand (bool expand);
		[NoArrayLength ()]
		public void set_fixed_width (int fixed_width);
		[NoArrayLength ()]
		public void set_max_width (int max_width);
		[NoArrayLength ()]
		public void set_min_width (int min_width);
		[NoArrayLength ()]
		public void set_reorderable (bool reorderable);
		[NoArrayLength ()]
		public void set_resizable (bool resizable);
		[NoArrayLength ()]
		public void set_sizing (Gtk.TreeViewColumnSizing type);
		[NoArrayLength ()]
		public void set_sort_column_id (int sort_column_id);
		[NoArrayLength ()]
		public void set_sort_indicator (bool setting);
		[NoArrayLength ()]
		public void set_sort_order (Gtk.SortType order);
		[NoArrayLength ()]
		public void set_spacing (int spacing);
		[NoArrayLength ()]
		public void set_title (string title);
		[NoArrayLength ()]
		public void set_visible (bool visible);
		[NoArrayLength ()]
		public void set_widget (Gtk.Widget widget);
		public weak bool visible { get; set; }
		public weak bool resizable { get; set; }
		public weak int width { get; }
		public weak int spacing { get; set; }
		public weak Gtk.TreeViewColumnSizing sizing { get; set; }
		public weak int fixed_width { get; set; }
		public weak int min_width { get; set; }
		public weak int max_width { get; set; }
		public weak string title { get; set; }
		public weak bool expand { get; set; }
		public weak bool clickable { get; set; }
		public weak Gtk.Widget widget { get; set; }
		public weak float alignment { get; set; }
		public weak bool reorderable { get; set; }
		public weak bool sort_indicator { get; set; }
		public weak Gtk.SortType sort_order { get; set; }
		[HasEmitter ()]
		public signal void clicked ();
	}
	public class UIManager : GLib.Object {
		[NoArrayLength ()]
		public void add_ui (uint merge_id, string path, string name, string action, Gtk.UIManagerItemType type, bool top);
		[NoArrayLength ()]
		public uint add_ui_from_file (string filename, GLib.Error error);
		[NoArrayLength ()]
		public uint add_ui_from_string (string buffer, long length, GLib.Error error);
		[NoArrayLength ()]
		public void ensure_update ();
		[NoArrayLength ()]
		public Gtk.AccelGroup get_accel_group ();
		[NoArrayLength ()]
		public virtual Gtk.Action get_action (string path);
		[NoArrayLength ()]
		public GLib.List get_action_groups ();
		[NoArrayLength ()]
		public bool get_add_tearoffs ();
		[NoArrayLength ()]
		public GLib.SList get_toplevels (Gtk.UIManagerItemType types);
		[NoArrayLength ()]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		public string get_ui ();
		[NoArrayLength ()]
		public virtual Gtk.Widget get_widget (string path);
		[NoArrayLength ()]
		public void insert_action_group (Gtk.ActionGroup action_group, int pos);
		[NoArrayLength ()]
		public construct ();
		[NoArrayLength ()]
		public construct merge_id ();
		[NoArrayLength ()]
		public void remove_action_group (Gtk.ActionGroup action_group);
		[NoArrayLength ()]
		public void remove_ui (uint merge_id);
		[NoArrayLength ()]
		public void set_add_tearoffs (bool add_tearoffs);
		public weak bool add_tearoffs { get; set; }
		public weak string ui { get; }
		public signal void add_widget (Gtk.Widget widget);
		public signal void actions_changed ();
		public signal void connect_proxy (Gtk.Action action, Gtk.Widget proxy);
		public signal void disconnect_proxy (Gtk.Action action, Gtk.Widget proxy);
		public signal void pre_activate (Gtk.Action action);
		public signal void post_activate (Gtk.Action action);
	}
	public class VBox : Gtk.Box {
		[NoArrayLength ()]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		public construct (bool homogeneous, int spacing);
	}
	public class VButtonBox : Gtk.ButtonBox {
		[NoArrayLength ()]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		public construct ();
	}
	public class Viewport : Gtk.Bin {
		[NoArrayLength ()]
		public Gtk.Adjustment get_hadjustment ();
		[NoArrayLength ()]
		public Gtk.ShadowType get_shadow_type ();
		[NoArrayLength ()]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		public Gtk.Adjustment get_vadjustment ();
		[NoArrayLength ()]
		public construct (Gtk.Adjustment hadjustment, Gtk.Adjustment vadjustment);
		[NoArrayLength ()]
		public void set_hadjustment (Gtk.Adjustment adjustment);
		[NoArrayLength ()]
		public void set_shadow_type (Gtk.ShadowType type);
		[NoArrayLength ()]
		public void set_vadjustment (Gtk.Adjustment adjustment);
		public weak Gtk.Adjustment hadjustment { get; set construct; }
		public weak Gtk.Adjustment vadjustment { get; set construct; }
		public weak Gtk.ShadowType shadow_type { get; set; }
		public signal void set_scroll_adjustments (Gtk.Adjustment hadjustment, Gtk.Adjustment vadjustment);
	}
	public class VPaned : Gtk.Paned {
		[NoArrayLength ()]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		public construct ();
	}
	public class VRuler : Gtk.Ruler {
		[NoArrayLength ()]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		public construct ();
	}
	public class VScale : Gtk.Scale {
		[NoArrayLength ()]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		public construct (Gtk.Adjustment adjustment);
		[NoArrayLength ()]
		public construct with_range (double min, double max, double step);
	}
	public class VScrollbar : Gtk.Scrollbar {
		[NoArrayLength ()]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		public construct (Gtk.Adjustment adjustment);
	}
	public class VSeparator : Gtk.Separator {
		[NoArrayLength ()]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		public construct ();
	}
	public class Widget : Gtk.Object, Atk.Implementor {
		public weak Gtk.Requisition requisition;
		public weak pointer allocation;
		public weak Gdk.Window window;
		[NoArrayLength ()]
		public bool activate ();
		[NoArrayLength ()]
		public void add_accelerator (string accel_signal, Gtk.AccelGroup accel_group, uint accel_key, Gdk.ModifierType accel_mods, Gtk.AccelFlags accel_flags);
		[NoArrayLength ()]
		public void add_events (int events);
		[NoArrayLength ()]
		public void add_mnemonic_label (Gtk.Widget label);
		[NoArrayLength ()]
		public bool child_focus (Gtk.DirectionType direction);
		[NoArrayLength ()]
		public static GLib.ParamSpec class_find_style_property (pointer klass, string property_name);
		[NoArrayLength ()]
		public static void class_install_style_property (pointer klass, GLib.ParamSpec pspec);
		[NoArrayLength ()]
		public static void class_install_style_property_parser (pointer klass, GLib.ParamSpec pspec, Gtk.RcPropertyParser parser);
		[NoArrayLength ()]
		public static GLib.ParamSpec class_list_style_properties (pointer klass, uint n_properties);
		[NoArrayLength ()]
		public void class_path (uint path_length, string path, string path_reversed);
		[NoArrayLength ()]
		public Pango.Context create_pango_context ();
		[NoArrayLength ()]
		public Pango.Layout create_pango_layout (string text);
		[NoArrayLength ()]
		public void destroyed (Gtk.Widget widget_pointer);
		[NoArrayLength ()]
		public void ensure_style ();
		[NoArrayLength ()]
		public void freeze_child_notify ();
		[NoArrayLength ()]
		public virtual Atk.Object get_accessible ();
		[NoArrayLength ()]
		public Gtk.Action get_action ();
		[NoArrayLength ()]
		public Gtk.Widget get_ancestor (GLib.Type widget_type);
		[NoArrayLength ()]
		public void get_child_requisition (Gtk.Requisition requisition);
		[NoArrayLength ()]
		public bool get_child_visible ();
		[NoArrayLength ()]
		public Gtk.Clipboard get_clipboard (Gdk.Atom selection);
		[NoArrayLength ()]
		public Gdk.Colormap get_colormap ();
		[NoArrayLength ()]
		public string get_composite_name ();
		[NoArrayLength ()]
		public static Gdk.Colormap get_default_colormap ();
		[NoArrayLength ()]
		public static Gtk.TextDirection get_default_direction ();
		[NoArrayLength ()]
		public static Gtk.Style get_default_style ();
		[NoArrayLength ()]
		public static Gdk.Visual get_default_visual ();
		[NoArrayLength ()]
		public Gtk.TextDirection get_direction ();
		[NoArrayLength ()]
		public Gdk.Display get_display ();
		[NoArrayLength ()]
		public int get_events ();
		[NoArrayLength ()]
		public Gdk.ExtensionMode get_extension_events ();
		[NoArrayLength ()]
		public Gtk.RcStyle get_modifier_style ();
		[NoArrayLength ()]
		public string get_name ();
		[NoArrayLength ()]
		public bool get_no_show_all ();
		[NoArrayLength ()]
		public Pango.Context get_pango_context ();
		[NoArrayLength ()]
		public Gtk.Widget get_parent ();
		[NoArrayLength ()]
		public Gdk.Window get_parent_window ();
		[NoArrayLength ()]
		public void get_pointer (int x, int y);
		[NoArrayLength ()]
		public Gdk.Window get_root_window ();
		[NoArrayLength ()]
		public Gdk.Screen get_screen ();
		[NoArrayLength ()]
		public Gtk.Settings get_settings ();
		[NoArrayLength ()]
		public void get_size_request (int width, int height);
		[NoArrayLength ()]
		public Gtk.Style get_style ();
		[NoArrayLength ()]
		public Gtk.Widget get_toplevel ();
		[NoArrayLength ()]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		public Gdk.Visual get_visual ();
		[NoArrayLength ()]
		public void grab_default ();
		[NoArrayLength ()]
		public bool has_screen ();
		[NoArrayLength ()]
		public virtual void hide_all ();
		[NoArrayLength ()]
		public bool hide_on_delete ();
		[NoArrayLength ()]
		public void input_shape_combine_mask (Gdk.Bitmap shape_mask, int offset_x, int offset_y);
		[NoArrayLength ()]
		public bool intersect (Gdk.Rectangle area, Gdk.Rectangle intersection);
		[NoArrayLength ()]
		public bool is_ancestor (Gtk.Widget ancestor);
		[NoArrayLength ()]
		public bool is_composited ();
		[NoArrayLength ()]
		public GLib.List list_accel_closures ();
		[NoArrayLength ()]
		public GLib.List list_mnemonic_labels ();
		[NoArrayLength ()]
		public void modify_base (Gtk.StateType state, Gdk.Color color);
		[NoArrayLength ()]
		public void modify_bg (Gtk.StateType state, Gdk.Color color);
		[NoArrayLength ()]
		public void modify_fg (Gtk.StateType state, Gdk.Color color);
		[NoArrayLength ()]
		public void modify_font (Pango.FontDescription font_desc);
		[NoArrayLength ()]
		public void modify_style (Gtk.RcStyle style);
		[NoArrayLength ()]
		public void modify_text (Gtk.StateType state, Gdk.Color color);
		[NoArrayLength ()]
		public construct (GLib.Type type, string first_property_name);
		[NoArrayLength ()]
		public void path (uint path_length, string path, string path_reversed);
		[NoArrayLength ()]
		public static void pop_colormap ();
		[NoArrayLength ()]
		public static void pop_composite_child ();
		[NoArrayLength ()]
		public static void push_colormap (Gdk.Colormap cmap);
		[NoArrayLength ()]
		public static void push_composite_child ();
		[NoArrayLength ()]
		public void queue_draw ();
		[NoArrayLength ()]
		public void queue_draw_area (int x, int y, int width, int height);
		[NoArrayLength ()]
		public void queue_resize ();
		[NoArrayLength ()]
		public void queue_resize_no_redraw ();
		[NoArrayLength ()]
		public Gtk.Widget @ref ();
		[NoArrayLength ()]
		public Gdk.Region region_intersect (Gdk.Region region);
		[NoArrayLength ()]
		public bool remove_accelerator (Gtk.AccelGroup accel_group, uint accel_key, Gdk.ModifierType accel_mods);
		[NoArrayLength ()]
		public void remove_mnemonic_label (Gtk.Widget label);
		[NoArrayLength ()]
		public Gdk.Pixbuf render_icon (string stock_id, Gtk.IconSize size, string detail);
		[NoArrayLength ()]
		public void reparent (Gtk.Widget new_parent);
		[NoArrayLength ()]
		public void reset_rc_styles ();
		[NoArrayLength ()]
		public void reset_shapes ();
		[NoArrayLength ()]
		public int send_expose (Gdk.Event event);
		[NoArrayLength ()]
		public void set_accel_path (string accel_path, Gtk.AccelGroup accel_group);
		[NoArrayLength ()]
		public void set_app_paintable (bool app_paintable);
		[NoArrayLength ()]
		public void set_child_visible (bool is_visible);
		[NoArrayLength ()]
		public void set_colormap (Gdk.Colormap colormap);
		[NoArrayLength ()]
		public void set_composite_name (string name);
		[NoArrayLength ()]
		public static void set_default_colormap (Gdk.Colormap colormap);
		[NoArrayLength ()]
		public static void set_default_direction (Gtk.TextDirection dir);
		[NoArrayLength ()]
		public void set_direction (Gtk.TextDirection dir);
		[NoArrayLength ()]
		public void set_double_buffered (bool double_buffered);
		[NoArrayLength ()]
		public void set_events (int events);
		[NoArrayLength ()]
		public void set_extension_events (Gdk.ExtensionMode mode);
		[NoArrayLength ()]
		public void set_name (string name);
		[NoArrayLength ()]
		public void set_no_show_all (bool no_show_all);
		[NoArrayLength ()]
		public void set_parent (Gtk.Widget parent);
		[NoArrayLength ()]
		public void set_parent_window (Gdk.Window parent_window);
		[NoArrayLength ()]
		public void set_redraw_on_allocate (bool redraw_on_allocate);
		[NoArrayLength ()]
		public bool set_scroll_adjustments (Gtk.Adjustment hadjustment, Gtk.Adjustment vadjustment);
		[NoArrayLength ()]
		public void set_sensitive (bool sensitive);
		[NoArrayLength ()]
		public void set_size_request (int width, int height);
		[NoArrayLength ()]
		public void set_state (Gtk.StateType state);
		[NoArrayLength ()]
		public void set_style (Gtk.Style style);
		[NoArrayLength ()]
		public void shape_combine_mask (Gdk.Bitmap shape_mask, int offset_x, int offset_y);
		[NoArrayLength ()]
		public virtual void show_all ();
		[NoArrayLength ()]
		public void show_now ();
		[NoArrayLength ()]
		public void style_get (string first_property_name);
		[NoArrayLength ()]
		public void style_get_property (string property_name, GLib.Value value);
		[NoArrayLength ()]
		public void style_get_valist (string first_property_name, pointer var_args);
		[NoArrayLength ()]
		public void thaw_child_notify ();
		[NoArrayLength ()]
		public bool translate_coordinates (Gtk.Widget dest_widget, int src_x, int src_y, int dest_x, int dest_y);
		[NoArrayLength ()]
		public void unparent ();
		[NoArrayLength ()]
		public void unref ();
		public weak string name { get; set; }
		public weak Gtk.Container parent { get; set; }
		[NoAccessorMethod ()]
		public weak int width_request { get; set; }
		[NoAccessorMethod ()]
		public weak int height_request { get; set; }
		[NoAccessorMethod ()]
		public weak bool visible { get; set; }
		[NoAccessorMethod ()]
		public weak bool sensitive { get; set; }
		[NoAccessorMethod ()]
		public weak bool app_paintable { get; set; }
		[NoAccessorMethod ()]
		public weak bool can_focus { get; set; }
		[NoAccessorMethod ()]
		public weak bool has_focus { get; set; }
		[NoAccessorMethod ()]
		public weak bool is_focus { get; set; }
		[NoAccessorMethod ()]
		public weak bool can_default { get; set; }
		[NoAccessorMethod ()]
		public weak bool has_default { get; set; }
		[NoAccessorMethod ()]
		public weak bool receives_default { get; set; }
		[NoAccessorMethod ()]
		public weak bool composite_child { get; }
		public weak Gtk.Style style { get; set; }
		public weak Gdk.EventMask events { get; set; }
		public weak Gdk.ExtensionMode extension_events { get; set; }
		public weak bool no_show_all { get; set; }
		[HasEmitter ()]
		public signal void show ();
		[HasEmitter ()]
		public signal void hide ();
		[HasEmitter ()]
		public signal void map ();
		[HasEmitter ()]
		public signal void unmap ();
		[HasEmitter ()]
		public signal void realize ();
		[HasEmitter ()]
		public signal void unrealize ();
		[HasEmitter ()]
		public signal void size_request (Gtk.Requisition requisition);
		[HasEmitter ()]
		public signal void size_allocate (pointer allocation);
		public signal void state_changed (Gtk.StateType previous_state);
		public signal void parent_set (Gtk.Widget previous_parent);
		public signal void hierarchy_changed (Gtk.Widget previous_toplevel);
		public signal void style_set (Gtk.Style previous_style);
		public signal void direction_changed (Gtk.TextDirection previous_direction);
		public signal void grab_notify (bool was_grabbed);
		[HasEmitter ()]
		public signal void child_notify (GLib.ParamSpec pspec);
		[HasEmitter ()]
		public signal bool mnemonic_activate (bool group_cycling);
		[HasEmitter ()]
		public signal void grab_focus ();
		public signal bool focus (Gtk.DirectionType direction);
		[HasEmitter ()]
		public signal bool event (Gdk.Event event);
		public signal void event_after (Gdk.Event p0);
		public signal bool button_press_event (Gdk.EventButton event);
		public signal bool button_release_event (Gdk.EventButton event);
		public signal bool scroll_event (Gdk.EventScroll event);
		public signal bool motion_notify_event (Gdk.EventMotion event);
		public signal void composited_changed ();
		public signal bool delete_event (Gdk.EventAny event);
		public signal bool destroy_event (Gdk.EventAny event);
		public signal bool expose_event (Gdk.EventExpose event);
		public signal bool key_press_event (Gdk.EventKey event);
		public signal bool key_release_event (Gdk.EventKey event);
		public signal bool enter_notify_event (Gdk.EventCrossing event);
		public signal bool leave_notify_event (Gdk.EventCrossing event);
		public signal bool configure_event (Gdk.EventConfigure event);
		public signal bool focus_in_event (Gdk.EventFocus event);
		public signal bool focus_out_event (Gdk.EventFocus event);
		public signal bool map_event (Gdk.EventAny event);
		public signal bool unmap_event (Gdk.EventAny event);
		public signal bool property_notify_event (Gdk.EventProperty event);
		public signal bool selection_clear_event (Gdk.EventSelection event);
		public signal bool selection_request_event (Gdk.EventSelection event);
		public signal bool selection_notify_event (Gdk.EventSelection event);
		public signal void selection_received (Gtk.SelectionData selection_data, uint time_);
		public signal void selection_get (Gtk.SelectionData selection_data, uint info, uint time_);
		public signal bool proximity_in_event (Gdk.EventProximity event);
		public signal bool proximity_out_event (Gdk.EventProximity event);
		public signal void drag_leave (Gdk.DragContext context, uint time_);
		public signal void drag_begin (Gdk.DragContext context);
		public signal void drag_end (Gdk.DragContext context);
		public signal void drag_data_delete (Gdk.DragContext context);
		public signal bool drag_motion (Gdk.DragContext context, int x, int y, uint time_);
		public signal bool drag_drop (Gdk.DragContext context, int x, int y, uint time_);
		public signal void drag_data_get (Gdk.DragContext context, Gtk.SelectionData selection_data, uint info, uint time_);
		public signal void drag_data_received (Gdk.DragContext context, int x, int y, Gtk.SelectionData selection_data, uint info, uint time_);
		public signal bool visibility_notify_event (Gdk.EventVisibility event);
		public signal bool client_event (Gdk.EventClient event);
		public signal bool no_expose_event (Gdk.EventAny event);
		public signal bool window_state_event (Gdk.EventWindowState event);
		public signal bool grab_broken_event (Gdk.EventGrabBroken event);
		public signal bool popup_menu ();
		public signal bool show_help (Gtk.WidgetHelpType help_type);
		public signal void accel_closures_changed ();
		public signal void screen_changed (Gdk.Screen previous_screen);
		[HasEmitter ()]
		public signal bool can_activate_accel (uint signal_id);
	}
	public class Win32EmbedWidget : Gtk.Window {
		[NoArrayLength ()]
		public static GLib.Type get_type ();
	}
	public class Window : Gtk.Bin {
		[NoArrayLength ()]
		public bool activate_default ();
		[NoArrayLength ()]
		public bool activate_focus ();
		[NoArrayLength ()]
		public bool activate_key (Gdk.EventKey event);
		[NoArrayLength ()]
		public void add_accel_group (Gtk.AccelGroup accel_group);
		[NoArrayLength ()]
		public void add_embedded_xid (uint xid);
		[NoArrayLength ()]
		public void add_mnemonic (uint keyval, Gtk.Widget target);
		[NoArrayLength ()]
		public void begin_move_drag (int button, int root_x, int root_y, uint timestamp);
		[NoArrayLength ()]
		public void begin_resize_drag (Gdk.WindowEdge edge, int button, int root_x, int root_y, uint timestamp);
		[NoArrayLength ()]
		public void deiconify ();
		[NoArrayLength ()]
		public void fullscreen ();
		[NoArrayLength ()]
		public bool get_accept_focus ();
		[NoArrayLength ()]
		public bool get_decorated ();
		[NoArrayLength ()]
		public static GLib.List get_default_icon_list ();
		[NoArrayLength ()]
		public void get_default_size (int width, int height);
		[NoArrayLength ()]
		public bool get_deletable ();
		[NoArrayLength ()]
		public bool get_destroy_with_parent ();
		[NoArrayLength ()]
		public Gtk.Widget get_focus ();
		[NoArrayLength ()]
		public bool get_focus_on_map ();
		[NoArrayLength ()]
		public void get_frame_dimensions (int left, int top, int right, int bottom);
		[NoArrayLength ()]
		public Gdk.Gravity get_gravity ();
		[NoArrayLength ()]
		public Gtk.WindowGroup get_group ();
		[NoArrayLength ()]
		public bool get_has_frame ();
		[NoArrayLength ()]
		public Gdk.Pixbuf get_icon ();
		[NoArrayLength ()]
		public GLib.List get_icon_list ();
		[NoArrayLength ()]
		public string get_icon_name ();
		[NoArrayLength ()]
		public Gdk.ModifierType get_mnemonic_modifier ();
		[NoArrayLength ()]
		public bool get_modal ();
		[NoArrayLength ()]
		public void get_position (int root_x, int root_y);
		[NoArrayLength ()]
		public bool get_resizable ();
		[NoArrayLength ()]
		public string get_role ();
		[NoArrayLength ()]
		public Gdk.Screen get_screen ();
		[NoArrayLength ()]
		public void get_size (int width, int height);
		[NoArrayLength ()]
		public bool get_skip_pager_hint ();
		[NoArrayLength ()]
		public bool get_skip_taskbar_hint ();
		[NoArrayLength ()]
		public string get_title ();
		[NoArrayLength ()]
		public Gtk.Window get_transient_for ();
		[NoArrayLength ()]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		public Gdk.WindowTypeHint get_type_hint ();
		[NoArrayLength ()]
		public bool get_urgency_hint ();
		[NoArrayLength ()]
		public void iconify ();
		[NoArrayLength ()]
		public static GLib.List list_toplevels ();
		[NoArrayLength ()]
		public void maximize ();
		[NoArrayLength ()]
		public bool mnemonic_activate (uint keyval, Gdk.ModifierType modifier);
		[NoArrayLength ()]
		public void move (int x, int y);
		[NoArrayLength ()]
		public construct (Gtk.WindowType type);
		[NoArrayLength ()]
		public bool parse_geometry (string geometry);
		[NoArrayLength ()]
		public void present ();
		[NoArrayLength ()]
		public void present_with_time (uint timestamp);
		[NoArrayLength ()]
		public bool propagate_key_event (Gdk.EventKey event);
		[NoArrayLength ()]
		public void remove_accel_group (Gtk.AccelGroup accel_group);
		[NoArrayLength ()]
		public void remove_embedded_xid (uint xid);
		[NoArrayLength ()]
		public void remove_mnemonic (uint keyval, Gtk.Widget target);
		[NoArrayLength ()]
		public void reshow_with_initial_size ();
		[NoArrayLength ()]
		public void resize (int width, int height);
		[NoArrayLength ()]
		public void set_accept_focus (bool setting);
		[NoArrayLength ()]
		public static void set_auto_startup_notification (bool setting);
		[NoArrayLength ()]
		public void set_decorated (bool setting);
		[NoArrayLength ()]
		public void set_default (Gtk.Widget default_widget);
		[NoArrayLength ()]
		public static void set_default_icon (Gdk.Pixbuf icon);
		[NoArrayLength ()]
		public static bool set_default_icon_from_file (string filename, GLib.Error err);
		[NoArrayLength ()]
		public static void set_default_icon_list (GLib.List list);
		[NoArrayLength ()]
		public static void set_default_icon_name (string name);
		[NoArrayLength ()]
		public void set_default_size (int width, int height);
		[NoArrayLength ()]
		public void set_deletable (bool setting);
		[NoArrayLength ()]
		public void set_destroy_with_parent (bool setting);
		[NoArrayLength ()]
		public void set_focus_on_map (bool setting);
		[NoArrayLength ()]
		public void set_frame_dimensions (int left, int top, int right, int bottom);
		[NoArrayLength ()]
		public void set_geometry_hints (Gtk.Widget geometry_widget, Gdk.Geometry geometry, Gdk.WindowHints geom_mask);
		[NoArrayLength ()]
		public void set_gravity (Gdk.Gravity gravity);
		[NoArrayLength ()]
		public void set_has_frame (bool setting);
		[NoArrayLength ()]
		public void set_icon (Gdk.Pixbuf icon);
		[NoArrayLength ()]
		public bool set_icon_from_file (string filename, GLib.Error err);
		[NoArrayLength ()]
		public void set_icon_list (GLib.List list);
		[NoArrayLength ()]
		public void set_icon_name (string name);
		[NoArrayLength ()]
		public void set_keep_above (bool setting);
		[NoArrayLength ()]
		public void set_keep_below (bool setting);
		[NoArrayLength ()]
		public void set_mnemonic_modifier (Gdk.ModifierType modifier);
		[NoArrayLength ()]
		public void set_modal (bool modal);
		[NoArrayLength ()]
		public void set_position (Gtk.WindowPosition position);
		[NoArrayLength ()]
		public void set_resizable (bool resizable);
		[NoArrayLength ()]
		public void set_role (string role);
		[NoArrayLength ()]
		public void set_screen (Gdk.Screen screen);
		[NoArrayLength ()]
		public void set_skip_pager_hint (bool setting);
		[NoArrayLength ()]
		public void set_skip_taskbar_hint (bool setting);
		[NoArrayLength ()]
		public void set_title (string title);
		[NoArrayLength ()]
		public void set_transient_for (Gtk.Window parent);
		[NoArrayLength ()]
		public void set_type_hint (Gdk.WindowTypeHint hint);
		[NoArrayLength ()]
		public void set_urgency_hint (bool setting);
		[NoArrayLength ()]
		public void set_wmclass (string wmclass_name, string wmclass_class);
		[NoArrayLength ()]
		public void stick ();
		[NoArrayLength ()]
		public void unfullscreen ();
		[NoArrayLength ()]
		public void unmaximize ();
		[NoArrayLength ()]
		public void unstick ();
		[NoAccessorMethod ()]
		public weak Gtk.WindowType type { get; construct; }
		public weak string title { get; set; }
		public weak string role { get; set; }
		[NoAccessorMethod ()]
		public weak bool allow_shrink { get; set; }
		[NoAccessorMethod ()]
		public weak bool allow_grow { get; set; }
		public weak bool resizable { get; set; }
		public weak bool modal { get; set; }
		[NoAccessorMethod ()]
		public weak Gtk.WindowPosition window_position { get; set; }
		[NoAccessorMethod ()]
		public weak int default_width { get; set; }
		[NoAccessorMethod ()]
		public weak int default_height { get; set; }
		public weak bool destroy_with_parent { get; set; }
		public weak Gdk.Pixbuf icon { get; set; }
		public weak string icon_name { get; set; }
		public weak Gdk.Screen screen { get; set; }
		[NoAccessorMethod ()]
		public weak bool is_active { get; }
		[NoAccessorMethod ()]
		public weak bool has_toplevel_focus { get; }
		public weak Gdk.WindowTypeHint type_hint { get; set; }
		public weak bool skip_taskbar_hint { get; set; }
		public weak bool skip_pager_hint { get; set; }
		public weak bool urgency_hint { get; set; }
		public weak bool accept_focus { get; set; }
		public weak bool focus_on_map { get; set; }
		public weak bool decorated { get; set; }
		public weak bool deletable { get; set; }
		public weak Gdk.Gravity gravity { get; set; }
		public weak Gtk.Window transient_for { get; set construct; }
		[HasEmitter ()]
		public signal void set_focus (Gtk.Widget focus);
		public signal bool frame_event (Gdk.Event event);
		public signal void focus_activated ();
		public signal void default_activated ();
		public signal void move_focus (Gtk.DirectionType direction);
		public signal void keys_changed ();
	}
	public class WindowGroup : GLib.Object {
		[NoArrayLength ()]
		public void add_window (Gtk.Window window);
		[NoArrayLength ()]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		public construct ();
		[NoArrayLength ()]
		public void remove_window (Gtk.Window window);
	}
	public interface CellEditable {
		[NoArrayLength ()]
		public static GLib.Type get_type ();
		[HasEmitter ()]
		public signal void editing_done ();
		[HasEmitter ()]
		public signal void remove_widget ();
	}
	public interface CellLayout {
		[NoArrayLength ()]
		public virtual void add_attribute (Gtk.CellRenderer cell, string attribute, int column);
		[NoArrayLength ()]
		public virtual void clear ();
		[NoArrayLength ()]
		public virtual void clear_attributes (Gtk.CellRenderer cell);
		[NoArrayLength ()]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		public virtual void pack_end (Gtk.CellRenderer cell, bool expand);
		[NoArrayLength ()]
		public virtual void pack_start (Gtk.CellRenderer cell, bool expand);
		[NoArrayLength ()]
		public virtual void reorder (Gtk.CellRenderer cell, int position);
		[NoArrayLength ()]
		public void set_attributes (Gtk.CellRenderer cell);
		[NoArrayLength ()]
		public virtual void set_cell_data_func (Gtk.CellRenderer cell, Gtk.CellLayoutDataFunc func, pointer func_data, GLib.DestroyNotify destroy);
	}
	public interface Editable {
		[NoArrayLength ()]
		public void copy_clipboard ();
		[NoArrayLength ()]
		public void cut_clipboard ();
		[NoArrayLength ()]
		public void delete_selection ();
		[NoArrayLength ()]
		public virtual string get_chars (int start_pos, int end_pos);
		[NoArrayLength ()]
		public bool get_editable ();
		[NoArrayLength ()]
		public virtual int get_position ();
		[NoArrayLength ()]
		public virtual bool get_selection_bounds (int start, int end);
		[NoArrayLength ()]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		public void paste_clipboard ();
		[NoArrayLength ()]
		public void select_region (int start, int end);
		[NoArrayLength ()]
		public void set_editable (bool is_editable);
		[NoArrayLength ()]
		public virtual void set_position (int position);
		[HasEmitter ()]
		public signal void insert_text (string text, int length, int position);
		[HasEmitter ()]
		public signal void delete_text (int start_pos, int end_pos);
		public signal void changed ();
	}
	public interface FileChooser {
		[NoArrayLength ()]
		public void add_filter (Gtk.FileFilter filter);
		[NoArrayLength ()]
		public bool add_shortcut_folder (string folder, GLib.Error error);
		[NoArrayLength ()]
		public bool add_shortcut_folder_uri (string uri, GLib.Error error);
		[NoArrayLength ()]
		public static GLib.Quark error_quark ();
		[NoArrayLength ()]
		public Gtk.FileChooserAction get_action ();
		[NoArrayLength ()]
		public string get_current_folder ();
		[NoArrayLength ()]
		public string get_current_folder_uri ();
		[NoArrayLength ()]
		public bool get_do_overwrite_confirmation ();
		[NoArrayLength ()]
		public Gtk.Widget get_extra_widget ();
		[NoArrayLength ()]
		public string get_filename ();
		[NoArrayLength ()]
		public GLib.SList get_filenames ();
		[NoArrayLength ()]
		public Gtk.FileFilter get_filter ();
		[NoArrayLength ()]
		public bool get_local_only ();
		[NoArrayLength ()]
		public string get_preview_filename ();
		[NoArrayLength ()]
		public string get_preview_uri ();
		[NoArrayLength ()]
		public Gtk.Widget get_preview_widget ();
		[NoArrayLength ()]
		public bool get_preview_widget_active ();
		[NoArrayLength ()]
		public bool get_select_multiple ();
		[NoArrayLength ()]
		public bool get_show_hidden ();
		[NoArrayLength ()]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		public string get_uri ();
		[NoArrayLength ()]
		public GLib.SList get_uris ();
		[NoArrayLength ()]
		public bool get_use_preview_label ();
		[NoArrayLength ()]
		public GLib.SList list_filters ();
		[NoArrayLength ()]
		public GLib.SList list_shortcut_folder_uris ();
		[NoArrayLength ()]
		public GLib.SList list_shortcut_folders ();
		[NoArrayLength ()]
		public void remove_filter (Gtk.FileFilter filter);
		[NoArrayLength ()]
		public bool remove_shortcut_folder (string folder, GLib.Error error);
		[NoArrayLength ()]
		public bool remove_shortcut_folder_uri (string uri, GLib.Error error);
		[NoArrayLength ()]
		public void select_all ();
		[NoArrayLength ()]
		public bool select_filename (string filename);
		[NoArrayLength ()]
		public bool select_uri (string uri);
		[NoArrayLength ()]
		public void set_action (Gtk.FileChooserAction action);
		[NoArrayLength ()]
		public bool set_current_folder (string filename);
		[NoArrayLength ()]
		public bool set_current_folder_uri (string uri);
		[NoArrayLength ()]
		public void set_current_name (string name);
		[NoArrayLength ()]
		public void set_do_overwrite_confirmation (bool do_overwrite_confirmation);
		[NoArrayLength ()]
		public void set_extra_widget (Gtk.Widget extra_widget);
		[NoArrayLength ()]
		public bool set_filename (string filename);
		[NoArrayLength ()]
		public void set_filter (Gtk.FileFilter filter);
		[NoArrayLength ()]
		public void set_local_only (bool local_only);
		[NoArrayLength ()]
		public void set_preview_widget (Gtk.Widget preview_widget);
		[NoArrayLength ()]
		public void set_preview_widget_active (bool active);
		[NoArrayLength ()]
		public void set_select_multiple (bool select_multiple);
		[NoArrayLength ()]
		public void set_show_hidden (bool show_hidden);
		[NoArrayLength ()]
		public bool set_uri (string uri);
		[NoArrayLength ()]
		public void set_use_preview_label (bool use_label);
		[NoArrayLength ()]
		public void unselect_all ();
		[NoArrayLength ()]
		public void unselect_filename (string filename);
		[NoArrayLength ()]
		public void unselect_uri (string uri);
	}
	public interface PrintOperationPreview {
		[NoArrayLength ()]
		public virtual void end_preview ();
		[NoArrayLength ()]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		public virtual bool is_selected (int page_nr);
		[NoArrayLength ()]
		public virtual void render_page (int page_nr);
		public signal void ready (Gtk.PrintContext context);
		public signal void got_page_size (Gtk.PrintContext context, Gtk.PageSetup page_setup);
	}
	public interface RecentChooser {
		[NoArrayLength ()]
		public virtual void add_filter (Gtk.RecentFilter filter);
		[NoArrayLength ()]
		public static GLib.Quark error_quark ();
		[NoArrayLength ()]
		public Gtk.RecentInfo get_current_item ();
		[NoArrayLength ()]
		public virtual string get_current_uri ();
		[NoArrayLength ()]
		public Gtk.RecentFilter get_filter ();
		[NoArrayLength ()]
		public virtual GLib.List get_items ();
		[NoArrayLength ()]
		public int get_limit ();
		[NoArrayLength ()]
		public bool get_local_only ();
		[NoArrayLength ()]
		public bool get_select_multiple ();
		[NoArrayLength ()]
		public bool get_show_icons ();
		[NoArrayLength ()]
		public bool get_show_not_found ();
		[NoArrayLength ()]
		public bool get_show_numbers ();
		[NoArrayLength ()]
		public bool get_show_private ();
		[NoArrayLength ()]
		public bool get_show_tips ();
		[NoArrayLength ()]
		public Gtk.RecentSortType get_sort_type ();
		[NoArrayLength ()]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		public string get_uris (ulong length);
		[NoArrayLength ()]
		public virtual GLib.SList list_filters ();
		[NoArrayLength ()]
		public virtual void remove_filter (Gtk.RecentFilter filter);
		[NoArrayLength ()]
		public virtual void select_all ();
		[NoArrayLength ()]
		public virtual bool select_uri (string uri, GLib.Error error);
		[NoArrayLength ()]
		public virtual bool set_current_uri (string uri, GLib.Error error);
		[NoArrayLength ()]
		public void set_filter (Gtk.RecentFilter filter);
		[NoArrayLength ()]
		public void set_limit (int limit);
		[NoArrayLength ()]
		public void set_local_only (bool local_only);
		[NoArrayLength ()]
		public void set_select_multiple (bool select_multiple);
		[NoArrayLength ()]
		public void set_show_icons (bool show_icons);
		[NoArrayLength ()]
		public void set_show_not_found (bool show_not_found);
		[NoArrayLength ()]
		public void set_show_numbers (bool show_numbers);
		[NoArrayLength ()]
		public void set_show_private (bool show_private);
		[NoArrayLength ()]
		public void set_show_tips (bool show_tips);
		[NoArrayLength ()]
		public virtual void set_sort_func (Gtk.RecentSortFunc sort_func, pointer sort_data, GLib.DestroyNotify data_destroy);
		[NoArrayLength ()]
		public void set_sort_type (Gtk.RecentSortType sort_type);
		[NoArrayLength ()]
		public virtual void unselect_all ();
		[NoArrayLength ()]
		public virtual void unselect_uri (string uri);
		public signal void selection_changed ();
		public signal void item_activated ();
	}
	public interface TreeDragDest {
		[NoArrayLength ()]
		public virtual bool drag_data_received (Gtk.TreePath dest, Gtk.SelectionData selection_data);
		[NoArrayLength ()]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		public virtual bool row_drop_possible (Gtk.TreePath dest_path, Gtk.SelectionData selection_data);
	}
	public interface TreeDragSource {
		[NoArrayLength ()]
		public virtual bool drag_data_delete (Gtk.TreePath path);
		[NoArrayLength ()]
		public virtual bool drag_data_get (Gtk.TreePath path, Gtk.SelectionData selection_data);
		[NoArrayLength ()]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		public virtual bool row_draggable (Gtk.TreePath path);
	}
	public interface TreeModel {
		[NoArrayLength ()]
		public void @foreach (Gtk.TreeModelForeachFunc func, pointer user_data);
		[NoArrayLength ()]
		public void @get (Gtk.TreeIter iter);
		[NoArrayLength ()]
		public virtual GLib.Type get_column_type (int index_);
		[NoArrayLength ()]
		public virtual Gtk.TreeModelFlags get_flags ();
		[NoArrayLength ()]
		public virtual bool get_iter (Gtk.TreeIter iter, Gtk.TreePath path);
		[NoArrayLength ()]
		public bool get_iter_first (Gtk.TreeIter iter);
		[NoArrayLength ()]
		public bool get_iter_from_string (Gtk.TreeIter iter, string path_string);
		[NoArrayLength ()]
		public virtual int get_n_columns ();
		[NoArrayLength ()]
		public virtual Gtk.TreePath get_path (Gtk.TreeIter iter);
		[NoArrayLength ()]
		public string get_string_from_iter (Gtk.TreeIter iter);
		[NoArrayLength ()]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		public void get_valist (Gtk.TreeIter iter, pointer var_args);
		[NoArrayLength ()]
		public virtual void get_value (Gtk.TreeIter iter, int column, GLib.Value value);
		[NoArrayLength ()]
		public virtual bool iter_children (Gtk.TreeIter iter, Gtk.TreeIter parent);
		[NoArrayLength ()]
		public virtual bool iter_has_child (Gtk.TreeIter iter);
		[NoArrayLength ()]
		public virtual int iter_n_children (Gtk.TreeIter iter);
		[NoArrayLength ()]
		public virtual bool iter_next (Gtk.TreeIter iter);
		[NoArrayLength ()]
		public virtual bool iter_nth_child (Gtk.TreeIter iter, Gtk.TreeIter parent, int n);
		[NoArrayLength ()]
		public virtual bool iter_parent (Gtk.TreeIter iter, Gtk.TreeIter child);
		[NoArrayLength ()]
		public virtual void ref_node (Gtk.TreeIter iter);
		[NoArrayLength ()]
		public virtual void unref_node (Gtk.TreeIter iter);
		[HasEmitter ()]
		public signal void row_changed (Gtk.TreePath path, Gtk.TreeIter iter);
		[HasEmitter ()]
		public signal void row_inserted (Gtk.TreePath path, Gtk.TreeIter iter);
		[HasEmitter ()]
		public signal void row_has_child_toggled (Gtk.TreePath path, Gtk.TreeIter iter);
		[HasEmitter ()]
		public signal void row_deleted (Gtk.TreePath path);
		[HasEmitter ()]
		public signal void rows_reordered (Gtk.TreePath path, Gtk.TreeIter iter, int new_order);
	}
	public interface TreeSortable {
		[NoArrayLength ()]
		public virtual bool get_sort_column_id (int sort_column_id, Gtk.SortType order);
		[NoArrayLength ()]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		public virtual bool has_default_sort_func ();
		[NoArrayLength ()]
		public virtual void set_default_sort_func (Gtk.TreeIterCompareFunc sort_func, pointer user_data, Gtk.DestroyNotify destroy);
		[NoArrayLength ()]
		public virtual void set_sort_column_id (int sort_column_id, Gtk.SortType order);
		[NoArrayLength ()]
		public virtual void set_sort_func (int sort_column_id, Gtk.TreeIterCompareFunc sort_func, pointer user_data, Gtk.DestroyNotify destroy);
		[HasEmitter ()]
		public signal void sort_column_changed ();
	}
	[ReferenceType ()]
	public struct AccelGroupEntry {
		public weak Gtk.AccelKey key;
		public weak GLib.Closure closure;
		public weak GLib.Quark accel_path_quark;
	}
	[ReferenceType ()]
	public struct AccelKey {
		public weak uint accel_key;
		public weak Gdk.ModifierType accel_mods;
		public weak uint accel_flags;
	}
	public struct ActionEntry {
		public weak string name;
		public weak string stock_id;
		public weak string label;
		public weak string accelerator;
		public weak string tooltip;
		public weak GLib.Callback @callback;
	}
	[ReferenceType ()]
	public struct BindingArg {
		public weak GLib.Type arg_type;
		public weak long long_data;
	}
	[ReferenceType ()]
	public struct BindingEntry {
		public weak uint keyval;
		public weak Gdk.ModifierType modifiers;
		public weak Gtk.BindingSet binding_set;
		public weak uint destroyed;
		public weak uint in_emission;
		public weak Gtk.BindingEntry set_next;
		public weak Gtk.BindingEntry hash_next;
		public weak Gtk.BindingSignal signals;
		[NoArrayLength ()]
		public static void add_signal (Gtk.BindingSet binding_set, uint keyval, Gdk.ModifierType modifiers, string signal_name, uint n_args);
		[NoArrayLength ()]
		public static void add_signall (Gtk.BindingSet binding_set, uint keyval, Gdk.ModifierType modifiers, string signal_name, GLib.SList binding_args);
		[NoArrayLength ()]
		public static void clear (Gtk.BindingSet binding_set, uint keyval, Gdk.ModifierType modifiers);
		[NoArrayLength ()]
		public static void remove (Gtk.BindingSet binding_set, uint keyval, Gdk.ModifierType modifiers);
	}
	[ReferenceType ()]
	public struct BindingSet {
		public weak string set_name;
		public weak int priority;
		public weak GLib.SList widget_path_pspecs;
		public weak GLib.SList widget_class_pspecs;
		public weak GLib.SList class_branch_pspecs;
		public weak Gtk.BindingEntry entries;
		public weak Gtk.BindingEntry current;
		public weak uint parsed;
		[NoArrayLength ()]
		public bool activate (uint keyval, Gdk.ModifierType modifiers, Gtk.Object object);
		[NoArrayLength ()]
		public void add_path (Gtk.PathType path_type, string path_pattern, Gtk.PathPriorityType priority);
		[NoArrayLength ()]
		public static Gtk.BindingSet by_class (pointer object_class);
		[NoArrayLength ()]
		public static Gtk.BindingSet find (string set_name);
		[NoArrayLength ()]
		public construct (string set_name);
	}
	[ReferenceType ()]
	public struct BindingSignal {
		public weak Gtk.BindingSignal next;
		public weak string signal_name;
		public weak uint n_args;
		public weak Gtk.BindingArg args;
	}
	public struct Border {
		public weak int left;
		public weak int right;
		public weak int top;
		public weak int bottom;
		[NoArrayLength ()]
		[InstanceByReference ()]
		public Gtk.Border copy ();
		[NoArrayLength ()]
		[InstanceByReference ()]
		public void free ();
		[NoArrayLength ()]
		public static GLib.Type get_type ();
	}
	[ReferenceType ()]
	public struct BoxChild {
		public weak Gtk.Widget widget;
		public weak ushort padding;
		public weak uint expand;
		public weak uint fill;
		public weak uint pack;
		public weak uint is_secondary;
	}
	[ReferenceType ()]
	public struct FileFilterInfo {
		public weak Gtk.FileFilterFlags contains;
		public weak string filename;
		public weak string uri;
		public weak string display_name;
		public weak string mime_type;
	}
	[ReferenceType ()]
	public struct FixedChild {
		public weak Gtk.Widget widget;
		public weak int x;
		public weak int y;
	}
	[ReferenceType ()]
	public struct IMContextInfo {
		public weak string context_id;
		public weak string context_name;
		public weak string domain;
		public weak string domain_dirname;
		public weak string default_locales;
	}
	public struct IconInfo {
		[NoArrayLength ()]
		[InstanceByReference ()]
		public Gtk.IconInfo copy ();
		[NoArrayLength ()]
		[InstanceByReference ()]
		public void free ();
		[NoArrayLength ()]
		[InstanceByReference ()]
		public bool get_attach_points (Gdk.Point points, int n_points);
		[NoArrayLength ()]
		[InstanceByReference ()]
		public int get_base_size ();
		[NoArrayLength ()]
		[InstanceByReference ()]
		public Gdk.Pixbuf get_builtin_pixbuf ();
		[NoArrayLength ()]
		[InstanceByReference ()]
		public string get_display_name ();
		[NoArrayLength ()]
		[InstanceByReference ()]
		public bool get_embedded_rect (Gdk.Rectangle rectangle);
		[NoArrayLength ()]
		[InstanceByReference ()]
		public string get_filename ();
		[NoArrayLength ()]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		[InstanceByReference ()]
		public Gdk.Pixbuf load_icon (GLib.Error error);
		[NoArrayLength ()]
		[InstanceByReference ()]
		public void set_raw_coordinates (bool raw_coordinates);
	}
	public struct IconSet {
		[NoArrayLength ()]
		[InstanceByReference ()]
		public void add_source (Gtk.IconSource source);
		[NoArrayLength ()]
		[InstanceByReference ()]
		public Gtk.IconSet copy ();
		[NoArrayLength ()]
		[InstanceByReference ()]
		public void get_sizes (Gtk.IconSize sizes, int n_sizes);
		[NoArrayLength ()]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		public construct ();
		[NoArrayLength ()]
		public construct from_pixbuf (Gdk.Pixbuf pixbuf);
		[NoArrayLength ()]
		[InstanceByReference ()]
		public Gtk.IconSet @ref ();
		[NoArrayLength ()]
		[InstanceByReference ()]
		public Gdk.Pixbuf render_icon (Gtk.Style style, Gtk.TextDirection direction, Gtk.StateType state, Gtk.IconSize size, Gtk.Widget widget, string detail);
		[NoArrayLength ()]
		[InstanceByReference ()]
		public void unref ();
	}
	public struct IconSource {
		[NoArrayLength ()]
		[InstanceByReference ()]
		public Gtk.IconSource copy ();
		[NoArrayLength ()]
		[InstanceByReference ()]
		public void free ();
		[NoArrayLength ()]
		[InstanceByReference ()]
		public Gtk.TextDirection get_direction ();
		[NoArrayLength ()]
		[InstanceByReference ()]
		public bool get_direction_wildcarded ();
		[NoArrayLength ()]
		[InstanceByReference ()]
		public string get_filename ();
		[NoArrayLength ()]
		[InstanceByReference ()]
		public string get_icon_name ();
		[NoArrayLength ()]
		[InstanceByReference ()]
		public Gdk.Pixbuf get_pixbuf ();
		[NoArrayLength ()]
		[InstanceByReference ()]
		public Gtk.IconSize get_size ();
		[NoArrayLength ()]
		[InstanceByReference ()]
		public bool get_size_wildcarded ();
		[NoArrayLength ()]
		[InstanceByReference ()]
		public Gtk.StateType get_state ();
		[NoArrayLength ()]
		[InstanceByReference ()]
		public bool get_state_wildcarded ();
		[NoArrayLength ()]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		public construct ();
		[NoArrayLength ()]
		[InstanceByReference ()]
		public void set_direction (Gtk.TextDirection direction);
		[NoArrayLength ()]
		[InstanceByReference ()]
		public void set_direction_wildcarded (bool setting);
		[NoArrayLength ()]
		[InstanceByReference ()]
		public void set_filename (string filename);
		[NoArrayLength ()]
		[InstanceByReference ()]
		public void set_icon_name (string icon_name);
		[NoArrayLength ()]
		[InstanceByReference ()]
		public void set_pixbuf (Gdk.Pixbuf pixbuf);
		[NoArrayLength ()]
		[InstanceByReference ()]
		public void set_size (Gtk.IconSize size);
		[NoArrayLength ()]
		[InstanceByReference ()]
		public void set_size_wildcarded (bool setting);
		[NoArrayLength ()]
		[InstanceByReference ()]
		public void set_state (Gtk.StateType state);
		[NoArrayLength ()]
		[InstanceByReference ()]
		public void set_state_wildcarded (bool setting);
	}
	[ReferenceType ()]
	public struct ImageAnimationData {
		public weak Gdk.PixbufAnimation anim;
		public weak Gdk.PixbufAnimationIter iter;
		public weak uint frame_timeout;
	}
	[ReferenceType ()]
	public struct ImageIconNameData {
		public weak string icon_name;
		public weak Gdk.Pixbuf pixbuf;
		public weak uint theme_change_id;
	}
	[ReferenceType ()]
	public struct ImageIconSetData {
		public weak Gtk.IconSet icon_set;
	}
	[ReferenceType ()]
	public struct ImageImageData {
		public weak Gdk.Image image;
	}
	[ReferenceType ()]
	public struct ImagePixbufData {
		public weak Gdk.Pixbuf pixbuf;
	}
	[ReferenceType ()]
	public struct ImagePixmapData {
		public weak Gdk.Pixmap pixmap;
	}
	[ReferenceType ()]
	public struct ImageStockData {
		public weak string stock_id;
	}
	[ReferenceType ()]
	public struct KeyHash {
	}
	[ReferenceType ()]
	public struct LabelSelectionInfo {
	}
	[ReferenceType ()]
	public struct MenuEntry {
		public weak string path;
		public weak string accelerator;
		public weak Gtk.MenuCallback @callback;
		public weak pointer callback_data;
		public weak Gtk.Widget widget;
	}
	[ReferenceType ()]
	public struct MnemonicHash {
	}
	[ReferenceType ()]
	public struct NotebookPage {
		[NoArrayLength ()]
		public static int num (Gtk.Notebook notebook, Gtk.Widget child);
	}
	[ReferenceType ()]
	public struct PageRange {
		public weak int start;
		public weak int end;
	}
	public struct PaperSize {
		[NoArrayLength ()]
		[InstanceByReference ()]
		public Gtk.PaperSize copy ();
		[NoArrayLength ()]
		[InstanceByReference ()]
		public void free ();
		[NoArrayLength ()]
		public static string get_default ();
		[NoArrayLength ()]
		[InstanceByReference ()]
		public double get_default_bottom_margin (Gtk.Unit unit);
		[NoArrayLength ()]
		[InstanceByReference ()]
		public double get_default_left_margin (Gtk.Unit unit);
		[NoArrayLength ()]
		[InstanceByReference ()]
		public double get_default_right_margin (Gtk.Unit unit);
		[NoArrayLength ()]
		[InstanceByReference ()]
		public double get_default_top_margin (Gtk.Unit unit);
		[NoArrayLength ()]
		[InstanceByReference ()]
		public string get_display_name ();
		[NoArrayLength ()]
		[InstanceByReference ()]
		public double get_height (Gtk.Unit unit);
		[NoArrayLength ()]
		[InstanceByReference ()]
		public string get_name ();
		[NoArrayLength ()]
		[InstanceByReference ()]
		public string get_ppd_name ();
		[NoArrayLength ()]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		[InstanceByReference ()]
		public double get_width (Gtk.Unit unit);
		[NoArrayLength ()]
		[InstanceByReference ()]
		public bool is_custom ();
		[NoArrayLength ()]
		[InstanceByReference ()]
		public bool is_equal (Gtk.PaperSize size2);
		[NoArrayLength ()]
		public construct (string name);
		[NoArrayLength ()]
		public construct custom (string name, string display_name, double width, double height, Gtk.Unit unit);
		[NoArrayLength ()]
		public construct from_ppd (string ppd_name, string ppd_display_name, double width, double height);
		[NoArrayLength ()]
		[InstanceByReference ()]
		public void set_size (double width, double height, Gtk.Unit unit);
	}
	[ReferenceType ()]
	public struct PrintWin32Devnames {
		public weak string driver;
		public weak string device;
		public weak string output;
		public weak int @flags;
		[NoArrayLength ()]
		public void free ();
		[NoArrayLength ()]
		public static pointer from_printer_name (string printer);
		[NoArrayLength ()]
		public static Gtk.PrintWin32Devnames from_win32 (pointer global);
		[NoArrayLength ()]
		public pointer to_win32 ();
	}
	public struct RadioActionEntry {
		public weak string name;
		public weak string stock_id;
		public weak string label;
		public weak string accelerator;
		public weak string tooltip;
		public weak int value;
	}
	[ReferenceType ()]
	public struct RangeLayout {
	}
	[ReferenceType ()]
	public struct RangeStepTimer {
	}
	[ReferenceType ()]
	public struct RcContext {
	}
	[ReferenceType ()]
	public struct RcProperty {
		public weak GLib.Quark type_name;
		public weak GLib.Quark property_name;
		public weak string origin;
		public weak GLib.Value value;
		[NoArrayLength ()]
		public static bool parse_border (GLib.ParamSpec pspec, GLib.String gstring, GLib.Value property_value);
		[NoArrayLength ()]
		public static bool parse_color (GLib.ParamSpec pspec, GLib.String gstring, GLib.Value property_value);
		[NoArrayLength ()]
		public static bool parse_enum (GLib.ParamSpec pspec, GLib.String gstring, GLib.Value property_value);
		[NoArrayLength ()]
		public static bool parse_flags (GLib.ParamSpec pspec, GLib.String gstring, GLib.Value property_value);
		[NoArrayLength ()]
		public static bool parse_requisition (GLib.ParamSpec pspec, GLib.String gstring, GLib.Value property_value);
	}
	[ReferenceType ()]
	public struct RecentData {
		public weak string display_name;
		public weak string description;
		public weak string mime_type;
		public weak string app_name;
		public weak string app_exec;
		public weak string groups;
		public weak bool is_private;
	}
	[ReferenceType ()]
	public struct RecentFilterInfo {
		public weak Gtk.RecentFilterFlags contains;
		public weak string uri;
		public weak string display_name;
		public weak string mime_type;
		public weak string applications;
		public weak string groups;
		public weak int age;
	}
	public struct RecentInfo {
		[NoArrayLength ()]
		[InstanceByReference ()]
		public bool exists ();
		[NoArrayLength ()]
		[InstanceByReference ()]
		public ulong get_added ();
		[NoArrayLength ()]
		[InstanceByReference ()]
		public int get_age ();
		[NoArrayLength ()]
		[InstanceByReference ()]
		public bool get_application_info (string app_name, string app_exec, uint count, ulong time_);
		[NoArrayLength ()]
		[InstanceByReference ()]
		public string get_applications (ulong length);
		[NoArrayLength ()]
		[InstanceByReference ()]
		public string get_description ();
		[NoArrayLength ()]
		[InstanceByReference ()]
		public string get_display_name ();
		[NoArrayLength ()]
		[InstanceByReference ()]
		public string get_groups (ulong length);
		[NoArrayLength ()]
		[InstanceByReference ()]
		public Gdk.Pixbuf get_icon (int size);
		[NoArrayLength ()]
		[InstanceByReference ()]
		public string get_mime_type ();
		[NoArrayLength ()]
		[InstanceByReference ()]
		public ulong get_modified ();
		[NoArrayLength ()]
		[InstanceByReference ()]
		public bool get_private_hint ();
		[NoArrayLength ()]
		[InstanceByReference ()]
		public string get_short_name ();
		[NoArrayLength ()]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		[InstanceByReference ()]
		public string get_uri ();
		[NoArrayLength ()]
		[InstanceByReference ()]
		public string get_uri_display ();
		[NoArrayLength ()]
		[InstanceByReference ()]
		public ulong get_visited ();
		[NoArrayLength ()]
		[InstanceByReference ()]
		public bool has_application (string app_name);
		[NoArrayLength ()]
		[InstanceByReference ()]
		public bool has_group (string group_name);
		[NoArrayLength ()]
		[InstanceByReference ()]
		public bool is_local ();
		[NoArrayLength ()]
		[InstanceByReference ()]
		public string last_application ();
		[NoArrayLength ()]
		[InstanceByReference ()]
		public bool match (Gtk.RecentInfo info_b);
		[NoArrayLength ()]
		[InstanceByReference ()]
		public Gtk.RecentInfo @ref ();
		[NoArrayLength ()]
		[InstanceByReference ()]
		public void unref ();
	}
	public struct Requisition {
		public weak int width;
		public weak int height;
		[NoArrayLength ()]
		[InstanceByReference ()]
		public Gtk.Requisition copy ();
		[NoArrayLength ()]
		[InstanceByReference ()]
		public void free ();
		[NoArrayLength ()]
		public static GLib.Type get_type ();
	}
	[ReferenceType ()]
	public struct RulerMetric {
		public weak string metric_name;
		public weak string abbrev;
		public weak double pixels_per_unit;
		public weak double ruler_scale;
		public weak int subdivide;
	}
	public struct SelectionData {
		public weak Gdk.Atom selection;
		public weak Gdk.Atom target;
		public weak Gdk.Atom type;
		public weak int format;
		public weak uchar data;
		public weak int length;
		public weak Gdk.Display display;
		[NoArrayLength ()]
		[InstanceByReference ()]
		public Gtk.SelectionData copy ();
		[NoArrayLength ()]
		[InstanceByReference ()]
		public void free ();
		[NoArrayLength ()]
		[InstanceByReference ()]
		public Gdk.Pixbuf get_pixbuf ();
		[NoArrayLength ()]
		[InstanceByReference ()]
		public bool get_targets (Gdk.Atom targets, int n_atoms);
		[NoArrayLength ()]
		[InstanceByReference ()]
		public uchar get_text ();
		[NoArrayLength ()]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		[InstanceByReference ()]
		public string get_uris ();
		[NoArrayLength ()]
		[InstanceByReference ()]
		public void @set (Gdk.Atom type, int format, uchar data, int length);
		[NoArrayLength ()]
		[InstanceByReference ()]
		public bool set_pixbuf (Gdk.Pixbuf pixbuf);
		[NoArrayLength ()]
		[InstanceByReference ()]
		public bool set_text (string str, int len);
		[NoArrayLength ()]
		[InstanceByReference ()]
		public bool set_uris (string uris);
		[NoArrayLength ()]
		[InstanceByReference ()]
		public bool targets_include_image (bool writable);
		[NoArrayLength ()]
		[InstanceByReference ()]
		public bool targets_include_rich_text (Gtk.TextBuffer buffer);
		[NoArrayLength ()]
		[InstanceByReference ()]
		public bool targets_include_text ();
		[NoArrayLength ()]
		[InstanceByReference ()]
		public bool targets_include_uri ();
	}
	[ReferenceType ()]
	public struct SettingsPropertyValue {
	}
	[ReferenceType ()]
	public struct SettingsValue {
		public weak string origin;
		public weak GLib.Value value;
	}
	[ReferenceType ()]
	public struct StockItem {
		public weak string stock_id;
		public weak string label;
		public weak Gdk.ModifierType modifier;
		public weak uint keyval;
		public weak string translation_domain;
		[NoArrayLength ()]
		public Gtk.StockItem copy ();
		[NoArrayLength ()]
		public void free ();
	}
	[ReferenceType ()]
	public struct TableChild {
		public weak Gtk.Widget widget;
		public weak ushort left_attach;
		public weak ushort right_attach;
		public weak ushort top_attach;
		public weak ushort bottom_attach;
		public weak ushort xpadding;
		public weak ushort ypadding;
		public weak uint xexpand;
		public weak uint yexpand;
		public weak uint xshrink;
		public weak uint yshrink;
		public weak uint xfill;
		public weak uint yfill;
	}
	[ReferenceType ()]
	public struct TableRowCol {
		public weak ushort requisition;
		public weak ushort allocation;
		public weak ushort spacing;
		public weak uint need_expand;
		public weak uint need_shrink;
		public weak uint expand;
		public weak uint shrink;
		public weak uint empty;
	}
	[ReferenceType ()]
	public struct TargetEntry {
		public weak string target;
		public weak uint @flags;
		public weak uint info;
	}
	public struct TargetList {
		public weak GLib.List list;
		public weak uint ref_count;
		[NoArrayLength ()]
		[InstanceByReference ()]
		public void add (Gdk.Atom target, uint @flags, uint info);
		[NoArrayLength ()]
		[InstanceByReference ()]
		public void add_image_targets (uint info, bool writable);
		[NoArrayLength ()]
		[InstanceByReference ()]
		public void add_rich_text_targets (uint info, bool deserializable, Gtk.TextBuffer buffer);
		[NoArrayLength ()]
		[InstanceByReference ()]
		public void add_table (Gtk.TargetEntry targets, uint ntargets);
		[NoArrayLength ()]
		[InstanceByReference ()]
		public void add_text_targets (uint info);
		[NoArrayLength ()]
		[InstanceByReference ()]
		public void add_uri_targets (uint info);
		[NoArrayLength ()]
		[InstanceByReference ()]
		public bool find (Gdk.Atom target, uint info);
		[NoArrayLength ()]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		public construct (Gtk.TargetEntry targets, uint ntargets);
		[NoArrayLength ()]
		[InstanceByReference ()]
		public Gtk.TargetList @ref ();
		[NoArrayLength ()]
		[InstanceByReference ()]
		public void remove (Gdk.Atom target);
		[NoArrayLength ()]
		[InstanceByReference ()]
		public void unref ();
	}
	[ReferenceType ()]
	public struct TargetPair {
		public weak Gdk.Atom target;
		public weak uint @flags;
		public weak uint info;
	}
	[ReferenceType ()]
	public struct TextAppearance {
		public weak Gdk.Color bg_color;
		public weak Gdk.Color fg_color;
		public weak Gdk.Bitmap bg_stipple;
		public weak Gdk.Bitmap fg_stipple;
		public weak int rise;
		public weak uint underline;
		public weak uint strikethrough;
		public weak uint draw_bg;
		public weak uint inside_selection;
		public weak uint is_text;
	}
	public struct TextAttributes {
		public weak Gtk.TextAppearance appearance;
		public weak Gtk.Justification justification;
		public weak Gtk.TextDirection direction;
		public weak Pango.FontDescription font;
		public weak double font_scale;
		public weak int left_margin;
		public weak int indent;
		public weak int right_margin;
		public weak int pixels_above_lines;
		public weak int pixels_below_lines;
		public weak int pixels_inside_wrap;
		public weak Pango.TabArray tabs;
		public weak Gtk.WrapMode wrap_mode;
		public weak Pango.Language language;
		public weak uint invisible;
		public weak uint bg_full_height;
		public weak uint editable;
		public weak uint realized;
		[NoArrayLength ()]
		[InstanceByReference ()]
		public Gtk.TextAttributes copy ();
		[NoArrayLength ()]
		[InstanceByReference ()]
		public void copy_values (Gtk.TextAttributes dest);
		[NoArrayLength ()]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		public construct ();
		[NoArrayLength ()]
		[InstanceByReference ()]
		public Gtk.TextAttributes @ref ();
		[NoArrayLength ()]
		[InstanceByReference ()]
		public void unref ();
	}
	[ReferenceType ()]
	public struct TextBTree {
	}
	public struct TextIter {
		[NoArrayLength ()]
		[InstanceByReference ()]
		public bool backward_char ();
		[NoArrayLength ()]
		[InstanceByReference ()]
		public bool backward_chars (int count);
		[NoArrayLength ()]
		[InstanceByReference ()]
		public bool backward_cursor_position ();
		[NoArrayLength ()]
		[InstanceByReference ()]
		public bool backward_cursor_positions (int count);
		[NoArrayLength ()]
		[InstanceByReference ()]
		public bool backward_find_char (Gtk.TextCharPredicate pred, pointer user_data, Gtk.TextIter limit);
		[NoArrayLength ()]
		[InstanceByReference ()]
		public bool backward_line ();
		[NoArrayLength ()]
		[InstanceByReference ()]
		public bool backward_lines (int count);
		[NoArrayLength ()]
		[InstanceByReference ()]
		public bool backward_search (string str, Gtk.TextSearchFlags @flags, Gtk.TextIter match_start, Gtk.TextIter match_end, Gtk.TextIter limit);
		[NoArrayLength ()]
		[InstanceByReference ()]
		public bool backward_sentence_start ();
		[NoArrayLength ()]
		[InstanceByReference ()]
		public bool backward_sentence_starts (int count);
		[NoArrayLength ()]
		[InstanceByReference ()]
		public bool backward_to_tag_toggle (Gtk.TextTag tag);
		[NoArrayLength ()]
		[InstanceByReference ()]
		public bool backward_visible_cursor_position ();
		[NoArrayLength ()]
		[InstanceByReference ()]
		public bool backward_visible_cursor_positions (int count);
		[NoArrayLength ()]
		[InstanceByReference ()]
		public bool backward_visible_line ();
		[NoArrayLength ()]
		[InstanceByReference ()]
		public bool backward_visible_lines (int count);
		[NoArrayLength ()]
		[InstanceByReference ()]
		public bool backward_visible_word_start ();
		[NoArrayLength ()]
		[InstanceByReference ()]
		public bool backward_visible_word_starts (int count);
		[NoArrayLength ()]
		[InstanceByReference ()]
		public bool backward_word_start ();
		[NoArrayLength ()]
		[InstanceByReference ()]
		public bool backward_word_starts (int count);
		[NoArrayLength ()]
		[InstanceByReference ()]
		public bool begins_tag (Gtk.TextTag tag);
		[NoArrayLength ()]
		[InstanceByReference ()]
		public bool can_insert (bool default_editability);
		[NoArrayLength ()]
		[InstanceByReference ()]
		public int compare (Gtk.TextIter rhs);
		[NoArrayLength ()]
		[InstanceByReference ()]
		public Gtk.TextIter copy ();
		[NoArrayLength ()]
		[InstanceByReference ()]
		public bool editable (bool default_setting);
		[NoArrayLength ()]
		[InstanceByReference ()]
		public bool ends_line ();
		[NoArrayLength ()]
		[InstanceByReference ()]
		public bool ends_sentence ();
		[NoArrayLength ()]
		[InstanceByReference ()]
		public bool ends_tag (Gtk.TextTag tag);
		[NoArrayLength ()]
		[InstanceByReference ()]
		public bool ends_word ();
		[NoArrayLength ()]
		[InstanceByReference ()]
		public bool equal (Gtk.TextIter rhs);
		[NoArrayLength ()]
		[InstanceByReference ()]
		public bool forward_char ();
		[NoArrayLength ()]
		[InstanceByReference ()]
		public bool forward_chars (int count);
		[NoArrayLength ()]
		[InstanceByReference ()]
		public bool forward_cursor_position ();
		[NoArrayLength ()]
		[InstanceByReference ()]
		public bool forward_cursor_positions (int count);
		[NoArrayLength ()]
		[InstanceByReference ()]
		public bool forward_find_char (Gtk.TextCharPredicate pred, pointer user_data, Gtk.TextIter limit);
		[NoArrayLength ()]
		[InstanceByReference ()]
		public bool forward_line ();
		[NoArrayLength ()]
		[InstanceByReference ()]
		public bool forward_lines (int count);
		[NoArrayLength ()]
		[InstanceByReference ()]
		public bool forward_search (string str, Gtk.TextSearchFlags @flags, Gtk.TextIter match_start, Gtk.TextIter match_end, Gtk.TextIter limit);
		[NoArrayLength ()]
		[InstanceByReference ()]
		public bool forward_sentence_end ();
		[NoArrayLength ()]
		[InstanceByReference ()]
		public bool forward_sentence_ends (int count);
		[NoArrayLength ()]
		[InstanceByReference ()]
		public void forward_to_end ();
		[NoArrayLength ()]
		[InstanceByReference ()]
		public bool forward_to_line_end ();
		[NoArrayLength ()]
		[InstanceByReference ()]
		public bool forward_to_tag_toggle (Gtk.TextTag tag);
		[NoArrayLength ()]
		[InstanceByReference ()]
		public bool forward_visible_cursor_position ();
		[NoArrayLength ()]
		[InstanceByReference ()]
		public bool forward_visible_cursor_positions (int count);
		[NoArrayLength ()]
		[InstanceByReference ()]
		public bool forward_visible_line ();
		[NoArrayLength ()]
		[InstanceByReference ()]
		public bool forward_visible_lines (int count);
		[NoArrayLength ()]
		[InstanceByReference ()]
		public bool forward_visible_word_end ();
		[NoArrayLength ()]
		[InstanceByReference ()]
		public bool forward_visible_word_ends (int count);
		[NoArrayLength ()]
		[InstanceByReference ()]
		public bool forward_word_end ();
		[NoArrayLength ()]
		[InstanceByReference ()]
		public bool forward_word_ends (int count);
		[NoArrayLength ()]
		[InstanceByReference ()]
		public void free ();
		[NoArrayLength ()]
		[InstanceByReference ()]
		public bool get_attributes (Gtk.TextAttributes values);
		[NoArrayLength ()]
		[InstanceByReference ()]
		public Gtk.TextBuffer get_buffer ();
		[NoArrayLength ()]
		[InstanceByReference ()]
		public int get_bytes_in_line ();
		[NoArrayLength ()]
		[InstanceByReference ()]
		public unichar get_char ();
		[NoArrayLength ()]
		[InstanceByReference ()]
		public int get_chars_in_line ();
		[NoArrayLength ()]
		[InstanceByReference ()]
		public Gtk.TextChildAnchor get_child_anchor ();
		[NoArrayLength ()]
		[InstanceByReference ()]
		public Pango.Language get_language ();
		[NoArrayLength ()]
		[InstanceByReference ()]
		public int get_line ();
		[NoArrayLength ()]
		[InstanceByReference ()]
		public int get_line_index ();
		[NoArrayLength ()]
		[InstanceByReference ()]
		public int get_line_offset ();
		[NoArrayLength ()]
		[InstanceByReference ()]
		public GLib.SList get_marks ();
		[NoArrayLength ()]
		[InstanceByReference ()]
		public int get_offset ();
		[NoArrayLength ()]
		[InstanceByReference ()]
		public Gdk.Pixbuf get_pixbuf ();
		[NoArrayLength ()]
		[InstanceByReference ()]
		public string get_slice (Gtk.TextIter end);
		[NoArrayLength ()]
		[InstanceByReference ()]
		public GLib.SList get_tags ();
		[NoArrayLength ()]
		[InstanceByReference ()]
		public string get_text (Gtk.TextIter end);
		[NoArrayLength ()]
		[InstanceByReference ()]
		public GLib.SList get_toggled_tags (bool toggled_on);
		[NoArrayLength ()]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		[InstanceByReference ()]
		public int get_visible_line_index ();
		[NoArrayLength ()]
		[InstanceByReference ()]
		public int get_visible_line_offset ();
		[NoArrayLength ()]
		[InstanceByReference ()]
		public string get_visible_slice (Gtk.TextIter end);
		[NoArrayLength ()]
		[InstanceByReference ()]
		public string get_visible_text (Gtk.TextIter end);
		[NoArrayLength ()]
		[InstanceByReference ()]
		public bool has_tag (Gtk.TextTag tag);
		[NoArrayLength ()]
		[InstanceByReference ()]
		public bool in_range (Gtk.TextIter start, Gtk.TextIter end);
		[NoArrayLength ()]
		[InstanceByReference ()]
		public bool inside_sentence ();
		[NoArrayLength ()]
		[InstanceByReference ()]
		public bool inside_word ();
		[NoArrayLength ()]
		[InstanceByReference ()]
		public bool is_cursor_position ();
		[NoArrayLength ()]
		[InstanceByReference ()]
		public bool is_end ();
		[NoArrayLength ()]
		[InstanceByReference ()]
		public bool is_start ();
		[NoArrayLength ()]
		[InstanceByReference ()]
		public void order (Gtk.TextIter second);
		[NoArrayLength ()]
		[InstanceByReference ()]
		public void set_line (int line_number);
		[NoArrayLength ()]
		[InstanceByReference ()]
		public void set_line_index (int byte_on_line);
		[NoArrayLength ()]
		[InstanceByReference ()]
		public void set_line_offset (int char_on_line);
		[NoArrayLength ()]
		[InstanceByReference ()]
		public void set_offset (int char_offset);
		[NoArrayLength ()]
		[InstanceByReference ()]
		public void set_visible_line_index (int byte_on_line);
		[NoArrayLength ()]
		[InstanceByReference ()]
		public void set_visible_line_offset (int char_on_line);
		[NoArrayLength ()]
		[InstanceByReference ()]
		public bool starts_line ();
		[NoArrayLength ()]
		[InstanceByReference ()]
		public bool starts_sentence ();
		[NoArrayLength ()]
		[InstanceByReference ()]
		public bool starts_word ();
		[NoArrayLength ()]
		[InstanceByReference ()]
		public bool toggles_tag (Gtk.TextTag tag);
	}
	[ReferenceType ()]
	public struct TextLogAttrCache {
	}
	[ReferenceType ()]
	public struct TextPendingScroll {
	}
	[ReferenceType ()]
	public struct TextWindow {
	}
	[ReferenceType ()]
	public struct ThemeEngine {
	}
	public struct ToggleActionEntry {
		public weak string name;
		public weak string stock_id;
		public weak string label;
		public weak string accelerator;
		public weak string tooltip;
		public weak GLib.Callback @callback;
		public weak bool is_active;
	}
	[ReferenceType ()]
	public struct TooltipsData {
		public weak Gtk.Tooltips tooltips;
		public weak Gtk.Widget widget;
		public weak string tip_text;
		public weak string tip_private;
		[NoArrayLength ()]
		public static Gtk.TooltipsData @get (Gtk.Widget widget);
	}
	public struct TreeIter {
		public weak int stamp;
		public weak pointer user_data;
		public weak pointer user_data2;
		public weak pointer user_data3;
		[NoArrayLength ()]
		[InstanceByReference ()]
		public Gtk.TreeIter copy ();
		[NoArrayLength ()]
		[InstanceByReference ()]
		public void free ();
		[NoArrayLength ()]
		public static GLib.Type get_type ();
	}
	[ReferenceType ()]
	public struct TreePath {
		[NoArrayLength ()]
		public void append_index (int index_);
		[NoArrayLength ()]
		public int compare (Gtk.TreePath b);
		[NoArrayLength ()]
		public Gtk.TreePath copy ();
		[NoArrayLength ()]
		public void down ();
		[NoArrayLength ()]
		public void free ();
		[NoArrayLength ()]
		public int get_depth ();
		[NoArrayLength ()]
		public int[] get_indices ();
		[NoArrayLength ()]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		public bool is_ancestor (Gtk.TreePath descendant);
		[NoArrayLength ()]
		public bool is_descendant (Gtk.TreePath ancestor);
		[NoArrayLength ()]
		public construct ();
		[NoArrayLength ()]
		public construct first ();
		[NoArrayLength ()]
		public construct from_indices (int first_index);
		[NoArrayLength ()]
		public construct from_string (string path);
		[NoArrayLength ()]
		public void next ();
		[NoArrayLength ()]
		public void prepend_index (int index_);
		[NoArrayLength ()]
		public bool prev ();
		[NoArrayLength ()]
		public string to_string ();
		[NoArrayLength ()]
		public bool up ();
	}
	public struct TreeRowReference {
		[NoArrayLength ()]
		[InstanceByReference ()]
		public Gtk.TreeRowReference copy ();
		[NoArrayLength ()]
		public static void deleted (GLib.Object proxy, Gtk.TreePath path);
		[NoArrayLength ()]
		[InstanceByReference ()]
		public void free ();
		[NoArrayLength ()]
		[InstanceByReference ()]
		public Gtk.TreeModel get_model ();
		[NoArrayLength ()]
		[InstanceByReference ()]
		public Gtk.TreePath get_path ();
		[NoArrayLength ()]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		public static void inserted (GLib.Object proxy, Gtk.TreePath path);
		[NoArrayLength ()]
		public construct (Gtk.TreeModel model, Gtk.TreePath path);
		[NoArrayLength ()]
		public construct proxy (GLib.Object proxy, Gtk.TreeModel model, Gtk.TreePath path);
		[NoArrayLength ()]
		public static void reordered (GLib.Object proxy, Gtk.TreePath path, Gtk.TreeIter iter, int new_order);
		[NoArrayLength ()]
		[InstanceByReference ()]
		public bool valid ();
	}
	[ReferenceType ()]
	public struct WidgetAuxInfo {
		public weak int x;
		public weak int y;
		public weak int width;
		public weak int height;
		public weak uint x_set;
		public weak uint y_set;
	}
	[ReferenceType ()]
	public struct WidgetShapeInfo {
		public weak short offset_x;
		public weak short offset_y;
		public weak Gdk.Bitmap shape_mask;
	}
	[ReferenceType ()]
	public struct WindowGeometryInfo {
	}
	[ReferenceType ()]
	public struct Accel {
		[NoArrayLength ()]
		public static bool groups_activate (GLib.Object object, uint accel_key, Gdk.ModifierType accel_mods);
		[NoArrayLength ()]
		public static GLib.SList groups_from_object (GLib.Object object);
	}
	[ReferenceType ()]
	public struct Accelerator {
		[NoArrayLength ()]
		public static uint get_default_mod_mask ();
		[NoArrayLength ()]
		public static string get_label (uint accelerator_key, Gdk.ModifierType accelerator_mods);
		[NoArrayLength ()]
		public static string name (uint accelerator_key, Gdk.ModifierType accelerator_mods);
		[NoArrayLength ()]
		public static void parse (string accelerator, uint accelerator_key, Gdk.ModifierType accelerator_mods);
		[NoArrayLength ()]
		public static void set_default_mod_mask (Gdk.ModifierType default_mod_mask);
		[NoArrayLength ()]
		public static bool valid (uint keyval, Gdk.ModifierType modifiers);
	}
	[ReferenceType ()]
	public struct Bindings {
		[NoArrayLength ()]
		public static bool activate (Gtk.Object object, uint keyval, Gdk.ModifierType modifiers);
		[NoArrayLength ()]
		public static bool activate_event (Gtk.Object object, Gdk.EventKey event);
	}
	[ReferenceType ()]
	public struct Ctree {
		[NoArrayLength ()]
		public static GLib.Type expander_style_get_type ();
		[NoArrayLength ()]
		public static GLib.Type expansion_type_get_type ();
		[NoArrayLength ()]
		public static GLib.Type line_style_get_type ();
		[NoArrayLength ()]
		public static GLib.Type pos_get_type ();
	}
	[ReferenceType ()]
	public struct Drag {
		[NoArrayLength ()]
		public static Gdk.DragContext begin (Gtk.Widget widget, Gtk.TargetList targets, Gdk.DragAction actions, int button, Gdk.Event event);
		[NoArrayLength ()]
		public static bool check_threshold (Gtk.Widget widget, int start_x, int start_y, int current_x, int current_y);
		[NoArrayLength ()]
		public static void dest_add_image_targets (Gtk.Widget widget);
		[NoArrayLength ()]
		public static void dest_add_text_targets (Gtk.Widget widget);
		[NoArrayLength ()]
		public static void dest_add_uri_targets (Gtk.Widget widget);
		[NoArrayLength ()]
		public static Gdk.Atom dest_find_target (Gtk.Widget widget, Gdk.DragContext context, Gtk.TargetList target_list);
		[NoArrayLength ()]
		public static Gtk.TargetList dest_get_target_list (Gtk.Widget widget);
		[NoArrayLength ()]
		public static bool dest_get_track_motion (Gtk.Widget widget);
		[NoArrayLength ()]
		public static void dest_set (Gtk.Widget widget, Gtk.DestDefaults @flags, Gtk.TargetEntry targets, int n_targets, Gdk.DragAction actions);
		[NoArrayLength ()]
		public static void dest_set_proxy (Gtk.Widget widget, Gdk.Window proxy_window, Gdk.DragProtocol protocol, bool use_coordinates);
		[NoArrayLength ()]
		public static void dest_set_target_list (Gtk.Widget widget, Gtk.TargetList target_list);
		[NoArrayLength ()]
		public static void dest_set_track_motion (Gtk.Widget widget, bool track_motion);
		[NoArrayLength ()]
		public static void dest_unset (Gtk.Widget widget);
		[NoArrayLength ()]
		public static void finish (Gdk.DragContext context, bool success, bool del, uint time_);
		[NoArrayLength ()]
		public static void get_data (Gtk.Widget widget, Gdk.DragContext context, Gdk.Atom target, uint time_);
		[NoArrayLength ()]
		public static Gtk.Widget get_source_widget (Gdk.DragContext context);
		[NoArrayLength ()]
		public static void highlight (Gtk.Widget widget);
		[NoArrayLength ()]
		public static void set_icon_default (Gdk.DragContext context);
		[NoArrayLength ()]
		public static void set_icon_name (Gdk.DragContext context, string icon_name, int hot_x, int hot_y);
		[NoArrayLength ()]
		public static void set_icon_pixbuf (Gdk.DragContext context, Gdk.Pixbuf pixbuf, int hot_x, int hot_y);
		[NoArrayLength ()]
		public static void set_icon_pixmap (Gdk.DragContext context, Gdk.Colormap colormap, Gdk.Pixmap pixmap, Gdk.Bitmap mask, int hot_x, int hot_y);
		[NoArrayLength ()]
		public static void set_icon_stock (Gdk.DragContext context, string stock_id, int hot_x, int hot_y);
		[NoArrayLength ()]
		public static void set_icon_widget (Gdk.DragContext context, Gtk.Widget widget, int hot_x, int hot_y);
		[NoArrayLength ()]
		public static void source_add_image_targets (Gtk.Widget widget);
		[NoArrayLength ()]
		public static void source_add_text_targets (Gtk.Widget widget);
		[NoArrayLength ()]
		public static void source_add_uri_targets (Gtk.Widget widget);
		[NoArrayLength ()]
		public static Gtk.TargetList source_get_target_list (Gtk.Widget widget);
		[NoArrayLength ()]
		public static void source_set (Gtk.Widget widget, Gdk.ModifierType start_button_mask, Gtk.TargetEntry targets, int n_targets, Gdk.DragAction actions);
		[NoArrayLength ()]
		public static void source_set_icon (Gtk.Widget widget, Gdk.Colormap colormap, Gdk.Pixmap pixmap, Gdk.Bitmap mask);
		[NoArrayLength ()]
		public static void source_set_icon_name (Gtk.Widget widget, string icon_name);
		[NoArrayLength ()]
		public static void source_set_icon_pixbuf (Gtk.Widget widget, Gdk.Pixbuf pixbuf);
		[NoArrayLength ()]
		public static void source_set_icon_stock (Gtk.Widget widget, string stock_id);
		[NoArrayLength ()]
		public static void source_set_target_list (Gtk.Widget widget, Gtk.TargetList target_list);
		[NoArrayLength ()]
		public static void source_unset (Gtk.Widget widget);
		[NoArrayLength ()]
		public static void unhighlight (Gtk.Widget widget);
	}
	[ReferenceType ()]
	public struct Draw {
		[NoArrayLength ()]
		public static void insertion_cursor (Gtk.Widget widget, Gdk.Drawable drawable, Gdk.Rectangle area, Gdk.Rectangle location, bool is_primary, Gtk.TextDirection direction, bool draw_arrow);
	}
	[ReferenceType ()]
	public struct Gc {
		[NoArrayLength ()]
		public static Gdk.GC @get (int depth, Gdk.Colormap colormap, Gdk.GCValues values, Gdk.GCValuesMask values_mask);
		[NoArrayLength ()]
		public static void release (Gdk.GC gc);
	}
	[ReferenceType ()]
	public struct Grab {
		[NoArrayLength ()]
		public static void add (Gtk.Widget widget);
		[NoArrayLength ()]
		public static Gtk.Widget get_current ();
		[NoArrayLength ()]
		public static void remove (Gtk.Widget widget);
	}
	[ReferenceType ()]
	public struct Icon {
		[NoArrayLength ()]
		public static Gtk.IconSize size_from_name (string name);
		[NoArrayLength ()]
		public static string size_get_name (Gtk.IconSize size);
		[NoArrayLength ()]
		public static bool size_lookup (Gtk.IconSize size, int width, int height);
		[NoArrayLength ()]
		public static bool size_lookup_for_settings (Gtk.Settings settings, Gtk.IconSize size, int width, int height);
		[NoArrayLength ()]
		public static Gtk.IconSize size_register (string name, int width, int height);
		[NoArrayLength ()]
		public static void size_register_alias (string alias, Gtk.IconSize target);
	}
	[ReferenceType ()]
	public struct Idle {
	}
	[ReferenceType ()]
	public struct Init {
		[NoArrayLength ()]
		public static void abi_check (int argc, string argv, int num_checks, ulong sizeof_GtkWindow, ulong sizeof_GtkBox);
		[NoArrayLength ()]
		public static void add (Gtk.Function function, pointer data);
		[NoArrayLength ()]
		public static bool check (int argc, string argv);
		[NoArrayLength ()]
		public static bool check_abi_check (int argc, string argv, int num_checks, ulong sizeof_GtkWindow, ulong sizeof_GtkBox);
		[NoArrayLength ()]
		public static bool with_args (int argc, string argv, string parameter_string, GLib.OptionEntry entries, string translation_domain, GLib.Error error);
	}
	[ReferenceType ()]
	public struct Input {
	}
	[ReferenceType ()]
	public struct Key {
		[NoArrayLength ()]
		public static uint snooper_install (Gtk.KeySnoopFunc snooper, pointer func_data);
		[NoArrayLength ()]
		public static void snooper_remove (uint snooper_handler_id);
	}
	[ReferenceType ()]
	public struct Main {
		[NoArrayLength ()]
		public static void do_event (Gdk.Event event);
		[NoArrayLength ()]
		public static bool iteration ();
		[NoArrayLength ()]
		public static bool iteration_do (bool blocking);
		[NoArrayLength ()]
		public static uint level ();
		[NoArrayLength ()]
		public static void quit ();
	}
	[ReferenceType ()]
	public struct Print {
		[NoArrayLength ()]
		public static GLib.Quark error_quark ();
		[NoArrayLength ()]
		public static Gtk.PageSetup run_page_setup_dialog (Gtk.Window parent, Gtk.PageSetup page_setup, Gtk.PrintSettings settings);
		[NoArrayLength ()]
		public static void run_page_setup_dialog_async (Gtk.Window parent, Gtk.PageSetup page_setup, Gtk.PrintSettings settings, Gtk.PageSetupDoneFunc done_cb, pointer data);
	}
	[ReferenceType ()]
	public struct Quit {
		[NoArrayLength ()]
		public static uint add (uint main_level, Gtk.Function function, pointer data);
		[NoArrayLength ()]
		public static void add_destroy (uint main_level, Gtk.Object object);
		[NoArrayLength ()]
		public static void remove (uint quit_handler_id);
		[NoArrayLength ()]
		public static void remove_by_data (pointer data);
	}
	[ReferenceType ()]
	public struct Rc {
		[NoArrayLength ()]
		public static void add_default_file (string filename);
		[NoArrayLength ()]
		public static string find_module_in_path (string module_file);
		[NoArrayLength ()]
		public static string find_pixmap_in_path (Gtk.Settings settings, GLib.Scanner scanner, string pixmap_file);
		[NoArrayLength ()]
		public static string get_default_files ();
		[NoArrayLength ()]
		public static string get_im_module_file ();
		[NoArrayLength ()]
		public static string get_im_module_path ();
		[NoArrayLength ()]
		public static string get_module_dir ();
		[NoArrayLength ()]
		public static Gtk.Style get_style (Gtk.Widget widget);
		[NoArrayLength ()]
		public static Gtk.Style get_style_by_paths (Gtk.Settings settings, string widget_path, string class_path, GLib.Type type);
		[NoArrayLength ()]
		public static string get_theme_dir ();
		[NoArrayLength ()]
		public static void parse (string filename);
		[NoArrayLength ()]
		public static uint parse_color (GLib.Scanner scanner, Gdk.Color color);
		[NoArrayLength ()]
		public static uint parse_priority (GLib.Scanner scanner, Gtk.PathPriorityType priority);
		[NoArrayLength ()]
		public static uint parse_state (GLib.Scanner scanner, Gtk.StateType state);
		[NoArrayLength ()]
		public static void parse_string (string rc_string);
		[NoArrayLength ()]
		public static bool reparse_all ();
		[NoArrayLength ()]
		public static bool reparse_all_for_settings (Gtk.Settings settings, bool force_load);
		[NoArrayLength ()]
		public static void reset_styles (Gtk.Settings settings);
		[NoArrayLength ()]
		public static GLib.Scanner scanner_new ();
		[NoArrayLength ()]
		public static void set_default_files (string filenames);
	}
	[ReferenceType ()]
	public struct Selection {
		[NoArrayLength ()]
		public static void add_target (Gtk.Widget widget, Gdk.Atom selection, Gdk.Atom target, uint info);
		[NoArrayLength ()]
		public static void add_targets (Gtk.Widget widget, Gdk.Atom selection, Gtk.TargetEntry targets, uint ntargets);
		[NoArrayLength ()]
		public static void clear_targets (Gtk.Widget widget, Gdk.Atom selection);
		[NoArrayLength ()]
		public static bool convert (Gtk.Widget widget, Gdk.Atom selection, Gdk.Atom target, uint time_);
		[NoArrayLength ()]
		public static bool owner_set (Gtk.Widget widget, Gdk.Atom selection, uint time_);
		[NoArrayLength ()]
		public static bool owner_set_for_display (Gdk.Display display, Gtk.Widget widget, Gdk.Atom selection, uint time_);
		[NoArrayLength ()]
		public static void remove_all (Gtk.Widget widget);
	}
	[ReferenceType ()]
	public struct Signal {
	}
	[ReferenceType ()]
	public struct Stock {
		[NoArrayLength ()]
		public static void add (Gtk.StockItem items, uint n_items);
		[NoArrayLength ()]
		public static void add_static (Gtk.StockItem items, uint n_items);
		[NoArrayLength ()]
		public static GLib.SList list_ids ();
		[NoArrayLength ()]
		public static bool lookup (string stock_id, Gtk.StockItem item);
		[NoArrayLength ()]
		public static void set_translate_func (string domain, Gtk.TranslateFunc func, pointer data, Gtk.DestroyNotify notify);
	}
	[ReferenceType ()]
	public struct Target {
		[NoArrayLength ()]
		public static void table_free (Gtk.TargetEntry targets, int n_targets);
		[NoArrayLength ()]
		public static Gtk.TargetEntry table_new_from_list (Gtk.TargetList list, int n_targets);
	}
	[ReferenceType ()]
	public struct Targets {
		[NoArrayLength ()]
		public static bool include_image (Gdk.Atom targets, int n_targets, bool writable);
		[NoArrayLength ()]
		public static bool include_rich_text (Gdk.Atom targets, int n_targets, Gtk.TextBuffer buffer);
		[NoArrayLength ()]
		public static bool include_text (Gdk.Atom targets, int n_targets);
		[NoArrayLength ()]
		public static bool include_uri (Gdk.Atom targets, int n_targets);
	}
	[ReferenceType ()]
	public struct Timeout {
	}
	[ReferenceType ()]
	public struct Tree {
		[NoArrayLength ()]
		public static bool get_row_drag_data (Gtk.SelectionData selection_data, Gtk.TreeModel tree_model, Gtk.TreePath path);
		[NoArrayLength ()]
		public static bool set_row_drag_data (Gtk.SelectionData selection_data, Gtk.TreeModel tree_model, Gtk.TreePath path);
	}
	[ReferenceType ()]
	public struct Type {
		[NoArrayLength ()]
		public pointer @class ();
	}
	public callback void AboutDialogActivateLinkFunc (Gtk.AboutDialog about, string link, pointer data);
	public callback bool AccelGroupActivate (Gtk.AccelGroup accel_group, GLib.Object acceleratable, uint keyval, Gdk.ModifierType modifier);
	public callback bool AccelGroupFindFunc (Gtk.AccelKey key, GLib.Closure closure, pointer data);
	public callback void AccelMapForeach (pointer data, string accel_path, uint accel_key, Gdk.ModifierType accel_mods, bool changed);
	public callback int AssistantPageFunc (int current_page, pointer data);
	public callback void Callback (Gtk.Widget widget, pointer data);
	public callback void CellLayoutDataFunc (Gtk.CellLayout cell_layout, Gtk.CellRenderer cell, Gtk.TreeModel tree_model, Gtk.TreeIter iter, pointer data);
	public callback void ClipboardClearFunc (Gtk.Clipboard clipboard, pointer user_data_or_owner);
	public callback void ClipboardGetFunc (Gtk.Clipboard clipboard, Gtk.SelectionData selection_data, uint info, pointer user_data_or_owner);
	public callback void ClipboardImageReceivedFunc (Gtk.Clipboard clipboard, Gdk.Pixbuf pixbuf, pointer data);
	public callback void ClipboardReceivedFunc (Gtk.Clipboard clipboard, Gtk.SelectionData selection_data, pointer data);
	public callback void ClipboardRichTextReceivedFunc (Gtk.Clipboard clipboard, Gdk.Atom format, uchar text, ulong length, pointer data);
	public callback void ClipboardTargetsReceivedFunc (Gtk.Clipboard clipboard, Gdk.Atom atoms, int n_atoms, pointer data);
	public callback void ClipboardTextReceivedFunc (Gtk.Clipboard clipboard, string text, pointer data);
	public callback void ColorSelectionChangePaletteFunc (Gdk.Color colors, int n_colors);
	public callback void ColorSelectionChangePaletteWithScreenFunc (Gdk.Screen screen, Gdk.Color colors, int n_colors);
	public callback void DestroyNotify (pointer data);
	public callback bool EntryCompletionMatchFunc (Gtk.EntryCompletion completion, string key, Gtk.TreeIter iter, pointer user_data);
	public callback bool FileFilterFunc (Gtk.FileFilterInfo filter_info, pointer data);
	public callback bool Function (pointer data);
	public callback void IconViewForeachFunc (Gtk.IconView icon_view, Gtk.TreePath path, pointer data);
	public callback void ItemFactoryCallback ();
	public callback void ItemFactoryCallback1 (pointer callback_data, uint callback_action, Gtk.Widget widget);
	public callback void ItemFactoryCallback2 ();
	public callback int KeySnoopFunc (Gtk.Widget grab_widget, Gdk.EventKey event, pointer func_data);
	public callback void LinkButtonUriFunc (Gtk.LinkButton button, string link, pointer user_data);
	public callback void MenuCallback (Gtk.Widget widget, pointer user_data);
	public callback void MenuDetachFunc (Gtk.Widget attach_widget, Gtk.Menu menu);
	public callback void MenuPositionFunc (Gtk.Menu menu, int x, int y, bool push_in, pointer user_data);
	public callback void MnemonicHashForeach (uint keyval, GLib.SList targets, pointer data);
	public callback void ModuleDisplayInitFunc (Gdk.Display display);
	public callback void ModuleInitFunc (int argc, string argv);
	public callback Gtk.Notebook NotebookWindowCreationFunc (Gtk.Notebook source, Gtk.Widget page, int x, int y, pointer data);
	public callback void PageSetupDoneFunc (Gtk.PageSetup page_setup, pointer data);
	public callback void PrintFunc (pointer func_data, string str);
	public callback void PrintJobCompleteFunc (Gtk.PrintJob print_job, pointer user_data, GLib.Error error);
	public callback void PrintSettingsFunc (string key, string value, pointer user_data);
	public callback bool PrinterFunc (Gtk.Printer printer, pointer data);
	public callback void PrinterOptionSetFunc (Gtk.PrinterOption option, pointer user_data);
	public callback bool RcPropertyParser (GLib.ParamSpec pspec, GLib.String rc_string, GLib.Value property_value);
	public callback bool RecentFilterFunc (Gtk.RecentFilterInfo filter_info, pointer user_data);
	public callback int RecentSortFunc (Gtk.RecentInfo a, Gtk.RecentInfo b, pointer user_data);
	public callback void SignalFunc ();
	public callback bool TextBufferDeserializeFunc (Gtk.TextBuffer register_buffer, Gtk.TextBuffer content_buffer, Gtk.TextIter iter, uchar data, ulong length, bool create_tags, pointer user_data, GLib.Error error);
	public callback uchar TextBufferSerializeFunc (Gtk.TextBuffer register_buffer, Gtk.TextBuffer content_buffer, Gtk.TextIter start, Gtk.TextIter end, ulong length, pointer user_data);
	public callback bool TextCharPredicate (unichar ch, pointer user_data);
	public callback void TextTagTableForeach (Gtk.TextTag tag, pointer data);
	public callback string TranslateFunc (string path, pointer func_data);
	public callback void TreeCellDataFunc (Gtk.TreeViewColumn tree_column, Gtk.CellRenderer cell, Gtk.TreeModel tree_model, Gtk.TreeIter iter, pointer data);
	public callback void TreeDestroyCountFunc (Gtk.TreeView tree_view, Gtk.TreePath path, int children, pointer user_data);
	public callback int TreeIterCompareFunc (Gtk.TreeModel model, Gtk.TreeIter a, Gtk.TreeIter b, pointer user_data);
	public callback void TreeModelFilterModifyFunc (Gtk.TreeModel model, Gtk.TreeIter iter, GLib.Value value, int column, pointer data);
	public callback bool TreeModelFilterVisibleFunc (Gtk.TreeModel model, Gtk.TreeIter iter, pointer data);
	public callback bool TreeModelForeachFunc (Gtk.TreeModel model, Gtk.TreePath path, Gtk.TreeIter iter, pointer data);
	public callback void TreeSelectionForeachFunc (Gtk.TreeModel model, Gtk.TreePath path, Gtk.TreeIter iter, pointer data);
	public callback bool TreeSelectionFunc (Gtk.TreeSelection selection, Gtk.TreeModel model, Gtk.TreePath path, bool path_currently_selected, pointer data);
	public callback bool TreeViewColumnDropFunc (Gtk.TreeView tree_view, Gtk.TreeViewColumn column, Gtk.TreeViewColumn prev_column, Gtk.TreeViewColumn next_column, pointer data);
	public callback void TreeViewMappingFunc (Gtk.TreeView tree_view, Gtk.TreePath path, pointer user_data);
	public callback bool TreeViewRowSeparatorFunc (Gtk.TreeModel model, Gtk.TreeIter iter, pointer data);
	public callback bool TreeViewSearchEqualFunc (Gtk.TreeModel model, int column, string key, Gtk.TreeIter iter, pointer search_data);
	public callback void TreeViewSearchPositionFunc (Gtk.TreeView tree_view, Gtk.Widget search_dialog, pointer user_data);
	public callback void WindowKeysForeachFunc (Gtk.Window window, uint keyval, Gdk.ModifierType modifiers, bool is_mnemonic, pointer data);
	public const string STOCK_ABOUT;
	public const string STOCK_ADD;
	public const string STOCK_APPLY;
	public const string STOCK_BOLD;
	public const string STOCK_CANCEL;
	public const string STOCK_CDROM;
	public const string STOCK_CLEAR;
	public const string STOCK_CLOSE;
	public const string STOCK_COLOR_PICKER;
	public const string STOCK_CONNECT;
	public const string STOCK_CONVERT;
	public const string STOCK_COPY;
	public const string STOCK_CUT;
	public const string STOCK_DELETE;
	public const string STOCK_DIALOG_ERROR;
	public const string STOCK_DIALOG_INFO;
	public const string STOCK_DIALOG_QUESTION;
	public const string STOCK_DIALOG_WARNING;
	public const string STOCK_DIRECTORY;
	public const string STOCK_DISCONNECT;
	public const string STOCK_DND;
	public const string STOCK_DND_MULTIPLE;
	public const string STOCK_EDIT;
	public const string STOCK_EXECUTE;
	public const string STOCK_FILE;
	public const string STOCK_FIND;
	public const string STOCK_FIND_AND_REPLACE;
	public const string STOCK_FLOPPY;
	public const string STOCK_FULLSCREEN;
	public const string STOCK_GOTO_BOTTOM;
	public const string STOCK_GOTO_FIRST;
	public const string STOCK_GOTO_LAST;
	public const string STOCK_GOTO_TOP;
	public const string STOCK_GO_BACK;
	public const string STOCK_GO_DOWN;
	public const string STOCK_GO_FORWARD;
	public const string STOCK_GO_UP;
	public const string STOCK_HARDDISK;
	public const string STOCK_HELP;
	public const string STOCK_HOME;
	public const string STOCK_INDENT;
	public const string STOCK_INDEX;
	public const string STOCK_INFO;
	public const string STOCK_ITALIC;
	public const string STOCK_JUMP_TO;
	public const string STOCK_JUSTIFY_CENTER;
	public const string STOCK_JUSTIFY_FILL;
	public const string STOCK_JUSTIFY_LEFT;
	public const string STOCK_JUSTIFY_RIGHT;
	public const string STOCK_LEAVE_FULLSCREEN;
	public const string STOCK_MEDIA_FORWARD;
	public const string STOCK_MEDIA_NEXT;
	public const string STOCK_MEDIA_PAUSE;
	public const string STOCK_MEDIA_PLAY;
	public const string STOCK_MEDIA_PREVIOUS;
	public const string STOCK_MEDIA_RECORD;
	public const string STOCK_MEDIA_REWIND;
	public const string STOCK_MEDIA_STOP;
	public const string STOCK_MISSING_IMAGE;
	public const string STOCK_NETWORK;
	public const string STOCK_NEW;
	public const string STOCK_NO;
	public const string STOCK_OK;
	public const string STOCK_OPEN;
	public const string STOCK_ORIENTATION_LANDSCAPE;
	public const string STOCK_ORIENTATION_PORTRAIT;
	public const string STOCK_ORIENTATION_REVERSE_LANDSCAPE;
	public const string STOCK_ORIENTATION_REVERSE_PORTRAIT;
	public const string STOCK_PASTE;
	public const string STOCK_PREFERENCES;
	public const string STOCK_PRINT;
	public const string STOCK_PRINT_PREVIEW;
	public const string STOCK_PROPERTIES;
	public const string STOCK_QUIT;
	public const string STOCK_REDO;
	public const string STOCK_REFRESH;
	public const string STOCK_REMOVE;
	public const string STOCK_REVERT_TO_SAVED;
	public const string STOCK_SAVE;
	public const string STOCK_SAVE_AS;
	public const string STOCK_SELECT_ALL;
	public const string STOCK_SELECT_COLOR;
	public const string STOCK_SELECT_FONT;
	public const string STOCK_SORT_ASCENDING;
	public const string STOCK_SORT_DESCENDING;
	public const string STOCK_SPELL_CHECK;
	public const string STOCK_STOP;
	public const string STOCK_STRIKETHROUGH;
	public const string STOCK_UNDELETE;
	public const string STOCK_UNDERLINE;
	public const string STOCK_UNDO;
	public const string STOCK_UNINDENT;
	public const string STOCK_YES;
	public const string STOCK_ZOOM_100;
	public const string STOCK_ZOOM_FIT;
	public const string STOCK_ZOOM_IN;
	public const string STOCK_ZOOM_OUT;
	[NoArrayLength ()]
	public static bool alternative_dialog_button_order (Gdk.Screen screen);
	[NoArrayLength ()]
	public static uint binding_parse_binding (GLib.Scanner scanner);
	[NoArrayLength ()]
	public static GLib.Type cell_type_get_type ();
	[NoArrayLength ()]
	public static string check_version (uint required_major, uint required_minor, uint required_micro);
	[NoArrayLength ()]
	public static GLib.Type clist_drag_pos_get_type ();
	[NoArrayLength ()]
	public static void disable_setlocale ();
	[NoArrayLength ()]
	public static void enumerate_printers (Gtk.PrinterFunc func, pointer data, GLib.DestroyNotify destroy, bool wait);
	[NoArrayLength ()]
	public static bool events_pending ();
	[NoArrayLength ()]
	public static Gdk.Event get_current_event ();
	[NoArrayLength ()]
	public static bool get_current_event_state (Gdk.ModifierType state);
	[NoArrayLength ()]
	public static uint get_current_event_time ();
	[NoArrayLength ()]
	public static Pango.Language get_default_language ();
	[NoArrayLength ()]
	public static Gtk.Widget get_event_widget (Gdk.Event event);
	[NoArrayLength ()]
	public static GLib.OptionGroup get_option_group (bool open_default_display);
	[NoArrayLength ()]
	public static GLib.Type identifier_get_type ();
	[NoArrayLength ()]
	public static void paint_arrow (Gtk.Style style, Gdk.Window window, Gtk.StateType state_type, Gtk.ShadowType shadow_type, Gdk.Rectangle area, Gtk.Widget widget, string detail, Gtk.ArrowType arrow_type, bool fill, int x, int y, int width, int height);
	[NoArrayLength ()]
	public static void paint_box (Gtk.Style style, Gdk.Window window, Gtk.StateType state_type, Gtk.ShadowType shadow_type, Gdk.Rectangle area, Gtk.Widget widget, string detail, int x, int y, int width, int height);
	[NoArrayLength ()]
	public static void paint_box_gap (Gtk.Style style, Gdk.Window window, Gtk.StateType state_type, Gtk.ShadowType shadow_type, Gdk.Rectangle area, Gtk.Widget widget, string detail, int x, int y, int width, int height, Gtk.PositionType gap_side, int gap_x, int gap_width);
	[NoArrayLength ()]
	public static void paint_check (Gtk.Style style, Gdk.Window window, Gtk.StateType state_type, Gtk.ShadowType shadow_type, Gdk.Rectangle area, Gtk.Widget widget, string detail, int x, int y, int width, int height);
	[NoArrayLength ()]
	public static void paint_diamond (Gtk.Style style, Gdk.Window window, Gtk.StateType state_type, Gtk.ShadowType shadow_type, Gdk.Rectangle area, Gtk.Widget widget, string detail, int x, int y, int width, int height);
	[NoArrayLength ()]
	public static void paint_expander (Gtk.Style style, Gdk.Window window, Gtk.StateType state_type, Gdk.Rectangle area, Gtk.Widget widget, string detail, int x, int y, Gtk.ExpanderStyle expander_style);
	[NoArrayLength ()]
	public static void paint_extension (Gtk.Style style, Gdk.Window window, Gtk.StateType state_type, Gtk.ShadowType shadow_type, Gdk.Rectangle area, Gtk.Widget widget, string detail, int x, int y, int width, int height, Gtk.PositionType gap_side);
	[NoArrayLength ()]
	public static void paint_flat_box (Gtk.Style style, Gdk.Window window, Gtk.StateType state_type, Gtk.ShadowType shadow_type, Gdk.Rectangle area, Gtk.Widget widget, string detail, int x, int y, int width, int height);
	[NoArrayLength ()]
	public static void paint_focus (Gtk.Style style, Gdk.Window window, Gtk.StateType state_type, Gdk.Rectangle area, Gtk.Widget widget, string detail, int x, int y, int width, int height);
	[NoArrayLength ()]
	public static void paint_handle (Gtk.Style style, Gdk.Window window, Gtk.StateType state_type, Gtk.ShadowType shadow_type, Gdk.Rectangle area, Gtk.Widget widget, string detail, int x, int y, int width, int height, Gtk.Orientation orientation);
	[NoArrayLength ()]
	public static void paint_hline (Gtk.Style style, Gdk.Window window, Gtk.StateType state_type, Gdk.Rectangle area, Gtk.Widget widget, string detail, int x1, int x2, int y);
	[NoArrayLength ()]
	public static void paint_layout (Gtk.Style style, Gdk.Window window, Gtk.StateType state_type, bool use_text, Gdk.Rectangle area, Gtk.Widget widget, string detail, int x, int y, Pango.Layout layout);
	[NoArrayLength ()]
	public static void paint_option (Gtk.Style style, Gdk.Window window, Gtk.StateType state_type, Gtk.ShadowType shadow_type, Gdk.Rectangle area, Gtk.Widget widget, string detail, int x, int y, int width, int height);
	[NoArrayLength ()]
	public static void paint_polygon (Gtk.Style style, Gdk.Window window, Gtk.StateType state_type, Gtk.ShadowType shadow_type, Gdk.Rectangle area, Gtk.Widget widget, string detail, Gdk.Point points, int npoints, bool fill);
	[NoArrayLength ()]
	public static void paint_resize_grip (Gtk.Style style, Gdk.Window window, Gtk.StateType state_type, Gdk.Rectangle area, Gtk.Widget widget, string detail, Gdk.WindowEdge edge, int x, int y, int width, int height);
	[NoArrayLength ()]
	public static void paint_shadow (Gtk.Style style, Gdk.Window window, Gtk.StateType state_type, Gtk.ShadowType shadow_type, Gdk.Rectangle area, Gtk.Widget widget, string detail, int x, int y, int width, int height);
	[NoArrayLength ()]
	public static void paint_shadow_gap (Gtk.Style style, Gdk.Window window, Gtk.StateType state_type, Gtk.ShadowType shadow_type, Gdk.Rectangle area, Gtk.Widget widget, string detail, int x, int y, int width, int height, Gtk.PositionType gap_side, int gap_x, int gap_width);
	[NoArrayLength ()]
	public static void paint_slider (Gtk.Style style, Gdk.Window window, Gtk.StateType state_type, Gtk.ShadowType shadow_type, Gdk.Rectangle area, Gtk.Widget widget, string detail, int x, int y, int width, int height, Gtk.Orientation orientation);
	[NoArrayLength ()]
	public static void paint_tab (Gtk.Style style, Gdk.Window window, Gtk.StateType state_type, Gtk.ShadowType shadow_type, Gdk.Rectangle area, Gtk.Widget widget, string detail, int x, int y, int width, int height);
	[NoArrayLength ()]
	public static void paint_vline (Gtk.Style style, Gdk.Window window, Gtk.StateType state_type, Gdk.Rectangle area, Gtk.Widget widget, string detail, int y1_, int y2_, int x);
	[NoArrayLength ()]
	public static bool parse_args (int argc, string argv);
	[NoArrayLength ()]
	public static GLib.Type private_flags_get_type ();
	[NoArrayLength ()]
	public static void propagate_event (Gtk.Widget widget, Gdk.Event event);
	[NoArrayLength ()]
	public static void rgb_to_hsv (double r, double g, double b, double h, double s, double v);
	[NoArrayLength ()]
	public static string set_locale ();
	[NoArrayLength ()]
	public static void show_about_dialog (Gtk.Window parent, string first_property_name, ...);
	[NoArrayLength ()]
	public static void text_layout_draw (pointer layout, Gtk.Widget widget, Gdk.Drawable drawable, Gdk.GC cursor_gc, int x_offset, int y_offset, int x, int y, int width, int height, GLib.List widgets);
}
[CCode (cheader_filename = "gtk/gtk.h")]
namespace Gtk {
	public static void init (out string[] args);
	public static void main ();
	public static void main_quit ();
}
