/* cairo.vala
 *
 * Copyright (C) 2006-2009  Jürg Billeter
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public
 * License as published by the Free Software Foundation; either
 * version 2.1 of the License, or (at your option) any later version.

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

[CCode (cheader_filename = "cairo.h", gir_namespace = "cairo", gir_version = "1.0")]
namespace Cairo {
	[Compact]
	[CCode (ref_function = "cairo_reference", unref_function = "cairo_destroy", cname = "cairo_t", cprefix = "cairo_", cheader_filename = "cairo.h")]
	public class Context {
		[CCode (cname = "cairo_create")]
		public Context (Surface target);
		public Status status ();
		public void save ();
		public void restore ();
		
		public unowned Surface get_target ();
		public void push_group ();
		public void push_group_with_content (Content content);
		public Pattern pop_group ();
		public void pop_group_to_source ();
		public unowned Surface get_group_target ();
		
		public void set_source_rgb (double red, double green, double blue);
		public void set_source_rgba (double red, double green, double blue, double alpha);
		public void set_source (Pattern source);
		public void set_source_surface (Surface surface, double x, double y);
		public unowned Pattern get_source ();

		public void set_matrix (Matrix matrix);
		public void get_matrix (out Matrix matrix);

		public void set_antialias (Antialias antialias);
		public Antialias get_antialias ();
		
		public void set_dash (double[]? dashes, double offset);
		
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
		public void clip_extents (out double x1, out double y1, out double x2, out double y2);
		public void reset_clip ();
		public bool in_clip (double x, double y);

		public void fill ();
		public void fill_preserve ();
		public void fill_extents (out double x1, out double y1, out double x2, out double y2);
		public bool in_fill (double x, double y);

		public void mask (Pattern pattern);
		public void mask_surface (Surface surface, double surface_x, double surface_y);
		
		public void paint ();
		public void paint_with_alpha (double alpha);

		public void stroke ();
		public void stroke_preserve ();
		public void stroke_extents (out double x1, out double y1, out double x2, out double y2);
		public bool in_stroke (double x, double y);

		public void copy_page ();
		public void show_page ();
		
		public Path copy_path ();
		public Path copy_path_flat ();
		
		public void append_path (Path path);
		
		public void get_current_point (out double x, out double y);
		
		public void new_path ();
		public void new_sub_path ();
		public void close_path ();
		
		public void arc (double xc, double yc, double radius, double angle1, double angle2);
		public void arc_negative (double xc, double yc, double radius, double angle1, double angle2);

		public void curve_to (double x1, double y1, double x2, double y2, double x3, double y3);
		public void line_to (double x, double y);
		public void move_to (double x, double y);
		
		public void rectangle (double x, double y, double width, double height);
		
		public void glyph_path (Glyph[] glyphs);
		public void text_path (string utf8);
		
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
		
		public void select_font_face (string family, FontSlant slant, FontWeight weight);
		public void set_font_size (double size);
		public void set_font_matrix (Matrix matrix);
		public void get_font_matrix (out Matrix matrix);
		public void set_font_options (FontOptions options);
		public void get_font_options (out FontOptions options);
		
		public void show_text (string utf8);
		public void show_glyphs (Glyph[] glyphs);
		
		public unowned FontFace get_font_face ();
		public void font_extents (out FontExtents extents);
		public void set_font_face (FontFace font_face);
		public void set_scaled_font (ScaledFont font);
		public void text_extents (string utf8, out TextExtents extents);
		public void glyph_extents (Glyph[] glyphs, out TextExtents extents);
	}
	
	[CCode (cname = "cairo_antialias_t")]
	public enum Antialias {
		DEFAULT,
		NONE,
		GRAY,
		SUBPIXEL
	}
	
	[CCode (cname = "cairo_fill_rule_t")]
	public enum FillRule {
		WINDING,
		EVEN_ODD
	}
	
	[CCode (cname = "cairo_line_cap_t")]
	public enum LineCap {
		BUTT,
		ROUND,
		SQUARE
	}
	
	[CCode (cname = "cairo_line_join_t")]
	public enum LineJoin {
		MITER,
		ROUND,
		BEVEL
	}
	
	[CCode (cname = "cairo_operator_t")]
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
		SATURATE,
		MULTIPLY,
		SCREEN,
		OVERLAY,
		DARKEN,
		LIGHTEN,
		COLOR_DODGE,
		COLOR_BURN,
		HARD_LIGHT,
		SOFT_LIGHT,
		DIFFERENCE,
		EXCLUSION,
		HSL_HUE,
		HSL_SATURATION,
		HSL_COLOR,
		HSL_LUMINOSITY
	}
	
	[Compact]
	[CCode (free_function = "cairo_path_destroy", cname = "cairo_path_t")]
	public class Path {
		public Status status;
		[CCode (array_length = false)]
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
	
	[CCode (cprefix = "CAIRO_PATH_", cname = "cairo_path_data_type_t")]
	public enum PathDataType {
		MOVE_TO,
		LINE_TO,
		CURVE_TO,
		CLOSE_PATH
	}
	
	[Compact]
	[CCode (ref_function = "cairo_pattern_reference", unref_function = "cairo_pattern_destroy", cname = "cairo_pattern_t")]
	public class Pattern {
		public void add_color_stop_rgb (double offset, double red, double green, double blue);
		public void add_color_stop_rgba (double offset, double red, double green, double blue, double alpha);

		[CCode (cname = "cairo_pattern_create_rgb")]
		public Pattern.rgb (double red, double green, double blue);
		[CCode (cname = "cairo_pattern_create_rgba")]
		public Pattern.rgba (double red, double green, double blue, double alpha);
		[CCode (cname = "cairo_pattern_create_for_surface")]
		public Pattern.for_surface (Surface surface);
		[CCode (cname = "cairo_pattern_create_linear")]
		public Pattern.linear (double x0, double y0, double x1, double y1);
		[CCode (cname = "cairo_pattern_create_radial")]
		public Pattern.radial (double cx0, double cy0, double radius0, double cx1, double cy1, double radius1);
		
		public Status status ();
		
		public void set_extend (Extend extend);
		public Extend get_extend ();
		
		public void set_filter (Filter filter);
		public Filter get_filter ();
		
		public void set_matrix (Matrix matrix);
		public void get_matrix (out Matrix matrix);
		
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

	[Compact]
	[CCode (ref_function = "cairo_region_reference", unref_function = "cairo_region_destroy", cname = "cairo_region_t")]
	public class Region {
		[CCode (cname = "cairo_region_create")]
		public Region ();
		[CCode (cname = "cairo_region_create_rectangle")]
		public Region.rectangle (RectangleInt rectangle);
		[CCode (cname = "cairo_region_create_rectangles")]
		public Region.rectangles (RectangleInt[] rects);
		public Status status ();
		public RectangleInt get_extents ();
		public int num_rectangles ();
		public RectangleInt get_rectangle (int nth);
		public bool is_empty ();
		public bool contains_point (int x, int y);
		public RegionOverlap contains_rectangle (RectangleInt rectangle);
		public bool equal (Region other);
		public void translate (int dx, int dy);
		public Status intersect (Region other);
		public Status intersect_rectangle (RectangleInt rectangle);
		public Status subtract (Region other);
		public Status subtract_rectangle (RectangleInt rectangle);
		public Status union (Region other);
		public Status union_rectangle (RectangleInt rectangle);
		public Status xor (Region other);
		public Status xor_rectangle (RectangleInt rectangle);
	}

	[CCode (cname = "cairo_region_overlap_t")]
	public enum RegionOverlap {
		IN,
		OUT,
		PART
	}

	[CCode (cname = "cairo_glyph_t")]
	public class Glyph {
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
	
	[Compact]
	[CCode (ref_function = "cairo_font_face_reference", unref_function = "cairo_font_face_destroy", cname = "cairo_font_face_t")]
	public class FontFace {
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
	
	[Compact]
	[CCode (ref_function = "cairo_scaled_font_reference", unref_function = "cairo_scaled_font_destroy", cname = "cairo_scaled_font_t")]
	public class ScaledFont {
		[CCode (cname = "cairo_scaled_font_create")]
		public ScaledFont (FontFace font_face, Matrix font_matrix, Matrix ctm, FontOptions options);
		public Status status ();
		public void extents (out FontExtents extents);
		public void text_extents (string utf8, out TextExtents extents);
		public void glyph_extents (Glyph[] glyphs, out TextExtents extents);
		public unowned FontFace get_font_face ();
		public void get_font_options (out FontOptions options);
		public void get_font_matrix (out Matrix font_matrix);
		public void get_ctm (out Matrix ctm);
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
	
	[Compact]
	[CCode (copy_function = "cairo_font_options_copy", free_function = "cairo_font_options_destroy", cname = "cairo_font_options_t")]
	public class FontOptions {
		[CCode (cname = "cairo_font_options_create")]
		public FontOptions ();
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

	[CCode (cname = "cairo_device_type_t")]
	public enum DeviceType {
		DRM,
		GL,
		SCRIPT,
		XCB,
		XLIB,
		XML
	}
	
	[Compact]
	[CCode (ref_function = "cairo_device_reference", unref_function = "cairo_device_destroy", cname = "cairo_device_t", cheader_filename = "cairo.h")]
	public class Device {
		public Status acquire ();
		public void finish ();
		public void flush ();
		public uint get_reference_count  ();
		public DeviceType get_type ();
		public void release ();
		public Status status ();
    }

	[Compact]
	[CCode (ref_function = "cairo_surface_reference", unref_function = "cairo_surface_destroy", cname = "cairo_surface_t", cheader_filename = "cairo.h")]
	public class Surface {
		[CCode (cname = "cairo_surface_create_similar")]
		public Surface.similar (Surface other, Content content, int width, int height);
		[CCode (cname = "cairo_surface_create_for_rectangle")]
		public Surface.for_rectangle (Surface target, double x, double y, double width, double height);
		public void copy_page ();
		public void finish ();
		public void flush ();
		public void get_font_options (out FontOptions options);
		public Content get_content ();
		public Device get_device ();
		public void get_fallback_resolution (out double x_pixels_per_inch, out double y_pixels_per_inch);
		public uint get_reference_count ();
		public bool has_show_text_glyphs ();
		public void mark_dirty ();
		public void mark_dirty_rectangle (int x, int y, int width, int height);
		public void set_device_offset (double x_offset, double y_offset);
		public void get_device_offset (out double x_offset, out double y_offset);
		public void set_fallback_resolution (double x_pixels_per_inch, double y_pixels_per_inch);
		public void show_page ();
		public Status status ();
		public SurfaceType get_type ();

		public Status write_to_png (string filename);
		public Status write_to_png_stream (WriteFunc write_func);
	}
	
	[CCode (cname = "cairo_content_t")]
	public enum Content {
		COLOR,
		ALPHA,
		COLOR_ALPHA
	}
	
	[CCode (cname = "cairo_surface_type_t")]
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
	
	[CCode (cname = "cairo_format_t")]
	public enum Format {
		ARGB32,
		RGB24,
		A8,
		A1,
		RGB16_565
	}
	
	[Compact]
	[CCode (cname = "cairo_surface_t")]
	public class ImageSurface : Surface {
		[CCode (cname = "cairo_image_surface_create")]
		public ImageSurface (Format format, int width, int height);
		[CCode (cname = "cairo_image_surface_create_for_data")]
		public ImageSurface.for_data ([CCode (array_length = false)] uchar[] data, Format format, int width, int height, int stride);
		[CCode (array_length = false)]
		public unowned uchar[] get_data ();
		public Format get_format ();
		public int get_width ();
		public int get_height ();
		public int get_stride ();

		[CCode (cname = "cairo_image_surface_create_from_png")]
		public ImageSurface.from_png (string filename);
		[CCode (cname = "cairo_image_surface_create_from_png_stream")]
		public ImageSurface.from_png_stream (ReadFunc read_func);
	}
	
	[Compact]
	[CCode (cname = "cairo_surface_t", cheader_filename = "cairo-pdf.h")]
	public class PdfSurface : Surface {
		[CCode (cname = "cairo_pdf_surface_create")]
		public PdfSurface (string? filename, double width_in_points, double height_in_points);
		[CCode (cname = "cairo_pdf_surface_create_for_stream")]
		public PdfSurface.for_stream (WriteFunc write_func, double width_in_points, double height_in_points);
		public void set_size (double width_in_points, double height_in_points);
		public static void get_versions (out unowned PdfVersion[] versions);
	}
	
	[CCode (instance_pos = 0, cname = "cairo_read_func_t")]
	public delegate Status ReadFunc (uchar[] data);
	[CCode (instance_pos = 0, cname = "cairo_write_func_t")]
	public delegate Status WriteFunc (uchar[] data);
	
	[Compact]
	[CCode (cname = "cairo_surface_t", cheader_filename = "cairo-ps.h")]
	public class PsSurface : Surface {
		[CCode (cname = "cairo_ps_surface_create")]
		public PsSurface (string filename, double width_in_points, double height_in_points);
		[CCode (cname = "cairo_ps_surface_create_for_stream")]
		public PsSurface.for_stream (WriteFunc write_func, double width_in_points, double height_in_points);
		public void set_size (double width_in_points, double height_in_points);
		public void dsc_begin_setup ();
		public void dsc_begin_page_setup ();
		public void dsc_comment (string comment);
		public bool get_eps ();
		public void set_eps (bool eps);
		public static void get_levels (out unowned PsLevel[] levels);
	}
	
	[Compact]
	[CCode (cname = "cairo_surface_t", cheader_filename = "cairo-svg.h")]
	public class SvgSurface : Surface {
		[CCode (cname = "cairo_svg_surface_create")]
		public SvgSurface (string filename, double width_in_points, double height_in_points);
		[CCode (cname = "cairo_svg_surface_create_for_stream")]
		public SvgSurface.for_stream (WriteFunc write_func, double width_in_points, double height_in_points);
		public void restrict_to_version (SvgVersion version);
		public static void get_versions (out unowned SvgVersion[] versions);
	}
	
	[CCode (cname = "cairo_svg_version_t", cprefix = "CAIRO_SVG_")]
	public enum SvgVersion {
		VERSION_1_1,
		VERSION_1_2;
		[CCode (cname = "cairo_svg_version_to_string")]
		public unowned string to_string ();
	}

	[CCode (cname = "cairo_pdf_version_t", cprefix = "CAIRO_PDF_")]
	public enum PdfVersion {
		VERSION_1_4,
		VERSION_1_5;
		[CCode (cname = "cairo_pdf_version_to_string")]
		public unowned string to_string ();
	}

	[CCode (cname = "cairo_ps_level_t", cprefix = "CAIRO_PS_")]
	public enum PsLevel {
		LEVEL_2,
		LEVEL_3;
		[CCode (cname = "cairo_ps_level_to_string")]
		public unowned string to_string ();
	}

	[Compact]
	[CCode (cname = "cairo_surface_t", cheader_filename = "cairo-xlib.h")]
	public class XlibSurface : Surface {
		[CCode (cname = "cairo_xlib_surface_create")]
		public XlibSurface (void* dpy, int drawable, void* visual, int width, int height);
		[CCode (cname = "cairo_xlib_surface_create_for_bitmap")]
		public XlibSurface.for_bitmap (void* dpy, int bitmap, void* screen, int width, int height);
		public void set_size (int width, int height);
		public void* get_display ();
		public void* get_screen ();
		public void set_drawable (int drawable, int width, int height);
		public int get_drawable ();
		public void* get_visual ();
		public int get_width ();
		public int get_height ();
		public int get_depth ();
	}
	
	[CCode (cname = "cairo_matrix_t", has_type_id = false)]
	public struct Matrix {
		[CCode (cname = "cairo_matrix_init")]
		public Matrix (double xx, double yx, double xy, double yy, double x0, double y0);
		[CCode (cname = "cairo_matrix_init_identity")]
		public Matrix.identity ();

		public void translate (double tx, double ty);
		public void scale (double sx, double sy);
		public void rotate (double radians);
		public Status invert ();
		public void multiply (Matrix a, Matrix b);
		public void transform_distance (ref double dx, ref double dy);
		public void transform_point (ref double x, ref double y);

		public double xx;
		public double yx;
		public double xy;
		public double yy;
		public double x0;
		public double y0;
	}

	[CCode (cname = "cairo_rectangle_t", has_type_id = false)]
	public struct Rectangle	{
		public double x;
		public double y;
		public double width;
		public double height;
	}

	[CCode (cname = "cairo_rectangle_int_t", has_type_id = false)]
	public struct RectangleInt {
		public int x;
		public int y;
		public int width;
		public int height;
	}

	[CCode (cname = "cairo_status_t")]
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
		INVALID_DSC_COMMENT,
		INVALID_INDEX,
		CLIP_NOT_REPRESENTABLE,
		TEMP_FILE_ERROR,
		INVALID_STRIDE,
		FONT_TYPE_MISMATCH,
		USER_FONT_IMMUTABLE,
		USER_FONT_ERROR,
		NEGATIVE_COUNT,
		INVALID_CLUSTERS,
		INVALID_SLANT,
		INVALID_WEIGHT,
		INVALID_SIZE,
		USER_FONT_NOT_IMPLEMENTED,
		DEVICE_TYPE_MISMATCH,
		DEVICE_ERROR;
		[CCode (cname = "cairo_status_to_string")]
		public unowned string to_string ();
	}
	
	public int version ();
	public unowned string version_string ();
}
