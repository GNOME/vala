/* valamemorymanager.vala
 *
 * Copyright (C) 2006-2008  Jürg Billeter, Raffaele Sandrini
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
 *	Raffaele Sandrini <raffaele@sandrini.ch>
 */

using GLib;
using Gee;

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
	public void analyze (CodeContext context) {
		context.accept (this);
	}
	
	private void visit_possibly_leaked_expression (Expression expr) {
		if (expr.value_type != null
		    && expr.value_type.transfers_ownership) {
			/* mark reference as leaked */
			expr.ref_leaked = true;
		}
	}

	private void visit_possibly_missing_copy_expression (Expression expr) {
		if (expr.value_type != null
		    && !expr.value_type.transfers_ownership
		    && !(expr.value_type is NullType)) {
			/* mark reference as missing */
			expr.ref_missing = true;
		}
	}

	public override void visit_source_file (SourceFile source_file) {
		if (!source_file.external_package) {
			source_file.accept_children (this);
		}
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

	public override void visit_field (Field f) {
		if (f.initializer != null) {
			if (!(f.field_type is PointerType)) {
				if (f.field_type.takes_ownership) {
					visit_possibly_missing_copy_expression (f.initializer);
				} else {
					visit_possibly_leaked_expression (f.initializer);
				}
			}
		}
	}

	public override void visit_method (Method m) {
		var old_symbol = current_symbol;
		current_symbol = m;

		m.accept_children (this);

		current_symbol = old_symbol;
	}
	
	public override void visit_creation_method (CreationMethod m) {
		visit_method (m);
	}
	
	public override void visit_property (Property prop) {
		current_symbol = prop;

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

	public override void visit_named_argument (NamedArgument n) {
		visit_possibly_leaked_expression (n.argument);
	}

	public override void visit_block (Block b) {
		b.accept_children (this);
	}

	public override void visit_local_variable (LocalVariable local) {
		local.accept_children (this);

		if (local.initializer != null) {
			if (!(local.variable_type is PointerType)) {
				if (local.variable_type.takes_ownership) {
					visit_possibly_missing_copy_expression (local.initializer);
				} else {
					visit_possibly_leaked_expression (local.initializer);
				}
			}
		}
	}

	public override void visit_initializer_list (InitializerList list) {
		list.accept_children (this);
	}

	public override void visit_expression_statement (ExpressionStatement stmt) {
		visit_possibly_leaked_expression (stmt.expression);
	}

	public override void visit_if_statement (IfStatement stmt) {
		stmt.accept_children (this);
	}

	public override void visit_switch_section (SwitchSection section) {
		section.accept_children (this);
	}

	public override void visit_while_statement (WhileStatement stmt) {
		stmt.accept_children (this);
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

	public override void visit_return_statement (ReturnStatement stmt) {
		stmt.accept_children (this);

		if (stmt.return_expression != null) {
			if (current_symbol is Method) {
				var m = (Method) current_symbol;
				
				if (!(m.return_type is PointerType)) {
					if (m.return_type.transfers_ownership) {
						visit_possibly_missing_copy_expression (stmt.return_expression);
					} else {
						visit_possibly_leaked_expression (stmt.return_expression);
					}
				}
			} else if (current_symbol is Property) {
				/* property get accessor */
				var prop = (Property) current_symbol;
				if (prop.type_reference.transfers_ownership) {
					visit_possibly_missing_copy_expression (stmt.return_expression);
				} else {
					visit_possibly_leaked_expression (stmt.return_expression);
				}
			} else {
				assert_not_reached ();
			}
		}
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

	public override void visit_array_creation_expression (ArrayCreationExpression e) {
		if (e.initializer_list != null) {
			foreach (Expression init in e.initializer_list.get_initializers ()) {
				if (init.value_type.is_reference_type_or_type_parameter ()) {
					visit_possibly_missing_copy_expression (init);
				} else {
					visit_possibly_leaked_expression (init);
				}
			}
		}
	}

	public override void visit_parenthesized_expression (ParenthesizedExpression expr) {
		expr.accept_children (this);
	}

	public override void visit_member_access (MemberAccess expr) {
		if (expr.inner != null) {
			visit_possibly_leaked_expression (expr.inner);
		}
	}

	public override void visit_invocation_expression (InvocationExpression expr) {
		expr.accept_children (this);

		var mtype = expr.call.value_type;
		Collection<FormalParameter> params = mtype.get_parameters ();

		Iterator<FormalParameter> params_it = params.iterator ();
		foreach (Expression arg in expr.get_argument_list ()) {
			if (params_it.next ()) {
				var param = params_it.get ();
				if (!param.ellipsis
				    && param.type_reference.is_reference_type_or_type_parameter ()) {
					bool is_ref = param.type_reference.transfers_ownership;
					if (is_ref && param.type_reference.type_parameter != null) {
						if (expr.call is MemberAccess) {
							var ma = (MemberAccess) expr.call;
							var param_type = SemanticAnalyzer.get_actual_type (ma.inner.value_type, ma.symbol_reference, param.type_reference, expr);
							if (param_type != null) {
								is_ref = param_type.takes_ownership;
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
			} else {
				visit_possibly_leaked_expression (arg);
			}
		}
	}

	public override void visit_object_creation_expression (ObjectCreationExpression expr) {
		expr.accept_children (this);

		if (!(expr.symbol_reference is Method)) {
			return;
		}
		
		var msym = (Method) expr.symbol_reference;
		Collection<FormalParameter> params = msym.get_parameters ();

		Iterator<FormalParameter> params_it = params.iterator ();
		foreach (Expression arg in expr.get_argument_list ()) {
			if (params_it.next ()) {
				var param = params_it.get ();
				if (!param.ellipsis
				    && param.type_reference.is_reference_type_or_type_parameter ()) {
					bool is_ref = param.type_reference.transfers_ownership;
					if (is_ref && param.type_reference.type_parameter != null) {
						var param_type = SemanticAnalyzer.get_actual_type (expr.type_reference, msym, param.type_reference, expr);
						if (param_type != null) {
							is_ref = param_type.takes_ownership;
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
			} else {
				visit_possibly_leaked_expression (arg);
			}
		}
	}

	public override void visit_binary_expression (BinaryExpression expr) {
		visit_possibly_leaked_expression (expr.left);
		visit_possibly_leaked_expression (expr.right);
	}

	public override void visit_lambda_expression (LambdaExpression l) {
		l.accept_children (this);
	}

	public override void visit_assignment (Assignment a) {
		a.accept_children (this);

		if (a.left is PointerIndirection || a.left.symbol_reference is Signal) {
		} else {
			if (!(a.left.value_type is PointerType)) {
				if (a.left.value_type.takes_ownership) {
					visit_possibly_missing_copy_expression (a.right);
				} else {
					visit_possibly_leaked_expression (a.right);
				}
			}
		}
	}
}
