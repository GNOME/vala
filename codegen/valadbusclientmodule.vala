/* valadbusclientmodule.vala
 *
 * Copyright (C) 2007-2009  Jürg Billeter
*  Copyright (C) 2008  Philip Van Hoof
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
 * 	Philip Van Hoof <pvanhoof@gnome.org>
 */

using GLib;
using Gee;

/**
 * The link between a dynamic method and generated code.
 */
internal class Vala.DBusClientModule : DBusModule {
	int dynamic_property_id;

	public DBusClientModule (CCodeGenerator codegen, CCodeModule? next) {
		base (codegen, next);
	}

	string get_dynamic_dbus_name (string vala_name) {
		// TODO switch default to no transformation as soon as we have static D-Bus client support
		// keep transformation by default for static D-Bus client and server support
		if (context.dbus_transformation) {
			return Symbol.lower_case_to_camel_case (vala_name);
		} else {
			return vala_name;
		}
	}

	public override void generate_dynamic_method_wrapper (DynamicMethod method) {
		var dynamic_method = (DynamicMethod) method;

		var func = new CCodeFunction (method.get_cname ());

		var cparam_map = new HashMap<int,CCodeFormalParameter> (direct_hash, direct_equal);

		generate_cparameters (method, source_declarations, cparam_map, func);

		var block = new CCodeBlock ();
		if (dynamic_method.dynamic_type.data_type == dbus_object_type) {
			generate_dbus_method_wrapper (method, block);
		} else {
			Report.error (method.source_reference, "dynamic methods are not supported for `%s'".printf (dynamic_method.dynamic_type.to_string ()));
		}

		// append to C source file
		source_declarations.add_type_member_declaration (func.copy ());

		func.block = block;
		source_type_member_definition.append (func);
	}

