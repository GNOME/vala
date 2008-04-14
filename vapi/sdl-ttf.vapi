using GLib;
using SDL;

[CCode (cheader_filename="SDL_ttf.h")]
namespace SDLTTF {
	[CCode (cname="TTF_Linked_Version")]
	public static weak Version linked();

	[CCode (cname="TTF_ByteSwappedUNICODE")]
	public static void byteswap_unicode(int swapped);

	[CCode (cname="TTF_Init")]
	public static int init();

	[CCode (cname="TTF_WasInit")]
	public static int get_initialized();

	[CCode (cname="TTF_Quit")]
	public static void quit();

	[CCode (cprefix="TTF_STYLE_")]
	public enum FontStyle {
		NORMAL, BOLD, ITALIC, UNDERLINE
	}// FontStyle

	[CCode (cname="TTF_Font", free_function="TTF_CloseFont")]
	public class Font {
		[CCode (cname="TTF_OpenFont")]
		public Font(string file, int ptsize);

		[CCode (cname="TTF_OpenFontIndex")]
		public Font.index(string file, int ptsize, long index);

		[CCode (cname="TTF_OpenFontRW")]
		public Font.RW(RWops src, int freesrc=0, int ptsize);

		[CCode (cname="TTF_OpenFontIndexRW")]
		public Font.RWindex(RWops src, int freesrc=0, int ptsize, long index);

		[CCode (cname="TTF_GetFontStyle")]
		public FontStyle get_style();

		[CCode (cname="TTF_SetFontStyle")]
		public FontStyle set_style(FontStyle style);

		[CCode (cname="TTF_FontHeight")]
		public int height();

		[CCode (cname="TTF_FontAscent")]
		public int ascent();

		[CCode (cname="TTF_FontDescent")]
		public int descent();

		[CCode (cname="TTF_FontLineSkip")]
		public int lineskip();

		[CCode (cname="TTF_FontFaces")]
		public long faces();

		[CCode (cname="TTF_FontFaceIsFixedWidth")]
		public int is_fixed_width();

		[CCode (cname="TTF_FontFaceFamilyName")]
		public string family();

		[CCode (cname="TTF_FontFaceStyleName")]
		public string style();

		[CCode (cname="TTF_GlyphMetrics")]
		public int metrics(uint16 ch, ref int minx, ref int maxx, 
			ref int miny, ref int maxy, ref int advance);

		[CCode (cname="TTF_SizeText")]
		public int size(string text, ref int w, ref int h);

		[CCode (cname="TTF_SizeUTF8")]
		public int size_utf8(string text, ref int w, ref int h);

		[CCode (cname="TTF_SizeUNICODE")]
		[NoArrayLength]
		public int size_unicode(uint16[] text, ref int w, ref int h);

		[CCode (cname="TTF_RenderText_Solid")]
		public Surface? render(string text, Color fg);

		[CCode (cname="TTF_RenderUTF8_Solid")]
		public Surface? render_utf8(string text, Color fg);

		[CCode (cname="TTF_RenderUNICODE_Solid")]
		[NoArrayLength]
		public Surface? render_unicode(uint16[] text, Color fg);

		[CCode (cname="TTF_RenderText_Shaded")]
		public Surface? render_shaded(string text, Color fg, Color bg);

		[CCode (cname="TTF_RenderUTF8_Shaded")]
		public Surface? render_shaded_utf8(string text, Color fg, Color bg);

		[CCode (cname="TTF_RenderUNICODE_Shaded")]
		[NoArrayLength]
		public Surface? render_shaded_unicode(uint16[] text, Color fg, Color bg);

		[CCode (cname="TTF_RenderText_Blended")]
		public Surface? render_blended(string text, Color fg);

		[CCode (cname="TTF_RenderUTF8_Blended")]
		public Surface? render_blended_utf8(string text, Color fg);

		[CCode (cname="TTF_RenderUNICODE_Blended")]
		[NoArrayLength]
		public Surface? render_blended_unicode(uint16[] text, Color fg);
	}// Font
}// SDLTTF
