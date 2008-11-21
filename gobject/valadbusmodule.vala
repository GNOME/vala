/* valadbusmodule.vala
 *
 * Copyright (C) 2008  Jürg Billeter
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

public class Vala.DBusModule : GAsyncModule {
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
		{ "s", "STRING", "const char*", "G_TYPE_STRING", "g_value_get_string", "g_value_set_string" },
		{ "o", "OBJECT_PATH", "const char*", "G_TYPE_STRING", null, "g_value_set_string" },
		{ "g", "SIGNATURE", "const char*", "G_TYPE_STRING", null, "g_value_set_string" }
	};

	public DBusModule (CCodeGenerator codegen, CCodeModule? next) {
		base (codegen, next);
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

	CCodeExpression? get_array_length (CCodeExpression expr) {
		var id = expr as CCodeIdentifier;
		var ma = expr as CCodeMemberAccess;
		if (id != null) {
			return new CCodeIdentifier (id.name + "_length1");
		} else if (ma != null) {
			return new CCodeMemberAccess.pointer (ma.inner, ma.member_name + "_length1");
		}
		return null;
	}

	CCodeExpression read_basic (CCodeFragment fragment, BasicTypeInfo basic_type, CCodeExpression iter_expr) {
		string temp_name = "_tmp%d".printf (next_temp_var_id++);

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
		string temp_name = "_tmp%d".printf (next_temp_var_id++);
		string subiter_name = "_tmp%d".printf (next_temp_var_id++);

		var cdecl = new CCodeDeclaration (array_type.get_cname ());
		cdecl.add_declarator (new CCodeVariableDeclarator.with_initializer (temp_name, new CCodeConstant ("NULL")));
		fragment.append (cdecl);

		cdecl = new CCodeDeclaration ("int");
		cdecl.add_declarator (new CCodeVariableDeclarator.with_initializer (temp_name + "_length1", new CCodeConstant ("0")));
		fragment.append (cdecl);

		cdecl = new CCodeDeclaration ("int");
		cdecl.add_declarator (new CCodeVariableDeclarator.with_initializer (temp_name + "_size", new CCodeConstant ("0")));
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
		cfor.add_iterator (new CCodeUnaryExpression (CCodeUnaryOperator.POSTFIX_INCREMENT, new CCodeIdentifier (temp_name + "_length1")));

		var size_check = new CCodeBinaryExpression (CCodeBinaryOperator.EQUALITY, new CCodeIdentifier (temp_name + "_size"), new CCodeIdentifier (temp_name + "_length1"));
		var init_check = new CCodeBinaryExpression (CCodeBinaryOperator.GREATER_THAN, new CCodeIdentifier (temp_name + "_size"), new CCodeConstant ("0"));
		var new_size = new CCodeConditionalExpression (init_check, new CCodeBinaryExpression (CCodeBinaryOperator.MUL, new CCodeConstant ("2"), new CCodeIdentifier (temp_name + "_size")), new CCodeConstant ("4"));
		var renew_call = new CCodeFunctionCall (new CCodeIdentifier ("g_renew"));
		renew_call.add_argument (new CCodeIdentifier (array_type.element_type.get_cname ()));
		renew_call.add_argument (new CCodeIdentifier (temp_name));
		renew_call.add_argument (new_size);
		var renew_stmt = new CCodeExpressionStatement (new CCodeAssignment (new CCodeIdentifier (temp_name), renew_call));
		var renew_block = new CCodeBlock ();
		renew_block.add_statement (renew_stmt);

		var cif = new CCodeIfStatement (size_check, renew_block);
		cforfragment.append (cif);

		var element_expr = read_expression (cforfragment, array_type.element_type, new CCodeIdentifier (subiter_name), null);
		cforfragment.append (new CCodeExpressionStatement (new CCodeAssignment (new CCodeElementAccess (new CCodeIdentifier (temp_name), new CCodeIdentifier (temp_name + "_length1")), element_expr)));

		fragment.append (cfor);

		if (expr != null) {
			fragment.append (new CCodeExpressionStatement (new CCodeAssignment (get_array_length (expr), new CCodeIdentifier (temp_name + "_length1"))));
		}

		return new CCodeIdentifier (temp_name);
	}

	CCodeExpression read_struct (CCodeFragment fragment, Struct st, CCodeExpression iter_expr) {
		string temp_name = "_tmp%d".printf (next_temp_var_id++);
		string subiter_name = "_tmp%d".printf (next_temp_var_id++);

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

	public CCodeExpression? read_expression (CCodeFragment fragment, DataType type, CCodeExpression iter_expr, CCodeExpression? expr) {
		BasicTypeInfo basic_type;
		CCodeExpression result = null;
		if (get_basic_type_info (type.get_type_signature (), out basic_type)) {
			result = read_basic (fragment, basic_type, iter_expr);
		} else if (type is ArrayType) {
			result = read_array (fragment, (ArrayType) type, iter_expr, expr);
		} else if (type.data_type is Struct) {
			result = read_struct (fragment, (Struct) type.data_type, iter_expr);
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
		string temp_name = "_tmp%d".printf (next_temp_var_id++);

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
		string subiter_name = "_tmp%d".printf (next_temp_var_id++);
		string index_name = "_tmp%d".printf (next_temp_var_id++);

		var cdecl = new CCodeDeclaration ("DBusMessageIter");
		cdecl.add_declarator (new CCodeVariableDeclarator (subiter_name));
		fragment.append (cdecl);

		cdecl = new CCodeDeclaration ("int");
		cdecl.add_declarator (new CCodeVariableDeclarator (index_name));
		fragment.append (cdecl);

		var iter_call = new CCodeFunctionCall (new CCodeIdentifier ("dbus_message_iter_open_container"));
		iter_call.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, iter_expr));
		iter_call.add_argument (new CCodeIdentifier ("DBUS_TYPE_ARRAY"));
		iter_call.add_argument (new CCodeConstant ("\"%s\"".printf (array_type.element_type.get_type_signature ())));
		iter_call.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, new CCodeIdentifier (subiter_name)));
		fragment.append (new CCodeExpressionStatement (iter_call));

		var cforblock = new CCodeBlock ();
		var cforfragment = new CCodeFragment ();
		cforblock.add_statement (cforfragment);
		var cfor = new CCodeForStatement (new CCodeBinaryExpression (CCodeBinaryOperator.LESS_THAN, new CCodeIdentifier (index_name), get_array_length (array_expr)), cforblock);
		cfor.add_initializer (new CCodeAssignment (new CCodeIdentifier (index_name), new CCodeConstant ("0")));
		cfor.add_iterator (new CCodeUnaryExpression (CCodeUnaryOperator.POSTFIX_INCREMENT, new CCodeIdentifier (index_name)));

		write_expression (cforfragment, array_type.element_type, new CCodeIdentifier (subiter_name), new CCodeElementAccess (array_expr, new CCodeIdentifier (index_name)));
		fragment.append (cfor);

		iter_call = new CCodeFunctionCall (new CCodeIdentifier ("dbus_message_iter_close_container"));
		iter_call.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, iter_expr));
		iter_call.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, new CCodeIdentifier (subiter_name)));
		fragment.append (new CCodeExpressionStatement (iter_call));
	}

	void write_struct (CCodeFragment fragment, Struct st, CCodeExpression iter_expr, CCodeExpression struct_expr) {
		string subiter_name = "_tmp%d".printf (next_temp_var_id++);

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

	public void write_expression (CCodeFragment fragment, DataType type, CCodeExpression iter_expr, CCodeExpression expr) {
		BasicTypeInfo basic_type;
		if (get_basic_type_info (type.get_type_signature (), out basic_type)) {
			write_basic (fragment, basic_type, iter_expr, expr);
		} else if (type is ArrayType) {
			write_array (fragment, (ArrayType) type, iter_expr, expr);
		} else if (type.data_type is Struct) {
			write_struct (fragment, (Struct) type.data_type, iter_expr, expr);
		} else {
			Report.error (type.source_reference, "D-Bus serialization of type `%s' is not supported".printf (type.to_string ()));
		}
	}
}
