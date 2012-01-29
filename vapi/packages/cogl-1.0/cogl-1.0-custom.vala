
namespace Cogl {
	[Compact]
	[CCode (cname = "CoglHandle")]
	public class Bitmap: Handle {
		public static bool get_size_from_file (string filename, out int width, out int height);
		public static Bitmap new_from_file (string filename) throws GLib.Error;
	}

	[Compact]
	[CCode (cname = "CoglHandle")]
	public class Buffer: Handle {
		public uint get_size ();
		public Cogl.BufferUpdateHint get_update_hint ();
		public uchar map (Cogl.BufferAccess access);
		public bool set_data (size_t offset, [CCode (array_length_type = "size_t")] uint8[] data);
		public void set_update_hint (Cogl.BufferUpdateHint hint);
		public void unmap ();
	}

	[CCode (has_type_id = false)]
	public struct Color {
		public Color.from_4f (float red, float green, float blue, float alpha);
		public Color.from_4ub (uint8 red, uint8 green, uint8 blue, uint8 alpha);
	}

	[Compact]
	[CCode (ref_function = "cogl_handle_ref", unref_function = "cogl_handle_unref")]
	public class Handle {
		[CCode (cname = "cogl_is_bitmap")]
		public bool is_bitmap ();
		[CCode (cname = "cogl_is_buffer")]
		public bool is_buffer ();
		[CCode (cname = "cogl_is_material")]
		public bool is_material ();
		[CCode (cname = "cogl_is_offscreen")]
		public bool is_offscreen ();
		[CCode (cname = "cogl_is_pixel_buffer")]
		public bool is_pixel_buffer ();
		[CCode (cname = "cogl_is_program")]
		public bool is_program ();
		[CCode (cname = "cogl_is_shader")]
		public bool is_shader ();
		[CCode (cname = "cogl_is_texture")]
		public bool is_texture ();
		[CCode (cname = "cogl_is_vertex_buffer")]
		public bool is_vertex_buffer ();
	}

	[Compact]
	[CCode (cname = "CoglHandle", ref_function = "cogl_material_ref", unref_function = "cogl_material_unref")]
	public class Material: Handle {
		[CCode (type = "CoglHandle*", has_construct_function = false)]
		public Material ();
		public Material copy();

		public void get_ambient (out Cogl.Color ambient);
		public void get_color (out Cogl.Color color);
		public void get_diffuse (out Cogl.Color diffuse);
		public void get_emission (out Cogl.Color emission);
		public unowned GLib.List<Cogl.MaterialLayer> get_layers ();
		public int get_n_layers ();
		public float get_shininess ();
		public void get_specular (out Cogl.Color specular);

		public void remove_layer (int layer_index);
		public void set_alpha_test_function (Cogl.MaterialAlphaFunc alpha_func, float alpha_reference);
		public void set_ambient (Cogl.Color ambient);
		public void set_ambient_and_diffuse (Cogl.Color color);
		public bool set_blend (string blend_string) throws Cogl.BlendStringError;
		public void set_blend_constant (Cogl.Color constant_color);
		public void set_color (Cogl.Color color);
		public void set_color4f (float red, float green, float blue, float alpha);
		public void set_color4ub (uchar red, uchar green, uchar blue, uchar alpha);
		public void set_diffuse (Cogl.Color diffuse);
		public void set_emission (Cogl.Color emission);
		public void set_layer (int layer_index, Cogl.Texture texture);
		public bool set_layer_combine (int layer_index, string blend_string) throws BlendStringError;
		public void set_layer_combine_constant (int layer_index, Cogl.Color constant);
		public void set_layer_filters (int layer_index, Cogl.MaterialFilter min_filter, Cogl.MaterialFilter mag_filter);
		public void set_layer_matrix (int layer_index, Cogl.Matrix matrix);
		public void set_shininess (float shininess);
		public void set_specular (Cogl.Color specular);
	}

	[Compact]
	[CCode (cname = "CoglHandle")]
	public class MaterialLayer: Handle {
		public Cogl.MaterialFilter get_mag_filter ();
		public Cogl.MaterialFilter get_min_filter ();
		public unowned Cogl.Texture? get_texture ();
		public Cogl.MaterialLayerType get_type ();
	}

	[Compact]
	[CCode (cname = "CoglHandle", ref_function = "cogl_offscreen_ref", unref_function = "cogl_offscreen_unref")]
	public class Offscreen: Handle {
		[CCode (cname = "cogl_offscreen_new_to_texture", type = "CoglHandle*", has_construct_function = false)]
		public Offscreen.to_texture (Cogl.Texture handle);
		[CCode (instance_pos = -1)]
		public void set_draw_buffer (Cogl.BufferTarget target);
		[CCode (cname = "cogl_pop_draw_buffer")]
		public static void pop_draw_buffer ();
		[CCode (cname = "cogl_push_draw_buffer")]
		public static void push_draw_buffer ();
	}

