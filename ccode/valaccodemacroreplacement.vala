/* valaccodemacroreplacement.vala
 *
 * Copyright (C) 2006-2007  Jürg Billeter
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
 * Represents a preprocessor macro replacement definition in the C code.
 */
public class Vala.CCodeMacroReplacement : CCodeNode {
	/**
	 * The name of this macro.
	 */
	public string name { get; set construct; }

	/**
	 * The replacement of this macro.
	 */
	public string replacement { get; set; }

	/**
	 * The replacement expression of this macro.
	 */
	public CCodeExpression replacement_expression { get; set; }

	public CCodeMacroReplacement (construct string name, construct string replacement) {
	}

	public CCodeMacroReplacement.with_expression (construct string name, construct CCodeExpression replacement_expression) {
	}

	public override void write (CCodeWriter writer) {
		writer.write_indent ();
		writer.write_string ("#define ");
		writer.write_string (name);
		writer.write_string (" ");
		if (replacement != null) {
			writer.write_string (replacement);
		} else {
			replacement_expression.write (writer);
		}
		writer.write_newline ();
	}
}
