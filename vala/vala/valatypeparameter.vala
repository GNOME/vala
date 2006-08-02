/* valatypeparameter.vala
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
 * Represents a generic type parameter in the source code.
 */
public class Vala.TypeParameter : CodeNode {
	/**
	 * The parameter name.
	 */
	public string! name { get; set construct; }
	
	/**
	 * The generic type declaring this parameter.
	 */
	public weak DataType type;

	/**
	 * Creates a new generic type parameter.
	 *
	 * @param name   parameter name
	 * @param source reference to source code
	 * @return       newly created generic type parameter
	 */	
	public construct (string! _name, SourceReference source) {
		name = _name;
		source_reference = source;
	}

	public override void accept (CodeVisitor! visitor) {
		visitor.visit_type_parameter (this);
	}
}
