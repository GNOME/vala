/* errorreporter.vala
 *
 * Copyright (C) 2008-2011 Florian Brosch
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
 * 	Brosch Florian <flo.brosch@gmail.com>
 */


public class Valadoc.ErrorReporter : Object {
	private int _warnings = 0;
	private int _errors = 0;

	/**
	 * SGR (Select Graphic Rendition) end tag
	 */
	private const string ANSI_COLOR_END = "\x1b[0m";

	/**
	 * SGR (Select Graphic Rendition) start tag for source location
	 */
	private string locus_color_start = "";

	/**
	 * SGR (Select Graphic Rendition) end tag for source location
	 */
	private unowned string locus_color_end = "";

	/**
	 * SGR (Select Graphic Rendition) start tag for warning titles
	 */
	private string warning_color_start = "";

	/**
	 * SGR (Select Graphic Rendition) end tag for warning titles
	 */
	private unowned string warning_color_end = "";

	/**
	 * SGR (Select Graphic Rendition) start tag for error titles
	 */
	private string error_color_start = "";

	/**
	 * SGR (Select Graphic Rendition) end tag for error titles
	 */
	private unowned string error_color_end = "";

	/**
	 * SGR (Select Graphic Rendition) start tag for note titles
	 */
	private string note_color_start = "";

	/**
	 * SGR (Select Graphic Rendition) end tag for note titles
	 */
	private unowned string note_color_end = "";

	/**
	 * SGR (Select Graphic Rendition) start tag for caret line (^^^)
	 */
	private string caret_color_start = "";

	/**
	 * SGR (Select Graphic Rendition) end tag for caret line (^^^)
	 */
	private unowned string caret_color_end = "";

	/**
	 * SGR (Select Graphic Rendition) start tag for quotes line ('...', `...`, `...')
	 */
	private string quote_color_start = "";

	/**
	 * SGR (Select Graphic Rendition) end tag for quotes line ('...', `...`, `...')
	 */
	private unowned string quote_color_end = "";


	public int warnings_offset {
		get;
		set;
	}

	public int errors_offset {
		get;
		set;
	}

	public unowned GLib.FileStream stream {
		get;
		set;
	}

	public Settings? settings {
		get;
		set;
	}

	public int errors {
		get {
			return this._errors + errors_offset;
		}
	}

	public int warnings {
		get {
			return this._warnings + warnings_offset;
		}
	}


	public ErrorReporter (Settings? settings = null) {
		this.stream = GLib.stderr;
		this.settings = settings;
	}

	/**
	 * Set all colors by string
	 *
	 * {{{
	 *   "error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01"
	 * }}}
	 */
	public bool set_colors (string str) {
		Regex val_regex;
		try {
			val_regex = new Regex ("^\\s*[0-9]+(;[0-9]*)*\\s*$");
		} catch (RegexError e) {
			assert_not_reached ();
		}

		string error_color = null;
		string warning_color = null;
		string note_color = null;
		string caret_color = null;
		string locus_color = null;
		string quote_color = null;

		string[] fragments = str.split (":");
		foreach (unowned string fragment in fragments) {
			string[] eq = fragment.split ("=", 2);
			if (eq.length != 2) {
				return false;
			}

			if (!val_regex.match (eq[1])) {
				return false;
			}


			unowned string checked_value = eq[1]._strip ();
			switch (eq[0]._strip ()) {
			case "error":
				error_color = checked_value;
				break;

			case "warning":
				warning_color = checked_value;
				break;

			case "note":
				note_color = checked_value;
				break;

			case "caret":
				caret_color = checked_value;
				break;

			case "locus":
				locus_color = checked_value;
				break;

			case "quote":
				quote_color = checked_value;
				break;

			default:
				return false;
			}
		}

		if (is_atty (this.stream.fileno ())) {
			if (error_color != null) {
				this.error_color_start = "\x1b[0" + error_color + "m";
				this.error_color_end = ANSI_COLOR_END;
			}

			if (warning_color != null) {
				this.warning_color_start = "\x1b[0" + warning_color + "m";
				this.warning_color_end = ANSI_COLOR_END;
			}

			if (note_color != null) {
				this.note_color_start = "\x1b[0" + note_color + "m";
				this.note_color_end = ANSI_COLOR_END;
			}

			if (caret_color != null) {
				this.caret_color_start = "\x1b[0" + caret_color + "m";
				this.caret_color_end = ANSI_COLOR_END;
			}

			if (locus_color != null) {
				this.locus_color_start = "\x1b[0" + locus_color + "m";
				this.locus_color_end = ANSI_COLOR_END;
			}

			if (quote_color != null) {
				this.quote_color_start = "\x1b[0" + quote_color + "m";
				this.quote_color_end = ANSI_COLOR_END;
			}
		}
		return true;
	}

