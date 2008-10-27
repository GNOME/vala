/* valalocalvariable.vala
 *
 * Copyright (C) 2006-2008  Jürg Billeter
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
 * Represents a local variable declaration in the source code.
 */
public class Vala.LocalVariable : Symbol {
	/**
	 * The optional initializer expression.
	 */
	public Expression? initializer {
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
	public DataType? variable_type {
		get { return _variable_type; }
		set {
			_variable_type = value;
			if (_variable_type != null) {
				_variable_type.parent_node = this;
			}
		}
	}

	private Expression? _initializer;
	private DataType? _variable_type;

	/**
	 * Creates a new local variable.
	 *
	 * @param name   name of the variable
	 * @param init   optional initializer expression
	 * @param source reference to source code
	 * @return       newly created variable declarator
	 */
	public LocalVariable (DataType? variable_type, string name, Expression? initializer = null, SourceReference? source_reference = null) {
		base (name, source_reference);
		this.variable_type = variable_type;
		this.initializer = initializer;
	}
	
	public override void accept (CodeVisitor visitor) {
		visitor.visit_local_variable (this);
	}

	public override void accept_children (CodeVisitor visitor) {
		if (initializer != null) {
			initializer.accept (visitor);
		
			visitor.visit_end_full_expression (initializer);
		}
		
		if (variable_type != null) {
			variable_type.accept (visitor);
		}
	}

	public override void replace_expression (Expression old_node, Expression new_node) {
		if (initializer == old_node) {
			initializer = new_node;
		}
	}

	public override void replace_type (DataType old_type, DataType new_type) {
		if (variable_type == old_type) {
			variable_type = new_type;
		}
	}
}
