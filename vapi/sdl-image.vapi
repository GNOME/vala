using GLib;
using SDL;

[CCode (cheader_filename="SDL_image.h")]
namespace SDLImage {
	[CCode (cname="IMG_Linked_Version")]
	public static weak Version linked();

	[CCode (cname="IMG_LoadTyped_RW")]
	public static Surface load_rw_typed(RWops src, int freesrc=0, string type);

	[CCode (cname="IMG_Load_RW")]
	public static Surface load_rw(RWops src, int freesrc=0);

	[CCode (cname="IMG_Load")]
	public static Surface load(string file);

	[CCode (cname="IMG_isBMP")]
	public static int is_bmp(RWops src);

	[CCode (cname="IMG_isGIF")]
	public static int is_gif(RWops src);

	[CCode (cname="IMG_isJPG")]
	public static int is_jpg(RWops src);

	[CCode (cname="IMG_isLBM")]
	public static int is_lbm(RWops src);

	[CCode (cname="IMG_isPCX")]
	public static int is_pcx(RWops src);

	[CCode (cname="IMG_isPNG")]
	public static int is_png(RWops src);

	[CCode (cname="IMG_isPNM")]
	public static int is_pnm(RWops src);

	[CCode (cname="IMG_isTIF")]
	public static int is_tif(RWops src);

	[CCode (cname="IMG_isXCF")]
	public static int is_xcf(RWops src);

	[CCode (cname="IMG_isXPM")]
	public static int is_xpm(RWops src);

	[CCode (cname="IMG_isXV")]
	public static int is_xv(RWops src);


	[CCode (cname="IMG_LoadBMP_RW")]
	public static Surface load_bmp(RWops src);

	[CCode (cname="IMG_LoadGIF_RW")]
	public static Surface load_gif(RWops src);

	[CCode (cname="IMG_LoadJPG_RW")]
	public static Surface load_jpg(RWops src);

	[CCode (cname="IMG_LoadLBM_RW")]
	public static Surface load_lbm(RWops src);

	[CCode (cname="IMG_LoadPCX_RW")]
	public static Surface load_pcx(RWops src);

	[CCode (cname="IMG_LoadPNG_RW")]
	public static Surface load_png(RWops src);

	[CCode (cname="IMG_LoadPNM_RW")]
	public static Surface load_pnm(RWops src);

	[CCode (cname="IMG_LoadTIF_RW")]
	public static Surface load_tif(RWops src);

	[CCode (cname="IMG_LoadXCF_RW")]
	public static Surface load_xcf(RWops src);

	[CCode (cname="IMG_LoadXPM_RW")]
	public static Surface load_xpm(RWops src);

	[CCode (cname="IMG_ReadXPMFromArray")]
	public static Surface read_xpm(pointer xpmdata);

	[CCode (cname="IMG_LoadXV_RW")]
	public static Surface load_xv(RWops src);
}// SDLImage
