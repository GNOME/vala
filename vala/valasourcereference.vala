/* valasourcereference.vala
 *
 * Copyright (C) 2006-2012  Jürg Billeter
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
public class Vala.SourceReference {
	/**
	 * The source file to be referenced.
	 */
	public weak SourceFile file { get; set; }

	/**
	 * The begin of the referenced source code.
	 */
	public SourceLocation begin { get; set; }

	/**
	 * The end of the referenced source code.
	 */
	public SourceLocation end { get; set; }

	public List<UsingDirective> using_directives { get; private set; }

	/**
	 * Creates a new source reference.
	 *
	 * @param _file        a source file
	 * @param begin        the begin of the referenced source code
	 * @param end          the end of the referenced source code
	 * @return             newly created source reference
	 */
	public SourceReference (SourceFile _file, SourceLocation begin, SourceLocation end) {
		file = _file;
		this.begin = begin;
		this.end = end;
		using_directives = file.current_using_directives;
	}

	/**
	 * Checks if given source location is part of this source reference.
	 *
	 * @param location     a source location
	 * @return             whether this source location is part of this
	 */
	public bool contains (SourceLocation location) {
		if (location.line > begin.line && location.line < end.line) {
			return true;
		} else if (location.line == begin.line && location.line == end.line) {
			return location.column >= begin.column && location.column <= end.column;
		} else if (location.line == begin.line) {
			return location.column >= begin.column;
		} else if (location.line == end.line) {
			return location.column <= end.column;
		} else {
			return false;
		}
	}

	/**
	 * Returns a string representation of this source reference.
	 *
	 * @return human-readable string
	 */
	public string to_string () {
		return ("%s:%d:%d-%d:%d".printf (file.get_relative_filename (), begin.line, begin.column, end.line, end.column));
	}
}
