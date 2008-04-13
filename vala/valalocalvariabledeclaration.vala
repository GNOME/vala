/* valalocalvariabledeclaration.vala
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
 * Represents a local variable declaration in the source code.
 */
public class Vala.LocalVariableDeclaration : CodeNode {
	/**
	 * The type of the local variable.
	 */
	public DataType type_reference {
		get { return _data_type; }
		set {
			_data_type = value;
			_data_type.parent_node = this;
		}
	}

	private DataType _data_type;

	private Gee.List<VariableDeclarator> variable_declarators = new ArrayList<VariableDeclarator> ();
	
	/**
	 * Creates a new local variable declaration.
	 *
	 * @param type_reference   type of the variable
	 * @param source_reference reference to source code
	 * @return                 newly created local variable declaration
	 */
	public LocalVariableDeclaration (construct DataType type_reference, construct SourceReference source_reference) {
	}
	
	/**
	 * Creates a new implicitly typed local variable declaration. The type
	 * of the variable is inferred from the expression used to initialize
	 * the variable.
	 *
	 * @param source_reference reference to source code
	 * @return                 newly created local variable declaration
	 */
	public LocalVariableDeclaration.var_type (construct SourceReference source_reference) {
	}
	
	/**
	 * Add the specified variable declarator to this local variable
	 * declaration.
	 *
	 * @param declarator a variable declarator
	 */
	public void add_declarator (VariableDeclarator declarator) {
		variable_declarators.add (declarator);
	}
	
	/**
	 * Returns a copy of the list of variable declarators.
	 *
	 * @return variable declarator list
	 */
	public Collection<VariableDeclarator> get_variable_declarators () {
		return new ReadOnlyCollection<VariableDeclarator> (variable_declarators);
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

	public override void replace_type (DataType old_type, DataType new_type) {
		if (type_reference == old_type) {
			type_reference = new_type;
		}
	}
}
