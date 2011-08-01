/* valaflowanalyzer.vala
 *
 * Copyright (C) 2008-2010  Jürg Billeter
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
 * Code visitor building the control flow graph.
 */
public class Vala.FlowAnalyzer : CodeVisitor {
	private class JumpTarget {
		public bool is_break_target { get; set; }
		public bool is_continue_target { get; set; }
		public bool is_return_target { get; set; }
		public bool is_exit_target { get; set; }
		public bool is_error_target { get; set; }
		public ErrorDomain? error_domain { get; set; }
		public ErrorCode? error_code { get; set; }
		public Class? error_class { get; set; }
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

		public JumpTarget.exit_target (BasicBlock basic_block) {
			this.basic_block = basic_block;
			is_exit_target = true;
		}

		public JumpTarget.error_target (BasicBlock basic_block, CatchClause catch_clause, ErrorDomain? error_domain, ErrorCode? error_code, Class? error_class) {
			this.basic_block = basic_block;
			this.catch_clause = catch_clause;
			this.error_domain = error_domain;
			this.error_code = error_code;
			this.error_class = error_class;
			is_error_target = true;
		}

		public JumpTarget.any_target (BasicBlock basic_block) {
			this.basic_block = basic_block;
			is_break_target = true;
			is_continue_target = true;
			is_return_target = true;
			is_exit_target = true;
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
	private List<JumpTarget> jump_stack = new ArrayList<JumpTarget> ();

	Map<Symbol, List<Variable>> var_map;
	Set<Variable> used_vars;
	Map<Variable, PhiFunction> phi_functions;

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
			if (file.file_type == SourceFileType.SOURCE) {
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
		if (f.is_internal_symbol () && !f.used) {
			if (!f.is_private_symbol () && context.internal_header_filename != null) {
				// do not warn if internal member may be used outside this compilation unit
			} else {
				Report.warning (f.source_reference, "field `%s' never used".printf (f.get_full_name ()));
			}
		}
	}

	public override void visit_lambda_expression (LambdaExpression le) {
		var old_current_block = current_block;
		var old_unreachable_reported = unreachable_reported;
		var old_jump_stack = jump_stack;
		mark_unreachable ();
		jump_stack = new ArrayList<JumpTarget> ();

		le.accept_children (this);

		current_block = old_current_block;
		unreachable_reported = old_unreachable_reported;
		jump_stack = old_jump_stack;
	}

	public override void visit_method (Method m) {
		if (m.is_internal_symbol () && !m.used && !m.entry_point
		    && !m.overrides && (m.base_interface_method == null || m.base_interface_method == m)
		    && !(m is CreationMethod)) {
			if (!m.is_private_symbol () && context.internal_header_filename != null) {
				// do not warn if internal member may be used outside this compilation unit
			} else {
				Report.warning (m.source_reference, "method `%s' never used".printf (m.get_full_name ()));
			}
		}

		visit_subroutine (m);
	}

	public override void visit_signal (Signal sig) {
		if (sig.default_handler != null) {
			visit_subroutine (sig.default_handler);
		}
	}

	void visit_subroutine (Subroutine m) {
		if (m.body == null) {
			return;
		}

		m.entry_block = new BasicBlock.entry ();
		m.return_block = new BasicBlock ();
		m.exit_block = new BasicBlock.exit ();

		m.return_block.connect (m.exit_block);

		if (context.profile == Profile.DOVA && m.result_var != null) {
			// ensure result is defined at end of method
			var result_ma = new MemberAccess.simple ("result", m.source_reference);
			result_ma.symbol_reference = m.result_var;
			m.return_block.add_node (result_ma);
		}
		if (m is Method) {
			// ensure out parameters are defined at end of method
			foreach (var param in ((Method) m).get_parameters ()) {
				if (param.direction == ParameterDirection.OUT) {
					var param_ma = new MemberAccess.simple (param.name, param.source_reference);
					param_ma.symbol_reference = param;
					m.return_block.add_node (param_ma);
				}
			}
		}

		current_block = new BasicBlock ();
		m.entry_block.connect (current_block);
		current_block.add_node (m);

		jump_stack.add (new JumpTarget.return_target (m.return_block));
		jump_stack.add (new JumpTarget.exit_target (m.exit_block));

		m.accept_children (this);

		jump_stack.remove_at (jump_stack.size - 1);

		if (current_block != null) {
			// end of method body reachable

			if (context.profile != Profile.DOVA && m.has_result) {
				Report.error (m.source_reference, "missing return statement at end of subroutine body");
				m.error = true;
			}

			current_block.connect (m.return_block);
		}

		analyze_body (m.entry_block);
	}

	void analyze_body (BasicBlock entry_block) {
		var block_list = get_depth_first_list (entry_block);

		build_dominator_tree (block_list, entry_block);
		build_dominator_frontier (block_list, entry_block);
		insert_phi_functions (block_list, entry_block);
		check_variables (entry_block);
	}

	// generates reverse postorder list
	List<BasicBlock> get_depth_first_list (BasicBlock entry_block) {
		var list = new ArrayList<BasicBlock> ();
		depth_first_traverse (entry_block, list);
		return list;
	}

	void depth_first_traverse (BasicBlock current, List<BasicBlock> list) {
		if (current.postorder_visited) {
			return;
		}
		current.postorder_visited = true;
		foreach (BasicBlock succ in current.get_successors ()) {
			depth_first_traverse (succ, list);
		}
		current.postorder_number = list.size;
		list.insert (0, current);
	}

	void build_dominator_tree (List<BasicBlock> block_list, BasicBlock entry_block) {
		// immediate dominators
		var idoms = new BasicBlock[block_list.size];
		idoms[entry_block.postorder_number] = entry_block;

		bool changed = true;
		while (changed) {
			changed = false;
			foreach (BasicBlock block in block_list) {
				if (block == entry_block) {
					continue;
				}

				// new immediate dominator
				BasicBlock new_idom = null;
				bool first = true;
				foreach (BasicBlock pred in block.get_predecessors ()) {
					if (idoms[pred.postorder_number] != null) {
						if (first) {
							new_idom = pred;
							first = false;
						} else {
							new_idom = intersect (idoms, pred, new_idom);
						}
					}
				}
				if (idoms[block.postorder_number] != new_idom) {
					idoms[block.postorder_number] = new_idom;
					changed = true;
				}
			}
		}

		// build tree
		foreach (BasicBlock block in block_list) {
			if (block == entry_block) {
				continue;
			}

			idoms[block.postorder_number].add_child (block);
		}
	}

	BasicBlock intersect (BasicBlock[] idoms, BasicBlock b1, BasicBlock b2) {
		while (b1 != b2) {
			while (b1.postorder_number < b2.postorder_number) {
				b1 = idoms[b2.postorder_number];
			}
			while (b2.postorder_number < b1.postorder_number) {
				b2 = idoms[b2.postorder_number];
			}
		}
		return b1;
	}

	void build_dominator_frontier (List<BasicBlock> block_list, BasicBlock entry_block) {
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

	Map<Variable, Set<BasicBlock>> get_assignment_map (List<BasicBlock> block_list, BasicBlock entry_block) {
		var map = new HashMap<Variable, Set<BasicBlock>> ();
		foreach (BasicBlock block in block_list) {
			var defined_variables = new ArrayList<Variable> ();
			foreach (CodeNode node in block.get_nodes ()) {
				node.get_defined_variables (defined_variables);
			}

			foreach (Variable variable in defined_variables) {
				var block_set = map.get (variable);
				if (block_set == null) {
					block_set = new HashSet<BasicBlock> ();
					map.set (variable, block_set);
				}
				block_set.add (block);
			}
		}
		return map;
	}

	void insert_phi_functions (List<BasicBlock> block_list, BasicBlock entry_block) {
		var assign = get_assignment_map (block_list, entry_block);

		int counter = 0;
		var work_list = new ArrayList<BasicBlock> ();

		var added = new HashMap<BasicBlock, int> ();
		var phi = new HashMap<BasicBlock, int> ();
		foreach (BasicBlock block in block_list) {
			added.set (block, 0);
			phi.set (block, 0);
		}

		foreach (Variable variable in assign.get_keys ()) {
			counter++;
			foreach (BasicBlock block in assign.get (variable)) {
				work_list.add (block);
				added.set (block, counter);
			}
			while (work_list.size > 0) {
				BasicBlock block = work_list.get (0);
				work_list.remove_at (0);
				foreach (BasicBlock frontier in block.get_dominator_frontier ()) {
					int blockPhi = phi.get (frontier);
					if (blockPhi < counter) {
						frontier.add_phi_function (new PhiFunction (variable, frontier.get_predecessors ().size));
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

	void check_variables (BasicBlock entry_block) {
		var_map = new HashMap<Symbol, List<Variable>>();
		used_vars = new HashSet<Variable> ();
		phi_functions = new HashMap<Variable, PhiFunction> ();

		check_block_variables (entry_block);

		// check for variables used before initialization
		var used_vars_queue = new ArrayList<Variable> ();
		foreach (Variable variable in used_vars) {
			used_vars_queue.add (variable);
		}
		while (used_vars_queue.size > 0) {
			Variable used_var = used_vars_queue[0];
			used_vars_queue.remove_at (0);

			PhiFunction phi = phi_functions.get (used_var);
			if (phi != null) {
				foreach (Variable variable in phi.operands) {
					if (variable == null) {
						if (used_var is LocalVariable) {
							Report.error (used_var.source_reference, "use of possibly unassigned local variable `%s'".printf (used_var.name));
						} else {
							// parameter
							Report.warning (used_var.source_reference, "use of possibly unassigned parameter `%s'".printf (used_var.name));
						}
						continue;
					}
					if (!(variable in used_vars)) {
						variable.source_reference = used_var.source_reference;
						used_vars.add (variable);
						used_vars_queue.add (variable);
					}
				}
			}
		}
	}

	void check_block_variables (BasicBlock block) {
		foreach (PhiFunction phi in block.get_phi_functions ()) {
			Variable versioned_var = process_assignment (var_map, phi.original_variable);

			phi_functions.set (versioned_var, phi);
		}

		foreach (CodeNode node in block.get_nodes ()) {
			var used_variables = new ArrayList<Variable> ();
			node.get_used_variables (used_variables);
			
			foreach (Variable var_symbol in used_variables) {
				var variable_stack = var_map.get (var_symbol);
				if (variable_stack == null || variable_stack.size == 0) {
					if (var_symbol is LocalVariable) {
						Report.error (node.source_reference, "use of possibly unassigned local variable `%s'".printf (var_symbol.name));
					} else {
						// parameter
						Report.warning (node.source_reference, "use of possibly unassigned parameter `%s'".printf (var_symbol.name));
					}
					continue;
				}
				var versioned_variable = variable_stack.get (variable_stack.size - 1);
				if (!(versioned_variable in used_vars)) {
					versioned_variable.source_reference = node.source_reference;
				}
				used_vars.add (versioned_variable);
			}

			var defined_variables = new ArrayList<Variable> ();
			node.get_defined_variables (defined_variables);

			foreach (Variable variable in defined_variables) {
				process_assignment (var_map, variable);
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
			check_block_variables (child);
		}

		foreach (PhiFunction phi in block.get_phi_functions ()) {
			var variable_stack = var_map.get (phi.original_variable);
			variable_stack.remove_at (variable_stack.size - 1);
		}
		foreach (CodeNode node in block.get_nodes ()) {
			var defined_variables = new ArrayList<Variable> ();
			node.get_defined_variables (defined_variables);

			foreach (Variable variable in defined_variables) {
				var variable_stack = var_map.get (variable);
				variable_stack.remove_at (variable_stack.size - 1);
			}
		}
	}

	Variable process_assignment (Map<Symbol, List<Variable>> var_map, Variable var_symbol) {
		var variable_stack = var_map.get (var_symbol);
		if (variable_stack == null) {
			variable_stack = new ArrayList<Variable> ();
			var_map.set (var_symbol, variable_stack);
			var_symbol.single_assignment = true;
		} else {
			var_symbol.single_assignment = false;
		}
		Variable versioned_var;
		if (var_symbol is LocalVariable) {
			versioned_var = new LocalVariable (var_symbol.variable_type, var_symbol.name, null, var_symbol.source_reference);
		} else {
			// parameter
			versioned_var = new Parameter (var_symbol.name, var_symbol.variable_type, var_symbol.source_reference);
		}
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
		visit_subroutine (acc);
	}

	public override void visit_block (Block b) {
		b.accept_children (this);
	}

	public override void visit_declaration_statement (DeclarationStatement stmt) {
		stmt.accept_children (this);

		if (unreachable (stmt)) {
			stmt.declaration.unreachable = true;
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

	public override void visit_local_variable (LocalVariable local) {
		if (local.initializer != null) {
			local.initializer.accept (this);
		}
	}

	public override void visit_expression_statement (ExpressionStatement stmt) {
		stmt.accept_children (this);

		if (unreachable (stmt)) {
			return;
		}

		current_block.add_node (stmt);

		handle_errors (stmt);

		if (stmt.expression is MethodCall) {
			var expr = (MethodCall) stmt.expression;
			var ma = expr.call as MemberAccess;
			if (ma != null && ma.symbol_reference != null && ma.symbol_reference.get_attribute ("NoReturn") != null) {
				mark_unreachable ();
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
			mark_unreachable ();
		} else {
			current_block = new BasicBlock ();
			last_block.connect (current_block);
		}
		stmt.true_statement.accept (this);

		// false block
		var last_true_block = current_block;
		if (always_true (stmt.condition)) {
			mark_unreachable ();
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
			foreach (Statement section_stmt in section.get_statements ()) {
				section_stmt.accept (this);
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
			mark_unreachable ();
		}

		jump_stack.remove_at (jump_stack.size - 1);
	}

	public override void visit_loop (Loop stmt) {
		if (unreachable (stmt)) {
			return;
		}

		var loop_block = new BasicBlock ();
		jump_stack.add (new JumpTarget.continue_target (loop_block));
		var after_loop_block = new BasicBlock ();
		jump_stack.add (new JumpTarget.break_target (after_loop_block));

		// loop block
		var last_block = current_block;
		last_block.connect (loop_block);
		current_block = loop_block;

		stmt.body.accept (this);
		// end of loop block reachable?
		if (current_block != null) {
			current_block.connect (loop_block);
		}

		// after loop
		// reachable?
		if (after_loop_block.get_predecessors ().size == 0) {
			// after loop block not reachable
			mark_unreachable ();
		} else {
			// after loop block reachable
			current_block = after_loop_block;
		}

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
				mark_unreachable ();
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
				mark_unreachable ();
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
		stmt.accept_children (this);

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
				mark_unreachable ();
				return;
			} else if (jump_target.is_finally_clause) {
				current_block.connect (jump_target.basic_block);
				current_block = jump_target.last_block;
			}
		}

		Report.error (stmt.source_reference, "no enclosing loop found");
		stmt.error = true;
	}

	private void handle_errors (CodeNode node, bool always_fail = false) {
		if (node.tree_can_fail) {
			var last_block = current_block;

			// exceptional control flow
			foreach (DataType error_data_type in node.get_error_types()) {
				var error_type = error_data_type as ErrorType;
				var error_class = error_data_type.data_type as Class;
				current_block = last_block;
				unreachable_reported = true;

				for (int i = jump_stack.size - 1; i >= 0; i--) {
					var jump_target = jump_stack[i];
					if (jump_target.is_exit_target) {
						current_block.connect (jump_target.basic_block);
						mark_unreachable ();
						break;
					} else if (jump_target.is_error_target) {
						if (context.profile == Profile.GOBJECT) {
							if (jump_target.error_domain == null
							    || (jump_target.error_domain == error_type.error_domain
								&& (jump_target.error_code == null
								    || jump_target.error_code == error_type.error_code))) {
								// error can always be caught by this catch clause
								// following catch clauses cannot be reached by this error
								current_block.connect (jump_target.basic_block);
								mark_unreachable ();
								break;
							} else if (error_type.error_domain == null
								   || (error_type.error_domain == jump_target.error_domain
								       && (error_type.error_code == null
								           || error_type.error_code == jump_target.error_code))) {
								// error might be caught by this catch clause
								// unknown at compile time
								// following catch clauses might still be reached by this error
								current_block.connect (jump_target.basic_block);
							}
						} else if (jump_target.error_class == null || jump_target.error_class == error_class) {
							// error can always be caught by this catch clause
							// following catch clauses cannot be reached by this error
							current_block.connect (jump_target.basic_block);
							mark_unreachable ();
							break;
						} else if (jump_target.error_class.is_subtype_of (error_class)) {
							// error might be caught by this catch clause
							// unknown at compile time
							// following catch clauses might still be reached by this error
							current_block.connect (jump_target.basic_block);
						}
					} else if (jump_target.is_finally_clause) {
						current_block.connect (jump_target.basic_block);
						current_block = jump_target.last_block;
					}
				}
			}

			// normal control flow
			if (!always_fail) {
				current_block = new BasicBlock ();
				last_block.connect (current_block);
			}
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
		handle_errors (stmt, true);
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

			// trap all forbidden jumps
			var invalid_block = new BasicBlock ();
			jump_stack.add (new JumpTarget.any_target (invalid_block));

			stmt.finally_body.accept (this);

			if (invalid_block.get_predecessors ().size > 0) {
				// don't allow finally blocks with e.g. return statements
				Report.error (stmt.source_reference, "jump out of finally block not permitted");
				stmt.error = true;
				return;
			}
			jump_stack.remove_at (jump_stack.size - 1);

			jump_stack.add (new JumpTarget.finally_clause (finally_block, current_block));
		}

		int finally_jump_stack_size = jump_stack.size;

		var catch_clauses = stmt.get_catch_clauses ();
		for (int i = catch_clauses.size - 1; i >= 0; i--) {
			var catch_clause = catch_clauses[i];
			if (catch_clause.error_type != null) {
				if (context.profile == Profile.GOBJECT) {
					var error_type = catch_clause.error_type as ErrorType;
					jump_stack.add (new JumpTarget.error_target (new BasicBlock (), catch_clause, catch_clause.error_type.data_type as ErrorDomain, error_type.error_code, null));
				} else {
					var error_class = catch_clause.error_type.data_type as Class;
					jump_stack.add (new JumpTarget.error_target (new BasicBlock (), catch_clause, null, null, error_class));
				}
			} else {
				jump_stack.add (new JumpTarget.error_target (new BasicBlock (), catch_clause, null, null, null));
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
		List<JumpTarget> catch_stack = new ArrayList<JumpTarget> ();
		for (int i = jump_stack.size - 1; i >= finally_jump_stack_size; i--) {
			var jump_target = jump_stack[i];
			catch_stack.add (jump_target);
			jump_stack.remove_at (i);
		}

		foreach (JumpTarget jump_target in catch_stack) {

			foreach (JumpTarget prev_target in catch_stack) {
				if (prev_target == jump_target) {
					break;
				}

				if (context.profile == Profile.GOBJECT) {
					if (prev_target.error_domain == jump_target.error_domain &&
					    prev_target.error_code == jump_target.error_code) {
						Report.error (stmt.source_reference, "double catch clause of same error detected");
						stmt.error = true;
						return;
					}
				} else if (prev_target.error_class == jump_target.error_class) {
					Report.error (stmt.source_reference, "double catch clause of same error detected");
					stmt.error = true;
					return;
				}
			}

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
			stmt.after_try_block_reachable = false;
			mark_unreachable ();
		}
	}

	public override void visit_lock_statement (LockStatement stmt) {
		if (unreachable (stmt)) {
			return;
		}
	}

	public override void visit_unlock_statement (UnlockStatement stmt) {
		if (unreachable (stmt)) {
			return;
		}
	}

	public override void visit_expression (Expression expr) {
		// lambda expression is handled separately
		if (!(expr is LambdaExpression)) {
			expr.accept_children (this);
		}
	}

	private bool unreachable (CodeNode node) {
		if (current_block == null) {
			node.unreachable = true;
			if (!unreachable_reported) {
				Report.warning (node.source_reference, "unreachable code detected");
				unreachable_reported = true;
			}
			return true;
		}

		return false;
	}

	void mark_unreachable () {
		current_block = null;
		unreachable_reported = false;
	}
}
