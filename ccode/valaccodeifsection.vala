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
	 * The expression
	 */
	public string expression { get; set; }

	public CCodeIfSection (string expr) {
		expression = expr;
	}

	public override void write (CCodeWriter writer) {
		writer.write_string ("#if ");
		writer.write_string (expression);
		foreach (CCodeNode node in get_children ()) {
			node.write_combined (writer);
		}
		writer.write_string ("#endif");
		writer.write_newline ();
	}

	public override void write_declaration (CCodeWriter writer) {
	}
}
