/* valavartype.vala
 *
 * Copyright (C) 2019  Rico Tzschichholz
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
 * 	Rico Tzschichholz <ricotz@ubuntu.com>
 */

/**
 * A to be inferred data type.
 */
public class Vala.VarType : DataType {
	public VarType (bool value_owned = true) {
		this.value_owned = value_owned;
	}

	public override string to_qualified_string (Scope? scope) {
		return "var";
	}

	public override DataType copy () {
		var result = new VarType (value_owned);
		result.nullable = nullable;
		result.is_dynamic = is_dynamic;
		return result;
	}
}
