/* valaccodedelegatemodule.vala
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


/**
 * The link between an assignment and generated code.
 */
public class Vala.CCodeDelegateModule : CCodeArrayModule {
	public override void generate_delegate_declaration (Delegate d, CCodeFile decl_space) {
		if (add_symbol_declaration (decl_space, d, get_ccode_name (d))) {
			return;
		}

		// internally generated delegates don't require a typedef
		if (d.sender_type != null) {
			return;
		}

		var creturn_type = get_callable_creturn_type (d);
		if (creturn_type is DelegateType && ((DelegateType) creturn_type).delegate_symbol == d) {
			// recursive delegate
			creturn_type = new DelegateType ((Delegate) context.root.scope.lookup ("GLib").scope.lookup ("Callback"));
		}

		generate_type_declaration (creturn_type, decl_space);

		var cparam_map = new HashMap<int,CCodeParameter> (direct_hash, direct_equal);

		var cfundecl = new CCodeFunctionDeclarator (get_ccode_name (d));
		foreach (Parameter param in d.get_parameters ()) {
			generate_parameter (param, decl_space, cparam_map, null);
		}

		// FIXME partial code duplication with CCodeMethodModule.generate_cparameters

		if (d.return_type.is_real_non_null_struct_type ()) {
			// structs are returned via out parameter
			var cparam = new CCodeParameter ("result", get_ccode_name (d.return_type) + "*");
			cparam_map.set (get_param_pos (-3), cparam);
		} else if (get_ccode_array_length (d) && d.return_type is ArrayType) {
			// return array length if appropriate
			var array_type = (ArrayType) d.return_type;
			var length_ctype = get_ccode_array_length_type (d) + "*";

			for (int dim = 1; dim <= array_type.rank; dim++) {
				var cparam = new CCodeParameter (get_array_length_cname ("result", dim), length_ctype);
				cparam_map.set (get_param_pos (get_ccode_array_length_pos (d) + 0.01 * dim), cparam);
			}
		} else if (get_ccode_delegate_target (d) && d.return_type is DelegateType) {
			// return delegate target if appropriate
			var deleg_type = (DelegateType) d.return_type;
			if (deleg_type.delegate_symbol.has_target) {
				generate_type_declaration (delegate_target_type, decl_space);
				var cparam = new CCodeParameter (get_delegate_target_cname ("result"), get_ccode_name (delegate_target_type) + "*");
				cparam_map.set (get_param_pos (get_ccode_delegate_target_pos (d)), cparam);
				if (deleg_type.is_disposable ()) {
					generate_type_declaration (delegate_target_destroy_type, decl_space);
					cparam = new CCodeParameter (get_delegate_target_destroy_notify_cname ("result"), get_ccode_name (delegate_target_destroy_type) + "*");
					cparam_map.set (get_param_pos (get_ccode_destroy_notify_pos (d)), cparam);
				}
			}
		}

		if (d.has_target) {
			generate_type_declaration (delegate_target_type, decl_space);
			var cparam = new CCodeParameter ("user_data", get_ccode_name (delegate_target_type));
			cparam_map.set (get_param_pos (get_ccode_instance_pos (d)), cparam);
		}
		if (d.tree_can_fail) {
			generate_type_declaration (gerror_type, decl_space);
			var cparam = new CCodeParameter ("error", "GError**");
			cparam_map.set (get_param_pos (get_ccode_error_pos (d)), cparam);
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
			cfundecl.add_parameter (cparam_map.get (min_pos));
			last_pos = min_pos;
		}

		var ctypedef = new CCodeTypeDefinition (get_ccode_name (creturn_type), cfundecl);

		if (d.version.deprecated) {
			if (context.profile == Profile.GOBJECT) {
				decl_space.add_include ("glib.h");
			}
			ctypedef.modifiers |= CCodeModifiers.DEPRECATED;
		}

		decl_space.add_type_declaration (ctypedef);
	}

