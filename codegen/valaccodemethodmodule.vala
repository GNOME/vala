/* valaccodemethodmodule.vala
 *
 * Copyright (C) 2007-2010  Jürg Billeter
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

/**
 * The link between a method and generated code.
 */
public abstract class Vala.CCodeMethodModule : CCodeStructModule {

	private bool ellipses_to_valist = false;

	public override bool method_has_wrapper (Method method) {
		return (method.get_attribute ("NoWrapper") == null);
	}

	string get_creturn_type (Method m, string default_value) {
		string type = get_ccode_type (m);
		if (type == null) {
			return default_value;
		}
		return type;
	}

	bool is_gtypeinstance_creation_method (Method m) {
		bool result = false;

		var cl = m.parent_symbol as Class;
		if (m is CreationMethod && cl != null && !cl.is_compact) {
			result = true;
		}

		return result;
	}

	public virtual void generate_method_result_declaration (Method m, CCodeFile decl_space, CCodeFunction cfunc, Map<int,CCodeParameter> cparam_map, Map<int,CCodeExpression>? carg_map) {
		var creturn_type = get_callable_creturn_type (m);
		cfunc.return_type = get_creturn_type (m, get_ccode_name (creturn_type));

		generate_type_declaration (m.return_type, decl_space);

		if (m.return_type.is_real_non_null_struct_type ()) {
			// structs are returned via out parameter
			var cparam = new CCodeParameter ("result", get_ccode_name (m.return_type) + "*");
			cparam_map.set (get_param_pos (-3), cparam);
			if (carg_map != null) {
				carg_map.set (get_param_pos (-3), get_cexpression ("result"));
			}
		} else if (get_ccode_array_length (m) && m.return_type is ArrayType) {
			// return array length if appropriate
			var array_type = (ArrayType) m.return_type;
			var length_ctype = get_ccode_array_length_type (m) + "*";

			for (int dim = 1; dim <= array_type.rank; dim++) {
				var cparam = new CCodeParameter (get_array_length_cname ("result", dim), length_ctype);
				cparam_map.set (get_param_pos (get_ccode_array_length_pos (m) + 0.01 * dim), cparam);
				if (carg_map != null) {
					carg_map.set (get_param_pos (get_ccode_array_length_pos (m) + 0.01 * dim), get_cexpression (cparam.name));
				}
			}
		} else if (get_ccode_delegate_target (m) && m.return_type is DelegateType) {
			// return delegate target if appropriate
			var deleg_type = (DelegateType) m.return_type;
			if (deleg_type.delegate_symbol.has_target) {
				var cparam = new CCodeParameter (get_delegate_target_cname ("result"), get_ccode_name (delegate_target_type) + "*");
				cparam_map.set (get_param_pos (get_ccode_delegate_target_pos (m)), cparam);
				if (carg_map != null) {
					carg_map.set (get_param_pos (get_ccode_delegate_target_pos (m)), get_cexpression (cparam.name));
				}
				if (deleg_type.is_disposable ()) {
					cparam = new CCodeParameter (get_delegate_target_destroy_notify_cname ("result"), get_ccode_name (delegate_target_destroy_type) + "*");
					cparam_map.set (get_param_pos (get_ccode_delegate_target_pos (m) + 0.01), cparam);
					if (carg_map != null) {
						carg_map.set (get_param_pos (get_ccode_delegate_target_pos (m) + 0.01), get_cexpression (cparam.name));
					}
				}
			}
		}

		if (m.has_error_type_parameter ()) {
			var error_types = new ArrayList<DataType> ();
			m.get_error_types (error_types);
			foreach (DataType error_type in error_types) {
				generate_type_declaration (error_type, decl_space);
			}

			var cparam = new CCodeParameter ("error", "GError**");
			cparam_map.set (get_param_pos (get_ccode_error_pos (m)), cparam);
			if (carg_map != null) {
				carg_map.set (get_param_pos (get_ccode_error_pos (m)), new CCodeIdentifier (cparam.name));
			}
		}
	}

	public void complete_async () {
		var data_var = new CCodeIdentifier ("_data_");
		var async_result_expr = new CCodeMemberAccess.pointer (data_var, "_async_result");

		var finish_call = new CCodeFunctionCall (new CCodeIdentifier ("g_task_return_pointer"));
		finish_call.add_argument (async_result_expr);
		finish_call.add_argument (data_var);
		finish_call.add_argument (new CCodeConstant ("NULL"));
		ccode.add_expression (finish_call);

		// Preserve the "complete now" behavior if state != 0, do so by
		//  iterating the GTask's main context till the task is complete.
		var state = new CCodeMemberAccess.pointer (data_var, "_state_");
		var zero = new CCodeConstant ("0");
		var state_is_not_zero = new CCodeBinaryExpression (CCodeBinaryOperator.INEQUALITY, state, zero);
		ccode.open_if (state_is_not_zero);

		CCodeExpression task_is_complete;

		var task_complete = new CCodeFunctionCall (new CCodeIdentifier ("g_task_get_completed"));
		task_complete.add_argument (async_result_expr);
		task_is_complete = new CCodeUnaryExpression (CCodeUnaryOperator.LOGICAL_NEGATION, task_complete);

		ccode.open_while (task_is_complete);
		var task_context = new CCodeFunctionCall (new CCodeIdentifier ("g_task_get_context"));
		task_context.add_argument (async_result_expr);
		var iterate_context = new CCodeFunctionCall (new CCodeIdentifier ("g_main_context_iteration"));
		iterate_context.add_argument (task_context);
		iterate_context.add_argument (new CCodeConstant ("TRUE"));
		ccode.add_expression (iterate_context);
		ccode.close ();

		ccode.close ();

		var unref = new CCodeFunctionCall (new CCodeIdentifier ("g_object_unref"));
		unref.add_argument (async_result_expr);
		ccode.add_expression (unref);

		ccode.add_return (new CCodeConstant ("FALSE"));
	}

