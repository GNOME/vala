/* valaabstractinterpreter.vala
 *
 * Copyright (C) 2009  Jürg Billeter
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

public class Vala.AbstractInterpreter : CodeVisitor {
	CodeContext context;

	State current_state;
	List<State> loop_init_states;
	State loop_exit_state;
	List<State> try_exit_states;
	List<State> switch_exit_states;
	List<State> method_exit_states;

	BooleanType true_type;
	BooleanType false_type;

	abstract class Statement {
		public abstract bool equal (Statement stmt);

		public virtual Ternary implies (Ternary value, Statement stmt) {
			return Ternary.UNKNOWN;
		}

		public abstract string to_string ();
	}

	class VariableStatement : Statement {
		public LocalVariable local;
		public DataType data_type;

		public VariableStatement (LocalVariable local, DataType data_type) {
			this.local = local;
			this.data_type = data_type;
		}

		public override bool equal (Statement stmt) {
			var var_stmt = stmt as VariableStatement;
			if (var_stmt == null) {
				return false;
			}

			return var_stmt.local == local && var_stmt.data_type.compatible (data_type) && data_type.compatible (var_stmt.data_type);
		}

		public override Ternary implies (Ternary value, Statement stmt) {
			var var_stmt = stmt as VariableStatement;
			if (var_stmt == null) {
				return Ternary.UNKNOWN;
			}

			if (var_stmt.local != local) {
				return Ternary.UNKNOWN;
			}

			bool maybe_compatible = false;

			if (data_type.compatible (var_stmt.data_type)) {
				if (value == Ternary.TRUE) {
					return Ternary.TRUE;
				} else {
					maybe_compatible = true;
				}
			}
			if (var_stmt.data_type.compatible (data_type)) {
				if (value == Ternary.FALSE) {
					return Ternary.FALSE;
				} else {
					maybe_compatible = true;
				}
			}
			if (data_type.data_type is Interface || var_stmt.data_type.data_type is Interface) {
				// if either type is an interface, it might be compatible
				maybe_compatible = true;
			}

			if (!maybe_compatible && value == Ternary.TRUE) {
				// fully incompatible type
				return Ternary.FALSE;
			} else {
				return Ternary.UNKNOWN;
			}
		}

		public override string to_string () {
			var bool_type = data_type as BooleanType;
			if (bool_type != null && bool_type.value_set) {
				return "%s is %s".printf (local.name, bool_type.value.to_string ());
			} else {
				return "%s is %s".printf (local.name, data_type.to_string ());
			}
		}
	}

	class ErrorStatement : Statement {
		public ErrorType? error_type;

		public override bool equal (Statement stmt) {
			var error_stmt = stmt as ErrorStatement;
			if (error_stmt == null) {
				return false;
			}

			if (error_type == null || error_stmt.error_type == null) {
				return error_type == error_stmt.error_type;
			}

			return error_stmt.error_type.compatible (error_type) && error_type.compatible (error_stmt.error_type);
		}

		public override Ternary implies (Ternary value, Statement stmt) {
			var error_stmt = stmt as ErrorStatement;
			if (error_stmt == null) {
				return Ternary.UNKNOWN;
			}

			if (error_stmt.error_type == error_type) {
				return value;
			}

			if (error_type == null) {
				// no error
				if (value == Ternary.TRUE) {
					return Ternary.FALSE;
				}
			}
			if (error_stmt.error_type == null) {
				if (value == Ternary.TRUE) {
					return Ternary.FALSE;
				}
			}

			bool maybe_compatible = false;

			if (error_type.compatible (error_stmt.error_type)) {
				if (value == Ternary.TRUE) {
					return Ternary.TRUE;
				} else {
					maybe_compatible = true;
				}
			}
			if (error_stmt.error_type.compatible (error_type)) {
				if (value == Ternary.FALSE) {
					return Ternary.FALSE;
				} else {
					maybe_compatible = true;
				}
			}

			if (!maybe_compatible && value == Ternary.TRUE) {
				// fully incompatible type
				return Ternary.FALSE;
			} else {
				return Ternary.UNKNOWN;
			}
		}

		public override string to_string () {
			if (error_type == null) {
				return "no error";
			} else {
				return "error is %s".printf (error_type.to_string ());
			}
		}
	}

	class FalseStatement : Statement {
		public override bool equal (Statement stmt) {
			return stmt is FalseStatement;
		}

		public override Ternary implies (Ternary value, Statement stmt) {
			if (value == Ternary.TRUE) {
				return Ternary.TRUE;
			}

			return Ternary.UNKNOWN;
		}

		public override string to_string () {
			return "false";
		}
	}

	enum Ternary {
		UNKNOWN,
		TRUE,
		FALSE
	}

	class State {
		public List<Statement> statements = new ArrayList<Statement> ();

		int n_valid_states = 1;
		public char[,] values = new char[4,4];

		public State copy () {
			var result = new State ();
			foreach (var statement in statements) {
				result.statements.add (statement);
			}
			result.values = values;
			result.n_valid_states = n_valid_states;
			return result;
		}

		void maybe_resize (int n_states, int n_statements) {
			bool do_resize = false;
			int new_n_states = values.length[0];
			int new_n_statements = values.length[1];
			while (new_n_states < n_states) {
				new_n_states *= 2;
				do_resize = true;
			}
			while (new_n_statements < n_statements) {
				new_n_statements *= 2;
				do_resize = true;
			}

			if (do_resize) {
				var new_values = new char[new_n_states, new_n_statements];
				for (int i = 0; i < values.length[0]; i++) {
					for (int j = 0; j < values.length[1]; j++) {
						new_values[i,j] = values[i,j];
					}
				}
				values = (owned) new_values;
			}
		}

		int get_statement (Statement stmt) {
			int stmt_index = -1;
			int stmt_i = 0;
			foreach (var statement in statements) {
				if (stmt.equal (statement)) {
					stmt_index = stmt_i;
					break;
				}
				stmt_i++;
			}
			return stmt_index;
		}

		int ensure_statement (Statement stmt) {
			int stmt_index = get_statement (stmt);
			if (stmt_index < 0) {
				// add new statement to array
				stmt_index = statements.size;
				statements.add (stmt);
				maybe_resize (n_valid_states, statements.size);
				// ensure that entailment is followed
				for (int stmt_i = 0; stmt_i < stmt_index; stmt_i++) {
					for (int state = 0; state < n_valid_states; state++) {
						Ternary t = statements[stmt_i].implies ((Ternary) values[state,stmt_i], stmt);
						if (t != Ternary.UNKNOWN) {
							values[state,stmt_index] = t;
						}
					}
				}
			}
			return stmt_index;
		}

		public void unset_variable (LocalVariable local) {
			for (int i = 0; i < statements.size; i++) {
				var var_stmt = statements[i] as VariableStatement;
				if (var_stmt != null && var_stmt.local == local) {
					// remove statement
					for (int state = 0; state < n_valid_states; state++) {
						values[state,i] = values[state,statements.size - 1];
						values[state,statements.size - 1] = Ternary.UNKNOWN;
					}
					statements[i] = statements[statements.size - 1];
					statements.remove_at (statements.size - 1);

					i--;
					continue;
				}
			}
		}

		public void assert (List<Statement> disjunction) {
			if (disjunction.size == 0) {
				// assert nothing
				return;
			}

			// ensure we have all statements of the disjunction in the array
			int[] stmt_index = new int[disjunction.size];
			int assert_stmt_index = 0;
			foreach (var assert_statement in disjunction) {
				stmt_index[assert_stmt_index] = ensure_statement (assert_statement);;
				assert_stmt_index++;
			}

			for (int state = 0; state < n_valid_states; state++) {
				bool is_true = false;
				int n_unknown = 0;
				int[] unknown_index = new int[disjunction.size];
				for (int i = 0; i < disjunction.size; i++) {
					Ternary t = (Ternary) values[state,stmt_index[i]];
					if (t == Ternary.TRUE) {
						is_true = true;
						break;
					} else if (t == Ternary.UNKNOWN) {
						unknown_index[n_unknown] = i;
						n_unknown++;
					}
				}
				if (is_true) {
					// disjunction already true in this state, nothing to do
					continue;
				} else {
					if (n_unknown > 0) {
						n_valid_states += n_unknown;
						maybe_resize (n_valid_states, statements.size);
						for (int j = 0; j < n_unknown; j++) {
							for (int i = 0; i < statements.size; i++) {
								Ternary t = (Ternary) values[state,i];
								Ternary u = disjunction[unknown_index[j]].implies (Ternary.TRUE, statements[i]);
								if (u != Ternary.UNKNOWN) {
									t = u;
								}
								values[n_valid_states - n_unknown + j,i] = t;
							}
							values[n_valid_states - n_unknown + j,stmt_index[unknown_index[j]]] = Ternary.TRUE;
						}
					}

					// remove state
					for (int i = 0; i < statements.size; i++) {
						values[state,i] = values[n_valid_states - 1,i];
						values[n_valid_states - 1,i] = Ternary.UNKNOWN;
					}
					n_valid_states--;

					state--;
					continue;
				}
			}
		}

		Ternary check (List<Statement> disjunction) {
			// true => true
			int[] conditions11 = {};
			// false => true
			int[] conditions01 = {};
			// true => false
			int[] conditions10 = {};
			// false => false
			int[] conditions00 = {};
			for (int i = 0; i < statements.size; i++) {
				foreach (var stmt in disjunction) {
					if (statements[i].implies (Ternary.TRUE, stmt) == Ternary.TRUE) {
						conditions11 += i;
					}
					if (statements[i].implies (Ternary.FALSE, stmt) == Ternary.TRUE) {
						conditions01 += i;
					}
					if (statements[i].implies (Ternary.TRUE, stmt) == Ternary.FALSE) {
						conditions10 += i;
					}
					if (statements[i].implies (Ternary.FALSE, stmt) == Ternary.FALSE) {
						conditions00 += i;
					}
				}
			}

			int n_true = 0, n_false = 0, n_unknown = 0;
			for (int state = 0; state < n_valid_states; state++) {
				bool is_true = false, is_false = false;
				foreach (int i in conditions11) {
					if (values[state,i] == Ternary.TRUE) {
						is_true = true;
						break;
					}
				}
				foreach (int i in conditions01) {
					if (values[state,i] == Ternary.FALSE) {
						is_true = true;
						break;
					}
				}
				foreach (int i in conditions10) {
					if (values[state,i] == Ternary.TRUE) {
						is_false = true;
						break;
					}
				}
				foreach (int i in conditions00) {
					if (values[state,i] == Ternary.FALSE) {
						is_false = true;
						break;
					}
				}
				if (is_true) {
					n_true++;
				} else if (is_false) {
					n_false++;
				} else {
					n_unknown++;
				}
			}

			if (n_false == 0 && n_unknown == 0) {
				return Ternary.TRUE;
			} else if (n_true == 0 && n_unknown == 0) {
				return Ternary.FALSE;
			} else {
				return Ternary.UNKNOWN;
			}
		}

		public bool is_true (List<Statement> disjunction) {
			return check (disjunction) == Ternary.TRUE;
		}

		public bool is_false (List<Statement> disjunction) {
			return check (disjunction) == Ternary.FALSE;
		}

		public bool maybe_true (List<Statement> disjunction) {
			return check (disjunction) != Ternary.FALSE;
		}

		public bool maybe_false (List<Statement> disjunction) {
			return check (disjunction) != Ternary.TRUE;
		}

		public static bool equal (State state1, State state2) {
			if (state1.statements.size != state2.statements.size) {
				return false;
			}
			int[] mapping = new int[state1.statements.size];
			for (int i = 0; i < state2.statements.size; i++) {
				int stmt_index = state1.get_statement (state2.statements[i]);
				if (stmt_index < 0) {
					return false;
				}
				mapping[stmt_index] = i;
			}
			for (int s1 = 0; s1 < state1.n_valid_states; s1++) {
				bool found = false;
				for (int s2 = 0; s2 < state2.n_valid_states; s2++) {
					found = true;
					for (int i = 0; i < mapping.length; i++) {
						if (state1.values[s1,i] != state2.values[s2,mapping[i]]) {
							found = false;
							break;
						}
					}
					if (found) {
						break;
					}
				}
				if (!found) {
					return false;
				}
			}
			for (int s2 = 0; s2 < state2.n_valid_states; s2++) {
				bool found = false;
				for (int s1 = 0; s1 < state1.n_valid_states; s1++) {
					found = true;
					for (int i = 0; i < mapping.length; i++) {
						if (state1.values[s1,i] != state2.values[s2,mapping[i]]) {
							found = false;
							break;
						}
					}
					if (found) {
						break;
					}
				}
				if (!found) {
					return false;
				}
			}
			return true;
		}

		public static State union (State state1, State state2) {
			var copy2 = state2.copy ();
			foreach (var stmt in state1.statements) {
				copy2.ensure_statement (stmt);
			}

			var result = state1.copy ();
			int[] mapping = new int[copy2.statements.size];
			for (int i = 0; i < copy2.statements.size; i++) {
				mapping[result.ensure_statement (copy2.statements[i])] = i;
			}
			result.n_valid_states += copy2.n_valid_states;
			result.maybe_resize (result.n_valid_states, result.statements.size);
			for (int state = 0; state < copy2.n_valid_states; state++) {
				for (int i = 0; i < result.statements.size; i++) {
					result.values[state1.n_valid_states + state, i] = copy2.values[state,mapping[i]];
				}
			}
			return result;
		}

		public void print () {
			for (int state = 0; state < n_valid_states; state++) {
				stderr.printf ("\tState %d: ", state);
				for (int i = 0; i < statements.size; i++) {
					switch (values[state, i]) {
					case Ternary.TRUE:
						stderr.printf ("%s, ", statements[i].to_string ());
						break;
					case Ternary.FALSE:
						stderr.printf ("!(%s), ", statements[i].to_string ());
						break;
					default:
						break;
					}
				}
				stderr.printf ("\n");
			}
		}
	}

	public AbstractInterpreter () {
	}

	public void run (CodeContext context) {
		this.context = context;

		true_type = new BooleanType ((Struct) context.root.scope.lookup ("bool"));
		true_type.value = true;
		true_type.value_set = true;

		false_type = new BooleanType ((Struct) context.root.scope.lookup ("bool"));
		false_type.value = false;
		false_type.value_set = true;

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

	List<Statement> create_list (Statement? stmt) {
		var result = new ArrayList<Statement> ();
		if (stmt != null) {
			result.add (stmt);
		}
		return result;
	}

	public override void visit_method (Method m) {
		if (m.body == null) {
			return;
		}

		current_state = new State ();

		// no error has happened when entering the method
		current_state.assert (create_list (new ErrorStatement ()));

		m.body.accept (this);

		current_state = null;
	}

	public override void visit_block (Block b) {
		b.accept_children (this);
	}

	bool unreachable (CodeNode? node = null) {
		if (current_state.is_true (create_list (new FalseStatement ()))) {
			if (node != null) {
				Report.warning (node.source_reference, "unreachable code");
			}
			return true;
		}
		return false;
	}

	public override void visit_declaration_statement (DeclarationStatement stmt) {
		visit_statement (stmt);

		var local = stmt.declaration as LocalVariable;
		if (local != null && local.initializer != null) {
			current_state.assert (create_list (new VariableStatement (local, local.initializer.value_type)));
		}
	}

	void visit_statement (Vala.Statement stmt) {
		if (unreachable (stmt)) {
			return;
		}

		var used_variables = new ArrayList<LocalVariable> ();
		stmt.get_used_variables (used_variables);
		foreach (var local in used_variables) {
			if (current_state.maybe_false (create_list (new VariableStatement (local, local.variable_type)))) {
				Report.error (stmt.source_reference, "use of possibly unassigned local variable `%s'".printf (local.name));
			}
		}

		var variables = new ArrayList<LocalVariable> ();
		var types = new ArrayList<DataType> ();
		stmt.get_assumptions (variables, types);
		for (int i = 0; i < variables.size; i++) {
			if (current_state.maybe_false (create_list (new VariableStatement (variables[i], types[i])))) {
				Report.error (stmt.source_reference, "cannot convert `%s' from `%s' to `%s'".printf (variables[i].name, variables[i].variable_type.to_string (), types[i].to_string ()));
			}
		}
	}

	public override void visit_expression_statement (ExpressionStatement stmt) {
		visit_statement (stmt);

		var assign = stmt.expression as Assignment;
		if (assign != null) {
			var local = assign.left.symbol_reference as LocalVariable;
			if (local != null) {
				current_state.unset_variable (local);
				current_state.assert (create_list (new VariableStatement (local, assign.right.value_type)));
			}
		}
	}

	public override void visit_if_statement (IfStatement stmt) {
		visit_statement (stmt);

		var before_state = current_state;
		State true_state = before_state.copy ();
		State false_state = before_state.copy ();

		var be = stmt.condition as BinaryExpression;
		var ue = stmt.condition as UnaryExpression;
		if (be != null && be.operator == BinaryOperator.INEQUALITY && (be.left is NullLiteral || be.right is NullLiteral)) {
			var local = be.left.symbol_reference as LocalVariable;
			if (local == null) {
				local = be.right.symbol_reference as LocalVariable;
			}
			if (local != null) {
				var non_null_type = local.variable_type.copy ();
				non_null_type.nullable = false;
				if (before_state.is_false (create_list (new VariableStatement (local, non_null_type)))) {
					// unreachable
					true_state.assert (create_list (new FalseStatement ()));
				}
				true_state.assert (create_list (new VariableStatement (local, non_null_type)));
			}
		} else if (ue != null && ue.operator == UnaryOperator.LOGICAL_NEGATION) {
			var local = ue.inner.symbol_reference as LocalVariable;
			if (local != null) {
				if (before_state.is_true (create_list (new VariableStatement (local, true_type)))) {
					// true unreachable
					true_state.assert (create_list (new FalseStatement ()));
				} else if (before_state.is_true (create_list (new VariableStatement (local, false_type)))) {
					// false unreachable
					false_state.assert (create_list (new FalseStatement ()));
				}
				true_state.assert (create_list (new VariableStatement (local, false_type)));
				false_state.assert (create_list (new VariableStatement (local, true_type)));
			}
		}

		/*stderr.printf ("before if state:\n");
		before_state.print ();
		stderr.printf ("if true init state:\n");
		true_state.print ();
		stderr.printf ("if false init state:\n");
		false_state.print ();*/

		current_state = true_state;
		stmt.true_statement.accept (this);
		true_state = current_state;

		if (stmt.false_statement != null) {
			current_state = false_state;
			stmt.false_statement.accept (this);
			false_state = current_state;
		}

		current_state = State.union (true_state, false_state);

		/*stderr.printf ("after if state:\n");
		current_state.print ();*/
	}

	void add_loop_init_state () {
		foreach (var state in loop_init_states) {
			if (State.equal (state, current_state)) {
				return;
			}
		}
		loop_init_states.add (current_state);
		/*stderr.printf ("added loop init state %d:", loop_init_states.size - 1);
		current_state.print ();*/
	}

	public override void visit_loop (Loop stmt) {
		visit_statement (stmt);

		loop_init_states = new ArrayList<State> ();
		loop_init_states.add (current_state);

		loop_exit_state = new State ();
		// unreachable so far
		loop_exit_state.assert (create_list (new FalseStatement ()));

		for (int i = 0; i < loop_init_states.size; i++) {
			current_state = loop_init_states[i].copy ();

			/*stderr.printf ("loop init state %d\n", i);
			current_state.print ();*/

			stmt.body.accept (this);

			//stderr.printf ("end of loop body\n");

			if (!unreachable ()) {
				add_loop_init_state ();
			}
		}

		current_state = loop_exit_state;

		/*stderr.printf ("loop exit state\n");
		current_state.print ();*/
	}

	public override void visit_break_statement (BreakStatement stmt) {
		// TODO support break in switch statement

		loop_exit_state = State.union (loop_exit_state, current_state);
		// statements after break unreachable
		current_state.assert (create_list (new FalseStatement ()));
	}
}
