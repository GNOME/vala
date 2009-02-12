/* valaccodelinedirective.vala
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
 * Represents a line directive in the C code.
 */
public class Vala.CCodeLineDirective : CCodeNode {
	/**
	 * The name of the source file to be presumed.
	 */
	public string filename { get; set; }
	
	/**
	 * The line number in the source file to be presumed.
	 */
	public int line_number { get; set; }
	
	public CCodeLineDirective (string _filename, int _line) {
		filename = _filename;
		line_number = _line;
	}

	public override void write (CCodeWriter writer) {
		if (!writer.bol) {
			writer.write_newline ();
		}
		writer.write_string ("#line %d \"%s\"".printf (line_number, filename));
		writer.write_newline ();
	}
}
