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

				sig = sig.replace ("%s", element_sig);
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
}
