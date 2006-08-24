[CCode (cheader_filename = "pango/pango.h")]
namespace Pango {
	public class Context : GLib.Object {
		[NoArrayLength ()]
		public Pango.Direction get_base_dir ();
		[NoArrayLength ()]
		public Pango.FontDescription get_font_description ();
		[NoArrayLength ()]
		public Pango.FontMap get_font_map ();
		[NoArrayLength ()]
		public Pango.Language get_language ();
		[NoArrayLength ()]
		public Pango.Matrix get_matrix ();
		[NoArrayLength ()]
		public Pango.FontMetrics get_metrics (Pango.FontDescription desc, Pango.Language language);
		[NoArrayLength ()]
		public GLib.Type get_type ();
		[NoArrayLength ()]
		public void list_families (Pango.FontFamily families, int n_families);
		[NoArrayLength ()]
		public Pango.Font load_font (Pango.FontDescription desc);
		[NoArrayLength ()]
		public Pango.Fontset load_fontset (Pango.FontDescription desc, Pango.Language language);
		[NoArrayLength ()]
		public void set_base_dir (Pango.Direction direction);
		[NoArrayLength ()]
		public void set_font_description (Pango.FontDescription desc);
		[NoArrayLength ()]
		public void set_language (Pango.Language language);
		[NoArrayLength ()]
		public void set_matrix (Pango.Matrix matrix);
	}
	public class Font : GLib.Object {
		[NoArrayLength ()]
		public Pango.FontDescription describe ();
		[NoArrayLength ()]
		public Pango.FontDescription describe_with_absolute_size ();
		[NoArrayLength ()]
		public static void descriptions_free (Pango.FontDescription descs, int n_descs);
		[NoArrayLength ()]
		public Pango.EngineShape find_shaper (Pango.Language language, uint ch);
		[NoArrayLength ()]
		public Pango.Coverage get_coverage (Pango.Language language);
		[NoArrayLength ()]
		public Pango.FontMap get_font_map ();
		[NoArrayLength ()]
		public void get_glyph_extents (uint glyph, Pango.Rectangle ink_rect, Pango.Rectangle logical_rect);
		[NoArrayLength ()]
		public Pango.FontMetrics get_metrics (Pango.Language language);
		[NoArrayLength ()]
		public GLib.Type get_type ();
	}
	public class Fontset : GLib.Object {
		[NoArrayLength ()]
		public void @foreach (Pango.FontsetForeachFunc func, pointer data);
		[NoArrayLength ()]
		public Pango.Font get_font (uint wc);
		[NoArrayLength ()]
		public Pango.FontMetrics get_metrics ();
		[NoArrayLength ()]
		public GLib.Type get_type ();
	}
	public class FontFace : GLib.Object {
		[NoArrayLength ()]
		public Pango.FontDescription describe ();
		[NoArrayLength ()]
		public string get_face_name ();
		[NoArrayLength ()]
		public GLib.Type get_type ();
		[NoArrayLength ()]
		public void list_sizes (int sizes, int n_sizes);
	}
	public class FontFamily : GLib.Object {
		[NoArrayLength ()]
		public string get_name ();
		[NoArrayLength ()]
		public GLib.Type get_type ();
		[NoArrayLength ()]
		public bool is_monospace ();
		[NoArrayLength ()]
		public void list_faces (Pango.FontFace faces, int n_faces);
	}
	public class FontMap : GLib.Object {
		[NoArrayLength ()]
		public GLib.Type get_type ();
		[NoArrayLength ()]
		public void list_families (Pango.FontFamily families, int n_families);
		[NoArrayLength ()]
		public Pango.Font load_font (Pango.Context context, Pango.FontDescription desc);
		[NoArrayLength ()]
		public Pango.Fontset load_fontset (Pango.Context context, Pango.FontDescription desc, Pango.Language language);
	}
	public class Layout : GLib.Object {
		[NoArrayLength ()]
		public void context_changed ();
		[NoArrayLength ()]
		public Pango.Layout copy ();
		[NoArrayLength ()]
		public Pango.Alignment get_alignment ();
		[NoArrayLength ()]
		public Pango.AttrList get_attributes ();
		[NoArrayLength ()]
		public bool get_auto_dir ();
		[NoArrayLength ()]
		public Pango.Context get_context ();
		[NoArrayLength ()]
		public void get_cursor_pos (int index_, Pango.Rectangle strong_pos, Pango.Rectangle weak_pos);
		[NoArrayLength ()]
		public Pango.EllipsizeMode get_ellipsize ();
		[NoArrayLength ()]
		public void get_extents (Pango.Rectangle ink_rect, Pango.Rectangle logical_rect);
		[NoArrayLength ()]
		public Pango.FontDescription get_font_description ();
		[NoArrayLength ()]
		public int get_indent ();
		[NoArrayLength ()]
		public Pango.LayoutIter get_iter ();
		[NoArrayLength ()]
		public bool get_justify ();
		[NoArrayLength ()]
		public Pango.LayoutLine get_line (int line);
		[NoArrayLength ()]
		public int get_line_count ();
		[NoArrayLength ()]
		public GLib.SList get_lines ();
		[NoArrayLength ()]
		public void get_log_attrs (Pango.LogAttr attrs, int n_attrs);
		[NoArrayLength ()]
		public void get_pixel_extents (Pango.Rectangle ink_rect, Pango.Rectangle logical_rect);
		[NoArrayLength ()]
		public void get_pixel_size (int width, int height);
		[NoArrayLength ()]
		public bool get_single_paragraph_mode ();
		[NoArrayLength ()]
		public void get_size (int width, int height);
		[NoArrayLength ()]
		public int get_spacing ();
		[NoArrayLength ()]
		public Pango.TabArray get_tabs ();
		[NoArrayLength ()]
		public string get_text ();
		[NoArrayLength ()]
		public GLib.Type get_type ();
		[NoArrayLength ()]
		public int get_width ();
		[NoArrayLength ()]
		public Pango.WrapMode get_wrap ();
		[NoArrayLength ()]
		public void index_to_line_x (int index_, bool trailing, int line, int x_pos);
		[NoArrayLength ()]
		public void index_to_pos (int index_, Pango.Rectangle pos);
		[NoArrayLength ()]
		public void move_cursor_visually (bool strong, int old_index, int old_trailing, int direction, int new_index, int new_trailing);
		[NoArrayLength ()]
		public construct (Pango.Context context);
		[NoArrayLength ()]
		public void set_alignment (Pango.Alignment alignment);
		[NoArrayLength ()]
		public void set_attributes (Pango.AttrList attrs);
		[NoArrayLength ()]
		public void set_auto_dir (bool auto_dir);
		[NoArrayLength ()]
		public void set_ellipsize (Pango.EllipsizeMode ellipsize);
		[NoArrayLength ()]
		public void set_font_description (Pango.FontDescription desc);
		[NoArrayLength ()]
		public void set_indent (int indent);
		[NoArrayLength ()]
		public void set_justify (bool justify);
		[NoArrayLength ()]
		public void set_markup (string markup, int length);
		[NoArrayLength ()]
		public void set_markup_with_accel (string markup, int length, unichar accel_marker, unichar accel_char);
		[NoArrayLength ()]
		public void set_single_paragraph_mode (bool setting);
		[NoArrayLength ()]
		public void set_spacing (int spacing);
		[NoArrayLength ()]
		public void set_tabs (Pango.TabArray tabs);
		[NoArrayLength ()]
		public void set_text (string text, int length);
		[NoArrayLength ()]
		public void set_width (int width);
		[NoArrayLength ()]
		public void set_wrap (Pango.WrapMode wrap);
		[NoArrayLength ()]
		public bool xy_to_index (int x, int y, int index_, int trailing);
	}
	public class Renderer : GLib.Object {
		public weak Pango.Matrix matrix;
		[NoArrayLength ()]
		public void activate ();
		[NoArrayLength ()]
		public void deactivate ();
		[NoArrayLength ()]
		public virtual void draw_error_underline (int x, int y, int width, int height);
		[NoArrayLength ()]
		public virtual void draw_glyph (Pango.Font font, uint glyph, double x, double y);
		[NoArrayLength ()]
		public virtual void draw_glyphs (Pango.Font font, Pango.GlyphString glyphs, int x, int y);
		[NoArrayLength ()]
		public void draw_layout (Pango.Layout layout, int x, int y);
		[NoArrayLength ()]
		public void draw_layout_line (Pango.LayoutLine line, int x, int y);
		[NoArrayLength ()]
		public virtual void draw_rectangle (Pango.RenderPart part, int x, int y, int width, int height);
		[NoArrayLength ()]
		public virtual void draw_trapezoid (Pango.RenderPart part, double y1_, double x11, double x21, double y2, double x12, double x22);
		[NoArrayLength ()]
		public Pango.Color get_color (Pango.RenderPart part);
		[NoArrayLength ()]
		public Pango.Matrix get_matrix ();
		[NoArrayLength ()]
		public GLib.Type get_type ();
		[NoArrayLength ()]
		public virtual void part_changed (Pango.RenderPart part);
		[NoArrayLength ()]
		public void set_color (Pango.RenderPart part, Pango.Color color);
		[NoArrayLength ()]
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
		[NoArrayLength ()]
		public construct (Pango.FontDescription desc);
	}
	[ReferenceType ()]
	public struct AttrInt {
		public weak Pango.Attribute attr;
		public weak int value;
	}
	[ReferenceType ()]
	public struct AttrIterator {
		[NoArrayLength ()]
		public Pango.AttrIterator copy ();
		[NoArrayLength ()]
		public void destroy ();
		[NoArrayLength ()]
		public Pango.Attribute @get (Pango.AttrType type);
		[NoArrayLength ()]
		public GLib.SList get_attrs ();
		[NoArrayLength ()]
		public void get_font (Pango.FontDescription desc, Pango.Language language, GLib.SList extra_attrs);
		[NoArrayLength ()]
		public bool next ();
		[NoArrayLength ()]
		public void range (int start, int end);
	}
	[ReferenceType ()]
	public struct AttrLanguage {
		public weak Pango.Attribute attr;
		public weak Pango.Language value;
		[NoArrayLength ()]
		public construct (Pango.Language language);
	}
	public struct AttrList {
		[NoArrayLength ()]
		public void change (Pango.Attribute attr);
		[NoArrayLength ()]
		public Pango.AttrList copy ();
		[NoArrayLength ()]
		public Pango.AttrList filter (Pango.AttrFilterFunc func, pointer data);
		[NoArrayLength ()]
		public Pango.AttrIterator get_iterator ();
		[NoArrayLength ()]
		public GLib.Type get_type ();
		[NoArrayLength ()]
		public void insert (Pango.Attribute attr);
		[NoArrayLength ()]
		public void insert_before (Pango.Attribute attr);
		[NoArrayLength ()]
		public construct ();
		[NoArrayLength ()]
		public Pango.AttrList @ref ();
		[NoArrayLength ()]
		public void splice (Pango.AttrList other, int pos, int len);
		[NoArrayLength ()]
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
		[NoArrayLength ()]
		public construct (Pango.Rectangle ink_rect, Pango.Rectangle logical_rect);
		[NoArrayLength ()]
		public construct with_data (Pango.Rectangle ink_rect, Pango.Rectangle logical_rect, pointer data, Pango.AttrDataCopyFunc copy_func, GLib.DestroyNotify destroy_func);
	}
	[ReferenceType ()]
	public struct AttrSize {
		public weak Pango.Attribute attr;
		public weak int size;
		public weak uint absolute;
		[NoArrayLength ()]
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
		[NoArrayLength ()]
		public Pango.Attribute copy ();
		[NoArrayLength ()]
		public void destroy ();
		[NoArrayLength ()]
		public bool equal (Pango.Attribute attr2);
	}
	public struct Color {
		[NoArrayLength ()]
		public Pango.Color copy ();
		[NoArrayLength ()]
		public void free ();
		[NoArrayLength ()]
		public GLib.Type get_type ();
		[NoArrayLength ()]
		public bool parse (string spec);
	}
	[ReferenceType ()]
	public struct Coverage {
		[NoArrayLength ()]
		public Pango.Coverage copy ();
		[NoArrayLength ()]
		public static Pango.Coverage from_bytes (uchar bytes, int n_bytes);
		[NoArrayLength ()]
		public Pango.CoverageLevel @get (int index_);
		[NoArrayLength ()]
		public void max (Pango.Coverage other);
		[NoArrayLength ()]
		public construct ();
		[NoArrayLength ()]
		public Pango.Coverage @ref ();
		[NoArrayLength ()]
		public void @set (int index_, Pango.CoverageLevel level);
		[NoArrayLength ()]
		public void to_bytes (uchar bytes, int n_bytes);
		[NoArrayLength ()]
		public void unref ();
	}
	[ReferenceType ()]
	public struct EngineLang {
	}
	[ReferenceType ()]
	public struct EngineShape {
	}
	public struct FontDescription {
		[NoArrayLength ()]
		public bool better_match (Pango.FontDescription old_match, Pango.FontDescription new_match);
		[NoArrayLength ()]
		public Pango.FontDescription copy ();
		[NoArrayLength ()]
		public Pango.FontDescription copy_static ();
		[NoArrayLength ()]
		public bool equal (Pango.FontDescription desc2);
		[NoArrayLength ()]
		public void free ();
		[NoArrayLength ()]
		public static Pango.FontDescription from_string (string str);
		[NoArrayLength ()]
		public string get_family ();
		[NoArrayLength ()]
		public Pango.FontMask get_set_fields ();
		[NoArrayLength ()]
		public int get_size ();
		[NoArrayLength ()]
		public bool get_size_is_absolute ();
		[NoArrayLength ()]
		public Pango.Stretch get_stretch ();
		[NoArrayLength ()]
		public Pango.Style get_style ();
		[NoArrayLength ()]
		public GLib.Type get_type ();
		[NoArrayLength ()]
		public Pango.Variant get_variant ();
		[NoArrayLength ()]
		public Pango.Weight get_weight ();
		[NoArrayLength ()]
		public uint hash ();
		[NoArrayLength ()]
		public void merge (Pango.FontDescription desc_to_merge, bool replace_existing);
		[NoArrayLength ()]
		public void merge_static (Pango.FontDescription desc_to_merge, bool replace_existing);
		[NoArrayLength ()]
		public construct ();
		[NoArrayLength ()]
		public void set_absolute_size (double size);
		[NoArrayLength ()]
		public void set_family (string family);
		[NoArrayLength ()]
		public void set_family_static (string family);
		[NoArrayLength ()]
		public void set_size (int size);
		[NoArrayLength ()]
		public void set_stretch (Pango.Stretch stretch);
		[NoArrayLength ()]
		public void set_style (Pango.Style style);
		[NoArrayLength ()]
		public void set_variant (Pango.Variant variant);
		[NoArrayLength ()]
		public void set_weight (Pango.Weight weight);
		[NoArrayLength ()]
		public string to_filename ();
		[NoArrayLength ()]
		public string to_string ();
		[NoArrayLength ()]
		public void unset_fields (Pango.FontMask to_unset);
	}
	public struct FontMetrics {
		[NoArrayLength ()]
		public int get_approximate_char_width ();
		[NoArrayLength ()]
		public int get_approximate_digit_width ();
		[NoArrayLength ()]
		public int get_ascent ();
		[NoArrayLength ()]
		public int get_descent ();
		[NoArrayLength ()]
		public int get_strikethrough_position ();
		[NoArrayLength ()]
		public int get_strikethrough_thickness ();
		[NoArrayLength ()]
		public GLib.Type get_type ();
		[NoArrayLength ()]
		public int get_underline_position ();
		[NoArrayLength ()]
		public int get_underline_thickness ();
		[NoArrayLength ()]
		public Pango.FontMetrics @ref ();
		[NoArrayLength ()]
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
		[NoArrayLength ()]
		public GLib.SList apply_attrs (string text, Pango.AttrList list);
		[NoArrayLength ()]
		public void free ();
		[NoArrayLength ()]
		public void letter_space (string text, Pango.LogAttr log_attrs, int letter_spacing);
		[NoArrayLength ()]
		public Pango.GlyphItem split (string text, int split_index);
	}
	public struct GlyphString {
		[NoArrayLength ()]
		public Pango.GlyphString copy ();
		[NoArrayLength ()]
		public void extents (Pango.Font font, Pango.Rectangle ink_rect, Pango.Rectangle logical_rect);
		[NoArrayLength ()]
		public void extents_range (int start, int end, Pango.Font font, Pango.Rectangle ink_rect, Pango.Rectangle logical_rect);
		[NoArrayLength ()]
		public void free ();
		[NoArrayLength ()]
		public void get_logical_widths (string text, int length, int embedding_level, int logical_widths);
		[NoArrayLength ()]
		public GLib.Type get_type ();
		[NoArrayLength ()]
		public int get_width ();
		[NoArrayLength ()]
		public void index_to_x (string text, int length, Pango.Analysis analysis, int index_, bool trailing, int x_pos);
		[NoArrayLength ()]
		public construct ();
		[NoArrayLength ()]
		public void set_size (int new_len);
		[NoArrayLength ()]
		public void x_to_index (string text, int length, Pango.Analysis analysis, int x_pos, int index_, int trailing);
	}
	[ReferenceType ()]
	public struct GlyphVisAttr {
		public weak uint is_cluster_start;
	}
	public struct Item {
		[NoArrayLength ()]
		public Pango.Item copy ();
		[NoArrayLength ()]
		public void free ();
		[NoArrayLength ()]
		public GLib.Type get_type ();
		[NoArrayLength ()]
		public construct ();
		[NoArrayLength ()]
		public Pango.Item split (int split_index, int split_offset);
	}
	public struct Language {
		[NoArrayLength ()]
		public static Pango.Language from_string (string language);
		[NoArrayLength ()]
		public string get_sample_string ();
		[NoArrayLength ()]
		public GLib.Type get_type ();
		[NoArrayLength ()]
		public bool includes_script (Pango.Script script);
		[NoArrayLength ()]
		public bool matches (string range_list);
	}
	public struct LayoutIter {
		[NoArrayLength ()]
		public bool at_last_line ();
		[NoArrayLength ()]
		public void free ();
		[NoArrayLength ()]
		public int get_baseline ();
		[NoArrayLength ()]
		public void get_char_extents (Pango.Rectangle logical_rect);
		[NoArrayLength ()]
		public void get_cluster_extents (Pango.Rectangle ink_rect, Pango.Rectangle logical_rect);
		[NoArrayLength ()]
		public int get_index ();
		[NoArrayLength ()]
		public void get_layout_extents (Pango.Rectangle ink_rect, Pango.Rectangle logical_rect);
		[NoArrayLength ()]
		public Pango.LayoutLine get_line ();
		[NoArrayLength ()]
		public void get_line_extents (Pango.Rectangle ink_rect, Pango.Rectangle logical_rect);
		[NoArrayLength ()]
		public void get_line_yrange (int y0_, int y1_);
		[NoArrayLength ()]
		public Pango.LayoutRun get_run ();
		[NoArrayLength ()]
		public void get_run_extents (Pango.Rectangle ink_rect, Pango.Rectangle logical_rect);
		[NoArrayLength ()]
		public GLib.Type get_type ();
		[NoArrayLength ()]
		public bool next_char ();
		[NoArrayLength ()]
		public bool next_cluster ();
		[NoArrayLength ()]
		public bool next_line ();
		[NoArrayLength ()]
		public bool next_run ();
	}
	public struct LayoutLine {
		[NoArrayLength ()]
		public void get_extents (Pango.Rectangle ink_rect, Pango.Rectangle logical_rect);
		[NoArrayLength ()]
		public void get_pixel_extents (Pango.Rectangle ink_rect, Pango.Rectangle logical_rect);
		[NoArrayLength ()]
		public GLib.Type get_type ();
		[NoArrayLength ()]
		public void get_x_ranges (int start_index, int end_index, int ranges, int n_ranges);
		[NoArrayLength ()]
		public void index_to_x (int index_, bool trailing, int x_pos);
		[NoArrayLength ()]
		public Pango.LayoutLine @ref ();
		[NoArrayLength ()]
		public void unref ();
		[NoArrayLength ()]
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
		[NoArrayLength ()]
		public void concat (Pango.Matrix new_matrix);
		[NoArrayLength ()]
		public Pango.Matrix copy ();
		[NoArrayLength ()]
		public void free ();
		[NoArrayLength ()]
		public double get_font_scale_factor ();
		[NoArrayLength ()]
		public GLib.Type get_type ();
		[NoArrayLength ()]
		public void rotate (double degrees);
		[NoArrayLength ()]
		public void scale (double scale_x, double scale_y);
		[NoArrayLength ()]
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
		[NoArrayLength ()]
		public void free ();
		[NoArrayLength ()]
		public void get_range (string start, string end, Pango.Script script);
		[NoArrayLength ()]
		public construct (string text, int length);
		[NoArrayLength ()]
		public bool next ();
	}
	public struct TabArray {
		[NoArrayLength ()]
		public Pango.TabArray copy ();
		[NoArrayLength ()]
		public void free ();
		[NoArrayLength ()]
		public bool get_positions_in_pixels ();
		[NoArrayLength ()]
		public int get_size ();
		[NoArrayLength ()]
		public void get_tab (int tab_index, Pango.TabAlign alignment, int location);
		[NoArrayLength ()]
		public void get_tabs (Pango.TabAlign alignments, int locations);
		[NoArrayLength ()]
		public GLib.Type get_type ();
		[NoArrayLength ()]
		public construct (int initial_size, bool positions_in_pixels);
		[NoArrayLength ()]
		public construct with_positions (int size, bool positions_in_pixels, Pango.TabAlign first_alignment, int first_position);
		[NoArrayLength ()]
		public void resize (int new_size);
		[NoArrayLength ()]
		public void set_tab (int tab_index, Pango.TabAlign alignment, int location);
	}
	[ReferenceType ()]
	public struct Win32FontCache {
		[NoArrayLength ()]
		public void free ();
		[NoArrayLength ()]
		public pointer load (pointer logfont);
		[NoArrayLength ()]
		public construct ();
		[NoArrayLength ()]
		public void unload (pointer hfont);
	}
	[ReferenceType ()]
	public struct Attr {
		[NoArrayLength ()]
		public static Pango.Attribute background_new (ushort red, ushort green, ushort blue);
		[NoArrayLength ()]
		public static Pango.Attribute fallback_new (bool enable_fallback);
		[NoArrayLength ()]
		public static Pango.Attribute family_new (string family);
		[NoArrayLength ()]
		public static Pango.Attribute foreground_new (ushort red, ushort green, ushort blue);
		[NoArrayLength ()]
		public static Pango.Attribute letter_spacing_new (int letter_spacing);
		[NoArrayLength ()]
		public static Pango.Attribute rise_new (int rise);
		[NoArrayLength ()]
		public static Pango.Attribute scale_new (double scale_factor);
		[NoArrayLength ()]
		public static Pango.Attribute stretch_new (Pango.Stretch stretch);
		[NoArrayLength ()]
		public static Pango.Attribute strikethrough_color_new (ushort red, ushort green, ushort blue);
		[NoArrayLength ()]
		public static Pango.Attribute strikethrough_new (bool strikethrough);
		[NoArrayLength ()]
		public static Pango.Attribute style_new (Pango.Style style);
		[NoArrayLength ()]
		public static Pango.AttrType type_register (string name);
		[NoArrayLength ()]
		public static Pango.Attribute underline_color_new (ushort red, ushort green, ushort blue);
		[NoArrayLength ()]
		public static Pango.Attribute underline_new (Pango.Underline underline);
		[NoArrayLength ()]
		public static Pango.Attribute variant_new (Pango.Variant variant);
		[NoArrayLength ()]
		public static Pango.Attribute weight_new (Pango.Weight weight);
	}
	[ReferenceType ()]
	public struct Global {
		[NoArrayLength ()]
		public static Pango.Direction _find_base_dir (string text, int length);
		[NoArrayLength ()]
		public static void _find_paragraph_boundary (string text, int length, int paragraph_delimiter_index, int next_paragraph_start);
		[NoArrayLength ()]
		public static void _get_log_attrs (string text, int length, int level, Pango.Language language, Pango.LogAttr log_attrs, int attrs_len);
		[NoArrayLength ()]
		public static bool _is_zero_width (unichar ch);
		[NoArrayLength ()]
		public static GLib.List _itemize_with_base_dir (Pango.Context context, Pango.Direction base_dir, string text, int start_index, int length, Pango.AttrList attrs, Pango.AttrIterator cached_iter);
		[NoArrayLength ()]
		public static bool _parse_markup (string markup_text, int length, unichar accel_marker, Pango.AttrList attr_list, string text, unichar accel_char, GLib.Error error);
		[NoArrayLength ()]
		public static bool _parse_stretch (string str, Pango.Stretch stretch, bool warn);
		[NoArrayLength ()]
		public static bool _parse_style (string str, Pango.Style style, bool warn);
		[NoArrayLength ()]
		public static bool _parse_variant (string str, Pango.Variant variant, bool warn);
		[NoArrayLength ()]
		public static bool _parse_weight (string str, Pango.Weight weight, bool warn);
		[NoArrayLength ()]
		public static void _quantize_line_geometry (int thickness, int position);
		[NoArrayLength ()]
		public static int _read_line (GLib.File stream, GLib.String str);
		[NoArrayLength ()]
		public static GLib.List _reorder_items (GLib.List logical_items);
		[NoArrayLength ()]
		public static bool _scan_int (string pos, int @out);
		[NoArrayLength ()]
		public static bool _scan_string (string pos, GLib.String @out);
		[NoArrayLength ()]
		public static bool _scan_word (string pos, GLib.String @out);
		[NoArrayLength ()]
		public static Pango.Script _script_for_unichar (unichar ch);
		[NoArrayLength ()]
		public static Pango.Language _script_get_sample_language (Pango.Script script);
		[NoArrayLength ()]
		public static bool _skip_space (string pos);
		[NoArrayLength ()]
		public static string _split_file_list (string str);
		[NoArrayLength ()]
		public static string _trim_string (string str);
		[NoArrayLength ()]
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
