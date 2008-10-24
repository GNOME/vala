/* valaccodemodule.vala
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

using Gee;

/**
 * Code visitor generating C Code.
 */
public abstract class Vala.CCodeModule {
	public weak CCodeGenerator codegen { get; private set; }

	public CCodeModule head {
		get { return _head; }
		private set {
			_head = value;
			// propagate head property to all modules
			if (next != null) {
				next.head = value;
			}
		}
	}

	weak CCodeModule _head;
	CCodeModule? next;

	public CCodeModule (CCodeGenerator codegen, CCodeModule? next) {
		this.codegen = codegen;
		this.next = next;
		this.head = this;
	}

	public virtual void emit (CodeContext context) {
		next.emit (context);
	}

	public virtual void visit_method (Method m) {
		next.visit_method (m);
	}

	public virtual void visit_creation_method (CreationMethod m) {
		next.visit_creation_method (m);
	}

	public virtual void generate_cparameters (Method m, DataType creturn_type, bool in_gtypeinstance_creation_method, Map<int,CCodeFormalParameter> cparam_map, CCodeFunction func, CCodeFunctionDeclarator? vdeclarator = null, Map<int,CCodeExpression>? carg_map = null, CCodeFunctionCall? vcall = null) {
		next.generate_cparameters (m, creturn_type, in_gtypeinstance_creation_method, cparam_map, func, vdeclarator, carg_map, vcall);
	}

	public virtual string? get_custom_creturn_type (Method m) {
		return next.get_custom_creturn_type (m);
	}

	public virtual void generate_dynamic_method_wrapper (DynamicMethod method) {
		next.generate_dynamic_method_wrapper (method);
	}

	public virtual bool method_has_wrapper (Method method) {
		return next.method_has_wrapper (method);
	}

	public virtual CCodeIdentifier get_value_setter_function (DataType type_reference) {
		return next.get_value_setter_function (type_reference);
	}

	public virtual CCodeExpression get_construct_property_assignment (CCodeConstant canonical_cconstant, DataType property_type, CCodeExpression value) {
		return next.get_construct_property_assignment (canonical_cconstant, property_type, value);
	}

	public virtual CCodeFunctionCall get_param_spec (Property prop) {
		return next.get_param_spec (prop);
	}

	public virtual CCodeFunctionCall get_signal_creation (Signal sig, TypeSymbol type) {
		return next.get_signal_creation (sig, type);
	}
}
