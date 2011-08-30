/* valaccodetransformer.vala
 *
 * Copyright (C) 2012  Luca Bruno
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
 * Code visitor for simplyfing the code tree for the C codegen.
 */
public class Vala.CCodeTransformer : CodeTransformer {
	public override void visit_constant (Constant c) {
		c.active = true;
		c.accept_children (this);
	}

	public override void visit_method (Method m) {
		if (m.body == null) {
			return;
		}

		m.accept_children (this);
	}

	public override void visit_creation_method (CreationMethod m) {
		if (m.body == null) {
			return;
		}

		m.accept_children (this);
	}

	public override void visit_block (Block b) {
		b.accept_children (this);

		foreach (LocalVariable local in b.get_local_variables ()) {
			local.active = false;
		}
		foreach (Constant constant in b.get_local_constants ()) {
			constant.active = false;
		}
	}

	public override void visit_local_variable (LocalVariable local) {
		local.active = true;
		local.accept_children (this);
	}

	public override void visit_while_statement (WhileStatement stmt) {
		// convert to simple loop
		begin_replace_statement (stmt);

		if (!stmt.condition.is_always_false ()) {
			b.open_loop ();
			if (!stmt.condition.is_always_true ()) {
				var cond = expression (@"!$(stmt.condition)");
				b.open_if (cond);
				b.add_break ();
				b.close ();
			}
			b.add_statement (stmt.body);
			b.close ();
		}

		stmt.body.checked = false;
		end_replace_statement ();
	}

	public override void visit_expression (Expression expr) {
		if (expr in context.analyzer.replaced_nodes) {
			return;
		}

		base.visit_expression (expr);
	}

	public override void visit_method_call (MethodCall expr) {
		if (expr.tree_can_fail) {
			if (expr.parent_node is LocalVariable || expr.parent_node is ExpressionStatement) {
				// simple statements, no side effects after method call
			} else if (!(context.analyzer.get_current_non_local_symbol (expr) is Block)) {
				// can't handle errors in field initializers
				expr.error = true;
				Report.error (expr.source_reference, "Field initializers must not throw errors");
			} else {
				var formal_target_type = copy_type (expr.target_type);
				var target_type = copy_type (expr.target_type);
				begin_replace_expression (expr);

				var local = b.add_temp_declaration (copy_type (expr.value_type), expr);
				var replacement = return_temp_access (local, expr.value_type, target_type, formal_target_type);

				end_replace_expression (replacement);
			}
		}
	}
}
