/* valafieldprototype.vala
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
 * A reference to an instance field without a specific instance.
 */
public class Vala.FieldPrototype : DataType {
	public Field field_symbol { get; set; }

	public FieldPrototype (Field field_symbol) {
		this.field_symbol = field_symbol;
	}

	public override DataType copy () {
		var result = new FieldPrototype (field_symbol);
		return result;
	}

	public override string to_qualified_string (Scope? scope) {
		return field_symbol.get_full_name ();
	}
}