	public override bool generate_method_declaration (Method m, CCodeFile decl_space) {
		if (m.is_async_callback) {
			return false;
		}
		if (add_symbol_declaration (decl_space, m, get_ccode_name (m))) {
			return false;
		}

		generate_type_declaration (new MethodType (m), decl_space);

		var function = new CCodeFunction (get_ccode_name (m));

		if (m.is_private_symbol () && !m.external) {
			function.modifiers |= CCodeModifiers.STATIC;
			if (m.is_inline) {
				function.modifiers |= CCodeModifiers.INLINE;
			}
		} else if (context.hide_internal && m.is_internal_symbol () && !m.external) {
			function.modifiers |= CCodeModifiers.INTERNAL;
		}

		if (m.version.deprecated) {
			function.modifiers |= CCodeModifiers.DEPRECATED;
		}

		var cparam_map = new HashMap<int,CCodeParameter> (direct_hash, direct_equal);
		var carg_map = new HashMap<int,CCodeExpression> (direct_hash, direct_equal);

		var cl = m.parent_symbol as Class;

		// do not generate _new functions for creation methods of abstract classes
		if (!(m is CreationMethod && cl != null && cl.is_abstract && !cl.is_compact)) {
			bool etv_tmp = ellipses_to_valist;
			ellipses_to_valist = false;
			generate_cparameters (m, decl_space, cparam_map, function, null, carg_map, new CCodeFunctionCall (new CCodeIdentifier ("fake")));
			ellipses_to_valist = etv_tmp;

			decl_space.add_function_declaration (function);
		}

		if (is_gtypeinstance_creation_method (m)) {
			// _construct function
			function = new CCodeFunction (get_ccode_real_name (m));

			if (m.is_private_symbol ()) {
				function.modifiers |= CCodeModifiers.STATIC;
			} else if (context.hide_internal && m.is_internal_symbol ()) {
				function.modifiers |= CCodeModifiers.INTERNAL;
			}

			cparam_map = new HashMap<int,CCodeParameter> (direct_hash, direct_equal);
			bool etv_tmp = ellipses_to_valist;
			ellipses_to_valist = false;
			generate_cparameters (m, decl_space, cparam_map, function);
			ellipses_to_valist = etv_tmp;

			decl_space.add_function_declaration (function);

			if (m.is_variadic ()) {
				// _constructv function
				function = new CCodeFunction (get_ccode_constructv_name ((CreationMethod) m));

				cparam_map = new HashMap<int,CCodeParameter> (direct_hash, direct_equal);
				generate_cparameters (m, decl_space, cparam_map, function);

				decl_space.add_function_declaration (function);
			}
		}

		return true;
	}

	void register_plugin_types (Symbol sym, Set<Symbol> registered_types) {
		var ns = sym as Namespace;
		var cl = sym as Class;
		var iface = sym as Interface;
		if (ns != null) {
			foreach (var ns_ns in ns.get_namespaces ()) {
				register_plugin_types (ns_ns, registered_types);
			}
			foreach (var ns_cl in ns.get_classes ()) {
				register_plugin_types (ns_cl, registered_types);
			}
			foreach (var ns_iface in ns.get_interfaces ()) {
				register_plugin_types (ns_iface, registered_types);
			}
		} else if (cl != null) {
			register_plugin_type (cl, registered_types);
			foreach (var cl_cl in cl.get_classes ()) {
				register_plugin_types (cl_cl, registered_types);
			}
		} else if (iface != null) {
			register_plugin_type (iface, registered_types);
			foreach (var iface_cl in iface.get_classes ()) {
				register_plugin_types (iface_cl, registered_types);
			}
		}
	}

	void register_plugin_type (ObjectTypeSymbol type_symbol, Set<Symbol> registered_types) {
		if (type_symbol.external_package) {
			return;
		}

		if (!registered_types.add (type_symbol)) {
			// already registered
			return;
		}

		var cl = type_symbol as Class;
		if (cl != null) {
			if (cl.is_compact) {
				return;
			}

			// register base types first
			foreach (var base_type in cl.get_base_types ()) {
				register_plugin_type ((ObjectTypeSymbol) base_type.type_symbol, registered_types);
			}
		}

		// Add function prototypes for required register-type-calls which are likely external
		if (type_symbol.source_reference.file != cfile.file) {
			// TODO Duplicated source with TypeRegisterFunction.init_from_type()
			var register_func = new CCodeFunction ("%s_register_type".printf (get_ccode_lower_case_name (type_symbol, null)), "GType");
			register_func.add_parameter (new CCodeParameter ("module", "GTypeModule *"));
			register_func.is_declaration = true;
			cfile.add_function_declaration (register_func);
		}

		var register_call = new CCodeFunctionCall (new CCodeIdentifier ("%s_register_type".printf (get_ccode_lower_case_name (type_symbol, null))));
		register_call.add_argument (new CCodeIdentifier (module_init_param_name));
		ccode.add_expression (register_call);

		var iface = type_symbol as Interface;
		if (iface != null) {
			string? dbus_name = GDBusModule.get_dbus_name(type_symbol);

			if (dbus_name != null) {
				string proxy_cname = get_ccode_lower_case_prefix (type_symbol) + "proxy";
				var register_proxy = new CCodeFunctionCall (new CCodeIdentifier ("%s_register_dynamic_type".printf (proxy_cname)));
				register_proxy.add_argument (new CCodeIdentifier (module_init_param_name));
				ccode.add_expression (register_proxy);
			}
		}
	}

