/* valagdbusclienttransformer.vala
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
 * Code visitor for transforming the code tree related to DBus clients.
 */
public class Vala.GDBusClientTransformer : GVariantTransformer {
	public static bool is_dbus_no_reply (Method m) {
		return m.get_attribute_bool ("DBus", "no_reply");
	}

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

	public Expression read_dbus_value (DataType type, string iter, string message, ref string? fd_list, ref string? fd_index) {
		string? type_name = null;
		if (type.data_type != null) {
			type_name = type.data_type.get_full_name ();
		}
		if (type_name == "GLib.UnixInputStream" || type_name == "GLib.UnixOutputStream" || type_name == "GLib.Socket") {
			if (fd_list == null) {
				fd_list = b.add_temp_declaration (data_type ("GLib.UnixFDList"), null);
				fd_index = b.add_temp_declaration (null, expression ("0"));
				b.add_expression (expression (@"$fd_list = $message.get_unix_fd_list ()"));
			}
			b.add_expression (expression (@"$iter.next (\"h\", out $fd_index)"));
			if (type_name == "GLib.UnixInputStream") {
				return expression (@"new GLib.UnixInputStream ($fd_list.get ($fd_index), true)");
			} else if (type_name == "GLib.UnixOutputStream") {
				return expression (@"new GLib.UnixOutputStream ($fd_list.get ($fd_index), true)");
			} else {
				// socket
				return expression (@"new GLib.Socket.from_fd ($fd_list.get ($fd_index))");
			}
		} else if (type_name == "GLib.Variant") {
			return expression (@"$iter.next_value ().get_variant ()");
		} else {
			return expression (@"($type) ($iter.next_value ())");
		}
	}

	public void write_dbus_value (DataType type, string builder, string value, ref string? fd_list) {
		string? type_name = null;
		if (type is ObjectType) {
			type_name = type.data_type.get_full_name ();
		}
		if (type_name == "GLib.Cancellable" || type_name == "GLib.BusName") {
			return;
		}
		if (type_name == "GLib.UnixInputStream" || type_name == "GLib.UnixOutputStream" || type_name == "GLib.Socket") {
			if (fd_list == null) {
				fd_list = b.add_temp_declaration (null, expression ("new GLib.UnixFDList ()"));
			}
			b.add_expression (expression (@"$builder.add (\"h\", $fd_list.append ($value.get_fd ()))"));
		} else if (type_name == "GLib.Variant") {
			b.add_expression (expression (@"$builder.add (\"v\", $value)"));
		} else {
			b.add_expression (expression (@"$builder.add_value ($value)"));
		}
	}

	void generate_marshalling (Method m, string? iface_name, string? method_name, int method_timeout) {
		var interface_name = iface_name != null ? @"\"$iface_name\"" : "this.get_interface_name ()";

		// create the message
		var reply = b.add_temp_declaration (data_type ("GLib.DBusMessage"));
		var message = b.add_temp_declaration (null, expression (@"new GLib.DBusMessage.method_call (this.get_name (), this.get_object_path (), $interface_name, \"$method_name\")"));
		var builder = b.add_temp_declaration (null, expression (@"new GLib.VariantBuilder (GLib.VariantType.TUPLE)"));

		// fill the message
		bool has_result = m.has_result;
		string cancellable = "null";
		string fd_list = null;
		foreach (var param in m.get_parameters ()) {
			if (param.direction == ParameterDirection.IN) {
				if (param.variable_type is ObjectType && param.variable_type.data_type.get_full_name () == "GLib.Cancellable") {
					cancellable = param.name;
				}
				write_dbus_value (param.variable_type, builder, param.name, ref fd_list);
			} else if (param.direction == ParameterDirection.OUT) {
				has_result = true;
			}
		}
		b.add_expression (expression (@"$message.set_body ($builder.end ())"));
		if (fd_list != null) {
			b.add_expression (expression (@"$message.set_unix_fd_list ($fd_list)"));
		}

		// send the message
		if (is_dbus_no_reply (m)) {
			b.add_expression (expression (@"this.get_connection ().send_message ($message, GLib.DBusSendMessageFlags.NO_REPLY_EXPECTED, null)"));
		} else {
			var yield_str = m.coroutine ? "yield " : "";
			var method_str = m.coroutine ? "send_message_with_reply" : "send_message_with_reply_sync";
			var timeout_str = method_timeout > 0 ? @"$method_timeout" : "this.get_default_timeout ()";
			b.add_expression (expression (@"$reply = $yield_str this.get_connection ().$method_str ($message, GLib.DBusSendMessageFlags.NONE, $timeout_str, null, $cancellable)"));

			b.add_expression (expression (@"$reply.to_gerror ()"));
		}

		// deserialize the result
		fd_list = null;
		string fd_index = null;
		if (has_result) {
			var iter = b.add_temp_declaration (data_type ("GLib.VariantIter"));
			b.add_expression (expression (@"$iter = $reply.get_body ().iterator ()"));
			foreach (var param in m.get_parameters ()) {
				if (param.direction == ParameterDirection.OUT) {
					b.add_assignment (expression (param.name), read_dbus_value (param.variable_type, iter, reply, ref fd_list, ref fd_index));
				}
			}
			if (m.has_result) {
				b.add_return (read_dbus_value (m.return_type, iter, reply, ref fd_list, ref fd_index));
			}
		}
	}

