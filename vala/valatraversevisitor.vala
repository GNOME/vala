/* valatraversevisitor.vala
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
 * Code visitor for traversing the tree with a simple callback
 */
public class Vala.TraverseVisitor : CodeVisitor {
	private TraverseFunc func;

	public TraverseVisitor (owned TraverseFunc func) {
		this.func = (owned) func;
	}

	public override void visit_namespace (Namespace ns) {
		if (func (ns) == TraverseStatus.CONTINUE) {
			ns.accept_children (this);
		}
	}

	public override void visit_class (Class cl) {
		if (func (cl) == TraverseStatus.CONTINUE) {
			cl.accept_children (this);
		}
	}

	public override void visit_struct (Struct st) {
		if (func (st) == TraverseStatus.CONTINUE) {
			st.accept_children (this);
		}
	}

	public override void visit_interface (Interface iface) {
		if (func (iface) == TraverseStatus.CONTINUE) {
			iface.accept_children (this);
		}
	}

	public override void visit_enum (Enum en) {
		if (func (en) == TraverseStatus.CONTINUE) {
			en.accept_children (this);
		}
	}

	public override void visit_enum_value (EnumValue ev) {
		if (func (ev) == TraverseStatus.CONTINUE) {
			ev.accept_children (this);
		}
	}

	public override void visit_error_domain (ErrorDomain edomain) {
		if (func (edomain) == TraverseStatus.CONTINUE) {
			edomain.accept_children (this);
		}
	}

	public override void visit_error_code (ErrorCode ecode) {
		if (func (ecode) == TraverseStatus.CONTINUE) {
			ecode.accept_children (this);
		}
	}

	public override void visit_delegate (Delegate d) {
		if (func (d) == TraverseStatus.CONTINUE) {
			d.accept_children (this);
		}
	}

	public override void visit_constant (Constant c) {
		if (func (c) == TraverseStatus.CONTINUE) {
			c.accept_children (this);
		}
	}

	public override void visit_field (Field f) {
		if (func (f) == TraverseStatus.CONTINUE) {
			f.accept_children (this);
		}
	}

	public override void visit_method (Method m) {
		if (func (m) == TraverseStatus.CONTINUE) {
			m.accept_children (this);
		}
	}

	public override void visit_creation_method (CreationMethod m) {
		if (func (m) == TraverseStatus.CONTINUE) {
			m.accept_children (this);
		}
	}

	public override void visit_formal_parameter (Parameter p) {
		if (func (p) == TraverseStatus.CONTINUE) {
			p.accept_children (this);
		}
	}

	public override void visit_property (Property prop) {
		if (func (prop) == TraverseStatus.CONTINUE) {
			prop.accept_children (this);
		}
	}

	public override void visit_property_accessor (PropertyAccessor acc) {
		if (func (acc) == TraverseStatus.CONTINUE) {
			acc.accept_children (this);
		}
	}

	public override void visit_signal (Signal sig) {
		if (func (sig) == TraverseStatus.CONTINUE) {
			sig.accept_children (this);
		}
	}

	public override void visit_constructor (Constructor c) {
		if (func (c) == TraverseStatus.CONTINUE) {
			c.accept_children (this);
		}
	}

	public override void visit_destructor (Destructor d) {
		if (func (d) == TraverseStatus.CONTINUE) {
			d.accept_children (this);
		}
	}

	public override void visit_block (Block b) {
		if (func (b) == TraverseStatus.CONTINUE) {
			b.accept_children (this);
		}
	}

	public override void visit_declaration_statement (DeclarationStatement stmt) {
		if (func (stmt) == TraverseStatus.CONTINUE) {
			stmt.accept_children (this);
		}
	}

	public override void visit_local_variable (LocalVariable local) {
		if (func (local) == TraverseStatus.CONTINUE) {
			local.accept_children (this);
		}
	}

	public override void visit_initializer_list (InitializerList list) {
		if (func (list) == TraverseStatus.CONTINUE) {
			list.accept_children (this);
		}
	}

	public override void visit_expression_statement (ExpressionStatement stmt) {
		if (func (stmt) == TraverseStatus.CONTINUE) {
			stmt.accept_children (this);
		}
	}

	public override void visit_if_statement (IfStatement stmt) {
		if (func (stmt) == TraverseStatus.CONTINUE) {
			stmt.accept_children (this);
		}
	}

	public override void visit_switch_statement (SwitchStatement stmt) {
		if (func (stmt) == TraverseStatus.CONTINUE) {
			stmt.accept_children (this);
		}
	}

	public override void visit_switch_section (SwitchSection section) {
		if (func (section) == TraverseStatus.CONTINUE) {
			section.accept_children (this);
		}
	}

	public override void visit_switch_label (SwitchLabel label) {
		if (func (label) == TraverseStatus.CONTINUE) {
			label.accept_children (this);
		}
	}

	public override void visit_loop (Loop loop) {
		if (func (loop) == TraverseStatus.CONTINUE) {
			loop.accept_children (this);
		}
	}

	public override void visit_while_statement (WhileStatement stmt) {
		if (func (stmt) == TraverseStatus.CONTINUE) {
			stmt.accept_children (this);
		}
	}

