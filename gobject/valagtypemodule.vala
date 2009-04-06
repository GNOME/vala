/* valagtypemodule.vala
 *
 * Copyright (C) 2006-2009  Jürg Billeter
 * Copyright (C) 2006-2008  Raffaele Sandrini
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
 *	Raffaele Sandrini <raffaele@sandrini.ch>
 */

using Gee;

internal class Vala.GTypeModule : GErrorModule {
	public GTypeModule (CCodeGenerator codegen, CCodeModule? next) {
		base (codegen, next);
	}

	public override void generate_interface_declaration (Interface iface, CCodeDeclarationSpace decl_space) {
		if (decl_space.add_symbol_declaration (iface, iface.get_cname ())) {
			return;
		}

		foreach (DataType prerequisite in iface.get_prerequisites ()) {
			var prereq_cl = prerequisite.data_type as Class;
			var prereq_iface = prerequisite.data_type as Interface;
			if (prereq_cl != null) {
				generate_class_declaration (prereq_cl, decl_space);
			} else if (prereq_iface != null) {
				generate_interface_declaration (prereq_iface, decl_space);
			}
		}

		var type_struct = new CCodeStruct ("_%s".printf (iface.get_type_cname ()));
		
		decl_space.add_type_declaration (new CCodeNewline ());
		var macro = "(%s_get_type ())".printf (iface.get_lower_case_cname (null));
		decl_space.add_type_declaration (new CCodeMacroReplacement (iface.get_type_id (), macro));

		macro = "(G_TYPE_CHECK_INSTANCE_CAST ((obj), %s, %s))".printf (iface.get_type_id (), iface.get_cname ());
		decl_space.add_type_declaration (new CCodeMacroReplacement ("%s(obj)".printf (iface.get_upper_case_cname (null)), macro));

		macro = "(G_TYPE_CHECK_INSTANCE_TYPE ((obj), %s))".printf (iface.get_type_id ());
		decl_space.add_type_declaration (new CCodeMacroReplacement ("%s(obj)".printf (get_type_check_function (iface)), macro));

		macro = "(G_TYPE_INSTANCE_GET_INTERFACE ((obj), %s, %s))".printf (iface.get_type_id (), iface.get_type_cname ());
		decl_space.add_type_declaration (new CCodeMacroReplacement ("%s_GET_INTERFACE(obj)".printf (iface.get_upper_case_cname (null)), macro));
		decl_space.add_type_declaration (new CCodeNewline ());

		decl_space.add_type_declaration (new CCodeTypeDefinition ("struct _%s".printf (iface.get_cname ()), new CCodeVariableDeclarator (iface.get_cname ())));
		decl_space.add_type_declaration (new CCodeTypeDefinition ("struct %s".printf (type_struct.name), new CCodeVariableDeclarator (iface.get_type_cname ())));

		type_struct.add_field ("GTypeInterface", "parent_iface");

		foreach (Method m in iface.get_methods ()) {
			if ((!m.is_abstract && !m.is_virtual) || m.coroutine) {
				continue;
			}

			// add vfunc field to the type struct
			var vdeclarator = new CCodeFunctionDeclarator (m.vfunc_name);
			var cparam_map = new HashMap<int,CCodeFormalParameter> (direct_hash, direct_equal);

			generate_cparameters (m, decl_space, cparam_map, new CCodeFunction ("fake"), vdeclarator);

			var vdecl = new CCodeDeclaration (m.return_type.get_cname ());
			vdecl.add_declarator (vdeclarator);
			type_struct.add_declaration (vdecl);
		}

		foreach (Property prop in iface.get_properties ()) {
			if (!prop.is_abstract && !prop.is_virtual) {
				continue;
			}
			generate_type_declaration (prop.property_type, decl_space);

			var t = (ObjectTypeSymbol) prop.parent_symbol;

			bool returns_real_struct = prop.property_type.is_real_struct_type ();

			var this_type = new ObjectType (t);
			var cselfparam = new CCodeFormalParameter ("self", this_type.get_cname ());

			if (prop.get_accessor != null) {
				var vdeclarator = new CCodeFunctionDeclarator ("get_%s".printf (prop.name));
				vdeclarator.add_parameter (cselfparam);
				string creturn_type;
				if (returns_real_struct) {
					var cvalueparam = new CCodeFormalParameter ("value", prop.get_accessor.value_type.get_cname () + "*");
					vdeclarator.add_parameter (cvalueparam);
					creturn_type = "void";
				} else {
					creturn_type = prop.get_accessor.value_type.get_cname ();
				}
				var vdecl = new CCodeDeclaration (creturn_type);
				vdecl.add_declarator (vdeclarator);
				type_struct.add_declaration (vdecl);
			}
			if (prop.set_accessor != null) {
				var vdeclarator = new CCodeFunctionDeclarator ("set_%s".printf (prop.name));
				vdeclarator.add_parameter (cselfparam);
				if (returns_real_struct) {
					var cvalueparam = new CCodeFormalParameter ("value", prop.set_accessor.value_type.get_cname () + "*");
					vdeclarator.add_parameter (cvalueparam);
				} else {
					var cvalueparam = new CCodeFormalParameter ("value", prop.set_accessor.value_type.get_cname ());
					vdeclarator.add_parameter (cvalueparam);
				}
				var vdecl = new CCodeDeclaration ("void");
				vdecl.add_declarator (vdeclarator);
				type_struct.add_declaration (vdecl);
			}
		}

		if (iface.source_reference.comment != null) {
			decl_space.add_type_definition (new CCodeComment (iface.source_reference.comment));
		}
		decl_space.add_type_definition (type_struct);

		var type_fun = new InterfaceRegisterFunction (iface, context);
		type_fun.init_from_type ();
		decl_space.add_type_member_declaration (type_fun.get_declaration ());
	}

