/* valainitializerlist.vala
 *
 * Copyright (C) 2006-2007  Jürg Billeter
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
 * Represents an array or struct initializer list in the source code.
 */
public class Vala.InitializerList : Expression {
	private List<Expression> initializers;
	
	/**
	 * Appends the specified expression to this initializer list.
	 *
	 * @param expr an expression
	 */
	public void append (Expression! expr) {
		initializers.append (expr);
	}
	
	/**
	 * Returns a copy of the expression list.
	 *
	 * @return expression list
	 */
	public List<weak Expression> get_initializers () {
		return initializers.copy ();
	}
	
	/**
	 * Creates a new initializer list.
	 *
	 * @param source reference to source code
	 * @return       newly created initializer list
	 */
	public InitializerList (SourceReference source) {
		source_reference = source;
	}
	
	public override void accept (CodeVisitor! visitor) {
		visitor.visit_begin_initializer_list (this);
		
		foreach (Expression expr in initializers) {
			expr.accept (visitor);
		}
		
		visitor.visit_end_initializer_list (this);
	}
}
