/* valaccodedelegatemodule.vala
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

using Gee;

/**
 * The link between an assignment and generated code.
 */
internal class Vala.CCodeDelegateModule : CCodeArrayModule {
	public CCodeDelegateModule (CCodeGenerator codegen, CCodeModule? next) {
		base (codegen, next);
	}

	public override void generate_delegate_declaration (Delegate d, CCodeDeclarationSpace decl_space) {
		if (decl_space.add_symbol_declaration (d, d.get_cname ())) {
			return;
		}

		generate_type_declaration (d.return_type, decl_space);

		var cfundecl = new CCodeFunctionDeclarator (d.get_cname ());
		foreach (FormalParameter param in d.get_parameters ()) {
			generate_parameter (param, decl_space, new HashMap<int,CCodeFormalParameter> (), null);

			cfundecl.add_parameter ((CCodeFormalParameter) param.ccodenode);

			// handle array parameters
			if (!param.no_array_length && param.parameter_type is ArrayType) {
				var array_type = (ArrayType) param.parameter_type;
				
				var length_ctype = "int";
				if (param.direction != ParameterDirection.IN) {
					length_ctype = "int*";
				}
				
				for (int dim = 1; dim <= array_type.rank; dim++) {
					var cparam = new CCodeFormalParameter (head.get_array_length_cname (param.name, dim), length_ctype);
					cfundecl.add_parameter (cparam);
				}
			}
		}
		if (!d.no_array_length && d.return_type is ArrayType) {
			// return array length if appropriate
			var array_type = (ArrayType) d.return_type;

			for (int dim = 1; dim <= array_type.rank; dim++) {
				var cparam = new CCodeFormalParameter (head.get_array_length_cname ("result", dim), "int*");
				cfundecl.add_parameter (cparam);
			}
		}
		if (d.has_target) {
			var cparam = new CCodeFormalParameter ("user_data", "void*");
			cfundecl.add_parameter (cparam);
		}
		if (d.get_error_types ().size > 0) {
			var cparam = new CCodeFormalParameter ("error", "GError**");
			cfundecl.add_parameter (cparam);
		}

		var ctypedef = new CCodeTypeDefinition (d.return_type.get_cname (), cfundecl);

		if (d.source_reference != null && d.source_reference.comment != null) {
			decl_space.add_type_declaration (new CCodeComment (d.source_reference.comment));
		}
		decl_space.add_type_declaration (ctypedef);
	}

	public override void visit_delegate (Delegate d) {
		d.accept_children (codegen);

		generate_delegate_declaration (d, source_declarations);

		if (!d.is_internal_symbol ()) {
			generate_delegate_declaration (d, header_declarations);
		}
	}

	public override string get_delegate_target_cname (string delegate_cname) {
		return "%s_target".printf (delegate_cname);
	}