	public override void visit_delegate (Delegate d) {
		generate_delegate_declaration (d, cfile);

		if (!d.is_internal_symbol ()) {
			generate_delegate_declaration (d, header_file);
		}
		if (!d.is_private_symbol ()) {
			generate_delegate_declaration (d, internal_header_file);
		}

		d.accept_children (this);
	}

	public override string get_delegate_target_cname (string delegate_cname) {
		return "%s_target".printf (delegate_cname);
	}

	public override CCodeExpression get_delegate_target_cexpression (Expression delegate_expr, out CCodeExpression delegate_target_destroy_notify) {
		delegate_target_destroy_notify = get_delegate_target_destroy_notify_cvalue (delegate_expr.target_value);
		return get_delegate_target_cvalue (delegate_expr.target_value);
	}

	public override CCodeExpression get_delegate_target_cvalue (TargetValue value) {
		return ((GLibValue) value).delegate_target_cvalue;
	}

	public override CCodeExpression get_delegate_target_destroy_notify_cvalue (TargetValue value) {
		return ((GLibValue) value).delegate_target_destroy_notify_cvalue;
	}

	public override string get_delegate_target_destroy_notify_cname (string delegate_cname) {
		return "%s_target_destroy_notify".printf (delegate_cname);
	}

	public override CCodeExpression get_implicit_cast_expression (CCodeExpression source_cexpr, DataType? expression_type, DataType? target_type, CodeNode? node) {
		if (target_type is DelegateType && expression_type is MethodType) {
			var dt = (DelegateType) target_type;
			var mt = (MethodType) expression_type;

			var method = mt.method_symbol;
			if (method.base_method != null) {
				method = method.base_method;
			} else if (method.base_interface_method != null) {
				method = method.base_interface_method;
			}

			return new CCodeIdentifier (generate_delegate_wrapper (method, dt, node));
		}

		return base.get_implicit_cast_expression (source_cexpr, expression_type, target_type, node);
	}

