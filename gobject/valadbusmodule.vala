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

	public CCodeExpression? read_expression (CCodeFragment fragment, DataType type, CCodeExpression iter_expr, CCodeExpression? expr) {
		BasicTypeInfo basic_type;
		CCodeExpression result = null;
		if (get_basic_type_info (type.get_type_signature (), out basic_type)) {
			result = read_basic (fragment, basic_type, iter_expr);
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

	public void write_expression (CCodeFragment fragment, DataType type, CCodeExpression iter_expr, CCodeExpression expr) {
		BasicTypeInfo basic_type;
		if (get_basic_type_info (type.get_type_signature (), out basic_type)) {
			write_basic (fragment, basic_type, iter_expr, expr);
		} else {
			Report.error (type.source_reference, "D-Bus serialization of type `%s' is not supported".printf (type.to_string ()));
		}
	}
}
