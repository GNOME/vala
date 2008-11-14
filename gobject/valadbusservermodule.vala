/* valadbusservermodule.vala
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
public class Vala.DBusServerModule : DBusClientModule {
	public DBusServerModule (CCodeGenerator codegen, CCodeModule? next) {
		base (codegen, next);
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

		dbus_glib_h_needed = true;

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
			parameters.add (new FormalParameter ("error", gerror_type));

			dbus_methods.append ("{ (GCallback) ");
			dbus_methods.append (generate_dbus_wrapper (m, bindable));
			dbus_methods.append (", ");
			dbus_methods.append (head.get_marshaller_function (parameters, bool_type, null, true));
			dbus_methods.append (", ");
			dbus_methods.append (blob_len.to_string ());
			dbus_methods.append (" },\n");

			head.generate_marshaller (parameters, bool_type, true);

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

	void transform_struct_to_value_array (CCodeBlock block, Struct st, CCodeExpression target, CCodeExpression st_expr, string name) {
		var array_construct = new CCodeFunctionCall (new CCodeIdentifier ("g_value_array_new"));
		array_construct.add_argument (new CCodeConstant ("0"));

		block.add_statement (new CCodeExpressionStatement (new CCodeAssignment (target, array_construct)));

		var type_call = new CCodeFunctionCall (new CCodeIdentifier ("dbus_g_type_get_struct"));
		type_call.add_argument (new CCodeConstant ("\"GValueArray\""));

		foreach (Field f in st.get_fields ()) {
			if (f.binding != MemberBinding.INSTANCE) {
				continue;
			}

			string val_name = "val_%s_%s".printf (name, f.name);

			// 0-initialize struct with struct initializer { 0 }
			var cvalinit = new CCodeInitializerList ();
			cvalinit.append (new CCodeConstant ("0"));

			var cval_decl = new CCodeDeclaration ("GValue");
			cval_decl.add_declarator (new CCodeVariableDeclarator.with_initializer (val_name, cvalinit));
			block.add_statement (cval_decl);

			var val_ptr = new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, new CCodeIdentifier (val_name));

			string type_id = f.field_type.data_type.get_type_id ();
			string set_value_function = f.field_type.data_type.get_set_value_function ();

			if (f.field_type.data_type is Enum) {
				// dbus-glib does not support enums
				var en = (Enum) f.field_type.data_type;
				if (!en.is_flags) {
					type_id = "G_TYPE_INT";
					set_value_function = "g_value_set_int";
				} else {
					type_id = "G_TYPE_UINT";
					set_value_function = "g_value_set_uint";
				}
			}

			var cinit_call = new CCodeFunctionCall (new CCodeIdentifier ("g_value_init"));
			cinit_call.add_argument (val_ptr);
			cinit_call.add_argument (new CCodeIdentifier (type_id));
			block.add_statement (new CCodeExpressionStatement (cinit_call));

			var cset_call = new CCodeFunctionCall (new CCodeIdentifier (set_value_function));
			cset_call.add_argument (val_ptr);
			if (f.field_type.data_type is Struct) {
				cset_call.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, new CCodeMemberAccess (st_expr, f.name)));
			} else {
				cset_call.add_argument (new CCodeMemberAccess (st_expr, f.name));
			}
			block.add_statement (new CCodeExpressionStatement (cset_call));

			var cappend_call = new CCodeFunctionCall (new CCodeIdentifier ("g_value_array_append"));
			cappend_call.add_argument (target);
			cappend_call.add_argument (val_ptr);
			block.add_statement (new CCodeExpressionStatement (cappend_call));

			type_call.add_argument (new CCodeIdentifier (f.field_type.data_type.get_type_id ()));
		}
	}

	void transform_struct_hash_table_to_value_array_hash_table (CCodeBlock block, Struct st, CCodeExpression target, CCodeExpression table_expr, string name) {
		// FIXME take care of memory management
		var table_construct = new CCodeFunctionCall (new CCodeIdentifier ("g_hash_table_new"));
		table_construct.add_argument (new CCodeIdentifier ("g_direct_hash"));
		table_construct.add_argument (new CCodeIdentifier ("g_direct_equal"));
		block.add_statement (new CCodeExpressionStatement (new CCodeAssignment (target, table_construct)));

		var cdecl = new CCodeDeclaration ("GList");
		cdecl.add_declarator (new CCodeVariableDeclarator ("*%s_keys".printf (name)));
		cdecl.add_declarator (new CCodeVariableDeclarator ("*%s_keys_it".printf (name)));
		cdecl.add_declarator (new CCodeVariableDeclarator ("*%s_values".printf (name)));
		cdecl.add_declarator (new CCodeVariableDeclarator ("*%s_values_it".printf (name)));
		block.add_statement (cdecl);

		var get_keys = new CCodeFunctionCall (new CCodeIdentifier ("g_hash_table_get_keys"));
		get_keys.add_argument (table_expr);
		block.add_statement (new CCodeExpressionStatement (new CCodeAssignment (new CCodeIdentifier ("%s_keys".printf (name)), get_keys)));

		var get_values = new CCodeFunctionCall (new CCodeIdentifier ("g_hash_table_get_values"));
		get_values.add_argument (table_expr);
		block.add_statement (new CCodeExpressionStatement (new CCodeAssignment (new CCodeIdentifier ("%s_values".printf (name)), get_values)));

		var loop_body = new CCodeBlock ();
		var for_stmt = new CCodeForStatement (new CCodeIdentifier ("%s_keys_it".printf (name)), loop_body);
		block.add_statement (for_stmt);
		for_stmt.add_initializer (new CCodeAssignment (new CCodeIdentifier ("%s_keys_it".printf (name)), new CCodeIdentifier ("%s_keys".printf (name))));
		for_stmt.add_initializer (new CCodeAssignment (new CCodeIdentifier ("%s_values_it".printf (name)), new CCodeIdentifier ("%s_values".printf (name))));
		for_stmt.add_iterator (new CCodeAssignment (new CCodeIdentifier ("%s_keys_it".printf (name)), new CCodeMemberAccess.pointer (new CCodeIdentifier ("%s_keys_it".printf (name)), "next")));
		for_stmt.add_iterator (new CCodeAssignment (new CCodeIdentifier ("%s_values_it".printf (name)), new CCodeMemberAccess.pointer (new CCodeIdentifier ("%s_values_it".printf (name)), "next")));

		cdecl = new CCodeDeclaration (st.get_cname () + "*");
		cdecl.add_declarator (new CCodeVariableDeclarator.with_initializer ("%s_value".printf (name), new CCodeMemberAccess.pointer (new CCodeIdentifier ("%s_values_it".printf (name)), "data")));
		loop_body.add_statement (cdecl);

		cdecl = new CCodeDeclaration ("GValueArray*");
		cdecl.add_declarator (new CCodeVariableDeclarator ("%s_value_array".printf (name)));
		loop_body.add_statement (cdecl);

		transform_struct_to_value_array (loop_body, st, new CCodeIdentifier ("%s_value_array".printf (name)), new CCodeUnaryExpression (CCodeUnaryOperator.POINTER_INDIRECTION, new CCodeIdentifier ("%s_value".printf (name))), name);

		var insert_call = new CCodeFunctionCall (new CCodeIdentifier ("g_hash_table_insert"));
		insert_call.add_argument (target);
		insert_call.add_argument (new CCodeMemberAccess.pointer (new CCodeIdentifier ("%s_keys_it".printf (name)), "data"));
		insert_call.add_argument (new CCodeIdentifier ("%s_value_array".printf (name)));
		loop_body.add_statement (new CCodeExpressionStatement (insert_call));
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
			if (array_type != null && array_type.element_type.data_type != string_type.data_type) {
				if (dbus_use_ptr_array (array_type)) {
					function.add_parameter (new CCodeFormalParameter ("dbus_%s".printf (param.name), "GPtrArray*" + ptr));
				} else {
					function.add_parameter (new CCodeFormalParameter ("dbus_%s".printf (param.name), "GArray*" + ptr));
				}
			} else if (param.parameter_type.get_type_signature ().has_prefix ("(")) {
				function.add_parameter (new CCodeFormalParameter ("dbus_%s".printf (param.name), "GValueArray*" + ptr));
			} else if (param.parameter_type.get_type_signature ().has_prefix ("a{")) {
				// hash table output parameter
				var type_args = param.parameter_type.get_type_arguments ();
				var value_type = type_args.get (1);
				if (value_type.get_type_signature ().has_prefix ("(")) {
					// values are structs
					function.add_parameter (new CCodeFormalParameter ("dbus_%s".printf (param.name), "GHashTable*" + ptr));
				} else {
					function.add_parameter ((CCodeFormalParameter) param.ccodenode);
				}
			} else {
				function.add_parameter ((CCodeFormalParameter) param.ccodenode);
			}
		}

		if (!(m.return_type is VoidType)) {
			var array_type = m.return_type as ArrayType;
			if (array_type != null) {
				if (array_type.element_type.data_type == string_type.data_type) {
					function.add_parameter (new CCodeFormalParameter ("result", array_type.get_cname () + "*"));
				} else if (dbus_use_ptr_array (array_type)) {
					function.add_parameter (new CCodeFormalParameter ("dbus_result", "GPtrArray**"));
				} else {
					function.add_parameter (new CCodeFormalParameter ("dbus_result", "GArray**"));
				}
			} else if (m.return_type.get_type_signature ().has_prefix ("(")) {
				function.add_parameter (new CCodeFormalParameter ("dbus_result", "GValueArray**"));
			} else if (m.return_type.get_type_signature ().has_prefix ("a{")) {
				// hash table output parameter
				var type_args = m.return_type.get_type_arguments ();
				var value_type = type_args.get (1);
				if (value_type.get_type_signature ().has_prefix ("(")) {
					// values are structs
					function.add_parameter (new CCodeFormalParameter ("dbus_result", "GHashTable**"));
				} else {
					function.add_parameter (new CCodeFormalParameter ("result", m.return_type.get_cname () + "*"));
				}
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
			} else if (param.parameter_type.get_type_signature ().has_prefix ("a{")) {
				// hash table output parameter
				var type_args = param.parameter_type.get_type_arguments ();
				var value_type = type_args.get (1);
				if (value_type.get_type_signature ().has_prefix ("(")) {
					// values are structs
					var cdecl = new CCodeDeclaration ("GHashTable*");
					cdecl.add_declarator (new CCodeVariableDeclarator (param.name));
					block.add_statement (cdecl);
				}
			}
		}

		if (!(m.return_type is VoidType)) {
			var array_type = m.return_type as ArrayType;
			if (array_type != null) {
				if (array_type.element_type.data_type != string_type.data_type) {
					var cdecl = new CCodeDeclaration (m.return_type.get_cname ());
					cdecl.add_declarator (new CCodeVariableDeclarator ("result"));
					block.add_statement (cdecl);
				}

				var len_cdecl = new CCodeDeclaration ("int");
				len_cdecl.add_declarator (new CCodeVariableDeclarator ("result_length1"));
				block.add_statement (len_cdecl);
			} else if (m.return_type.get_type_signature ().has_prefix ("a{")) {
				// hash table return value
				var type_args = m.return_type.get_type_arguments ();
				var value_type = type_args.get (1);
				if (value_type.get_type_signature ().has_prefix ("(")) {
					// values are structs
					var cdecl = new CCodeDeclaration ("GHashTable*");
					cdecl.add_declarator (new CCodeVariableDeclarator ("result"));
					block.add_statement (cdecl);
				}
			}
		}

		var ccall = new CCodeFunctionCall (new CCodeIdentifier (m.get_cname ()));

		ccall.add_argument (new CCodeIdentifier ("self"));

		foreach (FormalParameter param in m.get_parameters ()) {
			var array_type = param.parameter_type as ArrayType;
			if (array_type != null) {
				if (param.direction == ParameterDirection.IN) {
					if (array_type.element_type.data_type == string_type.data_type) {
						ccall.add_argument (new CCodeIdentifier (param.name));
						if (!m.no_array_length) {
							var cstrvlen = new CCodeFunctionCall (new CCodeIdentifier ("g_strv_length"));
							cstrvlen.add_argument (new CCodeIdentifier (param.name));
							ccall.add_argument (cstrvlen);
						}
					} else if (dbus_use_ptr_array (array_type)) {
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
					if (array_type.element_type.data_type != string_type.data_type) {
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
			} else if (param.parameter_type.get_type_signature ().has_prefix ("a{")) {
				// hash table output parameter
				var type_args = param.parameter_type.get_type_arguments ();
				var value_type = type_args.get (1);
				if (value_type.get_type_signature ().has_prefix ("(")) {
					// values are structs
					ccall.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, new CCodeIdentifier (param.name)));
				} else {
					ccall.add_argument (new CCodeIdentifier (param.name));
				}
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
				if (array_type.element_type.data_type != string_type.data_type) {
					expr = new CCodeAssignment (new CCodeIdentifier ("result"), ccall);
				} else {
					expr = new CCodeAssignment (new CCodeIdentifier ("*result"), ccall);
				}
			} else if (m.return_type.get_type_signature ().has_prefix ("a{")) {
				// hash table output parameter
				var type_args = m.return_type.get_type_arguments ();
				var value_type = type_args.get (1);
				if (value_type.get_type_signature ().has_prefix ("(")) {
					// values are structs
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
			if (param.direction == ParameterDirection.OUT) {
				if (param.parameter_type.get_type_signature ().has_prefix ("(")) {
					// struct output parameter
					var st = (Struct) param.parameter_type.data_type;
					var dbus_param = new CCodeUnaryExpression (CCodeUnaryOperator.POINTER_INDIRECTION, new CCodeIdentifier ("dbus_%s".printf (param.name)));
					var st_expr = new CCodeIdentifier (param.name);

					transform_struct_to_value_array (block, st, dbus_param, st_expr, param.name);
				} else if (param.parameter_type.get_type_signature ().has_prefix ("a{")) {
					// hash table output parameter
					var type_args = param.parameter_type.get_type_arguments ();
					var value_type = type_args.get (1);
					if (value_type.get_type_signature ().has_prefix ("(")) {
						// values are structs
						var st = (Struct) value_type.data_type;
						var dbus_param = new CCodeUnaryExpression (CCodeUnaryOperator.POINTER_INDIRECTION, new CCodeIdentifier ("dbus_%s".printf (param.name)));
						var table_expr = new CCodeIdentifier (param.name);
						transform_struct_hash_table_to_value_array_hash_table (block, st, dbus_param, table_expr, param.name);
					}
				}
			}
		}

		if (!(m.return_type is VoidType)) {
			var array_type = m.return_type as ArrayType;
			if (array_type != null && array_type.element_type.data_type != string_type.data_type) {
				var garray = new CCodeUnaryExpression (CCodeUnaryOperator.POINTER_INDIRECTION, new CCodeIdentifier ("dbus_result"));

				var sizeof_call = new CCodeFunctionCall (new CCodeIdentifier ("sizeof"));
				sizeof_call.add_argument (new CCodeIdentifier (array_type.element_type.get_cname ()));

				if (dbus_use_ptr_array (array_type)) {
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
			} else if (m.return_type.get_type_signature ().has_prefix ("a{")) {
				// hash table output parameter
				var type_args = m.return_type.get_type_arguments ();
				var value_type = type_args.get (1);
				if (value_type.get_type_signature ().has_prefix ("(")) {
					// values are structs
					var st = (Struct) value_type.data_type;
					var dbus_param = new CCodeUnaryExpression (CCodeUnaryOperator.POINTER_INDIRECTION, new CCodeIdentifier ("dbus_result"));
					var table_expr = new CCodeIdentifier ("result");
					transform_struct_hash_table_to_value_array_hash_table (block, st, dbus_param, table_expr, "result");
				}
			}
		}

		var no_error = new CCodeBinaryExpression (CCodeBinaryOperator.OR, new CCodeIdentifier ("!error"), new CCodeIdentifier ("!*error"));
		block.add_statement (new CCodeReturnStatement (no_error));

		// append to file

		source_type_member_declaration.append (function.copy ());

		function.block = block;
		source_type_member_definition.append (function);

		return wrapper_name;
	}
}
