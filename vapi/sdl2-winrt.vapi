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

namespace SDL {

	[CCode (cheader_filename = "SDL2/SDL_system.h")]
	[Compact]
	public class WinRt {
		[CCode (cname = "SDL_WinRT_Path", cprefix = "SDL_WINRT_PATH_")]
		public enum WinRTPath {
			/**
			 * The installed app's root directory.<<BR>>
			 * Files here are likely to be read-only.
			 */
			INSTALLED_LOCATION,
			/**
			 * The app's local data store.  Files may be written here
			 */
			LOCAL_FOLDER,
			/**
			 * The app's roaming data store.  Unsupported on Windows Phone.<<BR>>
			 * Files written here may be copied to other machines via a network
			 * connection.
			 */
			ROAMING_FOLDER,
			/**
			 * The app's temporary data store.  Unsupported on Windows Phone.<<BR>>
			 * Files written here may be deleted at any time.
			 */
			TEMP_FOLDER;

			[CCode (cname = "SDL_WinRTGetFSPathUTF8")]
			public unowned string get_fs_path ();
		}
	}

}
