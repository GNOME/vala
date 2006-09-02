/* cairo.vala
 *
 * Copyright (C) 2006  Jürg Billeter
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public
 * License as published by the Free Software Foundation; either
 * version 2 of the License, or (at your option) any later version.

 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * Lesser General Public License for more details.

 * You should have received a copy of the GNU Lesser General Public
 * License along with this library; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301  USA
 *
 * Author:
 * 	Jürg Billeter <j@bitron.ch>
 */

[CCode (cheader_filename = "cairo.h")]
namespace Cairo {
	[ReferenceType (dup_function = "cairo_reference", free_function = "cairo_destroy")]
	[CCode (cname = "cairo_t", cprefix = "cairo_", cheader_filename = "cairo.h")]
	public struct Context {
		[CCode (cname = "cairo_create")]
		public construct (Surface target);
		public Status status ();
		public void save ();
		public void restore ();
		
		public Surface get_target ();
		public void push_group ();
		public void push_group_with_content (Content content);
		public ref Pattern pop_group ();
		public void pop_group_to_source ();
		public Surface get_group_target ();
		
		public void set_source_rgb (double red, double green, double blue);
		public void set_source_rgba (double red, double green, double blue, double alpha);
		public void set_source (Pattern source);
		public void set_source_surface (Surface surface, double x, double y);
		public Pattern get_source ();
		
		public void set_antialias (Antialias antialias);
		public Antialias get_antialias ();
		
		[NoArrayLength ()]
		public void set_dash (double[] dashes, int num_dashes, double offset);
		
		public void set_fill_rule (FillRule fill_rule);
		public FillRule get_fill_rule ();
		
		public void set_line_cap (LineCap line_cap);
		public LineCap get_line_cap ();
		
		public void set_line_join (LineJoin line_join);
		public LineJoin get_line_join ();
		
		public void set_line_width (double width);
		public double get_line_width ();
		
		public void set_miter_limit (double limit);
		public double get_miter_limit ();
		
		public void set_operator (Operator op);
		public Operator get_operator ();
		
		public void set_tolerance (double tolerance);
		public double get_tolerance ();
		
		public void clip ();
		public void clip_preserve ();
		public void reset_clip ();

		public void fill ();
		public void fill_preserve ();
		public void fill_extents (ref double x1, ref double y1, ref double x2, ref double y2);
		public bool in_fill (double x, double y);

		public void mask (Pattern pattern);
		public void mask_surface (Surface surface, double surface_x, double surface_y);
		
		public void paint ();
		public void paint_with_alpha (double alpha);

		public void stroke ();
		public void stroke_preserve ();
		public void stroke_extents (ref double x1, ref double y1, ref double x2, ref double y2);
		public bool in_stroke (double x, double y);

		public void copy_page ();
		public void show_page ();
		
		public ref Path copy_path ();
		public ref Path copy_path_flat ();
		
		public void append_path (Path path);
		
		public void get_current_point (ref double x, ref double y);
		
		public void new_path ();
		public void new_sub_path ();
		public void close_path ();
		
		public void arc (double xc, double yc, double radius, double angle1, double angle2);
		public void arc_negative (double xc, double yc, double radius, double angle1, double angle2);

		public void curve_to (double x1, double y1, double x2, double y2, double x3, double y3);
		public void line_to (double x, double y);
		public void move_to (double x, double y);
		
		public void rectangle (double x, double y, double width, double height);
		
		[NoArrayLength ()]
		public void glyph_path (Glyph[] glyphs, int num_glyphs);
		public void text_path (string! utf8);
		
		public void rel_curve_to (double dx1, double dy1, double dx2, double dy2, double dx3, double dy3);
		public void rel_line_to (double dx, double dy);
		public void rel_move_to (double dx, double dy);
		
		public void translate (double tx, double ty);
		public void scale (double sx, double sy);
		public void rotate (double angle);
		public void transform (Matrix matrix);
		public void identity_matrix ();
		
		public void user_to_device (ref double x, ref double y);
		public void user_to_device_distance (ref double dx, ref double dy);
		public void device_to_user (ref double x, ref double y);
		public void device_to_user_distance (ref double dx, ref double dy);
		
		public void select_font_face (string! family, FontSlant slant, FontWeight weight);
		public void set_font_size (double size);
		public void set_font_matrix (Matrix! matrix);
		public void get_font_matrix (Matrix matrix);
		public void set_font_options (ref FontOptions! options);
		public void get_font_options (ref FontOptions options);
		
		public void show_text (string! utf8);
		[NoArrayLength ()]
		public void show_glyphs (Glyph[] glyphs, int num_glyphs);
		
