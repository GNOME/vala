/* valacodegeneratorassignment.vala
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
	public override void visit_end_assignment (Assignment! a) {
		MemberAccess ma = null;
		
		if (a.left is MemberAccess) {
			ma = (MemberAccess)a.left;
		}

		if (a.left.symbol_reference != null && a.left.symbol_reference.node is Property) {
			var prop = (Property) a.left.symbol_reference.node;
			
			if (current_class != null && ma.inner == null && in_creation_method) {
				// this property is used as a construction parameter
				var cpointer = new CCodeIdentifier ("__params_it");
				
				var ccomma = new CCodeCommaExpression ();
				// set name in array for current parameter
				var cnamemember = new CCodeMemberAccess.pointer (cpointer, "name");
				var cnameassign = new CCodeAssignment (cnamemember, prop.get_canonical_cconstant ());
				ccomma.append_expression (cnameassign);
				
				var gvaluearg = new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, new CCodeMemberAccess.pointer (cpointer, "value"));
				
				// initialize GValue in array for current parameter
				var cvalueinit = new CCodeFunctionCall (new CCodeIdentifier ("g_value_init"));
				cvalueinit.add_argument (gvaluearg);
				cvalueinit.add_argument (new CCodeIdentifier (prop.type_reference.data_type.get_type_id ()));
				ccomma.append_expression (cvalueinit);
				
				// set GValue for current parameter
				var cvalueset = new CCodeFunctionCall (get_value_setter_function (prop.type_reference));
				cvalueset.add_argument (gvaluearg);
				cvalueset.add_argument ((CCodeExpression) a.right.ccodenode);
				ccomma.append_expression (cvalueset);
				
				// move pointer to next parameter in array
				ccomma.append_expression (new CCodeUnaryExpression (CCodeUnaryOperator.POSTFIX_INCREMENT, cpointer));
				
				a.ccodenode = ccomma;
			} else {
				ref CCodeExpression cexpr = (CCodeExpression) a.right.ccodenode;
				
				if (!prop.no_accessor_method
				    && prop.type_reference.data_type != null
				    && prop.type_reference.data_type.is_reference_type ()
				    && a.right.static_type.data_type != null
				    && prop.type_reference.data_type != a.right.static_type.data_type) {
					/* cast is necessary */
					var ccast = new CCodeFunctionCall (new CCodeIdentifier (prop.type_reference.data_type.get_upper_case_cname (null)));
					ccast.add_argument (cexpr);
					cexpr = ccast;
				}
				
				if (a.operator != AssignmentOperator.SIMPLE) {
					CCodeBinaryOperator cop;
					if (a.operator == AssignmentOperator.BITWISE_OR) {
						cop = CCodeBinaryOperator.BITWISE_OR;
					} else if (a.operator == AssignmentOperator.BITWISE_AND) {
						cop = CCodeBinaryOperator.BITWISE_AND;
					} else if (a.operator == AssignmentOperator.BITWISE_XOR) {
						cop = CCodeBinaryOperator.BITWISE_XOR;
					} else if (a.operator == AssignmentOperator.ADD) {
						cop = CCodeBinaryOperator.PLUS;
					} else if (a.operator == AssignmentOperator.SUB) {
						cop = CCodeBinaryOperator.MINUS;
					} else if (a.operator == AssignmentOperator.MUL) {
						cop = CCodeBinaryOperator.MUL;
					} else if (a.operator == AssignmentOperator.DIV) {
						cop = CCodeBinaryOperator.DIV;
					} else if (a.operator == AssignmentOperator.PERCENT) {
						cop = CCodeBinaryOperator.MOD;
					} else if (a.operator == AssignmentOperator.SHIFT_LEFT) {
						cop = CCodeBinaryOperator.SHIFT_LEFT;
					} else if (a.operator == AssignmentOperator.SHIFT_RIGHT) {
						cop = CCodeBinaryOperator.SHIFT_RIGHT;
					}
					cexpr = new CCodeBinaryExpression (cop, (CCodeExpression) a.left.ccodenode, new CCodeParenthesizedExpression (cexpr));
				}
				
				var ccall = get_property_set_call (prop, ma, cexpr);
				
				// assignments are expressions, so return the current property value
				var ccomma = new CCodeCommaExpression ();
				ccomma.append_expression (ccall); // update property
				ccomma.append_expression ((CCodeExpression) ma.ccodenode); // current property value
				
				a.ccodenode = ccomma;
			}
		} else if (a.left.symbol_reference != null && a.left.symbol_reference.node is Signal) {
			var sig = (Signal) a.left.symbol_reference.node;
			
			var m = (Method) a.right.symbol_reference.node;

			string connect_func;
			bool disconnect = false;

			if (a.operator == AssignmentOperator.ADD) {
				connect_func = "g_signal_connect_object";
				if (!m.instance) {
					connect_func = "g_signal_connect";
				}
			} else if (a.operator == AssignmentOperator.SUB) {
				connect_func = "g_signal_handlers_disconnect_matched";
				disconnect = true;
			} else {
				a.error = true;
				Report.error (a.source_reference, "Specified compound assignment type for signals not supported.");
				return;
			}

			var ccall = new CCodeFunctionCall (new CCodeIdentifier (connect_func));
		
			if (ma.inner != null) {
				ccall.add_argument ((CCodeExpression) ma.inner.ccodenode);
			} else {
				ccall.add_argument (new CCodeIdentifier ("self"));
			}

			if (!disconnect) {
				ccall.add_argument (sig.get_canonical_cconstant ());
			} else {
				ccall.add_argument (new CCodeConstant ("G_SIGNAL_MATCH_ID | G_SIGNAL_MATCH_FUNC | G_SIGNAL_MATCH_DATA"));
				
				// get signal id
				var ccomma = new CCodeCommaExpression ();
				var temp_decl = get_temp_variable_declarator (uint_type);
				temp_vars.prepend (temp_decl);
				var parse_call = new CCodeFunctionCall (new CCodeIdentifier ("g_signal_parse_name"));
				parse_call.add_argument (sig.get_canonical_cconstant ());
				var decl_type = (DataType) sig.symbol.parent_symbol.node;
				parse_call.add_argument (new CCodeIdentifier (decl_type.get_type_id ()));
				parse_call.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, new CCodeIdentifier (temp_decl.name)));
				parse_call.add_argument (new CCodeConstant ("NULL"));
				parse_call.add_argument (new CCodeConstant ("FALSE"));
				ccomma.append_expression (parse_call);
				ccomma.append_expression (new CCodeIdentifier (temp_decl.name));
				
				ccall.add_argument (ccomma);

				ccall.add_argument (new CCodeConstant ("0"));
				ccall.add_argument (new CCodeConstant ("NULL"));
			}

			ccall.add_argument (new CCodeCastExpression (new CCodeIdentifier (m.get_cname ()), "GCallback"));

			if (m.instance) {
				if (a.right is MemberAccess) {
					var right_ma = (MemberAccess) a.right;
					if (right_ma.inner != null) {
						ccall.add_argument ((CCodeExpression) right_ma.inner.ccodenode);
					} else {
						ccall.add_argument (new CCodeIdentifier ("self"));
					}
				} else if (a.right is LambdaExpression) {
					ccall.add_argument (new CCodeIdentifier ("self"));
				}
				if (!disconnect) {
					ccall.add_argument (new CCodeConstant ("0"));
				}
			} else {
				ccall.add_argument (new CCodeConstant ("NULL"));
			}
			
			a.ccodenode = ccall;
		} else {
			/* explicitly use strong reference as ccast gets
			 * unrefed at end of inner block
			 */
			ref CCodeExpression rhs = (CCodeExpression) a.right.ccodenode;
			
			if (a.left.static_type.data_type != null
			    && a.right.static_type.data_type != null
			    && a.left.static_type.data_type.is_reference_type ()
			    && a.right.static_type.data_type != a.left.static_type.data_type) {
				var ccast = new CCodeFunctionCall (new CCodeIdentifier (a.left.static_type.data_type.get_upper_case_cname (null)));
				ccast.add_argument (rhs);
				rhs = ccast;
			}
			
			bool unref_old = (memory_management && a.left.static_type.takes_ownership);
			bool array = false;
			if (a.left.static_type.data_type is Array) {
				array = !(get_array_length_cexpression (a.left, 1) is CCodeConstant);
			}
			
			if (unref_old || array) {
				var ccomma = new CCodeCommaExpression ();
				
				var temp_decl = get_temp_variable_declarator (a.left.static_type);
				temp_vars.prepend (temp_decl);
				ccomma.append_expression (new CCodeAssignment (new CCodeIdentifier (temp_decl.name), rhs));
				if (unref_old) {
					/* unref old value */
					ccomma.append_expression (get_unref_expression ((CCodeExpression) a.left.ccodenode, a.left.static_type));
				}
				
				if (array) {
					var lhs_array_len = get_array_length_cexpression (a.left, 1);
					var rhs_array_len = get_array_length_cexpression (a.right, 1);
					ccomma.append_expression (new CCodeAssignment (lhs_array_len, rhs_array_len));
				}
				
				ccomma.append_expression (new CCodeIdentifier (temp_decl.name));
				
				rhs = ccomma;
			}
			
			var cop = CCodeAssignmentOperator.SIMPLE;
			if (a.operator == AssignmentOperator.BITWISE_OR) {
				cop = CCodeAssignmentOperator.BITWISE_OR;
			} else if (a.operator == AssignmentOperator.BITWISE_AND) {
				cop = CCodeAssignmentOperator.BITWISE_AND;
			} else if (a.operator == AssignmentOperator.BITWISE_XOR) {
				cop = CCodeAssignmentOperator.BITWISE_XOR;
			} else if (a.operator == AssignmentOperator.ADD) {
				cop = CCodeAssignmentOperator.ADD;
			} else if (a.operator == AssignmentOperator.SUB) {
				cop = CCodeAssignmentOperator.SUB;
			} else if (a.operator == AssignmentOperator.MUL) {
				cop = CCodeAssignmentOperator.MUL;
			} else if (a.operator == AssignmentOperator.DIV) {
				cop = CCodeAssignmentOperator.DIV;
			} else if (a.operator == AssignmentOperator.PERCENT) {
				cop = CCodeAssignmentOperator.PERCENT;
			} else if (a.operator == AssignmentOperator.SHIFT_LEFT) {
				cop = CCodeAssignmentOperator.SHIFT_LEFT;
			} else if (a.operator == AssignmentOperator.SHIFT_RIGHT) {
				cop = CCodeAssignmentOperator.SHIFT_RIGHT;
			}
		
			a.ccodenode = new CCodeAssignment ((CCodeExpression) a.left.ccodenode, rhs, cop);
		}
	}

	private ref CCodeFunctionCall get_property_set_call (Property! prop, MemberAccess! ma, CCodeExpression! cexpr) {
		var cl = (Class) prop.symbol.parent_symbol.node;
		var set_func = "g_object_set";
		
		if (!prop.no_accessor_method) {
			set_func = "%s_set_%s".printf (cl.get_lower_case_cname (null), prop.name);
		}
		
		var ccall = new CCodeFunctionCall (new CCodeIdentifier (set_func));

		/* target instance is first argument */
		ref CCodeExpression instance;
		var req_cast = false;

		if (ma.inner == null) {
			instance = new CCodeIdentifier ("self");
			/* require casts for inherited properties */
			req_cast = (prop.symbol.parent_symbol != current_type_symbol);
		} else {
			instance = (CCodeExpression) ma.inner.ccodenode;
			/* require casts if the type of the used instance is
			 * different than the type which declared the property */
			req_cast = prop.symbol.parent_symbol.node != ma.inner.static_type.data_type;
		}
		
		if (req_cast && ((DataType) prop.symbol.parent_symbol.node).is_reference_type ()) {
			var ccast = new CCodeFunctionCall (new CCodeIdentifier (((DataType) prop.symbol.parent_symbol.node).get_upper_case_cname (null)));
			ccast.add_argument (instance);
			instance = ccast;
		}

		ccall.add_argument (instance);

		if (prop.no_accessor_method) {
			/* property name is second argument of g_object_set */
			ccall.add_argument (prop.get_canonical_cconstant ());
		}
			
		ccall.add_argument (cexpr);
		
		if (prop.no_accessor_method) {
			ccall.add_argument (new CCodeConstant ("NULL"));
		}

		return ccall;
	}
}

