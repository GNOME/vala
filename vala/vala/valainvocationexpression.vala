/* valainvocationexpression.vala
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
	public class InvocationExpression : Expression {
		public Expression call { get; construct; }
		public List<Expression> argument_list { get; construct; }

		public static ref InvocationExpression new (Expression call, List<Expression> argument_list, SourceReference source) {
			return (new InvocationExpression (call = call, argument_list = argument_list, source_reference = source));
		}
		
		public void add_argument (Expression! arg) {
			_argument_list.append (arg);
		}
		
		public override void accept (CodeVisitor! visitor) {
			call.accept (visitor);

			visitor.visit_begin_invocation_expression (this);

			foreach (Expression expr in argument_list) {
				expr.accept (visitor);
			}

			visitor.visit_end_invocation_expression (this);
		}
	}
}
