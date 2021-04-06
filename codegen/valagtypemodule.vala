/* valagtypemodule.vala
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


public class Vala.GTypeModule : GErrorModule {
	public override CCodeParameter generate_parameter (Parameter param, CCodeFile decl_space, Map<int,CCodeParameter> cparam_map, Map<int,CCodeExpression>? carg_map) {
		if (!(param.variable_type is ObjectType)) {
			return base.generate_parameter (param, decl_space, cparam_map, carg_map);
		}

		generate_type_declaration (param.variable_type, decl_space);

		string ctypename = get_ccode_name (param.variable_type);

		if (param.direction != ParameterDirection.IN) {
			ctypename = "%s *".printf (ctypename);
		}

		var cparam = new CCodeParameter (get_ccode_name (param), ctypename);
		if (param.format_arg) {
			cparam.modifiers = CCodeModifiers.FORMAT_ARG;
		}

		cparam_map.set (get_param_pos (get_ccode_pos (param)), cparam);
		if (carg_map != null) {
			carg_map.set (get_param_pos (get_ccode_pos (param)), get_parameter_cexpression (param));
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

		bool is_gtypeinstance = !cl.is_compact;
		bool is_fundamental = is_gtypeinstance && cl.base_class == null;
		bool is_gsource = cl.base_class == gsource_type;

		if (is_gtypeinstance) {
			decl_space.add_include ("glib-object.h");

			decl_space.add_type_declaration (new CCodeNewline ());
			var macro = "(%s_get_type ())".printf (get_ccode_lower_case_name (cl, null));
			decl_space.add_type_declaration (new CCodeMacroReplacement (get_ccode_type_id (cl), macro));

			macro = "(G_TYPE_CHECK_INSTANCE_CAST ((obj), %s, %s))".printf (get_ccode_type_id (cl), get_ccode_name (cl));
			decl_space.add_type_declaration (new CCodeMacroReplacement ("%s(obj)".printf (get_ccode_type_cast_function (cl)), macro));

			macro = "(G_TYPE_CHECK_CLASS_CAST ((klass), %s, %s))".printf (get_ccode_type_id (cl), get_ccode_type_name (cl));
			decl_space.add_type_declaration (new CCodeMacroReplacement ("%s(klass)".printf (get_ccode_class_type_function (cl)), macro));

			macro = "(G_TYPE_CHECK_INSTANCE_TYPE ((obj), %s))".printf (get_ccode_type_id (cl));
			decl_space.add_type_declaration (new CCodeMacroReplacement ("%s(obj)".printf (get_ccode_type_check_function (cl)), macro));

			macro = "(G_TYPE_CHECK_CLASS_TYPE ((klass), %s))".printf (get_ccode_type_id (cl));
			decl_space.add_type_declaration (new CCodeMacroReplacement ("%s(klass)".printf (get_ccode_class_type_check_function (cl)), macro));

			macro = "(G_TYPE_INSTANCE_GET_CLASS ((obj), %s, %s))".printf (get_ccode_type_id (cl), get_ccode_type_name (cl));
			decl_space.add_type_declaration (new CCodeMacroReplacement ("%s(obj)".printf (get_ccode_type_get_function (cl)), macro));
			decl_space.add_type_declaration (new CCodeNewline ());
		}

		if (cl.is_compact && cl.base_class != null) {
			decl_space.add_type_declaration (new CCodeTypeDefinition (get_ccode_name (cl.base_class), new CCodeVariableDeclarator (get_ccode_name (cl))));
		} else {
			decl_space.add_type_declaration (new CCodeTypeDefinition ("struct _%s".printf (get_ccode_name (cl)), new CCodeVariableDeclarator (get_ccode_name (cl))));
		}

		if (is_fundamental) {
			var ref_fun = new CCodeFunction (get_ccode_ref_function (cl), "gpointer");
			var unref_fun = new CCodeFunction (get_ccode_unref_function (cl), "void");
			if (cl.is_private_symbol ()) {
				ref_fun.modifiers = CCodeModifiers.STATIC;
				unref_fun.modifiers = CCodeModifiers.STATIC;
			} else if (context.hide_internal && cl.is_internal_symbol ()) {
				ref_fun.modifiers = CCodeModifiers.INTERNAL;
				unref_fun.modifiers = CCodeModifiers.INTERNAL;
			}

			ref_fun.add_parameter (new CCodeParameter ("instance", "gpointer"));
			unref_fun.add_parameter (new CCodeParameter ("instance", "gpointer"));

			decl_space.add_function_declaration (ref_fun);
			decl_space.add_function_declaration (unref_fun);

			// GParamSpec and GValue functions
			var function = new CCodeFunction (get_ccode_param_spec_function (cl), "GParamSpec*");
			function.add_parameter (new CCodeParameter ("name", "const gchar*"));
			function.add_parameter (new CCodeParameter ("nick", "const gchar*"));
			function.add_parameter (new CCodeParameter ("blurb", "const gchar*"));
			function.add_parameter (new CCodeParameter ("object_type", "GType"));
			function.add_parameter (new CCodeParameter ("flags", "GParamFlags"));

			if (cl.is_private_symbol ()) {
				// avoid C warning as this function is not always used
				function.modifiers = CCodeModifiers.STATIC | CCodeModifiers.UNUSED;
			} else if (context.hide_internal && cl.is_internal_symbol ()) {
				function.modifiers = CCodeModifiers.INTERNAL;
			}

			decl_space.add_function_declaration (function);

			function = new CCodeFunction (get_ccode_set_value_function (cl), "void");
			function.add_parameter (new CCodeParameter ("value", "GValue*"));
			function.add_parameter (new CCodeParameter ("v_object", "gpointer"));

			if (cl.is_private_symbol ()) {
				// avoid C warning as this function is not always used
				function.modifiers = CCodeModifiers.STATIC | CCodeModifiers.UNUSED;
			} else if (context.hide_internal && cl.is_internal_symbol ()) {
				// avoid C warning as this function is not always used
				function.modifiers = CCodeModifiers.INTERNAL | CCodeModifiers.UNUSED;
			}

			decl_space.add_function_declaration (function);

			function = new CCodeFunction (get_ccode_take_value_function (cl), "void");
			function.add_parameter (new CCodeParameter ("value", "GValue*"));
			function.add_parameter (new CCodeParameter ("v_object", "gpointer"));

			if (cl.is_private_symbol ()) {
				// avoid C warning as this function is not always used
				function.modifiers = CCodeModifiers.STATIC | CCodeModifiers.UNUSED;
			} else if (context.hide_internal && cl.is_internal_symbol ()) {
				function.modifiers = CCodeModifiers.INTERNAL;
			}

			decl_space.add_function_declaration (function);

			function = new CCodeFunction (get_ccode_get_value_function (cl), "gpointer");
			function.add_parameter (new CCodeParameter ("value", "const GValue*"));

			if (cl.is_private_symbol ()) {
				// avoid C warning as this function is not always used
				function.modifiers = CCodeModifiers.STATIC | CCodeModifiers.UNUSED;
			} else if (context.hide_internal && cl.is_internal_symbol ()) {
				// avoid C warning as this function is not always used
				function.modifiers = CCodeModifiers.INTERNAL | CCodeModifiers.UNUSED;
			}

			decl_space.add_function_declaration (function);
		} else if (!is_gtypeinstance && !is_gsource) {
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

		if (is_gtypeinstance) {
			decl_space.add_type_declaration (new CCodeTypeDefinition ("struct _%s".printf (get_ccode_type_name (cl)), new CCodeVariableDeclarator (get_ccode_type_name (cl))));

			var type_fun = new ClassRegisterFunction (cl);
			type_fun.init_from_type (context, in_plugin, true);
			decl_space.add_type_member_declaration (type_fun.get_declaration ());
		}

		var base_class = cl;
		while (base_class.base_class != null) {
			base_class = base_class.base_class;
		}
		// Custom unref-methods need to be emitted before G_DEFINE_AUTOPTR_CLEANUP_FUNC,
		// so we guard against that special case and handle it in generate_method_declaration.
		if (!(base_class.is_compact && is_reference_counting (base_class))
		    && (!context.use_header || decl_space.is_header)) {
			string autoptr_cleanup_func;
			if (is_reference_counting (base_class)) {
				autoptr_cleanup_func = get_ccode_unref_function (base_class);
			} else {
				autoptr_cleanup_func = get_ccode_free_function (base_class);
			}
			if (autoptr_cleanup_func == null || autoptr_cleanup_func == "") {
				Report.error (cl.source_reference, "internal error: autoptr_cleanup_func not available");
			}
			decl_space.add_type_member_declaration (new CCodeIdentifier ("G_DEFINE_AUTOPTR_CLEANUP_FUNC (%s, %s)".printf (get_ccode_name (cl), autoptr_cleanup_func)));
			decl_space.add_type_member_declaration (new CCodeNewline ());
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
		foreach (DataType base_type in cl.get_base_types ()) {
			unowned Interface? iface = base_type.type_symbol as Interface;
			if (iface != null) {
				generate_interface_declaration (iface, decl_space);
			}
		}

		generate_class_declaration (cl, decl_space);

		bool is_gtypeinstance = !cl.is_compact;
		bool is_fundamental = is_gtypeinstance && cl.base_class == null;

		var instance_struct = new CCodeStruct ("_%s".printf (get_ccode_name (cl)));
		var type_struct = new CCodeStruct ("_%s".printf (get_ccode_type_name (cl)));

		if (cl.base_class != null) {
			instance_struct.add_field (get_ccode_name (cl.base_class), "parent_instance");
		} else if (is_fundamental) {
			instance_struct.add_field ("GTypeInstance", "parent_instance");
			instance_struct.add_field ("volatile int", "ref_count");
		}

		if (is_gtypeinstance) {
			decl_space.add_type_declaration (new CCodeTypeDefinition ("struct %sPrivate".printf (instance_struct.name), new CCodeVariableDeclarator ("%sPrivate".printf (get_ccode_name (cl)))));

			if (!context.abi_stability) {
				instance_struct.add_field ("%sPrivate *".printf (get_ccode_name (cl)), "priv");
			}
			if (is_fundamental) {
				type_struct.add_field ("GTypeClass", "parent_class");
			} else {
				type_struct.add_field (get_ccode_type_name (cl.base_class), "parent_class");
			}

			if (is_fundamental) {
				type_struct.add_field ("void", "(*finalize) (%s *self)".printf (get_ccode_name (cl)));
			}
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
					if (s.access != SymbolAccessibility.PRIVATE) {
						generate_struct_field_declaration ((Field) s, instance_struct, type_struct, decl_space, ref has_struct_member);
					}
				} else {
					Report.error (s.source_reference, "internal: Unsupported symbol");
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
				if (f.access != SymbolAccessibility.PRIVATE) {
					generate_struct_field_declaration (f, instance_struct, type_struct, decl_space, ref has_struct_member);
				}
			}
		}

		if (cl.is_compact && cl.base_class == null && !has_struct_member) {
			// add dummy member, C doesn't allow empty structs
			instance_struct.add_field ("int", "dummy");
		}

		if (!cl.is_compact || cl.base_class == null) {
			// derived compact classes do not have a struct
			decl_space.add_type_definition (instance_struct);
		}

		if (is_gtypeinstance) {
			if (context.abi_stability) {
				instance_struct.add_field ("%sPrivate *".printf (get_ccode_name (cl)), "priv");
			}
			decl_space.add_type_definition (type_struct);
		}
	}

	void generate_struct_method_declaration (ObjectTypeSymbol type_sym, Method m, CCodeStruct instance_struct, CCodeStruct type_struct, CCodeFile decl_space, ref bool has_struct_member) {
		unowned Class? cl = type_sym as Class;
		if (type_sym is Interface || (cl != null && !cl.is_compact)) {
			generate_virtual_method_declaration (m, decl_space, type_struct);
		} else if (cl != null && cl.is_compact && cl.base_class == null) {
			generate_virtual_method_declaration (m, decl_space, instance_struct);
			has_struct_member |= (m.is_abstract || m.is_virtual);
		}
	}

	void generate_struct_property_declaration (ObjectTypeSymbol type_sym, Property prop, CCodeStruct instance_struct, CCodeStruct type_struct, CCodeFile decl_space, ref bool has_struct_member) {
		if (!prop.is_abstract && !prop.is_virtual) {
			return;
		}
		generate_type_declaration (prop.property_type, decl_space);

		unowned ObjectTypeSymbol t = (ObjectTypeSymbol) prop.parent_symbol;
		unowned Class? cl = type_sym as Class;

		var this_type = new ObjectType (t);
		var cselfparam = new CCodeParameter ("self", get_ccode_name (this_type));

		if (prop.get_accessor != null) {
			var vdeclarator = new CCodeFunctionDeclarator ("get_%s".printf (prop.name));
			vdeclarator.add_parameter (cselfparam);
			var creturn_type = get_callable_creturn_type (prop.get_accessor.get_method ());
			if (prop.property_type.is_real_non_null_struct_type ()) {
				var cvalueparam = new CCodeParameter ("result", "%s *".printf (get_ccode_name (prop.get_accessor.value_type)));
				vdeclarator.add_parameter (cvalueparam);
			}

			var array_type = prop.property_type as ArrayType;
			if (array_type != null && get_ccode_array_length (prop)) {
				var length_ctype = get_ccode_array_length_type (prop) + "*";
				for (int dim = 1; dim <= array_type.rank; dim++) {
					vdeclarator.add_parameter (new CCodeParameter (get_array_length_cname ("result", dim), length_ctype));
				}
			} else if ((prop.property_type is DelegateType) && get_ccode_delegate_target (prop) && ((DelegateType) prop.property_type).delegate_symbol.has_target) {
				vdeclarator.add_parameter (new CCodeParameter (get_delegate_target_cname ("result"), "gpointer*"));
			}

			var vdecl = new CCodeDeclaration (get_ccode_name (creturn_type));
			vdecl.add_declarator (vdeclarator);
			type_struct.add_declaration (vdecl);

			if (cl != null && cl.is_compact && cl.base_class == null) {
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
			if (array_type != null && get_ccode_array_length (prop)) {
				var length_ctype = get_ccode_array_length_type (prop);
				for (int dim = 1; dim <= array_type.rank; dim++) {
					vdeclarator.add_parameter (new CCodeParameter (get_array_length_cname ("value", dim), length_ctype));
				}
			} else if ((prop.property_type is DelegateType) && get_ccode_delegate_target (prop) && ((DelegateType) prop.property_type).delegate_symbol.has_target) {
				vdeclarator.add_parameter (new CCodeParameter (get_delegate_target_cname ("value"), "gpointer"));
				if (prop.set_accessor.value_type.value_owned) {
					vdeclarator.add_parameter (new CCodeParameter (get_delegate_target_destroy_notify_cname ("value"), get_ccode_name (delegate_target_destroy_type)));
				}
			}

			var vdecl = new CCodeDeclaration ("void");
			vdecl.add_declarator (vdeclarator);
			type_struct.add_declaration (vdecl);

			if (cl != null && cl.is_compact && cl.base_class == null) {
				instance_struct.add_declaration (vdecl);
				has_struct_member = true;
			}
		}
	}

	void generate_struct_field_declaration (Field f, CCodeStruct instance_struct, CCodeStruct type_struct, CCodeFile decl_space, ref bool has_struct_member) {
		CCodeModifiers modifiers = (f.is_volatile ? CCodeModifiers.VOLATILE : 0) | (f.version.deprecated ? CCodeModifiers.DEPRECATED : 0);
		if (f.binding == MemberBinding.INSTANCE) {
			append_field (instance_struct, f, decl_space);
			has_struct_member = true;
		} else if (f.binding == MemberBinding.CLASS) {
			type_struct.add_field (get_ccode_name (f.variable_type), get_ccode_name (f), modifiers);
		}
	}

	public override bool generate_method_declaration (Method m, CCodeFile decl_space) {
		if (base.generate_method_declaration (m, decl_space)) {
			// Custom unref-methods need to be emitted before G_DEFINE_AUTOPTR_CLEANUP_FUNC,
			// in addition to the non-ref-countable case in generate_class_declaration.
			unowned Class? cl = m.parent_symbol as Class;
			if (cl != null && cl.is_compact && get_ccode_unref_function (cl) == get_ccode_name (m)
			    && (!context.use_header || decl_space.is_header)) {
				decl_space.add_type_member_declaration (new CCodeIdentifier ("G_DEFINE_AUTOPTR_CLEANUP_FUNC (%s, %s)".printf (get_ccode_name (cl), get_ccode_name (m))));
				decl_space.add_type_member_declaration (new CCodeNewline ());
			}

			return true;
		}

		return false;
	}

	public virtual void generate_virtual_method_declaration (Method m, CCodeFile decl_space, CCodeStruct type_struct) {
		if (!m.is_abstract && !m.is_virtual) {
			return;
		}

		var creturn_type = get_callable_creturn_type (m);

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

		bool is_gtypeinstance = !cl.is_compact;
		bool has_class_locks = false;

		var instance_priv_struct = new CCodeStruct ("_%sPrivate".printf (get_ccode_name (cl)));
		var type_priv_struct = new CCodeStruct ("_%sPrivate".printf (get_ccode_type_name (cl)));

		if (is_gtypeinstance) {
			/* create type, dup_func, and destroy_func fields for generic types */
			foreach (TypeParameter type_param in cl.get_type_parameters ()) {
				string func_name;

				func_name = "%s_type".printf (type_param.name.ascii_down ());
				instance_priv_struct.add_field ("GType", func_name);

				func_name = "%s_dup_func".printf (type_param.name.ascii_down ());
				instance_priv_struct.add_field ("GBoxedCopyFunc", func_name);

				func_name = "%s_destroy_func".printf (type_param.name.ascii_down ());
				instance_priv_struct.add_field ("GDestroyNotify", func_name);
			}
		}

		bool has_struct_member = false;
		foreach (Field f in cl.get_fields ()) {
			if (f.access == SymbolAccessibility.PRIVATE) {
				generate_struct_field_declaration (f, instance_priv_struct, type_priv_struct, decl_space, ref has_struct_member);
			}
			if (f.lock_used) {
				if (f.binding == MemberBinding.INSTANCE) {
					cl.has_private_fields = true;
					// add field for mutex
					instance_priv_struct.add_field (get_ccode_name (mutex_type), get_symbol_lock_name (get_ccode_name (f)));
				} else if (f.binding == MemberBinding.CLASS) {
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

		if (is_gtypeinstance) {
			if (cl.has_class_private_fields || has_class_locks) {
				decl_space.add_type_declaration (new CCodeTypeDefinition ("struct %s".printf (type_priv_struct.name), new CCodeVariableDeclarator ("%sPrivate".printf (get_ccode_type_name (cl)))));
			}

			/* only add the *Private struct if it is not empty, i.e. we actually have private data */
			if (cl.has_private_fields || cl.has_type_parameters ()) {
				decl_space.add_type_definition (instance_priv_struct);

				var parent_decl = new CCodeDeclaration ("gint");
				var parent_var_decl = new CCodeVariableDeclarator ("%s_private_offset".printf (get_ccode_name (cl)));
				parent_decl.add_declarator (parent_var_decl);
				parent_decl.modifiers = CCodeModifiers.STATIC;
				cfile.add_type_member_declaration (parent_decl);

				var function = new CCodeFunction ("%s_get_instance_private".printf (get_ccode_lower_case_name (cl, null)), "gpointer");
				function.modifiers = CCodeModifiers.STATIC | CCodeModifiers.INLINE;
				function.add_parameter (new CCodeParameter ("self", "%s*".printf (get_ccode_name (cl))));

				push_function (function);

				function.block = new CCodeBlock ();
				var ccall = new CCodeFunctionCall (new CCodeIdentifier ("G_STRUCT_MEMBER_P"));
				ccall.add_argument (new CCodeIdentifier ("self"));
				ccall.add_argument (new CCodeIdentifier ("%s_private_offset".printf (get_ccode_name (cl))));
				function.block.add_statement (new CCodeReturnStatement (ccall));

				pop_function ();
				cfile.add_function (function);
			}

			if (cl.has_class_private_fields || has_class_locks) {
				decl_space.add_type_definition (type_priv_struct);

				string macro = "(G_TYPE_CLASS_GET_PRIVATE (klass, %s, %sPrivate))".printf (get_ccode_type_id (cl), get_ccode_type_name (cl));
				decl_space.add_type_member_declaration (new CCodeMacroReplacement ("%s(klass)".printf (get_ccode_class_get_private_function (cl)), macro));
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

		bool is_gtypeinstance = !cl.is_compact;
		bool is_gobject = is_gtypeinstance && cl.is_subtype_of (gobject_type);
		bool is_fundamental = is_gtypeinstance && cl.base_class == null;

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

		var last_prop = "%s_NUM_PROPERTIES".printf (get_ccode_upper_case_name (cl));
		if (is_gobject) {
			cfile.add_type_declaration (prop_enum);

			var prop_array_decl = new CCodeDeclaration ("GParamSpec*");
			prop_array_decl.modifiers |= CCodeModifiers.STATIC;
			prop_array_decl.add_declarator (new CCodeVariableDeclarator ("%s_properties".printf (get_ccode_lower_case_name (cl)), null, new CCodeDeclaratorSuffix.with_array (new CCodeIdentifier (last_prop))));
			cfile.add_type_declaration (prop_array_decl);
		}

		if (!cl.is_internal_symbol ()) {
			generate_class_struct_declaration (cl, header_file);
		}
		if (!cl.is_private_symbol ()) {
			generate_class_struct_declaration (cl, internal_header_file);
		}

		if (is_gtypeinstance) {
			begin_base_init_function (cl);
			begin_class_init_function (cl);
			begin_instance_init_function (cl);

			begin_base_finalize_function (cl);
			begin_class_finalize_function (cl);
			begin_finalize_function (cl);
		} else {
			if (cl.is_compact || cl.base_class == null || cl.base_class == gsource_type) {
				begin_instance_init_function (cl);
				begin_finalize_function (cl);
			}
		}

		cl.accept_children (this);

		if (is_gtypeinstance) {
			if (is_fundamental) {
				param_spec_struct = new CCodeStruct ( "_%sParamSpec%s".printf(get_ccode_prefix (cl.parent_symbol), cl.name));
				param_spec_struct.add_field ("GParamSpec", "parent_instance");
				cfile.add_type_definition (param_spec_struct);

				cfile.add_type_declaration (new CCodeTypeDefinition ("struct %s".printf (param_spec_struct.name), new CCodeVariableDeclarator ( "%sParamSpec%s".printf(get_ccode_prefix (cl.parent_symbol), cl.name))));

				add_type_value_table_init_function (cl);
				add_type_value_table_free_function (cl);
				add_type_value_table_copy_function (cl);
				add_type_value_table_peek_pointer_function (cl);
				add_type_value_table_collect_value_function (cl);
				add_type_value_table_lcopy_value_function (cl);
				add_g_param_spec_type_function (cl);
				add_g_value_get_function (cl);
				add_g_value_set_function (cl);
				add_g_value_take_function (cl);

				var ref_count = new CCodeAssignment (new CCodeMemberAccess.pointer (new CCodeIdentifier ("self"), "ref_count"), new CCodeConstant ("1"));
				push_context (instance_init_context);
				ccode.add_expression (ref_count);
				pop_context ();
			}

			if (is_gobject) {
				prop_enum.add_value (new CCodeEnumValue (last_prop));
			}

			if (cl.get_signals ().size > 0) {
				var last_signal = "%s_NUM_SIGNALS".printf (get_ccode_upper_case_name (cl));
				signal_enum.add_value (new CCodeEnumValue (last_signal));
				cfile.add_type_declaration (signal_enum);

				var signal_array_decl = new CCodeDeclaration ("guint");
				signal_array_decl.modifiers |= CCodeModifiers.STATIC;
				signal_array_decl.add_declarator (new CCodeVariableDeclarator ("%s_signals".printf (get_ccode_lower_case_name (cl)), new CCodeConstant ("{0}"), new CCodeDeclaratorSuffix.with_array (new CCodeIdentifier (last_signal))));
				cfile.add_type_declaration (signal_array_decl);
			}


			if (cl.class_constructor != null) {
				add_base_init_function (cl);
			}
			add_class_init_function (cl);

			if (cl.class_destructor != null) {
				add_base_finalize_function (cl);
			}

			if (cl.static_destructor != null) {
				add_class_finalize_function (cl);
			}

			foreach (DataType base_type in cl.get_base_types ()) {
				if (base_type.type_symbol is Interface) {
					add_interface_init_function (cl, (Interface) base_type.type_symbol);
				}
			}

			add_instance_init_function (cl);

			if (!cl.is_compact && (cl.get_fields ().size > 0 || cl.destructor != null || cl.is_fundamental ())) {
				add_finalize_function (cl);
			}

			if (cl.comment != null) {
				cfile.add_type_member_definition (new CCodeComment (cl.comment.content));
			}

			var type_fun = new ClassRegisterFunction (cl);
			type_fun.init_from_type (context, in_plugin, false);
			cfile.add_type_member_declaration (type_fun.get_source_declaration ());
			cfile.add_type_member_definition (type_fun.get_definition ());

			if (is_fundamental) {
				var ref_count = new CCodeMemberAccess.pointer (new CCodeIdentifier ("self"), "ref_count");

				// ref function
				var ref_fun = new CCodeFunction (get_ccode_ref_function (cl), "gpointer");
				ref_fun.add_parameter (new CCodeParameter ("instance", "gpointer"));
				if (cl.is_private_symbol ()) {
					ref_fun.modifiers = CCodeModifiers.STATIC;
				} else if (context.hide_internal && cl.is_internal_symbol ()) {
					ref_fun.modifiers = CCodeModifiers.INTERNAL;
				}
				push_function (ref_fun);

				ccode.add_declaration ("%s *".printf (get_ccode_name (cl)), new CCodeVariableDeclarator ("self", new CCodeIdentifier ("instance")));
				var ccall = new CCodeFunctionCall (new CCodeIdentifier ("g_atomic_int_inc"));
				ccall.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, ref_count));
				ccode.add_expression (ccall);
				ccode.add_return (new CCodeIdentifier ("instance"));

				pop_function ();
				cfile.add_function (ref_fun);

				// unref function
				var unref_fun = new CCodeFunction (get_ccode_unref_function (cl), "void");
				unref_fun.add_parameter (new CCodeParameter ("instance", "gpointer"));
				if (cl.is_private_symbol ()) {
					unref_fun.modifiers = CCodeModifiers.STATIC;
				} else if (context.hide_internal && cl.is_internal_symbol ()) {
					unref_fun.modifiers = CCodeModifiers.INTERNAL;
				}
				push_function (unref_fun);

				ccode.add_declaration ("%s *".printf (get_ccode_name (cl)), new CCodeVariableDeclarator ("self", new CCodeIdentifier ("instance")));
				ccall = new CCodeFunctionCall (new CCodeIdentifier ("g_atomic_int_dec_and_test"));
				ccall.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, ref_count));
				ccode.open_if (ccall);

				var get_class = new CCodeFunctionCall (new CCodeIdentifier (get_ccode_type_get_function (cl)));
				get_class.add_argument (new CCodeIdentifier ("self"));

				// finalize class
				var ccast = new CCodeFunctionCall (new CCodeIdentifier (get_ccode_type_get_function (cl)));
				ccast.add_argument (new CCodeIdentifier ("self"));
				ccall = new CCodeFunctionCall (new CCodeMemberAccess.pointer (ccast, "finalize"));
				ccall.add_argument (new CCodeIdentifier ("self"));
				ccode.add_expression (ccall);

				// free type instance
				var free = new CCodeFunctionCall (new CCodeIdentifier ("g_type_free_instance"));
				free.add_argument (new CCodeCastExpression (new CCodeIdentifier ("self"), "GTypeInstance *"));
				ccode.add_expression (free);

				ccode.close ();
				pop_function ();
				cfile.add_function (unref_fun);
			}
		} else {
			if (cl.is_compact || cl.base_class == null || cl.base_class == gsource_type) {
				add_instance_init_function (cl);
				add_finalize_function (cl);
			}
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

	private void add_type_value_table_init_function (Class cl) {
		var function = new CCodeFunction ("%s_init".printf (get_ccode_lower_case_name (cl, "value_")), "void");
		function.add_parameter (new CCodeParameter ("value", "GValue*"));
		function.modifiers = CCodeModifiers.STATIC;

		push_function (function);
		ccode.add_assignment (new CCodeMemberAccess (new CCodeMemberAccess.pointer (new CCodeIdentifier ("value"), "data[0]"), "v_pointer"), new CCodeConstant ("NULL"));
		pop_function ();
		cfile.add_function (function);
	}

	private void add_type_value_table_free_function (Class cl) {
		var function = new CCodeFunction ("%s_free_value".printf (get_ccode_lower_case_name (cl, "value_")), "void");
		function.add_parameter (new CCodeParameter ("value", "GValue*"));
		function.modifiers = CCodeModifiers.STATIC;

		push_function (function);

		var vpointer = new CCodeMemberAccess(new CCodeMemberAccess.pointer (new CCodeIdentifier ("value"), "data[0]"),"v_pointer");
		var ccall = new CCodeFunctionCall (new CCodeIdentifier (get_ccode_unref_function (cl)));
		ccall.add_argument (vpointer);

		ccode.open_if (vpointer);
		ccode.add_expression (ccall);
		ccode.close ();

		pop_function ();
		cfile.add_function (function);
	}

	private void add_type_value_table_copy_function (Class cl) {
		var function = new CCodeFunction ("%s_copy_value".printf (get_ccode_lower_case_name (cl, "value_")), "void");
		function.add_parameter (new CCodeParameter ("src_value", "const GValue*"));
		function.add_parameter (new CCodeParameter ("dest_value", "GValue*"));
		function.modifiers = CCodeModifiers.STATIC;

		push_function (function);

		var dest_vpointer = new CCodeMemberAccess (new CCodeMemberAccess.pointer (new CCodeIdentifier ("dest_value"), "data[0]"), "v_pointer");
		var src_vpointer = new CCodeMemberAccess (new CCodeMemberAccess.pointer (new CCodeIdentifier ("src_value"), "data[0]"), "v_pointer");

		var ref_ccall = new CCodeFunctionCall (new CCodeIdentifier (get_ccode_ref_function (cl)));
		ref_ccall.add_argument ( src_vpointer );

		ccode.open_if (src_vpointer);
		ccode.add_assignment (dest_vpointer, ref_ccall);
		ccode.add_else ();
		ccode.add_assignment (dest_vpointer, new CCodeConstant ("NULL"));
		ccode.close ();

		pop_function ();
		cfile.add_function (function);
	}

	private void add_type_value_table_peek_pointer_function (Class cl) {
		var function = new CCodeFunction ("%s_peek_pointer".printf (get_ccode_lower_case_name (cl, "value_")), "gpointer");
		function.add_parameter (new CCodeParameter ("value", "const GValue*"));
		function.modifiers = CCodeModifiers.STATIC;

		push_function (function);

		var vpointer = new CCodeMemberAccess (new CCodeMemberAccess.pointer (new CCodeIdentifier ("value"), "data[0]"), "v_pointer");
		ccode.add_return (vpointer);

		pop_function ();
		cfile.add_function (function);
	}

	private void add_type_value_table_lcopy_value_function ( Class cl ) {
		// Required for GTypeCValue
		cfile.add_include ("gobject/gvaluecollector.h");

		var function = new CCodeFunction ("%s_lcopy_value".printf (get_ccode_lower_case_name (cl, "value_")), "gchar*");
		function.add_parameter (new CCodeParameter ("value", "const GValue*"));
		function.add_parameter (new CCodeParameter ("n_collect_values", "guint"));
		function.add_parameter (new CCodeParameter ("collect_values", "GTypeCValue*"));
		function.add_parameter (new CCodeParameter ("collect_flags", "guint"));
		function.modifiers = CCodeModifiers.STATIC;

		var vpointer = new CCodeMemberAccess (new CCodeMemberAccess.pointer (new CCodeIdentifier ("value"), "data[0]"), "v_pointer");
		var object_p_ptr = new CCodeIdentifier ("*object_p");
		var null_ = new CCodeConstant ("NULL");

		push_function (function);

		ccode.add_declaration ("%s **".printf (get_ccode_name (cl)), new CCodeVariableDeclarator ("object_p", new CCodeMemberAccess (new CCodeIdentifier ("collect_values[0]"), "v_pointer")));

		var value_type_name_fct = new CCodeFunctionCall (new CCodeIdentifier ("G_VALUE_TYPE_NAME"));
		value_type_name_fct.add_argument (new CCodeConstant ("value"));

		var assert_condition = new CCodeUnaryExpression (CCodeUnaryOperator.LOGICAL_NEGATION, new CCodeIdentifier ("object_p"));
		ccode.open_if (assert_condition);
		var assert_printf = new CCodeFunctionCall (new CCodeIdentifier ("g_strdup_printf"));
		assert_printf.add_argument (new CCodeConstant ("\"value location for `%s' passed as NULL\""));
		assert_printf.add_argument (value_type_name_fct);
		ccode.add_return (assert_printf);
		ccode.close ();

		var main_condition = new CCodeUnaryExpression (CCodeUnaryOperator.LOGICAL_NEGATION, vpointer);
		var main_else_if_condition = new CCodeBinaryExpression (CCodeBinaryOperator.BITWISE_AND, new CCodeIdentifier ("collect_flags"), new CCodeIdentifier ("G_VALUE_NOCOPY_CONTENTS"));
		var ref_fct = new CCodeFunctionCall (new CCodeIdentifier (get_ccode_ref_function (cl)));
		ref_fct.add_argument (vpointer);
		ccode.open_if (main_condition);
		ccode.add_assignment (object_p_ptr, null_);
		ccode.else_if (main_else_if_condition);
		ccode.add_assignment (object_p_ptr, vpointer);
		ccode.add_else ();
		ccode.add_assignment (object_p_ptr, ref_fct);
		ccode.close ();

		ccode.add_return (null_);
		pop_function ();
		cfile.add_function (function);
	}

	private void add_type_value_table_collect_value_function (Class cl) {
		// Required for GTypeCValue
		cfile.add_include ("gobject/gvaluecollector.h");

		var function = new CCodeFunction ("%s_collect_value".printf (get_ccode_lower_case_name (cl, "value_")), "gchar*");
		function.add_parameter (new CCodeParameter ("value", "GValue*"));
		function.add_parameter (new CCodeParameter ("n_collect_values", "guint"));
		function.add_parameter (new CCodeParameter ("collect_values", "GTypeCValue*"));
		function.add_parameter (new CCodeParameter ("collect_flags", "guint"));
		function.modifiers = CCodeModifiers.STATIC;

		var vpointer = new CCodeMemberAccess (new CCodeMemberAccess.pointer (new CCodeIdentifier ("value"), "data[0]"), "v_pointer");

		push_function (function);

		var collect_vpointer = new CCodeMemberAccess (new CCodeIdentifier ("collect_values[0]"), "v_pointer");

		ccode.open_if (collect_vpointer);
		ccode.add_declaration ("%s *".printf (get_ccode_name (cl)), new CCodeVariableDeclarator ("object", collect_vpointer));
		var obj_identifier = new CCodeIdentifier ("object");
		var l_expression = new CCodeMemberAccess (new CCodeMemberAccess.pointer (obj_identifier, "parent_instance"), "g_class");
		var sub_condition = new CCodeBinaryExpression (CCodeBinaryOperator.EQUALITY, l_expression, new CCodeConstant ("NULL"));
		var value_type_name_fct = new CCodeFunctionCall (new CCodeIdentifier ("G_VALUE_TYPE_NAME"));
		value_type_name_fct.add_argument (new CCodeConstant ("value"));

		ccode.open_if (sub_condition);
		var true_return = new CCodeFunctionCall (new CCodeIdentifier ("g_strconcat"));
		true_return.add_argument (new CCodeConstant ("\"invalid unclassed object pointer for value type `\""));
		true_return.add_argument (value_type_name_fct);
		true_return.add_argument (new CCodeConstant ("\"'\""));
		true_return.add_argument (new CCodeConstant ("NULL"));
		ccode.add_return (true_return);

		var reg_call = new CCodeFunctionCall (new CCodeIdentifier ("g_value_type_compatible"));
		var type_check = new CCodeFunctionCall (new CCodeIdentifier ("G_TYPE_FROM_INSTANCE"));
		type_check.add_argument (new CCodeIdentifier ("object"));
		reg_call.add_argument (type_check);
		var stored_type = new CCodeFunctionCall (new CCodeIdentifier ("G_VALUE_TYPE"));
		stored_type.add_argument (new CCodeIdentifier ("value"));
		reg_call.add_argument (stored_type);

		ccode.else_if (new CCodeUnaryExpression (CCodeUnaryOperator.LOGICAL_NEGATION, reg_call));
		var false_return = new CCodeFunctionCall (new CCodeIdentifier ("g_strconcat"));
		var type_name_fct = new CCodeFunctionCall (new CCodeIdentifier ("g_type_name"));
		type_name_fct.add_argument (type_check);
		false_return.add_argument (new CCodeConstant ("\"invalid object type `\""));
		false_return.add_argument (type_name_fct);
		false_return.add_argument (new CCodeConstant ("\"' for value type `\""));
		false_return.add_argument (value_type_name_fct);
		false_return.add_argument (new CCodeConstant ("\"'\""));
		false_return.add_argument (new CCodeConstant ("NULL"));
		ccode.add_return (false_return);

		ccode.close ();

		var ref_call = new CCodeFunctionCall (new CCodeIdentifier (get_ccode_ref_function (cl)));
		ref_call.add_argument (new CCodeIdentifier ("object"));
		ccode.add_assignment (vpointer, ref_call);

		ccode.add_else ();
		ccode.add_assignment (vpointer, new CCodeConstant ("NULL"));

		ccode.close ();

		ccode.add_return (new CCodeConstant ("NULL"));

		pop_function ();
		cfile.add_function (function);
	}

	private void add_g_param_spec_type_function (Class cl) {
		var function = new CCodeFunction (get_ccode_param_spec_function (cl), "GParamSpec*");
		function.add_parameter (new CCodeParameter ("name", "const gchar*"));
		function.add_parameter (new CCodeParameter ("nick", "const gchar*"));
		function.add_parameter (new CCodeParameter ("blurb", "const gchar*"));
		function.add_parameter (new CCodeParameter ("object_type", "GType"));
		function.add_parameter (new CCodeParameter ("flags", "GParamFlags"));

		if (cl.is_private_symbol ()) {
			function.modifiers = CCodeModifiers.STATIC;
		} else if (context.hide_internal && cl.is_internal_symbol ()) {
			function.modifiers = CCodeModifiers.INTERNAL;
		}

		push_function (function);

		ccode.add_declaration ("%sParamSpec%s*".printf (get_ccode_prefix (cl.parent_symbol), cl.name), new CCodeVariableDeclarator ("spec"));

		var subccall = new CCodeFunctionCall (new CCodeIdentifier ("g_type_is_a"));
		subccall.add_argument (new CCodeIdentifier ("object_type"));
		subccall.add_argument (new CCodeIdentifier ( get_ccode_type_id (cl) ));

		var ccall = new CCodeFunctionCall (new CCodeIdentifier ("g_return_val_if_fail"));
		ccall.add_argument (subccall);
		ccall.add_argument (new CCodeConstant ("NULL"));
		ccode.add_expression (ccall);

		ccall = new CCodeFunctionCall (new CCodeIdentifier ("g_param_spec_internal"));
		ccall.add_argument (new CCodeIdentifier ( "G_TYPE_PARAM_OBJECT" ));
		ccall.add_argument (new CCodeIdentifier ("name"));
		ccall.add_argument (new CCodeIdentifier ("nick"));
		ccall.add_argument (new CCodeIdentifier ("blurb"));
		ccall.add_argument (new CCodeIdentifier ("flags"));

		ccode.add_assignment (new CCodeIdentifier ("spec"), ccall);

		ccall = new CCodeFunctionCall (new CCodeIdentifier ("G_PARAM_SPEC"));
		ccall.add_argument (new CCodeIdentifier ("spec"));

		ccode.add_assignment (new CCodeMemberAccess.pointer (ccall, "value_type"), new CCodeIdentifier ("object_type"));
		ccode.add_return (ccall);

		pop_function ();
		cfile.add_function (function);
	}

	private void add_g_value_set_function (Class cl) {
		var function = new CCodeFunction (get_ccode_set_value_function (cl), "void");
		function.add_parameter (new CCodeParameter ("value", "GValue*"));
		function.add_parameter (new CCodeParameter ("v_object", "gpointer"));

		if (cl.is_private_symbol ()) {
			function.modifiers = CCodeModifiers.STATIC;
		} else if (context.hide_internal && cl.is_internal_symbol ()) {
			function.modifiers = CCodeModifiers.INTERNAL;
		}

		var vpointer = new CCodeMemberAccess (new CCodeMemberAccess.pointer (new CCodeIdentifier ("value"), "data[0]"), "v_pointer");

		push_function (function);

		ccode.add_declaration ("%s *".printf (get_ccode_name (cl)), new CCodeVariableDeclarator ("old"));

		var ccall_typecheck = new CCodeFunctionCall (new CCodeIdentifier ("G_TYPE_CHECK_VALUE_TYPE"));
		ccall_typecheck.add_argument (new CCodeIdentifier ( "value" ));
		ccall_typecheck.add_argument (new CCodeIdentifier ( get_ccode_type_id (cl) ));

		var ccall = new CCodeFunctionCall (new CCodeIdentifier ("g_return_if_fail"));
		ccall.add_argument (ccall_typecheck);
		ccode.add_expression (ccall);

		ccode.add_assignment (new CCodeConstant ("old"), vpointer);

		ccode.open_if (new CCodeIdentifier ("v_object"));
		ccall_typecheck = new CCodeFunctionCall (new CCodeIdentifier ("G_TYPE_CHECK_INSTANCE_TYPE"));
		ccall_typecheck.add_argument (new CCodeIdentifier ( "v_object" ));
		ccall_typecheck.add_argument (new CCodeIdentifier ( get_ccode_type_id (cl) ));

		ccall = new CCodeFunctionCall (new CCodeIdentifier ("g_return_if_fail"));
		ccall.add_argument (ccall_typecheck);
		ccode.add_expression (ccall);

		var ccall_typefrominstance = new CCodeFunctionCall (new CCodeIdentifier ("G_TYPE_FROM_INSTANCE"));
		ccall_typefrominstance.add_argument (new CCodeIdentifier ( "v_object" ));

		var ccall_gvaluetype = new CCodeFunctionCall (new CCodeIdentifier ("G_VALUE_TYPE"));
		ccall_gvaluetype.add_argument (new CCodeIdentifier ( "value" ));

		var ccall_typecompatible = new CCodeFunctionCall (new CCodeIdentifier ("g_value_type_compatible"));
		ccall_typecompatible.add_argument (ccall_typefrominstance);
		ccall_typecompatible.add_argument (ccall_gvaluetype);

		ccall = new CCodeFunctionCall (new CCodeIdentifier ("g_return_if_fail"));
		ccall.add_argument (ccall_typecompatible);
		ccode.add_expression (ccall);

		ccode.add_assignment (vpointer, new CCodeConstant ("v_object"));

		ccall = new CCodeFunctionCall (new CCodeIdentifier (get_ccode_ref_function (cl)));
		ccall.add_argument (vpointer);
		ccode.add_expression (ccall);

		ccode.add_else ();
		ccode.add_assignment (vpointer, new CCodeConstant ("NULL"));
		ccode.close ();

		ccode.open_if (new CCodeIdentifier ("old"));
		ccall = new CCodeFunctionCall (new CCodeIdentifier (get_ccode_unref_function (cl)));
		ccall.add_argument (new CCodeIdentifier ("old"));
		ccode.add_expression (ccall);
		ccode.close ();

		pop_function ();
		cfile.add_function (function);
	}

	private void add_g_value_take_function (Class cl) {
		var function = new CCodeFunction (get_ccode_take_value_function (cl), "void");
		function.add_parameter (new CCodeParameter ("value", "GValue*"));
		function.add_parameter (new CCodeParameter ("v_object", "gpointer"));

		if (cl.is_private_symbol ()) {
			function.modifiers = CCodeModifiers.STATIC;
		} else if (context.hide_internal && cl.is_internal_symbol ()) {
			function.modifiers = CCodeModifiers.INTERNAL;
		}

		var vpointer = new CCodeMemberAccess(new CCodeMemberAccess.pointer (new CCodeIdentifier ("value"), "data[0]"),"v_pointer");

		push_function (function);

		ccode.add_declaration ("%s *".printf (get_ccode_name (cl)), new CCodeVariableDeclarator ("old"));

		var ccall_typecheck = new CCodeFunctionCall (new CCodeIdentifier ("G_TYPE_CHECK_VALUE_TYPE"));
		ccall_typecheck.add_argument (new CCodeIdentifier ( "value" ));
		ccall_typecheck.add_argument (new CCodeIdentifier ( get_ccode_type_id (cl) ));

		var ccall = new CCodeFunctionCall (new CCodeIdentifier ("g_return_if_fail"));
		ccall.add_argument (ccall_typecheck);
		ccode.add_expression (ccall);

		ccode.add_assignment (new CCodeConstant ("old"), vpointer);

		ccode.open_if (new CCodeIdentifier ("v_object"));

		ccall_typecheck = new CCodeFunctionCall (new CCodeIdentifier ("G_TYPE_CHECK_INSTANCE_TYPE"));
		ccall_typecheck.add_argument (new CCodeIdentifier ( "v_object" ));
		ccall_typecheck.add_argument (new CCodeIdentifier ( get_ccode_type_id (cl) ));

		ccall = new CCodeFunctionCall (new CCodeIdentifier ("g_return_if_fail"));
		ccall.add_argument (ccall_typecheck);
		ccode.add_expression (ccall);

		var ccall_typefrominstance = new CCodeFunctionCall (new CCodeIdentifier ("G_TYPE_FROM_INSTANCE"));
		ccall_typefrominstance.add_argument (new CCodeIdentifier ( "v_object" ));

		var ccall_gvaluetype = new CCodeFunctionCall (new CCodeIdentifier ("G_VALUE_TYPE"));
		ccall_gvaluetype.add_argument (new CCodeIdentifier ( "value" ));

		var ccall_typecompatible = new CCodeFunctionCall (new CCodeIdentifier ("g_value_type_compatible"));
		ccall_typecompatible.add_argument (ccall_typefrominstance);
		ccall_typecompatible.add_argument (ccall_gvaluetype);

		ccall = new CCodeFunctionCall (new CCodeIdentifier ("g_return_if_fail"));
		ccall.add_argument (ccall_typecompatible);
		ccode.add_expression (ccall);

		ccode.add_assignment (vpointer, new CCodeConstant ("v_object"));

		ccode.add_else ();
		ccode.add_assignment (vpointer, new CCodeConstant ("NULL"));
		ccode.close ();

		ccode.open_if (new CCodeIdentifier ("old"));
		ccall = new CCodeFunctionCall (new CCodeIdentifier (get_ccode_unref_function (cl)));
		ccall.add_argument (new CCodeIdentifier ("old"));
		ccode.add_expression (ccall);
		ccode.close ();

		pop_function ();
		cfile.add_function (function);
	}

	private void add_g_value_get_function (Class cl) {
		var function = new CCodeFunction (get_ccode_get_value_function (cl), "gpointer");
		function.add_parameter (new CCodeParameter ("value", "const GValue*"));

		if (cl.is_private_symbol ()) {
			function.modifiers = CCodeModifiers.STATIC;
		} else if (context.hide_internal && cl.is_internal_symbol ()) {
			function.modifiers = CCodeModifiers.INTERNAL;
		}

		var vpointer = new CCodeMemberAccess(new CCodeMemberAccess.pointer (new CCodeIdentifier ("value"), "data[0]"),"v_pointer");

		push_function (function);

		var ccall_typecheck = new CCodeFunctionCall (new CCodeIdentifier ("G_TYPE_CHECK_VALUE_TYPE"));
		ccall_typecheck.add_argument (new CCodeIdentifier ("value"));
		ccall_typecheck.add_argument (new CCodeIdentifier (get_ccode_type_id (cl)));

		var ccall = new CCodeFunctionCall (new CCodeIdentifier ("g_return_val_if_fail"));
		ccall.add_argument (ccall_typecheck);
		ccall.add_argument (new CCodeConstant ("NULL"));
		ccode.add_expression (ccall);

		ccode.add_return (vpointer);

		pop_function ();
		cfile.add_function (function);
	}

	private void begin_base_init_function (Class cl) {
		push_context (base_init_context);

		var base_init = new CCodeFunction ("%s_base_init".printf (get_ccode_lower_case_name (cl, null)), "void");
		base_init.add_parameter (new CCodeParameter ("klass", "%s *".printf (get_ccode_type_name (cl))));
		base_init.modifiers = CCodeModifiers.STATIC;

		push_function (base_init);

		pop_context ();
	}

	private void add_base_init_function (Class cl) {
		cfile.add_function (base_init_context.ccode);
	}

	public virtual void generate_class_init (Class cl) {
	}

	public virtual void end_instance_init (Class cl) {
	}

	private void begin_class_init_function (Class cl) {
		push_context (class_init_context);

		var func = new CCodeFunction ("%s_class_init".printf (get_ccode_lower_case_name (cl, null)));
		func.add_parameter (new CCodeParameter ("klass", "%s *".printf (get_ccode_type_name (cl))));
		func.add_parameter (new CCodeParameter ("klass_data", "gpointer"));
		func.modifiers = CCodeModifiers.STATIC;

		CCodeFunctionCall ccall;

		/* save pointer to parent class */
		var parent_decl = new CCodeDeclaration ("gpointer");
		var parent_var_decl = new CCodeVariableDeclarator ("%s_parent_class".printf (get_ccode_lower_case_name (cl, null)));
		parent_var_decl.initializer = new CCodeConstant ("NULL");
		parent_decl.add_declarator (parent_var_decl);
		parent_decl.modifiers = CCodeModifiers.STATIC;
		cfile.add_type_member_declaration (parent_decl);

		push_function (func);

		ccall = new CCodeFunctionCall (new CCodeIdentifier ("g_type_class_peek_parent"));
		ccall.add_argument (new CCodeIdentifier ("klass"));
		var parent_assignment = new CCodeAssignment (new CCodeIdentifier ("%s_parent_class".printf (get_ccode_lower_case_name (cl, null))), ccall);
		ccode.add_expression (parent_assignment);


		if (!cl.is_compact && !cl.is_subtype_of (gobject_type) && (cl.get_fields ().size > 0 || cl.destructor != null || cl.is_fundamental ())) {
			// set finalize function
			var fundamental_class = cl;
			while (fundamental_class.base_class != null) {
				fundamental_class = fundamental_class.base_class;
			}

			var ccast = new CCodeCastExpression (new CCodeIdentifier ("klass"), "%s *".printf (get_ccode_type_name (fundamental_class)));
			var finalize_assignment = new CCodeAssignment (new CCodeMemberAccess.pointer (ccast, "finalize"), new CCodeIdentifier ("%sfinalize".printf (get_ccode_lower_case_prefix (cl))));
			ccode.add_expression (finalize_assignment);
		}

		/* add struct for private fields */
		if (cl.has_private_fields || cl.has_type_parameters ()) {
			ccall = new CCodeFunctionCall (new CCodeIdentifier ("g_type_class_adjust_private_offset"));
			ccall.add_argument (new CCodeIdentifier ("klass"));
			ccall.add_argument (new CCodeIdentifier ("&%s_private_offset".printf (get_ccode_name (cl))));
			ccode.add_expression (ccall);
		}

		/* connect overridden methods */
		foreach (Method m in cl.get_methods ()) {
			if (m.base_method == null) {
				continue;
			}
			var base_type = (ObjectTypeSymbol) m.base_method.parent_symbol;

			// there is currently no default handler for abstract async methods
			if (!m.is_abstract || !m.coroutine) {
				generate_method_declaration (m.base_method, cfile);

				CCodeExpression cfunc = new CCodeIdentifier (get_ccode_real_name (m));
				cfunc = cast_method_pointer (m.base_method, cfunc, base_type, (m.coroutine ? 1 : 3));
				var ccast = new CCodeCastExpression (new CCodeIdentifier ("klass"), "%s *".printf (get_ccode_type_name (base_type)));
				ccode.add_assignment (new CCodeMemberAccess.pointer (ccast, get_ccode_vfunc_name (m.base_method)), cfunc);

				if (m.coroutine) {
					cfunc = new CCodeIdentifier (get_ccode_finish_real_name (m));
					cfunc = cast_method_pointer (m.base_method, cfunc, base_type, 2);
					ccode.add_assignment (new CCodeMemberAccess.pointer (ccast, get_ccode_finish_vfunc_name (m.base_method)), cfunc);
				}
			}
		}

		/* connect default signal handlers */
		foreach (Signal sig in cl.get_signals ()) {
			if (sig.default_handler == null) {
				continue;
			}

			var ccast = new CCodeCastExpression (new CCodeIdentifier ("klass"), "%s *".printf (get_ccode_type_name (cl)));
			ccode.add_assignment (new CCodeMemberAccess.pointer (ccast, get_ccode_vfunc_name (sig.default_handler)), new CCodeIdentifier (get_ccode_real_name (sig.default_handler)));
		}

		/* connect overridden properties */
		foreach (Property prop in cl.get_properties ()) {
			if (prop.base_property == null) {
				continue;
			}
			var base_type = (Class) prop.base_property.parent_symbol;

			var ccast = new CCodeFunctionCall (new CCodeIdentifier (get_ccode_class_type_function (base_type)));
			ccast.add_argument (new CCodeIdentifier ("klass"));

			if (!get_ccode_no_accessor_method (prop.base_property) && !get_ccode_concrete_accessor (prop.base_property)) {
				if (prop.get_accessor != null) {
					generate_property_accessor_declaration (prop.base_property.get_accessor, cfile);

					string cname = get_ccode_real_name (prop.get_accessor);
					ccode.add_assignment (new CCodeMemberAccess.pointer (ccast, "get_%s".printf (prop.name)), new CCodeIdentifier (cname));
				}
				if (prop.set_accessor != null) {
					generate_property_accessor_declaration (prop.base_property.set_accessor, cfile);

					string cname = get_ccode_real_name (prop.set_accessor);
					ccode.add_assignment (new CCodeMemberAccess.pointer (ccast, "set_%s".printf (prop.name)), new CCodeIdentifier (cname));
				}
			}
		}

		generate_class_init (cl);

		if (!cl.is_compact) {
			/* create signals */
			foreach (Signal sig in cl.get_signals ()) {
				if (sig.comment != null) {
					ccode.add_statement (new CCodeComment (sig.comment.content));
				}
				ccode.add_expression (get_signal_creation (sig, cl));
			}
		}

		pop_context ();
	}

	private void add_class_init_function (Class cl) {
		cfile.add_function (class_init_context.ccode);
	}

	private void add_generic_accessor_function (string base_name, string return_type, CCodeExpression? expression, TypeParameter p, Class cl, Interface iface) {
		string name = "%s_%s_%s".printf (get_ccode_lower_case_name (cl), get_ccode_lower_case_name (iface), base_name);

		var function = new CCodeFunction (name, return_type);
		function.modifiers = CCodeModifiers.STATIC;
		var this_type = SemanticAnalyzer.get_data_type_for_symbol (cl);
		function.add_parameter (new CCodeParameter ("self", get_ccode_name (this_type)));
		push_function (function);
		ccode.add_return (expression);
		pop_function ();
		cfile.add_function (function);

		CCodeExpression cfunc = new CCodeIdentifier (function.name);
		string cast = "%s (*)".printf (return_type);
		string cast_args = "%s *".printf (get_ccode_name (iface));
		cast = "%s (%s)".printf (cast, cast_args);
		cfunc = new CCodeCastExpression (cfunc, cast);
		var ciface = new CCodeIdentifier ("iface");
		ccode.add_assignment (new CCodeMemberAccess.pointer (ciface, base_name), cfunc);
	}

	private void add_interface_init_function (Class cl, Interface iface) {
		var iface_init = new CCodeFunction ("%s_%s_interface_init".printf (get_ccode_lower_case_name (cl), get_ccode_lower_case_name (iface)), "void");
		iface_init.add_parameter (new CCodeParameter ("iface", "%s *".printf (get_ccode_type_name (iface))));
		iface_init.add_parameter (new CCodeParameter ("iface_data", "gpointer"));
		iface_init.modifiers = CCodeModifiers.STATIC;

		push_function (iface_init);

		CCodeFunctionCall ccall;

		/* save pointer to parent vtable */
		string parent_iface_var = "%s_%s_parent_iface".printf (get_ccode_lower_case_name (cl), get_ccode_lower_case_name (iface));
		var parent_decl = new CCodeDeclaration ("%s *".printf (get_ccode_type_name (iface)));
		var parent_var_decl = new CCodeVariableDeclarator (parent_iface_var);
		parent_var_decl.initializer = new CCodeConstant ("NULL");
		parent_decl.add_declarator (parent_var_decl);
		parent_decl.modifiers = CCodeModifiers.STATIC;
		cfile.add_type_member_declaration (parent_decl);
		ccall = new CCodeFunctionCall (new CCodeIdentifier ("g_type_interface_peek_parent"));
		ccall.add_argument (new CCodeIdentifier ("iface"));
		ccode.add_assignment (new CCodeIdentifier (parent_iface_var), ccall);

		foreach (Method m in cl.get_methods ()) {
			if (m.base_interface_method == null) {
				continue;
			}

			var base_type = m.base_interface_method.parent_symbol;
			if (base_type != iface) {
				continue;
			}

			generate_method_declaration (m.base_interface_method, cfile);

			var ciface = new CCodeIdentifier ("iface");
			CCodeExpression cfunc;
			if (m.is_abstract || m.is_virtual) {
				cfunc = new CCodeIdentifier (get_ccode_name (m));
			} else {
				cfunc = new CCodeIdentifier (get_ccode_real_name (m));
			}
			cfunc = cast_method_pointer (m.base_interface_method, cfunc, iface, (m.coroutine ? 1 : 3));
			ccode.add_assignment (new CCodeMemberAccess.pointer (ciface, get_ccode_vfunc_name (m.base_interface_method)), cfunc);

			if (m.coroutine) {
				if (m.is_abstract || m.is_virtual) {
					cfunc = new CCodeIdentifier (get_ccode_finish_name (m));
				} else {
					cfunc = new CCodeIdentifier (get_ccode_finish_real_name (m));
				}
				cfunc = cast_method_pointer (m.base_interface_method, cfunc, iface, 2);
				ccode.add_assignment (new CCodeMemberAccess.pointer (ciface, get_ccode_finish_vfunc_name (m.base_interface_method)), cfunc);
			}
		}

		if (iface.get_attribute ("GenericAccessors") != null) {
			foreach (TypeParameter p in iface.get_type_parameters ()) {
				GenericType p_type = new GenericType (p);
				DataType p_data_type = p_type.get_actual_type (SemanticAnalyzer.get_data_type_for_symbol (cl), null, cl);

				add_generic_accessor_function ("get_%s_type".printf (p.name.ascii_down ()),
				                               "GType",
				                               get_type_id_expression (p_data_type),
				                               p, cl, iface);

				add_generic_accessor_function ("get_%s_dup_func".printf (p.name.ascii_down ()),
				                               "GBoxedCopyFunc",
				                               get_dup_func_expression (p_data_type, null),
				                               p, cl, iface);

				add_generic_accessor_function ("get_%s_destroy_func".printf (p.name.ascii_down ()),
				                               "GDestroyNotify",
				                               get_destroy_func_expression (p_data_type),
				                               p, cl, iface);
			}
		}

		// connect inherited implementations
		var it = cl.get_implicit_implementations ().map_iterator ();
		while (it.next ()) {
			Method m = it.get_key ();
			if (m.parent_symbol == iface) {
				Method base_method = it.get_value ();

				generate_method_declaration (base_method, cfile);

				CCodeExpression cfunc = new CCodeIdentifier (get_ccode_name (base_method));
				cfunc = cast_method_pointer (m, cfunc, iface);
				var ciface = new CCodeIdentifier ("iface");
				ccode.add_assignment (new CCodeMemberAccess.pointer (ciface, get_ccode_vfunc_name (m)), cfunc);
			}
		}

		foreach (Property prop in cl.get_properties ()) {
			if (prop.base_interface_property == null) {
				continue;
			}

			var base_type = (ObjectTypeSymbol) prop.base_interface_property.parent_symbol;
			if (base_type != iface) {
				continue;
			}

			var ciface = new CCodeIdentifier ("iface");

			if (!get_ccode_no_accessor_method (prop.base_interface_property) && !get_ccode_concrete_accessor (prop.base_interface_property)) {
				if (prop.get_accessor != null) {
					generate_property_accessor_declaration (prop.base_interface_property.get_accessor, cfile);

					string cname = get_ccode_real_name (prop.get_accessor);
					if (prop.is_abstract || prop.is_virtual) {
						cname = get_ccode_name (prop.get_accessor);
					}

					CCodeExpression cfunc = new CCodeIdentifier (cname);
					if (prop.is_abstract || prop.is_virtual) {
						cfunc = cast_property_accessor_pointer (prop.get_accessor, cfunc, base_type);
					}
					ccode.add_assignment (new CCodeMemberAccess.pointer (ciface, "get_%s".printf (prop.name)), cfunc);
				}
				if (prop.set_accessor != null) {
					generate_property_accessor_declaration (prop.base_interface_property.set_accessor, cfile);

					string cname = get_ccode_real_name (prop.set_accessor);
					if (prop.is_abstract || prop.is_virtual) {
						cname = get_ccode_name (prop.set_accessor);
					}

					CCodeExpression cfunc = new CCodeIdentifier (cname);
					if (prop.is_abstract || prop.is_virtual) {
						cfunc = cast_property_accessor_pointer (prop.set_accessor, cfunc, base_type);
					}
					ccode.add_assignment (new CCodeMemberAccess.pointer (ciface, "set_%s".printf (prop.name)), cfunc);
				}
			}
		}

		foreach (Property prop in iface.get_properties ()) {
			if (!prop.is_abstract) {
				continue;
			}

			Property cl_prop = null;
			var base_class = cl;
			while (base_class != null && cl_prop == null) {
				cl_prop = base_class.scope.lookup (prop.name) as Property;
				base_class = base_class.base_class;
			}
			if (base_class != null && cl_prop.parent_symbol != cl) {
				// property inherited from base class

				var base_property = cl_prop;
				if (cl_prop.base_property != null) {
					base_property = cl_prop.base_property;
				} else if (cl_prop.base_interface_property != null) {
					base_property = cl_prop.base_interface_property;
				}

				// Our base class provides this interface implementation
				if (prop == base_property) {
					continue;
				}

				var ciface = new CCodeIdentifier ("iface");

				if (base_property.get_accessor != null && prop.get_accessor != null) {
					generate_property_accessor_declaration (base_property.get_accessor, cfile);

					string cname = get_ccode_name (base_property.get_accessor);
					CCodeExpression cfunc = new CCodeIdentifier (cname);
					cfunc = cast_property_accessor_pointer (prop.get_accessor, cfunc, iface);
					ccode.add_assignment (new CCodeMemberAccess.pointer (ciface, "get_%s".printf (prop.name)), cfunc);
				}
				if (base_property.set_accessor != null && prop.set_accessor != null) {
					generate_property_accessor_declaration (base_property.set_accessor, cfile);

					string cname = get_ccode_name (base_property.set_accessor);
					CCodeExpression cfunc = new CCodeIdentifier (cname);
					cfunc = cast_property_accessor_pointer (prop.set_accessor, cfunc, iface);
					ccode.add_assignment (new CCodeMemberAccess.pointer (ciface, "set_%s".printf (prop.name)), cfunc);
				}
			}
		}

		pop_function ();
		cfile.add_function (iface_init);
	}

	CCodeExpression cast_property_accessor_pointer (PropertyAccessor acc, CCodeExpression cfunc, ObjectTypeSymbol base_type) {
		string cast;
		if (acc.readable && acc.value_type.is_real_non_null_struct_type ()) {
			cast = "void (*) (%s *, %s *)".printf (get_ccode_name (base_type), get_ccode_name (acc.value_type));
		} else if (acc.readable) {
			cast = "%s (*) (%s *)".printf (get_ccode_name (acc.value_type), get_ccode_name (base_type));
		} else if (acc.value_type.is_real_non_null_struct_type ()) {
			cast = "void (*) (%s *, %s *)".printf (get_ccode_name (base_type), get_ccode_name (acc.value_type));
		} else {
			cast = "void (*) (%s *, %s)".printf (get_ccode_name (base_type), get_ccode_name (acc.value_type));
		}
		return new CCodeCastExpression (cfunc, cast);
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
		if (!cl.is_compact) {
			func.add_parameter (new CCodeParameter ("klass", "gpointer"));
		}
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
					generate_method_declaration (m.base_method, cfile);

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
						generate_property_accessor_declaration (prop.base_property.get_accessor, cfile);

						string cname = get_ccode_real_name (prop.get_accessor);
						ccode.add_assignment (new CCodeMemberAccess.pointer (ccast, "get_%s".printf (prop.name)), new CCodeIdentifier (cname));
					}
					if (prop.set_accessor != null) {
						generate_property_accessor_declaration (prop.base_property.set_accessor, cfile);

						string cname = get_ccode_real_name (prop.set_accessor);
						ccode.add_assignment (new CCodeMemberAccess.pointer (ccast, "set_%s".printf (prop.name)), new CCodeIdentifier (cname));
					}
				}
			}
		}

		if (!cl.is_compact && (cl.has_private_fields || cl.has_type_parameters ())) {
			var ccall = new CCodeFunctionCall (new CCodeIdentifier ("%s_get_instance_private".printf (get_ccode_lower_case_name (cl, null))));
			ccall.add_argument (new CCodeIdentifier ("self"));
			func.add_assignment (new CCodeMemberAccess.pointer (new CCodeIdentifier ("self"), "priv"), ccall);
		}

		pop_context ();
	}

	private void add_instance_init_function (Class cl) {
		push_context (instance_init_context);
		end_instance_init (cl);
		pop_context ();

		cfile.add_function (instance_init_context.ccode);
	}

	private void begin_class_finalize_function (Class cl) {
		push_context (class_finalize_context);

		var function = new CCodeFunction ("%s_class_finalize".printf (get_ccode_lower_case_name (cl, null)), "void");
		function.modifiers = CCodeModifiers.STATIC;

		function.add_parameter (new CCodeParameter ("klass", "%s *".printf (get_ccode_type_name (cl))));

		push_function (function);

		if (cl.static_destructor != null) {
			cl.static_destructor.body.emit (this);
		}

		pop_context ();
	}

	private void add_class_finalize_function (Class cl) {
		cfile.add_function_declaration (class_finalize_context.ccode);
		cfile.add_function (class_finalize_context.ccode);
	}

	private void begin_base_finalize_function (Class cl) {
		push_context (base_finalize_context);

		var function = new CCodeFunction ("%s_base_finalize".printf (get_ccode_lower_case_name (cl, null)), "void");
		function.modifiers = CCodeModifiers.STATIC;

		function.add_parameter (new CCodeParameter ("klass", "%s *".printf (get_ccode_type_name (cl))));
		function.add_parameter (new CCodeParameter ("klass_data", "gpointer"));

		push_function (function);

		if (cl.class_destructor != null) {
			cl.class_destructor.body.emit (this);
		}

		pop_context ();
	}

	private void add_base_finalize_function (Class cl) {
		push_context (base_finalize_context);

		cfile.add_function_declaration (ccode);
		cfile.add_function (ccode);

		pop_context ();
	}

	private void begin_finalize_function (Class cl) {
		push_context (instance_finalize_context);

		bool is_gsource = cl.base_class == gsource_type;

		if (!cl.is_compact || is_gsource) {
			var fundamental_class = cl;
			while (fundamental_class.base_class != null) {
				fundamental_class = fundamental_class.base_class;
			}

			var func = new CCodeFunction ("%sfinalize".printf (get_ccode_lower_case_prefix (cl)));
			func.add_parameter (new CCodeParameter ("obj", "%s *".printf (get_ccode_name (fundamental_class))));
			func.modifiers = CCodeModifiers.STATIC;

			push_function (func);

			if (is_gsource) {
				cfile.add_function_declaration (func);
			}

			CCodeExpression ccast;
			if (!cl.is_compact) {
				ccast = generate_instance_cast (new CCodeIdentifier ("obj"), cl);
			} else {
				ccast = new CCodeCastExpression (new CCodeIdentifier ("obj"), "%s *".printf (get_ccode_name (cl)));
			}

			ccode.add_declaration ("%s *".printf (get_ccode_name (cl)), new CCodeVariableDeclarator ("self"));
			ccode.add_assignment (new CCodeIdentifier ("self"), ccast);

			if (!cl.is_compact && cl.base_class == null) {
				// non-gobject class
				var call = new CCodeFunctionCall (new CCodeIdentifier ("g_signal_handlers_destroy"));
				call.add_argument (new CCodeIdentifier ("self"));
				ccode.add_expression (call);
			}
		} else if (cl.base_class == null) {
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

			if (current_method_inner_error) {
				ccode.add_declaration ("GError*", new CCodeVariableDeclarator.zero ("_inner_error%d_".printf (current_inner_error_id), new CCodeConstant ("NULL")));
			}

			if (current_method_return) {
				// support return statements in destructors
				ccode.add_label ("_return");
			}
		}

		pop_context ();
	}

	private void add_finalize_function (Class cl) {
		if (!cl.is_compact) {
			var fundamental_class = cl;
			while (fundamental_class.base_class != null) {
				fundamental_class = fundamental_class.base_class;
			}

			// chain up to finalize function of the base class
			if (cl.base_class != null) {
				var ccast = new CCodeFunctionCall (new CCodeIdentifier (get_ccode_class_type_function (fundamental_class)));
				ccast.add_argument (new CCodeIdentifier ("%s_parent_class".printf (get_ccode_lower_case_name (cl, null))));
				var ccall = new CCodeFunctionCall (new CCodeMemberAccess.pointer (ccast, "finalize"));
				ccall.add_argument (new CCodeIdentifier ("obj"));
				push_context (instance_finalize_context);
				ccode.add_expression (ccall);
				pop_context ();
			}

			cfile.add_function_declaration (instance_finalize_context.ccode);
			cfile.add_function (instance_finalize_context.ccode);
		} else if (cl.base_class == null) {
			// g_slice_free needs glib.h
			cfile.add_include ("glib.h");
			var ccall = new CCodeFunctionCall (new CCodeIdentifier ("g_slice_free"));
			ccall.add_argument (new CCodeIdentifier (get_ccode_name (cl)));
			ccall.add_argument (new CCodeIdentifier ("self"));
			push_context (instance_finalize_context);
			ccode.add_expression (ccall);
			pop_context ();

			cfile.add_function (instance_finalize_context.ccode);
		} else if (cl.base_class == gsource_type) {
			cfile.add_function (instance_finalize_context.ccode);
		}
	}

	public override CCodeExpression get_param_spec_cexpression (Property prop) {
		var cl = (TypeSymbol) prop.parent_symbol;
		var prop_array = new CCodeIdentifier ("%s_properties".printf (get_ccode_lower_case_name (cl)));
		var prop_enum_value = new CCodeIdentifier ("%s_PROPERTY".printf (get_ccode_upper_case_name (prop)));

		return new CCodeElementAccess (prop_array, prop_enum_value);
	}

	public override CCodeExpression get_param_spec (Property prop) {
		var cspec = new CCodeFunctionCall ();
		cspec.add_argument (get_property_canonical_cconstant (prop));
		cspec.add_argument (new CCodeConstant ("\"%s\"".printf (prop.nick)));
		cspec.add_argument (new CCodeConstant ("\"%s\"".printf (prop.blurb)));

		unowned TypeSymbol? type_symbol = prop.property_type.type_symbol;
		if (type_symbol is Class || type_symbol is Interface) {
			string param_spec_name = get_ccode_param_spec_function (type_symbol);
			cspec.call = new CCodeIdentifier (param_spec_name);
			if (param_spec_name == "g_param_spec_string") {
				cspec.add_argument (new CCodeConstant ("NULL"));
			} else if (param_spec_name == "g_param_spec_variant") {
				cspec.add_argument (new CCodeConstant ("G_VARIANT_TYPE_ANY"));
				cspec.add_argument (new CCodeConstant ("NULL"));
			} else if (param_spec_name == "gtk_param_spec_expression") {
				// No additional parameter required
			} else if (get_ccode_type_id (type_symbol) != "G_TYPE_POINTER") {
				cspec.add_argument (new CCodeIdentifier (get_ccode_type_id (type_symbol)));
			}
		} else if (type_symbol is Enum) {
			unowned Enum e = (Enum) type_symbol;
			if (get_ccode_has_type_id (e)) {
				if (e.is_flags) {
					cspec.call = new CCodeIdentifier ("g_param_spec_flags");
				} else {
					cspec.call = new CCodeIdentifier ("g_param_spec_enum");
				}
				cspec.add_argument (new CCodeIdentifier (get_ccode_type_id (e)));
			} else {
				if (e.is_flags) {
					cspec.call = new CCodeIdentifier ("g_param_spec_uint");
					cspec.add_argument (new CCodeConstant ("0"));
					cspec.add_argument (new CCodeConstant ("G_MAXUINT"));
				} else {
					cspec.call = new CCodeIdentifier ("g_param_spec_int");
					cspec.add_argument (new CCodeConstant ("G_MININT"));
					cspec.add_argument (new CCodeConstant ("G_MAXINT"));
				}
			}

			if (prop.initializer != null) {
				cspec.add_argument ((CCodeExpression) get_ccodenode (prop.initializer));
			} else {
				cspec.add_argument (new CCodeConstant (get_ccode_default_value (type_symbol)));
			}
		} else if (type_symbol is Struct) {
			unowned Struct st = (Struct) type_symbol;
			var type_id = get_ccode_type_id (st);
			if (type_id == "G_TYPE_INT") {
				cspec.call = new CCodeIdentifier ("g_param_spec_int");
				cspec.add_argument (new CCodeConstant ("G_MININT"));
				cspec.add_argument (new CCodeConstant ("G_MAXINT"));
				if (prop.initializer != null) {
					cspec.add_argument ((CCodeExpression) get_ccodenode (prop.initializer));
				} else {
					cspec.add_argument (new CCodeConstant ("0"));
				}
			} else if (type_id == "G_TYPE_UINT") {
				cspec.call = new CCodeIdentifier ("g_param_spec_uint");
				cspec.add_argument (new CCodeConstant ("0"));
				cspec.add_argument (new CCodeConstant ("G_MAXUINT"));
				if (prop.initializer != null) {
					cspec.add_argument ((CCodeExpression) get_ccodenode (prop.initializer));
				} else {
					cspec.add_argument (new CCodeConstant ("0U"));
				}
			} else if (type_id == "G_TYPE_INT64") {
				cspec.call = new CCodeIdentifier ("g_param_spec_int64");
				cspec.add_argument (new CCodeConstant ("G_MININT64"));
				cspec.add_argument (new CCodeConstant ("G_MAXINT64"));
				if (prop.initializer != null) {
					cspec.add_argument ((CCodeExpression) get_ccodenode (prop.initializer));
				} else {
					cspec.add_argument (new CCodeConstant ("0"));
				}
			} else if (type_id == "G_TYPE_UINT64") {
				cspec.call = new CCodeIdentifier ("g_param_spec_uint64");
				cspec.add_argument (new CCodeConstant ("0"));
				cspec.add_argument (new CCodeConstant ("G_MAXUINT64"));
				if (prop.initializer != null) {
					cspec.add_argument ((CCodeExpression) get_ccodenode (prop.initializer));
				} else {
					cspec.add_argument (new CCodeConstant ("0U"));
				}
			} else if (type_id == "G_TYPE_LONG") {
				cspec.call = new CCodeIdentifier ("g_param_spec_long");
				cspec.add_argument (new CCodeConstant ("G_MINLONG"));
				cspec.add_argument (new CCodeConstant ("G_MAXLONG"));
				if (prop.initializer != null) {
					cspec.add_argument ((CCodeExpression) get_ccodenode (prop.initializer));
				} else {
					cspec.add_argument (new CCodeConstant ("0L"));
				}
			} else if (type_id == "G_TYPE_ULONG") {
				cspec.call = new CCodeIdentifier ("g_param_spec_ulong");
				cspec.add_argument (new CCodeConstant ("0"));
				cspec.add_argument (new CCodeConstant ("G_MAXULONG"));
				if (prop.initializer != null) {
					cspec.add_argument ((CCodeExpression) get_ccodenode (prop.initializer));
				} else {
					cspec.add_argument (new CCodeConstant ("0UL"));
				}
			} else if (type_id == "G_TYPE_BOOLEAN") {
				cspec.call = new CCodeIdentifier ("g_param_spec_boolean");
				if (prop.initializer != null) {
					cspec.add_argument ((CCodeExpression) get_ccodenode (prop.initializer));
				} else {
					cspec.add_argument (new CCodeConstant ("FALSE"));
				}
			} else if (type_id == "G_TYPE_CHAR") {
				cspec.call = new CCodeIdentifier ("g_param_spec_char");
				cspec.add_argument (new CCodeConstant ("G_MININT8"));
				cspec.add_argument (new CCodeConstant ("G_MAXINT8"));
				if (prop.initializer != null) {
					cspec.add_argument ((CCodeExpression) get_ccodenode (prop.initializer));
				} else {
					cspec.add_argument (new CCodeConstant ("0"));
				}
			} else if (type_id == "G_TYPE_UCHAR") {
				cspec.call = new CCodeIdentifier ("g_param_spec_uchar");
				cspec.add_argument (new CCodeConstant ("0"));
				cspec.add_argument (new CCodeConstant ("G_MAXUINT8"));
				if (prop.initializer != null) {
					cspec.add_argument ((CCodeExpression) get_ccodenode (prop.initializer));
				} else {
					cspec.add_argument (new CCodeConstant ("0"));
				}
			} else if (type_id == "G_TYPE_FLOAT") {
				cspec.call = new CCodeIdentifier ("g_param_spec_float");
				cspec.add_argument (new CCodeConstant ("-G_MAXFLOAT"));
				cspec.add_argument (new CCodeConstant ("G_MAXFLOAT"));
				if (prop.initializer != null) {
					cspec.add_argument ((CCodeExpression) get_ccodenode (prop.initializer));
				} else {
					cspec.add_argument (new CCodeConstant ("0.0F"));
				}
			} else if (type_id == "G_TYPE_DOUBLE") {
				cspec.call = new CCodeIdentifier ("g_param_spec_double");
				cspec.add_argument (new CCodeConstant ("-G_MAXDOUBLE"));
				cspec.add_argument (new CCodeConstant ("G_MAXDOUBLE"));
				if (prop.initializer != null) {
					cspec.add_argument ((CCodeExpression) get_ccodenode (prop.initializer));
				} else {
					cspec.add_argument (new CCodeConstant ("0.0"));
				}
			} else if (type_id == "G_TYPE_GTYPE") {
				cspec.call = new CCodeIdentifier ("g_param_spec_gtype");
				if (prop.initializer != null) {
					cspec.add_argument ((CCodeExpression) get_ccodenode (prop.initializer));
				} else {
					cspec.add_argument (new CCodeConstant ("G_TYPE_NONE"));
				}
			} else {
				cspec.call = new CCodeIdentifier ("g_param_spec_boxed");
				cspec.add_argument (new CCodeIdentifier (type_id));
			}
		} else if (prop.property_type is ArrayType && ((ArrayType)prop.property_type).element_type.type_symbol == string_type.type_symbol) {
			cspec.call = new CCodeIdentifier ("g_param_spec_boxed");
			cspec.add_argument (new CCodeIdentifier ("G_TYPE_STRV"));
		} else {
			cspec.call = new CCodeIdentifier ("g_param_spec_pointer");
		}

		var pflags = "G_PARAM_STATIC_STRINGS";
		if (prop.get_accessor != null && prop.get_accessor.access != SymbolAccessibility.PRIVATE) {
			pflags = "%s%s".printf (pflags, " | G_PARAM_READABLE");
		}
		if (prop.set_accessor != null && prop.set_accessor.access != SymbolAccessibility.PRIVATE) {
			pflags = "%s%s".printf (pflags, " | G_PARAM_WRITABLE");
			if (prop.set_accessor.construction) {
				if (prop.set_accessor.writable) {
					pflags = "%s%s".printf (pflags, " | G_PARAM_CONSTRUCT");
				} else {
					pflags = "%s%s".printf (pflags, " | G_PARAM_CONSTRUCT_ONLY");
				}
			}
		}
		if (!prop.notify) {
			pflags = "%s%s".printf (pflags, " | G_PARAM_EXPLICIT_NOTIFY");
		}
		if (prop.version.deprecated) {
			pflags = "%s%s".printf (pflags, " | G_PARAM_DEPRECATED");
		}
		cspec.add_argument (new CCodeConstant (pflags));

		if (prop.parent_symbol is Interface) {
			return cspec;
		} else {
			return new CCodeAssignment (get_param_spec_cexpression (prop), cspec);
		}
	}

	public override void generate_interface_declaration (Interface iface, CCodeFile decl_space) {
		if (add_symbol_declaration (decl_space, iface, get_ccode_name (iface))) {
			return;
		}

		decl_space.add_include ("glib-object.h");

		var instance_struct = new CCodeStruct ("_%s".printf (get_ccode_name (iface)));
		var type_struct = new CCodeStruct ("_%s".printf (get_ccode_type_name (iface)));

		decl_space.add_type_declaration (new CCodeNewline ());
		var macro = "(%s_get_type ())".printf (get_ccode_lower_case_name (iface, null));
		decl_space.add_type_declaration (new CCodeMacroReplacement (get_ccode_type_id (iface), macro));

		macro = "(G_TYPE_CHECK_INSTANCE_CAST ((obj), %s, %s))".printf (get_ccode_type_id (iface), get_ccode_name (iface));
		decl_space.add_type_declaration (new CCodeMacroReplacement ("%s(obj)".printf (get_ccode_type_cast_function (iface)), macro));

		macro = "(G_TYPE_CHECK_INSTANCE_TYPE ((obj), %s))".printf (get_ccode_type_id (iface));
		decl_space.add_type_declaration (new CCodeMacroReplacement ("%s(obj)".printf (get_ccode_type_check_function (iface)), macro));

		macro = "(G_TYPE_INSTANCE_GET_INTERFACE ((obj), %s, %s))".printf (get_ccode_type_id (iface), get_ccode_type_name (iface));
		decl_space.add_type_declaration (new CCodeMacroReplacement ("%s(obj)".printf (get_ccode_type_get_function (iface)), macro));
		decl_space.add_type_declaration (new CCodeNewline ());

		decl_space.add_type_declaration (new CCodeTypeDefinition ("struct _%s".printf (get_ccode_name (iface)), new CCodeVariableDeclarator (get_ccode_name (iface))));
		decl_space.add_type_declaration (new CCodeTypeDefinition ("struct %s".printf (type_struct.name), new CCodeVariableDeclarator (get_ccode_type_name (iface))));

		foreach (DataType prerequisite in iface.get_prerequisites ()) {
			unowned Class? prereq_cl = prerequisite.type_symbol as Class;
			unowned Interface? prereq_iface = prerequisite.type_symbol as Interface;
			if (prereq_cl != null) {
				generate_class_declaration (prereq_cl, decl_space);
			} else if (prereq_iface != null) {
				generate_interface_declaration (prereq_iface, decl_space);
			}
		}

		type_struct.add_field ("GTypeInterface", "parent_iface");

		if (iface.get_attribute ("GenericAccessors") != null) {
			foreach (TypeParameter p in iface.get_type_parameters ()) {
				string method_name = "get_%s_type".printf (p.name.ascii_down ());
				var vdeclarator = new CCodeFunctionDeclarator (method_name);
				var this_type = SemanticAnalyzer.get_data_type_for_symbol (iface);
				vdeclarator.add_parameter (new CCodeParameter ("self", get_ccode_name (this_type)));

				var vdecl = new CCodeDeclaration ("GType");
				vdecl.add_declarator (vdeclarator);
				type_struct.add_declaration (vdecl);

				method_name = "get_%s_dup_func".printf (p.name.ascii_down ());
				vdeclarator = new CCodeFunctionDeclarator (method_name);
				this_type = SemanticAnalyzer.get_data_type_for_symbol (iface);
				vdeclarator.add_parameter (new CCodeParameter ("self", get_ccode_name (this_type)));

				vdecl = new CCodeDeclaration ("GBoxedCopyFunc");
				vdecl.add_declarator (vdeclarator);
				type_struct.add_declaration (vdecl);

				method_name = "get_%s_destroy_func".printf (p.name.ascii_down ());
				vdeclarator = new CCodeFunctionDeclarator (method_name);
				this_type = SemanticAnalyzer.get_data_type_for_symbol (iface);
				vdeclarator.add_parameter (new CCodeParameter ("self", get_ccode_name (this_type)));

				vdecl = new CCodeDeclaration ("GDestroyNotify");
				vdecl.add_declarator (vdeclarator);
				type_struct.add_declaration (vdecl);
			}
		}

		bool has_struct_member = false;
		foreach (Symbol sym in iface.get_virtuals ()) {
			Method m;
			Signal sig;
			Property prop;
			if ((m = sym as Method) != null) {
				generate_struct_method_declaration (iface, m, instance_struct, type_struct, decl_space, ref has_struct_member);
			} else if ((sig = sym as Signal) != null) {
				if (sig.default_handler != null) {
					generate_virtual_method_declaration (sig.default_handler, decl_space, type_struct);
				}
			} else if ((prop = sym as Property) != null) {
				generate_struct_property_declaration (iface, prop, instance_struct, type_struct, decl_space, ref has_struct_member);
			} else {
				Report.error (sym.source_reference, "internal: Unsupported symbol");
			}
		}

		decl_space.add_type_definition (type_struct);

		var type_fun = new InterfaceRegisterFunction (iface);
		type_fun.init_from_type (context, in_plugin, true);
		decl_space.add_type_member_declaration (type_fun.get_declaration ());
	}

	public override void visit_interface (Interface iface) {
		push_context (new EmitContext (iface));
		push_line (iface.source_reference);

		var old_signal_enum = signal_enum;

		if (get_ccode_name (iface).length < 3) {
			iface.error = true;
			Report.error (iface.source_reference, "Interface name `%s' is too short".printf (get_ccode_name (iface)));
			return;
		}

		signal_enum = new CCodeEnum ();

		generate_interface_declaration (iface, cfile);
		if (!iface.is_internal_symbol ()) {
			generate_interface_declaration (iface, header_file);
		}
		if (!iface.is_private_symbol ()) {
			generate_interface_declaration (iface, internal_header_file);
		}

		iface.accept_children (this);

		if (iface.get_signals ().size > 0) {
			var last_signal = "%s_NUM_SIGNALS".printf (get_ccode_upper_case_name (iface));
			signal_enum.add_value (new CCodeEnumValue (last_signal));
			cfile.add_type_declaration (signal_enum);

			var signal_array_decl = new CCodeDeclaration ("guint");
			signal_array_decl.modifiers |= CCodeModifiers.STATIC;
			signal_array_decl.add_declarator (new CCodeVariableDeclarator ("%s_signals".printf (get_ccode_lower_case_name (iface)), new CCodeConstant ("{0}"), new CCodeDeclaratorSuffix.with_array (new CCodeIdentifier (last_signal))));
			cfile.add_type_declaration (signal_array_decl);
		}

		add_interface_default_init_function (iface);

		if (iface.comment != null) {
			cfile.add_type_member_definition (new CCodeComment (iface.comment.content));
		}

		var type_fun = new InterfaceRegisterFunction (iface);
		type_fun.init_from_type (context, in_plugin, false);
		cfile.add_type_member_declaration (type_fun.get_source_declaration ());
		cfile.add_type_member_definition (type_fun.get_definition ());

		signal_enum = old_signal_enum;

		pop_line ();
		pop_context ();
	}

	private void add_interface_default_init_function (Interface iface) {
		push_context (new EmitContext (iface));

		var default_init = new CCodeFunction ("%s_default_init".printf (get_ccode_lower_case_name (iface, null)), "void");
		default_init.add_parameter (new CCodeParameter ("iface", "%s *".printf (get_ccode_type_name (iface))));
		default_init.add_parameter (new CCodeParameter ("iface_data", "gpointer"));
		default_init.modifiers = CCodeModifiers.STATIC;

		push_function (default_init);

		if (iface.is_subtype_of (gobject_type)) {
			/* create properties */
			var props = iface.get_properties ();
			foreach (Property prop in props) {
				if (prop.is_abstract) {
					if (!context.analyzer.is_gobject_property (prop)) {
						continue;
					}

					if (prop.comment != null) {
						ccode.add_statement (new CCodeComment (prop.comment.content));
					}

					var cinst = new CCodeFunctionCall (new CCodeIdentifier ("g_object_interface_install_property"));
					cinst.add_argument (new CCodeIdentifier ("iface"));
					cinst.add_argument (get_param_spec (prop));

					ccode.add_expression (cinst);
				}
			}
		}

		var ciface = new CCodeIdentifier ("iface");

		/* connect default signal handlers */
		foreach (Signal sig in iface.get_signals ()) {
			if (sig.default_handler == null) {
				continue;
			}
			var cname = get_ccode_real_name (sig.default_handler);
			ccode.add_assignment (new CCodeMemberAccess.pointer (ciface, get_ccode_vfunc_name (sig.default_handler)), new CCodeIdentifier (cname));
		}

		/* create signals */
		foreach (Signal sig in iface.get_signals ()) {
			if (sig.comment != null) {
				ccode.add_statement (new CCodeComment (sig.comment.content));
			}
			ccode.add_expression (get_signal_creation (sig, iface));
		}

		// connect default implementations
		foreach (Method m in iface.get_methods ()) {
			if (m.is_virtual) {
				var cname = get_ccode_real_name (m);
				ccode.add_assignment (new CCodeMemberAccess.pointer (ciface, get_ccode_vfunc_name (m)), new CCodeIdentifier (cname));
				if (m.coroutine) {
					ccode.add_assignment (new CCodeMemberAccess.pointer (ciface, get_ccode_finish_vfunc_name (m)), new CCodeIdentifier (get_ccode_finish_real_name (m)));
				}
			}
		}

		foreach (Property prop in iface.get_properties ()) {
			if (prop.is_virtual) {
				if (prop.get_accessor != null) {
					string cname = get_ccode_real_name (prop.get_accessor);
					ccode.add_assignment (new CCodeMemberAccess.pointer (ciface, "get_%s".printf (prop.name)), new CCodeIdentifier (cname));
				}
				if (prop.set_accessor != null) {
					string cname = get_ccode_real_name (prop.set_accessor);
					ccode.add_assignment (new CCodeMemberAccess.pointer (ciface, "set_%s".printf (prop.name)), new CCodeIdentifier (cname));
				}
			}
		}

		pop_context ();

		cfile.add_function (default_init);
	}

	public override void visit_struct (Struct st) {
		// custom simple type structs cannot have a type id which depends on head-allocation
		if (st.get_attribute ("SimpleType") != null && !st.has_attribute_argument ("CCode", "type_id")) {
			st.set_attribute_bool ("CCode", "has_type_id", false);
		}

		base.visit_struct (st);

		if (st.is_boolean_type () || st.is_integer_type () || st.is_floating_type ()) {
			// Skip GType handling for these struct types,
			// like in CCodeStructModule.generate_struct_declaration()
			return;
		}

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
		// to_string() on a gtype enum

		bool is_flags = ((Enum) ((EnumValueType) ma.inner.value_type).type_symbol).is_flags;

		push_line (expr.source_reference);
		if (context.require_glib_version (2, 54)) {
			var to_string = new CCodeFunctionCall (new CCodeIdentifier ((is_flags ? "g_flags_to_string" : "g_enum_to_string")));
			to_string.add_argument (new CCodeIdentifier (get_ccode_type_id (ma.inner.value_type)));
			to_string.add_argument ((CCodeExpression) get_ccodenode (((MemberAccess) expr.call).inner));
			expr.value_type.value_owned = true;
			set_cvalue (expr, to_string);
		} else {
			var temp_var = get_temp_variable (new CType (is_flags ? "GFlagsValue*" : "GEnumValue*", "NULL"), false, expr, false);
			emit_temp_var (temp_var);

			var class_ref = new CCodeFunctionCall (new CCodeIdentifier ("g_type_class_ref"));
			class_ref.add_argument (new CCodeIdentifier (get_ccode_type_id (ma.inner.value_type)));
			var get_value = new CCodeFunctionCall (new CCodeIdentifier (is_flags ? "g_flags_get_first_value" : "g_enum_get_value"));
			get_value.add_argument (class_ref);
			get_value.add_argument ((CCodeExpression) get_ccodenode (((MemberAccess) expr.call).inner));

			ccode.add_assignment (get_variable_cexpression (temp_var.name), get_value);
			var is_null_value = new CCodeBinaryExpression (CCodeBinaryOperator.INEQUALITY, get_variable_cexpression (temp_var.name), new CCodeConstant ("NULL"));
			set_cvalue (expr, new CCodeConditionalExpression (is_null_value, new CCodeMemberAccess.pointer (get_variable_cexpression (temp_var.name), "value_name"), new CCodeConstant ("NULL")));
		}
		pop_line ();
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

	public override void create_type_check_statement (CodeNode method_node, DataType ret_type, TypeSymbol t, bool non_null, string var_name) {
		var ccheck = new CCodeFunctionCall ();

		if (!context.assert) {
			return;
		} else if (context.checking && ((t is Class && !((Class) t).is_compact) || t is Interface)) {
			if (!get_ccode_has_type_id (t)) {
				return;
			}

			CCodeFunctionCall ctype_check;
			if (t.external_package) {
				ctype_check = new CCodeFunctionCall (new CCodeIdentifier ("G_TYPE_CHECK_INSTANCE_TYPE"));
				ctype_check.add_argument (new CCodeIdentifier (var_name));
				ctype_check.add_argument (new CCodeIdentifier (get_ccode_type_id (t)));
			} else {
				ctype_check = new CCodeFunctionCall (new CCodeIdentifier (get_ccode_type_check_function (t)));
				ctype_check.add_argument (new CCodeIdentifier (var_name));
			}

			CCodeExpression cexpr = ctype_check;
			if (!non_null) {
				var cnull = new CCodeBinaryExpression (CCodeBinaryOperator.EQUALITY, new CCodeIdentifier (var_name), new CCodeConstant ("NULL"));

				cexpr = new CCodeBinaryExpression (CCodeBinaryOperator.OR, cnull, ctype_check);
			}
			ccheck.add_argument (cexpr);
		} else if (!non_null || (t is Struct && ((Struct) t).is_simple_type ())) {
			return;
		} else if (t == glist_type || t == gslist_type) {
			// NULL is empty list
			return;
		} else {
			var cnonnull = new CCodeBinaryExpression (CCodeBinaryOperator.INEQUALITY, new CCodeIdentifier (var_name), new CCodeConstant ("NULL"));
			ccheck.add_argument (cnonnull);
		}

		// g_return_* needs glib.h
		cfile.add_include ("glib.h");

		var cm = method_node as CreationMethod;
		if (cm != null && cm.parent_symbol is ObjectTypeSymbol) {
			ccheck.call = new CCodeIdentifier ("g_return_val_if_fail");
			ccheck.add_argument (new CCodeConstant ("NULL"));
		} else if (ret_type is VoidType) {
			/* void function */
			ccheck.call = new CCodeIdentifier ("g_return_if_fail");
		} else {
			ccheck.call = new CCodeIdentifier ("g_return_val_if_fail");

			var cdefault = default_value_for_type (ret_type, false);
			if (cdefault != null) {
				ccheck.add_argument (cdefault);
			} else if (ret_type.type_symbol is Struct && !((Struct) ret_type.type_symbol).is_simple_type ()) {
				ccheck.add_argument (new CCodeIdentifier ("result"));
			} else {
				return;
			}
		}

		ccode.add_expression (ccheck);
	}

	public override void visit_cast_expression (CastExpression expr) {
		unowned ObjectTypeSymbol? type_symbol = expr.type_reference.type_symbol as ObjectTypeSymbol;

		if (type_symbol == null || (type_symbol is Class && ((Class) type_symbol).is_compact)) {
			base.visit_cast_expression (expr);
			return;
		}

		generate_type_declaration (expr.type_reference, cfile);

		// checked cast for strict subtypes of GTypeInstance
		if (expr.is_silent_cast) {
			TargetValue to_cast = expr.inner.target_value;
			CCodeExpression cexpr;
			if (!get_lvalue (to_cast)) {
				to_cast = store_temp_value (to_cast, expr);
			}
			cexpr = get_cvalue_ (to_cast);
			var ccheck = create_type_check (cexpr, expr.type_reference);
			var ccast = new CCodeCastExpression (cexpr, get_ccode_name (expr.type_reference));
			var cnull = new CCodeConstant ("NULL");
			var cast_value = new GLibValue (expr.value_type, new CCodeConditionalExpression (ccheck, ccast, cnull));
			if (requires_destroy (expr.inner.value_type)) {
				var casted = store_temp_value (cast_value, expr);
				ccode.open_if (new CCodeBinaryExpression (CCodeBinaryOperator.EQUALITY, get_cvalue_ (casted), new CCodeConstant ("NULL")));
				ccode.add_expression (destroy_value (to_cast));
				ccode.close ();
				expr.target_value = ((GLibValue) casted).copy ();
			} else {
				expr.target_value = cast_value;
			}
		} else {
			set_cvalue (expr, generate_instance_cast (get_cvalue (expr.inner), expr.type_reference.type_symbol));
		}
	}
}