	public override void visit_do_statement (DoStatement stmt) {
		if (func (stmt) == TraverseStatus.CONTINUE) {
			stmt.accept_children (this);
		}
	}

	public override void visit_for_statement (ForStatement stmt) {
		if (func (stmt) == TraverseStatus.CONTINUE) {
			stmt.accept_children (this);
		}
	}

	public override void visit_foreach_statement (ForeachStatement stmt) {
		if (func (stmt) == TraverseStatus.CONTINUE) {
			stmt.accept_children (this);
		}
	}

	public override void visit_break_statement (BreakStatement stmt) {
		if (func (stmt) == TraverseStatus.CONTINUE) {
			stmt.accept_children (this);
		}
	}

	public override void visit_continue_statement (ContinueStatement stmt) {
		if (func (stmt) == TraverseStatus.CONTINUE) {
			stmt.accept_children (this);
		}
	}

	public override void visit_return_statement (ReturnStatement stmt) {
		if (func (stmt) == TraverseStatus.CONTINUE) {
			stmt.accept_children (this);
		}
	}

	public override void visit_yield_statement (YieldStatement stmt) {
		if (func (stmt) == TraverseStatus.CONTINUE) {
			stmt.accept_children (this);
		}
	}

	public override void visit_throw_statement (ThrowStatement stmt) {
		if (func (stmt) == TraverseStatus.CONTINUE) {
			stmt.accept_children (this);
		}
	}

	public override void visit_try_statement (TryStatement stmt) {
		if (func (stmt) == TraverseStatus.CONTINUE) {
			stmt.accept_children (this);
		}
	}

	public override void visit_catch_clause (CatchClause clause) {
		if (func (clause) == TraverseStatus.CONTINUE) {
			clause.accept_children (this);
		}
	}

	public override void visit_lock_statement (LockStatement stmt) {
		if (func (stmt) == TraverseStatus.CONTINUE) {
			stmt.accept_children (this);
		}
	}

	public override void visit_unlock_statement (UnlockStatement stmt) {
		if (func (stmt) == TraverseStatus.CONTINUE) {
			stmt.accept_children (this);
		}
	}

	public override void visit_delete_statement (DeleteStatement stmt) {
		if (func (stmt) == TraverseStatus.CONTINUE) {
			stmt.accept_children (this);
		}
	}

	public override void visit_member_access (MemberAccess expr) {
		if (func (expr) == TraverseStatus.CONTINUE) {
			expr.accept_children (this);
		}
	}

	public override void visit_assignment (Assignment expr) {
		if (func (expr) == TraverseStatus.CONTINUE) {
			expr.accept_children (this);
		}
	}

	public override void visit_method_call (MethodCall expr) {
		if (func (expr) == TraverseStatus.CONTINUE) {
			expr.accept_children (this);
		}
	}

	public override void visit_conditional_expression (ConditionalExpression expr) {
		if (func (expr) == TraverseStatus.CONTINUE) {
			expr.accept_children (this);
		}
	}

	public override void visit_binary_expression (BinaryExpression expr) {
		if (func (expr) == TraverseStatus.CONTINUE) {
			expr.accept_children (this);
		}
	}

	public override void visit_unary_expression (UnaryExpression expr) {
		if (func (expr) == TraverseStatus.CONTINUE) {
			expr.accept_children (this);
		}
	}

	public override void visit_reference_transfer_expression (ReferenceTransferExpression expr) {
		if (func (expr) == TraverseStatus.CONTINUE) {
			expr.accept_children (this);
		}
	}

	public override void visit_object_creation_expression (ObjectCreationExpression expr) {
		if (func (expr) == TraverseStatus.CONTINUE) {
			expr.accept_children (this);
		}
	}

	public override void visit_postfix_expression (PostfixExpression expr) {
		if (func (expr) == TraverseStatus.CONTINUE) {
			expr.accept_children (this);
		}
	}

	public override void visit_array_creation_expression (ArrayCreationExpression expr) {
		if (func (expr) == TraverseStatus.CONTINUE) {
			expr.accept_children (this);
		}
	}

	public override void visit_cast_expression (CastExpression expr) {
		if (func (expr) == TraverseStatus.CONTINUE) {
			expr.accept_children (this);
		}
	}

	public override void visit_element_access (ElementAccess expr) {
		if (func (expr) == TraverseStatus.CONTINUE) {
			expr.accept_children (this);
		}
	}

	public override void visit_lambda_expression (LambdaExpression expr) {
		if (func (expr) == TraverseStatus.CONTINUE) {
			expr.accept_children (this);
		}
	}

	public override void visit_pointer_indirection (PointerIndirection expr) {
		if (func (expr) == TraverseStatus.CONTINUE) {
			expr.accept_children (this);
		}
	}

	public override void visit_addressof_expression (AddressofExpression expr) {
		if (func (expr) == TraverseStatus.CONTINUE) {
			expr.accept_children (this);
		}
	}

	public override void visit_slice_expression (SliceExpression expr) {
		if (func (expr) == TraverseStatus.CONTINUE) {
			expr.accept_children (this);
		}
	}
}

public enum Vala.TraverseStatus {
	STOP,
	CONTINUE
}

public delegate Vala.TraverseStatus Vala.TraverseFunc (CodeNode node);
