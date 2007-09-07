/* valareport.vala
 *
 * Copyright (C) 2006  Jürg Billeter
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
public class Vala.Report {
	private static int warnings;
	private static int errors;
	
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
	 * Reports the specified message as warning.
	 *
	 * @param source  reference to source code
	 * @param message warning message
	 */
	public static void warning (SourceReference source, string! message) {
		warnings++;
		if (source == null) {
			stderr.printf ("warning: %s\n", message);
		} else {
			stderr.printf ("%s: warning: %s\n", source.to_string (), message);
		}
	}
	
	/**
	 * Reports the specified message as error.
	 *
	 * @param source  reference to source code
	 * @param message error message
	 */
	public static void error (SourceReference source, string! message) {
		errors++;
		if (source == null) {
			stderr.printf ("error: %s\n", message);
		} else {
			stderr.printf ("%s: error: %s\n", source.to_string (), message);
		}
	}
}
