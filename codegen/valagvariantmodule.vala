/* valagvariantmodule.vala
 *
 * Copyright (C) 2010-2011  Jürg Billeter
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

public class Vala.GVariantModule : GAsyncModule {
	struct BasicTypeInfo {
		public unowned string signature;
		public unowned string type_name;
		public bool is_string;
	}

	const BasicTypeInfo[] basic_types = {
		{ "y", "byte", false },
		{ "b", "boolean", false },
		{ "n", "int16", false },
		{ "q", "uint16", false },
		{ "i", "int32", false },
		{ "u", "uint32", false },
		{ "x", "int64", false },
		{ "t", "uint64", false },
		{ "d", "double", false },
		{ "s", "string", true },
		{ "o", "object_path", true },
		{ "g", "signature", true }
	};

	static bool is_string_marshalled_enum (TypeSymbol? symbol) {
		if (symbol != null && symbol is Enum) {
			return symbol.get_attribute_bool ("DBus", "use_string_marshalling");
		}
		return false;
	}

	string get_dbus_value (EnumValue value, string default_value) {
		var dbus_value = value.get_attribute_string ("DBus", "value");
		if (dbus_value != null) {
			return dbus_value;;
		}
		return default_value;
	}

	public static string? get_dbus_signature (Symbol symbol) {
		return symbol.get_attribute_string ("DBus", "signature");
	}

	bool get_basic_type_info (string signature, out BasicTypeInfo basic_type) {
		foreach (BasicTypeInfo info in basic_types) {
			if (info.signature == signature) {
				basic_type = info;
				return true;
			}
		}
		basic_type = BasicTypeInfo ();
		return false;
	}

	public static string? get_type_signature (DataType datatype, Symbol? symbol = null) {
		if (symbol != null) {
			string sig = get_dbus_signature (symbol);
			if (sig != null) {
				// allow overriding signature in attribute, used for raw GVariants
				return sig;
			}
		}

		var array_type = datatype as ArrayType;

		if (array_type != null) {
			string element_type_signature = get_type_signature (array_type.element_type);

			if (element_type_signature == null) {
				return null;
			}

			return string.nfill (array_type.rank, 'a') + element_type_signature;
		} else if (is_string_marshalled_enum (datatype.data_type)) {
			return "s";
		} else if (datatype.data_type != null) {
			string sig = datatype.data_type.get_attribute_string ("CCode", "type_signature");

			var st = datatype.data_type as Struct;
			var en = datatype.data_type as Enum;
			if (sig == null && st != null) {
				var str = new StringBuilder ();
				str.append_c ('(');
				foreach (Field f in st.get_fields ()) {
					if (f.binding == MemberBinding.INSTANCE) {
						str.append (get_type_signature (f.variable_type, f));
					}
				}
				str.append_c (')');
				sig = str.str;
			} else if (sig == null && en != null) {
				if (en.is_flags) {
					return "u";
				} else {
					return "i";
				}
			}

			var type_args = datatype.get_type_arguments ();
			if (sig != null && "%s" in sig && type_args.size > 0) {
				string element_sig = "";
				foreach (DataType type_arg in type_args) {
					var s = get_type_signature (type_arg);
					if (s != null) {
						element_sig += s;
					}
				}

				sig = sig.printf (element_sig);
			}

			if (sig == null &&
			    (datatype.data_type.get_full_name () == "GLib.UnixInputStream" ||
			     datatype.data_type.get_full_name () == "GLib.UnixOutputStream" ||
			     datatype.data_type.get_full_name () == "GLib.Socket")) {
				return "h";
			}

			return sig;
		} else {
			return null;
		}
	}

	public override void visit_enum (Enum en) {
		base.visit_enum (en);

		if (is_string_marshalled_enum (en)) {
			// strcmp
			cfile.add_include ("string.h");

			cfile.add_function (generate_enum_from_string_function (en));
			cfile.add_function (generate_enum_to_string_function (en));
		}
	}

	public override bool generate_enum_declaration (Enum en, CCodeFile decl_space) {
		if (base.generate_enum_declaration (en, decl_space)) {
			if (is_string_marshalled_enum (en)) {
				decl_space.add_function_declaration (generate_enum_from_string_function_declaration (en));
				decl_space.add_function_declaration (generate_enum_to_string_function_declaration (en));
			}
			return true;
		}
		return false;
	}

	CCodeExpression? get_array_length (CCodeExpression expr, int dim) {
		var id = expr as CCodeIdentifier;
		var ma = expr as CCodeMemberAccess;
		if (id != null) {
			return new CCodeIdentifier ("%s_length%d".printf (id.name, dim));
		} else if (ma != null) {
			if (ma.is_pointer) {
				return new CCodeMemberAccess.pointer (ma.inner, "%s_length%d".printf (ma.member_name, dim));
			} else {
				return new CCodeMemberAccess (ma.inner, "%s_length%d".printf (ma.member_name, dim));
			}
		} else {
			// must be NULL-terminated
			var len_call = new CCodeFunctionCall (new CCodeIdentifier ("g_strv_length"));
			len_call.add_argument (expr);
			return len_call;
		}
	}

	CCodeExpression? generate_enum_value_from_string (EnumValueType type, CCodeExpression? expr, CCodeExpression? error_expr) {
		var en = type.type_symbol as Enum;
		var from_string_name = "%s_from_string".printf (get_ccode_lower_case_name (en, null));

		var from_string_call = new CCodeFunctionCall (new CCodeIdentifier (from_string_name));
		from_string_call.add_argument (expr);
		from_string_call.add_argument (error_expr != null ? error_expr : new CCodeConstant ("NULL"));

		return from_string_call;
	}

	public CCodeFunction generate_enum_from_string_function_declaration (Enum en) {
		var from_string_name = "%s_from_string".printf (get_ccode_lower_case_name (en, null));

		var from_string_func = new CCodeFunction (from_string_name, get_ccode_name (en));
		from_string_func.add_parameter (new CCodeParameter ("str", "const char*"));
		from_string_func.add_parameter (new CCodeParameter ("error", "GError**"));

		return from_string_func;
	}

	public CCodeFunction generate_enum_from_string_function (Enum en) {
		var from_string_name = "%s_from_string".printf (get_ccode_lower_case_name (en, null));

		var from_string_func = new CCodeFunction (from_string_name, get_ccode_name (en));
		from_string_func.add_parameter (new CCodeParameter ("str", "const char*"));
		from_string_func.add_parameter (new CCodeParameter ("error", "GError**"));

		push_function (from_string_func);

		ccode.add_declaration (get_ccode_name (en), new CCodeVariableDeclarator.zero ("value", new CCodeConstant ("0")));

		bool firstif = true;
		foreach (EnumValue enum_value in en.get_values ()) {
			string dbus_value = get_dbus_value (enum_value, enum_value.name);
			var string_comparison = new CCodeFunctionCall (new CCodeIdentifier ("strcmp"));
			string_comparison.add_argument (new CCodeIdentifier ("str"));
			string_comparison.add_argument (new CCodeConstant ("\"%s\"".printf (dbus_value)));
			var cond = new CCodeBinaryExpression (CCodeBinaryOperator.EQUALITY, string_comparison, new CCodeConstant ("0"));
			if (firstif) {
				ccode.open_if (cond);
				firstif = false;
			} else {
				ccode.else_if (cond);
			}
			ccode.add_assignment (new CCodeIdentifier ("value"), new CCodeIdentifier (get_ccode_name (enum_value)));
		}

		ccode.add_else ();
		var set_error = new CCodeFunctionCall (new CCodeIdentifier ("g_set_error"));
		set_error.add_argument (new CCodeIdentifier ("error"));
		set_error.add_argument (new CCodeIdentifier ("G_DBUS_ERROR"));
		set_error.add_argument (new CCodeIdentifier ("G_DBUS_ERROR_INVALID_ARGS"));
		set_error.add_argument (new CCodeConstant ("\"Invalid value for enum `%s'\"".printf (get_ccode_name (en))));
		ccode.add_expression (set_error);
		ccode.close ();

		ccode.add_return (new CCodeIdentifier ("value"));

		pop_function ();
		return from_string_func;
	}

	CCodeExpression deserialize_basic (BasicTypeInfo basic_type, CCodeExpression variant_expr, bool transfer = false) {
		var get_call = new CCodeFunctionCall (new CCodeIdentifier ("g_variant_get_" + basic_type.type_name));
		get_call.add_argument (variant_expr);

		if (basic_type.is_string) {
			if (transfer) {
				get_call.call = new CCodeIdentifier ("g_variant_get_string");
			} else {
				get_call.call = new CCodeIdentifier ("g_variant_dup_string");
			}
			get_call.add_argument (new CCodeConstant ("NULL"));
		}

		return get_call;
	}

	CCodeExpression deserialize_array (ArrayType array_type, CCodeExpression variant_expr, CCodeExpression? expr) {
		string temp_name = "_tmp%d_".printf (next_temp_var_id++);

		var new_call = new CCodeFunctionCall (new CCodeIdentifier ("g_new"));
		new_call.add_argument (new CCodeIdentifier (get_ccode_name (array_type.element_type)));
		// add one extra element for NULL-termination
		new_call.add_argument (new CCodeConstant ("5"));

		ccode.add_declaration (get_ccode_name (array_type), new CCodeVariableDeclarator (temp_name, new_call));
		ccode.add_declaration ("int", new CCodeVariableDeclarator (temp_name + "_length", new CCodeConstant ("0")));
		ccode.add_declaration ("int", new CCodeVariableDeclarator (temp_name + "_size", new CCodeConstant ("4")));

		deserialize_array_dim (array_type, 1, temp_name, variant_expr, expr);

		if (array_type.element_type.is_reference_type_or_type_parameter ()) {
			// NULL terminate array
			var length = new CCodeIdentifier (temp_name + "_length");
			var element_access = new CCodeElementAccess (new CCodeIdentifier (temp_name), length);
			ccode.add_assignment (element_access, new CCodeIdentifier ("NULL"));
		}

		return new CCodeIdentifier (temp_name);
	}

	void deserialize_array_dim (ArrayType array_type, int dim, string temp_name, CCodeExpression variant_expr, CCodeExpression? expr) {
		string subiter_name = "_tmp%d_".printf (next_temp_var_id++);
		string element_name = "_tmp%d_".printf (next_temp_var_id++);

		ccode.add_declaration ("int", new CCodeVariableDeclarator ("%s_length%d".printf (temp_name, dim), new CCodeConstant ("0")));
		ccode.add_declaration ("GVariantIter", new CCodeVariableDeclarator (subiter_name));
		ccode.add_declaration ("GVariant*", new CCodeVariableDeclarator (element_name));

		var iter_call = new CCodeFunctionCall (new CCodeIdentifier ("g_variant_iter_init"));
		iter_call.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, new CCodeIdentifier (subiter_name)));
		iter_call.add_argument (variant_expr);
		ccode.add_expression (iter_call);

		iter_call = new CCodeFunctionCall (new CCodeIdentifier ("g_variant_iter_next_value"));
		iter_call.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, new CCodeIdentifier (subiter_name)));

		var cforcond = new CCodeBinaryExpression (CCodeBinaryOperator.INEQUALITY, new CCodeAssignment (new CCodeIdentifier (element_name), iter_call), new CCodeConstant ("NULL"));
		var cforiter = new CCodeUnaryExpression (CCodeUnaryOperator.POSTFIX_INCREMENT, new CCodeIdentifier ("%s_length%d".printf (temp_name, dim)));
		ccode.open_for (null, cforcond, cforiter);

		if (dim < array_type.rank) {
			deserialize_array_dim (array_type, dim + 1, temp_name, new CCodeIdentifier (element_name), expr);
		} else {
			var size_check = new CCodeBinaryExpression (CCodeBinaryOperator.EQUALITY, new CCodeIdentifier (temp_name + "_size"), new CCodeIdentifier (temp_name + "_length"));

			ccode.open_if (size_check);

			// tmp_size = (2 * tmp_size);
			var new_size = new CCodeBinaryExpression (CCodeBinaryOperator.MUL, new CCodeConstant ("2"), new CCodeIdentifier (temp_name + "_size"));
			ccode.add_assignment (new CCodeIdentifier (temp_name + "_size"), new_size);

			var renew_call = new CCodeFunctionCall (new CCodeIdentifier ("g_renew"));
			renew_call.add_argument (new CCodeIdentifier (get_ccode_name (array_type.element_type)));
			renew_call.add_argument (new CCodeIdentifier (temp_name));
			// add one extra element for NULL-termination
			renew_call.add_argument (new CCodeBinaryExpression (CCodeBinaryOperator.PLUS, new CCodeIdentifier (temp_name + "_size"), new CCodeConstant ("1")));
			ccode.add_assignment (new CCodeIdentifier (temp_name), renew_call);

			ccode.close ();

			var element_access = new CCodeElementAccess (new CCodeIdentifier (temp_name), new CCodeUnaryExpression (CCodeUnaryOperator.POSTFIX_INCREMENT, new CCodeIdentifier (temp_name + "_length")));
			var element_expr = deserialize_expression (array_type.element_type, new CCodeIdentifier (element_name), null);
			ccode.add_assignment (element_access, element_expr);
		}

		var unref = new CCodeFunctionCall (new CCodeIdentifier ("g_variant_unref"));
		unref.add_argument (new CCodeIdentifier (element_name));
		ccode.add_expression (unref);

		ccode.close ();

		if (expr != null) {
			ccode.add_assignment (get_array_length (expr, dim), new CCodeIdentifier ("%s_length%d".printf (temp_name, dim)));
		}
	}

	CCodeExpression? deserialize_struct (Struct st, CCodeExpression variant_expr) {
		string temp_name = "_tmp%d_".printf (next_temp_var_id++);
		string subiter_name = "_tmp%d_".printf (next_temp_var_id++);

		ccode.add_declaration (get_ccode_name (st), new CCodeVariableDeclarator (temp_name));
		ccode.add_declaration ("GVariantIter", new CCodeVariableDeclarator (subiter_name));

		var iter_call = new CCodeFunctionCall (new CCodeIdentifier ("g_variant_iter_init"));
		iter_call.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, new CCodeIdentifier (subiter_name)));
		iter_call.add_argument (variant_expr);
		ccode.add_expression (iter_call);

		bool field_found = false;;

		foreach (Field f in st.get_fields ()) {
			if (f.binding != MemberBinding.INSTANCE) {
				continue;
			}

			field_found = true;

			read_expression (f.variable_type, new CCodeIdentifier (subiter_name), new CCodeMemberAccess (new CCodeIdentifier (temp_name), get_ccode_name (f)), f);
		}

		if (!field_found) {
			return null;
		}

		return new CCodeIdentifier (temp_name);
	}

	CCodeExpression? deserialize_hash_table (ObjectType type, CCodeExpression variant_expr) {
		string temp_name = "_tmp%d_".printf (next_temp_var_id++);
		string subiter_name = "_tmp%d_".printf (next_temp_var_id++);
		string key_name = "_tmp%d_".printf (next_temp_var_id++);
		string value_name = "_tmp%d_".printf (next_temp_var_id++);

		var type_args = type.get_type_arguments ();
		assert (type_args.size == 2);
		var key_type = type_args.get (0);
		var value_type = type_args.get (1);

		ccode.add_declaration ("GHashTable*", new CCodeVariableDeclarator (temp_name));
		ccode.add_declaration ("GVariantIter", new CCodeVariableDeclarator (subiter_name));
		ccode.add_declaration ("GVariant*", new CCodeVariableDeclarator (key_name));
		ccode.add_declaration ("GVariant*", new CCodeVariableDeclarator (value_name));

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
		ccode.add_assignment (new CCodeIdentifier (temp_name), hash_table_new);

		var iter_call = new CCodeFunctionCall (new CCodeIdentifier ("g_variant_iter_init"));
		iter_call.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, new CCodeIdentifier (subiter_name)));
		iter_call.add_argument (variant_expr);
		ccode.add_expression (iter_call);

		iter_call = new CCodeFunctionCall (new CCodeIdentifier ("g_variant_iter_loop"));
		iter_call.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, new CCodeIdentifier (subiter_name)));
		iter_call.add_argument (new CCodeConstant ("\"{?*}\""));
		iter_call.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, new CCodeIdentifier (key_name)));
		iter_call.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, new CCodeIdentifier (value_name)));

		ccode.open_while (iter_call);

		var key_expr = deserialize_expression (key_type, new CCodeIdentifier (key_name), null);
		var value_expr = deserialize_expression (value_type, new CCodeIdentifier (value_name), null);
		if (key_expr == null || value_expr == null) {
			return null;
		}

		var hash_table_insert = new CCodeFunctionCall (new CCodeIdentifier ("g_hash_table_insert"));
		hash_table_insert.add_argument (new CCodeIdentifier (temp_name));
		hash_table_insert.add_argument (convert_to_generic_pointer (key_expr, key_type));
		hash_table_insert.add_argument (convert_to_generic_pointer (value_expr, value_type));
		ccode.add_expression (hash_table_insert);

		ccode.close ();

		return new CCodeIdentifier (temp_name);
	}

	public override CCodeExpression? deserialize_expression (DataType type, CCodeExpression variant_expr, CCodeExpression? expr, CCodeExpression? error_expr = null, out bool may_fail = null) {
		BasicTypeInfo basic_type;
		CCodeExpression result = null;
		may_fail = false;
		if (is_string_marshalled_enum (type.data_type)) {
			get_basic_type_info ("s", out basic_type);
			result = deserialize_basic (basic_type, variant_expr, true);
			result = generate_enum_value_from_string (type as EnumValueType, result, error_expr);
			may_fail = true;
		} else if (get_basic_type_info (get_type_signature (type), out basic_type)) {
			result = deserialize_basic (basic_type, variant_expr);
		} else if (type is ArrayType) {
			result = deserialize_array ((ArrayType) type, variant_expr, expr);
		} else if (type.data_type is Struct) {
			var st = (Struct) type.data_type;
			result = deserialize_struct (st, variant_expr);
			if (result != null && type.nullable) {
				var csizeof = new CCodeFunctionCall (new CCodeIdentifier ("sizeof"));
				csizeof.add_argument (new CCodeIdentifier (get_ccode_name (st)));
				var cdup = new CCodeFunctionCall (new CCodeIdentifier ("g_memdup"));
				cdup.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, result));
				cdup.add_argument (csizeof);
				result = cdup;
			}
		} else if (type is ObjectType) {
			if (type.data_type.get_full_name () == "GLib.Variant") {
				var variant_get = new CCodeFunctionCall (new CCodeIdentifier ("g_variant_get_variant"));
				variant_get.add_argument (variant_expr);
				result = variant_get;
			} else if (type.data_type.get_full_name () == "GLib.HashTable") {
				result = deserialize_hash_table ((ObjectType) type, variant_expr);
			}
		}

		if (result == null) {
			Report.error (type.source_reference, "GVariant deserialization of type `%s' is not supported".printf (type.to_string ()));
		}

		return result;
	}

	public void read_expression (DataType type, CCodeExpression iter_expr, CCodeExpression target_expr, Symbol? sym, CCodeExpression? error_expr = null, out bool may_fail = null) {
		var iter_call = new CCodeFunctionCall (new CCodeIdentifier ("g_variant_iter_next_value"));
		iter_call.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, iter_expr));

		if (sym != null && get_dbus_signature (sym) != null) {
			// raw GVariant
			ccode.add_assignment (target_expr, iter_call);
			may_fail = false;
			return;
		}

		string temp_name = "_tmp%d_".printf (next_temp_var_id++);

		ccode.add_declaration ("GVariant*", new CCodeVariableDeclarator (temp_name));

		var variant_expr = new CCodeIdentifier (temp_name);

		ccode.add_assignment (variant_expr, iter_call);

		var result = deserialize_expression (type, variant_expr, target_expr, error_expr, out may_fail);
		if (result == null) {
			// error already reported
			return;
		}

		ccode.add_assignment (target_expr, result);

		var unref = new CCodeFunctionCall (new CCodeIdentifier ("g_variant_unref"));
		unref.add_argument (variant_expr);
		ccode.add_expression (unref);
	}

	CCodeExpression? generate_enum_value_to_string (EnumValueType type, CCodeExpression? expr) {
		var en = type.type_symbol as Enum;
		var to_string_name = "%s_to_string".printf (get_ccode_lower_case_name (en, null));

		var to_string_call = new CCodeFunctionCall (new CCodeIdentifier (to_string_name));
		to_string_call.add_argument (expr);

		return to_string_call;
	}

	public CCodeFunction generate_enum_to_string_function_declaration (Enum en) {
		var to_string_name = "%s_to_string".printf (get_ccode_lower_case_name (en, null));

		var to_string_func = new CCodeFunction (to_string_name, "const char*");
		to_string_func.add_parameter (new CCodeParameter ("value", get_ccode_name (en)));

		return to_string_func;
	}

	public CCodeFunction generate_enum_to_string_function (Enum en) {
		var to_string_name = "%s_to_string".printf (get_ccode_lower_case_name (en, null));

		var to_string_func = new CCodeFunction (to_string_name, "const char*");
		to_string_func.add_parameter (new CCodeParameter ("value", get_ccode_name (en)));

		push_function (to_string_func);

		ccode.add_declaration ("const char *", new CCodeVariableDeclarator ("str"));

		ccode.open_switch (new CCodeIdentifier ("value"));
		foreach (EnumValue enum_value in en.get_values ()) {
			string dbus_value = get_dbus_value (enum_value, enum_value.name);
			ccode.add_case (new CCodeIdentifier (get_ccode_name (enum_value)));
			ccode.add_assignment (new CCodeIdentifier ("str"), new CCodeConstant ("\"%s\"".printf (dbus_value)));
			ccode.add_break ();
		}

		ccode.close();

		ccode.add_return (new CCodeIdentifier ("str"));

		pop_function ();
		return to_string_func;
	}

	CCodeExpression? serialize_basic (BasicTypeInfo basic_type, CCodeExpression expr) {
		var new_call = new CCodeFunctionCall (new CCodeIdentifier ("g_variant_new_" + basic_type.type_name));
		new_call.add_argument (expr);
		return new_call;
	}

	CCodeExpression? serialize_array (ArrayType array_type, CCodeExpression array_expr) {
		string array_iter_name = "_tmp%d_".printf (next_temp_var_id++);

		ccode.add_declaration (get_ccode_name (array_type), new CCodeVariableDeclarator (array_iter_name));
		ccode.add_assignment (new CCodeIdentifier (array_iter_name), array_expr);

		return serialize_array_dim (array_type, 1, array_expr, new CCodeIdentifier (array_iter_name));
	}

	CCodeExpression? serialize_array_dim (ArrayType array_type, int dim, CCodeExpression array_expr, CCodeExpression array_iter_expr) {
		string builder_name = "_tmp%d_".printf (next_temp_var_id++);
		string index_name = "_tmp%d_".printf (next_temp_var_id++);

		ccode.add_declaration ("GVariantBuilder", new CCodeVariableDeclarator (builder_name));
		ccode.add_declaration ("int", new CCodeVariableDeclarator (index_name));

		var gvariant_type = new CCodeFunctionCall (new CCodeIdentifier ("G_VARIANT_TYPE"));
		gvariant_type.add_argument (new CCodeConstant ("\"%s\"".printf (get_type_signature (array_type))));

		var builder_init = new CCodeFunctionCall (new CCodeIdentifier ("g_variant_builder_init"));
		builder_init.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, new CCodeIdentifier (builder_name)));
		builder_init.add_argument (gvariant_type);
		ccode.add_expression (builder_init);

		var cforinit = new CCodeAssignment (new CCodeIdentifier (index_name), new CCodeConstant ("0"));
		var cforcond = new CCodeBinaryExpression (CCodeBinaryOperator.LESS_THAN, new CCodeIdentifier (index_name), get_array_length (array_expr, dim));
		var cforiter = new CCodeUnaryExpression (CCodeUnaryOperator.POSTFIX_INCREMENT, new CCodeIdentifier (index_name));
		ccode.open_for (cforinit, cforcond, cforiter);

		CCodeExpression element_variant;
		if (dim < array_type.rank) {
			element_variant = serialize_array_dim (array_type, dim + 1, array_expr, array_iter_expr);
		} else {
			var element_expr = new CCodeUnaryExpression (CCodeUnaryOperator.POINTER_INDIRECTION, array_iter_expr);
			element_variant = serialize_expression (array_type.element_type, element_expr);
		}

		var builder_add = new CCodeFunctionCall (new CCodeIdentifier ("g_variant_builder_add_value"));
		builder_add.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, new CCodeIdentifier (builder_name)));
		builder_add.add_argument (element_variant);
		ccode.add_expression (builder_add);

		if (dim == array_type.rank) {
			var array_iter_incr = new CCodeUnaryExpression (CCodeUnaryOperator.POSTFIX_INCREMENT, array_iter_expr);
			ccode.add_expression (array_iter_incr);
		}

		ccode.close ();

		var builder_end = new CCodeFunctionCall (new CCodeIdentifier ("g_variant_builder_end"));
		builder_end.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, new CCodeIdentifier (builder_name)));
		return builder_end;
	}

	CCodeExpression? serialize_struct (Struct st, CCodeExpression struct_expr) {
		string builder_name = "_tmp%d_".printf (next_temp_var_id++);

		ccode.add_declaration ("GVariantBuilder", new CCodeVariableDeclarator (builder_name));

		var iter_call = new CCodeFunctionCall (new CCodeIdentifier ("g_variant_builder_init"));
		iter_call.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, new CCodeIdentifier (builder_name)));
		iter_call.add_argument (new CCodeIdentifier ("G_VARIANT_TYPE_TUPLE"));
		ccode.add_expression (iter_call);

		bool field_found = false;;

		foreach (Field f in st.get_fields ()) {
			if (f.binding != MemberBinding.INSTANCE) {
				continue;
			}

			field_found = true;

			write_expression (f.variable_type, new CCodeIdentifier (builder_name), new CCodeMemberAccess (struct_expr, get_ccode_name (f)), f);
		}

		if (!field_found) {
			return null;
		}

		var builder_end = new CCodeFunctionCall (new CCodeIdentifier ("g_variant_builder_end"));
		builder_end.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, new CCodeIdentifier (builder_name)));
		return builder_end;
	}

	CCodeExpression? serialize_hash_table (ObjectType type, CCodeExpression hash_table_expr) {
		string subiter_name = "_tmp%d_".printf (next_temp_var_id++);
		string tableiter_name = "_tmp%d_".printf (next_temp_var_id++);
		string key_name = "_tmp%d_".printf (next_temp_var_id++);
		string value_name = "_tmp%d_".printf (next_temp_var_id++);

		var type_args = type.get_type_arguments ();
		assert (type_args.size == 2);
		var key_type = type_args.get (0);
		var value_type = type_args.get (1);

		ccode.add_declaration ("GVariantBuilder", new CCodeVariableDeclarator (subiter_name));
		ccode.add_declaration ("GHashTableIter", new CCodeVariableDeclarator (tableiter_name));
		ccode.add_declaration ("gpointer", new CCodeVariableDeclarator (key_name));
		ccode.add_declaration ("gpointer", new CCodeVariableDeclarator (value_name));

		var iter_init_call = new CCodeFunctionCall (new CCodeIdentifier ("g_hash_table_iter_init"));
		iter_init_call.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, new CCodeIdentifier (tableiter_name)));
		iter_init_call.add_argument (hash_table_expr);
		ccode.add_expression (iter_init_call);

		var gvariant_type = new CCodeFunctionCall (new CCodeIdentifier ("G_VARIANT_TYPE"));
		gvariant_type.add_argument (new CCodeConstant ("\"%s\"".printf (get_type_signature (type))));

		var iter_call = new CCodeFunctionCall (new CCodeIdentifier ("g_variant_builder_init"));
		iter_call.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, new CCodeIdentifier (subiter_name)));
		iter_call.add_argument (gvariant_type);
		ccode.add_expression (iter_call);

		var iter_next_call = new CCodeFunctionCall (new CCodeIdentifier ("g_hash_table_iter_next"));
		iter_next_call.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, new CCodeIdentifier (tableiter_name)));
		iter_next_call.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, new CCodeIdentifier (key_name)));
		iter_next_call.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, new CCodeIdentifier (value_name)));

		ccode.open_while (iter_next_call);

		ccode.add_declaration (get_ccode_name (key_type), new CCodeVariableDeclarator ("_key"));
		ccode.add_declaration (get_ccode_name (value_type), new CCodeVariableDeclarator ("_value"));

		ccode.add_assignment (new CCodeIdentifier ("_key"), convert_from_generic_pointer (new CCodeIdentifier (key_name), key_type));
		ccode.add_assignment (new CCodeIdentifier ("_value"), convert_from_generic_pointer (new CCodeIdentifier (value_name), value_type));

		var serialized_key =  serialize_expression (key_type, new CCodeIdentifier ("_key"));
		var serialized_value = serialize_expression (value_type, new CCodeIdentifier ("_value"));
		if (serialized_key == null || serialized_value == null) {
			return null;
		}

		iter_call = new CCodeFunctionCall (new CCodeIdentifier ("g_variant_builder_add"));
		iter_call.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, new CCodeIdentifier (subiter_name)));
		iter_call.add_argument (new CCodeConstant ("\"{?*}\""));
		iter_call.add_argument (serialized_key);
		iter_call.add_argument (serialized_value);
		ccode.add_expression (iter_call);

		ccode.close ();

		iter_call = new CCodeFunctionCall (new CCodeIdentifier ("g_variant_builder_end"));
		iter_call.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, new CCodeIdentifier (subiter_name)));
		return iter_call;
	}

	public override CCodeExpression? serialize_expression (DataType type, CCodeExpression expr) {
		BasicTypeInfo basic_type;
		CCodeExpression result = null;
		if (is_string_marshalled_enum (type.data_type)) {
			get_basic_type_info ("s", out basic_type);
			result = generate_enum_value_to_string (type as EnumValueType, expr);
			result = serialize_basic (basic_type, result);
		} else if (get_basic_type_info (get_type_signature (type), out basic_type)) {
			result = serialize_basic (basic_type, expr);
		} else if (type is ArrayType) {
			result = serialize_array ((ArrayType) type, expr);
		} else if (type.data_type is Struct) {
			var st_expr = expr;
			if (type.nullable) {
				st_expr = new CCodeUnaryExpression (CCodeUnaryOperator.POINTER_INDIRECTION, st_expr);
			}
			result = serialize_struct ((Struct) type.data_type, st_expr);
		} else if (type is ObjectType) {
			if (type.data_type.get_full_name () == "GLib.Variant") {
				var variant_new = new CCodeFunctionCall (new CCodeIdentifier ("g_variant_new_variant"));
				variant_new.add_argument (expr);
				result = variant_new;
			} else if (type.data_type.get_full_name () == "GLib.HashTable") {
				result = serialize_hash_table ((ObjectType) type, expr);
			}
		}

		if (result == null) {
			Report.error (type.source_reference, "GVariant serialization of type `%s' is not supported".printf (type.to_string ()));
		}

		return result;
	}

	public void write_expression (DataType type, CCodeExpression builder_expr, CCodeExpression expr, Symbol? sym) {
		var variant_expr = expr;
		if (sym == null || get_dbus_signature (sym) == null) {
			// perform boxing
			variant_expr = serialize_expression (type, expr);
		}
		if (variant_expr != null) {
			var builder_add = new CCodeFunctionCall (new CCodeIdentifier ("g_variant_builder_add_value"));
			builder_add.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, builder_expr));
			builder_add.add_argument (variant_expr);
			ccode.add_expression (builder_add);
		}
	}
}
