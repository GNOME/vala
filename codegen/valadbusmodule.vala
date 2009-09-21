/* valadbusmodule.vala
 *
 * Copyright (C) 2008-2009  Jürg Billeter
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

internal class Vala.DBusModule : GAsyncModule {
	struct BasicTypeInfo {
		public weak string signature;
		public weak string type_name;
		public weak string cname;
		public weak string gtype;
		public weak string? get_value_function;
		public weak string set_value_function;
	}

	const BasicTypeInfo[] basic_types = {
		{ "y", "BYTE", "guint8", "G_TYPE_UCHAR", "g_value_get_uchar", "g_value_set_uchar" },
		{ "b", "BOOLEAN", "dbus_bool_t", "G_TYPE_BOOLEAN", "g_value_get_boolean", "g_value_set_boolean" },
		{ "n", "INT16", "dbus_int16_t", "G_TYPE_INT", null, "g_value_set_int" },
		{ "q", "UINT16", "dbus_uint16_t", "G_TYPE_UINT", null, "g_value_set_uint" },
		{ "i", "INT32", "dbus_int32_t", "G_TYPE_INT", "g_value_get_int", "g_value_set_int" },
		{ "u", "UINT32", "dbus_uint32_t", "G_TYPE_UINT", "g_value_get_uint", "g_value_set_uint" },
		{ "x", "INT64", "dbus_int64_t", "G_TYPE_INT64", "g_value_get_int64", "g_value_set_int64" },
		{ "t", "UINT64", "dbus_uint64_t", "G_TYPE_UINT64", "g_value_get_uint64", "g_value_set_uint64" },
		{ "d", "DOUBLE", "double", "G_TYPE_DOUBLE", "g_value_get_double", "g_value_set_double" },
		{ "s", "STRING", "const char*", "G_TYPE_STRING", "g_value_get_string", "g_value_take_string" },
		{ "o", "OBJECT_PATH", "const char*", "G_TYPE_STRING", null, "g_value_take_string" },
		{ "g", "SIGNATURE", "const char*", "G_TYPE_STRING", null, "g_value_take_string" }
	};

	public DBusModule (CCodeGenerator codegen, CCodeModule? next) {
		base (codegen, next);
	}

	public string? get_dbus_name (TypeSymbol symbol) {
		var dbus = symbol.get_attribute ("DBus");
		if (dbus == null) {
			return null;
		}

		return dbus.get_string ("name");
	}

	public string get_dbus_name_for_member (Symbol symbol) {
		var dbus = symbol.get_attribute ("DBus");
		if (dbus != null) {
			return dbus.get_string ("name");
		}

		return Symbol.lower_case_to_camel_case (symbol.name);
	}

	bool get_basic_type_info (string signature, out BasicTypeInfo basic_type) {
		foreach (BasicTypeInfo info in basic_types) {
			if (info.signature == signature) {
				basic_type = info;
				return true;
			}
		}
		return false;
	}

	public static string get_type_signature (DataType datatype) {
		return datatype.get_type_signature ();
	}

	CCodeExpression? get_array_length (CCodeExpression expr, int dim) {
		var id = expr as CCodeIdentifier;
		var ma = expr as CCodeMemberAccess;
		if (id != null) {
			return new CCodeIdentifier ("%s_length%d".printf (id.name, dim));
		} else if (ma != null) {
			return new CCodeMemberAccess.pointer (ma.inner, "%s_length%d".printf (ma.member_name, dim));
		}
		return null;
	}

	CCodeExpression read_basic (CCodeFragment fragment, BasicTypeInfo basic_type, CCodeExpression iter_expr) {
		string temp_name = "_tmp%d_".printf (next_temp_var_id++);

		var cdecl = new CCodeDeclaration (basic_type.cname);
		cdecl.add_declarator (new CCodeVariableDeclarator (temp_name));
		fragment.append (cdecl);

		var iter_call = new CCodeFunctionCall (new CCodeIdentifier ("dbus_message_iter_get_basic"));
		iter_call.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, iter_expr));
		iter_call.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, new CCodeIdentifier (temp_name)));
		fragment.append (new CCodeExpressionStatement (iter_call));

		var temp_result = new CCodeIdentifier (temp_name);

		if (basic_type.signature == "s"
		    || basic_type.signature == "o"
		    || basic_type.signature == "g") {
			var dup_call = new CCodeFunctionCall (new CCodeIdentifier ("g_strdup"));
			dup_call.add_argument (temp_result);
			return dup_call;
		} else {
			return temp_result;
		}
	}

	CCodeExpression read_array (CCodeFragment fragment, ArrayType array_type, CCodeExpression iter_expr, CCodeExpression? expr) {
		string temp_name = "_tmp%d_".printf (next_temp_var_id++);

		var new_call = new CCodeFunctionCall (new CCodeIdentifier ("g_new"));
		new_call.add_argument (new CCodeIdentifier (array_type.element_type.get_cname ()));
		// add one extra element for NULL-termination
		new_call.add_argument (new CCodeConstant ("5"));

		var cdecl = new CCodeDeclaration (array_type.get_cname ());
		cdecl.add_declarator (new CCodeVariableDeclarator (temp_name, new_call));
		fragment.append (cdecl);

		cdecl = new CCodeDeclaration ("int");
		cdecl.add_declarator (new CCodeVariableDeclarator (temp_name + "_length", new CCodeConstant ("0")));
		fragment.append (cdecl);

		cdecl = new CCodeDeclaration ("int");
		cdecl.add_declarator (new CCodeVariableDeclarator (temp_name + "_size", new CCodeConstant ("4")));
		fragment.append (cdecl);

		read_array_dim (fragment, array_type, 1, temp_name, iter_expr, expr);

		if (array_type.element_type.is_reference_type_or_type_parameter ()) {
			// NULL terminate array
			var length = new CCodeIdentifier (temp_name + "_length");
			var element_access = new CCodeElementAccess (new CCodeIdentifier (temp_name), length);
			fragment.append (new CCodeExpressionStatement (new CCodeAssignment (element_access, new CCodeIdentifier ("NULL"))));
		}

		return new CCodeIdentifier (temp_name);
	}

	void read_array_dim (CCodeFragment fragment, ArrayType array_type, int dim, string temp_name, CCodeExpression iter_expr, CCodeExpression? expr) {
		string subiter_name = "_tmp%d_".printf (next_temp_var_id++);

		var cdecl = new CCodeDeclaration ("int");
		cdecl.add_declarator (new CCodeVariableDeclarator ("%s_length%d".printf (temp_name, dim), new CCodeConstant ("0")));
		fragment.append (cdecl);

		cdecl = new CCodeDeclaration ("DBusMessageIter");
		cdecl.add_declarator (new CCodeVariableDeclarator (subiter_name));
		fragment.append (cdecl);

		var iter_call = new CCodeFunctionCall (new CCodeIdentifier ("dbus_message_iter_recurse"));
		iter_call.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, iter_expr));
		iter_call.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, new CCodeIdentifier (subiter_name)));
		fragment.append (new CCodeExpressionStatement (iter_call));

		iter_call = new CCodeFunctionCall (new CCodeIdentifier ("dbus_message_iter_get_arg_type"));
		iter_call.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, new CCodeIdentifier (subiter_name)));

		var cforblock = new CCodeBlock ();
		var cforfragment = new CCodeFragment ();
		cforblock.add_statement (cforfragment);
		var cfor = new CCodeForStatement (iter_call, cforblock);
		cfor.add_iterator (new CCodeUnaryExpression (CCodeUnaryOperator.POSTFIX_INCREMENT, new CCodeIdentifier ("%s_length%d".printf (temp_name, dim))));

		if (dim < array_type.rank) {
			read_array_dim (cforfragment, array_type, dim + 1, temp_name, new CCodeIdentifier (subiter_name), expr);

			iter_call = new CCodeFunctionCall (new CCodeIdentifier ("dbus_message_iter_next"));
			iter_call.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, new CCodeIdentifier (subiter_name)));
			cforfragment.append (new CCodeExpressionStatement (iter_call));
		} else {
			var size_check = new CCodeBinaryExpression (CCodeBinaryOperator.EQUALITY, new CCodeIdentifier (temp_name + "_size"), new CCodeIdentifier (temp_name + "_length"));
			var renew_block = new CCodeBlock ();

			// tmp_size = (2 * tmp_size);
			var new_size = new CCodeBinaryExpression (CCodeBinaryOperator.MUL, new CCodeConstant ("2"), new CCodeIdentifier (temp_name + "_size"));
			renew_block.add_statement (new CCodeExpressionStatement (new CCodeAssignment (new CCodeIdentifier (temp_name + "_size"), new_size)));

			var renew_call = new CCodeFunctionCall (new CCodeIdentifier ("g_renew"));
			renew_call.add_argument (new CCodeIdentifier (array_type.element_type.get_cname ()));
			renew_call.add_argument (new CCodeIdentifier (temp_name));
			// add one extra element for NULL-termination
			renew_call.add_argument (new CCodeBinaryExpression (CCodeBinaryOperator.PLUS, new CCodeIdentifier (temp_name + "_size"), new CCodeConstant ("1")));
			var renew_stmt = new CCodeExpressionStatement (new CCodeAssignment (new CCodeIdentifier (temp_name), renew_call));
			renew_block.add_statement (renew_stmt);

			var cif = new CCodeIfStatement (size_check, renew_block);
			cforfragment.append (cif);

			var element_access = new CCodeElementAccess (new CCodeIdentifier (temp_name), new CCodeUnaryExpression (CCodeUnaryOperator.POSTFIX_INCREMENT, new CCodeIdentifier (temp_name + "_length")));
			var element_expr = read_expression (cforfragment, array_type.element_type, new CCodeIdentifier (subiter_name), null);
			cforfragment.append (new CCodeExpressionStatement (new CCodeAssignment (element_access, element_expr)));
		}

		fragment.append (cfor);

		if (expr != null) {
			fragment.append (new CCodeExpressionStatement (new CCodeAssignment (get_array_length (expr, dim), new CCodeIdentifier ("%s_length%d".printf (temp_name, dim)))));
		}
	}

	CCodeExpression read_struct (CCodeFragment fragment, Struct st, CCodeExpression iter_expr) {
		string temp_name = "_tmp%d_".printf (next_temp_var_id++);
		string subiter_name = "_tmp%d_".printf (next_temp_var_id++);

		var cdecl = new CCodeDeclaration (st.get_cname ());
		cdecl.add_declarator (new CCodeVariableDeclarator (temp_name));
		fragment.append (cdecl);

		cdecl = new CCodeDeclaration ("DBusMessageIter");
		cdecl.add_declarator (new CCodeVariableDeclarator (subiter_name));
		fragment.append (cdecl);

		var iter_call = new CCodeFunctionCall (new CCodeIdentifier ("dbus_message_iter_recurse"));
		iter_call.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, iter_expr));
		iter_call.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, new CCodeIdentifier (subiter_name)));
		fragment.append (new CCodeExpressionStatement (iter_call));

		foreach (Field f in st.get_fields ()) {
			if (f.binding != MemberBinding.INSTANCE) {
				continue;
			}

			var field_expr = read_expression (fragment, f.field_type, new CCodeIdentifier (subiter_name), new CCodeMemberAccess (new CCodeIdentifier (temp_name), f.get_cname ()));
			fragment.append (new CCodeExpressionStatement (new CCodeAssignment (new CCodeMemberAccess (new CCodeIdentifier (temp_name), f.get_cname ()), field_expr)));
		}

		return new CCodeIdentifier (temp_name);
	}

	CCodeExpression read_value (CCodeFragment fragment, CCodeExpression iter_expr) {
		string temp_name = "_tmp%d_".printf (next_temp_var_id++);
		string subiter_name = "_tmp%d_".printf (next_temp_var_id++);

		// 0-initialize struct with struct initializer { 0 }
		var cvalinit = new CCodeInitializerList ();
		cvalinit.append (new CCodeConstant ("0"));

		var cdecl = new CCodeDeclaration ("GValue");
		cdecl.add_declarator (new CCodeVariableDeclarator (temp_name, cvalinit));
		fragment.append (cdecl);

		cdecl = new CCodeDeclaration ("DBusMessageIter");
		cdecl.add_declarator (new CCodeVariableDeclarator (subiter_name));
		fragment.append (cdecl);

		var iter_call = new CCodeFunctionCall (new CCodeIdentifier ("dbus_message_iter_recurse"));
		iter_call.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, iter_expr));
		iter_call.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, new CCodeIdentifier (subiter_name)));
		fragment.append (new CCodeExpressionStatement (iter_call));

		CCodeIfStatement clastif = null;

		foreach (BasicTypeInfo basic_type in basic_types) {
			var type_call = new CCodeFunctionCall (new CCodeIdentifier ("dbus_message_iter_get_arg_type"));
			type_call.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, new CCodeIdentifier (subiter_name)));
			var type_check = new CCodeBinaryExpression (CCodeBinaryOperator.EQUALITY, type_call, new CCodeIdentifier ("DBUS_TYPE_" + basic_type.type_name));

			var type_block = new CCodeBlock ();
			var type_fragment = new CCodeFragment ();
			type_block.add_statement (type_fragment);
			var result = read_basic (type_fragment, basic_type, new CCodeIdentifier (subiter_name));

			var value_init = new CCodeFunctionCall (new CCodeIdentifier ("g_value_init"));
			value_init.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, new CCodeIdentifier (temp_name)));
			value_init.add_argument (new CCodeIdentifier (basic_type.gtype));
			type_fragment.append (new CCodeExpressionStatement (value_init));

			var value_set = new CCodeFunctionCall (new CCodeIdentifier (basic_type.set_value_function));
			value_set.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, new CCodeIdentifier (temp_name)));
			value_set.add_argument (result);
			type_fragment.append (new CCodeExpressionStatement (value_set));

			var cif = new CCodeIfStatement (type_check, type_block);
			if (clastif == null) {
				fragment.append (cif);
			} else {
				clastif.false_statement = cif;
			}

			clastif = cif;
		}

		return new CCodeIdentifier (temp_name);
	}

	CCodeExpression read_hash_table (CCodeFragment fragment, ObjectType type, CCodeExpression iter_expr) {
		string temp_name = "_tmp%d_".printf (next_temp_var_id++);
		string subiter_name = "_tmp%d_".printf (next_temp_var_id++);
		string entryiter_name = "_tmp%d_".printf (next_temp_var_id++);

		var type_args = type.get_type_arguments ();
		assert (type_args.size == 2);
		var key_type = type_args.get (0);
		var value_type = type_args.get (1);

		var cdecl = new CCodeDeclaration ("GHashTable*");
		cdecl.add_declarator (new CCodeVariableDeclarator (temp_name));
		fragment.append (cdecl);

		cdecl = new CCodeDeclaration ("DBusMessageIter");
		cdecl.add_declarator (new CCodeVariableDeclarator (subiter_name));
		fragment.append (cdecl);

		cdecl = new CCodeDeclaration ("DBusMessageIter");
		cdecl.add_declarator (new CCodeVariableDeclarator (entryiter_name));
		fragment.append (cdecl);

		var hash_table_new = new CCodeFunctionCall (new CCodeIdentifier ("g_hash_table_new_full"));
		if (key_type.data_type == string_type.data_type) {
			hash_table_new.add_argument (new CCodeIdentifier ("g_str_hash"));
			hash_table_new.add_argument (new CCodeIdentifier ("g_str_equal"));
		} else {
			hash_table_new.add_argument (new CCodeIdentifier ("g_direct_hash"));
			hash_table_new.add_argument (new CCodeIdentifier ("g_direct_equal"));
		}
		if (key_type.data_type == string_type.data_type) {
			hash_table_new.add_argument (new CCodeIdentifier ("g_free"));
		} else {
			hash_table_new.add_argument (new CCodeIdentifier ("NULL"));
		}
		if (value_type.data_type == string_type.data_type) {
			hash_table_new.add_argument (new CCodeIdentifier ("g_free"));
		} else {
			hash_table_new.add_argument (new CCodeIdentifier ("NULL"));
		}
		fragment.append (new CCodeExpressionStatement (new CCodeAssignment (new CCodeIdentifier (temp_name), hash_table_new)));

		var iter_call = new CCodeFunctionCall (new CCodeIdentifier ("dbus_message_iter_recurse"));
		iter_call.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, iter_expr));
		iter_call.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, new CCodeIdentifier (subiter_name)));
		fragment.append (new CCodeExpressionStatement (iter_call));

		iter_call = new CCodeFunctionCall (new CCodeIdentifier ("dbus_message_iter_get_arg_type"));
		iter_call.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, new CCodeIdentifier (subiter_name)));

		var cwhileblock = new CCodeBlock ();
		var cwhilefragment = new CCodeFragment ();
		cwhileblock.add_statement (cwhilefragment);
		var cwhile = new CCodeWhileStatement (iter_call, cwhileblock);

		iter_call = new CCodeFunctionCall (new CCodeIdentifier ("dbus_message_iter_recurse"));
		iter_call.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, new CCodeIdentifier (subiter_name)));
		iter_call.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, new CCodeIdentifier (entryiter_name)));
		cwhilefragment.append (new CCodeExpressionStatement (iter_call));

		cdecl = new CCodeDeclaration (key_type.get_cname ());
		cdecl.add_declarator (new CCodeVariableDeclarator ("_key"));
		cwhilefragment.append (cdecl);

		cdecl = new CCodeDeclaration (value_type.get_cname ());
		cdecl.add_declarator (new CCodeVariableDeclarator ("_value"));
		cwhilefragment.append (cdecl);

		var key_expr = read_expression (cwhilefragment, key_type, new CCodeIdentifier (entryiter_name), null);
		cwhilefragment.append (new CCodeExpressionStatement (new CCodeAssignment (new CCodeIdentifier ("_key"), key_expr)));
		
		var value_expr = read_expression (cwhilefragment, value_type, new CCodeIdentifier (entryiter_name), null);
		cwhilefragment.append (new CCodeExpressionStatement (new CCodeAssignment (new CCodeIdentifier ("_value"), value_expr)));

		var hash_table_insert = new CCodeFunctionCall (new CCodeIdentifier ("g_hash_table_insert"));
		hash_table_insert.add_argument (new CCodeIdentifier (temp_name));
		hash_table_insert.add_argument (convert_to_generic_pointer (new CCodeIdentifier ("_key"), key_type));
		hash_table_insert.add_argument (convert_to_generic_pointer (new CCodeIdentifier ("_value"), value_type));
		cwhilefragment.append (new CCodeExpressionStatement (hash_table_insert));

		iter_call = new CCodeFunctionCall (new CCodeIdentifier ("dbus_message_iter_next"));
		iter_call.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, new CCodeIdentifier (subiter_name)));
		cwhilefragment.append (new CCodeExpressionStatement (iter_call));

		fragment.append (cwhile);

		return new CCodeIdentifier (temp_name);
	}

	public CCodeExpression? read_expression (CCodeFragment fragment, DataType type, CCodeExpression iter_expr, CCodeExpression? expr) {
		BasicTypeInfo basic_type;
		CCodeExpression result = null;
		if (get_basic_type_info (get_type_signature (type), out basic_type)) {
			result = read_basic (fragment, basic_type, iter_expr);
		} else if (type is ArrayType) {
			result = read_array (fragment, (ArrayType) type, iter_expr, expr);
		} else if (type.data_type is Struct) {
			var st = (Struct) type.data_type;
			if (type.data_type.get_full_name () == "GLib.Value") {
				result = read_value (fragment, iter_expr);
			} else {
				result = read_struct (fragment, st, iter_expr);
			}
			if (type.nullable) {
				var csizeof = new CCodeFunctionCall (new CCodeIdentifier ("sizeof"));
				csizeof.add_argument (new CCodeIdentifier (st.get_cname ()));
				var cdup = new CCodeFunctionCall (new CCodeIdentifier ("g_memdup"));
				cdup.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, result));
				cdup.add_argument (csizeof);
				result = cdup;
			}
		} else if (type is ObjectType) {
			if (type.data_type.get_full_name () == "GLib.HashTable") {
				result = read_hash_table (fragment, (ObjectType) type, iter_expr);
			}
		} else {
			Report.error (type.source_reference, "D-Bus deserialization of type `%s' is not supported".printf (type.to_string ()));
			return null;
		}

		var iter_call = new CCodeFunctionCall (new CCodeIdentifier ("dbus_message_iter_next"));
		iter_call.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, iter_expr));
		fragment.append (new CCodeExpressionStatement (iter_call));

		return result;
	}

	void write_basic (CCodeFragment fragment, BasicTypeInfo basic_type, CCodeExpression iter_expr, CCodeExpression expr) {
		string temp_name = "_tmp%d_".printf (next_temp_var_id++);

		var cdecl = new CCodeDeclaration (basic_type.cname);
		cdecl.add_declarator (new CCodeVariableDeclarator (temp_name));
		fragment.append (cdecl);

		fragment.append (new CCodeExpressionStatement (new CCodeAssignment (new CCodeIdentifier (temp_name), expr)));

		var iter_call = new CCodeFunctionCall (new CCodeIdentifier ("dbus_message_iter_append_basic"));
		iter_call.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, iter_expr));
		iter_call.add_argument (new CCodeIdentifier ("DBUS_TYPE_" + basic_type.type_name));
		iter_call.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, new CCodeIdentifier (temp_name)));
		fragment.append (new CCodeExpressionStatement (iter_call));
	}

	void write_array (CCodeFragment fragment, ArrayType array_type, CCodeExpression iter_expr, CCodeExpression array_expr) {
		string array_iter_name = "_tmp%d_".printf (next_temp_var_id++);

		var cdecl = new CCodeDeclaration (array_type.get_cname ());
		cdecl.add_declarator (new CCodeVariableDeclarator (array_iter_name));
		fragment.append (cdecl);

		fragment.append (new CCodeExpressionStatement (new CCodeAssignment (new CCodeIdentifier (array_iter_name), array_expr)));

		write_array_dim (fragment, array_type, 1, iter_expr, array_expr, new CCodeIdentifier (array_iter_name));
	}

	void write_array_dim (CCodeFragment fragment, ArrayType array_type, int dim, CCodeExpression iter_expr, CCodeExpression array_expr, CCodeExpression array_iter_expr) {
		string subiter_name = "_tmp%d_".printf (next_temp_var_id++);
		string index_name = "_tmp%d_".printf (next_temp_var_id++);

		var cdecl = new CCodeDeclaration ("DBusMessageIter");
		cdecl.add_declarator (new CCodeVariableDeclarator (subiter_name));
		fragment.append (cdecl);

		cdecl = new CCodeDeclaration ("int");
		cdecl.add_declarator (new CCodeVariableDeclarator (index_name));
		fragment.append (cdecl);

		var iter_call = new CCodeFunctionCall (new CCodeIdentifier ("dbus_message_iter_open_container"));
		iter_call.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, iter_expr));
		iter_call.add_argument (new CCodeIdentifier ("DBUS_TYPE_ARRAY"));
		iter_call.add_argument (new CCodeConstant ("\"%s%s\"".printf (string.nfill (array_type.rank - dim, 'a'), get_type_signature (array_type.element_type))));
		iter_call.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, new CCodeIdentifier (subiter_name)));
		fragment.append (new CCodeExpressionStatement (iter_call));

		var cforblock = new CCodeBlock ();
		var cforfragment = new CCodeFragment ();
		cforblock.add_statement (cforfragment);
		var cfor = new CCodeForStatement (new CCodeBinaryExpression (CCodeBinaryOperator.LESS_THAN, new CCodeIdentifier (index_name), get_array_length (array_expr, dim)), cforblock);
		cfor.add_initializer (new CCodeAssignment (new CCodeIdentifier (index_name), new CCodeConstant ("0")));
		cfor.add_iterator (new CCodeUnaryExpression (CCodeUnaryOperator.POSTFIX_INCREMENT, new CCodeIdentifier (index_name)));
		
		if (dim < array_type.rank) {
			write_array_dim (cforfragment, array_type, dim + 1, new CCodeIdentifier (subiter_name), array_expr, array_iter_expr);
		} else {
			var element_expr = new CCodeUnaryExpression (CCodeUnaryOperator.POINTER_INDIRECTION, array_iter_expr);
			write_expression (cforfragment, array_type.element_type, new CCodeIdentifier (subiter_name), element_expr);

			var array_iter_incr = new CCodeUnaryExpression (CCodeUnaryOperator.POSTFIX_INCREMENT, array_iter_expr);
			cforfragment.append (new CCodeExpressionStatement (array_iter_incr));
		}
		fragment.append (cfor);

		iter_call = new CCodeFunctionCall (new CCodeIdentifier ("dbus_message_iter_close_container"));
		iter_call.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, iter_expr));
		iter_call.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, new CCodeIdentifier (subiter_name)));
		fragment.append (new CCodeExpressionStatement (iter_call));
	}

	void write_struct (CCodeFragment fragment, Struct st, CCodeExpression iter_expr, CCodeExpression struct_expr) {
		string subiter_name = "_tmp%d_".printf (next_temp_var_id++);

		var cdecl = new CCodeDeclaration ("DBusMessageIter");
		cdecl.add_declarator (new CCodeVariableDeclarator (subiter_name));
		fragment.append (cdecl);

		var iter_call = new CCodeFunctionCall (new CCodeIdentifier ("dbus_message_iter_open_container"));
		iter_call.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, iter_expr));
		iter_call.add_argument (new CCodeIdentifier ("DBUS_TYPE_STRUCT"));
		iter_call.add_argument (new CCodeConstant ("NULL"));
		iter_call.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, new CCodeIdentifier (subiter_name)));
		fragment.append (new CCodeExpressionStatement (iter_call));

		foreach (Field f in st.get_fields ()) {
			if (f.binding != MemberBinding.INSTANCE) {
				continue;
			}

			write_expression (fragment, f.field_type, new CCodeIdentifier (subiter_name), new CCodeMemberAccess (struct_expr, f.get_cname ()));
		}

		iter_call = new CCodeFunctionCall (new CCodeIdentifier ("dbus_message_iter_close_container"));
		iter_call.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, iter_expr));
		iter_call.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, new CCodeIdentifier (subiter_name)));
		fragment.append (new CCodeExpressionStatement (iter_call));
	}

	void write_value (CCodeFragment fragment, CCodeExpression iter_expr, CCodeExpression expr) {
		string subiter_name = "_tmp%d_".printf (next_temp_var_id++);

		var cdecl = new CCodeDeclaration ("DBusMessageIter");
		cdecl.add_declarator (new CCodeVariableDeclarator (subiter_name));
		fragment.append (cdecl);

		CCodeIfStatement clastif = null;

		foreach (BasicTypeInfo basic_type in basic_types) {
			// ensure that there is only one case per GType
			if (basic_type.get_value_function == null) {
				continue;
			}

			var type_call = new CCodeFunctionCall (new CCodeIdentifier ("G_VALUE_TYPE"));
			type_call.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, expr));
			var type_check = new CCodeBinaryExpression (CCodeBinaryOperator.EQUALITY, type_call, new CCodeIdentifier (basic_type.gtype));

			var type_block = new CCodeBlock ();
			var type_fragment = new CCodeFragment ();
			type_block.add_statement (type_fragment);

			var iter_call = new CCodeFunctionCall (new CCodeIdentifier ("dbus_message_iter_open_container"));
			iter_call.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, iter_expr));
			iter_call.add_argument (new CCodeIdentifier ("DBUS_TYPE_VARIANT"));
			iter_call.add_argument (new CCodeConstant ("\"%s\"".printf (basic_type.signature)));
			iter_call.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, new CCodeIdentifier (subiter_name)));
			type_fragment.append (new CCodeExpressionStatement (iter_call));

			var value_get = new CCodeFunctionCall (new CCodeIdentifier (basic_type.get_value_function));
			value_get.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, expr));

			write_basic (type_fragment, basic_type, new CCodeIdentifier (subiter_name), value_get);

			iter_call = new CCodeFunctionCall (new CCodeIdentifier ("dbus_message_iter_close_container"));
			iter_call.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, iter_expr));
			iter_call.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, new CCodeIdentifier (subiter_name)));
			type_fragment.append (new CCodeExpressionStatement (iter_call));

			var cif = new CCodeIfStatement (type_check, type_block);
			if (clastif == null) {
				fragment.append (cif);
			} else {
				clastif.false_statement = cif;
			}

			clastif = cif;
		}
	}

	void write_hash_table (CCodeFragment fragment, ObjectType type, CCodeExpression iter_expr, CCodeExpression hash_table_expr) {
		string subiter_name = "_tmp%d_".printf (next_temp_var_id++);
		string entryiter_name = "_tmp%d_".printf (next_temp_var_id++);
		string tableiter_name = "_tmp%d_".printf (next_temp_var_id++);
		string key_name = "_tmp%d_".printf (next_temp_var_id++);
		string value_name = "_tmp%d_".printf (next_temp_var_id++);

		var type_args = type.get_type_arguments ();
		assert (type_args.size == 2);
		var key_type = type_args.get (0);
		var value_type = type_args.get (1);

		var iter_call = new CCodeFunctionCall (new CCodeIdentifier ("dbus_message_iter_open_container"));
		iter_call.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, iter_expr));
		iter_call.add_argument (new CCodeIdentifier ("DBUS_TYPE_ARRAY"));
		iter_call.add_argument (new CCodeConstant ("\"{%s%s}\"".printf (get_type_signature (key_type), get_type_signature (value_type))));
		iter_call.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, new CCodeIdentifier (subiter_name)));
		fragment.append (new CCodeExpressionStatement (iter_call));

		var cdecl = new CCodeDeclaration ("DBusMessageIter");
		cdecl.add_declarator (new CCodeVariableDeclarator (subiter_name));
		cdecl.add_declarator (new CCodeVariableDeclarator (entryiter_name));
		fragment.append (cdecl);

		cdecl = new CCodeDeclaration ("GHashTableIter");
		cdecl.add_declarator (new CCodeVariableDeclarator (tableiter_name));
		fragment.append (cdecl);

		cdecl = new CCodeDeclaration ("gpointer");
		cdecl.add_declarator (new CCodeVariableDeclarator (key_name));
		cdecl.add_declarator (new CCodeVariableDeclarator (value_name));
		fragment.append (cdecl);

		var iter_init_call = new CCodeFunctionCall (new CCodeIdentifier ("g_hash_table_iter_init"));
		iter_init_call.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, new CCodeIdentifier (tableiter_name)));
		iter_init_call.add_argument (hash_table_expr);
		fragment.append (new CCodeExpressionStatement (iter_init_call));

		var iter_next_call = new CCodeFunctionCall (new CCodeIdentifier ("g_hash_table_iter_next"));
		iter_next_call.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, new CCodeIdentifier (tableiter_name)));
		iter_next_call.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, new CCodeIdentifier (key_name)));
		iter_next_call.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, new CCodeIdentifier (value_name)));

		var cwhileblock = new CCodeBlock ();
		var cwhilefragment = new CCodeFragment ();
		cwhileblock.add_statement (cwhilefragment);
		var cwhile = new CCodeWhileStatement (iter_next_call, cwhileblock);

		cdecl = new CCodeDeclaration (key_type.get_cname ());
		cdecl.add_declarator (new CCodeVariableDeclarator ("_key"));
		cwhilefragment.append (cdecl);

		cdecl = new CCodeDeclaration (value_type.get_cname ());
		cdecl.add_declarator (new CCodeVariableDeclarator ("_value"));
		cwhilefragment.append (cdecl);

		iter_call = new CCodeFunctionCall (new CCodeIdentifier ("dbus_message_iter_open_container"));
		iter_call.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, new CCodeIdentifier (subiter_name)));
		iter_call.add_argument (new CCodeIdentifier ("DBUS_TYPE_DICT_ENTRY"));
		iter_call.add_argument (new CCodeConstant ("NULL"));
		iter_call.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, new CCodeIdentifier (entryiter_name)));
		cwhilefragment.append (new CCodeExpressionStatement (iter_call));

		cwhilefragment.append (new CCodeExpressionStatement (new CCodeAssignment (new CCodeIdentifier ("_key"), convert_from_generic_pointer (new CCodeIdentifier (key_name), key_type))));
		cwhilefragment.append (new CCodeExpressionStatement (new CCodeAssignment (new CCodeIdentifier ("_value"), convert_from_generic_pointer (new CCodeIdentifier (value_name), value_type))));

		write_expression (cwhilefragment, key_type, new CCodeIdentifier (entryiter_name), new CCodeIdentifier ("_key"));
		write_expression (cwhilefragment, value_type, new CCodeIdentifier (entryiter_name), new CCodeIdentifier ("_value"));

		iter_call = new CCodeFunctionCall (new CCodeIdentifier ("dbus_message_iter_close_container"));
		iter_call.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, new CCodeIdentifier (subiter_name)));
		iter_call.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, new CCodeIdentifier (entryiter_name)));
		cwhilefragment.append (new CCodeExpressionStatement (iter_call));

		fragment.append (cwhile);

		iter_call = new CCodeFunctionCall (new CCodeIdentifier ("dbus_message_iter_close_container"));
		iter_call.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, iter_expr));
		iter_call.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, new CCodeIdentifier (subiter_name)));
		fragment.append (new CCodeExpressionStatement (iter_call));
	}

	public void write_expression (CCodeFragment fragment, DataType type, CCodeExpression iter_expr, CCodeExpression expr) {
		BasicTypeInfo basic_type;
		if (get_basic_type_info (get_type_signature (type), out basic_type)) {
			write_basic (fragment, basic_type, iter_expr, expr);
		} else if (type is ArrayType) {
			write_array (fragment, (ArrayType) type, iter_expr, expr);
		} else if (type.data_type is Struct) {
			var st_expr = expr;
			if (type.nullable) {
				st_expr = new CCodeUnaryExpression (CCodeUnaryOperator.POINTER_INDIRECTION, st_expr);
			}
			if (type.data_type.get_full_name () == "GLib.Value") {
				write_value (fragment, iter_expr, st_expr);
			} else {
				write_struct (fragment, (Struct) type.data_type, iter_expr, st_expr);
			}
		} else if (type is ObjectType) {
			if (type.data_type.get_full_name () == "GLib.HashTable") {
				write_hash_table (fragment, (ObjectType) type, iter_expr, expr);
			}
		} else {
			Report.error (type.source_reference, "D-Bus serialization of type `%s' is not supported".printf (type.to_string ()));
		}
	}
}
