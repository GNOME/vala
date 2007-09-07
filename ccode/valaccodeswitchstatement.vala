/* valaccodeswitchstatement.vala
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
using Gee;

/**
 * Represents a switch selection statement in the C code.
 */
public class Vala.CCodeSwitchStatement : CCodeStatement {
	/**
	 * The switch expression.
	 */
	public CCodeExpression! expression { get; set; }
	
	private Gee.List<CCodeCaseStatement> case_statements = new ArrayList<CCodeCaseStatement> ();
	private Gee.List<CCodeStatement> default_statements = new ArrayList<CCodeStatement> ();
	
	public CCodeSwitchStatement (construct CCodeExpression! expression) {
	}
	
	/**
	 * Adds the specified case statement to the list of switch sections.
	 *
	 * @param case_stmt a case statement
	 */
	public void add_case (CCodeCaseStatement! case_stmt) {
		case_statements.add (case_stmt);
	}

	/**
	 * Append the specified statement to the default clause.
	 *
	 * @param stmt a statement
	 */
	public void add_default_statement (CCodeStatement! stmt) {
		default_statements.add (stmt);
	}

	public override void write (CCodeWriter! writer) {
		writer.write_indent (line);
		writer.write_string ("switch (");
		expression.write (writer);
		writer.write_string (")");
		writer.write_begin_block ();
		
		foreach (CCodeCaseStatement case_stmt in case_statements) {
			case_stmt.write (writer);
		}

		if (default_statements.size > 0) {
			writer.write_indent ();
			writer.write_string ("default:");
			writer.write_newline ();

			foreach (CCodeStatement stmt in default_statements) {
				stmt.write (writer);
			}
		}

		writer.write_end_block ();
	}
}
