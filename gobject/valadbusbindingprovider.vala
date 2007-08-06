/* valadbusbindingprovider.vala
 *
 * Copyright (C) 2007  Jürg Billeter
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public
 * License as published by the Free Software Foundation; either
 * version 2 of the License, or (at your option) any later version.

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
 * Dynamic binding provider for DBus objects.
 */
public class Vala.DBusBindingProvider : BindingProvider {
	public CodeContext context {
		set {
			_context = value;

			string_type = (DataType) _context.root.scope.lookup ("string");

			var dbus_ns = _context.root.scope.lookup ("DBus");
			if (dbus_ns != null) {
				connection_type = (DataType) dbus_ns.scope.lookup ("Connection");
				dbus_error_type = (DataType) dbus_ns.scope.lookup ("Error");
			}
		}
	}

	private CodeContext _context;
	private DataType string_type;
	private DataType connection_type;
	private DataType dbus_error_type;

	private Collection<Symbol> symbols = new ArrayList<Symbol> ();

	public DBusBindingProvider () {
	}

	public Symbol get_binding (MemberAccess! ma) {
		if (connection_type != null && ma.inner != null && ma.inner.static_type.data_type == connection_type) {
			var type_args = ma.get_type_arguments ();
			if (type_args.size != 1) {
				return null;
			}
			Iterator<TypeReference> type_args_it = type_args.iterator ();
			type_args_it.next ();
			var ret_type = new TypeReference ();
			ret_type.data_type = type_args_it.get ().data_type;
			if (!is_dbus_interface (ret_type.data_type)) {
				return null;
			}
			var m = new Method ("get_object", ret_type, ma.source_reference);
			m.set_cname ("dbus_g_proxy_new_for_name");
			m.add_cheader_filename ("dbus/dbus-glib.h");
			m.access = MemberAccessibility.PUBLIC;
			var string_type_ref = new TypeReference ();
			string_type_ref.data_type = string_type;
			m.add_parameter (new FormalParameter ("name", string_type_ref));
			m.add_parameter (new FormalParameter ("path", string_type_ref));
			symbols.add (m);
			return m;
		} else if (ma.inner != null && is_dbus_interface (ma.inner.static_type.data_type)) {
			if (ma.parent_node is InvocationExpression) {
				var expr = (InvocationExpression) ma.parent_node;
				var ret_type = new TypeReference ();
				if (expr.expected_type != null) {
					ret_type.data_type = expr.expected_type.data_type;
					ret_type.transfers_ownership = ret_type.data_type.is_reference_type ();
				}
				var m = new DBusMethod (ma.member_name, ret_type, ma.source_reference);
				if (expr.expected_type != null) {
					var error_type = new TypeReference ();
					error_type.data_type = dbus_error_type;
					m.add_error_domain (error_type);
				}
				m.access = MemberAccessibility.PUBLIC;
				m.add_parameter (new FormalParameter.with_ellipsis ());
				symbols.add (m);
				return m;
			} else if (ma.parent_node is Assignment) {
				var a = (Assignment) ma.parent_node;
				if (a.left != ma) {
					return null;
				}
				var s = new DBusSignal (ma.member_name, new TypeReference (), ma.source_reference);
				s.access = MemberAccessibility.PUBLIC;
				symbols.add (s);
				return s;
			}
		}
		return null;
	}

	private bool is_dbus_interface (DataType! t) {
		if (!(t is Interface)) {
			return false;
		}
		return (t.get_attribute ("DBusInterface") != null);
	}
}

