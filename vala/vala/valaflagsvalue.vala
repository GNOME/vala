/* valaflagsvalue.vala
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
 * Represents a flags member in the source code.
 */
public class Vala.FlagsValue : CodeNode {
	/**
	 * The symbol name of this flags value.
	 */
	public string! name { get; set construct; }
	
	/**
	 * Specifies the numerical representation of this flags value.
	 */
	public Expression value { get; set; }

	private string cname;

	/**
	 * Creates a new flags value.
	 *
	 * @param name  flags value name
	 * @return      newly created flags value
	 */
	public static ref FlagsValue! new (string! name) {
		return (new FlagsValue (name = name));
	}

	/**
	 * Creates a new flags value with the specified numerical
	 * representation.
	 *
	 * @param name  flags value name
	 * @param value numerical representation
	 * @return      newly created flags value
	 */
	public static ref FlagsValue! new_with_value (string! name, Expression value) {
		return (new FlagsValue (name = name, value = value));
	}
	
	public override void accept (CodeVisitor! visitor) {
		visitor.visit_flags_value (this);
	}
	
	/**
	 * Returns the name of this flags value as it is used in C code.
	 *
	 * @return the name to be used in C code
	 */
	public string! get_cname () {
		if (cname == null) {
			var fl = (Flags) symbol.parent_symbol.node;
			cname = "%s_%s".printf (fl.get_upper_case_cname (null), name);
		}
		return cname;
	}
}
