/* valavaluetype.vala
 *
 * Copyright (C) 2007-2009  Jürg Billeter
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
 * A value type, i.e. a struct or an enum type.
 */
public abstract class Vala.ValueType : DataType {
	/**
	 * The referred struct or enum.
	 */
	public weak TypeSymbol type_symbol { get; set; }

	public ValueType (TypeSymbol type_symbol) {
		this.type_symbol = type_symbol;
		data_type = type_symbol;
	}

	public override bool is_disposable () {
		if (!value_owned) {
			return false;
		}

		// nullable structs are heap allocated
		if (nullable) {
			return true;
		}

		var st = type_symbol as Struct;
		if (st != null) {
			return st.is_disposable ();
		}

		return false;
	}

	public override bool check (CodeContext context) {
		return type_symbol.check (context);
	}
}