	void generate_dbus_proxy_method (Class proxy_class, Interface iface, Method m) {
		var proxy = new Method (m.name, m.return_type.copy(), m.source_reference);
		foreach (var param in m.get_parameters ()) {
			proxy.add_parameter (param.copy ());
		}
		proxy.access = m.access;
		proxy.binding = m.binding;
		proxy.coroutine = m.coroutine;
		var error_types = new ArrayList<DataType> ();
		m.get_error_types (error_types);
		foreach (var error_type in error_types) {
			proxy.add_error_type (error_type);
		}
		proxy_class.add_method (proxy);

		push_builder (new CodeBuilder.for_subroutine (proxy));
		string dbus_iface_name = get_dbus_name (iface);
		generate_marshalling (m, dbus_iface_name, get_dbus_name_for_member (m), GDBusModule.get_dbus_timeout_for_member (m));
		pop_builder ();
	}

	void generate_dbus_proxy_methods (Class proxy_class, Interface iface) {
		// also generate proxy for prerequisites
		foreach (var prereq in iface.get_prerequisites ()) {
			if (prereq.data_type is Interface) {
				generate_dbus_proxy_methods (proxy_class, (Interface) prereq.data_type);
			}
		}

		foreach (var m in iface.get_methods ()) {
			if (!m.is_abstract) {
				continue;
			}

			generate_dbus_proxy_method (proxy_class, iface, m);
		}
	}

	string generate_dbus_proxy_signal (Class proxy_class, Signal sig, ObjectTypeSymbol sym) {
		var m = new Method (temp_func_cname (), new VoidType (), sig.source_reference);
		m.access = SymbolAccessibility.PRIVATE;
		m.add_parameter (new Parameter ("parameters", data_type ("GLib.Variant", false), sig.source_reference));
		proxy_class.add_method (m);
		push_builder (new CodeBuilder.for_subroutine (m));

		var iter = b.add_temp_declaration (null, expression ("parameters.iterator ()"));
		var call = new MethodCall (expression (sig.name), sig.source_reference);
		foreach (var param in sig.get_parameters ()) {
			var temp = b.add_temp_declaration (copy_type (param.variable_type, true));
			if (is_gvariant_type (param.variable_type)) {
				b.add_expression (expression (@"$temp = $iter.next_value ().get_variant ()"));
			} else {
				b.add_expression (expression (@"$temp = ($(param.variable_type)) ($iter.next_value ())"));
			}
			call.add_argument (expression (temp));
		}
		b.add_expression (call);

		pop_builder ();
		return m.name;
	}

	void generate_dbus_proxy_signals (Class proxy_class, ObjectTypeSymbol sym) {
		var g_signal = (Signal) symbol_from_string ("GLib.DBusProxy.g_signal");
		var m = new Method ("g_signal", g_signal.return_type.copy(), sym.source_reference);
		m.overrides = true;
		m.access = SymbolAccessibility.PUBLIC;
		foreach (var param in g_signal.get_parameters ()) {
			m.add_parameter (param.copy ());
		}
		proxy_class.add_method (m);

		push_builder (new CodeBuilder.for_subroutine (m));

		b.open_switch (expression ("signal_name"), null);
		b.add_expression (expression ("GLib.assert_not_reached ()"));
		b.add_break ();
		foreach (var sig in sym.get_signals ()) {
			if (sig.access != SymbolAccessibility.PUBLIC) {
				continue;
			}

			b.add_section (expression (@"\"$(get_dbus_name_for_member (sig))\""));
			var handler_name = generate_dbus_proxy_signal (proxy_class, sig, sym);
			b.add_expression (expression (@"$handler_name (parameters)"));
			b.add_break ();
		}
		b.close ();
		pop_builder ();
	}

	public int get_dbus_timeout (Symbol symbol) {
		int timeout = -1;

		var dbus = symbol.get_attribute ("DBus");
		if (dbus != null && dbus.has_argument ("timeout")) {
			timeout = dbus.get_integer ("timeout");
		} else if (symbol.parent_symbol != null) {
			return get_dbus_timeout (symbol.parent_symbol);
		}

		return timeout;
	}

