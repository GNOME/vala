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

	public override string get_array_length_cname (string array_cname, int dim) {
		return "%s_length%d".printf (array_cname, dim);
	}

	public override CCodeExpression get_array_length_cexpression (Expression array_expr, int dim = -1) {
		// dim == -1 => total size over all dimensions
		if (dim == -1) {
			var array_type = array_expr.value_type as ArrayType;
			if (array_type != null && array_type.rank > 1) {
				CCodeExpression cexpr = get_array_length_cexpression (array_expr, 1);
				for (dim = 2; dim <= array_type.rank; dim++) {
					cexpr = new CCodeBinaryExpression (CCodeBinaryOperator.MUL, cexpr, get_array_length_cexpression (array_expr, dim));
				}
				return cexpr;
			} else {
				dim = 1;
			}
		}

		bool is_out = false;

		if (array_expr is UnaryExpression) {
			var unary_expr = (UnaryExpression) array_expr;
			if (unary_expr.operator == UnaryOperator.OUT || unary_expr.operator == UnaryOperator.REF) {
				array_expr = unary_expr.inner;
				is_out = true;
			}
		} else if (array_expr is ReferenceTransferExpression) {
			var reftransfer_expr = (ReferenceTransferExpression) array_expr;
			array_expr = reftransfer_expr.inner;
		}
		
		if (array_expr is ArrayCreationExpression) {
			Gee.List<Expression> size = ((ArrayCreationExpression) array_expr).get_sizes ();
			var length_expr = size[dim - 1];
			return (CCodeExpression) codegen.get_ccodenode (length_expr);
		} else if (array_expr is InvocationExpression) {
			var invocation_expr = (InvocationExpression) array_expr;
			Gee.List<CCodeExpression> size = invocation_expr.get_array_sizes ();
			return size[dim - 1];
		} else if (array_expr.symbol_reference != null) {
			if (array_expr.symbol_reference is FormalParameter) {
				var param = (FormalParameter) array_expr.symbol_reference;
				if (!param.no_array_length) {
					CCodeExpression length_expr = new CCodeIdentifier (get_array_length_cname (param.name, dim));
					if (param.direction != ParameterDirection.IN) {
						// accessing argument of out/ref param
						length_expr = new CCodeParenthesizedExpression (new CCodeUnaryExpression (CCodeUnaryOperator.POINTER_INDIRECTION, length_expr));
					}
					if (is_out) {
						// passing array as out/ref
						return new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, length_expr);
					} else {
						return length_expr;
					}
				}
			} else if (array_expr.symbol_reference is LocalVariable) {
				var local = (LocalVariable) array_expr.symbol_reference;
				var length_expr = new CCodeIdentifier (get_array_length_cname (local.name, dim));
				if (is_out) {
					return new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, length_expr);
				} else {
					return length_expr;
				}
			} else if (array_expr.symbol_reference is Field) {
				var field = (Field) array_expr.symbol_reference;
				if (!field.no_array_length) {
					var ma = (MemberAccess) array_expr;

					CCodeExpression length_expr = null;

					if (field.binding == MemberBinding.INSTANCE) {
						TypeSymbol base_type = null;
						if (ma.inner.value_type != null) {
							base_type = ma.inner.value_type.data_type;
						}

						var length_cname = get_array_length_cname (field.name, dim);
						var instance_expression_type = codegen.get_data_type_for_symbol (base_type);
						var instance_target_type = codegen.get_data_type_for_symbol ((TypeSymbol) field.parent_symbol);
						CCodeExpression typed_inst = (CCodeExpression) codegen.get_ccodenode (ma.inner);

						CCodeExpression inst;
						if (field.access == SymbolAccessibility.PRIVATE) {
							inst = new CCodeMemberAccess.pointer (typed_inst, "priv");
						} else {
							inst = typed_inst;
						}
						if (((TypeSymbol) field.parent_symbol).is_reference_type ()) {
							length_expr = new CCodeMemberAccess.pointer (inst, length_cname);
						} else {
							length_expr = new CCodeMemberAccess (inst, length_cname);
						}
					} else {
						length_expr = new CCodeIdentifier (get_array_length_cname (field.get_cname (), dim));
					}

					if (is_out) {
						return new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, length_expr);
					} else {
						return length_expr;
					}
				}
			} else if (array_expr.symbol_reference is Constant) {
				var constant = (Constant) array_expr.symbol_reference;
				var ccall = new CCodeFunctionCall (new CCodeIdentifier ("G_N_ELEMENTS"));
				ccall.add_argument (new CCodeIdentifier (constant.get_cname ()));
				return ccall;
			}
		} else if (array_expr is NullLiteral) {
			return new CCodeConstant ("0");
		}

		if (!is_out) {
			/* allow arrays with unknown length even for value types
			 * as else it may be impossible to bind some libraries
			 * users of affected libraries should explicitly set
			 * the array length as early as possible
			 * by setting the virtual length field of the array
			 */
			return new CCodeConstant ("-1");
		} else {
			return new CCodeConstant ("NULL");
		}
	}
}
