/* valabooleantype.vala
 *
 * Copyright (C) 2009  Jürg Billeter
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
 * A boolean type.
 */
public class Vala.BooleanType : ValueType {
	public bool value { get; set; }
	public bool value_set { get; set; }

	public BooleanType (Struct type_symbol) {
		base (type_symbol);
	}

	public override DataType copy () {
		var result = new BooleanType ((Struct) type_symbol);
		result.source_reference = source_reference;
		result.value_owned = value_owned;
		result.nullable = nullable;
		result.value = value;
		result.value_set = value_set;
		return result;
	}

	public override bool compatible (DataType target_type) {
		if (CodeContext.get ().experimental_non_null && nullable && !target_type.nullable) {
			return false;
		}

		if (target_type.get_type_id () == "G_TYPE_VALUE") {
			// allow implicit conversion to GValue
			return true;
		}

		var bool_target_type = target_type as BooleanType;
		if (bool_target_type != null) {
			if (!bool_target_type.value_set) {
				return true;
			} else if (!value_set) {
				return false;
			} else {
				return (this.value == bool_target_type.value);
			}
		}

		return false;
	}
}