	public string generate_delegate_wrapper (Method m, DelegateType dt, CodeNode? node) {
		var d = dt.delegate_symbol;
		string delegate_name;
		var sig = d.parent_symbol as Signal;
		var dynamic_sig = sig as DynamicSignal;
		if (dynamic_sig != null) {
			delegate_name = get_dynamic_signal_cname (dynamic_sig);
		} else if (sig != null) {
			delegate_name = get_ccode_lower_case_prefix (sig.parent_symbol) + get_ccode_lower_case_name (sig);
		} else {
			delegate_name = Symbol.camel_case_to_lower_case (get_ccode_name (d));
		}

		string wrapper_name = "_%s_%s".printf (get_ccode_name (m), delegate_name);

		if (!add_wrapper (wrapper_name)) {
			// wrapper already defined
			return wrapper_name;
		}

		// declaration
		var creturn_type = get_callable_creturn_type (d);

		var function = new CCodeFunction (wrapper_name, get_ccode_name (creturn_type));
		function.modifiers = CCodeModifiers.STATIC;

		push_function (function);

		var cparam_map = new HashMap<int,CCodeParameter> (direct_hash, direct_equal);

		if (d.has_target) {
			var cparam = new CCodeParameter ("self", get_ccode_name (delegate_target_type));
			cparam_map.set (get_param_pos (get_ccode_instance_pos (d)), cparam);
		}

		if (d.sender_type != null) {
			var param = new Parameter ("_sender", d.sender_type);
			generate_parameter (param, cfile, cparam_map, null);
		}

		var d_params = d.get_parameters ();
		foreach (Parameter param in d_params) {
			if (dynamic_sig != null
			    && param.variable_type is ArrayType
			    && ((ArrayType) param.variable_type).element_type.type_symbol == string_type.type_symbol) {
				// use null-terminated string arrays for dynamic signals for compatibility reasons
				param.set_attribute_bool ("CCode", "array_length", false);
				param.set_attribute_bool ("CCode", "array_null_terminated", true);
			}

			generate_parameter (param, cfile, cparam_map, null);
		}
		if (get_ccode_array_length (d) && d.return_type is ArrayType) {
			// return array length if appropriate
			var array_type = (ArrayType) d.return_type;
			var length_ctype = get_ccode_array_length_type (d) + "*";

			for (int dim = 1; dim <= array_type.rank; dim++) {
				var cparam = new CCodeParameter (get_array_length_cname ("result", dim), length_ctype);
				cparam_map.set (get_param_pos (get_ccode_array_length_pos (d) + 0.01 * dim), cparam);
			}
		} else if (d.return_type is DelegateType) {
			// return delegate target if appropriate
			var deleg_type = (DelegateType) d.return_type;

			if (get_ccode_delegate_target (d) && deleg_type.delegate_symbol.has_target) {
				var cparam = new CCodeParameter (get_delegate_target_cname ("result"), get_ccode_name (delegate_target_type) + "*");
				cparam_map.set (get_param_pos (get_ccode_delegate_target_pos (d)), cparam);
				if (deleg_type.is_disposable ()) {
					cparam = new CCodeParameter (get_delegate_target_destroy_notify_cname ("result"), get_ccode_name (delegate_target_destroy_type) + "*");
					cparam_map.set (get_param_pos (get_ccode_destroy_notify_pos (d)), cparam);
				}
			}
		} else if (d.return_type.is_real_non_null_struct_type ()) {
			var cparam = new CCodeParameter ("result", "%s*".printf (get_ccode_name (d.return_type)));
			cparam_map.set (get_param_pos (-3), cparam);
		}

		if (m.tree_can_fail) {
			var cparam = new CCodeParameter ("error", "GError**");
			cparam_map.set (get_param_pos (get_ccode_error_pos (d)), cparam);
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
			function.add_parameter (cparam_map.get (min_pos));
			last_pos = min_pos;
		}


		// definition

		var carg_map = new HashMap<int,CCodeExpression> (direct_hash, direct_equal);

		int i = 0;
		if (m.binding == MemberBinding.INSTANCE || m.closure) {
			CCodeExpression arg;
			if (d.has_target) {
				arg = new CCodeIdentifier ("self");
				if (!m.closure && m.this_parameter != null) {
					arg = convert_from_generic_pointer (arg, m.this_parameter.variable_type);
				}
			} else {
				// use first delegate parameter as instance
				if (d_params.size == 0 || m.closure) {
					Report.error (node != null ? node.source_reference : null, "internal: Cannot create delegate wrapper");
					arg = new CCodeInvalidExpression ();
				} else {
					arg = new CCodeIdentifier (get_ccode_name (d_params.get (0)));
					i = 1;
				}
			}
			carg_map.set (get_param_pos (get_ccode_instance_pos (m)), arg);
		}

		bool first = true;

		foreach (Parameter param in m.get_parameters ()) {
			if (first && d.sender_type != null && m.get_parameters ().size == d.get_parameters ().size + 1) {
				// sender parameter
				carg_map.set (get_param_pos (get_ccode_pos (param)), new CCodeIdentifier ("_sender"));

				first = false;
				continue;
			}

			CCodeExpression arg;
			arg = new CCodeIdentifier (get_ccode_name (d_params.get (i)));
			if (d_params.get (i).variable_type is GenericType) {
				arg = convert_from_generic_pointer (arg, param.variable_type);
			}
			carg_map.set (get_param_pos (get_ccode_pos (param)), arg);

			// handle array arguments
			if (get_ccode_array_length (param) && param.variable_type is ArrayType) {
				var array_type = (ArrayType) param.variable_type;
				for (int dim = 1; dim <= array_type.rank; dim++) {
					CCodeExpression clength;
					if (get_ccode_array_null_terminated (d_params.get (i))) {
						requires_array_length = true;
						var len_call = new CCodeFunctionCall (new CCodeIdentifier ("_vala_array_length"));
						len_call.add_argument (new CCodeIdentifier (d_params.get (i).name));
						clength = len_call;
					} else if (!get_ccode_array_length (d_params.get (i))) {
						clength = new CCodeConstant ("-1");
					} else {
						clength = new CCodeIdentifier (get_variable_array_length_cname (d_params.get (i), dim));
					}
					carg_map.set (get_param_pos (get_ccode_array_length_pos (param) + 0.01 * dim), clength);
				}
			} else if (get_ccode_delegate_target (param) && param.variable_type is DelegateType) {
				var deleg_type = (DelegateType) param.variable_type;

				if (deleg_type.delegate_symbol.has_target) {
					var ctarget = new CCodeIdentifier (get_ccode_delegate_target_name (d_params.get (i)));
					carg_map.set (get_param_pos (get_ccode_delegate_target_pos (param)), ctarget);
					if (deleg_type.is_disposable ()) {
						var ctarget_destroy_notify = new CCodeIdentifier (get_ccode_delegate_target_destroy_notify_name (d_params.get (i)));
						carg_map.set (get_param_pos (get_ccode_destroy_notify_pos (m)), ctarget_destroy_notify);
					}
				}
			}

			i++;
		}
		if (get_ccode_array_length (m) && m.return_type is ArrayType) {
			var array_type = (ArrayType) m.return_type;
			for (int dim = 1; dim <= array_type.rank; dim++) {
				CCodeExpression clength;
				if (!get_ccode_array_length (d)) {
					clength = new CCodeConstant ("NULL");
				} else {
					clength = new CCodeIdentifier (get_array_length_cname ("result", dim));
				}
				carg_map.set (get_param_pos (get_ccode_array_length_pos (m) + 0.01 * dim), clength);
			}
		} else if (get_ccode_delegate_target (m) && m.return_type is DelegateType) {
			var deleg_type = (DelegateType) m.return_type;

			if (deleg_type.delegate_symbol.has_target) {
				var ctarget = new CCodeIdentifier (get_delegate_target_cname ("result"));
				carg_map.set (get_param_pos (get_ccode_delegate_target_pos (m)), ctarget);
				if (deleg_type.is_disposable ()) {
					var ctarget_destroy_notify = new CCodeIdentifier (get_delegate_target_destroy_notify_cname ("result"));
					carg_map.set (get_param_pos (get_ccode_destroy_notify_pos (m)), ctarget_destroy_notify);
				}
			}
		} else if (m.return_type.is_real_non_null_struct_type ()) {
			carg_map.set (get_param_pos (-3), new CCodeIdentifier ("result"));
		}

		if (m.tree_can_fail) {
			carg_map.set (get_param_pos (get_ccode_error_pos (m)), new CCodeIdentifier ("error"));
		}

		var ccall = new CCodeFunctionCall (new CCodeIdentifier (get_ccode_name (m)));

		// append C arguments in the right order
		last_pos = -1;
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

		if (m.coroutine) {
			ccall.add_argument (new CCodeConstant ("NULL"));
			ccall.add_argument (new CCodeConstant ("NULL"));
		}

		if (m.return_type is VoidType || m.return_type.is_real_non_null_struct_type ()) {
			ccode.add_expression (ccall);
			if (!(d.return_type is VoidType || d.return_type.is_real_non_null_struct_type ())) {
				// return a default value
				ccode.add_declaration (get_ccode_name (creturn_type), new CCodeVariableDeclarator ("result", default_value_for_type (d.return_type, true)));
			}
		} else {
			CCodeExpression result = ccall;
			if (d.return_type is GenericType) {
				result = convert_to_generic_pointer (result, m.return_type);
			}
			ccode.add_declaration (get_ccode_name (creturn_type), new CCodeVariableDeclarator ("result", result));
		}

		if (d.has_target /* TODO: && dt.value_owned */ && dt.is_called_once) {
			// destroy notify "self" after the call
			CCodeExpression? destroy_notify = null;
			if (m.closure) {
				int block_id = get_block_id (current_closure_block);
				destroy_notify = new CCodeIdentifier ("block%d_data_unref".printf (block_id));
			} else if (get_this_type () != null && m.binding != MemberBinding.STATIC && !m.is_async_callback && is_reference_counting (m.this_parameter.variable_type.type_symbol)) {
				destroy_notify = get_destroy_func_expression (m.this_parameter.variable_type);
			}

			if (destroy_notify != null) {
				var unref_call = new CCodeFunctionCall (destroy_notify);
				unref_call.add_argument (new CCodeIdentifier ("self"));
				ccode.add_expression (unref_call);
			}
		}

		if (!(m.return_type is VoidType || m.return_type.is_real_non_null_struct_type ()) ||
			!(d.return_type is VoidType || d.return_type.is_real_non_null_struct_type ())) {
			ccode.add_return (new CCodeIdentifier ("result"));
		}

		pop_function ();

		// append to file
		cfile.add_function_declaration (function);
		cfile.add_function (function);

		return wrapper_name;
	}

