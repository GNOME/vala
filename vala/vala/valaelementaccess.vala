/* valaelementaccess.vala
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
 * Represents an element access expression.
 */
public class Vala.ElementAccess : Expression {
	/**
	 * Expression representing the container on wich we want to access.
	 */
	public Expression! container { get; set; }
	
	/**
	 * Expression representing the index we want to access inside the container.
	 */
	public Expression! index { get; set; }
	
	public static ref ElementAccess new (Expression container, Expression index, SourceReference source) {
		return new ElementAccess (container = container, index = index, source_reference = source);
	}
	
	public override void accept (CodeVisitor! visitor) {
		container.accept (visitor);
		index.accept (visitor);

		visitor.visit_element_access (this);
	}
}
