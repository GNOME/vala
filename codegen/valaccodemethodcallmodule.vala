/* valaccodemethodcallmodule.vala
 *
 * Copyright (C) 2006-2009  Jürg Billeter
 * Copyright (C) 2006-2008  Raffaele Sandrini
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

internal class Vala.CCodeMethodCallModule : CCodeAssignmentModule {
	public CCodeMethodCallModule (CCodeGenerator codegen, CCodeModule? next) {
		base (codegen, next);
	}

	public override void visit_method_call (MethodCall expr) {
		expr.accept_children (codegen);

		// the bare function call
		var ccall = new CCodeFunctionCall ((CCodeExpression) expr.call.ccodenode);

		CCodeFunctionCall async_call = null;

		Method m = null;
		Delegate deleg = null;
		List<FormalParameter> params;
		
		var ma = expr.call as MemberAccess;
		
		var itype = expr.call.value_type;
		params = itype.get_parameters ();
		
		if (itype is MethodType) {
			assert (ma != null);
			m = ((MethodType) itype).method_symbol;
		} else if (itype is SignalType) {
			var sig_type = (SignalType) itype;
			if (ma != null && ma.inner is BaseAccess && sig_type.signal_symbol.is_virtual) {
				m = sig_type.signal_symbol.default_handler;
			} else {
				ccall = (CCodeFunctionCall) expr.call.ccodenode;
			}
		} else if (itype is ObjectType) {
			// constructor
			var cl = (Class) ((ObjectType) itype).type_symbol;
			m = cl.default_construction_method;
			generate_method_declaration (m, source_declarations);
			ccall = new CCodeFunctionCall (new CCodeIdentifier (m.get_real_cname ()));
		} else if (itype is DelegateType) {
			deleg = ((DelegateType) itype).delegate_symbol;
		}

		var in_arg_map = new HashMap<int,CCodeExpression> (direct_hash, direct_equal);
		var out_arg_map = in_arg_map;

		if (m != null && m.coroutine) {
			// async call

			async_call = new CCodeFunctionCall (new CCodeIdentifier (m.get_cname ()));
			var finish_call = new CCodeFunctionCall (new CCodeIdentifier (m.get_finish_cname ()));

			if (ma.inner is BaseAccess) {
				if (m.base_method != null) {
					var base_class = (Class) m.base_method.parent_symbol;
					var vcast = new CCodeFunctionCall (new CCodeIdentifier ("%s_CLASS".printf (base_class.get_upper_case_cname (null))));
					vcast.add_argument (new CCodeIdentifier ("%s_parent_class".printf (current_class.get_lower_case_cname (null))));

					async_call.call = new CCodeMemberAccess.pointer (vcast, m.vfunc_name);
					finish_call.call = new CCodeMemberAccess.pointer (vcast, m.get_finish_vfunc_name ());
				} else if (m.base_interface_method != null) {
					var base_iface = (Interface) m.base_interface_method.parent_symbol;
					string parent_iface_var = "%s_%s_parent_iface".printf (current_class.get_lower_case_cname (null), base_iface.get_lower_case_cname (null));

					async_call.call = new CCodeMemberAccess.pointer (new CCodeIdentifier (parent_iface_var), m.vfunc_name);
					finish_call.call = new CCodeMemberAccess.pointer (new CCodeIdentifier (parent_iface_var), m.get_finish_vfunc_name ());
				}
			}

			if (ma.member_name == "begin" && ma.inner.symbol_reference == ma.symbol_reference) {
				// no finish call
				ccall = async_call;
				params = m.get_async_begin_parameters ();
			} else if (ma.member_name == "end" && ma.inner.symbol_reference == ma.symbol_reference) {
				// no async call
				ccall = finish_call;
				params = m.get_async_end_parameters ();
			} else if (!expr.is_yield_expression) {
				// same as .begin, backwards compatible to bindings without async methods
				ccall = async_call;
				params = m.get_async_begin_parameters ();
			} else {
				ccall = finish_call;

				// output arguments used separately
				out_arg_map = new HashMap<int,CCodeExpression> (direct_hash, direct_equal);
				// pass GAsyncResult stored in closure to finish function
				out_arg_map.set (get_param_pos (0.1), new CCodeMemberAccess.pointer (new CCodeIdentifier ("data"), "_res_"));
			}
		}

		if (m is CreationMethod) {
			if (context.profile == Profile.GOBJECT) {
				if (!((Class) m.parent_symbol).is_compact) {
					ccall.add_argument (new CCodeIdentifier ("object_type"));
				}
			} else {
				ccall.add_argument (new CCodeIdentifier ("self"));
			}

			foreach (DataType base_type in current_class.get_base_types ()) {
				if (base_type.data_type is Class) {
					add_generic_type_arguments (in_arg_map, base_type.get_type_arguments (), expr, true);
					break;
				}
			}
		} else if (m != null && m.get_type_parameters ().size > 0) {
			// generic method
			add_generic_type_arguments (in_arg_map, ma.get_type_arguments (), expr);
		}

		// the complete call expression, might include casts, comma expressions, and/or assignments
		CCodeExpression ccall_expr = ccall;

		if (m is ArrayResizeMethod) {
			var array_type = (ArrayType) ma.inner.value_type;
			in_arg_map.set (get_param_pos (0), new CCodeIdentifier (array_type.element_type.get_cname ()));
		} else if (m is ArrayMoveMethod) {
			requires_array_move = true;
		}

		CCodeExpression instance = null;
		if (m != null && m.binding == MemberBinding.INSTANCE && !(m is CreationMethod)) {
			instance = (CCodeExpression) ma.inner.ccodenode;

			if ((ma.member_name == "begin" || ma.member_name == "end") && ma.inner.symbol_reference == ma.symbol_reference) {
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

					var temp_var = get_temp_variable (ma.inner.target_type, true, null, false);
					temp_vars.insert (0, temp_var);
					ccomma.append_expression (new CCodeAssignment (get_variable_cexpression (temp_var.name), instance));
					ccomma.append_expression (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, get_variable_cexpression (temp_var.name)));

					instance = ccomma;
				}
			}

			in_arg_map.set (get_param_pos (m.cinstance_parameter_position), instance);
			out_arg_map.set (get_param_pos (m.cinstance_parameter_position), instance);
		} else if (m != null && m.binding == MemberBinding.CLASS) {
			var cl = (Class) m.parent_symbol;
			var cast = new CCodeFunctionCall (new CCodeIdentifier (cl.get_upper_case_cname (null) + "_CLASS"));
			
			CCodeExpression klass;
			if (ma.inner == null) {
				if (in_static_or_class_context) {
					// Accessing the method from a static or class constructor
					klass = new CCodeIdentifier ("klass");
				} else {
					// Accessing the method from within an instance method
					var k = new CCodeFunctionCall (new CCodeIdentifier ("G_OBJECT_GET_CLASS"));
					k.add_argument (new CCodeIdentifier ("self"));
					klass = k;
				}
			} else {
				// Accessing the method of an instance
				var k = new CCodeFunctionCall (new CCodeIdentifier ("G_OBJECT_GET_CLASS"));
				k.add_argument ((CCodeExpression) ma.inner.ccodenode);
				klass = k;
			}

			cast.add_argument (klass);
			in_arg_map.set (get_param_pos (m.cinstance_parameter_position), cast);
			out_arg_map.set (get_param_pos (m.cinstance_parameter_position), cast);
		}

		if (m != null && m.has_generic_type_parameter) {
			// insert type argument for macros
			int type_param_index = 0;
			foreach (var type_arg in ma.inner.value_type.get_type_arguments ()) {
				in_arg_map.set (get_param_pos (m.generic_type_parameter_position + 0.01 * type_param_index), new CCodeIdentifier (type_arg.get_cname ()));
				type_param_index++;
			}
		}

		if (m is ArrayMoveMethod) {
			var array_type = (ArrayType) ma.inner.value_type;
			var csizeof = new CCodeFunctionCall (new CCodeIdentifier ("sizeof"));
			csizeof.add_argument (new CCodeIdentifier (array_type.element_type.get_cname ()));
			in_arg_map.set (get_param_pos (0.1), csizeof);
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
			head.generate_dynamic_method_wrapper ((DynamicMethod) m);
		} else if (m is CreationMethod && context.profile == Profile.GOBJECT) {
			ccall_expr = new CCodeAssignment (new CCodeIdentifier ("self"), new CCodeCastExpression (ccall, current_class.get_cname () + "*"));

			if (!current_class.is_compact && current_class.get_type_parameters ().size > 0) {
				var ccomma = new CCodeCommaExpression ();
				ccomma.append_expression (ccall_expr);

				/* type, dup func, and destroy func fields for generic types */
				foreach (TypeParameter type_param in current_class.get_type_parameters ()) {
					CCodeIdentifier param_name;

					var priv_access = new CCodeMemberAccess.pointer (new CCodeIdentifier ("self"), "priv");

					param_name = new CCodeIdentifier ("%s_type".printf (type_param.name.down ()));
					ccomma.append_expression (new CCodeAssignment (new CCodeMemberAccess.pointer (priv_access, param_name.name), param_name));

					param_name = new CCodeIdentifier ("%s_dup_func".printf (type_param.name.down ()));
					ccomma.append_expression (new CCodeAssignment (new CCodeMemberAccess.pointer (priv_access, param_name.name), param_name));

					param_name = new CCodeIdentifier ("%s_destroy_func".printf (type_param.name.down ()));
					ccomma.append_expression (new CCodeAssignment (new CCodeMemberAccess.pointer (priv_access, param_name.name), param_name));
				}

				ccall_expr = ccomma;
			}
		}

		bool ellipsis = false;
		
		int i = 1;
		int arg_pos;
		Iterator<FormalParameter> params_it = params.iterator ();
		foreach (Expression arg in expr.get_argument_list ()) {
			CCodeExpression cexpr = (CCodeExpression) arg.ccodenode;

			var carg_map = in_arg_map;

			if (params_it.next ()) {
				var param = params_it.get ();
				ellipsis = param.params_array || param.ellipsis;
				if (!ellipsis) {
					// if the vala argument expands to multiple C arguments,
					// we have to make sure that the C arguments don't depend
					// on each other as there is no guaranteed argument
					// evaluation order
					// http://bugzilla.gnome.org/show_bug.cgi?id=519597
					bool multiple_cargs = false;

					if (param.direction == ParameterDirection.OUT) {
						carg_map = out_arg_map;
					}

					if (!param.no_array_length && param.parameter_type is ArrayType) {
						var array_type = (ArrayType) param.parameter_type;
						for (int dim = 1; dim <= array_type.rank; dim++) {
							carg_map.set (get_param_pos (param.carray_length_parameter_position + 0.01 * dim), head.get_array_length_cexpression (arg, dim));
						}
						multiple_cargs = true;
					} else if (param.parameter_type is DelegateType) {
						var deleg_type = (DelegateType) param.parameter_type;
						var d = deleg_type.delegate_symbol;
						if (d.has_target) {
							CCodeExpression delegate_target_destroy_notify;
							var delegate_target = get_delegate_target_cexpression (arg, out delegate_target_destroy_notify);
							carg_map.set (get_param_pos (param.cdelegate_target_parameter_position), delegate_target);
							if (deleg_type.value_owned) {
								carg_map.set (get_param_pos (param.cdelegate_target_parameter_position + 0.01), delegate_target_destroy_notify);
							}
							multiple_cargs = true;
						}
					} else if (param.parameter_type is MethodType) {
						// callbacks in dynamic method calls
						CCodeExpression delegate_target_destroy_notify;
						carg_map.set (get_param_pos (param.cdelegate_target_parameter_position), get_delegate_target_cexpression (arg, out delegate_target_destroy_notify));
						multiple_cargs = true;
					}

					cexpr = handle_struct_argument (param, arg, cexpr);

					if (multiple_cargs && arg is MethodCall) {
						// if vala argument is invocation expression
						// the auxiliary C argument(s) will depend on the main C argument

						// (tmp = arg1, call (tmp, arg2, arg3,...))

						var ccomma = new CCodeCommaExpression ();

						var temp_decl = get_temp_variable (arg.value_type, true, null, false);
						temp_vars.insert (0, temp_decl);
						ccomma.append_expression (new CCodeAssignment (get_variable_cexpression (temp_decl.name), cexpr));

						cexpr = get_variable_cexpression (temp_decl.name);

						ccomma.append_expression (ccall_expr);

						ccall_expr = ccomma;
					}

					// unref old value for non-null non-weak ref/out arguments
					// disabled for arrays for now as that requires special handling
					// (ret_tmp = call (&tmp), var1 = (assign_tmp = dup (tmp), free (var1), assign_tmp), ret_tmp)
					if (param.direction != ParameterDirection.IN && requires_destroy (arg.value_type)
					    && (param.direction == ParameterDirection.OUT || !param.parameter_type.value_owned)
					    && !(param.parameter_type is ArrayType) && !(param.parameter_type is DelegateType)) {
						var unary = (UnaryExpression) arg;

						var ccomma = new CCodeCommaExpression ();

						var temp_var = get_temp_variable (param.parameter_type, param.parameter_type.value_owned);
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
						if (itype.get_return_type () is VoidType || itype.get_return_type ().is_real_struct_type ()) {
							ccomma.append_expression (ccall_expr);
						} else {
							ret_temp_var = get_temp_variable (itype.get_return_type (), true, null, false);
							temp_vars.insert (0, ret_temp_var);
							ccomma.append_expression (new CCodeAssignment (get_variable_cexpression (ret_temp_var.name), ccall_expr));
						}

						var cassign_comma = new CCodeCommaExpression ();

						var assign_temp_var = get_temp_variable (unary.inner.value_type, unary.inner.value_type.value_owned, null, false);
						temp_vars.insert (0, assign_temp_var);

						cassign_comma.append_expression (new CCodeAssignment (get_variable_cexpression (assign_temp_var.name), transform_expression (get_variable_cexpression (temp_var.name), param.parameter_type, unary.inner.value_type, arg)));

						// unref old value
						cassign_comma.append_expression (get_unref_expression ((CCodeExpression) unary.inner.ccodenode, arg.value_type, arg));

						cassign_comma.append_expression (get_variable_cexpression (assign_temp_var.name));

						// assign new value
						ccomma.append_expression (new CCodeAssignment ((CCodeExpression) unary.inner.ccodenode, cassign_comma));

						// return value
						if (!(itype.get_return_type () is VoidType || itype.get_return_type ().is_real_struct_type ())) {
							ccomma.append_expression (get_variable_cexpression (ret_temp_var.name));
						}

						ccall_expr = ccomma;
					}

					if (param.ctype != null) {
						cexpr = new CCodeCastExpression (cexpr, param.ctype);
					}
				}
				arg_pos = get_param_pos (param.cparameter_position, ellipsis);
			} else {
				// default argument position
				arg_pos = get_param_pos (i, ellipsis);
			}

			carg_map.set (arg_pos, cexpr);

			if (arg is NamedArgument && ellipsis) {
				var named_arg = (NamedArgument) arg;
				string name = string.joinv ("-", named_arg.name.split ("_"));
				carg_map.set (get_param_pos (i - 0.1, ellipsis), new CCodeConstant ("\"%s\"".printf (name)));
			}

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

		/* add length argument for methods returning arrays */
		if (m != null && m.return_type is ArrayType && async_call != ccall) {
			var array_type = (ArrayType) m.return_type;
			for (int dim = 1; dim <= array_type.rank; dim++) {
				if (m.array_null_terminated) {
					// handle calls to methods returning null-terminated arrays
					var temp_var = get_temp_variable (itype.get_return_type (), true, null, false);
					var temp_ref = get_variable_cexpression (temp_var.name);

					temp_vars.insert (0, temp_var);

					ccall_expr = new CCodeAssignment (temp_ref, ccall_expr);

					requires_array_length = true;
					var len_call = new CCodeFunctionCall (new CCodeIdentifier ("_vala_array_length"));
					len_call.add_argument (temp_ref);

					expr.append_array_size (len_call);
				} else if (!m.no_array_length) {
					LocalVariable temp_var;

					if (m.array_length_type == null) {
						temp_var = get_temp_variable (int_type);
					} else {
						temp_var = get_temp_variable (new CType (m.array_length_type));
					}
					var temp_ref = get_variable_cexpression (temp_var.name);

					temp_vars.insert (0, temp_var);

					out_arg_map.set (get_param_pos (m.carray_length_parameter_position + 0.01 * dim), new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, temp_ref));

					expr.append_array_size (temp_ref);
				} else {
					expr.append_array_size (new CCodeConstant ("-1"));
				}
			}
		} else if (m != null && m.return_type is DelegateType && async_call != ccall) {
			var deleg_type = (DelegateType) m.return_type;
			var d = deleg_type.delegate_symbol;
			if (d.has_target) {
				var temp_var = get_temp_variable (new PointerType (new VoidType ()));
				var temp_ref = get_variable_cexpression (temp_var.name);

				temp_vars.insert (0, temp_var);

				out_arg_map.set (get_param_pos (m.cdelegate_target_parameter_position), new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, temp_ref));

				expr.delegate_target = temp_ref;

				if (deleg_type.value_owned) {
					temp_var = get_temp_variable (new DelegateType ((Delegate) context.root.scope.lookup ("GLib").scope.lookup ("DestroyNotify")));
					temp_ref = get_variable_cexpression (temp_var.name);

					temp_vars.insert (0, temp_var);

					out_arg_map.set (get_param_pos (m.cdelegate_target_parameter_position + 0.01), new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, temp_ref));

					expr.delegate_target_destroy_notify = temp_ref;
				}
			}
		}

		// add length argument for delegates returning arrays
		// TODO: avoid code duplication with methods returning arrays, see above
		if (deleg != null && deleg.return_type is ArrayType) {
			var array_type = (ArrayType) deleg.return_type;
			for (int dim = 1; dim <= array_type.rank; dim++) {
				if (deleg.array_null_terminated) {
					// handle calls to methods returning null-terminated arrays
					var temp_var = get_temp_variable (itype.get_return_type (), true, null, false);
					var temp_ref = get_variable_cexpression (temp_var.name);

					temp_vars.insert (0, temp_var);

					ccall_expr = new CCodeAssignment (temp_ref, ccall_expr);

					requires_array_length = true;
					var len_call = new CCodeFunctionCall (new CCodeIdentifier ("_vala_array_length"));
					len_call.add_argument (temp_ref);

					expr.append_array_size (len_call);
				} else if (!deleg.no_array_length) {
					var temp_var = get_temp_variable (int_type);
					var temp_ref = get_variable_cexpression (temp_var.name);

					temp_vars.insert (0, temp_var);

					out_arg_map.set (get_param_pos (deleg.carray_length_parameter_position + 0.01 * dim), new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, temp_ref));

					expr.append_array_size (temp_ref);
				} else {
					expr.append_array_size (new CCodeConstant ("-1"));
				}
			}
		} else if (deleg != null && deleg.return_type is DelegateType) {
			var deleg_type = (DelegateType) deleg.return_type;
			var d = deleg_type.delegate_symbol;
			if (d.has_target) {
				var temp_var = get_temp_variable (new PointerType (new VoidType ()));
				var temp_ref = get_variable_cexpression (temp_var.name);

				temp_vars.insert (0, temp_var);

				out_arg_map.set (get_param_pos (deleg.cdelegate_target_parameter_position), new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, temp_ref));

				expr.delegate_target = temp_ref;
			}
		}

		if (m != null && m.coroutine) {
			if (expr.is_yield_expression) {
				// asynchronous call
				in_arg_map.set (get_param_pos (-1), new CCodeIdentifier (current_method.get_cname () + "_ready"));
				in_arg_map.set (get_param_pos (-0.9), new CCodeIdentifier ("data"));
			}
		}

		if (m is CreationMethod && m.get_error_types ().size > 0) {
			out_arg_map.set (get_param_pos (-1), new CCodeIdentifier ("error"));
		} else if (expr.tree_can_fail) {
			// method can fail
			current_method_inner_error = true;
			// add &inner_error before the ellipsis arguments
			out_arg_map.set (get_param_pos (-1), new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, get_variable_cexpression ("_inner_error_")));
		}

		if (ellipsis) {
			/* ensure variable argument list ends with NULL
			 * except when using printf-style arguments */
			if (!m.printf_format && !m.scanf_format && m.sentinel != "") {
				in_arg_map.set (get_param_pos (-1, true), new CCodeConstant (m.sentinel));
			}
		} else if (itype is DelegateType) {
			var deleg_type = (DelegateType) itype;
			var d = deleg_type.delegate_symbol;
			if (d.has_target) {
				CCodeExpression delegate_target_destroy_notify;
				in_arg_map.set (get_param_pos (d.cinstance_parameter_position), get_delegate_target_cexpression (expr.call, out delegate_target_destroy_notify));
				out_arg_map.set (get_param_pos (d.cinstance_parameter_position), get_delegate_target_cexpression (expr.call, out delegate_target_destroy_notify));
			}
		}

		// structs are returned via out parameter
		bool return_result_via_out_param = itype.get_return_type ().is_real_non_null_struct_type ();

		// pass address for the return value of non-void signals without emitter functions
		if (itype is SignalType && !(itype.get_return_type () is VoidType)) {
			var sig = ((SignalType) itype).signal_symbol;

			if (ma != null && ma.inner is BaseAccess && sig.is_virtual) {
				// normal return value for base access
			} else if (!sig.has_emitter) {
				return_result_via_out_param = true;
			}
		}

		if (return_result_via_out_param) {
			var temp_var = get_temp_variable (itype.get_return_type ());
			var temp_ref = get_variable_cexpression (temp_var.name);

			temp_vars.insert (0, temp_var);

			out_arg_map.set (get_param_pos (-3), new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, temp_ref));

			var ccomma = new CCodeCommaExpression ();
			ccomma.append_expression ((CCodeExpression) ccall_expr);
			ccomma.append_expression ((CCodeExpression) temp_ref);

			ccall_expr = ccomma;
		}

		// append C arguments in the right order
		
		int last_pos;
		int min_pos;

		if (async_call != ccall) {
			// don't append out arguments for .begin() calls
			last_pos = -1;
			while (true) {
				min_pos = -1;
				foreach (int pos in out_arg_map.get_keys ()) {
					if (pos > last_pos && (min_pos == -1 || pos < min_pos)) {
						min_pos = pos;
					}
				}
				if (min_pos == -1) {
					break;
				}
				ccall.add_argument (out_arg_map.get (min_pos));
				last_pos = min_pos;
			}
		}

		if (async_call != null) {
			last_pos = -1;
			while (true) {
				min_pos = -1;
				foreach (int pos in in_arg_map.get_keys ()) {
					if (pos > last_pos && (min_pos == -1 || pos < min_pos)) {
						min_pos = pos;
					}
				}
				if (min_pos == -1) {
					break;
				}
				async_call.add_argument (in_arg_map.get (min_pos));
				last_pos = min_pos;
			}
		}

		if (m != null && m.binding == MemberBinding.INSTANCE && m.returns_modified_pointer) {
			expr.ccodenode = new CCodeAssignment (instance, ccall_expr);
		} else {
			expr.ccodenode = ccall_expr;
		}

		if (expr.is_yield_expression) {
			if (pre_statement_fragment == null) {
				pre_statement_fragment = new CCodeFragment ();
			}
			pre_statement_fragment.append (new CCodeExpressionStatement (async_call));

			int state = next_coroutine_state++;
			pre_statement_fragment.append (new CCodeExpressionStatement (new CCodeAssignment (new CCodeMemberAccess.pointer (new CCodeIdentifier ("data"), "_state_"), new CCodeConstant (state.to_string ()))));
			pre_statement_fragment.append (new CCodeReturnStatement (new CCodeConstant ("FALSE")));
			pre_statement_fragment.append (new CCodeCaseStatement (new CCodeConstant (state.to_string ())));
		}

		if (m is ArrayResizeMethod) {
			// FIXME: size expression must not be evaluated twice at runtime (potential side effects)
			Iterator<Expression> arg_it = expr.get_argument_list ().iterator ();
			arg_it.next ();
			var new_size = (CCodeExpression) arg_it.get ().ccodenode;

			var temp_decl = get_temp_variable (int_type);
			var temp_ref = get_variable_cexpression (temp_decl.name);

			temp_vars.insert (0, temp_decl);

			/* memset needs string.h */
			source_declarations.add_include ("string.h");

			var clen = head.get_array_length_cexpression (ma.inner, 1);
			var celems = (CCodeExpression) ma.inner.ccodenode;
			var array_type = (ArrayType) ma.inner.value_type;
			var csizeof = new CCodeIdentifier ("sizeof (%s)".printf (array_type.element_type.get_cname ()));
			var cdelta = new CCodeBinaryExpression (CCodeBinaryOperator.MINUS, temp_ref, clen);
			var ccheck = new CCodeBinaryExpression (CCodeBinaryOperator.GREATER_THAN, temp_ref, clen);

			var czero = new CCodeFunctionCall (new CCodeIdentifier ("memset"));
			czero.add_argument (new CCodeBinaryExpression (CCodeBinaryOperator.PLUS, celems, clen));
			czero.add_argument (new CCodeConstant ("0"));
			czero.add_argument (new CCodeBinaryExpression (CCodeBinaryOperator.MUL, csizeof, cdelta));

			var ccomma = new CCodeCommaExpression ();
			ccomma.append_expression (new CCodeAssignment (temp_ref, new_size));
			ccomma.append_expression ((CCodeExpression) expr.ccodenode);
			ccomma.append_expression (new CCodeConditionalExpression (ccheck, czero, new CCodeConstant ("NULL")));
			ccomma.append_expression (new CCodeAssignment (head.get_array_length_cexpression (ma.inner, 1), temp_ref));

			expr.ccodenode = ccomma;
		}
	}
}

