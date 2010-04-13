/* valaccodedeclarationspace.vala
 *
 * Copyright (C) 2009  Jürg Billeter
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


public class Vala.CCodeDeclarationSpace {
	public bool is_header { get; set; }

	Set<string> declarations = new HashSet<string> (str_hash, str_equal);
	Set<string> includes = new HashSet<string> (str_hash, str_equal);
	internal CCodeFragment include_directives = new CCodeFragment ();
	internal CCodeFragment type_declaration = new CCodeFragment ();
	internal CCodeFragment type_definition = new CCodeFragment ();
	internal CCodeFragment type_member_declaration = new CCodeFragment ();
	internal CCodeFragment constant_declaration = new CCodeFragment ();

	public bool add_declaration (string name) {
		if (name in declarations) {
			return true;
		}
		declarations.add (name);
		return false;
	}

	public bool add_symbol_declaration (Symbol sym, string name) {
		if (add_declaration (name)) {
			return true;
		}
		if (sym.external_package || (!is_header && CodeContext.get ().use_header && !sym.is_internal_symbol ())) {
			// add appropriate include file
			foreach (string header_filename in sym.get_cheader_filenames ()) {
				add_include (header_filename, !sym.external_package);
			}
			// declaration complete
			return true;
		} else {
			// require declaration
			return false;
		}
	}

	public void add_include (string filename, bool local = false) {
		if (!(filename in includes)) {
			include_directives.append (new CCodeIncludeDirective (filename, local));
			includes.add (filename);
		}
	}

	public void add_type_declaration (CCodeNode node) {
		type_declaration.append (node);
	}

	public void add_type_definition (CCodeNode node) {
		type_definition.append (node);
	}

	public void add_type_member_declaration (CCodeNode node) {
		type_member_declaration.append (node);
	}

	public void add_constant_declaration (CCodeNode node) {
		constant_declaration.append (node);
	}
}

