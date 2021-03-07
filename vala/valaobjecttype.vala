/* valaobjecttype.vala
 *
 * Copyright (C) 2007-2010  Jürg Billeter
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
 * A class type.
 */
public class Vala.ObjectType : ReferenceType {
	/**
	 * The referred class or interface.
	 */
	public weak ObjectTypeSymbol object_type_symbol {
		get {
			return (ObjectTypeSymbol) symbol;
		}
	}

	public ObjectType (ObjectTypeSymbol type_symbol) {
		base (type_symbol);
	}

	public override DataType copy () {
		var result = new ObjectType (object_type_symbol);
		result.source_reference = source_reference;
		result.value_owned = value_owned;
		result.nullable = nullable;
		result.is_dynamic = is_dynamic;
		result.floating_reference = floating_reference;

		foreach (DataType arg in get_type_arguments ()) {
			result.add_type_argument (arg.copy ());
		}

		return result;
	}

	public override bool stricter (DataType target_type) {
		unowned ObjectType? obj_target_type = target_type as ObjectType;
		if (obj_target_type == null) {
			return false;
		}

		if (value_owned != target_type.value_owned) {
			return false;
		}

		if (nullable && !target_type.nullable) {
			return false;
		}

		return type_symbol.is_subtype_of (obj_target_type.type_symbol);
	}

	public override bool is_invokable () {
		unowned Class? cl = type_symbol as Class;
		if (cl != null && cl.default_construction_method != null) {
			return true;
		} else {
			return false;
		}
	}

	public override unowned DataType? get_return_type () {
		unowned Class? cl = type_symbol as Class;
		if (cl != null && cl.default_construction_method != null) {
			return cl.default_construction_method.return_type;
		} else {
			return null;
		}
	}

	public override unowned List<Parameter>? get_parameters () {
		unowned Class? cl = type_symbol as Class;
		if (cl != null && cl.default_construction_method != null) {
			return cl.default_construction_method.get_parameters ();
		} else {
			return null;
		}
	}

	public override bool check (CodeContext context) {
		if (!type_symbol.check (context)) {
			return false;
		}

		// check whether there is the expected amount of type-arguments
		if (!check_type_arguments (context, true)) {
			return false;
		}

		return true;
	}
}