	/**
	 * This function generates the code the given method. If the method is
	 * a constructor, _construct is generated, unless it's variadic, in which
	 * case _constructv is generated (and _construct is generated together
	 * with _new in visit_creation_method).
	 */
	public override void visit_method (Method m) {
		string real_name = get_ccode_real_name (m);
		if (m is CreationMethod && m.is_variadic ()) {
			real_name = get_ccode_constructv_name ((CreationMethod) m);
		}

		push_context (new EmitContext (m));
		push_line (m.source_reference);

		bool in_gobject_creation_method = false;
		bool in_fundamental_creation_method = false;

		bool profile = m.get_attribute ("Profile") != null;

		if (m is CreationMethod) {
			var cl = current_type_symbol as Class;
			if (cl != null && !cl.is_compact) {
				if (cl.base_class == null) {
					in_fundamental_creation_method = true;
				} else if (gobject_type != null && cl.is_subtype_of (gobject_type)) {
					in_gobject_creation_method = true;
				}
			}
		}

		var creturn_type = get_callable_creturn_type (m);

		foreach (Parameter param in m.get_parameters ()) {
			param.accept (this);
		}

		// do not declare overriding methods and interface implementations
		if ((m.is_abstract || m.is_virtual
			 || (m.base_method == null && m.base_interface_method == null)) && m.signal_reference == null) {
			generate_method_declaration (m, cfile);

			if (!m.is_internal_symbol ()) {
				generate_method_declaration (m, header_file);
			}
			if (!m.is_private_symbol ()) {
				generate_method_declaration (m, internal_header_file);
			}
		}

		if (profile) {
			string prefix = "_vala_prof_%s".printf (real_name);

			cfile.add_include ("stdio.h");

			var counter = new CCodeIdentifier (prefix + "_counter");
			var counter_decl = new CCodeDeclaration (get_ccode_name (int_type));
			counter_decl.add_declarator (new CCodeVariableDeclarator (counter.name));
			counter_decl.modifiers = CCodeModifiers.STATIC;
			cfile.add_type_member_declaration (counter_decl);

			// nesting level for recursive functions
			var level = new CCodeIdentifier (prefix + "_level");
			var level_decl = new CCodeDeclaration (get_ccode_name (int_type));
			level_decl.add_declarator (new CCodeVariableDeclarator (level.name));
			level_decl.modifiers = CCodeModifiers.STATIC;
			cfile.add_type_member_declaration (level_decl);

			var timer = new CCodeIdentifier (prefix + "_timer");
			var timer_decl = new CCodeDeclaration ("GTimer *");
			timer_decl.add_declarator (new CCodeVariableDeclarator (timer.name));
			timer_decl.modifiers = CCodeModifiers.STATIC;
			cfile.add_type_member_declaration (timer_decl);

			var constructor = new CCodeFunction (prefix + "_init");
			constructor.modifiers = CCodeModifiers.STATIC | CCodeModifiers.CONSTRUCTOR;
			cfile.add_function_declaration (constructor);
			push_function (constructor);

			ccode.add_assignment (timer, new CCodeFunctionCall (new CCodeIdentifier ("g_timer_new")));

			var stop_call = new CCodeFunctionCall (new CCodeIdentifier ("g_timer_stop"));
			stop_call.add_argument (timer);
			ccode.add_expression (stop_call);

			pop_function ();
			cfile.add_function (constructor);


			var destructor = new CCodeFunction (prefix + "_exit");
			destructor.modifiers = CCodeModifiers.STATIC | CCodeModifiers.DESTRUCTOR;
			cfile.add_function_declaration (destructor);
			push_function (destructor);

			var elapsed_call = new CCodeFunctionCall (new CCodeIdentifier ("g_timer_elapsed"));
			elapsed_call.add_argument (timer);
			elapsed_call.add_argument (new CCodeConstant ("NULL"));

			var print_call = new CCodeFunctionCall (new CCodeIdentifier ("fprintf"));
			print_call.add_argument (new CCodeIdentifier ("stderr"));
			print_call.add_argument (new CCodeConstant ("\"%s: %%gs (%%d calls)\\n\"".printf (m.get_full_name ())));
			print_call.add_argument (elapsed_call);
			print_call.add_argument (counter);
			ccode.add_expression (print_call);

			pop_function ();
			cfile.add_function (destructor);
		}

		CCodeFunction function;
		function = new CCodeFunction (real_name);

		if (m.is_inline) {
			function.modifiers |= CCodeModifiers.INLINE;
		}

		var cparam_map = new HashMap<int,CCodeParameter> (direct_hash, direct_equal);

		generate_cparameters (m, cfile, cparam_map, function);

		// generate *_real_* functions for virtual methods
		// also generate them for abstract methods of classes to prevent faulty subclassing
		if (!m.is_abstract || (m.is_abstract && current_type_symbol is Class)) {
			if (!m.coroutine) {
				if (m.base_method != null || m.base_interface_method != null) {
					// declare *_real_* function
					function.modifiers |= CCodeModifiers.STATIC;
					cfile.add_function_declaration (function);
				} else if (m.is_private_symbol ()) {
					function.modifiers |= CCodeModifiers.STATIC;
				} else if (context.hide_internal && m.is_internal_symbol ()) {
					function.modifiers |= CCodeModifiers.INTERNAL;
				}
			} else {
				if (m.body != null) {
					function = new CCodeFunction (real_name + "_co", get_ccode_name (bool_type));

					// data struct to hold parameters, local variables, and the return value
					function.add_parameter (new CCodeParameter ("_data_", Symbol.lower_case_to_camel_case (get_ccode_const_name (m)) + "Data*"));
					function.modifiers |= CCodeModifiers.STATIC;
					cfile.add_function_declaration (function);
				}
			}
		}

		if (m.comment != null) {
			cfile.add_type_member_definition (new CCodeComment (m.comment.content));
		}

		push_function (function);

		unowned CCodeBlock? co_switch_block = null;

		// generate *_real_* functions for virtual methods
		// also generate them for abstract methods of classes to prevent faulty subclassing
		if (!m.is_abstract || (m.is_abstract && current_type_symbol is Class)) {
			if (m.body != null) {
				if (m.coroutine) {
					ccode.open_switch (new CCodeMemberAccess.pointer (new CCodeIdentifier ("_data_"), "_state_"));

					// initial coroutine state
					ccode.add_case (new CCodeConstant ("0"));
					ccode.add_goto ("_state_0");

					co_switch_block = ccode.current_block;

					ccode.close ();

					// coroutine body
					ccode.add_label ("_state_0");
				}

				if (m.closure) {
					// add variables for parent closure blocks
					// as closures only have one parameter for the innermost closure block
					var closure_block = current_closure_block;
					int block_id = get_block_id (closure_block);
					while (true) {
						var parent_closure_block = next_closure_block (closure_block.parent_symbol);
						if (parent_closure_block == null) {
							break;
						}
						int parent_block_id = get_block_id (parent_closure_block);

						var parent_data = new CCodeMemberAccess.pointer (new CCodeIdentifier ("_data%d_".printf (block_id)), "_data%d_".printf (parent_block_id));
						ccode.add_declaration ("Block%dData*".printf (parent_block_id), new CCodeVariableDeclarator ("_data%d_".printf (parent_block_id)));
						ccode.add_assignment (new CCodeIdentifier ("_data%d_".printf (parent_block_id)), parent_data);

						closure_block = parent_closure_block;
						block_id = parent_block_id;
					}

					// add self variable for closures
					// as closures have block data parameter
					if (m.binding == MemberBinding.INSTANCE) {
						var cself = new CCodeMemberAccess.pointer (new CCodeIdentifier ("_data%d_".printf (block_id)), "self");
						ccode.add_declaration (get_ccode_name (SemanticAnalyzer.get_data_type_for_symbol (current_type_symbol)), new CCodeVariableDeclarator ("self"));
						ccode.add_assignment (new CCodeIdentifier ("self"), cself);
					}

					// allow capturing generic type parameters
					foreach (var type_param in m.get_type_parameters ()) {
						string func_name;

						func_name = "%s_type".printf (type_param.name.down ());
						ccode.add_declaration ("GType", new CCodeVariableDeclarator (func_name));
						ccode.add_assignment (new CCodeIdentifier (func_name), new CCodeMemberAccess.pointer (get_variable_cexpression ("_data%d_".printf (block_id)), func_name));

						func_name = "%s_dup_func".printf (type_param.name.down ());
						ccode.add_declaration ("GBoxedCopyFunc", new CCodeVariableDeclarator (func_name));
						ccode.add_assignment (new CCodeIdentifier (func_name), new CCodeMemberAccess.pointer (get_variable_cexpression ("_data%d_".printf (block_id)), func_name));

						func_name = "%s_destroy_func".printf (type_param.name.down ());
						ccode.add_declaration ("GDestroyNotify", new CCodeVariableDeclarator (func_name));
						ccode.add_assignment (new CCodeIdentifier (func_name), new CCodeMemberAccess.pointer (get_variable_cexpression ("_data%d_".printf (block_id)), func_name));
					}
				} else if (m.parent_symbol is Class && !m.coroutine) {
					var cl = (Class) m.parent_symbol;
					if (m.overrides || (m.base_interface_method != null && !m.is_abstract && !m.is_virtual)) {
						Method base_method;
						ReferenceType base_expression_type;
						if (m.overrides && m.base_method != null) {
							base_method = m.base_method;
							base_expression_type = new ObjectType ((Class) base_method.parent_symbol);
						} else {
							base_method = m.base_interface_method;
							base_expression_type = new ObjectType ((Interface) base_method.parent_symbol);
						}
						var self_target_type = new ObjectType (cl);
						CCodeExpression cself = get_cvalue_ (transform_value (new GLibValue (base_expression_type, new CCodeIdentifier ("base"), true), self_target_type, m));

						ccode.add_declaration ("%s *".printf (get_ccode_name (cl)), new CCodeVariableDeclarator ("self"));
						ccode.add_assignment (new CCodeIdentifier ("self"), cself);
					} else if (m.binding == MemberBinding.INSTANCE
							   && !(m is CreationMethod)
							   && m.base_method == null && m.base_interface_method == null) {
						create_method_type_check_statement (m, creturn_type, cl, true, "self");
					}
				}

				foreach (Parameter param in m.get_parameters ()) {
					if (param.ellipsis || param.params_array) {
						if (param.params_array) {
							append_params_array (m.params_array_var);
						}
						break;
					}

					if (param.direction != ParameterDirection.OUT) {
						unowned TypeSymbol? t = param.variable_type.type_symbol;
						if (t != null && (t.is_reference_type () || param.variable_type.is_real_struct_type ())) {
							var cname = get_ccode_name (param);
							if (param.direction == ParameterDirection.REF && !param.variable_type.is_real_struct_type ()) {
								cname = "*"+cname;
							}
							create_method_type_check_statement (m, creturn_type, t, !param.variable_type.nullable, cname);
						}
					} else if (!m.coroutine) {
						// declare local variable for out parameter to allow assignment even when caller passes NULL
						var vardecl = new CCodeVariableDeclarator.zero ("_vala_%s".printf (get_ccode_name (param)), default_value_for_type (param.variable_type, true), get_ccode_declarator_suffix (param.variable_type));
						ccode.add_declaration (get_ccode_name (param.variable_type), vardecl);

						if (param.variable_type is ArrayType) {
							// create variables to store array dimensions
							var array_type = (ArrayType) param.variable_type;

							if (!array_type.fixed_length) {
								var length_ctype = get_ccode_array_length_type (param);
								for (int dim = 1; dim <= array_type.rank; dim++) {
									vardecl = new CCodeVariableDeclarator.zero (get_array_length_cname ("_vala_%s".printf (get_ccode_name (param)), dim), new CCodeConstant ("0"));
									ccode.add_declaration (length_ctype, vardecl);
								}
							}
						} else if (param.variable_type is DelegateType) {
							var deleg_type = (DelegateType) param.variable_type;
							if (deleg_type.delegate_symbol.has_target) {
								// create variable to store delegate target
								vardecl = new CCodeVariableDeclarator.zero ("_vala_%s".printf (get_ccode_delegate_target_name (param)), new CCodeConstant ("NULL"));
								ccode.add_declaration (get_ccode_name (delegate_target_type), vardecl);

								if (deleg_type.is_disposable ()) {
									vardecl = new CCodeVariableDeclarator.zero ("_vala_%s".printf (get_ccode_delegate_target_destroy_notify_name (param)), new CCodeConstant ("NULL"));
									ccode.add_declaration (get_ccode_name (delegate_target_destroy_type), vardecl);
								}
							}
						}
					}
				}

				if (m is CreationMethod) {
					if (in_gobject_creation_method) {
						if (!m.coroutine) {
							ccode.add_declaration ("%s *".printf (get_ccode_name (current_type_symbol)), new CCodeVariableDeclarator.zero ("self", new CCodeConstant ("NULL")));
						}
					} else if (is_gtypeinstance_creation_method (m)) {
						var cl = (Class) m.parent_symbol;
						ccode.add_declaration (get_ccode_name (cl) + "*", new CCodeVariableDeclarator.zero ("self", new CCodeConstant ("NULL")));

						if (cl.is_fundamental () && !((CreationMethod) m).chain_up) {
							var ccall = new CCodeFunctionCall (new CCodeIdentifier ("g_type_create_instance"));
							ccall.add_argument (get_variable_cexpression ("object_type"));
							ccode.add_assignment (get_this_cexpression (), new CCodeCastExpression (ccall, get_ccode_name (cl) + "*"));

							/* type, dup func, and destroy func fields for generic types */
							foreach (TypeParameter type_param in current_class.get_type_parameters ()) {
								CCodeIdentifier param_name;
								CCodeAssignment assign;

								var priv_access = new CCodeMemberAccess.pointer (new CCodeIdentifier ("self"), "priv");

								param_name = new CCodeIdentifier ("%s_type".printf (type_param.name.down ()));
								assign = new CCodeAssignment (new CCodeMemberAccess.pointer (priv_access, param_name.name), param_name);
								ccode.add_expression (assign);

								param_name = new CCodeIdentifier ("%s_dup_func".printf (type_param.name.down ()));
								assign = new CCodeAssignment (new CCodeMemberAccess.pointer (priv_access, param_name.name), param_name);
								ccode.add_expression (assign);

								param_name = new CCodeIdentifier ("%s_destroy_func".printf (type_param.name.down ()));
								assign = new CCodeAssignment (new CCodeMemberAccess.pointer (priv_access, param_name.name), param_name);
								ccode.add_expression (assign);
							}
						}
					} else if (current_type_symbol is Class) {
						var cl = (Class) m.parent_symbol;
						if (!m.coroutine) {
							ccode.add_declaration (get_ccode_name (cl) + "*", new CCodeVariableDeclarator ("self"));
						}

						if (!((CreationMethod) m).chain_up) {
							// TODO implicitly chain up to base class as in add_object_creation
							// g_slice_new0 needs glib.h
							cfile.add_include ("glib.h");
							var ccall = new CCodeFunctionCall (new CCodeIdentifier ("g_slice_new0"));
							ccall.add_argument (new CCodeIdentifier (get_ccode_name (cl)));
							ccode.add_assignment (get_this_cexpression (), ccall);
						}

						if (cl.base_class == null) {
							var cinitcall = new CCodeFunctionCall (new CCodeIdentifier ("%s_instance_init".printf (get_ccode_lower_case_name (cl, null))));
							cinitcall.add_argument (get_this_cexpression ());
							if (!cl.is_compact) {
								cinitcall.add_argument (new CCodeConstant ("NULL"));
							}
							ccode.add_expression (cinitcall);
						}
					} else {
						var st = (Struct) m.parent_symbol;

						// memset needs string.h
						cfile.add_include ("string.h");
						var czero = new CCodeFunctionCall (new CCodeIdentifier ("memset"));
						czero.add_argument (new CCodeIdentifier ("self"));
						czero.add_argument (new CCodeConstant ("0"));
						czero.add_argument (new CCodeIdentifier ("sizeof (%s)".printf (get_ccode_name (st))));
						ccode.add_expression (czero);
					}
				}

				if (context.module_init_method == m && in_plugin) {
					// GTypeModule-based plug-in, register types
					register_plugin_types (context.root, new HashSet<Symbol> ());
				}

				foreach (Expression precondition in m.get_preconditions ()) {
					create_precondition_statement (m, creturn_type, precondition);
				}
			}
		}

		if (profile) {
			string prefix = "_vala_prof_%s".printf (real_name);

			var level = new CCodeIdentifier (prefix + "_level");
			ccode.open_if (new CCodeUnaryExpression (CCodeUnaryOperator.LOGICAL_NEGATION, new CCodeUnaryExpression (CCodeUnaryOperator.POSTFIX_INCREMENT, level)));

			var counter = new CCodeIdentifier (prefix + "_counter");
			ccode.add_expression (new CCodeUnaryExpression (CCodeUnaryOperator.POSTFIX_INCREMENT, counter));

			var timer = new CCodeIdentifier (prefix + "_timer");
			var cont_call = new CCodeFunctionCall (new CCodeIdentifier ("g_timer_continue"));
			cont_call.add_argument (timer);
			ccode.add_expression (cont_call);

			ccode.close ();
		}

		if (m.body != null) {
			m.body.emit (this);

			if (co_switch_block != null) {
				// after counting the number of yields for coroutines, append the case statements to the switch
				var old_block = ccode.current_block;
				ccode.current_block = co_switch_block;

				for (int state = 1; state < emit_context.next_coroutine_state; state++) {
					ccode.add_case (new CCodeConstant (state.to_string ()));
					ccode.add_goto ("_state_%d".printf (state));
				}

				// let gcc know that this can't happen
				ccode.add_default ();
				ccode.add_expression (new CCodeFunctionCall (new CCodeIdentifier ("g_assert_not_reached")));

				ccode.current_block = old_block;
				co_switch_block = null;
			}
		}

		// we generate the same code if we see a return statement, this handles the case without returns
		if (profile && m.return_type is VoidType) {
			string prefix = "_vala_prof_%s".printf (real_name);

			var level = new CCodeIdentifier (prefix + "_level");
			ccode.open_if (new CCodeUnaryExpression (CCodeUnaryOperator.LOGICAL_NEGATION, new CCodeUnaryExpression (CCodeUnaryOperator.PREFIX_DECREMENT, level)));

			var timer = new CCodeIdentifier (prefix + "_timer");

			var stop_call = new CCodeFunctionCall (new CCodeIdentifier ("g_timer_stop"));
			stop_call.add_argument (timer);
			ccode.add_expression (stop_call);

			ccode.close ();
		}

		// generate *_real_* functions for virtual methods
		// also generate them for abstract methods of classes to prevent faulty subclassing
		if (!m.is_abstract || (m.is_abstract && current_type_symbol is Class)) {
			/* Methods imported from a plain C file don't
			 * have a body, e.g. Vala.Parser.parse_file () */
			if (m.body != null) {
				if (current_method_inner_error) {
					cfile.add_include ("glib.h");
					/* always separate error parameter and inner_error local variable
					 * as error may be set to NULL but we're always interested in inner errors
					 */
					if (m.coroutine) {
						// no initialization necessary, closure struct is zeroed
						closure_struct.add_field ("GError*", "_inner_error%d_".printf (current_inner_error_id));
					} else {
						ccode.add_declaration ("GError*", new CCodeVariableDeclarator.zero ("_inner_error%d_".printf (current_inner_error_id), new CCodeConstant ("NULL")));
					}
				}

				// For non-void return-types GAsyncModule.visit_return_statement () will take care of this
				if (m.return_type is VoidType && m.coroutine) {
					// epilogue
					complete_async ();
				}

				if (m is CreationMethod) {
					if (current_type_symbol is Class && !m.coroutine) {
						CCodeExpression cresult = new CCodeIdentifier ("self");
						if (get_ccode_type (m) != null) {
							cresult = new CCodeCastExpression (cresult, get_ccode_type (m));
						}

						ccode.add_return (cresult);
					}
				}

				cfile.add_function (ccode);
			}
		}

		if (m.is_abstract && current_type_symbol is Class) {
			// generate helpful error message if a sublcass does not implement an abstract method.
			// This is only meaningful for subclasses implemented in C since the vala compiler would
			// complain during compile time of such en error.

			// add critical warning that this method should not have been called
			var cerrorcall = new CCodeFunctionCall (new CCodeIdentifier ("g_critical"));
			if (!((Class) current_type_symbol).is_compact) {
				var type_from_instance_call = new CCodeFunctionCall (new CCodeIdentifier ("G_TYPE_FROM_INSTANCE"));
				type_from_instance_call.add_argument (new CCodeIdentifier ("self"));

				var type_name_call = new CCodeFunctionCall (new CCodeIdentifier ("g_type_name"));
				type_name_call.add_argument (type_from_instance_call);

				cerrorcall.add_argument (new CCodeConstant ("\"Type `%%s' does not implement abstract method `%s'\"".printf (get_ccode_name (m))));
				cerrorcall.add_argument (type_name_call);
			} else {
				cerrorcall.add_argument (new CCodeConstant ("\"Abstract method `%s' is not implemented\"".printf (get_ccode_name (m))));
			}

			ccode.add_expression (cerrorcall);

			// add return statement
			return_default_value (creturn_type);

			cfile.add_function (ccode);
		}

		if (current_method_return && !(m.return_type is VoidType) && !m.return_type.is_real_non_null_struct_type () && !m.coroutine) {
			var vardecl = new CCodeVariableDeclarator ("result", default_value_for_type (m.return_type, true));
			vardecl.init0 = true;
			ccode.add_declaration (get_ccode_name (m.return_type), vardecl);
		}

		pop_context ();

		if ((m.is_abstract || m.is_virtual) && !m.coroutine &&
		/* If the method is a signal handler, the declaration
		 * is not needed. -- the name should be reserved for the
		 * emitter! */
			    m.signal_reference == null) {

			cparam_map = new HashMap<int,CCodeParameter> (direct_hash, direct_equal);
			var carg_map = new HashMap<int,CCodeExpression> (direct_hash, direct_equal);

			generate_vfunc (m, creturn_type, cparam_map, carg_map);
		}

		if (m.entry_point) {
			// m is possible entry point, add appropriate startup code
			var cmain = new CCodeFunction ("main", "int");
			cmain.line = function.line;
			cmain.add_parameter (new CCodeParameter ("argc", "int"));
			cmain.add_parameter (new CCodeParameter ("argv", "char **"));
			push_function (cmain);

			if (context.profile == Profile.GOBJECT) {
				if (context.mem_profiler) {
					var mem_profiler_init_call = new CCodeFunctionCall (new CCodeIdentifier ("g_mem_set_vtable"));
					mem_profiler_init_call.line = cmain.line;
					mem_profiler_init_call.add_argument (new CCodeConstant ("glib_mem_profiler_table"));
					ccode.add_expression (mem_profiler_init_call);
				}
			}

			var main_call = new CCodeFunctionCall (new CCodeIdentifier (function.name));
			if (m.get_parameters ().size == 1) {
				main_call.add_argument (new CCodeIdentifier ("argv"));
				main_call.add_argument (new CCodeIdentifier ("argc"));
			}
			if (m.return_type is VoidType) {
				// method returns void, always use 0 as exit code
				ccode.add_expression (main_call);
				ccode.add_return (new CCodeConstant ("0"));
			} else {
				ccode.add_return (main_call);
			}
			pop_function ();
			cfile.add_function (cmain);
		}

		pop_line ();
	}

