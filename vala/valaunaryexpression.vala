/* valaunaryexpression.vala
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
	public Expression inner {
		get {
			return _inner;
		}
		set construct {
			_inner = value;
			_inner.parent_node = this;
		}
	}
	
	private Expression _inner;

	/**
	 * Creates a new unary expression.
	 *
	 * @param op     unary operator
	 * @param inner  operand
	 * @param source reference to source code
	 * @return       newly created binary expression
	 */
	public UnaryExpression (UnaryOperator op, Expression _inner, SourceReference source) {
		operator = op;
		inner = _inner;
		source_reference = source;
	}
	
	public override void accept (CodeVisitor visitor) {
		inner.accept (visitor);
	
		visitor.visit_unary_expression (this);

		visitor.visit_expression (this);
	}

	public override void replace_expression (Expression old_node, Expression new_node) {
		if (inner == old_node) {
			inner = new_node;
		}
	}

	private string get_operator_string () {
		switch (_operator) {
		case UnaryOperator.PLUS: return "+";
		case UnaryOperator.MINUS: return "-";
		case UnaryOperator.LOGICAL_NEGATION: return "!";
		case UnaryOperator.BITWISE_COMPLEMENT: return "~";
		case UnaryOperator.INCREMENT: return "++";
		case UnaryOperator.DECREMENT: return "--";
		case UnaryOperator.REF: return "ref ";
		case UnaryOperator.OUT: return "out ";
		}

		assert_not_reached ();
	}

	public override string to_string () {
		return get_operator_string () + _inner.to_string ();
	}

	public override bool is_pure () {
		if (operator == UnaryOperator.INCREMENT || operator == UnaryOperator.DECREMENT) {
			return false;
		}

		return inner.is_pure ();
	}
}

public enum Vala.UnaryOperator {
	NONE,
	PLUS,
	MINUS,
	LOGICAL_NEGATION,
	BITWISE_COMPLEMENT,
	INCREMENT,
	DECREMENT,
	REF,
	OUT
}
