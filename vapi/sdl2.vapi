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


[CCode (cprefix = "SDL_", cheader_filename = "SDL2/SDL.h")]
namespace SDL {
	///
	/// Initialization
	///
	/**
	 * These flags can be OR'd together.
	 */
	[Flags, CCode (cname = "int", cprefix = "SDL_INIT_")]
	public enum InitFlag {
		/**
		 * timer subsystem
		 */
		TIMER,
		/**
		 * audio subsystem
		 */
		AUDIO,
		/**
		 * video subsystem
		 */
		VIDEO,
		/**
		 * joystick subsystem
		 */
		JOYSTICK,
		/**
		 * haptic (force feedback) subsystem
		 */
		HAPTIC,
		/**
		 * controller subsystem
		 */
		GAMECONTROLLER,
		/**
		 * events subsystem
		 */
		EVENTS,
		/**
		 * All of the above subsystems beside.
		 */
		EVERYTHING,
		/**
		 * Prevents SDL from catching fatal signals.
		 */
		NOPARACHUTE
	}// InitFlag

	/**
	 * Use this function to initialize the SDL library. This must be called before using any other SDL function.
	 *
	 * All subsystems are initialized by default.
	 *
	 * If you want to initialize subsystems separately you would call:
	 *
	 * {{{
	 * SDL.init (0);
	 * }}}
	 *
	 * followed by {@link SDL.init_subsystem} with the desired subsystem flag.
	 *
	 * @param flags subsystem initialization flags.
	 *
	 * @return Returns 0 on success or a negative error code on failure; call {@link SDL.get_error} for more information.
	 */
	[Version (since = "2.0.0")]
	[CCode (cname = "SDL_Init")]
	public static int init (uint32 flags = SDL.InitFlag.EVERYTHING);

	/**
	 * Use this function to initialize specific SDL subsystems.
	 *
	 * {@link SDL.init} initializes assertions and crash protection and then calls {@link SDL.init_subsystem}.
	 * If you want to bypass those protections you can call {@link SDL.init_subsystem} directly.
	 *
	 * Subsystem initialization is ref-counted, you must call {@link SDL.quit_subsystem} for each {@link SDL.init_subsystem}
	 * to correctly shutdown a subsystem manually (or call {@link SDL.quit} to force shutdown).
	 * If a subsystem is already loaded then this call will increase the ref-count and return.
	 *
	 * @param flags any of the flags used by {@link SDL.init}.
	 *
	 * @return Returns 0 on success or a negative error code on failure; call {@link SDL.get_error} for more information.
	 */
	[CCode (cname = "SDL_InitSubSystem")]
	public static int init_subsystem (uint32 flags);

	/**
	 * Use this function to return a mask of the specified subsystems which have previously been initialized.
	 *
	 * Examples:
	 * {{{
	 * // Get init data on all the subsystems
	 * uint32 subsystem_init = SDL.get_initialized (SDL.InitFlag.EVERYTHING);
	 * if (subsystem_init & SDL.InitFlag.VIDEO)
	 *  //Video is initialized
	 * }}}
	 * {{{
	 * // Just check for one specific subsystem
	 * if (SDL.get_initialized (SDL.InitFlag.VIDEO) != 0)
	 *  //Video is initialized
	 * }}}
	 * {{{
	 * // Check for two subsystems
	 * uint32 mask = SDL.InitFlag.VIDEO | SDL.InitFlag.AUDIO;
	 * if (SDL.get_initialized (mask) == mask)
	 *  //Video and Audio is initialized
	 * }}}
	 *
	 * @param flags any of the flags used by {@link SDL.init}.
	 *
	 * @return If flags is 0 it returns a mask of all initialized subsystems, otherwise it returns the initialization status of the specified subsystems.
	 * The return value does not include {@link SDL.InitFlag.NOPARACHUTE}.
	 */
	[CCode (cname = "SDL_WasInit")]
	public static uint32 get_initialized (uint32 flags);


	/**
	 * Use this function to clean up all initialized subsystems. You should call it upon all exit conditions.
	 *
	 * You should call this function even if you have already shutdown each initialized subsystem with {@link SDL.quit_subsystem}.
	 * It is safe to call this function even in the case of errors in initialization.
	 *
	 * If you start a subsystem using a call to that subsystem's init function (for example {@link SDL.Video.init})
	 * instead of {@link SDL.init} or {@link SDL.init_subsystem}, then you must use that subsystem's quit function ({@link SDL.Video.quit})
	 * to shut it down before calling {@link SDL.quit}.
	 */
	[CCode (cname = "SDL_Quit")]
	public static void quit ();

	/**
	 * Use this function to shut down specific SDL subsystems.
	 *
	 * @param flags any of the flags used by {@link SDL.init}.
	 */
	[CCode (cname = "SDL_QuitSubSystem")]
	public static void quit_subsystem (uint32 flags);

	//
	// CPU Info
	//

	[CCode (cheader_filename = "SDL2/SDL_cpuinfo.h")]
	[Compact]
	public class CPU {
		[Version (since = "2.0.0")]
		[CCode (cname = "SDL_GetCPUCacheLineSize")]
		public static int get_cache_line_size ();

		/**
		 * This function name is misleading, you get logical core count, not physical CPU count
		 */
		[Version (since = "2.0.0")]
		[CCode (cname = "SDL_GetCPUCount")]
		public static int get_num_cores ();

		[Version (since = "2.0.1")]
		[CCode (cname = "SDL_GetSystemRAM")]
		public static int get_system_ram ();

		[Version (since = "2.0.0")]
		[CCode (cname = "SDL_Has3DNow")]
		public static bool has_3dnow ();

		[Version (since = "2.0.2")]
		[CCode (cname = "SDL_HasAVX")]
		public static bool has_avx ();

		[Version (since = "2.0.4")]
		[CCode (cname = "SDL_HasAVX2")]
		public static bool has_avx2 ();

		[CCode (cname = "SDL_HasAltiVec")]
		public static bool has_altivec ();

		[CCode (cname = "SDL_HasMMX")]
		public static bool has_mmx ();

		[CCode (cname = "SDL_HasRDTSC")]
		public static bool has_rdtsc ();

		[CCode (cname = "SDL_HasSSE")]
		public static bool has_sse ();

		[CCode (cname = "SDL_HasSSE2")]
		public static bool has_sse2 ();

		[CCode (cname = "SDL_HasSSE3")]
		public static bool has_sse3 ();

		[CCode (cname = "SDL_HasSSE41")]
		public static bool has_sse41 ();

		[CCode (cname = "SDL_HasSSE42")]
		public static bool has_sse42 ();
	}

	[CCode (type_id = "SDL_version", cheader_filename = "SDL2/SDL_version.h", cname = "SDL_version")]
	public class Version {
		public uint8 major;
		public uint8 minor;
		public uint8 patch;

		[CCode (cname = "SDL_GetVersion")]
		public static unowned Version get_version ();

		[CCode (cname = "SDL_GetRevision")]
		public static unowned string get_revision ();

		[CCode (cname = "SDL_GetRevisionNumber")]
		public static int get_revision_number ();
	}// Version

	///
	/// Hints
	///
	[CCode (cheader_filename = "SDL2/SDL_hints.h")]
	[Compact]
	public class Hint {
		/**
		 * A variable controlling how 3D acceleration is used to accelerate the SDL screen surface.
		 *
		 * SDL can try to accelerate the SDL screen surface by using streaming
		 * textures with a 3D rendering engine. This variable controls whether and
		 * how this is done.
		 *
		 * This variable can be set to the following values:
		 *
		 *  * "0"    - Disable 3D acceleration
		 *  * "1"    - Enable 3D acceleration, using the default renderer.
		 *  * "X"    - Enable 3D acceleration, using X where X is one of the valid rendering drivers. (e.g. "direct3d", "opengl", etc.)
		 *
		 * By default SDL tries to make a best guess for each platform whether
		 * to use acceleration or not.
		 */
		[CCode (cname = "SDL_HINT_FRAMEBUFFER_ACCELERATION")]
		public const string FRAMEBUFFER_ACCELERATION;

		/**
		 * A variable specifying which render driver to use.
		 *
		 * If the application doesn't pick a specific renderer to use, this variable
		 * specifies the name of the preferred renderer. If the preferred renderer
		 * can't be initialized, the normal default renderer is used.
		 *
		 * This variable is case insensitive and can be set to the following values:
		 *
		 *  * "direct3d"
		 *  * "opengl"
		 *  * "opengles2"
		 *  * "opengles"
		 *  * "software"
		 *
		 * The default varies by platform, but it's the first one in the list that
		 * is available on the current platform.
		 */
		[CCode (cname = "SDL_HINT_RENDER_DRIVER")]
		public const string RENDER_DRIVER;

		/**
		 * A variable controlling whether the OpenGL render driver uses shaders if they are available.
		 *
		 * This variable can be set to the following values:
		 *
		 *  * "0"    - Disable shaders
		 *  * "1"    - Enable shaders
		 *
		 * By default shaders are used if OpenGL supports them.
		 */
		[CCode (cname = "SDL_HINT_RENDER_OPENGL_SHADERS")]
		public const string RENDER_OPENGL_SHADERS;

		/**
		 * A variable controlling whether the Direct3D device is initialized for thread-safe operations.
		 *
		 * This variable can be set to the following values:
		 *
		 *  * "0"    - Thread-safety is not enabled (faster)
		 *  * "1"    - Thread-safety is enabled
		 *
		 * By default the Direct3D device is created with thread-safety disabled.
		 */
		[Version (since = "2.0.1")]
		[CCode (cname = "SDL_HINT_RENDER_DIRECT3D_THREADSAFE")]
		public const string RENDER_DIRECT3D_THREADSAFE;

		/**
		 * A variable controlling whether to enable Direct3D 11+'s Debug Layer.
		 *
		 * This variable does not have any effect on the Direct3D 9 based renderer.
		 *
		 * This variable can be set to the following values:
		 *
		 *  * "0"    - Disable Debug Layer use
		 *  * "1"    - Enable Debug Layer use
		 *
		 * By default, SDL does not use Direct3D Debug Layer.
		 */
		[Version (since = "2.0.3")]
		[CCode (cname = "SDL_HINT_RENDER_DIRECT3D11_DEBUG")]
		public const string RENDER_DIRECT3D11_DEBUG;

		/**
		 * A variable controlling the scaling quality
		 *
		 * This variable can be set to the following values:
		 *
		 *  * "0" or "nearest" - Nearest pixel sampling
		 *  * "1" or "linear" - Linear filtering (supported by OpenGL and Direct3D)
		 *  * "2" or "best"  - Currently this is the same as "linear"
		 *
		 * By default nearest pixel sampling is used
		 */
		[CCode (cname = "SDL_HINT_RENDER_SCALE_QUALITY")]
		public const string RENDER_SCALE_QUALITY;

		/**
		 * A variable controlling whether updates to the SDL screen surface should be synchronized with the vertical refresh, to avoid tearing.
		 *
		 * This variable can be set to the following values:
		 *
		 *  * "0"    - Disable vsync
		 *  * "1"    - Enable vsync
		 *
		 * By default SDL does not sync screen surface updates with vertical refresh.
		 */
		[CCode (cname = "SDL_HINT_RENDER_VSYNC")]
		public const string RENDER_VSYNC;

		/**
		 * A variable controlling whether the screensaver is enabled.
		 *
		 * This variable can be set to the following values:
		 *
		 *  * "0"    - Disable screensaver
		 *  * "1"    - Enable screensaver
		 *
		 * By default SDL will disable the screensaver.
		 */
		[Version (since = "2.0.2")]
		[CCode (cname = "SDL_HINT_VIDEO_ALLOW_SCREENSAVER")]
		public const string VIDEO_ALLOW_SCREENSAVER;

		/**
		 * A variable controlling whether the X11 VidMode extension should be used.
		 *
		 * This variable can be set to the following values:
		 *
		 *  * "0"    - Disable XVidMode
		 *  * "1"    - Enable XVidMode
		 *
		 * By default SDL will use XVidMode if it is available.
		 */
		[CCode (cname = "SDL_HINT_VIDEO_X11_XVIDMODE")]
		public const string VIDEO_X11_XVIDMODE;

		/**
		 * A variable controlling whether the X11 Xinerama extension should be used.
		 *
		 * This variable can be set to the following values:
		 *
		 *  * "0"    - Disable Xinerama
		 *  * "1"    - Enable Xinerama
		 *
		 * By default SDL will use Xinerama if it is available.
		 */
		[CCode (cname = "SDL_HINT_VIDEO_X11_XINERAMA")]
		public const string VIDEO_X11_XINERAMA;

		/**
		 * A variable controlling whether the X11 XRandR extension should be used.
		 *
		 * This variable can be set to the following values:
		 *
		 *  * "0"    - Disable XRandR
		 *  * "1"    - Enable XRandR
		 *
		 * By default SDL will not use XRandR because of window manager issues.
		 */
		[CCode (cname = "SDL_HINT_VIDEO_X11_XRANDR")]
		public const string VIDEO_X11_XRANDR;

		/**
		 * A variable controlling whether grabbing input grabs the keyboard
		 *
		 * This variable can be set to the following values:
		 *
		 *  * "0"    - Grab will affect only the mouse
		 *  * "1"    - Grab will affect mouse and keyboard
		 *
		 * By default SDL will not grab the keyboard so system shortcuts still work.
		 */
		[CCode (cname = "SDL_HINT_GRAB_KEYBOARD")]
		public const string GRAB_KEYBOARD;

		/**
		 * A variable controlling whether relative mouse mode is implemented using mouse warping
		 *
		 * This variable can be set to the following values:
		 *
		 *  * "0"    - Relative mouse mode uses raw input
		 *  * "1"    - Relative mouse mode uses mouse warping
		 *
		 * By default SDL will use raw input for relative mouse mode
		 */
		[Version (since = "2.0.2")]
		[CCode (cname = "SDL_HINT_MOUSE_RELATIVE_MODE_WARP")]
		public const string MOUSE_RELATIVE_MODE_WARP;

		/**
		 * Minimize your SDL_Window if it loses key focus when in fullscreen mode. Defaults to true.
		 */
		[CCode (cname = "SDL_HINT_VIDEO_MINIMIZE_ON_FOCUS_LOSS")]
		public const string VIDEO_MINIMIZE_ON_FOCUS_LOSS;

		/**
		 * A variable controlling whether the idle timer is disabled on iOS.
		 *
		 * When an iOS app does not receive touches for some time, the screen is
		 * dimmed automatically. For games where the accelerometer is the only input
		 * this is problematic. This functionality can be disabled by setting this
		 * hint.
		 *
		 * This variable can be set to the following values:
		 *
		 *  * "0"    - Enable idle timer
		 *  * "1"    - Disable idle timer
		 */
		[CCode (cname = "SDL_HINT_IOS_IDLE_TIMER_DISABLED")]
		public const string IOS_IDLE_TIMER_DISABLED;

		/**
		 * A variable controlling which orientations are allowed on iOS.
		 *
		 * In some circumstances it is necessary to be able to explicitly control
		 * which UI orientations are allowed.
		 *
		 * This variable is a space delimited list of the following values:
		 *
		 * "LandscapeLeft", "LandscapeRight", "Portrait" "PortraitUpsideDown"
		 */
		[CCode (cname = "SDL_HINT_IOS_ORIENTATIONS")]
		public const string IOS_ORIENTATIONS;

		/**
		 * A variable controlling whether an Android built-in accelerometer should be
		 * listed as a joystick device, rather than listing actual joysticks only.
		 *
		 * This variable can be set to the following values:
		 *
		 *  * "0"    - List only real joysticks and accept input from them
		 *  * "1"    - List real joysticks along with the accelerometer as if it were a 3 axis joystick (the default).
		 */
		[Version (since = "2.0.2")]
		[CCode (cname = "SDL_HINT_ACCELEROMETER_AS_JOYSTICK")]
		public const string ACCELEROMETER_AS_JOYSTICK;

		/**
		 * A variable that lets you disable the detection and use of Xinput gamepad devices
		 *
		 * The variable can be set to the following values:
		 *
		 *  * "0"    - Disable XInput detection (only uses direct input)
		 *  * "1"    - Enable XInput detection (the default)
		 */
		[CCode (cname = "SDL_HINT_XINPUT_ENABLED")]
		public const string XINPUT_ENABLED;

		/**
		 * A variable that lets you manually hint extra gamecontroller db entries
		 *
		 * The variable should be newline delimited rows of gamecontroller config data, see SDL_gamecontroller.h
		 *
		 * This hint must be set before calling SDL_Init (SDL_INIT_GAMECONTROLLER)
		 * You can update mappings after the system is initialized with SDL_GameControllerMappingForGUID () and SDL_GameControllerAddMapping ()
		 */
		[CCode (cname = "SDL_HINT_GAMECONTROLLERCONFIG")]
		public const string GAMECONTROLLERCONFIG;

		/**
		 * A variable that lets you enable joystick (and gamecontroller) events even when your app is in the background.
		 *
		 * The variable can be set to the following values:
		 *
		 *  * "0"    - Disable joystick & gamecontroller input events when the
		 *        application is in the background.
		 *  * "1"    - Enable joystick & gamecontroller input events when the
		 *        application is in the background.
		 *
		 * The default value is "0". This hint may be set at any time.
		 */
		[CCode (cname = "SDL_HINT_JOYSTICK_ALLOW_BACKGROUND_EVENTS")]
		public const string JOYSTICK_ALLOW_BACKGROUND_EVENTS;

		/**
		 * If set to 0 then never set the top most bit on a SDL Window, even if the video mode expects it.
		 * This is a debugging aid for developers and not expected to be used by end users. The default is "1"
		 *
		 * This variable can be set to the following values:
		 *
		 *  * "0"    - don't allow topmost
		 *  * "1"    - allow topmost
		 */
		[CCode (cname = "SDL_HINT_ALLOW_TOPMOST")]
		public const string ALLOW_TOPMOST;

		/**
		 * A variable that controls the timer resolution, in milliseconds.
		 *
		 * The higher resolution the timer, the more frequently the CPU services
		 * timer interrupts, and the more precise delays are, but this takes up
		 * power and CPU time. This hint is only used on Windows 7 and earlier.
		 *
		 * See this blog post for more information:
		 * [[http://randomascii.wordpress.com/2013/07/08/windows-timer-resolution-megawatts-wasted/]]
		 *
		 * If this variable is set to "0", the system timer resolution is not set.
		 *
		 * The default value is "1". This hint may be set at any time.
		 */
		[CCode (cname = "SDL_HINT_TIMER_RESOLUTION")]
		public const string TIMER_RESOLUTION;

		/**
		 * If set to 1, then do not allow high-DPI windows. ("Retina" on Mac).
		 *
		 * Supported for iOS since SDL 2.0.4.
		 */
		[Version (since = "2.0.1")]
		[CCode (cname = "SDL_HINT_VIDEO_HIGHDPI_DISABLED")]
		public const string VIDEO_HIGHDPI_DISABLED;

		/**
		 * A variable that determines whether ctrl+click should generate a right-click event on Mac
		 *
		 * If present, holding ctrl while left clicking will generate a right click
		 * event when on Mac.
		 */
		[Version (since = "2.0.2")]
		[CCode (cname = "SDL_HINT_MAC_CTRL_CLICK_EMULATE_RIGHT_CLICK")]
		public const string MAC_CTRL_CLICK_EMULATE_RIGHT_CLICK;

		/**
		 * A variable specifying if mouse click events are sent when clicking to focus an SDL window on Apple Mac OS X.
		 *
		 * By default no mouse click events are sent when clicking to focus. Only on Mac OS X.
		 *
		 * The variable can be set to the following values:
		 *
		 *  * "0"    - No mouse click events are sent when clicking to focus
		 *  * "1"    - Mouse click events are sent when clicking to focus
		 */
		[Version (experimental = true)]
		[CCode (cname = "SDL_HINT_MAC_MOUSE_FOCUS_CLICKTHROUGH")]
		public const string MAC_MOUSE_FOCUS_CLICKTHROUGH;

		/**
		 * A variable specifying which shader compiler to preload when using the Chrome ANGLE binaries
		 *
		 * SDL has EGL and OpenGL ES2 support on Windows via the ANGLE project. It
		 * can use two different sets of binaries, those compiled by the user from source
		 * or those provided by the Chrome browser. In the later case, these binaries require
		 * that SDL loads a DLL providing the shader compiler.
		 *
		 * This variable can be set to the following values:
		 *
		 *  * "d3dcompiler_46.dll" - default, best for Vista or later.
		 *  * "d3dcompiler_43.dll" - for XP support.
		 *  * "none" - do not load any library, useful if you compiled ANGLE from source and included the compiler in your binaries.
		 */
		[Version (since = "2.0.2")]
		[CCode (cname = "SDL_HINT_VIDEO_WIN_D3DCOMPILER")]
		public const string VIDEO_WIN_D3DCOMPILER;

		/**
		 * A variable that is the address of another {@link SDL.Video.Window} (as a hex string formatted with "%p"
		 *
		 * If this hint is set before {@link SDL.Video.Window.Window.from_native} and the Window it is set to has
		 * WINDOW_OPENGL set (and running on WGL only, currently), then two things will occur on the newly
		 * created Window:
		 *
		 * 1. Its pixel format will be set to the same pixel format as this Window. This is
		 * needed for example when sharing an OpenGL context across multiple windows.
		 *
		 * 2. The flag WINDOW_OPENGL will be set on the new window so it can be used for
		 * OpenGL rendering.
		 *
		 * This variable can be set to the following values:
		 *
		 * The address (as a string "%p") of the Window that new windows created with CreateWindowFrom () should
		 * share a pixel format with.
		 */
		[Version (since = "2.0.2")]
		[CCode (cname = "SDL_HINT_VIDEO_WINDOW_SHARE_PIXEL_FORMAT")]
		public const string VIDEO_WINDOW_SHARE_PIXEL_FORMAT;

		/**
		 * A URL to a WinRT app's privacy policy
		 *
		 * All network-enabled WinRT apps must make a privacy policy available to its
		 * users. On Windows 8, 8.1, and RT, Microsoft mandates that this policy be
		 * be available in the Windows Settings charm, as accessed from within the app.
		 * SDL provides code to add a URL-based link there, which can point to the app's
		 * privacy policy.
		 *
		 * To setup a URL to an app's privacy policy, set SDL_HINT_WINRT_PRIVACY_POLICY_URL
		 * before calling any SDL_Init functions. The contents of the hint should
		 * be a valid URL. For example, [["http://www.example.com"]].
		 *
		 * The default value is "", which will prevent SDL from adding a privacy policy
		 * link to the Settings charm. This hint should only be set during app init.
		 *
		 * The label text of an app's "Privacy Policy" link may be customized via another
		 * hint, SDL_HINT_WINRT_PRIVACY_POLICY_LABEL.
		 *
		 * Please note that on Windows Phone, Microsoft does not provide standard UI
		 * for displaying a privacy policy link, and as such, SDL_HINT_WINRT_PRIVACY_POLICY_URL
		 * will not get used on that platform. Network-enabled phone apps should display
		 * their privacy policy through some other, in-app means.
		 */
		[Version (since = "2.0.3")]
		[CCode (cname = "SDL_HINT_WINRT_PRIVACY_POLICY_URL")]
		public const string WINRT_PRIVACY_POLICY_URL;

