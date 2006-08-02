/* valaenumvalue.vala
 *
 * Copyright (C) 2006  Jürg Billeter
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public
 * License as published by the Free Software Foundation; either
 * version 2 of the License, or (at your option) any later version.

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
 * Represents an enum member in the source code.
 */
public class Vala.EnumValue : CodeNode {
	/**
	 * The symbol name of this enum value.
	 */
	public string! name { get; set construct; }

	/**
	 * Specifies the numerical representation of this enum value.
	 */
	public Expression value { get; set; }

	private string cname;

	/**
	 * Creates a new enum value.
	 *
	 * @param name enum value name
	 * @return     newly created enum value
	 */
	public construct (string! _name) {
		name = _name;
	}

	/**
	 * Creates a new enum value with the specified numerical representation.
	 *
	 * @param name  enum value name
	 * @param value numerical representation
	 * @return      newly created enum value
	 */
	public construct with_value (string! _name, Expression _value) {
		name = _name;
		value = _value;
	}
	
	public override void accept (CodeVisitor! visitor) {
		visitor.visit_enum_value (this);
	}
	
	/**
	 * Returns the name of this enum value as it is used in C code.
	 *
	 * @return the name to be used in C code
	 */
	public string! get_cname () {
		if (cname == null) {
			var en = (Enum) symbol.parent_symbol.node;
			cname = "%s%s".printf (en.get_cprefix (), name);
		}
		return cname;
	}
}
