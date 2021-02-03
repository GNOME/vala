/* valagvaluemodule.vala
 *
 * Copyright (C) 2019  Rico Tzschichholz
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
 * 	Rico Tzschichholz <ricotz@ubuntu.com>
 */

public class Vala.GValueModule : GAsyncModule {
	public override void visit_cast_expression (CastExpression expr) {
		unowned DataType? value_type = expr.inner.value_type;
		unowned DataType? target_type = expr.type_reference;

		if (expr.is_non_null_cast || value_type == null || gvalue_type == null
		    || value_type.type_symbol != gvalue_type || target_type.type_symbol == gvalue_type
		    || get_ccode_type_id (target_type) == "") {
			base.visit_cast_expression (expr);
			return;
		}

		generate_type_declaration (expr.type_reference, cfile);

		// explicit conversion from GValue
		var ccall = new CCodeFunctionCall (get_value_getter_function (target_type));
		CCodeExpression gvalue;
		if (value_type.nullable) {
			gvalue = get_cvalue (expr.inner);
		} else {
			gvalue = new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, get_cvalue (expr.inner));
		}
		ccall.add_argument (gvalue);

		if (value_type.is_disposable ()) {
			var temp_var = get_temp_variable (value_type, true, expr, false);
			emit_temp_var (temp_var);
			var temp_ref = get_variable_cexpression (temp_var.name);
			ccode.add_assignment (temp_ref, get_cvalue (expr.inner));

			// value needs to be kept alive until the end of this block
			temp_ref_values.insert (0, get_local_cvalue (temp_var));
		}

		CCodeExpression rv = ccall;

		if (expr != null && target_type is ArrayType) {
			// null-terminated string array
			var len_call = new CCodeFunctionCall (new CCodeIdentifier ("g_strv_length"));
			len_call.add_argument (rv);
			append_array_length (expr, len_call);
		} else if (target_type is StructValueType) {
			CodeNode node = expr != null ? (CodeNode) expr : target_type;
			var temp_value = create_temp_value (target_type, true, node, true);
			var ctemp = get_cvalue_ (temp_value);

			rv = new CCodeUnaryExpression (CCodeUnaryOperator.POINTER_INDIRECTION, new CCodeCastExpression (rv, get_ccode_name (new PointerType (target_type))));
			var holds = new CCodeFunctionCall (new CCodeIdentifier ("G_VALUE_HOLDS"));
			holds.add_argument (gvalue);
			holds.add_argument (new CCodeIdentifier (get_ccode_type_id (target_type)));
			var cond = new CCodeBinaryExpression (CCodeBinaryOperator.AND, holds, ccall);
			var warn = new CCodeFunctionCall (new CCodeIdentifier ("g_warning"));
			warn.add_argument (new CCodeConstant ("\"Invalid GValue unboxing (wrong type or NULL)\""));
			var fail = new CCodeCommaExpression ();
			fail.append_expression (warn);
			fail.append_expression (ctemp);
			rv = new CCodeConditionalExpression (cond, rv,  fail);
		}

		set_cvalue (expr, rv);
	}

	public override CCodeExpression get_value_getter_function (DataType type_reference) {
		var array_type = type_reference as ArrayType;
		if (type_reference.type_symbol != null) {
			return new CCodeIdentifier (get_ccode_get_value_function (type_reference.type_symbol));
		} else if (array_type != null && array_type.element_type.type_symbol == string_type.type_symbol) {
			// G_TYPE_STRV
			return new CCodeIdentifier ("g_value_get_boxed");
		} else {
			return new CCodeIdentifier ("g_value_get_pointer");
		}
	}

	public override CCodeExpression get_value_setter_function (DataType type_reference) {
		var array_type = type_reference as ArrayType;
		if (type_reference.type_symbol != null) {
			return new CCodeIdentifier (get_ccode_set_value_function (type_reference.type_symbol));
		} else if (array_type != null && array_type.element_type.type_symbol == string_type.type_symbol) {
			// G_TYPE_STRV
			return new CCodeIdentifier ("g_value_set_boxed");
		} else {
			return new CCodeIdentifier ("g_value_set_pointer");
		}
	}

	public override CCodeExpression get_value_taker_function (DataType type_reference) {
		var array_type = type_reference as ArrayType;
		if (type_reference.type_symbol != null) {
			return new CCodeIdentifier (get_ccode_take_value_function (type_reference.type_symbol));
		} else if (array_type != null && array_type.element_type.type_symbol == string_type.type_symbol) {
			// G_TYPE_STRV
			return new CCodeIdentifier ("g_value_take_boxed");
		} else {
			return new CCodeIdentifier ("g_value_set_pointer");
		}
	}
}
