/* valagdbusservertransformer.vala
 *
 * Copyright (C) 2011  Luca Bruno
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
 * 	Luca Bruno <lucabru@src.gnome.org>
 */

/**
 * Code visitor for transforming the code tree related to DBus server.
 */
public class Vala.GDBusServerTransformer : GDBusClientTransformer {
	public override void visit_class (Class cl) {
		visit_object_type_symbol (cl);

		base.visit_class (cl);
	}

	public override void visit_interface (Interface iface) {
		visit_object_type_symbol (iface);

		base.visit_interface (iface);
	}

	string generate_dbus_method_wrapper (Method m, ObjectTypeSymbol sym) {
		Method wrapper;
		wrapper_method (new VoidType (), "gdbus_server " + m.get_full_name (), out wrapper);
		var object_type = SemanticAnalyzer.get_data_type_for_symbol (sym);
		wrapper.add_parameter (new Parameter ("object", object_type));
		wrapper.add_parameter (new Parameter ("arguments", data_type ("GLib.Variant", false)));
		wrapper.add_parameter (new Parameter ("invocation", data_type ("GLib.DBusMethodInvocation", false)));
		push_builder (new CodeBuilder.for_subroutine (wrapper));

		var iter = b.add_temp_declaration (null, expression ("arguments.iterator ()"));

		var call = (MethodCall) expression (@"object.$(m.name) ()");
		var finish_call = call;
		Method ready = null;
		CodeBuilder ready_builder = null;
		if (m.coroutine) {
			wrapper_method (new VoidType (), "gdbus_server_async_ready " + m.get_full_name (), out ready);
			ready.add_parameter (new Parameter ("source_object", data_type ("GLib.Object", false)));
			ready.add_parameter (new Parameter ("res", data_type ("GLib.AsyncResult", false)));
			ready.add_parameter (new Parameter ("invocation", data_type ("GLib.DBusMethodInvocation", false)));
			ready_builder = new CodeBuilder.for_subroutine (ready);

			finish_call = (MethodCall) expression (@"(($object_type) source_object).$(m.name).end (res)");
		}

		var out_args = new string[0];
		var out_types = new DataType[0];
		string fd_list = null;
		string fd_index = null;
		foreach (var param in m.get_parameters ()) {
			string? type_name = null;
			if (param.variable_type is ObjectType) {
				type_name = param.variable_type.data_type.get_full_name ();
			}
			if (type_name == "GLib.Cancellable") {
				call.add_argument (expression ("null"));
				continue;
			}
			if (type_name == "GLib.BusName") {
				continue;
			}

			if (param.direction == ParameterDirection.IN) {
				var arg = b.add_temp_declaration (copy_type (param.variable_type, true));
				b.add_assignment (expression (arg), read_dbus_value (param.variable_type, iter, "invocation.get_message ()", ref fd_list, ref fd_index));
				call.add_argument (expression (arg));
			} else if (param.direction == ParameterDirection.OUT) {
				if (m.coroutine) {
					// declare the out argument in the ready callback
					push_builder (ready_builder);
				}
				var arg = b.add_temp_declaration (copy_type (param.variable_type, true));
				out_args += arg;
				out_types += param.variable_type;
				finish_call.add_argument (new UnaryExpression (UnaryOperator.OUT, expression (arg), m.source_reference));
				if (m.coroutine) {
					pop_builder ();
				}
			}
		}

		if (m.coroutine) {
			call.add_argument (expression (@"(s, r) => $(ready.name) (s, r, invocation)"));
			b.add_expression (call);
			push_builder (ready_builder);
		}

		b.open_try ();
		string result = null;
		if (m.has_result) {
			result = b.add_temp_declaration (copy_type (m.return_type));
			b.add_assignment (expression (result), finish_call);
		} else {
			b.add_expression (finish_call);
		}
		b.add_catch (data_type ("GLib.Error"), "e");
		b.add_expression (expression ("invocation.return_gerror (e)"));
		b.add_return ();
		b.close ();

		fd_list = null;
		var reply = b.add_temp_declaration (null, expression ("new GLib.DBusMessage.method_reply (invocation.get_message ())"));
		var builder = b.add_temp_declaration (null, expression ("new GLib.VariantBuilder (GLib.VariantType.TUPLE)"));
		for (int i = 0; i < out_args.length; i++) {
			write_dbus_value (out_types[i], builder, out_args[i], ref fd_list);
		}
		if (result != null) {
			write_dbus_value (m.return_type, builder, result, ref fd_list);
		}
		b.add_expression (expression (@"$reply.set_body ($builder.end ())"));
		if (fd_list != null) {
			b.add_expression (expression (@"$reply.set_unix_fd_list ($fd_list)"));
		}
		b.add_expression (expression (@"invocation.get_connection ().send_message ($reply, GLib.DBusSendMessageFlags.NONE, null)"));

		if (m.coroutine) {
			pop_builder ();
			check (ready);
		}

		pop_builder ();
		check (wrapper);
		return wrapper.name;
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

	void generate_interface_method_call (ObjectTypeSymbol sym) {
		if (sym.scope.lookup ("dbus_interface_method_call") != null) {
			return;
		}

		var im = new Method ("dbus_interface_method_call", new VoidType (), sym.source_reference);
		im.access = SymbolAccessibility.PRIVATE;
		im.binding = MemberBinding.STATIC;
		im.add_parameter (new Parameter ("connection", data_type ("GLib.DBusConnection", false)));
		im.add_parameter (new Parameter ("sender", data_type ("string", false)));
		im.add_parameter (new Parameter ("object_path", data_type ("string", false)));
		im.add_parameter (new Parameter ("interface_name", data_type ("string", false)));
		im.add_parameter (new Parameter ("method_name", data_type ("string", false)));
		im.add_parameter (new Parameter ("_parameters_", data_type ("GLib.Variant", false)));
		im.add_parameter (new Parameter ("invocation", data_type ("GLib.DBusMethodInvocation", false)));
		im.add_parameter (new Parameter ("user_data", new PointerType (new VoidType ())));
		sym.add_method (im);

		push_builder (new CodeBuilder.for_subroutine (im));
		var object_type = SemanticAnalyzer.get_data_type_for_symbol (sym);
		var object = b.add_temp_declaration (null, expression (@"($object_type) (((Object[]) user_data)[0])"));
		b.open_switch (expression ("method_name"), null);
		b.add_return ();
		foreach (var m in sym.get_methods ()) {
			if (m is CreationMethod || m.binding != MemberBinding.INSTANCE
			    || m.overrides || m.access != SymbolAccessibility.PUBLIC
				|| !is_dbus_visible (m)) {
				continue;
			}
			b.add_section (expression (@"\"$(get_dbus_name_for_member (m))\""));
			var wrapper = generate_dbus_method_wrapper (m, sym);
			b.add_expression (expression (@"$wrapper ($object, _parameters_, invocation)"));
			b.add_break ();
		}
		b.close ();
		pop_builder ();
		check (im);
	}

	void generate_interface_get_property (ObjectTypeSymbol sym) {
		if (sym.scope.lookup ("dbus_interface_get_property") != null) {
			return;
		}

		var m = new Method ("dbus_interface_get_property", data_type ("GLib.Variant", true, true), sym.source_reference);
		m.access = SymbolAccessibility.PRIVATE;
		m.binding = MemberBinding.STATIC;
		m.add_parameter (new Parameter ("connection", data_type ("GLib.DBusConnection", false)));
		m.add_parameter (new Parameter ("sender", data_type ("string", false)));
		m.add_parameter (new Parameter ("object_path", data_type ("string", false)));
		m.add_parameter (new Parameter ("interface_name", data_type ("string", false)));
		m.add_parameter (new Parameter ("property_name", data_type ("string", false)));
		m.add_parameter (new Parameter ("error", new PointerType (new PointerType (new VoidType ()))));
		m.add_parameter (new Parameter ("user_data", new PointerType (new VoidType ())));
		sym.add_method (m);

		push_builder (new CodeBuilder.for_subroutine (m));
		var object_type = SemanticAnalyzer.get_data_type_for_symbol (sym);
		var object = b.add_temp_declaration (null, expression (@"($object_type) (((Object[]) user_data)[0])"));
		b.open_switch (expression ("property_name"), null);
		b.add_return (expression ("null"));
		foreach (var prop in sym.get_properties ()) {
			if (prop.binding != MemberBinding.INSTANCE
			    || prop.overrides || prop.access != SymbolAccessibility.PUBLIC
				|| !is_dbus_visible (prop)
				|| prop.get_accessor == null) {
				continue;
			}
			b.add_section (expression (@"\"$(get_dbus_name_for_member (prop))\""));
			b.add_return (expression (@"$object.$(prop.name)"));
		}
		pop_builder ();
		check (m);
	}

	void generate_interface_set_property (ObjectTypeSymbol sym) {
		if (sym.scope.lookup ("dbus_interface_set_property") != null) {
			return;
		}

		var m = new Method ("dbus_interface_set_property", data_type ("bool"), sym.source_reference);
		m.access = SymbolAccessibility.PRIVATE;
		m.binding = MemberBinding.STATIC;
		m.add_parameter (new Parameter ("connection", data_type ("GLib.DBusConnection", false)));
		m.add_parameter (new Parameter ("sender", data_type ("string", false)));
		m.add_parameter (new Parameter ("object_path", data_type ("string", false)));
		m.add_parameter (new Parameter ("interface_name", data_type ("string", false)));
		m.add_parameter (new Parameter ("property_name", data_type ("string", false)));
		m.add_parameter (new Parameter ("value", data_type ("GLib.Variant", false)));
		m.add_parameter (new Parameter ("error", new PointerType (new PointerType (new VoidType ()))));
		m.add_parameter (new Parameter ("user_data", new PointerType (new VoidType ())));
		sym.add_method (m);

		push_builder (new CodeBuilder.for_subroutine (m));
		var object_type = SemanticAnalyzer.get_data_type_for_symbol (sym);
		var object = b.add_temp_declaration (null, expression (@"($object_type) (((Object[]) user_data)[0])"));
		b.open_switch (expression ("property_name"), null);
		b.add_return (expression ("false"));
		foreach (var prop in sym.get_properties ()) {
			if (prop.binding != MemberBinding.INSTANCE
			    || prop.overrides || prop.access != SymbolAccessibility.PUBLIC
				|| !is_dbus_visible (prop)
				|| prop.set_accessor == null) {
				continue;
			}
			b.add_section (expression (@"\"$(get_dbus_name_for_member (prop))\""));
			b.add_expression (expression (@"$object.$(prop.name) = ($(prop.property_type)) value"));
			b.add_return (expression ("true"));
		}
		pop_builder ();
		check (m);
	}

	void generate_interface_signal_emitter (Signal sig, ObjectTypeSymbol sym, string dbus_iface_name) {
		var wrapper_name = "_dbus_%s_%s".printf (get_ccode_lower_case_name (sym), get_ccode_lower_case_name (sig));
		if (context.root.scope.lookup (wrapper_name) != null) {
			return;
		}

		var m = new Method (wrapper_name, new VoidType (), sym.source_reference);
		context.root.add_method (m);
		m.access = SymbolAccessibility.PRIVATE;
		m.binding = MemberBinding.STATIC;
		m.add_parameter (new Parameter ("_sender", data_type ("GLib.Object", false)));
		foreach (var param in sig.get_parameters ()) {
			m.add_parameter (param.copy ());
		}
		m.add_parameter (new Parameter ("_data", new PointerType (new PointerType (new VoidType ()))));
		push_builder (new CodeBuilder.for_subroutine (m));

		var builder = b.add_temp_declaration (null, expression ("new GLib.VariantBuilder (GLib.VariantType.TUPLE)"));
		foreach (var param in sig.get_parameters ()) {
			if (is_gvariant_type (param.variable_type)) {
				b.add_expression (expression (@"$builder.add (\"v\", $(param.name))"));
			} else {
				b.add_expression (expression (@"$builder.add_value ($(param.name))"));
			}
		}
		b.add_expression (expression (@"((GLib.DBusConnection) _data[1]).emit_signal (null, (string) _data[2], \"$dbus_iface_name\", \"$(get_dbus_name_for_member (sig))\", $builder.end ())"));
		pop_builder ();
		check (m);
	}

	void visit_object_type_symbol (ObjectTypeSymbol sym) {
		string dbus_iface_name = get_dbus_name (sym);
		if (dbus_iface_name == null) {
			return;
		}

		if (!context.has_package ("gio-2.0")) {
			if (!sym.error) {
				Report.error (sym.source_reference, "gio-2.0 package required for dbus type symbols");
				sym.error = true;
			}
			return;
		}

		generate_interface_method_call (sym);
		generate_interface_get_property (sym);
		generate_interface_set_property (sym);

		foreach (var sig in sym.get_signals ()) {
			if (sig.access != SymbolAccessibility.PUBLIC || !is_dbus_visible (sig)) {
				continue;
			}
			generate_interface_signal_emitter (sig, sym, dbus_iface_name);
		}
	}
}
