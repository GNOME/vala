/* valatypeparametertype.vala
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
public class Vala.TypeParameterType : DataType {
	public TypeParameterType (TypeParameter type_parameter) {
		this.type_parameter = type_parameter;
	}

	public override DataType copy () {
		var result = new TypeParameterType (type_parameter);
		result.source_reference = source_reference;
		result.transfers_ownership = transfers_ownership;
		result.takes_ownership = takes_ownership;
		result.nullable = nullable;
		result.floating_reference = floating_reference;

		return result;
	}

	public override string? get_cname () {
		if (takes_ownership || transfers_ownership) {
			return "gpointer";
		} else {
			return "gconstpointer";
		}
	}
}
