/* valaccodememberaccess.vala
 *
 * Copyright (C) 2006  Raffaele Sandrini
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
 * 	Raffaele Sandrini <rasa@gmx.ch>
 */

using GLib;

/**
 * Represents an access to a array member in the C code.
 */
public class Vala.CCodeElementAccess : CCodeExpression {
	/**
	 * Expression representing the container on wich we want to access.
	 */
	public CCodeExpression! container { get; set construct; }
	
	/**
	 * Expression representing the index we want to access inside the container.
	 */
	public CCodeExpression! index { get; set construct; }
	
	public override void write (CCodeWriter! writer) {
		container.write (writer);
		writer.write_string ("[");
		index.write (writer);
		writer.write_string ("]");
	}
}
