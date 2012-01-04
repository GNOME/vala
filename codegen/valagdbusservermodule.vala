/* valagdbusservermodule.vala
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
 */

public class Vala.GDBusServerModule : GDBusClientModule {
	string generate_dbus_signal_wrapper (Signal sig, ObjectTypeSymbol sym, string dbus_iface_name) {
		return "_dbus_%s_%s".printf (get_ccode_lower_case_name (sym), get_ccode_lower_case_name (sig));
	}

	void handle_signals (ObjectTypeSymbol sym, bool connect) {
		string dbus_iface_name = get_dbus_name (sym);
		if (dbus_iface_name == null) {
			return;
		}

		foreach (Signal sig in sym.get_signals ()) {
			if (sig.access != SymbolAccessibility.PUBLIC) {
				continue;
			}
			if (!is_dbus_visible (sig)) {
				continue;
			}

			if (connect) {
				var connect_call = new CCodeFunctionCall (new CCodeIdentifier ("g_signal_connect"));
				connect_call.add_argument (new CCodeIdentifier ("object"));
				connect_call.add_argument (get_signal_canonical_constant (sig));
				connect_call.add_argument (new CCodeCastExpression (new CCodeIdentifier (generate_dbus_signal_wrapper (sig, sym, dbus_iface_name)), "GCallback"));
				connect_call.add_argument (new CCodeIdentifier ("data"));
				ccode.add_expression (connect_call);
			} else {
				// disconnect the signals
				var disconnect_call = new CCodeFunctionCall (new CCodeIdentifier ("g_signal_handlers_disconnect_by_func"));
				disconnect_call.add_argument (new CCodeElementAccess (new CCodeIdentifier ("data"), new CCodeConstant ("0")));
				disconnect_call.add_argument (new CCodeIdentifier ("_dbus_%s_%s".printf (get_ccode_lower_case_name (sym), get_ccode_lower_case_name (sig))));
				disconnect_call.add_argument (new CCodeIdentifier ("data"));
				ccode.add_expression (disconnect_call);
			}
		}
	}

	CCodeExpression get_method_info (ObjectTypeSymbol sym) {
		var infos = new CCodeInitializerList ();

		foreach (Method m in sym.get_methods ()) {
			if (m is CreationMethod || m.binding != MemberBinding.INSTANCE
			    || m.overrides || m.access != SymbolAccessibility.PUBLIC) {
				continue;
			}
			if (!is_dbus_visible (m)) {
				continue;
			}

			var in_args_info = new CCodeInitializerList ();
			var out_args_info = new CCodeInitializerList ();

			foreach (Parameter param in m.get_parameters ()) {
				if (param.variable_type is ObjectType && param.variable_type.data_type.get_full_name () == "GLib.Cancellable") {
					continue;
				}
				if (param.variable_type is ObjectType && param.variable_type.data_type.get_full_name () == "GLib.BusName") {
					continue;
				}

				var info = new CCodeInitializerList ();
				info.append (new CCodeConstant ("-1"));
				info.append (new CCodeConstant ("\"%s\"".printf (param.name)));
				info.append (new CCodeConstant ("\"%s\"".printf (get_type_signature (param.variable_type, param))));
				info.append (new CCodeConstant ("NULL"));

				var cdecl = new CCodeDeclaration ("const GDBusArgInfo");
				cdecl.add_declarator (new CCodeVariableDeclarator ("_" + get_ccode_lower_case_prefix (sym) + "dbus_arg_info_" + m.name + "_" + param.name, info));
				cdecl.modifiers = CCodeModifiers.STATIC;
				cfile.add_constant_declaration (cdecl);

				if (param.direction == ParameterDirection.IN) {
					in_args_info.append (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, new CCodeIdentifier ("_" + get_ccode_lower_case_prefix (sym) + "dbus_arg_info_" + m.name + "_" + param.name)));
				} else {
					out_args_info.append (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, new CCodeIdentifier ("_" + get_ccode_lower_case_prefix (sym) + "dbus_arg_info_" + m.name + "_" + param.name)));
				}
			}

