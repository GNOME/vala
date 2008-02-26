/* valaccodegeneratorinvocationexpression.vala
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

public class Vala.CCodeGenerator {
	public override void visit_invocation_expression (InvocationExpression! expr) {
		expr.accept_children (this);

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
		
		var itype = expr.call.static_type;
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
			var array = (Array) m.parent_symbol;
			carg_map.set (get_param_pos (0), new CCodeIdentifier (array.get_cname ()));
		} else if (m is ArrayMoveMethod) {
			requires_array_move = true;
		}

		CCodeExpression instance;
		if (m != null && m.instance) {
			var base_method = m;
			if (m.base_interface_method != null) {
				base_method = m.base_interface_method;
			} else if (m.base_method != null) {
				base_method = m.base_method;
			}

			DataType instance_expression_type;
			if (ma.inner == null) {
				instance = new CCodeIdentifier ("self");
				instance_expression_type = new DataType ();
				instance_expression_type.data_type = current_type_symbol;
			} else {
				instance = (CCodeExpression) ma.inner.ccodenode;
				instance_expression_type = ma.inner.static_type;
			}

			if (instance_expression_type.data_type is Struct && !((Struct) instance_expression_type.data_type).is_simple_type () && instance_expression_type.data_type != current_type_symbol) {
				instance = new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, instance);
			}

			// parent_symbol may be null for late bound methods
			if (base_method.parent_symbol != null) {
				var instance_target_type = new DataType ();
				instance_target_type.data_type = (Typesymbol) base_method.parent_symbol;
				instance = get_implicit_cast_expression (instance, instance_expression_type, instance_target_type);
			}

			carg_map.set (get_param_pos (m.cinstance_parameter_position), instance);
		}

		if (m is ArrayMoveMethod) {
			var array = (Array) m.parent_symbol;
			var csizeof = new CCodeFunctionCall (new CCodeIdentifier ("sizeof"));
			csizeof.add_argument (new CCodeIdentifier (array.get_cname ()));
			carg_map.set (get_param_pos (0.1), csizeof);
		} else if (m is DBusMethod) {
			bool found_out = false;
			Expression callback = null;
			foreach (Expression arg in expr.get_argument_list ()) {
				if (arg.symbol_reference is Method) {
					// callback
					if (callback != null) {
						Report.error (expr.source_reference, "only one reply callback may be specified in invocation of DBus method");
						expr.error = true;
						return;
					} else if (found_out) {
						Report.error (expr.source_reference, "out argument and reply callback conflict in invocation of DBus method");
						expr.error = true;
						return;
					}
					callback = arg;
				} else if (arg is UnaryExpression && ((UnaryExpression) arg).operator == UnaryOperator.OUT) {
					// out arg
					if (callback != null) {
						Report.error (expr.source_reference, "out argument and reply callback conflict in invocation of DBus method");
						expr.error = true;
						return;
					}
					found_out = true;
				} else {
					// in arg
					if (callback != null || found_out) {
						Report.error (expr.source_reference, "in argument must not follow out argument or reply callback in invocation of DBus method");
						expr.error = true;
						return;
					}
				}
			}

			carg_map.set (get_param_pos (0.1), new CCodeConstant ("\"%s\"".printf (m.name)));

			if (callback != null) {
				var reply_method = (Method) callback.symbol_reference;

				var cb_fun = new CCodeFunction ("_%s_cb".printf (reply_method.get_cname ()), "void");
				cb_fun.modifiers = CCodeModifiers.STATIC;
				cb_fun.add_parameter (new CCodeFormalParameter ("proxy", "DBusGProxy*"));
				cb_fun.add_parameter (new CCodeFormalParameter ("call", "DBusGProxyCall*"));
				cb_fun.add_parameter (new CCodeFormalParameter ("user_data", "void*"));
				cb_fun.block = new CCodeBlock ();
				var cerrdecl = new CCodeDeclaration ("GError*");
				cerrdecl.add_declarator (new CCodeVariableDeclarator.with_initializer ("error", new CCodeConstant ("NULL")));
				cb_fun.block.add_statement (cerrdecl);
				var cend_call = new CCodeFunctionCall (new CCodeIdentifier ("dbus_g_proxy_end_call"));
				cend_call.add_argument (new CCodeIdentifier ("proxy"));
				cend_call.add_argument (new CCodeIdentifier ("call"));
				cend_call.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, new CCodeIdentifier ("error")));
				var creply_call = new CCodeFunctionCall ((CCodeExpression) callback.ccodenode);
				creply_call.add_argument (new CCodeIdentifier ("user_data"));
				int param_count = reply_method.get_parameters ().size;
				int i = 0;
				foreach (FormalParameter param in reply_method.get_parameters ()) {
					if ((++i) == param_count) {
						// error parameter
						break;
					}
					if (param.type_reference is ArrayType && ((ArrayType) param.type_reference).element_type.data_type != string_type.data_type) {
						var array_type = (ArrayType) param.type_reference;
						var cdecl = new CCodeDeclaration ("GArray*");
						cdecl.add_declarator (new CCodeVariableDeclarator (param.name));
						cb_fun.block.add_statement (cdecl);
						cend_call.add_argument (get_dbus_array_type (array_type));
						cend_call.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, new CCodeIdentifier (param.name)));
						creply_call.add_argument (new CCodeMemberAccess.pointer (new CCodeIdentifier (param.name), "data"));
						creply_call.add_argument (new CCodeMemberAccess.pointer (new CCodeIdentifier (param.name), "len"));
					} else {
						var cdecl = new CCodeDeclaration (param.type_reference.get_cname ());
						cdecl.add_declarator (new CCodeVariableDeclarator (param.name));
						cb_fun.block.add_statement (cdecl);
						cend_call.add_argument (new CCodeIdentifier (param.type_reference.data_type.get_type_id ()));
						cend_call.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, new CCodeIdentifier (param.name)));
						if (param.type_reference is ArrayType && ((ArrayType) param.type_reference).element_type.data_type == string_type.data_type) {
							// special case string array
							var cstrvlen = new CCodeFunctionCall (new CCodeIdentifier ("g_strv_length"));
							cstrvlen.add_argument (new CCodeIdentifier (param.name));
							creply_call.add_argument (cstrvlen);
						}
						creply_call.add_argument (new CCodeIdentifier (param.name));
					}
				}
				cend_call.add_argument (new CCodeIdentifier ("G_TYPE_INVALID"));
				cb_fun.block.add_statement (new CCodeExpressionStatement (cend_call));
				creply_call.add_argument (new CCodeIdentifier ("error"));
				cb_fun.block.add_statement (new CCodeExpressionStatement (creply_call));
				source_type_member_definition.append (cb_fun);

				carg_map.set (get_param_pos (0.2), new CCodeIdentifier (cb_fun.name));
				carg_map.set (get_param_pos (0.3), new CCodeConstant ("self"));
				carg_map.set (get_param_pos (0.4), new CCodeConstant ("NULL"));
			} else if (found_out || m.return_type.data_type != null) {
				ccall.call = new CCodeIdentifier ("dbus_g_proxy_call");

				// method can fail
				current_method_inner_error = true;
				carg_map.set (get_param_pos (0.2), new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, new CCodeIdentifier ("inner_error")));
			} else {
				ccall.call = new CCodeIdentifier ("dbus_g_proxy_call_no_reply");
			}
		}

		bool ellipsis = false;
		
		int i = 1;
		int arg_pos;
		Iterator<FormalParameter> params_it = params.iterator ();
		foreach (Expression arg in expr.get_argument_list ()) {
			if (m is DBusMethod) {
				if (arg.symbol_reference is Method) {
					// callback parameter
					break;
				}
				
				carg_map.set (get_param_pos (i - 0.1, true), new CCodeIdentifier (arg.static_type.data_type.get_type_id ()));
			}

			CCodeExpression cexpr = (CCodeExpression) arg.ccodenode;
			Gee.List<CCodeExpression> extra_args = new ArrayList<CCodeExpression> ();
			if (params_it.next ()) {
				var param = params_it.get ();
				ellipsis = param.ellipsis;
				if (!ellipsis) {
					if (!param.no_array_length && param.type_reference is ArrayType) {
						var array_type = (ArrayType) param.type_reference;
						for (int dim = 1; dim <= array_type.rank; dim++) {
							carg_map.set (get_param_pos (param.carray_length_parameter_position + 0.01 * dim), get_array_length_cexpression (arg, dim));
						}
					} else if (param.type_reference is DelegateType) {
						var deleg_type = (DelegateType) param.type_reference;
						var d = deleg_type.delegate_symbol;
						if (d.instance) {
							carg_map.set (get_param_pos (param.cdelegate_target_parameter_position), get_delegate_target_cexpression (arg));
						}
					}
					cexpr = get_implicit_cast_expression (cexpr, arg.static_type, param.type_reference);

					// pass non-simple struct instances always by reference
					if (!(arg.static_type is NullType) && param.type_reference.data_type is Struct && !((Struct) param.type_reference.data_type).is_simple_type ()) {
						// we already use a reference for arguments of ref and out parameters
						if (!param.type_reference.is_ref && !param.type_reference.is_out) {
							cexpr = new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, cexpr);
						}
					}

					// unref old value for non-null non-weak out arguments
					if (param.type_reference.is_out && param.type_reference.takes_ownership && !(arg.static_type is NullType)) {
						var unary = (UnaryExpression) arg;

						// (ret_tmp = call (&tmp), free (var1), var1 = tmp, ret_tmp)
						var ccomma = new CCodeCommaExpression ();

						var temp_decl = get_temp_variable_declarator (unary.inner.static_type);
						temp_vars.insert (0, temp_decl);
						cexpr = new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, new CCodeIdentifier (temp_decl.name));

						// call function
						VariableDeclarator ret_temp_decl;
						if (m.return_type is VoidType) {
							ccomma.append_expression (ccall_expr);
						} else {
							ret_temp_decl = get_temp_variable_declarator (m.return_type);
							temp_vars.insert (0, ret_temp_decl);
							ccomma.append_expression (new CCodeAssignment (new CCodeIdentifier (ret_temp_decl.name), ccall_expr));
						}

						// unref old value
						ccomma.append_expression (get_unref_expression ((CCodeExpression) unary.inner.ccodenode, arg.static_type, arg));

						// assign new value
						ccomma.append_expression (new CCodeAssignment ((CCodeExpression) unary.inner.ccodenode, new CCodeIdentifier (temp_decl.name)));

						// return value
						if (!(m.return_type is VoidType)) {
							ccomma.append_expression (new CCodeIdentifier (ret_temp_decl.name));
						}

						ccall_expr = ccomma;
					}
				}
				arg_pos = get_param_pos (param.cparameter_position, ellipsis);
			} else {
				// default argument position
				arg_pos = get_param_pos (i, ellipsis);
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
			param.default_expression.accept (this);
		
			if (!param.no_array_length && param.type_reference != null &&
			    param.type_reference is ArrayType) {
				var array_type = (ArrayType) param.type_reference;
				for (int dim = 1; dim <= array_type.rank; dim++) {
					carg_map.set (get_param_pos (param.carray_length_parameter_position + 0.01 * dim), get_array_length_cexpression (param.default_expression, dim));
				}
			}

			carg_map.set (get_param_pos (param.cparameter_position), (CCodeExpression) param.default_expression.ccodenode);
			i++;
		}

		/* add length argument for methods returning arrays */
		if (m != null && m.return_type is ArrayType && !(m is DBusMethod)) {
			var array_type = (ArrayType) m.return_type;
			for (int dim = 1; dim <= array_type.rank; dim++) {
				if (!m.no_array_length) {
					var temp_decl = get_temp_variable_declarator (int_type);
					var temp_ref = new CCodeIdentifier (temp_decl.name);

					temp_vars.insert (0, temp_decl);

					carg_map.set (get_param_pos (m.carray_length_parameter_position + 0.01 * dim), new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, temp_ref));

					expr.append_array_size (temp_ref);
				} else {
					expr.append_array_size (new CCodeConstant ("-1"));
				}
			}
		} else if (m != null && m.return_type is DelegateType) {
			var deleg_type = (DelegateType) m.return_type;
			var d = deleg_type.delegate_symbol;
			if (d.instance) {
				var temp_decl = get_temp_variable_declarator (new PointerType (new VoidType ()));
				var temp_ref = new CCodeIdentifier (temp_decl.name);

				temp_vars.insert (0, temp_decl);

				carg_map.set (get_param_pos (m.cdelegate_target_parameter_position), new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, temp_ref));

				expr.delegate_target = temp_ref;
			}
		}

		if (connection_type != null && ma.inner != null && ma.inner.static_type != null && ma.inner.static_type.data_type == connection_type && m.name == "get_object") {
			var dbus_iface = (Interface) m.return_type.data_type;
			var dbus_attr = dbus_iface.get_attribute ("DBusInterface");
			carg_map.set (get_param_pos (-1), new CCodeConstant ("\"%s\"".printf (dbus_attr.get_string ("name"))));
		} else if (m is DBusMethod) {
			carg_map.set (get_param_pos (-1, true), new CCodeIdentifier ("G_TYPE_INVALID"));
		}

		if (expr.can_fail && !(m is DBusMethod)) {
			// method can fail
			current_method_inner_error = true;
			// add &inner_error before the ellipsis arguments
			carg_map.set (get_param_pos (-2), new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, new CCodeIdentifier ("inner_error")));
		}

		if (ellipsis) {
			/* ensure variable argument list ends with NULL
			 * except when using printf-style arguments */
			if ((m == null || !m.printf_format) && !(m is DBusMethod)) {
				carg_map.set (get_param_pos (-1, true), new CCodeConstant (m.sentinel));
			}
		} else if (itype is DelegateType) {
			var deleg_type = (DelegateType) itype;
			var d = deleg_type.delegate_symbol;
			if (d.instance) {
				carg_map.set (get_param_pos (d.cinstance_parameter_position), get_delegate_target_cexpression (expr.call));
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

		if (m != null && m.instance && m.returns_modified_pointer) {
			expr.ccodenode = new CCodeAssignment (instance, ccall_expr);
		} else {
			/* cast pointer to actual type if this is a generic method return value */
			if (m != null && m.return_type.type_parameter != null && expr.static_type.data_type != null) {
				expr.ccodenode = convert_from_generic_pointer (ccall_expr, expr.static_type);
			} else {
				expr.ccodenode = ccall_expr;
			}
		
			visit_expression (expr);
		}
		
		if (m is ArrayResizeMethod) {
			// FIXME: size expression must not be evaluated twice at runtime (potential side effects)
			Iterator<Expression> arg_it = expr.get_argument_list ().iterator ();
			arg_it.next ();
			var new_size = (CCodeExpression) arg_it.get ().ccodenode;

			var temp_decl = get_temp_variable_declarator (int_type);
			var temp_ref = new CCodeIdentifier (temp_decl.name);

			temp_vars.insert (0, temp_decl);

			/* memset needs string.h */
			string_h_needed = true;

			var clen = get_array_length_cexpression (ma.inner, 1);
			var celems = (CCodeExpression) ma.inner.ccodenode;
			var csizeof = new CCodeIdentifier ("sizeof (%s)".printf (ma.inner.static_type.data_type.get_cname ()));
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
			ccomma.append_expression (new CCodeAssignment (get_array_length_cexpression (ma.inner, 1), temp_ref));

			expr.ccodenode = ccomma;
		} else if (m == substring_method) {
			var temp_decl = get_temp_variable_declarator (string_type);
			var temp_ref = new CCodeIdentifier (temp_decl.name);

			temp_vars.insert (0, temp_decl);

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
		} else if (m is DBusMethod && m.return_type.data_type != null) {
			// synchronous D-Bus method call with reply
			if (m.return_type is ArrayType && ((ArrayType) m.return_type).element_type.data_type != string_type.data_type) {
				var array_type = (ArrayType) m.return_type;

				ccall.add_argument (get_dbus_array_type (array_type));

				var garray_type_reference = new DataType ();
				garray_type_reference.data_type = garray_type;
				var temp_decl = get_temp_variable_declarator (garray_type_reference);
				temp_vars.insert (0, temp_decl);
				ccall.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, new CCodeIdentifier (temp_decl.name)));

				ccall.add_argument (new CCodeIdentifier ("G_TYPE_INVALID"));

				var ccomma = new CCodeCommaExpression ();
				ccomma.append_expression (ccall);
				ccomma.append_expression (new CCodeMemberAccess.pointer (new CCodeIdentifier (temp_decl.name), "data"));
				expr.ccodenode = ccomma;

				if (!m.no_array_length) {
					expr.append_array_size (new CCodeMemberAccess.pointer (new CCodeIdentifier (temp_decl.name), "len"));
				} else {
					expr.append_array_size (new CCodeConstant ("-1"));
				}
			} else {
				ccall.add_argument (new CCodeIdentifier (m.return_type.data_type.get_type_id ()));

				var temp_decl = get_temp_variable_declarator (m.return_type);
				temp_vars.insert (0, temp_decl);
				ccall.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, new CCodeIdentifier (temp_decl.name)));

				ccall.add_argument (new CCodeIdentifier ("G_TYPE_INVALID"));

				var ccomma = new CCodeCommaExpression ();
				ccomma.append_expression (ccall);
				ccomma.append_expression (new CCodeIdentifier (temp_decl.name));
				expr.ccodenode = ccomma;

				if (m.return_type is ArrayType && ((ArrayType) m.return_type).element_type.data_type == string_type.data_type) {
					// special case string array
					if (!m.no_array_length) {
						var cstrvlen = new CCodeFunctionCall (new CCodeIdentifier ("g_strv_length"));
						cstrvlen.add_argument (new CCodeIdentifier (temp_decl.name));
						expr.append_array_size (cstrvlen);
					} else {
						expr.append_array_size (new CCodeConstant ("-1"));
					}
				}
			}
		}
	}

	private CCodeExpression! get_dbus_array_type (ArrayType array_type) {
		var carray_type = new CCodeFunctionCall (new CCodeIdentifier ("dbus_g_type_get_collection"));
		carray_type.add_argument (new CCodeConstant ("\"GArray\""));
		carray_type.add_argument (new CCodeIdentifier (array_type.element_type.data_type.get_type_id ()));
		return carray_type;
	}

	public int get_param_pos (double param_pos, bool ellipsis = false) {
		if (!ellipsis) {
			if (param_pos >= 0) {
				return (int) (param_pos * 1000);
			} else {
				return (int) ((100 + param_pos) * 1000);
			}
		} else {
			if (param_pos >= 0) {
				return (int) ((100 + param_pos) * 1000);
			} else {
				return (int) ((200 + param_pos) * 1000);
			}
		}
	}
}

