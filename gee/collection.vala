/* collection.vala
 *
 * Copyright (C) 2007  Jürg Billeter
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
 * Serves as the base interface for implementing collection classes. Defines
 * size, iteration, and modification methods.
 */
public abstract class Vala.Collection<G> : Iterable<G> {
	/**
	 * The number of items in this collection.
	 */
	public abstract int size { get; }

	/**
	 * Determines whether this collection contains the specified item.
	 *
	 * @param item the item to locate in the collection
	 *
	 * @return     true if item is found, false otherwise
	 */
	public abstract bool contains (G item);

	/**
	 * Adds an item to this collection. Must not be called on read-only
	 * collections.
	 *
	 * @param item the item to add to the collection
	 *
	 * @return     true if the collection has been changed, false otherwise
	 */
	public abstract bool add (G item);

	/**
	 * Removes the first occurence of an item from this collection. Must not
	 * be called on read-only collections.
	 *
	 * @param item the item to remove from the collection
	 *
	 * @return     true if the collection has been changed, false otherwise
	 */
	public abstract bool remove (G item);

	/**
	 * Removes all items from this collection. Must not be called on
	 * read-only collections.
	 */
	public abstract void clear ();
}

