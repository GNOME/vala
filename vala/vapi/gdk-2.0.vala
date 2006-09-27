[CCode (cheader_filename = "gdk/gdk.h")]
namespace Gdk {
	public class Colormap : GLib.Object {
		public weak int size;
		public weak Gdk.Color colors;
		[NoArrayLength ()]
		public bool alloc_color (Gdk.Color color, bool writeable, bool best_match);
		[NoArrayLength ()]
		public int alloc_colors (Gdk.Color colors, int ncolors, bool writeable, bool best_match, bool success);
		[NoArrayLength ()]
		public void free_colors (Gdk.Color colors, int ncolors);
		[NoArrayLength ()]
		public Gdk.Screen get_screen ();
		[NoArrayLength ()]
		public static Gdk.Colormap get_system ();
		[NoArrayLength ()]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		public Gdk.Visual get_visual ();
		[NoArrayLength ()]
		public construct (Gdk.Visual visual, bool allocate);
		[NoArrayLength ()]
		public void query_color (ulong pixel, Gdk.Color result);
	}
	public class Device : GLib.Object {
		[NoArrayLength ()]
		public static void free_history (Gdk.TimeCoord events, int n_events);
		[NoArrayLength ()]
		public bool get_axis (double axes, Gdk.AxisUse use, double value);
		[NoArrayLength ()]
		public static Gdk.Device get_core_pointer ();
		[NoArrayLength ()]
		public bool get_history (Gdk.Window window, uint start, uint stop, Gdk.TimeCoord events, int n_events);
		[NoArrayLength ()]
		public void get_state (Gdk.Window window, double axes, Gdk.ModifierType mask);
		[NoArrayLength ()]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		public void set_axis_use (uint index_, Gdk.AxisUse use);
		[NoArrayLength ()]
		public void set_key (uint index_, uint keyval, Gdk.ModifierType modifiers);
		[NoArrayLength ()]
		public bool set_mode (Gdk.InputMode mode);
		[NoArrayLength ()]
		public void set_source (Gdk.InputSource source);
	}
	public class Display : GLib.Object {
		[NoArrayLength ()]
		public void add_client_message_filter (Gdk.Atom message_type, Gdk.FilterFunc func, pointer data);
		[NoArrayLength ()]
		public void beep ();
		[NoArrayLength ()]
		public void close ();
		[NoArrayLength ()]
		public void flush ();
		[NoArrayLength ()]
		public Gdk.Device get_core_pointer ();
		[NoArrayLength ()]
		public static Gdk.Display get_default ();
		[NoArrayLength ()]
		public uint get_default_cursor_size ();
		[NoArrayLength ()]
		public Gdk.Window get_default_group ();
		[NoArrayLength ()]
		public virtual Gdk.Screen get_default_screen ();
		[NoArrayLength ()]
		public Gdk.Event get_event ();
		[NoArrayLength ()]
		public void get_maximal_cursor_size (uint width, uint height);
		[NoArrayLength ()]
		public virtual int get_n_screens ();
		[NoArrayLength ()]
		public string get_name ();
		[NoArrayLength ()]
		public void get_pointer (Gdk.Screen screen, int x, int y, Gdk.ModifierType mask);
		[NoArrayLength ()]
		public virtual Gdk.Screen get_screen (int screen_num);
		[NoArrayLength ()]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		public Gdk.Window get_window_at_pointer (int win_x, int win_y);
		[NoArrayLength ()]
		public void keyboard_ungrab (uint time_);
		[NoArrayLength ()]
		public GLib.List list_devices ();
		[NoArrayLength ()]
		public static Gdk.Display open (string display_name);
		[NoArrayLength ()]
		public static Gdk.Display open_default_libgtk_only ();
		[NoArrayLength ()]
		public Gdk.Event peek_event ();
		[NoArrayLength ()]
		public bool pointer_is_grabbed ();
		[NoArrayLength ()]
		public void pointer_ungrab (uint time_);
		[NoArrayLength ()]
		public void put_event (Gdk.Event event);
		[NoArrayLength ()]
		public bool request_selection_notification (Gdk.Atom selection);
		[NoArrayLength ()]
		public void set_double_click_distance (uint distance);
		[NoArrayLength ()]
		public void set_double_click_time (uint msec);
		[NoArrayLength ()]
		public Gdk.DisplayPointerHooks set_pointer_hooks (Gdk.DisplayPointerHooks new_hooks);
		[NoArrayLength ()]
		public void store_clipboard (Gdk.Window clipboard_window, uint time_, Gdk.Atom targets, int n_targets);
		[NoArrayLength ()]
		public bool supports_clipboard_persistence ();
		[NoArrayLength ()]
		public bool supports_cursor_alpha ();
		[NoArrayLength ()]
		public bool supports_cursor_color ();
		[NoArrayLength ()]
		public bool supports_input_shapes ();
		[NoArrayLength ()]
		public bool supports_selection_notification ();
		[NoArrayLength ()]
		public bool supports_shapes ();
		[NoArrayLength ()]
		public void sync ();
		[NoArrayLength ()]
		public void warp_pointer (Gdk.Screen screen, int x, int y);
		public signal void closed (bool is_error);
	}
	public class DisplayManager : GLib.Object {
		[NoArrayLength ()]
		public static Gdk.DisplayManager @get ();
		[NoArrayLength ()]
		public Gdk.Display get_default_display ();
		[NoArrayLength ()]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		public GLib.SList list_displays ();
		[NoArrayLength ()]
		public void set_default_display (Gdk.Display display);
		public weak Gdk.Display default_display { get; set; }
		public signal void display_opened (Gdk.Display display);
	}
	public class DragContext : GLib.Object {
		public weak Gdk.DragProtocol protocol;
		public weak bool is_source;
		public weak Gdk.Window source_window;
		public weak Gdk.Window dest_window;
		public weak GLib.List targets;
		public weak Gdk.DragAction actions;
		public weak Gdk.DragAction suggested_action;
		public weak Gdk.DragAction action;
		public weak uint start_time;
		[NoArrayLength ()]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		public construct ();
	}
	public class Drawable : GLib.Object {
		[NoArrayLength ()]
		public virtual void draw_arc (Gdk.GC gc, bool filled, int x, int y, int width, int height, int angle1, int angle2);
		[NoArrayLength ()]
		public virtual void draw_drawable (Gdk.GC gc, Gdk.Drawable src, int xsrc, int ysrc, int xdest, int ydest, int width, int height);
		[NoArrayLength ()]
		public virtual void draw_glyphs (Gdk.GC gc, Pango.Font font, int x, int y, Pango.GlyphString glyphs);
		[NoArrayLength ()]
		public virtual void draw_glyphs_transformed (Gdk.GC gc, Pango.Matrix matrix, Pango.Font font, int x, int y, Pango.GlyphString glyphs);
		[NoArrayLength ()]
		public void draw_gray_image (Gdk.GC gc, int x, int y, int width, int height, Gdk.RgbDither dith, uchar buf, int rowstride);
		[NoArrayLength ()]
		public virtual void draw_image (Gdk.GC gc, Gdk.Image image, int xsrc, int ysrc, int xdest, int ydest, int width, int height);
		[NoArrayLength ()]
		public void draw_indexed_image (Gdk.GC gc, int x, int y, int width, int height, Gdk.RgbDither dith, uchar buf, int rowstride, Gdk.RgbCmap cmap);
		[NoArrayLength ()]
		public void draw_layout (Gdk.GC gc, int x, int y, Pango.Layout layout);
		[NoArrayLength ()]
		public void draw_layout_line (Gdk.GC gc, int x, int y, Pango.LayoutLine line);
		[NoArrayLength ()]
		public void draw_layout_line_with_colors (Gdk.GC gc, int x, int y, Pango.LayoutLine line, Gdk.Color foreground, Gdk.Color background);
		[NoArrayLength ()]
		public void draw_layout_with_colors (Gdk.GC gc, int x, int y, Pango.Layout layout, Gdk.Color foreground, Gdk.Color background);
		[NoArrayLength ()]
		public void draw_line (Gdk.GC gc, int x1_, int y1_, int x2_, int y2_);
		[NoArrayLength ()]
		public virtual void draw_lines (Gdk.GC gc, Gdk.Point points, int npoints);
		[NoArrayLength ()]
		public virtual void draw_pixbuf (Gdk.GC gc, Gdk.Pixbuf pixbuf, int src_x, int src_y, int dest_x, int dest_y, int width, int height, Gdk.RgbDither dither, int x_dither, int y_dither);
		[NoArrayLength ()]
		public void draw_point (Gdk.GC gc, int x, int y);
		[NoArrayLength ()]
		public virtual void draw_points (Gdk.GC gc, Gdk.Point points, int npoints);
		[NoArrayLength ()]
		public virtual void draw_polygon (Gdk.GC gc, bool filled, Gdk.Point points, int npoints);
		[NoArrayLength ()]
		public virtual void draw_rectangle (Gdk.GC gc, bool filled, int x, int y, int width, int height);
		[NoArrayLength ()]
		public void draw_rgb_32_image (Gdk.GC gc, int x, int y, int width, int height, Gdk.RgbDither dith, uchar buf, int rowstride);
		[NoArrayLength ()]
		public void draw_rgb_32_image_dithalign (Gdk.GC gc, int x, int y, int width, int height, Gdk.RgbDither dith, uchar buf, int rowstride, int xdith, int ydith);
		[NoArrayLength ()]
		public void draw_rgb_image (Gdk.GC gc, int x, int y, int width, int height, Gdk.RgbDither dith, uchar rgb_buf, int rowstride);
		[NoArrayLength ()]
		public void draw_rgb_image_dithalign (Gdk.GC gc, int x, int y, int width, int height, Gdk.RgbDither dith, uchar rgb_buf, int rowstride, int xdith, int ydith);
		[NoArrayLength ()]
		public virtual void draw_segments (Gdk.GC gc, Gdk.Segment segs, int nsegs);
		[NoArrayLength ()]
		public virtual void draw_trapezoids (Gdk.GC gc, Gdk.Trapezoid trapezoids, int n_trapezoids);
		[NoArrayLength ()]
		public Gdk.Image copy_to_image (Gdk.Image image, int src_x, int src_y, int dest_x, int dest_y, int width, int height);
		[NoArrayLength ()]
		public virtual Gdk.Region get_clip_region ();
		[NoArrayLength ()]
		public virtual Gdk.Colormap get_colormap ();
		[NoArrayLength ()]
		public virtual int get_depth ();
		[NoArrayLength ()]
		public Gdk.Display get_display ();
		[NoArrayLength ()]
		public virtual Gdk.Image get_image (int x, int y, int width, int height);
		[NoArrayLength ()]
		public virtual Gdk.Screen get_screen ();
		[NoArrayLength ()]
		public virtual void get_size (int width, int height);
		[NoArrayLength ()]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		public virtual Gdk.Region get_visible_region ();
		[NoArrayLength ()]
		public virtual Gdk.Visual get_visual ();
		[NoArrayLength ()]
		public virtual void set_colormap (Gdk.Colormap colormap);
	}
	public class GC : GLib.Object {
		[NoArrayLength ()]
		public void copy (Gdk.GC src_gc);
		[NoArrayLength ()]
		public Gdk.Colormap get_colormap ();
		[NoArrayLength ()]
		public Gdk.Screen get_screen ();
		[NoArrayLength ()]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		public virtual void get_values (Gdk.GCValues values);
		[NoArrayLength ()]
		public construct (Gdk.Drawable drawable);
		[NoArrayLength ()]
		public construct with_values (Gdk.Drawable drawable, Gdk.GCValues values, Gdk.GCValuesMask values_mask);
		[NoArrayLength ()]
		public void offset (int x_offset, int y_offset);
		[NoArrayLength ()]
		public void set_background (Gdk.Color color);
		[NoArrayLength ()]
		public void set_clip_mask (Gdk.Bitmap mask);
		[NoArrayLength ()]
		public void set_clip_origin (int x, int y);
		[NoArrayLength ()]
		public void set_clip_rectangle (Gdk.Rectangle rectangle);
		[NoArrayLength ()]
		public void set_clip_region (Gdk.Region region);
		[NoArrayLength ()]
		public void set_colormap (Gdk.Colormap colormap);
		[NoArrayLength ()]
		public virtual void set_dashes (int dash_offset, char[] dash_list, int n);
		[NoArrayLength ()]
		public void set_exposures (bool exposures);
		[NoArrayLength ()]
		public void set_fill (Gdk.Fill fill);
		[NoArrayLength ()]
		public void set_foreground (Gdk.Color color);
		[NoArrayLength ()]
		public void set_function (Gdk.Function function);
		[NoArrayLength ()]
		public void set_line_attributes (int line_width, Gdk.LineStyle line_style, Gdk.CapStyle cap_style, Gdk.JoinStyle join_style);
		[NoArrayLength ()]
		public void set_rgb_bg_color (Gdk.Color color);
		[NoArrayLength ()]
		public void set_rgb_fg_color (Gdk.Color color);
		[NoArrayLength ()]
		public void set_stipple (Gdk.Pixmap stipple);
		[NoArrayLength ()]
		public void set_subwindow (Gdk.SubwindowMode mode);
		[NoArrayLength ()]
		public void set_tile (Gdk.Pixmap tile);
		[NoArrayLength ()]
		public void set_ts_origin (int x, int y);
		[NoArrayLength ()]
		public virtual void set_values (Gdk.GCValues values, Gdk.GCValuesMask values_mask);
	}
	public class Image : GLib.Object {
		public weak Gdk.ImageType type;
		public weak Gdk.Visual visual;
		public weak Gdk.ByteOrder byte_order;
		public weak int width;
		public weak int height;
		public weak ushort depth;
		public weak ushort bpp;
		public weak ushort bpl;
		public weak ushort bits_per_pixel;
		public weak pointer mem;
		public weak Gdk.Colormap colormap;
		[NoArrayLength ()]
		public Gdk.Colormap get_colormap ();
		[NoArrayLength ()]
		public uint get_pixel (int x, int y);
		[NoArrayLength ()]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		public construct (Gdk.ImageType type, Gdk.Visual visual, int width, int height);
		[NoArrayLength ()]
		public void put_pixel (int x, int y, uint pixel);
		[NoArrayLength ()]
		public void set_colormap (Gdk.Colormap colormap);
	}
	public class Keymap : GLib.Object {
		[NoArrayLength ()]
		public static Gdk.Keymap get_default ();
		[NoArrayLength ()]
		public Pango.Direction get_direction ();
		[NoArrayLength ()]
		public bool get_entries_for_keycode (uint hardware_keycode, Gdk.KeymapKey keys, uint keyvals, int n_entries);
		[NoArrayLength ()]
		public bool get_entries_for_keyval (uint keyval, Gdk.KeymapKey keys, int n_keys);
		[NoArrayLength ()]
		public static Gdk.Keymap get_for_display (Gdk.Display display);
		[NoArrayLength ()]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		public uint lookup_key (Gdk.KeymapKey key);
		[NoArrayLength ()]
		public bool translate_keyboard_state (uint hardware_keycode, Gdk.ModifierType state, int group, uint keyval, int effective_group, int level, Gdk.ModifierType consumed_modifiers);
		public signal void direction_changed ();
		public signal void keys_changed ();
	}
	public class PangoRenderer : Pango.Renderer {
		[NoArrayLength ()]
		public static Pango.Renderer get_default (Gdk.Screen screen);
		[NoArrayLength ()]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		public construct (Gdk.Screen screen);
		[NoArrayLength ()]
		public void set_drawable (Gdk.Drawable drawable);
		[NoArrayLength ()]
		public void set_gc (Gdk.GC gc);
		[NoArrayLength ()]
		public void set_override_color (Pango.RenderPart part, Gdk.Color color);
		[NoArrayLength ()]
		public void set_stipple (Pango.RenderPart part, Gdk.Bitmap stipple);
		[NoAccessorMethod ()]
		public weak Gdk.Screen screen { get; construct; }
	}
	public class Pixbuf : GLib.Object {
		[NoArrayLength ()]
		public Gdk.Pixbuf add_alpha (bool substitute_color, uchar r, uchar g, uchar b);
		[NoArrayLength ()]
		public void composite (Gdk.Pixbuf dest, int dest_x, int dest_y, int dest_width, int dest_height, double offset_x, double offset_y, double scale_x, double scale_y, Gdk.InterpType interp_type, int overall_alpha);
		[NoArrayLength ()]
		public void composite_color (Gdk.Pixbuf dest, int dest_x, int dest_y, int dest_width, int dest_height, double offset_x, double offset_y, double scale_x, double scale_y, Gdk.InterpType interp_type, int overall_alpha, int check_x, int check_y, int check_size, uint color1, uint color2);
		[NoArrayLength ()]
		public Gdk.Pixbuf composite_color_simple (int dest_width, int dest_height, Gdk.InterpType interp_type, int overall_alpha, int check_size, uint color1, uint color2);
		[NoArrayLength ()]
		public Gdk.Pixbuf copy ();
		[NoArrayLength ()]
		public void copy_area (int src_x, int src_y, int width, int height, Gdk.Pixbuf dest_pixbuf, int dest_x, int dest_y);
		[NoArrayLength ()]
		public static GLib.Quark error_quark ();
		[NoArrayLength ()]
		public void fill (uint pixel);
		[NoArrayLength ()]
		public Gdk.Pixbuf flip (bool horizontal);
		[NoArrayLength ()]
		public static Gdk.Pixbuf from_pixdata (Gdk.Pixdata pixdata, bool copy_pixels, GLib.Error error);
		[NoArrayLength ()]
		public int get_bits_per_sample ();
		[NoArrayLength ()]
		public Gdk.Colorspace get_colorspace ();
		[NoArrayLength ()]
		public static Gdk.PixbufFormat get_file_info (string filename, int width, int height);
		[NoArrayLength ()]
		public static GLib.SList get_formats ();
		[NoArrayLength ()]
		public Gdk.Pixbuf get_from_drawable (Gdk.Drawable src, Gdk.Colormap cmap, int src_x, int src_y, int dest_x, int dest_y, int width, int height);
		[NoArrayLength ()]
		public Gdk.Pixbuf get_from_image (Gdk.Image src, Gdk.Colormap cmap, int src_x, int src_y, int dest_x, int dest_y, int width, int height);
		[NoArrayLength ()]
		public bool get_has_alpha ();
		[NoArrayLength ()]
		public int get_height ();
		[NoArrayLength ()]
		public int get_n_channels ();
		[NoArrayLength ()]
		public string get_option (string key);
		[NoArrayLength ()]
		public uchar get_pixels ();
		[NoArrayLength ()]
		public int get_rowstride ();
		[NoArrayLength ()]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		public int get_width ();
		[NoArrayLength ()]
		public construct (Gdk.Colorspace colorspace, bool has_alpha, int bits_per_sample, int width, int height);
		[NoArrayLength ()]
		public construct from_data (uchar data, Gdk.Colorspace colorspace, bool has_alpha, int bits_per_sample, int width, int height, int rowstride, Gdk.PixbufDestroyNotify destroy_fn, pointer destroy_fn_data);
		[NoArrayLength ()]
		public construct from_file (string filename, GLib.Error error);
		[NoArrayLength ()]
		public construct from_file_at_scale (string filename, int width, int height, bool preserve_aspect_ratio, GLib.Error error);
		[NoArrayLength ()]
		public construct from_file_at_size (string filename, int width, int height, GLib.Error error);
		[NoArrayLength ()]
		public construct from_inline (int data_length, uchar data, bool copy_pixels, GLib.Error error);
		[NoArrayLength ()]
		public construct from_xpm_data (string data);
		[NoArrayLength ()]
		public construct subpixbuf (int src_x, int src_y, int width, int height);
		[NoArrayLength ()]
		public void render_pixmap_and_mask (Gdk.Pixmap pixmap_return, Gdk.Bitmap mask_return, int alpha_threshold);
		[NoArrayLength ()]
		public void render_pixmap_and_mask_for_colormap (Gdk.Colormap colormap, Gdk.Pixmap pixmap_return, Gdk.Bitmap mask_return, int alpha_threshold);
		[NoArrayLength ()]
		public void render_threshold_alpha (Gdk.Bitmap bitmap, int src_x, int src_y, int dest_x, int dest_y, int width, int height, int alpha_threshold);
		[NoArrayLength ()]
		public Gdk.Pixbuf rotate_simple (Gdk.PixbufRotation angle);
		[NoArrayLength ()]
		public void saturate_and_pixelate (Gdk.Pixbuf dest, float saturation, bool pixelate);
		[NoArrayLength ()]
		public bool save (string filename, string type, GLib.Error error);
		[NoArrayLength ()]
		public bool save_to_buffer (string buffer, ulong buffer_size, string type, GLib.Error error);
		[NoArrayLength ()]
		public bool save_to_bufferv (string buffer, ulong buffer_size, string type, string option_keys, string option_values, GLib.Error error);
		[NoArrayLength ()]
		public bool save_to_callback (Gdk.PixbufSaveFunc save_func, pointer user_data, string type, GLib.Error error);
		[NoArrayLength ()]
		public bool save_to_callbackv (Gdk.PixbufSaveFunc save_func, pointer user_data, string type, string option_keys, string option_values, GLib.Error error);
		[NoArrayLength ()]
		public bool savev (string filename, string type, string option_keys, string option_values, GLib.Error error);
		[NoArrayLength ()]
		public void scale (Gdk.Pixbuf dest, int dest_x, int dest_y, int dest_width, int dest_height, double offset_x, double offset_y, double scale_x, double scale_y, Gdk.InterpType interp_type);
		[NoArrayLength ()]
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
	public class PixbufAnimation : GLib.Object {
		[NoArrayLength ()]
		public int get_height ();
		[NoArrayLength ()]
		public Gdk.PixbufAnimationIter get_iter (GLib.TimeVal start_time);
		[NoArrayLength ()]
		public Gdk.Pixbuf get_static_image ();
		[NoArrayLength ()]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		public int get_width ();
		[NoArrayLength ()]
		public bool is_static_image ();
		[NoArrayLength ()]
		public construct from_file (string filename, GLib.Error error);
	}
	public class PixbufAnimationIter : GLib.Object {
		[NoArrayLength ()]
		public bool advance (GLib.TimeVal current_time);
		[NoArrayLength ()]
		public int get_delay_time ();
		[NoArrayLength ()]
		public Gdk.Pixbuf get_pixbuf ();
		[NoArrayLength ()]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		public bool on_currently_loading_frame ();
	}
	public class PixbufAniAnim : Gdk.PixbufAnimation {
		[NoArrayLength ()]
		public static GLib.Type get_type ();
	}
	public class PixbufAniAnimIter : Gdk.PixbufAnimationIter {
		[NoArrayLength ()]
		public static GLib.Type get_type ();
	}
	public class PixbufGifAnim : Gdk.PixbufAnimation {
		[NoArrayLength ()]
		public void frame_composite (Gdk.PixbufFrame frame);
		[NoArrayLength ()]
		public static GLib.Type get_type ();
	}
	public class PixbufGifAnimIter : Gdk.PixbufAnimationIter {
		[NoArrayLength ()]
		public static GLib.Type get_type ();
	}
	public class PixbufLoader : GLib.Object {
		[NoArrayLength ()]
		public bool close (GLib.Error error);
		[NoArrayLength ()]
		public Gdk.PixbufAnimation get_animation ();
		[NoArrayLength ()]
		public Gdk.PixbufFormat get_format ();
		[NoArrayLength ()]
		public Gdk.Pixbuf get_pixbuf ();
		[NoArrayLength ()]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		public construct ();
		[NoArrayLength ()]
		public construct with_mime_type (string mime_type, GLib.Error error);
		[NoArrayLength ()]
		public construct with_type (string image_type, GLib.Error error);
		[NoArrayLength ()]
		public void set_size (int width, int height);
		[NoArrayLength ()]
		public bool write (uchar buf, ulong count, GLib.Error error);
		public signal void size_prepared (int width, int height);
		public signal void area_prepared ();
		public signal void area_updated (int x, int y, int width, int height);
		public signal void closed ();
	}
	public class PixbufSimpleAnim : Gdk.PixbufAnimation {
		[NoArrayLength ()]
		public void add_frame (Gdk.Pixbuf pixbuf);
		[NoArrayLength ()]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		public static GLib.Type iter_get_type ();
		[NoArrayLength ()]
		public construct (int width, int height, float rate);
	}
	public class Pixmap : GLib.Object {
		[NoArrayLength ()]
		public static Gdk.Pixmap colormap_create_from_xpm (Gdk.Drawable drawable, Gdk.Colormap colormap, Gdk.Bitmap mask, Gdk.Color transparent_color, string filename);
		[NoArrayLength ()]
		public static Gdk.Pixmap colormap_create_from_xpm_d (Gdk.Drawable drawable, Gdk.Colormap colormap, Gdk.Bitmap mask, Gdk.Color transparent_color, string data);
		[NoArrayLength ()]
		public static Gdk.Pixmap create_from_data (Gdk.Drawable drawable, string data, int width, int height, int depth, Gdk.Color fg, Gdk.Color bg);
		[NoArrayLength ()]
		public static Gdk.Pixmap create_from_xpm (Gdk.Drawable drawable, Gdk.Bitmap mask, Gdk.Color transparent_color, string filename);
		[NoArrayLength ()]
		public static Gdk.Pixmap create_from_xpm_d (Gdk.Drawable drawable, Gdk.Bitmap mask, Gdk.Color transparent_color, string data);
		[NoArrayLength ()]
		public static Gdk.Pixmap foreign_new (pointer anid);
		[NoArrayLength ()]
		public static Gdk.Pixmap foreign_new_for_display (Gdk.Display display, pointer anid);
		[NoArrayLength ()]
		public static Gdk.Pixmap foreign_new_for_screen (Gdk.Screen screen, pointer anid, int width, int height, int depth);
		[NoArrayLength ()]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		public static Gdk.Pixmap lookup (pointer anid);
		[NoArrayLength ()]
		public static Gdk.Pixmap lookup_for_display (Gdk.Display display, pointer anid);
		[NoArrayLength ()]
		public construct (Gdk.Drawable drawable, int width, int height, int depth);
	}
	public class Screen : GLib.Object {
		[NoArrayLength ()]
		public void broadcast_client_message (Gdk.Event event);
		[NoArrayLength ()]
		public Gdk.Window get_active_window ();
		[NoArrayLength ()]
		public static Gdk.Screen get_default ();
		[NoArrayLength ()]
		public Gdk.Colormap get_default_colormap ();
		[NoArrayLength ()]
		public Gdk.Display get_display ();
		[NoArrayLength ()]
		public pointer get_font_options ();
		[NoArrayLength ()]
		public int get_height ();
		[NoArrayLength ()]
		public int get_height_mm ();
		[NoArrayLength ()]
		public int get_monitor_at_point (int x, int y);
		[NoArrayLength ()]
		public int get_monitor_at_window (Gdk.Window window);
		[NoArrayLength ()]
		public void get_monitor_geometry (int monitor_num, Gdk.Rectangle dest);
		[NoArrayLength ()]
		public int get_n_monitors ();
		[NoArrayLength ()]
		public int get_number ();
		[NoArrayLength ()]
		public double get_resolution ();
		[NoArrayLength ()]
		public Gdk.Colormap get_rgb_colormap ();
		[NoArrayLength ()]
		public Gdk.Visual get_rgb_visual ();
		[NoArrayLength ()]
		public Gdk.Colormap get_rgba_colormap ();
		[NoArrayLength ()]
		public Gdk.Visual get_rgba_visual ();
		[NoArrayLength ()]
		public Gdk.Window get_root_window ();
		[NoArrayLength ()]
		public bool get_setting (string name, GLib.Value value);
		[NoArrayLength ()]
		public Gdk.Colormap get_system_colormap ();
		[NoArrayLength ()]
		public Gdk.Visual get_system_visual ();
		[NoArrayLength ()]
		public GLib.List get_toplevel_windows ();
		[NoArrayLength ()]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		public int get_width ();
		[NoArrayLength ()]
		public int get_width_mm ();
		[NoArrayLength ()]
		public GLib.List get_window_stack ();
		[NoArrayLength ()]
		public static int height ();
		[NoArrayLength ()]
		public static int height_mm ();
		[NoArrayLength ()]
		public bool is_composited ();
		[NoArrayLength ()]
		public GLib.List list_visuals ();
		[NoArrayLength ()]
		public string make_display_name ();
		[NoArrayLength ()]
		public void set_default_colormap (Gdk.Colormap colormap);
		[NoArrayLength ()]
		public void set_font_options (pointer options);
		[NoArrayLength ()]
		public void set_resolution (double dpi);
		[NoArrayLength ()]
		public static int width ();
		[NoArrayLength ()]
		public static int width_mm ();
		public weak pointer font_options { get; set; }
		public weak double resolution { get; set; }
		public signal void size_changed ();
		public signal void composited_changed ();
	}
	public class Visual : GLib.Object {
		[NoArrayLength ()]
		public static Gdk.Visual get_best ();
		[NoArrayLength ()]
		public static int get_best_depth ();
		[NoArrayLength ()]
		public static Gdk.VisualType get_best_type ();
		[NoArrayLength ()]
		public static Gdk.Visual get_best_with_both (int depth, Gdk.VisualType visual_type);
		[NoArrayLength ()]
		public static Gdk.Visual get_best_with_depth (int depth);
		[NoArrayLength ()]
		public static Gdk.Visual get_best_with_type (Gdk.VisualType visual_type);
		[NoArrayLength ()]
		public Gdk.Screen get_screen ();
		[NoArrayLength ()]
		public static Gdk.Visual get_system ();
		[NoArrayLength ()]
		public static GLib.Type get_type ();
	}
	public class Window : Gdk.Drawable {
		[NoArrayLength ()]
		public void add_filter (Gdk.FilterFunc function, pointer data);
		[NoArrayLength ()]
		public static Gdk.Window at_pointer (int win_x, int win_y);
		[NoArrayLength ()]
		public void begin_move_drag (int button, int root_x, int root_y, uint timestamp);
		[NoArrayLength ()]
		public void begin_paint_rect (Gdk.Rectangle rectangle);
		[NoArrayLength ()]
		public void begin_paint_region (Gdk.Region region);
		[NoArrayLength ()]
		public void begin_resize_drag (Gdk.WindowEdge edge, int button, int root_x, int root_y, uint timestamp);
		[NoArrayLength ()]
		public void clear ();
		[NoArrayLength ()]
		public void clear_area (int x, int y, int width, int height);
		[NoArrayLength ()]
		public void clear_area_e (int x, int y, int width, int height);
		[NoArrayLength ()]
		public void configure_finished ();
		[NoArrayLength ()]
		public static void constrain_size (Gdk.Geometry geometry, uint @flags, int width, int height, int new_width, int new_height);
		[NoArrayLength ()]
		public void deiconify ();
		[NoArrayLength ()]
		public void destroy ();
		[NoArrayLength ()]
		public void enable_synchronized_configure ();
		[NoArrayLength ()]
		public void end_paint ();
		[NoArrayLength ()]
		public void focus (uint timestamp);
		[NoArrayLength ()]
		public static Gdk.Window foreign_new (pointer anid);
		[NoArrayLength ()]
		public static Gdk.Window foreign_new_for_display (Gdk.Display display, pointer anid);
		[NoArrayLength ()]
		public void freeze_updates ();
		[NoArrayLength ()]
		public void fullscreen ();
		[NoArrayLength ()]
		public GLib.List get_children ();
		[NoArrayLength ()]
		public bool get_decorations (Gdk.WMDecoration decorations);
		[NoArrayLength ()]
		public Gdk.EventMask get_events ();
		[NoArrayLength ()]
		public void get_frame_extents (Gdk.Rectangle rect);
		[NoArrayLength ()]
		public void get_geometry (int x, int y, int width, int height, int depth);
		[NoArrayLength ()]
		public Gdk.Window get_group ();
		[NoArrayLength ()]
		public void get_internal_paint_info (Gdk.Drawable real_drawable, int x_offset, int y_offset);
		[NoArrayLength ()]
		public int get_origin (int x, int y);
		[NoArrayLength ()]
		public Gdk.Window get_parent ();
		[NoArrayLength ()]
		public Gdk.Window get_pointer (int x, int y, Gdk.ModifierType mask);
		[NoArrayLength ()]
		public void get_position (int x, int y);
		[NoArrayLength ()]
		public void get_root_origin (int x, int y);
		[NoArrayLength ()]
		public Gdk.WindowState get_state ();
		[NoArrayLength ()]
		public Gdk.Window get_toplevel ();
		[NoArrayLength ()]
		public static GLib.List get_toplevels ();
		[NoArrayLength ()]
		public Gdk.WindowTypeHint get_type_hint ();
		[NoArrayLength ()]
		public Gdk.Region get_update_area ();
		[NoArrayLength ()]
		public void get_user_data (pointer data);
		[NoArrayLength ()]
		public Gdk.WindowType get_window_type ();
		[NoArrayLength ()]
		public void hide ();
		[NoArrayLength ()]
		public void iconify ();
		[NoArrayLength ()]
		public void input_shape_combine_mask (Gdk.Bitmap mask, int x, int y);
		[NoArrayLength ()]
		public void input_shape_combine_region (Gdk.Region shape_region, int offset_x, int offset_y);
		[NoArrayLength ()]
		public void invalidate_maybe_recurse (Gdk.Region region, Gdk.invalidate_maybe_recurseChildFunc child_func, pointer user_data);
		[NoArrayLength ()]
		public void invalidate_rect (Gdk.Rectangle rect, bool invalidate_children);
		[NoArrayLength ()]
		public void invalidate_region (Gdk.Region region, bool invalidate_children);
		[NoArrayLength ()]
		public bool is_viewable ();
		[NoArrayLength ()]
		public bool is_visible ();
		[NoArrayLength ()]
		public static Gdk.Window lookup (pointer anid);
		[NoArrayLength ()]
		public static Gdk.Window lookup_for_display (Gdk.Display display, pointer anid);
		[NoArrayLength ()]
		public void lower ();
		[NoArrayLength ()]
		public void maximize ();
		[NoArrayLength ()]
		public void merge_child_input_shapes ();
		[NoArrayLength ()]
		public void merge_child_shapes ();
		[NoArrayLength ()]
		public void move (int x, int y);
		[NoArrayLength ()]
		public void move_region (Gdk.Region region, int dx, int dy);
		[NoArrayLength ()]
		public void move_resize (int x, int y, int width, int height);
		[NoArrayLength ()]
		public construct (Gdk.WindowAttr attributes, int attributes_mask);
		[NoArrayLength ()]
		public GLib.List peek_children ();
		[NoArrayLength ()]
		public static void process_all_updates ();
		[NoArrayLength ()]
		public void process_updates (bool update_children);
		[NoArrayLength ()]
		public void raise ();
		[NoArrayLength ()]
		public void register_dnd ();
		[NoArrayLength ()]
		public void remove_filter (Gdk.FilterFunc function, pointer data);
		[NoArrayLength ()]
		public void reparent (Gdk.Window new_parent, int x, int y);
		[NoArrayLength ()]
		public void resize (int width, int height);
		[NoArrayLength ()]
		public void scroll (int dx, int dy);
		[NoArrayLength ()]
		public void set_accept_focus (bool accept_focus);
		[NoArrayLength ()]
		public void set_back_pixmap (Gdk.Pixmap pixmap, bool parent_relative);
		[NoArrayLength ()]
		public void set_background (Gdk.Color color);
		[NoArrayLength ()]
		public void set_child_input_shapes ();
		[NoArrayLength ()]
		public void set_child_shapes ();
		[NoArrayLength ()]
		public void set_cursor (Gdk.Cursor cursor);
		[NoArrayLength ()]
		public static void set_debug_updates (bool setting);
		[NoArrayLength ()]
		public void set_decorations (Gdk.WMDecoration decorations);
		[NoArrayLength ()]
		public void set_events (Gdk.EventMask event_mask);
		[NoArrayLength ()]
		public void set_focus_on_map (bool focus_on_map);
		[NoArrayLength ()]
		public void set_functions (Gdk.WMFunction functions);
		[NoArrayLength ()]
		public void set_geometry_hints (Gdk.Geometry geometry, Gdk.WindowHints geom_mask);
		[NoArrayLength ()]
		public void set_group (Gdk.Window leader);
		[NoArrayLength ()]
		public void set_icon (Gdk.Window icon_window, Gdk.Pixmap pixmap, Gdk.Bitmap mask);
		[NoArrayLength ()]
		public void set_icon_list (GLib.List pixbufs);
		[NoArrayLength ()]
		public void set_icon_name (string name);
		[NoArrayLength ()]
		public void set_keep_above (bool setting);
		[NoArrayLength ()]
		public void set_keep_below (bool setting);
		[NoArrayLength ()]
		public void set_modal_hint (bool modal);
		[NoArrayLength ()]
		public void set_override_redirect (bool override_redirect);
		[NoArrayLength ()]
		public void set_role (string role);
		[NoArrayLength ()]
		public void set_skip_pager_hint (bool skips_pager);
		[NoArrayLength ()]
		public void set_skip_taskbar_hint (bool skips_taskbar);
		[NoArrayLength ()]
		public bool set_static_gravities (bool use_static);
		[NoArrayLength ()]
		public void set_title (string title);
		[NoArrayLength ()]
		public void set_transient_for (Gdk.Window parent);
		[NoArrayLength ()]
		public void set_type_hint (Gdk.WindowTypeHint hint);
		[NoArrayLength ()]
		public void set_urgency_hint (bool urgent);
		[NoArrayLength ()]
		public void set_user_data (pointer user_data);
		[NoArrayLength ()]
		public void shape_combine_mask (Gdk.Bitmap mask, int x, int y);
		[NoArrayLength ()]
		public void shape_combine_region (Gdk.Region shape_region, int offset_x, int offset_y);
		[NoArrayLength ()]
		public void show ();
		[NoArrayLength ()]
		public void show_unraised ();
		[NoArrayLength ()]
		public void stick ();
		[NoArrayLength ()]
		public void thaw_updates ();
		[NoArrayLength ()]
		public void unfullscreen ();
		[NoArrayLength ()]
		public void unmaximize ();
		[NoArrayLength ()]
		public void unstick ();
		[NoArrayLength ()]
		public void withdraw ();
	}
	public class Bitmap {
		public weak GLib.Object parent_instance;
		[NoArrayLength ()]
		public static Gdk.Bitmap create_from_data (Gdk.Drawable drawable, string data, int width, int height);
	}
	[ReferenceType ()]
	public struct BRESINFO {
		public weak int minor_axis;
		public weak int d;
		public weak int m;
		public weak int m1;
		public weak int incr1;
		public weak int incr2;
	}
	[ReferenceType ()]
	public struct EdgeTable {
		public weak int ymax;
		public weak int ymin;
		public weak Gdk.ScanLineList scanlines;
	}
	[ReferenceType ()]
	public struct EdgeTableEntry {
	}
	public struct Color {
		[NoArrayLength ()]
		[InstanceByReference ()]
		public Gdk.Color copy ();
		[NoArrayLength ()]
		[InstanceByReference ()]
		public bool equal (Gdk.Color colorb);
		[NoArrayLength ()]
		[InstanceByReference ()]
		public void free ();
		[NoArrayLength ()]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		[InstanceByReference ()]
		public uint hash ();
		[NoArrayLength ()]
		public static bool parse (string spec, Gdk.Color color);
	}
	public struct Cursor {
		[NoArrayLength ()]
		[InstanceByReference ()]
		public Gdk.Display get_display ();
		[NoArrayLength ()]
		[InstanceByReference ()]
		public Gdk.Pixbuf get_image ();
		[NoArrayLength ()]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		public construct (Gdk.CursorType cursor_type);
		[NoArrayLength ()]
		public construct for_display (Gdk.Display display, Gdk.CursorType cursor_type);
		[NoArrayLength ()]
		public construct from_name (Gdk.Display display, string name);
		[NoArrayLength ()]
		public construct from_pixbuf (Gdk.Display display, Gdk.Pixbuf pixbuf, int x, int y);
		[NoArrayLength ()]
		public construct from_pixmap (Gdk.Pixmap source, Gdk.Pixmap mask, Gdk.Color fg, Gdk.Color bg, int x, int y);
		[NoArrayLength ()]
		[InstanceByReference ()]
		public Gdk.Cursor @ref ();
		[NoArrayLength ()]
		[InstanceByReference ()]
		public void unref ();
	}
	[ReferenceType ()]
	public struct DeviceAxis {
		public weak Gdk.AxisUse use;
		public weak double min;
		public weak double max;
	}
	[ReferenceType ()]
	public struct DeviceKey {
		public weak uint keyval;
		public weak Gdk.ModifierType modifiers;
	}
	[ReferenceType ()]
	public struct DisplayPointerHooks {
	}
	[ReferenceType ()]
	public struct EventAny {
		public weak Gdk.EventType type;
		public weak Gdk.Window window;
		public weak char send_event;
	}
	[ReferenceType ()]
	public struct EventButton {
		public weak Gdk.EventType type;
		public weak Gdk.Window window;
		public weak char send_event;
		public weak uint time;
		public weak double x;
		public weak double y;
		public weak double axes;
		public weak uint state;
		public weak uint button;
		public weak Gdk.Device device;
		public weak double x_root;
		public weak double y_root;
	}
	[ReferenceType ()]
	public struct EventClient {
		public weak Gdk.EventType type;
		public weak Gdk.Window window;
		public weak char send_event;
		public weak Gdk.Atom message_type;
		public weak ushort data_format;
		public weak char b;
	}
	[ReferenceType ()]
	public struct EventConfigure {
		public weak Gdk.EventType type;
		public weak Gdk.Window window;
		public weak char send_event;
		public weak int x;
		public weak int y;
		public weak int width;
		public weak int height;
	}
	[ReferenceType ()]
	public struct EventCrossing {
		public weak Gdk.EventType type;
		public weak Gdk.Window window;
		public weak char send_event;
		public weak Gdk.Window subwindow;
		public weak uint time;
		public weak double x;
		public weak double y;
		public weak double x_root;
		public weak double y_root;
		public weak Gdk.CrossingMode mode;
		public weak Gdk.NotifyType detail;
		public weak bool focus;
		public weak uint state;
	}
	[ReferenceType ()]
	public struct EventDND {
		public weak Gdk.EventType type;
		public weak Gdk.Window window;
		public weak char send_event;
		public weak Gdk.DragContext context;
		public weak uint time;
		public weak short x_root;
		public weak short y_root;
	}
	[ReferenceType ()]
	public struct EventExpose {
		public weak Gdk.EventType type;
		public weak Gdk.Window window;
		public weak char send_event;
		public weak Gdk.Rectangle area;
		public weak Gdk.Region region;
		public weak int count;
	}
	[ReferenceType ()]
	public struct EventFocus {
		public weak Gdk.EventType type;
		public weak Gdk.Window window;
		public weak char send_event;
		public weak short @in;
	}
	[ReferenceType ()]
	public struct EventGrabBroken {
		public weak Gdk.EventType type;
		public weak Gdk.Window window;
		public weak char send_event;
		public weak bool keyboard;
		public weak bool implicit;
		public weak Gdk.Window grab_window;
	}
	[ReferenceType ()]
	public struct EventKey {
		public weak Gdk.EventType type;
		public weak Gdk.Window window;
		public weak char send_event;
		public weak uint time;
		public weak uint state;
		public weak uint keyval;
		public weak int length;
		public weak string string;
		public weak ushort hardware_keycode;
		public weak uchar group;
		public weak uint is_modifier;
	}
	[ReferenceType ()]
	public struct EventMotion {
		public weak Gdk.EventType type;
		public weak Gdk.Window window;
		public weak char send_event;
		public weak uint time;
		public weak double x;
		public weak double y;
		public weak double axes;
		public weak uint state;
		public weak short is_hint;
		public weak Gdk.Device device;
		public weak double x_root;
		public weak double y_root;
	}
	[ReferenceType ()]
	public struct EventNoExpose {
		public weak Gdk.EventType type;
		public weak Gdk.Window window;
		public weak char send_event;
	}
	[ReferenceType ()]
	public struct EventOwnerChange {
		public weak Gdk.EventType type;
		public weak Gdk.Window window;
		public weak char send_event;
		public weak pointer owner;
		public weak Gdk.OwnerChange reason;
		public weak Gdk.Atom selection;
		public weak uint time;
		public weak uint selection_time;
	}
	[ReferenceType ()]
	public struct EventProperty {
		public weak Gdk.EventType type;
		public weak Gdk.Window window;
		public weak char send_event;
		public weak Gdk.Atom atom;
		public weak uint time;
		public weak uint state;
	}
	[ReferenceType ()]
	public struct EventProximity {
		public weak Gdk.EventType type;
		public weak Gdk.Window window;
		public weak char send_event;
		public weak uint time;
		public weak Gdk.Device device;
	}
	[ReferenceType ()]
	public struct EventScroll {
		public weak Gdk.EventType type;
		public weak Gdk.Window window;
		public weak char send_event;
		public weak uint time;
		public weak double x;
		public weak double y;
		public weak uint state;
		public weak Gdk.ScrollDirection direction;
		public weak Gdk.Device device;
		public weak double x_root;
		public weak double y_root;
	}
	[ReferenceType ()]
	public struct EventSelection {
		public weak Gdk.EventType type;
		public weak Gdk.Window window;
		public weak char send_event;
		public weak Gdk.Atom selection;
		public weak Gdk.Atom target;
		public weak Gdk.Atom property;
		public weak uint time;
		public weak pointer requestor;
	}
	[ReferenceType ()]
	public struct EventSetting {
		public weak Gdk.EventType type;
		public weak Gdk.Window window;
		public weak char send_event;
		public weak Gdk.SettingAction action;
		public weak string name;
	}
	[ReferenceType ()]
	public struct EventVisibility {
		public weak Gdk.EventType type;
		public weak Gdk.Window window;
		public weak char send_event;
		public weak Gdk.VisibilityState state;
	}
	[ReferenceType ()]
	public struct EventWindowState {
		public weak Gdk.EventType type;
		public weak Gdk.Window window;
		public weak char send_event;
		public weak Gdk.WindowState changed_mask;
		public weak Gdk.WindowState new_window_state;
	}
	public struct Font {
	}
	[ReferenceType ()]
	public struct GCValues {
		public weak Gdk.Color foreground;
		public weak Gdk.Color background;
		public weak Gdk.Font font;
		public weak Gdk.Function function;
		public weak Gdk.Fill fill;
		public weak Gdk.Pixmap tile;
		public weak Gdk.Pixmap stipple;
		public weak Gdk.Pixmap clip_mask;
		public weak Gdk.SubwindowMode subwindow_mode;
		public weak int ts_x_origin;
		public weak int ts_y_origin;
		public weak int clip_x_origin;
		public weak int clip_y_origin;
		public weak int graphics_exposures;
		public weak int line_width;
		public weak Gdk.LineStyle line_style;
		public weak Gdk.CapStyle cap_style;
		public weak Gdk.JoinStyle join_style;
	}
	[ReferenceType ()]
	public struct Geometry {
		public weak int min_width;
		public weak int min_height;
		public weak int max_width;
		public weak int max_height;
		public weak int base_width;
		public weak int base_height;
		public weak int width_inc;
		public weak int height_inc;
		public weak double min_aspect;
		public weak double max_aspect;
		public weak Gdk.Gravity win_gravity;
	}
	[ReferenceType ()]
	public struct KeymapKey {
		public weak uint keycode;
		public weak int group;
		public weak int level;
	}
	[ReferenceType ()]
	public struct PangoAttrEmbossed {
		public weak Pango.Attribute attr;
		public weak bool embossed;
		[NoArrayLength ()]
		public construct (bool embossed);
	}
	[ReferenceType ()]
	public struct PangoAttrStipple {
		public weak Pango.Attribute attr;
		public weak Gdk.Bitmap stipple;
		[NoArrayLength ()]
		public construct (Gdk.Bitmap stipple);
	}
	[ReferenceType ()]
	public struct PixbufFormat {
		[NoArrayLength ()]
		public string get_description ();
		[NoArrayLength ()]
		public string get_extensions ();
		[NoArrayLength ()]
		public string get_license ();
		[NoArrayLength ()]
		public string get_mime_types ();
		[NoArrayLength ()]
		public string get_name ();
		[NoArrayLength ()]
		public bool is_disabled ();
		[NoArrayLength ()]
		public bool is_scalable ();
		[NoArrayLength ()]
		public bool is_writable ();
		[NoArrayLength ()]
		public void set_disabled (bool disabled);
	}
	[ReferenceType ()]
	public struct PixbufFrame {
		public weak Gdk.Pixbuf pixbuf;
		public weak int x_offset;
		public weak int y_offset;
		public weak int delay_time;
		public weak int elapsed;
		public weak Gdk.PixbufFrameAction action;
		public weak bool need_recomposite;
		public weak bool bg_transparent;
		public weak Gdk.Pixbuf composited;
		public weak Gdk.Pixbuf revert;
	}
	[ReferenceType ()]
	public struct Pixdata {
		public weak uint magic;
		public weak int length;
		public weak uint pixdata_type;
		public weak uint rowstride;
		public weak uint width;
		public weak uint height;
		public weak uchar pixel_data;
		[NoArrayLength ()]
		public bool deserialize (uint stream_length, uchar stream, GLib.Error error);
		[NoArrayLength ()]
		public pointer from_pixbuf (Gdk.Pixbuf pixbuf, bool use_rle);
		[NoArrayLength ()]
		public uchar serialize (uint stream_length_p);
		[NoArrayLength ()]
		public GLib.String to_csource (string name, Gdk.PixdataDumpType dump_type);
	}
	[ReferenceType ()]
	public struct PixmapObject {
		public weak Gdk.Drawable parent_instance;
		public weak Gdk.Drawable impl;
		public weak int depth;
	}
	[ReferenceType ()]
	public struct Point {
		public weak int x;
		public weak int y;
	}
	[ReferenceType ()]
	public struct PointerHooks {
	}
	public struct Rectangle {
		[NoArrayLength ()]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		[InstanceByReference ()]
		public bool intersect (Gdk.Rectangle src2, Gdk.Rectangle dest);
		[NoArrayLength ()]
		[InstanceByReference ()]
		public void union (Gdk.Rectangle src2, Gdk.Rectangle dest);
	}
	[ReferenceType ()]
	public struct Region {
		public weak long size;
		public weak long numRects;
		public weak Gdk.RegionBox rects;
		public weak Gdk.RegionBox extents;
		[NoArrayLength ()]
		public Gdk.Region copy ();
		[NoArrayLength ()]
		public void destroy ();
		[NoArrayLength ()]
		public bool empty ();
		[NoArrayLength ()]
		public bool equal (Gdk.Region region2);
		[NoArrayLength ()]
		public void get_clipbox (Gdk.Rectangle rectangle);
		[NoArrayLength ()]
		public void get_rectangles (Gdk.Rectangle rectangles, int n_rectangles);
		[NoArrayLength ()]
		public void intersect (Gdk.Region source2);
		[NoArrayLength ()]
		public construct ();
		[NoArrayLength ()]
		public void offset (int dx, int dy);
		[NoArrayLength ()]
		public bool point_in (int x, int y);
		[NoArrayLength ()]
		public static Gdk.Region polygon (Gdk.Point points, int npoints, Gdk.FillRule fill_rule);
		[NoArrayLength ()]
		public Gdk.OverlapType rect_in (Gdk.Rectangle rectangle);
		[NoArrayLength ()]
		public static Gdk.Region rectangle (Gdk.Rectangle rectangle);
		[NoArrayLength ()]
		public void shrink (int dx, int dy);
		[NoArrayLength ()]
		public void spans_intersect_foreach (Gdk.Span spans, int n_spans, bool sorted, Gdk.SpanFunc function, pointer data);
		[NoArrayLength ()]
		public void subtract (Gdk.Region source2);
		[NoArrayLength ()]
		public void union (Gdk.Region source2);
		[NoArrayLength ()]
		public void union_with_rect (Gdk.Rectangle rect);
		[NoArrayLength ()]
		public void xor (Gdk.Region source2);
	}
	[ReferenceType ()]
	public struct RegionBox {
		public weak int x1;
		public weak int y1;
		public weak int x2;
		public weak int y2;
	}
	[ReferenceType ()]
	public struct RgbCmap {
		public weak uint colors;
		public weak int n_colors;
		[NoArrayLength ()]
		public void free ();
		[NoArrayLength ()]
		public construct (uint colors, int n_colors);
	}
	[ReferenceType ()]
	public struct Segment {
		public weak int x1;
		public weak int y1;
		public weak int x2;
		public weak int y2;
	}
	[ReferenceType ()]
	public struct Span {
		public weak int x;
		public weak int y;
		public weak int width;
	}
	[ReferenceType ()]
	public struct TimeCoord {
		public weak uint time;
		public weak double axes;
	}
	[ReferenceType ()]
	public struct Trapezoid {
		public weak double y1;
		public weak double x11;
		public weak double x21;
		public weak double y2;
		public weak double x12;
		public weak double x22;
	}
	[ReferenceType ()]
	public struct WindowAttr {
		public weak string title;
		public weak int event_mask;
		public weak int x;
		public weak int y;
		public weak int width;
		public weak int height;
		public weak pointer wclass;
		public weak Gdk.Visual visual;
		public weak Gdk.Colormap colormap;
		public weak Gdk.WindowType window_type;
		public weak Gdk.Cursor cursor;
		public weak string wmclass_name;
		public weak string wmclass_class;
		public weak bool override_redirect;
	}
	[ReferenceType ()]
	public struct WindowObject {
		public weak Gdk.Drawable parent_instance;
		public weak Gdk.Drawable impl;
		public weak Gdk.WindowObject parent;
		public weak pointer user_data;
		public weak int x;
		public weak int y;
		public weak int extension_events;
		public weak GLib.List filters;
		public weak GLib.List children;
		public weak Gdk.Color bg_color;
		public weak Gdk.Pixmap bg_pixmap;
		public weak GLib.SList paint_stack;
		public weak Gdk.Region update_area;
		public weak uint update_freeze_count;
		public weak uchar window_type;
		public weak uchar depth;
		public weak uchar resize_count;
		public weak Gdk.WindowState state;
		public weak uint guffaw_gravity;
		public weak uint input_only;
		public weak uint modal_hint;
		public weak uint destroyed;
		public weak uint accept_focus;
		public weak uint focus_on_map;
		public weak uint shaped;
		public weak Gdk.EventMask event_mask;
		[NoArrayLength ()]
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
		public static Gdk.Atom intern (string atom_name, bool only_if_exists);
		[NoArrayLength ()]
		public static Gdk.Atom intern_static_string (string atom_name);
		[NoArrayLength ()]
		public string name ();
	}
	[ReferenceType ()]
	public struct Cairo {
		[NoArrayLength ()]
		public static Cairo.Context create (Gdk.Drawable drawable);
		[NoArrayLength ()]
		public static void rectangle (Cairo.Context cr, Gdk.Rectangle rectangle);
		[NoArrayLength ()]
		public static void region (Cairo.Context cr, Gdk.Region region);
		[NoArrayLength ()]
		public static void set_source_color (Cairo.Context cr, Gdk.Color color);
		[NoArrayLength ()]
		public static void set_source_pixbuf (Cairo.Context cr, Gdk.Pixbuf pixbuf, double pixbuf_x, double pixbuf_y);
		[NoArrayLength ()]
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
		public static void abort (Gdk.DragContext context, uint time_);
		[NoArrayLength ()]
		public static Gdk.DragContext begin (Gdk.Window window, GLib.List targets);
		[NoArrayLength ()]
		public static void drop (Gdk.DragContext context, uint time_);
		[NoArrayLength ()]
		public static bool drop_succeeded (Gdk.DragContext context);
		[NoArrayLength ()]
		public static void find_window (Gdk.DragContext context, Gdk.Window drag_window, int x_root, int y_root, Gdk.Window dest_window, Gdk.DragProtocol protocol);
		[NoArrayLength ()]
		public static void find_window_for_screen (Gdk.DragContext context, Gdk.Window drag_window, Gdk.Screen screen, int x_root, int y_root, Gdk.Window dest_window, Gdk.DragProtocol protocol);
		[NoArrayLength ()]
		public static uint get_protocol (uint xid, Gdk.DragProtocol protocol);
		[NoArrayLength ()]
		public static uint get_protocol_for_display (Gdk.Display display, uint xid, Gdk.DragProtocol protocol);
		[NoArrayLength ()]
		public static Gdk.Atom get_selection (Gdk.DragContext context);
		[NoArrayLength ()]
		public static bool motion (Gdk.DragContext context, Gdk.Window dest_window, Gdk.DragProtocol protocol, int x_root, int y_root, Gdk.DragAction suggested_action, Gdk.DragAction possible_actions, uint time_);
		[NoArrayLength ()]
		public static void status (Gdk.DragContext context, Gdk.DragAction action, uint time_);
	}
	[ReferenceType ()]
	public struct Drop {
		[NoArrayLength ()]
		public static void finish (Gdk.DragContext context, bool success, uint time_);
		[NoArrayLength ()]
		public static void reply (Gdk.DragContext context, bool ok, uint time_);
	}
	[ReferenceType ()]
	public struct Error {
		[NoArrayLength ()]
		public static int trap_pop ();
		[NoArrayLength ()]
		public static void trap_push ();
	}
	[ReferenceType ()]
	public struct Event {
		[NoArrayLength ()]
		public Gdk.Event copy ();
		[NoArrayLength ()]
		public void free ();
		[NoArrayLength ()]
		public static Gdk.Event @get ();
		[NoArrayLength ()]
		public bool get_axis (Gdk.AxisUse axis_use, double value);
		[NoArrayLength ()]
		public bool get_coords (double x_win, double y_win);
		[NoArrayLength ()]
		public static Gdk.Event get_graphics_expose (Gdk.Window window);
		[NoArrayLength ()]
		public bool get_root_coords (double x_root, double y_root);
		[NoArrayLength ()]
		public Gdk.Screen get_screen ();
		[NoArrayLength ()]
		public bool get_state (Gdk.ModifierType state);
		[NoArrayLength ()]
		public uint get_time ();
		[NoArrayLength ()]
		public static GLib.Type get_type ();
		[NoArrayLength ()]
		public static void handler_set (Gdk.EventFunc func, pointer data, GLib.DestroyNotify notify);
		[NoArrayLength ()]
		public construct (Gdk.EventType type);
		[NoArrayLength ()]
		public static Gdk.Event peek ();
		[NoArrayLength ()]
		public void put ();
		[NoArrayLength ()]
		public bool send_client_message (pointer winid);
		[NoArrayLength ()]
		public static bool send_client_message_for_display (Gdk.Display display, Gdk.Event event, pointer winid);
		[NoArrayLength ()]
		public void send_clientmessage_toall ();
		[NoArrayLength ()]
		public void set_screen (Gdk.Screen screen);
	}
	[ReferenceType ()]
	public struct Fontset {
	}
	[ReferenceType ()]
	public struct Input {
		[NoArrayLength ()]
		public static void set_extension_events (Gdk.Window window, int mask, Gdk.ExtensionMode mode);
	}
	[ReferenceType ()]
	public struct Keyboard {
		[NoArrayLength ()]
		public static Gdk.GrabStatus grab (Gdk.Window window, bool owner_events, uint time_);
		[NoArrayLength ()]
		public static bool grab_info_libgtk_only (Gdk.Display display, Gdk.Window grab_window, bool owner_events);
		[NoArrayLength ()]
		public static void ungrab (uint time_);
	}
	[ReferenceType ()]
	public struct Keyval {
		[NoArrayLength ()]
		public static void convert_case (uint symbol, uint lower, uint upper);
		[NoArrayLength ()]
		public static uint from_name (string keyval_name);
		[NoArrayLength ()]
		public static bool is_lower (uint keyval);
		[NoArrayLength ()]
		public static bool is_upper (uint keyval);
		[NoArrayLength ()]
		public static string name (uint keyval);
		[NoArrayLength ()]
		public static uint to_lower (uint keyval);
		[NoArrayLength ()]
		public static uint to_unicode (uint keyval);
		[NoArrayLength ()]
		public static uint to_upper (uint keyval);
	}
	[ReferenceType ()]
	public struct Pango {
		[NoArrayLength ()]
		public static Pango.Context context_get ();
		[NoArrayLength ()]
		public static Pango.Context context_get_for_screen (Gdk.Screen screen);
		[NoArrayLength ()]
		public static Gdk.Region layout_get_clip_region (Pango.Layout layout, int x_origin, int y_origin, int index_ranges, int n_ranges);
		[NoArrayLength ()]
		public static Gdk.Region layout_line_get_clip_region (Pango.LayoutLine line, int x_origin, int y_origin, int index_ranges, int n_ranges);
	}
	[ReferenceType ()]
	public struct Pointer {
		[NoArrayLength ()]
		public static Gdk.GrabStatus grab (Gdk.Window window, bool owner_events, Gdk.EventMask event_mask, Gdk.Window confine_to, Gdk.Cursor cursor, uint time_);
		[NoArrayLength ()]
		public static bool grab_info_libgtk_only (Gdk.Display display, Gdk.Window grab_window, bool owner_events);
		[NoArrayLength ()]
		public static bool is_grabbed ();
		[NoArrayLength ()]
		public static void ungrab (uint time_);
	}
	[ReferenceType ()]
	public struct Property {
		[NoArrayLength ()]
		public static void change (Gdk.Window window, Gdk.Atom property, Gdk.Atom type, int format, Gdk.PropMode mode, uchar data, int nelements);
		[NoArrayLength ()]
		public static void delete (Gdk.Window window, Gdk.Atom property);
		[NoArrayLength ()]
		public static bool @get (Gdk.Window window, Gdk.Atom property, Gdk.Atom type, ulong offset, ulong length, int pdelete, Gdk.Atom actual_property_type, int actual_format, int actual_length, uchar data);
	}
	[ReferenceType ()]
	public struct Query {
		[NoArrayLength ()]
		public static void depths (int depths, int count);
		[NoArrayLength ()]
		public static void visual_types (Gdk.VisualType visual_types, int count);
	}
	[ReferenceType ()]
	public struct Rgb {
		[NoArrayLength ()]
		public static bool colormap_ditherable (Gdk.Colormap cmap);
		[NoArrayLength ()]
		public static bool ditherable ();
		[NoArrayLength ()]
		public static void find_color (Gdk.Colormap colormap, Gdk.Color color);
		[NoArrayLength ()]
		public static Gdk.Colormap get_colormap ();
		[NoArrayLength ()]
		public static Gdk.Visual get_visual ();
		[NoArrayLength ()]
		public static void set_install (bool install);
		[NoArrayLength ()]
		public static void set_min_colors (int min_colors);
		[NoArrayLength ()]
		public static void set_verbose (bool verbose);
	}
	[ReferenceType ()]
	public struct Selection {
		[NoArrayLength ()]
		public static void convert (Gdk.Window requestor, Gdk.Atom selection, Gdk.Atom target, uint time_);
		[NoArrayLength ()]
		public static Gdk.Window owner_get (Gdk.Atom selection);
		[NoArrayLength ()]
		public static Gdk.Window owner_get_for_display (Gdk.Display display, Gdk.Atom selection);
		[NoArrayLength ()]
		public static bool owner_set (Gdk.Window owner, Gdk.Atom selection, uint time_, bool send_event);
		[NoArrayLength ()]
		public static bool owner_set_for_display (Gdk.Display display, Gdk.Window owner, Gdk.Atom selection, uint time_, bool send_event);
		[NoArrayLength ()]
		public static bool property_get (Gdk.Window requestor, uchar data, Gdk.Atom prop_type, int prop_format);
		[NoArrayLength ()]
		public static void send_notify (uint requestor, Gdk.Atom selection, Gdk.Atom target, Gdk.Atom property, uint time_);
		[NoArrayLength ()]
		public static void send_notify_for_display (Gdk.Display display, uint requestor, Gdk.Atom selection, Gdk.Atom target, Gdk.Atom property, uint time_);
	}
	[ReferenceType ()]
	public struct Spawn {
		[NoArrayLength ()]
		public static bool command_line_on_screen (Gdk.Screen screen, string command_line, GLib.Error error);
		[NoArrayLength ()]
		public static bool on_screen (Gdk.Screen screen, string working_directory, string argv, string envp, GLib.SpawnFlags @flags, GLib.SpawnChildSetupFunc child_setup, pointer user_data, int child_pid, GLib.Error error);
		[NoArrayLength ()]
		public static bool on_screen_with_pipes (Gdk.Screen screen, string working_directory, string argv, string envp, GLib.SpawnFlags @flags, GLib.SpawnChildSetupFunc child_setup, pointer user_data, int child_pid, int standard_input, int standard_output, int standard_error, GLib.Error error);
	}
	[ReferenceType ()]
	public struct Text {
		[NoArrayLength ()]
		public static int property_to_text_list (Gdk.Atom encoding, int format, uchar text, int length, string list);
		[NoArrayLength ()]
		public static int property_to_text_list_for_display (Gdk.Display display, Gdk.Atom encoding, int format, uchar text, int length, string list);
		[NoArrayLength ()]
		public static int property_to_utf8_list (Gdk.Atom encoding, int format, uchar text, int length, string list);
		[NoArrayLength ()]
		public static int property_to_utf8_list_for_display (Gdk.Display display, Gdk.Atom encoding, int format, uchar text, int length, string list);
	}
	[ReferenceType ()]
	public struct Threads {
		[NoArrayLength ()]
		public static void enter ();
		[NoArrayLength ()]
		public static void init ();
		[NoArrayLength ()]
		public static void leave ();
		[NoArrayLength ()]
		public static void set_lock_functions (GLib.Callback enter_fn, GLib.Callback leave_fn);
	}
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
	public callback void DestroyNotify (pointer data);
	public callback void EventFunc (Gdk.Event event, pointer data);
	public callback Gdk.FilterReturn FilterFunc (pointer xevent, Gdk.Event event, pointer data);
	public callback void InputFunction (pointer data, int source, Gdk.InputCondition condition);
	public callback void PixbufDestroyNotify (uchar pixels, pointer data);
	public callback bool PixbufSaveFunc (string buf, ulong count, GLib.Error error, pointer data);
	public callback void SpanFunc (Gdk.Span span, pointer data);
	public callback bool invalidate_maybe_recurseChildFunc (Gdk.Window arg1, pointer data);
	[NoArrayLength ()]
	public static void add_client_message_filter (Gdk.Atom message_type, Gdk.FilterFunc func, pointer data);
	[NoArrayLength ()]
	public static void add_option_entries_libgtk_only (GLib.OptionGroup group);
	[NoArrayLength ()]
	public static GLib.List devices_list ();
	[NoArrayLength ()]
	public static bool events_pending ();
	[NoArrayLength ()]
	public static void free_compound_text (uchar ctext);
	[NoArrayLength ()]
	public static void free_text_list (string list);
	[NoArrayLength ()]
	public static Gdk.Window get_default_root_window ();
	[NoArrayLength ()]
	public static string get_display ();
	[NoArrayLength ()]
	public static string get_display_arg_name ();
	[NoArrayLength ()]
	public static string get_program_class ();
	[NoArrayLength ()]
	public static bool get_show_events ();
	[NoArrayLength ()]
	public static bool init_check (int argc, string argv);
	[NoArrayLength ()]
	public static GLib.List list_visuals ();
	[NoArrayLength ()]
	public static void notify_startup_complete ();
	[NoArrayLength ()]
	public static void parse_args (int argc, string argv);
	[NoArrayLength ()]
	public static void pre_parse_libgtk_only ();
	[NoArrayLength ()]
	public static void set_double_click_time (uint msec);
	[NoArrayLength ()]
	public static string set_locale ();
	[NoArrayLength ()]
	public static Gdk.PointerHooks set_pointer_hooks (Gdk.PointerHooks new_hooks);
	[NoArrayLength ()]
	public static void set_program_class (string program_class);
	[NoArrayLength ()]
	public static void set_show_events (bool show_events);
	[NoArrayLength ()]
	public static void set_sm_client_id (string sm_client_id);
	[NoArrayLength ()]
	public static bool setting_get (string name, GLib.Value value);
	[NoArrayLength ()]
	public static int string_to_compound_text (string str, Gdk.Atom encoding, int format, uchar ctext, int length);
	[NoArrayLength ()]
	public static int string_to_compound_text_for_display (Gdk.Display display, string str, Gdk.Atom encoding, int format, uchar ctext, int length);
	[NoArrayLength ()]
	public static uint unicode_to_keyval (uint wc);
}
