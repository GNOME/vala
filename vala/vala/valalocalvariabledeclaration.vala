/* valalocalvariabledeclaration.vala
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
	public class LocalVariableDeclaration : CodeNode {
		public TypeReference type_reference { get; construct; }
		public List<VariableDeclarator> variable_declarators { get; construct; }
		
		public static ref LocalVariableDeclaration new (TypeReference type, List<VariableDeclarator> declarators, SourceReference source) {
			return (new LocalVariableDeclaration (type_reference = type, variable_declarators = declarators, source_reference = source));
		}
		
		public static ref LocalVariableDeclaration new_var (List<VariableDeclarator> declarators, SourceReference source) {
			return (new LocalVariableDeclaration (variable_declarators = declarators, source_reference = source));
		}
		
		public override void accept (CodeVisitor visitor) {
			if (type_reference != null) {
				type_reference.accept (visitor);
			}
			
			foreach (VariableDeclarator decl in variable_declarators) {
				decl.accept (visitor);
			}
		
			visitor.visit_local_variable_declaration (this);
		}
	}
}
