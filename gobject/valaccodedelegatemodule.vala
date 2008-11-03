/* valaccodedelegatemodule.vala
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

/**
 * The link between an assignment and generated code.
 */
public class Vala.CCodeDelegateModule : CCodeArrayModule {
	public CCodeDelegateModule (CCodeGenerator codegen, CCodeModule? next) {
		base (codegen, next);
	}

	public override void visit_delegate (Delegate d) {
		d.accept_children (codegen);

		var cfundecl = new CCodeFunctionDeclarator (d.get_cname ());
		foreach (FormalParameter param in d.get_parameters ()) {
			cfundecl.add_parameter ((CCodeFormalParameter) param.ccodenode);

			// handle array parameters
			if (!param.no_array_length && param.parameter_type is ArrayType) {
				var array_type = (ArrayType) param.parameter_type;
				
				var length_ctype = "int";
				if (param.direction != ParameterDirection.IN) {
					length_ctype = "int*";
				}
				
				for (int dim = 1; dim <= array_type.rank; dim++) {
					var cparam = new CCodeFormalParameter (head.get_array_length_cname (param.name, dim), length_ctype);
					cfundecl.add_parameter (cparam);
				}
			}
		}
		if (d.has_target) {
			var cparam = new CCodeFormalParameter ("user_data", "void*");
			cfundecl.add_parameter (cparam);
		}

		var ctypedef = new CCodeTypeDefinition (d.return_type.get_cname (), cfundecl);

		if (!d.is_internal_symbol ()) {
			header_type_declaration.append (ctypedef);
		} else {
			source_type_declaration.append (ctypedef);
		}
	}

	public override string get_delegate_target_cname (string delegate_cname) {
		return "%s_target".printf (delegate_cname);
	}

	public override CCodeExpression get_delegate_target_cexpression (Expression delegate_expr) {
		bool is_out = false;
	
		if (delegate_expr is UnaryExpression) {
			var unary_expr = (UnaryExpression) delegate_expr;
			if (unary_expr.operator == UnaryOperator.OUT || unary_expr.operator == UnaryOperator.REF) {
				delegate_expr = unary_expr.inner;
				is_out = true;
			}
		}
		
		if (delegate_expr is InvocationExpression) {
			var invocation_expr = (InvocationExpression) delegate_expr;
			return invocation_expr.delegate_target;
		} else if (delegate_expr is LambdaExpression) {
			if ((current_method != null && current_method.binding == MemberBinding.INSTANCE) || in_constructor) {
				return new CCodeIdentifier ("self");
			} else {
				return new CCodeConstant ("NULL");
			}
		} else if (delegate_expr.symbol_reference != null) {
			if (delegate_expr.symbol_reference is FormalParameter) {
				var param = (FormalParameter) delegate_expr.symbol_reference;
				CCodeExpression target_expr = new CCodeIdentifier (get_delegate_target_cname (param.name));
				if (param.direction != ParameterDirection.IN) {
					// accessing argument of out/ref param
					target_expr = new CCodeParenthesizedExpression (new CCodeUnaryExpression (CCodeUnaryOperator.POINTER_INDIRECTION, target_expr));
				}
				if (is_out) {
					// passing array as out/ref
					return new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, target_expr);
				} else {
					return target_expr;
				}
			} else if (delegate_expr.symbol_reference is LocalVariable) {
				var local = (LocalVariable) delegate_expr.symbol_reference;
				var target_expr = new CCodeIdentifier (get_delegate_target_cname (local.name));
				if (is_out) {
					return new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, target_expr);
				} else {
					return target_expr;
				}
			} else if (delegate_expr.symbol_reference is Field) {
				var field = (Field) delegate_expr.symbol_reference;
				var target_cname = get_delegate_target_cname (field.name);

				var ma = (MemberAccess) delegate_expr;

				var base_type = ma.inner.value_type;
				CCodeExpression target_expr = null;

				var pub_inst = (CCodeExpression) get_ccodenode (ma.inner);

				if (field.binding == MemberBinding.INSTANCE) {
					var instance_expression_type = base_type;
					var instance_target_type = get_data_type_for_symbol ((TypeSymbol) field.parent_symbol);
					CCodeExpression typed_inst = transform_expression (pub_inst, instance_expression_type, instance_target_type);

					CCodeExpression inst;
					if (field.access == SymbolAccessibility.PRIVATE) {
						inst = new CCodeMemberAccess.pointer (typed_inst, "priv");
					} else {
						inst = typed_inst;
					}
					if (((TypeSymbol) field.parent_symbol).is_reference_type ()) {
						target_expr = new CCodeMemberAccess.pointer (inst, target_cname);
					} else {
						target_expr = new CCodeMemberAccess (inst, target_cname);
					}
				} else {
					target_expr = new CCodeIdentifier (target_cname);
				}

				if (is_out) {
					return new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, target_expr);
				} else {
					return target_expr;
				}
			} else if (delegate_expr.symbol_reference is Method) {
				var m = (Method) delegate_expr.symbol_reference;
				var ma = (MemberAccess) delegate_expr;
				if (m.binding == MemberBinding.STATIC) {
					return new CCodeConstant ("NULL");
				} else {
					return (CCodeExpression) get_ccodenode (ma.inner);
				}
			}
		}

		return new CCodeConstant ("NULL");
	}

	public override string get_delegate_target_destroy_notify_cname (string delegate_cname) {
		return "%s_target_destroy_notify".printf (delegate_cname);
	}
}
