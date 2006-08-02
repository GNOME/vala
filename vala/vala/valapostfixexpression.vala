/* valapostfixexpression.vala
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
 * Represents a postfix increment or decrement expression.
 */
public class Vala.PostfixExpression : Expression {
	/**
	 * The operand, must be a variable or a property.
	 */
	public Expression! inner { get; set construct; }
	
	/**
	 * Specifies whether value should be incremented or decremented.
	 */
	public bool increment { get; set; }

	/**
	 * Creates a new postfix expression.
	 *
	 * @param inner  operand expression
	 * @param inc    true for increment, false for decrement
	 * @param source reference to source code
	 * @return newly created postfix expression
	 */
	public construct (Expression! _inner, bool inc, SourceReference source) {
		inner = _inner;
		increment = inc;
		source_reference = source;
	}
	
	public override void accept (CodeVisitor! visitor) {
		inner.accept (visitor);

		visitor.visit_postfix_expression (this);
	}
}
