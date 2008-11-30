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

	public void insert_statement (int index, Statement stmt) {
		statement_list.insert (index, stmt);
	}

	/**
	 * Returns a copy of the list of statements.
	 *
	 * @return statement list
	 */
	public Gee.List<Statement> get_statements () {
		var list = new ArrayList<Statement> ();
		foreach (Statement stmt in statement_list) {
			var stmt_list = stmt as StatementList;
			if (stmt_list != null) {
				for (int i = 0; i < stmt_list.length; i++) {
					list.add (stmt_list.get (i));
				}
			} else {
				list.add (stmt);
			}
		}
		return list;
	}
	
	/**
	 * Add a local variable to this block.
	 *
	 * @param decl a variable declarator
	 */
	public void add_local_variable (LocalVariable local) {
		local_variables.add (local);
	}

	public void remove_local_variable (LocalVariable local) {
		local_variables.remove (local);
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

	public override bool check (SemanticAnalyzer analyzer) {
		if (checked) {
			return !error;
		}

		checked = true;

		owner = analyzer.current_symbol.scope;

		var old_symbol = analyzer.current_symbol;
		var old_insert_block = analyzer.insert_block;
		analyzer.current_symbol = this;
		analyzer.insert_block = this;

		for (int i = 0; i < statement_list.size; i++) {
			statement_list[i].check (analyzer);
		}

		foreach (LocalVariable local in get_local_variables ()) {
			local.active = false;
		}

		foreach (Statement stmt in statement_list) {
			add_error_types (stmt.get_error_types ());
		}

		analyzer.current_symbol = old_symbol;
		analyzer.insert_block = old_insert_block;

		return !error;
	}

	public void insert_before (Statement stmt, Statement new_stmt) {
		for (int i = 0; i < statement_list.size; i++) {
			var stmt_list = statement_list[i] as StatementList;
			if (stmt_list != null) {
				for (int j = 0; j < stmt_list.length; j++) {
					if (stmt_list.get (j) == stmt) {
						stmt_list.insert (j, new_stmt);
						break;
					}
				}
			} else if (statement_list[i] == stmt) {
				stmt_list = new StatementList (source_reference);
				stmt_list.add (new_stmt);
				stmt_list.add (stmt);
				statement_list[i] = stmt_list;
			}
		}
	}

	public void replace_statement (Statement old_stmt, Statement new_stmt) {
		for (int i = 0; i < statement_list.size; i++) {
			var stmt_list = statement_list[i] as StatementList;
			if (stmt_list != null) {
				for (int j = 0; j < stmt_list.length; j++) {
					if (stmt_list.get (j) == old_stmt) {
						stmt_list.set (j, new_stmt);
						break;
					}
				}
			} else if (statement_list[i] == old_stmt) {
				statement_list[i] = new_stmt;
				break;
			}
		}
	}
}
