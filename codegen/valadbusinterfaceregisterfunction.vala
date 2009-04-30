/* valadbusinterfaceregisterfunction.vala
 *
 * Copyright (C) 2009 Didier Villevalois
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
 *	Didier Villevalois <ptitjes@free.fr>
 */

using GLib;

/**
 * C function to register an interface at runtime.
 */
public class Vala.DBusInterfaceRegisterFunction : InterfaceRegisterFunction {
	
	public DBusInterfaceRegisterFunction (Interface iface, CodeContext context) {
		base(iface, context);
	}

	public override CCodeFragment get_type_interface_init_statements () {
		var frag = base.get_type_interface_init_statements ();
		
		var quark_dbus_proxy = new CCodeFunctionCall (new CCodeIdentifier ("g_quark_from_string"));
		quark_dbus_proxy.add_argument (new CCodeConstant ("\"ValaDBusInterfaceProxyType\""));

		var func = new CCodeFunctionCall (new CCodeIdentifier ("g_type_set_qdata"));
		func.add_argument (new CCodeIdentifier ("%s_type_id".printf (interface_reference.get_lower_case_cname 
(null))));
		func.add_argument (quark_dbus_proxy);
		func.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, new CCodeIdentifier 
("%s_dbus_proxy_get_type".printf (interface_reference.get_lower_case_cname (null)))));
		
		frag.append (new CCodeExpressionStatement (func));
		
		return frag;
	}
}

