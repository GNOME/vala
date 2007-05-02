/* valaccodeswitchstatement.vala
 *
 * Copyright (C) 2006  Jürg Billeter
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public
 * License as published by the Free Software Foundation; either
 * version 2 of the License, or (at your option) any later version.

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
 * Represents a switch selection statement in the C code.
 */
public class Vala.CCodeSwitchStatement : CCodeStatement {
	/**
	 * The switch expression.
	 */
	public CCodeExpression! expression { get; set construct; }
	
	private List<CCodeCaseStatement> case_statements;
	
	public CCodeSwitchStatement (CCodeExpression! expr) {
		expression = expr;
	}
	
	/**
	 * Adds the specified case statement to the list of switch sections.
	 *
	 * @param case_stmt a case statement
	 */
	public void add_case (CCodeCaseStatement! case_stmt) {
		case_statements.append (case_stmt);
	}
	
	public override void write (CCodeWriter! writer) {
		writer.write_indent ();
		writer.write_string ("switch (");
		expression.write (writer);
		writer.write_string (")");
		writer.write_begin_block ();
		
		foreach (CCodeCaseStatement case_stmt in case_statements) {
			case_stmt.write (writer);
		}
		
		writer.write_end_block ();
	}
}
