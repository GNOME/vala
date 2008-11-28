/* valagenerictype.vala
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
 * The type of a generic type parameter.
 */
public class Vala.GenericType : DataType {
	public GenericType (TypeParameter type_parameter) {
		this.type_parameter = type_parameter;
	}

	public override DataType copy () {
		var result = new GenericType (type_parameter);
		result.source_reference = source_reference;
		result.value_owned = value_owned;
		result.nullable = nullable;
		result.floating_reference = floating_reference;

		return result;
	}

	public override string? get_cname () {
		if (value_owned) {
			return "gpointer";
		} else {
			return "gconstpointer";
		}
	}

	public override string? get_type_id () {
		return "G_TYPE_POINTER";
	}
}
