/* valacodegeneratorstruct.vala
 *
 * Copyright (C) 2006-2007  Jürg Billeter, Raffaele Sandrini
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
 *	Raffaele Sandrini <rasa@gmx.ch>
 */

using GLib;

public class Vala.CodeGenerator {
	public override void visit_struct (Struct! st) {
		var old_type_symbol = current_type_symbol;
		var old_instance_struct = instance_struct;
		var old_instance_dispose_fragment = instance_dispose_fragment;
		current_type_symbol = st;
		instance_struct = new CCodeStruct ("_%s".printf (st.get_cname ()));
		instance_dispose_fragment = new CCodeFragment ();

		CCodeFragment decl_frag;
		CCodeFragment def_frag;
		if (st.access != SymbolAccessibility.PRIVATE) {
			decl_frag = header_type_declaration;
			def_frag = header_type_definition;
		} else {
			decl_frag = source_type_member_declaration;
			def_frag = source_type_member_declaration;
		}

		if (st.source_reference.file.cycle == null) {
			decl_frag.append (new CCodeTypeDefinition ("struct _%s".printf (st.get_cname ()), new CCodeVariableDeclarator (st.get_cname ())));
		}

		if (st.source_reference.comment != null) {
			def_frag.append (new CCodeComment (st.source_reference.comment));
		}
		def_frag.append (instance_struct);

		st.accept_children (this);

		if (st.default_construction_method != null) {
			var function = new CCodeFunction (st.get_lower_case_cprefix () + "free", "void");
			if (st.access == SymbolAccessibility.PRIVATE) {
				function.modifiers = CCodeModifiers.STATIC;
			}

			function.add_parameter (new CCodeFormalParameter ("self", st.get_cname () + "*"));

			decl_frag.append (function.copy ());

			var cblock = new CCodeBlock ();

			cblock.add_statement (instance_dispose_fragment);

			var ccall = new CCodeFunctionCall (new CCodeIdentifier ("g_slice_free"));
			ccall.add_argument (new CCodeIdentifier (st.get_cname ()));
			ccall.add_argument (new CCodeIdentifier ("self"));
			cblock.add_statement (new CCodeExpressionStatement (ccall));

			function.block = cblock;

			def_frag.append (function);
		}

		current_type_symbol = old_type_symbol;
		instance_struct = old_instance_struct;
		instance_dispose_fragment = old_instance_dispose_fragment;
	}
}
