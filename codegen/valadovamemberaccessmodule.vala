/* valadovamemberaccessmodule.vala
 *
 * Copyright (C) 2006-2010  Jürg Billeter
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

using GLib;

internal class Vala.DovaMemberAccessModule : DovaControlFlowModule {
	public DovaMemberAccessModule (CCodeGenerator codegen, CCodeModule? next) {
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

			if (!(m is DynamicMethod)) {
				generate_method_declaration (m, source_declarations);

				if (!m.external && m.external_package) {
					// internal VAPI methods
					// only add them once per source file
					if (add_generated_external_symbol (m)) {
						visit_method (m);
					}
				}
			}

			if (expr.inner is BaseAccess) {
				if (m.base_method != null) {
					var base_class = (Class) m.base_method.parent_symbol;

					expr.ccodenode = new CCodeIdentifier ("%s_base_%s".printf (base_class.get_lower_case_cname (null), m.name));
					return;
				} else if (m.base_interface_method != null) {
					var base_iface = (Interface) m.base_interface_method.parent_symbol;

					expr.ccodenode = new CCodeIdentifier ("%s_base_%s".printf (base_iface.get_lower_case_cname (null), m.name));
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
			generate_property_accessor_declaration (((Property) array_class.scope.lookup ("length")).get_accessor, source_declarations);

			var ccall = new CCodeFunctionCall (new CCodeIdentifier ("dova_array_get_length"));
			ccall.add_argument (pub_inst);
			expr.ccodenode = ccall;
		} else if (expr.symbol_reference is Field) {
			var f = (Field) expr.symbol_reference;
			if (f.binding == MemberBinding.INSTANCE) {
				var instance_target_type = get_data_type_for_symbol ((TypeSymbol) f.parent_symbol);

				var cl = instance_target_type.data_type as Class;
				bool dova_priv = false;
				if ((f.access == SymbolAccessibility.PRIVATE || f.access == SymbolAccessibility.INTERNAL)) {
					dova_priv = true;
				}

				CCodeExpression inst;
				if (dova_priv) {
					var priv_call = new CCodeFunctionCall (new CCodeIdentifier ("%s_GET_PRIVATE".printf (cl.get_upper_case_cname (null))));
					priv_call.add_argument (pub_inst);
					inst = priv_call;
				} else {
					inst = pub_inst;
				}
				if (instance_target_type.data_type.is_reference_type () || (expr.inner != null && expr.inner.value_type is PointerType)) {
					expr.ccodenode = new CCodeMemberAccess.pointer (inst, f.get_cname ());
				} else {
					expr.ccodenode = new CCodeMemberAccess (inst, f.get_cname ());
				}
			} else {
				generate_field_declaration (f, source_declarations);

				expr.ccodenode = new CCodeIdentifier (f.get_cname ());
			}
		} else if (expr.symbol_reference is EnumValue) {
			var ev = (EnumValue) expr.symbol_reference;

			generate_enum_declaration ((Enum) ev.parent_symbol, source_declarations);

			expr.ccodenode = new CCodeConstant (ev.get_cname ());
		} else if (expr.symbol_reference is Constant) {
			var c = (Constant) expr.symbol_reference;

			generate_constant_declaration (c, source_declarations);

			expr.ccodenode = new CCodeIdentifier (c.get_cname ());
		} else if (expr.symbol_reference is Property) {
			var prop = (Property) expr.symbol_reference;

			if (!(prop is DynamicProperty)) {
				generate_property_accessor_declaration (prop.get_accessor, source_declarations);

				if (!prop.external && prop.external_package) {
					// internal VAPI properties
					// only add them once per source file
					if (add_generated_external_symbol (prop)) {
						visit_property (prop);
					}
				}
			}

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

			expr.ccodenode = ccall;
		} else if (expr.symbol_reference is LocalVariable) {
			var local = (LocalVariable) expr.symbol_reference;
			if (local.is_result) {
				// used in postconditions
				expr.ccodenode = new CCodeIdentifier ("result");
			} else if (local.captured) {
				// captured variables are stored on the heap
				var block = (Block) local.parent_symbol;
				expr.ccodenode = new CCodeMemberAccess.pointer (get_variable_cexpression ("_data%d_".printf (get_block_id (block))), get_variable_cname (local.name));
			} else {
				expr.ccodenode = get_variable_cexpression (local.name);
			}
		} else if (expr.symbol_reference is FormalParameter) {
			var p = (FormalParameter) expr.symbol_reference;
			if (p.name == "this") {
				if (current_method != null && current_method.coroutine) {
					// use closure
					expr.ccodenode = new CCodeMemberAccess.pointer (new CCodeIdentifier ("data"), "this");
				} else {
					var st = current_type_symbol as Struct;
					if (st != null && !st.is_boolean_type () && !st.is_integer_type () && !st.is_floating_type () && (!st.is_simple_type () || current_method is CreationMethod)) {
						expr.ccodenode = new CCodeIdentifier ("(*this)");
					} else {
						expr.ccodenode = new CCodeIdentifier ("this");
					}
				}
			} else {
				if (p.captured) {
					// captured variables are stored on the heap
					var block = p.parent_symbol as Block;
					if (block == null) {
						block = ((Method) p.parent_symbol).body;
					}
					expr.ccodenode = new CCodeMemberAccess.pointer (get_variable_cexpression ("_data%d_".printf (get_block_id (block))), get_variable_cname (p.name));
				} else {
					if (current_method != null && current_method.coroutine) {
						// use closure
						expr.ccodenode = get_variable_cexpression (p.name);
					} else {
						var type_as_struct = p.variable_type.data_type as Struct;
						if (p.direction != ParameterDirection.IN
						    || (type_as_struct != null && !type_as_struct.is_simple_type () && !p.variable_type.nullable)) {
							if (p.variable_type is GenericType) {
								expr.ccodenode = get_variable_cexpression (p.name);
							} else {
								expr.ccodenode = new CCodeIdentifier ("(*%s)".printf (get_variable_cname (p.name)));
							}
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
								expr.ccodenode = get_variable_cexpression (p.name);
							}
						}
					}
				}
			}
		}
	}
}

