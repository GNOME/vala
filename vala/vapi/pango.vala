[CCode (cheader_filename = "pango/pango.h")]
namespace Pango {
	public class Context : GLib.Object {
		public Pango.Direction get_base_dir ();
		public Pango.FontDescription get_font_description ();
		public Pango.FontMap get_font_map ();
		public Pango.Language get_language ();
		public Pango.Matrix get_matrix ();
		public Pango.FontMetrics get_metrics (Pango.FontDescription desc, Pango.Language language);
		public GLib.Type get_type ();
		public void list_families (Pango.FontFamily families, int n_families);
		public Pango.Font load_font (Pango.FontDescription desc);
		public Pango.Fontset load_fontset (Pango.FontDescription desc, Pango.Language language);
		public void set_base_dir (Pango.Direction direction);
		public void set_font_description (Pango.FontDescription desc);
		public void set_language (Pango.Language language);
		public void set_matrix (Pango.Matrix matrix);
	}
	public class Font : GLib.Object {
		public Pango.FontDescription describe ();
		public Pango.FontDescription describe_with_absolute_size ();
		public static void descriptions_free (Pango.FontDescription descs, int n_descs);
		public Pango.EngineShape find_shaper (Pango.Language language, uint ch);
		public Pango.Coverage get_coverage (Pango.Language language);
		public Pango.FontMap get_font_map ();
		public void get_glyph_extents (uint glyph, Pango.Rectangle ink_rect, Pango.Rectangle logical_rect);
		public Pango.FontMetrics get_metrics (Pango.Language language);
		public GLib.Type get_type ();
	}
	public class Fontset : GLib.Object {
		public void @foreach (Pango.FontsetForeachFunc func, pointer data);
		public Pango.Font get_font (uint wc);
		public Pango.FontMetrics get_metrics ();
		public GLib.Type get_type ();
	}
	public class FontFace : GLib.Object {
		public Pango.FontDescription describe ();
		public string get_face_name ();
		public GLib.Type get_type ();
		public void list_sizes (int sizes, int n_sizes);
	}
	public class FontFamily : GLib.Object {
		public string get_name ();
		public GLib.Type get_type ();
		public bool is_monospace ();
		public void list_faces (Pango.FontFace faces, int n_faces);
	}
	public class FontMap : GLib.Object {
		public GLib.Type get_type ();
		public void list_families (Pango.FontFamily families, int n_families);
		public Pango.Font load_font (Pango.Context context, Pango.FontDescription desc);
		public Pango.Fontset load_fontset (Pango.Context context, Pango.FontDescription desc, Pango.Language language);
	}
	public class Layout : GLib.Object {
		public void context_changed ();
		public Pango.Layout copy ();
		public Pango.Alignment get_alignment ();
		public Pango.AttrList get_attributes ();
		public bool get_auto_dir ();
		public Pango.Context get_context ();
		public void get_cursor_pos (int index_, Pango.Rectangle strong_pos, Pango.Rectangle weak_pos);
		public Pango.EllipsizeMode get_ellipsize ();
		public void get_extents (Pango.Rectangle ink_rect, Pango.Rectangle logical_rect);
		public Pango.FontDescription get_font_description ();
		public int get_indent ();
		public Pango.LayoutIter get_iter ();
		public bool get_justify ();
		public Pango.LayoutLine get_line (int line);
		public int get_line_count ();
		public GLib.SList get_lines ();
		public void get_log_attrs (Pango.LogAttr attrs, int n_attrs);
		public void get_pixel_extents (Pango.Rectangle ink_rect, Pango.Rectangle logical_rect);
		public void get_pixel_size (int width, int height);
		public bool get_single_paragraph_mode ();
		public void get_size (int width, int height);
		public int get_spacing ();
		public Pango.TabArray get_tabs ();
		public string get_text ();
		public GLib.Type get_type ();
		public int get_width ();
		public Pango.WrapMode get_wrap ();
		public void index_to_line_x (int index_, bool trailing, int line, int x_pos);
		public void index_to_pos (int index_, Pango.Rectangle pos);
		public void move_cursor_visually (bool strong, int old_index, int old_trailing, int direction, int new_index, int new_trailing);
		public construct (Pango.Context context);
		public void set_alignment (Pango.Alignment alignment);
		public void set_attributes (Pango.AttrList attrs);
		public void set_auto_dir (bool auto_dir);
		public void set_ellipsize (Pango.EllipsizeMode ellipsize);
		public void set_font_description (Pango.FontDescription desc);
		public void set_indent (int indent);
		public void set_justify (bool justify);
		public void set_markup (string markup, int length);
		public void set_markup_with_accel (string markup, int length, unichar accel_marker, unichar accel_char);
		public void set_single_paragraph_mode (bool setting);
		public void set_spacing (int spacing);
		public void set_tabs (Pango.TabArray tabs);
		public void set_text (string text, int length);
		public void set_width (int width);
		public void set_wrap (Pango.WrapMode wrap);
		public bool xy_to_index (int x, int y, int index_, int trailing);
	}
	public class Renderer : GLib.Object {
		public weak Pango.Matrix matrix;
		public void activate ();
		public void deactivate ();
		public void draw_error_underline (int x, int y, int width, int height);
		public void draw_glyph (Pango.Font font, uint glyph, double x, double y);
		public void draw_glyphs (Pango.Font font, Pango.GlyphString glyphs, int x, int y);
		public void draw_layout (Pango.Layout layout, int x, int y);
		public void draw_layout_line (Pango.LayoutLine line, int x, int y);
		public void draw_rectangle (Pango.RenderPart part, int x, int y, int width, int height);
		public void draw_trapezoid (Pango.RenderPart part, double y1_, double x11, double x21, double y2, double x12, double x22);
		public Pango.Color get_color (Pango.RenderPart part);
		public Pango.Matrix get_matrix ();
		public GLib.Type get_type ();
		public void part_changed (Pango.RenderPart part);
		public void set_color (Pango.RenderPart part, Pango.Color color);
		public void set_matrix (Pango.Matrix matrix);
	}
	[ReferenceType ()]
	public struct Analysis {
		public weak Pango.EngineShape shape_engine;
		public weak Pango.EngineLang lang_engine;
		public weak Pango.Font font;
		public weak uchar level;
		public weak Pango.Language language;
		public weak GLib.SList extra_attrs;
	}
	[ReferenceType ()]
	public struct AttrClass {
		public weak Pango.AttrType type;
	}
	[ReferenceType ()]
	public struct AttrColor {
		public weak Pango.Attribute attr;
		public weak Pango.Color color;
	}
	[ReferenceType ()]
	public struct AttrFloat {
		public weak Pango.Attribute attr;
		public weak double value;
	}
	[ReferenceType ()]
	public struct AttrFontDesc {
		public weak Pango.Attribute attr;
		public weak Pango.FontDescription desc;
		public construct (Pango.FontDescription desc);
	}
	[ReferenceType ()]
	public struct AttrInt {
		public weak Pango.Attribute attr;
		public weak int value;
	}
	[ReferenceType ()]
	public struct AttrIterator {
		public Pango.AttrIterator copy ();
		public void destroy ();
		public Pango.Attribute @get (Pango.AttrType type);
		public GLib.SList get_attrs ();
		public void get_font (Pango.FontDescription desc, Pango.Language language, GLib.SList extra_attrs);
		public bool next ();
		public void range (int start, int end);
	}
	[ReferenceType ()]
	public struct AttrLanguage {
		public weak Pango.Attribute attr;
		public weak Pango.Language value;
		public construct (Pango.Language language);
	}
	public struct AttrList {
		public void change (Pango.Attribute attr);
		public Pango.AttrList copy ();
		public Pango.AttrList filter (Pango.AttrFilterFunc func, pointer data);
		public Pango.AttrIterator get_iterator ();
		public GLib.Type get_type ();
		public void insert (Pango.Attribute attr);
		public void insert_before (Pango.Attribute attr);
		public construct ();
		public Pango.AttrList @ref ();
		public void splice (Pango.AttrList other, int pos, int len);
		public void unref ();
	}
	[ReferenceType ()]
	public struct AttrShape {
		public weak Pango.Attribute attr;
		public weak Pango.Rectangle ink_rect;
		public weak Pango.Rectangle logical_rect;
		public weak pointer data;
		public weak Pango.AttrDataCopyFunc copy_func;
		public weak GLib.DestroyNotify destroy_func;
		public construct (Pango.Rectangle ink_rect, Pango.Rectangle logical_rect);
		public construct with_data (Pango.Rectangle ink_rect, Pango.Rectangle logical_rect, pointer data, Pango.AttrDataCopyFunc copy_func, GLib.DestroyNotify destroy_func);
	}
	[ReferenceType ()]
	public struct AttrSize {
		public weak Pango.Attribute attr;
		public weak int size;
		public weak uint absolute;
		public construct (int size);
	}
	[ReferenceType ()]
	public struct AttrString {
		public weak Pango.Attribute attr;
		public weak string value;
	}
	[ReferenceType ()]
	public struct Attribute {
		public weak pointer klass;
		public weak uint start_index;
		public weak uint end_index;
		public Pango.Attribute copy ();
		public void destroy ();
		public bool equal (Pango.Attribute attr2);
	}
	public struct Color {
		public Pango.Color copy ();
		public void free ();
		public GLib.Type get_type ();
		public bool parse (string spec);
	}
	[ReferenceType ()]
	public struct Coverage {
		public Pango.Coverage copy ();
		public static Pango.Coverage from_bytes (uchar bytes, int n_bytes);
		public Pango.CoverageLevel @get (int index_);
		public void max (Pango.Coverage other);
		public construct ();
		public Pango.Coverage @ref ();
		public void @set (int index_, Pango.CoverageLevel level);
		public void to_bytes (uchar bytes, int n_bytes);
		public void unref ();
	}
	[ReferenceType ()]
	public struct EngineLang {
	}
	[ReferenceType ()]
	public struct EngineShape {
	}
	public struct FontDescription {
		public bool better_match (Pango.FontDescription old_match, Pango.FontDescription new_match);
		public Pango.FontDescription copy ();
		public Pango.FontDescription copy_static ();
		public bool equal (Pango.FontDescription desc2);
		public void free ();
		public static Pango.FontDescription from_string (string str);
		public string get_family ();
		public Pango.FontMask get_set_fields ();
		public int get_size ();
		public bool get_size_is_absolute ();
		public Pango.Stretch get_stretch ();
		public Pango.Style get_style ();
		public GLib.Type get_type ();
		public Pango.Variant get_variant ();
		public Pango.Weight get_weight ();
		public uint hash ();
		public void merge (Pango.FontDescription desc_to_merge, bool replace_existing);
		public void merge_static (Pango.FontDescription desc_to_merge, bool replace_existing);
		public construct ();
		public void set_absolute_size (double size);
		public void set_family (string family);
		public void set_family_static (string family);
		public void set_size (int size);
		public void set_stretch (Pango.Stretch stretch);
		public void set_style (Pango.Style style);
		public void set_variant (Pango.Variant variant);
		public void set_weight (Pango.Weight weight);
		public string to_filename ();
		public string to_string ();
		public void unset_fields (Pango.FontMask to_unset);
	}
	public struct FontMetrics {
		public int get_approximate_char_width ();
		public int get_approximate_digit_width ();
		public int get_ascent ();
		public int get_descent ();
		public int get_strikethrough_position ();
		public int get_strikethrough_thickness ();
		public GLib.Type get_type ();
		public int get_underline_position ();
		public int get_underline_thickness ();
		public Pango.FontMetrics @ref ();
		public void unref ();
	}
	[ReferenceType ()]
	public struct GlyphGeometry {
		public weak int width;
		public weak int x_offset;
		public weak int y_offset;
	}
	[ReferenceType ()]
	public struct GlyphInfo {
		public weak uint glyph;
		public weak Pango.GlyphGeometry geometry;
		public weak Pango.GlyphVisAttr attr;
	}
	[ReferenceType ()]
	public struct GlyphItem {
		public weak Pango.Item item;
		public weak Pango.GlyphString glyphs;
		public GLib.SList apply_attrs (string text, Pango.AttrList list);
		public void free ();
		public void letter_space (string text, Pango.LogAttr log_attrs, int letter_spacing);
		public Pango.GlyphItem split (string text, int split_index);
	}
	public struct GlyphString {
		public Pango.GlyphString copy ();
		public void extents (Pango.Font font, Pango.Rectangle ink_rect, Pango.Rectangle logical_rect);
		public void extents_range (int start, int end, Pango.Font font, Pango.Rectangle ink_rect, Pango.Rectangle logical_rect);
		public void free ();
		public void get_logical_widths (string text, int length, int embedding_level, int logical_widths);
		public GLib.Type get_type ();
		public int get_width ();
		public void index_to_x (string text, int length, Pango.Analysis analysis, int index_, bool trailing, int x_pos);
		public construct ();
		public void set_size (int new_len);
		public void x_to_index (string text, int length, Pango.Analysis analysis, int x_pos, int index_, int trailing);
	}
	[ReferenceType ()]
	public struct GlyphVisAttr {
		public weak uint is_cluster_start;
	}
	public struct Item {
		public Pango.Item copy ();
		public void free ();
		public GLib.Type get_type ();
		public construct ();
		public Pango.Item split (int split_index, int split_offset);
	}
	public struct Language {
		public static Pango.Language from_string (string language);
		public string get_sample_string ();
		public GLib.Type get_type ();
		public bool includes_script (Pango.Script script);
		public bool matches (string range_list);
	}
	public struct LayoutIter {
		public bool at_last_line ();
		public void free ();
		public int get_baseline ();
		public void get_char_extents (Pango.Rectangle logical_rect);
		public void get_cluster_extents (Pango.Rectangle ink_rect, Pango.Rectangle logical_rect);
		public int get_index ();
		public void get_layout_extents (Pango.Rectangle ink_rect, Pango.Rectangle logical_rect);
		public Pango.LayoutLine get_line ();
		public void get_line_extents (Pango.Rectangle ink_rect, Pango.Rectangle logical_rect);
		public void get_line_yrange (int y0_, int y1_);
		public Pango.LayoutRun get_run ();
		public void get_run_extents (Pango.Rectangle ink_rect, Pango.Rectangle logical_rect);
		public GLib.Type get_type ();
		public bool next_char ();
		public bool next_cluster ();
		public bool next_line ();
		public bool next_run ();
	}
	public struct LayoutLine {
		public void get_extents (Pango.Rectangle ink_rect, Pango.Rectangle logical_rect);
		public void get_pixel_extents (Pango.Rectangle ink_rect, Pango.Rectangle logical_rect);
		public GLib.Type get_type ();
		public void get_x_ranges (int start_index, int end_index, int ranges, int n_ranges);
		public void index_to_x (int index_, bool trailing, int x_pos);
		public Pango.LayoutLine @ref ();
		public void unref ();
		public bool x_to_index (int x_pos, int index_, int trailing);
	}
	[ReferenceType ()]
	public struct LayoutRun {
		public weak Pango.Item item;
		public weak Pango.GlyphString glyphs;
	}
	[ReferenceType ()]
	public struct LogAttr {
		public weak uint is_line_break;
		public weak uint is_mandatory_break;
		public weak uint is_char_break;
		public weak uint is_white;
		public weak uint is_cursor_position;
		public weak uint is_word_start;
		public weak uint is_word_end;
		public weak uint is_sentence_boundary;
		public weak uint is_sentence_start;
		public weak uint is_sentence_end;
		public weak uint backspace_deletes_character;
	}
	public struct Matrix {
		public void concat (Pango.Matrix new_matrix);
		public Pango.Matrix copy ();
		public void free ();
		public double get_font_scale_factor ();
		public GLib.Type get_type ();
		public void rotate (double degrees);
		public void scale (double scale_x, double scale_y);
		public void translate (double tx, double ty);
	}
	[ReferenceType ()]
	public struct Rectangle {
		public weak int x;
		public weak int y;
		public weak int width;
		public weak int height;
	}
	[ReferenceType ()]
	public struct ScriptIter {
		public void free ();
		public void get_range (string start, string end, Pango.Script script);
		public construct (string text, int length);
		public bool next ();
	}
	public struct TabArray {
		public Pango.TabArray copy ();
		public void free ();
		public bool get_positions_in_pixels ();
		public int get_size ();
		public void get_tab (int tab_index, Pango.TabAlign alignment, int location);
		public void get_tabs (Pango.TabAlign alignments, int locations);
		public GLib.Type get_type ();
		public construct (int initial_size, bool positions_in_pixels);
		public construct with_positions (int size, bool positions_in_pixels, Pango.TabAlign first_alignment, int first_position);
		public void resize (int new_size);
		public void set_tab (int tab_index, Pango.TabAlign alignment, int location);
	}
	[ReferenceType ()]
	public struct Win32FontCache {
		public void free ();
		public pointer load (pointer logfont);
		public construct ();
		public void unload (pointer hfont);
	}
	[ReferenceType ()]
	public struct Attr {
		public static Pango.Attribute background_new (ushort red, ushort green, ushort blue);
		public static Pango.Attribute fallback_new (bool enable_fallback);
		public static Pango.Attribute family_new (string family);
		public static Pango.Attribute foreground_new (ushort red, ushort green, ushort blue);
		public static Pango.Attribute letter_spacing_new (int letter_spacing);
		public static Pango.Attribute rise_new (int rise);
		public static Pango.Attribute scale_new (double scale_factor);
		public static Pango.Attribute stretch_new (Pango.Stretch stretch);
		public static Pango.Attribute strikethrough_color_new (ushort red, ushort green, ushort blue);
		public static Pango.Attribute strikethrough_new (bool strikethrough);
		public static Pango.Attribute style_new (Pango.Style style);
		public static Pango.AttrType type_register (string name);
		public static Pango.Attribute underline_color_new (ushort red, ushort green, ushort blue);
		public static Pango.Attribute underline_new (Pango.Underline underline);
		public static Pango.Attribute variant_new (Pango.Variant variant);
		public static Pango.Attribute weight_new (Pango.Weight weight);
	}
	[ReferenceType ()]
	public struct Global {
		public static Pango.Direction _find_base_dir (string text, int length);
		public static void _find_paragraph_boundary (string text, int length, int paragraph_delimiter_index, int next_paragraph_start);
		public static void _get_log_attrs (string text, int length, int level, Pango.Language language, Pango.LogAttr log_attrs, int attrs_len);
		public static bool _is_zero_width (unichar ch);
		public static GLib.List _itemize_with_base_dir (Pango.Context context, Pango.Direction base_dir, string text, int start_index, int length, Pango.AttrList attrs, Pango.AttrIterator cached_iter);
		public static bool _parse_markup (string markup_text, int length, unichar accel_marker, Pango.AttrList attr_list, string text, unichar accel_char, GLib.Error error);
		public static bool _parse_stretch (string str, Pango.Stretch stretch, bool warn);
		public static bool _parse_style (string str, Pango.Style style, bool warn);
		public static bool _parse_variant (string str, Pango.Variant variant, bool warn);
		public static bool _parse_weight (string str, Pango.Weight weight, bool warn);
		public static void _quantize_line_geometry (int thickness, int position);
		public static int _read_line (GLib.File stream, GLib.String str);
		public static GLib.List _reorder_items (GLib.List logical_items);
		public static bool _scan_int (string pos, int @out);
		public static bool _scan_string (string pos, GLib.String @out);
		public static bool _scan_word (string pos, GLib.String @out);
		public static Pango.Script _script_for_unichar (unichar ch);
		public static Pango.Language _script_get_sample_language (Pango.Script script);
		public static bool _skip_space (string pos);
		public static string _split_file_list (string str);
		public static string _trim_string (string str);
		public static Pango.Direction _unichar_direction (unichar ch);
	}
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
	public callback pointer AttrDataCopyFunc (pointer data);
	public callback bool AttrFilterFunc (Pango.Attribute attribute, pointer data);
	public callback bool FontsetForeachFunc (Pango.Fontset fontset, Pango.Font font, pointer data);
}
