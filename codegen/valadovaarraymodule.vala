/* valadovaarraymodule.vala
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

internal class Vala.DovaArrayModule : DovaMethodCallModule {
	public DovaArrayModule (CCodeGenerator codegen, CCodeModule? next) {
		base (codegen, next);
	}

	void append_initializer_list (CCodeCommaExpression ce, CCodeExpression name_cnode, InitializerList initializer_list, int rank, ref int i) {
		foreach (Expression e in initializer_list.get_initializers ()) {
			if (rank > 1) {
				append_initializer_list (ce, name_cnode, (InitializerList) e, rank - 1, ref i);
			} else {
				ce.append_expression (new CCodeAssignment (new CCodeElementAccess (name_cnode, new CCodeConstant (i.to_string ())), (CCodeExpression) e.ccodenode));
				i++;
			}
		}
	}

	public override void visit_array_creation_expression (ArrayCreationExpression expr) {
		expr.accept_children (codegen);

		var array_type = expr.target_type as ArrayType;
		if (array_type != null && array_type.fixed_length) {
			// no heap allocation for fixed-length arrays

			var ce = new CCodeCommaExpression ();
			var temp_var = get_temp_variable (array_type, true, expr);
			var name_cnode = new CCodeIdentifier (temp_var.name);
			int i = 0;

			temp_vars.insert (0, temp_var);

			append_initializer_list (ce, name_cnode, expr.initializer_list, expr.rank, ref i);

			ce.append_expression (name_cnode);

			expr.ccodenode = ce;

			return;
		}

		generate_method_declaration (array_class.default_construction_method, source_declarations);

		var gnew = new CCodeFunctionCall (new CCodeIdentifier ("dova_array_new"));
		gnew.add_argument (get_type_id_expression (expr.element_type));

		bool first = true;
		CCodeExpression cexpr = null;

		// iterate over each dimension
		foreach (Expression size in expr.get_sizes ()) {
			CCodeExpression csize = (CCodeExpression) size.ccodenode;

			if (!is_pure_ccode_expression (csize)) {
				var temp_var = get_temp_variable (int_type, false, expr);
				var name_cnode = new CCodeIdentifier (temp_var.name);
				size.ccodenode = name_cnode;

				temp_vars.insert (0, temp_var);

				csize = new CCodeAssignment (name_cnode, csize);
			}

			if (first) {
				cexpr = csize;
				first = false;
			} else {
				cexpr = new CCodeBinaryExpression (CCodeBinaryOperator.MUL, cexpr, csize);
			}
		}

		gnew.add_argument (cexpr);

		if (expr.initializer_list != null) {
			var ce = new CCodeCommaExpression ();
			var temp_var = get_temp_variable (expr.value_type, true, expr);
			var name_cnode = new CCodeIdentifier (temp_var.name);
			int i = 0;

			temp_vars.insert (0, temp_var);

			ce.append_expression (new CCodeAssignment (name_cnode, gnew));

			append_initializer_list (ce, name_cnode, expr.initializer_list, expr.rank, ref i);

			ce.append_expression (name_cnode);

			expr.ccodenode = ce;
		} else {
			expr.ccodenode = gnew;
		}
	}

	public override void visit_element_access (ElementAccess expr) {
		expr.accept_children (codegen);

		List<Expression> indices = expr.get_indices ();
		int rank = indices.size;

		var ccontainer = (CCodeExpression) expr.container.ccodenode;
		var cindex = (CCodeExpression) indices[0].ccodenode;

		// access to element in an array
		for (int i = 1; i < rank; i++) {
			var cmul = new CCodeBinaryExpression (CCodeBinaryOperator.MUL, cindex, head.get_array_length_cexpression (expr.container, i + 1));
			cindex = new CCodeBinaryExpression (CCodeBinaryOperator.PLUS, cmul, (CCodeExpression) indices[i].ccodenode);
		}
		expr.ccodenode = new CCodeElementAccess (ccontainer, cindex);
	}
}