		/**
		 * Label text for a WinRT app's privacy policy link
		 *
		 * Network-enabled WinRT apps must include a privacy policy. On Windows 8, 8.1, and RT,
		 * Microsoft mandates that this policy be available via the Windows Settings charm.
		 * SDL provides code to add a link there, with it's label text being set via the
		 * optional hint, WINRT_PRIVACY_POLICY_LABEL.
		 *
		 * Please note that a privacy policy's contents are not set via this hint. A separate
		 * hint, WINRT_PRIVACY_POLICY_URL, is used to link to the actual text of the
		 * policy.
		 *
		 * The contents of this hint should be encoded as a UTF8 string.
		 *
		 * The default value is "Privacy Policy". This hint should only be set during app
		 * initialization, preferably before any calls to SDL_Init.
		 *
		 * For additional information on linking to a privacy policy, see the documentation for
		 * {@link SDL.Hint.WINRT_PRIVACY_POLICY_URL}.
		 */
		[Version (since = "2.0.3")]
		[CCode (cname = "SDL_HINT_WINRT_PRIVACY_POLICY_LABEL")]
		public const string WINRT_PRIVACY_POLICY_LABEL;

		/**
		 * If set to 1, back button press events on Windows Phone 8+ will be marked as handled.
		 *
		 * TODO, WinRT: document SDL_HINT_WINRT_HANDLE_BACK_BUTTON need and use
		 * For now, more details on why this is needed can be found at [[https://msdn.microsoft.com/library/windows/apps/jj247550%20(v%20=%20vs.105).aspx|MSDN]]
		 */
		[Version (since = "2.0.3")]
		[CCode (cname = "SDL_HINT_WINRT_HANDLE_BACK_BUTTON")]
		public const string WINRT_HANDLE_BACK_BUTTON;

		/**
		 * A variable that dictates policy for fullscreen Spaces on Mac OS X.
		 *
		 * This hint only applies to Mac OS X.
		 *
		 * The variable can be set to the following values:
		 *
		 *  * "0"    - Disable Spaces support (FULLSCREEN_DESKTOP won't use them and
		 *        SDL_WINDOW_RESIZABLE windows won't offer the "fullscreen"
		 *        button on their titlebars).
		 *  * "1"    - Enable Spaces support (FULLSCREEN_DESKTOP will use them and
		 *        SDL_WINDOW_RESIZABLE windows will offer the "fullscreen"
		 *        button on their titlebars.
		 *
		 * The default value is "1". Spaces are disabled regardless of this hint if
		 * the OS isn't at least Mac OS X Lion (10.7). This hint must be set before
		 * any windows are created.
		 */
		[Version (since = "2.0.2")]
		[CCode (cname = "SDL_HINT_VIDEO_MAC_FULLSCREEN_SPACES")]
		public const string VIDEO_MAC_FULLSCREEN_SPACES;

		//SDL 2.0.4 Hints

		/**
		 * A hint that specifies a variable to control whether mouse and touch events are to be treated together or separately.
		 *
		 * The value of this hint is used at runtime, so it can be changed at any time.
		 *
		 * The variable can be set to the following values:
		 *
		 *  * "0"    - mouse events will be handled as touch events and touch will
		 *        raise fake mouse events
		 *  * "1"    - mouse events will be handled separately from pure touch events
		 *
		 * By default mouse events will be handled as touch events and touch will raise fake mouse events.
		*/
		[Version (since = "2.0.4")]
		[CCode (cname = "SDL_HINT_ANDROID_SEPARATE_MOUSE_AND_TOUCH")]
		public const string ANDROID_SEPARATE_MOUSE_AND_TOUCH;

		/**
		 * A hint that specifies the Android APK expansion patch file version.
		 *
		 * This hint must be set together with the hint {@link Hint.ANDROID_APK_EXPANSION_MAIN_FILE_VERSION}.
		 *
		 * If both hints were set then {@link RWops.RWops.from_file} will look into expansion files after a given relative path was not found in the internal storage and assets.
		 *
		 * This hint should be set with the Android APK expansion patch file version (should be a string number like "1", "2" etc.)
		 *
		 * By default this hint is not set and the APK expansion files are not searched.
		*/
		[Version (since = "2.0.4")]
		[CCode (cname = "SDL_HINT_ANDROID_APK_EXPANSION_PATCH_FILE_VERSION")]
		public const string ANDROID_APK_EXPANSION_PATCH_FILE_VERSION;

		/**
		 * A hint that specifies the Android APK expansion main file version.
		 *
		 * This hint must be set together with the hint {@link Hint.ANDROID_APK_EXPANSION_PATCH_FILE_VERSION}.
		 *
		 * If both hints were set then {@link RWops.RWops.from_file} will look into expansion files after a given relative path was not found in the internal storage and assets.
		 *
		 * This hint should be set with the Android APK expansion patch file version (should be a string number like "1", "2" etc.)
		 *
		 * By default this hint is not set and the APK expansion files are not searched.
		*/
		[Version (since = "2.0.4")]
		[CCode (cname = "SDL_HINT_ANDROID_APK_EXPANSION_MAIN_FILE_VERSION")]
		public const string ANDROID_APK_EXPANSION_MAIN_FILE_VERSION;

		/**
		 * A hint that specifies not to catch the SIGINT or SIGTERM signals.
		 *
		 * The variable can be set to the following values:
		 *
		 *  * "0"    - SDL will install a SIGINT and SIGTERM handler, and when it
		 *        catches a signal, convert it into an SDL_QUIT event
		 *  * "1"    - SDL will not install a signal handler at all
		 *
		 * By default SDL installs a SIGINT and SIGTERM handler, and when it catches a signal, converts it into an SDL_QUIT event.
		*/
		[Version (since = "2.0.4")]
		[CCode (cname = "SDL_HINT_NO_SIGNAL_HANDLERS")]
		public const string NO_SIGNAL_HANDLERS;

		/**
		 * A hint that specifies whether certain IMEs should handle text editing internally instead of sending SDL_TEXTEDITING events.
		 *
		 * The variable can be set to the following values:
		 *
		 *  * "0"    - SDL_TEXTEDITING events are sent, and it is the application's
		 *        responsibility to render the text from these events and
		 *        differentiate it somehow from committed text. (default)
		 *  * "1"    - If supported by the IME then SDL_TEXTEDITING events are
		 *        not sent, and text that is being composed will be rendered
		 *        in its own UI.
		 *
		 * By default SDL_TEXTEDITING events are sent, and it is the application's responsibility to render the text from these events and differentiate it somehow from committed text.
		*/
		[Version (since = "2.0.4")]
		[CCode (cname = "SDL_HINT_IME_INTERNAL_EDITING")]
		public const string IME_INTERNAL_EDITING;

		/**
		 * A hint that specifies a value to override the binding element for keyboard inputs for Emscripten builds.
		 *
		 * The variable can be set to the following values:
		 *
		 *  * "#window"    - the JavaScript window object (this is the default)
		 *  * "#document"   - the JavaScript document object
		 *  * "#screen"    - the JavaScript window.screen object
		 *  * "#canvas"    - the default WebGL canvas element
		 *
		 * Any other string without a leading # sign applies to the element on the page with that ID.
		 *
		 * By default SDL will use the JavaScript window object.
		*/
		[Version (since = "2.0.4")]
		[CCode (cname = "SDL_HINT_EMSCRIPTEN_KEYBOARD_ELEMENT")]
		public const string EMSCRIPTEN_KEYBOARD_ELEMENT;

		/**
		 * A hint that specifies a variable specifying SDL's threads stack size in bytes or "0" for the backend's default size.
		 *
		 * Use this hint in case you need to set SDL's threads stack size to other than the default. This is specially
		 * useful if you build SDL against a non glibc libc library (such as musl) which provides a relatively small default
		 * thread stack size (a few kilobytes versus the default 8 MB glibc uses).
		 *
		 * Support for this hint is currently available only in the pthread backend.
		 *
		 * The variable can be set to the following values:
		 *
		 *  * "0"    - SDL will use the backend's default threads stack size
		 *  * "X"    - SDL will use the provided the X positive you provided as the threads stack size
		 *
		 * By default the backend's default threads stack size is used.
		*/
		[Version (since = "2.0.4")]
		[CCode (cname = "SDL_HINT_THREAD_STACK_SIZE")]
		public const string THREAD_STACK_SIZE;

		/**
		 * A hint that specifies whether the window frame and title bar are interactive when the cursor is hidden.
		 *
		 * The variable can be set to the following values:
		 *
		 *  * "0"    - The window frame is not interactive when the cursor is hidden (no move, resize, etc)
		 *  * "1"    - The window frame is interactive when the cursor is hidden
		 *
		 * By default SDL will allow interaction with the window frame when the cursor is hidden.
		*/
		[Version (since = "2.0.4")]
		[CCode (cname = "SDL_HINT_WINDOW_FRAME_USABLE_WHILE_CURSOR_HIDDEN")]
		public const string WINDOW_FRAME_USABLE_WHILE_CURSOR_HIDDEN;

		/**
		 * A hint that specifies whether the windows message loop is processed by SDL.
		 *
		 * The variable can be set to the following values:
		 *
		 *  * "0"    - The window message loop is not run
		 *  * "1"    - The window message loop is processed in {@link SDL.Event.pump}
		 *
		 * By default SDL will process the windows message loop.
		*/
		[Version (since = "2.0.4")]
		[CCode (cname = "SDL_HINT_WINDOWS_ENABLE_MESSAGELOOP")]
		public const string WINDOWS_ENABLE_MESSAGELOOP;

		/**
		 * A hint that specifies that SDL should not to generate an {@link SDL.WindowEvent} of type {@link SDL.WindowEventType.CLOSE} for Alt+F4 on Microsoft Windows.
		 *
		 * The variable can be set to the following values:
		 *
		 *  * "0"    - generate an {@link SDL.WindowEvent} of type {@link SDL.WindowEventType.CLOSE} for Alt+F4 (default)
		 *  * "1"    - Do not generate event and only do normal key handling for Alt+F4
		 *
		 * By default SDL will process the windows message loop.
		*/
		[Version (since = "2.0.4")]
		[CCode (cname = "SDL_HINT_WINDOWS_NO_CLOSE_ON_ALT_F4")]
		public const string WINDOWS_NO_CLOSE_ON_ALT_F4;

		/**
		 * A hint that specifies that SDL should use the old axis and button mapping for XInput devices.
		 *
		 * This hint is for backwards compatibility only and will be removed in SDL 2.1
		 *
		 * The default value is "0". This hint must be set before {@link SDL.init}.
		 *
		 * The variable can be set to the following values:
		 *
		 *  * "0"    - SDL will use the old axis and button mapping for XInput devices
		 *  * "1"    - SDL won't use old axis and button mapping for XInput devices
		 *
		 * By default SDL does not use the old axis and button mapping for XInput devices.
		*/
		[Version (since = "2.0.4", deprecated_since = "2.1")]
		[CCode (cname = "SDL_HINT_XINPUT_USE_OLD_JOYSTICK_MAPPING")]
		public const string XINPUT_USE_OLD_JOYSTICK_MAPPING;

		/**
		 * A hint that specifies if the SDL app should not be forced to become a foreground process on Mac OS X.
		 *
		 * The variable can be set to the following values:
		 *
		 *  * "0"    - SDL will force the app to become a foreground process (default)
		 *  * "1"    - SDL won't not force the SDL app to become a foreground process
		 *
		 * By default the SDL app will be forced to become a foreground process on Mac OS X.
		*/
		[Version (since = "2.0.4")]
		[CCode (cname = "SDL_HINT_MAC_BACKGROUND_APP")]
		public const string MAC_BACKGROUND_APP;

		/**
		 * A hint that specifies whether the X11 _NET_WM_PING protocol should be supported.
		 *
		 * The hint is checked in the {@link Video.Window} constructor
		 *
		 * The variable can be set to the following values:
		 *
		 *  * "0"    - disable _NET_WM_PING
		 *  * "1"    - enable _NET_WM_PING
		 *
		 * By default SDL will use _NET_WM_PING, but for applications that know they will not always be able to
		 * respond to ping requests in a timely manner they can turn it off to avoid the window manager thinking
		 * the app is hung.
		*/
		[Version (since = "2.0.4")]
		[CCode (cname = "SDL_HINT_VIDEO_X11_NET_WM_PING")]
		public const string VIDEO_X11_NET_WM_PING;

		/**
		 * A hint that specifies if mouse click events are sent when clicking to focus an SDL window.
		 *
		 * The variable can be set to the following values:
		 *
		 *  * "0"    - no mouse click events are sent when clicking to focus
		 *  * "1"    - mouse click events are sent when clicking to focus
		 *
		 * By default no mouse click events are sent when clicking to focus.
		 *
		*/
		[Version (since = "2.0.5")]
		[CCode (cname = "SDL_HINT_MOUSE_FOCUS_CLICKTHROUGH")]
		public const string MOUSE_FOCUS_CLICKTHROUGH;

		/**
		 * A hint that specifies whether SDL should not use version 4 of the bitmap header when saving BMPs.
		 * Version 4 includes alpha support.
		 *
		 * The variable can be set to the following values:
		 *
		 *  * "0"    - version 4 of the bitmap header will be used when saving BMPs
		 *  * "1"    - version 4 of the bitmap header will not be used when saving BMPs
		 *
		 * By default SDL will use version 4 of the bitmap header when saving BMPs.
		 *
		*/
		[Version (since = "2.0.5")]
		[CCode (cname = "SDL_HINT_BMP_SAVE_LEGACY_FORMAT")]
		public const string BMP_SAVE_LEGACY_FORMAT;

		/**
		 * A hint that specifies whether SDL should not name threads on Microsoft Windows.
		 * Might be useful if you want to interop with C# there.
		 *
		 * The variable can be set to the following values:
		 *
		 *  * "0"    - threads will be named
		 *  * "1"    - threads will not be named
		 *
		 * By default SDL will name threads on Microsoft Windows.
		 *
		*/
		[Version (since = "2.0.5")]
		[CCode (cname = "SDL_HINT_WINDOWS_DISABLE_THREAD_NAMING")]
		public const string WINDOWS_DISABLE_THREAD_NAMING;

		/**
		 * A hint that specifies whether the Apple TV remote's joystick axes will automatically
		 * match the rotation of the remote.
		 *
		 * The variable can be set to the following values:
		 *
		 *  * "0"    - remote orientation does not affect joystick axes
		 *  * "1"    - joystick axes are based on the orientation of the remote
		 *
		 * By default remote orientation does not affect joystick axes.
		 *
		*/
		[Version (since = "2.0.5")]
		[CCode (cname = "SDL_HINT_APPLE_TV_REMOTE_ALLOW_ROTATION")]
		public const string APPLE_TV_REMOTE_ALLOW_ROTATION;


		/**
		 * A variable controlling speed/quality tradeoff of audio resampling.
		 *
		 * If available, SDL can use [[http://www.mega-nerd.com/SRC/|libsamplerate]]
		 * to handle audio resampling. There are different resampling modes available
		 * that produce different levels of quality, using more CPU.
		 *
		 * If this hint isn't specified to a valid setting, or libsamplerate isn't
		 * available, SDL will use the default, internal resampling algorithm.
		 *
		 * Note that this is currently only applicable to resampling audio that is
		 * being written to a device for playback or audio being read from a device
		 * for capture. SDL_AudioCVT always uses the default resampler (although this
		 * might change for SDL 2.1).
		 *
		 * This hint is currently only checked at audio subsystem initialization.
		 *
		 * This variable can be set to the following values:
		 *
		 *  * "0" or "default" - Use SDL's internal resampling (Default when not set - low quality, fast)
		 *  * "1" or "fast"    - Use fast, slightly higher quality resampling, if available
		 *  * "2" or "medium"  - Use medium quality resampling, if available
		 *  * "3" or "best"    - Use high quality resampling, if available
		 */
		[Version (since = "2.0.6")]
		[CCode (cname = "SDL_HINT_AUDIO_RESAMPLING_MODE")]
		public const string AUDIO_RESAMPLING_MODE;


		/**
		 * A variable controlling the scaling policy for SDL_RenderSetLogicalSize.
		 *
		 * This variable can be set to the following values:
		 *
		 *  * "0" or "letterbox" - Uses letterbox/sidebars to fit the entire rendering on screen
		 *  * "1" or "overscan"  - Will zoom the rendering so it fills the entire screen, allowing edges to be drawn offscreen
		 *
		 * By default letterbox is used
		 */
		[Version (since = "2.0.6")]
		[CCode (cname = "SDL_HINT_RENDER_LOGICAL_SIZE_MODE")]
		public const string RENDER_LOGICAL_SIZE_MODE;

		/**
		 *  A variable setting the speed scale for mouse motion, in floating point, when the mouse is not in relative mode
		 */
		[Version (since = "2.0.6")]
		[CCode (cname = "SDL_HINT_MOUSE_NORMAL_SPEED_SCALE")]
		public const string MOUSE_NORMAL_SPEED_SCALE;


		/**
		 *  A variable setting the scale for mouse motion, in floating point, when the mouse is in relative mode
		 */
		[Version (since = "2.0.6")]
		[CCode (cname ="SDL_HINT_MOUSE_RELATIVE_SPEED_SCALE" )]
		public const string MOUSE_RELATIVE_SPEED_SCALE;

		/**
		 * A variable controlling whether touch events should generate synthetic mouse events
		 *
		 * This variable can be set to the following values:
		 *
		 *  * "0"       - Touch events will not generate mouse events
		 *  * "1"       - Touch events will generate mouse events
		 *
		 *  By default SDL will generate mouse events for touch events
		 */
		[Version (since = "2.0.6")]
		[CCode (cname = "SDL_HINT_TOUCH_MOUSE_EVENTS")]
		public const string TOUCH_MOUSE_EVENTS;

		/**
		 * A variable to specify custom icon resource id from RC file on Windows platform
		 */
		[Version (since = "2.0.6")]
		[CCode (cname = "SDL_HINT_WINDOWS_INTRESOURCE_ICON")]
		public const string WINDOWS_INTRESOURCE_ICON;

		/**
		 * A variable to specify custom icon resource id from RC file on Windows platform (small size)
		 */
		[Version (since = "2.0.6")]
		[CCode (cname = "SDL_HINT_WINDOWS_INTRESOURCE_ICON_SMALL")]
		public const string WINDOWS_INTRESOURCE_ICON_SMALL;

		/**
		 * A variable controlling whether the home indicator bar on iPhone X should be hidden.
		 *
		 * This variable can be set to the following values:
		 *
		 *  * "0"       - The indicator bar is not hidden (default for windowed applications)
		 *  * "1"       - The indicator bar is hidden and is shown when the screen is touched (useful for movie playback applications)
		 *  * "2"       - The indicator bar is dim and the first swipe makes it visible and the second swipe performs the "home" action (default for fullscreen applications)
		 */
		[Version (since = "2.0.8")]
		[CCode (cname = "SDL_HINT_IOS_HIDE_HOME_INDICATOR")]
		public const string IOS_HIDE_HOME_INDICATOR;

		/**
		 *  A variable setting the double click time, in milliseconds.
		 */
		[Version (since = "2.0.9")]
		[CCode (cname = "SDL_HINT_MOUSE_DOUBLE_CLICK_TIME")]
		public const string MOUSE_DOUBLE_CLICK_TIME;

		/**
		 *  A variable setting the double click radius, in pixels.
		 */
		[Version (since = "2.0.9")]
		[CCode (cname = "SDL_MOUSE_DOUBLE_CLICK_RADIUS")]
		public const string MOUSE_DOUBLE_CLICK_RADIUS;

		/**
		 * A variable controlling whether the HIDAPI joystick drivers should be used.
		 *
		 * This variable can be set to the following values:
		 *
		 *  * "0"       - HIDAPI drivers are not used
		 *  * "1"       - HIDAPI drivers are used (the default)
		 *
		 * This variable is the default for all drivers, but can be overridden by the hints for specific drivers below.
		 */
		[Version (since = "2.0.9")]
		[CCode (cname = "SDL_HINT_JOYSTICK_HIDAPI")]
		public const string JOYSTICK_HIDAPI;

		/**
		 * A variable controlling whether the HIDAPI driver for PS4 controllers should be used.
		 *
		 * This variable can be set to the following values:
		 *
		 *   * "0"       - HIDAPI driver is not used
		 *   * "1"       - HIDAPI driver is used
		 *
		 * The default is the value of {@link JOYSTICK_HIDAPI}
		 */
		[Version (since = "2.0.9")]
		[CCode (cname = "SDL_HINT_JOYSTICK_HIDAPI_PS4")]
		public const string JOYSTICK_HIDAPI_PS4;

		/**
		 *  A variable controlling whether extended input reports should be used for PS4 controllers when using the HIDAPI driver.
		 *
		 *  This variable can be set to the following values:
		 *
		 *    * "0"       - extended reports are not enabled (the default)
		 *    * "1"       - extended reports
		 *
		 *  Extended input reports allow rumble on Bluetooth PS4 controllers, but
		 *  break DirectInput handling for applications that don't use SDL.
		 *
		 *  Once extended reports are enabled, they can not be disabled without
		 *  power cycling the controller.
		 */
		[Version (since = "2.0.9")]
		[CCode (cname = "SDL_HINT_JOYSTICK_HIDAPI_PS4_RUMBLE")]
		public const string JOYSTICK_HIDAPI_PS4_RUMBLE;

		/**
		 *  A variable controlling whether the HIDAPI driver for Steam Controllers should be used.
		 *
		 *  This variable can be set to the following values:
		 *
		 *    * "0"       - HIDAPI driver is not used
		 *    * "1"       - HIDAPI driver is used
		 *
		 *  The default is the value of {@link JOYSTICK_HIDAPI}
		 */
		[Version (since = "2.0.9")]
		[CCode (cname = "SDL_HINT_JOYSTICK_HIDAPI_STEAM")]
		public const string JOYSTICK_HIDAPI_STEAM;

		/**
		 *  A variable controlling whether the HIDAPI driver for Nintendo Switch controllers should be used.
		 *
		 *  This variable can be set to the following values:
		 *
		 *    * "0"       - HIDAPI driver is not used
		 *    * "1"       - HIDAPI driver is used
		 *
		 *  The default is the value of {@link JOYSTICK_HIDAPI}
		 */
		[Version (since = "2.0.9")]
		[CCode (cname = "SDL_HINT_JOYSTICK_HIDAPI_SWITCH")]
		public const string JOYSTICK_HIDAPI_SWITCH;

