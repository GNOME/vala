/* valacfgbuilder.vala
 *
 * Copyright (C) 2008  Jürg Billeter
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
 * Code visitor building the control flow graph.
 */
public class Vala.CFGBuilder : CodeVisitor {
	private CodeContext context;
	private BasicBlock current_block;
	private bool unreachable_reported;
	private Method current_method;
	private Gee.List<BasicBlock> breakable_stack = new ArrayList<BasicBlock> ();
	private Gee.List<BasicBlock> continuable_stack = new ArrayList<BasicBlock> ();

	public CFGBuilder () {
	}

	/**
	 * Build control flow graph in the specified context.
	 *
	 * @param context a code context
	 */
	public void build_cfg (CodeContext! context) {
		this.context = context;

		/* we're only interested in non-pkg source files */
		var source_files = context.get_source_files ();
		foreach (SourceFile file in source_files) {
			if (!file.pkg) {
				file.accept (this);
			}
		}
	}

	public override void visit_source_file (SourceFile! source_file) {
		source_file.accept_children (this);
	}

	public override void visit_class (Class! cl) {
		cl.accept_children (this);
	}

	public override void visit_struct (Struct! st) {
		st.accept_children (this);
	}

	public override void visit_interface (Interface! iface) {
		iface.accept_children (this);
	}

	public override void visit_enum (Enum! en) {
		en.accept_children (this);
	}

	public override void visit_method (Method! m) {
		if (m.body == null) {
			return;
		}

		var old_method = current_method;
		current_method = m;

		m.entry_block = new BasicBlock.entry ();
		m.exit_block = new BasicBlock.exit ();

		current_block = new BasicBlock ();
		m.entry_block.connect (current_block);

		m.accept_children (this);

		if (current_block != null) {
			// end of method body reachable

			if (!(m.return_type is VoidType)) {
				Report.error (m.source_reference, "missing return statement at end of method body");
				m.error = true;
			}

			current_block.connect (m.exit_block);
		}

		current_method = old_method;
	}

	public override void visit_block (Block! b) {
		b.accept_children (this);
	}

	public override void visit_declaration_statement (DeclarationStatement! stmt) {
		if (unreachable (stmt)) {
			return;
		}

		current_block.add_node (stmt);
	}

	public override void visit_expression_statement (ExpressionStatement! stmt) {
		if (unreachable (stmt)) {
			return;
		}

		current_block.add_node (stmt);
	}

	public override void visit_if_statement (IfStatement! stmt) {
		if (unreachable (stmt)) {
			return;
		}

		// condition
		current_block.add_node (stmt.condition);

		// true block
		var last_block = current_block;
		current_block = new BasicBlock ();
		last_block.connect (current_block);
		stmt.true_statement.accept (this);

		// false block
		var last_true_block = current_block;
		current_block = new BasicBlock ();
		last_block.connect (current_block);
		if (stmt.false_statement != null) {
			stmt.false_statement.accept (this);
		}

		// after if/else
		var last_false_block = current_block;
		// reachable?
		if (last_true_block != null || last_false_block != null) {
			current_block = new BasicBlock ();
			if (last_true_block != null) {
				last_true_block.connect (current_block);
			}
			if (last_false_block != null) {
				last_false_block.connect (current_block);
			}
		}
	}

	public override void visit_while_statement (WhileStatement! stmt) {
		if (unreachable (stmt)) {
			return;
		}

		var condition_block = new BasicBlock ();
		continuable_stack.add (condition_block);
		var after_loop_block = new BasicBlock ();
		breakable_stack.add (after_loop_block);

		// condition
		var last_block = current_block;
		last_block.connect (condition_block);
		condition_block.add_node (stmt.condition);

		// loop block
		current_block = new BasicBlock ();
		condition_block.connect (current_block);
		stmt.body.accept (this);
		// end of loop block reachable?
		if (current_block != null) {
			current_block.connect (condition_block);
		}

		// after loop
		condition_block.connect (after_loop_block);
		current_block = after_loop_block;

		continuable_stack.remove_at (continuable_stack.size - 1);
		breakable_stack.remove_at (breakable_stack.size - 1);
	}

