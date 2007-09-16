/* valamemorymanager.vala
 *
 * Copyright (C) 2006-2007  Jürg Billeter, Raffaele Sandrini
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
 *	Raffaele Sandrini <rasa@gmx.ch>
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
	public void analyze (CodeContext! context) {
		context.accept (this);
	}
	
	private void visit_possibly_leaked_expression (Expression! expr) {
		if (expr.static_type != null &&
		    ((expr.static_type.data_type != null &&
		      expr.static_type.data_type.is_reference_type ()) ||
		     expr.static_type.type_parameter != null) &&
		    expr.static_type.transfers_ownership) {
			/* mark reference as leaked */
			expr.ref_leaked = true;
		}
	}

	private void visit_possibly_missing_copy_expression (Expression! expr) {
		if (expr.static_type != null &&
		    ((expr.static_type.data_type != null &&
		      expr.static_type.data_type.is_reference_type ()) ||
		     expr.static_type.type_parameter != null) &&
		    !expr.static_type.transfers_ownership) {
			/* mark reference as missing */
			expr.ref_missing = true;
		}
	}

	public override void visit_source_file (SourceFile! source_file) {
		if (!source_file.pkg) {
			source_file.accept_children (this);
		}
	}

	public override void visit_class (Class! cl) {
		cl.accept_children (this);
	}

	public override void visit_struct (Struct! st) {
		st.accept_children (this);
	}

	public override void visit_interface (Interface! iface) {
		iface.accept_children (this);
	}

	public override void visit_field (Field! f) {
		if (f.initializer != null) {
			if (f.type_reference.takes_ownership) {
				visit_possibly_missing_copy_expression (f.initializer);
			} else {
				visit_possibly_leaked_expression (f.initializer);
			}
		}
	}

	public override void visit_method (Method! m) {
		var old_symbol = current_symbol;
		current_symbol = m;

		m.accept_children (this);

		current_symbol = old_symbol;
	}
	
	public override void visit_creation_method (CreationMethod! m) {
		visit_method (m);
	}
	
	public override void visit_property (Property! prop) {
		current_symbol = prop;

		prop.accept_children (this);
	}

	public override void visit_property_accessor (PropertyAccessor! acc) {
		acc.accept_children (this);
	}

	public override void visit_constructor (Constructor! c) {
		c.accept_children (this);
	}

	public override void visit_destructor (Destructor! d) {
		d.accept_children (this);
	}

	public override void visit_named_argument (NamedArgument! n) {
		visit_possibly_leaked_expression (n.argument);
	}

	public override void visit_variable_declarator (VariableDeclarator! decl) {
		decl.accept_children (this);

		if (decl.initializer != null) {
			if (decl.type_reference.takes_ownership) {
				visit_possibly_missing_copy_expression (decl.initializer);
			} else {
				visit_possibly_leaked_expression (decl.initializer);
			}
		}
	}

	public override void visit_initializer_list (InitializerList! list) {
		list.accept_children (this);
	}

	public override void visit_expression_statement (ExpressionStatement! stmt) {
		visit_possibly_leaked_expression (stmt.expression);
	}

	public override void visit_end_return_statement (ReturnStatement! stmt) {
		if (stmt.return_expression != null) {
			if (current_symbol is Method) {
				var m = (Method) current_symbol;
				
				if (m.return_type.transfers_ownership) {
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

	public override void visit_throw_statement (ThrowStatement! stmt) {
		stmt.accept_children (this);
	}

	public override void visit_try_statement (TryStatement! stmt) {
		stmt.accept_children (this);
	}

	public override void visit_catch_clause (CatchClause! clause) {
		clause.accept_children (this);
	}

	public override void visit_array_creation_expression (ArrayCreationExpression! e) {
		if (e.initializer_list != null) {
			foreach (Expression init in e.initializer_list.get_initializers ()) {
				visit_possibly_missing_copy_expression (init);
			}
		}
	}

	public override void visit_member_access (MemberAccess! expr) {
		if (expr.inner != null) {
			visit_possibly_leaked_expression (expr.inner);
		}
	}

	public override void visit_end_invocation_expression (InvocationExpression! expr) {
		var msym = (Invokable) expr.call.symbol_reference;
		Collection<FormalParameter> params = msym.get_parameters ();

		Iterator<FormalParameter> params_it = params.iterator ();
		foreach (Expression arg in expr.get_argument_list ()) {
			if (params_it.next ()) {
				var param = params_it.get ();
				if (!param.ellipsis
				    && ((param.type_reference.data_type != null
				    && param.type_reference.data_type.is_reference_type ())
				    || param.type_reference.type_parameter != null)) {
					bool is_ref = param.type_reference.takes_ownership;
					if (is_ref && param.type_reference.type_parameter != null) {
						if (expr.call is MemberAccess) {
							var ma = (MemberAccess) expr.call;
							var param_type = SemanticAnalyzer.get_actual_type (ma.inner.static_type, msym, param.type_reference, expr);
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

	public override void visit_end_object_creation_expression (ObjectCreationExpression! expr) {
		if (!(expr.symbol_reference is Invokable)) {
			return;
		}
		
		var msym = (Invokable) expr.symbol_reference;
		Collection<FormalParameter> params = msym.get_parameters ();

		Iterator<FormalParameter> params_it = params.iterator ();
		foreach (Expression arg in expr.get_argument_list ()) {
			if (params_it.next ()) {
				var param = params_it.get ();
				if (!param.ellipsis
				    && ((param.type_reference.data_type != null
				    && param.type_reference.data_type.is_reference_type ())
				    || param.type_reference.type_parameter != null)) {
					bool is_ref = param.type_reference.takes_ownership;
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

	public override void visit_binary_expression (BinaryExpression! expr) {
		visit_possibly_leaked_expression (expr.left);
		visit_possibly_leaked_expression (expr.right);
	}

	public override void visit_end_assignment (Assignment! a) {
		if (a.left is PointerIndirection || a.left.symbol_reference is Signal) {
		} else {
			if (a.left.static_type.takes_ownership) {
				visit_possibly_missing_copy_expression (a.right);
			} else {
				visit_possibly_leaked_expression (a.right);
			}
		}
	}
}
