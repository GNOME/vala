/* valagdbusmodule.vala
 *
 * Copyright (C) 2010  Jürg Billeter
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

public class Vala.GDBusModule : GVariantModule {
	public GDBusModule (CCodeGenerator codegen, CCodeModule? next) {
		base (codegen, next);
	}

	public static string? get_dbus_name (TypeSymbol symbol) {
		var dbus = symbol.get_attribute ("DBus");
		if (dbus == null) {
			return null;
		}

		return dbus.get_string ("name");
	}

	public static string get_dbus_name_for_member (Symbol symbol) {
		var dbus = symbol.get_attribute ("DBus");
		if (dbus != null && dbus.has_argument ("name")) {
			return dbus.get_string ("name");
		}

		return Symbol.lower_case_to_camel_case (symbol.name);
	}

	public override void visit_error_domain (ErrorDomain edomain) {
		var edomain_dbus_name = get_dbus_name (edomain);
		if (edomain_dbus_name == null) {
			base.visit_error_domain (edomain);
			return;
		}

		generate_error_domain_declaration (edomain, source_declarations);

		if (!edomain.is_internal_symbol ()) {
			generate_error_domain_declaration (edomain, header_declarations);
		}
		if (!edomain.is_private_symbol ()) {
			generate_error_domain_declaration (edomain, internal_header_declarations);
		}

		var error_entries = new CCodeInitializerList ();
		foreach (ErrorCode ecode in edomain.get_codes ()) {
			var ecode_dbus_name = get_dbus_name (ecode);
			if (ecode_dbus_name == null) {
				ecode_dbus_name = Symbol.lower_case_to_camel_case (ecode.name.down ());
			}

			var error_entry = new CCodeInitializerList ();
			error_entry.append (new CCodeIdentifier (ecode.get_cname ()));
			error_entry.append (new CCodeConstant ("\"%s.%s\"".printf (edomain_dbus_name, ecode_dbus_name)));
			error_entries.append (error_entry);
		}

		var cdecl = new CCodeDeclaration ("const GDBusErrorEntry");
		cdecl.add_declarator (new CCodeVariableDeclarator (edomain.get_lower_case_cname () + "_entries[]", error_entries));
		cdecl.modifiers = CCodeModifiers.STATIC;
		source_declarations.add_constant_declaration (cdecl);

		string quark_fun_name = edomain.get_lower_case_cprefix () + "quark";

		var cquark_fun = new CCodeFunction (quark_fun_name, gquark_type.data_type.get_cname ());
		var cquark_block = new CCodeBlock ();

		string quark_name = "%squark_volatile".printf (edomain.get_lower_case_cprefix ());

		cdecl = new CCodeDeclaration ("gsize");
		cdecl.add_declarator (new CCodeVariableDeclarator (quark_name, new CCodeConstant ("0")));
		cdecl.modifiers = CCodeModifiers.STATIC | CCodeModifiers.VOLATILE;
		cquark_block.add_statement (cdecl);

		var register_call = new CCodeFunctionCall (new CCodeIdentifier ("g_dbus_error_register_error_domain"));
		register_call.add_argument (new CCodeConstant ("\"" + edomain.get_lower_case_cname () + "-quark\""));
		register_call.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, new CCodeIdentifier (quark_name)));
		register_call.add_argument (new CCodeIdentifier (edomain.get_lower_case_cname () + "_entries"));
		var nentries = new CCodeFunctionCall (new CCodeIdentifier ("G_N_ELEMENTS"));
		nentries.add_argument (new CCodeIdentifier (edomain.get_lower_case_cname () + "_entries"));
		register_call.add_argument (nentries);
		cquark_block.add_statement (new CCodeExpressionStatement (register_call));

		cquark_block.add_statement (new CCodeReturnStatement (new CCodeCastExpression (new CCodeIdentifier (quark_name), "GQuark")));

		cquark_fun.block = cquark_block;
		source_type_member_definition.append (cquark_fun);
	}

	public override CCodeFragment register_dbus_info (ObjectTypeSymbol sym) {
		return new CCodeFragment ();
	}
}
