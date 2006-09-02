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

/**
 * Represents a local variable declaration in the source code.
 */
public class Vala.LocalVariableDeclaration : CodeNode {
	/**
	 * The type of the local variable.
	 */
	public TypeReference type_reference { get; set; }

	private List<VariableDeclarator> variable_declarators;
	
	/**
	 * Creates a new local variable declaration.
	 *
	 * @param type   type of the variable
	 * @param source reference to source code
	 * @return       newly created local variable declaration
	 */
	public construct (TypeReference type, SourceReference source) {
		type_reference = type;
		source_reference = source;
	}
	
	/**
	 * Creates a new implicitly typed local variable declaration. The type
	 * of the variable is inferred from the expression used to initialize
	 * the variable.
	 *
	 * @param source reference to source code
	 * @return       newly created local variable declaration
	 */
	public construct var_type (SourceReference source) {
		source_reference = source;
	}
	
	/**
	 * Add the specified variable declarator to this local variable
	 * declaration.
	 *
	 * @param declarator a variable declarator
	 */
	public void add_declarator (VariableDeclarator! declarator) {
		variable_declarators.append (declarator);
	}
	
	/**
	 * Returns a copy of the list of variable declarators.
	 *
	 * @return variable declarator list
	 */
	public ref List<weak VariableDeclarator> get_variable_declarators () {
		return variable_declarators.copy ();
	}
	
	public override void accept (CodeVisitor! visitor) {
		if (type_reference != null) {
			type_reference.accept (visitor);
		}
		
		foreach (VariableDeclarator decl in variable_declarators) {
			decl.accept (visitor);
		}
	
		visitor.visit_local_variable_declaration (this);
	}
}
