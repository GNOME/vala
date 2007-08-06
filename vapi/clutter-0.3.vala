[CCode (cprefix = "Clutter", lower_case_cprefix = "clutter_")]
namespace Clutter {
	[CCode (cprefix = "CLUTTER_ACTOR_", cheader_filename = "clutter/clutter.h")]
	public enum ActorFlags {
		MAPPED,
		REALIZED,
	}
	[CCode (cprefix = "CLUTTER_DEBUG_", cheader_filename = "clutter/clutter.h")]
	public enum DebugFlag {
		MISC,
		ACTOR,
		TEXTURE,
		EVENT,
		PAINT,
		GL,
		ALPHA,
		BEHAVIOUR,
		PANGO,
		BACKEND,
		SCHEDULER,
	}
	[CCode (cprefix = "CLUTTER_", cheader_filename = "clutter/clutter.h")]
	public enum EventType {
		NOTHING,
		KEY_PRESS,
		KEY_RELEASE,
		MOTION,
		BUTTON_PRESS,
		2BUTTON_PRESS,
		3BUTTON_PRESS,
		BUTTON_RELEASE,
		SCROLL,
		STAGE_STATE,
		DESTROY_NOTIFY,
		CLIENT_MESSAGE,
		DELETE,
	}
	[CCode (cprefix = "CLUTTER_FEATURE_", cheader_filename = "clutter/clutter.h")]
	public enum FeatureFlags {
		TEXTURE_RECTANGLE,
		SYNC_TO_VBLANK,
		TEXTURE_YUV,
		TEXTURE_READ_PIXELS,
		STAGE_STATIC,
		STAGE_USER_RESIZE,
		STAGE_CURSOR,
	}
	[CCode (cprefix = "CLUTTER_GRAVITY_", cheader_filename = "clutter/clutter.h")]
	public enum Gravity {
		NONE,
		NORTH,
		NORTH_EAST,
		EAST,
		SOUTH_EAST,
		SOUTH,
		SOUTH_WEST,
		WEST,
		NORTH_WEST,
		CENTER,
	}
	[CCode (cprefix = "CLUTTER_INIT_", cheader_filename = "clutter/clutter.h")]
	public enum InitError {
		SUCCESS,
		ERROR_UNKOWN,
		ERROR_THREADS,
		ERROR_BACKEND,
		ERROR_INTERNAL,
	}
	[CCode (cprefix = "CLUTTER_LAYOUT_", cheader_filename = "clutter/clutter.h")]
	public enum LayoutFlags {
		NONE,
		WIDTH_FOR_HEIGHT,
		HEIGHT_FOR_WIDTH,
		NATURAL,
		TUNABLE,
	}
	[CCode (cprefix = "CLUTTER_", cheader_filename = "clutter/clutter.h")]
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
	}
	[CCode (cprefix = "CLUTTER_PACK_", cheader_filename = "clutter/clutter.h")]
	public enum PackType {
		START,
		END,
	}
	[CCode (cprefix = "CLUTTER_", cheader_filename = "clutter/clutter.h")]
	public enum RotateAxis {
		X_AXIS,
		Y_AXIS,
		Z_AXIS,
	}
	[CCode (cprefix = "CLUTTER_ROTATE_", cheader_filename = "clutter/clutter.h")]
	public enum RotateDirection {
		CW,
		CCW,
	}
	[CCode (cprefix = "CLUTTER_SCROLL_", cheader_filename = "clutter/clutter.h")]
	public enum ScrollDirection {
		UP,
		DOWN,
		LEFT,
		RIGHT,
	}
	[CCode (cprefix = "CLUTTER_STAGE_STATE_", cheader_filename = "clutter/clutter.h")]
	public enum StageState {
		FULLSCREEN,
		MAXIMIZED,
		MINIMIZED,
		OFFSCREEN,
	}
	[CCode (cprefix = "CLUTTER_TEXTURE_ERROR_", cheader_filename = "clutter/clutter.h")]
	public enum TextureError {
		OUT_OF_MEMORY,
		NO_YUV,
	}
	[CCode (cprefix = "CLUTTER_TEXTURE_", cheader_filename = "clutter/clutter.h")]
	public enum TextureFlags {
		RGB_FLAG_BGR,
		RGB_FLAG_PREMULT,
		YUV_FLAG_YUV2,
	}
	[CCode (cheader_filename = "clutter/clutter.h")]
	public class Actor : GLib.InitiallyUnowned {
		public uint flags;
		public void apply_transform_to_point (Clutter.Vertex point, Clutter.Vertex vertex);
		public void get_abs_position (int x, int y);
		public void get_abs_size (uint width, uint height);
		public void get_coords (int x_1, int y_1, int x_2, int y_2);
		public virtual int get_depth ();
		public void get_geometry (Clutter.Geometry geometry);
		public uint get_height ();
		public uint get_id ();
		public weak string get_name ();
		public uchar get_opacity ();
		public weak Clutter.Actor get_parent ();
		public double get_rxang ();
		public int32 get_rxangx ();
		public double get_ryang ();
		public int32 get_ryangx ();
		public double get_rzang ();
		public int32 get_rzangx ();
		public void get_scale (double scale_x, double scale_y);
		public void get_scalex (int32 scale_x, int32 scale_y);
		public void get_size (uint width, uint height);
		public static GLib.Type get_type ();
		[NoArrayLength]
		public void get_vertices (Clutter.Vertex[] verts);
		public uint get_width ();
		public int get_x ();
		public int get_y ();
		[CCode (cname = "clutter_actor_has_clip")]
		public bool get_has_clip ();
		public virtual void hide_all ();
		public void lower (Clutter.Actor above);
		public void lower_bottom ();
		public void move_by (int dx, int dy);
		public virtual void paint ();
		public virtual void pick (out Clutter.Color color);
		public virtual void query_coords (Clutter.ActorBox box);
		public void queue_redraw ();
		public void raise (Clutter.Actor below);
		public void raise_top ();
		public virtual void realize ();
		public void remove_clip ();
		public void reparent (Clutter.Actor new_parent);
		public virtual void request_coords (Clutter.ActorBox box);
		public void rotate_x (float angle, int y, int z);
		public void rotate_xx (int32 angle, int y, int z);
		public void rotate_y (float angle, int x, int z);
		public void rotate_yx (int32 angle, int x, int z);
		public void rotate_z (float angle, int x, int y);
		public void rotate_zx (int32 angle, int x, int y);
		public void set_clip (int xoff, int yoff, int width, int height);
		public virtual void set_depth (int depth);
		public void set_geometry (Clutter.Geometry geometry);
		public void set_height (uint height);
		public void set_name (string name);
		public void set_opacity (uchar opacity);
		public void set_parent (Clutter.Actor parent);
		public void set_position (int x, int y);
		public void set_scale (double scale_x, double scale_y);
		public void set_scale_with_gravity (float scale_x, float scale_y, Clutter.Gravity gravity);
		public void set_scale_with_gravityx (int32 scale_x, int32 scale_y, Clutter.Gravity gravity);
		public void set_scalex (int32 scale_x, int32 scale_y);
		public void set_size (int width, int height);
		public void set_width (uint width);
		public virtual void show_all ();
		public void unparent ();
		public virtual void unrealize ();
		[NoAccessorMethod]
		public weak int x { get; set; }
		[NoAccessorMethod]
		public weak int y { get; set; }
		public weak int width { get; set; }
		public weak int height { get; set; }
		public weak uchar opacity { get; set construct; }
		[NoAccessorMethod]
		public weak bool visible { get; set; }
		[NoAccessorMethod]
		public weak bool has_clip { get; }
		[NoAccessorMethod]
		public weak Clutter.Geometry clip { get; set; }
		public weak string name { get; set; }
		[HasEmitter]
		public signal void destroy ();
		[HasEmitter]
		public signal void show ();
		[HasEmitter]
		public signal void hide ();
		public signal void parent_set (Clutter.Actor old_parent);
	}
	[CCode (cheader_filename = "clutter/clutter.h")]
	public class Alpha : GLib.InitiallyUnowned {
		public uint get_alpha ();
		public weak Clutter.Timeline get_timeline ();
		public static GLib.Type get_type ();
		public Alpha ();
		public Alpha.full (Clutter.Timeline timeline, Clutter.AlphaFunc func, pointer data, GLib.DestroyNotify destroy);
		public void set_func (Clutter.AlphaFunc func, pointer data, GLib.DestroyNotify destroy);
		public void set_timeline (Clutter.Timeline timeline);
		public weak Clutter.Timeline timeline { get; set; }
		public weak uint alpha { get; }
	}
	[CCode (cheader_filename = "clutter/clutter.h")]
	public class Backend : GLib.Object {
		public uint get_double_click_distance ();
		public uint get_double_click_time ();
		public double get_resolution ();
		public static GLib.Type get_type ();
		public void set_double_click_distance (uint distance);
		public void set_double_click_time (uint msec);
		public void set_resolution (double dpi);
	}
	[CCode (cheader_filename = "clutter/clutter.h")]
	public class Behaviour : GLib.Object {
		public void actors_foreach (Clutter.BehaviourForeachFunc func, pointer data);
		public weak GLib.SList get_actors ();
		public weak Clutter.Alpha get_alpha ();
		public int get_n_actors ();
		public weak Clutter.Actor get_nth_actor (int index_);
		public static GLib.Type get_type ();
		public bool is_applied (Clutter.Actor actor);
		public void remove_all ();
		public void set_alpha (Clutter.Alpha alpha);
		public weak Clutter.Alpha alpha { get; set; }
		public signal void applied (Clutter.Actor actor);
		public signal void removed (Clutter.Actor actor);
	}
	[CCode (cheader_filename = "clutter/clutter.h")]
	public class BehaviourBspline : Clutter.Behaviour {
		public void adjust (uint offset, Clutter.Knot knot);
		public void append (...);
		public void append_knot (Clutter.Knot knot);
		public void clear ();
		public void get_origin (Clutter.Knot knot);
		public static GLib.Type get_type ();
		public void join (Clutter.BehaviourBspline bs2);
		[NoArrayLength]
		public BehaviourBspline (Clutter.Alpha alpha, Clutter.Knot[] knots, uint n_knots);
		public void set_origin (Clutter.Knot knot);
		public weak Clutter.Behaviour split (uint offset);
		public void truncate (uint offset);
		public signal void knot_reached (Clutter.Knot knot);
	}
	[CCode (cheader_filename = "clutter/clutter.h")]
	public class BehaviourDepth : Clutter.Behaviour {
		public static GLib.Type get_type ();
		public BehaviourDepth (Clutter.Alpha alpha, int min_depth, int max_depth);
		[NoAccessorMethod]
		public weak int start_depth { get; set; }
		[NoAccessorMethod]
		public weak int end_depth { get; set; }
	}
	[CCode (cheader_filename = "clutter/clutter.h")]
	public class BehaviourEllipse : Clutter.Behaviour {
		public double get_angle_begin ();
		public int32 get_angle_beginx ();
		public double get_angle_end ();
		public int32 get_angle_endx ();
		public double get_angle_tilt (Clutter.RotateAxis axis);
		public int32 get_angle_tiltx (Clutter.RotateAxis axis);
		public void get_center (int x, int y);
		public Clutter.RotateDirection get_direction ();
		public int get_height ();
		public void get_tilt (double angle_tilt_x, double angle_tilt_y, double angle_tilt_z);
		public void get_tiltx (int32 angle_tilt_x, int32 angle_tilt_y, int32 angle_tilt_z);
		public static GLib.Type get_type ();
		public int get_width ();
		public BehaviourEllipse (Clutter.Alpha alpha, int x, int y, int width, int height, Clutter.RotateDirection direction, double begin, double end);
		[CCode (cname = "clutter_behaviour_ellipse_newx")]
		public BehaviourEllipse.newx (Clutter.Alpha alpha, int x, int y, int width, int height, Clutter.RotateDirection direction, int32 begin, int32 end);
		public void set_angle_begin (double angle_begin);
		public void set_angle_beginx (int32 angle_begin);
		public void set_angle_end (double angle_end);
		public void set_angle_endx (int32 angle_end);
		public void set_angle_tilt (Clutter.RotateAxis axis, double angle_tilt);
		public void set_angle_tiltx (Clutter.RotateAxis axis, int32 angle_tilt);
		public void set_center (int x, int y);
		public void set_direction (Clutter.RotateDirection direction);
		public void set_height (int height);
		public void set_tilt (double angle_tilt_x, double angle_tilt_y, double angle_tilt_z);
		public void set_tiltx (int32 angle_tilt_x, int32 angle_tilt_y, int32 angle_tilt_z);
		public void set_width (int width);
		public weak double angle_begin { get; set; }
		public weak double angle_end { get; set; }
		[NoAccessorMethod]
		public weak double angle_tilt_x { get; set; }
		[NoAccessorMethod]
		public weak double angle_tilt_y { get; set; }
		[NoAccessorMethod]
		public weak double angle_tilt_z { get; set; }
		public weak int width { get; set; }
		public weak int height { get; set; }
		public weak Clutter.Knot center { get; set; }
		public weak Clutter.RotateDirection direction { get; set; }
	}
	[CCode (cheader_filename = "clutter/clutter.h")]
	public class BehaviourOpacity : Clutter.Behaviour {
		public static GLib.Type get_type ();
		public BehaviourOpacity (Clutter.Alpha alpha, uchar opacity_start, uchar opacity_end);
		[NoAccessorMethod]
		public weak uint opacity_start { get; set construct; }
		[NoAccessorMethod]
		public weak uint opacity_end { get; set construct; }
	}
	[CCode (cheader_filename = "clutter/clutter.h")]
	public class BehaviourPath : Clutter.Behaviour {
		public void append_knot (Clutter.Knot knot);
		public void append_knots (...);
		public void clear ();
		public weak GLib.SList get_knots ();
		public static GLib.Type get_type ();
		public void insert_knot (uint offset, Clutter.Knot knot);
		[NoArrayLength]
		public BehaviourPath (Clutter.Alpha alpha, Clutter.Knot[] knots, uint n_knots);
		public void remove_knot (uint offset);
		[NoAccessorMethod]
		public weak Clutter.Knot knot { set; }
		public signal void knot_reached (Clutter.Knot knot);
	}
	[CCode (cheader_filename = "clutter/clutter.h")]
	public class BehaviourRotate : Clutter.Behaviour {
		public Clutter.RotateAxis get_axis ();
		public void get_bounds (double angle_begin, double angle_end);
		public void get_boundsx (int32 angle_begin, int32 angle_end);
		public void get_center (int x, int y, int z);
		public Clutter.RotateDirection get_direction ();
		public static GLib.Type get_type ();
		public BehaviourRotate (Clutter.Alpha alpha, Clutter.RotateAxis axis, Clutter.RotateDirection direction, double angle_begin, double angle_end);
		[CCode (cname = "clutter_behaviour_rotate_newx")]
		public BehaviourRotate.newx (Clutter.Alpha alpha, Clutter.RotateAxis axis, Clutter.RotateDirection direction, int32 angle_begin, int32 angle_end);
		public void set_axis (Clutter.RotateAxis axis);
		public void set_bounds (double angle_begin, double angle_end);
		public void set_boundsx (int32 angle_begin, int32 angle_end);
		public void set_center (int x, int y, int z);
		public void set_direction (Clutter.RotateDirection direction);
		[NoAccessorMethod]
		public weak double angle_begin { get; set; }
		[NoAccessorMethod]
		public weak double angle_end { get; set; }
		public weak Clutter.RotateAxis axis { get; set; }
		public weak Clutter.RotateDirection direction { get; set; }
		[NoAccessorMethod]
		public weak int center_x { get; set; }
		[NoAccessorMethod]
		public weak int center_y { get; set; }
		[NoAccessorMethod]
		public weak int center_z { get; set; }
	}
	[CCode (cheader_filename = "clutter/clutter.h")]
	public class BehaviourScale : Clutter.Behaviour {
		public void get_bounds (double scale_begin, double scale_end);
		public void get_boundsx (int32 scale_begin, int32 scale_end);
		public Clutter.Gravity get_gravity ();
		public static GLib.Type get_type ();
		public BehaviourScale (Clutter.Alpha alpha, double scale_begin, double scale_end, Clutter.Gravity gravity);
		[CCode (cname = "clutter_behaviour_scale_newx")]
		public BehaviourScale.newx (Clutter.Alpha alpha, int32 scale_begin, int32 scale_end, Clutter.Gravity gravity);
		[NoAccessorMethod]
		public weak double scale_begin { get; set; }
		[NoAccessorMethod]
		public weak double scale_end { get; set; }
		[NoAccessorMethod]
		public weak Clutter.Gravity scale_gravity { get; set; }
	}
	[CCode (cheader_filename = "clutter/clutter.h")]
	public class Box : Clutter.Actor {
		public uint get_spacing ();
		public static GLib.Type get_type ();
		public void pack_end (Clutter.Actor actor);
		public void pack_start (Clutter.Actor actor);
		public bool query_child (Clutter.Actor actor, Clutter.BoxChild child);
		public bool query_nth_child (int index_, Clutter.BoxChild child);
		public void set_spacing (uint spacing);
		public weak uint spacing { get; set; }
	}
	[CCode (cheader_filename = "clutter/clutter.h")]
	public class CloneTexture : Clutter.Actor {
		public weak Clutter.Texture get_parent_texture ();
		public static GLib.Type get_type ();
		public CloneTexture (Clutter.Texture texture);
		public void set_parent_texture (Clutter.Texture texture);
		public weak Clutter.Texture parent_texture { get; set construct; }
	}
	[CCode (cheader_filename = "clutter/clutter.h")]
	public class EffectTemplate : GLib.Object {
		public static GLib.Type get_type ();
		public EffectTemplate (Clutter.Timeline timeline, Clutter.AlphaFunc alpha_func);
		public EffectTemplate.full (Clutter.Timeline timeline, Clutter.AlphaFunc alpha_func, pointer user_data, GLib.DestroyNotify notify);
		[NoAccessorMethod]
		public weak pointer alpha_func { get; construct; }
		[NoAccessorMethod]
		public weak Clutter.Timeline timeline { get; construct; }
	}
	[CCode (cheader_filename = "clutter/clutter.h")]
	public class Entry : Clutter.Actor {
		public void delete_chars (uint len);
		public void delete_text (long start_pos, long end_pos);
		public Pango.Alignment get_alignment ();
		public void get_color (out Clutter.Color color);
		public weak string get_font_name ();
		public unichar get_invisible_char ();
		public weak Pango.Layout get_layout ();
		public int get_max_length ();
		public int get_position ();
		public weak string get_text ();
		public static GLib.Type get_type ();
		public bool get_visibility ();
		public bool get_visible_cursor ();
		public void handle_key_event (Clutter.KeyEvent kev);
		public void insert_text (string text, long position);
		public void insert_unichar (unichar wc);
		public Entry ();
		public Entry.full (string font_name, string text, out Clutter.Color color);
		public Entry.with_text (string font_name, string text);
		public void set_alignment (Pango.Alignment alignment);
		public void set_color (out Clutter.Color color);
		public void set_font_name (string font_name);
		public void set_invisible_char (unichar wc);
		public void set_max_length (int max);
		public void set_position (int position);
		public void set_text (string text);
		public void set_visibility (bool visible);
		public void set_visible_cursor (bool visible);
		public weak string font_name { get; set construct; }
		public weak string text { get; set construct; }
		public weak Clutter.Color color { get; set; }
		public weak Pango.Alignment alignment { get; set; }
		public weak int position { get; set; }
		[NoAccessorMethod]
		public weak bool cursor_visible { get; set; }
		[NoAccessorMethod]
		public weak bool text_visible { get; set; }
		public weak int max_length { get; set; }
		[NoAccessorMethod]
		public weak uint entry_padding { get; set; }
		public signal void text_changed ();
		public signal void cursor_event (Clutter.Geometry geometry);
		public signal void activate ();
	}
	[CCode (cheader_filename = "clutter/clutter.h")]
	public class Group : Clutter.Actor, Clutter.Container {
		public weak Clutter.Actor find_child_by_id (uint id);
		public int get_n_children ();
		public weak Clutter.Actor get_nth_child (int index_);
		public static GLib.Type get_type ();
		public void lower (Clutter.Actor actor, Clutter.Actor sibling);
		public Group ();
		public void raise (Clutter.Actor actor, Clutter.Actor sibling);
		public void remove_all ();
		public void sort_depth_order ();
		public signal void add (Clutter.Actor child);
		public signal void remove (Clutter.Actor child);
	}
	[CCode (cheader_filename = "clutter/clutter.h")]
	public class HBox : Clutter.Box, Clutter.Layout {
		public static GLib.Type get_type ();
		public HBox ();
	}
	[CCode (cheader_filename = "clutter/clutter.h")]
	public class Label : Clutter.Actor, Clutter.Layout {
		public Pango.Alignment get_alignment ();
		public weak Pango.AttrList get_attributes ();
		public void get_color (out Clutter.Color color);
		public Pango.EllipsizeMode get_ellipsize ();
		public weak string get_font_name ();
		public weak Pango.Layout get_layout ();
		public bool get_line_wrap ();
		public Pango.WrapMode get_line_wrap_mode ();
		public weak string get_text ();
		public static GLib.Type get_type ();
		public bool get_use_markup ();
		public Label ();
		public Label.full (string font_name, string text, out Clutter.Color color);
		public Label.with_text (string font_name, string text);
		public void set_alignment (Pango.Alignment alignment);
		public void set_attributes (Pango.AttrList attrs);
		public void set_color (out Clutter.Color color);
		public void set_ellipsize (Pango.EllipsizeMode mode);
		public void set_font_name (string font_name);
		public void set_line_wrap (bool wrap);
		public void set_line_wrap_mode (Pango.WrapMode wrap_mode);
		public void set_text (string text);
		public void set_use_markup (bool setting);
		public weak string font_name { get; set construct; }
		public weak string text { get; set construct; }
		public weak Clutter.Color color { get; set; }
		public weak Pango.AttrList attributes { get; set; }
		public weak bool use_markup { get; set; }
		[NoAccessorMethod]
		public weak bool wrap { get; set; }
		[NoAccessorMethod]
		public weak Pango.WrapMode wrap_mode { get; set; }
		public weak Pango.EllipsizeMode ellipsize { get; set; }
		public weak Pango.Alignment alignment { get; set; }
	}
	[CCode (cheader_filename = "clutter/clutter.h")]
	public class Rectangle : Clutter.Actor {
		public void get_border_color (out Clutter.Color color);
		public uint get_border_width ();
		public void get_color (out Clutter.Color color);
		public static GLib.Type get_type ();
		public Rectangle ();
		public Rectangle.with_color (out Clutter.Color color);
		public void set_border_color (out Clutter.Color color);
		public void set_border_width (uint width);
		public void set_color (out Clutter.Color color);
		public weak Clutter.Color color { get; set; }
		public weak Clutter.Color border_color { get; set; }
		public weak uint border_width { get; set; }
		[NoAccessorMethod]
		public weak bool has_border { get; set; }
	}
	[CCode (cheader_filename = "clutter/clutter.h")]
	public class Stage : Clutter.Group {
		[CCode (cname = "clutter_stage_fullscreen")]
		public void get_fullscreen ();
		public weak Clutter.Actor get_actor_at_pos (int x, int y);
		public void get_color (out Clutter.Color color);
		public static weak Clutter.Actor get_default ();
		public void get_perspective (float fovy, float aspect, float z_near, float z_far);
		public void get_perspectivex (Clutter.Perspective perspective);
		public weak string get_title ();
		public static GLib.Type get_type ();
		public bool get_user_resizable ();
		public void hide_cursor ();
		public void set_color (out Clutter.Color color);
		public void set_perspective (float fovy, float aspect, float z_near, float z_far);
		public void set_perspectivex (Clutter.Perspective perspective);
		public virtual void set_title (string title);
		public void set_user_resizable (bool resizable);
		public void show_cursor ();
		public weak Gdk.Pixbuf snapshot (int x, int y, int width, int height);
		public void unfullscreen ();
		[NoAccessorMethod]
		public weak bool fullscreen { get; set construct; }
		[NoAccessorMethod]
		public weak bool offscreen { get; set construct; }
		[NoAccessorMethod]
		public weak bool cursor_visible { get; set construct; }
		public weak bool user_resizable { get; set construct; }
		public weak Clutter.Color color { get; set; }
		public weak string title { get; set; }
		[HasEmitter]
		public signal void event (Clutter.Event event);
		public signal void event_after (Clutter.Event event);
		public signal void button_press_event (Clutter.ButtonEvent event);
		public signal void button_release_event (Clutter.ButtonEvent event);
		public signal void scroll_event (Clutter.ScrollEvent event);
		public signal void key_press_event (Clutter.KeyEvent event);
		public signal void key_release_event (Clutter.KeyEvent event);
		public signal void motion_event (Clutter.MotionEvent event);
	}
	[CCode (cheader_filename = "clutter/clutter.h")]
	public class Texture : Clutter.Actor {
		public void bind_tile (int index_);
		public static GLib.Quark error_quark ();
		public void get_base_size (int width, int height);
		public void get_n_tiles (int n_x_tiles, int n_y_tiles);
		public weak Gdk.Pixbuf get_pixbuf ();
		public static GLib.Type get_type ();
		public void get_x_tile_detail (int x_index, int pos, int size, int waste);
		public void get_y_tile_detail (int y_index, int pos, int size, int waste);
		public bool has_generated_tiles ();
		public bool is_tiled ();
		public Texture ();
		public Texture.from_pixbuf (Gdk.Pixbuf pixbuf);
		[NoArrayLength]
		public bool set_from_rgb_data (uchar[] data, bool has_alpha, int width, int height, int rowstride, int bpp, Clutter.TextureFlags flags, GLib.Error error);
		[NoArrayLength]
		public bool set_from_yuv_data (uchar[] data, int width, int height, Clutter.TextureFlags flags, GLib.Error error);
		public bool set_pixbuf (Gdk.Pixbuf pixbuf, GLib.Error error);
		public weak Gdk.Pixbuf pixbuf { get; set; }
		[NoAccessorMethod]
		public weak bool tiled { get; construct; }
		[NoAccessorMethod]
		public weak bool sync_size { get; set construct; }
		[NoAccessorMethod]
		public weak bool repeat_x { get; set construct; }
		[NoAccessorMethod]
		public weak bool repeat_y { get; set construct; }
		[NoAccessorMethod]
		public weak int filter_quality { get; set construct; }
		[NoAccessorMethod]
		public weak int tile_waste { get; construct; }
		[NoAccessorMethod]
		public weak int pixel_type { get; }
		[NoAccessorMethod]
		public weak int pixel_format { get; }
		public signal void size_change (int width, int height);
		public signal void pixbuf_change ();
	}
	[CCode (cheader_filename = "clutter/clutter.h")]
	public class Timeline : GLib.Object {
		public void advance (uint frame_num);
		public weak Clutter.Timeline clone ();
		public int get_current_frame ();
		public uint get_delay ();
		public bool get_loop ();
		public uint get_n_frames ();
		public uint get_speed ();
		public static GLib.Type get_type ();
		public bool is_playing ();
		public Timeline (uint n_frames, uint fps);
		public void pause ();
		public void rewind ();
		public void set_delay (uint msecs);
		public void set_loop (bool loop);
		public void set_n_frames (uint n_frames);
		public void set_speed (uint fps);
		public void skip (uint n_frames);
		public void start ();
		public void stop ();
		[NoAccessorMethod]
		public weak uint fps { get; set construct; }
		[NoAccessorMethod]
		public weak uint num_frames { get; set construct; }
		public weak bool loop { get; set construct; }
		public weak uint delay { get; set construct; }
		public signal void new_frame (int frame_num);
		public signal void completed ();
		public signal void started ();
		public signal void paused ();
	}
	[CCode (cheader_filename = "clutter/clutter.h")]
	public class VBox : Clutter.Box, Clutter.Layout {
		public static GLib.Type get_type ();
		public VBox ();
	}
	[CCode (cheader_filename = "clutter/clutter.h")]
	public interface Container {
		public abstract void add (...);
		public void add_actor (Clutter.Actor actor);
		public void add_valist (Clutter.Actor first_actor, pointer var_args);
		public abstract void @foreach (Clutter.Callback callback, pointer user_data);
		public weak GLib.List get_children ();
		public static GLib.Type get_type ();
		public abstract void remove (...);
		public void remove_actor (Clutter.Actor actor);
		public void remove_valist (Clutter.Actor first_actor, pointer var_args);
		public signal void actor_added (Clutter.Actor actor);
		public signal void actor_removed (Clutter.Actor actor);
	}
	[CCode (cheader_filename = "clutter/clutter.h")]
	public interface Layout {
		public abstract Clutter.LayoutFlags get_layout_flags ();
		public static GLib.Type get_type ();
		public abstract void height_for_width (int width, int height);
		public abstract void natural_request (int width, int height);
		public abstract void tune_request (int given_width, int given_height, int width, int height);
		public abstract void width_for_height (int width, int height);
	}
	[CCode (cheader_filename = "clutter/clutter.h")]
	public interface Media {
		public abstract int get_buffer_percent ();
		public bool get_can_seek ();
		public abstract int get_duration ();
		public abstract bool get_playing ();
		public abstract int get_position ();
		public static GLib.Type get_type ();
		public weak string get_uri ();
		public abstract double get_volume ();
		public void set_filename (string filename);
		public abstract void set_playing (bool playing);
		public abstract void set_position (int position);
		public abstract void set_uri (string uri);
		public abstract void set_volume (double volume);
		public signal void eos ();
		public signal void error (GLib.Error error);
	}
	[ReferenceType]
	[CCode (cheader_filename = "clutter/clutter.h")]
	public struct ActorBox {
		public int32 x1;
		public int32 y1;
		public int32 x2;
		public int32 y2;
		public static GLib.Type get_type ();
	}
	[ReferenceType]
	[CCode (cheader_filename = "clutter/clutter.h")]
	public struct AnyEvent {
		public Clutter.EventType type;
	}
	[ReferenceType]
	[CCode (cheader_filename = "clutter/clutter.h")]
	public struct BoxChild {
		public weak Clutter.Actor actor;
		public Clutter.PackType pack_type;
	}
	[ReferenceType]
	[CCode (cheader_filename = "clutter/clutter.h")]
	public struct ButtonEvent {
		public Clutter.EventType type;
		public uint time;
		public int x;
		public int y;
		public Clutter.ModifierType modifier_state;
		public uint button;
		public double axes;
		public weak Clutter.InputDevice device;
		[CCode (cname = "clutter_button_event_button")]
		public uint get_button ();
	}
	[CCode (cheader_filename = "clutter/clutter.h")]
	public struct Color {
		public uchar red;
		public uchar green;
		public uchar blue;
		public uchar alpha;
		[InstanceByReference]
		public void add (out Clutter.Color src2, out Clutter.Color dest);
		[InstanceByReference]
		public Clutter.Color copy ();
		[InstanceByReference]
		public void darken (out Clutter.Color dest);
		[InstanceByReference]
		public bool equal (out Clutter.Color b);
		[InstanceByReference]
		public void free ();
		[InstanceByReference]
		public void from_hls (uchar hue, uchar luminance, uchar saturation);
		[InstanceByReference]
		public void from_hlsx (int32 hue, int32 luminance, int32 saturation);
		[InstanceByReference]
		public void from_pixel (uint pixel);
		public static GLib.Type get_type ();
		[InstanceByReference]
		public void lighten (out Clutter.Color dest);
		public static bool parse (string color, out Clutter.Color dest);
		[InstanceByReference]
		public void shade (out Clutter.Color dest, double shade);
		[InstanceByReference]
		public void shadex (out Clutter.Color dest, int32 shade);
		[InstanceByReference]
		public void subtract (out Clutter.Color src2, out Clutter.Color dest);
		[InstanceByReference]
		public void to_hls (uchar hue, uchar luminance, uchar saturation);
		[InstanceByReference]
		public void to_hlsx (int32 hue, int32 luminance, int32 saturation);
		[InstanceByReference]
		public uint to_pixel ();
		[InstanceByReference]
		public weak string to_string ();
	}
	[ReferenceType]
	[CCode (cheader_filename = "clutter/clutter.h")]
	public struct Geometry {
		public int x;
		public int y;
		public uint width;
		public uint height;
		public static GLib.Type get_type ();
	}
	[ReferenceType]
	[CCode (cheader_filename = "clutter/clutter.h")]
	public struct InputDevice {
	}
	[ReferenceType]
	[CCode (cheader_filename = "clutter/clutter.h")]
	public struct KeyEvent {
		public Clutter.EventType type;
		public uint time;
		public Clutter.ModifierType modifier_state;
		public uint keyval;
		public ushort hardware_keycode;
		public ushort code ();
		public uint symbol ();
		public uint unicode ();
	}
	[ReferenceType]
	[CCode (cheader_filename = "clutter/clutter.h")]
	public struct Knot {
		public int x;
		public int y;
		public weak Clutter.Knot copy ();
		public bool equal (Clutter.Knot knot_b);
		public void free ();
		public static GLib.Type get_type ();
	}
	[ReferenceType]
	[CCode (cheader_filename = "clutter/clutter.h")]
	public struct MotionEvent {
		public Clutter.EventType type;
		public uint time;
		public int x;
		public int y;
		public Clutter.ModifierType modifier_state;
		public double axes;
		public weak Clutter.InputDevice device;
	}
	[ReferenceType]
	[CCode (cheader_filename = "clutter/clutter.h")]
	public struct Perspective {
		public int32 fovy;
		public int32 aspect;
		public int32 z_near;
		public int32 z_far;
		public weak Clutter.Perspective copy ();
		public void free ();
		public static GLib.Type get_type ();
	}
	[ReferenceType]
	[CCode (cheader_filename = "clutter/clutter.h")]
	public struct ScrollEvent {
		public Clutter.EventType type;
		public uint time;
		public int x;
		public int y;
		public Clutter.ScrollDirection direction;
		public Clutter.ModifierType modifier_state;
		public double axes;
		public weak Clutter.InputDevice device;
	}
	[ReferenceType]
	[CCode (cheader_filename = "clutter/clutter.h")]
	public struct StageStateEvent {
		public Clutter.EventType type;
		public Clutter.StageState changed_mask;
		public Clutter.StageState new_state;
	}
	[ReferenceType]
	[CCode (cheader_filename = "clutter/clutter.h")]
	public struct TimeoutPool {
		public uint add (uint interval, GLib.SourceFunc func, pointer data, GLib.DestroyNotify notify);
		public TimeoutPool (int priority);
		public void remove (uint id);
	}
	[ReferenceType]
	[CCode (cheader_filename = "clutter/clutter.h")]
	public struct Vertex {
		public int32 x;
		public int32 y;
		public int32 z;
		public static GLib.Type get_type ();
	}
	[ReferenceType]
	[CCode (cheader_filename = "clutter/clutter.h")]
	public struct Effect {
		public static weak Clutter.Timeline fade (Clutter.EffectTemplate template_, Clutter.Actor actor, uchar start_opacity, uchar end_opacity, Clutter.EffectCompleteFunc completed_func, pointer completed_data);
		[NoArrayLength]
		public static weak Clutter.Timeline move (Clutter.EffectTemplate template_, Clutter.Actor actor, Clutter.Knot[] knots, uint n_knots, Clutter.EffectCompleteFunc completed_func, pointer completed_data);
		public static weak Clutter.Timeline rotate_x (Clutter.EffectTemplate template_, Clutter.Actor actor, double angle_begin, double angle_end, int center_y, int center_z, Clutter.RotateDirection direction, Clutter.EffectCompleteFunc completed_func, pointer completed_data);
		public static weak Clutter.Timeline rotate_y (Clutter.EffectTemplate template_, Clutter.Actor actor, double angle_begin, double angle_end, int center_x, int center_z, Clutter.RotateDirection direction, Clutter.EffectCompleteFunc completed_func, pointer completed_data);
		public static weak Clutter.Timeline rotate_z (Clutter.EffectTemplate template_, Clutter.Actor actor, double angle_begin, double angle_end, int center_x, int center_y, Clutter.RotateDirection direction, Clutter.EffectCompleteFunc completed_func, pointer completed_data);
		public static weak Clutter.Timeline scale (Clutter.EffectTemplate template_, Clutter.Actor actor, double scale_begin, double scale_end, Clutter.Gravity gravity, Clutter.EffectCompleteFunc completed_func, pointer completed_data);
	}
	[ReferenceType]
	[CCode (cheader_filename = "clutter/clutter.h")]
	public struct Event {
		public weak Clutter.Event copy ();
		public void free ();
		public static weak Clutter.Event get ();
		public void get_coords (int x, int y);
		public Clutter.ModifierType get_state ();
		public uint get_time ();
		public static GLib.Type get_type ();
		public Event (Clutter.EventType type);
		public static weak Clutter.Event peek ();
		public void put ();
		public Clutter.EventType type ();
	}
	[ReferenceType]
	[CCode (cheader_filename = "clutter/clutter.h")]
	public struct Exp {
		public static uint dec_func (Clutter.Alpha alpha, pointer dummy);
		public static uint inc_func (Clutter.Alpha alpha, pointer dummy);
	}
	[ReferenceType]
	[CCode (cheader_filename = "clutter/clutter.h")]
	public struct Feature {
		public static bool available (Clutter.FeatureFlags feature);
		public static Clutter.FeatureFlags get_all ();
	}
	[ReferenceType]
	[CCode (cheader_filename = "clutter/clutter.h")]
	public struct Init {
		public static GLib.Quark error_quark ();
		public static Clutter.InitError with_args (int argc, string argv, string parameter_string, GLib.OptionEntry entries, string translation_domain, GLib.Error error);
	}
	[ReferenceType]
	[CCode (cheader_filename = "clutter/clutter.h")]
	public struct Main {
		public static int level ();
		public static void quit ();
	}
	[ReferenceType]
	[CCode (cheader_filename = "clutter/clutter.h")]
	public struct Ramp {
		public static uint dec_func (Clutter.Alpha alpha, pointer dummy);
		public static uint func (Clutter.Alpha alpha, pointer dummy);
		public static uint inc_func (Clutter.Alpha alpha, pointer dummy);
	}
	[ReferenceType]
	[CCode (cheader_filename = "clutter/clutter.h")]
	public struct Sine {
		public static uint dec_func (Clutter.Alpha alpha, pointer dummy);
		public static uint func (Clutter.Alpha alpha, pointer dummy);
		public static uint half_func (Clutter.Alpha alpha, pointer dummy);
		public static uint inc_func (Clutter.Alpha alpha, pointer dummy);
	}
	[ReferenceType]
	[CCode (cheader_filename = "clutter/clutter.h")]
	public struct Smoothstep {
		public static uint dec_func (Clutter.Alpha alpha, pointer dummy);
		public static uint inc_func (Clutter.Alpha alpha, pointer dummy);
	}
	[ReferenceType]
	[CCode (cheader_filename = "clutter/clutter.h")]
	public struct Threads {
		public static void enter ();
		public static void leave ();
	}
	public static delegate uint AlphaFunc (Clutter.Alpha alpha, pointer user_data);
	public static delegate void BehaviourForeachFunc (Clutter.Behaviour behaviour, Clutter.Actor actor, pointer data);
	public static delegate void Callback (Clutter.Actor actor, pointer data);
	public static delegate void EffectCompleteFunc (Clutter.Actor actor, pointer user_data);
	public static void init (out string[] args);
	public static void main ();
	public static void main_quit ();
	public static void base_init ();
	public static bool events_pending ();
	public static bool get_debug_enabled ();
	public static weak Clutter.Backend get_default_backend ();
	public static weak GLib.OptionGroup get_option_group ();
	public static bool get_show_fps ();
	public static ulong get_timestamp ();
	public static uint keysym_to_unicode (uint keyval);
	public static uint square_func (Clutter.Alpha alpha, pointer dummy);
	public static int util_next_p2 (int a);
}
