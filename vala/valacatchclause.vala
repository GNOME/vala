/* valacatchclause.vala
 *
 * Copyright (C) 2007-2008  Jürg Billeter
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
 * Represents a catch clause in a try statement in the source code.
 */
public class Vala.CatchClause : CodeNode {
	/**
	 * Specifies the error type.
	 */
	public DataType? type_reference {
		get { return _data_type; }
		set {
			_data_type = value;
			if (_data_type != null) {
				_data_type.parent_node = this;
			}
		}
	}
	
	/**
	 * Specifies the error variable name.
	 */
	public string variable_name { get; set; }
	
	/**
	 * Specifies the error handler body.
	 */
	public Block body { get; set; }
	
	/**
	 * Specifies the declarator for the generated error variable.
	 */
	public VariableDeclarator variable_declarator { get; set; }

	private DataType _data_type;

	/**
	 * Creates a new catch clause.
	 *
	 * @param type_reference   error type
	 * @param variable_name    error variable name
	 * @param body             error handler body
	 * @param source_reference reference to source code
	 * @return                 newly created catch clause
	 */
	public CatchClause (DataType? type_reference, string variable_name, Block body, SourceReference? source_reference = null) {
		this.type_reference = type_reference;
		this.variable_name = variable_name;
		this.body = body;
		this.source_reference = source_reference;
	}

	public override void accept (CodeVisitor visitor) {
		visitor.visit_catch_clause (this);
	}

	public override void accept_children (CodeVisitor visitor) {
		if (type_reference != null) {
			type_reference.accept (visitor);
		}

		body.accept (visitor);
	}

	public override void replace_type (DataType old_type, DataType new_type) {
		if (type_reference == old_type) {
			type_reference = new_type;
		}
	}
}
