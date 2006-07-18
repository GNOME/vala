/* valamemorymanager.vala
 *
 * Copyright (C) 2006  Jürg Billeter
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public
 * License as published by the Free Software Foundation; either
 * version 2 of the License, or (at your option) any later version.

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
 * Code visitor analyzing memory usage. The memory manager finds leaked and
 * copied references.
 */
public class Vala.MemoryManager : CodeVisitor {
	Symbol current_symbol;

	/**
	 * Analyze memory usage in the specified code context.
	 *
	 * @param context a code context
	 */
	public void analyze (CodeContext! context) {
		context.accept (this);
	}
	
	private void visit_possibly_leaked_expression (Expression! expr) {
		if (expr.static_type != null &&
		    ((expr.static_type.type != null &&
		      expr.static_type.type.is_reference_type ()) ||
		     expr.static_type.type_parameter != null) &&
		    expr.static_type.is_ref) {
			/* mark reference as leaked */
			expr.ref_leaked = true;
		}
	}

	private void visit_possibly_missing_copy_expression (Expression! expr) {
		if (expr.static_type != null &&
		    ((expr.static_type.type != null &&
		      expr.static_type.type.is_reference_type ()) ||
		     expr.static_type.type_parameter != null) &&
		    !expr.static_type.is_ref) {
			/* mark reference as missing */
			expr.ref_missing = true;
		}
	}

	public override void visit_field (Field! f) {
		if (f.initializer != null) {
			if (f.type_reference.is_lvalue_ref) {
				visit_possibly_missing_copy_expression (f.initializer);
			} else {
				visit_possibly_leaked_expression (f.initializer);
			}
		}
	}

	public override void visit_begin_method (Method! m) {
		current_symbol = m.symbol;
	}
	
	public override void visit_begin_property (Property! prop) {
		current_symbol = prop.symbol;
	}

	public override void visit_named_argument (NamedArgument! n) {
		visit_possibly_leaked_expression (n.argument);
	}

	public override void visit_variable_declarator (VariableDeclarator! decl) {
		if (decl.initializer != null) {
			if (decl.type_reference.is_lvalue_ref) {
				visit_possibly_missing_copy_expression (decl.initializer);
			} else {
				visit_possibly_leaked_expression (decl.initializer);
			}
		}
	}

	public override void visit_expression_statement (ExpressionStatement! stmt) {
		visit_possibly_leaked_expression (stmt.expression);
	}

	public override void visit_return_statement (ReturnStatement! stmt) {
		if (stmt.return_expression != null) {
			if (current_symbol.node is Method) {
				var m = (Method) current_symbol.node;
				
				if (m.return_type.is_ref) {
					visit_possibly_missing_copy_expression (stmt.return_expression);
				} else {
					visit_possibly_leaked_expression (stmt.return_expression);
				}
			} else {
				/* property get accessor */
				visit_possibly_leaked_expression (stmt.return_expression);
			}
		}
	}

	public override void visit_member_access (MemberAccess! expr) {
		if (expr.inner != null) {
			visit_possibly_leaked_expression (expr.inner);
		}
	}

	public override void visit_end_invocation_expression (InvocationExpression! expr) {
		List<FormalParameter> params;
		
		var msym = expr.call.symbol_reference;
		if (msym.node is VariableDeclarator) {
			var decl = (VariableDeclarator) msym.node;
			var cb = (Callback) decl.type_reference.type;
			params = cb.get_parameters ();
		} else if (msym.node is FormalParameter) {
			var param = (FormalParameter) msym.node;
			var cb = (Callback) param.type_reference.type;
			params = cb.get_parameters ();
		} else if (msym.node is Method) {
			var m = (Method) msym.node;
			params = m.get_parameters ();
		} else {
			var sig = (Signal) msym.node;
			params = sig.get_parameters ();
		}
		foreach (Expression arg in expr.get_argument_list ()) {
			if (params != null) {
				var param = (FormalParameter) params.data;
				if (!param.ellipsis
				    && ((param.type_reference.type != null
				    && param.type_reference.type.is_reference_type ())
				    || param.type_reference.type_parameter != null)) {
					bool is_ref = param.type_reference.is_ref;
					if (is_ref && param.type_reference.type_parameter != null) {
						if (expr.call is MemberAccess) {
							var instance_type = ((MemberAccess) expr.call).inner.static_type;
							foreach (TypeReference type_arg in instance_type.get_type_arguments ()) {
								/* generic method parameters may only be strong references if the type argument is strong, too */
								is_ref = type_arg.is_ref;
							}
						}
					}
					
					if (is_ref) {
						visit_possibly_missing_copy_expression (arg);
					} else {
						visit_possibly_leaked_expression (arg);
					}
				} else {
					visit_possibly_leaked_expression (arg);
				}

				params = params.next;
			} else {
				visit_possibly_leaked_expression (arg);
			}
		}
	}

	public override void visit_binary_expression (BinaryExpression! expr) {
		visit_possibly_leaked_expression (expr.left);
		visit_possibly_leaked_expression (expr.right);
	}

	public override void visit_end_assignment (Assignment! a) {
		if (a.left.symbol_reference.node is Signal) {
		} else {
			if (a.left.static_type.is_lvalue_ref) {
				visit_possibly_missing_copy_expression (a.right);
			} else {
				visit_possibly_leaked_expression (a.right);
			}
		}
	}
}
