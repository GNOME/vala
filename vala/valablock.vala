/* valablock.vala
 *
 * Copyright (C) 2006-2010  Jürg Billeter
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
 * Represents a source code block.
 */
public class Vala.Block : Symbol, Statement {
	/**
	 * Specifies whether this block contains a jump statement. This
	 * information can be used to remove unreachable block cleanup code.
	 */
	public bool contains_jump_statement { get; set; }

	public bool captured { get; set; }

	public Statement first_statement { get; private set; }

	public Statement prev { get; set; }

	public Statement next { get; set; }

	private Statement last_statement;

	private List<LocalVariable> local_variables = new ArrayList<LocalVariable> ();
	private List<Constant> local_constants = new ArrayList<Constant> ();

	/**
	 * Creates a new block.
	 *
	 * @param source_reference  reference to source code
	 */
	public Block (SourceReference? source_reference) {
		base (null, source_reference);
	}

	/**
	 * Append a statement to this block.
	 *
	 * @param stmt a statement
	 */
	public void add_statement (Statement stmt) {
		stmt.parent_node = this;
		if (last_statement == null) {
			first_statement = last_statement = stmt;
		} else {
			last_statement.next = stmt;
			stmt.prev = last_statement;
			last_statement = stmt;
		}
	}

	public void insert_statement (int index, Statement stmt) {
		Statement iter = first_statement;
		while (iter != null && index > 0) {
			index--;
			iter = iter.next;
		}
		if (iter == null) {
			add_statement (stmt);
		} else {
			insert_before (iter, stmt);
		}
	}

	/**
	 * Add a local variable to this block.
	 *
	 * @param local a variable declarator
	 */
	public void add_local_variable (LocalVariable local) {
		unowned Symbol? parent_block = parent_symbol;
		while (parent_block is Block || parent_block is Method || parent_block is PropertyAccessor) {
			if (parent_block.scope.lookup (local.name) != null) {
				Report.error (local.source_reference, "Local variable `%s' conflicts with a local variable or constant declared in a parent scope".printf (local.name));
				break;
			}
			parent_block = parent_block.parent_symbol;
		}
		local_variables.add (local);
		scope.add (local.name, local);
	}

	public void remove_local_variable (LocalVariable local) {
		local_variables.remove (local);
		scope.remove (local.name);
	}

	/**
	 * Returns the list of local variables.
	 *
	 * @return variable declarator list
	 */
	public unowned List<LocalVariable> get_local_variables () {
		return local_variables;
	}

	public void add_local_constant (Constant constant) {
		unowned Symbol? parent_block = parent_symbol;
		while (parent_block is Block || parent_block is Method || parent_block is PropertyAccessor) {
			if (parent_block.scope.lookup (constant.name) != null) {
				Report.error (constant.source_reference, "Local constant `%s' conflicts with a local variable or constant declared in a parent scope".printf (constant.name));
				break;
			}
			parent_block = parent_block.parent_symbol;
		}
		local_constants.add (constant);
		scope.add (constant.name, constant);
	}

	/**
	 * Returns the list of local constants.
	 *
	 * @return constants list
	 */
	public unowned List<Constant> get_local_constants () {
		return local_constants;
	}

	public override void accept (CodeVisitor visitor) {
		visitor.visit_block (this);
	}

	public override void accept_children (CodeVisitor visitor) {
		foreach (Statement stmt in this) {
			stmt.accept (visitor);
		}
	}

	public override bool check (CodeContext context) {
		if (checked) {
			return !error;
		}

		checked = true;

		owner = context.analyzer.get_current_non_local_symbol (parent_node).scope;

		foreach (Statement stmt in this) {
			if (!stmt.check (context)) {
				error = true;
			}
		}

		foreach (LocalVariable local in get_local_variables ()) {
			local.active = false;
		}

		foreach (Constant constant in local_constants) {
			constant.active = false;
		}

		return !error;
	}

	public override void get_error_types (Collection<DataType> collection, SourceReference? source_reference = null) {
		// use get_statements () instead of statement_list to not miss errors within StatementList objects
		foreach (Statement stmt in this) {
			stmt.get_error_types (collection, source_reference);
		}
	}

	public override void emit (CodeGenerator codegen) {
		codegen.visit_block (this);
	}

	public void insert_before (Statement stmt, Statement new_stmt) {
		new_stmt.parent_node = this;
		new_stmt.prev = stmt.prev;
		new_stmt.next = stmt;

		if (stmt.prev == null) {
			first_statement = new_stmt;
		} else {
			stmt.prev.next = new_stmt;
		}
		stmt.prev = new_stmt;
	}

	public void remove_statement (Statement stmt) {
		var prev = stmt.prev;
		var next = stmt.next;

		if (prev != null) {
			prev.next = next;
		} else {
			first_statement = next;
		}

		if (next != null) {
			next.prev = prev;
		} else {
			last_statement = prev;
		}
	}

	public void replace_statement (Statement old_stmt, Statement new_stmt) {
		new_stmt.parent_node = this;
		new_stmt.prev = old_stmt.prev;
		new_stmt.next = old_stmt.next;

		if (old_stmt.prev == null) {
			first_statement = new_stmt;
		} else {
			old_stmt.prev.next = new_stmt;
		}

		if (old_stmt.next == null) {
			last_statement = new_stmt;
		} else {
			old_stmt.next.prev = new_stmt;
		}
	}

	public StatementIterator iterator () {
		return new StatementIterator (this);
	}
}

public class Vala.StatementIterator {
	private Block block;
	private Statement next;

	public StatementIterator (Block block) {
		this.block = block;
		this.next = block.first_statement;
	}

	public Statement? next_value () {
		var ret = next;
		if (ret != null) {
			next = ret.next;
		}
		return ret;
	}
}
