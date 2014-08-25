/* list.vala
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
 * An ordered collection.
 */
[GenericAccessors]
public interface Vala.List<G> : Collection<G> {
	/**
	 * Returns a ListIterator that can be used for iteration over this list.
	 *
	 * @return a ListIterator that can be used for iteration over this list
	 */
	public abstract new ListIterator<G> list_iterator ();

	/**
	 * Returns the item at the specified index in this list.
	 *
	 * @param index zero-based index of the item to be returned
	 *
	 * @return      the item at the specified index in the list
	 */
	public abstract G get (int index);

	/**
	 * Sets the item at the specified index in this list.
	 *
	 * @param index zero-based index of the item to be set
	 */
	public abstract void set (int index, G item);

	/**
	 * Returns the index of the first occurence of the specified item in
	 * this list.
	 *
	 * @return the index of the first occurence of the specified item, or
	 *         -1 if the item could not be found
	 */
	public abstract int index_of (G item);

	/**
	 * Inserts an item into this list at the specified position.
	 *
	 * @param index zero-based index at which item is inserted
	 * @param item  item to insert into the list
	 */
	public abstract void insert (int index, G item);

	/**
	 * Removes the item at the specified index of this list.
	 *
	 * @param index zero-based index of the item to be removed
	 *
	 * @return      the removed element
	 */
	public abstract G remove_at (int index);

	/**
	 * Returns a slice of this list.
	 *
	 * @param start zero-based index of the begin of the slice
	 * @param stop  zero-based index after the end of the slice
	 *
	 * @return A list containing a slice of this list
	 */
	public abstract List<G>? slice (int start, int stop);

	/**
	 * Returns the first item of the list. Fails if the list is empty.
	 *
	 * @return      first item in the list
	 */
	public virtual G first () {
		return get (0);
	}

	/**
	 * Returns the last item of the list. Fails if the list is empty.
	 *
	 * @return      last item in the list
	 */
	public virtual G last () {
		return get (size - 1);
	}

	/**
	 * Inserts items into this list for the input collection at the
	 * specified position.
	 *
	 * @param index zero-based index of the items to be inserted
	 * @param collection collection of items to be inserted
	 */
	public virtual void insert_all (int index, Collection<G> collection) {
		foreach (G item in collection) {
			insert(index, item);
			index++;
		}
	}

	/**
	 * Sorts items by comparing with the specified compare function.
	 *
	 * @param compare_func compare function to use to compare items
	 */
	public virtual void sort (owned CompareDataFunc<G>? compare_func = null) {
		if (compare_func == null) {
			compare_func = Functions.get_compare_func_for (typeof (G));
		}
		TimSort.sort<G> (this, compare_func);
	}

	/**
	 * The read-only view of this list.
	 */
	public abstract new List<G> read_only_view { owned get; }

	/**
	 * Returns an immutable empty list.
	 *
	 * @return an immutable empty list
	 */
	public static List<G> empty<G> () {
		return new LinkedList<G> ().read_only_view;
	}
}

