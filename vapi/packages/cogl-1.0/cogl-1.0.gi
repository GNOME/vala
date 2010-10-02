<?xml version="1.0"?>
<api version="1.0">
	<namespace name="Cogl">
		<function name="attribute_type_get_type" symbol="cogl_attribute_type_get_type">
			<return-type type="GType"/>
		</function>
		<function name="begin_gl" symbol="cogl_begin_gl">
			<return-type type="void"/>
		</function>
		<function name="blend_string_error_get_type" symbol="cogl_blend_string_error_get_type">
			<return-type type="GType"/>
		</function>
		<function name="blend_string_error_quark" symbol="cogl_blend_string_error_quark">
			<return-type type="GQuark"/>
		</function>
		<function name="check_extension" symbol="cogl_check_extension">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="name" type="char*"/>
				<parameter name="ext" type="char*"/>
			</parameters>
		</function>
		<function name="clear" symbol="cogl_clear">
			<return-type type="void"/>
			<parameters>
				<parameter name="color" type="CoglColor*"/>
				<parameter name="buffers" type="unsigned"/>
			</parameters>
		</function>
		<function name="clip_ensure" symbol="cogl_clip_ensure">
			<return-type type="void"/>
		</function>
		<function name="clip_pop" symbol="cogl_clip_pop">
			<return-type type="void"/>
		</function>
		<function name="clip_push" symbol="cogl_clip_push">
			<return-type type="void"/>
			<parameters>
				<parameter name="x_offset" type="float"/>
				<parameter name="y_offset" type="float"/>
				<parameter name="width" type="float"/>
				<parameter name="height" type="float"/>
			</parameters>
		</function>
		<function name="clip_push_from_path" symbol="cogl_clip_push_from_path">
			<return-type type="void"/>
		</function>
		<function name="clip_push_from_path_preserve" symbol="cogl_clip_push_from_path_preserve">
			<return-type type="void"/>
		</function>
		<function name="clip_push_rectangle" symbol="cogl_clip_push_rectangle">
			<return-type type="void"/>
			<parameters>
				<parameter name="x0" type="float"/>
				<parameter name="y0" type="float"/>
				<parameter name="x1" type="float"/>
				<parameter name="y1" type="float"/>
			</parameters>
		</function>
		<function name="clip_push_window_rect" symbol="cogl_clip_push_window_rect">
			<return-type type="void"/>
			<parameters>
				<parameter name="x_offset" type="float"/>
				<parameter name="y_offset" type="float"/>
				<parameter name="width" type="float"/>
				<parameter name="height" type="float"/>
			</parameters>
		</function>
		<function name="clip_push_window_rectangle" symbol="cogl_clip_push_window_rectangle">
			<return-type type="void"/>
			<parameters>
				<parameter name="x_offset" type="int"/>
				<parameter name="y_offset" type="int"/>
				<parameter name="width" type="int"/>
				<parameter name="height" type="int"/>
			</parameters>
		</function>
		<function name="clip_stack_restore" symbol="cogl_clip_stack_restore">
			<return-type type="void"/>
		</function>
		<function name="clip_stack_save" symbol="cogl_clip_stack_save">
			<return-type type="void"/>
		</function>
		<function name="create_program" symbol="cogl_create_program">
			<return-type type="CoglHandle"/>
		</function>
		<function name="create_shader" symbol="cogl_create_shader">
			<return-type type="CoglHandle"/>
			<parameters>
				<parameter name="shader_type" type="CoglShaderType"/>
			</parameters>
		</function>
		<function name="depth_test_function_get_type" symbol="cogl_depth_test_function_get_type">
			<return-type type="GType"/>
		</function>
		<function name="disable_fog" symbol="cogl_disable_fog">
			<return-type type="void"/>
		</function>
		<function name="double_to_fixed" symbol="cogl_double_to_fixed">
			<return-type type="CoglFixed"/>
			<parameters>
				<parameter name="value" type="double"/>
			</parameters>
		</function>
		<function name="double_to_int" symbol="cogl_double_to_int">
			<return-type type="int"/>
			<parameters>
				<parameter name="value" type="double"/>
			</parameters>
		</function>
		<function name="double_to_uint" symbol="cogl_double_to_uint">
			<return-type type="unsigned"/>
			<parameters>
				<parameter name="value" type="double"/>
			</parameters>
		</function>
		<function name="driver_error_get_type" symbol="cogl_driver_error_get_type">
			<return-type type="GType"/>
		</function>
		<function name="end_gl" symbol="cogl_end_gl">
			<return-type type="void"/>
		</function>
		<function name="error_get_type" symbol="cogl_error_get_type">
			<return-type type="GType"/>
		</function>
		<function name="feature_flags_get_type" symbol="cogl_feature_flags_get_type">
			<return-type type="GType"/>
		</function>
		<function name="features_available" symbol="cogl_features_available">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="features" type="CoglFeatureFlags"/>
			</parameters>
		</function>
		<function name="flush" symbol="cogl_flush">
			<return-type type="void"/>
		</function>
		<function name="fog_mode_get_type" symbol="cogl_fog_mode_get_type">
			<return-type type="GType"/>
		</function>
		<function name="frustum" symbol="cogl_frustum">
			<return-type type="void"/>
			<parameters>
				<parameter name="left" type="float"/>
				<parameter name="right" type="float"/>
				<parameter name="bottom" type="float"/>
				<parameter name="top" type="float"/>
				<parameter name="z_near" type="float"/>
				<parameter name="z_far" type="float"/>
			</parameters>
		</function>
		<function name="get_backface_culling_enabled" symbol="cogl_get_backface_culling_enabled">
			<return-type type="gboolean"/>
		</function>
		<function name="get_bitmasks" symbol="cogl_get_bitmasks">
			<return-type type="void"/>
			<parameters>
				<parameter name="red" type="int*"/>
				<parameter name="green" type="int*"/>
				<parameter name="blue" type="int*"/>
				<parameter name="alpha" type="int*"/>
			</parameters>
		</function>
		<function name="get_depth_test_enabled" symbol="cogl_get_depth_test_enabled">
			<return-type type="gboolean"/>
		</function>
		<function name="get_features" symbol="cogl_get_features">
			<return-type type="CoglFeatureFlags"/>
		</function>
		<function name="get_modelview_matrix" symbol="cogl_get_modelview_matrix">
			<return-type type="void"/>
			<parameters>
				<parameter name="matrix" type="CoglMatrix*"/>
			</parameters>
		</function>
		<function name="get_option_group" symbol="cogl_get_option_group">
			<return-type type="GOptionGroup*"/>
		</function>
		<function name="get_path" symbol="cogl_get_path">
			<return-type type="CoglPath*"/>
		</function>
		<function name="get_proc_address" symbol="cogl_get_proc_address">
			<return-type type="CoglFuncPtr"/>
			<parameters>
				<parameter name="name" type="char*"/>
			</parameters>
		</function>
		<function name="get_projection_matrix" symbol="cogl_get_projection_matrix">
			<return-type type="void"/>
			<parameters>
				<parameter name="matrix" type="CoglMatrix*"/>
			</parameters>
		</function>
		<function name="get_viewport" symbol="cogl_get_viewport">
			<return-type type="void"/>
			<parameters>
				<parameter name="v" type="float[]"/>
			</parameters>
		</function>
		<function name="indices_type_get_type" symbol="cogl_indices_type_get_type">
			<return-type type="GType"/>
		</function>
		<function name="is_bitmap" symbol="cogl_is_bitmap">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="handle" type="CoglHandle"/>
			</parameters>
		</function>
		<function name="is_buffer_EXP" symbol="cogl_is_buffer_EXP">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="object" type="void*"/>
			</parameters>
		</function>
		<function name="is_material" symbol="cogl_is_material">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="handle" type="CoglHandle"/>
			</parameters>
		</function>
		<function name="is_offscreen" symbol="cogl_is_offscreen">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="handle" type="CoglHandle"/>
			</parameters>
		</function>
		<function name="is_path" symbol="cogl_is_path">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="handle" type="CoglHandle"/>
			</parameters>
		</function>
		<function name="is_pixel_array_EXP" symbol="cogl_is_pixel_array_EXP">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="object" type="void*"/>
			</parameters>
		</function>
		<function name="is_program" symbol="cogl_is_program">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="handle" type="CoglHandle"/>
			</parameters>
		</function>
		<function name="is_shader" symbol="cogl_is_shader">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="handle" type="CoglHandle"/>
			</parameters>
		</function>
		<function name="is_texture" symbol="cogl_is_texture">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="handle" type="CoglHandle"/>
			</parameters>
		</function>
		<function name="is_texture_3d_EXP" symbol="cogl_is_texture_3d_EXP">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="handle" type="CoglHandle"/>
			</parameters>
		</function>
		<function name="is_texture_pixmap_x11_EXP" symbol="cogl_is_texture_pixmap_x11_EXP">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="handle" type="CoglHandle"/>
			</parameters>
		</function>
		<function name="is_vertex_buffer" symbol="cogl_is_vertex_buffer">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="handle" type="CoglHandle"/>
			</parameters>
		</function>
		<function name="is_vertex_buffer_indices" symbol="cogl_is_vertex_buffer_indices">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="handle" type="CoglHandle"/>
			</parameters>
		</function>
		<function name="offscreen_new_to_texture" symbol="cogl_offscreen_new_to_texture">
			<return-type type="CoglHandle"/>
			<parameters>
				<parameter name="handle" type="CoglHandle"/>
			</parameters>
		</function>
		<function name="offscreen_ref" symbol="cogl_offscreen_ref">
			<return-type type="CoglHandle"/>
			<parameters>
				<parameter name="handle" type="CoglHandle"/>
			</parameters>
		</function>
		<function name="offscreen_unref" symbol="cogl_offscreen_unref">
			<return-type type="void"/>
			<parameters>
				<parameter name="handle" type="CoglHandle"/>
			</parameters>
		</function>
		<function name="ortho" symbol="cogl_ortho">
			<return-type type="void"/>
			<parameters>
				<parameter name="left" type="float"/>
				<parameter name="right" type="float"/>
				<parameter name="bottom" type="float"/>
				<parameter name="top" type="float"/>
				<parameter name="near" type="float"/>
				<parameter name="far" type="float"/>
			</parameters>
		</function>
		<function name="pango_ensure_glyph_cache_for_layout" symbol="cogl_pango_ensure_glyph_cache_for_layout">
			<return-type type="void"/>
			<parameters>
				<parameter name="layout" type="PangoLayout*"/>
			</parameters>
		</function>
		<function name="pango_render_layout" symbol="cogl_pango_render_layout">
			<return-type type="void"/>
			<parameters>
				<parameter name="layout" type="PangoLayout*"/>
				<parameter name="x" type="int"/>
				<parameter name="y" type="int"/>
				<parameter name="color" type="CoglColor*"/>
				<parameter name="flags" type="int"/>
			</parameters>
		</function>
		<function name="pango_render_layout_line" symbol="cogl_pango_render_layout_line">
			<return-type type="void"/>
			<parameters>
				<parameter name="line" type="PangoLayoutLine*"/>
				<parameter name="x" type="int"/>
				<parameter name="y" type="int"/>
				<parameter name="color" type="CoglColor*"/>
			</parameters>
		</function>
		<function name="pango_render_layout_subpixel" symbol="cogl_pango_render_layout_subpixel">
			<return-type type="void"/>
			<parameters>
				<parameter name="layout" type="PangoLayout*"/>
				<parameter name="x" type="int"/>
				<parameter name="y" type="int"/>
				<parameter name="color" type="CoglColor*"/>
				<parameter name="flags" type="int"/>
			</parameters>
		</function>
		<function name="perspective" symbol="cogl_perspective">
			<return-type type="void"/>
			<parameters>
				<parameter name="fovy" type="float"/>
				<parameter name="aspect" type="float"/>
				<parameter name="z_near" type="float"/>
				<parameter name="z_far" type="float"/>
			</parameters>
		</function>
		<function name="pixel_format_get_type" symbol="cogl_pixel_format_get_type">
			<return-type type="GType"/>
		</function>
		<function name="polygon" symbol="cogl_polygon">
			<return-type type="void"/>
			<parameters>
				<parameter name="vertices" type="CoglTextureVertex*"/>
				<parameter name="n_vertices" type="unsigned"/>
				<parameter name="use_color" type="gboolean"/>
			</parameters>
		</function>
		<function name="pop_draw_buffer" symbol="cogl_pop_draw_buffer">
			<return-type type="void"/>
		</function>
		<function name="pop_framebuffer" symbol="cogl_pop_framebuffer">
			<return-type type="void"/>
		</function>
		<function name="pop_matrix" symbol="cogl_pop_matrix">
			<return-type type="void"/>
		</function>
		<function name="program_attach_shader" symbol="cogl_program_attach_shader">
			<return-type type="void"/>
			<parameters>
				<parameter name="program_handle" type="CoglHandle"/>
				<parameter name="shader_handle" type="CoglHandle"/>
			</parameters>
		</function>
		<function name="program_get_uniform_location" symbol="cogl_program_get_uniform_location">
			<return-type type="int"/>
			<parameters>
				<parameter name="handle" type="CoglHandle"/>
				<parameter name="uniform_name" type="char*"/>
			</parameters>
		</function>
		<function name="program_link" symbol="cogl_program_link">
			<return-type type="void"/>
			<parameters>
				<parameter name="handle" type="CoglHandle"/>
			</parameters>
		</function>
		<function name="program_ref" symbol="cogl_program_ref">
			<return-type type="CoglHandle"/>
			<parameters>
				<parameter name="handle" type="CoglHandle"/>
			</parameters>
		</function>
		<function name="program_set_uniform_1f" symbol="cogl_program_set_uniform_1f">
			<return-type type="void"/>
			<parameters>
				<parameter name="program" type="CoglHandle"/>
				<parameter name="uniform_location" type="int"/>
				<parameter name="value" type="float"/>
			</parameters>
		</function>
		<function name="program_set_uniform_1i" symbol="cogl_program_set_uniform_1i">
			<return-type type="void"/>
			<parameters>
				<parameter name="program" type="CoglHandle"/>
				<parameter name="uniform_location" type="int"/>
				<parameter name="value" type="int"/>
			</parameters>
		</function>
		<function name="program_set_uniform_float" symbol="cogl_program_set_uniform_float">
			<return-type type="void"/>
			<parameters>
				<parameter name="program" type="CoglHandle"/>
				<parameter name="uniform_location" type="int"/>
				<parameter name="n_components" type="int"/>
				<parameter name="count" type="int"/>
				<parameter name="value" type="float*"/>
			</parameters>
		</function>
		<function name="program_set_uniform_int" symbol="cogl_program_set_uniform_int">
			<return-type type="void"/>
			<parameters>
				<parameter name="program" type="CoglHandle"/>
				<parameter name="uniform_location" type="int"/>
				<parameter name="n_components" type="int"/>
				<parameter name="count" type="int"/>
				<parameter name="value" type="int*"/>
			</parameters>
		</function>
		<function name="program_set_uniform_matrix" symbol="cogl_program_set_uniform_matrix">
			<return-type type="void"/>
			<parameters>
				<parameter name="program" type="CoglHandle"/>
				<parameter name="uniform_location" type="int"/>
				<parameter name="dimensions" type="int"/>
				<parameter name="count" type="int"/>
				<parameter name="transpose" type="gboolean"/>
				<parameter name="value" type="float*"/>
			</parameters>
		</function>
		<function name="program_uniform_1f" symbol="cogl_program_uniform_1f">
			<return-type type="void"/>
			<parameters>
				<parameter name="uniform_no" type="int"/>
				<parameter name="value" type="float"/>
			</parameters>
		</function>
		<function name="program_uniform_1i" symbol="cogl_program_uniform_1i">
			<return-type type="void"/>
			<parameters>
				<parameter name="uniform_no" type="int"/>
				<parameter name="value" type="int"/>
			</parameters>
		</function>
		<function name="program_uniform_float" symbol="cogl_program_uniform_float">
			<return-type type="void"/>
			<parameters>
				<parameter name="uniform_no" type="int"/>
				<parameter name="size" type="int"/>
				<parameter name="count" type="int"/>
				<parameter name="value" type="float*"/>
			</parameters>
		</function>
		<function name="program_uniform_int" symbol="cogl_program_uniform_int">
			<return-type type="void"/>
			<parameters>
				<parameter name="uniform_no" type="int"/>
				<parameter name="size" type="int"/>
				<parameter name="count" type="int"/>
				<parameter name="value" type="int*"/>
			</parameters>
		</function>
		<function name="program_uniform_matrix" symbol="cogl_program_uniform_matrix">
			<return-type type="void"/>
			<parameters>
				<parameter name="uniform_no" type="int"/>
				<parameter name="size" type="int"/>
				<parameter name="count" type="int"/>
				<parameter name="transpose" type="gboolean"/>
				<parameter name="value" type="float*"/>
			</parameters>
		</function>
		<function name="program_unref" symbol="cogl_program_unref">
			<return-type type="void"/>
			<parameters>
				<parameter name="handle" type="CoglHandle"/>
			</parameters>
		</function>
		<function name="program_use" symbol="cogl_program_use">
			<return-type type="void"/>
			<parameters>
				<parameter name="handle" type="CoglHandle"/>
			</parameters>
		</function>
		<function name="push_draw_buffer" symbol="cogl_push_draw_buffer">
			<return-type type="void"/>
		</function>
		<function name="push_framebuffer" symbol="cogl_push_framebuffer">
			<return-type type="void"/>
			<parameters>
				<parameter name="buffer" type="CoglFramebuffer*"/>
			</parameters>
		</function>
		<function name="push_matrix" symbol="cogl_push_matrix">
			<return-type type="void"/>
		</function>
		<function name="read_pixels" symbol="cogl_read_pixels">
			<return-type type="void"/>
			<parameters>
				<parameter name="x" type="int"/>
				<parameter name="y" type="int"/>
				<parameter name="width" type="int"/>
				<parameter name="height" type="int"/>
				<parameter name="source" type="CoglReadPixelsFlags"/>
				<parameter name="format" type="CoglPixelFormat"/>
				<parameter name="pixels" type="guint8*"/>
			</parameters>
		</function>
		<function name="read_pixels_flags_get_type" symbol="cogl_read_pixels_flags_get_type">
			<return-type type="GType"/>
		</function>
		<function name="rectangle" symbol="cogl_rectangle">
			<return-type type="void"/>
			<parameters>
				<parameter name="x_1" type="float"/>
				<parameter name="y_1" type="float"/>
				<parameter name="x_2" type="float"/>
				<parameter name="y_2" type="float"/>
			</parameters>
		</function>
		<function name="rectangle_with_multitexture_coords" symbol="cogl_rectangle_with_multitexture_coords">
			<return-type type="void"/>
			<parameters>
				<parameter name="x1" type="float"/>
				<parameter name="y1" type="float"/>
				<parameter name="x2" type="float"/>
				<parameter name="y2" type="float"/>
				<parameter name="tex_coords" type="float*"/>
				<parameter name="tex_coords_len" type="int"/>
			</parameters>
		</function>
		<function name="rectangle_with_texture_coords" symbol="cogl_rectangle_with_texture_coords">
			<return-type type="void"/>
			<parameters>
				<parameter name="x1" type="float"/>
				<parameter name="y1" type="float"/>
				<parameter name="x2" type="float"/>
				<parameter name="y2" type="float"/>
				<parameter name="tx1" type="float"/>
				<parameter name="ty1" type="float"/>
				<parameter name="tx2" type="float"/>
				<parameter name="ty2" type="float"/>
			</parameters>
		</function>
		<function name="rectangles" symbol="cogl_rectangles">
			<return-type type="void"/>
			<parameters>
				<parameter name="verts" type="float*"/>
				<parameter name="n_rects" type="unsigned"/>
			</parameters>
		</function>
		<function name="rectangles_with_texture_coords" symbol="cogl_rectangles_with_texture_coords">
			<return-type type="void"/>
			<parameters>
				<parameter name="verts" type="float*"/>
				<parameter name="n_rects" type="unsigned"/>
			</parameters>
		</function>
		<function name="rotate" symbol="cogl_rotate">
			<return-type type="void"/>
			<parameters>
				<parameter name="angle" type="float"/>
				<parameter name="x" type="float"/>
				<parameter name="y" type="float"/>
				<parameter name="z" type="float"/>
			</parameters>
		</function>
		<function name="scale" symbol="cogl_scale">
			<return-type type="void"/>
			<parameters>
				<parameter name="x" type="float"/>
				<parameter name="y" type="float"/>
				<parameter name="z" type="float"/>
			</parameters>
		</function>
		<function name="set_backface_culling_enabled" symbol="cogl_set_backface_culling_enabled">
			<return-type type="void"/>
			<parameters>
				<parameter name="setting" type="gboolean"/>
			</parameters>
		</function>
		<function name="set_depth_test_enabled" symbol="cogl_set_depth_test_enabled">
			<return-type type="void"/>
			<parameters>
				<parameter name="setting" type="gboolean"/>
			</parameters>
		</function>
		<function name="set_draw_buffer" symbol="cogl_set_draw_buffer">
			<return-type type="void"/>
			<parameters>
				<parameter name="target" type="CoglBufferTarget"/>
				<parameter name="offscreen" type="CoglHandle"/>
			</parameters>
		</function>
		<function name="set_fog" symbol="cogl_set_fog">
			<return-type type="void"/>
			<parameters>
				<parameter name="fog_color" type="CoglColor*"/>
				<parameter name="mode" type="CoglFogMode"/>
				<parameter name="density" type="float"/>
				<parameter name="z_near" type="float"/>
				<parameter name="z_far" type="float"/>
			</parameters>
		</function>
		<function name="set_framebuffer" symbol="cogl_set_framebuffer">
			<return-type type="void"/>
			<parameters>
				<parameter name="buffer" type="CoglFramebuffer*"/>
			</parameters>
		</function>
		<function name="set_modelview_matrix" symbol="cogl_set_modelview_matrix">
			<return-type type="void"/>
			<parameters>
				<parameter name="matrix" type="CoglMatrix*"/>
			</parameters>
		</function>
		<function name="set_path" symbol="cogl_set_path">
			<return-type type="void"/>
			<parameters>
				<parameter name="path" type="CoglPath*"/>
			</parameters>
		</function>
		<function name="set_projection_matrix" symbol="cogl_set_projection_matrix">
			<return-type type="void"/>
			<parameters>
				<parameter name="matrix" type="CoglMatrix*"/>
			</parameters>
		</function>
		<function name="set_source" symbol="cogl_set_source">
			<return-type type="void"/>
			<parameters>
				<parameter name="material" type="CoglHandle"/>
			</parameters>
		</function>
		<function name="set_source_color" symbol="cogl_set_source_color">
			<return-type type="void"/>
			<parameters>
				<parameter name="color" type="CoglColor*"/>
			</parameters>
		</function>
		<function name="set_source_color4f" symbol="cogl_set_source_color4f">
			<return-type type="void"/>
			<parameters>
				<parameter name="red" type="float"/>
				<parameter name="green" type="float"/>
				<parameter name="blue" type="float"/>
				<parameter name="alpha" type="float"/>
			</parameters>
		</function>
		<function name="set_source_color4ub" symbol="cogl_set_source_color4ub">
			<return-type type="void"/>
			<parameters>
				<parameter name="red" type="guint8"/>
				<parameter name="green" type="guint8"/>
				<parameter name="blue" type="guint8"/>
				<parameter name="alpha" type="guint8"/>
			</parameters>
		</function>
		<function name="set_source_texture" symbol="cogl_set_source_texture">
			<return-type type="void"/>
			<parameters>
				<parameter name="texture_handle" type="CoglHandle"/>
			</parameters>
		</function>
		<function name="set_viewport" symbol="cogl_set_viewport">
			<return-type type="void"/>
			<parameters>
				<parameter name="x" type="int"/>
				<parameter name="y" type="int"/>
				<parameter name="width" type="int"/>
				<parameter name="height" type="int"/>
			</parameters>
		</function>
		<function name="shader_compile" symbol="cogl_shader_compile">
			<return-type type="void"/>
			<parameters>
				<parameter name="handle" type="CoglHandle"/>
			</parameters>
		</function>
		<function name="shader_get_info_log" symbol="cogl_shader_get_info_log">
			<return-type type="char*"/>
			<parameters>
				<parameter name="handle" type="CoglHandle"/>
			</parameters>
		</function>
		<function name="shader_get_type" symbol="cogl_shader_get_type">
			<return-type type="CoglShaderType"/>
			<parameters>
				<parameter name="handle" type="CoglHandle"/>
			</parameters>
		</function>
		<function name="shader_is_compiled" symbol="cogl_shader_is_compiled">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="handle" type="CoglHandle"/>
			</parameters>
		</function>
		<function name="shader_ref" symbol="cogl_shader_ref">
			<return-type type="CoglHandle"/>
			<parameters>
				<parameter name="handle" type="CoglHandle"/>
			</parameters>
		</function>
		<function name="shader_source" symbol="cogl_shader_source">
			<return-type type="void"/>
			<parameters>
				<parameter name="shader" type="CoglHandle"/>
				<parameter name="source" type="char*"/>
			</parameters>
		</function>
		<function name="shader_type_get_type" symbol="cogl_shader_type_get_type">
			<return-type type="GType"/>
		</function>
		<function name="shader_unref" symbol="cogl_shader_unref">
			<return-type type="void"/>
			<parameters>
				<parameter name="handle" type="CoglHandle"/>
			</parameters>
		</function>
		<function name="sqrti" symbol="cogl_sqrti">
			<return-type type="int"/>
			<parameters>
				<parameter name="x" type="int"/>
			</parameters>
		</function>
		<function name="texture_3d_new_from_data_EXP" symbol="cogl_texture_3d_new_from_data_EXP">
			<return-type type="CoglHandle"/>
			<parameters>
				<parameter name="width" type="unsigned"/>
				<parameter name="height" type="unsigned"/>
				<parameter name="depth" type="unsigned"/>
				<parameter name="flags" type="CoglTextureFlags"/>
				<parameter name="format" type="CoglPixelFormat"/>
				<parameter name="internal_format" type="CoglPixelFormat"/>
				<parameter name="rowstride" type="unsigned"/>
				<parameter name="image_stride" type="unsigned"/>
				<parameter name="data" type="guint8*"/>
				<parameter name="error" type="GError**"/>
			</parameters>
		</function>
		<function name="texture_3d_new_with_size_EXP" symbol="cogl_texture_3d_new_with_size_EXP">
			<return-type type="CoglHandle"/>
			<parameters>
				<parameter name="width" type="unsigned"/>
				<parameter name="height" type="unsigned"/>
				<parameter name="depth" type="unsigned"/>
				<parameter name="flags" type="CoglTextureFlags"/>
				<parameter name="internal_format" type="CoglPixelFormat"/>
				<parameter name="error" type="GError**"/>
			</parameters>
		</function>
		<function name="texture_flags_get_type" symbol="cogl_texture_flags_get_type">
			<return-type type="GType"/>
		</function>
		<function name="texture_get_data" symbol="cogl_texture_get_data">
			<return-type type="int"/>
			<parameters>
				<parameter name="handle" type="CoglHandle"/>
				<parameter name="format" type="CoglPixelFormat"/>
				<parameter name="rowstride" type="unsigned"/>
				<parameter name="data" type="guint8*"/>
			</parameters>
		</function>
		<function name="texture_get_format" symbol="cogl_texture_get_format">
			<return-type type="CoglPixelFormat"/>
			<parameters>
				<parameter name="handle" type="CoglHandle"/>
			</parameters>
		</function>
		<function name="texture_get_gl_texture" symbol="cogl_texture_get_gl_texture">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="handle" type="CoglHandle"/>
				<parameter name="out_gl_handle" type="GLuint*"/>
				<parameter name="out_gl_target" type="GLenum*"/>
			</parameters>
		</function>
		<function name="texture_get_height" symbol="cogl_texture_get_height">
			<return-type type="unsigned"/>
			<parameters>
				<parameter name="handle" type="CoglHandle"/>
			</parameters>
		</function>
		<function name="texture_get_max_waste" symbol="cogl_texture_get_max_waste">
			<return-type type="int"/>
			<parameters>
				<parameter name="handle" type="CoglHandle"/>
			</parameters>
		</function>
		<function name="texture_get_rowstride" symbol="cogl_texture_get_rowstride">
			<return-type type="unsigned"/>
			<parameters>
				<parameter name="handle" type="CoglHandle"/>
			</parameters>
		</function>
		<function name="texture_get_width" symbol="cogl_texture_get_width">
			<return-type type="unsigned"/>
			<parameters>
				<parameter name="handle" type="CoglHandle"/>
			</parameters>
		</function>
		<function name="texture_is_sliced" symbol="cogl_texture_is_sliced">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="handle" type="CoglHandle"/>
			</parameters>
		</function>
		<function name="texture_new_from_bitmap" symbol="cogl_texture_new_from_bitmap">
			<return-type type="CoglHandle"/>
			<parameters>
				<parameter name="bmp_handle" type="CoglHandle"/>
				<parameter name="flags" type="CoglTextureFlags"/>
				<parameter name="internal_format" type="CoglPixelFormat"/>
			</parameters>
		</function>
		<function name="texture_new_from_buffer" symbol="cogl_texture_new_from_buffer">
			<return-type type="CoglHandle"/>
			<parameters>
				<parameter name="buffer" type="CoglHandle"/>
				<parameter name="width" type="unsigned"/>
				<parameter name="height" type="unsigned"/>
				<parameter name="flags" type="CoglTextureFlags"/>
				<parameter name="format" type="CoglPixelFormat"/>
				<parameter name="internal_format" type="CoglPixelFormat"/>
				<parameter name="rowstride" type="unsigned"/>
				<parameter name="offset" type="unsigned"/>
			</parameters>
		</function>
		<function name="texture_new_from_buffer_EXP" symbol="cogl_texture_new_from_buffer_EXP">
			<return-type type="CoglHandle"/>
			<parameters>
				<parameter name="buffer" type="CoglHandle"/>
				<parameter name="width" type="unsigned"/>
				<parameter name="height" type="unsigned"/>
				<parameter name="flags" type="CoglTextureFlags"/>
				<parameter name="format" type="CoglPixelFormat"/>
				<parameter name="internal_format" type="CoglPixelFormat"/>
				<parameter name="rowstride" type="unsigned"/>
				<parameter name="offset" type="unsigned"/>
			</parameters>
		</function>
		<function name="texture_new_from_data" symbol="cogl_texture_new_from_data">
			<return-type type="CoglHandle"/>
			<parameters>
				<parameter name="width" type="unsigned"/>
				<parameter name="height" type="unsigned"/>
				<parameter name="flags" type="CoglTextureFlags"/>
				<parameter name="format" type="CoglPixelFormat"/>
				<parameter name="internal_format" type="CoglPixelFormat"/>
				<parameter name="rowstride" type="unsigned"/>
				<parameter name="data" type="guint8*"/>
			</parameters>
		</function>
		<function name="texture_new_from_file" symbol="cogl_texture_new_from_file">
			<return-type type="CoglHandle"/>
			<parameters>
				<parameter name="filename" type="char*"/>
				<parameter name="flags" type="CoglTextureFlags"/>
				<parameter name="internal_format" type="CoglPixelFormat"/>
				<parameter name="error" type="GError**"/>
			</parameters>
		</function>
		<function name="texture_new_from_foreign" symbol="cogl_texture_new_from_foreign">
			<return-type type="CoglHandle"/>
			<parameters>
				<parameter name="gl_handle" type="GLuint"/>
				<parameter name="gl_target" type="GLenum"/>
				<parameter name="width" type="GLuint"/>
				<parameter name="height" type="GLuint"/>
				<parameter name="x_pot_waste" type="GLuint"/>
				<parameter name="y_pot_waste" type="GLuint"/>
				<parameter name="format" type="CoglPixelFormat"/>
			</parameters>
		</function>
		<function name="texture_new_from_sub_texture" symbol="cogl_texture_new_from_sub_texture">
			<return-type type="CoglHandle"/>
			<parameters>
				<parameter name="full_texture" type="CoglHandle"/>
				<parameter name="sub_x" type="int"/>
				<parameter name="sub_y" type="int"/>
				<parameter name="sub_width" type="int"/>
				<parameter name="sub_height" type="int"/>
			</parameters>
		</function>
		<function name="texture_new_with_size" symbol="cogl_texture_new_with_size">
			<return-type type="CoglHandle"/>
			<parameters>
				<parameter name="width" type="unsigned"/>
				<parameter name="height" type="unsigned"/>
				<parameter name="flags" type="CoglTextureFlags"/>
				<parameter name="internal_format" type="CoglPixelFormat"/>
			</parameters>
		</function>
		<function name="texture_pixmap_x11_is_using_tfp_extension_EXP" symbol="cogl_texture_pixmap_x11_is_using_tfp_extension_EXP">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="handle" type="CoglHandle"/>
			</parameters>
		</function>
		<function name="texture_pixmap_x11_new_EXP" symbol="cogl_texture_pixmap_x11_new_EXP">
			<return-type type="CoglHandle"/>
			<parameters>
				<parameter name="pixmap" type="guint32"/>
				<parameter name="automatic_updates" type="gboolean"/>
			</parameters>
		</function>
		<function name="texture_pixmap_x11_report_level_get_type" symbol="cogl_texture_pixmap_x11_report_level_get_type">
			<return-type type="GType"/>
		</function>
		<function name="texture_pixmap_x11_set_damage_object_EXP" symbol="cogl_texture_pixmap_x11_set_damage_object_EXP">
			<return-type type="void"/>
			<parameters>
				<parameter name="handle" type="CoglHandle"/>
				<parameter name="damage" type="guint32"/>
				<parameter name="report_level" type="CoglTexturePixmapX11ReportLevel"/>
			</parameters>
		</function>
		<function name="texture_pixmap_x11_update_area_EXP" symbol="cogl_texture_pixmap_x11_update_area_EXP">
			<return-type type="void"/>
			<parameters>
				<parameter name="handle" type="CoglHandle"/>
				<parameter name="x" type="int"/>
				<parameter name="y" type="int"/>
				<parameter name="width" type="int"/>
				<parameter name="height" type="int"/>
			</parameters>
		</function>
		<function name="texture_ref" symbol="cogl_texture_ref">
			<return-type type="CoglHandle"/>
			<parameters>
				<parameter name="handle" type="CoglHandle"/>
			</parameters>
		</function>
		<function name="texture_set_region" symbol="cogl_texture_set_region">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="handle" type="CoglHandle"/>
				<parameter name="src_x" type="int"/>
				<parameter name="src_y" type="int"/>
				<parameter name="dst_x" type="int"/>
				<parameter name="dst_y" type="int"/>
				<parameter name="dst_width" type="unsigned"/>
				<parameter name="dst_height" type="unsigned"/>
				<parameter name="width" type="int"/>
				<parameter name="height" type="int"/>
				<parameter name="format" type="CoglPixelFormat"/>
				<parameter name="rowstride" type="unsigned"/>
				<parameter name="data" type="guint8*"/>
			</parameters>
		</function>
		<function name="texture_unref" symbol="cogl_texture_unref">
			<return-type type="void"/>
			<parameters>
				<parameter name="handle" type="CoglHandle"/>
			</parameters>
		</function>
		<function name="transform" symbol="cogl_transform">
			<return-type type="void"/>
			<parameters>
				<parameter name="matrix" type="CoglMatrix*"/>
			</parameters>
		</function>
		<function name="translate" symbol="cogl_translate">
			<return-type type="void"/>
			<parameters>
				<parameter name="x" type="float"/>
				<parameter name="y" type="float"/>
				<parameter name="z" type="float"/>
			</parameters>
		</function>
		<function name="vertex_buffer_add" symbol="cogl_vertex_buffer_add">
			<return-type type="void"/>
			<parameters>
				<parameter name="handle" type="CoglHandle"/>
				<parameter name="attribute_name" type="char*"/>
				<parameter name="n_components" type="guint8"/>
				<parameter name="type" type="CoglAttributeType"/>
				<parameter name="normalized" type="gboolean"/>
				<parameter name="stride" type="guint16"/>
				<parameter name="pointer" type="void*"/>
			</parameters>
		</function>
		<function name="vertex_buffer_delete" symbol="cogl_vertex_buffer_delete">
			<return-type type="void"/>
			<parameters>
				<parameter name="handle" type="CoglHandle"/>
				<parameter name="attribute_name" type="char*"/>
			</parameters>
		</function>
		<function name="vertex_buffer_disable" symbol="cogl_vertex_buffer_disable">
			<return-type type="void"/>
			<parameters>
				<parameter name="handle" type="CoglHandle"/>
				<parameter name="attribute_name" type="char*"/>
			</parameters>
		</function>
		<function name="vertex_buffer_draw" symbol="cogl_vertex_buffer_draw">
			<return-type type="void"/>
			<parameters>
				<parameter name="handle" type="CoglHandle"/>
				<parameter name="mode" type="CoglVerticesMode"/>
				<parameter name="first" type="int"/>
				<parameter name="count" type="int"/>
			</parameters>
		</function>
		<function name="vertex_buffer_draw_elements" symbol="cogl_vertex_buffer_draw_elements">
			<return-type type="void"/>
			<parameters>
				<parameter name="handle" type="CoglHandle"/>
				<parameter name="mode" type="CoglVerticesMode"/>
				<parameter name="indices" type="CoglHandle"/>
				<parameter name="min_index" type="int"/>
				<parameter name="max_index" type="int"/>
				<parameter name="indices_offset" type="int"/>
				<parameter name="count" type="int"/>
			</parameters>
		</function>
		<function name="vertex_buffer_enable" symbol="cogl_vertex_buffer_enable">
			<return-type type="void"/>
			<parameters>
				<parameter name="handle" type="CoglHandle"/>
				<parameter name="attribute_name" type="char*"/>
			</parameters>
		</function>
		<function name="vertex_buffer_get_n_vertices" symbol="cogl_vertex_buffer_get_n_vertices">
			<return-type type="unsigned"/>
			<parameters>
				<parameter name="handle" type="CoglHandle"/>
			</parameters>
		</function>
		<function name="vertex_buffer_indices_get_for_quads" symbol="cogl_vertex_buffer_indices_get_for_quads">
			<return-type type="CoglHandle"/>
			<parameters>
				<parameter name="n_indices" type="unsigned"/>
			</parameters>
		</function>
		<function name="vertex_buffer_indices_get_type" symbol="cogl_vertex_buffer_indices_get_type">
			<return-type type="CoglIndicesType"/>
			<parameters>
				<parameter name="indices" type="CoglHandle"/>
			</parameters>
		</function>
		<function name="vertex_buffer_indices_new" symbol="cogl_vertex_buffer_indices_new">
			<return-type type="CoglHandle"/>
			<parameters>
				<parameter name="indices_type" type="CoglIndicesType"/>
				<parameter name="indices_array" type="void*"/>
				<parameter name="indices_len" type="int"/>
			</parameters>
		</function>
		<function name="vertex_buffer_new" symbol="cogl_vertex_buffer_new">
			<return-type type="CoglHandle"/>
			<parameters>
				<parameter name="n_vertices" type="unsigned"/>
			</parameters>
		</function>
		<function name="vertex_buffer_ref" symbol="cogl_vertex_buffer_ref">
			<return-type type="CoglHandle"/>
			<parameters>
				<parameter name="handle" type="CoglHandle"/>
			</parameters>
		</function>
		<function name="vertex_buffer_submit" symbol="cogl_vertex_buffer_submit">
			<return-type type="void"/>
			<parameters>
				<parameter name="handle" type="CoglHandle"/>
			</parameters>
		</function>
		<function name="vertex_buffer_unref" symbol="cogl_vertex_buffer_unref">
			<return-type type="void"/>
			<parameters>
				<parameter name="handle" type="CoglHandle"/>
			</parameters>
		</function>
		<function name="vertices_mode_get_type" symbol="cogl_vertices_mode_get_type">
			<return-type type="GType"/>
		</function>
		<function name="viewport" symbol="cogl_viewport">
			<return-type type="void"/>
			<parameters>
				<parameter name="width" type="unsigned"/>
				<parameter name="height" type="unsigned"/>
			</parameters>
		</function>
		<callback name="CoglFuncPtr">
			<return-type type="void"/>
		</callback>
		<callback name="CoglMaterialLayerCallback">
			<return-type type="gboolean"/>
			<parameters>
				<parameter name="material" type="CoglMaterial*"/>
				<parameter name="layer_index" type="int"/>
				<parameter name="user_data" type="void*"/>
			</parameters>
		</callback>
		<callback name="CoglUserDataDestroyCallback">
			<return-type type="void"/>
			<parameters>
				<parameter name="user_data" type="void*"/>
			</parameters>
		</callback>
		<struct name="CoglAngle">
			<method name="cos" symbol="cogl_angle_cos">
				<return-type type="CoglFixed"/>
				<parameters>
					<parameter name="angle" type="CoglAngle"/>
				</parameters>
			</method>
			<method name="sin" symbol="cogl_angle_sin">
				<return-type type="CoglFixed"/>
				<parameters>
					<parameter name="angle" type="CoglAngle"/>
				</parameters>
			</method>
			<method name="tan" symbol="cogl_angle_tan">
				<return-type type="CoglFixed"/>
				<parameters>
					<parameter name="angle" type="CoglAngle"/>
				</parameters>
			</method>
		</struct>
		<struct name="CoglBitmap">
			<method name="error_get_type" symbol="cogl_bitmap_error_get_type">
				<return-type type="GType"/>
			</method>
			<method name="error_quark" symbol="cogl_bitmap_error_quark">
				<return-type type="GQuark"/>
			</method>
			<method name="get_size_from_file" symbol="cogl_bitmap_get_size_from_file">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="filename" type="char*"/>
					<parameter name="width" type="int*"/>
					<parameter name="height" type="int*"/>
				</parameters>
			</method>
			<method name="new_from_file" symbol="cogl_bitmap_new_from_file">
				<return-type type="CoglBitmap*"/>
				<parameters>
					<parameter name="filename" type="char*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
		</struct>
		<struct name="CoglBuffer">
			<method name="access_get_type" symbol="cogl_buffer_access_get_type">
				<return-type type="GType"/>
			</method>
			<method name="bit_get_type" symbol="cogl_buffer_bit_get_type">
				<return-type type="GType"/>
			</method>
			<method name="get_size_EXP" symbol="cogl_buffer_get_size_EXP">
				<return-type type="unsigned"/>
				<parameters>
					<parameter name="buffer" type="CoglBuffer*"/>
				</parameters>
			</method>
			<method name="get_update_hint_EXP" symbol="cogl_buffer_get_update_hint_EXP">
				<return-type type="CoglBufferUpdateHint"/>
				<parameters>
					<parameter name="buffer" type="CoglBuffer*"/>
				</parameters>
			</method>
			<method name="map_EXP" symbol="cogl_buffer_map_EXP">
				<return-type type="guint8*"/>
				<parameters>
					<parameter name="buffer" type="CoglBuffer*"/>
					<parameter name="access" type="CoglBufferAccess"/>
					<parameter name="hints" type="CoglBufferMapHint"/>
				</parameters>
			</method>
			<method name="map_hint_get_type" symbol="cogl_buffer_map_hint_get_type">
				<return-type type="GType"/>
			</method>
			<method name="set_data_EXP" symbol="cogl_buffer_set_data_EXP">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="buffer" type="CoglBuffer*"/>
					<parameter name="offset" type="gsize"/>
					<parameter name="data" type="guint8*"/>
					<parameter name="size" type="gsize"/>
				</parameters>
			</method>
			<method name="set_update_hint_EXP" symbol="cogl_buffer_set_update_hint_EXP">
				<return-type type="void"/>
				<parameters>
					<parameter name="buffer" type="CoglBuffer*"/>
					<parameter name="hint" type="CoglBufferUpdateHint"/>
				</parameters>
			</method>
			<method name="target_get_type" symbol="cogl_buffer_target_get_type">
				<return-type type="GType"/>
			</method>
			<method name="unmap_EXP" symbol="cogl_buffer_unmap_EXP">
				<return-type type="void"/>
				<parameters>
					<parameter name="buffer" type="CoglBuffer*"/>
				</parameters>
			</method>
			<method name="update_hint_get_type" symbol="cogl_buffer_update_hint_get_type">
				<return-type type="GType"/>
			</method>
		</struct>
		<struct name="CoglColor">
			<method name="copy" symbol="cogl_color_copy">
				<return-type type="CoglColor*"/>
				<parameters>
					<parameter name="color" type="CoglColor*"/>
				</parameters>
			</method>
			<method name="equal" symbol="cogl_color_equal">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="v1" type="gconstpointer"/>
					<parameter name="v2" type="gconstpointer"/>
				</parameters>
			</method>
			<method name="free" symbol="cogl_color_free">
				<return-type type="void"/>
				<parameters>
					<parameter name="color" type="CoglColor*"/>
				</parameters>
			</method>
			<method name="get_alpha" symbol="cogl_color_get_alpha">
				<return-type type="float"/>
				<parameters>
					<parameter name="color" type="CoglColor*"/>
				</parameters>
			</method>
			<method name="get_alpha_byte" symbol="cogl_color_get_alpha_byte">
				<return-type type="unsigned"/>
				<parameters>
					<parameter name="color" type="CoglColor*"/>
				</parameters>
			</method>
			<method name="get_alpha_float" symbol="cogl_color_get_alpha_float">
				<return-type type="float"/>
				<parameters>
					<parameter name="color" type="CoglColor*"/>
				</parameters>
			</method>
			<method name="get_blue" symbol="cogl_color_get_blue">
				<return-type type="float"/>
				<parameters>
					<parameter name="color" type="CoglColor*"/>
				</parameters>
			</method>
			<method name="get_blue_byte" symbol="cogl_color_get_blue_byte">
				<return-type type="unsigned"/>
				<parameters>
					<parameter name="color" type="CoglColor*"/>
				</parameters>
			</method>
			<method name="get_blue_float" symbol="cogl_color_get_blue_float">
				<return-type type="float"/>
				<parameters>
					<parameter name="color" type="CoglColor*"/>
				</parameters>
			</method>
			<method name="get_green" symbol="cogl_color_get_green">
				<return-type type="float"/>
				<parameters>
					<parameter name="color" type="CoglColor*"/>
				</parameters>
			</method>
			<method name="get_green_byte" symbol="cogl_color_get_green_byte">
				<return-type type="unsigned"/>
				<parameters>
					<parameter name="color" type="CoglColor*"/>
				</parameters>
			</method>
			<method name="get_green_float" symbol="cogl_color_get_green_float">
				<return-type type="float"/>
				<parameters>
					<parameter name="color" type="CoglColor*"/>
				</parameters>
			</method>
			<method name="get_red" symbol="cogl_color_get_red">
				<return-type type="float"/>
				<parameters>
					<parameter name="color" type="CoglColor*"/>
				</parameters>
			</method>
			<method name="get_red_byte" symbol="cogl_color_get_red_byte">
				<return-type type="unsigned"/>
				<parameters>
					<parameter name="color" type="CoglColor*"/>
				</parameters>
			</method>
			<method name="get_red_float" symbol="cogl_color_get_red_float">
				<return-type type="float"/>
				<parameters>
					<parameter name="color" type="CoglColor*"/>
				</parameters>
			</method>
			<method name="init_from_4f" symbol="cogl_color_init_from_4f">
				<return-type type="void"/>
				<parameters>
					<parameter name="color" type="CoglColor*"/>
					<parameter name="red" type="float"/>
					<parameter name="green" type="float"/>
					<parameter name="blue" type="float"/>
					<parameter name="alpha" type="float"/>
				</parameters>
			</method>
			<method name="init_from_4fv" symbol="cogl_color_init_from_4fv">
				<return-type type="void"/>
				<parameters>
					<parameter name="color" type="CoglColor*"/>
					<parameter name="color_array" type="float*"/>
				</parameters>
			</method>
			<method name="init_from_4ub" symbol="cogl_color_init_from_4ub">
				<return-type type="void"/>
				<parameters>
					<parameter name="color" type="CoglColor*"/>
					<parameter name="red" type="guint8"/>
					<parameter name="green" type="guint8"/>
					<parameter name="blue" type="guint8"/>
					<parameter name="alpha" type="guint8"/>
				</parameters>
			</method>
			<method name="new" symbol="cogl_color_new">
				<return-type type="CoglColor*"/>
			</method>
			<method name="premultiply" symbol="cogl_color_premultiply">
				<return-type type="void"/>
				<parameters>
					<parameter name="color" type="CoglColor*"/>
				</parameters>
			</method>
			<method name="set_alpha" symbol="cogl_color_set_alpha">
				<return-type type="void"/>
				<parameters>
					<parameter name="color" type="CoglColor*"/>
					<parameter name="alpha" type="float"/>
				</parameters>
			</method>
			<method name="set_alpha_byte" symbol="cogl_color_set_alpha_byte">
				<return-type type="void"/>
				<parameters>
					<parameter name="color" type="CoglColor*"/>
					<parameter name="alpha" type="unsigned"/>
				</parameters>
			</method>
			<method name="set_alpha_float" symbol="cogl_color_set_alpha_float">
				<return-type type="void"/>
				<parameters>
					<parameter name="color" type="CoglColor*"/>
					<parameter name="alpha" type="float"/>
				</parameters>
			</method>
			<method name="set_blue" symbol="cogl_color_set_blue">
				<return-type type="void"/>
				<parameters>
					<parameter name="color" type="CoglColor*"/>
					<parameter name="blue" type="float"/>
				</parameters>
			</method>
			<method name="set_blue_byte" symbol="cogl_color_set_blue_byte">
				<return-type type="void"/>
				<parameters>
					<parameter name="color" type="CoglColor*"/>
					<parameter name="blue" type="unsigned"/>
				</parameters>
			</method>
			<method name="set_blue_float" symbol="cogl_color_set_blue_float">
				<return-type type="void"/>
				<parameters>
					<parameter name="color" type="CoglColor*"/>
					<parameter name="blue" type="float"/>
				</parameters>
			</method>
			<method name="set_from_4f" symbol="cogl_color_set_from_4f">
				<return-type type="void"/>
				<parameters>
					<parameter name="color" type="CoglColor*"/>
					<parameter name="red" type="float"/>
					<parameter name="green" type="float"/>
					<parameter name="blue" type="float"/>
					<parameter name="alpha" type="float"/>
				</parameters>
			</method>
			<method name="set_from_4ub" symbol="cogl_color_set_from_4ub">
				<return-type type="void"/>
				<parameters>
					<parameter name="color" type="CoglColor*"/>
					<parameter name="red" type="guint8"/>
					<parameter name="green" type="guint8"/>
					<parameter name="blue" type="guint8"/>
					<parameter name="alpha" type="guint8"/>
				</parameters>
			</method>
			<method name="set_green" symbol="cogl_color_set_green">
				<return-type type="void"/>
				<parameters>
					<parameter name="color" type="CoglColor*"/>
					<parameter name="green" type="float"/>
				</parameters>
			</method>
			<method name="set_green_byte" symbol="cogl_color_set_green_byte">
				<return-type type="void"/>
				<parameters>
					<parameter name="color" type="CoglColor*"/>
					<parameter name="green" type="unsigned"/>
				</parameters>
			</method>
			<method name="set_green_float" symbol="cogl_color_set_green_float">
				<return-type type="void"/>
				<parameters>
					<parameter name="color" type="CoglColor*"/>
					<parameter name="green" type="float"/>
				</parameters>
			</method>
			<method name="set_red" symbol="cogl_color_set_red">
				<return-type type="void"/>
				<parameters>
					<parameter name="color" type="CoglColor*"/>
					<parameter name="red" type="float"/>
				</parameters>
			</method>
			<method name="set_red_byte" symbol="cogl_color_set_red_byte">
				<return-type type="void"/>
				<parameters>
					<parameter name="color" type="CoglColor*"/>
					<parameter name="red" type="unsigned"/>
				</parameters>
			</method>
			<method name="set_red_float" symbol="cogl_color_set_red_float">
				<return-type type="void"/>
				<parameters>
					<parameter name="color" type="CoglColor*"/>
					<parameter name="red" type="float"/>
				</parameters>
			</method>
			<method name="unpremultiply" symbol="cogl_color_unpremultiply">
				<return-type type="void"/>
				<parameters>
					<parameter name="color" type="CoglColor*"/>
				</parameters>
			</method>
			<field name="red" type="guint8"/>
			<field name="green" type="guint8"/>
			<field name="blue" type="guint8"/>
			<field name="alpha" type="guint8"/>
			<field name="padding0" type="guint32"/>
			<field name="padding1" type="guint32"/>
			<field name="padding2" type="guint32"/>
		</struct>
		<struct name="CoglFixed">
			<method name="atan" symbol="cogl_fixed_atan">
				<return-type type="CoglFixed"/>
				<parameters>
					<parameter name="a" type="CoglFixed"/>
				</parameters>
			</method>
			<method name="atan2" symbol="cogl_fixed_atan2">
				<return-type type="CoglFixed"/>
				<parameters>
					<parameter name="a" type="CoglFixed"/>
					<parameter name="b" type="CoglFixed"/>
				</parameters>
			</method>
			<method name="cos" symbol="cogl_fixed_cos">
				<return-type type="CoglFixed"/>
				<parameters>
					<parameter name="angle" type="CoglFixed"/>
				</parameters>
			</method>
			<method name="div" symbol="cogl_fixed_div">
				<return-type type="CoglFixed"/>
				<parameters>
					<parameter name="a" type="CoglFixed"/>
					<parameter name="b" type="CoglFixed"/>
				</parameters>
			</method>
			<method name="log2" symbol="cogl_fixed_log2">
				<return-type type="CoglFixed"/>
				<parameters>
					<parameter name="x" type="unsigned"/>
				</parameters>
			</method>
			<method name="mul" symbol="cogl_fixed_mul">
				<return-type type="CoglFixed"/>
				<parameters>
					<parameter name="a" type="CoglFixed"/>
					<parameter name="b" type="CoglFixed"/>
				</parameters>
			</method>
			<method name="mul_div" symbol="cogl_fixed_mul_div">
				<return-type type="CoglFixed"/>
				<parameters>
					<parameter name="a" type="CoglFixed"/>
					<parameter name="b" type="CoglFixed"/>
					<parameter name="c" type="CoglFixed"/>
				</parameters>
			</method>
			<method name="pow" symbol="cogl_fixed_pow">
				<return-type type="unsigned"/>
				<parameters>
					<parameter name="x" type="unsigned"/>
					<parameter name="y" type="CoglFixed"/>
				</parameters>
			</method>
			<method name="pow2" symbol="cogl_fixed_pow2">
				<return-type type="unsigned"/>
				<parameters>
					<parameter name="x" type="CoglFixed"/>
				</parameters>
			</method>
			<method name="sin" symbol="cogl_fixed_sin">
				<return-type type="CoglFixed"/>
				<parameters>
					<parameter name="angle" type="CoglFixed"/>
				</parameters>
			</method>
			<method name="sqrt" symbol="cogl_fixed_sqrt">
				<return-type type="CoglFixed"/>
				<parameters>
					<parameter name="x" type="CoglFixed"/>
				</parameters>
			</method>
			<method name="tan" symbol="cogl_fixed_tan">
				<return-type type="CoglFixed"/>
				<parameters>
					<parameter name="angle" type="CoglFixed"/>
				</parameters>
			</method>
		</struct>
		<struct name="CoglFramebuffer">
		</struct>
		<struct name="CoglHandle">
			<method name="ref" symbol="cogl_handle_ref">
				<return-type type="CoglHandle"/>
				<parameters>
					<parameter name="handle" type="CoglHandle"/>
				</parameters>
			</method>
			<method name="unref" symbol="cogl_handle_unref">
				<return-type type="void"/>
				<parameters>
					<parameter name="handle" type="CoglHandle"/>
				</parameters>
			</method>
		</struct>
		<struct name="CoglMaterial">
			<method name="alpha_func_get_type" symbol="cogl_material_alpha_func_get_type">
				<return-type type="GType"/>
			</method>
			<method name="copy" symbol="cogl_material_copy">
				<return-type type="CoglMaterial*"/>
				<parameters>
					<parameter name="source" type="CoglMaterial*"/>
				</parameters>
			</method>
			<method name="filter_get_type" symbol="cogl_material_filter_get_type">
				<return-type type="GType"/>
			</method>
			<method name="foreach_layer" symbol="cogl_material_foreach_layer">
				<return-type type="void"/>
				<parameters>
					<parameter name="material" type="CoglMaterial*"/>
					<parameter name="callback" type="CoglMaterialLayerCallback"/>
					<parameter name="user_data" type="void*"/>
				</parameters>
			</method>
			<method name="get_ambient" symbol="cogl_material_get_ambient">
				<return-type type="void"/>
				<parameters>
					<parameter name="material" type="CoglMaterial*"/>
					<parameter name="ambient" type="CoglColor*"/>
				</parameters>
			</method>
			<method name="get_color" symbol="cogl_material_get_color">
				<return-type type="void"/>
				<parameters>
					<parameter name="material" type="CoglMaterial*"/>
					<parameter name="color" type="CoglColor*"/>
				</parameters>
			</method>
			<method name="get_depth_range" symbol="cogl_material_get_depth_range">
				<return-type type="void"/>
				<parameters>
					<parameter name="material" type="CoglMaterial*"/>
					<parameter name="near_val" type="float*"/>
					<parameter name="far_val" type="float*"/>
				</parameters>
			</method>
			<method name="get_depth_test_enabled" symbol="cogl_material_get_depth_test_enabled">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="material" type="CoglMaterial*"/>
				</parameters>
			</method>
			<method name="get_depth_test_function" symbol="cogl_material_get_depth_test_function">
				<return-type type="CoglDepthTestFunction"/>
				<parameters>
					<parameter name="material" type="CoglMaterial*"/>
				</parameters>
			</method>
			<method name="get_depth_writing_enabled" symbol="cogl_material_get_depth_writing_enabled">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="material" type="CoglMaterial*"/>
				</parameters>
			</method>
			<method name="get_diffuse" symbol="cogl_material_get_diffuse">
				<return-type type="void"/>
				<parameters>
					<parameter name="material" type="CoglMaterial*"/>
					<parameter name="diffuse" type="CoglColor*"/>
				</parameters>
			</method>
			<method name="get_emission" symbol="cogl_material_get_emission">
				<return-type type="void"/>
				<parameters>
					<parameter name="material" type="CoglMaterial*"/>
					<parameter name="emission" type="CoglColor*"/>
				</parameters>
			</method>
			<method name="get_layer_point_sprite_coords_enabled" symbol="cogl_material_get_layer_point_sprite_coords_enabled">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="material" type="CoglMaterial*"/>
					<parameter name="layer_index" type="int"/>
				</parameters>
			</method>
			<method name="get_layers" symbol="cogl_material_get_layers">
				<return-type type="GList*"/>
				<parameters>
					<parameter name="material" type="CoglMaterial*"/>
				</parameters>
			</method>
			<method name="get_n_layers" symbol="cogl_material_get_n_layers">
				<return-type type="int"/>
				<parameters>
					<parameter name="material" type="CoglMaterial*"/>
				</parameters>
			</method>
			<method name="get_point_size" symbol="cogl_material_get_point_size">
				<return-type type="float"/>
				<parameters>
					<parameter name="material" type="CoglHandle"/>
				</parameters>
			</method>
			<method name="get_shininess" symbol="cogl_material_get_shininess">
				<return-type type="float"/>
				<parameters>
					<parameter name="material" type="CoglMaterial*"/>
				</parameters>
			</method>
			<method name="get_specular" symbol="cogl_material_get_specular">
				<return-type type="void"/>
				<parameters>
					<parameter name="material" type="CoglMaterial*"/>
					<parameter name="specular" type="CoglColor*"/>
				</parameters>
			</method>
			<method name="get_user_program" symbol="cogl_material_get_user_program">
				<return-type type="CoglHandle"/>
				<parameters>
					<parameter name="material" type="CoglMaterial*"/>
				</parameters>
			</method>
			<method name="new" symbol="cogl_material_new">
				<return-type type="CoglMaterial*"/>
			</method>
			<method name="ref" symbol="cogl_material_ref">
				<return-type type="CoglHandle"/>
				<parameters>
					<parameter name="handle" type="CoglHandle"/>
				</parameters>
			</method>
			<method name="remove_layer" symbol="cogl_material_remove_layer">
				<return-type type="void"/>
				<parameters>
					<parameter name="material" type="CoglMaterial*"/>
					<parameter name="layer_index" type="int"/>
				</parameters>
			</method>
			<method name="set_alpha_test_function" symbol="cogl_material_set_alpha_test_function">
				<return-type type="void"/>
				<parameters>
					<parameter name="material" type="CoglMaterial*"/>
					<parameter name="alpha_func" type="CoglMaterialAlphaFunc"/>
					<parameter name="alpha_reference" type="float"/>
				</parameters>
			</method>
			<method name="set_ambient" symbol="cogl_material_set_ambient">
				<return-type type="void"/>
				<parameters>
					<parameter name="material" type="CoglMaterial*"/>
					<parameter name="ambient" type="CoglColor*"/>
				</parameters>
			</method>
			<method name="set_ambient_and_diffuse" symbol="cogl_material_set_ambient_and_diffuse">
				<return-type type="void"/>
				<parameters>
					<parameter name="material" type="CoglMaterial*"/>
					<parameter name="color" type="CoglColor*"/>
				</parameters>
			</method>
			<method name="set_blend" symbol="cogl_material_set_blend">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="material" type="CoglMaterial*"/>
					<parameter name="blend_string" type="char*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="set_blend_constant" symbol="cogl_material_set_blend_constant">
				<return-type type="void"/>
				<parameters>
					<parameter name="material" type="CoglMaterial*"/>
					<parameter name="constant_color" type="CoglColor*"/>
				</parameters>
			</method>
			<method name="set_color" symbol="cogl_material_set_color">
				<return-type type="void"/>
				<parameters>
					<parameter name="material" type="CoglMaterial*"/>
					<parameter name="color" type="CoglColor*"/>
				</parameters>
			</method>
			<method name="set_color4f" symbol="cogl_material_set_color4f">
				<return-type type="void"/>
				<parameters>
					<parameter name="material" type="CoglMaterial*"/>
					<parameter name="red" type="float"/>
					<parameter name="green" type="float"/>
					<parameter name="blue" type="float"/>
					<parameter name="alpha" type="float"/>
				</parameters>
			</method>
			<method name="set_color4ub" symbol="cogl_material_set_color4ub">
				<return-type type="void"/>
				<parameters>
					<parameter name="material" type="CoglMaterial*"/>
					<parameter name="red" type="guint8"/>
					<parameter name="green" type="guint8"/>
					<parameter name="blue" type="guint8"/>
					<parameter name="alpha" type="guint8"/>
				</parameters>
			</method>
			<method name="set_depth_range" symbol="cogl_material_set_depth_range">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="material" type="CoglMaterial*"/>
					<parameter name="near_val" type="float"/>
					<parameter name="far_val" type="float"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="set_depth_test_enabled" symbol="cogl_material_set_depth_test_enabled">
				<return-type type="void"/>
				<parameters>
					<parameter name="material" type="CoglMaterial*"/>
					<parameter name="enable" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_depth_test_function" symbol="cogl_material_set_depth_test_function">
				<return-type type="void"/>
				<parameters>
					<parameter name="material" type="CoglMaterial*"/>
					<parameter name="function" type="CoglDepthTestFunction"/>
				</parameters>
			</method>
			<method name="set_depth_writing_enabled" symbol="cogl_material_set_depth_writing_enabled">
				<return-type type="void"/>
				<parameters>
					<parameter name="material" type="CoglMaterial*"/>
					<parameter name="enable" type="gboolean"/>
				</parameters>
			</method>
			<method name="set_diffuse" symbol="cogl_material_set_diffuse">
				<return-type type="void"/>
				<parameters>
					<parameter name="material" type="CoglMaterial*"/>
					<parameter name="diffuse" type="CoglColor*"/>
				</parameters>
			</method>
			<method name="set_emission" symbol="cogl_material_set_emission">
				<return-type type="void"/>
				<parameters>
					<parameter name="material" type="CoglMaterial*"/>
					<parameter name="emission" type="CoglColor*"/>
				</parameters>
			</method>
			<method name="set_layer" symbol="cogl_material_set_layer">
				<return-type type="void"/>
				<parameters>
					<parameter name="material" type="CoglMaterial*"/>
					<parameter name="layer_index" type="int"/>
					<parameter name="texture" type="CoglHandle"/>
				</parameters>
			</method>
			<method name="set_layer_combine" symbol="cogl_material_set_layer_combine">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="material" type="CoglMaterial*"/>
					<parameter name="layer_index" type="int"/>
					<parameter name="blend_string" type="char*"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="set_layer_combine_constant" symbol="cogl_material_set_layer_combine_constant">
				<return-type type="void"/>
				<parameters>
					<parameter name="material" type="CoglMaterial*"/>
					<parameter name="layer_index" type="int"/>
					<parameter name="constant" type="CoglColor*"/>
				</parameters>
			</method>
			<method name="set_layer_filters" symbol="cogl_material_set_layer_filters">
				<return-type type="void"/>
				<parameters>
					<parameter name="material" type="CoglMaterial*"/>
					<parameter name="layer_index" type="int"/>
					<parameter name="min_filter" type="CoglMaterialFilter"/>
					<parameter name="mag_filter" type="CoglMaterialFilter"/>
				</parameters>
			</method>
			<method name="set_layer_matrix" symbol="cogl_material_set_layer_matrix">
				<return-type type="void"/>
				<parameters>
					<parameter name="material" type="CoglMaterial*"/>
					<parameter name="layer_index" type="int"/>
					<parameter name="matrix" type="CoglMatrix*"/>
				</parameters>
			</method>
			<method name="set_layer_point_sprite_coords_enabled" symbol="cogl_material_set_layer_point_sprite_coords_enabled">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="material" type="CoglMaterial*"/>
					<parameter name="layer_index" type="int"/>
					<parameter name="enable" type="gboolean"/>
					<parameter name="error" type="GError**"/>
				</parameters>
			</method>
			<method name="set_layer_wrap_mode" symbol="cogl_material_set_layer_wrap_mode">
				<return-type type="void"/>
				<parameters>
					<parameter name="material" type="CoglMaterial*"/>
					<parameter name="layer_index" type="int"/>
					<parameter name="mode" type="CoglMaterialWrapMode"/>
				</parameters>
			</method>
			<method name="set_layer_wrap_mode_p" symbol="cogl_material_set_layer_wrap_mode_p">
				<return-type type="void"/>
				<parameters>
					<parameter name="material" type="CoglMaterial*"/>
					<parameter name="layer_index" type="int"/>
					<parameter name="mode" type="CoglMaterialWrapMode"/>
				</parameters>
			</method>
			<method name="set_layer_wrap_mode_s" symbol="cogl_material_set_layer_wrap_mode_s">
				<return-type type="void"/>
				<parameters>
					<parameter name="material" type="CoglMaterial*"/>
					<parameter name="layer_index" type="int"/>
					<parameter name="mode" type="CoglMaterialWrapMode"/>
				</parameters>
			</method>
			<method name="set_layer_wrap_mode_t" symbol="cogl_material_set_layer_wrap_mode_t">
				<return-type type="void"/>
				<parameters>
					<parameter name="material" type="CoglMaterial*"/>
					<parameter name="layer_index" type="int"/>
					<parameter name="mode" type="CoglMaterialWrapMode"/>
				</parameters>
			</method>
			<method name="set_point_size" symbol="cogl_material_set_point_size">
				<return-type type="void"/>
				<parameters>
					<parameter name="material" type="CoglHandle"/>
					<parameter name="point_size" type="float"/>
				</parameters>
			</method>
			<method name="set_shininess" symbol="cogl_material_set_shininess">
				<return-type type="void"/>
				<parameters>
					<parameter name="material" type="CoglMaterial*"/>
					<parameter name="shininess" type="float"/>
				</parameters>
			</method>
			<method name="set_specular" symbol="cogl_material_set_specular">
				<return-type type="void"/>
				<parameters>
					<parameter name="material" type="CoglMaterial*"/>
					<parameter name="specular" type="CoglColor*"/>
				</parameters>
			</method>
			<method name="set_user_program" symbol="cogl_material_set_user_program">
				<return-type type="void"/>
				<parameters>
					<parameter name="material" type="CoglMaterial*"/>
					<parameter name="program" type="CoglHandle"/>
				</parameters>
			</method>
			<method name="unref" symbol="cogl_material_unref">
				<return-type type="void"/>
				<parameters>
					<parameter name="handle" type="CoglHandle"/>
				</parameters>
			</method>
			<method name="wrap_mode_get_type" symbol="cogl_material_wrap_mode_get_type">
				<return-type type="GType"/>
			</method>
		</struct>
		<struct name="CoglMaterialLayer">
			<method name="get_mag_filter" symbol="cogl_material_layer_get_mag_filter">
				<return-type type="CoglMaterialFilter"/>
				<parameters>
					<parameter name="layer" type="CoglMaterialLayer*"/>
				</parameters>
			</method>
			<method name="get_min_filter" symbol="cogl_material_layer_get_min_filter">
				<return-type type="CoglMaterialFilter"/>
				<parameters>
					<parameter name="layer" type="CoglMaterialLayer*"/>
				</parameters>
			</method>
			<method name="get_texture" symbol="cogl_material_layer_get_texture">
				<return-type type="CoglHandle"/>
				<parameters>
					<parameter name="layer" type="CoglMaterialLayer*"/>
				</parameters>
			</method>
			<method name="get_wrap_mode_p" symbol="cogl_material_layer_get_wrap_mode_p">
				<return-type type="CoglMaterialWrapMode"/>
				<parameters>
					<parameter name="layer" type="CoglMaterialLayer*"/>
				</parameters>
			</method>
			<method name="get_wrap_mode_s" symbol="cogl_material_layer_get_wrap_mode_s">
				<return-type type="CoglMaterialWrapMode"/>
				<parameters>
					<parameter name="layer" type="CoglMaterialLayer*"/>
				</parameters>
			</method>
			<method name="get_wrap_mode_t" symbol="cogl_material_layer_get_wrap_mode_t">
				<return-type type="CoglMaterialWrapMode"/>
				<parameters>
					<parameter name="layer" type="CoglMaterialLayer*"/>
				</parameters>
			</method>
			<method name="type_get_type" symbol="cogl_material_layer_type_get_type">
				<return-type type="GType"/>
			</method>
		</struct>
		<struct name="CoglMatrix">
			<method name="equal" symbol="cogl_matrix_equal">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="v1" type="gconstpointer"/>
					<parameter name="v2" type="gconstpointer"/>
				</parameters>
			</method>
			<method name="frustum" symbol="cogl_matrix_frustum">
				<return-type type="void"/>
				<parameters>
					<parameter name="matrix" type="CoglMatrix*"/>
					<parameter name="left" type="float"/>
					<parameter name="right" type="float"/>
					<parameter name="bottom" type="float"/>
					<parameter name="top" type="float"/>
					<parameter name="z_near" type="float"/>
					<parameter name="z_far" type="float"/>
				</parameters>
			</method>
			<method name="get_array" symbol="cogl_matrix_get_array">
				<return-type type="float*"/>
				<parameters>
					<parameter name="matrix" type="CoglMatrix*"/>
				</parameters>
			</method>
			<method name="get_inverse" symbol="cogl_matrix_get_inverse">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="matrix" type="CoglMatrix*"/>
					<parameter name="inverse" type="CoglMatrix*"/>
				</parameters>
			</method>
			<method name="init_from_array" symbol="cogl_matrix_init_from_array">
				<return-type type="void"/>
				<parameters>
					<parameter name="matrix" type="CoglMatrix*"/>
					<parameter name="array" type="float*"/>
				</parameters>
			</method>
			<method name="init_identity" symbol="cogl_matrix_init_identity">
				<return-type type="void"/>
				<parameters>
					<parameter name="matrix" type="CoglMatrix*"/>
				</parameters>
			</method>
			<method name="multiply" symbol="cogl_matrix_multiply">
				<return-type type="void"/>
				<parameters>
					<parameter name="result" type="CoglMatrix*"/>
					<parameter name="a" type="CoglMatrix*"/>
					<parameter name="b" type="CoglMatrix*"/>
				</parameters>
			</method>
			<method name="ortho" symbol="cogl_matrix_ortho">
				<return-type type="void"/>
				<parameters>
					<parameter name="matrix" type="CoglMatrix*"/>
					<parameter name="left" type="float"/>
					<parameter name="right" type="float"/>
					<parameter name="bottom" type="float"/>
					<parameter name="top" type="float"/>
					<parameter name="z_near" type="float"/>
					<parameter name="z_far" type="float"/>
				</parameters>
			</method>
			<method name="perspective" symbol="cogl_matrix_perspective">
				<return-type type="void"/>
				<parameters>
					<parameter name="matrix" type="CoglMatrix*"/>
					<parameter name="fov_y" type="float"/>
					<parameter name="aspect" type="float"/>
					<parameter name="z_near" type="float"/>
					<parameter name="z_far" type="float"/>
				</parameters>
			</method>
			<method name="rotate" symbol="cogl_matrix_rotate">
				<return-type type="void"/>
				<parameters>
					<parameter name="matrix" type="CoglMatrix*"/>
					<parameter name="angle" type="float"/>
					<parameter name="x" type="float"/>
					<parameter name="y" type="float"/>
					<parameter name="z" type="float"/>
				</parameters>
			</method>
			<method name="scale" symbol="cogl_matrix_scale">
				<return-type type="void"/>
				<parameters>
					<parameter name="matrix" type="CoglMatrix*"/>
					<parameter name="sx" type="float"/>
					<parameter name="sy" type="float"/>
					<parameter name="sz" type="float"/>
				</parameters>
			</method>
			<method name="transform_point" symbol="cogl_matrix_transform_point">
				<return-type type="void"/>
				<parameters>
					<parameter name="matrix" type="CoglMatrix*"/>
					<parameter name="x" type="float*"/>
					<parameter name="y" type="float*"/>
					<parameter name="z" type="float*"/>
					<parameter name="w" type="float*"/>
				</parameters>
			</method>
			<method name="translate" symbol="cogl_matrix_translate">
				<return-type type="void"/>
				<parameters>
					<parameter name="matrix" type="CoglMatrix*"/>
					<parameter name="x" type="float"/>
					<parameter name="y" type="float"/>
					<parameter name="z" type="float"/>
				</parameters>
			</method>
			<field name="xx" type="float"/>
			<field name="yx" type="float"/>
			<field name="zx" type="float"/>
			<field name="wx" type="float"/>
			<field name="xy" type="float"/>
			<field name="yy" type="float"/>
			<field name="zy" type="float"/>
			<field name="wy" type="float"/>
			<field name="xz" type="float"/>
			<field name="yz" type="float"/>
			<field name="zz" type="float"/>
			<field name="wz" type="float"/>
			<field name="xw" type="float"/>
			<field name="yw" type="float"/>
			<field name="zw" type="float"/>
			<field name="ww" type="float"/>
			<field name="inv" type="float[]"/>
			<field name="type" type="unsigned"/>
			<field name="flags" type="unsigned"/>
			<field name="_padding3" type="unsigned"/>
		</struct>
		<struct name="CoglObject">
			<method name="get_user_data" symbol="cogl_object_get_user_data">
				<return-type type="void*"/>
				<parameters>
					<parameter name="object" type="CoglObject*"/>
					<parameter name="key" type="CoglUserDataKey*"/>
				</parameters>
			</method>
			<method name="ref" symbol="cogl_object_ref">
				<return-type type="void*"/>
				<parameters>
					<parameter name="object" type="void*"/>
				</parameters>
			</method>
			<method name="set_user_data" symbol="cogl_object_set_user_data">
				<return-type type="void"/>
				<parameters>
					<parameter name="object" type="CoglObject*"/>
					<parameter name="key" type="CoglUserDataKey*"/>
					<parameter name="user_data" type="void*"/>
					<parameter name="destroy" type="CoglUserDataDestroyCallback"/>
				</parameters>
			</method>
			<method name="unref" symbol="cogl_object_unref">
				<return-type type="void"/>
				<parameters>
					<parameter name="object" type="void*"/>
				</parameters>
			</method>
		</struct>
		<struct name="CoglPangoFontMap">
			<method name="clear_glyph_cache" symbol="cogl_pango_font_map_clear_glyph_cache">
				<return-type type="void"/>
				<parameters>
					<parameter name="fm" type="CoglPangoFontMap*"/>
				</parameters>
			</method>
			<method name="create_context" symbol="cogl_pango_font_map_create_context">
				<return-type type="PangoContext*"/>
				<parameters>
					<parameter name="fm" type="CoglPangoFontMap*"/>
				</parameters>
			</method>
			<method name="get_renderer" symbol="cogl_pango_font_map_get_renderer">
				<return-type type="PangoRenderer*"/>
				<parameters>
					<parameter name="fm" type="CoglPangoFontMap*"/>
				</parameters>
			</method>
			<method name="get_use_mipmapping" symbol="cogl_pango_font_map_get_use_mipmapping">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="fm" type="CoglPangoFontMap*"/>
				</parameters>
			</method>
			<method name="new" symbol="cogl_pango_font_map_new">
				<return-type type="PangoFontMap*"/>
			</method>
			<method name="set_resolution" symbol="cogl_pango_font_map_set_resolution">
				<return-type type="void"/>
				<parameters>
					<parameter name="font_map" type="CoglPangoFontMap*"/>
					<parameter name="dpi" type="double"/>
				</parameters>
			</method>
			<method name="set_use_mipmapping" symbol="cogl_pango_font_map_set_use_mipmapping">
				<return-type type="void"/>
				<parameters>
					<parameter name="fm" type="CoglPangoFontMap*"/>
					<parameter name="value" type="gboolean"/>
				</parameters>
			</method>
		</struct>
		<struct name="CoglPangoRenderer">
		</struct>
		<struct name="CoglPangoRendererClass">
		</struct>
		<struct name="CoglPath">
			<method name="arc" symbol="cogl_path_arc">
				<return-type type="void"/>
				<parameters>
					<parameter name="center_x" type="float"/>
					<parameter name="center_y" type="float"/>
					<parameter name="radius_x" type="float"/>
					<parameter name="radius_y" type="float"/>
					<parameter name="angle_1" type="float"/>
					<parameter name="angle_2" type="float"/>
				</parameters>
			</method>
			<method name="close" symbol="cogl_path_close">
				<return-type type="void"/>
			</method>
			<method name="copy" symbol="cogl_path_copy">
				<return-type type="CoglPath*"/>
				<parameters>
					<parameter name="path" type="CoglPath*"/>
				</parameters>
			</method>
			<method name="curve_to" symbol="cogl_path_curve_to">
				<return-type type="void"/>
				<parameters>
					<parameter name="x_1" type="float"/>
					<parameter name="y_1" type="float"/>
					<parameter name="x_2" type="float"/>
					<parameter name="y_2" type="float"/>
					<parameter name="x_3" type="float"/>
					<parameter name="y_3" type="float"/>
				</parameters>
			</method>
			<method name="ellipse" symbol="cogl_path_ellipse">
				<return-type type="void"/>
				<parameters>
					<parameter name="center_x" type="float"/>
					<parameter name="center_y" type="float"/>
					<parameter name="radius_x" type="float"/>
					<parameter name="radius_y" type="float"/>
				</parameters>
			</method>
			<method name="fill" symbol="cogl_path_fill">
				<return-type type="void"/>
			</method>
			<method name="fill_preserve" symbol="cogl_path_fill_preserve">
				<return-type type="void"/>
			</method>
			<method name="fill_rule_get_type" symbol="cogl_path_fill_rule_get_type">
				<return-type type="GType"/>
			</method>
			<method name="get_fill_rule" symbol="cogl_path_get_fill_rule">
				<return-type type="CoglPathFillRule"/>
			</method>
			<method name="line" symbol="cogl_path_line">
				<return-type type="void"/>
				<parameters>
					<parameter name="x_1" type="float"/>
					<parameter name="y_1" type="float"/>
					<parameter name="x_2" type="float"/>
					<parameter name="y_2" type="float"/>
				</parameters>
			</method>
			<method name="line_to" symbol="cogl_path_line_to">
				<return-type type="void"/>
				<parameters>
					<parameter name="x" type="float"/>
					<parameter name="y" type="float"/>
				</parameters>
			</method>
			<method name="move_to" symbol="cogl_path_move_to">
				<return-type type="void"/>
				<parameters>
					<parameter name="x" type="float"/>
					<parameter name="y" type="float"/>
				</parameters>
			</method>
			<method name="new" symbol="cogl_path_new">
				<return-type type="void"/>
			</method>
			<method name="polygon" symbol="cogl_path_polygon">
				<return-type type="void"/>
				<parameters>
					<parameter name="coords" type="float*"/>
					<parameter name="num_points" type="int"/>
				</parameters>
			</method>
			<method name="polyline" symbol="cogl_path_polyline">
				<return-type type="void"/>
				<parameters>
					<parameter name="coords" type="float*"/>
					<parameter name="num_points" type="int"/>
				</parameters>
			</method>
			<method name="rectangle" symbol="cogl_path_rectangle">
				<return-type type="void"/>
				<parameters>
					<parameter name="x_1" type="float"/>
					<parameter name="y_1" type="float"/>
					<parameter name="x_2" type="float"/>
					<parameter name="y_2" type="float"/>
				</parameters>
			</method>
			<method name="rel_curve_to" symbol="cogl_path_rel_curve_to">
				<return-type type="void"/>
				<parameters>
					<parameter name="x_1" type="float"/>
					<parameter name="y_1" type="float"/>
					<parameter name="x_2" type="float"/>
					<parameter name="y_2" type="float"/>
					<parameter name="x_3" type="float"/>
					<parameter name="y_3" type="float"/>
				</parameters>
			</method>
			<method name="rel_line_to" symbol="cogl_path_rel_line_to">
				<return-type type="void"/>
				<parameters>
					<parameter name="x" type="float"/>
					<parameter name="y" type="float"/>
				</parameters>
			</method>
			<method name="rel_move_to" symbol="cogl_path_rel_move_to">
				<return-type type="void"/>
				<parameters>
					<parameter name="x" type="float"/>
					<parameter name="y" type="float"/>
				</parameters>
			</method>
			<method name="round_rectangle" symbol="cogl_path_round_rectangle">
				<return-type type="void"/>
				<parameters>
					<parameter name="x_1" type="float"/>
					<parameter name="y_1" type="float"/>
					<parameter name="x_2" type="float"/>
					<parameter name="y_2" type="float"/>
					<parameter name="radius" type="float"/>
					<parameter name="arc_step" type="float"/>
				</parameters>
			</method>
			<method name="set_fill_rule" symbol="cogl_path_set_fill_rule">
				<return-type type="void"/>
				<parameters>
					<parameter name="fill_rule" type="CoglPathFillRule"/>
				</parameters>
			</method>
			<method name="stroke" symbol="cogl_path_stroke">
				<return-type type="void"/>
			</method>
			<method name="stroke_preserve" symbol="cogl_path_stroke_preserve">
				<return-type type="void"/>
			</method>
		</struct>
		<struct name="CoglPixelArray">
			<method name="new_with_size_EXP" symbol="cogl_pixel_array_new_with_size_EXP">
				<return-type type="CoglPixelArray*"/>
				<parameters>
					<parameter name="width" type="unsigned"/>
					<parameter name="height" type="unsigned"/>
					<parameter name="format" type="CoglPixelFormat"/>
					<parameter name="stride" type="unsigned*"/>
				</parameters>
			</method>
		</struct>
		<struct name="CoglTextureVertex">
			<field name="x" type="float"/>
			<field name="y" type="float"/>
			<field name="z" type="float"/>
			<field name="tx" type="float"/>
			<field name="ty" type="float"/>
			<field name="color" type="CoglColor"/>
		</struct>
		<struct name="CoglUserDataKey">
			<field name="unused" type="int"/>
		</struct>
		<struct name="CoglVector3">
			<method name="add_EXP" symbol="cogl_vector3_add_EXP">
				<return-type type="void"/>
				<parameters>
					<parameter name="result" type="CoglVector3*"/>
					<parameter name="a" type="CoglVector3*"/>
					<parameter name="b" type="CoglVector3*"/>
				</parameters>
			</method>
			<method name="copy_EXP" symbol="cogl_vector3_copy_EXP">
				<return-type type="CoglVector3*"/>
				<parameters>
					<parameter name="vector" type="CoglVector3*"/>
				</parameters>
			</method>
			<method name="cross_product_EXP" symbol="cogl_vector3_cross_product_EXP">
				<return-type type="void"/>
				<parameters>
					<parameter name="result" type="CoglVector3*"/>
					<parameter name="u" type="CoglVector3*"/>
					<parameter name="v" type="CoglVector3*"/>
				</parameters>
			</method>
			<method name="distance_EXP" symbol="cogl_vector3_distance_EXP">
				<return-type type="float"/>
				<parameters>
					<parameter name="a" type="CoglVector3*"/>
					<parameter name="b" type="CoglVector3*"/>
				</parameters>
			</method>
			<method name="divide_scalar_EXP" symbol="cogl_vector3_divide_scalar_EXP">
				<return-type type="void"/>
				<parameters>
					<parameter name="vector" type="CoglVector3*"/>
					<parameter name="scalar" type="float"/>
				</parameters>
			</method>
			<method name="dot_product_EXP" symbol="cogl_vector3_dot_product_EXP">
				<return-type type="float"/>
				<parameters>
					<parameter name="a" type="CoglVector3*"/>
					<parameter name="b" type="CoglVector3*"/>
				</parameters>
			</method>
			<method name="equal_EXP" symbol="cogl_vector3_equal_EXP">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="v1" type="gconstpointer"/>
					<parameter name="v2" type="gconstpointer"/>
				</parameters>
			</method>
			<method name="equal_with_epsilon_EXP" symbol="cogl_vector3_equal_with_epsilon_EXP">
				<return-type type="gboolean"/>
				<parameters>
					<parameter name="vector0" type="CoglVector3*"/>
					<parameter name="vector1" type="CoglVector3*"/>
					<parameter name="epsilon" type="float"/>
				</parameters>
			</method>
			<method name="free_EXP" symbol="cogl_vector3_free_EXP">
				<return-type type="void"/>
				<parameters>
					<parameter name="vector" type="CoglVector3*"/>
				</parameters>
			</method>
			<method name="init_EXP" symbol="cogl_vector3_init_EXP">
				<return-type type="void"/>
				<parameters>
					<parameter name="vector" type="CoglVector3*"/>
					<parameter name="x" type="float"/>
					<parameter name="y" type="float"/>
					<parameter name="z" type="float"/>
				</parameters>
			</method>
			<method name="init_zero_EXP" symbol="cogl_vector3_init_zero_EXP">
				<return-type type="void"/>
				<parameters>
					<parameter name="vector" type="CoglVector3*"/>
				</parameters>
			</method>
			<method name="invert_EXP" symbol="cogl_vector3_invert_EXP">
				<return-type type="void"/>
				<parameters>
					<parameter name="vector" type="CoglVector3*"/>
				</parameters>
			</method>
			<method name="magnitude_EXP" symbol="cogl_vector3_magnitude_EXP">
				<return-type type="float"/>
				<parameters>
					<parameter name="vector" type="CoglVector3*"/>
				</parameters>
			</method>
			<method name="multiply_scalar_EXP" symbol="cogl_vector3_multiply_scalar_EXP">
				<return-type type="void"/>
				<parameters>
					<parameter name="vector" type="CoglVector3*"/>
					<parameter name="scalar" type="float"/>
				</parameters>
			</method>
			<method name="normalize_EXP" symbol="cogl_vector3_normalize_EXP">
				<return-type type="void"/>
				<parameters>
					<parameter name="vector" type="CoglVector3*"/>
				</parameters>
			</method>
			<method name="subtract_EXP" symbol="cogl_vector3_subtract_EXP">
				<return-type type="void"/>
				<parameters>
					<parameter name="result" type="CoglVector3*"/>
					<parameter name="a" type="CoglVector3*"/>
					<parameter name="b" type="CoglVector3*"/>
				</parameters>
			</method>
			<field name="x" type="float"/>
			<field name="y" type="float"/>
			<field name="z" type="float"/>
		</struct>
		<enum name="CoglAttributeType">
			<member name="COGL_ATTRIBUTE_TYPE_BYTE" value="5120"/>
			<member name="COGL_ATTRIBUTE_TYPE_UNSIGNED_BYTE" value="5121"/>
			<member name="COGL_ATTRIBUTE_TYPE_SHORT" value="5122"/>
			<member name="COGL_ATTRIBUTE_TYPE_UNSIGNED_SHORT" value="5123"/>
			<member name="COGL_ATTRIBUTE_TYPE_FLOAT" value="5126"/>
		</enum>
		<enum name="CoglBitmapError">
			<member name="COGL_BITMAP_ERROR_FAILED" value="0"/>
			<member name="COGL_BITMAP_ERROR_UNKNOWN_TYPE" value="1"/>
			<member name="COGL_BITMAP_ERROR_CORRUPT_IMAGE" value="2"/>
		</enum>
		<enum name="CoglBlendStringError">
			<member name="COGL_BLEND_STRING_ERROR_PARSE_ERROR" value="0"/>
			<member name="COGL_BLEND_STRING_ERROR_ARGUMENT_PARSE_ERROR" value="1"/>
			<member name="COGL_BLEND_STRING_ERROR_INVALID_ERROR" value="2"/>
			<member name="COGL_BLEND_STRING_ERROR_GPU_UNSUPPORTED_ERROR" value="3"/>
		</enum>
		<enum name="CoglBufferAccess">
			<member name="COGL_BUFFER_ACCESS_READ" value="1"/>
			<member name="COGL_BUFFER_ACCESS_WRITE" value="2"/>
			<member name="COGL_BUFFER_ACCESS_READ_WRITE" value="3"/>
		</enum>
		<enum name="CoglBufferBit">
			<member name="COGL_BUFFER_BIT_COLOR" value="1"/>
			<member name="COGL_BUFFER_BIT_DEPTH" value="2"/>
			<member name="COGL_BUFFER_BIT_STENCIL" value="4"/>
		</enum>
		<enum name="CoglBufferMapHint">
			<member name="COGL_BUFFER_MAP_HINT_DISCARD" value="1"/>
		</enum>
		<enum name="CoglBufferTarget">
			<member name="COGL_WINDOW_BUFFER" value="2"/>
			<member name="COGL_OFFSCREEN_BUFFER" value="4"/>
		</enum>
		<enum name="CoglBufferUpdateHint">
			<member name="COGL_BUFFER_UPDATE_HINT_STATIC" value="0"/>
			<member name="COGL_BUFFER_UPDATE_HINT_DYNAMIC" value="1"/>
			<member name="COGL_BUFFER_UPDATE_HINT_STREAM" value="2"/>
		</enum>
		<enum name="CoglDepthTestFunction">
			<member name="COGL_DEPTH_TEST_FUNCTION_NEVER" value="512"/>
			<member name="COGL_DEPTH_TEST_FUNCTION_LESS" value="513"/>
			<member name="COGL_DEPTH_TEST_FUNCTION_EQUAL" value="514"/>
			<member name="COGL_DEPTH_TEST_FUNCTION_LEQUAL" value="515"/>
			<member name="COGL_DEPTH_TEST_FUNCTION_GREATER" value="516"/>
			<member name="COGL_DEPTH_TEST_FUNCTION_NOTEQUAL" value="517"/>
			<member name="COGL_DEPTH_TEST_FUNCTION_GEQUAL" value="518"/>
			<member name="COGL_DEPTH_TEST_FUNCTION_ALWAYS" value="519"/>
		</enum>
		<enum name="CoglDriverError">
			<member name="COGL_DRIVER_ERROR_UNKNOWN_VERSION" value="0"/>
			<member name="COGL_DRIVER_ERROR_INVALID_VERSION" value="1"/>
		</enum>
		<enum name="CoglError">
			<member name="COGL_ERROR_UNSUPPORTED" value="0"/>
		</enum>
		<enum name="CoglFeatureFlags">
			<member name="COGL_FEATURE_TEXTURE_RECTANGLE" value="2"/>
			<member name="COGL_FEATURE_TEXTURE_NPOT" value="4"/>
			<member name="COGL_FEATURE_TEXTURE_YUV" value="8"/>
			<member name="COGL_FEATURE_TEXTURE_READ_PIXELS" value="16"/>
			<member name="COGL_FEATURE_SHADERS_GLSL" value="32"/>
			<member name="COGL_FEATURE_OFFSCREEN" value="64"/>
			<member name="COGL_FEATURE_OFFSCREEN_MULTISAMPLE" value="128"/>
			<member name="COGL_FEATURE_OFFSCREEN_BLIT" value="256"/>
			<member name="COGL_FEATURE_FOUR_CLIP_PLANES" value="512"/>
			<member name="COGL_FEATURE_STENCIL_BUFFER" value="1024"/>
			<member name="COGL_FEATURE_VBOS" value="2048"/>
			<member name="COGL_FEATURE_PBOS" value="4096"/>
			<member name="COGL_FEATURE_UNSIGNED_INT_INDICES" value="8192"/>
			<member name="COGL_FEATURE_DEPTH_RANGE" value="16384"/>
			<member name="COGL_FEATURE_TEXTURE_NPOT_BASIC" value="32768"/>
			<member name="COGL_FEATURE_TEXTURE_NPOT_MIPMAP" value="65536"/>
			<member name="COGL_FEATURE_TEXTURE_NPOT_REPEAT" value="131072"/>
			<member name="COGL_FEATURE_POINT_SPRITE" value="262144"/>
			<member name="COGL_FEATURE_TEXTURE_3D" value="524288"/>
			<member name="COGL_FEATURE_SHADERS_ARBFP" value="1048576"/>
		</enum>
		<enum name="CoglFogMode">
			<member name="COGL_FOG_MODE_LINEAR" value="0"/>
			<member name="COGL_FOG_MODE_EXPONENTIAL" value="1"/>
			<member name="COGL_FOG_MODE_EXPONENTIAL_SQUARED" value="2"/>
		</enum>
		<enum name="CoglIndicesType">
			<member name="COGL_INDICES_TYPE_UNSIGNED_BYTE" value="0"/>
			<member name="COGL_INDICES_TYPE_UNSIGNED_SHORT" value="1"/>
			<member name="COGL_INDICES_TYPE_UNSIGNED_INT" value="2"/>
		</enum>
		<enum name="CoglMaterialAlphaFunc">
			<member name="COGL_MATERIAL_ALPHA_FUNC_NEVER" value="512"/>
			<member name="COGL_MATERIAL_ALPHA_FUNC_LESS" value="513"/>
			<member name="COGL_MATERIAL_ALPHA_FUNC_EQUAL" value="514"/>
			<member name="COGL_MATERIAL_ALPHA_FUNC_LEQUAL" value="515"/>
			<member name="COGL_MATERIAL_ALPHA_FUNC_GREATER" value="516"/>
			<member name="COGL_MATERIAL_ALPHA_FUNC_NOTEQUAL" value="517"/>
			<member name="COGL_MATERIAL_ALPHA_FUNC_GEQUAL" value="518"/>
			<member name="COGL_MATERIAL_ALPHA_FUNC_ALWAYS" value="519"/>
		</enum>
		<enum name="CoglMaterialFilter">
			<member name="COGL_MATERIAL_FILTER_NEAREST" value="9728"/>
			<member name="COGL_MATERIAL_FILTER_LINEAR" value="9729"/>
			<member name="COGL_MATERIAL_FILTER_NEAREST_MIPMAP_NEAREST" value="9984"/>
			<member name="COGL_MATERIAL_FILTER_LINEAR_MIPMAP_NEAREST" value="9985"/>
			<member name="COGL_MATERIAL_FILTER_NEAREST_MIPMAP_LINEAR" value="9986"/>
			<member name="COGL_MATERIAL_FILTER_LINEAR_MIPMAP_LINEAR" value="9987"/>
		</enum>
		<enum name="CoglMaterialLayerType">
			<member name="COGL_MATERIAL_LAYER_TYPE_TEXTURE" value="0"/>
		</enum>
		<enum name="CoglMaterialWrapMode">
			<member name="COGL_MATERIAL_WRAP_MODE_REPEAT" value="10497"/>
			<member name="COGL_MATERIAL_WRAP_MODE_CLAMP_TO_EDGE" value="33071"/>
			<member name="COGL_MATERIAL_WRAP_MODE_AUTOMATIC" value="519"/>
		</enum>
		<enum name="CoglPathFillRule">
			<member name="COGL_PATH_FILL_RULE_NON_ZERO" value="0"/>
			<member name="COGL_PATH_FILL_RULE_EVEN_ODD" value="1"/>
		</enum>
		<enum name="CoglPixelFormat">
			<member name="COGL_PIXEL_FORMAT_ANY" value="0"/>
			<member name="COGL_PIXEL_FORMAT_A_8" value="17"/>
			<member name="COGL_PIXEL_FORMAT_RGB_565" value="4"/>
			<member name="COGL_PIXEL_FORMAT_RGBA_4444" value="21"/>
			<member name="COGL_PIXEL_FORMAT_RGBA_5551" value="22"/>
			<member name="COGL_PIXEL_FORMAT_YUV" value="7"/>
			<member name="COGL_PIXEL_FORMAT_G_8" value="8"/>
			<member name="COGL_PIXEL_FORMAT_RGB_888" value="2"/>
			<member name="COGL_PIXEL_FORMAT_BGR_888" value="34"/>
			<member name="COGL_PIXEL_FORMAT_RGBA_8888" value="19"/>
			<member name="COGL_PIXEL_FORMAT_BGRA_8888" value="51"/>
			<member name="COGL_PIXEL_FORMAT_ARGB_8888" value="83"/>
			<member name="COGL_PIXEL_FORMAT_ABGR_8888" value="115"/>
			<member name="COGL_PIXEL_FORMAT_RGBA_8888_PRE" value="147"/>
			<member name="COGL_PIXEL_FORMAT_BGRA_8888_PRE" value="179"/>
			<member name="COGL_PIXEL_FORMAT_ARGB_8888_PRE" value="211"/>
			<member name="COGL_PIXEL_FORMAT_ABGR_8888_PRE" value="243"/>
			<member name="COGL_PIXEL_FORMAT_RGBA_4444_PRE" value="149"/>
			<member name="COGL_PIXEL_FORMAT_RGBA_5551_PRE" value="150"/>
		</enum>
		<enum name="CoglReadPixelsFlags">
			<member name="COGL_READ_PIXELS_COLOR_BUFFER" value="1"/>
		</enum>
		<enum name="CoglShaderType">
			<member name="COGL_SHADER_TYPE_VERTEX" value="0"/>
			<member name="COGL_SHADER_TYPE_FRAGMENT" value="1"/>
		</enum>
		<enum name="CoglTextureFlags">
			<member name="COGL_TEXTURE_NONE" value="0"/>
			<member name="COGL_TEXTURE_NO_AUTO_MIPMAP" value="1"/>
			<member name="COGL_TEXTURE_NO_SLICING" value="2"/>
			<member name="COGL_TEXTURE_NO_ATLAS" value="4"/>
		</enum>
		<enum name="CoglTexturePixmapX11ReportLevel">
			<member name="COGL_TEXTURE_PIXMAP_X11_DAMAGE_RAW_RECTANGLES" value="0"/>
			<member name="COGL_TEXTURE_PIXMAP_X11_DAMAGE_DELTA_RECTANGLES" value="1"/>
			<member name="COGL_TEXTURE_PIXMAP_X11_DAMAGE_BOUNDING_BOX" value="2"/>
			<member name="COGL_TEXTURE_PIXMAP_X11_DAMAGE_NON_EMPTY" value="3"/>
		</enum>
		<enum name="CoglVerticesMode">
			<member name="COGL_VERTICES_MODE_POINTS" value="0"/>
			<member name="COGL_VERTICES_MODE_LINE_STRIP" value="3"/>
			<member name="COGL_VERTICES_MODE_LINE_LOOP" value="2"/>
			<member name="COGL_VERTICES_MODE_LINES" value="1"/>
			<member name="COGL_VERTICES_MODE_TRIANGLE_STRIP" value="5"/>
			<member name="COGL_VERTICES_MODE_TRIANGLE_FAN" value="6"/>
			<member name="COGL_VERTICES_MODE_TRIANGLES" value="4"/>
		</enum>
		<constant name="CLUTTER_COGL_HAS_GL" type="int" value="1"/>
		<constant name="COGL_AFIRST_BIT" type="int" value="64"/>
		<constant name="COGL_A_BIT" type="int" value="16"/>
		<constant name="COGL_BGR_BIT" type="int" value="32"/>
		<constant name="COGL_FIXED_0_5" type="int" value="32768"/>
		<constant name="COGL_FIXED_1" type="int" value="1"/>
		<constant name="COGL_FIXED_2_PI" type="int" value="411775"/>
		<constant name="COGL_FIXED_BITS" type="int" value="32"/>
		<constant name="COGL_FIXED_EPSILON" type="int" value="1"/>
		<constant name="COGL_FIXED_MAX" type="int" value="2147483647"/>
		<constant name="COGL_FIXED_MIN" type="int" value="-2147483648"/>
		<constant name="COGL_FIXED_PI" type="int" value="205887"/>
		<constant name="COGL_FIXED_PI_2" type="int" value="102944"/>
		<constant name="COGL_FIXED_PI_4" type="int" value="51472"/>
		<constant name="COGL_FIXED_Q" type="int" value="-16"/>
		<constant name="COGL_HAS_GL" type="int" value="1"/>
		<constant name="COGL_HAS_X11" type="int" value="1"/>
		<constant name="COGL_HAS_XLIB" type="int" value="1"/>
		<constant name="COGL_PIXEL_FORMAT_24" type="int" value="2"/>
		<constant name="COGL_PIXEL_FORMAT_32" type="int" value="3"/>
		<constant name="COGL_PREMULT_BIT" type="int" value="128"/>
		<constant name="COGL_RADIANS_TO_DEGREES" type="int" value="3754936"/>
		<constant name="COGL_SQRTI_ARG_10_PERCENT" type="int" value="5590"/>
		<constant name="COGL_SQRTI_ARG_5_PERCENT" type="int" value="210"/>
		<constant name="COGL_SQRTI_ARG_MAX" type="int" value="4194303"/>
		<constant name="COGL_TEXTURE_MAX_WASTE" type="int" value="127"/>
		<constant name="COGL_UNORDERED_MASK" type="int" value="15"/>
		<constant name="COGL_UNPREMULT_MASK" type="int" value="127"/>
	</namespace>
</api>
