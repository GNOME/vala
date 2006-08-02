/* valaifstatement.vala
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
 * Represents an if selection statement in the source code.
 */
public class Vala.IfStatement : Statement {
	/**
	 * The boolean condition to evaluate.
	 */
	public Expression! condition { get; set construct; }
	
	/**
	 * The statement to be evaluated if the condition holds.
	 */
	public Block! true_statement { get; set construct; }
	
	/**
	 * The optional statement to be evaluated if the condition doesn't hold.
	 */
	public Block false_statement { get; set construct; }

	/**
	 * Creates a new if statement.
	 *
	 * @param cond       a boolean condition
	 * @param true_stmt  statement to be evaluated if condition is true
	 * @param false_stmt statement to be evaluated if condition is false
	 * @return           newly created if statement
	 */
	public construct (Expression! cond, Block! true_stmt, Block false_stmt, SourceReference source) {
		condition = cond;
		true_statement = true_stmt;
		false_statement = false_stmt;
		source_reference = source;
	}
	
	public override void accept (CodeVisitor! visitor) {
		condition.accept (visitor);
		
		visitor.visit_end_full_expression (condition);
		
		true_statement.accept (visitor);
		if (false_statement != null) {
			false_statement.accept (visitor);
		}

		visitor.visit_if_statement (this);
	}
}
