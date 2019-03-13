/* valaccodedefine.vala
 *
 * Copyright (C) 2018  Dr. Michael 'Mickey' Lauer
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
 * 	Dr. Michael 'Mickey' Lauer <mickey@vanille-media.de>
 * 	Rico Tzschichholz <ricotz@ubuntu.com>
 */

using GLib;

/**
 * Represents a definition in the C code.
 */
public class Vala.CCodeDefine : CCodeNode {
	/**
	 * The name of this definition.
	 */
	public string name { get; set; }

	/**
	 * The value of this definition.
	 */
	public string? value { get; set; }

	/**
	 * The value expression of this definition.
	 */
	public CCodeExpression? value_expression { get; set; }

	public CCodeDefine (string name, string? value = null) {
		this.name = name;
		this.value = value;
	}

	public CCodeDefine.with_expression (string name, CCodeExpression expression) {
		this.name = name;
		this.value_expression = expression;
	}

	public override void write (CCodeWriter writer) {
		writer.write_indent ();
		writer.write_string ("#define ");
		writer.write_string (name);
		if (value != null) {
			writer.write_string (" ");
			writer.write_string (@value);
		} else if (value_expression != null) {
			writer.write_string (" ");
			value_expression.write_inner (writer);
		}
		writer.write_newline ();
	}
}
