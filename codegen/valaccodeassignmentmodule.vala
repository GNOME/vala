/* valaccodeassignmentmodule.vala
 *
 * Copyright (C) 2006-2010  Jürg Billeter
 * Copyright (C) 2006-2008  Raffaele Sandrini
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
public class Vala.CCodeAssignmentModule : CCodeMemberAccessModule {
	CCodeExpression? emit_simple_assignment (Assignment assignment) {
		Variable variable = (Variable) assignment.left.symbol_reference;

		CCodeExpression rhs = get_cvalue (assignment.right);
		CCodeExpression lhs = (CCodeExpression) get_ccodenode (assignment.left);

		bool unref_old = requires_destroy (assignment.left.value_type);
		bool array = false;
		bool instance_delegate = false;
		if (assignment.left.value_type is ArrayType) {
			array = !(variable is Field) || !variable.no_array_length;
		} else if (assignment.left.value_type is DelegateType) {
			var delegate_type = (DelegateType) assignment.left.value_type;
			if (delegate_type.delegate_symbol.has_target) {
				instance_delegate = !(variable is Field) || !variable.no_delegate_target;
			}
		}

		if (unref_old || array || instance_delegate) {
			if (!is_pure_ccode_expression (lhs)) {
				/* Assign lhs to temp var to avoid repeating side effect */
				var lhs_value_type = assignment.left.value_type.copy ();
				string lhs_temp_name = "_tmp%d_".printf (next_temp_var_id++);
				var lhs_temp = new LocalVariable (lhs_value_type, "*" + lhs_temp_name);
				emit_temp_var (lhs_temp);
				ccode.add_assignment (get_variable_cexpression (lhs_temp_name), new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, lhs));
				lhs = new CCodeParenthesizedExpression (new CCodeUnaryExpression (CCodeUnaryOperator.POINTER_INDIRECTION, get_variable_cexpression (lhs_temp_name)));
			}

			var temp_decl = get_temp_variable (assignment.left.value_type, true, null, false);
			emit_temp_var (temp_decl);
			ccode.add_assignment (get_variable_cexpression (temp_decl.name), rhs);
			if (unref_old) {
				/* unref old value */
				var value = ((GLibValue) assignment.left.target_value).copy ();
				value.cvalue = lhs;
				ccode.add_expression (destroy_value (value));
			}
			
			if (array && !variable.no_array_length && !variable.array_null_terminated) {
				var array_type = (ArrayType) assignment.left.value_type;
				for (int dim = 1; dim <= array_type.rank; dim++) {
					var lhs_array_len = get_array_length_cexpression (assignment.left, dim);
					var rhs_array_len = get_array_length_cexpression (assignment.right, dim);
					ccode.add_assignment (lhs_array_len, rhs_array_len);
				}
				if (array_type.rank == 1) {
					var array_var = assignment.left.symbol_reference;
					var array_local = array_var as LocalVariable;
					if (array_var != null && array_var.is_internal_symbol ()
					    && ((array_var is LocalVariable && !array_local.captured) || array_var is Field)) {
						var lhs_array_size = get_array_size_cvalue (assignment.left.target_value);
						var rhs_array_len = get_array_length_cexpression (assignment.left, 1);
						ccode.add_assignment (lhs_array_size, rhs_array_len);
					}
				}
			} else if (instance_delegate) {
				CCodeExpression lhs_delegate_target_destroy_notify, rhs_delegate_target_destroy_notify;
				var lhs_delegate_target = get_delegate_target_cexpression (assignment.left, out lhs_delegate_target_destroy_notify);
				var rhs_delegate_target = get_delegate_target_cexpression (assignment.right, out rhs_delegate_target_destroy_notify);
				ccode.add_assignment (lhs_delegate_target, rhs_delegate_target);
				if (assignment.right.target_type.value_owned) {
					ccode.add_assignment (lhs_delegate_target_destroy_notify, rhs_delegate_target_destroy_notify);
				}
			}

			rhs = get_variable_cexpression (temp_decl.name);
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

		ccode.add_expression (codenode);

		return lhs;
	}

	CCodeExpression? emit_fixed_length_array_assignment (Assignment assignment, ArrayType array_type) {
		CCodeExpression rhs = get_cvalue (assignment.right);
		CCodeExpression lhs = (CCodeExpression) get_ccodenode (assignment.left);

		cfile.add_include ("string.h");

		// it is necessary to use memcpy for fixed-length (stack-allocated) arrays
		// simple assignments do not work in C
		var sizeof_call = new CCodeFunctionCall (new CCodeIdentifier ("sizeof"));
		sizeof_call.add_argument (new CCodeIdentifier (array_type.element_type.get_cname ()));
		var size = new CCodeBinaryExpression (CCodeBinaryOperator.MUL, new CCodeConstant ("%d".printf (array_type.length)), sizeof_call);
		var ccopy = new CCodeFunctionCall (new CCodeIdentifier ("memcpy"));
		ccopy.add_argument (lhs);
		ccopy.add_argument (rhs);
		ccopy.add_argument (size);

		ccode.add_expression (ccopy);

		return lhs;
	}

	public override void visit_assignment (Assignment assignment) {
		if (assignment.left.error || assignment.right.error) {
			assignment.error = true;
			return;
		}

		if (assignment.left.symbol_reference is Property) {
			var ma = assignment.left as MemberAccess;
			var prop = (Property) assignment.left.symbol_reference;

			if (assignment.parent_node is ExpressionStatement) {
				store_property (prop, ma.inner, assignment.right.target_value);

				set_cvalue (assignment, get_ccodenode (assignment.right));
			} else {
				// when load_variable is changed to use temporary
				// variables, this exception is no longer necessary

				var temp_decl = get_temp_variable (prop.property_type);
				emit_temp_var (temp_decl);
				ccode.add_assignment (get_variable_cexpression (temp_decl.name), get_cvalue_ (assignment.right.target_value));

				var target_value = ((GLibValue) assignment.right.target_value).copy ();
				target_value.cvalue = get_variable_cexpression (temp_decl.name);

				store_property (prop, ma.inner, target_value);

				assignment.target_value = target_value;
			}
		} else {
			var array_type = assignment.left.value_type as ArrayType;
			if (array_type != null && array_type.fixed_length) {
				set_cvalue (assignment, emit_fixed_length_array_assignment (assignment, array_type));
			} else {
				set_cvalue (assignment, emit_simple_assignment (assignment));
			}
		}
	}

	public override void store_value (TargetValue lvalue, TargetValue value) {
		var array_type = lvalue.value_type as ArrayType;

		if (array_type != null && array_type.fixed_length) {
			cfile.add_include ("string.h");

			// it is necessary to use memcpy for fixed-length (stack-allocated) arrays
			// simple assignments do not work in C
			var sizeof_call = new CCodeFunctionCall (new CCodeIdentifier ("sizeof"));
			sizeof_call.add_argument (new CCodeIdentifier (array_type.element_type.get_cname ()));
			var size = new CCodeBinaryExpression (CCodeBinaryOperator.MUL, new CCodeConstant ("%d".printf (array_type.length)), sizeof_call);

			var ccopy = new CCodeFunctionCall (new CCodeIdentifier ("memcpy"));
			ccopy.add_argument (get_cvalue_ (lvalue));
			ccopy.add_argument (get_cvalue_ (value));
			ccopy.add_argument (size);
			ccode.add_expression (ccopy);

			return;
		}

		var cexpr = get_cvalue_ (value);
		if (get_ctype (lvalue) != null) {
			cexpr = new CCodeCastExpression (cexpr, get_ctype (lvalue));
		}

		ccode.add_assignment (get_cvalue_ (lvalue), cexpr);

		if (array_type != null && ((GLibValue) lvalue).array_length_cvalues != null) {
			var glib_value = (GLibValue) value;
			if (glib_value.array_length_cvalues != null) {
				for (int dim = 1; dim <= array_type.rank; dim++) {
					ccode.add_assignment (get_array_length_cvalue (lvalue, dim), get_array_length_cvalue (value, dim));
				}
			} else if (glib_value.array_null_terminated) {
				requires_array_length = true;
				var len_call = new CCodeFunctionCall (new CCodeIdentifier ("_vala_array_length"));
				len_call.add_argument (get_cvalue_ (value));

				ccode.add_assignment (get_array_length_cvalue (lvalue, 1), len_call);
			} else {
				for (int dim = 1; dim <= array_type.rank; dim++) {
					ccode.add_assignment (get_array_length_cvalue (lvalue, dim), new CCodeConstant ("-1"));
				}
			}

			if (array_type.rank == 1 && get_array_size_cvalue (lvalue) != null) {
				ccode.add_assignment (get_array_size_cvalue (lvalue), get_array_length_cvalue (lvalue, 1));
			}
		}

		var delegate_type = lvalue.value_type as DelegateType;
		if (delegate_type != null && delegate_type.delegate_symbol.has_target) {
			if (get_delegate_target_cvalue (lvalue) != null) {
				ccode.add_assignment (get_delegate_target_cvalue (lvalue), get_delegate_target_cvalue (value));
				if (get_delegate_target_destroy_notify_cvalue (lvalue) != null) {
					ccode.add_assignment (get_delegate_target_destroy_notify_cvalue (lvalue), get_delegate_target_destroy_notify_cvalue (value));
				}
			}
		}
	}

	public override void store_local (LocalVariable local, TargetValue value, bool initializer) {
		if (!initializer && requires_destroy (local.variable_type)) {
			/* unref old value */
			ccode.add_expression (destroy_local (local));
		}

		store_value (get_local_cvalue (local), value);
	}

	public override void store_parameter (Parameter param, TargetValue value) {
		if (requires_destroy (param.variable_type)) {
			/* unref old value */
			ccode.add_expression (destroy_parameter (param));
		}

		store_value (get_parameter_cvalue (param), value);
	}

	public override void store_field (Field field, TargetValue? instance, TargetValue value) {
		var lvalue = get_field_cvalue (field, instance);
		var type = lvalue.value_type;
		if (lvalue.actual_value_type != null) {
			type = lvalue.actual_value_type;
		}
		if (requires_destroy (type)) {
			/* unref old value */
			ccode.add_expression (destroy_field (field, instance));
		}

		store_value (lvalue, value);
	}
}
