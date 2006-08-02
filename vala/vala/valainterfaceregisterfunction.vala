/* valainterfaceregisterfunction.vala
 *
 * Copyright (C) 2006  Jürg Billeter
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

/**
 * C function to register an interface at runtime.
 */
public class Vala.InterfaceRegisterFunction : TypeRegisterFunction {
	/**
	 * Specifies the interface to be registered.
	 */
	public Interface! interface_reference { get; set construct; }
	
	public construct (Interface! iface) {
		interface_reference = iface;
	}
	
	public override DataType! get_type_declaration () {
		return interface_reference;
	}
	
	public override ref string! get_type_struct_name () {
		return "%sInterface".printf (interface_reference.get_cname ());
	}
	
	public override ref string! get_class_init_func_name () {
		return "NULL";
	}
	
	public override ref string! get_instance_struct_size () {
		return "0";
	}
	
	public override ref string! get_instance_init_func_name () {
		return "NULL";
	}
	
	public override ref string! get_parent_type_name () {
		return "G_TYPE_INTERFACE";
	}

	public override ref CCodeFragment! get_type_interface_init_statements () {
		var frag = new CCodeFragment ();
		
		return frag;
	}
}
