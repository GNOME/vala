namespace Rsvg {
	public class Handle {
		[CCode (cheader_filename = "librsvg/rsvg-cairo.h")]
		public bool render_cairo (Cairo.Context cr);
		[CCode (cheader_filename = "librsvg/rsvg-cairo.h")]
		public bool render_cairo_sub (Cairo.Context cr, string id);
	}
}