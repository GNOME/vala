/* valacodegeneratorclass.vala
 *
 * Copyright (C) 2006-2007  Jürg Billeter, Raffaele Sandrini
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
 *	Raffaele Sandrini <rasa@gmx.ch>
 */

using GLib;

public class Vala.CodeGenerator {
	public override void visit_class (Class! cl) {
		var old_symbol = current_symbol;
		var old_type_symbol = current_type_symbol;
		var old_class = current_class;
		var old_instance_struct = instance_struct;
		var old_type_struct = type_struct;
		var old_instance_priv_struct = instance_priv_struct;
		var old_prop_enum = prop_enum;
		var old_class_init_fragment = class_init_fragment;
		var old_instance_init_fragment = instance_init_fragment;
		var old_instance_dispose_fragment = instance_dispose_fragment;
		current_symbol = cl;
		current_type_symbol = cl;
		current_class = cl;
		
		bool is_gobject = cl.is_subtype_of (gobject_type);

		if (cl.get_cname().len () < 3) {
			cl.error = true;
			Report.error (cl.source_reference, "Class name `%s' is too short".printf (cl.get_cname ()));
			return;
		}

		if (!cl.is_static) {
			instance_struct = new CCodeStruct ("_%s".printf (cl.get_cname ()));
			type_struct = new CCodeStruct ("_%sClass".printf (cl.get_cname ()));
			instance_priv_struct = new CCodeStruct ("_%sPrivate".printf (cl.get_cname ()));
			prop_enum = new CCodeEnum ();
			prop_enum.add_value ("%s_DUMMY_PROPERTY".printf (cl.get_upper_case_cname (null)), null);
			class_init_fragment = new CCodeFragment ();
			instance_init_fragment = new CCodeFragment ();
			instance_dispose_fragment = new CCodeFragment ();
		}

		CCodeFragment decl_frag;
		CCodeFragment def_frag;
		if (cl.access != SymbolAccessibility.PRIVATE) {
			decl_frag = header_type_declaration;
			def_frag = header_type_definition;
		} else {
			decl_frag = source_type_member_declaration;
			def_frag = source_type_member_declaration;
		}

		var macro = "(%s_get_type ())".printf (cl.get_lower_case_cname (null));
		if (is_gobject) {
			decl_frag.append (new CCodeNewline ());
			decl_frag.append (new CCodeMacroReplacement (cl.get_upper_case_cname ("TYPE_"), macro));

			macro = "(G_TYPE_CHECK_INSTANCE_CAST ((obj), %s, %s))".printf (cl.get_upper_case_cname ("TYPE_"), cl.get_cname ());
			decl_frag.append (new CCodeMacroReplacement ("%s(obj)".printf (cl.get_upper_case_cname (null)), macro));

			macro = "(G_TYPE_CHECK_CLASS_CAST ((klass), %s, %sClass))".printf (cl.get_upper_case_cname ("TYPE_"), cl.get_cname ());
			decl_frag.append (new CCodeMacroReplacement ("%s_CLASS(klass)".printf (cl.get_upper_case_cname (null)), macro));

			macro = "(G_TYPE_CHECK_INSTANCE_TYPE ((obj), %s))".printf (cl.get_upper_case_cname ("TYPE_"));
			decl_frag.append (new CCodeMacroReplacement ("%s(obj)".printf (cl.get_upper_case_cname ("IS_")), macro));

			macro = "(G_TYPE_CHECK_CLASS_TYPE ((klass), %s))".printf (cl.get_upper_case_cname ("TYPE_"));
			decl_frag.append (new CCodeMacroReplacement ("%s_CLASS(klass)".printf (cl.get_upper_case_cname ("IS_")), macro));

			macro = "(G_TYPE_INSTANCE_GET_CLASS ((obj), %s, %sClass))".printf (cl.get_upper_case_cname ("TYPE_"), cl.get_cname ());
			decl_frag.append (new CCodeMacroReplacement ("%s_GET_CLASS(obj)".printf (cl.get_upper_case_cname (null)), macro));
			decl_frag.append (new CCodeNewline ());
		}


		if (!cl.is_static && cl.source_reference.file.cycle == null) {
			decl_frag.append (new CCodeTypeDefinition ("struct %s".printf (instance_struct.name), new CCodeVariableDeclarator (cl.get_cname ())));
		}

		if (is_gobject) {
			if (cl.source_reference.file.cycle == null) {
				decl_frag.append (new CCodeTypeDefinition ("struct %s".printf (type_struct.name), new CCodeVariableDeclarator ("%sClass".printf (cl.get_cname ()))));
			}
			decl_frag.append (new CCodeTypeDefinition ("struct %s".printf (instance_priv_struct.name), new CCodeVariableDeclarator ("%sPrivate".printf (cl.get_cname ()))));

			instance_struct.add_field (cl.base_class.get_cname (), "parent");
			instance_struct.add_field ("%sPrivate *".printf (cl.get_cname ()), "priv");
			type_struct.add_field ("%sClass".printf (cl.base_class.get_cname ()), "parent");
		}

		if (!cl.is_static) {
			if (cl.source_reference.comment != null) {
				def_frag.append (new CCodeComment (cl.source_reference.comment));
			}
			def_frag.append (instance_struct);
		}

		if (is_gobject) {
			def_frag.append (type_struct);
			/* only add the *Private struct if it is not empty, i.e. we actually have private data */
			if (cl.has_private_fields || cl.get_type_parameters ().size > 0) {
				source_type_member_declaration.append (instance_priv_struct);
				macro = "(G_TYPE_INSTANCE_GET_PRIVATE ((o), %s, %sPrivate))".printf (cl.get_upper_case_cname ("TYPE_"), cl.get_cname ());
				source_type_member_declaration.append (new CCodeMacroReplacement ("%s_GET_PRIVATE(o)".printf (cl.get_upper_case_cname (null)), macro));
			}
			source_type_member_declaration.append (prop_enum);
		}

		cl.accept_children (this);

		if (is_gobject) {
			if (class_has_readable_properties (cl) || cl.get_type_parameters ().size > 0) {
				add_get_property_function (cl);
			}
			if (class_has_writable_properties (cl) || cl.get_type_parameters ().size > 0) {
				add_set_property_function (cl);
			}
			add_class_init_function (cl);
			
			foreach (TypeReference base_type in cl.get_base_types ()) {
				if (base_type.data_type is Interface) {
					add_interface_init_function (cl, (Interface) base_type.data_type);
				}
			}
			
			add_instance_init_function (cl);
			if ((memory_management && cl.get_fields ().size > 0) || cl.destructor != null) {
				add_dispose_function (cl);
			}
			
			var type_fun = new ClassRegisterFunction (cl);
			type_fun.init_from_type (in_plugin);
			if (cl.access != SymbolAccessibility.PRIVATE) {
				header_type_member_declaration.append (type_fun.get_declaration ());
			} else {
				source_type_member_declaration.append (type_fun.get_declaration ());
			}
			source_type_member_definition.append (type_fun.get_definition ());
			
			if (in_plugin) {
				// FIXME resolve potential dependency issues, i.e. base types have to be registered before derived types
				var register_call = new CCodeFunctionCall (new CCodeIdentifier ("%s_register_type".printf (cl.get_lower_case_cname (null))));
				register_call.add_argument (new CCodeIdentifier (module_init_param_name));
				module_init_fragment.append (new CCodeExpressionStatement (register_call));
			}
		} else if (!cl.is_static) {
			var function = new CCodeFunction (cl.get_lower_case_cprefix () + "free", "void");
			if (cl.access == SymbolAccessibility.PRIVATE) {
				function.modifiers = CCodeModifiers.STATIC;
			}

			function.add_parameter (new CCodeFormalParameter ("self", cl.get_cname () + "*"));

			if (cl.access != SymbolAccessibility.PRIVATE) {
				header_type_member_declaration.append (function.copy ());
			} else {
				source_type_member_declaration.append (function.copy ());
			}

			var cblock = new CCodeBlock ();

			cblock.add_statement (instance_dispose_fragment);

			var ccall = new CCodeFunctionCall (new CCodeIdentifier ("g_slice_free"));
			ccall.add_argument (new CCodeIdentifier (cl.get_cname ()));
			ccall.add_argument (new CCodeIdentifier ("self"));
			cblock.add_statement (new CCodeExpressionStatement (ccall));

			function.block = cblock;

			source_type_member_definition.append (function);
		}

		current_type_symbol = old_type_symbol;
		current_class = old_class;
		instance_struct = old_instance_struct;
		type_struct = old_type_struct;
		instance_priv_struct = old_instance_priv_struct;
		prop_enum = old_prop_enum;
		class_init_fragment = old_class_init_fragment;
		instance_init_fragment = old_instance_init_fragment;
		instance_dispose_fragment = old_instance_dispose_fragment;
	}
	
