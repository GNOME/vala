/* valaccodepragma.vala
 *
 * Copyright (C) 2024  Rico Tzschichholz
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

using GLib;

/**
 * Represents a pragma in the C code.
 */
public class Vala.CCodePragma : CCodeNode {
	/**
	 * The prefix of this pragma.
	 */
	public string prefix { get; set; }

	/**
	 * The directive of this pragma.
	 */
	public string directive { get; set; }

	/**
	 * The value of this pragma.
	 */
	public string? value { get; set; }

	public CCodePragma (string prefix, string directive, string? value = null) {
		this.prefix = prefix;
		this.directive = directive;
		this.value = value;
	}

	public override void write (CCodeWriter writer) {
		writer.write_indent ();
		writer.write_string ("#pragma ");
		writer.write_string (prefix);
		writer.write_string (" ");
		writer.write_string (directive);
		if (value != null) {
			writer.write_string (" ");
			writer.write_string (@value);
		}
		writer.write_newline ();
	}
}
