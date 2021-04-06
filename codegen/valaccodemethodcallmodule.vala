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

			if (!get_ccode_simple_generics (m)) {
				context.analyzer.check_type_arguments (ma);
			}

			if (ma.inner != null && ma.inner.value_type is EnumValueType && ((EnumValueType) ma.inner.value_type).get_to_string_method() == m) {
				// Enum.VALUE.to_string()
				unowned Enum en = (Enum) ma.inner.value_type.type_symbol;
				ccall.call = new CCodeIdentifier (generate_enum_to_string_function (en));
			} else if (context.profile == Profile.POSIX && ma.inner != null && ma.inner.value_type != null && ma.inner.value_type.type_symbol == string_type.type_symbol && ma.member_name == "printf") {
				ccall.call = new CCodeIdentifier (generate_string_printf_function ());
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
				CCodeExpression? vcast = null;
				if (m.base_method != null) {
					unowned Class base_class = (Class) m.base_method.parent_symbol;
					vcast = new CCodeFunctionCall (new CCodeIdentifier (get_ccode_class_type_function (base_class)));
					((CCodeFunctionCall) vcast).add_argument (new CCodeIdentifier ("%s_parent_class".printf (get_ccode_lower_case_name (current_class))));
				} else if (m.base_interface_method != null) {
					unowned Interface base_iface = (Interface) m.base_interface_method.parent_symbol;
					vcast = get_this_interface_cexpression (base_iface);
				}
				if (vcast != null) {
					async_call.call = new CCodeMemberAccess.pointer (vcast, get_ccode_vfunc_name (m));
					finish_call.call = new CCodeMemberAccess.pointer (vcast, get_ccode_finish_vfunc_name (m));
				}
			} else if (m != null && get_ccode_no_wrapper (m) && m.binding == MemberBinding.INSTANCE && !(m is CreationMethod)) {
				var instance_value = ma.inner.target_value;
				if ((ma.member_name == "begin" || ma.member_name == "end") && ma.inner.symbol_reference == ma.symbol_reference) {
					var inner_ma = (MemberAccess) ma.inner;
					instance_value = inner_ma.inner.target_value;
				}
				var pub_inst = get_cvalue_ (instance_value);

				CCodeFunctionCall? vcast = null;
				if (m.parent_symbol is Class) {
					unowned Class base_class = (Class) m.parent_symbol;
					if (base_class.external_package) {
						vcast = new CCodeFunctionCall (new CCodeIdentifier ("G_TYPE_INSTANCE_GET_CLASS"));
						vcast.add_argument (pub_inst);
						vcast.add_argument (new CCodeIdentifier (get_ccode_type_id (base_class)));
						vcast.add_argument (new CCodeIdentifier (get_ccode_type_name (base_class)));
					} else {
						vcast = new CCodeFunctionCall (new CCodeIdentifier (get_ccode_type_get_function (base_class)));
						vcast.add_argument (pub_inst);
					}
				} else if (m.parent_symbol is Interface) {
					unowned Interface base_iface = (Interface) m.parent_symbol;
					if (base_iface.external_package) {
						vcast = new CCodeFunctionCall (new CCodeIdentifier ("G_TYPE_INSTANCE_GET_INTERFACE"));
						vcast.add_argument (pub_inst);
						vcast.add_argument (new CCodeIdentifier (get_ccode_type_id (base_iface)));
						vcast.add_argument (new CCodeIdentifier (get_ccode_type_name (base_iface)));
					} else {
						vcast = new CCodeFunctionCall (new CCodeIdentifier (get_ccode_type_get_function (base_iface)));
						vcast.add_argument (pub_inst);
					}
				}
				if (vcast != null) {
					async_call.call = new CCodeMemberAccess.pointer (vcast, get_ccode_vfunc_name (m));
					finish_call.call = new CCodeMemberAccess.pointer (vcast, get_ccode_finish_vfunc_name (m));
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
				out_arg_map.set (get_param_pos (get_ccode_async_result_pos (m)), new CCodeMemberAccess.pointer (new CCodeIdentifier ("_data_"), "_res_"));
			}
		}

		if (m is CreationMethod && m.parent_symbol is Class) {
			if (context.profile == Profile.GOBJECT) {
				if (!((Class) m.parent_symbol).is_compact) {
					ccall.add_argument (get_variable_cexpression ("object_type"));
				}
			} else {
				ccall.add_argument (get_this_cexpression ());
			}

			if (!current_class.is_compact) {
				if (current_class != m.parent_symbol) {
					// chain up to base class
					foreach (DataType base_type in current_class.get_base_types ()) {
						if (base_type.type_symbol is Class) {
							List<TypeParameter> type_parameters = null;
							if (get_ccode_real_name (m) == "g_object_new") {
								// gobject-style chainup
								type_parameters = ((Class) base_type.type_symbol).get_type_parameters ();
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
						in_arg_map.set (get_param_pos (0.1 * type_param_index + 0.01), new CCodeIdentifier ("%s_type".printf (type_param.name.ascii_down ())));
						in_arg_map.set (get_param_pos (0.1 * type_param_index + 0.02), new CCodeIdentifier ("%s_dup_func".printf (type_param.name.ascii_down ())));
						in_arg_map.set (get_param_pos (0.1 * type_param_index + 0.03), new CCodeIdentifier ("%s_destroy_func".printf (type_param.name.ascii_down ())));
						type_param_index++;
					}
				}
			} else if (current_class.base_class == gsource_type) {
				// g_source_new

				string class_prefix = get_ccode_lower_case_name (current_class);

				var funcs = new CCodeDeclaration ("const GSourceFuncs");
				funcs.modifiers = CCodeModifiers.STATIC;
				funcs.add_declarator (new CCodeVariableDeclarator ("_source_funcs", new CCodeConstant ("{ %s_real_prepare, %s_real_check, %s_real_dispatch, %s_finalize}".printf (class_prefix, class_prefix, class_prefix, class_prefix))));
				ccode.add_statement (funcs);

				ccall.add_argument (new CCodeCastExpression (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, new CCodeIdentifier ("_source_funcs")), "GSourceFuncs *"));

				var csizeof = new CCodeFunctionCall (new CCodeIdentifier ("sizeof"));
				csizeof.add_argument (new CCodeIdentifier (get_ccode_name (current_class)));
				ccall.add_argument (csizeof);
			}
		} else if (m is CreationMethod && m.parent_symbol is Struct) {
			ccall.add_argument (get_this_cexpression ());
		} else if (m != null && m.has_type_parameters () && !get_ccode_has_generic_type_parameter (m) && !get_ccode_simple_generics (m) && (ccall != finish_call || expr.is_yield_expression)) {
			// generic method
			// don't add generic arguments for .end() calls
			add_generic_type_arguments (in_arg_map, ma.get_type_arguments (), expr);
		}

		// the complete call expression, might include casts, comma expressions, and/or assignments
		CCodeExpression ccall_expr = ccall;

		if (m is ArrayResizeMethod && context.profile != Profile.POSIX) {
			var array_type = (ArrayType) ma.inner.value_type;
			in_arg_map.set (get_param_pos (0), new CCodeIdentifier (get_ccode_name (array_type.element_type)));
		} else if (m is ArrayMoveMethod) {
			requires_array_move = true;
		} else if (m is ArrayCopyMethod) {
			expr.target_value = copy_value (ma.inner.target_value, expr);
			return;
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

			if (!m.coroutine) {
				in_arg_map.set (get_param_pos (get_ccode_instance_pos (m)), instance);
			} else if (expr.is_yield_expression) {
				in_arg_map.set (get_param_pos (get_ccode_instance_pos (m)), instance);
				if (get_ccode_finish_instance (m)) {
					out_arg_map.set (get_param_pos (get_ccode_instance_pos (m)), instance);
				}
			} else if (ma.member_name != "end" || get_ccode_finish_instance (m)) {
				out_arg_map.set (get_param_pos (get_ccode_instance_pos (m)), instance);
				in_arg_map.set (get_param_pos (get_ccode_instance_pos (m)), instance);
			}
		} else if (m != null && m.binding == MemberBinding.CLASS) {
			var cl = (Class) m.parent_symbol;
			var cast = new CCodeFunctionCall (new CCodeIdentifier (get_ccode_class_type_function (cl)));

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
			if (m.has_type_parameters ()) {
				// generic method
				int type_param_index = 0;
				foreach (var type_arg in ma.get_type_arguments ()) {
					// real structs are passed by reference for simple generics
					if (get_ccode_simple_generics (m) && type_arg.is_real_struct_type () && !type_arg.nullable && !(type_arg is PointerType)) {
					    type_arg = new PointerType (type_arg);
					}
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
			emit_context.push_symbol (m);
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
			emit_context.pop_symbol ();
		} else if (m is CreationMethod && context.profile == Profile.GOBJECT && m.parent_symbol is Class) {
			ccode.add_assignment (get_this_cexpression (), new CCodeCastExpression (ccall, get_ccode_name (current_class) + "*"));

			if (current_method.body.captured) {
				// capture self after setting it
				var ref_call = new CCodeFunctionCall (get_dup_func_expression (new ObjectType (current_class), expr.source_reference));
				ref_call.add_argument (get_this_cexpression ());

				ccode.add_assignment (new CCodeMemberAccess.pointer (get_variable_cexpression ("_data%d_".printf (get_block_id (current_method.body))), "self"), ref_call);
			}

			if (!current_class.is_compact && current_class.has_type_parameters ()) {
				/* type, dup func, and destroy func fields for generic types */
				var suffices = new string[] {"type", "dup_func", "destroy_func"};
				foreach (TypeParameter type_param in current_class.get_type_parameters ()) {
					var priv_access = new CCodeMemberAccess.pointer (new CCodeIdentifier ("self"), "priv");

					foreach (string suffix in suffices) {
						var param_name = new CCodeIdentifier ("%s_%s".printf (type_param.name.ascii_down (), suffix));
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

			Parameter? param = null;
			if (params_it.next ()) {
				param = params_it.get ();
				ellipsis = param.params_array || param.ellipsis;
			}

			if (param != null && !ellipsis) {
					if (param.direction == ParameterDirection.OUT) {
						carg_map = out_arg_map;
					}

					var unary = arg as UnaryExpression;
					if (unary == null || unary.operator != UnaryOperator.OUT) {
						if (get_ccode_array_length (param) && param.variable_type is ArrayType && !((ArrayType) param.variable_type).fixed_length) {
							var array_type = (ArrayType) param.variable_type;
							var length_ctype = get_ccode_array_length_type (param);
							if (unary != null && unary.operator == UnaryOperator.REF) {
								length_ctype = "%s*".printf (length_ctype);
							}
							for (int dim = 1; dim <= array_type.rank; dim++) {
								var array_length_expr = new CCodeCastExpression (get_array_length_cexpression (arg, dim), length_ctype);
								carg_map.set (get_param_pos (get_ccode_array_length_pos (param) + 0.01 * dim), array_length_expr);
							}
						} else if (get_ccode_delegate_target (param) && param.variable_type is DelegateType) {
							var deleg_type = (DelegateType) param.variable_type;
							if (deleg_type.delegate_symbol.has_target) {
								CCodeExpression delegate_target_destroy_notify;
								var delegate_target = get_delegate_target_cexpression (arg, out delegate_target_destroy_notify);
								assert (delegate_target != null);
								if (get_ccode_type (param) == "GClosure*") {
									// one single GClosure parameter
									var closure_new = new CCodeFunctionCall (new CCodeIdentifier ("g_cclosure_new"));
									closure_new.add_argument (new CCodeCastExpression (cexpr, "GCallback"));
									closure_new.add_argument (delegate_target);
									closure_new.add_argument (new CCodeCastExpression (delegate_target_destroy_notify, "GClosureNotify"));
									cexpr = new CCodeConditionalExpression (new CCodeBinaryExpression (CCodeBinaryOperator.EQUALITY, cexpr, new CCodeConstant ("NULL")), new CCodeConstant ("NULL"), closure_new);
								} else {
									// Override previously given target/destroy only if it was NULL
									// TODO https://gitlab.gnome.org/GNOME/vala/issues/59
									var node = carg_map.get (get_param_pos (get_ccode_delegate_target_pos (param)));
									if (node == null || (node is CCodeConstant && ((CCodeConstant) node).name == "NULL")) {
										carg_map.set (get_param_pos (get_ccode_delegate_target_pos (param)), delegate_target);
										if (deleg_type.is_disposable ()) {
											assert (delegate_target_destroy_notify != null);
											carg_map.set (get_param_pos (get_ccode_destroy_notify_pos (param)), delegate_target_destroy_notify);
										}
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

						var temp_var = get_temp_variable (param.variable_type, param.variable_type.value_owned, null, true);
						emit_temp_var (temp_var);
						set_cvalue (arg, get_variable_cexpression (temp_var.name));
						arg.target_value.value_type = arg.target_type;

						cexpr = new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, get_cvalue (arg));

						if (get_ccode_array_length (param) && param.variable_type is ArrayType && !((ArrayType) param.variable_type).fixed_length) {
							var array_type = (ArrayType) param.variable_type;
							var length_ctype = get_ccode_array_length_type (param);
							for (int dim = 1; dim <= array_type.rank; dim++) {
								var temp_array_length = get_temp_variable (new CType (length_ctype, "0"), true, null, true);
								emit_temp_var (temp_array_length);
								append_array_length (arg, get_variable_cexpression (temp_array_length.name));
								carg_map.set (get_param_pos (get_ccode_array_length_pos (param) + 0.01 * dim), new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, get_array_lengths (arg).get (dim - 1)));
							}
						} else if (get_ccode_delegate_target (param) && param.variable_type is DelegateType) {
							var deleg_type = (DelegateType) param.variable_type;
							if (deleg_type.delegate_symbol.has_target) {
								temp_var = get_temp_variable (delegate_target_type, true, null, true);
								emit_temp_var (temp_var);
								set_delegate_target (arg, get_variable_cexpression (temp_var.name));
								carg_map.set (get_param_pos (get_ccode_delegate_target_pos (param)), new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, get_delegate_target (arg)));
								if (deleg_type.is_disposable ()) {
									temp_var = get_temp_variable (delegate_target_destroy_type, true, null, true);
									emit_temp_var (temp_var);
									set_delegate_target_destroy_notify (arg, get_variable_cexpression (temp_var.name));
									carg_map.set (get_param_pos (get_ccode_destroy_notify_pos (param)), new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, get_delegate_target_destroy_notify (arg)));
								}
							}
						}
					}

					if (get_ccode_type (param) != null) {
						cexpr = new CCodeCastExpression (cexpr, get_ccode_type (param));
					}
			} else {
				// ellipsis arguments
				var unary = arg as UnaryExpression;
				if (ellipsis && unary != null && unary.operator == UnaryOperator.OUT) {
					carg_map = out_arg_map;

					arg.target_value = null;

					// infer type and ownership from argument expression
					var temp_var = get_temp_variable (arg.value_type, arg.value_type.value_owned, null, true);
					emit_temp_var (temp_var);
					set_cvalue (arg, get_variable_cexpression (temp_var.name));
					arg.target_value.value_type = arg.value_type;

					if (arg.value_type is DelegateType && ((DelegateType) arg.value_type).delegate_symbol.has_target) {
						// Initialize target/destroy cvalues to allow assignment of delegates from varargs
						unowned GLibValue arg_value = (GLibValue) arg.target_value;
						if (arg_value.delegate_target_cvalue == null) {
							arg_value.delegate_target_cvalue = new CCodeConstant ("NULL");
						}
						if (arg_value.delegate_target_destroy_notify_cvalue == null) {
							arg_value.delegate_target_destroy_notify_cvalue = new CCodeConstant ("NULL");
						}
					}

					cexpr = new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, get_cvalue (arg));
				} else {
					cexpr = handle_struct_argument (null, arg, cexpr);
				}
			}

			arg_pos = get_param_pos (param != null && !ellipsis ? get_ccode_pos (param) : i, ellipsis);
			carg_map.set (arg_pos, cexpr);

			if (m is ArrayResizeMethod && context.profile == Profile.POSIX) {
				var csizeof = new CCodeIdentifier ("sizeof (%s)".printf (get_ccode_name (((ArrayType) ma.inner.value_type).element_type)));
				carg_map.set (arg_pos, new CCodeBinaryExpression (CCodeBinaryOperator.MUL, csizeof, cexpr));
			} else {
				carg_map.set (arg_pos, cexpr);
			}

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
					var length_ctype = get_ccode_array_length_type (m);
					var temp_var = get_temp_variable (new CType (length_ctype, "0"), true, null, true);
					var temp_ref = get_variable_cexpression (temp_var.name);

					emit_temp_var (temp_var);

					out_arg_map.set (get_param_pos (get_ccode_array_length_pos (m) + 0.01 * dim), new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, temp_ref));

					append_array_length (expr, temp_ref);
				} else if (get_ccode_array_length_expr (m) != null) {
					append_array_length (expr, new CCodeConstant (get_ccode_array_length_expr (m)));
				} else {
					append_array_length (expr, new CCodeConstant ("-1"));
				}
			}
		} else if (m != null && m.return_type is DelegateType && async_call != ccall) {
			var deleg_type = (DelegateType) m.return_type;
			if (get_ccode_delegate_target (m) && deleg_type.delegate_symbol.has_target) {
				var temp_var = get_temp_variable (delegate_target_type, true, null, true);
				var temp_ref = get_variable_cexpression (temp_var.name);

				emit_temp_var (temp_var);

				out_arg_map.set (get_param_pos (get_ccode_delegate_target_pos (m)), new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, temp_ref));

				set_delegate_target (expr, temp_ref);

				if (deleg_type.is_disposable ()) {
					temp_var = get_temp_variable (delegate_target_destroy_type, true, null, true);
					temp_ref = get_variable_cexpression (temp_var.name);

					emit_temp_var (temp_var);

					out_arg_map.set (get_param_pos (get_ccode_destroy_notify_pos (m)), new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, temp_ref));

					set_delegate_target_destroy_notify (expr, temp_ref);
				} else {
					set_delegate_target_destroy_notify (expr, new CCodeConstant ("NULL"));
				}
			} else {
				set_delegate_target (expr, new CCodeConstant ("NULL"));
				if (deleg_type.delegate_symbol.has_target) {
					set_delegate_target_destroy_notify (expr, new CCodeConstant ("NULL"));
				}
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
					var length_ctype = get_ccode_array_length_type (deleg);
					var temp_var = get_temp_variable (new CType (length_ctype, "0"), true, null, true);
					var temp_ref = get_variable_cexpression (temp_var.name);

					emit_temp_var (temp_var);

					out_arg_map.set (get_param_pos (get_ccode_array_length_pos (deleg) + 0.01 * dim), new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, temp_ref));

					append_array_length (expr, temp_ref);
				} else {
					append_array_length (expr, new CCodeConstant ("-1"));
				}
			}
		} else if (deleg != null && deleg.return_type is DelegateType && get_ccode_delegate_target (deleg)) {
			var deleg_type = (DelegateType) deleg.return_type;
			if (deleg_type.delegate_symbol.has_target) {
				var temp_var = get_temp_variable (delegate_target_type, true, null, true);
				var temp_ref = get_variable_cexpression (temp_var.name);

				emit_temp_var (temp_var);

				out_arg_map.set (get_param_pos (get_ccode_delegate_target_pos (deleg)), new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, temp_ref));

				set_delegate_target (expr, temp_ref);

				if (deleg_type.is_disposable ()) {
					temp_var = get_temp_variable (delegate_target_destroy_type, true, null, true);
					temp_ref = get_variable_cexpression (temp_var.name);

					emit_temp_var (temp_var);

					out_arg_map.set (get_param_pos (get_ccode_destroy_notify_pos (deleg)), new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, temp_ref));

					set_delegate_target_destroy_notify (expr, temp_ref);
				}
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
			out_arg_map.set (get_param_pos (get_ccode_error_pos ((Callable) m ?? deleg)), new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, get_inner_error_cexpression ()));
		} else if (m != null && m.has_error_type_parameter () && async_call != ccall) {
			// inferred error argument from base method
			out_arg_map.set (get_param_pos (get_ccode_error_pos (m)), new CCodeConstant ("NULL"));
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

		if (deleg != null && deleg.has_target) {
			CCodeExpression delegate_target_destroy_notify;
			in_arg_map.set (get_param_pos (get_ccode_instance_pos (deleg)), get_delegate_target_cexpression (expr.call, out delegate_target_destroy_notify));
			out_arg_map.set (get_param_pos (get_ccode_instance_pos (deleg)), get_delegate_target_cexpression (expr.call, out delegate_target_destroy_notify));
		}

		// structs are returned via out parameter
		bool return_result_via_out_param = itype.get_return_type ().is_real_non_null_struct_type ();

		// pass address for the return value of non-void signals without emitter functions
		if (itype is SignalType && !(itype.get_return_type () is VoidType)) {
			var sig = ((SignalType) itype).signal_symbol;

			if (ma != null && ma.inner is BaseAccess && sig.is_virtual) {
				// normal return value for base access
			} else if (!get_ccode_has_emitter (sig) || ma.source_reference.file == sig.source_reference.file) {
				return_result_via_out_param = true;
			}
		}

		if (async_call == ccall) {
			// skip out parameter for .begin() calls
			return_result_via_out_param = false;
		}

		CCodeExpression out_param_ref = null;

		if (return_result_via_out_param) {
			var out_param_var = get_temp_variable (itype.get_return_type (), true, null, true);
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
			int state = emit_context.next_coroutine_state++;

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

		// real structs are passed by reference for simple generics
		if (m != null && get_ccode_simple_generics (m) && m.return_type is GenericType
		    && expr.value_type.is_real_struct_type () && !expr.value_type.nullable && !(expr.value_type is PointerType)) {
		    ccall_expr = new CCodeUnaryExpression (CCodeUnaryOperator.POINTER_INDIRECTION, new CCodeParenthesizedExpression (ccall_expr));
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
			if (array_var != null && array_var.is_internal_symbol ()
			    && (array_var is LocalVariable || array_var is Field)) {
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
				var type_parameter = ((GenericType) expr.formal_value_type).type_parameter;
				var st = type_parameter.parent_symbol.parent_symbol as Struct;
				if (type_parameter.parent_symbol == garray_type ||
				    (st != null && get_ccode_name (st) == "va_list")) {
					// GArray and va_list don't use pointer-based generics
					// above logic copied from visit_expression ()
					// TODO avoid code duplication
					result_type = expr.value_type;
				}
				if (st != null && get_ccode_name (st) == "va_list" && ma.member_name == "arg") {
					if (result_type is DelegateType && ((DelegateType) result_type).delegate_symbol.has_target) {
						set_cvalue (expr, null);
						// Initialize target/destroy cvalues to allow assignment of delegates from varargs
						unowned GLibValue arg_value = (GLibValue) expr.target_value;
						if (arg_value.delegate_target_cvalue == null) {
							arg_value.delegate_target_cvalue = new CCodeConstant ("NULL");
						}
						if (arg_value.delegate_target_destroy_notify_cvalue == null) {
							arg_value.delegate_target_destroy_notify_cvalue = new CCodeConstant ("NULL");
						}
					}
				}
			}

			if (m != null && m.get_format_arg_index () >= 0) {
				set_cvalue (expr, ccall_expr);
			} else if (m != null && m.get_attribute_bool ("CCode", "use_inplace", false)) {
				set_cvalue (expr, ccall_expr);
			} else if (!return_result_via_out_param
			    && !has_ref_out_argument (expr)
			    && (result_type is ValueType && !result_type.is_disposable ())) {
				set_cvalue (expr, ccall_expr);
			} else if (!return_result_via_out_param) {
				var temp_var = get_temp_variable (result_type, result_type.value_owned, null, false);
				var temp_ref = get_variable_cexpression (temp_var.name);

				emit_temp_var (temp_var);

				ccode.add_assignment (temp_ref, ccall_expr);
				set_cvalue (expr, temp_ref);
				((GLibValue) expr.target_value).lvalue = true;
			} else {
				set_cvalue (expr, ccall_expr);
				((GLibValue) expr.target_value).lvalue = true;
			}
		}

		params_it = params.iterator ();
		foreach (Expression arg in expr.get_argument_list ()) {
			Parameter param = null;

			if (params_it.next ()) {
				param = params_it.get ();
			}

			var unary = arg as UnaryExpression;

			// update possible stale _*_size_ variable
			if (unary != null && unary.operator == UnaryOperator.REF) {
				if (param != null && get_ccode_array_length (param) && param.variable_type is ArrayType
				    && !((ArrayType) param.variable_type).fixed_length && ((ArrayType) param.variable_type).rank == 1) {
					unowned Variable? array_var = unary.inner.symbol_reference as Variable;
					if ((array_var is LocalVariable || array_var is Field) && array_var.is_internal_symbol ()
					    && array_var.variable_type is ArrayType && !((ArrayType) array_var.variable_type).fixed_length) {
						ccode.add_assignment (get_array_size_cvalue (unary.inner.target_value), get_array_length_cvalue (unary.inner.target_value, 1));
					}
				}
			}

			if (unary == null || unary.operator != UnaryOperator.OUT) {
				continue;
			}

			if (requires_destroy (unary.inner.value_type)) {
				// unref old value
				ccode.add_expression (destroy_value (unary.inner.target_value));
			}

			// infer type of out-parameter from argument
			if (ma.symbol_reference is DynamicMethod && unary.target_value.value_type == null) {
				unary.target_value.value_type = unary.inner.value_type.copy ();
			}

			// assign new value
			store_value (unary.inner.target_value, transform_value (unary.target_value, unary.inner.value_type, arg), expr.source_reference);

			// handle out null terminated arrays
			if (param != null && get_ccode_array_null_terminated (param)) {
				requires_array_length = true;
				var len_call = new CCodeFunctionCall (new CCodeIdentifier ("_vala_array_length"));
				len_call.add_argument (get_cvalue_ (unary.inner.target_value));

				ccode.add_assignment (get_array_length_cvalue (unary.inner.target_value, 1), len_call);
			}
		}

		if (m is CreationMethod && m.parent_symbol is Class && ((current_class.is_compact && current_class.base_class != null) || current_class.base_class == gsource_type)) {
			var cinitcall = new CCodeFunctionCall (new CCodeIdentifier ("%s_instance_init".printf (get_ccode_lower_case_name (current_class, null))));
			cinitcall.add_argument (get_this_cexpression ());
			if (!current_class.is_compact) {
				cinitcall.add_argument (new CCodeConstant ("NULL"));
			}
			ccode.add_expression (cinitcall);
		}
	}

	private string generate_enum_to_string_function (Enum en) {
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

	bool has_ref_out_argument (MethodCall c) {
		foreach (var arg in c.get_argument_list ()) {
			unowned UnaryExpression? unary = arg as UnaryExpression;
			if (unary != null && (unary.operator == UnaryOperator.OUT || unary.operator == UnaryOperator.REF)) {
				return true;
			}
		}
		return false;
	}

	string generate_string_printf_function () {
		if (!add_wrapper ("string_printf")) {
			// wrapper already defined
			return "string_printf";
		}

		// declaration
		var function = new CCodeFunction ("string_printf", "char*");
		function.add_parameter (new CCodeParameter ("format", "const char*"));
		function.add_parameter (new CCodeParameter.with_ellipsis ());
		function.modifiers = CCodeModifiers.STATIC;

		// definition
		push_context (new EmitContext ());
		push_function (function);

		ccode.add_declaration ("int", new CCodeVariableDeclarator ("length"));
		ccode.add_declaration ("va_list", new CCodeVariableDeclarator ("ap"));
		ccode.add_declaration ("char*", new CCodeVariableDeclarator ("result"));

		var va_start = new CCodeFunctionCall (new CCodeIdentifier ("va_start"));
		va_start.add_argument (new CCodeIdentifier ("ap"));
		va_start.add_argument (new CCodeIdentifier ("format"));

		ccode.add_expression (va_start);

		if (context.profile == Profile.POSIX) {
			cfile.add_include ("stdio.h");
		}

		var vsnprintf = new CCodeFunctionCall (new CCodeIdentifier ("vsnprintf"));
		vsnprintf.add_argument (new CCodeConstant ("NULL"));
		vsnprintf.add_argument (new CCodeConstant ("0"));
		vsnprintf.add_argument (new CCodeIdentifier ("format"));
		vsnprintf.add_argument (new CCodeIdentifier ("ap"));

		ccode.add_assignment (new CCodeIdentifier ("length"), new CCodeBinaryExpression (CCodeBinaryOperator.PLUS, vsnprintf, new CCodeConstant ("1")));

		var va_end = new CCodeFunctionCall (new CCodeIdentifier ("va_end"));
		va_end.add_argument (new CCodeIdentifier ("ap"));

		ccode.add_expression (va_end);

		var malloc = new CCodeFunctionCall (new CCodeIdentifier ("malloc"));
		malloc.add_argument (new CCodeIdentifier ("length"));

		ccode.add_assignment (new CCodeIdentifier ("result"), malloc);

		va_start = new CCodeFunctionCall (new CCodeIdentifier ("va_start"));
		va_start.add_argument (new CCodeIdentifier ("ap"));
		va_start.add_argument (new CCodeIdentifier ("format"));

		ccode.add_expression (va_start);

		vsnprintf = new CCodeFunctionCall (new CCodeIdentifier ("vsnprintf"));
		vsnprintf.add_argument (new CCodeIdentifier ("result"));
		vsnprintf.add_argument (new CCodeIdentifier ("length"));
		vsnprintf.add_argument (new CCodeIdentifier ("format"));
		vsnprintf.add_argument (new CCodeIdentifier ("ap"));

		ccode.add_expression (vsnprintf);

		va_end = new CCodeFunctionCall (new CCodeIdentifier ("va_end"));
		va_end.add_argument (new CCodeIdentifier ("ap"));

		ccode.add_expression (va_end);

		ccode.add_return (new CCodeIdentifier ("result"));

		// append to file
		cfile.add_include ("stdarg.h");
		cfile.add_function_declaration (function);
		cfile.add_function (function);

		pop_context ();

		return "string_printf";
	}
}

