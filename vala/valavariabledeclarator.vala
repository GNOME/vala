/* valavariabledeclarator.vala
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
 * Represents a variable declarator in the source code.
 */
public class Vala.VariableDeclarator : Symbol {
	/**
	 * The optional initializer expression.
	 */
	public Expression initializer {
		get {
			return _initializer;
		}
		set {
			_initializer = value;
			if (_initializer != null) {
				_initializer.parent_node = this;
			}
		}
	}
	
	/**
	 * The variable type.
	 */
	public DataType type_reference {
		get { return _data_type; }
		set {
			_data_type = value;
			_data_type.parent_node = this;
		}
	}

	private Expression _initializer;
	private DataType _data_type;

	/**
	 * Creates a new variable declarator.
	 *
	 * @param name   name of the variable
	 * @param init   optional initializer expression
	 * @param source reference to source code
	 * @return       newly created variable declarator
	 */
	public VariableDeclarator (string name, Expression initializer = null, SourceReference source_reference = null) {
		this.initializer = initializer;
		this.source_reference = source_reference;
		this.name = name;
	}
	
	public override void accept (CodeVisitor visitor) {
		visitor.visit_variable_declarator (this);
	}

	public override void accept_children (CodeVisitor visitor) {
		if (initializer != null) {
			initializer.accept (visitor);
		
			visitor.visit_end_full_expression (initializer);
		}
		
		if (type_reference != null) {
			type_reference.accept (visitor);
		}
	}

	public override void replace_expression (Expression old_node, Expression new_node) {
		if (initializer == old_node) {
			initializer = new_node;
		}
	}

	public override void replace_type (DataType old_type, DataType new_type) {
		if (type_reference == old_type) {
			type_reference = new_type;
		}
	}
}
