/* valaccodeclassmodule.vala
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


public class Vala.CCodeClassModule : CCodeDelegateModule {
	public override CCodeParameter generate_parameter (Parameter param, CCodeFile decl_space, Map<int,CCodeParameter> cparam_map, Map<int,CCodeExpression>? carg_map) {
		if (!(param.variable_type is ObjectType)) {
			return base.generate_parameter (param, decl_space, cparam_map, carg_map);
		}

		generate_type_declaration (param.variable_type, decl_space);

		string ctypename = get_ccode_name (param.variable_type);

		if (param.direction != ParameterDirection.IN) {
			ctypename = "%s *".printf (ctypename);
		}

		var cparam = new CCodeParameter (get_variable_cname (param.name), ctypename);
		if (param.format_arg) {
			cparam.modifiers = CCodeModifiers.FORMAT_ARG;
		}

		cparam_map.set (get_param_pos (get_ccode_pos (param)), cparam);
		if (carg_map != null) {
			carg_map.set (get_param_pos (get_ccode_pos (param)), get_variable_cexpression (param.name));
		}

		return cparam;
	}

	public override void generate_class_declaration (Class cl, CCodeFile decl_space) {
		if (add_symbol_declaration (decl_space, cl, get_ccode_name (cl))) {
			return;
		}

		if (cl.base_class != null) {
			// base class declaration
			// necessary for ref and unref function declarations
			generate_class_declaration (cl.base_class, decl_space);
		}

		if (cl.is_compact && cl.base_class != null) {
			decl_space.add_type_declaration (new CCodeTypeDefinition (get_ccode_name (cl.base_class), new CCodeVariableDeclarator (get_ccode_name (cl))));
		} else {
			decl_space.add_type_declaration (new CCodeTypeDefinition ("struct _%s".printf (get_ccode_name (cl)), new CCodeVariableDeclarator (get_ccode_name (cl))));
		}

			if (cl.base_class == null) {
				var function = new CCodeFunction (get_ccode_free_function (cl), "void");
				if (cl.is_private_symbol ()) {
					function.modifiers = CCodeModifiers.STATIC;
				} else if (context.hide_internal && cl.is_internal_symbol ()) {
					function.modifiers = CCodeModifiers.INTERNAL;
				}

				function.add_parameter (new CCodeParameter ("self", "%s *".printf (get_ccode_name (cl))));

				decl_space.add_function_declaration (function);
			}
	}

	public override void generate_class_struct_declaration (Class cl, CCodeFile decl_space) {
		if (add_symbol_declaration (decl_space, cl, "struct _%s".printf (get_ccode_name (cl)))) {
			return;
		}

		if (cl.base_class != null) {
			// base class declaration
			generate_class_struct_declaration (cl.base_class, decl_space);
		}

		generate_class_declaration (cl, decl_space);

		var instance_struct = new CCodeStruct ("_%s".printf (get_ccode_name (cl)));
		var type_struct = new CCodeStruct ("_%sClass".printf (get_ccode_name (cl)));

		if (cl.base_class != null) {
			instance_struct.add_field (get_ccode_name (cl.base_class), "parent_instance");
		}

		bool has_struct_member = false;
		if (context.abi_stability) {
			foreach (Symbol s in cl.get_members ()) {
				if (s is Method) {
					var m = (Method) s;
					generate_struct_method_declaration (cl, m, instance_struct, type_struct, decl_space, ref has_struct_member);
				} else if (s is Signal) {
					var sig = (Signal) s;
					if (sig.default_handler != null) {
						generate_virtual_method_declaration (sig.default_handler, decl_space, type_struct);
					}
				} else if (s is Property) {
					var prop = (Property) s;
					generate_struct_property_declaration (cl, prop, instance_struct, type_struct, decl_space, ref has_struct_member);
				} else if (s is Field) {
					var f = (Field) s;
					generate_struct_field_declaration (cl, f, instance_struct, type_struct, decl_space, ref has_struct_member);
				} else {
					assert_not_reached ();
				}
			}
		} else {
			foreach (Method m in cl.get_methods ()) {
				generate_struct_method_declaration (cl, m, instance_struct, type_struct, decl_space, ref has_struct_member);
			}

			foreach (Signal sig in cl.get_signals ()) {
				if (sig.default_handler != null) {
					generate_virtual_method_declaration (sig.default_handler, decl_space, type_struct);
				}
			}

			foreach (Property prop in cl.get_properties ()) {
				generate_struct_property_declaration (cl, prop, instance_struct, type_struct, decl_space, ref has_struct_member);
			}

			foreach (Field f in cl.get_fields ()) {
				generate_struct_field_declaration (cl, f, instance_struct, type_struct, decl_space, ref has_struct_member);
			}
		}

		if (cl.base_class == null && !has_struct_member) {
			// add dummy member, C doesn't allow empty structs
			instance_struct.add_field ("int", "dummy");
		}

		if (cl.base_class == null) {
			// derived compact classes do not have a struct
			decl_space.add_type_definition (instance_struct);
		}
	}

	void generate_struct_method_declaration (Class cl, Method m, CCodeStruct instance_struct, CCodeStruct type_struct, CCodeFile decl_space, ref bool has_struct_member) {
		if (cl.base_class == null) {
			generate_virtual_method_declaration (m, decl_space, instance_struct);
			has_struct_member |= (m.is_abstract || m.is_virtual);
		}
	}

	void generate_struct_property_declaration (Class cl, Property prop, CCodeStruct instance_struct, CCodeStruct type_struct, CCodeFile decl_space, ref bool has_struct_member) {
		if (!prop.is_abstract && !prop.is_virtual) {
			return;
		}
		generate_type_declaration (prop.property_type, decl_space);

		var t = (ObjectTypeSymbol) prop.parent_symbol;

		var this_type = new ObjectType (t);
		var cselfparam = new CCodeParameter ("self", get_ccode_name (this_type));

		if (prop.get_accessor != null) {
			var vdeclarator = new CCodeFunctionDeclarator ("get_%s".printf (prop.name));
			vdeclarator.add_parameter (cselfparam);
			string creturn_type;
			if (prop.property_type.is_real_non_null_struct_type ()) {
				var cvalueparam = new CCodeParameter ("result", "%s *".printf (get_ccode_name (prop.get_accessor.value_type)));
				vdeclarator.add_parameter (cvalueparam);
				creturn_type = "void";
			} else {
				creturn_type = get_ccode_name (prop.get_accessor.value_type);
			}

			var array_type = prop.property_type as ArrayType;
			if (array_type != null) {
				var length_ctype = get_ccode_array_length_type (array_type) + "*";
				for (int dim = 1; dim <= array_type.rank; dim++) {
					vdeclarator.add_parameter (new CCodeParameter (get_array_length_cname ("result", dim), length_ctype));
				}
			} else if ((prop.property_type is DelegateType) && ((DelegateType) prop.property_type).delegate_symbol.has_target) {
				vdeclarator.add_parameter (new CCodeParameter (get_delegate_target_cname ("result"), get_ccode_name (pointer_type) + "*"));
			}

			var vdecl = new CCodeDeclaration (creturn_type);
			vdecl.add_declarator (vdeclarator);
			type_struct.add_declaration (vdecl);

			if (cl.is_compact && cl.base_class == null) {
				instance_struct.add_declaration (vdecl);
				has_struct_member = true;
			}
		}
		if (prop.set_accessor != null) {
			CCodeParameter cvalueparam;
			if (prop.property_type.is_real_non_null_struct_type ()) {
				cvalueparam = new CCodeParameter ("value", "%s *".printf (get_ccode_name (prop.set_accessor.value_type)));
			} else {
				cvalueparam = new CCodeParameter ("value", get_ccode_name (prop.set_accessor.value_type));
			}

			var vdeclarator = new CCodeFunctionDeclarator ("set_%s".printf (prop.name));
			vdeclarator.add_parameter (cselfparam);
			vdeclarator.add_parameter (cvalueparam);

			var array_type = prop.property_type as ArrayType;
			if (array_type != null) {
				var length_ctype = get_ccode_array_length_type (array_type);
				for (int dim = 1; dim <= array_type.rank; dim++) {
					vdeclarator.add_parameter (new CCodeParameter (get_array_length_cname ("value", dim), length_ctype));
				}
			} else if ((prop.property_type is DelegateType) && ((DelegateType) prop.property_type).delegate_symbol.has_target) {
				vdeclarator.add_parameter (new CCodeParameter (get_delegate_target_cname ("value"), get_ccode_name (pointer_type)));
			}

			var vdecl = new CCodeDeclaration ("void");
			vdecl.add_declarator (vdeclarator);
			type_struct.add_declaration (vdecl);

			if (cl.is_compact && cl.base_class == null) {
				instance_struct.add_declaration (vdecl);
				has_struct_member = true;
			}
		}
	}

	void generate_struct_field_declaration (Class cl, Field f, CCodeStruct instance_struct, CCodeStruct type_struct, CCodeFile decl_space, ref bool has_struct_member) {
		if (f.access == SymbolAccessibility.PRIVATE) {
			return;
		}

		CCodeModifiers modifiers = (f.is_volatile ? CCodeModifiers.VOLATILE : 0) | (f.version.deprecated ? CCodeModifiers.DEPRECATED : 0);
		if (f.binding == MemberBinding.INSTANCE) {
			generate_type_declaration (f.variable_type, decl_space);

			instance_struct.add_field (get_ccode_name (f.variable_type), get_ccode_name (f), modifiers, get_ccode_declarator_suffix (f.variable_type));
			has_struct_member = true;
			if (f.variable_type is ArrayType && get_ccode_array_length (f)) {
				// create fields to store array dimensions
				var array_type = (ArrayType) f.variable_type;

				if (!array_type.fixed_length) {
					var length_ctype = get_ccode_array_length_type (array_type);

					for (int dim = 1; dim <= array_type.rank; dim++) {
						string length_cname;
						if (get_ccode_array_length_name (f) != null) {
							length_cname = get_ccode_array_length_name (f);
						} else {
							length_cname = get_array_length_cname (get_ccode_name (f), dim);
						}
						instance_struct.add_field (length_ctype, length_cname);
					}

					if (array_type.rank == 1 && f.is_internal_symbol ()) {
						instance_struct.add_field (length_ctype, get_array_size_cname (get_ccode_name (f)));
					}
				}
			} else if (f.variable_type is DelegateType && get_ccode_delegate_target (f)) {
				var delegate_type = (DelegateType) f.variable_type;
				if (delegate_type.delegate_symbol.has_target) {
					// create field to store delegate target
					instance_struct.add_field (get_ccode_name (delegate_target_type), get_ccode_delegate_target_name (f));
					if (delegate_type.is_disposable ()) {
						instance_struct.add_field (get_ccode_name (delegate_target_destroy_type), get_delegate_target_destroy_notify_cname (get_ccode_name (f)));
					}
				}
			}
		} else if (f.binding == MemberBinding.CLASS) {
			type_struct.add_field (get_ccode_name (f.variable_type), get_ccode_name (f), modifiers);
		}
	}

	public virtual void generate_virtual_method_declaration (Method m, CCodeFile decl_space, CCodeStruct type_struct) {
		if (!m.is_abstract && !m.is_virtual) {
			return;
		}

		var creturn_type = m.return_type;
		if (m.return_type.is_real_non_null_struct_type ()) {
			// structs are returned via out parameter
			creturn_type = new VoidType ();
		}

		// add vfunc field to the type struct
		var vdeclarator = new CCodeFunctionDeclarator (get_ccode_vfunc_name (m));
		var cparam_map = new HashMap<int,CCodeParameter> (direct_hash, direct_equal);

		if (m.printf_format) {
			vdeclarator.modifiers |= CCodeModifiers.PRINTF;
		} else if (m.scanf_format) {
			vdeclarator.modifiers |= CCodeModifiers.SCANF;
		}

		if (m.version.deprecated) {
			vdeclarator.modifiers |= CCodeModifiers.DEPRECATED;
		}

		generate_cparameters (m, decl_space, cparam_map, new CCodeFunction ("fake"), vdeclarator);

		var vdecl = new CCodeDeclaration (get_ccode_name (creturn_type));
		vdecl.add_declarator (vdeclarator);
		type_struct.add_declaration (vdecl);
	}

	void generate_class_private_declaration (Class cl, CCodeFile decl_space) {
		if (decl_space.add_declaration ("%sPrivate".printf (get_ccode_name (cl)))) {
			return;
		}

		bool has_class_locks = false;

		var instance_priv_struct = new CCodeStruct ("_%sPrivate".printf (get_ccode_name (cl)));
		var type_priv_struct = new CCodeStruct ("_%sClassPrivate".printf (get_ccode_name (cl)));

		foreach (Field f in cl.get_fields ()) {
			CCodeModifiers modifiers = (f.is_volatile ? CCodeModifiers.VOLATILE : 0) | (f.version.deprecated ? CCodeModifiers.DEPRECATED : 0);
			if (f.binding == MemberBinding.INSTANCE) {
				if (f.access == SymbolAccessibility.PRIVATE)  {
					generate_type_declaration (f.variable_type, decl_space);

					instance_priv_struct.add_field (get_ccode_name (f.variable_type), get_ccode_name (f), modifiers, get_ccode_declarator_suffix (f.variable_type));
					if (f.variable_type is ArrayType && get_ccode_array_length (f)) {
						// create fields to store array dimensions
						var array_type = (ArrayType) f.variable_type;

						if (!array_type.fixed_length) {
							var length_ctype = get_ccode_array_length_type (array_type);

							for (int dim = 1; dim <= array_type.rank; dim++) {
								string length_cname;
								if (get_ccode_array_length_name (f) != null) {
									length_cname = get_ccode_array_length_name (f);
								} else {
									length_cname = get_array_length_cname (get_ccode_name (f), dim);
								}
								instance_priv_struct.add_field (length_ctype, length_cname);
							}

							if (array_type.rank == 1 && f.is_internal_symbol ()) {
								instance_priv_struct.add_field (length_ctype, get_array_size_cname (get_ccode_name (f)));
							}
						}
					} else if (f.variable_type is DelegateType && get_ccode_delegate_target (f)) {
						var delegate_type = (DelegateType) f.variable_type;
						if (delegate_type.delegate_symbol.has_target) {
							// create field to store delegate target
							instance_priv_struct.add_field (get_ccode_name (delegate_target_type), get_ccode_delegate_target_name (f));
							if (delegate_type.is_disposable ()) {
								instance_priv_struct.add_field (get_ccode_name (delegate_target_destroy_type), get_delegate_target_destroy_notify_cname (get_ccode_name (f)));
							}
						}
					}
				}

				if (f.lock_used) {
					cl.has_private_fields = true;
					// add field for mutex
					instance_priv_struct.add_field (get_ccode_name (mutex_type), get_symbol_lock_name (get_ccode_name (f)));
				}
			} else if (f.binding == MemberBinding.CLASS) {
				if (f.access == SymbolAccessibility.PRIVATE) {
					type_priv_struct.add_field (get_ccode_name (f.variable_type), get_ccode_name (f), modifiers);
				}

				if (f.lock_used) {
					has_class_locks = true;
					// add field for mutex
					type_priv_struct.add_field (get_ccode_name (mutex_type), get_symbol_lock_name (get_ccode_name (f)));
				}
			}
		}

		foreach (Property prop in cl.get_properties ()) {
			if (prop.binding == MemberBinding.INSTANCE) {
				if (prop.lock_used) {
					cl.has_private_fields = true;
					// add field for mutex
					instance_priv_struct.add_field (get_ccode_name (mutex_type), get_symbol_lock_name (get_ccode_name (prop)));
				}
			} else if (prop.binding == MemberBinding.CLASS) {
				if (prop.lock_used) {
					has_class_locks = true;
					// add field for mutex
					type_priv_struct.add_field (get_ccode_name (mutex_type), get_symbol_lock_name (get_ccode_name (prop)));
				}
			}
		}
	}

	public override void visit_class (Class cl) {
		push_context (new EmitContext (cl));
		push_line (cl.source_reference);

		var old_param_spec_struct = param_spec_struct;
		var old_prop_enum = prop_enum;
		var old_signal_enum = signal_enum;
		var old_class_init_context = class_init_context;
		var old_base_init_context = base_init_context;
		var old_class_finalize_context = class_finalize_context;
		var old_base_finalize_context = base_finalize_context;
		var old_instance_init_context = instance_init_context;
		var old_instance_finalize_context = instance_finalize_context;

		if (get_ccode_name (cl).length < 3) {
			cl.error = true;
			Report.error (cl.source_reference, "Class name `%s' is too short".printf (get_ccode_name (cl)));
			return;
		}

		prop_enum = new CCodeEnum ();
		prop_enum.add_value (new CCodeEnumValue ("%s_0_PROPERTY".printf (get_ccode_upper_case_name (cl, null))));
		signal_enum = new CCodeEnum ();
		class_init_context = new EmitContext (cl);
		base_init_context = new EmitContext (cl);
		class_finalize_context = new EmitContext (cl);
		base_finalize_context = new EmitContext (cl);
		instance_init_context = new EmitContext (cl);
		instance_finalize_context = new EmitContext (cl);

		generate_class_struct_declaration (cl, cfile);
		generate_class_private_declaration (cl, cfile);

		if (!cl.is_internal_symbol ()) {
			generate_class_struct_declaration (cl, header_file);
		}
		if (!cl.is_private_symbol ()) {
			generate_class_struct_declaration (cl, internal_header_file);
		}

			if (cl.is_compact || cl.base_class == null || cl.base_class == gsource_type) {
				begin_instance_init_function (cl);
				begin_finalize_function (cl);
			}

		cl.accept_children (this);

			if (cl.is_compact || cl.base_class == null || cl.base_class == gsource_type) {
				add_instance_init_function (cl);
				add_finalize_function (cl);
			}

		param_spec_struct = old_param_spec_struct;
		prop_enum = old_prop_enum;
		signal_enum = old_signal_enum;
		class_init_context = old_class_init_context;
		base_init_context = old_base_init_context;
		class_finalize_context = old_class_finalize_context;
		base_finalize_context = old_base_finalize_context;
		instance_init_context = old_instance_init_context;
		instance_finalize_context = old_instance_finalize_context;

		pop_line ();
		pop_context ();
	}

	public virtual void generate_class_init (Class cl) {
	}

	public virtual void end_instance_init (Class cl) {
	}

	CCodeExpression cast_method_pointer (Method m, CCodeExpression cfunc, ObjectTypeSymbol base_type, int direction = 3) {
		// Cast the function pointer to match the interface
		string cast;
		if (direction == 1 || m.return_type.is_real_non_null_struct_type ()) {
			cast = "void (*)";
		} else {
			cast = "%s (*)".printf (get_ccode_name (m.return_type));
		}

		var vdeclarator = new CCodeFunctionDeclarator (get_ccode_vfunc_name (m));
		var cparam_map = new HashMap<int,CCodeParameter> (direct_hash, direct_equal);

		generate_cparameters (m, cfile, cparam_map, new CCodeFunction ("fake"), vdeclarator, null, null, direction);

		// append C arguments in the right order
		int last_pos = -1;
		int min_pos;
		string cast_args = "";
		while (true) {
			min_pos = -1;
			foreach (int pos in cparam_map.get_keys ()) {
				if (pos > last_pos && (min_pos == -1 || pos < min_pos)) {
					min_pos = pos;
				}
			}
			if (min_pos == -1) {
				break;
			}
			if (last_pos != -1) {
				cast_args = "%s, ".printf (cast_args);
			}
			var cparam = cparam_map.get (min_pos);
			if (cparam.ellipsis) {
				cast_args = "%s...".printf (cast_args);
			} else {
				cast_args = "%s%s".printf (cast_args, cparam.type_name);
			}
			last_pos = min_pos;
		}
		cast = "%s (%s)".printf (cast, cast_args);
		return new CCodeCastExpression (cfunc, cast);
	}

	private void begin_instance_init_function (Class cl) {
		push_context (instance_init_context);

		var func = new CCodeFunction ("%s_instance_init".printf (get_ccode_lower_case_name (cl, null)));
		func.add_parameter (new CCodeParameter ("self", "%s *".printf (get_ccode_name (cl))));
		func.modifiers = CCodeModifiers.STATIC;

		push_function (func);

		bool is_gsource = cl.base_class == gsource_type;

		if (cl.is_compact) {
			// Add declaration, since the instance_init function is explicitly called
			// by the creation methods
			cfile.add_function_declaration (func);

			// connect overridden methods
			foreach (Method m in cl.get_methods ()) {
				if (m.base_method == null || is_gsource) {
					continue;
				}
				var base_type = (ObjectTypeSymbol) m.base_method.parent_symbol;

				// there is currently no default handler for abstract async methods
				if (!m.is_abstract || !m.coroutine) {
					CCodeExpression cfunc = new CCodeIdentifier (get_ccode_real_name (m));
					cfunc = cast_method_pointer (m.base_method, cfunc, base_type, (m.coroutine ? 1 : 3));
					var ccast = new CCodeCastExpression (new CCodeIdentifier ("self"), "%s *".printf (get_ccode_name (base_type)));
					func.add_assignment (new CCodeMemberAccess.pointer (ccast, get_ccode_vfunc_name (m.base_method)), cfunc);

					if (m.coroutine) {
						cfunc = new CCodeIdentifier (get_ccode_finish_real_name (m));
						cfunc = cast_method_pointer (m.base_method, cfunc, base_type, 2);
						ccode.add_assignment (new CCodeMemberAccess.pointer (ccast, get_ccode_finish_vfunc_name (m.base_method)), cfunc);
					}
				}
			}

			// connect overridden properties
			foreach (Property prop in cl.get_properties ()) {
				if (prop.base_property == null || is_gsource) {
					continue;
				}
				var base_type = prop.base_property.parent_symbol;

				var ccast = new CCodeCastExpression (new CCodeIdentifier ("self"), "%s *".printf (get_ccode_name (base_type)));

				if (!get_ccode_no_accessor_method (prop.base_property) && !get_ccode_concrete_accessor (prop.base_property)) {
					if (prop.get_accessor != null) {
						string cname = get_ccode_real_name (prop.get_accessor);
						ccode.add_assignment (new CCodeMemberAccess.pointer (ccast, "get_%s".printf (prop.name)), new CCodeIdentifier (cname));
					}
					if (prop.set_accessor != null) {
						string cname = get_ccode_real_name (prop.set_accessor);
						ccode.add_assignment (new CCodeMemberAccess.pointer (ccast, "set_%s".printf (prop.name)), new CCodeIdentifier (cname));
					}
				}
			}
		}

		pop_context ();
	}

	private void add_instance_init_function (Class cl) {
		push_context (instance_init_context);
		end_instance_init (cl);
		pop_context ();

		cfile.add_function (instance_init_context.ccode);
	}

	private void begin_finalize_function (Class cl) {
		push_context (instance_finalize_context);

		if (cl.base_class == null) {
			var function = new CCodeFunction (get_ccode_free_function (cl), "void");
			if (cl.is_private_symbol ()) {
				function.modifiers = CCodeModifiers.STATIC;
			} else if (context.hide_internal && cl.is_internal_symbol ()) {
				function.modifiers = CCodeModifiers.INTERNAL;
			}

			function.add_parameter (new CCodeParameter ("self", "%s *".printf (get_ccode_name (cl))));

			push_function (function);
		}

		if (cl.destructor != null) {
			cl.destructor.body.emit (this);

			if (current_method_return) {
				// support return statements in destructors
				ccode.add_label ("_return");
			}
		}

		pop_context ();
	}

	private void add_finalize_function (Class cl) {
		if (cl.base_class == null) {
			CCodeFunctionCall ccall;
			if (context.profile == Profile.POSIX) {
				// free needs stdlib.h
				cfile.add_include ("stdlib.h");
				ccall = new CCodeFunctionCall (new CCodeIdentifier ("free"));
				ccall.add_argument (new CCodeIdentifier ("self"));
			} else {
				// g_slice_free needs glib.h
				cfile.add_include ("glib.h");
				ccall = new CCodeFunctionCall (new CCodeIdentifier ("g_slice_free"));
				ccall.add_argument (new CCodeIdentifier (get_ccode_name (cl)));
				ccall.add_argument (new CCodeIdentifier ("self"));
			}
			push_context (instance_finalize_context);
			ccode.add_expression (ccall);
			pop_context ();

			cfile.add_function (instance_finalize_context.ccode);
		} else if (cl.base_class == gsource_type) {
			cfile.add_function (instance_finalize_context.ccode);
		}
	}

	public override void visit_interface (Interface iface) {
	}

	public override void visit_struct (Struct st) {
		base.visit_struct (st);

		if (get_ccode_has_type_id (st)) {
			push_line (st.source_reference);
			var type_fun = new StructRegisterFunction (st);
			type_fun.init_from_type (context, false, false);
			cfile.add_type_member_definition (type_fun.get_definition ());
			pop_line ();
		}
	}

	public override void visit_enum (Enum en) {
		base.visit_enum (en);

		if (get_ccode_has_type_id (en)) {
			push_line (en.source_reference);
			var type_fun = new EnumRegisterFunction (en);
			type_fun.init_from_type (context, false, false);
			cfile.add_type_member_definition (type_fun.get_definition ());
			pop_line ();
		}
	}

	public override void visit_method_call (MethodCall expr) {
		var ma = expr.call as MemberAccess;
		var mtype = expr.call.value_type as MethodType;
		if (mtype == null || ma == null || ma.inner == null ||
			!(ma.inner.value_type is EnumValueType) || !get_ccode_has_type_id (ma.inner.value_type.type_symbol) ||
			mtype.method_symbol != ((EnumValueType) ma.inner.value_type).get_to_string_method ()) {
			base.visit_method_call (expr);
			return;
		}
	}

	public override void visit_property (Property prop) {
		var cl = current_type_symbol as Class;
		var st = current_type_symbol as Struct;

		var base_prop = prop;
		if (prop.base_property != null) {
			base_prop = prop.base_property;
		} else if (prop.base_interface_property != null) {
			base_prop = prop.base_interface_property;
		}

		if (cl != null && cl.is_compact && (prop.get_accessor == null || prop.get_accessor.automatic_body)) {
			Report.error (prop.source_reference, "Properties without accessor bodies are not supported in compact classes");
			return;
		}

		if (base_prop.get_attribute ("NoAccessorMethod") == null &&
			prop.name == "type" && ((cl != null && !cl.is_compact) || (st != null && get_ccode_has_type_id (st)))) {
			Report.error (prop.source_reference, "Property 'type' not allowed");
			return;
		}
		base.visit_property (prop);
	}
}
