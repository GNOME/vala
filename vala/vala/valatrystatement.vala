/* valatrystatement.vala
 *
 * Copyright (C) 2007  Jürg Billeter
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
 * Represents a try statement in the source code.
 */
public class Vala.TryStatement : Statement {
	/**
	 * Specifies the body of the try statement.
	 */
	public Block! body { get; set construct; }

	/**
	 * Specifies the body of the optional finally clause.
	 */
	public Block finally_body { get; set; }

	private List<CatchClause> catch_clauses;

	/**
	 * Creates a new try statement.
	 *
	 * @param body             body of the try statement
	 * @param finally_body     body of the optional finally clause
	 * @param source_reference reference to source code
	 * @return                 newly created try statement
	 */
	public TryStatement (construct Block! body, construct Block finally_body, construct SourceReference source_reference = null) {
	}
	
	/**
	 * Appends the specified clause to the list of catch clauses.
	 *
	 * @param clause a catch clause
	 */
	public void add_catch_clause (CatchClause! clause) {
		catch_clauses.append (clause);
	}
	
	public override void accept (CodeVisitor! visitor) {
		visitor.visit_begin_try_statement (this);

		visitor.visit_end_try_statement (this);
	}
}