	public override CCodeParameter generate_parameter (Parameter param, CCodeFile decl_space, Map<int,CCodeParameter> cparam_map, Map<int,CCodeExpression>? carg_map) {
		if (!(param.variable_type is DelegateType || param.variable_type is MethodType)) {
			return base.generate_parameter (param, decl_space, cparam_map, carg_map);
		}

		var param_type = param.variable_type;
		if (param_type is DelegateType && ((DelegateType) param_type).delegate_symbol == param.parent_symbol) {
			// recursive delegate
			param_type = new DelegateType ((Delegate) context.root.scope.lookup ("GLib").scope.lookup ("Callback"));
		}

		generate_type_declaration (param_type, decl_space);

		string ctypename = get_ccode_name (param_type);
		string target_ctypename = get_ccode_name (delegate_target_type);
		string target_destroy_notify_ctypename = get_ccode_name (delegate_target_destroy_type);

		if (param.direction != ParameterDirection.IN) {
			ctypename += "*";
			target_ctypename += "*";
			target_destroy_notify_ctypename += "*";
		}

		var main_cparam = new CCodeParameter (get_ccode_name (param), ctypename);

		cparam_map.set (get_param_pos (get_ccode_pos (param)), main_cparam);
		if (carg_map != null) {
			carg_map.set (get_param_pos (get_ccode_pos (param)), get_parameter_cexpression (param));
		}

		if (param_type is DelegateType) {
			unowned DelegateType deleg_type = (DelegateType) param_type;
			if (get_ccode_delegate_target (param) && deleg_type.delegate_symbol.has_target) {
				var cparam = new CCodeParameter (get_ccode_delegate_target_name (param), target_ctypename);
				cparam_map.set (get_param_pos (get_ccode_delegate_target_pos (param)), cparam);
				if (carg_map != null) {
					carg_map.set (get_param_pos (get_ccode_delegate_target_pos (param)), get_cexpression (cparam.name));
				}
				if (deleg_type.is_disposable ()) {
					cparam = new CCodeParameter (get_ccode_delegate_target_destroy_notify_name (param), target_destroy_notify_ctypename);
					cparam_map.set (get_param_pos (get_ccode_destroy_notify_pos (param)), cparam);
					if (carg_map != null) {
						carg_map.set (get_param_pos (get_ccode_destroy_notify_pos (param)), get_cexpression (cparam.name));
					}
				}
			}
		} else if (param_type is MethodType) {
			var cparam = new CCodeParameter (get_ccode_delegate_target_name (param), target_ctypename);
			cparam_map.set (get_param_pos (get_ccode_delegate_target_pos (param)), cparam);
			if (carg_map != null) {
				carg_map.set (get_param_pos (get_ccode_delegate_target_pos (param)), get_cexpression (cparam.name));
			}
		}

		return main_cparam;
	}
}
