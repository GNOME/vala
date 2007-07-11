[CCode (cprefix = "Gdk", lower_case_cprefix = "gdk_", cheader_filename = "gdk/gdk.h")]
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
		TYPE_HINT,
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
		public bool alloc_color (out Gdk.Color color, bool writeable, bool best_match);
		public int alloc_colors (out Gdk.Color colors, int ncolors, bool writeable, bool best_match, bool success);
		public void free_colors (out Gdk.Color colors, int ncolors);
		public weak Gdk.Screen get_screen ();
		public static weak Gdk.Colormap get_system ();
		public static GLib.Type get_type ();
		public weak Gdk.Visual get_visual ();
		public Colormap (Gdk.Visual visual, bool allocate);
		public void query_color (ulong pixel, out Gdk.Color result);
	}
	[CCode (cheader_filename = "gdk/gdk.h")]
	public class Device : GLib.Object {
		[NoArrayLength]
		public static void free_history (Gdk.TimeCoord[] events, int n_events);
		public bool get_axis (double axes, Gdk.AxisUse use, double value);
		public static weak Gdk.Device get_core_pointer ();
		[NoArrayLength]
		public bool get_history (Gdk.Window window, uint start, uint stop, Gdk.TimeCoord[] events, int n_events);
		public void get_state (Gdk.Window window, double axes, Gdk.ModifierType mask);
		public static GLib.Type get_type ();
		public void set_axis_use (uint index_, Gdk.AxisUse use);
		public void set_key (uint index_, uint keyval, Gdk.ModifierType modifiers);
		public bool set_mode (Gdk.InputMode mode);
		public void set_source (Gdk.InputSource source);
	}
	[CCode (cheader_filename = "gdk/gdk.h")]
	public class Display : GLib.Object {
		public void add_client_message_filter (Gdk.Atom message_type, Gdk.FilterFunc func, pointer data);
		public void beep ();
		public void close ();
		public void flush ();
		public weak Gdk.Device get_core_pointer ();
		public static weak Gdk.Display get_default ();
		public uint get_default_cursor_size ();
		public weak Gdk.Window get_default_group ();
		public virtual weak Gdk.Screen get_default_screen ();
		public weak Gdk.Event get_event ();
		public void get_maximal_cursor_size (uint width, uint height);
		public virtual int get_n_screens ();
		public weak string get_name ();
		public void get_pointer (Gdk.Screen screen, int x, int y, Gdk.ModifierType mask);
		public virtual weak Gdk.Screen get_screen (int screen_num);
		public static GLib.Type get_type ();
		public weak Gdk.Window get_window_at_pointer (int win_x, int win_y);
		public void keyboard_ungrab (uint time_);
		public weak GLib.List list_devices ();
		public static weak Gdk.Display open (string display_name);
		public static weak Gdk.Display open_default_libgtk_only ();
		public weak Gdk.Event peek_event ();
		public bool pointer_is_grabbed ();
		public void pointer_ungrab (uint time_);
		public void put_event (Gdk.Event event);
		public bool request_selection_notification (Gdk.Atom selection);
		public void set_double_click_distance (uint distance);
		public void set_double_click_time (uint msec);
		public weak Gdk.DisplayPointerHooks set_pointer_hooks (Gdk.DisplayPointerHooks new_hooks);
		[NoArrayLength]
		public void store_clipboard (Gdk.Window clipboard_window, uint time_, Gdk.Atom[] targets, int n_targets);
		public bool supports_clipboard_persistence ();
		public bool supports_composite ();
		public bool supports_cursor_alpha ();
		public bool supports_cursor_color ();
		public bool supports_input_shapes ();
		public bool supports_selection_notification ();
		public bool supports_shapes ();
		public void sync ();
		public void warp_pointer (Gdk.Screen screen, int x, int y);
		public signal void closed (bool is_error);
	}
	[CCode (cheader_filename = "gdk/gdk.h")]
	public class DisplayManager : GLib.Object {
		public static weak Gdk.DisplayManager get ();
		public weak Gdk.Display get_default_display ();
		public static GLib.Type get_type ();
		public weak GLib.SList list_displays ();
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
		public static GLib.Type get_type ();
		public DragContext ();
	}
	[CCode (cheader_filename = "gdk/gdk.h")]
	public class Drawable : GLib.Object {
		[CCode (cname = "gdk_draw_arc")]
		public virtual void draw_arc (Gdk.GC gc, bool filled, int x, int y, int width, int height, int angle1, int angle2);
		[CCode (cname = "gdk_draw_drawable")]
		public virtual void draw_drawable (Gdk.GC gc, Gdk.Drawable src, int xsrc, int ysrc, int xdest, int ydest, int width, int height);
		[CCode (cname = "gdk_draw_glyphs")]
		public virtual void draw_glyphs (Gdk.GC gc, Pango.Font font, int x, int y, Pango.GlyphString glyphs);
		[CCode (cname = "gdk_draw_glyphs_transformed")]
		public virtual void draw_glyphs_transformed (Gdk.GC gc, Pango.Matrix matrix, Pango.Font font, int x, int y, Pango.GlyphString glyphs);
		[NoArrayLength]
		[CCode (cname = "gdk_draw_gray_image")]
		public void draw_gray_image (Gdk.GC gc, int x, int y, int width, int height, Gdk.RgbDither dith, uchar[] buf, int rowstride);
		[CCode (cname = "gdk_draw_image")]
		public virtual void draw_image (Gdk.GC gc, Gdk.Image image, int xsrc, int ysrc, int xdest, int ydest, int width, int height);
		[NoArrayLength]
		[CCode (cname = "gdk_draw_indexed_image")]
		public void draw_indexed_image (Gdk.GC gc, int x, int y, int width, int height, Gdk.RgbDither dith, uchar[] buf, int rowstride, Gdk.RgbCmap cmap);
		[CCode (cname = "gdk_draw_layout")]
		public void draw_layout (Gdk.GC gc, int x, int y, Pango.Layout layout);
		[CCode (cname = "gdk_draw_layout_line")]
		public void draw_layout_line (Gdk.GC gc, int x, int y, Pango.LayoutLine line);
		[CCode (cname = "gdk_draw_layout_line_with_colors")]
		public void draw_layout_line_with_colors (Gdk.GC gc, int x, int y, Pango.LayoutLine line, out Gdk.Color foreground, out Gdk.Color background);
		[CCode (cname = "gdk_draw_layout_with_colors")]
		public void draw_layout_with_colors (Gdk.GC gc, int x, int y, Pango.Layout layout, out Gdk.Color foreground, out Gdk.Color background);
		[CCode (cname = "gdk_draw_line")]
		public void draw_line (Gdk.GC gc, int x1_, int y1_, int x2_, int y2_);
		[CCode (cname = "gdk_draw_lines")]
		public virtual void draw_lines (Gdk.GC gc, Gdk.Point points, int npoints);
		[CCode (cname = "gdk_draw_pixbuf")]
		public virtual void draw_pixbuf (Gdk.GC gc, Gdk.Pixbuf pixbuf, int src_x, int src_y, int dest_x, int dest_y, int width, int height, Gdk.RgbDither dither, int x_dither, int y_dither);
		[CCode (cname = "gdk_draw_point")]
		public void draw_point (Gdk.GC gc, int x, int y);
		[CCode (cname = "gdk_draw_points")]
		public virtual void draw_points (Gdk.GC gc, Gdk.Point points, int npoints);
		[CCode (cname = "gdk_draw_polygon")]
		public virtual void draw_polygon (Gdk.GC gc, bool filled, Gdk.Point points, int npoints);
		[CCode (cname = "gdk_draw_rectangle")]
		public virtual void draw_rectangle (Gdk.GC gc, bool filled, int x, int y, int width, int height);
		[NoArrayLength]
		[CCode (cname = "gdk_draw_rgb_32_image")]
		public void draw_rgb_32_image (Gdk.GC gc, int x, int y, int width, int height, Gdk.RgbDither dith, uchar[] buf, int rowstride);
		[NoArrayLength]
		[CCode (cname = "gdk_draw_rgb_32_image_dithalign")]
		public void draw_rgb_32_image_dithalign (Gdk.GC gc, int x, int y, int width, int height, Gdk.RgbDither dith, uchar[] buf, int rowstride, int xdith, int ydith);
		[NoArrayLength]
		[CCode (cname = "gdk_draw_rgb_image")]
		public void draw_rgb_image (Gdk.GC gc, int x, int y, int width, int height, Gdk.RgbDither dith, uchar[] rgb_buf, int rowstride);
		[NoArrayLength]
		[CCode (cname = "gdk_draw_rgb_image_dithalign")]
		public void draw_rgb_image_dithalign (Gdk.GC gc, int x, int y, int width, int height, Gdk.RgbDither dith, uchar[] rgb_buf, int rowstride, int xdith, int ydith);
		[CCode (cname = "gdk_draw_segments")]
		public virtual void draw_segments (Gdk.GC gc, Gdk.Segment segs, int nsegs);
		[NoArrayLength]
		[CCode (cname = "gdk_draw_trapezoids")]
		public virtual void draw_trapezoids (Gdk.GC gc, Gdk.Trapezoid[] trapezoids, int n_trapezoids);
		public weak Gdk.Image copy_to_image (Gdk.Image image, int src_x, int src_y, int dest_x, int dest_y, int width, int height);
		public virtual weak Gdk.Region get_clip_region ();
		public virtual weak Gdk.Colormap get_colormap ();
		public virtual int get_depth ();
		public weak Gdk.Display get_display ();
		public virtual weak Gdk.Image get_image (int x, int y, int width, int height);
		public virtual weak Gdk.Screen get_screen ();
		public virtual void get_size (int width, int height);
		public static GLib.Type get_type ();
		public virtual weak Gdk.Region get_visible_region ();
		public virtual weak Gdk.Visual get_visual ();
		public virtual void set_colormap (Gdk.Colormap colormap);
	}
	[CCode (cheader_filename = "gdk/gdk.h")]
	public class GC : GLib.Object {
		public void copy (Gdk.GC src_gc);
		public weak Gdk.Colormap get_colormap ();
		public weak Gdk.Screen get_screen ();
		public static GLib.Type get_type ();
		public virtual void get_values (Gdk.GCValues values);
		public GC (Gdk.Drawable drawable);
		public GC.with_values (Gdk.Drawable drawable, Gdk.GCValues values, Gdk.GCValuesMask values_mask);
		public void offset (int x_offset, int y_offset);
		public void set_background (out Gdk.Color color);
		public void set_clip_mask (Gdk.Bitmap mask);
		public void set_clip_origin (int x, int y);
		public void set_clip_rectangle (out Gdk.Rectangle rectangle);
		public void set_clip_region (Gdk.Region region);
		public void set_colormap (Gdk.Colormap colormap);
		[NoArrayLength]
		public virtual void set_dashes (int dash_offset, char[] dash_list, int n);
		public void set_exposures (bool exposures);
		public void set_fill (Gdk.Fill fill);
		public void set_foreground (out Gdk.Color color);
		public void set_function (Gdk.Function function);
		public void set_line_attributes (int line_width, Gdk.LineStyle line_style, Gdk.CapStyle cap_style, Gdk.JoinStyle join_style);
		public void set_rgb_bg_color (out Gdk.Color color);
		public void set_rgb_fg_color (out Gdk.Color color);
		public void set_stipple (Gdk.Pixmap stipple);
		public void set_subwindow (Gdk.SubwindowMode mode);
		public void set_tile (Gdk.Pixmap tile);
		public void set_ts_origin (int x, int y);
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
		public weak Gdk.Colormap get_colormap ();
		public uint get_pixel (int x, int y);
		public static GLib.Type get_type ();
		public Image (Gdk.ImageType type, Gdk.Visual visual, int width, int height);
		public void put_pixel (int x, int y, uint pixel);
		public void set_colormap (Gdk.Colormap colormap);
	}
	[CCode (cheader_filename = "gdk/gdk.h")]
	public class Keymap : GLib.Object {
		public static weak Gdk.Keymap get_default ();
		public Pango.Direction get_direction ();
		public bool get_entries_for_keycode (uint hardware_keycode, Gdk.KeymapKey keys, uint keyvals, int n_entries);
		[NoArrayLength]
		public bool get_entries_for_keyval (uint keyval, Gdk.KeymapKey[] keys, int n_keys);
		public static weak Gdk.Keymap get_for_display (Gdk.Display display);
		public static GLib.Type get_type ();
		public uint lookup_key (Gdk.KeymapKey key);
		public bool translate_keyboard_state (uint hardware_keycode, Gdk.ModifierType state, int group, uint keyval, int effective_group, int level, Gdk.ModifierType consumed_modifiers);
		public signal void direction_changed ();
		public signal void keys_changed ();
	}
	[CCode (cheader_filename = "gdk/gdk.h")]
	public class PangoRenderer : Pango.Renderer {
		public static weak Pango.Renderer get_default (Gdk.Screen screen);
		public static GLib.Type get_type ();
		public PangoRenderer (Gdk.Screen screen);
		public void set_drawable (Gdk.Drawable drawable);
		public void set_gc (Gdk.GC gc);
		public void set_override_color (Pango.RenderPart part, out Gdk.Color color);
		public void set_stipple (Pango.RenderPart part, Gdk.Bitmap stipple);
		[NoAccessorMethod]
		public weak Gdk.Screen screen { get; construct; }
	}
	[CCode (cheader_filename = "gdk/gdk.h")]
	public class Pixbuf : GLib.Object {
		public weak Gdk.Pixbuf add_alpha (bool substitute_color, uchar r, uchar g, uchar b);
		public void composite (Gdk.Pixbuf dest, int dest_x, int dest_y, int dest_width, int dest_height, double offset_x, double offset_y, double scale_x, double scale_y, Gdk.InterpType interp_type, int overall_alpha);
		public void composite_color (Gdk.Pixbuf dest, int dest_x, int dest_y, int dest_width, int dest_height, double offset_x, double offset_y, double scale_x, double scale_y, Gdk.InterpType interp_type, int overall_alpha, int check_x, int check_y, int check_size, uint color1, uint color2);
		public weak Gdk.Pixbuf composite_color_simple (int dest_width, int dest_height, Gdk.InterpType interp_type, int overall_alpha, int check_size, uint color1, uint color2);
		public weak Gdk.Pixbuf copy ();
		public void copy_area (int src_x, int src_y, int width, int height, Gdk.Pixbuf dest_pixbuf, int dest_x, int dest_y);
		public static GLib.Quark error_quark ();
		public void fill (uint pixel);
		public weak Gdk.Pixbuf flip (bool horizontal);
		public static weak Gdk.Pixbuf from_pixdata (Gdk.Pixdata pixdata, bool copy_pixels, GLib.Error error);
		public int get_bits_per_sample ();
		public Gdk.Colorspace get_colorspace ();
		public static weak Gdk.PixbufFormat get_file_info (string filename, int width, int height);
		public static weak GLib.SList get_formats ();
		public weak Gdk.Pixbuf get_from_drawable (Gdk.Drawable src, Gdk.Colormap cmap, int src_x, int src_y, int dest_x, int dest_y, int width, int height);
		public weak Gdk.Pixbuf get_from_image (Gdk.Image src, Gdk.Colormap cmap, int src_x, int src_y, int dest_x, int dest_y, int width, int height);
		public bool get_has_alpha ();
		public int get_height ();
		public int get_n_channels ();
		public weak string get_option (string key);
		[NoArrayLength]
		public weak uchar[] get_pixels ();
		public int get_rowstride ();
		public static GLib.Type get_type ();
		public int get_width ();
		public Pixbuf (Gdk.Colorspace colorspace, bool has_alpha, int bits_per_sample, int width, int height);
		[NoArrayLength]
		public Pixbuf.from_data (uchar[] data, Gdk.Colorspace colorspace, bool has_alpha, int bits_per_sample, int width, int height, int rowstride, Gdk.PixbufDestroyNotify destroy_fn, pointer destroy_fn_data);
		public Pixbuf.from_file (string filename, GLib.Error error);
		public Pixbuf.from_file_at_scale (string filename, int width, int height, bool preserve_aspect_ratio, GLib.Error error);
		public Pixbuf.from_file_at_size (string filename, int width, int height, GLib.Error error);
		[NoArrayLength]
		public Pixbuf.from_inline (int data_length, uchar[] data, bool copy_pixels, GLib.Error error);
		public Pixbuf.from_xpm_data (string data);
		public Pixbuf.subpixbuf (int src_x, int src_y, int width, int height);
		public void render_pixmap_and_mask (Gdk.Pixmap pixmap_return, Gdk.Bitmap mask_return, int alpha_threshold);
		public void render_pixmap_and_mask_for_colormap (Gdk.Colormap colormap, Gdk.Pixmap pixmap_return, Gdk.Bitmap mask_return, int alpha_threshold);
		public void render_threshold_alpha (Gdk.Bitmap bitmap, int src_x, int src_y, int dest_x, int dest_y, int width, int height, int alpha_threshold);
		public weak Gdk.Pixbuf rotate_simple (Gdk.PixbufRotation angle);
		public void saturate_and_pixelate (Gdk.Pixbuf dest, float saturation, bool pixelate);
		public bool save (string filename, string type, GLib.Error error);
		public bool save_to_buffer (string buffer, ulong buffer_size, string type, GLib.Error error);
		public bool save_to_bufferv (string buffer, ulong buffer_size, string type, string option_keys, string option_values, GLib.Error error);
		public bool save_to_callback (Gdk.PixbufSaveFunc save_func, pointer user_data, string type, GLib.Error error);
		public bool save_to_callbackv (Gdk.PixbufSaveFunc save_func, pointer user_data, string type, string option_keys, string option_values, GLib.Error error);
		public bool savev (string filename, string type, string option_keys, string option_values, GLib.Error error);
		public void scale (Gdk.Pixbuf dest, int dest_x, int dest_y, int dest_width, int dest_height, double offset_x, double offset_y, double scale_x, double scale_y, Gdk.InterpType interp_type);
		public weak Gdk.Pixbuf scale_simple (int dest_width, int dest_height, Gdk.InterpType interp_type);
		[NoAccessorMethod]
		public weak int n_channels { get; set; }
		[NoAccessorMethod]
		public weak Gdk.Colorspace colorspace { get; set; }
		[NoAccessorMethod]
		public weak bool has_alpha { get; set; }
		[NoAccessorMethod]
		public weak int bits_per_sample { get; set; }
		[NoAccessorMethod]
		public weak int width { get; set; }
		[NoAccessorMethod]
		public weak int height { get; set; }
		[NoAccessorMethod]
		public weak int rowstride { get; set; }
		[NoAccessorMethod]
		public weak pointer pixels { get; set; }
	}
	[CCode (cheader_filename = "gdk/gdk.h")]
	public class PixbufAnimation : GLib.Object {
		public int get_height ();
		public weak Gdk.PixbufAnimationIter get_iter (GLib.TimeVal start_time);
		public weak Gdk.Pixbuf get_static_image ();
		public static GLib.Type get_type ();
		public int get_width ();
		public bool is_static_image ();
		public PixbufAnimation.from_file (string filename, GLib.Error error);
	}
	[CCode (cheader_filename = "gdk/gdk.h")]
	public class PixbufAnimationIter : GLib.Object {
		public bool advance (GLib.TimeVal current_time);
		public int get_delay_time ();
		public weak Gdk.Pixbuf get_pixbuf ();
		public static GLib.Type get_type ();
		public bool on_currently_loading_frame ();
	}
	[CCode (cheader_filename = "gdk/gdk.h")]
	public class PixbufAniAnim : Gdk.PixbufAnimation {
		public static GLib.Type get_type ();
	}
	[CCode (cheader_filename = "gdk/gdk.h")]
	public class PixbufAniAnimIter : Gdk.PixbufAnimationIter {
		public static GLib.Type get_type ();
	}
	[CCode (cheader_filename = "gdk/gdk.h")]
	public class PixbufGifAnim : Gdk.PixbufAnimation {
		public void frame_composite (Gdk.PixbufFrame frame);
		public static GLib.Type get_type ();
	}
	[CCode (cheader_filename = "gdk/gdk.h")]
	public class PixbufGifAnimIter : Gdk.PixbufAnimationIter {
		public static GLib.Type get_type ();
	}
	[CCode (cheader_filename = "gdk/gdk.h")]
	public class PixbufLoader : GLib.Object {
		public bool close (GLib.Error error);
		public weak Gdk.PixbufAnimation get_animation ();
		public weak Gdk.PixbufFormat get_format ();
		public weak Gdk.Pixbuf get_pixbuf ();
		public static GLib.Type get_type ();
		public PixbufLoader ();
		public PixbufLoader.with_mime_type (string mime_type, GLib.Error error);
		public PixbufLoader.with_type (string image_type, GLib.Error error);
		public void set_size (int width, int height);
		[NoArrayLength]
		public bool write (uchar[] buf, ulong count, GLib.Error error);
		public signal void size_prepared (int width, int height);
		public signal void area_prepared ();
		public signal void area_updated (int x, int y, int width, int height);
		public signal void closed ();
	}
	[CCode (cheader_filename = "gdk/gdk.h")]
	public class PixbufSimpleAnim : Gdk.PixbufAnimation {
		public void add_frame (Gdk.Pixbuf pixbuf);
		public static GLib.Type get_type ();
		public static GLib.Type iter_get_type ();
		public PixbufSimpleAnim (int width, int height, float rate);
	}
	[CCode (cheader_filename = "gdk/gdk.h")]
	public class Pixmap : GLib.Object {
		public static weak Gdk.Pixmap colormap_create_from_xpm (Gdk.Drawable drawable, Gdk.Colormap colormap, Gdk.Bitmap mask, out Gdk.Color transparent_color, string filename);
		public static weak Gdk.Pixmap colormap_create_from_xpm_d (Gdk.Drawable drawable, Gdk.Colormap colormap, Gdk.Bitmap mask, out Gdk.Color transparent_color, string data);
		public static weak Gdk.Pixmap create_from_data (Gdk.Drawable drawable, string data, int width, int height, int depth, out Gdk.Color fg, out Gdk.Color bg);
		public static weak Gdk.Pixmap create_from_xpm (Gdk.Drawable drawable, Gdk.Bitmap mask, out Gdk.Color transparent_color, string filename);
		public static weak Gdk.Pixmap create_from_xpm_d (Gdk.Drawable drawable, Gdk.Bitmap mask, out Gdk.Color transparent_color, string data);
		public static weak Gdk.Pixmap foreign_new (pointer anid);
		public static weak Gdk.Pixmap foreign_new_for_display (Gdk.Display display, pointer anid);
		public static weak Gdk.Pixmap foreign_new_for_screen (Gdk.Screen screen, pointer anid, int width, int height, int depth);
		public static GLib.Type get_type ();
		public static weak Gdk.Pixmap lookup (pointer anid);
		public static weak Gdk.Pixmap lookup_for_display (Gdk.Display display, pointer anid);
		public Pixmap (Gdk.Drawable drawable, int width, int height, int depth);
	}
	[CCode (cheader_filename = "gdk/gdk.h")]
	public class Screen : GLib.Object {
		public void broadcast_client_message (Gdk.Event event);
		public weak Gdk.Window get_active_window ();
		public static weak Gdk.Screen get_default ();
		public weak Gdk.Colormap get_default_colormap ();
		public weak Gdk.Display get_display ();
		public pointer get_font_options ();
		public int get_height ();
		public int get_height_mm ();
		public int get_monitor_at_point (int x, int y);
		public int get_monitor_at_window (Gdk.Window window);
		public void get_monitor_geometry (int monitor_num, out Gdk.Rectangle dest);
		public int get_n_monitors ();
		public int get_number ();
		public double get_resolution ();
		public weak Gdk.Colormap get_rgb_colormap ();
		public weak Gdk.Visual get_rgb_visual ();
		public weak Gdk.Colormap get_rgba_colormap ();
		public weak Gdk.Visual get_rgba_visual ();
		public weak Gdk.Window get_root_window ();
		public bool get_setting (string name, GLib.Value value);
		public weak Gdk.Colormap get_system_colormap ();
		public weak Gdk.Visual get_system_visual ();
		public weak GLib.List get_toplevel_windows ();
		public static GLib.Type get_type ();
		public int get_width ();
		public int get_width_mm ();
		public weak GLib.List get_window_stack ();
		public static int height ();
		public static int height_mm ();
		public bool is_composited ();
		public weak GLib.List list_visuals ();
		public weak string make_display_name ();
		public void set_default_colormap (Gdk.Colormap colormap);
		public void set_font_options (pointer options);
		public void set_resolution (double dpi);
		public static int width ();
		public static int width_mm ();
		public weak pointer font_options { get; set; }
		public weak double resolution { get; set; }
		public signal void size_changed ();
		public signal void composited_changed ();
	}
	[CCode (cheader_filename = "gdk/gdk.h")]
	public class Visual : GLib.Object {
		public static weak Gdk.Visual get_best ();
		public static int get_best_depth ();
		public static Gdk.VisualType get_best_type ();
		public static weak Gdk.Visual get_best_with_both (int depth, Gdk.VisualType visual_type);
		public static weak Gdk.Visual get_best_with_depth (int depth);
		public static weak Gdk.Visual get_best_with_type (Gdk.VisualType visual_type);
		public weak Gdk.Screen get_screen ();
		public static weak Gdk.Visual get_system ();
		public static GLib.Type get_type ();
	}
	[CCode (cheader_filename = "gdk/gdk.h")]
	public class Window : Gdk.Drawable {
		public void add_filter (Gdk.FilterFunc function, pointer data);
		public static weak Gdk.Window at_pointer (int win_x, int win_y);
		public void beep ();
		public void begin_move_drag (int button, int root_x, int root_y, uint timestamp);
		public void begin_paint_rect (out Gdk.Rectangle rectangle);
		public void begin_paint_region (Gdk.Region region);
		public void begin_resize_drag (Gdk.WindowEdge edge, int button, int root_x, int root_y, uint timestamp);
		public void clear ();
		public void clear_area (int x, int y, int width, int height);
		public void clear_area_e (int x, int y, int width, int height);
		public void configure_finished ();
		public static void constrain_size (Gdk.Geometry geometry, uint @flags, int width, int height, int new_width, int new_height);
		public void deiconify ();
		public void destroy ();
		public void enable_synchronized_configure ();
		public void end_paint ();
		public void focus (uint timestamp);
		public static weak Gdk.Window foreign_new (pointer anid);
		public static weak Gdk.Window foreign_new_for_display (Gdk.Display display, pointer anid);
		public void freeze_updates ();
		public void fullscreen ();
		public weak GLib.List get_children ();
		public bool get_decorations (Gdk.WMDecoration decorations);
		public Gdk.EventMask get_events ();
		public void get_frame_extents (out Gdk.Rectangle rect);
		public void get_geometry (int x, int y, int width, int height, int depth);
		public weak Gdk.Window get_group ();
		public void get_internal_paint_info (Gdk.Drawable real_drawable, int x_offset, int y_offset);
		public int get_origin (int x, int y);
		public weak Gdk.Window get_parent ();
		public weak Gdk.Window get_pointer (int x, int y, Gdk.ModifierType mask);
		public void get_position (int x, int y);
		public void get_root_origin (int x, int y);
		public Gdk.WindowState get_state ();
		public weak Gdk.Window get_toplevel ();
		public static weak GLib.List get_toplevels ();
		public Gdk.WindowTypeHint get_type_hint ();
		public weak Gdk.Region get_update_area ();
		public void get_user_data (pointer data);
		public Gdk.WindowType get_window_type ();
		public void hide ();
		public void iconify ();
		public void input_shape_combine_mask (Gdk.Bitmap mask, int x, int y);
		public void input_shape_combine_region (Gdk.Region shape_region, int offset_x, int offset_y);
		public void invalidate_maybe_recurse (Gdk.Region region, Gdk.invalidate_maybe_recurseChildFunc child_func, pointer user_data);
		public void invalidate_rect (out Gdk.Rectangle rect, bool invalidate_children);
		public void invalidate_region (Gdk.Region region, bool invalidate_children);
		public bool is_viewable ();
		public bool is_visible ();
		public static weak Gdk.Window lookup (pointer anid);
		public static weak Gdk.Window lookup_for_display (Gdk.Display display, pointer anid);
		public void lower ();
		public void maximize ();
		public void merge_child_input_shapes ();
		public void merge_child_shapes ();
		public void move (int x, int y);
		public void move_region (Gdk.Region region, int dx, int dy);
		public void move_resize (int x, int y, int width, int height);
		public Window (out Gdk.WindowAttr attributes, int attributes_mask);
		public weak GLib.List peek_children ();
		public static void process_all_updates ();
		public void process_updates (bool update_children);
		public void raise ();
		public void register_dnd ();
		public void remove_filter (Gdk.FilterFunc function, pointer data);
		public void reparent (Gdk.Window new_parent, int x, int y);
		public void resize (int width, int height);
		public void scroll (int dx, int dy);
		public void set_accept_focus (bool accept_focus);
		public void set_back_pixmap (Gdk.Pixmap pixmap, bool parent_relative);
		public void set_background (out Gdk.Color color);
		public void set_child_input_shapes ();
		public void set_child_shapes ();
		public void set_composited (bool composited);
		public void set_cursor (Gdk.Cursor cursor);
		public static void set_debug_updates (bool setting);
		public void set_decorations (Gdk.WMDecoration decorations);
		public void set_events (Gdk.EventMask event_mask);
		public void set_focus_on_map (bool focus_on_map);
		public void set_functions (Gdk.WMFunction functions);
		public void set_geometry_hints (Gdk.Geometry geometry, Gdk.WindowHints geom_mask);
		public void set_group (Gdk.Window leader);
		public void set_icon (Gdk.Window icon_window, Gdk.Pixmap pixmap, Gdk.Bitmap mask);
		public void set_icon_list (GLib.List pixbufs);
		public void set_icon_name (string name);
		public void set_keep_above (bool setting);
		public void set_keep_below (bool setting);
		public void set_modal_hint (bool modal);
		public void set_opacity (double opacity);
		public void set_override_redirect (bool override_redirect);
		public void set_role (string role);
		public void set_skip_pager_hint (bool skips_pager);
		public void set_skip_taskbar_hint (bool skips_taskbar);
		public void set_startup_id (string startup_id);
		public bool set_static_gravities (bool use_static);
		public void set_title (string title);
		public void set_transient_for (Gdk.Window parent);
		public void set_type_hint (Gdk.WindowTypeHint hint);
		public void set_urgency_hint (bool urgent);
		public void set_user_data (pointer user_data);
		public void shape_combine_mask (Gdk.Bitmap mask, int x, int y);
		public void shape_combine_region (Gdk.Region shape_region, int offset_x, int offset_y);
		public void show ();
		public void show_unraised ();
		public void stick ();
		public void thaw_updates ();
		public void unfullscreen ();
		public void unmaximize ();
		public void unstick ();
		public void withdraw ();
	}
	[CCode (cheader_filename = "gdk/gdk.h")]
	public class Bitmap : GLib.Object {
		public weak GLib.Object parent_instance;
		public static weak Gdk.Bitmap create_from_data (Gdk.Drawable drawable, string data, int width, int height);
	}
	[ReferenceType]
	public struct BRESINFO {
		public int minor_axis;
		public int d;
		public int m;
		public int m1;
		public int incr1;
		public int incr2;
	}
	[ReferenceType]
	public struct EdgeTable {
		public int ymax;
		public int ymin;
		public weak Gdk.ScanLineList scanlines;
	}
	[ReferenceType]
	public struct EdgeTableEntry {
	}
	public struct Color {
		public uint pixel;
		public ushort red;
		public ushort green;
		public ushort blue;
		[InstanceByReference]
		public Gdk.Color copy ();
		[InstanceByReference]
		public bool equal (out Gdk.Color colorb);
		[InstanceByReference]
		public void free ();
		public static GLib.Type get_type ();
		[InstanceByReference]
		public uint hash ();
		public static bool parse (string spec, out Gdk.Color color);
		[InstanceByReference]
		public weak string to_string ();
	}
	[ReferenceType]
	public struct Cursor {
		public Gdk.CursorType type;
		public weak Gdk.Display get_display ();
		public weak Gdk.Pixbuf get_image ();
		public static GLib.Type get_type ();
		public Cursor (Gdk.CursorType cursor_type);
		public Cursor.for_display (Gdk.Display display, Gdk.CursorType cursor_type);
		public Cursor.from_name (Gdk.Display display, string name);
		public Cursor.from_pixbuf (Gdk.Display display, Gdk.Pixbuf pixbuf, int x, int y);
		public Cursor.from_pixmap (Gdk.Pixmap source, Gdk.Pixmap mask, out Gdk.Color fg, out Gdk.Color bg, int x, int y);
		public weak Gdk.Cursor @ref ();
		public void unref ();
	}
	[ReferenceType]
	public struct DeviceAxis {
		public Gdk.AxisUse use;
		public double min;
		public double max;
	}
	[ReferenceType]
	public struct DeviceKey {
		public uint keyval;
		public Gdk.ModifierType modifiers;
	}
	[ReferenceType]
	public struct DisplayPointerHooks {
	}
	[ReferenceType]
	public struct EventAny {
		public Gdk.EventType type;
		public weak Gdk.Window window;
		public char send_event;
	}
	[ReferenceType]
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
	[ReferenceType]
	public struct EventClient {
		public Gdk.EventType type;
		public weak Gdk.Window window;
		public char send_event;
		public Gdk.Atom message_type;
		public ushort data_format;
		public char b;
	}
	[ReferenceType]
	public struct EventConfigure {
		public Gdk.EventType type;
		public weak Gdk.Window window;
		public char send_event;
		public int x;
		public int y;
		public int width;
		public int height;
	}
	[ReferenceType]
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
	[ReferenceType]
	public struct EventDND {
		public Gdk.EventType type;
		public weak Gdk.Window window;
		public char send_event;
		public weak Gdk.DragContext context;
		public uint time;
		public short x_root;
		public short y_root;
	}
	[ReferenceType]
	public struct EventExpose {
		public Gdk.EventType type;
		public weak Gdk.Window window;
		public char send_event;
		public Gdk.Rectangle area;
		public weak Gdk.Region region;
		public int count;
	}
	[ReferenceType]
	public struct EventFocus {
		public Gdk.EventType type;
		public weak Gdk.Window window;
		public char send_event;
		public short @in;
	}
	[ReferenceType]
	public struct EventGrabBroken {
		public Gdk.EventType type;
		public weak Gdk.Window window;
		public char send_event;
		public bool keyboard;
		public bool implicit;
		public weak Gdk.Window grab_window;
	}
	[ReferenceType]
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
	[ReferenceType]
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
	[ReferenceType]
	public struct EventNoExpose {
		public Gdk.EventType type;
		public weak Gdk.Window window;
		public char send_event;
	}
	[ReferenceType]
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
	[ReferenceType]
	public struct EventProperty {
		public Gdk.EventType type;
		public weak Gdk.Window window;
		public char send_event;
		public Gdk.Atom atom;
		public uint time;
		public uint state;
	}
	[ReferenceType]
	public struct EventProximity {
		public Gdk.EventType type;
		public weak Gdk.Window window;
		public char send_event;
		public uint time;
		public weak Gdk.Device device;
	}
	[ReferenceType]
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
	[ReferenceType]
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
	[ReferenceType]
	public struct EventSetting {
		public Gdk.EventType type;
		public weak Gdk.Window window;
		public char send_event;
		public Gdk.SettingAction action;
		public weak string name;
	}
	[ReferenceType]
	public struct EventVisibility {
		public Gdk.EventType type;
		public weak Gdk.Window window;
		public char send_event;
		public Gdk.VisibilityState state;
	}
	[ReferenceType]
	public struct EventWindowState {
		public Gdk.EventType type;
		public weak Gdk.Window window;
		public char send_event;
		public Gdk.WindowState changed_mask;
		public Gdk.WindowState new_window_state;
	}
	[ReferenceType]
	public struct Font {
		public Gdk.FontType type;
		public int ascent;
		public int descent;
	}
	[ReferenceType]
	public struct GCValues {
		public Gdk.Color foreground;
		public Gdk.Color background;
		public weak Gdk.Font font;
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
	[ReferenceType]
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
	[ReferenceType]
	public struct KeymapKey {
		public uint keycode;
		public int group;
		public int level;
	}
	[ReferenceType]
	public struct PangoAttrEmbossColor {
		public weak Pango.Attribute attr;
		public Pango.Color color;
		public PangoAttrEmbossColor (out Gdk.Color color);
	}
	[ReferenceType]
	public struct PangoAttrEmbossed {
		public weak Pango.Attribute attr;
		public bool embossed;
		public PangoAttrEmbossed (bool embossed);
	}
	[ReferenceType]
	public struct PangoAttrStipple {
		public weak Pango.Attribute attr;
		public weak Gdk.Bitmap stipple;
		public PangoAttrStipple (Gdk.Bitmap stipple);
	}
	[ReferenceType]
	public struct PixbufFormat {
		public weak string get_description ();
		public weak string get_extensions ();
		public weak string get_license ();
		public weak string get_mime_types ();
		public weak string get_name ();
		public bool is_disabled ();
		public bool is_scalable ();
		public bool is_writable ();
		public void set_disabled (bool disabled);
	}
	[ReferenceType]
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
	[ReferenceType]
	public struct PixbufScaledAnim {
		public static GLib.Type get_type ();
		public static GLib.Type iter_get_type ();
	}
	[ReferenceType]
	public struct PixbufScaledAnimClass {
	}
	[ReferenceType]
	public struct Pixdata {
		public uint magic;
		public int length;
		public uint pixdata_type;
		public uint rowstride;
		public uint width;
		public uint height;
		public uchar pixel_data;
		[NoArrayLength]
		public bool deserialize (uint stream_length, uchar[] stream, GLib.Error error);
		public pointer from_pixbuf (Gdk.Pixbuf pixbuf, bool use_rle);
		public uchar serialize (uint stream_length_p);
		public weak GLib.String to_csource (string name, Gdk.PixdataDumpType dump_type);
	}
	[ReferenceType]
	public struct PixmapObject {
		public weak Gdk.Drawable parent_instance;
		public weak Gdk.Drawable impl;
		public int depth;
	}
	[ReferenceType]
	public struct Point {
		public int x;
		public int y;
	}
	[ReferenceType]
	public struct PointerHooks {
	}
	public struct Rectangle {
		public int x;
		public int y;
		public int width;
		public int height;
		public static GLib.Type get_type ();
		[InstanceByReference]
		public bool intersect (out Gdk.Rectangle src2, out Gdk.Rectangle dest);
		[InstanceByReference]
		public void union (out Gdk.Rectangle src2, out Gdk.Rectangle dest);
	}
	[ReferenceType]
	public struct Region {
		public long size;
		public long numRects;
		public weak Gdk.RegionBox rects;
		public weak Gdk.RegionBox extents;
		public weak Gdk.Region copy ();
		public void destroy ();
		public bool empty ();
		public bool equal (Gdk.Region region2);
		public void get_clipbox (out Gdk.Rectangle rectangle);
		[NoArrayLength]
		public void get_rectangles (Gdk.Rectangle[] rectangles, int n_rectangles);
		public void intersect (Gdk.Region source2);
		public Region ();
		public void offset (int dx, int dy);
		public bool point_in (int x, int y);
		public static weak Gdk.Region polygon (Gdk.Point points, int npoints, Gdk.FillRule fill_rule);
		public Gdk.OverlapType rect_in (out Gdk.Rectangle rectangle);
		public static weak Gdk.Region rectangle (out Gdk.Rectangle rectangle);
		public void shrink (int dx, int dy);
		[NoArrayLength]
		public void spans_intersect_foreach (Gdk.Span[] spans, int n_spans, bool sorted, Gdk.SpanFunc function, pointer data);
		public void subtract (Gdk.Region source2);
		public void union (Gdk.Region source2);
		public void union_with_rect (out Gdk.Rectangle rect);
		public void xor (Gdk.Region source2);
	}
	[ReferenceType]
	public struct RegionBox {
		public int x1;
		public int y1;
		public int x2;
		public int y2;
	}
	[ReferenceType]
	public struct RgbCmap {
		public uint colors;
		public int n_colors;
		public void free ();
		[NoArrayLength]
		public RgbCmap (uint[] colors, int n_colors);
	}
	[ReferenceType]
	public struct Segment {
		public int x1;
		public int y1;
		public int x2;
		public int y2;
	}
	[ReferenceType]
	public struct Span {
		public int x;
		public int y;
		public int width;
	}
	[ReferenceType]
	public struct TimeCoord {
		public uint time;
		public double axes;
	}
	[ReferenceType]
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
		public Gdk.WindowTypeHint type_hint;
	}
	[ReferenceType]
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
		public uint composited;
		public uint destroyed;
		public uint accept_focus;
		public uint focus_on_map;
		public uint shaped;
		public Gdk.EventMask event_mask;
		public static GLib.Type get_type ();
	}
	[ReferenceType]
	public struct POINTBLOCK {
	}
	[ReferenceType]
	public struct ScanLineList {
	}
	[ReferenceType]
	public struct ScanLineListBlock {
	}
	public struct Atom {
		public static Gdk.Atom intern (string atom_name, bool only_if_exists);
		public static Gdk.Atom intern_static_string (string atom_name);
		public weak string name ();
	}
	[ReferenceType]
	public struct Cairo {
		public static weak Cairo.Context create (Gdk.Drawable drawable);
		public static void rectangle (Cairo.Context cr, out Gdk.Rectangle rectangle);
		public static void region (Cairo.Context cr, Gdk.Region region);
		public static void set_source_color (Cairo.Context cr, out Gdk.Color color);
		public static void set_source_pixbuf (Cairo.Context cr, Gdk.Pixbuf pixbuf, double pixbuf_x, double pixbuf_y);
		public static void set_source_pixmap (Cairo.Context cr, Gdk.Pixmap pixmap, double pixmap_x, double pixmap_y);
	}
	[ReferenceType]
	public struct Char {
	}
	[ReferenceType]
	public struct Colors {
	}
	[ReferenceType]
	public struct Drag {
		public static void abort (Gdk.DragContext context, uint time_);
		public static weak Gdk.DragContext begin (Gdk.Window window, GLib.List targets);
		public static void drop (Gdk.DragContext context, uint time_);
		public static bool drop_succeeded (Gdk.DragContext context);
		public static void find_window (Gdk.DragContext context, Gdk.Window drag_window, int x_root, int y_root, Gdk.Window dest_window, Gdk.DragProtocol protocol);
		public static void find_window_for_screen (Gdk.DragContext context, Gdk.Window drag_window, Gdk.Screen screen, int x_root, int y_root, Gdk.Window dest_window, Gdk.DragProtocol protocol);
		public static uint get_protocol (uint xid, Gdk.DragProtocol protocol);
		public static uint get_protocol_for_display (Gdk.Display display, uint xid, Gdk.DragProtocol protocol);
		public static Gdk.Atom get_selection (Gdk.DragContext context);
		public static bool motion (Gdk.DragContext context, Gdk.Window dest_window, Gdk.DragProtocol protocol, int x_root, int y_root, Gdk.DragAction suggested_action, Gdk.DragAction possible_actions, uint time_);
		public static void status (Gdk.DragContext context, Gdk.DragAction action, uint time_);
	}
	[ReferenceType]
	public struct Drop {
		public static void finish (Gdk.DragContext context, bool success, uint time_);
		public static void reply (Gdk.DragContext context, bool ok, uint time_);
	}
	[ReferenceType]
	public struct Error {
		public static int trap_pop ();
		public static void trap_push ();
	}
	[ReferenceType]
	public struct Event {
		public weak Gdk.Event copy ();
		public void free ();
		public static weak Gdk.Event get ();
		public bool get_axis (Gdk.AxisUse axis_use, double value);
		public bool get_coords (double x_win, double y_win);
		public static weak Gdk.Event get_graphics_expose (Gdk.Window window);
		public bool get_root_coords (double x_root, double y_root);
		public weak Gdk.Screen get_screen ();
		public bool get_state (Gdk.ModifierType state);
		public uint get_time ();
		public static GLib.Type get_type ();
		public static void handler_set (Gdk.EventFunc func, pointer data, GLib.DestroyNotify notify);
		public Event (Gdk.EventType type);
		public static weak Gdk.Event peek ();
		public void put ();
		public static void request_motions (Gdk.EventMotion event);
		public bool send_client_message (pointer winid);
		public static bool send_client_message_for_display (Gdk.Display display, Gdk.Event event, pointer winid);
		public void send_clientmessage_toall ();
		public void set_screen (Gdk.Screen screen);
	}
	[ReferenceType]
	public struct Fontset {
	}
	[ReferenceType]
	public struct Input {
		public static void set_extension_events (Gdk.Window window, int mask, Gdk.ExtensionMode mode);
	}
	[ReferenceType]
	public struct Keyboard {
		public static Gdk.GrabStatus grab (Gdk.Window window, bool owner_events, uint time_);
		public static bool grab_info_libgtk_only (Gdk.Display display, Gdk.Window grab_window, bool owner_events);
		public static void ungrab (uint time_);
	}
	[ReferenceType]
	public struct Keyval {
		public static void convert_case (uint symbol, uint lower, uint upper);
		public static uint from_name (string keyval_name);
		public static bool is_lower (uint keyval);
		public static bool is_upper (uint keyval);
		public static weak string name (uint keyval);
		public static uint to_lower (uint keyval);
		public static uint to_unicode (uint keyval);
		public static uint to_upper (uint keyval);
	}
	[ReferenceType]
	public struct Notify {
		public static void startup_complete ();
		public static void startup_complete_with_id (string startup_id);
	}
	[ReferenceType]
	public struct Pango {
		public static weak Pango.Context context_get ();
		public static weak Pango.Context context_get_for_screen (Gdk.Screen screen);
		public static weak Gdk.Region layout_get_clip_region (Pango.Layout layout, int x_origin, int y_origin, int index_ranges, int n_ranges);
		public static weak Gdk.Region layout_line_get_clip_region (Pango.LayoutLine line, int x_origin, int y_origin, int index_ranges, int n_ranges);
	}
	[ReferenceType]
	public struct Pointer {
		public static Gdk.GrabStatus grab (Gdk.Window window, bool owner_events, Gdk.EventMask event_mask, Gdk.Window confine_to, Gdk.Cursor cursor, uint time_);
		public static bool grab_info_libgtk_only (Gdk.Display display, Gdk.Window grab_window, bool owner_events);
		public static bool is_grabbed ();
		public static void ungrab (uint time_);
	}
	[ReferenceType]
	public struct Property {
		[NoArrayLength]
		public static void change (Gdk.Window window, Gdk.Atom property, Gdk.Atom type, int format, Gdk.PropMode mode, uchar[] data, int nelements);
		public static void delete (Gdk.Window window, Gdk.Atom property);
		[NoArrayLength]
		public static bool get (Gdk.Window window, Gdk.Atom property, Gdk.Atom type, ulong offset, ulong length, int pdelete, out Gdk.Atom actual_property_type, int actual_format, int actual_length, uchar[] data);
	}
	[ReferenceType]
	public struct Query {
		public static void depths (int depths, int count);
		public static void visual_types (Gdk.VisualType visual_types, int count);
	}
	[ReferenceType]
	public struct Rgb {
		public static bool colormap_ditherable (Gdk.Colormap cmap);
		public static bool ditherable ();
		public static void find_color (Gdk.Colormap colormap, out Gdk.Color color);
		public static weak Gdk.Colormap get_colormap ();
		public static weak Gdk.Visual get_visual ();
		public static void set_install (bool install);
		public static void set_min_colors (int min_colors);
		public static void set_verbose (bool verbose);
	}
	[ReferenceType]
	public struct Selection {
		public static void convert (Gdk.Window requestor, Gdk.Atom selection, Gdk.Atom target, uint time_);
		public static weak Gdk.Window owner_get (Gdk.Atom selection);
		public static weak Gdk.Window owner_get_for_display (Gdk.Display display, Gdk.Atom selection);
		public static bool owner_set (Gdk.Window owner, Gdk.Atom selection, uint time_, bool send_event);
		public static bool owner_set_for_display (Gdk.Display display, Gdk.Window owner, Gdk.Atom selection, uint time_, bool send_event);
		[NoArrayLength]
		public static bool property_get (Gdk.Window requestor, uchar[] data, out Gdk.Atom prop_type, int prop_format);
		public static void send_notify (uint requestor, Gdk.Atom selection, Gdk.Atom target, Gdk.Atom property, uint time_);
		public static void send_notify_for_display (Gdk.Display display, uint requestor, Gdk.Atom selection, Gdk.Atom target, Gdk.Atom property, uint time_);
	}
	[ReferenceType]
	public struct Spawn {
		public static bool command_line_on_screen (Gdk.Screen screen, string command_line, GLib.Error error);
		public static bool on_screen (Gdk.Screen screen, string working_directory, string argv, string envp, GLib.SpawnFlags @flags, GLib.SpawnChildSetupFunc child_setup, pointer user_data, int child_pid, GLib.Error error);
		public static bool on_screen_with_pipes (Gdk.Screen screen, string working_directory, string argv, string envp, GLib.SpawnFlags @flags, GLib.SpawnChildSetupFunc child_setup, pointer user_data, int child_pid, int standard_input, int standard_output, int standard_error, GLib.Error error);
	}
	[ReferenceType]
	public struct Text {
		[NoArrayLength]
		public static int property_to_text_list (Gdk.Atom encoding, int format, uchar[] text, int length, string list);
		[NoArrayLength]
		public static int property_to_text_list_for_display (Gdk.Display display, Gdk.Atom encoding, int format, uchar[] text, int length, string list);
		[NoArrayLength]
		public static int property_to_utf8_list (Gdk.Atom encoding, int format, uchar[] text, int length, string list);
		[NoArrayLength]
		public static int property_to_utf8_list_for_display (Gdk.Display display, Gdk.Atom encoding, int format, uchar[] text, int length, string list);
	}
	[ReferenceType]
	public struct Threads {
		public static uint add_idle (GLib.SourceFunc function, pointer data);
		public static uint add_idle_full (int priority, GLib.SourceFunc function, pointer data, GLib.DestroyNotify notify);
		public static uint add_timeout (uint interval, GLib.SourceFunc function, pointer data);
		public static uint add_timeout_full (int priority, uint interval, GLib.SourceFunc function, pointer data, GLib.DestroyNotify notify);
		public static void enter ();
		public static void init ();
		public static void leave ();
		public static void set_lock_functions (GLib.Callback enter_fn, GLib.Callback leave_fn);
	}
	public static delegate void DestroyNotify (pointer data);
	public static delegate void EventFunc (Gdk.Event event, pointer data);
	public static delegate Gdk.FilterReturn FilterFunc (pointer xevent, Gdk.Event event, pointer data);
	public static delegate void InputFunction (pointer data, int source, Gdk.InputCondition condition);
	public static delegate void PixbufDestroyNotify (uchar[] pixels, pointer data);
	public static delegate bool PixbufSaveFunc (string buf, ulong count, GLib.Error error, pointer data);
	public static delegate void SpanFunc (Gdk.Span span, pointer data);
	public static delegate bool invalidate_maybe_recurseChildFunc (Gdk.Window arg1, pointer data);
	public static void add_client_message_filter (Gdk.Atom message_type, Gdk.FilterFunc func, pointer data);
	public static void add_option_entries_libgtk_only (GLib.OptionGroup group);
	public static weak GLib.List devices_list ();
	public static bool events_pending ();
	[NoArrayLength]
	public static void free_compound_text (uchar[] ctext);
	public static void free_text_list (string list);
	public static weak Gdk.Window get_default_root_window ();
	public static weak string get_display ();
	public static weak string get_display_arg_name ();
	public static weak string get_program_class ();
	public static bool get_show_events ();
	public static bool init_check (int argc, string argv);
	public static weak GLib.List list_visuals ();
	public static void parse_args (int argc, string argv);
	public static void pre_parse_libgtk_only ();
	public static void set_double_click_time (uint msec);
	public static weak string set_locale ();
	public static weak Gdk.PointerHooks set_pointer_hooks (Gdk.PointerHooks new_hooks);
	public static void set_program_class (string program_class);
	public static void set_show_events (bool show_events);
	public static void set_sm_client_id (string sm_client_id);
	public static bool setting_get (string name, GLib.Value value);
	[NoArrayLength]
	public static int string_to_compound_text (string str, out Gdk.Atom encoding, int format, uchar[] ctext, int length);
	[NoArrayLength]
	public static int string_to_compound_text_for_display (Gdk.Display display, string str, out Gdk.Atom encoding, int format, uchar[] ctext, int length);
	public static uint unicode_to_keyval (uint wc);
}
