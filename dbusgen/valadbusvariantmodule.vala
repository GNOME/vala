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
	public DataType? unichar_type;
	public DataType short_type;
	public DataType ushort_type;
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
	public DataType regex_type;
	public DataType float_type;
	public DataType double_type;
	public TypeSymbol gtype_type;
	public TypeSymbol gobject_type;
	public ErrorType gerror_type;
	public Class glist_type;
	public Class gslist_type;
	public Class gnode_type;
	public Class gqueue_type;
	public Class gvaluearray_type;
	public TypeSymbol gstringbuilder_type;
	public TypeSymbol garray_type;
	public TypeSymbol gbytearray_type;
	public TypeSymbol gptrarray_type;
	public TypeSymbol gthreadpool_type;
	public DataType gdestroynotify_type;
	public DataType gquark_type;
	public Struct gvalue_type;
	public Class gvariant_type;
	public Struct mutex_type;
	public Struct gmutex_type;
	public Struct grecmutex_type;
	public Struct grwlock_type;
	public Struct gcond_type;
	public Class gsource_type;
	public TypeSymbol type_module_type;
	public TypeSymbol dbus_proxy_type;

	public DBusVariantModule (CodeContext context) {

		this.context = context;

		root_symbol = context.root;

		bool_type = new BooleanType ((Struct) root_symbol.scope.lookup ("bool"));
		char_type = new IntegerType ((Struct) root_symbol.scope.lookup ("char"));
		uchar_type = new IntegerType ((Struct) root_symbol.scope.lookup ("uchar"));
		short_type = new IntegerType ((Struct) root_symbol.scope.lookup ("short"));
		ushort_type = new IntegerType ((Struct) root_symbol.scope.lookup ("ushort"));
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
		var unichar_struct = (Struct) root_symbol.scope.lookup ("unichar");
		if (unichar_struct != null) {
			unichar_type = new IntegerType (unichar_struct);
		}
		var glib_ns = root_symbol.scope.lookup ("GLib");

		gtype_type = (TypeSymbol) glib_ns.scope.lookup ("Type");
		gobject_type = (TypeSymbol) glib_ns.scope.lookup ("Object");
		gerror_type = new ErrorType (null, null);
		glist_type = (Class) glib_ns.scope.lookup ("List");
		gslist_type = (Class) glib_ns.scope.lookup ("SList");
		gnode_type = (Class) glib_ns.scope.lookup ("Node");
		gqueue_type = (Class) glib_ns.scope.lookup ("Queue");
		gvaluearray_type = (Class) glib_ns.scope.lookup ("ValueArray");
		gstringbuilder_type = (TypeSymbol) glib_ns.scope.lookup ("StringBuilder");
		garray_type = (TypeSymbol) glib_ns.scope.lookup ("Array");
		gbytearray_type = (TypeSymbol) glib_ns.scope.lookup ("ByteArray");
		gptrarray_type = (TypeSymbol) glib_ns.scope.lookup ("PtrArray");
		gthreadpool_type = (TypeSymbol) glib_ns.scope.lookup ("ThreadPool");
		gdestroynotify_type = new DelegateType ((Delegate) glib_ns.scope.lookup ("DestroyNotify"));

		gquark_type = new IntegerType ((Struct) glib_ns.scope.lookup ("Quark"));
		gvalue_type = (Struct) glib_ns.scope.lookup ("Value");
		gvariant_type = (Class) glib_ns.scope.lookup ("Variant");
		gsource_type = (Class) glib_ns.scope.lookup ("Source");

		gmutex_type = (Struct) glib_ns.scope.lookup ("Mutex");
		grecmutex_type = (Struct) glib_ns.scope.lookup ("RecMutex");
		grwlock_type = (Struct) glib_ns.scope.lookup ("RWLock");
		gcond_type = (Struct) glib_ns.scope.lookup ("Cond");

		mutex_type = grecmutex_type;
	}

	public DataType? get_dbus_type (string type) {
		if (VariantType.string_is_valid (type)) {
			VariantType vrnt = new VariantType (type);
			return get_variant_type (vrnt);

		} else {
			string emessage = "The Variant Type string: %s is invalid".printf (type);
			Report.error (null, emessage);
			return null;
		}
	}

	private DataType get_variant_type (VariantType type) {

		if (type.equal (VariantType.BOOLEAN)) {
			return bool_type;
		} else if (type.equal (VariantType.BYTE)) {
			return char_type;
		} else if (type.equal (VariantType.INT16)) {
			return int16_type;
		} else if (type.equal (VariantType.UINT16)) {
			return uint16_type;
		} else if (type.equal (VariantType.INT32)) {
			return int32_type;
		} else if (type.equal (VariantType.UINT32)) {
			return uint32_type;
		} else if (type.equal (VariantType.INT64)) {
			return int64_type;
		} else if (type.equal (VariantType.UINT64)) {
			return uint64_type;
		} else if (type.equal (VariantType.DOUBLE)) {
			return double_type;
		} else if (type.equal (VariantType.STRING)) {
			return string_type.copy ();
		} else if (type.equal (VariantType.OBJECT_PATH)) {
			return string_type;
		} else if (type.equal (VariantType.SIGNATURE)) {
			return string_type;
		} else if (type.equal (VariantType.VARIANT) || type.equal (VariantType.ANY) || type.equal (VariantType.BASIC) || type.equal (VariantType.MAYBE) || type.equal (VariantType.TUPLE)) {
			return new ObjectType ((ObjectTypeSymbol) gvariant_type);
		}

		return new ObjectType ((ObjectTypeSymbol) gvariant_type);

		if (type.equal (VariantType.UNIT)) {
			return string_type;
		} else if (type.equal (VariantType.MAYBE)) {
			return string_type;
		} else if (type.equal (VariantType.OBJECT_PATH_ARRAY) || type.equal (VariantType.ARRAY) || type.equal (VariantType.STRING_ARRAY) || type.equal (VariantType.BYTESTRING_ARRAY)) {

			var element = new ObjectType ((ObjectTypeSymbol) gvariant_type); //get_variant_type (type.element ());
			return new ArrayType (element, 0, null);

		} else if (type.equal (VariantType.DICT_ENTRY)) {
			return string_type;
		} else if (type.equal (VariantType.DICTIONARY)) {
			return string_type;
		} else if (type.equal (VariantType.BYTESTRING)) {
			return string_type;
		} else if (type.equal (VariantType.VARDICT)) {
			return string_type;
		} else if (type.equal (VariantType.HANDLE)) {
			return string_type;
		}

	}

}