	public override void visit_do_statement (DoStatement! stmt) {
		if (unreachable (stmt)) {
			return;
		}

		var condition_block = new BasicBlock ();
		continuable_stack.add (condition_block);
		var after_loop_block = new BasicBlock ();
		breakable_stack.add (after_loop_block);

		// loop block
		var last_block = current_block;
		var loop_block = new BasicBlock ();
		last_block.connect (loop_block);
		current_block = loop_block;
		stmt.body.accept (this);

		// condition
		// reachable?
		if (current_block != null || condition_block.get_predecessors ().size > 0) {
			if (current_block != null) {
				last_block = current_block;
				last_block.connect (condition_block);
			}
			condition_block.add_node (stmt.condition);
			condition_block.connect (loop_block);
			current_block = condition_block;
		}

		// after loop
		// reachable?
		if (current_block != null || after_loop_block.get_predecessors ().size > 0) {
			if (current_block != null) {
				last_block = current_block;
				last_block.connect (after_loop_block);
			}
			current_block = after_loop_block;
		}

		continuable_stack.remove_at (continuable_stack.size - 1);
		breakable_stack.remove_at (breakable_stack.size - 1);
	}

	public override void visit_for_statement (ForStatement! stmt) {
		if (unreachable (stmt)) {
			return;
		}

		// initializer
		foreach (Expression init_expr in stmt.get_initializer ()) {
			current_block.add_node (init_expr);
		}

		var iterator_block = new BasicBlock ();
		continuable_stack.add (iterator_block);
		var after_loop_block = new BasicBlock ();
		breakable_stack.add (after_loop_block);

		// condition
		var condition_block = new BasicBlock ();
		current_block.connect (condition_block);
		condition_block.add_node (stmt.condition);

		// loop block
		current_block = new BasicBlock ();
		condition_block.connect (current_block);
		stmt.body.accept (this);

		// iterator
		// reachable?
		if (current_block != null || iterator_block.get_predecessors ().size > 0) {
			if (current_block != null) {
				current_block.connect (iterator_block);
			}
			foreach (Expression it_expr in stmt.get_iterator ()) {
				iterator_block.add_node (it_expr);
			}
			iterator_block.connect (condition_block);
		}

		// after loop
		condition_block.connect (after_loop_block);
		current_block = after_loop_block;

		continuable_stack.remove_at (continuable_stack.size - 1);
		breakable_stack.remove_at (breakable_stack.size - 1);
	}

	public override void visit_foreach_statement (ForeachStatement! stmt) {
		if (unreachable (stmt)) {
			return;
		}

		var loop_block = new BasicBlock ();
		continuable_stack.add (loop_block);
		var after_loop_block = new BasicBlock ();
		breakable_stack.add (after_loop_block);

		// loop block
		var last_block = current_block;
		last_block.connect (loop_block);
		current_block = loop_block;
		stmt.body.accept (this);
		if (current_block != null) {
			current_block.connect (loop_block);
		}

		// after loop
		last_block.connect (after_loop_block);
		if (current_block != null) {
			current_block.connect (after_loop_block);
		}
		current_block = after_loop_block;

		continuable_stack.remove_at (continuable_stack.size - 1);
		breakable_stack.remove_at (breakable_stack.size - 1);
	}

	public override void visit_break_statement (BreakStatement! stmt) {
		if (unreachable (stmt)) {
			return;
		}

		current_block.add_node (stmt);
		current_block.connect (top_breakable ());
		current_block = null;
		unreachable_reported = false;
	}

	public override void visit_continue_statement (ContinueStatement! stmt) {
		if (unreachable (stmt)) {
			return;
		}

		current_block.add_node (stmt);
		current_block.connect (top_continuable ());
		current_block = null;
		unreachable_reported = false;
	}

	public override void visit_return_statement (ReturnStatement! stmt) {
		if (unreachable (stmt)) {
			return;
		}

		current_block.add_node (stmt);
		current_block.connect (current_method.exit_block);
		current_block = null;
		unreachable_reported = false;
	}

	public override void visit_throw_statement (ThrowStatement! stmt) {
		if (unreachable (stmt)) {
			return;
		}

		current_block.add_node (stmt);
		// TODO connect to catch blocks instead of exit block if appropriate
		current_block.connect (current_method.exit_block);
		current_block = null;
		unreachable_reported = false;
	}

	public override void visit_try_statement (TryStatement! stmt) {
		if (unreachable (stmt)) {
			return;
		}

		stmt.body.accept (this);

		// TODO exceptional control flow
	}

	public override void visit_lock_statement (LockStatement! stmt) {
		if (unreachable (stmt)) {
			return;
		}

		stmt.body.accept (this);
	}

	private bool unreachable (CodeNode node) {
		if (current_block == null) {
			if (!unreachable_reported) {
				Report.warning (node.source_reference, "unreachable code detected");
				unreachable_reported = true;
			}
			return true;
		}

		return false;
	}

	private BasicBlock top_breakable () {
		return breakable_stack.get (breakable_stack.size - 1);
	}

	private BasicBlock top_continuable () {
		return continuable_stack.get (continuable_stack.size - 1);
	}
}