		public FontFace get_font_face ();
		public void font_extents (ref FontExtents extents);
		public void set_font_face (FontFace font_face);
		public void set_scaled_font (ScaledFont! font);
		public void text_extents (string! utf8, ref TextExtents extents);
		[NoArrayLength ()]
		public void glyph_extents (Glyph[] glyphs, int num_glyphs, ref TextExtents extents);
	}
	
	public enum Antialias {
		DEFAULT,
		NONE,
		GRAY,
		SUBPIXEL
	}
	
	public enum FillRule {
		WINDING,
		EVEN_ODD
	}
	
	public enum LineCap {
		BUTT,
		ROUND,
		SQUARE
	}
	
	public enum LineJoin {
		MITER,
		ROUND,
		BEVEL
	}
	
	public enum Operator {
		CLEAR,
		SOURCE,
		OVER,
		IN,
		OUT,
		ATOP,
		DEST,
		DEST_OVER,
		DEST_IN,
		DEST_OUT,
		DEST_ATOP,
		XOR,
		ADD,
		SATURATE
	}
	
	[ReferenceType (free_function = "cairo_path_destroy")]
	[CCode (cname = "cairo_path_t")]
	public struct Path {
		public Status status;
		[NoArrayLength ()]
		public PathData[] data;
		public int num_data;
	}
	
	[CCode (cname = "cairo_path_data_t")]
	public struct PathData {
		public PathDataHeader header;
		public PathDataPoint point;
	}
	
	public struct PathDataHeader {
		public PathDataType type;
		public int length;
	}
	
	public struct PathDataPoint {
		public double x;
		public double y;
	}
	
	[CCode (cprefix = "CAIRO_PATH_")]
	public enum PathDataType {
		MOVE_TO,
		LINE_TO,
		CURVE_TO,
		CLOSE_PATH
	}
	
	[ReferenceType (dup_function = "cairo_pattern_reference", free_function = "cairo_pattern_destroy")]
	[CCode (cname = "cairo_pattern_t")]
	public struct Pattern {
		public void add_color_stop_rgb (double offset, double red, double green, double blue);
		public void add_color_stop_rgba (double offset, double red, double green, double blue, double alpha);

		[CCode (cname = "cairo_pattern_create_rgb")]
		public construct rgb (double red, double green, double blue);
		[CCode (cname = "cairo_pattern_create_rgba")]
		public construct rgba (double red, double green, double blue, double alpha);
		[CCode (cname = "cairo_pattern_create_for_surface")]
		public construct for_surface (Surface! surface);
		[CCode (cname = "cairo_pattern_create_linear")]
		public construct linear (double x0, double y0, double x1, double y1);
		[CCode (cname = "cairo_pattern_create_radial")]
		public construct radial (double cx0, double cy0, double radius0, double cx1, double cy1, double radius1);
		
		public Status status ();
		
		public void set_extend (Extend extend);
		public Extend get_extend ();
		
		public void set_filter (Filter filter);
		public Filter get_filter ();
		
		public void set_matrix (Matrix matrix);
		public void get_matrix (Matrix matrix);
		
		public PatternType get_type ();
	}
	
	[CCode (cname = "cairo_extend_t")]
	public enum Extend {
		NONE,
		REPEAT,
		REFLECT,
		PAD
	}
	
	[CCode (cname = "cairo_filter_t")]
	public enum Filter {
		FAST,
		GOOD,
		BEST,
		NEAREST,
		BILINEAR,
		GAUSSIAN
	}
	
	[CCode (cname = "cairo_pattern_type_t")]
	public enum PatternType {
		SOLID,
		SURFACE,
		LINEAR,
		RADIAL
	}
	
	[ReferenceType ()]
	[CCode (cname = "cairo_glyph_t")]
	public struct Glyph {
	}
	
	[CCode (cname = "cairo_font_slant_t")]
	public enum FontSlant {
		NORMAL,
		ITALIC,
		OBLIQUE
	}
	
	[CCode (cname = "cairo_font_weight_t")]
	public enum FontWeight {
		NORMAL,
		BOLD
	}
	
	[ReferenceType (dup_function = "cairo_font_face_reference", free_function = "cairo_font_face_destroy")]
	[CCode (cname = "cairo_font_face_t")]
	public struct FontFace {
		public Status status ();
		public FontType get_type ();
	}
	
	[CCode (cname = "cairo_font_type_t")]
	public enum FontType {
		TOY,
		FT,
		WIN32,
		ATSUI
	}
	