	public virtual CCodeParameter generate_parameter (Parameter param, CCodeFile decl_space, Map<int,CCodeParameter> cparam_map, Map<int,CCodeExpression>? carg_map) {
		CCodeParameter cparam;
		if (!param.ellipsis && !param.params_array) {
			string ctypename = get_ccode_name (param.variable_type);

			generate_type_declaration (param.variable_type, decl_space);

			// pass non-simple structs always by reference
			unowned Struct? st = param.variable_type.type_symbol as Struct;
			if (st != null) {
				if (!st.is_simple_type () && param.direction == ParameterDirection.IN) {
					if (st.is_immutable && !param.variable_type.value_owned) {
						ctypename = "const " + ctypename;
					}

					if (!param.variable_type.nullable) {
						ctypename += "*";
					}
				}
			}

			if (param.direction != ParameterDirection.IN) {
				ctypename += "*";
			}

			cparam = new CCodeParameter (get_ccode_name (param), ctypename);
			if (param.format_arg) {
				cparam.modifiers = CCodeModifiers.FORMAT_ARG;
			}
		} else {
			// Add _first_* parameter for the params array parameter
			if (param.params_array) {
				var param_type = ((ArrayType) param.variable_type).element_type;
				string ctypename = get_ccode_name (param_type);

				generate_type_declaration (param_type, decl_space);

				// pass non-simple structs always by reference
				if (param_type.type_symbol is Struct) {
					var st = (Struct) param_type.type_symbol;
					if (!st.is_simple_type () && param.direction == ParameterDirection.IN) {
						if (st.is_immutable && !param.variable_type.value_owned) {
							ctypename = "const " + ctypename;
						}

						if (!param_type.nullable) {
							ctypename += "*";
						}
					}
				}

				cparam = new CCodeParameter ("_first_%s".printf (get_ccode_name (param)), ctypename);
				cparam_map.set (get_param_pos (get_ccode_pos (param), false), cparam);
			}

			if (ellipses_to_valist) {
				cparam = new CCodeParameter ("_vala_va_list", "va_list");
			} else {
				cparam = new CCodeParameter.with_ellipsis ();
			}
		}

		cparam_map.set (get_param_pos (get_ccode_pos (param), param.ellipsis || param.params_array), cparam);
		if (carg_map != null && !param.ellipsis && !param.params_array) {
			carg_map.set (get_param_pos (get_ccode_pos (param), param.ellipsis || param.params_array), get_parameter_cexpression (param));
		}

		return cparam;
	}

