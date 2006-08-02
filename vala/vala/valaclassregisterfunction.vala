/* valaclassregisterfunction.vala
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
 * C function to register a class at runtime.
 */
public class Vala.ClassRegisterFunction : TypeRegisterFunction {
	/**
	 * Specifies the class to be registered.
	 */
	public Class! class_reference { get; set construct; }
	
	/**
	 * Creates a new C function to register the specified class at runtime.
	 *
	 * @param cl a class
	 * @return   newly created class register function
	 */
	public construct (Class! cl) {
		class_reference = cl;
	}
	
	public override DataType! get_type_declaration () {
		return class_reference;
	}
	
	public override ref string! get_type_struct_name () {
		return "%sClass".printf (class_reference.get_cname ());
	}
	
	public override ref string! get_class_init_func_name () {
		return "%s_class_init".printf (class_reference.get_lower_case_cname (null));
	}
	
	public override ref string! get_instance_struct_size () {
		return "sizeof (%s)".printf (class_reference.get_cname ());
	}
	
	public override ref string! get_instance_init_func_name () {
		return "%s_init".printf (class_reference.get_lower_case_cname (null));
	}
	
	public override ref string! get_parent_type_name () {
		return class_reference.base_class.get_upper_case_cname ("TYPE_");
	}

	public override string get_type_flags () {
		if (class_reference.is_abstract) {
			return "G_TYPE_FLAG_ABSTRACT";
		} else {
			return "0";
		}
	}

	public override ref CCodeFragment! get_type_interface_init_statements () {
		var frag = new CCodeFragment ();
		
		foreach (TypeReference base_type in class_reference.get_base_types ()) {
			if (!(base_type.data_type is Interface)) {
				continue;
			}
			
			var iface = (Interface) base_type.data_type;
			
			var iface_info_name = "%s_info".printf (iface.get_lower_case_cname (null));
			
			var ctypedecl = new CCodeDeclaration ("const GInterfaceInfo");
			ctypedecl.modifiers = CCodeModifiers.STATIC;
			ctypedecl.add_declarator (new CCodeVariableDeclarator.with_initializer (iface_info_name, new CCodeConstant ("{ (GInterfaceInitFunc) %s_%s_interface_init, (GInterfaceFinalizeFunc) NULL, NULL}".printf (class_reference.get_lower_case_cname (null), iface.get_lower_case_cname (null)))));
			frag.append (ctypedecl);
			var reg_call = new CCodeFunctionCall (new CCodeIdentifier ("g_type_add_interface_static"));
			reg_call.add_argument (new CCodeIdentifier ("g_define_type_id"));
			reg_call.add_argument (new CCodeIdentifier (iface.get_upper_case_cname ("TYPE_")));
			reg_call.add_argument (new CCodeIdentifier ("&%s".printf (iface_info_name)));
			frag.append (new CCodeExpressionStatement (reg_call));
		}
		
		return frag;
	}
}
