/* valastringliteral.vala
 *
 * Copyright (C) 2006-2011  Jürg Billeter
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
 * Represents a string literal in the source code.
 */
public class Vala.StringLiteral : Literal {
	/**
	 * The literal value.
	 */
	public string value { get; set; }

	public bool translate { get; set; }

	/**
	 * Creates a new string literal.
	 *
	 * @param s      the literal value
	 * @param source reference to source code
	 * @return       newly created string literal
	 */
	public StringLiteral (string value, SourceReference? source_reference = null) {
		this.value = value;
		this.source_reference = source_reference;
	}

	/**
	 * Evaluates the literal string value.
	 *
	 * @return the unescaped string
	 */	
	public string? eval () {
		if (value == null) {
			return null;
		}
		
		/* remove quotes */
		var noquotes = value.substring (1, (uint) (value.length - 2));
		/* unescape string */
		return noquotes.compress ();
	}
	
	public override void accept (CodeVisitor visitor) {
		visitor.visit_string_literal (this);

		visitor.visit_expression (this);
	}

	public override bool is_pure () {
		return true;
	}

	public override bool is_non_null () {
		return true;
	}

	public override string to_string () {
		return value;
	}

	public override bool check (CodeContext context) {
		if (checked) {
			return !error;
		}

		checked = true;

		value_type = context.analyzer.string_type.copy ();

		return !error;
	}

	public override void emit (CodeGenerator codegen) {
		codegen.visit_string_literal (this);

		codegen.visit_expression (this);
	}
}