	public override void generate_cparameters (Method m, CCodeFile decl_space, Map<int,CCodeParameter> cparam_map, CCodeFunction func, CCodeFunctionDeclarator? vdeclarator = null, Map<int,CCodeExpression>? carg_map = null, CCodeFunctionCall? vcall = null, int direction = 3) {
		if (m.closure) {
			var closure_block = current_closure_block;
			int block_id = get_block_id (closure_block);
			var instance_param = new CCodeParameter ("_data%d_".printf (block_id), "Block%dData*".printf (block_id));
			cparam_map.set (get_param_pos (get_ccode_instance_pos (m)), instance_param);
		} else if (m.parent_symbol is Class && m is CreationMethod) {
			var cl = (Class) m.parent_symbol;
			if (!cl.is_compact && vcall == null && (direction & 1) == 1) {
				cparam_map.set (get_param_pos (get_ccode_instance_pos (m)), new CCodeParameter ("object_type", "GType"));
			}
		} else if (m.binding == MemberBinding.INSTANCE && (direction != 2 || get_ccode_finish_instance (m))) {
			var this_type = SemanticAnalyzer.get_this_type (m);

			generate_type_declaration (this_type, decl_space);

			CCodeParameter instance_param = null;
			if (m.base_interface_method != null && !m.is_abstract && !m.is_virtual) {
				var base_type = new ObjectType ((Interface) m.base_interface_method.parent_symbol);
				instance_param = new CCodeParameter ("base", get_ccode_name (base_type));
			} else if (m.overrides) {
				var base_type = new ObjectType ((Class) m.base_method.parent_symbol);
				instance_param = new CCodeParameter ("base", get_ccode_name (base_type));
			} else {
				if (m.parent_symbol is Struct && !((Struct) m.parent_symbol).is_simple_type ()) {
					instance_param = new CCodeParameter ("*self", get_ccode_name (this_type));
				} else {
					instance_param = new CCodeParameter ("self", get_ccode_name (this_type));
				}
			}
			cparam_map.set (get_param_pos (get_ccode_instance_pos (m)), instance_param);
		} else if (m.binding == MemberBinding.CLASS) {
			var this_type = SemanticAnalyzer.get_this_type (m);
			var class_param = new CCodeParameter ("klass", get_ccode_name (this_type));
			cparam_map.set (get_param_pos (get_ccode_instance_pos (m)), class_param);
		}

		if (is_gtypeinstance_creation_method (m)) {
			// memory management for generic types
			int type_param_index = 0;
			var cl = (Class) m.parent_symbol;
			foreach (TypeParameter type_param in cl.get_type_parameters ()) {
				cparam_map.set (get_param_pos (0.1 * type_param_index + 0.01), new CCodeParameter ("%s_type".printf (type_param.name.down ()), "GType"));
				cparam_map.set (get_param_pos (0.1 * type_param_index + 0.02), new CCodeParameter ("%s_dup_func".printf (type_param.name.down ()), "GBoxedCopyFunc"));
				cparam_map.set (get_param_pos (0.1 * type_param_index + 0.03), new CCodeParameter ("%s_destroy_func".printf (type_param.name.down ()), "GDestroyNotify"));
				if (carg_map != null) {
					carg_map.set (get_param_pos (0.1 * type_param_index + 0.01), new CCodeIdentifier ("%s_type".printf (type_param.name.down ())));
					carg_map.set (get_param_pos (0.1 * type_param_index + 0.02), new CCodeIdentifier ("%s_dup_func".printf (type_param.name.down ())));
					carg_map.set (get_param_pos (0.1 * type_param_index + 0.03), new CCodeIdentifier ("%s_destroy_func".printf (type_param.name.down ())));
				}
				type_param_index++;
			}
		} else if (!m.closure && (direction & 1) == 1) {
			int type_param_index = 0;
			foreach (var type_param in m.get_type_parameters ()) {
				cparam_map.set (get_param_pos (0.1 * type_param_index + 0.01), new CCodeParameter ("%s_type".printf (type_param.name.down ()), "GType"));
				cparam_map.set (get_param_pos (0.1 * type_param_index + 0.02), new CCodeParameter ("%s_dup_func".printf (type_param.name.down ()), "GBoxedCopyFunc"));
				cparam_map.set (get_param_pos (0.1 * type_param_index + 0.03), new CCodeParameter ("%s_destroy_func".printf (type_param.name.down ()), "GDestroyNotify"));
				if (carg_map != null) {
					carg_map.set (get_param_pos (0.1 * type_param_index + 0.01), new CCodeIdentifier ("%s_type".printf (type_param.name.down ())));
					carg_map.set (get_param_pos (0.1 * type_param_index + 0.02), new CCodeIdentifier ("%s_dup_func".printf (type_param.name.down ())));
					carg_map.set (get_param_pos (0.1 * type_param_index + 0.03), new CCodeIdentifier ("%s_destroy_func".printf (type_param.name.down ())));
				}
				type_param_index++;
			}
		}

		var needs_format_arg = m.get_format_arg_index () < 0 && (m.printf_format || m.scanf_format);

		CCodeParameter? prev_cparam = null;
		foreach (Parameter param in m.get_parameters ()) {
			if (param.direction != ParameterDirection.OUT) {
				if ((direction & 1) == 0) {
					// no in parameters
					continue;
				}
			} else {
				if ((direction & 2) == 0) {
					// no out parameters
					continue;
				}
			}

			var cparam = generate_parameter (param, decl_space, cparam_map, carg_map);

			// if there is no explicit FormatArg annotation while this method throws an error
			// it is required to mark the parameter located right before ellipsis as format-arg
			// to account for the parameter shifting caused by the inserted GError parameter
			if (needs_format_arg) {
				if (prev_cparam != null && cparam.ellipsis) {
					prev_cparam.modifiers |= CCodeModifiers.FORMAT_ARG;
				}
				prev_cparam = cparam;
			}
		}

		if ((direction & 2) != 0) {
			generate_method_result_declaration (m, decl_space, func, cparam_map, carg_map);
		}

		// append C parameters in the right order
		int last_pos = -1;
		int min_pos;
		while (true) {
			min_pos = -1;
			foreach (int pos in cparam_map.get_keys ()) {
				if (pos > last_pos && (min_pos == -1 || pos < min_pos)) {
					min_pos = pos;
				}
			}
			if (min_pos == -1) {
				break;
			}
			func.add_parameter (cparam_map.get (min_pos));
			if (vdeclarator != null) {
				vdeclarator.add_parameter (cparam_map.get (min_pos));
			}
			if (vcall != null) {
				var arg = carg_map.get (min_pos);
				if (arg != null) {
					vcall.add_argument (arg);
				}
			}
			last_pos = min_pos;
		}

		if (m.printf_format) {
			func.modifiers |= CCodeModifiers.PRINTF;
		} else if (m.scanf_format) {
			func.modifiers |= CCodeModifiers.SCANF;
		}

		if (m.version.deprecated) {
			func.modifiers |= CCodeModifiers.DEPRECATED;
		}
	}

