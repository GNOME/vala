/* valamemorymanager.vala
 *
 * Copyright (C) 2006-2007  Jürg Billeter, Raffaele Sandrini
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
 *	Raffaele Sandrini <rasa@gmx.ch>
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
		source_file.accept_children (this);
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
		current_symbol = m.symbol;

		m.accept_children (this);
	}
	
	public override void visit_creation_method (CreationMethod! m) {
		visit_method (m);
	}
	
	public override void visit_property (Property! prop) {
		current_symbol = prop.symbol;

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
		if (decl.initializer != null) {
			if (decl.type_reference.takes_ownership) {
				visit_possibly_missing_copy_expression (decl.initializer);
			} else {
				visit_possibly_leaked_expression (decl.initializer);
			}
		}
	}

	public override void visit_expression_statement (ExpressionStatement! stmt) {
		visit_possibly_leaked_expression (stmt.expression);
	}

	public override void visit_end_return_statement (ReturnStatement! stmt) {
		if (stmt.return_expression != null) {
			if (current_symbol.node is Method) {
				var m = (Method) current_symbol.node;
				
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

	public override void visit_member_access (MemberAccess! expr) {
		if (expr.inner != null) {
			visit_possibly_leaked_expression (expr.inner);
		}
	}

	public override void visit_end_invocation_expression (InvocationExpression! expr) {
		List<weak FormalParameter> params;
		
		var msym = expr.call.symbol_reference;
		if (msym.node is VariableDeclarator) {
			var decl = (VariableDeclarator) msym.node;
			var cb = (Callback) decl.type_reference.data_type;
			params = cb.get_parameters ();
		} else if (msym.node is FormalParameter) {
			var param = (FormalParameter) msym.node;
			var cb = (Callback) param.type_reference.data_type;
			params = cb.get_parameters ();
		} else if (msym.node is Field) {
			var f = (Field) msym.node;
			var cb = (Callback) f.type_reference.data_type;
			params = cb.get_parameters ();
		} else if (msym.node is Method) {
			var m = (Method) msym.node;
			params = m.get_parameters ();
		} else if (msym.node is Signal) {
			var sig = (Signal) msym.node;
			params = sig.get_parameters ();
		}
		weak List<weak FormalParameter> params_it = params;
		foreach (Expression arg in expr.get_argument_list ()) {
			if (params_it != null) {
				var param = (FormalParameter) params_it.data;
				if (!param.ellipsis
				    && ((param.type_reference.data_type != null
				    && param.type_reference.data_type.is_reference_type ())
				    || param.type_reference.type_parameter != null)) {
					bool is_ref = param.type_reference.takes_ownership;
					if (is_ref && param.type_reference.type_parameter != null) {
						// TODO move this to semantic analyzer
						if (expr.call is MemberAccess) {
							var ma = (MemberAccess) expr.call;
							TypeReference instance_type = ma.inner.static_type;
							// trace type arguments back to the datatype where the method has been declared
							while (instance_type.data_type != msym.parent_symbol.node) {
								List<weak TypeReference> base_types = null;
								if (instance_type.data_type is Class) {
									var cl = (Class) instance_type.data_type;
									base_types = cl.get_base_types ();
								} else if (instance_type.data_type is Interface) {
									var iface = (Interface) instance_type.data_type;
									base_types = iface.get_prerequisites ();
								} else {
									Report.error (expr.source_reference, "internal error: unsupported generic type");
									expr.error = true;
									return;
								}
								foreach (TypeReference base_type in base_types) {
									if (SemanticAnalyzer.symbol_lookup_inherited (base_type.data_type.symbol, msym.name) != null) {
										// construct a new type reference for the base type with correctly linked type arguments
										var instance_base_type = new TypeReference ();
										instance_base_type.data_type = base_type.data_type;
										foreach (TypeReference type_arg in base_type.get_type_arguments ()) {
											if (type_arg.type_parameter != null) {
												// link to type argument of derived type
												int param_index = instance_type.data_type.get_type_parameter_index (type_arg.type_parameter.name);
												if (param_index == -1) {
													Report.error (expr.source_reference, "internal error: unknown type parameter %s".printf (type_arg.type_parameter.name));
													expr.error = true;
													return;
												}
												type_arg = instance_type.get_type_arguments ().nth_data (param_index);
											}
											instance_base_type.add_type_argument (type_arg);
										}
										instance_type = instance_base_type;
									}
								}
							}
							if (instance_type.data_type != msym.parent_symbol.node) {
								Report.error (expr.source_reference, "internal error: generic type parameter tracing not supported yet");
								expr.error = true;
								return;
							}
							int param_index = instance_type.data_type.get_type_parameter_index (param.type_reference.type_parameter.name);
							if (param_index == -1) {
								Report.error (expr.source_reference, "internal error: unknown type parameter %s".printf (param.type_reference.type_parameter.name));
								expr.error = true;
								return;
							}
							var param_type = (TypeReference) instance_type.get_type_arguments ().nth_data (param_index);
							if (param_type == null) {
								Report.error (expr.source_reference, "internal error: no actual argument found for type parameter %s".printf (param.type_reference.type_parameter.name));
								expr.error = true;
								return;
							}
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

				params_it = params_it.next;
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
		if (a.left is PointerIndirection || (a.left.symbol_reference != null && a.left.symbol_reference.node is Signal)) {
		} else {
			if (a.left.static_type.takes_ownership) {
				visit_possibly_missing_copy_expression (a.right);
			} else {
				visit_possibly_leaked_expression (a.right);
			}
		}
	}
}
