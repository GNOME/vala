/* valadeletestatement.vala
 *
 * Copyright (C) 2008  Jürg Billeter
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
 * Represents a delete statement e.g. "delete a".
 */
public class Vala.DeleteStatement : CodeNode, Statement {
	/**
	 * Expression representing the instance to be freed.
	 */
	public Expression expression { get; set; }

	public DeleteStatement (Expression expression, SourceReference? source_reference = null) {
		this.expression = expression;
		this.source_reference = source_reference;
	}

	public override void accept (CodeVisitor visitor) {
		visitor.visit_delete_statement (this);
	}

	public override void accept_children (CodeVisitor visitor) {
		expression.accept (visitor);
	}

	public override bool check (SemanticAnalyzer analyzer) {
		if (checked) {
			return !error;
		}

		checked = true;

		accept_children (analyzer);

		if (expression.error) {
			// if there was an error in the inner expression, skip this check
			return false;
		}

		if (!(expression.value_type is PointerType)) {
			error = true;
			Report.error (source_reference, "delete operator not supported for `%s'".printf (expression.value_type.to_string ()));
		}

		return !error;
	}
}
