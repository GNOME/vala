/* valadbusvariantmodule.vala
 *
 * Copyright (C) 2017 Chris Daley
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
 * 	Chris Daley <chebizarro@gmail.com>
 */

public class Vala.DBusVariantModule {

	private CodeContext context;

	public Symbol root_symbol;

	public Namespace current_ns;

	public DataType void_type = new VoidType ();
	public DataType bool_type;
	public DataType char_type;
	public DataType uchar_type;
	public DataType int_type;
	public DataType uint_type;
	public DataType long_type;
	public DataType ulong_type;
	public DataType int8_type;
	public DataType uint8_type;
	public DataType int16_type;
	public DataType uint16_type;
	public DataType int32_type;
	public DataType uint32_type;
	public DataType int64_type;
	public DataType uint64_type;
	public DataType string_type;
	public DataType object_path_type;
	public DataType float_type;
	public DataType double_type;
	public TypeSymbol gtype_type;
	public TypeSymbol gobject_type;
	public ErrorType gerror_type;
	public ErrorType gdbus_error_type;
	public ErrorType gio_error_type;
	public ObjectType dictionary_type;
	public ObjectType gvariant_type;
	public Struct gvalue_type;
	public DataType vardict_type;
	public DataType string_array_type;
	public DataType object_path_array_type;

	public DBusVariantModule (CodeContext context) {

		this.context = context;

		root_symbol = context.root;

		bool_type = new BooleanType ((Struct) root_symbol.scope.lookup ("bool"));
		char_type = new IntegerType ((Struct) root_symbol.scope.lookup ("char"));
		uchar_type = new IntegerType ((Struct) root_symbol.scope.lookup ("uchar"));
		int_type = new IntegerType ((Struct) root_symbol.scope.lookup ("int"));
		uint_type = new IntegerType ((Struct) root_symbol.scope.lookup ("uint"));
		long_type = new IntegerType ((Struct) root_symbol.scope.lookup ("long"));
		ulong_type = new IntegerType ((Struct) root_symbol.scope.lookup ("ulong"));
		int8_type = new IntegerType ((Struct) root_symbol.scope.lookup ("int8"));
		uint8_type = new IntegerType ((Struct) root_symbol.scope.lookup ("uint8"));
		int16_type = new IntegerType ((Struct) root_symbol.scope.lookup ("int16"));
		uint16_type = new IntegerType ((Struct) root_symbol.scope.lookup ("uint16"));
		int32_type = new IntegerType ((Struct) root_symbol.scope.lookup ("int32"));
		uint32_type = new IntegerType ((Struct) root_symbol.scope.lookup ("uint32"));
		int64_type = new IntegerType ((Struct) root_symbol.scope.lookup ("int64"));
		uint64_type = new IntegerType ((Struct) root_symbol.scope.lookup ("uint64"));
		float_type = new FloatingType ((Struct) root_symbol.scope.lookup ("float"));
		double_type = new FloatingType ((Struct) root_symbol.scope.lookup ("double"));
		string_type = new ObjectType ((Class) root_symbol.scope.lookup ("string"));
		string_type.value_owned = true;

		var glib_ns = root_symbol.scope.lookup ("GLib");

		object_path_type = new ObjectType ((Class) glib_ns.scope.lookup ("ObjectPath"));
		object_path_type.value_owned = true;

		TypeSymbol ghashtable_type = (TypeSymbol) glib_ns.scope.lookup ("HashTable");
		gtype_type = (TypeSymbol) glib_ns.scope.lookup ("Type");
		gobject_type = (TypeSymbol) glib_ns.scope.lookup ("Object");
		gerror_type = new ErrorType (null, null);
		gio_error_type = new ErrorType ((ErrorDomain) glib_ns.scope.lookup ("DBusError"), null);
		gdbus_error_type = new ErrorType ((ErrorDomain) glib_ns.scope.lookup ("IOError"), null);

		gvalue_type = (Struct) glib_ns.scope.lookup ("Value");
		gvariant_type = new ObjectType ((Class) glib_ns.scope.lookup ("Variant"));
		gvariant_type.value_owned = true;

		dictionary_type = new ObjectType ((ObjectTypeSymbol) ghashtable_type);
		dictionary_type.value_owned = true;

		vardict_type = dictionary_type.copy ();
		vardict_type.add_type_argument (string_type.copy ());
		vardict_type.add_type_argument (gvariant_type.copy ());

		string_array_type = new ArrayType (string_type.copy (), 1, null);
		string_array_type.value_owned = true;

		object_path_array_type = new ArrayType (object_path_type.copy (), 1, null);
		object_path_array_type.value_owned = true;
	}

	public DataType? get_dbus_type (string type) {
		if (VariantType.string_is_valid (type)) {
			var variant = new VariantType (type);
			return get_variant_type (variant);
		} else {
			string emessage = "The Variant Type string: %s is invalid".printf (type);
			Report.error (null, emessage);
			return null;
		}
	}

