/* valaregexliteral.vala
 *
 * Copyright (C) 2010  Jukka-Pekka Iivonen
 * Copyright (C) 2010  Jürg Billeter
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
 * 	Jukka-Pekka Iivonen <jp0409@jippii.fi>
 */

using GLib;

/**
 * Represents a regular expression literal in the source code.
 */
public class Vala.RegexLiteral : Literal {
	/**
	 * The literal value.
	 */
	public string value { get; set; }

	/**
	 * Creates a new regular expression literal.
	 *
	 * @param s      the literal value
	 * @param source reference to source code
	 * @return       newly created string literal
	 */
	public RegexLiteral (string value, SourceReference? source_reference = null) {
		this.value = value;
		this.source_reference = source_reference;
	}

	public override void accept (CodeVisitor visitor) {
		visitor.visit_regex_literal (this);

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

		if (!context.experimental) {
			Report.warning (source_reference, "regular expression literals are experimental");
		}

		try {
			var regex = new GLib.Regex (value);
			if (regex != null) { /* Regex is valid. */ }
		} catch (RegexError err) {
			error = true;
			Report.error (source_reference, "Invalid regular expression `%s'.".printf (value));
			return false;
		}

		value_type = context.analyzer.regex_type.copy ();

		return !error;
	}

	public override void emit (CodeGenerator codegen) {
		codegen.visit_regex_literal (this);

		codegen.visit_expression (this);
	}
}

