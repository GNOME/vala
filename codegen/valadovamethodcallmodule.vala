/* valadovamethodcallmodule.vala
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

internal class Vala.DovaMethodCallModule : DovaAssignmentModule {
	public DovaMethodCallModule (CCodeGenerator codegen, CCodeModule? next) {
		base (codegen, next);
	}

	public override void visit_method_call (MethodCall expr) {
		expr.accept_children (codegen);

		// the bare function call
		var ccall = new CCodeFunctionCall ((CCodeExpression) expr.call.ccodenode);

		Method m = null;
		Delegate deleg = null;
		List<FormalParameter> params;

		var ma = expr.call as MemberAccess;

		var itype = expr.call.value_type;
		params = itype.get_parameters ();

		if (itype is MethodType) {
			assert (ma != null);
			m = ((MethodType) itype).method_symbol;
		} else if (itype is ObjectType) {
			// constructor
			var cl = (Class) ((ObjectType) itype).type_symbol;
			m = cl.default_construction_method;
			generate_method_declaration (m, source_declarations);
			ccall = new CCodeFunctionCall (new CCodeIdentifier (m.get_real_cname ()));
		} else if (itype is DelegateType) {
			deleg = ((DelegateType) itype).delegate_symbol;
			ccall = new CCodeFunctionCall (new CCodeIdentifier ("%s_invoke".printf (deleg.get_lower_case_cname ())));
			ccall.add_argument ((CCodeExpression) expr.call.ccodenode);
		}

		if (m is CreationMethod) {
			var cl = (Class) m.parent_symbol;

			if (cl == current_class) {
				ccall.add_argument (new CCodeIdentifier ("this"));
			} else {
				ccall.add_argument (new CCodeCastExpression (new CCodeIdentifier ("this"), cl.get_cname () + "*"));
			}
		} else if (m != null) {
			if (m.binding == MemberBinding.INSTANCE) {
				var instance = (CCodeExpression) ma.inner.ccodenode;

				if (ma.member_name == "begin" && ma.inner.symbol_reference == ma.symbol_reference) {
					var inner_ma = (MemberAccess) ma.inner;
					instance = (CCodeExpression) inner_ma.inner.ccodenode;
				}

				var st = m.parent_symbol as Struct;
				if (st != null && !st.is_simple_type ()) {
					// we need to pass struct instance by reference
					var unary = instance as CCodeUnaryExpression;
					if (unary != null && unary.operator == CCodeUnaryOperator.POINTER_INDIRECTION) {
						// *expr => expr
						instance = unary.inner;
					} else if (instance is CCodeIdentifier || instance is CCodeMemberAccess) {
						instance = new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, instance);
					} else {
						// if instance is e.g. a function call, we can't take the address of the expression
						// (tmp = expr, &tmp)
						var ccomma = new CCodeCommaExpression ();

						var temp_var = get_temp_variable (ma.inner.target_type);
						temp_vars.insert (0, temp_var);
						ccomma.append_expression (new CCodeAssignment (get_variable_cexpression (temp_var.name), instance));
						ccomma.append_expression (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, get_variable_cexpression (temp_var.name)));

						instance = ccomma;
					}
				}

				if (ma.inner is BaseAccess) {
					ccall.add_argument (new CCodeFunctionCall (new CCodeIdentifier ("%s_type_get".printf (((Class) current_class.base_class).get_lower_case_cname ()))));
				}
				ccall.add_argument (instance);
			}

			if (m.binding != MemberBinding.INSTANCE && m.parent_symbol is ObjectTypeSymbol) {
				// support static methods in generic types
				var type_symbol = (ObjectTypeSymbol) m.parent_symbol;
				if (type_symbol.get_type_parameters ().size > 0 && ma.inner is MemberAccess) {
					var type_ma = (MemberAccess) ma.inner;
					add_generic_type_arguments (ccall, type_ma.get_type_arguments (), expr);
				}
			}
			if (m.get_type_parameters ().size > 0) {
				add_generic_type_arguments (ccall, ma.get_type_arguments (), expr);
			}
		}

		// the complete call expression, might include casts, comma expressions, and/or assignments
		CCodeExpression ccall_expr = ccall;

		bool ellipsis = false;

		int i = 1;
		Iterator<FormalParameter> params_it = params.iterator ();
		foreach (Expression arg in expr.get_argument_list ()) {
			CCodeExpression cexpr = (CCodeExpression) arg.ccodenode;

			if (params_it.next ()) {
				var param = params_it.get ();
				ellipsis = param.params_array || param.ellipsis;
				if (!ellipsis) {
					cexpr = handle_struct_argument (param, arg, cexpr);

					// unref old value for non-null non-weak ref/out arguments
					// disabled for arrays for now as that requires special handling
					// (ret_tmp = call (&tmp), var1 = (assign_tmp = dup (tmp), free (var1), assign_tmp), ret_tmp)
					if (param.direction != ParameterDirection.IN && requires_destroy (arg.value_type)
					    && (param.direction == ParameterDirection.OUT || !param.variable_type.value_owned)
					    && !(param.variable_type is ArrayType)) {
						var unary = (UnaryExpression) arg;

						var ccomma = new CCodeCommaExpression ();

						var temp_var = get_temp_variable (param.variable_type, param.variable_type.value_owned);
						temp_vars.insert (0, temp_var);
						cexpr = new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, get_variable_cexpression (temp_var.name));

						if (param.direction == ParameterDirection.REF) {
							var crefcomma = new CCodeCommaExpression ();
							crefcomma.append_expression (new CCodeAssignment (get_variable_cexpression (temp_var.name), (CCodeExpression) unary.inner.ccodenode));
							crefcomma.append_expression (cexpr);
							cexpr = crefcomma;
						}

						// call function
						LocalVariable ret_temp_var = null;
						if (itype.get_return_type () is VoidType) {
							ccomma.append_expression (ccall_expr);
						} else {
							ret_temp_var = get_temp_variable (itype.get_return_type ());
							temp_vars.insert (0, ret_temp_var);
							ccomma.append_expression (new CCodeAssignment (get_variable_cexpression (ret_temp_var.name), ccall_expr));
						}

						var cassign_comma = new CCodeCommaExpression ();

						var assign_temp_var = get_temp_variable (unary.inner.value_type, unary.inner.value_type.value_owned);
						temp_vars.insert (0, assign_temp_var);

						cassign_comma.append_expression (new CCodeAssignment (get_variable_cexpression (assign_temp_var.name), transform_expression (get_variable_cexpression (temp_var.name), param.variable_type, unary.inner.value_type, arg)));

						// unref old value
						cassign_comma.append_expression (get_unref_expression ((CCodeExpression) unary.inner.ccodenode, arg.value_type, arg));

						cassign_comma.append_expression (get_variable_cexpression (assign_temp_var.name));

						// assign new value
						ccomma.append_expression (new CCodeAssignment ((CCodeExpression) unary.inner.ccodenode, cassign_comma));

						// return value
						if (!(itype.get_return_type () is VoidType)) {
							ccomma.append_expression (get_variable_cexpression (ret_temp_var.name));
						}

						ccall_expr = ccomma;
					}

					if (param.ctype != null) {
						cexpr = new CCodeCastExpression (cexpr, param.ctype);
					}
				}
			}

			ccall.add_argument (cexpr);

			i++;
		}
		if (params_it.next ()) {
			var param = params_it.get ();

			/* if there are more parameters than arguments,
			 * the additional parameter is an ellipsis parameter
			 * otherwise there is a bug in the semantic analyzer
			 */
			assert (param.params_array || param.ellipsis);
			ellipsis = true;
		}

		if (itype.get_return_type () is GenericType) {
			var ccomma = new CCodeCommaExpression ();

			var temp_var = get_temp_variable (expr.value_type);
			temp_vars.insert (0, temp_var);
			if (expr.value_type is GenericType) {
				ccall.add_argument (get_variable_cexpression (temp_var.name));
			} else {
				ccall.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, get_variable_cexpression (temp_var.name)));
			}

			// call function
			ccomma.append_expression (ccall_expr);

			ccomma.append_expression (get_variable_cexpression (temp_var.name));

			ccall_expr = ccomma;
		}

		expr.ccodenode = ccall_expr;
	}
}

