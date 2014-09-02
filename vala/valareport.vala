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
public class Vala.Report : Object {
	/**
	 * SGR end tag
	 */
	private const string ANSI_COLOR_END = "\x1b[0m";

	/**
	 * SGR start tag for source location
	 */
	private string locus_color_start = "";

	/**
	 * SGR end tag for source location
	 */
	private unowned string locus_color_end = "";

	/**
	 * SGR start tag for warning titles
	 */
	private string warning_color_start = "";

	/**
	 * SGR end tag for warning titles
	 */
	private unowned string warning_color_end = "";

	/**
	 * SGR start tag for error titles
	 */
	private string error_color_start = "";

	/**
	 * SGR end tag for error titles
	 */
	private unowned string error_color_end = "";

	/**
	 * SGR start tag for note titles
	 */
	private string note_color_start = "";

	/**
	 * SGR end tag for note titles
	 */
	private unowned string note_color_end = "";

	/**
	 * SGR start tag for caret line (^^^)
	 */
	private string caret_color_start = "";

	/**
	 * SGR end tag for caret line (^^^)
	 */
	private unowned string caret_color_end = "";

	/**
	 * SGR start tag for quotes line ('', ``, `')
	 */
	private string quote_color_start = "";

	/**
	 * SGR end tag for quotes line ('', ``, `')
	 */
	private unowned string quote_color_end = "";


	protected int warnings;
	protected int errors;

	private bool verbose_errors;

	public bool enable_warnings { get; set; default = true; }


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

		if (is_atty (stderr.fileno ())) {
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
		if (source.begin.line != source.end.line) {
			// FIXME Cannot report multi-line issues currently
			return;
		}

		string offending_line = source.file.get_source_line (source.begin.line);

		if (offending_line != null) {
			stderr.printf ("%s\n", offending_line);
			int idx;

			/* We loop in this manner so that we don't fall over on differing
			 * tab widths. This means we get the ^s in the right places.
			 */
			for (idx = 1; idx < source.begin.column; ++idx) {
				if (offending_line[idx - 1] == '\t') {
					stderr.printf ("\t");
				} else {
					stderr.printf (" ");
				}
			}

			stderr.puts (caret_color_start);
			for (idx = source.begin.column; idx <= source.end.column; ++idx) {
				if (offending_line[idx - 1] == '\t') {
					stderr.printf ("\t");
				} else {
					stderr.printf ("^");
				}
			}
			stderr.puts (caret_color_end);

			stderr.printf ("\n");
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
					stderr.printf ("%s%s%s", quote_color_start, message.substring (start, cur - start), quote_color_end);
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
			stderr.printf ("%s%s:%s ", locus_color_start, source.to_string (), locus_color_end);
		}

		stderr.printf ("%s%s:%s ", type_color_start, type, type_color_end);

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

		print_message (source, "warning", warning_color_start, warning_color_end, message, false);
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
	public static void notice (SourceReference? source, string message) {
		CodeContext.get ().report.note (source, message);
	}
	public static void deprecated (SourceReference? source, string message) {
		CodeContext.get ().report.depr (source, message);
	}
	public static void experimental (SourceReference? source, string message) {
		CodeContext.get ().report.depr (source, message);
	}
	public static void warning (SourceReference? source, string message) {
		CodeContext.get ().report.warn (source, message);
	}
	public static void error (SourceReference? source, string message) {
		CodeContext.get ().report.err (source, message);
	}


	[CCode (has_target = false)]
	private delegate int AttyFunc (int fd);

	private bool is_atty (int fd) {
		Module module = Module.open (null, ModuleFlags.BIND_LAZY); 
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
}
