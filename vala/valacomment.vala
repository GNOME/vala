/* valacomment.vala
 *
 * Copyright (C) 2008-2009  Florian Brosch
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
 * 	Florian Brosch <flo.brosch@gmail.com>
 */

using GLib;

/**
 * A documentation comment used by valadoc
 */
public class Vala.Comment {
	public Comment (string comment, SourceReference _source_reference) {
		source_reference = _source_reference;
		content = comment;
	}

	/**
	 * The text describing the referenced source code.
	 */
	public string content { set; get; }

	/**
	 * References the location in the source file where this code node has
	 * been written.
	 */
	public SourceReference source_reference { get; set; }
}

