/* valastatement.vala
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
 * Base class for all statement types.
 */
public abstract class Vala.Statement : CodeNode {
	/**
	 * Specifies whether this statement is in the construction part
	 * of a construction method.
	 */
	public bool construction { get; set; }
	
	/**
	 * Returns the number of construction parameters this statement sets in
	 * maximum or -1 if this statement may not be used in the construction
	 * part of a construction method.
	 *
	 * @return number of construction parameters set or -1
	 */
	public virtual int get_number_of_set_construction_parameters () {
		return -1;
	}
}
