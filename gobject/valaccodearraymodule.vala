/* valaccodearraymodule.vala
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
using Gee;

/**
 * The link between an assignment and generated code.
 */
public class Vala.CCodeArrayModule : CCodeModule {
	public CCodeArrayModule (CCodeGenerator codegen, CCodeModule? next) {
		base (codegen, next);
	}

	public override void visit_array_creation_expression (ArrayCreationExpression expr) {
		expr.accept_children (codegen);

		var gnew = new CCodeFunctionCall (new CCodeIdentifier ("g_new0"));
		gnew.add_argument (new CCodeIdentifier (expr.element_type.get_cname ()));
		bool first = true;
		CCodeExpression cexpr = null;

		// iterate over each dimension
		foreach (Expression size in expr.get_sizes ()) {
			CCodeExpression csize = (CCodeExpression) size.ccodenode;

			if (!codegen.is_pure_ccode_expression (csize)) {
				var temp_var = codegen.get_temp_variable (codegen.int_type, false, expr);
				var name_cnode = new CCodeIdentifier (temp_var.name);
				size.ccodenode = name_cnode;

				codegen.temp_vars.insert (0, temp_var);

				csize = new CCodeParenthesizedExpression (new CCodeAssignment (name_cnode, csize));
			}

			if (first) {
				cexpr = csize;
				first = false;
			} else {
				cexpr = new CCodeBinaryExpression (CCodeBinaryOperator.MUL, cexpr, csize);
			}
		}
		
		// add extra item to have array NULL-terminated for all reference types
		if (expr.element_type.data_type != null && expr.element_type.data_type.is_reference_type ()) {
			cexpr = new CCodeBinaryExpression (CCodeBinaryOperator.PLUS, cexpr, new CCodeConstant ("1"));
		}
		
		gnew.add_argument (cexpr);

		if (expr.initializer_list != null) {
			// FIXME rank > 1 not supported yet
			if (expr.rank > 1) {
				expr.error = true;
				Report.error (expr.source_reference, "Creating arrays with rank greater than 1 with initializers is not supported yet");
			}

			var ce = new CCodeCommaExpression ();
			var temp_var = codegen.get_temp_variable (expr.value_type, true, expr);
			var name_cnode = new CCodeIdentifier (temp_var.name);
			int i = 0;
			
			codegen.temp_vars.insert (0, temp_var);
			
			ce.append_expression (new CCodeAssignment (name_cnode, gnew));
			
			foreach (Expression e in expr.initializer_list.get_initializers ()) {
				ce.append_expression (new CCodeAssignment (new CCodeElementAccess (name_cnode, new CCodeConstant (i.to_string ())), (CCodeExpression) e.ccodenode));
				i++;
			}
			
			ce.append_expression (name_cnode);
			
			expr.ccodenode = ce;
		} else {
			expr.ccodenode = gnew;
		}
	}
}
