/* valagdbusmodule.vala
 *
 * Copyright (C) 2010-2012  Jürg Billeter
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

public class Vala.GDBusModule : GVariantModule {
	public static string? get_dbus_name (TypeSymbol symbol) {
		return symbol.get_attribute_string ("DBus", "name");
	}

	public static string get_dbus_name_for_member (Symbol symbol) {
		var dbus_name = symbol.get_attribute_string ("DBus", "name");
		if (dbus_name != null) {
			return dbus_name;
		}

		return Symbol.lower_case_to_camel_case (symbol.name);
	}

	public static bool is_dbus_visible (CodeNode node) {
		var dbus_attribute = node.get_attribute ("DBus");
		if (dbus_attribute != null
		    && dbus_attribute.has_argument ("visible")
		    && !dbus_attribute.get_bool ("visible")) {
			return false;
		}

		return true;
	}

	public static bool is_dbus_no_reply (Method m) {
		return m.get_attribute_bool ("DBus", "no_reply");
	}

	public static string dbus_result_name (Method m) {
		var dbus_name = m.get_attribute_string ("DBus", "result");
		if (dbus_name != null && dbus_name != "") {
			return dbus_name;
		}

		return "result";
	}

	public override void visit_error_domain (ErrorDomain edomain) {
		var edomain_dbus_name = get_dbus_name (edomain);
		if (edomain_dbus_name == null) {
			base.visit_error_domain (edomain);
			return;
		}

		cfile.add_include ("gio/gio.h");

		generate_error_domain_declaration (edomain, cfile);

		if (!edomain.is_internal_symbol ()) {
			generate_error_domain_declaration (edomain, header_file);
		}
		if (!edomain.is_private_symbol ()) {
			generate_error_domain_declaration (edomain, internal_header_file);
		}

		var error_entries = new CCodeInitializerList ();
		foreach (ErrorCode ecode in edomain.get_codes ()) {
			var ecode_dbus_name = get_dbus_name (ecode);
			if (ecode_dbus_name == null) {
				ecode_dbus_name = Symbol.lower_case_to_camel_case (ecode.name.down ());
			}

			var error_entry = new CCodeInitializerList ();
			error_entry.append (new CCodeIdentifier (get_ccode_name (ecode)));
			error_entry.append (new CCodeConstant ("\"%s.%s\"".printf (edomain_dbus_name, ecode_dbus_name)));
			error_entries.append (error_entry);
		}

		var cdecl = new CCodeDeclaration ("const GDBusErrorEntry");
		cdecl.add_declarator (new CCodeVariableDeclarator (get_ccode_lower_case_name (edomain) + "_entries[]", error_entries));
		cdecl.modifiers = CCodeModifiers.STATIC;
		cfile.add_constant_declaration (cdecl);

		string quark_fun_name = get_ccode_lower_case_prefix (edomain) + "quark";

		var cquark_fun = new CCodeFunction (quark_fun_name, get_ccode_name (gquark_type.data_type));
		push_function (cquark_fun);

		string quark_name = "%squark_volatile".printf (get_ccode_lower_case_prefix (edomain));

		ccode.add_declaration ("gsize", new CCodeVariableDeclarator (quark_name, new CCodeConstant ("0")), CCodeModifiers.STATIC | CCodeModifiers.VOLATILE);

		var register_call = new CCodeFunctionCall (new CCodeIdentifier ("g_dbus_error_register_error_domain"));
		register_call.add_argument (new CCodeConstant ("\"" + CCodeBaseModule.get_quark_name (edomain) + "\""));
		register_call.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, new CCodeIdentifier (quark_name)));
		register_call.add_argument (new CCodeIdentifier (get_ccode_lower_case_name (edomain) + "_entries"));
		var nentries = new CCodeFunctionCall (new CCodeIdentifier ("G_N_ELEMENTS"));
		nentries.add_argument (new CCodeIdentifier (get_ccode_lower_case_name (edomain) + "_entries"));
		register_call.add_argument (nentries);
		ccode.add_expression (register_call);

		ccode.add_return (new CCodeCastExpression (new CCodeIdentifier (quark_name), "GQuark"));

		pop_function ();
		cfile.add_function (cquark_fun);
	}

	bool is_file_descriptor (DataType type) {
		if (type is ObjectType) {
			if (type.data_type.get_full_name () == "GLib.UnixInputStream" ||
			    type.data_type.get_full_name () == "GLib.UnixOutputStream" ||
			    type.data_type.get_full_name () == "GLib.Socket" ||
			    type.data_type.get_full_name () == "GLib.FileDescriptorBased") {
				return true;
			}
		}

		return false;
	}

	public bool dbus_method_uses_file_descriptor (Method method) {
		foreach (Parameter param in method.get_parameters ()) {
			if (is_file_descriptor (param.variable_type)) {
				return true;
			}
		}

		if (is_file_descriptor (method.return_type)) {
			return true;
		}

		return false;
	}

	CCodeExpression? get_file_descriptor (DataType type, CCodeExpression expr) {
		if (type is ObjectType) {
			if (type.data_type.get_full_name () == "GLib.UnixInputStream") {
				var result = new CCodeFunctionCall (new CCodeIdentifier ("g_unix_input_stream_get_fd"));
				result.add_argument (expr);
				return result;
			} else if (type.data_type.get_full_name () == "GLib.UnixOutputStream") {
				var result = new CCodeFunctionCall (new CCodeIdentifier ("g_unix_output_stream_get_fd"));
				result.add_argument (expr);
				return result;
			} else if (type.data_type.get_full_name () == "GLib.Socket") {
				var result = new CCodeFunctionCall (new CCodeIdentifier ("g_socket_get_fd"));
				result.add_argument (expr);
				return result;
			} else if (type.data_type.get_full_name () == "GLib.FileDescriptorBased") {
				var result = new CCodeFunctionCall (new CCodeIdentifier ("g_file_descriptor_based_get_fd"));
				result.add_argument (expr);
				return result;
			}
		}

		return null;
	}

	public void send_dbus_value (DataType type, CCodeExpression builder_expr, CCodeExpression expr, Symbol? sym) {
		var fd = get_file_descriptor (type, expr);
		if (fd != null) {
			// add file descriptor to the file descriptor list
			var fd_append = new CCodeFunctionCall (new CCodeIdentifier ("g_unix_fd_list_append"));
			fd_append.add_argument (new CCodeIdentifier ("_fd_list"));
			fd_append.add_argument (fd);
			fd_append.add_argument (new CCodeConstant ("NULL"));

			// add index to file descriptor to gvariant
			var builder_add = new CCodeFunctionCall (new CCodeIdentifier ("g_variant_builder_add"));
			builder_add.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, builder_expr));
			builder_add.add_argument (new CCodeConstant ("\"h\""));
			builder_add.add_argument (fd_append);
			ccode.add_expression (builder_add);
		} else {
			write_expression (type, builder_expr, expr, sym);
		}
	}

	CCodeExpression? create_from_file_descriptor (DataType type, CCodeExpression expr) {
		if (type is ObjectType) {
			if (type.data_type.get_full_name () == "GLib.UnixInputStream") {
				var result = new CCodeFunctionCall (new CCodeIdentifier ("g_unix_input_stream_new"));
				result.add_argument (expr);
				result.add_argument (new CCodeConstant ("TRUE"));
				return new CCodeCastExpression (result, "GUnixInputStream *");
			} else if (type.data_type.get_full_name () == "GLib.UnixOutputStream") {
				var result = new CCodeFunctionCall (new CCodeIdentifier ("g_unix_output_stream_new"));
				result.add_argument (expr);
				result.add_argument (new CCodeConstant ("TRUE"));
				return new CCodeCastExpression (result, "GUnixOutputStream *");
			} else if (type.data_type.get_full_name () == "GLib.Socket") {
				var result = new CCodeFunctionCall (new CCodeIdentifier ("g_socket_new_from_fd"));
				result.add_argument (expr);
				result.add_argument (new CCodeConstant ("NULL"));
				return result;
			}
		}

		return null;
	}

	public void receive_dbus_value (DataType type, CCodeExpression message_expr, CCodeExpression iter_expr, CCodeExpression target_expr, Symbol? sym, CCodeExpression? error_expr = null, out bool may_fail = null) {
		var fd_list = new CCodeFunctionCall (new CCodeIdentifier ("g_dbus_message_get_unix_fd_list"));
		fd_list.add_argument (message_expr);

		var fd = new CCodeFunctionCall (new CCodeIdentifier ("g_unix_fd_list_get"));
		fd.add_argument (fd_list);
		fd.add_argument (new CCodeIdentifier ("_fd_index"));
		fd.add_argument (new CCodeConstant ("NULL"));

		var stream = create_from_file_descriptor (type, fd);
		if (stream != null) {
			var get_fd = new CCodeFunctionCall (new CCodeIdentifier ("g_variant_iter_next"));
			get_fd.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, iter_expr));
			get_fd.add_argument (new CCodeConstant ("\"h\""));
			get_fd.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, new CCodeIdentifier ("_fd_index")));
			ccode.add_expression (get_fd);

			ccode.add_assignment (target_expr, stream);
			may_fail = false;
		} else {
			read_expression (type, iter_expr, target_expr, sym, error_expr, out may_fail);
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

				var cdecl = new CCodeDeclaration ("const GDBusArgInfo");
				cdecl.add_declarator (new CCodeVariableDeclarator ("_" + get_ccode_lower_case_prefix (sym) + "dbus_arg_info_" + get_ccode_name (sig) + "_" + param.name, info));
				cdecl.modifiers = CCodeModifiers.STATIC;
				cfile.add_constant_declaration (cdecl);

				args_info.append (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, new CCodeIdentifier ("_" + get_ccode_lower_case_prefix (sym) + "dbus_arg_info_" + get_ccode_name (sig) + "_" + param.name)));
			}

			args_info.append (new CCodeConstant ("NULL"));

			var cdecl = new CCodeDeclaration ("const GDBusArgInfo * const");
			cdecl.add_declarator (new CCodeVariableDeclarator ("_" + get_ccode_lower_case_prefix (sym) + "dbus_arg_info_" + get_ccode_name (sig) + "[]", args_info));
			cdecl.modifiers = CCodeModifiers.STATIC;
			cfile.add_constant_declaration (cdecl);

			var info = new CCodeInitializerList ();
			info.append (new CCodeConstant ("-1"));
			info.append (new CCodeConstant ("\"%s\"".printf (get_dbus_name_for_member (sig))));
			info.append (new CCodeCastExpression (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, new CCodeIdentifier ("_" + get_ccode_lower_case_prefix (sym) + "dbus_arg_info_" + get_ccode_name (sig))), "GDBusArgInfo **"));

			cdecl = new CCodeDeclaration ("const GDBusSignalInfo");
			cdecl.add_declarator (new CCodeVariableDeclarator ("_" + get_ccode_lower_case_prefix (sym) + "dbus_signal_info_" + get_ccode_name (sig), info));
			cdecl.modifiers = CCodeModifiers.STATIC;
			cfile.add_constant_declaration (cdecl);

			infos.append (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, new CCodeIdentifier ("_" + get_ccode_lower_case_prefix (sym) + "dbus_signal_info_" + get_ccode_name (sig))));
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

	void declare_interface_info (ObjectTypeSymbol sym) {
		var info = new CCodeInitializerList ();
		info.append (new CCodeConstant ("-1"));
		info.append (new CCodeConstant ("\"%s\"".printf (get_dbus_name (sym))));
		info.append (new CCodeCastExpression (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, get_method_info (sym)), "GDBusMethodInfo **"));
		info.append (new CCodeCastExpression (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, get_signal_info (sym)), "GDBusSignalInfo **"));
		info.append (new CCodeCastExpression (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, get_property_info (sym)), "GDBusPropertyInfo **"));

		var cdecl = new CCodeDeclaration ("const GDBusInterfaceInfo");
		cdecl.add_declarator (new CCodeVariableDeclarator ("_" + get_ccode_lower_case_prefix (sym) + "dbus_interface_info", info));
		cdecl.modifiers = CCodeModifiers.STATIC;
		cfile.add_constant_declaration (cdecl);
	}

	protected CCodeExpression get_interface_info (ObjectTypeSymbol sym) {
		return new CCodeIdentifier ("_" + get_ccode_lower_case_prefix (sym) + "dbus_interface_info");
	}

	public override void visit_class (Class cl) {
		base.visit_class (cl);

		visit_object_type_symbol (cl);
	}

	public override void visit_interface (Interface iface) {
		base.visit_interface (iface);

		visit_object_type_symbol (iface);
	}

	void visit_object_type_symbol (ObjectTypeSymbol sym) {
		if (get_dbus_name (sym) == null) {
			return;
		}

		declare_interface_info(sym);
	}
}