	private DataType? get_variant_type (VariantType type) {
		if (type.is_basic ()) {
			if (type.equal (VariantType.BOOLEAN)) {
				return bool_type.copy ();
			} else if (type.equal (VariantType.BYTE)) {
				return char_type.copy ();
			} else if (type.equal (VariantType.INT16)) {
				return int16_type.copy ();
			} else if (type.equal (VariantType.UINT16)) {
				return uint16_type.copy ();
			} else if (type.equal (VariantType.INT32)) {
				return int32_type.copy ();
			} else if (type.equal (VariantType.UINT32)) {
				return uint32_type.copy ();
			} else if (type.equal (VariantType.INT64)) {
				return int64_type.copy ();
			} else if (type.equal (VariantType.UINT64)) {
				return uint64_type.copy ();
			} else if (type.equal (VariantType.DOUBLE)) {
				return double_type.copy ();
			} else if (type.equal (VariantType.STRING)) {
				return string_type.copy ();
			} else if (type.equal (VariantType.OBJECT_PATH)) {
				return object_path_type.copy ();
			} else if (type.equal (VariantType.SIGNATURE)) {
				return string_type.copy ();
			} else if (type.equal (VariantType.HANDLE)) {
				// TODO: The spec says: 32-bit unsigned integer in the message's byte order.
				// But usually e.g. `open()` returns an 32-bit signed integer
				return int32_type.copy ();
			}
		} else if (type.is_variant ()) {
			return gvariant_type.copy ();
		}
		return get_complex_type (type);
	}

	private string generate_struct_name (VariantType type) {
		return "DBusProxyStruct" + ((string) type.peek_string ())
					.replace ("(", "_1")
					.replace (")", "1_")
					.replace ("{", "_2")
					.replace ("}", "2_")
					;
	}

	private bool invalid_generic_type (VariantType type) {
		return  type.equal (VariantType.BOOLEAN)
				|| type.equal (VariantType.BYTE)
				|| type.equal (VariantType.INT16)
				|| type.equal (VariantType.UINT16)
				|| type.equal (VariantType.INT32)
				|| type.equal (VariantType.UINT32)
				|| type.equal (VariantType.INT64)
				|| type.equal (VariantType.UINT64)
				|| type.equal (VariantType.DOUBLE);
	}

	private DataType? get_complex_type (VariantType type) {
		// If we were able to interpret it, but it is false vala syntax
		// E.g. generics with arrays/primitive types
		var skipped_generation = false;
		if (type.equal (VariantType.OBJECT_PATH_ARRAY)) {
			return object_path_array_type.copy ();
		} else if (type.equal (VariantType.BYTESTRING)) {
			return string_type.copy ();
		} else if (type.equal (VariantType.BYTESTRING_ARRAY)) {
			return string_array_type.copy ();
		}  else if (type.equal (VariantType.STRING_ARRAY)) {
			return string_array_type.copy ();
		} else if (type.is_array ()) {
			var element = type.element ();
			if (element.equal (VariantType.DICTIONARY) || element.is_dict_entry ()) {
				var res = dictionary_type.copy ();
				var invalid_generic_arg = invalid_generic_type (element.key()) || invalid_generic_type (element.value ());
				var key = get_variant_type (element.key ());
				var value = get_variant_type (element.value ());
				var valid_types = !((key is ArrayType) || (value is ArrayType) || (key is StructValueType) || (value is StructValueType) || invalid_generic_arg);
				if (key != null && value != null) {
					if (valid_types) {
						res.add_type_argument (key);
						res.add_type_argument (value);
						return res;
					} else {
						skipped_generation = true;
					}
				}
			} else {
				var element_type = get_variant_type (element);
				if (element != null && !(element_type is ArrayType) && element_type != null) {
					var array = new ArrayType (element_type, 1, null);
					array.value_owned = true;
					return array;
				}
			}
		} else if (type.is_tuple ()) {
			var generated_name = generate_struct_name (type);
			foreach (var st in current_ns.get_structs ()) {
				if (st.name == generated_name) {
					return new StructValueType (st, null);
				}
			}
			var n = type.n_items ();
			var able_to_add_all = true;
			unowned var sub = type.first ();
			var file = context.get_source_file ("<artificial>");
			if (file == null) {
				file = new SourceFile (context, SourceFileType.SOURCE, "<artificial>", null, true);
				context.add_source_file (file);
			}
			var sref = new SourceReference (
								file,
								SourceLocation (null, 0, 0),
								SourceLocation (null, 0, 1));
			var new_struct = new Struct (generated_name, sref);
			new_struct.access = SymbolAccessibility.PUBLIC;
			for (var i = 0; i < n; i++) {
				var dt = get_dbus_type (sub.dup_string ());
				if (dt == null) {
					able_to_add_all = false;
					break;
				}
				var field = new Field ("arg%d".printf (i), dt, null, sref);
				field.access = SymbolAccessibility.PUBLIC;
				new_struct.add_field (field);
				sub = sub.next();
			}
			if (able_to_add_all) {
				current_ns.add_struct (new_struct);
				return new StructValueType (new_struct, null);
			}
		}

		if (!skipped_generation) {
			Report.warning (null, "Unresolved type: %s".printf ((string) type.peek_string ()));
		}
		return null;

		if (type.equal (VariantType.DICT_ENTRY) || type.is_dict_entry ()) {
			return dictionary_type.copy ();
		}  else if (type.equal (VariantType.UNIT)) {
			return void_type.copy ();
		} else if (type.equal (VariantType.VARDICT)) {
			return vardict_type.copy ();
		} else if (type.equal (VariantType.VARIANT) || type.equal (VariantType.ANY) ||  type.equal (VariantType.MAYBE) || type.equal (VariantType.TUPLE)) {
			return gvariant_type.copy ();
		}

		if (type.equal (VariantType.MAYBE)) {
			return string_type.copy ();
		} else if (type.equal (VariantType.ARRAY)) {
			return new ArrayType (gvariant_type.copy (), 1, null);
		} else if (type.equal (VariantType.DICT_ENTRY)) {
			return string_type.copy ();
		} else if (type.equal (VariantType.DICTIONARY)) {
			return dictionary_type.copy ();
		}
	}
}
