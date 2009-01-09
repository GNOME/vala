/* valaflowanalyzer.vala
 *
 * Copyright (C) 2008-2009  Jürg Billeter
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
public class Vala.FlowAnalyzer : CodeVisitor {
	private class JumpTarget {
		public bool is_break_target { get; set; }
		public bool is_continue_target { get; set; }
		public bool is_return_target { get; set; }
		public bool is_error_target { get; set; }
		public ErrorDomain? error_domain { get; set; }
		public ErrorCode? error_code { get; set; }
		public bool is_finally_clause { get; set; }
		public BasicBlock basic_block { get; set; }
		public BasicBlock? last_block { get; set; }
		public CatchClause? catch_clause { get; set; }

		public JumpTarget.break_target (BasicBlock basic_block) {
			this.basic_block = basic_block;
			is_break_target = true;
		}

		public JumpTarget.continue_target (BasicBlock basic_block) {
			this.basic_block = basic_block;
			is_continue_target = true;
		}

		public JumpTarget.return_target (BasicBlock basic_block) {
			this.basic_block = basic_block;
			is_return_target = true;
		}

		public JumpTarget.error_target (BasicBlock basic_block, CatchClause catch_clause, ErrorDomain? error_domain, ErrorCode? error_code) {
			this.basic_block = basic_block;
			this.catch_clause = catch_clause;
			this.error_domain = error_domain;
			this.error_code = error_code;
			is_error_target = true;
		}

		public JumpTarget.finally_clause (BasicBlock basic_block, BasicBlock last_block) {
			this.basic_block = basic_block;
			this.last_block = last_block;
			is_finally_clause = true;
		}
	}

	private CodeContext context;
	private BasicBlock current_block;
	private bool unreachable_reported;
	private Gee.List<JumpTarget> jump_stack = new ArrayList<JumpTarget> ();

	Map<Symbol, Gee.List<LocalVariable>> var_map;
	Set<LocalVariable> used_vars;
	Map<LocalVariable, PhiFunction> phi_functions;

	public FlowAnalyzer () {
	}

	/**
	 * Build control flow graph in the specified context.
	 *
	 * @param context a code context
	 */
	public void analyze (CodeContext context) {
		this.context = context;

		/* we're only interested in non-pkg source files */
		var source_files = context.get_source_files ();
		foreach (SourceFile file in source_files) {
			if (!file.external_package) {
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

	public override void visit_error_domain (ErrorDomain ed) {
		ed.accept_children (this);
	}

	public override void visit_field (Field f) {
		if (f.access != SymbolAccessibility.PUBLIC
		    && f.access != SymbolAccessibility.PROTECTED
		    && !f.used) {
			Report.warning (f.source_reference, "field `%s' never used".printf (f.get_full_name ()));
		}
	}

	public override void visit_method (Method m) {
		if (m.access != SymbolAccessibility.PUBLIC
		    && m.access != SymbolAccessibility.PROTECTED
		    && !m.used && !m.entry_point) {
			Report.warning (m.source_reference, "method `%s' never used".printf (m.get_full_name ()));
		}

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

		build_dominator_tree (m);
		build_dominator_frontier (m);
		insert_phi_functions (m);
		check_variables (m);
	}

	Gee.List<BasicBlock> get_depth_first_list (Method m) {
		var list = new ArrayList<BasicBlock> ();
		depth_first_traverse (m.entry_block, list);
		return list;
	}

	void depth_first_traverse (BasicBlock current, Gee.List<BasicBlock> list) {
		if (current in list) {
			return;
		}
		list.add (current);
		foreach (BasicBlock succ in current.get_successors ()) {
			depth_first_traverse (succ, list);
		}
	}

	void build_dominator_tree (Method m) {
		// set dom(n) = {E,1,2...,N,X} forall n
		var dom = new HashMap<BasicBlock, Set<BasicBlock>> ();
		var block_list = get_depth_first_list (m);
		foreach (BasicBlock block in block_list) {
			var block_set = new HashSet<BasicBlock> ();
			foreach (BasicBlock b in block_list) {
				block_set.add (b);
			}
			dom.set (block, block_set);
		}

		// set dom(E) = {E}
		var entry_dom_set = new HashSet<BasicBlock> ();
		entry_dom_set.add (m.entry_block);
		dom.set (m.entry_block, entry_dom_set);

		bool changes = true;
		while (changes) {
			changes = false;
			foreach (BasicBlock block in block_list) {
				// intersect dom(pred) forall pred: pred = predecessor(s)
				var dom_set = new HashSet<BasicBlock> ();
				bool first = true;
				foreach (BasicBlock pred in block.get_predecessors ()) {
					var pred_dom_set = dom.get (pred);
					if (first) {
						foreach (BasicBlock dom_block in pred_dom_set) {
							dom_set.add (dom_block);
						}
						first = false;
					} else {
						var remove_queue = new ArrayList<BasicBlock> ();
						foreach (BasicBlock dom_block in dom_set) {
							if (!(dom_block in pred_dom_set)) {
								remove_queue.add (dom_block);
							}
						}
						foreach (BasicBlock dom_block in remove_queue) {
							dom_set.remove (dom_block);
						}
					}
				}
				// unite with s
				dom_set.add (block);

				// check for changes
				if (dom.get (block).size != dom_set.size) {
					changes = true;
				} else {
					foreach (BasicBlock dom_block in dom.get (block)) {
						if (!(dom_block in dom_set)) {
							changes = true;
						}
					}
				}
				// update set in map
				dom.set (block, dom_set);
			}
		}

		// build tree
		foreach (BasicBlock block in block_list) {
			if (block == m.entry_block) {
				continue;
			}

			BasicBlock immediate_dominator = null;
			foreach (BasicBlock dominator in dom.get (block)) {
				if (dominator == block) {
					continue;
				}

				if (immediate_dominator == null) {
					immediate_dominator = dominator;
				} else {
					// if immediate_dominator dominates dominator,
					// update immediate_dominator
					if (immediate_dominator in dom.get (dominator)) {
						immediate_dominator = dominator;
					}
				}
			}

			immediate_dominator.add_child (block);
		}
	}

	void build_dominator_frontier (Method m) {
		var block_list = get_depth_first_list (m);
		for (int i = block_list.size - 1; i >= 0; i--) {
			var block = block_list[i];

			foreach (BasicBlock succ in block.get_successors ()) {
				// if idom(succ) != block
				if (succ.parent != block) {
					block.add_dominator_frontier (succ);
				}
			}

			foreach (BasicBlock child in block.get_children ()) {
				foreach (BasicBlock child_frontier in child.get_dominator_frontier ()) {
					// if idom(child_frontier) != block
					if (child_frontier.parent != block) {
						block.add_dominator_frontier (child_frontier);
					}
				}
			}
		}
	}

	Map<LocalVariable, Set<BasicBlock>> get_assignment_map (Method m) {
		var map = new HashMap<LocalVariable, Set<BasicBlock>> ();
		foreach (BasicBlock block in get_depth_first_list (m)) {
			var defined_variables = new ArrayList<LocalVariable> ();
			foreach (CodeNode node in block.get_nodes ()) {
				node.get_defined_variables (defined_variables);
			}

			foreach (LocalVariable local in defined_variables) {
				var block_set = map.get (local);
				if (block_set == null) {
					block_set = new HashSet<BasicBlock> ();
					map.set (local, block_set);
				}
				block_set.add (block);
			}
		}
		return map;
	}

	void insert_phi_functions (Method m) {
		var assign = get_assignment_map (m);

		int counter = 0;
		var work_list = new ArrayList<BasicBlock> ();

		var added = new HashMap<BasicBlock, int> ();
		var phi = new HashMap<BasicBlock, int> ();
		foreach (BasicBlock block in get_depth_first_list (m)) {
			added.set (block, 0);
			phi.set (block, 0);
		}

		foreach (LocalVariable local in assign.get_keys ()) {
			counter++;
			foreach (BasicBlock block in assign.get (local)) {
				work_list.add (block);
				added.set (block, counter);
			}
			while (work_list.size > 0) {
				BasicBlock block = work_list.get (0);
				work_list.remove_at (0);
				foreach (BasicBlock frontier in block.get_dominator_frontier ()) {
					int blockPhi = phi.get (frontier);
					if (blockPhi < counter) {
						frontier.add_phi_function (new PhiFunction (local, frontier.get_predecessors ().size));
						phi.set (frontier, counter);
						int block_added = added.get (frontier);
						if (block_added < counter) {
							added.set (frontier, counter);
							work_list.add (frontier);
						}
					}
				}
			}
		}
	}

	void check_variables (Method m) {
		var_map = new HashMap<Symbol, Gee.List<LocalVariable>>();
		used_vars = new HashSet<LocalVariable> ();
		phi_functions = new HashMap<LocalVariable, PhiFunction> ();

		check_block_variables (m, m.entry_block);

		// check for variables used before initialization
		var used_vars_queue = new ArrayList<LocalVariable> ();
		foreach (LocalVariable local in used_vars) {
			used_vars_queue.add (local);
		}
		while (used_vars_queue.size > 0) {
			LocalVariable used_var = used_vars_queue[0];
			used_vars_queue.remove_at (0);

			PhiFunction phi = phi_functions.get (used_var);
			if (phi != null) {
				foreach (LocalVariable local in phi.operands) {
					if (local == null) {
						Report.error (used_var.source_reference, "use of possibly unassigned local variable `%s'".printf (used_var.name));
						continue;
					}
					if (!(local in used_vars)) {
						local.source_reference = used_var.source_reference;
						used_vars.add (local);
						used_vars_queue.add (local);
					}
				}
			}
		}
	}

	void check_block_variables (Method m, BasicBlock block) {
		foreach (PhiFunction phi in block.get_phi_functions ()) {
			LocalVariable versioned_var = process_assignment (m, var_map, phi.original_variable);

			phi_functions.set (versioned_var, phi);
		}

		foreach (CodeNode node in block.get_nodes ()) {
			var used_variables = new ArrayList<LocalVariable> ();
			node.get_used_variables (used_variables);
			
			foreach (LocalVariable var_symbol in used_variables) {
				var variable_stack = var_map.get (var_symbol);
				if (variable_stack == null || variable_stack.size == 0) {
					Report.error (node.source_reference, "use of possibly unassigned local variable `%s'".printf (var_symbol.name));
					continue;
				}
				var versioned_local = variable_stack.get (variable_stack.size - 1);
				if (!(versioned_local in used_vars)) {
					versioned_local.source_reference = node.source_reference;
				}
				used_vars.add (versioned_local);
			}

			var defined_variables = new ArrayList<LocalVariable> ();
			node.get_defined_variables (defined_variables);

			foreach (LocalVariable local in defined_variables) {
				process_assignment (m, var_map, local);
			}
		}

		foreach (BasicBlock succ in block.get_successors ()) {
			int j = 0;
			foreach (BasicBlock pred in succ.get_predecessors ()) {
				if (pred == block) {
					break;
				}
				j++;
			}

			foreach (PhiFunction phi in succ.get_phi_functions ()) {
				var variable_stack = var_map.get (phi.original_variable);
				if (variable_stack != null && variable_stack.size > 0) {
					phi.operands.set (j, variable_stack.get (variable_stack.size - 1));
				}
			}
		}

		foreach (BasicBlock child in block.get_children ()) {
			check_block_variables (m, child);
		}

		foreach (PhiFunction phi in block.get_phi_functions ()) {
			var variable_stack = var_map.get (phi.original_variable);
			variable_stack.remove_at (variable_stack.size - 1);
		}
		foreach (CodeNode node in block.get_nodes ()) {
			var defined_variables = new ArrayList<LocalVariable> ();
			node.get_defined_variables (defined_variables);

			foreach (LocalVariable local in defined_variables) {
				var variable_stack = var_map.get (local);
				variable_stack.remove_at (variable_stack.size - 1);
			}
		}
	}

	LocalVariable process_assignment (Method m, Map<Symbol, Gee.List<LocalVariable>> var_map, LocalVariable var_symbol) {
		var variable_stack = var_map.get (var_symbol);
		if (variable_stack == null) {
			variable_stack = new ArrayList<LocalVariable> ();
			var_map.set (var_symbol, variable_stack);
		}
		LocalVariable versioned_var = new LocalVariable (var_symbol.variable_type, var_symbol.name, null, var_symbol.source_reference);
		variable_stack.add (versioned_var);
		return versioned_var;
	}

	public override void visit_creation_method (CreationMethod m) {
		visit_method (m);
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

		if (!stmt.declaration.used) {
			Report.warning (stmt.declaration.source_reference, "local variable `%s' declared but never used".printf (stmt.declaration.name));
		}

		current_block.add_node (stmt);

		var local = stmt.declaration as LocalVariable;
		if (local != null && local.initializer != null) {
			handle_errors (local.initializer);
		}
	}

	public override void visit_expression_statement (ExpressionStatement stmt) {
		if (unreachable (stmt)) {
			return;
		}

		current_block.add_node (stmt);

		handle_errors (stmt);

		if (stmt.expression is MethodCall) {
			var expr = (MethodCall) stmt.expression;
			var ma = expr.call as MemberAccess;
			if (ma != null && ma.symbol_reference != null && ma.symbol_reference.get_attribute ("NoReturn") != null) {
				current_block = null;
				unreachable_reported = false;
				return;
			}
		}
	}

	bool always_true (Expression condition) {
		var literal = condition as BooleanLiteral;
		return (literal != null && literal.value);
	}

	bool always_false (Expression condition) {
		var literal = condition as BooleanLiteral;
		return (literal != null && !literal.value);
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
		if (always_false (stmt.condition)) {
			current_block = null;
			unreachable_reported = false;
		} else {
			current_block = new BasicBlock ();
			last_block.connect (current_block);
		}
		stmt.true_statement.accept (this);

		// false block
		var last_true_block = current_block;
		if (always_true (stmt.condition)) {
			current_block = null;
			unreachable_reported = false;
		} else {
			current_block = new BasicBlock ();
			last_block.connect (current_block);
		}
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

		if (!has_default_label) {
			condition_block.connect (after_switch_block);
		}

		// after switch
		// reachable?
		if (after_switch_block.get_predecessors ().size > 0) {
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
		if (always_false (stmt.condition)) {
			current_block = null;
			unreachable_reported = false;
		} else {
			current_block = new BasicBlock ();
			condition_block.connect (current_block);
		}
		stmt.body.accept (this);
		// end of loop block reachable?
		if (current_block != null) {
			current_block.connect (condition_block);
		}

		// after loop
		// reachable?
		if (always_true (stmt.condition) && after_loop_block.get_predecessors ().size == 0) {
			current_block = null;
			unreachable_reported = false;
		} else {
			condition_block.connect (after_loop_block);
			current_block = after_loop_block;
		}

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
		current_block.add_node (stmt);
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
			if (jump_target.is_break_target) {
				current_block.connect (jump_target.basic_block);
				current_block = null;
				unreachable_reported = false;
				return;
			} else if (jump_target.is_finally_clause) {
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
			if (jump_target.is_continue_target) {
				current_block.connect (jump_target.basic_block);
				current_block = null;
				unreachable_reported = false;
				return;
			} else if (jump_target.is_finally_clause) {
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

		if (stmt.return_expression != null) {
			handle_errors (stmt.return_expression);
		}

		for (int i = jump_stack.size - 1; i >= 0; i--) {
			var jump_target = jump_stack[i];
			if (jump_target.is_return_target) {
				current_block.connect (jump_target.basic_block);
				current_block = null;
				unreachable_reported = false;
				return;
			} else if (jump_target.is_finally_clause) {
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
				if (jump_target.is_return_target) {
					current_block.connect (jump_target.basic_block);
					current_block = null;
					unreachable_reported = false;
					break;
				} else if (jump_target.is_error_target) {
					// TODO check whether jump target catches node.error_type
					current_block.connect (jump_target.basic_block);
					if (jump_target.error_domain == null) {
						// catch all clause
						current_block = null;
						unreachable_reported = false;
						break;
					}
				} else if (jump_target.is_finally_clause) {
					current_block.connect (jump_target.basic_block);
					current_block = jump_target.last_block;
				}
			}

			// normal control flow
			current_block = new BasicBlock ();
			last_block.connect (current_block);
		}
	}

	public override void visit_yield_statement (YieldStatement stmt) {
		if (unreachable (stmt)) {
			return;
		}

		stmt.accept_children (this);
	}

	public override void visit_throw_statement (ThrowStatement stmt) {
		if (unreachable (stmt)) {
			return;
		}

		current_block.add_node (stmt);

		for (int i = jump_stack.size - 1; i >= 0; i--) {
			var jump_target = jump_stack[i];
			if (jump_target.is_return_target) {
				current_block.connect (jump_target.basic_block);
				current_block = null;
				unreachable_reported = false;
				return;
			} else if (jump_target.is_error_target) {
				// TODO check whether jump target catches stmt.error_type
				current_block.connect (jump_target.basic_block);
				if (jump_target.error_domain == null) {
					current_block = null;
					unreachable_reported = false;
					return;
				}
			} else if (jump_target.is_finally_clause) {
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

		var before_try_block = current_block;
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
			if (catch_clause.error_type != null) {
				jump_stack.add (new JumpTarget.error_target (new BasicBlock (), catch_clause, catch_clause.error_type.data_type as ErrorDomain, null));
			} else {
				jump_stack.add (new JumpTarget.error_target (new BasicBlock (), catch_clause, null, null));
			}
		}

		current_block = before_try_block;

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
				current_block.add_node (jump_target.catch_clause);
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
