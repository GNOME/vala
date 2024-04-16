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

			if (!(m is DynamicMethod || m is ArrayMoveMethod || m is ArrayResizeMethod || m is ArrayCopyMethod)) {
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
				CCodeExpression? vcast = null;
				if (m.base_method != null) {
					unowned Class base_class = (Class) m.base_method.parent_symbol;
					vcast = new CCodeFunctionCall (new CCodeIdentifier (get_ccode_class_type_function (base_class)));
					((CCodeFunctionCall) vcast).add_argument (new CCodeIdentifier ("%s_parent_class".printf (get_ccode_lower_case_name (current_class))));
				} else if (m.base_interface_method != null) {
					unowned Interface base_iface = (Interface) m.base_interface_method.parent_symbol;
					vcast = get_this_interface_cexpression (base_iface);
				}
				if (vcast != null) {
					set_cvalue (expr, new CCodeMemberAccess.pointer (vcast, get_ccode_vfunc_name (m)));
					return;
				}
			}

			if (m.base_method != null) {
				if (get_ccode_no_wrapper (m.base_method)) {
					unowned Class base_class = (Class) m.base_method.parent_symbol;
					if (!base_class.is_compact) {
						var vclass = get_this_class_cexpression (base_class, expr.inner.target_value);
						set_cvalue (expr, new CCodeMemberAccess.pointer (vclass, get_ccode_vfunc_name (m)));
					} else {
						set_cvalue (expr, new CCodeMemberAccess.pointer (pub_inst, get_ccode_vfunc_name (m)));
					}
				} else {
					set_cvalue (expr, new CCodeIdentifier (get_ccode_name (m.base_method)));
				}
			} else if (m.base_interface_method != null) {
				if (get_ccode_no_wrapper (m.base_interface_method)) {
					unowned Interface base_iface = (Interface) m.base_interface_method.parent_symbol;
					var vclass = get_this_interface_cexpression (base_iface, expr.inner.target_value);
					set_cvalue (expr, new CCodeMemberAccess.pointer (vclass, get_ccode_vfunc_name (m)));
				} else {
					set_cvalue (expr, new CCodeIdentifier (get_ccode_name (m.base_interface_method)));
				}
			} else if (m is CreationMethod) {
				set_cvalue (expr, new CCodeIdentifier (get_ccode_real_name (m)));
			} else {
				set_cvalue (expr, new CCodeIdentifier (get_ccode_name (m)));
			}

			delegate_type = expr.target_type as DelegateType;
			if (delegate_type != null) {
				generate_type_declaration (delegate_type, cfile);
				set_cvalue (expr, new CCodeCastExpression (get_cvalue (expr), get_ccode_name (delegate_type.delegate_symbol)));
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
				if ((expr.value_type.value_owned || (delegate_type != null && delegate_type.is_called_once)) && expr.inner.value_type.type_symbol != null && is_reference_counting (expr.inner.value_type.type_symbol)) {
					var ref_call = new CCodeFunctionCall (get_dup_func_expression (expr.inner.value_type, expr.source_reference));
					ref_call.add_argument (delegate_target);
					delegate_target = ref_call;
					set_delegate_target_destroy_notify (expr, get_destroy_func_expression (expr.inner.value_type));
				}
				set_delegate_target (expr, delegate_target);
			}
		} else if (expr.symbol_reference is ArrayLengthField) {
			set_cvalue (expr, get_array_length_cexpression (expr.inner, 1));
		} else if (expr.symbol_reference is DelegateTargetField) {
			CCodeExpression delegate_target_destroy_notify;
			set_cvalue (expr, get_delegate_target_cexpression (expr.inner, out delegate_target_destroy_notify) ?? new CCodeConstant ("NULL"));
		} else if (expr.symbol_reference is DelegateDestroyField) {
			CCodeExpression delegate_target_destroy_notify;
			get_delegate_target_cexpression (expr.inner, out delegate_target_destroy_notify);
			set_cvalue (expr, delegate_target_destroy_notify ?? new CCodeConstant ("NULL"));
		} else if (expr.symbol_reference is GenericDupField) {
			set_cvalue (expr, get_dup_func_expression (expr.inner.value_type, expr.source_reference));
		} else if (expr.symbol_reference is GenericDestroyField) {
			set_cvalue (expr, get_destroy_func_expression (expr.inner.value_type));
		} else if (expr.symbol_reference is Field) {
			var field = (Field) expr.symbol_reference;
			if (expr.lvalue) {
				expr.target_value = get_field_cvalue (field, expr.inner != null ? expr.inner.target_value : null);
			} else {
				expr.target_value = load_field (field, expr.inner != null ? expr.inner.target_value : null, expr);
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
			} else if (c.type_reference.is_non_null_simple_type ()) {
				set_cvalue (expr, new CCodeConstant (get_ccode_name (c)));
			} else {
				set_cvalue (expr, new CCodeConstantIdentifier (get_ccode_name (c)));
			}

			if (array_type != null) {
				string sub = "";
				for (int i = 0; i < array_type.rank; i++) {
					CCodeFunctionCall ccall;
					if (context.profile == Profile.POSIX) {
						requires_array_n_elements = true;
						ccall = new CCodeFunctionCall (new CCodeIdentifier ("VALA_N_ELEMENTS"));
					} else {
						ccall = new CCodeFunctionCall (new CCodeIdentifier ("G_N_ELEMENTS"));
					}
					ccall.add_argument (new CCodeIdentifier (get_ccode_name (c) + sub));
					append_array_length (expr, ccall);
					sub += "[0]";
				}
				((GLibValue) expr.target_value).non_null = true;
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

			if (pub_inst == null && prop.binding == MemberBinding.INSTANCE) {
				// FIXME Report this with proper source-reference on the vala side!
				Report.error (prop.source_reference, "Invalid access to instance member `%s'", prop.get_full_name ());
				set_cvalue (expr, new CCodeInvalidExpression ());
				return;
			}

			unowned Property base_prop = prop;
			if (prop.base_property != null) {
				base_prop = prop.base_property;
			} else if (prop.base_interface_property != null) {
				base_prop = prop.base_interface_property;
			}
			if (expr.inner is BaseAccess && (base_prop.is_abstract || base_prop.is_virtual)) {
				CCodeExpression? vcast = null;
				if (base_prop.parent_symbol is Class) {
					unowned Class base_class = (Class) base_prop.parent_symbol;
					vcast = new CCodeFunctionCall (new CCodeIdentifier (get_ccode_class_type_function (base_class)));
					((CCodeFunctionCall) vcast).add_argument (new CCodeIdentifier ("%s_parent_class".printf (get_ccode_lower_case_name (current_class))));
				} else if (base_prop.parent_symbol is Interface) {
					unowned Interface base_iface = (Interface) base_prop.parent_symbol;
					vcast = get_this_interface_cexpression (base_iface);
				}
				if (vcast != null) {
					var ccall = new CCodeFunctionCall (new CCodeMemberAccess.pointer (vcast, "get_%s".printf (prop.name)));
					ccall.add_argument (get_cvalue (expr.inner));
					if (prop.property_type.is_real_non_null_struct_type ()) {
						var temp_value = (GLibValue) create_temp_value (prop.get_accessor.value_type, false, expr);
						expr.target_value = load_temp_value (temp_value);
						var ctemp = get_cvalue_ (temp_value);
						ccall.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, ctemp));
						ccode.add_expression (ccall);
					} else {
						set_cvalue (expr, ccall);
					}
				} else {
					Report.error (expr.source_reference, "internal: Invalid access to `%s'", base_prop.get_full_name ());
				}
			} else if (prop.binding == MemberBinding.INSTANCE &&
			    prop.get_accessor.automatic_body &&
			    !prop.get_accessor.value_type.value_owned &&
			    current_type_symbol == prop.parent_symbol &&
			    current_type_symbol is Class &&
			    prop.base_property == null &&
			    prop.base_interface_property == null &&
			    !(prop.property_type is ArrayType || prop.property_type is DelegateType)) {
				CCodeExpression inst = pub_inst;
				if (!((Class) current_type_symbol).is_compact) {
					inst = new CCodeMemberAccess.pointer (inst, "priv");
				}
				set_cvalue (expr, new CCodeMemberAccess.pointer (inst, get_ccode_name (prop.field)));
			} else if (!get_ccode_no_accessor_method (prop) && !(prop is DynamicProperty)) {
				var ccall = new CCodeFunctionCall (new CCodeIdentifier (get_ccode_name (prop.get_accessor)));

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

				bool prop_is_real_non_null_struct_type = prop.property_type.is_real_non_null_struct_type ();
				bool requires_init = prop.property_type is DelegateType || prop_is_real_non_null_struct_type;
				var temp_value = (GLibValue) create_temp_value (prop.get_accessor.value_type, requires_init, expr);
				expr.target_value = load_temp_value (temp_value);
				var ctemp = get_cvalue_ (temp_value);

				// Property access to real struct types is handled differently
				// The value is returned by out parameter
				if (prop_is_real_non_null_struct_type) {
					ccall.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, ctemp));
					ccode.add_expression (ccall);
				} else {
					array_type = prop.property_type as ArrayType;
					if (array_type != null) {
						if (get_ccode_array_null_terminated (prop) && !get_ccode_array_length (prop)) {
							requires_array_length = true;
							var len_call = new CCodeFunctionCall (new CCodeIdentifier ("_vala_array_length"));
							len_call.add_argument (ctemp);

							ccode.add_assignment (ctemp, ccall);
							ccode.add_assignment (temp_value.array_length_cvalues[0], len_call);
						} else if (get_ccode_array_length (prop)) {
							var temp_refs = new ArrayList<CCodeExpression> ();
							for (int dim = 1; dim <= array_type.rank; dim++) {
								var length_ctype = get_ccode_array_length_type (prop);
								var temp_var = get_temp_variable (new CType (length_ctype, "0"), true, null, true);
								var temp_ref = get_variable_cexpression (temp_var.name);
								emit_temp_var (temp_var);
								ccall.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, temp_ref));
								temp_refs.add (temp_ref);
							}

							ccode.add_assignment (ctemp, ccall);
							for (int dim = 1; dim <= array_type.rank; dim++) {
								ccode.add_assignment (temp_value.array_length_cvalues[dim - 1], temp_refs.get (dim - 1));
							}
						} else {
							ccode.add_assignment (ctemp, ccall);
						}
					} else {
						ccode.add_assignment (ctemp, ccall);

						delegate_type = prop.property_type as DelegateType;
						if (delegate_type != null && get_ccode_delegate_target (prop) && delegate_type.delegate_symbol.has_target) {
							ccall.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, get_delegate_target_cvalue (temp_value)));
						} else {
							if (temp_value.delegate_target_cvalue != null) {
								ccode.add_assignment (temp_value.delegate_target_cvalue, new CCodeConstant ("NULL"));
							}
							if (temp_value.delegate_target_destroy_notify_cvalue != null) {
								ccode.add_assignment (temp_value.delegate_target_destroy_notify_cvalue, new CCodeConstant ("NULL"));
							}
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
				if (!(prop is DynamicProperty) && !prop.get_accessor.value_type.value_owned) {
					// only report error for types where there actually
					// is a difference between `owned' and `unowned'
					var owned_value_type = prop.get_accessor.value_type.copy ();
					owned_value_type.value_owned = true;
					if (requires_copy (owned_value_type)) {
						Report.error (prop.get_accessor.source_reference, "unowned return value for getter of property `%s' not supported without accessor", prop.get_full_name ());
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

				if (get_ccode_array_null_terminated (prop) && !get_ccode_array_length (prop)) {
					requires_array_length = true;
					var len_call = new CCodeFunctionCall (new CCodeIdentifier ("_vala_array_length"));
					len_call.add_argument (ctemp);

					var glib_value = (GLibValue) expr.target_value;
					glib_value.array_length_cvalues = null;
					glib_value.append_array_length_cvalue (len_call);
					glib_value.lvalue = false;
				}
			}

			if (prop.get_accessor.value_type is GenericType) {
				expr.target_value.value_type = prop.get_accessor.value_type.copy ();
			} else {
				expr.target_value.value_type = expr.value_type.copy ();
			}
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
					expr.target_value = load_local (local, expr);
				}
			}
		} else if (expr.symbol_reference is Parameter) {
			var param = (Parameter) expr.symbol_reference;
			if (expr.lvalue) {
				expr.target_value = get_parameter_cvalue (param);
			} else {
				expr.target_value = load_parameter (param, expr);
			}
		}

		// Add cast for narrowed type access of variables if needed
		if (expr.symbol_reference is Variable) {
			unowned GLibValue cvalue = (GLibValue) expr.target_value;
			if (!(cvalue.value_type is GenericType) && cvalue.value_type.type_symbol != null
			    && cvalue.value_type.type_symbol != expr.value_type.type_symbol) {
				cvalue.cvalue = new CCodeCastExpression (cvalue.cvalue, get_ccode_name (expr.value_type));
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
					result.delegate_target_cvalue = get_variable_cexpression (get_delegate_target_cname (get_local_cname (local)));
					if (local.variable_type.is_disposable ()) {
						result.delegate_target_destroy_notify_cvalue = get_variable_cexpression (get_delegate_target_destroy_notify_cname (get_local_cname (local)));
					}
				} else {
					result.delegate_target_cvalue = new CCodeIdentifier (get_delegate_target_cname (get_local_cname (local)));
					if (local.variable_type.is_disposable ()) {
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
				result.cvalue = get_this_cexpression ();
			} else {
				unowned Struct? st = result.value_type.type_symbol as Struct;
				if (st != null && !st.is_simple_type ()) {
					result.cvalue = new CCodeIdentifier ("(*self)");
				} else {
					result.cvalue = new CCodeIdentifier ("self");
				}
			}
		} else {
			string name = get_ccode_name (param);

			if (param.captured && !is_in_method_precondition) {
				// captured variables are stored on the heap
				var block = param.parent_symbol as Block;
				if (block == null) {
					block = ((Method) param.parent_symbol).body;
				}
				result.cvalue = new CCodeMemberAccess.pointer (get_variable_cexpression ("_data%d_".printf (get_block_id (block))), get_ccode_name (param));
				if (array_type != null && get_ccode_array_length (param)) {
					for (int dim = 1; dim <= array_type.rank; dim++) {
						result.append_array_length_cvalue (new CCodeMemberAccess.pointer (get_variable_cexpression ("_data%d_".printf (get_block_id (block))), get_variable_array_length_cname (param, dim)));
					}
				} else if (delegate_type != null && delegate_type.delegate_symbol.has_target) {
					result.delegate_target_cvalue = new CCodeMemberAccess.pointer (get_variable_cexpression ("_data%d_".printf (get_block_id (block))), get_ccode_delegate_target_name (param));
					if (result.value_type.is_disposable ()) {
						result.delegate_target_destroy_notify_cvalue = new CCodeMemberAccess.pointer (get_variable_cexpression ("_data%d_".printf (get_block_id (block))), get_ccode_delegate_target_destroy_notify_name (param));
					}
				}
			} else if (is_in_coroutine ()) {
				// use closure
				result.cvalue = get_parameter_cexpression (param);
				if (delegate_type != null && delegate_type.delegate_symbol.has_target) {
					result.delegate_target_cvalue = get_variable_cexpression (get_ccode_delegate_target_name (param));
					if (delegate_type.is_disposable ()) {
						result.delegate_target_destroy_notify_cvalue = get_variable_cexpression (get_ccode_delegate_target_destroy_notify_name (param));
					}
				}
			} else {
				unowned Struct? type_as_struct = result.value_type.type_symbol as Struct;

				if (param.direction == ParameterDirection.OUT) {
					name = "_vala_%s".printf (name);
				}

				if (param.direction == ParameterDirection.REF ||
					(param.direction == ParameterDirection.IN && type_as_struct != null && !type_as_struct.is_simple_type () && !result.value_type.nullable)) {
					result.cvalue = new CCodeUnaryExpression (CCodeUnaryOperator.POINTER_INDIRECTION, new CCodeIdentifier (name));
				} else {
					result.cvalue = get_variable_cexpression (name);
				}
				if (get_ccode_delegate_target (param) && delegate_type != null && delegate_type.delegate_symbol.has_target) {
					var target_cname = get_ccode_delegate_target_name (param);
					var destroy_cname = get_ccode_delegate_target_destroy_notify_name (param);
					if (param.direction == ParameterDirection.OUT) {
						target_cname = "_vala_%s".printf (target_cname);
						destroy_cname = "_vala_%s".printf (destroy_cname);
					}
					CCodeExpression target_expr = new CCodeIdentifier (target_cname);
					CCodeExpression delegate_target_destroy_notify = new CCodeIdentifier (destroy_cname);
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
						CCodeExpression length_expr = get_cexpression (get_variable_array_length_cname (param, dim));
						if (param.direction == ParameterDirection.OUT) {
							length_expr = get_cexpression (get_array_length_cname (name, dim));
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
		if (field.binding == MemberBinding.INSTANCE) {
			CCodeExpression pub_inst = null;

			if (instance != null) {
				pub_inst = get_cvalue_ (instance);
			}

			var instance_target_type = SemanticAnalyzer.get_data_type_for_symbol (field.parent_symbol);

			unowned Class? cl = instance_target_type.type_symbol as Class;
			bool is_gtypeinstance = ((instance_target_type.type_symbol == cl) && (cl == null || !cl.is_compact));

			CCodeExpression inst;
			if (is_gtypeinstance && field.access == SymbolAccessibility.PRIVATE) {
				inst = new CCodeMemberAccess.pointer (pub_inst, "priv");
			} else {
				if (cl != null) {
					generate_class_struct_declaration (cl, cfile);
				}
				inst = pub_inst;
			}

			if (inst == null) {
				// FIXME Report this with proper source-reference on the vala side!
				Report.error (field.source_reference, "Invalid access to instance member `%s'", field.get_full_name ());
				result.cvalue = new CCodeInvalidExpression ();
				return result;
			}

			if (instance_target_type.type_symbol.is_reference_type () || (instance != null && instance.value_type is PointerType)) {
				result.cvalue = new CCodeMemberAccess.pointer (inst, get_ccode_name (field));
			} else {
				result.cvalue = new CCodeMemberAccess (inst, get_ccode_name (field));
			}

			if (array_type != null && get_ccode_array_length (field)) {
				for (int dim = 1; dim <= array_type.rank; dim++) {
					CCodeExpression length_expr = null;
					string length_cname = get_variable_array_length_cname (field, dim);

					if (((TypeSymbol) field.parent_symbol).is_reference_type ()) {
						length_expr = new CCodeMemberAccess.pointer (inst, length_cname);
					} else {
						length_expr = new CCodeMemberAccess (inst, length_cname);
					}

					result.append_array_length_cvalue (length_expr);
				}
				if (array_type.rank == 1 && field.is_internal_symbol ()) {
					string size_cname = get_array_size_cname (get_ccode_name (field));

					if (((TypeSymbol) field.parent_symbol).is_reference_type ()) {
						set_array_size_cvalue (result, new CCodeMemberAccess.pointer (inst, size_cname));
					} else {
						set_array_size_cvalue (result, new CCodeMemberAccess (inst, size_cname));
					}
				}
			} else if (get_ccode_delegate_target (field)) {
				string target_cname = get_ccode_delegate_target_name (field);
				string target_destroy_notify_cname = get_ccode_delegate_target_destroy_notify_name (field);

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
			unowned Class cl = (Class) field.parent_symbol;
			var cast = get_this_class_cexpression (cl, instance);
			if (field.access == SymbolAccessibility.PRIVATE) {
				var ccall = new CCodeFunctionCall (new CCodeIdentifier (get_ccode_class_get_private_function (cl)));
				ccall.add_argument (cast);
				result.cvalue = new CCodeMemberAccess.pointer (ccall, get_ccode_name (field));
			} else {
				result.cvalue = new CCodeMemberAccess.pointer (cast, get_ccode_name (field));
			}

		} else {
			generate_field_declaration (field, cfile);

			result.cvalue = new CCodeIdentifier (get_ccode_name (field));

			if (array_type != null && get_ccode_array_length (field)) {
				for (int dim = 1; dim <= array_type.rank; dim++) {
					string length_cname = get_variable_array_length_cname (field, dim);
					result.append_array_length_cvalue (new CCodeIdentifier (length_cname));
				}
				if (array_type.rank == 1 && field.is_internal_symbol ()) {
					set_array_size_cvalue (result, new CCodeIdentifier (get_array_size_cname (get_ccode_name (field))));
				}
			} else if (get_ccode_delegate_target (field)) {
				result.delegate_target_cvalue = new CCodeIdentifier (get_ccode_delegate_target_name (field));
				if (result.value_type.is_disposable ()) {
					result.delegate_target_destroy_notify_cvalue = new CCodeIdentifier (get_ccode_delegate_target_destroy_notify_name (field));
				}
			}
		}

		return result;
	}

	public override TargetValue load_variable (Variable variable, TargetValue value, Expression? expr = null) {
		var result = (GLibValue) value;
		var array_type = result.value_type as ArrayType;
		var delegate_type = result.value_type as DelegateType;
		if (array_type != null) {
			if (array_type.fixed_length) {
				result.array_length_cvalues = null;
				result.append_array_length_cvalue (get_ccodenode (array_type.length));
				result.lvalue = false;
			} else if (get_ccode_array_null_terminated (variable) && !get_ccode_array_length (variable)) {
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
			} else if (get_ccode_array_length_type (variable.variable_type) != get_ccode_array_length_type (array_type)) {
				for (int dim = 1; dim <= array_type.rank; dim++) {
					// cast if variable does not use int for array length
					result.array_length_cvalues[dim - 1] = new CCodeCastExpression (result.array_length_cvalues[dim - 1], get_ccode_array_length_type (array_type));
				}
				result.lvalue = false;
			}
			result.array_size_cvalue = null;
			result.non_null = array_type.inline_allocated;
		} else if (delegate_type != null) {
			if (!get_ccode_delegate_target (variable)) {
				result.delegate_target_cvalue = new CCodeConstant ("NULL");
				result.delegate_target_destroy_notify_cvalue = new CCodeConstant ("NULL");
			}

			result.lvalue = false;
		}
		result.value_type.value_owned = false;

		bool use_temp = true;
		if (!is_lvalue_access_allowed (result.value_type)) {
			// special handling for types such as va_list
			use_temp = false;
		}
		if (variable is Parameter) {
			var param = (Parameter) variable;
			if (variable.name == "this") {
				use_temp = false;
			} else if ((param.direction != ParameterDirection.OUT)
			    && !(param.variable_type.is_real_non_null_struct_type ())) {
				use_temp = false;
			}
		}
		if (variable.single_assignment && !result.value_type.is_real_non_null_struct_type ()) {
			// no need to copy values from variables that are assigned exactly once
			// as there is no risk of modification
			// except for structs that are always passed by reference
			use_temp = false;
		}
		if (result.value_type.is_non_null_simple_type ()) {
			// no need to an extra copy of variables that are stack allocated simple types
			use_temp = false;
		}
		// our implementation of postfix-expressions require temporary variables
		if (expr is MemberAccess && ((MemberAccess) expr).tainted_access) {
			use_temp = true;
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
	public override TargetValue load_local (LocalVariable local, Expression? expr = null) {
		return load_variable (local, get_local_cvalue (local), expr);
	}

	/* Returns unowned access to the given parameter */
	public override TargetValue load_parameter (Parameter param, Expression? expr = null) {
		return load_variable (param, get_parameter_cvalue (param), expr);
	}

	/* Convenience method returning access to "this" */
	public override TargetValue load_this_parameter (TypeSymbol sym) {
		var param = new Parameter ("this", SemanticAnalyzer.get_data_type_for_symbol (sym));
		return load_parameter (param);
	}

	/* Returns unowned access to the given field */
	public override TargetValue load_field (Field field, TargetValue? instance, Expression? expr = null) {
		return load_variable (field, get_field_cvalue (field, instance), expr);
	}
}