		/**
		 *  A variable controlling whether the HIDAPI driver for XBox controllers should be used.
		 *
		 *  This variable can be set to the following values:
		 *
		 *    * "0"       - HIDAPI driver is not used
		 *    * "1"       - HIDAPI driver is used
		 *
		 *  The default is the value of {@link JOYSTICK_HIDAPI}
		 */
		[Version (since = "2.0.9")]
		[CCode (cname = "SDL_HINT_JOYSTICK_HIDAPI_XBOX")]
		public const string JOYSTICK_HIDAPI_XBOX;

		/**
		 *  A variable that controls whether Steam Controllers should be exposed using the SDL joystick and game controller APIs
		 *
		 *  The variable can be set to the following values:
		 *
		 *    * "0"       - Do not scan for Steam Controllers
		 *    * "1"       - Scan for Steam Controllers (the default)
		 *
		 *  The default value is "1".  This hint must be set before initializing the joystick subsystem.
		 */
		[Version (since = "2.0.9")]
		[CCode (cname = "SDL_HINT_ENABLE_STEAM_CONTROLLERS")]
		public const string ENABLE_STEAM_CONTROLLERS;

		/**
		 * A variable to control whether we trap the Android back button to handle it manually.
		 * This is necessary for the right mouse button to work on some Android devices, or
		 * to be able to trap the back button for use in your code reliably.  If set to true,
		 * the back button will show up as an SDL_KEYDOWN / SDL_KEYUP pair with a keycode of
		 * SDL_SCANCODE_AC_BACK.
		 *
		 * The variable can be set to the following values:
		 *
		 *    * "0"       - Back button will be handled as usual for system. (default)
		 *    * "1"       - Back button will be trapped, allowing you to handle the key press
		 *               manually.  (This will also let right mouse click work on systems
		 *               where the right mouse button functions as back.)
		 *
		 * The value of this hint is used at runtime, so it can be changed at any time.
		 */
		[Version (since = "2.0.9")]
		[CCode (cname = "SDL_HINT_ANDROID_TRAP_BACK_BUTTON")]
		public const string ANDROID_TRAP_BACK_BUTTON;

		/**
		 *  A variable controlling whether the HIDAPI driver for Nintendo GameCube controllers should be used.
		 *
		 *  This variable can be set to the following values:
		 *
		 *    * "0"       - HIDAPI driver is not used
		 *    * "1"       - HIDAPI driver is used
		 *
		 *  The default is the value of SDL_HINT_JOYSTICK_HIDAPI
		 */
		[Version (since = "2.0.10")]
		[CCode (cname = "SDL_HINT_JOYSTICK_HIDAPI_GAMECUBE")]
		public const string JOYSTICK_HIDAPI_GAMECUBE;

		/**
		 *  A variable that lets you provide a file with extra gamecontroller db entries.
		 *
		 *  The file should contain lines of gamecontroller config data, see {@link SDL.GameController}
		 *
		 *  This hint must be set before calling {@link SDL.init}
		 *  You can update mappings after the system is initialized with SDL_GameControllerMappingForGUID() and SDL_GameControllerAddMapping()
		 */
		[Version (since = "2.0.10")]
		[CCode (cname = "SDL_HINT_GAMECONTROLLERCONFIG_FILE")]
		public const string SDL_HINT_GAMECONTROLLERCONFIG_FILE;

		/**
		 * A variable to control whether the event loop will block itself when the app is paused.
		 *
		 * The variable can be set to the following values:
		 *
		 *  * "0"       - Non blocking.
		 *  * "1"       - Blocking. (default)
		 *
		 * The value should be set before SDL is initialized.
		 */
		[Version (since = "2.0.10")]
		[CCode (cname = "SDL_HINT_ANDROID_BLOCK_ON_PAUSE")]
		public const string SDL_HINT_ANDROID_BLOCK_ON_PAUSE;


		/**
		 *  A variable controlling whether the 2D render API is compatible or efficient.
		 *
		 *  This variable can be set to the following values:
		 *
		 *   * "0"     - Don't use batching to make rendering more efficient.
		 *   * "1"     - Use batching, but might cause problems if app makes its own direct OpenGL calls.
		 *
		 *  Up to SDL 2.0.9, the render API would draw immediately when requested. Now
		 *  it batches up draw requests and sends them all to the GPU only when forced
		 *  to (during SDL_RenderPresent, when changing render targets, by updating a
		 *  texture that the batch needs, etc). This is significantly more efficient,
		 *  but it can cause problems for apps that expect to render on top of the
		 *  render API's output. As such, SDL will disable batching if a specific
		 *  render backend is requested (since this might indicate that the app is
		 *  planning to use the underlying graphics API directly). This hint can
		 *  be used to explicitly request batching in this instance. It is a contract
		 *  that you will either never use the underlying graphics API directly, or
		 *  if you do, you will call SDL_RenderFlush() before you do so any current
		 *  batch goes to the GPU before your work begins. Not following this contract
		 *  will result in undefined behavior.
		 */
		[Version (since = "2.0.10")]
		[CCode (cname = "SDL_HINT_RENDER_BATCHING")]
		public const string RENDER_BATCHING;

		/**
		 *  A variable controlling whether SDL logs all events pushed onto its internal queue.
		 *
		 *  This variable can be set to the following values:
		 *
		 *   * "0"     - Don't log any events (default)
		 *   * "1"     - Log all events except mouse and finger motion, which are pretty spammy.
		 *   * "2"     - Log all events.
		 *
		 *  This is generally meant to be used to debug SDL itself, but can be useful
		 *  for application developers that need better visibility into what is going
		 *  on in the event queue. Logged events are sent through {@link SDL.log()}, which
		 *  means by default they appear on stdout on most platforms or maybe
		 *  OutputDebugString() on Windows, and can be funneled by the app with
		 *  SDL_LogSetOutputFunction(), etc.
		 *
		 *  This hint can be toggled on and off at runtime, if you only need to log
		 *  events for a small subset of program execution.
		 */
		[Version (since = "2.0.10")]
		[CCode (cname = "SDL_HINT_EVENT_LOGGING")]
		public const string EVENT_LOGGING;

		/**
		 *  Controls how the size of the RIFF chunk affects the loading of a WAVE file.
		 *
		 *  The size of the RIFF chunk (which includes all the sub-chunks of the WAVE
		 *  file) is not always reliable. In case the size is wrong, it's possible to
		 *  just ignore it and step through the chunks until a fixed limit is reached.
		 *
		 *  Note that files that have trailing data unrelated to the WAVE file or
		 *  corrupt files may slow down the loading process without a reliable boundary.
		 *  By default, SDL stops after 10000 chunks to prevent wasting time. Use the
		 *  environment variable SDL_WAVE_CHUNK_LIMIT to adjust this value.
		 *
		 *  This variable can be set to the following values:
		 *
		 *   * "force"        - Always use the RIFF chunk size as a boundary for the chunk search
		 *   * "ignorezero"   - Like "force", but a zero size searches up to 4 GiB (default)
		 *   * "ignore"       - Ignore the RIFF chunk size and always search up to 4 GiB
		 *   * "maximum"      - Search for chunks until the end of file (not recommended)
		 */
		[Version (since = "2.0.10")]
		[CCode (cname = "SDL_HINT_WAVE_RIFF_CHUNK_SIZE")]
		public const string WAVE_RIFF_CHUNK_SIZE;

		/**
		 *  Controls how a truncated WAVE file is handled.
		 *
		 *  A WAVE file is considered truncated if any of the chunks are incomplete or
		 *  the data chunk size is not a multiple of the block size. By default, SDL
		 *  decodes until the first incomplete block, as most applications seem to do.
		 *
		 *  This variable can be set to the following values:
		 *
		 *   * "verystrict" - Raise an error if the file is truncated
		 *   * "strict"     - Like "verystrict", but the size of the RIFF chunk is ignored
		 *   * "dropframe"  - Decode until the first incomplete sample frame
		 *   * "dropblock"  - Decode until the first incomplete block (default)
		 */
		[Version (since = "2.0.10")]
		[CCode (cname = "SDL_HINT_WAVE_TRUNCATION")]
		public const string WAVE_TRUNCATION;

		/**
		 *  Controls how the fact chunk affects the loading of a WAVE file.
		 *
		 *  The fact chunk stores information about the number of samples of a WAVE
		 *  file. The Standards Update from Microsoft notes that this value can be used
		 *  to 'determine the length of the data in seconds'. This is especially useful
		 *  for compressed formats (for which this is a mandatory chunk) if they produce
		 *  multiple sample frames per block and truncating the block is not allowed.
		 *  The fact chunk can exactly specify how many sample frames there should be
		 *  in this case.
		 *
		 *  Unfortunately, most application seem to ignore the fact chunk and so SDL
		 *  ignores it by default as well.
		 *
		 *  This variable can be set to the following values:
		 *
		 *   * "truncate"    - Use the number of samples to truncate the wave data if
		 *                    the fact chunk is present and valid
		 *   * "strict"      - Like "truncate", but raise an error if the fact chunk
		 *                    is invalid, not present for non-PCM formats, or if the
		 *                    data chunk doesn't have that many samples
		 *   * "ignorezero"  - Like "truncate", but ignore fact chunk if the number of
		 *                    samples is zero
		 *   * "ignore"      - Ignore fact chunk entirely (default)
		 */
		[Version (since = "2.0.10")]
		[CCode (cname = "SDL_HINT_WAVE_FACT_CHUNK")]
		public const string WAVE_FACT_CHUNK;


		/**
		 * A callback used to watch hints.
		 *
		 * @param name What was passed as name to {@link Hint.add_callback}.
		 * @param old_value The old value.
		 * @param new_value The new value.
		 */
		[CCode (cname = "SDL_HintCallback", has_target = true)]
		public delegate void HintFunc (string name, string old_value, string? new_value);

		/**
		 * An enumeration of hint priorities
		 */
		[CCode (cname = "SDL_HintPriority", cprefix = "SDL_HINT_", has_type_id = false)]
		public enum Priority {
			/**
			 * Low priority, used for default values.
			 */
			DEFAULT,

			/**
			 * Medium priority.
			 */
			NORMAL,

			/**
			 * High priority.
			 */
			OVERRIDE;
		}
		/**
		 * Use this function to add a function to watch a particular hint.
		 *
		 * @param name The hint to watch.
		 * @param callback The delegate of {@link Hint.HintFunc} type to call when the hint value changes.
		 *
		 * @since 2.0.0
		 */
		[Version (since = "2.0.0")]
		[CCode (cname = "SDL_AddHintCallback", cheader_filename = "SDL2/SDL_hints.h")]
		public static void add_callback (string name, HintFunc callback);



		/**
		 * Use this function to remove a function watching a particular hint.
		 *
		 * @param name The hint being watched.
		 * @param callback The delegate of {@link Hint.HintFunc} type being called when the hint value changes.
		 */
		[Version (since = "2.0.0")]
		[CCode (cname = "SDL_DelHintCallback", cheader_filename = "SDL2/SDL_hints.h")]
		public static void del_callback (string name, HintFunc callback);

		/**
		 * Use this function to set a hint with normal priority.
		 *
		 * Hints will not be set if there is an existing override hint or environment
		 * variable that takes precedence. You can use {@link set_hint_with_priority}
		 * to set the hint with override priority instead.
		 *
		 * @param name The hint to set. Use one of the string constants from the {@link Hint} class.
		 * @param hint_value The value of the hint variable.
		 *
		 * @return true if the hint was set. false otherwise.
		 */
		[CCode (cname = "SDL_SetHint", cheader_filename = "SDL2/SDL_hints.h")]
		public static bool set_hint (string name, string hint_value);

		/**
		 * Use this function to get the value of a hint.
		 *
		 * @param name The hint to query. Use the constants from the {@link Hint} class.
		 *
		 * @return Returns the string value of a hint or null if the hint isn't set.
		 */
		[CCode (cname = "SDL_GetHint", cheader_filename = "SDL2/SDL_hints.h")]
		public static unowned string get_hint (string name);

		/**
		 * Use this function on boolean hints to see if they are enabled.
		 */
		[Version (since = "2.0.5")]
		[CCode (cname = "SDL_GetHintBoolean", cheader_filename = "SDL2/SDL_hints.h")]
		public static bool is_hint_enabled (string name, bool default_value);

		/**
		 * Use this function to set a boolean hint with normal priority.
		 *
		 * Hints will not be set if there is an existing override hint or environment
		 * variable that takes precedence. You can use {@link set_hint_with_priority}
		 * to set the hint with override priority instead. This is just a helper function
		 * that calls {@link set_hint} internally.
		 *
		 * @param name The hint to set. Use one of the string constants from the {@link Hint} class.
		 * @param hint_value The value of the hint variable.
		 *
		 * @return true if the hint was set. false otherwise.
		 */
		public static bool set_hint_enabled (string name, bool hint_value) {
			return set_hint(name, hint_value ? "1" : "0");
		}

		/**
		 * Use this function to clear all hints.
		 *
		 * This function is automatically called during {@link SDL.quit}.
		 */
		[CCode (cname = "SDL_ClearHints", cheader_filename = "SDL2/SDL_hints.h")]
		public static void clear_all ();

		/**
		 * Use this function to set a hint with a specific priority.
		 *
		 * @param name The hint to set. Use the constants from the {@link Hint} class.
		 * @param hint_value The value of the hint variable.
		 * @param priority The {@link Hint.Priority} level for the hint.
		 *
		 * @return true if the hint was set. false otherwise.
		 */
		[CCode (cname = "SDL_SetHintWithPriority", cheader_filename = "SDL2/SDL_hints.h")]
		public static bool set_hint_with_priority (string name, string hint_value, Hint.Priority priority);

	}//Hints


	///
	/// Power
	///
	[CCode (cname = "SDL_PowerState", cheader_filename = "SDL2/SDL_power.h", cprefix = "SDL_POWERSTATE_")]
	public enum PowerState {
		ON_BATTERY, NO_BATTERY, CHARGING,
		CHARGED, UNKNOWN
	}
	[CCode (cname = "SDL_GetPowerInfo", cheader_filename = "SDL2/SDL_power.h")]
	public static PowerState get_power_info (out int seconds_left, out int percentage_left);
	//Power

	///
	/// Error
	///
	[CCode (cname = "SDL_errorcode", cprefix = "SDL_")]
	public enum ErrorCode {
			ENOMEM, EFREAD, EFWRITE, EFSEEK,
			UNSUPPORTED, LASTERROR
	}

	[CCode (cname = "SDL_SetError")]
	[PrintfFunction]
	public static int set_error (string format, ...);

	[CCode (cname = "SDL_GetError")]
	public static unowned string get_error ();

	[CCode (cname = "SDL_ClearError")]
	public static void clear_error ();

	[CCode (cname = "SDL_Error")]
	public static void emit_error (ErrorCode code);
	// Error

	///
	/// RWops
	///

	[Flags, CCode (cname = "int", cprefix = "RW_SEEK_", cheader_filename = "SDL2/SDL_rwops.h")]
	public enum RWFlags {
		SET, CUR, END
	}// RWFlags

	[CCode (cname = "SDL_RWops", free_function = "SDL_FreeRW", cheader_filename = "SDL2/SDL_rwops.h")]
	[Compact]
	public class RWops {

		public uint32 type;

		[CCode (cname = "SDL_RWread")]
		public size_t read (void* ptr, size_t size, size_t maxnum);

		[Version (since = "2.0.0")]
		[CCode (cname = "SDL_ReadU8")]
		public uint8 read_u8 ();

		[CCode (cname = "SDL_ReadBE16")]
		public uint16 read_be16 ();

		[CCode (cname = "SDL_ReadLE16")]
		public uint16 read_le16 ();

		[CCode (cname = "SDL_ReadBE32")]
		public uint32 read_be32 ();

		[CCode (cname = "SDL_ReadLE32")]
		public uint32 read_le32 ();

		[CCode (cname = "SDL_ReadBE64")]
		public uint64 read_be64 ();

		[CCode (cname = "SDL_ReadLE64")]
		public uint64 read_le64 ();

		[CCode (cname = "SDL_RWwrite")]
		public size_t write (void* ptr, size_t size, size_t num);

		[Version (since = "2.0.0")]
		[CCode (cname = "SDL_WriteU8")]
		public size_t write_u8 (uint8 val);

		[CCode (cname = "SDL_WriteBE16")]
		public size_t write_be16 (uint16 val);

		[CCode (cname = "SDL_WriteLE16")]
		public size_t write_le16 (uint16 val);

		[CCode (cname = "SDL_WriteBE32")]
		public size_t write_be32 (uint32 val);

		[CCode (cname = "SDL_WriteLE32")]
		public size_t write_le32 (uint32 val);

		[CCode (cname = "SDL_WriteBE64")]
		public size_t write_be64 (uint64 val);

		[CCode (cname = "SDL_WriteLE64")]
		public size_t write_le64 (uint64 val);

		[CCode (cname = "SDL_RWseek")]
		public int64 seek (int64 offset, SDL.RWFlags flag);

		[CCode (cname = "SDL_RWtell")]
		public int64 tell ();

		[CCode (cname = "SDL_RWclose")]
		[DestroysInstance]
		public int64 close ();

		[CCode (cname = "SDL_RWFromFile")]
		public RWops.from_file (string file, string mode);

		[CCode (cname = "SDL_RWFromMem")]
		public RWops.from_mem (void* mem, int size);

		[Version (since = "2.0.0")]
		public int64 size{
			[CCode (cname = "SDL_RWsize")] get;
		}
	}// RWops

	///
	/// Events
	///
	[CCode (cname = "SDL_EventType", cprefix = "SDL_", cheader_filename = "SDL2/SDL_events.h")]
	public enum EventType {
		// TODO: Review if updated
		FIRSTEVENT, QUIT, APP_TERMINATING,
		APP_LOWMEMORY, APP_WILLENTERBACKGROUND, APP_DIDENTERBACKGROUND,
		APP_WILLENTERFOREGROUND, APP_DIDENTERFOREGROUND, WINDOWEVENT,
		SYSWMEVENT, KEYDOWN, KEYUP, TEXTEDITING,
		TEXTINPUT, [Version (since = "2.0.4")] KEYMAPCHANGED, MOUSEMOTION,
		MOUSEBUTTONDOWN, MOUSEBUTTONUP, MOUSEWHEEL, JOYAXISMOTION,
		JOYBALLMOTION, JOYHATMOTION, JOYBUTTONDOWN, JOYBUTTONUP, JOYDEVICEADDED,
		JOYDEVICEREMOVED, CONTROLLERAXISMOTION, CONTROLLERBUTTONDOWN,
		CONTROLLERBUTTONUP, CONTROLLERDEVICEADDED,
		CONTROLLERDEVICEREMOVED, CONTROLLERDEVICEREMAPPED, FINGERDOWN,
		FINGERUP, FINGERMOTION, DOLLARGESTURE,
		DOLLARRECORD, MULTIGESTURE, CLIPBOARDUPDATE, DROPFILE,
		[Version (since = "2.0.5")] DROPTEXT,
		[Version (since = "2.0.5")] DROPBEGIN,
		[Version (since = "2.0.4")] DROPCOMPLETE,
		[Version (since = "2.0.4")] AUDIODEVICEADDED,
		[Version (since = "2.0.4")] AUDIODEVICEREMOVED,
		[Version (since = "2.0.2")] RENDER_TARGETS_RESET,
		[Version (since = "2.0.4")] RENDER_DEVICE_RESET, USEREVENT, LASTEVENT;
	}// EventType

	[CCode (cname = "SDL_WindowEventID", cprefix = "SDL_WINDOWEVENT_", cheader_filename = "SDL2/SDL_events.h")]
	public enum WindowEventType {
		NONE, SHOWN, HIDDEN, EXPOSED, MOVED, RESIZED, SIZE_CHANGED, MINIMIZED, MAXIMIZED, RESTORED,
		ENTER, LEAVE, FOCUS_GAINED, FOCUS_LOST, CLOSE, [Version (since = "2.0.5")] TAKE_FOCUS, [Version (since = "2.0.5")] HIT_TEST;
	}

	[CCode (cname = "SDL_CommonEvent", has_type_id = false, cheader_filename = "SDL2/SDL_events.h")]
	[Compact]
	public struct CommonEvent {
		public SDL.EventType type;
		public uint32 timestamp;
	}// CommonEvent

	[CCode (cname = "SDL_WindowEvent", has_type_id = false, cheader_filename = "SDL2/SDL_events.h")]
	[Compact]
	public struct WindowEvent : CommonEvent {
		[CCode (cname = "windowID")]
		public uint32 window_id;
		public WindowEventType event;
		public int32 data1;
		public int32 data2;
	}// WindowEvent

	[Version (since = "2.0.4")]
	[CCode (cname = "SDL_AudioDeviceEvent", has_type_id = false, cheader_filename = "SDL2/SDL_events.h")]
	[Compact]
	public struct AudioDeviceEvent : CommonEvent {
		public uint32 which;
		public bool iscapture;
	}

	[CCode (cname = "SDL_KeyboardEvent", has_type_id = false, cheader_filename = "SDL2/SDL_events.h")]
	[Compact]
	public struct KeyboardEvent : CommonEvent {
		[CCode (cname = "windowID")]
		public uint32 window_id;
		public uint8 state;
		public uint8 repeat;
		public Input.Key keysym;
	}// KeyboardEvent

	[CCode (cname = "SDL_TextEditingEvent", has_type_id = false, cheader_filename = "SDL2/SDL_events.h")]
	[Compact]
	public struct TextEditingEvent : CommonEvent {
		[CCode (cname = "SDL_TEXTEDITINGEVENT_TEXT_SIZE")]
		public const uint8 TEXT_SIZE;

		[CCode (cname = "windowID")]
		public uint32 window_id;
		public string? text;
		public int32 start;
		public int32 length;
	}// TextEditingEvent

	[CCode (cname = "SDL_TextInputEvent", has_type_id = false, cheader_filename = "SDL2/SDL_events.h")]
	[Compact]
	public struct TextInputEvent : CommonEvent {
		[CCode (cname = "SDL_TEXTINPUTEVENT_TEXT_SIZE")]
		public const uint8 TEXT_SIZE;

		[CCode (cname = "windowID")]
		public uint32 window_id;
		public string? text;
	}// TextInputEvent

	[CCode (cname = "SDL_MouseMotionEvent", has_type_id = false, cheader_filename = "SDL2/SDL_events.h")]
	[Compact]
	public struct MouseMotionEvent : CommonEvent {
		[CCode (cname = "windowID")]
		public uint32 window_id;
		public uint32 which;
		public uint8 state;
		public int32 x;
		public int32 y;
		public int32 xrel;
		public int32 yrel;
	}// MouseMotionEvent

	[CCode (cname = "SDL_MouseButtonEvent", has_type_id = false, cheader_filename = "SDL2/SDL_events.h")]
	[Compact]
	public struct MouseButtonEvent : CommonEvent {
		[CCode (cname = "windowID")]
		public uint32 window_id;
		public uint32 which;
		public uint8 button;
		public uint8 state;
		[Version (since = "2.0.2")]
		public uint8 clicks;
		public int32 x;
		public int32 y;
	}// MouseButtonEvent

