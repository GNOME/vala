/* valaforstatement.vala
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
	public class ForStatement : Statement {
		public readonly ref List<ref Expression> initializer;
		public readonly Expression# condition;
		public readonly ref List<ref Expression> iterator;
		public readonly Statement# body;
		public readonly SourceReference# source_reference;

		public static ForStatement# @new (List<StatementExpression> init, Expression cond, List<StatementExpression> iter, Statement body, SourceReference source) {
			return (new ForStatement (initializer = init, condition = cond, iterator = iter, body = body, source_reference = source));
		}
		
		public override void accept (CodeVisitor visitor) {
			foreach (Expression init_expr in initializer) {
				init_expr.accept (visitor);
			}
			condition.accept (visitor);
			foreach (Expression it_expr in iterator) {
				it_expr.accept (visitor);
			}
			body.accept (visitor);

			visitor.visit_for_statement (this);
		}
	}
}
