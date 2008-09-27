/* valaccodeinterfacebinding.vala
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

public class Vala.CCodeInterfaceBinding : CCodeObjectTypeSymbolBinding {
	public Interface iface { get; set; }

	public CCodeInterfaceBinding (CCodeGenerator codegen, Interface iface) {
		this.iface = iface;
		this.codegen = codegen;
	}

	public override void emit () {
		codegen.current_symbol = iface;
		codegen.current_type_symbol = iface;

		if (iface.get_cname().len () < 3) {
			iface.error = true;
			Report.error (iface.source_reference, "Interface name `%s' is too short".printf (iface.get_cname ()));
			return;
		}

		CCodeFragment decl_frag;
		CCodeFragment def_frag;
		if (iface.access != SymbolAccessibility.PRIVATE) {
			decl_frag = codegen.header_type_declaration;
			def_frag = codegen.header_type_definition;
		} else {
			decl_frag = codegen.source_type_declaration;
			def_frag = codegen.source_type_definition;
		}

		if (!iface.is_static) {
			codegen.type_struct = new CCodeStruct ("_%s".printf (iface.get_type_cname ()));
			
			decl_frag.append (new CCodeNewline ());
			var macro = "(%s_get_type ())".printf (iface.get_lower_case_cname (null));
			decl_frag.append (new CCodeMacroReplacement (iface.get_type_id (), macro));

			macro = "(G_TYPE_CHECK_INSTANCE_CAST ((obj), %s, %s))".printf (iface.get_type_id (), iface.get_cname ());
			decl_frag.append (new CCodeMacroReplacement ("%s(obj)".printf (iface.get_upper_case_cname (null)), macro));

			macro = "(G_TYPE_CHECK_INSTANCE_TYPE ((obj), %s))".printf (iface.get_type_id ());
			decl_frag.append (new CCodeMacroReplacement ("%s(obj)".printf (codegen.get_type_check_function (iface)), macro));

			macro = "(G_TYPE_INSTANCE_GET_INTERFACE ((obj), %s, %s))".printf (iface.get_type_id (), iface.get_type_cname ());
			decl_frag.append (new CCodeMacroReplacement ("%s_GET_INTERFACE(obj)".printf (iface.get_upper_case_cname (null)), macro));
			decl_frag.append (new CCodeNewline ());


			if (iface.source_reference.file.cycle == null) {
				decl_frag.append (new CCodeTypeDefinition ("struct _%s".printf (iface.get_cname ()), new CCodeVariableDeclarator (iface.get_cname ())));
				decl_frag.append (new CCodeTypeDefinition ("struct %s".printf (codegen.type_struct.name), new CCodeVariableDeclarator (iface.get_type_cname ())));
			}
			
			codegen.type_struct.add_field ("GTypeInterface", "parent_iface");

			if (iface.source_reference.comment != null) {
				def_frag.append (new CCodeComment (iface.source_reference.comment));
			}
			def_frag.append (codegen.type_struct);
		}

		iface.accept_children (codegen);

		if (!iface.is_static) {
			add_interface_base_init_function (iface);

			var type_fun = new InterfaceRegisterFunction (iface, codegen);
			type_fun.init_from_type ();
			if (iface.access != SymbolAccessibility.PRIVATE) {
				codegen.header_type_member_declaration.append (type_fun.get_declaration ());
			} else {
				codegen.source_type_member_declaration.append (type_fun.get_declaration ());
			}
			codegen.source_type_member_definition.append (type_fun.get_definition ());
		}

		codegen.current_type_symbol = null;
	}

	private void add_interface_base_init_function (Interface iface) {
		var base_init = new CCodeFunction ("%s_base_init".printf (iface.get_lower_case_cname (null)), "void");
		base_init.add_parameter (new CCodeFormalParameter ("iface", "%sIface *".printf (iface.get_cname ())));
		base_init.modifiers = CCodeModifiers.STATIC;
		
		var init_block = new CCodeBlock ();
		
		/* make sure not to run the initialization code twice */
		base_init.block = new CCodeBlock ();
		var decl = new CCodeDeclaration (codegen.bool_type.get_cname ());
		decl.modifiers |= CCodeModifiers.STATIC;
		decl.add_declarator (new CCodeVariableDeclarator.with_initializer ("initialized", new CCodeConstant ("FALSE")));
		base_init.block.add_statement (decl);
		var cif = new CCodeIfStatement (new CCodeUnaryExpression (CCodeUnaryOperator.LOGICAL_NEGATION, new CCodeIdentifier ("initialized")), init_block);
		base_init.block.add_statement (cif);
		init_block.add_statement (new CCodeExpressionStatement (new CCodeAssignment (new CCodeIdentifier ("initialized"), new CCodeConstant ("TRUE"))));

		if (iface.is_subtype_of (codegen.gobject_type)) {
			/* create properties */
			var props = iface.get_properties ();
			foreach (Property prop in props) {
				if (prop.is_abstract) {
					var cinst = new CCodeFunctionCall (new CCodeIdentifier ("g_object_interface_install_property"));
					cinst.add_argument (new CCodeIdentifier ("iface"));
					cinst.add_argument (get_param_spec (prop));

					init_block.add_statement (new CCodeExpressionStatement (cinst));
				}
			}
		}

		/* create signals */
		foreach (Signal sig in iface.get_signals ()) {
			init_block.add_statement (new CCodeExpressionStatement (get_signal_creation (sig, iface)));
		}

		// connect default implementations
		foreach (Method m in iface.get_methods ()) {
			if (m.is_virtual) {
				var ciface = new CCodeIdentifier ("iface");
				var cname = m.get_real_cname ();
				base_init.block.add_statement (new CCodeExpressionStatement (new CCodeAssignment (new CCodeMemberAccess.pointer (ciface, m.vfunc_name), new CCodeIdentifier (cname))));
			}
		}

		init_block.add_statement (register_dbus_info (iface));

		codegen.source_type_member_definition.append (base_init);
	}
}
