/* valaexpression.vala
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
 * Base class for all code nodes that might be used as an expression.
 */
public abstract class Vala.Expression : CodeNode {
	/**
	 * The static type of the value of this expression.
	 *
	 * The semantic analyzer computes this value.
	 */
	public DataType value_type { get; set; }

	public DataType? formal_value_type { get; set; }

	/*
	 * The static type this expression is expected to have.
	 *
	 * The semantic analyzer computes this value, lambda expressions use it.
	 */
	public DataType target_type { get; set; }

	public DataType? formal_target_type { get; set; }

	/**
	 * The symbol this expression refers to.
	 */
	public weak Symbol symbol_reference { get; set; }

	/**
	 * Specifies that this expression is used as lvalue, i.e. the
	 * left hand side of an assignment.
	 */
	public bool lvalue { get; set; }

	public TargetValue? target_value { get; set; }

	/**
	 * Returns whether this expression is constant, i.e. whether this
	 * expression only consists of literals and other constants.
	 */
	public virtual bool is_constant () {
		return false;
	}

	/**
	 * Returns whether this expression is pure, i.e. whether this expression
	 * is free of side-effects.
	 */
	public abstract bool is_pure ();

	/**
	 * Returns whether this expression is guaranteed to be non-null.
	 */
	public virtual bool is_non_null () {
		return false;
	}

	/**
	 * Check whether symbol_references in this expression are at least
	 * as accessible as the specified symbol.
	 */
	public virtual bool is_accessible (Symbol sym) {
		return true;
	}

	/**
	 * Check whether this expression is always true.
	 */
	public bool is_always_true () {
		unowned BooleanLiteral? literal = this as BooleanLiteral;
		return (literal != null && literal.value);
	}

	/**
	 * Check whether this expression is always false.
	 */
	public bool is_always_false () {
		unowned BooleanLiteral? literal = this as BooleanLiteral;
		return (literal != null && !literal.value);
	}

	public Statement? parent_statement {
		get {
			if (parent_node is MemberInitializer) {
				return ((Expression) parent_node.parent_node).parent_statement;
			} else if (parent_node is LocalVariable) {
				return (Statement) parent_node.parent_node;
			} else if (parent_node is Statement) {
				return (Statement) parent_node;
			} else if (parent_node is Expression) {
				return ((Expression) parent_node).parent_statement;
			} else {
				return null;
			}
		}
	}

	public void insert_statement (Block block, Statement stmt) {
		block.insert_before (parent_statement, stmt);
	}

