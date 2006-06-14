/* valamemorymanager.vala
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
	public class MemoryManager : CodeVisitor {
		public void analyze (CodeContext! context) {
			context.accept (this);
		}
		
		private void visit_possibly_leaked_expression (Expression expr) {
			if (expr.static_type != null &&
			    expr.static_type.is_ref) {
				/* mark reference as leaked */
				expr.ref_leaked = true;
			}
		}

		public override void visit_expression_statement (ExpressionStatement stmt) {
			visit_possibly_leaked_expression (stmt.expression);
		}

		public override void visit_member_access (MemberAccess expr) {
			visit_possibly_leaked_expression (expr.inner);
		}

		public override void visit_invocation_expression (InvocationExpression expr) {
			foreach (Expression arg in expr.argument_list) {
				visit_possibly_leaked_expression (arg);
			}
		}

		public override void visit_binary_expression (BinaryExpression expr) {
			visit_possibly_leaked_expression (expr.left);
			visit_possibly_leaked_expression (expr.right);
		}
	}
}