	public void generate_vfunc (Method m, DataType return_type, Map<int,CCodeParameter> cparam_map, Map<int,CCodeExpression> carg_map, string suffix = "", int direction = 3) {
		push_context (new EmitContext ());

		CCodeFunction vfunc;
		if (suffix == "_finish") {
			vfunc = new CCodeFunction (get_ccode_finish_name (m));
		} else {
			vfunc = new CCodeFunction (get_ccode_name (m));
		}

		CCodeExpression vcast;
		if (m.parent_symbol is Interface) {
			var iface = (Interface) m.parent_symbol;

			vcast = new CCodeFunctionCall (new CCodeIdentifier (get_ccode_interface_get_function (iface)));
			((CCodeFunctionCall) vcast).add_argument (new CCodeIdentifier ("self"));
		} else {
			var cl = (Class) m.parent_symbol;
			if (!cl.is_compact) {
				vcast = new CCodeFunctionCall (new CCodeIdentifier (get_ccode_class_get_function (cl)));
				((CCodeFunctionCall) vcast).add_argument (new CCodeIdentifier ("self"));
			} else {
				vcast = new CCodeIdentifier ("self");
			}
		}

		CCodeFunctionCall vcall;
		if (suffix == "_finish") {
			vcall = new CCodeFunctionCall (new CCodeMemberAccess.pointer (vcast, get_ccode_finish_vfunc_name (m)));
		} else {
			vcall = new CCodeFunctionCall (new CCodeMemberAccess.pointer (vcast, get_ccode_vfunc_name (m)));
		}

		carg_map.set (get_param_pos (get_ccode_instance_pos (m)), new CCodeIdentifier ("self"));

		generate_cparameters (m, cfile, cparam_map, vfunc, null, carg_map, vcall, direction);

		push_function (vfunc);

		if (context.assert && m.return_type.type_symbol is Struct && ((Struct) m.return_type.type_symbol).is_simple_type () && default_value_for_type (m.return_type, false) == null) {
			// the type check will use the result variable
			var vardecl = new CCodeVariableDeclarator ("result", default_value_for_type (m.return_type, true));
			vardecl.init0 = true;
			ccode.add_declaration (get_ccode_name (m.return_type), vardecl);
		}

		// add a typecheck statement for "self"
		create_method_type_check_statement (m, return_type, (TypeSymbol) m.parent_symbol, true, "self");

		foreach (Expression precondition in m.get_preconditions ()) {
			create_precondition_statement (m, return_type, precondition);
		}

		if (return_type is VoidType || return_type.is_real_non_null_struct_type ()) {
			ccode.add_expression (vcall);
		} else if (m.get_postconditions ().size == 0) {
			/* pass method return value */
			ccode.add_return (vcall);
		} else {
			/* store method return value for postconditions */
			ccode.add_declaration (get_creturn_type (m, get_ccode_name (return_type)), new CCodeVariableDeclarator ("result"));
			ccode.add_assignment (new CCodeIdentifier ("result"), vcall);
		}

		if (m.get_postconditions ().size > 0) {
			foreach (Expression postcondition in m.get_postconditions ()) {
				create_postcondition_statement (postcondition);
			}

			if (!(return_type is VoidType)) {
				ccode.add_return (new CCodeIdentifier ("result"));
			}
		}

		if (m.printf_format) {
			vfunc.modifiers |= CCodeModifiers.PRINTF;
		} else if (m.scanf_format) {
			vfunc.modifiers |= CCodeModifiers.SCANF;
		}

		if (m.version.deprecated) {
			vfunc.modifiers |= CCodeModifiers.DEPRECATED;
		}

		cfile.add_function (vfunc);

		pop_context ();
	}

