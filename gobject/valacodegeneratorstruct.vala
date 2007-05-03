/* valacodegeneratorstruct.vala
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
	public override void visit_begin_struct (Struct! st) {
		current_type_symbol = st.symbol;

		instance_struct = new CCodeStruct ("_%s".printf (st.get_cname ()));

		if (st.source_reference.file.cycle == null) {
			header_type_declaration.append (new CCodeTypeDefinition ("struct _%s".printf (st.get_cname ()), new CCodeVariableDeclarator (st.get_cname ())));
		}

		if (st.source_reference.comment != null) {
			header_type_definition.append (new CCodeComment (st.source_reference.comment));
		}
		header_type_definition.append (instance_struct);
	}
	
	public override void visit_end_struct (Struct! st) {
		current_type_symbol = null;
	}
}