	public override CCodeExpression get_delegate_target_cexpression (Expression delegate_expr) {
		bool is_out = false;
	
		if (delegate_expr is UnaryExpression) {
			var unary_expr = (UnaryExpression) delegate_expr;
			if (unary_expr.operator == UnaryOperator.OUT || unary_expr.operator == UnaryOperator.REF) {
				delegate_expr = unary_expr.inner;
				is_out = true;
			}
		}
		
		if (delegate_expr is MethodCall) {
			var invocation_expr = (MethodCall) delegate_expr;
			return invocation_expr.delegate_target;
		} else if (delegate_expr is LambdaExpression) {
			if ((current_method != null && current_method.binding == MemberBinding.INSTANCE) || in_constructor) {
				return new CCodeIdentifier ("self");
			} else {
				return new CCodeConstant ("NULL");
			}
		} else if (delegate_expr.symbol_reference != null) {
			if (delegate_expr.symbol_reference is FormalParameter) {
				var param = (FormalParameter) delegate_expr.symbol_reference;
				CCodeExpression target_expr = new CCodeIdentifier (get_delegate_target_cname (param.name));
				if (param.direction != ParameterDirection.IN) {
					// accessing argument of out/ref param
					target_expr = new CCodeUnaryExpression (CCodeUnaryOperator.POINTER_INDIRECTION, target_expr);
				}
				if (is_out) {
					// passing array as out/ref
					return new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, target_expr);
				} else {
					return target_expr;
				}
			} else if (delegate_expr.symbol_reference is LocalVariable) {
				var local = (LocalVariable) delegate_expr.symbol_reference;
				var target_expr = new CCodeIdentifier (get_delegate_target_cname (local.name));
				if (is_out) {
					return new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, target_expr);
				} else {
					return target_expr;
				}
			} else if (delegate_expr.symbol_reference is Field) {
				var field = (Field) delegate_expr.symbol_reference;
				var target_cname = get_delegate_target_cname (field.get_cname ());

				var ma = (MemberAccess) delegate_expr;

				CCodeExpression target_expr = null;

				if (field.binding == MemberBinding.INSTANCE) {
					var instance_expression_type = ma.inner.value_type;
					var instance_target_type = get_data_type_for_symbol ((TypeSymbol) field.parent_symbol);

					var pub_inst = (CCodeExpression) get_ccodenode (ma.inner);
					CCodeExpression typed_inst = transform_expression (pub_inst, instance_expression_type, instance_target_type);

					CCodeExpression inst;
					if (field.access == SymbolAccessibility.PRIVATE) {
						inst = new CCodeMemberAccess.pointer (typed_inst, "priv");
					} else {
						inst = typed_inst;
					}
					if (((TypeSymbol) field.parent_symbol).is_reference_type ()) {
						target_expr = new CCodeMemberAccess.pointer (inst, target_cname);
					} else {
						target_expr = new CCodeMemberAccess (inst, target_cname);
					}
				} else {
					target_expr = new CCodeIdentifier (target_cname);
				}

				if (is_out) {
					return new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, target_expr);
				} else {
					return target_expr;
				}
			} else if (delegate_expr.symbol_reference is Method) {
				var m = (Method) delegate_expr.symbol_reference;
				var ma = (MemberAccess) delegate_expr;
				if (m.binding == MemberBinding.STATIC) {
					return new CCodeConstant ("NULL");
				} else {
					return (CCodeExpression) get_ccodenode (ma.inner);
				}
			}
		}

		return new CCodeConstant ("NULL");
	}

	public override string get_delegate_target_destroy_notify_cname (string delegate_cname) {
		return "%s_target_destroy_notify".printf (delegate_cname);
	}

	public override CCodeExpression get_implicit_cast_expression (CCodeExpression source_cexpr, DataType? expression_type, DataType? target_type, Expression? expr = null) {
		if (target_type is DelegateType && expression_type is MethodType) {
			var dt = (DelegateType) target_type;
			var mt = (MethodType) expression_type;

			var method = mt.method_symbol;
			if (method.base_method != null) {
				method = method.base_method;
			} else if (method.base_interface_method != null) {
				method = method.base_interface_method;
			}

			return new CCodeIdentifier (generate_delegate_wrapper (method, dt.delegate_symbol));
		} else {
			return base.get_implicit_cast_expression (source_cexpr, expression_type, target_type, expr);
		}
	}

	private string generate_delegate_wrapper (Method m, Delegate d) {
		string delegate_name;
		var sig = d.parent_symbol as Signal;
		var dynamic_sig = sig as DynamicSignal;
		if (dynamic_sig != null) {
			delegate_name = head.get_dynamic_signal_cname (dynamic_sig);
		} else if (sig != null) {
			delegate_name = sig.parent_symbol.get_lower_case_cprefix () + sig.get_cname ();
		} else {
			delegate_name = Symbol.camel_case_to_lower_case (d.get_cname ());
		}

		string wrapper_name = "_%s_%s".printf (m.get_cname (), delegate_name);

		if (!add_wrapper (wrapper_name)) {
			// wrapper already defined
			return wrapper_name;
		}

		// declaration

		var function = new CCodeFunction (wrapper_name, m.return_type.get_cname ());
		function.modifiers = CCodeModifiers.STATIC;
		m.ccodenode = function;

		var cparam_map = new HashMap<int,CCodeFormalParameter> (direct_hash, direct_equal);

		if (d.has_target) {
			var cparam = new CCodeFormalParameter ("self", "gpointer");
			cparam_map.set (get_param_pos (d.cinstance_parameter_position), cparam);
		}

		if (d.sender_type != null) {
			var param = new FormalParameter ("_sender", d.sender_type);
			generate_parameter (param, source_declarations, cparam_map, null);
		}

		var d_params = d.get_parameters ();
		foreach (FormalParameter param in d_params) {
			generate_parameter (param, source_declarations, cparam_map, null);
		}
		if (!d.no_array_length && d.return_type is ArrayType) {
			// return array length if appropriate
			var array_type = (ArrayType) d.return_type;

			for (int dim = 1; dim <= array_type.rank; dim++) {
				var cparam = new CCodeFormalParameter (head.get_array_length_cname ("result", dim), "int*");
				cparam_map.set (get_param_pos (d.carray_length_parameter_position + 0.01 * dim), cparam);
			}
		}

		if (m.get_error_types ().size > 0) {
			var cparam = new CCodeFormalParameter ("error", "GError**");
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
		if (m.binding == MemberBinding.INSTANCE) {
			CCodeExpression arg;
			if (d.has_target) {
				arg = new CCodeIdentifier ("self");
			} else {
				// use first delegate parameter as instance
				arg = new CCodeIdentifier ((d_params.get (0).ccodenode as CCodeFormalParameter).name);
				i = 1;
			}
			carg_map.set (get_param_pos (m.cinstance_parameter_position), arg);
		}

		bool first = true;

		foreach (FormalParameter param in m.get_parameters ()) {
			if (first && d.sender_type != null && m.get_parameters ().size == d.get_parameters ().size + 1) {
				// sender parameter
				carg_map.set (get_param_pos (param.cparameter_position), new CCodeIdentifier ("_sender"));

				first = false;
				continue;
			}

			CCodeExpression arg;
			arg = new CCodeIdentifier ((d_params.get (i).ccodenode as CCodeFormalParameter).name);
			carg_map.set (get_param_pos (param.cparameter_position), arg);

			// handle array arguments
			if (!param.no_array_length && param.parameter_type is ArrayType) {
				var array_type = (ArrayType) param.parameter_type;
				for (int dim = 1; dim <= array_type.rank; dim++) {
					CCodeExpression clength;
					if (d_params.get (i).array_null_terminated) {
						requires_array_length = true;
						var len_call = new CCodeFunctionCall (new CCodeIdentifier ("_vala_array_length"));
						len_call.add_argument (new CCodeIdentifier (d_params.get (i).name));
						clength = len_call;
					} else if (d_params.get (i).no_array_length) {
						clength = new CCodeConstant ("-1");
					} else {
						clength = new CCodeIdentifier (head.get_array_length_cname (d_params.get (i).name, dim));
					}
					carg_map.set (get_param_pos (param.carray_length_parameter_position + 0.01 * dim), clength);
				}
			}

			i++;
		}
		if (!m.no_array_length && m.return_type is ArrayType) {
			var array_type = (ArrayType) m.return_type;
			for (int dim = 1; dim <= array_type.rank; dim++) {
				CCodeExpression clength;
				if (d.no_array_length) {
					clength = new CCodeConstant ("NULL");
				} else {
					clength = new CCodeIdentifier (head.get_array_length_cname ("result", dim));
				}
				carg_map.set (get_param_pos (m.carray_length_parameter_position + 0.01 * dim), clength);
			}
		}

		if (m.get_error_types ().size > 0) {
			carg_map.set (get_param_pos (-1), new CCodeIdentifier ("error"));
		}

		var ccall = new CCodeFunctionCall (new CCodeIdentifier (m.get_cname ()));

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

		var block = new CCodeBlock ();
		if (m.return_type is VoidType) {
			block.add_statement (new CCodeExpressionStatement (ccall));
		} else {
			block.add_statement (new CCodeReturnStatement (ccall));
		}

		// append to file

		source_declarations.add_type_member_declaration (function.copy ());

		function.block = block;
		source_type_member_definition.append (function);

		return wrapper_name;
	}

	public override void generate_parameter (FormalParameter param, CCodeDeclarationSpace decl_space, Map<int,CCodeFormalParameter> cparam_map, Map<int,CCodeExpression>? carg_map) {
		if (!(param.parameter_type is DelegateType || param.parameter_type is MethodType)) {
			base.generate_parameter (param, decl_space, cparam_map, carg_map);
			return;
		}

		string ctypename = param.parameter_type.get_cname ();

		if (param.direction != ParameterDirection.IN) {
			ctypename += "*";
		}

		param.ccodenode = new CCodeFormalParameter (param.name, ctypename);

		cparam_map.set (get_param_pos (param.cparameter_position), (CCodeFormalParameter) param.ccodenode);
		if (carg_map != null) {
			carg_map.set (get_param_pos (param.cparameter_position), new CCodeIdentifier (param.name));
		}

		if (param.parameter_type is DelegateType) {
			var deleg_type = (DelegateType) param.parameter_type;
			var d = deleg_type.delegate_symbol;

			generate_delegate_declaration (d, decl_space);

			if (d.has_target) {
				var cparam = new CCodeFormalParameter (get_delegate_target_cname (param.name), "void*");
				cparam_map.set (get_param_pos (param.cdelegate_target_parameter_position), cparam);
				if (carg_map != null) {
					carg_map.set (get_param_pos (param.cdelegate_target_parameter_position), new CCodeIdentifier (cparam.name));
				}
				if (deleg_type.value_owned) {
					cparam = new CCodeFormalParameter (get_delegate_target_destroy_notify_cname (param.name), "GDestroyNotify");
					cparam_map.set (get_param_pos (param.cdelegate_target_parameter_position + 0.01), cparam);
					if (carg_map != null) {
						carg_map.set (get_param_pos (param.cdelegate_target_parameter_position + 0.01), new CCodeIdentifier (cparam.name));
					}
				}
			}
		} else if (param.parameter_type is MethodType) {
			var cparam = new CCodeFormalParameter (get_delegate_target_cname (param.name), "void*");
			cparam_map.set (get_param_pos (param.cdelegate_target_parameter_position), cparam);
			if (carg_map != null) {
				carg_map.set (get_param_pos (param.cdelegate_target_parameter_position), new CCodeIdentifier (cparam.name));
			}
		}
	}
}
