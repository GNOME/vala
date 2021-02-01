/* valaccodefunctioncall.vala
 *
 * Copyright (C) 2006-2007  Jürg Billeter
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
 * Represents a function call in the C code.
 */
public class Vala.CCodeFunctionCall : CCodeExpression {
	/**
	 * The function to be called.
	 */
	public CCodeExpression? call { get; set; }

	private List<CCodeExpression> arguments = new ArrayList<CCodeExpression> ();

	public CCodeFunctionCall (CCodeExpression? call = null) {
		this.call = call;
	}

	/**
	 * Appends the specified expression to the list of arguments.
	 *
	 * @param expr a C code expression
	 */
	public void add_argument (CCodeExpression expr) {
		arguments.add (expr);
	}

	public void insert_argument (int index, CCodeExpression expr) {
		arguments.insert (index, expr);
	}

	/**
	 * Returns the list of arguments.
	 *
	 * @return list of arguments
	 */
	public unowned List<CCodeExpression> get_arguments () {
		return arguments;
	}

	public override void write (CCodeWriter writer) {
		call.write_inner (writer);
		writer.write_string (" (");

		bool first = true;
		foreach (CCodeExpression expr in arguments) {
			if (!first) {
				writer.write_string (", ");
			} else {
				first = false;
			}

			if (expr != null) {
				expr.write (writer);
			}
		}

		writer.write_string (")");
	}
}
