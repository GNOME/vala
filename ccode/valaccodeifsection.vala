/* valaccodeifsection.vala
 *
 * Copyright (C) 2013  Jürg Billeter
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
 * 	Marc-André Lurau <marcandre.lureau@redhat.com>
 */

using GLib;

/**
 * Represents a section that should be processed on condition.
 */
public class Vala.CCodeIfSection : CCodeFragment {
	/**
	 * The conditional expression, or null if there is no condition.
	 */
	public string? expression { get; set; }

	CCodeIfSection? else_section;
	bool is_else_section;

	public CCodeIfSection (string? expr) {
		expression = expr;
		is_else_section = false;
	}

	public unowned CCodeIfSection append_else (string? expr = null) {
		else_section = new CCodeIfSection (expr);
		else_section.is_else_section = true;
		return else_section;
	}

	public override void write (CCodeWriter writer) {
		if (is_else_section) {
			if (expression != null) {
				writer.write_string ("#elif ");
				writer.write_string (expression);
			} else {
				writer.write_string ("#else");
			}
		} else if (expression != null) {
			writer.write_string ("#if ");
			writer.write_string (expression);
		}
		writer.write_newline ();
		foreach (CCodeNode node in get_children ()) {
			node.write_combined (writer);
		}
		if (else_section != null) {
			else_section.write_combined (writer);
		} else {
			writer.write_string ("#endif");
			writer.write_newline ();
		}
	}

	public override void write_declaration (CCodeWriter writer) {
	}

	public override void write_combined (CCodeWriter writer) {
		write (writer);
	}
}
