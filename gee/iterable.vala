/* iterable.vala
 *
 * Copyright (C) 2007-2008  Jürg Billeter
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
 * Implemented by classes that support a simple iteration over instances of the
 * collection.
 */
public abstract class Vala.Iterable<G> {
	public abstract Type get_element_type ();

	/**
	 * Returns a Iterator that can be used for simple iteration over a
	 * collection.
	 *
	 * @return a Iterator that can be used for simple iteration over a
	 *         collection
	 */
	public abstract Iterator<G> iterator ();
}

