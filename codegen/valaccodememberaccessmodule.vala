/* valaccodememberaccessmodule.vala
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

			if (!(m is DynamicMethod || m is ArrayMoveMethod || m is ArrayResizeMethod)) {
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
					var vcast = new CCodeFunctionCall (new CCodeIdentifier ("%s_CLASS".printf (base_class.get_upper_case_cname (null))));
					vcast.add_argument (new CCodeIdentifier ("%s_parent_class".printf (current_class.get_lower_case_cname (null))));
					
					expr.ccodenode = new CCodeMemberAccess.pointer (vcast, m.vfunc_name);
					return;
				} else if (m.base_interface_method != null) {
					var base_iface = (Interface) m.base_interface_method.parent_symbol;
					string parent_iface_var = "%s_%s_parent_iface".printf (current_class.get_lower_case_cname (null), base_iface.get_lower_case_cname (null));

					expr.ccodenode = new CCodeMemberAccess.pointer (new CCodeIdentifier (parent_iface_var), m.vfunc_name);
					return;
				}
			}

			if (m.base_method != null) {
				if (!head.method_has_wrapper (m.base_method)) {
					var inst = pub_inst;
					if (expr.inner != null && !expr.inner.is_pure ()) {
						// instance expression has side-effects
						// store in temp. variable
						var temp_var = get_temp_variable (expr.inner.value_type, true, null, false);
						temp_vars.insert (0, temp_var);
						var ctemp = get_variable_cexpression (temp_var.name);
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
			if (expr.value_type is ArrayType && !(expr.parent_node is ElementAccess)) {
				Report.error (expr.source_reference, "unsupported use of length field of multi-dimensional array");
			}
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
					if (cl != null) {
						generate_class_struct_declaration (cl, source_declarations);
					}
					inst = pub_inst;
				}
				if (instance_target_type.data_type.is_reference_type () || (expr.inner != null && expr.inner.value_type is PointerType)) {
					expr.ccodenode = new CCodeMemberAccess.pointer (inst, f.get_cname ());
				} else {
					if (inst is CCodeCommaExpression) {
						var ccomma = inst as CCodeCommaExpression;
						var inner = ccomma.get_inner ();
						var last = inner.get (inner.size - 1);
						ccomma.set_expression (inner.size - 1, new CCodeMemberAccess (last, f.get_cname ()));
						expr.ccodenode = ccomma;
					} else {
						expr.ccodenode = new CCodeMemberAccess (inst, f.get_cname ());
					}
				}
			} else if (f.binding == MemberBinding.CLASS) {
				var cl = (Class) f.parent_symbol;
				var cast = new CCodeFunctionCall (new CCodeIdentifier (cl.get_upper_case_cname (null) + "_CLASS"));

				CCodeExpression klass;
				if (expr.inner == null) {
					if (in_static_or_class_context) {
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
					ccall.add_argument (klass);
					expr.ccodenode = new CCodeMemberAccess.pointer (ccall, f.get_cname ());
				} else {
					expr.ccodenode = new CCodeMemberAccess.pointer (cast, f.get_cname ());
				}

			} else {
				generate_field_declaration (f, source_declarations);

				expr.ccodenode = new CCodeIdentifier (f.get_cname ());
			}
		} else if (expr.symbol_reference is Constant) {
			var c = (Constant) expr.symbol_reference;

			generate_constant_declaration (c, source_declarations);

			string fn = c.get_full_name ();
			if (fn == "GLib.Log.FILE") {
				string s = Path.get_basename (expr.source_reference.file.filename);
				expr.ccodenode = new CCodeConstant ("\"%s\"".printf (s));
			} else if (fn == "GLib.Log.LINE") {
				int i = expr.source_reference.first_line;
				expr.ccodenode = new CCodeConstant ("%d".printf (i));
			} else if (fn == "GLib.Log.METHOD") {
				string s = "";
				if (current_method != null) {
					s = current_method.get_full_name ();
				}
				expr.ccodenode = new CCodeConstant ("\"%s\"".printf (s));
			} else {
				expr.ccodenode = new CCodeIdentifier (c.get_cname ());
			}
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

			if (prop.binding == MemberBinding.INSTANCE &&
			    prop.get_accessor.automatic_body &&
			    current_type_symbol == prop.parent_symbol &&
			    current_type_symbol is Class &&
			    prop.base_property == null &&
			    prop.base_interface_property == null &&
			    !(prop.property_type is ArrayType || prop.property_type is DelegateType)) {
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
					if (prop.parent_symbol is Struct) {
						// we need to pass struct instance by reference
						var unary = pub_inst as CCodeUnaryExpression;
						if (unary != null && unary.operator == CCodeUnaryOperator.POINTER_INDIRECTION) {
							// *expr => expr
							pub_inst = unary.inner;
						} else if (pub_inst is CCodeIdentifier || pub_inst is CCodeMemberAccess) {
							pub_inst = new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, pub_inst);
						} else {
							// if instance is e.g. a function call, we can't take the address of the expression
							// (tmp = expr, &tmp)
							var ccomma = new CCodeCommaExpression ();

							var temp_var = get_temp_variable (expr.inner.target_type, true, null, false);
							temp_vars.insert (0, temp_var);
							ccomma.append_expression (new CCodeAssignment (get_variable_cexpression (temp_var.name), pub_inst));
							ccomma.append_expression (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, get_variable_cexpression (temp_var.name)));

							pub_inst = ccomma;
						}
					}

					ccall.add_argument (pub_inst);
				}

				// Property access to real struct types is handled differently
				// The value is returned by out parameter
				if (base_property.property_type.is_real_non_null_struct_type ()) {
					var ccomma = new CCodeCommaExpression ();
					var temp_var = get_temp_variable (base_property.get_accessor.value_type);
					var ctemp = get_variable_cexpression (temp_var.name);
					temp_vars.add (temp_var);
					ccall.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, ctemp));
					ccomma.append_expression (ccall);
					ccomma.append_expression (ctemp);
					expr.ccodenode = ccomma;
				} else {
					var array_type = base_property.property_type as ArrayType;
					if (array_type != null && !base_property.no_array_length) {
						for (int dim = 1; dim <= array_type.rank; dim++) {
							var temp_var = get_temp_variable (int_type);
							var ctemp = get_variable_cexpression (temp_var.name);
							temp_vars.add (temp_var);
							ccall.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, ctemp));
							expr.append_array_size (ctemp);
						}
					} else {
						var delegate_type = base_property.property_type as DelegateType;
						if (delegate_type != null && delegate_type.delegate_symbol.has_target) {
							var temp_var = get_temp_variable (new PointerType (new VoidType ()));
							var ctemp = get_variable_cexpression (temp_var.name);
							temp_vars.add (temp_var);
							ccall.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, ctemp));
							expr.delegate_target = ctemp;
						}
					}

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
				if (!prop.get_accessor.value_type.value_owned) {
					// only report error for types where there actually
					// is a difference between `owned' and `unowned'
					var owned_value_type = prop.get_accessor.value_type.copy ();
					owned_value_type.value_owned = true;
					if (requires_copy (owned_value_type)) {
						Report.error (prop.get_accessor.source_reference, "unowned return value for getter of property `%s' not supported without accessor".printf (prop.get_full_name ()));
					}
				}

				var ccomma = new CCodeCommaExpression ();
				var temp_var = get_temp_variable (expr.value_type);
				var ctemp = get_variable_cexpression (temp_var.name);
				temp_vars.add (temp_var);
				ccall.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, ctemp));
				ccall.add_argument (new CCodeConstant ("NULL"));
				ccomma.append_expression (ccall);
				ccomma.append_expression (ctemp);
				expr.ccodenode = ccomma;
			}
		} else if (expr.symbol_reference is EnumValue) {
			var ev = (EnumValue) expr.symbol_reference;

			generate_enum_declaration ((Enum) ev.parent_symbol, source_declarations);

			expr.ccodenode = new CCodeConstant (ev.get_cname ());
		} else if (expr.symbol_reference is LocalVariable) {
			var local = (LocalVariable) expr.symbol_reference;
			if (local.is_result) {
				// used in postconditions
				// structs are returned as out parameter
				if (local.variable_type != null && local.variable_type.is_real_non_null_struct_type ()) {
					expr.ccodenode = new CCodeUnaryExpression (CCodeUnaryOperator.POINTER_INDIRECTION, new CCodeIdentifier ("result"));
				} else {
					expr.ccodenode = new CCodeIdentifier ("result");
				}
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
					expr.ccodenode = new CCodeMemberAccess.pointer (new CCodeIdentifier ("data"), "self");
				} else {
					var st = current_type_symbol as Struct;
					if (st != null && !st.is_simple_type ()) {
						expr.ccodenode = new CCodeIdentifier ("(*self)");
					} else {
						expr.ccodenode = new CCodeIdentifier ("self");
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
				} else if (current_method != null && current_method.coroutine) {
					// use closure
					expr.ccodenode = get_variable_cexpression (p.name);
				} else {
					var type_as_struct = p.parameter_type.data_type as Struct;
					if (p.direction != ParameterDirection.IN
					    || (type_as_struct != null && !type_as_struct.is_simple_type () && !p.parameter_type.nullable)) {
						expr.ccodenode = new CCodeUnaryExpression (CCodeUnaryOperator.POINTER_INDIRECTION, new CCodeIdentifier (get_variable_cname (p.name)));
					} else {
						// Property setters of non simple structs shall replace all occurences
						// of the "value" formal parameter with a dereferencing version of that
						// parameter.
						if (current_property_accessor != null &&
						    current_property_accessor.writable &&
						    current_property_accessor.value_parameter == p &&
						    current_property_accessor.prop.property_type.is_real_struct_type () &&
						    !current_property_accessor.prop.property_type.nullable) {
							expr.ccodenode = new CCodeUnaryExpression (CCodeUnaryOperator.POINTER_INDIRECTION, new CCodeIdentifier ("value"));
						} else {
							expr.ccodenode = get_variable_cexpression (p.name);
						}
					}
				}
			}
		}
	}
}

