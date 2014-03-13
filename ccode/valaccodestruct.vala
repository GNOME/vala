/* valaccodestruct.vala
 *
 * Copyright (C) 2006-2010  Jürg Billeter
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
 * Represents a struct declaration in the C code.
 */
public class Vala.CCodeStruct : CCodeNode {
	/**
	 * The struct name.
	 */
	public string name { get; set; }

	/**
	 * Whether the struct is deprecated.
	 */
	public bool deprecated { get; set; default = false; }

	public bool is_empty { get { return declarations.size == 0; } }

	private List<CCodeDeclaration> declarations = new ArrayList<CCodeDeclaration> ();
	
	public CCodeStruct (string name) {
		this.name = name;
	}
	
	/**
	 * Adds the specified declaration as member to this struct.
	 *
	 * @param decl a variable declaration
	 */
	public void add_declaration (CCodeDeclaration decl) {
		declarations.add (decl);
	}
	
	/**
	 * Adds a variable with the specified type and name to this struct.
	 *
	 * @param type_name field type
	 * @param name      member name
	 */
	public void add_field (string type_name, string name, CCodeDeclaratorSuffix? declarator_suffix = null) {
		var decl = new CCodeDeclaration (type_name);
		decl.add_declarator (new CCodeVariableDeclarator (name, null, declarator_suffix));
		add_declaration (decl);
	}
	
	public override void write (CCodeWriter writer) {
		writer.write_string ("struct ");
		writer.write_string (name);
		writer.write_begin_block ();
		foreach (CCodeDeclaration decl in declarations) {
			decl.write_declaration (writer);
		}

		writer.write_end_block ();
		if (deprecated) {
			writer.write_string (" G_GNUC_DEPRECATED");
		}
		writer.write_string (";");
		writer.write_newline ();
		writer.write_newline ();
	}
}
