/* listiterator.vala
 *
 * Copyright (C) 2009  Didier Villevalois
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
 * 	Didier 'Ptitjes Villevalois <ptitjes@free.fr>
 */

/**
 * A list iterator. This supports bi-directionnal and index-based iteration.
 */
public interface Vala.ListIterator<G> : Vala.Iterator<G> {
	/**
	 * Sets the current item in the iteration to the specified new item.
	 */
	public abstract void set (G item);

	/**
	 * Adds the specified item after the current item in the iteration. The
	 * cursor is moved to point to the new added item.
	 */
	public abstract void add (G item);

	/**
	 * Returns the current index in the iteration.
	 *
	 * @return the current index
	 */
	public abstract int index ();
}
