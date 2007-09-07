/* valasourcereference.vala
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
 * Represents a reference to a location in a source file.
 */
public class Vala.SourceReference : Object {
	/**
	 * The source file to be referenced.
	 */
	public weak SourceFile file { get; set; }

	/**
	 * The first line number of the referenced source code.
	 */
	public int first_line { get; set; }

	/**
	 * The first column number of the referenced source code.
	 */
	public int first_column { get; set; }

	/**
	 * The last line number of the referenced source code.
	 */
	public int last_line { get; set; }

	/**
	 * The last column number of the referenced source code.
	 */
	public int last_column { get; set; }

	/**
	 * The text describing the referenced source code.
	 */
	public string comment { get; set; }
	
	/**
	 * Creates a new source reference.
	 *
	 * @param file         a source file
	 * @param first_line   first line number
	 * @param first_column first column number
	 * @param last_line    last line number
	 * @param last_column  last column number
	 * @return             newly created source reference
	 */
	public SourceReference (SourceFile _file, int _first_line = 0, int _first_column = 0, int _last_line = 0, int _last_column = 0) {
		file = _file;
		first_line = _first_line;
		first_column = _first_column;
		last_line = _last_line;
		last_column = _last_column;
	}
	
	/**
	 * Creates a new commented source reference.
	 *
	 * @param file         a source file
	 * @param first_line   first line number
	 * @param first_column first column number
	 * @param last_line    last line number
	 * @param last_column  last column number
	 * @param comment      code comment
	 * @return             newly created source reference
	 */
	public SourceReference.with_comment (SourceFile _file, int _first_line, int _first_column, int _last_line, int _last_column, string _comment) {
		file = _file;
		first_line = _first_line;
		first_column = _first_column;
		last_line = _last_line;
		last_column = _last_column;
		comment = _comment;
	}
	
	/**
	 * Returns a string representation of this source reference.
	 *
	 * @return human-readable string
	 */
	public string! to_string () {
		return ("%s:%d.%d-%d.%d".printf (file.filename, first_line, first_column, last_line, last_column));
	}
}
