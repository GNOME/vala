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
	private string get_marshaller_type_name (DataType t, bool dbus = false) {
		if (t is PointerType || t.type_parameter != null) {
			return ("POINTER");
		} else if (t is ErrorType) {
			return ("POINTER");
		} else if (t is ArrayType) {
			if (dbus) {
				return ("BOXED");
			} else {
				if (((ArrayType) t).element_type.data_type == string_type.data_type) {
					return ("BOXED_INT");
				} else {
					return ("POINTER_INT");
				}
			}
		} else if (t is VoidType) {
			return ("VOID");
		} else if (dbus && DBusModule.get_type_signature (t).has_prefix ("(")) {
			return ("BOXED");
		} else if (t.data_type is Enum) {
			var en = (Enum) t.data_type;
			if (dbus) {
				if (en.is_flags) {
					return ("UINT");
				} else {
					return ("INT");
				}
			} else {
				return en.get_marshaller_type_name ();
			}
		} else {
			return t.data_type.get_marshaller_type_name ();
		}
	}
	
	private string get_marshaller_type_name_for_parameter (FormalParameter param, bool dbus = false) {
		if (param.direction != ParameterDirection.IN) {
			return ("POINTER");
		} else {
			return get_marshaller_type_name (param.variable_type, dbus);
		}
	}
	
	public override string get_marshaller_function (List<FormalParameter> params, DataType return_type, string? prefix = null, bool dbus = false) {
		var signature = get_marshaller_signature (params, return_type, dbus);
		string ret;

		if (prefix == null) {
			if (predefined_marshal_set.contains (signature)) {
				prefix = "g_cclosure_marshal";
			} else {
				prefix = "g_cclosure_user_marshal";
			}
		}
		
		ret = "%s_%s_".printf (prefix, get_marshaller_type_name (return_type, dbus));
		
		if (params == null || params.size == 0) {
			ret = ret + "_VOID";
		} else {
			foreach (FormalParameter p in params) {
				ret = "%s_%s".printf (ret, get_marshaller_type_name_for_parameter (p, dbus));
			}
		}
		
		return ret;
	}
	
	private string? get_value_type_name_from_type_reference (DataType t) {
		if (t is PointerType || t.type_parameter != null) {
			return "gpointer";
		} else if (t is VoidType) {
			return "void";
		} else if (t.data_type == string_type.data_type) {
			return "const char*";
		} else if (t.data_type is Class || t.data_type is Interface) {
			return "gpointer";
		} else if (t.data_type is Struct) {
			var st = (Struct) t.data_type;
			if (st.is_simple_type ()) {
				return t.data_type.get_cname ();
			} else {
				return "gpointer";
			}
		} else if (t.data_type is Enum) {
			return "gint";
		} else if (t is ArrayType) {
			return "gpointer";
		} else if (t is ErrorType) {
			return "gpointer";
		}
		
		return null;
	}
	
	private string? get_value_type_name_from_parameter (FormalParameter p) {
		if (p.direction != ParameterDirection.IN) {
			return "gpointer";
		} else {
			return get_value_type_name_from_type_reference (p.variable_type);
		}
	}
	
	private string get_marshaller_signature (List<FormalParameter> params, DataType return_type, bool dbus = false) {
		string signature;
		
		signature = "%s:".printf (get_marshaller_type_name (return_type, dbus));
		if (params == null || params.size == 0) {
			signature = signature + "VOID";
		} else {
			bool first = true;
			foreach (FormalParameter p in params) {
				if (first) {
					signature = signature + get_marshaller_type_name_for_parameter (p, dbus);
					first = false;
				} else {
					signature = "%s,%s".printf (signature, get_marshaller_type_name_for_parameter (p, dbus));
				}
			}
		}
		
		return signature;
	}

	private CCodeExpression? get_signal_name_cexpression (Signal sig, Expression? detail_expr, CodeNode node) {
		if (detail_expr == null) {
			return sig.get_canonical_cconstant ();
		}

		if (detail_expr.value_type is NullType || !detail_expr.value_type.compatible (string_type)) {
			node.error = true;
			Report.error (detail_expr.source_reference, "only string details are supported");
			return null;
		}

		if (detail_expr is StringLiteral) {
			return sig.get_canonical_cconstant (((StringLiteral) detail_expr).eval ());
		}

		var detail_decl = get_temp_variable (detail_expr.value_type, true, node);
		emit_temp_var (detail_decl);
		temp_ref_vars.insert (0, detail_decl);

		var ccall = new CCodeFunctionCall (new CCodeIdentifier ("g_strconcat"));
		ccall.add_argument (sig.get_canonical_cconstant (""));
		ccall.add_argument ((CCodeExpression) detail_expr.ccodenode);
		ccall.add_argument (new CCodeConstant ("NULL"));

		var ccomma = new CCodeCommaExpression ();
		ccomma.append_expression (new CCodeAssignment (get_variable_cexpression (detail_decl.name), ccall));
		ccomma.append_expression (get_variable_cexpression (detail_decl.name));
		return ccomma;
	}

	public override void visit_signal (Signal sig) {
		// parent_symbol may be null for dynamic signals

		var cl = sig.parent_symbol as Class;
		if (cl != null && cl.is_compact) {
			sig.error = true;
			Report.error (sig.source_reference, "Signals are not supported in compact classes");
			return;
		}

		if (cl != null) {
			foreach (DataType base_type in cl.get_base_types ()) {
				if (SemanticAnalyzer.symbol_lookup_inherited (base_type.data_type, sig.name) is Signal) {
					sig.error = true;
					Report.error (sig.source_reference, "Signals with the same name as a signal in a base type are not supported");
					return;
				}
			}
		}

		sig.accept_children (this);

		// declare parameter type
		foreach (FormalParameter p in sig.get_parameters ()) {
			generate_parameter (p, cfile, new HashMap<int,CCodeFormalParameter> (), null);
		}

		generate_marshaller (sig.get_parameters (), sig.return_type);
	}

	public override void generate_marshaller (List<FormalParameter> params, DataType return_type, bool dbus = false) {
		string signature;
		int n_params, i;
		
		/* check whether a signal with the same signature already exists for this source file (or predefined) */
		signature = get_marshaller_signature (params, return_type, dbus);
		if (predefined_marshal_set.contains (signature) || user_marshal_set.contains (signature)) {
			return;
		}
		
		var signal_marshaller = new CCodeFunction (get_marshaller_function (params, return_type, null, dbus), "void");
		signal_marshaller.modifiers = CCodeModifiers.STATIC;
		
		signal_marshaller.add_parameter (new CCodeFormalParameter ("closure", "GClosure *"));
		signal_marshaller.add_parameter (new CCodeFormalParameter ("return_value", "GValue *"));
		signal_marshaller.add_parameter (new CCodeFormalParameter ("n_param_values", "guint"));
		signal_marshaller.add_parameter (new CCodeFormalParameter ("param_values", "const GValue *"));
		signal_marshaller.add_parameter (new CCodeFormalParameter ("invocation_hint", "gpointer"));
		signal_marshaller.add_parameter (new CCodeFormalParameter ("marshal_data", "gpointer"));
		
		cfile.add_function_declaration (signal_marshaller);
		
		var marshaller_body = new CCodeBlock ();
		
		var callback_decl = new CCodeFunctionDeclarator (get_marshaller_function (params, return_type, "GMarshalFunc", dbus));
		callback_decl.add_parameter (new CCodeFormalParameter ("data1", "gpointer"));
		n_params = 1;
		foreach (FormalParameter p in params) {
			callback_decl.add_parameter (new CCodeFormalParameter ("arg_%d".printf (n_params), get_value_type_name_from_parameter (p)));
			n_params++;
			if (p.variable_type.is_array () && !dbus) {
				callback_decl.add_parameter (new CCodeFormalParameter ("arg_%d".printf (n_params), "gint"));
				n_params++;
			}
		}
		callback_decl.add_parameter (new CCodeFormalParameter ("data2", "gpointer"));
		marshaller_body.add_statement (new CCodeTypeDefinition (get_value_type_name_from_type_reference (return_type), callback_decl));
		
		var var_decl = new CCodeDeclaration (get_marshaller_function (params, return_type, "GMarshalFunc", dbus));
		var_decl.modifiers = CCodeModifiers.REGISTER;
		var_decl.add_declarator (new CCodeVariableDeclarator ("callback"));
		marshaller_body.add_statement (var_decl);
		
		var_decl = new CCodeDeclaration ("GCClosure *");
		var_decl.modifiers = CCodeModifiers.REGISTER;
		var_decl.add_declarator (new CCodeVariableDeclarator ("cc", new CCodeCastExpression (new CCodeIdentifier ("closure"), "GCClosure *")));
		marshaller_body.add_statement (var_decl);
		
		var_decl = new CCodeDeclaration ("gpointer");
		var_decl.modifiers = CCodeModifiers.REGISTER;
		var_decl.add_declarator (new CCodeVariableDeclarator ("data1"));
		var_decl.add_declarator (new CCodeVariableDeclarator ("data2"));
		marshaller_body.add_statement (var_decl);
		
		CCodeFunctionCall fc;
		
		if (return_type.data_type != null || return_type.is_array ()) {
			var_decl = new CCodeDeclaration (get_value_type_name_from_type_reference (return_type));
			var_decl.add_declarator (new CCodeVariableDeclarator ("v_return"));
			marshaller_body.add_statement (var_decl);
			
			fc = new CCodeFunctionCall (new CCodeIdentifier ("g_return_if_fail"));
			fc.add_argument (new CCodeBinaryExpression (CCodeBinaryOperator.INEQUALITY, new CCodeIdentifier ("return_value"), new CCodeConstant ("NULL")));
			marshaller_body.add_statement (new CCodeExpressionStatement (fc));
		}
		
		fc = new CCodeFunctionCall (new CCodeIdentifier ("g_return_if_fail"));
		fc.add_argument (new CCodeBinaryExpression (CCodeBinaryOperator.EQUALITY, new CCodeIdentifier ("n_param_values"), new CCodeConstant (n_params.to_string())));
		marshaller_body.add_statement (new CCodeExpressionStatement (fc));
		
		var data = new CCodeMemberAccess (new CCodeIdentifier ("closure"), "data", true);
		var param = new CCodeMemberAccess (new CCodeMemberAccess (new CCodeIdentifier ("param_values"), "data[0]", true), "v_pointer");
		var cond = new CCodeFunctionCall (new CCodeConstant ("G_CCLOSURE_SWAP_DATA"));
		cond.add_argument (new CCodeIdentifier ("closure"));
		var true_block = new CCodeBlock ();
		true_block.add_statement (new CCodeExpressionStatement (new CCodeAssignment (new CCodeIdentifier ("data1"), data)));
		true_block.add_statement (new CCodeExpressionStatement (new CCodeAssignment (new CCodeIdentifier ("data2"), param)));
		var false_block = new CCodeBlock ();
		false_block.add_statement (new CCodeExpressionStatement (new CCodeAssignment (new CCodeIdentifier ("data1"), param)));
		false_block.add_statement (new CCodeExpressionStatement (new CCodeAssignment (new CCodeIdentifier ("data2"), data)));
		marshaller_body.add_statement (new CCodeIfStatement (cond, true_block, false_block));
		
		var c_assign = new CCodeAssignment (new CCodeIdentifier ("callback"), new CCodeCastExpression (new CCodeConditionalExpression (new CCodeIdentifier ("marshal_data"), new CCodeIdentifier ("marshal_data"), new CCodeMemberAccess (new CCodeIdentifier ("cc"), "callback", true)), get_marshaller_function (params, return_type, "GMarshalFunc", dbus)));
		marshaller_body.add_statement (new CCodeExpressionStatement (c_assign));
		
		fc = new CCodeFunctionCall (new CCodeIdentifier ("callback"));
		fc.add_argument (new CCodeIdentifier ("data1"));
		i = 1;
		foreach (FormalParameter p in params) {
			string get_value_function;
			bool is_array = p.variable_type.is_array ();
			if (p.direction != ParameterDirection.IN) {
				get_value_function = "g_value_get_pointer";
			} else if (is_array) {
				if (dbus) {
					get_value_function = "g_value_get_boxed";
				} else {
					if (((ArrayType) p.variable_type).element_type.data_type == string_type.data_type) {
						get_value_function = "g_value_get_boxed";
					} else {
						get_value_function = "g_value_get_pointer";
					}
				}
			} else if (p.variable_type is PointerType || p.variable_type.type_parameter != null) {
				get_value_function = "g_value_get_pointer";
			} else if (p.variable_type is ErrorType) {
				get_value_function = "g_value_get_pointer";
			} else if (dbus && DBusModule.get_type_signature (p.variable_type).has_prefix ("(")) {
				get_value_function = "g_value_get_boxed";
			} else if (dbus && p.variable_type.data_type is Enum) {
				var en = (Enum) p.variable_type.data_type;
				if (en.is_flags) {
					get_value_function = "g_value_get_uint";
				} else {
					get_value_function = "g_value_get_int";
				}
			} else {
				get_value_function = p.variable_type.data_type.get_get_value_function ();
			}
			var inner_fc = new CCodeFunctionCall (new CCodeIdentifier (get_value_function));
			inner_fc.add_argument (new CCodeBinaryExpression (CCodeBinaryOperator.PLUS, new CCodeIdentifier ("param_values"), new CCodeIdentifier (i.to_string ())));
			fc.add_argument (inner_fc);
			i++;
			if (is_array && !dbus) {
				inner_fc = new CCodeFunctionCall (new CCodeIdentifier ("g_value_get_int"));
				inner_fc.add_argument (new CCodeBinaryExpression (CCodeBinaryOperator.PLUS, new CCodeIdentifier ("param_values"), new CCodeIdentifier (i.to_string ())));
				fc.add_argument (inner_fc);
				i++;
			}
		}
		fc.add_argument (new CCodeIdentifier ("data2"));
		
		if (return_type.data_type != null || return_type.is_array ()) {
			marshaller_body.add_statement (new CCodeExpressionStatement (new CCodeAssignment (new CCodeIdentifier ("v_return"), fc)));
			
			CCodeFunctionCall set_fc;
			if (return_type.is_array ()) {
				if (dbus) {
					set_fc = new CCodeFunctionCall (new CCodeIdentifier ("g_value_take_boxed"));
				} else {
					if (((ArrayType) return_type).element_type.data_type == string_type.data_type) {
						set_fc = new CCodeFunctionCall (new CCodeIdentifier ("g_value_take_boxed"));
					} else {
						set_fc = new CCodeFunctionCall (new CCodeIdentifier ("g_value_set_pointer"));
					}
				}
			} else if (return_type.type_parameter != null) {
				set_fc = new CCodeFunctionCall (new CCodeIdentifier ("g_value_set_pointer"));
			} else if (return_type is ErrorType) {
				set_fc = new CCodeFunctionCall (new CCodeIdentifier ("g_value_set_pointer"));
			} else if (return_type.data_type == string_type.data_type) {
				set_fc = new CCodeFunctionCall (new CCodeIdentifier ("g_value_take_string"));
			} else if (return_type.data_type is Class || return_type.data_type is Interface) {
				set_fc = new CCodeFunctionCall (new CCodeIdentifier ("g_value_take_object"));
			} else if (dbus && DBusModule.get_type_signature (return_type).has_prefix ("(")) {
				set_fc = new CCodeFunctionCall (new CCodeIdentifier ("g_value_take_boxed"));
			} else if (dbus && return_type.data_type is Enum) {
				var en = (Enum) return_type.data_type;
				if (en.is_flags) {
					set_fc = new CCodeFunctionCall (new CCodeIdentifier ("g_value_set_uint"));
				} else {
					set_fc = new CCodeFunctionCall (new CCodeIdentifier ("g_value_set_int"));
				}
			} else {
				set_fc = new CCodeFunctionCall (new CCodeIdentifier (return_type.data_type.get_set_value_function ()));
			}
			set_fc.add_argument (new CCodeIdentifier ("return_value"));
			set_fc.add_argument (new CCodeIdentifier ("v_return"));
			
			marshaller_body.add_statement (new CCodeExpressionStatement (set_fc));
		} else {
			marshaller_body.add_statement (new CCodeExpressionStatement (fc));
		}
		
		signal_marshaller.block = marshaller_body;
		
		cfile.add_function (signal_marshaller);
		user_marshal_set.add (signature);
	}

	public override CCodeFunctionCall get_signal_creation (Signal sig, TypeSymbol type) {	
		var csignew = new CCodeFunctionCall (new CCodeIdentifier ("g_signal_new"));
		var cl = sig.parent_symbol as Class;
		csignew.add_argument (new CCodeConstant ("\"%s\"".printf (sig.get_cname ())));
		csignew.add_argument (new CCodeIdentifier (type.get_type_id ()));
		string[] flags = new string[0];
		if (sig.run_type == "first") {
			flags += "G_SIGNAL_RUN_FIRST";
		} else if (sig.run_type == "cleanup") {
			flags += "G_SIGNAL_RUN_CLEANUP";
		} else {
			flags += "G_SIGNAL_RUN_LAST";
		}
		if (sig.is_detailed) {
			flags += "G_SIGNAL_DETAILED";
		}

		if (sig.no_recurse) {
			flags += "G_SIGNAL_NO_RECURSE";
		}

		if (sig.is_action) {
			flags += "G_SIGNAL_ACTION";
		}

		if (sig.no_hooks) {
			flags += "G_SIGNAL_NO_HOOKS";
		}

		csignew.add_argument (new CCodeConstant (string.joinv (" | ", flags)));

		if (sig.default_handler == null) {
			csignew.add_argument (new CCodeConstant ("0"));
		} else {
			var struct_offset = new CCodeFunctionCall (new CCodeIdentifier ("G_STRUCT_OFFSET"));
			struct_offset.add_argument (new CCodeIdentifier ("%sClass".printf (cl.get_cname ())));
			struct_offset.add_argument (new CCodeIdentifier (sig.default_handler.vfunc_name));
			csignew.add_argument (struct_offset);
		}
		csignew.add_argument (new CCodeConstant ("NULL"));
		csignew.add_argument (new CCodeConstant ("NULL"));

		string marshaller = get_marshaller_function (sig.get_parameters (), sig.return_type);

		var marshal_arg = new CCodeIdentifier (marshaller);
		csignew.add_argument (marshal_arg);

		var params = sig.get_parameters ();
		if (sig.return_type is PointerType || sig.return_type.type_parameter != null) {
			csignew.add_argument (new CCodeConstant ("G_TYPE_POINTER"));
		} else if (sig.return_type is ErrorType) {
			csignew.add_argument (new CCodeConstant ("G_TYPE_POINTER"));
		} else if (sig.return_type.data_type == null) {
			csignew.add_argument (new CCodeConstant ("G_TYPE_NONE"));
		} else {
			csignew.add_argument (new CCodeConstant (sig.return_type.data_type.get_type_id ()));
		}

		int params_len = 0;
		foreach (FormalParameter param in params) {
			params_len++;
			if (param.variable_type.is_array ()) {
				params_len++;
			}
		}

		csignew.add_argument (new CCodeConstant ("%d".printf (params_len)));
		foreach (FormalParameter param in params) {
			if (param.variable_type.is_array ()) {
				if (((ArrayType) param.variable_type).element_type.data_type == string_type.data_type) {
					csignew.add_argument (new CCodeConstant ("G_TYPE_STRV"));
				} else {
					csignew.add_argument (new CCodeConstant ("G_TYPE_POINTER"));
				}
				csignew.add_argument (new CCodeConstant ("G_TYPE_INT"));
			} else if (param.variable_type is PointerType || param.variable_type.type_parameter != null || param.direction != ParameterDirection.IN) {
				csignew.add_argument (new CCodeConstant ("G_TYPE_POINTER"));
			} else if (param.variable_type is ErrorType) {
				csignew.add_argument (new CCodeConstant ("G_TYPE_POINTER"));
			} else {
				csignew.add_argument (new CCodeConstant (param.variable_type.data_type.get_type_id ()));
			}
		}

		marshal_arg.name = marshaller;

		return csignew;
	}

	public virtual CCodeExpression get_dbus_g_type (DataType data_type) {
		return new CCodeConstant (data_type.data_type.get_type_id ());
	}

	public override void visit_element_access (ElementAccess expr) {
		if (expr.container is MemberAccess && expr.container.symbol_reference is Signal) {
			// detailed signal emission
			var sig = (Signal) expr.symbol_reference;
			var ma = (MemberAccess) expr.container;

			var detail_expr = expr.get_indices ().get (0);
			var signal_name_cexpr = get_signal_name_cexpression (sig, detail_expr, expr);
			
			var ccall = new CCodeFunctionCall (new CCodeIdentifier ("g_signal_emit_by_name"));
			ccall.add_argument ((CCodeExpression) ma.inner.ccodenode);
			if (signal_name_cexpr != null) {
				ccall.add_argument (signal_name_cexpr);
			}
			expr.ccodenode = ccall;
		} else {
			base.visit_element_access (expr);
		}
	}

	bool in_gobject_instance (Method m) {
		bool result = false;
		if (m.binding == MemberBinding.INSTANCE) {
			result = m.this_parameter.variable_type.data_type.is_subtype_of (gobject_type);
		}
		return result;
	}

	CCodeExpression? emit_signal_assignment (Assignment assignment) {
		var sig = (Signal) assignment.left.symbol_reference;

		bool disconnect = false;

		if (assignment.operator == AssignmentOperator.ADD) {
			// connect
		} else if (assignment.operator == AssignmentOperator.SUB) {
			// disconnect
			disconnect = true;
		} else {
			assignment.error = true;
			Report.error (assignment.source_reference, "Specified compound assignment type for signals not supported.");
			return null;
		}

		return connect_signal (sig, assignment.left, assignment.right, disconnect, false, assignment);
	}

	public override void visit_assignment (Assignment assignment) {
		if (assignment.left.symbol_reference is Signal) {
			if (assignment.left.error || assignment.right.error) {
				assignment.error = true;
				return;
			}

			assignment.ccodenode = emit_signal_assignment (assignment);
		} else {
			base.visit_assignment (assignment);
		}
	}

	public override void visit_member_access (MemberAccess expr) {
		if (expr.symbol_reference is Signal) {
			CCodeExpression pub_inst = null;
	
			if (expr.inner != null) {
				pub_inst = (CCodeExpression) expr.inner.ccodenode;
			}

			var sig = (Signal) expr.symbol_reference;
			var cl = (TypeSymbol) sig.parent_symbol;
			
			if (expr.inner is BaseAccess && sig.is_virtual) {
				var m = sig.default_handler;
				var base_class = (Class) m.parent_symbol;
				var vcast = new CCodeFunctionCall (new CCodeIdentifier ("%s_CLASS".printf (base_class.get_upper_case_cname (null))));
				vcast.add_argument (new CCodeIdentifier ("%s_parent_class".printf (current_class.get_lower_case_cname (null))));
				
				expr.ccodenode = new CCodeMemberAccess.pointer (vcast, m.name);
				return;
			}

			if (sig.has_emitter) {
				var ccall = new CCodeFunctionCall (new CCodeIdentifier ("%s_%s".printf (cl.get_lower_case_cname (null), sig.name)));

				ccall.add_argument (pub_inst);
				expr.ccodenode = ccall;
			} else {
				var ccall = new CCodeFunctionCall (new CCodeIdentifier ("g_signal_emit_by_name"));
				ccall.add_argument (pub_inst);

				ccall.add_argument (sig.get_canonical_cconstant ());
				
				expr.ccodenode = ccall;
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

		expr.ccodenode = connect_signal (sig, signal_access, handler, disconnect, after, expr);
	}

	CCodeExpression? connect_signal (Signal sig, Expression signal_access, Expression handler, bool disconnect, bool after, CodeNode expr) {
		string connect_func;

		var m = (Method) handler.symbol_reference;

		if (!disconnect) {
			// connect
			if (sig is DynamicSignal) {
				if (!after)
					connect_func = get_dynamic_signal_connect_wrapper_name ((DynamicSignal) sig);
				else
					connect_func = get_dynamic_signal_connect_after_wrapper_name ((DynamicSignal) sig);
			} else {
				if (m.closure) {
					connect_func = "g_signal_connect_data";
				} else if (in_gobject_instance (m)) {
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
			if (signal_name_cexpr == null) {
				return null;
			}
		} else {
			ma = (MemberAccess) signal_access;
			signal_name_cexpr = get_signal_name_cexpression (sig, null, expr);
		}
		if (ma.inner != null) {
			ccall.add_argument ((CCodeExpression) get_ccodenode (ma.inner));
		} else {
			ccall.add_argument (get_result_cexpression ("self"));
		}

		CCodeCommaExpression? ccomma = null;

		if (sig is DynamicSignal) {
			// dynamic_signal_connect or dynamic_signal_disconnect

			// second argument: signal name
			ccall.add_argument (new CCodeConstant ("\"%s\"".printf (sig.name)));
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
			ccomma = new CCodeCommaExpression ();
			var temp_decl = get_temp_variable (uint_type);
			emit_temp_var (temp_decl);
			var parse_call = new CCodeFunctionCall (new CCodeIdentifier ("g_signal_parse_name"));
			parse_call.add_argument (signal_name_cexpr);
			var decl_type = (TypeSymbol) sig.parent_symbol;
			parse_call.add_argument (new CCodeIdentifier (decl_type.get_type_id ()));
			parse_call.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, get_variable_cexpression (temp_decl.name)));
			LocalVariable? detail_temp_decl = null;
			if (!(signal_access is ElementAccess)) {
				parse_call.add_argument (new CCodeConstant ("NULL"));
				parse_call.add_argument (new CCodeConstant ("FALSE"));
			} else {
				detail_temp_decl = get_temp_variable (gquark_type);
				emit_temp_var (detail_temp_decl);
				parse_call.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, new CCodeIdentifier (detail_temp_decl.name)));
				parse_call.add_argument (new CCodeConstant ("TRUE"));
			}
			ccomma.append_expression (parse_call);

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
		ccall.add_argument (new CCodeCastExpression ((CCodeExpression) handler.ccodenode, "GCallback"));

		if (m.closure) {
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
		} else if (m.binding == MemberBinding.INSTANCE) {
			// g_signal_connect_object or g_signal_handlers_disconnect_matched
			// or dynamic_signal_connect or dynamic_signal_disconnect

			// fourth resp. seventh argument: object/user_data
			if (handler is MemberAccess) {
				var right_ma = (MemberAccess) handler;
				if (right_ma.inner != null) {
					ccall.add_argument ((CCodeExpression) right_ma.inner.ccodenode);
				} else {
					ccall.add_argument (get_result_cexpression ("self"));
				}
			} else if (handler is LambdaExpression) {
				ccall.add_argument (get_result_cexpression ("self"));
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
		} else {
			// g_signal_connect or g_signal_connect_after or g_signal_handlers_disconnect_matched
			// or dynamic_signal_connect or dynamic_signal_disconnect

			// fourth resp. seventh argument: user_data
			ccall.add_argument (new CCodeConstant ("NULL"));
		}

		if (ccomma != null) {
			ccomma.append_expression (ccall);
			return ccomma;
		} else {
			return ccall;
		}
	}
}

