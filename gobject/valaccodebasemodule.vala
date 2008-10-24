/* valaccodebasemodule.vala
 *
 * Copyright (C) 2008  Jürg Billeter
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
 * Code visitor generating C Code.
 */
public class Vala.CCodeBaseModule : CCodeModule {
	public CCodeBaseModule (CCodeGenerator codegen, CCodeModule? next) {
		base (codegen, next);
	}

	public override void emit (CodeContext context) {
	}

	public override CCodeIdentifier get_value_setter_function (DataType type_reference) {
		if (type_reference.data_type != null) {
			return new CCodeIdentifier (type_reference.data_type.get_set_value_function ());
		} else {
			return new CCodeIdentifier ("g_value_set_pointer");
		}
	}

	public override CCodeExpression get_construct_property_assignment (CCodeConstant canonical_cconstant, DataType property_type, CCodeExpression value) {
		// this property is used as a construction parameter
		var cpointer = new CCodeIdentifier ("__params_it");
		
		var ccomma = new CCodeCommaExpression ();
		// set name in array for current parameter
		var cnamemember = new CCodeMemberAccess.pointer (cpointer, "name");
		var cnameassign = new CCodeAssignment (cnamemember, canonical_cconstant);
		ccomma.append_expression (cnameassign);
		
		var gvaluearg = new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, new CCodeMemberAccess.pointer (cpointer, "value"));
		
		// initialize GValue in array for current parameter
		var cvalueinit = new CCodeFunctionCall (new CCodeIdentifier ("g_value_init"));
		cvalueinit.add_argument (gvaluearg);
		cvalueinit.add_argument (new CCodeIdentifier (property_type.get_type_id ()));
		ccomma.append_expression (cvalueinit);
		
		// set GValue for current parameter
		var cvalueset = new CCodeFunctionCall (get_value_setter_function (property_type));
		cvalueset.add_argument (gvaluearg);
		cvalueset.add_argument (value);
		ccomma.append_expression (cvalueset);
		
		// move pointer to next parameter in array
		ccomma.append_expression (new CCodeUnaryExpression (CCodeUnaryOperator.POSTFIX_INCREMENT, cpointer));

		return ccomma;
	}
}
