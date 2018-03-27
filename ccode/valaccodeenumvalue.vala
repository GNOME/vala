/* valaccodeenumvalue.vala
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

/**
 * Represents an enum value in the C code.
 */
public class Vala.CCodeEnumValue : CCodeNode {
	/**
	 * The name of this enum value.
	 */
	public string name { get; set; }

	/**
	 * The numerical representation of this enum value.
	 */
	public CCodeExpression? value { get; set; }

	public CCodeEnumValue (string name, CCodeExpression? value = null) {
		this.name = name;
		this.value = value;
	}

	public override void write (CCodeWriter writer) {
		writer.write_string (name);
		if (CCodeModifiers.DEPRECATED in modifiers) {
			// FIXME Requires GCC 6.0 to work at this place
			// https://gcc.gnu.org/bugzilla/show_bug.cgi?id=47043
			//writer.write_string (" G_GNUC_DEPRECATED");
		}
		if (value != null) {
			writer.write_string (" = ");
			value.write (writer);
		}
	}
}