	[CCode (cname = "Uint32", cprefix = "SDL_MOUSEWHEEL_", has_type_id = false, cheader_filename = "SDL2/SDL_events.h")]
	public enum MouseWheelDirection {
		NORMAL,
		FLIPPED
	}

	[CCode (cname = "SDL_MouseWheelEvent", has_type_id = false, cheader_filename = "SDL2/SDL_events.h")]
	[Compact]
	public struct MouseWheelEvent : CommonEvent {
		[CCode (cname = "windowID")]
		public uint32 window_id;
		public uint32 which;
		public int32 x;
		public int32 y;
		[Version (since = "2.0.4")]
		public MouseWheelDirection direction;

	}// MouseWheelEvent

	[CCode (cname = "SDL_JoyAxisEvent", has_type_id = false, cheader_filename = "SDL2/SDL_events.h")]
	[Compact]
	public struct JoyAxisEvent : CommonEvent {
		[CCode (cname = "windowID")]
		public uint32 window_id;
		public Input.JoystickID which;
		public uint8 axis;
		public int16 @value;
	}// JoyAxisEvent

	[CCode (cname = "SDL_JoyBallEvent", has_type_id = false, cheader_filename = "SDL2/SDL_events.h")]
	[Compact]
	public struct JoyBallEvent : CommonEvent {
		[CCode (cname = "windowID")]
		public uint32 window_id;
		public Input.JoystickID which;
		public uint8 ball;
		public int16 xrel;
		public int16 yrel;
	}// JoyBallEvent

	[CCode (cname = "Uint8", cprefix = "SDL_HAT_", cheader_filename = "SDL2/SDL_events.h")]
	public enum HatValue {
		LEFTU, UP, RIGHTUP,
		LEFT, CENTERED, RIGHT,
		LEFTDOWN, DOWN, RIGHTDOWN
	}

	[CCode (cname = "SDL_JoyHatEvent", has_type_id = false, cheader_filename = "SDL2/SDL_events.h")]
	[Compact]
	public struct JoyHatEvent : CommonEvent {
		[CCode (cname = "windowID")]
		public uint32 window_id;
		public Input.JoystickID which;
		public uint8 hat;
		public HatValue hat_value;
	}// JoyHatEvent

	[CCode (cname = "SDL_JoyButtonEvent", has_type_id = false, cheader_filename = "SDL2/SDL_events.h")]
	[Compact]
	public struct JoyButtonEvent : CommonEvent {
		[CCode (cname = "windowID")]
		public uint32 window_id;
		public Input.JoystickID which;
		public uint8 button;
		public uint8 state;
	}// JoyButtonEvent

	[CCode (cname = "SDL_JoyDeviceEvent", has_type_id = false, cheader_filename = "SDL2/SDL_events.h")]
	[Compact]
	public struct JoyDeviceEvent : CommonEvent {
		[CCode (cname = "windowID")]
		public uint32 window_id;
		public Input.JoystickID which;
	}// JoyDeviceEvent

	[CCode (cname = "SDL_ControllerAxisEvent", has_type_id = false, cheader_filename = "SDL2/SDL_events.h")]
	[Compact]
	public struct ControllerAxisEvent : CommonEvent {
		[CCode (cname = "windowID")]
		public uint32 window_id;
		public Input.JoystickID which;
		public uint8 axis;
		public int16 @value;

	}// ControllerAxisEvent

	[CCode (cname = "SDL_ControllerButtonEvent", has_type_id = false, cheader_filename = "SDL2/SDL_events.h")]
	[Compact]
	public struct ControllerButtonEvent : CommonEvent {
		[CCode (cname = "windowID")]
		public uint32 window_id;
		public Input.JoystickID which;
		public uint8 button;
		public uint8 state;
	}// ControllerButtonEvent

	[CCode (cname = "SDL_ControllerDeviceEvent", has_type_id = false, cheader_filename = "SDL2/SDL_events.h")]
	[Compact]
	public struct ControllerDeviceEvent : CommonEvent {
		[CCode (cname = "windowID")]
		public uint32 window_id;
		public Input.JoystickID which;
	}// ControllerDeviceEvent

	[CCode (cname = "SDL_TouchFingerEvent", has_type_id = false, cheader_filename = "SDL2/SDL_events.h")]
	[Compact]
	public struct TouchFingerEvent : CommonEvent {
		[CCode (cname = "touchID")]
		public Input.Touch.TouchID touch_id;
		[CCode (cname = "fingerID")]
		public Input.Touch.FingerID finger_id;
		public float x;
		public float y;
		public float dx;
		public float dy;
		public float pressure;
	}// TouchFingerEvent

	[CCode (cname = "SDL_MultiGestureEvent", has_type_id = false, cheader_filename = "SDL2/SDL_events.h")]
	[Compact]
	public struct MultiGestureEvent : CommonEvent {
		[CCode (cname = "touchID")]
		public Input.Touch.TouchID touch_id;
		[CCode (cname = "dTheta")]
		public float d_theta;
		[CCode (cname = "dDist")]
		public float d_dist;
		public float x;
		public float y;
		public float pressure;
		[CCode (cname = "numFingers")]
		public uint16 num_fingers;
	}// MultiGestureEvent

	[CCode (cname = "SDL_DollarGestureEvent", has_type_id = false, cheader_filename = "SDL2/SDL_events.h")]
	[Compact]
	public struct DollarGestureEvent : CommonEvent {
		[CCode (cname = "touchID")]
		public Input.Touch.TouchID touch_id;
		[CCode (cname = "gestureID")]
		public Input.Touch.GestureID gesture_id;
		[CCode (cname = "numFingers")]
		public uint32 num_fingers;
		public float error;
		public float x;
		public float y;
	}// DollarGestureEvent

	[CCode (cname = "SDL_DropEvent", has_type_id = false, cheader_filename = "SDL2/SDL_events.h")]
	[Compact]
	public struct DropEvent : CommonEvent {
		public string file;
	}// DropEvent

	[CCode (cname = "SDL_UserEvent", has_type_id = false, cheader_filename = "SDL2/SDL_events.h")]
	[Compact]
	public struct UserEvent : CommonEvent {
		[CCode (cname = "windowID")]
		public uint32 window_id;
		public int32 code;
		public void* data1;
		public void* data2;
	}// UserEvent

	[CCode (cname = "SDL_QuitEvent", has_type_id = false, cheader_filename = "SDL2/SDL_events.h")]
	[Compact]
	public struct QuitEvent : CommonEvent {}// QuitEvent


	[CCode (cname = "SDL_OSEvent", has_type_id = false, cheader_filename = "SDL2/SDL_events.h")]
	[Compact]
	public struct OSEvent : CommonEvent {}// OSEvent

	[CCode (cname = "SDL_SysWMEvent", type_id = "SDL_SysWMEvent", cheader_filename = "SDL2/SDL_events.h")]
	public struct SysWMEvent {
		public Video.SysWMmsg msg;
	}// SysWMEvent

	[CCode (has_target = true, instance_pos = 0)]
	public delegate int EventFilter (ref SDL.Event ev);

	[CCode (cname = "SDL_Event", has_type_id = false, has_target = false, destroy_function = "", cheader_filename = "SDL2/SDL_events.h")]
	[SimpleType]
	public struct Event {
		public SDL.EventType type;
		public SDL.CommonEvent generic;
		public SDL.WindowEvent window;
		public SDL.KeyboardEvent key;
		public SDL.TextEditingEvent edit;
		public SDL.TextInputEvent text;
		public SDL.MouseMotionEvent motion;
		public SDL.MouseButtonEvent button;
		public SDL.MouseWheelEvent wheel;
		public SDL.JoyAxisEvent jaxis;
		public SDL.JoyBallEvent jball;
		public SDL.JoyHatEvent jhat;
		public SDL.JoyButtonEvent jbutton;
		public SDL.JoyDeviceEvent jdevice;
		public SDL.ControllerAxisEvent caxis;
		public SDL.ControllerButtonEvent cbutton;
		public SDL.ControllerDeviceEvent cdevice;
		[Version (since = "2.0.4")]
		public SDL.AudioDeviceEvent adevice;
		public SDL.QuitEvent quit;
		public SDL.UserEvent user;
		public SDL.SysWMEvent syswm;
		public SDL.TouchFingerEvent tfinger;
		public SDL.MultiGestureEvent mgesture;
		public SDL.DollarGestureEvent dgesture;
		public SDL.DropEvent drop;

		[CCode (cname = "SDL_PumpEvents")]
		public static void pump ();

		[CCode (cname = "SDL_PeepEvents")]
		public static void peep (SDL.Event[] events, EventAction action,
			uint32 min_type, uint32 max_type);

		[CCode (cname = "SDL_HasEvent")]
		public static bool has_event (SDL.EventType type);

		[CCode (cname = "SDL_HasEvents")]
		public static bool has_events (uint32 min_type, uint32 max_type);

		[CCode (cname = "SDL_FlushEvent")]
		public static void flush_event (SDL.EventType type);

		[CCode (cname = "SDL_FlushEvents")]
		public static void flush_events (uint32 min_type, uint32 max_type);

		[CCode (cname = "SDL_PollEvent")]
		public static int poll (out SDL.Event ev);

		[CCode (cname = "SDL_WaitEvent")]
		public static int wait (out SDL.Event ev);

		[CCode (cname = "SDL_WaitEventTimeout")]
		public static int wait_inms (out SDL.Event ev, int timeout);

		[CCode (cname = "SDL_PushEvent")]
		public static int push (SDL.Event ev);

		[CCode (cname = "SDL_SetEventFilter")]
		public static void set_eventfilter (SDL.EventFilter filter);

		[CCode (cname = "SDL_GetEventFilter")]
		public static bool get_eventfilter (out SDL.EventFilter filter);

		[CCode (cname = "SDL_AddEventWatch")]
		public static void add_eventwatch (SDL.EventFilter filter);

		[CCode (cname = "SDL_DelEventWatch")]
		public static void del_eventwatch (SDL.EventFilter filter);

		[CCode (cname = "SDL_FilterEvents")]
		public static void filter_events (SDL.EventFilter filter);

		[CCode (cname = "SDL_EventState")]
		public static uint8 state (SDL.EventType type, SDL.EventState state);

		[CCode (cname = "SDL_RegisterEvents")]
		public static uint32 register_events (int numevents);

		[CCode (cname = "SDL_QuitRequested")]
		public static bool quit_requested ();


	}// Event

	[CCode (cname = "int", cprefix = "SDL_", cheader_filename = "SDL2/SDL_events.h")]
	public enum EventState {
		QUERY, IGNORE, DISABLE, ENABLE
	}// EventState

	[CCode (cname = "SDL_eventaction", cprefix = "SDL_", cheader_filename = "SDL2/SDL_events.h")]
	public enum EventAction {
		ADDEVENT, PEEKEVENT, GETEVENT
	}// EventAction



	///
	/// Video
	///
	[CCode (cheader_filename = "SDL2/SDL_video.h")]
	namespace Video {
		[CCode (cprefix = "SDL_ALPHA_", cheader_filename = "SDL2/SDL_pixels.h")]
		public enum Alpha {
			OPAQUE,
			TRANSPARENT
		}// Alpha

		[CCode (cprefix = "SDL_PIXELTYPE_", cheader_filename = "SDL2/SDL_pixels.h")]
		public enum PixelType {
			UNKNOWN,
			INDEX1, INDEX4, INDEX8, PACKED8, PACKED16, PACKED32,
			ARRAYU8, ARRAYU16, ARRAYU32, ARRAYF16, ARRAYF32
		}// PixelType

		[CCode (cprefix = "SDL_BITMAPORDER", cheader_filename = "SDL2/SDL_pixels.h")]
		public enum BitmapOrder {
			[CCode (cname = "SDL_BITMAPORDER_NONE")]
			NONE,
			_4321, _1234
		}// BitmapOrder

		[CCode (cprefix = "SDL_PACKEDORDER_", cheader_filename = "SDL2/SDL_pixels.h")]
		public enum PackedOrder {
			NONE, XRGB, RGBX, ARGB, RGBA,
			XBGR, BGRX, ABGR, BGRA
		}// PackedOrder

		[CCode (cprefix = "SDL_ARRAYORDER_", cheader_filename = "SDL2/SDL_pixels.h")]
		public enum ArrayOrder {
			NONE, RGB, RGBA,
			ARGB, BGR, BGRA, ABGR
		}// ArrayOrder

		[CCode (cprefix = "SDL_PACKEDLAYOUT", cheader_filename = "SDL2/SDL_pixels.h")]
		public enum PackedLayout {
			[CCode (cname = "SDL_PACKEDLAYOUT_NONE")]
			NONE,
			_332, _4444, _1555, _5551,
			_565, _8888, _2101010, _1010102
		}// PackedLayout


		[CCode (cname = "Uint32", cprefix = "SDL_PIXELFORMAT_", has_type_id = false, cheader_filename = "SDL2/SDL_pixels.h")]
		public enum PixelRAWFormat {
			UNKNOWN, INDEX1LSB, INDEX1MSB, INDEX4LSB, INDEX4MSB,
			INDEX8, RGB332, RGB444, RGB555, ARGB4444, RGBA4444,
			ABGR4444, BGRA4444, ARGB1555, RGBA5551, ABGR1555,
			BGRA5551, RGB565, BGR565, RGB24, BGR24, RGB888,
			RGBX8888, BGR888, BGRX8888, ARGB8888, RGBA8888,
			ABGR8888, BGRA8888, ARGB2101010, YV12, IYUV, YUY2,
			UYVY, YVYU;

			[CCode (cname = "SDL_DEFINE_PIXELFOURCC")]
			public PixelRAWFormat define_from_four_cc (char a, char b, char c, char d);

			[CCode (cname = "SDL_DEFINE_PIXELFORMAT")]
			public PixelRAWFormat define (Video.PixelType type, Video.BitmapOrder order, Video.PackedLayout layout, uchar bits, uchar bytes);

			[CCode (cname = "SDL_PIXELFLAG")]
			public uchar get_pixel_flag ();

			[CCode (cname = "SDL_PIXELTYPE")]
			public Video.PixelType get_pixel_type ();

			[CCode (cname = "SDL_PIXELORDER")]
			public Video.BitmapOrder get_pixel_order ();

			[CCode (cname = "SDL_PIXELLAYOUT")]
			public Video.PackedLayout get_pixel_layout ();

			[CCode (cname = "SDL_BITSPERPIXEL")]
			public uchar bits_per_pixel ();

			[CCode (cname = "SDL_BYTESPERPIXEL")]
			public uchar bytes_per_pixel ();

			[CCode (cname = "SDL_ISPIXELFORMAT_INDEXED")]
			public bool is_indexed ();

			[CCode (cname = "SDL_ISPIXELFORMAT_ALPHA")]
			public bool is_alpha ();

		}// PixelFormat

		[CCode (cname = "SDL_BlendMode", cprefix = "SDL_BLENDMODE_")]
		public enum BlendMode {
			NONE, BLEND, ADD, MOD
		}// BlendMode

		[CCode (cname = "SDL_Point", cheader_filename = "SDL2/SDL_rect.h")]
		[SimpleType]
		public struct Point {
			public int x;
			public int y;
		}// Point

		[CCode (cname = "SDL_BlitMap")]
		[SimpleType]
		public struct BlitMap {
			// Private type, content should not be added
		}// BlitMap

		[CCode (cname = "SDL_Color", cheader_filename = "SDL2/SDL_pixels.h")]
		[SimpleType]
		public struct Color {
			public uint8 r;
			public uint8 g;
			public uint8 b;
			public uint8 a;
		} // Color

		[CCode (cheader_filename = "SDL2/SDL_rect.h", cname = "SDL_Rect", has_type_id = false)]
		public struct Rect {
			public int x;
			public int y;
			public uint w;
			public uint h;

			public bool is_empty () {
				return (this.w<=0 || this.h<=0);
			}

			[CCode (cname = "SDL_RectEquals")]
			public bool is_equal (Video.Rect other_rect);

			[Version (since = "2.0.4")]
			[CCode (cname = "SDL_PointInRect", instance_pos = 1)]
			public bool contains_point (Video.Point p);
			[CCode (cname = "SDL_HasIntersection")]
			public bool is_intersecting (Video.Rect other_rect);

			[CCode (cname = "SDL_IntersectRect")]
			public bool intersection_rect (Video.Rect other_rect, out Video.Rect result);

			[CCode (cname = "SDL_UnionRect")]
			public void union_rect (Video.Rect other_rect, out Video.Rect result);

			[CCode (cname = "SDL_EnclosePoints")]
			public bool enclose_points (int count, Video.Rect clip, out Video.Rect result);

			[CCode (cname = "SDL_IntersectRectAndLine")]
			public bool intersects_withline (out int x1, out int y1, out int x2, out int y2);
		}// Rect



		[CCode (type_id = "SDL_Palette", cname = "SDL_Palette", cheader_filename = "SDL2/SDL_pixels.h", cprefix = "SDL_", free_function = "SDL_FreePalette", ref_function = "SDL_Palette_up", unref_function = "SDL_FreePalette")]
		public class Palette {
			[CCode (array_length_cexpr = "ncolors", array_length_type = "int")]
			public Video.Color[] colors;
			public uint32 version;
			public int refcount;
			public unowned Palette up () {
				GLib.AtomicInt.inc (ref this.refcount);
				return this;
			}

			[CCode (cname = "SDL_AllocPalette")]
			public Palette (int colors_num);

			[CCode (cname = "SDL_SetPaletteColors", array_length_pos = 2.1)]
			public int set_colors (Video.Color[] colors, int first_color);
		}

		[CCode (type_id = "SDL_PixelFormat", cname = "SDL_PixelFormat", cheader_filename = "SDL2/SDL_pixels.h", cprefix = "SDL_", free_function = "SDL_FreeFormat", ref_function = "SDL_PixelFormat_up", unref_function = "SDL_FreeFormat")]
		public class PixelFormat {
			public Video.PixelRAWFormat format;
			public Video.Palette palette;
			[CCode (cname = "BitsPerPixel")]
			public uint8 bits_per_pixel;
			[CCode (cname = "BytesPerPixel")]
			public uint8 bytes_per_pixel;
			//public uint8 padding[2]; Is this even useful? We are binding a Struct, not recreating one
			[CCode (cname = "Rmask")]
			public uint32 r_mask;
			[CCode (cname = "Gmask")]
			public uint32 g_mask;
			[CCode (cname = "Bmask")]
			public uint32 b_mask;
			[CCode (cname = "Amask")]
			public uint32 a_mask;
			public uint8 r_loss;
			public uint8 g_loss;
			public uint8 b_loss;
			public uint8 a_loss;
			public uint8 r_shift;
			public uint8 g_shift;
			public uint8 b_shift;
			public uint8 a_shift;

			public int refcount;
			public Video.PixelFormat next;

			public unowned PixelFormat up () {
				GLib.AtomicInt.inc (ref this.refcount);
				return this;
			}

			[CCode (cname = "SDL_AllocFormat")]
			public PixelFormat (uint32 pixel_format);

			[CCode (cname = "SDL_SetPixelFormatPalette")]
			public int set_palette (Video.Palette palette);

			[CCode (cname = "SDL_MapRGB")]
			public uint32 map_rgb (uint8 r, uint8 g, uint8 b);

			[CCode (cname = "SDL_MapRGBA")]
			public uint32 map_rgba (uint8 r, uint8 g, uint8 b, uint8 a);

			[CCode (cname = "SDL_GetRGB", instance_pos = 1.2)]
			public void get_rgb (uint32 pixel, ref uint8 r, ref uint8 g, ref uint8 b);

			[CCode (cname = "SDL_GetRGBA", instance_pos = 1.2)]
			public void get_rgba (uint32 pixel, ref uint8 r, ref uint8 g, ref uint8 b, ref uint8 a);

			[CCode (cname = "SDL_CalculateGammaRamp")]
			public static void calc_gamma_ramp (float gamma, out uint16 ramp);

			[CCode (cname = "SDL_GetPixelFormatName")]
			public static unowned string? get_pixelformatname (Video.PixelRAWFormat format);

			[CCode (cname = "SDL_PixelFormatEnumToMasks")]
			public static bool enum_tomasks (Video.PixelRAWFormat format,
				out int bpp, out uint32 r_mask, out uint32 g_mask, out uint32 b_mask, out uint32 a_mask);

			[CCode (cname = "SDL_MasksToPixelFormatEnum")]
			public static uint32 masks_toenum (
				int bpp, uint32 r_mask, uint32 g_mask, uint32 b_mask, uint32 a_mask);
		}// PixelFormat

		[CCode (cname = "SDL_blit", cheader_filename = "SDL2/SDL_surface.h")]
		public delegate int BlitFunc (Video.Surface src, Video.Rect? srcrect,
		 Video.Surface dst, Video.Rect? dstrect);

		[CCode (type_id = "SDL_Surface", cname = "SDL_Surface", ref_function = "SDL_Surface_up", unref_function = "SDL_FreeSurface", cheader_filename = "SDL2/SDL_surface.h")]
		[Compact]
		public class Surface {
			public uint32 flags;
			public Video.PixelFormat format;
			public int w;
			public int h;
			public int pitch;
			public void* pixels;
			public void* userdata; //maybe this could be binded as Simple Generics?
			public int locked;
			public void* lock_data;
			public Video.Rect clip_rect;
			public Video.BlitMap map;
			public int refcount;

			public unowned Surface up () {
				GLib.AtomicInt.inc (ref this.refcount);
				return this;
			}

			[CCode (cname = "SDL_CreateRGBSurface")]
			public Surface.legacy_rgb (uint32 flags, int width, int height, int depth,
						uint32 rmask, uint32 gmask, uint32 bmask, uint32 amask);

			public Surface.rgb (int width, int height, int depth,
						uint32 rmask, uint32 gmask, uint32 bmask, uint32 amask) {
				this.legacy_rgb (0, width, height, depth, rmask, gmask, bmask, amask);
			}

			[CCode (cname = "SDL_CreateRGBSurfaceFrom")]
			public Surface.from_rgb (void* pixels, int width, int height, int depth,
				int pitch, uint32 rmask, uint32 gmask, uint32 bmask, uint32 amask);

			[CCode (cname = "SDL_CreateRGBSurfaceWithFormat")]
			public Surface.legacy_rgb_with_format (uint32 flags, int width, int height, int depth, PixelRAWFormat format);

			public Surface.rgb_with_format (int width, int height, int depth, PixelRAWFormat format) {
				this.legacy_rgb_with_format (0, width, height, depth, format);
			}

			[CCode (cname = "SDL_CreateRGBSurfaceWithFormatFrom")]
			public Surface.from_rgb_with_format (void* pixels, int width, int height, int depth,
				int pitch, PixelRAWFormat format);

			[CCode (cname = "SDL_LoadBMP_RW")]
			public Surface.from_bmp_rw (SDL.RWops src, int freesrc = 0);

