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
		Symbol current_symbol;

		public void analyze (CodeContext! context) {
			context.accept (this);
		}
		
		private void visit_possibly_leaked_expression (Expression! expr) {
			if (expr.static_type != null &&
			    expr.static_type.is_ref) {
				/* mark reference as leaked */
				expr.ref_leaked = true;
			}
		}

		private void visit_possibly_missing_copy_expression (Expression! expr) {
			if (expr.static_type != null &&
			    !expr.static_type.is_ref) {
				/* mark reference as missing */
				expr.ref_missing = true;
			}
		}

		public override void visit_begin_method (Method! m) {
			current_symbol = m.symbol;
		}

		public override void visit_expression_statement (ExpressionStatement! stmt) {
			visit_possibly_leaked_expression (stmt.expression);
		}

		public override void visit_return_statement (ReturnStatement! stmt) {
			if (stmt.return_expression != null) {
				var m = (Method) current_symbol.node;
				
				if (m.return_type.is_ref) {
					visit_possibly_missing_copy_expression (stmt.return_expression);
				} else {
					visit_possibly_leaked_expression (stmt.return_expression);
				}
			}
		}

		public override void visit_member_access (MemberAccess! expr) {
			visit_possibly_leaked_expression (expr.inner);
		}

		public override void visit_invocation_expression (InvocationExpression! expr) {
			var m = (Method) expr.call.symbol_reference.node;
			var params = m.get_parameters ();
			foreach (Expression arg in expr.argument_list) {
				if (params != null) {
					var param = (FormalParameter) params.data;
					if (!param.ellipsis
					    && ((param.type_reference.type != null
					    && param.type_reference.type.is_reference_type ())
					    || param.type_reference.type_parameter != null)) {
						if (param.type_reference.is_ref) {
							visit_possibly_missing_copy_expression (arg);
						} else {
							visit_possibly_leaked_expression (arg);
						}
					}

					params = params.next;
				} else {
					visit_possibly_leaked_expression (arg);
				}
			}
		}

		public override void visit_binary_expression (BinaryExpression! expr) {
			visit_possibly_leaked_expression (expr.left);
			visit_possibly_leaked_expression (expr.right);
		}

		public override void visit_assignment (Assignment! a) {
			if (a.left.static_type.is_lvalue_ref) {
				visit_possibly_missing_copy_expression (a.right);
			} else {
				visit_possibly_leaked_expression (a.right);
			}
		}
	}
}
