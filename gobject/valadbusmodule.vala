/* valadbusmodule.vala
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
public class Vala.DBusModule : CCodeModule {
	public DBusModule (CCodeGenerator codegen, CCodeModule? next) {
		base (codegen, next);
	}

	public override void generate_dynamic_method_wrapper (DynamicMethod method) {
		var dynamic_method = (DynamicMethod) method;

		var func = new CCodeFunction (method.get_cname (), method.return_type.get_cname ());

		var cparam_map = new HashMap<int,CCodeFormalParameter> (direct_hash, direct_equal);

		var instance_param = new CCodeFormalParameter ("obj", dynamic_method.dynamic_type.get_cname ());
		cparam_map.set (codegen.get_param_pos (method.cinstance_parameter_position), instance_param);

		generate_cparameters (method, method.return_type, false, cparam_map, func);

		var block = new CCodeBlock ();
		if (dynamic_method.dynamic_type.data_type == codegen.dbus_object_type) {
			generate_dbus_method_wrapper (method, block);
		} else {
			Report.error (method.source_reference, "dynamic methods are not supported for `%s'".printf (dynamic_method.dynamic_type.to_string ()));
		}

		// append to C source file
		codegen.source_type_member_declaration.append (func.copy ());

		func.block = block;
		codegen.source_type_member_definition.append (func);
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
					// error parameter
					break;
				}
				if (param.parameter_type is ArrayType && ((ArrayType) param.parameter_type).element_type.data_type != codegen.string_type.data_type) {
					var array_type = (ArrayType) param.parameter_type;
					CCodeDeclaration cdecl;
					if (codegen.dbus_use_ptr_array (array_type)) {
						cdecl = new CCodeDeclaration ("GPtrArray*");
					} else {
						cdecl = new CCodeDeclaration ("GArray*");
					}
					cdecl.add_declarator (new CCodeVariableDeclarator (param.name));
					cb_fun.block.add_statement (cdecl);
					cend_call.add_argument (get_dbus_g_type (array_type));
					cend_call.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, new CCodeIdentifier (param.name)));
					creply_call.add_argument (new CCodeMemberAccess.pointer (new CCodeIdentifier (param.name), codegen.dbus_use_ptr_array (array_type) ? "pdata" : "data"));
					creply_call.add_argument (new CCodeMemberAccess.pointer (new CCodeIdentifier (param.name), "len"));
				} else {
					var cdecl = new CCodeDeclaration (param.parameter_type.get_cname ());
					cdecl.add_declarator (new CCodeVariableDeclarator (param.name));
					cb_fun.block.add_statement (cdecl);
					if (param.parameter_type is ArrayType && ((ArrayType) param.parameter_type).element_type.data_type == codegen.string_type.data_type) {
						// special case string array
						cend_call.add_argument (new CCodeIdentifier ("G_TYPE_STRV"));
					} else {
						cend_call.add_argument (new CCodeIdentifier (param.parameter_type.data_type.get_type_id ()));
					}
					cend_call.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, new CCodeIdentifier (param.name)));
					creply_call.add_argument (new CCodeIdentifier (param.name));

					if (param.parameter_type is ArrayType && ((ArrayType) param.parameter_type).element_type.data_type == codegen.string_type.data_type) {
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
			codegen.source_type_member_definition.append (cb_fun);

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
				if (array_type.element_type.data_type != codegen.string_type.data_type) {
					// non-string arrays (use GArray)
					ccall.add_argument (get_dbus_g_type (array_type));

					var sizeof_call = new CCodeFunctionCall (new CCodeIdentifier ("sizeof"));
					sizeof_call.add_argument (new CCodeIdentifier (array_type.element_type.get_cname ()));

					CCodeDeclaration cdecl;
					CCodeFunctionCall array_construct;
					if (codegen.dbus_use_ptr_array (array_type)) {
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

					if (codegen.dbus_use_ptr_array (array_type)) {
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
				ccall.add_argument (new CCodeIdentifier (param.parameter_type.data_type.get_type_id ()));
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
					var assign = new CCodeAssignment (new CCodeMemberAccess.pointer (new CCodeIdentifier (param.name), f.name), cget_call);
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
			if (array_type != null && array_type.element_type.data_type != codegen.string_type.data_type) {
				// non-string arrays (use GArray)
				ccall.add_argument (get_dbus_g_type (array_type));

				CCodeDeclaration cdecl;
				if (codegen.dbus_use_ptr_array (array_type)) {
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
				creturnblock.add_statement (new CCodeReturnStatement (codegen.default_value_for_type (method.return_type, false)));
				var cerrorif = new CCodeIfStatement (new CCodeUnaryExpression (CCodeUnaryOperator.POINTER_INDIRECTION, new CCodeIdentifier ("error")), creturnblock);
				block.add_statement (cerrorif);

				block.add_statement (out_marshalling_fragment);

				// *result_length1 = result->len;
				var garray_length = new CCodeMemberAccess.pointer (new CCodeIdentifier ("result"), "len");
				var result_length = new CCodeUnaryExpression (CCodeUnaryOperator.POINTER_INDIRECTION, new CCodeIdentifier ("result_length1"));
				var assign = new CCodeAssignment (result_length, garray_length);
				block.add_statement (new CCodeExpressionStatement (assign));

				// return result->data;
				block.add_statement (new CCodeReturnStatement (new CCodeCastExpression (new CCodeMemberAccess.pointer (new CCodeIdentifier ("result"), codegen.dbus_use_ptr_array (array_type) ? "pdata" : "data"), method.return_type.get_cname ())));
			} else {
				// string arrays or other datatypes

				if (method.return_type is ArrayType) {
					// string arrays
					ccall.add_argument (new CCodeIdentifier ("G_TYPE_STRV"));
				} else {
					// other types
					ccall.add_argument (new CCodeIdentifier (method.return_type.data_type.get_type_id ()));
				}

				var cdecl = new CCodeDeclaration (method.return_type.get_cname ());
				cdecl.add_declarator (new CCodeVariableDeclarator ("result"));
				block.add_statement (cdecl);

				ccall.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, new CCodeIdentifier ("result")));
				ccall.add_argument (new CCodeIdentifier ("G_TYPE_INVALID"));

				block.add_statement (new CCodeExpressionStatement (ccall));

				// don't access result when error occured
				var creturnblock = new CCodeBlock ();
				creturnblock.add_statement (new CCodeReturnStatement (codegen.default_value_for_type (method.return_type, false)));
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
		var array_type = data_type as ArrayType;
		if (array_type != null) {
			if (array_type.element_type.data_type == codegen.string_type.data_type) {
				return new CCodeIdentifier ("G_TYPE_STRV");
			}

			var carray_type = new CCodeFunctionCall (new CCodeIdentifier ("dbus_g_type_get_collection"));
			if (codegen.dbus_use_ptr_array (array_type)) {
				carray_type.add_argument (new CCodeConstant ("\"GPtrArray\""));
			} else {
				carray_type.add_argument (new CCodeConstant ("\"GArray\""));
			}
			carray_type.add_argument (get_dbus_g_type (array_type.element_type));
			return carray_type;
		} else {
			return new CCodeIdentifier (data_type.data_type.get_type_id ());
		}
	}

	bool is_dbus_visible (CodeNode node) {
		var dbus_attribute = node.get_attribute ("DBus");
		if (dbus_attribute != null
		    && dbus_attribute.has_argument ("visible")
		    && !dbus_attribute.get_bool ("visible")) {
			return false;
		}

		return true;
	}

	string dbus_result_name (CodeNode node) {
		var dbus_attribute = node.get_attribute ("DBus");
		if (dbus_attribute != null
		    && dbus_attribute.has_argument ("result")) {
			var result_name = dbus_attribute.get_string ("result");
			if (result_name != null && result_name != "")
				return result_name;
		}

		return "result";
	}

	public override CCodeFragment register_dbus_info (ObjectTypeSymbol bindable) {

		CCodeFragment fragment = new CCodeFragment ();

		var dbus = bindable.get_attribute ("DBus");
		if (dbus == null) {
			return fragment;
		}
		var dbus_iface_name = dbus.get_string ("name");
		if (dbus_iface_name == null) {
			return fragment;
		}

		codegen.dbus_glib_h_needed = true;

		var dbus_methods = new StringBuilder ();
		dbus_methods.append ("{\n");

		var blob = new StringBuilder ();
		blob.append_c ('"');

		int method_count = 0;
		long blob_len = 0;
		foreach (Method m in bindable.get_methods ()) {
			if (m is CreationMethod || m.binding != MemberBinding.INSTANCE
			    || m.overrides || m.access != SymbolAccessibility.PUBLIC) {
				continue;
			}
			if (!is_dbus_visible (m)) {
				continue;
			}

			var parameters = new Gee.ArrayList<FormalParameter> ();
			foreach (FormalParameter param in m.get_parameters ()) {
				parameters.add (param);
			}
			if (!(m.return_type is VoidType)) {
				parameters.add (new FormalParameter ("result", new PointerType (new VoidType ())));
			}
			parameters.add (new FormalParameter ("error", codegen.gerror_type));

			dbus_methods.append ("{ (GCallback) ");
			dbus_methods.append (generate_dbus_wrapper (m, bindable));
			dbus_methods.append (", ");
			dbus_methods.append (head.get_marshaller_function (parameters, codegen.bool_type, null, true));
			dbus_methods.append (", ");
			dbus_methods.append (blob_len.to_string ());
			dbus_methods.append (" },\n");

			head.generate_marshaller (parameters, codegen.bool_type, true);

			long start = blob.len;

			blob.append (dbus_iface_name);
			blob.append ("\\0");
			start++;

			blob.append (Symbol.lower_case_to_camel_case (m.name));
			blob.append ("\\0");
			start++;

			// synchronous
			blob.append ("S\\0");
			start++;

			foreach (FormalParameter param in m.get_parameters ()) {
				blob.append (param.name);
				blob.append ("\\0");
				start++;

				if (param.direction == ParameterDirection.IN) {
					blob.append ("I\\0");
					start++;
				} else if (param.direction == ParameterDirection.OUT) {
					blob.append ("O\\0");
					start++;
					blob.append ("F\\0");
					start++;
					blob.append ("N\\0");
					start++;
				} else {
					Report.error (param.source_reference, "unsupported parameter direction for D-Bus method");
				}

				blob.append (param.parameter_type.get_type_signature ());
				blob.append ("\\0");
				start++;
			}

			if (!(m.return_type is VoidType)) {
				blob.append (dbus_result_name (m));
				blob.append ("\\0");
				start++;

				blob.append ("O\\0");
				start++;
				blob.append ("F\\0");
				start++;
				blob.append ("N\\0");
				start++;

				blob.append (m.return_type.get_type_signature ());
				blob.append ("\\0");
				start++;
			}

			blob.append ("\\0");
			start++;

			blob_len += blob.len - start;

			method_count++;
		}

		blob.append_c ('"');

		dbus_methods.append ("}\n");

		var dbus_signals = new StringBuilder ();
		dbus_signals.append_c ('"');
		foreach (Signal sig in bindable.get_signals ()) {
			if (sig.access != SymbolAccessibility.PUBLIC) {
				continue;
			}
			if (!is_dbus_visible (sig)) {
				continue;
			}

			dbus_signals.append (dbus_iface_name);
			dbus_signals.append ("\\0");
			dbus_signals.append (Symbol.lower_case_to_camel_case (sig.name));
			dbus_signals.append ("\\0");
		}
		dbus_signals.append_c('"');

		var dbus_props = new StringBuilder();
		dbus_props.append_c ('"');
		foreach (Property prop in bindable.get_properties ()) {
			if (prop.access != SymbolAccessibility.PUBLIC) {
				continue;
			}
			if (!is_dbus_visible (prop)) {
				continue;
			}

			dbus_props.append (dbus_iface_name);
			dbus_props.append ("\\0");
			dbus_props.append (Symbol.lower_case_to_camel_case (prop.name));
			dbus_props.append ("\\0");
		}
		dbus_props.append_c ('"');

		var dbus_methods_decl = new CCodeDeclaration ("const DBusGMethodInfo");
		dbus_methods_decl.modifiers = CCodeModifiers.STATIC;
		dbus_methods_decl.add_declarator (new CCodeVariableDeclarator.with_initializer ("%s_dbus_methods[]".printf (bindable.get_lower_case_cname ()), new CCodeConstant (dbus_methods.str)));

		fragment.append (dbus_methods_decl);

		var dbus_object_info = new CCodeDeclaration ("const DBusGObjectInfo");
		dbus_object_info.modifiers = CCodeModifiers.STATIC;
		dbus_object_info.add_declarator (new CCodeVariableDeclarator.with_initializer ("%s_dbus_object_info".printf (bindable.get_lower_case_cname ()), new CCodeConstant ("{ 0, %s_dbus_methods, %d, %s, %s, %s }".printf (bindable.get_lower_case_cname (), method_count, blob.str, dbus_signals.str, dbus_props.str))));

		fragment.append (dbus_object_info);

		var install_call = new CCodeFunctionCall (new CCodeIdentifier ("dbus_g_object_type_install_info"));
		install_call.add_argument (new CCodeIdentifier (bindable.get_type_id ()));
		install_call.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, new CCodeIdentifier ("%s_dbus_object_info".printf (bindable.get_lower_case_cname ()))));

		fragment.append (new CCodeExpressionStatement (install_call));

		return fragment;
	}

	string generate_dbus_wrapper (Method m, ObjectTypeSymbol bindable) {
		string wrapper_name = "_dbus_%s".printf (m.get_cname ());

		// declaration

		var function = new CCodeFunction (wrapper_name, "gboolean");
		function.modifiers = CCodeModifiers.STATIC;
		m.ccodenode = function;

		function.add_parameter (new CCodeFormalParameter ("self", bindable.get_cname () + "*"));

		foreach (FormalParameter param in m.get_parameters ()) {
			string ptr = (param.direction == ParameterDirection.OUT ? "*" : "");
			var array_type = param.parameter_type as ArrayType;
			if (array_type != null && array_type.element_type.data_type != codegen.string_type.data_type) {
				if (codegen.dbus_use_ptr_array (array_type)) {
					function.add_parameter (new CCodeFormalParameter ("dbus_%s".printf (param.name), "GPtrArray*" + ptr));
				} else {
					function.add_parameter (new CCodeFormalParameter ("dbus_%s".printf (param.name), "GArray*" + ptr));
				}
			} else if (param.parameter_type.get_type_signature ().has_prefix ("(")) {
				function.add_parameter (new CCodeFormalParameter ("dbus_%s".printf (param.name), "GValueArray*" + ptr));
			} else {
				function.add_parameter ((CCodeFormalParameter) param.ccodenode);
			}
		}

		if (!(m.return_type is VoidType)) {
			var array_type = m.return_type as ArrayType;
			if (array_type != null) {
				if (array_type.element_type.data_type == codegen.string_type.data_type) {
					function.add_parameter (new CCodeFormalParameter ("result", array_type.get_cname () + "*"));
				} else if (codegen.dbus_use_ptr_array (array_type)) {
					function.add_parameter (new CCodeFormalParameter ("dbus_result", "GPtrArray**"));
				} else {
					function.add_parameter (new CCodeFormalParameter ("dbus_result", "GArray**"));
				}
			} else if (m.return_type.get_type_signature ().has_prefix ("(")) {
				function.add_parameter (new CCodeFormalParameter ("dbus_result", "GValueArray**"));
			} else {
				function.add_parameter (new CCodeFormalParameter ("result", m.return_type.get_cname () + "*"));
			}
		}

		function.add_parameter (new CCodeFormalParameter ("error", "GError**"));

		// definition

		var block = new CCodeBlock ();

		foreach (FormalParameter param in m.get_parameters ()) {
			if (param.parameter_type.get_type_signature ().has_prefix ("(")) {
				var st = (Struct) param.parameter_type.data_type;

				var cdecl = new CCodeDeclaration (st.get_cname ());
				cdecl.add_declarator (new CCodeVariableDeclarator (param.name));
				block.add_statement (cdecl);

				if (param.direction == ParameterDirection.IN) {
					// struct input parameter
					int i = 0;
					foreach (Field f in st.get_fields ()) {
						if (f.binding == MemberBinding.INSTANCE) {
							var cget_call = new CCodeFunctionCall (new CCodeIdentifier (f.field_type.data_type.get_get_value_function ()));
							cget_call.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, new CCodeElementAccess (new CCodeMemberAccess.pointer (new CCodeIdentifier ("dbus_%s".printf (param.name)), "values"), new CCodeConstant (i.to_string ()))));
							var assign = new CCodeAssignment (new CCodeMemberAccess (new CCodeIdentifier (param.name), f.name), cget_call);
							block.add_statement (new CCodeExpressionStatement (assign));
							i++;
						}
					}
				}
			}
		}

		if (!(m.return_type is VoidType)) {
			var array_type = m.return_type as ArrayType;
			if (array_type != null) {
				if (array_type.element_type.data_type != codegen.string_type.data_type) {
					var cdecl = new CCodeDeclaration (m.return_type.get_cname ());
					cdecl.add_declarator (new CCodeVariableDeclarator ("result"));
					block.add_statement (cdecl);
				}

				var len_cdecl = new CCodeDeclaration ("int");
				len_cdecl.add_declarator (new CCodeVariableDeclarator ("result_length1"));
				block.add_statement (len_cdecl);
			}
		}

		var ccall = new CCodeFunctionCall (new CCodeIdentifier (m.get_cname ()));

		ccall.add_argument (new CCodeIdentifier ("self"));

		foreach (FormalParameter param in m.get_parameters ()) {
			var array_type = param.parameter_type as ArrayType;
			if (array_type != null) {
				if (param.direction == ParameterDirection.IN) {
					if (array_type.element_type.data_type == codegen.string_type.data_type) {
						ccall.add_argument (new CCodeIdentifier (param.name));
						if (!m.no_array_length) {
							var cstrvlen = new CCodeFunctionCall (new CCodeIdentifier ("g_strv_length"));
							cstrvlen.add_argument (new CCodeIdentifier (param.name));
							ccall.add_argument (cstrvlen);
						}
					} else if (codegen.dbus_use_ptr_array (array_type)) {
						ccall.add_argument (new CCodeMemberAccess.pointer (new CCodeIdentifier ("dbus_%s".printf (param.name)), "pdata"));
						if (!m.no_array_length) {
							ccall.add_argument (new CCodeMemberAccess.pointer (new CCodeIdentifier ("dbus_%s".printf (param.name)), "len"));
						}
					} else {
						ccall.add_argument (new CCodeMemberAccess.pointer (new CCodeIdentifier ("dbus_%s".printf (param.name)), "data"));
						if (!m.no_array_length) {
							ccall.add_argument (new CCodeMemberAccess.pointer (new CCodeIdentifier ("dbus_%s".printf (param.name)), "len"));
						}
					}
				} else {
					if (array_type.element_type.data_type != codegen.string_type.data_type) {
						var cdecl = new CCodeDeclaration (param.parameter_type.get_cname ());
						cdecl.add_declarator (new CCodeVariableDeclarator (param.name));
						block.add_statement (cdecl);

						ccall.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, new CCodeIdentifier (param.name)));
					} else {
						ccall.add_argument (new CCodeIdentifier (param.name));
					}

					if (!m.no_array_length) {
						var len_cdecl = new CCodeDeclaration ("int");
						len_cdecl.add_declarator (new CCodeVariableDeclarator ("%s_length1".printf (param.name)));
						block.add_statement (len_cdecl);

						ccall.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, new CCodeIdentifier ("%s_length1".printf (param.name))));
					}
				}
			} else if (param.parameter_type.get_type_signature ().has_prefix ("(")) {
				// struct input or output parameters
				ccall.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, new CCodeIdentifier (param.name)));
			} else {
				ccall.add_argument (new CCodeIdentifier (param.name));
			}
		}

		CCodeExpression expr;
		if (m.return_type is VoidType) {
			expr = ccall;
		} else {
			var array_type = m.return_type as ArrayType;
			if (array_type != null) {
				ccall.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, new CCodeIdentifier ("result_length1")));
				if (array_type.element_type.data_type != codegen.string_type.data_type) {
					expr = new CCodeAssignment (new CCodeIdentifier ("result"), ccall);
				} else {
					expr = new CCodeAssignment (new CCodeIdentifier ("*result"), ccall);
				}
			} else {
				expr = new CCodeAssignment (new CCodeIdentifier ("*result"), ccall);
			}
		}

		if (m.get_error_types ().size > 0) {
			ccall.add_argument (new CCodeIdentifier ("error"));
		}

		block.add_statement (new CCodeExpressionStatement (expr));

		foreach (FormalParameter param in m.get_parameters ()) {
			if (param.direction == ParameterDirection.OUT
			    && param.parameter_type.get_type_signature ().has_prefix ("(")) {
				// struct output parameter
				var st = (Struct) param.parameter_type.data_type;

				var array_construct = new CCodeFunctionCall (new CCodeIdentifier ("g_value_array_new"));
				array_construct.add_argument (new CCodeConstant ("0"));

				var dbus_param = new CCodeUnaryExpression (CCodeUnaryOperator.POINTER_INDIRECTION, new CCodeIdentifier ("dbus_%s".printf (param.name)));

				block.add_statement (new CCodeExpressionStatement (new CCodeAssignment (dbus_param, array_construct)));

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
					cset_call.add_argument (new CCodeMemberAccess (new CCodeIdentifier (param.name), f.name));
					block.add_statement (new CCodeExpressionStatement (cset_call));

					var cappend_call = new CCodeFunctionCall (new CCodeIdentifier ("g_value_array_append"));
					cappend_call.add_argument (dbus_param);
					cappend_call.add_argument (val_ptr);
					block.add_statement (new CCodeExpressionStatement (cappend_call));

					type_call.add_argument (new CCodeIdentifier (f.field_type.data_type.get_type_id ()));
				}
			}
		}

		if (!(m.return_type is VoidType)) {
			var array_type = m.return_type as ArrayType;
			if (array_type != null && array_type.element_type.data_type != codegen.string_type.data_type) {
				var garray = new CCodeUnaryExpression (CCodeUnaryOperator.POINTER_INDIRECTION, new CCodeIdentifier ("dbus_result"));

				var sizeof_call = new CCodeFunctionCall (new CCodeIdentifier ("sizeof"));
				sizeof_call.add_argument (new CCodeIdentifier (array_type.element_type.get_cname ()));

				if (codegen.dbus_use_ptr_array (array_type)) {
					var array_construct = new CCodeFunctionCall (new CCodeIdentifier ("g_ptr_array_sized_new"));
					array_construct.add_argument (new CCodeIdentifier ("result_length1"));

					block.add_statement (new CCodeExpressionStatement (new CCodeAssignment (garray, array_construct)));

					var memcpy_call = new CCodeFunctionCall (new CCodeIdentifier ("memcpy"));
					memcpy_call.add_argument (new CCodeMemberAccess.pointer (garray, "pdata"));
					memcpy_call.add_argument (new CCodeIdentifier ("result"));
					memcpy_call.add_argument (new CCodeBinaryExpression (CCodeBinaryOperator.MUL, new CCodeIdentifier ("result_length1"), sizeof_call));
					block.add_statement (new CCodeExpressionStatement (memcpy_call));

					var len_assignment = new CCodeAssignment (new CCodeMemberAccess.pointer (garray, "len"), new CCodeIdentifier ("result_length1"));
					block.add_statement (new CCodeExpressionStatement (len_assignment));
				} else {
					var array_construct = new CCodeFunctionCall (new CCodeIdentifier ("g_array_new"));
					array_construct.add_argument (new CCodeConstant ("TRUE"));
					array_construct.add_argument (new CCodeConstant ("TRUE"));
					array_construct.add_argument (sizeof_call);

					block.add_statement (new CCodeExpressionStatement (new CCodeAssignment (garray, array_construct)));

					var cappend_call = new CCodeFunctionCall (new CCodeIdentifier ("g_array_append_vals"));
					cappend_call.add_argument (garray);
					cappend_call.add_argument (new CCodeIdentifier ("result"));
					cappend_call.add_argument (new CCodeIdentifier ("result_length1"));
					block.add_statement (new CCodeExpressionStatement (cappend_call));
				}
			}
		}

		var no_error = new CCodeBinaryExpression (CCodeBinaryOperator.OR, new CCodeIdentifier ("!error"), new CCodeIdentifier ("!*error"));
		block.add_statement (new CCodeReturnStatement (no_error));

		// append to file

		codegen.source_type_member_declaration.append (function.copy ());

		function.block = block;
		codegen.source_type_member_definition.append (function);

		return wrapper_name;
	}
}
