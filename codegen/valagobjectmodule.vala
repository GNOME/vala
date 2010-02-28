/* valagobjectmodule.vala
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


internal class Vala.GObjectModule : GTypeModule {
	int dynamic_property_id;
	int signal_wrapper_id;

	public GObjectModule (CCodeGenerator codegen, CCodeModule? next) {
		base (codegen, next);
	}

	public override void visit_class (Class cl) {
		base.visit_class (cl);

		if (!cl.is_subtype_of (gobject_type)) {
			return;
		}

		if (class_has_readable_properties (cl) || cl.get_type_parameters ().size > 0) {
			add_get_property_function (cl);
		}
		if (class_has_writable_properties (cl) || cl.get_type_parameters ().size > 0) {
			add_set_property_function (cl);
		}
	}

	public override void generate_class_init (Class cl, CCodeBlock init_block) {
		if (!cl.is_subtype_of (gobject_type)) {
			return;
		}

		/* set property handlers */
		var ccall = new CCodeFunctionCall (new CCodeIdentifier ("G_OBJECT_CLASS"));
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

		/* set finalize function */
		if (cl.get_fields ().size > 0 || cl.destructor != null) {
			var ccast = new CCodeFunctionCall (new CCodeIdentifier ("G_OBJECT_CLASS"));
			ccast.add_argument (new CCodeIdentifier ("klass"));
			init_block.add_statement (new CCodeExpressionStatement (new CCodeAssignment (new CCodeMemberAccess.pointer (ccast, "finalize"), new CCodeIdentifier ("%s_finalize".printf (cl.get_lower_case_cname (null))))));
		}

		/* create type, dup_func, and destroy_func properties for generic types */
		foreach (TypeParameter type_param in cl.get_type_parameters ()) {
			string func_name, enum_value;
			CCodeConstant func_name_constant;
			CCodeFunctionCall cinst, cspec;

			func_name = "%s_type".printf (type_param.name.down ());
			func_name_constant = new CCodeConstant ("\"%s-type\"".printf (type_param.name.down ()));
			enum_value = "%s_%s".printf (cl.get_lower_case_cname (null), func_name).up ();
			cinst = new CCodeFunctionCall (new CCodeIdentifier ("g_object_class_install_property"));
			cinst.add_argument (ccall);
			cinst.add_argument (new CCodeConstant (enum_value));
			cspec = new CCodeFunctionCall (new CCodeIdentifier ("g_param_spec_gtype"));
			cspec.add_argument (func_name_constant);
			cspec.add_argument (new CCodeConstant ("\"type\""));
			cspec.add_argument (new CCodeConstant ("\"type\""));
			cspec.add_argument (new CCodeIdentifier ("G_TYPE_NONE"));
			cspec.add_argument (new CCodeConstant ("G_PARAM_STATIC_NAME | G_PARAM_STATIC_NICK | G_PARAM_STATIC_BLURB | G_PARAM_WRITABLE | G_PARAM_CONSTRUCT_ONLY"));
			cinst.add_argument (cspec);
			init_block.add_statement (new CCodeExpressionStatement (cinst));
			prop_enum.add_value (new CCodeEnumValue (enum_value));


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
			cspec.add_argument (new CCodeConstant ("G_PARAM_STATIC_NAME | G_PARAM_STATIC_NICK | G_PARAM_STATIC_BLURB | G_PARAM_WRITABLE | G_PARAM_CONSTRUCT_ONLY"));
			cinst.add_argument (cspec);
			init_block.add_statement (new CCodeExpressionStatement (cinst));
			prop_enum.add_value (new CCodeEnumValue (enum_value));


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
			cspec.add_argument (new CCodeConstant ("G_PARAM_STATIC_NAME | G_PARAM_STATIC_NICK | G_PARAM_STATIC_BLURB | G_PARAM_WRITABLE | G_PARAM_CONSTRUCT_ONLY"));
			cinst.add_argument (cspec);
			init_block.add_statement (new CCodeExpressionStatement (cinst));
			prop_enum.add_value (new CCodeEnumValue (enum_value));
		}

		/* create properties */
		var props = cl.get_properties ();
		foreach (Property prop in props) {
			if (!is_gobject_property (prop)) {
				continue;
			}

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
				cinst.add_argument (head.get_param_spec (prop));
			
				init_block.add_statement (new CCodeExpressionStatement (cinst));
			}
		}
	}

	private bool class_has_readable_properties (Class cl) {
		foreach (Property prop in cl.get_properties ()) {
			if (prop.get_accessor != null) {
				return true;
			}
		}
		return false;
	}

	private bool class_has_writable_properties (Class cl) {
		foreach (Property prop in cl.get_properties ()) {
			if (prop.set_accessor != null) {
				return true;
			}
		}
		return false;
	}

	private void add_get_property_function (Class cl) {
		var get_prop = new CCodeFunction ("%s_get_property".printf (cl.get_lower_case_cname (null)), "void");
		get_prop.modifiers = CCodeModifiers.STATIC;
		get_prop.add_parameter (new CCodeFormalParameter ("object", "GObject *"));
		get_prop.add_parameter (new CCodeFormalParameter ("property_id", "guint"));
		get_prop.add_parameter (new CCodeFormalParameter ("value", "GValue *"));
		get_prop.add_parameter (new CCodeFormalParameter ("pspec", "GParamSpec *"));
		
		var block = new CCodeBlock ();
		
		CCodeFunctionCall ccall = generate_instance_cast (new CCodeIdentifier ("object"), cl);
		var cdecl = new CCodeDeclaration ("%s *".printf (cl.get_cname ()));
		cdecl.add_declarator (new CCodeVariableDeclarator ("self", ccall));
		block.add_statement (cdecl);

		bool boxed_declared = false;

		var cswitch = new CCodeSwitchStatement (new CCodeIdentifier ("property_id"));
		var props = cl.get_properties ();
		foreach (Property prop in props) {
			if (prop.get_accessor == null || prop.is_abstract) {
				continue;
			}
			if (!is_gobject_property (prop)) {
				// don't register private properties
				continue;
			}

			string prefix = cl.get_lower_case_cname (null);
			CCodeExpression cself = new CCodeIdentifier ("self");
			if (prop.base_property != null) {
				var base_type = (Class) prop.base_property.parent_symbol;
				prefix = base_type.get_lower_case_cname (null);
				cself = transform_expression (cself, new ObjectType (cl), new ObjectType (base_type));

				generate_property_accessor_declaration (prop.base_property.get_accessor, source_declarations);
			} else if (prop.base_interface_property != null) {
				var base_type = (Interface) prop.base_interface_property.parent_symbol;
				prefix = base_type.get_lower_case_cname (null);
				cself = transform_expression (cself, new ObjectType (cl), new ObjectType (base_type));

				generate_property_accessor_declaration (prop.base_interface_property.get_accessor, source_declarations);
			}

			cswitch.add_statement (new CCodeCaseStatement (new CCodeIdentifier (prop.get_upper_case_cname ())));
			if (prop.property_type.is_real_struct_type ()) {
				if (!boxed_declared) {
					cdecl = new CCodeDeclaration ("gpointer");
					cdecl.add_declarator (new CCodeVariableDeclarator ("boxed"));
					block.add_statement (cdecl);
					boxed_declared = true;
				}

				var st = prop.property_type.data_type as Struct;
				var struct_creation = new CCodeFunctionCall (new CCodeIdentifier ("g_new0"));
				struct_creation.add_argument (new CCodeIdentifier (st.get_cname ()));
				struct_creation.add_argument (new CCodeConstant ("1"));
				cswitch.add_statement (new CCodeExpressionStatement (new CCodeAssignment (new CCodeIdentifier ("boxed"), struct_creation)));
				ccall = new CCodeFunctionCall (new CCodeIdentifier ("%s_get_%s".printf (prefix, prop.name)));
				ccall.add_argument (cself);
				ccall.add_argument (new CCodeIdentifier ("boxed"));
				cswitch.add_statement (new CCodeExpressionStatement (ccall));
				var csetcall = new CCodeFunctionCall (new CCodeIdentifier ("g_value_take_boxed"));
				csetcall.add_argument (new CCodeIdentifier ("value"));
				csetcall.add_argument (new CCodeIdentifier ("boxed"));
				cswitch.add_statement (new CCodeExpressionStatement (csetcall));
			} else {
				ccall = new CCodeFunctionCall (new CCodeIdentifier ("%s_get_%s".printf (prefix, prop.name)));
				ccall.add_argument (cself);
				var csetcall = new CCodeFunctionCall ();
				csetcall.call = head.get_value_setter_function (prop.property_type);
				csetcall.add_argument (new CCodeIdentifier ("value"));
				csetcall.add_argument (ccall);
				cswitch.add_statement (new CCodeExpressionStatement (csetcall));
			}
			cswitch.add_statement (new CCodeBreakStatement ());
		}
		cswitch.add_statement (new CCodeLabel ("default"));
		cswitch.add_statement (get_invalid_property_id_warn_statement ());
		cswitch.add_statement (new CCodeBreakStatement ());

		block.add_statement (cswitch);

		source_declarations.add_type_member_declaration (get_prop.copy ());

		get_prop.block = block;
		
		source_type_member_definition.append (get_prop);
	}
	
	private void add_set_property_function (Class cl) {
		var set_prop = new CCodeFunction ("%s_set_property".printf (cl.get_lower_case_cname (null)), "void");
		set_prop.modifiers = CCodeModifiers.STATIC;
		set_prop.add_parameter (new CCodeFormalParameter ("object", "GObject *"));
		set_prop.add_parameter (new CCodeFormalParameter ("property_id", "guint"));
		set_prop.add_parameter (new CCodeFormalParameter ("value", "const GValue *"));
		set_prop.add_parameter (new CCodeFormalParameter ("pspec", "GParamSpec *"));
		
		var block = new CCodeBlock ();
		
		CCodeFunctionCall ccall = generate_instance_cast (new CCodeIdentifier ("object"), cl);
		var cdecl = new CCodeDeclaration ("%s *".printf (cl.get_cname ()));
		cdecl.add_declarator (new CCodeVariableDeclarator ("self", ccall));
		block.add_statement (cdecl);
		
		var cswitch = new CCodeSwitchStatement (new CCodeIdentifier ("property_id"));
		var props = cl.get_properties ();
		foreach (Property prop in props) {
			if (prop.set_accessor == null || prop.is_abstract) {
				continue;
			}
			if (!is_gobject_property (prop)) {
				continue;
			}

			string prefix = cl.get_lower_case_cname (null);
			CCodeExpression cself = new CCodeIdentifier ("self");
			if (prop.base_property != null) {
				var base_type = (Class) prop.base_property.parent_symbol;
				prefix = base_type.get_lower_case_cname (null);
				cself = transform_expression (cself, new ObjectType (cl), new ObjectType (base_type));

				generate_property_accessor_declaration (prop.base_property.set_accessor, source_declarations);
			} else if (prop.base_interface_property != null) {
				var base_type = (Interface) prop.base_interface_property.parent_symbol;
				prefix = base_type.get_lower_case_cname (null);
				cself = transform_expression (cself, new ObjectType (cl), new ObjectType (base_type));

				generate_property_accessor_declaration (prop.base_interface_property.set_accessor, source_declarations);
			}

			cswitch.add_statement (new CCodeCaseStatement (new CCodeIdentifier (prop.get_upper_case_cname ())));
			ccall = new CCodeFunctionCall (new CCodeIdentifier ("%s_set_%s".printf (prefix, prop.name)));
			ccall.add_argument (cself);
			var cgetcall = new CCodeFunctionCall ();
			if (prop.property_type.data_type != null) {
				cgetcall.call = new CCodeIdentifier (prop.property_type.data_type.get_get_value_function ());
			} else {
				cgetcall.call = new CCodeIdentifier ("g_value_get_pointer");
			}
			cgetcall.add_argument (new CCodeIdentifier ("value"));
			ccall.add_argument (cgetcall);
			cswitch.add_statement (new CCodeExpressionStatement (ccall));
			cswitch.add_statement (new CCodeBreakStatement ());
		}
		cswitch.add_statement (new CCodeLabel ("default"));
		cswitch.add_statement (get_invalid_property_id_warn_statement ());
		cswitch.add_statement (new CCodeBreakStatement ());

		block.add_statement (cswitch);

		/* type, dup func, and destroy func properties for generic types */
		foreach (TypeParameter type_param in cl.get_type_parameters ()) {
			string func_name, enum_value;
			CCodeMemberAccess cfield;
			CCodeFunctionCall cgetcall;

			func_name = "%s_type".printf (type_param.name.down ());
			enum_value = "%s_%s".printf (cl.get_lower_case_cname (null), func_name).up ();
			cswitch.add_statement (new CCodeCaseStatement (new CCodeIdentifier (enum_value)));
			cfield = new CCodeMemberAccess.pointer (new CCodeMemberAccess.pointer (new CCodeIdentifier ("self"), "priv"), func_name);
			cgetcall = new CCodeFunctionCall (new CCodeIdentifier ("g_value_get_gtype"));
			cgetcall.add_argument (new CCodeIdentifier ("value"));
			cswitch.add_statement (new CCodeExpressionStatement (new CCodeAssignment (cfield, cgetcall)));
			cswitch.add_statement (new CCodeBreakStatement ());

			func_name = "%s_dup_func".printf (type_param.name.down ());
			enum_value = "%s_%s".printf (cl.get_lower_case_cname (null), func_name).up ();
			cswitch.add_statement (new CCodeCaseStatement (new CCodeIdentifier (enum_value)));
			cfield = new CCodeMemberAccess.pointer (new CCodeMemberAccess.pointer (new CCodeIdentifier ("self"), "priv"), func_name);
			cgetcall = new CCodeFunctionCall (new CCodeIdentifier ("g_value_get_pointer"));
			cgetcall.add_argument (new CCodeIdentifier ("value"));
			cswitch.add_statement (new CCodeExpressionStatement (new CCodeAssignment (cfield, cgetcall)));
			cswitch.add_statement (new CCodeBreakStatement ());

			func_name = "%s_destroy_func".printf (type_param.name.down ());
			enum_value = "%s_%s".printf (cl.get_lower_case_cname (null), func_name).up ();
			cswitch.add_statement (new CCodeCaseStatement (new CCodeIdentifier (enum_value)));
			cfield = new CCodeMemberAccess.pointer (new CCodeMemberAccess.pointer (new CCodeIdentifier ("self"), "priv"), func_name);
			cgetcall = new CCodeFunctionCall (new CCodeIdentifier ("g_value_get_pointer"));
			cgetcall.add_argument (new CCodeIdentifier ("value"));
			cswitch.add_statement (new CCodeExpressionStatement (new CCodeAssignment (cfield, cgetcall)));
			cswitch.add_statement (new CCodeBreakStatement ());
		}

		source_declarations.add_type_member_declaration (set_prop.copy ());

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

	public override CCodeExpression get_construct_property_assignment (CCodeConstant canonical_cconstant, DataType property_type, CCodeExpression value) {
		// this property is used as a construction parameter
		var cpointer = new CCodeIdentifier ("__params_it");
		
		var ccomma = new CCodeCommaExpression ();
		// set name in array for current parameter
		var cnamemember = new CCodeMemberAccess.pointer (cpointer, "name");
		var cnameassign = new CCodeAssignment (cnamemember, canonical_cconstant);
		ccomma.append_expression (cnameassign);
		
		var gvaluearg = new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, new CCodeMemberAccess.pointer (cpointer, "value"));
		
		// initialize GValue in array for current parameter
		var cvalueinit = new CCodeFunctionCall (new CCodeIdentifier ("g_value_init"));
		cvalueinit.add_argument (gvaluearg);
		cvalueinit.add_argument (new CCodeIdentifier (property_type.get_type_id ()));
		ccomma.append_expression (cvalueinit);
		
		// set GValue for current parameter
		var cvalueset = new CCodeFunctionCall (get_value_setter_function (property_type));
		cvalueset.add_argument (gvaluearg);
		if (property_type.is_real_struct_type ()) {
			cvalueset.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, value));
		} else {
			cvalueset.add_argument (value);
		}
		ccomma.append_expression (cvalueset);
		
		// move pointer to next parameter in array
		ccomma.append_expression (new CCodeUnaryExpression (CCodeUnaryOperator.POSTFIX_INCREMENT, cpointer));

		return ccomma;
	}

	public override void visit_constructor (Constructor c) {
		bool old_method_inner_error = current_method_inner_error;
		current_method_inner_error = false;

		if (c.binding == MemberBinding.CLASS || c.binding == MemberBinding.STATIC) {
			in_static_or_class_context = true;
		} else {
			in_constructor = true;
		}
		c.accept_children (codegen);
		in_static_or_class_context = false;

		in_constructor = false;

		var cl = (Class) c.parent_symbol;

		if (c.binding == MemberBinding.INSTANCE) {
			if (!cl.is_subtype_of (gobject_type)) {
				Report.error (c.source_reference, "construct blocks require GLib.Object");
				c.error = true;
				return;
			}

			function = new CCodeFunction ("%s_constructor".printf (cl.get_lower_case_cname (null)), "GObject *");
			function.modifiers = CCodeModifiers.STATIC;
		
			function.add_parameter (new CCodeFormalParameter ("type", "GType"));
			function.add_parameter (new CCodeFormalParameter ("n_construct_properties", "guint"));
			function.add_parameter (new CCodeFormalParameter ("construct_properties", "GObjectConstructParam *"));
		
			source_declarations.add_type_member_declaration (function.copy ());


			var cblock = new CCodeBlock ();
			var cdecl = new CCodeDeclaration ("GObject *");
			cdecl.add_declarator (new CCodeVariableDeclarator ("obj"));
			cblock.add_statement (cdecl);

			cdecl = new CCodeDeclaration ("GObjectClass *");
			cdecl.add_declarator (new CCodeVariableDeclarator ("parent_class"));
			cblock.add_statement (cdecl);


			var ccast = new CCodeFunctionCall (new CCodeIdentifier ("G_OBJECT_CLASS"));
			ccast.add_argument (new CCodeIdentifier ("%s_parent_class".printf (cl.get_lower_case_cname (null))));
			cblock.add_statement (new CCodeExpressionStatement (new CCodeAssignment (new CCodeIdentifier ("parent_class"), ccast)));

		
			var ccall = new CCodeFunctionCall (new CCodeMemberAccess.pointer (new CCodeIdentifier ("parent_class"), "constructor"));
			ccall.add_argument (new CCodeIdentifier ("type"));
			ccall.add_argument (new CCodeIdentifier ("n_construct_properties"));
			ccall.add_argument (new CCodeIdentifier ("construct_properties"));
			cblock.add_statement (new CCodeExpressionStatement (new CCodeAssignment (new CCodeIdentifier ("obj"), ccall)));


			ccall = generate_instance_cast (new CCodeIdentifier ("obj"), cl);

			cdecl = new CCodeDeclaration ("%s *".printf (cl.get_cname ()));
			cdecl.add_declarator (new CCodeVariableDeclarator ("self", ccall));
			cblock.add_statement (cdecl);

			if (current_method_inner_error) {
				/* always separate error parameter and inner_error local variable
				 * as error may be set to NULL but we're always interested in inner errors
				 */
				cdecl = new CCodeDeclaration ("GError *");
				cdecl.add_declarator (new CCodeVariableDeclarator ("_inner_error_", new CCodeConstant ("NULL")));
				cblock.add_statement (cdecl);
			}


			cblock.add_statement (c.body.ccodenode);
		
			cblock.add_statement (new CCodeReturnStatement (new CCodeIdentifier ("obj")));
		
			function.block = cblock;

			source_type_member_definition.append (function);
		} else if (c.binding == MemberBinding.CLASS) {
			// class constructor

			if (cl.is_compact) {
				Report.error (c.source_reference, "class constructors are not supported in compact classes");
				c.error = true;
				return;
			}

			if (current_method_inner_error) {
				/* always separate error parameter and inner_error local variable
				 * as error may be set to NULL but we're always interested in inner errors
				 */
				var cdecl = new CCodeDeclaration ("GError *");
				cdecl.add_declarator (new CCodeVariableDeclarator ("_inner_error_", new CCodeConstant ("NULL")));
				base_init_fragment.append (cdecl);
			}

			base_init_fragment.append (c.body.ccodenode);
		} else if (c.binding == MemberBinding.STATIC) {
			// static class constructor
			// add to class_init

			if (cl.is_compact) {
				Report.error (c.source_reference, "static constructors are not supported in compact classes");
				c.error = true;
				return;
			}

			if (current_method_inner_error) {
				/* always separate error parameter and inner_error local variable
				 * as error may be set to NULL but we're always interested in inner errors
				 */
				var cdecl = new CCodeDeclaration ("GError *");
				cdecl.add_declarator (new CCodeVariableDeclarator ("_inner_error_", new CCodeConstant ("NULL")));
				class_init_fragment.append (cdecl);
			}

			class_init_fragment.append (c.body.ccodenode);
		} else {
			Report.error (c.source_reference, "internal error: constructors must have instance, class, or static binding");
		}

		current_method_inner_error = old_method_inner_error;
	}

	public override string get_dynamic_property_getter_cname (DynamicProperty prop) {
		if (prop.dynamic_type.data_type == null
		    || !prop.dynamic_type.data_type.is_subtype_of (gobject_type)) {
			return base.get_dynamic_property_getter_cname (prop);
		}

		string getter_cname = "_dynamic_get_%s%d".printf (prop.name, dynamic_property_id++);

		var func = new CCodeFunction (getter_cname, prop.property_type.get_cname ());
		func.modifiers |= CCodeModifiers.STATIC | CCodeModifiers.INLINE;

		func.add_parameter (new CCodeFormalParameter ("obj", prop.dynamic_type.get_cname ()));

		var block = new CCodeBlock ();
		generate_gobject_property_getter_wrapper (prop, block);

		// append to C source file
		source_declarations.add_type_member_declaration (func.copy ());

		func.block = block;
		source_type_member_definition.append (func);

		return getter_cname;
	}

	public override string get_dynamic_property_setter_cname (DynamicProperty prop) {
		if (prop.dynamic_type.data_type == null
		    || !prop.dynamic_type.data_type.is_subtype_of (gobject_type)) {
			return base.get_dynamic_property_setter_cname (prop);
		}

		string setter_cname = "_dynamic_set_%s%d".printf (prop.name, dynamic_property_id++);

		var func = new CCodeFunction (setter_cname, "void");
		func.modifiers |= CCodeModifiers.STATIC | CCodeModifiers.INLINE;

		func.add_parameter (new CCodeFormalParameter ("obj", prop.dynamic_type.get_cname ()));
		func.add_parameter (new CCodeFormalParameter ("value", prop.property_type.get_cname ()));

		var block = new CCodeBlock ();
		generate_gobject_property_setter_wrapper (prop, block);

		// append to C source file
		source_declarations.add_type_member_declaration (func.copy ());

		func.block = block;
		source_type_member_definition.append (func);

		return setter_cname;
	}

	void generate_gobject_property_getter_wrapper (DynamicProperty node, CCodeBlock block) {
		var cdecl = new CCodeDeclaration (node.property_type.get_cname ());
		cdecl.add_declarator (new CCodeVariableDeclarator ("result"));
		block.add_statement (cdecl);

		var call = new CCodeFunctionCall (new CCodeIdentifier ("g_object_get"));
		call.add_argument (new CCodeIdentifier ("obj"));
		call.add_argument (node.get_canonical_cconstant ());
		call.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, new CCodeIdentifier ("result")));
		call.add_argument (new CCodeConstant ("NULL"));

		block.add_statement (new CCodeExpressionStatement (call));

		block.add_statement (new CCodeReturnStatement (new CCodeIdentifier ("result")));
	}

	void generate_gobject_property_setter_wrapper (DynamicProperty node, CCodeBlock block) {
		var call = new CCodeFunctionCall (new CCodeIdentifier ("g_object_set"));
		call.add_argument (new CCodeIdentifier ("obj"));
		call.add_argument (node.get_canonical_cconstant ());
		call.add_argument (new CCodeIdentifier ("value"));
		call.add_argument (new CCodeConstant ("NULL"));

		block.add_statement (new CCodeExpressionStatement (call));
	}

	public override string get_dynamic_signal_cname (DynamicSignal node) {
		return "dynamic_%s%d_".printf (node.name, signal_wrapper_id++);
	}

	public override string get_dynamic_signal_connect_wrapper_name (DynamicSignal sig) {
		if (sig.dynamic_type.data_type == null
		    || !sig.dynamic_type.data_type.is_subtype_of (gobject_type)) {
			return base.get_dynamic_signal_connect_wrapper_name (sig);
		}

		string connect_wrapper_name = "_%sconnect".printf (get_dynamic_signal_cname (sig));
		var func = new CCodeFunction (connect_wrapper_name, "void");
		func.add_parameter (new CCodeFormalParameter ("obj", "gpointer"));
		func.add_parameter (new CCodeFormalParameter ("signal_name", "const char *"));
		func.add_parameter (new CCodeFormalParameter ("handler", "GCallback"));
		func.add_parameter (new CCodeFormalParameter ("data", "gpointer"));
		var block = new CCodeBlock ();
		generate_gobject_connect_wrapper (sig, block);

		// append to C source file
		source_declarations.add_type_member_declaration (func.copy ());

		func.block = block;
		source_type_member_definition.append (func);

		return connect_wrapper_name;
	}

	void generate_gobject_connect_wrapper (DynamicSignal sig, CCodeBlock block) {
		var m = (Method) sig.handler.symbol_reference;

		sig.accept (codegen);

		string connect_func = "g_signal_connect_object";
		if (m.binding != MemberBinding.INSTANCE) {
			connect_func = "g_signal_connect";
		}

		var call = new CCodeFunctionCall (new CCodeIdentifier (connect_func));
		call.add_argument (new CCodeIdentifier ("obj"));
		call.add_argument (new CCodeIdentifier ("signal_name"));
		call.add_argument (new CCodeIdentifier ("handler"));
		call.add_argument (new CCodeIdentifier ("data"));

		if (m.binding == MemberBinding.INSTANCE) {
			call.add_argument (new CCodeConstant ("0"));
		}

		block.add_statement (new CCodeExpressionStatement (call));
	}

	public override void visit_property (Property prop) {
		base.visit_property (prop);

		if (is_gobject_property (prop)) {
			prop_enum.add_value (new CCodeEnumValue (prop.get_upper_case_cname ()));
		}
	}

	public override bool is_gobject_property (Property prop) {
		var cl = prop.parent_symbol as Class;
		if (cl == null || !cl.is_subtype_of (gobject_type)) {
			return false;
		}

		if (prop.binding != MemberBinding.INSTANCE) {
			return false;
		}

		if (prop.access == SymbolAccessibility.PRIVATE) {
			return false;
		}

		var st = prop.property_type.data_type as Struct;
		if (st != null && (!st.has_type_id || prop.property_type.nullable)) {
			return false;
		}

		if (prop.property_type is ArrayType) {
			return false;
		}

		var d = prop.property_type as DelegateType;
		if (d != null && d.delegate_symbol.has_target) {
			return false;
		}

		if (prop.base_interface_property != null) {
			var iface = (Interface) prop.base_interface_property.parent_symbol;
			if (!iface.is_subtype_of (gobject_type)) {
				// implementing non-GObject property
				return false;
			}
		}

		if (!prop.name[0].isalpha ()) {
			// GObject requires properties to start with a letter
			return false;
		}

		return true;
	}

	public override void visit_method_call (MethodCall expr) {
		if (expr.call is MemberAccess) {
			var ma = expr.call as MemberAccess;
			if (ma.inner != null && ma.inner.symbol_reference == gobject_type && ma.member_name == "new") {
				// Object.new (...) creation
				// runtime check to ref_sink the instance if it's a floating type
				base.visit_method_call (expr);

				var ccomma = new CCodeCommaExpression ();
				var temp_var = get_temp_variable (expr.value_type, false, expr, false);
				temp_vars.insert (0, temp_var);
				ccomma.append_expression (new CCodeAssignment (get_variable_cexpression (temp_var.name), (CCodeExpression) expr.ccodenode));

				var is_floating_ccall = new CCodeFunctionCall (new CCodeIdentifier ("g_object_is_floating"));
				is_floating_ccall.add_argument (get_variable_cexpression (temp_var.name));
				var sink_ref_ccall = new CCodeFunctionCall (new CCodeIdentifier ("g_object_ref_sink"));
				sink_ref_ccall.add_argument (get_variable_cexpression (temp_var.name));
				ccomma.append_expression (new CCodeConditionalExpression (is_floating_ccall, sink_ref_ccall, get_variable_cexpression (temp_var.name)));

				expr.ccodenode = ccomma;
				return;
			} else if (ma.symbol_reference == gobject_type) {
				// Object (...) chain up
				// check it's only used with valid properties
				foreach (var arg in expr.get_argument_list ()) {
					var named_argument = arg as NamedArgument;
					if (named_argument == null) {
						Report.error (arg.source_reference, "Named argument expected");
						break;
					}
					var prop = SemanticAnalyzer.symbol_lookup_inherited (current_class, named_argument.name) as Property;
					if (prop == null) {
						Report.error (arg.source_reference, "Property `%s' not found in `%s'".printf (named_argument.name, current_class.get_full_name ()));
						break;
					}
					if (!arg.value_type.compatible (prop.property_type)) {
						Report.error (arg.source_reference, "Cannot convert from `%s' to `%s'".printf (arg.value_type.to_string (), prop.property_type.to_string ()));
						break;
					}
				}
			}
		}

		base.visit_method_call (expr);
	}
}