			if (!(m.return_type is VoidType)) {
				var info = new CCodeInitializerList ();
				info.append (new CCodeConstant ("-1"));
				info.append (new CCodeConstant ("\"%s\"".printf (dbus_result_name (m))));
				info.append (new CCodeConstant ("\"%s\"".printf (get_type_signature (m.return_type, m))));
				info.append (new CCodeConstant ("NULL"));

				var cdecl = new CCodeDeclaration ("const GDBusArgInfo");
				cdecl.add_declarator (new CCodeVariableDeclarator ("_" + get_ccode_lower_case_prefix (sym) + "dbus_arg_info_" + m.name + "_result", info));
				cdecl.modifiers = CCodeModifiers.STATIC;
				cfile.add_constant_declaration (cdecl);

				out_args_info.append (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, new CCodeIdentifier ("_" + get_ccode_lower_case_prefix (sym) + "dbus_arg_info_" + m.name + "_result")));
			}

			in_args_info.append (new CCodeConstant ("NULL"));
			out_args_info.append (new CCodeConstant ("NULL"));

			var cdecl = new CCodeDeclaration ("const GDBusArgInfo * const");
			cdecl.add_declarator (new CCodeVariableDeclarator ("_" + get_ccode_lower_case_prefix (sym) + "dbus_arg_info_" + m.name + "_in[]", in_args_info));
			cdecl.modifiers = CCodeModifiers.STATIC;
			cfile.add_constant_declaration (cdecl);

			cdecl = new CCodeDeclaration ("const GDBusArgInfo * const");
			cdecl.add_declarator (new CCodeVariableDeclarator ("_" + get_ccode_lower_case_prefix (sym) + "dbus_arg_info_" + m.name + "_out[]", out_args_info));
			cdecl.modifiers = CCodeModifiers.STATIC;
			cfile.add_constant_declaration (cdecl);

			var info = new CCodeInitializerList ();
			info.append (new CCodeConstant ("-1"));
			info.append (new CCodeConstant ("\"%s\"".printf (get_dbus_name_for_member (m))));
			info.append (new CCodeCastExpression (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, new CCodeIdentifier ("_" + get_ccode_lower_case_prefix (sym) + "dbus_arg_info_" + m.name + "_in")), "GDBusArgInfo **"));
			info.append (new CCodeCastExpression (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, new CCodeIdentifier ("_" + get_ccode_lower_case_prefix (sym) + "dbus_arg_info_" + m.name + "_out")), "GDBusArgInfo **"));
			info.append (new CCodeConstant ("NULL"));

			cdecl = new CCodeDeclaration ("const GDBusMethodInfo");
			cdecl.add_declarator (new CCodeVariableDeclarator ("_" + get_ccode_lower_case_prefix (sym) + "dbus_method_info_" + m.name, info));
			cdecl.modifiers = CCodeModifiers.STATIC;
			cfile.add_constant_declaration (cdecl);

			infos.append (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, new CCodeIdentifier ("_" + get_ccode_lower_case_prefix (sym) + "dbus_method_info_" + m.name)));
		}

		infos.append (new CCodeConstant ("NULL"));

		var cdecl = new CCodeDeclaration ("const GDBusMethodInfo * const");
		cdecl.add_declarator (new CCodeVariableDeclarator ("_" + get_ccode_lower_case_prefix (sym) + "dbus_method_info[]", infos));
		cdecl.modifiers = CCodeModifiers.STATIC;
		cfile.add_constant_declaration (cdecl);

		return new CCodeIdentifier ("_" + get_ccode_lower_case_prefix (sym) + "dbus_method_info");
	}

	CCodeExpression get_signal_info (ObjectTypeSymbol sym) {
		var infos = new CCodeInitializerList ();

		foreach (Signal sig in sym.get_signals ()) {
			if (sig.access != SymbolAccessibility.PUBLIC) {
				continue;
			}
			if (!is_dbus_visible (sig)) {
				continue;
			}

			var args_info = new CCodeInitializerList ();

			foreach (Parameter param in sig.get_parameters ()) {
				var info = new CCodeInitializerList ();
				info.append (new CCodeConstant ("-1"));
				info.append (new CCodeConstant ("\"%s\"".printf (param.name)));
				info.append (new CCodeConstant ("\"%s\"".printf (get_type_signature (param.variable_type, param))));
				info.append (new CCodeConstant ("NULL"));

				var cdecl = new CCodeDeclaration ("const GDBusArgInfo");
				cdecl.add_declarator (new CCodeVariableDeclarator ("_" + get_ccode_lower_case_prefix (sym) + "dbus_arg_info_" + get_ccode_lower_case_name (sig) + "_" + param.name, info));
				cdecl.modifiers = CCodeModifiers.STATIC;
				cfile.add_constant_declaration (cdecl);

				args_info.append (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, new CCodeIdentifier ("_" + get_ccode_lower_case_prefix (sym) + "dbus_arg_info_" + get_ccode_lower_case_name (sig) + "_" + param.name)));
			}

			args_info.append (new CCodeConstant ("NULL"));

			var cdecl = new CCodeDeclaration ("const GDBusArgInfo * const");
			cdecl.add_declarator (new CCodeVariableDeclarator ("_" + get_ccode_lower_case_prefix (sym) + "dbus_arg_info_" + get_ccode_lower_case_name (sig) + "[]", args_info));
			cdecl.modifiers = CCodeModifiers.STATIC;
			cfile.add_constant_declaration (cdecl);

			var info = new CCodeInitializerList ();
			info.append (new CCodeConstant ("-1"));
			info.append (new CCodeConstant ("\"%s\"".printf (get_dbus_name_for_member (sig))));
			info.append (new CCodeCastExpression (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, new CCodeIdentifier ("_" + get_ccode_lower_case_prefix (sym) + "dbus_arg_info_" + get_ccode_lower_case_name (sig))), "GDBusArgInfo **"));
			info.append (new CCodeConstant ("NULL"));

			cdecl = new CCodeDeclaration ("const GDBusSignalInfo");
			cdecl.add_declarator (new CCodeVariableDeclarator ("_" + get_ccode_lower_case_prefix (sym) + "dbus_signal_info_" + get_ccode_lower_case_name (sig), info));
			cdecl.modifiers = CCodeModifiers.STATIC;
			cfile.add_constant_declaration (cdecl);

			infos.append (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, new CCodeIdentifier ("_" + get_ccode_lower_case_prefix (sym) + "dbus_signal_info_" + get_ccode_lower_case_name (sig))));
		}

		infos.append (new CCodeConstant ("NULL"));

		var cdecl = new CCodeDeclaration ("const GDBusSignalInfo * const");
		cdecl.add_declarator (new CCodeVariableDeclarator ("_" + get_ccode_lower_case_prefix (sym) + "dbus_signal_info[]", infos));
		cdecl.modifiers = CCodeModifiers.STATIC;
		cfile.add_constant_declaration (cdecl);

		return new CCodeIdentifier ("_" + get_ccode_lower_case_prefix (sym) + "dbus_signal_info");
	}

	CCodeExpression get_property_info (ObjectTypeSymbol sym) {
		var infos = new CCodeInitializerList ();

		foreach (Property prop in sym.get_properties ()) {
			if (prop.binding != MemberBinding.INSTANCE
			    || prop.overrides || prop.access != SymbolAccessibility.PUBLIC) {
				continue;
			}
			if (!is_dbus_visible (prop)) {
				continue;
			}

			var info = new CCodeInitializerList ();
			info.append (new CCodeConstant ("-1"));
			info.append (new CCodeConstant ("\"%s\"".printf (get_dbus_name_for_member (prop))));
			info.append (new CCodeConstant ("\"%s\"".printf (get_type_signature (prop.property_type, prop))));
			if (prop.get_accessor != null && prop.set_accessor != null) {
				info.append (new CCodeConstant ("G_DBUS_PROPERTY_INFO_FLAGS_READABLE | G_DBUS_PROPERTY_INFO_FLAGS_WRITABLE"));
			} else if (prop.get_accessor != null) {
				info.append (new CCodeConstant ("G_DBUS_PROPERTY_INFO_FLAGS_READABLE"));
			} else if (prop.set_accessor != null) {
				info.append (new CCodeConstant ("G_DBUS_PROPERTY_INFO_FLAGS_WRITABLE"));
			} else {
				info.append (new CCodeConstant ("G_DBUS_PROPERTY_INFO_FLAGS_NONE"));
			}
			info.append (new CCodeConstant ("NULL"));

			var cdecl = new CCodeDeclaration ("const GDBusPropertyInfo");
			cdecl.add_declarator (new CCodeVariableDeclarator ("_" + get_ccode_lower_case_prefix (sym) + "dbus_property_info_" + prop.name, info));
			cdecl.modifiers = CCodeModifiers.STATIC;
			cfile.add_constant_declaration (cdecl);

			infos.append (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, new CCodeIdentifier ("_" + get_ccode_lower_case_prefix (sym) + "dbus_property_info_" + prop.name)));
		}

		infos.append (new CCodeConstant ("NULL"));

		var cdecl = new CCodeDeclaration ("const GDBusPropertyInfo * const");
		cdecl.add_declarator (new CCodeVariableDeclarator ("_" + get_ccode_lower_case_prefix (sym) + "dbus_property_info[]", infos));
		cdecl.modifiers = CCodeModifiers.STATIC;
		cfile.add_constant_declaration (cdecl);

		return new CCodeIdentifier ("_" + get_ccode_lower_case_prefix (sym) + "dbus_property_info");
	}

	CCodeExpression get_interface_info (ObjectTypeSymbol sym) {
		var info = new CCodeInitializerList ();
		info.append (new CCodeConstant ("-1"));
		info.append (new CCodeConstant ("\"%s\"".printf (get_dbus_name (sym))));
		info.append (new CCodeCastExpression (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, get_method_info (sym)), "GDBusMethodInfo **"));
		info.append (new CCodeCastExpression (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, get_signal_info (sym)), "GDBusSignalInfo **"));
		info.append (new CCodeCastExpression (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, get_property_info (sym)), "GDBusPropertyInfo **"));
		info.append (new CCodeConstant ("NULL"));

		var cdecl = new CCodeDeclaration ("const GDBusInterfaceInfo");
		cdecl.add_declarator (new CCodeVariableDeclarator ("_" + get_ccode_lower_case_prefix (sym) + "dbus_interface_info", info));
		cdecl.modifiers = CCodeModifiers.STATIC;
		cfile.add_constant_declaration (cdecl);

		return new CCodeIdentifier ("_" + get_ccode_lower_case_prefix (sym) + "dbus_interface_info");
	}

	CCodeExpression get_interface_vtable (ObjectTypeSymbol sym) {
		var vtable = new CCodeInitializerList ();
		vtable.append (new CCodeIdentifier (get_ccode_lower_case_prefix (sym) + "dbus_interface_method_call"));
		vtable.append (new CCodeIdentifier (get_ccode_lower_case_prefix (sym) + "dbus_interface_get_property"));
		vtable.append (new CCodeIdentifier (get_ccode_lower_case_prefix (sym) + "dbus_interface_set_property"));

		var cdecl = new CCodeDeclaration ("const GDBusInterfaceVTable");
		cdecl.add_declarator (new CCodeVariableDeclarator ("_" + get_ccode_lower_case_prefix (sym) + "dbus_interface_vtable", vtable));
		cdecl.modifiers = CCodeModifiers.STATIC;
		cfile.add_constant_declaration (cdecl);

		return new CCodeIdentifier ("_" + get_ccode_lower_case_prefix (sym) + "dbus_interface_vtable");
	}

	string generate_register_object_function () {
		string register_object_func = "_vala_g_dbus_connection_register_object";

		if (!add_wrapper (register_object_func)) {
			return register_object_func;
		}

		cfile.add_include ("gio/gio.h");

		var function = new CCodeFunction (register_object_func, "guint");
		function.modifiers = CCodeModifiers.STATIC;

		function.add_parameter (new CCodeParameter ("type", "GType"));
		function.add_parameter (new CCodeParameter ("object", "void*"));
		function.add_parameter (new CCodeParameter ("connection", "GDBusConnection*"));
		function.add_parameter (new CCodeParameter ("path", "const gchar*"));
		function.add_parameter (new CCodeParameter ("error", "GError**"));

		push_function (function);

		var quark = new CCodeFunctionCall (new CCodeIdentifier ("g_quark_from_static_string"));
		quark.add_argument (new CCodeConstant ("\"vala-dbus-register-object\""));

		var get_qdata = new CCodeFunctionCall (new CCodeIdentifier ("g_type_get_qdata"));
		get_qdata.add_argument (new CCodeIdentifier ("type"));
		get_qdata.add_argument (quark);

		ccode.add_declaration ("void", new CCodeVariableDeclarator ("*func"));
		ccode.add_assignment (new CCodeIdentifier ("func"), get_qdata);

		ccode.open_if (new CCodeUnaryExpression (CCodeUnaryOperator.LOGICAL_NEGATION, new CCodeIdentifier ("func")));
		// no D-Bus interface
		// return error

		var set_error = new CCodeFunctionCall (new CCodeIdentifier ("g_set_error_literal"));
		set_error.add_argument (new CCodeIdentifier ("error"));
		set_error.add_argument (new CCodeIdentifier ("G_IO_ERROR"));
		set_error.add_argument (new CCodeIdentifier ("G_IO_ERROR_FAILED"));
		set_error.add_argument (new CCodeConstant ("\"The specified type does not support D-Bus registration\""));
		ccode.add_expression (set_error);

		ccode.add_return (new CCodeConstant ("0"));

		ccode.close ();

		var register_object = new CCodeCastExpression (new CCodeIdentifier ("func"), "guint (*) (void *, GDBusConnection *, const gchar *, GError **)");

		var ccall = new CCodeFunctionCall (register_object);
		ccall.add_argument (new CCodeIdentifier ("object"));
		ccall.add_argument (new CCodeIdentifier ("connection"));
		ccall.add_argument (new CCodeIdentifier ("path"));
		ccall.add_argument (new CCodeIdentifier ("error"));

		ccode.add_return (ccall);

		pop_function ();

		cfile.add_function_declaration (function);
		cfile.add_function (function);

		return register_object_func;
	}

	public override void visit_method_call (MethodCall expr) {
		var mtype = expr.call.value_type as MethodType;
		if (mtype == null || get_ccode_name (mtype.method_symbol) != "g_dbus_connection_register_object") {
			base.visit_method_call (expr);
			return;
		}

		var ma = (MemberAccess) expr.call;
		var type_arg = ma.get_type_arguments ().get (0);

		CCodeFunctionCall cregister;

		var object_type = type_arg as ObjectType;
		if (object_type != null) {
			if (get_dbus_name (object_type.type_symbol) == null) {
				Report.error (expr.source_reference, "DBusConnection.register_object requires type argument with [DBus (name = ...)] attribute");
				return;
			}

			cregister = new CCodeFunctionCall (new CCodeIdentifier ("%sregister_object".printf (get_ccode_lower_case_prefix (object_type.type_symbol))));
		} else {
			// use runtime type information for generic methods
			cregister = new CCodeFunctionCall (new CCodeIdentifier (generate_register_object_function ()));
			cregister.add_argument (get_type_id_expression (type_arg));
		}

		var args = expr.get_argument_list ();
		var path_arg = args[0];
		var obj_arg = args[1];

		// method can fail
		current_method_inner_error = true;

		cregister.add_argument (get_cvalue (obj_arg));
		cregister.add_argument (get_cvalue (ma.inner));
		cregister.add_argument (get_cvalue (path_arg));
		cregister.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, get_inner_error_cexpression ()));

		if (expr.parent_node is ExpressionStatement) {
			ccode.add_expression (cregister);
		} else {
			var temp_var = get_temp_variable (expr.value_type, expr.value_type.value_owned);
			var temp_ref = get_variable_cexpression (temp_var.name);

			emit_temp_var (temp_var);

			ccode.add_assignment (temp_ref, cregister);
			set_cvalue (expr, temp_ref);
		}
	}

	public override void generate_class_declaration (Class cl, CCodeFile decl_space) {
		base.generate_class_declaration (cl, decl_space);

		generate_object_type_symbol_declaration (cl, decl_space);
	}

	public override void generate_interface_declaration (Interface iface, CCodeFile decl_space) {
		base.generate_interface_declaration (iface, decl_space);

		generate_object_type_symbol_declaration (iface, decl_space);
	}

	public override void visit_class (Class cl) {
		base.visit_class (cl);

		visit_object_type_symbol (cl);
	}

	public override void visit_interface (Interface iface) {
		base.visit_interface (iface);

		visit_object_type_symbol (iface);
	}

	void generate_object_type_symbol_declaration (ObjectTypeSymbol sym, CCodeFile decl_space) {
		string dbus_iface_name = get_dbus_name (sym);
		if (dbus_iface_name == null) {
			return;
		}

		string register_object_name = "%sregister_object".printf (get_ccode_lower_case_prefix (sym));

		if (add_symbol_declaration (decl_space, sym, register_object_name)) {
			return;
		}

		decl_space.add_include ("gio/gio.h");

		// declare register_object function
		var cfunc = new CCodeFunction (register_object_name, "guint");
		cfunc.add_parameter (new CCodeParameter ("object", "void*"));
		cfunc.add_parameter (new CCodeParameter ("connection", "GDBusConnection*"));
		cfunc.add_parameter (new CCodeParameter ("path", "const gchar*"));
		cfunc.add_parameter (new CCodeParameter ("error", "GError**"));
		if (sym.is_private_symbol ()) {
			cfunc.modifiers |= CCodeModifiers.STATIC;
		} else if (context.hide_internal && sym.is_internal_symbol ()) {
			cfunc.modifiers |= CCodeModifiers.INTERNAL;
		}
		decl_space.add_function_declaration (cfunc);
	}

	void visit_object_type_symbol (ObjectTypeSymbol sym) {
		// only support registering a single D-Bus interface at a time (unlike old D-Bus support)
		// however, register_object can be invoked multiple times for the same object path with different interfaces
		string dbus_iface_name = get_dbus_name (sym);
		if (dbus_iface_name == null) {
			return;
		}

		cfile.add_include ("gio/gio.h");

		var cfunc = new CCodeFunction (get_ccode_lower_case_prefix (sym) + "register_object", "guint");
		cfunc.add_parameter (new CCodeParameter ("object", "gpointer"));
		cfunc.add_parameter (new CCodeParameter ("connection", "GDBusConnection*"));
		cfunc.add_parameter (new CCodeParameter ("path", "const gchar*"));
		cfunc.add_parameter (new CCodeParameter ("error", "GError**"));
		if (sym.is_private_symbol ()) {
			cfunc.modifiers |= CCodeModifiers.STATIC;
		} else if (context.hide_internal && sym.is_internal_symbol ()) {
			cfunc.modifiers |= CCodeModifiers.INTERNAL;
		}

		push_function (cfunc);

		ccode.add_declaration ("guint", new CCodeVariableDeclarator ("result"));


		// data consists of 3 pointers: object, connection, path
		ccode.add_declaration ("gpointer", new CCodeVariableDeclarator ("*data"));

		var alloc_data = new CCodeFunctionCall (new CCodeIdentifier ("g_new"));
		alloc_data.add_argument (new CCodeIdentifier ("gpointer"));
		alloc_data.add_argument (new CCodeConstant ("3"));
		ccode.add_assignment (new CCodeIdentifier ("data"), alloc_data);

		var ref_function = get_ccode_ref_function (sym);
		if (sym is Interface && ref_function == null) {
			Report.error (sym.source_reference, "missing class prerequisite for interface `%s', add GLib.Object to interface declaration if unsure".printf (sym.get_full_name ()));
			return;
		}

		var ref_object = new CCodeFunctionCall (new CCodeIdentifier (ref_function));
		ref_object.add_argument (new CCodeIdentifier ("object"));
		ccode.add_assignment (new CCodeElementAccess (new CCodeIdentifier ("data"), new CCodeConstant ("0")), ref_object);

		ref_object = new CCodeFunctionCall (new CCodeIdentifier ("g_object_ref"));
		ref_object.add_argument (new CCodeIdentifier ("connection"));
		ccode.add_assignment (new CCodeElementAccess (new CCodeIdentifier ("data"), new CCodeConstant ("1")), ref_object);

		var dup_path = new CCodeFunctionCall (new CCodeIdentifier ("g_strdup"));
		dup_path.add_argument (new CCodeIdentifier ("path"));
		ccode.add_assignment (new CCodeElementAccess (new CCodeIdentifier ("data"), new CCodeConstant ("2")), dup_path);


		var cregister = new CCodeFunctionCall (new CCodeIdentifier ("g_dbus_connection_register_object"));
		cregister.add_argument (new CCodeIdentifier ("connection"));
		cregister.add_argument (new CCodeIdentifier ("path"));

		cregister.add_argument (new CCodeCastExpression (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, get_interface_info (sym)), "GDBusInterfaceInfo *"));
		cregister.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, get_interface_vtable (sym)));

		cregister.add_argument (new CCodeIdentifier ("data"));
		cregister.add_argument (new CCodeIdentifier ("_" + get_ccode_lower_case_prefix (sym) + "unregister_object"));
		cregister.add_argument (new CCodeIdentifier ("error"));

		ccode.add_assignment (new CCodeIdentifier ("result"), cregister);

		ccode.open_if (new CCodeUnaryExpression (CCodeUnaryOperator.LOGICAL_NEGATION, new CCodeIdentifier ("result")));
		ccode.add_return (new CCodeConstant ("0"));
		ccode.close ();

		handle_signals (sym, true);

		ccode.add_return (new CCodeIdentifier ("result"));

		pop_function ();
		cfile.add_function (cfunc);


		cfunc = new CCodeFunction ("_" + get_ccode_lower_case_prefix (sym) + "unregister_object");
		cfunc.add_parameter (new CCodeParameter ("user_data", "gpointer"));
		cfunc.modifiers |= CCodeModifiers.STATIC;

		push_function (cfunc);

		ccode.add_declaration ("gpointer*", new CCodeVariableDeclarator ("data", new CCodeIdentifier ("user_data")));

		handle_signals (sym, false);

		var unref_object = new CCodeFunctionCall (new CCodeIdentifier (get_ccode_unref_function (sym)));
		unref_object.add_argument (new CCodeElementAccess (new CCodeIdentifier ("data"), new CCodeConstant ("0")));
		ccode.add_expression (unref_object);

		unref_object = new CCodeFunctionCall (new CCodeIdentifier ("g_object_unref"));
		unref_object.add_argument (new CCodeElementAccess (new CCodeIdentifier ("data"), new CCodeConstant ("1")));
		ccode.add_expression (unref_object);

		var free_path = new CCodeFunctionCall (new CCodeIdentifier ("g_free"));
		free_path.add_argument (new CCodeElementAccess (new CCodeIdentifier ("data"), new CCodeConstant ("2")));
		ccode.add_expression (free_path);

		var free_data = new CCodeFunctionCall (new CCodeIdentifier ("g_free"));
		free_data.add_argument (new CCodeIdentifier ("data"));
		ccode.add_expression (free_data);

		pop_function ();
		cfile.add_function_declaration (cfunc);
		cfile.add_function (cfunc);
	}

	public override void register_dbus_info (CCodeBlock block, ObjectTypeSymbol sym) {
		string dbus_iface_name = get_dbus_name (sym);
		if (dbus_iface_name == null) {
			return;
		}

		base.register_dbus_info (block, sym);

		var quark = new CCodeFunctionCall (new CCodeIdentifier ("g_quark_from_static_string"));
		quark.add_argument (new CCodeConstant ("\"vala-dbus-register-object\""));

		var set_qdata = new CCodeFunctionCall (new CCodeIdentifier ("g_type_set_qdata"));
		set_qdata.add_argument (new CCodeIdentifier ("%s_type_id".printf (get_ccode_lower_case_name (sym, null))));
		set_qdata.add_argument (quark);
		set_qdata.add_argument (new CCodeCastExpression (new CCodeIdentifier (get_ccode_lower_case_prefix (sym) + "register_object"), "void*"));

		block.add_statement (new CCodeExpressionStatement (set_qdata));
	}
}