	private void create_method_type_check_statement (Method m, DataType return_type, TypeSymbol t, bool non_null, string var_name) {
		if (!m.coroutine) {
			create_type_check_statement (m, return_type, t, non_null, var_name);
		}
	}

	private void create_precondition_statement (Method m, DataType ret_type, Expression precondition) {
		is_in_method_precondition = true;

		var ccheck = new CCodeFunctionCall ();

		precondition.emit (this);

		ccheck.add_argument (get_cvalue (precondition));

		string message = ((string) precondition.source_reference.begin.pos).substring (0, (int) (precondition.source_reference.end.pos - precondition.source_reference.begin.pos));
		ccheck.add_argument (new CCodeConstant ("\"%s\"".printf (message.replace ("\n", " ").escape (""))));
		requires_assert = true;

		if (m is CreationMethod) {
			if (m.parent_symbol is Class) {
				ccheck.call = new CCodeIdentifier ("_vala_return_val_if_fail");
				ccheck.add_argument (new CCodeConstant ("NULL"));
			} else {
				// creation method of struct
				ccheck.call = new CCodeIdentifier ("_vala_return_if_fail");
			}
		} else if (m.coroutine) {
			// _co function
			ccheck.call = new CCodeIdentifier ("_vala_return_val_if_fail");
			ccheck.add_argument (new CCodeConstant ("FALSE"));
		} else if (ret_type is VoidType) {
			/* void function */
			ccheck.call = new CCodeIdentifier ("_vala_return_if_fail");
		} else {
			ccheck.call = new CCodeIdentifier ("_vala_return_val_if_fail");

			var cdefault = default_value_for_type (ret_type, false);
			if (cdefault != null) {
				ccheck.add_argument (cdefault);
			} else {
				return;
			}
		}

		ccode.add_expression (ccheck);

		current_method_return = true;
		is_in_method_precondition = false;
	}

