[CCode (cheader_filename = "pango/pango.h")]
namespace Pango {
	[CCode (cprefix = "PANGO_ALIGN_")]
	public enum Alignment {
		LEFT,
		CENTER,
		RIGHT,
	}
	[CCode (cprefix = "PANGO_ATTR_")]
	public enum AttrType {
		INVALID,
		LANGUAGE,
		FAMILY,
		STYLE,
		WEIGHT,
		VARIANT,
		STRETCH,
		SIZE,
		FONT_DESC,
		FOREGROUND,
		BACKGROUND,
		UNDERLINE,
		STRIKETHROUGH,
		RISE,
		SHAPE,
		SCALE,
		FALLBACK,
		LETTER_SPACING,
		UNDERLINE_COLOR,
		STRIKETHROUGH_COLOR,
		ABSOLUTE_SIZE,
		GRAVITY,
		GRAVITY_HINT,
	}
	[CCode (cprefix = "PANGO_COVERAGE_")]
	public enum CoverageLevel {
		NONE,
		FALLBACK,
		APPROXIMATE,
		EXACT,
	}
	[CCode (cprefix = "PANGO_DIRECTION_")]
	public enum Direction {
		LTR,
		RTL,
		TTB_LTR,
		TTB_RTL,
		WEAK_LTR,
		WEAK_RTL,
		NEUTRAL,
	}
	[CCode (cprefix = "PANGO_ELLIPSIZE_")]
	public enum EllipsizeMode {
		NONE,
		START,
		MIDDLE,
		END,
	}
	[CCode (cprefix = "PANGO_FONT_MASK_")]
	public enum FontMask {
		FAMILY,
		STYLE,
		VARIANT,
		WEIGHT,
		STRETCH,
		SIZE,
		GRAVITY,
	}
	[CCode (cprefix = "PANGO_GRAVITY_")]
	public enum Gravity {
		SOUTH,
		EAST,
		NORTH,
		WEST,
		AUTO,
	}
	[CCode (cprefix = "PANGO_GRAVITY_HINT_")]
	public enum GravityHint {
		NATURAL,
		STRONG,
		LINE,
	}
	[CCode (cprefix = "PANGO_RENDER_PART_")]
	public enum RenderPart {
		FOREGROUND,
		BACKGROUND,
		UNDERLINE,
		STRIKETHROUGH,
	}
	[CCode (cprefix = "PANGO_SCRIPT_")]
	public enum Script {
		INVALID_CODE,
		COMMON,
		INHERITED,
		ARABIC,
		ARMENIAN,
		BENGALI,
		BOPOMOFO,
		CHEROKEE,
		COPTIC,
		CYRILLIC,
		DESERET,
		DEVANAGARI,
		ETHIOPIC,
		GEORGIAN,
		GOTHIC,
		GREEK,
		GUJARATI,
		GURMUKHI,
		HAN,
		HANGUL,
		HEBREW,
		HIRAGANA,
		KANNADA,
		KATAKANA,
		KHMER,
		LAO,
		LATIN,
		MALAYALAM,
		MONGOLIAN,
		MYANMAR,
		OGHAM,
		OLD_ITALIC,
		ORIYA,
		RUNIC,
		SINHALA,
		SYRIAC,
		TAMIL,
		TELUGU,
		THAANA,
		THAI,
		TIBETAN,
		CANADIAN_ABORIGINAL,
		YI,
		TAGALOG,
		HANUNOO,
		BUHID,
		TAGBANWA,
		BRAILLE,
		CYPRIOT,
		LIMBU,
		OSMANYA,
		SHAVIAN,
		LINEAR_B,
		TAI_LE,
		UGARITIC,
		NEW_TAI_LUE,
		BUGINESE,
		GLAGOLITIC,
		TIFINAGH,
		SYLOTI_NAGRI,
		OLD_PERSIAN,
		KHAROSHTHI,
		UNKNOWN,
		BALINESE,
		CUNEIFORM,
		PHOENICIAN,
		PHAGS_PA,
		NKO,
	}
	[CCode (cprefix = "PANGO_STRETCH_")]
	public enum Stretch {
		ULTRA_CONDENSED,
		EXTRA_CONDENSED,
		CONDENSED,
		SEMI_CONDENSED,
		NORMAL,
		SEMI_EXPANDED,
		EXPANDED,
		EXTRA_EXPANDED,
		ULTRA_EXPANDED,
	}
	[CCode (cprefix = "PANGO_STYLE_")]
	public enum Style {
		NORMAL,
		OBLIQUE,
		ITALIC,
	}
	[CCode (cprefix = "PANGO_TAB_")]
	public enum TabAlign {
		LEFT,
	}
	[CCode (cprefix = "PANGO_UNDERLINE_")]
	public enum Underline {
		NONE,
		SINGLE,
		DOUBLE,
		LOW,
		ERROR,
	}
	[CCode (cprefix = "PANGO_VARIANT_")]
	public enum Variant {
		NORMAL,
		SMALL_CAPS,
	}
	[CCode (cprefix = "PANGO_WEIGHT_")]
	public enum Weight {
		ULTRALIGHT,
		LIGHT,
		NORMAL,
		SEMIBOLD,
		BOLD,
		ULTRABOLD,
		HEAVY,
	}
	[CCode (cprefix = "PANGO_WRAP_")]
	public enum WrapMode {
		WORD,
		CHAR,
		WORD_CHAR,
	}
	[CCode (cheader_filename = "pango/pango.h")]
	public class Context : GLib.Object {
		[NoArrayLength]
		[CCode (cname = "pango_context_get_base_dir")]
		public Pango.Direction get_base_dir ();
		[NoArrayLength]
		[CCode (cname = "pango_context_get_base_gravity")]
		public Pango.Gravity get_base_gravity ();
		[NoArrayLength]
		[CCode (cname = "pango_context_get_font_description")]
		public weak Pango.FontDescription get_font_description ();
		[NoArrayLength]
		[CCode (cname = "pango_context_get_font_map")]
		public weak Pango.FontMap get_font_map ();
		[NoArrayLength]
		[CCode (cname = "pango_context_get_gravity")]
		public Pango.Gravity get_gravity ();
		[NoArrayLength]
		[CCode (cname = "pango_context_get_gravity_hint")]
		public Pango.GravityHint get_gravity_hint ();
		[NoArrayLength]
		[CCode (cname = "pango_context_get_language")]
		public weak Pango.Language get_language ();
		[NoArrayLength]
		[CCode (cname = "pango_context_get_matrix")]
		public Pango.Matrix get_matrix ();
		[NoArrayLength]
		[CCode (cname = "pango_context_get_metrics")]
		public weak Pango.FontMetrics get_metrics (Pango.FontDescription desc, Pango.Language language);
		[NoArrayLength]
		[CCode (cname = "pango_context_get_type")]
		public static GLib.Type get_type ();
		[NoArrayLength]
		[CCode (cname = "pango_context_list_families")]
		public void list_families (Pango.FontFamily[] families, int n_families);
		[NoArrayLength]
		[CCode (cname = "pango_context_load_font")]
		public weak Pango.Font load_font (Pango.FontDescription desc);
		[NoArrayLength]
		[CCode (cname = "pango_context_load_fontset")]
		public weak Pango.Fontset load_fontset (Pango.FontDescription desc, Pango.Language language);
		[NoArrayLength]
		[CCode (cname = "pango_context_set_base_dir")]
		public void set_base_dir (Pango.Direction direction);
		[NoArrayLength]
		[CCode (cname = "pango_context_set_base_gravity")]
		public void set_base_gravity (Pango.Gravity gravity);
		[NoArrayLength]
		[CCode (cname = "pango_context_set_font_description")]
		public void set_font_description (Pango.FontDescription desc);
		[NoArrayLength]
		[CCode (cname = "pango_context_set_gravity_hint")]
		public void set_gravity_hint (Pango.GravityHint hint);
		[NoArrayLength]
		[CCode (cname = "pango_context_set_language")]
		public void set_language (Pango.Language language);
		[NoArrayLength]
		[CCode (cname = "pango_context_set_matrix")]
		public void set_matrix (ref Pango.Matrix matrix);
	}
	[CCode (cheader_filename = "pango/pango.h")]
	public class Font : GLib.Object {
		[NoArrayLength]
		[CCode (cname = "pango_font_describe")]
		public weak Pango.FontDescription describe ();
		[NoArrayLength]
		[CCode (cname = "pango_font_describe_with_absolute_size")]
		public weak Pango.FontDescription describe_with_absolute_size ();
		[NoArrayLength]
		[CCode (cname = "pango_font_descriptions_free")]
		public static void descriptions_free (Pango.FontDescription[] descs, int n_descs);
		[NoArrayLength]
		[CCode (cname = "pango_font_find_shaper")]
		public weak Pango.EngineShape find_shaper (Pango.Language language, uint ch);
		[NoArrayLength]
		[CCode (cname = "pango_font_get_coverage")]
		public weak Pango.Coverage get_coverage (Pango.Language language);
		[NoArrayLength]
		[CCode (cname = "pango_font_get_font_map")]
		public weak Pango.FontMap get_font_map ();
		[NoArrayLength]
		[CCode (cname = "pango_font_get_glyph_extents")]
		public void get_glyph_extents (uint glyph, ref Pango.Rectangle ink_rect, ref Pango.Rectangle logical_rect);
		[NoArrayLength]
		[CCode (cname = "pango_font_get_metrics")]
		public weak Pango.FontMetrics get_metrics (Pango.Language language);
		[NoArrayLength]
		[CCode (cname = "pango_font_get_type")]
		public static GLib.Type get_type ();
	}
	[CCode (cheader_filename = "pango/pango.h")]
	public class Fontset : GLib.Object {
		[NoArrayLength]
		[CCode (cname = "pango_fontset_foreach")]
		public void @foreach (Pango.FontsetForeachFunc func, pointer data);
		[NoArrayLength]
		[CCode (cname = "pango_fontset_get_font")]
		public weak Pango.Font get_font (uint wc);
		[NoArrayLength]
		[CCode (cname = "pango_fontset_get_metrics")]
		public weak Pango.FontMetrics get_metrics ();
		[NoArrayLength]
		[CCode (cname = "pango_fontset_get_type")]
		public static GLib.Type get_type ();
	}
	[CCode (cheader_filename = "pango/pango.h")]
	public class FontFace : GLib.Object {
		[NoArrayLength]
		[CCode (cname = "pango_font_face_describe")]
		public weak Pango.FontDescription describe ();
		[NoArrayLength]
		[CCode (cname = "pango_font_face_get_face_name")]
		public weak string get_face_name ();
		[NoArrayLength]
		[CCode (cname = "pango_font_face_get_type")]
		public static GLib.Type get_type ();
		[NoArrayLength]
		[CCode (cname = "pango_font_face_list_sizes")]
		public void list_sizes (int[] sizes, int n_sizes);
	}
	[CCode (cheader_filename = "pango/pango.h")]
	public class FontFamily : GLib.Object {
		[NoArrayLength]
		[CCode (cname = "pango_font_family_get_name")]
		public weak string get_name ();
		[NoArrayLength]
		[CCode (cname = "pango_font_family_get_type")]
		public static GLib.Type get_type ();
		[NoArrayLength]
		[CCode (cname = "pango_font_family_is_monospace")]
		public bool is_monospace ();
		[NoArrayLength]
		[CCode (cname = "pango_font_family_list_faces")]
		public void list_faces (Pango.FontFace[] faces, int n_faces);
	}
	[CCode (cheader_filename = "pango/pango.h")]
	public class FontMap : GLib.Object {
		[NoArrayLength]
		[CCode (cname = "pango_font_map_get_type")]
		public static GLib.Type get_type ();
		[NoArrayLength]
		[CCode (cname = "pango_font_map_list_families")]
		public void list_families (Pango.FontFamily[] families, int n_families);
		[NoArrayLength]
		[CCode (cname = "pango_font_map_load_font")]
		public weak Pango.Font load_font (Pango.Context context, Pango.FontDescription desc);
		[NoArrayLength]
		[CCode (cname = "pango_font_map_load_fontset")]
		public weak Pango.Fontset load_fontset (Pango.Context context, Pango.FontDescription desc, Pango.Language language);
	}
	[CCode (cheader_filename = "pango/pango.h")]
	public class Layout : GLib.Object {
		[NoArrayLength]
		[CCode (cname = "pango_layout_context_changed")]
		public void context_changed ();
		[NoArrayLength]
		[CCode (cname = "pango_layout_copy")]
		public weak Pango.Layout copy ();
		[NoArrayLength]
		[CCode (cname = "pango_layout_get_alignment")]
		public Pango.Alignment get_alignment ();
		[NoArrayLength]
		[CCode (cname = "pango_layout_get_attributes")]
		public weak Pango.AttrList get_attributes ();
		[NoArrayLength]
		[CCode (cname = "pango_layout_get_auto_dir")]
		public bool get_auto_dir ();
		[NoArrayLength]
		[CCode (cname = "pango_layout_get_context")]
		public weak Pango.Context get_context ();
		[NoArrayLength]
		[CCode (cname = "pango_layout_get_cursor_pos")]
		public void get_cursor_pos (int index_, ref Pango.Rectangle strong_pos, ref Pango.Rectangle weak_pos);
		[NoArrayLength]
		[CCode (cname = "pango_layout_get_ellipsize")]
		public Pango.EllipsizeMode get_ellipsize ();
		[NoArrayLength]
		[CCode (cname = "pango_layout_get_extents")]
		public void get_extents (ref Pango.Rectangle ink_rect, ref Pango.Rectangle logical_rect);
		[NoArrayLength]
		[CCode (cname = "pango_layout_get_font_description")]
		public weak Pango.FontDescription get_font_description ();
		[NoArrayLength]
		[CCode (cname = "pango_layout_get_indent")]
		public int get_indent ();
		[NoArrayLength]
		[CCode (cname = "pango_layout_get_iter")]
		public weak Pango.LayoutIter get_iter ();
		[NoArrayLength]
		[CCode (cname = "pango_layout_get_justify")]
		public bool get_justify ();
		[NoArrayLength]
		[CCode (cname = "pango_layout_get_line")]
		public weak Pango.LayoutLine get_line (int line);
		[NoArrayLength]
		[CCode (cname = "pango_layout_get_line_count")]
		public int get_line_count ();
		[NoArrayLength]
		[CCode (cname = "pango_layout_get_line_readonly")]
		public weak Pango.LayoutLine get_line_readonly (int line);
		[NoArrayLength]
		[CCode (cname = "pango_layout_get_lines")]
		public weak GLib.SList get_lines ();
		[NoArrayLength]
		[CCode (cname = "pango_layout_get_lines_readonly")]
		public weak GLib.SList get_lines_readonly ();
		[NoArrayLength]
		[CCode (cname = "pango_layout_get_log_attrs")]
		public void get_log_attrs (Pango.LogAttr[] attrs, int n_attrs);
		[NoArrayLength]
		[CCode (cname = "pango_layout_get_pixel_extents")]
		public void get_pixel_extents (ref Pango.Rectangle ink_rect, ref Pango.Rectangle logical_rect);
		[NoArrayLength]
		[CCode (cname = "pango_layout_get_pixel_size")]
		public void get_pixel_size (int width, int height);
		[NoArrayLength]
		[CCode (cname = "pango_layout_get_single_paragraph_mode")]
		public bool get_single_paragraph_mode ();
		[NoArrayLength]
		[CCode (cname = "pango_layout_get_size")]
		public void get_size (int width, int height);
		[NoArrayLength]
		[CCode (cname = "pango_layout_get_spacing")]
		public int get_spacing ();
		[NoArrayLength]
		[CCode (cname = "pango_layout_get_tabs")]
		public weak Pango.TabArray get_tabs ();
		[NoArrayLength]
		[CCode (cname = "pango_layout_get_text")]
		public weak string get_text ();
		[NoArrayLength]
		[CCode (cname = "pango_layout_get_type")]
		public static GLib.Type get_type ();
		[NoArrayLength]
		[CCode (cname = "pango_layout_get_unknown_glyphs_count")]
		public int get_unknown_glyphs_count ();
		[NoArrayLength]
		[CCode (cname = "pango_layout_get_width")]
		public int get_width ();
		[NoArrayLength]
		[CCode (cname = "pango_layout_get_wrap")]
		public Pango.WrapMode get_wrap ();
		[NoArrayLength]
		[CCode (cname = "pango_layout_index_to_line_x")]
		public void index_to_line_x (int index_, bool trailing, int line, int x_pos);
		[NoArrayLength]
		[CCode (cname = "pango_layout_index_to_pos")]
		public void index_to_pos (int index_, ref Pango.Rectangle pos);
		[NoArrayLength]
		[CCode (cname = "pango_layout_is_ellipsized")]
		public bool is_ellipsized ();
		[NoArrayLength]
		[CCode (cname = "pango_layout_is_wrapped")]
		public bool is_wrapped ();
		[NoArrayLength]
		[CCode (cname = "pango_layout_move_cursor_visually")]
		public void move_cursor_visually (bool strong, int old_index, int old_trailing, int direction, int new_index, int new_trailing);
		[NoArrayLength]
		[CCode (cname = "pango_layout_new")]
		public Layout (Pango.Context context);
		[NoArrayLength]
		[CCode (cname = "pango_layout_set_alignment")]
		public void set_alignment (Pango.Alignment alignment);
		[NoArrayLength]
		[CCode (cname = "pango_layout_set_attributes")]
		public void set_attributes (Pango.AttrList attrs);
		[NoArrayLength]
		[CCode (cname = "pango_layout_set_auto_dir")]
		public void set_auto_dir (bool auto_dir);
		[NoArrayLength]
		[CCode (cname = "pango_layout_set_ellipsize")]
		public void set_ellipsize (Pango.EllipsizeMode ellipsize);
		[NoArrayLength]
		[CCode (cname = "pango_layout_set_font_description")]
		public void set_font_description (Pango.FontDescription desc);
		[NoArrayLength]
		[CCode (cname = "pango_layout_set_indent")]
		public void set_indent (int indent);
		[NoArrayLength]
		[CCode (cname = "pango_layout_set_justify")]
		public void set_justify (bool justify);
		[NoArrayLength]
		[CCode (cname = "pango_layout_set_markup")]
		public void set_markup (string markup, int length);
		[NoArrayLength]
		[CCode (cname = "pango_layout_set_markup_with_accel")]
		public void set_markup_with_accel (string markup, int length, unichar accel_marker, unichar accel_char);
		[NoArrayLength]
		[CCode (cname = "pango_layout_set_single_paragraph_mode")]
		public void set_single_paragraph_mode (bool setting);
		[NoArrayLength]
		[CCode (cname = "pango_layout_set_spacing")]
		public void set_spacing (int spacing);
		[NoArrayLength]
		[CCode (cname = "pango_layout_set_tabs")]
		public void set_tabs (Pango.TabArray tabs);
		[NoArrayLength]
		[CCode (cname = "pango_layout_set_text")]
		public void set_text (string text, int length);
		[NoArrayLength]
		[CCode (cname = "pango_layout_set_width")]
		public void set_width (int width);
		[NoArrayLength]
		[CCode (cname = "pango_layout_set_wrap")]
		public void set_wrap (Pango.WrapMode wrap);
		[NoArrayLength]
		[CCode (cname = "pango_layout_xy_to_index")]
		public bool xy_to_index (int x, int y, int index_, int trailing);
	}
	[CCode (cheader_filename = "pango/pango.h")]
	public class Renderer : GLib.Object {
		public Pango.Matrix matrix;
		[NoArrayLength]
		[CCode (cname = "pango_renderer_activate")]
		public void activate ();
		[NoArrayLength]
		[CCode (cname = "pango_renderer_deactivate")]
		public void deactivate ();
		[NoArrayLength]
		[CCode (cname = "pango_renderer_draw_error_underline")]
		public virtual void draw_error_underline (int x, int y, int width, int height);
		[NoArrayLength]
		[CCode (cname = "pango_renderer_draw_glyph")]
		public virtual void draw_glyph (Pango.Font font, uint glyph, double x, double y);
		[NoArrayLength]
		[CCode (cname = "pango_renderer_draw_glyphs")]
		public virtual void draw_glyphs (Pango.Font font, Pango.GlyphString glyphs, int x, int y);
		[NoArrayLength]
		[CCode (cname = "pango_renderer_draw_layout")]
		public void draw_layout (Pango.Layout layout, int x, int y);
		[NoArrayLength]
		[CCode (cname = "pango_renderer_draw_layout_line")]
		public void draw_layout_line (Pango.LayoutLine line, int x, int y);
		[NoArrayLength]
		[CCode (cname = "pango_renderer_draw_rectangle")]
		public virtual void draw_rectangle (Pango.RenderPart part, int x, int y, int width, int height);
		[NoArrayLength]
		[CCode (cname = "pango_renderer_draw_trapezoid")]
		public virtual void draw_trapezoid (Pango.RenderPart part, double y1_, double x11, double x21, double y2, double x12, double x22);
		[NoArrayLength]
		[CCode (cname = "pango_renderer_get_color")]
		public Pango.Color get_color (Pango.RenderPart part);
		[NoArrayLength]
		[CCode (cname = "pango_renderer_get_matrix")]
		public Pango.Matrix get_matrix ();
		[NoArrayLength]
		[CCode (cname = "pango_renderer_get_type")]
		public static GLib.Type get_type ();
		[NoArrayLength]
		[CCode (cname = "pango_renderer_part_changed")]
		public virtual void part_changed (Pango.RenderPart part);
		[NoArrayLength]
		[CCode (cname = "pango_renderer_set_color")]
		public void set_color (Pango.RenderPart part, ref Pango.Color color);
		[NoArrayLength]
		[CCode (cname = "pango_renderer_set_matrix")]
		public void set_matrix (ref Pango.Matrix matrix);
	}
	[ReferenceType]
	public struct Analysis {
		public weak Pango.EngineShape shape_engine;
		public weak Pango.EngineLang lang_engine;
		public weak Pango.Font font;
		public uchar level;
		public uchar gravity;
		public uchar @flags;
		public weak Pango.Language language;
		public weak GLib.SList extra_attrs;
	}
	[ReferenceType]
	public struct AttrClass {
		public Pango.AttrType type;
	}
	[ReferenceType]
	public struct AttrColor {
		public weak Pango.Attribute attr;
		public Pango.Color color;
	}
	[ReferenceType]
	public struct AttrFloat {
		public weak Pango.Attribute attr;
		public double value;
	}
	[ReferenceType]
	public struct AttrFontDesc {
		public weak Pango.Attribute attr;
		public weak Pango.FontDescription desc;
		[NoArrayLength]
		[CCode (cname = "pango_attr_font_desc_new")]
		public AttrFontDesc (Pango.FontDescription desc);
	}
	[ReferenceType]
	public struct AttrInt {
		public weak Pango.Attribute attr;
		public int value;
	}
	[ReferenceType]
	public struct AttrIterator {
		[NoArrayLength]
		[CCode (cname = "pango_attr_iterator_copy")]
		public weak Pango.AttrIterator copy ();
		[NoArrayLength]
		[CCode (cname = "pango_attr_iterator_destroy")]
		public void destroy ();
		[NoArrayLength]
		[CCode (cname = "pango_attr_iterator_get")]
		public weak Pango.Attribute @get (Pango.AttrType type);
		[NoArrayLength]
		[CCode (cname = "pango_attr_iterator_get_attrs")]
		public weak GLib.SList get_attrs ();
		[NoArrayLength]
		[CCode (cname = "pango_attr_iterator_get_font")]
		public void get_font (Pango.FontDescription desc, Pango.Language language, GLib.SList extra_attrs);
		[NoArrayLength]
		[CCode (cname = "pango_attr_iterator_next")]
		public bool next ();
		[NoArrayLength]
		[CCode (cname = "pango_attr_iterator_range")]
		public void range (int start, int end);
	}
	[ReferenceType]
	public struct AttrLanguage {
		public weak Pango.Attribute attr;
		public weak Pango.Language value;
		[NoArrayLength]
		[CCode (cname = "pango_attr_language_new")]
		public AttrLanguage (Pango.Language language);
	}
	[ReferenceType]
	public struct AttrList {
		[NoArrayLength]
		[CCode (cname = "pango_attr_list_change")]
		public void change (Pango.Attribute attr);
		[NoArrayLength]
		[CCode (cname = "pango_attr_list_copy")]
		public weak Pango.AttrList copy ();
		[NoArrayLength]
		[CCode (cname = "pango_attr_list_filter")]
		public weak Pango.AttrList filter (Pango.AttrFilterFunc func, pointer data);
		[NoArrayLength]
		[CCode (cname = "pango_attr_list_get_iterator")]
		public weak Pango.AttrIterator get_iterator ();
		[NoArrayLength]
		[CCode (cname = "pango_attr_list_get_type")]
		public static GLib.Type get_type ();
		[NoArrayLength]
		[CCode (cname = "pango_attr_list_insert")]
		public void insert (Pango.Attribute attr);
		[NoArrayLength]
		[CCode (cname = "pango_attr_list_insert_before")]
		public void insert_before (Pango.Attribute attr);
		[NoArrayLength]
		[CCode (cname = "pango_attr_list_new")]
		public AttrList ();
		[NoArrayLength]
		[CCode (cname = "pango_attr_list_ref")]
		public weak Pango.AttrList @ref ();
		[NoArrayLength]
		[CCode (cname = "pango_attr_list_splice")]
		public void splice (Pango.AttrList other, int pos, int len);
		[NoArrayLength]
		[CCode (cname = "pango_attr_list_unref")]
		public void unref ();
	}
	[ReferenceType]
	public struct AttrShape {
		public weak Pango.Attribute attr;
		public Pango.Rectangle ink_rect;
		public Pango.Rectangle logical_rect;
		public pointer data;
		public Pango.AttrDataCopyFunc copy_func;
		public GLib.DestroyNotify destroy_func;
		[NoArrayLength]
		[CCode (cname = "pango_attr_shape_new")]
		public AttrShape (ref Pango.Rectangle ink_rect, ref Pango.Rectangle logical_rect);
		[NoArrayLength]
		[CCode (cname = "pango_attr_shape_new_with_data")]
		public AttrShape.with_data (ref Pango.Rectangle ink_rect, ref Pango.Rectangle logical_rect, pointer data, Pango.AttrDataCopyFunc copy_func, GLib.DestroyNotify destroy_func);
	}
	[ReferenceType]
	public struct AttrSize {
		public weak Pango.Attribute attr;
		public int size;
		public uint absolute;
		[NoArrayLength]
		[CCode (cname = "pango_attr_size_new")]
		public AttrSize (int size);
	}
	[ReferenceType]
	public struct AttrString {
		public weak Pango.Attribute attr;
		public weak string value;
	}
	[ReferenceType]
	public struct Attribute {
		public pointer klass;
		public uint start_index;
		public uint end_index;
		[NoArrayLength]
		[CCode (cname = "pango_attribute_copy")]
		public weak Pango.Attribute copy ();
		[NoArrayLength]
		[CCode (cname = "pango_attribute_destroy")]
		public void destroy ();
		[NoArrayLength]
		[CCode (cname = "pango_attribute_equal")]
		public bool equal (Pango.Attribute attr2);
	}
	public struct Color {
		public ushort red;
		public ushort green;
		public ushort blue;
		[NoArrayLength]
		[InstanceByReference]
		[CCode (cname = "pango_color_copy")]
		public Pango.Color copy ();
		[NoArrayLength]
		[InstanceByReference]
		[CCode (cname = "pango_color_free")]
		public void free ();
		[NoArrayLength]
		[CCode (cname = "pango_color_get_type")]
		public static GLib.Type get_type ();
		[NoArrayLength]
		[InstanceByReference]
		[CCode (cname = "pango_color_parse")]
		public bool parse (string spec);
		[NoArrayLength]
		[InstanceByReference]
		[CCode (cname = "pango_color_to_string")]
		public weak string to_string ();
	}
	[ReferenceType]
	public struct Coverage {
		[NoArrayLength]
		[CCode (cname = "pango_coverage_copy")]
		public weak Pango.Coverage copy ();
		[NoArrayLength]
		[CCode (cname = "pango_coverage_from_bytes")]
		public static weak Pango.Coverage from_bytes (uchar[] bytes, int n_bytes);
		[NoArrayLength]
		[CCode (cname = "pango_coverage_get")]
		public Pango.CoverageLevel @get (int index_);
		[NoArrayLength]
		[CCode (cname = "pango_coverage_max")]
		public void max (Pango.Coverage other);
		[NoArrayLength]
		[CCode (cname = "pango_coverage_new")]
		public Coverage ();
		[NoArrayLength]
		[CCode (cname = "pango_coverage_ref")]
		public weak Pango.Coverage @ref ();
		[NoArrayLength]
		[CCode (cname = "pango_coverage_set")]
		public void @set (int index_, Pango.CoverageLevel level);
		[NoArrayLength]
		[CCode (cname = "pango_coverage_to_bytes")]
		public void to_bytes (uchar[] bytes, int n_bytes);
		[NoArrayLength]
		[CCode (cname = "pango_coverage_unref")]
		public void unref ();
	}
	[ReferenceType]
	public struct EngineLang {
	}
	[ReferenceType]
	public struct EngineShape {
	}
	[ReferenceType]
	public struct FontDescription {
		[NoArrayLength]
		[CCode (cname = "pango_font_description_better_match")]
		public bool better_match (Pango.FontDescription old_match, Pango.FontDescription new_match);
		[NoArrayLength]
		[CCode (cname = "pango_font_description_copy")]
		public weak Pango.FontDescription copy ();
		[NoArrayLength]
		[CCode (cname = "pango_font_description_copy_static")]
		public weak Pango.FontDescription copy_static ();
		[NoArrayLength]
		[CCode (cname = "pango_font_description_equal")]
		public bool equal (Pango.FontDescription desc2);
		[NoArrayLength]
		[CCode (cname = "pango_font_description_free")]
		public void free ();
		[NoArrayLength]
		[CCode (cname = "pango_font_description_from_string")]
		public static weak Pango.FontDescription from_string (string str);
		[NoArrayLength]
		[CCode (cname = "pango_font_description_get_family")]
		public weak string get_family ();
		[NoArrayLength]
		[CCode (cname = "pango_font_description_get_gravity")]
		public Pango.Gravity get_gravity ();
		[NoArrayLength]
		[CCode (cname = "pango_font_description_get_set_fields")]
		public Pango.FontMask get_set_fields ();
		[NoArrayLength]
		[CCode (cname = "pango_font_description_get_size")]
		public int get_size ();
		[NoArrayLength]
		[CCode (cname = "pango_font_description_get_size_is_absolute")]
		public bool get_size_is_absolute ();
		[NoArrayLength]
		[CCode (cname = "pango_font_description_get_stretch")]
		public Pango.Stretch get_stretch ();
		[NoArrayLength]
		[CCode (cname = "pango_font_description_get_style")]
		public Pango.Style get_style ();
		[NoArrayLength]
		[CCode (cname = "pango_font_description_get_type")]
		public static GLib.Type get_type ();
		[NoArrayLength]
		[CCode (cname = "pango_font_description_get_variant")]
		public Pango.Variant get_variant ();
		[NoArrayLength]
		[CCode (cname = "pango_font_description_get_weight")]
		public Pango.Weight get_weight ();
		[NoArrayLength]
		[CCode (cname = "pango_font_description_hash")]
		public uint hash ();
		[NoArrayLength]
		[CCode (cname = "pango_font_description_merge")]
		public void merge (Pango.FontDescription desc_to_merge, bool replace_existing);
		[NoArrayLength]
		[CCode (cname = "pango_font_description_merge_static")]
		public void merge_static (Pango.FontDescription desc_to_merge, bool replace_existing);
		[NoArrayLength]
		[CCode (cname = "pango_font_description_new")]
		public FontDescription ();
		[NoArrayLength]
		[CCode (cname = "pango_font_description_set_absolute_size")]
		public void set_absolute_size (double size);
		[NoArrayLength]
		[CCode (cname = "pango_font_description_set_family")]
		public void set_family (string family);
		[NoArrayLength]
		[CCode (cname = "pango_font_description_set_family_static")]
		public void set_family_static (string family);
		[NoArrayLength]
		[CCode (cname = "pango_font_description_set_gravity")]
		public void set_gravity (Pango.Gravity gravity);
		[NoArrayLength]
		[CCode (cname = "pango_font_description_set_size")]
		public void set_size (int size);
		[NoArrayLength]
		[CCode (cname = "pango_font_description_set_stretch")]
		public void set_stretch (Pango.Stretch stretch);
		[NoArrayLength]
		[CCode (cname = "pango_font_description_set_style")]
		public void set_style (Pango.Style style);
		[NoArrayLength]
		[CCode (cname = "pango_font_description_set_variant")]
		public void set_variant (Pango.Variant variant);
		[NoArrayLength]
		[CCode (cname = "pango_font_description_set_weight")]
		public void set_weight (Pango.Weight weight);
		[NoArrayLength]
		[CCode (cname = "pango_font_description_to_filename")]
		public weak string to_filename ();
		[NoArrayLength]
		[CCode (cname = "pango_font_description_to_string")]
		public weak string to_string ();
		[NoArrayLength]
		[CCode (cname = "pango_font_description_unset_fields")]
		public void unset_fields (Pango.FontMask to_unset);
	}
	[ReferenceType]
	public struct FontMetrics {
		[NoArrayLength]
		[CCode (cname = "pango_font_metrics_get_approximate_char_width")]
		public int get_approximate_char_width ();
		[NoArrayLength]
		[CCode (cname = "pango_font_metrics_get_approximate_digit_width")]
		public int get_approximate_digit_width ();
		[NoArrayLength]
		[CCode (cname = "pango_font_metrics_get_ascent")]
		public int get_ascent ();
		[NoArrayLength]
		[CCode (cname = "pango_font_metrics_get_descent")]
		public int get_descent ();
		[NoArrayLength]
		[CCode (cname = "pango_font_metrics_get_strikethrough_position")]
		public int get_strikethrough_position ();
		[NoArrayLength]
		[CCode (cname = "pango_font_metrics_get_strikethrough_thickness")]
		public int get_strikethrough_thickness ();
		[NoArrayLength]
		[CCode (cname = "pango_font_metrics_get_type")]
		public static GLib.Type get_type ();
		[NoArrayLength]
		[CCode (cname = "pango_font_metrics_get_underline_position")]
		public int get_underline_position ();
		[NoArrayLength]
		[CCode (cname = "pango_font_metrics_get_underline_thickness")]
		public int get_underline_thickness ();
		[NoArrayLength]
		[CCode (cname = "pango_font_metrics_ref")]
		public weak Pango.FontMetrics @ref ();
		[NoArrayLength]
		[CCode (cname = "pango_font_metrics_unref")]
		public void unref ();
	}
	[ReferenceType]
	public struct GlyphGeometry {
		public int width;
		public int x_offset;
		public int y_offset;
	}
	[ReferenceType]
	public struct GlyphInfo {
		public uint glyph;
		public weak Pango.GlyphGeometry geometry;
		public weak Pango.GlyphVisAttr attr;
	}
	[ReferenceType]
	public struct GlyphItem {
		public weak Pango.Item item;
		public weak Pango.GlyphString glyphs;
		[NoArrayLength]
		[CCode (cname = "pango_glyph_item_apply_attrs")]
		public weak GLib.SList apply_attrs (string text, Pango.AttrList list);
		[NoArrayLength]
		[CCode (cname = "pango_glyph_item_free")]
		public void free ();
		[NoArrayLength]
		[CCode (cname = "pango_glyph_item_letter_space")]
		public void letter_space (string text, Pango.LogAttr log_attrs, int letter_spacing);
		[NoArrayLength]
		[CCode (cname = "pango_glyph_item_split")]
		public weak Pango.GlyphItem split (string text, int split_index);
	}
	[ReferenceType]
	public struct GlyphString {
		public int num_glyphs;
		public weak Pango.GlyphInfo glyphs;
		public int log_clusters;
		[NoArrayLength]
		[CCode (cname = "pango_glyph_string_copy")]
		public weak Pango.GlyphString copy ();
		[NoArrayLength]
		[CCode (cname = "pango_glyph_string_extents")]
		public void extents (Pango.Font font, ref Pango.Rectangle ink_rect, ref Pango.Rectangle logical_rect);
		[NoArrayLength]
		[CCode (cname = "pango_glyph_string_extents_range")]
		public void extents_range (int start, int end, Pango.Font font, ref Pango.Rectangle ink_rect, ref Pango.Rectangle logical_rect);
		[NoArrayLength]
		[CCode (cname = "pango_glyph_string_free")]
		public void free ();
		[NoArrayLength]
		[CCode (cname = "pango_glyph_string_get_logical_widths")]
		public void get_logical_widths (string text, int length, int embedding_level, int logical_widths);
		[NoArrayLength]
		[CCode (cname = "pango_glyph_string_get_type")]
		public static GLib.Type get_type ();
		[NoArrayLength]
		[CCode (cname = "pango_glyph_string_get_width")]
		public int get_width ();
		[NoArrayLength]
		[CCode (cname = "pango_glyph_string_index_to_x")]
		public void index_to_x (string text, int length, Pango.Analysis analysis, int index_, bool trailing, int x_pos);
		[NoArrayLength]
		[CCode (cname = "pango_glyph_string_new")]
		public GlyphString ();
		[NoArrayLength]
		[CCode (cname = "pango_glyph_string_set_size")]
		public void set_size (int new_len);
		[NoArrayLength]
		[CCode (cname = "pango_glyph_string_x_to_index")]
		public void x_to_index (string text, int length, Pango.Analysis analysis, int x_pos, int index_, int trailing);
	}
	[ReferenceType]
	public struct GlyphVisAttr {
		public uint is_cluster_start;
	}
	[ReferenceType]
	public struct Item {
		public int offset;
		public int length;
		public int num_chars;
		public weak Pango.Analysis analysis;
		[NoArrayLength]
		[CCode (cname = "pango_item_copy")]
		public weak Pango.Item copy ();
		[NoArrayLength]
		[CCode (cname = "pango_item_free")]
		public void free ();
		[NoArrayLength]
		[CCode (cname = "pango_item_get_type")]
		public static GLib.Type get_type ();
		[NoArrayLength]
		[CCode (cname = "pango_item_new")]
		public Item ();
		[NoArrayLength]
		[CCode (cname = "pango_item_split")]
		public weak Pango.Item split (int split_index, int split_offset);
	}
	[ReferenceType]
	public struct Language {
		[NoArrayLength]
		[CCode (cname = "pango_language_from_string")]
		public static weak Pango.Language from_string (string language);
		[NoArrayLength]
		[CCode (cname = "pango_language_get_default")]
		public static weak Pango.Language get_default ();
		[NoArrayLength]
		[CCode (cname = "pango_language_get_sample_string")]
		public weak string get_sample_string ();
		[NoArrayLength]
		[CCode (cname = "pango_language_get_type")]
		public static GLib.Type get_type ();
		[NoArrayLength]
		[CCode (cname = "pango_language_includes_script")]
		public bool includes_script (Pango.Script script);
		[NoArrayLength]
		[CCode (cname = "pango_language_matches")]
		public bool matches (string range_list);
	}
	[ReferenceType]
	public struct LayoutIter {
		[NoArrayLength]
		[CCode (cname = "pango_layout_iter_at_last_line")]
		public bool at_last_line ();
		[NoArrayLength]
		[CCode (cname = "pango_layout_iter_free")]
		public void free ();
		[NoArrayLength]
		[CCode (cname = "pango_layout_iter_get_baseline")]
		public int get_baseline ();
		[NoArrayLength]
		[CCode (cname = "pango_layout_iter_get_char_extents")]
		public void get_char_extents (ref Pango.Rectangle logical_rect);
		[NoArrayLength]
		[CCode (cname = "pango_layout_iter_get_cluster_extents")]
		public void get_cluster_extents (ref Pango.Rectangle ink_rect, ref Pango.Rectangle logical_rect);
		[NoArrayLength]
		[CCode (cname = "pango_layout_iter_get_index")]
		public int get_index ();
		[NoArrayLength]
		[CCode (cname = "pango_layout_iter_get_layout_extents")]
		public void get_layout_extents (ref Pango.Rectangle ink_rect, ref Pango.Rectangle logical_rect);
		[NoArrayLength]
		[CCode (cname = "pango_layout_iter_get_line")]
		public weak Pango.LayoutLine get_line ();
		[NoArrayLength]
		[CCode (cname = "pango_layout_iter_get_line_extents")]
		public void get_line_extents (ref Pango.Rectangle ink_rect, ref Pango.Rectangle logical_rect);
		[NoArrayLength]
		[CCode (cname = "pango_layout_iter_get_line_readonly")]
		public weak Pango.LayoutLine get_line_readonly ();
		[NoArrayLength]
		[CCode (cname = "pango_layout_iter_get_line_yrange")]
		public void get_line_yrange (int y0_, int y1_);
		[NoArrayLength]
		[CCode (cname = "pango_layout_iter_get_run")]
		public weak Pango.LayoutRun get_run ();
		[NoArrayLength]
		[CCode (cname = "pango_layout_iter_get_run_extents")]
		public void get_run_extents (ref Pango.Rectangle ink_rect, ref Pango.Rectangle logical_rect);
		[NoArrayLength]
		[CCode (cname = "pango_layout_iter_get_run_readonly")]
		public weak Pango.LayoutRun get_run_readonly ();
		[NoArrayLength]
		[CCode (cname = "pango_layout_iter_get_type")]
		public static GLib.Type get_type ();
		[NoArrayLength]
		[CCode (cname = "pango_layout_iter_next_char")]
		public bool next_char ();
		[NoArrayLength]
		[CCode (cname = "pango_layout_iter_next_cluster")]
		public bool next_cluster ();
		[NoArrayLength]
		[CCode (cname = "pango_layout_iter_next_line")]
		public bool next_line ();
		[NoArrayLength]
		[CCode (cname = "pango_layout_iter_next_run")]
		public bool next_run ();
	}
	[ReferenceType]
	public struct LayoutLine {
		public weak Pango.Layout layout;
		public int start_index;
		public int length;
		public weak GLib.SList runs;
		public uint is_paragraph_start;
		public uint resolved_dir;
		[NoArrayLength]
		[CCode (cname = "pango_layout_line_get_extents")]
		public void get_extents (ref Pango.Rectangle ink_rect, ref Pango.Rectangle logical_rect);
		[NoArrayLength]
		[CCode (cname = "pango_layout_line_get_pixel_extents")]
		public void get_pixel_extents (ref Pango.Rectangle ink_rect, ref Pango.Rectangle logical_rect);
		[NoArrayLength]
		[CCode (cname = "pango_layout_line_get_type")]
		public static GLib.Type get_type ();
		[NoArrayLength]
		[CCode (cname = "pango_layout_line_get_x_ranges")]
		public void get_x_ranges (int start_index, int end_index, int[] ranges, int n_ranges);
		[NoArrayLength]
		[CCode (cname = "pango_layout_line_index_to_x")]
		public void index_to_x (int index_, bool trailing, int x_pos);
		[NoArrayLength]
		[CCode (cname = "pango_layout_line_ref")]
		public weak Pango.LayoutLine @ref ();
		[NoArrayLength]
		[CCode (cname = "pango_layout_line_unref")]
		public void unref ();
		[NoArrayLength]
		[CCode (cname = "pango_layout_line_x_to_index")]
		public bool x_to_index (int x_pos, int index_, int trailing);
	}
	[ReferenceType]
	public struct LayoutRun {
		public weak Pango.Item item;
		public weak Pango.GlyphString glyphs;
	}
	[ReferenceType]
	public struct LogAttr {
		public uint is_line_break;
		public uint is_mandatory_break;
		public uint is_char_break;
		public uint is_white;
		public uint is_cursor_position;
		public uint is_word_start;
		public uint is_word_end;
		public uint is_sentence_boundary;
		public uint is_sentence_start;
		public uint is_sentence_end;
		public uint backspace_deletes_character;
	}
	public struct Matrix {
		public double xx;
		public double xy;
		public double yx;
		public double yy;
		public double x0;
		public double y0;
		[NoArrayLength]
		[InstanceByReference]
		[CCode (cname = "pango_matrix_concat")]
		public void concat (ref Pango.Matrix new_matrix);
		[NoArrayLength]
		[InstanceByReference]
		[CCode (cname = "pango_matrix_copy")]
		public Pango.Matrix copy ();
		[NoArrayLength]
		[InstanceByReference]
		[CCode (cname = "pango_matrix_free")]
		public void free ();
		[NoArrayLength]
		[InstanceByReference]
		[CCode (cname = "pango_matrix_get_font_scale_factor")]
		public double get_font_scale_factor ();
		[NoArrayLength]
		[CCode (cname = "pango_matrix_get_type")]
		public static GLib.Type get_type ();
		[NoArrayLength]
		[InstanceByReference]
		[CCode (cname = "pango_matrix_rotate")]
		public void rotate (double degrees);
		[NoArrayLength]
		[InstanceByReference]
		[CCode (cname = "pango_matrix_scale")]
		public void scale (double scale_x, double scale_y);
		[NoArrayLength]
		[InstanceByReference]
		[CCode (cname = "pango_matrix_transform_distance")]
		public void transform_distance (double dx, double dy);
		[NoArrayLength]
		[InstanceByReference]
		[CCode (cname = "pango_matrix_transform_pixel_rectangle")]
		public void transform_pixel_rectangle (ref Pango.Rectangle rect);
		[NoArrayLength]
		[InstanceByReference]
		[CCode (cname = "pango_matrix_transform_point")]
		public void transform_point (double x, double y);
		[NoArrayLength]
		[InstanceByReference]
		[CCode (cname = "pango_matrix_transform_rectangle")]
		public void transform_rectangle (ref Pango.Rectangle rect);
		[NoArrayLength]
		[InstanceByReference]
		[CCode (cname = "pango_matrix_translate")]
		public void translate (double tx, double ty);
	}
	public struct Rectangle {
		public int x;
		public int y;
		public int width;
		public int height;
	}
	[ReferenceType]
	public struct ScriptIter {
		[NoArrayLength]
		[CCode (cname = "pango_script_iter_free")]
		public void free ();
		[NoArrayLength]
		[CCode (cname = "pango_script_iter_get_range")]
		public void get_range (string start, string end, Pango.Script script);
		[NoArrayLength]
		[CCode (cname = "pango_script_iter_new")]
		public ScriptIter (string text, int length);
		[NoArrayLength]
		[CCode (cname = "pango_script_iter_next")]
		public bool next ();
	}
	[ReferenceType]
	public struct TabArray {
		[NoArrayLength]
		[CCode (cname = "pango_tab_array_copy")]
		public weak Pango.TabArray copy ();
		[NoArrayLength]
		[CCode (cname = "pango_tab_array_free")]
		public void free ();
		[NoArrayLength]
		[CCode (cname = "pango_tab_array_get_positions_in_pixels")]
		public bool get_positions_in_pixels ();
		[NoArrayLength]
		[CCode (cname = "pango_tab_array_get_size")]
		public int get_size ();
		[NoArrayLength]
		[CCode (cname = "pango_tab_array_get_tab")]
		public void get_tab (int tab_index, Pango.TabAlign alignment, int location);
		[NoArrayLength]
		[CCode (cname = "pango_tab_array_get_tabs")]
		public void get_tabs (Pango.TabAlign alignments, int locations);
		[NoArrayLength]
		[CCode (cname = "pango_tab_array_get_type")]
		public static GLib.Type get_type ();
		[NoArrayLength]
		[CCode (cname = "pango_tab_array_new")]
		public TabArray (int initial_size, bool positions_in_pixels);
		[NoArrayLength]
		[CCode (cname = "pango_tab_array_new_with_positions")]
		public TabArray.with_positions (int size, bool positions_in_pixels, Pango.TabAlign first_alignment, int first_position);
		[NoArrayLength]
		[CCode (cname = "pango_tab_array_resize")]
		public void resize (int new_size);
		[NoArrayLength]
		[CCode (cname = "pango_tab_array_set_tab")]
		public void set_tab (int tab_index, Pango.TabAlign alignment, int location);
	}
	[ReferenceType]
	public struct Win32FontCache {
		[NoArrayLength]
		[CCode (cname = "pango_win32_font_cache_free")]
		public void free ();
		[NoArrayLength]
		[CCode (cname = "pango_win32_font_cache_load")]
		public pointer load (pointer logfont);
		[NoArrayLength]
		[CCode (cname = "pango_win32_font_cache_loadw")]
		public pointer loadw (pointer logfont);
		[NoArrayLength]
		[CCode (cname = "pango_win32_font_cache_new")]
		public Win32FontCache ();
		[NoArrayLength]
		[CCode (cname = "pango_win32_font_cache_unload")]
		public void unload (pointer hfont);
	}
	[ReferenceType]
	public struct Attr {
		[NoArrayLength]
		[CCode (cname = "pango_attr_background_new")]
		public static weak Pango.Attribute background_new (ushort red, ushort green, ushort blue);
		[NoArrayLength]
		[CCode (cname = "pango_attr_fallback_new")]
		public static weak Pango.Attribute fallback_new (bool enable_fallback);
		[NoArrayLength]
		[CCode (cname = "pango_attr_family_new")]
		public static weak Pango.Attribute family_new (string family);
		[NoArrayLength]
		[CCode (cname = "pango_attr_foreground_new")]
		public static weak Pango.Attribute foreground_new (ushort red, ushort green, ushort blue);
		[NoArrayLength]
		[CCode (cname = "pango_attr_gravity_hint_new")]
		public static weak Pango.Attribute gravity_hint_new (Pango.GravityHint hint);
		[NoArrayLength]
		[CCode (cname = "pango_attr_gravity_new")]
		public static weak Pango.Attribute gravity_new (Pango.Gravity gravity);
		[NoArrayLength]
		[CCode (cname = "pango_attr_letter_spacing_new")]
		public static weak Pango.Attribute letter_spacing_new (int letter_spacing);
		[NoArrayLength]
		[CCode (cname = "pango_attr_rise_new")]
		public static weak Pango.Attribute rise_new (int rise);
		[NoArrayLength]
		[CCode (cname = "pango_attr_scale_new")]
		public static weak Pango.Attribute scale_new (double scale_factor);
		[NoArrayLength]
		[CCode (cname = "pango_attr_stretch_new")]
		public static weak Pango.Attribute stretch_new (Pango.Stretch stretch);
		[NoArrayLength]
		[CCode (cname = "pango_attr_strikethrough_color_new")]
		public static weak Pango.Attribute strikethrough_color_new (ushort red, ushort green, ushort blue);
		[NoArrayLength]
		[CCode (cname = "pango_attr_strikethrough_new")]
		public static weak Pango.Attribute strikethrough_new (bool strikethrough);
		[NoArrayLength]
		[CCode (cname = "pango_attr_style_new")]
		public static weak Pango.Attribute style_new (Pango.Style style);
		[NoArrayLength]
		[CCode (cname = "pango_attr_type_register")]
		public static Pango.AttrType type_register (string name);
		[NoArrayLength]
		[CCode (cname = "pango_attr_underline_color_new")]
		public static weak Pango.Attribute underline_color_new (ushort red, ushort green, ushort blue);
		[NoArrayLength]
		[CCode (cname = "pango_attr_underline_new")]
		public static weak Pango.Attribute underline_new (Pango.Underline underline);
		[NoArrayLength]
		[CCode (cname = "pango_attr_variant_new")]
		public static weak Pango.Attribute variant_new (Pango.Variant variant);
		[NoArrayLength]
		[CCode (cname = "pango_attr_weight_new")]
		public static weak Pango.Attribute weight_new (Pango.Weight weight);
	}
	[ReferenceType]
	public struct Units {
		[NoArrayLength]
		[CCode (cname = "pango_units_from_double")]
		public static int from_double (double d);
		[NoArrayLength]
		[CCode (cname = "pango_units_to_double")]
		public static double to_double (int i);
	}
	[ReferenceType]
	public struct Version {
		[NoArrayLength]
		[CCode (cname = "pango_version_check")]
		public static weak string check (int required_major, int required_minor, int required_micro);
		[NoArrayLength]
		[CCode (cname = "pango_version_string")]
		public static weak string string ();
	}
	public callback pointer AttrDataCopyFunc (pointer data);
	public callback bool AttrFilterFunc (Pango.Attribute attribute, pointer data);
	public callback bool FontsetForeachFunc (Pango.Fontset fontset, Pango.Font font, pointer data);
	[NoArrayLength]
	[CCode (cname = "pango_extents_to_pixels")]
	public static void extents_to_pixels (ref Pango.Rectangle ink_rect, ref Pango.Rectangle logical_rect);
	[NoArrayLength]
	[CCode (cname = "pango_find_base_dir")]
	public static Pango.Direction find_base_dir (string text, int length);
	[NoArrayLength]
	[CCode (cname = "pango_find_paragraph_boundary")]
	public static void find_paragraph_boundary (string text, int length, int paragraph_delimiter_index, int next_paragraph_start);
	[NoArrayLength]
	[CCode (cname = "pango_get_log_attrs")]
	public static void get_log_attrs (string text, int length, int level, Pango.Language language, Pango.LogAttr log_attrs, int attrs_len);
	[NoArrayLength]
	[CCode (cname = "pango_gravity_get_for_matrix")]
	public static Pango.Gravity gravity_get_for_matrix (ref Pango.Matrix matrix);
	[NoArrayLength]
	[CCode (cname = "pango_gravity_get_for_script")]
	public static Pango.Gravity gravity_get_for_script (Pango.Script script, Pango.Gravity base_gravity, Pango.GravityHint hint);
	[NoArrayLength]
	[CCode (cname = "pango_gravity_to_rotation")]
	public static double gravity_to_rotation (Pango.Gravity gravity);
	[NoArrayLength]
	[CCode (cname = "pango_is_zero_width")]
	public static bool is_zero_width (unichar ch);
	[NoArrayLength]
	[CCode (cname = "pango_itemize_with_base_dir")]
	public static weak GLib.List itemize_with_base_dir (Pango.Context context, Pango.Direction base_dir, string text, int start_index, int length, Pango.AttrList attrs, Pango.AttrIterator cached_iter);
	[NoArrayLength]
	[CCode (cname = "pango_parse_enum")]
	public static bool parse_enum (GLib.Type type, string str, int value, bool warn, string possible_values);
	[NoArrayLength]
	[CCode (cname = "pango_parse_markup")]
	public static bool parse_markup (string markup_text, int length, unichar accel_marker, Pango.AttrList attr_list, string text, unichar accel_char, GLib.Error error);
	[NoArrayLength]
	[CCode (cname = "pango_parse_stretch")]
	public static bool parse_stretch (string str, Pango.Stretch stretch, bool warn);
	[NoArrayLength]
	[CCode (cname = "pango_parse_style")]
	public static bool parse_style (string str, Pango.Style style, bool warn);
	[NoArrayLength]
	[CCode (cname = "pango_parse_variant")]
	public static bool parse_variant (string str, Pango.Variant variant, bool warn);
	[NoArrayLength]
	[CCode (cname = "pango_parse_weight")]
	public static bool parse_weight (string str, Pango.Weight weight, bool warn);
	[NoArrayLength]
	[CCode (cname = "pango_quantize_line_geometry")]
	public static void quantize_line_geometry (int thickness, int position);
	[NoArrayLength]
	[CCode (cname = "pango_read_line")]
	public static int read_line (GLib.File stream, GLib.String str);
	[NoArrayLength]
	[CCode (cname = "pango_reorder_items")]
	public static weak GLib.List reorder_items (GLib.List logical_items);
	[NoArrayLength]
	[CCode (cname = "pango_scan_int")]
	public static bool scan_int (string pos, int @out);
	[NoArrayLength]
	[CCode (cname = "pango_scan_string")]
	public static bool scan_string (string pos, GLib.String @out);
	[NoArrayLength]
	[CCode (cname = "pango_scan_word")]
	public static bool scan_word (string pos, GLib.String @out);
	[NoArrayLength]
	[CCode (cname = "pango_script_for_unichar")]
	public static Pango.Script script_for_unichar (unichar ch);
	[NoArrayLength]
	[CCode (cname = "pango_script_get_sample_language")]
	public static weak Pango.Language script_get_sample_language (Pango.Script script);
	[NoArrayLength]
	[CCode (cname = "pango_skip_space")]
	public static bool skip_space (string pos);
	[NoArrayLength]
	[CCode (cname = "pango_split_file_list")]
	public static weak string split_file_list (string str);
	[NoArrayLength]
	[CCode (cname = "pango_trim_string")]
	public static weak string trim_string (string str);
	[NoArrayLength]
	[CCode (cname = "pango_unichar_direction")]
	public static Pango.Direction unichar_direction (unichar ch);
}