	void generate_dbus_method_wrapper (Method method, CCodeBlock block) {
		var dynamic_method = (DynamicMethod) method;

		var expr = dynamic_method.invocation;

		var ccall = new CCodeFunctionCall (new CCodeIdentifier ("dbus_g_proxy_begin_call"));

		ccall.add_argument (new CCodeIdentifier ("self"));

		bool found_out = false;
		Expression callback = null;
		int callback_index = -1;
		int arg_index = 1;
		foreach (Expression arg in expr.get_argument_list ()) {
			if (arg.symbol_reference is Method) {
				// callback
				if (callback != null) {
					Report.error (expr.source_reference, "only one reply callback may be specified in invocation of DBus method");
					expr.error = true;
					return;
				} else if (found_out) {
					Report.error (expr.source_reference, "out argument and reply callback conflict in invocation of DBus method");
					expr.error = true;
					return;
				}
				callback = arg;
				callback_index = arg_index;
			} else if (arg is UnaryExpression && ((UnaryExpression) arg).operator == UnaryOperator.OUT) {
				// out arg
				if (callback != null) {
					Report.error (expr.source_reference, "out argument and reply callback conflict in invocation of DBus method");
					expr.error = true;
					return;
				}
				found_out = true;
			} else {
				// in arg
				if (callback != null || found_out) {
					Report.error (expr.source_reference, "in argument must not follow out argument or reply callback in invocation of DBus method");
					expr.error = true;
					return;
				}
			}
			arg_index++;
		}

		ccall.add_argument (new CCodeConstant ("\"%s\"".printf (get_dynamic_dbus_name (method.name))));

		if (callback != null) {
			var reply_method = (Method) callback.symbol_reference;

			var cb_fun = new CCodeFunction ("_%s_cb".printf (reply_method.get_cname ()), "void");
			cb_fun.modifiers = CCodeModifiers.STATIC;
			cb_fun.add_parameter (new CCodeFormalParameter ("proxy", "DBusGProxy*"));
			cb_fun.add_parameter (new CCodeFormalParameter ("call", "DBusGProxyCall*"));
			cb_fun.add_parameter (new CCodeFormalParameter ("user_data", "void*"));
			cb_fun.block = new CCodeBlock ();
			var cerrdecl = new CCodeDeclaration ("GError*");
			cerrdecl.add_declarator (new CCodeVariableDeclarator ("error", new CCodeConstant ("NULL")));
			cb_fun.block.add_statement (cerrdecl);
			var cend_call = new CCodeFunctionCall (new CCodeIdentifier ("dbus_g_proxy_end_call"));
			cend_call.add_argument (new CCodeIdentifier ("proxy"));
			cend_call.add_argument (new CCodeIdentifier ("call"));
			cend_call.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, new CCodeIdentifier ("error")));
			var creply_call = new CCodeFunctionCall ((CCodeExpression) callback.ccodenode);
			if (reply_method.binding != MemberBinding.STATIC) {
				creply_call.add_argument (new CCodeIdentifier ("user_data"));
			}
			int param_count = reply_method.get_parameters ().size;
			int i = 0;
			foreach (FormalParameter param in reply_method.get_parameters ()) {
				if ((++i) == param_count) {
					if (!(param.parameter_type is ErrorType)) {
						Report.error (null, "DBus reply callbacks must end with GLib.Error argument");
						return;
					}

					break;
				}
				if (param.parameter_type is ArrayType && ((ArrayType) param.parameter_type).element_type.data_type != string_type.data_type) {
					var array_type = (ArrayType) param.parameter_type;
					CCodeDeclaration cdecl;
					if (dbus_use_ptr_array (array_type)) {
						cdecl = new CCodeDeclaration ("GPtrArray*");
					} else {
						cdecl = new CCodeDeclaration ("GArray*");
					}
					cdecl.add_declarator (new CCodeVariableDeclarator (param.name));
					cb_fun.block.add_statement (cdecl);
					cend_call.add_argument (get_dbus_g_type (array_type));
					cend_call.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, new CCodeIdentifier (param.name)));
					creply_call.add_argument (new CCodeMemberAccess.pointer (new CCodeIdentifier (param.name), dbus_use_ptr_array (array_type) ? "pdata" : "data"));
					creply_call.add_argument (new CCodeMemberAccess.pointer (new CCodeIdentifier (param.name), "len"));
				} else {
					var cdecl = new CCodeDeclaration (param.parameter_type.get_cname ());
					cdecl.add_declarator (new CCodeVariableDeclarator (param.name));
					cb_fun.block.add_statement (cdecl);
					cend_call.add_argument (get_dbus_g_type (param.parameter_type));
					cend_call.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, new CCodeIdentifier (param.name)));
					creply_call.add_argument (new CCodeIdentifier (param.name));

					if (param.parameter_type is ArrayType && ((ArrayType) param.parameter_type).element_type.data_type == string_type.data_type) {
						var cstrvlen = new CCodeFunctionCall (new CCodeIdentifier ("g_strv_length"));
						cstrvlen.add_argument (new CCodeIdentifier (param.name));
						creply_call.add_argument (cstrvlen);
					}

				}
			}
			cend_call.add_argument (new CCodeIdentifier ("G_TYPE_INVALID"));
			cb_fun.block.add_statement (new CCodeExpressionStatement (cend_call));
			creply_call.add_argument (new CCodeIdentifier ("error"));
			cb_fun.block.add_statement (new CCodeExpressionStatement (creply_call));

			if (!source_declarations.add_declaration (cb_fun.name)) {
				// avoid duplicate function definition
				source_type_member_definition.append (cb_fun);
			}

			ccall.add_argument (new CCodeIdentifier (cb_fun.name));
			ccall.add_argument (new CCodeConstant ("param%d_target".printf (callback_index)));
			ccall.add_argument (new CCodeConstant ("NULL"));
		} else { 
			ccall.call = new CCodeIdentifier ("dbus_g_proxy_call");

			ccall.add_argument (new CCodeIdentifier ("error"));
		}

		foreach (FormalParameter param in method.get_parameters ()) {
			if (param.parameter_type is MethodType
			    || param.parameter_type is DelegateType) {
				// callback parameter
				break;
			}

			if (param.direction != ParameterDirection.IN) {
				continue;
			}

			var array_type = param.parameter_type as ArrayType;
			if (array_type != null) {
				// array parameter
				if (array_type.element_type.data_type != string_type.data_type) {
					// non-string arrays (use GArray)
					ccall.add_argument (get_dbus_g_type (array_type));

					var sizeof_call = new CCodeFunctionCall (new CCodeIdentifier ("sizeof"));
					sizeof_call.add_argument (new CCodeIdentifier (array_type.element_type.get_cname ()));

					CCodeDeclaration cdecl;
					CCodeFunctionCall array_construct;
					if (dbus_use_ptr_array (array_type)) {
						cdecl = new CCodeDeclaration ("GPtrArray*");

						array_construct = new CCodeFunctionCall (new CCodeIdentifier ("g_ptr_array_sized_new"));
						array_construct.add_argument (new CCodeIdentifier (head.get_array_length_cname (param.name, 1)));
					} else {
						cdecl = new CCodeDeclaration ("GArray*");

						array_construct = new CCodeFunctionCall (new CCodeIdentifier ("g_array_new"));
						array_construct.add_argument (new CCodeConstant ("TRUE"));
						array_construct.add_argument (new CCodeConstant ("TRUE"));
						array_construct.add_argument (sizeof_call);
					}

					cdecl.add_declarator (new CCodeVariableDeclarator ("dbus_%s".printf (param.name), array_construct));
					block.add_statement (cdecl);

					if (dbus_use_ptr_array (array_type)) {
						source_declarations.add_include ("string.h");

						var memcpy_call = new CCodeFunctionCall (new CCodeIdentifier ("memcpy"));
						memcpy_call.add_argument (new CCodeMemberAccess.pointer (new CCodeIdentifier ("dbus_%s".printf (param.name)), "pdata"));
						memcpy_call.add_argument (new CCodeIdentifier (param.name));
						memcpy_call.add_argument (new CCodeBinaryExpression (CCodeBinaryOperator.MUL, new CCodeIdentifier (head.get_array_length_cname (param.name, 1)), sizeof_call));
						block.add_statement (new CCodeExpressionStatement (memcpy_call));

						var len_assignment = new CCodeAssignment (new CCodeMemberAccess.pointer (new CCodeIdentifier ("dbus_%s".printf (param.name)), "len"), new CCodeIdentifier (head.get_array_length_cname (param.name, 1)));
						block.add_statement (new CCodeExpressionStatement (len_assignment));
					} else {
						var cappend_call = new CCodeFunctionCall (new CCodeIdentifier ("g_array_append_vals"));
						cappend_call.add_argument (new CCodeIdentifier ("dbus_%s".printf (param.name)));
						cappend_call.add_argument (new CCodeIdentifier (param.name));
						cappend_call.add_argument (new CCodeIdentifier (head.get_array_length_cname (param.name, 1)));
						block.add_statement (new CCodeExpressionStatement (cappend_call));
					}

					ccall.add_argument (new CCodeIdentifier ("dbus_%s".printf (param.name)));
				} else {
					// string arrays
					ccall.add_argument (new CCodeIdentifier ("G_TYPE_STRV"));
					ccall.add_argument (new CCodeIdentifier (param.name));
				}
			} else if (get_type_signature (param.parameter_type).has_prefix ("(")) {
				// struct parameter
				var st = (Struct) param.parameter_type.data_type;

				var array_construct = new CCodeFunctionCall (new CCodeIdentifier ("g_value_array_new"));
				array_construct.add_argument (new CCodeConstant ("0"));

				var cdecl = new CCodeDeclaration ("GValueArray*");
				cdecl.add_declarator (new CCodeVariableDeclarator ("dbus_%s".printf (param.name), array_construct));
				block.add_statement (cdecl);

				foreach (Field f in st.get_fields ()) {
					if (f.binding != MemberBinding.INSTANCE) {
						continue;
					}

					string val_name = "val_%s_%s".printf (param.name, f.name);

					// 0-initialize struct with struct initializer { 0 }
					var cvalinit = new CCodeInitializerList ();
					cvalinit.append (new CCodeConstant ("0"));

					var cval_decl = new CCodeDeclaration ("GValue");
					cval_decl.add_declarator (new CCodeVariableDeclarator (val_name, cvalinit));
					block.add_statement (cval_decl);

					var val_ptr = new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, new CCodeIdentifier (val_name));

					var cinit_call = new CCodeFunctionCall (new CCodeIdentifier ("g_value_init"));
					cinit_call.add_argument (val_ptr);
					cinit_call.add_argument (new CCodeIdentifier (f.field_type.data_type.get_type_id ()));
					block.add_statement (new CCodeExpressionStatement (cinit_call));

					var cset_call = new CCodeFunctionCall (new CCodeIdentifier (f.field_type.data_type.get_set_value_function ()));
					cset_call.add_argument (val_ptr);
					cset_call.add_argument (new CCodeMemberAccess.pointer (new CCodeIdentifier (param.name), f.name));
					block.add_statement (new CCodeExpressionStatement (cset_call));

					var cappend_call = new CCodeFunctionCall (new CCodeIdentifier ("g_value_array_append"));
					cappend_call.add_argument (new CCodeIdentifier ("dbus_%s".printf (param.name)));
					cappend_call.add_argument (val_ptr);
					block.add_statement (new CCodeExpressionStatement (cappend_call));
				}

				ccall.add_argument (get_dbus_g_type (param.parameter_type));
				ccall.add_argument (new CCodeIdentifier ("dbus_%s".printf (param.name)));
			} else {
				ccall.add_argument (get_dbus_g_type (param.parameter_type));
				ccall.add_argument (new CCodeIdentifier (param.name));
			}
		}

		ccall.add_argument (new CCodeIdentifier ("G_TYPE_INVALID"));

		var out_marshalling_fragment = new CCodeFragment ();

		foreach (FormalParameter param in method.get_parameters ()) {
			if (param.parameter_type is MethodType) {
				// callback parameter
				break;
			}

			if (param.direction != ParameterDirection.OUT) {
				continue;
			}

			if (get_type_signature (param.parameter_type).has_prefix ("(")) {
				// struct output parameter
				var st = (Struct) param.parameter_type.data_type;

				var cdecl = new CCodeDeclaration ("GValueArray*");
				cdecl.add_declarator (new CCodeVariableDeclarator ("dbus_%s".printf (param.name)));
				block.add_statement (cdecl);

				int i = 0;
				foreach (Field f in st.get_fields ()) {
					if (f.binding != MemberBinding.INSTANCE) {
						continue;
					}

					var cget_call = new CCodeFunctionCall (new CCodeIdentifier (f.field_type.data_type.get_get_value_function ()));
					cget_call.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, new CCodeElementAccess (new CCodeMemberAccess.pointer (new CCodeIdentifier ("dbus_%s".printf (param.name)), "values"), new CCodeConstant (i.to_string ()))));

					var converted_value = cget_call;

					if (requires_copy (f.field_type)) {
						var dupexpr = get_dup_func_expression (f.field_type, expr.source_reference);
						converted_value = new CCodeFunctionCall (dupexpr);
						converted_value.add_argument (cget_call);
					}

					var assign = new CCodeAssignment (new CCodeMemberAccess.pointer (new CCodeIdentifier (param.name), f.name), converted_value);
					out_marshalling_fragment.append (new CCodeExpressionStatement (assign));

					i++;
				}

				ccall.add_argument (get_dbus_g_type (param.parameter_type));
				ccall.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, new CCodeIdentifier ("dbus_%s".printf (param.name))));
			} else {
				ccall.add_argument (get_dbus_g_type (param.parameter_type));
				ccall.add_argument (new CCodeIdentifier (param.name));
			}
		}

		if (!(method.return_type is VoidType)) {
			// synchronous D-Bus method call with reply
			var array_type = method.return_type as ArrayType;
			if (array_type != null && array_type.element_type.data_type != string_type.data_type) {
				// non-string arrays (use GArray)
				ccall.add_argument (get_dbus_g_type (array_type));

				CCodeDeclaration cdecl;
				if (dbus_use_ptr_array (array_type)) {
					cdecl = new CCodeDeclaration ("GPtrArray*");
				} else {
					cdecl = new CCodeDeclaration ("GArray*");
				}
				cdecl.add_declarator (new CCodeVariableDeclarator ("result"));
				block.add_statement (cdecl);

				ccall.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, new CCodeIdentifier ("result")));
				ccall.add_argument (new CCodeIdentifier ("G_TYPE_INVALID"));

				block.add_statement (new CCodeExpressionStatement (ccall));

				// don't access result when error occured
				var creturnblock = new CCodeBlock ();
				creturnblock.add_statement (new CCodeReturnStatement (default_value_for_type (method.return_type, false)));
				var cerrorif = new CCodeIfStatement (new CCodeUnaryExpression (CCodeUnaryOperator.POINTER_INDIRECTION, new CCodeIdentifier ("error")), creturnblock);
				block.add_statement (cerrorif);

				block.add_statement (out_marshalling_fragment);

				// *result_length1 = result->len;
				var garray_length = new CCodeMemberAccess.pointer (new CCodeIdentifier ("result"), "len");
				var result_length = new CCodeUnaryExpression (CCodeUnaryOperator.POINTER_INDIRECTION, new CCodeIdentifier ("result_length1"));
				var assign = new CCodeAssignment (result_length, garray_length);
				block.add_statement (new CCodeExpressionStatement (assign));

				// return result->data;
				block.add_statement (new CCodeReturnStatement (new CCodeCastExpression (new CCodeMemberAccess.pointer (new CCodeIdentifier ("result"), dbus_use_ptr_array (array_type) ? "pdata" : "data"), method.return_type.get_cname ())));
			} else {
				// string arrays or other datatypes

				ccall.add_argument (get_dbus_g_type (method.return_type));

				var cdecl = new CCodeDeclaration (method.return_type.get_cname ());
				cdecl.add_declarator (new CCodeVariableDeclarator ("result"));
				block.add_statement (cdecl);

				ccall.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, new CCodeIdentifier ("result")));
				ccall.add_argument (new CCodeIdentifier ("G_TYPE_INVALID"));

				block.add_statement (new CCodeExpressionStatement (ccall));

				// don't access result when error occured
				var creturnblock = new CCodeBlock ();
				creturnblock.add_statement (new CCodeReturnStatement (default_value_for_type (method.return_type, false)));
				var cerrorif = new CCodeIfStatement (new CCodeUnaryExpression (CCodeUnaryOperator.POINTER_INDIRECTION, new CCodeIdentifier ("error")), creturnblock);
				block.add_statement (cerrorif);

				block.add_statement (out_marshalling_fragment);

				if (array_type != null) {
					// special case string array

					// *result_length1 = g_strv_length (result);
					var cstrvlen = new CCodeFunctionCall (new CCodeIdentifier ("g_strv_length"));
					cstrvlen.add_argument (new CCodeIdentifier ("result"));
					var result_length = new CCodeUnaryExpression (CCodeUnaryOperator.POINTER_INDIRECTION, new CCodeIdentifier ("result_length1"));
					var assign = new CCodeAssignment (result_length, cstrvlen);
					block.add_statement (new CCodeExpressionStatement (assign));
				}

				block.add_statement (new CCodeReturnStatement (new CCodeIdentifier ("result")));
			}
		} else {
			ccall.add_argument (new CCodeIdentifier ("G_TYPE_INVALID"));

			block.add_statement (new CCodeExpressionStatement (ccall));

			// don't access result when error occured
			var creturnblock = new CCodeBlock ();
			creturnblock.add_statement (new CCodeReturnStatement ());
			var cerrorif = new CCodeIfStatement (new CCodeUnaryExpression (CCodeUnaryOperator.POINTER_INDIRECTION, new CCodeIdentifier ("error")), creturnblock);
			block.add_statement (cerrorif);

			block.add_statement (out_marshalling_fragment);
		}
	}

	public override CCodeExpression get_dbus_g_type (DataType data_type) {
		if (data_type is ArrayType) {
			var array_type = data_type as ArrayType;
			if (array_type.element_type.data_type == string_type.data_type) {
				return new CCodeIdentifier ("G_TYPE_STRV");
			}

			var carray_type = new CCodeFunctionCall (new CCodeIdentifier ("dbus_g_type_get_collection"));
			if (dbus_use_ptr_array (array_type)) {
				carray_type.add_argument (new CCodeConstant ("\"GPtrArray\""));
			} else {
				carray_type.add_argument (new CCodeConstant ("\"GArray\""));
			}
			carray_type.add_argument (get_dbus_g_type (array_type.element_type));
			return carray_type;
		} else if (data_type.data_type is Enum) {
			var en = (Enum) data_type.data_type;
			if (en.is_flags) {
				return new CCodeIdentifier ("G_TYPE_UINT");
			} else {
				return new CCodeIdentifier ("G_TYPE_INT");
			}
		} else if (data_type.data_type == null) {
			critical ("Internal error during DBus type generation with: %s", data_type.to_string ());
			return new CCodeIdentifier ("G_TYPE_NONE");
		} else if (data_type.data_type.get_full_name () == "GLib.HashTable") {
			var cmap_type = new CCodeFunctionCall (new CCodeIdentifier ("dbus_g_type_get_map"));
			var type_args = data_type.get_type_arguments ();

			cmap_type.add_argument (new CCodeConstant ("\"GHashTable\""));
			foreach (DataType type_arg in type_args) {
				cmap_type.add_argument (get_dbus_g_type (type_arg));
			}

			return cmap_type;
		} else if (get_type_signature (data_type).has_prefix ("(")) {
			// struct parameter
			var st = (Struct) data_type.data_type;

			var type_call = new CCodeFunctionCall (new CCodeIdentifier ("dbus_g_type_get_struct"));
			type_call.add_argument (new CCodeConstant ("\"GValueArray\""));

			foreach (Field f in st.get_fields ()) {
				if (f.binding != MemberBinding.INSTANCE) {
					continue;
				}

				type_call.add_argument (get_dbus_g_type (f.field_type));
			}

			type_call.add_argument (new CCodeConstant ("G_TYPE_INVALID"));

			return type_call;
		} else {
			return new CCodeIdentifier (data_type.data_type.get_type_id ());
		}
	}

	public bool dbus_use_ptr_array (ArrayType array_type) {
		if (array_type.element_type.data_type == string_type.data_type) {
			// use char**
			return false;
		} else if (array_type.element_type.data_type == bool_type.data_type
		           || array_type.element_type.data_type == char_type.data_type
		           || array_type.element_type.data_type == uchar_type.data_type
		           || array_type.element_type.data_type == int_type.data_type
		           || array_type.element_type.data_type == uint_type.data_type
		           || array_type.element_type.data_type == long_type.data_type
		           || array_type.element_type.data_type == ulong_type.data_type
		           || array_type.element_type.data_type == int8_type.data_type
		           || array_type.element_type.data_type == uint8_type.data_type
		           || array_type.element_type.data_type == int32_type.data_type
		           || array_type.element_type.data_type == uint32_type.data_type
		           || array_type.element_type.data_type == int64_type.data_type
		           || array_type.element_type.data_type == uint64_type.data_type
		           || array_type.element_type.data_type == double_type.data_type) {
			// use GArray
			return false;
		} else {
			// use GPtrArray
			return true;
		}
	}

	public override string get_dynamic_property_getter_cname (DynamicProperty prop) {
		if (prop.dynamic_type.data_type != dbus_object_type) {
			return base.get_dynamic_property_getter_cname (prop);
		}

		string getter_cname = "_dynamic_get_%s%d".printf (prop.name, dynamic_property_id++);

		if (get_type_signature (prop.property_type) == null) {
			Report.error (prop.property_type.source_reference, "D-Bus serialization of type `%s' is not supported".printf (prop.property_type.to_string ()));
			return getter_cname;
		}

		var func = new CCodeFunction (getter_cname, prop.property_type.get_cname ());
		func.modifiers |= CCodeModifiers.STATIC | CCodeModifiers.INLINE;

		func.add_parameter (new CCodeFormalParameter ("obj", prop.dynamic_type.get_cname ()));

		var block = new CCodeBlock ();
		generate_dbus_property_getter_wrapper (prop, block);

		// append to C source file
		source_declarations.add_type_member_declaration (func.copy ());

		func.block = block;
		source_type_member_definition.append (func);

		return getter_cname;
	}

	public override string get_dynamic_property_setter_cname (DynamicProperty prop) {
		if (prop.dynamic_type.data_type != dbus_object_type) {
			return base.get_dynamic_property_setter_cname (prop);
		}

		string setter_cname = "_dynamic_set_%s%d".printf (prop.name, dynamic_property_id++);

		if (get_type_signature (prop.property_type) == null) {
			Report.error (prop.property_type.source_reference, "D-Bus serialization of type `%s' is not supported".printf (prop.property_type.to_string ()));
			return setter_cname;
		}

		var func = new CCodeFunction (setter_cname, "void");
		func.modifiers |= CCodeModifiers.STATIC | CCodeModifiers.INLINE;

		func.add_parameter (new CCodeFormalParameter ("obj", prop.dynamic_type.get_cname ()));
		func.add_parameter (new CCodeFormalParameter ("value", prop.property_type.get_cname ()));

		var block = new CCodeBlock ();
		generate_dbus_property_setter_wrapper (prop, block);

		// append to C source file
		source_declarations.add_type_member_declaration (func.copy ());

		func.block = block;
		source_type_member_definition.append (func);

		return setter_cname;
	}

	void create_dbus_property_proxy (DynamicProperty node, CCodeBlock block) {
		var prop_proxy_call = new CCodeFunctionCall (new CCodeIdentifier ("dbus_g_proxy_new_from_proxy"));
		prop_proxy_call.add_argument (new CCodeIdentifier ("obj"));
		prop_proxy_call.add_argument (new CCodeConstant ("DBUS_INTERFACE_PROPERTIES"));
		prop_proxy_call.add_argument (new CCodeConstant ("NULL"));

		var prop_proxy_decl = new CCodeDeclaration ("DBusGProxy*");
		prop_proxy_decl.add_declarator (new CCodeVariableDeclarator ("property_proxy", prop_proxy_call));
		block.add_statement (prop_proxy_decl);
	}

	void generate_dbus_property_getter_wrapper (DynamicProperty node, CCodeBlock block) {
		create_dbus_property_proxy (node, block);

		// initialize GValue
		var cvalinit = new CCodeInitializerList ();
		cvalinit.append (new CCodeConstant ("0"));

		var cval_decl = new CCodeDeclaration ("GValue");
		cval_decl.add_declarator (new CCodeVariableDeclarator ("gvalue", cvalinit));
		block.add_statement (cval_decl);

		var val_ptr = new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, new CCodeIdentifier ("gvalue"));

		// call Get method on property proxy
		var cdecl = new CCodeDeclaration (node.property_type.get_cname ());
		cdecl.add_declarator (new CCodeVariableDeclarator ("result"));
		block.add_statement (cdecl);

		var ccall = new CCodeFunctionCall (new CCodeIdentifier ("dbus_g_proxy_call"));
		ccall.add_argument (new CCodeIdentifier ("property_proxy"));
		ccall.add_argument (new CCodeConstant ("\"Get\""));
		ccall.add_argument (new CCodeConstant ("NULL"));

		ccall.add_argument (new CCodeIdentifier ("G_TYPE_STRING"));
		var get_iface = new CCodeFunctionCall (new CCodeIdentifier ("dbus_g_proxy_get_interface"));
		get_iface.add_argument (new CCodeIdentifier ("obj"));
		ccall.add_argument (get_iface);

		ccall.add_argument (new CCodeIdentifier ("G_TYPE_STRING"));
		ccall.add_argument (new CCodeConstant ("\"%s\"".printf (get_dynamic_dbus_name (node.name))));

		ccall.add_argument (new CCodeIdentifier ("G_TYPE_INVALID"));

		ccall.add_argument (new CCodeIdentifier ("G_TYPE_VALUE"));
		ccall.add_argument (val_ptr);

		ccall.add_argument (new CCodeIdentifier ("G_TYPE_INVALID"));

		block.add_statement (new CCodeExpressionStatement (ccall));

		// unref property proxy
		var prop_proxy_unref = new CCodeFunctionCall (new CCodeIdentifier ("g_object_unref"));
		prop_proxy_unref.add_argument (new CCodeIdentifier ("property_proxy"));
		block.add_statement (new CCodeExpressionStatement (prop_proxy_unref));

		// assign value to result variable
		var cget_call = new CCodeFunctionCall (new CCodeIdentifier (node.property_type.data_type.get_get_value_function ()));
		cget_call.add_argument (val_ptr);
		var assign = new CCodeAssignment (new CCodeIdentifier ("result"), cget_call);
		block.add_statement (new CCodeExpressionStatement (assign));

		// return result
		block.add_statement (new CCodeReturnStatement (new CCodeIdentifier ("result")));
	}

	void generate_dbus_property_setter_wrapper (DynamicProperty node, CCodeBlock block) {
		create_dbus_property_proxy (node, block);

		// initialize GValue
		var cvalinit = new CCodeInitializerList ();
		cvalinit.append (new CCodeConstant ("0"));

		var cval_decl = new CCodeDeclaration ("GValue");
		cval_decl.add_declarator (new CCodeVariableDeclarator ("gvalue", cvalinit));
		block.add_statement (cval_decl);

		var val_ptr = new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, new CCodeIdentifier ("gvalue"));

		var cinit_call = new CCodeFunctionCall (new CCodeIdentifier ("g_value_init"));
		cinit_call.add_argument (val_ptr);
		cinit_call.add_argument (new CCodeIdentifier (node.property_type.data_type.get_type_id ()));
		block.add_statement (new CCodeExpressionStatement (cinit_call));

		var cset_call = new CCodeFunctionCall (new CCodeIdentifier (node.property_type.data_type.get_set_value_function ()));
		cset_call.add_argument (val_ptr);
		cset_call.add_argument (new CCodeIdentifier ("value"));
		block.add_statement (new CCodeExpressionStatement (cset_call));

		// call Set method on property proxy
		var ccall = new CCodeFunctionCall (new CCodeIdentifier ("dbus_g_proxy_call"));
		ccall.add_argument (new CCodeIdentifier ("property_proxy"));
		ccall.add_argument (new CCodeConstant ("\"Set\""));
		ccall.add_argument (new CCodeConstant ("NULL"));

		ccall.add_argument (new CCodeIdentifier ("G_TYPE_STRING"));
		var get_iface = new CCodeFunctionCall (new CCodeIdentifier ("dbus_g_proxy_get_interface"));
		get_iface.add_argument (new CCodeIdentifier ("obj"));
		ccall.add_argument (get_iface);

		ccall.add_argument (new CCodeIdentifier ("G_TYPE_STRING"));
		ccall.add_argument (new CCodeConstant ("\"%s\"".printf (get_dynamic_dbus_name (node.name))));

		ccall.add_argument (new CCodeIdentifier ("G_TYPE_VALUE"));
		ccall.add_argument (val_ptr);

		ccall.add_argument (new CCodeIdentifier ("G_TYPE_INVALID"));

		ccall.add_argument (new CCodeIdentifier ("G_TYPE_INVALID"));

		block.add_statement (new CCodeExpressionStatement (ccall));

		// unref property proxy
		var prop_proxy_unref = new CCodeFunctionCall (new CCodeIdentifier ("g_object_unref"));
		prop_proxy_unref.add_argument (new CCodeIdentifier ("property_proxy"));
		block.add_statement (new CCodeExpressionStatement (prop_proxy_unref));
	}

	public override string get_dynamic_signal_connect_wrapper_name (DynamicSignal sig) {
		if (sig.dynamic_type.data_type != dbus_object_type) {
			return base.get_dynamic_signal_connect_wrapper_name (sig);
		}

		string connect_wrapper_name = "_%sconnect".printf (get_dynamic_signal_cname (sig));
		var func = new CCodeFunction (connect_wrapper_name, "void");
		func.add_parameter (new CCodeFormalParameter ("obj", "gpointer"));
		func.add_parameter (new CCodeFormalParameter ("signal_name", "const char *"));
		func.add_parameter (new CCodeFormalParameter ("handler", "GCallback"));
		func.add_parameter (new CCodeFormalParameter ("data", "gpointer"));
		var block = new CCodeBlock ();
		generate_dbus_connect_wrapper (sig, block);

		// append to C source file
		source_declarations.add_type_member_declaration (func.copy ());

		func.block = block;
		source_type_member_definition.append (func);

		return connect_wrapper_name;
	}

	public override string get_dynamic_signal_disconnect_wrapper_name (DynamicSignal sig) {
		if (sig.dynamic_type.data_type != dbus_object_type) {
			return base.get_dynamic_signal_disconnect_wrapper_name (sig);
		}

		string disconnect_wrapper_name = "_%sdisconnect".printf (get_dynamic_signal_cname (sig));
		var func = new CCodeFunction (disconnect_wrapper_name, "void");
		func.add_parameter (new CCodeFormalParameter ("obj", "gpointer"));
		func.add_parameter (new CCodeFormalParameter ("signal_name", "const char *"));
		func.add_parameter (new CCodeFormalParameter ("handler", "GCallback"));
		func.add_parameter (new CCodeFormalParameter ("data", "gpointer"));
		var block = new CCodeBlock ();
		generate_dbus_disconnect_wrapper (sig, block);

		// append to C source file
		source_declarations.add_type_member_declaration (func.copy ());

		func.block = block;
		source_type_member_definition.append (func);

		return disconnect_wrapper_name;
	}

	void generate_dbus_connect_wrapper (DynamicSignal sig, CCodeBlock block) {
		var m = (Method) sig.handler.symbol_reference;

		sig.accept (codegen);

		// FIXME should only be done once per marshaller
		var register_call = new CCodeFunctionCall (new CCodeIdentifier ("dbus_g_object_register_marshaller"));
		head.generate_marshaller (sig.get_parameters (), sig.return_type, true);
		register_call.add_argument (new CCodeIdentifier (head.get_marshaller_function (sig.get_parameters (), sig.return_type, null, true)));
		register_call.add_argument (new CCodeIdentifier ("G_TYPE_NONE"));

		var add_call = new CCodeFunctionCall (new CCodeIdentifier ("dbus_g_proxy_add_signal"));
		add_call.add_argument (new CCodeIdentifier ("obj"));
		add_call.add_argument (new CCodeConstant ("\"%s\"".printf (get_dynamic_dbus_name (sig.name))));

		bool first = true;
		foreach (FormalParameter param in m.get_parameters ()) {
			if (first) {
				// skip sender parameter
				first = false;
				continue;
			}

			register_call.add_argument (get_dbus_g_type (param.parameter_type));
			add_call.add_argument (get_dbus_g_type (param.parameter_type));
		}
		register_call.add_argument (new CCodeIdentifier ("G_TYPE_INVALID"));
		add_call.add_argument (new CCodeIdentifier ("G_TYPE_INVALID"));

		block.add_statement (new CCodeExpressionStatement (register_call));
		block.add_statement (new CCodeExpressionStatement (add_call));

		var call = new CCodeFunctionCall (new CCodeIdentifier ("dbus_g_proxy_connect_signal"));
		call.add_argument (new CCodeIdentifier ("obj"));
		call.add_argument (new CCodeIdentifier ("signal_name"));
		call.add_argument (new CCodeIdentifier ("handler"));
		call.add_argument (new CCodeIdentifier ("data"));
		call.add_argument (new CCodeConstant ("NULL"));
		block.add_statement (new CCodeExpressionStatement (call));
	}

	void generate_dbus_disconnect_wrapper (DynamicSignal sig, CCodeBlock block) {
		var call = new CCodeFunctionCall (new CCodeIdentifier ("dbus_g_proxy_disconnect_signal"));
		call.add_argument (new CCodeIdentifier ("obj"));
		call.add_argument (new CCodeIdentifier ("signal_name"));
		call.add_argument (new CCodeIdentifier ("handler"));
		call.add_argument (new CCodeIdentifier ("data"));
		block.add_statement (new CCodeExpressionStatement (call));
	}

	public override void visit_cast_expression (CastExpression expr) {
		// handles casting DBus.Object instances to DBus interfaces

		var type = expr.type_reference as ObjectType;
		var call = expr.inner as MethodCall;
		if (type == null || !(type.type_symbol is Interface)
		    || type.type_symbol.get_attribute ("DBus") == null || call == null) {
			base.visit_cast_expression (expr);
			return;
		}

		var mtype = call.call.value_type as MethodType;
		if (mtype == null || mtype.method_symbol.get_cname () != "dbus_g_proxy_new_for_name") {
			base.visit_cast_expression (expr);
			return;
		}

		var args = call.get_argument_list ();
		Expression connection = ((MemberAccess) call.call).inner;
		Expression bus_name = args.get (0);
		Expression object_path = args.get (1);

		var ccall = new CCodeFunctionCall (new CCodeIdentifier (type.type_symbol.get_lower_case_cprefix () + "dbus_proxy_new"));
		connection.accept (codegen);
		ccall.add_argument ((CCodeExpression) connection.ccodenode);
		bus_name.accept (codegen);
		ccall.add_argument ((CCodeExpression) bus_name.ccodenode);
		object_path.accept (codegen);
		ccall.add_argument ((CCodeExpression) object_path.ccodenode);
		expr.ccodenode = ccall;
	}

	public override void visit_interface (Interface iface) {
		base.visit_interface (iface);

		var dbus = iface.get_attribute ("DBus");
		if (dbus == null) {
			return;
		}
		string dbus_iface_name = dbus.get_string ("name");
		if (dbus_iface_name == null) {
			return;
		}

		// create proxy class
		string cname = iface.get_cname () + "DBusProxy";
		string lower_cname = iface.get_lower_case_cprefix () + "dbus_proxy";

		if (iface.access != SymbolAccessibility.PRIVATE) {
			dbus_glib_h_needed_in_header = true;
		} else {
			dbus_glib_h_needed = true;
		}

		source_declarations.add_type_declaration (new CCodeTypeDefinition ("struct _%s".printf (cname), new CCodeVariableDeclarator (cname)));
		source_declarations.add_type_declaration (new CCodeTypeDefinition ("DBusGProxyClass", new CCodeVariableDeclarator (cname + "Class")));

		var instance_struct = new CCodeStruct ("_%s".printf (cname));
		instance_struct.add_field ("DBusGProxy", "parent_instance");
		instance_struct.add_field ("gboolean", "disposed");

		source_declarations.add_type_definition (instance_struct);

		source_declarations.add_type_member_declaration (new CCodeFunction(lower_cname + "_get_type", "GType"));

		var implement = new CCodeFunctionCall (new CCodeIdentifier ("G_IMPLEMENT_INTERFACE"));
		implement.add_argument (new CCodeIdentifier (iface.get_upper_case_cname ("TYPE_")));
		implement.add_argument (new CCodeIdentifier (lower_cname + "_interface_init"));

		var define_type = new CCodeFunctionCall (new CCodeIdentifier ("G_DEFINE_TYPE_EXTENDED"));
		define_type.add_argument (new CCodeIdentifier (cname));
		define_type.add_argument (new CCodeIdentifier (lower_cname));
		define_type.add_argument (new CCodeIdentifier ("DBUS_TYPE_G_PROXY"));
		define_type.add_argument (new CCodeConstant ("0"));
		define_type.add_argument (implement);

		source_type_member_definition.append (new CCodeExpressionStatement (define_type));

		// generate proxy_new function
		var proxy_new = new CCodeFunction (lower_cname + "_new", iface.get_cname () + "*");
		proxy_new.add_parameter (new CCodeFormalParameter ("connection", "DBusGConnection*"));
		proxy_new.add_parameter (new CCodeFormalParameter ("name", "const char*"));
		proxy_new.add_parameter (new CCodeFormalParameter ("path", "const char*"));

		var new_block = new CCodeBlock ();

		// create proxy object
		var new_call = new CCodeFunctionCall (new CCodeIdentifier ("g_object_new"));
		new_call.add_argument (new CCodeFunctionCall (new CCodeIdentifier (lower_cname + "_get_type")));
		new_call.add_argument (new CCodeConstant ("\"connection\""));
		new_call.add_argument (new CCodeIdentifier ("connection"));
		new_call.add_argument (new CCodeConstant ("\"name\""));
		new_call.add_argument (new CCodeIdentifier ("name"));
		new_call.add_argument (new CCodeConstant ("\"path\""));
		new_call.add_argument (new CCodeIdentifier ("path"));
		new_call.add_argument (new CCodeConstant ("\"interface\""));
		new_call.add_argument (new CCodeConstant ("\"%s\"".printf (dbus_iface_name)));
		new_call.add_argument (new CCodeConstant ("NULL"));

		var cdecl = new CCodeDeclaration (iface.get_cname () + "*");
		cdecl.add_declarator (new CCodeVariableDeclarator ("self", new_call));
		new_block.add_statement (cdecl);
		new_block.add_statement (new CCodeReturnStatement (new CCodeIdentifier ("self")));

		source_declarations.add_type_member_declaration (proxy_new.copy ());
		proxy_new.block = new_block;
		source_type_member_definition.append (proxy_new);

		// dbus proxy construct
		var proxy_construct = new CCodeFunction (lower_cname + "_construct", "GObject*");
		proxy_construct.add_parameter (new CCodeFormalParameter ("gtype", "GType"));
		proxy_construct.add_parameter (new CCodeFormalParameter ("n_properties", "guint"));
		proxy_construct.add_parameter (new CCodeFormalParameter ("properties", "GObjectConstructParam*"));
		proxy_construct.modifiers = CCodeModifiers.STATIC;
		proxy_construct.block = new CCodeBlock ();

		// chain up
		var parent_class = new CCodeFunctionCall (new CCodeIdentifier ("G_OBJECT_CLASS"));
		parent_class.add_argument (new CCodeIdentifier (lower_cname + "_parent_class"));
		var chainup = new CCodeFunctionCall (new CCodeMemberAccess.pointer (parent_class, "constructor"));
		chainup.add_argument (new CCodeIdentifier ("gtype"));
		chainup.add_argument (new CCodeIdentifier ("n_properties"));
		chainup.add_argument (new CCodeIdentifier ("properties"));

		cdecl = new CCodeDeclaration ("GObject*");
		cdecl.add_declarator (new CCodeVariableDeclarator ("self", chainup));
		proxy_construct.block.add_statement (cdecl);

		cdecl = new CCodeDeclaration ("DBusGConnection");
		cdecl.add_declarator (new CCodeVariableDeclarator ("*connection"));
		proxy_construct.block.add_statement (cdecl);

		var gconnection = new CCodeFunctionCall (new CCodeIdentifier ("g_object_get"));
		gconnection.add_argument (new CCodeIdentifier ("self"));
		gconnection.add_argument (new CCodeConstant ("\"connection\""));
		gconnection.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, new CCodeIdentifier ("connection")));
		gconnection.add_argument (new CCodeConstant ("NULL"));
		proxy_construct.block.add_statement (new CCodeExpressionStatement (gconnection));

		cdecl = new CCodeDeclaration ("char*");
		cdecl.add_declarator (new CCodeVariableDeclarator ("path"));
		proxy_construct.block.add_statement (cdecl);

		var path = new CCodeFunctionCall (new CCodeIdentifier ("g_object_get"));
		path.add_argument (new CCodeIdentifier ("self"));
		path.add_argument (new CCodeConstant ("\"path\""));
		path.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, new CCodeIdentifier ("path")));
		path.add_argument (new CCodeConstant ("NULL"));
		proxy_construct.block.add_statement (new CCodeExpressionStatement (path));

		var raw_connection = new CCodeFunctionCall (new CCodeIdentifier ("dbus_g_connection_get_connection"));
		raw_connection.add_argument (new CCodeIdentifier ("connection"));

		// add filter to handle signals from the remote object
		var filter_call = new CCodeFunctionCall (new CCodeIdentifier ("dbus_connection_add_filter"));
		filter_call.add_argument (raw_connection);
		filter_call.add_argument (new CCodeIdentifier (lower_cname + "_filter"));
		filter_call.add_argument (new CCodeIdentifier ("self"));
		filter_call.add_argument (new CCodeConstant ("NULL"));
		proxy_construct.block.add_statement (new CCodeExpressionStatement (filter_call));

		var filter_printf = new CCodeFunctionCall (new CCodeIdentifier ("g_strdup_printf"));
		filter_printf.add_argument (new CCodeConstant ("\"type='signal',path='%s'\""));
		filter_printf.add_argument (new CCodeIdentifier ("path"));

		cdecl = new CCodeDeclaration ("char*");
		cdecl.add_declarator (new CCodeVariableDeclarator ("filter", filter_printf));
		proxy_construct.block.add_statement (cdecl);

		// ensure we receive signals from the remote object
		var match_call = new CCodeFunctionCall (new CCodeIdentifier ("dbus_bus_add_match"));
		match_call.add_argument (raw_connection);
		match_call.add_argument (new CCodeIdentifier ("filter"));
		match_call.add_argument (new CCodeConstant ("NULL"));
		proxy_construct.block.add_statement (new CCodeExpressionStatement (match_call));

		var connection_free = new CCodeFunctionCall (new CCodeIdentifier ("dbus_g_connection_unref"));
		connection_free.add_argument (new CCodeIdentifier ("connection"));
		proxy_construct.block.add_statement (new CCodeExpressionStatement (connection_free));

		var path_free = new CCodeFunctionCall (new CCodeIdentifier ("g_free"));
		path_free.add_argument (new CCodeIdentifier ("path"));
		proxy_construct.block.add_statement (new CCodeExpressionStatement (path_free));

		var filter_free = new CCodeFunctionCall (new CCodeIdentifier ("g_free"));
		filter_free.add_argument (new CCodeIdentifier ("filter"));
		proxy_construct.block.add_statement (new CCodeExpressionStatement (filter_free));

		proxy_construct.block.add_statement (new CCodeReturnStatement (new CCodeIdentifier ("self")));

		source_type_member_definition.append (proxy_construct);

		// dbus proxy filter function
		generate_proxy_filter_function (iface);

		// dbus proxy dispose
		var proxy_dispose = new CCodeFunction (lower_cname + "_dispose", "void");
		proxy_dispose.add_parameter (new CCodeFormalParameter ("self", "GObject*"));
		proxy_dispose.modifiers = CCodeModifiers.STATIC;
		proxy_dispose.block = new CCodeBlock ();

		cdecl = new CCodeDeclaration ("DBusGConnection");
		cdecl.add_declarator (new CCodeVariableDeclarator ("*connection"));
		proxy_dispose.block.add_statement (cdecl);

		// return if proxy is already disposed
		var dispose_return_block = new CCodeBlock ();
		dispose_return_block.add_statement (new CCodeReturnStatement ());
		proxy_dispose.block.add_statement (new CCodeIfStatement (new CCodeMemberAccess.pointer (new CCodeCastExpression (new CCodeIdentifier ("self"), cname + "*"), "disposed"), dispose_return_block));

		// mark proxy as disposed
		proxy_dispose.block.add_statement (new CCodeExpressionStatement (new CCodeAssignment (new CCodeMemberAccess.pointer (new CCodeCastExpression (new CCodeIdentifier ("self"), cname + "*"), "disposed"), new CCodeConstant ("TRUE"))));

		gconnection = new CCodeFunctionCall (new CCodeIdentifier ("g_object_get"));
		gconnection.add_argument (new CCodeIdentifier ("self"));
		gconnection.add_argument (new CCodeConstant ("\"connection\""));
		gconnection.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, new CCodeIdentifier ("connection")));
		gconnection.add_argument (new CCodeConstant ("NULL"));
		proxy_dispose.block.add_statement (new CCodeExpressionStatement (gconnection));

		// remove filter
		filter_call = new CCodeFunctionCall (new CCodeIdentifier ("dbus_connection_remove_filter"));
		filter_call.add_argument (raw_connection);
		filter_call.add_argument (new CCodeIdentifier (lower_cname + "_filter"));
		filter_call.add_argument (new CCodeIdentifier ("self"));
		proxy_dispose.block.add_statement (new CCodeExpressionStatement (filter_call));

		// chain up
		parent_class = new CCodeFunctionCall (new CCodeIdentifier ("G_OBJECT_CLASS"));
		parent_class.add_argument (new CCodeIdentifier (lower_cname + "_parent_class"));
		chainup = new CCodeFunctionCall (new CCodeMemberAccess.pointer (parent_class, "dispose"));
		chainup.add_argument (new CCodeIdentifier ("self"));
		proxy_dispose.block.add_statement (new CCodeExpressionStatement (chainup));

		source_type_member_definition.append (proxy_dispose);

		var proxy_class_init = new CCodeFunction (lower_cname + "_class_init", "void");
		proxy_class_init.add_parameter (new CCodeFormalParameter ("klass", cname + "Class*"));
		proxy_class_init.modifiers = CCodeModifiers.STATIC;
		proxy_class_init.block = new CCodeBlock ();
		var gobject_class = new CCodeFunctionCall (new CCodeIdentifier ("G_OBJECT_CLASS"));
		gobject_class.add_argument (new CCodeIdentifier ("klass"));
		proxy_class_init.block.add_statement (new CCodeExpressionStatement (new CCodeAssignment (new CCodeMemberAccess.pointer (gobject_class, "constructor"), new CCodeIdentifier (lower_cname + "_construct"))));
		proxy_class_init.block.add_statement (new CCodeExpressionStatement (new CCodeAssignment (new CCodeMemberAccess.pointer (gobject_class, "dispose"), new CCodeIdentifier (lower_cname + "_dispose"))));
		proxy_class_init.block.add_statement (new CCodeExpressionStatement (new CCodeAssignment (new CCodeMemberAccess.pointer (gobject_class, "get_property"), new CCodeIdentifier (lower_cname + "_get_property"))));
		proxy_class_init.block.add_statement (new CCodeExpressionStatement (new CCodeAssignment (new CCodeMemberAccess.pointer (gobject_class, "set_property"), new CCodeIdentifier (lower_cname + "_set_property"))));
		source_type_member_definition.append (proxy_class_init);

		prop_enum = new CCodeEnum ();
		prop_enum.add_value (new CCodeEnumValue ("%s_DUMMY_PROPERTY".printf (lower_cname.up ())));

		foreach (Property prop in iface.get_properties ()) {
			if (!prop.is_abstract) {
				continue;
			}

			if (prop.property_type is ArrayType) {
				continue;
			}

			var cinst = new CCodeFunctionCall (new CCodeIdentifier ("g_object_class_override_property"));
			cinst.add_argument (gobject_class);
			cinst.add_argument (new CCodeConstant (prop.get_upper_case_cname ()));
			cinst.add_argument (prop.get_canonical_cconstant ());
			proxy_class_init.block.add_statement (new CCodeExpressionStatement (cinst));

			prop_enum.add_value (new CCodeEnumValue (prop.get_upper_case_cname ()));
		}

		source_declarations.add_type_member_declaration (prop_enum);

		var proxy_instance_init = new CCodeFunction (lower_cname + "_init", "void");
		proxy_instance_init.add_parameter (new CCodeFormalParameter ("self", cname + "*"));
		proxy_instance_init.modifiers = CCodeModifiers.STATIC;
		proxy_instance_init.block = new CCodeBlock ();
		source_type_member_definition.append (proxy_instance_init);

		var proxy_iface_init = new CCodeFunction (lower_cname + "_interface_init", "void");
		proxy_iface_init.add_parameter (new CCodeFormalParameter ("iface", iface.get_cname () + "Iface*"));

		var iface_block = new CCodeBlock ();

		foreach (Method m in iface.get_methods ()) {
			var vfunc_entry = new CCodeMemberAccess.pointer (new CCodeIdentifier ("iface"), m.vfunc_name);
			iface_block.add_statement (new CCodeExpressionStatement (new CCodeAssignment (vfunc_entry, new CCodeIdentifier (generate_dbus_proxy_method (iface, m)))));
			if (m.coroutine) {
				vfunc_entry = new CCodeMemberAccess.pointer (new CCodeIdentifier ("iface"), m.vfunc_name + "_async");
				iface_block.add_statement (new CCodeExpressionStatement (new CCodeAssignment (vfunc_entry, new CCodeIdentifier (generate_async_dbus_proxy_method (iface, m)))));
				vfunc_entry = new CCodeMemberAccess.pointer (new CCodeIdentifier ("iface"), m.vfunc_name + "_finish");
				iface_block.add_statement (new CCodeExpressionStatement (new CCodeAssignment (vfunc_entry, new CCodeIdentifier (generate_finish_dbus_proxy_method (iface, m)))));
			}
		}

		foreach (Property prop in iface.get_properties ()) {
			if (prop.get_accessor != null) {
				var vfunc_entry = new CCodeMemberAccess.pointer (new CCodeIdentifier ("iface"), "get_" + prop.name);
				iface_block.add_statement (new CCodeExpressionStatement (new CCodeAssignment (vfunc_entry, new CCodeIdentifier (generate_dbus_proxy_property_get (iface, prop)))));
			}
			if (prop.set_accessor != null) {
				var vfunc_entry = new CCodeMemberAccess.pointer (new CCodeIdentifier ("iface"), "set_" + prop.name);
				iface_block.add_statement (new CCodeExpressionStatement (new CCodeAssignment (vfunc_entry, new CCodeIdentifier (generate_dbus_proxy_property_set (iface, prop)))));
			}
		}

		proxy_iface_init.modifiers = CCodeModifiers.STATIC;
		source_declarations.add_type_member_declaration (proxy_iface_init.copy ());
		proxy_iface_init.block = iface_block;
		source_type_member_definition.append (proxy_iface_init);

		// dbus proxy get/set_property stubs
		// TODO add actual implementation
		var get_prop = new CCodeFunction ("%s_get_property".printf (lower_cname), "void");
		get_prop.modifiers = CCodeModifiers.STATIC;
		get_prop.add_parameter (new CCodeFormalParameter ("object", "GObject *"));
		get_prop.add_parameter (new CCodeFormalParameter ("property_id", "guint"));
		get_prop.add_parameter (new CCodeFormalParameter ("value", "GValue *"));
		get_prop.add_parameter (new CCodeFormalParameter ("pspec", "GParamSpec *"));
		source_declarations.add_type_member_declaration (get_prop.copy ());
		get_prop.block = new CCodeBlock ();
		source_type_member_definition.append (get_prop);

		var set_prop = new CCodeFunction ("%s_set_property".printf (lower_cname), "void");
		set_prop.modifiers = CCodeModifiers.STATIC;
		set_prop.add_parameter (new CCodeFormalParameter ("object", "GObject *"));
		set_prop.add_parameter (new CCodeFormalParameter ("property_id", "guint"));
		set_prop.add_parameter (new CCodeFormalParameter ("value", "const GValue *"));
		set_prop.add_parameter (new CCodeFormalParameter ("pspec", "GParamSpec *"));
		source_declarations.add_type_member_declaration (set_prop.copy ());
		set_prop.block = new CCodeBlock ();
		source_type_member_definition.append (set_prop);
	}

	public override TypeRegisterFunction create_interface_register_function (Interface iface) {
		var dbus = iface.get_attribute ("DBus");
		if (dbus == null) {
			return new InterfaceRegisterFunction (iface, context);
		}

		string dbus_iface_name = dbus.get_string ("name");
		if (dbus_iface_name == null) {
			return new InterfaceRegisterFunction (iface, context);
		}

		return new DBusInterfaceRegisterFunction (iface, context);
	}

	public override void visit_method_call (MethodCall expr) {
		var mtype = expr.call.value_type as MethodType;
		if (mtype == null || mtype.method_symbol.get_cname () != "dbus_g_proxy_new_from_type") {
			base.visit_method_call (expr);
			return;
		}

		var args = expr.get_argument_list ();
		Expression connection = ((MemberAccess) expr.call).inner;
		Expression bus_name = args.get (0);
		Expression object_path = args.get (1);
		Expression interface_name = args.get (2);
		Expression type = args.get (3);

		var quark_call = new CCodeFunctionCall (new CCodeIdentifier ("g_quark_from_string"));
		quark_call.add_argument (new CCodeConstant ("\"ValaDBusInterfaceProxyType\""));

		var qdata_call = new CCodeFunctionCall (new CCodeIdentifier ("g_type_get_qdata"));
		type.accept (codegen);
		qdata_call.add_argument ((CCodeExpression) type.ccodenode);
		qdata_call.add_argument (quark_call);

		var get_type_call = new CCodeFunctionCall (new CCodeCastExpression (qdata_call, "GType (*)(void)"));

		var ccall = new CCodeFunctionCall (new CCodeIdentifier ("g_object_new"));
		ccall.add_argument (get_type_call);
		ccall.add_argument (new CCodeConstant ("\"connection\""));
		connection.accept (codegen);
		ccall.add_argument ((CCodeExpression) connection.ccodenode);
		ccall.add_argument (new CCodeConstant ("\"name\""));
		bus_name.accept (codegen);
		ccall.add_argument ((CCodeExpression) bus_name.ccodenode);
		ccall.add_argument (new CCodeConstant ("\"path\""));
		object_path.accept (codegen);
		ccall.add_argument ((CCodeExpression) object_path.ccodenode);
		ccall.add_argument (new CCodeConstant ("\"interface\""));
		interface_name.accept (codegen);
		ccall.add_argument ((CCodeExpression) interface_name.ccodenode);
		ccall.add_argument (new CCodeConstant ("NULL"));
		expr.ccodenode = ccall;
	}

	void generate_proxy_filter_function (Interface iface) {
		string lower_cname = iface.get_lower_case_cprefix () + "dbus_proxy";

		var proxy_filter = new CCodeFunction (lower_cname + "_filter", "DBusHandlerResult");
		proxy_filter.add_parameter (new CCodeFormalParameter ("connection", "DBusConnection*"));
		proxy_filter.add_parameter (new CCodeFormalParameter ("message", "DBusMessage*"));
		proxy_filter.add_parameter (new CCodeFormalParameter ("user_data", "void*"));

		var filter_block = new CCodeBlock ();

		// only handle signals concering the object path
		var path = new CCodeFunctionCall (new CCodeIdentifier ("dbus_g_proxy_get_path"));
		path.add_argument (new CCodeIdentifier ("user_data"));

		var ccheck = new CCodeFunctionCall (new CCodeIdentifier ("dbus_message_has_path"));
		ccheck.add_argument (new CCodeIdentifier ("message"));
		ccheck.add_argument (path);

		var object_filter_block = new CCodeBlock ();
		filter_block.add_statement (new CCodeIfStatement (ccheck, object_filter_block));

		handle_signals (iface, object_filter_block);

		filter_block.add_statement (new CCodeReturnStatement (new CCodeIdentifier ("DBUS_HANDLER_RESULT_NOT_YET_HANDLED")));

		source_declarations.add_type_member_declaration (proxy_filter.copy ());
		proxy_filter.block = filter_block;
		source_type_member_definition.append (proxy_filter);
	}

	string generate_dbus_signal_handler (Signal sig, ObjectTypeSymbol sym) {
		string wrapper_name = "_dbus_handle_%s_%s".printf (sym.get_lower_case_cname (), sig.get_cname ());

		// declaration

		CCodeDeclaration cdecl;

		var function = new CCodeFunction (wrapper_name, "void");
		function.modifiers = CCodeModifiers.STATIC;

		function.add_parameter (new CCodeFormalParameter ("self", sym.get_cname () + "*"));
		function.add_parameter (new CCodeFormalParameter ("connection", "DBusConnection*"));
		function.add_parameter (new CCodeFormalParameter ("message", "DBusMessage*"));

		var block = new CCodeBlock ();
		var prefragment = new CCodeFragment ();

		cdecl = new CCodeDeclaration ("DBusMessageIter");
		cdecl.add_declarator (new CCodeVariableDeclarator ("iter"));
		block.add_statement (cdecl);

		block.add_statement (prefragment);

		var message_signature = new CCodeFunctionCall (new CCodeIdentifier ("dbus_message_get_signature"));
		message_signature.add_argument (new CCodeIdentifier ("message"));
		var signature_check = new CCodeFunctionCall (new CCodeIdentifier ("strcmp"));
		signature_check.add_argument (message_signature);
		var signature_error_block = new CCodeBlock ();
		signature_error_block.add_statement (new CCodeReturnStatement ());
		prefragment.append (new CCodeIfStatement (signature_check, signature_error_block));

		var iter_call = new CCodeFunctionCall (new CCodeIdentifier ("dbus_message_iter_init"));
		iter_call.add_argument (new CCodeIdentifier ("message"));
		iter_call.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, new CCodeIdentifier ("iter")));
		prefragment.append (new CCodeExpressionStatement (iter_call));

		var ccall = new CCodeFunctionCall (new CCodeIdentifier ("g_signal_emit_by_name"));
		ccall.add_argument (new CCodeIdentifier ("self"));
		ccall.add_argument (sig.get_canonical_cconstant ());

		// expected type signature for input parameters
		string type_signature = "";

		foreach (FormalParameter param in sig.get_parameters ()) {
			cdecl = new CCodeDeclaration (param.parameter_type.get_cname ());
			cdecl.add_declarator (new CCodeVariableDeclarator (param.name, default_value_for_type (param.parameter_type, true)));
			prefragment.append (cdecl);

			if (get_type_signature (param.parameter_type) == null) {
				Report.error (param.parameter_type.source_reference, "D-Bus serialization of type `%s' is not supported".printf (param.parameter_type.to_string ()));
				continue;
			}

			var st = param.parameter_type.data_type as Struct;
			if (st != null && !st.is_simple_type ()) {
				ccall.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, new CCodeIdentifier (param.name)));
			} else {
				ccall.add_argument (new CCodeIdentifier (param.name));
			}

			if (param.parameter_type is ArrayType) {
				var array_type = (ArrayType) param.parameter_type;

				for (int dim = 1; dim <= array_type.rank; dim++) {
					string length_cname = get_array_length_cname (param.name, dim);

					cdecl = new CCodeDeclaration ("int");
					cdecl.add_declarator (new CCodeVariableDeclarator (length_cname, new CCodeConstant ("0")));
					prefragment.append (cdecl);
					ccall.add_argument (new CCodeIdentifier (length_cname));
				}
			}

			type_signature += get_type_signature (param.parameter_type);

			var target = new CCodeIdentifier (param.name);
			var expr = read_expression (prefragment, param.parameter_type, new CCodeIdentifier ("iter"), target);
			prefragment.append (new CCodeExpressionStatement (new CCodeAssignment (target, expr)));
		}

		signature_check.add_argument (new CCodeConstant ("\"%s\"".printf (type_signature)));

		block.add_statement (new CCodeExpressionStatement (ccall));

		cdecl = new CCodeDeclaration ("DBusMessage*");
		cdecl.add_declarator (new CCodeVariableDeclarator ("reply"));
		block.add_statement (cdecl);

		source_declarations.add_type_member_declaration (function.copy ());

		function.block = block;
		source_type_member_definition.append (function);

		return wrapper_name;
	}

	void handle_signal (string dbus_iface_name, string dbus_signal_name, string handler_name, CCodeBlock block, ref CCodeIfStatement clastif) {
		var ccheck = new CCodeFunctionCall (new CCodeIdentifier ("dbus_message_is_signal"));
		ccheck.add_argument (new CCodeIdentifier ("message"));
		ccheck.add_argument (new CCodeConstant ("\"%s\"".printf (dbus_iface_name)));
		ccheck.add_argument (new CCodeConstant ("\"%s\"".printf (dbus_signal_name)));

		var callblock = new CCodeBlock ();

		var ccall = new CCodeFunctionCall (new CCodeIdentifier (handler_name));
		ccall.add_argument (new CCodeIdentifier ("user_data"));
		ccall.add_argument (new CCodeIdentifier ("connection"));
		ccall.add_argument (new CCodeIdentifier ("message"));

		callblock.add_statement (new CCodeExpressionStatement (ccall));

		var cif = new CCodeIfStatement (ccheck, callblock);
		if (clastif == null) {
			block.add_statement (cif);
		} else {
			clastif.false_statement = cif;
		}

		clastif = cif;
	}

	void handle_signals (Interface iface, CCodeBlock block) {
		string dbus_iface_name = iface.get_attribute ("DBus").get_string ("name");

		CCodeIfStatement clastif = null;
		foreach (Signal sig in iface.get_signals ()) {
			if (sig.access != SymbolAccessibility.PUBLIC) {
				continue;
			}

			handle_signal (dbus_iface_name, Symbol.lower_case_to_camel_case (sig.name), generate_dbus_signal_handler (sig, iface), block, ref clastif);
		}
	}

	void generate_marshalling (Method m, string dbus_iface_name, CCodeFragment prefragment, CCodeFragment postfragment) {
		CCodeDeclaration cdecl;

		var destination = new CCodeFunctionCall (new CCodeIdentifier ("dbus_g_proxy_get_bus_name"));
		destination.add_argument (new CCodeCastExpression (new CCodeIdentifier ("self"), "DBusGProxy*"));
		var path = new CCodeFunctionCall (new CCodeIdentifier ("dbus_g_proxy_get_path"));
		path.add_argument (new CCodeCastExpression (new CCodeIdentifier ("self"), "DBusGProxy*"));

		var msgcall = new CCodeFunctionCall (new CCodeIdentifier ("dbus_message_new_method_call"));
		msgcall.add_argument (destination);
		msgcall.add_argument (path);
		msgcall.add_argument (new CCodeConstant ("\"%s\"".printf (dbus_iface_name)));
		msgcall.add_argument (new CCodeConstant ("\"%s\"".printf (Symbol.lower_case_to_camel_case (m.name))));
		prefragment.append (new CCodeExpressionStatement (new CCodeAssignment (new CCodeIdentifier ("_message"), msgcall)));

		var iter_call = new CCodeFunctionCall (new CCodeIdentifier ("dbus_message_iter_init_append"));
		iter_call.add_argument (new CCodeIdentifier ("_message"));
		iter_call.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, new CCodeIdentifier ("_iter")));
		prefragment.append (new CCodeExpressionStatement (iter_call));

		iter_call = new CCodeFunctionCall (new CCodeIdentifier ("dbus_message_iter_init"));
		iter_call.add_argument (new CCodeIdentifier ("_reply"));
		iter_call.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, new CCodeIdentifier ("_iter")));
		postfragment.append (new CCodeExpressionStatement (iter_call));

		foreach (FormalParameter param in m.get_parameters ()) {
			if (param.direction == ParameterDirection.IN) {
				if (param.parameter_type.data_type != null
				    && param.parameter_type.data_type.get_full_name () == "DBus.BusName") {
					// ignore BusName sender parameters
					continue;
				}
				CCodeExpression expr = new CCodeIdentifier (param.name);
				if (param.parameter_type.is_real_struct_type ()) {
					expr = new CCodeUnaryExpression (CCodeUnaryOperator.POINTER_INDIRECTION, expr);
				}
				write_expression (prefragment, param.parameter_type, new CCodeIdentifier ("_iter"), expr);
			} else {
				cdecl = new CCodeDeclaration (param.parameter_type.get_cname ());
				cdecl.add_declarator (new CCodeVariableDeclarator ("_" + param.name));
				postfragment.append (cdecl);

				var array_type = param.parameter_type as ArrayType;

				if (array_type != null) {
					for (int dim = 1; dim <= array_type.rank; dim++) {
						cdecl = new CCodeDeclaration ("int");
						cdecl.add_declarator (new CCodeVariableDeclarator ("_%s_length%d".printf (param.name, dim), new CCodeConstant ("0")));
						postfragment.append (cdecl);
					}
				}

				var target = new CCodeIdentifier ("_" + param.name);
				var expr = read_expression (postfragment, param.parameter_type, new CCodeIdentifier ("_iter"), target);
				postfragment.append (new CCodeExpressionStatement (new CCodeAssignment (target, expr)));

				// TODO check that parameter is not NULL (out parameters are optional)
				// free value if parameter is NULL
				postfragment.append (new CCodeExpressionStatement (new CCodeAssignment (new CCodeUnaryExpression (CCodeUnaryOperator.POINTER_INDIRECTION, new CCodeIdentifier (param.name)), target)));


				if (array_type != null) {
					for (int dim = 1; dim <= array_type.rank; dim++) {
						// TODO check that parameter is not NULL (out parameters are optional)
						postfragment.append (new CCodeExpressionStatement (new CCodeAssignment (new CCodeUnaryExpression (CCodeUnaryOperator.POINTER_INDIRECTION, new CCodeIdentifier ("%s_length%d".printf (param.name, dim))), new CCodeIdentifier ("_%s_length%d".printf (param.name, dim)))));
					}
				}
			}
		}

		if (!(m.return_type is VoidType)) {
			cdecl = new CCodeDeclaration (m.return_type.get_cname ());
			cdecl.add_declarator (new CCodeVariableDeclarator ("_result"));
			postfragment.append (cdecl);

			var array_type = m.return_type as ArrayType;

			if (array_type != null) {
				for (int dim = 1; dim <= array_type.rank; dim++) {
					cdecl = new CCodeDeclaration ("int");
					cdecl.add_declarator (new CCodeVariableDeclarator ("_result_length%d".printf (dim), new CCodeConstant ("0")));
					postfragment.append (cdecl);
				}
			}

			var target = new CCodeIdentifier ("_result");
			var expr = read_expression (postfragment, m.return_type, new CCodeIdentifier ("_iter"), target);
			postfragment.append (new CCodeExpressionStatement (new CCodeAssignment (target, expr)));

			if (array_type != null) {
				for (int dim = 1; dim <= array_type.rank; dim++) {
					// TODO check that parameter is not NULL (out parameters are optional)
					postfragment.append (new CCodeExpressionStatement (new CCodeAssignment (new CCodeUnaryExpression (CCodeUnaryOperator.POINTER_INDIRECTION, new CCodeIdentifier ("result_length%d".printf (dim))), new CCodeIdentifier ("_result_length%d".printf (dim)))));
				}
			}
		}
	}

	string generate_dbus_proxy_method (Interface iface, Method m) {
		string proxy_name = "%sdbus_proxy_%s".printf (iface.get_lower_case_cprefix (), m.name);

		string dbus_iface_name = iface.get_attribute ("DBus").get_string ("name");

		CCodeDeclaration cdecl;

		var function = new CCodeFunction (proxy_name);
		function.modifiers = CCodeModifiers.STATIC;

		var cparam_map = new HashMap<int,CCodeFormalParameter> (direct_hash, direct_equal);

		generate_cparameters (m, source_declarations, cparam_map, function);

		var block = new CCodeBlock ();
		var prefragment = new CCodeFragment ();
		var postfragment = new CCodeFragment ();

		// throw error and return if proxy is disposed
		var dispose_return_block = new CCodeBlock ();
		if (m.get_error_types ().size > 0) {
			var set_error_call = new CCodeFunctionCall (new CCodeIdentifier ("g_set_error_literal"));
			set_error_call.add_argument (new CCodeIdentifier ("error"));
			set_error_call.add_argument (new CCodeIdentifier ("DBUS_GERROR"));
			set_error_call.add_argument (new CCodeIdentifier ("DBUS_GERROR_DISCONNECTED"));
			set_error_call.add_argument (new CCodeConstant ("\"Connection is closed\""));
			dispose_return_block.add_statement (new CCodeExpressionStatement (set_error_call));
		}
		if (m.return_type is VoidType) {
			dispose_return_block.add_statement (new CCodeReturnStatement ());
		} else {
			dispose_return_block.add_statement (new CCodeReturnStatement (default_value_for_type (m.return_type, false)));
		}
		block.add_statement (new CCodeIfStatement (new CCodeMemberAccess.pointer (new CCodeCastExpression (new CCodeIdentifier ("self"), iface.get_cname () + "DBusProxy*"), "disposed"), dispose_return_block));

		cdecl = new CCodeDeclaration ("DBusGConnection");
		cdecl.add_declarator (new CCodeVariableDeclarator ("*_connection"));
		block.add_statement (cdecl);

		cdecl = new CCodeDeclaration ("DBusMessage");
		cdecl.add_declarator (new CCodeVariableDeclarator ("*_message"));
		cdecl.add_declarator (new CCodeVariableDeclarator ("*_reply"));
		block.add_statement (cdecl);

		cdecl = new CCodeDeclaration ("DBusMessageIter");
		cdecl.add_declarator (new CCodeVariableDeclarator ("_iter"));
		block.add_statement (cdecl);

		block.add_statement (prefragment);

		generate_marshalling (m, dbus_iface_name, prefragment, postfragment);

		var gconnection = new CCodeFunctionCall (new CCodeIdentifier ("g_object_get"));
		gconnection.add_argument (new CCodeIdentifier ("self"));
		gconnection.add_argument (new CCodeConstant ("\"connection\""));
		gconnection.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, new CCodeIdentifier ("_connection")));
		gconnection.add_argument (new CCodeConstant ("NULL"));
		block.add_statement (new CCodeExpressionStatement (gconnection));

		var connection = new CCodeFunctionCall (new CCodeIdentifier ("dbus_g_connection_get_connection"));
		connection.add_argument (new CCodeIdentifier ("_connection"));

		var ccall = new CCodeFunctionCall (new CCodeIdentifier ("dbus_connection_send_with_reply_and_block"));
		ccall.add_argument (connection);
		ccall.add_argument (new CCodeIdentifier ("_message"));
		ccall.add_argument (new CCodeConstant ("-1"));
		ccall.add_argument (new CCodeConstant ("NULL"));
		block.add_statement (new CCodeExpressionStatement (new CCodeAssignment (new CCodeIdentifier ("_reply"), ccall)));

		var conn_unref = new CCodeFunctionCall (new CCodeIdentifier ("dbus_g_connection_unref"));
		conn_unref.add_argument (new CCodeIdentifier ("_connection"));
		block.add_statement (new CCodeExpressionStatement (conn_unref));

		var message_unref = new CCodeFunctionCall (new CCodeIdentifier ("dbus_message_unref"));
		message_unref.add_argument (new CCodeIdentifier ("_message"));
		block.add_statement (new CCodeExpressionStatement (message_unref));

		block.add_statement (postfragment);

		var reply_unref = new CCodeFunctionCall (new CCodeIdentifier ("dbus_message_unref"));
		reply_unref.add_argument (new CCodeIdentifier ("_reply"));
		block.add_statement (new CCodeExpressionStatement (reply_unref));

		if (!(m.return_type is VoidType)) {
			block.add_statement (new CCodeReturnStatement (new CCodeIdentifier ("_result")));
		}

		source_declarations.add_type_member_declaration (function.copy ());
		function.block = block;
		source_type_member_definition.append (function);

		return proxy_name;
	}

	string generate_async_dbus_proxy_method (Interface iface, Method m) {
		string proxy_name = "%sdbus_proxy_%s_async".printf (iface.get_lower_case_cprefix (), m.name);

		string dbus_iface_name = iface.get_attribute ("DBus").get_string ("name");

		CCodeDeclaration cdecl;


		// generate data struct

		string dataname = "%sDBusProxy%sData".printf (iface.get_cname (), Symbol.lower_case_to_camel_case (m.name));
		var datastruct = new CCodeStruct ("_" + dataname);

		datastruct.add_field ("GAsyncReadyCallback", "callback");
		datastruct.add_field ("gpointer", "user_data");
		datastruct.add_field ("DBusPendingCall*", "pending");

		source_declarations.add_type_definition (datastruct);
		source_declarations.add_type_declaration (new CCodeTypeDefinition ("struct _" + dataname, new CCodeVariableDeclarator (dataname)));


		// generate async function

		var function = new CCodeFunction (proxy_name, "void");
		function.modifiers = CCodeModifiers.STATIC;

		var cparam_map = new HashMap<int,CCodeFormalParameter> (direct_hash, direct_equal);

		cparam_map.set (get_param_pos (-1), new CCodeFormalParameter ("callback", "GAsyncReadyCallback"));
		cparam_map.set (get_param_pos (-0.9), new CCodeFormalParameter ("user_data", "gpointer"));

		generate_cparameters (m, source_declarations, cparam_map, function, null, null, null, 1);

		var block = new CCodeBlock ();
		var prefragment = new CCodeFragment ();
		var postfragment = new CCodeFragment ();

		cdecl = new CCodeDeclaration ("DBusGConnection");
		cdecl.add_declarator (new CCodeVariableDeclarator ("*_connection"));
		block.add_statement (cdecl);

		cdecl = new CCodeDeclaration ("DBusMessage");
		cdecl.add_declarator (new CCodeVariableDeclarator ("*_message"));
		block.add_statement (cdecl);

		cdecl = new CCodeDeclaration ("DBusPendingCall");
		cdecl.add_declarator (new CCodeVariableDeclarator ("*_pending"));
		block.add_statement (cdecl);

		cdecl = new CCodeDeclaration ("DBusMessageIter");
		cdecl.add_declarator (new CCodeVariableDeclarator ("_iter"));
		block.add_statement (cdecl);

		block.add_statement (prefragment);

		generate_marshalling (m, dbus_iface_name, prefragment, postfragment);

		var gconnection = new CCodeFunctionCall (new CCodeIdentifier ("g_object_get"));
		gconnection.add_argument (new CCodeIdentifier ("self"));
		gconnection.add_argument (new CCodeConstant ("\"connection\""));
		gconnection.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, new CCodeIdentifier ("_connection")));
		gconnection.add_argument (new CCodeConstant ("NULL"));
		block.add_statement (new CCodeExpressionStatement (gconnection));

		var connection = new CCodeFunctionCall (new CCodeIdentifier ("dbus_g_connection_get_connection"));
		connection.add_argument (new CCodeIdentifier ("_connection"));

		var ccall = new CCodeFunctionCall (new CCodeIdentifier ("dbus_connection_send_with_reply"));
		ccall.add_argument (connection);
		ccall.add_argument (new CCodeIdentifier ("_message"));
		ccall.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, new CCodeIdentifier ("_pending")));
		ccall.add_argument (new CCodeConstant ("-1"));
		block.add_statement (new CCodeExpressionStatement (ccall));

		var conn_unref = new CCodeFunctionCall (new CCodeIdentifier ("dbus_g_connection_unref"));
		conn_unref.add_argument (new CCodeIdentifier ("_connection"));
		block.add_statement (new CCodeExpressionStatement (conn_unref));

		var message_unref = new CCodeFunctionCall (new CCodeIdentifier ("dbus_message_unref"));
		message_unref.add_argument (new CCodeIdentifier ("_message"));
		block.add_statement (new CCodeExpressionStatement (message_unref));

		var dataalloc = new CCodeFunctionCall (new CCodeIdentifier ("g_slice_new0"));
		dataalloc.add_argument (new CCodeIdentifier (dataname));

		var datadecl = new CCodeDeclaration (dataname + "*");
		datadecl.add_declarator (new CCodeVariableDeclarator ("data"));
		block.add_statement (datadecl);
		block.add_statement (new CCodeExpressionStatement (new CCodeAssignment (new CCodeIdentifier ("data"), dataalloc)));

		block.add_statement (new CCodeExpressionStatement (new CCodeAssignment (new CCodeMemberAccess.pointer (new CCodeIdentifier ("data"), "callback"), new CCodeIdentifier ("callback"))));
		block.add_statement (new CCodeExpressionStatement (new CCodeAssignment (new CCodeMemberAccess.pointer (new CCodeIdentifier ("data"), "user_data"), new CCodeIdentifier ("user_data"))));
		block.add_statement (new CCodeExpressionStatement (new CCodeAssignment (new CCodeMemberAccess.pointer (new CCodeIdentifier ("data"), "pending"), new CCodeIdentifier ("_pending"))));

		var pending = new CCodeFunctionCall (new CCodeIdentifier ("dbus_pending_call_set_notify"));
		pending.add_argument (new CCodeIdentifier ("_pending"));
		pending.add_argument (new CCodeIdentifier ("%sdbus_proxy_%s_ready".printf (iface.get_lower_case_cprefix (), m.name)));
		pending.add_argument (new CCodeIdentifier ("data"));
		pending.add_argument (new CCodeConstant ("NULL"));
		block.add_statement (new CCodeExpressionStatement (pending));

		source_declarations.add_type_member_declaration (function.copy ());
		function.block = block;
		source_type_member_definition.append (function);


		// generate ready function

		function = new CCodeFunction ("%sdbus_proxy_%s_ready".printf (iface.get_lower_case_cprefix (), m.name), "void");
		function.modifiers = CCodeModifiers.STATIC;

		function.add_parameter (new CCodeFormalParameter ("pending", "DBusPendingCall*"));
		function.add_parameter (new CCodeFormalParameter ("user_data", "void*"));

		block = new CCodeBlock ();

		datadecl = new CCodeDeclaration (dataname + "*");
		datadecl.add_declarator (new CCodeVariableDeclarator ("data"));
		block.add_statement (datadecl);
		block.add_statement (new CCodeExpressionStatement (new CCodeAssignment (new CCodeIdentifier ("data"), new CCodeIdentifier ("user_data"))));

		// complete async call by invoking callback
		var object_creation = new CCodeFunctionCall (new CCodeIdentifier ("g_object_newv"));
		object_creation.add_argument (new CCodeConstant ("G_TYPE_OBJECT"));
		object_creation.add_argument (new CCodeConstant ("0"));
		object_creation.add_argument (new CCodeConstant ("NULL"));

		var async_result_creation = new CCodeFunctionCall (new CCodeIdentifier ("g_simple_async_result_new"));
		async_result_creation.add_argument (object_creation);
		async_result_creation.add_argument (new CCodeMemberAccess.pointer (new CCodeIdentifier ("data"), "callback"));
		async_result_creation.add_argument (new CCodeMemberAccess.pointer (new CCodeIdentifier ("data"), "user_data"));
		async_result_creation.add_argument (new CCodeIdentifier ("data"));

		var completecall = new CCodeFunctionCall (new CCodeIdentifier ("g_simple_async_result_complete"));
		completecall.add_argument (async_result_creation);
		block.add_statement (new CCodeExpressionStatement (completecall));

		source_declarations.add_type_member_declaration (function.copy ());
		function.block = block;
		source_type_member_definition.append (function);


		return proxy_name;
	}

	string generate_finish_dbus_proxy_method (Interface iface, Method m) {
		string proxy_name = "%sdbus_proxy_%s_finish".printf (iface.get_lower_case_cprefix (), m.name);

		string dbus_iface_name = iface.get_attribute ("DBus").get_string ("name");

		CCodeDeclaration cdecl;

		var function = new CCodeFunction (proxy_name);
		function.modifiers = CCodeModifiers.STATIC;

		var cparam_map = new HashMap<int,CCodeFormalParameter> (direct_hash, direct_equal);

		cparam_map.set (get_param_pos (0.1), new CCodeFormalParameter ("res", "GAsyncResult*"));

		generate_cparameters (m, source_declarations, cparam_map, function, null, null, null, 2);

		var block = new CCodeBlock ();
		var prefragment = new CCodeFragment ();
		var postfragment = new CCodeFragment ();

		string dataname = "%sDBusProxy%sData".printf (iface.get_cname (), Symbol.lower_case_to_camel_case (m.name));
		cdecl = new CCodeDeclaration (dataname + "*");
		cdecl.add_declarator (new CCodeVariableDeclarator ("data"));
		block.add_statement (cdecl);

		cdecl = new CCodeDeclaration ("DBusMessage");
		cdecl.add_declarator (new CCodeVariableDeclarator ("*_reply"));
		block.add_statement (cdecl);

		cdecl = new CCodeDeclaration ("DBusMessageIter");
		cdecl.add_declarator (new CCodeVariableDeclarator ("_iter"));
		block.add_statement (cdecl);

		var get_source_tag = new CCodeFunctionCall (new CCodeIdentifier ("g_simple_async_result_get_source_tag"));
		get_source_tag.add_argument (new CCodeCastExpression (new CCodeIdentifier ("res"), "GSimpleAsyncResult *"));
		block.add_statement (new CCodeExpressionStatement (new CCodeAssignment (new CCodeIdentifier ("data"), get_source_tag)));

		var ccall = new CCodeFunctionCall (new CCodeIdentifier ("dbus_pending_call_steal_reply"));
		ccall.add_argument (new CCodeMemberAccess.pointer (new CCodeIdentifier ("data"), "pending"));
		block.add_statement (new CCodeExpressionStatement (new CCodeAssignment (new CCodeIdentifier ("_reply"), ccall)));

		generate_marshalling (m, dbus_iface_name, prefragment, postfragment);

		block.add_statement (postfragment);

		var reply_unref = new CCodeFunctionCall (new CCodeIdentifier ("dbus_message_unref"));
		reply_unref.add_argument (new CCodeIdentifier ("_reply"));
		block.add_statement (new CCodeExpressionStatement (reply_unref));

		if (!(m.return_type is VoidType)) {
			block.add_statement (new CCodeReturnStatement (new CCodeIdentifier ("_result")));
		}

		source_declarations.add_type_member_declaration (function.copy ());
		function.block = block;
		source_type_member_definition.append (function);

		return proxy_name;
	}

	string generate_dbus_proxy_property_get (Interface iface, Property prop) {
		string proxy_name = "%sdbus_proxy_get_%s".printf (iface.get_lower_case_cprefix (), prop.name);

		string dbus_iface_name = iface.get_attribute ("DBus").get_string ("name");

		var owned_type = prop.get_accessor.value_type.copy ();
		owned_type.value_owned = true;
		if (owned_type.is_disposable () && !prop.get_accessor.value_type.value_owned) {
			Report.error (prop.get_accessor.value_type.source_reference, "Properties used in D-Bus clients require owned get accessor");
		}

		var array_type = prop.get_accessor.value_type as ArrayType;

		CCodeDeclaration cdecl;

		var function = new CCodeFunction (proxy_name);
		function.modifiers = CCodeModifiers.STATIC;

		function.add_parameter (new CCodeFormalParameter ("self", "%s*".printf (iface.get_cname ())));

		if (array_type != null) {
			for (int dim = 1; dim <= array_type.rank; dim++) {
				function.add_parameter (new CCodeFormalParameter ("result_length%d".printf (dim), "int*"));
			}
		}

		function.return_type = prop.get_accessor.value_type.get_cname ();

		var block = new CCodeBlock ();
		var prefragment = new CCodeFragment ();
		var postfragment = new CCodeFragment ();

		var dispose_return_block = new CCodeBlock ();
		dispose_return_block.add_statement (new CCodeReturnStatement (default_value_for_type (prop.property_type, false)));
		block.add_statement (new CCodeIfStatement (new CCodeMemberAccess.pointer (new CCodeCastExpression (new CCodeIdentifier ("self"), iface.get_cname () + "DBusProxy*"), "disposed"), dispose_return_block));

		cdecl = new CCodeDeclaration ("DBusGConnection");
		cdecl.add_declarator (new CCodeVariableDeclarator ("*_connection"));
		block.add_statement (cdecl);

		cdecl = new CCodeDeclaration ("DBusMessage");
		cdecl.add_declarator (new CCodeVariableDeclarator ("*_message"));
		cdecl.add_declarator (new CCodeVariableDeclarator ("*_reply"));
		block.add_statement (cdecl);

		cdecl = new CCodeDeclaration ("DBusMessageIter");
		cdecl.add_declarator (new CCodeVariableDeclarator ("_iter"));
		cdecl.add_declarator (new CCodeVariableDeclarator ("_subiter"));
		block.add_statement (cdecl);

		block.add_statement (prefragment);

		var destination = new CCodeFunctionCall (new CCodeIdentifier ("dbus_g_proxy_get_bus_name"));
		destination.add_argument (new CCodeCastExpression (new CCodeIdentifier ("self"), "DBusGProxy*"));
		var path = new CCodeFunctionCall (new CCodeIdentifier ("dbus_g_proxy_get_path"));
		path.add_argument (new CCodeCastExpression (new CCodeIdentifier ("self"), "DBusGProxy*"));

		var msgcall = new CCodeFunctionCall (new CCodeIdentifier ("dbus_message_new_method_call"));
		msgcall.add_argument (destination);
		msgcall.add_argument (path);
		msgcall.add_argument (new CCodeConstant ("\"org.freedesktop.DBus.Properties\""));
		msgcall.add_argument (new CCodeConstant ("\"Get\""));
		prefragment.append (new CCodeExpressionStatement (new CCodeAssignment (new CCodeIdentifier ("_message"), msgcall)));

		var iter_call = new CCodeFunctionCall (new CCodeIdentifier ("dbus_message_iter_init_append"));
		iter_call.add_argument (new CCodeIdentifier ("_message"));
		iter_call.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, new CCodeIdentifier ("_iter")));
		prefragment.append (new CCodeExpressionStatement (iter_call));

		iter_call = new CCodeFunctionCall (new CCodeIdentifier ("dbus_message_iter_init"));
		iter_call.add_argument (new CCodeIdentifier ("_reply"));
		iter_call.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, new CCodeIdentifier ("_iter")));
		postfragment.append (new CCodeExpressionStatement (iter_call));

		// interface name
		write_expression (prefragment, string_type, new CCodeIdentifier ("_iter"), new CCodeConstant ("\"%s\"".printf (dbus_iface_name)));
		// property name
		write_expression (prefragment, string_type, new CCodeIdentifier ("_iter"), new CCodeConstant ("\"%s\"".printf (Symbol.lower_case_to_camel_case (prop.name))));

		cdecl = new CCodeDeclaration (prop.get_accessor.value_type.get_cname ());
		cdecl.add_declarator (new CCodeVariableDeclarator ("_result"));
		postfragment.append (cdecl);

		if (array_type != null) {
			for (int dim = 1; dim <= array_type.rank; dim++) {
				cdecl = new CCodeDeclaration ("int");
				cdecl.add_declarator (new CCodeVariableDeclarator ("_result_length%d".printf (dim), new CCodeConstant ("0")));
				postfragment.append (cdecl);
			}
		}

		iter_call = new CCodeFunctionCall (new CCodeIdentifier ("dbus_message_iter_recurse"));
		iter_call.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, new CCodeIdentifier ("_iter")));
		iter_call.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, new CCodeIdentifier ("_subiter")));
		postfragment.append (new CCodeExpressionStatement (iter_call));

		var target = new CCodeIdentifier ("_result");
		var expr = read_expression (postfragment, prop.get_accessor.value_type, new CCodeIdentifier ("_subiter"), target);
		postfragment.append (new CCodeExpressionStatement (new CCodeAssignment (target, expr)));

		if (array_type != null) {
			for (int dim = 1; dim <= array_type.rank; dim++) {
				// TODO check that parameter is not NULL (out parameters are optional)
				postfragment.append (new CCodeExpressionStatement (new CCodeAssignment (new CCodeUnaryExpression (CCodeUnaryOperator.POINTER_INDIRECTION, new CCodeIdentifier ("result_length%d".printf (dim))), new CCodeIdentifier ("_result_length%d".printf (dim)))));
			}
		}

		var gconnection = new CCodeFunctionCall (new CCodeIdentifier ("g_object_get"));
		gconnection.add_argument (new CCodeIdentifier ("self"));
		gconnection.add_argument (new CCodeConstant ("\"connection\""));
		gconnection.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, new CCodeIdentifier ("_connection")));
		gconnection.add_argument (new CCodeConstant ("NULL"));
		block.add_statement (new CCodeExpressionStatement (gconnection));

		var connection = new CCodeFunctionCall (new CCodeIdentifier ("dbus_g_connection_get_connection"));
		connection.add_argument (new CCodeIdentifier ("_connection"));

		var ccall = new CCodeFunctionCall (new CCodeIdentifier ("dbus_connection_send_with_reply_and_block"));
		ccall.add_argument (connection);
		ccall.add_argument (new CCodeIdentifier ("_message"));
		ccall.add_argument (new CCodeConstant ("-1"));
		ccall.add_argument (new CCodeConstant ("NULL"));
		block.add_statement (new CCodeExpressionStatement (new CCodeAssignment (new CCodeIdentifier ("_reply"), ccall)));

		var conn_unref = new CCodeFunctionCall (new CCodeIdentifier ("dbus_g_connection_unref"));
		conn_unref.add_argument (new CCodeIdentifier ("_connection"));
		block.add_statement (new CCodeExpressionStatement (conn_unref));

		var message_unref = new CCodeFunctionCall (new CCodeIdentifier ("dbus_message_unref"));
		message_unref.add_argument (new CCodeIdentifier ("_message"));
		block.add_statement (new CCodeExpressionStatement (message_unref));

		block.add_statement (postfragment);

		var reply_unref = new CCodeFunctionCall (new CCodeIdentifier ("dbus_message_unref"));
		reply_unref.add_argument (new CCodeIdentifier ("_reply"));
		block.add_statement (new CCodeExpressionStatement (reply_unref));

		block.add_statement (new CCodeReturnStatement (new CCodeIdentifier ("_result")));

		source_declarations.add_type_member_declaration (function.copy ());
		function.block = block;
		source_type_member_definition.append (function);

		return proxy_name;
	}

	string generate_dbus_proxy_property_set (Interface iface, Property prop) {
		string proxy_name = "%sdbus_proxy_set_%s".printf (iface.get_lower_case_cprefix (), prop.name);

		string dbus_iface_name = iface.get_attribute ("DBus").get_string ("name");

		var array_type = prop.set_accessor.value_type as ArrayType;

		CCodeDeclaration cdecl;

		var function = new CCodeFunction (proxy_name);
		function.modifiers = CCodeModifiers.STATIC;

		function.add_parameter (new CCodeFormalParameter ("self", "%s*".printf (iface.get_cname ())));
		function.add_parameter (new CCodeFormalParameter ("value", prop.set_accessor.value_type.get_cname ()));

		if (array_type != null) {
			for (int dim = 1; dim <= array_type.rank; dim++) {
				function.add_parameter (new CCodeFormalParameter ("value_length%d".printf (dim), "int"));
			}
		}

		var block = new CCodeBlock ();
		var prefragment = new CCodeFragment ();
		var postfragment = new CCodeFragment ();

		var dispose_return_block = new CCodeBlock ();
		dispose_return_block.add_statement (new CCodeReturnStatement ());
		block.add_statement (new CCodeIfStatement (new CCodeMemberAccess.pointer (new CCodeCastExpression (new CCodeIdentifier ("self"), iface.get_cname () + "DBusProxy*"), "disposed"), dispose_return_block));

		cdecl = new CCodeDeclaration ("DBusGConnection");
		cdecl.add_declarator (new CCodeVariableDeclarator ("*_connection"));
		block.add_statement (cdecl);

		cdecl = new CCodeDeclaration ("DBusMessage");
		cdecl.add_declarator (new CCodeVariableDeclarator ("*_message"));
		cdecl.add_declarator (new CCodeVariableDeclarator ("*_reply"));
		block.add_statement (cdecl);

		cdecl = new CCodeDeclaration ("DBusMessageIter");
		cdecl.add_declarator (new CCodeVariableDeclarator ("_iter"));
		cdecl.add_declarator (new CCodeVariableDeclarator ("_subiter"));
		block.add_statement (cdecl);

		block.add_statement (prefragment);

		var destination = new CCodeFunctionCall (new CCodeIdentifier ("dbus_g_proxy_get_bus_name"));
		destination.add_argument (new CCodeCastExpression (new CCodeIdentifier ("self"), "DBusGProxy*"));
		var path = new CCodeFunctionCall (new CCodeIdentifier ("dbus_g_proxy_get_path"));
		path.add_argument (new CCodeCastExpression (new CCodeIdentifier ("self"), "DBusGProxy*"));

		var msgcall = new CCodeFunctionCall (new CCodeIdentifier ("dbus_message_new_method_call"));
		msgcall.add_argument (destination);
		msgcall.add_argument (path);
		msgcall.add_argument (new CCodeConstant ("\"org.freedesktop.DBus.Properties\""));
		msgcall.add_argument (new CCodeConstant ("\"Set\""));
		prefragment.append (new CCodeExpressionStatement (new CCodeAssignment (new CCodeIdentifier ("_message"), msgcall)));

		var iter_call = new CCodeFunctionCall (new CCodeIdentifier ("dbus_message_iter_init_append"));
		iter_call.add_argument (new CCodeIdentifier ("_message"));
		iter_call.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, new CCodeIdentifier ("_iter")));
		prefragment.append (new CCodeExpressionStatement (iter_call));

		iter_call = new CCodeFunctionCall (new CCodeIdentifier ("dbus_message_iter_init"));
		iter_call.add_argument (new CCodeIdentifier ("_reply"));
		iter_call.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, new CCodeIdentifier ("_iter")));
		postfragment.append (new CCodeExpressionStatement (iter_call));

		// interface name
		write_expression (prefragment, string_type, new CCodeIdentifier ("_iter"), new CCodeConstant ("\"%s\"".printf (dbus_iface_name)));
		// property name
		write_expression (prefragment, string_type, new CCodeIdentifier ("_iter"), new CCodeConstant ("\"%s\"".printf (Symbol.lower_case_to_camel_case (prop.name))));

		// property value (as variant)
		iter_call = new CCodeFunctionCall (new CCodeIdentifier ("dbus_message_iter_open_container"));
		iter_call.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, new CCodeIdentifier ("_iter")));
		iter_call.add_argument (new CCodeIdentifier ("DBUS_TYPE_VARIANT"));
		iter_call.add_argument (new CCodeConstant ("\"%s\"".printf (prop.property_type.get_type_signature ())));
		iter_call.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, new CCodeIdentifier ("_subiter")));
		prefragment.append (new CCodeExpressionStatement (iter_call));

		write_expression (prefragment, prop.set_accessor.value_type, new CCodeIdentifier ("_subiter"), new CCodeIdentifier ("value"));

		iter_call = new CCodeFunctionCall (new CCodeIdentifier ("dbus_message_iter_close_container"));
		iter_call.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, new CCodeIdentifier ("_iter")));
		iter_call.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, new CCodeIdentifier ("_subiter")));
		prefragment.append (new CCodeExpressionStatement (iter_call));

		var gconnection = new CCodeFunctionCall (new CCodeIdentifier ("g_object_get"));
		gconnection.add_argument (new CCodeIdentifier ("self"));
		gconnection.add_argument (new CCodeConstant ("\"connection\""));
		gconnection.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, new CCodeIdentifier ("_connection")));
		gconnection.add_argument (new CCodeConstant ("NULL"));
		block.add_statement (new CCodeExpressionStatement (gconnection));

		var connection = new CCodeFunctionCall (new CCodeIdentifier ("dbus_g_connection_get_connection"));
		connection.add_argument (new CCodeIdentifier ("_connection"));

		var ccall = new CCodeFunctionCall (new CCodeIdentifier ("dbus_connection_send_with_reply_and_block"));
		ccall.add_argument (connection);
		ccall.add_argument (new CCodeIdentifier ("_message"));
		ccall.add_argument (new CCodeConstant ("-1"));
		ccall.add_argument (new CCodeConstant ("NULL"));
		block.add_statement (new CCodeExpressionStatement (new CCodeAssignment (new CCodeIdentifier ("_reply"), ccall)));

		var conn_unref = new CCodeFunctionCall (new CCodeIdentifier ("dbus_g_connection_unref"));
		conn_unref.add_argument (new CCodeIdentifier ("_connection"));
		block.add_statement (new CCodeExpressionStatement (conn_unref));

		var message_unref = new CCodeFunctionCall (new CCodeIdentifier ("dbus_message_unref"));
		message_unref.add_argument (new CCodeIdentifier ("_message"));
		block.add_statement (new CCodeExpressionStatement (message_unref));

		block.add_statement (postfragment);

		var reply_unref = new CCodeFunctionCall (new CCodeIdentifier ("dbus_message_unref"));
		reply_unref.add_argument (new CCodeIdentifier ("_reply"));
		block.add_statement (new CCodeExpressionStatement (reply_unref));

		source_declarations.add_type_member_declaration (function.copy ());
		function.block = block;
		source_type_member_definition.append (function);

		return proxy_name;
	}
}
