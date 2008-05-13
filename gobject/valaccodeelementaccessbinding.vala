/* valaccodeelementaccessbinding.vala
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
 * The link between an element access and generated code.
 */
public class Vala.CCodeElementAccessBinding : CCodeExpressionBinding {
	public ElementAccess element_access { get; set; }

	public CCodeElementAccessBinding (CCodeGenerator codegen, ElementAccess element_access) {
		this.element_access = element_access;
		this.codegen = codegen;
	}

	public override void emit () {
		var expr = element_access;

		Gee.List<Expression> indices = expr.get_indices ();
		int rank = indices.size;

		var container_type = expr.container.value_type.data_type;

		var ccontainer = (CCodeExpression) expr.container.ccodenode;
		var cindex = (CCodeExpression) indices[0].ccodenode;
		if (expr.container.symbol_reference is ArrayLengthField) {
			/* Figure if cindex is a constant expression and calculate dim...*/
			var lit = indices[0] as IntegerLiteral;
			var memberaccess = expr.container as MemberAccess;
			if (lit != null && memberaccess != null) {
				int dim = lit.value.to_int ();
				codenode = codegen.get_array_length_cexpression (memberaccess.inner, dim + 1);
			}
		} else if (container_type == codegen.string_type.data_type) {
			// access to unichar in a string
			var coffsetcall = new CCodeFunctionCall (new CCodeIdentifier ("g_utf8_offset_to_pointer"));
			coffsetcall.add_argument (ccontainer);
			coffsetcall.add_argument (cindex);

			var ccall = new CCodeFunctionCall (new CCodeIdentifier ("g_utf8_get_char"));
			ccall.add_argument (coffsetcall);

			codenode = ccall;
		} else if (container_type != null && codegen.list_type != null && codegen.map_type != null &&
		           (container_type.is_subtype_of (codegen.list_type) || container_type.is_subtype_of (codegen.map_type))) {
			Typesymbol collection_iface = null;
			if (container_type.is_subtype_of (codegen.list_type)) {
				collection_iface = codegen.list_type;
			} else if (container_type.is_subtype_of (codegen.map_type)) {
				collection_iface = codegen.map_type;
			}
			var get_method = (Method) collection_iface.scope.lookup ("get");
			Collection<FormalParameter> get_params = get_method.get_parameters ();
			Iterator<FormalParameter> get_params_it = get_params.iterator ();
			get_params_it.next ();
			var get_param = get_params_it.get ();

			if (get_param.parameter_type.type_parameter != null) {
				var index_type = SemanticAnalyzer.get_actual_type (expr.container.value_type, get_method, get_param.parameter_type, expr);
				cindex = codegen.convert_to_generic_pointer (cindex, index_type);
			}

			var get_ccall = new CCodeFunctionCall (new CCodeIdentifier (get_method.get_cname ()));
			get_ccall.add_argument (new CCodeCastExpression (ccontainer, collection_iface.get_cname () + "*"));
			get_ccall.add_argument (cindex);

			codenode = codegen.convert_from_generic_pointer (get_ccall, expr.value_type);
		} else {
			// access to element in an array
			for (int i = 1; i < rank; i++) {
				var cmul = new CCodeBinaryExpression (CCodeBinaryOperator.MUL, new CCodeParenthesizedExpression (cindex), codegen.get_array_length_cexpression (expr.container, i + 1));
				cindex = new CCodeBinaryExpression (CCodeBinaryOperator.PLUS, cmul, new CCodeParenthesizedExpression ((CCodeExpression) indices[i].ccodenode));
			}
			codenode = new CCodeElementAccess (ccontainer, cindex);
		}

		expr.ccodenode = codenode;

		codegen.visit_expression (expr);
	}
}