	public override bool check (CodeContext context) {
		//Add null checks to a null-safe expression

		unowned MethodCall? call = this as MethodCall;
		unowned Expression access = call != null ? call.call : this;
		unowned MemberAccess? member_access = access as MemberAccess;
		unowned ElementAccess? elem_access = access as ElementAccess;
		unowned SliceExpression? slice_expr = access as SliceExpression;

		unowned Expression? inner = null;
		if (member_access != null && member_access.null_safe_access) {
			inner = member_access.inner;
		} else if (elem_access != null && elem_access.null_safe_access) {
			inner = elem_access.container;
		} else if (slice_expr != null && slice_expr.null_safe_access) {
			inner = slice_expr.container;
		} else {
			// Nothing to do here
			return true;
		}

		// get the type of the inner expression
		if (!inner.check (context)) {
			error = true;
			return false;
		}

		// the inner expression may have been replaced by the check, reload it
		if (member_access != null) {
			inner = member_access.inner;
		} else if (elem_access != null) {
			inner = elem_access.container;
		} else if (slice_expr != null) {
			inner = slice_expr.container;
		}

		if (inner.value_type == null) {
			Report.error (inner.source_reference, "invalid inner expression");
			return false;
		}

		// declare the inner expression as a local variable to check for null
		var inner_type = inner.value_type.copy ();
		if (context.experimental_non_null && !inner_type.nullable) {
			Report.warning (inner.source_reference, "inner expression is never null");
			// make it nullable, otherwise the null check will not compile in non-null mode
			inner_type.nullable = true;
		}
		var inner_local = new LocalVariable (inner_type, get_temp_name (), inner, inner.source_reference);

		var inner_decl = new DeclarationStatement (inner_local, inner.source_reference);
		insert_statement (context.analyzer.insert_block, inner_decl);

		if (!inner_decl.check (context)) {
			return false;
		}

		// create an equivalent non null-safe expression
		Expression? non_null_expr = null;

		Expression inner_access = new MemberAccess.simple (inner_local.name, source_reference);

		if (context.experimental_non_null) {
			inner_access = new CastExpression.non_null (inner_access, source_reference);
		}

		if (member_access != null) {
			non_null_expr = new MemberAccess (inner_access, member_access.member_name, source_reference);
		} else if (elem_access != null) {
			var non_null_elem_access = new ElementAccess (inner_access, source_reference);
			foreach (Expression index in elem_access.get_indices ()) {
				non_null_elem_access.append_index (index);
			}
			non_null_expr = non_null_elem_access;
		} else if (slice_expr != null) {
			non_null_expr = new SliceExpression (inner_access, slice_expr.start, slice_expr.stop, source_reference);
		}

		if ((member_access != null || elem_access != null)
		    && access.parent_node is ReferenceTransferExpression) {
			// preserve ownership transfer
			non_null_expr = new ReferenceTransferExpression (non_null_expr, source_reference);
		}

		if (!non_null_expr.check (context)) {
			return false;
		}

		if (non_null_expr.value_type == null) {
			Report.error (source_reference, "invalid null-safe expression");
			error = true;
			return false;
		}

		DataType result_type;

		if (call != null) {
			// if the expression is a method call, create an equivalent non-conditional method call
			var non_null_call = new MethodCall (non_null_expr, source_reference);
			foreach (Expression arg in call.get_argument_list ()) {
				non_null_call.add_argument (arg);
			}
			result_type = non_null_expr.value_type.get_return_type ().copy ();
			non_null_expr = non_null_call;
		} else {
			result_type = non_null_expr.value_type.copy ();
		}

		if (result_type is VoidType) {
			// void result type, replace the parent expression statement by a conditional statement
			var non_null_stmt = new ExpressionStatement (non_null_expr, source_reference);
			var non_null_block = new Block (source_reference);
			non_null_block.add_statement (non_null_stmt);

			var non_null_safe = new BinaryExpression (BinaryOperator.INEQUALITY, new MemberAccess.simple (inner_local.name, source_reference), new NullLiteral (source_reference), source_reference);
			var non_null_ifstmt = new IfStatement (non_null_safe, non_null_block, null, source_reference);

			unowned ExpressionStatement? parent_stmt = parent_node as ExpressionStatement;
			unowned Block? parent_block = parent_stmt != null ? parent_stmt.parent_node as Block : null;

			if (parent_stmt == null || parent_block == null) {
				Report.error (source_reference, "void method call not allowed here");
				error = true;
				return false;
			}

			context.analyzer.replaced_nodes.add (parent_stmt);
			parent_block.replace_statement (parent_stmt, non_null_ifstmt);
			return non_null_ifstmt.check (context);
		} else {
			// non-void result type, replace the expression by an access to a local variable
			if (!result_type.nullable) {
				if (result_type is ValueType) {
					// the value must be owned, otherwise the local variable may receive a stale pointer to the stack
					result_type.value_owned = true;
				}
				result_type.nullable = true;
			}
			var result_local = new LocalVariable (result_type, get_temp_name (), new NullLiteral (source_reference), source_reference);

			var result_decl = new DeclarationStatement (result_local, source_reference);
			insert_statement (context.analyzer.insert_block, result_decl);

			if (!result_decl.check (context)) {
				return false;
			}

			// assign the non-conditional member access if the inner expression is not null
			var non_null_safe = new BinaryExpression (BinaryOperator.INEQUALITY, new MemberAccess.simple (inner_local.name, source_reference), new NullLiteral (source_reference), source_reference);
			var non_null_stmt = new ExpressionStatement (new Assignment (new MemberAccess.simple (result_local.name, source_reference), non_null_expr, AssignmentOperator.SIMPLE, source_reference), source_reference);
			var non_null_block = new Block (source_reference);
			non_null_block.add_statement (non_null_stmt);
			var non_null_ifstmt = new IfStatement (non_null_safe, non_null_block, null, source_reference);
			insert_statement (context.analyzer.insert_block, non_null_ifstmt);

			if (!non_null_ifstmt.check (context)) {
				return false;
			}

			var result_access = SemanticAnalyzer.create_temp_access (result_local, target_type);
			context.analyzer.replaced_nodes.add (this);
			parent_node.replace_expression (this, result_access);

			if (lvalue) {
				if (non_null_expr is ReferenceTransferExpression) {
					// ownership can be transferred transitively
					result_access.lvalue = true;
				} else {
					Report.error (source_reference, "null-safe expression not supported as lvalue");
					error = true;
					return false;
				}
			}

			return result_access.check (context);
		}
	}
}
