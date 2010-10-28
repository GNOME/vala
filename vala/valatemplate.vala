/* valatemplate.vala
 *
 * Copyright (C) 2009-2010  Jürg Billeter
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


public class Vala.Template : Expression {
	private List<Expression> expression_list = new ArrayList<Expression> ();

	public Template (SourceReference? source_reference = null) {
		this.source_reference = source_reference;
	}

	public override void accept (CodeVisitor visitor) {
		visitor.visit_template (this);
	}

	public override void accept_children (CodeVisitor visitor) {
		foreach (var expr in expression_list) {
			expr.accept (visitor);
		}
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

	Expression stringify (Expression expr) {
		if (expr is StringLiteral) {
			return expr;
		} else {
			return new MethodCall (new MemberAccess (expr, "to_string", expr.source_reference), expr.source_reference);
		}
	}

	public override bool check (CodeContext context) {
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
				if (context.profile == Profile.DOVA) {
					// varargs concat not yet supported
					for (int i = 1; i < expression_list.size; i++) {
						expr = new BinaryExpression (BinaryOperator.PLUS, expr, stringify (expression_list[i]), source_reference);
					}
				} else {
					var concat = new MethodCall (new MemberAccess (expr, "concat", source_reference), source_reference);
					for (int i = 1; i < expression_list.size; i++) {
						concat.add_argument (stringify (expression_list[i]));
					}
					expr = concat;
				}
			}
		}
		expr.target_type = target_type;

		context.analyzer.replaced_nodes.add (this);
		parent_node.replace_expression (this, expr);
		return expr.check (context);
	}
}