	void generate_dbus_proxy_property (Class proxy_class, Interface iface, Property prop) {
		int timeout = get_dbus_timeout (prop);
		var dbus_name = get_dbus_name_for_member (prop);
		var dbus_iface_name = get_dbus_name (iface);

		PropertyAccessor proxy_get = null;
		if (prop.get_accessor != null) {
			var owned_type = copy_type (prop.get_accessor.value_type, true);
			if (owned_type.is_disposable () && !prop.get_accessor.value_type.value_owned) {
				Report.error (prop.get_accessor.value_type.source_reference, "Properties used in D-Bus clients require owned get accessor");
				return;
			}

			proxy_get = new PropertyAccessor (true, false, false, owned_type, null, prop.get_accessor.source_reference);

			push_builder (new CodeBuilder.for_subroutine (proxy_get));
			// first try cached value
			var result = b.add_temp_declaration (null, expression (@"get_cached_property (\"$dbus_name\")"));
			b.open_if (expression (@"$result == null"));

			b.open_try ();
			b.add_expression (expression (@"$result = call_sync (\"org.freedesktop.DBus.Properties.Get\", new Variant (\"(ss)\", \"$dbus_iface_name\", \"$dbus_name\"), GLib.DBusCallFlags.NONE, $timeout, null)"));
			b.add_catch_uncaught_error ();
			b.close ();

			b.add_expression (expression (@"$result.get (\"(v)\", out $result)"));
			b.close ();

			b.add_return (expression (@"($(prop.property_type)) ($result)"));
			pop_builder ();
		}

		PropertyAccessor proxy_set = null;
		if (prop.set_accessor != null) {
			proxy_set = new PropertyAccessor (false, true, false, prop.set_accessor.value_type, null, prop.set_accessor.source_reference);
			push_builder (new CodeBuilder.for_subroutine (proxy_set));
			var variant = b.add_temp_declaration (data_type ("GLib.Variant"), expression ("value"));
			b.add_expression (expression (@"call_sync (\"org.freedesktop.DBus.Properties.Set\", new Variant (\"(ssv)\", \"$dbus_iface_name\", \"$dbus_name\", $variant), GLib.DBusCallFlags.NONE, $timeout, null)"));
			pop_builder ();
		}

		Property proxy = new Property (prop.name, prop.property_type, proxy_get, proxy_set, prop.source_reference);
		proxy_class.add_property (proxy);
	}

	void generate_dbus_proxy_properties (Class proxy_class, Interface iface) {
		// also generate proxy for prerequisites
		foreach (var prereq in iface.get_prerequisites ()) {
			if (prereq.data_type is Interface) {
				generate_dbus_proxy_properties (proxy_class, (Interface) prereq.data_type);
			}
		}

		foreach (var prop in iface.get_properties ()) {
			if (!prop.is_abstract) {
				continue;
			}

			generate_dbus_proxy_property (proxy_class, iface, prop);
		}
	}

	public override void visit_interface (Interface iface) {
		base.visit_interface (iface);

		string dbus_iface_name = get_dbus_name (iface);
		if (dbus_iface_name == null) {
			return;
		}

		if (iface.parent_symbol.scope.lookup (iface.name+"Proxy") != null) {
			return;
		}

		if (!context.has_package ("gio-2.0")) {
			if (!iface.error) {
				Report.error (iface.source_reference, "gio-2.0 package required for dbus type symbols");
				iface.error = true;
			}
			return;
		}

		// create proxy class
		var proxy = new Class (iface.name + "Proxy", iface.source_reference, null);
		proxy.add_base_type (data_type ("GLib.DBusProxy"));
		proxy.add_base_type (SemanticAnalyzer.get_data_type_for_symbol (iface));
		proxy.access = iface.access;
		iface.parent_symbol.add_class (proxy);

		generate_dbus_proxy_methods (proxy, iface);
		generate_dbus_proxy_signals (proxy, iface);
		generate_dbus_proxy_properties (proxy, iface);

		check (proxy);
	}

	public override void visit_method_call (MethodCall expr) {
		var m = expr.call.symbol_reference as DynamicMethod;
		if (m == null || m.dynamic_type.data_type != symbol_from_string ("GLib.DBusProxy")) {
			// not a dynamic dbus call
			base.visit_method_call (expr);
			return;
		}

		push_builder (new CodeBuilder (context, expr.parent_statement, expr.source_reference));

		Method wrapper;
		var cache_key = "gdbus_client_dynamic_method_call " + m.return_type.to_string ();
		foreach (var param in m.get_parameters ()) {
			cache_key = "%s %s".printf (cache_key, param.variable_type.to_string ());
		}
		if (!wrapper_method (m.return_type.copy(), cache_key, out wrapper, symbol_from_string ("GLib.DBusProxy"))) {
			foreach (var param in m.get_parameters ()) {
				wrapper.add_parameter (param.copy ());
			}
			b = new CodeBuilder.for_subroutine (wrapper);
			generate_marshalling (m, null, m.name, GDBusModule.get_dbus_timeout_for_member (m));
			check (wrapper);
		}

		pop_builder ();
		expr.call.symbol_reference = wrapper;
		base.visit_method_call (expr);
	}
}
