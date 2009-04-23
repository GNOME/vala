/* x11.vapi
 *
 * Copyright (C) 2009  Jürg Billeter
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public
 * License as published by the Free Software Foundation; either
 * version 2.1 of the License, or (at your option) any later version.
 *
 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public
 * License along with this library; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301  USA
 *
 * Author:
 * 	Jürg Billeter <j@bitron.ch>
 */

[CCode (cprefix = "", lower_case_cprefix = "", cheader_filename = "X11/Xlib.h,X11/Xatom.h,X11/Xutil.h")]
namespace X {
	[Compact]
	[CCode (cname = "Display", ref_function = "", unref_function = "")]
	public class Display {
		[CCode (cname = "XAddToSaveSet")]
		public int add_to_save_set (Window w);
		[CCode (cname = "XAllowEvents")]
		public int allow_events (int event_mode, int time);
		[CCode (cname = "XChangeProperty")]
		public int change_property (Window w, Atom property, Atom type, int format, int mode, [CCode (array_length = false)] uchar[] data, int nelements);
		[CCode (cname = "XChangeWindowAttributes")]
		public int change_window_attributes (Window w, ulong valuemask, SetWindowAttributes attributes);
		[CCode (cname = "XConfigureWindow")]
		public int configure_window (Window w, uint value_mask, WindowChanges values);
		[CCode (cname = "ConnectionNumber")]
		public int connection_number ();
		[CCode (cname = "DefaultRootWindow")]
		public Window default_root_window ();
		[CCode (cname = "DisplayString")]
		public string display_string ();
		[CCode (cname = "XFlush")]
		public int flush ();
		[CCode (cname = "XGetKeyboardMapping", array_length = false)]
		public weak uint[] get_keyboard_mapping (uint first_keycode, int keycode_count, ref int keysyms_per_keycode_return);
		[CCode (cname = "XGetModifierMapping")]
		public ModifierKeymap get_modifier_mapping ();
		[CCode (cname = "XGetSelectionOwner")]
		public Window get_selection_owner (Atom selection);
		[CCode (cname = "XGetWindowAttributes")]
		public void get_window_attributes (Window w, out WindowAttributes window_attributes_return);
		[CCode (cname = "XGetWindowProperty")]
		public int get_window_property (Window w, Atom property, long long_offset, long long_length, bool delete, Atom req_type, out Atom actual_type_return, out int actual_format_return, out ulong nitems_return, out ulong bytes_after_return, out void* prop_return);
		[CCode (cname = "XGrabButton")]
		public int grab_button (uint button, uint modifiers, Window grab_window, bool owner_events, uint event_mask, int pointer_mode, int keyboard_mode, Window confine_to, uint cursor);
		[CCode (cname = "XGrabPointer")]
		public int grab_pointer (Window grab_window, bool owner_events, uint event_mask, int pointer_mode, int keyboard_mode, Window confine_to, uint cursor, int time);
		[CCode (cname = "XGrabServer")]
		public int grab_server ();
		[CCode (cname = "XInternAtom")]
		public Atom intern_atom (string atom_name, bool only_if_exists);
		[CCode (cname = "XInternAtoms")]
		public void intern_atoms (string[] names, bool only_if_exists, [CCode (array_length = false)] Atom[] atoms_return);
		[CCode (cname = "XDisplayKeycodes")]
		public int keycodes (ref int min_keycodes_return, ref int max_keycodes_return);
		[CCode (cname = "XMapWindow")]
		public int map_window (Window w);
		[CCode (cname = "XNextEvent")]
		public int next_event (ref Event event_return);
		[CCode (cname = "XPending")]
		public int pending ();
		[CCode (cname = "XRaiseWindow")]
		public int raise_window (Window w);
		[CCode (cname = "XReparentWindow")]
		public int reparent_window (Window w, Window parent, int x, int y);
		[CCode (cname = "XResizeWindow")]
		public int resize_window (Window w, uint width, uint height);
		[CCode (cname = "XRootWindow")]
		public Window root_window (int screen_number);
		[CCode (cname = "ScreenCount")]
		public int screen_count ();
		[CCode (cname = "XScreenOfDisplay")]
		public weak Screen screen_of_display (int screen_number);
		[CCode (cname = "XSelectInput")]
		public int select_input (Window w, long event_mask);
		[CCode (cname = "XSendEvent")]
		public void send_event (Window w, bool prpagate, long event_mask, ref Event event_send);
		[CCode (cname = "XSetSelectionOwner")]
		public Window set_selection_owner (Atom selection, Window owner, int time);
		[CCode (cname = "XSetInputFocus")]
		public int set_input_focus (Window focus, int revert_to, int time);
		[CCode (cname = "XUngrabButton")]
		public int ungrab_button (uint button, uint modifiers, Window grab_window);
		[CCode (cname = "XUngrabPointer")]
		public int ungrab_pointer (int time);
		[CCode (cname = "XUngrabServer")]
		public int ungrab_server ();
		[CCode (cname = "XUnmapWindow")]
		public int unmap_window (Window w);
		[CCode (cname = "XQueryTree")]
		public void query_tree (Window w, out Window root_return, out Window parent_return, out Window[] children_return);
		[CCode (cname = "XWindowEvent")]
		public int window_event (Window w, EventMask event_mask, out Event event_return);
	}

