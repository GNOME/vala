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
	public DataType float_type;
	public DataType double_type;
	public TypeSymbol gtype_type;
	public TypeSymbol gobject_type;
	public ErrorType gerror_type;
	public ObjectType dictionary_type;
	public ObjectType gvariant_type;
	public Struct gvalue_type;
	public DataType vardict_type;
	public DataType string_array_type;

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

		var ghashtable_type = (TypeSymbol) glib_ns.scope.lookup ("HashTable");
		gtype_type = (TypeSymbol) glib_ns.scope.lookup ("Type");
		gobject_type = (TypeSymbol) glib_ns.scope.lookup ("Object");
		gerror_type = new ErrorType (null, null);

		gvalue_type = (Struct) glib_ns.scope.lookup ("Value");
		gvariant_type = new ObjectType ((Class) glib_ns.scope.lookup ("Variant"));
		gvariant_type.value_owned = true;

		dictionary_type = new ObjectType ((ObjectTypeSymbol) ghashtable_type);
		dictionary_type.value_owned = true;

		vardict_type = dictionary_type.copy ();
		vardict_type.add_type_argument (string_type.copy ());
		vardict_type.add_type_argument (gvariant_type.copy ());

		string_array_type = new ArrayType (string_type.copy (), 1, null);
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

	private DataType get_variant_type (VariantType type) {
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
				return string_type.copy ();
			} else if (type.equal (VariantType.SIGNATURE)) {
				return string_type.copy ();
			} else if (type.equal (VariantType.HANDLE)) {
				return int32_type.copy ();
			}
		} else if (type.is_variant ()) {
			return gvariant_type.copy ();
		}
		return get_complex_type (type);
	}

	private DataType get_complex_type (VariantType type) {
		if (type.is_array ()) {
			var element = type.element ();
			if (element.equal (VariantType.DICTIONARY) || element.is_dict_entry ()) {
				var res = dictionary_type.copy ();
				res.add_type_argument (get_variant_type (element.key ()));
				res.add_type_argument (get_variant_type (element.value ()));
				return res;
			}
			return new ArrayType (get_variant_type (element), 1, null);
		} else if (type.equal (VariantType.BYTESTRING)) {
			return string_type.copy (); //new ArrayType (uchar_type.copy (), 1, null);
		} else if (type.equal (VariantType.BYTESTRING_ARRAY)) {
			return string_array_type.copy (); //new ArrayType (uchar_type.copy (), 2, null);
		}  else if (type.equal (VariantType.STRING_ARRAY)) {
			return string_array_type.copy ();
		} else if (type.equal (VariantType.OBJECT_PATH_ARRAY)) {
			return string_array_type.copy ();
		}

		Report.warning (null, "Unresolved type: %s".printf ((string) type.peek_string ()));

		return gvariant_type.copy ();

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