	[ReferenceType (dup_function = "cairo_scaled_font_reference", free_function = "cairo_scaled_font_destroy")]
	[CCode (cname = "cairo_scaled_font_t")]
	public struct ScaledFont {
		[CCode (cname = "cairo_scaled_font_create")]
		public construct (Matrix font_matrix, Matrix ctm, ref FontOptions options);
		public Status status ();
		public void extents (ref FontExtents extents);
		public void text_extents (string! utf8, ref TextExtents extents);
		[NoArrayLength ()]
		public void glyph_extents (Glyph[] glyphs, int num_glyphs, ref TextExtents extents);
		public FontFace get_font_face ();
		public void get_font_options (ref FontOptions options);
		public void get_font_matrix (Matrix font_matrix);
		public void get_ctm (Matrix ctm);
		public FontType get_type ();
	}
	
	[CCode (cname = "cairo_font_extents_t")]
	public struct FontExtents {
		public double ascent;
		public double descent;
		public double height;
		public double max_x_advance;
		public double max_y_advance;
	}
	
	[CCode (cname = "cairo_text_extents_t")]
	public struct TextExtents {
		public double x_bearing;
		public double y_bearing;
		public double width;
		public double height;
		public double x_advance;
		public double y_advance;
	}
	
	[ReferenceType (dup_function = "cairo_font_options_copy", free_function = "cairo_font_options_destroy")]
	[CCode (cname = "cairo_font_options_t")]
	public struct FontOptions {
		[CCode (cname = "cairo_font_options_create")]
		public construct ();
		public Status status ();
		public void merge (FontOptions other);
		public ulong hash ();
		public bool equal (FontOptions other);
		public void set_antialias (Antialias antialias);
		public Antialias get_antialias ();
		public void set_subpixel_order (SubpixelOrder subpixel_order);
		public SubpixelOrder get_subpixel_order ();
		public void set_hint_style (HintStyle hint_style);
		public HintStyle get_hint_style ();
		public void set_hint_metrics (HintMetrics hint_metrics);
		public HintMetrics get_hint_metrics ();
	}
	
	[CCode (cname = "cairo_subpixel_order_t")]
	public enum SubpixelOrder {
		DEFAULT,
		RGB,
		BGR,
		VRGB,
		VBGR
	}
	
	[CCode (cname = "cairo_hint_style_t")]
	public enum HintStyle {
		DEFAULT,
		NONE,
		SLIGHT,
		MEDIUM,
		FULL
	}
	
	[CCode (cname = "cairo_hint_metrics_t")]
	public enum HintMetrics {
		DEFAULT,
		OFF,
		ON
	}
	
	[ReferenceType (dup_function = "cairo_surface_reference", free_function = "cairo_surface_destroy")]
	[CCode (cname = "cairo_surface_t", cheader_filename = "cairo.h")]
	public struct Surface {
		[CCode (cname = "cairo_surface_create_similar")]
		public construct similar (Surface! other, Content content, int width, int height);
		public void finish ();
		public void flush ();
		public void get_font_options (ref FontOptions options);
		public Content get_content ();
		public void mark_dirty ();
		public void mark_dirty_rectangle (int x, int y, int width, int height);
		public void set_device_offset (double x_offset, double y_offset);
		public void get_device_offset (ref double x_offset, ref double y_offset);
		public void set_fallback_resolution (double x_pixels_per_inch, double y_pixels_per_inch);
		public Status status ();
		public SurfaceType get_type ();

		public Status write_to_png (string! filename);
		public Status write_to_png_stream (WriteFunc write_func, pointer closure);
	}
	
	public enum Content {
		COLOR,
		ALPHA,
		COLOR_ALPHA
	}
	
	public enum SurfaceType {
		IMAGE,
		PDF,
		PS,
		XLIB,
		XCB,
		GLITZ,
		QUARTZ,
		WIN32,
		BEOS,
		DIRECTFB,
		SVG
	}
	
	public enum Format {
		ARGB32,
		RGB24,
		A8,
		A1,
		RGB16_565
	}
	
	[ReferenceType (dup_function = "cairo_surface_reference", free_function = "cairo_surface_destroy")]
	[CCode (cname = "cairo_surface_t")]
	public struct ImageSurface : Surface {
		[CCode (cname = "cairo_image_surface_create")]
		public construct (Format format, int width, int height);
		[CCode (cname = "cairo_image_surface_create_for_data")]
		[NoArrayLength ()]
		public construct for_data (uchar[] data, Format format, int width, int height, int stride);
		public uchar[] get_data ();
		public Format get_format ();
		public int get_width ();
		public int get_height ();
		public int get_stride ();

		[CCode (cname = "cairo_image_surface_create_from_png")]
		public construct from_png (string! filename);
		[CCode (cname = "cairo_image_surface_create_from_png_stream")]
		public construct from_png_stream (ReadFunc read_func, pointer closure);
	}
	
