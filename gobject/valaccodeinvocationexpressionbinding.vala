/* valaccodeinvocationexpressionbinding.vala
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

public class Vala.CCodeInvocationExpressionBinding : CCodeExpressionBinding {
	public InvocationExpression invocation_expression { get; set; }

	public CCodeInvocationExpressionBinding (CCodeGenerator codegen, InvocationExpression invocation_expression) {
		this.invocation_expression = invocation_expression;
		this.codegen = codegen;
	}

	public override void emit () {
		var expr = invocation_expression;

		expr.accept_children (codegen);

		// the bare function call
		var ccall = new CCodeFunctionCall ((CCodeExpression) expr.call.ccodenode);

		Method m = null;
		Collection<FormalParameter> params;
		
		if (!(expr.call is MemberAccess)) {
			expr.error = true;
			Report.error (expr.source_reference, "unsupported method invocation");
			return;
		}
		
		var ma = (MemberAccess) expr.call;
		
		var itype = expr.call.value_type;
		params = itype.get_parameters ();
		
		if (itype is MethodType) {
			m = ((MethodType) itype).method_symbol;
		} else if (itype is SignalType) {
			ccall = (CCodeFunctionCall) expr.call.ccodenode;
		}

		// the complete call expression, might include casts, comma expressions, and/or assignments
		CCodeExpression ccall_expr = ccall;

		var carg_map = new HashMap<int,CCodeExpression> (direct_hash, direct_equal);

		if (m is ArrayResizeMethod) {
			var array_type = (ArrayType) ma.inner.value_type;
			carg_map.set (codegen.get_param_pos (0), new CCodeIdentifier (array_type.element_type.get_cname ()));
		} else if (m is ArrayMoveMethod) {
			codegen.requires_array_move = true;
		}

		CCodeExpression instance;
		if (m != null && m.binding == MemberBinding.INSTANCE) {
			var base_method = m;
			if (m.base_method != null) {
				base_method = m.base_method;
			} else if (m.base_interface_method != null) {
				base_method = m.base_interface_method;
			}

			DataType instance_expression_type;
			if (ma.inner == null) {
				instance = new CCodeIdentifier ("self");
				instance_expression_type = codegen.get_data_type_for_symbol (codegen.current_type_symbol);
			} else {
				instance = (CCodeExpression) ma.inner.ccodenode;
				instance_expression_type = ma.inner.value_type;
			}

			if (instance_expression_type.data_type is Struct
			    && !((Struct) instance_expression_type.data_type).is_simple_type ()
			    && instance_expression_type.data_type != codegen.current_type_symbol) {
				if (instance is CCodeIdentifier || instance is CCodeMemberAccess) {
					instance = new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, instance);
				} else {
					// if instance is e.g. a function call, we can't take the address of the expression
					// (tmp = expr, &tmp)
					var ccomma = new CCodeCommaExpression ();

					var temp_var = codegen.get_temp_variable (instance_expression_type);
					codegen.temp_vars.insert (0, temp_var);
					ccomma.append_expression (new CCodeAssignment (new CCodeIdentifier (temp_var.name), instance));
					ccomma.append_expression (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, new CCodeIdentifier (temp_var.name)));

					instance = ccomma;
				}
			}

			// parent_symbol may be null for late bound methods
			if (base_method.parent_symbol != null) {
				var instance_target_type = ma.value_type.copy ();
				instance_target_type.data_type = (Typesymbol) base_method.parent_symbol;
				instance = codegen.get_implicit_cast_expression (instance, instance_expression_type, instance_target_type);
			}

			carg_map.set (codegen.get_param_pos (m.cinstance_parameter_position), instance);
		} else if (m != null && m.binding == MemberBinding.CLASS) {
			var cl = (Class) m.parent_symbol;
			var cast = new CCodeFunctionCall (new CCodeIdentifier (cl.get_upper_case_cname (null) + "_CLASS"));
			cast.add_argument (new CCodeIdentifier ("klass"));

			carg_map.set (codegen.get_param_pos (m.cinstance_parameter_position), cast);
		}

		if (m is ArrayMoveMethod) {
			var array_type = (ArrayType) ma.inner.value_type;
			var csizeof = new CCodeFunctionCall (new CCodeIdentifier ("sizeof"));
			csizeof.add_argument (new CCodeIdentifier (array_type.element_type.get_cname ()));
			carg_map.set (codegen.get_param_pos (0.1), csizeof);
		} else if (m is DynamicMethod) {
			m.clear_parameters ();
			int param_nr = 1;
			foreach (Expression arg in expr.get_argument_list ()) {
				var unary = arg as UnaryExpression;
				if (unary != null && unary.operator == UnaryOperator.OUT) {
					// out argument
					var param = new FormalParameter ("param%d".printf (param_nr), unary.inner.value_type);
					param.direction = ParameterDirection.OUT;
					m.add_parameter (param);
				} else if (unary != null && unary.operator == UnaryOperator.REF) {
					// ref argument
					var param = new FormalParameter ("param%d".printf (param_nr), unary.inner.value_type);
					param.direction = ParameterDirection.REF;
					m.add_parameter (param);
				} else {
					// in argument
					m.add_parameter (new FormalParameter ("param%d".printf (param_nr), arg.value_type));
				}
				param_nr++;
			}
			foreach (FormalParameter param in m.get_parameters ()) {
				param.accept (codegen);
			}
			codegen.dynamic_method_binding ((DynamicMethod) m).generate_wrapper ();
		}

		bool ellipsis = false;
		
		int i = 1;
		int arg_pos;
		Iterator<FormalParameter> params_it = params.iterator ();
		foreach (Expression arg in expr.get_argument_list ()) {
			CCodeExpression cexpr = (CCodeExpression) arg.ccodenode;
			Gee.List<CCodeExpression> extra_args = new ArrayList<CCodeExpression> ();
			if (params_it.next ()) {
				var param = params_it.get ();
				ellipsis = param.ellipsis;
				if (!ellipsis) {
					// if the vala argument expands to multiple C arguments,
					// we have to make sure that the C arguments don't depend
					// on each other as there is no guaranteed argument
					// evaluation order
					// http://bugzilla.gnome.org/show_bug.cgi?id=519597
					bool multiple_cargs = false;

					if (!param.no_array_length && param.type_reference is ArrayType) {
						var array_type = (ArrayType) param.type_reference;
						for (int dim = 1; dim <= array_type.rank; dim++) {
							carg_map.set (codegen.get_param_pos (param.carray_length_parameter_position + 0.01 * dim), codegen.get_array_length_cexpression (arg, dim));
						}
						multiple_cargs = true;
					} else if (param.type_reference is DelegateType) {
						var deleg_type = (DelegateType) param.type_reference;
						var d = deleg_type.delegate_symbol;
						if (d.has_target) {
							carg_map.set (codegen.get_param_pos (param.cdelegate_target_parameter_position), codegen.get_delegate_target_cexpression (arg));
							multiple_cargs = true;
						}
					} else if (param.type_reference is MethodType) {
						carg_map.set (codegen.get_param_pos (param.cdelegate_target_parameter_position), codegen.get_delegate_target_cexpression (arg));
						multiple_cargs = true;
					}
					if (param.direction == ParameterDirection.IN) {
						// don't cast arguments passed by reference
						cexpr = codegen.get_implicit_cast_expression (cexpr, arg.value_type, param.type_reference);
					}

					// pass non-simple struct instances always by reference
					if (!(arg.value_type is NullType) && param.type_reference.data_type is Struct && !((Struct) param.type_reference.data_type).is_simple_type ()) {
						// we already use a reference for arguments of ref and out parameters
						if (param.direction == ParameterDirection.IN) {
							if (cexpr is CCodeIdentifier) {
								cexpr = new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, cexpr);
							} else {
								// if cexpr is e.g. a function call, we can't take the address of the expression
								// (tmp = expr, &tmp)
								var ccomma = new CCodeCommaExpression ();

								var temp_var = codegen.get_temp_variable (arg.value_type);
								codegen.temp_vars.insert (0, temp_var);
								ccomma.append_expression (new CCodeAssignment (new CCodeIdentifier (temp_var.name), cexpr));
								ccomma.append_expression (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, new CCodeIdentifier (temp_var.name)));

								cexpr = ccomma;
							}
						}
					}

					if (multiple_cargs && arg is InvocationExpression) {
						// if vala argument is invocation expression
						// the auxiliary C argument(s) will depend on the main C argument

						// (tmp = arg1, call (tmp, arg2, arg3,...))

						var ccomma = new CCodeCommaExpression ();

						var temp_decl = codegen.get_temp_variable (arg.value_type);
						codegen.temp_vars.insert (0, temp_decl);
						ccomma.append_expression (new CCodeAssignment (new CCodeIdentifier (temp_decl.name), cexpr));

						cexpr = new CCodeIdentifier (temp_decl.name);

						ccomma.append_expression (ccall_expr);

						ccall_expr = ccomma;
					}

					// unref old value for non-null non-weak out arguments
					if (param.direction == ParameterDirection.OUT && param.type_reference.takes_ownership && !(arg.value_type is NullType)) {
						var unary = (UnaryExpression) arg;

						// (ret_tmp = call (&tmp), free (var1), var1 = tmp, ret_tmp)
						var ccomma = new CCodeCommaExpression ();

						var temp_var = codegen.get_temp_variable (unary.inner.value_type);
						codegen.temp_vars.insert (0, temp_var);
						cexpr = new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, new CCodeIdentifier (temp_var.name));

						// call function
						LocalVariable ret_temp_var;
						if (m.return_type is VoidType) {
							ccomma.append_expression (ccall_expr);
						} else {
							ret_temp_var = codegen.get_temp_variable (m.return_type);
							codegen.temp_vars.insert (0, ret_temp_var);
							ccomma.append_expression (new CCodeAssignment (new CCodeIdentifier (ret_temp_var.name), ccall_expr));
						}

						// unref old value
						ccomma.append_expression (codegen.get_unref_expression ((CCodeExpression) unary.inner.ccodenode, arg.value_type, arg));

						// assign new value
						ccomma.append_expression (new CCodeAssignment ((CCodeExpression) unary.inner.ccodenode, new CCodeIdentifier (temp_var.name)));

						// return value
						if (!(m.return_type is VoidType)) {
							ccomma.append_expression (new CCodeIdentifier (ret_temp_var.name));
						}

						ccall_expr = ccomma;
					}
				}
				arg_pos = codegen.get_param_pos (param.cparameter_position, ellipsis);
			} else {
				// default argument position
				arg_pos = codegen.get_param_pos (i, ellipsis);
			}

			carg_map.set (arg_pos, cexpr);

			i++;
		}
		while (params_it.next ()) {
			var param = params_it.get ();
			
			if (param.ellipsis) {
				ellipsis = true;
				break;
			}
			
			if (param.default_expression == null) {
				Report.error (expr.source_reference, "no default expression for argument %d".printf (i));
				return;
			}
			
			/* evaluate default expression here as the code
			 * generator might not have visited the formal
			 * parameter yet */
			param.default_expression.accept (codegen);
		
			if (!param.no_array_length && param.type_reference != null &&
			    param.type_reference is ArrayType) {
				var array_type = (ArrayType) param.type_reference;
				for (int dim = 1; dim <= array_type.rank; dim++) {
					carg_map.set (codegen.get_param_pos (param.carray_length_parameter_position + 0.01 * dim), codegen.get_array_length_cexpression (param.default_expression, dim));
				}
			}

			carg_map.set (codegen.get_param_pos (param.cparameter_position), (CCodeExpression) param.default_expression.ccodenode);
			i++;
		}

		/* add length argument for methods returning arrays */
		if (m != null && m.return_type is ArrayType) {
			var array_type = (ArrayType) m.return_type;
			for (int dim = 1; dim <= array_type.rank; dim++) {
				if (!m.no_array_length) {
					var temp_var = codegen.get_temp_variable (codegen.int_type);
					var temp_ref = new CCodeIdentifier (temp_var.name);

					codegen.temp_vars.insert (0, temp_var);

					carg_map.set (codegen.get_param_pos (m.carray_length_parameter_position + 0.01 * dim), new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, temp_ref));

					expr.append_array_size (temp_ref);
				} else {
					expr.append_array_size (new CCodeConstant ("-1"));
				}
			}
		} else if (m != null && m.return_type is DelegateType) {
			var deleg_type = (DelegateType) m.return_type;
			var d = deleg_type.delegate_symbol;
			if (d.has_target) {
				var temp_var = codegen.get_temp_variable (new PointerType (new VoidType ()));
				var temp_ref = new CCodeIdentifier (temp_var.name);

				codegen.temp_vars.insert (0, temp_var);

				carg_map.set (codegen.get_param_pos (m.cdelegate_target_parameter_position), new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, temp_ref));

				expr.delegate_target = temp_ref;
			}
		}

		if (expr.can_fail) {
			// method can fail
			codegen.current_method_inner_error = true;
			// add &inner_error before the ellipsis arguments
			carg_map.set (codegen.get_param_pos (-2), new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, new CCodeIdentifier ("inner_error")));
		}

		if (ellipsis) {
			/* ensure variable argument list ends with NULL
			 * except when using printf-style arguments */
			if ((m == null || !m.printf_format)) {
				carg_map.set (codegen.get_param_pos (-1, true), new CCodeConstant (m.sentinel));
			}
		} else if (itype is DelegateType) {
			var deleg_type = (DelegateType) itype;
			var d = deleg_type.delegate_symbol;
			if (d.has_target) {
				carg_map.set (codegen.get_param_pos (d.cinstance_parameter_position), codegen.get_delegate_target_cexpression (expr.call));
			}
		}

		// append C arguments in the right order
		int last_pos = -1;
		int min_pos;
		while (true) {
			min_pos = -1;
			foreach (int pos in carg_map.get_keys ()) {
				if (pos > last_pos && (min_pos == -1 || pos < min_pos)) {
					min_pos = pos;
				}
			}
			if (min_pos == -1) {
				break;
			}
			ccall.add_argument (carg_map.get (min_pos));
			last_pos = min_pos;
		}

		if (m != null && m.binding == MemberBinding.INSTANCE && m.returns_modified_pointer) {
			expr.ccodenode = new CCodeAssignment (instance, ccall_expr);
		} else {
			/* cast pointer to actual type if this is a generic method return value */
			if (m != null && m.return_type.type_parameter != null && expr.value_type.data_type != null) {
				expr.ccodenode = codegen.convert_from_generic_pointer (ccall_expr, expr.value_type);
			} else {
				expr.ccodenode = ccall_expr;
			}
		
			codegen.visit_expression (expr);
		}
		
		if (m is ArrayResizeMethod) {
			// FIXME: size expression must not be evaluated twice at runtime (potential side effects)
			Iterator<Expression> arg_it = expr.get_argument_list ().iterator ();
			arg_it.next ();
			var new_size = (CCodeExpression) arg_it.get ().ccodenode;

			var temp_decl = codegen.get_temp_variable (codegen.int_type);
			var temp_ref = new CCodeIdentifier (temp_decl.name);

			codegen.temp_vars.insert (0, temp_decl);

			/* memset needs string.h */
			codegen.string_h_needed = true;

			var clen = codegen.get_array_length_cexpression (ma.inner, 1);
			var celems = (CCodeExpression) ma.inner.ccodenode;
			var array_type = (ArrayType) ma.inner.value_type;
			var csizeof = new CCodeIdentifier ("sizeof (%s)".printf (array_type.element_type.get_cname ()));
			var cdelta = new CCodeParenthesizedExpression (new CCodeBinaryExpression (CCodeBinaryOperator.MINUS, temp_ref, clen));
			var ccheck = new CCodeBinaryExpression (CCodeBinaryOperator.GREATER_THAN, temp_ref, clen);

			var czero = new CCodeFunctionCall (new CCodeIdentifier ("memset"));
			czero.add_argument (new CCodeBinaryExpression (CCodeBinaryOperator.PLUS, celems, clen));
			czero.add_argument (new CCodeConstant ("0"));
			czero.add_argument (new CCodeBinaryExpression (CCodeBinaryOperator.MUL, csizeof, cdelta));

			var ccomma = new CCodeCommaExpression ();
			ccomma.append_expression (new CCodeAssignment (temp_ref, new_size));
			ccomma.append_expression ((CCodeExpression) expr.ccodenode);
			ccomma.append_expression (new CCodeConditionalExpression (ccheck, czero, new CCodeConstant ("NULL")));
			ccomma.append_expression (new CCodeAssignment (codegen.get_array_length_cexpression (ma.inner, 1), temp_ref));

			expr.ccodenode = ccomma;
		} else if (m == codegen.substring_method) {
			var temp_decl = codegen.get_temp_variable (codegen.string_type);
			var temp_ref = new CCodeIdentifier (temp_decl.name);

			codegen.temp_vars.insert (0, temp_decl);

			Gee.List<CCodeExpression> args = ccall.get_arguments ();

			var coffsetcall = new CCodeFunctionCall (new CCodeIdentifier ("g_utf8_offset_to_pointer"));
			// full string
			coffsetcall.add_argument (args[0]);
			// offset
			coffsetcall.add_argument (args[1]);

			var coffsetcall2 = new CCodeFunctionCall (new CCodeIdentifier ("g_utf8_offset_to_pointer"));
			coffsetcall2.add_argument (temp_ref);
			// len
			coffsetcall2.add_argument (args[2]);

			var cndupcall = new CCodeFunctionCall (new CCodeIdentifier ("g_strndup"));
			cndupcall.add_argument (temp_ref);
			cndupcall.add_argument (new CCodeBinaryExpression (CCodeBinaryOperator.MINUS, coffsetcall2, temp_ref));

			var ccomma = new CCodeCommaExpression ();
			ccomma.append_expression (new CCodeAssignment (temp_ref, coffsetcall));
			ccomma.append_expression (cndupcall);

			expr.ccodenode = ccomma;
		}
	}
}

