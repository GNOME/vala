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

public abstract class Vala.CCodeMemberAccessModule : CCodeControlFlowModule {
	public override void visit_member_access (MemberAccess expr) {
		CCodeExpression pub_inst = null;
	
		if (expr.inner != null) {
			pub_inst = get_cvalue (expr.inner);
		}

		var array_type = expr.value_type as ArrayType;
		var delegate_type = expr.value_type as DelegateType;

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
					var vcast = new CCodeFunctionCall (new CCodeIdentifier ("%s_CLASS".printf (get_ccode_upper_case_name (base_class, null))));
					vcast.add_argument (new CCodeIdentifier ("%s_parent_class".printf (get_ccode_lower_case_name (current_class, null))));
					
					set_cvalue (expr, new CCodeMemberAccess.pointer (vcast, get_ccode_vfunc_name (m)));
					return;
				} else if (m.base_interface_method != null) {
					var base_iface = (Interface) m.base_interface_method.parent_symbol;
					string parent_iface_var = "%s_%s_parent_iface".printf (get_ccode_lower_case_name (current_class), get_ccode_lower_case_name (base_iface));

					set_cvalue (expr, new CCodeMemberAccess.pointer (new CCodeIdentifier (parent_iface_var), get_ccode_vfunc_name (m)));
					return;
				}
			}

			if (m.base_method != null) {
				if (!method_has_wrapper (m.base_method)) {
					var base_class = (Class) m.base_method.parent_symbol;
					var vclass = new CCodeFunctionCall (new CCodeIdentifier ("%s_GET_CLASS".printf (get_ccode_upper_case_name (base_class))));
					vclass.add_argument (pub_inst);
					set_cvalue (expr, new CCodeMemberAccess.pointer (vclass, get_ccode_vfunc_name (m)));
				} else {
					set_cvalue (expr, new CCodeIdentifier (get_ccode_name (m.base_method)));
				}
			} else if (m.base_interface_method != null) {
				set_cvalue (expr, new CCodeIdentifier (get_ccode_name (m.base_interface_method)));
			} else if (m is CreationMethod) {
				set_cvalue (expr, new CCodeIdentifier (get_ccode_real_name (m)));
			} else {
				set_cvalue (expr, new CCodeIdentifier (get_ccode_name (m)));
			}

			set_delegate_target_destroy_notify (expr, new CCodeConstant ("NULL"));
			if (m.binding == MemberBinding.STATIC) {
				set_delegate_target (expr, new CCodeConstant ("NULL"));
			} else if (m.is_async_callback) {
				if (current_method.closure) {
					var block = ((Method) m.parent_symbol).body;
					set_delegate_target (expr, new CCodeMemberAccess.pointer (get_variable_cexpression ("_data%d_".printf (get_block_id (block))), "_async_data_"));
				} else {
					set_delegate_target (expr, new CCodeIdentifier ("_data_"));
				}
			} else if (expr.inner != null && !expr.prototype_access) {
				// expr.inner is null in the special case of referencing the method in a constant initializer
				var delegate_target = (CCodeExpression) get_ccodenode (expr.inner);
				delegate_type = expr.target_type as DelegateType;
				if ((expr.value_type.value_owned || (delegate_type != null && delegate_type.is_called_once)) && expr.inner.value_type.data_type != null && is_reference_counting (expr.inner.value_type.data_type)) {
					var ref_call = new CCodeFunctionCall (get_dup_func_expression (expr.inner.value_type, expr.source_reference));
					ref_call.add_argument (delegate_target);
					delegate_target = ref_call;
					if (delegate_type != null && delegate_type.is_disposable ()) {
						set_delegate_target_destroy_notify (expr, get_destroy_func_expression (expr.inner.value_type));
					}
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
			if (expr.lvalue) {
				expr.target_value = get_field_cvalue (field, expr.inner != null ? expr.inner.target_value : null);
			} else {
				expr.target_value = load_field (field, expr.inner != null ? expr.inner.target_value : null);
			}
		} else if (expr.symbol_reference is EnumValue) {
			var ev = (EnumValue) expr.symbol_reference;

			generate_enum_declaration ((Enum) ev.parent_symbol, cfile);

			set_cvalue (expr, new CCodeConstant (get_ccode_name (ev)));
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
				int i = expr.source_reference.begin.line;
				set_cvalue (expr, new CCodeConstant ("%d".printf (i)));
			} else if (fn == "GLib.Log.METHOD") {
				string s = "";
				if (current_method != null) {
					s = current_method.get_full_name ();
				}
				set_cvalue (expr, new CCodeConstant ("\"%s\"".printf (s)));
			} else {
				set_cvalue (expr, new CCodeIdentifier (get_ccode_name (c)));
			}

			if (array_type != null) {
				var ccall = new CCodeFunctionCall (new CCodeIdentifier ("G_N_ELEMENTS"));
				ccall.add_argument (new CCodeIdentifier (get_ccode_name (c)));
				append_array_length (expr, ccall);
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
				var base_prop = prop;
				if (prop.base_property != null) {
					base_prop = prop.base_property;
				} else if (prop.base_interface_property != null) {
					base_prop = prop.base_interface_property;
				}
				if (base_prop.parent_symbol is Class) {
					var base_class = (Class) base_prop.parent_symbol;
					var vcast = new CCodeFunctionCall (new CCodeIdentifier ("%s_CLASS".printf (get_ccode_upper_case_name (base_class, null))));
					vcast.add_argument (new CCodeIdentifier ("%s_parent_class".printf (get_ccode_lower_case_name (current_class, null))));
					
					var ccall = new CCodeFunctionCall (new CCodeMemberAccess.pointer (vcast, "get_%s".printf (prop.name)));
					ccall.add_argument (get_cvalue (expr.inner));
					set_cvalue (expr, ccall);
				} else if (base_prop.parent_symbol is Interface) {
					var base_iface = (Interface) base_prop.parent_symbol;
					string parent_iface_var = "%s_%s_parent_iface".printf (get_ccode_lower_case_name (current_class), get_ccode_lower_case_name (base_iface));

					var ccall = new CCodeFunctionCall (new CCodeMemberAccess.pointer (new CCodeIdentifier (parent_iface_var), "get_%s".printf (prop.name)));
					ccall.add_argument (get_cvalue (expr.inner));
					set_cvalue (expr, ccall);
				}
			} else if (prop.binding == MemberBinding.INSTANCE &&
			    prop.get_accessor.automatic_body &&
			    !prop.get_accessor.value_type.value_owned &&
			    current_type_symbol == prop.parent_symbol &&
			    current_type_symbol is Class &&
			    prop.base_property == null &&
			    prop.base_interface_property == null &&
			    !(prop.property_type is ArrayType || prop.property_type is DelegateType)) {
				CCodeExpression inst;
				inst = new CCodeMemberAccess.pointer (pub_inst, "priv");
				set_cvalue (expr, new CCodeMemberAccess.pointer (inst, get_ccode_name (prop.field)));
			} else if (!get_ccode_no_accessor_method (prop)) {
				string getter_cname;
				if (prop is DynamicProperty) {
					getter_cname = get_dynamic_property_getter_cname ((DynamicProperty) prop);
				} else {
					getter_cname = get_ccode_name (prop.get_accessor);
				}
				var ccall = new CCodeFunctionCall (new CCodeIdentifier (getter_cname));

				if (prop.binding == MemberBinding.INSTANCE) {
					if (prop.parent_symbol is Struct && !((Struct) prop.parent_symbol).is_simple_type ()) {
						// we need to pass struct instance by reference
						var instance = expr.inner.target_value;
						if (!get_lvalue (instance)) {
							instance = store_temp_value (instance, expr);
						}
						pub_inst = new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, get_cvalue_ (instance));
					}

					ccall.add_argument (pub_inst);
				}

				var temp_value = (GLibValue) create_temp_value (prop.get_accessor.value_type, false, expr);
				expr.target_value = load_temp_value (temp_value);
				var ctemp = get_cvalue_ (temp_value);

				// Property access to real struct types is handled differently
				// The value is returned by out parameter
				if (prop.property_type.is_real_non_null_struct_type ()) {
					ccall.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, ctemp));
					ccode.add_expression (ccall);
				} else {
					ccode.add_assignment (ctemp, ccall);

					array_type = prop.property_type as ArrayType;
					if (array_type != null) {
						if (get_ccode_array_null_terminated (prop)) {
							requires_array_length = true;
							var len_call = new CCodeFunctionCall (new CCodeIdentifier ("_vala_array_length"));
							len_call.add_argument (ctemp);

							ccode.add_assignment (temp_value.array_length_cvalues[0], len_call);
						} else if (get_ccode_array_length (prop)) {
							for (int dim = 1; dim <= array_type.rank; dim++) {
								ccall.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, get_array_length_cvalue (temp_value, dim)));
							}
						}
					} else {
						delegate_type = prop.property_type as DelegateType;
						if (delegate_type != null && delegate_type.delegate_symbol.has_target) {
							ccall.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, get_delegate_target_cvalue (temp_value)));
						}
					}
				}
			} else {
				var ccall = new CCodeFunctionCall (new CCodeIdentifier ("g_object_get"));
				ccall.add_argument (pub_inst);

				// property name is second argument of g_object_get
				ccall.add_argument (get_property_canonical_cconstant (prop));

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

				if (expr.value_type.is_real_struct_type ()) {
					// gobject allocates structs on heap
					expr.value_type.nullable = true;
				}

				var temp_var = get_temp_variable (expr.value_type);
				var ctemp = get_variable_cexpression (temp_var.name);
				emit_temp_var (temp_var);
				ccall.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, ctemp));
				ccall.add_argument (new CCodeConstant ("NULL"));
				ccode.add_expression (ccall);
				set_cvalue (expr, ctemp);
			}
			expr.target_value.value_type = expr.value_type;
			expr.target_value = store_temp_value (expr.target_value, expr);
		} else if (expr.symbol_reference is LocalVariable) {
			var local = (LocalVariable) expr.symbol_reference;

			if (expr.parent_node is ReturnStatement &&
			    current_return_type.value_owned &&
			    local.variable_type.value_owned &&
			    !local.captured &&
			    !variable_accessible_in_finally (local) &&
			    !(local.variable_type is ArrayType && ((ArrayType) local.variable_type).inline_allocated)) {
				/* return expression is local variable taking ownership and
				 * current method is transferring ownership */

				// don't ref expression
				expr.value_type.value_owned = true;

				// don't unref variable
				local.active = false;

				var glib_value = (GLibValue) get_local_cvalue (local);
				expr.target_value = glib_value;
				if (glib_value.delegate_target_cvalue == null) {
					glib_value.delegate_target_cvalue = new CCodeConstant ("NULL");
				}
				if (glib_value.delegate_target_destroy_notify_cvalue == null) {
					glib_value.delegate_target_destroy_notify_cvalue = new CCodeConstant ("NULL");
				}
			} else {
				if (expr.lvalue) {
					expr.target_value = get_local_cvalue (local);
				} else {
					expr.target_value = load_local (local);
				}
			}
		} else if (expr.symbol_reference is Parameter) {
			var param = (Parameter) expr.symbol_reference;
			if (expr.lvalue) {
				expr.target_value = get_parameter_cvalue (param);
			} else {
				expr.target_value = load_parameter (param);
			}
		}
	}

	/* Returns lvalue access to the given local variable */
	public override TargetValue get_local_cvalue (LocalVariable local) {
		var result = new GLibValue (local.variable_type.copy ());
		result.lvalue = true;

		var array_type = local.variable_type as ArrayType;
		var delegate_type = local.variable_type as DelegateType;
		if (local.is_result) {
			// used in postconditions
			// structs are returned as out parameter
			if (local.variable_type != null && local.variable_type.is_real_non_null_struct_type ()) {
				result.cvalue = new CCodeUnaryExpression (CCodeUnaryOperator.POINTER_INDIRECTION, new CCodeIdentifier ("result"));
			} else {
				result.cvalue = new CCodeIdentifier ("result");
			}
			if (array_type != null && !array_type.fixed_length && ((current_method != null && get_ccode_array_length (current_method)) || current_property_accessor != null)) {
				for (int dim = 1; dim <= array_type.rank; dim++) {
					result.append_array_length_cvalue (new CCodeUnaryExpression (CCodeUnaryOperator.POINTER_INDIRECTION, get_variable_cexpression (get_array_length_cname ("result", dim))));
				}
			}
		} else if (local.captured) {
			// captured variables are stored on the heap
			var block = (Block) local.parent_symbol;
			result.cvalue = new CCodeMemberAccess.pointer (get_variable_cexpression ("_data%d_".printf (get_block_id (block))), get_local_cname (local));
			if (array_type != null && !array_type.fixed_length) {
				for (int dim = 1; dim <= array_type.rank; dim++) {
					result.append_array_length_cvalue (new CCodeMemberAccess.pointer (get_variable_cexpression ("_data%d_".printf (get_block_id (block))), get_array_length_cname (get_local_cname (local), dim)));
				}
				if (array_type.rank == 1) {
					result.array_size_cvalue = new CCodeMemberAccess.pointer (get_variable_cexpression ("_data%d_".printf (get_block_id (block))), get_array_size_cname (get_local_cname (local)));
				}
			} else if (delegate_type != null && delegate_type.delegate_symbol.has_target) {
				result.delegate_target_cvalue = new CCodeMemberAccess.pointer (get_variable_cexpression ("_data%d_".printf (get_block_id (block))), get_delegate_target_cname (get_local_cname (local)));
				if (delegate_type.is_disposable ()) {
					result.delegate_target_destroy_notify_cvalue = new CCodeMemberAccess.pointer (get_variable_cexpression ("_data%d_".printf (get_block_id (block))), get_delegate_target_destroy_notify_cname (get_local_cname (local)));
				}
			}
		} else {
			result.cvalue = get_local_cexpression (local);
			if (array_type != null && !array_type.fixed_length) {
				for (int dim = 1; dim <= array_type.rank; dim++) {
					result.append_array_length_cvalue (get_variable_cexpression (get_array_length_cname (get_local_cname (local), dim)));
				}
				if (array_type.rank == 1) {
					result.array_size_cvalue = get_variable_cexpression (get_array_size_cname (get_local_cname (local)));
				}
			} else if (delegate_type != null && delegate_type.delegate_symbol.has_target) {
				if (is_in_coroutine ()) {
					result.delegate_target_cvalue = new CCodeMemberAccess.pointer (new CCodeIdentifier ("_data_"), get_delegate_target_cname (get_local_cname (local)));
					if (local.variable_type.value_owned) {
						result.delegate_target_destroy_notify_cvalue = new CCodeMemberAccess.pointer (new CCodeIdentifier ("_data_"), get_delegate_target_destroy_notify_cname (get_local_cname (local)));
					}
				} else {
					result.delegate_target_cvalue = new CCodeIdentifier (get_delegate_target_cname (get_local_cname (local)));
					if (local.variable_type.value_owned) {
						result.delegate_target_destroy_notify_cvalue = new CCodeIdentifier (get_delegate_target_destroy_notify_cname (get_local_cname (local)));
					}
				}
			}
		}

		return result;
	}

	/* Returns access values to the given parameter */
	public override TargetValue get_parameter_cvalue (Parameter param) {
		var result = new GLibValue (param.variable_type.copy ());
		result.lvalue = true;
		result.array_null_terminated = get_ccode_array_null_terminated (param);
		if (get_ccode_array_length_expr (param) != null) {
			result.array_length_cexpr = new CCodeConstant (get_ccode_array_length_expr (param));
		}
		result.ctype = get_ccode_type (param);

		var array_type = result.value_type as ArrayType;
		var delegate_type = result.value_type as DelegateType;

		bool is_unowned_delegate = delegate_type != null && !param.variable_type.value_owned;
		if ((param.captured || is_in_coroutine ()) && !is_unowned_delegate) {
			result.value_type.value_owned = true;
		}

		if (param.name == "this") {
			if (is_in_coroutine ()) {
				// use closure
				result.cvalue = new CCodeMemberAccess.pointer (new CCodeIdentifier ("_data_"), "self");
			} else {
				var st = result.value_type.data_type as Struct;
				if (st != null && !st.is_simple_type ()) {
					result.cvalue = new CCodeIdentifier ("(*self)");
				} else {
					result.cvalue = new CCodeIdentifier ("self");
				}
			}
		} else {
			string name = param.name;

			if (param.captured) {
				// captured variables are stored on the heap
				var block = param.parent_symbol as Block;
				if (block == null) {
					block = ((Method) param.parent_symbol).body;
				}
				result.cvalue = new CCodeMemberAccess.pointer (get_variable_cexpression ("_data%d_".printf (get_block_id (block))), get_variable_cname (param.name));
				if (array_type != null && get_ccode_array_length (param)) {
					for (int dim = 1; dim <= array_type.rank; dim++) {
						result.append_array_length_cvalue (new CCodeMemberAccess.pointer (get_variable_cexpression ("_data%d_".printf (get_block_id (block))), get_parameter_array_length_cname (param, dim)));
					}
				} else if (delegate_type != null && delegate_type.delegate_symbol.has_target) {
					result.delegate_target_cvalue = new CCodeMemberAccess.pointer (get_variable_cexpression ("_data%d_".printf (get_block_id (block))), get_ccode_delegate_target_name (param));
					if (result.value_type.is_disposable ()) {
						result.delegate_target_destroy_notify_cvalue = new CCodeMemberAccess.pointer (get_variable_cexpression ("_data%d_".printf (get_block_id (block))), get_delegate_target_destroy_notify_cname (get_variable_cname (param.name)));
					}
				}
			} else if (is_in_coroutine ()) {
				// use closure
				result.cvalue = get_variable_cexpression (param.name);
				if (delegate_type != null && delegate_type.delegate_symbol.has_target) {
					result.delegate_target_cvalue = new CCodeMemberAccess.pointer (new CCodeIdentifier ("_data_"), get_ccode_delegate_target_name (param));
					if (delegate_type.is_disposable ()) {
						result.delegate_target_destroy_notify_cvalue = new CCodeMemberAccess.pointer (new CCodeIdentifier ("_data_"), get_delegate_target_destroy_notify_cname (get_variable_cname (param.name)));
					}
				}
			} else {
				var type_as_struct = result.value_type.data_type as Struct;

				if (param.direction == ParameterDirection.OUT) {
					name = "_vala_" + name;
				}

				if (param.direction == ParameterDirection.REF ||
					(param.direction == ParameterDirection.IN && type_as_struct != null && !type_as_struct.is_simple_type () && !result.value_type.nullable)) {
					result.cvalue = new CCodeUnaryExpression (CCodeUnaryOperator.POINTER_INDIRECTION, new CCodeIdentifier (get_variable_cname (name)));
				} else {
					// Property setters of non simple structs shall replace all occurrences
					// of the "value" formal parameter with a dereferencing version of that
					// parameter.
					if (current_property_accessor != null &&
						current_property_accessor.writable &&
						current_property_accessor.value_parameter == param &&
						current_property_accessor.prop.property_type.is_real_struct_type () &&
						!current_property_accessor.prop.property_type.nullable) {
						result.cvalue = new CCodeUnaryExpression (CCodeUnaryOperator.POINTER_INDIRECTION, new CCodeIdentifier ("value"));
					} else {
						result.cvalue = get_variable_cexpression (name);
					}
				}
				if (delegate_type != null && delegate_type.delegate_symbol.has_target) {
					var target_cname = get_ccode_delegate_target_name (param);
					if (param.direction == ParameterDirection.OUT) {
						target_cname = "_vala_" + target_cname;
					}
					CCodeExpression target_expr = new CCodeIdentifier (target_cname);
					CCodeExpression delegate_target_destroy_notify = new CCodeIdentifier (get_delegate_target_destroy_notify_cname (get_variable_cname (name)));
					if (param.direction == ParameterDirection.REF) {
						// accessing argument of ref param
						target_expr = new CCodeUnaryExpression (CCodeUnaryOperator.POINTER_INDIRECTION, target_expr);
						delegate_target_destroy_notify = new CCodeUnaryExpression (CCodeUnaryOperator.POINTER_INDIRECTION, delegate_target_destroy_notify);
					}
					result.delegate_target_cvalue = target_expr;
					if (result.value_type.is_disposable ()) {
						result.delegate_target_destroy_notify_cvalue = delegate_target_destroy_notify;
					}
				}
			}
			if (!param.captured && array_type != null) {
				if (get_ccode_array_length (param) && !get_ccode_array_null_terminated (param)) {
					for (int dim = 1; dim <= array_type.rank; dim++) {
						CCodeExpression length_expr = get_variable_cexpression (get_parameter_array_length_cname (param, dim));
						if (param.direction == ParameterDirection.OUT) {
							length_expr = get_variable_cexpression (get_array_length_cname (get_variable_cname (name), dim));
						} else if (param.direction == ParameterDirection.REF) {
							// accessing argument of ref param
							length_expr = new CCodeUnaryExpression (CCodeUnaryOperator.POINTER_INDIRECTION, length_expr);
						}
						result.append_array_length_cvalue (length_expr);
					}
				}
			}
		}

		return result;
	}

	/* Returns lvalue access to the given field */
	public override TargetValue get_field_cvalue (Field field, TargetValue? instance) {
		var value_type = field.variable_type.copy ();

		var result = new GLibValue (value_type);
		if (instance != null) {
			result.actual_value_type = field.variable_type.get_actual_type (instance.value_type, null, field);
		}
		result.lvalue = true;
		result.array_null_terminated = get_ccode_array_null_terminated (field);
		if (get_ccode_array_length_expr (field) != null) {
			result.array_length_cexpr = new CCodeConstant (get_ccode_array_length_expr (field));
		}
		result.ctype = get_ccode_type (field);

		var array_type = result.value_type as ArrayType;
		var delegate_type = result.value_type as DelegateType;
		if (field.binding == MemberBinding.INSTANCE) {
			CCodeExpression pub_inst = null;

			if (instance != null) {
				pub_inst = get_cvalue_ (instance);
			}

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
			if (instance_target_type.data_type.is_reference_type () || (instance != null && instance.value_type is PointerType)) {
				result.cvalue = new CCodeMemberAccess.pointer (inst, get_ccode_name (field));
			} else {
				result.cvalue = new CCodeMemberAccess (inst, get_ccode_name (field));
			}

			if (array_type != null && get_ccode_array_length (field)) {
				for (int dim = 1; dim <= array_type.rank; dim++) {
					CCodeExpression length_expr = null;

					string length_cname;
					if (get_ccode_array_length_name (field) != null) {
						length_cname = get_ccode_array_length_name (field);
					} else {
						length_cname = get_array_length_cname (field.name, dim);
					}

					if (((TypeSymbol) field.parent_symbol).is_reference_type ()) {
						length_expr = new CCodeMemberAccess.pointer (inst, length_cname);
					} else {
						length_expr = new CCodeMemberAccess (inst, length_cname);
					}

					result.append_array_length_cvalue (length_expr);
				}
				if (array_type.rank == 1 && field.is_internal_symbol ()) {
					string size_cname = get_array_size_cname (field.name);

					if (((TypeSymbol) field.parent_symbol).is_reference_type ()) {
						set_array_size_cvalue (result, new CCodeMemberAccess.pointer (inst, size_cname));
					} else {
						set_array_size_cvalue (result, new CCodeMemberAccess (inst, size_cname));
					}
				}
			} else if (delegate_type != null && delegate_type.delegate_symbol.has_target && get_ccode_delegate_target (field)) {
				string target_cname = get_ccode_delegate_target_name (field);
				string target_destroy_notify_cname = get_delegate_target_destroy_notify_cname (get_ccode_name (field));

				if (((TypeSymbol) field.parent_symbol).is_reference_type ()) {
					result.delegate_target_cvalue = new CCodeMemberAccess.pointer (inst, target_cname);
					if (result.value_type.is_disposable ()){
						result.delegate_target_destroy_notify_cvalue = new CCodeMemberAccess.pointer (inst, target_destroy_notify_cname);
					}
				} else {
					result.delegate_target_cvalue = new CCodeMemberAccess (inst, target_cname);
					if (result.value_type.is_disposable ()) {
						result.delegate_target_destroy_notify_cvalue = new CCodeMemberAccess (inst, target_destroy_notify_cname);
					}
				}
			}
		} else if (field.binding == MemberBinding.CLASS) {
			var cl = (Class) field.parent_symbol;
			var cast = new CCodeFunctionCall (new CCodeIdentifier (get_ccode_upper_case_name (cl, null) + "_CLASS"));

			CCodeExpression klass;
			if (instance == null) {
				if (get_this_type () == null) {
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
				k.add_argument (get_cvalue_ (instance));
				klass = k;
			}
			cast.add_argument (klass);

			if (field.access == SymbolAccessibility.PRIVATE) {
				var ccall = new CCodeFunctionCall (new CCodeIdentifier ("%s_GET_CLASS_PRIVATE".printf (get_ccode_upper_case_name (cl))));
				ccall.add_argument (klass);
				result.cvalue = new CCodeMemberAccess.pointer (ccall, get_ccode_name (field));
			} else {
				result.cvalue = new CCodeMemberAccess.pointer (cast, get_ccode_name (field));
			}

		} else {
			generate_field_declaration (field, cfile);

			result.cvalue = new CCodeIdentifier (get_ccode_name (field));

			if (array_type != null && get_ccode_array_length (field)) {
				for (int dim = 1; dim <= array_type.rank; dim++) {
					string length_cname;
					if (get_ccode_array_length_name (field) != null) {
						length_cname = get_ccode_array_length_name (field);
					} else {
						length_cname = get_array_length_cname (get_ccode_name (field), dim);
					}

					result.append_array_length_cvalue (new CCodeIdentifier (length_cname));
				}
				if (array_type.rank == 1 && field.is_internal_symbol ()) {
					set_array_size_cvalue (result, new CCodeIdentifier (get_array_size_cname (get_ccode_name (field))));
				}
			} else if (delegate_type != null && delegate_type.delegate_symbol.has_target && get_ccode_delegate_target (field)) {
				result.delegate_target_cvalue = new CCodeIdentifier (get_ccode_delegate_target_name (field));
				if (result.value_type.is_disposable ()) {
					result.delegate_target_destroy_notify_cvalue = new CCodeIdentifier (get_delegate_target_destroy_notify_cname (get_ccode_name (field)));
				}
			}
		}

		return result;
	}

	public override TargetValue load_variable (Variable variable, TargetValue value) {
		var result = (GLibValue) value;
		var array_type = result.value_type as ArrayType;
		var delegate_type = result.value_type as DelegateType;
		if (array_type != null) {
			if (array_type.fixed_length) {
				result.array_length_cvalues = null;
				result.append_array_length_cvalue (new CCodeConstant (array_type.length.to_string ()));
				result.lvalue = false;
			} else if (get_ccode_array_null_terminated (variable)) {
				requires_array_length = true;
				var len_call = new CCodeFunctionCall (new CCodeIdentifier ("_vala_array_length"));
				len_call.add_argument (result.cvalue);

				result.array_length_cvalues = null;
				result.append_array_length_cvalue (len_call);
				result.lvalue = false;
			} else if (get_ccode_array_length_expr (variable) != null) {
				var length_expr = new CCodeConstant (get_ccode_array_length_expr (variable));

				result.array_length_cvalues = null;
				result.append_array_length_cvalue (length_expr);
				result.lvalue = false;
			} else if (!get_ccode_array_length (variable)) {
				result.array_length_cvalues = null;
				for (int dim = 1; dim <= array_type.rank; dim++) {
					result.append_array_length_cvalue (new CCodeConstant ("-1"));
				}
				result.lvalue = false;
			} else if (get_ccode_array_length_type (variable) != null) {
				for (int dim = 1; dim <= array_type.rank; dim++) {
					// cast if variable does not use int for array length
					result.array_length_cvalues[dim - 1] = new CCodeCastExpression (result.array_length_cvalues[dim - 1], "gint");
				}
				result.lvalue = false;
			}
			result.array_size_cvalue = null;
		} else if (delegate_type != null) {
			if (!delegate_type.delegate_symbol.has_target || !get_ccode_delegate_target (variable)) {
				result.delegate_target_cvalue = new CCodeConstant ("NULL");
			}

			result.delegate_target_destroy_notify_cvalue = new CCodeConstant ("NULL");
			result.lvalue = false;
		}
		result.value_type.value_owned = false;

		bool use_temp = true;
		if (!is_lvalue_access_allowed (result.value_type)) {
			// special handling for types such as va_list
			use_temp = false;
		}
		if (variable is Parameter && variable.name == "this") {
			use_temp = false;
		}
		if (variable.single_assignment && !result.value_type.is_real_non_null_struct_type ()) {
			// no need to copy values from variables that are assigned exactly once
			// as there is no risk of modification
			// except for structs that are always passed by reference
			use_temp = false;
		}
		var local = variable as LocalVariable;
		if (local != null && local.name[0] == '.') {
			// already a temporary variable generated internally
			// and safe to access without temporary variable
			use_temp = false;
		}

		if (use_temp) {
			result = (GLibValue) store_temp_value (result, variable);
		}

		return result;
	}

	/* Returns unowned access to the given local variable */
	public override TargetValue load_local (LocalVariable local) {
		return load_variable (local, get_local_cvalue (local));
	}

	/* Returns unowned access to the given parameter */
	public override TargetValue load_parameter (Parameter param) {
		return load_variable (param, get_parameter_cvalue (param));
	}

	/* Convenience method returning access to "this" */
	public override TargetValue load_this_parameter (TypeSymbol sym) {
		var param = new Parameter ("this", get_data_type_for_symbol (sym));
		return load_parameter (param);
	}

	/* Returns unowned access to the given field */
	public override TargetValue load_field (Field field, TargetValue? instance) {
		return load_variable (field, get_field_cvalue (field, instance));
	}
}