	[CCode (has_target = false)]
	private delegate int AttyFunc (int fd);

	private bool is_atty (int fd) {
		Module module = Module.open (null, ModuleFlags.LAZY);
		if (module == null) {
			return false;
		}

		void* _func;
		module.symbol ("isatty", out _func);
		if (_func == null) {
			return false;
		}

		AttyFunc? func = (AttyFunc) _func;
		return func (fd) == 1;
	}

	[PrintfFormat]
	private inline void msg (string type, string type_color_start, string type_color_end, string file, long line, long startpos, long endpos,
							 string errline, string msg_format, va_list args)
	{
		this.stream.printf ("%s%s:%lu.%lu-%lu.%lu:%s %s%s:%s ",
							locus_color_start, file, line, startpos, line, endpos, locus_color_end,
							type_color_start, type, type_color_end);
		print_highlighted_message (msg_format.vprintf (args));
		this.stream.putc ('\n');

		if (startpos <= endpos) {
			this.stream.printf ("%s\n", errline);

			this.stream.puts (caret_color_start);
			for (int i = 0; i < errline.char_count ()+1; i++) {
				if (errline[i] == '\t') {
					this.stream.printf ("\t");
				} else if (i >= startpos - 1 && i < endpos - 1) {
					this.stream.printf ("^");
				} else {
					this.stream.printf (" ");
				}
			}
			this.stream.puts (caret_color_end);
			this.stream.printf ("\n");
		}
	}

	private void print_highlighted_message (string message) {
		int start = 0;
		int cur = 0;

		while (message[cur] != '\0') {
			if (message[cur] == '\'' || message[cur] == '`') {
				unowned string end_chars = (message[cur] == '`')? "`'" : "'";
				this.stream.puts (message.substring (start, cur - start));
				start = cur;
				cur++;

				while (message[cur] != '\0' && end_chars.index_of_char (message[cur]) < 0) {
					cur++;
				}
				if (message[cur] == '\0') {
					this.stream.puts (message.substring (start, cur - start));
					start = cur;
				} else {
					cur++;
					this.stream.printf ("%s%s%s", quote_color_start, message.substring (start, cur - start), quote_color_end);
					start = cur;
				}
			} else {
				cur++;
			}
		}

		this.stream.puts (message.offset (start));
	}

	[PrintfFormat]
	public void simple_warning (string? location, string msg_format, ...) {
		var args = va_list();

		if (location != null) {
			this.stream.puts (locus_color_start);
			this.stream.puts (location);
			this.stream.puts (": ");
			this.stream.puts (locus_color_end);
		}

		this.stream.puts (warning_color_start);
		this.stream.puts ("warning: ");
		this.stream.puts (warning_color_end);

		print_highlighted_message (msg_format.vprintf (args));
		this.stream.putc ('\n');
		this._warnings++;
	}

	[PrintfFormat]
	public void simple_error (string? location, string msg_format, ...) {
		var args = va_list();

		if (location != null) {
			this.stream.puts (locus_color_start);
			this.stream.puts (location);
			this.stream.puts (": ");
			this.stream.puts (locus_color_end);
			this.stream.putc (' ');
		}

		this.stream.puts (error_color_start);
		this.stream.puts ("error: ");
		this.stream.puts (error_color_end);

		print_highlighted_message (msg_format.vprintf (args));
		this.stream.putc ('\n');
		this._errors++;
	}

	[PrintfFormat]
	public void simple_note (string? location, string msg_format, ...) {
		if (_settings == null || _settings.verbose) {
			var args = va_list();

			if (location != null) {
				this.stream.puts (locus_color_start);
				this.stream.puts (location);
				this.stream.puts (": ");
				this.stream.puts (locus_color_end);
				this.stream.putc (' ');
			}

			this.stream.puts (note_color_start);
			this.stream.puts ("note: ");
			this.stream.puts (note_color_end);

			print_highlighted_message (msg_format.vprintf (args));
			this.stream.putc ('\n');
			this._warnings++;
		}
	}

	[PrintfFormat]
	public void error (string file, long line, long startpos, long endpos, string errline,
					   string msg_format, ...)
	{
		var args = va_list();
		this.msg ("error", error_color_start, error_color_end, file, line, startpos, endpos, errline, msg_format, args);
		this._errors++;
	}

	[PrintfFormat]
	public void warning (string file, long line, long startpos, long endpos, string errline,
						 string msg_format, ...)
	{
		var args = va_list();
		this.msg ("warning", warning_color_start, warning_color_end, file, line, startpos, endpos, errline, msg_format, args);
		this._warnings++;
	}
}

