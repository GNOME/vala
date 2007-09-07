/* valacatchclause.vala
 *
 * Copyright (C) 2007  Jürg Billeter
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
	public TypeReference type_reference { get; set; }
	
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

	/**
	 * Creates a new catch clause.
	 *
	 * @param type_reference   error type
	 * @param variable_name    error variable name
	 * @param body             error handler body
	 * @param source_reference reference to source code
	 * @return                 newly created catch clause
	 */
	public CatchClause (construct TypeReference type_reference, construct string variable_name, construct Block body, construct SourceReference source_reference = null) {
	}

	public override void accept (CodeVisitor! visitor) {
		visitor.visit_catch_clause (this);
	}

	public override void accept_children (CodeVisitor! visitor) {
		type_reference.accept (visitor);
		body.accept (visitor);
	}
}