			[CCode (cname = "SDL_LoadBMP")]
			public Surface.from_bmp (string file);

			[CCode (cname = "SDL_SetSurfacePalette")]
			public int set_palette (Video.Palette palette);

			[CCode (cname = "SDL_MUSTLOCK")]
			public bool must_lock ();

			[CCode (cname = "SDL_LockSurface")]
			public int do_lock ();

			[CCode (cname = "SDL_UnlockSurface")]
			public void unlock ();

			[CCode (cname = "SDL_SaveBMP_RW")]
			public int save_bmp_rw (RWops dst, int freedst = 0);

			public int save_bmp (string file) {
				return save_bmp_rw (new SDL.RWops.from_file (file, "wb"), 1);
			}

			[CCode (cname = "SDL_SetSurfaceRLE")]
			public int set_rle (int flag);

			[CCode (cname = "SDL_SetColorKey")]
			public int set_colorkey (int flag, uint32 key);

			[CCode (cname = "SDL_GetColorKey")]
			public int get_colorkey (out uint32 key);

			[CCode (cname = "SDL_SetSurfaceColorMod")]
			public int set_colormod (uint8 r, uint8 g, uint8 b);

			[CCode (cname = "SDL_GetSurfaceColorMod")]
			public int get_colormod (out uint8 r, out int8 g, out uint8 b);

			[CCode (cname = "SDL_SetSurfaceAlphaMod")]
			public int set_alphamod (uint8 alpha);

			[CCode (cname = "SDL_GetSurfaceAlphaMod")]
			public int get_alphamod (out uint8 alpha);

			[CCode (cname = "SDL_SetSurfaceBlendMode")]
			public int set_blend_mode (Video.BlendMode blend_mode);

			[CCode (cname = "SDL_GetSurfaceBlendMode")]
			public int get_blend_mode (out Video.BlendMode blend_mode);

			[CCode (cname = "SDL_SetClipRect")]
			public bool set_cliprect (Video.Rect? rect);

			[CCode (cname = "SDL_GetClipRect")]
			public int get_cliprect (out Video.Rect rect);

			[CCode (cname = "SDL_ConvertSurface")]
			public Surface? convert (Video.PixelFormat? fmt, uint32 flags);

			[CCode (cname = "SDL_ConvertSurfaceFormat")]
			public Surface? convert_format (uint32 pixel_fmt, uint32 flags);

			[CCode (cname = "SDL_ConvertPixels")]
			public static int convert_pixels (int width, int height, Video.PixelRAWFormat src_format, void* src, int src_pitch, Video.PixelRAWFormat dst_format, void* dst, int dst_pitch);

			[CCode (cname = "SDL_FillRect")]
			public int fill_rect (Video.Rect? rect, uint32 color);

			[CCode (cname = "SDL_FillRects")]
			public int fill_rects (Video.Rect[] rects, uint32 color);

			[CCode (cname = "SDL_BlitSurface")]
			public int blit (Video.Rect? srcrect, Video.Surface dst, Video.Rect? dstrect);

			[CCode (cname = "SDL_LowerBlit")]
			public int lowerblit (Video.Rect? srcrect, Video.Surface dst, Video.Rect? dstrect);

			[CCode (cname = "SDL_BlitScaled")]
			public int blit_scaled (Video.Rect? srcrect, Video.Surface dst, Video.Rect? dstrect);

			[CCode (cname = "SDL_LowerBlitScaled")]
			public int lowerblit_scaled (Video.Rect? srcrect, Video.Surface dst, Video.Rect? dstrect);

			[CCode (cname = "SDL_SoftStretch")]
			public int softstretch (Video.Rect? srcrect, Video.Surface dst, Video.Rect? dstrect);
		} //Surface

		///
		/// Render
		///
		[CCode (cname = "SDL_RendererFlags", cprefix = "SDL_RENDERER_", cheader_filename = "SDL2/SDL_render.h")]
		public enum RendererFlags {
			SOFTWARE, ACCELERATED,
			PRESENTVSYNC, TARGETTEXTURE
		}// RendererFlags

		[CCode (cprefix = "SDL_", cname = "SDL_RendererInfo", cheader_filename = "SDL2/SDL_render.h")]
		[Compact]
		public class RendererInfo {

			public const string name;
			public uint32 flags;

			[CCode (cname = "num_texture_formats")]
			public uint32 num_texture_formats;

			[CCode (cname = "texture_formats")]
			public Video.PixelFormat texture_formats[16];

			[CCode (cname = "max_texture_width")]
			public int max_texture_width;

			[CCode (cname = "texture_formats")]
			public int max_texture_height;
		}// RendererInfo

		[Flags, CCode (cname = "SDL_TextureAccess", cprefix = "SDL_TEXTUREACCESS_", cheader_filename = "SDL2/SDL_render.h")]
		public enum TextureAccess {
			STATIC, STREAMING, TARGET
		}// TextureAccess

		[Flags, CCode (cname = "SDL_TextureModulate", cprefix = "SDL_TEXTUREMODULATE_", cheader_filename = "SDL2/SDL_render.h")]
		public enum TextureModulate {
			NONE, COLOR, ALPHA
		}// TextureModulate

		[Flags, CCode (cname = "SDL_RendererFlip", cprefix = "SDL_FLIP_", cheader_filename = "SDL2/SDL_render.h")]
		public enum RendererFlip {
			NONE, HORIZONTAL, VERTICAL
		}// RendererFlip

		[CCode (cprefix = "SDL_", cname = "SDL_Renderer", free_function = "SDL_DestroyRenderer", cheader_filename = "SDL2/SDL_render.h")]
		[Compact]
		public class Renderer {
			[CCode (cname = "SDL_GetNumRenderDrivers")]
			public static int num_drivers ();

			[CCode (cname = "SDL_GetRenderDriverInfo")]
			public static int get_driver_info (int index, Video.RendererInfo info);

			[CCode (cname = "SDL_CreateWindowAndRenderer")]
			public static int create_with_window (int width, int height, uint32 window_flags, out Video.Window window, out Video.Renderer renderer);

			[CCode (cname = "SDL_CreateRenderer")]
			public static Renderer? create (Video.Window window, int index, uint32 flags);

			[CCode (cname = "SDL_CreateSoftwareRenderer")]
			public static Renderer? create_from_surface (Video.Surface surface);

			[CCode (cname = "SDL_GetRendererInfo")]
			public int get_info (out Video.RendererInfo info);

			[Version (since = "2.0.0")]
			[CCode (cname = "SDL_RenderTargetSupported")]
			public bool is_supported ();

			[Version (since = "2.0.0")]
			public Video.Texture? render_target{
				[CCode (cname = "SDL_GetRenderTarget")]get;
				[CCode (cname = "SDL_SetRenderTarget")]set;
			}

			[Version (since = "2.0.4")]
			[CCode (cname = "SDL_RenderIsClipEnabled")]
			public bool is_clip_enabled ();

			[Version (since = "2.0.0")]
			[CCode (cname = "SDL_RenderSetLogicalSize")]
			public int set_logical_size (int w, int h);

			[Version (since = "2.0.0")]
			[CCode (cname = "SDL_RenderGetLogicalSize")]
			public void get_logical_size (out int w, out int h);

			[CCode (cname = "SDL_RenderSetViewport")]
			public int set_viewport (Video.Rect? rect);

			[CCode (cname = "SDL_RenderGetViewport")]
			public void get_viewport (out Video.Rect rect);

			[Version (since = "2.0.0")]
			[CCode (cname = "SDL_RenderSetScale")]
			public int set_scale (float scale_x, float scale_y);

			[Version (since = "2.0.0")]
			[CCode (cname = "SDL_RenderGetScale")]
			public void get_scale (out float scale_x, out float scale_y);

			[Version (since = "2.0.5")]
			[CCode (cname = "SDL_RenderSetIntegerScale")]
			public int set_int_scale (bool enable);

			[Version (since = "2.0.5")]
			[CCode (cname = "SDL_RenderGetIntegerScale")]
			public bool get_int_scale ();

			[CCode (cname = "SDL_SetRenderDrawColor")]
			public int set_draw_color (uint8 r, uint8 g, uint8 b, uint8 a);

			[CCode (cname = "SDL_GetRenderDrawColor")]
			public int get_draw_color (out uint8 r, out uint8 g, out uint8 b, out uint8 a);

			[CCode (cname = "SDL_SetRenderDrawBlendMode")]
			public int set_draw_blend_mode (Video.BlendMode blend_mode);

			[CCode (cname = "SDL_GetRenderDrawBlendMode")]
			public int get_draw_blend_mode (out Video.BlendMode blend_mode);

			[CCode (cname = "SDL_RenderClear")]
			public int clear ();

			[CCode (cname = "SDL_RenderDrawPoint")]
			public int draw_point (int x, int y);

			[CCode (cname = "SDL_RenderDrawPoints")]
			public int draw_points (Video.Point[] points);

			[CCode (cname = "SDL_RenderDrawLine")]
			public int draw_line (int x1, int y1, int x2, int y2);

			[CCode (cname = "SDL_RenderDrawLines")]
			public int draw_lines (Video.Point[] points);

			[CCode (cname = "SDL_RenderDrawRect")]
			public int draw_rect (Video.Rect? rect);

			[CCode (cname = "SDL_RenderDrawLines")]
			public int draw_rects (Video.Rect[] points, int count);

			[CCode (cname = "SDL_RenderFillRect")]
			public int fill_rect (Video.Rect? rect);

			[CCode (cname = "SDL_RenderFillRects")]
			public int fill_rects (Video.Rect[] points, int count);

			[CCode (cname = "SDL_RenderCopy")]
			public int copy (Video.Texture texture, Video.Rect? srcrect, Video.Rect? dstrect);

			[CCode (cname = "SDL_RenderCopyEx")]
			public int copyex (Video.Texture texture, Video.Rect? srcrect, Video.Rect? dstrect, double angle, Video.Point? center, Video.RendererFlip flip);

			[CCode (cname = "SDL_RenderReadPixels")]
			public int read_pixels (Video.Rect? rect, Video.PixelRAWFormat format, out void* pixels, int pitch);

			[CCode (cname = "SDL_RenderPresent")]
			public void present ();

			[Version (since = "2.0.0")]
			[CCode (cname = "SDL_GetRendererOutputSize")]
			public void get_output_size (out int w, out int h);
		}// Renderer

		[CCode (cprefix = "SDL_", cname = "SDL_Texture", free_function = "SDL_DestroyTexture", cheader_filename = "SDL2/SDL_render.h")]
		[Compact]
		public class Texture {
			[CCode (cname = "SDL_CreateTexture")]
			public static Texture? create (Video.Renderer renderer, Video.PixelRAWFormat format, int access, int w, int h);

			[CCode (cname = "SDL_CreateTextureFromSurface")]
			public static Texture? create_from_surface (Video.Renderer renderer, Video.Surface surface);

			[CCode (cname = "SDL_QueryTexture")]
			public int query (out Video.PixelRAWFormat format, out int access, out int w, out int h);

			[CCode (cname = "SDL_SetTextureColorMod")]
			public int set_color_mod (uint8 r, uint8 g, uint8 b);

			[CCode (cname = "SDL_GetTextureColorMod")]
			public int get_color_mod (out uint8 r, out uint8 g, out uint8 b);

			[CCode (cname = "SDL_SetTextureAlphaMod")]
			public int set_alpha_mod (uint8 alpha);

			[CCode (cname = "SDL_GetTextureColorMod")]
			public int get_alpha_mod (out uint8 alpha);

			[CCode (cname = "SDL_SetTextureBlendMode")]
			public int set_blend_mode (Video.BlendMode blend_mode);

			[CCode (cname = "SDL_GetTextureBlendMode")]
			public int get_blend_mode (out Video.BlendMode blend_mode);

			[CCode (cname = "SDL_UpdateTexture")]
			public int update (Video.Rect? rect, void* pixels, int pitch);

			[Version (since = "2.0.1")]
			[CCode (cname = "SDL_UpdateYUVTexture")]
			public int update_yuv (Video.Rect? rect, uint8[] yplane, int ypitch, uint8[] uplane, int upitch, uint8[] vplane, int vpitch);

			[CCode (cname = "SDL_LockTexture")]
			public int do_lock (Video.Rect? rect, out void* pixels, out int pitch);

			[CCode (cname = "SDL_UnlockTexture")]
			public void unlock ();

			[Version (since = "2.0.0")]
			[CCode (cname = "SDL_GL_BindTexture")]
			public void gl_bind (ref float texw, ref float texh);

			[CCode (cname = "SDL_GL_UnbindTexture")]
			public int gl_unbind ();
		}// Texture


		///
		/// Video
		///

		[CCode (cname = "SDL_DisplayMode", destroy_function = "", cheader_filename = "SDL2/SDL_video.h")]
		public struct DisplayMode {
			public Video.PixelRAWFormat format;
			public int w;
			public int h;
			public int refresh_rate;
			public void* driverdata; //Please, initialize as NULL
		}// DisplayMode

		[Version (since = "2.0.0")]
		[Flags, CCode (cname = "SDL_WindowFlags", cprefix = "SDL_WINDOW_", cheader_filename = "SDL2/SDL_video.h")]
		public enum WindowFlags {
			FULLSCREEN, FULLSCREEN_DESKTOP, OPENGL, SHOWN, HIDDEN, BORDERLESS,
			RESIZABLE, MINIMIZED, MAXIMIZED, INPUT_GRABBED, INPUT_FOCUS, MOUSE_FOCUS,
			FOREIGN, [Version (since = "2.0.1")] ALLOW_HIGHDPI,
			[Version (since = "2.0.4")] MOUSE_CAPTURE
		}// WindowFlags


		[CCode (cname = "SDL_GetNumVideoDrivers")]
		public static int num_drivers ();

		[CCode (cname = "SDL_GetVideoDriver")]
		public static unowned string? get_driver (int driver_index);

		[CCode (cname = "SDL_VideoInit")]
		public static int init (string driver_name);

		[CCode (cname = "SDL_VideoQuit")]
		public static void quit ();

		[Version (since = "2.0.0")]
		[CCode (cname = "SDL_GetCurrentVideoDriver")]
		public static unowned string? get_current_driver ();

		[Version (since = "2.0.0")]
		[CCode (cname = "SDL_GetNumVideoDisplays")]
		public static int num_displays ();

		[Version (since = "2.0.0")]
		[CCode (cname = "SDL_IsScreenSaverEnabled")]
		public static bool is_screensaver_enabled ();

		[Version (since = "2.0.0")]
		[CCode (cname = "SDL_EnableScreenSaver")]
		public static void enable_screensaver ();

		[Version (since = "2.0.0")]
		[CCode (cname = "SDL_DisableScreenSaver")]
		public static void disable_screensaver ();


		[CCode (cname = "int", has_type_id = false, cheader_filename = "SDL2/SDL_video.h")]
		[SimpleType]
		[IntegerType (rank = 6)]
		public struct Display : int {
			[Version (since = "2.0.0")]
			[CCode (cname = "SDL_GetDisplayName")]
			public unowned string? get_name ();

			[CCode (cname = "SDL_GetDisplayBounds")]
			public int get_bounds (out Video.Rect rect);

			[Version (since = "2.0.0")]
			[CCode (cname = "SDL_GetNumDisplayModes")]
			public int num_modes ();

			[CCode (cname = "SDL_GetDisplayMode")]
			public int get_mode (int mode_index, out Video.DisplayMode mode);

			[Version (since = "2.0.4")]
			[CCode (cname = "SDL_GetDisplayDPI")]
			public int get_dpi (out float ddpi, out float hdpi, out float vdpi);

			[CCode (cname = "SDL_GetDesktopDisplayMode")]
			public int get_desktop_mode (out Video.DisplayMode mode);

			[CCode (cname = "SDL_GetCurrentDisplayMode")]
			public int get_current_mode (out Video.DisplayMode mode);

			[CCode (cname = "SDL_GetClosestDisplayMode")]
			public Video.DisplayMode? get_closest_mode (Video.DisplayMode mode, out Video.DisplayMode closest);

			[Version (since = "2.0.5")]
			[CCode (cname = "SDL_GetDisplayUsableBounds")]
			public int get_usable_bounds (out Video.Rect? rect);
		}// Display

		[CCode (cname = " SDL_SYSWM_TYPE", cprefix = "SDL_SYSWM_", cheader_filename = "SDL2/SDL_syswm.h")]
		public enum SysWMType {
			UNKNOWN, WINDOWS, X11, DIRECTFB, COCOA, UIKIT,
			[Version (since = "2.0.2")] WAYLAND,
			[Version (since = "2.0.2")]MIR,
			[Version (since = "2.0.3")]WINRT,
			[Version (since = "2.0.4")]ANDROID
		}
		[CCode (cname = "SDL_SysWMmsg", cheader_filename = "SDL2/SDL_syswm.h")]
		public struct SysWMmsg {
			public SDL.Version version;
			public SysWMType subsystem;
			public int dummy;

			//if SDL_SYSWM_WINDOWS
			[CCode (cname = "win.hwnd")]
			public void* win_hwnd;
			[CCode (cname = "win.msg")]
			public uint win_msg;
			[CCode (cname = "win.wParam")]
			public void* win_wparam;
			[CCode (cname = "win.lParam")]
			public void* win_lparam;

			//if SDL_SYSWM_X11
			[CCode (cname = "x11.event")]
			public void* x11_event;

			//if SDL_SYSWM_DIRECTFB
			[CCode (cname = "dfb.event")]
			public void* dfb_event;

			//if SDL_SYSWM_COCOA
			[Version (since = "2.0.4")]
			[CCode (cname = "cocoa.dummy")]
			public int cocoa_dummy;

			//if SDL_SYSWM_UIKIT
			[Version (since = "2.0.4")]
			[CCode (cname = "uikit.dummy")]
			public int uikit_dummy;
		}// SysWMmsg

		/**
		 * Remember to always check the {@link SysWMType} before accessing any field
		*/
		[CCode (cname = "SDL_SysWMinfo", cheader_filename = "SDL2/SDL_syswm.h")]
		public struct SysWMInfo {
			public SDL.Version version;
			public SysWMType subsystem;
			public int dummy;

			//if SDL_SYSWM_WINDOWS

			/*the window handle*/
			[CCode (cname = "win.window")]
			public void* win_window;
			[Version (since = "2.0.4")]
			[CCode (cname = "win.hdc")]
			public void* win_hdc;

			//if SDL_SYSWM_WINRT (>= SDL 2.0.3)

			/*the WinRT CoreWindow*/
			[Version (since = "2.0.3")]
			[CCode (cname = "win.window")]
			public void* winrt_window;

			//if SDL_SYSWM_X11

			/*the X11 display*/
			[CCode (cname = "x11.display")]
			public void* x11_display;

			/*the X11 window*/
			[CCode (cname = "x11.window")]
			public void* x11_window;

			//if SDL_SYSWM_DIRECTFB

			/*the DirectFB main interface*/
			[CCode (cname = "dfb.dfb")]
			public void* dfb_dfb;

			/*the DirectFB window handle*/
			[CCode (cname = "dfb.window")]
			public void* dfb_window;

			/*the DirectFB client surface*/
			[CCode (cname = "dfb.surface")]
			public void* dfb_surface;

			//if SDL_SYSWM_COCOA

			/*the Cocoa window*/
			[CCode (cname = "cocoa.window")]
			public void* cocoa_window;

			//if SDL_SYSWM_UIKIT

			/*the UIKit window*/
			[CCode (cname = "uikit.window")]
			public void* uikit_window;

			/**
			 * the GL view's Framebuffer Object; it must be bound when rendering to the screen using GL (>= SDL 2.0.4)
			 */
			[Version (since = "2.0.4")]
			[CCode (cname = "uikit.framebuffer")]
			public uint uikit_framebuffer;

			/**
			 * the GL view's color Renderbuffer Object; it must be bound when {@link GL.swap_window} is called (>= SDL 2.0.4)
			 */
			[Version (since = "2.0.4")]
			[CCode (cname = "uikit.colorbuffer")]
			public uint uikit_colorbuffer;

			/**
			 * the Framebuffer Object which holds the resolve color Renderbuffer, when MSAA is used (>= SDL 2.0.4)
			 */
			[Version (since = "2.0.4")]
			[CCode (cname = "uikit.resolveFramebuffer")]
			public uint uikit_resolve_framebuffer;

			//if SDL_SYSWM_WAYLAND (>= SDL 2.0.2)

			/*the Wayland display*/
			[Version (since = "2.0.2")]
			[CCode (cname = "wl.display")]
			public void* wl_display;

			/*the Wayland surface*/
			[Version (since = "2.0.2")]
			[CCode (cname = "wl.surface")]
			public void* wl_surface;

			/*the Wayland shell_surface (window manager handle)*/
			[Version (since = "2.0.2")]
			[CCode (cname = "wl.shell_surface")]
			public void* wl_shell_surface;

			//if SDL_SYSWM_MIR (>= SDL 2.0.2)

			/*the Mir display server connection*/
			[Version (since = "2.0.2")]
			[CCode (cname = "mir.connection")]
			public void* mir_connection;

			/*the Mir surface*/
			[Version (since = "2.0.2")]
			[CCode (cname = "mir.surface")]
			public void* mir_surface;

			//if SDL_SYSWM_ANDROID (>= SDL 2.0.4)

			/*the Android native window*/
			[Version (since = "2.0.4")]
			[CCode (cname = "android.window")]
			public void* android_window;

			/*the Android EGL surface*/
			[Version (since = "2.0.4")]
			[CCode (cname = "android.surface")]
			public void* android_surface;
		}// SysWMmsg

		[Version (since = "2.0.4")]
		[CCode (cname = " SDL_HitTestResult", cprefix = "SDL_HITTEST_", cheader_filename = "SDL2/SDL_video.h")]
		public enum HitTestResult {
			NORMAL, DRAGGABLE, RESIZE_TOPLEFT, RESIZE_TOP, RESIZE_TOPRIGHT,
			RESIZE_RIGHT, RESIZE_BOTTOMRIGHT, RESIZE_BOTTOM, RESIZE_BOTTOMLEFT,
			RESIZE_LEFT;
		}

		[CCode (cname = "SDL_HitTest", has_target= true, delegate_target_pos = 1.1)]
		public delegate HitTestResult HitTestFunc (Video.Window window, Video.Point area);


		[CCode (cprefix = "SDL_", cname = "SDL_Window", free_function = "SDL_DestroyWindow", cheader_filename = "SDL2/SDL_video.h")]
		[Compact]
		public class Window {
			[CCode (cname = "SDL_WINDOWPOS_UNDEFINED_MASK")]
			public const uint8 POS_UNDEFINED;

			[CCode (cname = "SDL_WINDOWPOS_CENTERED_MASK")]
			public const uint8 POS_CENTERED;

