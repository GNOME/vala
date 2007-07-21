/* valaforeachstatement.vala
 *
 * Copyright (C) 2006-2007  Jürg Billeter
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
 * Represents a foreach statement in the source code. Foreach statements iterate
 * over the elements of a collection.
 */
public class Vala.ForeachStatement : CodeNode, Statement {
	/**
	 * Specifies the element type.
	 */
	public TypeReference! type_reference { get; set construct; }
	
	/**
	 * Specifies the element variable name.
	 */
	public string! variable_name { get; set construct; }
	
	/**
	 * Specifies the container.
	 */
	public Expression! collection {
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
	public Block body { get; set; }
	
	/**
	 * Specifies the declarator for the generated element variable.
	 */
	public VariableDeclarator variable_declarator { get; set; }

	private Expression! _collection;

	/**
	 * Creates a new foreach statement.
	 *
	 * @param type   element type
	 * @param id     element variable name
	 * @param col    loop body
	 * @param source reference to source code
	 * @return       newly created foreach statement
	 */
	public ForeachStatement (construct TypeReference! type_reference, construct string! variable_name, construct Expression! collection, construct Block body, construct SourceReference source_reference) {
	}
	
	public override void accept (CodeVisitor! visitor) {
		visitor.visit_begin_foreach_statement (this);

		type_reference.accept (visitor);

		collection.accept (visitor);
		visitor.visit_end_full_expression (collection);

		body.accept (visitor);

		visitor.visit_end_foreach_statement (this);
	}

	public override void replace (CodeNode! old_node, CodeNode! new_node) {
		if (collection == old_node) {
			collection = (Expression) new_node;
		}
	}
}
