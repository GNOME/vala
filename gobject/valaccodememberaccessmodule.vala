/* valaccodememberaccessmodule.vala
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

public class Vala.CCodeMemberAccessModule : CCodeControlFlowModule {
	public CCodeMemberAccessModule (CCodeGenerator codegen, CCodeModule? next) {
		base (codegen, next);
	}

	public override void visit_member_access (MemberAccess expr) {
		expr.accept_children (codegen);

		CCodeExpression pub_inst = null;
		DataType base_type = null;
	
		if (expr.inner != null) {
			pub_inst = (CCodeExpression) expr.inner.ccodenode;

			if (expr.inner.value_type != null) {
				base_type = expr.inner.value_type;
			}
		}

		if (expr.symbol_reference is Method) {
			var m = (Method) expr.symbol_reference;
			
			if (expr.inner is BaseAccess) {
				if (m.base_method != null) {
					var base_class = (Class) m.base_method.parent_symbol;
					var vcast = new CCodeFunctionCall (new CCodeIdentifier ("%s_CLASS".printf (base_class.get_upper_case_cname (null))));
					vcast.add_argument (new CCodeIdentifier ("%s_parent_class".printf (current_class.get_lower_case_cname (null))));
					
					expr.ccodenode = new CCodeMemberAccess.pointer (vcast, m.name);
					return;
				} else if (m.base_interface_method != null) {
					var base_iface = (Interface) m.base_interface_method.parent_symbol;
					string parent_iface_var = "%s_%s_parent_iface".printf (current_class.get_lower_case_cname (null), base_iface.get_lower_case_cname (null));

					expr.ccodenode = new CCodeMemberAccess.pointer (new CCodeIdentifier (parent_iface_var), m.name);
					return;
				}
			}

			if (m.base_method != null) {
				if (!head.method_has_wrapper (m.base_method)) {
					var inst = pub_inst;
					if (expr.inner != null && !expr.inner.is_pure ()) {
						// instance expression has side-effects
						// store in temp. variable
						var temp_var = get_temp_variable (expr.inner.value_type);
						temp_vars.insert (0, temp_var);
						var ctemp = new CCodeIdentifier (temp_var.name);
						inst = new CCodeAssignment (ctemp, pub_inst);
						expr.inner.ccodenode = ctemp;
					}
					var base_class = (Class) m.base_method.parent_symbol;
					var vclass = new CCodeFunctionCall (new CCodeIdentifier ("%s_GET_CLASS".printf (base_class.get_upper_case_cname (null))));
					vclass.add_argument (inst);
					expr.ccodenode = new CCodeMemberAccess.pointer (vclass, m.name);
				} else {
					expr.ccodenode = new CCodeIdentifier (m.base_method.get_cname ());
				}
			} else if (m.base_interface_method != null) {
				expr.ccodenode = new CCodeIdentifier (m.base_interface_method.get_cname ());
			} else if (m is CreationMethod) {
				expr.ccodenode = new CCodeIdentifier (m.get_real_cname ());
			} else {
				expr.ccodenode = new CCodeIdentifier (m.get_cname ());
			}
		} else if (expr.symbol_reference is ArrayLengthField) {
			expr.ccodenode = head.get_array_length_cexpression (expr.inner, 1);
		} else if (expr.symbol_reference is Field) {
			var f = (Field) expr.symbol_reference;
			if (f.binding == MemberBinding.INSTANCE) {
				var instance_target_type = get_data_type_for_symbol ((TypeSymbol) f.parent_symbol);

				var cl = instance_target_type.data_type as Class;
				bool is_gtypeinstance = ((instance_target_type.data_type == cl) && (cl == null || !cl.is_compact));

				CCodeExpression inst;
				if (is_gtypeinstance && f.access == SymbolAccessibility.PRIVATE) {
					inst = new CCodeMemberAccess.pointer (pub_inst, "priv");
				} else {
					inst = pub_inst;
				}
				if (instance_target_type.data_type.is_reference_type () || (expr.inner != null && expr.inner.value_type is PointerType)) {
					expr.ccodenode = new CCodeMemberAccess.pointer (inst, f.get_cname ());
				} else {
					expr.ccodenode = new CCodeMemberAccess (inst, f.get_cname ());
				}
			} else if (f.binding == MemberBinding.CLASS) {
				var cl = (Class) f.parent_symbol;
				var cast = new CCodeFunctionCall (new CCodeIdentifier (cl.get_upper_case_cname (null) + "_CLASS"));

				CCodeExpression klass;
				if (expr.inner == null) {
					if (in_static_or_class_ctor) {
						// Accessing the field from a static or class constructor
						klass = new CCodeIdentifier ("klass");
					} else {
						// Accessing the field from within an instance method
						var k = new CCodeFunctionCall (new CCodeIdentifier ("G_OBJECT_GET_CLASS"));
						k.add_argument (new CCodeIdentifier ("self"));
						klass = k;
					}
				} else {
					// Accessing the field of an instance
					var k = new CCodeFunctionCall (new CCodeIdentifier ("G_OBJECT_GET_CLASS"));
					k.add_argument ((CCodeExpression) expr.inner.ccodenode);
					klass = k;
				}
				cast.add_argument (klass);

				if (f.access == SymbolAccessibility.PRIVATE) {
					var ccall = new CCodeFunctionCall (new CCodeIdentifier ("%s_GET_CLASS_PRIVATE".printf (cl.get_upper_case_cname ())));
					var ccall2 = new CCodeFunctionCall (new CCodeIdentifier ("G_TYPE_FROM_CLASS"));
					ccall2.add_argument (cast);
					ccall.add_argument (ccall2);
					expr.ccodenode = new CCodeMemberAccess.pointer (ccall, f.get_cname ());
				} else {
					expr.ccodenode = new CCodeMemberAccess.pointer (cast, f.get_cname ());
				}

			} else {
				expr.ccodenode = new CCodeIdentifier (f.get_cname ());
			}

			if (f.field_type.type_parameter != null && expr.value_type.type_parameter == null) {
				expr.ccodenode = convert_from_generic_pointer ((CCodeExpression) expr.ccodenode, expr.value_type);
			}
		} else if (expr.symbol_reference is Constant) {
			var c = (Constant) expr.symbol_reference;
			expr.ccodenode = new CCodeIdentifier (c.get_cname ());
		} else if (expr.symbol_reference is Property) {
			var prop = (Property) expr.symbol_reference;

			if (expr.inner is BaseAccess) {
				if (prop.base_property != null) {
					var base_class = (Class) prop.base_property.parent_symbol;
					var vcast = new CCodeFunctionCall (new CCodeIdentifier ("%s_CLASS".printf (base_class.get_upper_case_cname (null))));
					vcast.add_argument (new CCodeIdentifier ("%s_parent_class".printf (current_class.get_lower_case_cname (null))));
					
					var ccall = new CCodeFunctionCall (new CCodeMemberAccess.pointer (vcast, "get_%s".printf (prop.name)));
					ccall.add_argument ((CCodeExpression) expr.inner.ccodenode);
					expr.ccodenode = ccall;
					return;
				} else if (prop.base_interface_property != null) {
					var base_iface = (Interface) prop.base_interface_property.parent_symbol;
					string parent_iface_var = "%s_%s_parent_iface".printf (current_class.get_lower_case_cname (null), base_iface.get_lower_case_cname (null));

					var ccall = new CCodeFunctionCall (new CCodeMemberAccess.pointer (new CCodeIdentifier (parent_iface_var), "get_%s".printf (prop.name)));
					ccall.add_argument ((CCodeExpression) expr.inner.ccodenode);
					expr.ccodenode = ccall;
					return;
				}
			}

			if (prop.get_accessor.automatic_body &&
			    current_type_symbol == prop.parent_symbol &&
			    prop.base_property == null &&
			    prop.base_interface_property == null) {
				CCodeExpression inst;
				inst = new CCodeMemberAccess.pointer (pub_inst, "priv");
				expr.ccodenode = new CCodeMemberAccess.pointer (inst, prop.field.get_cname());
			} else if (!prop.no_accessor_method) {
				var base_property = prop;
				if (prop.base_property != null) {
					base_property = prop.base_property;
				} else if (prop.base_interface_property != null) {
					base_property = prop.base_interface_property;
				}
				string getter_cname;
				if (prop is DynamicProperty) {
					getter_cname = head.get_dynamic_property_getter_cname ((DynamicProperty) prop);
				} else {
					getter_cname = base_property.get_accessor.get_cname ();
				}
				var ccall = new CCodeFunctionCall (new CCodeIdentifier (getter_cname));

				if (prop.binding == MemberBinding.INSTANCE) {
					ccall.add_argument (pub_inst);
				}

				// Property access to real struct types is handled differently
				// The value is returned by out parameter
				if (base_property.property_type.is_real_struct_type ()) {
					var ccomma = new CCodeCommaExpression ();
					var temp_var = get_temp_variable (base_property.get_accessor.value_type);
					var ctemp = new CCodeIdentifier (temp_var.name);
					temp_vars.add (temp_var);
					ccall.add_argument (new CCodeUnaryExpression(CCodeUnaryOperator.ADDRESS_OF, ctemp));
					ccomma.append_expression (ccall);
					ccomma.append_expression (ctemp);
					expr.ccodenode = ccomma;
				} else {
					expr.ccodenode = ccall;
				}
			} else {
				var ccall = new CCodeFunctionCall (new CCodeIdentifier ("g_object_get"));
				ccall.add_argument (pub_inst);

				// property name is second argument of g_object_get
				ccall.add_argument (prop.get_canonical_cconstant ());

				// g_object_get always returns owned values
				// therefore, property getters of properties
				// without accessor methods need to be marked as owned

				var ccomma = new CCodeCommaExpression ();
				var temp_var = get_temp_variable (expr.value_type);
				var ctemp = new CCodeIdentifier (temp_var.name);
				temp_vars.add (temp_var);
				ccall.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, ctemp));
				ccall.add_argument (new CCodeConstant ("NULL"));
				ccomma.append_expression (ccall);
				ccomma.append_expression (ctemp);
				expr.ccodenode = ccomma;
			}
		} else if (expr.symbol_reference is EnumValue) {
			var ev = (EnumValue) expr.symbol_reference;
			expr.ccodenode = new CCodeConstant (ev.get_cname ());
		} else if (expr.symbol_reference is LocalVariable) {
			var local = (LocalVariable) expr.symbol_reference;
			expr.ccodenode = get_variable_cexpression (local.name);
		} else if (expr.symbol_reference is FormalParameter) {
			var p = (FormalParameter) expr.symbol_reference;
			if (p.name == "this") {
				if (current_method != null && current_method.coroutine) {
					// use closure
					expr.ccodenode = get_variable_cexpression ("self");
				} else {
					var st = current_type_symbol as Struct;
					if (st != null && !st.is_simple_type ()) {
						expr.ccodenode = new CCodeIdentifier ("(*self)");
					} else {
						expr.ccodenode = new CCodeIdentifier ("self");
					}
				}
			} else {
				if (current_method != null && current_method.coroutine) {
					// use closure
					expr.ccodenode = get_variable_cexpression (p.name);
				} else {
					var type_as_struct = p.parameter_type.data_type as Struct;
					if (p.direction != ParameterDirection.IN
					    || (type_as_struct != null && !type_as_struct.is_simple_type () && !p.parameter_type.nullable)) {
						expr.ccodenode = new CCodeIdentifier ("(*%s)".printf (p.name));
					} else {
						// Property setters of non simple structs shall replace all occurences
						// of the "value" formal parameter with a dereferencing version of that
						// parameter.
						if (current_property_accessor != null &&
						    current_property_accessor.writable &&
						    current_property_accessor.value_parameter == p &&
						    current_property_accessor.prop.property_type.is_real_struct_type ()) {
							expr.ccodenode = new CCodeIdentifier ("(*value)");
						} else {
							expr.ccodenode = new CCodeIdentifier (p.name);
						}
					}
				}
			}
		}
	}
}