			[CCode (cname = "SDL_NONSHAPEABLE_WINDOW", cheader_filename = "SDL2/SDL_shape.h")]
			private const int8 SDL_NONSHAPEABLE_WINDOW;
			[CCode (cname = "SDL_INVALID_SHAPE_ARGUMENT", cheader_filename = "SDL2/SDL_shape.h")]
			private const int8 SDL_INVALID_SHAPE_ARGUMENT;
			[CCode (cname = "SDL_WINDOW_LACKS_SHAPE", cheader_filename = "SDL2/SDL_shape.h")]
			private const int8 SDL_WINDOW_LACKS_SHAPE;

			[Version (since = "2.0.4")]
			[CCode (cname = "SDL_GetGrabbedWindow")]
			public static Window? get_grabbed ();

			[Version (since = "2.0.0")]
			[CCode (cname = "SDL_CreateWindow")]
			public Window (string title, int x, int y, int w, int h, uint32 flags);

			/**
			 * Create a window that can be shaped with the specified position, dimensions, and flags.
			 *
			 * @param title The title of the window, in UTF-8 encoding.
			 * @param x     The x position of the window, {@link POS_CENTERED}, or
			 *               {@link POS_UNDEFINED}.
			 * @param y     The y position of the window, {@link POS_CENTERED}, or
			 *               {@link POS_UNDEFINED}.
			 * @param w     The width of the window.
			 * @param h     The height of the window.
			 * @param flags The flags for the window, a mask of {@link WindowFlags.BORDERLESS} with any of the following:<<BR>>
			 *     {@link WindowFlags.OPENGL},  {@link WindowFlags.INPUT_GRABBED},<<BR>>
			 *     {@link WindowFlags.HIDDEN},  {@link WindowFlags.RESIZABLE} <<BR>>
			 *     {@link WindowFlags.MAXIMIZED},  {@link WindowFlags.MINIMIZED} <<BR>><<BR>>
			 * {@link WindowFlags.BORDERLESS} is always set, and {@link WindowFlags.FULLSCREEN} is always unset.
			 *
			 * @return The window created, or null if window creation failed.
			 *
			 * @see destroy
			 */

			[Version (since = "2.0.5")]
			[CCode (cname = "SDL_CreateShapedWindow", cheader_filename = "SDL2/SDL_shape.h")]
			public Window.shaped (string title, int x, int y, int w, int h, uint32 flags);

			// Param data is a "pointer to driver-dependent window creation data"
			[CCode (cname = "SDL_CreateWindowFrom")]
			public Window.from_native (void* data);

			[CCode (cname = "SDL_GetWindowFromID")]
			public Window.from_id (uint32 id);

			[CCode (cname = "SDL_GetWindowDisplayIndex")]
			public int get_display ();

			[CCode (cname = "SDL_SetWindowDisplayMode")]
			public int set_display_mode (Video.DisplayMode mode);

			[CCode (cname = "SDL_GetWindowDisplayMode")]
			public int get_display_mode (out Video.DisplayMode mode);

			[Version (since = "2.0.4")]
			[CCode (cname = "SDL_SetWindowHitTest")]
			public int set_hit_test (HitTestFunc callback);

			[Version (since = "2.0.5")]
			[CCode (cname = "SDL_SetWindowResizable")]
			public void set_resizable (bool resizable);

			[CCode (cname = "SDL_GetWindowPixelFormat")]
			public Video.PixelRAWFormat get_pixelformat ();

			[CCode (cname = "SDL_GetWindowID")]
			public uint32 get_id ();

			[CCode (cname = "SDL_GetWindowFlags")]
			public uint32 get_flags ();

			public string title {
				[CCode (cname = "SDL_GetWindowTitle")]get;
				[CCode (cname = "SDL_SetWindowTitle")]set;
			}

			[CCode (cname = "SDL_SetWindowIcon")]
			public void set_icon (Video.Surface icon);

			[CCode (cname = "SDL_SetWindowData", simple_generics = true)]
			public void set_data<T> (string key, owned T data);

			[CCode (cname = "SDL_GetWindowData", simple_generics = true)]
			public unowned T get_data<T> (string key);

			[CCode (cname = "SDL_SetWindowPosition")]
			public void set_position (int x, int y);

			[CCode (cname = "SDL_GetWindowPosition")]
			public void get_position (out int x, out int y); //TODO: create a beautilful method

			[CCode (cname = "SDL_SetWindowSize")]
			public void set_size (int w, int h);

			[CCode (cname = "SDL_GetWindowSize")]
			public void get_size (out int w, out int h); //TODO: create a beautilful method

			[CCode (cname = "SDL_SetWindowMinimumSize")]
			public void set_minsize (int w, int h);

			[CCode (cname = "SDL_GetWindowMinimumSize")]
			public void get_minsize (out int w, out int h); //TODO: create a beautilful method

			[CCode (cname = "SDL_SetWindowMaximumSize")]
			public void set_maxsize (int w, int h);

			[CCode (cname = "SDL_GetWindowMaximumSize")]
			public void get_maxsize (out int w, out int h); //TODO: create a beautilful method

			[Version (since = "2.0.0")]
			[CCode (cname = "SDL_SetWindowBordered")]
			public void set_bordered (bool bordered);

			[CCode (cname = "SDL_ShowWindow")]
			public void show ();

			[CCode (cname = "SDL_HideWindow")]
			public void hide ();

			[CCode (cname = "SDL_RaiseWindow")]
			public void raise ();

			[CCode (cname = "SDL_MaximizeWindow")]
			public void maximize ();

			[CCode (cname = "SDL_MinimizeWindow")]
			public void minimize ();

			[CCode (cname = "SDL_RestoreWindow")]
			public void restore ();

			[Version (since = "2.0.0")]
			[CCode (cname = "SDL_SetWindowFullscreen")]
			public int set_fullscreen (uint32 flags);

			[CCode (cname = "SDL_GetWindowSurface")]
			public Video.Surface get_surface ();

			[CCode (cname = "SDL_UpdateWindowSurface")]
			public int update_surface ();

			[CCode (cname = "SDL_UpdateWindowSurfaceRects")]
			public int update_surface_rects (Video.Rect[] rects);

			public bool grab {
				[CCode (cname = "SDL_GetWindowGrab")]get;
				[CCode (cname = "SDL_SetWindowGrab")]set;
			}

			[CCode (cname = "SDL_SetWindowBrightness")]
			public int set_brightness (float brightness);

			[CCode (cname = "SDL_GetWindowBrightness")]
			public float get_brightness ();

			[CCode (cname = "SDL_SetWindowGammaRamp")]
			public int set_gammaramp (uint16[]? red, uint16[]? green, uint16[]? blue);

			[CCode (cname = "SDL_GetWindowGammaRamp")]
			public int get_gammaramp (out uint16[]? red, out uint16[]? green, out uint16[]? blue);

			[Version (since = "2.0.0")]
			[CCode (cname = "SDL_GetWindowWMInfo", cheader_filename = "SDL2/SDL_syswm.h")]
			public bool get_wm_info (out Video.SysWMInfo info);

			[Version (since = "2.0.1")]
			[CCode (cname = "SDL_GL_GetDrawableSize")]
			public void get_gl_drawable_size (out int? w, out int? h);

			[Version (since = "2.0.5")]
			[CCode (cname = "SDL_GetWindowBorderSize")]
			public int get_border_size (out int? top, out int? left, out int? bottom, out int? right);

			[Version (since = "2.0.5")]
			[CCode (cname = "SDL_SetWindowOpacity")]
			public int set_opacity (float opacity);

			[Version (since = "2.0.5")]
			[CCode (cname = "SDL_GetWindowOpacity")]
			public int get_opacity (out float? opacity);

			[Version (since = "2.0.5")]
			[CCode (cname = "SDL_SetWindowInputFocus")]
			public int set_input_focus ();

			/**
			 * Use this function to set the window as a modal for another window.
			 *
			 * This only works in X11
			 */
			[Version (since = "2.0.5")]
			[CCode (cname = "SDL_SetWindowModalFor")]
			public int set_modal_for (Video.Window parent);

			[CCode (cname = "SDL_DestroyWindow")]
			[DestroysInstance]
			public void destroy ();

			[Version (since = "2.0.5")]
			[CCode (cname = "SDL_IsShapedWindow", cheader_filename = "SDL2/SDL_shape.h")]
			public bool is_shaped();


			/**
			 * Set the shape and parameters of a shaped window.
			 *
			 * @param shape A {@link Surface} encoding the desired shape for the window.
			 * @param mode The {@link ShapeMode} with the parameters to set for the shaped window.
			 *
			 * @throws ShapeError if there's any error
			 * @see ShapeMode
			 * @see get_shape_mode
			 */
			[Version (since = "2.0.5")]
			[CCode (cname = "vala_set_shape_mode")]
			public void set_window_shape (Surface shape, ShapeMode? mode) throws ShapeError {
				int8 retval = orig_set_window_shape(shape, mode);

				if (retval < 0) {
					switch (retval) {
						case SDL_NONSHAPEABLE_WINDOW:
							throw new ShapeError.NONSHAPEABLE_WINDOW("Window %p is not shaped".printf((void*)this));
						case SDL_INVALID_SHAPE_ARGUMENT:
							throw new ShapeError.INVALID_SHAPE_ARGUMENT("Surface %p and/or mode %p are invalid".printf((void*)shape,(void*)mode));
						case SDL_WINDOW_LACKS_SHAPE:
							throw new ShapeError.WINDOW_LACKS_SHAPE("Window %p lacks shape".printf((void*)this));
						default:
							throw new ShapeError.UNKNOWN("Unknown Error");
					}
				}
			}

			[Version (since = "2.0.5")]
			[CCode (cname = "SDL_SetWindowShape", cheader_filename = "SDL2/SDL_shape.h")]
			private int8 orig_set_window_shape (Surface shape, ShapeMode? shape_mode);

			/**
			 * Get the shape parameters of a shaped window.
			 *
			 * @return The current {@link ShapeMode}
			 *
			 * @throws ShapeError if there's any error
			 * @see ShapeMode
			 * @see set_window_shape
			 */
			[Version (since = "2.0.5")]
			[CCode (cname = "vala_get_shape_mode")]
			public ShapeMode get_shape_mode () throws ShapeError {
				ShapeMode mode;
				int8 retval = orig_get_shaped_mode(out mode);

				if (retval < 0) {
					switch (retval) {
						case SDL_NONSHAPEABLE_WINDOW:
							throw new ShapeError.NONSHAPEABLE_WINDOW("Window %p is not shaped".printf((void*)this));
						case SDL_INVALID_SHAPE_ARGUMENT:
							throw new ShapeError.INVALID_SHAPE_ARGUMENT("Mode %p is invalid".printf((void*)mode));
						case SDL_WINDOW_LACKS_SHAPE:
							throw new ShapeError.WINDOW_LACKS_SHAPE("Window %p lacks shape".printf((void*)this));
						default:
							throw new ShapeError.UNKNOWN("Unknown Error");
					}
				}

				return mode;
			}

			[Version (since = "2.0.5")]
			[CCode (cname = "SDL_GetShapedWindowMode", cheader_filename = "SDL2/SDL_shape.h")]
			private int8 orig_get_shaped_mode (out ShapeMode shape_mode);


			[Version (since = "2.0.5")]
			[CCode (cname = "WindowShapeMode", cheader_filename = "SDL2/SDL_shape.h")]
			public enum ShapeModeType {
				/**
				 * The default mode, a binarized alpha cutoff of 1.
				 */
				[CCode (cname = "ShapeModeDefault")] DEFAULT,
				/**
				 * A binarized alpha cutoff with a given integer value.
				 */
				[CCode (cname = "ShapeModeBinarizeAlpha")] BINARIZE_ALPHA,
				/**
				 * A binarized alpha cutoff with a given integer value, but with the opposite comparison.
				 */
				[CCode (cname = "ShapeModeReverseBinarizeAlpha")] REVERSE_BINARIZE_APHA,
				/**
				 * A color key is applied.
				 */
				[CCode (cname = "ShapeModeColorKey")] COLOR_KEY;

				[CCode (cname = "SDL_SHAPEMODEALPHA")]
				public bool is_alpha();
			}

			[Version (since = "2.0.5")]
			[CCode (cname = "SDL_WindowShapeMode", type_id = "SDL_WindowShapeMode" , cheader_filename = "SDL2/SDL_shape.h")]
			public struct ShapeMode {
				/**
				 * The mode of these window-shape parameters.
				 */
				public ShapeModeType mode;
				/**
				 * a cutoff alpha value for binarization of the window shape's alpha channel.
				 */
				[CCode (cname = "parameters.binarizationCutoff")]
				public uint8 binarization_cutoff;

				[CCode (cname = "parameters.colorKey")]
				public Color color_key;
			}

		}//Window

		public errordomain ShapeError {
			NONSHAPEABLE_WINDOW,
			INVALID_SHAPE_ARGUMENT,
			WINDOW_LACKS_SHAPE,
			UNKNOWN
		}


		///
		/// OpenGL
		///
		[CCode (cprefix = "SDL_GL_", cheader_filename = "SDL2/SDL_video.h")]
		namespace GL {

			[CCode (type_id = "SDL_GLContext", cname = "SDL_GLContext", free_function = "SDL_GL_DeleteContext", cheader_filename = "SDL2/SDL_video.h")]
			[Compact]
			public class Context {
				[CCode (cname = "SDL_GL_CreateContext")]
				public static Context? create (Video.Window window);
			}// GLContext

			[CCode (cname = "SDL_GLattr", cprefix = "SDL_GL_", cheader_filename = "SDL2/SDL_video.h")]
			public enum Attributes {
				RED_SIZE, GREEN_SIZE, BLUE_SIZE, ALPHA_SIZE,
				BUFFER_SIZE, DOUBLEBUFFER, DEPTH_SIZE, STENCIL_SIZE,
				ACCUM_RED_SIZE, ACCUM_GREEN_SIZE, ACCUM_BLUE_SIZE,
				ACCUM_ALPHA_SIZE, STEREO, MULTISAMPLEBUFFERS,
				MULTISAMPLESAMPLES, ACCELERATED_VISUAL,
				[Version (deprecated = true)] RETAINED_BACKING,
				CONTEXT_MAJOR_VERSION, CONTEXT_MINOR_VERSION,
				CONTEXT_FLAGS, CONTEXT_PROFILE_MASK,
				SHARE_WITH_CURRENT_CONTEXT,
				[Version (since = "2.0.1")] FRAMEBUFFER_SRGB_CAPABLE,
				[Version (since = "2.0.4")] CONTEXT_RELEASE_BEHAVIOR,
				[Version (deprecated = true)] CONTEXT_EGL
			}// GLattr

			[CCode (cname = "SDL_GLprofile", cprefix = "SDL_GL_CONTEXT_PROFILE_", cheader_filename = "SDL2/SDL_video.h")]
			public enum ProfileType {
				CORE, COMPATIBILITY, ES;
			}// GLprofile

			[CCode (cname = "SDL_GLcontextFlag", cprefix = "SDL_GL_CONTEXT_", lower_case_csuffix = "flag", cheader_filename = "SDL2/SDL_video.h")]
			public enum ContextFlag {
				DEBUG, FORWARD_COMPATIBLE, ROBUST_ACCESS, RESET_ISOLATION
			}
			[CCode (cname = "SDL_GL_LoadLibrary")]
			public static int load_library (string path);

			[CCode (cname = "SDL_GL_GetProcAddress")]
			public static void* get_proc_address (string proc);

			[CCode (cname = "SDL_GL_UnloadLibrary")]
			public static void unload_library ();

			[Version (since = "2.0.0")]
			[CCode (cname = "SDL_GL_ExtensionSupported")]
			public static bool is_extension_supported (string extension);

			[Version (since = "2.0.2")]
			[CCode (cname = "SDL_GL_ResetAttributes")]
			public static void reset_attributes ();

			[CCode (cname = "SDL_GL_SetAttribute")]
			public static int set_attribute (Video.GL.Attributes attr, int val);

			[CCode (cname = "SDL_GL_GetAttribute")]
			public static int get_attribute (Video.GL.Attributes attr, out int val);

			[CCode (cname = "SDL_GL_MakeCurrent")]
			public static int make_current (Video.Window window, Video.GL.Context context);

			[Version (since = "2.0.0")]
			[CCode (cname = "SDL_GL_SetSwapInterval")]
			public static int set_swapinterval (int interval);

			[Version (since = "2.0.0")]
			[CCode (cname = "SDL_GL_GetSwapInterval")]
			public static int get_swapinterval ();

			[CCode (cname = "SDL_GL_SwapWindow")]
			public static void swap_window (Video.Window window);

			[Version (since = "2.0.0")]
			[CCode (cname = "SDL_GL_GetCurrentContext")]
			public static Video.GL.Context? get_current_context ();

			[Version (since = "2.0.0")]
			[CCode (cname = "SDL_GL_GetCurrentWindow")]
			public static Video.Window? get_current_window ();
		}// GL

		///
		/// MessageBox
		///
		[CCode (cprefix = "SDL_", cheader_filename = "SDL2/SDL_messagebox.h")]
		[Compact]
		public class MessageBox {
			[Flags, CCode (cname = "SDL_MessageBoxFlags", cprefix = "SDL_MESSAGEBOX_", cheader_filename = "SDL2/SDL_messagebox.h")]
			public enum Flags {
				/**
				 * error dialog
				 */
				ERROR,
				/**
				 * warning dialog
				 */
				WARNING,
				/**
				 * informational dialog
				 */
				INFORMATION
			} // MessageBoxFlags;
			[Flags, CCode (cname = "SDL_MessageBoxButtonFlags", cprefix = "SDL_MESSAGEBOX_BUTTON_", cheader_filename = "SDL2/SDL_messagebox.h")]
			public enum ButtonFlags {
				/**
				 * Marks the default button when return is hit
				 */
				RETURNKEY_DEFAULT,
				/**
				 * Marks the default button when escape is hit
				 */
				ESCAPEKEY_DEFAULT
			} //MessageBoxButtonFlags;
			[CCode (cname = "SDL_MessageBoxColorType", cprefix = "SDL_MESSAGEBOX_COLOR_", cheader_filename = "SDL2/SDL_messagebox.h")]
			public enum ColorType {
				BACKGROUND,
				TEXT,
				BUTTON_BORDER,
				BUTTON_BACKGROUND,
				BUTTON_SELECTED,
				MAX
			} //MessageBoxColorType;
			[CCode (cname = "SDL_MessageBoxButtonData", destroy_function = "", cheader_filename = "SDL2/SDL_messagebox.h")]
			public struct ButtonData {

				/**
				 * A field composed of {@link MessageBox.ButtonFlags}
				 */
				public uint32 flags;
				/**
				 * User defined button id (value returned via SDL_ShowMessageBox)
				 */
				public int buttonid;

				public string text;
			} //MessageBoxButtonData;
			[CCode (cname = "SDL_MessageBoxColor", destroy_function = "", cheader_filename = "SDL2/SDL_messagebox.h")]
			public struct Color {
				public uint8 r;
				public uint8 g;
				public uint8 b;
			} // MessageBoxColor;
			[CCode (cname = "SDL_MessageBoxColorScheme", destroy_function = "", cheader_filename = "SDL2/SDL_messagebox.h")]
			public struct ColorScheme {
				public Video.MessageBox.Color colors[SDL.Video.MessageBox.ColorType.MAX];
			} // MessageBoxColorScheme;

			[CCode (cname = "SDL_MessageBoxData", destroy_function = "", cheader_filename = "SDL2/SDL_messagebox.h")]
			public struct Data {

				/**
				 * A field composed of {@link MessageBox.Flags}
				 */
				public uint32 flags;

				[CCode (cname = "window")]
				public Video.Window? parent_window;
				public string title;
				public string message;
				[CCode (array_length_cexpr = "numbuttons", array_length_type = "int")]
				public Video.MessageBox.ButtonData[] buttons;
				/**
				* Can be null to use system settings
				*/
				[CCode (cname = "colorScheme")]
				public Video.MessageBox.ColorScheme? color_scheme;
			} //MessageBoxData;

			[CCode (cname = "SDL_ShowSimpleMessageBox")]
			public static int simple_show (MessageBox.Flags flags, string title, string message, Video.Window? parent = null);

			[Version (since = "2.0.0")]
			[CCode (cname = "SDL_ShowMessageBox")]
			public static int show (MessageBox.Data data, out int buttonid);

		}// MessageBox

	}
	///
	/// Input
	///
	namespace Input {

		[CCode (cheader_filename = "SDL2/SDL_clipboard.h")]
		[Compact]
		public class Clipboard {

			[Version (since = "2.0.0")]
			[CCode (cname = "SDL_GetClipboardText")]
			public static string? get_text ();

			[Version (since = "2.0.0")]
			[CCode (cname = "SDL_SetClipboardText")]
			public static int set_text (string text);

			[Version (since = "2.0.0")]
			[CCode (cname = "SDL_HasClipboardText")]
			public static bool has_text ();
		}


		[CCode (cname = "int", cprefix = "SDL_")]
		public enum ButtonState {
			RELEASED, PRESSED;
		}// ButtonState

