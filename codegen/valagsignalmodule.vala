/* valagsignalmodule.vala
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


public class Vala.GSignalModule : GObjectModule {
	string get_marshaller_function (Signal sig, List<Parameter> params, DataType return_type, string? prefix = null) {
		var signature = get_marshaller_signature (sig, params, return_type);
		string ret;

		if (prefix == null) {
			if (predefined_marshal_set.contains (signature)) {
				prefix = "g_cclosure_marshal";
			} else {
				prefix = "g_cclosure_user_marshal";
			}
		}

		ret = "%s_%s_".printf (prefix, get_ccode_marshaller_type_name (return_type));

		foreach (Parameter p in params) {
			ret = "%s_%s".printf (ret, get_ccode_marshaller_type_name (p).replace (",", "_"));
		}
		if (sig.return_type.is_real_non_null_struct_type ()) {
			ret = ret + "_POINTER";
		} else if (params.size == 0) {
			ret = ret + "_VOID";
		}

		return ret;
	}

	private string? get_value_type_name_from_type_reference (DataType t) {
		if (t is PointerType || t is GenericType) {
			return "gpointer";
		} else if (t is VoidType) {
			return "void";
		} else if (get_ccode_type_id (t) == get_ccode_type_id (string_type)) {
			return "const char*";
		} else if (t.type_symbol is Class || t.type_symbol is Interface) {
			return "gpointer";
		} else if (t is ValueType && t.nullable) {
			return "gpointer";
		} else if (t.type_symbol is Struct) {
			unowned Struct st = (Struct) t.type_symbol;
			if (st.is_simple_type ()) {
				return get_ccode_name (t.type_symbol);
			} else {
				return "gpointer";
			}
		} else if (t.type_symbol is Enum) {
			unowned Enum en = (Enum) t.type_symbol;
			if (en.is_flags) {
				return "guint";
			} else {
				return "gint";
			}
		} else if (t is ArrayType) {
			return "gpointer";
		} else if (t is DelegateType) {
			return "gpointer";
		} else if (t is ErrorType) {
			return "gpointer";
		}

		return null;
	}

	private string? get_value_type_name_from_parameter (Parameter p) {
		if (p.direction != ParameterDirection.IN) {
			return "gpointer";
		} else {
			return get_value_type_name_from_type_reference (p.variable_type);
		}
	}

	private string get_marshaller_signature (Signal sig, List<Parameter> params, DataType return_type) {
		string signature;

		signature = "%s:".printf (get_ccode_marshaller_type_name (return_type));
		bool first = true;
		foreach (Parameter p in params) {
			if (first) {
				signature = signature + get_ccode_marshaller_type_name (p);
				first = false;
			} else {
				signature = "%s,%s".printf (signature, get_ccode_marshaller_type_name (p));
			}
		}
		if (sig.return_type.is_real_non_null_struct_type ()) {
			signature = signature + (first ? "POINTER" : ",POINTER");
		} else if (params.size == 0) {
			signature = signature + "VOID";
		}

		return signature;
	}

	private CCodeExpression get_signal_name_cexpression (Signal sig, Expression? detail_expr, CodeNode node) {
		if (detail_expr == null) {
			return get_signal_canonical_constant (sig);
		}

		if (detail_expr is StringLiteral) {
			return get_signal_canonical_constant (sig, ((StringLiteral) detail_expr).eval ());
		}

		var detail_value = create_temp_value (detail_expr.value_type, false, node, true);
		temp_ref_values.insert (0, detail_value);

		var ccall = new CCodeFunctionCall (new CCodeIdentifier ("g_strconcat"));
		ccall.add_argument (get_signal_canonical_constant (sig, ""));
		ccall.add_argument (get_cvalue (detail_expr));
		ccall.add_argument (new CCodeConstant ("NULL"));

		ccode.add_assignment (get_cvalue_ (detail_value), ccall);
		return get_cvalue_ (detail_value);
	}

	private CCodeExpression get_signal_id_cexpression (Signal sig) {
		var cl = (TypeSymbol) sig.parent_symbol;
		var signal_array = new CCodeIdentifier ("%s_signals".printf (get_ccode_lower_case_name (cl)));
		var signal_enum_value = new CCodeIdentifier ("%s_%s_SIGNAL".printf (get_ccode_upper_case_name (cl), get_ccode_upper_case_name (sig)));

		return new CCodeElementAccess (signal_array, signal_enum_value);
	}

	private CCodeExpression get_detail_cexpression (Expression detail_expr, CodeNode node) {
		var detail_cexpr = get_cvalue (detail_expr);
		CCodeFunctionCall detail_ccall;
		if (is_constant_ccode_expression (detail_cexpr)) {
			detail_ccall = new CCodeFunctionCall (new CCodeIdentifier ("g_quark_from_static_string"));
		} else {
			detail_ccall = new CCodeFunctionCall (new CCodeIdentifier ("g_quark_from_string"));
		}
		detail_ccall.add_argument (detail_cexpr);

		return detail_ccall;
	}

	public override void visit_signal (Signal sig) {
		if (signal_enum != null && sig.parent_symbol is TypeSymbol) {
			signal_enum.add_value (new CCodeEnumValue ("%s_%s_SIGNAL".printf (get_ccode_upper_case_name ((TypeSymbol) sig.parent_symbol), get_ccode_upper_case_name (sig))));
		}

		sig.accept_children (this);

		// declare parameter type
		unowned List<Parameter> params = sig.get_parameters ();
		foreach (Parameter p in params) {
			generate_parameter (p, cfile, new HashMap<int,CCodeParameter> (), null);
		}

		if (sig.return_type.is_real_non_null_struct_type ()) {
			generate_marshaller (sig, params, new VoidType ());
		} else {
			generate_marshaller (sig, params, sig.return_type);
		}
	}

	void generate_marshaller (Signal sig, List<Parameter> params, DataType return_type) {
		string signature;
		int n_params, i;

		/* check whether a signal with the same signature already exists for this source file (or predefined) */
		signature = get_marshaller_signature (sig, params, return_type);
		if (predefined_marshal_set.contains (signature) || user_marshal_set.contains (signature)) {
			return;
		}

		var signal_marshaller = new CCodeFunction (get_marshaller_function (sig, params, return_type, null), "void");
		signal_marshaller.modifiers = CCodeModifiers.STATIC;

		signal_marshaller.add_parameter (new CCodeParameter ("closure", "GClosure *"));
		signal_marshaller.add_parameter (new CCodeParameter ("return_value", "GValue *"));
		signal_marshaller.add_parameter (new CCodeParameter ("n_param_values", "guint"));
		signal_marshaller.add_parameter (new CCodeParameter ("param_values", "const GValue *"));
		signal_marshaller.add_parameter (new CCodeParameter ("invocation_hint", "gpointer"));
		signal_marshaller.add_parameter (new CCodeParameter ("marshal_data", "gpointer"));

		push_function (signal_marshaller);

		var callback_decl = new CCodeFunctionDeclarator (get_marshaller_function (sig, params, return_type, "GMarshalFunc"));
		callback_decl.add_parameter (new CCodeParameter ("data1", "gpointer"));
		n_params = 1;
		foreach (Parameter p in params) {
			callback_decl.add_parameter (new CCodeParameter ("arg_%d".printf (n_params), get_value_type_name_from_parameter (p)));
			n_params++;
			if (p.variable_type is ArrayType) {
				var array_type = (ArrayType) p.variable_type;
				var length_ctype = get_ccode_array_length_type (p);
				for (var j = 0; j < array_type.rank; j++) {
					callback_decl.add_parameter (new CCodeParameter ("arg_%d".printf (n_params), length_ctype));
					n_params++;
				}
			} else if (p.variable_type is DelegateType) {
				unowned DelegateType delegate_type = (DelegateType) p.variable_type;
				if (delegate_type.delegate_symbol.has_target) {
					callback_decl.add_parameter (new CCodeParameter ("arg_%d".printf (n_params), get_ccode_name (delegate_target_type)));
					n_params++;
					if (delegate_type.is_disposable ()) {
						callback_decl.add_parameter (new CCodeParameter ("arg_%d".printf (n_params), get_ccode_name (delegate_target_destroy_type)));
						n_params++;
					}
				}
			}
		}
		if (sig.return_type.is_real_non_null_struct_type ()) {
			callback_decl.add_parameter (new CCodeParameter ("arg_%d".printf (n_params), "gpointer"));
			n_params++;
		}

		callback_decl.add_parameter (new CCodeParameter ("data2", "gpointer"));
		ccode.add_statement (new CCodeTypeDefinition (get_value_type_name_from_type_reference (return_type), callback_decl));

		ccode.add_declaration (get_marshaller_function (sig, params, return_type, "GMarshalFunc"), new CCodeVariableDeclarator ("callback"), CCodeModifiers.REGISTER);

		ccode.add_declaration ("GCClosure *", new CCodeVariableDeclarator ("cc", new CCodeCastExpression (new CCodeIdentifier ("closure"), "GCClosure *")), CCodeModifiers.REGISTER);

		ccode.add_declaration ("gpointer", new CCodeVariableDeclarator ("data1"), CCodeModifiers.REGISTER);
		ccode.add_declaration ("gpointer", new CCodeVariableDeclarator ("data2"), CCodeModifiers.REGISTER);

		CCodeFunctionCall fc;

		if (return_type.type_symbol != null || return_type is ArrayType) {
			ccode.add_declaration (get_value_type_name_from_type_reference (return_type), new CCodeVariableDeclarator ("v_return"));

			fc = new CCodeFunctionCall (new CCodeIdentifier ("g_return_if_fail"));
			fc.add_argument (new CCodeBinaryExpression (CCodeBinaryOperator.INEQUALITY, new CCodeIdentifier ("return_value"), new CCodeConstant ("NULL")));
			ccode.add_expression (fc);
		}

		fc = new CCodeFunctionCall (new CCodeIdentifier ("g_return_if_fail"));
		fc.add_argument (new CCodeBinaryExpression (CCodeBinaryOperator.EQUALITY, new CCodeIdentifier ("n_param_values"), new CCodeConstant (n_params.to_string())));
		ccode.add_expression (fc);

		var data = new CCodeMemberAccess (new CCodeIdentifier ("closure"), "data", true);
		var param = new CCodeMemberAccess (new CCodeMemberAccess (new CCodeIdentifier ("param_values"), "data[0]", true), "v_pointer");
		var cond = new CCodeFunctionCall (new CCodeConstant ("G_CCLOSURE_SWAP_DATA"));
		cond.add_argument (new CCodeIdentifier ("closure"));
		ccode.open_if (cond);
		ccode.add_assignment (new CCodeIdentifier ("data1"), data);
		ccode.add_assignment (new CCodeIdentifier ("data2"), param);
		ccode.add_else ();
		ccode.add_assignment (new CCodeIdentifier ("data1"), param);
		ccode.add_assignment (new CCodeIdentifier ("data2"), data);
		ccode.close ();

		var c_assign_rhs =  new CCodeCastExpression (new CCodeConditionalExpression (new CCodeIdentifier ("marshal_data"), new CCodeIdentifier ("marshal_data"), new CCodeMemberAccess (new CCodeIdentifier ("cc"), "callback", true)), get_marshaller_function (sig, params, return_type, "GMarshalFunc"));
		ccode.add_assignment (new CCodeIdentifier ("callback"), c_assign_rhs);

		fc = new CCodeFunctionCall (new CCodeIdentifier ("callback"));
		fc.add_argument (new CCodeIdentifier ("data1"));
		i = 1;
		foreach (Parameter p in params) {
			CCodeFunctionCall inner_fc;
			if (p.direction != ParameterDirection.IN) {
				inner_fc = new CCodeFunctionCall (new CCodeIdentifier ("g_value_get_pointer"));
			} else if (p.variable_type is ValueType && p.variable_type.nullable) {
				inner_fc = new CCodeFunctionCall (new CCodeIdentifier ("g_value_get_pointer"));
			} else {
				inner_fc = new CCodeFunctionCall (get_value_getter_function (p.variable_type));
			}
			inner_fc.add_argument (new CCodeBinaryExpression (CCodeBinaryOperator.PLUS, new CCodeIdentifier ("param_values"), new CCodeIdentifier (i.to_string ())));
			fc.add_argument (inner_fc);
			i++;
			if (p.variable_type is ArrayType) {
				var array_type = (ArrayType) p.variable_type;
				var length_value_function = get_ccode_get_value_function (array_type.length_type.type_symbol);
				assert (length_value_function != null && length_value_function != "");
				for (var j = 0; j < array_type.rank; j++) {
					inner_fc = new CCodeFunctionCall (new CCodeIdentifier (length_value_function));
					inner_fc.add_argument (new CCodeBinaryExpression (CCodeBinaryOperator.PLUS, new CCodeIdentifier ("param_values"), new CCodeIdentifier (i.to_string ())));
					fc.add_argument (inner_fc);
					i++;
				}
			} else if (p.variable_type is DelegateType) {
				unowned DelegateType delegate_type = (DelegateType) p.variable_type;
				if (delegate_type.delegate_symbol.has_target) {
					inner_fc = new CCodeFunctionCall (new CCodeIdentifier ("g_value_get_pointer"));
					inner_fc.add_argument (new CCodeBinaryExpression (CCodeBinaryOperator.PLUS, new CCodeIdentifier ("param_values"), new CCodeIdentifier (i.to_string ())));
					fc.add_argument (inner_fc);
					i++;
					if (delegate_type.is_disposable ()) {
						inner_fc = new CCodeFunctionCall (new CCodeIdentifier ("g_value_get_pointer"));
						inner_fc.add_argument (new CCodeBinaryExpression (CCodeBinaryOperator.PLUS, new CCodeIdentifier ("param_values"), new CCodeIdentifier (i.to_string ())));
						fc.add_argument (inner_fc);
						i++;
					}
				}
			}
		}
		if (sig.return_type.is_real_non_null_struct_type ()) {
			var inner_fc = new CCodeFunctionCall (new CCodeIdentifier ("g_value_get_pointer"));
			inner_fc.add_argument (new CCodeBinaryExpression (CCodeBinaryOperator.PLUS, new CCodeIdentifier ("param_values"), new CCodeIdentifier (i.to_string ())));
			fc.add_argument (inner_fc);
			i++;
		}
		fc.add_argument (new CCodeIdentifier ("data2"));

		if (return_type.type_symbol != null || return_type is ArrayType) {
			ccode.add_assignment (new CCodeIdentifier ("v_return"), fc);

			CCodeFunctionCall set_fc;
			if (return_type is ValueType) {
				if (return_type.nullable) {
					set_fc = new CCodeFunctionCall (new CCodeIdentifier ("g_value_set_pointer"));
				} else {
					set_fc = new CCodeFunctionCall (get_value_setter_function (return_type));
				}
			} else {
				set_fc = new CCodeFunctionCall (get_value_taker_function (return_type));
			}
			set_fc.add_argument (new CCodeIdentifier ("return_value"));
			set_fc.add_argument (new CCodeIdentifier ("v_return"));

			ccode.add_expression (set_fc);
		} else {
			ccode.add_expression (fc);
		}

		pop_function ();

		cfile.add_function_declaration (signal_marshaller);
		cfile.add_function (signal_marshaller);
		user_marshal_set.add (signature);
	}

	public override CCodeExpression get_signal_creation (Signal sig, ObjectTypeSymbol type) {
		var csignew = new CCodeFunctionCall (new CCodeIdentifier ("g_signal_new"));
		csignew.add_argument (new CCodeConstant ("\"%s\"".printf (get_ccode_name (sig))));
		csignew.add_argument (new CCodeIdentifier (get_ccode_type_id (type)));
		string[] flags = new string[0];
		var run_type = sig.get_attribute_string ("Signal", "run");
		if (run_type == "first") {
			flags += "G_SIGNAL_RUN_FIRST";
		} else if (run_type == "cleanup") {
			flags += "G_SIGNAL_RUN_CLEANUP";
		} else {
			flags += "G_SIGNAL_RUN_LAST";
		}
		if (sig.get_attribute_bool ("Signal", "detailed")) {
			flags += "G_SIGNAL_DETAILED";
		}

		if (sig.get_attribute_bool ("Signal", "no_recurse")) {
			flags += "G_SIGNAL_NO_RECURSE";
		}

		if (sig.get_attribute_bool ("Signal", "action")) {
			flags += "G_SIGNAL_ACTION";
		}

		if (sig.get_attribute_bool ("Signal", "no_hooks")) {
			flags += "G_SIGNAL_NO_HOOKS";
		}

		if (sig.version.deprecated) {
			flags += "G_SIGNAL_DEPRECATED";
		}

		csignew.add_argument (new CCodeConstant (string.joinv (" | ", flags)));

		if (sig.default_handler == null) {
			csignew.add_argument (new CCodeConstant ("0"));
		} else {
			var struct_offset = new CCodeFunctionCall (new CCodeIdentifier ("G_STRUCT_OFFSET"));
			struct_offset.add_argument (new CCodeIdentifier (get_ccode_type_name (type)));
			struct_offset.add_argument (new CCodeIdentifier (get_ccode_vfunc_name (sig.default_handler)));
			csignew.add_argument (struct_offset);
		}
		csignew.add_argument (new CCodeConstant ("NULL"));
		csignew.add_argument (new CCodeConstant ("NULL"));

		unowned List<Parameter> params = sig.get_parameters ();
		string marshaller;
		if (sig.return_type.is_real_non_null_struct_type ()) {
			marshaller = get_marshaller_function (sig, params, new VoidType ());
		} else {
			marshaller = get_marshaller_function (sig, params, sig.return_type);
		}

		var marshal_arg = new CCodeIdentifier (marshaller);
		csignew.add_argument (marshal_arg);

		if (sig.return_type is PointerType || sig.return_type is GenericType) {
			csignew.add_argument (new CCodeConstant ("G_TYPE_POINTER"));
		} else if (sig.return_type is ErrorType) {
			csignew.add_argument (new CCodeConstant ("G_TYPE_POINTER"));
		} else if (sig.return_type is ValueType && sig.return_type.nullable) {
			csignew.add_argument (new CCodeConstant ("G_TYPE_POINTER"));
		} else if (sig.return_type.type_symbol == null) {
			csignew.add_argument (new CCodeConstant ("G_TYPE_NONE"));
		} else if (sig.return_type.is_real_non_null_struct_type ()) {
			csignew.add_argument (new CCodeConstant ("G_TYPE_NONE"));
		} else {
			csignew.add_argument (new CCodeConstant (get_ccode_type_id (sig.return_type.type_symbol)));
		}

		int params_len = 0;
		foreach (Parameter param in params) {
			params_len++;
			if (param.variable_type is ArrayType) {
				params_len += ((ArrayType) param.variable_type).rank;
			} else if (param.variable_type is DelegateType) {
				unowned DelegateType delegate_type = (DelegateType) param.variable_type;
				if (delegate_type.delegate_symbol.has_target) {
					params_len++;
					if (delegate_type.is_disposable ()) {
						params_len++;
					}
				}
			}
		}
		if (sig.return_type.is_real_non_null_struct_type ()) {
			params_len++;
		}

		csignew.add_argument (new CCodeConstant ("%d".printf (params_len)));
		foreach (Parameter param in params) {
			if (param.variable_type is ArrayType) {
				var array_type = (ArrayType) param.variable_type;
				if (array_type.element_type.type_symbol == string_type.type_symbol) {
					csignew.add_argument (new CCodeConstant ("G_TYPE_STRV"));
				} else {
					csignew.add_argument (new CCodeConstant ("G_TYPE_POINTER"));
				}
				assert (get_ccode_has_type_id (array_type.length_type.type_symbol));
				var length_type_id = get_ccode_type_id (array_type.length_type.type_symbol);
				for (var i = 0; i < array_type.rank; i++) {
					csignew.add_argument (new CCodeConstant (length_type_id));
				}
			} else if (param.variable_type is DelegateType) {
				unowned DelegateType delegate_type = (DelegateType) param.variable_type;
				csignew.add_argument (new CCodeConstant ("G_TYPE_POINTER"));
				if (delegate_type.delegate_symbol.has_target) {
					csignew.add_argument (new CCodeConstant ("G_TYPE_POINTER"));
					if (delegate_type.is_disposable ()) {
						csignew.add_argument (new CCodeConstant ("G_TYPE_POINTER"));
					}
				}
			} else if (param.variable_type is PointerType || param.variable_type is GenericType || param.direction != ParameterDirection.IN) {
				csignew.add_argument (new CCodeConstant ("G_TYPE_POINTER"));
			} else if (param.variable_type is ErrorType) {
				csignew.add_argument (new CCodeConstant ("G_TYPE_POINTER"));
			} else if (param.variable_type is ValueType && param.variable_type.nullable) {
				csignew.add_argument (new CCodeConstant ("G_TYPE_POINTER"));
			} else {
				csignew.add_argument (new CCodeConstant (get_ccode_type_id (param.variable_type.type_symbol)));
			}
		}
		if (sig.return_type.is_real_non_null_struct_type ()) {
			csignew.add_argument (new CCodeConstant ("G_TYPE_POINTER"));
		}

		marshal_arg.name = marshaller;

		return new CCodeAssignment (get_signal_id_cexpression (sig), csignew);
	}

	public override void visit_element_access (ElementAccess expr) {
		if (expr.container is MemberAccess && expr.container.symbol_reference is Signal) {
			if (expr.parent_node is MethodCall) {
				// detailed signal emission
				var sig = (Signal) expr.symbol_reference;
				var ma = (MemberAccess) expr.container;

				var detail_expr = expr.get_indices ().get (0);

				CCodeFunctionCall ccall;
				if (!sig.external_package && expr.source_reference.file == sig.source_reference.file) {
					var detail_cexpr = get_detail_cexpression (detail_expr, expr);

					ccall = new CCodeFunctionCall (new CCodeIdentifier ("g_signal_emit"));
					ccall.add_argument (get_cvalue (ma.inner));
					ccall.add_argument (get_signal_id_cexpression (sig));
					ccall.add_argument (detail_cexpr);
				} else {
					var signal_name_cexpr = get_signal_name_cexpression (sig, detail_expr, expr);

					ccall = new CCodeFunctionCall (new CCodeIdentifier ("g_signal_emit_by_name"));
					ccall.add_argument (get_cvalue (ma.inner));
					ccall.add_argument (signal_name_cexpr);
				}

				set_cvalue (expr, ccall);
			} else {
				// signal connect or disconnect
			}
		} else {
			base.visit_element_access (expr);
		}
	}

	bool in_gobject_instance (Method m) {
		bool result = false;
		if (m.binding == MemberBinding.INSTANCE) {
			result = m.this_parameter.variable_type.type_symbol.is_subtype_of (gobject_type);
		}
		return result;
	}

	public override void visit_member_access (MemberAccess expr) {
		if (expr.symbol_reference is Signal) {
			CCodeExpression pub_inst = null;

			if (expr.inner != null) {
				pub_inst = get_cvalue (expr.inner);
			}

			var sig = (Signal) expr.symbol_reference;
			var cl = (TypeSymbol) sig.parent_symbol;

			if (expr.inner is BaseAccess && sig.is_virtual) {
				var m = sig.default_handler;
				var base_class = (Class) m.parent_symbol;
				var vcast = new CCodeFunctionCall (new CCodeIdentifier (get_ccode_class_type_function (base_class)));
				vcast.add_argument (new CCodeIdentifier ("%s_parent_class".printf (get_ccode_lower_case_name (current_class))));

				set_cvalue (expr, new CCodeMemberAccess.pointer (vcast, m.name));
				return;
			}

			if (!sig.external_package && expr.source_reference.file == sig.source_reference.file) {
				var ccall = new CCodeFunctionCall (new CCodeIdentifier ("g_signal_emit"));
				ccall.add_argument (pub_inst);
				ccall.add_argument (get_signal_id_cexpression (sig));
				ccall.add_argument (new CCodeConstant ("0"));

				set_cvalue (expr, ccall);
			} else if (get_ccode_has_emitter (sig)) {
				string emitter_func;
				if (sig.emitter != null) {
					if (!sig.external_package && expr.source_reference.file != sig.source_reference.file) {
						generate_method_declaration (sig.emitter, cfile);
					}
					emitter_func = get_ccode_lower_case_name (sig.emitter);
				} else {
					emitter_func = "%s_%s".printf (get_ccode_lower_case_name (cl), get_ccode_lower_case_name (sig));
				}
				var ccall = new CCodeFunctionCall (new CCodeIdentifier (emitter_func));

				ccall.add_argument (pub_inst);
				set_cvalue (expr, ccall);
			} else {
				var ccall = new CCodeFunctionCall (new CCodeIdentifier ("g_signal_emit_by_name"));
				ccall.add_argument (pub_inst);

				ccall.add_argument (get_signal_canonical_constant (sig));

				set_cvalue (expr, ccall);
			}
		} else {
			base.visit_member_access (expr);
		}
	}

	public override void visit_method_call (MethodCall expr) {
		var method_type = expr.call.value_type as MethodType;

		if (method_type == null || !(method_type.method_symbol.parent_symbol is Signal)) {
			// no signal connect/disconnect call
			base.visit_method_call (expr);
			return;
		}

		var sig = (Signal) method_type.method_symbol.parent_symbol;
		var signal_access = ((MemberAccess) expr.call).inner;
		var handler = expr.get_argument_list ().get (0);

		bool disconnect = (method_type.method_symbol.name == "disconnect");
		bool after = (method_type.method_symbol.name == "connect_after");

		var cexpr = connect_signal (sig, signal_access, handler, disconnect, after, expr);
		set_cvalue (expr, cexpr);
	}

	CCodeExpression? connect_signal (Signal sig, Expression signal_access, Expression handler, bool disconnect, bool after, CodeNode expr) {
		string connect_func;

		DelegateType? dt = null;
		if (handler.symbol_reference is Variable) {
			dt = ((Variable) handler.symbol_reference).variable_type as DelegateType;
			if (dt != null && !context.experimental) {
				Report.warning (handler.source_reference, "Connecting delegates to signals is experimental");
			}
			// Use actual lambda expression if available for proper target/destroy handling
			if (((Variable) handler.symbol_reference).initializer is LambdaExpression) {
				handler = ((Variable) handler.symbol_reference).initializer;
			}
		}
		var m = handler.symbol_reference as Method;

		if (!disconnect) {
			// connect
			if (sig is DynamicSignal) {
				if (!after)
					connect_func = get_dynamic_signal_connect_wrapper_name ((DynamicSignal) sig);
				else
					connect_func = get_dynamic_signal_connect_after_wrapper_name ((DynamicSignal) sig);
			} else {
				if ((m != null && m.closure) || (dt != null && dt.value_owned)) {
					connect_func = "g_signal_connect_data";
				} else if (m != null && in_gobject_instance (m)) {
					connect_func = "g_signal_connect_object";
				} else if (!after) {
					connect_func = "g_signal_connect";
				} else
					connect_func = "g_signal_connect_after";
			}
		} else {
			// disconnect
			if (sig is DynamicSignal) {
				connect_func = get_dynamic_signal_disconnect_wrapper_name ((DynamicSignal) sig);
			} else {
				connect_func = "g_signal_handlers_disconnect_matched";
			}
		}

		var ccall = new CCodeFunctionCall (new CCodeIdentifier (connect_func));

		CCodeExpression signal_name_cexpr = null;

		// first argument: instance of sender
		MemberAccess ma;
		if (signal_access is ElementAccess) {
			var ea = (ElementAccess) signal_access;
			ma = (MemberAccess) ea.container;
			var detail_expr = ea.get_indices ().get (0);
			signal_name_cexpr = get_signal_name_cexpression (sig, detail_expr, expr);
		} else {
			ma = (MemberAccess) signal_access;
			signal_name_cexpr = get_signal_name_cexpression (sig, null, expr);
		}
		if (ma.inner != null) {
			ccall.add_argument ((CCodeExpression) get_ccodenode (ma.inner));
		} else {
			ccall.add_argument (get_this_cexpression ());
		}

		if (sig is DynamicSignal) {
			// dynamic_signal_connect or dynamic_signal_disconnect

			// second argument: signal name
			ccall.add_argument (new CCodeConstant ("\"%s\"".printf (get_ccode_name (sig))));
		} else if (!disconnect) {
			// g_signal_connect_object or g_signal_connect

			// second argument: signal name
			ccall.add_argument (signal_name_cexpr);
		} else {
			// g_signal_handlers_disconnect_matched

			// second argument: mask
			if (!(signal_access is ElementAccess)) {
				ccall.add_argument (new CCodeConstant ("G_SIGNAL_MATCH_ID | G_SIGNAL_MATCH_FUNC | G_SIGNAL_MATCH_DATA"));
			} else {
				ccall.add_argument (new CCodeConstant ("G_SIGNAL_MATCH_ID | G_SIGNAL_MATCH_DETAIL | G_SIGNAL_MATCH_FUNC | G_SIGNAL_MATCH_DATA"));
			}

			// get signal id
			var temp_decl = get_temp_variable (uint_type);
			emit_temp_var (temp_decl);
			var parse_call = new CCodeFunctionCall (new CCodeIdentifier ("g_signal_parse_name"));
			parse_call.add_argument (signal_name_cexpr);
			var decl_type = (TypeSymbol) sig.parent_symbol;
			parse_call.add_argument (new CCodeIdentifier (get_ccode_type_id (decl_type)));
			parse_call.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, get_variable_cexpression (temp_decl.name)));
			LocalVariable? detail_temp_decl = null;
			if (!(signal_access is ElementAccess)) {
				parse_call.add_argument (new CCodeConstant ("NULL"));
				parse_call.add_argument (new CCodeConstant ("FALSE"));
			} else {
				detail_temp_decl = get_temp_variable (gquark_type);
				emit_temp_var (detail_temp_decl);
				parse_call.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, get_variable_cexpression (detail_temp_decl.name)));
				parse_call.add_argument (new CCodeConstant ("TRUE"));
			}
			ccode.add_expression (parse_call);

			// third argument: signal_id
			ccall.add_argument (get_variable_cexpression (temp_decl.name));

			// fourth argument: detail
			if (detail_temp_decl == null) {
				ccall.add_argument (new CCodeConstant ("0"));
			} else {
				ccall.add_argument (get_variable_cexpression (detail_temp_decl.name));
			}
			// fifth argument: closure
			ccall.add_argument (new CCodeConstant ("NULL"));
		}

		// third resp. sixth argument: handler
		ccall.add_argument (new CCodeCastExpression (get_cvalue (handler), "GCallback"));

		if (m != null && m.closure) {
			// g_signal_connect_data

			// fourth argument: user_data
			CCodeExpression handler_destroy_notify;
			ccall.add_argument (get_delegate_target_cexpression (handler, out handler_destroy_notify));

			// fifth argument: destroy_notify
			ccall.add_argument (new CCodeCastExpression (handler_destroy_notify, "GClosureNotify"));

			// sixth argument: connect_flags
			if (!after)
				ccall.add_argument (new CCodeConstant ("0"));
			else
				ccall.add_argument (new CCodeConstant ("G_CONNECT_AFTER"));
		} else if (m != null && m.binding == MemberBinding.INSTANCE) {
			// g_signal_connect_object or g_signal_handlers_disconnect_matched
			// or dynamic_signal_connect or dynamic_signal_disconnect

			// fourth resp. seventh argument: object/user_data
			if (handler is MemberAccess) {
				var right_ma = (MemberAccess) handler;
				if (right_ma.inner != null) {
					ccall.add_argument (get_cvalue (right_ma.inner));
				} else {
					ccall.add_argument (get_this_cexpression ());
				}
			} else if (handler is LambdaExpression) {
				ccall.add_argument (get_this_cexpression ());
			}
			if (!disconnect && !(sig is DynamicSignal)
			    && in_gobject_instance (m)) {
				// g_signal_connect_object

				// fifth argument: connect_flags
				if (!after)
					ccall.add_argument (new CCodeConstant ("0"));
				else
					ccall.add_argument (new CCodeConstant ("G_CONNECT_AFTER"));
			}
		} else if (dt != null && dt.delegate_symbol.has_target) {
			// fourth argument: user_data
			CCodeExpression handler_destroy_notify;
			ccall.add_argument (get_delegate_target_cexpression (handler, out handler_destroy_notify));
			if (!disconnect && dt.value_owned) {
				// fifth argument: destroy_notify
				//FIXME handler_destroy_notify is NULL
				ccall.add_argument (new CCodeCastExpression (handler_destroy_notify, "GClosureNotify"));
				// sixth argument: connect_flags
				if (!after)
					ccall.add_argument (new CCodeConstant ("0"));
				else
					ccall.add_argument (new CCodeConstant ("G_CONNECT_AFTER"));
			}
		} else {
			// g_signal_connect or g_signal_connect_after or g_signal_handlers_disconnect_matched
			// or dynamic_signal_connect or dynamic_signal_disconnect

			// fourth resp. seventh argument: user_data
			ccall.add_argument (new CCodeConstant ("NULL"));
		}

		if (disconnect || expr.parent_node is ExpressionStatement) {
			ccode.add_expression (ccall);
			return null;
		} else {
			var temp_var = get_temp_variable (ulong_type);
			var temp_ref = get_variable_cexpression (temp_var.name);

			emit_temp_var (temp_var);

			ccode.add_assignment (temp_ref, ccall);

			return temp_ref;
		}
	}
}

