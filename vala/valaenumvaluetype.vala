/* valaenumvaluetype.vala
 *
 * Copyright (C) 2009-2011  Jürg Billeter
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
 * An enum value type.
 */
public class Vala.EnumValueType : ValueType {
	private Method? to_string_method;

	public EnumValueType (Enum type_symbol) {
		base (type_symbol);
	}

	public override DataType copy () {
		var result = new EnumValueType ((Enum) type_symbol);
		result.source_reference = source_reference;
		result.value_owned = value_owned;
		result.nullable = nullable;

		return result;
	}

	public Method get_to_string_method () {
		if (to_string_method == null) {
			var string_type = new ObjectType ((Class) CodeContext.get ().root.scope.lookup ("string"));
			string_type.value_owned = false;
			to_string_method = new Method ("to_string", string_type);
			to_string_method.access = SymbolAccessibility.PUBLIC;
			to_string_method.external = true;
			to_string_method.owner = type_symbol.scope;
			to_string_method.this_parameter = new Parameter ("this", this);
			to_string_method.scope.add (to_string_method.this_parameter.name, to_string_method.this_parameter);
		}
		return to_string_method;
	}

	public override Symbol? get_member (string member_name) {
		var result = base.get_member (member_name);
		if (result == null && member_name == "to_string") {
			return get_to_string_method ();
		}
		return result;
	}
}
