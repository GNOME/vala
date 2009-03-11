/* valagtypemodule.vala
 *
 * Copyright (C) 2006-2008  Jürg Billeter, Raffaele Sandrini
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

using GLib;

internal class Vala.GTypeModule : GErrorModule {
	public GTypeModule (CCodeGenerator codegen, CCodeModule? next) {
		base (codegen, next);
	}

	public override void visit_interface (Interface iface) {
		current_symbol = iface;
		current_type_symbol = iface;

		if (iface.get_cname().len () < 3) {
			iface.error = true;
			Report.error (iface.source_reference, "Interface name `%s' is too short".printf (iface.get_cname ()));
			return;
		}

		CCodeDeclarationSpace decl_space;
		if (iface.access != SymbolAccessibility.PRIVATE) {
			decl_space = header_declarations;
		} else {
			decl_space = source_declarations;
		}

		type_struct = new CCodeStruct ("_%s".printf (iface.get_type_cname ()));
		
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


		if (iface.source_reference.file.cycle == null) {
			decl_space.add_type_declaration (new CCodeTypeDefinition ("struct _%s".printf (iface.get_cname ()), new CCodeVariableDeclarator (iface.get_cname ())));
			decl_space.add_type_declaration (new CCodeTypeDefinition ("struct %s".printf (type_struct.name), new CCodeVariableDeclarator (iface.get_type_cname ())));
		}
		
		type_struct.add_field ("GTypeInterface", "parent_iface");

		if (iface.source_reference.comment != null) {
			decl_space.add_type_definition (new CCodeComment (iface.source_reference.comment));
		}
		decl_space.add_type_definition (type_struct);

		iface.accept_children (codegen);

		add_interface_base_init_function (iface);

		var type_fun = new InterfaceRegisterFunction (iface, context);
		type_fun.init_from_type ();
		if (iface.access != SymbolAccessibility.PRIVATE) {
			header_declarations.add_type_member_declaration (type_fun.get_declaration ());
		} else {
			source_declarations.add_type_member_declaration (type_fun.get_declaration ());
		}
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

		CCodeDeclarationSpace decl_space;
		if (st.access != SymbolAccessibility.PRIVATE) {
			decl_space = header_declarations;
		} else {
			decl_space = source_declarations;
		}

		decl_space.add_type_declaration (new CCodeNewline ());
		var macro = "(%s_get_type ())".printf (st.get_lower_case_cname (null));
		decl_space.add_type_declaration (new CCodeMacroReplacement (st.get_type_id (), macro));

		var type_fun = new StructRegisterFunction (st, context);
		type_fun.init_from_type (false);
		if (st.access != SymbolAccessibility.PRIVATE) {
			header_declarations.add_type_member_declaration (type_fun.get_declaration ());
		} else {
			source_declarations.add_type_member_declaration (type_fun.get_declaration ());
		}
		source_type_member_definition.append (type_fun.get_definition ());
	}
}
