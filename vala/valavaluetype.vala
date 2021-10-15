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
	protected ValueType (TypeSymbol type_symbol, SourceReference? source_reference = null) {
		base.with_symbol (type_symbol, source_reference);
	}

	public override bool is_disposable () {
		if (!value_owned) {
			return false;
		}

		// nullable structs are heap allocated
		if (nullable) {
			return true;
		}

		unowned Struct? st = type_symbol as Struct;
		if (st != null && !st.error) {
			return st.is_disposable ();
		}

		return false;
	}

	public override bool check (CodeContext context) {
		if (!type_symbol.check (context)) {
			error = true;
			return false;
		}

		// check whether there is the expected amount of type-arguments
		if (!check_type_arguments (context, true)) {
			error = true;
			return false;
		}

		return true;
	}
}
