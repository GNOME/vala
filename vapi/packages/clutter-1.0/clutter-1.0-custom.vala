namespace Clutter {
	public class Actor {
		[CCode (cname = "clutter_get_actor_by_gid")]
		public static unowned Clutter.Actor get_by_gid (uint32 id);
	}

	[CCode (dup_function = "clutter_actor_box_copy", free_function = "clutter_actor_box_free")]
	public struct ActorBox {
		[CCode (cname = "clutter_actor_box_from_vertices")]
		public ActorBox.from_vertices (Clutter.Vertex[] verts);
	}

	[CCode (get_value_function = "clutter_value_get_color", set_value_function = "clutter_value_set_color", dup_function = "clutter_color_copy", free_function = "clutter_color_free")]
	public struct Color {
		[CCode (cname = "clutter_color_from_hls")]
		public Color.from_hls (float hue, float luminance, float saturation);
		[CCode (cname = "clutter_color_from_pixel")]
		public Color.from_pixel (uint32 pixel);
		[CCode (cname = "clutter_color_from_string")]
		public Color.from_string (string str);
		[CCode (cname = "clutter_color_from_string")]
		public bool parse_string (string str);

		public static GLib.HashFunc hash;
		public static GLib.EqualFunc equal;
	}

	public interface Container : GLib.Object {
		public void add (...);
		[CCode (vfunc_name = "add")]
		public abstract void add_actor (Clutter.Actor actor);

		public void remove (...);
		[CCode (vfunc_name = "remove")]
		public abstract void remove_actor (Clutter.Actor actor);

		[NoWrapper]
		public virtual void create_child_meta (Clutter.Actor actor);
		[NoWrapper]
		public virtual void destroy_child_meta (Clutter.Actor actor);
		public virtual void foreach_with_internals (Clutter.Callback callback);
		public virtual unowned Clutter.ChildMeta get_child_meta (Clutter.Actor actor);
		[NoWrapper]
		public virtual void lower (Clutter.Actor actor, Clutter.Actor? sibling);
		[NoWrapper]
		public virtual void raise (Clutter.Actor actor, Clutter.Actor? sibling);
		public virtual void sort_depth_order ();

		public GLib.List<weak Clutter.Actor> get_children ();
	}

	[CCode (cheader_filename = "clutter/clutter.h")]
	namespace FrameSource {
		public static uint add (uint fps, GLib.SourceFunc func);
		public static uint add_full (int priority, uint fps, GLib.SourceFunc func, GLib.DestroyNotify? notify = null);
	}

	public class InputDevice {
		[CCode (cname = "clutter_get_input_device_for_id")]
		public static unowned Clutter.InputDevice get_for_id (int id);
	}

	[CCode (cname = "GParamSpec")]
	public class ParamSpecColor: GLib.ParamSpec {
		[CCode (cname = "clutter_param_spec_color")]
		public ParamSpecColor (string name, string nick, string blurb, Clutter.Color default_value, GLib.ParamFlags flags);
	}

	[CCode (cname = "GParamSpec")]
	public class ParamSpecFixed: GLib.ParamSpec {
		[CCode (cname = "clutter_param_spec_fixed")]
		public ParamSpecFixed (string name, string nick, string blurb, Cogl.Fixed minimum, Cogl.Fixed maximum, Cogl.Fixed default_value, GLib.ParamFlags flags);
	}

	[CCode (cname = "GParamSpec")]
	public class ParamSpecUnits: GLib.ParamSpec {
		[CCode (cname = "clutter_param_spec_units")]
		public ParamSpecUnits (string name, string nick, string blurb, Clutter.Units minimum, Clutter.Units maximum, Clutter.Units default_value, GLib.ParamFlags flags);
	}

	public class Shader {
		public Cogl.Shader get_cogl_fragment_shader ();
		public Cogl.Program get_cogl_program ();
		public Cogl.Shader get_cogl_vertex_shader ();
	}

	public class Stage {
		[CCode (cname = "clutter_redraw")]
		public void redraw ();
	}

	public class Texture {
		[CCode (type = "ClutterActor*", has_construct_function = false)]
		public Texture.from_file (string filename) throws TextureError;
		public Cogl.Material cogl_material { get; set; }
		public Cogl.Texture cogl_texture { get; set; }
	}

	[CCode (cheader_filename = "clutter/clutter.h")]
	namespace Threads {
		[CCode (cheader_filename = "clutter/clutter.h")]
		namespace FrameSource {
			[CCode (cname = "clutter_threads_add_frame_source")]
			public static uint add (uint fps, GLib.SourceFunc func);
			[CCode (cname = "clutter_threads_add_frame_source_full")]
			public static uint add_full (int priority, uint fps, GLib.SourceFunc func, GLib.DestroyNotify? notify = null);
		}

		[CCode (cheader_filename = "clutter/clutter.h")]
		namespace Idle {
			[CCode (cname = "clutter_threads_add_idle")]
			public static uint add (GLib.SourceFunc func);
			[CCode (cname = "clutter_threads_add_idle_full")]
			public static uint add_full (int priority, GLib.SourceFunc func, GLib.DestroyNotify? notify = null);
		}

		[CCode (cheader_filename = "clutter/clutter.h")]
		namespace Timeout {
			[CCode (cname = "clutter_threads_add_timeout")]
			public static uint add (uint interval, GLib.SourceFunc func);
			[CCode (cname = "clutter_threads_add_timeout_full")]
			public static uint add_full (int priority, uint interval, GLib.SourceFunc func, GLib.DestroyNotify? notify = null);
		}

		public static void enter ();
		public static void init ();
		public static void leave ();
		public static void set_lock_functions (GLib.Callback enter_fn, GLib.Callback leave_fn);
	}
	[CCode (type_id = "CLUTTER_TYPE_UNITS", get_value_function = "clutter_value_get_unit", set_value_function = "clutter_value_set_unit", dup_function = "clutter_units_copy", free_function = "clutter_units_free")]
	public struct Units {
		public Clutter.UnitType unit_type;
		public float value;
		public float pixels;
		public uint pixels_set;
		[CCode (cname = "clutter_units_from_em")]
		public Units.from_em (float em);
		[CCode (cname = "clutter_units_from_em_for_font")]
		public Units.from_em_for_font (string font_name, float em);
		[CCode (cname = "clutter_units_from_mm")]
		public Units.from_mm (float mm);
		[CCode (cname = "clutter_units_from_pixels")]
		public Units.from_pixels (int px);
		[CCode (cname = "clutter_units_from_pt")]
		public Units.from_pt (float pt);
		[CCode (cname = "clutter_units_from_string")]
		public Units.from_string (string str);
		public Clutter.UnitType get_unit_type ();
		public float get_unit_value ();
		public float to_pixels ();
		public unowned string to_string ();
	}

	[CCode (cheader_filename = "clutter/clutter.h")]
	namespace Util {
		[CCode (cname = "clutter_util_next_p2")]
		public static int next_power_of_2 (int a);
	}

	[CCode (cprefix = "clutter_value_", cheader_filename = "clutter/clutter.h")]
	namespace Value {
		public unowned Clutter.Color? get_color (GLib.Value value);
		public void set_color (GLib.Value value, Clutter.Color color);

		public unowned Cogl.Fixed? get_fixed (GLib.Value value);
		public void set_fixed (GLib.Value value, Cogl.Fixed fixed_);

		public unowned Clutter.Units get_units (GLib.Value value);
		public void set_units (GLib.Value value, Clutter.Units units);

		public unowned float[] get_shader_float (GLib.Value value);
		public void set_shader_float (GLib.Value value, [CCode (array_length_pos = 1.9)] float[] floats);

		public unowned int[] get_shader_int (GLib.Value value);
		public void set_shader_int (GLib.Value value, [CCode (array_length_pos = 1.9)] int[] ints);

		public unowned float[] get_shader_matrix (GLib.Value value);
		public void set_shader_matrix (GLib.Value value, [CCode (array_length_pos = 1.9)] float[] matrix);
	}

	[CCode (cprefix = "CLUTTER_FEATURE_")]
	[Flags]
	public enum FeatureFlags {
		TEXTURE_NPOT,
		SYNC_TO_VBLANK,
		TEXTURE_YUV,
		TEXTURE_READ_PIXELS,
		STAGE_STATIC,
		STAGE_USER_RESIZE,
		STAGE_CURSOR,
		SHADERS_GLSL,
		OFFSCREEN,
		STAGE_MULTIPLE;
		[CCode (cname = "clutter_feature_available")]
		public bool is_available ();
		[CCode (cname = "clutter_feature_get_all")]
		public static Clutter.FeatureFlags get ();
	}
}
