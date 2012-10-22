/* valagvarianttransformer.vala
 *
 * Copyright (C) 2011  Luca Bruno
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
 * 	Luca Bruno <lucabru@src.gnome.org>
 */

/**
 * Code visitor for transforming the code tree related to GVariant.
 */
public class Vala.GVariantTransformer : CCodeTransformer {
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

	public bool is_gvariant_type (DataType type) {
		return type.data_type == context.analyzer.gvariant_type.data_type;
	}

	bool get_basic_type_info (string signature, out BasicTypeInfo basic_type) {
		if (signature != null) {
			foreach (BasicTypeInfo info in basic_types) {
				if (info.signature == signature) {
					basic_type = info;
					return true;
				}
			}
		}
		basic_type = BasicTypeInfo ();
		return false;
	}

	Expression serialize_basic (BasicTypeInfo basic_type, Expression expr) {
		var new_call = (ObjectCreationExpression) expression (@"new GLib.Variant.$(basic_type.type_name) ()");
		new_call.add_argument (expr);
		return new_call;
	}

	public static string? get_dbus_signature (Symbol symbol) {
		return symbol.get_attribute_string ("DBus", "signature");
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

	Expression serialize_array (ArrayType array_type, Expression array_expr) {
		Method m;
		if (!wrapper_method (data_type ("GLib.Variant"), "gvariant_serialize_array " + array_type.to_string (), out m)) {
			m.add_parameter (new Parameter ("array", copy_type (array_type, false), b.source_reference));
			push_builder (new CodeBuilder.for_subroutine (m));

			string[] indices = new string[array_type.rank];
			for (int dim = 1; dim <= array_type.rank; dim++) {
				indices[dim - 1] = b.add_temp_declaration (null, new IntegerLiteral ("0"));
			}
			b.add_return (serialize_array_dim (array_type, 1, indices, "array"));

			pop_builder ();
			check (m);
		}
		var call = (MethodCall) expression (m.name + " ()");
		call.add_argument (array_expr);
		return call;
	}

	Expression serialize_array_dim (ArrayType array_type, int dim, string[] indices, string array_var) {
		var builderinit = expression (@"new GLib.VariantBuilder (new GLib.VariantType (\"$(get_type_signature (array_type))\"))");

		var builder = b.add_temp_declaration (null, builderinit);

		Expression length = expression (array_var + ".length");
		if (array_type.rank > 1) {
			ElementAccess ea = new ElementAccess (length, b.source_reference);
			ea.append_index (new IntegerLiteral ((dim - 1).to_string (), b.source_reference));
			length = ea;
		}

		var index = indices[dim - 1];
		var forcond = new BinaryExpression (BinaryOperator.LESS_THAN, expression (index), length, b.source_reference);
		var foriter = new PostfixExpression (expression (index), true, b.source_reference);
		b.open_for (null, forcond, foriter);

		Expression element_variant;
		if (dim < array_type.rank) {
			element_variant = serialize_array_dim (array_type, dim + 1, indices, array_var);
		} else {
			var element_expr = new ElementAccess (expression (array_var), b.source_reference);
			for (int i = 0; i < dim; i++) {
				element_expr.append_index (expression (indices[i]));
			}
			if (is_gvariant_type (array_type.element_type)) {
				var new_variant = (ObjectCreationExpression) expression ("new GLib.Variant.variant ()");
				new_variant.add_argument (element_expr);
				element_variant = new_variant;
			} else {
				element_variant = element_expr;
			}
		}

		var builder_add = (MethodCall) expression (builder + ".add_value ()");
		builder_add.add_argument (element_variant);
		b.add_expression (builder_add);
		b.close ();

		return (MethodCall) expression (builder + ".end ()");
	}

	Expression? serialize_struct (Struct st, Expression expr) {
		bool has_instance_field = false;
		foreach (Field f in st.get_fields ()) {
			if (f.binding == MemberBinding.INSTANCE) {
				has_instance_field = true;
				break;
			}
		}
		if (!has_instance_field) {
			return null;
		}

		Method m;
		var type = SemanticAnalyzer.get_data_type_for_symbol (st);
		if (!wrapper_method (data_type ("GLib.Variant"), "gvariant_serialize_struct " + type.to_string (), out m)) {
			m.add_parameter (new Parameter ("st", type, b.source_reference));
			push_builder (new CodeBuilder.for_subroutine (m));

			var builderinit = expression ("new GLib.VariantBuilder (GLib.VariantType.TUPLE)");
			var builder = b.add_temp_declaration (null, builderinit);

			foreach (Field f in st.get_fields ()) {
				if (f.binding != MemberBinding.INSTANCE) {
					continue;
				}

				var serialized_field = "st." + f.name;
				if (is_gvariant_type (f.variable_type)) {
					serialized_field = @"new GLib.Variant.variant ($serialized_field)";
				}
				b.add_expression (expression (@"$builder.add_value ($serialized_field)"));
			}
			b.add_return (expression (@"$builder.end ()"));

			pop_builder ();
			check (m);
		}

		var call = (MethodCall) expression (m.name + " ()");
		call.add_argument (expr);
		return call;
	}

	Expression? serialize_hash_table (ObjectType type, Expression expr) {
		Method m;
		if (!wrapper_method (data_type ("GLib.Variant"), "gvariant_serialize_hash_table " + type.to_string (), out m)) {
			m.add_parameter (new Parameter ("ht", copy_type (type, false), b.source_reference));
			push_builder (new CodeBuilder.for_subroutine (m));

			var builderinit = expression (@"new GLib.VariantBuilder (new GLib.VariantType (\"$(get_type_signature (type))\"))");
			var builder = b.add_temp_declaration (null, builderinit);

			var type_args = type.get_type_arguments ();
			assert (type_args.size == 2);
			var key_type = type_args.get (0);
			var value_type = type_args.get (1);
			string serialized_key = is_gvariant_type (key_type) ? "new GLib.Variant.variant (k1)" : "k1";
			string serialized_value = is_gvariant_type (value_type) ? "new GLib.Variant.variant (v1)" : "v1";

			var for_each = expression (@"ht.for_each ((k, v) => { GLib.Variant k1 = k; GLib.Variant v1 = v; $builder.add (\"{?*}\", $serialized_key, $serialized_value); })");
			b.add_expression (for_each);
			b.add_return (expression (@"$builder.end ()"));

			pop_builder ();
			check (m);
		}
		var call = (MethodCall) expression (m.name + " ()");
		call.add_argument (expr);
		return call;
	}

	Expression deserialize_basic (BasicTypeInfo basic_type, Expression expr) {
		if (basic_type.is_string) {
			var call = new MethodCall (new MemberAccess (expr, "get_string", b.source_reference), b.source_reference);
			call.add_argument (new NullLiteral ());
			return call;
		}

		return new MethodCall (new MemberAccess (expr, "get_" + basic_type.type_name, b.source_reference), b.source_reference);
	}

	Expression deserialize_array (ArrayType array_type, Expression expr) {
		Method m;
		if (!wrapper_method (copy_type (array_type, true), "gvariant_deserialize_array " + array_type.to_string (), out m)) {
			m.add_parameter (new Parameter ("variant", data_type ("GLib.Variant", false), b.source_reference));
			push_builder (new CodeBuilder.for_subroutine (m));

			var iterator = b.add_temp_declaration (data_type ("GLib.VariantIter"), expression ("variant.iterator ()"));

			var array_new = new ArrayCreationExpression (array_type.element_type, array_type.rank, null, b.source_reference);
			var array = b.add_temp_declaration (copy_type (array_type, true));

			string[] indices = new string[array_type.rank];
			for (int dim = 1; dim <= array_type.rank; dim++) {
				string length = b.add_temp_declaration (data_type ("size_t"));
				b.add_assignment (expression (length), expression (@"$iterator.n_children ()"));
				array_new.append_size (expression (length));
				indices[dim - 1] = b.add_temp_declaration (null, expression ("0"));
				if (dim < array_type.rank) {
					b.add_expression (expression (@"$iterator.next_value ()"));
				}
			}
			b.add_assignment (expression (array), array_new);
			deserialize_array_dim (array_type, "variant", indices, 1, array);
			b.add_return (expression (array));

			pop_builder ();
			check (m);
		}
		var call = (MethodCall) expression (m.name + " ()");
		call.add_argument (expr);
		return call;
	}

	void deserialize_array_dim (ArrayType array_type, string variant, string[] indices, int dim, string array) {
		var iter = b.add_temp_declaration (data_type ("GLib.VariantIter"));
		b.add_assignment (expression (iter), expression (@"$variant.iterator ()"));
		var new_variant = b.add_temp_declaration (data_type ("GLib.Variant"));
		b.open_while (expression (@"($new_variant = $iter.next_value ()) != null"));

		if (dim == array_type.rank) {
			var element_access = new ElementAccess (expression (array), b.source_reference);
			for (int i = 0; i < array_type.rank; i++) {
				element_access.append_index (expression (@"$(indices[i])++"));
			}
			if (is_gvariant_type (array_type.element_type)) {
				b.add_assignment (element_access, expression (@"$new_variant.get_variant ()"));
			} else {
				b.add_assignment (element_access, expression (@"($(array_type.element_type)) ($new_variant)"));
			}
		} else {
			deserialize_array_dim (array_type, new_variant, indices, dim + 1, array);
		}

		b.close ();
	}

	Expression? deserialize_struct (Struct st, Expression expr) {
		bool has_instance_field = false;
		foreach (var f in st.get_fields ()) {
			if (f.binding == MemberBinding.INSTANCE) {
				has_instance_field = true;
				break;
			}
		}
		if (!has_instance_field) {
			return null;
		}

		Method m;
		var type = SemanticAnalyzer.get_data_type_for_symbol (st);
		type.value_owned = true;
		if (!wrapper_method (type, "gvariant_deserialize_struct " + type.to_string (), out m)) {
			m.add_parameter (new Parameter ("variant", data_type ("GLib.Variant", false), b.source_reference));
			push_builder (new CodeBuilder.for_subroutine (m));

			var iterator = b.add_temp_declaration (data_type ("GLib.VariantIter"), expression (@"variant.iterator ()"));

			var result = b.add_temp_declaration (type, expression ("{}"));

			foreach (var f in st.get_fields ()) {
				if (f.binding != MemberBinding.INSTANCE) {
					continue;
				}

				if (is_gvariant_type (f.variable_type)) {
					b.add_expression (expression (@"$result.$(f.name) = $iterator.next_value ().get_variant ()"));
				} else {
					b.add_expression (expression (@"$result.$(f.name) = ($(f.variable_type)) ($iterator.next_value ())"));
				}
			}
			b.add_return (expression (result));
			pop_builder ();
			check (m);
		}
		var call = (MethodCall) expression (m.name + " ()");
		call.add_argument (expr);
		return call;
	}

	Expression deserialize_hash_table (DataType type, Expression expr) {
		Method m;
		if (!wrapper_method (copy_type (type, true), "gvariant_deserialize_hash_table " + type.to_string (), out m)) {
			m.add_parameter (new Parameter ("variant", data_type ("GLib.Variant", false), b.source_reference));
			push_builder (new CodeBuilder.for_subroutine (m));

			var iterator = b.add_temp_declaration (data_type ("GLib.VariantIter"), expression (@"variant.iterator ()"));

			var type_args = type.get_type_arguments ();
			assert (type_args.size == 2);
			var key_type = type_args.get (0);
			var value_type = type_args.get (1);

			Expression hash_table_new;
			if (key_type.data_type == context.analyzer.string_type.data_type) {
				hash_table_new = expression (@"new $type (GLib.str_hash, GLib.str_equal)");
			} else {
				hash_table_new = expression (@"new $type (GLib.direct_hash, GLib.direct_equal)");
			}

			var hash_table = b.add_temp_declaration (copy_type (type, true), hash_table_new);
			var new_variant = b.add_temp_declaration (data_type ("GLib.Variant"));

			b.open_while (expression (@"($new_variant = $iterator.next_value ()) != null"));
			var serialized_key = @"$new_variant.get_child_value (0)";
			serialized_key = is_gvariant_type (key_type) ? @"$serialized_key.get_variant ()" : @"($key_type)($serialized_key)";
			var serialized_value = @"$new_variant.get_child_value (1)";
			serialized_value = is_gvariant_type (value_type) ? @"$serialized_value.get_variant ()" : @"($value_type)($serialized_value)";
			b.add_expression (expression (@"$hash_table.insert ($serialized_key, $serialized_value)"));
			b.close ();

			b.add_return (expression (hash_table));
			pop_builder ();
			check (m);
		}
		var call = (MethodCall) expression (m.name + " ()");
		call.add_argument (expr);
		return call;
	}

	string get_dbus_value (EnumValue value, string default_value) {
		var dbus_value = value.get_attribute_string ("DBus", "value");
		if (dbus_value != null) {
			return dbus_value;;
		}
		return default_value;
	}

	void add_enum_from_string_method (Enum en) {
		if (en.scope.lookup ("from_string") != null) {
			return;
		}
		var m = new Method ("from_string", SemanticAnalyzer.get_data_type_for_symbol (en), en.source_reference);
		m.add_error_type (data_type ("GLib.DBusError.INVALID_ARGS"));
		m.add_parameter (new Parameter ("str", data_type ("string", false), en.source_reference));
		en.add_method (m);
		m.binding = MemberBinding.STATIC;
		m.access = SymbolAccessibility.PUBLIC;
		push_builder (new CodeBuilder.for_subroutine (m));

		b.open_switch (expression ("str"), null);
		b.add_throw (expression ("new GLib.DBusError.INVALID_ARGS (\"Invalid value for enum `%s'\")".printf (get_ccode_name (en))));
		foreach (var enum_value in en.get_values ()) {
			string dbus_value = get_dbus_value (enum_value, enum_value.name);
			b.add_section (expression (@"\"$dbus_value\""));
			b.add_return (expression (@"$(en.get_full_name ()).$(enum_value.name)"));
		}
		b.close ();
		pop_builder ();

		check (m);
	}

	void add_enum_to_string_method (Enum en) {
		if (en.scope.lookup ("to_string") != null) {
			return;
		}
		var m = new Method ("to_string", data_type ("string", false, true), en.source_reference);
		en.add_method (m);
		m.access = SymbolAccessibility.PUBLIC;
		push_builder (new CodeBuilder.for_subroutine (m));

		b.open_switch (expression ("this"), null);
		b.add_return (expression ("null"));
		foreach (var enum_value in en.get_values ()) {
			string dbus_value = get_dbus_value (enum_value, enum_value.name);
			b.add_section (expression (@"$(en.get_full_name ()).$(enum_value.name)"));
			b.add_return (expression (@"\"$dbus_value\""));
		}
		b.close ();
		pop_builder ();

		check (m);
	}

	public override void visit_enum (Enum en) {
		if (!en.external && is_string_marshalled_enum (en) && context.has_package ("gio-2.0")) {
			add_enum_from_string_method (en);
			add_enum_to_string_method (en);
		}
		base.visit_enum (en);
	}

	public override void visit_cast_expression (CastExpression expr) {
		if (!(is_gvariant_type (expr.inner.value_type) && !is_gvariant_type (expr.type_reference))) {
			// no explicit gvariant unboxing
			base.visit_cast_expression (expr);
			return;
		}

		push_builder (new CodeBuilder (context, expr.parent_statement, expr.source_reference));
		var type = expr.value_type;

		BasicTypeInfo basic_type;
		Expression result = null;
		if (is_string_marshalled_enum (type.data_type)) {
			get_basic_type_info ("s", out basic_type);
			result = deserialize_basic (basic_type, expr.inner);
			var call = (MethodCall) expression (@"$(type.data_type.get_full_name ()).from_string ()");
			call.add_argument (result);
			result = call;
		} else if (get_basic_type_info (get_type_signature (type), out basic_type)) {
			result = deserialize_basic (basic_type, expr.inner);
		} else if (type is ArrayType) {
			result = deserialize_array ((ArrayType) type, expr.inner);
		} else if (type.data_type is Struct) {
			result = deserialize_struct ((Struct) type.data_type, expr.inner);
		} else if (type is ObjectType && type.data_type.get_full_name () == "GLib.HashTable") {
			result = deserialize_hash_table ((ObjectType) type, expr.inner);
		}

		if (result == null) {
			Report.error (type.source_reference, "GVariant deserialization of type `%s' is not supported".printf (type.to_string ()));
		}

		context.analyzer.replaced_nodes.add (expr.inner);
		expr.inner = result;
		b.check (this);
		pop_builder ();
		expr.checked = false;
		check (expr);
	}

	public override void visit_expression (Expression expr) {
		if (expr in context.analyzer.replaced_nodes) {
			return;
		}

		if (!(context.profile == Profile.GOBJECT && expr.target_type != null && is_gvariant_type (expr.target_type) && !(expr.value_type is NullType) && !is_gvariant_type (expr.value_type))) {
			// no implicit gvariant boxing
			base.visit_expression (expr);
			return;
		}

		push_builder (new CodeBuilder (context, expr.parent_statement, expr.source_reference));
		var old_parent_node = expr.parent_node;
		var target_type = expr.target_type.copy ();
		var type = expr.value_type;

		BasicTypeInfo basic_type;
		Expression result = null;
		if (is_string_marshalled_enum (type.data_type)) {
			get_basic_type_info ("s", out basic_type);
			result = new MethodCall (new MemberAccess (expr, "to_string"), b.source_reference);
		} else if (get_basic_type_info (get_type_signature (type), out basic_type)) {
			result = serialize_basic (basic_type, expr);
		} else if (type is ArrayType) {
			result = serialize_array ((ArrayType) type, expr);
		} else if (type.data_type is Struct) {
			result = serialize_struct ((Struct) type.data_type, expr);
		} else if (type is ObjectType && type.data_type.get_full_name () == "GLib.HashTable") {
			result = serialize_hash_table ((ObjectType) type, expr);
		}

		if (result == null) {
			Report.error (type.source_reference, "GVariant serialization of type `%s' is not supported".printf (type.to_string ()));
		}

		result.target_type = target_type;
		context.analyzer.replaced_nodes.add (expr);
		old_parent_node.replace_expression (expr, result);
		b.check (this);
		pop_builder ();
		check (result);
	}
}
