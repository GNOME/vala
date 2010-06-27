/* valadovaobjectmodule.vala
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

internal class Vala.DovaObjectModule : DovaArrayModule {
	public DovaObjectModule (CCodeGenerator codegen, CCodeModule? next) {
		base (codegen, next);
	}

	public override void generate_class_declaration (Class cl, CCodeDeclarationSpace decl_space) {
		if (decl_space.add_symbol_declaration (cl, cl.get_cname ())) {
			return;
		}

		if (cl.base_class == null) {
			decl_space.add_type_declaration (new CCodeTypeDefinition ("struct _%s".printf (cl.get_cname ()), new CCodeVariableDeclarator (cl.get_cname ())));
		} else {
			// typedef to base class instead of dummy struct to avoid warnings/casts
			generate_class_declaration (cl.base_class, decl_space);
			decl_space.add_type_declaration (new CCodeTypeDefinition (cl.base_class.get_cname (), new CCodeVariableDeclarator (cl.get_cname ())));
		}

		if (cl.base_class == null) {
			var instance_struct = new CCodeStruct ("_%s".printf (cl.get_cname ()));
			instance_struct.add_field ("DovaType *", "type");
			decl_space.add_type_definition (instance_struct);
		} else if (cl == type_class) {
			decl_space.add_include ("stdbool.h");

			var value_copy_function = new CCodeFunction ("dova_type_value_copy");
			value_copy_function.add_parameter (new CCodeFormalParameter ("type", "DovaType *"));
			value_copy_function.add_parameter (new CCodeFormalParameter ("dest", "void *"));
			value_copy_function.add_parameter (new CCodeFormalParameter ("dest_index", "int32_t"));
			value_copy_function.add_parameter (new CCodeFormalParameter ("src", "void *"));
			value_copy_function.add_parameter (new CCodeFormalParameter ("src_index", "int32_t"));

			source_declarations.add_type_member_declaration (value_copy_function);

			var value_equals_function = new CCodeFunction ("dova_type_value_equals", "bool");
			value_equals_function.add_parameter (new CCodeFormalParameter ("type", "DovaType *"));
			value_equals_function.add_parameter (new CCodeFormalParameter ("value", "void *"));
			value_equals_function.add_parameter (new CCodeFormalParameter ("value_index", "int32_t"));
			value_equals_function.add_parameter (new CCodeFormalParameter ("other", "void *"));
			value_equals_function.add_parameter (new CCodeFormalParameter ("other_index", "int32_t"));

			source_declarations.add_type_member_declaration (value_equals_function);

			var value_hash_function = new CCodeFunction ("dova_type_value_hash", "int32_t");
			value_hash_function.add_parameter (new CCodeFormalParameter ("type", "DovaType *"));
			value_hash_function.add_parameter (new CCodeFormalParameter ("value", "void *"));
			value_hash_function.add_parameter (new CCodeFormalParameter ("value_index", "int32_t"));

			source_declarations.add_type_member_declaration (value_hash_function);
		}

		generate_class_declaration (type_class, decl_space);
		generate_method_declaration ((Method) object_class.scope.lookup ("ref"), decl_space);
		generate_method_declaration ((Method) object_class.scope.lookup ("unref"), decl_space);

		var type_fun = new CCodeFunction ("%s_type_get".printf (cl.get_lower_case_cname ()), "DovaType *");
		foreach (var type_param in cl.get_type_parameters ()) {
			type_fun.add_parameter (new CCodeFormalParameter ("%s_type".printf (type_param.name.down ()), "DovaType *"));
		}
		decl_space.add_type_member_declaration (type_fun);

		var type_init_fun = new CCodeFunction ("%s_type_init".printf (cl.get_lower_case_cname ()));
		type_init_fun.add_parameter (new CCodeFormalParameter ("type", "DovaType *"));
		foreach (var type_param in cl.get_type_parameters ()) {
			type_init_fun.add_parameter (new CCodeFormalParameter ("%s_type".printf (type_param.name.down ()), "DovaType *"));
		}
		decl_space.add_type_member_declaration (type_init_fun);
	}

	void generate_virtual_method_declaration (Method m, CCodeDeclarationSpace decl_space, CCodeStruct type_struct) {
		if (!m.is_abstract && !m.is_virtual) {
			return;
		}

		// add vfunc field to the type struct
		var vdeclarator = new CCodeFunctionDeclarator (m.vfunc_name);

		generate_cparameters (m, decl_space, new CCodeFunction ("fake"), vdeclarator);

		var vdecl = new CCodeDeclaration (m.return_type.get_cname ());
		vdecl.add_declarator (vdeclarator);
		type_struct.add_declaration (vdecl);
	}

	void generate_class_private_declaration (Class cl, CCodeDeclarationSpace decl_space) {
		if (decl_space.add_symbol_declaration (cl, cl.get_cname () + "Private")) {
			return;
		}

		var instance_priv_struct = new CCodeStruct ("_%sPrivate".printf (cl.get_cname ()));
		var type_priv_struct = new CCodeStruct ("_%sTypePrivate".printf (cl.get_cname ()));

		foreach (Field f in cl.get_fields ()) {
			if (f.binding == MemberBinding.INSTANCE)  {
				generate_type_declaration (f.field_type, decl_space);

				string field_ctype = f.field_type.get_cname ();
				if (f.is_volatile) {
					field_ctype = "volatile " + field_ctype;
				}

				instance_priv_struct.add_field (field_ctype, f.get_cname ());
			}
		}

		if (cl.get_full_name () == "Dova.Type") {
			var vdeclarator = new CCodeFunctionDeclarator ("value_copy");
			vdeclarator.add_parameter (new CCodeFormalParameter ("dest", "void *"));
			vdeclarator.add_parameter (new CCodeFormalParameter ("dest_index", "int32_t"));
			vdeclarator.add_parameter (new CCodeFormalParameter ("src", "void *"));
			vdeclarator.add_parameter (new CCodeFormalParameter ("src_index", "int32_t"));

			var vdecl = new CCodeDeclaration ("void");
			vdecl.add_declarator (vdeclarator);
			instance_priv_struct.add_declaration (vdecl);

			vdeclarator = new CCodeFunctionDeclarator ("value_equals");
			vdeclarator.add_parameter (new CCodeFormalParameter ("value", "void *"));
			vdeclarator.add_parameter (new CCodeFormalParameter ("value_index", "int32_t"));
			vdeclarator.add_parameter (new CCodeFormalParameter ("other", "void *"));
			vdeclarator.add_parameter (new CCodeFormalParameter ("other_index", "int32_t"));

			vdecl = new CCodeDeclaration ("bool");
			vdecl.add_declarator (vdeclarator);
			instance_priv_struct.add_declaration (vdecl);

			vdeclarator = new CCodeFunctionDeclarator ("value_hash");
			vdeclarator.add_parameter (new CCodeFormalParameter ("value", "void *"));
			vdeclarator.add_parameter (new CCodeFormalParameter ("value_index", "int32_t"));

			vdecl = new CCodeDeclaration ("int32_t");
			vdecl.add_declarator (vdeclarator);
			instance_priv_struct.add_declaration (vdecl);
		}

		foreach (var type_param in cl.get_type_parameters ()) {
			var type_param_decl = new CCodeDeclaration ("DovaType *");
			type_param_decl.add_declarator (new CCodeVariableDeclarator ("%s_type".printf (type_param.name.down ())));
			type_priv_struct.add_declaration (type_param_decl);
		}

		foreach (Method m in cl.get_methods ()) {
			generate_virtual_method_declaration (m, decl_space, type_priv_struct);
		}

		foreach (Property prop in cl.get_properties ()) {
			if (!prop.is_abstract && !prop.is_virtual) {
				continue;
			}
			generate_type_declaration (prop.property_type, decl_space);

			var t = (ObjectTypeSymbol) prop.parent_symbol;

			var this_type = new ObjectType (t);
			var cselfparam = new CCodeFormalParameter ("this", this_type.get_cname ());
			var cvalueparam = new CCodeFormalParameter ("value", prop.property_type.get_cname ());

			if (prop.get_accessor != null) {
				var vdeclarator = new CCodeFunctionDeclarator ("get_%s".printf (prop.name));
				vdeclarator.add_parameter (cselfparam);
				string creturn_type = prop.property_type.get_cname ();

				var vdecl = new CCodeDeclaration (creturn_type);
				vdecl.add_declarator (vdeclarator);
				type_priv_struct.add_declaration (vdecl);
			}
			if (prop.set_accessor != null) {
				var vdeclarator = new CCodeFunctionDeclarator ("set_%s".printf (prop.name));
				vdeclarator.add_parameter (cselfparam);
				vdeclarator.add_parameter (cvalueparam);

				var vdecl = new CCodeDeclaration ("void");
				vdecl.add_declarator (vdeclarator);
				type_priv_struct.add_declaration (vdecl);
			}
		}

		decl_space.add_type_declaration (new CCodeTypeDefinition ("struct %s".printf (instance_priv_struct.name), new CCodeVariableDeclarator ("%sPrivate".printf (cl.get_cname ()))));
		decl_space.add_type_definition (instance_priv_struct);

		decl_space.add_type_declaration (new CCodeTypeDefinition ("struct %s".printf (type_priv_struct.name), new CCodeVariableDeclarator ("%sTypePrivate".printf (cl.get_cname ()))));
		decl_space.add_type_definition (type_priv_struct);

		string macro;
		if (cl.base_class == null) {
			// offset of Object class is 0
			macro = "((%sPrivate *) o)".printf (cl.get_cname ());
		} else {
			var cdecl = new CCodeDeclaration ("int");
			cdecl.add_declarator (new CCodeVariableDeclarator ("_%s_object_offset".printf (cl.get_lower_case_cname ()), new CCodeConstant ("0")));
			cdecl.modifiers = CCodeModifiers.STATIC;
			decl_space.add_type_member_declaration (cdecl);

			macro = "((%sPrivate *) (((char *) o) + _%s_object_offset))".printf (cl.get_cname (), cl.get_lower_case_cname ());
		}
		decl_space.add_type_member_declaration (new CCodeMacroReplacement ("%s_GET_PRIVATE(o)".printf (cl.get_upper_case_cname (null)), macro));

		var cdecl = new CCodeDeclaration ("int");
		cdecl.add_declarator (new CCodeVariableDeclarator ("_%s_type_offset".printf (cl.get_lower_case_cname ()), new CCodeConstant ("0")));
		cdecl.modifiers = CCodeModifiers.STATIC;
		decl_space.add_type_member_declaration (cdecl);
	}

	CCodeFunction create_set_value_copy_function (bool decl_only = false) {
		var result = new CCodeFunction ("dova_type_set_value_copy");
		result.add_parameter (new CCodeFormalParameter ("type", "DovaType *"));
		result.add_parameter (new CCodeFormalParameter ("(*function) (void *dest, int32_t dest_index, void *src, int32_t src_index)", "void"));
		if (decl_only) {
			return result;
		}

		result.block = new CCodeBlock ();

		var priv_call = new CCodeFunctionCall (new CCodeIdentifier ("DOVA_TYPE_GET_PRIVATE"));
		priv_call.add_argument (new CCodeIdentifier ("type"));

		result.block.add_statement (new CCodeExpressionStatement (new CCodeAssignment (new CCodeMemberAccess.pointer (priv_call, "value_copy"), new CCodeIdentifier ("function"))));
		return result;
	}

	public void declare_set_value_copy_function (CCodeDeclarationSpace decl_space) {
		if (decl_space.add_symbol_declaration (type_class, "dova_type_set_value_copy")) {
			return;
		}
		decl_space.add_type_member_declaration (create_set_value_copy_function (true));
	}

	CCodeFunction create_set_value_equals_function (bool decl_only = false) {
		var result = new CCodeFunction ("dova_type_set_value_equals");
		result.add_parameter (new CCodeFormalParameter ("type", "DovaType *"));
		result.add_parameter (new CCodeFormalParameter ("(*function) (void *value, int32_t value_index, void *other, int32_t other_index)", "bool"));
		if (decl_only) {
			return result;
		}

		result.block = new CCodeBlock ();

		var priv_call = new CCodeFunctionCall (new CCodeIdentifier ("DOVA_TYPE_GET_PRIVATE"));
		priv_call.add_argument (new CCodeIdentifier ("type"));

		result.block.add_statement (new CCodeExpressionStatement (new CCodeAssignment (new CCodeMemberAccess.pointer (priv_call, "value_equals"), new CCodeIdentifier ("function"))));
		return result;
	}

	public void declare_set_value_equals_function (CCodeDeclarationSpace decl_space) {
		if (decl_space.add_symbol_declaration (type_class, "dova_type_set_value_equals")) {
			return;
		}
		decl_space.add_type_member_declaration (create_set_value_equals_function (true));
	}

	CCodeFunction create_set_value_hash_function (bool decl_only = false) {
		var result = new CCodeFunction ("dova_type_set_value_hash");
		result.add_parameter (new CCodeFormalParameter ("type", "DovaType *"));
		result.add_parameter (new CCodeFormalParameter ("(*function) (void *value, int32_t value_index)", "int32_t"));
		if (decl_only) {
			return result;
		}

		result.block = new CCodeBlock ();

		var priv_call = new CCodeFunctionCall (new CCodeIdentifier ("DOVA_TYPE_GET_PRIVATE"));
		priv_call.add_argument (new CCodeIdentifier ("type"));

		result.block.add_statement (new CCodeExpressionStatement (new CCodeAssignment (new CCodeMemberAccess.pointer (priv_call, "value_hash"), new CCodeIdentifier ("function"))));
		return result;
	}

	public void declare_set_value_hash_function (CCodeDeclarationSpace decl_space) {
		if (decl_space.add_symbol_declaration (type_class, "dova_type_set_value_hash")) {
			return;
		}
		decl_space.add_type_member_declaration (create_set_value_hash_function (true));
	}

	public CCodeBlock generate_type_get_function (TypeSymbol cl, Class? base_class) {
		source_declarations.add_include ("stddef.h");
		// calloc
		source_declarations.add_include ("stdlib.h");

		var cdecl = new CCodeDeclaration ("DovaType *");
		cdecl.add_declarator (new CCodeVariableDeclarator ("%s_type".printf (cl.get_lower_case_cname ()), new CCodeConstant ("NULL")));
		cdecl.modifiers = CCodeModifiers.STATIC;
		source_declarations.add_type_member_declaration (cdecl);

		var type_fun = new CCodeFunction ("%s_type_get".printf (cl.get_lower_case_cname ()), "DovaType *");

		var object_type_symbol = cl as ObjectTypeSymbol;
		if (object_type_symbol != null) {
			foreach (var type_param in object_type_symbol.get_type_parameters ()) {
				type_fun.add_parameter (new CCodeFormalParameter ("%s_type".printf (type_param.name.down ()), "DovaType *"));
			}
		}

		type_fun.block = new CCodeBlock ();

		var type_init_block = new CCodeBlock ();

		if (base_class == null) {
			// var sizeof_call = new CCodeFunctionCall (new CCodeIdentifier ("sizeof"));
			// sizeof_call.add_argument (new CCodeIdentifier ("DovaObject"));

			var sizeof_call = new CCodeFunctionCall (new CCodeIdentifier ("sizeof"));
			sizeof_call.add_argument (new CCodeIdentifier ("%sPrivate".printf (cl.get_cname ())));

			var calloc_call = new CCodeFunctionCall (new CCodeIdentifier ("calloc"));
			calloc_call.add_argument (new CCodeConstant ("1"));
			// calloc_call.add_argument (sizeof_call);
			// FIXME
			calloc_call.add_argument (new CCodeConstant ("sizeof (DovaObjectPrivate) + sizeof (DovaTypePrivate) + sizeof (DovaObjectTypePrivate)"));

			type_init_block.add_statement (new CCodeExpressionStatement (new CCodeAssignment (new CCodeIdentifier ("%s_type".printf (cl.get_lower_case_cname ())), calloc_call)));

			type_init_block.add_statement (new CCodeExpressionStatement (new CCodeAssignment (new CCodeIdentifier ("_dova_type_object_offset"), sizeof_call)));

			var set_size = new CCodeFunctionCall (new CCodeIdentifier ("dova_type_set_object_size"));
			set_size.add_argument (new CCodeIdentifier ("%s_type".printf (cl.get_lower_case_cname ())));
			set_size.add_argument (sizeof_call);
			type_init_block.add_statement (new CCodeExpressionStatement (set_size));

			type_init_block.add_statement (new CCodeExpressionStatement (new CCodeAssignment (new CCodeIdentifier ("_dova_object_type_offset"), new CCodeConstant ("sizeof (DovaObjectPrivate) + sizeof (DovaTypePrivate)"))));

			set_size = new CCodeFunctionCall (new CCodeIdentifier ("dova_type_set_type_size"));
			set_size.add_argument (new CCodeIdentifier ("%s_type".printf (cl.get_lower_case_cname ())));
			set_size.add_argument (new CCodeConstant ("sizeof (DovaObjectPrivate) + sizeof (DovaTypePrivate) + sizeof (DovaObjectTypePrivate)"));
			type_init_block.add_statement (new CCodeExpressionStatement (set_size));

			type_init_block.add_statement (new CCodeExpressionStatement (new CCodeAssignment (new CCodeMemberAccess.pointer (new CCodeCastExpression (new CCodeIdentifier ("%s_type".printf (cl.get_lower_case_cname ())), "DovaObject *"), "type"), new CCodeFunctionCall (new CCodeIdentifier ("dova_type_type_get")))));
		} else {
			generate_method_declaration ((Method) object_class.scope.lookup ("alloc"), source_declarations);
			generate_method_declaration ((Method) type_class.scope.lookup ("alloc"), source_declarations);

			var base_type = new CCodeFunctionCall (new CCodeIdentifier ("%s_type_get".printf (base_class.get_lower_case_cname ())));
			for (int i = 0; i < base_class.get_type_parameters ().size; i++) {
				base_type.add_argument (new CCodeConstant ("NULL"));
			}

			var alloc_call = new CCodeFunctionCall (new CCodeIdentifier ("dova_type_alloc"));
			alloc_call.add_argument (base_type);
			alloc_call.add_argument (new CCodeConstant ("sizeof (%sPrivate)".printf (cl.get_cname ())));
			alloc_call.add_argument (new CCodeConstant ("sizeof (%sTypePrivate)".printf (cl.get_cname ())));
			alloc_call.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, new CCodeIdentifier ("%s_type".printf (cl.get_lower_case_cname ()))));
			alloc_call.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, new CCodeIdentifier ("_%s_object_offset".printf (cl.get_lower_case_cname ()))));
			alloc_call.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, new CCodeIdentifier ("_%s_type_offset".printf (cl.get_lower_case_cname ()))));

			type_init_block.add_statement (new CCodeExpressionStatement (alloc_call));
		}

		var type_init_call = new CCodeFunctionCall (new CCodeIdentifier ("%s_type_init".printf (cl.get_lower_case_cname ())));
		type_init_call.add_argument (new CCodeIdentifier ("%s_type".printf (cl.get_lower_case_cname ())));

		if (object_type_symbol != null) {
			for (int i = 0; i < object_type_symbol.get_type_parameters ().size; i++) {
				type_init_call.add_argument (new CCodeConstant ("NULL"));
			}
		}

		type_init_block.add_statement (new CCodeExpressionStatement (type_init_call));

		type_fun.block.add_statement (new CCodeIfStatement (new CCodeUnaryExpression (CCodeUnaryOperator.LOGICAL_NEGATION, new CCodeIdentifier ("%s_type".printf (cl.get_lower_case_cname ()))), type_init_block));

		if (object_type_symbol != null && object_type_symbol.get_type_parameters ().size > 0) {
			// generics
			var specialized_type_get_block = new CCodeBlock ();

			generate_property_accessor_declaration (((Property) type_class.scope.lookup ("next_type")).get_accessor, source_declarations);
			generate_method_declaration ((Method) type_class.scope.lookup ("insert_type"), source_declarations);

			var first = new CCodeFunctionCall (new CCodeIdentifier ("dova_type_get_next_type"));
			first.add_argument (new CCodeIdentifier ("%s_type".printf (cl.get_lower_case_cname ())));

			cdecl = new CCodeDeclaration ("DovaType *");
			cdecl.add_declarator (new CCodeVariableDeclarator ("result", first));
			specialized_type_get_block.add_statement (cdecl);

			var next = new CCodeFunctionCall (new CCodeIdentifier ("dova_type_get_next_type"));
			next.add_argument (new CCodeIdentifier ("result"));

			var next_check = new CCodeBlock ();
			next_check.add_statement (new CCodeIfStatement (new CCodeBinaryExpression (CCodeBinaryOperator.EQUALITY, new CCodeMemberAccess.pointer (get_type_private_from_type (object_type_symbol, new CCodeIdentifier ("result")), "%s_type".printf (object_type_symbol.get_type_parameters ().get (0).name.down ())), new CCodeIdentifier ("%s_type".printf (object_type_symbol.get_type_parameters ().get (0).name.down ()))), new CCodeBreakStatement ()));
			next_check.add_statement (new CCodeExpressionStatement (new CCodeAssignment (new CCodeIdentifier ("result"), next)));

			specialized_type_get_block.add_statement (new CCodeWhileStatement (new CCodeIdentifier ("result"), next_check));

			var specialized_type_init_block = new CCodeBlock ();

			generate_method_declaration ((Method) type_class.scope.lookup ("alloc"), source_declarations);

			var base_type = new CCodeFunctionCall (new CCodeIdentifier ("%s_type_get".printf (base_class.get_lower_case_cname ())));
			foreach (var type_param in base_class.get_type_parameters ()) {
				base_type.add_argument (new CCodeIdentifier ("%s_type".printf (type_param.name.down ())));
			}

			var alloc_call = new CCodeFunctionCall (new CCodeIdentifier ("dova_type_alloc"));
			alloc_call.add_argument (base_type);
			alloc_call.add_argument (new CCodeConstant ("sizeof (%sPrivate)".printf (cl.get_cname ())));
			alloc_call.add_argument (new CCodeConstant ("sizeof (%sTypePrivate)".printf (cl.get_cname ())));
			alloc_call.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, new CCodeIdentifier ("result")));
			alloc_call.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, new CCodeIdentifier ("_%s_object_offset".printf (cl.get_lower_case_cname ()))));
			alloc_call.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, new CCodeIdentifier ("_%s_type_offset".printf (cl.get_lower_case_cname ()))));

			specialized_type_init_block.add_statement (new CCodeExpressionStatement (alloc_call));

			type_init_call = new CCodeFunctionCall (new CCodeIdentifier ("%s_type_init".printf (cl.get_lower_case_cname ())));
			type_init_call.add_argument (new CCodeIdentifier ("result"));

			foreach (var type_param in object_type_symbol.get_type_parameters ()) {
				type_init_call.add_argument (new CCodeIdentifier ("%s_type".printf (type_param.name.down ())));
			}

			specialized_type_init_block.add_statement (new CCodeExpressionStatement (type_init_call));

			var insert_call = new CCodeFunctionCall (new CCodeIdentifier ("dova_type_insert_type"));
			insert_call.add_argument (new CCodeIdentifier ("%s_type".printf (cl.get_lower_case_cname ())));
			insert_call.add_argument (new CCodeIdentifier ("result"));
			specialized_type_init_block.add_statement (new CCodeExpressionStatement (insert_call));

			specialized_type_get_block.add_statement (new CCodeIfStatement (new CCodeUnaryExpression (CCodeUnaryOperator.LOGICAL_NEGATION, new CCodeIdentifier ("result")), specialized_type_init_block));

			specialized_type_get_block.add_statement (new CCodeReturnStatement (new CCodeIdentifier ("result")));

			type_fun.block.add_statement (new CCodeIfStatement (new CCodeIdentifier ("%s_type".printf (object_type_symbol.get_type_parameters ().get (0).name.down ())), specialized_type_get_block));
		}

		type_fun.block.add_statement (new CCodeReturnStatement (new CCodeIdentifier ("%s_type".printf (cl.get_lower_case_cname ()))));

		source_type_member_definition.append (type_fun);

		var type_init_fun = new CCodeFunction ("%s_type_init".printf (cl.get_lower_case_cname ()));
		type_init_fun.add_parameter (new CCodeFormalParameter ("type", "DovaType *"));
		if (object_type_symbol != null) {
			foreach (var type_param in object_type_symbol.get_type_parameters ()) {
				type_init_fun.add_parameter (new CCodeFormalParameter ("%s_type".printf (type_param.name.down ()), "DovaType *"));
			}
		}
		type_init_fun.block = new CCodeBlock ();

		if (base_class == null) {
			var sizeof_call = new CCodeFunctionCall (new CCodeIdentifier ("sizeof"));
			sizeof_call.add_argument (new CCodeIdentifier ("void *"));

			var set_size = new CCodeFunctionCall (new CCodeIdentifier ("dova_type_set_value_size"));
			set_size.add_argument (new CCodeIdentifier ("type"));
			set_size.add_argument (sizeof_call);
			type_init_fun.block.add_statement (new CCodeExpressionStatement (set_size));

			declare_set_value_copy_function (source_declarations);

			var value_copy_call = new CCodeFunctionCall (new CCodeIdentifier ("dova_type_set_value_copy"));
			value_copy_call.add_argument (new CCodeIdentifier ("type"));
			value_copy_call.add_argument (new CCodeCastExpression (new CCodeIdentifier ("dova_object_copy"), "void (*)(void *, int32_t,  void *, int32_t)"));
			type_init_fun.block.add_statement (new CCodeExpressionStatement (value_copy_call));

			var function = new CCodeFunction ("dova_object_copy", "void");
			function.modifiers = CCodeModifiers.STATIC;
			function.add_parameter (new CCodeFormalParameter ("dest", "DovaObject **"));
			function.add_parameter (new CCodeFormalParameter ("dest_index", "int32_t"));
			function.add_parameter (new CCodeFormalParameter ("src", "DovaObject **"));
			function.add_parameter (new CCodeFormalParameter ("src_index", "int32_t"));

			function.block = new CCodeBlock ();
			var cfrag = new CCodeFragment ();
			function.block.add_statement (cfrag);

			var dest = new CCodeBinaryExpression (CCodeBinaryOperator.PLUS, new CCodeIdentifier ("dest"), new CCodeIdentifier ("dest_index"));
			var src = new CCodeBinaryExpression (CCodeBinaryOperator.PLUS, new CCodeIdentifier ("src"), new CCodeIdentifier ("src_index"));

			var unref_call = new CCodeFunctionCall (new CCodeIdentifier ("dova_object_unref"));
			unref_call.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.POINTER_INDIRECTION, dest));
			var unref_block = new CCodeBlock ();
			unref_block.add_statement (new CCodeExpressionStatement (unref_call));
			unref_block.add_statement (new CCodeExpressionStatement (new CCodeAssignment (new CCodeUnaryExpression (CCodeUnaryOperator.POINTER_INDIRECTION, dest), new CCodeConstant ("NULL"))));
			function.block.add_statement (new CCodeIfStatement (new CCodeUnaryExpression (CCodeUnaryOperator.POINTER_INDIRECTION, dest), unref_block));

			var ref_call = new CCodeFunctionCall (new CCodeIdentifier ("dova_object_ref"));
			ref_call.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.POINTER_INDIRECTION, src));
			var ref_block = new CCodeBlock ();
			ref_block.add_statement (new CCodeExpressionStatement (new CCodeAssignment (new CCodeUnaryExpression (CCodeUnaryOperator.POINTER_INDIRECTION, dest), ref_call)));
			function.block.add_statement (new CCodeIfStatement (new CCodeIdentifier ("src"), ref_block));

			source_type_member_definition.append (function);
		} else {
			type_init_call = new CCodeFunctionCall (new CCodeIdentifier ("%s_type_init".printf (base_class.get_lower_case_cname ())));
			type_init_call.add_argument (new CCodeIdentifier ("type"));

			foreach (var type_param in base_class.get_type_parameters ()) {
				type_init_call.add_argument (new CCodeIdentifier ("%s_type".printf (type_param.name.down ())));
			}

			type_init_fun.block.add_statement (new CCodeExpressionStatement (type_init_call));

			if (object_type_symbol != null) {
				foreach (var type_param in object_type_symbol.get_type_parameters ()) {
					type_init_fun.block.add_statement (new CCodeExpressionStatement (new CCodeAssignment (new CCodeMemberAccess.pointer (get_type_private_from_type (object_type_symbol, new CCodeIdentifier ("type")), "%s_type".printf (type_param.name.down ())), new CCodeIdentifier ("%s_type".printf (type_param.name.down ())))));
				}
			}
		}

		source_type_member_definition.append (type_init_fun);

		return type_init_fun.block;
	}

	void add_finalize_function (Class cl) {
		var function = new CCodeFunction ("%sfinalize".printf (cl.get_lower_case_cprefix ()), "void");
		function.modifiers = CCodeModifiers.STATIC;

		function.add_parameter (new CCodeFormalParameter ("this", cl.get_cname () + "*"));

		source_declarations.add_type_member_declaration (function.copy ());


		var cblock = new CCodeBlock ();

		if (cl.destructor != null) {
			cblock.add_statement (cl.destructor.ccodenode);
		}

		cblock.add_statement (instance_finalize_fragment);

		// chain up to finalize function of the base class
		foreach (DataType base_type in cl.get_base_types ()) {
			var object_type = (ObjectType) base_type;
			if (object_type.type_symbol is Class) {
				var ccall = new CCodeFunctionCall (new CCodeIdentifier ("dova_object_base_finalize"));
				var type_get_call = new CCodeFunctionCall (new CCodeIdentifier ("%s_type_get".printf (object_type.type_symbol.get_lower_case_cname ())));
				foreach (var type_arg in base_type.get_type_arguments ()) {
					type_get_call.add_argument (get_type_id_expression (type_arg, false));
				}
				ccall.add_argument (type_get_call);
				ccall.add_argument (new CCodeIdentifier ("this"));
				cblock.add_statement (new CCodeExpressionStatement (ccall));
			}
		}


		function.block = cblock;

		source_type_member_definition.append (function);
	}

	public override void visit_class (Class cl) {
		var old_symbol = current_symbol;
		var old_instance_finalize_fragment = instance_finalize_fragment;
		current_symbol = cl;
		instance_finalize_fragment = new CCodeFragment ();

		generate_class_declaration (cl, source_declarations);
		generate_class_private_declaration (cl, source_declarations);

		if (!cl.is_internal_symbol ()) {
			generate_class_declaration (cl, header_declarations);
		}
		generate_class_declaration (cl, internal_header_declarations);

		cl.accept_children (codegen);

		var type_init_block = generate_type_get_function (cl, cl.base_class);

		foreach (DataType base_type in cl.get_base_types ()) {
			var object_type = (ObjectType) base_type;
			if (object_type.type_symbol is Interface) {
				generate_interface_declaration ((Interface) object_type.type_symbol, source_declarations);

				var type_init_call = new CCodeFunctionCall (new CCodeIdentifier ("%s_type_init".printf (object_type.type_symbol.get_lower_case_cname ())));
				type_init_call.add_argument (new CCodeIdentifier ("type"));
				foreach (var type_arg in base_type.get_type_arguments ()) {
					type_init_call.add_argument (get_type_id_expression (type_arg, true));
				}
				type_init_block.add_statement (new CCodeExpressionStatement (type_init_call));
			}
		}

		// finalizer
		if (cl.base_class != null && (cl.get_fields ().size > 0 || cl.destructor != null)) {
			add_finalize_function (cl);

			generate_method_declaration ((Method) object_class.scope.lookup ("finalize"), source_declarations);

			var override_call = new CCodeFunctionCall (new CCodeIdentifier ("dova_object_override_finalize"));
			override_call.add_argument (new CCodeIdentifier ("type"));
			override_call.add_argument (new CCodeIdentifier ("%sfinalize".printf (cl.get_lower_case_cprefix ())));
			type_init_block.add_statement (new CCodeExpressionStatement (override_call));
		}

		foreach (Method m in cl.get_methods ()) {
			if (m.is_virtual || m.overrides) {
				var override_call = new CCodeFunctionCall (new CCodeIdentifier ("%soverride_%s".printf (m.base_method.parent_symbol.get_lower_case_cprefix (), m.name)));
				override_call.add_argument (new CCodeIdentifier ("type"));
				override_call.add_argument (new CCodeIdentifier (m.get_real_cname ()));
				type_init_block.add_statement (new CCodeExpressionStatement (override_call));
			} else if (m.base_interface_method != null) {
				var override_call = new CCodeFunctionCall (new CCodeIdentifier ("%soverride_%s".printf (m.base_interface_method.parent_symbol.get_lower_case_cprefix (), m.name)));
				override_call.add_argument (new CCodeIdentifier ("type"));
				override_call.add_argument (new CCodeIdentifier (m.get_real_cname ()));
				type_init_block.add_statement (new CCodeExpressionStatement (override_call));
			}
		}

		foreach (Property prop in cl.get_properties ()) {
			if (prop.is_virtual || prop.overrides) {
				if (prop.get_accessor != null) {
					var override_call = new CCodeFunctionCall (new CCodeIdentifier ("%soverride_get_%s".printf (prop.base_property.parent_symbol.get_lower_case_cprefix (), prop.name)));
					override_call.add_argument (new CCodeIdentifier ("type"));
					override_call.add_argument (new CCodeIdentifier (prop.get_accessor.get_cname ()));
					type_init_block.add_statement (new CCodeExpressionStatement (override_call));
				}
				if (prop.set_accessor != null) {
					var override_call = new CCodeFunctionCall (new CCodeIdentifier ("%soverride_set_%s".printf (prop.base_property.parent_symbol.get_lower_case_cprefix (), prop.name)));
					override_call.add_argument (new CCodeIdentifier ("type"));
					override_call.add_argument (new CCodeIdentifier (prop.set_accessor.get_cname ()));
					type_init_block.add_statement (new CCodeExpressionStatement (override_call));
				}
			}
		}

		if (cl == type_class) {
			var priv_call = new CCodeFunctionCall (new CCodeIdentifier ("DOVA_TYPE_GET_PRIVATE"));
			priv_call.add_argument (new CCodeIdentifier ("type"));

			var value_copy_function = new CCodeFunction ("dova_type_value_copy");
			value_copy_function.add_parameter (new CCodeFormalParameter ("type", "DovaType *"));
			value_copy_function.add_parameter (new CCodeFormalParameter ("dest", "void *"));
			value_copy_function.add_parameter (new CCodeFormalParameter ("dest_index", "int32_t"));
			value_copy_function.add_parameter (new CCodeFormalParameter ("src", "void *"));
			value_copy_function.add_parameter (new CCodeFormalParameter ("src_index", "int32_t"));

			value_copy_function.block = new CCodeBlock ();

			var ccall = new CCodeFunctionCall (new CCodeMemberAccess.pointer (priv_call, "value_copy"));
			ccall.add_argument (new CCodeIdentifier ("dest"));
			ccall.add_argument (new CCodeIdentifier ("dest_index"));
			ccall.add_argument (new CCodeIdentifier ("src"));
			ccall.add_argument (new CCodeIdentifier ("src_index"));
			value_copy_function.block.add_statement (new CCodeExpressionStatement (ccall));

			source_type_member_definition.append (value_copy_function);

			declare_set_value_copy_function (source_declarations);
			declare_set_value_copy_function (header_declarations);
			declare_set_value_copy_function (internal_header_declarations);
			source_type_member_definition.append (create_set_value_copy_function ());

			var value_equals_function = new CCodeFunction ("dova_type_value_equals", "bool");
			value_equals_function.add_parameter (new CCodeFormalParameter ("type", "DovaType *"));
			value_equals_function.add_parameter (new CCodeFormalParameter ("value", "void *"));
			value_equals_function.add_parameter (new CCodeFormalParameter ("value_index", "int32_t"));
			value_equals_function.add_parameter (new CCodeFormalParameter ("other", "void *"));
			value_equals_function.add_parameter (new CCodeFormalParameter ("other_index", "int32_t"));

			value_equals_function.block = new CCodeBlock ();

			ccall = new CCodeFunctionCall (new CCodeMemberAccess.pointer (priv_call, "value_equals"));
			ccall.add_argument (new CCodeIdentifier ("value"));
			ccall.add_argument (new CCodeIdentifier ("value_index"));
			ccall.add_argument (new CCodeIdentifier ("other"));
			ccall.add_argument (new CCodeIdentifier ("other_index"));
			value_equals_function.block.add_statement (new CCodeExpressionStatement (ccall));

			source_type_member_definition.append (value_equals_function);

			declare_set_value_equals_function (source_declarations);
			declare_set_value_equals_function (header_declarations);
			declare_set_value_equals_function (internal_header_declarations);
			source_type_member_definition.append (create_set_value_equals_function ());

			var value_hash_function = new CCodeFunction ("dova_type_value_hash", "int32_t");
			value_hash_function.add_parameter (new CCodeFormalParameter ("type", "DovaType *"));
			value_hash_function.add_parameter (new CCodeFormalParameter ("value", "void *"));
			value_hash_function.add_parameter (new CCodeFormalParameter ("value_index", "int32_t"));

			value_hash_function.block = new CCodeBlock ();

			ccall = new CCodeFunctionCall (new CCodeMemberAccess.pointer (priv_call, "value_hash"));
			ccall.add_argument (new CCodeIdentifier ("value"));
			ccall.add_argument (new CCodeIdentifier ("value_index"));
			value_hash_function.block.add_statement (new CCodeExpressionStatement (ccall));

			source_type_member_definition.append (value_hash_function);

			declare_set_value_hash_function (source_declarations);
			declare_set_value_hash_function (header_declarations);
			declare_set_value_hash_function (internal_header_declarations);
			source_type_member_definition.append (create_set_value_hash_function ());
		}

		current_symbol = old_symbol;
		instance_finalize_fragment = old_instance_finalize_fragment;
	}

	public override void visit_interface (Interface iface) {
		var old_symbol = current_symbol;
		current_symbol = iface;

		generate_interface_declaration (iface, source_declarations);

		var type_priv_struct = new CCodeStruct ("_%sTypePrivate".printf (iface.get_cname ()));

		foreach (var type_param in iface.get_type_parameters ()) {
			var type_param_decl = new CCodeDeclaration ("DovaType *");
			type_param_decl.add_declarator (new CCodeVariableDeclarator ("%s_type".printf (type_param.name.down ())));
			type_priv_struct.add_declaration (type_param_decl);
		}

		foreach (Method m in iface.get_methods ()) {
			generate_virtual_method_declaration (m, source_declarations, type_priv_struct);
		}

		source_declarations.add_type_declaration (new CCodeTypeDefinition ("struct %s".printf (type_priv_struct.name), new CCodeVariableDeclarator ("%sTypePrivate".printf (iface.get_cname ()))));
		source_declarations.add_type_definition (type_priv_struct);

		source_declarations.add_include ("stddef.h");
		// calloc
		source_declarations.add_include ("stdlib.h");

		var cdecl = new CCodeDeclaration ("DovaType *");
		cdecl.add_declarator (new CCodeVariableDeclarator ("%s_type".printf (iface.get_lower_case_cname ()), new CCodeConstant ("NULL")));
		cdecl.modifiers = CCodeModifiers.STATIC;
		source_declarations.add_type_member_declaration (cdecl);

		var type_fun = new CCodeFunction ("%s_type_get".printf (iface.get_lower_case_cname ()), "DovaType *");
		foreach (var type_param in iface.get_type_parameters ()) {
			type_fun.add_parameter (new CCodeFormalParameter ("%s_type".printf (type_param.name.down ()), "DovaType *"));
		}
		type_fun.block = new CCodeBlock ();

		var type_init_block = new CCodeBlock ();

		var calloc_call = new CCodeFunctionCall (new CCodeIdentifier ("calloc"));
		calloc_call.add_argument (new CCodeConstant ("1"));
		calloc_call.add_argument (new CCodeConstant ("dova_type_get_type_size (dova_type_type_get ()) + sizeof (%sTypePrivate)".printf (iface.get_cname ())));

		type_init_block.add_statement (new CCodeExpressionStatement (new CCodeAssignment (new CCodeIdentifier ("%s_type".printf (iface.get_lower_case_cname ())), calloc_call)));

		var type_init_call = new CCodeFunctionCall (new CCodeIdentifier ("%s_type_init".printf (iface.get_lower_case_cname ())));
		type_init_call.add_argument (new CCodeIdentifier ("%s_type".printf (iface.get_lower_case_cname ())));
		foreach (var type_param in iface.get_type_parameters ()) {
			type_init_call.add_argument (new CCodeIdentifier ("%s_type".printf (type_param.name.down ())));
		}
		type_init_block.add_statement (new CCodeExpressionStatement (type_init_call));

		type_fun.block.add_statement (new CCodeIfStatement (new CCodeUnaryExpression (CCodeUnaryOperator.LOGICAL_NEGATION, new CCodeIdentifier ("%s_type".printf (iface.get_lower_case_cname ()))), type_init_block));

		type_fun.block.add_statement (new CCodeReturnStatement (new CCodeIdentifier ("%s_type".printf (iface.get_lower_case_cname ()))));

		source_type_member_definition.append (type_fun);

		var type_init_fun = new CCodeFunction ("%s_type_init".printf (iface.get_lower_case_cname ()));
		type_init_fun.add_parameter (new CCodeFormalParameter ("type", "DovaType *"));
		foreach (var type_param in iface.get_type_parameters ()) {
			type_init_fun.add_parameter (new CCodeFormalParameter ("%s_type".printf (type_param.name.down ()), "DovaType *"));
		}
		type_init_fun.block = new CCodeBlock ();

		foreach (DataType base_type in iface.get_prerequisites ()) {
			var object_type = (ObjectType) base_type;
			if (object_type.type_symbol is Interface) {
				type_init_call = new CCodeFunctionCall (new CCodeIdentifier ("%s_type_init".printf (object_type.type_symbol.get_lower_case_cname ())));
				type_init_call.add_argument (new CCodeIdentifier ("type"));
				type_init_fun.block.add_statement (new CCodeExpressionStatement (type_init_call));
			}
		}

		var vtable_alloc = new CCodeFunctionCall (new CCodeIdentifier ("calloc"));
		vtable_alloc.add_argument (new CCodeConstant ("1"));
		vtable_alloc.add_argument (new CCodeConstant ("sizeof (%sTypePrivate)".printf (iface.get_cname ())));

		var type_get_call = new CCodeFunctionCall (new CCodeIdentifier ("%s_type_get".printf (iface.get_lower_case_cname ())));
		foreach (var type_param in iface.get_type_parameters ()) {
			type_get_call.add_argument (new CCodeIdentifier ("%s_type".printf (type_param.name.down ())));
		}

		var add_interface_call = new CCodeFunctionCall (new CCodeIdentifier ("dova_type_add_interface"));
		add_interface_call.add_argument (new CCodeIdentifier ("type"));
		add_interface_call.add_argument (type_get_call);
		add_interface_call.add_argument (vtable_alloc);
		type_init_fun.block.add_statement (new CCodeExpressionStatement (add_interface_call));

		source_type_member_definition.append (type_init_fun);

		iface.accept_children (codegen);

		current_symbol = old_symbol;
	}

	public override void generate_property_accessor_declaration (PropertyAccessor acc, CCodeDeclarationSpace decl_space) {
		if (decl_space.add_symbol_declaration (acc.prop, acc.get_cname ())) {
			return;
		}

		var prop = (Property) acc.prop;

		generate_type_declaration (acc.value_type, decl_space);

		CCodeFunction function;

		if (acc.readable) {
			function = new CCodeFunction (acc.get_cname (), acc.value_type.get_cname ());
		} else {
			function = new CCodeFunction (acc.get_cname (), "void");
		}

		if (prop.binding == MemberBinding.INSTANCE) {
			DataType this_type;
			if (prop.parent_symbol is Struct) {
				var st = (Struct) prop.parent_symbol;
				this_type = SemanticAnalyzer.get_data_type_for_symbol (st);
			} else {
				var t = (ObjectTypeSymbol) prop.parent_symbol;
				this_type = new ObjectType (t);
			}

			generate_type_declaration (this_type, decl_space);
			var cselfparam = new CCodeFormalParameter ("this", this_type.get_cname ());

			function.add_parameter (cselfparam);
		}

		if (acc.writable) {
			var cvalueparam = new CCodeFormalParameter ("value", acc.value_type.get_cname ());
			function.add_parameter (cvalueparam);
		}

		if (prop.is_private_symbol () || acc.access == SymbolAccessibility.PRIVATE) {
			function.modifiers |= CCodeModifiers.STATIC;
		}
		decl_space.add_type_member_declaration (function);

		if (prop.is_abstract || prop.is_virtual) {
			string param_list = "(%s *this".printf (((ObjectTypeSymbol) prop.parent_symbol).get_cname ());
			if (!acc.readable) {
				param_list += ", ";
				param_list += acc.value_type.get_cname ();
			}
			param_list += ")";

			var override_func = new CCodeFunction ("%soverride_%s_%s".printf (prop.parent_symbol.get_lower_case_cprefix (), acc.readable ? "get" : "set", prop.name));
			override_func.add_parameter (new CCodeFormalParameter ("type", "DovaType *"));
			override_func.add_parameter (new CCodeFormalParameter ("(*function) %s".printf (param_list), acc.readable ? acc.value_type.get_cname () : "void"));

			decl_space.add_type_member_declaration (override_func);
		}
	}

	public override void visit_property_accessor (PropertyAccessor acc) {
		var old_symbol = current_symbol;
		bool old_method_inner_error = current_method_inner_error;
		current_symbol = acc;
		current_method_inner_error = false;

		var prop = (Property) acc.prop;

		acc.accept_children (codegen);

		// do not declare overriding properties and interface implementations
		if (prop.is_abstract || prop.is_virtual
		    || (prop.base_property == null && prop.base_interface_property == null)) {
			generate_property_accessor_declaration (acc, source_declarations);

			if (!prop.is_internal_symbol ()
			    && (acc.access == SymbolAccessibility.PUBLIC
				|| acc.access == SymbolAccessibility.PROTECTED)) {
				generate_property_accessor_declaration (acc, header_declarations);
			}
			generate_property_accessor_declaration (acc, internal_header_declarations);
		}

		DataType this_type;
		if (prop.parent_symbol is Struct) {
			var st = (Struct) prop.parent_symbol;
			this_type = SemanticAnalyzer.get_data_type_for_symbol (st);
		} else {
			var t = (ObjectTypeSymbol) prop.parent_symbol;
			this_type = new ObjectType (t);
		}
		var cselfparam = new CCodeFormalParameter ("this", this_type.get_cname ());
		var cvalueparam = new CCodeFormalParameter ("value", acc.value_type.get_cname ());

		string cname = acc.get_cname ();

		if (prop.is_abstract || prop.is_virtual) {
			CCodeFunction function;
			if (acc.readable) {
				function = new CCodeFunction (acc.get_cname (), current_return_type.get_cname ());
			} else {
				function = new CCodeFunction (acc.get_cname (), "void");
			}
			function.add_parameter (cselfparam);
			if (acc.writable) {
				function.add_parameter (cvalueparam);
			}

			if (prop.is_private_symbol () || !(acc.readable || acc.writable) || acc.access == SymbolAccessibility.PRIVATE) {
				// accessor function should be private if the property is an internal symbol
				function.modifiers |= CCodeModifiers.STATIC;
			}

			var block = new CCodeBlock ();
			function.block = block;

			var vcast = get_type_private_from_type ((ObjectTypeSymbol) prop.parent_symbol, get_type_from_instance (new CCodeIdentifier ("this")));

			if (acc.readable) {
				var vcall = new CCodeFunctionCall (new CCodeMemberAccess.pointer (vcast, "get_%s".printf (prop.name)));
				vcall.add_argument (new CCodeIdentifier ("this"));
				block.add_statement (new CCodeReturnStatement (vcall));
			} else {
				var vcall = new CCodeFunctionCall (new CCodeMemberAccess.pointer (vcast, "set_%s".printf (prop.name)));
				vcall.add_argument (new CCodeIdentifier ("this"));
				vcall.add_argument (new CCodeIdentifier ("value"));
				block.add_statement (new CCodeExpressionStatement (vcall));
			}

			source_type_member_definition.append (function);


			string param_list = "(%s *this".printf (((ObjectTypeSymbol) prop.parent_symbol).get_cname ());
			if (!acc.readable) {
				param_list += ", ";
				param_list += acc.value_type.get_cname ();
			}
			param_list += ")";

			var override_func = new CCodeFunction ("%soverride_%s_%s".printf (prop.parent_symbol.get_lower_case_cprefix (), acc.readable ? "get" : "set", prop.name));
			override_func.add_parameter (new CCodeFormalParameter ("type", "DovaType *"));
			override_func.add_parameter (new CCodeFormalParameter ("(*function) %s".printf (param_list), acc.readable ? acc.value_type.get_cname () : "void"));
			override_func.block = new CCodeBlock ();

			vcast = get_type_private_from_type ((ObjectTypeSymbol) prop.parent_symbol, new CCodeIdentifier ("type"));

			override_func.block.add_statement (new CCodeExpressionStatement (new CCodeAssignment (new CCodeMemberAccess.pointer (vcast, "%s_%s".printf (acc.readable ? "get" : "set", prop.name)), new CCodeIdentifier ("function"))));

			source_type_member_definition.append (override_func);
		}

		if (!prop.is_abstract) {
			CCodeFunction function;
			if (acc.writable) {
				function = new CCodeFunction (cname, "void");
			} else {
				function = new CCodeFunction (cname, acc.value_type.get_cname ());
			}

			if (prop.binding == MemberBinding.INSTANCE) {
				function.add_parameter (cselfparam);
			}
			if (acc.writable) {
				function.add_parameter (cvalueparam);
			}

			if (prop.is_private_symbol () || !(acc.readable || acc.writable) || acc.access == SymbolAccessibility.PRIVATE) {
				// accessor function should be private if the property is an internal symbol
				function.modifiers |= CCodeModifiers.STATIC;
			}

			function.block = (CCodeBlock) acc.body.ccodenode;

			if (acc.readable) {
				var cdecl = new CCodeDeclaration (acc.value_type.get_cname ());
				cdecl.add_declarator (new CCodeVariableDeclarator.zero ("result", default_value_for_type (acc.value_type, true)));
				function.block.prepend_statement (cdecl);

				function.block.add_statement (new CCodeReturnStatement (new CCodeIdentifier ("result")));
			}

			source_type_member_definition.append (function);
		}

		current_symbol = old_symbol;
		current_method_inner_error = old_method_inner_error;
	}

	public override void generate_interface_declaration (Interface iface, CCodeDeclarationSpace decl_space) {
		if (decl_space.add_symbol_declaration (iface, iface.get_cname ())) {
			return;
		}

		// typedef to DovaObject instead of dummy struct to avoid warnings/casts
		generate_class_declaration (object_class, decl_space);
		decl_space.add_type_declaration (new CCodeTypeDefinition ("DovaObject", new CCodeVariableDeclarator (iface.get_cname ())));

		generate_class_declaration (type_class, decl_space);

		var type_fun = new CCodeFunction ("%s_type_get".printf (iface.get_lower_case_cname ()), "DovaType *");
		foreach (var type_param in iface.get_type_parameters ()) {
			type_fun.add_parameter (new CCodeFormalParameter ("%s_type".printf (type_param.name.down ()), "DovaType *"));
		}
		decl_space.add_type_member_declaration (type_fun);

		var type_init_fun = new CCodeFunction ("%s_type_init".printf (iface.get_lower_case_cname ()));
		type_init_fun.add_parameter (new CCodeFormalParameter ("type", "DovaType *"));
		foreach (var type_param in iface.get_type_parameters ()) {
			type_init_fun.add_parameter (new CCodeFormalParameter ("%s_type".printf (type_param.name.down ()), "DovaType *"));
		}
		decl_space.add_type_member_declaration (type_init_fun);
	}


	public override bool method_has_wrapper (Method method) {
		return (method.get_attribute ("NoWrapper") == null);
	}

	public override string? get_custom_creturn_type (Method m) {
		var attr = m.get_attribute ("CCode");
		if (attr != null) {
			string type = attr.get_string ("type");
			if (type != null) {
				return type;
			}
		}
		return null;
	}

	public override void generate_method_declaration (Method m, CCodeDeclarationSpace decl_space) {
		if (decl_space.add_symbol_declaration (m, m.get_cname ())) {
			return;
		}

		var function = new CCodeFunction (m.get_cname ());

		if (m.is_private_symbol ()) {
			function.modifiers |= CCodeModifiers.STATIC;
			if (m.is_inline) {
				function.modifiers |= CCodeModifiers.INLINE;
			}
		}

		generate_cparameters (m, decl_space, function, null, new CCodeFunctionCall (new CCodeIdentifier ("fake")));

		decl_space.add_type_member_declaration (function);

		if (m.is_abstract || m.is_virtual) {
			var base_func = function.copy ();
			base_func.name = "%sbase_%s".printf (m.parent_symbol.get_lower_case_cprefix (), m.name);
			base_func.insert_parameter (0, new CCodeFormalParameter ("base_type", "DovaType *"));
			decl_space.add_type_member_declaration (base_func);

			string param_list = "(%s *this".printf (((ObjectTypeSymbol) m.parent_symbol).get_cname ());
			foreach (var param in m.get_parameters ()) {
				param_list += ", ";
				param_list += param.parameter_type.get_cname ();
			}
			if (m.return_type is GenericType) {
				param_list += ", void *";
			}
			if (m.get_error_types ().size > 0) {
				param_list += ", DovaError **";
			}
			param_list += ")";

			var override_func = new CCodeFunction ("%soverride_%s".printf (m.parent_symbol.get_lower_case_cprefix (), m.name));
			override_func.add_parameter (new CCodeFormalParameter ("type", "DovaType *"));
			override_func.add_parameter (new CCodeFormalParameter ("(*function) %s".printf (param_list), (m.return_type is GenericType) ? "void" : m.return_type.get_cname ()));
			decl_space.add_type_member_declaration (override_func);
		}

		if (m is CreationMethod && m.parent_symbol is Class) {
			generate_class_declaration ((Class) m.parent_symbol, decl_space);

			// _init function
			function = new CCodeFunction (m.get_real_cname ());

			if (m.is_private_symbol ()) {
				function.modifiers |= CCodeModifiers.STATIC;
			}

			generate_cparameters (m, decl_space, function);

			decl_space.add_type_member_declaration (function);
		}
	}

	CCodeExpression get_type_from_instance (CCodeExpression instance_expression) {
		return new CCodeMemberAccess.pointer (new CCodeCastExpression (instance_expression, "DovaObject *"), "type");
	}

	public override void visit_method (Method m) {
		var old_symbol = current_symbol;
		bool old_method_inner_error = current_method_inner_error;
		int old_next_temp_var_id = next_temp_var_id;
		var old_temp_vars = temp_vars;
		var old_temp_ref_vars = temp_ref_vars;
		var old_variable_name_map = variable_name_map;
		var old_try = current_try;
		current_symbol = m;
		current_method_inner_error = false;
		next_temp_var_id = 0;
		temp_vars = new ArrayList<LocalVariable> ();
		temp_ref_vars = new ArrayList<LocalVariable> ();
		variable_name_map = new HashMap<string,string> (str_hash, str_equal);
		current_try = null;

		m.accept_children (codegen);

		bool inner_error = current_method_inner_error;

		current_symbol = old_symbol;
		current_method_inner_error = old_method_inner_error;
		next_temp_var_id = old_next_temp_var_id;
		temp_vars = old_temp_vars;
		temp_ref_vars = old_temp_ref_vars;
		variable_name_map = old_variable_name_map;
		current_try = old_try;

		generate_method_declaration (m, source_declarations);

		if (!m.is_internal_symbol ()) {
			generate_method_declaration (m, header_declarations);
		}
		generate_method_declaration (m, internal_header_declarations);

		var function = new CCodeFunction (m.get_real_cname ());
		m.ccodenode = function;

		generate_cparameters (m, source_declarations, function);

		// generate *_real_* functions for virtual methods
		if (!m.is_abstract) {
			if (m.base_method != null || m.base_interface_method != null) {
				// declare *_real_* function
				function.modifiers |= CCodeModifiers.STATIC;
				source_declarations.add_type_member_declaration (function.copy ());
			} else if (m.is_private_symbol ()) {
				function.modifiers |= CCodeModifiers.STATIC;
			}

			if (m.body != null) {
				function.block = (CCodeBlock) m.body.ccodenode;
				function.block.line = function.line;

				var cinit = new CCodeFragment ();
				function.block.prepend_statement (cinit);

				if (m.closure) {
					// add variables for parent closure blocks
					// as closures only have one parameter for the innermost closure block
					var closure_block = current_closure_block;
					int block_id = get_block_id (closure_block);
					while (true) {
						var parent_closure_block = next_closure_block (closure_block.parent_symbol);
						if (parent_closure_block == null) {
							break;
						}
						int parent_block_id = get_block_id (parent_closure_block);

						var parent_data = new CCodeMemberAccess.pointer (new CCodeIdentifier ("_data%d_".printf (block_id)), "_data%d_".printf (parent_block_id));
						var cdecl = new CCodeDeclaration ("Block%dData*".printf (parent_block_id));
						cdecl.add_declarator (new CCodeVariableDeclarator ("_data%d_".printf (parent_block_id), parent_data));

						cinit.append (cdecl);

						closure_block = parent_closure_block;
						block_id = parent_block_id;
					}

					// add self variable for closures
					// as closures have block data parameter
					if (m.binding == MemberBinding.INSTANCE) {
						var cself = new CCodeMemberAccess.pointer (new CCodeIdentifier ("_data%d_".printf (block_id)), "this");
						var cdecl = new CCodeDeclaration ("%s *".printf (current_class.get_cname ()));
						cdecl.add_declarator (new CCodeVariableDeclarator ("this", cself));

						cinit.append (cdecl);
					}
				}
				foreach (FormalParameter param in m.get_parameters ()) {
					if (param.ellipsis) {
						break;
					}

					var t = param.parameter_type.data_type;
					if (t != null && t.is_reference_type ()) {
						if (param.direction == ParameterDirection.OUT) {
							// ensure that the passed reference for output parameter is cleared
							var a = new CCodeAssignment (new CCodeUnaryExpression (CCodeUnaryOperator.POINTER_INDIRECTION, get_variable_cexpression (param.name)), new CCodeConstant ("NULL"));
							var cblock = new CCodeBlock ();
							cblock.add_statement (new CCodeExpressionStatement (a));

							var condition = new CCodeBinaryExpression (CCodeBinaryOperator.INEQUALITY, new CCodeIdentifier (param.name), new CCodeConstant ("NULL"));
							var if_statement = new CCodeIfStatement (condition, cblock);
							cinit.append (if_statement);
						}
					}
				}

				if (!(m.return_type is VoidType) && !(m.return_type is GenericType)) {
					var cdecl = new CCodeDeclaration (m.return_type.get_cname ());
					cdecl.add_declarator (new CCodeVariableDeclarator.zero ("result", default_value_for_type (m.return_type, true)));
					cinit.append (cdecl);

					function.block.add_statement (new CCodeReturnStatement (new CCodeIdentifier ("result")));
				}

				if (inner_error) {
					var cdecl = new CCodeDeclaration ("DovaError *");
					cdecl.add_declarator (new CCodeVariableDeclarator ("_inner_error_", new CCodeConstant ("NULL")));
					cinit.append (cdecl);
				}

				var st = m.parent_symbol as Struct;
				if (m is CreationMethod && st != null && (st.is_boolean_type () || st.is_integer_type () || st.is_floating_type ())) {
					var cdecl = new CCodeDeclaration (st.get_cname ());
					cdecl.add_declarator (new CCodeVariableDeclarator ("this", new CCodeConstant ("0")));
					cinit.append (cdecl);

					function.block.add_statement (new CCodeReturnStatement (new CCodeIdentifier ("this")));
				}

				source_type_member_definition.append (function);
			}
		}

		if (m.is_abstract || m.is_virtual) {
			generate_class_declaration ((Class) object_class, source_declarations);

			var vfunc = new CCodeFunction (m.get_cname (), (m.return_type is GenericType) ? "void" : m.return_type.get_cname ());
			vfunc.block = new CCodeBlock ();

			vfunc.add_parameter (new CCodeFormalParameter ("this", "%s *".printf (((ObjectTypeSymbol) m.parent_symbol).get_cname ())));
			foreach (FormalParameter param in m.get_parameters ()) {
				string ctypename = param.parameter_type.get_cname ();
				if (param.direction != ParameterDirection.IN) {
					ctypename += "*";
				}
				vfunc.add_parameter (new CCodeFormalParameter (param.name, ctypename));
			}
			if (m.return_type is GenericType) {
				vfunc.add_parameter (new CCodeFormalParameter ("result", "void *"));
			}
			if (m.get_error_types ().size > 0) {
				var cparam = new CCodeFormalParameter ("error", "DovaError**");
				vfunc.add_parameter (cparam);
			}

			var vcast = get_type_private_from_type ((ObjectTypeSymbol) m.parent_symbol, get_type_from_instance (new CCodeIdentifier ("this")));

			var vcall = new CCodeFunctionCall (new CCodeMemberAccess.pointer (vcast, m.vfunc_name));
			vcall.add_argument (new CCodeIdentifier ("this"));
			foreach (FormalParameter param in m.get_parameters ()) {
				vcall.add_argument (new CCodeIdentifier (param.name));
			}
			if (m.return_type is GenericType) {
				vcall.add_argument (new CCodeIdentifier ("result"));
			}
			if (m.get_error_types ().size > 0) {
				vcall.add_argument (new CCodeIdentifier ("error"));
			}

			if (m.return_type is VoidType || m.return_type is GenericType) {
				vfunc.block.add_statement (new CCodeExpressionStatement (vcall));
			} else {
				vfunc.block.add_statement (new CCodeReturnStatement (vcall));
			}

			source_type_member_definition.append (vfunc);


			vfunc = new CCodeFunction ("%sbase_%s".printf (m.parent_symbol.get_lower_case_cprefix (), m.name), (m.return_type is GenericType) ? "void" : m.return_type.get_cname ());
			vfunc.block = new CCodeBlock ();

			vfunc.add_parameter (new CCodeFormalParameter ("base_type", "DovaType *"));
			vfunc.add_parameter (new CCodeFormalParameter ("this", "%s *".printf (((ObjectTypeSymbol) m.parent_symbol).get_cname ())));
			foreach (FormalParameter param in m.get_parameters ()) {
				string ctypename = param.parameter_type.get_cname ();
				if (param.direction != ParameterDirection.IN) {
					ctypename += "*";
				}
				vfunc.add_parameter (new CCodeFormalParameter (param.name, ctypename));
			}
			if (m.return_type is GenericType) {
				vfunc.add_parameter (new CCodeFormalParameter ("result", "void *"));
			}
			if (m.get_error_types ().size > 0) {
				var cparam = new CCodeFormalParameter ("error", "DovaError**");
				vfunc.add_parameter (cparam);
			}

			var base_type = new CCodeIdentifier ("base_type");

			vcast = get_type_private_from_type ((ObjectTypeSymbol) m.parent_symbol, base_type);

			vcall = new CCodeFunctionCall (new CCodeMemberAccess.pointer (vcast, m.vfunc_name));
			vcall.add_argument (new CCodeIdentifier ("this"));
			foreach (FormalParameter param in m.get_parameters ()) {
				vcall.add_argument (new CCodeIdentifier (param.name));
			}
			if (m.return_type is GenericType) {
				vcall.add_argument (new CCodeIdentifier ("result"));
			}
			if (m.get_error_types ().size > 0) {
				vcall.add_argument (new CCodeIdentifier ("error"));
			}

			if (m.return_type is VoidType || m.return_type is GenericType) {
				vfunc.block.add_statement (new CCodeExpressionStatement (vcall));
			} else {
				vfunc.block.add_statement (new CCodeReturnStatement (vcall));
			}

			source_type_member_definition.append (vfunc);


			string param_list = "(%s *this".printf (((ObjectTypeSymbol) m.parent_symbol).get_cname ());
			foreach (var param in m.get_parameters ()) {
				param_list += ", ";
				param_list += param.parameter_type.get_cname ();
			}
			if (m.return_type is GenericType) {
				param_list += ", void *";
			}
			if (m.get_error_types ().size > 0) {
				param_list += ", DovaError **";
			}
			param_list += ")";

			var override_func = new CCodeFunction ("%soverride_%s".printf (m.parent_symbol.get_lower_case_cprefix (), m.name));
			override_func.add_parameter (new CCodeFormalParameter ("type", "DovaType *"));
			override_func.add_parameter (new CCodeFormalParameter ("(*function) %s".printf (param_list), (m.return_type is GenericType) ? "void" : m.return_type.get_cname ()));
			override_func.block = new CCodeBlock ();

			vcast = get_type_private_from_type ((ObjectTypeSymbol) m.parent_symbol, new CCodeIdentifier ("type"));

			override_func.block.add_statement (new CCodeExpressionStatement (new CCodeAssignment (new CCodeMemberAccess.pointer (vcast, m.name), new CCodeIdentifier ("function"))));

			source_type_member_definition.append (override_func);
		}

		if (m.entry_point) {
			// m is possible entry point, add appropriate startup code
			var cmain = new CCodeFunction ("main", "int");
			cmain.line = function.line;
			cmain.add_parameter (new CCodeFormalParameter ("argc", "int"));
			cmain.add_parameter (new CCodeFormalParameter ("argv", "char **"));
			var main_block = new CCodeBlock ();

			var array_creation = new CCodeFunctionCall (new CCodeIdentifier ("dova_array_new"));
			array_creation.add_argument (new CCodeFunctionCall (new CCodeIdentifier ("string_type_get")));
			array_creation.add_argument (new CCodeIdentifier ("argc"));

			var cdecl = new CCodeDeclaration ("DovaArray*");
			cdecl.add_declarator (new CCodeVariableDeclarator ("args", array_creation));
			main_block.add_statement (cdecl);

			var array_data = new CCodeFunctionCall (new CCodeIdentifier ("dova_array_get_data"));
			array_data.add_argument (new CCodeIdentifier ("args"));

			cdecl = new CCodeDeclaration ("string**");
			cdecl.add_declarator (new CCodeVariableDeclarator ("args_data", array_data));
			main_block.add_statement (cdecl);

			cdecl = new CCodeDeclaration ("int");
			cdecl.add_declarator (new CCodeVariableDeclarator ("argi"));
			main_block.add_statement (cdecl);

			var string_creation = new CCodeFunctionCall (new CCodeIdentifier ("string_create_from_cstring"));
			string_creation.add_argument (new CCodeElementAccess (new CCodeIdentifier ("argv"), new CCodeIdentifier ("argi")));

			var loop_block = new CCodeBlock ();
			loop_block.add_statement (new CCodeExpressionStatement (new CCodeAssignment (new CCodeElementAccess (new CCodeIdentifier ("args_data"), new CCodeIdentifier ("argi")), string_creation)));

			var for_stmt = new CCodeForStatement (new CCodeBinaryExpression (CCodeBinaryOperator.LESS_THAN, new CCodeIdentifier ("argi"), new CCodeIdentifier ("argc")), loop_block);
			for_stmt.add_initializer (new CCodeAssignment (new CCodeIdentifier ("argi"), new CCodeConstant ("0")));
			for_stmt.add_iterator (new CCodeUnaryExpression (CCodeUnaryOperator.POSTFIX_INCREMENT, new CCodeIdentifier ("argi")));
			main_block.add_statement (for_stmt);

			var main_call = new CCodeFunctionCall (new CCodeIdentifier (function.name));
			if (m.get_parameters ().size == 1) {
				main_call.add_argument (new CCodeIdentifier ("args"));
			}
			if (m.return_type is VoidType) {
				// method returns void, always use 0 as exit code
				var main_stmt = new CCodeExpressionStatement (main_call);
				main_stmt.line = cmain.line;
				main_block.add_statement (main_stmt);
				var ret_stmt = new CCodeReturnStatement (new CCodeConstant ("0"));
				ret_stmt.line = cmain.line;
				main_block.add_statement (ret_stmt);
			} else {
				var main_stmt = new CCodeReturnStatement (main_call);
				main_stmt.line = cmain.line;
				main_block.add_statement (main_stmt);
			}
			cmain.block = main_block;
			source_type_member_definition.append (cmain);
		}
	}

	public override void visit_creation_method (CreationMethod m) {
		bool visible = !m.is_private_symbol ();

		head.visit_method (m);

		DataType creturn_type;
		if (current_type_symbol is Class) {
			creturn_type = new ObjectType (current_class);
		} else {
			creturn_type = new VoidType ();
		}

		// do not generate _new functions for creation methods of abstract classes
		if (current_type_symbol is Class && !current_class.is_abstract) {
			var vfunc = new CCodeFunction (m.get_cname ());

			var vblock = new CCodeBlock ();

			var cdecl = new CCodeDeclaration ("%s *".printf (current_type_symbol.get_cname ()));
			cdecl.add_declarator (new CCodeVariableDeclarator ("this"));
			vblock.add_statement (cdecl);

			source_declarations.add_include ("stddef.h");

			var type_get = new CCodeFunctionCall (new CCodeIdentifier (current_class.get_lower_case_cname () + "_type_get"));
			foreach (var type_param in current_class.get_type_parameters ()) {
				type_get.add_argument (new CCodeIdentifier ("%s_type".printf (type_param.name.down ())));
			}

			var alloc_call = new CCodeFunctionCall (new CCodeIdentifier ("dova_object_alloc"));
			alloc_call.add_argument (type_get);
			vblock.add_statement (new CCodeExpressionStatement (new CCodeAssignment (new CCodeIdentifier ("this"), new CCodeCastExpression (alloc_call, "%s *".printf (current_type_symbol.get_cname ())))));

			// allocate memory for fields of generic types
			// this is only a temporary measure until this can be allocated inline at the end of the instance
			// this also won't work for subclasses of classes that have fields of generic types
			foreach (var f in current_class.get_fields ()) {
				if (f.binding != MemberBinding.INSTANCE || !(f.field_type is GenericType)) {
					continue;
				}

				var generic_type = (GenericType) f.field_type;
				var type_get_value_size = new CCodeFunctionCall (new CCodeIdentifier ("dova_type_get_value_size"));
				type_get_value_size.add_argument (new CCodeIdentifier ("%s_type".printf (generic_type.type_parameter.name.down ())));

				var calloc_call = new CCodeFunctionCall (new CCodeIdentifier ("calloc"));
				calloc_call.add_argument (new CCodeConstant ("1"));
				calloc_call.add_argument (type_get_value_size);
				var priv_call = new CCodeFunctionCall (new CCodeIdentifier ("%s_GET_PRIVATE".printf (current_class.get_upper_case_cname (null))));
				priv_call.add_argument (new CCodeIdentifier ("this"));

				vblock.add_statement (new CCodeExpressionStatement (new CCodeAssignment (new CCodeMemberAccess.pointer (priv_call, f.name), calloc_call)));
			}

			var vcall = new CCodeFunctionCall (new CCodeIdentifier (m.get_real_cname ()));
			vcall.add_argument (new CCodeIdentifier ("this"));
			vblock.add_statement (new CCodeExpressionStatement (vcall));

			generate_cparameters (m, source_declarations, vfunc, null, vcall);
			CCodeStatement cstmt = new CCodeReturnStatement (new CCodeIdentifier ("this"));
			cstmt.line = vfunc.line;
			vblock.add_statement (cstmt);

			if (!visible) {
				vfunc.modifiers |= CCodeModifiers.STATIC;
			}

			source_declarations.add_type_member_declaration (vfunc.copy ());

			vfunc.block = vblock;

			source_type_member_definition.append (vfunc);
		}
	}

	private TypeSymbol? find_parent_type (Symbol sym) {
		while (sym != null) {
			if (sym is TypeSymbol) {
				return (TypeSymbol) sym;
			}
			sym = sym.parent_symbol;
		}
		return null;
	}

	public override void generate_cparameters (Method m, CCodeDeclarationSpace decl_space, CCodeFunction func, CCodeFunctionDeclarator? vdeclarator = null, CCodeFunctionCall? vcall = null) {
		CCodeFormalParameter instance_param = null;
		if (m.closure) {
			var closure_block = current_closure_block;
			int block_id = get_block_id (closure_block);
			instance_param = new CCodeFormalParameter ("_data%d_".printf (block_id), "Block%dData*".printf (block_id));
		} else if (m.parent_symbol is Class && m is CreationMethod) {
			if (vcall == null) {
				instance_param = new CCodeFormalParameter ("this", ((Class) m.parent_symbol).get_cname () + "*");
			}
		} else if (m.binding == MemberBinding.INSTANCE || (m.parent_symbol is Struct && m is CreationMethod)) {
			TypeSymbol parent_type = find_parent_type (m);
			var this_type = get_data_type_for_symbol (parent_type);

			generate_type_declaration (this_type, decl_space);

			if (m.base_interface_method != null && !m.is_abstract && !m.is_virtual) {
				var base_type = new ObjectType ((Interface) m.base_interface_method.parent_symbol);
				instance_param = new CCodeFormalParameter ("this", base_type.get_cname ());
			} else if (m.overrides) {
				var base_type = new ObjectType ((Class) m.base_method.parent_symbol);
				generate_type_declaration (base_type, decl_space);
				instance_param = new CCodeFormalParameter ("this", base_type.get_cname ());
			} else {
				if (m.parent_symbol is Struct && m is CreationMethod) {
					var st = (Struct) m.parent_symbol;
					if (st.is_boolean_type () || st.is_integer_type () || st.is_floating_type ()) {
						// use return value
					} else {
						instance_param = new CCodeFormalParameter ("*this", this_type.get_cname ());
					}
				} else {
					instance_param = new CCodeFormalParameter ("this", this_type.get_cname ());
				}
			}
		}
		if (instance_param != null) {
			func.add_parameter (instance_param);
			if (vdeclarator != null) {
				vdeclarator.add_parameter (instance_param);
			}
		}

		if (m is CreationMethod) {
			generate_class_declaration ((Class) type_class, decl_space);

			if (m.parent_symbol is Class) {
				int type_param_index = 0;
				var cl = (Class) m.parent_symbol;
				foreach (TypeParameter type_param in cl.get_type_parameters ()) {
					var cparam = new CCodeFormalParameter ("%s_type".printf (type_param.name.down ()), "DovaType*");
					if (vcall != null) {
						func.add_parameter (cparam);
					}
					type_param_index++;
				}
			}
		} else {
			int type_param_index = 0;
			foreach (TypeParameter type_param in m.get_type_parameters ()) {
				var cparam = new CCodeFormalParameter ("%s_type".printf (type_param.name.down ()), "DovaType*");
				func.add_parameter (cparam);
				if (vdeclarator != null) {
					vdeclarator.add_parameter (cparam);
				}
				if (vcall != null) {
					vcall.add_argument (new CCodeIdentifier ("%s_type".printf (type_param.name.down ())));
				}
				type_param_index++;
			}
		}

		foreach (FormalParameter param in m.get_parameters ()) {
			CCodeFormalParameter cparam;
			if (!param.ellipsis) {
				string ctypename = param.parameter_type.get_cname ();

				generate_type_declaration (param.parameter_type, decl_space);

				if (param.direction != ParameterDirection.IN && !(param.parameter_type is GenericType)) {
					ctypename += "*";
				}

				cparam = new CCodeFormalParameter (get_variable_cname (param.name), ctypename);
			} else {
				cparam = new CCodeFormalParameter.with_ellipsis ();
			}

			func.add_parameter (cparam);
			if (vdeclarator != null) {
				vdeclarator.add_parameter (cparam);
			}
			if (vcall != null) {
				vcall.add_argument (get_variable_cexpression (param.name));
			}
		}

		if (m.parent_symbol is Class && m is CreationMethod && vcall != null) {
			func.return_type = ((Class) m.parent_symbol).get_cname () + "*";
		} else {
			if (m.return_type is GenericType) {
				func.add_parameter (new CCodeFormalParameter ("result", "void *"));
				if (vdeclarator != null) {
					vdeclarator.add_parameter (new CCodeFormalParameter ("result", "void *"));
				}
			} else {
				var st = m.parent_symbol as Struct;
				if (m is CreationMethod && st != null && (st.is_boolean_type () || st.is_integer_type () || st.is_floating_type ())) {
					func.return_type = st.get_cname ();
				} else {
					func.return_type = m.return_type.get_cname ();
				}
			}

			generate_type_declaration (m.return_type, decl_space);
		}

		if (m.get_error_types ().size > 0 || (m.base_method != null && m.base_method.get_error_types ().size > 0)) {
			var cparam = new CCodeFormalParameter ("error", "DovaError**");
			func.add_parameter (cparam);
			if (vdeclarator != null) {
				vdeclarator.add_parameter (cparam);
			}
			if (vcall != null) {
				vcall.add_argument (new CCodeIdentifier ("error"));
			}
		}
	}

	public override void visit_element_access (ElementAccess expr) {
		var array_type = expr.container.value_type as ArrayType;
		if (array_type != null) {
			// access to element in an array

			expr.accept_children (codegen);

			List<Expression> indices = expr.get_indices ();
			var cindex = (CCodeExpression) indices[0].ccodenode;

			if (array_type.inline_allocated) {
				expr.ccodenode = new CCodeElementAccess ((CCodeExpression) expr.container.ccodenode, cindex);
			} else {
				generate_property_accessor_declaration (((Property) array_class.scope.lookup ("data")).get_accessor, source_declarations);

				var ccontainer = new CCodeFunctionCall (new CCodeIdentifier ("dova_array_get_data"));
				ccontainer.add_argument ((CCodeExpression) expr.container.ccodenode);
				expr.ccodenode = new CCodeElementAccess (new CCodeCastExpression (ccontainer, "%s*".printf (array_type.element_type.get_cname ())), cindex);
			}
		} else {
			base.visit_element_access (expr);
		}
	}
}
