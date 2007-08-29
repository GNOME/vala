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
using Gee;

public class Vala.CodeGenerator {
	public override void visit_end_assignment (Assignment! a) {
		MemberAccess ma = null;
		
		if (a.left is MemberAccess) {
			ma = (MemberAccess) a.left;
		}

		if (a.left.symbol_reference is Property) {
			var prop = (Property) a.left.symbol_reference;
			
			if (prop.set_accessor.construction && current_type_symbol is Class && in_creation_method) {
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
				CCodeExpression cexpr = (CCodeExpression) a.right.ccodenode;
				
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
				
				// assignments are expressions, so return the current property value, except if we're sure that it can't be used
				if (!(a.parent_node is ExpressionStatement)) {
					var ccomma = new CCodeCommaExpression ();
					ccomma.append_expression (ccall); // update property
					ccomma.append_expression ((CCodeExpression) ma.ccodenode); // current property value
					
					a.ccodenode = ccomma;
				} else {
					a.ccodenode = ccall;
				}
			}
		} else if (a.left.symbol_reference is Signal) {
			var sig = (Signal) a.left.symbol_reference;
			
			var m = (Method) a.right.symbol_reference;

			string connect_func;
			bool disconnect = false;

			if (a.operator == AssignmentOperator.ADD) {
				if (sig is DBusSignal) {
					connect_func = "dbus_g_proxy_connect_signal";
				} else {
					connect_func = "g_signal_connect_object";
					if (!m.instance) {
						connect_func = "g_signal_connect";
					}
				}
			} else if (a.operator == AssignmentOperator.SUB) {
				if (sig is DBusSignal) {
					connect_func = "dbus_g_proxy_disconnect_signal";
				} else {
					connect_func = "g_signal_handlers_disconnect_matched";
				}
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

			if (!disconnect || sig is DBusSignal) {
				ccall.add_argument (sig.get_canonical_cconstant ());
			} else {
				ccall.add_argument (new CCodeConstant ("G_SIGNAL_MATCH_ID | G_SIGNAL_MATCH_FUNC | G_SIGNAL_MATCH_DATA"));
				
				// get signal id
				var ccomma = new CCodeCommaExpression ();
				var temp_decl = get_temp_variable_declarator (uint_type);
				temp_vars.insert (0, temp_decl);
				var parse_call = new CCodeFunctionCall (new CCodeIdentifier ("g_signal_parse_name"));
				parse_call.add_argument (sig.get_canonical_cconstant ());
				var decl_type = (DataType) sig.parent_symbol;
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
					if (sig is DBusSignal) {
						// free_data_func
						ccall.add_argument (new CCodeConstant ("NULL"));
					} else {
						// connect_flags
						ccall.add_argument (new CCodeConstant ("0"));
					}
				}
			} else {
				ccall.add_argument (new CCodeConstant ("NULL"));
			}
			
			a.ccodenode = ccall;
			
			if (sig is DBusSignal && !disconnect) {
				bool first = true;
				foreach (FormalParameter param in m.get_parameters ()) {
					if (first) {
						// skip sender parameter
						first = false;
						continue;
					}
					sig.add_parameter (param);
				}

				sig.accept (this);

				// FIXME should only be done once per marshaller
				var register_call = new CCodeFunctionCall (new CCodeIdentifier ("dbus_g_object_register_marshaller"));
				register_call.add_argument (new CCodeIdentifier (get_signal_marshaller_function (sig)));
				register_call.add_argument (new CCodeIdentifier ("G_TYPE_NONE"));

				var add_call = new CCodeFunctionCall (new CCodeIdentifier ("dbus_g_proxy_add_signal"));
				if (ma.inner != null) {
					add_call.add_argument ((CCodeExpression) ma.inner.ccodenode);
				} else {
					add_call.add_argument (new CCodeIdentifier ("self"));
				}
				add_call.add_argument (sig.get_canonical_cconstant ());

				first = true;
				foreach (FormalParameter param in m.get_parameters ()) {
					if (first) {
						// skip sender parameter
						first = false;
						continue;
					}
					if (param.type_reference.data_type is Array && ((Array) param.type_reference.data_type).element_type != string_type.data_type) {
						var array = (Array) param.type_reference.data_type;
						var carray_type = new CCodeFunctionCall (new CCodeIdentifier ("dbus_g_type_get_collection"));
						carray_type.add_argument (new CCodeConstant ("\"GArray\""));
						carray_type.add_argument (new CCodeIdentifier (array.element_type.get_type_id ()));
						register_call.add_argument (carray_type);
						add_call.add_argument (carray_type);
					} else {
						register_call.add_argument (new CCodeIdentifier (param.type_reference.data_type.get_type_id ()));
						add_call.add_argument (new CCodeIdentifier (param.type_reference.data_type.get_type_id ()));
					}
				}
				register_call.add_argument (new CCodeIdentifier ("G_TYPE_INVALID"));
				add_call.add_argument (new CCodeIdentifier ("G_TYPE_INVALID"));

				var ccomma = new CCodeCommaExpression ();
				ccomma.append_expression (register_call);
				ccomma.append_expression (add_call);
				ccomma.append_expression (ccall);
				a.ccodenode = ccomma;
			}
		} else if (a.left is ElementAccess && !(((ElementAccess) a.left).container.static_type.data_type is Array)) {
			// custom element access
			CCodeExpression rhs = (CCodeExpression) a.right.ccodenode;
			
			if (a.left.static_type.data_type != null
			    && a.right.static_type.data_type != null
			    && a.left.static_type.data_type.is_reference_type ()
			    && a.right.static_type.data_type != a.left.static_type.data_type) {
				var ccast = new CCodeFunctionCall (new CCodeIdentifier (a.left.static_type.data_type.get_upper_case_cname (null)));
				ccast.add_argument (rhs);
				rhs = ccast;
			}
			
			var expr = (ElementAccess) a.left;
			var container_type = expr.container.static_type.data_type;
			Collection<Expression> indices = expr.get_indices ();
			Iterator<Expression> indices_it = indices.iterator ();
			indices_it.next ();

			var ccontainer = (CCodeExpression) expr.container.ccodenode;
			var cindex = (CCodeExpression) indices_it.get ().ccodenode;

			if (container_type != null && list_type != null && map_type != null &&
			    (container_type == list_type || container_type.is_subtype_of (list_type) ||
			     container_type == map_type || container_type.is_subtype_of (map_type))) {
				var set_method = (Method) container_type.scope.lookup ("set");
				Collection<FormalParameter> set_params = set_method.get_parameters ();
				Iterator<FormalParameter> set_params_it = set_params.iterator ();
				set_params_it.next ();
				var set_param = set_params_it.get ();

				if (set_param.type_reference.type_parameter != null) {
					var index_type = SemanticAnalyzer.get_actual_type (expr.container.static_type, set_method, set_param.type_reference, a);
					cindex = convert_to_generic_pointer (cindex, index_type);
				}

				var set_ccall = new CCodeFunctionCall (new CCodeIdentifier (set_method.get_cname ()));
				set_ccall.add_argument (new CCodeCastExpression (ccontainer, container_type.get_cname () + "*"));
				set_ccall.add_argument (cindex);
				set_ccall.add_argument (convert_to_generic_pointer (rhs, expr.static_type));

				a.ccodenode = set_ccall;
			} else {
				Report.error (a.source_reference, "internal error: unsupported element access");
				a.error = true;
			}
		} else {
			CCodeExpression rhs = (CCodeExpression) a.right.ccodenode;
			
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
				temp_vars.insert (0, temp_decl);
				ccomma.append_expression (new CCodeAssignment (new CCodeIdentifier (temp_decl.name), rhs));
				if (unref_old) {
					/* unref old value */
					ccomma.append_expression (get_unref_expression ((CCodeExpression) a.left.ccodenode, a.left.static_type, a.left));
				}
				
				if (array) {
					var arr = (Array) a.left.static_type.data_type;
					for (int dim = 1; dim <= arr.rank; dim++) {
						var lhs_array_len = get_array_length_cexpression (a.left, dim);
						var rhs_array_len = get_array_length_cexpression (a.right, dim);
						ccomma.append_expression (new CCodeAssignment (lhs_array_len, rhs_array_len));
					}
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

			if (unref_old && a.left.ccodenode is CCodeElementAccess) {
				// ensure that index expression in element access doesn't get evaluated more than once
				// except when it's a simple expression
				var cea = (CCodeElementAccess) a.left.ccodenode;
				if (!(cea.index is CCodeConstant || cea.index is CCodeIdentifier)) {
					var index_temp_decl = get_temp_variable_declarator (int_type);
					temp_vars.insert (0, index_temp_decl);
					
					var ccomma = new CCodeCommaExpression ();
					ccomma.append_expression (new CCodeAssignment (new CCodeIdentifier (index_temp_decl.name), cea.index));
					ccomma.append_expression ((CCodeExpression) a.ccodenode);

					cea.index = new CCodeIdentifier (index_temp_decl.name);
					
					a.ccodenode = ccomma;
				}
			}
		}
	}

	private CCodeFunctionCall get_property_set_call (Property! prop, MemberAccess! ma, CCodeExpression! cexpr) {
		var cl = (Class) prop.parent_symbol;
		var set_func = "g_object_set";
		
		var base_property = prop;
		if (!prop.no_accessor_method) {
			if (prop.base_property != null) {
				base_property = prop.base_property;
			} else if (prop.base_interface_property != null) {
				base_property = prop.base_interface_property;
			}
			var base_property_type = (DataType) base_property.parent_symbol;
			set_func = "%s_set_%s".printf (base_property_type.get_lower_case_cname (null), base_property.name);
		}
		
		var ccall = new CCodeFunctionCall (new CCodeIdentifier (set_func));

		/* target instance is first argument */
		CCodeExpression instance;
		var req_cast = false;

		if (ma.inner == null) {
			instance = new CCodeIdentifier ("self");
			/* require casts for inherited properties */
			req_cast = (base_property.parent_symbol != current_type_symbol);
		} else {
			instance = (CCodeExpression) ma.inner.ccodenode;
			/* require casts if the type of the used instance is
			 * different than the type which declared the property */
			req_cast = base_property.parent_symbol != ma.inner.static_type.data_type;
		}
		
		if (req_cast && ((DataType) prop.parent_symbol).is_reference_type ()) {
			var ccast = new CCodeFunctionCall (new CCodeIdentifier (((DataType) base_property.parent_symbol).get_upper_case_cname (null)));
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

