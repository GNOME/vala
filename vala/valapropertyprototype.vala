/* valafieldprototype.vala
 *
 * Copyright (C) 2018  Rico Tzschichholz
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
 * A reference to an instance property without a specific instance.
 */
public class Vala.PropertyPrototype : DataType {
	public weak Property property_symbol {
		get {
			return (Property) symbol;
		}
	}

	public PropertyPrototype (Property property_symbol, SourceReference? source_reference = null) {
		base.with_symbol (property_symbol, source_reference);
	}

	public override DataType copy () {
		var result = new PropertyPrototype (property_symbol, source_reference);
		return result;
	}

	public override string to_qualified_string (Scope? scope) {
		return property_symbol.get_full_name ();
	}
}
