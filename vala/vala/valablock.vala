/* valablock.vala
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
 * Represents a source code block.
 */
public class Vala.Block : Statement {
	/**
	 * Specifies whether this block contains a jump statement. This
	 * information can be used to remove unreachable block cleanup code.
	 */
	public bool contains_jump_statement { get; set; }

	private List<Statement> statement_list;
	private List<VariableDeclarator> local_variables;
	
	/**
	 * Creates a new block.
	 *
	 * @param source reference to source code
	 */
	public construct (SourceReference source = null) {
		source_reference = source;
	}
	
	/**
	 * Append a statement to this block.
	 *
	 * @param stmt a statement
	 */
	public void add_statement (Statement! stmt) {
		statement_list.append (stmt);
	}
	
	/**
	 * Returns a copy of the list of statements.
	 *
	 * @return statement list
	 */
	public ref List<Statement> get_statements () {
		return statement_list.copy ();
	}
	
	/**
	 * Add a local variable to this block.
	 *
	 * @param decl a variable declarator
	 */
	public void add_local_variable (VariableDeclarator! decl) {
		local_variables.append (decl);
	}
	
	/**
	 * Returns a copy of the list of local variables.
	 *
	 * @return variable declarator list
	 */
	public ref List<VariableDeclarator> get_local_variables () {
		return local_variables.copy ();
	}
	
	public override void accept (CodeVisitor! visitor) {
		visitor.visit_begin_block (this);

		foreach (Statement! stmt in statement_list) {
			stmt.accept (visitor);
		}

		visitor.visit_end_block (this);
	}
}
