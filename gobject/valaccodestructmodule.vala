/* valaccodestructmodule.vala
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

public class Vala.CCodeStructModule : CCodeBaseModule {
	public CCodeStructModule (CCodeGenerator codegen, CCodeModule? next) {
		base (codegen, next);
	}

	public override void visit_struct (Struct st) {
		var old_type_symbol = current_type_symbol;
		var old_instance_struct = instance_struct;
		var old_instance_finalize_fragment = instance_finalize_fragment;
		current_type_symbol = st;
		instance_struct = new CCodeStruct ("_%s".printf (st.get_cname ()));
		instance_finalize_fragment = new CCodeFragment ();

		CCodeFragment decl_frag;
		CCodeFragment def_frag;
		if (st.access != SymbolAccessibility.PRIVATE) {
			decl_frag = header_type_declaration;
			def_frag = header_type_definition;
		} else {
			decl_frag = source_type_declaration;
			def_frag = source_type_definition;
		}

		if (st.source_reference.file.cycle == null) {
			decl_frag.append (new CCodeTypeDefinition ("struct _%s".printf (st.get_cname ()), new CCodeVariableDeclarator (st.get_cname ())));
		}

		if (st.source_reference.comment != null) {
			def_frag.append (new CCodeComment (st.source_reference.comment));
		}
		def_frag.append (instance_struct);

		st.accept_children (codegen);

		if (st.is_disposable ()) {
			add_struct_copy_function (st);
			add_struct_destroy_function (st);
		}

		current_type_symbol = old_type_symbol;
		instance_struct = old_instance_struct;
		instance_finalize_fragment = old_instance_finalize_fragment;
	}

	void add_struct_copy_function (Struct st) {
		var function = new CCodeFunction (st.get_copy_function (), "void");
		if (st.access == SymbolAccessibility.PRIVATE) {
			function.modifiers = CCodeModifiers.STATIC;
		}

		function.add_parameter (new CCodeFormalParameter ("self", "const " + st.get_cname () + "*"));
		function.add_parameter (new CCodeFormalParameter ("dest", st.get_cname () + "*"));

		if (st.access != SymbolAccessibility.PRIVATE) {
			header_type_member_declaration.append (function.copy ());
		} else {
			source_type_member_declaration.append (function.copy ());
		}

		var cblock = new CCodeBlock ();

		function.block = cblock;

		source_type_member_definition.append (function);
	}

	void add_struct_destroy_function (Struct st) {
		var function = new CCodeFunction (st.get_destroy_function (), "void");
		if (st.access == SymbolAccessibility.PRIVATE) {
			function.modifiers = CCodeModifiers.STATIC;
		}

		function.add_parameter (new CCodeFormalParameter ("self", st.get_cname () + "*"));

		if (st.access != SymbolAccessibility.PRIVATE) {
			header_type_member_declaration.append (function.copy ());
		} else {
			source_type_member_declaration.append (function.copy ());
		}

		var cblock = new CCodeBlock ();

		cblock.add_statement (instance_finalize_fragment);

		function.block = cblock;

		source_type_member_definition.append (function);
	}
}

