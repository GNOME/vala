/* valareferencetransferexpression.vala
 *
 * Copyright (C) 2007-2008  Jürg Billeter
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
 * Represents a reference transfer expression in the source code, e.g. `#foo'.
 */
public class Vala.ReferenceTransferExpression : Expression {
	/**
	 * The variable whose reference is to be transferred.
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
	 * Creates a new reference transfer expression.
	 *
	 * @param inner variable whose reference is to be transferred
	 * @return      newly created reference transfer expression
	 */
	public ReferenceTransferExpression (Expression inner, SourceReference? source_reference = null) {
		this.inner = inner;
		this.source_reference = source_reference;
	}
	
	public override void accept (CodeVisitor visitor) {
		visitor.visit_reference_transfer_expression (this);

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
		return false;
	}
}
