/* valaforeachstatement.vala
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
 * Represents a foreach statement in the source code. Foreach statements iterate
 * over the elements of a collection.
 */
public class Vala.ForeachStatement : Block {
	/**
	 * Specifies the element type.
	 */
	public DataType type_reference {
		get { return _data_type; }
		set {
			_data_type = value;
			_data_type.parent_node = this;
		}
	}
	
	/**
	 * Specifies the element variable name.
	 */
	public string variable_name { get; set construct; }
	
	/**
	 * Specifies the container.
	 */
	public Expression collection {
		get {
			return _collection;
		}
		set construct {
			_collection = value;
			_collection.parent_node = this;
		}
	}
	
	/**
	 * Specifies the loop body.
	 */
	public Block body {
		get {
			return _body;
		}
		set {
			_body = value;
			_body.parent_node = this;
		}
	}

	/**
	 * Specifies the declarator for the generated element variable.
	 */
	public VariableDeclarator variable_declarator { get; set; }

	/**
	 * Specifies the declarator for the generated collection variable.
	 */
	public VariableDeclarator collection_variable_declarator { get; set; }

	/**
	 * Specifies the declarator for the generated iterator variable.
	 */
	public VariableDeclarator iterator_variable_declarator { get; set; }

	private Expression _collection;
	private Block _body;

	private DataType _data_type;

	/**
	 * Creates a new foreach statement.
	 *
	 * @param type   element type
	 * @param id     element variable name
	 * @param col    loop body
	 * @param source reference to source code
	 * @return       newly created foreach statement
	 */
	public ForeachStatement (construct DataType type_reference, construct string variable_name, construct Expression collection, construct Block body, construct SourceReference source_reference) {
	}
	
	public override void accept (CodeVisitor visitor) {
		visitor.visit_foreach_statement (this);
	}

	public override void accept_children (CodeVisitor visitor) {
		type_reference.accept (visitor);

		collection.accept (visitor);
		visitor.visit_end_full_expression (collection);

		body.accept (visitor);
	}

	public override void replace_expression (Expression old_node, Expression new_node) {
		if (collection == old_node) {
			collection = new_node;
		}
	}

	public override void replace_type (DataType old_type, DataType new_type) {
		if (type_reference == old_type) {
			type_reference = new_type;
		}
	}
}
