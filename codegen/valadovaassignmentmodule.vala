/* valadovaassignmentmodule.vala
 *
 * Copyright (C) 2006-2009  Jürg Billeter
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
 */

/**
 * The link between an assignment and generated code.
 */
internal class Vala.DovaAssignmentModule : DovaMemberAccessModule {
	public DovaAssignmentModule (CCodeGenerator codegen, CCodeModule? next) {
		base (codegen, next);
	}

	CCodeExpression emit_property_assignment (Assignment assignment) {
		var ma = assignment.left as MemberAccess;

		var prop = (Property) assignment.left.symbol_reference;

		if (!(prop is DynamicProperty)) {
			generate_property_accessor_declaration (prop.set_accessor, source_declarations);

			if (!prop.external && prop.external_package) {
				// internal VAPI properties
				// only add them once per source file
				if (add_generated_external_symbol (prop)) {
					visit_property (prop);
				}
			}
		}

		CCodeExpression cexpr = (CCodeExpression) assignment.right.ccodenode;

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

		var ccall = get_property_set_call (prop, ma, cexpr, assignment.right);

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

	CCodeExpression emit_simple_assignment (Assignment assignment) {
		CCodeExpression rhs = (CCodeExpression) assignment.right.ccodenode;
		CCodeExpression lhs = (CCodeExpression) get_ccodenode (assignment.left);
		CCodeCommaExpression outer_ccomma = null;

		bool unref_old = requires_destroy (assignment.left.value_type);

		if (unref_old) {
			var ccomma = new CCodeCommaExpression ();

			if (!is_pure_ccode_expression (lhs)) {
				/* Assign lhs to temp var to avoid repeating side effect */
				outer_ccomma = new CCodeCommaExpression ();

				var lhs_value_type = assignment.left.value_type.copy ();
				string lhs_temp_name = "_tmp%d_".printf (next_temp_var_id++);
				var lhs_temp = new LocalVariable (lhs_value_type, "*" + lhs_temp_name);
				temp_vars.add (lhs_temp);
				outer_ccomma.append_expression (new CCodeAssignment (get_variable_cexpression (lhs_temp_name), new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, lhs)));
				lhs = new CCodeParenthesizedExpression (new CCodeUnaryExpression (CCodeUnaryOperator.POINTER_INDIRECTION, get_variable_cexpression (lhs_temp_name)));
			}

			var temp_decl = get_temp_variable (assignment.left.value_type);
			temp_vars.add (temp_decl);
			ccomma.append_expression (new CCodeAssignment (get_variable_cexpression (temp_decl.name), rhs));
			if (unref_old) {
				/* unref old value */
				ccomma.append_expression (get_unref_expression (lhs, assignment.left.value_type, assignment.left));
			}

			ccomma.append_expression (get_variable_cexpression (temp_decl.name));

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

		CCodeExpression codenode = new CCodeAssignment (lhs, rhs, cop);

		if (outer_ccomma != null) {
			outer_ccomma.append_expression (codenode);
			codenode = outer_ccomma;
		}

		return codenode;
	}

	CCodeExpression emit_fixed_length_array_assignment (Assignment assignment, ArrayType array_type) {
		CCodeExpression rhs = (CCodeExpression) assignment.right.ccodenode;
		CCodeExpression lhs = (CCodeExpression) get_ccodenode (assignment.left);

		// it is necessary to use memcpy for fixed-length (stack-allocated) arrays
		// simple assignments do not work in C
		var sizeof_call = new CCodeFunctionCall (new CCodeIdentifier ("sizeof"));
		sizeof_call.add_argument (new CCodeIdentifier (array_type.element_type.get_cname ()));
		var size = new CCodeBinaryExpression (CCodeBinaryOperator.MUL, new CCodeConstant ("%d".printf (array_type.length)), sizeof_call);
		var ccopy = new CCodeFunctionCall (new CCodeIdentifier ("memcpy"));
		ccopy.add_argument (lhs);
		ccopy.add_argument (rhs);
		ccopy.add_argument (size);

		return ccopy;
	}

	public override void visit_assignment (Assignment assignment) {
		if (assignment.left.error || assignment.right.error) {
			assignment.error = true;
			return;
		}

		if (assignment.left.symbol_reference is Property) {
			assignment.ccodenode = emit_property_assignment (assignment);
		} else {
			var array_type = assignment.left.value_type as ArrayType;
			if (array_type != null && array_type.fixed_length) {
				assignment.ccodenode = emit_fixed_length_array_assignment (assignment, array_type);
			} else {
				assignment.ccodenode = emit_simple_assignment (assignment);
			}
		}
	}
}