		[CCode (cname = "SDL_Keycode", cprefix = "SDLK_", cheader_filename = "SDL2/SDL_keycode.h")]
		public enum Keycode {
			UNKNOWN, RETURN, ESCAPE, BACKSPACE, TAB, SPACE, EXCLAIM,
			QUOTEDBL, HASH, PERCENT, DOLLAR, AMPERSAND, QUOTE,
			LEFTPAREN, RIGHTPAREN, ASTERISK, PLUS, COMMA, MINUS,
			PERIOD, SLASH,
			[CCode (cname = "SDLK_0")]
			ZERO,
			[CCode (cname = "SDLK_1")]
			ONE,
			[CCode (cname = "SDLK_2")]
			TWO,
			[CCode (cname = "SDLK_3")]
			THREE,
			[CCode (cname = "SDLK_4")]
			FOUR,
			[CCode (cname = "SDLK_5")]
			FIVE,
			[CCode (cname = "SDLK_6")]
			SIX,
			[CCode (cname = "SDLK_7")]
			SEVEN,
			[CCode (cname = "SDLK_8")]
			EIGHT,
			[CCode (cname = "SDLK_9")]
			NINE,
			COLON, SEMICOLON,
			LESS, EQUALS, GREATER, QUESTION, AT, LEFTBRACKET, BACKSLASH,
			RIGHTBRACKET, CARET, UNDERSCORE, BACKQUOTE, a, b, c, d, e, f,
			g, h, i, j, k, l, m, n, o, p, q, r, s, t, u, v, w, x, y, z, CAPSLOCK, F1,
			F2, F3, F4, F5, F6, F7, F8, F9, F10, F11, F12, PRINTSCREEN,
			SCROLLLOCK, PAUSE, INSERT, HOME, PAGEUP, DELETE, END,
			PAGEDOWN, RIGHT, LEFT, DOWN, UP, NUMLOCKCLEAR, KP_DIVIDE,
			KP_MULTIPLY, KP_MINUS, KP_PLUS, KP_ENTER, KP_1, KP_2, KP_3,
			KP_4, KP_5, KP_6, KP_7, KP_8, KP_9, KP_0, KP_PERIOD, APPLICATION,
			POWER, KP_EQUALS, F13, F14, F15, F16, F17, F18, F19, F20, F21,
			F22, F23, F24, EXECUTE, HELP, MENU, SELECT, STOP, AGAIN, UNDO,
			CUT, COPY, PASTE, FIND, MUTE, VOLUMEUP, VOLUMEDOWN, KP_COMMA,
			KP_EQUALSAS400, ALTERASE, SYSREQ, CANCEL, CLEAR, PRIOR,
			RETURN2, SEPARATOR, OUT, OPER, CLEARAGAIN, CRSEL, EXSEL,
			KP_00, KP_000, THOUSANDSSEPARATOR, DECIMALSEPARATOR,
			CURRENCYUNIT, CURRENCYSUBUNIT, KP_LEFTPAREN, KP_RIGHTPAREN,
			KP_LEFTBRACE, KP_RIGHTBRACE, KP_TAB, KP_BACKSPACE, KP_A, KP_B,
			KP_C, KP_D, KP_E, KP_F, KP_XOR, KP_POWER, KP_PERCENT, KP_LESS,
			KP_GREATER, KP_AMPERSAND, KP_DBLAMPERSAND, KP_VERTICALBAR,
			KP_DBLVERTICALBAR, KP_COLON, KP_HASH, KP_SPACE, KP_AT,
			KP_EXCLAM, KP_MEMSTORE, KP_MEMRECALL, KP_MEMCLEAR, KP_MEMADD,
			KP_MEMSUBTRACT, KP_MEMMULTIPLY, KP_MEMDIVIDE, KP_PLUSMINUS,
			KP_CLEAR, KP_CLEARENTRY, KP_BINARY, KP_OCTAL, KP_DECIMAL,
			KP_HEXADECIMAL, LCTRL, LSHIFT, LALT, LGUI, RCTRL, RSHIFT, RALT,
			RGUI, MODE, AUDIONEXT, AUDIOPREV, AUDIOSTOP, AUDIOPLAY,
			AUDIOMUTE, MEDIASELECT, WWW, MAIL, CALCULATOR, COMPUTER,
			AC_SEARCH, AC_HOME, AC_BACK, AC_FORWARD, AC_STOP, AC_REFRESH,
			AC_BOOKMARKS, BRIGHTNESSDOWN, BRIGHTNESSUP, DISPLAYSWITCH,
			KBDILLUMTOGGLE, KBDILLUMDOWN, KBDILLUMUP, EJECT, SLEEP;

			[CCode (cname = "SDL_GetKeyName")]
			public unowned string get_name();

			[CCode (cname = "SDL_GetKeyFromName")]
			public static Input.Keycode from_name (string name);

			[CCode (cname = "SDL_GetKeyFromScancode")]
			public static Input.Keycode from_scancode (Input.Scancode scancode);
		}// Keycode

		[Flags, CCode (cname = "SDL_Keymod", cprefix = "KMOD_", cheader_filename = "SDL2/SDL_keycode.h")]
		public enum Keymod {
			NONE, LSHIFT, RSHIFT, LCTRL, RCTRL, LALT, RALT,
			LGUI, RGUI, NUM, CAPS, MODE, RESERVED,
			CTRL, SHIFT, ALT, GUI
		}// Keymod

		[CCode (cname = "SDL_Scancode", cprefix = "SDL_SCANCODE_", cheader_filename = "SDL2/SDL_scancode.h")]
		public enum Scancode {
			UNKNOWN, A, B, C, D, E, F, G, H, I, J, K, L, M, N, O, P, Q, R,
			S, T, U, V, W, X, Y, Z,
			[CCode (cname = "SDL_SCANCODE_1")]
			ONE,
			[CCode (cname = "SDL_SCANCODE_2")]
			TWO,
			[CCode (cname = "SDL_SCANCODE_3")]
			THREE,
			[CCode (cname = "SDL_SCANCODE_4")]
			FOUR,
			[CCode (cname = "SDL_SCANCODE_5")]
			FIVE,
			[CCode (cname = "SDL_SCANCODE_6")]
			SIX,
			[CCode (cname = "SDL_SCANCODE_7")]
			SEVEN,
			[CCode (cname = "SDL_SCANCODE_8")]
			EIGHT,
			[CCode (cname = "SDL_SCANCODE_9")]
			NINE,
			[CCode (cname = "SDL_SCANCODE_0")]
			ZERO,
			RETURN, ESCAPE, BACKSPACE, TAB, SPACE, MINUS, EQUALS,
			LEFTBRACKET, RIGHTBRACKET, BACKSLASH, NONUSHASH,
			SEMICOLON, APOSTROPHE, GRAVE, COMMA, PERIOD, SLASH,
			CAPSLOCK, F1, F2, F3, F4, F5, F6, F7, F8, F9, F10, F11, F12,
			PRINTSCREEN, SCROLLLOCK, PAUSE, INSERT, HOME,
			PAGEUP, DELETE, END, PAGEDOWN, RIGHT, LEFT, DOWN, UP,
			NUMLOCKCLEAR, KP_DIVIDE, KP_MULTIPLY, KP_MINUS, KP_PLUS,
			KP_ENTER, KP_1, KP_2, KP_3, KP_4, KP_5, KP_6, KP_7, KP_8,
			KP_9, KP_0, KP_PERIOD, NONUSBACKSLASH, APPLICATION,
			POWER, KP_EQUALS, F13, F14, F15, F16, F17, F18, F19, F20,
			F21, F22, F23, F24, EXECUTE, HELP, MENU, SELECT, STOP,
			AGAIN, UNDO, CUT, COPY, PASTE, FIND, MUTE, VOLUMEUP,
			VOLUMEDOWN, KP_COMMA, KP_EQUALSAS400,
			INTERNATIONAL1, INTERNATIONAL2, INTERNATIONAL3,
			INTERNATIONAL4, INTERNATIONAL5, INTERNATIONAL6,
			INTERNATIONAL7, INTERNATIONAL8, INTERNATIONAL9, LANG1,
			LANG2, LANG3, LANG4, LANG5, LANG6, LANG7, LANG8,
			LANG9, ALTERASE, SYSREQ, CANCEL, CLEAR, PRIOR, RETURN2,
			SEPARATOR, OUT, OPER, CLEARAGAIN, CRSEL, EXSEL, KP_00,
			KP_000, THOUSANDSSEPARATOR, DECIMALSEPARATOR,
			CURRENCYUNIT, CURRENCYSUBUNIT, KP_LEFTPAREN,
			KP_RIGHTPAREN, KP_LEFTBRACE, KP_RIGHTBRACE, KP_TAB,
			KP_BACKSPACE, KP_A, KP_B, KP_C, KP_D, KP_E, KP_F, KP_XOR,
			KP_POWER, KP_PERCENT, KP_LESS, KP_GREATER, KP_AMPERSAND,
			KP_DBLAMPERSAND, KP_VERTICALBAR, KP_DBLVERTICALBAR,
			KP_COLON, KP_HASH, KP_SPACE, KP_AT, KP_EXCLAM, KP_MEMSTORE,
			KP_MEMRECALL, KP_MEMCLEAR, KP_MEMADD, KP_MEMSUBTRACT,
			KP_MEMMULTIPLY, KP_MEMDIVIDE, KP_PLUSMINUS, KP_CLEAR,
			KP_CLEARENTRY, KP_BINARY, KP_OCTAL, KP_DECIMAL,
			KP_HEXADECIMAL, LCTRL, LSHIFT, LALT, LGUI, RCTRL, RSHIFT, RALT,
			RGUI, MODE, AUDIONEXT, AUDIOPREV, AUDIOSTOP, AUDIOPLAY,
			AUDIOMUTE, MEDIASELECT, WWW, MAIL, CALCULATOR, COMPUTER,
			AC_SEARCH, AC_HOME, AC_BACK, AC_FORWARD, AC_STOP, AC_REFRESH,
			AC_BOOKMARKS, BRIGHTNESSDOWN, BRIGHTNESSUP, DISPLAYSWITCH,
			KBDILLUMTOGGLE, KBDILLUMDOWN, KBDILLUMUP, EJECT, SLEEP, APP1, APP2,


			/**
			 *  Number of possible Scancodes
			 */
			[CCode (cname = "SDL_NUM_SCANCODES")]
			NUM_SCANCODES;

			[CCode (cname = "SDL_GetScancodeName")]
			public unowned string get_name ();

			[CCode (cname = "SDL_GetScancodeFromName")]
			public static Input.Scancode from_name (string name);



			[CCode (cname = "SDL_GetScancodeFromKey")]
			public static Input.Scancode from_keycode (Input.Keycode key);

		}// Scancode

		[CCode (cname = "SDL_Keysym", cheader_filename = "SDL2/SDL_keyboard.h")]
		[SimpleType]
		public struct Key {
			public Input.Scancode scancode;
			public Input.Keycode sym;
			public uint16 mod;
			public uint32 unicode;
		}// Key

		[CCode (cheader_filename = "SDL2/SDL_keyboard.h")]
		public class Keyboard {
			[CCode (cname = "SDL_GetKeyboardFocus")]
			public static Video.Window get_focus ();

			[CCode (cname = "SDL_GetKeyboardState")]
			public static unowned uint8* get_raw_state (out size_t length = null);

			[CCode (cname = "vala_get_keyboard_state")]
			public static unowned bool[] get_state () {
				size_t len;
				uint8* raw = get_raw_state (out len);
				unowned bool[] retval = (bool[])raw;
				retval.length = (int)len;
				return retval;
			}

			[CCode (cname = "SDL_GetModState")]
			public static Input.Keymod get_modifierstate ();

			[CCode (cname = "SDL_SetModState")]
			public static void set_modifierstate (Input.Keymod modstate);


		}// Keyboard

		[CCode (cheader_filename = "SDL2/SDL_keyboard.h")]
		public class TextInput {
			[CCode (cname = "SDL_StartTextInput")]
			public static void start ();

			[Version (since = "2.0.0")]
			[CCode (cname = "SDL_IsTextInputActive")]
			public static bool is_active ();

			[CCode (cname = "SDL_StopTextInput")]
			public static void stop ();

			[CCode (cname = "SDL_SetTextInputRect")]
			public static void set_rect (Video.Rect rect);
		}// TextInput

		[CCode (cheader_filename = "SDL2/SDL_keyboard.h")]
		public class ScreenKeyboard {
			[Version (since = "2.0.0")]
			[CCode (cname = "SDL_HasScreenKeyboardSupport")]
			public static bool has_support ();

			[Version (since = "2.0.0")]
			[CCode (cname = "SDL_IsScreenKeyboardShown")]
			public static bool is_shown (Video.Window window);
		}

		[CCode (cname = "SDL_SystemCursor", cprefix = "SDL_SYSTEM_CURSOR_", cheader_filename = "SDL2/SDL_mouse.h")]
		public enum SystemCursor {
			ARROW, IBEAM, WAIT, CROSSHAIR, WAITARROW, SIZENWSE,
			SIZENESW, SIZEWE, SIZENS, SIZEALL, NO, HAND,
			[CCode (cname = "SDL_NUM_SYSTEM_CURSORS")]
			NUM
		}// SystemCursor

		[CCode (cname = "Uint8", cprefix = "SDL_BUTTON_")]
		public enum MouseButton {
			LEFT, MIDDLE, RIGHT, X1, X2,
			LMASK, MMASK, RMASK,
			X1MASK, X2MASK
		}// Buttons

		[CCode (type_id = "SDL_Cursor", free_function = "SDL_FreeCursor", cheader_filename = "SDL2/SDL_mouse.h")]
		[Compact]
		public class Cursor {
			[CCode (cname = "SDL_GetMouseFocus")]
			public static Video.Window get_focus ();

			[Version (since = "2.0.0")]
			[CCode (cname = "SDL_MouseIsHaptic", cheader_filename = "SDL2/SDL_haptic.h")]
			public static int is_haptic ();

			[CCode (cname = "SDL_GetMouseState")]
			public static uint32 get_state (ref int x, ref int y);

			[Version (since = "2.0.4")]
			[CCode (cname = "SDL_GetGlobalMouseState")]
			public static uint32 get_global_state (ref int? x, ref int? y);

			[CCode (cname = "SDL_GetRelativeMouseState")]
			public static uint32 get_relative_state (ref int x, ref int y);

			[Version (since = "2.0.4")]
			[CCode (cname = "SDL_CaptureMouse")]
			public static int toggle_capture (bool active);

			[CCode (cname = "SDL_WarpMouseInWindow")]
			public static void warp_inwindow (Video.Window window, int x, int y);

			[Version (since = "2.0.4")]
			[CCode (cname = "SDL_WarpMouseGlobal")]
			public static int warp_global (int x, int y);

			[CCode (cname = "SDL_SetRelativeMouseMode")]
			public static int set_relative_mode (bool enabled);

			[CCode (cname = "SDL_GetRelativeMouseMode")]
			public static bool get_relative_mode ();

			[CCode (cname = "SDL_CreateCursor")]
			public Cursor ([CCode (array_length = false)]uint8[] data, [CCode (array_length = false)]uint8[] mask, int w, int h, int hot_x, int hot_y);

			[Version (since = "2.0.0")]
			[CCode (cname = "SDL_CreateColorCursor")]
			public Cursor.from_color (Video.Surface surface, int hot_x, int hot_y);

			[Version (since = "2.0.0")]
			[CCode (cname = "SDL_SystemCursor")]
			public Cursor.from_system (Input.SystemCursor id);

			[CCode (cname = "SDL_SetCursor")]
			public void set_active ();

			[CCode (cname = "SDL_GetCursor")]
			public static Input.Cursor get_active ();

			[Version (since = "2.0.0")]
			[CCode (cname = "SDL_GetDefaultCursor")]
			public static Input.Cursor get_default ();

			[CCode (cname = "SDL_ShowCursor")]
			public static int show (int toggle);
		}// Cursor

		[CCode (cname = "SDL_JoystickGUID", cheader_filename = "SDL2/SDL_joystick.h")]
		[SimpleType]
		public struct JoystickGUID {
			public uint8 data[16];
		}

		[SimpleType]
		[IntegerType (rank = 6)]
		[CCode (cname = "SDL_JoystickID", cheader_filename = "SDL2/SDL_joystick.h")]
		public struct JoystickID {}// JoystickID

		[Version (since = "2.0.4")]
		[CCode (cname = "SDL_JoystickPowerLevel", cprefix = "SDL_JOYSTICK_POWER_", cheader_filename = "SDL2/SDL_joystick.h")]
		public enum JoystickPowerLevel {
			UNKNOWN, EMPTY, LOW, MEDIUM, FULL, WIRED, MAX;
		}

		[CCode (cname = "SDL_Joystick", free_function = "SDL_JoystickClose", cheader_filename = "SDL2/SDL_joystick.h")]
		[Compact]
		public class Joystick {
			[CCode (cname = "SDL_NumJoysticks")]
			public static int count ();

			[CCode (cname = "SDL_JoystickNameForIndex")]
			public static unowned string get_name_for_index (int device_index);

			[CCode (cname = "SDL_JoystickOpen")]
			public Joystick (int device_index);

			[Version (since = "2.0.4")]
			[CCode (cname = "SDL_JoystickFromInstanceID")]
			public static Joystick? create_from_instance_id (Input.JoystickID id);

			[Version (since = "2.0.0")]
			[CCode (cname = "SDL_JoystickName")]
			public unowned string get_name ();

			[Version (since = "2.0.4")]
			[CCode (cname = "SDL_JoystickCurrentPowerLevel")]
			public Input.JoystickPowerLevel get_current_powerlevel ();

			[CCode (cname = "SDL_JoystickGetDeviceGUID")]
			public static Input.JoystickGUID get_guid_from_device (int device_index);

			[CCode (cname = "SDL_JoystickGetGUID")]
			public Input.JoystickGUID get_guid ();

			[CCode (cname = "SDL_JoystickGetGUIDString")]
			public static void get_guid_buffer (Input.JoystickGUID guid, uint8[] ps);

			//Convenience method, use guid_buffer if the GUID is truncated here
			public static string get_guid_string (Input.JoystickGUID guid) {
				uint8 buf[1024];
				get_guid_buffer (guid, buf);
				return (string) buf;
			}

			[CCode (cname = "SDL_JoystickGetGUIDFromString")]
			public static Input.JoystickGUID get_guid_from_string (string pch);

			[CCode (cname = "SDL_JoystickGetAttached")]
			public bool get_attached ();

			[CCode (cname = "SDL_JoystickInstanceID")]
			public Input.JoystickID get_instance_id ();

			[CCode (cname = "SDL_JoystickNumAxes")]
			public int num_axes ();

			[CCode (cname = "SDL_JoystickNumBalls")]
			public int num_balls ();

			[CCode (cname = "SDL_JoystickNumHats")]
			public int num_hats ();

			[CCode (cname = "SDL_JoystickNumButtons")]
			public int num_buttons ();

			[CCode (cname = "SDL_JoystickUpdate")]
			public static void update ();

			[CCode (cname = "SDL_JoystickGetAxis")]
			public int16 get_axis (int axis);

			[Version (since = "2.0.0")]
			[CCode (cname = "SDL_JoystickIsHaptic", cheader_filename = "SDL2/SDL_haptic.h")]
			public int is_haptic ();

			[CCode (cname = "SDL_JoystickGetHat")]
			public HatValue get_hat (int hat);

			[CCode (cname = "SDL_JoystickGetBall")]
			public int get_ball (int ball, out int dx, out int dy);

			[CCode (cname = "SDL_JoystickGetButton")]
			public Input.ButtonState get_button (int button);
		}// Joystick

		[CCode (cheader_filename = "SDL2/SDL_touch.h")]
		namespace Touch {

			[SimpleType]
			[IntegerType (rank = 10)]
			[CCode (cname = "SDL_GestureID", cheader_filename = "SDL2/SDL_gesture.h")]
			public struct GestureID {}// GestureID

			[SimpleType]
			[IntegerType (rank = 10)]
			[CCode (cname = "SDL_TouchID", cheader_filename = "SDL2/SDL_touch.h")]
			public struct TouchID {}// TouchID

			[SimpleType]
			[IntegerType (rank = 10)]
			[CCode (cname = "SDL_FingerID", cheader_filename = "SDL2/SDL_touch.h")]
			public struct FingerID {}// FingerID

			/**
			 *  Used as the device ID for mouse events simulated with touch input
			 */
			[CCode (cname = "SDL_TOUCH_MOUSEID", cheader_filename = "SDL2/SDL_touch.h")]
			public const uint32 TOUCH_MOUSE_ID;

			/**
			 *  Used as the {@link TouchID} for touch events simulated with mouse input
			 */
			[Version (since = "2.0.10")]
			[CCode (cname = "SDL_MOUSE_TOUCHID", cheader_filename = "SDL2/SDL_touch.h")]
			public const int64 MOUSE_TOUCH_ID;

			[CCode (cname = "SDL_RecordGesture", cheader_filename = "SDL2/SDL_gesture.h")]
			public static int record_gesture (Touch.TouchID touch_id);

			[Version (since = "2.0.0")]
			[CCode (cname = "SDL_LoadDollarTemplates", cheader_filename = "SDL2/SDL_gesture.h")]
			public static int load_dollar_templates_rw (Touch.TouchID touch_id, SDL.RWops src);

			[Version (since = "2.0.0")]
			public static int load_dollar_templates (Touch.TouchID touch_id, string file) {
				return load_dollar_templates_rw (touch_id, new SDL.RWops.from_file (file, "rb"));
			}

			[Version (since = "2.0.0")]
			[CCode (cname = "SDL_SaveDollarTemplate", cheader_filename = "SDL2/SDL_gesture.h")]
			public static int save_dollar_template_rw (GestureID gesture_id, SDL.RWops dst);

			public static int save_dollar_template (GestureID gesture_id, string file) {
				return save_dollar_template_rw (gesture_id, new SDL.RWops.from_file (file, "wb"));
			}

			[Version (since = "2.0.0")]
			[CCode (cname = "SDL_SaveAllDollarTemplates", cheader_filename = "SDL2/SDL_gesture.h")]
			public static int save_all_dollar_templates_rw (SDL.RWops dst);

			public static int save_all_dollar_templates (string file) {
				return save_all_dollar_templates_rw (new SDL.RWops.from_file (file, "wb"));
			}

			[Version (since = "2.0.0")]
			[CCode (cname = "SDL_GetNumTouchDevices", cheader_filename = "SDL2/SDL_touch.h")]
			public static int num_devices ();

			[Version (since = "2.0.0")]
			[CCode (cname = "SDL_GetTouchDevice", cheader_filename = "SDL2/SDL_touch.h")]
			public static TouchID get_touch_device (int index);

			[Version (since = "2.0.0")]
			[CCode (cname = "SDL_GetNumTouchFingers", cheader_filename = "SDL2/SDL_touch.h")]
			public static int num_fingers (TouchID touch_id);



			[CCode (cname = "SDL_Finger", type_id = "SDL_Finger", cheader_filename = "SDL2/SDL_touch.h")]
			[Compact]
			public class Finger {
				public FingerID id;
				public float x;
				public float y;
				public float pressure;

				[CCode (cname = "SDL_GetTouchFinger", cheader_filename = "SDL2/SDL_touch.h")]
				public Finger (TouchID touch_id, int index);
			}// Finger
		}
		///
		/// Game Controller
		///
		[CCode (cname = "SDL_GameController", free_function = "SDL_GameControllerClose", cheader_filename = "SDL2/SDL_gamecontroller.h")]
		[Compact]
		public class GameController {

			[Version (since = "2.0.0")]
			[CCode (cname = "SDL_GameControllerOpen")]
			public GameController (int device_index);

			[Version (since = "2.0.4")]
			[CCode (cname = "SDL_GameControllerFromInstanceID")]
			public static GameController? create_from_instance_id (Input.JoystickID id);

			[Version (since = "2.0.0")]
			public string? name {
				[CCode (cname = "SDL_GameControllerName")] get;
			}

			[Version (since = "2.0.0")]
			[CCode (cname = "SDL_GameControllerMapping")]
			public string get_mapping ();

			[CCode (cname = "SDL_GameControllerGetJoystick")]
			public Input.Joystick to_joystick ();

			[CCode (cname = "SDL_GameControllerGetAttached")]
			public bool is_attached ();

			[Version (since = "2.0.0")]
			[CCode (cname = "SDL_GameControllerGetAxis")]
			public int16 get_axis_status (GameController.Axis axis);

			[Version (since = "2.0.0")]
			[CCode (cname = "SDL_GameControllerGetButton")]
			public uint8 get_button_status (GameController.Button button);

			[Version (since = "2.0.0")]
			[CCode (cname = "SDL_GameControllerGetBindForAxis")]
			public Input.GameController.ButtonBind get_axis_bind (GameController.Axis axis);

