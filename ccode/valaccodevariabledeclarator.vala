/* valaccodevariabledeclarator.vala
 *
 * Copyright (C) 2006-2007  Jürg Billeter
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public
 * License as published by the Free Software Foundation; either
 * version 2 of the License, or (at your option) any later version.

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
 * Represents a variable declarator in the C code.
 */
public class Vala.CCodeVariableDeclarator : CCodeDeclarator {
	/**
	 * The variable name.
	 */
	public string! name { get; set construct; }
	
	/**
	 * The optional initializer expression.
	 */
	public CCodeExpression initializer { get; set; }
	
	public CCodeVariableDeclarator (string! _name) {
		name = _name;
	}
	
	public CCodeVariableDeclarator.with_initializer (string! _name, CCodeExpression init) {
		name = _name;
		initializer = init;
	}

	public override void write (CCodeWriter! writer) {
		writer.write_string (name);

		if (initializer != null) {
			writer.write_string (" = ");
			initializer.write (writer);
		}
	}

	public override void write_declaration (CCodeWriter! writer) {
		writer.write_string (name);
	}

	public override void write_initialization (CCodeWriter! writer) {
		if (initializer != null) {
			writer.write_indent (line);

			writer.write_string (name);
			writer.write_string (" = ");
			initializer.write (writer);

			writer.write_string (";");
			writer.write_newline ();
		}
	}
}
