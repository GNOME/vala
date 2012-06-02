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
	protected int warnings;
	protected int errors;

	bool verbose_errors;

	public bool enable_warnings { get; set; default = true; }

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
	static void report_source (SourceReference source) {
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

			for (idx = source.begin.column; idx <= source.end.column; ++idx) {
				if (offending_line[idx - 1] == '\t') {
					stderr.printf ("\t");
				} else {
					stderr.printf ("^");
				}
			}

			stderr.printf ("\n");
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

		if (source == null) {
			stderr.printf ("note: %s\n", message);
		} else {
			stderr.printf ("%s: note: %s\n", source.to_string (), message);
			if (verbose_errors) {
				report_source (source);
			}
		}
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
		if (source == null) {
			stderr.printf ("warning: %s\n", message);
		} else {
			stderr.printf ("%s: warning: %s\n", source.to_string (), message);
		}
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
		if (source == null) {
			stderr.printf ("warning: %s\n", message);
		} else {
			stderr.printf ("%s: warning: %s\n", source.to_string (), message);
			if (verbose_errors) {
				report_source (source);
			}
		}
	}
	
	/**
	 * Reports the specified message as error.
	 *
	 * @param source  reference to source code
	 * @param message error message
	 */
	public virtual void err (SourceReference? source, string message) {
		errors++;
		if (source == null) {
			stderr.printf ("error: %s\n", message);
		} else {
			stderr.printf ("%s: error: %s\n", source.to_string (), message);
			if (verbose_errors) {
				report_source (source);
			}
		}
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
}