	public override void visit_interface (Interface iface) {
		current_symbol = iface;
		current_type_symbol = iface;

		if (iface.get_cname().len () < 3) {
			iface.error = true;
			Report.error (iface.source_reference, "Interface name `%s' is too short".printf (iface.get_cname ()));
			return;
		}

		generate_interface_declaration (iface, source_declarations);

		iface.accept_children (codegen);

		add_interface_base_init_function (iface);

		var type_fun = new InterfaceRegisterFunction (iface, context);
		type_fun.init_from_type ();
		source_type_member_definition.append (type_fun.get_definition ());

		current_type_symbol = null;
	}

	private void add_interface_base_init_function (Interface iface) {
		var base_init = new CCodeFunction ("%s_base_init".printf (iface.get_lower_case_cname (null)), "void");
		base_init.add_parameter (new CCodeFormalParameter ("iface", "%sIface *".printf (iface.get_cname ())));
		base_init.modifiers = CCodeModifiers.STATIC;
		
		var init_block = new CCodeBlock ();
		
		/* make sure not to run the initialization code twice */
		base_init.block = new CCodeBlock ();
		var decl = new CCodeDeclaration (bool_type.get_cname ());
		decl.modifiers |= CCodeModifiers.STATIC;
		decl.add_declarator (new CCodeVariableDeclarator ("initialized", new CCodeConstant ("FALSE")));
		base_init.block.add_statement (decl);
		var cif = new CCodeIfStatement (new CCodeUnaryExpression (CCodeUnaryOperator.LOGICAL_NEGATION, new CCodeIdentifier ("initialized")), init_block);
		base_init.block.add_statement (cif);
		init_block.add_statement (new CCodeExpressionStatement (new CCodeAssignment (new CCodeIdentifier ("initialized"), new CCodeConstant ("TRUE"))));

		if (iface.is_subtype_of (gobject_type)) {
			/* create properties */
			var props = iface.get_properties ();
			foreach (Property prop in props) {
				if (prop.is_abstract) {
					var cinst = new CCodeFunctionCall (new CCodeIdentifier ("g_object_interface_install_property"));
					cinst.add_argument (new CCodeIdentifier ("iface"));
					cinst.add_argument (head.get_param_spec (prop));

					init_block.add_statement (new CCodeExpressionStatement (cinst));
				}
			}
		}

		/* create signals */
		foreach (Signal sig in iface.get_signals ()) {
			init_block.add_statement (new CCodeExpressionStatement (head.get_signal_creation (sig, iface)));
		}

		// connect default implementations
		foreach (Method m in iface.get_methods ()) {
			if (m.is_virtual) {
				var ciface = new CCodeIdentifier ("iface");
				var cname = m.get_real_cname ();
				base_init.block.add_statement (new CCodeExpressionStatement (new CCodeAssignment (new CCodeMemberAccess.pointer (ciface, m.vfunc_name), new CCodeIdentifier (cname))));
			}
		}

		init_block.add_statement (head.register_dbus_info (iface));

		source_type_member_definition.append (base_init);
	}

	public override void visit_struct (Struct st) {
		base.visit_struct (st);

		source_declarations.add_type_declaration (new CCodeNewline ());
		var macro = "(%s_get_type ())".printf (st.get_lower_case_cname (null));
		source_declarations.add_type_declaration (new CCodeMacroReplacement (st.get_type_id (), macro));

		var type_fun = new StructRegisterFunction (st, context);
		type_fun.init_from_type (false);
		source_declarations.add_type_member_declaration (type_fun.get_declaration ());
		source_type_member_definition.append (type_fun.get_definition ());
	}
}
