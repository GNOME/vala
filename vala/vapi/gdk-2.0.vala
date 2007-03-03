[CCode (cheader_filename = "gdk/gdk.h")]
namespace Gdk {
	[CCode (cprefix = "GDK_AXIS_")]
	public enum AxisUse {
		IGNORE,
		X,
		Y,
		PRESSURE,
		XTILT,
		YTILT,
		WHEEL,
		LAST,
	}
	[CCode (cprefix = "GDK_")]
	public enum ByteOrder {
		LSB_FIRST,
		MSB_FIRST,
	}
	[CCode (cprefix = "GDK_CAP_")]
	public enum CapStyle {
		NOT_LAST,
		BUTT,
		ROUND,
		PROJECTING,
	}
	[CCode (cprefix = "GDK_COLORSPACE_")]
	public enum Colorspace {
		RGB,
	}
	[CCode (cprefix = "GDK_CROSSING_")]
	public enum CrossingMode {
		NORMAL,
		GRAB,
		UNGRAB,
	}
	[CCode (cprefix = "GDK_")]
	public enum CursorType {
		X_CURSOR,
		ARROW,
		BASED_ARROW_DOWN,
		BASED_ARROW_UP,
		BOAT,
		BOGOSITY,
		BOTTOM_LEFT_CORNER,
		BOTTOM_RIGHT_CORNER,
		BOTTOM_SIDE,
		BOTTOM_TEE,
		BOX_SPIRAL,
		CENTER_PTR,
		CIRCLE,
		CLOCK,
		COFFEE_MUG,
		CROSS,
		CROSS_REVERSE,
		CROSSHAIR,
		DIAMOND_CROSS,
		DOT,
		DOTBOX,
		DOUBLE_ARROW,
		DRAFT_LARGE,
		DRAFT_SMALL,
		DRAPED_BOX,
		EXCHANGE,
		FLEUR,
		GOBBLER,
		GUMBY,
		HAND1,
		HAND2,
		HEART,
		ICON,
		IRON_CROSS,
		LEFT_PTR,
		LEFT_SIDE,
		LEFT_TEE,
		LEFTBUTTON,
		LL_ANGLE,
		LR_ANGLE,
		MAN,
		MIDDLEBUTTON,
		MOUSE,
		PENCIL,
		PIRATE,
		PLUS,
		QUESTION_ARROW,
		RIGHT_PTR,
		RIGHT_SIDE,
		RIGHT_TEE,
		RIGHTBUTTON,
		RTL_LOGO,
		SAILBOAT,
		SB_DOWN_ARROW,
		SB_H_DOUBLE_ARROW,
		SB_LEFT_ARROW,
		SB_RIGHT_ARROW,
		SB_UP_ARROW,
		SB_V_DOUBLE_ARROW,
		SHUTTLE,
		SIZING,
		SPIDER,
		SPRAYCAN,
		STAR,
		TARGET,
		TCROSS,
		TOP_LEFT_ARROW,
		TOP_LEFT_CORNER,
		TOP_RIGHT_CORNER,
		TOP_SIDE,
		TOP_TEE,
		TREK,
		UL_ANGLE,
		UMBRELLA,
		UR_ANGLE,
		WATCH,
		XTERM,
		LAST_CURSOR,
		CURSOR_IS_PIXMAP,
	}
	[CCode (cprefix = "GDK_ACTION_")]
	public enum DragAction {
		DEFAULT,
		COPY,
		MOVE,
		LINK,
		PRIVATE,
		ASK,
	}
	[CCode (cprefix = "GDK_DRAG_PROTO_")]
	public enum DragProtocol {
		MOTIF,
		XDND,
		ROOTWIN,
		NONE,
		WIN32_DROPFILES,
		OLE2,
		LOCAL,
	}
	[CCode (cprefix = "GDK_")]
	public enum EventMask {
		EXPOSURE_MASK,
		POINTER_MOTION_MASK,
		POINTER_MOTION_HINT_MASK,
		BUTTON_MOTION_MASK,
		BUTTON1_MOTION_MASK,
		BUTTON2_MOTION_MASK,
		BUTTON3_MOTION_MASK,
		BUTTON_PRESS_MASK,
		BUTTON_RELEASE_MASK,
		KEY_PRESS_MASK,
		KEY_RELEASE_MASK,
		ENTER_NOTIFY_MASK,
		LEAVE_NOTIFY_MASK,
		FOCUS_CHANGE_MASK,
		STRUCTURE_MASK,
		PROPERTY_CHANGE_MASK,
		VISIBILITY_NOTIFY_MASK,
		PROXIMITY_IN_MASK,
		PROXIMITY_OUT_MASK,
		SUBSTRUCTURE_MASK,
		SCROLL_MASK,
		ALL_EVENTS_MASK,
	}
	[CCode (cprefix = "GDK_")]
	public enum EventType {
		NOTHING,
		DELETE,
		DESTROY,
		EXPOSE,
		MOTION_NOTIFY,
		BUTTON_PRESS,
		2BUTTON_PRESS,
		3BUTTON_PRESS,
		BUTTON_RELEASE,
		KEY_PRESS,
		KEY_RELEASE,
		ENTER_NOTIFY,
		LEAVE_NOTIFY,
		FOCUS_CHANGE,
		CONFIGURE,
		MAP,
		UNMAP,
		PROPERTY_NOTIFY,
		SELECTION_CLEAR,
		SELECTION_REQUEST,
		SELECTION_NOTIFY,
		PROXIMITY_IN,
		PROXIMITY_OUT,
		DRAG_ENTER,
		DRAG_LEAVE,
		DRAG_MOTION,
		DRAG_STATUS,
		DROP_START,
		DROP_FINISHED,
		CLIENT_EVENT,
		VISIBILITY_NOTIFY,
		NO_EXPOSE,
		SCROLL,
		WINDOW_STATE,
		SETTING,
		OWNER_CHANGE,
		GRAB_BROKEN,
	}
	[CCode (cprefix = "GDK_EXTENSION_EVENTS_")]
	public enum ExtensionMode {
		NONE,
		ALL,
		CURSOR,
	}
	[CCode (cprefix = "GDK_")]
	public enum Fill {
		SOLID,
		TILED,
		STIPPLED,
		OPAQUE_STIPPLED,
	}
	[CCode (cprefix = "GDK_")]
	public enum FillRule {
		EVEN_ODD_RULE,
		WINDING_RULE,
	}
	[CCode (cprefix = "GDK_FILTER_")]
	public enum FilterReturn {
		CONTINUE,
		TRANSLATE,
		REMOVE,
	}
	[CCode (cprefix = "GDK_FONT_")]
	public enum FontType {
		FONT,
		FONTSET,
	}
	[CCode (cprefix = "GDK_")]
	public enum Function {
		COPY,
		INVERT,
		XOR,
		CLEAR,
		AND,
		AND_REVERSE,
		AND_INVERT,
		NOOP,
		OR,
		EQUIV,
		OR_REVERSE,
		COPY_INVERT,
		OR_INVERT,
		NAND,
		NOR,
		SET,
	}
	[CCode (cprefix = "GDK_GC_")]
	public enum GCValuesMask {
		FOREGROUND,
		BACKGROUND,
		FONT,
		FUNCTION,
		FILL,
		TILE,
		STIPPLE,
		CLIP_MASK,
		SUBWINDOW,
		TS_X_ORIGIN,
		TS_Y_ORIGIN,
		CLIP_X_ORIGIN,
		CLIP_Y_ORIGIN,
		EXPOSURES,
		LINE_WIDTH,
		LINE_STYLE,
		CAP_STYLE,
		JOIN_STYLE,
	}
	[CCode (cprefix = "GDK_GRAB_")]
	public enum GrabStatus {
		SUCCESS,
		ALREADY_GRABBED,
		INVALID_TIME,
		NOT_VIEWABLE,
		FROZEN,
	}
	[CCode (cprefix = "GDK_GRAVITY_")]
	public enum Gravity {
		NORTH_WEST,
		NORTH,
		NORTH_EAST,
		WEST,
		CENTER,
		EAST,
		SOUTH_WEST,
		SOUTH,
		SOUTH_EAST,
		STATIC,
	}
	[CCode (cprefix = "GDK_IMAGE_")]
	public enum ImageType {
		NORMAL,
		SHARED,
		FASTEST,
	}
	[CCode (cprefix = "GDK_INPUT_")]
	public enum InputCondition {
		READ,
		WRITE,
		EXCEPTION,
	}
	[CCode (cprefix = "GDK_MODE_")]
	public enum InputMode {
		DISABLED,
		SCREEN,
		WINDOW,
	}
	[CCode (cprefix = "GDK_SOURCE_")]
	public enum InputSource {
		MOUSE,
		PEN,
		ERASER,
		CURSOR,
	}
	[CCode (cprefix = "GDK_INTERP_")]
	public enum InterpType {
		NEAREST,
		TILES,
		BILINEAR,
		HYPER,
	}
	[CCode (cprefix = "GDK_JOIN_")]
	public enum JoinStyle {
		MITER,
		ROUND,
		BEVEL,
	}
	[CCode (cprefix = "GDK_LINE_")]
	public enum LineStyle {
		SOLID,
		ON_OFF_DASH,
		DOUBLE_DASH,
	}
	[CCode (cprefix = "GDK_")]
	public enum ModifierType {
		SHIFT_MASK,
		LOCK_MASK,
		CONTROL_MASK,
		MOD1_MASK,
		MOD2_MASK,
		MOD3_MASK,
		MOD4_MASK,
		MOD5_MASK,
		BUTTON1_MASK,
		BUTTON2_MASK,
		BUTTON3_MASK,
		BUTTON4_MASK,
		BUTTON5_MASK,
		SUPER_MASK,
		HYPER_MASK,
		META_MASK,
		RELEASE_MASK,
		MODIFIER_MASK,
	}
	[CCode (cprefix = "GDK_NOTIFY_")]
	public enum NotifyType {
		ANCESTOR,
		VIRTUAL,
		INFERIOR,
		NONLINEAR,
		NONLINEAR_VIRTUAL,
		UNKNOWN,
	}
	[CCode (cprefix = "GDK_OVERLAP_RECTANGLE_")]
	public enum OverlapType {
		IN,
		OUT,
		PART,
	}
	[CCode (cprefix = "GDK_OWNER_CHANGE_")]
	public enum OwnerChange {
		NEW_OWNER,
		DESTROY,
		CLOSE,
	}
	[CCode (cprefix = "GDK_PIXBUF_ALPHA_")]
	public enum PixbufAlphaMode {
		BILEVEL,
		FULL,
	}
	[CCode (cprefix = "GDK_PIXBUF_ERROR_")]
	public enum PixbufError {
		CORRUPT_IMAGE,
		INSUFFICIENT_MEMORY,
		BAD_OPTION,
		UNKNOWN_TYPE,
		UNSUPPORTED_OPERATION,
		FAILED,
	}
	[CCode (cprefix = "GDK_PIXBUF_FRAME_")]
	public enum PixbufFrameAction {
		RETAIN,
		DISPOSE,
		REVERT,
	}
	[CCode (cprefix = "GDK_PIXBUF_ROTATE_")]
	public enum PixbufRotation {
		NONE,
		COUNTERCLOCKWISE,
		UPSIDEDOWN,
		CLOCKWISE,
	}
	[CCode (cprefix = "GDK_PIXDATA_DUMP_")]
	public enum PixdataDumpType {
		PIXDATA_STREAM,
		PIXDATA_STRUCT,
		MACROS,
		GTYPES,
		CTYPES,
		STATIC,
		CONST,
		RLE_DECODER,
	}
	[CCode (cprefix = "GDK_PIXDATA_")]
	public enum PixdataType {
		COLOR_TYPE_RGB,
		COLOR_TYPE_RGBA,
		COLOR_TYPE_MASK,
		SAMPLE_WIDTH_8,
		SAMPLE_WIDTH_MASK,
		ENCODING_RAW,
		ENCODING_RLE,
		ENCODING_MASK,
	}
	[CCode (cprefix = "GDK_PROP_MODE_")]
	public enum PropMode {
		REPLACE,
		PREPEND,
		APPEND,
	}
	[CCode (cprefix = "GDK_PROPERTY_")]
	public enum PropertyState {
		NEW_VALUE,
		DELETE,
	}
	[CCode (cprefix = "GDK_RGB_DITHER_")]
	public enum RgbDither {
		NONE,
		NORMAL,
		MAX,
	}
	[CCode (cprefix = "GDK_SCROLL_")]
	public enum ScrollDirection {
		UP,
		DOWN,
		LEFT,
		RIGHT,
	}
	[CCode (cprefix = "GDK_SETTING_ACTION_")]
	public enum SettingAction {
		NEW,
		CHANGED,
		DELETED,
	}
	[CCode (cprefix = "GDK_")]
	public enum Status {
		OK,
		ERROR,
		ERROR_PARAM,
		ERROR_FILE,
		ERROR_MEM,
	}
	[CCode (cprefix = "GDK_")]
	public enum SubwindowMode {
		CLIP_BY_CHILDREN,
		INCLUDE_INFERIORS,
	}
	[CCode (cprefix = "GDK_VISIBILITY_")]
	public enum VisibilityState {
		UNOBSCURED,
		PARTIAL,
		FULLY_OBSCURED,
	}
	[CCode (cprefix = "GDK_VISUAL_")]
	public enum VisualType {
		STATIC_GRAY,
		GRAYSCALE,
		STATIC_COLOR,
		PSEUDO_COLOR,
		TRUE_COLOR,
		DIRECT_COLOR,
	}
	[CCode (cprefix = "GDK_DECOR_")]
	public enum WMDecoration {
		ALL,
		BORDER,
		RESIZEH,
		TITLE,
		MENU,
		MINIMIZE,
		MAXIMIZE,
	}
	[CCode (cprefix = "GDK_FUNC_")]
	public enum WMFunction {
		ALL,
		RESIZE,
		MOVE,
		MINIMIZE,
		MAXIMIZE,
		CLOSE,
	}
	[CCode (cprefix = "GDK_WA_")]
	public enum WindowAttributesType {
		TITLE,
		X,
		Y,
		CURSOR,
		COLORMAP,
		VISUAL,
		WMCLASS,
		NOREDIR,
	}
	[CCode (cprefix = "GDK_INPUT_")]
	public enum WindowClass {
		OUTPUT,
		ONLY,
	}
	[CCode (cprefix = "GDK_WINDOW_EDGE_")]
	public enum WindowEdge {
		NORTH_WEST,
		NORTH,
		NORTH_EAST,
		WEST,
		EAST,
		SOUTH_WEST,
		SOUTH,
		SOUTH_EAST,
	}
	[CCode (cprefix = "GDK_HINT_")]
	public enum WindowHints {
		POS,
		MIN_SIZE,
		MAX_SIZE,
		BASE_SIZE,
		ASPECT,
		RESIZE_INC,
		WIN_GRAVITY,
		USER_POS,
		USER_SIZE,
	}
	[CCode (cprefix = "GDK_WINDOW_STATE_")]
	public enum WindowState {
		WITHDRAWN,
		ICONIFIED,
		MAXIMIZED,
		STICKY,
		FULLSCREEN,
		ABOVE,
		BELOW,
	}
	[CCode (cprefix = "GDK_WINDOW_")]
	public enum WindowType {
		ROOT,
		TOPLEVEL,
		CHILD,
		DIALOG,
		TEMP,
		FOREIGN,
	}
	[CCode (cprefix = "GDK_WINDOW_TYPE_HINT_")]
	public enum WindowTypeHint {
		NORMAL,
		DIALOG,
		MENU,
		TOOLBAR,
		SPLASHSCREEN,
		UTILITY,
		DOCK,
		DESKTOP,
		DROPDOWN_MENU,
		POPUP_MENU,
		TOOLTIP,
		NOTIFICATION,
		COMBO,
		DND,
	}
	[CCode (cheader_filename = "gdk/gdk.h")]
	public class Colormap : GLib.Object {
		public int size;
		public Gdk.Color colors;
		[NoArrayLength ()]
		[CCode (cname = "gdk_colormap_alloc_color")]
		public bool alloc_color (Gdk.Color color, bool writeable, bool best_match);
		[NoArrayLength ()]
		[CCode (cname = "gdk_colormap_alloc_colors")]
		public int alloc_colors (Gdk.Color colors, int ncolors, bool writeable, bool best_match, bool success);
		[NoArrayLength ()]
		[CCode (cname = "gdk_colormap_free_colors")]
		public void free_colors (Gdk.Color colors, int ncolors);
		[NoArrayLength ()]
		[CCode (cname = "gdk_colormap_get_screen")]
		public Gdk.Screen get_screen ();
		[NoArrayLength ()]
		[CCode (cname = "gdk_colormap_get_system")]
		public static Gdk.Colormap get_system ();
		[NoArrayLength ()]
		[CCode (cname = "gdk_colormap_get_type")]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		[CCode (cname = "gdk_colormap_get_visual")]
		public Gdk.Visual get_visual ();
		[NoArrayLength ()]
		[CCode (cname = "gdk_colormap_new")]
		public Colormap (Gdk.Visual visual, bool allocate);
		[NoArrayLength ()]
		[CCode (cname = "gdk_colormap_query_color")]
		public void query_color (ulong pixel, Gdk.Color result);
	}
	[CCode (cheader_filename = "gdk/gdk.h")]
	public class Device : GLib.Object {
		[NoArrayLength ()]
		[CCode (cname = "gdk_device_free_history")]
		public static void free_history (Gdk.TimeCoord events, int n_events);
		[NoArrayLength ()]
		[CCode (cname = "gdk_device_get_axis")]
		public bool get_axis (double axes, Gdk.AxisUse use, double value);
		[NoArrayLength ()]
		[CCode (cname = "gdk_device_get_core_pointer")]
		public static Gdk.Device get_core_pointer ();
		[NoArrayLength ()]
		[CCode (cname = "gdk_device_get_history")]
		public bool get_history (Gdk.Window window, uint start, uint stop, Gdk.TimeCoord events, int n_events);
		[NoArrayLength ()]
		[CCode (cname = "gdk_device_get_state")]
		public void get_state (Gdk.Window window, double axes, Gdk.ModifierType mask);
		[NoArrayLength ()]
		[CCode (cname = "gdk_device_get_type")]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		[CCode (cname = "gdk_device_set_axis_use")]
		public void set_axis_use (uint index_, Gdk.AxisUse use);
		[NoArrayLength ()]
		[CCode (cname = "gdk_device_set_key")]
		public void set_key (uint index_, uint keyval, Gdk.ModifierType modifiers);
		[NoArrayLength ()]
		[CCode (cname = "gdk_device_set_mode")]
		public bool set_mode (Gdk.InputMode mode);
		[NoArrayLength ()]
		[CCode (cname = "gdk_device_set_source")]
		public void set_source (Gdk.InputSource source);
	}
	[CCode (cheader_filename = "gdk/gdk.h")]
	public class Display : GLib.Object {
		[NoArrayLength ()]
		[CCode (cname = "gdk_display_add_client_message_filter")]
		public void add_client_message_filter (Gdk.Atom message_type, Gdk.FilterFunc func, pointer data);
		[NoArrayLength ()]
		[CCode (cname = "gdk_display_beep")]
		public void beep ();
		[NoArrayLength ()]
		[CCode (cname = "gdk_display_close")]
		public void close ();
		[NoArrayLength ()]
		[CCode (cname = "gdk_display_flush")]
		public void flush ();
		[NoArrayLength ()]
		[CCode (cname = "gdk_display_get_core_pointer")]
		public Gdk.Device get_core_pointer ();
		[NoArrayLength ()]
		[CCode (cname = "gdk_display_get_default")]
		public static Gdk.Display get_default ();
		[NoArrayLength ()]
		[CCode (cname = "gdk_display_get_default_cursor_size")]
		public uint get_default_cursor_size ();
		[NoArrayLength ()]
		[CCode (cname = "gdk_display_get_default_group")]
		public Gdk.Window get_default_group ();
		[NoArrayLength ()]
		[CCode (cname = "gdk_display_get_default_screen")]
		public virtual Gdk.Screen get_default_screen ();
		[NoArrayLength ()]
		[CCode (cname = "gdk_display_get_event")]
		public Gdk.Event get_event ();
		[NoArrayLength ()]
		[CCode (cname = "gdk_display_get_maximal_cursor_size")]
		public void get_maximal_cursor_size (uint width, uint height);
		[NoArrayLength ()]
		[CCode (cname = "gdk_display_get_n_screens")]
		public virtual int get_n_screens ();
		[NoArrayLength ()]
		[CCode (cname = "gdk_display_get_name")]
		public string get_name ();
		[NoArrayLength ()]
		[CCode (cname = "gdk_display_get_pointer")]
		public void get_pointer (Gdk.Screen screen, int x, int y, Gdk.ModifierType mask);
		[NoArrayLength ()]
		[CCode (cname = "gdk_display_get_screen")]
		public virtual Gdk.Screen get_screen (int screen_num);
		[NoArrayLength ()]
		[CCode (cname = "gdk_display_get_type")]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		[CCode (cname = "gdk_display_get_window_at_pointer")]
		public Gdk.Window get_window_at_pointer (int win_x, int win_y);
		[NoArrayLength ()]
		[CCode (cname = "gdk_display_keyboard_ungrab")]
		public void keyboard_ungrab (uint time_);
		[NoArrayLength ()]
		[CCode (cname = "gdk_display_list_devices")]
		public GLib.List list_devices ();
		[NoArrayLength ()]
		[CCode (cname = "gdk_display_open")]
		public static Gdk.Display open (string display_name);
		[NoArrayLength ()]
		[CCode (cname = "gdk_display_open_default_libgtk_only")]
		public static Gdk.Display open_default_libgtk_only ();
		[NoArrayLength ()]
		[CCode (cname = "gdk_display_peek_event")]
		public Gdk.Event peek_event ();
		[NoArrayLength ()]
		[CCode (cname = "gdk_display_pointer_is_grabbed")]
		public bool pointer_is_grabbed ();
		[NoArrayLength ()]
		[CCode (cname = "gdk_display_pointer_ungrab")]
		public void pointer_ungrab (uint time_);
		[NoArrayLength ()]
		[CCode (cname = "gdk_display_put_event")]
		public void put_event (Gdk.Event event);
		[NoArrayLength ()]
		[CCode (cname = "gdk_display_request_selection_notification")]
		public bool request_selection_notification (Gdk.Atom selection);
		[NoArrayLength ()]
		[CCode (cname = "gdk_display_set_double_click_distance")]
		public void set_double_click_distance (uint distance);
		[NoArrayLength ()]
		[CCode (cname = "gdk_display_set_double_click_time")]
		public void set_double_click_time (uint msec);
		[NoArrayLength ()]
		[CCode (cname = "gdk_display_set_pointer_hooks")]
		public Gdk.DisplayPointerHooks set_pointer_hooks (Gdk.DisplayPointerHooks new_hooks);
		[NoArrayLength ()]
		[CCode (cname = "gdk_display_store_clipboard")]
		public void store_clipboard (Gdk.Window clipboard_window, uint time_, Gdk.Atom targets, int n_targets);
		[NoArrayLength ()]
		[CCode (cname = "gdk_display_supports_clipboard_persistence")]
		public bool supports_clipboard_persistence ();
		[NoArrayLength ()]
		[CCode (cname = "gdk_display_supports_cursor_alpha")]
		public bool supports_cursor_alpha ();
		[NoArrayLength ()]
		[CCode (cname = "gdk_display_supports_cursor_color")]
		public bool supports_cursor_color ();
		[NoArrayLength ()]
		[CCode (cname = "gdk_display_supports_input_shapes")]
		public bool supports_input_shapes ();
		[NoArrayLength ()]
		[CCode (cname = "gdk_display_supports_selection_notification")]
		public bool supports_selection_notification ();
		[NoArrayLength ()]
		[CCode (cname = "gdk_display_supports_shapes")]
		public bool supports_shapes ();
		[NoArrayLength ()]
		[CCode (cname = "gdk_display_sync")]
		public void sync ();
		[NoArrayLength ()]
		[CCode (cname = "gdk_display_warp_pointer")]
		public void warp_pointer (Gdk.Screen screen, int x, int y);
		public signal void closed (bool is_error);
	}
	[CCode (cheader_filename = "gdk/gdk.h")]
	public class DisplayManager : GLib.Object {
		[NoArrayLength ()]
		[CCode (cname = "gdk_display_manager_get")]
		public static Gdk.DisplayManager @get ();
		[NoArrayLength ()]
		[CCode (cname = "gdk_display_manager_get_default_display")]
		public Gdk.Display get_default_display ();
		[NoArrayLength ()]
		[CCode (cname = "gdk_display_manager_get_type")]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		[CCode (cname = "gdk_display_manager_list_displays")]
		public GLib.SList list_displays ();
		[NoArrayLength ()]
		[CCode (cname = "gdk_display_manager_set_default_display")]
		public void set_default_display (Gdk.Display display);
		public weak Gdk.Display default_display { get; set; }
		public signal void display_opened (Gdk.Display display);
	}
	[CCode (cheader_filename = "gdk/gdk.h")]
	public class DragContext : GLib.Object {
		public Gdk.DragProtocol protocol;
		public bool is_source;
		public weak Gdk.Window source_window;
		public weak Gdk.Window dest_window;
		public weak GLib.List targets;
		public Gdk.DragAction actions;
		public Gdk.DragAction suggested_action;
		public Gdk.DragAction action;
		public uint start_time;
		[NoArrayLength ()]
		[CCode (cname = "gdk_drag_context_get_type")]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		[CCode (cname = "gdk_drag_context_new")]
		public DragContext ();
	}
	[CCode (cheader_filename = "gdk/gdk.h")]
	public class Drawable : GLib.Object {
		[NoArrayLength ()]
		[CCode (cname = "gdk_draw_arc")]
		public virtual void draw_arc (Gdk.GC gc, bool filled, int x, int y, int width, int height, int angle1, int angle2);
		[NoArrayLength ()]
		[CCode (cname = "gdk_draw_drawable")]
		public virtual void draw_drawable (Gdk.GC gc, Gdk.Drawable src, int xsrc, int ysrc, int xdest, int ydest, int width, int height);
		[NoArrayLength ()]
		[CCode (cname = "gdk_draw_glyphs")]
		public virtual void draw_glyphs (Gdk.GC gc, Pango.Font font, int x, int y, Pango.GlyphString glyphs);
		[NoArrayLength ()]
		[CCode (cname = "gdk_draw_glyphs_transformed")]
		public virtual void draw_glyphs_transformed (Gdk.GC gc, Pango.Matrix matrix, Pango.Font font, int x, int y, Pango.GlyphString glyphs);
		[NoArrayLength ()]
		[CCode (cname = "gdk_draw_gray_image")]
		public void draw_gray_image (Gdk.GC gc, int x, int y, int width, int height, Gdk.RgbDither dith, uchar[] buf, int rowstride);
		[NoArrayLength ()]
		[CCode (cname = "gdk_draw_image")]
		public virtual void draw_image (Gdk.GC gc, Gdk.Image image, int xsrc, int ysrc, int xdest, int ydest, int width, int height);
		[NoArrayLength ()]
		[CCode (cname = "gdk_draw_indexed_image")]
		public void draw_indexed_image (Gdk.GC gc, int x, int y, int width, int height, Gdk.RgbDither dith, uchar[] buf, int rowstride, Gdk.RgbCmap cmap);
		[NoArrayLength ()]
		[CCode (cname = "gdk_draw_layout")]
		public void draw_layout (Gdk.GC gc, int x, int y, Pango.Layout layout);
		[NoArrayLength ()]
		[CCode (cname = "gdk_draw_layout_line")]
		public void draw_layout_line (Gdk.GC gc, int x, int y, Pango.LayoutLine line);
		[NoArrayLength ()]
		[CCode (cname = "gdk_draw_layout_line_with_colors")]
		public void draw_layout_line_with_colors (Gdk.GC gc, int x, int y, Pango.LayoutLine line, Gdk.Color foreground, Gdk.Color background);
		[NoArrayLength ()]
		[CCode (cname = "gdk_draw_layout_with_colors")]
		public void draw_layout_with_colors (Gdk.GC gc, int x, int y, Pango.Layout layout, Gdk.Color foreground, Gdk.Color background);
		[NoArrayLength ()]
		[CCode (cname = "gdk_draw_line")]
		public void draw_line (Gdk.GC gc, int x1_, int y1_, int x2_, int y2_);
		[NoArrayLength ()]
		[CCode (cname = "gdk_draw_lines")]
		public virtual void draw_lines (Gdk.GC gc, Gdk.Point points, int npoints);
		[NoArrayLength ()]
		[CCode (cname = "gdk_draw_pixbuf")]
		public virtual void draw_pixbuf (Gdk.GC gc, Gdk.Pixbuf pixbuf, int src_x, int src_y, int dest_x, int dest_y, int width, int height, Gdk.RgbDither dither, int x_dither, int y_dither);
		[NoArrayLength ()]
		[CCode (cname = "gdk_draw_point")]
		public void draw_point (Gdk.GC gc, int x, int y);
		[NoArrayLength ()]
		[CCode (cname = "gdk_draw_points")]
		public virtual void draw_points (Gdk.GC gc, Gdk.Point points, int npoints);
		[NoArrayLength ()]
		[CCode (cname = "gdk_draw_polygon")]
		public virtual void draw_polygon (Gdk.GC gc, bool filled, Gdk.Point points, int npoints);
		[NoArrayLength ()]
		[CCode (cname = "gdk_draw_rectangle")]
		public virtual void draw_rectangle (Gdk.GC gc, bool filled, int x, int y, int width, int height);
		[NoArrayLength ()]
		[CCode (cname = "gdk_draw_rgb_32_image")]
		public void draw_rgb_32_image (Gdk.GC gc, int x, int y, int width, int height, Gdk.RgbDither dith, uchar[] buf, int rowstride);
		[NoArrayLength ()]
		[CCode (cname = "gdk_draw_rgb_32_image_dithalign")]
		public void draw_rgb_32_image_dithalign (Gdk.GC gc, int x, int y, int width, int height, Gdk.RgbDither dith, uchar[] buf, int rowstride, int xdith, int ydith);
		[NoArrayLength ()]
		[CCode (cname = "gdk_draw_rgb_image")]
		public void draw_rgb_image (Gdk.GC gc, int x, int y, int width, int height, Gdk.RgbDither dith, uchar[] rgb_buf, int rowstride);
		[NoArrayLength ()]
		[CCode (cname = "gdk_draw_rgb_image_dithalign")]
		public void draw_rgb_image_dithalign (Gdk.GC gc, int x, int y, int width, int height, Gdk.RgbDither dith, uchar[] rgb_buf, int rowstride, int xdith, int ydith);
		[NoArrayLength ()]
		[CCode (cname = "gdk_draw_segments")]
		public virtual void draw_segments (Gdk.GC gc, Gdk.Segment segs, int nsegs);
		[NoArrayLength ()]
		[CCode (cname = "gdk_draw_trapezoids")]
		public virtual void draw_trapezoids (Gdk.GC gc, Gdk.Trapezoid trapezoids, int n_trapezoids);
		[NoArrayLength ()]
		[CCode (cname = "gdk_drawable_copy_to_image")]
		public Gdk.Image copy_to_image (Gdk.Image image, int src_x, int src_y, int dest_x, int dest_y, int width, int height);
		[NoArrayLength ()]
		[CCode (cname = "gdk_drawable_get_clip_region")]
		public virtual Gdk.Region get_clip_region ();
		[NoArrayLength ()]
		[CCode (cname = "gdk_drawable_get_colormap")]
		public virtual Gdk.Colormap get_colormap ();
		[NoArrayLength ()]
		[CCode (cname = "gdk_drawable_get_depth")]
		public virtual int get_depth ();
		[NoArrayLength ()]
		[CCode (cname = "gdk_drawable_get_display")]
		public Gdk.Display get_display ();
		[NoArrayLength ()]
		[CCode (cname = "gdk_drawable_get_image")]
		public virtual Gdk.Image get_image (int x, int y, int width, int height);
		[NoArrayLength ()]
		[CCode (cname = "gdk_drawable_get_screen")]
		public virtual Gdk.Screen get_screen ();
		[NoArrayLength ()]
		[CCode (cname = "gdk_drawable_get_size")]
		public virtual void get_size (int width, int height);
		[NoArrayLength ()]
		[CCode (cname = "gdk_drawable_get_type")]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		[CCode (cname = "gdk_drawable_get_visible_region")]
		public virtual Gdk.Region get_visible_region ();
		[NoArrayLength ()]
		[CCode (cname = "gdk_drawable_get_visual")]
		public virtual Gdk.Visual get_visual ();
		[NoArrayLength ()]
		[CCode (cname = "gdk_drawable_set_colormap")]
		public virtual void set_colormap (Gdk.Colormap colormap);
	}
	[CCode (cheader_filename = "gdk/gdk.h")]
	public class GC : GLib.Object {
		[NoArrayLength ()]
		[CCode (cname = "gdk_gc_copy")]
		public void copy (Gdk.GC src_gc);
		[NoArrayLength ()]
		[CCode (cname = "gdk_gc_get_colormap")]
		public Gdk.Colormap get_colormap ();
		[NoArrayLength ()]
		[CCode (cname = "gdk_gc_get_screen")]
		public Gdk.Screen get_screen ();
		[NoArrayLength ()]
		[CCode (cname = "gdk_gc_get_type")]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		[CCode (cname = "gdk_gc_get_values")]
		public virtual void get_values (Gdk.GCValues values);
		[NoArrayLength ()]
		[CCode (cname = "gdk_gc_new")]
		public GC (Gdk.Drawable drawable);
		[NoArrayLength ()]
		[CCode (cname = "gdk_gc_new_with_values")]
		public GC.with_values (Gdk.Drawable drawable, Gdk.GCValues values, Gdk.GCValuesMask values_mask);
		[NoArrayLength ()]
		[CCode (cname = "gdk_gc_offset")]
		public void offset (int x_offset, int y_offset);
		[NoArrayLength ()]
		[CCode (cname = "gdk_gc_set_background")]
		public void set_background (Gdk.Color color);
		[NoArrayLength ()]
		[CCode (cname = "gdk_gc_set_clip_mask")]
		public void set_clip_mask (Gdk.Bitmap mask);
		[NoArrayLength ()]
		[CCode (cname = "gdk_gc_set_clip_origin")]
		public void set_clip_origin (int x, int y);
		[NoArrayLength ()]
		[CCode (cname = "gdk_gc_set_clip_rectangle")]
		public void set_clip_rectangle (Gdk.Rectangle rectangle);
		[NoArrayLength ()]
		[CCode (cname = "gdk_gc_set_clip_region")]
		public void set_clip_region (Gdk.Region region);
		[NoArrayLength ()]
		[CCode (cname = "gdk_gc_set_colormap")]
		public void set_colormap (Gdk.Colormap colormap);
		[NoArrayLength ()]
		[CCode (cname = "gdk_gc_set_dashes")]
		public virtual void set_dashes (int dash_offset, char[] dash_list, int n);
		[NoArrayLength ()]
		[CCode (cname = "gdk_gc_set_exposures")]
		public void set_exposures (bool exposures);
		[NoArrayLength ()]
		[CCode (cname = "gdk_gc_set_fill")]
		public void set_fill (Gdk.Fill fill);
		[NoArrayLength ()]
		[CCode (cname = "gdk_gc_set_foreground")]
		public void set_foreground (Gdk.Color color);
		[NoArrayLength ()]
		[CCode (cname = "gdk_gc_set_function")]
		public void set_function (Gdk.Function function);
		[NoArrayLength ()]
		[CCode (cname = "gdk_gc_set_line_attributes")]
		public void set_line_attributes (int line_width, Gdk.LineStyle line_style, Gdk.CapStyle cap_style, Gdk.JoinStyle join_style);
		[NoArrayLength ()]
		[CCode (cname = "gdk_gc_set_rgb_bg_color")]
		public void set_rgb_bg_color (Gdk.Color color);
		[NoArrayLength ()]
		[CCode (cname = "gdk_gc_set_rgb_fg_color")]
		public void set_rgb_fg_color (Gdk.Color color);
		[NoArrayLength ()]
		[CCode (cname = "gdk_gc_set_stipple")]
		public void set_stipple (Gdk.Pixmap stipple);
		[NoArrayLength ()]
		[CCode (cname = "gdk_gc_set_subwindow")]
		public void set_subwindow (Gdk.SubwindowMode mode);
		[NoArrayLength ()]
		[CCode (cname = "gdk_gc_set_tile")]
		public void set_tile (Gdk.Pixmap tile);
		[NoArrayLength ()]
		[CCode (cname = "gdk_gc_set_ts_origin")]
		public void set_ts_origin (int x, int y);
		[NoArrayLength ()]
		[CCode (cname = "gdk_gc_set_values")]
		public virtual void set_values (Gdk.GCValues values, Gdk.GCValuesMask values_mask);
	}
	[CCode (cheader_filename = "gdk/gdk.h")]
	public class Image : GLib.Object {
		public Gdk.ImageType type;
		public weak Gdk.Visual visual;
		public Gdk.ByteOrder byte_order;
		public int width;
		public int height;
		public ushort depth;
		public ushort bpp;
		public ushort bpl;
		public ushort bits_per_pixel;
		public pointer mem;
		public weak Gdk.Colormap colormap;
		[NoArrayLength ()]
		[CCode (cname = "gdk_image_get_colormap")]
		public Gdk.Colormap get_colormap ();
		[NoArrayLength ()]
		[CCode (cname = "gdk_image_get_pixel")]
		public uint get_pixel (int x, int y);
		[NoArrayLength ()]
		[CCode (cname = "gdk_image_get_type")]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		[CCode (cname = "gdk_image_new")]
		public Image (Gdk.ImageType type, Gdk.Visual visual, int width, int height);
		[NoArrayLength ()]
		[CCode (cname = "gdk_image_put_pixel")]
		public void put_pixel (int x, int y, uint pixel);
		[NoArrayLength ()]
		[CCode (cname = "gdk_image_set_colormap")]
		public void set_colormap (Gdk.Colormap colormap);
	}
	[CCode (cheader_filename = "gdk/gdk.h")]
	public class Keymap : GLib.Object {
		[NoArrayLength ()]
		[CCode (cname = "gdk_keymap_get_default")]
		public static Gdk.Keymap get_default ();
		[NoArrayLength ()]
		[CCode (cname = "gdk_keymap_get_direction")]
		public Pango.Direction get_direction ();
		[NoArrayLength ()]
		[CCode (cname = "gdk_keymap_get_entries_for_keycode")]
		public bool get_entries_for_keycode (uint hardware_keycode, Gdk.KeymapKey keys, uint keyvals, int n_entries);
		[NoArrayLength ()]
		[CCode (cname = "gdk_keymap_get_entries_for_keyval")]
		public bool get_entries_for_keyval (uint keyval, Gdk.KeymapKey keys, int n_keys);
		[NoArrayLength ()]
		[CCode (cname = "gdk_keymap_get_for_display")]
		public static Gdk.Keymap get_for_display (Gdk.Display display);
		[NoArrayLength ()]
		[CCode (cname = "gdk_keymap_get_type")]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		[CCode (cname = "gdk_keymap_lookup_key")]
		public uint lookup_key (Gdk.KeymapKey key);
		[NoArrayLength ()]
		[CCode (cname = "gdk_keymap_translate_keyboard_state")]
		public bool translate_keyboard_state (uint hardware_keycode, Gdk.ModifierType state, int group, uint keyval, int effective_group, int level, Gdk.ModifierType consumed_modifiers);
		public signal void direction_changed ();
		public signal void keys_changed ();
	}
	[CCode (cheader_filename = "gdk/gdk.h")]
	public class PangoRenderer : Pango.Renderer {
		[NoArrayLength ()]
		[CCode (cname = "gdk_pango_renderer_get_default")]
		public static Pango.Renderer get_default (Gdk.Screen screen);
		[NoArrayLength ()]
		[CCode (cname = "gdk_pango_renderer_get_type")]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		[CCode (cname = "gdk_pango_renderer_new")]
		public PangoRenderer (Gdk.Screen screen);
		[NoArrayLength ()]
		[CCode (cname = "gdk_pango_renderer_set_drawable")]
		public void set_drawable (Gdk.Drawable drawable);
		[NoArrayLength ()]
		[CCode (cname = "gdk_pango_renderer_set_gc")]
		public void set_gc (Gdk.GC gc);
		[NoArrayLength ()]
		[CCode (cname = "gdk_pango_renderer_set_override_color")]
		public void set_override_color (Pango.RenderPart part, Gdk.Color color);
		[NoArrayLength ()]
		[CCode (cname = "gdk_pango_renderer_set_stipple")]
		public void set_stipple (Pango.RenderPart part, Gdk.Bitmap stipple);
		[NoAccessorMethod ()]
		public weak Gdk.Screen screen { get; construct; }
	}
	[CCode (cheader_filename = "gdk/gdk.h")]
	public class Pixbuf : GLib.Object {
		[NoArrayLength ()]
		[CCode (cname = "gdk_pixbuf_add_alpha")]
		public Gdk.Pixbuf add_alpha (bool substitute_color, uchar r, uchar g, uchar b);
		[NoArrayLength ()]
		[CCode (cname = "gdk_pixbuf_composite")]
		public void composite (Gdk.Pixbuf dest, int dest_x, int dest_y, int dest_width, int dest_height, double offset_x, double offset_y, double scale_x, double scale_y, Gdk.InterpType interp_type, int overall_alpha);
		[NoArrayLength ()]
		[CCode (cname = "gdk_pixbuf_composite_color")]
		public void composite_color (Gdk.Pixbuf dest, int dest_x, int dest_y, int dest_width, int dest_height, double offset_x, double offset_y, double scale_x, double scale_y, Gdk.InterpType interp_type, int overall_alpha, int check_x, int check_y, int check_size, uint color1, uint color2);
		[NoArrayLength ()]
		[CCode (cname = "gdk_pixbuf_composite_color_simple")]
		public Gdk.Pixbuf composite_color_simple (int dest_width, int dest_height, Gdk.InterpType interp_type, int overall_alpha, int check_size, uint color1, uint color2);
		[NoArrayLength ()]
		[CCode (cname = "gdk_pixbuf_copy")]
		public Gdk.Pixbuf copy ();
		[NoArrayLength ()]
		[CCode (cname = "gdk_pixbuf_copy_area")]
		public void copy_area (int src_x, int src_y, int width, int height, Gdk.Pixbuf dest_pixbuf, int dest_x, int dest_y);
		[NoArrayLength ()]
		[CCode (cname = "gdk_pixbuf_error_quark")]
		public static GLib.Quark error_quark ();
		[NoArrayLength ()]
		[CCode (cname = "gdk_pixbuf_fill")]
		public void fill (uint pixel);
		[NoArrayLength ()]
		[CCode (cname = "gdk_pixbuf_flip")]
		public Gdk.Pixbuf flip (bool horizontal);
		[NoArrayLength ()]
		[CCode (cname = "gdk_pixbuf_from_pixdata")]
		public static Gdk.Pixbuf from_pixdata (Gdk.Pixdata pixdata, bool copy_pixels, GLib.Error error);
		[NoArrayLength ()]
		[CCode (cname = "gdk_pixbuf_get_bits_per_sample")]
		public int get_bits_per_sample ();
		[NoArrayLength ()]
		[CCode (cname = "gdk_pixbuf_get_colorspace")]
		public Gdk.Colorspace get_colorspace ();
		[NoArrayLength ()]
		[CCode (cname = "gdk_pixbuf_get_file_info")]
		public static Gdk.PixbufFormat get_file_info (string filename, int width, int height);
		[NoArrayLength ()]
		[CCode (cname = "gdk_pixbuf_get_formats")]
		public static GLib.SList get_formats ();
		[NoArrayLength ()]
		[CCode (cname = "gdk_pixbuf_get_from_drawable")]
		public Gdk.Pixbuf get_from_drawable (Gdk.Drawable src, Gdk.Colormap cmap, int src_x, int src_y, int dest_x, int dest_y, int width, int height);
		[NoArrayLength ()]
		[CCode (cname = "gdk_pixbuf_get_from_image")]
		public Gdk.Pixbuf get_from_image (Gdk.Image src, Gdk.Colormap cmap, int src_x, int src_y, int dest_x, int dest_y, int width, int height);
		[NoArrayLength ()]
		[CCode (cname = "gdk_pixbuf_get_has_alpha")]
		public bool get_has_alpha ();
		[NoArrayLength ()]
		[CCode (cname = "gdk_pixbuf_get_height")]
		public int get_height ();
		[NoArrayLength ()]
		[CCode (cname = "gdk_pixbuf_get_n_channels")]
		public int get_n_channels ();
		[NoArrayLength ()]
		[CCode (cname = "gdk_pixbuf_get_option")]
		public string get_option (string key);
		[NoArrayLength ()]
		[CCode (cname = "gdk_pixbuf_get_pixels")]
		public uchar[] get_pixels ();
		[NoArrayLength ()]
		[CCode (cname = "gdk_pixbuf_get_rowstride")]
		public int get_rowstride ();
		[NoArrayLength ()]
		[CCode (cname = "gdk_pixbuf_get_type")]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		[CCode (cname = "gdk_pixbuf_get_width")]
		public int get_width ();
		[NoArrayLength ()]
		[CCode (cname = "gdk_pixbuf_new")]
		public Pixbuf (Gdk.Colorspace colorspace, bool has_alpha, int bits_per_sample, int width, int height);
		[NoArrayLength ()]
		[CCode (cname = "gdk_pixbuf_new_from_data")]
		public Pixbuf.from_data (uchar[] data, Gdk.Colorspace colorspace, bool has_alpha, int bits_per_sample, int width, int height, int rowstride, Gdk.PixbufDestroyNotify destroy_fn, pointer destroy_fn_data);
		[NoArrayLength ()]
		[CCode (cname = "gdk_pixbuf_new_from_file")]
		public Pixbuf.from_file (string filename, GLib.Error error);
		[NoArrayLength ()]
		[CCode (cname = "gdk_pixbuf_new_from_file_at_scale")]
		public Pixbuf.from_file_at_scale (string filename, int width, int height, bool preserve_aspect_ratio, GLib.Error error);
		[NoArrayLength ()]
		[CCode (cname = "gdk_pixbuf_new_from_file_at_size")]
		public Pixbuf.from_file_at_size (string filename, int width, int height, GLib.Error error);
		[NoArrayLength ()]
		[CCode (cname = "gdk_pixbuf_new_from_inline")]
		public Pixbuf.from_inline (int data_length, uchar[] data, bool copy_pixels, GLib.Error error);
		[NoArrayLength ()]
		[CCode (cname = "gdk_pixbuf_new_from_xpm_data")]
		public Pixbuf.from_xpm_data (string data);
		[NoArrayLength ()]
		[CCode (cname = "gdk_pixbuf_new_subpixbuf")]
		public Pixbuf.subpixbuf (int src_x, int src_y, int width, int height);
		[NoArrayLength ()]
		[CCode (cname = "gdk_pixbuf_render_pixmap_and_mask")]
		public void render_pixmap_and_mask (Gdk.Pixmap pixmap_return, Gdk.Bitmap mask_return, int alpha_threshold);
		[NoArrayLength ()]
		[CCode (cname = "gdk_pixbuf_render_pixmap_and_mask_for_colormap")]
		public void render_pixmap_and_mask_for_colormap (Gdk.Colormap colormap, Gdk.Pixmap pixmap_return, Gdk.Bitmap mask_return, int alpha_threshold);
		[NoArrayLength ()]
		[CCode (cname = "gdk_pixbuf_render_threshold_alpha")]
		public void render_threshold_alpha (Gdk.Bitmap bitmap, int src_x, int src_y, int dest_x, int dest_y, int width, int height, int alpha_threshold);
		[NoArrayLength ()]
		[CCode (cname = "gdk_pixbuf_rotate_simple")]
		public Gdk.Pixbuf rotate_simple (Gdk.PixbufRotation angle);
		[NoArrayLength ()]
		[CCode (cname = "gdk_pixbuf_saturate_and_pixelate")]
		public void saturate_and_pixelate (Gdk.Pixbuf dest, float saturation, bool pixelate);
		[NoArrayLength ()]
		[CCode (cname = "gdk_pixbuf_save")]
		public bool save (string filename, string type, GLib.Error error);
		[NoArrayLength ()]
		[CCode (cname = "gdk_pixbuf_save_to_buffer")]
		public bool save_to_buffer (string buffer, ulong buffer_size, string type, GLib.Error error);
		[NoArrayLength ()]
		[CCode (cname = "gdk_pixbuf_save_to_bufferv")]
		public bool save_to_bufferv (string buffer, ulong buffer_size, string type, string option_keys, string option_values, GLib.Error error);
		[NoArrayLength ()]
		[CCode (cname = "gdk_pixbuf_save_to_callback")]
		public bool save_to_callback (Gdk.PixbufSaveFunc save_func, pointer user_data, string type, GLib.Error error);
		[NoArrayLength ()]
		[CCode (cname = "gdk_pixbuf_save_to_callbackv")]
		public bool save_to_callbackv (Gdk.PixbufSaveFunc save_func, pointer user_data, string type, string option_keys, string option_values, GLib.Error error);
		[NoArrayLength ()]
		[CCode (cname = "gdk_pixbuf_savev")]
		public bool savev (string filename, string type, string option_keys, string option_values, GLib.Error error);
		[NoArrayLength ()]
		[CCode (cname = "gdk_pixbuf_scale")]
		public void scale (Gdk.Pixbuf dest, int dest_x, int dest_y, int dest_width, int dest_height, double offset_x, double offset_y, double scale_x, double scale_y, Gdk.InterpType interp_type);
		[NoArrayLength ()]
		[CCode (cname = "gdk_pixbuf_scale_simple")]
		public Gdk.Pixbuf scale_simple (int dest_width, int dest_height, Gdk.InterpType interp_type);
		[NoAccessorMethod ()]
		public weak int n_channels { get; set; }
		[NoAccessorMethod ()]
		public weak Gdk.Colorspace colorspace { get; set; }
		[NoAccessorMethod ()]
		public weak bool has_alpha { get; set; }
		[NoAccessorMethod ()]
		public weak int bits_per_sample { get; set; }
		[NoAccessorMethod ()]
		public weak int width { get; set; }
		[NoAccessorMethod ()]
		public weak int height { get; set; }
		[NoAccessorMethod ()]
		public weak int rowstride { get; set; }
		[NoAccessorMethod ()]
		public weak pointer pixels { get; set; }
	}
	[CCode (cheader_filename = "gdk/gdk.h")]
	public class PixbufAnimation : GLib.Object {
		[NoArrayLength ()]
		[CCode (cname = "gdk_pixbuf_animation_get_height")]
		public int get_height ();
		[NoArrayLength ()]
		[CCode (cname = "gdk_pixbuf_animation_get_iter")]
		public Gdk.PixbufAnimationIter get_iter (GLib.TimeVal start_time);
		[NoArrayLength ()]
		[CCode (cname = "gdk_pixbuf_animation_get_static_image")]
		public Gdk.Pixbuf get_static_image ();
		[NoArrayLength ()]
		[CCode (cname = "gdk_pixbuf_animation_get_type")]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		[CCode (cname = "gdk_pixbuf_animation_get_width")]
		public int get_width ();
		[NoArrayLength ()]
		[CCode (cname = "gdk_pixbuf_animation_is_static_image")]
		public bool is_static_image ();
		[NoArrayLength ()]
		[CCode (cname = "gdk_pixbuf_animation_new_from_file")]
		public PixbufAnimation.from_file (string filename, GLib.Error error);
	}
	[CCode (cheader_filename = "gdk/gdk.h")]
	public class PixbufAnimationIter : GLib.Object {
		[NoArrayLength ()]
		[CCode (cname = "gdk_pixbuf_animation_iter_advance")]
		public bool advance (GLib.TimeVal current_time);
		[NoArrayLength ()]
		[CCode (cname = "gdk_pixbuf_animation_iter_get_delay_time")]
		public int get_delay_time ();
		[NoArrayLength ()]
		[CCode (cname = "gdk_pixbuf_animation_iter_get_pixbuf")]
		public Gdk.Pixbuf get_pixbuf ();
		[NoArrayLength ()]
		[CCode (cname = "gdk_pixbuf_animation_iter_get_type")]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		[CCode (cname = "gdk_pixbuf_animation_iter_on_currently_loading_frame")]
		public bool on_currently_loading_frame ();
	}
	[CCode (cheader_filename = "gdk/gdk.h")]
	public class PixbufAniAnim : Gdk.PixbufAnimation {
		[NoArrayLength ()]
		[CCode (cname = "gdk_pixbuf_ani_anim_get_type")]
		public static GLib.Type get_type ();
	}
	[CCode (cheader_filename = "gdk/gdk.h")]
	public class PixbufAniAnimIter : Gdk.PixbufAnimationIter {
		[NoArrayLength ()]
		[CCode (cname = "gdk_pixbuf_ani_anim_iter_get_type")]
		public static GLib.Type get_type ();
	}
	[CCode (cheader_filename = "gdk/gdk.h")]
	public class PixbufGifAnim : Gdk.PixbufAnimation {
		[NoArrayLength ()]
		[CCode (cname = "gdk_pixbuf_gif_anim_frame_composite")]
		public void frame_composite (Gdk.PixbufFrame frame);
		[NoArrayLength ()]
		[CCode (cname = "gdk_pixbuf_gif_anim_get_type")]
		public static GLib.Type get_type ();
	}
	[CCode (cheader_filename = "gdk/gdk.h")]
	public class PixbufGifAnimIter : Gdk.PixbufAnimationIter {
		[NoArrayLength ()]
		[CCode (cname = "gdk_pixbuf_gif_anim_iter_get_type")]
		public static GLib.Type get_type ();
	}
	[CCode (cheader_filename = "gdk/gdk.h")]
	public class PixbufLoader : GLib.Object {
		[NoArrayLength ()]
		[CCode (cname = "gdk_pixbuf_loader_close")]
		public bool close (GLib.Error error);
		[NoArrayLength ()]
		[CCode (cname = "gdk_pixbuf_loader_get_animation")]
		public Gdk.PixbufAnimation get_animation ();
		[NoArrayLength ()]
		[CCode (cname = "gdk_pixbuf_loader_get_format")]
		public Gdk.PixbufFormat get_format ();
		[NoArrayLength ()]
		[CCode (cname = "gdk_pixbuf_loader_get_pixbuf")]
		public Gdk.Pixbuf get_pixbuf ();
		[NoArrayLength ()]
		[CCode (cname = "gdk_pixbuf_loader_get_type")]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		[CCode (cname = "gdk_pixbuf_loader_new")]
		public PixbufLoader ();
		[NoArrayLength ()]
		[CCode (cname = "gdk_pixbuf_loader_new_with_mime_type")]
		public PixbufLoader.with_mime_type (string mime_type, GLib.Error error);
		[NoArrayLength ()]
		[CCode (cname = "gdk_pixbuf_loader_new_with_type")]
		public PixbufLoader.with_type (string image_type, GLib.Error error);
		[NoArrayLength ()]
		[CCode (cname = "gdk_pixbuf_loader_set_size")]
		public void set_size (int width, int height);
		[NoArrayLength ()]
		[CCode (cname = "gdk_pixbuf_loader_write")]
		public bool write (uchar[] buf, ulong count, GLib.Error error);
		public signal void size_prepared (int width, int height);
		public signal void area_prepared ();
		public signal void area_updated (int x, int y, int width, int height);
		public signal void closed ();
	}
	[CCode (cheader_filename = "gdk/gdk.h")]
	public class PixbufSimpleAnim : Gdk.PixbufAnimation {
		[NoArrayLength ()]
		[CCode (cname = "gdk_pixbuf_simple_anim_add_frame")]
		public void add_frame (Gdk.Pixbuf pixbuf);
		[NoArrayLength ()]
		[CCode (cname = "gdk_pixbuf_simple_anim_get_type")]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		[CCode (cname = "gdk_pixbuf_simple_anim_iter_get_type")]
		public static GLib.Type iter_get_type ();
		[NoArrayLength ()]
		[CCode (cname = "gdk_pixbuf_simple_anim_new")]
		public PixbufSimpleAnim (int width, int height, float rate);
	}
	[CCode (cheader_filename = "gdk/gdk.h")]
	public class Pixmap : GLib.Object {
		[NoArrayLength ()]
		[CCode (cname = "gdk_pixmap_colormap_create_from_xpm")]
		public static Gdk.Pixmap colormap_create_from_xpm (Gdk.Drawable drawable, Gdk.Colormap colormap, Gdk.Bitmap mask, Gdk.Color transparent_color, string filename);
		[NoArrayLength ()]
		[CCode (cname = "gdk_pixmap_colormap_create_from_xpm_d")]
		public static Gdk.Pixmap colormap_create_from_xpm_d (Gdk.Drawable drawable, Gdk.Colormap colormap, Gdk.Bitmap mask, Gdk.Color transparent_color, string data);
		[NoArrayLength ()]
		[CCode (cname = "gdk_pixmap_create_from_data")]
		public static Gdk.Pixmap create_from_data (Gdk.Drawable drawable, string data, int width, int height, int depth, Gdk.Color fg, Gdk.Color bg);
		[NoArrayLength ()]
		[CCode (cname = "gdk_pixmap_create_from_xpm")]
		public static Gdk.Pixmap create_from_xpm (Gdk.Drawable drawable, Gdk.Bitmap mask, Gdk.Color transparent_color, string filename);
		[NoArrayLength ()]
		[CCode (cname = "gdk_pixmap_create_from_xpm_d")]
		public static Gdk.Pixmap create_from_xpm_d (Gdk.Drawable drawable, Gdk.Bitmap mask, Gdk.Color transparent_color, string data);
		[NoArrayLength ()]
		[CCode (cname = "gdk_pixmap_foreign_new")]
		public static Gdk.Pixmap foreign_new (pointer anid);
		[NoArrayLength ()]
		[CCode (cname = "gdk_pixmap_foreign_new_for_display")]
		public static Gdk.Pixmap foreign_new_for_display (Gdk.Display display, pointer anid);
		[NoArrayLength ()]
		[CCode (cname = "gdk_pixmap_foreign_new_for_screen")]
		public static Gdk.Pixmap foreign_new_for_screen (Gdk.Screen screen, pointer anid, int width, int height, int depth);
		[NoArrayLength ()]
		[CCode (cname = "gdk_pixmap_get_type")]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		[CCode (cname = "gdk_pixmap_lookup")]
		public static Gdk.Pixmap lookup (pointer anid);
		[NoArrayLength ()]
		[CCode (cname = "gdk_pixmap_lookup_for_display")]
		public static Gdk.Pixmap lookup_for_display (Gdk.Display display, pointer anid);
		[NoArrayLength ()]
		[CCode (cname = "gdk_pixmap_new")]
		public Pixmap (Gdk.Drawable drawable, int width, int height, int depth);
	}
	[CCode (cheader_filename = "gdk/gdk.h")]
	public class Screen : GLib.Object {
		[NoArrayLength ()]
		[CCode (cname = "gdk_screen_broadcast_client_message")]
		public void broadcast_client_message (Gdk.Event event);
		[NoArrayLength ()]
		[CCode (cname = "gdk_screen_get_active_window")]
		public Gdk.Window get_active_window ();
		[NoArrayLength ()]
		[CCode (cname = "gdk_screen_get_default")]
		public static Gdk.Screen get_default ();
		[NoArrayLength ()]
		[CCode (cname = "gdk_screen_get_default_colormap")]
		public Gdk.Colormap get_default_colormap ();
		[NoArrayLength ()]
		[CCode (cname = "gdk_screen_get_display")]
		public Gdk.Display get_display ();
		[NoArrayLength ()]
		[CCode (cname = "gdk_screen_get_font_options")]
		public pointer get_font_options ();
		[NoArrayLength ()]
		[CCode (cname = "gdk_screen_get_height")]
		public int get_height ();
		[NoArrayLength ()]
		[CCode (cname = "gdk_screen_get_height_mm")]
		public int get_height_mm ();
		[NoArrayLength ()]
		[CCode (cname = "gdk_screen_get_monitor_at_point")]
		public int get_monitor_at_point (int x, int y);
		[NoArrayLength ()]
		[CCode (cname = "gdk_screen_get_monitor_at_window")]
		public int get_monitor_at_window (Gdk.Window window);
		[NoArrayLength ()]
		[CCode (cname = "gdk_screen_get_monitor_geometry")]
		public void get_monitor_geometry (int monitor_num, Gdk.Rectangle dest);
		[NoArrayLength ()]
		[CCode (cname = "gdk_screen_get_n_monitors")]
		public int get_n_monitors ();
		[NoArrayLength ()]
		[CCode (cname = "gdk_screen_get_number")]
		public int get_number ();
		[NoArrayLength ()]
		[CCode (cname = "gdk_screen_get_resolution")]
		public double get_resolution ();
		[NoArrayLength ()]
		[CCode (cname = "gdk_screen_get_rgb_colormap")]
		public Gdk.Colormap get_rgb_colormap ();
		[NoArrayLength ()]
		[CCode (cname = "gdk_screen_get_rgb_visual")]
		public Gdk.Visual get_rgb_visual ();
		[NoArrayLength ()]
		[CCode (cname = "gdk_screen_get_rgba_colormap")]
		public Gdk.Colormap get_rgba_colormap ();
		[NoArrayLength ()]
		[CCode (cname = "gdk_screen_get_rgba_visual")]
		public Gdk.Visual get_rgba_visual ();
		[NoArrayLength ()]
		[CCode (cname = "gdk_screen_get_root_window")]
		public Gdk.Window get_root_window ();
		[NoArrayLength ()]
		[CCode (cname = "gdk_screen_get_setting")]
		public bool get_setting (string name, GLib.Value value);
		[NoArrayLength ()]
		[CCode (cname = "gdk_screen_get_system_colormap")]
		public Gdk.Colormap get_system_colormap ();
		[NoArrayLength ()]
		[CCode (cname = "gdk_screen_get_system_visual")]
		public Gdk.Visual get_system_visual ();
		[NoArrayLength ()]
		[CCode (cname = "gdk_screen_get_toplevel_windows")]
		public GLib.List get_toplevel_windows ();
		[NoArrayLength ()]
		[CCode (cname = "gdk_screen_get_type")]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		[CCode (cname = "gdk_screen_get_width")]
		public int get_width ();
		[NoArrayLength ()]
		[CCode (cname = "gdk_screen_get_width_mm")]
		public int get_width_mm ();
		[NoArrayLength ()]
		[CCode (cname = "gdk_screen_get_window_stack")]
		public GLib.List get_window_stack ();
		[NoArrayLength ()]
		[CCode (cname = "gdk_screen_height")]
		public static int height ();
		[NoArrayLength ()]
		[CCode (cname = "gdk_screen_height_mm")]
		public static int height_mm ();
		[NoArrayLength ()]
		[CCode (cname = "gdk_screen_is_composited")]
		public bool is_composited ();
		[NoArrayLength ()]
		[CCode (cname = "gdk_screen_list_visuals")]
		public GLib.List list_visuals ();
		[NoArrayLength ()]
		[CCode (cname = "gdk_screen_make_display_name")]
		public string make_display_name ();
		[NoArrayLength ()]
		[CCode (cname = "gdk_screen_set_default_colormap")]
		public void set_default_colormap (Gdk.Colormap colormap);
		[NoArrayLength ()]
		[CCode (cname = "gdk_screen_set_font_options")]
		public void set_font_options (pointer options);
		[NoArrayLength ()]
		[CCode (cname = "gdk_screen_set_resolution")]
		public void set_resolution (double dpi);
		[NoArrayLength ()]
		[CCode (cname = "gdk_screen_width")]
		public static int width ();
		[NoArrayLength ()]
		[CCode (cname = "gdk_screen_width_mm")]
		public static int width_mm ();
		public weak pointer font_options { get; set; }
		public weak double resolution { get; set; }
		public signal void size_changed ();
		public signal void composited_changed ();
	}
	[CCode (cheader_filename = "gdk/gdk.h")]
	public class Visual : GLib.Object {
		[NoArrayLength ()]
		[CCode (cname = "gdk_visual_get_best")]
		public static Gdk.Visual get_best ();
		[NoArrayLength ()]
		[CCode (cname = "gdk_visual_get_best_depth")]
		public static int get_best_depth ();
		[NoArrayLength ()]
		[CCode (cname = "gdk_visual_get_best_type")]
		public static Gdk.VisualType get_best_type ();
		[NoArrayLength ()]
		[CCode (cname = "gdk_visual_get_best_with_both")]
		public static Gdk.Visual get_best_with_both (int depth, Gdk.VisualType visual_type);
		[NoArrayLength ()]
		[CCode (cname = "gdk_visual_get_best_with_depth")]
		public static Gdk.Visual get_best_with_depth (int depth);
		[NoArrayLength ()]
		[CCode (cname = "gdk_visual_get_best_with_type")]
		public static Gdk.Visual get_best_with_type (Gdk.VisualType visual_type);
		[NoArrayLength ()]
		[CCode (cname = "gdk_visual_get_screen")]
		public Gdk.Screen get_screen ();
		[NoArrayLength ()]
		[CCode (cname = "gdk_visual_get_system")]
		public static Gdk.Visual get_system ();
		[NoArrayLength ()]
		[CCode (cname = "gdk_visual_get_type")]
		public static GLib.Type get_type ();
	}
	[CCode (cheader_filename = "gdk/gdk.h")]
	public class Window : Gdk.Drawable {
		[NoArrayLength ()]
		[CCode (cname = "gdk_window_add_filter")]
		public void add_filter (Gdk.FilterFunc function, pointer data);
		[NoArrayLength ()]
		[CCode (cname = "gdk_window_at_pointer")]
		public static Gdk.Window at_pointer (int win_x, int win_y);
		[NoArrayLength ()]
		[CCode (cname = "gdk_window_begin_move_drag")]
		public void begin_move_drag (int button, int root_x, int root_y, uint timestamp);
		[NoArrayLength ()]
		[CCode (cname = "gdk_window_begin_paint_rect")]
		public void begin_paint_rect (Gdk.Rectangle rectangle);
		[NoArrayLength ()]
		[CCode (cname = "gdk_window_begin_paint_region")]
		public void begin_paint_region (Gdk.Region region);
		[NoArrayLength ()]
		[CCode (cname = "gdk_window_begin_resize_drag")]
		public void begin_resize_drag (Gdk.WindowEdge edge, int button, int root_x, int root_y, uint timestamp);
		[NoArrayLength ()]
		[CCode (cname = "gdk_window_clear")]
		public void clear ();
		[NoArrayLength ()]
		[CCode (cname = "gdk_window_clear_area")]
		public void clear_area (int x, int y, int width, int height);
		[NoArrayLength ()]
		[CCode (cname = "gdk_window_clear_area_e")]
		public void clear_area_e (int x, int y, int width, int height);
		[NoArrayLength ()]
		[CCode (cname = "gdk_window_configure_finished")]
		public void configure_finished ();
		[NoArrayLength ()]
		[CCode (cname = "gdk_window_constrain_size")]
		public static void constrain_size (Gdk.Geometry geometry, uint @flags, int width, int height, int new_width, int new_height);
		[NoArrayLength ()]
		[CCode (cname = "gdk_window_deiconify")]
		public void deiconify ();
		[NoArrayLength ()]
		[CCode (cname = "gdk_window_destroy")]
		public void destroy ();
		[NoArrayLength ()]
		[CCode (cname = "gdk_window_enable_synchronized_configure")]
		public void enable_synchronized_configure ();
		[NoArrayLength ()]
		[CCode (cname = "gdk_window_end_paint")]
		public void end_paint ();
		[NoArrayLength ()]
		[CCode (cname = "gdk_window_focus")]
		public void focus (uint timestamp);
		[NoArrayLength ()]
		[CCode (cname = "gdk_window_foreign_new")]
		public static Gdk.Window foreign_new (pointer anid);
		[NoArrayLength ()]
		[CCode (cname = "gdk_window_foreign_new_for_display")]
		public static Gdk.Window foreign_new_for_display (Gdk.Display display, pointer anid);
		[NoArrayLength ()]
		[CCode (cname = "gdk_window_freeze_updates")]
		public void freeze_updates ();
		[NoArrayLength ()]
		[CCode (cname = "gdk_window_fullscreen")]
		public void fullscreen ();
		[NoArrayLength ()]
		[CCode (cname = "gdk_window_get_children")]
		public GLib.List get_children ();
		[NoArrayLength ()]
		[CCode (cname = "gdk_window_get_decorations")]
		public bool get_decorations (Gdk.WMDecoration decorations);
		[NoArrayLength ()]
		[CCode (cname = "gdk_window_get_events")]
		public Gdk.EventMask get_events ();
		[NoArrayLength ()]
		[CCode (cname = "gdk_window_get_frame_extents")]
		public void get_frame_extents (Gdk.Rectangle rect);
		[NoArrayLength ()]
		[CCode (cname = "gdk_window_get_geometry")]
		public void get_geometry (int x, int y, int width, int height, int depth);
		[NoArrayLength ()]
		[CCode (cname = "gdk_window_get_group")]
		public Gdk.Window get_group ();
		[NoArrayLength ()]
		[CCode (cname = "gdk_window_get_internal_paint_info")]
		public void get_internal_paint_info (Gdk.Drawable real_drawable, int x_offset, int y_offset);
		[NoArrayLength ()]
		[CCode (cname = "gdk_window_get_origin")]
		public int get_origin (int x, int y);
		[NoArrayLength ()]
		[CCode (cname = "gdk_window_get_parent")]
		public Gdk.Window get_parent ();
		[NoArrayLength ()]
		[CCode (cname = "gdk_window_get_pointer")]
		public Gdk.Window get_pointer (int x, int y, Gdk.ModifierType mask);
		[NoArrayLength ()]
		[CCode (cname = "gdk_window_get_position")]
		public void get_position (int x, int y);
		[NoArrayLength ()]
		[CCode (cname = "gdk_window_get_root_origin")]
		public void get_root_origin (int x, int y);
		[NoArrayLength ()]
		[CCode (cname = "gdk_window_get_state")]
		public Gdk.WindowState get_state ();
		[NoArrayLength ()]
		[CCode (cname = "gdk_window_get_toplevel")]
		public Gdk.Window get_toplevel ();
		[NoArrayLength ()]
		[CCode (cname = "gdk_window_get_toplevels")]
		public static GLib.List get_toplevels ();
		[NoArrayLength ()]
		[CCode (cname = "gdk_window_get_type_hint")]
		public Gdk.WindowTypeHint get_type_hint ();
		[NoArrayLength ()]
		[CCode (cname = "gdk_window_get_update_area")]
		public Gdk.Region get_update_area ();
		[NoArrayLength ()]
		[CCode (cname = "gdk_window_get_user_data")]
		public void get_user_data (pointer data);
		[NoArrayLength ()]
		[CCode (cname = "gdk_window_get_window_type")]
		public Gdk.WindowType get_window_type ();
		[NoArrayLength ()]
		[CCode (cname = "gdk_window_hide")]
		public void hide ();
		[NoArrayLength ()]
		[CCode (cname = "gdk_window_iconify")]
		public void iconify ();
		[NoArrayLength ()]
		[CCode (cname = "gdk_window_input_shape_combine_mask")]
		public void input_shape_combine_mask (Gdk.Bitmap mask, int x, int y);
		[NoArrayLength ()]
		[CCode (cname = "gdk_window_input_shape_combine_region")]
		public void input_shape_combine_region (Gdk.Region shape_region, int offset_x, int offset_y);
		[NoArrayLength ()]
		[CCode (cname = "gdk_window_invalidate_maybe_recurse")]
		public void invalidate_maybe_recurse (Gdk.Region region, Gdk.invalidate_maybe_recurseChildFunc child_func, pointer user_data);
		[NoArrayLength ()]
		[CCode (cname = "gdk_window_invalidate_rect")]
		public void invalidate_rect (Gdk.Rectangle rect, bool invalidate_children);
		[NoArrayLength ()]
		[CCode (cname = "gdk_window_invalidate_region")]
		public void invalidate_region (Gdk.Region region, bool invalidate_children);
		[NoArrayLength ()]
		[CCode (cname = "gdk_window_is_viewable")]
		public bool is_viewable ();
		[NoArrayLength ()]
		[CCode (cname = "gdk_window_is_visible")]
		public bool is_visible ();
		[NoArrayLength ()]
		[CCode (cname = "gdk_window_lookup")]
		public static Gdk.Window lookup (pointer anid);
		[NoArrayLength ()]
		[CCode (cname = "gdk_window_lookup_for_display")]
		public static Gdk.Window lookup_for_display (Gdk.Display display, pointer anid);
		[NoArrayLength ()]
		[CCode (cname = "gdk_window_lower")]
		public void lower ();
		[NoArrayLength ()]
		[CCode (cname = "gdk_window_maximize")]
		public void maximize ();
		[NoArrayLength ()]
		[CCode (cname = "gdk_window_merge_child_input_shapes")]
		public void merge_child_input_shapes ();
		[NoArrayLength ()]
		[CCode (cname = "gdk_window_merge_child_shapes")]
		public void merge_child_shapes ();
		[NoArrayLength ()]
		[CCode (cname = "gdk_window_move")]
		public void move (int x, int y);
		[NoArrayLength ()]
		[CCode (cname = "gdk_window_move_region")]
		public void move_region (Gdk.Region region, int dx, int dy);
		[NoArrayLength ()]
		[CCode (cname = "gdk_window_move_resize")]
		public void move_resize (int x, int y, int width, int height);
		[NoArrayLength ()]
		[CCode (cname = "gdk_window_new")]
		public Window (Gdk.WindowAttr attributes, int attributes_mask);
		[NoArrayLength ()]
		[CCode (cname = "gdk_window_peek_children")]
		public GLib.List peek_children ();
		[NoArrayLength ()]
		[CCode (cname = "gdk_window_process_all_updates")]
		public static void process_all_updates ();
		[NoArrayLength ()]
		[CCode (cname = "gdk_window_process_updates")]
		public void process_updates (bool update_children);
		[NoArrayLength ()]
		[CCode (cname = "gdk_window_raise")]
		public void raise ();
		[NoArrayLength ()]
		[CCode (cname = "gdk_window_register_dnd")]
		public void register_dnd ();
		[NoArrayLength ()]
		[CCode (cname = "gdk_window_remove_filter")]
		public void remove_filter (Gdk.FilterFunc function, pointer data);
		[NoArrayLength ()]
		[CCode (cname = "gdk_window_reparent")]
		public void reparent (Gdk.Window new_parent, int x, int y);
		[NoArrayLength ()]
		[CCode (cname = "gdk_window_resize")]
		public void resize (int width, int height);
		[NoArrayLength ()]
		[CCode (cname = "gdk_window_scroll")]
		public void scroll (int dx, int dy);
		[NoArrayLength ()]
		[CCode (cname = "gdk_window_set_accept_focus")]
		public void set_accept_focus (bool accept_focus);
		[NoArrayLength ()]
		[CCode (cname = "gdk_window_set_back_pixmap")]
		public void set_back_pixmap (Gdk.Pixmap pixmap, bool parent_relative);
		[NoArrayLength ()]
		[CCode (cname = "gdk_window_set_background")]
		public void set_background (Gdk.Color color);
		[NoArrayLength ()]
		[CCode (cname = "gdk_window_set_child_input_shapes")]
		public void set_child_input_shapes ();
		[NoArrayLength ()]
		[CCode (cname = "gdk_window_set_child_shapes")]
		public void set_child_shapes ();
		[NoArrayLength ()]
		[CCode (cname = "gdk_window_set_cursor")]
		public void set_cursor (Gdk.Cursor cursor);
		[NoArrayLength ()]
		[CCode (cname = "gdk_window_set_debug_updates")]
		public static void set_debug_updates (bool setting);
		[NoArrayLength ()]
		[CCode (cname = "gdk_window_set_decorations")]
		public void set_decorations (Gdk.WMDecoration decorations);
		[NoArrayLength ()]
		[CCode (cname = "gdk_window_set_events")]
		public void set_events (Gdk.EventMask event_mask);
		[NoArrayLength ()]
		[CCode (cname = "gdk_window_set_focus_on_map")]
		public void set_focus_on_map (bool focus_on_map);
		[NoArrayLength ()]
		[CCode (cname = "gdk_window_set_functions")]
		public void set_functions (Gdk.WMFunction functions);
		[NoArrayLength ()]
		[CCode (cname = "gdk_window_set_geometry_hints")]
		public void set_geometry_hints (Gdk.Geometry geometry, Gdk.WindowHints geom_mask);
		[NoArrayLength ()]
		[CCode (cname = "gdk_window_set_group")]
		public void set_group (Gdk.Window leader);
		[NoArrayLength ()]
		[CCode (cname = "gdk_window_set_icon")]
		public void set_icon (Gdk.Window icon_window, Gdk.Pixmap pixmap, Gdk.Bitmap mask);
		[NoArrayLength ()]
		[CCode (cname = "gdk_window_set_icon_list")]
		public void set_icon_list (GLib.List pixbufs);
		[NoArrayLength ()]
		[CCode (cname = "gdk_window_set_icon_name")]
		public void set_icon_name (string name);
		[NoArrayLength ()]
		[CCode (cname = "gdk_window_set_keep_above")]
		public void set_keep_above (bool setting);
		[NoArrayLength ()]
		[CCode (cname = "gdk_window_set_keep_below")]
		public void set_keep_below (bool setting);
		[NoArrayLength ()]
		[CCode (cname = "gdk_window_set_modal_hint")]
		public void set_modal_hint (bool modal);
		[NoArrayLength ()]
		[CCode (cname = "gdk_window_set_override_redirect")]
		public void set_override_redirect (bool override_redirect);
		[NoArrayLength ()]
		[CCode (cname = "gdk_window_set_role")]
		public void set_role (string role);
		[NoArrayLength ()]
		[CCode (cname = "gdk_window_set_skip_pager_hint")]
		public void set_skip_pager_hint (bool skips_pager);
		[NoArrayLength ()]
		[CCode (cname = "gdk_window_set_skip_taskbar_hint")]
		public void set_skip_taskbar_hint (bool skips_taskbar);
		[NoArrayLength ()]
		[CCode (cname = "gdk_window_set_static_gravities")]
		public bool set_static_gravities (bool use_static);
		[NoArrayLength ()]
		[CCode (cname = "gdk_window_set_title")]
		public void set_title (string title);
		[NoArrayLength ()]
		[CCode (cname = "gdk_window_set_transient_for")]
		public void set_transient_for (Gdk.Window parent);
		[NoArrayLength ()]
		[CCode (cname = "gdk_window_set_type_hint")]
		public void set_type_hint (Gdk.WindowTypeHint hint);
		[NoArrayLength ()]
		[CCode (cname = "gdk_window_set_urgency_hint")]
		public void set_urgency_hint (bool urgent);
		[NoArrayLength ()]
		[CCode (cname = "gdk_window_set_user_data")]
		public void set_user_data (pointer user_data);
		[NoArrayLength ()]
		[CCode (cname = "gdk_window_shape_combine_mask")]
		public void shape_combine_mask (Gdk.Bitmap mask, int x, int y);
		[NoArrayLength ()]
		[CCode (cname = "gdk_window_shape_combine_region")]
		public void shape_combine_region (Gdk.Region shape_region, int offset_x, int offset_y);
		[NoArrayLength ()]
		[CCode (cname = "gdk_window_show")]
		public void show ();
		[NoArrayLength ()]
		[CCode (cname = "gdk_window_show_unraised")]
		public void show_unraised ();
		[NoArrayLength ()]
		[CCode (cname = "gdk_window_stick")]
		public void stick ();
		[NoArrayLength ()]
		[CCode (cname = "gdk_window_thaw_updates")]
		public void thaw_updates ();
		[NoArrayLength ()]
		[CCode (cname = "gdk_window_unfullscreen")]
		public void unfullscreen ();
		[NoArrayLength ()]
		[CCode (cname = "gdk_window_unmaximize")]
		public void unmaximize ();
		[NoArrayLength ()]
		[CCode (cname = "gdk_window_unstick")]
		public void unstick ();
		[NoArrayLength ()]
		[CCode (cname = "gdk_window_withdraw")]
		public void withdraw ();
	}
	[CCode (cheader_filename = "gdk/gdk.h")]
	public class Bitmap {
		public weak GLib.Object parent_instance;
		[NoArrayLength ()]
		[CCode (cname = "gdk_bitmap_create_from_data")]
		public static Gdk.Bitmap create_from_data (Gdk.Drawable drawable, string data, int width, int height);
	}
	[ReferenceType ()]
	public struct BRESINFO {
		public int minor_axis;
		public int d;
		public int m;
		public int m1;
		public int incr1;
		public int incr2;
	}
	[ReferenceType ()]
	public struct EdgeTable {
		public int ymax;
		public int ymin;
		public weak Gdk.ScanLineList scanlines;
	}
	[ReferenceType ()]
	public struct EdgeTableEntry {
	}
	public struct Color {
		public uint pixel;
		public ushort red;
		public ushort green;
		public ushort blue;
		[NoArrayLength ()]
		[InstanceByReference ()]
		[CCode (cname = "gdk_color_copy")]
		public Gdk.Color copy ();
		[NoArrayLength ()]
		[InstanceByReference ()]
		[CCode (cname = "gdk_color_equal")]
		public bool equal (Gdk.Color colorb);
		[NoArrayLength ()]
		[InstanceByReference ()]
		[CCode (cname = "gdk_color_free")]
		public void free ();
		[NoArrayLength ()]
		[CCode (cname = "gdk_color_get_type")]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		[InstanceByReference ()]
		[CCode (cname = "gdk_color_hash")]
		public uint hash ();
		[NoArrayLength ()]
		[CCode (cname = "gdk_color_parse")]
		public static bool parse (string spec, Gdk.Color color);
	}
	[ReferenceType ()]
	public struct Cursor {
		public Gdk.CursorType type;
		[NoArrayLength ()]
		[CCode (cname = "gdk_cursor_get_display")]
		public Gdk.Display get_display ();
		[NoArrayLength ()]
		[CCode (cname = "gdk_cursor_get_image")]
		public Gdk.Pixbuf get_image ();
		[NoArrayLength ()]
		[CCode (cname = "gdk_cursor_get_type")]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		[CCode (cname = "gdk_cursor_new")]
		public Cursor (Gdk.CursorType cursor_type);
		[NoArrayLength ()]
		[CCode (cname = "gdk_cursor_new_for_display")]
		public Cursor.for_display (Gdk.Display display, Gdk.CursorType cursor_type);
		[NoArrayLength ()]
		[CCode (cname = "gdk_cursor_new_from_name")]
		public Cursor.from_name (Gdk.Display display, string name);
		[NoArrayLength ()]
		[CCode (cname = "gdk_cursor_new_from_pixbuf")]
		public Cursor.from_pixbuf (Gdk.Display display, Gdk.Pixbuf pixbuf, int x, int y);
		[NoArrayLength ()]
		[CCode (cname = "gdk_cursor_new_from_pixmap")]
		public Cursor.from_pixmap (Gdk.Pixmap source, Gdk.Pixmap mask, Gdk.Color fg, Gdk.Color bg, int x, int y);
		[NoArrayLength ()]
		[CCode (cname = "gdk_cursor_ref")]
		public Gdk.Cursor @ref ();
		[NoArrayLength ()]
		[CCode (cname = "gdk_cursor_unref")]
		public void unref ();
	}
	[ReferenceType ()]
	public struct DeviceAxis {
		public Gdk.AxisUse use;
		public double min;
		public double max;
	}
	[ReferenceType ()]
	public struct DeviceKey {
		public uint keyval;
		public Gdk.ModifierType modifiers;
	}
	[ReferenceType ()]
	public struct DisplayPointerHooks {
	}
	[ReferenceType ()]
	public struct EventAny {
		public Gdk.EventType type;
		public weak Gdk.Window window;
		public char send_event;
	}
	[ReferenceType ()]
	public struct EventButton {
		public Gdk.EventType type;
		public weak Gdk.Window window;
		public char send_event;
		public uint time;
		public double x;
		public double y;
		public double axes;
		public uint state;
		public uint button;
		public weak Gdk.Device device;
		public double x_root;
		public double y_root;
	}
	[ReferenceType ()]
	public struct EventClient {
		public Gdk.EventType type;
		public weak Gdk.Window window;
		public char send_event;
		public Gdk.Atom message_type;
		public ushort data_format;
		public char b;
	}
	[ReferenceType ()]
	public struct EventConfigure {
		public Gdk.EventType type;
		public weak Gdk.Window window;
		public char send_event;
		public int x;
		public int y;
		public int width;
		public int height;
	}
	[ReferenceType ()]
	public struct EventCrossing {
		public Gdk.EventType type;
		public weak Gdk.Window window;
		public char send_event;
		public weak Gdk.Window subwindow;
		public uint time;
		public double x;
		public double y;
		public double x_root;
		public double y_root;
		public Gdk.CrossingMode mode;
		public Gdk.NotifyType detail;
		public bool focus;
		public uint state;
	}
	[ReferenceType ()]
	public struct EventDND {
		public Gdk.EventType type;
		public weak Gdk.Window window;
		public char send_event;
		public weak Gdk.DragContext context;
		public uint time;
		public short x_root;
		public short y_root;
	}
	[ReferenceType ()]
	public struct EventExpose {
		public Gdk.EventType type;
		public weak Gdk.Window window;
		public char send_event;
		public Gdk.Rectangle area;
		public weak Gdk.Region region;
		public int count;
	}
	[ReferenceType ()]
	public struct EventFocus {
		public Gdk.EventType type;
		public weak Gdk.Window window;
		public char send_event;
		public short @in;
	}
	[ReferenceType ()]
	public struct EventGrabBroken {
		public Gdk.EventType type;
		public weak Gdk.Window window;
		public char send_event;
		public bool keyboard;
		public bool implicit;
		public weak Gdk.Window grab_window;
	}
	[ReferenceType ()]
	public struct EventKey {
		public Gdk.EventType type;
		public weak Gdk.Window window;
		public char send_event;
		public uint time;
		public uint state;
		public uint keyval;
		public int length;
		public weak string string;
		public ushort hardware_keycode;
		public uchar group;
		public uint is_modifier;
	}
	[ReferenceType ()]
	public struct EventMotion {
		public Gdk.EventType type;
		public weak Gdk.Window window;
		public char send_event;
		public uint time;
		public double x;
		public double y;
		public double axes;
		public uint state;
		public short is_hint;
		public weak Gdk.Device device;
		public double x_root;
		public double y_root;
	}
	[ReferenceType ()]
	public struct EventNoExpose {
		public Gdk.EventType type;
		public weak Gdk.Window window;
		public char send_event;
	}
	[ReferenceType ()]
	public struct EventOwnerChange {
		public Gdk.EventType type;
		public weak Gdk.Window window;
		public char send_event;
		public pointer owner;
		public Gdk.OwnerChange reason;
		public Gdk.Atom selection;
		public uint time;
		public uint selection_time;
	}
	[ReferenceType ()]
	public struct EventProperty {
		public Gdk.EventType type;
		public weak Gdk.Window window;
		public char send_event;
		public Gdk.Atom atom;
		public uint time;
		public uint state;
	}
	[ReferenceType ()]
	public struct EventProximity {
		public Gdk.EventType type;
		public weak Gdk.Window window;
		public char send_event;
		public uint time;
		public weak Gdk.Device device;
	}
	[ReferenceType ()]
	public struct EventScroll {
		public Gdk.EventType type;
		public weak Gdk.Window window;
		public char send_event;
		public uint time;
		public double x;
		public double y;
		public uint state;
		public Gdk.ScrollDirection direction;
		public weak Gdk.Device device;
		public double x_root;
		public double y_root;
	}
	[ReferenceType ()]
	public struct EventSelection {
		public Gdk.EventType type;
		public weak Gdk.Window window;
		public char send_event;
		public Gdk.Atom selection;
		public Gdk.Atom target;
		public Gdk.Atom property;
		public uint time;
		public pointer requestor;
	}
	[ReferenceType ()]
	public struct EventSetting {
		public Gdk.EventType type;
		public weak Gdk.Window window;
		public char send_event;
		public Gdk.SettingAction action;
		public weak string name;
	}
	[ReferenceType ()]
	public struct EventVisibility {
		public Gdk.EventType type;
		public weak Gdk.Window window;
		public char send_event;
		public Gdk.VisibilityState state;
	}
	[ReferenceType ()]
	public struct EventWindowState {
		public Gdk.EventType type;
		public weak Gdk.Window window;
		public char send_event;
		public Gdk.WindowState changed_mask;
		public Gdk.WindowState new_window_state;
	}
	public struct Font {
		public Gdk.FontType type;
		public int ascent;
		public int descent;
	}
	[ReferenceType ()]
	public struct GCValues {
		public Gdk.Color foreground;
		public Gdk.Color background;
		public Gdk.Font font;
		public Gdk.Function function;
		public Gdk.Fill fill;
		public weak Gdk.Pixmap tile;
		public weak Gdk.Pixmap stipple;
		public weak Gdk.Pixmap clip_mask;
		public Gdk.SubwindowMode subwindow_mode;
		public int ts_x_origin;
		public int ts_y_origin;
		public int clip_x_origin;
		public int clip_y_origin;
		public int graphics_exposures;
		public int line_width;
		public Gdk.LineStyle line_style;
		public Gdk.CapStyle cap_style;
		public Gdk.JoinStyle join_style;
	}
	[ReferenceType ()]
	public struct Geometry {
		public int min_width;
		public int min_height;
		public int max_width;
		public int max_height;
		public int base_width;
		public int base_height;
		public int width_inc;
		public int height_inc;
		public double min_aspect;
		public double max_aspect;
		public Gdk.Gravity win_gravity;
	}
	[ReferenceType ()]
	public struct KeymapKey {
		public uint keycode;
		public int group;
		public int level;
	}
	[ReferenceType ()]
	public struct PangoAttrEmbossed {
		public weak Pango.Attribute attr;
		public bool embossed;
		[NoArrayLength ()]
		[CCode (cname = "gdk_pango_attr_embossed_new")]
		public PangoAttrEmbossed (bool embossed);
	}
	[ReferenceType ()]
	public struct PangoAttrStipple {
		public weak Pango.Attribute attr;
		public weak Gdk.Bitmap stipple;
		[NoArrayLength ()]
		[CCode (cname = "gdk_pango_attr_stipple_new")]
		public PangoAttrStipple (Gdk.Bitmap stipple);
	}
	[ReferenceType ()]
	public struct PixbufFormat {
		[NoArrayLength ()]
		[CCode (cname = "gdk_pixbuf_format_get_description")]
		public string get_description ();
		[NoArrayLength ()]
		[CCode (cname = "gdk_pixbuf_format_get_extensions")]
		public string get_extensions ();
		[NoArrayLength ()]
		[CCode (cname = "gdk_pixbuf_format_get_license")]
		public string get_license ();
		[NoArrayLength ()]
		[CCode (cname = "gdk_pixbuf_format_get_mime_types")]
		public string get_mime_types ();
		[NoArrayLength ()]
		[CCode (cname = "gdk_pixbuf_format_get_name")]
		public string get_name ();
		[NoArrayLength ()]
		[CCode (cname = "gdk_pixbuf_format_is_disabled")]
		public bool is_disabled ();
		[NoArrayLength ()]
		[CCode (cname = "gdk_pixbuf_format_is_scalable")]
		public bool is_scalable ();
		[NoArrayLength ()]
		[CCode (cname = "gdk_pixbuf_format_is_writable")]
		public bool is_writable ();
		[NoArrayLength ()]
		[CCode (cname = "gdk_pixbuf_format_set_disabled")]
		public void set_disabled (bool disabled);
	}
	[ReferenceType ()]
	public struct PixbufFrame {
		public weak Gdk.Pixbuf pixbuf;
		public int x_offset;
		public int y_offset;
		public int delay_time;
		public int elapsed;
		public Gdk.PixbufFrameAction action;
		public bool need_recomposite;
		public bool bg_transparent;
		public weak Gdk.Pixbuf composited;
		public weak Gdk.Pixbuf revert;
	}
	[ReferenceType ()]
	public struct Pixdata {
		public uint magic;
		public int length;
		public uint pixdata_type;
		public uint rowstride;
		public uint width;
		public uint height;
		public uchar pixel_data;
		[NoArrayLength ()]
		[CCode (cname = "gdk_pixdata_deserialize")]
		public bool deserialize (uint stream_length, uchar[] stream, GLib.Error error);
		[NoArrayLength ()]
		[CCode (cname = "gdk_pixdata_from_pixbuf")]
		public pointer from_pixbuf (Gdk.Pixbuf pixbuf, bool use_rle);
		[NoArrayLength ()]
		[CCode (cname = "gdk_pixdata_serialize")]
		public uchar serialize (uint stream_length_p);
		[NoArrayLength ()]
		[CCode (cname = "gdk_pixdata_to_csource")]
		public GLib.String to_csource (string name, Gdk.PixdataDumpType dump_type);
	}
	[ReferenceType ()]
	public struct PixmapObject {
		public weak Gdk.Drawable parent_instance;
		public weak Gdk.Drawable impl;
		public int depth;
	}
	[ReferenceType ()]
	public struct Point {
		public int x;
		public int y;
	}
	[ReferenceType ()]
	public struct PointerHooks {
	}
	public struct Rectangle {
		public int x;
		public int y;
		public int width;
		public int height;
		[NoArrayLength ()]
		[CCode (cname = "gdk_rectangle_get_type")]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		[InstanceByReference ()]
		[CCode (cname = "gdk_rectangle_intersect")]
		public bool intersect (Gdk.Rectangle src2, Gdk.Rectangle dest);
		[NoArrayLength ()]
		[InstanceByReference ()]
		[CCode (cname = "gdk_rectangle_union")]
		public void union (Gdk.Rectangle src2, Gdk.Rectangle dest);
	}
	[ReferenceType ()]
	public struct Region {
		public long size;
		public long numRects;
		public weak Gdk.RegionBox rects;
		public weak Gdk.RegionBox extents;
		[NoArrayLength ()]
		[CCode (cname = "gdk_region_copy")]
		public Gdk.Region copy ();
		[NoArrayLength ()]
		[CCode (cname = "gdk_region_destroy")]
		public void destroy ();
		[NoArrayLength ()]
		[CCode (cname = "gdk_region_empty")]
		public bool empty ();
		[NoArrayLength ()]
		[CCode (cname = "gdk_region_equal")]
		public bool equal (Gdk.Region region2);
		[NoArrayLength ()]
		[CCode (cname = "gdk_region_get_clipbox")]
		public void get_clipbox (Gdk.Rectangle rectangle);
		[NoArrayLength ()]
		[CCode (cname = "gdk_region_get_rectangles")]
		public void get_rectangles (Gdk.Rectangle rectangles, int n_rectangles);
		[NoArrayLength ()]
		[CCode (cname = "gdk_region_intersect")]
		public void intersect (Gdk.Region source2);
		[NoArrayLength ()]
		[CCode (cname = "gdk_region_new")]
		public Region ();
		[NoArrayLength ()]
		[CCode (cname = "gdk_region_offset")]
		public void offset (int dx, int dy);
		[NoArrayLength ()]
		[CCode (cname = "gdk_region_point_in")]
		public bool point_in (int x, int y);
		[NoArrayLength ()]
		[CCode (cname = "gdk_region_polygon")]
		public static Gdk.Region polygon (Gdk.Point points, int npoints, Gdk.FillRule fill_rule);
		[NoArrayLength ()]
		[CCode (cname = "gdk_region_rect_in")]
		public Gdk.OverlapType rect_in (Gdk.Rectangle rectangle);
		[NoArrayLength ()]
		[CCode (cname = "gdk_region_rectangle")]
		public static Gdk.Region rectangle (Gdk.Rectangle rectangle);
		[NoArrayLength ()]
		[CCode (cname = "gdk_region_shrink")]
		public void shrink (int dx, int dy);
		[NoArrayLength ()]
		[CCode (cname = "gdk_region_spans_intersect_foreach")]
		public void spans_intersect_foreach (Gdk.Span spans, int n_spans, bool sorted, Gdk.SpanFunc function, pointer data);
		[NoArrayLength ()]
		[CCode (cname = "gdk_region_subtract")]
		public void subtract (Gdk.Region source2);
		[NoArrayLength ()]
		[CCode (cname = "gdk_region_union")]
		public void union (Gdk.Region source2);
		[NoArrayLength ()]
		[CCode (cname = "gdk_region_union_with_rect")]
		public void union_with_rect (Gdk.Rectangle rect);
		[NoArrayLength ()]
		[CCode (cname = "gdk_region_xor")]
		public void xor (Gdk.Region source2);
	}
	[ReferenceType ()]
	public struct RegionBox {
		public int x1;
		public int y1;
		public int x2;
		public int y2;
	}
	[ReferenceType ()]
	public struct RgbCmap {
		public uint colors;
		public int n_colors;
		[NoArrayLength ()]
		[CCode (cname = "gdk_rgb_cmap_free")]
		public void free ();
		[NoArrayLength ()]
		[CCode (cname = "gdk_rgb_cmap_new")]
		public RgbCmap (uint colors, int n_colors);
	}
	[ReferenceType ()]
	public struct Segment {
		public int x1;
		public int y1;
		public int x2;
		public int y2;
	}
	[ReferenceType ()]
	public struct Span {
		public int x;
		public int y;
		public int width;
	}
	[ReferenceType ()]
	public struct TimeCoord {
		public uint time;
		public double axes;
	}
	[ReferenceType ()]
	public struct Trapezoid {
		public double y1;
		public double x11;
		public double x21;
		public double y2;
		public double x12;
		public double x22;
	}
	public struct WindowAttr {
		public weak string title;
		public int event_mask;
		public int x;
		public int y;
		public int width;
		public int height;
		public pointer wclass;
		public weak Gdk.Visual visual;
		public weak Gdk.Colormap colormap;
		public Gdk.WindowType window_type;
		public weak Gdk.Cursor cursor;
		public weak string wmclass_name;
		public weak string wmclass_class;
		public bool override_redirect;
	}
	[ReferenceType ()]
	public struct WindowObject {
		public weak Gdk.Drawable parent_instance;
		public weak Gdk.Drawable impl;
		public weak Gdk.WindowObject parent;
		public pointer user_data;
		public int x;
		public int y;
		public int extension_events;
		public weak GLib.List filters;
		public weak GLib.List children;
		public Gdk.Color bg_color;
		public weak Gdk.Pixmap bg_pixmap;
		public weak GLib.SList paint_stack;
		public weak Gdk.Region update_area;
		public uint update_freeze_count;
		public uchar window_type;
		public uchar depth;
		public uchar resize_count;
		public Gdk.WindowState state;
		public uint guffaw_gravity;
		public uint input_only;
		public uint modal_hint;
		public uint destroyed;
		public uint accept_focus;
		public uint focus_on_map;
		public uint shaped;
		public Gdk.EventMask event_mask;
		[NoArrayLength ()]
		[CCode (cname = "gdk_window_object_get_type")]
		public static GLib.Type get_type ();
	}
	[ReferenceType ()]
	public struct POINTBLOCK {
	}
	[ReferenceType ()]
	public struct ScanLineList {
	}
	[ReferenceType ()]
	public struct ScanLineListBlock {
	}
	public struct Atom {
		[NoArrayLength ()]
		[CCode (cname = "gdk_atom_intern")]
		public static Gdk.Atom intern (string atom_name, bool only_if_exists);
		[NoArrayLength ()]
		[CCode (cname = "gdk_atom_intern_static_string")]
		public static Gdk.Atom intern_static_string (string atom_name);
		[NoArrayLength ()]
		[CCode (cname = "gdk_atom_name")]
		public string name ();
	}
	[ReferenceType ()]
	public struct Cairo {
		[NoArrayLength ()]
		[CCode (cname = "gdk_cairo_create")]
		public static Cairo.Context create (Gdk.Drawable drawable);
		[NoArrayLength ()]
		[CCode (cname = "gdk_cairo_rectangle")]
		public static void rectangle (Cairo.Context cr, Gdk.Rectangle rectangle);
		[NoArrayLength ()]
		[CCode (cname = "gdk_cairo_region")]
		public static void region (Cairo.Context cr, Gdk.Region region);
		[NoArrayLength ()]
		[CCode (cname = "gdk_cairo_set_source_color")]
		public static void set_source_color (Cairo.Context cr, Gdk.Color color);
		[NoArrayLength ()]
		[CCode (cname = "gdk_cairo_set_source_pixbuf")]
		public static void set_source_pixbuf (Cairo.Context cr, Gdk.Pixbuf pixbuf, double pixbuf_x, double pixbuf_y);
		[NoArrayLength ()]
		[CCode (cname = "gdk_cairo_set_source_pixmap")]
		public static void set_source_pixmap (Cairo.Context cr, Gdk.Pixmap pixmap, double pixmap_x, double pixmap_y);
	}
	[ReferenceType ()]
	public struct Char {
	}
	[ReferenceType ()]
	public struct Colors {
	}
	[ReferenceType ()]
	public struct Drag {
		[NoArrayLength ()]
		[CCode (cname = "gdk_drag_abort")]
		public static void abort (Gdk.DragContext context, uint time_);
		[NoArrayLength ()]
		[CCode (cname = "gdk_drag_begin")]
		public static Gdk.DragContext begin (Gdk.Window window, GLib.List targets);
		[NoArrayLength ()]
		[CCode (cname = "gdk_drag_drop")]
		public static void drop (Gdk.DragContext context, uint time_);
		[NoArrayLength ()]
		[CCode (cname = "gdk_drag_drop_succeeded")]
		public static bool drop_succeeded (Gdk.DragContext context);
		[NoArrayLength ()]
		[CCode (cname = "gdk_drag_find_window")]
		public static void find_window (Gdk.DragContext context, Gdk.Window drag_window, int x_root, int y_root, Gdk.Window dest_window, Gdk.DragProtocol protocol);
		[NoArrayLength ()]
		[CCode (cname = "gdk_drag_find_window_for_screen")]
		public static void find_window_for_screen (Gdk.DragContext context, Gdk.Window drag_window, Gdk.Screen screen, int x_root, int y_root, Gdk.Window dest_window, Gdk.DragProtocol protocol);
		[NoArrayLength ()]
		[CCode (cname = "gdk_drag_get_protocol")]
		public static uint get_protocol (uint xid, Gdk.DragProtocol protocol);
		[NoArrayLength ()]
		[CCode (cname = "gdk_drag_get_protocol_for_display")]
		public static uint get_protocol_for_display (Gdk.Display display, uint xid, Gdk.DragProtocol protocol);
		[NoArrayLength ()]
		[CCode (cname = "gdk_drag_get_selection")]
		public static Gdk.Atom get_selection (Gdk.DragContext context);
		[NoArrayLength ()]
		[CCode (cname = "gdk_drag_motion")]
		public static bool motion (Gdk.DragContext context, Gdk.Window dest_window, Gdk.DragProtocol protocol, int x_root, int y_root, Gdk.DragAction suggested_action, Gdk.DragAction possible_actions, uint time_);
		[NoArrayLength ()]
		[CCode (cname = "gdk_drag_status")]
		public static void status (Gdk.DragContext context, Gdk.DragAction action, uint time_);
	}
	[ReferenceType ()]
	public struct Drop {
		[NoArrayLength ()]
		[CCode (cname = "gdk_drop_finish")]
		public static void finish (Gdk.DragContext context, bool success, uint time_);
		[NoArrayLength ()]
		[CCode (cname = "gdk_drop_reply")]
		public static void reply (Gdk.DragContext context, bool ok, uint time_);
	}
	[ReferenceType ()]
	public struct Error {
		[NoArrayLength ()]
		[CCode (cname = "gdk_error_trap_pop")]
		public static int trap_pop ();
		[NoArrayLength ()]
		[CCode (cname = "gdk_error_trap_push")]
		public static void trap_push ();
	}
	[ReferenceType ()]
	public struct Event {
		[NoArrayLength ()]
		[CCode (cname = "gdk_event_copy")]
		public Gdk.Event copy ();
		[NoArrayLength ()]
		[CCode (cname = "gdk_event_free")]
		public void free ();
		[NoArrayLength ()]
		[CCode (cname = "gdk_event_get")]
		public static Gdk.Event @get ();
		[NoArrayLength ()]
		[CCode (cname = "gdk_event_get_axis")]
		public bool get_axis (Gdk.AxisUse axis_use, double value);
		[NoArrayLength ()]
		[CCode (cname = "gdk_event_get_coords")]
		public bool get_coords (double x_win, double y_win);
		[NoArrayLength ()]
		[CCode (cname = "gdk_event_get_graphics_expose")]
		public static Gdk.Event get_graphics_expose (Gdk.Window window);
		[NoArrayLength ()]
		[CCode (cname = "gdk_event_get_root_coords")]
		public bool get_root_coords (double x_root, double y_root);
		[NoArrayLength ()]
		[CCode (cname = "gdk_event_get_screen")]
		public Gdk.Screen get_screen ();
		[NoArrayLength ()]
		[CCode (cname = "gdk_event_get_state")]
		public bool get_state (Gdk.ModifierType state);
		[NoArrayLength ()]
		[CCode (cname = "gdk_event_get_time")]
		public uint get_time ();
		[NoArrayLength ()]
		[CCode (cname = "gdk_event_get_type")]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		[CCode (cname = "gdk_event_handler_set")]
		public static void handler_set (Gdk.EventFunc func, pointer data, GLib.DestroyNotify notify);
		[NoArrayLength ()]
		[CCode (cname = "gdk_event_new")]
		public Event (Gdk.EventType type);
		[NoArrayLength ()]
		[CCode (cname = "gdk_event_peek")]
		public static Gdk.Event peek ();
		[NoArrayLength ()]
		[CCode (cname = "gdk_event_put")]
		public void put ();
		[NoArrayLength ()]
		[CCode (cname = "gdk_event_send_client_message")]
		public bool send_client_message (pointer winid);
		[NoArrayLength ()]
		[CCode (cname = "gdk_event_send_client_message_for_display")]
		public static bool send_client_message_for_display (Gdk.Display display, Gdk.Event event, pointer winid);
		[NoArrayLength ()]
		[CCode (cname = "gdk_event_send_clientmessage_toall")]
		public void send_clientmessage_toall ();
		[NoArrayLength ()]
		[CCode (cname = "gdk_event_set_screen")]
		public void set_screen (Gdk.Screen screen);
	}
	[ReferenceType ()]
	public struct Fontset {
	}
	[ReferenceType ()]
	public struct Input {
		[NoArrayLength ()]
		[CCode (cname = "gdk_input_set_extension_events")]
		public static void set_extension_events (Gdk.Window window, int mask, Gdk.ExtensionMode mode);
	}
	[ReferenceType ()]
	public struct Keyboard {
		[NoArrayLength ()]
		[CCode (cname = "gdk_keyboard_grab")]
		public static Gdk.GrabStatus grab (Gdk.Window window, bool owner_events, uint time_);
		[NoArrayLength ()]
		[CCode (cname = "gdk_keyboard_grab_info_libgtk_only")]
		public static bool grab_info_libgtk_only (Gdk.Display display, Gdk.Window grab_window, bool owner_events);
		[NoArrayLength ()]
		[CCode (cname = "gdk_keyboard_ungrab")]
		public static void ungrab (uint time_);
	}
	[ReferenceType ()]
	public struct Keyval {
		[NoArrayLength ()]
		[CCode (cname = "gdk_keyval_convert_case")]
		public static void convert_case (uint symbol, uint lower, uint upper);
		[NoArrayLength ()]
		[CCode (cname = "gdk_keyval_from_name")]
		public static uint from_name (string keyval_name);
		[NoArrayLength ()]
		[CCode (cname = "gdk_keyval_is_lower")]
		public static bool is_lower (uint keyval);
		[NoArrayLength ()]
		[CCode (cname = "gdk_keyval_is_upper")]
		public static bool is_upper (uint keyval);
		[NoArrayLength ()]
		[CCode (cname = "gdk_keyval_name")]
		public static string name (uint keyval);
		[NoArrayLength ()]
		[CCode (cname = "gdk_keyval_to_lower")]
		public static uint to_lower (uint keyval);
		[NoArrayLength ()]
		[CCode (cname = "gdk_keyval_to_unicode")]
		public static uint to_unicode (uint keyval);
		[NoArrayLength ()]
		[CCode (cname = "gdk_keyval_to_upper")]
		public static uint to_upper (uint keyval);
	}
	[ReferenceType ()]
	public struct Pango {
		[NoArrayLength ()]
		[CCode (cname = "gdk_pango_context_get")]
		public static Pango.Context context_get ();
		[NoArrayLength ()]
		[CCode (cname = "gdk_pango_context_get_for_screen")]
		public static Pango.Context context_get_for_screen (Gdk.Screen screen);
		[NoArrayLength ()]
		[CCode (cname = "gdk_pango_layout_get_clip_region")]
		public static Gdk.Region layout_get_clip_region (Pango.Layout layout, int x_origin, int y_origin, int index_ranges, int n_ranges);
		[NoArrayLength ()]
		[CCode (cname = "gdk_pango_layout_line_get_clip_region")]
		public static Gdk.Region layout_line_get_clip_region (Pango.LayoutLine line, int x_origin, int y_origin, int index_ranges, int n_ranges);
	}
	[ReferenceType ()]
	public struct Pointer {
		[NoArrayLength ()]
		[CCode (cname = "gdk_pointer_grab")]
		public static Gdk.GrabStatus grab (Gdk.Window window, bool owner_events, Gdk.EventMask event_mask, Gdk.Window confine_to, Gdk.Cursor cursor, uint time_);
		[NoArrayLength ()]
		[CCode (cname = "gdk_pointer_grab_info_libgtk_only")]
		public static bool grab_info_libgtk_only (Gdk.Display display, Gdk.Window grab_window, bool owner_events);
		[NoArrayLength ()]
		[CCode (cname = "gdk_pointer_is_grabbed")]
		public static bool is_grabbed ();
		[NoArrayLength ()]
		[CCode (cname = "gdk_pointer_ungrab")]
		public static void ungrab (uint time_);
	}
	[ReferenceType ()]
	public struct Property {
		[NoArrayLength ()]
		[CCode (cname = "gdk_property_change")]
		public static void change (Gdk.Window window, Gdk.Atom property, Gdk.Atom type, int format, Gdk.PropMode mode, uchar[] data, int nelements);
		[NoArrayLength ()]
		[CCode (cname = "gdk_property_delete")]
		public static void delete (Gdk.Window window, Gdk.Atom property);
		[NoArrayLength ()]
		[CCode (cname = "gdk_property_get")]
		public static bool @get (Gdk.Window window, Gdk.Atom property, Gdk.Atom type, ulong offset, ulong length, int pdelete, Gdk.Atom actual_property_type, int actual_format, int actual_length, uchar[] data);
	}
	[ReferenceType ()]
	public struct Query {
		[NoArrayLength ()]
		[CCode (cname = "gdk_query_depths")]
		public static void depths (int depths, int count);
		[NoArrayLength ()]
		[CCode (cname = "gdk_query_visual_types")]
		public static void visual_types (Gdk.VisualType visual_types, int count);
	}
	[ReferenceType ()]
	public struct Rgb {
		[NoArrayLength ()]
		[CCode (cname = "gdk_rgb_colormap_ditherable")]
		public static bool colormap_ditherable (Gdk.Colormap cmap);
		[NoArrayLength ()]
		[CCode (cname = "gdk_rgb_ditherable")]
		public static bool ditherable ();
		[NoArrayLength ()]
		[CCode (cname = "gdk_rgb_find_color")]
		public static void find_color (Gdk.Colormap colormap, Gdk.Color color);
		[NoArrayLength ()]
		[CCode (cname = "gdk_rgb_get_colormap")]
		public static Gdk.Colormap get_colormap ();
		[NoArrayLength ()]
		[CCode (cname = "gdk_rgb_get_visual")]
		public static Gdk.Visual get_visual ();
		[NoArrayLength ()]
		[CCode (cname = "gdk_rgb_set_install")]
		public static void set_install (bool install);
		[NoArrayLength ()]
		[CCode (cname = "gdk_rgb_set_min_colors")]
		public static void set_min_colors (int min_colors);
		[NoArrayLength ()]
		[CCode (cname = "gdk_rgb_set_verbose")]
		public static void set_verbose (bool verbose);
	}
	[ReferenceType ()]
	public struct Selection {
		[NoArrayLength ()]
		[CCode (cname = "gdk_selection_convert")]
		public static void convert (Gdk.Window requestor, Gdk.Atom selection, Gdk.Atom target, uint time_);
		[NoArrayLength ()]
		[CCode (cname = "gdk_selection_owner_get")]
		public static Gdk.Window owner_get (Gdk.Atom selection);
		[NoArrayLength ()]
		[CCode (cname = "gdk_selection_owner_get_for_display")]
		public static Gdk.Window owner_get_for_display (Gdk.Display display, Gdk.Atom selection);
		[NoArrayLength ()]
		[CCode (cname = "gdk_selection_owner_set")]
		public static bool owner_set (Gdk.Window owner, Gdk.Atom selection, uint time_, bool send_event);
		[NoArrayLength ()]
		[CCode (cname = "gdk_selection_owner_set_for_display")]
		public static bool owner_set_for_display (Gdk.Display display, Gdk.Window owner, Gdk.Atom selection, uint time_, bool send_event);
		[NoArrayLength ()]
		[CCode (cname = "gdk_selection_property_get")]
		public static bool property_get (Gdk.Window requestor, uchar[] data, Gdk.Atom prop_type, int prop_format);
		[NoArrayLength ()]
		[CCode (cname = "gdk_selection_send_notify")]
		public static void send_notify (uint requestor, Gdk.Atom selection, Gdk.Atom target, Gdk.Atom property, uint time_);
		[NoArrayLength ()]
		[CCode (cname = "gdk_selection_send_notify_for_display")]
		public static void send_notify_for_display (Gdk.Display display, uint requestor, Gdk.Atom selection, Gdk.Atom target, Gdk.Atom property, uint time_);
	}
	[ReferenceType ()]
	public struct Spawn {
		[NoArrayLength ()]
		[CCode (cname = "gdk_spawn_command_line_on_screen")]
		public static bool command_line_on_screen (Gdk.Screen screen, string command_line, GLib.Error error);
		[NoArrayLength ()]
		[CCode (cname = "gdk_spawn_on_screen")]
		public static bool on_screen (Gdk.Screen screen, string working_directory, string argv, string envp, GLib.SpawnFlags @flags, GLib.SpawnChildSetupFunc child_setup, pointer user_data, int child_pid, GLib.Error error);
		[NoArrayLength ()]
		[CCode (cname = "gdk_spawn_on_screen_with_pipes")]
		public static bool on_screen_with_pipes (Gdk.Screen screen, string working_directory, string argv, string envp, GLib.SpawnFlags @flags, GLib.SpawnChildSetupFunc child_setup, pointer user_data, int child_pid, int standard_input, int standard_output, int standard_error, GLib.Error error);
	}
	[ReferenceType ()]
	public struct Text {
		[NoArrayLength ()]
		[CCode (cname = "gdk_text_property_to_text_list")]
		public static int property_to_text_list (Gdk.Atom encoding, int format, uchar[] text, int length, string list);
		[NoArrayLength ()]
		[CCode (cname = "gdk_text_property_to_text_list_for_display")]
		public static int property_to_text_list_for_display (Gdk.Display display, Gdk.Atom encoding, int format, uchar[] text, int length, string list);
		[NoArrayLength ()]
		[CCode (cname = "gdk_text_property_to_utf8_list")]
		public static int property_to_utf8_list (Gdk.Atom encoding, int format, uchar[] text, int length, string list);
		[NoArrayLength ()]
		[CCode (cname = "gdk_text_property_to_utf8_list_for_display")]
		public static int property_to_utf8_list_for_display (Gdk.Display display, Gdk.Atom encoding, int format, uchar[] text, int length, string list);
	}
	[ReferenceType ()]
	public struct Threads {
		[NoArrayLength ()]
		[CCode (cname = "gdk_threads_enter")]
		public static void enter ();
		[NoArrayLength ()]
		[CCode (cname = "gdk_threads_init")]
		public static void init ();
		[NoArrayLength ()]
		[CCode (cname = "gdk_threads_leave")]
		public static void leave ();
		[NoArrayLength ()]
		[CCode (cname = "gdk_threads_set_lock_functions")]
		public static void set_lock_functions (GLib.Callback enter_fn, GLib.Callback leave_fn);
	}
	public callback void DestroyNotify (pointer data);
	public callback void EventFunc (Gdk.Event event, pointer data);
	public callback Gdk.FilterReturn FilterFunc (pointer xevent, Gdk.Event event, pointer data);
	public callback void InputFunction (pointer data, int source, Gdk.InputCondition condition);
	public callback void PixbufDestroyNotify (uchar[] pixels, pointer data);
	public callback bool PixbufSaveFunc (string buf, ulong count, GLib.Error error, pointer data);
	public callback void SpanFunc (Gdk.Span span, pointer data);
	public callback bool invalidate_maybe_recurseChildFunc (Gdk.Window arg1, pointer data);
	[NoArrayLength ()]
	[CCode (cname = "gdk_add_client_message_filter")]
	public static void add_client_message_filter (Gdk.Atom message_type, Gdk.FilterFunc func, pointer data);
	[NoArrayLength ()]
	[CCode (cname = "gdk_add_option_entries_libgtk_only")]
	public static void add_option_entries_libgtk_only (GLib.OptionGroup group);
	[NoArrayLength ()]
	[CCode (cname = "gdk_devices_list")]
	public static GLib.List devices_list ();
	[NoArrayLength ()]
	[CCode (cname = "gdk_events_pending")]
	public static bool events_pending ();
	[NoArrayLength ()]
	[CCode (cname = "gdk_free_compound_text")]
	public static void free_compound_text (uchar[] ctext);
	[NoArrayLength ()]
	[CCode (cname = "gdk_free_text_list")]
	public static void free_text_list (string list);
	[NoArrayLength ()]
	[CCode (cname = "gdk_get_default_root_window")]
	public static Gdk.Window get_default_root_window ();
	[NoArrayLength ()]
	[CCode (cname = "gdk_get_display")]
	public static string get_display ();
	[NoArrayLength ()]
	[CCode (cname = "gdk_get_display_arg_name")]
	public static string get_display_arg_name ();
	[NoArrayLength ()]
	[CCode (cname = "gdk_get_program_class")]
	public static string get_program_class ();
	[NoArrayLength ()]
	[CCode (cname = "gdk_get_show_events")]
	public static bool get_show_events ();
	[NoArrayLength ()]
	[CCode (cname = "gdk_init_check")]
	public static bool init_check (int argc, string argv);
	[NoArrayLength ()]
	[CCode (cname = "gdk_list_visuals")]
	public static GLib.List list_visuals ();
	[NoArrayLength ()]
	[CCode (cname = "gdk_notify_startup_complete")]
	public static void notify_startup_complete ();
	[NoArrayLength ()]
	[CCode (cname = "gdk_parse_args")]
	public static void parse_args (int argc, string argv);
	[NoArrayLength ()]
	[CCode (cname = "gdk_pre_parse_libgtk_only")]
	public static void pre_parse_libgtk_only ();
	[NoArrayLength ()]
	[CCode (cname = "gdk_set_double_click_time")]
	public static void set_double_click_time (uint msec);
	[NoArrayLength ()]
	[CCode (cname = "gdk_set_locale")]
	public static string set_locale ();
	[NoArrayLength ()]
	[CCode (cname = "gdk_set_pointer_hooks")]
	public static Gdk.PointerHooks set_pointer_hooks (Gdk.PointerHooks new_hooks);
	[NoArrayLength ()]
	[CCode (cname = "gdk_set_program_class")]
	public static void set_program_class (string program_class);
	[NoArrayLength ()]
	[CCode (cname = "gdk_set_show_events")]
	public static void set_show_events (bool show_events);
	[NoArrayLength ()]
	[CCode (cname = "gdk_set_sm_client_id")]
	public static void set_sm_client_id (string sm_client_id);
	[NoArrayLength ()]
	[CCode (cname = "gdk_setting_get")]
	public static bool setting_get (string name, GLib.Value value);
	[NoArrayLength ()]
	[CCode (cname = "gdk_string_to_compound_text")]
	public static int string_to_compound_text (string str, Gdk.Atom encoding, int format, uchar[] ctext, int length);
	[NoArrayLength ()]
	[CCode (cname = "gdk_string_to_compound_text_for_display")]
	public static int string_to_compound_text_for_display (Gdk.Display display, string str, Gdk.Atom encoding, int format, uchar[] ctext, int length);
	[NoArrayLength ()]
	[CCode (cname = "gdk_unicode_to_keyval")]
	public static uint unicode_to_keyval (uint wc);
}
