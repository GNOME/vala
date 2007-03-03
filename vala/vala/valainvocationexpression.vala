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

/**
 * Represents an invocation expression in the source code.
 */
public class Vala.InvocationExpression : Expression {
	/**
	 * The method to call.
	 */
	public Expression! call {
		get {
			return _call;
		}
		set construct {
			_call = value;
			_call.parent_node = this;
		}
	}

	public Expression! _call;
	
	private List<Expression> argument_list;

	/**
	 * Creates a new invocation expression.
	 *
	 * @param call   method to call
	 * @param source reference to source code
	 * @return       newly created invocation expression
	 */
	public InvocationExpression (Expression! _call, SourceReference source = null) {
		call = _call;
		source_reference = source;
	}
	
	/**
	 * Appends the specified expression to the list of arguments.
	 *
	 * @param arg an argument
	 */
	public void add_argument (Expression! arg) {
		argument_list.append (arg);
		arg.parent_node = this;
	}
	
	/**
	 * Returns a copy of the argument list.
	 *
	 * @return argument list
	 */
	public ref List<weak Expression> get_argument_list () {
		return argument_list.copy ();
	}
	
	public override void accept (CodeVisitor! visitor) {
		call.accept (visitor);

		visitor.visit_begin_invocation_expression (this);

		// iterate over list copy as list may change in loop body
		foreach (Expression expr in argument_list.copy ()) {
			expr.accept (visitor);
		}

		visitor.visit_end_invocation_expression (this);
	}

	public override void replace (CodeNode! old_node, CodeNode! new_node) {
		if (call == old_node) {
			call = (Expression) new_node;
		}
		
		List l = argument_list.find (old_node);
		if (l != null) {
			if (new_node.parent_node != null) {
				return;
			}
			
			argument_list.insert_before (l, new_node);
			argument_list.remove_link (l);
			new_node.parent_node = this;
		}
	}
}
