/* valaccodedynamicpropertymodule.vala
 *
 * Copyright (C) 2008  Jürg Billeter
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
 * The link between a dynamic property and generated code.
 */
public class Vala.CCodeDynamicPropertyModule : CCodeArrayModule {
	int dynamic_property_id;

	public CCodeDynamicPropertyModule (CCodeGenerator codegen, CCodeModule? next) {
		base (codegen, next);
	}

	public override string get_dynamic_property_getter_cname (DynamicProperty node) {
		string getter_cname = "_dynamic_get_%s%d".printf (node.name, dynamic_property_id++);

		var dynamic_property = (DynamicProperty) node;

		var func = new CCodeFunction (getter_cname, node.property_type.get_cname ());
		func.modifiers |= CCodeModifiers.STATIC | CCodeModifiers.INLINE;

		func.add_parameter (new CCodeFormalParameter ("obj", dynamic_property.dynamic_type.get_cname ()));

		var block = new CCodeBlock ();
		if (dynamic_property.dynamic_type.data_type == codegen.dbus_object_type) {
			generate_dbus_property_getter_wrapper (node, block);
		} else if (dynamic_property.dynamic_type.data_type != null
		           && dynamic_property.dynamic_type.data_type.is_subtype_of (codegen.gobject_type)) {
			generate_gobject_property_getter_wrapper (node, block);
		} else {
			Report.error (node.source_reference, "dynamic properties are not supported for `%s'".printf (dynamic_property.dynamic_type.to_string ()));
		}

		// append to C source file
		codegen.source_type_member_declaration.append (func.copy ());

		func.block = block;
		codegen.source_type_member_definition.append (func);

		return getter_cname;
	}

	public override string get_dynamic_property_setter_cname (DynamicProperty node) {
		string setter_cname = "_dynamic_set_%s%d".printf (node.name, dynamic_property_id++);

		var dynamic_property = (DynamicProperty) node;

		var func = new CCodeFunction (setter_cname, "void");
		func.modifiers |= CCodeModifiers.STATIC | CCodeModifiers.INLINE;

		func.add_parameter (new CCodeFormalParameter ("obj", dynamic_property.dynamic_type.get_cname ()));
		func.add_parameter (new CCodeFormalParameter ("value", node.property_type.get_cname ()));

		var block = new CCodeBlock ();
		if (dynamic_property.dynamic_type.data_type == codegen.dbus_object_type) {
			generate_dbus_property_setter_wrapper (node, block);
		} else if (dynamic_property.dynamic_type.data_type != null
		           && dynamic_property.dynamic_type.data_type.is_subtype_of (codegen.gobject_type)) {
			generate_gobject_property_setter_wrapper (node, block);
		} else {
			Report.error (node.source_reference, "dynamic properties are not supported for `%s'".printf (dynamic_property.dynamic_type.to_string ()));
		}

		// append to C source file
		codegen.source_type_member_declaration.append (func.copy ());

		func.block = block;
		codegen.source_type_member_definition.append (func);

		return setter_cname;
	}