	private void add_class_init_function (Class! cl) {
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
		source_type_member_declaration.append (parent_decl);
		ccall = new CCodeFunctionCall (new CCodeIdentifier ("g_type_class_peek_parent"));
		ccall.add_argument (new CCodeIdentifier ("klass"));
		var parent_assignment = new CCodeAssignment (new CCodeIdentifier ("%s_parent_class".printf (cl.get_lower_case_cname (null))), ccall);
		init_block.add_statement (new CCodeExpressionStatement (parent_assignment));
		
		/* add struct for private fields */
		if (cl.has_private_fields || cl.get_type_parameters ().size > 0) {
			ccall = new CCodeFunctionCall (new CCodeIdentifier ("g_type_class_add_private"));
			ccall.add_argument (new CCodeIdentifier ("klass"));
			ccall.add_argument (new CCodeConstant ("sizeof (%sPrivate)".printf (cl.get_cname ())));
			init_block.add_statement (new CCodeExpressionStatement (ccall));
		}
		
		/* set property handlers */
		ccall = new CCodeFunctionCall (new CCodeIdentifier ("G_OBJECT_CLASS"));
		ccall.add_argument (new CCodeIdentifier ("klass"));
		if (class_has_readable_properties (cl) || cl.get_type_parameters ().size > 0) {
			init_block.add_statement (new CCodeExpressionStatement (new CCodeAssignment (new CCodeMemberAccess.pointer (ccall, "get_property"), new CCodeIdentifier ("%s_get_property".printf (cl.get_lower_case_cname (null))))));
		}
		if (class_has_writable_properties (cl) || cl.get_type_parameters ().size > 0) {
			init_block.add_statement (new CCodeExpressionStatement (new CCodeAssignment (new CCodeMemberAccess.pointer (ccall, "set_property"), new CCodeIdentifier ("%s_set_property".printf (cl.get_lower_case_cname (null))))));
		}
		
		/* set constructor */
		if (cl.constructor != null) {
			var ccast = new CCodeFunctionCall (new CCodeIdentifier ("G_OBJECT_CLASS"));
			ccast.add_argument (new CCodeIdentifier ("klass"));
			init_block.add_statement (new CCodeExpressionStatement (new CCodeAssignment (new CCodeMemberAccess.pointer (ccast, "constructor"), new CCodeIdentifier ("%s_constructor".printf (cl.get_lower_case_cname (null))))));
		}

		/* set dispose function */
		if (memory_management && cl.get_fields ().size > 0) {
			var ccast = new CCodeFunctionCall (new CCodeIdentifier ("G_OBJECT_CLASS"));
			ccast.add_argument (new CCodeIdentifier ("klass"));
			init_block.add_statement (new CCodeExpressionStatement (new CCodeAssignment (new CCodeMemberAccess.pointer (ccast, "dispose"), new CCodeIdentifier ("%s_dispose".printf (cl.get_lower_case_cname (null))))));
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

		/* create dup_func and destroy_func properties for generic types */
		foreach (TypeParameter type_param in cl.get_type_parameters ()) {
			string func_name, enum_value;
			CCodeConstant func_name_constant;
			CCodeFunctionCall cinst, cspec;

			func_name = "%s_dup_func".printf (type_param.name.down ());
			func_name_constant = new CCodeConstant ("\"%s-dup-func\"".printf (type_param.name.down ()));
			enum_value = "%s_%s".printf (cl.get_lower_case_cname (null), func_name).up ();
			cinst = new CCodeFunctionCall (new CCodeIdentifier ("g_object_class_install_property"));
			cinst.add_argument (ccall);
			cinst.add_argument (new CCodeConstant (enum_value));
			cspec = new CCodeFunctionCall (new CCodeIdentifier ("g_param_spec_pointer"));
			cspec.add_argument (func_name_constant);
			cspec.add_argument (new CCodeConstant ("\"dup func\""));
			cspec.add_argument (new CCodeConstant ("\"dup func\""));
			cspec.add_argument (new CCodeConstant ("G_PARAM_STATIC_NAME | G_PARAM_STATIC_NICK | G_PARAM_STATIC_BLURB | G_PARAM_WRITABLE"));
			cinst.add_argument (cspec);
			init_block.add_statement (new CCodeExpressionStatement (cinst));
			prop_enum.add_value (enum_value, null);

			instance_priv_struct.add_field ("GBoxedCopyFunc", func_name);


			func_name = "%s_destroy_func".printf (type_param.name.down ());
			func_name_constant = new CCodeConstant ("\"%s-destroy-func\"".printf (type_param.name.down ()));
			enum_value = "%s_%s".printf (cl.get_lower_case_cname (null), func_name).up ();
			cinst = new CCodeFunctionCall (new CCodeIdentifier ("g_object_class_install_property"));
			cinst.add_argument (ccall);
			cinst.add_argument (new CCodeConstant (enum_value));
			cspec = new CCodeFunctionCall (new CCodeIdentifier ("g_param_spec_pointer"));
			cspec.add_argument (func_name_constant);
			cspec.add_argument (new CCodeConstant ("\"destroy func\""));
			cspec.add_argument (new CCodeConstant ("\"destroy func\""));
			cspec.add_argument (new CCodeConstant ("G_PARAM_STATIC_NAME | G_PARAM_STATIC_NICK | G_PARAM_STATIC_BLURB | G_PARAM_WRITABLE"));
			cinst.add_argument (cspec);
			init_block.add_statement (new CCodeExpressionStatement (cinst));
			prop_enum.add_value (enum_value, null);

			instance_priv_struct.add_field ("GDestroyNotify", func_name);
		}

		/* create properties */
		var props = cl.get_properties ();
		foreach (Property prop in props) {
			if (prop.overrides || prop.base_interface_property != null) {
				var cinst = new CCodeFunctionCall (new CCodeIdentifier ("g_object_class_override_property"));
				cinst.add_argument (ccall);
				cinst.add_argument (new CCodeConstant (prop.get_upper_case_cname ()));
				cinst.add_argument (prop.get_canonical_cconstant ());
				
				init_block.add_statement (new CCodeExpressionStatement (cinst));
			} else {
				var cinst = new CCodeFunctionCall (new CCodeIdentifier ("g_object_class_install_property"));
				cinst.add_argument (ccall);
				cinst.add_argument (new CCodeConstant (prop.get_upper_case_cname ()));
				cinst.add_argument (get_param_spec (prop));
				
				init_block.add_statement (new CCodeExpressionStatement (cinst));
			}
		}
		
		/* create signals */
		foreach (Signal sig in cl.get_signals ()) {
			init_block.add_statement (new CCodeExpressionStatement (get_signal_creation (sig, cl)));
		}

		init_block.add_statement (class_init_fragment);
		
		source_type_member_definition.append (class_init);
	}
	
	private void add_interface_init_function (Class! cl, Interface! iface) {
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
		source_type_member_declaration.append (parent_decl);
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
			init_block.add_statement (new CCodeExpressionStatement (new CCodeAssignment (new CCodeMemberAccess.pointer (ciface, m.base_interface_method.vfunc_name), new CCodeIdentifier (m.get_real_cname ()))));
		}
		
		source_type_member_definition.append (iface_init);
	}
	
