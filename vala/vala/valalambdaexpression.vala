/* valalambdaexpression.vala
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
	public class LambdaExpression : Expression {
		public List<string> parameters { get; set; }
		public Expression inner { get; set; }
		
		/* generated anonymous method */
		public Method method;
		
		public static ref LambdaExpression new (List<String> params, Expression! inner, SourceReference source) {
			return new LambdaExpression (parameters = params, inner = inner, source_reference = source);
		}
		
		public void add_parameter (string! param) {
			_parameters.append (param);
		}
		
		public override void accept (CodeVisitor! visitor) {
			visitor.visit_begin_lambda_expression (this);

			inner.accept (visitor);
			visitor.visit_end_full_expression (inner);

			visitor.visit_end_lambda_expression (this);
			
			if (method != null) {
				method.accept (visitor);
			}
		}
	}
}
