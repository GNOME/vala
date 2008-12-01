/* valagobjectmodule.vala
 *
 * Copyright (C) 2006-2008  Jürg Billeter, Raffaele Sandrini
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

using GLib;

public class Vala.GObjectModule : GTypeModule {
	int dynamic_property_id;
	int signal_wrapper_id;

	public GObjectModule (CCodeGenerator codegen, CCodeModule? next) {
		base (codegen, next);
	}

	public override void visit_class (Class cl) {
		var old_symbol = current_symbol;
		var old_type_symbol = current_type_symbol;
		var old_class = current_class;
		var old_instance_struct = instance_struct;
		var old_param_spec_struct = param_spec_struct;
		var old_type_struct = type_struct;
		var old_instance_priv_struct = instance_priv_struct;
		var old_prop_enum = prop_enum;
		var old_class_init_fragment = class_init_fragment;
		var old_instance_init_fragment = instance_init_fragment;
		var old_instance_finalize_fragment = instance_finalize_fragment;
		current_symbol = cl;
		current_type_symbol = cl;
		current_class = cl;
		
		bool is_gtypeinstance = !cl.is_compact;
		bool is_gobject = cl.is_subtype_of (gobject_type);
		bool is_fundamental = is_gtypeinstance && cl.base_class == null;

		if (cl.get_cname().len () < 3) {
			cl.error = true;
			Report.error (cl.source_reference, "Class name `%s' is too short".printf (cl.get_cname ()));
			return;
		}


		instance_struct = new CCodeStruct ("_%s".printf (cl.get_cname ()));
		type_struct = new CCodeStruct ("_%sClass".printf (cl.get_cname ()));
		instance_priv_struct = new CCodeStruct ("_%sPrivate".printf (cl.get_cname ()));
		prop_enum = new CCodeEnum ();
		prop_enum.add_value (new CCodeEnumValue ("%s_DUMMY_PROPERTY".printf (cl.get_upper_case_cname (null))));
		class_init_fragment = new CCodeFragment ();
		instance_init_fragment = new CCodeFragment ();
		instance_finalize_fragment = new CCodeFragment ();


		CCodeFragment decl_frag;
		CCodeFragment def_frag;
		if (cl.access != SymbolAccessibility.PRIVATE) {
			decl_frag = header_type_declaration;
			def_frag = header_type_definition;
		} else {
			decl_frag = source_type_declaration;
			def_frag = source_type_definition;
		}

		if (is_gtypeinstance) {
			decl_frag.append (new CCodeNewline ());
			var macro = "(%s_get_type ())".printf (cl.get_lower_case_cname (null));
			decl_frag.append (new CCodeMacroReplacement (cl.get_type_id (), macro));

			macro = "(G_TYPE_CHECK_INSTANCE_CAST ((obj), %s, %s))".printf (cl.get_type_id (), cl.get_cname ());
			decl_frag.append (new CCodeMacroReplacement ("%s(obj)".printf (cl.get_upper_case_cname (null)), macro));

			macro = "(G_TYPE_CHECK_CLASS_CAST ((klass), %s, %sClass))".printf (cl.get_type_id (), cl.get_cname ());
			decl_frag.append (new CCodeMacroReplacement ("%s_CLASS(klass)".printf (cl.get_upper_case_cname (null)), macro));

			macro = "(G_TYPE_CHECK_INSTANCE_TYPE ((obj), %s))".printf (cl.get_type_id ());
			decl_frag.append (new CCodeMacroReplacement ("%s(obj)".printf (get_type_check_function (cl)), macro));

			macro = "(G_TYPE_CHECK_CLASS_TYPE ((klass), %s))".printf (cl.get_type_id ());
			decl_frag.append (new CCodeMacroReplacement ("%s_CLASS(klass)".printf (get_type_check_function (cl)), macro));

			macro = "(G_TYPE_INSTANCE_GET_CLASS ((obj), %s, %sClass))".printf (cl.get_type_id (), cl.get_cname ());
			decl_frag.append (new CCodeMacroReplacement ("%s_GET_CLASS(obj)".printf (cl.get_upper_case_cname (null)), macro));
			decl_frag.append (new CCodeNewline ());
		}


		if (cl.source_reference.file.cycle == null) {
			decl_frag.append (new CCodeTypeDefinition ("struct %s".printf (instance_struct.name), new CCodeVariableDeclarator (cl.get_cname ())));
		}

		if (cl.base_class != null) {
			instance_struct.add_field (cl.base_class.get_cname (), "parent_instance");
		} else if (is_fundamental) {
			instance_struct.add_field ("GTypeInstance", "parent_instance");
			instance_struct.add_field ("volatile int", "ref_count");
		}

		if (cl.is_compact && cl.base_class == null && cl.get_fields ().size == 0) {
			// add dummy member, C doesn't allow empty structs
			instance_struct.add_field ("int", "dummy");
		}

		if (is_gtypeinstance) {
			if (cl.source_reference.file.cycle == null) {
				decl_frag.append (new CCodeTypeDefinition ("struct %s".printf (type_struct.name), new CCodeVariableDeclarator ("%sClass".printf (cl.get_cname ()))));
			}
			decl_frag.append (new CCodeTypeDefinition ("struct %s".printf (instance_priv_struct.name), new CCodeVariableDeclarator ("%sPrivate".printf (cl.get_cname ()))));

			instance_struct.add_field ("%sPrivate *".printf (cl.get_cname ()), "priv");
			if (is_fundamental) {
				type_struct.add_field ("GTypeClass", "parent_class");
				type_struct.add_field ("void", "(*finalize) (%s *self)".printf (cl.get_cname ()));
			} else {
				type_struct.add_field ("%sClass".printf (cl.base_class.get_cname ()), "parent_class");
			}
		}

		if (cl.source_reference.comment != null) {
			def_frag.append (new CCodeComment (cl.source_reference.comment));
		}
		def_frag.append (instance_struct);

		if (is_gtypeinstance) {
			def_frag.append (type_struct);
			/* only add the *Private struct if it is not empty, i.e. we actually have private data */
			if (cl.has_private_fields || cl.get_type_parameters ().size > 0) {
				source_type_member_declaration.append (instance_priv_struct);
				var macro = "(G_TYPE_INSTANCE_GET_PRIVATE ((o), %s, %sPrivate))".printf (cl.get_type_id (), cl.get_cname ());
				source_type_member_declaration.append (new CCodeMacroReplacement ("%s_GET_PRIVATE(o)".printf (cl.get_upper_case_cname (null)), macro));
			}
			source_type_member_declaration.append (prop_enum);
		}

		cl.accept_children (codegen);

		if (is_gtypeinstance) {
			if (is_fundamental) {
				param_spec_struct = new CCodeStruct ( "_%sParamSpec%s".printf(cl.parent_symbol.get_cprefix (), cl.name));
				param_spec_struct.add_field ("GParamSpec", "parent_instance");
				def_frag.append (param_spec_struct);

				decl_frag.append (new CCodeTypeDefinition ("struct %s".printf (param_spec_struct.name), new CCodeVariableDeclarator ( "%sParamSpec%s".printf(cl.parent_symbol.get_cprefix (), cl.name))));


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
			} else if (is_gobject) {
				if (class_has_readable_properties (cl) || cl.get_type_parameters ().size > 0) {
					add_get_property_function (cl);
				}
				if (class_has_writable_properties (cl) || cl.get_type_parameters ().size > 0) {
					add_set_property_function (cl);
				}
			}
			add_class_init_function (cl);
			
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

			if (is_fundamental) {
				var ref_fun = new CCodeFunction (cl.get_lower_case_cprefix () + "ref", "gpointer");
				var unref_fun = new CCodeFunction (cl.get_lower_case_cprefix () + "unref", "void");
				if (cl.access == SymbolAccessibility.PRIVATE) {
					ref_fun.modifiers = CCodeModifiers.STATIC;
					unref_fun.modifiers = CCodeModifiers.STATIC;
				}

				ref_fun.add_parameter (new CCodeFormalParameter ("instance", "gpointer"));
				unref_fun.add_parameter (new CCodeFormalParameter ("instance", "gpointer"));

				if (cl.access != SymbolAccessibility.PRIVATE) {
					header_type_member_declaration.append (ref_fun.copy ());
					header_type_member_declaration.append (unref_fun.copy ());
				} else {
					source_type_member_declaration.append (ref_fun.copy ());
					source_type_member_declaration.append (unref_fun.copy ());
				}

				var ref_block = new CCodeBlock ();
				var unref_block = new CCodeBlock ();

				var cdecl = new CCodeDeclaration (cl.get_cname () + "*");
				cdecl.add_declarator (new CCodeVariableDeclarator.with_initializer ("self", new CCodeIdentifier ("instance")));
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

			if (cl.access != SymbolAccessibility.PRIVATE) {
				header_type_member_declaration.append (function.copy ());
			} else {
				source_type_member_declaration.append (function.copy ());
			}

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
		instance_struct = old_instance_struct;
		param_spec_struct = old_param_spec_struct;
		type_struct = old_type_struct;
		instance_priv_struct = old_instance_priv_struct;
		prop_enum = old_prop_enum;
		class_init_fragment = old_class_init_fragment;
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
		ctypedecl.add_declarator (new CCodeVariableDeclarator.with_initializer ("object_p", new CCodeMemberAccess (new CCodeIdentifier ("collect_values[0]"),"v_pointer")));
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
		ctypedecl.add_declarator (new CCodeVariableDeclarator.with_initializer ("object", collect_vpointer));
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
			source_type_member_declaration.append (function.copy ());
		} else {
			header_type_member_declaration.append (function.copy ());		
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
			source_type_member_declaration.append (function.copy ());
		} else {
			header_type_member_declaration.append (function.copy ());		
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
			source_type_member_declaration.append (function.copy ());
		} else {
			header_type_member_declaration.append (function.copy ());		
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
		source_type_member_declaration.append (parent_decl);
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

		if (cl.is_subtype_of (gobject_type)) {
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

			/* set finalize function */
			if (cl.get_fields ().size > 0 || cl.destructor != null) {
				var ccast = new CCodeFunctionCall (new CCodeIdentifier ("G_OBJECT_CLASS"));
				ccast.add_argument (new CCodeIdentifier ("klass"));
				init_block.add_statement (new CCodeExpressionStatement (new CCodeAssignment (new CCodeMemberAccess.pointer (ccast, "finalize"), new CCodeIdentifier ("%s_finalize".printf (cl.get_lower_case_cname (null))))));
			}
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
			CCodeExpression left = new CCodeMemberAccess (new CCodeIdentifier ("klass"),
			                                              field.get_cname (), true);
			CCodeExpression right = (CCodeExpression)field.initializer.ccodenode;
			CCodeAssignment assign = new CCodeAssignment (left, right);
			init_block.add_statement (new CCodeExpressionStatement (assign));
		}

		if (cl.is_subtype_of (gobject_type)) {
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

				instance_priv_struct.add_field ("GType", func_name);


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
				cspec.add_argument (new CCodeConstant ("G_PARAM_STATIC_NAME | G_PARAM_STATIC_NICK | G_PARAM_STATIC_BLURB | G_PARAM_WRITABLE | G_PARAM_CONSTRUCT_ONLY"));
				cinst.add_argument (cspec);
				init_block.add_statement (new CCodeExpressionStatement (cinst));
				prop_enum.add_value (new CCodeEnumValue (enum_value));

				instance_priv_struct.add_field ("GDestroyNotify", func_name);
			}

			/* create properties */
			var props = cl.get_properties ();
			foreach (Property prop in props) {
				// FIXME: omit real struct types for now since they cannot be expressed as gobject property yet
				if (prop.property_type.is_real_struct_type ()) {
					continue;
				}
				if (prop.access == SymbolAccessibility.PRIVATE) {
					// don't register private properties
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
		} else if (!cl.is_compact) {
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
			string cname = m.get_real_cname ();
			if (m.is_abstract || m.is_virtual) {
				// FIXME results in C compiler warning
				cname = m.get_cname ();
			}
			init_block.add_statement (new CCodeExpressionStatement (new CCodeAssignment (new CCodeMemberAccess.pointer (ciface, m.base_interface_method.vfunc_name), new CCodeIdentifier (cname))));
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
			source_type_member_declaration.append (instance_init.copy ());
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
	
	private void add_finalize_function (Class cl) {
		var function = new CCodeFunction ("%s_finalize".printf (cl.get_lower_case_cname (null)), "void");
		function.modifiers = CCodeModifiers.STATIC;

		var fundamental_class = cl;
		while (fundamental_class.base_class != null) {
			fundamental_class = fundamental_class.base_class;
		}

		function.add_parameter (new CCodeFormalParameter ("obj", fundamental_class.get_cname () + "*"));

		source_type_member_declaration.append (function.copy ());


		var cblock = new CCodeBlock ();

		CCodeFunctionCall ccall = new InstanceCast (new CCodeIdentifier ("obj"), cl);

		var cdecl = new CCodeDeclaration ("%s *".printf (cl.get_cname ()));
		cdecl.add_declarator (new CCodeVariableDeclarator.with_initializer ("self", ccall));
		
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
		
		var ccall = new InstanceCast (new CCodeIdentifier ("object"), cl);
		var cdecl = new CCodeDeclaration ("%s *".printf (cl.get_cname ()));
		cdecl.add_declarator (new CCodeVariableDeclarator.with_initializer ("self", ccall));
		block.add_statement (cdecl);
		
		var cswitch = new CCodeSwitchStatement (new CCodeIdentifier ("property_id"));
		var props = cl.get_properties ();
		foreach (Property prop in props) {
			// FIXME: omit real struct types for now since they cannot be expressed as gobject property yet
			if (prop.get_accessor == null || prop.is_abstract || prop.property_type.is_real_struct_type ()) {
				continue;
			}
			if (prop.access == SymbolAccessibility.PRIVATE) {
				// don't register private properties
				continue;
			}

			string prefix = cl.get_lower_case_cname (null);
			CCodeExpression cself = new CCodeIdentifier ("self");
			if (prop.base_property != null) {
				var base_type = (Class) prop.base_property.parent_symbol;
				prefix = base_type.get_lower_case_cname (null);
				cself = transform_expression (cself, new ObjectType (cl), new ObjectType (base_type));
			} else if (prop.base_interface_property != null) {
				var base_type = (Interface) prop.base_interface_property.parent_symbol;
				prefix = base_type.get_lower_case_cname (null);
				cself = transform_expression (cself, new ObjectType (cl), new ObjectType (base_type));
			}

			cswitch.add_statement (new CCodeCaseStatement (new CCodeIdentifier (prop.get_upper_case_cname ())));
			var ccall = new CCodeFunctionCall (new CCodeIdentifier ("%s_get_%s".printf (prefix, prop.name)));
			ccall.add_argument (cself);
			var csetcall = new CCodeFunctionCall ();
			csetcall.call = head.get_value_setter_function (prop.property_type);
			csetcall.add_argument (new CCodeIdentifier ("value"));
			csetcall.add_argument (ccall);
			cswitch.add_statement (new CCodeExpressionStatement (csetcall));
			cswitch.add_statement (new CCodeBreakStatement ());
		}
		cswitch.add_statement (new CCodeLabel ("default"));
		cswitch.add_statement (get_invalid_property_id_warn_statement ());
		cswitch.add_statement (new CCodeBreakStatement ());

		block.add_statement (cswitch);

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
		
		var ccall = new InstanceCast (new CCodeIdentifier ("object"), cl);
		var cdecl = new CCodeDeclaration ("%s *".printf (cl.get_cname ()));
		cdecl.add_declarator (new CCodeVariableDeclarator.with_initializer ("self", ccall));
		block.add_statement (cdecl);
		
		var cswitch = new CCodeSwitchStatement (new CCodeIdentifier ("property_id"));
		var props = cl.get_properties ();
		foreach (Property prop in props) {
			// FIXME: omit real struct types for now since they cannot be expressed as gobject property yet
			if (prop.set_accessor == null || prop.is_abstract || prop.property_type.is_real_struct_type ()) {
				continue;
			}
			if (prop.access == SymbolAccessibility.PRIVATE) {
				// don't register private properties
				continue;
			}

			string prefix = cl.get_lower_case_cname (null);
			CCodeExpression cself = new CCodeIdentifier ("self");
			if (prop.base_property != null) {
				var base_type = (Class) prop.base_property.parent_symbol;
				prefix = base_type.get_lower_case_cname (null);
				cself = transform_expression (cself, new ObjectType (cl), new ObjectType (base_type));
			} else if (prop.base_interface_property != null) {
				var base_type = (Interface) prop.base_interface_property.parent_symbol;
				prefix = base_type.get_lower_case_cname (null);
				cself = transform_expression (cself, new ObjectType (cl), new ObjectType (base_type));
			}

			cswitch.add_statement (new CCodeCaseStatement (new CCodeIdentifier (prop.get_upper_case_cname ())));
			var ccall = new CCodeFunctionCall (new CCodeIdentifier ("%s_set_%s".printf (prefix, prop.name)));
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
				cspec.call = new CCodeIdentifier ( param_spec_name );
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
				cspec.call = new CCodeIdentifier ("g_param_spec_pointer");
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
		cvalueset.add_argument (value);
		ccomma.append_expression (cvalueset);
		
		// move pointer to next parameter in array
		ccomma.append_expression (new CCodeUnaryExpression (CCodeUnaryOperator.POSTFIX_INCREMENT, cpointer));

		return ccomma;
	}

	public override void visit_constructor (Constructor c) {
		current_method_inner_error = false;
		in_constructor = true;

		if (c.binding == MemberBinding.CLASS || c.binding == MemberBinding.STATIC) {
			in_static_or_class_ctor = true;
		}
		c.accept_children (codegen);
		in_static_or_class_ctor = false;

		in_constructor = false;

		var cl = (Class) c.parent_symbol;

		if (c.binding == MemberBinding.INSTANCE) {
			function = new CCodeFunction ("%s_constructor".printf (cl.get_lower_case_cname (null)), "GObject *");
			function.modifiers = CCodeModifiers.STATIC;
		
			function.add_parameter (new CCodeFormalParameter ("type", "GType"));
			function.add_parameter (new CCodeFormalParameter ("n_construct_properties", "guint"));
			function.add_parameter (new CCodeFormalParameter ("construct_properties", "GObjectConstructParam *"));
		
			source_type_member_declaration.append (function.copy ());


			var cblock = new CCodeBlock ();
			var cdecl = new CCodeDeclaration ("GObject *");
			cdecl.add_declarator (new CCodeVariableDeclarator ("obj"));
			cblock.add_statement (cdecl);

			cdecl = new CCodeDeclaration ("%sClass *".printf (cl.get_cname ()));
			cdecl.add_declarator (new CCodeVariableDeclarator ("klass"));
			cblock.add_statement (cdecl);

			cdecl = new CCodeDeclaration ("GObjectClass *");
			cdecl.add_declarator (new CCodeVariableDeclarator ("parent_class"));
			cblock.add_statement (cdecl);


			var ccall = new CCodeFunctionCall (new CCodeIdentifier ("g_type_class_peek"));
			ccall.add_argument (new CCodeIdentifier (cl.get_type_id ()));
			var ccast = new CCodeFunctionCall (new CCodeIdentifier ("%s_CLASS".printf (cl.get_upper_case_cname (null))));
			ccast.add_argument (ccall);
			cblock.add_statement (new CCodeExpressionStatement (new CCodeAssignment (new CCodeIdentifier ("klass"), ccast)));

			ccall = new CCodeFunctionCall (new CCodeIdentifier ("g_type_class_peek_parent"));
			ccall.add_argument (new CCodeIdentifier ("klass"));
			ccast = new CCodeFunctionCall (new CCodeIdentifier ("G_OBJECT_CLASS"));
			ccast.add_argument (ccall);
			cblock.add_statement (new CCodeExpressionStatement (new CCodeAssignment (new CCodeIdentifier ("parent_class"), ccast)));

		
			ccall = new CCodeFunctionCall (new CCodeMemberAccess.pointer (new CCodeIdentifier ("parent_class"), "constructor"));
			ccall.add_argument (new CCodeIdentifier ("type"));
			ccall.add_argument (new CCodeIdentifier ("n_construct_properties"));
			ccall.add_argument (new CCodeIdentifier ("construct_properties"));
			cblock.add_statement (new CCodeExpressionStatement (new CCodeAssignment (new CCodeIdentifier ("obj"), ccall)));


			ccall = new InstanceCast (new CCodeIdentifier ("obj"), cl);

			cdecl = new CCodeDeclaration ("%s *".printf (cl.get_cname ()));
			cdecl.add_declarator (new CCodeVariableDeclarator.with_initializer ("self", ccall));
		
			cblock.add_statement (cdecl);

			if (current_method_inner_error) {
				/* always separate error parameter and inner_error local variable
				 * as error may be set to NULL but we're always interested in inner errors
				 */
				var cdecl = new CCodeDeclaration ("GError *");
				cdecl.add_declarator (new CCodeVariableDeclarator.with_initializer ("inner_error", new CCodeConstant ("NULL")));
				cblock.add_statement (cdecl);
			}


			cblock.add_statement (c.body.ccodenode);
		
			cblock.add_statement (new CCodeReturnStatement (new CCodeIdentifier ("obj")));
		
			function.block = cblock;

			if (c.source_reference.comment != null) {
				source_type_member_definition.append (new CCodeComment (c.source_reference.comment));
			}
			source_type_member_definition.append (function);
		} else if (c.binding == MemberBinding.CLASS) {
			// class constructor

			var base_init = new CCodeFunction ("%s_base_init".printf (cl.get_lower_case_cname (null)), "void");
			base_init.add_parameter (new CCodeFormalParameter ("klass", "%sClass *".printf (cl.get_cname ())));
			base_init.modifiers = CCodeModifiers.STATIC;

			source_type_member_declaration.append (base_init.copy ());

			var block = (CCodeBlock) c.body.ccodenode;
			if (current_method_inner_error) {
				/* always separate error parameter and inner_error local variable
				 * as error may be set to NULL but we're always interested in inner errors
				 */
				var cdecl = new CCodeDeclaration ("GError *");
				cdecl.add_declarator (new CCodeVariableDeclarator.with_initializer ("inner_error", new CCodeConstant ("NULL")));
				block.prepend_statement (cdecl);
			}

			base_init.block = block;
		
			source_type_member_definition.append (base_init);
		} else if (c.binding == MemberBinding.STATIC) {
			// static class constructor
			// add to class_init

			if (current_method_inner_error) {
				/* always separate error parameter and inner_error local variable
				 * as error may be set to NULL but we're always interested in inner errors
				 */
				var cdecl = new CCodeDeclaration ("GError *");
				cdecl.add_declarator (new CCodeVariableDeclarator.with_initializer ("inner_error", new CCodeConstant ("NULL")));
				class_init_fragment.append (cdecl);
			}

			class_init_fragment.append (c.body.ccodenode);
		} else {
			Report.error (c.source_reference, "internal error: constructors must have instance, class, or static binding");
		}
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
		source_type_member_declaration.append (func.copy ());

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
		source_type_member_declaration.append (func.copy ());

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
		source_type_member_declaration.append (func.copy ());

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
}

