/* valareport.vala
 *
 * Copyright (C) 2006-2007  Jürg Billeter
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
 * Static class to centralize reporting warnings and errors.
 */
public static class Vala.Report {
	private static int warnings;
	private static int errors;

	private static bool verbose_errors;
	
	/**
	 * Set the error verbosity.
	 */
	public static void set_verbose_errors (bool verbose) {
		verbose_errors = verbose;
	}

	/**
	 * Returns the total number of warnings reported.
	 */
	public static int get_warnings () {
		return warnings;
	}
	
	/**
	 * Returns the total number of errors reported.
	 */
	public static int get_errors () {
		return errors;
	}

	/**
	 * Pretty-print the actual line of offending code if possible.
	 */
	private static void report_source (SourceReference source) {
		if (source.first_line != source.last_line) {
			// FIXME Cannot report multi-line issues currently
			return;
		}

		string offending_line = source.file.get_source_line (source.first_line);

		if (offending_line != null) {
			stderr.printf ("%s\n", offending_line);
			int idx;
			
			/* We loop in this manner so that we don't fall over on differing
			 * tab widths. This means we get the ^s in the right places.
			 */
			for (idx = 1; idx < source.first_column; ++idx) {
				if (offending_line[idx - 1] == '\t') {
					stderr.printf ("\t");
				} else {
					stderr.printf (" ");
				}
			}

			for (idx = source.first_column; idx <= source.last_column; ++idx) {
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
	 * Reports the specified message as warning.
	 *
	 * @param source  reference to source code
	 * @param message warning message
	 */
	public static void warning (SourceReference source, string message) {
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
	public static void error (SourceReference source, string message) {
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
}
