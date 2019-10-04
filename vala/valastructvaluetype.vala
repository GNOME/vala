/* valastructvaluetype.vala
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
 * A struct value type.
 */
public class Vala.StructValueType : ValueType {
	public StructValueType (Struct type_symbol) {
		base (type_symbol);
	}

	public override bool is_invokable () {
		unowned Struct? st = type_symbol as Struct;
		if (st != null && st.default_construction_method != null) {
			return true;
		} else {
			return false;
		}
	}

	public override unowned DataType? get_return_type () {
		unowned Struct? st = type_symbol as Struct;
		if (st != null && st.default_construction_method != null) {
			return st.default_construction_method.return_type;
		} else {
			return null;
		}
	}

	public override unowned List<Parameter>? get_parameters () {
		unowned Struct? st = type_symbol as Struct;
		if (st != null && st.default_construction_method != null) {
			return st.default_construction_method.get_parameters ();
		} else {
			return null;
		}
	}

	public override DataType copy () {
		var result = new StructValueType ((Struct) type_symbol);
		result.source_reference = source_reference;
		result.value_owned = value_owned;
		result.nullable = nullable;

		foreach (DataType arg in get_type_arguments ()) {
			result.add_type_argument (arg.copy ());
		}

		return result;
	}
}
