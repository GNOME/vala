/* valareport.vala
 *
 * Copyright (C) 2006-2010  Jürg Billeter
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public
 * License as published by the Free Software Foundation; either
 * version 2.1 of the License, or (at your option) any later version.

 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * Lesser General Public License for more details.

 * You should have received a copy of the GNU Lesser General Public
 * License along with this library; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301  USA
 *
 * Author:
 * 	Jürg Billeter <j@bitron.ch>
 */

using GLib;


/**
 * Namespace to centralize reporting warnings and errors.
 */
public class Vala.Report {
	public enum Colored {
		AUTO,
		NEVER,
		ALWAYS
	}

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


	protected int warnings;
	protected int errors;

	private bool verbose_errors;

	public bool enable_warnings { get; set; default = true; }

	static GLib.Regex val_regex;

	/**
	 * Set all colors by string
	 *
	 * {{{
	 *   "error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01"
	 * }}}
	 */
	public bool set_colors (string str, Report.Colored colored_output = Report.Colored.AUTO) {
		try {
			if (val_regex == null)
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

		if (colored_output == Report.Colored.ALWAYS || (colored_output == Report.Colored.AUTO && Log.writer_supports_color (stderr.fileno ()))) {
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

	/**
	 * Set the error verbosity.
	 */
	public void set_verbose_errors (bool verbose) {
		verbose_errors = verbose;
	}

	/**
	 * Returns the total number of warnings reported.
	 */
	public int get_warnings () {
		return warnings;
	}

	/**
	 * Returns the total number of errors reported.
	 */
	public int get_errors () {
		return errors;
	}

	/**
	 * Pretty-print the actual line of offending code if possible.
	 */
	private void report_source (SourceReference source) {
		for (int idx = source.begin.line; idx <= source.end.line; idx++) {
			string? offending_line = source.file.get_source_line (idx);
			if (offending_line == null) {
				break;
			}
			printerr ("%5d | %s\n", idx, offending_line);
			printerr ("      | ");
			stderr.puts (caret_color_start);
			for (int jdx = 0; jdx < offending_line.length; jdx++) {
				if (offending_line[jdx] == '\t') {
					stderr.putc ('\t');
					continue;
				}
				bool caret = false;
				unowned SourceLocation begin = source.begin;
				unowned SourceLocation end = source.end;
				if (begin.line == idx && end.line == idx) {
					if (begin.column <= jdx + 1 <= end.column) {
						caret = true;
					}
				} else if (begin.line == idx && begin.column <= jdx + 1) {
					caret = true;
				} else if (begin.line < idx < end.line) {
					caret = true;
				} else if (end.line == idx && end.column >= jdx + 1) {
					caret = true;
				}
				if (caret) {
					if (begin.line == idx && begin.column == jdx + 1) {
						stderr.putc ('^');
					} else {
						stderr.putc ('~');
					}
				} else {
					stderr.putc (' ');
				}
			}
			stderr.puts (caret_color_end);
			stderr.putc ('\n');
		}
	}

	private void print_highlighted_message (string message) {
		int start = 0;
		int cur = 0;

		while (message[cur] != '\0') {
			if (message[cur] == '\'' || message[cur] == '`') {
				unowned string end_chars = (message[cur] == '`')? "`'" : "'";
				stderr.puts (message.substring (start, cur - start));
				start = cur;
				cur++;

				while (message[cur] != '\0' && end_chars.index_of_char (message[cur]) < 0) {
					cur++;
				}
				if (message[cur] == '\0') {
					stderr.puts (message.substring (start, cur - start));
					start = cur;
				} else {
					cur++;
					printerr ("%s%s%s", quote_color_start, message.substring (start, cur - start), quote_color_end);
					start = cur;
				}
			} else {
				cur++;
			}
		}

		stderr.puts (message.offset (start));
	}

	private void print_message (SourceReference? source, string type, string type_color_start, string type_color_end, string message, bool do_report_source) {
		if (source != null) {
			printerr ("%s%s:%s ", locus_color_start, source.to_string (), locus_color_end);
		}

		printerr ("%s%s:%s ", type_color_start, type, type_color_end);

		// highlight '', `', ``
		print_highlighted_message (message);
		stderr.putc ('\n');

		if (do_report_source && source != null) {
			report_source (source);
		}
	}

	/**
	 * Reports the specified message as note.
	 *
	 * @param source  reference to source code
	 * @param message note message
	 */
	public virtual void note (SourceReference? source, string message) {
		if (!enable_warnings) {
			return;
		}

		print_message (source, "note", note_color_start, note_color_end, message, verbose_errors);
	}

	/**
	 * Reports the specified message as deprecation warning.
	 *
	 * @param source  reference to source code
	 * @param message warning message
	 */
	public virtual void depr (SourceReference? source, string message) {
		if (!enable_warnings) {
			return;
		}

		warnings++;

		print_message (source, "warning", warning_color_start, warning_color_end, message, verbose_errors);
	}

	/**
	 * Reports the specified message as warning.
	 *
	 * @param source  reference to source code
	 * @param message warning message
	 */
	public virtual void warn (SourceReference? source, string message) {
		if (!enable_warnings) {
			return;
		}

		warnings++;

		print_message (source, "warning", warning_color_start, warning_color_end, message, verbose_errors);
	}

	/**
	 * Reports the specified message as error.
	 *
	 * @param source  reference to source code
	 * @param message error message
	 */
	public virtual void err (SourceReference? source, string message) {
		errors++;

		print_message (source, "error", error_color_start, error_color_end, message, verbose_errors);
	}

	/* Convenience methods calling warn and err on correct instance */
	[PrintfFormat]
	public static void notice (SourceReference? source, string msg_format, ...) {
		CodeContext.get ().report.note (source, msg_format.vprintf (va_list ()));
	}
	[PrintfFormat]
	public static void deprecated (SourceReference? source, string msg_format, ...) {
		CodeContext.get ().report.depr (source, msg_format.vprintf (va_list ()));
	}
	[PrintfFormat]
	public static void experimental (SourceReference? source, string msg_format, ...) {
		CodeContext.get ().report.depr (source, msg_format.vprintf (va_list ()));
	}
	[PrintfFormat]
	public static void warning (SourceReference? source, string msg_format, ...) {
		CodeContext.get ().report.warn (source, msg_format.vprintf (va_list ()));
	}
	[PrintfFormat]
	public static void error (SourceReference? source, string msg_format, ...) {
		CodeContext.get ().report.err (source, msg_format.vprintf (va_list ()));
	}
}
