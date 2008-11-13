/* valadbusclientmodule.vala
 *
 * Copyright (C) 2007-2008  Jürg Billeter
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
public class Vala.DBusClientModule : GAsyncModule {
	int dynamic_property_id;

	public DBusClientModule (CCodeGenerator codegen, CCodeModule? next) {
		base (codegen, next);
	}

	public override void generate_dynamic_method_wrapper (DynamicMethod method) {
		var dynamic_method = (DynamicMethod) method;

		var func = new CCodeFunction (method.get_cname (), method.return_type.get_cname ());

		var cparam_map = new HashMap<int,CCodeFormalParameter> (direct_hash, direct_equal);

		var instance_param = new CCodeFormalParameter ("obj", dynamic_method.dynamic_type.get_cname ());
		cparam_map.set (get_param_pos (method.cinstance_parameter_position), instance_param);

		generate_cparameters (method, method.return_type, false, cparam_map, func);

		var block = new CCodeBlock ();
		if (dynamic_method.dynamic_type.data_type == dbus_object_type) {
			generate_dbus_method_wrapper (method, block);
		} else {
			Report.error (method.source_reference, "dynamic methods are not supported for `%s'".printf (dynamic_method.dynamic_type.to_string ()));
		}

		// append to C source file
		source_type_member_declaration.append (func.copy ());

		func.block = block;
		source_type_member_definition.append (func);
	}

	void generate_dbus_method_wrapper (Method method, CCodeBlock block) {
		var dynamic_method = (DynamicMethod) method;

		var expr = dynamic_method.invocation;

		var ccall = new CCodeFunctionCall (new CCodeIdentifier ("dbus_g_proxy_begin_call"));

		ccall.add_argument (new CCodeIdentifier ("obj"));

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

		ccall.add_argument (new CCodeConstant ("\"%s\"".printf (Symbol.lower_case_to_camel_case (method.name))));

		if (callback != null) {
			var reply_method = (Method) callback.symbol_reference;

			var cb_fun = new CCodeFunction ("_%s_cb".printf (reply_method.get_cname ()), "void");
			cb_fun.modifiers = CCodeModifiers.STATIC;
			cb_fun.add_parameter (new CCodeFormalParameter ("proxy", "DBusGProxy*"));
			cb_fun.add_parameter (new CCodeFormalParameter ("call", "DBusGProxyCall*"));
			cb_fun.add_parameter (new CCodeFormalParameter ("user_data", "void*"));
			cb_fun.block = new CCodeBlock ();
			var cerrdecl = new CCodeDeclaration ("GError*");
			cerrdecl.add_declarator (new CCodeVariableDeclarator.with_initializer ("error", new CCodeConstant ("NULL")));
			cb_fun.block.add_statement (cerrdecl);
			var cend_call = new CCodeFunctionCall (new CCodeIdentifier ("dbus_g_proxy_end_call"));
			cend_call.add_argument (new CCodeIdentifier ("proxy"));
			cend_call.add_argument (new CCodeIdentifier ("call"));
			cend_call.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, new CCodeIdentifier ("error")));
			var creply_call = new CCodeFunctionCall ((CCodeExpression) callback.ccodenode);
			creply_call.add_argument (new CCodeIdentifier ("user_data"));
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
					if (param.parameter_type is ArrayType && ((ArrayType) param.parameter_type).element_type.data_type == string_type.data_type) {
						// special case string array
						cend_call.add_argument (new CCodeIdentifier ("G_TYPE_STRV"));
					} else {
						cend_call.add_argument (get_dbus_g_type (param.parameter_type));
					}
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
			source_type_member_definition.append (cb_fun);

			ccall.add_argument (new CCodeIdentifier (cb_fun.name));
			ccall.add_argument (new CCodeConstant ("param%d_target".printf (callback_index)));
			ccall.add_argument (new CCodeConstant ("NULL"));
		} else if (found_out || !(method.return_type is VoidType)) {
			ccall.call = new CCodeIdentifier ("dbus_g_proxy_call");

			ccall.add_argument (new CCodeIdentifier ("error"));
		} else {
			ccall.call = new CCodeIdentifier ("dbus_g_proxy_call_no_reply");
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

					cdecl.add_declarator (new CCodeVariableDeclarator.with_initializer ("dbus_%s".printf (param.name), array_construct));
					block.add_statement (cdecl);

					if (dbus_use_ptr_array (array_type)) {
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
			} else if (param.parameter_type.get_type_signature ().has_prefix ("(")) {
				// struct parameter
				var st = (Struct) param.parameter_type.data_type;

				var array_construct = new CCodeFunctionCall (new CCodeIdentifier ("g_value_array_new"));
				array_construct.add_argument (new CCodeConstant ("0"));

				var cdecl = new CCodeDeclaration ("GValueArray*");
				cdecl.add_declarator (new CCodeVariableDeclarator.with_initializer ("dbus_%s".printf (param.name), array_construct));
				block.add_statement (cdecl);

				var type_call = new CCodeFunctionCall (new CCodeIdentifier ("dbus_g_type_get_struct"));
				type_call.add_argument (new CCodeConstant ("\"GValueArray\""));

				foreach (Field f in st.get_fields ()) {
					if (f.binding != MemberBinding.INSTANCE) {
						continue;
					}

					string val_name = "val_%s_%s".printf (param.name, f.name);

					// 0-initialize struct with struct initializer { 0 }
					var cvalinit = new CCodeInitializerList ();
					cvalinit.append (new CCodeConstant ("0"));

					var cval_decl = new CCodeDeclaration ("GValue");
					cval_decl.add_declarator (new CCodeVariableDeclarator.with_initializer (val_name, cvalinit));
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

					type_call.add_argument (new CCodeIdentifier (f.field_type.data_type.get_type_id ()));
				}

				type_call.add_argument (new CCodeConstant ("G_TYPE_INVALID"));

				ccall.add_argument (type_call);
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

			if (param.parameter_type.get_type_signature ().has_prefix ("(")) {
				// struct output parameter
				var st = (Struct) param.parameter_type.data_type;

				var cdecl = new CCodeDeclaration ("GValueArray*");
				cdecl.add_declarator (new CCodeVariableDeclarator ("dbus_%s".printf (param.name)));
				block.add_statement (cdecl);

				var type_call = new CCodeFunctionCall (new CCodeIdentifier ("dbus_g_type_get_struct"));
				type_call.add_argument (new CCodeConstant ("\"GValueArray\""));

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

					type_call.add_argument (new CCodeIdentifier (f.field_type.data_type.get_type_id ()));
					i++;
				}

				type_call.add_argument (new CCodeConstant ("G_TYPE_INVALID"));

				ccall.add_argument (type_call);
				ccall.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, new CCodeIdentifier ("dbus_%s".printf (param.name))));
			} else {
				ccall.add_argument (new CCodeIdentifier (param.parameter_type.data_type.get_type_id ()));
				ccall.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, new CCodeIdentifier (param.name)));
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
			if (found_out) {
				ccall.add_argument (new CCodeIdentifier ("G_TYPE_INVALID"));
			}

			block.add_statement (new CCodeExpressionStatement (ccall));

			// don't access result when error occured
			var creturnblock = new CCodeBlock ();
			creturnblock.add_statement (new CCodeReturnStatement ());
			var cerrorif = new CCodeIfStatement (new CCodeUnaryExpression (CCodeUnaryOperator.POINTER_INDIRECTION, new CCodeIdentifier ("error")), creturnblock);
			block.add_statement (cerrorif);

			block.add_statement (out_marshalling_fragment);
		}
	}

	CCodeExpression get_dbus_g_type (DataType data_type) {
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
			foreach (DataType type_arg in type_args)
				cmap_type.add_argument (get_dbus_g_type (type_arg));

			return cmap_type;
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

		var func = new CCodeFunction (getter_cname, prop.property_type.get_cname ());
		func.modifiers |= CCodeModifiers.STATIC | CCodeModifiers.INLINE;

		func.add_parameter (new CCodeFormalParameter ("obj", prop.dynamic_type.get_cname ()));

		var block = new CCodeBlock ();
		generate_dbus_property_getter_wrapper (prop, block);

		// append to C source file
		source_type_member_declaration.append (func.copy ());

		func.block = block;
		source_type_member_definition.append (func);

		return getter_cname;
	}

	public override string get_dynamic_property_setter_cname (DynamicProperty prop) {
		if (prop.dynamic_type.data_type != dbus_object_type) {
			return base.get_dynamic_property_setter_cname (prop);
		}

		string setter_cname = "_dynamic_set_%s%d".printf (prop.name, dynamic_property_id++);

		var func = new CCodeFunction (setter_cname, "void");
		func.modifiers |= CCodeModifiers.STATIC | CCodeModifiers.INLINE;

		func.add_parameter (new CCodeFormalParameter ("obj", prop.dynamic_type.get_cname ()));
		func.add_parameter (new CCodeFormalParameter ("value", prop.property_type.get_cname ()));

		var block = new CCodeBlock ();
		generate_dbus_property_setter_wrapper (prop, block);

		// append to C source file
		source_type_member_declaration.append (func.copy ());

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
		prop_proxy_decl.add_declarator (new CCodeVariableDeclarator.with_initializer ("property_proxy", prop_proxy_call));
		block.add_statement (prop_proxy_decl);
	}

	void generate_dbus_property_getter_wrapper (DynamicProperty node, CCodeBlock block) {
		create_dbus_property_proxy (node, block);

		// initialize GValue
		var cvalinit = new CCodeInitializerList ();
		cvalinit.append (new CCodeConstant ("0"));

		var cval_decl = new CCodeDeclaration ("GValue");
		cval_decl.add_declarator (new CCodeVariableDeclarator.with_initializer ("gvalue", cvalinit));
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
		ccall.add_argument (new CCodeConstant ("\"%s\"".printf (Symbol.lower_case_to_camel_case (node.name))));

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
		cval_decl.add_declarator (new CCodeVariableDeclarator.with_initializer ("gvalue", cvalinit));
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
		ccall.add_argument (new CCodeConstant ("\"%s\"".printf (Symbol.lower_case_to_camel_case (node.name))));

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
		source_type_member_declaration.append (func.copy ());

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
		source_type_member_declaration.append (func.copy ());

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
		add_call.add_argument (new CCodeConstant ("\"%s\"".printf (Symbol.lower_case_to_camel_case (sig.name))));

		bool first = true;
		foreach (FormalParameter param in m.get_parameters ()) {
			if (first) {
				// skip sender parameter
				first = false;
				continue;
			}

			var array_type = param.parameter_type as ArrayType;
			if (array_type != null) {
				if (array_type.element_type.data_type == string_type.data_type) {
					register_call.add_argument (new CCodeIdentifier ("G_TYPE_STRV"));
					add_call.add_argument (new CCodeIdentifier ("G_TYPE_STRV"));
				} else {
					if (array_type.element_type.data_type.get_type_id () == null) {
						Report.error (param.source_reference, "unsupported parameter type for D-Bus signals");
						return;
					}

					var carray_type = new CCodeFunctionCall (new CCodeIdentifier ("dbus_g_type_get_collection"));
					carray_type.add_argument (new CCodeConstant ("\"GArray\""));
					carray_type.add_argument (new CCodeIdentifier (array_type.element_type.data_type.get_type_id ()));
					register_call.add_argument (carray_type);
					add_call.add_argument (carray_type);
				}
			} else {
				if (param.parameter_type.get_type_id () == null) {
					Report.error (param.source_reference, "unsupported parameter type for D-Bus signals");
					return;
				}

				register_call.add_argument (new CCodeIdentifier (param.parameter_type.get_type_id ()));
				add_call.add_argument (new CCodeIdentifier (param.parameter_type.get_type_id ()));
			}
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
}
