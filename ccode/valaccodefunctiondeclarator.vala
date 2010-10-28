/* valaccodefunctiondeclarator.vala
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
 * Represents a function pointer declarator in the C code.
 */
public class Vala.CCodeFunctionDeclarator : CCodeDeclarator {
	/**
	 * The declarator name.
	 */
	public string name { get; set; }
	
	private List<CCodeParameter> parameters = new ArrayList<CCodeParameter> ();
	
	public CCodeFunctionDeclarator (string name) {
		this.name = name;
	}
	
	/**
	 * Appends the specified parameter to the list of function parameters.
	 *
	 * @param param a formal parameter
	 */
	public void add_parameter (CCodeParameter param) {
		parameters.add (param);
	}
	
	public override void write (CCodeWriter writer) {
		write_declaration (writer);
	}
	
	public override void write_declaration (CCodeWriter writer) {
		writer.write_string ("(*");
		writer.write_string (name);
		writer.write_string (") (");
		
		bool first = true;
		foreach (CCodeParameter param in parameters) {
			if (!first) {
				writer.write_string (", ");
			} else {
				first = false;
			}
			param.write (writer);
		}
		
		writer.write_string (")");
	}
}