	[Compact]
	[CCode (cname = "XModifierKeymap", free_function = "XFreeModifiermap")]
	public class ModifierKeymap {
		// The server's max # of keys per modifier
		public int max_keypermod;
		// An 8 by max_keypermod array of modifiers
		public uchar[] modifiermap;
	}

	[SimpleType]
	[IntegerType (rank = 9)]
	[CCode (cname = "Atom")]
	public struct Atom {
	}

	[SimpleType]
	[IntegerType (rank = 9)]
	[CCode (cname = "Window")]
	public struct Window {
	}

	public struct Visual {
	}

	public struct WindowChanges {
		public int x;
		public int y;
		public int width;
		public int height;
		public int border_width;
		public Window sibling;
		public int stack_mode;
	}
	public struct SizeHints {
		public long @flags;
		public int x;
		public int y;
		public int width;
		public int height;
	}

	[CCode (cname = "XCreateWindow")]
	public Window create_window (Display display, Window parent, int x, int y, uint width, uint height, uint border_width, int depth, uint @class, Visual? visual, X.CW valuemask, ref SetWindowAttributes attributes);

	public struct SetWindowAttributes {
		// public Pixmap background_pixmap;	/* background or None or ParentRelative */
		public ulong background_pixel;	/* background pixel */
		// public Pixmap border_pixmap;	/* border of the window */
		public ulong border_pixel;	/* border pixel value */
		public int bit_gravity;		/* one of bit gravity values */
		public int win_gravity;		/* one of the window gravity values */
		public int backing_store;		/* NotUseful, WhenMapped, Always */
		public ulong backing_planes;/* planes to be preseved if possible */
		public ulong backing_pixel;/* value to use in restoring planes */
		public bool save_under;		/* should bits under be saved? (popups) */
		public long event_mask;		/* set of events that should be saved */
		public long do_not_propagate_mask;	/* set of events that should not propagate */
		public bool override_redirect;	/* boolean value for override-redirect */
		// public Colormap colormap;		/* color map to be associated with window */
		// public Cursor cursor;		/* cursor to be displayed (or None) */
	}

	public struct WindowAttributes {
		public int x;
		public int y;			/* location of window */
		public int width;
		public int height;		/* width and height of window */
		public int border_width;		/* border width of window */
		public int depth;          	/* depth of window */
		public Visual visual;		/* the associated visual structure */
		public Window root;        	/* root of screen containing window */
		public int @class;			/* InputOutput, InputOnly*/
		public int bit_gravity;		/* one of bit gravity values */
		public int win_gravity;		/* one of the window gravity values */
		public int backing_store;		/* NotUseful, WhenMapped, Always */
		public ulong backing_planes;/* planes to be preserved if possible */
		public ulong backing_pixel;/* value to be used when restoring planes */
		public bool save_under;		/* boolean, should bits under be saved? */
		// public Colormap colormap;		/* color map to be associated with window */
		public bool map_installed;		/* boolean, is color map currently installed*/
		public int map_state;		/* IsUnmapped, IsUnviewable, IsViewable */
		public long all_event_masks;	/* set of events all people have interest in*/
		public long your_event_mask;	/* my event mask */
		public long do_not_propagate_mask; /* set of events that should not propagate */
		public bool override_redirect;	/* boolean value for override-redirect */
		// public Screen screen;		/* back pointer to correct screen */
	}

	[CCode (cname = "CopyFromParent")]
	public const int COPY_FROM_PARENT;

	[CCode (cname = "CurrentTime")]
	public const ulong CURRENT_TIME;

	[CCode (cname = "Success")]
	public int Success;

	[CCode (cname = "XFree")]
	public int free (void* data);

	[CCode (cprefix = "CW")]
	public enum CW {
		OverrideRedirect,
		EventMask,
		BorderWidth,
		X,
		Y,
		Width,
		Height
	}

