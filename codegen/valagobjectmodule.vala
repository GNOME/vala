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
	int signal_wrapper_id;

	public override void visit_class (Class cl) {
		base.visit_class (cl);

		if (!cl.is_subtype_of (gobject_type)) {
			return;
		}

		push_line (cl.source_reference);
		if (class_has_readable_properties (cl) || cl.has_type_parameters ()) {
			add_get_property_function (cl);
		}
		if (class_has_writable_properties (cl) || cl.has_type_parameters ()) {
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
		if (class_has_readable_properties (cl) || cl.has_type_parameters ()) {
			ccode.add_assignment (new CCodeMemberAccess.pointer (ccall, "get_property"), new CCodeIdentifier ("_vala_%s_get_property".printf (get_ccode_lower_case_name (cl, null))));
		}
		if (class_has_writable_properties (cl) || cl.has_type_parameters ()) {
			ccode.add_assignment (new CCodeMemberAccess.pointer (ccall, "set_property"), new CCodeIdentifier ("_vala_%s_set_property".printf (get_ccode_lower_case_name (cl, null))));
		}

		/* set constructor */
		if (cl.constructor != null) {
			var ccast = new CCodeFunctionCall (new CCodeIdentifier ("G_OBJECT_CLASS"));
			ccast.add_argument (new CCodeIdentifier ("klass"));
			ccode.add_assignment (new CCodeMemberAccess.pointer (ccast, "constructor"), new CCodeIdentifier ("%sconstructor".printf (get_ccode_lower_case_prefix (cl))));
		}

		/* set finalize function */
		if (cl.get_fields ().size > 0 || cl.destructor != null) {
			var ccast = new CCodeFunctionCall (new CCodeIdentifier ("G_OBJECT_CLASS"));
			ccast.add_argument (new CCodeIdentifier ("klass"));
			ccode.add_assignment (new CCodeMemberAccess.pointer (ccast, "finalize"), new CCodeIdentifier ("%sfinalize".printf (get_ccode_lower_case_prefix (cl))));
		}

		/* create type, dup_func, and destroy_func properties for generic types */
		foreach (TypeParameter type_param in cl.get_type_parameters ()) {
			string func_name, enum_value;
			CCodeConstant func_name_constant;
			CCodeFunctionCall cinst, cspec;


			func_name = get_ccode_type_id (type_param);
			func_name_constant = new CCodeConstant ("\"%s\"".printf (func_name.replace ("_", "-")));
			enum_value = "%s_%s".printf (get_ccode_lower_case_name (cl, null), func_name).ascii_up ();
			cinst = new CCodeFunctionCall (new CCodeIdentifier ("g_object_class_install_property"));
			cinst.add_argument (ccall);
			cinst.add_argument (new CCodeConstant (enum_value));
			cspec = new CCodeFunctionCall (new CCodeIdentifier ("g_param_spec_gtype"));
			cspec.add_argument (func_name_constant);
			cspec.add_argument (new CCodeConstant ("\"type\""));
			cspec.add_argument (new CCodeConstant ("\"type\""));
			cspec.add_argument (new CCodeIdentifier ("G_TYPE_NONE"));
			cspec.add_argument (new CCodeConstant ("G_PARAM_STATIC_STRINGS | G_PARAM_READWRITE | G_PARAM_CONSTRUCT_ONLY"));
			cinst.add_argument (cspec);
			ccode.add_expression (cinst);
			prop_enum.add_value (new CCodeEnumValue (enum_value));


			func_name = get_ccode_copy_function (type_param);
			func_name_constant = new CCodeConstant ("\"%s\"".printf (func_name.replace ("_", "-")));
			enum_value = "%s_%s".printf (get_ccode_lower_case_name (cl, null), func_name).ascii_up ();
			cinst = new CCodeFunctionCall (new CCodeIdentifier ("g_object_class_install_property"));
			cinst.add_argument (ccall);
			cinst.add_argument (new CCodeConstant (enum_value));
			cspec = new CCodeFunctionCall (new CCodeIdentifier ("g_param_spec_pointer"));
			cspec.add_argument (func_name_constant);
			cspec.add_argument (new CCodeConstant ("\"dup func\""));
			cspec.add_argument (new CCodeConstant ("\"dup func\""));
			cspec.add_argument (new CCodeConstant ("G_PARAM_STATIC_STRINGS | G_PARAM_READWRITE | G_PARAM_CONSTRUCT_ONLY"));
			cinst.add_argument (cspec);
			ccode.add_expression (cinst);
			prop_enum.add_value (new CCodeEnumValue (enum_value));


			func_name = get_ccode_destroy_function (type_param);
			func_name_constant = new CCodeConstant ("\"%s\"".printf (func_name.replace ("_", "-")));
			enum_value = "%s_%s".printf (get_ccode_lower_case_name (cl, null), func_name).ascii_up ();
			cinst = new CCodeFunctionCall (new CCodeIdentifier ("g_object_class_install_property"));
			cinst.add_argument (ccall);
			cinst.add_argument (new CCodeConstant (enum_value));
			cspec = new CCodeFunctionCall (new CCodeIdentifier ("g_param_spec_pointer"));
			cspec.add_argument (func_name_constant);
			cspec.add_argument (new CCodeConstant ("\"destroy func\""));
			cspec.add_argument (new CCodeConstant ("\"destroy func\""));
			cspec.add_argument (new CCodeConstant ("G_PARAM_STATIC_STRINGS | G_PARAM_READWRITE | G_PARAM_CONSTRUCT_ONLY"));
			cinst.add_argument (cspec);
			ccode.add_expression (cinst);
			prop_enum.add_value (new CCodeEnumValue (enum_value));
		}

		/* create properties */
		var props = cl.get_properties ();
		foreach (Property prop in props) {
			if (!context.analyzer.is_gobject_property (prop)) {
				if (!context.analyzer.is_gobject_property_type (prop.property_type)) {
					Report.warning (prop.source_reference, "Type `%s' can not be used for a GLib.Object property", prop.property_type.to_qualified_string ());
				}
				continue;
			}

			if (prop.comment != null) {
				ccode.add_statement (new CCodeComment (prop.comment.content));
			}

			var cinst = new CCodeFunctionCall ();
			cinst.add_argument (ccall);
			cinst.add_argument (new CCodeConstant ("%s_PROPERTY".printf (get_ccode_upper_case_name (prop))));

			//TODO g_object_class_override_property should be used more regulary
			unowned Property? base_prop = prop.base_interface_property;
			if (base_prop != null && base_prop.property_type is GenericType) {
				cinst.call = new CCodeIdentifier ("g_object_class_override_property");
				cinst.add_argument (get_property_canonical_cconstant (prop));

				ccode.add_expression (cinst);

				var cfind = new CCodeFunctionCall (new CCodeIdentifier ("g_object_class_find_property"));
				cfind.add_argument (ccall);
				cfind.add_argument (get_property_canonical_cconstant (prop));
				ccode.add_expression (new CCodeAssignment (get_param_spec_cexpression (prop), cfind));
			} else {
				cinst.call = new CCodeIdentifier ("g_object_class_install_property");
				cinst.add_argument (get_param_spec (prop));

				ccode.add_expression (cinst);
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

	private void add_guarded_expression (Symbol sym, CCodeExpression expression) {
		// prevent deprecation warnings
		if (sym.version.deprecated) {
			var guard = new CCodeGGnucSection (GGnucSectionType.IGNORE_DEPRECATIONS);
			ccode.add_statement (guard);
			guard.append (new CCodeExpressionStatement (expression));
		} else {
			ccode.add_expression (expression);
		}
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
			if (!context.analyzer.is_gobject_property (prop)) {
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

			ccode.add_case (new CCodeIdentifier ("%s_PROPERTY".printf (get_ccode_upper_case_name (prop))));
			if (prop.property_type.is_real_struct_type ()) {
				ccode.open_block ();
				ccode.add_declaration (get_ccode_name (prop.property_type), new CCodeVariableDeclarator ("boxed"));

				ccall = new CCodeFunctionCall (cfunc);
				ccall.add_argument (cself);
				if (prop.property_type.nullable) {
					ccode.add_assignment (new CCodeIdentifier ("boxed"), ccall);
				} else {
					ccall.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, new CCodeIdentifier ("boxed")));
					ccode.add_expression (ccall);
				}

				var csetcall = new CCodeFunctionCall ();
				csetcall.call = get_value_setter_function (prop.property_type);
				csetcall.add_argument (new CCodeIdentifier ("value"));
				if (prop.property_type.nullable) {
					csetcall.add_argument (new CCodeIdentifier ("boxed"));
				} else {
					csetcall.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, new CCodeIdentifier ("boxed")));
				}
				add_guarded_expression (prop, csetcall);

				if (requires_destroy (prop.get_accessor.value_type)) {
					ccode.add_expression (destroy_value (new GLibValue (prop.get_accessor.value_type, new CCodeIdentifier ("boxed"), true)));
				}
				ccode.close ();
			} else {
				ccall = new CCodeFunctionCall (cfunc);
				ccall.add_argument (cself);
				var array_type = prop.property_type as ArrayType;
				if (array_type != null && get_ccode_array_length (prop) && array_type.element_type.type_symbol == string_type.type_symbol) {
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
				if (base_prop != null && prop != base_prop && base_prop.property_type is GenericType) {
					csetcall.add_argument (convert_from_generic_pointer (ccall, prop.property_type));
				} else {
					csetcall.add_argument (ccall);
				}
				add_guarded_expression (prop, csetcall);
				if (array_type != null && get_ccode_array_length (prop) && array_type.element_type.type_symbol == string_type.type_symbol) {
					ccode.close ();
				}
			}
			ccode.add_break ();
		}

		/* type, dup func, and destroy func properties for generic types */
		foreach (TypeParameter type_param in cl.get_type_parameters ()) {
			string func_name, enum_value;
			CCodeMemberAccess cfield;
			CCodeFunctionCall csetcall;

			func_name = get_ccode_type_id (type_param);
			enum_value = "%s_%s".printf (get_ccode_lower_case_name (cl, null), func_name).ascii_up ();
			ccode.add_case (new CCodeIdentifier (enum_value));
			cfield = new CCodeMemberAccess.pointer (new CCodeMemberAccess.pointer (new CCodeIdentifier ("self"), "priv"), func_name);
			csetcall = new CCodeFunctionCall (new CCodeIdentifier ("g_value_set_gtype"));
			csetcall.add_argument (new CCodeIdentifier ("value"));
			csetcall.add_argument (cfield);
			ccode.add_expression (csetcall);
			ccode.add_break ();

			func_name = get_ccode_copy_function (type_param);
			enum_value = "%s_%s".printf (get_ccode_lower_case_name (cl, null), func_name).ascii_up ();
			ccode.add_case (new CCodeIdentifier (enum_value));
			cfield = new CCodeMemberAccess.pointer (new CCodeMemberAccess.pointer (new CCodeIdentifier ("self"), "priv"), func_name);
			csetcall = new CCodeFunctionCall (new CCodeIdentifier ("g_value_set_pointer"));
			csetcall.add_argument (new CCodeIdentifier ("value"));
			csetcall.add_argument (cfield);
			ccode.add_expression (csetcall);
			ccode.add_break ();

			func_name = get_ccode_destroy_function (type_param);
			enum_value = "%s_%s".printf (get_ccode_lower_case_name (cl, null), func_name).ascii_up ();
			ccode.add_case (new CCodeIdentifier (enum_value));
			cfield = new CCodeMemberAccess.pointer (new CCodeMemberAccess.pointer (new CCodeIdentifier ("self"), "priv"), func_name);
			csetcall = new CCodeFunctionCall (new CCodeIdentifier ("g_value_set_pointer"));
			csetcall.add_argument (new CCodeIdentifier ("value"));
			csetcall.add_argument (cfield);
			ccode.add_expression (csetcall);
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
			if (!context.analyzer.is_gobject_property (prop)) {
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

			ccode.add_case (new CCodeIdentifier ("%s_PROPERTY".printf (get_ccode_upper_case_name (prop))));
			ccall = new CCodeFunctionCall (cfunc);
			ccall.add_argument (cself);
			if (prop.property_type is ArrayType && ((ArrayType)prop.property_type).element_type.type_symbol == string_type.type_symbol) {
				ccode.open_block ();
				ccode.add_declaration ("gpointer", new CCodeVariableDeclarator ("boxed"));

				var cgetcall = new CCodeFunctionCall (new CCodeIdentifier ("g_value_get_boxed"));
				cgetcall.add_argument (new CCodeIdentifier ("value"));
				ccode.add_assignment (new CCodeIdentifier ("boxed"), cgetcall);
				ccall.add_argument (new CCodeIdentifier ("boxed"));

				if (get_ccode_array_length (prop)) {
					var cisnull = new CCodeBinaryExpression (CCodeBinaryOperator.EQUALITY, new CCodeIdentifier ("boxed"), new CCodeConstant ("NULL"));
					var cstrvlen = new CCodeFunctionCall (new CCodeIdentifier ("g_strv_length"));
					cstrvlen.add_argument (new CCodeIdentifier ("boxed"));
					var ccond = new CCodeConditionalExpression (cisnull, new CCodeConstant ("0"), cstrvlen);

					ccall.add_argument (ccond);
				}
				add_guarded_expression (prop, ccall);
				ccode.close ();
			} else {
				var cgetcall = new CCodeFunctionCall ();
				if (prop.property_type.type_symbol != null) {
					cgetcall.call = new CCodeIdentifier (get_ccode_get_value_function (prop.property_type.type_symbol));
				} else {
					cgetcall.call = new CCodeIdentifier ("g_value_get_pointer");
				}
				cgetcall.add_argument (new CCodeIdentifier ("value"));
				if (base_prop != null && prop != base_prop && base_prop.property_type is GenericType) {
					ccall.add_argument (convert_to_generic_pointer (cgetcall, prop.property_type));
				} else {
					ccall.add_argument (cgetcall);
				}
				add_guarded_expression (prop, ccall);
			}
			ccode.add_break ();
		}

		/* type, dup func, and destroy func properties for generic types */
		foreach (TypeParameter type_param in cl.get_type_parameters ()) {
			string func_name, enum_value;
			CCodeMemberAccess cfield;
			CCodeFunctionCall cgetcall;

			func_name = get_ccode_type_id (type_param);
			enum_value = "%s_%s".printf (get_ccode_lower_case_name (cl, null), func_name).ascii_up ();
			ccode.add_case (new CCodeIdentifier (enum_value));
			cfield = new CCodeMemberAccess.pointer (new CCodeMemberAccess.pointer (new CCodeIdentifier ("self"), "priv"), func_name);
			cgetcall = new CCodeFunctionCall (new CCodeIdentifier ("g_value_get_gtype"));
			cgetcall.add_argument (new CCodeIdentifier ("value"));
			ccode.add_assignment (cfield, cgetcall);
			ccode.add_break ();

			func_name = get_ccode_copy_function (type_param);
			enum_value = "%s_%s".printf (get_ccode_lower_case_name (cl, null), func_name).ascii_up ();
			ccode.add_case (new CCodeIdentifier (enum_value));
			cfield = new CCodeMemberAccess.pointer (new CCodeMemberAccess.pointer (new CCodeIdentifier ("self"), "priv"), func_name);
			cgetcall = new CCodeFunctionCall (new CCodeIdentifier ("g_value_get_pointer"));
			cgetcall.add_argument (new CCodeIdentifier ("value"));
			ccode.add_assignment (cfield, cgetcall);
			ccode.add_break ();

			func_name = get_ccode_destroy_function (type_param);
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

			var function = new CCodeFunction ("%sconstructor".printf (get_ccode_lower_case_prefix (cl)), "GObject *");
			function.modifiers = CCodeModifiers.STATIC;

			function.add_parameter (new CCodeParameter ("type", "GType"));
			function.add_parameter (new CCodeParameter ("n_construct_properties", "guint"));
			function.add_parameter (new CCodeParameter ("construct_properties", "GObjectConstructParam *"));

			cfile.add_function_declaration (function);

			push_function (function);

			ccode.add_declaration ("GObject *", new CCodeVariableDeclarator ("obj"));
			ccode.add_declaration ("GObjectClass *", new CCodeVariableDeclarator ("parent_class"));

			if (cl.is_singleton) {
				var singleton_ref_name = "%s_singleton__ref".printf (get_ccode_name (cl));
				var singleton_lock_name = "%s_singleton__lock".printf (get_ccode_name (cl));

				var singleton_ref = new CCodeDeclaration("GWeakRef");
				singleton_ref.add_declarator (new CCodeVariableDeclarator (singleton_ref_name));
				singleton_ref.modifiers = CCodeModifiers.STATIC;
				ccode.add_statement (singleton_ref);

				var mutex_lock = new CCodeDeclaration("GMutex");
				mutex_lock.add_declarator (new CCodeVariableDeclarator (singleton_lock_name));
				mutex_lock.modifiers = CCodeModifiers.STATIC;
				ccode.add_statement (mutex_lock);

				var singleton_mutex_lock = new CCodeFunctionCall (new CCodeIdentifier ("g_mutex_lock"));
				singleton_mutex_lock.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, new CCodeIdentifier (singleton_lock_name)));
				ccode.add_statement (new CCodeExpressionStatement (singleton_mutex_lock));

				var get_from_singleton = new CCodeFunctionCall (new CCodeIdentifier ("g_weak_ref_get"));
				get_from_singleton.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, new CCodeIdentifier (singleton_ref_name)));
				ccode.add_assignment (new CCodeIdentifier ("obj"), get_from_singleton);

				var check_existance = new CCodeBinaryExpression (CCodeBinaryOperator.INEQUALITY, new CCodeIdentifier ("obj"), new CCodeConstant ("NULL"));
				var return_singleton = new CCodeBlock();

				var singleton_mutex_unlock = new CCodeFunctionCall (new CCodeIdentifier ("g_mutex_unlock"));
				singleton_mutex_unlock.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, new CCodeIdentifier (singleton_lock_name)));
				return_singleton.add_statement (new CCodeExpressionStatement (singleton_mutex_unlock));
				return_singleton.add_statement (new CCodeReturnStatement (new CCodeIdentifier ("obj")));

				var if_singleton_alive = new CCodeIfStatement (check_existance, return_singleton);
				ccode.add_statement (if_singleton_alive);
			}

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
				ccode.add_declaration ("GError*", new CCodeVariableDeclarator.zero ("_inner_error%d_".printf (current_inner_error_id), new CCodeConstant ("NULL")));
			}

			if (cl.is_singleton) {
				var singleton_ref_name = "%s_singleton__ref".printf (get_ccode_name (cl));
				var singleton_lock_name = "%s_singleton__lock".printf (get_ccode_name (cl));

				var set_singleton_reference = new CCodeFunctionCall (new CCodeIdentifier ("g_weak_ref_set"));
				set_singleton_reference.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, new CCodeIdentifier (singleton_ref_name)));
				set_singleton_reference.add_argument (new CCodeIdentifier ("obj"));
				ccode.add_statement (new CCodeExpressionStatement (set_singleton_reference));

				var final_singleton_mutex_unlock = new CCodeFunctionCall (new CCodeIdentifier ("g_mutex_unlock"));
				final_singleton_mutex_unlock.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, new CCodeIdentifier (singleton_lock_name)));
				ccode.add_statement (new CCodeExpressionStatement (final_singleton_mutex_unlock));
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
				ccode.add_declaration ("GError*", new CCodeVariableDeclarator.zero ("_inner_error%d_".printf (current_inner_error_id), new CCodeConstant ("NULL")));
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
				ccode.add_declaration ("GError*", new CCodeVariableDeclarator.zero ("_inner_error%d_".printf (current_inner_error_id), new CCodeConstant ("NULL")));
			}

			pop_context ();
		} else {
			Report.error (c.source_reference, "internal error: constructors must have instance, class, or static binding");
		}

		pop_line ();
	}

	public override string get_dynamic_signal_cname (DynamicSignal node) {
		return "dynamic_%s%d_".printf (node.name, signal_wrapper_id++);
	}

	public override void visit_property (Property prop) {
		base.visit_property (prop);

		if (context.analyzer.is_gobject_property (prop) && prop.parent_symbol is Class) {
			prop_enum.add_value (new CCodeEnumValue ("%s_PROPERTY".printf (get_ccode_upper_case_name (prop))));
		}
	}

	public override void visit_method_call (MethodCall expr) {
		if (expr.call is MemberAccess) {
			push_line (expr.source_reference);

			var ma = expr.call as MemberAccess;
			if (ma.inner != null && ma.inner.symbol_reference == gobject_type &&
			    (ma.member_name == "new" || ma.member_name == "newv"
			     || ma.member_name == "new_valist" || ma.member_name == "new_with_properties")) {
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
						Report.error (arg.source_reference, "Property `%s' not found in `%s'", named_argument.name, current_class.get_full_name ());
						break;
					}
					if (!context.analyzer.is_gobject_property (prop)) {
						Report.error (arg.source_reference, "Property `%s' not supported in Object (property: value) constructor chain up", named_argument.name);
						break;
					}
					if (!arg.value_type.compatible (prop.property_type)) {
						Report.error (arg.source_reference, "Cannot convert from `%s' to `%s'", arg.value_type.to_string (), prop.property_type.to_string ());
						break;
					}
				}
			}

			pop_line ();
		}

		base.visit_method_call (expr);
	}
}

