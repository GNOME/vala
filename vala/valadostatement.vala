/* valadostatement.vala
 *
 * Copyright (C) 2006-2009  Jürg Billeter
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
 * Represents a do iteration statement in the source code.
 */
public class Vala.DoStatement : BaseStatement {
	/**
	 * Specifies the loop body.
	 */
	public Block body {
		get {
			return _body;
		}
		private set {
			_body = value;
			_body.parent_node = this;
		}
	}

	/**
	 * Specifies the loop condition.
	 */
	public Expression condition {
		get {
			return _condition;
		}
		private set {
			_condition = value;
			_condition.parent_node = this;
		}
	}

	private Expression _condition;
	private Block _body;

	/**
	 * Creates a new do statement.
	 *
	 * @param body              loop body
	 * @param condition         loop condition
	 * @param source_reference  reference to source code
	 * @return                  newly created do statement
	 */
	public DoStatement (Block body, Expression condition, SourceReference? source_reference = null) {
		this.condition = condition;
		this.source_reference = source_reference;
		this.body = body;
	}

	public override void accept (CodeVisitor visitor) {
		visitor.visit_do_statement (this);
	}

	public override void accept_children (CodeVisitor visitor) {
		body.accept (visitor);

		condition.accept (visitor);

		visitor.visit_end_full_expression (condition);
	}

	public override void replace_expression (Expression old_node, Expression new_node) {
		if (condition == old_node) {
			condition = new_node;
		}
	}

	public override bool check (CodeContext context) {
		if (checked) {
			return !error;
		}

		checked = true;

		condition.target_type = context.analyzer.bool_type.copy ();

		condition.check (context);

		if (condition.error) {
			/* if there was an error in the condition, skip this check */
			error = true;
			return false;
		}

		if (condition.value_type == null || !condition.value_type.compatible (context.analyzer.bool_type)) {
			error = true;
			Report.error (condition.source_reference, "Condition must be boolean");
			return false;
		}

		if (!body.check (context)) {
			error = true;
			return false;
		}

		return !error;
	}
}
