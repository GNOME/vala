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
	[CCode (cheader_filename = "gtk/gtk.h")]
	public class AboutDialog : Gtk.Dialog {
		[NoArrayLength ()]
		[CCode (cname = "gtk_about_dialog_get_artists")]
		public string get_artists ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_about_dialog_get_authors")]
		public string get_authors ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_about_dialog_get_comments")]
		public string get_comments ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_about_dialog_get_copyright")]
		public string get_copyright ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_about_dialog_get_documenters")]
		public string get_documenters ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_about_dialog_get_license")]
		public string get_license ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_about_dialog_get_logo")]
		public Gdk.Pixbuf get_logo ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_about_dialog_get_logo_icon_name")]
		public string get_logo_icon_name ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_about_dialog_get_name")]
		public string get_name ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_about_dialog_get_translator_credits")]
		public string get_translator_credits ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_about_dialog_get_type")]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_about_dialog_get_version")]
		public string get_version ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_about_dialog_get_website")]
		public string get_website ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_about_dialog_get_website_label")]
		public string get_website_label ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_about_dialog_get_wrap_license")]
		public bool get_wrap_license ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_about_dialog_new")]
		public construct ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_about_dialog_set_artists")]
		public void set_artists (string artists);
		[NoArrayLength ()]
		[CCode (cname = "gtk_about_dialog_set_authors")]
		public void set_authors (string authors);
		[NoArrayLength ()]
		[CCode (cname = "gtk_about_dialog_set_comments")]
		public void set_comments (string comments);
		[NoArrayLength ()]
		[CCode (cname = "gtk_about_dialog_set_copyright")]
		public void set_copyright (string copyright);
		[NoArrayLength ()]
		[CCode (cname = "gtk_about_dialog_set_documenters")]
		public void set_documenters (string documenters);
		[NoArrayLength ()]
		[CCode (cname = "gtk_about_dialog_set_email_hook")]
		public static Gtk.AboutDialogActivateLinkFunc set_email_hook (Gtk.AboutDialogActivateLinkFunc func, pointer data, GLib.DestroyNotify destroy);
		[NoArrayLength ()]
		[CCode (cname = "gtk_about_dialog_set_license")]
		public void set_license (string license);
		[NoArrayLength ()]
		[CCode (cname = "gtk_about_dialog_set_logo")]
		public void set_logo (Gdk.Pixbuf logo);
		[NoArrayLength ()]
		[CCode (cname = "gtk_about_dialog_set_logo_icon_name")]
		public void set_logo_icon_name (string icon_name);
		[NoArrayLength ()]
		[CCode (cname = "gtk_about_dialog_set_name")]
		public void set_name (string name);
		[NoArrayLength ()]
		[CCode (cname = "gtk_about_dialog_set_translator_credits")]
		public void set_translator_credits (string translator_credits);
		[NoArrayLength ()]
		[CCode (cname = "gtk_about_dialog_set_url_hook")]
		public static Gtk.AboutDialogActivateLinkFunc set_url_hook (Gtk.AboutDialogActivateLinkFunc func, pointer data, GLib.DestroyNotify destroy);
		[NoArrayLength ()]
		[CCode (cname = "gtk_about_dialog_set_version")]
		public void set_version (string version);
		[NoArrayLength ()]
		[CCode (cname = "gtk_about_dialog_set_website")]
		public void set_website (string website);
		[NoArrayLength ()]
		[CCode (cname = "gtk_about_dialog_set_website_label")]
		public void set_website_label (string website_label);
		[NoArrayLength ()]
		[CCode (cname = "gtk_about_dialog_set_wrap_license")]
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
	[CCode (cheader_filename = "gtk/gtk.h")]
	public class AccelGroup : GLib.Object {
		[NoArrayLength ()]
		[CCode (cname = "gtk_accel_group_activate")]
		public bool activate (GLib.Quark accel_quark, GLib.Object acceleratable, uint accel_key, Gdk.ModifierType accel_mods);
		[NoArrayLength ()]
		[CCode (cname = "gtk_accel_group_connect")]
		public void connect (uint accel_key, Gdk.ModifierType accel_mods, Gtk.AccelFlags accel_flags, GLib.Closure closure);
		[NoArrayLength ()]
		[CCode (cname = "gtk_accel_group_connect_by_path")]
		public void connect_by_path (string accel_path, GLib.Closure closure);
		[NoArrayLength ()]
		[CCode (cname = "gtk_accel_group_disconnect")]
		public bool disconnect (GLib.Closure closure);
		[NoArrayLength ()]
		[CCode (cname = "gtk_accel_group_disconnect_key")]
		public bool disconnect_key (uint accel_key, Gdk.ModifierType accel_mods);
		[NoArrayLength ()]
		[CCode (cname = "gtk_accel_group_find")]
		public Gtk.AccelKey find (Gtk.AccelGroupFindFunc find_func, pointer data);
		[NoArrayLength ()]
		[CCode (cname = "gtk_accel_group_from_accel_closure")]
		public static Gtk.AccelGroup from_accel_closure (GLib.Closure closure);
		[NoArrayLength ()]
		[CCode (cname = "gtk_accel_group_get_type")]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_accel_group_lock")]
		public void @lock ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_accel_group_new")]
		public construct ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_accel_group_query")]
		public Gtk.AccelGroupEntry query (uint accel_key, Gdk.ModifierType accel_mods, uint n_entries);
		[NoArrayLength ()]
		[CCode (cname = "gtk_accel_group_unlock")]
		public void unlock ();
		public signal bool accel_activate (GLib.Object p0, uint p1, Gdk.ModifierType p2);
		public signal void accel_changed (uint keyval, Gdk.ModifierType modifier, GLib.Closure accel_closure);
	}
	[CCode (cheader_filename = "gtk/gtk.h")]
	public class AccelLabel : Gtk.Label {
		[NoArrayLength ()]
		[CCode (cname = "gtk_accel_label_get_accel_widget")]
		public Gtk.Widget get_accel_widget ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_accel_label_get_accel_width")]
		public uint get_accel_width ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_accel_label_get_type")]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_accel_label_new")]
		public construct (string string);
		[NoArrayLength ()]
		[CCode (cname = "gtk_accel_label_refetch")]
		public bool refetch ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_accel_label_set_accel_closure")]
		public void set_accel_closure (GLib.Closure accel_closure);
		[NoArrayLength ()]
		[CCode (cname = "gtk_accel_label_set_accel_widget")]
		public void set_accel_widget (Gtk.Widget accel_widget);
		[NoAccessorMethod ()]
		public weak GLib.Closure accel_closure { get; set; }
		public weak Gtk.Widget accel_widget { get; set; }
	}
	[CCode (cheader_filename = "gtk/gtk.h")]
	public class AccelMap : GLib.Object {
		[NoArrayLength ()]
		[CCode (cname = "gtk_accel_map_add_entry")]
		public static void add_entry (string accel_path, uint accel_key, Gdk.ModifierType accel_mods);
		[NoArrayLength ()]
		[CCode (cname = "gtk_accel_map_add_filter")]
		public static void add_filter (string filter_pattern);
		[NoArrayLength ()]
		[CCode (cname = "gtk_accel_map_change_entry")]
		public static bool change_entry (string accel_path, uint accel_key, Gdk.ModifierType accel_mods, bool replace);
		[NoArrayLength ()]
		[CCode (cname = "gtk_accel_map_foreach")]
		public static void @foreach (pointer data, Gtk.AccelMapForeach foreach_func);
		[NoArrayLength ()]
		[CCode (cname = "gtk_accel_map_foreach_unfiltered")]
		public static void foreach_unfiltered (pointer data, Gtk.AccelMapForeach foreach_func);
		[NoArrayLength ()]
		[CCode (cname = "gtk_accel_map_get")]
		public static Gtk.AccelMap @get ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_accel_map_get_type")]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_accel_map_load")]
		public static void load (string file_name);
		[NoArrayLength ()]
		[CCode (cname = "gtk_accel_map_load_fd")]
		public static void load_fd (int fd);
		[NoArrayLength ()]
		[CCode (cname = "gtk_accel_map_load_scanner")]
		public static void load_scanner (GLib.Scanner scanner);
		[NoArrayLength ()]
		[CCode (cname = "gtk_accel_map_lock_path")]
		public static void lock_path (string accel_path);
		[NoArrayLength ()]
		[CCode (cname = "gtk_accel_map_lookup_entry")]
		public static bool lookup_entry (string accel_path, Gtk.AccelKey key);
		[NoArrayLength ()]
		[CCode (cname = "gtk_accel_map_save")]
		public static void save (string file_name);
		[NoArrayLength ()]
		[CCode (cname = "gtk_accel_map_save_fd")]
		public static void save_fd (int fd);
		[NoArrayLength ()]
		[CCode (cname = "gtk_accel_map_unlock_path")]
		public static void unlock_path (string accel_path);
		public signal void changed (string p0, uint p1, Gdk.ModifierType p2);
	}
	[CCode (cheader_filename = "gtk/gtk.h")]
	public class Accessible : Atk.Object {
		[NoArrayLength ()]
		[CCode (cname = "gtk_accessible_connect_widget_destroyed")]
		public virtual void connect_widget_destroyed ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_accessible_get_type")]
		public static GLib.Type get_type ();
	}
	[CCode (cheader_filename = "gtk/gtk.h")]
	public class Action : GLib.Object {
		[NoArrayLength ()]
		[CCode (cname = "gtk_action_block_activate_from")]
		public void block_activate_from (Gtk.Widget proxy);
		[NoArrayLength ()]
		[CCode (cname = "gtk_action_connect_accelerator")]
		public void connect_accelerator ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_action_connect_proxy")]
		public virtual void connect_proxy (Gtk.Widget proxy);
		[NoArrayLength ()]
		[CCode (cname = "gtk_action_create_icon")]
		public Gtk.Widget create_icon (Gtk.IconSize icon_size);
		[NoArrayLength ()]
		[CCode (cname = "gtk_action_create_menu_item")]
		public virtual Gtk.Widget create_menu_item ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_action_create_tool_item")]
		public virtual Gtk.Widget create_tool_item ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_action_disconnect_accelerator")]
		public void disconnect_accelerator ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_action_disconnect_proxy")]
		public virtual void disconnect_proxy (Gtk.Widget proxy);
		[NoArrayLength ()]
		[CCode (cname = "gtk_action_get_accel_closure")]
		public GLib.Closure get_accel_closure ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_action_get_accel_path")]
		public string get_accel_path ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_action_get_name")]
		public string get_name ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_action_get_proxies")]
		public GLib.SList get_proxies ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_action_get_sensitive")]
		public bool get_sensitive ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_action_get_type")]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_action_get_visible")]
		public bool get_visible ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_action_is_sensitive")]
		public bool is_sensitive ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_action_is_visible")]
		public bool is_visible ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_action_new")]
		public construct (string name, string label, string tooltip, string stock_id);
		[NoArrayLength ()]
		[CCode (cname = "gtk_action_set_accel_group")]
		public void set_accel_group (Gtk.AccelGroup accel_group);
		[NoArrayLength ()]
		[CCode (cname = "gtk_action_set_accel_path")]
		public void set_accel_path (string accel_path);
		[NoArrayLength ()]
		[CCode (cname = "gtk_action_set_sensitive")]
		public void set_sensitive (bool sensitive);
		[NoArrayLength ()]
		[CCode (cname = "gtk_action_set_visible")]
		public void set_visible (bool visible);
		[NoArrayLength ()]
		[CCode (cname = "gtk_action_unblock_activate_from")]
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
	[CCode (cheader_filename = "gtk/gtk.h")]
	public class ActionGroup : GLib.Object {
		[NoArrayLength ()]
		[CCode (cname = "gtk_action_group_add_action")]
		public void add_action (Gtk.Action action);
		[NoArrayLength ()]
		[CCode (cname = "gtk_action_group_add_action_with_accel")]
		public void add_action_with_accel (Gtk.Action action, string accelerator);
		[NoArrayLength ()]
		[CCode (cname = "gtk_action_group_add_actions")]
		public void add_actions (Gtk.ActionEntry entries, uint n_entries, pointer user_data);
		[NoArrayLength ()]
		[CCode (cname = "gtk_action_group_add_actions_full")]
		public void add_actions_full (Gtk.ActionEntry entries, uint n_entries, pointer user_data, GLib.DestroyNotify destroy);
		[NoArrayLength ()]
		[CCode (cname = "gtk_action_group_add_radio_actions")]
		public void add_radio_actions (Gtk.RadioActionEntry entries, uint n_entries, int value, GLib.Callback on_change, pointer user_data);
		[NoArrayLength ()]
		[CCode (cname = "gtk_action_group_add_radio_actions_full")]
		public void add_radio_actions_full (Gtk.RadioActionEntry entries, uint n_entries, int value, GLib.Callback on_change, pointer user_data, GLib.DestroyNotify destroy);
		[NoArrayLength ()]
		[CCode (cname = "gtk_action_group_add_toggle_actions")]
		public void add_toggle_actions (Gtk.ToggleActionEntry entries, uint n_entries, pointer user_data);
		[NoArrayLength ()]
		[CCode (cname = "gtk_action_group_add_toggle_actions_full")]
		public void add_toggle_actions_full (Gtk.ToggleActionEntry entries, uint n_entries, pointer user_data, GLib.DestroyNotify destroy);
		[NoArrayLength ()]
		[CCode (cname = "gtk_action_group_get_action")]
		public virtual Gtk.Action get_action (string action_name);
		[NoArrayLength ()]
		[CCode (cname = "gtk_action_group_get_name")]
		public string get_name ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_action_group_get_sensitive")]
		public bool get_sensitive ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_action_group_get_type")]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_action_group_get_visible")]
		public bool get_visible ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_action_group_list_actions")]
		public GLib.List list_actions ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_action_group_new")]
		public construct (string name);
		[NoArrayLength ()]
		[CCode (cname = "gtk_action_group_remove_action")]
		public void remove_action (Gtk.Action action);
		[NoArrayLength ()]
		[CCode (cname = "gtk_action_group_set_sensitive")]
		public void set_sensitive (bool sensitive);
		[NoArrayLength ()]
		[CCode (cname = "gtk_action_group_set_translate_func")]
		public void set_translate_func (Gtk.TranslateFunc func, pointer data, Gtk.DestroyNotify notify);
		[NoArrayLength ()]
		[CCode (cname = "gtk_action_group_set_translation_domain")]
		public void set_translation_domain (string domain);
		[NoArrayLength ()]
		[CCode (cname = "gtk_action_group_set_visible")]
		public void set_visible (bool visible);
		[NoArrayLength ()]
		[CCode (cname = "gtk_action_group_translate_string")]
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
	[CCode (cheader_filename = "gtk/gtk.h")]
	public class Adjustment : Gtk.Object {
		[NoArrayLength ()]
		[CCode (cname = "gtk_adjustment_clamp_page")]
		public void clamp_page (double lower, double upper);
		[NoArrayLength ()]
		[CCode (cname = "gtk_adjustment_get_type")]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_adjustment_get_value")]
		public double get_value ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_adjustment_new")]
		public construct (double value, double lower, double upper, double step_increment, double page_increment, double page_size);
		[NoArrayLength ()]
		[CCode (cname = "gtk_adjustment_set_value")]
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
	[CCode (cheader_filename = "gtk/gtk.h")]
	public class Alignment : Gtk.Bin {
		[NoArrayLength ()]
		[CCode (cname = "gtk_alignment_get_padding")]
		public void get_padding (uint padding_top, uint padding_bottom, uint padding_left, uint padding_right);
		[NoArrayLength ()]
		[CCode (cname = "gtk_alignment_get_type")]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_alignment_new")]
		public construct (float xalign, float yalign, float xscale, float yscale);
		[NoArrayLength ()]
		[CCode (cname = "gtk_alignment_set")]
		public void @set (float xalign, float yalign, float xscale, float yscale);
		[NoArrayLength ()]
		[CCode (cname = "gtk_alignment_set_padding")]
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
	[CCode (cheader_filename = "gtk/gtk.h")]
	public class Arrow : Gtk.Misc {
		[NoArrayLength ()]
		[CCode (cname = "gtk_arrow_get_type")]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_arrow_new")]
		public construct (Gtk.ArrowType arrow_type, Gtk.ShadowType shadow_type);
		[NoArrayLength ()]
		[CCode (cname = "gtk_arrow_set")]
		public void @set (Gtk.ArrowType arrow_type, Gtk.ShadowType shadow_type);
		[NoAccessorMethod ()]
		public weak Gtk.ArrowType arrow_type { get; set; }
		[NoAccessorMethod ()]
		public weak Gtk.ShadowType shadow_type { get; set; }
	}
	[CCode (cheader_filename = "gtk/gtk.h")]
	public class AspectFrame : Gtk.Frame {
		[NoArrayLength ()]
		[CCode (cname = "gtk_aspect_frame_get_type")]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_aspect_frame_new")]
		public construct (string label, float xalign, float yalign, float ratio, bool obey_child);
		[NoArrayLength ()]
		[CCode (cname = "gtk_aspect_frame_set")]
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
	[CCode (cheader_filename = "gtk/gtk.h")]
	public class Assistant : Gtk.Window {
		[NoArrayLength ()]
		[CCode (cname = "gtk_assistant_add_action_widget")]
		public void add_action_widget (Gtk.Widget child);
		[NoArrayLength ()]
		[CCode (cname = "gtk_assistant_append_page")]
		public int append_page (Gtk.Widget page);
		[NoArrayLength ()]
		[CCode (cname = "gtk_assistant_get_current_page")]
		public int get_current_page ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_assistant_get_n_pages")]
		public int get_n_pages ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_assistant_get_nth_page")]
		public Gtk.Widget get_nth_page (int page_num);
		[NoArrayLength ()]
		[CCode (cname = "gtk_assistant_get_page_complete")]
		public bool get_page_complete (Gtk.Widget page);
		[NoArrayLength ()]
		[CCode (cname = "gtk_assistant_get_page_header_image")]
		public Gdk.Pixbuf get_page_header_image (Gtk.Widget page);
		[NoArrayLength ()]
		[CCode (cname = "gtk_assistant_get_page_side_image")]
		public Gdk.Pixbuf get_page_side_image (Gtk.Widget page);
		[NoArrayLength ()]
		[CCode (cname = "gtk_assistant_get_page_title")]
		public string get_page_title (Gtk.Widget page);
		[NoArrayLength ()]
		[CCode (cname = "gtk_assistant_get_page_type")]
		public Gtk.AssistantPageType get_page_type (Gtk.Widget page);
		[NoArrayLength ()]
		[CCode (cname = "gtk_assistant_get_type")]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_assistant_insert_page")]
		public int insert_page (Gtk.Widget page, int position);
		[NoArrayLength ()]
		[CCode (cname = "gtk_assistant_new")]
		public construct ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_assistant_prepend_page")]
		public int prepend_page (Gtk.Widget page);
		[NoArrayLength ()]
		[CCode (cname = "gtk_assistant_remove_action_widget")]
		public void remove_action_widget (Gtk.Widget child);
		[NoArrayLength ()]
		[CCode (cname = "gtk_assistant_set_current_page")]
		public void set_current_page (int page_num);
		[NoArrayLength ()]
		[CCode (cname = "gtk_assistant_set_forward_page_func")]
		public void set_forward_page_func (Gtk.AssistantPageFunc page_func, pointer data, GLib.DestroyNotify destroy);
		[NoArrayLength ()]
		[CCode (cname = "gtk_assistant_set_page_complete")]
		public void set_page_complete (Gtk.Widget page, bool complete);
		[NoArrayLength ()]
		[CCode (cname = "gtk_assistant_set_page_header_image")]
		public void set_page_header_image (Gtk.Widget page, Gdk.Pixbuf pixbuf);
		[NoArrayLength ()]
		[CCode (cname = "gtk_assistant_set_page_side_image")]
		public void set_page_side_image (Gtk.Widget page, Gdk.Pixbuf pixbuf);
		[NoArrayLength ()]
		[CCode (cname = "gtk_assistant_set_page_title")]
		public void set_page_title (Gtk.Widget page, string title);
		[NoArrayLength ()]
		[CCode (cname = "gtk_assistant_set_page_type")]
		public void set_page_type (Gtk.Widget page, Gtk.AssistantPageType type);
		[NoArrayLength ()]
		[CCode (cname = "gtk_assistant_update_buttons_state")]
		public void update_buttons_state ();
		public signal void cancel ();
		public signal void prepare (Gtk.Widget page);
		public signal void apply ();
		public signal void close ();
	}
	[CCode (cheader_filename = "gtk/gtk.h")]
	public class Bin : Gtk.Container {
		[NoArrayLength ()]
		[CCode (cname = "gtk_bin_get_child")]
		public Gtk.Widget get_child ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_bin_get_type")]
		public static GLib.Type get_type ();
	}
	[CCode (cheader_filename = "gtk/gtk.h")]
	public class Box : Gtk.Container {
		public weak GLib.List children;
		[NoArrayLength ()]
		[CCode (cname = "gtk_box_get_homogeneous")]
		public bool get_homogeneous ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_box_get_spacing")]
		public int get_spacing ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_box_get_type")]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_box_pack_end")]
		public void pack_end (Gtk.Widget child, bool expand, bool fill, uint padding);
		[NoArrayLength ()]
		[CCode (cname = "gtk_box_pack_end_defaults")]
		public void pack_end_defaults (Gtk.Widget widget);
		[NoArrayLength ()]
		[CCode (cname = "gtk_box_pack_start")]
		public void pack_start (Gtk.Widget child, bool expand, bool fill, uint padding);
		[NoArrayLength ()]
		[CCode (cname = "gtk_box_pack_start_defaults")]
		public void pack_start_defaults (Gtk.Widget widget);
		[NoArrayLength ()]
		[CCode (cname = "gtk_box_query_child_packing")]
		public void query_child_packing (Gtk.Widget child, bool expand, bool fill, uint padding, Gtk.PackType pack_type);
		[NoArrayLength ()]
		[CCode (cname = "gtk_box_reorder_child")]
		public void reorder_child (Gtk.Widget child, int position);
		[NoArrayLength ()]
		[CCode (cname = "gtk_box_set_child_packing")]
		public void set_child_packing (Gtk.Widget child, bool expand, bool fill, uint padding, Gtk.PackType pack_type);
		[NoArrayLength ()]
		[CCode (cname = "gtk_box_set_homogeneous")]
		public void set_homogeneous (bool homogeneous);
		[NoArrayLength ()]
		[CCode (cname = "gtk_box_set_spacing")]
		public void set_spacing (int spacing);
		public weak int spacing { get; set; }
		public weak bool homogeneous { get; set; }
	}
	[CCode (cheader_filename = "gtk/gtk.h")]
	public class Button : Gtk.Bin {
		[NoArrayLength ()]
		[CCode (cname = "gtk_button_action_get_type")]
		public static GLib.Type action_get_type ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_button_get_alignment")]
		public void get_alignment (float xalign, float yalign);
		[NoArrayLength ()]
		[CCode (cname = "gtk_button_get_focus_on_click")]
		public bool get_focus_on_click ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_button_get_image")]
		public Gtk.Widget get_image ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_button_get_image_position")]
		public Gtk.PositionType get_image_position ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_button_get_label")]
		public string get_label ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_button_get_relief")]
		public Gtk.ReliefStyle get_relief ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_button_get_type")]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_button_get_use_stock")]
		public bool get_use_stock ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_button_get_use_underline")]
		public bool get_use_underline ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_button_new")]
		public construct ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_button_new_from_stock")]
		public construct from_stock (string stock_id);
		[NoArrayLength ()]
		[CCode (cname = "gtk_button_new_with_label")]
		public construct with_label (string label);
		[NoArrayLength ()]
		[CCode (cname = "gtk_button_new_with_mnemonic")]
		public construct with_mnemonic (string label);
		[NoArrayLength ()]
		[CCode (cname = "gtk_button_set_alignment")]
		public void set_alignment (float xalign, float yalign);
		[NoArrayLength ()]
		[CCode (cname = "gtk_button_set_focus_on_click")]
		public void set_focus_on_click (bool focus_on_click);
		[NoArrayLength ()]
		[CCode (cname = "gtk_button_set_image")]
		public void set_image (Gtk.Widget image);
		[NoArrayLength ()]
		[CCode (cname = "gtk_button_set_image_position")]
		public void set_image_position (Gtk.PositionType position);
		[NoArrayLength ()]
		[CCode (cname = "gtk_button_set_label")]
		public void set_label (string label);
		[NoArrayLength ()]
		[CCode (cname = "gtk_button_set_relief")]
		public void set_relief (Gtk.ReliefStyle newstyle);
		[NoArrayLength ()]
		[CCode (cname = "gtk_button_set_use_stock")]
		public void set_use_stock (bool use_stock);
		[NoArrayLength ()]
		[CCode (cname = "gtk_button_set_use_underline")]
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
	[CCode (cheader_filename = "gtk/gtk.h")]
	public class ButtonBox : Gtk.Box {
		[NoArrayLength ()]
		[CCode (cname = "gtk_button_box_get_child_secondary")]
		public bool get_child_secondary (Gtk.Widget child);
		[NoArrayLength ()]
		[CCode (cname = "gtk_button_box_get_layout")]
		public Gtk.ButtonBoxStyle get_layout ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_button_box_get_type")]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_button_box_set_child_secondary")]
		public void set_child_secondary (Gtk.Widget child, bool is_secondary);
		[NoArrayLength ()]
		[CCode (cname = "gtk_button_box_set_layout")]
		public void set_layout (Gtk.ButtonBoxStyle layout_style);
		[NoAccessorMethod ()]
		public weak Gtk.ButtonBoxStyle layout_style { get; set; }
	}
	[CCode (cheader_filename = "gtk/gtk.h")]
	public class Calendar : Gtk.Widget {
		[NoArrayLength ()]
		[CCode (cname = "gtk_calendar_clear_marks")]
		public void clear_marks ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_calendar_get_date")]
		public void get_date (uint year, uint month, uint day);
		[NoArrayLength ()]
		[CCode (cname = "gtk_calendar_get_display_options")]
		public Gtk.CalendarDisplayOptions get_display_options ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_calendar_get_type")]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_calendar_mark_day")]
		public bool mark_day (uint day);
		[NoArrayLength ()]
		[CCode (cname = "gtk_calendar_new")]
		public construct ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_calendar_select_day")]
		public void select_day (uint day);
		[NoArrayLength ()]
		[CCode (cname = "gtk_calendar_select_month")]
		public bool select_month (uint month, uint year);
		[NoArrayLength ()]
		[CCode (cname = "gtk_calendar_set_display_options")]
		public void set_display_options (Gtk.CalendarDisplayOptions @flags);
		[NoArrayLength ()]
		[CCode (cname = "gtk_calendar_unmark_day")]
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
	[CCode (cheader_filename = "gtk/gtk.h")]
	public class CellRenderer : Gtk.Object {
		[NoArrayLength ()]
		[CCode (cname = "gtk_cell_renderer_activate")]
		public virtual bool activate (Gdk.Event event, Gtk.Widget widget, string path, Gdk.Rectangle background_area, Gdk.Rectangle cell_area, Gtk.CellRendererState @flags);
		[NoArrayLength ()]
		[CCode (cname = "gtk_cell_renderer_get_fixed_size")]
		public void get_fixed_size (int width, int height);
		[NoArrayLength ()]
		[CCode (cname = "gtk_cell_renderer_get_size")]
		public virtual void get_size (Gtk.Widget widget, Gdk.Rectangle cell_area, int x_offset, int y_offset, int width, int height);
		[NoArrayLength ()]
		[CCode (cname = "gtk_cell_renderer_get_type")]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_cell_renderer_render")]
		public virtual void render (Gdk.Window window, Gtk.Widget widget, Gdk.Rectangle background_area, Gdk.Rectangle cell_area, Gdk.Rectangle expose_area, Gtk.CellRendererState @flags);
		[NoArrayLength ()]
		[CCode (cname = "gtk_cell_renderer_set_fixed_size")]
		public void set_fixed_size (int width, int height);
		[NoArrayLength ()]
		[CCode (cname = "gtk_cell_renderer_start_editing")]
		public virtual Gtk.CellEditable start_editing (Gdk.Event event, Gtk.Widget widget, string path, Gdk.Rectangle background_area, Gdk.Rectangle cell_area, Gtk.CellRendererState @flags);
		[NoArrayLength ()]
		[CCode (cname = "gtk_cell_renderer_stop_editing")]
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
	[CCode (cheader_filename = "gtk/gtk.h")]
	public class CellRendererAccel : Gtk.CellRendererText {
		[NoArrayLength ()]
		[CCode (cname = "gtk_cell_renderer_accel_get_type")]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_cell_renderer_accel_new")]
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
	[CCode (cheader_filename = "gtk/gtk.h")]
	public class CellRendererCombo : Gtk.CellRendererText {
		[NoArrayLength ()]
		[CCode (cname = "gtk_cell_renderer_combo_get_type")]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_cell_renderer_combo_new")]
		public construct ();
		[NoAccessorMethod ()]
		public weak Gtk.TreeModel model { get; set; }
		[NoAccessorMethod ()]
		public weak int text_column { get; set; }
		[NoAccessorMethod ()]
		public weak bool has_entry { get; set; }
	}
	[CCode (cheader_filename = "gtk/gtk.h")]
	public class CellRendererPixbuf : Gtk.CellRenderer {
		[NoArrayLength ()]
		[CCode (cname = "gtk_cell_renderer_pixbuf_get_type")]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_cell_renderer_pixbuf_new")]
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
	[CCode (cheader_filename = "gtk/gtk.h")]
	public class CellRendererProgress : Gtk.CellRenderer {
		[NoArrayLength ()]
		[CCode (cname = "gtk_cell_renderer_progress_get_type")]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_cell_renderer_progress_new")]
		public construct ();
		[NoAccessorMethod ()]
		public weak int value { get; set; }
		[NoAccessorMethod ()]
		public weak string text { get; set; }
	}
	[CCode (cheader_filename = "gtk/gtk.h")]
	public class CellRendererSpin : Gtk.CellRendererText {
		[NoArrayLength ()]
		[CCode (cname = "gtk_cell_renderer_spin_get_type")]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_cell_renderer_spin_new")]
		public construct ();
		[NoAccessorMethod ()]
		public weak Gtk.Adjustment adjustment { get; set; }
		[NoAccessorMethod ()]
		public weak double climb_rate { get; set; }
		[NoAccessorMethod ()]
		public weak uint digits { get; set; }
	}
	[CCode (cheader_filename = "gtk/gtk.h")]
	public class CellRendererText : Gtk.CellRenderer {
		[NoArrayLength ()]
		[CCode (cname = "gtk_cell_renderer_text_get_type")]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_cell_renderer_text_new")]
		public construct ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_cell_renderer_text_set_fixed_height_from_font")]
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
	[CCode (cheader_filename = "gtk/gtk.h")]
	public class CellRendererToggle : Gtk.CellRenderer {
		[NoArrayLength ()]
		[CCode (cname = "gtk_cell_renderer_toggle_get_active")]
		public bool get_active ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_cell_renderer_toggle_get_radio")]
		public bool get_radio ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_cell_renderer_toggle_get_type")]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_cell_renderer_toggle_new")]
		public construct ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_cell_renderer_toggle_set_active")]
		public void set_active (bool setting);
		[NoArrayLength ()]
		[CCode (cname = "gtk_cell_renderer_toggle_set_radio")]
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
	[CCode (cheader_filename = "gtk/gtk.h")]
	public class CellView : Gtk.Widget, Gtk.CellLayout {
		[NoArrayLength ()]
		[CCode (cname = "gtk_cell_view_get_cell_renderers")]
		public GLib.List get_cell_renderers ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_cell_view_get_displayed_row")]
		public Gtk.TreePath get_displayed_row ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_cell_view_get_size_of_row")]
		public bool get_size_of_row (Gtk.TreePath path, Gtk.Requisition requisition);
		[NoArrayLength ()]
		[CCode (cname = "gtk_cell_view_get_type")]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_cell_view_new")]
		public construct ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_cell_view_new_with_markup")]
		public construct with_markup (string markup);
		[NoArrayLength ()]
		[CCode (cname = "gtk_cell_view_new_with_pixbuf")]
		public construct with_pixbuf (Gdk.Pixbuf pixbuf);
		[NoArrayLength ()]
		[CCode (cname = "gtk_cell_view_new_with_text")]
		public construct with_text (string text);
		[NoArrayLength ()]
		[CCode (cname = "gtk_cell_view_set_background_color")]
		public void set_background_color (Gdk.Color color);
		[NoArrayLength ()]
		[CCode (cname = "gtk_cell_view_set_displayed_row")]
		public void set_displayed_row (Gtk.TreePath path);
		[NoArrayLength ()]
		[CCode (cname = "gtk_cell_view_set_model")]
		public void set_model (Gtk.TreeModel model);
		[NoAccessorMethod ()]
		public weak string background { set; }
		[NoAccessorMethod ()]
		public weak Gdk.Color background_gdk { get; set; }
		[NoAccessorMethod ()]
		public weak Gtk.TreeModel model { get; set; }
	}
	[CCode (cheader_filename = "gtk/gtk.h")]
	public class CheckButton : Gtk.ToggleButton {
		[NoArrayLength ()]
		[CCode (cname = "gtk_check_button_get_type")]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_check_button_new")]
		public construct ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_check_button_new_with_label")]
		public construct with_label (string label);
		[NoArrayLength ()]
		[CCode (cname = "gtk_check_button_new_with_mnemonic")]
		public construct with_mnemonic (string label);
	}
	[CCode (cheader_filename = "gtk/gtk.h")]
	public class CheckMenuItem : Gtk.MenuItem {
		[NoArrayLength ()]
		[CCode (cname = "gtk_check_menu_item_get_active")]
		public bool get_active ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_check_menu_item_get_draw_as_radio")]
		public bool get_draw_as_radio ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_check_menu_item_get_inconsistent")]
		public bool get_inconsistent ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_check_menu_item_get_type")]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_check_menu_item_new")]
		public construct ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_check_menu_item_new_with_label")]
		public construct with_label (string label);
		[NoArrayLength ()]
		[CCode (cname = "gtk_check_menu_item_new_with_mnemonic")]
		public construct with_mnemonic (string label);
		[NoArrayLength ()]
		[CCode (cname = "gtk_check_menu_item_set_active")]
		public void set_active (bool is_active);
		[NoArrayLength ()]
		[CCode (cname = "gtk_check_menu_item_set_draw_as_radio")]
		public void set_draw_as_radio (bool draw_as_radio);
		[NoArrayLength ()]
		[CCode (cname = "gtk_check_menu_item_set_inconsistent")]
		public void set_inconsistent (bool setting);
		public weak bool active { get; set; }
		public weak bool inconsistent { get; set; }
		public weak bool draw_as_radio { get; set; }
		[HasEmitter ()]
		public signal void toggled ();
	}
	[CCode (cheader_filename = "gtk/gtk.h")]
	public class Clipboard : GLib.Object {
		[NoArrayLength ()]
		[CCode (cname = "gtk_clipboard_clear")]
		public void clear ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_clipboard_get")]
		public static Gtk.Clipboard @get (Gdk.Atom selection);
		[NoArrayLength ()]
		[CCode (cname = "gtk_clipboard_get_display")]
		public Gdk.Display get_display ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_clipboard_get_for_display")]
		public static Gtk.Clipboard get_for_display (Gdk.Display display, Gdk.Atom selection);
		[NoArrayLength ()]
		[CCode (cname = "gtk_clipboard_get_owner")]
		public GLib.Object get_owner ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_clipboard_get_type")]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_clipboard_request_contents")]
		public void request_contents (Gdk.Atom target, Gtk.ClipboardReceivedFunc @callback, pointer user_data);
		[NoArrayLength ()]
		[CCode (cname = "gtk_clipboard_request_image")]
		public void request_image (Gtk.ClipboardImageReceivedFunc @callback, pointer user_data);
		[NoArrayLength ()]
		[CCode (cname = "gtk_clipboard_request_rich_text")]
		public void request_rich_text (Gtk.TextBuffer buffer, Gtk.ClipboardRichTextReceivedFunc @callback, pointer user_data);
		[NoArrayLength ()]
		[CCode (cname = "gtk_clipboard_request_targets")]
		public void request_targets (Gtk.ClipboardTargetsReceivedFunc @callback, pointer user_data);
		[NoArrayLength ()]
		[CCode (cname = "gtk_clipboard_request_text")]
		public void request_text (Gtk.ClipboardTextReceivedFunc @callback, pointer user_data);
		[NoArrayLength ()]
		[CCode (cname = "gtk_clipboard_set_can_store")]
		public void set_can_store (Gtk.TargetEntry targets, int n_targets);
		[NoArrayLength ()]
		[CCode (cname = "gtk_clipboard_set_image")]
		public void set_image (Gdk.Pixbuf pixbuf);
		[NoArrayLength ()]
		[CCode (cname = "gtk_clipboard_set_text")]
		public void set_text (string text, int len);
		[NoArrayLength ()]
		[CCode (cname = "gtk_clipboard_set_with_data")]
		public bool set_with_data (Gtk.TargetEntry targets, uint n_targets, Gtk.ClipboardGetFunc get_func, Gtk.ClipboardClearFunc clear_func, pointer user_data);
		[NoArrayLength ()]
		[CCode (cname = "gtk_clipboard_set_with_owner")]
		public bool set_with_owner (Gtk.TargetEntry targets, uint n_targets, Gtk.ClipboardGetFunc get_func, Gtk.ClipboardClearFunc clear_func, GLib.Object owner);
		[NoArrayLength ()]
		[CCode (cname = "gtk_clipboard_store")]
		public void store ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_clipboard_wait_for_contents")]
		public Gtk.SelectionData wait_for_contents (Gdk.Atom target);
		[NoArrayLength ()]
		[CCode (cname = "gtk_clipboard_wait_for_image")]
		public Gdk.Pixbuf wait_for_image ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_clipboard_wait_for_rich_text")]
		public uchar wait_for_rich_text (Gtk.TextBuffer buffer, Gdk.Atom format, ulong length);
		[NoArrayLength ()]
		[CCode (cname = "gtk_clipboard_wait_for_targets")]
		public bool wait_for_targets (Gdk.Atom targets, int n_targets);
		[NoArrayLength ()]
		[CCode (cname = "gtk_clipboard_wait_for_text")]
		public string wait_for_text ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_clipboard_wait_is_image_available")]
		public bool wait_is_image_available ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_clipboard_wait_is_rich_text_available")]
		public bool wait_is_rich_text_available (Gtk.TextBuffer buffer);
		[NoArrayLength ()]
		[CCode (cname = "gtk_clipboard_wait_is_target_available")]
		public bool wait_is_target_available (Gdk.Atom target);
		[NoArrayLength ()]
		[CCode (cname = "gtk_clipboard_wait_is_text_available")]
		public bool wait_is_text_available ();
		public signal void owner_change (Gdk.EventOwnerChange event);
	}
	[CCode (cheader_filename = "gtk/gtk.h")]
	public class ColorButton : Gtk.Button {
		[NoArrayLength ()]
		[CCode (cname = "gtk_color_button_get_alpha")]
		public ushort get_alpha ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_color_button_get_color")]
		public void get_color (Gdk.Color color);
		[NoArrayLength ()]
		[CCode (cname = "gtk_color_button_get_title")]
		public string get_title ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_color_button_get_type")]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_color_button_get_use_alpha")]
		public bool get_use_alpha ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_color_button_new")]
		public construct ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_color_button_new_with_color")]
		public construct with_color (Gdk.Color color);
		[NoArrayLength ()]
		[CCode (cname = "gtk_color_button_set_alpha")]
		public void set_alpha (ushort alpha);
		[NoArrayLength ()]
		[CCode (cname = "gtk_color_button_set_color")]
		public void set_color (Gdk.Color color);
		[NoArrayLength ()]
		[CCode (cname = "gtk_color_button_set_title")]
		public void set_title (string title);
		[NoArrayLength ()]
		[CCode (cname = "gtk_color_button_set_use_alpha")]
		public void set_use_alpha (bool use_alpha);
		public weak bool use_alpha { get; set; }
		public weak string title { get; set; }
		public weak Gdk.Color color { get; set; }
		public weak uint alpha { get; set; }
		public signal void color_set ();
	}
	[CCode (cheader_filename = "gtk/gtk.h")]
	public class ColorSelection : Gtk.VBox {
		[NoArrayLength ()]
		[CCode (cname = "gtk_color_selection_get_current_alpha")]
		public ushort get_current_alpha ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_color_selection_get_current_color")]
		public void get_current_color (Gdk.Color color);
		[NoArrayLength ()]
		[CCode (cname = "gtk_color_selection_get_has_opacity_control")]
		public bool get_has_opacity_control ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_color_selection_get_has_palette")]
		public bool get_has_palette ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_color_selection_get_previous_alpha")]
		public ushort get_previous_alpha ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_color_selection_get_previous_color")]
		public void get_previous_color (Gdk.Color color);
		[NoArrayLength ()]
		[CCode (cname = "gtk_color_selection_get_type")]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_color_selection_is_adjusting")]
		public bool is_adjusting ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_color_selection_new")]
		public construct ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_color_selection_palette_from_string")]
		public static bool palette_from_string (string str, Gdk.Color colors, int n_colors);
		[NoArrayLength ()]
		[CCode (cname = "gtk_color_selection_palette_to_string")]
		public static string palette_to_string (Gdk.Color colors, int n_colors);
		[NoArrayLength ()]
		[CCode (cname = "gtk_color_selection_set_change_palette_with_screen_hook")]
		public static Gtk.ColorSelectionChangePaletteWithScreenFunc set_change_palette_with_screen_hook (Gtk.ColorSelectionChangePaletteWithScreenFunc func);
		[NoArrayLength ()]
		[CCode (cname = "gtk_color_selection_set_current_alpha")]
		public void set_current_alpha (ushort alpha);
		[NoArrayLength ()]
		[CCode (cname = "gtk_color_selection_set_current_color")]
		public void set_current_color (Gdk.Color color);
		[NoArrayLength ()]
		[CCode (cname = "gtk_color_selection_set_has_opacity_control")]
		public void set_has_opacity_control (bool has_opacity);
		[NoArrayLength ()]
		[CCode (cname = "gtk_color_selection_set_has_palette")]
		public void set_has_palette (bool has_palette);
		[NoArrayLength ()]
		[CCode (cname = "gtk_color_selection_set_previous_alpha")]
		public void set_previous_alpha (ushort alpha);
		[NoArrayLength ()]
		[CCode (cname = "gtk_color_selection_set_previous_color")]
		public void set_previous_color (Gdk.Color color);
		public weak bool has_opacity_control { get; set; }
		public weak bool has_palette { get; set; }
		public weak Gdk.Color current_color { get; set; }
		public weak uint current_alpha { get; set; }
		public signal void color_changed ();
	}
	[CCode (cheader_filename = "gtk/gtk.h")]
	public class ColorSelectionDialog : Gtk.Dialog {
		[NoArrayLength ()]
		[CCode (cname = "gtk_color_selection_dialog_get_type")]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_color_selection_dialog_new")]
		public construct (string title);
	}
	[CCode (cheader_filename = "gtk/gtk.h")]
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
	[CCode (cheader_filename = "gtk/gtk.h")]
	public class ComboBox : Gtk.Bin, Gtk.CellLayout, Gtk.CellEditable {
		[NoArrayLength ()]
		[CCode (cname = "gtk_combo_box_append_text")]
		public void append_text (string text);
		[NoArrayLength ()]
		[CCode (cname = "gtk_combo_box_get_active")]
		public int get_active ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_combo_box_get_active_iter")]
		public bool get_active_iter (Gtk.TreeIter iter);
		[NoArrayLength ()]
		[CCode (cname = "gtk_combo_box_get_active_text")]
		public virtual string get_active_text ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_combo_box_get_add_tearoffs")]
		public bool get_add_tearoffs ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_combo_box_get_column_span_column")]
		public int get_column_span_column ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_combo_box_get_focus_on_click")]
		public bool get_focus_on_click ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_combo_box_get_model")]
		public Gtk.TreeModel get_model ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_combo_box_get_popup_accessible")]
		public Atk.Object get_popup_accessible ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_combo_box_get_row_separator_func")]
		public Gtk.TreeViewRowSeparatorFunc get_row_separator_func ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_combo_box_get_row_span_column")]
		public int get_row_span_column ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_combo_box_get_title")]
		public string get_title ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_combo_box_get_type")]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_combo_box_get_wrap_width")]
		public int get_wrap_width ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_combo_box_insert_text")]
		public void insert_text (int position, string text);
		[NoArrayLength ()]
		[CCode (cname = "gtk_combo_box_new")]
		public construct ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_combo_box_new_text")]
		public construct text ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_combo_box_new_with_model")]
		public construct with_model (Gtk.TreeModel model);
		[NoArrayLength ()]
		[CCode (cname = "gtk_combo_box_popdown")]
		public void popdown ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_combo_box_popup")]
		public void popup ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_combo_box_prepend_text")]
		public void prepend_text (string text);
		[NoArrayLength ()]
		[CCode (cname = "gtk_combo_box_remove_text")]
		public void remove_text (int position);
		[NoArrayLength ()]
		[CCode (cname = "gtk_combo_box_set_active")]
		public void set_active (int index_);
		[NoArrayLength ()]
		[CCode (cname = "gtk_combo_box_set_active_iter")]
		public void set_active_iter (Gtk.TreeIter iter);
		[NoArrayLength ()]
		[CCode (cname = "gtk_combo_box_set_add_tearoffs")]
		public void set_add_tearoffs (bool add_tearoffs);
		[NoArrayLength ()]
		[CCode (cname = "gtk_combo_box_set_column_span_column")]
		public void set_column_span_column (int column_span);
		[NoArrayLength ()]
		[CCode (cname = "gtk_combo_box_set_focus_on_click")]
		public void set_focus_on_click (bool focus_on_click);
		[NoArrayLength ()]
		[CCode (cname = "gtk_combo_box_set_model")]
		public void set_model (Gtk.TreeModel model);
		[NoArrayLength ()]
		[CCode (cname = "gtk_combo_box_set_row_separator_func")]
		public void set_row_separator_func (Gtk.TreeViewRowSeparatorFunc func, pointer data, Gtk.DestroyNotify destroy);
		[NoArrayLength ()]
		[CCode (cname = "gtk_combo_box_set_row_span_column")]
		public void set_row_span_column (int row_span);
		[NoArrayLength ()]
		[CCode (cname = "gtk_combo_box_set_title")]
		public void set_title (string title);
		[NoArrayLength ()]
		[CCode (cname = "gtk_combo_box_set_wrap_width")]
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
	[CCode (cheader_filename = "gtk/gtk.h")]
	public class ComboBoxEntry : Gtk.ComboBox {
		[NoArrayLength ()]
		[CCode (cname = "gtk_combo_box_entry_get_text_column")]
		public int get_text_column ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_combo_box_entry_get_type")]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_combo_box_entry_new")]
		public construct ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_combo_box_entry_new_text")]
		public construct text ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_combo_box_entry_new_with_model")]
		public construct with_model (Gtk.TreeModel model, int text_column);
		[NoArrayLength ()]
		[CCode (cname = "gtk_combo_box_entry_set_text_column")]
		public void set_text_column (int text_column);
		public weak int text_column { get; set; }
	}
	[CCode (cheader_filename = "gtk/gtk.h")]
	public class Container : Gtk.Widget {
		[NoArrayLength ()]
		[CCode (cname = "gtk_container_add_with_properties")]
		public void add_with_properties (Gtk.Widget widget, string first_prop_name);
		[NoArrayLength ()]
		[CCode (cname = "gtk_container_child_get")]
		public void child_get (Gtk.Widget child, string first_prop_name);
		[NoArrayLength ()]
		[CCode (cname = "gtk_container_child_get_property")]
		public void child_get_property (Gtk.Widget child, string property_name, GLib.Value value);
		[NoArrayLength ()]
		[CCode (cname = "gtk_container_child_get_valist")]
		public void child_get_valist (Gtk.Widget child, string first_property_name, pointer var_args);
		[NoArrayLength ()]
		[CCode (cname = "gtk_container_child_set")]
		public void child_set (Gtk.Widget child, string first_prop_name);
		[NoArrayLength ()]
		[CCode (cname = "gtk_container_child_set_property")]
		public void child_set_property (Gtk.Widget child, string property_name, GLib.Value value);
		[NoArrayLength ()]
		[CCode (cname = "gtk_container_child_set_valist")]
		public void child_set_valist (Gtk.Widget child, string first_property_name, pointer var_args);
		[NoArrayLength ()]
		[CCode (cname = "gtk_container_child_type")]
		public virtual GLib.Type child_type ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_container_class_find_child_property")]
		public static GLib.ParamSpec class_find_child_property (pointer cclass, string property_name);
		[NoArrayLength ()]
		[CCode (cname = "gtk_container_class_install_child_property")]
		public static void class_install_child_property (pointer cclass, uint property_id, GLib.ParamSpec pspec);
		[NoArrayLength ()]
		[CCode (cname = "gtk_container_class_list_child_properties")]
		public static GLib.ParamSpec class_list_child_properties (pointer cclass, uint n_properties);
		[NoArrayLength ()]
		[CCode (cname = "gtk_container_forall")]
		public virtual void forall (Gtk.Callback @callback, pointer callback_data);
		[NoArrayLength ()]
		[CCode (cname = "gtk_container_foreach")]
		public void @foreach (Gtk.Callback @callback, pointer callback_data);
		[NoArrayLength ()]
		[CCode (cname = "gtk_container_get_border_width")]
		public uint get_border_width ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_container_get_children")]
		public GLib.List get_children ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_container_get_focus_chain")]
		public bool get_focus_chain (GLib.List focusable_widgets);
		[NoArrayLength ()]
		[CCode (cname = "gtk_container_get_focus_hadjustment")]
		public Gtk.Adjustment get_focus_hadjustment ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_container_get_focus_vadjustment")]
		public Gtk.Adjustment get_focus_vadjustment ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_container_get_resize_mode")]
		public Gtk.ResizeMode get_resize_mode ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_container_get_type")]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_container_propagate_expose")]
		public void propagate_expose (Gtk.Widget child, Gdk.EventExpose event);
		[NoArrayLength ()]
		[CCode (cname = "gtk_container_resize_children")]
		public void resize_children ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_container_set_border_width")]
		public void set_border_width (uint border_width);
		[NoArrayLength ()]
		[CCode (cname = "gtk_container_set_focus_chain")]
		public void set_focus_chain (GLib.List focusable_widgets);
		[NoArrayLength ()]
		[CCode (cname = "gtk_container_set_focus_hadjustment")]
		public void set_focus_hadjustment (Gtk.Adjustment adjustment);
		[NoArrayLength ()]
		[CCode (cname = "gtk_container_set_focus_vadjustment")]
		public void set_focus_vadjustment (Gtk.Adjustment adjustment);
		[NoArrayLength ()]
		[CCode (cname = "gtk_container_set_reallocate_redraws")]
		public void set_reallocate_redraws (bool needs_redraws);
		[NoArrayLength ()]
		[CCode (cname = "gtk_container_set_resize_mode")]
		public void set_resize_mode (Gtk.ResizeMode resize_mode);
		[NoArrayLength ()]
		[CCode (cname = "gtk_container_unset_focus_chain")]
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
	[CCode (cheader_filename = "gtk/gtk.h")]
	public class Curve : Gtk.DrawingArea {
		[NoArrayLength ()]
		[CCode (cname = "gtk_curve_get_type")]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_curve_get_vector")]
		public void get_vector (int veclen, float[] vector);
		[NoArrayLength ()]
		[CCode (cname = "gtk_curve_new")]
		public construct ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_curve_reset")]
		public void reset ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_curve_set_curve_type")]
		public void set_curve_type (Gtk.CurveType type);
		[NoArrayLength ()]
		[CCode (cname = "gtk_curve_set_gamma")]
		public void set_gamma (float gamma_);
		[NoArrayLength ()]
		[CCode (cname = "gtk_curve_set_range")]
		public void set_range (float min_x, float max_x, float min_y, float max_y);
		[NoArrayLength ()]
		[CCode (cname = "gtk_curve_set_vector")]
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
	[CCode (cheader_filename = "gtk/gtk.h")]
	public class Dialog : Gtk.Window {
		public weak Gtk.Widget vbox;
		public weak Gtk.Widget action_area;
		[NoArrayLength ()]
		[CCode (cname = "gtk_dialog_add_action_widget")]
		public void add_action_widget (Gtk.Widget child, int response_id);
		[NoArrayLength ()]
		[CCode (cname = "gtk_dialog_add_button")]
		public Gtk.Widget add_button (string button_text, int response_id);
		[NoArrayLength ()]
		[CCode (cname = "gtk_dialog_add_buttons")]
		public void add_buttons (string first_button_text);
		[NoArrayLength ()]
		[CCode (cname = "gtk_dialog_get_has_separator")]
		public bool get_has_separator ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_dialog_get_response_for_widget")]
		public int get_response_for_widget (Gtk.Widget widget);
		[NoArrayLength ()]
		[CCode (cname = "gtk_dialog_get_type")]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_dialog_new")]
		public construct ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_dialog_new_with_buttons")]
		public construct with_buttons (string title, Gtk.Window parent, Gtk.DialogFlags @flags, string first_button_text);
		[NoArrayLength ()]
		[CCode (cname = "gtk_dialog_run")]
		public int run ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_dialog_set_alternative_button_order")]
		public void set_alternative_button_order (int first_response_id);
		[NoArrayLength ()]
		[CCode (cname = "gtk_dialog_set_alternative_button_order_from_array")]
		public void set_alternative_button_order_from_array (int n_params, int new_order);
		[NoArrayLength ()]
		[CCode (cname = "gtk_dialog_set_default_response")]
		public void set_default_response (int response_id);
		[NoArrayLength ()]
		[CCode (cname = "gtk_dialog_set_has_separator")]
		public void set_has_separator (bool setting);
		[NoArrayLength ()]
		[CCode (cname = "gtk_dialog_set_response_sensitive")]
		public void set_response_sensitive (int response_id, bool setting);
		public weak bool has_separator { get; set; }
		[HasEmitter ()]
		public signal void response (int response_id);
		public signal void close ();
	}
	[CCode (cheader_filename = "gtk/gtk.h")]
	public class DrawingArea : Gtk.Widget {
		[NoArrayLength ()]
		[CCode (cname = "gtk_drawing_area_get_type")]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_drawing_area_new")]
		public construct ();
	}
	[CCode (cheader_filename = "gtk/gtk.h")]
	public class Entry : Gtk.Widget, Gtk.Editable, Gtk.CellEditable {
		[NoArrayLength ()]
		[CCode (cname = "gtk_entry_get_activates_default")]
		public bool get_activates_default ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_entry_get_alignment")]
		public float get_alignment ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_entry_get_completion")]
		public Gtk.EntryCompletion get_completion ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_entry_get_has_frame")]
		public bool get_has_frame ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_entry_get_inner_border")]
		public Gtk.Border get_inner_border ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_entry_get_invisible_char")]
		public unichar get_invisible_char ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_entry_get_layout")]
		public Pango.Layout get_layout ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_entry_get_layout_offsets")]
		public void get_layout_offsets (int x, int y);
		[NoArrayLength ()]
		[CCode (cname = "gtk_entry_get_max_length")]
		public int get_max_length ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_entry_get_text")]
		public string get_text ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_entry_get_type")]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_entry_get_visibility")]
		public bool get_visibility ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_entry_get_width_chars")]
		public int get_width_chars ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_entry_layout_index_to_text_index")]
		public int layout_index_to_text_index (int layout_index);
		[NoArrayLength ()]
		[CCode (cname = "gtk_entry_new")]
		public construct ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_entry_set_activates_default")]
		public void set_activates_default (bool setting);
		[NoArrayLength ()]
		[CCode (cname = "gtk_entry_set_alignment")]
		public void set_alignment (float xalign);
		[NoArrayLength ()]
		[CCode (cname = "gtk_entry_set_completion")]
		public void set_completion (Gtk.EntryCompletion completion);
		[NoArrayLength ()]
		[CCode (cname = "gtk_entry_set_has_frame")]
		public void set_has_frame (bool setting);
		[NoArrayLength ()]
		[CCode (cname = "gtk_entry_set_inner_border")]
		public void set_inner_border (Gtk.Border border);
		[NoArrayLength ()]
		[CCode (cname = "gtk_entry_set_invisible_char")]
		public void set_invisible_char (unichar ch);
		[NoArrayLength ()]
		[CCode (cname = "gtk_entry_set_max_length")]
		public void set_max_length (int max);
		[NoArrayLength ()]
		[CCode (cname = "gtk_entry_set_text")]
		public void set_text (string text);
		[NoArrayLength ()]
		[CCode (cname = "gtk_entry_set_visibility")]
		public void set_visibility (bool visible);
		[NoArrayLength ()]
		[CCode (cname = "gtk_entry_set_width_chars")]
		public void set_width_chars (int n_chars);
		[NoArrayLength ()]
		[CCode (cname = "gtk_entry_text_index_to_layout_index")]
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
	[CCode (cheader_filename = "gtk/gtk.h")]
	public class EntryCompletion : GLib.Object, Gtk.CellLayout {
		[NoArrayLength ()]
		[CCode (cname = "gtk_entry_completion_complete")]
		public void complete ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_entry_completion_delete_action")]
		public void delete_action (int index_);
		[NoArrayLength ()]
		[CCode (cname = "gtk_entry_completion_get_entry")]
		public Gtk.Widget get_entry ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_entry_completion_get_inline_completion")]
		public bool get_inline_completion ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_entry_completion_get_minimum_key_length")]
		public int get_minimum_key_length ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_entry_completion_get_model")]
		public Gtk.TreeModel get_model ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_entry_completion_get_popup_completion")]
		public bool get_popup_completion ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_entry_completion_get_popup_set_width")]
		public bool get_popup_set_width ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_entry_completion_get_popup_single_match")]
		public bool get_popup_single_match ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_entry_completion_get_text_column")]
		public int get_text_column ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_entry_completion_get_type")]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_entry_completion_insert_action_markup")]
		public void insert_action_markup (int index_, string markup);
		[NoArrayLength ()]
		[CCode (cname = "gtk_entry_completion_insert_action_text")]
		public void insert_action_text (int index_, string text);
		[NoArrayLength ()]
		[CCode (cname = "gtk_entry_completion_new")]
		public construct ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_entry_completion_set_inline_completion")]
		public void set_inline_completion (bool inline_completion);
		[NoArrayLength ()]
		[CCode (cname = "gtk_entry_completion_set_match_func")]
		public void set_match_func (Gtk.EntryCompletionMatchFunc func, pointer func_data, GLib.DestroyNotify func_notify);
		[NoArrayLength ()]
		[CCode (cname = "gtk_entry_completion_set_minimum_key_length")]
		public void set_minimum_key_length (int length);
		[NoArrayLength ()]
		[CCode (cname = "gtk_entry_completion_set_model")]
		public void set_model (Gtk.TreeModel model);
		[NoArrayLength ()]
		[CCode (cname = "gtk_entry_completion_set_popup_completion")]
		public void set_popup_completion (bool popup_completion);
		[NoArrayLength ()]
		[CCode (cname = "gtk_entry_completion_set_popup_set_width")]
		public void set_popup_set_width (bool popup_set_width);
		[NoArrayLength ()]
		[CCode (cname = "gtk_entry_completion_set_popup_single_match")]
		public void set_popup_single_match (bool popup_single_match);
		[NoArrayLength ()]
		[CCode (cname = "gtk_entry_completion_set_text_column")]
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
	[CCode (cheader_filename = "gtk/gtk.h")]
	public class EventBox : Gtk.Bin {
		[NoArrayLength ()]
		[CCode (cname = "gtk_event_box_get_above_child")]
		public bool get_above_child ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_event_box_get_type")]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_event_box_get_visible_window")]
		public bool get_visible_window ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_event_box_new")]
		public construct ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_event_box_set_above_child")]
		public void set_above_child (bool above_child);
		[NoArrayLength ()]
		[CCode (cname = "gtk_event_box_set_visible_window")]
		public void set_visible_window (bool visible_window);
		public weak bool visible_window { get; set; }
		public weak bool above_child { get; set; }
	}
	[CCode (cheader_filename = "gtk/gtk.h")]
	public class Expander : Gtk.Bin {
		[NoArrayLength ()]
		[CCode (cname = "gtk_expander_get_expanded")]
		public bool get_expanded ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_expander_get_label")]
		public string get_label ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_expander_get_label_widget")]
		public Gtk.Widget get_label_widget ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_expander_get_spacing")]
		public int get_spacing ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_expander_get_type")]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_expander_get_use_markup")]
		public bool get_use_markup ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_expander_get_use_underline")]
		public bool get_use_underline ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_expander_new")]
		public construct (string label);
		[NoArrayLength ()]
		[CCode (cname = "gtk_expander_new_with_mnemonic")]
		public construct with_mnemonic (string label);
		[NoArrayLength ()]
		[CCode (cname = "gtk_expander_set_expanded")]
		public void set_expanded (bool expanded);
		[NoArrayLength ()]
		[CCode (cname = "gtk_expander_set_label")]
		public void set_label (string label);
		[NoArrayLength ()]
		[CCode (cname = "gtk_expander_set_label_widget")]
		public void set_label_widget (Gtk.Widget label_widget);
		[NoArrayLength ()]
		[CCode (cname = "gtk_expander_set_spacing")]
		public void set_spacing (int spacing);
		[NoArrayLength ()]
		[CCode (cname = "gtk_expander_set_use_markup")]
		public void set_use_markup (bool use_markup);
		[NoArrayLength ()]
		[CCode (cname = "gtk_expander_set_use_underline")]
		public void set_use_underline (bool use_underline);
		public weak bool expanded { get; set construct; }
		public weak string label { get; set construct; }
		public weak bool use_underline { get; set construct; }
		public weak bool use_markup { get; set construct; }
		public weak int spacing { get; set; }
		public weak Gtk.Widget label_widget { get; set; }
		public signal void activate ();
	}
	[CCode (cheader_filename = "gtk/gtk.h")]
	public class FileChooserButton : Gtk.HBox, Gtk.FileChooser {
		[NoArrayLength ()]
		[CCode (cname = "gtk_file_chooser_button_get_focus_on_click")]
		public bool get_focus_on_click ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_file_chooser_button_get_title")]
		public string get_title ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_file_chooser_button_get_type")]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_file_chooser_button_get_width_chars")]
		public int get_width_chars ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_file_chooser_button_new")]
		public construct (string title, Gtk.FileChooserAction action);
		[NoArrayLength ()]
		[CCode (cname = "gtk_file_chooser_button_new_with_backend")]
		public construct with_backend (string title, Gtk.FileChooserAction action, string backend);
		[NoArrayLength ()]
		[CCode (cname = "gtk_file_chooser_button_new_with_dialog")]
		public construct with_dialog (Gtk.Widget dialog);
		[NoArrayLength ()]
		[CCode (cname = "gtk_file_chooser_button_set_focus_on_click")]
		public void set_focus_on_click (bool focus_on_click);
		[NoArrayLength ()]
		[CCode (cname = "gtk_file_chooser_button_set_title")]
		public void set_title (string title);
		[NoArrayLength ()]
		[CCode (cname = "gtk_file_chooser_button_set_width_chars")]
		public void set_width_chars (int n_chars);
		[NoAccessorMethod ()]
		public weak Gtk.FileChooser dialog { construct; }
		public weak bool focus_on_click { get; set; }
		public weak string title { get; set; }
		public weak int width_chars { get; set; }
	}
	[CCode (cheader_filename = "gtk/gtk.h")]
	public class FileChooserDialog : Gtk.Dialog, Gtk.FileChooser {
		[NoArrayLength ()]
		[CCode (cname = "gtk_file_chooser_dialog_get_type")]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_file_chooser_dialog_new")]
		public construct (string title, Gtk.Window parent, Gtk.FileChooserAction action, string first_button_text);
		[NoArrayLength ()]
		[CCode (cname = "gtk_file_chooser_dialog_new_with_backend")]
		public construct with_backend (string title, Gtk.Window parent, Gtk.FileChooserAction action, string backend, string first_button_text);
	}
	[CCode (cheader_filename = "gtk/gtk.h")]
	public class FileChooserWidget : Gtk.VBox, Gtk.FileChooser {
		[NoArrayLength ()]
		[CCode (cname = "gtk_file_chooser_widget_get_type")]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_file_chooser_widget_new")]
		public construct (Gtk.FileChooserAction action);
		[NoArrayLength ()]
		[CCode (cname = "gtk_file_chooser_widget_new_with_backend")]
		public construct with_backend (Gtk.FileChooserAction action, string backend);
	}
	[CCode (cheader_filename = "gtk/gtk.h")]
	public class FileFilter : Gtk.Object {
		[NoArrayLength ()]
		[CCode (cname = "gtk_file_filter_add_custom")]
		public void add_custom (Gtk.FileFilterFlags needed, Gtk.FileFilterFunc func, pointer data, GLib.DestroyNotify notify);
		[NoArrayLength ()]
		[CCode (cname = "gtk_file_filter_add_mime_type")]
		public void add_mime_type (string mime_type);
		[NoArrayLength ()]
		[CCode (cname = "gtk_file_filter_add_pattern")]
		public void add_pattern (string pattern);
		[NoArrayLength ()]
		[CCode (cname = "gtk_file_filter_add_pixbuf_formats")]
		public void add_pixbuf_formats ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_file_filter_filter")]
		public bool filter (Gtk.FileFilterInfo filter_info);
		[NoArrayLength ()]
		[CCode (cname = "gtk_file_filter_get_name")]
		public string get_name ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_file_filter_get_needed")]
		public Gtk.FileFilterFlags get_needed ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_file_filter_get_type")]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_file_filter_new")]
		public construct ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_file_filter_set_name")]
		public void set_name (string name);
	}
	[CCode (cheader_filename = "gtk/gtk.h")]
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
		public pointer cmpl_state;
		public weak Gtk.Widget fileop_c_dir;
		public weak Gtk.Widget fileop_del_file;
		public weak Gtk.Widget fileop_ren_file;
		public weak Gtk.Widget button_area;
		public weak Gtk.Widget action_area;
		[NoArrayLength ()]
		[CCode (cname = "gtk_file_selection_complete")]
		public void complete (string pattern);
		[NoArrayLength ()]
		[CCode (cname = "gtk_file_selection_get_filename")]
		public string get_filename ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_file_selection_get_select_multiple")]
		public bool get_select_multiple ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_file_selection_get_selections")]
		public string get_selections ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_file_selection_get_type")]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_file_selection_hide_fileop_buttons")]
		public void hide_fileop_buttons ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_file_selection_new")]
		public construct (string title);
		[NoArrayLength ()]
		[CCode (cname = "gtk_file_selection_set_filename")]
		public void set_filename (string filename);
		[NoArrayLength ()]
		[CCode (cname = "gtk_file_selection_set_select_multiple")]
		public void set_select_multiple (bool select_multiple);
		[NoArrayLength ()]
		[CCode (cname = "gtk_file_selection_show_fileop_buttons")]
		public void show_fileop_buttons ();
		public weak string filename { get; set; }
		[NoAccessorMethod ()]
		public weak bool show_fileops { get; set; }
		public weak bool select_multiple { get; set; }
	}
	[CCode (cheader_filename = "gtk/gtk.h")]
	public class Fixed : Gtk.Container {
		[NoArrayLength ()]
		[CCode (cname = "gtk_fixed_get_has_window")]
		public bool get_has_window ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_fixed_get_type")]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_fixed_move")]
		public void move (Gtk.Widget widget, int x, int y);
		[NoArrayLength ()]
		[CCode (cname = "gtk_fixed_new")]
		public construct ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_fixed_put")]
		public void put (Gtk.Widget widget, int x, int y);
		[NoArrayLength ()]
		[CCode (cname = "gtk_fixed_set_has_window")]
		public void set_has_window (bool has_window);
	}
	[CCode (cheader_filename = "gtk/gtk.h")]
	public class FontButton : Gtk.Button {
		[NoArrayLength ()]
		[CCode (cname = "gtk_font_button_get_font_name")]
		public string get_font_name ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_font_button_get_show_size")]
		public bool get_show_size ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_font_button_get_show_style")]
		public bool get_show_style ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_font_button_get_title")]
		public string get_title ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_font_button_get_type")]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_font_button_get_use_font")]
		public bool get_use_font ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_font_button_get_use_size")]
		public bool get_use_size ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_font_button_new")]
		public construct ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_font_button_new_with_font")]
		public construct with_font (string fontname);
		[NoArrayLength ()]
		[CCode (cname = "gtk_font_button_set_font_name")]
		public bool set_font_name (string fontname);
		[NoArrayLength ()]
		[CCode (cname = "gtk_font_button_set_show_size")]
		public void set_show_size (bool show_size);
		[NoArrayLength ()]
		[CCode (cname = "gtk_font_button_set_show_style")]
		public void set_show_style (bool show_style);
		[NoArrayLength ()]
		[CCode (cname = "gtk_font_button_set_title")]
		public void set_title (string title);
		[NoArrayLength ()]
		[CCode (cname = "gtk_font_button_set_use_font")]
		public void set_use_font (bool use_font);
		[NoArrayLength ()]
		[CCode (cname = "gtk_font_button_set_use_size")]
		public void set_use_size (bool use_size);
		public weak string title { get; set; }
		public weak string font_name { get; set; }
		public weak bool use_font { get; set; }
		public weak bool use_size { get; set; }
		public weak bool show_style { get; set; }
		public weak bool show_size { get; set; }
		public signal void font_set ();
	}
	[CCode (cheader_filename = "gtk/gtk.h")]
	public class FontSelection : Gtk.VBox {
		[NoArrayLength ()]
		[CCode (cname = "gtk_font_selection_get_font_name")]
		public string get_font_name ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_font_selection_get_preview_text")]
		public string get_preview_text ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_font_selection_get_type")]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_font_selection_new")]
		public construct ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_font_selection_set_font_name")]
		public bool set_font_name (string fontname);
		[NoArrayLength ()]
		[CCode (cname = "gtk_font_selection_set_preview_text")]
		public void set_preview_text (string text);
		public weak string font_name { get; set; }
		[NoAccessorMethod ()]
		public weak Gdk.Font font { get; }
		public weak string preview_text { get; set; }
	}
	[CCode (cheader_filename = "gtk/gtk.h")]
	public class FontSelectionDialog : Gtk.Dialog {
		public weak Gtk.Widget ok_button;
		public weak Gtk.Widget apply_button;
		public weak Gtk.Widget cancel_button;
		[NoArrayLength ()]
		[CCode (cname = "gtk_font_selection_dialog_get_font_name")]
		public string get_font_name ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_font_selection_dialog_get_preview_text")]
		public string get_preview_text ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_font_selection_dialog_get_type")]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_font_selection_dialog_new")]
		public construct (string title);
		[NoArrayLength ()]
		[CCode (cname = "gtk_font_selection_dialog_set_font_name")]
		public bool set_font_name (string fontname);
		[NoArrayLength ()]
		[CCode (cname = "gtk_font_selection_dialog_set_preview_text")]
		public void set_preview_text (string text);
	}
	[CCode (cheader_filename = "gtk/gtk.h")]
	public class Frame : Gtk.Bin {
		[NoArrayLength ()]
		[CCode (cname = "gtk_frame_get_label")]
		public string get_label ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_frame_get_label_align")]
		public void get_label_align (float xalign, float yalign);
		[NoArrayLength ()]
		[CCode (cname = "gtk_frame_get_label_widget")]
		public Gtk.Widget get_label_widget ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_frame_get_shadow_type")]
		public Gtk.ShadowType get_shadow_type ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_frame_get_type")]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_frame_new")]
		public construct (string label);
		[NoArrayLength ()]
		[CCode (cname = "gtk_frame_set_label")]
		public void set_label (string label);
		[NoArrayLength ()]
		[CCode (cname = "gtk_frame_set_label_align")]
		public void set_label_align (float xalign, float yalign);
		[NoArrayLength ()]
		[CCode (cname = "gtk_frame_set_label_widget")]
		public void set_label_widget (Gtk.Widget label_widget);
		[NoArrayLength ()]
		[CCode (cname = "gtk_frame_set_shadow_type")]
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
	[CCode (cheader_filename = "gtk/gtk.h")]
	public class GammaCurve : Gtk.VBox {
		[NoArrayLength ()]
		[CCode (cname = "gtk_gamma_curve_get_type")]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_gamma_curve_new")]
		public construct ();
	}
	[CCode (cheader_filename = "gtk/gtk.h")]
	public class HandleBox : Gtk.Bin {
		[NoArrayLength ()]
		[CCode (cname = "gtk_handle_box_get_handle_position")]
		public Gtk.PositionType get_handle_position ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_handle_box_get_shadow_type")]
		public Gtk.ShadowType get_shadow_type ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_handle_box_get_snap_edge")]
		public Gtk.PositionType get_snap_edge ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_handle_box_get_type")]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_handle_box_new")]
		public construct ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_handle_box_set_handle_position")]
		public void set_handle_position (Gtk.PositionType position);
		[NoArrayLength ()]
		[CCode (cname = "gtk_handle_box_set_shadow_type")]
		public void set_shadow_type (Gtk.ShadowType type);
		[NoArrayLength ()]
		[CCode (cname = "gtk_handle_box_set_snap_edge")]
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
	[CCode (cheader_filename = "gtk/gtk.h")]
	public class HBox : Gtk.Box {
		[NoArrayLength ()]
		[CCode (cname = "gtk_hbox_get_type")]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_hbox_new")]
		public construct (bool homogeneous, int spacing);
	}
	[CCode (cheader_filename = "gtk/gtk.h")]
	public class HButtonBox : Gtk.ButtonBox {
		[NoArrayLength ()]
		[CCode (cname = "gtk_hbutton_box_get_type")]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_hbutton_box_new")]
		public construct ();
	}
	[CCode (cheader_filename = "gtk/gtk.h")]
	public class HPaned : Gtk.Paned {
		[NoArrayLength ()]
		[CCode (cname = "gtk_hpaned_get_type")]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_hpaned_new")]
		public construct ();
	}
	[CCode (cheader_filename = "gtk/gtk.h")]
	public class HRuler : Gtk.Ruler {
		[NoArrayLength ()]
		[CCode (cname = "gtk_hruler_get_type")]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_hruler_new")]
		public construct ();
	}
	[CCode (cheader_filename = "gtk/gtk.h")]
	public class HScale : Gtk.Scale {
		[NoArrayLength ()]
		[CCode (cname = "gtk_hscale_get_type")]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_hscale_new")]
		public construct (Gtk.Adjustment adjustment);
		[NoArrayLength ()]
		[CCode (cname = "gtk_hscale_new_with_range")]
		public construct with_range (double min, double max, double step);
	}
	[CCode (cheader_filename = "gtk/gtk.h")]
	public class HScrollbar : Gtk.Scrollbar {
		[NoArrayLength ()]
		[CCode (cname = "gtk_hscrollbar_get_type")]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_hscrollbar_new")]
		public construct (Gtk.Adjustment adjustment);
	}
	[CCode (cheader_filename = "gtk/gtk.h")]
	public class HSeparator : Gtk.Separator {
		[NoArrayLength ()]
		[CCode (cname = "gtk_hseparator_get_type")]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_hseparator_new")]
		public construct ();
	}
	[CCode (cheader_filename = "gtk/gtk.h")]
	public class HSV : Gtk.Widget {
		[NoArrayLength ()]
		[CCode (cname = "gtk_hsv_get_color")]
		public void get_color (double h, double s, double v);
		[NoArrayLength ()]
		[CCode (cname = "gtk_hsv_get_metrics")]
		public void get_metrics (int size, int ring_width);
		[NoArrayLength ()]
		[CCode (cname = "gtk_hsv_get_type")]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_hsv_is_adjusting")]
		public bool is_adjusting ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_hsv_new")]
		public construct ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_hsv_set_color")]
		public void set_color (double h, double s, double v);
		[NoArrayLength ()]
		[CCode (cname = "gtk_hsv_set_metrics")]
		public void set_metrics (int size, int ring_width);
		[NoArrayLength ()]
		[CCode (cname = "gtk_hsv_to_rgb")]
		public static void to_rgb (double h, double s, double v, double r, double g, double b);
		public signal void changed ();
		public signal void move (Gtk.DirectionType type);
	}
	[CCode (cheader_filename = "gtk/gtk.h")]
	public class IconFactory : GLib.Object {
		[NoArrayLength ()]
		[CCode (cname = "gtk_icon_factory_add")]
		public void add (string stock_id, Gtk.IconSet icon_set);
		[NoArrayLength ()]
		[CCode (cname = "gtk_icon_factory_add_default")]
		public void add_default ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_icon_factory_get_type")]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_icon_factory_lookup")]
		public Gtk.IconSet lookup (string stock_id);
		[NoArrayLength ()]
		[CCode (cname = "gtk_icon_factory_lookup_default")]
		public static Gtk.IconSet lookup_default (string stock_id);
		[NoArrayLength ()]
		[CCode (cname = "gtk_icon_factory_new")]
		public construct ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_icon_factory_remove_default")]
		public void remove_default ();
	}
	[CCode (cheader_filename = "gtk/gtk.h")]
	public class IconTheme : GLib.Object {
		[NoArrayLength ()]
		[CCode (cname = "gtk_icon_theme_add_builtin_icon")]
		public static void add_builtin_icon (string icon_name, int size, Gdk.Pixbuf pixbuf);
		[NoArrayLength ()]
		[CCode (cname = "gtk_icon_theme_append_search_path")]
		public void append_search_path (string path);
		[NoArrayLength ()]
		[CCode (cname = "gtk_icon_theme_error_quark")]
		public static GLib.Quark error_quark ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_icon_theme_get_default")]
		public static Gtk.IconTheme get_default ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_icon_theme_get_example_icon_name")]
		public string get_example_icon_name ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_icon_theme_get_for_screen")]
		public static Gtk.IconTheme get_for_screen (Gdk.Screen screen);
		[NoArrayLength ()]
		[CCode (cname = "gtk_icon_theme_get_icon_sizes")]
		public int[] get_icon_sizes (string icon_name);
		[NoArrayLength ()]
		[CCode (cname = "gtk_icon_theme_get_search_path")]
		public void get_search_path (string path, int n_elements);
		[NoArrayLength ()]
		[CCode (cname = "gtk_icon_theme_get_type")]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_icon_theme_has_icon")]
		public bool has_icon (string icon_name);
		[NoArrayLength ()]
		[CCode (cname = "gtk_icon_theme_list_icons")]
		public GLib.List list_icons (string context);
		[NoArrayLength ()]
		[CCode (cname = "gtk_icon_theme_load_icon")]
		public Gdk.Pixbuf load_icon (string icon_name, int size, Gtk.IconLookupFlags @flags, GLib.Error error);
		[NoArrayLength ()]
		[CCode (cname = "gtk_icon_theme_lookup_icon")]
		public Gtk.IconInfo lookup_icon (string icon_name, int size, Gtk.IconLookupFlags @flags);
		[NoArrayLength ()]
		[CCode (cname = "gtk_icon_theme_new")]
		public construct ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_icon_theme_prepend_search_path")]
		public void prepend_search_path (string path);
		[NoArrayLength ()]
		[CCode (cname = "gtk_icon_theme_rescan_if_needed")]
		public bool rescan_if_needed ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_icon_theme_set_custom_theme")]
		public void set_custom_theme (string theme_name);
		[NoArrayLength ()]
		[CCode (cname = "gtk_icon_theme_set_screen")]
		public void set_screen (Gdk.Screen screen);
		[NoArrayLength ()]
		[CCode (cname = "gtk_icon_theme_set_search_path")]
		public void set_search_path (string[] path, int n_elements);
		public signal void changed ();
	}
	[CCode (cheader_filename = "gtk/gtk.h")]
	public class IconView : Gtk.Container, Gtk.CellLayout {
		[NoArrayLength ()]
		[CCode (cname = "gtk_icon_view_create_drag_icon")]
		public Gdk.Pixmap create_drag_icon (Gtk.TreePath path);
		[NoArrayLength ()]
		[CCode (cname = "gtk_icon_view_enable_model_drag_dest")]
		public void enable_model_drag_dest (Gtk.TargetEntry targets, int n_targets, Gdk.DragAction actions);
		[NoArrayLength ()]
		[CCode (cname = "gtk_icon_view_enable_model_drag_source")]
		public void enable_model_drag_source (Gdk.ModifierType start_button_mask, Gtk.TargetEntry targets, int n_targets, Gdk.DragAction actions);
		[NoArrayLength ()]
		[CCode (cname = "gtk_icon_view_get_column_spacing")]
		public int get_column_spacing ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_icon_view_get_columns")]
		public int get_columns ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_icon_view_get_cursor")]
		public bool get_cursor (Gtk.TreePath path, Gtk.CellRenderer cell);
		[NoArrayLength ()]
		[CCode (cname = "gtk_icon_view_get_dest_item_at_pos")]
		public bool get_dest_item_at_pos (int drag_x, int drag_y, Gtk.TreePath path, Gtk.IconViewDropPosition pos);
		[NoArrayLength ()]
		[CCode (cname = "gtk_icon_view_get_drag_dest_item")]
		public void get_drag_dest_item (Gtk.TreePath path, Gtk.IconViewDropPosition pos);
		[NoArrayLength ()]
		[CCode (cname = "gtk_icon_view_get_item_at_pos")]
		public bool get_item_at_pos (int x, int y, Gtk.TreePath path, Gtk.CellRenderer cell);
		[NoArrayLength ()]
		[CCode (cname = "gtk_icon_view_get_item_width")]
		public int get_item_width ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_icon_view_get_margin")]
		public int get_margin ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_icon_view_get_markup_column")]
		public int get_markup_column ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_icon_view_get_model")]
		public Gtk.TreeModel get_model ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_icon_view_get_orientation")]
		public Gtk.Orientation get_orientation ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_icon_view_get_path_at_pos")]
		public Gtk.TreePath get_path_at_pos (int x, int y);
		[NoArrayLength ()]
		[CCode (cname = "gtk_icon_view_get_pixbuf_column")]
		public int get_pixbuf_column ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_icon_view_get_reorderable")]
		public bool get_reorderable ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_icon_view_get_row_spacing")]
		public int get_row_spacing ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_icon_view_get_selected_items")]
		public GLib.List get_selected_items ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_icon_view_get_selection_mode")]
		public Gtk.SelectionMode get_selection_mode ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_icon_view_get_spacing")]
		public int get_spacing ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_icon_view_get_text_column")]
		public int get_text_column ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_icon_view_get_type")]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_icon_view_get_visible_range")]
		public bool get_visible_range (Gtk.TreePath start_path, Gtk.TreePath end_path);
		[NoArrayLength ()]
		[CCode (cname = "gtk_icon_view_new")]
		public construct ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_icon_view_new_with_model")]
		public construct with_model (Gtk.TreeModel model);
		[NoArrayLength ()]
		[CCode (cname = "gtk_icon_view_path_is_selected")]
		public bool path_is_selected (Gtk.TreePath path);
		[NoArrayLength ()]
		[CCode (cname = "gtk_icon_view_scroll_to_path")]
		public void scroll_to_path (Gtk.TreePath path, bool use_align, float row_align, float col_align);
		[NoArrayLength ()]
		[CCode (cname = "gtk_icon_view_select_path")]
		public void select_path (Gtk.TreePath path);
		[NoArrayLength ()]
		[CCode (cname = "gtk_icon_view_selected_foreach")]
		public void selected_foreach (Gtk.IconViewForeachFunc func, pointer data);
		[NoArrayLength ()]
		[CCode (cname = "gtk_icon_view_set_column_spacing")]
		public void set_column_spacing (int column_spacing);
		[NoArrayLength ()]
		[CCode (cname = "gtk_icon_view_set_columns")]
		public void set_columns (int columns);
		[NoArrayLength ()]
		[CCode (cname = "gtk_icon_view_set_cursor")]
		public void set_cursor (Gtk.TreePath path, Gtk.CellRenderer cell, bool start_editing);
		[NoArrayLength ()]
		[CCode (cname = "gtk_icon_view_set_drag_dest_item")]
		public void set_drag_dest_item (Gtk.TreePath path, Gtk.IconViewDropPosition pos);
		[NoArrayLength ()]
		[CCode (cname = "gtk_icon_view_set_item_width")]
		public void set_item_width (int item_width);
		[NoArrayLength ()]
		[CCode (cname = "gtk_icon_view_set_margin")]
		public void set_margin (int margin);
		[NoArrayLength ()]
		[CCode (cname = "gtk_icon_view_set_markup_column")]
		public void set_markup_column (int column);
		[NoArrayLength ()]
		[CCode (cname = "gtk_icon_view_set_model")]
		public void set_model (Gtk.TreeModel model);
		[NoArrayLength ()]
		[CCode (cname = "gtk_icon_view_set_orientation")]
		public void set_orientation (Gtk.Orientation orientation);
		[NoArrayLength ()]
		[CCode (cname = "gtk_icon_view_set_pixbuf_column")]
		public void set_pixbuf_column (int column);
		[NoArrayLength ()]
		[CCode (cname = "gtk_icon_view_set_reorderable")]
		public void set_reorderable (bool reorderable);
		[NoArrayLength ()]
		[CCode (cname = "gtk_icon_view_set_row_spacing")]
		public void set_row_spacing (int row_spacing);
		[NoArrayLength ()]
		[CCode (cname = "gtk_icon_view_set_selection_mode")]
		public void set_selection_mode (Gtk.SelectionMode mode);
		[NoArrayLength ()]
		[CCode (cname = "gtk_icon_view_set_spacing")]
		public void set_spacing (int spacing);
		[NoArrayLength ()]
		[CCode (cname = "gtk_icon_view_set_text_column")]
		public void set_text_column (int column);
		[NoArrayLength ()]
		[CCode (cname = "gtk_icon_view_unselect_path")]
		public void unselect_path (Gtk.TreePath path);
		[NoArrayLength ()]
		[CCode (cname = "gtk_icon_view_unset_model_drag_dest")]
		public void unset_model_drag_dest ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_icon_view_unset_model_drag_source")]
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
	[CCode (cheader_filename = "gtk/gtk.h")]
	public class Image : Gtk.Misc {
		[NoArrayLength ()]
		[CCode (cname = "gtk_image_clear")]
		public void clear ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_image_get_animation")]
		public Gdk.PixbufAnimation get_animation ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_image_get_icon_name")]
		public void get_icon_name (string icon_name, Gtk.IconSize size);
		[NoArrayLength ()]
		[CCode (cname = "gtk_image_get_icon_set")]
		public void get_icon_set (Gtk.IconSet icon_set, Gtk.IconSize size);
		[NoArrayLength ()]
		[CCode (cname = "gtk_image_get_image")]
		public void get_image (Gdk.Image gdk_image, Gdk.Bitmap mask);
		[NoArrayLength ()]
		[CCode (cname = "gtk_image_get_pixbuf")]
		public Gdk.Pixbuf get_pixbuf ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_image_get_pixel_size")]
		public int get_pixel_size ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_image_get_pixmap")]
		public void get_pixmap (Gdk.Pixmap pixmap, Gdk.Bitmap mask);
		[NoArrayLength ()]
		[CCode (cname = "gtk_image_get_stock")]
		public void get_stock (string stock_id, Gtk.IconSize size);
		[NoArrayLength ()]
		[CCode (cname = "gtk_image_get_storage_type")]
		public Gtk.ImageType get_storage_type ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_image_get_type")]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_image_new")]
		public construct ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_image_new_from_animation")]
		public construct from_animation (Gdk.PixbufAnimation animation);
		[NoArrayLength ()]
		[CCode (cname = "gtk_image_new_from_file")]
		public construct from_file (string filename);
		[NoArrayLength ()]
		[CCode (cname = "gtk_image_new_from_icon_name")]
		public construct from_icon_name (string icon_name, Gtk.IconSize size);
		[NoArrayLength ()]
		[CCode (cname = "gtk_image_new_from_icon_set")]
		public construct from_icon_set (Gtk.IconSet icon_set, Gtk.IconSize size);
		[NoArrayLength ()]
		[CCode (cname = "gtk_image_new_from_image")]
		public construct from_image (Gdk.Image image, Gdk.Bitmap mask);
		[NoArrayLength ()]
		[CCode (cname = "gtk_image_new_from_pixbuf")]
		public construct from_pixbuf (Gdk.Pixbuf pixbuf);
		[NoArrayLength ()]
		[CCode (cname = "gtk_image_new_from_pixmap")]
		public construct from_pixmap (Gdk.Pixmap pixmap, Gdk.Bitmap mask);
		[NoArrayLength ()]
		[CCode (cname = "gtk_image_new_from_stock")]
		public construct from_stock (string stock_id, Gtk.IconSize size);
		[NoArrayLength ()]
		[CCode (cname = "gtk_image_set_from_animation")]
		public void set_from_animation (Gdk.PixbufAnimation animation);
		[NoArrayLength ()]
		[CCode (cname = "gtk_image_set_from_file")]
		public void set_from_file (string filename);
		[NoArrayLength ()]
		[CCode (cname = "gtk_image_set_from_icon_name")]
		public void set_from_icon_name (string icon_name, Gtk.IconSize size);
		[NoArrayLength ()]
		[CCode (cname = "gtk_image_set_from_icon_set")]
		public void set_from_icon_set (Gtk.IconSet icon_set, Gtk.IconSize size);
		[NoArrayLength ()]
		[CCode (cname = "gtk_image_set_from_image")]
		public void set_from_image (Gdk.Image gdk_image, Gdk.Bitmap mask);
		[NoArrayLength ()]
		[CCode (cname = "gtk_image_set_from_pixbuf")]
		public void set_from_pixbuf (Gdk.Pixbuf pixbuf);
		[NoArrayLength ()]
		[CCode (cname = "gtk_image_set_from_pixmap")]
		public void set_from_pixmap (Gdk.Pixmap pixmap, Gdk.Bitmap mask);
		[NoArrayLength ()]
		[CCode (cname = "gtk_image_set_from_stock")]
		public void set_from_stock (string stock_id, Gtk.IconSize size);
		[NoArrayLength ()]
		[CCode (cname = "gtk_image_set_pixel_size")]
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
	[CCode (cheader_filename = "gtk/gtk.h")]
	public class ImageMenuItem : Gtk.MenuItem {
		[NoArrayLength ()]
		[CCode (cname = "gtk_image_menu_item_get_image")]
		public Gtk.Widget get_image ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_image_menu_item_get_type")]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_image_menu_item_new")]
		public construct ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_image_menu_item_new_from_stock")]
		public construct from_stock (string stock_id, Gtk.AccelGroup accel_group);
		[NoArrayLength ()]
		[CCode (cname = "gtk_image_menu_item_new_with_label")]
		public construct with_label (string label);
		[NoArrayLength ()]
		[CCode (cname = "gtk_image_menu_item_new_with_mnemonic")]
		public construct with_mnemonic (string label);
		[NoArrayLength ()]
		[CCode (cname = "gtk_image_menu_item_set_image")]
		public void set_image (Gtk.Widget image);
		public weak Gtk.Widget image { get; set; }
	}
	[CCode (cheader_filename = "gtk/gtk.h")]
	public class IMContext : GLib.Object {
		[NoArrayLength ()]
		[CCode (cname = "gtk_im_context_filter_keypress")]
		public virtual bool filter_keypress (Gdk.EventKey event);
		[NoArrayLength ()]
		[CCode (cname = "gtk_im_context_focus_in")]
		public virtual void focus_in ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_im_context_focus_out")]
		public virtual void focus_out ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_im_context_get_preedit_string")]
		public virtual void get_preedit_string (string str, Pango.AttrList attrs, int cursor_pos);
		[NoArrayLength ()]
		[CCode (cname = "gtk_im_context_get_surrounding")]
		public virtual bool get_surrounding (string text, int cursor_index);
		[NoArrayLength ()]
		[CCode (cname = "gtk_im_context_get_type")]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_im_context_reset")]
		public virtual void reset ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_im_context_set_client_window")]
		public virtual void set_client_window (Gdk.Window window);
		[NoArrayLength ()]
		[CCode (cname = "gtk_im_context_set_cursor_location")]
		public virtual void set_cursor_location (Gdk.Rectangle area);
		[NoArrayLength ()]
		[CCode (cname = "gtk_im_context_set_surrounding")]
		public virtual void set_surrounding (string text, int len, int cursor_index);
		[NoArrayLength ()]
		[CCode (cname = "gtk_im_context_set_use_preedit")]
		public virtual void set_use_preedit (bool use_preedit);
		public signal void preedit_start ();
		public signal void preedit_end ();
		public signal void preedit_changed ();
		public signal void commit (string str);
		public signal bool retrieve_surrounding ();
		[HasEmitter ()]
		public signal bool delete_surrounding (int offset, int n_chars);
	}
	[CCode (cheader_filename = "gtk/gtk.h")]
	public class IMContextSimple : Gtk.IMContext {
		[NoArrayLength ()]
		[CCode (cname = "gtk_im_context_simple_add_table")]
		public void add_table (ushort data, int max_seq_len, int n_seqs);
		[NoArrayLength ()]
		[CCode (cname = "gtk_im_context_simple_get_type")]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_im_context_simple_new")]
		public construct ();
	}
	[CCode (cheader_filename = "gtk/gtk.h")]
	public class IMMulticontext : Gtk.IMContext {
		[NoArrayLength ()]
		[CCode (cname = "gtk_im_multicontext_append_menuitems")]
		public void append_menuitems (Gtk.MenuShell menushell);
		[NoArrayLength ()]
		[CCode (cname = "gtk_im_multicontext_get_type")]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_im_multicontext_new")]
		public construct ();
	}
	[CCode (cheader_filename = "gtk/gtk.h")]
	public class InputDialog : Gtk.Dialog {
		[NoArrayLength ()]
		[CCode (cname = "gtk_input_dialog_get_type")]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_input_dialog_new")]
		public construct ();
		public signal void enable_device (Gdk.Device device);
		public signal void disable_device (Gdk.Device device);
	}
	[CCode (cheader_filename = "gtk/gtk.h")]
	public class Invisible : Gtk.Widget {
		[NoArrayLength ()]
		[CCode (cname = "gtk_invisible_get_screen")]
		public Gdk.Screen get_screen ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_invisible_get_type")]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_invisible_new")]
		public construct ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_invisible_new_for_screen")]
		public construct for_screen (Gdk.Screen screen);
		[NoArrayLength ()]
		[CCode (cname = "gtk_invisible_set_screen")]
		public void set_screen (Gdk.Screen screen);
		public weak Gdk.Screen screen { get; set; }
	}
	[CCode (cheader_filename = "gtk/gtk.h")]
	public class Item : Gtk.Bin {
		[NoArrayLength ()]
		[CCode (cname = "gtk_item_get_type")]
		public static GLib.Type get_type ();
		[HasEmitter ()]
		public signal void select ();
		[HasEmitter ()]
		public signal void deselect ();
		[HasEmitter ()]
		public signal void toggle ();
	}
	[CCode (cheader_filename = "gtk/gtk.h")]
	public class ItemFactory : Gtk.Object {
	}
	[CCode (cheader_filename = "gtk/gtk.h")]
	public class Label : Gtk.Misc {
		[NoArrayLength ()]
		[CCode (cname = "gtk_label_get_angle")]
		public double get_angle ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_label_get_attributes")]
		public Pango.AttrList get_attributes ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_label_get_ellipsize")]
		public Pango.EllipsizeMode get_ellipsize ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_label_get_justify")]
		public Gtk.Justification get_justify ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_label_get_label")]
		public string get_label ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_label_get_layout")]
		public Pango.Layout get_layout ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_label_get_layout_offsets")]
		public void get_layout_offsets (int x, int y);
		[NoArrayLength ()]
		[CCode (cname = "gtk_label_get_line_wrap")]
		public bool get_line_wrap ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_label_get_line_wrap_mode")]
		public Pango.WrapMode get_line_wrap_mode ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_label_get_max_width_chars")]
		public int get_max_width_chars ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_label_get_mnemonic_keyval")]
		public uint get_mnemonic_keyval ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_label_get_mnemonic_widget")]
		public Gtk.Widget get_mnemonic_widget ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_label_get_selectable")]
		public bool get_selectable ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_label_get_selection_bounds")]
		public bool get_selection_bounds (int start, int end);
		[NoArrayLength ()]
		[CCode (cname = "gtk_label_get_single_line_mode")]
		public bool get_single_line_mode ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_label_get_text")]
		public string get_text ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_label_get_type")]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_label_get_use_markup")]
		public bool get_use_markup ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_label_get_use_underline")]
		public bool get_use_underline ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_label_get_width_chars")]
		public int get_width_chars ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_label_new")]
		public construct (string str);
		[NoArrayLength ()]
		[CCode (cname = "gtk_label_new_with_mnemonic")]
		public construct with_mnemonic (string str);
		[NoArrayLength ()]
		[CCode (cname = "gtk_label_select_region")]
		public void select_region (int start_offset, int end_offset);
		[NoArrayLength ()]
		[CCode (cname = "gtk_label_set_angle")]
		public void set_angle (double angle);
		[NoArrayLength ()]
		[CCode (cname = "gtk_label_set_attributes")]
		public void set_attributes (Pango.AttrList attrs);
		[NoArrayLength ()]
		[CCode (cname = "gtk_label_set_ellipsize")]
		public void set_ellipsize (Pango.EllipsizeMode mode);
		[NoArrayLength ()]
		[CCode (cname = "gtk_label_set_justify")]
		public void set_justify (Gtk.Justification jtype);
		[NoArrayLength ()]
		[CCode (cname = "gtk_label_set_label")]
		public void set_label (string str);
		[NoArrayLength ()]
		[CCode (cname = "gtk_label_set_line_wrap")]
		public void set_line_wrap (bool wrap);
		[NoArrayLength ()]
		[CCode (cname = "gtk_label_set_line_wrap_mode")]
		public void set_line_wrap_mode (Pango.WrapMode wrap_mode);
		[NoArrayLength ()]
		[CCode (cname = "gtk_label_set_markup")]
		public void set_markup (string str);
		[NoArrayLength ()]
		[CCode (cname = "gtk_label_set_markup_with_mnemonic")]
		public void set_markup_with_mnemonic (string str);
		[NoArrayLength ()]
		[CCode (cname = "gtk_label_set_max_width_chars")]
		public void set_max_width_chars (int n_chars);
		[NoArrayLength ()]
		[CCode (cname = "gtk_label_set_mnemonic_widget")]
		public void set_mnemonic_widget (Gtk.Widget widget);
		[NoArrayLength ()]
		[CCode (cname = "gtk_label_set_pattern")]
		public void set_pattern (string pattern);
		[NoArrayLength ()]
		[CCode (cname = "gtk_label_set_selectable")]
		public void set_selectable (bool setting);
		[NoArrayLength ()]
		[CCode (cname = "gtk_label_set_single_line_mode")]
		public void set_single_line_mode (bool single_line_mode);
		[NoArrayLength ()]
		[CCode (cname = "gtk_label_set_text")]
		public void set_text (string str);
		[NoArrayLength ()]
		[CCode (cname = "gtk_label_set_text_with_mnemonic")]
		public void set_text_with_mnemonic (string str);
		[NoArrayLength ()]
		[CCode (cname = "gtk_label_set_use_markup")]
		public void set_use_markup (bool setting);
		[NoArrayLength ()]
		[CCode (cname = "gtk_label_set_use_underline")]
		public void set_use_underline (bool setting);
		[NoArrayLength ()]
		[CCode (cname = "gtk_label_set_width_chars")]
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
	[CCode (cheader_filename = "gtk/gtk.h")]
	public class Layout : Gtk.Container {
		public weak Gdk.Window bin_window;
		[NoArrayLength ()]
		[CCode (cname = "gtk_layout_get_hadjustment")]
		public Gtk.Adjustment get_hadjustment ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_layout_get_size")]
		public void get_size (uint width, uint height);
		[NoArrayLength ()]
		[CCode (cname = "gtk_layout_get_type")]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_layout_get_vadjustment")]
		public Gtk.Adjustment get_vadjustment ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_layout_move")]
		public void move (Gtk.Widget child_widget, int x, int y);
		[NoArrayLength ()]
		[CCode (cname = "gtk_layout_new")]
		public construct (Gtk.Adjustment hadjustment, Gtk.Adjustment vadjustment);
		[NoArrayLength ()]
		[CCode (cname = "gtk_layout_put")]
		public void put (Gtk.Widget child_widget, int x, int y);
		[NoArrayLength ()]
		[CCode (cname = "gtk_layout_set_hadjustment")]
		public void set_hadjustment (Gtk.Adjustment adjustment);
		[NoArrayLength ()]
		[CCode (cname = "gtk_layout_set_size")]
		public void set_size (uint width, uint height);
		[NoArrayLength ()]
		[CCode (cname = "gtk_layout_set_vadjustment")]
		public void set_vadjustment (Gtk.Adjustment adjustment);
		public weak Gtk.Adjustment hadjustment { get; set; }
		public weak Gtk.Adjustment vadjustment { get; set; }
		[NoAccessorMethod ()]
		public weak uint width { get; set; }
		[NoAccessorMethod ()]
		public weak uint height { get; set; }
		public signal void set_scroll_adjustments (Gtk.Adjustment hadjustment, Gtk.Adjustment vadjustment);
	}
	[CCode (cheader_filename = "gtk/gtk.h")]
	public class LinkButton : Gtk.Button {
		[NoArrayLength ()]
		[CCode (cname = "gtk_link_button_get_type")]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_link_button_get_uri")]
		public string get_uri ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_link_button_new")]
		public construct (string uri);
		[NoArrayLength ()]
		[CCode (cname = "gtk_link_button_new_with_label")]
		public construct with_label (string uri, string label);
		[NoArrayLength ()]
		[CCode (cname = "gtk_link_button_set_uri")]
		public void set_uri (string uri);
		[NoArrayLength ()]
		[CCode (cname = "gtk_link_button_set_uri_hook")]
		public static Gtk.LinkButtonUriFunc set_uri_hook (Gtk.LinkButtonUriFunc func, pointer data, GLib.DestroyNotify destroy);
		public weak string uri { get; set; }
	}
	[CCode (cheader_filename = "gtk/gtk.h")]
	public class ListStore : GLib.Object, Gtk.TreeModel, Gtk.TreeDragSource, Gtk.TreeDragDest, Gtk.TreeSortable {
		[NoArrayLength ()]
		[CCode (cname = "gtk_list_store_append")]
		public void append (Gtk.TreeIter iter);
		[NoArrayLength ()]
		[CCode (cname = "gtk_list_store_clear")]
		public void clear ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_list_store_get_type")]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_list_store_insert")]
		public void insert (Gtk.TreeIter iter, int position);
		[NoArrayLength ()]
		[CCode (cname = "gtk_list_store_insert_after")]
		public void insert_after (Gtk.TreeIter iter, Gtk.TreeIter sibling);
		[NoArrayLength ()]
		[CCode (cname = "gtk_list_store_insert_before")]
		public void insert_before (Gtk.TreeIter iter, Gtk.TreeIter sibling);
		[NoArrayLength ()]
		[CCode (cname = "gtk_list_store_insert_with_values")]
		public void insert_with_values (Gtk.TreeIter iter, int position, ...);
		[NoArrayLength ()]
		[CCode (cname = "gtk_list_store_insert_with_valuesv")]
		public void insert_with_valuesv (Gtk.TreeIter iter, int position, int columns, GLib.Value values, int n_values);
		[NoArrayLength ()]
		[CCode (cname = "gtk_list_store_iter_is_valid")]
		public bool iter_is_valid (Gtk.TreeIter iter);
		[NoArrayLength ()]
		[CCode (cname = "gtk_list_store_move_after")]
		public void move_after (Gtk.TreeIter iter, Gtk.TreeIter position);
		[NoArrayLength ()]
		[CCode (cname = "gtk_list_store_move_before")]
		public void move_before (Gtk.TreeIter iter, Gtk.TreeIter position);
		[NoArrayLength ()]
		[CCode (cname = "gtk_list_store_new")]
		public construct (int n_columns, ...);
		[NoArrayLength ()]
		[CCode (cname = "gtk_list_store_newv")]
		public construct newv (int n_columns, GLib.Type types);
		[NoArrayLength ()]
		[CCode (cname = "gtk_list_store_prepend")]
		public void prepend (Gtk.TreeIter iter);
		[NoArrayLength ()]
		[CCode (cname = "gtk_list_store_remove")]
		public bool remove (Gtk.TreeIter iter);
		[NoArrayLength ()]
		[CCode (cname = "gtk_list_store_reorder")]
		public void reorder (int new_order);
		[NoArrayLength ()]
		[CCode (cname = "gtk_list_store_set")]
		public void @set (Gtk.TreeIter iter);
		[NoArrayLength ()]
		[CCode (cname = "gtk_list_store_set_column_types")]
		public void set_column_types (int n_columns, GLib.Type types);
		[NoArrayLength ()]
		[CCode (cname = "gtk_list_store_set_valist")]
		public void set_valist (Gtk.TreeIter iter, pointer var_args);
		[NoArrayLength ()]
		[CCode (cname = "gtk_list_store_set_value")]
		public void set_value (Gtk.TreeIter iter, int column, GLib.Value value);
		[NoArrayLength ()]
		[CCode (cname = "gtk_list_store_swap")]
		public void swap (Gtk.TreeIter a, Gtk.TreeIter b);
	}
	[CCode (cheader_filename = "gtk/gtk.h")]
	public class Menu : Gtk.MenuShell {
		[NoArrayLength ()]
		[CCode (cname = "gtk_menu_attach")]
		public void attach (Gtk.Widget child, uint left_attach, uint right_attach, uint top_attach, uint bottom_attach);
		[NoArrayLength ()]
		[CCode (cname = "gtk_menu_attach_to_widget")]
		public void attach_to_widget (Gtk.Widget attach_widget, Gtk.MenuDetachFunc detacher);
		[NoArrayLength ()]
		[CCode (cname = "gtk_menu_detach")]
		public void detach ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_menu_get_accel_group")]
		public Gtk.AccelGroup get_accel_group ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_menu_get_active")]
		public Gtk.Widget get_active ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_menu_get_attach_widget")]
		public Gtk.Widget get_attach_widget ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_menu_get_for_attach_widget")]
		public static GLib.List get_for_attach_widget (Gtk.Widget widget);
		[NoArrayLength ()]
		[CCode (cname = "gtk_menu_get_tearoff_state")]
		public bool get_tearoff_state ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_menu_get_title")]
		public string get_title ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_menu_get_type")]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_menu_new")]
		public construct ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_menu_popdown")]
		public void popdown ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_menu_popup")]
		public void popup (Gtk.Widget parent_menu_shell, Gtk.Widget parent_menu_item, Gtk.MenuPositionFunc func, pointer data, uint button, uint activate_time);
		[NoArrayLength ()]
		[CCode (cname = "gtk_menu_reorder_child")]
		public void reorder_child (Gtk.Widget child, int position);
		[NoArrayLength ()]
		[CCode (cname = "gtk_menu_reposition")]
		public void reposition ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_menu_set_accel_group")]
		public void set_accel_group (Gtk.AccelGroup accel_group);
		[NoArrayLength ()]
		[CCode (cname = "gtk_menu_set_accel_path")]
		public void set_accel_path (string accel_path);
		[NoArrayLength ()]
		[CCode (cname = "gtk_menu_set_active")]
		public void set_active (uint index_);
		[NoArrayLength ()]
		[CCode (cname = "gtk_menu_set_monitor")]
		public void set_monitor (int monitor_num);
		[NoArrayLength ()]
		[CCode (cname = "gtk_menu_set_screen")]
		public void set_screen (Gdk.Screen screen);
		[NoArrayLength ()]
		[CCode (cname = "gtk_menu_set_tearoff_state")]
		public void set_tearoff_state (bool torn_off);
		[NoArrayLength ()]
		[CCode (cname = "gtk_menu_set_title")]
		public void set_title (string title);
		[NoAccessorMethod ()]
		public weak string tearoff_title { get; set; }
		public weak bool tearoff_state { get; set; }
	}
	[CCode (cheader_filename = "gtk/gtk.h")]
	public class MenuBar : Gtk.MenuShell {
		[NoArrayLength ()]
		[CCode (cname = "gtk_menu_bar_get_child_pack_direction")]
		public Gtk.PackDirection get_child_pack_direction ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_menu_bar_get_pack_direction")]
		public Gtk.PackDirection get_pack_direction ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_menu_bar_get_type")]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_menu_bar_new")]
		public construct ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_menu_bar_set_child_pack_direction")]
		public void set_child_pack_direction (Gtk.PackDirection child_pack_dir);
		[NoArrayLength ()]
		[CCode (cname = "gtk_menu_bar_set_pack_direction")]
		public void set_pack_direction (Gtk.PackDirection pack_dir);
		public weak Gtk.PackDirection pack_direction { get; set; }
		public weak Gtk.PackDirection child_pack_direction { get; set; }
	}
	[CCode (cheader_filename = "gtk/gtk.h")]
	public class MenuItem : Gtk.Item {
		[NoArrayLength ()]
		[CCode (cname = "gtk_menu_item_deselect")]
		public void deselect ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_menu_item_get_right_justified")]
		public bool get_right_justified ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_menu_item_get_submenu")]
		public Gtk.Widget get_submenu ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_menu_item_get_type")]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_menu_item_new")]
		public construct ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_menu_item_new_with_label")]
		public construct with_label (string label);
		[NoArrayLength ()]
		[CCode (cname = "gtk_menu_item_new_with_mnemonic")]
		public construct with_mnemonic (string label);
		[NoArrayLength ()]
		[CCode (cname = "gtk_menu_item_remove_submenu")]
		public void remove_submenu ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_menu_item_select")]
		public void select ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_menu_item_set_accel_path")]
		public void set_accel_path (string accel_path);
		[NoArrayLength ()]
		[CCode (cname = "gtk_menu_item_set_right_justified")]
		public void set_right_justified (bool right_justified);
		[NoArrayLength ()]
		[CCode (cname = "gtk_menu_item_set_submenu")]
		public void set_submenu (Gtk.Widget submenu);
		[HasEmitter ()]
		public signal void activate ();
		public signal void activate_item ();
		[HasEmitter ()]
		public signal void toggle_size_request (int requisition);
		[HasEmitter ()]
		public signal void toggle_size_allocate (int allocation);
	}
	[CCode (cheader_filename = "gtk/gtk.h")]
	public class MenuShell : Gtk.Container {
		[NoArrayLength ()]
		[CCode (cname = "gtk_menu_shell_activate_item")]
		public void activate_item (Gtk.Widget menu_item, bool force_deactivate);
		[NoArrayLength ()]
		[CCode (cname = "gtk_menu_shell_append")]
		public void append (Gtk.Widget child);
		[NoArrayLength ()]
		[CCode (cname = "gtk_menu_shell_deselect")]
		public void deselect ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_menu_shell_get_take_focus")]
		public bool get_take_focus ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_menu_shell_get_type")]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_menu_shell_insert")]
		public virtual void insert (Gtk.Widget child, int position);
		[NoArrayLength ()]
		[CCode (cname = "gtk_menu_shell_prepend")]
		public void prepend (Gtk.Widget child);
		[NoArrayLength ()]
		[CCode (cname = "gtk_menu_shell_select_first")]
		public void select_first (bool search_sensitive);
		[NoArrayLength ()]
		[CCode (cname = "gtk_menu_shell_select_item")]
		public virtual void select_item (Gtk.Widget menu_item);
		[NoArrayLength ()]
		[CCode (cname = "gtk_menu_shell_set_take_focus")]
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
	[CCode (cheader_filename = "gtk/gtk.h")]
	public class MenuToolButton : Gtk.ToolButton {
		[NoArrayLength ()]
		[CCode (cname = "gtk_menu_tool_button_get_menu")]
		public Gtk.Widget get_menu ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_menu_tool_button_get_type")]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_menu_tool_button_new")]
		public construct (Gtk.Widget icon_widget, string label);
		[NoArrayLength ()]
		[CCode (cname = "gtk_menu_tool_button_new_from_stock")]
		public construct from_stock (string stock_id);
		[NoArrayLength ()]
		[CCode (cname = "gtk_menu_tool_button_set_arrow_tooltip")]
		public void set_arrow_tooltip (Gtk.Tooltips tooltips, string tip_text, string tip_private);
		[NoArrayLength ()]
		[CCode (cname = "gtk_menu_tool_button_set_menu")]
		public void set_menu (Gtk.Widget menu);
		public weak Gtk.Menu menu { get; set; }
		public signal void show_menu ();
	}
	[CCode (cheader_filename = "gtk/gtk.h")]
	public class MessageDialog : Gtk.Dialog {
		[NoArrayLength ()]
		[CCode (cname = "gtk_message_dialog_format_secondary_markup")]
		public void format_secondary_markup (string message_format);
		[NoArrayLength ()]
		[CCode (cname = "gtk_message_dialog_format_secondary_text")]
		public void format_secondary_text (string message_format);
		[NoArrayLength ()]
		[CCode (cname = "gtk_message_dialog_get_type")]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_message_dialog_new")]
		public construct (Gtk.Window parent, Gtk.DialogFlags @flags, Gtk.MessageType type, Gtk.ButtonsType buttons, string message_format);
		[NoArrayLength ()]
		[CCode (cname = "gtk_message_dialog_new_with_markup")]
		public construct with_markup (Gtk.Window parent, Gtk.DialogFlags @flags, Gtk.MessageType type, Gtk.ButtonsType buttons, string message_format);
		[NoArrayLength ()]
		[CCode (cname = "gtk_message_dialog_set_image")]
		public void set_image (Gtk.Widget image);
		[NoArrayLength ()]
		[CCode (cname = "gtk_message_dialog_set_markup")]
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
	[CCode (cheader_filename = "gtk/gtk.h")]
	public class Misc : Gtk.Widget {
		[NoArrayLength ()]
		[CCode (cname = "gtk_misc_get_alignment")]
		public void get_alignment (float xalign, float yalign);
		[NoArrayLength ()]
		[CCode (cname = "gtk_misc_get_padding")]
		public void get_padding (int xpad, int ypad);
		[NoArrayLength ()]
		[CCode (cname = "gtk_misc_get_type")]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_misc_set_alignment")]
		public void set_alignment (float xalign, float yalign);
		[NoArrayLength ()]
		[CCode (cname = "gtk_misc_set_padding")]
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
	[CCode (cheader_filename = "gtk/gtk.h")]
	public class Notebook : Gtk.Container {
		[NoArrayLength ()]
		[CCode (cname = "gtk_notebook_append_page")]
		public int append_page (Gtk.Widget child, Gtk.Widget tab_label);
		[NoArrayLength ()]
		[CCode (cname = "gtk_notebook_append_page_menu")]
		public int append_page_menu (Gtk.Widget child, Gtk.Widget tab_label, Gtk.Widget menu_label);
		[NoArrayLength ()]
		[CCode (cname = "gtk_notebook_get_current_page")]
		public int get_current_page ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_notebook_get_group_id")]
		public int get_group_id ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_notebook_get_menu_label")]
		public Gtk.Widget get_menu_label (Gtk.Widget child);
		[NoArrayLength ()]
		[CCode (cname = "gtk_notebook_get_menu_label_text")]
		public string get_menu_label_text (Gtk.Widget child);
		[NoArrayLength ()]
		[CCode (cname = "gtk_notebook_get_n_pages")]
		public int get_n_pages ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_notebook_get_nth_page")]
		public Gtk.Widget get_nth_page (int page_num);
		[NoArrayLength ()]
		[CCode (cname = "gtk_notebook_get_scrollable")]
		public bool get_scrollable ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_notebook_get_show_border")]
		public bool get_show_border ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_notebook_get_show_tabs")]
		public bool get_show_tabs ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_notebook_get_tab_detachable")]
		public bool get_tab_detachable (Gtk.Widget child);
		[NoArrayLength ()]
		[CCode (cname = "gtk_notebook_get_tab_label")]
		public Gtk.Widget get_tab_label (Gtk.Widget child);
		[NoArrayLength ()]
		[CCode (cname = "gtk_notebook_get_tab_label_text")]
		public string get_tab_label_text (Gtk.Widget child);
		[NoArrayLength ()]
		[CCode (cname = "gtk_notebook_get_tab_pos")]
		public Gtk.PositionType get_tab_pos ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_notebook_get_tab_reorderable")]
		public bool get_tab_reorderable (Gtk.Widget child);
		[NoArrayLength ()]
		[CCode (cname = "gtk_notebook_get_type")]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_notebook_insert_page")]
		public virtual int insert_page (Gtk.Widget child, Gtk.Widget tab_label, int position);
		[NoArrayLength ()]
		[CCode (cname = "gtk_notebook_insert_page_menu")]
		public int insert_page_menu (Gtk.Widget child, Gtk.Widget tab_label, Gtk.Widget menu_label, int position);
		[NoArrayLength ()]
		[CCode (cname = "gtk_notebook_new")]
		public construct ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_notebook_next_page")]
		public void next_page ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_notebook_popup_disable")]
		public void popup_disable ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_notebook_popup_enable")]
		public void popup_enable ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_notebook_prepend_page")]
		public int prepend_page (Gtk.Widget child, Gtk.Widget tab_label);
		[NoArrayLength ()]
		[CCode (cname = "gtk_notebook_prepend_page_menu")]
		public int prepend_page_menu (Gtk.Widget child, Gtk.Widget tab_label, Gtk.Widget menu_label);
		[NoArrayLength ()]
		[CCode (cname = "gtk_notebook_prev_page")]
		public void prev_page ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_notebook_query_tab_label_packing")]
		public void query_tab_label_packing (Gtk.Widget child, bool expand, bool fill, Gtk.PackType pack_type);
		[NoArrayLength ()]
		[CCode (cname = "gtk_notebook_remove_page")]
		public void remove_page (int page_num);
		[NoArrayLength ()]
		[CCode (cname = "gtk_notebook_reorder_child")]
		public void reorder_child (Gtk.Widget child, int position);
		[NoArrayLength ()]
		[CCode (cname = "gtk_notebook_set_current_page")]
		public void set_current_page (int page_num);
		[NoArrayLength ()]
		[CCode (cname = "gtk_notebook_set_group_id")]
		public void set_group_id (int group_id);
		[NoArrayLength ()]
		[CCode (cname = "gtk_notebook_set_menu_label")]
		public void set_menu_label (Gtk.Widget child, Gtk.Widget menu_label);
		[NoArrayLength ()]
		[CCode (cname = "gtk_notebook_set_menu_label_text")]
		public void set_menu_label_text (Gtk.Widget child, string menu_text);
		[NoArrayLength ()]
		[CCode (cname = "gtk_notebook_set_scrollable")]
		public void set_scrollable (bool scrollable);
		[NoArrayLength ()]
		[CCode (cname = "gtk_notebook_set_show_border")]
		public void set_show_border (bool show_border);
		[NoArrayLength ()]
		[CCode (cname = "gtk_notebook_set_show_tabs")]
		public void set_show_tabs (bool show_tabs);
		[NoArrayLength ()]
		[CCode (cname = "gtk_notebook_set_tab_detachable")]
		public void set_tab_detachable (Gtk.Widget child, bool detachable);
		[NoArrayLength ()]
		[CCode (cname = "gtk_notebook_set_tab_label")]
		public void set_tab_label (Gtk.Widget child, Gtk.Widget tab_label);
		[NoArrayLength ()]
		[CCode (cname = "gtk_notebook_set_tab_label_packing")]
		public void set_tab_label_packing (Gtk.Widget child, bool expand, bool fill, Gtk.PackType pack_type);
		[NoArrayLength ()]
		[CCode (cname = "gtk_notebook_set_tab_label_text")]
		public void set_tab_label_text (Gtk.Widget child, string tab_text);
		[NoArrayLength ()]
		[CCode (cname = "gtk_notebook_set_tab_pos")]
		public void set_tab_pos (Gtk.PositionType pos);
		[NoArrayLength ()]
		[CCode (cname = "gtk_notebook_set_tab_reorderable")]
		public void set_tab_reorderable (Gtk.Widget child, bool reorderable);
		[NoArrayLength ()]
		[CCode (cname = "gtk_notebook_set_window_creation_hook")]
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
		public signal bool change_current_page (int offset);
		public signal void move_focus_out (Gtk.DirectionType direction);
		public signal bool reorder_tab (Gtk.DirectionType direction, bool move_to_last);
		public signal void page_reordered (Gtk.Widget p0, uint p1);
		public signal void page_removed (Gtk.Widget p0, uint p1);
		public signal void page_added (Gtk.Widget p0, uint p1);
	}
	[CCode (cheader_filename = "gtk/gtk.h")]
	public class Object : GLib.InitiallyUnowned {
		[NoArrayLength ()]
		[CCode (cname = "gtk_object_get_type")]
		public static Gtk.Type get_type ();
		[NoAccessorMethod ()]
		public weak pointer user_data { get; set; }
		public signal void destroy ();
	}
	[CCode (cheader_filename = "gtk/gtk.h")]
	public class OptionMenu : Gtk.Button {
		[NoAccessorMethod ()]
		public weak Gtk.Menu menu { get; set; }
		public signal void changed ();
	}
	[CCode (cheader_filename = "gtk/gtk.h")]
	public class PageSetup : GLib.Object {
		[NoArrayLength ()]
		[CCode (cname = "gtk_page_setup_copy")]
		public Gtk.PageSetup copy ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_page_setup_get_bottom_margin")]
		public double get_bottom_margin (Gtk.Unit unit);
		[NoArrayLength ()]
		[CCode (cname = "gtk_page_setup_get_left_margin")]
		public double get_left_margin (Gtk.Unit unit);
		[NoArrayLength ()]
		[CCode (cname = "gtk_page_setup_get_orientation")]
		public Gtk.PageOrientation get_orientation ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_page_setup_get_page_height")]
		public double get_page_height (Gtk.Unit unit);
		[NoArrayLength ()]
		[CCode (cname = "gtk_page_setup_get_page_width")]
		public double get_page_width (Gtk.Unit unit);
		[NoArrayLength ()]
		[CCode (cname = "gtk_page_setup_get_paper_height")]
		public double get_paper_height (Gtk.Unit unit);
		[NoArrayLength ()]
		[CCode (cname = "gtk_page_setup_get_paper_size")]
		public Gtk.PaperSize get_paper_size ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_page_setup_get_paper_width")]
		public double get_paper_width (Gtk.Unit unit);
		[NoArrayLength ()]
		[CCode (cname = "gtk_page_setup_get_right_margin")]
		public double get_right_margin (Gtk.Unit unit);
		[NoArrayLength ()]
		[CCode (cname = "gtk_page_setup_get_top_margin")]
		public double get_top_margin (Gtk.Unit unit);
		[NoArrayLength ()]
		[CCode (cname = "gtk_page_setup_get_type")]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_page_setup_new")]
		public construct ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_page_setup_set_bottom_margin")]
		public void set_bottom_margin (double margin, Gtk.Unit unit);
		[NoArrayLength ()]
		[CCode (cname = "gtk_page_setup_set_left_margin")]
		public void set_left_margin (double margin, Gtk.Unit unit);
		[NoArrayLength ()]
		[CCode (cname = "gtk_page_setup_set_orientation")]
		public void set_orientation (Gtk.PageOrientation orientation);
		[NoArrayLength ()]
		[CCode (cname = "gtk_page_setup_set_paper_size")]
		public void set_paper_size (Gtk.PaperSize size);
		[NoArrayLength ()]
		[CCode (cname = "gtk_page_setup_set_paper_size_and_default_margins")]
		public void set_paper_size_and_default_margins (Gtk.PaperSize size);
		[NoArrayLength ()]
		[CCode (cname = "gtk_page_setup_set_right_margin")]
		public void set_right_margin (double margin, Gtk.Unit unit);
		[NoArrayLength ()]
		[CCode (cname = "gtk_page_setup_set_top_margin")]
		public void set_top_margin (double margin, Gtk.Unit unit);
	}
	[CCode (cheader_filename = "gtk/gtk.h")]
	public class PageSetupUnixDialog : Gtk.Dialog {
		[NoArrayLength ()]
		[CCode (cname = "gtk_page_setup_unix_dialog_get_page_setup")]
		public Gtk.PageSetup get_page_setup ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_page_setup_unix_dialog_get_print_settings")]
		public Gtk.PrintSettings get_print_settings ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_page_setup_unix_dialog_get_type")]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_page_setup_unix_dialog_new")]
		public construct (string title, Gtk.Window parent);
		[NoArrayLength ()]
		[CCode (cname = "gtk_page_setup_unix_dialog_set_page_setup")]
		public void set_page_setup (Gtk.PageSetup page_setup);
		[NoArrayLength ()]
		[CCode (cname = "gtk_page_setup_unix_dialog_set_print_settings")]
		public void set_print_settings (Gtk.PrintSettings print_settings);
	}
	[CCode (cheader_filename = "gtk/gtk.h")]
	public class Paned : Gtk.Container {
		[NoArrayLength ()]
		[CCode (cname = "gtk_paned_add1")]
		public void add1 (Gtk.Widget child);
		[NoArrayLength ()]
		[CCode (cname = "gtk_paned_add2")]
		public void add2 (Gtk.Widget child);
		[NoArrayLength ()]
		[CCode (cname = "gtk_paned_get_child1")]
		public Gtk.Widget get_child1 ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_paned_get_child2")]
		public Gtk.Widget get_child2 ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_paned_get_position")]
		public int get_position ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_paned_get_type")]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_paned_pack1")]
		public void pack1 (Gtk.Widget child, bool resize, bool shrink);
		[NoArrayLength ()]
		[CCode (cname = "gtk_paned_pack2")]
		public void pack2 (Gtk.Widget child, bool resize, bool shrink);
		[NoArrayLength ()]
		[CCode (cname = "gtk_paned_set_position")]
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
	[CCode (cheader_filename = "gtk/gtk.h")]
	public class Plug : Gtk.Window {
		[NoArrayLength ()]
		[CCode (cname = "gtk_plug_construct")]
		public void @construct (pointer socket_id);
		[NoArrayLength ()]
		[CCode (cname = "gtk_plug_construct_for_display")]
		public void construct_for_display (Gdk.Display display, pointer socket_id);
		[NoArrayLength ()]
		[CCode (cname = "gtk_plug_get_id")]
		public pointer get_id ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_plug_get_type")]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_plug_new")]
		public construct (pointer socket_id);
		[NoArrayLength ()]
		[CCode (cname = "gtk_plug_new_for_display")]
		public construct for_display (Gdk.Display display, pointer socket_id);
		public signal void embedded ();
	}
	[CCode (cheader_filename = "gtk/gtk.h")]
	public class Printer : GLib.Object {
		[NoArrayLength ()]
		[CCode (cname = "gtk_printer_compare")]
		public int compare (Gtk.Printer b);
		[NoArrayLength ()]
		[CCode (cname = "gtk_printer_get_backend")]
		public Gtk.PrintBackend get_backend ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_printer_get_description")]
		public string get_description ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_printer_get_icon_name")]
		public string get_icon_name ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_printer_get_job_count")]
		public int get_job_count ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_printer_get_location")]
		public string get_location ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_printer_get_name")]
		public string get_name ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_printer_get_state_message")]
		public string get_state_message ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_printer_get_type")]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_printer_is_active")]
		public bool is_active ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_printer_is_default")]
		public bool is_default ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_printer_is_new")]
		public bool is_new ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_printer_new")]
		public construct (string name, Gtk.PrintBackend backend, bool virtual_);
		[NoArrayLength ()]
		[CCode (cname = "gtk_printer_set_description")]
		public bool set_description (string description);
		[NoArrayLength ()]
		[CCode (cname = "gtk_printer_set_has_details")]
		public void set_has_details (bool val);
		[NoArrayLength ()]
		[CCode (cname = "gtk_printer_set_icon_name")]
		public void set_icon_name (string icon);
		[NoArrayLength ()]
		[CCode (cname = "gtk_printer_set_is_active")]
		public void set_is_active (bool active);
		[NoArrayLength ()]
		[CCode (cname = "gtk_printer_set_is_default")]
		public void set_is_default (bool val);
		[NoArrayLength ()]
		[CCode (cname = "gtk_printer_set_is_new")]
		public void set_is_new (bool val);
		[NoArrayLength ()]
		[CCode (cname = "gtk_printer_set_job_count")]
		public bool set_job_count (int count);
		[NoArrayLength ()]
		[CCode (cname = "gtk_printer_set_location")]
		public bool set_location (string location);
		[NoArrayLength ()]
		[CCode (cname = "gtk_printer_set_state_message")]
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
	[CCode (cheader_filename = "gtk/gtk.h")]
	public class PrinterOption : GLib.Object {
		[NoArrayLength ()]
		[CCode (cname = "gtk_printer_option_allocate_choices")]
		public void allocate_choices (int num);
		[NoArrayLength ()]
		[CCode (cname = "gtk_printer_option_choices_from_array")]
		public void choices_from_array (int num_choices, string[] choices, string[] choices_display);
		[NoArrayLength ()]
		[CCode (cname = "gtk_printer_option_clear_has_conflict")]
		public void clear_has_conflict ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_printer_option_get_type")]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_printer_option_has_choice")]
		public bool has_choice (string choice);
		[NoArrayLength ()]
		[CCode (cname = "gtk_printer_option_new")]
		public construct (string name, string display_text, Gtk.PrinterOptionType type);
		[NoArrayLength ()]
		[CCode (cname = "gtk_printer_option_set")]
		public void @set (string value);
		public signal void changed ();
	}
	[CCode (cheader_filename = "gtk/gtk.h")]
	public class PrinterOptionSet : GLib.Object {
		[NoArrayLength ()]
		[CCode (cname = "gtk_printer_option_set_add")]
		public void add (Gtk.PrinterOption option);
		[NoArrayLength ()]
		[CCode (cname = "gtk_printer_option_set_boolean")]
		public static void boolean (Gtk.PrinterOption option, bool value);
		[NoArrayLength ()]
		[CCode (cname = "gtk_printer_option_set_clear_conflicts")]
		public void clear_conflicts ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_printer_option_set_foreach")]
		public void @foreach (Gtk.PrinterOptionSetFunc func, pointer user_data);
		[NoArrayLength ()]
		[CCode (cname = "gtk_printer_option_set_foreach_in_group")]
		public void foreach_in_group (string group, Gtk.PrinterOptionSetFunc func, pointer user_data);
		[NoArrayLength ()]
		[CCode (cname = "gtk_printer_option_set_get_groups")]
		public GLib.List get_groups ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_printer_option_set_get_type")]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_printer_option_set_has_conflict")]
		public static void has_conflict (Gtk.PrinterOption option, bool has_conflict);
		[NoArrayLength ()]
		[CCode (cname = "gtk_printer_option_set_lookup")]
		public Gtk.PrinterOption lookup (string name);
		[NoArrayLength ()]
		[CCode (cname = "gtk_printer_option_set_new")]
		public construct ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_printer_option_set_remove")]
		public void remove (Gtk.PrinterOption option);
		public signal void changed ();
	}
	[CCode (cheader_filename = "gtk/gtk.h")]
	public class PrinterOptionWidget : Gtk.HBox {
		[NoArrayLength ()]
		[CCode (cname = "gtk_printer_option_widget_get_external_label")]
		public Gtk.Widget get_external_label ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_printer_option_widget_get_type")]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_printer_option_widget_get_value")]
		public string get_value ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_printer_option_widget_has_external_label")]
		public bool has_external_label ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_printer_option_widget_new")]
		public construct (Gtk.PrinterOption source);
		[NoArrayLength ()]
		[CCode (cname = "gtk_printer_option_widget_set_source")]
		public void set_source (Gtk.PrinterOption source);
		[NoAccessorMethod ()]
		public weak Gtk.PrinterOption source { get; set construct; }
		public signal void changed ();
	}
	[CCode (cheader_filename = "gtk/gtk.h")]
	public class PrintBackend : GLib.Object {
		[NoArrayLength ()]
		[CCode (cname = "gtk_print_backend_add_printer")]
		public void add_printer (Gtk.Printer printer);
		[NoArrayLength ()]
		[CCode (cname = "gtk_print_backend_destroy")]
		public void destroy ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_print_backend_error_quark")]
		public static GLib.Quark error_quark ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_print_backend_find_printer")]
		public Gtk.Printer find_printer (string printer_name);
		[NoArrayLength ()]
		[CCode (cname = "gtk_print_backend_get_printer_list")]
		public GLib.List get_printer_list ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_print_backend_get_type")]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_print_backend_load_modules")]
		public static GLib.List load_modules ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_print_backend_print_stream")]
		public virtual void print_stream (Gtk.PrintJob job, GLib.IOChannel data_io, Gtk.PrintJobCompleteFunc @callback, pointer user_data, GLib.DestroyNotify dnotify);
		[NoArrayLength ()]
		[CCode (cname = "gtk_print_backend_printer_list_is_done")]
		public bool printer_list_is_done ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_print_backend_remove_printer")]
		public void remove_printer (Gtk.Printer printer);
		[NoArrayLength ()]
		[CCode (cname = "gtk_print_backend_set_list_done")]
		public void set_list_done ();
		public signal void printer_list_changed ();
		public signal void printer_list_done ();
		public signal void printer_added (Gtk.Printer printer);
		public signal void printer_removed (Gtk.Printer printer);
		public signal void printer_status_changed (Gtk.Printer printer);
	}
	[CCode (cheader_filename = "gtk/gtk.h")]
	public class PrintContext : GLib.Object {
		[NoArrayLength ()]
		[CCode (cname = "gtk_print_context_create_pango_context")]
		public Pango.Context create_pango_context ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_print_context_create_pango_layout")]
		public Pango.Layout create_pango_layout ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_print_context_get_cairo_context")]
		public Cairo.Context get_cairo_context ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_print_context_get_dpi_x")]
		public double get_dpi_x ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_print_context_get_dpi_y")]
		public double get_dpi_y ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_print_context_get_height")]
		public double get_height ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_print_context_get_page_setup")]
		public Gtk.PageSetup get_page_setup ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_print_context_get_pango_fontmap")]
		public Pango.FontMap get_pango_fontmap ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_print_context_get_type")]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_print_context_get_width")]
		public double get_width ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_print_context_set_cairo_context")]
		public void set_cairo_context (Cairo.Context cr, double dpi_x, double dpi_y);
	}
	[CCode (cheader_filename = "gtk/gtk.h")]
	public class PrintJob : GLib.Object {
		[NoArrayLength ()]
		[CCode (cname = "gtk_print_job_get_printer")]
		public Gtk.Printer get_printer ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_print_job_get_settings")]
		public Gtk.PrintSettings get_settings ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_print_job_get_status")]
		public Gtk.PrintStatus get_status ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_print_job_get_surface")]
		public Cairo.Surface get_surface (GLib.Error error);
		[NoArrayLength ()]
		[CCode (cname = "gtk_print_job_get_title")]
		public string get_title ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_print_job_get_track_print_status")]
		public bool get_track_print_status ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_print_job_get_type")]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_print_job_new")]
		public construct (string title, Gtk.Printer printer, Gtk.PrintSettings settings, Gtk.PageSetup page_setup);
		[NoArrayLength ()]
		[CCode (cname = "gtk_print_job_send")]
		public void send (Gtk.PrintJobCompleteFunc @callback, pointer user_data, GLib.DestroyNotify dnotify);
		[NoArrayLength ()]
		[CCode (cname = "gtk_print_job_set_source_file")]
		public bool set_source_file (string filename, GLib.Error error);
		[NoArrayLength ()]
		[CCode (cname = "gtk_print_job_set_track_print_status")]
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
	[CCode (cheader_filename = "gtk/gtk.h")]
	public class PrintOperation : GLib.Object, Gtk.PrintOperationPreview {
		[NoArrayLength ()]
		[CCode (cname = "gtk_print_operation_cancel")]
		public void cancel ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_print_operation_get_default_page_setup")]
		public Gtk.PageSetup get_default_page_setup ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_print_operation_get_error")]
		public void get_error (GLib.Error error);
		[NoArrayLength ()]
		[CCode (cname = "gtk_print_operation_get_print_settings")]
		public Gtk.PrintSettings get_print_settings ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_print_operation_get_status")]
		public Gtk.PrintStatus get_status ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_print_operation_get_status_string")]
		public string get_status_string ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_print_operation_get_type")]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_print_operation_is_finished")]
		public bool is_finished ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_print_operation_new")]
		public construct ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_print_operation_run")]
		public Gtk.PrintOperationResult run (Gtk.PrintOperationAction action, Gtk.Window parent, GLib.Error error);
		[NoArrayLength ()]
		[CCode (cname = "gtk_print_operation_set_allow_async")]
		public void set_allow_async (bool allow_async);
		[NoArrayLength ()]
		[CCode (cname = "gtk_print_operation_set_current_page")]
		public void set_current_page (int current_page);
		[NoArrayLength ()]
		[CCode (cname = "gtk_print_operation_set_custom_tab_label")]
		public void set_custom_tab_label (string label);
		[NoArrayLength ()]
		[CCode (cname = "gtk_print_operation_set_default_page_setup")]
		public void set_default_page_setup (Gtk.PageSetup default_page_setup);
		[NoArrayLength ()]
		[CCode (cname = "gtk_print_operation_set_export_filename")]
		public void set_export_filename (string filename);
		[NoArrayLength ()]
		[CCode (cname = "gtk_print_operation_set_job_name")]
		public void set_job_name (string job_name);
		[NoArrayLength ()]
		[CCode (cname = "gtk_print_operation_set_n_pages")]
		public void set_n_pages (int n_pages);
		[NoArrayLength ()]
		[CCode (cname = "gtk_print_operation_set_print_settings")]
		public void set_print_settings (Gtk.PrintSettings print_settings);
		[NoArrayLength ()]
		[CCode (cname = "gtk_print_operation_set_show_progress")]
		public void set_show_progress (bool show_progress);
		[NoArrayLength ()]
		[CCode (cname = "gtk_print_operation_set_track_print_status")]
		public void set_track_print_status (bool track_status);
		[NoArrayLength ()]
		[CCode (cname = "gtk_print_operation_set_unit")]
		public void set_unit (Gtk.Unit unit);
		[NoArrayLength ()]
		[CCode (cname = "gtk_print_operation_set_use_full_page")]
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
	[CCode (cheader_filename = "gtk/gtk.h")]
	public class PrintSettings : GLib.Object {
		[NoArrayLength ()]
		[CCode (cname = "gtk_print_settings_copy")]
		public Gtk.PrintSettings copy ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_print_settings_foreach")]
		public void @foreach (Gtk.PrintSettingsFunc func, pointer user_data);
		[NoArrayLength ()]
		[CCode (cname = "gtk_print_settings_get")]
		public string @get (string key);
		[NoArrayLength ()]
		[CCode (cname = "gtk_print_settings_get_bool")]
		public bool get_bool (string key);
		[NoArrayLength ()]
		[CCode (cname = "gtk_print_settings_get_collate")]
		public bool get_collate ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_print_settings_get_default_source")]
		public string get_default_source ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_print_settings_get_dither")]
		public string get_dither ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_print_settings_get_double")]
		public double get_double (string key);
		[NoArrayLength ()]
		[CCode (cname = "gtk_print_settings_get_double_with_default")]
		public double get_double_with_default (string key, double def);
		[NoArrayLength ()]
		[CCode (cname = "gtk_print_settings_get_duplex")]
		public Gtk.PrintDuplex get_duplex ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_print_settings_get_finishings")]
		public string get_finishings ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_print_settings_get_int")]
		public int get_int (string key);
		[NoArrayLength ()]
		[CCode (cname = "gtk_print_settings_get_int_with_default")]
		public int get_int_with_default (string key, int def);
		[NoArrayLength ()]
		[CCode (cname = "gtk_print_settings_get_length")]
		public double get_length (string key, Gtk.Unit unit);
		[NoArrayLength ()]
		[CCode (cname = "gtk_print_settings_get_media_type")]
		public string get_media_type ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_print_settings_get_n_copies")]
		public int get_n_copies ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_print_settings_get_number_up")]
		public int get_number_up ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_print_settings_get_orientation")]
		public Gtk.PageOrientation get_orientation ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_print_settings_get_output_bin")]
		public string get_output_bin ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_print_settings_get_page_ranges")]
		public Gtk.PageRange get_page_ranges (int num_ranges);
		[NoArrayLength ()]
		[CCode (cname = "gtk_print_settings_get_page_set")]
		public Gtk.PageSet get_page_set ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_print_settings_get_paper_height")]
		public double get_paper_height (Gtk.Unit unit);
		[NoArrayLength ()]
		[CCode (cname = "gtk_print_settings_get_paper_size")]
		public Gtk.PaperSize get_paper_size ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_print_settings_get_paper_width")]
		public double get_paper_width (Gtk.Unit unit);
		[NoArrayLength ()]
		[CCode (cname = "gtk_print_settings_get_print_pages")]
		public Gtk.PrintPages get_print_pages ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_print_settings_get_printer")]
		public string get_printer ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_print_settings_get_quality")]
		public Gtk.PrintQuality get_quality ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_print_settings_get_resolution")]
		public int get_resolution ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_print_settings_get_reverse")]
		public bool get_reverse ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_print_settings_get_scale")]
		public double get_scale ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_print_settings_get_type")]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_print_settings_get_use_color")]
		public bool get_use_color ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_print_settings_has_key")]
		public bool has_key (string key);
		[NoArrayLength ()]
		[CCode (cname = "gtk_print_settings_new")]
		public construct ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_print_settings_set")]
		public void @set (string key, string value);
		[NoArrayLength ()]
		[CCode (cname = "gtk_print_settings_set_bool")]
		public void set_bool (string key, bool value);
		[NoArrayLength ()]
		[CCode (cname = "gtk_print_settings_set_collate")]
		public void set_collate (bool collate);
		[NoArrayLength ()]
		[CCode (cname = "gtk_print_settings_set_default_source")]
		public void set_default_source (string default_source);
		[NoArrayLength ()]
		[CCode (cname = "gtk_print_settings_set_dither")]
		public void set_dither (string dither);
		[NoArrayLength ()]
		[CCode (cname = "gtk_print_settings_set_double")]
		public void set_double (string key, double value);
		[NoArrayLength ()]
		[CCode (cname = "gtk_print_settings_set_duplex")]
		public void set_duplex (Gtk.PrintDuplex duplex);
		[NoArrayLength ()]
		[CCode (cname = "gtk_print_settings_set_finishings")]
		public void set_finishings (string finishings);
		[NoArrayLength ()]
		[CCode (cname = "gtk_print_settings_set_int")]
		public void set_int (string key, int value);
		[NoArrayLength ()]
		[CCode (cname = "gtk_print_settings_set_length")]
		public void set_length (string key, double value, Gtk.Unit unit);
		[NoArrayLength ()]
		[CCode (cname = "gtk_print_settings_set_media_type")]
		public void set_media_type (string media_type);
		[NoArrayLength ()]
		[CCode (cname = "gtk_print_settings_set_n_copies")]
		public void set_n_copies (int num_copies);
		[NoArrayLength ()]
		[CCode (cname = "gtk_print_settings_set_number_up")]
		public void set_number_up (int number_up);
		[NoArrayLength ()]
		[CCode (cname = "gtk_print_settings_set_orientation")]
		public void set_orientation (Gtk.PageOrientation orientation);
		[NoArrayLength ()]
		[CCode (cname = "gtk_print_settings_set_output_bin")]
		public void set_output_bin (string output_bin);
		[NoArrayLength ()]
		[CCode (cname = "gtk_print_settings_set_page_ranges")]
		public void set_page_ranges (Gtk.PageRange page_ranges, int num_ranges);
		[NoArrayLength ()]
		[CCode (cname = "gtk_print_settings_set_page_set")]
		public void set_page_set (Gtk.PageSet page_set);
		[NoArrayLength ()]
		[CCode (cname = "gtk_print_settings_set_paper_height")]
		public void set_paper_height (double height, Gtk.Unit unit);
		[NoArrayLength ()]
		[CCode (cname = "gtk_print_settings_set_paper_size")]
		public void set_paper_size (Gtk.PaperSize paper_size);
		[NoArrayLength ()]
		[CCode (cname = "gtk_print_settings_set_paper_width")]
		public void set_paper_width (double width, Gtk.Unit unit);
		[NoArrayLength ()]
		[CCode (cname = "gtk_print_settings_set_print_pages")]
		public void set_print_pages (Gtk.PrintPages pages);
		[NoArrayLength ()]
		[CCode (cname = "gtk_print_settings_set_printer")]
		public void set_printer (string printer);
		[NoArrayLength ()]
		[CCode (cname = "gtk_print_settings_set_quality")]
		public void set_quality (Gtk.PrintQuality quality);
		[NoArrayLength ()]
		[CCode (cname = "gtk_print_settings_set_resolution")]
		public void set_resolution (int resolution);
		[NoArrayLength ()]
		[CCode (cname = "gtk_print_settings_set_reverse")]
		public void set_reverse (bool reverse);
		[NoArrayLength ()]
		[CCode (cname = "gtk_print_settings_set_scale")]
		public void set_scale (double scale);
		[NoArrayLength ()]
		[CCode (cname = "gtk_print_settings_set_use_color")]
		public void set_use_color (bool use_color);
		[NoArrayLength ()]
		[CCode (cname = "gtk_print_settings_unset")]
		public void unset (string key);
	}
	[CCode (cheader_filename = "gtk/gtk.h")]
	public class PrintUnixDialog : Gtk.Dialog {
		[NoArrayLength ()]
		[CCode (cname = "gtk_print_unix_dialog_add_custom_tab")]
		public void add_custom_tab (Gtk.Widget child, Gtk.Widget tab_label);
		[NoArrayLength ()]
		[CCode (cname = "gtk_print_unix_dialog_get_current_page")]
		public int get_current_page ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_print_unix_dialog_get_page_setup")]
		public Gtk.PageSetup get_page_setup ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_print_unix_dialog_get_selected_printer")]
		public Gtk.Printer get_selected_printer ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_print_unix_dialog_get_settings")]
		public Gtk.PrintSettings get_settings ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_print_unix_dialog_get_type")]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_print_unix_dialog_new")]
		public construct (string title, Gtk.Window parent);
		[NoArrayLength ()]
		[CCode (cname = "gtk_print_unix_dialog_set_current_page")]
		public void set_current_page (int current_page);
		[NoArrayLength ()]
		[CCode (cname = "gtk_print_unix_dialog_set_manual_capabilities")]
		public void set_manual_capabilities (Gtk.PrintCapabilities capabilities);
		[NoArrayLength ()]
		[CCode (cname = "gtk_print_unix_dialog_set_page_setup")]
		public void set_page_setup (Gtk.PageSetup page_setup);
		[NoArrayLength ()]
		[CCode (cname = "gtk_print_unix_dialog_set_settings")]
		public void set_settings (Gtk.PrintSettings settings);
		public weak Gtk.PageSetup page_setup { get; set; }
		public weak int current_page { get; set; }
		[NoAccessorMethod ()]
		public weak Gtk.PrintSettings print_settings { get; set; }
		public weak Gtk.Printer selected_printer { get; }
	}
	[CCode (cheader_filename = "gtk/gtk.h")]
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
	[CCode (cheader_filename = "gtk/gtk.h")]
	public class ProgressBar : Gtk.Progress {
		[NoArrayLength ()]
		[CCode (cname = "gtk_progress_bar_get_ellipsize")]
		public Pango.EllipsizeMode get_ellipsize ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_progress_bar_get_fraction")]
		public double get_fraction ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_progress_bar_get_orientation")]
		public Gtk.ProgressBarOrientation get_orientation ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_progress_bar_get_pulse_step")]
		public double get_pulse_step ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_progress_bar_get_text")]
		public string get_text ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_progress_bar_get_type")]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_progress_bar_new")]
		public construct ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_progress_bar_pulse")]
		public void pulse ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_progress_bar_set_ellipsize")]
		public void set_ellipsize (Pango.EllipsizeMode mode);
		[NoArrayLength ()]
		[CCode (cname = "gtk_progress_bar_set_fraction")]
		public void set_fraction (double fraction);
		[NoArrayLength ()]
		[CCode (cname = "gtk_progress_bar_set_orientation")]
		public void set_orientation (Gtk.ProgressBarOrientation orientation);
		[NoArrayLength ()]
		[CCode (cname = "gtk_progress_bar_set_pulse_step")]
		public void set_pulse_step (double fraction);
		[NoArrayLength ()]
		[CCode (cname = "gtk_progress_bar_set_text")]
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
	[CCode (cheader_filename = "gtk/gtk.h")]
	public class RadioAction : Gtk.ToggleAction {
		[NoArrayLength ()]
		[CCode (cname = "gtk_radio_action_get_current_value")]
		public int get_current_value ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_radio_action_get_group")]
		public GLib.SList get_group ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_radio_action_get_type")]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_radio_action_new")]
		public construct (string name, string label, string tooltip, string stock_id, int value);
		[NoArrayLength ()]
		[CCode (cname = "gtk_radio_action_set_current_value")]
		public void set_current_value (int current_value);
		[NoArrayLength ()]
		[CCode (cname = "gtk_radio_action_set_group")]
		public void set_group (GLib.SList group);
		[NoAccessorMethod ()]
		public weak int value { get; set; }
		public weak Gtk.RadioAction group { set; }
		public weak int current_value { get; set; }
		public signal void changed (Gtk.RadioAction current);
	}
	[CCode (cheader_filename = "gtk/gtk.h")]
	public class RadioButton : Gtk.CheckButton {
		[NoArrayLength ()]
		[CCode (cname = "gtk_radio_button_get_group")]
		public GLib.SList get_group ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_radio_button_get_type")]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_radio_button_new")]
		public construct (GLib.SList group);
		[NoArrayLength ()]
		[CCode (cname = "gtk_radio_button_new_from_widget")]
		public construct from_widget ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_radio_button_new_with_label")]
		public construct with_label (GLib.SList group, string label);
		[NoArrayLength ()]
		[CCode (cname = "gtk_radio_button_new_with_label_from_widget")]
		public construct with_label_from_widget (string label);
		[NoArrayLength ()]
		[CCode (cname = "gtk_radio_button_new_with_mnemonic")]
		public construct with_mnemonic (GLib.SList group, string label);
		[NoArrayLength ()]
		[CCode (cname = "gtk_radio_button_new_with_mnemonic_from_widget")]
		public construct with_mnemonic_from_widget (string label);
		[NoArrayLength ()]
		[CCode (cname = "gtk_radio_button_set_group")]
		public void set_group (GLib.SList group);
		public weak Gtk.RadioButton group { set; }
		public signal void group_changed ();
	}
	[CCode (cheader_filename = "gtk/gtk.h")]
	public class RadioMenuItem : Gtk.CheckMenuItem {
		[NoArrayLength ()]
		[CCode (cname = "gtk_radio_menu_item_get_group")]
		public GLib.SList get_group ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_radio_menu_item_get_type")]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_radio_menu_item_new")]
		public construct (GLib.SList group);
		[NoArrayLength ()]
		[CCode (cname = "gtk_radio_menu_item_new_from_widget")]
		public construct from_widget ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_radio_menu_item_new_with_label")]
		public construct with_label (GLib.SList group, string label);
		[NoArrayLength ()]
		[CCode (cname = "gtk_radio_menu_item_new_with_label_from_widget")]
		public construct with_label_from_widget (string label);
		[NoArrayLength ()]
		[CCode (cname = "gtk_radio_menu_item_new_with_mnemonic")]
		public construct with_mnemonic (GLib.SList group, string label);
		[NoArrayLength ()]
		[CCode (cname = "gtk_radio_menu_item_new_with_mnemonic_from_widget")]
		public construct with_mnemonic_from_widget (string label);
		[NoArrayLength ()]
		[CCode (cname = "gtk_radio_menu_item_set_group")]
		public void set_group (GLib.SList group);
		public weak Gtk.RadioMenuItem group { set; }
		public signal void group_changed ();
	}
	[CCode (cheader_filename = "gtk/gtk.h")]
	public class RadioToolButton : Gtk.ToggleToolButton {
		[NoArrayLength ()]
		[CCode (cname = "gtk_radio_tool_button_get_group")]
		public GLib.SList get_group ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_radio_tool_button_get_type")]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_radio_tool_button_new")]
		public construct (GLib.SList group);
		[NoArrayLength ()]
		[CCode (cname = "gtk_radio_tool_button_new_from_stock")]
		public construct from_stock (GLib.SList group, string stock_id);
		[NoArrayLength ()]
		[CCode (cname = "gtk_radio_tool_button_new_from_widget")]
		public construct from_widget ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_radio_tool_button_new_with_stock_from_widget")]
		public construct with_stock_from_widget (string stock_id);
		[NoArrayLength ()]
		[CCode (cname = "gtk_radio_tool_button_set_group")]
		public void set_group (GLib.SList group);
		public weak Gtk.RadioToolButton group { set; }
	}
	[CCode (cheader_filename = "gtk/gtk.h")]
	public class Range : Gtk.Widget {
		[NoArrayLength ()]
		[CCode (cname = "gtk_range_get_adjustment")]
		public Gtk.Adjustment get_adjustment ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_range_get_inverted")]
		public bool get_inverted ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_range_get_lower_stepper_sensitivity")]
		public Gtk.SensitivityType get_lower_stepper_sensitivity ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_range_get_type")]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_range_get_update_policy")]
		public Gtk.UpdateType get_update_policy ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_range_get_upper_stepper_sensitivity")]
		public Gtk.SensitivityType get_upper_stepper_sensitivity ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_range_get_value")]
		public double get_value ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_range_set_adjustment")]
		public void set_adjustment (Gtk.Adjustment adjustment);
		[NoArrayLength ()]
		[CCode (cname = "gtk_range_set_increments")]
		public void set_increments (double step, double page);
		[NoArrayLength ()]
		[CCode (cname = "gtk_range_set_inverted")]
		public void set_inverted (bool setting);
		[NoArrayLength ()]
		[CCode (cname = "gtk_range_set_lower_stepper_sensitivity")]
		public void set_lower_stepper_sensitivity (Gtk.SensitivityType sensitivity);
		[NoArrayLength ()]
		[CCode (cname = "gtk_range_set_range")]
		public void set_range (double min, double max);
		[NoArrayLength ()]
		[CCode (cname = "gtk_range_set_update_policy")]
		public void set_update_policy (Gtk.UpdateType policy);
		[NoArrayLength ()]
		[CCode (cname = "gtk_range_set_upper_stepper_sensitivity")]
		public void set_upper_stepper_sensitivity (Gtk.SensitivityType sensitivity);
		[NoArrayLength ()]
		[CCode (cname = "gtk_range_set_value")]
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
	[CCode (cheader_filename = "gtk/gtk.h")]
	public class RcStyle : GLib.Object {
		public weak string name;
		public weak string bg_pixmap_name;
		public Pango.FontDescription font_desc;
		public Gtk.RcFlags color_flags;
		public Gdk.Color fg;
		public Gdk.Color bg;
		public Gdk.Color text;
		public Gdk.Color @base;
		public int xthickness;
		public int ythickness;
		[NoArrayLength ()]
		[CCode (cname = "gtk_rc_style_copy")]
		public Gtk.RcStyle copy ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_rc_style_get_type")]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_rc_style_new")]
		public construct ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_rc_style_ref")]
		public void @ref ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_rc_style_unref")]
		public void unref ();
	}
	[CCode (cheader_filename = "gtk/gtk.h")]
	public class RecentChooserDefault : Gtk.VBox, Gtk.RecentChooser {
	}
	[CCode (cheader_filename = "gtk/gtk.h")]
	public class RecentChooserDialog : Gtk.Dialog, Gtk.RecentChooser {
		[NoArrayLength ()]
		[CCode (cname = "gtk_recent_chooser_dialog_get_type")]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_recent_chooser_dialog_new")]
		public construct (string title, Gtk.Window parent, string first_button_text);
		[NoArrayLength ()]
		[CCode (cname = "gtk_recent_chooser_dialog_new_for_manager")]
		public construct for_manager (string title, Gtk.Window parent, Gtk.RecentManager manager, string first_button_text);
	}
	[CCode (cheader_filename = "gtk/gtk.h")]
	public class RecentChooserMenu : Gtk.Menu, Gtk.RecentChooser {
		[NoArrayLength ()]
		[CCode (cname = "gtk_recent_chooser_menu_get_show_numbers")]
		public bool get_show_numbers ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_recent_chooser_menu_get_type")]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_recent_chooser_menu_new")]
		public construct ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_recent_chooser_menu_new_for_manager")]
		public construct for_manager (Gtk.RecentManager manager);
		[NoArrayLength ()]
		[CCode (cname = "gtk_recent_chooser_menu_set_show_numbers")]
		public void set_show_numbers (bool show_numbers);
		public weak bool show_numbers { get; set; }
	}
	[CCode (cheader_filename = "gtk/gtk.h")]
	public class RecentChooserWidget : Gtk.VBox, Gtk.RecentChooser {
		[NoArrayLength ()]
		[CCode (cname = "gtk_recent_chooser_widget_get_type")]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_recent_chooser_widget_new")]
		public construct ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_recent_chooser_widget_new_for_manager")]
		public construct for_manager (Gtk.RecentManager manager);
	}
	[CCode (cheader_filename = "gtk/gtk.h")]
	public class RecentFilter : Gtk.Object {
		[NoArrayLength ()]
		[CCode (cname = "gtk_recent_filter_add_age")]
		public void add_age (int days);
		[NoArrayLength ()]
		[CCode (cname = "gtk_recent_filter_add_application")]
		public void add_application (string application);
		[NoArrayLength ()]
		[CCode (cname = "gtk_recent_filter_add_custom")]
		public void add_custom (Gtk.RecentFilterFlags needed, Gtk.RecentFilterFunc func, pointer data, GLib.DestroyNotify data_destroy);
		[NoArrayLength ()]
		[CCode (cname = "gtk_recent_filter_add_group")]
		public void add_group (string group);
		[NoArrayLength ()]
		[CCode (cname = "gtk_recent_filter_add_mime_type")]
		public void add_mime_type (string mime_type);
		[NoArrayLength ()]
		[CCode (cname = "gtk_recent_filter_add_pattern")]
		public void add_pattern (string pattern);
		[NoArrayLength ()]
		[CCode (cname = "gtk_recent_filter_add_pixbuf_formats")]
		public void add_pixbuf_formats ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_recent_filter_filter")]
		public bool filter (Gtk.RecentFilterInfo filter_info);
		[NoArrayLength ()]
		[CCode (cname = "gtk_recent_filter_get_name")]
		public string get_name ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_recent_filter_get_needed")]
		public Gtk.RecentFilterFlags get_needed ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_recent_filter_get_type")]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_recent_filter_new")]
		public construct ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_recent_filter_set_name")]
		public void set_name (string name);
	}
	[CCode (cheader_filename = "gtk/gtk.h")]
	public class RecentManager : GLib.Object {
		[NoArrayLength ()]
		[CCode (cname = "gtk_recent_manager_add_full")]
		public bool add_full (string uri, Gtk.RecentData recent_data);
		[NoArrayLength ()]
		[CCode (cname = "gtk_recent_manager_add_item")]
		public bool add_item (string uri);
		[NoArrayLength ()]
		[CCode (cname = "gtk_recent_manager_error_quark")]
		public static GLib.Quark error_quark ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_recent_manager_get_default")]
		public static Gtk.RecentManager get_default ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_recent_manager_get_for_screen")]
		public static Gtk.RecentManager get_for_screen (Gdk.Screen screen);
		[NoArrayLength ()]
		[CCode (cname = "gtk_recent_manager_get_items")]
		public GLib.List get_items ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_recent_manager_get_limit")]
		public int get_limit ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_recent_manager_get_type")]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_recent_manager_has_item")]
		public bool has_item (string uri);
		[NoArrayLength ()]
		[CCode (cname = "gtk_recent_manager_lookup_item")]
		public Gtk.RecentInfo lookup_item (string uri, GLib.Error error);
		[NoArrayLength ()]
		[CCode (cname = "gtk_recent_manager_move_item")]
		public bool move_item (string uri, string new_uri, GLib.Error error);
		[NoArrayLength ()]
		[CCode (cname = "gtk_recent_manager_new")]
		public construct ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_recent_manager_purge_items")]
		public int purge_items (GLib.Error error);
		[NoArrayLength ()]
		[CCode (cname = "gtk_recent_manager_remove_item")]
		public bool remove_item (string uri, GLib.Error error);
		[NoArrayLength ()]
		[CCode (cname = "gtk_recent_manager_set_limit")]
		public void set_limit (int limit);
		[NoArrayLength ()]
		[CCode (cname = "gtk_recent_manager_set_screen")]
		public void set_screen (Gdk.Screen screen);
		[NoAccessorMethod ()]
		public weak string filename { get; construct; }
		public weak int limit { get; set; }
		[NoAccessorMethod ()]
		public weak int size { get; }
		public signal void changed ();
	}
	[CCode (cheader_filename = "gtk/gtk.h")]
	public class Ruler : Gtk.Widget {
		[NoArrayLength ()]
		[CCode (cname = "gtk_ruler_draw_pos")]
		public virtual void draw_pos ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_ruler_draw_ticks")]
		public virtual void draw_ticks ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_ruler_get_metric")]
		public Gtk.MetricType get_metric ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_ruler_get_range")]
		public void get_range (double lower, double upper, double position, double max_size);
		[NoArrayLength ()]
		[CCode (cname = "gtk_ruler_get_type")]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_ruler_set_metric")]
		public void set_metric (Gtk.MetricType metric);
		[NoArrayLength ()]
		[CCode (cname = "gtk_ruler_set_range")]
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
	[CCode (cheader_filename = "gtk/gtk.h")]
	public class Scale : Gtk.Range {
		[NoArrayLength ()]
		[CCode (cname = "gtk_scale_get_digits")]
		public int get_digits ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_scale_get_draw_value")]
		public bool get_draw_value ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_scale_get_layout")]
		public Pango.Layout get_layout ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_scale_get_layout_offsets")]
		public virtual void get_layout_offsets (int x, int y);
		[NoArrayLength ()]
		[CCode (cname = "gtk_scale_get_type")]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_scale_get_value_pos")]
		public Gtk.PositionType get_value_pos ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_scale_set_digits")]
		public void set_digits (int digits);
		[NoArrayLength ()]
		[CCode (cname = "gtk_scale_set_draw_value")]
		public void set_draw_value (bool draw_value);
		[NoArrayLength ()]
		[CCode (cname = "gtk_scale_set_value_pos")]
		public void set_value_pos (Gtk.PositionType pos);
		public weak int digits { get; set; }
		public weak bool draw_value { get; set; }
		public weak Gtk.PositionType value_pos { get; set; }
		public signal string format_value (double value);
	}
	[CCode (cheader_filename = "gtk/gtk.h")]
	public class Scrollbar : Gtk.Range {
		[NoArrayLength ()]
		[CCode (cname = "gtk_scrollbar_get_type")]
		public static GLib.Type get_type ();
	}
	[CCode (cheader_filename = "gtk/gtk.h")]
	public class ScrolledWindow : Gtk.Bin {
		public weak Gtk.Widget hscrollbar;
		public weak Gtk.Widget vscrollbar;
		[NoArrayLength ()]
		[CCode (cname = "gtk_scrolled_window_add_with_viewport")]
		public void add_with_viewport (Gtk.Widget child);
		[NoArrayLength ()]
		[CCode (cname = "gtk_scrolled_window_get_hadjustment")]
		public Gtk.Adjustment get_hadjustment ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_scrolled_window_get_hscrollbar")]
		public Gtk.Widget get_hscrollbar ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_scrolled_window_get_placement")]
		public Gtk.CornerType get_placement ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_scrolled_window_get_policy")]
		public void get_policy (Gtk.PolicyType hscrollbar_policy, Gtk.PolicyType vscrollbar_policy);
		[NoArrayLength ()]
		[CCode (cname = "gtk_scrolled_window_get_shadow_type")]
		public Gtk.ShadowType get_shadow_type ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_scrolled_window_get_type")]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_scrolled_window_get_vadjustment")]
		public Gtk.Adjustment get_vadjustment ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_scrolled_window_get_vscrollbar")]
		public Gtk.Widget get_vscrollbar ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_scrolled_window_new")]
		public construct (Gtk.Adjustment hadjustment, Gtk.Adjustment vadjustment);
		[NoArrayLength ()]
		[CCode (cname = "gtk_scrolled_window_set_hadjustment")]
		public void set_hadjustment (Gtk.Adjustment hadjustment);
		[NoArrayLength ()]
		[CCode (cname = "gtk_scrolled_window_set_placement")]
		public void set_placement (Gtk.CornerType window_placement);
		[NoArrayLength ()]
		[CCode (cname = "gtk_scrolled_window_set_policy")]
		public void set_policy (Gtk.PolicyType hscrollbar_policy, Gtk.PolicyType vscrollbar_policy);
		[NoArrayLength ()]
		[CCode (cname = "gtk_scrolled_window_set_shadow_type")]
		public void set_shadow_type (Gtk.ShadowType type);
		[NoArrayLength ()]
		[CCode (cname = "gtk_scrolled_window_set_vadjustment")]
		public void set_vadjustment (Gtk.Adjustment vadjustment);
		[NoArrayLength ()]
		[CCode (cname = "gtk_scrolled_window_unset_placement")]
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
		public signal bool scroll_child (Gtk.ScrollType scroll, bool horizontal);
		public signal void move_focus_out (Gtk.DirectionType direction);
	}
	[CCode (cheader_filename = "gtk/gtk.h")]
	public class Separator : Gtk.Widget {
		[NoArrayLength ()]
		[CCode (cname = "gtk_separator_get_type")]
		public static GLib.Type get_type ();
	}
	[CCode (cheader_filename = "gtk/gtk.h")]
	public class SeparatorMenuItem : Gtk.MenuItem {
		[NoArrayLength ()]
		[CCode (cname = "gtk_separator_menu_item_get_type")]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_separator_menu_item_new")]
		public construct ();
	}
	[CCode (cheader_filename = "gtk/gtk.h")]
	public class SeparatorToolItem : Gtk.ToolItem {
		[NoArrayLength ()]
		[CCode (cname = "gtk_separator_tool_item_get_draw")]
		public bool get_draw ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_separator_tool_item_get_type")]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_separator_tool_item_new")]
		public construct ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_separator_tool_item_set_draw")]
		public void set_draw (bool draw);
		public weak bool draw { get; set; }
	}
	[CCode (cheader_filename = "gtk/gtk.h")]
	public class Settings : GLib.Object {
		[NoArrayLength ()]
		[CCode (cname = "gtk_settings_get_default")]
		public static Gtk.Settings get_default ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_settings_get_for_screen")]
		public static Gtk.Settings get_for_screen (Gdk.Screen screen);
		[NoArrayLength ()]
		[CCode (cname = "gtk_settings_get_type")]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_settings_install_property")]
		public static void install_property (GLib.ParamSpec pspec);
		[NoArrayLength ()]
		[CCode (cname = "gtk_settings_install_property_parser")]
		public static void install_property_parser (GLib.ParamSpec pspec, Gtk.RcPropertyParser parser);
		[NoArrayLength ()]
		[CCode (cname = "gtk_settings_set_double_property")]
		public void set_double_property (string name, double v_double, string origin);
		[NoArrayLength ()]
		[CCode (cname = "gtk_settings_set_long_property")]
		public void set_long_property (string name, long v_long, string origin);
		[NoArrayLength ()]
		[CCode (cname = "gtk_settings_set_property_value")]
		public void set_property_value (string name, Gtk.SettingsValue svalue);
		[NoArrayLength ()]
		[CCode (cname = "gtk_settings_set_string_property")]
		public void set_string_property (string name, string v_string, string origin);
		[NoAccessorMethod ()]
		public weak GLib.HashTable color_hash { get; }
	}
	[CCode (cheader_filename = "gtk/gtk.h")]
	public class SizeGroup : GLib.Object {
		[NoArrayLength ()]
		[CCode (cname = "gtk_size_group_add_widget")]
		public void add_widget (Gtk.Widget widget);
		[NoArrayLength ()]
		[CCode (cname = "gtk_size_group_get_ignore_hidden")]
		public bool get_ignore_hidden ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_size_group_get_mode")]
		public Gtk.SizeGroupMode get_mode ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_size_group_get_type")]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_size_group_get_widgets")]
		public GLib.SList get_widgets ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_size_group_new")]
		public construct (Gtk.SizeGroupMode mode);
		[NoArrayLength ()]
		[CCode (cname = "gtk_size_group_remove_widget")]
		public void remove_widget (Gtk.Widget widget);
		[NoArrayLength ()]
		[CCode (cname = "gtk_size_group_set_ignore_hidden")]
		public void set_ignore_hidden (bool ignore_hidden);
		[NoArrayLength ()]
		[CCode (cname = "gtk_size_group_set_mode")]
		public void set_mode (Gtk.SizeGroupMode mode);
		public weak Gtk.SizeGroupMode mode { get; set; }
		public weak bool ignore_hidden { get; set; }
	}
	[CCode (cheader_filename = "gtk/gtk.h")]
	public class Socket : Gtk.Container {
		[NoArrayLength ()]
		[CCode (cname = "gtk_socket_add_id")]
		public void add_id (pointer window_id);
		[NoArrayLength ()]
		[CCode (cname = "gtk_socket_get_id")]
		public pointer get_id ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_socket_get_type")]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_socket_new")]
		public construct ();
		public signal void plug_added ();
		public signal bool plug_removed ();
	}
	[CCode (cheader_filename = "gtk/gtk.h")]
	public class SpinButton : Gtk.Entry, Gtk.Editable {
		[NoArrayLength ()]
		[CCode (cname = "gtk_spin_button_configure")]
		public void configure (Gtk.Adjustment adjustment, double climb_rate, uint digits);
		[NoArrayLength ()]
		[CCode (cname = "gtk_spin_button_get_adjustment")]
		public Gtk.Adjustment get_adjustment ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_spin_button_get_digits")]
		public uint get_digits ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_spin_button_get_increments")]
		public void get_increments (double step, double page);
		[NoArrayLength ()]
		[CCode (cname = "gtk_spin_button_get_numeric")]
		public bool get_numeric ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_spin_button_get_range")]
		public void get_range (double min, double max);
		[NoArrayLength ()]
		[CCode (cname = "gtk_spin_button_get_snap_to_ticks")]
		public bool get_snap_to_ticks ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_spin_button_get_type")]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_spin_button_get_update_policy")]
		public Gtk.SpinButtonUpdatePolicy get_update_policy ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_spin_button_get_value")]
		public double get_value ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_spin_button_get_value_as_int")]
		public int get_value_as_int ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_spin_button_get_wrap")]
		public bool get_wrap ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_spin_button_new")]
		public construct (Gtk.Adjustment adjustment, double climb_rate, uint digits);
		[NoArrayLength ()]
		[CCode (cname = "gtk_spin_button_new_with_range")]
		public construct with_range (double min, double max, double step);
		[NoArrayLength ()]
		[CCode (cname = "gtk_spin_button_set_adjustment")]
		public void set_adjustment (Gtk.Adjustment adjustment);
		[NoArrayLength ()]
		[CCode (cname = "gtk_spin_button_set_digits")]
		public void set_digits (uint digits);
		[NoArrayLength ()]
		[CCode (cname = "gtk_spin_button_set_increments")]
		public void set_increments (double step, double page);
		[NoArrayLength ()]
		[CCode (cname = "gtk_spin_button_set_numeric")]
		public void set_numeric (bool numeric);
		[NoArrayLength ()]
		[CCode (cname = "gtk_spin_button_set_range")]
		public void set_range (double min, double max);
		[NoArrayLength ()]
		[CCode (cname = "gtk_spin_button_set_snap_to_ticks")]
		public void set_snap_to_ticks (bool snap_to_ticks);
		[NoArrayLength ()]
		[CCode (cname = "gtk_spin_button_set_update_policy")]
		public void set_update_policy (Gtk.SpinButtonUpdatePolicy policy);
		[NoArrayLength ()]
		[CCode (cname = "gtk_spin_button_set_value")]
		public void set_value (double value);
		[NoArrayLength ()]
		[CCode (cname = "gtk_spin_button_set_wrap")]
		public void set_wrap (bool wrap);
		[NoArrayLength ()]
		[CCode (cname = "gtk_spin_button_spin")]
		public void spin (Gtk.SpinType direction, double increment);
		[NoArrayLength ()]
		[CCode (cname = "gtk_spin_button_update")]
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
	[CCode (cheader_filename = "gtk/gtk.h")]
	public class Statusbar : Gtk.HBox {
		[NoArrayLength ()]
		[CCode (cname = "gtk_statusbar_get_context_id")]
		public uint get_context_id (string context_description);
		[NoArrayLength ()]
		[CCode (cname = "gtk_statusbar_get_has_resize_grip")]
		public bool get_has_resize_grip ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_statusbar_get_type")]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_statusbar_new")]
		public construct ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_statusbar_pop")]
		public void pop (uint context_id);
		[NoArrayLength ()]
		[CCode (cname = "gtk_statusbar_push")]
		public uint push (uint context_id, string text);
		[NoArrayLength ()]
		[CCode (cname = "gtk_statusbar_remove")]
		public void remove (uint context_id, uint message_id);
		[NoArrayLength ()]
		[CCode (cname = "gtk_statusbar_set_has_resize_grip")]
		public void set_has_resize_grip (bool setting);
		public weak bool has_resize_grip { get; set; }
		public signal void text_pushed (uint context_id, string text);
		public signal void text_popped (uint context_id, string text);
	}
	[CCode (cheader_filename = "gtk/gtk.h")]
	public class StatusIcon : GLib.Object {
		[NoArrayLength ()]
		[CCode (cname = "gtk_status_icon_get_blinking")]
		public bool get_blinking ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_status_icon_get_geometry")]
		public bool get_geometry (Gdk.Screen screen, Gdk.Rectangle area, Gtk.Orientation orientation);
		[NoArrayLength ()]
		[CCode (cname = "gtk_status_icon_get_icon_name")]
		public string get_icon_name ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_status_icon_get_pixbuf")]
		public Gdk.Pixbuf get_pixbuf ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_status_icon_get_size")]
		public int get_size ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_status_icon_get_stock")]
		public string get_stock ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_status_icon_get_storage_type")]
		public Gtk.ImageType get_storage_type ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_status_icon_get_type")]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_status_icon_get_visible")]
		public bool get_visible ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_status_icon_is_embedded")]
		public bool is_embedded ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_status_icon_new")]
		public construct ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_status_icon_new_from_file")]
		public construct from_file (string filename);
		[NoArrayLength ()]
		[CCode (cname = "gtk_status_icon_new_from_icon_name")]
		public construct from_icon_name (string icon_name);
		[NoArrayLength ()]
		[CCode (cname = "gtk_status_icon_new_from_pixbuf")]
		public construct from_pixbuf (Gdk.Pixbuf pixbuf);
		[NoArrayLength ()]
		[CCode (cname = "gtk_status_icon_new_from_stock")]
		public construct from_stock (string stock_id);
		[NoArrayLength ()]
		[CCode (cname = "gtk_status_icon_position_menu")]
		public static void position_menu (Gtk.Menu menu, int x, int y, bool push_in, pointer user_data);
		[NoArrayLength ()]
		[CCode (cname = "gtk_status_icon_set_blinking")]
		public void set_blinking (bool blinking);
		[NoArrayLength ()]
		[CCode (cname = "gtk_status_icon_set_from_file")]
		public void set_from_file (string filename);
		[NoArrayLength ()]
		[CCode (cname = "gtk_status_icon_set_from_icon_name")]
		public void set_from_icon_name (string icon_name);
		[NoArrayLength ()]
		[CCode (cname = "gtk_status_icon_set_from_pixbuf")]
		public void set_from_pixbuf (Gdk.Pixbuf pixbuf);
		[NoArrayLength ()]
		[CCode (cname = "gtk_status_icon_set_from_stock")]
		public void set_from_stock (string stock_id);
		[NoArrayLength ()]
		[CCode (cname = "gtk_status_icon_set_tooltip")]
		public void set_tooltip (string tooltip_text);
		[NoArrayLength ()]
		[CCode (cname = "gtk_status_icon_set_visible")]
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
	[CCode (cheader_filename = "gtk/gtk.h")]
	public class Style : GLib.Object {
		public Gdk.Color fg;
		public Gdk.Color bg;
		public Gdk.Color light;
		public Gdk.Color dark;
		public Gdk.Color mid;
		public Gdk.Color text;
		public Gdk.Color @base;
		public Gdk.Color text_aa;
		public Gdk.Color black;
		public Gdk.Color white;
		public Pango.FontDescription font_desc;
		public int xthickness;
		public int ythickness;
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
		[CCode (cname = "gtk_style_apply_default_background")]
		public void apply_default_background (Gdk.Window window, bool set_bg, Gtk.StateType state_type, Gdk.Rectangle area, int x, int y, int width, int height);
		[NoArrayLength ()]
		[CCode (cname = "gtk_style_attach")]
		public Gtk.Style attach (Gdk.Window window);
		[NoArrayLength ()]
		[CCode (cname = "gtk_style_copy")]
		public virtual Gtk.Style copy ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_style_detach")]
		public void detach ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_style_get_type")]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_style_lookup_color")]
		public bool lookup_color (string color_name, Gdk.Color color);
		[NoArrayLength ()]
		[CCode (cname = "gtk_style_lookup_icon_set")]
		public Gtk.IconSet lookup_icon_set (string stock_id);
		[NoArrayLength ()]
		[CCode (cname = "gtk_style_new")]
		public construct ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_style_render_icon")]
		public virtual Gdk.Pixbuf render_icon (Gtk.IconSource source, Gtk.TextDirection direction, Gtk.StateType state, Gtk.IconSize size, Gtk.Widget widget, string detail);
		[NoArrayLength ()]
		[CCode (cname = "gtk_style_set_background")]
		public virtual void set_background (Gdk.Window window, Gtk.StateType state_type);
		public signal void realize ();
		public signal void unrealize ();
	}
	[CCode (cheader_filename = "gtk/gtk.h")]
	public class Table : Gtk.Container {
		[NoArrayLength ()]
		[CCode (cname = "gtk_table_attach")]
		public void attach (Gtk.Widget child, uint left_attach, uint right_attach, uint top_attach, uint bottom_attach, Gtk.AttachOptions xoptions, Gtk.AttachOptions yoptions, uint xpadding, uint ypadding);
		[NoArrayLength ()]
		[CCode (cname = "gtk_table_attach_defaults")]
		public void attach_defaults (Gtk.Widget widget, uint left_attach, uint right_attach, uint top_attach, uint bottom_attach);
		[NoArrayLength ()]
		[CCode (cname = "gtk_table_get_col_spacing")]
		public uint get_col_spacing (uint column);
		[NoArrayLength ()]
		[CCode (cname = "gtk_table_get_default_col_spacing")]
		public uint get_default_col_spacing ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_table_get_default_row_spacing")]
		public uint get_default_row_spacing ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_table_get_homogeneous")]
		public bool get_homogeneous ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_table_get_row_spacing")]
		public uint get_row_spacing (uint row);
		[NoArrayLength ()]
		[CCode (cname = "gtk_table_get_type")]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_table_new")]
		public construct (uint rows, uint columns, bool homogeneous);
		[NoArrayLength ()]
		[CCode (cname = "gtk_table_resize")]
		public void resize (uint rows, uint columns);
		[NoArrayLength ()]
		[CCode (cname = "gtk_table_set_col_spacing")]
		public void set_col_spacing (uint column, uint spacing);
		[NoArrayLength ()]
		[CCode (cname = "gtk_table_set_col_spacings")]
		public void set_col_spacings (uint spacing);
		[NoArrayLength ()]
		[CCode (cname = "gtk_table_set_homogeneous")]
		public void set_homogeneous (bool homogeneous);
		[NoArrayLength ()]
		[CCode (cname = "gtk_table_set_row_spacing")]
		public void set_row_spacing (uint row, uint spacing);
		[NoArrayLength ()]
		[CCode (cname = "gtk_table_set_row_spacings")]
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
	[CCode (cheader_filename = "gtk/gtk.h")]
	public class TearoffMenuItem : Gtk.MenuItem {
		[NoArrayLength ()]
		[CCode (cname = "gtk_tearoff_menu_item_get_type")]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_tearoff_menu_item_new")]
		public construct ();
	}
	[CCode (cheader_filename = "gtk/gtk.h")]
	public class TextBuffer : GLib.Object {
		[NoArrayLength ()]
		[CCode (cname = "gtk_text_buffer_add_selection_clipboard")]
		public void add_selection_clipboard (Gtk.Clipboard clipboard);
		[NoArrayLength ()]
		[CCode (cname = "gtk_text_buffer_apply_tag_by_name")]
		public void apply_tag_by_name (string name, Gtk.TextIter start, Gtk.TextIter end);
		[NoArrayLength ()]
		[CCode (cname = "gtk_text_buffer_backspace")]
		public bool backspace (Gtk.TextIter iter, bool interactive, bool default_editable);
		[NoArrayLength ()]
		[CCode (cname = "gtk_text_buffer_copy_clipboard")]
		public void copy_clipboard (Gtk.Clipboard clipboard);
		[NoArrayLength ()]
		[CCode (cname = "gtk_text_buffer_create_child_anchor")]
		public Gtk.TextChildAnchor create_child_anchor (Gtk.TextIter iter);
		[NoArrayLength ()]
		[CCode (cname = "gtk_text_buffer_create_mark")]
		public Gtk.TextMark create_mark (string mark_name, Gtk.TextIter where, bool left_gravity);
		[NoArrayLength ()]
		[CCode (cname = "gtk_text_buffer_create_tag")]
		public Gtk.TextTag create_tag (string tag_name, string first_property_name);
		[NoArrayLength ()]
		[CCode (cname = "gtk_text_buffer_cut_clipboard")]
		public void cut_clipboard (Gtk.Clipboard clipboard, bool default_editable);
		[NoArrayLength ()]
		[CCode (cname = "gtk_text_buffer_delete")]
		public void delete (Gtk.TextIter start, Gtk.TextIter end);
		[NoArrayLength ()]
		[CCode (cname = "gtk_text_buffer_delete_interactive")]
		public bool delete_interactive (Gtk.TextIter start_iter, Gtk.TextIter end_iter, bool default_editable);
		[NoArrayLength ()]
		[CCode (cname = "gtk_text_buffer_delete_mark")]
		public void delete_mark (Gtk.TextMark mark);
		[NoArrayLength ()]
		[CCode (cname = "gtk_text_buffer_delete_mark_by_name")]
		public void delete_mark_by_name (string name);
		[NoArrayLength ()]
		[CCode (cname = "gtk_text_buffer_delete_selection")]
		public bool delete_selection (bool interactive, bool default_editable);
		[NoArrayLength ()]
		[CCode (cname = "gtk_text_buffer_deserialize")]
		public bool deserialize (Gtk.TextBuffer content_buffer, Gdk.Atom format, Gtk.TextIter iter, uchar[] data, ulong length, GLib.Error error);
		[NoArrayLength ()]
		[CCode (cname = "gtk_text_buffer_deserialize_get_can_create_tags")]
		public bool deserialize_get_can_create_tags (Gdk.Atom format);
		[NoArrayLength ()]
		[CCode (cname = "gtk_text_buffer_deserialize_set_can_create_tags")]
		public void deserialize_set_can_create_tags (Gdk.Atom format, bool can_create_tags);
		[NoArrayLength ()]
		[CCode (cname = "gtk_text_buffer_get_bounds")]
		public void get_bounds (Gtk.TextIter start, Gtk.TextIter end);
		[NoArrayLength ()]
		[CCode (cname = "gtk_text_buffer_get_char_count")]
		public int get_char_count ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_text_buffer_get_copy_target_list")]
		public Gtk.TargetList get_copy_target_list ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_text_buffer_get_deserialize_formats")]
		public Gdk.Atom get_deserialize_formats (int n_formats);
		[NoArrayLength ()]
		[CCode (cname = "gtk_text_buffer_get_end_iter")]
		public void get_end_iter (Gtk.TextIter iter);
		[NoArrayLength ()]
		[CCode (cname = "gtk_text_buffer_get_has_selection")]
		public bool get_has_selection ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_text_buffer_get_insert")]
		public Gtk.TextMark get_insert ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_text_buffer_get_iter_at_child_anchor")]
		public void get_iter_at_child_anchor (Gtk.TextIter iter, Gtk.TextChildAnchor anchor);
		[NoArrayLength ()]
		[CCode (cname = "gtk_text_buffer_get_iter_at_line")]
		public void get_iter_at_line (Gtk.TextIter iter, int line_number);
		[NoArrayLength ()]
		[CCode (cname = "gtk_text_buffer_get_iter_at_line_index")]
		public void get_iter_at_line_index (Gtk.TextIter iter, int line_number, int byte_index);
		[NoArrayLength ()]
		[CCode (cname = "gtk_text_buffer_get_iter_at_line_offset")]
		public void get_iter_at_line_offset (Gtk.TextIter iter, int line_number, int char_offset);
		[NoArrayLength ()]
		[CCode (cname = "gtk_text_buffer_get_iter_at_mark")]
		public void get_iter_at_mark (Gtk.TextIter iter, Gtk.TextMark mark);
		[NoArrayLength ()]
		[CCode (cname = "gtk_text_buffer_get_iter_at_offset")]
		public void get_iter_at_offset (Gtk.TextIter iter, int char_offset);
		[NoArrayLength ()]
		[CCode (cname = "gtk_text_buffer_get_line_count")]
		public int get_line_count ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_text_buffer_get_mark")]
		public Gtk.TextMark get_mark (string name);
		[NoArrayLength ()]
		[CCode (cname = "gtk_text_buffer_get_modified")]
		public bool get_modified ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_text_buffer_get_paste_target_list")]
		public Gtk.TargetList get_paste_target_list ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_text_buffer_get_selection_bound")]
		public Gtk.TextMark get_selection_bound ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_text_buffer_get_selection_bounds")]
		public bool get_selection_bounds (Gtk.TextIter start, Gtk.TextIter end);
		[NoArrayLength ()]
		[CCode (cname = "gtk_text_buffer_get_serialize_formats")]
		public Gdk.Atom get_serialize_formats (int n_formats);
		[NoArrayLength ()]
		[CCode (cname = "gtk_text_buffer_get_slice")]
		public string get_slice (Gtk.TextIter start, Gtk.TextIter end, bool include_hidden_chars);
		[NoArrayLength ()]
		[CCode (cname = "gtk_text_buffer_get_start_iter")]
		public void get_start_iter (Gtk.TextIter iter);
		[NoArrayLength ()]
		[CCode (cname = "gtk_text_buffer_get_tag_table")]
		public Gtk.TextTagTable get_tag_table ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_text_buffer_get_text")]
		public string get_text (Gtk.TextIter start, Gtk.TextIter end, bool include_hidden_chars);
		[NoArrayLength ()]
		[CCode (cname = "gtk_text_buffer_get_type")]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_text_buffer_insert")]
		public void insert (Gtk.TextIter iter, string text, int len);
		[NoArrayLength ()]
		[CCode (cname = "gtk_text_buffer_insert_at_cursor")]
		public void insert_at_cursor (string text, int len);
		[NoArrayLength ()]
		[CCode (cname = "gtk_text_buffer_insert_interactive")]
		public bool insert_interactive (Gtk.TextIter iter, string text, int len, bool default_editable);
		[NoArrayLength ()]
		[CCode (cname = "gtk_text_buffer_insert_interactive_at_cursor")]
		public bool insert_interactive_at_cursor (string text, int len, bool default_editable);
		[NoArrayLength ()]
		[CCode (cname = "gtk_text_buffer_insert_range")]
		public void insert_range (Gtk.TextIter iter, Gtk.TextIter start, Gtk.TextIter end);
		[NoArrayLength ()]
		[CCode (cname = "gtk_text_buffer_insert_range_interactive")]
		public bool insert_range_interactive (Gtk.TextIter iter, Gtk.TextIter start, Gtk.TextIter end, bool default_editable);
		[NoArrayLength ()]
		[CCode (cname = "gtk_text_buffer_insert_with_tags")]
		public void insert_with_tags (Gtk.TextIter iter, string text, int len, Gtk.TextTag first_tag);
		[NoArrayLength ()]
		[CCode (cname = "gtk_text_buffer_insert_with_tags_by_name")]
		public void insert_with_tags_by_name (Gtk.TextIter iter, string text, int len, string first_tag_name);
		[NoArrayLength ()]
		[CCode (cname = "gtk_text_buffer_move_mark")]
		public void move_mark (Gtk.TextMark mark, Gtk.TextIter where);
		[NoArrayLength ()]
		[CCode (cname = "gtk_text_buffer_move_mark_by_name")]
		public void move_mark_by_name (string name, Gtk.TextIter where);
		[NoArrayLength ()]
		[CCode (cname = "gtk_text_buffer_new")]
		public construct (Gtk.TextTagTable table);
		[NoArrayLength ()]
		[CCode (cname = "gtk_text_buffer_paste_clipboard")]
		public void paste_clipboard (Gtk.Clipboard clipboard, Gtk.TextIter override_location, bool default_editable);
		[NoArrayLength ()]
		[CCode (cname = "gtk_text_buffer_place_cursor")]
		public void place_cursor (Gtk.TextIter where);
		[NoArrayLength ()]
		[CCode (cname = "gtk_text_buffer_register_deserialize_format")]
		public Gdk.Atom register_deserialize_format (string mime_type, Gtk.TextBufferDeserializeFunc function, pointer user_data, GLib.DestroyNotify user_data_destroy);
		[NoArrayLength ()]
		[CCode (cname = "gtk_text_buffer_register_deserialize_tagset")]
		public Gdk.Atom register_deserialize_tagset (string tagset_name);
		[NoArrayLength ()]
		[CCode (cname = "gtk_text_buffer_register_serialize_format")]
		public Gdk.Atom register_serialize_format (string mime_type, Gtk.TextBufferSerializeFunc function, pointer user_data, GLib.DestroyNotify user_data_destroy);
		[NoArrayLength ()]
		[CCode (cname = "gtk_text_buffer_register_serialize_tagset")]
		public Gdk.Atom register_serialize_tagset (string tagset_name);
		[NoArrayLength ()]
		[CCode (cname = "gtk_text_buffer_remove_all_tags")]
		public void remove_all_tags (Gtk.TextIter start, Gtk.TextIter end);
		[NoArrayLength ()]
		[CCode (cname = "gtk_text_buffer_remove_selection_clipboard")]
		public void remove_selection_clipboard (Gtk.Clipboard clipboard);
		[NoArrayLength ()]
		[CCode (cname = "gtk_text_buffer_remove_tag_by_name")]
		public void remove_tag_by_name (string name, Gtk.TextIter start, Gtk.TextIter end);
		[NoArrayLength ()]
		[CCode (cname = "gtk_text_buffer_select_range")]
		public void select_range (Gtk.TextIter ins, Gtk.TextIter bound);
		[NoArrayLength ()]
		[CCode (cname = "gtk_text_buffer_serialize")]
		public uchar serialize (Gtk.TextBuffer content_buffer, Gdk.Atom format, Gtk.TextIter start, Gtk.TextIter end, ulong length);
		[NoArrayLength ()]
		[CCode (cname = "gtk_text_buffer_set_modified")]
		public void set_modified (bool setting);
		[NoArrayLength ()]
		[CCode (cname = "gtk_text_buffer_set_text")]
		public void set_text (string text, int len);
		[NoArrayLength ()]
		[CCode (cname = "gtk_text_buffer_unregister_deserialize_format")]
		public void unregister_deserialize_format (Gdk.Atom format);
		[NoArrayLength ()]
		[CCode (cname = "gtk_text_buffer_unregister_serialize_format")]
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
	[CCode (cheader_filename = "gtk/gtk.h")]
	public class TextChildAnchor : GLib.Object {
		[NoArrayLength ()]
		[CCode (cname = "gtk_text_child_anchor_get_deleted")]
		public bool get_deleted ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_text_child_anchor_get_type")]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_text_child_anchor_get_widgets")]
		public GLib.List get_widgets ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_text_child_anchor_new")]
		public construct ();
	}
	[CCode (cheader_filename = "gtk/gtk.h")]
	public class TextMark : GLib.Object {
		[NoArrayLength ()]
		[CCode (cname = "gtk_text_mark_get_buffer")]
		public Gtk.TextBuffer get_buffer ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_text_mark_get_deleted")]
		public bool get_deleted ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_text_mark_get_left_gravity")]
		public bool get_left_gravity ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_text_mark_get_name")]
		public string get_name ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_text_mark_get_type")]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_text_mark_get_visible")]
		public bool get_visible ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_text_mark_set_visible")]
		public void set_visible (bool setting);
	}
	[CCode (cheader_filename = "gtk/gtk.h")]
	public class TextTag : GLib.Object {
		[NoArrayLength ()]
		[CCode (cname = "gtk_text_tag_get_priority")]
		public int get_priority ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_text_tag_get_type")]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_text_tag_new")]
		public construct (string name);
		[NoArrayLength ()]
		[CCode (cname = "gtk_text_tag_set_priority")]
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
	[CCode (cheader_filename = "gtk/gtk.h")]
	public class TextTagTable : GLib.Object {
		[NoArrayLength ()]
		[CCode (cname = "gtk_text_tag_table_add")]
		public void add (Gtk.TextTag tag);
		[NoArrayLength ()]
		[CCode (cname = "gtk_text_tag_table_foreach")]
		public void @foreach (Gtk.TextTagTableForeach func, pointer data);
		[NoArrayLength ()]
		[CCode (cname = "gtk_text_tag_table_get_size")]
		public int get_size ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_text_tag_table_get_type")]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_text_tag_table_lookup")]
		public Gtk.TextTag lookup (string name);
		[NoArrayLength ()]
		[CCode (cname = "gtk_text_tag_table_new")]
		public construct ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_text_tag_table_remove")]
		public void remove (Gtk.TextTag tag);
		public signal void tag_changed (Gtk.TextTag tag, bool size_changed);
		public signal void tag_added (Gtk.TextTag tag);
		public signal void tag_removed (Gtk.TextTag tag);
	}
	[CCode (cheader_filename = "gtk/gtk.h")]
	public class TextView : Gtk.Container {
		[NoArrayLength ()]
		[CCode (cname = "gtk_text_view_add_child_at_anchor")]
		public void add_child_at_anchor (Gtk.Widget child, Gtk.TextChildAnchor anchor);
		[NoArrayLength ()]
		[CCode (cname = "gtk_text_view_add_child_in_window")]
		public void add_child_in_window (Gtk.Widget child, Gtk.TextWindowType which_window, int xpos, int ypos);
		[NoArrayLength ()]
		[CCode (cname = "gtk_text_view_backward_display_line")]
		public bool backward_display_line (Gtk.TextIter iter);
		[NoArrayLength ()]
		[CCode (cname = "gtk_text_view_backward_display_line_start")]
		public bool backward_display_line_start (Gtk.TextIter iter);
		[NoArrayLength ()]
		[CCode (cname = "gtk_text_view_buffer_to_window_coords")]
		public void buffer_to_window_coords (Gtk.TextWindowType win, int buffer_x, int buffer_y, int window_x, int window_y);
		[NoArrayLength ()]
		[CCode (cname = "gtk_text_view_forward_display_line")]
		public bool forward_display_line (Gtk.TextIter iter);
		[NoArrayLength ()]
		[CCode (cname = "gtk_text_view_forward_display_line_end")]
		public bool forward_display_line_end (Gtk.TextIter iter);
		[NoArrayLength ()]
		[CCode (cname = "gtk_text_view_get_accepts_tab")]
		public bool get_accepts_tab ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_text_view_get_border_window_size")]
		public int get_border_window_size (Gtk.TextWindowType type);
		[NoArrayLength ()]
		[CCode (cname = "gtk_text_view_get_buffer")]
		public Gtk.TextBuffer get_buffer ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_text_view_get_cursor_visible")]
		public bool get_cursor_visible ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_text_view_get_default_attributes")]
		public Gtk.TextAttributes get_default_attributes ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_text_view_get_editable")]
		public bool get_editable ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_text_view_get_indent")]
		public int get_indent ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_text_view_get_iter_at_location")]
		public void get_iter_at_location (Gtk.TextIter iter, int x, int y);
		[NoArrayLength ()]
		[CCode (cname = "gtk_text_view_get_iter_at_position")]
		public void get_iter_at_position (Gtk.TextIter iter, int trailing, int x, int y);
		[NoArrayLength ()]
		[CCode (cname = "gtk_text_view_get_iter_location")]
		public void get_iter_location (Gtk.TextIter iter, Gdk.Rectangle location);
		[NoArrayLength ()]
		[CCode (cname = "gtk_text_view_get_justification")]
		public Gtk.Justification get_justification ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_text_view_get_left_margin")]
		public int get_left_margin ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_text_view_get_line_at_y")]
		public void get_line_at_y (Gtk.TextIter target_iter, int y, int line_top);
		[NoArrayLength ()]
		[CCode (cname = "gtk_text_view_get_line_yrange")]
		public void get_line_yrange (Gtk.TextIter iter, int y, int height);
		[NoArrayLength ()]
		[CCode (cname = "gtk_text_view_get_overwrite")]
		public bool get_overwrite ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_text_view_get_pixels_above_lines")]
		public int get_pixels_above_lines ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_text_view_get_pixels_below_lines")]
		public int get_pixels_below_lines ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_text_view_get_pixels_inside_wrap")]
		public int get_pixels_inside_wrap ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_text_view_get_right_margin")]
		public int get_right_margin ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_text_view_get_tabs")]
		public Pango.TabArray get_tabs ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_text_view_get_type")]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_text_view_get_visible_rect")]
		public void get_visible_rect (Gdk.Rectangle visible_rect);
		[NoArrayLength ()]
		[CCode (cname = "gtk_text_view_get_window")]
		public Gdk.Window get_window (Gtk.TextWindowType win);
		[NoArrayLength ()]
		[CCode (cname = "gtk_text_view_get_window_type")]
		public Gtk.TextWindowType get_window_type (Gdk.Window window);
		[NoArrayLength ()]
		[CCode (cname = "gtk_text_view_get_wrap_mode")]
		public Gtk.WrapMode get_wrap_mode ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_text_view_move_child")]
		public void move_child (Gtk.Widget child, int xpos, int ypos);
		[NoArrayLength ()]
		[CCode (cname = "gtk_text_view_move_mark_onscreen")]
		public bool move_mark_onscreen (Gtk.TextMark mark);
		[NoArrayLength ()]
		[CCode (cname = "gtk_text_view_move_visually")]
		public bool move_visually (Gtk.TextIter iter, int count);
		[NoArrayLength ()]
		[CCode (cname = "gtk_text_view_new")]
		public construct ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_text_view_new_with_buffer")]
		public construct with_buffer (Gtk.TextBuffer buffer);
		[NoArrayLength ()]
		[CCode (cname = "gtk_text_view_place_cursor_onscreen")]
		public bool place_cursor_onscreen ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_text_view_scroll_mark_onscreen")]
		public void scroll_mark_onscreen (Gtk.TextMark mark);
		[NoArrayLength ()]
		[CCode (cname = "gtk_text_view_scroll_to_iter")]
		public bool scroll_to_iter (Gtk.TextIter iter, double within_margin, bool use_align, double xalign, double yalign);
		[NoArrayLength ()]
		[CCode (cname = "gtk_text_view_scroll_to_mark")]
		public void scroll_to_mark (Gtk.TextMark mark, double within_margin, bool use_align, double xalign, double yalign);
		[NoArrayLength ()]
		[CCode (cname = "gtk_text_view_set_accepts_tab")]
		public void set_accepts_tab (bool accepts_tab);
		[NoArrayLength ()]
		[CCode (cname = "gtk_text_view_set_border_window_size")]
		public void set_border_window_size (Gtk.TextWindowType type, int size);
		[NoArrayLength ()]
		[CCode (cname = "gtk_text_view_set_buffer")]
		public void set_buffer (Gtk.TextBuffer buffer);
		[NoArrayLength ()]
		[CCode (cname = "gtk_text_view_set_cursor_visible")]
		public void set_cursor_visible (bool setting);
		[NoArrayLength ()]
		[CCode (cname = "gtk_text_view_set_editable")]
		public void set_editable (bool setting);
		[NoArrayLength ()]
		[CCode (cname = "gtk_text_view_set_indent")]
		public void set_indent (int indent);
		[NoArrayLength ()]
		[CCode (cname = "gtk_text_view_set_justification")]
		public void set_justification (Gtk.Justification justification);
		[NoArrayLength ()]
		[CCode (cname = "gtk_text_view_set_left_margin")]
		public void set_left_margin (int left_margin);
		[NoArrayLength ()]
		[CCode (cname = "gtk_text_view_set_overwrite")]
		public void set_overwrite (bool overwrite);
		[NoArrayLength ()]
		[CCode (cname = "gtk_text_view_set_pixels_above_lines")]
		public void set_pixels_above_lines (int pixels_above_lines);
		[NoArrayLength ()]
		[CCode (cname = "gtk_text_view_set_pixels_below_lines")]
		public void set_pixels_below_lines (int pixels_below_lines);
		[NoArrayLength ()]
		[CCode (cname = "gtk_text_view_set_pixels_inside_wrap")]
		public void set_pixels_inside_wrap (int pixels_inside_wrap);
		[NoArrayLength ()]
		[CCode (cname = "gtk_text_view_set_right_margin")]
		public void set_right_margin (int right_margin);
		[NoArrayLength ()]
		[CCode (cname = "gtk_text_view_set_tabs")]
		public void set_tabs (Pango.TabArray tabs);
		[NoArrayLength ()]
		[CCode (cname = "gtk_text_view_set_wrap_mode")]
		public void set_wrap_mode (Gtk.WrapMode wrap_mode);
		[NoArrayLength ()]
		[CCode (cname = "gtk_text_view_starts_display_line")]
		public bool starts_display_line (Gtk.TextIter iter);
		[NoArrayLength ()]
		[CCode (cname = "gtk_text_view_window_to_buffer_coords")]
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
	[CCode (cheader_filename = "gtk/gtk.h")]
	public class ToggleAction : Gtk.Action {
		[NoArrayLength ()]
		[CCode (cname = "gtk_toggle_action_get_active")]
		public bool get_active ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_toggle_action_get_draw_as_radio")]
		public bool get_draw_as_radio ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_toggle_action_get_type")]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_toggle_action_new")]
		public construct (string name, string label, string tooltip, string stock_id);
		[NoArrayLength ()]
		[CCode (cname = "gtk_toggle_action_set_active")]
		public void set_active (bool is_active);
		[NoArrayLength ()]
		[CCode (cname = "gtk_toggle_action_set_draw_as_radio")]
		public void set_draw_as_radio (bool draw_as_radio);
		public weak bool draw_as_radio { get; set; }
		public weak bool active { get; set; }
		[HasEmitter ()]
		public signal void toggled ();
	}
	[CCode (cheader_filename = "gtk/gtk.h")]
	public class ToggleButton : Gtk.Button {
		[NoArrayLength ()]
		[CCode (cname = "gtk_toggle_button_get_active")]
		public bool get_active ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_toggle_button_get_inconsistent")]
		public bool get_inconsistent ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_toggle_button_get_mode")]
		public bool get_mode ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_toggle_button_get_type")]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_toggle_button_new")]
		public construct ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_toggle_button_new_with_label")]
		public construct with_label (string label);
		[NoArrayLength ()]
		[CCode (cname = "gtk_toggle_button_new_with_mnemonic")]
		public construct with_mnemonic (string label);
		[NoArrayLength ()]
		[CCode (cname = "gtk_toggle_button_set_active")]
		public void set_active (bool is_active);
		[NoArrayLength ()]
		[CCode (cname = "gtk_toggle_button_set_inconsistent")]
		public void set_inconsistent (bool setting);
		[NoArrayLength ()]
		[CCode (cname = "gtk_toggle_button_set_mode")]
		public void set_mode (bool draw_indicator);
		public weak bool active { get; set; }
		public weak bool inconsistent { get; set; }
		[NoAccessorMethod ()]
		public weak bool draw_indicator { get; set; }
		[HasEmitter ()]
		public signal void toggled ();
	}
	[CCode (cheader_filename = "gtk/gtk.h")]
	public class ToggleToolButton : Gtk.ToolButton {
		[NoArrayLength ()]
		[CCode (cname = "gtk_toggle_tool_button_get_active")]
		public bool get_active ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_toggle_tool_button_get_type")]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_toggle_tool_button_new")]
		public construct ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_toggle_tool_button_new_from_stock")]
		public construct from_stock (string stock_id);
		[NoArrayLength ()]
		[CCode (cname = "gtk_toggle_tool_button_set_active")]
		public void set_active (bool is_active);
		public weak bool active { get; set; }
		public signal void toggled ();
	}
	[CCode (cheader_filename = "gtk/gtk.h")]
	public class Toolbar : Gtk.Container {
		public int num_children;
		public weak GLib.List children;
		public Gtk.ToolbarStyle style;
		[NoArrayLength ()]
		[CCode (cname = "gtk_toolbar_get_drop_index")]
		public int get_drop_index (int x, int y);
		[NoArrayLength ()]
		[CCode (cname = "gtk_toolbar_get_icon_size")]
		public Gtk.IconSize get_icon_size ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_toolbar_get_item_index")]
		public int get_item_index (Gtk.ToolItem item);
		[NoArrayLength ()]
		[CCode (cname = "gtk_toolbar_get_n_items")]
		public int get_n_items ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_toolbar_get_nth_item")]
		public Gtk.ToolItem get_nth_item (int n);
		[NoArrayLength ()]
		[CCode (cname = "gtk_toolbar_get_orientation")]
		public Gtk.Orientation get_orientation ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_toolbar_get_relief_style")]
		public Gtk.ReliefStyle get_relief_style ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_toolbar_get_show_arrow")]
		public bool get_show_arrow ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_toolbar_get_style")]
		public Gtk.ToolbarStyle get_style ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_toolbar_get_tooltips")]
		public bool get_tooltips ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_toolbar_get_type")]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_toolbar_insert")]
		public void insert (Gtk.ToolItem item, int pos);
		[NoArrayLength ()]
		[CCode (cname = "gtk_toolbar_new")]
		public construct ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_toolbar_set_drop_highlight_item")]
		public void set_drop_highlight_item (Gtk.ToolItem tool_item, int index_);
		[NoArrayLength ()]
		[CCode (cname = "gtk_toolbar_set_orientation")]
		public void set_orientation (Gtk.Orientation orientation);
		[NoArrayLength ()]
		[CCode (cname = "gtk_toolbar_set_show_arrow")]
		public void set_show_arrow (bool show_arrow);
		[NoArrayLength ()]
		[CCode (cname = "gtk_toolbar_set_style")]
		public void set_style (Gtk.ToolbarStyle style);
		[NoArrayLength ()]
		[CCode (cname = "gtk_toolbar_set_tooltips")]
		public void set_tooltips (bool enable);
		[NoArrayLength ()]
		[CCode (cname = "gtk_toolbar_unset_style")]
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
	[CCode (cheader_filename = "gtk/gtk.h")]
	public class Tooltips : Gtk.Object {
		[NoArrayLength ()]
		[CCode (cname = "gtk_tooltips_disable")]
		public void disable ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_tooltips_enable")]
		public void enable ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_tooltips_force_window")]
		public void force_window ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_tooltips_get_info_from_tip_window")]
		public static bool get_info_from_tip_window (Gtk.Window tip_window, Gtk.Tooltips tooltips, Gtk.Widget current_widget);
		[NoArrayLength ()]
		[CCode (cname = "gtk_tooltips_get_type")]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_tooltips_new")]
		public construct ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_tooltips_set_tip")]
		public void set_tip (Gtk.Widget widget, string tip_text, string tip_private);
	}
	[CCode (cheader_filename = "gtk/gtk.h")]
	public class ToolButton : Gtk.ToolItem {
		[NoArrayLength ()]
		[CCode (cname = "gtk_tool_button_get_icon_name")]
		public string get_icon_name ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_tool_button_get_icon_widget")]
		public Gtk.Widget get_icon_widget ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_tool_button_get_label")]
		public string get_label ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_tool_button_get_label_widget")]
		public Gtk.Widget get_label_widget ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_tool_button_get_stock_id")]
		public string get_stock_id ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_tool_button_get_type")]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_tool_button_get_use_underline")]
		public bool get_use_underline ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_tool_button_new")]
		public construct (Gtk.Widget icon_widget, string label);
		[NoArrayLength ()]
		[CCode (cname = "gtk_tool_button_new_from_stock")]
		public construct from_stock (string stock_id);
		[NoArrayLength ()]
		[CCode (cname = "gtk_tool_button_set_icon_name")]
		public void set_icon_name (string icon_name);
		[NoArrayLength ()]
		[CCode (cname = "gtk_tool_button_set_icon_widget")]
		public void set_icon_widget (Gtk.Widget icon_widget);
		[NoArrayLength ()]
		[CCode (cname = "gtk_tool_button_set_label")]
		public void set_label (string label);
		[NoArrayLength ()]
		[CCode (cname = "gtk_tool_button_set_label_widget")]
		public void set_label_widget (Gtk.Widget label_widget);
		[NoArrayLength ()]
		[CCode (cname = "gtk_tool_button_set_stock_id")]
		public void set_stock_id (string stock_id);
		[NoArrayLength ()]
		[CCode (cname = "gtk_tool_button_set_use_underline")]
		public void set_use_underline (bool use_underline);
		public weak string label { get; set; }
		public weak bool use_underline { get; set; }
		public weak Gtk.Widget label_widget { get; set; }
		public weak string stock_id { get; set; }
		public weak string icon_name { get; set; }
		public weak Gtk.Widget icon_widget { get; set; }
		public signal void clicked ();
	}
	[CCode (cheader_filename = "gtk/gtk.h")]
	public class ToolItem : Gtk.Bin {
		[NoArrayLength ()]
		[CCode (cname = "gtk_tool_item_get_expand")]
		public bool get_expand ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_tool_item_get_homogeneous")]
		public bool get_homogeneous ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_tool_item_get_icon_size")]
		public Gtk.IconSize get_icon_size ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_tool_item_get_is_important")]
		public bool get_is_important ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_tool_item_get_orientation")]
		public Gtk.Orientation get_orientation ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_tool_item_get_proxy_menu_item")]
		public Gtk.Widget get_proxy_menu_item (string menu_item_id);
		[NoArrayLength ()]
		[CCode (cname = "gtk_tool_item_get_relief_style")]
		public Gtk.ReliefStyle get_relief_style ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_tool_item_get_toolbar_style")]
		public Gtk.ToolbarStyle get_toolbar_style ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_tool_item_get_type")]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_tool_item_get_use_drag_window")]
		public bool get_use_drag_window ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_tool_item_get_visible_horizontal")]
		public bool get_visible_horizontal ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_tool_item_get_visible_vertical")]
		public bool get_visible_vertical ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_tool_item_new")]
		public construct ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_tool_item_rebuild_menu")]
		public void rebuild_menu ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_tool_item_retrieve_proxy_menu_item")]
		public Gtk.Widget retrieve_proxy_menu_item ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_tool_item_set_expand")]
		public void set_expand (bool expand);
		[NoArrayLength ()]
		[CCode (cname = "gtk_tool_item_set_homogeneous")]
		public void set_homogeneous (bool homogeneous);
		[NoArrayLength ()]
		[CCode (cname = "gtk_tool_item_set_is_important")]
		public void set_is_important (bool is_important);
		[NoArrayLength ()]
		[CCode (cname = "gtk_tool_item_set_proxy_menu_item")]
		public void set_proxy_menu_item (string menu_item_id, Gtk.Widget menu_item);
		[NoArrayLength ()]
		[CCode (cname = "gtk_tool_item_set_use_drag_window")]
		public void set_use_drag_window (bool use_drag_window);
		[NoArrayLength ()]
		[CCode (cname = "gtk_tool_item_set_visible_horizontal")]
		public void set_visible_horizontal (bool visible_horizontal);
		[NoArrayLength ()]
		[CCode (cname = "gtk_tool_item_set_visible_vertical")]
		public void set_visible_vertical (bool visible_vertical);
		public weak bool visible_horizontal { get; set; }
		public weak bool visible_vertical { get; set; }
		public weak bool is_important { get; set; }
		public signal bool create_menu_proxy ();
		public signal void toolbar_reconfigured ();
		[HasEmitter ()]
		public signal bool set_tooltip (Gtk.Tooltips tooltips, string tip_text, string tip_private);
	}
	[CCode (cheader_filename = "gtk/gtk.h")]
	public class TrayIcon : Gtk.Plug {
		[NoArrayLength ()]
		[CCode (cname = "gtk_tray_icon_get_type")]
		public static GLib.Type get_type ();
		[NoAccessorMethod ()]
		public weak Gtk.Orientation orientation { get; }
	}
	[CCode (cheader_filename = "gtk/gtk.h")]
	public class TreeModelFilter : GLib.Object, Gtk.TreeModel, Gtk.TreeDragSource {
		[NoArrayLength ()]
		[CCode (cname = "gtk_tree_model_filter_clear_cache")]
		public void clear_cache ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_tree_model_filter_convert_child_iter_to_iter")]
		public bool convert_child_iter_to_iter (Gtk.TreeIter filter_iter, Gtk.TreeIter child_iter);
		[NoArrayLength ()]
		[CCode (cname = "gtk_tree_model_filter_convert_child_path_to_path")]
		public Gtk.TreePath convert_child_path_to_path (Gtk.TreePath child_path);
		[NoArrayLength ()]
		[CCode (cname = "gtk_tree_model_filter_convert_iter_to_child_iter")]
		public void convert_iter_to_child_iter (Gtk.TreeIter child_iter, Gtk.TreeIter filter_iter);
		[NoArrayLength ()]
		[CCode (cname = "gtk_tree_model_filter_convert_path_to_child_path")]
		public Gtk.TreePath convert_path_to_child_path (Gtk.TreePath filter_path);
		[NoArrayLength ()]
		[CCode (cname = "gtk_tree_model_filter_get_model")]
		public Gtk.TreeModel get_model ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_tree_model_filter_get_type")]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_tree_model_filter_new")]
		public construct (Gtk.TreeModel child_model, Gtk.TreePath root);
		[NoArrayLength ()]
		[CCode (cname = "gtk_tree_model_filter_refilter")]
		public void refilter ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_tree_model_filter_set_modify_func")]
		public void set_modify_func (int n_columns, GLib.Type types, Gtk.TreeModelFilterModifyFunc func, pointer data, Gtk.DestroyNotify destroy);
		[NoArrayLength ()]
		[CCode (cname = "gtk_tree_model_filter_set_visible_column")]
		public void set_visible_column (int column);
		[NoArrayLength ()]
		[CCode (cname = "gtk_tree_model_filter_set_visible_func")]
		public void set_visible_func (Gtk.TreeModelFilterVisibleFunc func, pointer data, Gtk.DestroyNotify destroy);
		[NoAccessorMethod ()]
		public weak Gtk.TreeModel child_model { get; construct; }
		[NoAccessorMethod ()]
		public weak Gtk.TreePath virtual_root { get; construct; }
	}
	[CCode (cheader_filename = "gtk/gtk.h")]
	public class TreeModelSort : GLib.Object, Gtk.TreeModel, Gtk.TreeSortable, Gtk.TreeDragSource {
		[NoArrayLength ()]
		[CCode (cname = "gtk_tree_model_sort_clear_cache")]
		public void clear_cache ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_tree_model_sort_convert_child_iter_to_iter")]
		public void convert_child_iter_to_iter (Gtk.TreeIter sort_iter, Gtk.TreeIter child_iter);
		[NoArrayLength ()]
		[CCode (cname = "gtk_tree_model_sort_convert_child_path_to_path")]
		public Gtk.TreePath convert_child_path_to_path (Gtk.TreePath child_path);
		[NoArrayLength ()]
		[CCode (cname = "gtk_tree_model_sort_convert_iter_to_child_iter")]
		public void convert_iter_to_child_iter (Gtk.TreeIter child_iter, Gtk.TreeIter sorted_iter);
		[NoArrayLength ()]
		[CCode (cname = "gtk_tree_model_sort_convert_path_to_child_path")]
		public Gtk.TreePath convert_path_to_child_path (Gtk.TreePath sorted_path);
		[NoArrayLength ()]
		[CCode (cname = "gtk_tree_model_sort_get_model")]
		public Gtk.TreeModel get_model ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_tree_model_sort_get_type")]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_tree_model_sort_iter_is_valid")]
		public bool iter_is_valid (Gtk.TreeIter iter);
		[NoArrayLength ()]
		[CCode (cname = "gtk_tree_model_sort_new_with_model")]
		public construct with_model (Gtk.TreeModel child_model);
		[NoArrayLength ()]
		[CCode (cname = "gtk_tree_model_sort_reset_default_sort_func")]
		public void reset_default_sort_func ();
		[NoAccessorMethod ()]
		public weak Gtk.TreeModel model { get; construct; }
	}
	[CCode (cheader_filename = "gtk/gtk.h")]
	public class TreeSelection : GLib.Object {
		[NoArrayLength ()]
		[CCode (cname = "gtk_tree_selection_count_selected_rows")]
		public int count_selected_rows ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_tree_selection_get_mode")]
		public Gtk.SelectionMode get_mode ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_tree_selection_get_selected")]
		public bool get_selected (Gtk.TreeModel model, Gtk.TreeIter iter);
		[NoArrayLength ()]
		[CCode (cname = "gtk_tree_selection_get_selected_rows")]
		public GLib.List get_selected_rows (Gtk.TreeModel model);
		[NoArrayLength ()]
		[CCode (cname = "gtk_tree_selection_get_tree_view")]
		public Gtk.TreeView get_tree_view ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_tree_selection_get_type")]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_tree_selection_get_user_data")]
		public pointer get_user_data ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_tree_selection_iter_is_selected")]
		public bool iter_is_selected (Gtk.TreeIter iter);
		[NoArrayLength ()]
		[CCode (cname = "gtk_tree_selection_path_is_selected")]
		public bool path_is_selected (Gtk.TreePath path);
		[NoArrayLength ()]
		[CCode (cname = "gtk_tree_selection_select_all")]
		public void select_all ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_tree_selection_select_iter")]
		public void select_iter (Gtk.TreeIter iter);
		[NoArrayLength ()]
		[CCode (cname = "gtk_tree_selection_select_path")]
		public void select_path (Gtk.TreePath path);
		[NoArrayLength ()]
		[CCode (cname = "gtk_tree_selection_select_range")]
		public void select_range (Gtk.TreePath start_path, Gtk.TreePath end_path);
		[NoArrayLength ()]
		[CCode (cname = "gtk_tree_selection_selected_foreach")]
		public void selected_foreach (Gtk.TreeSelectionForeachFunc func, pointer data);
		[NoArrayLength ()]
		[CCode (cname = "gtk_tree_selection_set_mode")]
		public void set_mode (Gtk.SelectionMode type);
		[NoArrayLength ()]
		[CCode (cname = "gtk_tree_selection_set_select_function")]
		public void set_select_function (Gtk.TreeSelectionFunc func, pointer data, Gtk.DestroyNotify destroy);
		[NoArrayLength ()]
		[CCode (cname = "gtk_tree_selection_unselect_all")]
		public void unselect_all ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_tree_selection_unselect_iter")]
		public void unselect_iter (Gtk.TreeIter iter);
		[NoArrayLength ()]
		[CCode (cname = "gtk_tree_selection_unselect_path")]
		public void unselect_path (Gtk.TreePath path);
		[NoArrayLength ()]
		[CCode (cname = "gtk_tree_selection_unselect_range")]
		public void unselect_range (Gtk.TreePath start_path, Gtk.TreePath end_path);
		public signal void changed ();
	}
	[CCode (cheader_filename = "gtk/gtk.h")]
	public class TreeStore : GLib.Object, Gtk.TreeModel, Gtk.TreeDragSource, Gtk.TreeDragDest, Gtk.TreeSortable {
		[NoArrayLength ()]
		[CCode (cname = "gtk_tree_store_append")]
		public void append (Gtk.TreeIter iter, Gtk.TreeIter parent);
		[NoArrayLength ()]
		[CCode (cname = "gtk_tree_store_clear")]
		public void clear ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_tree_store_get_type")]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_tree_store_insert")]
		public void insert (Gtk.TreeIter iter, Gtk.TreeIter parent, int position);
		[NoArrayLength ()]
		[CCode (cname = "gtk_tree_store_insert_after")]
		public void insert_after (Gtk.TreeIter iter, Gtk.TreeIter parent, Gtk.TreeIter sibling);
		[NoArrayLength ()]
		[CCode (cname = "gtk_tree_store_insert_before")]
		public void insert_before (Gtk.TreeIter iter, Gtk.TreeIter parent, Gtk.TreeIter sibling);
		[NoArrayLength ()]
		[CCode (cname = "gtk_tree_store_insert_with_values")]
		public void insert_with_values (Gtk.TreeIter iter, Gtk.TreeIter parent, int position);
		[NoArrayLength ()]
		[CCode (cname = "gtk_tree_store_insert_with_valuesv")]
		public void insert_with_valuesv (Gtk.TreeIter iter, Gtk.TreeIter parent, int position, int columns, GLib.Value values, int n_values);
		[NoArrayLength ()]
		[CCode (cname = "gtk_tree_store_is_ancestor")]
		public bool is_ancestor (Gtk.TreeIter iter, Gtk.TreeIter descendant);
		[NoArrayLength ()]
		[CCode (cname = "gtk_tree_store_iter_depth")]
		public int iter_depth (Gtk.TreeIter iter);
		[NoArrayLength ()]
		[CCode (cname = "gtk_tree_store_iter_is_valid")]
		public bool iter_is_valid (Gtk.TreeIter iter);
		[NoArrayLength ()]
		[CCode (cname = "gtk_tree_store_move_after")]
		public void move_after (Gtk.TreeIter iter, Gtk.TreeIter position);
		[NoArrayLength ()]
		[CCode (cname = "gtk_tree_store_move_before")]
		public void move_before (Gtk.TreeIter iter, Gtk.TreeIter position);
		[NoArrayLength ()]
		[CCode (cname = "gtk_tree_store_new")]
		public construct (int n_columns);
		[NoArrayLength ()]
		[CCode (cname = "gtk_tree_store_newv")]
		public construct newv (int n_columns, GLib.Type types);
		[NoArrayLength ()]
		[CCode (cname = "gtk_tree_store_prepend")]
		public void prepend (Gtk.TreeIter iter, Gtk.TreeIter parent);
		[NoArrayLength ()]
		[CCode (cname = "gtk_tree_store_remove")]
		public bool remove (Gtk.TreeIter iter);
		[NoArrayLength ()]
		[CCode (cname = "gtk_tree_store_reorder")]
		public void reorder (Gtk.TreeIter parent, int new_order);
		[NoArrayLength ()]
		[CCode (cname = "gtk_tree_store_set")]
		public void @set (Gtk.TreeIter iter);
		[NoArrayLength ()]
		[CCode (cname = "gtk_tree_store_set_column_types")]
		public void set_column_types (int n_columns, GLib.Type types);
		[NoArrayLength ()]
		[CCode (cname = "gtk_tree_store_set_valist")]
		public void set_valist (Gtk.TreeIter iter, pointer var_args);
		[NoArrayLength ()]
		[CCode (cname = "gtk_tree_store_set_value")]
		public void set_value (Gtk.TreeIter iter, int column, GLib.Value value);
		[NoArrayLength ()]
		[CCode (cname = "gtk_tree_store_swap")]
		public void swap (Gtk.TreeIter a, Gtk.TreeIter b);
	}
	[CCode (cheader_filename = "gtk/gtk.h")]
	public class TreeView : Gtk.Container {
		[NoArrayLength ()]
		[CCode (cname = "gtk_tree_view_append_column")]
		public int append_column (Gtk.TreeViewColumn column);
		[NoArrayLength ()]
		[CCode (cname = "gtk_tree_view_collapse_all")]
		public void collapse_all ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_tree_view_collapse_row")]
		public bool collapse_row (Gtk.TreePath path);
		[NoArrayLength ()]
		[CCode (cname = "gtk_tree_view_columns_autosize")]
		public void columns_autosize ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_tree_view_create_row_drag_icon")]
		public Gdk.Pixmap create_row_drag_icon (Gtk.TreePath path);
		[NoArrayLength ()]
		[CCode (cname = "gtk_tree_view_enable_model_drag_dest")]
		public void enable_model_drag_dest (Gtk.TargetEntry targets, int n_targets, Gdk.DragAction actions);
		[NoArrayLength ()]
		[CCode (cname = "gtk_tree_view_enable_model_drag_source")]
		public void enable_model_drag_source (Gdk.ModifierType start_button_mask, Gtk.TargetEntry targets, int n_targets, Gdk.DragAction actions);
		[NoArrayLength ()]
		[CCode (cname = "gtk_tree_view_expand_all")]
		public void expand_all ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_tree_view_expand_row")]
		public bool expand_row (Gtk.TreePath path, bool open_all);
		[NoArrayLength ()]
		[CCode (cname = "gtk_tree_view_expand_to_path")]
		public void expand_to_path (Gtk.TreePath path);
		[NoArrayLength ()]
		[CCode (cname = "gtk_tree_view_get_background_area")]
		public void get_background_area (Gtk.TreePath path, Gtk.TreeViewColumn column, Gdk.Rectangle rect);
		[NoArrayLength ()]
		[CCode (cname = "gtk_tree_view_get_bin_window")]
		public Gdk.Window get_bin_window ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_tree_view_get_cell_area")]
		public void get_cell_area (Gtk.TreePath path, Gtk.TreeViewColumn column, Gdk.Rectangle rect);
		[NoArrayLength ()]
		[CCode (cname = "gtk_tree_view_get_column")]
		public Gtk.TreeViewColumn get_column (int n);
		[NoArrayLength ()]
		[CCode (cname = "gtk_tree_view_get_columns")]
		public GLib.List get_columns ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_tree_view_get_cursor")]
		public void get_cursor (Gtk.TreePath path, Gtk.TreeViewColumn focus_column);
		[NoArrayLength ()]
		[CCode (cname = "gtk_tree_view_get_dest_row_at_pos")]
		public bool get_dest_row_at_pos (int drag_x, int drag_y, Gtk.TreePath path, Gtk.TreeViewDropPosition pos);
		[NoArrayLength ()]
		[CCode (cname = "gtk_tree_view_get_drag_dest_row")]
		public void get_drag_dest_row (Gtk.TreePath path, Gtk.TreeViewDropPosition pos);
		[NoArrayLength ()]
		[CCode (cname = "gtk_tree_view_get_enable_search")]
		public bool get_enable_search ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_tree_view_get_enable_tree_lines")]
		public bool get_enable_tree_lines ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_tree_view_get_expander_column")]
		public Gtk.TreeViewColumn get_expander_column ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_tree_view_get_fixed_height_mode")]
		public bool get_fixed_height_mode ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_tree_view_get_grid_lines")]
		public Gtk.TreeViewGridLines get_grid_lines ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_tree_view_get_hadjustment")]
		public Gtk.Adjustment get_hadjustment ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_tree_view_get_headers_clickable")]
		public bool get_headers_clickable ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_tree_view_get_headers_visible")]
		public bool get_headers_visible ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_tree_view_get_hover_expand")]
		public bool get_hover_expand ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_tree_view_get_hover_selection")]
		public bool get_hover_selection ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_tree_view_get_model")]
		public Gtk.TreeModel get_model ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_tree_view_get_path_at_pos")]
		public bool get_path_at_pos (int x, int y, Gtk.TreePath path, Gtk.TreeViewColumn column, int cell_x, int cell_y);
		[NoArrayLength ()]
		[CCode (cname = "gtk_tree_view_get_reorderable")]
		public bool get_reorderable ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_tree_view_get_row_separator_func")]
		public Gtk.TreeViewRowSeparatorFunc get_row_separator_func ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_tree_view_get_rubber_banding")]
		public bool get_rubber_banding ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_tree_view_get_rules_hint")]
		public bool get_rules_hint ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_tree_view_get_search_column")]
		public int get_search_column ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_tree_view_get_search_entry")]
		public Gtk.Entry get_search_entry ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_tree_view_get_search_equal_func")]
		public Gtk.TreeViewSearchEqualFunc get_search_equal_func ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_tree_view_get_search_position_func")]
		public Gtk.TreeViewSearchPositionFunc get_search_position_func ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_tree_view_get_selection")]
		public Gtk.TreeSelection get_selection ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_tree_view_get_type")]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_tree_view_get_vadjustment")]
		public Gtk.Adjustment get_vadjustment ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_tree_view_get_visible_range")]
		public bool get_visible_range (Gtk.TreePath start_path, Gtk.TreePath end_path);
		[NoArrayLength ()]
		[CCode (cname = "gtk_tree_view_get_visible_rect")]
		public void get_visible_rect (Gdk.Rectangle visible_rect);
		[NoArrayLength ()]
		[CCode (cname = "gtk_tree_view_insert_column")]
		public int insert_column (Gtk.TreeViewColumn column, int position);
		[NoArrayLength ()]
		[CCode (cname = "gtk_tree_view_insert_column_with_attributes")]
		public int insert_column_with_attributes (int position, string title, Gtk.CellRenderer cell, ...);
		[NoArrayLength ()]
		[CCode (cname = "gtk_tree_view_insert_column_with_data_func")]
		public int insert_column_with_data_func (int position, string title, Gtk.CellRenderer cell, Gtk.TreeCellDataFunc func, pointer data, GLib.DestroyNotify dnotify);
		[NoArrayLength ()]
		[CCode (cname = "gtk_tree_view_map_expanded_rows")]
		public void map_expanded_rows (Gtk.TreeViewMappingFunc func, pointer data);
		[NoArrayLength ()]
		[CCode (cname = "gtk_tree_view_mode_get_type")]
		public static GLib.Type mode_get_type ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_tree_view_move_column_after")]
		public void move_column_after (Gtk.TreeViewColumn column, Gtk.TreeViewColumn base_column);
		[NoArrayLength ()]
		[CCode (cname = "gtk_tree_view_new")]
		public construct ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_tree_view_new_with_model")]
		public construct with_model (Gtk.TreeModel model);
		[NoArrayLength ()]
		[CCode (cname = "gtk_tree_view_remove_column")]
		public int remove_column (Gtk.TreeViewColumn column);
		[NoArrayLength ()]
		[CCode (cname = "gtk_tree_view_scroll_to_cell")]
		public void scroll_to_cell (Gtk.TreePath path, Gtk.TreeViewColumn column, bool use_align, float row_align, float col_align);
		[NoArrayLength ()]
		[CCode (cname = "gtk_tree_view_scroll_to_point")]
		public void scroll_to_point (int tree_x, int tree_y);
		[NoArrayLength ()]
		[CCode (cname = "gtk_tree_view_set_column_drag_function")]
		public void set_column_drag_function (Gtk.TreeViewColumnDropFunc func, pointer user_data, Gtk.DestroyNotify destroy);
		[NoArrayLength ()]
		[CCode (cname = "gtk_tree_view_set_cursor")]
		public void set_cursor (Gtk.TreePath path, Gtk.TreeViewColumn focus_column, bool start_editing);
		[NoArrayLength ()]
		[CCode (cname = "gtk_tree_view_set_cursor_on_cell")]
		public void set_cursor_on_cell (Gtk.TreePath path, Gtk.TreeViewColumn focus_column, Gtk.CellRenderer focus_cell, bool start_editing);
		[NoArrayLength ()]
		[CCode (cname = "gtk_tree_view_set_destroy_count_func")]
		public void set_destroy_count_func (Gtk.TreeDestroyCountFunc func, pointer data, Gtk.DestroyNotify destroy);
		[NoArrayLength ()]
		[CCode (cname = "gtk_tree_view_set_drag_dest_row")]
		public void set_drag_dest_row (Gtk.TreePath path, Gtk.TreeViewDropPosition pos);
		[NoArrayLength ()]
		[CCode (cname = "gtk_tree_view_set_enable_search")]
		public void set_enable_search (bool enable_search);
		[NoArrayLength ()]
		[CCode (cname = "gtk_tree_view_set_enable_tree_lines")]
		public void set_enable_tree_lines (bool enabled);
		[NoArrayLength ()]
		[CCode (cname = "gtk_tree_view_set_expander_column")]
		public void set_expander_column (Gtk.TreeViewColumn column);
		[NoArrayLength ()]
		[CCode (cname = "gtk_tree_view_set_fixed_height_mode")]
		public void set_fixed_height_mode (bool enable);
		[NoArrayLength ()]
		[CCode (cname = "gtk_tree_view_set_grid_lines")]
		public void set_grid_lines (Gtk.TreeViewGridLines grid_lines);
		[NoArrayLength ()]
		[CCode (cname = "gtk_tree_view_set_hadjustment")]
		public void set_hadjustment (Gtk.Adjustment adjustment);
		[NoArrayLength ()]
		[CCode (cname = "gtk_tree_view_set_headers_clickable")]
		public void set_headers_clickable (bool setting);
		[NoArrayLength ()]
		[CCode (cname = "gtk_tree_view_set_headers_visible")]
		public void set_headers_visible (bool headers_visible);
		[NoArrayLength ()]
		[CCode (cname = "gtk_tree_view_set_hover_expand")]
		public void set_hover_expand (bool expand);
		[NoArrayLength ()]
		[CCode (cname = "gtk_tree_view_set_hover_selection")]
		public void set_hover_selection (bool hover);
		[NoArrayLength ()]
		[CCode (cname = "gtk_tree_view_set_model")]
		public void set_model (Gtk.TreeModel model);
		[NoArrayLength ()]
		[CCode (cname = "gtk_tree_view_set_reorderable")]
		public void set_reorderable (bool reorderable);
		[NoArrayLength ()]
		[CCode (cname = "gtk_tree_view_set_row_separator_func")]
		public void set_row_separator_func (Gtk.TreeViewRowSeparatorFunc func, pointer data, Gtk.DestroyNotify destroy);
		[NoArrayLength ()]
		[CCode (cname = "gtk_tree_view_set_rubber_banding")]
		public void set_rubber_banding (bool enable);
		[NoArrayLength ()]
		[CCode (cname = "gtk_tree_view_set_rules_hint")]
		public void set_rules_hint (bool setting);
		[NoArrayLength ()]
		[CCode (cname = "gtk_tree_view_set_search_column")]
		public void set_search_column (int column);
		[NoArrayLength ()]
		[CCode (cname = "gtk_tree_view_set_search_entry")]
		public void set_search_entry (Gtk.Entry entry);
		[NoArrayLength ()]
		[CCode (cname = "gtk_tree_view_set_search_equal_func")]
		public void set_search_equal_func (Gtk.TreeViewSearchEqualFunc search_equal_func, pointer search_user_data, Gtk.DestroyNotify search_destroy);
		[NoArrayLength ()]
		[CCode (cname = "gtk_tree_view_set_search_position_func")]
		public void set_search_position_func (Gtk.TreeViewSearchPositionFunc func, pointer data, GLib.DestroyNotify destroy);
		[NoArrayLength ()]
		[CCode (cname = "gtk_tree_view_set_vadjustment")]
		public void set_vadjustment (Gtk.Adjustment adjustment);
		[NoArrayLength ()]
		[CCode (cname = "gtk_tree_view_tree_to_widget_coords")]
		public void tree_to_widget_coords (int tx, int ty, int wx, int wy);
		[NoArrayLength ()]
		[CCode (cname = "gtk_tree_view_unset_rows_drag_dest")]
		public void unset_rows_drag_dest ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_tree_view_unset_rows_drag_source")]
		public void unset_rows_drag_source ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_tree_view_widget_to_tree_coords")]
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
	[CCode (cheader_filename = "gtk/gtk.h")]
	public class TreeViewColumn : Gtk.Object, Gtk.CellLayout {
		[NoArrayLength ()]
		[CCode (cname = "gtk_tree_view_column_add_attribute")]
		public void add_attribute (Gtk.CellRenderer cell_renderer, string attribute, int column);
		[NoArrayLength ()]
		[CCode (cname = "gtk_tree_view_column_cell_get_position")]
		public bool cell_get_position (Gtk.CellRenderer cell_renderer, int start_pos, int width);
		[NoArrayLength ()]
		[CCode (cname = "gtk_tree_view_column_cell_get_size")]
		public void cell_get_size (Gdk.Rectangle cell_area, int x_offset, int y_offset, int width, int height);
		[NoArrayLength ()]
		[CCode (cname = "gtk_tree_view_column_cell_is_visible")]
		public bool cell_is_visible ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_tree_view_column_cell_set_cell_data")]
		public void cell_set_cell_data (Gtk.TreeModel tree_model, Gtk.TreeIter iter, bool is_expander, bool is_expanded);
		[NoArrayLength ()]
		[CCode (cname = "gtk_tree_view_column_clear")]
		public void clear ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_tree_view_column_clear_attributes")]
		public void clear_attributes (Gtk.CellRenderer cell_renderer);
		[NoArrayLength ()]
		[CCode (cname = "gtk_tree_view_column_focus_cell")]
		public void focus_cell (Gtk.CellRenderer cell);
		[NoArrayLength ()]
		[CCode (cname = "gtk_tree_view_column_get_alignment")]
		public float get_alignment ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_tree_view_column_get_cell_renderers")]
		public GLib.List get_cell_renderers ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_tree_view_column_get_clickable")]
		public bool get_clickable ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_tree_view_column_get_expand")]
		public bool get_expand ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_tree_view_column_get_fixed_width")]
		public int get_fixed_width ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_tree_view_column_get_max_width")]
		public int get_max_width ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_tree_view_column_get_min_width")]
		public int get_min_width ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_tree_view_column_get_reorderable")]
		public bool get_reorderable ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_tree_view_column_get_resizable")]
		public bool get_resizable ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_tree_view_column_get_sizing")]
		public Gtk.TreeViewColumnSizing get_sizing ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_tree_view_column_get_sort_column_id")]
		public int get_sort_column_id ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_tree_view_column_get_sort_indicator")]
		public bool get_sort_indicator ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_tree_view_column_get_sort_order")]
		public Gtk.SortType get_sort_order ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_tree_view_column_get_spacing")]
		public int get_spacing ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_tree_view_column_get_title")]
		public string get_title ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_tree_view_column_get_type")]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_tree_view_column_get_visible")]
		public bool get_visible ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_tree_view_column_get_widget")]
		public Gtk.Widget get_widget ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_tree_view_column_get_width")]
		public int get_width ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_tree_view_column_new")]
		public construct ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_tree_view_column_new_with_attributes")]
		public construct with_attributes (string title, Gtk.CellRenderer cell, ...);
		[NoArrayLength ()]
		[CCode (cname = "gtk_tree_view_column_pack_end")]
		public void pack_end (Gtk.CellRenderer cell, bool expand);
		[NoArrayLength ()]
		[CCode (cname = "gtk_tree_view_column_pack_start")]
		public void pack_start (Gtk.CellRenderer cell, bool expand);
		[NoArrayLength ()]
		[CCode (cname = "gtk_tree_view_column_queue_resize")]
		public void queue_resize ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_tree_view_column_set_alignment")]
		public void set_alignment (float xalign);
		[NoArrayLength ()]
		[CCode (cname = "gtk_tree_view_column_set_attributes")]
		public void set_attributes (Gtk.CellRenderer cell_renderer);
		[NoArrayLength ()]
		[CCode (cname = "gtk_tree_view_column_set_cell_data_func")]
		public void set_cell_data_func (Gtk.CellRenderer cell_renderer, Gtk.TreeCellDataFunc func, pointer func_data, Gtk.DestroyNotify destroy);
		[NoArrayLength ()]
		[CCode (cname = "gtk_tree_view_column_set_clickable")]
		public void set_clickable (bool clickable);
		[NoArrayLength ()]
		[CCode (cname = "gtk_tree_view_column_set_expand")]
		public void set_expand (bool expand);
		[NoArrayLength ()]
		[CCode (cname = "gtk_tree_view_column_set_fixed_width")]
		public void set_fixed_width (int fixed_width);
		[NoArrayLength ()]
		[CCode (cname = "gtk_tree_view_column_set_max_width")]
		public void set_max_width (int max_width);
		[NoArrayLength ()]
		[CCode (cname = "gtk_tree_view_column_set_min_width")]
		public void set_min_width (int min_width);
		[NoArrayLength ()]
		[CCode (cname = "gtk_tree_view_column_set_reorderable")]
		public void set_reorderable (bool reorderable);
		[NoArrayLength ()]
		[CCode (cname = "gtk_tree_view_column_set_resizable")]
		public void set_resizable (bool resizable);
		[NoArrayLength ()]
		[CCode (cname = "gtk_tree_view_column_set_sizing")]
		public void set_sizing (Gtk.TreeViewColumnSizing type);
		[NoArrayLength ()]
		[CCode (cname = "gtk_tree_view_column_set_sort_column_id")]
		public void set_sort_column_id (int sort_column_id);
		[NoArrayLength ()]
		[CCode (cname = "gtk_tree_view_column_set_sort_indicator")]
		public void set_sort_indicator (bool setting);
		[NoArrayLength ()]
		[CCode (cname = "gtk_tree_view_column_set_sort_order")]
		public void set_sort_order (Gtk.SortType order);
		[NoArrayLength ()]
		[CCode (cname = "gtk_tree_view_column_set_spacing")]
		public void set_spacing (int spacing);
		[NoArrayLength ()]
		[CCode (cname = "gtk_tree_view_column_set_title")]
		public void set_title (string title);
		[NoArrayLength ()]
		[CCode (cname = "gtk_tree_view_column_set_visible")]
		public void set_visible (bool visible);
		[NoArrayLength ()]
		[CCode (cname = "gtk_tree_view_column_set_widget")]
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
	[CCode (cheader_filename = "gtk/gtk.h")]
	public class UIManager : GLib.Object {
		[NoArrayLength ()]
		[CCode (cname = "gtk_ui_manager_add_ui")]
		public void add_ui (uint merge_id, string path, string name, string action, Gtk.UIManagerItemType type, bool top);
		[NoArrayLength ()]
		[CCode (cname = "gtk_ui_manager_add_ui_from_file")]
		public uint add_ui_from_file (string filename, GLib.Error error);
		[NoArrayLength ()]
		[CCode (cname = "gtk_ui_manager_add_ui_from_string")]
		public uint add_ui_from_string (string buffer, long length, GLib.Error error);
		[NoArrayLength ()]
		[CCode (cname = "gtk_ui_manager_ensure_update")]
		public void ensure_update ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_ui_manager_get_accel_group")]
		public Gtk.AccelGroup get_accel_group ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_ui_manager_get_action")]
		public virtual Gtk.Action get_action (string path);
		[NoArrayLength ()]
		[CCode (cname = "gtk_ui_manager_get_action_groups")]
		public GLib.List get_action_groups ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_ui_manager_get_add_tearoffs")]
		public bool get_add_tearoffs ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_ui_manager_get_toplevels")]
		public GLib.SList get_toplevels (Gtk.UIManagerItemType types);
		[NoArrayLength ()]
		[CCode (cname = "gtk_ui_manager_get_type")]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_ui_manager_get_ui")]
		public string get_ui ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_ui_manager_get_widget")]
		public virtual Gtk.Widget get_widget (string path);
		[NoArrayLength ()]
		[CCode (cname = "gtk_ui_manager_insert_action_group")]
		public void insert_action_group (Gtk.ActionGroup action_group, int pos);
		[NoArrayLength ()]
		[CCode (cname = "gtk_ui_manager_new")]
		public construct ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_ui_manager_new_merge_id")]
		public construct merge_id ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_ui_manager_remove_action_group")]
		public void remove_action_group (Gtk.ActionGroup action_group);
		[NoArrayLength ()]
		[CCode (cname = "gtk_ui_manager_remove_ui")]
		public void remove_ui (uint merge_id);
		[NoArrayLength ()]
		[CCode (cname = "gtk_ui_manager_set_add_tearoffs")]
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
	[CCode (cheader_filename = "gtk/gtk.h")]
	public class VBox : Gtk.Box {
		[NoArrayLength ()]
		[CCode (cname = "gtk_vbox_get_type")]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_vbox_new")]
		public construct (bool homogeneous, int spacing);
	}
	[CCode (cheader_filename = "gtk/gtk.h")]
	public class VButtonBox : Gtk.ButtonBox {
		[NoArrayLength ()]
		[CCode (cname = "gtk_vbutton_box_get_type")]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_vbutton_box_new")]
		public construct ();
	}
	[CCode (cheader_filename = "gtk/gtk.h")]
	public class Viewport : Gtk.Bin {
		[NoArrayLength ()]
		[CCode (cname = "gtk_viewport_get_hadjustment")]
		public Gtk.Adjustment get_hadjustment ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_viewport_get_shadow_type")]
		public Gtk.ShadowType get_shadow_type ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_viewport_get_type")]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_viewport_get_vadjustment")]
		public Gtk.Adjustment get_vadjustment ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_viewport_new")]
		public construct (Gtk.Adjustment hadjustment, Gtk.Adjustment vadjustment);
		[NoArrayLength ()]
		[CCode (cname = "gtk_viewport_set_hadjustment")]
		public void set_hadjustment (Gtk.Adjustment adjustment);
		[NoArrayLength ()]
		[CCode (cname = "gtk_viewport_set_shadow_type")]
		public void set_shadow_type (Gtk.ShadowType type);
		[NoArrayLength ()]
		[CCode (cname = "gtk_viewport_set_vadjustment")]
		public void set_vadjustment (Gtk.Adjustment adjustment);
		public weak Gtk.Adjustment hadjustment { get; set construct; }
		public weak Gtk.Adjustment vadjustment { get; set construct; }
		public weak Gtk.ShadowType shadow_type { get; set; }
		public signal void set_scroll_adjustments (Gtk.Adjustment hadjustment, Gtk.Adjustment vadjustment);
	}
	[CCode (cheader_filename = "gtk/gtk.h")]
	public class VPaned : Gtk.Paned {
		[NoArrayLength ()]
		[CCode (cname = "gtk_vpaned_get_type")]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_vpaned_new")]
		public construct ();
	}
	[CCode (cheader_filename = "gtk/gtk.h")]
	public class VRuler : Gtk.Ruler {
		[NoArrayLength ()]
		[CCode (cname = "gtk_vruler_get_type")]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_vruler_new")]
		public construct ();
	}
	[CCode (cheader_filename = "gtk/gtk.h")]
	public class VScale : Gtk.Scale {
		[NoArrayLength ()]
		[CCode (cname = "gtk_vscale_get_type")]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_vscale_new")]
		public construct (Gtk.Adjustment adjustment);
		[NoArrayLength ()]
		[CCode (cname = "gtk_vscale_new_with_range")]
		public construct with_range (double min, double max, double step);
	}
	[CCode (cheader_filename = "gtk/gtk.h")]
	public class VScrollbar : Gtk.Scrollbar {
		[NoArrayLength ()]
		[CCode (cname = "gtk_vscrollbar_get_type")]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_vscrollbar_new")]
		public construct (Gtk.Adjustment adjustment);
	}
	[CCode (cheader_filename = "gtk/gtk.h")]
	public class VSeparator : Gtk.Separator {
		[NoArrayLength ()]
		[CCode (cname = "gtk_vseparator_get_type")]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_vseparator_new")]
		public construct ();
	}
	[CCode (cheader_filename = "gtk/gtk.h")]
	public class Widget : Gtk.Object, Atk.Implementor {
		public Gtk.Requisition requisition;
		public Gtk.Allocation allocation;
		public weak Gdk.Window window;
		[NoArrayLength ()]
		[CCode (cname = "gtk_widget_activate")]
		public bool activate ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_widget_add_accelerator")]
		public void add_accelerator (string accel_signal, Gtk.AccelGroup accel_group, uint accel_key, Gdk.ModifierType accel_mods, Gtk.AccelFlags accel_flags);
		[NoArrayLength ()]
		[CCode (cname = "gtk_widget_add_events")]
		public void add_events (int events);
		[NoArrayLength ()]
		[CCode (cname = "gtk_widget_add_mnemonic_label")]
		public void add_mnemonic_label (Gtk.Widget label);
		[NoArrayLength ()]
		[CCode (cname = "gtk_widget_child_focus")]
		public bool child_focus (Gtk.DirectionType direction);
		[NoArrayLength ()]
		[CCode (cname = "gtk_widget_class_find_style_property")]
		public static GLib.ParamSpec class_find_style_property (pointer klass, string property_name);
		[NoArrayLength ()]
		[CCode (cname = "gtk_widget_class_install_style_property")]
		public static void class_install_style_property (pointer klass, GLib.ParamSpec pspec);
		[NoArrayLength ()]
		[CCode (cname = "gtk_widget_class_install_style_property_parser")]
		public static void class_install_style_property_parser (pointer klass, GLib.ParamSpec pspec, Gtk.RcPropertyParser parser);
		[NoArrayLength ()]
		[CCode (cname = "gtk_widget_class_list_style_properties")]
		public static GLib.ParamSpec class_list_style_properties (pointer klass, uint n_properties);
		[NoArrayLength ()]
		[CCode (cname = "gtk_widget_class_path")]
		public void class_path (uint path_length, string path, string path_reversed);
		[NoArrayLength ()]
		[CCode (cname = "gtk_widget_create_pango_context")]
		public Pango.Context create_pango_context ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_widget_create_pango_layout")]
		public Pango.Layout create_pango_layout (string text);
		[NoArrayLength ()]
		[CCode (cname = "gtk_widget_destroyed")]
		public void destroyed (Gtk.Widget widget_pointer);
		[NoArrayLength ()]
		[CCode (cname = "gtk_widget_ensure_style")]
		public void ensure_style ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_widget_freeze_child_notify")]
		public void freeze_child_notify ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_widget_get_accessible")]
		public virtual Atk.Object get_accessible ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_widget_get_action")]
		public Gtk.Action get_action ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_widget_get_ancestor")]
		public Gtk.Widget get_ancestor (GLib.Type widget_type);
		[NoArrayLength ()]
		[CCode (cname = "gtk_widget_get_child_requisition")]
		public void get_child_requisition (Gtk.Requisition requisition);
		[NoArrayLength ()]
		[CCode (cname = "gtk_widget_get_child_visible")]
		public bool get_child_visible ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_widget_get_clipboard")]
		public Gtk.Clipboard get_clipboard (Gdk.Atom selection);
		[NoArrayLength ()]
		[CCode (cname = "gtk_widget_get_colormap")]
		public Gdk.Colormap get_colormap ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_widget_get_composite_name")]
		public string get_composite_name ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_widget_get_default_colormap")]
		public static Gdk.Colormap get_default_colormap ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_widget_get_default_direction")]
		public static Gtk.TextDirection get_default_direction ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_widget_get_default_style")]
		public static Gtk.Style get_default_style ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_widget_get_default_visual")]
		public static Gdk.Visual get_default_visual ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_widget_get_direction")]
		public Gtk.TextDirection get_direction ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_widget_get_display")]
		public Gdk.Display get_display ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_widget_get_events")]
		public int get_events ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_widget_get_extension_events")]
		public Gdk.ExtensionMode get_extension_events ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_widget_get_modifier_style")]
		public Gtk.RcStyle get_modifier_style ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_widget_get_name")]
		public string get_name ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_widget_get_no_show_all")]
		public bool get_no_show_all ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_widget_get_pango_context")]
		public Pango.Context get_pango_context ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_widget_get_parent")]
		public Gtk.Widget get_parent ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_widget_get_parent_window")]
		public Gdk.Window get_parent_window ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_widget_get_pointer")]
		public void get_pointer (int x, int y);
		[NoArrayLength ()]
		[CCode (cname = "gtk_widget_get_root_window")]
		public Gdk.Window get_root_window ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_widget_get_screen")]
		public Gdk.Screen get_screen ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_widget_get_settings")]
		public Gtk.Settings get_settings ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_widget_get_size_request")]
		public void get_size_request (int width, int height);
		[NoArrayLength ()]
		[CCode (cname = "gtk_widget_get_style")]
		public Gtk.Style get_style ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_widget_get_toplevel")]
		public Gtk.Widget get_toplevel ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_widget_get_type")]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_widget_get_visual")]
		public Gdk.Visual get_visual ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_widget_grab_default")]
		public void grab_default ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_widget_has_screen")]
		public bool has_screen ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_widget_hide_all")]
		public virtual void hide_all ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_widget_hide_on_delete")]
		public bool hide_on_delete ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_widget_input_shape_combine_mask")]
		public void input_shape_combine_mask (Gdk.Bitmap shape_mask, int offset_x, int offset_y);
		[NoArrayLength ()]
		[CCode (cname = "gtk_widget_intersect")]
		public bool intersect (Gdk.Rectangle area, Gdk.Rectangle intersection);
		[NoArrayLength ()]
		[CCode (cname = "gtk_widget_is_ancestor")]
		public bool is_ancestor (Gtk.Widget ancestor);
		[NoArrayLength ()]
		[CCode (cname = "gtk_widget_is_composited")]
		public bool is_composited ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_widget_list_accel_closures")]
		public GLib.List list_accel_closures ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_widget_list_mnemonic_labels")]
		public GLib.List list_mnemonic_labels ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_widget_modify_base")]
		public void modify_base (Gtk.StateType state, Gdk.Color color);
		[NoArrayLength ()]
		[CCode (cname = "gtk_widget_modify_bg")]
		public void modify_bg (Gtk.StateType state, Gdk.Color color);
		[NoArrayLength ()]
		[CCode (cname = "gtk_widget_modify_fg")]
		public void modify_fg (Gtk.StateType state, Gdk.Color color);
		[NoArrayLength ()]
		[CCode (cname = "gtk_widget_modify_font")]
		public void modify_font (Pango.FontDescription font_desc);
		[NoArrayLength ()]
		[CCode (cname = "gtk_widget_modify_style")]
		public void modify_style (Gtk.RcStyle style);
		[NoArrayLength ()]
		[CCode (cname = "gtk_widget_modify_text")]
		public void modify_text (Gtk.StateType state, Gdk.Color color);
		[NoArrayLength ()]
		[CCode (cname = "gtk_widget_new")]
		public construct (GLib.Type type, string first_property_name);
		[NoArrayLength ()]
		[CCode (cname = "gtk_widget_path")]
		public void path (uint path_length, string path, string path_reversed);
		[NoArrayLength ()]
		[CCode (cname = "gtk_widget_pop_colormap")]
		public static void pop_colormap ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_widget_pop_composite_child")]
		public static void pop_composite_child ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_widget_push_colormap")]
		public static void push_colormap (Gdk.Colormap cmap);
		[NoArrayLength ()]
		[CCode (cname = "gtk_widget_push_composite_child")]
		public static void push_composite_child ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_widget_queue_draw")]
		public void queue_draw ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_widget_queue_draw_area")]
		public void queue_draw_area (int x, int y, int width, int height);
		[NoArrayLength ()]
		[CCode (cname = "gtk_widget_queue_resize")]
		public void queue_resize ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_widget_queue_resize_no_redraw")]
		public void queue_resize_no_redraw ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_widget_ref")]
		public Gtk.Widget @ref ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_widget_region_intersect")]
		public Gdk.Region region_intersect (Gdk.Region region);
		[NoArrayLength ()]
		[CCode (cname = "gtk_widget_remove_accelerator")]
		public bool remove_accelerator (Gtk.AccelGroup accel_group, uint accel_key, Gdk.ModifierType accel_mods);
		[NoArrayLength ()]
		[CCode (cname = "gtk_widget_remove_mnemonic_label")]
		public void remove_mnemonic_label (Gtk.Widget label);
		[NoArrayLength ()]
		[CCode (cname = "gtk_widget_render_icon")]
		public Gdk.Pixbuf render_icon (string stock_id, Gtk.IconSize size, string detail);
		[NoArrayLength ()]
		[CCode (cname = "gtk_widget_reparent")]
		public void reparent (Gtk.Widget new_parent);
		[NoArrayLength ()]
		[CCode (cname = "gtk_widget_reset_rc_styles")]
		public void reset_rc_styles ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_widget_reset_shapes")]
		public void reset_shapes ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_widget_send_expose")]
		public int send_expose (Gdk.Event event);
		[NoArrayLength ()]
		[CCode (cname = "gtk_widget_set_accel_path")]
		public void set_accel_path (string accel_path, Gtk.AccelGroup accel_group);
		[NoArrayLength ()]
		[CCode (cname = "gtk_widget_set_app_paintable")]
		public void set_app_paintable (bool app_paintable);
		[NoArrayLength ()]
		[CCode (cname = "gtk_widget_set_child_visible")]
		public void set_child_visible (bool is_visible);
		[NoArrayLength ()]
		[CCode (cname = "gtk_widget_set_colormap")]
		public void set_colormap (Gdk.Colormap colormap);
		[NoArrayLength ()]
		[CCode (cname = "gtk_widget_set_composite_name")]
		public void set_composite_name (string name);
		[NoArrayLength ()]
		[CCode (cname = "gtk_widget_set_default_colormap")]
		public static void set_default_colormap (Gdk.Colormap colormap);
		[NoArrayLength ()]
		[CCode (cname = "gtk_widget_set_default_direction")]
		public static void set_default_direction (Gtk.TextDirection dir);
		[NoArrayLength ()]
		[CCode (cname = "gtk_widget_set_direction")]
		public void set_direction (Gtk.TextDirection dir);
		[NoArrayLength ()]
		[CCode (cname = "gtk_widget_set_double_buffered")]
		public void set_double_buffered (bool double_buffered);
		[NoArrayLength ()]
		[CCode (cname = "gtk_widget_set_events")]
		public void set_events (int events);
		[NoArrayLength ()]
		[CCode (cname = "gtk_widget_set_extension_events")]
		public void set_extension_events (Gdk.ExtensionMode mode);
		[NoArrayLength ()]
		[CCode (cname = "gtk_widget_set_name")]
		public void set_name (string name);
		[NoArrayLength ()]
		[CCode (cname = "gtk_widget_set_no_show_all")]
		public void set_no_show_all (bool no_show_all);
		[NoArrayLength ()]
		[CCode (cname = "gtk_widget_set_parent")]
		public void set_parent (Gtk.Widget parent);
		[NoArrayLength ()]
		[CCode (cname = "gtk_widget_set_parent_window")]
		public void set_parent_window (Gdk.Window parent_window);
		[NoArrayLength ()]
		[CCode (cname = "gtk_widget_set_redraw_on_allocate")]
		public void set_redraw_on_allocate (bool redraw_on_allocate);
		[NoArrayLength ()]
		[CCode (cname = "gtk_widget_set_scroll_adjustments")]
		public bool set_scroll_adjustments (Gtk.Adjustment hadjustment, Gtk.Adjustment vadjustment);
		[NoArrayLength ()]
		[CCode (cname = "gtk_widget_set_sensitive")]
		public void set_sensitive (bool sensitive);
		[NoArrayLength ()]
		[CCode (cname = "gtk_widget_set_size_request")]
		public void set_size_request (int width, int height);
		[NoArrayLength ()]
		[CCode (cname = "gtk_widget_set_state")]
		public void set_state (Gtk.StateType state);
		[NoArrayLength ()]
		[CCode (cname = "gtk_widget_set_style")]
		public void set_style (Gtk.Style style);
		[NoArrayLength ()]
		[CCode (cname = "gtk_widget_shape_combine_mask")]
		public void shape_combine_mask (Gdk.Bitmap shape_mask, int offset_x, int offset_y);
		[NoArrayLength ()]
		[CCode (cname = "gtk_widget_show_all")]
		public virtual void show_all ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_widget_show_now")]
		public void show_now ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_widget_style_get")]
		public void style_get (string first_property_name);
		[NoArrayLength ()]
		[CCode (cname = "gtk_widget_style_get_property")]
		public void style_get_property (string property_name, GLib.Value value);
		[NoArrayLength ()]
		[CCode (cname = "gtk_widget_style_get_valist")]
		public void style_get_valist (string first_property_name, pointer var_args);
		[NoArrayLength ()]
		[CCode (cname = "gtk_widget_thaw_child_notify")]
		public void thaw_child_notify ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_widget_translate_coordinates")]
		public bool translate_coordinates (Gtk.Widget dest_widget, int src_x, int src_y, int dest_x, int dest_y);
		[NoArrayLength ()]
		[CCode (cname = "gtk_widget_unparent")]
		public void unparent ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_widget_unref")]
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
		public signal void size_allocate (Gtk.Allocation allocation);
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
	[CCode (cheader_filename = "gtk/gtk.h")]
	public class Win32EmbedWidget : Gtk.Window {
		[NoArrayLength ()]
		[CCode (cname = "gtk_win32_embed_widget_get_type")]
		public static GLib.Type get_type ();
	}
	[CCode (cheader_filename = "gtk/gtk.h")]
	public class Window : Gtk.Bin {
		[NoArrayLength ()]
		[CCode (cname = "gtk_window_activate_default")]
		public bool activate_default ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_window_activate_focus")]
		public bool activate_focus ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_window_activate_key")]
		public bool activate_key (Gdk.EventKey event);
		[NoArrayLength ()]
		[CCode (cname = "gtk_window_add_accel_group")]
		public void add_accel_group (Gtk.AccelGroup accel_group);
		[NoArrayLength ()]
		[CCode (cname = "gtk_window_add_embedded_xid")]
		public void add_embedded_xid (uint xid);
		[NoArrayLength ()]
		[CCode (cname = "gtk_window_add_mnemonic")]
		public void add_mnemonic (uint keyval, Gtk.Widget target);
		[NoArrayLength ()]
		[CCode (cname = "gtk_window_begin_move_drag")]
		public void begin_move_drag (int button, int root_x, int root_y, uint timestamp);
		[NoArrayLength ()]
		[CCode (cname = "gtk_window_begin_resize_drag")]
		public void begin_resize_drag (Gdk.WindowEdge edge, int button, int root_x, int root_y, uint timestamp);
		[NoArrayLength ()]
		[CCode (cname = "gtk_window_deiconify")]
		public void deiconify ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_window_fullscreen")]
		public void fullscreen ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_window_get_accept_focus")]
		public bool get_accept_focus ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_window_get_decorated")]
		public bool get_decorated ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_window_get_default_icon_list")]
		public static GLib.List get_default_icon_list ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_window_get_default_size")]
		public void get_default_size (int width, int height);
		[NoArrayLength ()]
		[CCode (cname = "gtk_window_get_deletable")]
		public bool get_deletable ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_window_get_destroy_with_parent")]
		public bool get_destroy_with_parent ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_window_get_focus")]
		public Gtk.Widget get_focus ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_window_get_focus_on_map")]
		public bool get_focus_on_map ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_window_get_frame_dimensions")]
		public void get_frame_dimensions (int left, int top, int right, int bottom);
		[NoArrayLength ()]
		[CCode (cname = "gtk_window_get_gravity")]
		public Gdk.Gravity get_gravity ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_window_get_group")]
		public Gtk.WindowGroup get_group ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_window_get_has_frame")]
		public bool get_has_frame ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_window_get_icon")]
		public Gdk.Pixbuf get_icon ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_window_get_icon_list")]
		public GLib.List get_icon_list ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_window_get_icon_name")]
		public string get_icon_name ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_window_get_mnemonic_modifier")]
		public Gdk.ModifierType get_mnemonic_modifier ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_window_get_modal")]
		public bool get_modal ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_window_get_position")]
		public void get_position (int root_x, int root_y);
		[NoArrayLength ()]
		[CCode (cname = "gtk_window_get_resizable")]
		public bool get_resizable ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_window_get_role")]
		public string get_role ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_window_get_screen")]
		public Gdk.Screen get_screen ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_window_get_size")]
		public void get_size (int width, int height);
		[NoArrayLength ()]
		[CCode (cname = "gtk_window_get_skip_pager_hint")]
		public bool get_skip_pager_hint ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_window_get_skip_taskbar_hint")]
		public bool get_skip_taskbar_hint ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_window_get_title")]
		public string get_title ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_window_get_transient_for")]
		public Gtk.Window get_transient_for ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_window_get_type")]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_window_get_type_hint")]
		public Gdk.WindowTypeHint get_type_hint ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_window_get_urgency_hint")]
		public bool get_urgency_hint ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_window_iconify")]
		public void iconify ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_window_list_toplevels")]
		public static GLib.List list_toplevels ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_window_maximize")]
		public void maximize ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_window_mnemonic_activate")]
		public bool mnemonic_activate (uint keyval, Gdk.ModifierType modifier);
		[NoArrayLength ()]
		[CCode (cname = "gtk_window_move")]
		public void move (int x, int y);
		[NoArrayLength ()]
		[CCode (cname = "gtk_window_new")]
		public construct (Gtk.WindowType type);
		[NoArrayLength ()]
		[CCode (cname = "gtk_window_parse_geometry")]
		public bool parse_geometry (string geometry);
		[NoArrayLength ()]
		[CCode (cname = "gtk_window_present")]
		public void present ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_window_present_with_time")]
		public void present_with_time (uint timestamp);
		[NoArrayLength ()]
		[CCode (cname = "gtk_window_propagate_key_event")]
		public bool propagate_key_event (Gdk.EventKey event);
		[NoArrayLength ()]
		[CCode (cname = "gtk_window_remove_accel_group")]
		public void remove_accel_group (Gtk.AccelGroup accel_group);
		[NoArrayLength ()]
		[CCode (cname = "gtk_window_remove_embedded_xid")]
		public void remove_embedded_xid (uint xid);
		[NoArrayLength ()]
		[CCode (cname = "gtk_window_remove_mnemonic")]
		public void remove_mnemonic (uint keyval, Gtk.Widget target);
		[NoArrayLength ()]
		[CCode (cname = "gtk_window_reshow_with_initial_size")]
		public void reshow_with_initial_size ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_window_resize")]
		public void resize (int width, int height);
		[NoArrayLength ()]
		[CCode (cname = "gtk_window_set_accept_focus")]
		public void set_accept_focus (bool setting);
		[NoArrayLength ()]
		[CCode (cname = "gtk_window_set_auto_startup_notification")]
		public static void set_auto_startup_notification (bool setting);
		[NoArrayLength ()]
		[CCode (cname = "gtk_window_set_decorated")]
		public void set_decorated (bool setting);
		[NoArrayLength ()]
		[CCode (cname = "gtk_window_set_default")]
		public void set_default (Gtk.Widget default_widget);
		[NoArrayLength ()]
		[CCode (cname = "gtk_window_set_default_icon")]
		public static void set_default_icon (Gdk.Pixbuf icon);
		[NoArrayLength ()]
		[CCode (cname = "gtk_window_set_default_icon_from_file")]
		public static bool set_default_icon_from_file (string filename, GLib.Error err);
		[NoArrayLength ()]
		[CCode (cname = "gtk_window_set_default_icon_list")]
		public static void set_default_icon_list (GLib.List list);
		[NoArrayLength ()]
		[CCode (cname = "gtk_window_set_default_icon_name")]
		public static void set_default_icon_name (string name);
		[NoArrayLength ()]
		[CCode (cname = "gtk_window_set_default_size")]
		public void set_default_size (int width, int height);
		[NoArrayLength ()]
		[CCode (cname = "gtk_window_set_deletable")]
		public void set_deletable (bool setting);
		[NoArrayLength ()]
		[CCode (cname = "gtk_window_set_destroy_with_parent")]
		public void set_destroy_with_parent (bool setting);
		[NoArrayLength ()]
		[CCode (cname = "gtk_window_set_focus_on_map")]
		public void set_focus_on_map (bool setting);
		[NoArrayLength ()]
		[CCode (cname = "gtk_window_set_frame_dimensions")]
		public void set_frame_dimensions (int left, int top, int right, int bottom);
		[NoArrayLength ()]
		[CCode (cname = "gtk_window_set_geometry_hints")]
		public void set_geometry_hints (Gtk.Widget geometry_widget, Gdk.Geometry geometry, Gdk.WindowHints geom_mask);
		[NoArrayLength ()]
		[CCode (cname = "gtk_window_set_gravity")]
		public void set_gravity (Gdk.Gravity gravity);
		[NoArrayLength ()]
		[CCode (cname = "gtk_window_set_has_frame")]
		public void set_has_frame (bool setting);
		[NoArrayLength ()]
		[CCode (cname = "gtk_window_set_icon")]
		public void set_icon (Gdk.Pixbuf icon);
		[NoArrayLength ()]
		[CCode (cname = "gtk_window_set_icon_from_file")]
		public bool set_icon_from_file (string filename, GLib.Error err);
		[NoArrayLength ()]
		[CCode (cname = "gtk_window_set_icon_list")]
		public void set_icon_list (GLib.List list);
		[NoArrayLength ()]
		[CCode (cname = "gtk_window_set_icon_name")]
		public void set_icon_name (string name);
		[NoArrayLength ()]
		[CCode (cname = "gtk_window_set_keep_above")]
		public void set_keep_above (bool setting);
		[NoArrayLength ()]
		[CCode (cname = "gtk_window_set_keep_below")]
		public void set_keep_below (bool setting);
		[NoArrayLength ()]
		[CCode (cname = "gtk_window_set_mnemonic_modifier")]
		public void set_mnemonic_modifier (Gdk.ModifierType modifier);
		[NoArrayLength ()]
		[CCode (cname = "gtk_window_set_modal")]
		public void set_modal (bool modal);
		[NoArrayLength ()]
		[CCode (cname = "gtk_window_set_position")]
		public void set_position (Gtk.WindowPosition position);
		[NoArrayLength ()]
		[CCode (cname = "gtk_window_set_resizable")]
		public void set_resizable (bool resizable);
		[NoArrayLength ()]
		[CCode (cname = "gtk_window_set_role")]
		public void set_role (string role);
		[NoArrayLength ()]
		[CCode (cname = "gtk_window_set_screen")]
		public void set_screen (Gdk.Screen screen);
		[NoArrayLength ()]
		[CCode (cname = "gtk_window_set_skip_pager_hint")]
		public void set_skip_pager_hint (bool setting);
		[NoArrayLength ()]
		[CCode (cname = "gtk_window_set_skip_taskbar_hint")]
		public void set_skip_taskbar_hint (bool setting);
		[NoArrayLength ()]
		[CCode (cname = "gtk_window_set_title")]
		public void set_title (string title);
		[NoArrayLength ()]
		[CCode (cname = "gtk_window_set_transient_for")]
		public void set_transient_for (Gtk.Window parent);
		[NoArrayLength ()]
		[CCode (cname = "gtk_window_set_type_hint")]
		public void set_type_hint (Gdk.WindowTypeHint hint);
		[NoArrayLength ()]
		[CCode (cname = "gtk_window_set_urgency_hint")]
		public void set_urgency_hint (bool setting);
		[NoArrayLength ()]
		[CCode (cname = "gtk_window_set_wmclass")]
		public void set_wmclass (string wmclass_name, string wmclass_class);
		[NoArrayLength ()]
		[CCode (cname = "gtk_window_stick")]
		public void stick ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_window_unfullscreen")]
		public void unfullscreen ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_window_unmaximize")]
		public void unmaximize ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_window_unstick")]
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
	[CCode (cheader_filename = "gtk/gtk.h")]
	public class WindowGroup : GLib.Object {
		[NoArrayLength ()]
		[CCode (cname = "gtk_window_group_add_window")]
		public void add_window (Gtk.Window window);
		[NoArrayLength ()]
		[CCode (cname = "gtk_window_group_get_type")]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_window_group_new")]
		public construct ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_window_group_remove_window")]
		public void remove_window (Gtk.Window window);
	}
	public interface CellEditable {
		[NoArrayLength ()]
		[CCode (cname = "gtk_cell_editable_get_type")]
		public static GLib.Type get_type ();
		[HasEmitter ()]
		public signal void editing_done ();
		[HasEmitter ()]
		public signal void remove_widget ();
	}
	public interface CellLayout {
		[NoArrayLength ()]
		[CCode (cname = "gtk_cell_layout_add_attribute")]
		public virtual void add_attribute (Gtk.CellRenderer cell, string attribute, int column);
		[NoArrayLength ()]
		[CCode (cname = "gtk_cell_layout_clear")]
		public virtual void clear ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_cell_layout_clear_attributes")]
		public virtual void clear_attributes (Gtk.CellRenderer cell);
		[NoArrayLength ()]
		[CCode (cname = "gtk_cell_layout_get_type")]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_cell_layout_pack_end")]
		public virtual void pack_end (Gtk.CellRenderer cell, bool expand);
		[NoArrayLength ()]
		[CCode (cname = "gtk_cell_layout_pack_start")]
		public virtual void pack_start (Gtk.CellRenderer cell, bool expand);
		[NoArrayLength ()]
		[CCode (cname = "gtk_cell_layout_reorder")]
		public virtual void reorder (Gtk.CellRenderer cell, int position);
		[NoArrayLength ()]
		[CCode (cname = "gtk_cell_layout_set_attributes")]
		public void set_attributes (Gtk.CellRenderer cell);
		[NoArrayLength ()]
		[CCode (cname = "gtk_cell_layout_set_cell_data_func")]
		public virtual void set_cell_data_func (Gtk.CellRenderer cell, Gtk.CellLayoutDataFunc func, pointer func_data, GLib.DestroyNotify destroy);
	}
	public interface Editable {
		[NoArrayLength ()]
		[CCode (cname = "gtk_editable_copy_clipboard")]
		public void copy_clipboard ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_editable_cut_clipboard")]
		public void cut_clipboard ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_editable_delete_selection")]
		public void delete_selection ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_editable_get_chars")]
		public virtual string get_chars (int start_pos, int end_pos);
		[NoArrayLength ()]
		[CCode (cname = "gtk_editable_get_editable")]
		public bool get_editable ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_editable_get_position")]
		public virtual int get_position ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_editable_get_selection_bounds")]
		public virtual bool get_selection_bounds (int start, int end);
		[NoArrayLength ()]
		[CCode (cname = "gtk_editable_get_type")]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_editable_paste_clipboard")]
		public void paste_clipboard ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_editable_select_region")]
		public void select_region (int start, int end);
		[NoArrayLength ()]
		[CCode (cname = "gtk_editable_set_editable")]
		public void set_editable (bool is_editable);
		[NoArrayLength ()]
		[CCode (cname = "gtk_editable_set_position")]
		public virtual void set_position (int position);
		[HasEmitter ()]
		public signal void insert_text (string text, int length, int position);
		[HasEmitter ()]
		public signal void delete_text (int start_pos, int end_pos);
		public signal void changed ();
	}
	public interface FileChooser {
		[NoArrayLength ()]
		[CCode (cname = "gtk_file_chooser_add_filter")]
		public void add_filter (Gtk.FileFilter filter);
		[NoArrayLength ()]
		[CCode (cname = "gtk_file_chooser_add_shortcut_folder")]
		public bool add_shortcut_folder (string folder, GLib.Error error);
		[NoArrayLength ()]
		[CCode (cname = "gtk_file_chooser_add_shortcut_folder_uri")]
		public bool add_shortcut_folder_uri (string uri, GLib.Error error);
		[NoArrayLength ()]
		[CCode (cname = "gtk_file_chooser_error_quark")]
		public static GLib.Quark error_quark ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_file_chooser_get_action")]
		public Gtk.FileChooserAction get_action ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_file_chooser_get_current_folder")]
		public string get_current_folder ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_file_chooser_get_current_folder_uri")]
		public string get_current_folder_uri ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_file_chooser_get_do_overwrite_confirmation")]
		public bool get_do_overwrite_confirmation ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_file_chooser_get_extra_widget")]
		public Gtk.Widget get_extra_widget ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_file_chooser_get_filename")]
		public string get_filename ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_file_chooser_get_filenames")]
		public GLib.SList get_filenames ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_file_chooser_get_filter")]
		public Gtk.FileFilter get_filter ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_file_chooser_get_local_only")]
		public bool get_local_only ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_file_chooser_get_preview_filename")]
		public string get_preview_filename ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_file_chooser_get_preview_uri")]
		public string get_preview_uri ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_file_chooser_get_preview_widget")]
		public Gtk.Widget get_preview_widget ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_file_chooser_get_preview_widget_active")]
		public bool get_preview_widget_active ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_file_chooser_get_select_multiple")]
		public bool get_select_multiple ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_file_chooser_get_show_hidden")]
		public bool get_show_hidden ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_file_chooser_get_type")]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_file_chooser_get_uri")]
		public string get_uri ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_file_chooser_get_uris")]
		public GLib.SList get_uris ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_file_chooser_get_use_preview_label")]
		public bool get_use_preview_label ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_file_chooser_list_filters")]
		public GLib.SList list_filters ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_file_chooser_list_shortcut_folder_uris")]
		public GLib.SList list_shortcut_folder_uris ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_file_chooser_list_shortcut_folders")]
		public GLib.SList list_shortcut_folders ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_file_chooser_remove_filter")]
		public void remove_filter (Gtk.FileFilter filter);
		[NoArrayLength ()]
		[CCode (cname = "gtk_file_chooser_remove_shortcut_folder")]
		public bool remove_shortcut_folder (string folder, GLib.Error error);
		[NoArrayLength ()]
		[CCode (cname = "gtk_file_chooser_remove_shortcut_folder_uri")]
		public bool remove_shortcut_folder_uri (string uri, GLib.Error error);
		[NoArrayLength ()]
		[CCode (cname = "gtk_file_chooser_select_all")]
		public void select_all ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_file_chooser_select_filename")]
		public bool select_filename (string filename);
		[NoArrayLength ()]
		[CCode (cname = "gtk_file_chooser_select_uri")]
		public bool select_uri (string uri);
		[NoArrayLength ()]
		[CCode (cname = "gtk_file_chooser_set_action")]
		public void set_action (Gtk.FileChooserAction action);
		[NoArrayLength ()]
		[CCode (cname = "gtk_file_chooser_set_current_folder")]
		public bool set_current_folder (string filename);
		[NoArrayLength ()]
		[CCode (cname = "gtk_file_chooser_set_current_folder_uri")]
		public bool set_current_folder_uri (string uri);
		[NoArrayLength ()]
		[CCode (cname = "gtk_file_chooser_set_current_name")]
		public void set_current_name (string name);
		[NoArrayLength ()]
		[CCode (cname = "gtk_file_chooser_set_do_overwrite_confirmation")]
		public void set_do_overwrite_confirmation (bool do_overwrite_confirmation);
		[NoArrayLength ()]
		[CCode (cname = "gtk_file_chooser_set_extra_widget")]
		public void set_extra_widget (Gtk.Widget extra_widget);
		[NoArrayLength ()]
		[CCode (cname = "gtk_file_chooser_set_filename")]
		public bool set_filename (string filename);
		[NoArrayLength ()]
		[CCode (cname = "gtk_file_chooser_set_filter")]
		public void set_filter (Gtk.FileFilter filter);
		[NoArrayLength ()]
		[CCode (cname = "gtk_file_chooser_set_local_only")]
		public void set_local_only (bool local_only);
		[NoArrayLength ()]
		[CCode (cname = "gtk_file_chooser_set_preview_widget")]
		public void set_preview_widget (Gtk.Widget preview_widget);
		[NoArrayLength ()]
		[CCode (cname = "gtk_file_chooser_set_preview_widget_active")]
		public void set_preview_widget_active (bool active);
		[NoArrayLength ()]
		[CCode (cname = "gtk_file_chooser_set_select_multiple")]
		public void set_select_multiple (bool select_multiple);
		[NoArrayLength ()]
		[CCode (cname = "gtk_file_chooser_set_show_hidden")]
		public void set_show_hidden (bool show_hidden);
		[NoArrayLength ()]
		[CCode (cname = "gtk_file_chooser_set_uri")]
		public bool set_uri (string uri);
		[NoArrayLength ()]
		[CCode (cname = "gtk_file_chooser_set_use_preview_label")]
		public void set_use_preview_label (bool use_label);
		[NoArrayLength ()]
		[CCode (cname = "gtk_file_chooser_unselect_all")]
		public void unselect_all ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_file_chooser_unselect_filename")]
		public void unselect_filename (string filename);
		[NoArrayLength ()]
		[CCode (cname = "gtk_file_chooser_unselect_uri")]
		public void unselect_uri (string uri);
	}
	public interface PrintOperationPreview {
		[NoArrayLength ()]
		[CCode (cname = "gtk_print_operation_preview_end_preview")]
		public virtual void end_preview ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_print_operation_preview_get_type")]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_print_operation_preview_is_selected")]
		public virtual bool is_selected (int page_nr);
		[NoArrayLength ()]
		[CCode (cname = "gtk_print_operation_preview_render_page")]
		public virtual void render_page (int page_nr);
		public signal void ready (Gtk.PrintContext context);
		public signal void got_page_size (Gtk.PrintContext context, Gtk.PageSetup page_setup);
	}
	public interface RecentChooser {
		[NoArrayLength ()]
		[CCode (cname = "gtk_recent_chooser_add_filter")]
		public virtual void add_filter (Gtk.RecentFilter filter);
		[NoArrayLength ()]
		[CCode (cname = "gtk_recent_chooser_error_quark")]
		public static GLib.Quark error_quark ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_recent_chooser_get_current_item")]
		public Gtk.RecentInfo get_current_item ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_recent_chooser_get_current_uri")]
		public virtual string get_current_uri ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_recent_chooser_get_filter")]
		public Gtk.RecentFilter get_filter ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_recent_chooser_get_items")]
		public virtual GLib.List get_items ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_recent_chooser_get_limit")]
		public int get_limit ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_recent_chooser_get_local_only")]
		public bool get_local_only ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_recent_chooser_get_select_multiple")]
		public bool get_select_multiple ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_recent_chooser_get_show_icons")]
		public bool get_show_icons ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_recent_chooser_get_show_not_found")]
		public bool get_show_not_found ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_recent_chooser_get_show_numbers")]
		public bool get_show_numbers ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_recent_chooser_get_show_private")]
		public bool get_show_private ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_recent_chooser_get_show_tips")]
		public bool get_show_tips ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_recent_chooser_get_sort_type")]
		public Gtk.RecentSortType get_sort_type ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_recent_chooser_get_type")]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_recent_chooser_get_uris")]
		public string get_uris (ulong length);
		[NoArrayLength ()]
		[CCode (cname = "gtk_recent_chooser_list_filters")]
		public virtual GLib.SList list_filters ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_recent_chooser_remove_filter")]
		public virtual void remove_filter (Gtk.RecentFilter filter);
		[NoArrayLength ()]
		[CCode (cname = "gtk_recent_chooser_select_all")]
		public virtual void select_all ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_recent_chooser_select_uri")]
		public virtual bool select_uri (string uri, GLib.Error error);
		[NoArrayLength ()]
		[CCode (cname = "gtk_recent_chooser_set_current_uri")]
		public virtual bool set_current_uri (string uri, GLib.Error error);
		[NoArrayLength ()]
		[CCode (cname = "gtk_recent_chooser_set_filter")]
		public void set_filter (Gtk.RecentFilter filter);
		[NoArrayLength ()]
		[CCode (cname = "gtk_recent_chooser_set_limit")]
		public void set_limit (int limit);
		[NoArrayLength ()]
		[CCode (cname = "gtk_recent_chooser_set_local_only")]
		public void set_local_only (bool local_only);
		[NoArrayLength ()]
		[CCode (cname = "gtk_recent_chooser_set_select_multiple")]
		public void set_select_multiple (bool select_multiple);
		[NoArrayLength ()]
		[CCode (cname = "gtk_recent_chooser_set_show_icons")]
		public void set_show_icons (bool show_icons);
		[NoArrayLength ()]
		[CCode (cname = "gtk_recent_chooser_set_show_not_found")]
		public void set_show_not_found (bool show_not_found);
		[NoArrayLength ()]
		[CCode (cname = "gtk_recent_chooser_set_show_numbers")]
		public void set_show_numbers (bool show_numbers);
		[NoArrayLength ()]
		[CCode (cname = "gtk_recent_chooser_set_show_private")]
		public void set_show_private (bool show_private);
		[NoArrayLength ()]
		[CCode (cname = "gtk_recent_chooser_set_show_tips")]
		public void set_show_tips (bool show_tips);
		[NoArrayLength ()]
		[CCode (cname = "gtk_recent_chooser_set_sort_func")]
		public virtual void set_sort_func (Gtk.RecentSortFunc sort_func, pointer sort_data, GLib.DestroyNotify data_destroy);
		[NoArrayLength ()]
		[CCode (cname = "gtk_recent_chooser_set_sort_type")]
		public void set_sort_type (Gtk.RecentSortType sort_type);
		[NoArrayLength ()]
		[CCode (cname = "gtk_recent_chooser_unselect_all")]
		public virtual void unselect_all ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_recent_chooser_unselect_uri")]
		public virtual void unselect_uri (string uri);
		public signal void selection_changed ();
		public signal void item_activated ();
	}
	public interface TreeDragDest {
		[NoArrayLength ()]
		[CCode (cname = "gtk_tree_drag_dest_drag_data_received")]
		public virtual bool drag_data_received (Gtk.TreePath dest, Gtk.SelectionData selection_data);
		[NoArrayLength ()]
		[CCode (cname = "gtk_tree_drag_dest_get_type")]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_tree_drag_dest_row_drop_possible")]
		public virtual bool row_drop_possible (Gtk.TreePath dest_path, Gtk.SelectionData selection_data);
	}
	public interface TreeDragSource {
		[NoArrayLength ()]
		[CCode (cname = "gtk_tree_drag_source_drag_data_delete")]
		public virtual bool drag_data_delete (Gtk.TreePath path);
		[NoArrayLength ()]
		[CCode (cname = "gtk_tree_drag_source_drag_data_get")]
		public virtual bool drag_data_get (Gtk.TreePath path, Gtk.SelectionData selection_data);
		[NoArrayLength ()]
		[CCode (cname = "gtk_tree_drag_source_get_type")]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_tree_drag_source_row_draggable")]
		public virtual bool row_draggable (Gtk.TreePath path);
	}
	public interface TreeModel {
		[NoArrayLength ()]
		[CCode (cname = "gtk_tree_model_foreach")]
		public void @foreach (Gtk.TreeModelForeachFunc func, pointer user_data);
		[NoArrayLength ()]
		[CCode (cname = "gtk_tree_model_get")]
		public void @get (Gtk.TreeIter iter);
		[NoArrayLength ()]
		[CCode (cname = "gtk_tree_model_get_column_type")]
		public virtual GLib.Type get_column_type (int index_);
		[NoArrayLength ()]
		[CCode (cname = "gtk_tree_model_get_flags")]
		public virtual Gtk.TreeModelFlags get_flags ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_tree_model_get_iter")]
		public virtual bool get_iter (Gtk.TreeIter iter, Gtk.TreePath path);
		[NoArrayLength ()]
		[CCode (cname = "gtk_tree_model_get_iter_first")]
		public bool get_iter_first (Gtk.TreeIter iter);
		[NoArrayLength ()]
		[CCode (cname = "gtk_tree_model_get_iter_from_string")]
		public bool get_iter_from_string (Gtk.TreeIter iter, string path_string);
		[NoArrayLength ()]
		[CCode (cname = "gtk_tree_model_get_n_columns")]
		public virtual int get_n_columns ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_tree_model_get_path")]
		public virtual Gtk.TreePath get_path (Gtk.TreeIter iter);
		[NoArrayLength ()]
		[CCode (cname = "gtk_tree_model_get_string_from_iter")]
		public string get_string_from_iter (Gtk.TreeIter iter);
		[NoArrayLength ()]
		[CCode (cname = "gtk_tree_model_get_type")]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_tree_model_get_valist")]
		public void get_valist (Gtk.TreeIter iter, pointer var_args);
		[NoArrayLength ()]
		[CCode (cname = "gtk_tree_model_get_value")]
		public virtual void get_value (Gtk.TreeIter iter, int column, GLib.Value value);
		[NoArrayLength ()]
		[CCode (cname = "gtk_tree_model_iter_children")]
		public virtual bool iter_children (Gtk.TreeIter iter, Gtk.TreeIter parent);
		[NoArrayLength ()]
		[CCode (cname = "gtk_tree_model_iter_has_child")]
		public virtual bool iter_has_child (Gtk.TreeIter iter);
		[NoArrayLength ()]
		[CCode (cname = "gtk_tree_model_iter_n_children")]
		public virtual int iter_n_children (Gtk.TreeIter iter);
		[NoArrayLength ()]
		[CCode (cname = "gtk_tree_model_iter_next")]
		public virtual bool iter_next (Gtk.TreeIter iter);
		[NoArrayLength ()]
		[CCode (cname = "gtk_tree_model_iter_nth_child")]
		public virtual bool iter_nth_child (Gtk.TreeIter iter, Gtk.TreeIter parent, int n);
		[NoArrayLength ()]
		[CCode (cname = "gtk_tree_model_iter_parent")]
		public virtual bool iter_parent (Gtk.TreeIter iter, Gtk.TreeIter child);
		[NoArrayLength ()]
		[CCode (cname = "gtk_tree_model_ref_node")]
		public virtual void ref_node (Gtk.TreeIter iter);
		[NoArrayLength ()]
		[CCode (cname = "gtk_tree_model_unref_node")]
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
		[CCode (cname = "gtk_tree_sortable_get_sort_column_id")]
		public virtual bool get_sort_column_id (int sort_column_id, Gtk.SortType order);
		[NoArrayLength ()]
		[CCode (cname = "gtk_tree_sortable_get_type")]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_tree_sortable_has_default_sort_func")]
		public virtual bool has_default_sort_func ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_tree_sortable_set_default_sort_func")]
		public virtual void set_default_sort_func (Gtk.TreeIterCompareFunc sort_func, pointer user_data, Gtk.DestroyNotify destroy);
		[NoArrayLength ()]
		[CCode (cname = "gtk_tree_sortable_set_sort_column_id")]
		public virtual void set_sort_column_id (int sort_column_id, Gtk.SortType order);
		[NoArrayLength ()]
		[CCode (cname = "gtk_tree_sortable_set_sort_func")]
		public virtual void set_sort_func (int sort_column_id, Gtk.TreeIterCompareFunc sort_func, pointer user_data, Gtk.DestroyNotify destroy);
		[HasEmitter ()]
		public signal void sort_column_changed ();
	}
	[ReferenceType ()]
	public struct AccelGroupEntry {
		public weak Gtk.AccelKey key;
		public GLib.Closure closure;
		public GLib.Quark accel_path_quark;
	}
	[ReferenceType ()]
	public struct AccelKey {
		public uint accel_key;
		public Gdk.ModifierType accel_mods;
		public uint accel_flags;
	}
	public struct ActionEntry {
		public weak string name;
		public weak string stock_id;
		public weak string label;
		public weak string accelerator;
		public weak string tooltip;
		public GLib.Callback @callback;
	}
	[ReferenceType ()]
	public struct BindingArg {
		public GLib.Type arg_type;
		public long long_data;
	}
	[ReferenceType ()]
	public struct BindingEntry {
		public uint keyval;
		public Gdk.ModifierType modifiers;
		public weak Gtk.BindingSet binding_set;
		public uint destroyed;
		public uint in_emission;
		public weak Gtk.BindingEntry set_next;
		public weak Gtk.BindingEntry hash_next;
		public weak Gtk.BindingSignal signals;
		[NoArrayLength ()]
		[CCode (cname = "gtk_binding_entry_add_signal")]
		public static void add_signal (Gtk.BindingSet binding_set, uint keyval, Gdk.ModifierType modifiers, string signal_name, uint n_args);
		[NoArrayLength ()]
		[CCode (cname = "gtk_binding_entry_add_signall")]
		public static void add_signall (Gtk.BindingSet binding_set, uint keyval, Gdk.ModifierType modifiers, string signal_name, GLib.SList binding_args);
		[NoArrayLength ()]
		[CCode (cname = "gtk_binding_entry_clear")]
		public static void clear (Gtk.BindingSet binding_set, uint keyval, Gdk.ModifierType modifiers);
		[NoArrayLength ()]
		[CCode (cname = "gtk_binding_entry_remove")]
		public static void remove (Gtk.BindingSet binding_set, uint keyval, Gdk.ModifierType modifiers);
	}
	[ReferenceType ()]
	public struct BindingSet {
		public weak string set_name;
		public int priority;
		public weak GLib.SList widget_path_pspecs;
		public weak GLib.SList widget_class_pspecs;
		public weak GLib.SList class_branch_pspecs;
		public weak Gtk.BindingEntry entries;
		public weak Gtk.BindingEntry current;
		public uint parsed;
		[NoArrayLength ()]
		[CCode (cname = "gtk_binding_set_activate")]
		public bool activate (uint keyval, Gdk.ModifierType modifiers, Gtk.Object object);
		[NoArrayLength ()]
		[CCode (cname = "gtk_binding_set_add_path")]
		public void add_path (Gtk.PathType path_type, string path_pattern, Gtk.PathPriorityType priority);
		[NoArrayLength ()]
		[CCode (cname = "gtk_binding_set_by_class")]
		public static Gtk.BindingSet by_class (pointer object_class);
		[NoArrayLength ()]
		[CCode (cname = "gtk_binding_set_find")]
		public static Gtk.BindingSet find (string set_name);
		[NoArrayLength ()]
		[CCode (cname = "gtk_binding_set_new")]
		public construct (string set_name);
	}
	[ReferenceType ()]
	public struct BindingSignal {
		public weak Gtk.BindingSignal next;
		public weak string signal_name;
		public uint n_args;
		public weak Gtk.BindingArg args;
	}
	public struct Border {
		public int left;
		public int right;
		public int top;
		public int bottom;
		[NoArrayLength ()]
		[InstanceByReference ()]
		[CCode (cname = "gtk_border_copy")]
		public Gtk.Border copy ();
		[NoArrayLength ()]
		[InstanceByReference ()]
		[CCode (cname = "gtk_border_free")]
		public void free ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_border_get_type")]
		public static GLib.Type get_type ();
	}
	[ReferenceType ()]
	public struct BoxChild {
		public weak Gtk.Widget widget;
		public ushort padding;
		public uint expand;
		public uint fill;
		public uint pack;
		public uint is_secondary;
	}
	[ReferenceType ()]
	public struct FileFilterInfo {
		public Gtk.FileFilterFlags contains;
		public weak string filename;
		public weak string uri;
		public weak string display_name;
		public weak string mime_type;
	}
	[ReferenceType ()]
	public struct FixedChild {
		public weak Gtk.Widget widget;
		public int x;
		public int y;
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
		[CCode (cname = "gtk_icon_info_copy")]
		public Gtk.IconInfo copy ();
		[NoArrayLength ()]
		[InstanceByReference ()]
		[CCode (cname = "gtk_icon_info_free")]
		public void free ();
		[NoArrayLength ()]
		[InstanceByReference ()]
		[CCode (cname = "gtk_icon_info_get_attach_points")]
		public bool get_attach_points (Gdk.Point points, int n_points);
		[NoArrayLength ()]
		[InstanceByReference ()]
		[CCode (cname = "gtk_icon_info_get_base_size")]
		public int get_base_size ();
		[NoArrayLength ()]
		[InstanceByReference ()]
		[CCode (cname = "gtk_icon_info_get_builtin_pixbuf")]
		public Gdk.Pixbuf get_builtin_pixbuf ();
		[NoArrayLength ()]
		[InstanceByReference ()]
		[CCode (cname = "gtk_icon_info_get_display_name")]
		public string get_display_name ();
		[NoArrayLength ()]
		[InstanceByReference ()]
		[CCode (cname = "gtk_icon_info_get_embedded_rect")]
		public bool get_embedded_rect (Gdk.Rectangle rectangle);
		[NoArrayLength ()]
		[InstanceByReference ()]
		[CCode (cname = "gtk_icon_info_get_filename")]
		public string get_filename ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_icon_info_get_type")]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		[InstanceByReference ()]
		[CCode (cname = "gtk_icon_info_load_icon")]
		public Gdk.Pixbuf load_icon (GLib.Error error);
		[NoArrayLength ()]
		[InstanceByReference ()]
		[CCode (cname = "gtk_icon_info_set_raw_coordinates")]
		public void set_raw_coordinates (bool raw_coordinates);
	}
	public struct IconSet {
		[NoArrayLength ()]
		[InstanceByReference ()]
		[CCode (cname = "gtk_icon_set_add_source")]
		public void add_source (Gtk.IconSource source);
		[NoArrayLength ()]
		[InstanceByReference ()]
		[CCode (cname = "gtk_icon_set_copy")]
		public Gtk.IconSet copy ();
		[NoArrayLength ()]
		[InstanceByReference ()]
		[CCode (cname = "gtk_icon_set_get_sizes")]
		public void get_sizes (Gtk.IconSize sizes, int n_sizes);
		[NoArrayLength ()]
		[CCode (cname = "gtk_icon_set_get_type")]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_icon_set_new")]
		public construct ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_icon_set_new_from_pixbuf")]
		public construct from_pixbuf (Gdk.Pixbuf pixbuf);
		[NoArrayLength ()]
		[InstanceByReference ()]
		[CCode (cname = "gtk_icon_set_ref")]
		public Gtk.IconSet @ref ();
		[NoArrayLength ()]
		[InstanceByReference ()]
		[CCode (cname = "gtk_icon_set_render_icon")]
		public Gdk.Pixbuf render_icon (Gtk.Style style, Gtk.TextDirection direction, Gtk.StateType state, Gtk.IconSize size, Gtk.Widget widget, string detail);
		[NoArrayLength ()]
		[InstanceByReference ()]
		[CCode (cname = "gtk_icon_set_unref")]
		public void unref ();
	}
	public struct IconSource {
		[NoArrayLength ()]
		[InstanceByReference ()]
		[CCode (cname = "gtk_icon_source_copy")]
		public Gtk.IconSource copy ();
		[NoArrayLength ()]
		[InstanceByReference ()]
		[CCode (cname = "gtk_icon_source_free")]
		public void free ();
		[NoArrayLength ()]
		[InstanceByReference ()]
		[CCode (cname = "gtk_icon_source_get_direction")]
		public Gtk.TextDirection get_direction ();
		[NoArrayLength ()]
		[InstanceByReference ()]
		[CCode (cname = "gtk_icon_source_get_direction_wildcarded")]
		public bool get_direction_wildcarded ();
		[NoArrayLength ()]
		[InstanceByReference ()]
		[CCode (cname = "gtk_icon_source_get_filename")]
		public string get_filename ();
		[NoArrayLength ()]
		[InstanceByReference ()]
		[CCode (cname = "gtk_icon_source_get_icon_name")]
		public string get_icon_name ();
		[NoArrayLength ()]
		[InstanceByReference ()]
		[CCode (cname = "gtk_icon_source_get_pixbuf")]
		public Gdk.Pixbuf get_pixbuf ();
		[NoArrayLength ()]
		[InstanceByReference ()]
		[CCode (cname = "gtk_icon_source_get_size")]
		public Gtk.IconSize get_size ();
		[NoArrayLength ()]
		[InstanceByReference ()]
		[CCode (cname = "gtk_icon_source_get_size_wildcarded")]
		public bool get_size_wildcarded ();
		[NoArrayLength ()]
		[InstanceByReference ()]
		[CCode (cname = "gtk_icon_source_get_state")]
		public Gtk.StateType get_state ();
		[NoArrayLength ()]
		[InstanceByReference ()]
		[CCode (cname = "gtk_icon_source_get_state_wildcarded")]
		public bool get_state_wildcarded ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_icon_source_get_type")]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_icon_source_new")]
		public construct ();
		[NoArrayLength ()]
		[InstanceByReference ()]
		[CCode (cname = "gtk_icon_source_set_direction")]
		public void set_direction (Gtk.TextDirection direction);
		[NoArrayLength ()]
		[InstanceByReference ()]
		[CCode (cname = "gtk_icon_source_set_direction_wildcarded")]
		public void set_direction_wildcarded (bool setting);
		[NoArrayLength ()]
		[InstanceByReference ()]
		[CCode (cname = "gtk_icon_source_set_filename")]
		public void set_filename (string filename);
		[NoArrayLength ()]
		[InstanceByReference ()]
		[CCode (cname = "gtk_icon_source_set_icon_name")]
		public void set_icon_name (string icon_name);
		[NoArrayLength ()]
		[InstanceByReference ()]
		[CCode (cname = "gtk_icon_source_set_pixbuf")]
		public void set_pixbuf (Gdk.Pixbuf pixbuf);
		[NoArrayLength ()]
		[InstanceByReference ()]
		[CCode (cname = "gtk_icon_source_set_size")]
		public void set_size (Gtk.IconSize size);
		[NoArrayLength ()]
		[InstanceByReference ()]
		[CCode (cname = "gtk_icon_source_set_size_wildcarded")]
		public void set_size_wildcarded (bool setting);
		[NoArrayLength ()]
		[InstanceByReference ()]
		[CCode (cname = "gtk_icon_source_set_state")]
		public void set_state (Gtk.StateType state);
		[NoArrayLength ()]
		[InstanceByReference ()]
		[CCode (cname = "gtk_icon_source_set_state_wildcarded")]
		public void set_state_wildcarded (bool setting);
	}
	[ReferenceType ()]
	public struct ImageAnimationData {
		public weak Gdk.PixbufAnimation anim;
		public weak Gdk.PixbufAnimationIter iter;
		public uint frame_timeout;
	}
	[ReferenceType ()]
	public struct ImageIconNameData {
		public weak string icon_name;
		public weak Gdk.Pixbuf pixbuf;
		public uint theme_change_id;
	}
	[ReferenceType ()]
	public struct ImageIconSetData {
		public Gtk.IconSet icon_set;
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
		public Gtk.MenuCallback @callback;
		public pointer callback_data;
		public weak Gtk.Widget widget;
	}
	[ReferenceType ()]
	public struct MnemonicHash {
	}
	[ReferenceType ()]
	public struct NotebookPage {
		[NoArrayLength ()]
		[CCode (cname = "gtk_notebook_page_num")]
		public static int num (Gtk.Notebook notebook, Gtk.Widget child);
	}
	[ReferenceType ()]
	public struct PageRange {
		public int start;
		public int end;
	}
	public struct PaperSize {
		[NoArrayLength ()]
		[InstanceByReference ()]
		[CCode (cname = "gtk_paper_size_copy")]
		public Gtk.PaperSize copy ();
		[NoArrayLength ()]
		[InstanceByReference ()]
		[CCode (cname = "gtk_paper_size_free")]
		public void free ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_paper_size_get_default")]
		public static string get_default ();
		[NoArrayLength ()]
		[InstanceByReference ()]
		[CCode (cname = "gtk_paper_size_get_default_bottom_margin")]
		public double get_default_bottom_margin (Gtk.Unit unit);
		[NoArrayLength ()]
		[InstanceByReference ()]
		[CCode (cname = "gtk_paper_size_get_default_left_margin")]
		public double get_default_left_margin (Gtk.Unit unit);
		[NoArrayLength ()]
		[InstanceByReference ()]
		[CCode (cname = "gtk_paper_size_get_default_right_margin")]
		public double get_default_right_margin (Gtk.Unit unit);
		[NoArrayLength ()]
		[InstanceByReference ()]
		[CCode (cname = "gtk_paper_size_get_default_top_margin")]
		public double get_default_top_margin (Gtk.Unit unit);
		[NoArrayLength ()]
		[InstanceByReference ()]
		[CCode (cname = "gtk_paper_size_get_display_name")]
		public string get_display_name ();
		[NoArrayLength ()]
		[InstanceByReference ()]
		[CCode (cname = "gtk_paper_size_get_height")]
		public double get_height (Gtk.Unit unit);
		[NoArrayLength ()]
		[InstanceByReference ()]
		[CCode (cname = "gtk_paper_size_get_name")]
		public string get_name ();
		[NoArrayLength ()]
		[InstanceByReference ()]
		[CCode (cname = "gtk_paper_size_get_ppd_name")]
		public string get_ppd_name ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_paper_size_get_type")]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		[InstanceByReference ()]
		[CCode (cname = "gtk_paper_size_get_width")]
		public double get_width (Gtk.Unit unit);
		[NoArrayLength ()]
		[InstanceByReference ()]
		[CCode (cname = "gtk_paper_size_is_custom")]
		public bool is_custom ();
		[NoArrayLength ()]
		[InstanceByReference ()]
		[CCode (cname = "gtk_paper_size_is_equal")]
		public bool is_equal (Gtk.PaperSize size2);
		[NoArrayLength ()]
		[CCode (cname = "gtk_paper_size_new")]
		public construct (string name);
		[NoArrayLength ()]
		[CCode (cname = "gtk_paper_size_new_custom")]
		public construct custom (string name, string display_name, double width, double height, Gtk.Unit unit);
		[NoArrayLength ()]
		[CCode (cname = "gtk_paper_size_new_from_ppd")]
		public construct from_ppd (string ppd_name, string ppd_display_name, double width, double height);
		[NoArrayLength ()]
		[InstanceByReference ()]
		[CCode (cname = "gtk_paper_size_set_size")]
		public void set_size (double width, double height, Gtk.Unit unit);
	}
	[ReferenceType ()]
	public struct PrintWin32Devnames {
		public weak string driver;
		public weak string device;
		public weak string output;
		public int @flags;
		[NoArrayLength ()]
		[CCode (cname = "gtk_print_win32_devnames_free")]
		public void free ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_print_win32_devnames_from_printer_name")]
		public static pointer from_printer_name (string printer);
		[NoArrayLength ()]
		[CCode (cname = "gtk_print_win32_devnames_from_win32")]
		public static Gtk.PrintWin32Devnames from_win32 (pointer global);
		[NoArrayLength ()]
		[CCode (cname = "gtk_print_win32_devnames_to_win32")]
		public pointer to_win32 ();
	}
	public struct RadioActionEntry {
		public weak string name;
		public weak string stock_id;
		public weak string label;
		public weak string accelerator;
		public weak string tooltip;
		public int value;
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
		public GLib.Quark type_name;
		public GLib.Quark property_name;
		public weak string origin;
		public weak GLib.Value value;
		[NoArrayLength ()]
		[CCode (cname = "gtk_rc_property_parse_border")]
		public static bool parse_border (GLib.ParamSpec pspec, GLib.String gstring, GLib.Value property_value);
		[NoArrayLength ()]
		[CCode (cname = "gtk_rc_property_parse_color")]
		public static bool parse_color (GLib.ParamSpec pspec, GLib.String gstring, GLib.Value property_value);
		[NoArrayLength ()]
		[CCode (cname = "gtk_rc_property_parse_enum")]
		public static bool parse_enum (GLib.ParamSpec pspec, GLib.String gstring, GLib.Value property_value);
		[NoArrayLength ()]
		[CCode (cname = "gtk_rc_property_parse_flags")]
		public static bool parse_flags (GLib.ParamSpec pspec, GLib.String gstring, GLib.Value property_value);
		[NoArrayLength ()]
		[CCode (cname = "gtk_rc_property_parse_requisition")]
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
		public bool is_private;
	}
	[ReferenceType ()]
	public struct RecentFilterInfo {
		public Gtk.RecentFilterFlags contains;
		public weak string uri;
		public weak string display_name;
		public weak string mime_type;
		public weak string applications;
		public weak string groups;
		public int age;
	}
	public struct RecentInfo {
		[NoArrayLength ()]
		[InstanceByReference ()]
		[CCode (cname = "gtk_recent_info_exists")]
		public bool exists ();
		[NoArrayLength ()]
		[InstanceByReference ()]
		[CCode (cname = "gtk_recent_info_get_added")]
		public ulong get_added ();
		[NoArrayLength ()]
		[InstanceByReference ()]
		[CCode (cname = "gtk_recent_info_get_age")]
		public int get_age ();
		[NoArrayLength ()]
		[InstanceByReference ()]
		[CCode (cname = "gtk_recent_info_get_application_info")]
		public bool get_application_info (string app_name, string app_exec, uint count, ulong time_);
		[NoArrayLength ()]
		[InstanceByReference ()]
		[CCode (cname = "gtk_recent_info_get_applications")]
		public string get_applications (ulong length);
		[NoArrayLength ()]
		[InstanceByReference ()]
		[CCode (cname = "gtk_recent_info_get_description")]
		public string get_description ();
		[NoArrayLength ()]
		[InstanceByReference ()]
		[CCode (cname = "gtk_recent_info_get_display_name")]
		public string get_display_name ();
		[NoArrayLength ()]
		[InstanceByReference ()]
		[CCode (cname = "gtk_recent_info_get_groups")]
		public string get_groups (ulong length);
		[NoArrayLength ()]
		[InstanceByReference ()]
		[CCode (cname = "gtk_recent_info_get_icon")]
		public Gdk.Pixbuf get_icon (int size);
		[NoArrayLength ()]
		[InstanceByReference ()]
		[CCode (cname = "gtk_recent_info_get_mime_type")]
		public string get_mime_type ();
		[NoArrayLength ()]
		[InstanceByReference ()]
		[CCode (cname = "gtk_recent_info_get_modified")]
		public ulong get_modified ();
		[NoArrayLength ()]
		[InstanceByReference ()]
		[CCode (cname = "gtk_recent_info_get_private_hint")]
		public bool get_private_hint ();
		[NoArrayLength ()]
		[InstanceByReference ()]
		[CCode (cname = "gtk_recent_info_get_short_name")]
		public string get_short_name ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_recent_info_get_type")]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		[InstanceByReference ()]
		[CCode (cname = "gtk_recent_info_get_uri")]
		public string get_uri ();
		[NoArrayLength ()]
		[InstanceByReference ()]
		[CCode (cname = "gtk_recent_info_get_uri_display")]
		public string get_uri_display ();
		[NoArrayLength ()]
		[InstanceByReference ()]
		[CCode (cname = "gtk_recent_info_get_visited")]
		public ulong get_visited ();
		[NoArrayLength ()]
		[InstanceByReference ()]
		[CCode (cname = "gtk_recent_info_has_application")]
		public bool has_application (string app_name);
		[NoArrayLength ()]
		[InstanceByReference ()]
		[CCode (cname = "gtk_recent_info_has_group")]
		public bool has_group (string group_name);
		[NoArrayLength ()]
		[InstanceByReference ()]
		[CCode (cname = "gtk_recent_info_is_local")]
		public bool is_local ();
		[NoArrayLength ()]
		[InstanceByReference ()]
		[CCode (cname = "gtk_recent_info_last_application")]
		public string last_application ();
		[NoArrayLength ()]
		[InstanceByReference ()]
		[CCode (cname = "gtk_recent_info_match")]
		public bool match (Gtk.RecentInfo info_b);
		[NoArrayLength ()]
		[InstanceByReference ()]
		[CCode (cname = "gtk_recent_info_ref")]
		public Gtk.RecentInfo @ref ();
		[NoArrayLength ()]
		[InstanceByReference ()]
		[CCode (cname = "gtk_recent_info_unref")]
		public void unref ();
	}
	public struct Requisition {
		public int width;
		public int height;
		[NoArrayLength ()]
		[InstanceByReference ()]
		[CCode (cname = "gtk_requisition_copy")]
		public Gtk.Requisition copy ();
		[NoArrayLength ()]
		[InstanceByReference ()]
		[CCode (cname = "gtk_requisition_free")]
		public void free ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_requisition_get_type")]
		public static GLib.Type get_type ();
	}
	[ReferenceType ()]
	public struct RulerMetric {
		public weak string metric_name;
		public weak string abbrev;
		public double pixels_per_unit;
		public double ruler_scale;
		public int subdivide;
	}
	public struct SelectionData {
		public Gdk.Atom selection;
		public Gdk.Atom target;
		public Gdk.Atom type;
		public int format;
		public weak uchar[] data;
		public int length;
		public weak Gdk.Display display;
		[NoArrayLength ()]
		[InstanceByReference ()]
		[CCode (cname = "gtk_selection_data_copy")]
		public Gtk.SelectionData copy ();
		[NoArrayLength ()]
		[InstanceByReference ()]
		[CCode (cname = "gtk_selection_data_free")]
		public void free ();
		[NoArrayLength ()]
		[InstanceByReference ()]
		[CCode (cname = "gtk_selection_data_get_pixbuf")]
		public Gdk.Pixbuf get_pixbuf ();
		[NoArrayLength ()]
		[InstanceByReference ()]
		[CCode (cname = "gtk_selection_data_get_targets")]
		public bool get_targets (Gdk.Atom targets, int n_atoms);
		[NoArrayLength ()]
		[InstanceByReference ()]
		[CCode (cname = "gtk_selection_data_get_text")]
		public uchar[] get_text ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_selection_data_get_type")]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		[InstanceByReference ()]
		[CCode (cname = "gtk_selection_data_get_uris")]
		public string get_uris ();
		[NoArrayLength ()]
		[InstanceByReference ()]
		[CCode (cname = "gtk_selection_data_set")]
		public void @set (Gdk.Atom type, int format, uchar[] data, int length);
		[NoArrayLength ()]
		[InstanceByReference ()]
		[CCode (cname = "gtk_selection_data_set_pixbuf")]
		public bool set_pixbuf (Gdk.Pixbuf pixbuf);
		[NoArrayLength ()]
		[InstanceByReference ()]
		[CCode (cname = "gtk_selection_data_set_text")]
		public bool set_text (string str, int len);
		[NoArrayLength ()]
		[InstanceByReference ()]
		[CCode (cname = "gtk_selection_data_set_uris")]
		public bool set_uris (string uris);
		[NoArrayLength ()]
		[InstanceByReference ()]
		[CCode (cname = "gtk_selection_data_targets_include_image")]
		public bool targets_include_image (bool writable);
		[NoArrayLength ()]
		[InstanceByReference ()]
		[CCode (cname = "gtk_selection_data_targets_include_rich_text")]
		public bool targets_include_rich_text (Gtk.TextBuffer buffer);
		[NoArrayLength ()]
		[InstanceByReference ()]
		[CCode (cname = "gtk_selection_data_targets_include_text")]
		public bool targets_include_text ();
		[NoArrayLength ()]
		[InstanceByReference ()]
		[CCode (cname = "gtk_selection_data_targets_include_uri")]
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
		public Gdk.ModifierType modifier;
		public uint keyval;
		public weak string translation_domain;
		[NoArrayLength ()]
		[CCode (cname = "gtk_stock_item_copy")]
		public Gtk.StockItem copy ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_stock_item_free")]
		public void free ();
	}
	[ReferenceType ()]
	public struct TableChild {
		public weak Gtk.Widget widget;
		public ushort left_attach;
		public ushort right_attach;
		public ushort top_attach;
		public ushort bottom_attach;
		public ushort xpadding;
		public ushort ypadding;
		public uint xexpand;
		public uint yexpand;
		public uint xshrink;
		public uint yshrink;
		public uint xfill;
		public uint yfill;
	}
	[ReferenceType ()]
	public struct TableRowCol {
		public ushort requisition;
		public ushort allocation;
		public ushort spacing;
		public uint need_expand;
		public uint need_shrink;
		public uint expand;
		public uint shrink;
		public uint empty;
	}
	[ReferenceType ()]
	public struct TargetEntry {
		public weak string target;
		public uint @flags;
		public uint info;
	}
	public struct TargetList {
		public weak GLib.List list;
		public uint ref_count;
		[NoArrayLength ()]
		[InstanceByReference ()]
		[CCode (cname = "gtk_target_list_add")]
		public void add (Gdk.Atom target, uint @flags, uint info);
		[NoArrayLength ()]
		[InstanceByReference ()]
		[CCode (cname = "gtk_target_list_add_image_targets")]
		public void add_image_targets (uint info, bool writable);
		[NoArrayLength ()]
		[InstanceByReference ()]
		[CCode (cname = "gtk_target_list_add_rich_text_targets")]
		public void add_rich_text_targets (uint info, bool deserializable, Gtk.TextBuffer buffer);
		[NoArrayLength ()]
		[InstanceByReference ()]
		[CCode (cname = "gtk_target_list_add_table")]
		public void add_table (Gtk.TargetEntry targets, uint ntargets);
		[NoArrayLength ()]
		[InstanceByReference ()]
		[CCode (cname = "gtk_target_list_add_text_targets")]
		public void add_text_targets (uint info);
		[NoArrayLength ()]
		[InstanceByReference ()]
		[CCode (cname = "gtk_target_list_add_uri_targets")]
		public void add_uri_targets (uint info);
		[NoArrayLength ()]
		[InstanceByReference ()]
		[CCode (cname = "gtk_target_list_find")]
		public bool find (Gdk.Atom target, uint info);
		[NoArrayLength ()]
		[CCode (cname = "gtk_target_list_get_type")]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_target_list_new")]
		public construct (Gtk.TargetEntry targets, uint ntargets);
		[NoArrayLength ()]
		[InstanceByReference ()]
		[CCode (cname = "gtk_target_list_ref")]
		public Gtk.TargetList @ref ();
		[NoArrayLength ()]
		[InstanceByReference ()]
		[CCode (cname = "gtk_target_list_remove")]
		public void remove (Gdk.Atom target);
		[NoArrayLength ()]
		[InstanceByReference ()]
		[CCode (cname = "gtk_target_list_unref")]
		public void unref ();
	}
	[ReferenceType ()]
	public struct TargetPair {
		public Gdk.Atom target;
		public uint @flags;
		public uint info;
	}
	[ReferenceType ()]
	public struct TextAppearance {
		public Gdk.Color bg_color;
		public Gdk.Color fg_color;
		public weak Gdk.Bitmap bg_stipple;
		public weak Gdk.Bitmap fg_stipple;
		public int rise;
		public uint underline;
		public uint strikethrough;
		public uint draw_bg;
		public uint inside_selection;
		public uint is_text;
	}
	public struct TextAttributes {
		public weak Gtk.TextAppearance appearance;
		public Gtk.Justification justification;
		public Gtk.TextDirection direction;
		public Pango.FontDescription font;
		public double font_scale;
		public int left_margin;
		public int indent;
		public int right_margin;
		public int pixels_above_lines;
		public int pixels_below_lines;
		public int pixels_inside_wrap;
		public Pango.TabArray tabs;
		public Gtk.WrapMode wrap_mode;
		public Pango.Language language;
		public uint invisible;
		public uint bg_full_height;
		public uint editable;
		public uint realized;
		[NoArrayLength ()]
		[InstanceByReference ()]
		[CCode (cname = "gtk_text_attributes_copy")]
		public Gtk.TextAttributes copy ();
		[NoArrayLength ()]
		[InstanceByReference ()]
		[CCode (cname = "gtk_text_attributes_copy_values")]
		public void copy_values (Gtk.TextAttributes dest);
		[NoArrayLength ()]
		[CCode (cname = "gtk_text_attributes_get_type")]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_text_attributes_new")]
		public construct ();
		[NoArrayLength ()]
		[InstanceByReference ()]
		[CCode (cname = "gtk_text_attributes_ref")]
		public Gtk.TextAttributes @ref ();
		[NoArrayLength ()]
		[InstanceByReference ()]
		[CCode (cname = "gtk_text_attributes_unref")]
		public void unref ();
	}
	[ReferenceType ()]
	public struct TextBTree {
	}
	public struct TextIter {
		[NoArrayLength ()]
		[InstanceByReference ()]
		[CCode (cname = "gtk_text_iter_backward_char")]
		public bool backward_char ();
		[NoArrayLength ()]
		[InstanceByReference ()]
		[CCode (cname = "gtk_text_iter_backward_chars")]
		public bool backward_chars (int count);
		[NoArrayLength ()]
		[InstanceByReference ()]
		[CCode (cname = "gtk_text_iter_backward_cursor_position")]
		public bool backward_cursor_position ();
		[NoArrayLength ()]
		[InstanceByReference ()]
		[CCode (cname = "gtk_text_iter_backward_cursor_positions")]
		public bool backward_cursor_positions (int count);
		[NoArrayLength ()]
		[InstanceByReference ()]
		[CCode (cname = "gtk_text_iter_backward_find_char")]
		public bool backward_find_char (Gtk.TextCharPredicate pred, pointer user_data, Gtk.TextIter limit);
		[NoArrayLength ()]
		[InstanceByReference ()]
		[CCode (cname = "gtk_text_iter_backward_line")]
		public bool backward_line ();
		[NoArrayLength ()]
		[InstanceByReference ()]
		[CCode (cname = "gtk_text_iter_backward_lines")]
		public bool backward_lines (int count);
		[NoArrayLength ()]
		[InstanceByReference ()]
		[CCode (cname = "gtk_text_iter_backward_search")]
		public bool backward_search (string str, Gtk.TextSearchFlags @flags, Gtk.TextIter match_start, Gtk.TextIter match_end, Gtk.TextIter limit);
		[NoArrayLength ()]
		[InstanceByReference ()]
		[CCode (cname = "gtk_text_iter_backward_sentence_start")]
		public bool backward_sentence_start ();
		[NoArrayLength ()]
		[InstanceByReference ()]
		[CCode (cname = "gtk_text_iter_backward_sentence_starts")]
		public bool backward_sentence_starts (int count);
		[NoArrayLength ()]
		[InstanceByReference ()]
		[CCode (cname = "gtk_text_iter_backward_to_tag_toggle")]
		public bool backward_to_tag_toggle (Gtk.TextTag tag);
		[NoArrayLength ()]
		[InstanceByReference ()]
		[CCode (cname = "gtk_text_iter_backward_visible_cursor_position")]
		public bool backward_visible_cursor_position ();
		[NoArrayLength ()]
		[InstanceByReference ()]
		[CCode (cname = "gtk_text_iter_backward_visible_cursor_positions")]
		public bool backward_visible_cursor_positions (int count);
		[NoArrayLength ()]
		[InstanceByReference ()]
		[CCode (cname = "gtk_text_iter_backward_visible_line")]
		public bool backward_visible_line ();
		[NoArrayLength ()]
		[InstanceByReference ()]
		[CCode (cname = "gtk_text_iter_backward_visible_lines")]
		public bool backward_visible_lines (int count);
		[NoArrayLength ()]
		[InstanceByReference ()]
		[CCode (cname = "gtk_text_iter_backward_visible_word_start")]
		public bool backward_visible_word_start ();
		[NoArrayLength ()]
		[InstanceByReference ()]
		[CCode (cname = "gtk_text_iter_backward_visible_word_starts")]
		public bool backward_visible_word_starts (int count);
		[NoArrayLength ()]
		[InstanceByReference ()]
		[CCode (cname = "gtk_text_iter_backward_word_start")]
		public bool backward_word_start ();
		[NoArrayLength ()]
		[InstanceByReference ()]
		[CCode (cname = "gtk_text_iter_backward_word_starts")]
		public bool backward_word_starts (int count);
		[NoArrayLength ()]
		[InstanceByReference ()]
		[CCode (cname = "gtk_text_iter_begins_tag")]
		public bool begins_tag (Gtk.TextTag tag);
		[NoArrayLength ()]
		[InstanceByReference ()]
		[CCode (cname = "gtk_text_iter_can_insert")]
		public bool can_insert (bool default_editability);
		[NoArrayLength ()]
		[InstanceByReference ()]
		[CCode (cname = "gtk_text_iter_compare")]
		public int compare (Gtk.TextIter rhs);
		[NoArrayLength ()]
		[InstanceByReference ()]
		[CCode (cname = "gtk_text_iter_copy")]
		public Gtk.TextIter copy ();
		[NoArrayLength ()]
		[InstanceByReference ()]
		[CCode (cname = "gtk_text_iter_editable")]
		public bool editable (bool default_setting);
		[NoArrayLength ()]
		[InstanceByReference ()]
		[CCode (cname = "gtk_text_iter_ends_line")]
		public bool ends_line ();
		[NoArrayLength ()]
		[InstanceByReference ()]
		[CCode (cname = "gtk_text_iter_ends_sentence")]
		public bool ends_sentence ();
		[NoArrayLength ()]
		[InstanceByReference ()]
		[CCode (cname = "gtk_text_iter_ends_tag")]
		public bool ends_tag (Gtk.TextTag tag);
		[NoArrayLength ()]
		[InstanceByReference ()]
		[CCode (cname = "gtk_text_iter_ends_word")]
		public bool ends_word ();
		[NoArrayLength ()]
		[InstanceByReference ()]
		[CCode (cname = "gtk_text_iter_equal")]
		public bool equal (Gtk.TextIter rhs);
		[NoArrayLength ()]
		[InstanceByReference ()]
		[CCode (cname = "gtk_text_iter_forward_char")]
		public bool forward_char ();
		[NoArrayLength ()]
		[InstanceByReference ()]
		[CCode (cname = "gtk_text_iter_forward_chars")]
		public bool forward_chars (int count);
		[NoArrayLength ()]
		[InstanceByReference ()]
		[CCode (cname = "gtk_text_iter_forward_cursor_position")]
		public bool forward_cursor_position ();
		[NoArrayLength ()]
		[InstanceByReference ()]
		[CCode (cname = "gtk_text_iter_forward_cursor_positions")]
		public bool forward_cursor_positions (int count);
		[NoArrayLength ()]
		[InstanceByReference ()]
		[CCode (cname = "gtk_text_iter_forward_find_char")]
		public bool forward_find_char (Gtk.TextCharPredicate pred, pointer user_data, Gtk.TextIter limit);
		[NoArrayLength ()]
		[InstanceByReference ()]
		[CCode (cname = "gtk_text_iter_forward_line")]
		public bool forward_line ();
		[NoArrayLength ()]
		[InstanceByReference ()]
		[CCode (cname = "gtk_text_iter_forward_lines")]
		public bool forward_lines (int count);
		[NoArrayLength ()]
		[InstanceByReference ()]
		[CCode (cname = "gtk_text_iter_forward_search")]
		public bool forward_search (string str, Gtk.TextSearchFlags @flags, Gtk.TextIter match_start, Gtk.TextIter match_end, Gtk.TextIter limit);
		[NoArrayLength ()]
		[InstanceByReference ()]
		[CCode (cname = "gtk_text_iter_forward_sentence_end")]
		public bool forward_sentence_end ();
		[NoArrayLength ()]
		[InstanceByReference ()]
		[CCode (cname = "gtk_text_iter_forward_sentence_ends")]
		public bool forward_sentence_ends (int count);
		[NoArrayLength ()]
		[InstanceByReference ()]
		[CCode (cname = "gtk_text_iter_forward_to_end")]
		public void forward_to_end ();
		[NoArrayLength ()]
		[InstanceByReference ()]
		[CCode (cname = "gtk_text_iter_forward_to_line_end")]
		public bool forward_to_line_end ();
		[NoArrayLength ()]
		[InstanceByReference ()]
		[CCode (cname = "gtk_text_iter_forward_to_tag_toggle")]
		public bool forward_to_tag_toggle (Gtk.TextTag tag);
		[NoArrayLength ()]
		[InstanceByReference ()]
		[CCode (cname = "gtk_text_iter_forward_visible_cursor_position")]
		public bool forward_visible_cursor_position ();
		[NoArrayLength ()]
		[InstanceByReference ()]
		[CCode (cname = "gtk_text_iter_forward_visible_cursor_positions")]
		public bool forward_visible_cursor_positions (int count);
		[NoArrayLength ()]
		[InstanceByReference ()]
		[CCode (cname = "gtk_text_iter_forward_visible_line")]
		public bool forward_visible_line ();
		[NoArrayLength ()]
		[InstanceByReference ()]
		[CCode (cname = "gtk_text_iter_forward_visible_lines")]
		public bool forward_visible_lines (int count);
		[NoArrayLength ()]
		[InstanceByReference ()]
		[CCode (cname = "gtk_text_iter_forward_visible_word_end")]
		public bool forward_visible_word_end ();
		[NoArrayLength ()]
		[InstanceByReference ()]
		[CCode (cname = "gtk_text_iter_forward_visible_word_ends")]
		public bool forward_visible_word_ends (int count);
		[NoArrayLength ()]
		[InstanceByReference ()]
		[CCode (cname = "gtk_text_iter_forward_word_end")]
		public bool forward_word_end ();
		[NoArrayLength ()]
		[InstanceByReference ()]
		[CCode (cname = "gtk_text_iter_forward_word_ends")]
		public bool forward_word_ends (int count);
		[NoArrayLength ()]
		[InstanceByReference ()]
		[CCode (cname = "gtk_text_iter_free")]
		public void free ();
		[NoArrayLength ()]
		[InstanceByReference ()]
		[CCode (cname = "gtk_text_iter_get_attributes")]
		public bool get_attributes (Gtk.TextAttributes values);
		[NoArrayLength ()]
		[InstanceByReference ()]
		[CCode (cname = "gtk_text_iter_get_buffer")]
		public Gtk.TextBuffer get_buffer ();
		[NoArrayLength ()]
		[InstanceByReference ()]
		[CCode (cname = "gtk_text_iter_get_bytes_in_line")]
		public int get_bytes_in_line ();
		[NoArrayLength ()]
		[InstanceByReference ()]
		[CCode (cname = "gtk_text_iter_get_char")]
		public unichar get_char ();
		[NoArrayLength ()]
		[InstanceByReference ()]
		[CCode (cname = "gtk_text_iter_get_chars_in_line")]
		public int get_chars_in_line ();
		[NoArrayLength ()]
		[InstanceByReference ()]
		[CCode (cname = "gtk_text_iter_get_child_anchor")]
		public Gtk.TextChildAnchor get_child_anchor ();
		[NoArrayLength ()]
		[InstanceByReference ()]
		[CCode (cname = "gtk_text_iter_get_language")]
		public Pango.Language get_language ();
		[NoArrayLength ()]
		[InstanceByReference ()]
		[CCode (cname = "gtk_text_iter_get_line")]
		public int get_line ();
		[NoArrayLength ()]
		[InstanceByReference ()]
		[CCode (cname = "gtk_text_iter_get_line_index")]
		public int get_line_index ();
		[NoArrayLength ()]
		[InstanceByReference ()]
		[CCode (cname = "gtk_text_iter_get_line_offset")]
		public int get_line_offset ();
		[NoArrayLength ()]
		[InstanceByReference ()]
		[CCode (cname = "gtk_text_iter_get_marks")]
		public GLib.SList get_marks ();
		[NoArrayLength ()]
		[InstanceByReference ()]
		[CCode (cname = "gtk_text_iter_get_offset")]
		public int get_offset ();
		[NoArrayLength ()]
		[InstanceByReference ()]
		[CCode (cname = "gtk_text_iter_get_pixbuf")]
		public Gdk.Pixbuf get_pixbuf ();
		[NoArrayLength ()]
		[InstanceByReference ()]
		[CCode (cname = "gtk_text_iter_get_slice")]
		public string get_slice (Gtk.TextIter end);
		[NoArrayLength ()]
		[InstanceByReference ()]
		[CCode (cname = "gtk_text_iter_get_tags")]
		public GLib.SList get_tags ();
		[NoArrayLength ()]
		[InstanceByReference ()]
		[CCode (cname = "gtk_text_iter_get_text")]
		public string get_text (Gtk.TextIter end);
		[NoArrayLength ()]
		[InstanceByReference ()]
		[CCode (cname = "gtk_text_iter_get_toggled_tags")]
		public GLib.SList get_toggled_tags (bool toggled_on);
		[NoArrayLength ()]
		[CCode (cname = "gtk_text_iter_get_type")]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		[InstanceByReference ()]
		[CCode (cname = "gtk_text_iter_get_visible_line_index")]
		public int get_visible_line_index ();
		[NoArrayLength ()]
		[InstanceByReference ()]
		[CCode (cname = "gtk_text_iter_get_visible_line_offset")]
		public int get_visible_line_offset ();
		[NoArrayLength ()]
		[InstanceByReference ()]
		[CCode (cname = "gtk_text_iter_get_visible_slice")]
		public string get_visible_slice (Gtk.TextIter end);
		[NoArrayLength ()]
		[InstanceByReference ()]
		[CCode (cname = "gtk_text_iter_get_visible_text")]
		public string get_visible_text (Gtk.TextIter end);
		[NoArrayLength ()]
		[InstanceByReference ()]
		[CCode (cname = "gtk_text_iter_has_tag")]
		public bool has_tag (Gtk.TextTag tag);
		[NoArrayLength ()]
		[InstanceByReference ()]
		[CCode (cname = "gtk_text_iter_in_range")]
		public bool in_range (Gtk.TextIter start, Gtk.TextIter end);
		[NoArrayLength ()]
		[InstanceByReference ()]
		[CCode (cname = "gtk_text_iter_inside_sentence")]
		public bool inside_sentence ();
		[NoArrayLength ()]
		[InstanceByReference ()]
		[CCode (cname = "gtk_text_iter_inside_word")]
		public bool inside_word ();
		[NoArrayLength ()]
		[InstanceByReference ()]
		[CCode (cname = "gtk_text_iter_is_cursor_position")]
		public bool is_cursor_position ();
		[NoArrayLength ()]
		[InstanceByReference ()]
		[CCode (cname = "gtk_text_iter_is_end")]
		public bool is_end ();
		[NoArrayLength ()]
		[InstanceByReference ()]
		[CCode (cname = "gtk_text_iter_is_start")]
		public bool is_start ();
		[NoArrayLength ()]
		[InstanceByReference ()]
		[CCode (cname = "gtk_text_iter_order")]
		public void order (Gtk.TextIter second);
		[NoArrayLength ()]
		[InstanceByReference ()]
		[CCode (cname = "gtk_text_iter_set_line")]
		public void set_line (int line_number);
		[NoArrayLength ()]
		[InstanceByReference ()]
		[CCode (cname = "gtk_text_iter_set_line_index")]
		public void set_line_index (int byte_on_line);
		[NoArrayLength ()]
		[InstanceByReference ()]
		[CCode (cname = "gtk_text_iter_set_line_offset")]
		public void set_line_offset (int char_on_line);
		[NoArrayLength ()]
		[InstanceByReference ()]
		[CCode (cname = "gtk_text_iter_set_offset")]
		public void set_offset (int char_offset);
		[NoArrayLength ()]
		[InstanceByReference ()]
		[CCode (cname = "gtk_text_iter_set_visible_line_index")]
		public void set_visible_line_index (int byte_on_line);
		[NoArrayLength ()]
		[InstanceByReference ()]
		[CCode (cname = "gtk_text_iter_set_visible_line_offset")]
		public void set_visible_line_offset (int char_on_line);
		[NoArrayLength ()]
		[InstanceByReference ()]
		[CCode (cname = "gtk_text_iter_starts_line")]
		public bool starts_line ();
		[NoArrayLength ()]
		[InstanceByReference ()]
		[CCode (cname = "gtk_text_iter_starts_sentence")]
		public bool starts_sentence ();
		[NoArrayLength ()]
		[InstanceByReference ()]
		[CCode (cname = "gtk_text_iter_starts_word")]
		public bool starts_word ();
		[NoArrayLength ()]
		[InstanceByReference ()]
		[CCode (cname = "gtk_text_iter_toggles_tag")]
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
		public GLib.Callback @callback;
		public bool is_active;
	}
	[ReferenceType ()]
	public struct TooltipsData {
		public weak Gtk.Tooltips tooltips;
		public weak Gtk.Widget widget;
		public weak string tip_text;
		public weak string tip_private;
		[NoArrayLength ()]
		[CCode (cname = "gtk_tooltips_data_get")]
		public static Gtk.TooltipsData @get (Gtk.Widget widget);
	}
	public struct TreeIter {
		public int stamp;
		public pointer user_data;
		public pointer user_data2;
		public pointer user_data3;
		[NoArrayLength ()]
		[InstanceByReference ()]
		[CCode (cname = "gtk_tree_iter_copy")]
		public Gtk.TreeIter copy ();
		[NoArrayLength ()]
		[InstanceByReference ()]
		[CCode (cname = "gtk_tree_iter_free")]
		public void free ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_tree_iter_get_type")]
		public static GLib.Type get_type ();
	}
	[ReferenceType ()]
	public struct TreePath {
		[NoArrayLength ()]
		[CCode (cname = "gtk_tree_path_append_index")]
		public void append_index (int index_);
		[NoArrayLength ()]
		[CCode (cname = "gtk_tree_path_compare")]
		public int compare (Gtk.TreePath b);
		[NoArrayLength ()]
		[CCode (cname = "gtk_tree_path_copy")]
		public Gtk.TreePath copy ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_tree_path_down")]
		public void down ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_tree_path_free")]
		public void free ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_tree_path_get_depth")]
		public int get_depth ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_tree_path_get_indices")]
		public int[] get_indices ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_tree_path_get_type")]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_tree_path_is_ancestor")]
		public bool is_ancestor (Gtk.TreePath descendant);
		[NoArrayLength ()]
		[CCode (cname = "gtk_tree_path_is_descendant")]
		public bool is_descendant (Gtk.TreePath ancestor);
		[NoArrayLength ()]
		[CCode (cname = "gtk_tree_path_new")]
		public construct ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_tree_path_new_first")]
		public construct first ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_tree_path_new_from_indices")]
		public construct from_indices (int first_index);
		[NoArrayLength ()]
		[CCode (cname = "gtk_tree_path_new_from_string")]
		public construct from_string (string path);
		[NoArrayLength ()]
		[CCode (cname = "gtk_tree_path_next")]
		public void next ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_tree_path_prepend_index")]
		public void prepend_index (int index_);
		[NoArrayLength ()]
		[CCode (cname = "gtk_tree_path_prev")]
		public bool prev ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_tree_path_to_string")]
		public string to_string ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_tree_path_up")]
		public bool up ();
	}
	public struct TreeRowReference {
		[NoArrayLength ()]
		[InstanceByReference ()]
		[CCode (cname = "gtk_tree_row_reference_copy")]
		public Gtk.TreeRowReference copy ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_tree_row_reference_deleted")]
		public static void deleted (GLib.Object proxy, Gtk.TreePath path);
		[NoArrayLength ()]
		[InstanceByReference ()]
		[CCode (cname = "gtk_tree_row_reference_free")]
		public void free ();
		[NoArrayLength ()]
		[InstanceByReference ()]
		[CCode (cname = "gtk_tree_row_reference_get_model")]
		public Gtk.TreeModel get_model ();
		[NoArrayLength ()]
		[InstanceByReference ()]
		[CCode (cname = "gtk_tree_row_reference_get_path")]
		public Gtk.TreePath get_path ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_tree_row_reference_get_type")]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_tree_row_reference_inserted")]
		public static void inserted (GLib.Object proxy, Gtk.TreePath path);
		[NoArrayLength ()]
		[CCode (cname = "gtk_tree_row_reference_new")]
		public construct (Gtk.TreeModel model, Gtk.TreePath path);
		[NoArrayLength ()]
		[CCode (cname = "gtk_tree_row_reference_new_proxy")]
		public construct proxy (GLib.Object proxy, Gtk.TreeModel model, Gtk.TreePath path);
		[NoArrayLength ()]
		[CCode (cname = "gtk_tree_row_reference_reordered")]
		public static void reordered (GLib.Object proxy, Gtk.TreePath path, Gtk.TreeIter iter, int new_order);
		[NoArrayLength ()]
		[InstanceByReference ()]
		[CCode (cname = "gtk_tree_row_reference_valid")]
		public bool valid ();
	}
	[ReferenceType ()]
	public struct WidgetAuxInfo {
		public int x;
		public int y;
		public int width;
		public int height;
		public uint x_set;
		public uint y_set;
	}
	[ReferenceType ()]
	public struct WidgetShapeInfo {
		public short offset_x;
		public short offset_y;
		public weak Gdk.Bitmap shape_mask;
	}
	[ReferenceType ()]
	public struct WindowGeometryInfo {
	}
	[ReferenceType ()]
	public struct Accel {
		[NoArrayLength ()]
		[CCode (cname = "gtk_accel_groups_activate")]
		public static bool groups_activate (GLib.Object object, uint accel_key, Gdk.ModifierType accel_mods);
		[NoArrayLength ()]
		[CCode (cname = "gtk_accel_groups_from_object")]
		public static GLib.SList groups_from_object (GLib.Object object);
	}
	[ReferenceType ()]
	public struct Accelerator {
		[NoArrayLength ()]
		[CCode (cname = "gtk_accelerator_get_default_mod_mask")]
		public static uint get_default_mod_mask ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_accelerator_get_label")]
		public static string get_label (uint accelerator_key, Gdk.ModifierType accelerator_mods);
		[NoArrayLength ()]
		[CCode (cname = "gtk_accelerator_name")]
		public static string name (uint accelerator_key, Gdk.ModifierType accelerator_mods);
		[NoArrayLength ()]
		[CCode (cname = "gtk_accelerator_parse")]
		public static void parse (string accelerator, uint accelerator_key, Gdk.ModifierType accelerator_mods);
		[NoArrayLength ()]
		[CCode (cname = "gtk_accelerator_set_default_mod_mask")]
		public static void set_default_mod_mask (Gdk.ModifierType default_mod_mask);
		[NoArrayLength ()]
		[CCode (cname = "gtk_accelerator_valid")]
		public static bool valid (uint keyval, Gdk.ModifierType modifiers);
	}
	[ReferenceType ()]
	public struct Bindings {
		[NoArrayLength ()]
		[CCode (cname = "gtk_bindings_activate")]
		public static bool activate (Gtk.Object object, uint keyval, Gdk.ModifierType modifiers);
		[NoArrayLength ()]
		[CCode (cname = "gtk_bindings_activate_event")]
		public static bool activate_event (Gtk.Object object, Gdk.EventKey event);
	}
	[ReferenceType ()]
	public struct Ctree {
		[NoArrayLength ()]
		[CCode (cname = "gtk_ctree_expander_style_get_type")]
		public static GLib.Type expander_style_get_type ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_ctree_expansion_type_get_type")]
		public static GLib.Type expansion_type_get_type ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_ctree_line_style_get_type")]
		public static GLib.Type line_style_get_type ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_ctree_pos_get_type")]
		public static GLib.Type pos_get_type ();
	}
	[ReferenceType ()]
	public struct Drag {
		[NoArrayLength ()]
		[CCode (cname = "gtk_drag_begin")]
		public static Gdk.DragContext begin (Gtk.Widget widget, Gtk.TargetList targets, Gdk.DragAction actions, int button, Gdk.Event event);
		[NoArrayLength ()]
		[CCode (cname = "gtk_drag_check_threshold")]
		public static bool check_threshold (Gtk.Widget widget, int start_x, int start_y, int current_x, int current_y);
		[NoArrayLength ()]
		[CCode (cname = "gtk_drag_dest_add_image_targets")]
		public static void dest_add_image_targets (Gtk.Widget widget);
		[NoArrayLength ()]
		[CCode (cname = "gtk_drag_dest_add_text_targets")]
		public static void dest_add_text_targets (Gtk.Widget widget);
		[NoArrayLength ()]
		[CCode (cname = "gtk_drag_dest_add_uri_targets")]
		public static void dest_add_uri_targets (Gtk.Widget widget);
		[NoArrayLength ()]
		[CCode (cname = "gtk_drag_dest_find_target")]
		public static Gdk.Atom dest_find_target (Gtk.Widget widget, Gdk.DragContext context, Gtk.TargetList target_list);
		[NoArrayLength ()]
		[CCode (cname = "gtk_drag_dest_get_target_list")]
		public static Gtk.TargetList dest_get_target_list (Gtk.Widget widget);
		[NoArrayLength ()]
		[CCode (cname = "gtk_drag_dest_get_track_motion")]
		public static bool dest_get_track_motion (Gtk.Widget widget);
		[NoArrayLength ()]
		[CCode (cname = "gtk_drag_dest_set")]
		public static void dest_set (Gtk.Widget widget, Gtk.DestDefaults @flags, Gtk.TargetEntry targets, int n_targets, Gdk.DragAction actions);
		[NoArrayLength ()]
		[CCode (cname = "gtk_drag_dest_set_proxy")]
		public static void dest_set_proxy (Gtk.Widget widget, Gdk.Window proxy_window, Gdk.DragProtocol protocol, bool use_coordinates);
		[NoArrayLength ()]
		[CCode (cname = "gtk_drag_dest_set_target_list")]
		public static void dest_set_target_list (Gtk.Widget widget, Gtk.TargetList target_list);
		[NoArrayLength ()]
		[CCode (cname = "gtk_drag_dest_set_track_motion")]
		public static void dest_set_track_motion (Gtk.Widget widget, bool track_motion);
		[NoArrayLength ()]
		[CCode (cname = "gtk_drag_dest_unset")]
		public static void dest_unset (Gtk.Widget widget);
		[NoArrayLength ()]
		[CCode (cname = "gtk_drag_finish")]
		public static void finish (Gdk.DragContext context, bool success, bool del, uint time_);
		[NoArrayLength ()]
		[CCode (cname = "gtk_drag_get_data")]
		public static void get_data (Gtk.Widget widget, Gdk.DragContext context, Gdk.Atom target, uint time_);
		[NoArrayLength ()]
		[CCode (cname = "gtk_drag_get_source_widget")]
		public static Gtk.Widget get_source_widget (Gdk.DragContext context);
		[NoArrayLength ()]
		[CCode (cname = "gtk_drag_highlight")]
		public static void highlight (Gtk.Widget widget);
		[NoArrayLength ()]
		[CCode (cname = "gtk_drag_set_icon_default")]
		public static void set_icon_default (Gdk.DragContext context);
		[NoArrayLength ()]
		[CCode (cname = "gtk_drag_set_icon_name")]
		public static void set_icon_name (Gdk.DragContext context, string icon_name, int hot_x, int hot_y);
		[NoArrayLength ()]
		[CCode (cname = "gtk_drag_set_icon_pixbuf")]
		public static void set_icon_pixbuf (Gdk.DragContext context, Gdk.Pixbuf pixbuf, int hot_x, int hot_y);
		[NoArrayLength ()]
		[CCode (cname = "gtk_drag_set_icon_pixmap")]
		public static void set_icon_pixmap (Gdk.DragContext context, Gdk.Colormap colormap, Gdk.Pixmap pixmap, Gdk.Bitmap mask, int hot_x, int hot_y);
		[NoArrayLength ()]
		[CCode (cname = "gtk_drag_set_icon_stock")]
		public static void set_icon_stock (Gdk.DragContext context, string stock_id, int hot_x, int hot_y);
		[NoArrayLength ()]
		[CCode (cname = "gtk_drag_set_icon_widget")]
		public static void set_icon_widget (Gdk.DragContext context, Gtk.Widget widget, int hot_x, int hot_y);
		[NoArrayLength ()]
		[CCode (cname = "gtk_drag_source_add_image_targets")]
		public static void source_add_image_targets (Gtk.Widget widget);
		[NoArrayLength ()]
		[CCode (cname = "gtk_drag_source_add_text_targets")]
		public static void source_add_text_targets (Gtk.Widget widget);
		[NoArrayLength ()]
		[CCode (cname = "gtk_drag_source_add_uri_targets")]
		public static void source_add_uri_targets (Gtk.Widget widget);
		[NoArrayLength ()]
		[CCode (cname = "gtk_drag_source_get_target_list")]
		public static Gtk.TargetList source_get_target_list (Gtk.Widget widget);
		[NoArrayLength ()]
		[CCode (cname = "gtk_drag_source_set")]
		public static void source_set (Gtk.Widget widget, Gdk.ModifierType start_button_mask, Gtk.TargetEntry targets, int n_targets, Gdk.DragAction actions);
		[NoArrayLength ()]
		[CCode (cname = "gtk_drag_source_set_icon")]
		public static void source_set_icon (Gtk.Widget widget, Gdk.Colormap colormap, Gdk.Pixmap pixmap, Gdk.Bitmap mask);
		[NoArrayLength ()]
		[CCode (cname = "gtk_drag_source_set_icon_name")]
		public static void source_set_icon_name (Gtk.Widget widget, string icon_name);
		[NoArrayLength ()]
		[CCode (cname = "gtk_drag_source_set_icon_pixbuf")]
		public static void source_set_icon_pixbuf (Gtk.Widget widget, Gdk.Pixbuf pixbuf);
		[NoArrayLength ()]
		[CCode (cname = "gtk_drag_source_set_icon_stock")]
		public static void source_set_icon_stock (Gtk.Widget widget, string stock_id);
		[NoArrayLength ()]
		[CCode (cname = "gtk_drag_source_set_target_list")]
		public static void source_set_target_list (Gtk.Widget widget, Gtk.TargetList target_list);
		[NoArrayLength ()]
		[CCode (cname = "gtk_drag_source_unset")]
		public static void source_unset (Gtk.Widget widget);
		[NoArrayLength ()]
		[CCode (cname = "gtk_drag_unhighlight")]
		public static void unhighlight (Gtk.Widget widget);
	}
	[ReferenceType ()]
	public struct Draw {
		[NoArrayLength ()]
		[CCode (cname = "gtk_draw_insertion_cursor")]
		public static void insertion_cursor (Gtk.Widget widget, Gdk.Drawable drawable, Gdk.Rectangle area, Gdk.Rectangle location, bool is_primary, Gtk.TextDirection direction, bool draw_arrow);
	}
	[ReferenceType ()]
	public struct Gc {
		[NoArrayLength ()]
		[CCode (cname = "gtk_gc_get")]
		public static Gdk.GC @get (int depth, Gdk.Colormap colormap, Gdk.GCValues values, Gdk.GCValuesMask values_mask);
		[NoArrayLength ()]
		[CCode (cname = "gtk_gc_release")]
		public static void release (Gdk.GC gc);
	}
	[ReferenceType ()]
	public struct Grab {
		[NoArrayLength ()]
		[CCode (cname = "gtk_grab_add")]
		public static void add (Gtk.Widget widget);
		[NoArrayLength ()]
		[CCode (cname = "gtk_grab_get_current")]
		public static Gtk.Widget get_current ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_grab_remove")]
		public static void remove (Gtk.Widget widget);
	}
	[ReferenceType ()]
	public struct Icon {
		[NoArrayLength ()]
		[CCode (cname = "gtk_icon_size_from_name")]
		public static Gtk.IconSize size_from_name (string name);
		[NoArrayLength ()]
		[CCode (cname = "gtk_icon_size_get_name")]
		public static string size_get_name (Gtk.IconSize size);
		[NoArrayLength ()]
		[CCode (cname = "gtk_icon_size_lookup")]
		public static bool size_lookup (Gtk.IconSize size, int width, int height);
		[NoArrayLength ()]
		[CCode (cname = "gtk_icon_size_lookup_for_settings")]
		public static bool size_lookup_for_settings (Gtk.Settings settings, Gtk.IconSize size, int width, int height);
		[NoArrayLength ()]
		[CCode (cname = "gtk_icon_size_register")]
		public static Gtk.IconSize size_register (string name, int width, int height);
		[NoArrayLength ()]
		[CCode (cname = "gtk_icon_size_register_alias")]
		public static void size_register_alias (string alias, Gtk.IconSize target);
	}
	[ReferenceType ()]
	public struct Idle {
	}
	[ReferenceType ()]
	public struct Init {
		[NoArrayLength ()]
		[CCode (cname = "gtk_init_abi_check")]
		public static void abi_check (int argc, string argv, int num_checks, ulong sizeof_GtkWindow, ulong sizeof_GtkBox);
		[NoArrayLength ()]
		[CCode (cname = "gtk_init_add")]
		public static void add (Gtk.Function function, pointer data);
		[NoArrayLength ()]
		[CCode (cname = "gtk_init_check")]
		public static bool check (int argc, string argv);
		[NoArrayLength ()]
		[CCode (cname = "gtk_init_check_abi_check")]
		public static bool check_abi_check (int argc, string argv, int num_checks, ulong sizeof_GtkWindow, ulong sizeof_GtkBox);
		[NoArrayLength ()]
		[CCode (cname = "gtk_init_with_args")]
		public static bool with_args (int argc, string argv, string parameter_string, GLib.OptionEntry entries, string translation_domain, GLib.Error error);
	}
	[ReferenceType ()]
	public struct Input {
	}
	[ReferenceType ()]
	public struct Key {
		[NoArrayLength ()]
		[CCode (cname = "gtk_key_snooper_install")]
		public static uint snooper_install (Gtk.KeySnoopFunc snooper, pointer func_data);
		[NoArrayLength ()]
		[CCode (cname = "gtk_key_snooper_remove")]
		public static void snooper_remove (uint snooper_handler_id);
	}
	[ReferenceType ()]
	public struct Main {
		[NoArrayLength ()]
		[CCode (cname = "gtk_main_do_event")]
		public static void do_event (Gdk.Event event);
		[NoArrayLength ()]
		[CCode (cname = "gtk_main_iteration")]
		public static bool iteration ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_main_iteration_do")]
		public static bool iteration_do (bool blocking);
		[NoArrayLength ()]
		[CCode (cname = "gtk_main_level")]
		public static uint level ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_main_quit")]
		public static void quit ();
	}
	[ReferenceType ()]
	public struct Print {
		[NoArrayLength ()]
		[CCode (cname = "gtk_print_error_quark")]
		public static GLib.Quark error_quark ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_print_run_page_setup_dialog")]
		public static Gtk.PageSetup run_page_setup_dialog (Gtk.Window parent, Gtk.PageSetup page_setup, Gtk.PrintSettings settings);
		[NoArrayLength ()]
		[CCode (cname = "gtk_print_run_page_setup_dialog_async")]
		public static void run_page_setup_dialog_async (Gtk.Window parent, Gtk.PageSetup page_setup, Gtk.PrintSettings settings, Gtk.PageSetupDoneFunc done_cb, pointer data);
	}
	[ReferenceType ()]
	public struct Quit {
		[NoArrayLength ()]
		[CCode (cname = "gtk_quit_add")]
		public static uint add (uint main_level, Gtk.Function function, pointer data);
		[NoArrayLength ()]
		[CCode (cname = "gtk_quit_add_destroy")]
		public static void add_destroy (uint main_level, Gtk.Object object);
		[NoArrayLength ()]
		[CCode (cname = "gtk_quit_remove")]
		public static void remove (uint quit_handler_id);
		[NoArrayLength ()]
		[CCode (cname = "gtk_quit_remove_by_data")]
		public static void remove_by_data (pointer data);
	}
	[ReferenceType ()]
	public struct Rc {
		[NoArrayLength ()]
		[CCode (cname = "gtk_rc_add_default_file")]
		public static void add_default_file (string filename);
		[NoArrayLength ()]
		[CCode (cname = "gtk_rc_find_module_in_path")]
		public static string find_module_in_path (string module_file);
		[NoArrayLength ()]
		[CCode (cname = "gtk_rc_find_pixmap_in_path")]
		public static string find_pixmap_in_path (Gtk.Settings settings, GLib.Scanner scanner, string pixmap_file);
		[NoArrayLength ()]
		[CCode (cname = "gtk_rc_get_default_files")]
		public static string get_default_files ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_rc_get_im_module_file")]
		public static string get_im_module_file ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_rc_get_im_module_path")]
		public static string get_im_module_path ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_rc_get_module_dir")]
		public static string get_module_dir ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_rc_get_style")]
		public static Gtk.Style get_style (Gtk.Widget widget);
		[NoArrayLength ()]
		[CCode (cname = "gtk_rc_get_style_by_paths")]
		public static Gtk.Style get_style_by_paths (Gtk.Settings settings, string widget_path, string class_path, GLib.Type type);
		[NoArrayLength ()]
		[CCode (cname = "gtk_rc_get_theme_dir")]
		public static string get_theme_dir ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_rc_parse")]
		public static void parse (string filename);
		[NoArrayLength ()]
		[CCode (cname = "gtk_rc_parse_color")]
		public static uint parse_color (GLib.Scanner scanner, Gdk.Color color);
		[NoArrayLength ()]
		[CCode (cname = "gtk_rc_parse_priority")]
		public static uint parse_priority (GLib.Scanner scanner, Gtk.PathPriorityType priority);
		[NoArrayLength ()]
		[CCode (cname = "gtk_rc_parse_state")]
		public static uint parse_state (GLib.Scanner scanner, Gtk.StateType state);
		[NoArrayLength ()]
		[CCode (cname = "gtk_rc_parse_string")]
		public static void parse_string (string rc_string);
		[NoArrayLength ()]
		[CCode (cname = "gtk_rc_reparse_all")]
		public static bool reparse_all ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_rc_reparse_all_for_settings")]
		public static bool reparse_all_for_settings (Gtk.Settings settings, bool force_load);
		[NoArrayLength ()]
		[CCode (cname = "gtk_rc_reset_styles")]
		public static void reset_styles (Gtk.Settings settings);
		[NoArrayLength ()]
		[CCode (cname = "gtk_rc_scanner_new")]
		public static GLib.Scanner scanner_new ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_rc_set_default_files")]
		public static void set_default_files (string filenames);
	}
	[ReferenceType ()]
	public struct Selection {
		[NoArrayLength ()]
		[CCode (cname = "gtk_selection_add_target")]
		public static void add_target (Gtk.Widget widget, Gdk.Atom selection, Gdk.Atom target, uint info);
		[NoArrayLength ()]
		[CCode (cname = "gtk_selection_add_targets")]
		public static void add_targets (Gtk.Widget widget, Gdk.Atom selection, Gtk.TargetEntry targets, uint ntargets);
		[NoArrayLength ()]
		[CCode (cname = "gtk_selection_clear_targets")]
		public static void clear_targets (Gtk.Widget widget, Gdk.Atom selection);
		[NoArrayLength ()]
		[CCode (cname = "gtk_selection_convert")]
		public static bool convert (Gtk.Widget widget, Gdk.Atom selection, Gdk.Atom target, uint time_);
		[NoArrayLength ()]
		[CCode (cname = "gtk_selection_owner_set")]
		public static bool owner_set (Gtk.Widget widget, Gdk.Atom selection, uint time_);
		[NoArrayLength ()]
		[CCode (cname = "gtk_selection_owner_set_for_display")]
		public static bool owner_set_for_display (Gdk.Display display, Gtk.Widget widget, Gdk.Atom selection, uint time_);
		[NoArrayLength ()]
		[CCode (cname = "gtk_selection_remove_all")]
		public static void remove_all (Gtk.Widget widget);
	}
	[ReferenceType ()]
	public struct Signal {
	}
	[ReferenceType ()]
	public struct Stock {
		[NoArrayLength ()]
		[CCode (cname = "gtk_stock_add")]
		public static void add (Gtk.StockItem items, uint n_items);
		[NoArrayLength ()]
		[CCode (cname = "gtk_stock_add_static")]
		public static void add_static (Gtk.StockItem items, uint n_items);
		[NoArrayLength ()]
		[CCode (cname = "gtk_stock_list_ids")]
		public static GLib.SList list_ids ();
		[NoArrayLength ()]
		[CCode (cname = "gtk_stock_lookup")]
		public static bool lookup (string stock_id, Gtk.StockItem item);
		[NoArrayLength ()]
		[CCode (cname = "gtk_stock_set_translate_func")]
		public static void set_translate_func (string domain, Gtk.TranslateFunc func, pointer data, Gtk.DestroyNotify notify);
	}
	[ReferenceType ()]
	public struct Target {
		[NoArrayLength ()]
		[CCode (cname = "gtk_target_table_free")]
		public static void table_free (Gtk.TargetEntry targets, int n_targets);
		[NoArrayLength ()]
		[CCode (cname = "gtk_target_table_new_from_list")]
		public static Gtk.TargetEntry table_new_from_list (Gtk.TargetList list, int n_targets);
	}
	[ReferenceType ()]
	public struct Targets {
		[NoArrayLength ()]
		[CCode (cname = "gtk_targets_include_image")]
		public static bool include_image (Gdk.Atom targets, int n_targets, bool writable);
		[NoArrayLength ()]
		[CCode (cname = "gtk_targets_include_rich_text")]
		public static bool include_rich_text (Gdk.Atom targets, int n_targets, Gtk.TextBuffer buffer);
		[NoArrayLength ()]
		[CCode (cname = "gtk_targets_include_text")]
		public static bool include_text (Gdk.Atom targets, int n_targets);
		[NoArrayLength ()]
		[CCode (cname = "gtk_targets_include_uri")]
		public static bool include_uri (Gdk.Atom targets, int n_targets);
	}
	[ReferenceType ()]
	public struct Timeout {
	}
	[ReferenceType ()]
	public struct Tree {
		[NoArrayLength ()]
		[CCode (cname = "gtk_tree_get_row_drag_data")]
		public static bool get_row_drag_data (Gtk.SelectionData selection_data, Gtk.TreeModel tree_model, Gtk.TreePath path);
		[NoArrayLength ()]
		[CCode (cname = "gtk_tree_set_row_drag_data")]
		public static bool set_row_drag_data (Gtk.SelectionData selection_data, Gtk.TreeModel tree_model, Gtk.TreePath path);
	}
	[ReferenceType ()]
	public struct Type {
		[NoArrayLength ()]
		[CCode (cname = "gtk_type_class")]
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
	public callback void ClipboardRichTextReceivedFunc (Gtk.Clipboard clipboard, Gdk.Atom format, uchar[] text, ulong length, pointer data);
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
	public callback bool TextBufferDeserializeFunc (Gtk.TextBuffer register_buffer, Gtk.TextBuffer content_buffer, Gtk.TextIter iter, uchar[] data, ulong length, bool create_tags, pointer user_data, GLib.Error error);
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
	[CCode (cname = "gtk_alternative_dialog_button_order")]
	public static bool alternative_dialog_button_order (Gdk.Screen screen);
	[NoArrayLength ()]
	[CCode (cname = "gtk_binding_parse_binding")]
	public static uint binding_parse_binding (GLib.Scanner scanner);
	[NoArrayLength ()]
	[CCode (cname = "gtk_cell_type_get_type")]
	public static GLib.Type cell_type_get_type ();
	[NoArrayLength ()]
	[CCode (cname = "gtk_check_version")]
	public static string check_version (uint required_major, uint required_minor, uint required_micro);
	[NoArrayLength ()]
	[CCode (cname = "gtk_clist_drag_pos_get_type")]
	public static GLib.Type clist_drag_pos_get_type ();
	[NoArrayLength ()]
	[CCode (cname = "gtk_disable_setlocale")]
	public static void disable_setlocale ();
	[NoArrayLength ()]
	[CCode (cname = "gtk_enumerate_printers")]
	public static void enumerate_printers (Gtk.PrinterFunc func, pointer data, GLib.DestroyNotify destroy, bool wait);
	[NoArrayLength ()]
	[CCode (cname = "gtk_events_pending")]
	public static bool events_pending ();
	[NoArrayLength ()]
	[CCode (cname = "gtk_get_current_event")]
	public static Gdk.Event get_current_event ();
	[NoArrayLength ()]
	[CCode (cname = "gtk_get_current_event_state")]
	public static bool get_current_event_state (Gdk.ModifierType state);
	[NoArrayLength ()]
	[CCode (cname = "gtk_get_current_event_time")]
	public static uint get_current_event_time ();
	[NoArrayLength ()]
	[CCode (cname = "gtk_get_default_language")]
	public static Pango.Language get_default_language ();
	[NoArrayLength ()]
	[CCode (cname = "gtk_get_event_widget")]
	public static Gtk.Widget get_event_widget (Gdk.Event event);
	[NoArrayLength ()]
	[CCode (cname = "gtk_get_option_group")]
	public static GLib.OptionGroup get_option_group (bool open_default_display);
	[NoArrayLength ()]
	[CCode (cname = "gtk_identifier_get_type")]
	public static GLib.Type identifier_get_type ();
	[NoArrayLength ()]
	[CCode (cname = "gtk_paint_arrow")]
	public static void paint_arrow (Gtk.Style style, Gdk.Window window, Gtk.StateType state_type, Gtk.ShadowType shadow_type, Gdk.Rectangle area, Gtk.Widget widget, string detail, Gtk.ArrowType arrow_type, bool fill, int x, int y, int width, int height);
	[NoArrayLength ()]
	[CCode (cname = "gtk_paint_box")]
	public static void paint_box (Gtk.Style style, Gdk.Window window, Gtk.StateType state_type, Gtk.ShadowType shadow_type, Gdk.Rectangle area, Gtk.Widget widget, string detail, int x, int y, int width, int height);
	[NoArrayLength ()]
	[CCode (cname = "gtk_paint_box_gap")]
	public static void paint_box_gap (Gtk.Style style, Gdk.Window window, Gtk.StateType state_type, Gtk.ShadowType shadow_type, Gdk.Rectangle area, Gtk.Widget widget, string detail, int x, int y, int width, int height, Gtk.PositionType gap_side, int gap_x, int gap_width);
	[NoArrayLength ()]
	[CCode (cname = "gtk_paint_check")]
	public static void paint_check (Gtk.Style style, Gdk.Window window, Gtk.StateType state_type, Gtk.ShadowType shadow_type, Gdk.Rectangle area, Gtk.Widget widget, string detail, int x, int y, int width, int height);
	[NoArrayLength ()]
	[CCode (cname = "gtk_paint_diamond")]
	public static void paint_diamond (Gtk.Style style, Gdk.Window window, Gtk.StateType state_type, Gtk.ShadowType shadow_type, Gdk.Rectangle area, Gtk.Widget widget, string detail, int x, int y, int width, int height);
	[NoArrayLength ()]
	[CCode (cname = "gtk_paint_expander")]
	public static void paint_expander (Gtk.Style style, Gdk.Window window, Gtk.StateType state_type, Gdk.Rectangle area, Gtk.Widget widget, string detail, int x, int y, Gtk.ExpanderStyle expander_style);
	[NoArrayLength ()]
	[CCode (cname = "gtk_paint_extension")]
	public static void paint_extension (Gtk.Style style, Gdk.Window window, Gtk.StateType state_type, Gtk.ShadowType shadow_type, Gdk.Rectangle area, Gtk.Widget widget, string detail, int x, int y, int width, int height, Gtk.PositionType gap_side);
	[NoArrayLength ()]
	[CCode (cname = "gtk_paint_flat_box")]
	public static void paint_flat_box (Gtk.Style style, Gdk.Window window, Gtk.StateType state_type, Gtk.ShadowType shadow_type, Gdk.Rectangle area, Gtk.Widget widget, string detail, int x, int y, int width, int height);
	[NoArrayLength ()]
	[CCode (cname = "gtk_paint_focus")]
	public static void paint_focus (Gtk.Style style, Gdk.Window window, Gtk.StateType state_type, Gdk.Rectangle area, Gtk.Widget widget, string detail, int x, int y, int width, int height);
	[NoArrayLength ()]
	[CCode (cname = "gtk_paint_handle")]
	public static void paint_handle (Gtk.Style style, Gdk.Window window, Gtk.StateType state_type, Gtk.ShadowType shadow_type, Gdk.Rectangle area, Gtk.Widget widget, string detail, int x, int y, int width, int height, Gtk.Orientation orientation);
	[NoArrayLength ()]
	[CCode (cname = "gtk_paint_hline")]
	public static void paint_hline (Gtk.Style style, Gdk.Window window, Gtk.StateType state_type, Gdk.Rectangle area, Gtk.Widget widget, string detail, int x1, int x2, int y);
	[NoArrayLength ()]
	[CCode (cname = "gtk_paint_layout")]
	public static void paint_layout (Gtk.Style style, Gdk.Window window, Gtk.StateType state_type, bool use_text, Gdk.Rectangle area, Gtk.Widget widget, string detail, int x, int y, Pango.Layout layout);
	[NoArrayLength ()]
	[CCode (cname = "gtk_paint_option")]
	public static void paint_option (Gtk.Style style, Gdk.Window window, Gtk.StateType state_type, Gtk.ShadowType shadow_type, Gdk.Rectangle area, Gtk.Widget widget, string detail, int x, int y, int width, int height);
	[NoArrayLength ()]
	[CCode (cname = "gtk_paint_polygon")]
	public static void paint_polygon (Gtk.Style style, Gdk.Window window, Gtk.StateType state_type, Gtk.ShadowType shadow_type, Gdk.Rectangle area, Gtk.Widget widget, string detail, Gdk.Point points, int npoints, bool fill);
	[NoArrayLength ()]
	[CCode (cname = "gtk_paint_resize_grip")]
	public static void paint_resize_grip (Gtk.Style style, Gdk.Window window, Gtk.StateType state_type, Gdk.Rectangle area, Gtk.Widget widget, string detail, Gdk.WindowEdge edge, int x, int y, int width, int height);
	[NoArrayLength ()]
	[CCode (cname = "gtk_paint_shadow")]
	public static void paint_shadow (Gtk.Style style, Gdk.Window window, Gtk.StateType state_type, Gtk.ShadowType shadow_type, Gdk.Rectangle area, Gtk.Widget widget, string detail, int x, int y, int width, int height);
	[NoArrayLength ()]
	[CCode (cname = "gtk_paint_shadow_gap")]
	public static void paint_shadow_gap (Gtk.Style style, Gdk.Window window, Gtk.StateType state_type, Gtk.ShadowType shadow_type, Gdk.Rectangle area, Gtk.Widget widget, string detail, int x, int y, int width, int height, Gtk.PositionType gap_side, int gap_x, int gap_width);
	[NoArrayLength ()]
	[CCode (cname = "gtk_paint_slider")]
	public static void paint_slider (Gtk.Style style, Gdk.Window window, Gtk.StateType state_type, Gtk.ShadowType shadow_type, Gdk.Rectangle area, Gtk.Widget widget, string detail, int x, int y, int width, int height, Gtk.Orientation orientation);
	[NoArrayLength ()]
	[CCode (cname = "gtk_paint_tab")]
	public static void paint_tab (Gtk.Style style, Gdk.Window window, Gtk.StateType state_type, Gtk.ShadowType shadow_type, Gdk.Rectangle area, Gtk.Widget widget, string detail, int x, int y, int width, int height);
	[NoArrayLength ()]
	[CCode (cname = "gtk_paint_vline")]
	public static void paint_vline (Gtk.Style style, Gdk.Window window, Gtk.StateType state_type, Gdk.Rectangle area, Gtk.Widget widget, string detail, int y1_, int y2_, int x);
	[NoArrayLength ()]
	[CCode (cname = "gtk_parse_args")]
	public static bool parse_args (int argc, string argv);
	[NoArrayLength ()]
	[CCode (cname = "gtk_private_flags_get_type")]
	public static GLib.Type private_flags_get_type ();
	[NoArrayLength ()]
	[CCode (cname = "gtk_propagate_event")]
	public static void propagate_event (Gtk.Widget widget, Gdk.Event event);
	[NoArrayLength ()]
	[CCode (cname = "gtk_rgb_to_hsv")]
	public static void rgb_to_hsv (double r, double g, double b, double h, double s, double v);
	[NoArrayLength ()]
	[CCode (cname = "gtk_set_locale")]
	public static string set_locale ();
	[NoArrayLength ()]
	[CCode (cname = "gtk_show_about_dialog")]
	public static void show_about_dialog (Gtk.Window parent, string first_property_name, ...);
	[NoArrayLength ()]
	[CCode (cname = "gtk_text_layout_draw")]
	public static void text_layout_draw (pointer layout, Gtk.Widget widget, Gdk.Drawable drawable, Gdk.GC cursor_gc, int x_offset, int y_offset, int x, int y, int width, int height, GLib.List widgets);
}
[CCode (cheader_filename = "gtk/gtk.h")]
namespace Gtk {
	public struct Allocation {
		public int x;
		public int y;
		public int width;
		public int height;
	}
	[CCode (cname = "gtk_init")]
	public static void init (out string[] args);
	[CCode (cname = "gtk_main")]
	public static void main ();
	[CCode (cname = "gtk_main_quit")]
	public static void main_quit ();
}
