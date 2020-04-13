/* valaccodememberaccess.vala
 *
 * Copyright (C) 2006  Raffaele Sandrini
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
 * 	Raffaele Sandrini <raffaele@sandrini.ch>
 *	Jürg Billeter <j@bitron.ch>
 */

using GLib;

/**
 * Represents an access to an array member in the C code.
 */
public class Vala.CCodeElementAccess : CCodeExpression {
	/**
	 * Expression representing the container on which we want to access.
	 */
	public CCodeExpression container { get; set; }

	/**
	 * Expression representing the index we want to access inside the
	 * container.
	 */
	public List<CCodeExpression> indices { get; set; }

	public CCodeElementAccess (CCodeExpression cont, CCodeExpression i) {
		container = cont;
		indices = new ArrayList<CCodeExpression> ();
		indices.add (i);
	}

	public CCodeElementAccess.with_indices (CCodeExpression cont, List<CCodeExpression> i) {
		container = cont;
		indices = i;
	}

	public override void write (CCodeWriter writer) {
		container.write_inner (writer);
		writer.write_string ("[");
		bool first = true;
		foreach (var index in indices) {
			if (!first) {
				writer.write_string ("][");
			}
			index.write (writer);
			first = false;
		}
		writer.write_string ("]");
	}
}
