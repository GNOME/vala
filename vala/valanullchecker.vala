/* valanullchecker.vala
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

/**
 * Code visitor checking null references.
 */
public class Vala.NullChecker : CodeVisitor {
	private CodeContext context;

	DataType current_return_type;

	public NullChecker () {
	}

	public void check (CodeContext context) {
		this.context = context;

		context.accept (this);
	}

	void check_compatible (Expression expr, DataType target_type) {
		if (!target_type.nullable) {
			if (expr.value_type is NullType) {
				Report.error (expr.source_reference, "`null' incompatible with `%s'".printf (target_type.to_string ()));
			} else if (expr.value_type.nullable) {
				Report.warning (expr.source_reference, "`%s' incompatible with `%s'".printf (expr.value_type.to_string (), target_type.to_string ()));
			}
		}
	}

	void check_non_null (Expression expr) {
		if (expr.value_type is NullType) {
			Report.error (expr.source_reference, "null dereference");
		} else if (expr.value_type.nullable) {
			Report.warning (expr.source_reference, "possible null dereference");
		}
	}

	public override void visit_source_file (SourceFile file) {
		file.accept_children (this);
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
		f.accept_children (this);
	}

	public override void visit_method (Method m) {
		var old_return_type = current_return_type;
		current_return_type = m.return_type;

		m.accept_children (this);

		current_return_type = old_return_type;
	}

	public override void visit_creation_method (CreationMethod m) {
		m.accept_children (this);
	}

	public override void visit_formal_parameter (FormalParameter p) {
		p.accept_children (this);

		if (p.default_expression != null) {
			check_compatible (p.default_expression, p.parameter_type);
		}
	}

	public override void visit_property (Property prop) {
		prop.accept_children (this);
	}

	public override void visit_property_accessor (PropertyAccessor acc) {
		acc.accept_children (this);
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

	public override void visit_local_variable (LocalVariable local) {
		local.accept_children (this);

		if (local.initializer != null) {
			check_compatible (local.initializer, local.variable_type);
		}
	}

	public override void visit_if_statement (IfStatement stmt) {
		stmt.accept_children (this);

		check_non_null (stmt.condition);
	}

	public override void visit_switch_section (SwitchSection section) {
		section.accept_children (this);
	}

	public override void visit_while_statement (WhileStatement stmt) {
		stmt.accept_children (this);

		check_non_null (stmt.condition);
	}

	public override void visit_do_statement (DoStatement stmt) {
		stmt.accept_children (this);

		check_non_null (stmt.condition);
	}

	public override void visit_for_statement (ForStatement stmt) {
		stmt.accept_children (this);

		check_non_null (stmt.condition);
	}

	public override void visit_foreach_statement (ForeachStatement stmt) {
		stmt.accept_children (this);

		check_non_null (stmt.collection);
	}

	public override void visit_return_statement (ReturnStatement stmt) {
		stmt.accept_children (this);

		if (stmt.return_expression != null) {
			check_compatible (stmt.return_expression, current_return_type);
		}
	}

	public override void visit_throw_statement (ThrowStatement stmt) {
		stmt.accept_children (this);

		check_non_null (stmt.error_expression);
	}

	public override void visit_try_statement (TryStatement stmt) {
		stmt.accept_children (this);
	}

	public override void visit_catch_clause (CatchClause clause) {
		clause.accept_children (this);
	}

	public override void visit_delete_statement (DeleteStatement stmt) {
		stmt.accept_children (this);
	}

	public override void visit_invocation_expression (InvocationExpression expr) {
		expr.accept_children (this);

		var mtype = expr.call.value_type as MethodType;
		var ma = expr.call as MemberAccess;
		if (mtype != null && mtype.method_symbol.binding == MemberBinding.INSTANCE && ma != null) {
			check_non_null (ma.inner);
		}
	}

	public override void visit_element_access (ElementAccess expr) {
		check_non_null (expr.container);
	}

	public override void visit_postfix_expression (PostfixExpression expr) {
		check_non_null (expr.inner);
	}

	public override void visit_unary_expression (UnaryExpression expr) {
		switch (expr.operator) {
		case UnaryOperator.PLUS:
		case UnaryOperator.MINUS:
		case UnaryOperator.LOGICAL_NEGATION:
		case UnaryOperator.BITWISE_COMPLEMENT:
		case UnaryOperator.INCREMENT:
		case UnaryOperator.DECREMENT:
			check_non_null (expr.inner);
			break;
		}
	}

	public override void visit_reference_transfer_expression (ReferenceTransferExpression expr) {
		expr.accept_children (this);
	}

	public override void visit_conditional_expression (ConditionalExpression expr) {
		check_non_null (expr.condition);
	}

	public override void visit_lambda_expression (LambdaExpression l) {
		l.accept_children (this);
	}

	public override void visit_assignment (Assignment a) {
		a.accept_children (this);

		check_compatible (a.right, a.left.value_type);
	}
}
