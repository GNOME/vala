/* valaparenthesizedexpression.vala
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
 * Represents a parenthesized expression in the source code.
 */
public class Vala.ParenthesizedExpression : Expression {
	/**
	 * The inner expression.
	 */
	public Expression inner {
		get {
			return _inner;
		}
		set {
			_inner = value;
			_inner.parent_node = this;
		}
	}

	private Expression _inner;

	/**
	 * Creates a new parenthesized expression.
	 *
	 * @param inner  an expression
	 * @param source reference to source code
	 * @return       newly created parenthesized expression
	 */
	public ParenthesizedExpression (Expression _inner, SourceReference? source) {
		inner = _inner;
		source_reference = source;
	}
	
	public override void accept (CodeVisitor visitor) {
		visitor.visit_parenthesized_expression (this);

		visitor.visit_expression (this);
	}

	public override void accept_children (CodeVisitor visitor) {
		inner.accept (visitor);
	}

	public override void replace_expression (Expression old_node, Expression new_node) {
		if (inner == old_node) {
			inner = new_node;
		}
	}

	public override bool is_pure () {
		return inner.is_pure ();
	}

	public override bool check (SemanticAnalyzer analyzer) {
		if (checked) {
			return !error;
		}

		checked = true;

		inner.target_type = target_type;

		accept_children (analyzer);

		if (inner.error) {
			// ignore inner error
			error = true;
			return false;
		}

		if (inner.value_type == null) {
			// static type may be null for method references
			error = true;
			Report.error (inner.source_reference, "Invalid expression type");
			return false;
		}

		value_type = inner.value_type.copy ();
		// don't call g_object_ref_sink on inner and outer expression
		value_type.floating_reference = false;

		// don't transform expression twice
		inner.target_type = inner.value_type.copy ();

		return !error;
	}
}
