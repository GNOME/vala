/* valatuple.vala
 *
 * Copyright (C) 2006-2010  Jürg Billeter
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
 * Represents a fixed-length sequence of expressions in the source code.
 */
public class Vala.Tuple : Expression {
	private List<Expression> expression_list = new ArrayList<Expression> ();

	public Tuple (SourceReference? source_reference = null) {
		this.source_reference = source_reference;
	}

	public override void accept_children (CodeVisitor visitor) {
		foreach (Expression expr in expression_list) {
			expr.accept (visitor);
		}
	}

	public override void accept (CodeVisitor visitor) {
		visitor.visit_tuple (this);

		visitor.visit_expression (this);
	}

	public void add_expression (Expression expr) {
		expression_list.add (expr);
	}

	public List<Expression> get_expressions () {
		return expression_list;
	}

	public override bool is_pure () {
		return false;
	}

	public override void replace_expression (Expression old_node, Expression new_node) {
		for (int i = 0; i < expression_list.size; i++) {
			if (expression_list[i] == old_node) {
				expression_list[i] = new_node;
			}
		}
	}

	public override bool check (CodeContext context) {
		if (checked) {
			return !error;
		}

		checked = true;

		if (context.profile != Profile.DOVA) {
			Report.error (source_reference, "tuples are not supported");
			error = true;
			return false;
		}

		value_type = new ObjectType ((Class) context.root.scope.lookup ("Dova").scope.lookup ("Tuple"));
		value_type.value_owned = true;

		foreach (var expr in expression_list) {
			if (!expr.check (context)) {
				return false;
			}
			value_type.add_type_argument (expr.value_type.copy ());
		}

		return !error;
	}

	public override void emit (CodeGenerator codegen) {
		foreach (Expression expr in expression_list) {
			expr.emit (codegen);
		}

		codegen.visit_tuple (this);

		codegen.visit_expression (this);
	}
}