	[ReferenceType (dup_function = "cairo_surface_reference", free_function = "cairo_surface_destroy")]
	[CCode (cname = "cairo_surface_t", cheader_filename = "cairo-pdf.h")]
	public struct PdfSurface : Surface {
		[CCode (cname = "cairo_pdf_surface_create")]
		public construct (string! filename, double width_in_points, double height_in_points);
		[CCode (cname = "cairo_pdf_surface_create_for_stream")]
		public construct for_stream (WriteFunc write_func, pointer closure, double width_in_points, double height_in_points);
		public void set_size (double width_in_points, double height_in_points);
	}
	
	[NoArrayLength ()]
	public callback Status ReadFunc (pointer closure, uchar[] data, uint length);
	[NoArrayLength ()]
	public callback Status WriteFunc (pointer closure, uchar[] data, uint length);
	
	[ReferenceType (dup_function = "cairo_surface_reference", free_function = "cairo_surface_destroy")]
	[CCode (cname = "cairo_surface_t", cheader_filename = "cairo-ps.h")]
	public struct PsSurface : Surface {
		[CCode (cname = "cairo_ps_surface_create")]
		public construct (string! filename, double width_in_points, double height_in_points);
		[CCode (cname = "cairo_ps_surface_create_for_stream")]
		public construct for_stream (WriteFunc write_func, pointer closure, double width_in_points, double height_in_points);
		public void set_size (double width_in_points, double height_in_points);
		public void dsc_begin_setup ();
		public void dsc_begin_page_setup ();
		public void dsc_comment (string! comment);
	}
	
	[ReferenceType (dup_function = "cairo_surface_reference", free_function = "cairo_surface_destroy")]
	[CCode (cname = "cairo_surface_t", cheader_filename = "cairo-svg.h")]
	public struct SvgSurface : Surface {
		[CCode (cname = "cairo_svg_surface_create")]
		public construct (string! filename, double width_in_points, double height_in_points);
		[CCode (cname = "cairo_svg_surface_create_for_stream")]
		public construct for_stream (WriteFunc write_func, pointer closure, double width_in_points, double height_in_points);
		public void restrict_to_version (SvgVersion version);
		[NoArrayLength ()]
		public static void get_versions (out SvgVersion[] versions, ref int num_versions);
	}
	
	[CCode (cname = "cairo_svg_version_t", cprefix = "CAIRO_SVG_")]
	public enum SvgVersion {
		VERSION_1_1,
		VERSION_1_2
	}
	
	[ReferenceType (dup_function = "cairo_surface_reference", free_function = "cairo_surface_destroy")]
	[CCode (cname = "cairo_surface_t", cheader_filename = "cairo-xlib.h")]
	public struct XlibSurface : Surface {
		[CCode (cname = "cairo_xlib_surface_create")]
		public construct (pointer dpy, int drawable, pointer visual, int width, int height);
		[CCode (cname = "cairo_xlib_surface_create_for_bitmap")]
		public construct for_bitmap (pointer dpy, int bitmap, pointer screen, int width, int height);
		public void set_size (int width, int height);
		public pointer get_display ();
		public pointer get_screen ();
		public void set_drawable (int drawable, int width, int height);
		public int get_drawable ();
		public pointer get_visual ();
		public int get_width ();
		public int get_height ();
		public int get_depth ();
	}
	
	[ReferenceType (free_function = "g_free")]
	[CCode (cname = "cairo_matrix_t")]
	public struct Matrix {
		public void init (double xx, double yx, double xy, double yy, double x0, double y0);
		public void init_identity ();
		public void init_translate (double tx, double ty);
		public void init_scale (double sx, double sy);
		public void init_rotate (double radians);
		public void translate (double tx, double ty);
		public void scale (double sx, double sy);
		public void rotate (double radians);
		public Status invert ();
		public void multiply (Matrix a, Matrix b);
		public void transform_distance (ref double dx, ref double dy);
		public void transform_point (ref double x, ref double y);
	}
	
	public enum Status {
		SUCCESS,
		NO_MEMORY,
		INVALID_RESTORE,
		INVALID_POP_GROUP,
		NO_CURRENT_POINT,
		INVALID_MATRIX,
		INVALID_STATUS,
		NULL_POINTER,
		INVALID_STRING,
		INVALID_PATH_DATA,
		READ_ERROR,
		WRITE_ERROR,
		SURFACE_FINISHED,
		SURFACE_TYPE_MISMATCH,
		PATTERN_TYPE_MISMATCH,
		INVALID_CONTENT,
		INVALID_FORMAT,
		INVALID_VISUAL,
		FILE_NOT_FOUND,
		INVALID_DASH,
		INVALID_DSC_COMMENT
	}
	
	public int version ();
	public string! version_string ();
}