	void generate_gobject_property_getter_wrapper (DynamicProperty node, CCodeBlock block) {
		var cdecl = new CCodeDeclaration (node.property_type.get_cname ());
		cdecl.add_declarator (new CCodeVariableDeclarator ("result"));
		block.add_statement (cdecl);

		var call = new CCodeFunctionCall (new CCodeIdentifier ("g_object_get"));
		call.add_argument (new CCodeIdentifier ("obj"));
		call.add_argument (node.get_canonical_cconstant ());
		call.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, new CCodeIdentifier ("result")));
		call.add_argument (new CCodeConstant ("NULL"));

		block.add_statement (new CCodeExpressionStatement (call));

		block.add_statement (new CCodeReturnStatement (new CCodeIdentifier ("result")));
	}

	void generate_gobject_property_setter_wrapper (DynamicProperty node, CCodeBlock block) {
		var call = new CCodeFunctionCall (new CCodeIdentifier ("g_object_set"));
		call.add_argument (new CCodeIdentifier ("obj"));
		call.add_argument (node.get_canonical_cconstant ());
		call.add_argument (new CCodeIdentifier ("value"));
		call.add_argument (new CCodeConstant ("NULL"));

		block.add_statement (new CCodeExpressionStatement (call));
	}

	void create_dbus_property_proxy (DynamicProperty node, CCodeBlock block) {
		var prop_proxy_call = new CCodeFunctionCall (new CCodeIdentifier ("dbus_g_proxy_new_from_proxy"));
		prop_proxy_call.add_argument (new CCodeIdentifier ("obj"));
		prop_proxy_call.add_argument (new CCodeConstant ("DBUS_INTERFACE_PROPERTIES"));
		prop_proxy_call.add_argument (new CCodeConstant ("NULL"));

		var prop_proxy_decl = new CCodeDeclaration ("DBusGProxy*");
		prop_proxy_decl.add_declarator (new CCodeVariableDeclarator.with_initializer ("property_proxy", prop_proxy_call));
		block.add_statement (prop_proxy_decl);
	}

	void generate_dbus_property_getter_wrapper (DynamicProperty node, CCodeBlock block) {
		create_dbus_property_proxy (node, block);

		// initialize GValue
		var cvalinit = new CCodeInitializerList ();
		cvalinit.append (new CCodeConstant ("0"));

		var cval_decl = new CCodeDeclaration ("GValue");
		cval_decl.add_declarator (new CCodeVariableDeclarator.with_initializer ("gvalue", cvalinit));
		block.add_statement (cval_decl);

		var val_ptr = new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, new CCodeIdentifier ("gvalue"));

		// call Get method on property proxy
		var cdecl = new CCodeDeclaration (node.property_type.get_cname ());
		cdecl.add_declarator (new CCodeVariableDeclarator ("result"));
		block.add_statement (cdecl);

		var ccall = new CCodeFunctionCall (new CCodeIdentifier ("dbus_g_proxy_call"));
		ccall.add_argument (new CCodeIdentifier ("property_proxy"));
		ccall.add_argument (new CCodeConstant ("\"Get\""));
		ccall.add_argument (new CCodeConstant ("NULL"));

		ccall.add_argument (new CCodeIdentifier ("G_TYPE_STRING"));
		var get_iface = new CCodeFunctionCall (new CCodeIdentifier ("dbus_g_proxy_get_interface"));
		get_iface.add_argument (new CCodeIdentifier ("obj"));
		ccall.add_argument (get_iface);

		ccall.add_argument (new CCodeIdentifier ("G_TYPE_STRING"));
		ccall.add_argument (new CCodeConstant ("\"%s\"".printf (Symbol.lower_case_to_camel_case (node.name))));

		ccall.add_argument (new CCodeIdentifier ("G_TYPE_INVALID"));

		ccall.add_argument (new CCodeIdentifier ("G_TYPE_VALUE"));
		ccall.add_argument (val_ptr);

		ccall.add_argument (new CCodeIdentifier ("G_TYPE_INVALID"));

		block.add_statement (new CCodeExpressionStatement (ccall));

		// unref property proxy
		var prop_proxy_unref = new CCodeFunctionCall (new CCodeIdentifier ("g_object_unref"));
		prop_proxy_unref.add_argument (new CCodeIdentifier ("property_proxy"));
		block.add_statement (new CCodeExpressionStatement (prop_proxy_unref));

		// assign value to result variable
		var cget_call = new CCodeFunctionCall (new CCodeIdentifier (node.property_type.data_type.get_get_value_function ()));
		cget_call.add_argument (val_ptr);
		var assign = new CCodeAssignment (new CCodeIdentifier ("result"), cget_call);
		block.add_statement (new CCodeExpressionStatement (assign));

		// return result
		block.add_statement (new CCodeReturnStatement (new CCodeIdentifier ("result")));
	}

	void generate_dbus_property_setter_wrapper (DynamicProperty node, CCodeBlock block) {
		create_dbus_property_proxy (node, block);

		// initialize GValue
		var cvalinit = new CCodeInitializerList ();
		cvalinit.append (new CCodeConstant ("0"));

		var cval_decl = new CCodeDeclaration ("GValue");
		cval_decl.add_declarator (new CCodeVariableDeclarator.with_initializer ("gvalue", cvalinit));
		block.add_statement (cval_decl);

		var val_ptr = new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, new CCodeIdentifier ("gvalue"));

		var cinit_call = new CCodeFunctionCall (new CCodeIdentifier ("g_value_init"));
		cinit_call.add_argument (val_ptr);
		cinit_call.add_argument (new CCodeIdentifier (node.property_type.data_type.get_type_id ()));
		block.add_statement (new CCodeExpressionStatement (cinit_call));

		var cset_call = new CCodeFunctionCall (new CCodeIdentifier (node.property_type.data_type.get_set_value_function ()));
		cset_call.add_argument (val_ptr);
		cset_call.add_argument (new CCodeIdentifier ("value"));
		block.add_statement (new CCodeExpressionStatement (cset_call));

		// call Set method on property proxy
		var ccall = new CCodeFunctionCall (new CCodeIdentifier ("dbus_g_proxy_call"));
		ccall.add_argument (new CCodeIdentifier ("property_proxy"));
		ccall.add_argument (new CCodeConstant ("\"Set\""));
		ccall.add_argument (new CCodeConstant ("NULL"));

		ccall.add_argument (new CCodeIdentifier ("G_TYPE_STRING"));
		var get_iface = new CCodeFunctionCall (new CCodeIdentifier ("dbus_g_proxy_get_interface"));
		get_iface.add_argument (new CCodeIdentifier ("obj"));
		ccall.add_argument (get_iface);

		ccall.add_argument (new CCodeIdentifier ("G_TYPE_STRING"));
		ccall.add_argument (new CCodeConstant ("\"%s\"".printf (Symbol.lower_case_to_camel_case (node.name))));

		ccall.add_argument (new CCodeIdentifier ("G_TYPE_VALUE"));
		ccall.add_argument (val_ptr);

		ccall.add_argument (new CCodeIdentifier ("G_TYPE_INVALID"));

		ccall.add_argument (new CCodeIdentifier ("G_TYPE_INVALID"));

		block.add_statement (new CCodeExpressionStatement (ccall));

		// unref property proxy
		var prop_proxy_unref = new CCodeFunctionCall (new CCodeIdentifier ("g_object_unref"));
		prop_proxy_unref.add_argument (new CCodeIdentifier ("property_proxy"));
		block.add_statement (new CCodeExpressionStatement (prop_proxy_unref));
	}
}
