/* valaccodemethodcallmodule.vala
 *
 * Copyright (C) 2006-2010  Jürg Billeter
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

public class Vala.CCodeMethodCallModule : CCodeAssignmentModule {
	public override void visit_method_call (MethodCall expr) {
		// the bare function call
		var ccall = new CCodeFunctionCall (get_cvalue (expr.call));

		CCodeFunctionCall async_call = null;
		CCodeFunctionCall finish_call = null;

		Method m = null;
		Delegate deleg = null;
		List<Parameter> params;
		
		var ma = expr.call as MemberAccess;
		
		var itype = expr.call.value_type;
		params = itype.get_parameters ();
		
		if (itype is MethodType) {
			assert (ma != null);
			m = ((MethodType) itype).method_symbol;
			if (ma.inner != null && ma.inner.value_type is EnumValueType && ((EnumValueType) ma.inner.value_type).get_to_string_method() == m) {
				// Enum.VALUE.to_string()
				var en = (Enum) ma.inner.value_type.data_type;
				ccall.call = new CCodeIdentifier (generate_enum_tostring_function (en));
			} else if (expr.is_constructv_chainup) {
				ccall.call = new CCodeIdentifier (get_ccode_constructv_name ((CreationMethod) m));
			}
		} else if (itype is SignalType) {
			var sig_type = (SignalType) itype;
			if (ma != null && ma.inner is BaseAccess && sig_type.signal_symbol.is_virtual) {
				m = sig_type.signal_symbol.default_handler;
			} else {
				ccall = (CCodeFunctionCall) get_cvalue (expr.call);
			}
		} else if (itype is ObjectType) {
			// constructor
			var cl = (Class) ((ObjectType) itype).type_symbol;
			m = cl.default_construction_method;
			generate_method_declaration (m, cfile);
			var real_name = get_ccode_real_name (m);
			if (expr.is_constructv_chainup) {
				real_name = get_ccode_constructv_name ((CreationMethod) m);
			}
			ccall = new CCodeFunctionCall (new CCodeIdentifier (real_name));
		} else if (itype is StructValueType) {
			// constructor
			var st = (Struct) ((StructValueType) itype).type_symbol;
			m = st.default_construction_method;
			generate_method_declaration (m, cfile);
			ccall = new CCodeFunctionCall (new CCodeIdentifier (get_ccode_real_name (m)));
		} else if (itype is DelegateType) {
			deleg = ((DelegateType) itype).delegate_symbol;
		}

		var in_arg_map = new HashMap<int,CCodeExpression> (direct_hash, direct_equal);
		var out_arg_map = in_arg_map;

		if (m != null && m.coroutine) {
			// async call

			async_call = new CCodeFunctionCall (new CCodeIdentifier (get_ccode_name (m)));
			finish_call = new CCodeFunctionCall (new CCodeIdentifier (get_ccode_finish_name (m)));

			if (ma.inner is BaseAccess) {
				if (m.base_method != null) {
					var base_class = (Class) m.base_method.parent_symbol;
					var vcast = new CCodeFunctionCall (new CCodeIdentifier ("%s_CLASS".printf (get_ccode_upper_case_name (base_class, null))));
					vcast.add_argument (new CCodeIdentifier ("%s_parent_class".printf (get_ccode_lower_case_name (current_class, null))));

					async_call.call = new CCodeMemberAccess.pointer (vcast, get_ccode_vfunc_name (m));
					finish_call.call = new CCodeMemberAccess.pointer (vcast, get_ccode_finish_vfunc_name (m));
				} else if (m.base_interface_method != null) {
					var base_iface = (Interface) m.base_interface_method.parent_symbol;
					string parent_iface_var = "%s_%s_parent_iface".printf (get_ccode_lower_case_name (current_class), get_ccode_lower_case_name (base_iface));

					async_call.call = new CCodeMemberAccess.pointer (new CCodeIdentifier (parent_iface_var), get_ccode_vfunc_name (m));
					finish_call.call = new CCodeMemberAccess.pointer (new CCodeIdentifier (parent_iface_var), get_ccode_finish_vfunc_name (m));
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
				out_arg_map.set (get_param_pos (0.1), new CCodeMemberAccess.pointer (new CCodeIdentifier ("_data_"), "_res_"));
			}
		}

		if (m is CreationMethod && m.parent_symbol is Class) {
			if (!((Class) m.parent_symbol).is_compact) {
				ccall.add_argument (get_variable_cexpression ("object_type"));
			}

			if (!current_class.is_compact) {
				if (current_class != m.parent_symbol) {
					// chain up to base class
					foreach (DataType base_type in current_class.get_base_types ()) {
						if (base_type.data_type is Class) {
							List<TypeParameter> type_parameters = null;
							if (get_ccode_real_name (m) == "g_object_new") {
								// gobject-style chainup
								type_parameters = ((Class) base_type.data_type).get_type_parameters ();
							}
							add_generic_type_arguments (in_arg_map, base_type.get_type_arguments (), expr, true, type_parameters);
							break;
						}
					}
				} else {
					// chain up to other constructor in same class
					int type_param_index = 0;
					var cl = (Class) m.parent_symbol;
					foreach (TypeParameter type_param in cl.get_type_parameters ()) {
						in_arg_map.set (get_param_pos (0.1 * type_param_index + 0.01), new CCodeIdentifier ("%s_type".printf (type_param.name.down ())));
						in_arg_map.set (get_param_pos (0.1 * type_param_index + 0.02), new CCodeIdentifier ("%s_dup_func".printf (type_param.name.down ())));
						in_arg_map.set (get_param_pos (0.1 * type_param_index + 0.03), new CCodeIdentifier ("%s_destroy_func".printf (type_param.name.down ())));
						type_param_index++;
					}
				}
			} else if (current_class.base_class == gsource_type) {
				// g_source_new

				string class_prefix = CCodeBaseModule.get_ccode_lower_case_name (current_class);

				var funcs = new CCodeDeclaration ("const GSourceFuncs");
				funcs.modifiers = CCodeModifiers.STATIC;
				funcs.add_declarator (new CCodeVariableDeclarator ("_source_funcs", new CCodeConstant ("{ %s_real_prepare, %s_real_check, %s_real_dispatch, %s_finalize}".printf (class_prefix, class_prefix, class_prefix, class_prefix))));
				ccode.add_statement (funcs);

				ccall.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, new CCodeIdentifier ("_source_funcs")));

				var csizeof = new CCodeFunctionCall (new CCodeIdentifier ("sizeof"));
				csizeof.add_argument (new CCodeIdentifier (get_ccode_name (current_class)));
				ccall.add_argument (csizeof);
			}
		} else if (m is CreationMethod && m.parent_symbol is Struct) {
			ccall.add_argument (get_this_cexpression ());
		} else if (m != null && m.get_type_parameters ().size > 0 && !get_ccode_has_generic_type_parameter (m) && !get_ccode_simple_generics (m) && (ccall != finish_call || expr.is_yield_expression)) {
			// generic method
			// don't add generic arguments for .end() calls
			add_generic_type_arguments (in_arg_map, ma.get_type_arguments (), expr);
		}

		// the complete call expression, might include casts, comma expressions, and/or assignments
		CCodeExpression ccall_expr = ccall;

		if (m is ArrayResizeMethod) {
			var array_type = (ArrayType) ma.inner.value_type;
			in_arg_map.set (get_param_pos (0), new CCodeIdentifier (get_ccode_name (array_type.element_type)));
		} else if (m is ArrayMoveMethod) {
			requires_array_move = true;
		}

		CCodeExpression instance = null;
		if (m != null && m.is_async_callback) {
			if (current_method.closure) {
				var block = ((Method) m.parent_symbol).body;
				instance = new CCodeMemberAccess.pointer (get_variable_cexpression ("_data%d_".printf (get_block_id (block))), "_async_data_");
			} else {
				instance = new CCodeIdentifier ("_data_");
			}

			in_arg_map.set (get_param_pos (get_ccode_instance_pos (m)), instance);
			out_arg_map.set (get_param_pos (get_ccode_instance_pos (m)), instance);
		} else if (m != null && m.binding == MemberBinding.INSTANCE && !(m is CreationMethod)) {
			var instance_value = ma.inner.target_value;
			if ((ma.member_name == "begin" || ma.member_name == "end") && ma.inner.symbol_reference == ma.symbol_reference) {
				var inner_ma = (MemberAccess) ma.inner;
				instance_value = inner_ma.inner.target_value;
			}
			instance = get_cvalue_ (instance_value);

			var st = m.parent_symbol as Struct;
			if (st != null && !st.is_simple_type ()) {
				// we need to pass struct instance by reference
				if (!get_lvalue (instance_value)) {
					instance_value = store_temp_value (instance_value, expr);
				}
				instance = new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, get_cvalue_ (instance_value));
			}

			in_arg_map.set (get_param_pos (get_ccode_instance_pos (m)), instance);
			out_arg_map.set (get_param_pos (get_ccode_instance_pos (m)), instance);
		} else if (m != null && m.binding == MemberBinding.CLASS) {
			var cl = (Class) m.parent_symbol;
			var cast = new CCodeFunctionCall (new CCodeIdentifier (get_ccode_upper_case_name (cl, null) + "_CLASS"));
			
			CCodeExpression klass;
			if (ma.inner == null) {
				if (get_this_type () == null) {
					// Accessing the method from a static or class constructor
					klass = new CCodeIdentifier ("klass");
				} else {
					// Accessing the method from within an instance method
					var k = new CCodeFunctionCall (new CCodeIdentifier ("G_OBJECT_GET_CLASS"));
					k.add_argument (get_this_cexpression ());
					klass = k;
				}
			} else {
				// Accessing the method of an instance
				var k = new CCodeFunctionCall (new CCodeIdentifier ("G_OBJECT_GET_CLASS"));
				k.add_argument (get_cvalue (ma.inner));
				klass = k;
			}

			cast.add_argument (klass);
			in_arg_map.set (get_param_pos (get_ccode_instance_pos (m)), cast);
			out_arg_map.set (get_param_pos (get_ccode_instance_pos (m)), cast);
		}

		if (m != null && get_ccode_has_generic_type_parameter (m)) {
			// insert type argument for macros
			if (m.get_type_parameters ().size > 0) {
				// generic method
				int type_param_index = 0;
				foreach (var type_arg in ma.get_type_arguments ()) {
					in_arg_map.set (get_param_pos (get_ccode_generic_type_pos (m) + 0.01 * type_param_index), new CCodeIdentifier (get_ccode_name (type_arg)));
					type_param_index++;
				}
			} else {
				// method in generic type
				int type_param_index = 0;
				foreach (var type_arg in ma.inner.value_type.get_type_arguments ()) {
					in_arg_map.set (get_param_pos (get_ccode_generic_type_pos (m) + 0.01 * type_param_index), new CCodeIdentifier (get_ccode_name (type_arg)));
					type_param_index++;
				}
			}
		}

		if (m is ArrayMoveMethod) {
			var array_type = (ArrayType) ma.inner.value_type;
			var csizeof = new CCodeFunctionCall (new CCodeIdentifier ("sizeof"));
			csizeof.add_argument (new CCodeIdentifier (get_ccode_name (array_type.element_type)));
			in_arg_map.set (get_param_pos (0.1), csizeof);
		} else if (m is DynamicMethod) {
			m.clear_parameters ();
			int param_nr = 1;
			foreach (Expression arg in expr.get_argument_list ()) {
				var unary = arg as UnaryExpression;
				if (unary != null && unary.operator == UnaryOperator.OUT) {
					// out argument
					var param = new Parameter ("param%d".printf (param_nr), unary.inner.value_type);
					param.direction = ParameterDirection.OUT;
					m.add_parameter (param);
				} else if (unary != null && unary.operator == UnaryOperator.REF) {
					// ref argument
					var param = new Parameter ("param%d".printf (param_nr), unary.inner.value_type);
					param.direction = ParameterDirection.REF;
					m.add_parameter (param);
				} else {
					// in argument
					m.add_parameter (new Parameter ("param%d".printf (param_nr), arg.value_type));
				}
				param_nr++;
			}
			foreach (Parameter param in m.get_parameters ()) {
				param.accept (this);
			}
			generate_dynamic_method_wrapper ((DynamicMethod) m);
		} else if (m is CreationMethod && m.parent_symbol is Class) {
			ccode.add_assignment (get_this_cexpression (), new CCodeCastExpression (ccall, CCodeBaseModule.get_ccode_name (current_class) + "*"));

			if (current_method.body.captured) {
				// capture self after setting it
				var ref_call = new CCodeFunctionCall (get_dup_func_expression (new ObjectType (current_class), expr.source_reference));
				ref_call.add_argument (get_this_cexpression ());

				ccode.add_assignment (new CCodeMemberAccess.pointer (get_variable_cexpression ("_data%d_".printf (get_block_id (current_method.body))), "self"), ref_call);
			}

			if (!current_class.is_compact && current_class.get_type_parameters ().size > 0) {
				/* type, dup func, and destroy func fields for generic types */
				var suffices = new string[] {"type", "dup_func", "destroy_func"};
				foreach (TypeParameter type_param in current_class.get_type_parameters ()) {
					var priv_access = new CCodeMemberAccess.pointer (new CCodeIdentifier ("self"), "priv");

					foreach (string suffix in suffices) {
						var param_name = new CCodeIdentifier ("%s_%s".printf (type_param.name.down (), suffix));
						ccode.add_assignment (new CCodeMemberAccess.pointer (priv_access, param_name.name), param_name);
					}
				}
			}
			// object chainup can't be used as expression
			ccall_expr = null;
		}

		bool ellipsis = false;
		
		int i = 1;
		int arg_pos;
		Iterator<Parameter> params_it = params.iterator ();
		foreach (Expression arg in expr.get_argument_list ()) {
			CCodeExpression cexpr = get_cvalue (arg);

			var carg_map = in_arg_map;

			if (params_it.next ()) {
				var param = params_it.get ();
				ellipsis = param.params_array || param.ellipsis;
				if (!ellipsis) {
					if (param.direction == ParameterDirection.OUT) {
						carg_map = out_arg_map;
					}

					var unary = arg as UnaryExpression;
					if (unary == null || unary.operator != UnaryOperator.OUT) {
						if (get_ccode_array_length (param) && param.variable_type is ArrayType) {
							var array_type = (ArrayType) param.variable_type;
							for (int dim = 1; dim <= array_type.rank; dim++) {
								CCodeExpression? array_length_expr = null;
								if (get_ccode_array_length_type (param) != null) {
									array_length_expr = new CCodeCastExpression (get_array_length_cexpression (arg, dim), get_ccode_array_length_type (param));
								} else {
									array_length_expr = get_array_length_cexpression (arg, dim);
								}
								carg_map.set (get_param_pos (get_ccode_array_length_pos (param) + 0.01 * dim), array_length_expr);
							}
						} else if (param.variable_type is DelegateType) {
							var deleg_type = (DelegateType) param.variable_type;
							var d = deleg_type.delegate_symbol;
							if (d.has_target) {
								CCodeExpression delegate_target_destroy_notify;
								var delegate_target = get_delegate_target_cexpression (arg, out delegate_target_destroy_notify);
								assert (delegate_target != null);
								if (get_ccode_type (param) == "GClosure*") {
									// one single GClosure parameter
									var closure_new = new CCodeFunctionCall (new CCodeIdentifier ("g_cclosure_new"));
									closure_new.add_argument (new CCodeCastExpression (cexpr, "GCallback"));
									closure_new.add_argument (delegate_target);
									closure_new.add_argument (delegate_target_destroy_notify);
									cexpr = new CCodeConditionalExpression (new CCodeBinaryExpression (CCodeBinaryOperator.EQUALITY, cexpr, new CCodeIdentifier ("NULL")), new CCodeIdentifier ("NULL"), closure_new);
								} else {
									carg_map.set (get_param_pos (get_ccode_delegate_target_pos (param)), delegate_target);
									if (deleg_type.is_disposable ()) {
										assert (delegate_target_destroy_notify != null);
										carg_map.set (get_param_pos (get_ccode_delegate_target_pos (param) + 0.01), delegate_target_destroy_notify);
									}
								}
							}
						} else if (param.variable_type is MethodType) {
							// callbacks in dynamic method calls
							CCodeExpression delegate_target_destroy_notify;
							carg_map.set (get_param_pos (get_ccode_delegate_target_pos (param)), get_delegate_target_cexpression (arg, out delegate_target_destroy_notify));
						} else if (param.variable_type is GenericType) {
							if (m != null && get_ccode_simple_generics (m)) {
								var generic_type = (GenericType) param.variable_type;
								int type_param_index = m.get_type_parameter_index (generic_type.type_parameter.name);
								var type_arg = ma.get_type_arguments ().get (type_param_index);
								if (param.variable_type.value_owned) {
									if (requires_copy (type_arg)) {
										carg_map.set (get_param_pos (get_ccode_destroy_notify_pos (param)), get_destroy_func_expression (type_arg));
									} else {
										carg_map.set (get_param_pos (get_ccode_destroy_notify_pos (param)), new CCodeConstant ("NULL"));
									}
								}
							}
						}

						cexpr = handle_struct_argument (param, arg, cexpr);
					} else {
						arg.target_value = null;

						var temp_var = get_temp_variable (param.variable_type, param.variable_type.value_owned);
						emit_temp_var (temp_var);
						set_cvalue (arg, get_variable_cexpression (temp_var.name));
						arg.target_value.value_type = arg.target_type;

						cexpr = new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, get_cvalue (arg));

						if (get_ccode_array_length (param) && param.variable_type is ArrayType) {
							var array_type = (ArrayType) param.variable_type;
							var array_length_type = int_type;
							if (get_ccode_array_length_type (param) != null) {
								array_length_type = new CType (get_ccode_array_length_type (param));
							}
							for (int dim = 1; dim <= array_type.rank; dim++) {
								var temp_array_length = get_temp_variable (array_length_type);
								emit_temp_var (temp_array_length);
								append_array_length (arg, get_variable_cexpression (temp_array_length.name));
								carg_map.set (get_param_pos (get_ccode_array_length_pos (param) + 0.01 * dim), new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, get_array_lengths (arg).get (dim - 1)));
							}
						} else if (param.variable_type is DelegateType) {
							var deleg_type = (DelegateType) param.variable_type;
							var d = deleg_type.delegate_symbol;
							if (d.has_target) {
								temp_var = get_temp_variable (new PointerType (new VoidType ()));
								emit_temp_var (temp_var);
								set_delegate_target (arg, get_variable_cexpression (temp_var.name));
								carg_map.set (get_param_pos (get_ccode_delegate_target_pos (param)), new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, get_delegate_target (arg)));
								if (deleg_type.is_disposable ()) {
									temp_var = get_temp_variable (gdestroynotify_type);
									emit_temp_var (temp_var);
									set_delegate_target_destroy_notify (arg, get_variable_cexpression (temp_var.name));
									carg_map.set (get_param_pos (get_ccode_delegate_target_pos (param) + 0.01), new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, get_delegate_target_destroy_notify (arg)));
								}
							}
						}
					}

					if (get_ccode_type (param) != null) {
						cexpr = new CCodeCastExpression (cexpr, get_ccode_type (param));
					}
				} else {
					cexpr = handle_struct_argument (null, arg, cexpr);
				}
				arg_pos = get_param_pos (get_ccode_pos (param), ellipsis);
			} else {
				// default argument position
				cexpr = handle_struct_argument (null, arg, cexpr);
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
				if (get_ccode_array_null_terminated (m)) {
					// handle calls to methods returning null-terminated arrays
					var temp_var = get_temp_variable (itype.get_return_type (), true, null, false);
					var temp_ref = get_variable_cexpression (temp_var.name);

					emit_temp_var (temp_var);

					ccall_expr = new CCodeAssignment (temp_ref, ccall_expr);

					requires_array_length = true;
					var len_call = new CCodeFunctionCall (new CCodeIdentifier ("_vala_array_length"));
					len_call.add_argument (temp_ref);

					append_array_length (expr, len_call);
				} else if (get_ccode_array_length (m)) {
					LocalVariable temp_var;

					if (get_ccode_array_length_type (m) == null) {
						temp_var = get_temp_variable (int_type);
					} else {
						temp_var = get_temp_variable (new CType (get_ccode_array_length_type (m)));
					}
					var temp_ref = get_variable_cexpression (temp_var.name);

					emit_temp_var (temp_var);

					out_arg_map.set (get_param_pos (get_ccode_array_length_pos (m) + 0.01 * dim), new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, temp_ref));

					append_array_length (expr, temp_ref);
				} else {
					append_array_length (expr, new CCodeConstant ("-1"));
				}
			}
		} else if (m != null && m.return_type is DelegateType && async_call != ccall) {
			var deleg_type = (DelegateType) m.return_type;
			var d = deleg_type.delegate_symbol;
			if (d.has_target) {
				var temp_var = get_temp_variable (new PointerType (new VoidType ()));
				var temp_ref = get_variable_cexpression (temp_var.name);

				emit_temp_var (temp_var);

				out_arg_map.set (get_param_pos (get_ccode_delegate_target_pos (m)), new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, temp_ref));

				set_delegate_target (expr, temp_ref);

				if (deleg_type.is_disposable ()) {
					temp_var = get_temp_variable (gdestroynotify_type);
					temp_ref = get_variable_cexpression (temp_var.name);

					emit_temp_var (temp_var);

					out_arg_map.set (get_param_pos (get_ccode_delegate_target_pos (m) + 0.01), new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, temp_ref));

					set_delegate_target_destroy_notify (expr, temp_ref);
				} else {
					set_delegate_target_destroy_notify (expr, new CCodeConstant ("NULL"));
				}
			} else {
				set_delegate_target (expr, new CCodeConstant ("NULL"));
			}
		}

		// add length argument for delegates returning arrays
		// TODO: avoid code duplication with methods returning arrays, see above
		if (deleg != null && deleg.return_type is ArrayType) {
			var array_type = (ArrayType) deleg.return_type;
			for (int dim = 1; dim <= array_type.rank; dim++) {
				if (get_ccode_array_null_terminated (deleg)) {
					// handle calls to methods returning null-terminated arrays
					var temp_var = get_temp_variable (itype.get_return_type (), true, null, false);
					var temp_ref = get_variable_cexpression (temp_var.name);

					emit_temp_var (temp_var);

					ccall_expr = new CCodeAssignment (temp_ref, ccall_expr);

					requires_array_length = true;
					var len_call = new CCodeFunctionCall (new CCodeIdentifier ("_vala_array_length"));
					len_call.add_argument (temp_ref);

					append_array_length (expr, len_call);
				} else if (get_ccode_array_length (deleg)) {
					var temp_var = get_temp_variable (int_type);
					var temp_ref = get_variable_cexpression (temp_var.name);

					emit_temp_var (temp_var);

					out_arg_map.set (get_param_pos (get_ccode_array_length_pos (deleg) + 0.01 * dim), new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, temp_ref));

					append_array_length (expr, temp_ref);
				} else {
					append_array_length (expr, new CCodeConstant ("-1"));
				}
			}
		} else if (deleg != null && deleg.return_type is DelegateType) {
			var deleg_type = (DelegateType) deleg.return_type;
			var d = deleg_type.delegate_symbol;
			if (d.has_target) {
				var temp_var = get_temp_variable (new PointerType (new VoidType ()));
				var temp_ref = get_variable_cexpression (temp_var.name);

				emit_temp_var (temp_var);

				out_arg_map.set (get_param_pos (get_ccode_delegate_target_pos (deleg)), new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, temp_ref));

				set_delegate_target (expr, temp_ref);
			}
		}

		if (m != null && m.coroutine) {
			if (expr.is_yield_expression) {
				// asynchronous call
				in_arg_map.set (get_param_pos (-1), new CCodeIdentifier (generate_ready_function (current_method)));
				in_arg_map.set (get_param_pos (-0.9), new CCodeIdentifier ("_data_"));
			}
		}

		if (expr.tree_can_fail) {
			// method can fail
			current_method_inner_error = true;
			// add &inner_error before the ellipsis arguments
			out_arg_map.set (get_param_pos (-1), new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, get_variable_cexpression ("_inner_error_")));
		}

		if (ellipsis) {
			/* ensure variable argument list ends with NULL
			 * except when using printf-style arguments */
			if (m == null) {
				in_arg_map.set (get_param_pos (-1, true), new CCodeConstant ("NULL"));
			} else if (!m.printf_format && !m.scanf_format && get_ccode_sentinel (m) != "" && !expr.is_constructv_chainup) {
				in_arg_map.set (get_param_pos (-1, true), new CCodeConstant (get_ccode_sentinel (m)));
			}
		}

		if (itype is DelegateType) {
			var deleg_type = (DelegateType) itype;
			var d = deleg_type.delegate_symbol;
			if (d.has_target) {
				CCodeExpression delegate_target_destroy_notify;
				in_arg_map.set (get_param_pos (get_ccode_instance_pos (d)), get_delegate_target_cexpression (expr.call, out delegate_target_destroy_notify));
				out_arg_map.set (get_param_pos (get_ccode_instance_pos (d)), get_delegate_target_cexpression (expr.call, out delegate_target_destroy_notify));
			}
		}

		// structs are returned via out parameter
		bool return_result_via_out_param = itype.get_return_type ().is_real_non_null_struct_type ();

		// pass address for the return value of non-void signals without emitter functions
		if (itype is SignalType && !(itype.get_return_type () is VoidType)) {
			var sig = ((SignalType) itype).signal_symbol;

			if (ma != null && ma.inner is BaseAccess && sig.is_virtual) {
				// normal return value for base access
			} else if (!get_signal_has_emitter (sig)) {
				return_result_via_out_param = true;
			}
		}

		if (async_call == ccall) {
			// skip out parameter for .begin() calls
			return_result_via_out_param = false;
		}

		CCodeExpression out_param_ref = null;

		if (return_result_via_out_param) {
			var out_param_var = get_temp_variable (itype.get_return_type ());
			out_param_ref = get_variable_cexpression (out_param_var.name);
			emit_temp_var (out_param_var);
			out_arg_map.set (get_param_pos (-3), new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, out_param_ref));
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

		if (expr.is_yield_expression) {
			// set state before calling async function to support immediate callbacks
			int state = next_coroutine_state++;

			ccode.add_assignment (new CCodeMemberAccess.pointer (new CCodeIdentifier ("_data_"), "_state_"), new CCodeConstant (state.to_string ()));
			ccode.add_expression (async_call);
			ccode.add_return (new CCodeConstant ("FALSE"));
			ccode.add_label ("_state_%d".printf (state));
		}

		if (expr.is_assert) {
			string message = ((string) expr.source_reference.begin.pos).substring (0, (int) (expr.source_reference.end.pos - expr.source_reference.begin.pos));
			ccall.call = new CCodeIdentifier ("_vala_assert");
			ccall.add_argument (new CCodeConstant ("\"%s\"".printf (message.replace ("\n", " ").escape (""))));
			requires_assert = true;

		}

		if (return_result_via_out_param) {
			ccode.add_expression (ccall_expr);
			ccall_expr = out_param_ref;
		}

		if (m != null && m.binding == MemberBinding.INSTANCE && m.returns_modified_pointer) {
			if (ma != null && ma.inner.symbol_reference is Property && ma.inner is MemberAccess) {
				var prop = (Property) ma.inner.symbol_reference;
				store_property (prop, ((MemberAccess) ma.inner).inner, new GLibValue (expr.value_type, ccall_expr));
				ccall_expr = null;
			} else {
				ccall_expr = new CCodeAssignment (instance, ccall_expr);
			}
		}

		if (m != null && get_ccode_type (m) != null && get_ccode_type (m) != get_ccode_name (m.return_type)) {
			// Bug 699956: Implement cast for method return type if [CCode type=] annotation is specified
			ccall_expr = new CCodeCastExpression (ccall_expr, get_ccode_name (m.return_type));
		}

		if (m is ArrayResizeMethod) {
			// FIXME: size expression must not be evaluated twice at runtime (potential side effects)
			Iterator<Expression> arg_it = expr.get_argument_list ().iterator ();
			arg_it.next ();
			var new_size = get_cvalue (arg_it.get ());

			var temp_decl = get_temp_variable (int_type);
			var temp_ref = get_variable_cexpression (temp_decl.name);

			emit_temp_var (temp_decl);

			/* memset needs string.h */
			cfile.add_include ("string.h");

			var clen = get_array_length_cexpression (ma.inner, 1);
			var celems = get_cvalue (ma.inner);
			var array_type = (ArrayType) ma.inner.value_type;
			var csizeof = new CCodeIdentifier ("sizeof (%s)".printf (get_ccode_name (array_type.element_type)));
			var cdelta = new CCodeBinaryExpression (CCodeBinaryOperator.MINUS, temp_ref, clen);
			var ccheck = new CCodeBinaryExpression (CCodeBinaryOperator.GREATER_THAN, temp_ref, clen);

			var czero = new CCodeFunctionCall (new CCodeIdentifier ("memset"));
			czero.add_argument (new CCodeBinaryExpression (CCodeBinaryOperator.PLUS, celems, clen));
			czero.add_argument (new CCodeConstant ("0"));
			czero.add_argument (new CCodeBinaryExpression (CCodeBinaryOperator.MUL, csizeof, cdelta));

			ccode.add_assignment (temp_ref, new_size);
			ccode.add_expression (ccall_expr);
			ccode.add_expression (new CCodeConditionalExpression (ccheck, czero, new CCodeConstant ("NULL")));
			ccode.add_assignment (get_array_length_cexpression (ma.inner, 1), temp_ref);

			var array_var = ma.inner.symbol_reference;
			var array_local = array_var as LocalVariable;
			if (array_var != null && array_var.is_internal_symbol ()
			    && ((array_var is LocalVariable && !array_local.captured) || array_var is Field)) {
				ccode.add_assignment (get_array_size_cvalue (ma.inner.target_value), temp_ref);
			}

			return;
		}

		if (expr.parent_node is ExpressionStatement && !expr.value_type.is_disposable ()) {
			if (ccall_expr != null && !return_result_via_out_param) {
				ccode.add_expression (ccall_expr);
			}
		} else {
			var result_type = itype.get_return_type ();

			if (expr.formal_value_type is GenericType && !(expr.value_type is GenericType)) {
				var st = expr.formal_value_type.type_parameter.parent_symbol.parent_symbol as Struct;
				if (expr.formal_value_type.type_parameter.parent_symbol == garray_type ||
				    (st != null && get_ccode_name (st) == "va_list")) {
					// GArray and va_list don't use pointer-based generics
					// above logic copied from visit_expression ()
					// TODO avoid code duplication
					result_type = expr.value_type;
				}
			}

			if (!return_result_via_out_param) {
				var temp_var = get_temp_variable (result_type, result_type.value_owned);
				var temp_ref = get_variable_cexpression (temp_var.name);

				emit_temp_var (temp_var);

				ccode.add_assignment (temp_ref, ccall_expr);
				set_cvalue (expr, temp_ref);
			} else {
				set_cvalue (expr, ccall_expr);
			}
			((GLibValue) expr.target_value).lvalue = true;
		}

		params_it = params.iterator ();
		foreach (Expression arg in expr.get_argument_list ()) {
			Parameter param = null;
			
			if (params_it.next ()) {
				param = params_it.get ();
				if (param.params_array || param.ellipsis) {
					// ignore ellipsis arguments as we currently don't use temporary variables for them
					break;
				}
			}

			var unary = arg as UnaryExpression;
			if (unary == null || unary.operator != UnaryOperator.OUT) {
				continue;
			}

			if (requires_destroy (unary.inner.value_type)) {
				// unref old value
				ccode.add_expression (destroy_value (unary.inner.target_value));
			}

			// assign new value
			store_value (unary.inner.target_value, transform_value (unary.target_value, unary.inner.value_type, arg));

			// handle out null terminated arrays
			if (param != null && get_ccode_array_null_terminated (param)) {
				requires_array_length = true;
				var len_call = new CCodeFunctionCall (new CCodeIdentifier ("_vala_array_length"));
				len_call.add_argument (get_cvalue_ (unary.inner.target_value));
				
				ccode.add_assignment (get_array_length_cvalue (unary.inner.target_value, 1), len_call);
			}
		}

		if (m is CreationMethod && m.parent_symbol is Class && current_class.base_class == gsource_type) {
			var cinitcall = new CCodeFunctionCall (new CCodeIdentifier ("%s_instance_init".printf (get_ccode_lower_case_name (current_class, null))));
			cinitcall.add_argument (get_this_cexpression ());
			ccode.add_expression (cinitcall);
		}
	}

	private string generate_enum_tostring_function (Enum en) {
		var to_string_func = "_%s_to_string".printf (get_ccode_lower_case_name (en));

		if (!add_wrapper (to_string_func)) {
			// wrapper already defined
			return to_string_func;
		}
		// declaration

		var function = new CCodeFunction (to_string_func, "const char*");
		function.modifiers = CCodeModifiers.STATIC;

		function.add_parameter (new CCodeParameter ("value", get_ccode_name (en)));

		// definition
		push_context (new EmitContext ());
		push_function (function);

		ccode.open_switch (new CCodeConstant ("value"));
		foreach (var enum_value in en.get_values ()) {
			ccode.add_case (new CCodeIdentifier (get_ccode_name (enum_value)));
			ccode.add_return (new CCodeConstant ("\""+get_ccode_name (enum_value)+"\""));
		}
		ccode.close ();
		ccode.add_return (new CCodeConstant ("NULL"));

		// append to file
		cfile.add_function_declaration (function);
		cfile.add_function (function);

		pop_context ();

		return to_string_func;
	}
}

