/*
 * The MIT License (MIT)
 *
 * Copyright (c) 2016-2020 SDL2 VAPI Authors
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 *
 * Authors:
 *  Mario Daniel Ruiz Saavedra <desiderantes93@gmail.com>
 *  Gontzal Uriarte <txasatonga@gmail.com>
 *  Pedro H. Lara Campos <root@pedrohlc.com>
 */

[CCode (cheader_filename = "SDL2/SDL_image.h")]
namespace SDLImage {
	//! Defines

	[CCode (cname = "IMG_InitFlags", cprefix = "IMG_INIT_")]
	public enum InitFlags {
	    JPG,
	    PNG,
	    TIF,
	    WEBP,
	    [CCode (cname = "IMG_INIT_JPG|IMG_INIT_PNG|IMG_INIT_TIF|IMG_INIT_WEBP")]
	    ALL
	}

	//! General

	[CCode (cname = "IMG_Linked_Version")]
	public static unowned SDL.Version linked ();

	[CCode (cname = "IMG_Init")]
	public static int init (int flags);

	[CCode (cname = "IMG_Quit")]
	public static void quit ();

	//! Loading

	[CCode (cname = "IMG_Load")]
	public static SDL.Video.Surface? load (string file);

	[CCode (cname = "IMG_Load_RW")]
	public static SDL.Video.Surface? load_rw (SDL.RWops src, bool freesrc = false);

	[CCode (cname = "IMG_LoadTyped_RW")]
	public static SDL.Video.Surface? load_rw_typed (SDL.RWops src, bool freesrc, string type);

	[CCode (cname = "IMG_LoadTexture")]
	public static SDL.Video.Texture? load_texture (SDL.Video.Renderer renderer, string file);

	[CCode (cname = "IMG_LoadTexture_RW")]
	public static SDL.Video.Texture? load_texture_rw (SDL.Video.Renderer renderer, SDL.RWops src, bool freesrc = false);

	[CCode (cname = "IMG_LoadTextureTyped_RW")]
	public static SDL.Video.Texture? load_texture_rw_typed (SDL.Video.Renderer renderer, SDL.RWops src, bool freesrc, string type);

	[CCode (cname = "IMG_InvertAlpha")]
	public static int invert_alpha (int on);

	[CCode (cname = "IMG_LoadCUR_RW")]
	public static SDL.Video.Surface? load_cur (SDL.RWops src);

	[CCode (cname = "IMG_LoadICO_RW")]
	public static SDL.Video.Surface? load_ico (SDL.RWops src);

	[CCode (cname = "IMG_LoadBMP_RW")]
	public static SDL.Video.Surface? load_bmp (SDL.RWops src);

	[CCode (cname = "IMG_LoadPNM_RW")]
	public static SDL.Video.Surface? load_pnm (SDL.RWops src);

	[CCode (cname = "IMG_LoadXPM_RW")]
	public static SDL.Video.Surface? load_xpm (SDL.RWops src);

	[CCode (cname = "IMG_LoadXCF_RW")]
	public static SDL.Video.Surface? load_xcf (SDL.RWops src);

	[CCode (cname = "IMG_LoadPCX_RW")]
	public static SDL.Video.Surface? load_pcx (SDL.RWops src);

	[CCode (cname = "IMG_LoadGIF_RW")]
	public static SDL.Video.Surface? load_gif (SDL.RWops src);

	[CCode (cname = "IMG_LoadJPG_RW")]
	public static SDL.Video.Surface? load_jpg (SDL.RWops src);

	[CCode (cname = "IMG_LoadTIF_RW")]
	public static SDL.Video.Surface? load_tif (SDL.RWops src);

	[CCode (cname = "IMG_LoadPNG_RW")]
	public static SDL.Video.Surface? load_png (SDL.RWops src);

	[CCode (cname = "IMG_LoadTGA_RW")]
	public static SDL.Video.Surface? load_tga (SDL.RWops src);

	[CCode (cname = "IMG_LoadLBM_RW")]
	public static SDL.Video.Surface? load_lbm (SDL.RWops src);

	[CCode (cname = "IMG_LoadXV_RW")]
	public static SDL.Video.Surface? load_xv (SDL.RWops src);

	[CCode (cname = "IMG_LoadWEBP_RW")]
	public static SDL.Video.Surface? load_webp (SDL.RWops src);

	[CCode (cname = "IMG_ReadXPMFromArray")]
	public static SDL.Video.Surface? read_xpm (string[] xpmdata);

	//!Info

	[CCode (cname = "IMG_isCUR")]
	public static bool is_cur (SDL.RWops src);

	[CCode (cname = "IMG_isICO")]
	public static bool is_ico (SDL.RWops src);

	[CCode (cname = "IMG_isBMP")]
	public static bool is_bmp (SDL.RWops src);

	[CCode (cname = "IMG_isPNM")]
	public static bool is_pnm (SDL.RWops src);

	[CCode (cname = "IMG_isXPM")]
	public static bool is_xpm (SDL.RWops src);

	[CCode (cname = "IMG_isXCF")]
	public static bool is_xcf (SDL.RWops src);

	[CCode (cname = "IMG_isPCX")]
	public static bool is_pcx (SDL.RWops src);

	[CCode (cname = "IMG_isGIF")]
	public static bool is_gif (SDL.RWops src);

	[CCode (cname = "IMG_isJPG")]
	public static bool is_jpg (SDL.RWops src);

	[CCode (cname = "IMG_isTIF")]
	public static bool is_tif (SDL.RWops src);

	[CCode (cname = "IMG_isPNG")]
	public static bool is_png (SDL.RWops src);

	[CCode (cname = "IMG_isLBM")]
	public static bool is_lbm (SDL.RWops src);

	[CCode (cname = "IMG_isXV")]
	public static bool is_xv (SDL.RWops src);

	[CCode (cname = "IMG_isWEBP")]
	public static bool is_webp (SDL.RWops src);
} // SDLImage
