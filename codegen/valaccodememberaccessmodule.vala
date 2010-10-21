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

public class Vala.CCodeMemberAccessModule : CCodeControlFlowModule {
	public override void visit_member_access (MemberAccess expr) {
		CCodeExpression pub_inst = null;
	
		if (expr.inner != null) {
			pub_inst = get_cvalue (expr.inner);
		}

		var array_type = expr.value_type as ArrayType;

		if (expr.symbol_reference is Method) {
			var m = (Method) expr.symbol_reference;

			if (!(m is DynamicMethod || m is ArrayMoveMethod || m is ArrayResizeMethod)) {
				generate_method_declaration (m, cfile);

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
					
					set_cvalue (expr, new CCodeMemberAccess.pointer (vcast, m.vfunc_name));
					return;
				} else if (m.base_interface_method != null) {
					var base_iface = (Interface) m.base_interface_method.parent_symbol;
					string parent_iface_var = "%s_%s_parent_iface".printf (current_class.get_lower_case_cname (null), base_iface.get_lower_case_cname (null));

					set_cvalue (expr, new CCodeMemberAccess.pointer (new CCodeIdentifier (parent_iface_var), m.vfunc_name));
					return;
				}
			}

			if (m.base_method != null) {
				if (!method_has_wrapper (m.base_method)) {
					var inst = pub_inst;
					if (expr.inner != null && !expr.inner.is_pure ()) {
						// instance expression has side-effects
						// store in temp. variable
						var temp_var = get_temp_variable (expr.inner.value_type, true, null, false);
						emit_temp_var (temp_var);
						var ctemp = get_variable_cexpression (temp_var.name);
						inst = new CCodeAssignment (ctemp, pub_inst);
						set_cvalue (expr.inner, ctemp);
					}
					var base_class = (Class) m.base_method.parent_symbol;
					var vclass = new CCodeFunctionCall (new CCodeIdentifier ("%s_GET_CLASS".printf (base_class.get_upper_case_cname (null))));
					vclass.add_argument (inst);
					set_cvalue (expr, new CCodeMemberAccess.pointer (vclass, m.name));
				} else {
					set_cvalue (expr, new CCodeIdentifier (m.base_method.get_cname ()));
				}
			} else if (m.base_interface_method != null) {
				set_cvalue (expr, new CCodeIdentifier (m.base_interface_method.get_cname ()));
			} else if (m is CreationMethod) {
				set_cvalue (expr, new CCodeIdentifier (m.get_real_cname ()));
			} else {
				set_cvalue (expr, new CCodeIdentifier (m.get_cname ()));
			}

			set_delegate_target_destroy_notify (expr, new CCodeConstant ("NULL"));
			if (m.binding == MemberBinding.STATIC) {
				set_delegate_target (expr, new CCodeConstant ("NULL"));
			} else if (m.is_async_callback) {
				if (current_method.closure) {
					var block = ((Method) m.parent_symbol).body;
					set_delegate_target (expr, new CCodeMemberAccess.pointer (get_variable_cexpression ("_data%d_".printf (get_block_id (block))), "_async_data_"));
				} else {
					set_delegate_target (expr, new CCodeIdentifier ("data"));
				}
			} else if (expr.inner != null) {
				// expr.inner is null in the special case of referencing the method in a constant initializer
				var delegate_target = (CCodeExpression) get_ccodenode (expr.inner);
				var delegate_type = expr.target_type as DelegateType;
				if ((expr.value_type.value_owned || (delegate_type != null && delegate_type.is_called_once)) && expr.inner.value_type.data_type != null && expr.inner.value_type.data_type.is_reference_counting ()) {
					var ref_call = new CCodeFunctionCall (get_dup_func_expression (expr.inner.value_type, expr.source_reference));
					ref_call.add_argument (delegate_target);
					delegate_target = ref_call;
					set_delegate_target_destroy_notify (expr, get_destroy_func_expression (expr.inner.value_type));
				}
				set_delegate_target (expr, delegate_target);
			}
		} else if (expr.symbol_reference is ArrayLengthField) {
			if (expr.value_type is ArrayType && !(expr.parent_node is ElementAccess)) {
				Report.error (expr.source_reference, "unsupported use of length field of multi-dimensional array");
			}
			set_cvalue (expr, get_array_length_cexpression (expr.inner, 1));
		} else if (expr.symbol_reference is Field) {
			var field = (Field) expr.symbol_reference;
			if (field.binding == MemberBinding.INSTANCE) {
				var instance_target_type = get_data_type_for_symbol ((TypeSymbol) field.parent_symbol);

				var cl = instance_target_type.data_type as Class;
				bool is_gtypeinstance = ((instance_target_type.data_type == cl) && (cl == null || !cl.is_compact));

				CCodeExpression inst;
				if (is_gtypeinstance && field.access == SymbolAccessibility.PRIVATE) {
					inst = new CCodeMemberAccess.pointer (pub_inst, "priv");
				} else {
					if (cl != null) {
						generate_class_struct_declaration (cl, cfile);
					}
					inst = pub_inst;
				}
				if (instance_target_type.data_type.is_reference_type () || (expr.inner != null && expr.inner.value_type is PointerType)) {
					set_cvalue (expr, new CCodeMemberAccess.pointer (inst, field.get_cname ()));
				} else {
					if (inst is CCodeCommaExpression) {
						var ccomma = inst as CCodeCommaExpression;
						var inner = ccomma.get_inner ();
						var last = inner.get (inner.size - 1);
						ccomma.set_expression (inner.size - 1, new CCodeMemberAccess (last, field.get_cname ()));
						set_cvalue (expr, ccomma);
					} else {
						set_cvalue (expr, new CCodeMemberAccess (inst, field.get_cname ()));
					}
				}

				if (array_type != null) {
					if (field.array_null_terminated) {
						CCodeExpression carray_expr = null;
						if (instance_target_type.data_type.is_reference_type () || (expr.inner != null && expr.inner.value_type is PointerType)) {
							carray_expr = new CCodeMemberAccess.pointer (inst, field.get_cname ());
						} else {
							carray_expr = new CCodeMemberAccess (inst, field.get_cname ());
						}

						requires_array_length = true;
						var len_call = new CCodeFunctionCall (new CCodeIdentifier ("_vala_array_length"));
						len_call.add_argument (carray_expr);
						append_array_size (expr, len_call);
					} else if (!field.no_array_length) {
						for (int dim = 1; dim <= array_type.rank; dim++) {
							CCodeExpression length_expr = null;

							if (field.has_array_length_cexpr) {
								length_expr = new CCodeConstant (field.get_array_length_cexpr ());
							} else {
								string length_cname;
								if (field.has_array_length_cname) {
									length_cname = field.get_array_length_cname ();
								} else {
									length_cname = get_array_length_cname (field.name, dim);
								}

								if (((TypeSymbol) field.parent_symbol).is_reference_type ()) {
									length_expr = new CCodeMemberAccess.pointer (inst, length_cname);
								} else {
									length_expr = new CCodeMemberAccess (inst, length_cname);
								}

								if (field.array_length_type != null) {
									// cast if field does not use int for array length
									var parent_expr = expr.parent_node as Expression;
									if (expr.lvalue) {
										// don't cast if array is used as lvalue
									} else if (parent_expr != null && parent_expr.symbol_reference is ArrayLengthField &&
										   parent_expr.lvalue) {
										// don't cast if array length is used as lvalue
									} else {
										length_expr = new CCodeCastExpression (length_expr, "gint");
									}
								}
							}
							append_array_size (expr, length_expr);
						}
					}
				} else if (field.variable_type is DelegateType) {
					string target_cname = get_delegate_target_cname (field.get_cname ());
					string target_destroy_notify_cname = get_delegate_target_destroy_notify_cname (field.get_cname ());

					set_delegate_target_destroy_notify (expr, new CCodeConstant ("NULL"));
					if (field.no_delegate_target) {
						set_delegate_target (expr, new CCodeConstant ("NULL"));
					} else {
						if (((TypeSymbol) field.parent_symbol).is_reference_type ()) {
							set_delegate_target (expr, new CCodeMemberAccess.pointer (inst, target_cname));
							if (expr.value_type.value_owned) {
								set_delegate_target_destroy_notify (expr, new CCodeMemberAccess.pointer (inst, target_destroy_notify_cname));
							}
						} else {
							set_delegate_target (expr, new CCodeMemberAccess (inst, target_cname));
							if (expr.value_type.value_owned) {
								set_delegate_target_destroy_notify (expr, new CCodeMemberAccess (inst, target_destroy_notify_cname));
							}
						}
					}
				}
			} else if (field.binding == MemberBinding.CLASS) {
				var cl = (Class) field.parent_symbol;
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
					k.add_argument (get_cvalue (expr.inner));
					klass = k;
				}
				cast.add_argument (klass);

				if (field.access == SymbolAccessibility.PRIVATE) {
					var ccall = new CCodeFunctionCall (new CCodeIdentifier ("%s_GET_CLASS_PRIVATE".printf (cl.get_upper_case_cname ())));
					ccall.add_argument (klass);
					set_cvalue (expr, new CCodeMemberAccess.pointer (ccall, field.get_cname ()));
				} else {
					set_cvalue (expr, new CCodeMemberAccess.pointer (cast, field.get_cname ()));
				}

			} else {
				generate_field_declaration (field, cfile);

				set_cvalue (expr, new CCodeIdentifier (field.get_cname ()));

				if (array_type != null) {
					if (field.array_null_terminated) {
						requires_array_length = true;
						var len_call = new CCodeFunctionCall (new CCodeIdentifier ("_vala_array_length"));
						len_call.add_argument (new CCodeIdentifier (field.get_cname ()));
						append_array_size (expr, len_call);
					} else if (!field.no_array_length) {
						for (int dim = 1; dim <= array_type.rank; dim++) {
							if (field.has_array_length_cexpr) {
								append_array_size (expr, new CCodeConstant (field.get_array_length_cexpr ()));
							} else {
								append_array_size (expr, new CCodeIdentifier (get_array_length_cname (field.get_cname (), dim)));
							}
						}
					}
				} else if (field.variable_type is DelegateType) {
					set_delegate_target_destroy_notify (expr, new CCodeConstant ("NULL"));
					if (field.no_delegate_target) {
						set_delegate_target (expr, new CCodeConstant ("NULL"));
					} else {
						set_delegate_target (expr, new CCodeIdentifier (get_delegate_target_cname (field.get_cname ())));
						if (expr.value_type.value_owned) {
							set_delegate_target_destroy_notify (expr, new CCodeIdentifier (get_delegate_target_destroy_notify_cname (field.get_cname ())));
						}
					}
				}
			}
		} else if (expr.symbol_reference is EnumValue) {
			var ev = (EnumValue) expr.symbol_reference;

			generate_enum_declaration ((Enum) ev.parent_symbol, cfile);

			set_cvalue (expr, new CCodeConstant (ev.get_cname ()));
		} else if (expr.symbol_reference is Constant) {
			var c = (Constant) expr.symbol_reference;

			generate_constant_declaration (c, cfile,
				c.source_reference != null && expr.source_reference != null &&
				c.source_reference.file == expr.source_reference.file);

			string fn = c.get_full_name ();
			if (fn == "GLib.Log.FILE") {
				string s = Path.get_basename (expr.source_reference.file.filename);
				set_cvalue (expr, new CCodeConstant ("\"%s\"".printf (s)));
			} else if (fn == "GLib.Log.LINE") {
				int i = expr.source_reference.first_line;
				set_cvalue (expr, new CCodeConstant ("%d".printf (i)));
			} else if (fn == "GLib.Log.METHOD") {
				string s = "";
				if (current_method != null) {
					s = current_method.get_full_name ();
				}
				set_cvalue (expr, new CCodeConstant ("\"%s\"".printf (s)));
			} else {
				set_cvalue (expr, new CCodeIdentifier (c.get_cname ()));
			}

			if (array_type != null) {
				var ccall = new CCodeFunctionCall (new CCodeIdentifier ("G_N_ELEMENTS"));
				ccall.add_argument (new CCodeIdentifier (c.get_cname ()));
				append_array_size (expr, ccall);
			}
		} else if (expr.symbol_reference is Property) {
			var prop = (Property) expr.symbol_reference;

			if (!(prop is DynamicProperty)) {
				generate_property_accessor_declaration (prop.get_accessor, cfile);

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
					ccall.add_argument (get_cvalue (expr.inner));
					set_cvalue (expr, ccall);
					return;
				} else if (prop.base_interface_property != null) {
					var base_iface = (Interface) prop.base_interface_property.parent_symbol;
					string parent_iface_var = "%s_%s_parent_iface".printf (current_class.get_lower_case_cname (null), base_iface.get_lower_case_cname (null));

					var ccall = new CCodeFunctionCall (new CCodeMemberAccess.pointer (new CCodeIdentifier (parent_iface_var), "get_%s".printf (prop.name)));
					ccall.add_argument (get_cvalue (expr.inner));
					set_cvalue (expr, ccall);
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
				set_cvalue (expr, new CCodeMemberAccess.pointer (inst, prop.field.get_cname()));
			} else if (!prop.no_accessor_method) {
				var base_property = prop;
				if (prop.base_property != null) {
					base_property = prop.base_property;
				} else if (prop.base_interface_property != null) {
					base_property = prop.base_interface_property;
				}
				string getter_cname;
				if (prop is DynamicProperty) {
					getter_cname = get_dynamic_property_getter_cname ((DynamicProperty) prop);
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
							emit_temp_var (temp_var);
							ccomma.append_expression (new CCodeAssignment (get_variable_cexpression (temp_var.name), pub_inst));
							ccomma.append_expression (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, get_variable_cexpression (temp_var.name)));

							pub_inst = ccomma;
						}
					}

					ccall.add_argument (pub_inst);
				}

				var temp_var = get_temp_variable (base_property.get_accessor.value_type, base_property.get_accessor.value_type.value_owned);
				emit_temp_var (temp_var);
				var ctemp = get_variable_cexpression (temp_var.name);
				set_cvalue (expr, ctemp);

				// Property access to real struct types is handled differently
				// The value is returned by out parameter
				if (base_property.property_type.is_real_non_null_struct_type ()) {
					ccall.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, ctemp));
					ccode.add_expression (ccall);
				} else {
					ccode.add_expression (new CCodeAssignment (ctemp, ccall));

					array_type = base_property.property_type as ArrayType;
					if (array_type != null && !base_property.no_array_length) {
						for (int dim = 1; dim <= array_type.rank; dim++) {
							temp_var = get_temp_variable (int_type);
							ctemp = get_variable_cexpression (temp_var.name);
							emit_temp_var (temp_var);
							ccall.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, ctemp));
							append_array_size (expr, ctemp);
						}
					} else {
						var delegate_type = base_property.property_type as DelegateType;
						if (delegate_type != null && delegate_type.delegate_symbol.has_target) {
							temp_var = get_temp_variable (new PointerType (new VoidType ()));
							ctemp = get_variable_cexpression (temp_var.name);
							emit_temp_var (temp_var);
							ccall.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, ctemp));
							set_delegate_target (expr, ctemp);
						}
					}
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
				emit_temp_var (temp_var);
				ccall.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, ctemp));
				ccall.add_argument (new CCodeConstant ("NULL"));
				ccomma.append_expression (ccall);
				ccomma.append_expression (ctemp);
				set_cvalue (expr, ccomma);
			}
		} else if (expr.symbol_reference is LocalVariable) {
			var local = (LocalVariable) expr.symbol_reference;
			if (local.is_result) {
				// used in postconditions
				// structs are returned as out parameter
				if (local.variable_type != null && local.variable_type.is_real_non_null_struct_type ()) {
					set_cvalue (expr, new CCodeUnaryExpression (CCodeUnaryOperator.POINTER_INDIRECTION, new CCodeIdentifier ("result")));
				} else {
					set_cvalue (expr, new CCodeIdentifier ("result"));
				}
			} else if (local.captured) {
				// captured variables are stored on the heap
				var block = (Block) local.parent_symbol;
				set_cvalue (expr, new CCodeMemberAccess.pointer (get_variable_cexpression ("_data%d_".printf (get_block_id (block))), get_variable_cname (local.name)));
				if (array_type != null) {
					for (int dim = 1; dim <= array_type.rank; dim++) {
						append_array_size (expr, new CCodeMemberAccess.pointer (get_variable_cexpression ("_data%d_".printf (get_block_id (block))), get_array_length_cname (get_variable_cname (local.name), dim)));
					}
				} else if (local.variable_type is DelegateType) {
					set_delegate_target (expr, new CCodeMemberAccess.pointer (get_variable_cexpression ("_data%d_".printf (get_block_id (block))), get_delegate_target_cname (get_variable_cname (local.name))));
					set_delegate_target_destroy_notify (expr, new CCodeMemberAccess.pointer (get_variable_cexpression ("_data%d_".printf (get_block_id (block))), get_delegate_target_destroy_notify_cname (get_variable_cname (local.name))));
				}
			} else {
				set_cvalue (expr, get_variable_cexpression (local.name));
				if (array_type != null) {
					for (int dim = 1; dim <= array_type.rank; dim++) {
						append_array_size (expr, get_variable_cexpression (get_array_length_cname (get_variable_cname (local.name), dim)));
					}
				} else if (local.variable_type is DelegateType) {
					if (current_method != null && current_method.coroutine) {
						set_delegate_target (expr, new CCodeMemberAccess.pointer (new CCodeIdentifier ("data"), get_delegate_target_cname (get_variable_cname (local.name))));
						set_delegate_target_destroy_notify (expr, new CCodeMemberAccess.pointer (new CCodeIdentifier ("data"), get_delegate_target_destroy_notify_cname (get_variable_cname (local.name))));
					} else {
						set_delegate_target (expr, new CCodeIdentifier (get_delegate_target_cname (get_variable_cname (local.name))));
						if (expr.value_type.value_owned) {
							set_delegate_target_destroy_notify (expr, new CCodeIdentifier (get_delegate_target_destroy_notify_cname (get_variable_cname (local.name))));
						} else {
							set_delegate_target_destroy_notify (expr, new CCodeConstant ("NULL"));
						}
					}
				}

				if (expr.parent_node is ReturnStatement &&
				    current_return_type.value_owned &&
				    local.variable_type.value_owned &&
				    !variable_accessible_in_finally (local)) {
					/* return expression is local variable taking ownership and
					 * current method is transferring ownership */

					// don't ref expression
					expr.value_type.value_owned = true;

					// don't unref variable
					local.active = false;
				}
			}
		} else if (expr.symbol_reference is FormalParameter) {
			var p = (FormalParameter) expr.symbol_reference;
			if (p.name == "this") {
				if (current_method != null && current_method.coroutine) {
					// use closure
					set_cvalue (expr, new CCodeMemberAccess.pointer (new CCodeIdentifier ("data"), "self"));
				} else {
					var st = current_type_symbol as Struct;
					if (st != null && !st.is_simple_type ()) {
						set_cvalue (expr, new CCodeIdentifier ("(*self)"));
					} else {
						set_cvalue (expr, new CCodeIdentifier ("self"));
					}
				}
			} else {
				string name = p.name;

				if (p.captured) {
					// captured variables are stored on the heap
					var block = p.parent_symbol as Block;
					if (block == null) {
						block = ((Method) p.parent_symbol).body;
					}
					set_cvalue (expr, new CCodeMemberAccess.pointer (get_variable_cexpression ("_data%d_".printf (get_block_id (block))), get_variable_cname (p.name)));
					if (array_type != null) {
						for (int dim = 1; dim <= array_type.rank; dim++) {
							append_array_size (expr, new CCodeMemberAccess.pointer (get_variable_cexpression ("_data%d_".printf (get_block_id (block))), get_parameter_array_length_cname (p, dim)));
						}
					} else if (p.variable_type is DelegateType) {
						set_delegate_target (expr, new CCodeMemberAccess.pointer (get_variable_cexpression ("_data%d_".printf (get_block_id (block))), get_delegate_target_cname (get_variable_cname (p.name))));
						set_delegate_target_destroy_notify (expr, new CCodeMemberAccess.pointer (get_variable_cexpression ("_data%d_".printf (get_block_id (block))), get_delegate_target_destroy_notify_cname (get_variable_cname (p.name))));
					}
				} else if (current_method != null && current_method.coroutine) {
					// use closure
					set_cvalue (expr, get_variable_cexpression (p.name));
					if (p.variable_type is DelegateType) {
						set_delegate_target (expr, new CCodeMemberAccess.pointer (new CCodeIdentifier ("data"), get_delegate_target_cname (get_variable_cname (p.name))));
						set_delegate_target_destroy_notify (expr, new CCodeMemberAccess.pointer (new CCodeIdentifier ("data"), get_delegate_target_destroy_notify_cname (get_variable_cname (p.name))));
					}
				} else {
					var type_as_struct = p.variable_type.data_type as Struct;

					if (p.direction == ParameterDirection.OUT) {
						name = "_" + name;
					}

					if (p.direction == ParameterDirection.REF
					    || (p.direction == ParameterDirection.IN && type_as_struct != null && !type_as_struct.is_simple_type () && !p.variable_type.nullable)) {
						set_cvalue (expr, new CCodeUnaryExpression (CCodeUnaryOperator.POINTER_INDIRECTION, new CCodeIdentifier (get_variable_cname (name))));
					} else {
						// Property setters of non simple structs shall replace all occurences
						// of the "value" formal parameter with a dereferencing version of that
						// parameter.
						if (current_property_accessor != null &&
						    current_property_accessor.writable &&
						    current_property_accessor.value_parameter == p &&
						    current_property_accessor.prop.property_type.is_real_struct_type () &&
						    !current_property_accessor.prop.property_type.nullable) {
							set_cvalue (expr, new CCodeUnaryExpression (CCodeUnaryOperator.POINTER_INDIRECTION, new CCodeIdentifier ("value")));
						} else {
							set_cvalue (expr, get_variable_cexpression (name));
						}
					}
					if (p.variable_type is DelegateType) {
						CCodeExpression target_expr = new CCodeIdentifier (get_delegate_target_cname (get_variable_cname (name)));
						CCodeExpression delegate_target_destroy_notify = new CCodeIdentifier (get_delegate_target_destroy_notify_cname (get_variable_cname (name)));
						if (p.direction == ParameterDirection.REF) {
							// accessing argument of ref param
							target_expr = new CCodeUnaryExpression (CCodeUnaryOperator.POINTER_INDIRECTION, target_expr);
							delegate_target_destroy_notify = new CCodeUnaryExpression (CCodeUnaryOperator.POINTER_INDIRECTION, delegate_target_destroy_notify);
						}
						set_delegate_target (expr, target_expr);
						if (expr.value_type.value_owned) {
							set_delegate_target_destroy_notify (expr, delegate_target_destroy_notify);
						} else {
							set_delegate_target_destroy_notify (expr, new CCodeConstant ("NULL"));
						}
					}
				}
				if (!p.captured && array_type != null) {
					if (p.array_null_terminated) {
						var carray_expr = get_variable_cexpression (name);
						requires_array_length = true;
						var len_call = new CCodeFunctionCall (new CCodeIdentifier ("_vala_array_length"));
						len_call.add_argument (carray_expr);
						append_array_size (expr, len_call);
					} else if (!p.no_array_length) {
						for (int dim = 1; dim <= array_type.rank; dim++) {
							CCodeExpression length_expr = get_variable_cexpression (get_parameter_array_length_cname (p, dim));
							if (p.direction == ParameterDirection.OUT) {
								length_expr = get_variable_cexpression (get_array_length_cname (get_variable_cname (name), dim));
							} else if (p.direction == ParameterDirection.REF) {
								// accessing argument of ref param
								length_expr = new CCodeUnaryExpression (CCodeUnaryOperator.POINTER_INDIRECTION, length_expr);
							}
							append_array_size (expr, length_expr);
						}
					}
				}
			}
		}
	}
}

