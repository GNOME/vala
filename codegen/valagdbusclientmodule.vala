/* valagdbusclientmodule.vala
 *
 * Copyright (C) 2010-2011  Jürg Billeter
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
 * 	Philip Van Hoof <pvanhoof@gnome.org>
 */

public class Vala.GDBusClientModule : GDBusModule {
	CCodeExpression get_interface_info (ObjectTypeSymbol sym) {
		return new CCodeIdentifier ("_" + get_ccode_lower_case_prefix (sym) + "dbus_interface_info");
	}

	public override void generate_dynamic_method_wrapper (DynamicMethod method) {
		var dynamic_method = (DynamicMethod) method;

		var func = new CCodeFunction (get_ccode_name (method));
		func.modifiers = CCodeModifiers.STATIC;

		var cparam_map = new HashMap<int,CCodeParameter> (direct_hash, direct_equal);

		generate_cparameters (method, cfile, cparam_map, func);

		push_function (func);

		if (dynamic_method.dynamic_type.data_type == dbus_proxy_type) {
			//generate_marshalling (method, CallType.SYNC, null, method.name, -1);
		} else {
			Report.error (method.source_reference, "dynamic methods are not supported for `%s'".printf (dynamic_method.dynamic_type.to_string ()));
		}

		pop_function ();

		cfile.add_function_declaration (func);
		cfile.add_function (func);
	}

