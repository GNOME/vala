/* valaccodevariabledeclarator.vala
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
 * Represents a variable declarator in the C code.
 */
public class Vala.CCodeVariableDeclarator : CCodeDeclarator {
	/**
	 * The variable name.
	 */
	public string name { get; set; }

	/**
	 * The optional initializer expression.
	 */
	public CCodeExpression? initializer { get; set; }

	/**
	 * The optional declarator suffix.
	 */
	public CCodeDeclaratorSuffix? declarator_suffix { get; set; }

	/**
	 * Initializer only used to zero memory, safe to initialize as part
	 * of declaration at beginning of block instead of separate assignment.
	 */
	public bool init0 { get; set; }

	public CCodeVariableDeclarator (string name, CCodeExpression? initializer = null, CCodeDeclaratorSuffix? declarator_suffix = null) {
		this.name = name;
		this.initializer = initializer;
		this.declarator_suffix = declarator_suffix;
	}

	public CCodeVariableDeclarator.zero (string name, CCodeExpression? initializer, CCodeDeclaratorSuffix? declarator_suffix = null) {
		this.name = name;
		this.initializer = initializer;
		this.declarator_suffix = declarator_suffix;
		this.init0 = true;
	}

	public override void write (CCodeWriter writer) {
		writer.write_string (name);

		if (declarator_suffix != null) {
			declarator_suffix.write (writer);
		}

		if (initializer != null) {
			writer.write_string (" = ");
			initializer.write (writer);
		}
	}

	public override void write_declaration (CCodeWriter writer) {
		writer.write_string (name);

		if (declarator_suffix != null) {
			declarator_suffix.write (writer);
		}

		if (initializer != null && init0) {
			writer.write_string (" = ");
			initializer.write (writer);
		}
	}

	public override void write_initialization (CCodeWriter writer) {
		if (initializer != null && !init0) {
			writer.write_indent (line);

			writer.write_string (name);
			writer.write_string (" = ");
			initializer.write (writer);

			writer.write_string (";");
			writer.write_newline ();
		}
	}
}

public class Vala.CCodeDeclaratorSuffix {
	bool array;
	List<CCodeExpression>? array_length;

	public CCodeDeclaratorSuffix.with_array (CCodeExpression? array_length = null) {
		if (array_length != null) {
			this.array_length = new ArrayList<CCodeExpression> ();
			this.array_length.add (array_length);
		}
		array = true;
	}

	public CCodeDeclaratorSuffix.with_multi_array (List<CCodeExpression>? array_length = null) {
		this.array_length = array_length;
		array = true;
	}

	public void write (CCodeWriter writer) {
		if (array_length != null && array_length.size > 0) {
			foreach (var length in array_length) {
				writer.write_string ("[");
				if (length != null) {
					length.write (writer);
				}
				writer.write_string ("]");
			}
		} else if (array) {
			writer.write_string ("[]");
		}
	}
}
