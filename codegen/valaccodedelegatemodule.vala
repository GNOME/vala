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

		string return_type_cname = get_ccode_name (d.return_type);

		if (d.return_type.is_real_non_null_struct_type ()) {
			// structs are returned via out parameter
			return_type_cname = "void";
		}

		if (return_type_cname == get_ccode_name (d)) {
			// recursive delegate
			return_type_cname = "GCallback";
		} else {
			generate_type_declaration (d.return_type, decl_space);
		}

		var cfundecl = new CCodeFunctionDeclarator (get_ccode_name (d));
		foreach (Parameter param in d.get_parameters ()) {
			var cparam = generate_parameter (param, decl_space, new HashMap<int,CCodeParameter> (), null);

			cfundecl.add_parameter (cparam);

			// handle array parameters
			if (get_ccode_array_length (param) && param.variable_type is ArrayType) {
				var array_type = (ArrayType) param.variable_type;
				
				var length_ctype = "int";
				if (param.direction != ParameterDirection.IN) {
					length_ctype = "int*";
				}
				
				for (int dim = 1; dim <= array_type.rank; dim++) {
					cparam = new CCodeParameter (get_parameter_array_length_cname (param, dim), length_ctype);
					cfundecl.add_parameter (cparam);
				}
			}
			// handle delegate parameters
			if (param.variable_type is DelegateType) {
				var deleg_type = (DelegateType) param.variable_type;
				var param_d = deleg_type.delegate_symbol;
				if (param_d.has_target) {
					cparam = new CCodeParameter (get_delegate_target_cname (get_variable_cname (param.name)), "void*");
					cfundecl.add_parameter (cparam);
					if (deleg_type.is_disposable ()) {
						cparam = new CCodeParameter (get_delegate_target_destroy_notify_cname (get_variable_cname (param.name)), "GDestroyNotify*");
						cfundecl.add_parameter (cparam);
					}
				}
			}
		}
		if (get_ccode_array_length (d) && d.return_type is ArrayType) {
			// return array length if appropriate
			var array_type = (ArrayType) d.return_type;
			var array_length_type = get_ccode_array_length_type (d) != null ? get_ccode_array_length_type (d) : "int";
			array_length_type += "*";

			for (int dim = 1; dim <= array_type.rank; dim++) {
				var cparam = new CCodeParameter (get_array_length_cname ("result", dim), array_length_type);
				cfundecl.add_parameter (cparam);
			}
		} else if (d.return_type is DelegateType) {
			// return delegate target if appropriate
			var deleg_type = (DelegateType) d.return_type;
			var result_d = deleg_type.delegate_symbol;
			if (result_d.has_target) {
				var cparam = new CCodeParameter (get_delegate_target_cname ("result"), "void**");
				cfundecl.add_parameter (cparam);
				if (deleg_type.is_disposable ()) {
					cparam = new CCodeParameter (get_delegate_target_destroy_notify_cname ("result"), "GDestroyNotify*");
					cfundecl.add_parameter (cparam);
				}
			}
		} else if (d.return_type.is_real_non_null_struct_type ()) {
			var cparam = new CCodeParameter ("result", "%s*".printf (get_ccode_name (d.return_type)));
			cfundecl.add_parameter (cparam);
		}
		if (d.has_target) {
			var cparam = new CCodeParameter ("user_data", "void*");
			cfundecl.add_parameter (cparam);
		}
		if (d.get_error_types ().size > 0) {
			var cparam = new CCodeParameter ("error", "GError**");
			cfundecl.add_parameter (cparam);
		}

		var ctypedef = new CCodeTypeDefinition (return_type_cname, cfundecl);
		ctypedef.deprecated = d.deprecated;

		decl_space.add_type_definition (ctypedef);
	}

	public override void visit_delegate (Delegate d) {
		d.accept_children (this);

		generate_delegate_declaration (d, cfile);

		if (!d.is_internal_symbol ()) {
			generate_delegate_declaration (d, header_file);
		}
		if (!d.is_private_symbol ()) {
			generate_delegate_declaration (d, internal_header_file);
		}
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
			delegate_name = get_ccode_lower_case_prefix (sig.parent_symbol) + get_ccode_name (sig);
		} else {
			delegate_name = Symbol.camel_case_to_lower_case (get_ccode_name (d));
		}

		string wrapper_name = "_%s_%s".printf (get_ccode_name (m), delegate_name);

		if (!add_wrapper (wrapper_name)) {
			// wrapper already defined
			return wrapper_name;
		}

		// declaration

		string return_type_cname = get_ccode_name (d.return_type);

		if (d.return_type.is_real_non_null_struct_type ()) {
			// structs are returned via out parameter
			return_type_cname = "void";
		}

		var function = new CCodeFunction (wrapper_name, return_type_cname);
		function.modifiers = CCodeModifiers.STATIC;

		push_function (function);

		var cparam_map = new HashMap<int,CCodeParameter> (direct_hash, direct_equal);

		if (d.has_target) {
			var cparam = new CCodeParameter ("self", "gpointer");
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
			    && ((ArrayType) param.variable_type).element_type.data_type == string_type.data_type) {
				// use null-terminated string arrays for dynamic signals for compatibility reasons
				param.set_attribute_bool ("CCode", "array_length", false);
				param.set_attribute_bool ("CCode", "array_null_terminated", true);
			}

			generate_parameter (param, cfile, cparam_map, null);
		}
		if (get_ccode_array_length (d) && d.return_type is ArrayType) {
			// return array length if appropriate
			var array_type = (ArrayType) d.return_type;
			var array_length_type = get_ccode_array_length_type (d) != null ? get_ccode_array_length_type (d) : "int";
			array_length_type += "*";

			for (int dim = 1; dim <= array_type.rank; dim++) {
				var cparam = new CCodeParameter (get_array_length_cname ("result", dim), array_length_type);
				cparam_map.set (get_param_pos (get_ccode_array_length_pos (d) + 0.01 * dim), cparam);
			}
		} else if (d.return_type is DelegateType) {
			// return delegate target if appropriate
			var deleg_type = (DelegateType) d.return_type;

			if (deleg_type.delegate_symbol.has_target) {
				var cparam = new CCodeParameter (get_delegate_target_cname ("result"), "void**");
				cparam_map.set (get_param_pos (get_ccode_delegate_target_pos (d)), cparam);
				if (deleg_type.is_disposable ()) {
					cparam = new CCodeParameter (get_delegate_target_destroy_notify_cname ("result"), "GDestroyNotify*");
					cparam_map.set (get_param_pos (get_ccode_delegate_target_pos (d) + 0.01), cparam);
				}
			}
		} else if (d.return_type.is_real_non_null_struct_type ()) {
			var cparam = new CCodeParameter ("result", "%s*".printf (get_ccode_name (d.return_type)));
			cparam_map.set (get_param_pos (-3), cparam);
		}

		if (m.get_error_types ().size > 0) {
			var cparam = new CCodeParameter ("error", "GError**");
			cparam_map.set (get_param_pos (-1), cparam);
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
			} else {
				// use first delegate parameter as instance
				if (d_params.size == 0 || m.closure) {
					Report.error (node != null ? node.source_reference : null, "Cannot create delegate without target for instance method or closure");
					arg = new CCodeConstant ("NULL");
				} else {
					arg = new CCodeIdentifier (get_variable_cname (d_params.get (0).name));
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
			arg = new CCodeIdentifier (get_variable_cname (d_params.get (i).name));
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
						clength = new CCodeIdentifier (get_parameter_array_length_cname (d_params.get (i), dim));
					}
					carg_map.set (get_param_pos (get_ccode_array_length_pos (param) + 0.01 * dim), clength);
				}
			} else if (param.variable_type is DelegateType) {
				var deleg_type = (DelegateType) param.variable_type;

				if (deleg_type.delegate_symbol.has_target) {
					var ctarget = new CCodeIdentifier (get_ccode_delegate_target_name (d_params.get (i)));
					carg_map.set (get_param_pos (get_ccode_delegate_target_pos (param)), ctarget);
					if (deleg_type.is_disposable ()) {
						var ctarget_destroy_notify = new CCodeIdentifier (get_delegate_target_destroy_notify_cname (d_params.get (i).name));
						carg_map.set (get_param_pos (get_ccode_delegate_target_pos (m) + 0.01), ctarget_destroy_notify);
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
		} else if (m.return_type is DelegateType) {
			var deleg_type = (DelegateType) m.return_type;

			if (deleg_type.delegate_symbol.has_target) {
				var ctarget = new CCodeIdentifier (get_delegate_target_cname ("result"));
				carg_map.set (get_param_pos (get_ccode_delegate_target_pos (m)), ctarget);
				if (deleg_type.is_disposable ()) {
					var ctarget_destroy_notify = new CCodeIdentifier (get_delegate_target_destroy_notify_cname ("result"));
					carg_map.set (get_param_pos (get_ccode_delegate_target_pos (m) + 0.01), ctarget_destroy_notify);
				}
			}
		} else if (m.return_type.is_real_non_null_struct_type ()) {
			carg_map.set (get_param_pos (-3), new CCodeIdentifier ("result"));
		}

		if (m.get_error_types ().size > 0) {
			carg_map.set (get_param_pos (-1), new CCodeIdentifier ("error"));
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
		} else {
			ccode.add_declaration (return_type_cname, new CCodeVariableDeclarator ("result", ccall));
		}

		if (d.has_target /* TODO: && dt.value_owned */ && dt.is_called_once) {
			// destroy notify "self" after the call
			CCodeExpression? destroy_notify = null;
			if (m.closure) {
				int block_id = get_block_id (current_closure_block);
				destroy_notify = new CCodeIdentifier ("block%d_data_unref".printf (block_id));
			} else if (get_this_type () != null && m.binding != MemberBinding.STATIC && !m.is_async_callback && is_reference_counting (m.this_parameter.variable_type.data_type)) {
				destroy_notify = get_destroy_func_expression (m.this_parameter.variable_type);
			}

			if (destroy_notify != null) {
				var unref_call = new CCodeFunctionCall (destroy_notify);
				unref_call.add_argument (new CCodeIdentifier ("self"));
				ccode.add_expression (unref_call);
			}
		}

		if (!(m.return_type is VoidType || m.return_type.is_real_non_null_struct_type ())) {
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

		string ctypename = get_ccode_name (param.variable_type);
		string target_ctypename = "void*";
		string target_destroy_notify_ctypename = "GDestroyNotify";

		if (param.parent_symbol is Delegate
		    && get_ccode_name (param.variable_type) == get_ccode_name (param.parent_symbol)) {
			// recursive delegate
			ctypename = "GCallback";
		}

		if (param.direction != ParameterDirection.IN) {
			ctypename += "*";
			target_ctypename += "*";
			target_destroy_notify_ctypename += "*";
		}

		var main_cparam = new CCodeParameter (get_variable_cname (param.name), ctypename);

		cparam_map.set (get_param_pos (get_ccode_pos (param)), main_cparam);
		if (carg_map != null) {
			carg_map.set (get_param_pos (get_ccode_pos (param)), get_variable_cexpression (param.name));
		}

		if (param.variable_type is DelegateType) {
			var deleg_type = (DelegateType) param.variable_type;
			var d = deleg_type.delegate_symbol;

			generate_delegate_declaration (d, decl_space);

			if (d.has_target) {
				var cparam = new CCodeParameter (get_ccode_delegate_target_name (param), target_ctypename);
				cparam_map.set (get_param_pos (get_ccode_delegate_target_pos (param)), cparam);
				if (carg_map != null) {
					carg_map.set (get_param_pos (get_ccode_delegate_target_pos (param)), get_variable_cexpression (cparam.name));
				}
				if (deleg_type.is_disposable ()) {
					cparam = new CCodeParameter (get_delegate_target_destroy_notify_cname (get_variable_cname (param.name)), target_destroy_notify_ctypename);
					cparam_map.set (get_param_pos (get_ccode_delegate_target_pos (param) + 0.01), cparam);
					if (carg_map != null) {
						carg_map.set (get_param_pos (get_ccode_delegate_target_pos (param) + 0.01), get_variable_cexpression (cparam.name));
					}
				}
			}
		} else if (param.variable_type is MethodType) {
			var cparam = new CCodeParameter (get_ccode_delegate_target_name (param), target_ctypename);
			cparam_map.set (get_param_pos (get_ccode_delegate_target_pos (param)), cparam);
			if (carg_map != null) {
				carg_map.set (get_param_pos (get_ccode_delegate_target_pos (param)), get_variable_cexpression (cparam.name));
			}
		}

		return main_cparam;
	}
}
