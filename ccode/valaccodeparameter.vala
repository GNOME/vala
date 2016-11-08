/* valaccodeparameter.vala
 *
 * Copyright (C) 2006-2008  Jürg Billeter
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
 * Represents a formal parameter in a C method signature.
 */
public class Vala.CCodeParameter : CCodeNode {
	/**
	 * The parameter name.
	 */
	public string name { get; set; }
	
	/**
	 * The parameter type.
	 */
	public string type_name { get; set; }

	/**
	 * Specifies whether the function accepts an indefinite number of
	 * arguments.
	 */
	public bool ellipsis { get; set; }

	public CCodeParameter (string n, string type) {
		name = n;
		type_name = type;
	}

	public CCodeParameter.with_ellipsis () {
		ellipsis = true;
	}

	public override void write (CCodeWriter writer) {
		if (!ellipsis) {
			writer.write_string (type_name);
			writer.write_string (" ");
			writer.write_string (name);
		} else {
			writer.write_string ("...");
		}
	}
}
