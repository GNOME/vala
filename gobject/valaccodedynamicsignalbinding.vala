/* valaccodedynamicsignalbinding.vala
 *
 * Copyright (C) 2007-2008  Jürg Billeter
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

using GLib;
using Gee;

/**
 * The link between a dynamic signal and generated code.
 */
public class Vala.CCodeDynamicSignalBinding : CCodeBinding {
	public Signal node { get; set; }

	public CCodeDynamicSignalBinding (CCodeGenerator codegen, DynamicSignal node) {
		this.node = node;
		this.codegen = codegen;
	}

	string? connect_wrapper_name;
	string? disconnect_wrapper_name;

	public string get_connect_wrapper_name () {
		var dynamic_signal = (DynamicSignal) node;

		if (connect_wrapper_name == null) {
			connect_wrapper_name = "_dynamic_%s_connect".printf (node.name);
			var func = new CCodeFunction (connect_wrapper_name, "void");
			func.add_parameter (new CCodeFormalParameter ("obj", "gpointer"));
			func.add_parameter (new CCodeFormalParameter ("signal_name", "const char *"));
			func.add_parameter (new CCodeFormalParameter ("handler", "GCallback"));
			func.add_parameter (new CCodeFormalParameter ("data", "gpointer"));
			var block = new CCodeBlock ();
			if (dynamic_signal.dynamic_type.data_type == codegen.dbus_object_type) {
				generate_dbus_connect_wrapper (block);
			} else {
				Report.error (node.source_reference, "dynamic signals are not supported for `%s'".printf (dynamic_signal.dynamic_type.to_string ()));
			}

			// append to C source file
			codegen.source_type_member_declaration.append (func.copy ());

			func.block = block;
			codegen.source_type_member_definition.append (func);
		}

		return connect_wrapper_name;
	}

	public string get_disconnect_wrapper_name () {
		var dynamic_signal = (DynamicSignal) node;

		if (disconnect_wrapper_name == null) {
			disconnect_wrapper_name = "_dynamic_%s_disconnect".printf (node.name);
			var func = new CCodeFunction (disconnect_wrapper_name, "void");
			func.add_parameter (new CCodeFormalParameter ("obj", "gpointer"));
			func.add_parameter (new CCodeFormalParameter ("signal_name", "const char *"));
			func.add_parameter (new CCodeFormalParameter ("handler", "GCallback"));
			func.add_parameter (new CCodeFormalParameter ("data", "gpointer"));
			var block = new CCodeBlock ();
			if (dynamic_signal.dynamic_type.data_type == codegen.dbus_object_type) {
				generate_dbus_disconnect_wrapper (block);
			} else {
				Report.error (node.source_reference, "dynamic signals are not supported for `%s'".printf (dynamic_signal.dynamic_type.to_string ()));
			}

			// append to C source file
			codegen.source_type_member_declaration.append (func.copy ());

			func.block = block;
			codegen.source_type_member_definition.append (func);
		}

		return disconnect_wrapper_name;
	}

	void generate_dbus_connect_wrapper (CCodeBlock block) {
		var dynamic_signal = (DynamicSignal) node;

		var m = (Method) dynamic_signal.handler.symbol_reference;

		bool first = true;
		foreach (FormalParameter param in m.get_parameters ()) {
			if (first) {
				// skip sender parameter
				first = false;
				continue;
			}
			node.add_parameter (param.copy ());
		}

		node.accept (codegen);

		// FIXME should only be done once per marshaller
		var register_call = new CCodeFunctionCall (new CCodeIdentifier ("dbus_g_object_register_marshaller"));
		register_call.add_argument (new CCodeIdentifier (codegen.get_signal_marshaller_function (node)));
		register_call.add_argument (new CCodeIdentifier ("G_TYPE_NONE"));

		var add_call = new CCodeFunctionCall (new CCodeIdentifier ("dbus_g_proxy_add_signal"));
		add_call.add_argument (new CCodeIdentifier ("obj"));
		add_call.add_argument (new CCodeConstant ("\"%s\"".printf (node.name)));

		first = true;
		foreach (FormalParameter param in m.get_parameters ()) {
			if (first) {
				// skip sender parameter
				first = false;
				continue;
			}
			if (param.type_reference is ArrayType && ((ArrayType) param.type_reference).element_type.data_type != codegen.string_type.data_type) {
				var array_type = (ArrayType) param.type_reference;
				if (array_type.element_type.data_type.get_type_id () == null) {
					Report.error (param.source_reference, "unsupported parameter type for D-Bus signals");
					return;
				}

				var carray_type = new CCodeFunctionCall (new CCodeIdentifier ("dbus_g_type_get_collection"));
				carray_type.add_argument (new CCodeConstant ("\"GArray\""));
				carray_type.add_argument (new CCodeIdentifier (array_type.element_type.data_type.get_type_id ()));
				register_call.add_argument (carray_type);
				add_call.add_argument (carray_type);
			} else {
				if (param.type_reference.get_type_id () == null) {
					Report.error (param.source_reference, "unsupported parameter type for D-Bus signals");
					return;
				}

				register_call.add_argument (new CCodeIdentifier (param.type_reference.get_type_id ()));
				add_call.add_argument (new CCodeIdentifier (param.type_reference.get_type_id ()));
			}
		}
		register_call.add_argument (new CCodeIdentifier ("G_TYPE_INVALID"));
		add_call.add_argument (new CCodeIdentifier ("G_TYPE_INVALID"));

		block.add_statement (new CCodeExpressionStatement (register_call));
		block.add_statement (new CCodeExpressionStatement (add_call));

		var call = new CCodeFunctionCall (new CCodeIdentifier ("dbus_g_proxy_connect_signal"));
		call.add_argument (new CCodeIdentifier ("obj"));
		call.add_argument (new CCodeIdentifier ("signal_name"));
		call.add_argument (new CCodeIdentifier ("handler"));
		call.add_argument (new CCodeIdentifier ("data"));
		call.add_argument (new CCodeConstant ("NULL"));
		block.add_statement (new CCodeExpressionStatement (call));
	}

	void generate_dbus_disconnect_wrapper (CCodeBlock block) {
		var dynamic_signal = (DynamicSignal) node;

		var call = new CCodeFunctionCall (new CCodeIdentifier ("dbus_g_proxy_disconnect_signal"));
		call.add_argument (new CCodeIdentifier ("obj"));
		call.add_argument (new CCodeIdentifier ("signal_name"));
		call.add_argument (new CCodeIdentifier ("handler"));
		call.add_argument (new CCodeIdentifier ("data"));
		block.add_statement (new CCodeExpressionStatement (call));
	}
}