	public override void visit_creation_method (CreationMethod m) {
		push_line (m.source_reference);

		ellipses_to_valist = true;
		visit_method (m);
		ellipses_to_valist = false;

		if (m.source_type == SourceFileType.FAST) {
			pop_line ();
			return;
		}

		// do not generate _new functions for creation methods of abstract classes
		if (current_type_symbol is Class && !current_class.is_compact && !current_class.is_abstract) {
			// _new function
			create_aux_constructor (m, get_ccode_name (m), false);

			// _construct function (if visit_method generated _constructv)
			if (m.is_variadic ()) {
				create_aux_constructor (m, get_ccode_real_name (m), true);
			}
		}

		pop_line ();
	}

	private void create_aux_constructor (CreationMethod m, string func_name, bool self_as_first_parameter) {
		var vfunc = new CCodeFunction (func_name);
		if (m.is_private_symbol ()) {
			vfunc.modifiers |= CCodeModifiers.STATIC;
		} else if (context.hide_internal && m.is_internal_symbol ()) {
			vfunc.modifiers |= CCodeModifiers.INTERNAL;
		}

		var cparam_map = new HashMap<int,CCodeParameter> (direct_hash, direct_equal);
		var carg_map = new HashMap<int,CCodeExpression> (direct_hash, direct_equal);

		push_function (vfunc);

		string constructor = (m.is_variadic ()) ? get_ccode_constructv_name (m) : get_ccode_real_name (m);
		var vcall = new CCodeFunctionCall (new CCodeIdentifier (constructor));

		if (self_as_first_parameter) {
			cparam_map.set (get_param_pos (get_ccode_instance_pos (m)), new CCodeParameter ("object_type", "GType"));
			vcall.add_argument (get_variable_cexpression ("object_type"));
		} else {
			vcall.add_argument (new CCodeIdentifier (get_ccode_type_id (current_class)));
		}


		generate_cparameters (m, cfile, cparam_map, vfunc, null, carg_map, vcall);

		if (m.is_variadic ()) {
			int last_pos = -1;
			int second_last_pos = -1;
			foreach (int pos in cparam_map.get_keys ()) {
				if (pos > last_pos) {
					second_last_pos = last_pos;
					last_pos = pos;
				} else if (pos > second_last_pos) {
					second_last_pos = pos;
				}
			}

			var va_start = new CCodeFunctionCall (new CCodeIdentifier ("va_start"));
			va_start.add_argument (new CCodeIdentifier ("_vala_va_list_obj"));
			va_start.add_argument (carg_map.get (second_last_pos));

			ccode.add_declaration ("va_list", new CCodeVariableDeclarator ("_vala_va_list_obj"));
			ccode.add_expression (va_start);

			vcall.add_argument (new CCodeIdentifier("_vala_va_list_obj"));
		}

		ccode.add_return (vcall);

		pop_function ();

		cfile.add_function (vfunc);
	}
}

// vim:sw=8 noet
