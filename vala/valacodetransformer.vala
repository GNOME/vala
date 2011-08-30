/* valacodetransformer.vala
 *
 * Copyright (C) 2011  Luca Bruno
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
 * 	Luca Bruno <lucabru@src.gnome.org>
 */

/**
 * Code visitor for transforming the code tree.
 */
public class Vala.CodeTransformer : CodeVisitor {
	public CodeContext context;

	/**
	 * Transform the code tree for the specified code context.
	 *
	 * @param context a code context
	 */
	public void transform (CodeContext context) {
		this.context = context;

		/* we're only interested in non-pkg source files */
		var source_files = context.get_source_files ();
		foreach (SourceFile file in source_files) {
			if (file.file_type == SourceFileType.SOURCE ||
			    (context.header_filename != null && file.file_type == SourceFileType.FAST)) {
				file.accept (this);
			}
		}
	}

	public void check (CodeNode node) {
		if (!node.check (context)) {
			return;
		}
		//node.accept (this);
	}

	public override void visit_source_file (SourceFile source_file) {
		source_file.accept_children (this);
	}

	public override void visit_namespace (Namespace ns) {
		ns.accept_children (this);
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

	public override void visit_enum_value (EnumValue ev) {
		ev.accept_children (this);
	}

	public override void visit_error_domain (ErrorDomain edomain) {
		edomain.accept_children (this);
	}

	public override void visit_error_code (ErrorCode ecode) {
		ecode.accept_children (this);
	}

	public override void visit_delegate (Delegate d) {
		d.accept_children (this);
	}

	public override void visit_constant (Constant c) {
		c.accept_children (this);
	}

	public override void visit_field (Field f) {
		f.accept_children (this);
	}

	public override void visit_method (Method m) {
		m.accept_children (this);
	}

	public override void visit_creation_method (CreationMethod m) {
		m.accept_children (this);
	}

	public override void visit_formal_parameter (Parameter p) {
		p.accept_children (this);
	}

	public override void visit_property (Property prop) {
		prop.accept_children (this);
	}

	public override void visit_property_accessor (PropertyAccessor acc) {
		acc.accept_children (this);
	}

	public override void visit_signal (Signal sig) {
		sig.accept_children (this);
	}

	public override void visit_constructor (Constructor c) {
		c.accept_children (this);
	}

	public override void visit_destructor (Destructor d) {
		d.accept_children (this);
	}

	public override void visit_block (Block b) {
		b.accept_children (this);
	}

	public override void visit_declaration_statement (DeclarationStatement stmt) {
		stmt.accept_children (this);
	}

	public override void visit_local_variable (LocalVariable local) {
		local.accept_children (this);
	}

	public override void visit_initializer_list (InitializerList list) {
		list.accept_children (this);
	}

	public override void visit_expression_statement (ExpressionStatement stmt) {
		stmt.accept_children (this);
	}

	public override void visit_if_statement (IfStatement stmt) {
		stmt.accept_children (this);
	}

	public override void visit_switch_statement (SwitchStatement stmt) {
		stmt.accept_children (this);
	}

	public override void visit_switch_section (SwitchSection section) {
		section.accept_children (this);
	}

	public override void visit_switch_label (SwitchLabel label) {
		label.accept_children (this);
	}

	bool always_true (Expression condition) {
		var literal = condition as BooleanLiteral;
		return (literal != null && literal.value);
	}

	bool always_false (Expression condition) {
		var literal = condition as BooleanLiteral;
		return (literal != null && !literal.value);
	}

	public override void visit_while_statement (WhileStatement stmt) {
		// convert to simple loop

		if (always_true (stmt.condition)) {
			// do not generate if block if condition is always true
		} else if (always_false (stmt.condition)) {
			// do not generate if block if condition is always false
			stmt.body.insert_statement (0, new BreakStatement (stmt.condition.source_reference));
		} else {
			var if_condition = new UnaryExpression (UnaryOperator.LOGICAL_NEGATION, stmt.condition, stmt.condition.source_reference);
			var true_block = new Block (stmt.condition.source_reference);
			true_block.add_statement (new BreakStatement (stmt.condition.source_reference));
			var if_stmt = new IfStatement (if_condition, true_block, null, stmt.condition.source_reference);
			stmt.body.insert_statement (0, if_stmt);
		}

		var loop = new Loop (stmt.body, stmt.source_reference);

		var parent_block = (Block) stmt.parent_node;
		parent_block.replace_statement (stmt, loop);

		stmt.body.checked = false;
		check (loop);
	}

	public override void visit_do_statement (DoStatement stmt) {
		stmt.accept_children (this);
	}

	public override void visit_for_statement (ForStatement stmt) {
		stmt.accept_children (this);
	}

	public override void visit_foreach_statement (ForeachStatement stmt) {
		stmt.accept_children (this);
	}

	public override void visit_break_statement (BreakStatement stmt) {
		stmt.accept_children (this);
	}

	public override void visit_continue_statement (ContinueStatement stmt) {
		stmt.accept_children (this);
	}

	public override void visit_return_statement (ReturnStatement stmt) {
		stmt.accept_children (this);
	}

	public override void visit_yield_statement (YieldStatement stmt) {
		stmt.accept_children (this);
	}

	public override void visit_throw_statement (ThrowStatement stmt) {
		stmt.accept_children (this);
	}

	public override void visit_try_statement (TryStatement stmt) {
		stmt.accept_children (this);
	}

	public override void visit_catch_clause (CatchClause clause) {
		clause.accept_children (this);
	}

	public override void visit_lock_statement (LockStatement stmt) {
		stmt.accept_children (this);
	}

	public override void visit_unlock_statement (UnlockStatement stmt) {
		stmt.accept_children (this);
	}

	public override void visit_delete_statement (DeleteStatement stmt) {
		stmt.accept_children (this);
	}

	public override void visit_expression (Expression expr) {
		expr.accept_children (this);
	}

	public override void visit_method_call (MethodCall expr) {
		if (expr.tree_can_fail) {
			if (expr.parent_node is LocalVariable || expr.parent_node is ExpressionStatement) {
				// simple statements, no side effects after method call
			} else if (!(context.analyzer.get_current_non_local_symbol (expr) is Block)) {
				// can't handle errors in field initializers
				Report.error (expr.source_reference, "Field initializers must not throw errors");
			} else {
				// store parent_node as we need to replace the expression in the old parent node later on
				var old_parent_node = expr.parent_node;

				var local = new LocalVariable (expr.value_type, expr.get_temp_name (), null, expr.source_reference);
				var decl = new DeclarationStatement (local, expr.source_reference);

				expr.insert_statement (context.analyzer.get_insert_block (expr), decl);

				var temp_access = SemanticAnalyzer.create_temp_access (local, expr.target_type);

				// don't set initializer earlier as this changes parent_node and parent_statement
				local.initializer = expr;
				check (decl);

				// move temp variable to insert block to ensure
				// variable is in the same block as the declarat
				// otherwise there will be scoping issues in the
				var block = context.analyzer.get_current_block (expr);
				block.remove_local_variable (local);
				context.analyzer.get_insert_block (expr).add_local_variable (local);

				old_parent_node.replace_expression (expr, temp_access);
				check (temp_access);
			}
		}
	}
}
