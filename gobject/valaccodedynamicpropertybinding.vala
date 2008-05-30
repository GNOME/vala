/* valaccodedynamicpropertybinding.vala
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
public class Vala.CCodeDynamicPropertyBinding : CCodeBinding {
	public Property node { get; set; }

	string? getter_cname;
	string? setter_cname;

	static int dynamic_property_id;

	public CCodeDynamicPropertyBinding (CCodeGenerator codegen, DynamicProperty property) {
		this.node = property;
		this.codegen = codegen;
	}

	public string get_getter_cname () {
		if (getter_cname != null) {
			return getter_cname;
		}

		getter_cname = "_dynamic_get_%s%d".printf (node.name, dynamic_property_id++);

		var dynamic_property = (DynamicProperty) node;

		var func = new CCodeFunction (getter_cname, node.property_type.get_cname ());

		func.add_parameter (new CCodeFormalParameter ("obj", dynamic_property.dynamic_type.get_cname ()));

		var block = new CCodeBlock ();
		if (dynamic_property.dynamic_type.data_type == codegen.gobject_type) {
			generate_gobject_property_getter_wrapper (block);
		} else {
			Report.error (node.source_reference, "dynamic properties are not supported for `%s'".printf (dynamic_property.dynamic_type.to_string ()));
		}

		// append to C source file
		codegen.source_type_member_declaration.append (func.copy ());

		func.block = block;
		codegen.source_type_member_definition.append (func);

		return getter_cname;
	}

	public string get_setter_cname () {
		if (setter_cname != null) {
			return setter_cname;
		}

		getter_cname = "_dynamic_set_%s%d".printf (node.name, dynamic_property_id++);

		var dynamic_property = (DynamicProperty) node;

		var func = new CCodeFunction (getter_cname, "void");

		func.add_parameter (new CCodeFormalParameter ("obj", dynamic_property.dynamic_type.get_cname ()));
		func.add_parameter (new CCodeFormalParameter ("value", node.property_type.get_cname ()));

		var block = new CCodeBlock ();
		if (dynamic_property.dynamic_type.data_type == codegen.gobject_type) {
			generate_gobject_property_setter_wrapper (block);
		} else {
			Report.error (node.source_reference, "dynamic properties are not supported for `%s'".printf (dynamic_property.dynamic_type.to_string ()));
		}

		// append to C source file
		codegen.source_type_member_declaration.append (func.copy ());

		func.block = block;
		codegen.source_type_member_definition.append (func);

		return getter_cname;
	}

	void generate_gobject_property_getter_wrapper (CCodeBlock block) {
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

	void generate_gobject_property_setter_wrapper (CCodeBlock block) {
		var call = new CCodeFunctionCall (new CCodeIdentifier ("g_object_set"));
		call.add_argument (new CCodeIdentifier ("obj"));
		call.add_argument (node.get_canonical_cconstant ());
		call.add_argument (new CCodeIdentifier ("value"));
		call.add_argument (new CCodeConstant ("NULL"));

		block.add_statement (new CCodeExpressionStatement (call));
	}
}
