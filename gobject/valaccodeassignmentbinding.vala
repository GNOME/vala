/* valaccodeassignmentbinding.vala
 *
 * Copyright (C) 2006-2007  Jürg Billeter, Raffaele Sandrini
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
public class Vala.CCodeAssignmentBinding : CCodeExpressionBinding {
	public Assignment! assignment { get; set; }

	public CCodeAssignmentBinding (construct CodeGenerator! codegen, construct Assignment! assignment) {
	}

	private void emit_property_assignment () {
		var ma = assignment.left as MemberAccess;

		var prop = (Property) assignment.left.symbol_reference;

		if (prop.set_accessor.construction && codegen.current_type_symbol is Class && codegen.in_creation_method) {
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
			var cvalueset = new CCodeFunctionCall (codegen.get_value_setter_function (prop.type_reference));
			cvalueset.add_argument (gvaluearg);
			cvalueset.add_argument ((CCodeExpression) assignment.right.ccodenode);
			ccomma.append_expression (cvalueset);
			
			// move pointer to next parameter in array
			ccomma.append_expression (new CCodeUnaryExpression (CCodeUnaryOperator.POSTFIX_INCREMENT, cpointer));
			
			codenode = ccomma;
		} else {
			CCodeExpression cexpr = (CCodeExpression) assignment.right.ccodenode;

			if (!prop.no_accessor_method) {
				cexpr = codegen.get_implicit_cast_expression (cexpr, assignment.right.static_type, prop.type_reference);
			}

			if (assignment.operator != AssignmentOperator.SIMPLE) {
				CCodeBinaryOperator cop;
				if (assignment.operator == AssignmentOperator.BITWISE_OR) {
					cop = CCodeBinaryOperator.BITWISE_OR;
				} else if (assignment.operator == AssignmentOperator.BITWISE_AND) {
					cop = CCodeBinaryOperator.BITWISE_AND;
				} else if (assignment.operator == AssignmentOperator.BITWISE_XOR) {
					cop = CCodeBinaryOperator.BITWISE_XOR;
				} else if (assignment.operator == AssignmentOperator.ADD) {
					cop = CCodeBinaryOperator.PLUS;
				} else if (assignment.operator == AssignmentOperator.SUB) {
					cop = CCodeBinaryOperator.MINUS;
				} else if (assignment.operator == AssignmentOperator.MUL) {
					cop = CCodeBinaryOperator.MUL;
				} else if (assignment.operator == AssignmentOperator.DIV) {
					cop = CCodeBinaryOperator.DIV;
				} else if (assignment.operator == AssignmentOperator.PERCENT) {
					cop = CCodeBinaryOperator.MOD;
				} else if (assignment.operator == AssignmentOperator.SHIFT_LEFT) {
					cop = CCodeBinaryOperator.SHIFT_LEFT;
				} else if (assignment.operator == AssignmentOperator.SHIFT_RIGHT) {
					cop = CCodeBinaryOperator.SHIFT_RIGHT;
				}
				cexpr = new CCodeBinaryExpression (cop, (CCodeExpression) assignment.left.ccodenode, new CCodeParenthesizedExpression (cexpr));
			}
			
			var ccall = codegen.get_property_set_call (prop, ma, cexpr);
			
			// assignments are expressions, so return the current property value, except if we're sure that it can't be used
			if (!(assignment.parent_node is ExpressionStatement)) {
				var ccomma = new CCodeCommaExpression ();
				ccomma.append_expression (ccall); // update property
				ccomma.append_expression ((CCodeExpression) ma.ccodenode); // current property value
				
				codenode = ccomma;
			} else {
				codenode = ccall;
			}
		}
	}

	private void emit_signal_assignment () {
		var ma = assignment.left as MemberAccess;

		var sig = (Signal) assignment.left.symbol_reference;
		
		var m = (Method) assignment.right.symbol_reference;

		string connect_func;
		bool disconnect = false;

		if (assignment.operator == AssignmentOperator.ADD) {
			if (sig is DBusSignal) {
				connect_func = "dbus_g_proxy_connect_signal";
			} else {
				connect_func = "g_signal_connect_object";
				if (!m.instance) {
					connect_func = "g_signal_connect";
				}
			}
		} else if (assignment.operator == AssignmentOperator.SUB) {
			if (sig is DBusSignal) {
				connect_func = "dbus_g_proxy_disconnect_signal";
			} else {
				connect_func = "g_signal_handlers_disconnect_matched";
			}
			disconnect = true;
		} else {
			assignment.error = true;
			Report.error (assignment.source_reference, "Specified compound assignment type for signals not supported.");
			return;
		}

		var ccall = new CCodeFunctionCall (new CCodeIdentifier (connect_func));

		// first argument: instance of sender
		if (ma.inner != null) {
			ccall.add_argument ((CCodeExpression) ma.inner.ccodenode);
		} else {
			ccall.add_argument (new CCodeIdentifier ("self"));
		}

		if (!disconnect || sig is DBusSignal) {
			// g_signal_connect_object or g_signal_connect
			// or dbus_g_proxy_connect_signal or dbus_g_proxy_disconnect_signal

			// second argument: signal name
			ccall.add_argument (sig.get_canonical_cconstant ());
		} else {
			// g_signal_handlers_disconnect_matched

			// second argument: mask
			ccall.add_argument (new CCodeConstant ("G_SIGNAL_MATCH_ID | G_SIGNAL_MATCH_FUNC | G_SIGNAL_MATCH_DATA"));

			// get signal id
			var ccomma = new CCodeCommaExpression ();
			var temp_decl = codegen.get_temp_variable_declarator (codegen.uint_type);
			codegen.temp_vars.insert (0, temp_decl);
			var parse_call = new CCodeFunctionCall (new CCodeIdentifier ("g_signal_parse_name"));
			parse_call.add_argument (sig.get_canonical_cconstant ());
			var decl_type = (Typesymbol) sig.parent_symbol;
			parse_call.add_argument (new CCodeIdentifier (decl_type.get_type_id ()));
			parse_call.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, new CCodeIdentifier (temp_decl.name)));
			parse_call.add_argument (new CCodeConstant ("NULL"));
			parse_call.add_argument (new CCodeConstant ("FALSE"));
			ccomma.append_expression (parse_call);
			ccomma.append_expression (new CCodeIdentifier (temp_decl.name));

			// third argument: signal_id
			ccall.add_argument (ccomma);

			// fourth argument: detail
			ccall.add_argument (new CCodeConstant ("0"));
			// fifth argument: closure
			ccall.add_argument (new CCodeConstant ("NULL"));
		}

		// third resp. sixth argument: handler
		ccall.add_argument (new CCodeCastExpression (new CCodeIdentifier (m.get_cname ()), "GCallback"));

		if (m.instance) {
			// g_signal_connect_object or g_signal_handlers_disconnect_matched
			// or dbus_g_proxy_connect_signal or dbus_g_proxy_disconnect_signal

			// fourth resp. seventh argument: object/user_data
			if (assignment.right is MemberAccess) {
				var right_ma = (MemberAccess) assignment.right;
				if (right_ma.inner != null) {
					ccall.add_argument ((CCodeExpression) right_ma.inner.ccodenode);
				} else {
					ccall.add_argument (new CCodeIdentifier ("self"));
				}
			} else if (assignment.right is LambdaExpression) {
				ccall.add_argument (new CCodeIdentifier ("self"));
			}
			if (!disconnect) {
				if (sig is DBusSignal) {
					// dbus_g_proxy_connect_signal

					// fifth argument: free_data_func
					ccall.add_argument (new CCodeConstant ("NULL"));
				} else {
					// g_signal_connect_object

					// fifth argument: connect_flags
					ccall.add_argument (new CCodeConstant ("0"));
				}
			}
		} else {
			// g_signal_connect or g_signal_handlers_disconnect_matched
			// or dbus_g_proxy_connect_signal or dbus_g_proxy_disconnect_signal

			// fourth resp. seventh argument: user_data
			ccall.add_argument (new CCodeConstant ("NULL"));

			if (sig is DBusSignal && !disconnect) {
				// fifth argument: free_data_func
				ccall.add_argument (new CCodeConstant ("NULL"));
			}
		}
		
		codenode = ccall;
		
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

			sig.accept (codegen);

			// FIXME should only be done once per marshaller
			var register_call = new CCodeFunctionCall (new CCodeIdentifier ("dbus_g_object_register_marshaller"));
			register_call.add_argument (new CCodeIdentifier (codegen.get_signal_marshaller_function (sig)));
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
				if (param.type_reference.data_type is Array && ((Array) param.type_reference.data_type).element_type != codegen.string_type.data_type) {
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
			codenode = ccomma;
		}
	}

	private void emit_non_array_element_access () {
		// custom element access
		CCodeExpression rhs = (CCodeExpression) assignment.right.ccodenode;

		rhs = codegen.get_implicit_cast_expression (rhs, assignment.right.static_type, assignment.left.static_type);

		var expr = (ElementAccess) assignment.left;
		var container_type = expr.container.static_type.data_type;
		Collection<Expression> indices = expr.get_indices ();
		Iterator<Expression> indices_it = indices.iterator ();
		indices_it.next ();

		var ccontainer = (CCodeExpression) expr.container.ccodenode;
		var cindex = (CCodeExpression) indices_it.get ().ccodenode;

		if (container_type != null && codegen.list_type != null && codegen.map_type != null &&
		    (container_type.is_subtype_of (codegen.list_type) || container_type.is_subtype_of (codegen.map_type))) {
			var set_method = (Method) container_type.scope.lookup ("set");
			Collection<FormalParameter> set_params = set_method.get_parameters ();
			Iterator<FormalParameter> set_params_it = set_params.iterator ();
			set_params_it.next ();
			var set_param = set_params_it.get ();

			if (set_param.type_reference.type_parameter != null) {
				var index_type = SemanticAnalyzer.get_actual_type (expr.container.static_type, set_method, set_param.type_reference, assignment);
				cindex = codegen.convert_to_generic_pointer (cindex, index_type);
			}

			var set_ccall = new CCodeFunctionCall (new CCodeIdentifier (set_method.get_cname ()));
			set_ccall.add_argument (new CCodeCastExpression (ccontainer, container_type.get_cname () + "*"));
			set_ccall.add_argument (cindex);
			set_ccall.add_argument (codegen.convert_to_generic_pointer (rhs, expr.static_type));

			codenode = set_ccall;
		} else {
			Report.error (assignment.source_reference, "internal error: unsupported element access");
			assignment.error = true;
		}
	}

	private void emit_simple_assignment () {
		CCodeExpression rhs = (CCodeExpression) assignment.right.ccodenode;

		rhs = codegen.get_implicit_cast_expression (rhs, assignment.right.static_type, assignment.left.static_type);

		bool unref_old = (codegen.memory_management && assignment.left.static_type.takes_ownership);
		bool array = false;
		if (assignment.left.static_type.data_type is Array) {
			array = !(codegen.get_array_length_cexpression (assignment.left, 1) is CCodeConstant);
		}
		
		if (unref_old || array) {
			var ccomma = new CCodeCommaExpression ();
			
			var temp_decl = codegen.get_temp_variable_declarator (assignment.left.static_type);
			codegen.temp_vars.insert (0, temp_decl);
			ccomma.append_expression (new CCodeAssignment (new CCodeIdentifier (temp_decl.name), rhs));
			if (unref_old) {
				/* unref old value */
				ccomma.append_expression (codegen.get_unref_expression ((CCodeExpression) assignment.left.ccodenode, assignment.left.static_type, assignment.left));
			}
			
			if (array) {
				var arr = (Array) assignment.left.static_type.data_type;
				for (int dim = 1; dim <= arr.rank; dim++) {
					var lhs_array_len = codegen.get_array_length_cexpression (assignment.left, dim);
					var rhs_array_len = codegen.get_array_length_cexpression (assignment.right, dim);
					ccomma.append_expression (new CCodeAssignment (lhs_array_len, rhs_array_len));
				}
			}
			
			ccomma.append_expression (new CCodeIdentifier (temp_decl.name));
			
			rhs = ccomma;
		}
		
		var cop = CCodeAssignmentOperator.SIMPLE;
		if (assignment.operator == AssignmentOperator.BITWISE_OR) {
			cop = CCodeAssignmentOperator.BITWISE_OR;
		} else if (assignment.operator == AssignmentOperator.BITWISE_AND) {
			cop = CCodeAssignmentOperator.BITWISE_AND;
		} else if (assignment.operator == AssignmentOperator.BITWISE_XOR) {
			cop = CCodeAssignmentOperator.BITWISE_XOR;
		} else if (assignment.operator == AssignmentOperator.ADD) {
			cop = CCodeAssignmentOperator.ADD;
		} else if (assignment.operator == AssignmentOperator.SUB) {
			cop = CCodeAssignmentOperator.SUB;
		} else if (assignment.operator == AssignmentOperator.MUL) {
			cop = CCodeAssignmentOperator.MUL;
		} else if (assignment.operator == AssignmentOperator.DIV) {
			cop = CCodeAssignmentOperator.DIV;
		} else if (assignment.operator == AssignmentOperator.PERCENT) {
			cop = CCodeAssignmentOperator.PERCENT;
		} else if (assignment.operator == AssignmentOperator.SHIFT_LEFT) {
			cop = CCodeAssignmentOperator.SHIFT_LEFT;
		} else if (assignment.operator == AssignmentOperator.SHIFT_RIGHT) {
			cop = CCodeAssignmentOperator.SHIFT_RIGHT;
		}
	
		codenode = new CCodeAssignment ((CCodeExpression) assignment.left.ccodenode, rhs, cop);

		if (unref_old && assignment.left.ccodenode is CCodeElementAccess) {
			// ensure that index expression in element access doesn't get evaluated more than once
			// except when it's a simple expression
			var cea = (CCodeElementAccess) assignment.left.ccodenode;
			if (!(cea.index is CCodeConstant || cea.index is CCodeIdentifier)) {
				var index_temp_decl = codegen.get_temp_variable_declarator (codegen.int_type);
				codegen.temp_vars.insert (0, index_temp_decl);
				
				var ccomma = new CCodeCommaExpression ();
				ccomma.append_expression (new CCodeAssignment (new CCodeIdentifier (index_temp_decl.name), cea.index));
				ccomma.append_expression (codenode);

				cea.index = new CCodeIdentifier (index_temp_decl.name);
				
				codenode = ccomma;
			}
		}
	}

	public override void emit () {
		assignment.accept_children (codegen);

		if (assignment.left.symbol_reference is Property) {
			emit_property_assignment ();
		} else if (assignment.left.symbol_reference is Signal) {
			emit_signal_assignment ();
		} else if (assignment.left is ElementAccess && !(((ElementAccess) assignment.left).container.static_type.data_type is Array)) {
			emit_non_array_element_access ();
		} else {
			emit_simple_assignment ();
		}

		assignment.ccodenode = codenode;
	}
}
