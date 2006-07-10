/* valaintegerliteral.vala
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
 * Represents an integer literal in the source code.
 */
public class Vala.IntegerLiteral : Literal {
	/**
	 * The literal value.
	 */
	public string! value { get; set; }

	/**
	 * Creates a new integer literal.
	 *
	 * @param i      literal value
	 * @param source reference to source code
	 * @return       newly created integer literal
	 */
	public static ref IntegerLiteral! new (string! i, SourceReference source) {
		return (new IntegerLiteral (value = i, source_reference = source));
	}
	
	public override void accept (CodeVisitor! visitor) {
		visitor.visit_integer_literal (this);
	}
}
