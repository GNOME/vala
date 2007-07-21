/* valacodegeneratorinvocationexpression.vala
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
	public override void visit_end_invocation_expression (InvocationExpression! expr) {
		var ccall = new CCodeFunctionCall ((CCodeExpression) expr.call.ccodenode);
		
		Method m = null;
		List<weak FormalParameter> params;
		
		if (!(expr.call is MemberAccess)) {
			expr.error = true;
			Report.error (expr.source_reference, "unsupported method invocation");
			return;
		}
		
		var ma = (MemberAccess) expr.call;
		
		if (expr.call.symbol_reference is Invokable) {
			var i = (Invokable) expr.call.symbol_reference;
			params = i.get_parameters ();
			
			if (i is Method) {
				m = (Method) i;
			} else if (i is Signal) {
				ccall = (CCodeFunctionCall) expr.call.ccodenode;
			}
		}
		
		if (m is ArrayResizeMethod) {
			var array = (Array) m.parent_symbol;
			ccall.add_argument (new CCodeIdentifier (array.get_cname ()));
		}
		
		/* explicitly use strong reference as ccall gets unrefed
		 * at end of inner block
		 */
		CCodeExpression instance;
		if (m != null && m.instance) {
			var base_method = m;
			if (m.base_interface_method != null) {
				base_method = m.base_interface_method;
			} else if (m.base_method != null) {
				base_method = m.base_method;
			}

			var req_cast = false;
			if (ma.inner == null) {
				instance = new CCodeIdentifier ("self");
				/* require casts for overriden and inherited methods */
				req_cast = m.overrides || m.base_interface_method != null || (m.parent_symbol != current_type_symbol);
			} else {
				instance = (CCodeExpression) ma.inner.ccodenode;
				/* reqiure casts if the type of the used instance is
				 * different than the type which declared the method */
				req_cast = base_method.parent_symbol != ma.inner.static_type.data_type;
			}
			
			if (m.instance_by_reference && (ma.inner != null || m.parent_symbol != current_type_symbol)) {
				instance = new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, instance);
			}
			
			if (req_cast && ((DataType) m.parent_symbol).is_reference_type ()) {
				// FIXME: use C cast if debugging disabled
				var ccall = new CCodeFunctionCall (new CCodeIdentifier (((DataType) base_method.parent_symbol).get_upper_case_cname (null)));
				ccall.add_argument (instance);
				instance = ccall;
			}
			
			if (!m.instance_last) {
				ccall.add_argument (instance);
			}
		}
		
		bool ellipsis = false;
		
		var i = 1;
		weak List<weak FormalParameter> params_it = params;
		foreach (Expression arg in expr.get_argument_list ()) {
			/* explicitly use strong reference as ccall gets
			 * unrefed at end of inner block
			 */
			CCodeExpression cexpr = (CCodeExpression) arg.ccodenode;
			if (params_it != null) {
				var param = (FormalParameter) params_it.data;
				ellipsis = param.ellipsis;
				if (!ellipsis) {
					if (param.type_reference.data_type != null
					    && param.type_reference.data_type.is_reference_type ()
					    && arg.static_type.data_type != null) {
						if (!param.no_array_length && param.type_reference.data_type is Array) {
							var arr = (Array) param.type_reference.data_type;
							for (int dim = 1; dim <= arr.rank; dim++) {
								ccall.add_argument (get_array_length_cexpression (arg, dim));
							}
						}
						if (param.type_reference.data_type != arg.static_type.data_type) {
							// FIXME: use C cast if debugging disabled
							var ccall = new CCodeFunctionCall (new CCodeIdentifier (param.type_reference.data_type.get_upper_case_cname (null)));
							ccall.add_argument (cexpr);
							cexpr = ccall;
						}
					} else if (param.type_reference.data_type is Callback) {
						cexpr = new CCodeCastExpression (cexpr, param.type_reference.data_type.get_cname ());
					} else if (param.type_reference.data_type == null
					           && arg.static_type.data_type is Struct) {
						/* convert integer to pointer if this is a generic method parameter */
						var st = (Struct) arg.static_type.data_type;
						if (st == bool_type.data_type || st.is_integer_type ()) {
							var cconv = new CCodeFunctionCall (new CCodeIdentifier ("GINT_TO_POINTER"));
							cconv.add_argument (cexpr);
							cexpr = cconv;
						}
					}
				}
			}
					
			ccall.add_argument (cexpr);
			i++;
			
			if (params_it != null) {
				params_it = params_it.next;
			}
		}
		while (params_it != null) {
			var param = (FormalParameter) params_it.data;
			
			if (param.ellipsis) {
				ellipsis = true;
				break;
			}
			
			if (param.default_expression == null) {
				Report.error (expr.source_reference, "no default expression for argument %d".printf (i));
				return;
			}
			
			/* evaluate default expression here as the code
			 * generator might not have visited the formal
			 * parameter yet */
			param.default_expression.accept (this);
		
			if (!param.no_array_length && param.type_reference != null &&
			    param.type_reference.data_type is Array) {
				var arr = (Array) param.type_reference.data_type;
				for (int dim = 1; dim <= arr.rank; dim++) {
					ccall.add_argument (get_array_length_cexpression (param.default_expression, dim));
				}
			}

			ccall.add_argument ((CCodeExpression) param.default_expression.ccodenode);
			i++;
		
			params_it = params_it.next;
		}

		/* add length argument for methods returning arrays */
		if (m != null && m.return_type.data_type is Array) {
			var arr = (Array) m.return_type.data_type;
			for (int dim = 1; dim <= arr.rank; dim++) {
				if (!m.no_array_length) {
					var temp_decl = get_temp_variable_declarator (int_type);
					var temp_ref = new CCodeIdentifier (temp_decl.name);

					temp_vars.prepend (temp_decl);

					ccall.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, temp_ref));

					expr.append_array_size (temp_ref);
				} else {
					expr.append_array_size (new CCodeConstant ("-1"));
				}
			}
		}

		if (expr.can_fail) {
			// method can fail
			current_method_inner_error = true;
			ccall.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, new CCodeIdentifier ("inner_error")));
		}

		if (m != null && m.instance && m.instance_last) {
			ccall.add_argument (instance);
		} else if (ellipsis) {
			/* ensure variable argument list ends with NULL
			 * except when using printf-style arguments */
			if (m == null || !m.printf_format) {
				ccall.add_argument (new CCodeConstant ("NULL"));
			}
		}
		
		if (m != null && m.instance && m.returns_modified_pointer) {
			expr.ccodenode = new CCodeAssignment (instance, ccall);
		} else {
			/* cast pointer to actual type if this is a generic method return value */
			if (m != null && m.return_type.type_parameter != null && expr.static_type.data_type != null) {
				if (expr.static_type.data_type is Struct) {
					var st = (Struct) expr.static_type.data_type;
					if (st == uint_type.data_type) {
						var cconv = new CCodeFunctionCall (new CCodeIdentifier ("GPOINTER_TO_UINT"));
						cconv.add_argument (ccall);
						ccall = cconv;
					} else if (st == bool_type.data_type || st.is_integer_type ()) {
						var cconv = new CCodeFunctionCall (new CCodeIdentifier ("GPOINTER_TO_INT"));
						cconv.add_argument (ccall);
						ccall = cconv;
					}
				}
			}

			expr.ccodenode = ccall;
		
			visit_expression (expr);
		}
		
		if (m is ArrayResizeMethod) {
			// FIXME: size expression must not be evaluated twice at runtime (potential side effects)
			var new_size = (CCodeExpression) ((CodeNode) expr.get_argument_list ().data).ccodenode;

			var temp_decl = get_temp_variable_declarator (int_type);
			var temp_ref = new CCodeIdentifier (temp_decl.name);

			temp_vars.prepend (temp_decl);

			/* memset needs string.h */
			string_h_needed = true;

			var clen = get_array_length_cexpression (ma.inner, 1);
			var celems = (CCodeExpression) ma.inner.ccodenode;
			var csizeof = new CCodeIdentifier ("sizeof (%s)".printf (ma.inner.static_type.data_type.get_cname ()));
			var cdelta = new CCodeParenthesizedExpression (new CCodeBinaryExpression (CCodeBinaryOperator.MINUS, temp_ref, clen));
			var ccheck = new CCodeBinaryExpression (CCodeBinaryOperator.GREATER_THAN, temp_ref, clen);

			var czero = new CCodeFunctionCall (new CCodeIdentifier ("memset"));
			czero.add_argument (new CCodeBinaryExpression (CCodeBinaryOperator.PLUS, celems, clen));
			czero.add_argument (new CCodeConstant ("0"));
			czero.add_argument (new CCodeBinaryExpression (CCodeBinaryOperator.MUL, csizeof, cdelta));

			var ccomma = new CCodeCommaExpression ();
			ccomma.append_expression (new CCodeAssignment (temp_ref, new_size));
			ccomma.append_expression ((CCodeExpression) expr.ccodenode);
			ccomma.append_expression (new CCodeConditionalExpression (ccheck, czero, new CCodeConstant ("NULL")));
			ccomma.append_expression (new CCodeAssignment (get_array_length_cexpression (ma.inner, 1), temp_ref));

			expr.ccodenode = ccomma;
		} else if (m == substring_method) {
			var temp_decl = get_temp_variable_declarator (string_type);
			var temp_ref = new CCodeIdentifier (temp_decl.name);

			temp_vars.prepend (temp_decl);

			List<weak CCodeExpression> args = ccall.get_arguments ();

			var coffsetcall = new CCodeFunctionCall (new CCodeIdentifier ("g_utf8_offset_to_pointer"));
			// full string
			coffsetcall.add_argument (args.nth_data (0));
			// offset
			coffsetcall.add_argument (args.nth_data (1));

			var coffsetcall2 = new CCodeFunctionCall (new CCodeIdentifier ("g_utf8_offset_to_pointer"));
			coffsetcall2.add_argument (temp_ref);
			// len
			coffsetcall2.add_argument (args.nth_data (2));

			var cndupcall = new CCodeFunctionCall (new CCodeIdentifier ("g_strndup"));
			cndupcall.add_argument (temp_ref);
			cndupcall.add_argument (new CCodeBinaryExpression (CCodeBinaryOperator.MINUS, coffsetcall2, temp_ref));

			var ccomma = new CCodeCommaExpression ();
			ccomma.append_expression (new CCodeAssignment (temp_ref, coffsetcall));
			ccomma.append_expression (cndupcall);

			expr.ccodenode = ccomma;
		}
	}
}

