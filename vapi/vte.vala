[CCode (cheader_filename = "vte/vte.h")]
namespace Vte {
	[CCode (cprefix = "VTE_ANTI_ALIAS_")]
	public enum TerminalAntiAlias {
		USE_DEFAULT,
		FORCE_ENABLE,
		FORCE_DISABLE,
	}
	[CCode (cprefix = "VTE_ERASE_")]
	public enum TerminalEraseBinding {
		AUTO,
		ASCII_BACKSPACE,
		ASCII_DELETE,
		DELETE_SEQUENCE,
	}
	[CCode (cheader_filename = "vte/reaper.h")]
	public class Reaper : GLib.Object {
		[NoArrayLength]
		[CCode (cname = "vte_reaper_add_child")]
		public static int add_child (GLib.Pid pid);
		[NoArrayLength]
		[CCode (cname = "vte_reaper_get")]
		public static weak Vte.Reaper @get ();
		[NoArrayLength]
		[CCode (cname = "vte_reaper_get_type")]
		public static GLib.Type get_type ();
		public signal void child_exited (int p0, int p1);
	}
	[CCode (cheader_filename = "vte/vte.h")]
	public class Terminal : Gtk.Widget {
		public weak Gtk.Adjustment adjustment;
		public long char_width;
		public long char_height;
		public long char_ascent;
		public long char_descent;
		public long row_count;
		public long column_count;
		public weak string window_title;
		public weak string icon_title;
		[NoArrayLength]
		[CCode (cname = "vte_terminal_copy_clipboard")]
		public void copy_clipboard ();
		[NoArrayLength]
		[CCode (cname = "vte_terminal_copy_primary")]
		public void copy_primary ();
		[NoArrayLength]
		[CCode (cname = "vte_terminal_feed")]
		public void feed (string data, long length);
		[NoArrayLength]
		[CCode (cname = "vte_terminal_feed_child")]
		public void feed_child (string text, long length);
		[NoArrayLength]
		[CCode (cname = "vte_terminal_feed_child_binary")]
		public void feed_child_binary (string data, long length);
		[NoArrayLength]
		[CCode (cname = "vte_terminal_fork_command")]
		public int fork_command (string command, string argv, string envv, string directory, bool lastlog, bool utmp, bool wtmp);
		[NoArrayLength]
		[CCode (cname = "vte_terminal_forkpty")]
		public int forkpty (string envv, string directory, bool lastlog, bool utmp, bool wtmp);
		[NoArrayLength]
		[CCode (cname = "vte_terminal_get_adjustment")]
		public weak Gtk.Adjustment get_adjustment ();
		[NoArrayLength]
		[CCode (cname = "vte_terminal_get_allow_bold")]
		public bool get_allow_bold ();
		[NoArrayLength]
		[CCode (cname = "vte_terminal_get_audible_bell")]
		public bool get_audible_bell ();
		[NoArrayLength]
		[CCode (cname = "vte_terminal_get_char_ascent")]
		public long get_char_ascent ();
		[NoArrayLength]
		[CCode (cname = "vte_terminal_get_char_descent")]
		public long get_char_descent ();
		[NoArrayLength]
		[CCode (cname = "vte_terminal_get_char_height")]
		public long get_char_height ();
		[NoArrayLength]
		[CCode (cname = "vte_terminal_get_char_width")]
		public long get_char_width ();
		[NoArrayLength]
		[CCode (cname = "vte_terminal_get_column_count")]
		public long get_column_count ();
		[NoArrayLength]
		[CCode (cname = "vte_terminal_get_cursor_position")]
		public void get_cursor_position (long column, long row);
		[NoArrayLength]
		[CCode (cname = "vte_terminal_get_default_emulation")]
		public weak string get_default_emulation ();
		[NoArrayLength]
		[CCode (cname = "vte_terminal_get_emulation")]
		public weak string get_emulation ();
		[NoArrayLength]
		[CCode (cname = "vte_terminal_get_encoding")]
		public weak string get_encoding ();
		[NoArrayLength]
		[CCode (cname = "vte_terminal_get_font")]
		public weak Pango.FontDescription get_font ();
		[NoArrayLength]
		[CCode (cname = "vte_terminal_get_has_selection")]
		public bool get_has_selection ();
		[NoArrayLength]
		[CCode (cname = "vte_terminal_get_icon_title")]
		public weak string get_icon_title ();
		[NoArrayLength]
		[CCode (cname = "vte_terminal_get_mouse_autohide")]
		public bool get_mouse_autohide ();
		[NoArrayLength]
		[CCode (cname = "vte_terminal_get_padding")]
		public void get_padding (int xpad, int ypad);
		[NoArrayLength]
		[CCode (cname = "vte_terminal_get_row_count")]
		public long get_row_count ();
		[NoArrayLength]
		[CCode (cname = "vte_terminal_get_status_line")]
		public weak string get_status_line ();
		[NoArrayLength]
		[CCode (cname = "vte_terminal_get_text")]
		public weak string get_text (Vte.IsSelectedFunc is_selected, pointer data, GLib.Array attributes);
		[NoArrayLength]
		[CCode (cname = "vte_terminal_get_text_include_trailing_spaces")]
		public weak string get_text_include_trailing_spaces (Vte.IsSelectedFunc is_selected, pointer data, GLib.Array attributes);
		[NoArrayLength]
		[CCode (cname = "vte_terminal_get_text_range")]
		public weak string get_text_range (long start_row, long start_col, long end_row, long end_col, Vte.IsSelectedFunc is_selected, pointer data, GLib.Array attributes);
		[NoArrayLength]
		[CCode (cname = "vte_terminal_get_type")]
		public static weak Gtk.Type get_type ();
		[NoArrayLength]
		[CCode (cname = "vte_terminal_get_using_xft")]
		public bool get_using_xft ();
		[NoArrayLength]
		[CCode (cname = "vte_terminal_get_visible_bell")]
		public bool get_visible_bell ();
		[NoArrayLength]
		[CCode (cname = "vte_terminal_get_window_title")]
		public weak string get_window_title ();
		[NoArrayLength]
		[CCode (cname = "vte_terminal_im_append_menuitems")]
		public void im_append_menuitems (Gtk.MenuShell menushell);
		[NoArrayLength]
		[CCode (cname = "vte_terminal_is_word_char")]
		public bool is_word_char (unichar c);
		[NoArrayLength]
		[CCode (cname = "vte_terminal_match_add")]
		public int match_add (string match);
		[NoArrayLength]
		[CCode (cname = "vte_terminal_match_check")]
		public weak string match_check (long column, long row, int tag);
		[NoArrayLength]
		[CCode (cname = "vte_terminal_match_clear_all")]
		public void match_clear_all ();
		[NoArrayLength]
		[CCode (cname = "vte_terminal_match_remove")]
		public void match_remove (int tag);
		[NoArrayLength]
		[CCode (cname = "vte_terminal_match_set_cursor")]
		public void match_set_cursor (int tag, Gdk.Cursor cursor);
		[NoArrayLength]
		[CCode (cname = "vte_terminal_match_set_cursor_type")]
		public void match_set_cursor_type (int tag, Gdk.CursorType cursor_type);
		[NoArrayLength]
		[CCode (cname = "vte_terminal_new")]
		public Terminal ();
		[NoArrayLength]
		[CCode (cname = "vte_terminal_paste_clipboard")]
		public void paste_clipboard ();
		[NoArrayLength]
		[CCode (cname = "vte_terminal_paste_primary")]
		public void paste_primary ();
		[NoArrayLength]
		[CCode (cname = "vte_terminal_reset")]
		public void reset (bool full, bool clear_history);
		[NoArrayLength]
		[CCode (cname = "vte_terminal_select_all")]
		public void select_all ();
		[NoArrayLength]
		[CCode (cname = "vte_terminal_select_none")]
		public void select_none ();
		[NoArrayLength]
		[CCode (cname = "vte_terminal_set_allow_bold")]
		public void set_allow_bold (bool allow_bold);
		[NoArrayLength]
		[CCode (cname = "vte_terminal_set_audible_bell")]
		public void set_audible_bell (bool is_audible);
		[NoArrayLength]
		[CCode (cname = "vte_terminal_set_background_image")]
		public void set_background_image (Gdk.Pixbuf image);
		[NoArrayLength]
		[CCode (cname = "vte_terminal_set_background_image_file")]
		public void set_background_image_file (string path);
		[NoArrayLength]
		[CCode (cname = "vte_terminal_set_background_saturation")]
		public void set_background_saturation (double saturation);
		[NoArrayLength]
		[CCode (cname = "vte_terminal_set_background_tint_color")]
		public void set_background_tint_color (Gdk.Color color);
		[NoArrayLength]
		[CCode (cname = "vte_terminal_set_background_transparent")]
		public void set_background_transparent (bool transparent);
		[NoArrayLength]
		[CCode (cname = "vte_terminal_set_backspace_binding")]
		public void set_backspace_binding (Vte.TerminalEraseBinding binding);
		[NoArrayLength]
		[CCode (cname = "vte_terminal_set_color_background")]
		public void set_color_background (Gdk.Color background);
		[NoArrayLength]
		[CCode (cname = "vte_terminal_set_color_bold")]
		public void set_color_bold (Gdk.Color bold);
		[NoArrayLength]
		[CCode (cname = "vte_terminal_set_color_cursor")]
		public void set_color_cursor (Gdk.Color cursor_background);
		[NoArrayLength]
		[CCode (cname = "vte_terminal_set_color_dim")]
		public void set_color_dim (Gdk.Color dim);
		[NoArrayLength]
		[CCode (cname = "vte_terminal_set_color_foreground")]
		public void set_color_foreground (Gdk.Color foreground);
		[NoArrayLength]
		[CCode (cname = "vte_terminal_set_color_highlight")]
		public void set_color_highlight (Gdk.Color highlight_background);
		[NoArrayLength]
		[CCode (cname = "vte_terminal_set_colors")]
		public void set_colors (Gdk.Color foreground, Gdk.Color background, Gdk.Color palette, long palette_size);
		[NoArrayLength]
		[CCode (cname = "vte_terminal_set_cursor_blinks")]
		public void set_cursor_blinks (bool blink);
		[NoArrayLength]
		[CCode (cname = "vte_terminal_set_default_colors")]
		public void set_default_colors ();
		[NoArrayLength]
		[CCode (cname = "vte_terminal_set_delete_binding")]
		public void set_delete_binding (Vte.TerminalEraseBinding binding);
		[NoArrayLength]
		[CCode (cname = "vte_terminal_set_emulation")]
		public void set_emulation (string emulation);
		[NoArrayLength]
		[CCode (cname = "vte_terminal_set_encoding")]
		public void set_encoding (string codeset);
		[NoArrayLength]
		[CCode (cname = "vte_terminal_set_font")]
		public void set_font (Pango.FontDescription font_desc);
		[NoArrayLength]
		[CCode (cname = "vte_terminal_set_font_from_string")]
		public void set_font_from_string (string name);
		[NoArrayLength]
		[CCode (cname = "vte_terminal_set_font_from_string_full")]
		public void set_font_from_string_full (string name, Vte.TerminalAntiAlias antialias);
		[NoArrayLength]
		[CCode (cname = "vte_terminal_set_font_full")]
		public void set_font_full (Pango.FontDescription font_desc, Vte.TerminalAntiAlias antialias);
		[NoArrayLength]
		[CCode (cname = "vte_terminal_set_mouse_autohide")]
		public void set_mouse_autohide (bool setting);
		[NoArrayLength]
		[CCode (cname = "vte_terminal_set_opacity")]
		public void set_opacity (ushort opacity);
		[NoArrayLength]
		[CCode (cname = "vte_terminal_set_pty")]
		public void set_pty (int pty_master);
		[NoArrayLength]
		[CCode (cname = "vte_terminal_set_scroll_background")]
		public void set_scroll_background (bool scroll);
		[NoArrayLength]
		[CCode (cname = "vte_terminal_set_scroll_on_keystroke")]
		public void set_scroll_on_keystroke (bool scroll);
		[NoArrayLength]
		[CCode (cname = "vte_terminal_set_scroll_on_output")]
		public void set_scroll_on_output (bool scroll);
		[NoArrayLength]
		[CCode (cname = "vte_terminal_set_scrollback_lines")]
		public void set_scrollback_lines (long lines);
		[NoArrayLength]
		[CCode (cname = "vte_terminal_set_size")]
		public void set_size (long columns, long rows);
		[NoArrayLength]
		[CCode (cname = "vte_terminal_set_visible_bell")]
		public void set_visible_bell (bool is_visible);
		[NoArrayLength]
		[CCode (cname = "vte_terminal_set_word_chars")]
		public void set_word_chars (string spec);
		public signal void child_exited ();
		public signal void window_title_changed ();
		public signal void icon_title_changed ();
		public signal void encoding_changed ();
		public signal void commit (string text, uint size);
		public signal void emulation_changed ();
		public signal void char_size_changed (uint char_width, uint char_height);
		public signal void selection_changed ();
		public signal void contents_changed ();
		public signal void cursor_moved ();
		public signal void deiconify_window ();
		public signal void iconify_window ();
		public signal void raise_window ();
		public signal void lower_window ();
		public signal void refresh_window ();
		public signal void restore_window ();
		public signal void maximize_window ();
		public signal void resize_window (uint width, uint height);
		public signal void move_window (uint x, uint y);
		public signal void status_line_changed ();
		public signal void increase_font_size ();
		public signal void decrease_font_size ();
		public signal void text_modified ();
		public signal void text_inserted ();
		public signal void text_deleted ();
		public signal void text_scrolled (int delta);
	}
	[CCode (cheader_filename = "vte/vteaccess.h")]
	public class TerminalAccessible : Gtk.Accessible, Atk.Text, Atk.Component, Atk.Action {
		[NoArrayLength]
		[CCode (cname = "vte_terminal_accessible_get_type")]
		public static weak Gtk.Type get_type ();
		[NoArrayLength]
		[CCode (cname = "vte_terminal_accessible_new")]
		public TerminalAccessible (Vte.Terminal terminal);
	}
	[CCode (cheader_filename = "vte/vte.h")]
	public class TerminalAccessibleFactory : Atk.ObjectFactory {
		[NoArrayLength]
		[CCode (cname = "vte_terminal_accessible_factory_get_type")]
		public static weak Gtk.Type get_type ();
		[NoArrayLength]
		[CCode (cname = "vte_terminal_accessible_factory_new")]
		public TerminalAccessibleFactory ();
	}
	[ReferenceType]
	public struct CharAttributes {
		public long row;
		public long column;
		public Gdk.Color fore;
		public Gdk.Color back;
		public uint underline;
		public uint strikethrough;
	}
	public callback bool IsSelectedFunc (Vte.Terminal terminal, long column, long row, pointer data);
}
