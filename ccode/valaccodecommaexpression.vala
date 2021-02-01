/* valaccodecommaexpression.vala
 *
 * Copyright (C) 2006-2010  Jürg Billeter
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
 * Represents a comma separated expression list in the C code.
 */
public class Vala.CCodeCommaExpression : CCodeExpression {
	private List<CCodeExpression> inner = new ArrayList<CCodeExpression> ();

	/**
	 * Appends the specified expression to the expression list.
	 *
	 * @param expr a C code expression
	 */
	public void append_expression (CCodeExpression expr) {
		inner.add (expr);
	}

	public void set_expression (int index, CCodeExpression expr) {
		inner[index] = expr;
	}

	public unowned List<CCodeExpression> get_inner () {
		return inner;
	}

	public override void write (CCodeWriter writer) {
		bool first = true;

		writer.write_string ("(");
		foreach (CCodeExpression expr in inner) {
			if (!first) {
				writer.write_string (", ");
			} else {
				first = false;
			}
			expr.write (writer);
		}
		writer.write_string (")");
	}
}
