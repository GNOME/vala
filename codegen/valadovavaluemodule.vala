/* valadovavaluemodule.vala
 *
 * Copyright (C) 2009-2010  Jürg Billeter
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

internal class Vala.DovaValueModule : DovaObjectModule {
	public DovaValueModule (CCodeGenerator codegen, CCodeModule? next) {
		base (codegen, next);
	}

	public override void visit_creation_method (CreationMethod m) {
		if (current_type_symbol is Class &&
		    (current_class.base_class == null ||
		     current_class.base_class.get_full_name () != "Dova.Value")) {
			base.visit_creation_method (m);
			return;
		}

		visit_method (m);
	}

	public override void generate_struct_declaration (Struct st, CCodeDeclarationSpace decl_space) {
		base.generate_struct_declaration (st, decl_space);

		if (decl_space.add_symbol_declaration (st, st.get_copy_function ())) {
			return;
		}

		generate_class_declaration (type_class, decl_space);

		var type_fun = new CCodeFunction ("%s_type_get".printf (st.get_lower_case_cname ()), "DovaType *");
		if (st.is_internal_symbol ()) {
			type_fun.modifiers = CCodeModifiers.STATIC;
		}
		decl_space.add_type_member_declaration (type_fun);

		var type_init_fun = new CCodeFunction ("%s_type_init".printf (st.get_lower_case_cname ()));
		type_init_fun.add_parameter (new CCodeFormalParameter ("type", "DovaType *"));
		if (st.is_internal_symbol ()) {
			type_init_fun.modifiers = CCodeModifiers.STATIC;
		}
		decl_space.add_type_member_declaration (type_init_fun);

		var function = new CCodeFunction (st.get_copy_function (), "void");
		if (st.is_internal_symbol ()) {
			function.modifiers = CCodeModifiers.STATIC;
		}

		function.add_parameter (new CCodeFormalParameter ("dest", st.get_cname () + "*"));
		function.add_parameter (new CCodeFormalParameter ("dest_index", "int32_t"));
		function.add_parameter (new CCodeFormalParameter ("src", st.get_cname () + "*"));
		function.add_parameter (new CCodeFormalParameter ("src_index", "int32_t"));

		decl_space.add_type_member_declaration (function);

		add_value_assert (st, decl_space);
	}

	void add_value_assert (TypeSymbol sym, CCodeDeclarationSpace decl_space) {
		string cname = sym.get_cname ();
		if (sym is Class) {
			cname += "*";
		}

		string assert_body;
		var compare_method = sym.scope.lookup ("compare") as Method;
		if (compare_method != null) {
			assert_body = "do { %s __v1 = (v1); %s __v2 = (v2); if (%s (__v1, __v2) cmp 0); else dova_assert_compare (string_create_from_cstring (#v1 \" \" #cmp \" \" #v2), %s_to_string (v1), string_create_from_cstring (#cmp), %s_to_string (v2)); } while (0)".printf (cname, cname, compare_method.get_cname (), sym.get_lower_case_cname (), sym.get_lower_case_cname ());
		} else {
			assert_body = "do { %s __v1 = (v1); %s __v2 = (v2); if (__v1 cmp __v2); else dova_assert_compare (string_create_from_cstring (#v1 \" \" #cmp \" \" #v2), %s_to_string (v1), string_create_from_cstring (#cmp), %s_to_string (v2)); } while (0)".printf (cname, cname, sym.get_lower_case_cname (), sym.get_lower_case_cname ());
		}
		var assert_macro = new CCodeMacroReplacement ("%s_assert(v1, cmp, v2)".printf (sym.get_lower_case_cname ()), assert_body);
		decl_space.add_type_member_declaration (assert_macro);
	}

	public override void visit_struct (Struct st) {
		base.visit_struct (st);

		var cdecl = new CCodeDeclaration ("int");
		cdecl.add_declarator (new CCodeVariableDeclarator ("_%s_object_offset".printf (st.get_lower_case_cname ()), new CCodeConstant ("0")));
		cdecl.modifiers = CCodeModifiers.STATIC;
		source_declarations.add_type_member_declaration (cdecl);

		string macro = "((%s *) (((char *) o) + _%s_object_offset))".printf (st.get_cname (), st.get_lower_case_cname ());
		source_declarations.add_type_member_declaration (new CCodeMacroReplacement ("%s_GET_PRIVATE(o)".printf (st.get_upper_case_cname (null)), macro));


		cdecl = new CCodeDeclaration ("DovaType *");
		cdecl.add_declarator (new CCodeVariableDeclarator ("%s_type".printf (st.get_lower_case_cname ()), new CCodeConstant ("NULL")));
		cdecl.modifiers = CCodeModifiers.STATIC;
		source_declarations.add_type_member_declaration (cdecl);

		var type_fun = new CCodeFunction ("%s_type_get".printf (st.get_lower_case_cname ()), "DovaType *");
		type_fun.block = new CCodeBlock ();

		var type_init_block = new CCodeBlock ();

		generate_method_declaration ((Method) object_class.scope.lookup ("alloc"), source_declarations);
		generate_property_accessor_declaration (((Property) type_class.scope.lookup ("base_type")).get_accessor, source_declarations);
		generate_property_accessor_declaration (((Property) type_class.scope.lookup ("base_type")).set_accessor, source_declarations);
		generate_property_accessor_declaration (((Property) type_class.scope.lookup ("object_size")).get_accessor, source_declarations);
		generate_property_accessor_declaration (((Property) type_class.scope.lookup ("object_size")).set_accessor, source_declarations);
		generate_property_accessor_declaration (((Property) type_class.scope.lookup ("type_size")).get_accessor, source_declarations);
		generate_property_accessor_declaration (((Property) type_class.scope.lookup ("type_size")).set_accessor, source_declarations);
		generate_property_accessor_declaration (((Property) type_class.scope.lookup ("value_size")).set_accessor, source_declarations);

		generate_class_declaration ((Class) context.root.scope.lookup ("Dova").scope.lookup ("Value"), source_declarations);

		var base_type = new CCodeFunctionCall (new CCodeIdentifier ("dova_value_type_get"));

		var base_type_size = new CCodeFunctionCall (new CCodeIdentifier ("dova_type_get_type_size"));
		base_type_size.add_argument (base_type);

		var calloc_call = new CCodeFunctionCall (new CCodeIdentifier ("calloc"));
		calloc_call.add_argument (new CCodeConstant ("1"));
		calloc_call.add_argument (base_type_size);

		type_init_block.add_statement (new CCodeExpressionStatement (new CCodeAssignment (new CCodeIdentifier ("%s_type".printf (st.get_lower_case_cname ())), calloc_call)));

		generate_class_declaration ((Class) object_class, source_declarations);

		type_init_block.add_statement (new CCodeExpressionStatement (new CCodeAssignment (new CCodeMemberAccess.pointer (new CCodeCastExpression (new CCodeIdentifier ("%s_type".printf (st.get_lower_case_cname ())), "DovaObject *"), "type"), new CCodeFunctionCall (new CCodeIdentifier ("dova_type_type_get")))));

		var set_base_type = new CCodeFunctionCall (new CCodeIdentifier ("dova_type_set_base_type"));
		set_base_type.add_argument (new CCodeIdentifier ("%s_type".printf (st.get_lower_case_cname ())));
		set_base_type.add_argument (base_type);
		type_init_block.add_statement (new CCodeExpressionStatement (set_base_type));

		var base_size = new CCodeFunctionCall (new CCodeIdentifier ("dova_type_get_object_size"));
		base_size.add_argument (base_type);

		type_init_block.add_statement (new CCodeExpressionStatement (new CCodeAssignment (new CCodeIdentifier ("_%s_object_offset".printf (st.get_lower_case_cname ())), base_size)));

		var sizeof_call = new CCodeFunctionCall (new CCodeIdentifier ("sizeof"));
		sizeof_call.add_argument (new CCodeIdentifier (st.get_cname ()));
		var set_size = new CCodeFunctionCall (new CCodeIdentifier ("dova_type_set_object_size"));
		set_size.add_argument (new CCodeIdentifier ("%s_type".printf (st.get_lower_case_cname ())));
		set_size.add_argument (new CCodeBinaryExpression (CCodeBinaryOperator.PLUS, base_size, sizeof_call));
		type_init_block.add_statement (new CCodeExpressionStatement (set_size));

		set_size = new CCodeFunctionCall (new CCodeIdentifier ("dova_type_set_value_size"));
		set_size.add_argument (new CCodeIdentifier ("%s_type".printf (st.get_lower_case_cname ())));
		set_size.add_argument (sizeof_call);
		type_init_block.add_statement (new CCodeExpressionStatement (set_size));

		set_size = new CCodeFunctionCall (new CCodeIdentifier ("dova_type_set_type_size"));
		set_size.add_argument (new CCodeIdentifier ("%s_type".printf (st.get_lower_case_cname ())));
		set_size.add_argument (base_type_size);
		type_init_block.add_statement (new CCodeExpressionStatement (set_size));

		var type_init_call = new CCodeFunctionCall (new CCodeIdentifier ("%s_type_init".printf (st.get_lower_case_cname ())));
		type_init_call.add_argument (new CCodeIdentifier ("%s_type".printf (st.get_lower_case_cname ())));
		type_init_block.add_statement (new CCodeExpressionStatement (type_init_call));

		// workaround: set value_size again as it is currently overwritten by dova_object_type_init
		set_size = new CCodeFunctionCall (new CCodeIdentifier ("dova_type_set_value_size"));
		set_size.add_argument (new CCodeIdentifier ("%s_type".printf (st.get_lower_case_cname ())));
		set_size.add_argument (sizeof_call);
		type_init_block.add_statement (new CCodeExpressionStatement (set_size));

		type_fun.block.add_statement (new CCodeIfStatement (new CCodeUnaryExpression (CCodeUnaryOperator.LOGICAL_NEGATION, new CCodeIdentifier ("%s_type".printf (st.get_lower_case_cname ()))), type_init_block));

		type_fun.block.add_statement (new CCodeReturnStatement (new CCodeIdentifier ("%s_type".printf (st.get_lower_case_cname ()))));

		source_type_member_definition.append (type_fun);

		var type_init_fun = new CCodeFunction ("%s_type_init".printf (st.get_lower_case_cname ()));
		type_init_fun.add_parameter (new CCodeFormalParameter ("type", "DovaType *"));
		type_init_fun.block = new CCodeBlock ();

		type_init_call = new CCodeFunctionCall (new CCodeIdentifier ("dova_value_type_init"));
		type_init_call.add_argument (new CCodeIdentifier ("type"));
		type_init_fun.block.add_statement (new CCodeExpressionStatement (type_init_call));

		declare_set_value_copy_function (source_declarations);

		var value_copy_call = new CCodeFunctionCall (new CCodeIdentifier ("dova_type_set_value_copy"));
		value_copy_call.add_argument (new CCodeIdentifier ("type"));
		value_copy_call.add_argument (new CCodeCastExpression (new CCodeIdentifier ("%s_copy".printf (st.get_lower_case_cname ())), "void (*)(void *, int32_t,  void *, int32_t)"));
		type_init_fun.block.add_statement (new CCodeExpressionStatement (value_copy_call));

		if (st.scope.lookup ("equals") is Method) {
			var value_equals_fun = new CCodeFunction ("%s_value_equals".printf (st.get_lower_case_cname ()), "bool");
			value_equals_fun.modifiers = CCodeModifiers.STATIC;
			value_equals_fun.add_parameter (new CCodeFormalParameter ("value", st.get_cname () + "*"));
			value_equals_fun.add_parameter (new CCodeFormalParameter ("value_index", "int32_t"));
			value_equals_fun.add_parameter (new CCodeFormalParameter ("other", st.get_cname () + "*"));
			value_equals_fun.add_parameter (new CCodeFormalParameter ("other_index", "int32_t"));
			value_equals_fun.block = new CCodeBlock ();
			var val = new CCodeBinaryExpression (CCodeBinaryOperator.PLUS, new CCodeIdentifier ("value"), new CCodeIdentifier ("value_index"));
			var other = new CCodeBinaryExpression (CCodeBinaryOperator.PLUS, new CCodeIdentifier ("other"), new CCodeIdentifier ("other_index"));
			var ccall = new CCodeFunctionCall (new CCodeIdentifier ("%s_equals".printf (st.get_lower_case_cname ())));
			ccall.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.POINTER_INDIRECTION, val));
			ccall.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.POINTER_INDIRECTION, other));
			value_equals_fun.block.add_statement (new CCodeReturnStatement (ccall));
			source_type_member_definition.append (value_equals_fun);

			declare_set_value_equals_function (source_declarations);

			var value_equals_call = new CCodeFunctionCall (new CCodeIdentifier ("dova_type_set_value_equals"));
			value_equals_call.add_argument (new CCodeIdentifier ("type"));
			value_equals_call.add_argument (new CCodeCastExpression (new CCodeIdentifier ("%s_value_equals".printf (st.get_lower_case_cname ())), "bool (*)(void *, int32_t,  void *, int32_t)"));
			type_init_fun.block.add_statement (new CCodeExpressionStatement (value_equals_call));
		}

		if (st.scope.lookup ("hash") is Method) {
			var value_hash_fun = new CCodeFunction ("%s_value_hash".printf (st.get_lower_case_cname ()), "uint32_t");
			value_hash_fun.modifiers = CCodeModifiers.STATIC;
			value_hash_fun.add_parameter (new CCodeFormalParameter ("value", st.get_cname () + "*"));
			value_hash_fun.add_parameter (new CCodeFormalParameter ("value_index", "int32_t"));
			value_hash_fun.block = new CCodeBlock ();
			var val = new CCodeBinaryExpression (CCodeBinaryOperator.PLUS, new CCodeIdentifier ("value"), new CCodeIdentifier ("value_index"));
			var ccall = new CCodeFunctionCall (new CCodeIdentifier ("%s_hash".printf (st.get_lower_case_cname ())));
			ccall.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.POINTER_INDIRECTION, val));
			value_hash_fun.block.add_statement (new CCodeReturnStatement (ccall));
			source_type_member_definition.append (value_hash_fun);

			declare_set_value_hash_function (source_declarations);

			var value_hash_call = new CCodeFunctionCall (new CCodeIdentifier ("dova_type_set_value_hash"));
			value_hash_call.add_argument (new CCodeIdentifier ("type"));
			value_hash_call.add_argument (new CCodeCastExpression (new CCodeIdentifier ("%s_value_hash".printf (st.get_lower_case_cname ())), "uint32_t (*)(void *, int32_t)"));
			type_init_fun.block.add_statement (new CCodeExpressionStatement (value_hash_call));
		}

		// generate method to box values
		var value_to_any_fun = new CCodeFunction ("%s_value_to_any".printf (st.get_lower_case_cname ()), "DovaObject*");
		value_to_any_fun.modifiers = CCodeModifiers.STATIC;
		value_to_any_fun.add_parameter (new CCodeFormalParameter ("value", "void *"));
		value_to_any_fun.add_parameter (new CCodeFormalParameter ("value_index", "int32_t"));
		value_to_any_fun.block = new CCodeBlock ();
		var alloc_call = new CCodeFunctionCall (new CCodeIdentifier ("dova_object_alloc"));
		alloc_call.add_argument (new CCodeFunctionCall (new CCodeIdentifier ("%s_type_get".printf (st.get_lower_case_cname ()))));
		cdecl = new CCodeDeclaration ("DovaObject *");
		cdecl.add_declarator (new CCodeVariableDeclarator ("result", alloc_call));
		value_to_any_fun.block.add_statement (cdecl);
		var priv_call = new CCodeFunctionCall (new CCodeIdentifier ("%s_GET_PRIVATE".printf (st.get_upper_case_cname (null))));
		priv_call.add_argument (new CCodeIdentifier ("result"));
		var copy_call = new CCodeFunctionCall (new CCodeIdentifier ("%s_copy".printf (st.get_lower_case_cname ())));
		copy_call.add_argument (priv_call);
		copy_call.add_argument (new CCodeConstant ("0"));
		copy_call.add_argument (new CCodeIdentifier ("value"));
		copy_call.add_argument (new CCodeIdentifier ("value_index"));
		value_to_any_fun.block.add_statement (new CCodeExpressionStatement (copy_call));
		value_to_any_fun.block.add_statement (new CCodeReturnStatement (new CCodeIdentifier ("result")));
		source_type_member_definition.append (value_to_any_fun);

		declare_set_value_to_any_function (source_declarations);

		var value_to_any_call = new CCodeFunctionCall (new CCodeIdentifier ("dova_type_set_value_to_any"));
		value_to_any_call.add_argument (new CCodeIdentifier ("type"));
		value_to_any_call.add_argument (new CCodeIdentifier ("%s_value_to_any".printf (st.get_lower_case_cname ())));
		type_init_fun.block.add_statement (new CCodeExpressionStatement (value_to_any_call));

		// generate method to unbox values
		var value_from_any_fun = new CCodeFunction ("%s_value_from_any".printf (st.get_lower_case_cname ()));
		value_from_any_fun.modifiers = CCodeModifiers.STATIC;
		value_from_any_fun.add_parameter (new CCodeFormalParameter ("any_", "any *"));
		value_from_any_fun.add_parameter (new CCodeFormalParameter ("value", st.get_cname () + "*"));
		value_from_any_fun.add_parameter (new CCodeFormalParameter ("value_index", "int32_t"));
		value_from_any_fun.block = new CCodeBlock ();
		priv_call = new CCodeFunctionCall (new CCodeIdentifier ("%s_GET_PRIVATE".printf (st.get_upper_case_cname (null))));
		priv_call.add_argument (new CCodeIdentifier ("any_"));
		copy_call = new CCodeFunctionCall (new CCodeIdentifier ("%s_copy".printf (st.get_lower_case_cname ())));
		copy_call.add_argument (new CCodeIdentifier ("value"));
		copy_call.add_argument (new CCodeIdentifier ("value_index"));
		copy_call.add_argument (priv_call);
		copy_call.add_argument (new CCodeConstant ("0"));
		value_from_any_fun.block.add_statement (new CCodeExpressionStatement (copy_call));
		source_type_member_definition.append (value_from_any_fun);

		declare_set_value_from_any_function (source_declarations);

		var value_from_any_call = new CCodeFunctionCall (new CCodeIdentifier ("dova_type_set_value_from_any"));
		value_from_any_call.add_argument (new CCodeIdentifier ("type"));
		value_from_any_call.add_argument (new CCodeIdentifier ("%s_value_from_any".printf (st.get_lower_case_cname ())));
		type_init_fun.block.add_statement (new CCodeExpressionStatement (value_from_any_call));

		source_type_member_definition.append (type_init_fun);

		add_struct_copy_function (st);
	}

	void add_struct_copy_function (Struct st) {
		var function = new CCodeFunction (st.get_copy_function (), "void");
		if (st.is_internal_symbol ()) {
			function.modifiers = CCodeModifiers.STATIC;
		}

		function.add_parameter (new CCodeFormalParameter ("dest", st.get_cname () + "*"));
		function.add_parameter (new CCodeFormalParameter ("dest_index", "int32_t"));
		function.add_parameter (new CCodeFormalParameter ("src", st.get_cname () + "*"));
		function.add_parameter (new CCodeFormalParameter ("src_index", "int32_t"));

		var cblock = new CCodeBlock ();
		var cfrag = new CCodeFragment ();
		cblock.add_statement (cfrag);

		var dest = new CCodeBinaryExpression (CCodeBinaryOperator.PLUS, new CCodeIdentifier ("dest"), new CCodeIdentifier ("dest_index"));
		var src = new CCodeBinaryExpression (CCodeBinaryOperator.PLUS, new CCodeIdentifier ("src"), new CCodeIdentifier ("src_index"));

		foreach (var f in st.get_fields ()) {
			if (f.binding == MemberBinding.INSTANCE) {
				var field = new CCodeMemberAccess.pointer (dest, f.name);

				var array_type = f.field_type as ArrayType;
				if (array_type != null && array_type.fixed_length) {
					for (int i = 0; i < array_type.length; i++) {
						var element = new CCodeElementAccess (field, new CCodeConstant (i.to_string ()));

						if (requires_destroy (array_type.element_type))  {
							cblock.add_statement (new CCodeExpressionStatement (get_unref_expression (element, array_type.element_type)));
						}
					}
					continue;
				}

				if (requires_destroy (f.field_type))  {
					var this_access = new MemberAccess.simple ("this");
					this_access.value_type = get_data_type_for_symbol ((TypeSymbol) f.parent_symbol);
					this_access.ccodenode = new CCodeUnaryExpression (CCodeUnaryOperator.POINTER_INDIRECTION, dest);
					var ma = new MemberAccess (this_access, f.name);
					ma.symbol_reference = f;
					ma.value_type = f.field_type.copy ();
					cblock.add_statement (new CCodeExpressionStatement (get_unref_expression (field, f.field_type, ma)));
				}
			}
		}

		var copy_block = new CCodeBlock ();

		if (st.get_fields ().size == 0) {
			copy_block.add_statement (new CCodeExpressionStatement (new CCodeAssignment (new CCodeUnaryExpression (CCodeUnaryOperator.POINTER_INDIRECTION, dest), new CCodeUnaryExpression (CCodeUnaryOperator.POINTER_INDIRECTION, src))));
		} else {
			foreach (var f in st.get_fields ()) {
				if (f.binding == MemberBinding.INSTANCE) {
					CCodeExpression copy = new CCodeMemberAccess.pointer (src, f.name);
					var dest_field = new CCodeMemberAccess.pointer (dest, f.name);

					var array_type = f.field_type as ArrayType;
					if (array_type != null && array_type.fixed_length) {
						for (int i = 0; i < array_type.length; i++) {
							CCodeExpression copy_element = new CCodeElementAccess (copy, new CCodeConstant (i.to_string ()));
							var dest_field_element = new CCodeElementAccess (dest_field, new CCodeConstant (i.to_string ()));

							if (requires_copy (array_type.element_type))  {
								copy_element = get_ref_cexpression (array_type.element_type, copy_element, null, f);
							}

							copy_block.add_statement (new CCodeExpressionStatement (new CCodeAssignment (dest_field_element, copy_element)));
						}
						continue;
					}

					if (requires_copy (f.field_type))  {
						var this_access = new MemberAccess.simple ("this");
						this_access.value_type = get_data_type_for_symbol ((TypeSymbol) f.parent_symbol);
						this_access.ccodenode = new CCodeUnaryExpression (CCodeUnaryOperator.POINTER_INDIRECTION, src);
						var ma = new MemberAccess (this_access, f.name);
						ma.symbol_reference = f;
						copy = get_ref_cexpression (f.field_type, copy, ma, f);
					}

					copy_block.add_statement (new CCodeExpressionStatement (new CCodeAssignment (dest_field, copy)));
				}
			}
		}

		cblock.add_statement (new CCodeIfStatement (new CCodeIdentifier ("src"), copy_block));

		append_temp_decl (cfrag, temp_vars);
		temp_vars.clear ();

		function.block = cblock;

		source_type_member_definition.append (function);
	}

	public override void visit_assignment (Assignment assignment) {
		var generic_type = assignment.left.value_type as GenericType;
		if (generic_type == null) {
			base.visit_assignment (assignment);
			return;
		}

		var dest = assignment.left;
		CCodeExpression cdest;
		CCodeExpression dest_index = new CCodeConstant ("0");
		var src = assignment.right;
		CCodeExpression csrc;
		CCodeExpression src_index = new CCodeConstant ("0");

		if (src is NullLiteral) {
			// TODO destroy dest
			assignment.ccodenode = new CCodeConstant ("0");
			return;
		}

		var dest_ea = dest as ElementAccess;
		var src_ea = src as ElementAccess;

		if (dest_ea != null) {
			dest = dest_ea.container;

			var array_type = dest.value_type as ArrayType;
			if (array_type != null && !array_type.inline_allocated) {
				generate_property_accessor_declaration (((Property) array_class.scope.lookup ("data")).get_accessor, source_declarations);

				var data_call = new CCodeFunctionCall (new CCodeIdentifier ("dova_array_get_data"));
				data_call.add_argument ((CCodeExpression) get_ccodenode (dest));
				cdest = data_call;
			} else {
				cdest = (CCodeExpression) get_ccodenode (dest);
			}
			dest_index = (CCodeExpression) get_ccodenode (dest_ea.get_indices ().get (0));
		} else {
			cdest = (CCodeExpression) get_ccodenode (dest);
		}

		if (src_ea != null) {
			src = src_ea.container;

			var array_type = src.value_type as ArrayType;
			if (array_type != null && !array_type.inline_allocated) {
				generate_property_accessor_declaration (((Property) array_class.scope.lookup ("data")).get_accessor, source_declarations);

				var data_call = new CCodeFunctionCall (new CCodeIdentifier ("dova_array_get_data"));
				data_call.add_argument ((CCodeExpression) get_ccodenode (src));
				csrc = data_call;
			} else {
				csrc = (CCodeExpression) get_ccodenode (src);
			}
			src_index = (CCodeExpression) get_ccodenode (src_ea.get_indices ().get (0));
		} else {
			csrc = (CCodeExpression) get_ccodenode (src);
		}

		var ccall = new CCodeFunctionCall (new CCodeIdentifier ("dova_type_value_copy"));
		if (generic_type.type_parameter.parent_symbol is TypeSymbol) {
			// generic type
			ccall.add_argument (new CCodeMemberAccess.pointer (get_type_private_from_type ((ObjectTypeSymbol) generic_type.type_parameter.parent_symbol, new CCodeMemberAccess.pointer (new CCodeIdentifier ("this"), "type")), "%s_type".printf (generic_type.type_parameter.name.down ())));
		} else {
			// generic method
			ccall.add_argument (new CCodeIdentifier ("%s_type".printf (generic_type.type_parameter.name.down ())));
		}
		ccall.add_argument (cdest);
		ccall.add_argument (dest_index);
		ccall.add_argument (csrc);
		ccall.add_argument (src_index);
		assignment.ccodenode = ccall;
	}

	public override void visit_binary_expression (BinaryExpression expr) {
		var generic_type = expr.left.value_type as GenericType;
		if (generic_type == null) {
			base.visit_binary_expression (expr);
			return;
		}

		CCodeExpression cleft;
		CCodeExpression left_index = new CCodeConstant ("0");
		CCodeExpression cright;
		CCodeExpression right_index = new CCodeConstant ("0");

		var left_ea = expr.left as ElementAccess;
		var right_ea = expr.right as ElementAccess;

		if (left_ea != null) {
			generate_property_accessor_declaration (((Property) array_class.scope.lookup ("data")).get_accessor, source_declarations);

			var data_call = new CCodeFunctionCall (new CCodeIdentifier ("dova_array_get_data"));
			data_call.add_argument ((CCodeExpression) get_ccodenode (left_ea.container));
			cleft = data_call;
			left_index = (CCodeExpression) get_ccodenode (left_ea.get_indices ().get (0));
		} else {
			cleft = (CCodeExpression) get_ccodenode (expr.left);
		}

		if (right_ea != null) {
			generate_property_accessor_declaration (((Property) array_class.scope.lookup ("data")).get_accessor, source_declarations);

			var data_call = new CCodeFunctionCall (new CCodeIdentifier ("dova_array_get_data"));
			data_call.add_argument ((CCodeExpression) get_ccodenode (right_ea.container));
			cright = data_call;
			right_index = (CCodeExpression) get_ccodenode (right_ea.get_indices ().get (0));
		} else {
			cright = (CCodeExpression) get_ccodenode (expr.right);
		}

		var ccall = new CCodeFunctionCall (new CCodeIdentifier ("dova_type_value_equals"));
		ccall.add_argument (get_type_id_expression (generic_type));
		ccall.add_argument (cleft);
		ccall.add_argument (left_index);
		ccall.add_argument (cright);
		ccall.add_argument (right_index);

		if (expr.operator == BinaryOperator.EQUALITY) {
			expr.ccodenode = ccall;
		} else {
			expr.ccodenode = new CCodeUnaryExpression (CCodeUnaryOperator.LOGICAL_NEGATION, ccall);
		}
	}

	bool is_comparison (Expression expr) {
		var binary_expression = expr as BinaryExpression;
		if (binary_expression != null) {
			switch (binary_expression.operator) {
			case BinaryOperator.LESS_THAN:
			case BinaryOperator.GREATER_THAN:
			case BinaryOperator.LESS_THAN_OR_EQUAL:
			case BinaryOperator.GREATER_THAN_OR_EQUAL:
			case BinaryOperator.EQUALITY:
			case BinaryOperator.INEQUALITY:
				return true;
			default:
				return false;
			}
		}
		return false;
	}

	bool handle_assert (MethodCall expr) {
		var args = expr.get_argument_list ();
		var mtype = expr.call.value_type as MethodType;
		if (mtype == null || mtype.method_symbol.get_cname () != "dova_assert" ||
		    !(args.get (1) is NullLiteral) ||
		    !is_comparison (args.get (0))) {
			return false;
		}

		expr.accept_children (codegen);

		var binary_expression = (BinaryExpression) args.get (0);
		var op1 = binary_expression.left;
		var op2 = binary_expression.right;

		var type = op1.value_type.data_type;

		var ccall = new CCodeFunctionCall (new CCodeIdentifier ("%s_assert".printf (type.get_lower_case_cname ())));
		ccall.add_argument ((CCodeExpression) get_ccodenode (op1));
		ccall.add_argument (new CCodeConstant (binary_expression.get_operator_string ()));
		ccall.add_argument ((CCodeExpression) get_ccodenode (op2));
		expr.ccodenode = ccall;

		return true;
	}

	public override void visit_method_call (MethodCall expr) {
		if (handle_assert (expr)) {
			return;
		}

		var ma = expr.call as MemberAccess;
		if (ma == null || ma.inner == null || !(ma.inner.value_type is GenericType)) {
			base.visit_method_call (expr);
			return;
		}

		// handle method calls on generic types

		expr.accept_children (codegen);

		if (ma.member_name == "hash") {
			var val = ma.inner;
			CCodeExpression cval;
			CCodeExpression val_index = new CCodeConstant ("0");

			var val_ea = val as ElementAccess;
			if (val_ea != null) {
				val = val_ea.container;

				generate_property_accessor_declaration (((Property) array_class.scope.lookup ("data")).get_accessor, source_declarations);

				var data_call = new CCodeFunctionCall (new CCodeIdentifier ("dova_array_get_data"));
				data_call.add_argument ((CCodeExpression) get_ccodenode (val));
				cval = data_call;
				val_index = (CCodeExpression) get_ccodenode (val_ea.get_indices ().get (0));
			} else {
				cval = (CCodeExpression) get_ccodenode (val);
			}

			var ccall = new CCodeFunctionCall (new CCodeIdentifier ("dova_type_value_hash"));
			ccall.add_argument (get_type_id_expression (ma.inner.value_type));
			ccall.add_argument (cval);
			ccall.add_argument (val_index);

			expr.ccodenode = ccall;
		}
	}

	public override void visit_list_literal (ListLiteral expr) {
		expr.accept_children (codegen);

		var array_type = new ArrayType (expr.element_type, 1, expr.source_reference);
		array_type.inline_allocated = true;
		array_type.fixed_length = true;
		array_type.length = expr.get_expressions ().size;

		var ce = new CCodeCommaExpression ();
		var temp_var = get_temp_variable (array_type, true, expr);
		var name_cnode = get_variable_cexpression (temp_var.name);

		temp_vars.insert (0, temp_var);

		int i = 0;
		foreach (Expression e in expr.get_expressions ()) {
			ce.append_expression (new CCodeAssignment (new CCodeElementAccess (name_cnode, new CCodeConstant (i.to_string ())), (CCodeExpression) e.ccodenode));
			i++;
		}

		ce.append_expression (name_cnode);

		var list_creation = new CCodeFunctionCall (new CCodeIdentifier ("dova_list_new"));
		list_creation.add_argument (get_type_id_expression (expr.element_type));
		list_creation.add_argument (new CCodeConstant (array_type.length.to_string ()));
		list_creation.add_argument (ce);

		expr.ccodenode = list_creation;
	}

	public override void visit_set_literal (SetLiteral expr) {
		expr.accept_children (codegen);

		var array_type = new ArrayType (expr.element_type, 1, expr.source_reference);
		array_type.inline_allocated = true;
		array_type.fixed_length = true;
		array_type.length = expr.get_expressions ().size;

		var ce = new CCodeCommaExpression ();
		var temp_var = get_temp_variable (array_type, true, expr);
		var name_cnode = get_variable_cexpression (temp_var.name);

		temp_vars.insert (0, temp_var);

		int i = 0;
		foreach (Expression e in expr.get_expressions ()) {
			ce.append_expression (new CCodeAssignment (new CCodeElementAccess (name_cnode, new CCodeConstant (i.to_string ())), (CCodeExpression) e.ccodenode));
			i++;
		}

		ce.append_expression (name_cnode);

		var set_creation = new CCodeFunctionCall (new CCodeIdentifier ("dova_set_new"));
		set_creation.add_argument (get_type_id_expression (expr.element_type));
		set_creation.add_argument (new CCodeConstant (array_type.length.to_string ()));
		set_creation.add_argument (ce);

		expr.ccodenode = set_creation;
	}

	public override void visit_map_literal (MapLiteral expr) {
		expr.accept_children (codegen);

		var key_array_type = new ArrayType (expr.map_key_type, 1, expr.source_reference);
		key_array_type.inline_allocated = true;
		key_array_type.fixed_length = true;
		key_array_type.length = expr.get_keys ().size;

		var key_ce = new CCodeCommaExpression ();
		var key_temp_var = get_temp_variable (key_array_type, true, expr);
		var key_name_cnode = get_variable_cexpression (key_temp_var.name);

		temp_vars.insert (0, key_temp_var);

		var value_array_type = new ArrayType (expr.map_value_type, 1, expr.source_reference);
		value_array_type.inline_allocated = true;
		value_array_type.fixed_length = true;
		value_array_type.length = expr.get_values ().size;

		var value_ce = new CCodeCommaExpression ();
		var value_temp_var = get_temp_variable (value_array_type, true, expr);
		var value_name_cnode = get_variable_cexpression (value_temp_var.name);

		temp_vars.insert (0, value_temp_var);

		for (int i = 0; i < expr.get_keys ().size; i++) {
			key_ce.append_expression (new CCodeAssignment (new CCodeElementAccess (key_name_cnode, new CCodeConstant (i.to_string ())), (CCodeExpression) expr.get_keys ().get (i).ccodenode));
			value_ce.append_expression (new CCodeAssignment (new CCodeElementAccess (value_name_cnode, new CCodeConstant (i.to_string ())), (CCodeExpression) expr.get_values ().get (i).ccodenode));
		}

		key_ce.append_expression (key_name_cnode);
		value_ce.append_expression (value_name_cnode);

		var map_creation = new CCodeFunctionCall (new CCodeIdentifier ("dova_map_new"));
		map_creation.add_argument (get_type_id_expression (expr.map_key_type));
		map_creation.add_argument (get_type_id_expression (expr.map_value_type));
		map_creation.add_argument (new CCodeConstant (key_array_type.length.to_string ()));
		map_creation.add_argument (key_ce);
		map_creation.add_argument (value_ce);

		expr.ccodenode = map_creation;
	}

	public override void visit_tuple (Tuple tuple) {
		tuple.accept_children (codegen);

		var type_array_type = new ArrayType (new PointerType (new VoidType ()), 1, tuple.source_reference);
		type_array_type.inline_allocated = true;
		type_array_type.fixed_length = true;
		type_array_type.length = tuple.get_expressions ().size;

		var type_temp_var = get_temp_variable (type_array_type, true, tuple);
		var type_name_cnode = get_variable_cexpression (type_temp_var.name);
		temp_vars.insert (0, type_temp_var);

		var array_type = new ArrayType (new PointerType (new VoidType ()), 1, tuple.source_reference);
		array_type.inline_allocated = true;
		array_type.fixed_length = true;
		array_type.length = tuple.get_expressions ().size;

		var temp_var = get_temp_variable (array_type, true, tuple);
		var name_cnode = get_variable_cexpression (temp_var.name);
		temp_vars.insert (0, temp_var);

		var type_ce = new CCodeCommaExpression ();
		var ce = new CCodeCommaExpression ();

		int i = 0;
		foreach (Expression e in tuple.get_expressions ()) {
			var element_type = tuple.value_type.get_type_arguments ().get (i);

			type_ce.append_expression (new CCodeAssignment (new CCodeElementAccess (type_name_cnode, new CCodeConstant (i.to_string ())), get_type_id_expression (element_type)));

			var cexpr = (CCodeExpression) e.ccodenode;

			var unary = cexpr as CCodeUnaryExpression;
			if (unary != null && unary.operator == CCodeUnaryOperator.POINTER_INDIRECTION) {
				// *expr => expr
				cexpr = unary.inner;
			} else if (cexpr is CCodeIdentifier || cexpr is CCodeMemberAccess) {
				cexpr = new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, cexpr);
			} else {
				// if cexpr is e.g. a function call, we can't take the address of the expression
				// tmp = expr, &tmp

				var element_temp_var = get_temp_variable (element_type);
				temp_vars.insert (0, element_temp_var);
				ce.append_expression (new CCodeAssignment (get_variable_cexpression (element_temp_var.name), cexpr));
				cexpr = new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, new CCodeIdentifier (element_temp_var.name));
			}

			ce.append_expression (new CCodeAssignment (new CCodeElementAccess (name_cnode, new CCodeConstant (i.to_string ())), cexpr));

			i++;
		}

		type_ce.append_expression (type_name_cnode);
		ce.append_expression (name_cnode);

		var tuple_creation = new CCodeFunctionCall (new CCodeIdentifier ("dova_tuple_new"));
		tuple_creation.add_argument (new CCodeConstant (tuple.get_expressions ().size.to_string ()));
		tuple_creation.add_argument (type_ce);
		tuple_creation.add_argument (ce);

		tuple.ccodenode = tuple_creation;
	}
}
