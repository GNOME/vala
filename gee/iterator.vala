/* iterator.vala
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

/**
 * Implemented by classes that support a simple iteration over instances of the
 * collection.
 */
public abstract class Vala.Iterator<G> {
	/**
	 * Advances to the next element in the iteration.
	 *
	 * @return true if the iterator has a next element
	 */
	public abstract bool next ();

	/**
	 * Checks whether there is a next element in the iteration.
	 *
	 * @return ``true`` if the iterator has a next element
	 */
	public abstract bool has_next ();

	/**
	 * Returns the current element in the iteration.
	 *
	 * @return the current element in the iteration
	 */
	public abstract G? get ();

	/**
	 * Removes the current element in the iteration. The cursor is set in an
	 * in-between state. Both {@link get} and {@link remove} will fail until
	 * the next move of the cursor (calling {@link next}).
	 */
	public abstract void remove ();

	/**
	 * Determines whether the call to {@link get} is legal. It is false at the
	 * beginning and after {@link remove} call and true otherwise.
	 */
	public abstract bool valid { get; }
}

