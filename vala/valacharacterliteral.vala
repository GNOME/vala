/* valacharacterliteral.vala
 *
 * Copyright (C) 2006-2010  Jürg Billeter
 * Copyright (C) 2006-2009  Raffaele Sandrini
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
 *	Raffaele Sandrini <raffaele@sandrini.ch>
 */

using GLib;

/**
 * Represents a single literal character.
 */
public class Vala.CharacterLiteral : Literal {
	/**
	 * The literal value.
	 */
	public string value {
		get {
			return _value;
		}
		set {
			_value = value;
			
			if (!value.validate ()) {
				error = true;
			}
		}
	}
	
	private string _value;

	/**
	 * Creates a new character literal.
	 *
	 * @param c      character
	 * @param source reference to source code
	 * @return       newly created character literal
	 */
	public CharacterLiteral (string c, SourceReference? source = null) {
		value = c;
		source_reference = source;

	}

	public override void accept (CodeVisitor visitor) {
		visitor.visit_character_literal (this);

		visitor.visit_expression (this);
	}
	
	/**
	 * Returns the unicode character value this character literal
	 * represents.
	 *
	 * @return unicode character value
	 */
	public unichar get_char () {
		return value.next_char ().get_char ();
	}

	public override bool is_pure () {
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

		if (context.profile == Profile.DOVA) {
			value_type = new IntegerType ((Struct) context.analyzer.root_symbol.scope.lookup ("char"), get_char ().to_string (), "int");
		} else {
			if (get_char () < 128) {
				value_type = new IntegerType ((Struct) context.analyzer.root_symbol.scope.lookup ("char"));
			} else {
				value_type = new IntegerType ((Struct) context.analyzer.root_symbol.scope.lookup ("unichar"));
			}
		}

		return !error;
	}

	public override void emit (CodeGenerator codegen) {
		codegen.visit_character_literal (this);

		codegen.visit_expression (this);
	}
}