	[CCode (cheader_filename = "cogl/cogl.h", copy_function = "cogl_path_copy")] 
	[Compact]
	public class Path {
		public static void @new ();
	}

	[Compact]
	public class PixelBuffer: Handle {
		public PixelBuffer (uint size);
		public PixelBuffer.for_size (uint width, uint height, Cogl.PixelFormat format, uint stride);
	}

	[Compact]
	[CCode (cname = "CoglHandle", ref_function = "cogl_program_ref", unref_function = "cogl_program_unref")]
	public class Program: Handle {
		[CCode (cname = "cogl_create_program", type = "CoglHandle*", has_construct_function = false)]
		public Program ();
		public void attach_shader (Cogl.Shader shader_handle);
		public int get_uniform_location (string uniform_name);
		public void link ();
		public static void uniform_1f (int uniform_no, float value);
		public static void uniform_1i (int uniform_no, int value);
		public static void uniform_float (int uniform_no, int size, [CCode (array_length_pos = 2.9)] float[] value);
		public static void uniform_int (int uniform_no, int size, [CCode (array_length_pos = 2.9)] int[] value);
		public static void uniform_matrix (int uniform_no, int size, bool transpose, [CCode (array_length_pos = 2.9)] float[] value);
		public void use ();
	}

	[Compact]
	[CCode (cname = "CoglHandle", ref_function = "cogl_shader_ref", unref_function = "cogl_shader_unref")]
	public class Shader: Handle {
		[CCode (cname = "cogl_create_shader", type = "CoglHandle*", has_construct_function = false)]
		public Shader (Cogl.ShaderType shader_type);
		public void compile ();
		public string get_info_log ();
		public Cogl.ShaderType get_type ();
		public bool is_compiled ();
		public void source (string source);
	}

	[Compact]
	[CCode (cname = "CoglHandle", ref_function = "cogl_texture_ref", unref_function = "cogl_texture_unref")]
	public class Texture: Handle {
		public int get_data (Cogl.PixelFormat format, uint rowstride, uchar[] data);
		public Cogl.PixelFormat get_format ();
		public uint get_height ();
		public int get_max_waste ();
		public uint get_rowstride ();
		public uint get_width ();
		public bool is_sliced ();
		public Texture.from_bitmap (Cogl.Bitmap bmp_handle, Cogl.TextureFlags flags, Cogl.PixelFormat internal_format);
		public Texture.from_data (uint width, uint height, Cogl.TextureFlags flags, Cogl.PixelFormat format, Cogl.PixelFormat internal_format, uint rowstride, [CCode (array_length = false)] uchar[] data);
		public Texture.from_file (string filename, Cogl.TextureFlags flags, Cogl.PixelFormat internal_format) throws GLib.Error;
		public Texture.with_size (uint width, uint height, Cogl.TextureFlags flags, Cogl.PixelFormat internal_format);
		public bool set_region (int src_x, int src_y, int dst_x, int dst_y, uint dst_width, uint dst_height, int width, int height, Cogl.PixelFormat format, uint rowstride, uchar[] data);
	}

	[Compact]
	[CCode (cname = "CoglHandle", ref_function = "cogl_vertex_buffer_ref", unref_function = "cogl_vertex_buffer_unref")]
	public class VertexBuffer: Handle {
		[CCode (type = "CoglHandle*", has_construct_function = false)]
		public VertexBuffer (uint n_vertices);
		public void add (string attribute_name, uchar n_components, Cogl.AttributeType type, bool normalized, uint16 stride, void* pointer);
		public void delete (string attribute_name);
		public void disable (string attribute_name);
		public void draw (Cogl.VerticesMode mode, int first, int count);
		public void draw_elements (Cogl.VerticesMode mode, VertexBufferIndices indices, int min_index, int max_index, int indices_offset, int count);
		public void enable (string attribute_name);
		public uint get_n_vertices ();
		public void submit ();
	}

	[Compact]
	[CCode (cname = "CoglHandle")]
	public class VertexBufferIndices: Handle {
		public VertexBufferIndices (Cogl.IndicesType indices_type, void* indices_array, int indices_len);
		public static unowned Cogl.VertexBufferIndices get_for_quads (uint n_indices);
		public Cogl.IndicesType get_type ();
	}

	[CCode (type_id = "COGL_TYPE_MATRIX", cheader_filename = "cogl/cogl.h")]
	public struct Matrix {
		[CCode (cname = "cogl_matrix_init_from_array", array_length = false, array_null_terminated = false)]
		public Matrix.from_array ([CCode (array_length = false)] float[] array);
		[CCode (cname = "cogl_matrix_init_identity")]
		public Matrix.identity ();
		[CCode (cname = "cogl_matrix_multiply")]
		public Matrix.multiply (Cogl.Matrix a, Cogl.Matrix b);
	}
}
