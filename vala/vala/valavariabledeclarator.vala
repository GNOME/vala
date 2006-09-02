/* valavariabledeclarator.vala
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
 * Represents a variable declarator in the source code.
 */
public class Vala.VariableDeclarator : CodeNode, Invokable {
	/**
	 * The variable name.
	 */
	public string! name { get; set construct; }
	
	/**
	 * The optional initializer expression.
	 */
	public Expression initializer { get; set; }
	
	/**
	 * The variable type.
	 */
	public TypeReference type_reference { get; set; }

	/**
	 * Creates a new variable declarator.
	 *
	 * @param name   name of the variable
	 * @param init   optional initializer expression
	 * @param source reference to source code
	 * @return       newly created variable declarator
	 */
	public construct (string! _name, Expression init = null, SourceReference source = null) {
		name = _name;
		initializer = init;
		source_reference = source;
	}
	
	public override void accept (CodeVisitor! visitor) {
		if (initializer != null) {
			initializer.accept (visitor);
		
			visitor.visit_end_full_expression (initializer);
		}
		
		if (type_reference != null) {
			type_reference.accept (visitor);
		}
	
		visitor.visit_variable_declarator (this);
	}

	public override ref List<weak FormalParameter> get_parameters () {
		if (!is_invokable ()) {
			return null;
		}
		
		var cb = (Callback) type_reference.data_type;
		return cb.get_parameters ();
	}
	
	public override TypeReference get_return_type () {
		if (!is_invokable ()) {
			return null;
		}
		
		var cb = (Callback) type_reference.data_type;
		return cb.return_type;
	}

	public override bool is_invokable () {
		return (type_reference.data_type is Callback);
	}
}
