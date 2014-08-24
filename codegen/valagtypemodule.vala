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
			ctypename += "*";
		}

		var cparam = new CCodeParameter (get_variable_cname (param.name), ctypename);

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

		bool is_gtypeinstance = !cl.is_compact;
		bool is_fundamental = is_gtypeinstance && cl.base_class == null;
		bool is_gsource = cl.base_class == gsource_type;

		if (is_gtypeinstance) {
			decl_space.add_type_declaration (new CCodeNewline ());
			var macro = "(%s_get_type ())".printf (get_ccode_lower_case_name (cl, null));
			decl_space.add_type_declaration (new CCodeMacroReplacement (get_ccode_type_id (cl), macro));

			macro = "(G_TYPE_CHECK_INSTANCE_CAST ((obj), %s, %s))".printf (get_ccode_type_id (cl), get_ccode_name (cl));
			decl_space.add_type_declaration (new CCodeMacroReplacement ("%s(obj)".printf (get_ccode_upper_case_name (cl, null)), macro));

			macro = "(G_TYPE_CHECK_CLASS_CAST ((klass), %s, %sClass))".printf (get_ccode_type_id (cl), get_ccode_name (cl));
			decl_space.add_type_declaration (new CCodeMacroReplacement ("%s_CLASS(klass)".printf (get_ccode_upper_case_name (cl, null)), macro));

			macro = "(G_TYPE_CHECK_INSTANCE_TYPE ((obj), %s))".printf (get_ccode_type_id (cl));
			decl_space.add_type_declaration (new CCodeMacroReplacement ("%s(obj)".printf (get_ccode_type_check_function (cl)), macro));

			macro = "(G_TYPE_CHECK_CLASS_TYPE ((klass), %s))".printf (get_ccode_type_id (cl));
			decl_space.add_type_declaration (new CCodeMacroReplacement ("%s_CLASS(klass)".printf (get_ccode_type_check_function (cl)), macro));

			macro = "(G_TYPE_INSTANCE_GET_CLASS ((obj), %s, %sClass))".printf (get_ccode_type_id (cl), get_ccode_name (cl));
			decl_space.add_type_declaration (new CCodeMacroReplacement ("%s_GET_CLASS(obj)".printf (get_ccode_upper_case_name (cl, null)), macro));
			decl_space.add_type_declaration (new CCodeNewline ());
		}

		if (cl.is_compact && cl.base_class != null && !is_gsource) {
			decl_space.add_type_declaration (new CCodeTypeDefinition (get_ccode_name (cl.base_class), new CCodeVariableDeclarator (get_ccode_name (cl))));
		} else {
			decl_space.add_type_declaration (new CCodeTypeDefinition ("struct _%s".printf (get_ccode_name (cl)), new CCodeVariableDeclarator (get_ccode_name (cl))));
		}

		if (is_fundamental) {
			var ref_fun = new CCodeFunction (get_ccode_lower_case_prefix (cl) + "ref", "gpointer");
			var unref_fun = new CCodeFunction (get_ccode_lower_case_prefix (cl) + "unref", "void");
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
			string function_name = get_ccode_lower_case_name (cl, "param_spec_");

			var function = new CCodeFunction (function_name, "GParamSpec*");
			function.add_parameter (new CCodeParameter ("name", "const gchar*"));
			function.add_parameter (new CCodeParameter ("nick", "const gchar*"));
			function.add_parameter (new CCodeParameter ("blurb", "const gchar*"));
			function.add_parameter (new CCodeParameter ("object_type", "GType"));
			function.add_parameter (new CCodeParameter ("flags", "GParamFlags"));

			if (cl.is_private_symbol ()) {
				function.modifiers = CCodeModifiers.STATIC;
				// avoid C warning as this function is not always used
				function.attributes = "G_GNUC_UNUSED";
			} else if (context.hide_internal && cl.is_internal_symbol ()) {
				function.modifiers = CCodeModifiers.INTERNAL;
			}

			decl_space.add_function_declaration (function);

			function = new CCodeFunction (get_ccode_set_value_function (cl), "void");
			function.add_parameter (new CCodeParameter ("value", "GValue*"));
			function.add_parameter (new CCodeParameter ("v_object", "gpointer"));

			if (cl.is_private_symbol ()) {
				function.modifiers = CCodeModifiers.STATIC;
				// avoid C warning as this function is not always used
				function.attributes = "G_GNUC_UNUSED";
			} else if (context.hide_internal && cl.is_internal_symbol ()) {
				function.modifiers = CCodeModifiers.INTERNAL;
				// avoid C warning as this function is not always used
				function.attributes = "G_GNUC_UNUSED";
			}

			decl_space.add_function_declaration (function);

			function = new CCodeFunction (get_ccode_take_value_function (cl), "void");
			function.add_parameter (new CCodeParameter ("value", "GValue*"));
			function.add_parameter (new CCodeParameter ("v_object", "gpointer"));

			if (cl.is_private_symbol ()) {
				function.modifiers = CCodeModifiers.STATIC;
				// avoid C warning as this function is not always used
				function.attributes = "G_GNUC_UNUSED";
			} else if (context.hide_internal && cl.is_internal_symbol ()) {
				function.modifiers = CCodeModifiers.INTERNAL;
			}

			decl_space.add_function_declaration (function);

			function = new CCodeFunction (get_ccode_get_value_function (cl), "gpointer");
			function.add_parameter (new CCodeParameter ("value", "const GValue*"));

			if (cl.is_private_symbol ()) {
				function.modifiers = CCodeModifiers.STATIC;
				// avoid C warning as this function is not always used
				function.attributes = "G_GNUC_UNUSED";
			} else if (context.hide_internal && cl.is_internal_symbol ()) {
				function.modifiers = CCodeModifiers.INTERNAL;
				// avoid C warning as this function is not always used
				function.attributes = "G_GNUC_UNUSED";
			}

			decl_space.add_function_declaration (function);
		} else if (!is_gtypeinstance && !is_gsource) {
			if (cl.base_class == null) {
				var function = new CCodeFunction (get_ccode_lower_case_prefix (cl) + "free", "void");
				if (cl.is_private_symbol ()) {
					function.modifiers = CCodeModifiers.STATIC;
				} else if (context.hide_internal && cl.is_internal_symbol ()) {
					function.modifiers = CCodeModifiers.INTERNAL;
				}

				function.add_parameter (new CCodeParameter ("self", get_ccode_name (cl) + "*"));

				decl_space.add_function_declaration (function);
			}
		}

		if (is_gtypeinstance) {
			decl_space.add_type_declaration (new CCodeTypeDefinition ("struct _%sClass".printf (get_ccode_name (cl)), new CCodeVariableDeclarator ("%sClass".printf (get_ccode_name (cl)))));

			var type_fun = new ClassRegisterFunction (cl, context);
			type_fun.init_from_type (in_plugin, true);
			decl_space.add_type_member_declaration (type_fun.get_declaration ());
		}
	}

	public override void generate_class_struct_declaration (Class cl, CCodeFile decl_space) {
		if (add_symbol_declaration (decl_space, cl, "struct _" + get_ccode_name (cl))) {
			return;
		}

		if (cl.base_class != null) {
			// base class declaration
			generate_class_struct_declaration (cl.base_class, decl_space);
		}
		foreach (DataType base_type in cl.get_base_types ()) {
			var iface = base_type.data_type as Interface;
			if (iface != null) {
				generate_interface_declaration (iface, decl_space);
			}
		}

		generate_class_declaration (cl, decl_space);

		bool is_gtypeinstance = !cl.is_compact;
		bool is_fundamental = is_gtypeinstance && cl.base_class == null;
		bool is_gsource = cl.base_class == gsource_type;

		var instance_struct = new CCodeStruct ("_%s".printf (get_ccode_name (cl)));
		var type_struct = new CCodeStruct ("_%sClass".printf (get_ccode_name (cl)));

		if (cl.base_class != null) {
			instance_struct.add_field (get_ccode_name (cl.base_class), "parent_instance");
		} else if (is_fundamental) {
			decl_space.add_include ("glib-object.h");
			instance_struct.add_field ("GTypeInstance", "parent_instance");
			instance_struct.add_field ("volatile int", "ref_count");
		}

		if (cl.is_compact && cl.base_class == null && cl.get_fields ().size == 0) {
			// add dummy member, C doesn't allow empty structs
			instance_struct.add_field ("int", "dummy");
		}

		if (is_gtypeinstance) {
			decl_space.add_type_declaration (new CCodeTypeDefinition ("struct %sPrivate".printf (instance_struct.name), new CCodeVariableDeclarator ("%sPrivate".printf (get_ccode_name (cl)))));

			instance_struct.add_field ("%sPrivate *".printf (get_ccode_name (cl)), "priv");
			if (is_fundamental) {
				type_struct.add_field ("GTypeClass", "parent_class");
			} else {
				type_struct.add_field ("%sClass".printf (get_ccode_name (cl.base_class)), "parent_class");
			}

			if (is_fundamental) {
				type_struct.add_field ("void", "(*finalize) (%s *self)".printf (get_ccode_name (cl)));
			}
		}

		foreach (Method m in cl.get_methods ()) {
			generate_virtual_method_declaration (m, decl_space, type_struct);
		}

		foreach (Signal sig in cl.get_signals ()) {
			if (sig.default_handler != null) {
				generate_virtual_method_declaration (sig.default_handler, decl_space, type_struct);
			}
		}

		foreach (Property prop in cl.get_properties ()) {
			if (!prop.is_abstract && !prop.is_virtual) {
				continue;
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
					var cvalueparam = new CCodeParameter ("result", get_ccode_name (prop.get_accessor.value_type) + "*");
					vdeclarator.add_parameter (cvalueparam);
					creturn_type = "void";
				} else {
					creturn_type = get_ccode_name (prop.get_accessor.value_type);
				}

				var array_type = prop.property_type as ArrayType;
				if (array_type != null) {
					for (int dim = 1; dim <= array_type.rank; dim++) {
						vdeclarator.add_parameter (new CCodeParameter (get_array_length_cname ("result", dim), "int*"));
					}
				} else if ((prop.property_type is DelegateType) && ((DelegateType) prop.property_type).delegate_symbol.has_target) {
					vdeclarator.add_parameter (new CCodeParameter (get_delegate_target_cname ("result"), "gpointer*"));
				}

				var vdecl = new CCodeDeclaration (creturn_type);
				vdecl.add_declarator (vdeclarator);
				type_struct.add_declaration (vdecl);
			}
			if (prop.set_accessor != null) {
				CCodeParameter cvalueparam;
				if (prop.property_type.is_real_non_null_struct_type ()) {
					cvalueparam = new CCodeParameter ("value", get_ccode_name (prop.set_accessor.value_type) + "*");
				} else {
					cvalueparam = new CCodeParameter ("value", get_ccode_name (prop.set_accessor.value_type));
				}

				var vdeclarator = new CCodeFunctionDeclarator ("set_%s".printf (prop.name));
				vdeclarator.add_parameter (cselfparam);
				vdeclarator.add_parameter (cvalueparam);

				var array_type = prop.property_type as ArrayType;
				if (array_type != null) {
					for (int dim = 1; dim <= array_type.rank; dim++) {
						vdeclarator.add_parameter (new CCodeParameter (get_array_length_cname ("value", dim), "int"));
					}
				} else if ((prop.property_type is DelegateType) && ((DelegateType) prop.property_type).delegate_symbol.has_target) {
					vdeclarator.add_parameter (new CCodeParameter (get_delegate_target_cname ("value"), "gpointer"));
				}

				var vdecl = new CCodeDeclaration ("void");
				vdecl.add_declarator (vdeclarator);
				type_struct.add_declaration (vdecl);
			}
		}

		foreach (Field f in cl.get_fields ()) {
			string field_ctype = get_ccode_name (f.variable_type);
			if (f.is_volatile) {
				field_ctype = "volatile " + field_ctype;
			}

			if (f.access != SymbolAccessibility.PRIVATE) {
				if (f.binding == MemberBinding.INSTANCE) {
					generate_type_declaration (f.variable_type, decl_space);

					instance_struct.add_field (field_ctype, get_ccode_name (f), get_ccode_declarator_suffix (f.variable_type));
					if (f.variable_type is ArrayType && get_ccode_array_length (f)) {
						// create fields to store array dimensions
						var array_type = (ArrayType) f.variable_type;

						if (!array_type.fixed_length) {
							var len_type = int_type.copy ();

							for (int dim = 1; dim <= array_type.rank; dim++) {
								string length_cname;
								if (get_ccode_array_length_name (f) != null) {
									length_cname = get_ccode_array_length_name (f);
								} else {
									length_cname = get_array_length_cname (f.name, dim);
								}
								instance_struct.add_field (get_ccode_name (len_type), length_cname);
							}

							if (array_type.rank == 1 && f.is_internal_symbol ()) {
								instance_struct.add_field (get_ccode_name (len_type), get_array_size_cname (f.name));
							}
						}
					} else if (f.variable_type is DelegateType) {
						var delegate_type = (DelegateType) f.variable_type;
						if (delegate_type.delegate_symbol.has_target) {
							// create field to store delegate target
							instance_struct.add_field ("gpointer", get_ccode_delegate_target_name (f));
							if (delegate_type.is_disposable ()) {
								instance_struct.add_field ("GDestroyNotify", get_delegate_target_destroy_notify_cname (f.name));
							}
						}
					}
				} else if (f.binding == MemberBinding.CLASS) {
					type_struct.add_field (field_ctype, get_ccode_name (f));
				}
			}
		}

		if (!cl.is_compact || cl.base_class == null || is_gsource) {
			// derived compact classes do not have a struct
			decl_space.add_type_definition (instance_struct);
		}

		if (is_gtypeinstance) {
			decl_space.add_type_definition (type_struct);
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

		generate_cparameters (m, decl_space, cparam_map, new CCodeFunction ("fake"), vdeclarator);

		var vdecl = new CCodeDeclaration (get_ccode_name (creturn_type));
		vdecl.add_declarator (vdeclarator);
		type_struct.add_declaration (vdecl);
	}

	void generate_class_private_declaration (Class cl, CCodeFile decl_space) {
		if (decl_space.add_declaration (get_ccode_name (cl) + "Private")) {
			return;
		}

		bool is_gtypeinstance = !cl.is_compact;
		bool has_class_locks = false;

		var instance_priv_struct = new CCodeStruct ("_%sPrivate".printf (get_ccode_name (cl)));
		var type_priv_struct = new CCodeStruct ("_%sClassPrivate".printf (get_ccode_name (cl)));

		if (is_gtypeinstance) {
			/* create type, dup_func, and destroy_func fields for generic types */
			foreach (TypeParameter type_param in cl.get_type_parameters ()) {
				string func_name;

				func_name = "%s_type".printf (type_param.name.down ());
				instance_priv_struct.add_field ("GType", func_name);

				func_name = "%s_dup_func".printf (type_param.name.down ());
				instance_priv_struct.add_field ("GBoxedCopyFunc", func_name);

				func_name = "%s_destroy_func".printf (type_param.name.down ());
				instance_priv_struct.add_field ("GDestroyNotify", func_name);
			}
		}

		foreach (Field f in cl.get_fields ()) {
			string field_ctype = get_ccode_name (f.variable_type);
			if (f.is_volatile) {
				field_ctype = "volatile " + field_ctype;
			}

			if (f.binding == MemberBinding.INSTANCE) {
				if (f.access == SymbolAccessibility.PRIVATE)  {
					generate_type_declaration (f.variable_type, decl_space);

					instance_priv_struct.add_field (field_ctype, get_ccode_name (f), get_ccode_declarator_suffix (f.variable_type));
					if (f.variable_type is ArrayType && get_ccode_array_length (f)) {
						// create fields to store array dimensions
						var array_type = (ArrayType) f.variable_type;
						var len_type = int_type.copy ();

						if (!array_type.fixed_length) {
							for (int dim = 1; dim <= array_type.rank; dim++) {
								string length_cname;
								if (get_ccode_array_length_name (f) != null) {
									length_cname = get_ccode_array_length_name (f);
								} else {
									length_cname = get_array_length_cname (f.name, dim);
								}
								instance_priv_struct.add_field (get_ccode_name (len_type), length_cname);
							}

							if (array_type.rank == 1 && f.is_internal_symbol ()) {
								instance_priv_struct.add_field (get_ccode_name (len_type), get_array_size_cname (f.name));
							}
						}
					} else if (f.variable_type is DelegateType) {
						var delegate_type = (DelegateType) f.variable_type;
						if (delegate_type.delegate_symbol.has_target) {
							// create field to store delegate target
							instance_priv_struct.add_field ("gpointer", get_ccode_delegate_target_name (f));
							if (delegate_type.is_disposable ()) {
								instance_priv_struct.add_field ("GDestroyNotify", get_delegate_target_destroy_notify_cname (f.name));
							}
						}
					}
				}

				if (f.get_lock_used ()) {
					cl.has_private_fields = true;
					// add field for mutex
					instance_priv_struct.add_field (get_ccode_name (mutex_type), get_symbol_lock_name (f.name));
				}
			} else if (f.binding == MemberBinding.CLASS) {
				if (f.access == SymbolAccessibility.PRIVATE) {
					type_priv_struct.add_field (field_ctype, get_ccode_name (f));
				}

				if (f.get_lock_used ()) {
					has_class_locks = true;
					// add field for mutex
					type_priv_struct.add_field (get_ccode_name (mutex_type), get_symbol_lock_name (get_ccode_name (f)));
				}
			}
		}

		foreach (Property prop in cl.get_properties ()) {
			if (prop.binding == MemberBinding.INSTANCE) {
				if (prop.get_lock_used ()) {
					cl.has_private_fields = true;
					// add field for mutex
					instance_priv_struct.add_field (get_ccode_name (mutex_type), get_symbol_lock_name (prop.name));
				}
			} else if (prop.binding == MemberBinding.CLASS) {
				if (prop.get_lock_used ()) {
					has_class_locks = true;
					// add field for mutex
					type_priv_struct.add_field (get_ccode_name (mutex_type), get_symbol_lock_name (prop.name));
				}
			}
		}

		if (is_gtypeinstance) {
			if (cl.has_class_private_fields || has_class_locks) {
				decl_space.add_type_declaration (new CCodeTypeDefinition ("struct %s".printf (type_priv_struct.name), new CCodeVariableDeclarator ("%sClassPrivate".printf (get_ccode_name (cl)))));
			}

			/* only add the *Private struct if it is not empty, i.e. we actually have private data */
			if (cl.has_private_fields || cl.get_type_parameters ().size > 0) {
				decl_space.add_type_definition (instance_priv_struct);
				var macro = "(G_TYPE_INSTANCE_GET_PRIVATE ((o), %s, %sPrivate))".printf (get_ccode_type_id (cl), get_ccode_name (cl));
				decl_space.add_type_member_declaration (new CCodeMacroReplacement ("%s_GET_PRIVATE(o)".printf (get_ccode_upper_case_name (cl, null)), macro));
			}

			if (cl.has_class_private_fields || has_class_locks) {
				decl_space.add_type_member_declaration (type_priv_struct);

				string macro = "(G_TYPE_CLASS_GET_PRIVATE (klass, %s, %sClassPrivate))".printf (get_ccode_type_id (cl), get_ccode_name (cl));
				decl_space.add_type_member_declaration (new CCodeMacroReplacement ("%s_GET_CLASS_PRIVATE(klass)".printf (get_ccode_upper_case_name (cl, null)), macro));
			}
			decl_space.add_type_member_declaration (prop_enum);
		} else {
			if (cl.has_private_fields) {
				Report.error (cl.source_reference, "Private fields not supported in compact classes");
			}
		}
	}

	public override void visit_class (Class cl) {
		push_context (new EmitContext (cl));
		push_line (cl.source_reference);

		var old_param_spec_struct = param_spec_struct;
		var old_prop_enum = prop_enum;
		var old_class_init_context = class_init_context;
		var old_base_init_context = base_init_context;
		var old_class_finalize_context = class_finalize_context;
		var old_base_finalize_context = base_finalize_context;
		var old_instance_init_context = instance_init_context;
		var old_instance_finalize_context = instance_finalize_context;

		bool is_gtypeinstance = !cl.is_compact;
		bool is_fundamental = is_gtypeinstance && cl.base_class == null;

		if (get_ccode_name (cl).length < 3) {
			cl.error = true;
			Report.error (cl.source_reference, "Class name `%s' is too short".printf (get_ccode_name (cl)));
			return;
		}

		prop_enum = new CCodeEnum ();
		prop_enum.add_value (new CCodeEnumValue ("%s_DUMMY_PROPERTY".printf (get_ccode_upper_case_name (cl, null))));
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

		if (is_gtypeinstance) {
			begin_base_init_function (cl);
			begin_class_init_function (cl);
			begin_instance_init_function (cl);

			begin_base_finalize_function (cl);
			begin_class_finalize_function (cl);
			begin_finalize_function (cl);
		} else {
			if (cl.base_class == null || cl.base_class == gsource_type) {
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


				gvaluecollector_h_needed = true;

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
				if (base_type.data_type is Interface) {
					add_interface_init_function (cl, (Interface) base_type.data_type);
				}
			}
			
			add_instance_init_function (cl);

			if (!cl.is_compact && (cl.get_fields ().size > 0 || cl.destructor != null || cl.is_fundamental ())) {
				add_finalize_function (cl);
			}

			if (cl.comment != null) {
				cfile.add_type_member_definition (new CCodeComment (cl.comment.content));
			}

			var type_fun = new ClassRegisterFunction (cl, context);
			type_fun.init_from_type (in_plugin, false);
			cfile.add_type_member_declaration (type_fun.get_source_declaration ());
			cfile.add_type_member_definition (type_fun.get_definition ());

			if (is_fundamental) {
				var ref_count = new CCodeMemberAccess.pointer (new CCodeIdentifier ("self"), "ref_count");

				// ref function
				var ref_fun = new CCodeFunction (get_ccode_lower_case_prefix (cl) + "ref", "gpointer");
				ref_fun.add_parameter (new CCodeParameter ("instance", "gpointer"));
				if (cl.is_private_symbol ()) {
					ref_fun.modifiers = CCodeModifiers.STATIC;
				} else if (context.hide_internal && cl.is_internal_symbol ()) {
					ref_fun.modifiers = CCodeModifiers.INTERNAL;
				}
				push_function (ref_fun);

				ccode.add_declaration (get_ccode_name (cl) + "*", new CCodeVariableDeclarator ("self", new CCodeIdentifier ("instance")));
				var ccall = new CCodeFunctionCall (new CCodeIdentifier ("g_atomic_int_inc"));
				ccall.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, ref_count));
				ccode.add_expression (ccall);
				ccode.add_return (new CCodeIdentifier ("instance"));

				pop_function ();
				cfile.add_function (ref_fun);

				// unref function
				var unref_fun = new CCodeFunction (get_ccode_lower_case_prefix (cl) + "unref", "void");
				unref_fun.add_parameter (new CCodeParameter ("instance", "gpointer"));
				if (cl.is_private_symbol ()) {
					unref_fun.modifiers = CCodeModifiers.STATIC;
				} else if (context.hide_internal && cl.is_internal_symbol ()) {
					unref_fun.modifiers = CCodeModifiers.INTERNAL;
				}
				push_function (unref_fun);

				ccode.add_declaration (get_ccode_name (cl) + "*", new CCodeVariableDeclarator ("self", new CCodeIdentifier ("instance")));
				ccall = new CCodeFunctionCall (new CCodeIdentifier ("g_atomic_int_dec_and_test"));
				ccall.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, ref_count));
				ccode.open_if (ccall);

				var get_class = new CCodeFunctionCall (new CCodeIdentifier ("%s_GET_CLASS".printf (get_ccode_upper_case_name (cl, null))));
				get_class.add_argument (new CCodeIdentifier ("self"));

				// finalize class
				var ccast = new CCodeFunctionCall (new CCodeIdentifier ("%s_GET_CLASS".printf (get_ccode_upper_case_name (cl, null))));
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
			if (cl.base_class == null || cl.base_class == gsource_type) {
				// derived compact classes do not have fields
				add_instance_init_function (cl);
				add_finalize_function (cl);
			}
		}

		param_spec_struct = old_param_spec_struct;
		prop_enum = old_prop_enum;
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
		var ccall = new CCodeFunctionCall (new CCodeIdentifier (get_ccode_lower_case_prefix (cl) + "unref"));
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

		var ref_ccall = new CCodeFunctionCall (new CCodeIdentifier (get_ccode_lower_case_prefix (cl) + "ref"));
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

		ccode.add_declaration (get_ccode_name (cl) + "**", new CCodeVariableDeclarator ("object_p", new CCodeMemberAccess (new CCodeIdentifier ("collect_values[0]"), "v_pointer")));

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
		ccode.add_declaration (get_ccode_name (cl) + "*", new CCodeVariableDeclarator ("object", collect_vpointer));
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
		string function_name = get_ccode_lower_case_name (cl, "param_spec_");

		var function = new CCodeFunction (function_name, "GParamSpec*");
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
		ccall.add_argument (new CCodeIdentifier ("NULL"));
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

		ccode.add_declaration (get_ccode_name (cl)+"*", new CCodeVariableDeclarator ("old"));

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

		ccode.add_declaration (get_ccode_name (cl)+"*", new CCodeVariableDeclarator ("old"));

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
		ccall.add_argument (new CCodeIdentifier ("NULL"));
		ccode.add_expression (ccall);

		ccode.add_return (vpointer);

		pop_function ();
		cfile.add_function (function);
	}

	private void begin_base_init_function (Class cl) {
		push_context (base_init_context);

		var base_init = new CCodeFunction ("%s_base_init".printf (get_ccode_lower_case_name (cl, null)), "void");
		base_init.add_parameter (new CCodeParameter ("klass", "%sClass *".printf (get_ccode_name (cl))));
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
		func.add_parameter (new CCodeParameter ("klass", "%sClass *".printf (get_ccode_name (cl))));
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

			var ccast = new CCodeCastExpression (new CCodeIdentifier ("klass"), get_ccode_name (fundamental_class) + "Class *");
			var finalize_assignment = new CCodeAssignment (new CCodeMemberAccess.pointer (ccast, "finalize"), new CCodeIdentifier (get_ccode_lower_case_prefix (cl) + "finalize"));
			ccode.add_expression (finalize_assignment);
		}

		/* add struct for private fields */
		if (cl.has_private_fields || cl.get_type_parameters ().size > 0) {
			ccall = new CCodeFunctionCall (new CCodeIdentifier ("g_type_class_add_private"));
			ccall.add_argument (new CCodeIdentifier ("klass"));
			ccall.add_argument (new CCodeConstant ("sizeof (%sPrivate)".printf (get_ccode_name (cl))));
			ccode.add_expression (ccall);
		}

		/* connect overridden methods */
		foreach (Method m in cl.get_methods ()) {
			if (m.base_method == null) {
				continue;
			}
			var base_type = m.base_method.parent_symbol;

			// there is currently no default handler for abstract async methods
			if (!m.is_abstract || !m.coroutine) {
				var ccast = new CCodeCastExpression (new CCodeIdentifier ("klass"), get_ccode_name (base_type) + "Class *");
				ccode.add_assignment (new CCodeMemberAccess.pointer (ccast, get_ccode_vfunc_name (m.base_method)), new CCodeIdentifier (get_ccode_real_name (m)));

				if (m.coroutine) {
					ccode.add_assignment (new CCodeMemberAccess.pointer (ccast, get_ccode_finish_vfunc_name (m.base_method)), new CCodeIdentifier (get_ccode_finish_real_name (m)));
				}
			}
		}

		/* connect default signal handlers */
		foreach (Signal sig in cl.get_signals ()) {
			if (sig.default_handler == null) {
				continue;
			}
			var ccast = new CCodeCastExpression (new CCodeIdentifier ("klass"), get_ccode_name (cl) + "Class *");
			ccode.add_assignment (new CCodeMemberAccess.pointer (ccast, get_ccode_vfunc_name (sig.default_handler)), new CCodeIdentifier (get_ccode_real_name (sig.default_handler)));
		}

		/* connect overridden properties */
		foreach (Property prop in cl.get_properties ()) {
			if (prop.base_property == null) {
				continue;
			}
			var base_type = prop.base_property.parent_symbol;
			
			var ccast = new CCodeFunctionCall (new CCodeIdentifier ("%s_CLASS".printf (get_ccode_upper_case_name (base_type))));
			ccast.add_argument (new CCodeIdentifier ("klass"));

			if (!get_ccode_no_accessor_method (prop.base_property)) {
				if (prop.get_accessor != null) {
					string cname = CCodeBaseModule.get_ccode_real_name (prop.get_accessor);
					ccode.add_assignment (new CCodeMemberAccess.pointer (ccast, "get_%s".printf (prop.name)), new CCodeIdentifier (cname));
				}
				if (prop.set_accessor != null) {
					string cname = CCodeBaseModule.get_ccode_real_name (prop.set_accessor);
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
		var this_type = get_data_type_for_symbol (cl);
		function.add_parameter (new CCodeParameter ("self", get_ccode_name (this_type)));
		push_function (function);
		ccode.add_return (expression);
		pop_function ();
		cfile.add_function (function);

		CCodeExpression cfunc = new CCodeIdentifier (function.name);
		string cast = return_type + "(*)";
		string cast_args = get_ccode_name (iface) + "*";
		cast += "(" + cast_args + ")";
		cfunc = new CCodeCastExpression (cfunc, cast);
		var ciface = new CCodeIdentifier ("iface");
		ccode.add_assignment (new CCodeMemberAccess.pointer (ciface, base_name), cfunc);
	}

	private void add_interface_init_function (Class cl, Interface iface) {
		var iface_init = new CCodeFunction ("%s_%s_interface_init".printf (get_ccode_lower_case_name (cl), get_ccode_lower_case_name (iface)), "void");
		iface_init.add_parameter (new CCodeParameter ("iface", "%s *".printf (get_ccode_type_name (iface))));
		iface_init.modifiers = CCodeModifiers.STATIC;

		push_function (iface_init);
		
		CCodeFunctionCall ccall;
		
		/* save pointer to parent vtable */
		string parent_iface_var = "%s_%s_parent_iface".printf (get_ccode_lower_case_name (cl), get_ccode_lower_case_name (iface));
		var parent_decl = new CCodeDeclaration (get_ccode_type_name (iface) + "*");
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
			
			var ciface = new CCodeIdentifier ("iface");
			CCodeExpression cfunc;
			if (m.is_abstract || m.is_virtual) {
				cfunc = new CCodeIdentifier (get_ccode_name (m));
			} else {
				cfunc = new CCodeIdentifier (get_ccode_real_name (m));
			}
			cfunc = cast_method_pointer (m.base_interface_method, cfunc, iface);
			ccode.add_assignment (new CCodeMemberAccess.pointer (ciface, get_ccode_vfunc_name (m.base_interface_method)), cfunc);

			if (m.coroutine) {
				if (m.is_abstract || m.is_virtual) {
					cfunc = new CCodeIdentifier (get_ccode_finish_name (m));
				} else {
					cfunc = new CCodeIdentifier (get_ccode_finish_real_name (m));
				}
				ccode.add_assignment (new CCodeMemberAccess.pointer (ciface, get_ccode_finish_vfunc_name (m.base_interface_method)), cfunc);
			}
		}

		if (iface.get_attribute ("GenericAccessors") != null) {
			foreach (TypeParameter p in iface.get_type_parameters ()) {
				GenericType p_type = new GenericType (p);
				DataType p_data_type = p_type.get_actual_type (get_data_type_for_symbol (cl), null, cl);

				add_generic_accessor_function ("get_%s_type".printf (p.name.down ()),
				                               "GType",
				                               get_type_id_expression (p_data_type),
				                               p, cl, iface);

				add_generic_accessor_function ("get_%s_dup_func".printf (p.name.down ()),
				                               "GBoxedCopyFunc",
				                               get_dup_func_expression (p_data_type, null),
				                               p, cl, iface);

				add_generic_accessor_function ("get_%s_destroy_func".printf (p.name.down ()),
				                               "GDestroyNotify",
				                               get_destroy_func_expression (p_data_type),
				                               p, cl, iface);
			}
		}

		// connect inherited implementations
		foreach (Method m in iface.get_methods ()) {
			if (m.is_abstract) {
				Method cl_method = null;
				var base_class = cl;
				while (base_class != null && cl_method == null) {
					cl_method = base_class.scope.lookup (m.name) as Method;
					base_class = base_class.base_class;
				}
				if (base_class != null && cl_method.parent_symbol != cl) {
					// method inherited from base class

					var base_method = cl_method;
					if (cl_method.base_method != null) {
						base_method = cl_method.base_method;
					} else if (cl_method.base_interface_method != null) {
						base_method = cl_method.base_interface_method;
					}

					generate_method_declaration (base_method, cfile);

					CCodeExpression cfunc = new CCodeIdentifier (get_ccode_name (base_method));
					cfunc = cast_method_pointer (base_method, cfunc, iface);
					var ciface = new CCodeIdentifier ("iface");
					ccode.add_assignment (new CCodeMemberAccess.pointer (ciface, get_ccode_vfunc_name (m)), cfunc);
				}
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

			if (!get_ccode_no_accessor_method (prop.base_interface_property)) {
				if (prop.get_accessor != null) {
					string cname = CCodeBaseModule.get_ccode_real_name (prop.get_accessor);
					if (prop.is_abstract || prop.is_virtual) {
						cname = CCodeBaseModule.get_ccode_name (prop.get_accessor);
					}

					CCodeExpression cfunc = new CCodeIdentifier (cname);
					if (prop.is_abstract || prop.is_virtual) {
						cfunc = cast_property_accessor_pointer (prop.get_accessor, cfunc, base_type);
					}
					ccode.add_assignment (new CCodeMemberAccess.pointer (ciface, "get_%s".printf (prop.name)), cfunc);
				}
				if (prop.set_accessor != null) {
					string cname = CCodeBaseModule.get_ccode_real_name (prop.set_accessor);
					if (prop.is_abstract || prop.is_virtual) {
						cname = CCodeBaseModule.get_ccode_name (prop.set_accessor);
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

				var ciface = new CCodeIdentifier ("iface");

				if (base_property.get_accessor != null) {
					generate_property_accessor_declaration (base_property.get_accessor, cfile);

					string cname = get_ccode_name (base_property.get_accessor);
					CCodeExpression cfunc = new CCodeIdentifier (cname);
					cfunc = cast_property_accessor_pointer (prop.get_accessor, cfunc, iface);
					ccode.add_assignment (new CCodeMemberAccess.pointer (ciface, "get_%s".printf (prop.name)), cfunc);
				}
				if (base_property.set_accessor != null) {
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

	CCodeExpression cast_method_pointer (Method m, CCodeExpression cfunc, ObjectTypeSymbol base_type) {
		// Cast the function pointer to match the interface
		string cast;
		if (m.return_type.is_real_non_null_struct_type ()) {
			cast = "void (*)";
		} else {
			cast = get_ccode_name (m.return_type) + " (*)";
		}
		string cast_args = get_ccode_name (base_type) + "*";

		var vdeclarator = new CCodeFunctionDeclarator (get_ccode_vfunc_name (m));
		var cparam_map = new HashMap<int,CCodeParameter> (direct_hash, direct_equal);

		generate_cparameters (m, cfile, cparam_map, new CCodeFunction ("fake"), vdeclarator);

		// append C arguments in the right order
		int last_pos = -1;
		int min_pos;
		while (true) {
			min_pos = -1;
			foreach (int pos in cparam_map.get_keys ()) {
				if (pos > last_pos && (min_pos == -1 || pos < min_pos)) {
					min_pos = pos;
				}
			}
			if (last_pos != -1) { // Skip the 1st parameter
				if (min_pos == -1) {
					break;
				}

				var tmp = cparam_map.get (min_pos);
				if (tmp.ellipsis) {
					cast_args += ", " + " ...";
				} else {
					cast_args += ", " + tmp.type_name;
				}
			}
			last_pos = min_pos;
		}
		cast += "(" + cast_args + ")";
		return new CCodeCastExpression (cfunc, cast);
	}

	private void begin_instance_init_function (Class cl) {
		push_context (instance_init_context);

		var func = new CCodeFunction ("%s_instance_init".printf (get_ccode_lower_case_name (cl, null)));
		func.add_parameter (new CCodeParameter ("self", "%s *".printf (get_ccode_name (cl))));
		func.modifiers = CCodeModifiers.STATIC;

		push_function (func);

		if (cl.is_compact) {
			// Add declaration, since the instance_init function is explicitly called
			// by the creation methods
			cfile.add_function_declaration (func);
		}

		if (!cl.is_compact && (cl.has_private_fields || cl.get_type_parameters ().size > 0)) {
			var ccall = new CCodeFunctionCall (new CCodeIdentifier ("%s_GET_PRIVATE".printf (get_ccode_upper_case_name (cl, null))));
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

		function.add_parameter (new CCodeParameter ("klass", get_ccode_name (cl) + "Class *"));

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

		function.add_parameter (new CCodeParameter ("klass", get_ccode_name (cl) + "Class *"));

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

			var func = new CCodeFunction ("%s_finalize".printf (get_ccode_lower_case_name (cl, null)));
			func.add_parameter (new CCodeParameter ("obj", get_ccode_name (fundamental_class) + "*"));
			func.modifiers = CCodeModifiers.STATIC;

			push_function (func);

			if (is_gsource) {
				cfile.add_function_declaration (func);
			}

			CCodeExpression ccast;
			if (!cl.is_compact) {
				ccast = generate_instance_cast (new CCodeIdentifier ("obj"), cl);
			} else {
				ccast = new CCodeCastExpression (new CCodeIdentifier ("obj"), get_ccode_name (cl) + "*");
			}

			ccode.add_declaration ("%s *".printf (get_ccode_name (cl)), new CCodeVariableDeclarator ("self"));
			ccode.add_assignment (new CCodeIdentifier ("self"), ccast);

			if (!cl.is_compact && cl.base_class == null) {
				// non-gobject class
				var call = new CCodeFunctionCall (new CCodeIdentifier ("g_signal_handlers_destroy"));
				call.add_argument (new CCodeIdentifier ("self"));
				ccode.add_expression (call);
			}
		} else {
			var function = new CCodeFunction (get_ccode_lower_case_prefix (cl) + "free", "void");
			if (cl.is_private_symbol ()) {
				function.modifiers = CCodeModifiers.STATIC;
			} else if (context.hide_internal && cl.is_internal_symbol ()) {
				function.modifiers = CCodeModifiers.INTERNAL;
			}

			function.add_parameter (new CCodeParameter ("self", get_ccode_name (cl) + "*"));

			push_function (function);
		}

		if (cl.destructor != null) {
			cl.destructor.body.emit (this);

			if (current_method_inner_error) {
				ccode.add_declaration ("GError *", new CCodeVariableDeclarator.zero ("_inner_error_", new CCodeConstant ("NULL")));
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
				var ccast = new CCodeFunctionCall (new CCodeIdentifier ("%s_CLASS".printf (get_ccode_upper_case_name (fundamental_class))));
				ccast.add_argument (new CCodeIdentifier ("%s_parent_class".printf (get_ccode_lower_case_name (cl, null))));
				var ccall = new CCodeFunctionCall (new CCodeMemberAccess.pointer (ccast, "finalize"));
				ccall.add_argument (new CCodeIdentifier ("obj"));
				push_context (instance_finalize_context);
				ccode.add_expression (ccall);
				pop_context ();
			}

			cfile.add_function_declaration (instance_finalize_context.ccode);
		} else if (cl.base_class == null) {
			var ccall = new CCodeFunctionCall (new CCodeIdentifier ("g_slice_free"));
			ccall.add_argument (new CCodeIdentifier (get_ccode_name (cl)));
			ccall.add_argument (new CCodeIdentifier ("self"));
			push_context (instance_finalize_context);
			ccode.add_expression (ccall);
			pop_context ();
		}

		cfile.add_function (instance_finalize_context.ccode);
	}

	public override CCodeFunctionCall get_param_spec (Property prop) {
		var cspec = new CCodeFunctionCall ();
		cspec.add_argument (get_property_canonical_cconstant (prop));
		var nick = get_ccode_nick (prop);
		var blurb = get_ccode_blurb (prop);
		cspec.add_argument (new CCodeConstant ("\"%s\"".printf (nick)));
		cspec.add_argument (new CCodeConstant ("\"%s\"".printf (blurb)));


		if (prop.property_type.data_type is Class || prop.property_type.data_type is Interface) {
			string param_spec_name = get_ccode_param_spec_function (prop.property_type.data_type);
			cspec.call = new CCodeIdentifier (param_spec_name);
			if (param_spec_name == "g_param_spec_string") {
				cspec.add_argument (new CCodeConstant ("NULL"));
			} else if (param_spec_name == "g_param_spec_variant") {
				cspec.add_argument (new CCodeConstant ("G_VARIANT_TYPE_ANY"));
				cspec.add_argument (new CCodeConstant ("NULL"));
			} else if (get_ccode_type_id (prop.property_type.data_type) != "G_TYPE_POINTER") {
				cspec.add_argument (new CCodeIdentifier (get_ccode_type_id (prop.property_type.data_type)));
			}
		} else if (prop.property_type.data_type is Enum) {
			var e = prop.property_type.data_type as Enum;
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
				cspec.add_argument (new CCodeConstant (get_ccode_default_value (prop.property_type.data_type)));
			}
		} else if (prop.property_type.data_type is Struct) {
			var st = (Struct) prop.property_type.data_type;
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
		} else if (prop.property_type is ArrayType && ((ArrayType)prop.property_type).element_type.data_type == string_type.data_type) {
			cspec.call = new CCodeIdentifier ("g_param_spec_boxed");
			cspec.add_argument (new CCodeIdentifier ("G_TYPE_STRV"));
		} else {
			cspec.call = new CCodeIdentifier ("g_param_spec_pointer");
		}
		
		var pflags = "G_PARAM_STATIC_NAME | G_PARAM_STATIC_NICK | G_PARAM_STATIC_BLURB";
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
		cspec.add_argument (new CCodeConstant (pflags));

		return cspec;
	}

	public override void generate_interface_declaration (Interface iface, CCodeFile decl_space) {
		if (add_symbol_declaration (decl_space, iface, get_ccode_name (iface))) {
			return;
		}

		foreach (DataType prerequisite in iface.get_prerequisites ()) {
			var prereq_cl = prerequisite.data_type as Class;
			var prereq_iface = prerequisite.data_type as Interface;
			if (prereq_cl != null) {
				generate_class_declaration (prereq_cl, decl_space);
			} else if (prereq_iface != null) {
				generate_interface_declaration (prereq_iface, decl_space);
			}
		}

		var type_struct = new CCodeStruct ("_%s".printf (get_ccode_type_name (iface)));
		
		decl_space.add_type_declaration (new CCodeNewline ());
		var macro = "(%s_get_type ())".printf (get_ccode_lower_case_name (iface, null));
		decl_space.add_type_declaration (new CCodeMacroReplacement (get_ccode_type_id (iface), macro));

		macro = "(G_TYPE_CHECK_INSTANCE_CAST ((obj), %s, %s))".printf (get_ccode_type_id (iface), get_ccode_name (iface));
		decl_space.add_type_declaration (new CCodeMacroReplacement ("%s(obj)".printf (get_ccode_upper_case_name (iface, null)), macro));

		macro = "(G_TYPE_CHECK_INSTANCE_TYPE ((obj), %s))".printf (get_ccode_type_id (iface));
		decl_space.add_type_declaration (new CCodeMacroReplacement ("%s(obj)".printf (get_ccode_type_check_function (iface)), macro));

		macro = "(G_TYPE_INSTANCE_GET_INTERFACE ((obj), %s, %s))".printf (get_ccode_type_id (iface), get_ccode_type_name (iface));
		decl_space.add_type_declaration (new CCodeMacroReplacement ("%s_GET_INTERFACE(obj)".printf (get_ccode_upper_case_name (iface, null)), macro));
		decl_space.add_type_declaration (new CCodeNewline ());

		decl_space.add_type_declaration (new CCodeTypeDefinition ("struct _%s".printf (get_ccode_name (iface)), new CCodeVariableDeclarator (get_ccode_name (iface))));
		decl_space.add_type_declaration (new CCodeTypeDefinition ("struct %s".printf (type_struct.name), new CCodeVariableDeclarator (get_ccode_type_name (iface))));

		type_struct.add_field ("GTypeInterface", "parent_iface");

		if (iface.get_attribute ("GenericAccessors") != null) {
			foreach (TypeParameter p in iface.get_type_parameters ()) {
				string method_name = "get_%s_type".printf (p.name.down ());
				var vdeclarator = new CCodeFunctionDeclarator (method_name);
				var this_type = get_data_type_for_symbol (iface);
				vdeclarator.add_parameter (new CCodeParameter ("self", get_ccode_name (this_type)));

				var vdecl = new CCodeDeclaration ("GType");
				vdecl.add_declarator (vdeclarator);
				type_struct.add_declaration (vdecl);

				method_name = "get_%s_dup_func".printf (p.name.down ());
				vdeclarator = new CCodeFunctionDeclarator (method_name);
				this_type = get_data_type_for_symbol (iface);
				vdeclarator.add_parameter (new CCodeParameter ("self", get_ccode_name (this_type)));

				vdecl = new CCodeDeclaration ("GBoxedCopyFunc");
				vdecl.add_declarator (vdeclarator);
				type_struct.add_declaration (vdecl);

				method_name = "get_%s_destroy_func".printf (p.name.down ());
				vdeclarator = new CCodeFunctionDeclarator (method_name);
				this_type = get_data_type_for_symbol (iface);
				vdeclarator.add_parameter (new CCodeParameter ("self", get_ccode_name (this_type)));

				vdecl = new CCodeDeclaration ("GDestroyNotify");
				vdecl.add_declarator (vdeclarator);
				type_struct.add_declaration (vdecl);
			}
		}

		foreach (Symbol sym in iface.get_virtuals ()) {
			Method m;
			Signal sig;
			Property prop;
			if ((m = sym as Method) != null) {
				generate_virtual_method_declaration (m, decl_space, type_struct);
			} else if ((sig = sym as Signal) != null) {
				if (sig.default_handler != null) {
					generate_virtual_method_declaration (sig.default_handler, decl_space, type_struct);
				}
			} else if ((prop = sym as Property) != null) {
				generate_type_declaration (prop.property_type, decl_space);

				var t = (ObjectTypeSymbol) prop.parent_symbol;

				bool returns_real_struct = prop.property_type.is_real_non_null_struct_type ();

				var this_type = new ObjectType (t);
				var cselfparam = new CCodeParameter ("self", get_ccode_name (this_type));

				if (prop.get_accessor != null) {
					var vdeclarator = new CCodeFunctionDeclarator ("get_%s".printf (prop.name));
					vdeclarator.add_parameter (cselfparam);
					string creturn_type;
					if (returns_real_struct) {
						var cvalueparam = new CCodeParameter ("value", get_ccode_name (prop.get_accessor.value_type) + "*");
						vdeclarator.add_parameter (cvalueparam);
						creturn_type = "void";
					} else {
						creturn_type = get_ccode_name (prop.get_accessor.value_type);
					}

					var array_type = prop.property_type as ArrayType;
					if (array_type != null) {
						for (int dim = 1; dim <= array_type.rank; dim++) {
							vdeclarator.add_parameter (new CCodeParameter (get_array_length_cname ("result", dim), "int*"));
						}
					}

					var vdecl = new CCodeDeclaration (creturn_type);
					vdecl.add_declarator (vdeclarator);
					type_struct.add_declaration (vdecl);
				}
				if (prop.set_accessor != null) {
					var vdeclarator = new CCodeFunctionDeclarator ("set_%s".printf (prop.name));
					vdeclarator.add_parameter (cselfparam);
					if (returns_real_struct) {
						var cvalueparam = new CCodeParameter ("value", get_ccode_name (prop.set_accessor.value_type) + "*");
						vdeclarator.add_parameter (cvalueparam);
					} else {
						var cvalueparam = new CCodeParameter ("value", get_ccode_name (prop.set_accessor.value_type));
						vdeclarator.add_parameter (cvalueparam);
					}

					var array_type = prop.property_type as ArrayType;
					if (array_type != null) {
						for (int dim = 1; dim <= array_type.rank; dim++) {
							vdeclarator.add_parameter (new CCodeParameter (get_array_length_cname ("value", dim), "int"));
						}
					}

					var vdecl = new CCodeDeclaration ("void");
					vdecl.add_declarator (vdeclarator);
					type_struct.add_declaration (vdecl);
				}
			} else {
				assert_not_reached ();
			}
		}

		decl_space.add_type_definition (type_struct);

		var type_fun = new InterfaceRegisterFunction (iface, context);
		type_fun.init_from_type (in_plugin, true);
		decl_space.add_type_member_declaration (type_fun.get_declaration ());
	}

	public override void visit_interface (Interface iface) {
		push_context (new EmitContext (iface));
		push_line (iface.source_reference);

		if (get_ccode_name (iface).length < 3) {
			iface.error = true;
			Report.error (iface.source_reference, "Interface name `%s' is too short".printf (get_ccode_name (iface)));
			return;
		}

		generate_interface_declaration (iface, cfile);
		if (!iface.is_internal_symbol ()) {
			generate_interface_declaration (iface, header_file);
		}
		if (!iface.is_private_symbol ()) {
			generate_interface_declaration (iface, internal_header_file);
		}

		iface.accept_children (this);

		add_interface_base_init_function (iface);

		if (iface.comment != null) {
			cfile.add_type_member_definition (new CCodeComment (iface.comment.content));
		}

		var type_fun = new InterfaceRegisterFunction (iface, context);
		type_fun.init_from_type (in_plugin, false);
		cfile.add_type_member_declaration (type_fun.get_source_declaration ());
		cfile.add_type_member_definition (type_fun.get_definition ());

		pop_line ();
		pop_context ();
	}

	private void add_interface_base_init_function (Interface iface) {
		push_context (new EmitContext (iface));

		var base_init = new CCodeFunction ("%s_base_init".printf (get_ccode_lower_case_name (iface, null)), "void");
		base_init.add_parameter (new CCodeParameter ("iface", "%sIface *".printf (get_ccode_name (iface))));
		base_init.modifiers = CCodeModifiers.STATIC;

		push_function (base_init);

		/* make sure not to run the initialization code twice */
		ccode.add_declaration (get_ccode_name (bool_type), new CCodeVariableDeclarator ("initialized", new CCodeConstant ("FALSE")), CCodeModifiers.STATIC);
		ccode.open_if (new CCodeUnaryExpression (CCodeUnaryOperator.LOGICAL_NEGATION, new CCodeIdentifier ("initialized")));

		ccode.add_assignment (new CCodeIdentifier ("initialized"), new CCodeConstant ("TRUE"));

		if (iface.is_subtype_of (gobject_type)) {
			/* create properties */
			var props = iface.get_properties ();
			foreach (Property prop in props) {
				if (prop.is_abstract) {
					if (!is_gobject_property (prop)) {
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
					string cname = CCodeBaseModule.get_ccode_real_name (prop.get_accessor);
					ccode.add_assignment (new CCodeMemberAccess.pointer (ciface, "get_%s".printf (prop.name)), new CCodeIdentifier (cname));
				}
				if (prop.set_accessor != null) {
					string cname = CCodeBaseModule.get_ccode_real_name (prop.set_accessor);
					ccode.add_assignment (new CCodeMemberAccess.pointer (ciface, "set_%s".printf (prop.name)), new CCodeIdentifier (cname));
				}
			}
		}

		ccode.close ();

		pop_context ();

		cfile.add_function (base_init);
	}

	public override void visit_struct (Struct st) {
		base.visit_struct (st);

		if (get_ccode_has_type_id (st)) {
			push_line (st.source_reference);
			var type_fun = new StructRegisterFunction (st, context);
			type_fun.init_from_type (false, false);
			cfile.add_type_member_definition (type_fun.get_definition ());
			pop_line ();
		}
	}

	public override void visit_enum (Enum en) {
		base.visit_enum (en);

		if (get_ccode_has_type_id (en)) {
			push_line (en.source_reference);
			var type_fun = new EnumRegisterFunction (en, context);
			type_fun.init_from_type (false, false);
			cfile.add_type_member_definition (type_fun.get_definition ());
			pop_line ();
		}
	}

	public override void visit_method_call (MethodCall expr) {
		var ma = expr.call as MemberAccess;
		var mtype = expr.call.value_type as MethodType;
		if (mtype == null || ma == null || ma.inner == null ||
			!(ma.inner.value_type is EnumValueType) || !get_ccode_has_type_id (ma.inner.value_type.data_type) ||
			mtype.method_symbol != ((EnumValueType) ma.inner.value_type).get_to_string_method ()) {
			base.visit_method_call (expr);
			return;
		}
		// to_string() on a gtype enum

		push_line (expr.source_reference);
		var temp_var = get_temp_variable (new CType ("GEnumValue*"), false, expr, false);
		emit_temp_var (temp_var);

		var class_ref = new CCodeFunctionCall (new CCodeIdentifier ("g_type_class_ref"));
		class_ref.add_argument (new CCodeIdentifier (get_ccode_type_id (ma.inner.value_type)));
		var get_value = new CCodeFunctionCall (new CCodeIdentifier ("g_enum_get_value"));
		get_value.add_argument (class_ref);
		get_value.add_argument ((CCodeExpression) get_ccodenode (((MemberAccess) expr.call).inner));

		ccode.add_assignment (get_variable_cexpression (temp_var.name), get_value);
		var is_null_value = new CCodeBinaryExpression (CCodeBinaryOperator.INEQUALITY, get_variable_cexpression (temp_var.name), new CCodeIdentifier ("NULL"));
		set_cvalue (expr, new CCodeConditionalExpression (is_null_value, new CCodeMemberAccess.pointer (get_variable_cexpression (temp_var.name), "value_name"), new CCodeIdentifier ("NULL")));
		pop_line ();
	}

	public override void visit_property (Property prop) {
		var cl = current_type_symbol as Class;
		var st = current_type_symbol as Struct;
		if (prop.name == "type" && ((cl != null && !cl.is_compact) || (st != null && get_ccode_has_type_id (st)))) {
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
			var ctype_check = new CCodeFunctionCall (new CCodeIdentifier (get_ccode_type_check_function (t)));
			ctype_check.add_argument (new CCodeIdentifier (var_name));

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
			} else if (ret_type.data_type is Struct && ((Struct) ret_type.data_type).is_simple_type ()) {
				ccheck.add_argument (new CCodeIdentifier ("result"));
			} else {
				return;
			}
		}

		ccode.add_expression (ccheck);
	}
}
