/* valagvariantmodule.vala
 *
 * Copyright (C) 2010  Jürg Billeter
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

	public GVariantModule (CCodeGenerator codegen, CCodeModule? next) {
		base (codegen, next);
	}

	static bool is_string_marshalled_enum (TypeSymbol? symbol) {
		if (symbol != null && symbol is Enum) {
			var dbus = symbol.get_attribute ("DBus");
			return dbus != null && dbus.get_bool ("use_string_marshalling");
		}
		return false;
	}

	string get_dbus_value (EnumValue value, string default_value) {
		var dbus = value.get_attribute ("DBus");
		if (dbus == null) {
			return default_value;
		}

		string dbus_value = dbus.get_string ("value");
		if (dbus_value == null) {
			return default_value;
		}
		return dbus_value;
	}

	public static string? get_dbus_signature (Symbol symbol) {
		var dbus = symbol.get_attribute ("DBus");
		if (dbus == null) {
			return null;
		}

		return dbus.get_string ("signature");
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
			string sig = null;

			var ccode = datatype.data_type.get_attribute ("CCode");
			if (ccode != null) {
				sig = ccode.get_string ("type_signature");
			}

			var st = datatype.data_type as Struct;
			var en = datatype.data_type as Enum;
			if (sig == null && st != null) {
				var str = new StringBuilder ();
				str.append_c ('(');
				foreach (Field f in st.get_fields ()) {
					if (f.binding == MemberBinding.INSTANCE) {
						str.append (get_type_signature (f.variable_type));
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
			if (sig != null && sig.str ("%s") != null && type_args.size > 0) {
				string element_sig = "";
				foreach (DataType type_arg in type_args) {
					var s = get_type_signature (type_arg);
					if (s != null) {
						element_sig += s;
					}
				}

				sig = sig.printf (element_sig);
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
			source_declarations.add_include ("string.h");

			source_type_member_definition.append (generate_enum_from_string_function (en));
			source_type_member_definition.append (generate_enum_to_string_function (en));
		}
	}

	public override bool generate_enum_declaration (Enum en, CCodeDeclarationSpace decl_space) {
		if (base.generate_enum_declaration (en, decl_space)) {
			if (is_string_marshalled_enum (en)) {
				decl_space.add_type_member_declaration (generate_enum_from_string_function_declaration (en));
				decl_space.add_type_member_declaration (generate_enum_to_string_function_declaration (en));
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

	CCodeExpression? generate_enum_value_from_string (CCodeFragment fragment, EnumValueType type, CCodeExpression? expr) {
		var en = type.type_symbol as Enum;
		var from_string_name = "%s_from_string".printf (en.get_lower_case_cname (null));

		var from_string_call = new CCodeFunctionCall (new CCodeIdentifier (from_string_name));
		from_string_call.add_argument (expr);

		return from_string_call;
	}

	public CCodeFunction generate_enum_from_string_function_declaration (Enum en) {
		var from_string_name = "%s_from_string".printf (en.get_lower_case_cname (null));

		var from_string_func = new CCodeFunction (from_string_name, en.get_cname ());
		from_string_func.add_parameter (new CCodeFormalParameter ("str", "const char*"));

		return from_string_func;
	}

	public CCodeFunction generate_enum_from_string_function (Enum en) {
		var from_string_name = "%s_from_string".printf (en.get_lower_case_cname (null));

		var from_string_func = new CCodeFunction (from_string_name, en.get_cname ());
		from_string_func.add_parameter (new CCodeFormalParameter ("str", "const char*"));

		var from_string_block = new CCodeBlock ();
		from_string_func.block = from_string_block;

		var cdecl = new CCodeDeclaration (en.get_cname ());
		cdecl.add_declarator (new CCodeVariableDeclarator ("value"));
		from_string_block.add_statement (cdecl);

		CCodeStatement if_else_if = null;
		CCodeIfStatement last_statement = null;
		foreach (EnumValue enum_value in en.get_values ()) {
			var true_block = new CCodeBlock ();
			true_block.suppress_newline = true;
			true_block.add_statement (new CCodeExpressionStatement (new CCodeAssignment (new CCodeIdentifier ("value"), new CCodeIdentifier (enum_value.get_cname ()))));

			string dbus_value = get_dbus_value (enum_value, enum_value.name);
			var string_comparison = new CCodeFunctionCall (new CCodeIdentifier ("strcmp"));
			string_comparison.add_argument (new CCodeIdentifier ("str"));
			string_comparison.add_argument (new CCodeConstant ("\"%s\"".printf (dbus_value)));
			var stmt = new CCodeIfStatement (new CCodeBinaryExpression (CCodeBinaryOperator.EQUALITY, string_comparison, new CCodeConstant ("0")), true_block);

			if (last_statement != null) {
				last_statement.false_statement = stmt;
			} else {
				if_else_if = stmt;
			}
			last_statement = stmt;
		}

		from_string_block.add_statement (if_else_if);

		from_string_block.add_statement (new CCodeReturnStatement (new CCodeIdentifier ("value")));

		return from_string_func;
	}

	CCodeExpression deserialize_basic (CCodeFragment fragment, BasicTypeInfo basic_type, CCodeExpression variant_expr, bool transfer = false) {
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

	CCodeExpression deserialize_array (CCodeFragment fragment, ArrayType array_type, CCodeExpression variant_expr, CCodeExpression? expr) {
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

		deserialize_array_dim (fragment, array_type, 1, temp_name, variant_expr, expr);

		if (array_type.element_type.is_reference_type_or_type_parameter ()) {
			// NULL terminate array
			var length = new CCodeIdentifier (temp_name + "_length");
			var element_access = new CCodeElementAccess (new CCodeIdentifier (temp_name), length);
			fragment.append (new CCodeExpressionStatement (new CCodeAssignment (element_access, new CCodeIdentifier ("NULL"))));
		}

		return new CCodeIdentifier (temp_name);
	}

	void deserialize_array_dim (CCodeFragment fragment, ArrayType array_type, int dim, string temp_name, CCodeExpression variant_expr, CCodeExpression? expr) {
		string subiter_name = "_tmp%d_".printf (next_temp_var_id++);
		string element_name = "_tmp%d_".printf (next_temp_var_id++);

		var cdecl = new CCodeDeclaration ("int");
		cdecl.add_declarator (new CCodeVariableDeclarator ("%s_length%d".printf (temp_name, dim), new CCodeConstant ("0")));
		fragment.append (cdecl);

		cdecl = new CCodeDeclaration ("GVariantIter");
		cdecl.add_declarator (new CCodeVariableDeclarator (subiter_name));
		fragment.append (cdecl);

		cdecl = new CCodeDeclaration ("GVariant*");
		cdecl.add_declarator (new CCodeVariableDeclarator (element_name));
		fragment.append (cdecl);

		var iter_call = new CCodeFunctionCall (new CCodeIdentifier ("g_variant_iter_init"));
		iter_call.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, new CCodeIdentifier (subiter_name)));
		iter_call.add_argument (variant_expr);
		fragment.append (new CCodeExpressionStatement (iter_call));

		iter_call = new CCodeFunctionCall (new CCodeIdentifier ("g_variant_iter_next_value"));
		iter_call.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, new CCodeIdentifier (subiter_name)));

		var cforblock = new CCodeBlock ();
		var cforfragment = new CCodeFragment ();
		cforblock.add_statement (cforfragment);
		var cfor = new CCodeForStatement (new CCodeAssignment (new CCodeIdentifier (element_name), iter_call), cforblock);
		cfor.add_iterator (new CCodeUnaryExpression (CCodeUnaryOperator.POSTFIX_INCREMENT, new CCodeIdentifier ("%s_length%d".printf (temp_name, dim))));

		if (dim < array_type.rank) {
			deserialize_array_dim (cforfragment, array_type, dim + 1, temp_name, new CCodeIdentifier (element_name), expr);
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
			var element_expr = deserialize_expression (cforfragment, array_type.element_type, new CCodeIdentifier (element_name), null);
			cforfragment.append (new CCodeExpressionStatement (new CCodeAssignment (element_access, element_expr)));
		}

		var unref = new CCodeFunctionCall (new CCodeIdentifier ("g_variant_unref"));
		unref.add_argument (new CCodeIdentifier (element_name));
		cforfragment.append (new CCodeExpressionStatement (unref));

		fragment.append (cfor);

		if (expr != null) {
			fragment.append (new CCodeExpressionStatement (new CCodeAssignment (get_array_length (expr, dim), new CCodeIdentifier ("%s_length%d".printf (temp_name, dim)))));
		}
	}

	CCodeExpression? deserialize_struct (CCodeFragment fragment, Struct st, CCodeExpression variant_expr) {
		string temp_name = "_tmp%d_".printf (next_temp_var_id++);
		string subiter_name = "_tmp%d_".printf (next_temp_var_id++);

		var cdecl = new CCodeDeclaration (st.get_cname ());
		cdecl.add_declarator (new CCodeVariableDeclarator (temp_name));
		fragment.append (cdecl);

		cdecl = new CCodeDeclaration ("GVariantIter");
		cdecl.add_declarator (new CCodeVariableDeclarator (subiter_name));
		fragment.append (cdecl);

		var iter_call = new CCodeFunctionCall (new CCodeIdentifier ("g_variant_iter_init"));
		iter_call.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, new CCodeIdentifier (subiter_name)));
		iter_call.add_argument (variant_expr);
		fragment.append (new CCodeExpressionStatement (iter_call));

		bool field_found = false;;

		foreach (Field f in st.get_fields ()) {
			if (f.binding != MemberBinding.INSTANCE) {
				continue;
			}

			field_found = true;

			read_expression (fragment, f.variable_type, new CCodeIdentifier (subiter_name), new CCodeMemberAccess (new CCodeIdentifier (temp_name), f.get_cname ()), f);
		}

		if (!field_found) {
			return null;
		}

		return new CCodeIdentifier (temp_name);
	}

	CCodeExpression deserialize_hash_table (CCodeFragment fragment, ObjectType type, CCodeExpression variant_expr) {
		string temp_name = "_tmp%d_".printf (next_temp_var_id++);
		string subiter_name = "_tmp%d_".printf (next_temp_var_id++);
		string key_name = "_tmp%d_".printf (next_temp_var_id++);
		string value_name = "_tmp%d_".printf (next_temp_var_id++);

		var type_args = type.get_type_arguments ();
		assert (type_args.size == 2);
		var key_type = type_args.get (0);
		var value_type = type_args.get (1);

		var cdecl = new CCodeDeclaration ("GHashTable*");
		cdecl.add_declarator (new CCodeVariableDeclarator (temp_name));
		fragment.append (cdecl);

		cdecl = new CCodeDeclaration ("GVariantIter");
		cdecl.add_declarator (new CCodeVariableDeclarator (subiter_name));
		fragment.append (cdecl);

		cdecl = new CCodeDeclaration ("GVariant*");
		cdecl.add_declarator (new CCodeVariableDeclarator (key_name));
		fragment.append (cdecl);

		cdecl = new CCodeDeclaration ("GVariant*");
		cdecl.add_declarator (new CCodeVariableDeclarator (value_name));
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

		var iter_call = new CCodeFunctionCall (new CCodeIdentifier ("g_variant_iter_init"));
		iter_call.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, new CCodeIdentifier (subiter_name)));
		iter_call.add_argument (variant_expr);
		fragment.append (new CCodeExpressionStatement (iter_call));

		iter_call = new CCodeFunctionCall (new CCodeIdentifier ("g_variant_iter_loop"));
		iter_call.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, new CCodeIdentifier (subiter_name)));
		iter_call.add_argument (new CCodeConstant ("\"{?*}\""));
		iter_call.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, new CCodeIdentifier (key_name)));
		iter_call.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, new CCodeIdentifier (value_name)));

		var cwhileblock = new CCodeBlock ();
		var cwhilefragment = new CCodeFragment ();
		cwhileblock.add_statement (cwhilefragment);
		var cwhile = new CCodeWhileStatement (iter_call, cwhileblock);

		var key_expr = deserialize_expression (cwhilefragment, key_type, new CCodeIdentifier (key_name), null);
		var value_expr = deserialize_expression (cwhilefragment, value_type, new CCodeIdentifier (value_name), null);

		var hash_table_insert = new CCodeFunctionCall (new CCodeIdentifier ("g_hash_table_insert"));
		hash_table_insert.add_argument (new CCodeIdentifier (temp_name));
		hash_table_insert.add_argument (convert_to_generic_pointer (key_expr, key_type));
		hash_table_insert.add_argument (convert_to_generic_pointer (value_expr, value_type));
		cwhilefragment.append (new CCodeExpressionStatement (hash_table_insert));

		fragment.append (cwhile);

		return new CCodeIdentifier (temp_name);
	}

	public override CCodeExpression? deserialize_expression (CCodeFragment fragment, DataType type, CCodeExpression variant_expr, CCodeExpression? expr) {
		BasicTypeInfo basic_type;
		CCodeExpression result = null;
		if (is_string_marshalled_enum (type.data_type)) {
			get_basic_type_info ("s", out basic_type);
			result = deserialize_basic (fragment, basic_type, variant_expr, true);
			result = generate_enum_value_from_string (fragment, type as EnumValueType, result);
		} else if (get_basic_type_info (get_type_signature (type), out basic_type)) {
			result = deserialize_basic (fragment, basic_type, variant_expr);
		} else if (type is ArrayType) {
			result = deserialize_array (fragment, (ArrayType) type, variant_expr, expr);
		} else if (type.data_type is Struct) {
			var st = (Struct) type.data_type;
			result = deserialize_struct (fragment, st, variant_expr);
			if (result != null && type.nullable) {
				var csizeof = new CCodeFunctionCall (new CCodeIdentifier ("sizeof"));
				csizeof.add_argument (new CCodeIdentifier (st.get_cname ()));
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
				result = deserialize_hash_table (fragment, (ObjectType) type, variant_expr);
			}
		}

		if (result == null) {
			Report.error (type.source_reference, "GVariant deserialization of type `%s' is not supported".printf (type.to_string ()));
		}

		return result;
	}

	public void read_expression (CCodeFragment fragment, DataType type, CCodeExpression iter_expr, CCodeExpression target_expr, Symbol? sym) {
		var iter_call = new CCodeFunctionCall (new CCodeIdentifier ("g_variant_iter_next_value"));
		iter_call.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, iter_expr));

		if (sym != null && get_dbus_signature (sym) != null) {
			// raw GVariant
			fragment.append (new CCodeExpressionStatement (new CCodeAssignment (target_expr, iter_call)));
			return;
		}

		string temp_name = "_tmp%d_".printf (next_temp_var_id++);

		var cdecl = new CCodeDeclaration ("GVariant*");
		cdecl.add_declarator (new CCodeVariableDeclarator (temp_name));
		fragment.append (cdecl);

		var variant_expr = new CCodeIdentifier (temp_name);

		fragment.append (new CCodeExpressionStatement (new CCodeAssignment (variant_expr, iter_call)));

		var result = deserialize_expression (fragment, type, variant_expr, target_expr);
		fragment.append (new CCodeExpressionStatement (new CCodeAssignment (target_expr, result)));

		var unref = new CCodeFunctionCall (new CCodeIdentifier ("g_variant_unref"));
		unref.add_argument (variant_expr);
		fragment.append (new CCodeExpressionStatement (unref));
	}

	CCodeExpression? generate_enum_value_to_string (CCodeFragment fragment, EnumValueType type, CCodeExpression? expr) {
		var en = type.type_symbol as Enum;
		var to_string_name = "%s_to_string".printf (en.get_lower_case_cname (null));

		var to_string_call = new CCodeFunctionCall (new CCodeIdentifier (to_string_name));
		to_string_call.add_argument (expr);

		return to_string_call;
	}

	public CCodeFunction generate_enum_to_string_function_declaration (Enum en) {
		var to_string_name = "%s_to_string".printf (en.get_lower_case_cname (null));

		var to_string_func = new CCodeFunction (to_string_name, "const char*");
		to_string_func.add_parameter (new CCodeFormalParameter ("value", en.get_cname ()));

		return to_string_func;
	}

	public CCodeFunction generate_enum_to_string_function (Enum en) {
		var to_string_name = "%s_to_string".printf (en.get_lower_case_cname (null));

		var to_string_func = new CCodeFunction (to_string_name, "const char*");
		to_string_func.add_parameter (new CCodeFormalParameter ("value", en.get_cname ()));

		var to_string_block = new CCodeBlock ();
		to_string_func.block = to_string_block;

		var cdecl = new CCodeDeclaration ("const char *");
		cdecl.add_declarator (new CCodeVariableDeclarator ("str"));
		to_string_block.add_statement (cdecl);

		var cswitch = new CCodeSwitchStatement (new CCodeIdentifier ("value"));
		foreach (EnumValue enum_value in en.get_values ()) {
			string dbus_value = get_dbus_value (enum_value, enum_value.name);
			cswitch.add_statement (new CCodeCaseStatement (new CCodeIdentifier (enum_value.get_cname ())));
			cswitch.add_statement (new CCodeExpressionStatement (new CCodeAssignment (new CCodeIdentifier ("str"), new CCodeConstant ("\"%s\"".printf (dbus_value)))));
			cswitch.add_statement (new CCodeBreakStatement ());
		}
		to_string_block.add_statement (cswitch);

		to_string_block.add_statement (new CCodeReturnStatement (new CCodeIdentifier ("str")));

		return to_string_func;
	}

	CCodeExpression? serialize_basic (CCodeFragment fragment, BasicTypeInfo basic_type, CCodeExpression expr) {
		var new_call = new CCodeFunctionCall (new CCodeIdentifier ("g_variant_new_" + basic_type.type_name));
		new_call.add_argument (expr);
		return new_call;
	}

	CCodeExpression? serialize_array (CCodeFragment fragment, ArrayType array_type, CCodeExpression array_expr) {
		string array_iter_name = "_tmp%d_".printf (next_temp_var_id++);

		var cdecl = new CCodeDeclaration (array_type.get_cname ());
		cdecl.add_declarator (new CCodeVariableDeclarator (array_iter_name));
		fragment.append (cdecl);

		fragment.append (new CCodeExpressionStatement (new CCodeAssignment (new CCodeIdentifier (array_iter_name), array_expr)));

		return serialize_array_dim (fragment, array_type, 1, array_expr, new CCodeIdentifier (array_iter_name));
	}

	CCodeExpression? serialize_array_dim (CCodeFragment fragment, ArrayType array_type, int dim, CCodeExpression array_expr, CCodeExpression array_iter_expr) {
		string builder_name = "_tmp%d_".printf (next_temp_var_id++);
		string index_name = "_tmp%d_".printf (next_temp_var_id++);

		var cdecl = new CCodeDeclaration ("GVariantBuilder");
		cdecl.add_declarator (new CCodeVariableDeclarator (builder_name));
		fragment.append (cdecl);

		cdecl = new CCodeDeclaration ("int");
		cdecl.add_declarator (new CCodeVariableDeclarator (index_name));
		fragment.append (cdecl);

		var builder_init = new CCodeFunctionCall (new CCodeIdentifier ("g_variant_builder_init"));
		builder_init.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, new CCodeIdentifier (builder_name)));
		builder_init.add_argument (new CCodeIdentifier ("G_VARIANT_TYPE_ARRAY"));
		fragment.append (new CCodeExpressionStatement (builder_init));

		var cforblock = new CCodeBlock ();
		var cforfragment = new CCodeFragment ();
		cforblock.add_statement (cforfragment);
		var cfor = new CCodeForStatement (new CCodeBinaryExpression (CCodeBinaryOperator.LESS_THAN, new CCodeIdentifier (index_name), get_array_length (array_expr, dim)), cforblock);
		cfor.add_initializer (new CCodeAssignment (new CCodeIdentifier (index_name), new CCodeConstant ("0")));
		cfor.add_iterator (new CCodeUnaryExpression (CCodeUnaryOperator.POSTFIX_INCREMENT, new CCodeIdentifier (index_name)));

		CCodeExpression element_variant;
		if (dim < array_type.rank) {
			element_variant = serialize_array_dim (cforfragment, array_type, dim + 1, array_expr, array_iter_expr);
		} else {
			var element_expr = new CCodeUnaryExpression (CCodeUnaryOperator.POINTER_INDIRECTION, array_iter_expr);
			element_variant = serialize_expression (cforfragment, array_type.element_type, element_expr);
		}

		var builder_add = new CCodeFunctionCall (new CCodeIdentifier ("g_variant_builder_add_value"));
		builder_add.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, new CCodeIdentifier (builder_name)));
		builder_add.add_argument (element_variant);
		cforfragment.append (new CCodeExpressionStatement (builder_add));

		if (dim == array_type.rank) {
			var array_iter_incr = new CCodeUnaryExpression (CCodeUnaryOperator.POSTFIX_INCREMENT, array_iter_expr);
			cforfragment.append (new CCodeExpressionStatement (array_iter_incr));
		}

		fragment.append (cfor);

		var builder_end = new CCodeFunctionCall (new CCodeIdentifier ("g_variant_builder_end"));
		builder_end.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, new CCodeIdentifier (builder_name)));
		return builder_end;
	}

	CCodeExpression? serialize_struct (CCodeFragment fragment, Struct st, CCodeExpression struct_expr) {
		string builder_name = "_tmp%d_".printf (next_temp_var_id++);

		var cdecl = new CCodeDeclaration ("GVariantBuilder");
		cdecl.add_declarator (new CCodeVariableDeclarator (builder_name));
		fragment.append (cdecl);

		var iter_call = new CCodeFunctionCall (new CCodeIdentifier ("g_variant_builder_init"));
		iter_call.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, new CCodeIdentifier (builder_name)));
		iter_call.add_argument (new CCodeIdentifier ("G_VARIANT_TYPE_TUPLE"));
		fragment.append (new CCodeExpressionStatement (iter_call));

		bool field_found = false;;

		foreach (Field f in st.get_fields ()) {
			if (f.binding != MemberBinding.INSTANCE) {
				continue;
			}

			field_found = true;

			write_expression (fragment, f.variable_type, new CCodeIdentifier (builder_name), new CCodeMemberAccess (struct_expr, f.get_cname ()), f);
		}

		if (!field_found) {
			return null;
		}

		var builder_end = new CCodeFunctionCall (new CCodeIdentifier ("g_variant_builder_end"));
		builder_end.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, new CCodeIdentifier (builder_name)));
		return builder_end;
	}

	CCodeExpression serialize_hash_table (CCodeFragment fragment, ObjectType type, CCodeExpression hash_table_expr) {
		string subiter_name = "_tmp%d_".printf (next_temp_var_id++);
		string tableiter_name = "_tmp%d_".printf (next_temp_var_id++);
		string key_name = "_tmp%d_".printf (next_temp_var_id++);
		string value_name = "_tmp%d_".printf (next_temp_var_id++);

		var type_args = type.get_type_arguments ();
		assert (type_args.size == 2);
		var key_type = type_args.get (0);
		var value_type = type_args.get (1);

		var cdecl = new CCodeDeclaration ("GVariantBuilder");
		cdecl.add_declarator (new CCodeVariableDeclarator (subiter_name));
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

		var iter_call = new CCodeFunctionCall (new CCodeIdentifier ("g_variant_builder_init"));
		iter_call.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, new CCodeIdentifier (subiter_name)));
		iter_call.add_argument (new CCodeIdentifier ("G_VARIANT_TYPE_DICTIONARY"));
		fragment.append (new CCodeExpressionStatement (iter_call));

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

		cwhilefragment.append (new CCodeExpressionStatement (new CCodeAssignment (new CCodeIdentifier ("_key"), convert_from_generic_pointer (new CCodeIdentifier (key_name), key_type))));
		cwhilefragment.append (new CCodeExpressionStatement (new CCodeAssignment (new CCodeIdentifier ("_value"), convert_from_generic_pointer (new CCodeIdentifier (value_name), value_type))));

		iter_call = new CCodeFunctionCall (new CCodeIdentifier ("g_variant_builder_add"));
		iter_call.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, new CCodeIdentifier (subiter_name)));
		iter_call.add_argument (new CCodeConstant ("\"{?*}\""));
		iter_call.add_argument (serialize_expression (cwhilefragment, key_type, new CCodeIdentifier ("_key")));
		iter_call.add_argument (serialize_expression (cwhilefragment, value_type, new CCodeIdentifier ("_value")));
		cwhilefragment.append (new CCodeExpressionStatement (iter_call));

		fragment.append (cwhile);

		iter_call = new CCodeFunctionCall (new CCodeIdentifier ("g_variant_builder_end"));
		iter_call.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, new CCodeIdentifier (subiter_name)));
		return iter_call;
	}

	public override CCodeExpression? serialize_expression (CCodeFragment fragment, DataType type, CCodeExpression expr) {
		BasicTypeInfo basic_type;
		CCodeExpression result = null;
		if (is_string_marshalled_enum (type.data_type)) {
			get_basic_type_info ("s", out basic_type);
			result = generate_enum_value_to_string (fragment, type as EnumValueType, expr);
			result = serialize_basic (fragment, basic_type, result);
		} else if (get_basic_type_info (get_type_signature (type), out basic_type)) {
			result = serialize_basic (fragment, basic_type, expr);
		} else if (type is ArrayType) {
			result = serialize_array (fragment, (ArrayType) type, expr);
		} else if (type.data_type is Struct) {
			var st_expr = expr;
			if (type.nullable) {
				st_expr = new CCodeUnaryExpression (CCodeUnaryOperator.POINTER_INDIRECTION, st_expr);
			}
			result = serialize_struct (fragment, (Struct) type.data_type, st_expr);
		} else if (type is ObjectType) {
			if (type.data_type.get_full_name () == "GLib.Variant") {
				var variant_new = new CCodeFunctionCall (new CCodeIdentifier ("g_variant_new_variant"));
				variant_new.add_argument (expr);
				result = variant_new;
			} else if (type.data_type.get_full_name () == "GLib.HashTable") {
				result = serialize_hash_table (fragment, (ObjectType) type, expr);
			}
		}

		if (result == null) {
			Report.error (type.source_reference, "GVariant serialization of type `%s' is not supported".printf (type.to_string ()));
		}

		return result;
	}

	public void write_expression (CCodeFragment fragment, DataType type, CCodeExpression builder_expr, CCodeExpression expr, Symbol? sym) {
		var variant_expr = expr;
		if (sym == null || get_dbus_signature (sym) == null) {
			// perform boxing
			variant_expr = serialize_expression (fragment, type, expr);
		}
		if (variant_expr != null) {
			var builder_add = new CCodeFunctionCall (new CCodeIdentifier ("g_variant_builder_add_value"));
			builder_add.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, builder_expr));
			builder_add.add_argument (variant_expr);
			fragment.append (new CCodeExpressionStatement (builder_add));
		}
	}
}