	private void add_instance_init_function (Class! cl) {
		var instance_init = new CCodeFunction ("%s_init".printf (cl.get_lower_case_cname (null)), "void");
		instance_init.add_parameter (new CCodeFormalParameter ("self", "%s *".printf (cl.get_cname ())));
		instance_init.modifiers = CCodeModifiers.STATIC;
		
		var init_block = new CCodeBlock ();
		instance_init.block = init_block;
		
		if (cl.has_private_fields || cl.get_type_parameters ().size > 0) {
			var ccall = new CCodeFunctionCall (new CCodeIdentifier ("%s_GET_PRIVATE".printf (cl.get_upper_case_cname (null))));
			ccall.add_argument (new CCodeIdentifier ("self"));
			init_block.add_statement (new CCodeExpressionStatement (new CCodeAssignment (new CCodeMemberAccess.pointer (new CCodeIdentifier ("self"), "priv"), ccall)));
		}
		
		init_block.add_statement (instance_init_fragment);
		
		var init_sym = cl.scope.lookup ("init");
		if (init_sym != null) {
			var init_fun = (Method) init_sym;
			init_block.add_statement (init_fun.body.ccodenode);
		}
		
		source_type_member_definition.append (instance_init);
	}
	
	private void add_dispose_function (Class! cl) {
		function = new CCodeFunction ("%s_dispose".printf (cl.get_lower_case_cname (null)), "void");
		function.modifiers = CCodeModifiers.STATIC;
		
		function.add_parameter (new CCodeFormalParameter ("obj", "GObject *"));
		
		source_type_member_declaration.append (function.copy ());


		var cblock = new CCodeBlock ();

		CCodeFunctionCall ccall = new InstanceCast (new CCodeIdentifier ("obj"), cl);

		var cdecl = new CCodeDeclaration ("%s *".printf (cl.get_cname ()));
		cdecl.add_declarator (new CCodeVariableDeclarator.with_initializer ("self", ccall));
		
		cblock.add_statement (cdecl);

		if (cl.destructor != null) {
			cblock.add_statement ((CCodeBlock) cl.destructor.body.ccodenode);
		}

		cblock.add_statement (instance_dispose_fragment);

		// chain up to dispose function of the base class
		var ccast = new CCodeFunctionCall (new CCodeIdentifier ("G_OBJECT_CLASS"));
		ccast.add_argument (new CCodeIdentifier ("%s_parent_class".printf (cl.get_lower_case_cname (null))));
		ccall = new CCodeFunctionCall (new CCodeMemberAccess.pointer (ccast, "dispose"));
		ccall.add_argument (new CCodeIdentifier ("obj"));
		cblock.add_statement (new CCodeExpressionStatement (ccall));


		function.block = cblock;

		source_type_member_definition.append (function);
	}
	