			[Version (since = "2.0.0")]
			[CCode (cname = "SDL_GameControllerGetBindForButton")]
			public Input.GameController.ButtonBind get_button_bind (GameController.Button button);

			[Version (since = "2.0.0")]
			[CCode (cname = "SDL_GameControllerEventState")]
			public static void set_event_state (SDL.EventState state);

			[Version (since = "2.0.0")]
			[CCode (cname = "SDL_IsGameController")]
			public static bool is_game_controller (int device_index);

			[Version (since = "2.0.0")]
			[CCode (cname = "SDL_GameControllerNameForIndex")]
			public static string? name_for_index (int device_index);

			[CCode (cname = "SDL_GameControllerAddMapping")]
			public static int load_mapping (string mapping);

			[Version (since = "2.0.2")]
			[CCode (cname = "SDL_GameControllerAddMappingsFromFile")]
			public static int load_mapping_file (string path);

			[Version (since = "2.0.2")]
			[CCode (cname = "SDL_GameControllerAddMappingsFromRW")]
			public static int load_mapping_rw (SDL.RWops rw, int freerw = 1);

			[CCode (cname = "SDL_GameControllerMappingForGUID")]
			public static string mapping_for_guid (Input.JoystickGUID guid);

			//Convenience method to get the amount of Controllers available
			public static int count () {
				int controllernum = 0;
				for (int i = 0; i < Input.Joystick.count (); i++) {
					if (is_game_controller (i)) {
						controllernum++;
					}
				}
				return controllernum;
			}

			[CCode (cname = "SDL_GameControllerUpdate")]
			public static void update_controls ();

			[CCode (cprefix = "SDL_CONTROLLER_AXIS_", cheader_filename = "SDL2/SDL_gamecontroller.h")]
			public enum Axis {
				INVALID, LEFTX, LEFTY, RIGHTX, RIGHTY, TRIGGERLEFT, TRIGGERRIGHT, MAX;
				[CCode (cname = "SDL_GameControllerGetStringForAxis")]
				private string? _to_string ();

				public string to_string () {
					return _to_string () ?? "INVALID";
				}
				[CCode (cname = "SDL_GameControllerGetAxisFromString")]
				public static GameController.Axis? from_string (string axis_string);
			}

			[Version (since = "2.0.0")]
			[CCode (cprefix = "SDL_CONTROLLER_BUTTON_", cheader_filename = "SDL2/SDL_gamecontroller.h")]
			public enum Button {
				INVALID, A, B, X, Y, BACK, GUIDE, START, LEFTSTICK, RIGHTSTICK,
				LEFTSHOULDER, RIGHTSHOULDER, DPAD_UP, DPAD_DOWN, DPAD_LEFT, DPAD_RIGHT, MAX;
				[CCode (cname = "SDL_GameControllerGetStringForButton")]
				private string? _to_string ();

				public string to_string () {
					return _to_string () ?? "INVALID";
				}
				[CCode (cname = "SDL_GameControllerGetButtonFromString")]
				public static GameController.Button? from_string (string button_string);
			}
			[CCode (cprefix = "SDL_CONTROLLER_BINDTYPE_", cheader_filename = "SDL2/SDL_gamecontroller.h")]
			public enum BindType {
				NONE, BUTTON, AXIS, HAT
			}

			[CCode (cname = "SDL_GameControllerButtonBind")]
			public struct ButtonBind {
				[CCode (cname = "bindType")]
				public BindType bind_type;

				[CCode (cname = "value.button")]
				public int button;
				[CCode (cname = "value.axis")]
				public int axis;
				[CCode (cname = "value.hat.hat")]
				public int hat;
				[CCode (cname = "value.hat.hat_mask")]
				public int hat_mask;
			}
		}
	}

	///
	/// Force Feedback
	///
	[CCode (cname = "SDL_Haptic", destroy_function = "SDL_HapticClose", cheader_filename = "SDL2/SDL_haptic.h")]
	[Compact]
	public class Haptic {
		[CCode (cname = "Uint8", cprefix = "SDL_HAPTIC_", cheader_filename = "SDL2/SDL_haptic.h")]
		public enum DirectionType {
			POLAR, CARTESIAN, SPHERICAL
		}
		[Flags, CCode (cname = "Uint16", cprefix = "SDL_HAPTIC_", cheader_filename = "SDL2/SDL_haptic.h")]
		public enum EffectType {
			SINE, SQUARE, TRIANGLE, SAWTOOTHUP, SAWTOOTHDOWN, CONSTANT,
			CUSTOM, LEFTRIGHT, SPRING, DAMPER, INERTIA, FRICTION, RAMP
		}
		[CCode (cname = "SDL_HapticDirection", cheader_filename = "SDL2/SDL_haptic.h")]
		[SimpleType]
		public struct HapticDirection {
			public DirectionType type;
			public int32 dir;
		}
		[CCode (cname = "SDL_HapticPeriodic", cheader_filename = "SDL2/SDL_haptic.h")]
		public struct HapticPeriodic {
			//Header
			public EffectType type;
			public HapticDirection direction;
			//Replay
			public uint32 length;
			public uint16 delay;
			//Trigger
			public uint16 button;
			public uint16 interval;
			//Periodic
			public uint16 period;
			public int16 magnitude;
			public int16 offset;
			public uint16 phase;
			//Envelope
			public uint16 attack_length;
			public uint16 attack_level;
			public uint16 fade_langth;
			public uint16 fade_level;
		}

		[CCode (cname = "SDL_HapticConstant", cheader_filename = "SDL2/SDL_haptic.h")]
		public struct HapticConstant {
			//Header
			public EffectType type;
			public HapticDirection direction;
			//Replay
			public uint32 length;
			public uint16 delay;
			//Trigger
			public uint16 button;
			public uint16 interval;
			//Constant
			public int16 level;
			//Envelope
			public uint16 attack_length;
			public uint16 attack_level;
			public uint16 fade_langth;
			public uint16 fade_level;
		}

		[CCode (cname = "SDL_HapticCondition", cheader_filename = "SDL2/SDL_haptic.h")]
		public struct HapticCondition {
			//Header
			public EffectType type;
			public HapticDirection direction;
			//Replay
			public uint32 length;
			public uint16 delay;
			//Trigger
			public uint16 button;
			public uint16 interval;
			//Condition
			public uint16 right_sat;
			public uint16 left_sat;
			public int16 right_coeff;
			public int16 left_coeff;
			public uint16 deadband;
			public int16 center;
			//Envelope
			public uint16 attack_length;
			public uint16 attack_level;
			public uint16 fade_langth;
			public uint16 fade_level;
		}
		[CCode (cname = "SDL_HapticRamp", cheader_filename = "SDL2/SDL_haptic.h")]
		public struct HapticRamp {
			//Header
			public EffectType type;
			public HapticDirection direction;
			//Replay
			public uint32 length;
			public uint16 delay;
			//Trigger
			public uint16 button;
			public uint16 interval;
			//Ramp
			public int16 start;
			public int16 end;
			//Envelope
			public uint16 attack_length;
			public uint16 attack_level;
			public uint16 fade_langth;
			public uint16 fade_level;
		}
		[CCode (cname = "SDL_HapticLeftRight", cheader_filename = "SDL2/SDL_haptic.h")]
		public struct HapticLeftRight {
			//Header
			public EffectType type;
			//Replay
			public uint32 length;
			//Rumble
			public uint16 large_magnitude;
			public uint16 small_magnitude;
		}
		[CCode (cname = "SDL_HapticCustom", cheader_filename = "SDL2/SDL_haptic.h")]
		public struct HapticCustom {
			//Header
			public EffectType type;
			public HapticDirection direction;
			//Replay
			public uint32 length;
			public uint16 delay;
			//Trigger
			public uint16 button;
			public uint16 interval;
			//Custom
			public uint8 channels;
			public uint16 period;
			public uint16 samples;
			[CCode (array_length = false)]
			public uint16[] data;
			//Envelope
			public uint16 attack_length;
			public uint16 attack_level;
			public uint16 fade_langth;
			public uint16 fade_level;
		}

		[CCode (cname = "SDL_HapticEffect", has_type_id = false, has_target = false, destroy_function = "", cheader_filename = "SDL2/SDL_haptic.h")]
		[SimpleType]
		public struct HapticEffect {
			public EffectType type;
			public HapticConstant constant;
			public HapticPeriodic periodic;
			public HapticCondition condition;
			public HapticRamp ramp;
			public HapticLeftRight leftright;
			public HapticCustom custom;
		}


		[Version (since = "2.0.0")]
		[CCode (cname = "SDL_HapticOpen")]
		public Haptic (int device_index);
		[Version (since = "2.0.0")]
		[CCode (cname = "SDL_HapticOpenfromJoystick")]
		public Haptic.from_joystick (Input.Joystick joystick);
		[Version (since = "2.0.0")]
		[CCode (cname = "SDL_HapticOpenfromMouse")]
		public Haptic.from_mouse ();
		[CCode (cname = "SDL_NumHaptics")]
		public static int num_devices ();
		[CCode (cname = "SDL_HapticName")]
		public static unowned string device_name (int device_index);
		[CCode (cname = "SDL_HapticNewEffect")]
		public int upload_effect (HapticEffect effect);
		[CCode (cname = "SDL_HapticRunEffect")]
		public int run_effect (int effect_id);
		[CCode (cname = "SDl_HapticUpdateEffect")]
		public int update_effect (int effect_id, HapticEffect new_effect);
		[CCode (cname = "SDL_HapticDestroyEffect")]
		public int destroy_effect (int effect_id);
		[CCode (cname = "SDL_HapticGetEffectStatus")]
		public int get_effect_status (int effect_id);
		//Returns negative on error, that's why it's not a bool
		[CCode (cname = "SDL_HapticEffectSupported")]
		public int supports_effect (HapticEffect effect);
		[Version (since = "2.0.0")]
		[CCode (cname = "SDL_HapticNumEffects")]
		public int effects_capacity ();
		[Version (since = "2.0.0")]
		[CCode (cname = "SDL_HapticNumEffectsPlaying")]
		public int effects_playing ();
		[CCode (cname = "SDL_HapticNumAxes")]
		public int num_axes ();
		[CCode (cname = "SDL_HapticIndex")]
		public int get_index ();
		[CCode (cname = "SDL_HapticSetGain")]
		public int set_gain (int gain);
		[CCode (cname = "SDL_HapticsetAutocenter")]
		public int set_autocenter (int percentage);
		[CCode (cname = "SDL_HapticRumbleInit")]
		public int rumble_init ();
		[CCode (cname = "SDL_HapticRumblePlay")]
		public int rumble_play ();
		[CCode (cname = "SDL_HapticRumbleStop")]
		public int rumble_stop ();
		[CCode (cname = "SDL_HapticRumbleSupported")]
		public int rumble_supported ();
		[Version (since = "2.0.0")]
		[CCode (cname = "SDL_HapticOpened")]
		public bool is_open ();
		[CCode (cname = "SDL_HapticQuery")]
		public uint query ();
		[CCode (cname = "SDL_HapticPause")]
		public int pause ();
		[CCode (cname = "SDL_HapticUnpause")]
		public int resume ();
		[CCode (cname = "SDL_HapticStopAll")]
		public int stop ();
		[CCode (cname = "SDL_HapticStopEffect")]
		public int stop_effect (int effect_id);

	}//Force Feedback


	///
	/// Audio
	///

	[CCode (cheader_filename = "SDL2/SDL_audio.h")]
	namespace Audio {
		[CCode (cname = "Uint16", cprefix = "AUDIO_", cheader_filename = "SDL2/SDL_audio.h")]
		public enum AudioFormat {
			U8, S16LSB, S16MSB, S16SYS, S16,
			U16LSB, U16MSB, U16SYS, U16,
			[Version (since = "2.0")] S32LSB,
			[Version (since = "2.0")] S32MSB,
			[Version (since = "2.0")] S32SYS,
			[Version (since = "2.0")] S32,
			[Version (since = "2.0")] F32LSB,
			[Version (since = "2.0")] F32MSB,
			[Version (since = "2.0")] F32SYS,
			[Version (since = "2.0")] F32
		}// AudioFormat

		[CCode (cname = "int", cprefix = "SDL_AUDIO_")]
		public enum AudioStatus {
			STOPPED, PLAYING, PAUSED
		}// AudioStatus

			[CCode (cname = "int", cprefix = "SDL_AUDIO_ALLOW_", cheader_filename = "SDL2/SDL_audio.h")]
		public enum AllowFlags {
			FREQUENCY_CHANGE,
			FORMAT_CHANGE,
			CHANNELS_CHANGE,
			ANY_CHANGE
		}// AudioAllowFlags

		[CCode (cname = "SDL_AudioCallback", instance_pos = 0.1, has_target = true, delegate_target_pos = 0, cheader_filename = "SDL2/SDL_audio.h")]
		public delegate void AudioFunc (uint8[] stream, int len);

		[CCode (cname = "SDL_AudioSpec", cheader_filename = "SDL2/SDL_audio.h")]
		public struct AudioSpec {
			public int freq;
			public AudioFormat format;
			public uint8 channels;
			public uint8 silence;
			public uint16 samples;
			public uint16 padding;
			public uint32 size;
			[CCode (delegate_target_cname = "userdata")]
			public unowned AudioFunc callback;
		}// AudioSpec

		[CCode (cname = "SDL_AudioFilter", has_target = false, cheader_filename = "SDL2/SDL_audio.h")]
		public delegate void AudioFilter (AudioConverter cvt, AudioFormat format);

		[CCode (cname = "SDL_AudioCVT", cheader_filename = "SDL2/SDL_audio.h")]
		public struct AudioConverter {
			public int needed;
			public AudioFormat src_format;
			public AudioFormat dst_format;
			public double rate_incr;
			public uint8* buf;
			public int len;
			public int len_cvt;
			public int len_mult;
			public double len_ratio;
			public AudioFilter filters[10];
			public int filter_index;

			[CCode (cname = "SDL_BuildAudioCVT")]
			public static int build (AudioConverter cvt, AudioFormat src_format,
			uint8 src_channels, int src_rate, AudioFormat dst_format,
			uint8 dst_channels, int dst_rate);

			[CCode (cname = "SDL_ConvertAudio")]
			public int convert ();
		}// AudioConverter

		[CCode (cname = "SDL_AudioDeviceID", has_type_id = false, cheader_filename = "SDL2/SDL_audio.h")]
		[SimpleType]
		[IntegerType (rank = 7)]
		public struct AudioDevice : uint32 {
			[CCode (cname = "SDL_OpenAudioDevice")]
			public AudioDevice (string device_name, bool is_capture,
								AudioSpec desired, AudioSpec obtained,
				int allowed_changes);

			[CCode (cname = "SDL_PauseAudioDevice")]
			public void pause (int pause_on);

			[CCode (cname = "SDL_GetAudioDeviceStatus")]
			public AudioStatus get_status ();

			[CCode (cname = "SDL_LockAudioDevice")]
			public void do_lock ();

			[CCode (cname = "SDL_UnlockAudioDevice")]
			public void unlock ();

			[CCode (cname = "SDL_GetAudioDeviceName")]
			public unowned string get_name ();

			[Version (since = "2.0.4")]
			[CCode (cname = "SDL_QueueAudio")]
			public int raw_enqueue (void* data, uint32 length);

			[Version (since = "2.0.4")]
			[CCode (cname = "SDL_QueueAudio")]
			public int enqueue (uint8[] data);

			[Version (since = "2.0.5")]
			[CCode (cname = "SDL_DequeueAudio")]
			public int raw_dequeue (void* data, uint32 length);

			[Version (since = "2.0.5")]
			[CCode (cname = "SDL_DequeueAudio")]
			public int dequeue (uint8[] data);

			[Version (since = "2.0.4")]
			[CCode (cname = "SDL_GetQueuedAudioSize")]
			public uint32 get_queued_size ();

			[Version (since = "2.0.4")]
			[CCode (cname = "SDL_ClearQueuedAudio")]
			public void clear_queue ();

			[Version (since = "2.0.4")]
			[CCode (cname = "SDL_CloseAudioDevice")]
			public void close_device ();

			[Version (since = "2.0.4")]
			[CCode (cname = "SDL_AudioDeviceConnected")]
			public bool is_device_connected ();


		}// AudioDeviceID


		[Version (since = "2.0.0")]
		[CCode (cname = "SDL_GetNumAudioDrivers")]
		public static int num_drivers ();

		[CCode (cname = "SDL_GetAudioDriver")]
		public static unowned string get_driver (int index);

		[CCode (cname = "SDL_AudioInit")]
		public static int init (string driver);

		[CCode (cname = "SDL_AudioQuit")]
		public static void quit ();

		[Version (since = "2.0.0")]
		[CCode (cname = "SDL_GetCurrentAudioDriver")]
		public static unowned string get_current_driver ();

		[Version (deprecated = true, replacement = "AudioDevice.AudioDevice")]
		[CCode (cname = "SDL_OpenAudio")]
		public static int open (AudioSpec desired, out AudioSpec obtained);

		[Version (since = "2.0.0")]
		[CCode (cname = "SDL_GetNumAudioDevices")]
		public static int num_devices (int iscapture = 0);


		[CCode (cname = "SDL_GetAudioStatus")]
		public static AudioStatus status ();

		[Version (deprecated = true, replacement = "AudioDevice.pause")]
		[CCode (cname = "SDL_PauseAudio")]
		public static void pause (int pause_on);

		[CCode (cname = "SDL_LoadWAV_RW")]
		public static unowned AudioSpec? load_rw (RWops src, int freesrc, ref AudioSpec spec, out uint8[] audio_buf, out uint32 audio_len);

		public static unowned AudioSpec? load (string file, ref AudioSpec spec, out uint8[] audio_buf, out uint32 audio_len) {
			return load_rw (new SDL.RWops.from_file (file, "rb"), 1,
			ref spec, out audio_buf, out audio_len);
		}

		[CCode (cname = "SDL_FreeWAV")]
		public static void free (ref uint8 audio_buf);

		[CCode (cname = "SDL_MixAudio")]
		public static void mix (out uint8[] dst, uint8[] src, uint32 len, int volume);

		[CCode (cname = "SDL_MixAudioFormat")]
		public static void mix_device (out uint8[] dst, uint8[] src, AudioFormat format, uint32 len, int volume);

		[Version (deprecated = true, replacement = "AudioDevice.do_lock")]
		[CCode (cname = "SDL_LockAudio")]
		public static void do_lock ();

		[Version (deprecated = true, replacement = "AudioDevice.unlock")]
		[CCode (cname = "SDL_UnlockAudio")]
		public static void unlock ();

		[Version (deprecated = true, replacement = "Audio.close_device")]
		[CCode (cname = "SDL_CloseAudio")]
		public static void close ();

	}// Audio


	///
	/// Timers
	///
	[CCode (cname = "SDL_TimerCallback", cheader_filename = "SDL2/SDL_timer.h", has_target = true, delegate_target_pos = 0.1)]
	public delegate uint32 TimerFunc (uint32 interval);

	[CCode (cname = "SDL_TimerID", cheader_filename = "SDL2/SDL_timer.h")]
	[SimpleType, IntegerType (rank = 6)]
	public struct Timer {
		[CCode (cname = "SDL_GetTicks")]
		public static uint32 get_ticks ();

		[CCode (cname = "SDL_GetPerformanceCounter")]
		public static uint64 get_performance_counter ();

		[Version (since = "2.0.0")]
		[CCode (cname = "SDL_GetPerformanceFrequency")]
		public static uint64 get_performance_frequency ();

		[CCode (cname = "SDL_Delay")]
		public static void delay (uint32 ms);

		[CCode (cname = "SDL_AddTimer", delegate_target_pos= 1.1)]
		public Timer (uint32 interval, SDL.TimerFunc callback);

		[CCode (cname = "SDL_RemoveTimer")]
		public bool remove ();
	}// Timer




	///
	/// Threading
	///
	[CCode (has_target = true)]
	public delegate int ThreadFunc ();


	[CCode (cname = "SDL_ThreadPriority", cprefix = "SDL_THREAD_PRIORITY_", cheader_filename = "SDL2/SDL_thread.h")]
	public enum ThreadPriority {
		LOW, NORMAL, HIGH
	}

	[CCode (cname = "SDL_Thread", free_function = "vala_sdl_wait_thread", cheader_filename = "SDL2/SDL_thread.h")]
	[Compact]
	public class Thread {
		[CCode (cname = "SDL_CreateThread", delegate_target_pos= 1.1)]
		public Thread (ThreadFunc f, string name);

		[CCode (cname = "SDL_ThreadID")]
		public static ulong id ();

		[CCode (cname = "SDL_WaitThread")]
		private void _wait(out int status);

		[CCode (cname = "vala_sdl_wait_thread")]
		[DestroysInstance]
		public int wait() {
			int retval;
			_wait(out retval);
			return retval;
		}

		[CCode (cname = "SDL_GetThreadID")]
		public ulong get_id ();

		[CCode (cname = "SDL_GetThreadName")]
		public string get_name ();

		[CCode (cname = "SDL_SetThreadPriority")]
		public static int set_priotity (ThreadPriority priority);

		[Version (since = "2.0.2")]
		[CCode (cname = "SDL_DetachThread")]
		public void detach ();

	}// Thread

	[CCode (cname = "SDL_Mutex", free_function = "SDL_DestroyMutex")]
	[Compact]
	public class Mutex {
		[CCode (cname = "SDL_CreateMutex")]
		public Mutex ();

		[CCode (cname = "SDL_TryLockMutex")]
		public int try_lock ();

		[CCode (cname = "SDL_LockMutex")]
		public int do_lock ();

		[CCode (cname = "SDL_UnlockMutex")]
		public int unlock ();
	}// Mutex

	[CCode (cname = "SDL_sem", free_function = "SDL_DestroySemaphore")]
	[Compact]
	public class Semaphore {
		[CCode (cname = "SDL_CreateSemaphore")]
		public Semaphore (uint32 initial_value);

		[CCode (cname = "SDL_SemWait")]
		public int wait ();

		[CCode (cname = "SDL_SemTryWait")]
		public int try_wait ();

		[CCode (cname = "SDL_SemWaitTimeout")]
		public int wait_timeout (uint32 ms);

		[CCode (cname = "SDL_SemPost")]
		public int post ();

		[CCode (cname = "SDL_SemValue")]
		public uint32 get_value ();
	}// Semaphore

	[CCode (cname = "SDL_cond", free_function = "SDL_DestroyCond")]
	[Compact]
	public class Condition {
		[CCode (cname = "SDL_CreateCond")]
		public Condition ();

		[CCode (cname = "SDL_CondSignal")]
		public int emit_signal ();

		[CCode (cname = "SDL_CondBroadcast")]
		public int broadcast ();

		[CCode (cname = "SDL_CondWait")]
		public int wait (SDL.Mutex mut);

		[CCode (cname = "SDL_CondWaitTimeout")]
		public int wait_timeout (SDL.Mutex mut, uint32 ms);
	}// Condition

}// SDL
