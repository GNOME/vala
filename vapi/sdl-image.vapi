[CCode (cheader_filename="SDL_image.h")]
namespace SDLImage {
	[CCode (cname="IMG_Linked_Version")]
	public static weak SDL.Version linked();

	[CCode (cname="IMG_LoadTyped_RW")]
	public static SDL.Surface load_rw_typed(SDL.RWops src, int freesrc=0, string type);

	[CCode (cname="IMG_Load_RW")]
	public static SDL.Surface load_rw(SDL.RWops src, int freesrc=0);

	[CCode (cname="IMG_Load")]
	public static SDL.Surface load(string file);

	[CCode (cname="IMG_isBMP")]
	public static int is_bmp(SDL.RWops src);

	[CCode (cname="IMG_isGIF")]
	public static int is_gif(SDL.RWops src);

	[CCode (cname="IMG_isJPG")]
	public static int is_jpg(SDL.RWops src);

	[CCode (cname="IMG_isLBM")]
	public static int is_lbm(SDL.RWops src);

	[CCode (cname="IMG_isPCX")]
	public static int is_pcx(SDL.RWops src);

	[CCode (cname="IMG_isPNG")]
	public static int is_png(SDL.RWops src);

	[CCode (cname="IMG_isPNM")]
	public static int is_pnm(SDL.RWops src);

	[CCode (cname="IMG_isTIF")]
	public static int is_tif(SDL.RWops src);

	[CCode (cname="IMG_isXCF")]
	public static int is_xcf(SDL.RWops src);

	[CCode (cname="IMG_isXPM")]
	public static int is_xpm(SDL.RWops src);

	[CCode (cname="IMG_isXV")]
	public static int is_xv(SDL.RWops src);


	[CCode (cname="IMG_LoadBMP_RW")]
	public static SDL.Surface load_bmp(SDL.RWops src);

	[CCode (cname="IMG_LoadGIF_RW")]
	public static SDL.Surface load_gif(SDL.RWops src);

	[CCode (cname="IMG_LoadJPG_RW")]
	public static SDL.Surface load_jpg(SDL.RWops src);

	[CCode (cname="IMG_LoadLBM_RW")]
	public static SDL.Surface load_lbm(SDL.RWops src);

	[CCode (cname="IMG_LoadPCX_RW")]
	public static SDL.Surface load_pcx(SDL.RWops src);

	[CCode (cname="IMG_LoadPNG_RW")]
	public static SDL.Surface load_png(SDL.RWops src);

	[CCode (cname="IMG_LoadPNM_RW")]
	public static SDL.Surface load_pnm(SDL.RWops src);

	[CCode (cname="IMG_LoadTIF_RW")]
	public static SDL.Surface load_tif(SDL.RWops src);

	[CCode (cname="IMG_LoadXCF_RW")]
	public static SDL.Surface load_xcf(SDL.RWops src);

	[CCode (cname="IMG_LoadXPM_RW")]
	public static SDL.Surface load_xpm(SDL.RWops src);

	[CCode (cname="IMG_ReadXPMFromArray")]
	public static SDL.Surface read_xpm(char** xpmdata);

	[CCode (cname="IMG_LoadXV_RW")]
	public static SDL.Surface load_xv(SDL.RWops src);
}// SDLImage
