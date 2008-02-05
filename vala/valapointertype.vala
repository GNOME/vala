/* valapointertype.vala
 *
 * Copyright (C) 2007-2008  Jürg Billeter
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
using Gee;

/**
 * A pointer type.
 */
public class Vala.PointerType : DataType {
	/**
	 * The base type the pointer is referring to.
	 */
	public DataType base_type { get; set; }

	public PointerType (construct DataType! base_type) {
	}

	public override string! to_string () {
		return base_type.to_string () + "*";
	}

	public override string get_cname (bool var_type = false, bool const_type = false) {
		if (base_type.data_type != null && base_type.data_type.is_reference_type ()) {
			return base_type.get_cname (var_type, const_type);
		} else {
			return base_type.get_cname (var_type, const_type) + "*";
		}
	}

	public override DataType! copy () {
		return new PointerType (base_type);
	}

	public override bool compatible (DataType! target_type, bool enable_non_null = true) {
		if (target_type is PointerType || (target_type.data_type != null && target_type.data_type.get_attribute ("PointerType") != null)) {
			return true;
		}

		/* temporarily ignore type parameters */
		if (target_type.type_parameter != null) {
			return true;
		}

		if (base_type.is_reference_type_or_type_parameter ()) {
			// Object* is compatible with Object if Object is a reference type
			return base_type.compatible (target_type, enable_non_null);
		}

		return false;
	}

	public override Symbol get_pointer_member (string member_name) {
		Symbol base_symbol = base_type.data_type;

		if (base_symbol == null) {
			return null;
		}

		return SemanticAnalyzer.symbol_lookup_inherited (base_symbol, member_name);
	}

	public override Collection<Symbol> get_symbols () {
		return base_type.get_symbols ();
	}
}
