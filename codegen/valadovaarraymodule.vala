/* valadovaarraymodule.vala
 *
 * Copyright (C) 2006-2010  Jürg Billeter
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

public class Vala.DovaArrayModule : DovaMethodCallModule {
	void append_initializer_list (CCodeCommaExpression ce, CCodeExpression name_cnode, InitializerList initializer_list, ref int i) {
		foreach (Expression e in initializer_list.get_initializers ()) {
			ce.append_expression (new CCodeAssignment (new CCodeElementAccess (name_cnode, new CCodeConstant (i.to_string ())), (CCodeExpression) e.ccodenode));
			i++;
		}
	}

	public override void visit_array_creation_expression (ArrayCreationExpression expr) {
		var array_type = expr.target_type as ArrayType;
		if (array_type != null && array_type.fixed_length) {
			// no heap allocation for fixed-length arrays

			var ce = new CCodeCommaExpression ();
			var temp_var = get_temp_variable (array_type, true, expr);
			var name_cnode = new CCodeIdentifier (temp_var.name);
			int i = 0;

			emit_temp_var (temp_var);

			append_initializer_list (ce, name_cnode, expr.initializer_list, ref i);

			ce.append_expression (name_cnode);

			expr.ccodenode = ce;

			return;
		}

		generate_method_declaration (array_class.default_construction_method, cfile);

		var array_new = new CCodeFunctionCall (new CCodeIdentifier ("dova_array_new"));
		array_new.add_argument (get_type_id_expression (expr.element_type));

		// length of new array
		array_new.add_argument ((CCodeExpression) expr.get_sizes ().get (0).ccodenode);

		expr.ccodenode = array_new;
	}

	public override void visit_element_access (ElementAccess expr) {
		List<Expression> indices = expr.get_indices ();

		var ccontainer = (CCodeExpression) expr.container.ccodenode;
		var cindex = (CCodeExpression) indices[0].ccodenode;

		// access to element in an array
		expr.ccodenode = new CCodeElementAccess (ccontainer, cindex);
	}
}
