/* valagobjectmodule.vala
 *
 * Copyright (C) 2006-2011  Jürg Billeter
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


public class Vala.GObjectModule : GTypeModule {
	int dynamic_property_id;
	int signal_wrapper_id;

	public override void visit_class (Class cl) {
		base.visit_class (cl);

		if (!cl.is_subtype_of (gobject_type)) {
			return;
		}

		push_line (cl.source_reference);
		if (class_has_readable_properties (cl) || cl.get_type_parameters ().size > 0) {
			add_get_property_function (cl);
		}
		if (class_has_writable_properties (cl) || cl.get_type_parameters ().size > 0) {
			add_set_property_function (cl);
		}
		pop_line ();
	}

	public override void generate_class_init (Class cl) {
		if (!cl.is_subtype_of (gobject_type)) {
			return;
		}

		/* set property handlers */
		var ccall = new CCodeFunctionCall (new CCodeIdentifier ("G_OBJECT_CLASS"));
		ccall.add_argument (new CCodeIdentifier ("klass"));
		if (class_has_readable_properties (cl) || cl.get_type_parameters ().size > 0) {
			ccode.add_assignment (new CCodeMemberAccess.pointer (ccall, "get_property"), new CCodeIdentifier ("_vala_%s_get_property".printf (get_ccode_lower_case_name (cl, null))));
		}
		if (class_has_writable_properties (cl) || cl.get_type_parameters ().size > 0) {
			ccode.add_assignment (new CCodeMemberAccess.pointer (ccall, "set_property"), new CCodeIdentifier ("_vala_%s_set_property".printf (get_ccode_lower_case_name (cl, null))));
		}
	
		/* set constructor */
		if (cl.constructor != null) {
			var ccast = new CCodeFunctionCall (new CCodeIdentifier ("G_OBJECT_CLASS"));
			ccast.add_argument (new CCodeIdentifier ("klass"));
			ccode.add_assignment (new CCodeMemberAccess.pointer (ccast, "constructor"), new CCodeIdentifier ("%s_constructor".printf (get_ccode_lower_case_name (cl, null))));
		}

		/* set finalize function */
		if (cl.get_fields ().size > 0 || cl.destructor != null) {
			var ccast = new CCodeFunctionCall (new CCodeIdentifier ("G_OBJECT_CLASS"));
			ccast.add_argument (new CCodeIdentifier ("klass"));
			ccode.add_assignment (new CCodeMemberAccess.pointer (ccast, "finalize"), new CCodeIdentifier ("%s_finalize".printf (get_ccode_lower_case_name (cl, null))));
		}

		/* create type, dup_func, and destroy_func properties for generic types */
		foreach (TypeParameter type_param in cl.get_type_parameters ()) {
			string func_name, enum_value;
			CCodeConstant func_name_constant;
			CCodeFunctionCall cinst, cspec;

			func_name = "%s_type".printf (type_param.name.ascii_down ());
			func_name_constant = new CCodeConstant ("\"%s-type\"".printf (type_param.name.ascii_down ()));
			enum_value = "%s_%s".printf (get_ccode_lower_case_name (cl, null), func_name).ascii_up ();
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
			ccode.add_expression (cinst);
			prop_enum.add_value (new CCodeEnumValue (enum_value));


			func_name = "%s_dup_func".printf (type_param.name.ascii_down ());
			func_name_constant = new CCodeConstant ("\"%s-dup-func\"".printf (type_param.name.ascii_down ()));
			enum_value = "%s_%s".printf (get_ccode_lower_case_name (cl, null), func_name).ascii_up ();
			cinst = new CCodeFunctionCall (new CCodeIdentifier ("g_object_class_install_property"));
			cinst.add_argument (ccall);
			cinst.add_argument (new CCodeConstant (enum_value));
			cspec = new CCodeFunctionCall (new CCodeIdentifier ("g_param_spec_pointer"));
			cspec.add_argument (func_name_constant);
			cspec.add_argument (new CCodeConstant ("\"dup func\""));
			cspec.add_argument (new CCodeConstant ("\"dup func\""));
			cspec.add_argument (new CCodeConstant ("G_PARAM_STATIC_NAME | G_PARAM_STATIC_NICK | G_PARAM_STATIC_BLURB | G_PARAM_WRITABLE | G_PARAM_CONSTRUCT_ONLY"));
			cinst.add_argument (cspec);
			ccode.add_expression (cinst);
			prop_enum.add_value (new CCodeEnumValue (enum_value));


			func_name = "%s_destroy_func".printf (type_param.name.ascii_down ());
			func_name_constant = new CCodeConstant ("\"%s-destroy-func\"".printf (type_param.name.ascii_down ()));
			enum_value = "%s_%s".printf (get_ccode_lower_case_name (cl, null), func_name).ascii_up ();
			cinst = new CCodeFunctionCall (new CCodeIdentifier ("g_object_class_install_property"));
			cinst.add_argument (ccall);
			cinst.add_argument (new CCodeConstant (enum_value));
			cspec = new CCodeFunctionCall (new CCodeIdentifier ("g_param_spec_pointer"));
			cspec.add_argument (func_name_constant);
			cspec.add_argument (new CCodeConstant ("\"destroy func\""));
			cspec.add_argument (new CCodeConstant ("\"destroy func\""));
			cspec.add_argument (new CCodeConstant ("G_PARAM_STATIC_NAME | G_PARAM_STATIC_NICK | G_PARAM_STATIC_BLURB | G_PARAM_WRITABLE | G_PARAM_CONSTRUCT_ONLY"));
			cinst.add_argument (cspec);
			ccode.add_expression (cinst);
			prop_enum.add_value (new CCodeEnumValue (enum_value));
		}

		/* create properties */
		var props = cl.get_properties ();
		foreach (Property prop in props) {
			if (!is_gobject_property (prop)) {
				continue;
			}

			if (prop.comment != null) {
				ccode.add_statement (new CCodeComment (prop.comment.content));
			}

			var cinst = new CCodeFunctionCall (new CCodeIdentifier ("g_object_class_install_property"));
			cinst.add_argument (ccall);
			cinst.add_argument (new CCodeConstant (get_ccode_upper_case_name (prop)));
			cinst.add_argument (get_param_spec (prop));

			ccode.add_expression (cinst);
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
		var get_prop = new CCodeFunction ("_vala_%s_get_property".printf (get_ccode_lower_case_name (cl, null)), "void");
		get_prop.modifiers = CCodeModifiers.STATIC;
		get_prop.add_parameter (new CCodeParameter ("object", "GObject *"));
		get_prop.add_parameter (new CCodeParameter ("property_id", "guint"));
		get_prop.add_parameter (new CCodeParameter ("value", "GValue *"));
		get_prop.add_parameter (new CCodeParameter ("pspec", "GParamSpec *"));

		push_function (get_prop);
		
		CCodeFunctionCall ccall = generate_instance_cast (new CCodeIdentifier ("object"), cl);
		ccode.add_declaration ("%s *".printf (get_ccode_name (cl)), new CCodeVariableDeclarator ("self", ccall));

		ccode.open_switch (new CCodeIdentifier ("property_id"));
		var props = cl.get_properties ();
		foreach (Property prop in props) {
			if (prop.get_accessor == null || prop.is_abstract) {
				continue;
			}
			if (!is_gobject_property (prop)) {
				// don't register private properties
				continue;
			}

			Property base_prop = prop;
			CCodeExpression cself = new CCodeIdentifier ("self");
			if (prop.base_property != null) {
				var base_type = (Class) prop.base_property.parent_symbol;
				base_prop = prop.base_property;
				cself = get_cvalue_ (transform_value (new GLibValue (new ObjectType (cl), cself, true), new ObjectType (base_type), prop));

				generate_property_accessor_declaration (prop.base_property.get_accessor, cfile);
			} else if (prop.base_interface_property != null) {
				var base_type = (Interface) prop.base_interface_property.parent_symbol;
				base_prop = prop.base_interface_property;
				cself = get_cvalue_ (transform_value (new GLibValue (new ObjectType (cl), cself, true), new ObjectType (base_type), prop));

				generate_property_accessor_declaration (prop.base_interface_property.get_accessor, cfile);
			}

			CCodeExpression cfunc;
			if (!get_ccode_no_accessor_method (base_prop) && !get_ccode_concrete_accessor (base_prop)) {
				cfunc = new CCodeIdentifier (get_ccode_name (base_prop.get_accessor));
			} else {
				// use the static real function as helper
				cfunc = new CCodeIdentifier (get_ccode_real_name (prop.get_accessor));
			}

			ccode.add_case (new CCodeIdentifier (get_ccode_upper_case_name (prop)));
			if (prop.property_type.is_real_struct_type ()) {
				var st = prop.property_type.data_type as Struct;

				ccode.open_block ();
				ccode.add_declaration (get_ccode_name (st), new CCodeVariableDeclarator ("boxed"));

				ccall = new CCodeFunctionCall (cfunc);
				ccall.add_argument (cself);
				var boxed_addr = new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, new CCodeIdentifier ("boxed"));
				ccall.add_argument (boxed_addr);
				ccode.add_expression (ccall);

				var csetcall = new CCodeFunctionCall ();
				csetcall.call = get_value_setter_function (prop.property_type);
				csetcall.add_argument (new CCodeIdentifier ("value"));
				csetcall.add_argument (boxed_addr);
				ccode.add_expression (csetcall);

				if (requires_destroy (prop.get_accessor.value_type)) {
					ccode.add_expression (destroy_value (new GLibValue (prop.get_accessor.value_type, new CCodeIdentifier ("boxed"), true)));
				}
				ccode.close ();
			} else {
				ccall = new CCodeFunctionCall (cfunc);
				ccall.add_argument (cself);
				var array_type = prop.property_type as ArrayType;
				if (array_type != null && array_type.element_type.data_type == string_type.data_type) {
					// G_TYPE_STRV
					ccode.open_block ();
					ccode.add_declaration ("int", new CCodeVariableDeclarator ("length"));
					ccall.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, new CCodeIdentifier ("length")));
				}
				var csetcall = new CCodeFunctionCall ();
				if (prop.get_accessor.value_type.value_owned) {
					csetcall.call = get_value_taker_function (prop.property_type);
				} else {
					csetcall.call = get_value_setter_function (prop.property_type);
				}
				csetcall.add_argument (new CCodeIdentifier ("value"));
				csetcall.add_argument (ccall);
				ccode.add_expression (csetcall);
				if (array_type != null && array_type.element_type.data_type == string_type.data_type) {
					ccode.close ();
				}
			}
			ccode.add_break ();
		}
		ccode.add_default ();
		emit_invalid_property_id_warn ();
		ccode.add_break ();

		ccode.close ();

		pop_function ();

		cfile.add_function_declaration (get_prop);
		cfile.add_function (get_prop);
	}
	
	private void add_set_property_function (Class cl) {
		var set_prop = new CCodeFunction ("_vala_%s_set_property".printf (get_ccode_lower_case_name (cl, null)), "void");
		set_prop.modifiers = CCodeModifiers.STATIC;
		set_prop.add_parameter (new CCodeParameter ("object", "GObject *"));
		set_prop.add_parameter (new CCodeParameter ("property_id", "guint"));
		set_prop.add_parameter (new CCodeParameter ("value", "const GValue *"));
		set_prop.add_parameter (new CCodeParameter ("pspec", "GParamSpec *"));

		push_function (set_prop);
		
		CCodeFunctionCall ccall = generate_instance_cast (new CCodeIdentifier ("object"), cl);
		ccode.add_declaration ("%s *".printf (get_ccode_name (cl)), new CCodeVariableDeclarator ("self", ccall));

		ccode.open_switch (new CCodeIdentifier ("property_id"));
		var props = cl.get_properties ();
		foreach (Property prop in props) {
			if (prop.set_accessor == null || prop.is_abstract) {
				continue;
			}
			if (!is_gobject_property (prop)) {
				continue;
			}

			Property base_prop = prop;
			CCodeExpression cself = new CCodeIdentifier ("self");
			if (prop.base_property != null) {
				var base_type = (Class) prop.base_property.parent_symbol;
				base_prop = prop.base_property;
				cself = get_cvalue_ (transform_value (new GLibValue (new ObjectType (cl), cself, true), new ObjectType (base_type), prop));

				generate_property_accessor_declaration (prop.base_property.set_accessor, cfile);
			} else if (prop.base_interface_property != null) {
				var base_type = (Interface) prop.base_interface_property.parent_symbol;
				base_prop = prop.base_interface_property;
				cself = get_cvalue_ (transform_value (new GLibValue (new ObjectType (cl), cself, true), new ObjectType (base_type), prop));

				generate_property_accessor_declaration (prop.base_interface_property.set_accessor, cfile);
			}

			CCodeExpression cfunc;
			if (!get_ccode_no_accessor_method (base_prop) && !get_ccode_concrete_accessor (base_prop)) {
				cfunc = new CCodeIdentifier (get_ccode_name (base_prop.set_accessor));
			} else {
				// use the static real function as helper
				cfunc = new CCodeIdentifier (get_ccode_real_name (prop.set_accessor));
			}

			ccode.add_case (new CCodeIdentifier (get_ccode_upper_case_name (prop)));
			ccall = new CCodeFunctionCall (cfunc);
			ccall.add_argument (cself);
			if (prop.property_type is ArrayType && ((ArrayType)prop.property_type).element_type.data_type == string_type.data_type) {
				ccode.open_block ();
				ccode.add_declaration ("gpointer", new CCodeVariableDeclarator ("boxed"));

				var cgetcall = new CCodeFunctionCall (new CCodeIdentifier ("g_value_get_boxed"));
				cgetcall.add_argument (new CCodeIdentifier ("value"));
				ccode.add_assignment (new CCodeIdentifier ("boxed"), cgetcall);
				ccall.add_argument (new CCodeIdentifier ("boxed"));

				var cisnull = new CCodeBinaryExpression (CCodeBinaryOperator.EQUALITY, new CCodeIdentifier ("boxed"), new CCodeConstant ("NULL"));
				var cstrvlen = new CCodeFunctionCall (new CCodeIdentifier ("g_strv_length"));
				cstrvlen.add_argument (new CCodeIdentifier ("boxed"));
				var ccond = new CCodeConditionalExpression (cisnull, new CCodeConstant ("0"), cstrvlen);

				ccall.add_argument (ccond);
				ccode.add_expression (ccall);
				ccode.close ();
			} else {
				var cgetcall = new CCodeFunctionCall ();
				if (prop.property_type.data_type != null) {
					cgetcall.call = new CCodeIdentifier (get_ccode_get_value_function (prop.property_type.data_type));
				} else {
					cgetcall.call = new CCodeIdentifier ("g_value_get_pointer");
				}
				cgetcall.add_argument (new CCodeIdentifier ("value"));
				ccall.add_argument (cgetcall);
				ccode.add_expression (ccall);
			}
			ccode.add_break ();
		}

		/* type, dup func, and destroy func properties for generic types */
		foreach (TypeParameter type_param in cl.get_type_parameters ()) {
			string func_name, enum_value;
			CCodeMemberAccess cfield;
			CCodeFunctionCall cgetcall;

			func_name = "%s_type".printf (type_param.name.ascii_down ());
			enum_value = "%s_%s".printf (get_ccode_lower_case_name (cl, null), func_name).ascii_up ();
			ccode.add_case (new CCodeIdentifier (enum_value));
			cfield = new CCodeMemberAccess.pointer (new CCodeMemberAccess.pointer (new CCodeIdentifier ("self"), "priv"), func_name);
			cgetcall = new CCodeFunctionCall (new CCodeIdentifier ("g_value_get_gtype"));
			cgetcall.add_argument (new CCodeIdentifier ("value"));
			ccode.add_assignment (cfield, cgetcall);
			ccode.add_break ();

			func_name = "%s_dup_func".printf (type_param.name.ascii_down ());
			enum_value = "%s_%s".printf (get_ccode_lower_case_name (cl, null), func_name).ascii_up ();
			ccode.add_case (new CCodeIdentifier (enum_value));
			cfield = new CCodeMemberAccess.pointer (new CCodeMemberAccess.pointer (new CCodeIdentifier ("self"), "priv"), func_name);
			cgetcall = new CCodeFunctionCall (new CCodeIdentifier ("g_value_get_pointer"));
			cgetcall.add_argument (new CCodeIdentifier ("value"));
			ccode.add_assignment (cfield, cgetcall);
			ccode.add_break ();

			func_name = "%s_destroy_func".printf (type_param.name.ascii_down ());
			enum_value = "%s_%s".printf (get_ccode_lower_case_name (cl, null), func_name).ascii_up ();
			ccode.add_case (new CCodeIdentifier (enum_value));
			cfield = new CCodeMemberAccess.pointer (new CCodeMemberAccess.pointer (new CCodeIdentifier ("self"), "priv"), func_name);
			cgetcall = new CCodeFunctionCall (new CCodeIdentifier ("g_value_get_pointer"));
			cgetcall.add_argument (new CCodeIdentifier ("value"));
			ccode.add_assignment (cfield, cgetcall);
			ccode.add_break ();
		}
		ccode.add_default ();
		emit_invalid_property_id_warn ();
		ccode.add_break ();

		ccode.close ();

		pop_function ();

		cfile.add_function_declaration (set_prop);
		cfile.add_function (set_prop);
	}

	private void emit_invalid_property_id_warn () {
		// warn on invalid property id
		var cwarn = new CCodeFunctionCall (new CCodeIdentifier ("G_OBJECT_WARN_INVALID_PROPERTY_ID"));
		cwarn.add_argument (new CCodeIdentifier ("object"));
		cwarn.add_argument (new CCodeIdentifier ("property_id"));
		cwarn.add_argument (new CCodeIdentifier ("pspec"));
		ccode.add_expression (cwarn);
	}

	public override void visit_constructor (Constructor c) {
		push_line (c.source_reference);

		var cl = (Class) c.parent_symbol;

		if (c.binding == MemberBinding.INSTANCE) {
			if (!cl.is_subtype_of (gobject_type)) {
				Report.error (c.source_reference, "construct blocks require GLib.Object");
				c.error = true;
				return;
			}

			push_context (new EmitContext (c));

			var function = new CCodeFunction ("%s_constructor".printf (get_ccode_lower_case_name (cl, null)), "GObject *");
			function.modifiers = CCodeModifiers.STATIC;
		
			function.add_parameter (new CCodeParameter ("type", "GType"));
			function.add_parameter (new CCodeParameter ("n_construct_properties", "guint"));
			function.add_parameter (new CCodeParameter ("construct_properties", "GObjectConstructParam *"));
		
			cfile.add_function_declaration (function);

			push_function (function);

			ccode.add_declaration ("GObject *", new CCodeVariableDeclarator ("obj"));
			ccode.add_declaration ("GObjectClass *", new CCodeVariableDeclarator ("parent_class"));

			var ccast = new CCodeFunctionCall (new CCodeIdentifier ("G_OBJECT_CLASS"));
			ccast.add_argument (new CCodeIdentifier ("%s_parent_class".printf (get_ccode_lower_case_name (cl, null))));
			ccode.add_assignment (new CCodeIdentifier ("parent_class"), ccast);

			var ccall = new CCodeFunctionCall (new CCodeMemberAccess.pointer (new CCodeIdentifier ("parent_class"), "constructor"));
			ccall.add_argument (new CCodeIdentifier ("type"));
			ccall.add_argument (new CCodeIdentifier ("n_construct_properties"));
			ccall.add_argument (new CCodeIdentifier ("construct_properties"));
			ccode.add_assignment (new CCodeIdentifier ("obj"), ccall);


			ccall = generate_instance_cast (new CCodeIdentifier ("obj"), cl);

			ccode.add_declaration ("%s *".printf (get_ccode_name (cl)), new CCodeVariableDeclarator ("self"));
			ccode.add_assignment (new CCodeIdentifier ("self"), ccall);

			c.body.emit (this);

			if (current_method_inner_error) {
				/* always separate error parameter and inner_error local variable
				 * as error may be set to NULL but we're always interested in inner errors
				 */
				ccode.add_declaration ("GError *", new CCodeVariableDeclarator.zero ("_inner_error_", new CCodeConstant ("NULL")));
			}

			ccode.add_return (new CCodeIdentifier ("obj"));

			pop_function ();
			cfile.add_function (function);

			pop_context ();
		} else if (c.binding == MemberBinding.CLASS) {
			// class constructor

			if (cl.is_compact) {
				Report.error (c.source_reference, "class constructors are not supported in compact classes");
				c.error = true;
				return;
			}

			push_context (base_init_context);

			c.body.emit (this);

			if (current_method_inner_error) {
				/* always separate error parameter and inner_error local variable
				 * as error may be set to NULL but we're always interested in inner errors
				 */
				ccode.add_declaration ("GError *", new CCodeVariableDeclarator.zero ("_inner_error_", new CCodeConstant ("NULL")));
			}

			pop_context ();
		} else if (c.binding == MemberBinding.STATIC) {
			// static class constructor
			// add to class_init

			if (cl.is_compact) {
				Report.error (c.source_reference, "static constructors are not supported in compact classes");
				c.error = true;
				return;
			}

			push_context (class_init_context);

			c.body.emit (this);

			if (current_method_inner_error) {
				/* always separate error parameter and inner_error local variable
				 * as error may be set to NULL but we're always interested in inner errors
				 */
				ccode.add_declaration ("GError *", new CCodeVariableDeclarator.zero ("_inner_error_", new CCodeConstant ("NULL")));
			}

			pop_context ();
		} else {
			Report.error (c.source_reference, "internal error: constructors must have instance, class, or static binding");
		}

		pop_line ();
	}

	public override string get_dynamic_property_getter_cname (DynamicProperty prop) {
		if (prop.dynamic_type.data_type == null
		    || !prop.dynamic_type.data_type.is_subtype_of (gobject_type)) {
			return base.get_dynamic_property_getter_cname (prop);
		}

		string getter_cname = "_dynamic_get_%s%d".printf (prop.name, dynamic_property_id++);

		var func = new CCodeFunction (getter_cname, get_ccode_name (prop.property_type));
		func.modifiers |= CCodeModifiers.STATIC | CCodeModifiers.INLINE;

		func.add_parameter (new CCodeParameter ("obj", get_ccode_name (prop.dynamic_type)));

		push_function (func);

		ccode.add_declaration (get_ccode_name (prop.property_type), new CCodeVariableDeclarator ("result"));

		var call = new CCodeFunctionCall (new CCodeIdentifier ("g_object_get"));
		call.add_argument (new CCodeIdentifier ("obj"));
		call.add_argument (get_property_canonical_cconstant (prop));
		call.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, new CCodeIdentifier ("result")));
		call.add_argument (new CCodeConstant ("NULL"));

		ccode.add_expression (call);

		ccode.add_return (new CCodeIdentifier ("result"));

		pop_function ();

		// append to C source file
		cfile.add_function_declaration (func);
		cfile.add_function (func);

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
		func.add_parameter (new CCodeParameter ("obj", get_ccode_name (prop.dynamic_type)));
		func.add_parameter (new CCodeParameter ("value", get_ccode_name (prop.property_type)));

		push_function (func);

		var call = new CCodeFunctionCall (new CCodeIdentifier ("g_object_set"));
		call.add_argument (new CCodeIdentifier ("obj"));
		call.add_argument (get_property_canonical_cconstant (prop));
		call.add_argument (new CCodeIdentifier ("value"));
		call.add_argument (new CCodeConstant ("NULL"));

		ccode.add_expression (call);

		pop_function ();

		// append to C source file
		cfile.add_function_declaration (func);
		cfile.add_function (func);

		return setter_cname;
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
		var func = new CCodeFunction (connect_wrapper_name, "gulong");
		func.add_parameter (new CCodeParameter ("obj", "gpointer"));
		func.add_parameter (new CCodeParameter ("signal_name", "const char *"));
		func.add_parameter (new CCodeParameter ("handler", "GCallback"));
		func.add_parameter (new CCodeParameter ("data", "gpointer"));
		push_function (func);
		generate_gobject_connect_wrapper (sig, false);
		pop_function ();

		// append to C source file
		cfile.add_function_declaration (func);
		cfile.add_function (func);

		return connect_wrapper_name;
	}

	public override string get_dynamic_signal_connect_after_wrapper_name (DynamicSignal sig) {
		if (sig.dynamic_type.data_type == null
		    || !sig.dynamic_type.data_type.is_subtype_of (gobject_type)) {
			return base.get_dynamic_signal_connect_wrapper_name (sig);
		}

		string connect_wrapper_name = "_%sconnect_after".printf (get_dynamic_signal_cname (sig));
		var func = new CCodeFunction (connect_wrapper_name, "gulong");
		func.add_parameter (new CCodeParameter ("obj", "gpointer"));
		func.add_parameter (new CCodeParameter ("signal_name", "const char *"));
		func.add_parameter (new CCodeParameter ("handler", "GCallback"));
		func.add_parameter (new CCodeParameter ("data", "gpointer"));
		push_function (func);
		generate_gobject_connect_wrapper (sig, true);
		pop_function ();

		// append to C source file
		cfile.add_function_declaration (func);
		cfile.add_function (func);

		return connect_wrapper_name;
	}

	void generate_gobject_connect_wrapper (DynamicSignal sig, bool after) {
		var m = (Method) sig.handler.symbol_reference;

		sig.accept (this);

		string connect_func = "g_signal_connect_object";
		if (m.binding != MemberBinding.INSTANCE) {
			if (!after)
				connect_func = "g_signal_connect";
			else
				connect_func = "g_signal_connect_after";
		}

		var call = new CCodeFunctionCall (new CCodeIdentifier (connect_func));
		call.add_argument (new CCodeIdentifier ("obj"));
		call.add_argument (new CCodeIdentifier ("signal_name"));
		call.add_argument (new CCodeIdentifier ("handler"));
		call.add_argument (new CCodeIdentifier ("data"));

		if (m.binding == MemberBinding.INSTANCE) {
			if (!after) {
				call.add_argument (new CCodeConstant ("0"));
			} else {
				call.add_argument (new CCodeConstant ("G_CONNECT_AFTER"));
			}
		}

		ccode.add_return (call);
	}

	public override void visit_property (Property prop) {
		base.visit_property (prop);

		if (is_gobject_property (prop) && prop.parent_symbol is Class) {
			prop_enum.add_value (new CCodeEnumValue (get_ccode_upper_case_name (prop)));

			if (prop.initializer != null && prop.set_accessor != null && !prop.set_accessor.automatic_body) {
				// generate a custom initializer if it couldn't be done at class_init time
				bool has_spec_initializer = prop.property_type.data_type is Enum;
				if (!has_spec_initializer && prop.property_type.data_type is Struct) {
					var param_spec_func = get_ccode_param_spec_function (prop.property_type.data_type);
					has_spec_initializer = param_spec_func != "g_param_spec_boxed";
				}
				if (!has_spec_initializer) {
					push_context (instance_init_context);

					prop.initializer.emit (this);

					var inst_ma = new MemberAccess.simple ("this");
					inst_ma.target_value = new GLibValue (get_data_type_for_symbol ((Class) prop.parent_symbol), new CCodeIdentifier ("self"), true);
					store_property (prop, inst_ma, prop.initializer.target_value);

					temp_ref_values.clear ();			
					pop_context ();
				}
			}
		}
	}

	public override bool is_gobject_property (Property prop) {
		var type_sym = prop.parent_symbol as ObjectTypeSymbol;
		if (type_sym == null || !type_sym.is_subtype_of (gobject_type)) {
			return false;
		}

		if (prop.binding != MemberBinding.INSTANCE) {
			return false;
		}

		if (prop.access == SymbolAccessibility.PRIVATE) {
			return false;
		}

		var st = prop.property_type.data_type as Struct;
		if (st != null && (!get_ccode_has_type_id (st) || prop.property_type.nullable)) {
			return false;
		}

		if (prop.property_type is ArrayType && ((ArrayType)prop.property_type).element_type.data_type != string_type.data_type) {
			return false;
		}

		var d = prop.property_type as DelegateType;
		if (d != null && d.delegate_symbol.has_target) {
			return false;
		}

		if (type_sym is Class && prop.base_interface_property != null &&
		    !is_gobject_property (prop.base_interface_property)) {
			return false;
		}

		if (!prop.name[0].isalpha ()) {
			// GObject requires properties to start with a letter
			return false;
		}

		if (type_sym is Interface && !prop.is_abstract && !prop.external && !prop.external_package) {
			// GObject does not support non-abstract interface properties,
			// however we assume external properties always are GObject properties
			return false;
		}

		if (type_sym is Interface && type_sym.get_attribute ("DBus") != null) {
			// GObject properties not currently supported in D-Bus interfaces
			return false;
		}

		return true;
	}

	public override void visit_method_call (MethodCall expr) {
		if (expr.call is MemberAccess) {
			push_line (expr.source_reference);

			var ma = expr.call as MemberAccess;
			if (ma.inner != null && ma.inner.symbol_reference == gobject_type &&
			    (ma.member_name == "new" || ma.member_name == "newv")) {
				// Object.new (...) creation
				// runtime check to ref_sink the instance if it's a floating type
				base.visit_method_call (expr);

				var initiallyunowned_ccall = new CCodeFunctionCall (new CCodeIdentifier ("G_IS_INITIALLY_UNOWNED"));
				initiallyunowned_ccall.add_argument (get_cvalue (expr));
				var sink_ref_ccall = new CCodeFunctionCall (new CCodeIdentifier ("g_object_ref_sink"));
				sink_ref_ccall.add_argument (get_cvalue (expr));
				var cexpr = new CCodeConditionalExpression (initiallyunowned_ccall, sink_ref_ccall, get_cvalue (expr));

				expr.target_value = store_temp_value (new GLibValue (expr.value_type, cexpr), expr);
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
					if (!is_gobject_property (prop)) {
						Report.error (arg.source_reference, "Property `%s' not supported in Object (property: value) constructor chain up".printf (named_argument.name));
						break;
					}
					if (!arg.value_type.compatible (prop.property_type)) {
						Report.error (arg.source_reference, "Cannot convert from `%s' to `%s'".printf (arg.value_type.to_string (), prop.property_type.to_string ()));
						break;
					}
				}
			}

			pop_line ();
		}

		base.visit_method_call (expr);
	}
}

