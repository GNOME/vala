/* valacodegeneratorinterface.vala
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

public class Vala.CodeGenerator {
	public override void visit_interface (Interface! iface) {
		current_symbol = iface;
		current_type_symbol = iface;

		CCodeFragment decl_frag;
		CCodeFragment def_frag;
		if (iface.access != MemberAccessibility.PRIVATE) {
			decl_frag = header_type_declaration;
			def_frag = header_type_definition;
		} else {
			decl_frag = source_type_member_declaration;
			def_frag = source_type_member_declaration;
		}

		if (!iface.is_static && !iface.declaration_only) {
			type_struct = new CCodeStruct ("_%s".printf (iface.get_type_cname ()));
			
			decl_frag.append (new CCodeNewline ());
			var macro = "(%s_get_type ())".printf (iface.get_lower_case_cname (null));
			decl_frag.append (new CCodeMacroReplacement (iface.get_upper_case_cname ("TYPE_"), macro));

			macro = "(G_TYPE_CHECK_INSTANCE_CAST ((obj), %s, %s))".printf (iface.get_upper_case_cname ("TYPE_"), iface.get_cname ());
			decl_frag.append (new CCodeMacroReplacement ("%s(obj)".printf (iface.get_upper_case_cname (null)), macro));

			macro = "(G_TYPE_CHECK_INSTANCE_TYPE ((obj), %s))".printf (iface.get_upper_case_cname ("TYPE_"));
			decl_frag.append (new CCodeMacroReplacement ("%s(obj)".printf (iface.get_upper_case_cname ("IS_")), macro));

			macro = "(G_TYPE_INSTANCE_GET_INTERFACE ((obj), %s, %s))".printf (iface.get_upper_case_cname ("TYPE_"), iface.get_type_cname ());
			decl_frag.append (new CCodeMacroReplacement ("%s_GET_INTERFACE(obj)".printf (iface.get_upper_case_cname (null)), macro));
			decl_frag.append (new CCodeNewline ());


			if (iface.source_reference.file.cycle == null) {
				decl_frag.append (new CCodeTypeDefinition ("struct _%s".printf (iface.get_cname ()), new CCodeVariableDeclarator (iface.get_cname ())));
				decl_frag.append (new CCodeTypeDefinition ("struct %s".printf (type_struct.name), new CCodeVariableDeclarator (iface.get_type_cname ())));
			}
			
			type_struct.add_field ("GTypeInterface", "parent");

			if (iface.source_reference.comment != null) {
				def_frag.append (new CCodeComment (iface.source_reference.comment));
			}
			def_frag.append (type_struct);
		}

		iface.accept_children (this);

		if (!iface.is_static && !iface.declaration_only) {
			add_interface_base_init_function (iface);

			var type_fun = new InterfaceRegisterFunction (iface);
			type_fun.init_from_type ();
			if (iface.access != MemberAccessibility.PRIVATE) {
				header_type_member_declaration.append (type_fun.get_declaration ());
			} else {
				source_type_member_declaration.append (type_fun.get_declaration ());
			}
			source_type_member_definition.append (type_fun.get_definition ());
		}

		current_type_symbol = null;
	}
	
	private CCodeFunctionCall! get_param_spec (Property! prop) {
		var cspec = new CCodeFunctionCall ();
		cspec.add_argument (prop.get_canonical_cconstant ());
		cspec.add_argument (new CCodeConstant ("\"foo\""));
		cspec.add_argument (new CCodeConstant ("\"bar\""));
		if (prop.type_reference.data_type is Class || prop.type_reference.data_type is Interface) {
			cspec.call = new CCodeIdentifier ("g_param_spec_object");
			cspec.add_argument (new CCodeIdentifier (prop.type_reference.data_type.get_upper_case_cname ("TYPE_")));
		} else if (prop.type_reference.data_type == string_type.data_type) {
			cspec.call = new CCodeIdentifier ("g_param_spec_string");
			cspec.add_argument (new CCodeConstant ("NULL"));
		} else if (prop.type_reference.data_type == int_type.data_type
			   || prop.type_reference.data_type is Enum) {
			cspec.call = new CCodeIdentifier ("g_param_spec_int");
			cspec.add_argument (new CCodeConstant ("G_MININT"));
			cspec.add_argument (new CCodeConstant ("G_MAXINT"));
			cspec.add_argument (new CCodeConstant ("0"));
		} else if (prop.type_reference.data_type == uint_type.data_type) {
			cspec.call = new CCodeIdentifier ("g_param_spec_uint");
			cspec.add_argument (new CCodeConstant ("0"));
			cspec.add_argument (new CCodeConstant ("G_MAXUINT"));
			cspec.add_argument (new CCodeConstant ("0U"));
		} else if (prop.type_reference.data_type == long_type.data_type) {
			cspec.call = new CCodeIdentifier ("g_param_spec_long");
			cspec.add_argument (new CCodeConstant ("G_MINLONG"));
			cspec.add_argument (new CCodeConstant ("G_MAXLONG"));
			cspec.add_argument (new CCodeConstant ("0L"));
		} else if (prop.type_reference.data_type == ulong_type.data_type) {
			cspec.call = new CCodeIdentifier ("g_param_spec_ulong");
			cspec.add_argument (new CCodeConstant ("0"));
			cspec.add_argument (new CCodeConstant ("G_MAXULONG"));
			cspec.add_argument (new CCodeConstant ("0UL"));
		} else if (prop.type_reference.data_type == bool_type.data_type) {
			cspec.call = new CCodeIdentifier ("g_param_spec_boolean");
			cspec.add_argument (new CCodeConstant ("FALSE"));
		} else if (prop.type_reference.data_type == float_type.data_type) {
			cspec.call = new CCodeIdentifier ("g_param_spec_float");
			cspec.add_argument (new CCodeConstant ("-G_MAXFLOAT"));
			cspec.add_argument (new CCodeConstant ("G_MAXFLOAT"));
			cspec.add_argument (new CCodeConstant ("0.0F"));
		} else if (prop.type_reference.data_type == double_type.data_type) {
			cspec.call = new CCodeIdentifier ("g_param_spec_double");
			cspec.add_argument (new CCodeConstant ("-G_MAXDOUBLE"));
			cspec.add_argument (new CCodeConstant ("G_MAXDOUBLE"));
			cspec.add_argument (new CCodeConstant ("0.0"));
		} else {
			cspec.call = new CCodeIdentifier ("g_param_spec_pointer");
		}
		
		var pflags = "G_PARAM_STATIC_NAME | G_PARAM_STATIC_NICK | G_PARAM_STATIC_BLURB";
		if (prop.get_accessor != null) {
			pflags = "%s%s".printf (pflags, " | G_PARAM_READABLE");
		}
		if (prop.set_accessor != null) {
			pflags = "%s%s".printf (pflags, " | G_PARAM_WRITABLE");
			if (prop.set_accessor.construction) {
				if (prop.set_accessor.writable) {
					pflags = "%s%s".printf (pflags, " | G_PARAM_CONSTRUCT");
				} else {
					pflags = "%s%s".printf (pflags, " | G_PARAM_CONSTRUCT_ONLY");
				}
			}
		}
		cspec.add_argument (new CCodeConstant (pflags));

		return cspec;
	}

	private CCodeFunctionCall! get_signal_creation (Signal! sig, DataType! type) {	
		var csignew = new CCodeFunctionCall (new CCodeIdentifier ("g_signal_new"));
		csignew.add_argument (new CCodeConstant ("\"%s\"".printf (sig.name)));
		csignew.add_argument (new CCodeIdentifier (type.get_upper_case_cname ("TYPE_")));
		csignew.add_argument (new CCodeConstant ("G_SIGNAL_RUN_LAST"));
		csignew.add_argument (new CCodeConstant ("0"));
		csignew.add_argument (new CCodeConstant ("NULL"));
		csignew.add_argument (new CCodeConstant ("NULL"));

		string marshaller = get_signal_marshaller_function (sig);

		var marshal_arg = new CCodeIdentifier (marshaller);
		csignew.add_argument (marshal_arg);

		var params = sig.get_parameters ();
		var params_len = params.size;
		if (sig.return_type.type_parameter != null) {
			csignew.add_argument (new CCodeConstant ("G_TYPE_POINTER"));
		} else if (sig.return_type.data_type == null) {
			csignew.add_argument (new CCodeConstant ("G_TYPE_NONE"));
		} else {
			csignew.add_argument (new CCodeConstant (sig.return_type.data_type.get_type_id ()));
		}
		csignew.add_argument (new CCodeConstant ("%d".printf (params_len)));
		foreach (FormalParameter param in params) {
			if (param.type_reference.type_parameter != null) {
				csignew.add_argument (new CCodeConstant ("G_TYPE_POINTER"));
			} else {
				csignew.add_argument (new CCodeConstant (param.type_reference.data_type.get_type_id ()));
			}
		}

		marshal_arg.name = marshaller;

		return csignew;
	}

	private void add_interface_base_init_function (Interface! iface) {
		var base_init = new CCodeFunction ("%s_base_init".printf (iface.get_lower_case_cname (null)), "void");
		base_init.add_parameter (new CCodeFormalParameter ("iface", "%sIface *".printf (iface.get_cname ())));
		base_init.modifiers = CCodeModifiers.STATIC;
		
		var init_block = new CCodeBlock ();
		
		/* make sure not to run the initialization code twice */
		base_init.block = new CCodeBlock ();
		var decl = new CCodeDeclaration (bool_type.get_cname ());
		decl.modifiers |= CCodeModifiers.STATIC;
		decl.add_declarator (new CCodeVariableDeclarator.with_initializer ("initialized", new CCodeConstant ("FALSE")));
		base_init.block.add_statement (decl);
		var cif = new CCodeIfStatement (new CCodeUnaryExpression (CCodeUnaryOperator.LOGICAL_NEGATION, new CCodeIdentifier ("initialized")), init_block);
		base_init.block.add_statement (cif);
		init_block.add_statement (new CCodeExpressionStatement (new CCodeAssignment (new CCodeIdentifier ("initialized"), new CCodeConstant ("TRUE"))));
		
		/* create properties */
		var props = iface.get_properties ();
		foreach (Property prop in props) {
			var cinst = new CCodeFunctionCall (new CCodeIdentifier ("g_object_interface_install_property"));
			cinst.add_argument (new CCodeIdentifier ("iface"));
			cinst.add_argument (get_param_spec (prop));

			init_block.add_statement (new CCodeExpressionStatement (cinst));
		}
		
		/* create signals */
		foreach (Signal sig in iface.get_signals ()) {
			init_block.add_statement (new CCodeExpressionStatement (get_signal_creation (sig, iface)));
		}
		
		source_type_member_definition.append (base_init);
	}
}
