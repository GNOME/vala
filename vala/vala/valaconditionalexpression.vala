/* valaconditionalexpression.vala
 *
 * Copyright (C) 2006  Jürg Billeter
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public
 * License as published by the Free Software Foundation; either
 * version 2 of the License, or (at your option) any later version.

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

namespace Vala {
	public class ConditionalExpression : Expression {
		public Expression condition { get; construct; }
		public Expression true_expression { get; construct; }
		public Expression false_expression { get; construct; }
		public SourceReference source_reference { get; construct; }
		
		public static ref ConditionalExpression new (Expression cond, Expression true_expr, Expression false_expr, SourceReference source) {
			return (new ConditionalExpression (condition = cond, true_expression = true_expr, false_expression = false_expr, source_reference = source));
		}
		
		public override void accept (CodeVisitor visitor) {
			condition.accept (visitor);
			true_expression.accept (visitor);
			false_expression.accept (visitor);			

			visitor.visit_conditional_expression (this);
		}
	}
}