	private CCodeIdentifier! get_value_setter_function (TypeReference! type_reference) {
		if (type_reference.data_type != null) {
			return new CCodeIdentifier (type_reference.data_type.get_set_value_function ());
		} else {
			return new CCodeIdentifier ("g_value_set_pointer");
		}
	}

	private bool class_has_readable_properties (Class! cl) {
		foreach (Property prop in cl.get_properties ()) {
			if (prop.get_accessor != null && !prop.is_abstract) {
				return true;
			}
		}
		return false;
	}

	private bool class_has_writable_properties (Class! cl) {
		foreach (Property prop in cl.get_properties ()) {
			if (prop.set_accessor != null && !prop.is_abstract) {
				return true;
			}
		}
		return false;
	}

	private void add_get_property_function (Class! cl) {
		var get_prop = new CCodeFunction ("%s_get_property".printf (cl.get_lower_case_cname (null)), "void");
		get_prop.modifiers = CCodeModifiers.STATIC;
		get_prop.add_parameter (new CCodeFormalParameter ("object", "GObject *"));
		get_prop.add_parameter (new CCodeFormalParameter ("property_id", "guint"));
		get_prop.add_parameter (new CCodeFormalParameter ("value", "GValue *"));
		get_prop.add_parameter (new CCodeFormalParameter ("pspec", "GParamSpec *"));
		
		var block = new CCodeBlock ();
		
		var ccall = new InstanceCast (new CCodeIdentifier ("object"), cl);
		var cdecl = new CCodeDeclaration ("%s *".printf (cl.get_cname ()));
		cdecl.add_declarator (new CCodeVariableDeclarator.with_initializer ("self", ccall));
		block.add_statement (cdecl);
		
		var cswitch = new CCodeSwitchStatement (new CCodeIdentifier ("property_id"));
		var props = cl.get_properties ();
		foreach (Property prop in props) {
			if (prop.get_accessor == null || prop.is_abstract) {
				continue;
			}

			bool is_virtual = prop.base_property != null || prop.base_interface_property != null;

			string prefix = cl.get_lower_case_cname (null);
			if (is_virtual) {
				prefix += "_real";
			}

			var ccase = new CCodeCaseStatement (new CCodeIdentifier (prop.get_upper_case_cname ()));
			var ccall = new CCodeFunctionCall (new CCodeIdentifier ("%s_get_%s".printf (prefix, prop.name)));
			ccall.add_argument (new CCodeIdentifier ("self"));
			var csetcall = new CCodeFunctionCall ();
			csetcall.call = get_value_setter_function (prop.type_reference);
			csetcall.add_argument (new CCodeIdentifier ("value"));
			csetcall.add_argument (ccall);
			ccase.add_statement (new CCodeExpressionStatement (csetcall));
			ccase.add_statement (new CCodeBreakStatement ());
			cswitch.add_case (ccase);
		}
		cswitch.add_default_statement (get_invalid_property_id_warn_statement ());
		cswitch.add_default_statement (new CCodeBreakStatement ());

		block.add_statement (cswitch);

		get_prop.block = block;
		
		source_type_member_definition.append (get_prop);
	}
	
