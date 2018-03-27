/* valaccodedostatement.vala
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
 * Represents a do iteration statement in the C code.
 */
public class Vala.CCodeDoStatement : CCodeStatement {
	/**
	 * The loop body.
	 */
	public CCodeStatement body { get; set; }

	/**
	 * The loop condition.
	 */
	public CCodeExpression condition { get; set; }

	public CCodeDoStatement (CCodeStatement stmt, CCodeExpression cond) {
		body = stmt;
		condition = cond;
	}

	public override void write (CCodeWriter writer) {
		writer.write_indent (line);
		writer.write_string ("do");

		/* while shouldn't be on a separate line */
		if (body is CCodeBlock) {
			var cblock = (CCodeBlock) body;
			cblock.suppress_newline = true;
		}

		body.write (writer);

		writer.write_string (" while (");

		condition.write (writer);

		writer.write_string (");");
	}
}
