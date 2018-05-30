namespace Pango {
	namespace Scale {
		[CCode (cheader_filename = "pango/pango.h", cname = "PANGO_SCALE_LARGE")]
		public const double LARGE;
		[CCode (cheader_filename = "pango/pango.h", cname = "PANGO_SCALE_MEDIUM")]
		public const double MEDIUM;
		[CCode (cheader_filename = "pango/pango.h", cname = "PANGO_SCALE_SMALL")]
		public const double SMALL;
		[CCode (cheader_filename = "pango/pango.h", cname = "PANGO_SCALE_XX_LARGE")]
		public const double XX_LARGE;
		[CCode (cheader_filename = "pango/pango.h", cname = "PANGO_SCALE_XX_SMALL")]
		public const double XX_SMALL;
		[CCode (cheader_filename = "pango/pango.h", cname = "PANGO_SCALE_X_LARGE")]
		public const double X_LARGE;
		[CCode (cheader_filename = "pango/pango.h", cname = "PANGO_SCALE_X_SMALL")]
		public const double X_SMALL;
	}

	[CCode (cheader_filename = "pango/pango.h")]
	[Compact]
	public class AttrFontDesc {
		[CCode (has_construct_function = false, type = "PangoAttribute*")]
		public AttrFontDesc (Pango.FontDescription desc);
	}

	[CCode (cheader_filename = "pango/pango.h", free_function = "pango_attr_iterator_destroy")]
	[Compact]
	public class AttrIterator {
	}

	[CCode (cheader_filename = "pango/pango.h")]
	[Compact]
	public class AttrLanguage {
		[CCode (has_construct_function = false, type = "PangoAttribute*")]
		public AttrLanguage (Pango.Language language);
	}

	[CCode (cheader_filename = "pango/pango.h")]
	[Compact]
	public class AttrShape<T> {
		[CCode (has_construct_function = false, type = "PangoAttribute*")]
		public AttrShape (Pango.Rectangle ink_rect, Pango.Rectangle logical_rect);
		[CCode (has_construct_function = false, simple_generics = true, type = "PangoAttribute*")]
		public AttrShape.with_data (Pango.Rectangle ink_rect, Pango.Rectangle logical_rect, owned T data, Pango.AttrDataCopyFunc<T> copy_func);
	}

	[CCode (cheader_filename = "pango/pango.h")]
	[Compact]
	public class AttrSize {
		[CCode (has_construct_function = false, type = "PangoAttribute*")]
		public AttrSize (int size);
	}

	[CCode (cheader_filename = "pango/pango.h", free_function = "pango_attribute_destroy")]
	[Compact]
	public class Attribute {
	}

	[CCode (cheader_filename = "pango/pango.h", ref_function = "pango_coverage_ref", unref_function = "pango_coverage_unref")]
	[Compact]
	public class Coverage {
		[CCode (has_construct_function = false)]
		public Coverage ();
		public static Pango.Coverage from_bytes (uint8[] bytes);
	}

	[CCode (cheader_filename = "pango/pango.h")]
	[Compact]
	public class ScriptIter {
		[CCode (has_construct_function = false)]
		public ScriptIter (string text, int length);
	}

	[CCode (cheader_filename = "pango/pango.h", has_target = false)]
	public delegate T AttrDataCopyFunc<T> (T data);

	[CCode (cheader_filename = "pango/pango.h")]
	public const int VERSION_MAJOR;
	[CCode (cheader_filename = "pango/pango.h")]
	public const int VERSION_MICRO;
	[CCode (cheader_filename = "pango/pango.h")]
	public const int VERSION_MINOR;
	[CCode (cheader_filename = "pango/pango.h")]
	public const string VERSION_STRING;
}