	private void add_set_property_function (Class! cl) {
		var set_prop = new CCodeFunction ("%s_set_property".printf (cl.get_lower_case_cname (null)), "void");
		set_prop.modifiers = CCodeModifiers.STATIC;
		set_prop.add_parameter (new CCodeFormalParameter ("object", "GObject *"));
		set_prop.add_parameter (new CCodeFormalParameter ("property_id", "guint"));
		set_prop.add_parameter (new CCodeFormalParameter ("value", "const GValue *"));
		set_prop.add_parameter (new CCodeFormalParameter ("pspec", "GParamSpec *"));
		
		var block = new CCodeBlock ();
		
		var ccall = new InstanceCast (new CCodeIdentifier ("object"), cl);
		var cdecl = new CCodeDeclaration ("%s *".printf (cl.get_cname ()));
		cdecl.add_declarator (new CCodeVariableDeclarator.with_initializer ("self", ccall));
		block.add_statement (cdecl);
		
		var cswitch = new CCodeSwitchStatement (new CCodeIdentifier ("property_id"));
		var props = cl.get_properties ();
		foreach (Property prop in props) {
			if (prop.set_accessor == null || prop.is_abstract) {
				continue;
			}

			bool is_virtual = prop.base_property != null || prop.base_interface_property != null;

			string prefix = cl.get_lower_case_cname (null);
			if (is_virtual) {
				prefix += "_real";
			}

			var ccase = new CCodeCaseStatement (new CCodeIdentifier (prop.get_upper_case_cname ()));
			var ccall = new CCodeFunctionCall (new CCodeIdentifier ("%s_set_%s".printf (prefix, prop.name)));
			ccall.add_argument (new CCodeIdentifier ("self"));
			var cgetcall = new CCodeFunctionCall ();
			if (prop.type_reference.data_type != null) {
				cgetcall.call = new CCodeIdentifier (prop.type_reference.data_type.get_get_value_function ());
			} else {
				cgetcall.call = new CCodeIdentifier ("g_value_get_pointer");
			}
			cgetcall.add_argument (new CCodeIdentifier ("value"));
			ccall.add_argument (cgetcall);
			ccase.add_statement (new CCodeExpressionStatement (ccall));
			ccase.add_statement (new CCodeBreakStatement ());
			cswitch.add_case (ccase);
		}
		cswitch.add_default_statement (get_invalid_property_id_warn_statement ());
		cswitch.add_default_statement (new CCodeBreakStatement ());

		block.add_statement (cswitch);

		/* destroy func properties for generic types */
		foreach (TypeParameter type_param in cl.get_type_parameters ()) {
			string func_name = "%s_destroy_func".printf (type_param.name.down ());
			string enum_value = "%s_%s".printf (cl.get_lower_case_cname (null), func_name).up ();

			var ccase = new CCodeCaseStatement (new CCodeIdentifier (enum_value));
			var cfield = new CCodeMemberAccess.pointer (new CCodeMemberAccess.pointer (new CCodeIdentifier ("self"), "priv"), func_name);
			var cgetcall = new CCodeFunctionCall (new CCodeIdentifier ("g_value_get_pointer"));
			cgetcall.add_argument (new CCodeIdentifier ("value"));
			ccase.add_statement (new CCodeExpressionStatement (new CCodeAssignment (cfield, cgetcall)));
			ccase.add_statement (new CCodeBreakStatement ());
			cswitch.add_case (ccase);
		}

		set_prop.block = block;
		
		source_type_member_definition.append (set_prop);
	}

	private CCodeStatement get_invalid_property_id_warn_statement () {
		// warn on invalid property id
		var cwarn = new CCodeFunctionCall (new CCodeIdentifier ("G_OBJECT_WARN_INVALID_PROPERTY_ID"));
		cwarn.add_argument (new CCodeIdentifier ("object"));
		cwarn.add_argument (new CCodeIdentifier ("property_id"));
		cwarn.add_argument (new CCodeIdentifier ("pspec"));
		return new CCodeExpressionStatement (cwarn);
	}
}
