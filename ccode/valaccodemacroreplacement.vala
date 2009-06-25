/* valaccodemacroreplacement.vala
 *
 * Copyright (C) 2006-2009  Jürg Billeter
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
	public string name { get; set; }

	/**
	 * The replacement of this macro.
	 */
	public string replacement { get; set; }

	/**
	 * The replacement expression of this macro.
	 */
	public CCodeExpression replacement_expression { get; set; }

	public CCodeMacroReplacement (string name, string replacement) {
		this.replacement = replacement;
		this.name = name;
	}

	public CCodeMacroReplacement.with_expression (string name, CCodeExpression replacement_expression) {
		this.name = name;
		this.replacement_expression = replacement_expression;
	}

	public override void write (CCodeWriter writer) {
		writer.write_indent ();
		writer.write_string ("#define ");
		writer.write_string (name);
		writer.write_string (" ");
		if (replacement != null) {
			writer.write_string (replacement);
		} else {
			replacement_expression.write_inner (writer);
		}
		writer.write_newline ();
	}
}
