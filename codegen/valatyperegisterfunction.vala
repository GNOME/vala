/* valatyperegisterfunction.vala
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

/**
 * C function to register a type at runtime.
 */
public abstract class Vala.TypeRegisterFunction {
	CCodeFragment source_declaration_fragment = new CCodeFragment ();
	CCodeFragment declaration_fragment = new CCodeFragment ();
	CCodeFragment definition_fragment = new CCodeFragment ();

	public CodeContext context { get; set; }

	/**
	 * Constructs the C function from the specified type.
	 */
	public void init_from_type (bool plugin, bool declaration_only) {
		bool use_thread_safe = !plugin;

		bool fundamental = false;
		Class cl = get_type_declaration () as Class;
		if (cl != null && !cl.is_compact && cl.base_class == null) {
			fundamental = true;
		}

		string type_id_name = "%s_type_id".printf (CCodeBaseModule.get_ccode_lower_case_name (get_type_declaration ()));

		var type_block = new CCodeBlock ();
		CCodeDeclaration cdecl;
		if (use_thread_safe) {
			cdecl = new CCodeDeclaration ("gsize");
			cdecl.add_declarator (new CCodeVariableDeclarator (type_id_name + "__volatile", new CCodeConstant ("0")));
		} else {
			cdecl = new CCodeDeclaration ("GType");
			cdecl.add_declarator (new CCodeVariableDeclarator (type_id_name, new CCodeConstant ("0")));
		}
		cdecl.modifiers = CCodeModifiers.STATIC;
		if (use_thread_safe) {
			cdecl.modifiers |= CCodeModifiers.VOLATILE;
		}
		if (!plugin) {
			type_block.add_statement (cdecl);
		} else {
			source_declaration_fragment.append (cdecl);
		}

		CCodeFunction fun;
		if (!plugin) {
			fun = new CCodeFunction ("%s_get_type".printf (CCodeBaseModule.get_ccode_lower_case_name (get_type_declaration ())), "GType");
			fun.attributes = "G_GNUC_CONST";

			/* Function will not be prototyped anyway */
			if (get_accessibility () == SymbolAccessibility.PRIVATE) {
				fun.modifiers = CCodeModifiers.STATIC;
				// avoid C warning as this function is not always used
				fun.attributes += " G_GNUC_UNUSED";
			}
		} else {
			fun = new CCodeFunction ("%s_register_type".printf (CCodeBaseModule.get_ccode_lower_case_name (get_type_declaration ())), "GType");
			fun.add_parameter (new CCodeParameter ("module", "GTypeModule *"));

			var get_fun = new CCodeFunction ("%s_get_type".printf (CCodeBaseModule.get_ccode_lower_case_name (get_type_declaration ())), "GType");
			get_fun.attributes = "G_GNUC_CONST";

			get_fun.is_declaration = true;
			declaration_fragment.append (get_fun.copy ());
			get_fun.is_declaration = false;

			get_fun.block = new CCodeBlock ();
			get_fun.block.add_statement (new CCodeReturnStatement (new CCodeIdentifier (type_id_name)));

			definition_fragment.append (get_fun);
		}

		string type_value_table_decl_name = null;
		var type_init = new CCodeBlock ();

		if (fundamental) {
			var cgtypetabledecl = new CCodeDeclaration ("const GTypeValueTable");
			cgtypetabledecl.modifiers = CCodeModifiers.STATIC;

			cgtypetabledecl.add_declarator (new CCodeVariableDeclarator ( "g_define_type_value_table", new CCodeConstant ("{ %s, %s, %s, %s, \"p\", %s, \"p\", %s }".printf (get_gtype_value_table_init_function_name (), get_gtype_value_table_free_function_name (), get_gtype_value_table_copy_function_name (), get_gtype_value_table_peek_pointer_function_name (), get_gtype_value_table_collect_value_function_name (), get_gtype_value_table_lcopy_value_function_name ()))));
			type_value_table_decl_name = "&g_define_type_value_table";
			type_init.add_statement ( cgtypetabledecl );
		}
		else {
			type_value_table_decl_name = "NULL";
		}


		if (get_type_declaration () is ObjectTypeSymbol) {
			var ctypedecl = new CCodeDeclaration ("const GTypeInfo");
			ctypedecl.modifiers = CCodeModifiers.STATIC;
			ctypedecl.add_declarator (new CCodeVariableDeclarator ("g_define_type_info", new CCodeConstant ("{ sizeof (%s), (GBaseInitFunc) %s, (GBaseFinalizeFunc) %s, (GClassInitFunc) %s, (GClassFinalizeFunc) %s, NULL, %s, 0, (GInstanceInitFunc) %s, %s }".printf (get_type_struct_name (), get_base_init_func_name (), (plugin) ? get_base_finalize_func_name () : "NULL", get_class_init_func_name (), get_class_finalize_func_name (), get_instance_struct_size (), get_instance_init_func_name (), type_value_table_decl_name))));
			type_init.add_statement (ctypedecl);
			if (fundamental) {
				var ctypefundamentaldecl = new CCodeDeclaration ("const GTypeFundamentalInfo");
				ctypefundamentaldecl.modifiers = CCodeModifiers.STATIC;
				ctypefundamentaldecl.add_declarator (new CCodeVariableDeclarator ("g_define_type_fundamental_info", new CCodeConstant ("{ (G_TYPE_FLAG_CLASSED | G_TYPE_FLAG_INSTANTIATABLE | G_TYPE_FLAG_DERIVABLE | G_TYPE_FLAG_DEEP_DERIVABLE) }")));
				type_init.add_statement (ctypefundamentaldecl);
			}
		}

		type_init.add_statement (get_type_interface_init_declaration ());

		if (cl != null && cl.has_class_private_fields && !context.require_glib_version (2, 24)) {
			CCodeFunctionCall quark_reg_call;

			if (plugin) {
				quark_reg_call = new CCodeFunctionCall (new CCodeIdentifier ("g_quark_from_string"));
			} else {
				quark_reg_call = new CCodeFunctionCall (new CCodeIdentifier ("g_quark_from_static_string"));
			}

			quark_reg_call.add_argument (new CCodeConstant ("\"Vala%sClassPrivate\"".printf (CCodeBaseModule.get_ccode_name (get_type_declaration ()))));

			type_init.add_statement (new CCodeExpressionStatement (new CCodeAssignment (new CCodeIdentifier ("_vala_%s_class_private_quark".printf (CCodeBaseModule.get_ccode_lower_case_name (get_type_declaration ()))), quark_reg_call)));
		}

		CCodeFunctionCall reg_call;
		if (get_type_declaration () is Struct) {
			reg_call = new CCodeFunctionCall (new CCodeIdentifier ("g_boxed_type_register_static"));
		} else if (get_type_declaration () is Enum) {
			var en = get_type_declaration () as Enum;
			if (en.is_flags) {
				reg_call = new CCodeFunctionCall (new CCodeIdentifier ("g_flags_register_static"));
			} else {
				reg_call = new CCodeFunctionCall (new CCodeIdentifier ("g_enum_register_static"));
			}
		} else if (fundamental) {
			reg_call = new CCodeFunctionCall (new CCodeIdentifier ("g_type_register_fundamental"));
			reg_call.add_argument (new CCodeFunctionCall (new CCodeIdentifier ("g_type_fundamental_next")));
		} else if (!plugin) {
			reg_call = new CCodeFunctionCall (new CCodeIdentifier ("g_type_register_static"));
			reg_call.add_argument (new CCodeIdentifier (get_parent_type_name ()));
		} else {
			reg_call = new CCodeFunctionCall (new CCodeIdentifier ("g_type_module_register_type"));
			reg_call.add_argument (new CCodeIdentifier ("module"));
			reg_call.add_argument (new CCodeIdentifier (get_parent_type_name ()));
		}
		reg_call.add_argument (new CCodeConstant ("\"%s\"".printf (CCodeBaseModule.get_ccode_name (get_type_declaration ()))));
		if (get_type_declaration () is Struct) {
			var st = (Struct) get_type_declaration ();
			reg_call.add_argument (new CCodeCastExpression (new CCodeIdentifier (CCodeBaseModule.get_ccode_dup_function (st)), "GBoxedCopyFunc"));
			reg_call.add_argument (new CCodeCastExpression (new CCodeIdentifier (CCodeBaseModule.get_ccode_free_function (st)), "GBoxedFreeFunc"));
		} else if (get_type_declaration () is Enum) {
			var en = get_type_declaration () as Enum;
			var clist = new CCodeInitializerList (); /* or during visit time? */

			CCodeInitializerList clist_ev = null;
			foreach (EnumValue ev in en.get_values ()) {
				clist_ev = new CCodeInitializerList ();
				clist_ev.append (new CCodeConstant (CCodeBaseModule.get_ccode_name (ev)));
				clist_ev.append (new CCodeIdentifier ("\"%s\"".printf (CCodeBaseModule.get_ccode_name (ev))));
				clist_ev.append (CCodeBaseModule.get_enum_value_canonical_cconstant (ev));
				clist.append (clist_ev);
			}

			clist_ev = new CCodeInitializerList ();
			clist_ev.append (new CCodeConstant ("0"));
			clist_ev.append (new CCodeConstant ("NULL"));
			clist_ev.append (new CCodeConstant ("NULL"));
			clist.append (clist_ev);

			var enum_decl = new CCodeVariableDeclarator ("values[]", clist);

			if (en.is_flags) {
				cdecl = new CCodeDeclaration ("const GFlagsValue");
			} else {
				cdecl = new CCodeDeclaration ("const GEnumValue");
			}

			cdecl.add_declarator (enum_decl);
			cdecl.modifiers = CCodeModifiers.STATIC;

			type_init.add_statement (cdecl);

			reg_call.add_argument (new CCodeIdentifier ("values"));
		} else {
			reg_call.add_argument (new CCodeIdentifier ("&g_define_type_info"));
			if (fundamental) {
				reg_call.add_argument (new CCodeIdentifier ("&g_define_type_fundamental_info"));
			}
			reg_call.add_argument (new CCodeConstant (get_type_flags ()));
		}

		if (use_thread_safe && !plugin) {
			var temp_decl = new CCodeDeclaration ("GType");
			temp_decl.add_declarator (new CCodeVariableDeclarator (type_id_name, reg_call));
			type_init.add_statement (temp_decl);
		} else {
			type_init.add_statement (new CCodeExpressionStatement (new CCodeAssignment (new CCodeIdentifier (type_id_name), reg_call)));
		}

		 if (cl != null && cl.has_class_private_fields && context.require_glib_version (2, 24)) {
			CCodeFunctionCall add_class_private_call;

			add_class_private_call = new CCodeFunctionCall (new CCodeIdentifier ("g_type_add_class_private"));
			add_class_private_call.add_argument (new CCodeIdentifier (type_id_name));
			add_class_private_call.add_argument (new CCodeIdentifier ("sizeof (%sClassPrivate)".printf (CCodeBaseModule.get_ccode_name (get_type_declaration ()))));
			type_init.add_statement (new CCodeExpressionStatement (add_class_private_call));
		}

		if (!declaration_only) {
			get_type_interface_init_statements (type_init, plugin);
		}

		if (!plugin) {
			CCodeExpression condition; // the condition that guards the type initialisation
			if (use_thread_safe) {
				var enter = new CCodeFunctionCall (new CCodeIdentifier ("g_once_init_enter"));
				enter.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, new CCodeIdentifier (type_id_name + "__volatile")));
				condition = enter;

				var leave = new CCodeFunctionCall (new CCodeIdentifier ("g_once_init_leave"));
				leave.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, new CCodeIdentifier (type_id_name + "__volatile")));
				leave.add_argument (new CCodeIdentifier (type_id_name));
				type_init.add_statement (new CCodeExpressionStatement (leave));
			} else {
				var id = new CCodeIdentifier (type_id_name);
				var zero = new CCodeConstant ("0");
				condition = new CCodeBinaryExpression (CCodeBinaryOperator.EQUALITY, id, zero);
			}

			CCodeExpression cond;
			if (use_thread_safe) {
				cond = condition;
			} else {
				cond = new CCodeFunctionCall (new CCodeIdentifier ("G_UNLIKELY"));
				(cond as CCodeFunctionCall).add_argument (condition);
			}
			var cif = new CCodeIfStatement (cond, type_init);
			type_block.add_statement (cif);
		} else {
			type_block = type_init;
		}

		if (use_thread_safe) {
			type_block.add_statement (new CCodeReturnStatement (new CCodeIdentifier (type_id_name + "__volatile")));
		} else {
			type_block.add_statement (new CCodeReturnStatement (new CCodeIdentifier (type_id_name)));
		}

		fun.is_declaration = true;
		declaration_fragment.append (fun.copy ());
		fun.is_declaration = false;

		fun.block = type_block;

		definition_fragment.append (fun);
	}
	
	/**
	 * Returns the data type to be registered.
	 *
	 * @return type to be registered
	 */
	public abstract TypeSymbol get_type_declaration ();

	/**
	 * Returns the name of the type struct in C code.
	 *
	 * @return C struct name
	 */
	public virtual string get_type_struct_name () {
		assert_not_reached ();
	}
	/**
	 * Returns the name of the base_init function in C code.
	 *
	 * @return C function name
	 */
	public virtual string get_base_init_func_name () {
		assert_not_reached ();
	}

	/**
	 * Returns the name of the class_finalize function in C code.
	 *
	 * @return C function name
	 */
	public virtual string get_class_finalize_func_name () {
		assert_not_reached ();
	}

	/**
	 * Returns the name of the base_finalize function in C code.
	 *
	 * @return C function name
	 */
	public virtual string get_base_finalize_func_name () {
		assert_not_reached ();
	}

	/**
	 * Returns the name of the class_init function in C code.
	 *
	 * @return C function name
	 */
	public virtual string get_class_init_func_name () {
		assert_not_reached ();
	}

	/**
	 * Returns the size of the instance struct in C code.
	 *
	 * @return C instance struct size
	 */
	public virtual string get_instance_struct_size () {
		assert_not_reached ();
	}

	/**
	 * Returns the name of the instance_init function in C code.
	 *
	 * @return C function name
	 */
	public virtual string get_instance_init_func_name () {
		assert_not_reached ();
	}

	/**
	 * Returns the name of the parent type in C code.
	 *
	 * @return C function name
	 */
	public virtual string get_parent_type_name () {
		assert_not_reached ();
	}



	/**
	 * Returns the C-name of the new generated GTypeValueTable init function or null when not available.
	 *
	 * @return C function name
	 */
	public virtual string? get_gtype_value_table_init_function_name () {
		return null;
	}

	/**
	 * Returns the C-name of the new generated GTypeValueTable peek pointer function or null when not available.
	 *
	 * @return C function name
	 */
	public virtual string? get_gtype_value_table_peek_pointer_function_name () {
		return null;
	}

	/**
	 * Returns the C-name of the new generated GTypeValueTable free function or null when not available.
	 *
	 * @return C function name
	 */
	public virtual string? get_gtype_value_table_free_function_name () {
		return null;
	}

	/**
	 * Returns the C-name of the new generated GTypeValueTable copy function or null when not available.
	 *
	 * @return C function name
	 */
	public virtual string? get_gtype_value_table_copy_function_name () {
		return null;
	}

	/**
	 * Returns the C-name of the new generated GTypeValueTable lcopy function or null when not available.
	 *
	 * @return C function name
	 */
	public virtual string? get_gtype_value_table_lcopy_value_function_name () {
		return null;
	}

	/**
	 * Returns the C-name of the new generated GTypeValueTable collect value function or null when not available.
	 *
	 * @return C function name
	 */
	public virtual string? get_gtype_value_table_collect_value_function_name () {
		return null;
	}

	/**
	 * Returns the set of type flags to be applied when registering.
	 *
	 * @return type flags
	 */
	public virtual string get_type_flags () {
		return "0";
	}

	/**
	 * Returns additional C declarations to setup interfaces.
	 *
	 * @return C declarations
	 */
	public virtual CCodeFragment get_type_interface_init_declaration () {
		return new CCodeFragment ();
	}

	/**
	 * Returns additional C initialization statements to setup interfaces.
	 *
	 * @return C statements
	 */
	public virtual void get_type_interface_init_statements (CCodeBlock block, bool plugin) {
	}
	
	public CCodeFragment get_source_declaration () {
		return source_declaration_fragment;
	}

	/**
	 * Returns the declaration for this type register function in C code.
	 *
	 * @return C function declaration fragment
	 */
	public CCodeFragment get_declaration () {
		return declaration_fragment;
	}
	
	/**
	 * Returns the definition for this type register function in C code.
	 *
	 * @return C function definition fragment
	 */
	public CCodeFragment get_definition () {
		return definition_fragment;
	}

	/**
	 * Returns the accessibility for this type.
	 */
	public abstract SymbolAccessibility get_accessibility ();
}
