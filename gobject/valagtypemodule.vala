/* valagtypemodule.vala
 *
 * Copyright (C) 2006-2009  Jürg Billeter
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

using Gee;

internal class Vala.GTypeModule : GErrorModule {
	public GTypeModule (CCodeGenerator codegen, CCodeModule? next) {
		base (codegen, next);
	}

	public override void generate_parameter (FormalParameter param, CCodeDeclarationSpace decl_space, Map<int,CCodeFormalParameter> cparam_map, Map<int,CCodeExpression>? carg_map) {
		if (!(param.parameter_type is ObjectType)) {
			base.generate_parameter (param, decl_space, cparam_map, carg_map);
			return;
		}

		generate_type_declaration (param.parameter_type, decl_space);

		string ctypename = param.parameter_type.get_cname ();

		if (param.direction != ParameterDirection.IN) {
			ctypename += "*";
		}

		param.ccodenode = new CCodeFormalParameter (get_variable_cname (param.name), ctypename);

		cparam_map.set (get_param_pos (param.cparameter_position), (CCodeFormalParameter) param.ccodenode);
		if (carg_map != null) {
			carg_map.set (get_param_pos (param.cparameter_position), get_variable_cexpression (param.name));
		}
	}

	public override void generate_class_declaration (Class cl, CCodeDeclarationSpace decl_space) {
		if (decl_space.add_symbol_declaration (cl, cl.get_cname ())) {
			return;
		}

		if (cl.base_class != null) {
			// base class declaration
			// necessary for ref and unref function declarations
			generate_class_declaration (cl.base_class, decl_space);
		}

		bool is_gtypeinstance = !cl.is_compact;
		bool is_fundamental = is_gtypeinstance && cl.base_class == null;

		if (is_gtypeinstance) {
			decl_space.add_type_declaration (new CCodeNewline ());
			var macro = "(%s_get_type ())".printf (cl.get_lower_case_cname (null));
			decl_space.add_type_declaration (new CCodeMacroReplacement (cl.get_type_id (), macro));

			macro = "(G_TYPE_CHECK_INSTANCE_CAST ((obj), %s, %s))".printf (cl.get_type_id (), cl.get_cname ());
			decl_space.add_type_declaration (new CCodeMacroReplacement ("%s(obj)".printf (cl.get_upper_case_cname (null)), macro));

			macro = "(G_TYPE_CHECK_CLASS_CAST ((klass), %s, %sClass))".printf (cl.get_type_id (), cl.get_cname ());
			decl_space.add_type_declaration (new CCodeMacroReplacement ("%s_CLASS(klass)".printf (cl.get_upper_case_cname (null)), macro));

			macro = "(G_TYPE_CHECK_INSTANCE_TYPE ((obj), %s))".printf (cl.get_type_id ());
			decl_space.add_type_declaration (new CCodeMacroReplacement ("%s(obj)".printf (get_type_check_function (cl)), macro));

			macro = "(G_TYPE_CHECK_CLASS_TYPE ((klass), %s))".printf (cl.get_type_id ());
			decl_space.add_type_declaration (new CCodeMacroReplacement ("%s_CLASS(klass)".printf (get_type_check_function (cl)), macro));

			macro = "(G_TYPE_INSTANCE_GET_CLASS ((obj), %s, %sClass))".printf (cl.get_type_id (), cl.get_cname ());
			decl_space.add_type_declaration (new CCodeMacroReplacement ("%s_GET_CLASS(obj)".printf (cl.get_upper_case_cname (null)), macro));
			decl_space.add_type_declaration (new CCodeNewline ());
		}

		decl_space.add_type_declaration (new CCodeTypeDefinition ("struct _%s".printf (cl.get_cname ()), new CCodeVariableDeclarator (cl.get_cname ())));

		if (is_fundamental) {
			var ref_fun = new CCodeFunction (cl.get_lower_case_cprefix () + "ref", "gpointer");
			var unref_fun = new CCodeFunction (cl.get_lower_case_cprefix () + "unref", "void");
			if (cl.access == SymbolAccessibility.PRIVATE) {
				ref_fun.modifiers = CCodeModifiers.STATIC;
				unref_fun.modifiers = CCodeModifiers.STATIC;
			}

			ref_fun.add_parameter (new CCodeFormalParameter ("instance", "gpointer"));
			unref_fun.add_parameter (new CCodeFormalParameter ("instance", "gpointer"));

			decl_space.add_type_member_declaration (ref_fun.copy ());
			decl_space.add_type_member_declaration (unref_fun.copy ());

			// GParamSpec and GValue functions
			var function_name = cl.get_lower_case_cname ("param_spec_");

			var function = new CCodeFunction (function_name, "GParamSpec*");
			function.add_parameter (new CCodeFormalParameter ("name", "const gchar*"));
			function.add_parameter (new CCodeFormalParameter ("nick", "const gchar*"));
			function.add_parameter (new CCodeFormalParameter ("blurb", "const gchar*"));
			function.add_parameter (new CCodeFormalParameter ("object_type", "GType"));
			function.add_parameter (new CCodeFormalParameter ("flags", "GParamFlags"));

			cl.set_param_spec_function (function_name);

			if (cl.access == SymbolAccessibility.PRIVATE) {
				function.modifiers = CCodeModifiers.STATIC;
			}

			decl_space.add_type_member_declaration (function);

			function = new CCodeFunction (cl.get_set_value_function (), "void");
			function.add_parameter (new CCodeFormalParameter ("value", "GValue*"));
			function.add_parameter (new CCodeFormalParameter ("v_object", "gpointer"));

			if (cl.access == SymbolAccessibility.PRIVATE) {
				function.modifiers = CCodeModifiers.STATIC;
			}

			decl_space.add_type_member_declaration (function);

			function = new CCodeFunction (cl.get_get_value_function (), "gpointer");
			function.add_parameter (new CCodeFormalParameter ("value", "const GValue*"));

			if (cl.access == SymbolAccessibility.PRIVATE) {
				function.modifiers = CCodeModifiers.STATIC;
			}

			decl_space.add_type_member_declaration (function);
		}

		if (is_gtypeinstance) {
			decl_space.add_type_declaration (new CCodeTypeDefinition ("struct _%sClass".printf (cl.get_cname ()), new CCodeVariableDeclarator ("%sClass".printf (cl.get_cname ()))));

			var type_fun = new ClassRegisterFunction (cl, context);
			type_fun.init_from_type (in_plugin);
			decl_space.add_type_member_declaration (type_fun.get_declaration ());
		}
	}

	public override void generate_class_struct_declaration (Class cl, CCodeDeclarationSpace decl_space) {
		if (decl_space.add_symbol_declaration (cl, "struct _" + cl.get_cname ())) {
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

		var instance_struct = new CCodeStruct ("_%s".printf (cl.get_cname ()));
		var type_struct = new CCodeStruct ("_%sClass".printf (cl.get_cname ()));

		if (cl.base_class != null) {
			instance_struct.add_field (cl.base_class.get_cname (), "parent_instance");
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
			decl_space.add_type_declaration (new CCodeTypeDefinition ("struct %sPrivate".printf (instance_struct.name), new CCodeVariableDeclarator ("%sPrivate".printf (cl.get_cname ()))));

			instance_struct.add_field ("%sPrivate *".printf (cl.get_cname ()), "priv");
			if (is_fundamental) {
				type_struct.add_field ("GTypeClass", "parent_class");
			} else {
				type_struct.add_field ("%sClass".printf (cl.base_class.get_cname ()), "parent_class");
			}

			if (is_fundamental) {
				type_struct.add_field ("void", "(*finalize) (%s *self)".printf (cl.get_cname ()));
			}
		}

		foreach (Method m in cl.get_methods ()) {
			generate_virtual_method_declaration (m, decl_space, type_struct);
		}

		foreach (Property prop in cl.get_properties ()) {
			if (!prop.is_abstract && !prop.is_virtual) {
				continue;
			}
			generate_type_declaration (prop.property_type, decl_space);

			var t = (ObjectTypeSymbol) prop.parent_symbol;

			bool returns_real_struct = prop.property_type.is_real_struct_type ();

			var this_type = new ObjectType (t);
			var cselfparam = new CCodeFormalParameter ("self", this_type.get_cname ());
			CCodeFormalParameter cvalueparam;
			if (returns_real_struct) {
				cvalueparam = new CCodeFormalParameter ("value", prop.property_type.get_cname () + "*");
			} else {
				cvalueparam = new CCodeFormalParameter ("value", prop.property_type.get_cname ());
			}

			if (prop.get_accessor != null) {
				var vdeclarator = new CCodeFunctionDeclarator ("get_%s".printf (prop.name));
				vdeclarator.add_parameter (cselfparam);
				string creturn_type;
				if (returns_real_struct) {
					vdeclarator.add_parameter (cvalueparam);
					creturn_type = "void";
				} else {
					creturn_type = prop.property_type.get_cname ();
				}
				var vdecl = new CCodeDeclaration (creturn_type);
				vdecl.add_declarator (vdeclarator);
				type_struct.add_declaration (vdecl);
			}
			if (prop.set_accessor != null) {
				var vdeclarator = new CCodeFunctionDeclarator ("set_%s".printf (prop.name));
				vdeclarator.add_parameter (cselfparam);
				vdeclarator.add_parameter (cvalueparam);
				var vdecl = new CCodeDeclaration ("void");
				vdecl.add_declarator (vdeclarator);
				type_struct.add_declaration (vdecl);
			}
		}

		foreach (Field f in cl.get_fields ()) {
			string field_ctype = f.field_type.get_cname ();
			if (f.is_volatile) {
				field_ctype = "volatile " + field_ctype;
			}

			if (f.binding == MemberBinding.INSTANCE && f.access != SymbolAccessibility.PRIVATE)  {
				generate_type_declaration (f.field_type, decl_space);

				instance_struct.add_field (field_ctype, f.get_cname ());
				if (f.field_type is ArrayType && !f.no_array_length) {
					// create fields to store array dimensions
					var array_type = (ArrayType) f.field_type;
					var len_type = int_type.copy ();

					for (int dim = 1; dim <= array_type.rank; dim++) {
						instance_struct.add_field (len_type.get_cname (), head.get_array_length_cname (f.name, dim));
					}

					if (array_type.rank == 1 && f.is_internal_symbol ()) {
						instance_struct.add_field (len_type.get_cname (), head.get_array_size_cname (f.name));
					}
				} else if (f.field_type is DelegateType) {
					var delegate_type = (DelegateType) f.field_type;
					if (delegate_type.delegate_symbol.has_target) {
						// create field to store delegate target
						instance_struct.add_field ("gpointer", get_delegate_target_cname (f.name));
					}
				}
			} else if (f.binding == MemberBinding.CLASS && f.access != SymbolAccessibility.PRIVATE)  {
				type_struct.add_field (field_ctype, f.get_cname ());
			}
		}

		if (cl.source_reference.comment != null) {
			decl_space.add_type_definition (new CCodeComment (cl.source_reference.comment));
		}
		decl_space.add_type_definition (instance_struct);

		if (is_gtypeinstance) {
			decl_space.add_type_definition (type_struct);
		}
	}

	public virtual void generate_virtual_method_declaration (Method m, CCodeDeclarationSpace decl_space, CCodeStruct type_struct) {
		if (!m.is_abstract && !m.is_virtual) {
			return;
		}

		// add vfunc field to the type struct
		var vdeclarator = new CCodeFunctionDeclarator (m.vfunc_name);
		var cparam_map = new HashMap<int,CCodeFormalParameter> (direct_hash, direct_equal);

		generate_cparameters (m, decl_space, cparam_map, new CCodeFunction ("fake"), vdeclarator);

		var vdecl = new CCodeDeclaration (m.return_type.get_cname ());
		vdecl.add_declarator (vdeclarator);
		type_struct.add_declaration (vdecl);
	}

	void generate_class_private_declaration (Class cl, CCodeDeclarationSpace decl_space) {
		if (decl_space.add_symbol_declaration (cl, cl.get_cname () + "Private")) {
			return;
		}

		bool is_gtypeinstance = !cl.is_compact;

		var instance_priv_struct = new CCodeStruct ("_%sPrivate".printf (cl.get_cname ()));
		var type_priv_struct = new CCodeStruct ("_%sClassPrivate".printf (cl.get_cname ()));

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
			string field_ctype = f.field_type.get_cname ();
			if (f.is_volatile) {
				field_ctype = "volatile " + field_ctype;
			}

			if (f.binding == MemberBinding.INSTANCE && f.access == SymbolAccessibility.PRIVATE)  {
				generate_type_declaration (f.field_type, decl_space);

				instance_priv_struct.add_field (field_ctype, f.get_cname ());
				if (f.field_type is ArrayType && !f.no_array_length) {
					// create fields to store array dimensions
					var array_type = (ArrayType) f.field_type;
					var len_type = int_type.copy ();

					for (int dim = 1; dim <= array_type.rank; dim++) {
						instance_priv_struct.add_field (len_type.get_cname (), head.get_array_length_cname (f.name, dim));
					}

					if (array_type.rank == 1 && f.is_internal_symbol ()) {
						instance_priv_struct.add_field (len_type.get_cname (), head.get_array_size_cname (f.name));
					}
				} else if (f.field_type is DelegateType) {
					var delegate_type = (DelegateType) f.field_type;
					if (delegate_type.delegate_symbol.has_target) {
						// create field to store delegate target
						instance_priv_struct.add_field ("gpointer", get_delegate_target_cname (f.name));
					}
				}

				if (f.get_lock_used ()) {
					// add field for mutex
					instance_priv_struct.add_field (mutex_type.get_cname (), get_symbol_lock_name (f));
				}
			} else if (f.binding == MemberBinding.CLASS && f.access == SymbolAccessibility.PRIVATE)  {
				type_priv_struct.add_field (field_ctype, f.get_cname ());
			}
		}

		if (is_gtypeinstance) {
			if (cl.has_class_private_fields) {
				decl_space.add_type_declaration (new CCodeTypeDefinition ("struct %s".printf (type_priv_struct.name), new CCodeVariableDeclarator ("%sClassPrivate".printf (cl.get_cname ()))));
				var cdecl = new CCodeDeclaration ("GQuark");
				cdecl.add_declarator (new CCodeVariableDeclarator ("_vala_%s_class_private_quark".printf (cl.get_lower_case_cname ()), new CCodeConstant ("0")));
				cdecl.modifiers = CCodeModifiers.STATIC;
				decl_space.add_type_declaration (cdecl);
			}

			/* only add the *Private struct if it is not empty, i.e. we actually have private data */
			if (cl.has_private_fields || cl.get_type_parameters ().size > 0) {
				decl_space.add_type_definition (instance_priv_struct);
				var macro = "(G_TYPE_INSTANCE_GET_PRIVATE ((o), %s, %sPrivate))".printf (cl.get_type_id (), cl.get_cname ());
				decl_space.add_type_member_declaration (new CCodeMacroReplacement ("%s_GET_PRIVATE(o)".printf (cl.get_upper_case_cname (null)), macro));
			}

			if (cl.has_class_private_fields) {
				decl_space.add_type_member_declaration (type_priv_struct);

				var macro = "((%sClassPrivate *) g_type_get_qdata (type, _vala_%s_class_private_quark))".printf (cl.get_cname(), cl.get_lower_case_cname ());
				decl_space.add_type_member_declaration (new CCodeMacroReplacement ("%s_GET_CLASS_PRIVATE(type)".printf (cl.get_upper_case_cname (null)), macro));
			}
			decl_space.add_type_member_declaration (prop_enum);
		} else {
			var function = new CCodeFunction (cl.get_lower_case_cprefix () + "free", "void");
			if (cl.access == SymbolAccessibility.PRIVATE) {
				function.modifiers = CCodeModifiers.STATIC;
			}

			function.add_parameter (new CCodeFormalParameter ("self", cl.get_cname () + "*"));

			decl_space.add_type_member_declaration (function);
		}
	}

	public override void visit_class (Class cl) {
		var old_symbol = current_symbol;
		var old_type_symbol = current_type_symbol;
		var old_class = current_class;
		var old_param_spec_struct = param_spec_struct;
		var old_prop_enum = prop_enum;
		var old_class_init_fragment = class_init_fragment;
		var old_base_init_fragment = base_init_fragment;
		var old_class_finalize_fragment = class_finalize_fragment;
		var old_base_finalize_fragment = base_finalize_fragment;
		var old_instance_init_fragment = instance_init_fragment;
		var old_instance_finalize_fragment = instance_finalize_fragment;
		current_symbol = cl;
		current_type_symbol = cl;
		current_class = cl;

		bool is_gtypeinstance = !cl.is_compact;
		bool is_fundamental = is_gtypeinstance && cl.base_class == null;

		if (cl.get_cname().len () < 3) {
			cl.error = true;
			Report.error (cl.source_reference, "Class name `%s' is too short".printf (cl.get_cname ()));
			return;
		}

		prop_enum = new CCodeEnum ();
		prop_enum.add_value (new CCodeEnumValue ("%s_DUMMY_PROPERTY".printf (cl.get_upper_case_cname (null))));
		class_init_fragment = new CCodeFragment ();
		base_init_fragment = new CCodeFragment ();
		class_finalize_fragment = new CCodeFragment ();
		base_finalize_fragment = new CCodeFragment ();
		instance_init_fragment = new CCodeFragment ();
		instance_finalize_fragment = new CCodeFragment ();


		generate_class_struct_declaration (cl, source_declarations);
		generate_class_private_declaration (cl, source_declarations);

		if (!cl.is_internal_symbol ()) {
			generate_class_struct_declaration (cl, header_declarations);
		}
		generate_class_struct_declaration (cl, internal_header_declarations);

		cl.accept_children (codegen);

		if (is_gtypeinstance) {
			if (is_fundamental) {
				param_spec_struct = new CCodeStruct ( "_%sParamSpec%s".printf(cl.parent_symbol.get_cprefix (), cl.name));
				param_spec_struct.add_field ("GParamSpec", "parent_instance");
				source_declarations.add_type_definition (param_spec_struct);

				source_declarations.add_type_declaration (new CCodeTypeDefinition ("struct %s".printf (param_spec_struct.name), new CCodeVariableDeclarator ( "%sParamSpec%s".printf(cl.parent_symbol.get_cprefix (), cl.name))));


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

				var ref_count = new CCodeAssignment (new CCodeMemberAccess.pointer (new CCodeIdentifier ("self"), "ref_count"), new CCodeConstant ("1"));
				instance_init_fragment.append (new CCodeExpressionStatement (ref_count));
			}


			if (cl.class_constructor != null || cl.has_class_private_fields) {
				add_base_init_function (cl);
			}
			add_class_init_function (cl);

			if (cl.class_destructor != null || cl.has_class_private_fields) {
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

			var type_fun = new ClassRegisterFunction (cl, context);
			type_fun.init_from_type (in_plugin);
			source_type_member_definition.append (type_fun.get_definition ());
			
			if (in_plugin) {
				// FIXME resolve potential dependency issues, i.e. base types have to be registered before derived types
				var register_call = new CCodeFunctionCall (new CCodeIdentifier ("%s_register_type".printf (cl.get_lower_case_cname (null))));
				register_call.add_argument (new CCodeIdentifier (module_init_param_name));
				module_init_fragment.append (new CCodeExpressionStatement (register_call));
			}

			if (is_fundamental) {
				var ref_fun = new CCodeFunction (cl.get_lower_case_cprefix () + "ref", "gpointer");
				var unref_fun = new CCodeFunction (cl.get_lower_case_cprefix () + "unref", "void");
				if (cl.access == SymbolAccessibility.PRIVATE) {
					ref_fun.modifiers = CCodeModifiers.STATIC;
					unref_fun.modifiers = CCodeModifiers.STATIC;
				}

				ref_fun.add_parameter (new CCodeFormalParameter ("instance", "gpointer"));
				unref_fun.add_parameter (new CCodeFormalParameter ("instance", "gpointer"));

				var ref_block = new CCodeBlock ();
				var unref_block = new CCodeBlock ();

				var cdecl = new CCodeDeclaration (cl.get_cname () + "*");
				cdecl.add_declarator (new CCodeVariableDeclarator ("self", new CCodeIdentifier ("instance")));
				ref_block.add_statement (cdecl);
				unref_block.add_statement (cdecl);

				var ref_count = new CCodeMemberAccess.pointer (new CCodeIdentifier ("self"), "ref_count");

				var ccall = new CCodeFunctionCall (new CCodeIdentifier ("g_atomic_int_inc"));
				ccall.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, ref_count));
				ref_block.add_statement (new CCodeExpressionStatement (ccall));

				ref_block.add_statement (new CCodeReturnStatement (new CCodeIdentifier ("instance")));

				var destroy_block = new CCodeBlock ();
				var get_class = new CCodeFunctionCall (new CCodeIdentifier ("%s_GET_CLASS".printf (cl.get_upper_case_cname (null))));
				get_class.add_argument (new CCodeIdentifier ("self"));

				// finalize class
				var ccast = new CCodeFunctionCall (new CCodeIdentifier ("%s_GET_CLASS".printf (cl.get_upper_case_cname (null))));
				ccast.add_argument (new CCodeIdentifier ("self"));
				ccall = new CCodeFunctionCall (new CCodeMemberAccess.pointer (ccast, "finalize"));
				ccall.add_argument (new CCodeIdentifier ("self"));
				destroy_block.add_statement (new CCodeExpressionStatement (ccall));

				// free type instance
				var free = new CCodeFunctionCall (new CCodeIdentifier ("g_type_free_instance"));
				free.add_argument (new CCodeCastExpression (new CCodeIdentifier ("self"), "GTypeInstance *"));
				destroy_block.add_statement (new CCodeExpressionStatement (free));

				ccall = new CCodeFunctionCall (new CCodeIdentifier ("g_atomic_int_dec_and_test"));
				ccall.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, ref_count));
				unref_block.add_statement (new CCodeIfStatement (ccall, destroy_block));

				ref_fun.block = ref_block;
				unref_fun.block = unref_block;

				source_type_member_definition.append (ref_fun);
				source_type_member_definition.append (unref_fun);
			}
		} else {
			add_instance_init_function (cl);

			var function = new CCodeFunction (cl.get_lower_case_cprefix () + "free", "void");
			if (cl.access == SymbolAccessibility.PRIVATE) {
				function.modifiers = CCodeModifiers.STATIC;
			}

			function.add_parameter (new CCodeFormalParameter ("self", cl.get_cname () + "*"));

			var cblock = new CCodeBlock ();

			cblock.add_statement (instance_finalize_fragment);

			if (cl.destructor != null) {
				cblock.add_statement (cl.destructor.ccodenode);
			}

			var ccall = new CCodeFunctionCall (new CCodeIdentifier ("g_slice_free"));
			ccall.add_argument (new CCodeIdentifier (cl.get_cname ()));
			ccall.add_argument (new CCodeIdentifier ("self"));
			cblock.add_statement (new CCodeExpressionStatement (ccall));

			function.block = cblock;

			source_type_member_definition.append (function);
		}

		current_symbol = old_symbol;
		current_type_symbol = old_type_symbol;
		current_class = old_class;
		param_spec_struct = old_param_spec_struct;
		prop_enum = old_prop_enum;
		class_init_fragment = old_class_init_fragment;
		base_init_fragment = old_base_init_fragment;
		class_finalize_fragment = old_class_finalize_fragment;
		base_finalize_fragment = old_base_finalize_fragment;
		instance_init_fragment = old_instance_init_fragment;
		instance_finalize_fragment = old_instance_finalize_fragment;
	}

	private void add_type_value_table_init_function (Class cl) {
		var function = new CCodeFunction ("%s_init".printf (cl.get_lower_case_cname ("value_")), "void");
		function.add_parameter (new CCodeFormalParameter ("value", "GValue*"));
		function.modifiers = CCodeModifiers.STATIC;

		var init_block = new CCodeBlock ();
		function.block = init_block;

		init_block.add_statement(new CCodeExpressionStatement (new CCodeAssignment (new CCodeMemberAccess(new CCodeMemberAccess.pointer (new CCodeIdentifier ("value"), "data[0]"),"v_pointer"),new CCodeConstant ("NULL"), CCodeAssignmentOperator.SIMPLE)));
		source_type_member_definition.append (function);
	}

	private void add_type_value_table_free_function (Class cl) {
		var function = new CCodeFunction ("%s_free_value".printf (cl.get_lower_case_cname ("value_")), "void");
		function.add_parameter (new CCodeFormalParameter ("value", "GValue*"));
		function.modifiers = CCodeModifiers.STATIC;

		var init_block = new CCodeBlock ();
		function.block = init_block;
		
		var vpointer = new CCodeMemberAccess(new CCodeMemberAccess.pointer (new CCodeIdentifier ("value"), "data[0]"),"v_pointer");
		var ccall = new CCodeFunctionCall (new CCodeIdentifier (cl.get_lower_case_cprefix () + "unref"));
		ccall.add_argument ( vpointer );

		var ifbody = new CCodeBlock ();
		ifbody.add_statement ( new CCodeExpressionStatement(ccall) );

		init_block.add_statement(new CCodeIfStatement (vpointer, ifbody));
		source_type_member_definition.append (function);
	}

	private void add_type_value_table_copy_function (Class cl) {
		var function = new CCodeFunction ("%s_copy_value".printf (cl.get_lower_case_cname ("value_")), "void");
		function.add_parameter (new CCodeFormalParameter ("src_value", "const GValue*"));
		function.add_parameter (new CCodeFormalParameter ("dest_value", "GValue*"));
		function.modifiers = CCodeModifiers.STATIC;

		var init_block = new CCodeBlock ();
		function.block = init_block;

		var dest_vpointer = new CCodeMemberAccess (new CCodeMemberAccess.pointer (new CCodeIdentifier ("dest_value"), "data[0]"),"v_pointer");
		var src_vpointer = new CCodeMemberAccess (new CCodeMemberAccess.pointer (new CCodeIdentifier ("src_value"), "data[0]"),"v_pointer");

		var ref_ccall = new CCodeFunctionCall (new CCodeIdentifier (cl.get_lower_case_cprefix () + "ref"));
		ref_ccall.add_argument ( src_vpointer );

		var true_stmt = new CCodeBlock ();
		true_stmt.add_statement(new CCodeExpressionStatement(new CCodeAssignment (dest_vpointer, ref_ccall, CCodeAssignmentOperator.SIMPLE)));

		var false_stmt = new CCodeBlock ();
		false_stmt.add_statement (new CCodeExpressionStatement( new CCodeAssignment (dest_vpointer, new CCodeConstant ("NULL"), CCodeAssignmentOperator.SIMPLE)));

		var if_statement = new CCodeIfStatement (src_vpointer, true_stmt, false_stmt);
		init_block.add_statement (if_statement);

		source_type_member_definition.append (function);
	}

	private void add_type_value_table_peek_pointer_function (Class cl) {
		var function = new CCodeFunction ("%s_peek_pointer".printf (cl.get_lower_case_cname ("value_")), "gpointer");
		function.add_parameter (new CCodeFormalParameter ("value", "const GValue*"));
		function.modifiers = CCodeModifiers.STATIC;

		var init_block = new CCodeBlock ();
		function.block = init_block;

		var vpointer = new CCodeMemberAccess(new CCodeMemberAccess.pointer (new CCodeIdentifier ("value"), "data[0]"),"v_pointer");
		var ret = new CCodeReturnStatement ( vpointer );
		init_block.add_statement (ret);

		source_type_member_definition.append (function);
	}

	private void add_type_value_table_lcopy_value_function ( Class cl ) {
		var function = new CCodeFunction ("%s_lcopy_value".printf (cl.get_lower_case_cname ("value_")), "gchar*");
		function.add_parameter (new CCodeFormalParameter ("value", "const GValue*"));
		function.add_parameter (new CCodeFormalParameter ("n_collect_values", "guint"));
		function.add_parameter (new CCodeFormalParameter ("collect_values", "GTypeCValue*"));
		function.add_parameter (new CCodeFormalParameter ("collect_flags", "guint"));
		function.modifiers = CCodeModifiers.STATIC;

		var vpointer = new CCodeMemberAccess (new CCodeMemberAccess.pointer (new CCodeIdentifier ("value"), "data[0]"), "v_pointer");
		var object_p_ptr = new CCodeIdentifier ("*object_p");
		var null_ = new CCodeConstant ("NULL");

		var init_block = new CCodeBlock ();

		var ctypedecl = new CCodeDeclaration (cl.get_cname () + "**");
		ctypedecl.add_declarator (new CCodeVariableDeclarator ("object_p", new CCodeMemberAccess (new CCodeIdentifier ("collect_values[0]"),"v_pointer")));
		init_block.add_statement (ctypedecl);

		var value_type_name_fct = new CCodeFunctionCall (new CCodeIdentifier ("G_VALUE_TYPE_NAME"));
		value_type_name_fct.add_argument (new CCodeConstant ("value"));

		var assert_condition = new CCodeUnaryExpression (CCodeUnaryOperator.LOGICAL_NEGATION, new CCodeIdentifier ("object_p"));
		function.block = init_block;
		var assert_true = new CCodeBlock ();
		var assert_printf = new CCodeFunctionCall (new CCodeIdentifier ("g_strdup_printf"));
		assert_printf.add_argument (new CCodeConstant ("\"value location for `%s' passed as NULL\""));
		assert_printf.add_argument (value_type_name_fct);
		assert_true.add_statement (new CCodeReturnStatement (assert_printf));
		var if_assert = new CCodeIfStatement (assert_condition, assert_true);
		init_block.add_statement (if_assert);

		var main_else_true = new CCodeBlock ();
		var main_else_if_true = new CCodeBlock ();
		var main_else_if_condition = new CCodeBinaryExpression (CCodeBinaryOperator.AND, new CCodeIdentifier ("collect_flags"), new CCodeIdentifier ("G_VALUE_NOCOPY_CONTENTS"));
		var main_else_if = new CCodeIfStatement (main_else_if_condition, main_else_if_true, main_else_true);

		var main_true = new CCodeBlock ();
		var main_condition = new CCodeUnaryExpression (CCodeUnaryOperator.LOGICAL_NEGATION, vpointer);
		var if_main = new CCodeIfStatement (main_condition, main_true, main_else_if);
		init_block.add_statement (if_main);

		var ref_fct = new CCodeFunctionCall (new CCodeIdentifier (cl.get_ref_function()));
		ref_fct.add_argument (vpointer);

		main_true.add_statement (new CCodeExpressionStatement (new CCodeAssignment (object_p_ptr, null_, CCodeAssignmentOperator.SIMPLE)));
		main_else_if_true.add_statement (new CCodeExpressionStatement (new CCodeAssignment (object_p_ptr, vpointer, CCodeAssignmentOperator.SIMPLE)));
		main_else_true.add_statement (new CCodeExpressionStatement (new CCodeAssignment (object_p_ptr, ref_fct, CCodeAssignmentOperator.SIMPLE)));

		init_block.add_statement (new CCodeReturnStatement (null_));
		source_type_member_definition.append (function);
	}

	private void add_type_value_table_collect_value_function (Class cl) {
		var function = new CCodeFunction ("%s_collect_value".printf (cl.get_lower_case_cname ("value_")), "gchar*");
		function.add_parameter (new CCodeFormalParameter ("value", "GValue*"));
		function.add_parameter (new CCodeFormalParameter ("n_collect_values", "guint"));
		function.add_parameter (new CCodeFormalParameter ("collect_values", "GTypeCValue*"));
		function.add_parameter (new CCodeFormalParameter ("collect_flags", "guint"));
		function.modifiers = CCodeModifiers.STATIC;

		var vpointer = new CCodeMemberAccess(new CCodeMemberAccess.pointer (new CCodeIdentifier ("value"), "data[0]"),"v_pointer");

		var init_block = new CCodeBlock ();
		function.block = init_block;

		var collect_vpointer = new CCodeMemberAccess (new CCodeIdentifier ("collect_values[0]"), "v_pointer");

		var true_stmt = new CCodeBlock ();
		var false_stmt = new CCodeBlock ();
		var if_statement = new CCodeIfStatement (collect_vpointer, true_stmt, false_stmt);
		init_block.add_statement (if_statement);

		var obj_identifier = new CCodeIdentifier ("object");

		var ctypedecl = new CCodeDeclaration (cl.get_cname () + "*");
		ctypedecl.add_declarator (new CCodeVariableDeclarator ("object", collect_vpointer));
		true_stmt.add_statement (ctypedecl);

		var l_expression = new CCodeMemberAccess (new CCodeMemberAccess.pointer (obj_identifier, "parent_instance"), "g_class");
		var sub_condition = new CCodeBinaryExpression (CCodeBinaryOperator.EQUALITY, l_expression, new CCodeConstant ("NULL"));
		var sub_true_stmt = new CCodeBlock ();
		var sub_false_stmt = new CCodeBlock ();

		var reg_call = new CCodeFunctionCall (new CCodeIdentifier ("g_value_type_compatible"));
		var type_check = new CCodeFunctionCall (new CCodeIdentifier ("G_TYPE_FROM_INSTANCE"));
		type_check.add_argument (new CCodeIdentifier ("object"));
		reg_call.add_argument (type_check);

		var type_name_fct = new CCodeFunctionCall (new CCodeIdentifier ("g_type_name"));
		type_name_fct.add_argument (type_check);

		var stored_type = new CCodeFunctionCall (new CCodeIdentifier ("G_VALUE_TYPE"));
		stored_type.add_argument (new CCodeIdentifier ("value"));
		reg_call.add_argument (stored_type);

		var value_type_name_fct = new CCodeFunctionCall (new CCodeIdentifier ("G_VALUE_TYPE_NAME"));
		value_type_name_fct.add_argument (new CCodeConstant ("value"));

		var true_return = new CCodeFunctionCall (new CCodeIdentifier ("g_strconcat"));
		true_return.add_argument (new CCodeConstant ("\"invalid unclassed object pointer for value type `\""));
		true_return.add_argument (value_type_name_fct);
		true_return.add_argument (new CCodeConstant ("\"'\""));
		true_return.add_argument (new CCodeConstant ("NULL"));
		sub_true_stmt.add_statement (new CCodeReturnStatement (true_return));

		var false_return = new CCodeFunctionCall (new CCodeIdentifier ("g_strconcat"));
		false_return.add_argument (new CCodeConstant ("\"invalid object type `\""));
		false_return.add_argument (type_name_fct);
		false_return.add_argument (new CCodeConstant ("\"' for value type `\""));
		false_return.add_argument (value_type_name_fct);
		false_return.add_argument (new CCodeConstant ("\"'\""));
		false_return.add_argument (new CCodeConstant ("NULL"));
		sub_false_stmt.add_statement (new CCodeReturnStatement (false_return));

		var sub_else_if_statement = new CCodeIfStatement (new CCodeUnaryExpression (CCodeUnaryOperator.LOGICAL_NEGATION, reg_call), sub_false_stmt );
		sub_else_if_statement.else_if = true;
		var sub_if_statement = new CCodeIfStatement (sub_condition, sub_true_stmt, sub_else_if_statement);
		true_stmt.add_statement (sub_if_statement);

		var ref_call = new CCodeFunctionCall (new CCodeIdentifier (cl.get_ref_function ()));
		ref_call.add_argument (new CCodeIdentifier ("object"));

		var true_assignment = new CCodeExpressionStatement (new CCodeAssignment (vpointer, ref_call, CCodeAssignmentOperator.SIMPLE));
		true_stmt.add_statement (true_assignment);

		var else_assigment = new CCodeExpressionStatement (new CCodeAssignment (vpointer, new CCodeConstant ("NULL"), CCodeAssignmentOperator.SIMPLE));
		false_stmt.add_statement (else_assigment);

		init_block.add_statement (new CCodeReturnStatement (new CCodeConstant ("NULL")));
		source_type_member_definition.append (function);
	}

	private void add_g_param_spec_type_function (Class cl) {
		var function_name = cl.get_lower_case_cname ("param_spec_");

		var function = new CCodeFunction (function_name, "GParamSpec*");
		function.add_parameter (new CCodeFormalParameter ("name", "const gchar*"));
		function.add_parameter (new CCodeFormalParameter ("nick", "const gchar*"));
		function.add_parameter (new CCodeFormalParameter ("blurb", "const gchar*"));
		function.add_parameter (new CCodeFormalParameter ("object_type", "GType"));
		function.add_parameter (new CCodeFormalParameter ("flags", "GParamFlags"));

		cl.set_param_spec_function ( function_name );

		if (cl.access == SymbolAccessibility.PRIVATE) {
			function.modifiers = CCodeModifiers.STATIC;
		}

		var init_block = new CCodeBlock ();
		function.block = init_block;

		var ctypedecl = new CCodeDeclaration ("%sParamSpec%s*".printf (cl.parent_symbol.get_cprefix (), cl.name));
		ctypedecl.add_declarator ( new CCodeVariableDeclarator ("spec"));
		init_block.add_statement (ctypedecl);

		var subccall = new CCodeFunctionCall (new CCodeIdentifier ("g_type_is_a"));
		subccall.add_argument (new CCodeIdentifier ("object_type"));
		subccall.add_argument (new CCodeIdentifier ( cl.get_type_id() ));

		var ccall = new CCodeFunctionCall (new CCodeIdentifier ("g_return_val_if_fail"));
		ccall.add_argument (subccall);
		ccall.add_argument (new CCodeIdentifier ("NULL"));
		init_block.add_statement (new CCodeExpressionStatement (ccall));

		ccall = new CCodeFunctionCall (new CCodeIdentifier ("g_param_spec_internal"));
		ccall.add_argument (new CCodeIdentifier ( "G_TYPE_PARAM_OBJECT" ));
		ccall.add_argument (new CCodeIdentifier ("name"));
		ccall.add_argument (new CCodeIdentifier ("nick"));
		ccall.add_argument (new CCodeIdentifier ("blurb"));
		ccall.add_argument (new CCodeIdentifier ("flags"));

		init_block.add_statement (new CCodeExpressionStatement (new CCodeAssignment (new CCodeIdentifier ("spec"), ccall, CCodeAssignmentOperator.SIMPLE )));

		ccall = new CCodeFunctionCall (new CCodeIdentifier ("G_PARAM_SPEC"));
		ccall.add_argument (new CCodeIdentifier ("spec"));

		init_block.add_statement (new CCodeExpressionStatement (new CCodeAssignment (new CCodeMemberAccess.pointer (ccall, "value_type"), new CCodeIdentifier ("object_type"), CCodeAssignmentOperator.SIMPLE )));
		init_block.add_statement (new CCodeReturnStatement (ccall));
		source_type_member_definition.append (function);
	}

	private void add_g_value_set_function (Class cl) {
		var function = new CCodeFunction (cl.get_set_value_function (), "void");
		function.add_parameter (new CCodeFormalParameter ("value", "GValue*"));
		function.add_parameter (new CCodeFormalParameter ("v_object", "gpointer"));

		if (cl.access == SymbolAccessibility.PRIVATE) {
			function.modifiers = CCodeModifiers.STATIC;
		}

		var vpointer = new CCodeMemberAccess(new CCodeMemberAccess.pointer (new CCodeIdentifier ("value"), "data[0]"),"v_pointer");

		var init_block = new CCodeBlock ();
		function.block = init_block;

		var ctypedecl = new CCodeDeclaration (cl.get_cname()+"*");
		ctypedecl.add_declarator ( new CCodeVariableDeclarator ("old"));
		init_block.add_statement (ctypedecl);

		var ccall_typecheck = new CCodeFunctionCall (new CCodeIdentifier ("G_TYPE_CHECK_VALUE_TYPE"));
		ccall_typecheck.add_argument (new CCodeIdentifier ( "value" ));
		ccall_typecheck.add_argument (new CCodeIdentifier ( cl.get_type_id() ));

		var ccall = new CCodeFunctionCall (new CCodeIdentifier ("g_return_if_fail"));
		ccall.add_argument (ccall_typecheck);
		init_block.add_statement (new CCodeExpressionStatement (ccall));

		init_block.add_statement(new CCodeExpressionStatement (new CCodeAssignment (new CCodeConstant ("old"), vpointer, CCodeAssignmentOperator.SIMPLE)));

		var true_stmt = new CCodeBlock ();
		var false_stmt = new CCodeBlock ();
		var if_statement = new CCodeIfStatement (new CCodeIdentifier ("v_object"), true_stmt, false_stmt);
		init_block.add_statement (if_statement);


		ccall_typecheck = new CCodeFunctionCall (new CCodeIdentifier ("G_TYPE_CHECK_INSTANCE_TYPE"));
		ccall_typecheck.add_argument (new CCodeIdentifier ( "v_object" ));
		ccall_typecheck.add_argument (new CCodeIdentifier ( cl.get_type_id() ));

		ccall = new CCodeFunctionCall (new CCodeIdentifier ("g_return_if_fail"));
		ccall.add_argument (ccall_typecheck);
		true_stmt.add_statement (new CCodeExpressionStatement (ccall));

		var ccall_typefrominstance = new CCodeFunctionCall (new CCodeIdentifier ("G_TYPE_FROM_INSTANCE"));
		ccall_typefrominstance.add_argument (new CCodeIdentifier ( "v_object" ));

		var ccall_gvaluetype = new CCodeFunctionCall (new CCodeIdentifier ("G_VALUE_TYPE"));
		ccall_gvaluetype.add_argument (new CCodeIdentifier ( "value" ));

		var ccall_typecompatible = new CCodeFunctionCall (new CCodeIdentifier ("g_value_type_compatible"));
		ccall_typecompatible.add_argument (ccall_typefrominstance);
		ccall_typecompatible.add_argument (ccall_gvaluetype);

		ccall = new CCodeFunctionCall (new CCodeIdentifier ("g_return_if_fail"));
		ccall.add_argument (ccall_typecompatible);
		true_stmt.add_statement (new CCodeExpressionStatement (ccall));

		true_stmt.add_statement(new CCodeExpressionStatement (new CCodeAssignment (vpointer, new CCodeConstant ("v_object"), CCodeAssignmentOperator.SIMPLE)));

		ccall = new CCodeFunctionCall (new CCodeIdentifier (cl.get_ref_function ()));
		ccall.add_argument (vpointer);
		true_stmt.add_statement (new CCodeExpressionStatement (ccall));

		false_stmt.add_statement(new CCodeExpressionStatement (new CCodeAssignment (vpointer, new CCodeConstant ("NULL"), CCodeAssignmentOperator.SIMPLE)));

		true_stmt = new CCodeBlock ();
		if_statement = new CCodeIfStatement (new CCodeIdentifier ("old"), true_stmt);
		init_block.add_statement (if_statement);
		
		ccall = new CCodeFunctionCall (new CCodeIdentifier (cl.get_unref_function ()));
		ccall.add_argument (new CCodeIdentifier ("old"));
		true_stmt.add_statement (new CCodeExpressionStatement (ccall));
		source_type_member_definition.append (function);
	}

	private void add_g_value_get_function (Class cl) {
		var function = new CCodeFunction (cl.get_get_value_function (), "gpointer");
		function.add_parameter (new CCodeFormalParameter ("value", "const GValue*"));

		if (cl.access == SymbolAccessibility.PRIVATE) {
			function.modifiers = CCodeModifiers.STATIC;
		}

		var vpointer = new CCodeMemberAccess(new CCodeMemberAccess.pointer (new CCodeIdentifier ("value"), "data[0]"),"v_pointer");

		var init_block = new CCodeBlock ();
		function.block = init_block;

		var ccall_typecheck = new CCodeFunctionCall (new CCodeIdentifier ("G_TYPE_CHECK_VALUE_TYPE"));
		ccall_typecheck.add_argument (new CCodeIdentifier ( "value" ));
		ccall_typecheck.add_argument (new CCodeIdentifier ( cl.get_type_id() ));

		var ccall = new CCodeFunctionCall (new CCodeIdentifier ("g_return_val_if_fail"));
		ccall.add_argument (ccall_typecheck);
		ccall.add_argument (new CCodeIdentifier ( "NULL" ));
		init_block.add_statement (new CCodeExpressionStatement (ccall));

		init_block.add_statement (new CCodeReturnStatement ( vpointer ));
		source_type_member_definition.append (function);
	}

	private void add_base_init_function (Class cl) {
		var base_init = new CCodeFunction ("%s_base_init".printf (cl.get_lower_case_cname (null)), "void");
		base_init.add_parameter (new CCodeFormalParameter ("klass", "%sClass *".printf (cl.get_cname ())));
		base_init.modifiers = CCodeModifiers.STATIC;

		var init_block = new CCodeBlock ();
		base_init.block = init_block;

		if (cl.has_class_private_fields) {
			var block = new CCodeBlock ();
			var cdecl = new CCodeDeclaration ("%sClassPrivate *".printf (cl.get_cname ()));
			cdecl.add_declarator (new CCodeVariableDeclarator ("priv"));
			block.add_statement (cdecl);
			cdecl = new CCodeDeclaration ("%sClassPrivate *".printf (cl.get_cname ()));
			cdecl.add_declarator (new CCodeVariableDeclarator ("parent_priv", new CCodeConstant ("NULL")));
			block.add_statement (cdecl);
			cdecl = new CCodeDeclaration ("GType");
			cdecl.add_declarator (new CCodeVariableDeclarator ("parent_type"));
			block.add_statement (cdecl);

			var ccall = new CCodeFunctionCall (new CCodeIdentifier ("g_type_parent"));
			var ccall2 = new CCodeFunctionCall (new CCodeIdentifier ("G_TYPE_FROM_CLASS"));
			ccall2.add_argument (new CCodeIdentifier ("klass"));
			ccall.add_argument (ccall2);
			block.add_statement (new CCodeExpressionStatement (new CCodeAssignment (new CCodeIdentifier ("parent_type"), ccall)));

			var iftrue = new CCodeBlock ();
			ccall = new CCodeFunctionCall (new CCodeIdentifier ("%s_GET_CLASS_PRIVATE".printf (cl.get_upper_case_cname (null))));
			ccall.add_argument (new CCodeIdentifier ("parent_type"));
			iftrue.add_statement (new CCodeExpressionStatement (new CCodeAssignment (new CCodeIdentifier ("parent_priv"), ccall)));
			block.add_statement (new CCodeIfStatement (new CCodeIdentifier ("parent_type"), iftrue));

			ccall = new CCodeFunctionCall (new CCodeIdentifier ("g_slice_new0"));
			ccall.add_argument (new CCodeIdentifier ("%sClassPrivate".printf(cl.get_cname())));

			block.add_statement (new CCodeExpressionStatement (new CCodeAssignment (new CCodeIdentifier ("priv"), ccall)));

			source_declarations.add_include ("string.h");

			iftrue = new CCodeBlock ();
			ccall = new CCodeFunctionCall (new CCodeIdentifier ("memcpy"));
			ccall.add_argument (new CCodeIdentifier ("priv"));
			ccall.add_argument (new CCodeIdentifier ("parent_priv"));
			ccall.add_argument (new CCodeIdentifier ("sizeof (%sClassPrivate)".printf(cl.get_cname())));
			iftrue.add_statement (new CCodeExpressionStatement (ccall));

			block.add_statement (new CCodeIfStatement (new CCodeIdentifier ("parent_priv"), iftrue));

			ccall = new CCodeFunctionCall (new CCodeIdentifier ("g_type_set_qdata"));
			ccall2 = new CCodeFunctionCall (new CCodeIdentifier ("G_TYPE_FROM_CLASS"));
			ccall2.add_argument (new CCodeIdentifier ("klass"));
			ccall.add_argument (ccall2);
			ccall.add_argument (new CCodeIdentifier ("_vala_%s_class_private_quark".printf (cl.get_lower_case_cname ())));
			ccall.add_argument (new CCodeIdentifier ("priv"));
			block.add_statement (new CCodeExpressionStatement (ccall));

			init_block.add_statement (block);

			block = new CCodeBlock ();
			cdecl = new CCodeDeclaration ("%sClassPrivate *".printf (cl.get_cname ()));
			cdecl.add_declarator (new CCodeVariableDeclarator ("priv"));
			block.add_statement (cdecl);

			ccall = new CCodeFunctionCall (new CCodeIdentifier ("%s_GET_CLASS_PRIVATE".printf (cl.get_upper_case_cname (null))));
			ccall2 = new CCodeFunctionCall (new CCodeIdentifier ("G_TYPE_FROM_CLASS"));
			ccall2.add_argument (new CCodeIdentifier ("klass"));
			ccall.add_argument (ccall2);
			block.add_statement (new CCodeExpressionStatement (new CCodeAssignment (new CCodeIdentifier ("priv"), ccall)));

			ccall = new CCodeFunctionCall (new CCodeIdentifier ("g_slice_free"));
			ccall.add_argument (new CCodeIdentifier ("%sClassPrivate".printf (cl.get_cname ())));
			ccall.add_argument (new CCodeIdentifier ("priv"));
			block.add_statement (new CCodeExpressionStatement (ccall));
			base_finalize_fragment.append (block);
		}

		init_block.add_statement (base_init_fragment);

		source_type_member_definition.append (base_init);
	}

	public virtual void generate_class_init (Class cl, CCodeBlock init_block) {
	}

	private void add_class_init_function (Class cl) {
		var class_init = new CCodeFunction ("%s_class_init".printf (cl.get_lower_case_cname (null)), "void");
		class_init.add_parameter (new CCodeFormalParameter ("klass", "%sClass *".printf (cl.get_cname ())));
		class_init.modifiers = CCodeModifiers.STATIC;

		var init_block = new CCodeBlock ();
		class_init.block = init_block;
		
		CCodeFunctionCall ccall;
		
		/* save pointer to parent class */
		var parent_decl = new CCodeDeclaration ("gpointer");
		var parent_var_decl = new CCodeVariableDeclarator ("%s_parent_class".printf (cl.get_lower_case_cname (null)));
		parent_var_decl.initializer = new CCodeConstant ("NULL");
		parent_decl.add_declarator (parent_var_decl);
		parent_decl.modifiers = CCodeModifiers.STATIC;
		source_declarations.add_type_member_declaration (parent_decl);
		ccall = new CCodeFunctionCall (new CCodeIdentifier ("g_type_class_peek_parent"));
		ccall.add_argument (new CCodeIdentifier ("klass"));
		var parent_assignment = new CCodeAssignment (new CCodeIdentifier ("%s_parent_class".printf (cl.get_lower_case_cname (null))), ccall);
		init_block.add_statement (new CCodeExpressionStatement (parent_assignment));
		

		if (!cl.is_compact && !cl.is_subtype_of (gobject_type) && (cl.get_fields ().size > 0 || cl.destructor != null || cl.is_fundamental ())) {
			// set finalize function
			var fundamental_class = cl;
			while (fundamental_class.base_class != null) {
				fundamental_class = fundamental_class.base_class;
			}

			ccall = new CCodeFunctionCall (new CCodeIdentifier ("%s_CLASS".printf (fundamental_class.get_upper_case_cname (null))));
			ccall.add_argument (new CCodeIdentifier ("klass"));
			var finalize_assignment = new CCodeAssignment (new CCodeMemberAccess.pointer (ccall, "finalize"), new CCodeIdentifier (cl.get_lower_case_cprefix () + "finalize"));
			init_block.add_statement (new CCodeExpressionStatement (finalize_assignment));
		}

		/* add struct for private fields */
		if (cl.has_private_fields || cl.get_type_parameters ().size > 0) {
			ccall = new CCodeFunctionCall (new CCodeIdentifier ("g_type_class_add_private"));
			ccall.add_argument (new CCodeIdentifier ("klass"));
			ccall.add_argument (new CCodeConstant ("sizeof (%sPrivate)".printf (cl.get_cname ())));
			init_block.add_statement (new CCodeExpressionStatement (ccall));
		}

		/* connect overridden methods */
		foreach (Method m in cl.get_methods ()) {
			if (m.base_method == null) {
				continue;
			}
			var base_type = m.base_method.parent_symbol;
			
			var ccast = new CCodeFunctionCall (new CCodeIdentifier ("%s_CLASS".printf (((Class) base_type).get_upper_case_cname (null))));
			ccast.add_argument (new CCodeIdentifier ("klass"));
			init_block.add_statement (new CCodeExpressionStatement (new CCodeAssignment (new CCodeMemberAccess.pointer (ccast, m.base_method.vfunc_name), new CCodeIdentifier (m.get_real_cname ()))));
		}

		/* connect overridden properties */
		foreach (Property prop in cl.get_properties ()) {
			if (prop.base_property == null) {
				continue;
			}
			var base_type = prop.base_property.parent_symbol;
			
			var ccast = new CCodeFunctionCall (new CCodeIdentifier ("%s_CLASS".printf (((Class) base_type).get_upper_case_cname (null))));
			ccast.add_argument (new CCodeIdentifier ("klass"));

			if (prop.get_accessor != null) {
				string cname = "%s_real_get_%s".printf (cl.get_lower_case_cname (null), prop.name);
				init_block.add_statement (new CCodeExpressionStatement (new CCodeAssignment (new CCodeMemberAccess.pointer (ccast, "get_%s".printf (prop.name)), new CCodeIdentifier (cname))));
			}
			if (prop.set_accessor != null) {
				string cname = "%s_real_set_%s".printf (cl.get_lower_case_cname (null), prop.name);
				init_block.add_statement (new CCodeExpressionStatement (new CCodeAssignment (new CCodeMemberAccess.pointer (ccast, "set_%s".printf (prop.name)), new CCodeIdentifier (cname))));
			}
		}

		/* initialize class fields */
		var fields = cl.get_fields ();
		foreach (Field field in fields) {
			if (field.binding != MemberBinding.CLASS || field.initializer == null) {
				continue;
			}

			CCodeExpression left;

			if (field.access == SymbolAccessibility.PRIVATE) {
				ccall = new CCodeFunctionCall (new CCodeIdentifier ("%s_GET_CLASS_PRIVATE".printf (cl.get_upper_case_cname ())));
				var ccall2 = new CCodeFunctionCall (new CCodeIdentifier ("G_TYPE_FROM_CLASS"));
				ccall2.add_argument (new CCodeIdentifier ("klass"));
				ccall.add_argument (ccall2);
				left = new CCodeMemberAccess (ccall, field.get_cname (), true);
			} else {
				left = new CCodeMemberAccess (new CCodeIdentifier ("klass"), field.get_cname (), true);
			}
			CCodeExpression right = (CCodeExpression) field.initializer.ccodenode;
			CCodeAssignment assign = new CCodeAssignment (left, right);
			init_block.add_statement (new CCodeExpressionStatement (assign));
		}

		generate_class_init (cl, init_block);

		if (!cl.is_compact) {
			/* create signals */
			foreach (Signal sig in cl.get_signals ()) {
				init_block.add_statement (new CCodeExpressionStatement (head.get_signal_creation (sig, cl)));
			}
		}

		init_block.add_statement (head.register_dbus_info (cl));
		init_block.add_statement (class_init_fragment);

		source_type_member_definition.append (class_init);
	}
	
	private void add_interface_init_function (Class cl, Interface iface) {
		var iface_init = new CCodeFunction ("%s_%s_interface_init".printf (cl.get_lower_case_cname (null), iface.get_lower_case_cname (null)), "void");
		iface_init.add_parameter (new CCodeFormalParameter ("iface", "%s *".printf (iface.get_type_cname ())));
		iface_init.modifiers = CCodeModifiers.STATIC;
		
		var init_block = new CCodeBlock ();
		iface_init.block = init_block;
		
		CCodeFunctionCall ccall;
		
		/* save pointer to parent vtable */
		string parent_iface_var = "%s_%s_parent_iface".printf (cl.get_lower_case_cname (null), iface.get_lower_case_cname (null));
		var parent_decl = new CCodeDeclaration (iface.get_type_cname () + "*");
		var parent_var_decl = new CCodeVariableDeclarator (parent_iface_var);
		parent_var_decl.initializer = new CCodeConstant ("NULL");
		parent_decl.add_declarator (parent_var_decl);
		parent_decl.modifiers = CCodeModifiers.STATIC;
		source_declarations.add_type_member_declaration (parent_decl);
		ccall = new CCodeFunctionCall (new CCodeIdentifier ("g_type_interface_peek_parent"));
		ccall.add_argument (new CCodeIdentifier ("iface"));
		var parent_assignment = new CCodeAssignment (new CCodeIdentifier (parent_iface_var), ccall);
		init_block.add_statement (new CCodeExpressionStatement (parent_assignment));

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
				cfunc = new CCodeIdentifier (m.get_cname ());
				// Cast the function pointer to match the interface
				string cast = m.return_type.get_cname () + " (*)";
				string cast_args = iface.get_cname () + "*";

				var vdeclarator = new CCodeFunctionDeclarator (m.vfunc_name);
				var cparam_map = new HashMap<int,CCodeFormalParameter> (direct_hash, direct_equal);

				generate_cparameters (m, source_declarations, cparam_map, new CCodeFunction ("fake"), vdeclarator);

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
						cast_args += " ," + cparam_map.get (min_pos).type_name;
					}
					last_pos = min_pos;
				}
				cast += "(" + cast_args + ")";
				cfunc = new CCodeCastExpression (cfunc, cast);
			} else {
				cfunc = new CCodeIdentifier (m.get_real_cname ());
			}
			init_block.add_statement (new CCodeExpressionStatement (new CCodeAssignment (new CCodeMemberAccess.pointer (ciface, m.base_interface_method.vfunc_name), cfunc)));
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

					generate_method_declaration (base_method, source_declarations);

					var ciface = new CCodeIdentifier ("iface");
					init_block.add_statement (new CCodeExpressionStatement (new CCodeAssignment (new CCodeMemberAccess.pointer (ciface, m.vfunc_name), new CCodeIdentifier (base_method.get_cname ()))));
				}
			}
		}

		foreach (Property prop in cl.get_properties ()) {
			if (prop.base_interface_property == null) {
				continue;
			}

			var base_type = prop.base_interface_property.parent_symbol;
			if (base_type != iface) {
				continue;
			}
			
			var ciface = new CCodeIdentifier ("iface");

			if (prop.get_accessor != null) {
				string cname = "%s_real_get_%s".printf (cl.get_lower_case_cname (null), prop.name);
				if (prop.is_abstract || prop.is_virtual) {
					cname = "%s_get_%s".printf (cl.get_lower_case_cname (null), prop.name);
				}
				init_block.add_statement (new CCodeExpressionStatement (new CCodeAssignment (new CCodeMemberAccess.pointer (ciface, "get_%s".printf (prop.name)), new CCodeIdentifier (cname))));
			}
			if (prop.set_accessor != null) {
				string cname = "%s_real_set_%s".printf (cl.get_lower_case_cname (null), prop.name);
				if (prop.is_abstract || prop.is_virtual) {
					cname = "%s_set_%s".printf (cl.get_lower_case_cname (null), prop.name);
				}
				init_block.add_statement (new CCodeExpressionStatement (new CCodeAssignment (new CCodeMemberAccess.pointer (ciface, "set_%s".printf (prop.name)), new CCodeIdentifier (cname))));
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
					string cname = base_property.get_accessor.get_cname ();
					init_block.add_statement (new CCodeExpressionStatement (new CCodeAssignment (new CCodeMemberAccess.pointer (ciface, "get_%s".printf (prop.name)), new CCodeIdentifier (cname))));
				}
				if (base_property.set_accessor != null) {
					string cname = base_property.set_accessor.get_cname ();
					init_block.add_statement (new CCodeExpressionStatement (new CCodeAssignment (new CCodeMemberAccess.pointer (ciface, "set_%s".printf (prop.name)), new CCodeIdentifier (cname))));
				}
			}
		}

		source_type_member_definition.append (iface_init);
	}
	
	private void add_instance_init_function (Class cl) {
		var instance_init = new CCodeFunction ("%s_instance_init".printf (cl.get_lower_case_cname (null)), "void");
		instance_init.add_parameter (new CCodeFormalParameter ("self", "%s *".printf (cl.get_cname ())));
		instance_init.modifiers = CCodeModifiers.STATIC;
		
		if (cl.is_compact) {
			// Add declaration, since the instance_init function is explicitly called
			// by the creation methods
			source_declarations.add_type_member_declaration (instance_init.copy ());
		}

		var init_block = new CCodeBlock ();
		instance_init.block = init_block;
		
		if (!cl.is_compact && (cl.has_private_fields || cl.get_type_parameters ().size > 0)) {
			var ccall = new CCodeFunctionCall (new CCodeIdentifier ("%s_GET_PRIVATE".printf (cl.get_upper_case_cname (null))));
			ccall.add_argument (new CCodeIdentifier ("self"));
			init_block.add_statement (new CCodeExpressionStatement (new CCodeAssignment (new CCodeMemberAccess.pointer (new CCodeIdentifier ("self"), "priv"), ccall)));
		}
		
		init_block.add_statement (instance_init_fragment);

		source_type_member_definition.append (instance_init);
	}

	private void add_class_finalize_function (Class cl) {
		var function = new CCodeFunction ("%s_class_finalize".printf (cl.get_lower_case_cname (null)), "void");
		function.modifiers = CCodeModifiers.STATIC;

		function.add_parameter (new CCodeFormalParameter ("klass", cl.get_cname () + "Class *"));
		source_declarations.add_type_member_declaration (function.copy ());
		
		var cblock = new CCodeBlock ();

		if (cl.class_destructor != null) {
			cblock.add_statement (cl.class_destructor.ccodenode);
		}

		cblock.add_statement (class_finalize_fragment);

		function.block = cblock;
		source_type_member_definition.append (function);
	}

	private void add_base_finalize_function (Class cl) {
		var function = new CCodeFunction ("%s_base_finalize".printf (cl.get_lower_case_cname (null)), "void");
		function.modifiers = CCodeModifiers.STATIC;

		function.add_parameter (new CCodeFormalParameter ("klass", cl.get_cname () + "Class *"));
		source_declarations.add_type_member_declaration (function.copy ());
		
		var cblock = new CCodeBlock ();

		if (cl.class_destructor != null) {
			cblock.add_statement (cl.class_destructor.ccodenode);
		}

		cblock.add_statement (base_finalize_fragment);

		function.block = cblock;
		source_type_member_definition.append (function);
	}

	private void add_finalize_function (Class cl) {
		var function = new CCodeFunction ("%s_finalize".printf (cl.get_lower_case_cname (null)), "void");
		function.modifiers = CCodeModifiers.STATIC;

		var fundamental_class = cl;
		while (fundamental_class.base_class != null) {
			fundamental_class = fundamental_class.base_class;
		}

		function.add_parameter (new CCodeFormalParameter ("obj", fundamental_class.get_cname () + "*"));

		source_declarations.add_type_member_declaration (function.copy ());


		var cblock = new CCodeBlock ();

		CCodeFunctionCall ccall = new InstanceCast (new CCodeIdentifier ("obj"), cl);

		var cdecl = new CCodeDeclaration ("%s *".printf (cl.get_cname ()));
		cdecl.add_declarator (new CCodeVariableDeclarator ("self", ccall));
		
		cblock.add_statement (cdecl);

		if (cl.destructor != null) {
			cblock.add_statement (cl.destructor.ccodenode);
		}

		cblock.add_statement (instance_finalize_fragment);

		// chain up to finalize function of the base class
		if (cl.base_class != null) {
			var ccast = new CCodeFunctionCall (new CCodeIdentifier ("%s_CLASS".printf (fundamental_class.get_upper_case_cname ())));
			ccast.add_argument (new CCodeIdentifier ("%s_parent_class".printf (cl.get_lower_case_cname (null))));
			ccall = new CCodeFunctionCall (new CCodeMemberAccess.pointer (ccast, "finalize"));
			ccall.add_argument (new CCodeIdentifier ("obj"));
			cblock.add_statement (new CCodeExpressionStatement (ccall));
		}


		function.block = cblock;

		source_type_member_definition.append (function);
	}

	public override CCodeFunctionCall get_param_spec (Property prop) {
		var cspec = new CCodeFunctionCall ();
		cspec.add_argument (prop.get_canonical_cconstant ());
		cspec.add_argument (new CCodeConstant ("\"%s\"".printf (prop.nick)));
		cspec.add_argument (new CCodeConstant ("\"%s\"".printf (prop.blurb)));


		if ((prop.property_type.data_type is Class && !(((Class) prop.property_type.data_type).is_compact)) || prop.property_type.data_type is Interface) {
			string param_spec_name = prop.property_type.data_type.get_param_spec_function ();
			if (param_spec_name == null) {
				cspec.call = new CCodeIdentifier ("g_param_spec_pointer");
			} else {
				cspec.call = new CCodeIdentifier (param_spec_name);
				cspec.add_argument (new CCodeIdentifier (prop.property_type.data_type.get_type_id ()));
			}
		} else if (prop.property_type.data_type == string_type.data_type) {
			cspec.call = new CCodeIdentifier ("g_param_spec_string");
			cspec.add_argument (new CCodeConstant ("NULL"));
		} else if (prop.property_type.data_type is Enum) {
			var e = prop.property_type.data_type as Enum;
			if (e.has_type_id) {
				if (e.is_flags) {
					cspec.call = new CCodeIdentifier ("g_param_spec_flags");
				} else {
					cspec.call = new CCodeIdentifier ("g_param_spec_enum");
				}
				cspec.add_argument (new CCodeIdentifier (e.get_type_id ()));
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

			if (prop.default_expression != null) {
				cspec.add_argument ((CCodeExpression) prop.default_expression.ccodenode);
			} else {
				cspec.add_argument (new CCodeConstant (prop.property_type.data_type.get_default_value ()));
			}
		} else if (prop.property_type.data_type is Struct) {
			var st = (Struct) prop.property_type.data_type;
			if (st.get_type_id () == "G_TYPE_INT") {
				cspec.call = new CCodeIdentifier ("g_param_spec_int");
				cspec.add_argument (new CCodeConstant ("G_MININT"));
				cspec.add_argument (new CCodeConstant ("G_MAXINT"));
				if (prop.default_expression != null) {
					cspec.add_argument ((CCodeExpression) prop.default_expression.ccodenode);
				} else {
					cspec.add_argument (new CCodeConstant ("0"));
				}
			} else if (st.get_type_id () == "G_TYPE_UINT") {
				cspec.call = new CCodeIdentifier ("g_param_spec_uint");
				cspec.add_argument (new CCodeConstant ("0"));
				cspec.add_argument (new CCodeConstant ("G_MAXUINT"));
				if (prop.default_expression != null) {
					cspec.add_argument ((CCodeExpression) prop.default_expression.ccodenode);
				} else {
					cspec.add_argument (new CCodeConstant ("0U"));
				}
			} else if (st.get_type_id () == "G_TYPE_INT64") {
				cspec.call = new CCodeIdentifier ("g_param_spec_int64");
				cspec.add_argument (new CCodeConstant ("G_MININT64"));
				cspec.add_argument (new CCodeConstant ("G_MAXINT64"));
				if (prop.default_expression != null) {
					cspec.add_argument ((CCodeExpression) prop.default_expression.ccodenode);
				} else {
					cspec.add_argument (new CCodeConstant ("0"));
				}
			} else if (st.get_type_id () == "G_TYPE_UINT64") {
				cspec.call = new CCodeIdentifier ("g_param_spec_uint64");
				cspec.add_argument (new CCodeConstant ("0"));
				cspec.add_argument (new CCodeConstant ("G_MAXUINT64"));
				if (prop.default_expression != null) {
					cspec.add_argument ((CCodeExpression) prop.default_expression.ccodenode);
				} else {
					cspec.add_argument (new CCodeConstant ("0U"));
				}
			} else if (st.get_type_id () == "G_TYPE_LONG") {
				cspec.call = new CCodeIdentifier ("g_param_spec_long");
				cspec.add_argument (new CCodeConstant ("G_MINLONG"));
				cspec.add_argument (new CCodeConstant ("G_MAXLONG"));
				if (prop.default_expression != null) {
					cspec.add_argument ((CCodeExpression) prop.default_expression.ccodenode);
				} else {
					cspec.add_argument (new CCodeConstant ("0L"));
				}
			} else if (st.get_type_id () == "G_TYPE_ULONG") {
				cspec.call = new CCodeIdentifier ("g_param_spec_ulong");
				cspec.add_argument (new CCodeConstant ("0"));
				cspec.add_argument (new CCodeConstant ("G_MAXULONG"));
				if (prop.default_expression != null) {
					cspec.add_argument ((CCodeExpression) prop.default_expression.ccodenode);
				} else {
					cspec.add_argument (new CCodeConstant ("0UL"));
				}
			} else if (st.get_type_id () == "G_TYPE_BOOLEAN") {
				cspec.call = new CCodeIdentifier ("g_param_spec_boolean");
				if (prop.default_expression != null) {
					cspec.add_argument ((CCodeExpression) prop.default_expression.ccodenode);
				} else {
					cspec.add_argument (new CCodeConstant ("FALSE"));
				}
			} else if (st.get_type_id () == "G_TYPE_CHAR") {
				cspec.call = new CCodeIdentifier ("g_param_spec_char");
				cspec.add_argument (new CCodeConstant ("G_MININT8"));
				cspec.add_argument (new CCodeConstant ("G_MAXINT8"));
				if (prop.default_expression != null) {
					cspec.add_argument ((CCodeExpression) prop.default_expression.ccodenode);
				} else {
					cspec.add_argument (new CCodeConstant ("0"));
				}
			} else if (st.get_type_id () == "G_TYPE_UCHAR") {
				cspec.call = new CCodeIdentifier ("g_param_spec_uchar");
				cspec.add_argument (new CCodeConstant ("0"));
				cspec.add_argument (new CCodeConstant ("G_MAXUINT8"));
				if (prop.default_expression != null) {
					cspec.add_argument ((CCodeExpression) prop.default_expression.ccodenode);
				} else {
					cspec.add_argument (new CCodeConstant ("0"));
				}
			}else if (st.get_type_id () == "G_TYPE_FLOAT") {
				cspec.call = new CCodeIdentifier ("g_param_spec_float");
				cspec.add_argument (new CCodeConstant ("-G_MAXFLOAT"));
				cspec.add_argument (new CCodeConstant ("G_MAXFLOAT"));
				if (prop.default_expression != null) {
					cspec.add_argument ((CCodeExpression) prop.default_expression.ccodenode);
				} else {
					cspec.add_argument (new CCodeConstant ("0.0F"));
				}
			} else if (st.get_type_id () == "G_TYPE_DOUBLE") {
				cspec.call = new CCodeIdentifier ("g_param_spec_double");
				cspec.add_argument (new CCodeConstant ("-G_MAXDOUBLE"));
				cspec.add_argument (new CCodeConstant ("G_MAXDOUBLE"));
				if (prop.default_expression != null) {
					cspec.add_argument ((CCodeExpression) prop.default_expression.ccodenode);
				} else {
					cspec.add_argument (new CCodeConstant ("0.0"));
				}
			} else if (st.get_type_id () == "G_TYPE_GTYPE") {
				cspec.call = new CCodeIdentifier ("g_param_spec_gtype");
				if (prop.default_expression != null) {
					cspec.add_argument ((CCodeExpression) prop.default_expression.ccodenode);
				} else {
					cspec.add_argument (new CCodeConstant ("G_TYPE_NONE"));
				}
			} else {
				cspec.call = new CCodeIdentifier ("g_param_spec_boxed");
				cspec.add_argument (new CCodeIdentifier (st.get_type_id ()));
			}
		} else {
			cspec.call = new CCodeIdentifier ("g_param_spec_pointer");
		}
		
		var pflags = "G_PARAM_STATIC_NAME | G_PARAM_STATIC_NICK | G_PARAM_STATIC_BLURB";
		if (prop.get_accessor != null) {
			pflags = "%s%s".printf (pflags, " | G_PARAM_READABLE");
		}
		if (prop.set_accessor != null) {
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

	public override void generate_interface_declaration (Interface iface, CCodeDeclarationSpace decl_space) {
		if (decl_space.add_symbol_declaration (iface, iface.get_cname ())) {
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

		var type_struct = new CCodeStruct ("_%s".printf (iface.get_type_cname ()));
		
		decl_space.add_type_declaration (new CCodeNewline ());
		var macro = "(%s_get_type ())".printf (iface.get_lower_case_cname (null));
		decl_space.add_type_declaration (new CCodeMacroReplacement (iface.get_type_id (), macro));

		macro = "(G_TYPE_CHECK_INSTANCE_CAST ((obj), %s, %s))".printf (iface.get_type_id (), iface.get_cname ());
		decl_space.add_type_declaration (new CCodeMacroReplacement ("%s(obj)".printf (iface.get_upper_case_cname (null)), macro));

		macro = "(G_TYPE_CHECK_INSTANCE_TYPE ((obj), %s))".printf (iface.get_type_id ());
		decl_space.add_type_declaration (new CCodeMacroReplacement ("%s(obj)".printf (get_type_check_function (iface)), macro));

		macro = "(G_TYPE_INSTANCE_GET_INTERFACE ((obj), %s, %s))".printf (iface.get_type_id (), iface.get_type_cname ());
		decl_space.add_type_declaration (new CCodeMacroReplacement ("%s_GET_INTERFACE(obj)".printf (iface.get_upper_case_cname (null)), macro));
		decl_space.add_type_declaration (new CCodeNewline ());

		decl_space.add_type_declaration (new CCodeTypeDefinition ("struct _%s".printf (iface.get_cname ()), new CCodeVariableDeclarator (iface.get_cname ())));
		decl_space.add_type_declaration (new CCodeTypeDefinition ("struct %s".printf (type_struct.name), new CCodeVariableDeclarator (iface.get_type_cname ())));

		type_struct.add_field ("GTypeInterface", "parent_iface");

		foreach (Method m in iface.get_methods ()) {
			if ((!m.is_abstract && !m.is_virtual) || m.coroutine) {
				continue;
			}

			// add vfunc field to the type struct
			var vdeclarator = new CCodeFunctionDeclarator (m.vfunc_name);
			var cparam_map = new HashMap<int,CCodeFormalParameter> (direct_hash, direct_equal);

			generate_cparameters (m, decl_space, cparam_map, new CCodeFunction ("fake"), vdeclarator);

			var vdecl = new CCodeDeclaration (m.return_type.get_cname ());
			vdecl.add_declarator (vdeclarator);
			type_struct.add_declaration (vdecl);
		}

		foreach (Property prop in iface.get_properties ()) {
			if (!prop.is_abstract && !prop.is_virtual) {
				continue;
			}
			generate_type_declaration (prop.property_type, decl_space);

			var t = (ObjectTypeSymbol) prop.parent_symbol;

			bool returns_real_struct = prop.property_type.is_real_struct_type ();

			var this_type = new ObjectType (t);
			var cselfparam = new CCodeFormalParameter ("self", this_type.get_cname ());

			if (prop.get_accessor != null) {
				var vdeclarator = new CCodeFunctionDeclarator ("get_%s".printf (prop.name));
				vdeclarator.add_parameter (cselfparam);
				string creturn_type;
				if (returns_real_struct) {
					var cvalueparam = new CCodeFormalParameter ("value", prop.get_accessor.value_type.get_cname () + "*");
					vdeclarator.add_parameter (cvalueparam);
					creturn_type = "void";
				} else {
					creturn_type = prop.get_accessor.value_type.get_cname ();
				}
				var vdecl = new CCodeDeclaration (creturn_type);
				vdecl.add_declarator (vdeclarator);
				type_struct.add_declaration (vdecl);
			}
			if (prop.set_accessor != null) {
				var vdeclarator = new CCodeFunctionDeclarator ("set_%s".printf (prop.name));
				vdeclarator.add_parameter (cselfparam);
				if (returns_real_struct) {
					var cvalueparam = new CCodeFormalParameter ("value", prop.set_accessor.value_type.get_cname () + "*");
					vdeclarator.add_parameter (cvalueparam);
				} else {
					var cvalueparam = new CCodeFormalParameter ("value", prop.set_accessor.value_type.get_cname ());
					vdeclarator.add_parameter (cvalueparam);
				}
				var vdecl = new CCodeDeclaration ("void");
				vdecl.add_declarator (vdeclarator);
				type_struct.add_declaration (vdecl);
			}
		}

		if (iface.source_reference.comment != null) {
			decl_space.add_type_definition (new CCodeComment (iface.source_reference.comment));
		}
		decl_space.add_type_definition (type_struct);

		var type_fun = new InterfaceRegisterFunction (iface, context);
		type_fun.init_from_type ();
		decl_space.add_type_member_declaration (type_fun.get_declaration ());
	}

	public override void visit_interface (Interface iface) {
		current_symbol = iface;
		current_type_symbol = iface;

		if (iface.get_cname().len () < 3) {
			iface.error = true;
			Report.error (iface.source_reference, "Interface name `%s' is too short".printf (iface.get_cname ()));
			return;
		}

		generate_interface_declaration (iface, source_declarations);

		iface.accept_children (codegen);

		add_interface_base_init_function (iface);

		var type_fun = new InterfaceRegisterFunction (iface, context);
		type_fun.init_from_type ();
		source_type_member_definition.append (type_fun.get_definition ());

		current_type_symbol = null;
	}

	private void add_interface_base_init_function (Interface iface) {
		var base_init = new CCodeFunction ("%s_base_init".printf (iface.get_lower_case_cname (null)), "void");
		base_init.add_parameter (new CCodeFormalParameter ("iface", "%sIface *".printf (iface.get_cname ())));
		base_init.modifiers = CCodeModifiers.STATIC;
		
		var init_block = new CCodeBlock ();
		
		/* make sure not to run the initialization code twice */
		base_init.block = new CCodeBlock ();
		var decl = new CCodeDeclaration (bool_type.get_cname ());
		decl.modifiers |= CCodeModifiers.STATIC;
		decl.add_declarator (new CCodeVariableDeclarator ("initialized", new CCodeConstant ("FALSE")));
		base_init.block.add_statement (decl);
		var cif = new CCodeIfStatement (new CCodeUnaryExpression (CCodeUnaryOperator.LOGICAL_NEGATION, new CCodeIdentifier ("initialized")), init_block);
		base_init.block.add_statement (cif);
		init_block.add_statement (new CCodeExpressionStatement (new CCodeAssignment (new CCodeIdentifier ("initialized"), new CCodeConstant ("TRUE"))));

		if (iface.is_subtype_of (gobject_type)) {
			/* create properties */
			var props = iface.get_properties ();
			foreach (Property prop in props) {
				if (prop.is_abstract) {
					var cinst = new CCodeFunctionCall (new CCodeIdentifier ("g_object_interface_install_property"));
					cinst.add_argument (new CCodeIdentifier ("iface"));
					cinst.add_argument (head.get_param_spec (prop));

					init_block.add_statement (new CCodeExpressionStatement (cinst));
				}
			}
		}

		/* create signals */
		foreach (Signal sig in iface.get_signals ()) {
			init_block.add_statement (new CCodeExpressionStatement (head.get_signal_creation (sig, iface)));
		}

		// connect default implementations
		foreach (Method m in iface.get_methods ()) {
			if (m.is_virtual) {
				var ciface = new CCodeIdentifier ("iface");
				var cname = m.get_real_cname ();
				base_init.block.add_statement (new CCodeExpressionStatement (new CCodeAssignment (new CCodeMemberAccess.pointer (ciface, m.vfunc_name), new CCodeIdentifier (cname))));
			}
		}

		init_block.add_statement (head.register_dbus_info (iface));

		source_type_member_definition.append (base_init);
	}

	public override void visit_struct (Struct st) {
		base.visit_struct (st);

		if (st.has_type_id) {
			var type_fun = new StructRegisterFunction (st, context);
			type_fun.init_from_type (false);
			source_type_member_definition.append (type_fun.get_definition ());
		}
	}
}
