/* valatypeparameter.vala
 *
 * Copyright (C) 2006-2009  Jürg Billeter
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
 * Represents a generic type parameter in the source code.
 */
public class Vala.TypeParameter : Symbol {
	/**
	 * Creates a new generic type parameter.
	 *
	 * @param name   parameter name
	 * @param source reference to source code
	 * @return       newly created generic type parameter
	 */	
	public TypeParameter (string name, SourceReference source_reference) {
		base (name, source_reference);
	}

	public override void accept (CodeVisitor visitor) {
		visitor.visit_type_parameter (this);
	}

	/**
	 * Checks two type parameters for equality.
	 *
	 * @param param2 a type parameter
	 * @return      true if this type parameter is equal to param2, false
	 *              otherwise
	 */
	public bool equals (TypeParameter param2) {
		// FIXME check whether the corresponding data type of one of the
		//       parameters is a base type of the corresponding data
		//       type of the other parameter and check along the path
		//       whether one parameter maps to the other
		return true;
	}
}
