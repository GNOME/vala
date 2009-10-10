/* valatemplate.vala
 *
 * Copyright (C) 2009  Jürg Billeter
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

using Gee;

public class Vala.Template : Expression {
	private Gee.List<Expression> expression_list = new ArrayList<Expression> ();

	public Template () {
	}

	public void add_expression (Expression expr) {
		expression_list.add (expr);
	}

	public Gee.List<Expression> get_expressions () {
		return expression_list;
	}

	public override bool is_pure () {
		return false;
	}

	Expression stringify (Expression expr) {
		if (expr is StringLiteral) {
			return expr;
		} else {
			return new MethodCall (new MemberAccess (expr, "to_string", expr.source_reference), expr.source_reference);
		}
	}

	public override bool check (SemanticAnalyzer analyzer) {
		if (checked) {
			return !error;
		}

		checked = true;

		Expression expr;

		if (expression_list.size == 0) {
			expr = new StringLiteral ("\"\"", source_reference);
		} else {
			expr = stringify (expression_list[0]);
			if (expression_list.size > 1) {
				var concat = new MethodCall (new MemberAccess (expr, "concat", source_reference), source_reference);
				for (int i = 1; i < expression_list.size; i++) {
					concat.add_argument (stringify (expression_list[i]));
				}
				expr = concat;
			}
		}

		analyzer.replaced_nodes.add (this);
		parent_node.replace_expression (this, expr);
		return expr.check (analyzer);
	}
}

