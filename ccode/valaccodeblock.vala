/* valaccodeblock.vala
 *
 * Copyright (C) 2006-2008  Jürg Billeter
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
 * Represents a C code block.
 */
public class Vala.CCodeBlock : CCodeStatement {
	/**
	 * Specifies whether a newline at the end of the block should be
	 * suppressed.
	 */
	public bool suppress_newline { get; set; }

	private List<CCodeNode> statements = new ArrayList<CCodeNode> ();

	/**
	 * Prepend the specified statement to the list of statements.
	 */
	public void prepend_statement (CCodeNode statement) {
		statements.insert (0, statement);
	}

	/**
	 * Append the specified statement to the list of statements.
	 */
	public void add_statement (CCodeNode statement) {
		/* allow generic nodes to include comments */
		statements.add (statement);
	}

	public override void write (CCodeWriter writer) {
		// the last reachable statement
		CCodeNode last_statement = null;

		writer.write_begin_block ();
		foreach (CCodeNode statement in statements) {
			statement.write_declaration (writer);

			// determine last reachable statement
			if (statement is CCodeLabel || statement is CCodeCaseStatement) {
				last_statement = null;
			} else if (statement is CCodeReturnStatement || statement is CCodeGotoStatement
			|| statement is CCodeContinueStatement || statement is CCodeBreakStatement) {
				last_statement = statement;
			}
		}

		foreach (CCodeNode statement in statements) {
			statement.write (writer);

			// only output reachable code
			if (statement == last_statement) {
				break;
			}
		}

		writer.write_end_block ();

		if (!suppress_newline) {
			writer.write_newline ();
		}
	}
}
