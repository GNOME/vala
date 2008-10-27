/* valablock.vala
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
using Gee;

/**
 * Represents a source code block.
 */
public class Vala.Block : Symbol, Statement {
	/**
	 * Specifies whether this block contains a jump statement. This
	 * information can be used to remove unreachable block cleanup code.
	 */
	public bool contains_jump_statement { get; set; }

	private Gee.List<Statement> statement_list = new ArrayList<Statement> ();
	private Gee.List<LocalVariable> local_variables = new ArrayList<LocalVariable> ();
	
	/**
	 * Creates a new block.
	 *
	 * @param source reference to source code
	 */
	public Block (SourceReference source_reference) {
		base (null, source_reference);
	}
	
	/**
	 * Append a statement to this block.
	 *
	 * @param stmt a statement
	 */
	public void add_statement (Statement stmt) {
		statement_list.add (stmt);
	}
	
	/**
	 * Returns a copy of the list of statements.
	 *
	 * @return statement list
	 */
	public Gee.List<Statement> get_statements () {
		return new ReadOnlyList<Statement> (statement_list);
	}
	
	/**
	 * Add a local variable to this block.
	 *
	 * @param decl a variable declarator
	 */
	public void add_local_variable (LocalVariable local) {
		local_variables.add (local);
	}
	
	/**
	 * Returns a copy of the list of local variables.
	 *
	 * @return variable declarator list
	 */
	public Gee.List<LocalVariable> get_local_variables () {
		return new ReadOnlyList<LocalVariable> (local_variables);
	}

	public override void accept (CodeVisitor visitor) {
		visitor.visit_block (this);
	}

	public override void accept_children (CodeVisitor visitor) {
		foreach (Statement stmt in statement_list) {
			stmt.accept (visitor);
		}
	}
}
