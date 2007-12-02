/* valacastexpression.vala
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

/**
 * Represents a type cast in the source code.
 */
public class Vala.CastExpression : Expression {
	/**
	 * The expression to be cast.
	 */
	public Expression! inner {
		get {
			return _inner;
		}
		set construct {
			_inner = value;
			_inner.parent_node = this;
		}
	}
	
	/**
	 * The target type.
	 */
	public DataType! type_reference { get; set construct; }

	/**
	 * Checked casts return NULL instead of raising an error.
	 */
	public bool is_silent_cast { get; set construct; }

	private Expression! _inner;

	/**
	 * Creates a new cast expression.
	 *
	 * @param inner expression to be cast
	 * @param type  target type
	 * @return      newly created cast expression
	 */
	public CastExpression (construct Expression! inner, construct DataType! type_reference, construct SourceReference source_reference, construct bool is_silent_cast) {
	}
	
	public override void accept (CodeVisitor! visitor) {
		inner.accept (visitor);
		type_reference.accept (visitor);

		visitor.visit_cast_expression (this);
	}

	public override void replace (CodeNode! old_node, CodeNode! new_node) {
		if (inner == old_node) {
			inner = (Expression) new_node;
		}
	}

	public override bool is_pure () {
		return inner.is_pure ();
	}
}