	public override void visit_method_call (MethodCall expr) {
		var mtype = expr.call.value_type as MethodType;
		bool bus_get_proxy_async = (mtype != null && get_ccode_name (mtype.method_symbol) == "g_bus_get_proxy");
		bool bus_get_proxy_sync = (mtype != null && get_ccode_name (mtype.method_symbol) == "g_bus_get_proxy_sync");
		bool conn_get_proxy_async = (mtype != null && get_ccode_name (mtype.method_symbol) == "g_dbus_connection_get_proxy");
		bool conn_get_proxy_sync = (mtype != null && get_ccode_name (mtype.method_symbol) == "g_dbus_connection_get_proxy_sync");
		if (!bus_get_proxy_async && !bus_get_proxy_sync && !conn_get_proxy_async && !conn_get_proxy_sync) {
			base.visit_method_call (expr);
			return;
		}

		var ma = (MemberAccess) expr.call;
		var type_arg = ma.get_type_arguments ().get (0);

		CCodeExpression proxy_type;
		CCodeExpression dbus_iface_name;
		CCodeExpression dbus_iface_info;

		var object_type = type_arg as ObjectType;
		if (object_type != null) {
			var iface = (Interface) object_type.type_symbol;

			if (get_dbus_name (iface) == null) {
				Report.error (expr.source_reference, "`%s' is not a D-Bus interface".printf (iface.get_full_name ()));
				return;
			}

			var proxy_class = (Class) CodeBuilder.symbol_from_string (iface.name + "Proxy", iface.parent_symbol);
			generate_class_declaration (proxy_class, cfile);

			proxy_type = new CCodeIdentifier (get_ccode_type_id (proxy_class));
			dbus_iface_name = new CCodeConstant ("\"%s\"".printf (get_dbus_name (iface)));
		} else {
			// use runtime type information for generic methods

			var quark = new CCodeFunctionCall (new CCodeIdentifier ("g_quark_from_static_string"));
			quark.add_argument (new CCodeConstant ("\"vala-dbus-proxy-type\""));

			var get_qdata = new CCodeFunctionCall (new CCodeIdentifier ("g_type_get_qdata"));
			get_qdata.add_argument (get_type_id_expression (type_arg));
			get_qdata.add_argument (quark);

			proxy_type = new CCodeFunctionCall (new CCodeCastExpression (get_qdata, "GType (*) (void)"));

			quark = new CCodeFunctionCall (new CCodeIdentifier ("g_quark_from_static_string"));
			quark.add_argument (new CCodeConstant ("\"vala-dbus-interface-name\""));

			get_qdata = new CCodeFunctionCall (new CCodeIdentifier ("g_type_get_qdata"));
			get_qdata.add_argument (get_type_id_expression (type_arg));
			get_qdata.add_argument (quark);

			dbus_iface_name = get_qdata;
		}

		var quark = new CCodeFunctionCall (new CCodeIdentifier ("g_quark_from_static_string"));
		quark.add_argument (new CCodeConstant ("\"vala-dbus-interface-info\""));

		var get_qdata = new CCodeFunctionCall (new CCodeIdentifier ("g_type_get_qdata"));
		get_qdata.add_argument (get_type_id_expression (type_arg));
		get_qdata.add_argument (quark);

		dbus_iface_info = get_qdata;

		if (bus_get_proxy_async || conn_get_proxy_async) {
			if (ma.member_name == "end" && ma.inner.symbol_reference == ma.symbol_reference) {
				// method can fail
				current_method_inner_error = true;

				var args = expr.get_argument_list ();
				Expression res = args.get (0);

				var source_var = get_temp_variable (expr.value_type, expr.value_type.value_owned);
				var source_ref = get_variable_cexpression (source_var.name);
				emit_temp_var (source_var);
				var source = new CCodeFunctionCall (new CCodeIdentifier ("g_async_result_get_source_object"));
				source.add_argument (get_cvalue (res));
				ccode.add_assignment (source_ref, source);

				var ccall = new CCodeFunctionCall (new CCodeIdentifier ("g_async_initable_new_finish"));
				ccall.add_argument (new CCodeCastExpression (source_ref, "GAsyncInitable *"));
				ccall.add_argument (get_cvalue (res));
				ccall.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, get_inner_error_cexpression ()));

				var temp_var = get_temp_variable (expr.value_type, expr.value_type.value_owned);
				var temp_ref = get_variable_cexpression (temp_var.name);
				emit_temp_var (temp_var);
				ccode.add_assignment (temp_ref, new CCodeCastExpression (ccall, get_ccode_name (expr.value_type)));

				// g_async_result_get_source_object transfers ownership, unref after use
				var unref_proxy = new CCodeFunctionCall (new CCodeIdentifier ("g_object_unref"));
				unref_proxy.add_argument (source_ref);
				ccode.add_expression (unref_proxy);

				set_cvalue (expr, temp_ref);

				return;
			}
		}

		var base_arg_index = 0;
		if (bus_get_proxy_async || bus_get_proxy_sync)
			base_arg_index = 1;

		var args = expr.get_argument_list ();
		Expression name = args.get (base_arg_index + 0);
		Expression object_path = args.get (base_arg_index + 1);
		Expression flags = args.get (base_arg_index + 2);
		Expression cancellable = args.get (base_arg_index + 3);

		// method can fail
		current_method_inner_error = true;

		CCodeFunctionCall ccall;
		if (bus_get_proxy_async || conn_get_proxy_async) {
			ccall = new CCodeFunctionCall (new CCodeIdentifier ("g_async_initable_new_async"));
		} else {
			ccall = new CCodeFunctionCall (new CCodeIdentifier ("g_initable_new"));
		}
		ccall.add_argument (proxy_type);
		if (bus_get_proxy_async || conn_get_proxy_async) {
			// I/O priority
			ccall.add_argument (new CCodeConstant ("0"));
		}
		ccall.add_argument (get_cvalue (cancellable));
		if (bus_get_proxy_async || conn_get_proxy_async) {
			if (expr.is_yield_expression) {
				// asynchronous call
				ccall.add_argument (new CCodeIdentifier (generate_ready_function (current_method)));
				ccall.add_argument (new CCodeIdentifier ("_data_"));
			} else {
				// begin
				Expression callback = args.get (base_arg_index + 4);
				ccall.add_argument (get_cvalue (callback));
				ccall.add_argument (get_delegate_target (callback));
			}
		} else {
			ccall.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, get_inner_error_cexpression ()));
		}
		ccall.add_argument (new CCodeConstant ("\"g-flags\""));
		ccall.add_argument (get_cvalue (flags));
		ccall.add_argument (new CCodeConstant ("\"g-name\""));
		ccall.add_argument (get_cvalue (name));
		if (bus_get_proxy_async || bus_get_proxy_sync) {
			Expression bus_type = args.get (0);
			ccall.add_argument (new CCodeConstant ("\"g-bus-type\""));
			ccall.add_argument (get_cvalue (bus_type));
		} else {
			Expression connection = ma.inner;
			if (ma.member_name == "begin" && ma.inner.symbol_reference == ma.symbol_reference) {
				var inner_ma = (MemberAccess) ma.inner;
				connection = inner_ma.inner;
			}
			ccall.add_argument (new CCodeConstant ("\"g-connection\""));
			ccall.add_argument (get_cvalue (connection));
		}
		ccall.add_argument (new CCodeConstant ("\"g-object-path\""));
		ccall.add_argument (get_cvalue (object_path));
		ccall.add_argument (new CCodeConstant ("\"g-interface-name\""));
		ccall.add_argument (dbus_iface_name);
		if (dbus_iface_info != null) {
			ccall.add_argument (new CCodeConstant ("\"g-interface-info\""));
			ccall.add_argument (dbus_iface_info);
		}
		ccall.add_argument (new CCodeConstant ("NULL"));

		if (bus_get_proxy_async || conn_get_proxy_async) {
			if (expr.is_yield_expression) {
				int state = emit_context.next_coroutine_state++;

				ccode.add_assignment (new CCodeMemberAccess.pointer (new CCodeIdentifier ("_data_"), "_state_"), new CCodeConstant (state.to_string ()));
				ccode.add_expression (ccall);
				ccode.add_return (new CCodeConstant ("FALSE"));
				ccode.add_label ("_state_%d".printf (state));

				ccall = new CCodeFunctionCall (new CCodeIdentifier ("g_async_initable_new_finish"));
				ccall.add_argument (new CCodeCastExpression (new CCodeMemberAccess.pointer (new CCodeIdentifier ("_data_"), "_source_object_"), "GAsyncInitable *"));
				// pass GAsyncResult stored in closure to finish function
				ccall.add_argument (new CCodeMemberAccess.pointer (new CCodeIdentifier ("_data_"), "_res_"));
				ccall.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, get_inner_error_cexpression ()));
			} else {
				// begin
				ccode.add_expression (ccall);
				return;
			}
		}

		var temp_var = get_temp_variable (expr.value_type, expr.value_type.value_owned);
		var temp_ref = get_variable_cexpression (temp_var.name);

		emit_temp_var (temp_var);

		ccode.add_assignment (temp_ref, new CCodeCastExpression (ccall, get_ccode_name (expr.value_type)));
		set_cvalue (expr, temp_ref);
	}

	public override void register_dbus_info (CCodeBlock block, ObjectTypeSymbol sym) {
		if (!(sym is Interface)) {
			return;
		}

		string dbus_iface_name = get_dbus_name (sym);
		if (dbus_iface_name == null) {
			return;
		}

		var quark = new CCodeFunctionCall (new CCodeIdentifier ("g_quark_from_static_string"));
		quark.add_argument (new CCodeConstant ("\"vala-dbus-proxy-type\""));

		var proxy_type = new CCodeIdentifier (get_ccode_lower_case_prefix (sym) + "proxy_get_type");

		var set_qdata = new CCodeFunctionCall (new CCodeIdentifier ("g_type_set_qdata"));
		set_qdata.add_argument (new CCodeIdentifier ("%s_type_id".printf (get_ccode_lower_case_name (sym, null))));
		set_qdata.add_argument (quark);
		set_qdata.add_argument (new CCodeCastExpression (proxy_type, "void*"));

		block.add_statement (new CCodeExpressionStatement (set_qdata));

		quark = new CCodeFunctionCall (new CCodeIdentifier ("g_quark_from_static_string"));
		quark.add_argument (new CCodeConstant ("\"vala-dbus-interface-name\""));

		set_qdata = new CCodeFunctionCall (new CCodeIdentifier ("g_type_set_qdata"));
		set_qdata.add_argument (new CCodeIdentifier ("%s_type_id".printf (get_ccode_lower_case_name (sym, null))));
		set_qdata.add_argument (quark);
		set_qdata.add_argument (new CCodeConstant ("\"%s\"".printf (dbus_iface_name)));

		block.add_statement (new CCodeExpressionStatement (set_qdata));

		quark = new CCodeFunctionCall (new CCodeIdentifier ("g_quark_from_static_string"));
		quark.add_argument (new CCodeConstant ("\"vala-dbus-interface-info\""));

		set_qdata = new CCodeFunctionCall (new CCodeIdentifier ("g_type_set_qdata"));
		set_qdata.add_argument (new CCodeIdentifier ("%s_type_id".printf (get_ccode_lower_case_name (sym, null))));
		set_qdata.add_argument (quark);
		set_qdata.add_argument (new CCodeCastExpression (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, get_interface_info (sym)), "void*"));

		block.add_statement (new CCodeExpressionStatement (set_qdata));
	}
}
