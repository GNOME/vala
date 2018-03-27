/* valaccodeincludedirective.vala
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
 * Represents an include preprocessor directive in the C code.
 */
public class Vala.CCodeIncludeDirective : CCodeNode {
	/**
	 * The file to be included.
	 */
	public string filename { get; set; }

	/**
	 * Specifies whether the specified file should be searched in the local
	 * directory.
	 */
	public bool local { get; set; }

	public CCodeIncludeDirective (string _filename, bool _local = false) {
		filename = _filename;
		local = _local;
	}

	public override void write (CCodeWriter writer) {
		writer.write_indent ();
		writer.write_string ("#include ");
		if (local) {
			writer.write_string ("\"");
			writer.write_string (filename);
			writer.write_string ("\"");
		} else {
			writer.write_string ("<");
			writer.write_string (filename);
			writer.write_string (">");
		}
		writer.write_newline ();
	}
}