	[CCode (cprefix = "GrabMode")]
	public enum GrabMode {
		Sync,
		Async
	}

	[CCode (cprefix = "")]
	public enum EventMask {
		NoEventMask,
		KeyPressMask,
		KeyReleaseMask,
		ButtonPressMask,
		ButtonReleaseMask,
		EnterWindowMask,
		LeaveWindowMask,
		PointerMotionMask,
		PointerMotionHintMask,
		Button1MotionMask,
		Button2MotionMask,
		Button3MotionMask,
		Button4MotionMask,
		Button5MotionMask,
		ButtonMotionMask,
		KeymapStateMask,
		ExposureMask,
		VisibilityChangeMask,
		StructureNotifyMask,
		ResizeRedirectMask,
		SubstructureNotifyMask,
		SubstructureRedirectMask,
		FocusChangeMask,
		PropertyChangeMask,
		ColormapChangeMask,
		OwnerGrabButtonMask
	}

	[CCode (cprefix = "")]
	public enum KeyMask {
		ShiftMask,
		LockMask,
		ControlMask,
		Mod1Mask,
		Mod2Mask,
		Mod3Mask,
		Mod4Mask,
		Mod5Mask
	}

	[CCode (cprefix = "")]
	public enum EventType {
		KeyPress,
		KeyRelease,
		ButtonPress,
		ButtonRelease,
		MotionNotify,
		EnterNotify,
		LeaveNotify,
		FocusIn,
		FocusOut,
		KeymapNotify,
		Expose,
		GraphicsExpose,
		NoExpose,
		VisibilityNotify,
		CreateNotify,
		DestroyNotify,
		UnmapNotify,
		MapNotify,
		MapRequest,
		ReparentNotify,
		ConfigureNotify,
		ConfigureRequest,
		GravityNotify,
		ResizeRequest,
		CirculateNotify,
		CirculateRequest,
		PropertyNotify,
		SelectionClear,
		SelectionRequest,
		SelectionNotify,
		ColormapNotify,
		ClientMessage,
		MappingNotify
	}

	// union
	public struct Event {
		public int type;
		public AnyEvent xany;
		public KeyEvent xkey;
		public ButtonEvent xbutton;
		public MotionEvent xmotion;
		public CrossingEvent xcrossing;
		public CreateWindowEvent xcreatewindow;
		public DestroyWindowEvent xdestroywindow;
		public UnmapEvent xunmap;
		public MapEvent xmap;
		public MapRequestEvent xmaprequest;
		public ReparentEvent xreparent;
		public ConfigureEvent xconfigure;
		public GravityEvent xgravity;
		public ConfigureRequestEvent xconfigurerequest;
		public CirculateEvent xcirculate;
		public CirculateRequestEvent xcirculaterequest;
		public PropertyEvent xproperty;
		public SelectionEvent xselection;
		public ClientMessageEvent xclient;
	}

	public struct AnyEvent {
		public int type;
		public ulong serial;
		public bool send_event;
		public unowned Display display;
		public Window window;
	}

	public struct KeyEvent {
		public int type;
		public ulong serial;
		public bool send_event;
		public unowned Display display;
		public Window window;
		public Window root;
		public Window subwindow;
		public ulong time;
		public int x;
		public int y;
		public int x_root;
		public int y_root;
		public uint state;
		public uint keycode;
		public bool same_screen;
	}

	public struct ButtonEvent {
		public int type;
		public ulong serial;
		public bool send_event;
		public unowned Display display;
		public Window window;
		public Window subwindow;
		public ulong time;
		public int x;
		public int y;
		public int x_root;
		public int y_root;
		public uint state;
		public uint button;
		public bool same_screen;
	}

	public struct MotionEvent {
		public int type;
		public ulong serial;
		public bool send_event;
		public unowned Display display;
		public Window window;
		public Window subwindow;
		public ulong time;
		public int x;
		public int y;
		public int x_root;
		public int y_root;
		public uint state;
		public char is_hint;
		public bool same_screen;
	}

	public struct CrossingEvent {
		public int type;
		public ulong serial;
		public bool send_event;
		public unowned Display display;
		public Window window;
		public Window root;
		public Window subwindow;
		public ulong time;
		public int x;
		public int y;
		public int x_root;
		public int y_root;
		public int mode;
		public int detail;
		public bool same_screen;
		public bool focus;
		public uint state;
	}

