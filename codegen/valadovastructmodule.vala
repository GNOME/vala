/* valadovastructmodule.vala
 *
 * Copyright (C) 2006-2009  Jürg Billeter
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

internal class Vala.DovaStructModule : DovaBaseModule {
	public DovaStructModule (CCodeGenerator codegen, CCodeModule? next) {
		base (codegen, next);
	}

	public override void generate_struct_declaration (Struct st, CCodeDeclarationSpace decl_space) {
		if (decl_space.add_symbol_declaration (st, st.get_cname ())) {
			return;
		}

		if (st.base_struct != null) {
			generate_struct_declaration (st.base_struct, decl_space);

			decl_space.add_type_declaration (new CCodeTypeDefinition (st.base_struct.get_cname (), new CCodeVariableDeclarator (st.get_cname ())));
			return;
		}

		if (st.is_boolean_type ()) {
			// typedef for boolean types
			decl_space.add_include ("stdbool.h");
			st.set_cname ("bool");
			return;
		} else if (st.is_integer_type ()) {
			// typedef for integral types
			decl_space.add_include ("stdint.h");
			st.set_cname ("%sint%d_t".printf (st.signed ? "" : "u", st.width));
			return;
		} else if (st.is_decimal_floating_type ()) {
			// typedef for decimal floating types
			st.set_cname ("_Decimal%d".printf (st.width));
			return;
		} else if (st.is_floating_type ()) {
			// typedef for generic floating types
			st.set_cname (st.width == 64 ? "double" : "float");
			return;
		}

		var instance_struct = new CCodeStruct ("_%s".printf (st.get_cname ()));

		foreach (Field f in st.get_fields ()) {
			string field_ctype = f.field_type.get_cname ();
			if (f.is_volatile) {
				field_ctype = "volatile " + field_ctype;
			}

			if (f.binding == MemberBinding.INSTANCE)  {
				generate_type_declaration (f.field_type, decl_space);

				instance_struct.add_field (field_ctype, f.get_cname () + f.field_type.get_cdeclarator_suffix ());
			}
		}

		decl_space.add_type_declaration (new CCodeTypeDefinition ("struct _%s".printf (st.get_cname ()), new CCodeVariableDeclarator (st.get_cname ())));

		decl_space.add_type_definition (instance_struct);
	}

	public override void visit_struct (Struct st) {
		var old_symbol = current_symbol;
		var old_instance_finalize_fragment = instance_finalize_fragment;
		current_symbol = st;
		instance_finalize_fragment = new CCodeFragment ();

		generate_struct_declaration (st, source_declarations);

		if (!st.is_internal_symbol ()) {
			generate_struct_declaration (st, header_declarations);
		}

		st.accept_children (codegen);

		current_symbol = old_symbol;
		instance_finalize_fragment = old_instance_finalize_fragment;
	}
}

