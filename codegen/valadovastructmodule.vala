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

public class Vala.DovaStructModule : DovaBaseModule {
	public override void generate_struct_declaration (Struct st, CCodeFile decl_space) {
		if (add_symbol_declaration (decl_space, st, st.get_cname ())) {
			return;
		}

		if (st.base_struct != null) {
			generate_struct_declaration (st.base_struct, decl_space);

			decl_space.add_type_declaration (new CCodeTypeDefinition (st.base_struct.get_cname (), new CCodeVariableDeclarator (st.get_cname ())));
			return;
		}

		if (st.is_boolean_type ()) {
			// typedef for boolean types
			return;
		} else if (st.is_integer_type ()) {
			// typedef for integral types
			return;
		} else if (st.is_decimal_floating_type ()) {
			// typedef for decimal floating types
			return;
		} else if (st.is_floating_type ()) {
			// typedef for generic floating types
			return;
		}

		var instance_struct = new CCodeStruct ("_%s".printf (st.get_cname ()));

		foreach (Field f in st.get_fields ()) {
			string field_ctype = f.variable_type.get_cname ();
			if (f.is_volatile) {
				field_ctype = "volatile " + field_ctype;
			}

			if (f.binding == MemberBinding.INSTANCE)  {
				generate_type_declaration (f.variable_type, decl_space);

				instance_struct.add_field (field_ctype, f.get_cname () + f.variable_type.get_cdeclarator_suffix ());
			}
		}

		decl_space.add_type_declaration (new CCodeTypeDefinition ("struct _%s".printf (st.get_cname ()), new CCodeVariableDeclarator (st.get_cname ())));

		decl_space.add_type_definition (instance_struct);
	}

	public override void visit_struct (Struct st) {
		push_context (new EmitContext (st));

		generate_struct_declaration (st, cfile);

		if (!st.is_internal_symbol ()) {
			generate_struct_declaration (st, header_file);
		}

		st.accept_children (this);

		pop_context ();
	}
}