	public struct CreateWindowEvent {
		public int type;
		public ulong serial;
		public bool send_event;
		public unowned Display display;
		public Window parent;
		public Window window;
		public int x;
		public int y;
		public int width;
		public int height;
		public int border_width;
		public bool override_redirect;
	}

	public struct DestroyWindowEvent {
		public int type;
		public ulong serial;
		public bool send_event;
		public unowned Display display;
		public Window event;
		public Window window;
	}

	public struct UnmapEvent {
		public int type;
		public ulong serial;
		public bool send_event;
		public unowned Display display;
		public Window event;
		public Window window;
		public bool from_configure;
	}

	public struct MapEvent {
		public int type;
		public ulong serial;
		public bool send_event;
		public unowned Display display;
		public Window event;
		public Window window;
		public bool override_redirect;
	}

	public struct MapRequestEvent {
		public int type;
		public ulong serial;
		public bool send_event;
		public unowned Display display;
		public Window parent;
		public Window window;
	}

	public struct ReparentEvent {
		public int type;
		public ulong serial;
		public bool send_event;
		public unowned Display display;
		public Window event;
		public Window window;
		public Window parent;
		public int x;
		public int y;
		public bool override_redirect;
	}

	public struct ConfigureEvent {
		public int type;
		public ulong serial;
		public bool send_event;
		public unowned Display display;
		public Window event;
		public Window window;
		public int x;
		public int y;
		public int width;
		public int height;
		public int border_width;
		public Window above;
		public bool override_redirect;
	}

	public struct GravityEvent {
		public int type;
		public ulong serial;
		public bool send_event;
		public unowned Display display;
		public Window event;
		public Window window;
		public int x;
		public int y;
	}

	public struct ConfigureRequestEvent {
		public int type;
		public ulong serial;
		public bool send_event;
		public unowned Display display;
		public Window parent;
		public Window window;
		public int x;
		public int y;
		public int width;
		public int height;
		public int border_width;
		public Window above;
		public int detail;
		public ulong value_mask;
	}

	public struct CirculateEvent {
		public int type;
		public ulong serial;
		public bool send_event;
		public unowned Display display;
		public Window event;
		public Window window;
		public int place;
	}

	public struct CirculateRequestEvent {
		public int type;
		public ulong serial;
		public bool send_event;
		public unowned Display display;
		public Window parent;
		public Window window;
		public int place;
	}

	public struct PropertyEvent {
		public int type;
		public ulong serial;
		public bool send_event;
		public unowned Display display;
		public Window window;
		public Atom atom;
		public ulong time;
		public int state;
	}

	public struct SelectionEvent {
		public int type;
		public ulong serial;
		public bool send_event;
		public unowned Display display;
		public Window requestor;
		public Atom selection;
		public Atom target;
		public Atom property;
		public ulong time;
	}

	public struct ClientMessageEvent {
		public int type;
		public ulong serial;	/* # of last request processed by server */
		public bool send_event;	/* true if this came from a SendEvent request */
		public unowned Display display;	/* Display the event was read from */
		public Window window;
		public Atom message_type;
		public int format;
		public ClientMessageEventData data;
	}

	// union
	public struct ClientMessageEventData {
		public unowned char[] b;
		public unowned short[] s;
		public unowned long[] l;
	}

	[CCode (cprefix = "PropMode")]
	public enum PropMode {
		Replace,
		Prepend,
		Append
	}

	[CCode (cprefix = "")]
	public enum AllowEventsMode {
		AsyncPointer,
		SyncPointer,
		ReplayPointer,
		AsyncKeyboard,
		SyncKeyboard,
		ReplayKeyboard,
		AsyncBoth,
		SyncBoth
	}

	[CCode (cprefix = "")]
	public enum MapState {
		IsUnmapped,
		IsUnviewable,
		IsViewable
	}

	[CCode (cprefix = "RevertTo")]
	public enum RevertTo {
		None,
		PointerRoot,
		Parent
	}

	[Compact]
	[CCode (cname = "Screen")]
	public class Screen {
		public Display display;
		public Window root;
		public int width;
		public int height;
	}

	public const X.Atom XA_ATOM;
	public const X.Atom XA_CARDINAL;
	public const X.Atom XA_WINDOW;
	public const X.Atom XA_WM_CLASS;
	public const X.Atom XA_WM_HINTS;
	public const X.Atom XA_WM_ICON_NAME;
	public const X.Atom XA_WM_NAME;
	public const X.Atom XA_WM_NORMAL_HINTS;
	public const X.Atom XA_WM_TRANSIENT_FOR;

	public const uint XK_Num_Lock;
	public const uint XK_Scroll_Lock;
}

