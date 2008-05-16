/* valaccodeassignmentbinding.vala
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
public class Vala.CCodeAssignmentBinding : CCodeExpressionBinding {
	public Assignment assignment { get; set; }

	public CCodeAssignmentBinding (CCodeGenerator codegen, Assignment assignment) {
		this.assignment = assignment;
		this.codegen = codegen;
	}

	private void emit_property_assignment () {
		var ma = assignment.left as MemberAccess;

		var prop = (Property) assignment.left.symbol_reference;

		if (prop.set_accessor.construction && codegen.current_type_symbol is Class && codegen.current_class.is_subtype_of (codegen.gobject_type) && codegen.in_creation_method) {
			codenode = get_construct_property_assignment (prop.get_canonical_cconstant (), prop.property_type, (CCodeExpression) assignment.right.ccodenode);
		} else {
			CCodeExpression cexpr = (CCodeExpression) assignment.right.ccodenode;

			// ensure to pass the value correctly typed (especially important for varargs)
			cexpr = codegen.get_implicit_cast_expression (cexpr, assignment.right.value_type, prop.property_type);

			if (!prop.no_accessor_method) {
				if (prop.property_type.is_real_struct_type ()) {
					cexpr = codegen.get_address_of_expression (assignment.right, cexpr);
				}
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
			if (sig is DynamicSignal) {
				connect_func = codegen.dynamic_signal_binding ((DynamicSignal) sig).get_connect_wrapper_name ();
			} else {
				connect_func = "g_signal_connect_object";
				if (m.binding != MemberBinding.INSTANCE) {
					connect_func = "g_signal_connect";
				}
			}
		} else if (assignment.operator == AssignmentOperator.SUB) {
			if (sig is DynamicSignal) {
				connect_func = codegen.dynamic_signal_binding ((DynamicSignal) sig).get_disconnect_wrapper_name ();
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

		if (sig is DynamicSignal) {
			// dynamic_signal_connect or dynamic_signal_disconnect

			// second argument: signal name
			ccall.add_argument (new CCodeConstant ("\"%s\"".printf (sig.name)));
		} else if (!disconnect) {
			// g_signal_connect_object or g_signal_connect

			// second argument: signal name
			ccall.add_argument (sig.get_canonical_cconstant ());
		} else {
			// g_signal_handlers_disconnect_matched

			// second argument: mask
			ccall.add_argument (new CCodeConstant ("G_SIGNAL_MATCH_ID | G_SIGNAL_MATCH_FUNC | G_SIGNAL_MATCH_DATA"));

			// get signal id
			var ccomma = new CCodeCommaExpression ();
			var temp_decl = codegen.get_temp_variable (codegen.uint_type);
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
		if (sig is DynamicSignal) {
			// signal handler wrappers not used for dynamic signals
			ccall.add_argument (new CCodeCastExpression (new CCodeIdentifier (m.get_cname ()), "GCallback"));
			m.cinstance_parameter_position = -1;
		} else {
			ccall.add_argument (new CCodeCastExpression (new CCodeIdentifier (generate_signal_handler_wrapper (m, sig)), "GCallback"));
		}

		if (m.binding == MemberBinding.INSTANCE) {
			// g_signal_connect_object or g_signal_handlers_disconnect_matched
			// or dynamic_signal_connect or dynamic_signal_disconnect

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
			if (!disconnect && !(sig is DynamicSignal)) {
				// g_signal_connect_object

				// fifth argument: connect_flags
				ccall.add_argument (new CCodeConstant ("0"));
			}
		} else {
			// g_signal_connect or g_signal_handlers_disconnect_matched
			// or dynamic_signal_connect or dynamic_signal_disconnect

			// fourth resp. seventh argument: user_data
			ccall.add_argument (new CCodeConstant ("NULL"));
		}
		
		codenode = ccall;
	}

	private string generate_signal_handler_wrapper (Method m, Signal sig) {
		string wrapper_name = "_%s_%s%s".printf (m.get_cname (), sig.parent_symbol.get_lower_case_cprefix (), sig.get_cname ());

		if (!codegen.add_wrapper (wrapper_name)) {
			// wrapper already defined
			return wrapper_name;
		}

		// declaration

		var function = new CCodeFunction (wrapper_name, m.return_type.get_cname ());
		function.modifiers = CCodeModifiers.STATIC;
		m.ccodenode = function;

		var cparam_map = new HashMap<int,CCodeFormalParameter> (direct_hash, direct_equal);

		var cparam = new CCodeFormalParameter ("self", "gpointer");
		cparam_map.set (codegen.get_param_pos (-1), cparam);

		cparam = new CCodeFormalParameter ("sender", ((Typesymbol) sig.parent_symbol).get_cname () + "*");
		cparam_map.set (codegen.get_param_pos (0), cparam);

		var sig_params = sig.get_parameters ();
		foreach (FormalParameter param in sig_params) {
			// ensure that C code node has been generated
			param.accept (codegen);

			cparam_map.set (codegen.get_param_pos (param.cparameter_position), (CCodeFormalParameter) param.ccodenode);
		}

		// append C parameters in the right order
		int last_pos = -1;
		int min_pos;
		while (true) {
			min_pos = -1;
			foreach (int pos in cparam_map.get_keys ()) {
				if (pos > last_pos && (min_pos == -1 || pos < min_pos)) {
					min_pos = pos;
				}
			}
			if (min_pos == -1) {
				break;
			}
			function.add_parameter (cparam_map.get (min_pos));
			last_pos = min_pos;
		}


		// definition

		var carg_map = new HashMap<int,CCodeExpression> (direct_hash, direct_equal);

		if (m.binding == MemberBinding.INSTANCE) {
			carg_map.set (codegen.get_param_pos (m.cinstance_parameter_position), new CCodeIdentifier ("self"));
		}

		int i = -1;
		foreach (FormalParameter param in m.get_parameters ()) {
			CCodeExpression arg;
			if (i < 0) {
				arg = new CCodeIdentifier ("sender");
			} else {
				arg = new CCodeIdentifier ((sig_params.get (i).ccodenode as CCodeFormalParameter).name);
			}
			carg_map.set (codegen.get_param_pos (param.cparameter_position), arg);
			i++;
		}

		var ccall = new CCodeFunctionCall (new CCodeIdentifier (m.get_cname ()));

		// append C arguments in the right order
		last_pos = -1;
		while (true) {
			min_pos = -1;
			foreach (int pos in carg_map.get_keys ()) {
				if (pos > last_pos && (min_pos == -1 || pos < min_pos)) {
					min_pos = pos;
				}
			}
			if (min_pos == -1) {
				break;
			}
			ccall.add_argument (carg_map.get (min_pos));
			last_pos = min_pos;
		}

		var block = new CCodeBlock ();
		if (m.return_type is VoidType) {
			block.add_statement (new CCodeExpressionStatement (ccall));
		} else {
			block.add_statement (new CCodeReturnStatement (ccall));
		}

		// append to file

		codegen.source_type_member_declaration.append (function.copy ());

		function.block = block;
		codegen.source_type_member_definition.append (function);

		return wrapper_name;
	}

	private void emit_non_array_element_access () {
		// custom element access
		CCodeExpression rhs = (CCodeExpression) assignment.right.ccodenode;

		rhs = codegen.get_implicit_cast_expression (rhs, assignment.right.value_type, assignment.left.value_type);

		var expr = (ElementAccess) assignment.left;
		var container_type = expr.container.value_type.data_type;
		Collection<Expression> indices = expr.get_indices ();
		Iterator<Expression> indices_it = indices.iterator ();
		indices_it.next ();

		var ccontainer = (CCodeExpression) expr.container.ccodenode;
		var cindex = (CCodeExpression) indices_it.get ().ccodenode;

		if (container_type != null && codegen.list_type != null && codegen.map_type != null &&
		    (container_type.is_subtype_of (codegen.list_type) || container_type.is_subtype_of (codegen.map_type))) {
			// lookup symbol in interface instead of class as implemented interface methods are not in VAPI files
			Typesymbol collection_iface = null;
			if (container_type.is_subtype_of (codegen.list_type)) {
				collection_iface = codegen.list_type;
			} else if (container_type.is_subtype_of (codegen.map_type)) {
				collection_iface = codegen.map_type;
			}
			var set_method = (Method) collection_iface.scope.lookup ("set");
			Collection<FormalParameter> set_params = set_method.get_parameters ();
			Iterator<FormalParameter> set_params_it = set_params.iterator ();
			set_params_it.next ();
			var set_param = set_params_it.get ();

			if (set_param.parameter_type.type_parameter != null) {
				var index_type = SemanticAnalyzer.get_actual_type (expr.container.value_type, set_method, set_param.parameter_type, assignment);
				cindex = codegen.convert_to_generic_pointer (cindex, index_type);
			}

			var set_ccall = new CCodeFunctionCall (new CCodeIdentifier (set_method.get_cname ()));
			set_ccall.add_argument (new CCodeCastExpression (ccontainer, collection_iface.get_cname () + "*"));
			set_ccall.add_argument (cindex);
			set_ccall.add_argument (codegen.convert_to_generic_pointer (rhs, expr.value_type));

			codenode = set_ccall;
		} else {
			Report.error (assignment.source_reference, "internal error: unsupported element access");
			assignment.error = true;
		}
	}

	private void emit_simple_assignment () {
		CCodeExpression rhs = (CCodeExpression) assignment.right.ccodenode;

		rhs = codegen.get_implicit_cast_expression (rhs, assignment.right.value_type, assignment.left.value_type);

		bool unref_old = codegen.requires_destroy (assignment.left.value_type);
		bool array = false;
		bool instance_delegate = false;
		if (assignment.left.value_type is ArrayType) {
			array = !(codegen.get_array_length_cexpression (assignment.left, 1) is CCodeConstant);
		} else if (assignment.left.value_type is DelegateType) {
			var delegate_type = (DelegateType) assignment.left.value_type;
			instance_delegate = delegate_type.delegate_symbol.has_target;
		}
		
		if (unref_old || array || instance_delegate) {
			var ccomma = new CCodeCommaExpression ();
			
			var temp_decl = codegen.get_temp_variable (assignment.left.value_type);
			codegen.temp_vars.insert (0, temp_decl);
			ccomma.append_expression (new CCodeAssignment (new CCodeIdentifier (temp_decl.name), rhs));
			if (unref_old) {
				/* unref old value */
				ccomma.append_expression (codegen.get_unref_expression ((CCodeExpression) assignment.left.ccodenode, assignment.left.value_type, assignment.left));
			}
			
			if (array) {
				var array_type = (ArrayType) assignment.left.value_type;
				for (int dim = 1; dim <= array_type.rank; dim++) {
					var lhs_array_len = codegen.get_array_length_cexpression (assignment.left, dim);
					var rhs_array_len = codegen.get_array_length_cexpression (assignment.right, dim);
					ccomma.append_expression (new CCodeAssignment (lhs_array_len, rhs_array_len));
				}
			} else if (instance_delegate) {
				var delegate_type = (DelegateType) assignment.left.value_type;
				var lhs_delegate_target = codegen.get_delegate_target_cexpression (assignment.left);
				var rhs_delegate_target = codegen.get_delegate_target_cexpression (assignment.right);
				ccomma.append_expression (new CCodeAssignment (lhs_delegate_target, rhs_delegate_target));
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
				var index_temp_decl = codegen.get_temp_variable (codegen.int_type);
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
		} else if (assignment.left is ElementAccess
		           && !(((ElementAccess) assignment.left).container.value_type is ArrayType)
		           && !(((ElementAccess) assignment.left).container.value_type is PointerType)) {
			emit_non_array_element_access ();
		} else {
			emit_simple_assignment ();
		}

		assignment.ccodenode = codenode;

		codegen.visit_expression (assignment);
	}
}
