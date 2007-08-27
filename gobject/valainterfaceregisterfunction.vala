/* valainterfaceregisterfunction.vala
 *
 * Copyright (C) 2006-2007  Jürg Billeter, Raffaele Sandrini
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
 *	Raffaele Sandrini <rasa@gmx.ch>
 */

using GLib;

/**
 * C function to register an interface at runtime.
 */
public class Vala.InterfaceRegisterFunction : TypeRegisterFunction {
	/**
	 * Specifies the interface to be registered.
	 */
	public weak Interface! interface_reference { get; set; }
	
	public InterfaceRegisterFunction (Interface! iface) {
		interface_reference = iface;
	}
	
	public override DataType! get_type_declaration () {
		return interface_reference;
	}
	
	public override string! get_type_struct_name () {
		return interface_reference.get_type_cname ();
	}

	public override string! get_base_init_func_name () {
		return "%s_base_init".printf (interface_reference.get_lower_case_cname (null));
	}

	public override string! get_class_init_func_name () {
		return "NULL";
	}
	
	public override string! get_instance_struct_size () {
		return "0";
	}
	
	public override string! get_instance_init_func_name () {
		return "NULL";
	}
	
	public override string! get_parent_type_name () {
		return "G_TYPE_INTERFACE";
	}

	public override MemberAccessibility get_accessibility () {
		return interface_reference.access;
	}

	public override CCodeFragment! get_type_interface_init_statements () {
		var frag = new CCodeFragment ();
		
		/* register all prerequisites */
		foreach (TypeReference prereq_ref in interface_reference.get_prerequisites ()) {
			var prereq = prereq_ref.data_type;
			
			var func = new CCodeFunctionCall (new CCodeIdentifier ("g_type_interface_add_prerequisite"));
			func.add_argument (new CCodeIdentifier ("%s_type_id".printf (interface_reference.get_lower_case_cname (null))));
			func.add_argument (new CCodeIdentifier (prereq.get_type_id()));
			
			frag.append (new CCodeExpressionStatement (func));
		}
		
		return frag;
	}
}
