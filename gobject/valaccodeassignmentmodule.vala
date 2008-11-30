/* valaccodeassignmentmodule.vala
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
public class Vala.CCodeAssignmentModule : CCodeMemberAccessModule {
	public CCodeAssignmentModule (CCodeGenerator codegen, CCodeModule? next) {
		base (codegen, next);
	}

	CCodeExpression emit_property_assignment (Assignment assignment) {
		var ma = assignment.left as MemberAccess;

		var prop = (Property) assignment.left.symbol_reference;

		if (prop.set_accessor.construction && current_type_symbol is Class && current_class.is_subtype_of (gobject_type) && in_creation_method) {
			return head.get_construct_property_assignment (prop.get_canonical_cconstant (), prop.property_type, (CCodeExpression) assignment.right.ccodenode);
		} else {
			CCodeExpression cexpr = (CCodeExpression) assignment.right.ccodenode;

			if (!prop.no_accessor_method) {
				if (prop.property_type.is_real_struct_type ()) {
					cexpr = get_address_of_expression (assignment.right, cexpr);
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
				} else {
					assert_not_reached ();
				}
				cexpr = new CCodeBinaryExpression (cop, (CCodeExpression) get_ccodenode (assignment.left), cexpr);
			}
			
			var ccall = get_property_set_call (prop, ma, cexpr);
			
			// assignments are expressions, so return the current property value, except if we're sure that it can't be used
			if (!(assignment.parent_node is ExpressionStatement)) {
				var ccomma = new CCodeCommaExpression ();
				ccomma.append_expression (ccall); // update property
				ccomma.append_expression ((CCodeExpression) get_ccodenode (ma)); // current property value
				
				return ccomma;
			} else {
				return ccall;
			}
		}
	}

	private CCodeExpression? emit_non_array_element_access (Assignment assignment) {
		// custom element access
		CCodeExpression rhs = (CCodeExpression) assignment.right.ccodenode;

		var expr = (ElementAccess) assignment.left;
		var container_type = expr.container.value_type.data_type;
		Gee.List<Expression> indices = expr.get_indices ();
		Iterator<Expression> indices_it = indices.iterator ();
		indices_it.next ();

		var ccontainer = (CCodeExpression) get_ccodenode (expr.container);
		var cindex = (CCodeExpression) get_ccodenode (indices_it.get ());

		if (container_type != null && list_type != null && map_type != null &&
		    (container_type.is_subtype_of (list_type) || container_type.is_subtype_of (map_type))) {
			// lookup symbol in interface instead of class as implemented interface methods are not in VAPI files
			TypeSymbol collection_iface = null;
			if (container_type.is_subtype_of (list_type)) {
				collection_iface = list_type;
			} else if (container_type.is_subtype_of (map_type)) {
				collection_iface = map_type;
			}
			var set_method = (Method) collection_iface.scope.lookup ("set");
			Gee.List<FormalParameter> set_params = set_method.get_parameters ();
			Iterator<FormalParameter> set_params_it = set_params.iterator ();
			set_params_it.next ();
			var set_param = set_params_it.get ();

			if (set_param.parameter_type is GenericType) {
				var index_type = SemanticAnalyzer.get_actual_type (expr.container.value_type, (GenericType) set_param.parameter_type, assignment);
				cindex = convert_to_generic_pointer (cindex, index_type);
			}

			var set_ccall = new CCodeFunctionCall (new CCodeIdentifier (set_method.get_cname ()));
			set_ccall.add_argument (new CCodeCastExpression (ccontainer, collection_iface.get_cname () + "*"));
			set_ccall.add_argument (cindex);
			set_ccall.add_argument (convert_to_generic_pointer (rhs, expr.value_type));

			return set_ccall;
		} else {
			Report.error (assignment.source_reference, "internal error: unsupported element access");
			assignment.error = true;
			return null;
		}
	}

	CCodeExpression emit_simple_assignment (Assignment assignment) {
		CCodeExpression rhs = (CCodeExpression) assignment.right.ccodenode;

		bool unref_old = requires_destroy (assignment.left.value_type);
		bool array = false;
		bool instance_delegate = false;
		if (assignment.left.value_type is ArrayType) {
			array = !(head.get_array_length_cexpression (assignment.left, 1) is CCodeConstant);
		} else if (assignment.left.value_type is DelegateType) {
			var delegate_type = (DelegateType) assignment.left.value_type;
			instance_delegate = delegate_type.delegate_symbol.has_target;
		}
		
		if (unref_old || array || instance_delegate) {
			var ccomma = new CCodeCommaExpression ();
			
			var temp_decl = get_temp_variable (assignment.left.value_type);
			temp_vars.insert (0, temp_decl);
			ccomma.append_expression (new CCodeAssignment (new CCodeIdentifier (temp_decl.name), rhs));
			if (unref_old) {
				/* unref old value */
				ccomma.append_expression (get_unref_expression ((CCodeExpression) get_ccodenode (assignment.left), assignment.left.value_type, assignment.left));
			}
			
			if (array) {
				var array_type = (ArrayType) assignment.left.value_type;
				for (int dim = 1; dim <= array_type.rank; dim++) {
					var lhs_array_len = head.get_array_length_cexpression (assignment.left, dim);
					var rhs_array_len = head.get_array_length_cexpression (assignment.right, dim);
					ccomma.append_expression (new CCodeAssignment (lhs_array_len, rhs_array_len));
				}
			} else if (instance_delegate) {
				var lhs_delegate_target = get_delegate_target_cexpression (assignment.left);
				var rhs_delegate_target = get_delegate_target_cexpression (assignment.right);
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
	
		CCodeExpression codenode = new CCodeAssignment ((CCodeExpression) get_ccodenode (assignment.left), rhs, cop);

		if (unref_old && get_ccodenode (assignment.left) is CCodeElementAccess) {
			// ensure that index expression in element access doesn't get evaluated more than once
			// except when it's a simple expression
			var cea = (CCodeElementAccess) get_ccodenode (assignment.left);
			if (!(cea.index is CCodeConstant || cea.index is CCodeIdentifier)) {
				var index_temp_decl = get_temp_variable (int_type);
				temp_vars.insert (0, index_temp_decl);
				
				var ccomma = new CCodeCommaExpression ();
				ccomma.append_expression (new CCodeAssignment (new CCodeIdentifier (index_temp_decl.name), cea.index));
				ccomma.append_expression (codenode);

				cea.index = new CCodeIdentifier (index_temp_decl.name);
				
				codenode = ccomma;
			}
		}

		return codenode;
	}

	public override void visit_assignment (Assignment assignment) {
		assignment.right.accept (codegen);

		if (assignment.left.error || assignment.right.error) {
			assignment.error = true;
			return;
		}

		if (assignment.left.symbol_reference is Property) {
			assignment.ccodenode = emit_property_assignment (assignment);
		} else if (assignment.left is ElementAccess
		           && !(((ElementAccess) assignment.left).container.value_type is ArrayType)
		           && !(((ElementAccess) assignment.left).container.value_type is PointerType)) {
			assignment.ccodenode = emit_non_array_element_access (assignment);
		} else {
			assignment.ccodenode = emit_simple_assignment (assignment);
		}
	}
}
