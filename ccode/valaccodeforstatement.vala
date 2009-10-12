/* valaccodeforstatement.vala
 *
 * Copyright (C) 2006-2008  Jürg Billeter
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

using GLib;

/**
 * Represents a for iteration statement in the C code.
 */
public class Vala.CCodeForStatement : CCodeStatement {
	/**
	 * The loop condition.
	 */
	public CCodeExpression? condition { get; set; }
	
	/**
	 * The loop body.
	 */
	public CCodeStatement body { get; set; }
	
	private List<CCodeExpression> initializer = new ArrayList<CCodeExpression> ();
	private List<CCodeExpression> iterator = new ArrayList<CCodeExpression> ();
	
	public CCodeForStatement (CCodeExpression? condition, CCodeStatement? body = null) {
		this.condition = condition;
		this.body = body;
	}

	/**
	 * Appends the specified expression to the list of initializers.
	 *
	 * @param expr an initializer expression
	 */
	public void add_initializer (CCodeExpression expr) {
		initializer.add (expr);
	}

	/**
	 * Appends the specified expression to the iterator.
	 *
	 * @param expr an iterator expression
	 */
	public void add_iterator (CCodeExpression expr) {
		iterator.add (expr);
	}
	
	public override void write (CCodeWriter writer) {
		bool first;
		
		writer.write_indent (line);
		writer.write_string ("for (");
		
		first = true;
		foreach (CCodeExpression init_expr in initializer) {
			if (!first) {
				writer.write_string (", ");
			} else {
				first = false;
			}
			if (init_expr != null) {
				init_expr.write (writer);
			}
		}

		writer.write_string ("; ");
		if (condition != null) {
			condition.write (writer);
		}
		writer.write_string ("; ");
		
		first = true;
		foreach (CCodeExpression it_expr in iterator) {
			if (!first) {
				writer.write_string (", ");
			} else {
				first = false;
			}
			if (it_expr != null) {
				it_expr.write (writer);
			}
		}

		writer.write_string (")");
		body.write (writer);
	}
}
