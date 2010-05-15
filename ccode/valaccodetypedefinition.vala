/* valaccodetypedefinition.vala
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
 * Represents a typedef in the C code.
 */
public class Vala.CCodeTypeDefinition : CCodeNode {
	/**
	 * The type name.
	 */
	public string type_name { get; set; }
	
	/**
	 * The type declarator.
	 */
	public CCodeDeclarator declarator { get; set; }

	/**
	 * Whether the type is deprecated.
	 */
	public bool deprecated { get; set; default = false; }
	
	public CCodeTypeDefinition (string type, CCodeDeclarator decl) {
		type_name = type;
		declarator = decl;
	}
	
	public override void write (CCodeWriter writer) {
	}
	
	public override void write_declaration (CCodeWriter writer) {
		writer.write_indent ();
		writer.write_string ("typedef ");
		
		writer.write_string (type_name);
		
		writer.write_string (" ");
		
		declarator.write_declaration (writer);

		if (deprecated) {
			writer.write_string (" G_GNUC_DEPRECATED");
		}

		writer.write_string (";");
		writer.write_newline ();
	}
}
