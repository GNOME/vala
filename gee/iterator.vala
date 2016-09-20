/* iterator.vala
 *
 * Copyright (C) 2007-2008  Jürg Billeter
 * Copyright (C) 2009  Didier Villevalois, Maciej Piechotka
 * Copyright (C) 2010-2011  Maciej Piechotka
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
 * 	Maciej Piechotka <uzytkownik2@gmail.com>
 * 	Didier 'Ptitjes Villevalois <ptitjes@free.fr>
 */

/**
 * An iterator over a collection.
 *
 * Gee's iterators are "on-track" iterators. They always point to an item
 * except before the first call to {@link next}, or, when an
 * item has been removed, until the next call to {@link next}.
 *
 * Please note that when the iterator is out of track, neither {@link get} nor
 * {@link remove} are defined and both might fail. After the next call to
 * {@link next}, they will be defined again.
 *
 * Please also note that, unless specified otherwise, iterators before iteration
 * started should behave as if after deletion of the first element. Whenever
 * documentation states about the iterator 'out of track', 'invalid' or
 * 'in-between elements' this refers to the same concept.
 */
public interface Vala.Iterator<G> : Object, Traversable<G> {
	/**
	 * Advances to the next element in the iteration.
	 *
	 * @return ``true`` if the iterator has a next element
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
	public abstract G get ();

	/**
	 * Removes the current element in the iteration. The cursor is set in an
	 * in-between state. Both {@link get} and {@link remove} will fail until
	 * the next move of the cursor (calling {@link next}).
	 */
	public abstract void remove ();

	/**
	 * Determines wheather the call to {@link get} is legal. It is false at the
	 * beginning and after {@link remove} call and true otherwise.
	 */
	public abstract bool valid { get; }

	/**
	 * Determines wheather the call to {@link remove} is legal assuming the
	 * iterator is valid. The value must not change in runtime hence the user
	 * of iterator may cache it.
	 */
	public abstract bool read_only { get; }

	/**
	 * Create iterator from unfolding function. The lazy value is
	 * force-evaluated before progressing to next element.
	 *
	 * @param f Unfolding function
	 * @param current If iterator is to be valid it contains the current value of it
	 */
	public static Iterator<A> unfold<A> (owned UnfoldFunc<A> f, owned Lazy<G>? current = null) {
		return new UnfoldIterator<A> ((owned) f, (owned) current);
	}

	/**
	 * Concatinate iterators.
	 *
	 * @param iters Iterators of iterators
	 * @return Iterator containg values of each iterator
	 */
	public static Iterator<G> concat<G> (Iterator<Iterator<G>> iters) {
		Iterator<G>? current = null;
		if (iters.valid)
			current = iters.get ();
		return unfold<G> (() => {
			while (true) {
				if (current == null) {
					if (iters.next ()) {
						current = iters.get ();
					} else {
						return null;
					}
				} else if (current.next ()) {
					return new Lazy<G>.from_value (current.get ());
				} else {
					current = null;
				}
			}
		});
	}
}

