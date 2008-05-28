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
	public Expression inner {
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
	public DataType type_reference {
		get { return _data_type; }
		set {
			_data_type = value;
			_data_type.parent_node = this;
		}
	}

	/**
	 * Checked casts return NULL instead of raising an error.
	 */
	public bool is_silent_cast { get; set construct; }

	private Expression _inner;

	private DataType _data_type;

	/**
	 * Creates a new cast expression.
	 *
	 * @param inner expression to be cast
	 * @param type  target type
	 * @return      newly created cast expression
	 */
	public CastExpression (Expression inner, DataType type_reference, SourceReference source_reference, bool is_silent_cast) {
		this.type_reference = type_reference;
		this.source_reference = source_reference;
		this.is_silent_cast = is_silent_cast;
		this.inner = inner;
	}
	
	public override void accept (CodeVisitor visitor) {
		inner.accept (visitor);
		type_reference.accept (visitor);

		visitor.visit_cast_expression (this);

		visitor.visit_expression (this);
	}

	public override void replace_expression (Expression old_node, Expression new_node) {
		if (inner == old_node) {
			inner = new_node;
		}
	}

	public override bool is_pure () {
		return inner.is_pure ();
	}

	public override void replace_type (DataType old_type, DataType new_type) {
		if (type_reference == old_type) {
			type_reference = new_type;
		}
	}
}
