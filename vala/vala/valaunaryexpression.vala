/* valaunaryexpression.vala
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
 * Represents an expression with one operand in the source code.
 *
 * Supports +, -, !, ~, ref, out.
 */
public class Vala.UnaryExpression : Expression {
	/**
	 * The unary operator.
	 */
	public UnaryOperator operator { get; set; }

	/**
	 * The operand.
	 */
	public Expression! inner { get; set construct; }
	
	/**
	 * Creates a new unary expression.
	 *
	 * @param op     unary operator
	 * @param inner  operand
	 * @param source reference to source code
	 * @return       newly created binary expression
	 */
	public static ref UnaryExpression! new (UnaryOperator op, Expression! inner, SourceReference source) {
		return (new UnaryExpression (operator = op, inner = inner, source_reference = source));
	}
	
	public override void accept (CodeVisitor! visitor) {
		inner.accept (visitor);
	
		visitor.visit_unary_expression (this);
	}
}

public enum Vala.UnaryOperator {
	PLUS,
	MINUS,
	LOGICAL_NEGATION,
	BITWISE_COMPLEMENT,
	REF,
	OUT
}
