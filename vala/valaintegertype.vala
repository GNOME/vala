/* valaintegertype.vala
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

using GLib;

/**
 * An integer type.
 */
public class Vala.IntegerType : ValueType {
	public IntegerLiteral literal { get; set; }

	public IntegerType (Typesymbol type_symbol) {
		this.type_symbol = type_symbol;
		data_type = type_symbol;
	}

	public override DataType copy () {
		var type = new IntegerType (type_symbol);
		type.literal = literal;
		return type;
	}

	public override bool compatible (DataType target_type, bool enable_non_null = true) {
		if (target_type.data_type is Struct && literal.get_type_name () == "int") {
			// int literals are implicitly convertible to integer types
			// of a lower rank if the value of the literal is within
			// the range of the target type
			var target_st = (Struct) target_type.data_type;
			if (target_st.is_integer_type ()) {
				var int_attr = target_st.get_attribute ("IntegerType");
				if (int_attr.has_argument ("min") && int_attr.has_argument ("max")) {
					int val = literal.value.to_int ();
					return (val >= int_attr.get_integer ("min") && val <= int_attr.get_integer ("max"));
				}
			}
		} else if (target_type.data_type is Enum && literal.get_type_name () == "int") {
			// allow implicit conversion from 0 to enum and flags types
			if (literal.value.to_int () == 0) {
				return true;
			}
		}

		return base.compatible (target_type, enable_non_null);
	}
}
