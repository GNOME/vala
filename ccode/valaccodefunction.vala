/* valaccodefunction.vala
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
using Gee;

/**
 * Represents a function declaration in the C code.
 */
public class Vala.CCodeFunction : CCodeNode {
	/**
	 * The name of this function.
	 */
	public string name { get; set; }
	
	/**
	 * The function modifiers.
	 */
	public CCodeModifiers modifiers { get; set; }
	
	/**
	 * The function return type.
	 */
	public string return_type { get; set; }

	/**
	 * The function body.
	 */
	public CCodeBlock block { get; set; }

	private Gee.List<CCodeFormalParameter> parameters = new ArrayList<CCodeFormalParameter> ();
	
	public CCodeFunction (string name, string return_type) {
		this.return_type = return_type;
		this.name = name;
	}
	
	/**
	 * Appends the specified parameter to the list of function parameters.
	 *
	 * @param param a formal parameter
	 */
	public void add_parameter (CCodeFormalParameter param) {
		parameters.add (param);
	}
	
	/**
	 * Returns a copy of this function.
	 *
	 * @return copied function
	 */
	public CCodeFunction copy () {
		var func = new CCodeFunction (name, return_type);
		func.modifiers = modifiers;

		/* no deep copy for lists available yet
		 * func.parameters = parameters.copy ();
		 */
		foreach (CCodeFormalParameter param in parameters) {
			func.parameters.add (param);
		}
		
		func.block = block;
		return func;
	}
	
	public override void write (CCodeWriter writer) {
		writer.write_indent (line);
		if (CCodeModifiers.STATIC in modifiers) {
			writer.write_string ("static ");
		}
		if (CCodeModifiers.INLINE in modifiers) {
			writer.write_string ("inline ");
		}
		writer.write_string (return_type);
		writer.write_string (" ");
		writer.write_string (name);
		writer.write_string (" (");
		
		bool first = true;
		foreach (CCodeFormalParameter param in parameters) {
			if (!first) {
				writer.write_string (", ");
			} else {
				first = false;
			}
			param.write (writer);
		}
		if (first) {
			writer.write_string ("void");
		}
		
		writer.write_string (")");
		if (block == null) {
			writer.write_string (";");
		} else {
			block.write (writer);
			writer.write_newline ();
		}
		writer.write_newline ();
	}
}
