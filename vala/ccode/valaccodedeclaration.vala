/* valaccodedeclaration.vala
 *
 * Copyright (C) 2006  Jürg Billeter
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

namespace Vala {
	public class CCodeDeclaration : CCodeStatement {
		public string type_name { get; construct; }
		public CCodeModifiers modifiers;
		List<CCodeDeclarator> declarators;
		
		public void add_declarator (CCodeDeclarator! decl) {
			declarators.append (decl);
		}
		
		public override void write (CCodeWriter! writer) {
			writer.write_indent ();
			if ((modifiers & CCodeModifiers.STATIC) == CCodeModifiers.STATIC) {
				writer.write_string ("static ");
			}
			writer.write_string (type_name);
			writer.write_string (" ");
		
			bool first = true;
			foreach (CCodeDeclarator decl in declarators) {
				if (!first) {
					writer.write_string (", ");
				} else {
					first = false;
				}
				decl.write (writer);
			}

			writer.write_string (";");
			writer.write_newline ();
		}
	}
}
