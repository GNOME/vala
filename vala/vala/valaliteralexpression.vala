/* valaliteralexpression.vala
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
 * Represents a literal expression in the source code.
 */
public class Vala.LiteralExpression : Expression {
	/**
	 * The literal.
	 */
	public Literal literal { get; construct; }

	/**
	 * Creates a new literal expression.
	 *
	 * @param literal a literal
	 * @param source  reference to source code
	 * @return        newly created literal expression
	 */
	public construct (Literal! _literal, SourceReference source = null) {
		literal = _literal;
		source_reference = source;
	}
	
	public override void accept (CodeVisitor! visitor) {
		literal.accept (visitor);
	
		visitor.visit_literal_expression (this);
	}

	public override ref string! to_string () {
		return literal.to_string ();
	}
}
