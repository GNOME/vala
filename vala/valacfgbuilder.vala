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
	private class JumpTarget : Object {
		public bool break_target { get; set; }
		public bool continue_target { get; set; }
		public bool return_target { get; set; }
		public bool error_target { get; set; }
		public Enum? error_domain { get; set; }
		public EnumValue? error_code { get; set; }
		public bool finally_clause { get; set; }
		public BasicBlock basic_block { get; set; }
		public BasicBlock? last_block { get; set; }
		public CatchClause? catch_clause { get; set; }

		public JumpTarget.break_target (construct BasicBlock basic_block) {
			break_target = true;
		}

		public JumpTarget.continue_target (construct BasicBlock basic_block) {
			continue_target = true;
		}

		public JumpTarget.return_target (construct BasicBlock basic_block) {
			return_target = true;
		}

		public JumpTarget.error_target (construct BasicBlock basic_block, construct CatchClause catch_clause, construct Enum? error_domain, construct EnumValue? error_code) {
			error_target = true;
		}

		public JumpTarget.finally_clause (construct BasicBlock basic_block, construct BasicBlock last_block) {
			finally_clause = true;
		}
	}

	private CodeContext context;
	private BasicBlock current_block;
	private bool unreachable_reported;
	private Gee.List<JumpTarget> jump_stack = new ArrayList<JumpTarget> ();

	public CFGBuilder () {
	}

	/**
	 * Build control flow graph in the specified context.
	 *
	 * @param context a code context
	 */
	public void build_cfg (CodeContext context) {
		this.context = context;

		/* we're only interested in non-pkg source files */
		var source_files = context.get_source_files ();
		foreach (SourceFile file in source_files) {
			if (!file.pkg) {
				file.accept (this);
			}
		}
	}

	public override void visit_source_file (SourceFile source_file) {
		source_file.accept_children (this);
	}

	public override void visit_class (Class cl) {
		cl.accept_children (this);
	}

	public override void visit_struct (Struct st) {
		st.accept_children (this);
	}

	public override void visit_interface (Interface iface) {
		iface.accept_children (this);
	}

	public override void visit_enum (Enum en) {
		en.accept_children (this);
	}

	public override void visit_method (Method m) {
		if (m.body == null) {
			return;
		}

		m.entry_block = new BasicBlock.entry ();
		m.exit_block = new BasicBlock.exit ();

		current_block = new BasicBlock ();
		m.entry_block.connect (current_block);

		jump_stack.add (new JumpTarget.return_target (m.exit_block));

		m.accept_children (this);

		jump_stack.remove_at (jump_stack.size - 1);

		if (current_block != null) {
			// end of method body reachable

			if (!(m.return_type is VoidType)) {
				Report.error (m.source_reference, "missing return statement at end of method body");
				m.error = true;
			}

			current_block.connect (m.exit_block);
		}
	}

	public override void visit_property (Property prop) {
		prop.accept_children (this);
	}

	public override void visit_property_accessor (PropertyAccessor acc) {
		if (acc.body == null) {
			return;
		}

		acc.entry_block = new BasicBlock.entry ();
		acc.exit_block = new BasicBlock.exit ();

		current_block = new BasicBlock ();
		acc.entry_block.connect (current_block);

		jump_stack.add (new JumpTarget.return_target (acc.exit_block));

		acc.accept_children (this);

		jump_stack.remove_at (jump_stack.size - 1);

		if (current_block != null) {
			// end of property accessor body reachable

			if (acc.readable) {
				Report.error (acc.source_reference, "missing return statement at end of property getter body");
				acc.error = true;
			}

			current_block.connect (acc.exit_block);
		}
	}

	public override void visit_block (Block b) {
		b.accept_children (this);
	}

	public override void visit_declaration_statement (DeclarationStatement stmt) {
		if (unreachable (stmt)) {
			return;
		}

		current_block.add_node (stmt);

		foreach (VariableDeclarator decl in stmt.declaration.get_variable_declarators ()) {
			if (decl.initializer != null) {
				handle_errors (decl.initializer);
			}
		}
	}

	public override void visit_expression_statement (ExpressionStatement stmt) {
		if (unreachable (stmt)) {
			return;
		}

		current_block.add_node (stmt);

		handle_errors (stmt);

		if (stmt.expression is InvocationExpression) {
			var expr = (InvocationExpression) stmt.expression;
			var ma = expr.call as MemberAccess;
			if (ma.symbol_reference != null && ma.symbol_reference.get_attribute ("NoReturn") != null) {
				current_block = null;
				unreachable_reported = false;
				return;
			}
		}
	}

	public override void visit_if_statement (IfStatement stmt) {
		if (unreachable (stmt)) {
			return;
		}

		// condition
		current_block.add_node (stmt.condition);

		handle_errors (stmt.condition);

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

	public override void visit_switch_statement (SwitchStatement stmt) {
		if (unreachable (stmt)) {
			return;
		}

		var after_switch_block = new BasicBlock ();
		jump_stack.add (new JumpTarget.break_target (after_switch_block));

		// condition
		current_block.add_node (stmt.expression);
		var condition_block = current_block;

		handle_errors (stmt.expression);

		bool has_default_label = false;

		foreach (SwitchSection section in stmt.get_sections ()) {
			current_block = new BasicBlock ();
			condition_block.connect (current_block);
			foreach (Statement stmt in section.get_statements ()) {
				stmt.accept (this);
			}

			if (section.has_default_label ()) {
				has_default_label = true;
			}

			if (current_block != null) {
				// end of switch section reachable
				// we don't allow fall-through

				Report.error (section.source_reference, "missing break statement at end of switch section");
				section.error = true;

				current_block.connect (after_switch_block);
			}
		}

		// after switch
		// reachable?
		if (!has_default_label || after_switch_block.get_predecessors ().size > 0) {
			current_block = after_switch_block;
		} else {
			current_block = null;
			unreachable_reported = false;
		}

		jump_stack.remove_at (jump_stack.size - 1);
	}

	public override void visit_while_statement (WhileStatement stmt) {
		if (unreachable (stmt)) {
			return;
		}

		var condition_block = new BasicBlock ();
		jump_stack.add (new JumpTarget.continue_target (condition_block));
		var after_loop_block = new BasicBlock ();
		jump_stack.add (new JumpTarget.break_target (after_loop_block));

		// condition
		var last_block = current_block;
		last_block.connect (condition_block);
		current_block = condition_block;
		current_block.add_node (stmt.condition);

		handle_errors (stmt.condition);

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

		jump_stack.remove_at (jump_stack.size - 1);
		jump_stack.remove_at (jump_stack.size - 1);
	}

	public override void visit_do_statement (DoStatement stmt) {
		if (unreachable (stmt)) {
			return;
		}

		var condition_block = new BasicBlock ();
		jump_stack.add (new JumpTarget.continue_target (condition_block));
		var after_loop_block = new BasicBlock ();
		jump_stack.add (new JumpTarget.break_target (after_loop_block));

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

			handle_errors (stmt.condition);
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

		jump_stack.remove_at (jump_stack.size - 1);
		jump_stack.remove_at (jump_stack.size - 1);
	}

	public override void visit_for_statement (ForStatement stmt) {
		if (unreachable (stmt)) {
			return;
		}

		// initializer
		foreach (Expression init_expr in stmt.get_initializer ()) {
			current_block.add_node (init_expr);
			handle_errors (init_expr);
		}

		var iterator_block = new BasicBlock ();
		jump_stack.add (new JumpTarget.continue_target (iterator_block));
		var after_loop_block = new BasicBlock ();
		jump_stack.add (new JumpTarget.break_target (after_loop_block));

		// condition
		var condition_block = new BasicBlock ();
		current_block.connect (condition_block);
		current_block = condition_block;
		if (stmt.condition != null) {
			current_block.add_node (stmt.condition);
		}

		if (stmt.condition != null) {
			handle_errors (stmt.condition);
		}

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
			current_block = iterator_block;
			foreach (Expression it_expr in stmt.get_iterator ()) {
				current_block.add_node (it_expr);
				handle_errors (it_expr);
			}
			current_block.connect (condition_block);
		}

		// after loop
		condition_block.connect (after_loop_block);
		current_block = after_loop_block;

		jump_stack.remove_at (jump_stack.size - 1);
		jump_stack.remove_at (jump_stack.size - 1);
	}

	public override void visit_foreach_statement (ForeachStatement stmt) {
		if (unreachable (stmt)) {
			return;
		}

		// collection
		current_block.add_node (stmt.collection);
		handle_errors (stmt.collection);

		var loop_block = new BasicBlock ();
		jump_stack.add (new JumpTarget.continue_target (loop_block));
		var after_loop_block = new BasicBlock ();
		jump_stack.add (new JumpTarget.break_target (after_loop_block));

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

		jump_stack.remove_at (jump_stack.size - 1);
		jump_stack.remove_at (jump_stack.size - 1);
	}

	public override void visit_break_statement (BreakStatement stmt) {
		if (unreachable (stmt)) {
			return;
		}

		current_block.add_node (stmt);

		for (int i = jump_stack.size - 1; i >= 0; i--) {
			var jump_target = jump_stack[i];
			if (jump_target.break_target) {
				current_block.connect (jump_target.basic_block);
				current_block = null;
				unreachable_reported = false;
				return;
			} else if (jump_target.finally_clause) {
				current_block.connect (jump_target.basic_block);
				current_block = jump_target.last_block;
			}
		}

		Report.error (stmt.source_reference, "no enclosing loop or switch statement found");
		stmt.error = true;
	}

	public override void visit_continue_statement (ContinueStatement stmt) {
		if (unreachable (stmt)) {
			return;
		}

		current_block.add_node (stmt);

		for (int i = jump_stack.size - 1; i >= 0; i--) {
			var jump_target = jump_stack[i];
			if (jump_target.continue_target) {
				current_block.connect (jump_target.basic_block);
				current_block = null;
				unreachable_reported = false;
				return;
			} else if (jump_target.finally_clause) {
				current_block.connect (jump_target.basic_block);
				current_block = jump_target.last_block;
			}
		}

		Report.error (stmt.source_reference, "no enclosing loop found");
		stmt.error = true;
	}

	public override void visit_return_statement (ReturnStatement stmt) {
		if (unreachable (stmt)) {
			return;
		}

		current_block.add_node (stmt);

		for (int i = jump_stack.size - 1; i >= 0; i--) {
			var jump_target = jump_stack[i];
			if (jump_target.return_target) {
				current_block.connect (jump_target.basic_block);
				current_block = null;
				unreachable_reported = false;
				return;
			} else if (jump_target.finally_clause) {
				current_block.connect (jump_target.basic_block);
				current_block = jump_target.last_block;
			}
		}

		Report.error (stmt.source_reference, "no enclosing loop found");
		stmt.error = true;
	}

	private void handle_errors (CodeNode node) {
		if (node.tree_can_fail) {
			var last_block = current_block;

			// exceptional control flow
			for (int i = jump_stack.size - 1; i >= 0; i--) {
				var jump_target = jump_stack[i];
				if (jump_target.return_target) {
					current_block.connect (jump_target.basic_block);
					current_block = null;
					unreachable_reported = false;
					break;
				} else if (jump_target.error_target) {
					// TODO check whether jump target catches node.error_type
					current_block.connect (jump_target.basic_block);
					if (jump_target.error_domain == null) {
						// catch all clause
						current_block = null;
						unreachable_reported = false;
						break;
					}
				} else if (jump_target.finally_clause) {
					current_block.connect (jump_target.basic_block);
					current_block = jump_target.last_block;
				}
			}

			// normal control flow
			current_block = new BasicBlock ();
			last_block.connect (current_block);
		}
	}

	public override void visit_throw_statement (ThrowStatement stmt) {
		if (unreachable (stmt)) {
			return;
		}

		current_block.add_node (stmt);

		for (int i = jump_stack.size - 1; i >= 0; i--) {
			var jump_target = jump_stack[i];
			if (jump_target.return_target) {
				current_block.connect (jump_target.basic_block);
				current_block = null;
				unreachable_reported = false;
				return;
			} else if (jump_target.error_target) {
				// TODO check whether jump target catches stmt.error_type
				current_block.connect (jump_target.basic_block);
				if (jump_target.error_domain == null) {
					current_block = null;
					unreachable_reported = false;
					return;
				}
			} else if (jump_target.finally_clause) {
				current_block.connect (jump_target.basic_block);
				current_block = jump_target.last_block;
			}
		}

		assert_not_reached ();
	}

	public override void visit_try_statement (TryStatement stmt) {
		if (unreachable (stmt)) {
			return;
		}

		var after_try_block = new BasicBlock ();

		BasicBlock finally_block = null;
		if (stmt.finally_body != null) {
			finally_block = new BasicBlock ();
			current_block = finally_block;
			stmt.finally_body.accept (this);

			if (current_block == null) {
				// don't allow finally blocks with e.g. return statements
				Report.error (stmt.source_reference, "end of finally block not reachable");
				stmt.error = true;
				return;
			}

			jump_stack.add (new JumpTarget.finally_clause (finally_block, current_block));
		}

		int finally_jump_stack_size = jump_stack.size;

		var catch_clauses = stmt.get_catch_clauses ();
		for (int i = catch_clauses.size - 1; i >= 0; i--) {
			var catch_clause = catch_clauses[i];
			if (catch_clause.type_reference != null) {
				jump_stack.add (new JumpTarget.error_target (new BasicBlock (), catch_clause, catch_clause.type_reference.data_type as Enum, null));
			} else {
				jump_stack.add (new JumpTarget.error_target (new BasicBlock (), catch_clause, null, null));
			}
		}

		stmt.body.accept (this);

		if (current_block != null) {
			if (finally_block != null) {
				current_block.connect (finally_block);
				current_block = finally_block;
			}
			current_block.connect (after_try_block);
		}

		// remove catch clauses from jump stack
		Gee.List<JumpTarget> catch_stack = new ArrayList<JumpTarget> ();
		for (int i = jump_stack.size - 1; i >= finally_jump_stack_size; i--) {
			var jump_target = jump_stack[i];
			catch_stack.add (jump_target);
			jump_stack.remove_at (i);
		}

		foreach (JumpTarget jump_target in catch_stack) {
			if (jump_target.basic_block.get_predecessors ().size == 0) {
				// unreachable
				Report.warning (jump_target.catch_clause.source_reference, "unreachable catch clause detected");
			} else {
				current_block = jump_target.basic_block;
				jump_target.catch_clause.body.accept (this);
				if (current_block != null) {
					if (finally_block != null) {
						current_block.connect (finally_block);
						current_block = finally_block;
					}
					current_block.connect (after_try_block);
				}
			}
		}

		if (finally_block != null) {
			jump_stack.remove_at (jump_stack.size - 1);
		}

		// after try statement
		// reachable?
		if (after_try_block.get_predecessors ().size > 0) {
			current_block = after_try_block;
		} else {
			current_block = null;
			unreachable_reported = false;
		}
	}

	public override void visit_lock_statement (LockStatement stmt) {
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
}
