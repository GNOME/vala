/* mapiterator.vala
 *
 * Copyright (C) 2009  Didier Villevalois
 * Copyright (C) 2011  Maciej Piechotka
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

namespace Vala {
	public delegate A FoldMapFunc<A, K, V> (K k, V v, owned A a);
	public delegate bool ForallMapFunc<K, V> (K k, V v);
}

/**
 * An iterator over a map.
 *
 * Gee's iterators are "on-track" iterators. They always point to an item
 * except before the first call to {@link next}, or, when an
 * item has been removed, until the next call to {@link next}.
 *
 * Please note that when the iterator is out of track, neither {@link get_key},
 * {@link get_value}, {@link set_value} nor {@link unset} are defined and all
 * will fail. After the next call to {@link next}, they will
 * be defined again.
 */
[GenericAccessors]
public interface Vala.MapIterator<K,V> : Object {
	/**
	 * Advances to the next entry in the iteration.
	 *
	 * @return ``true`` if the iterator has a next entry
	 */
	public abstract bool next ();

	/**
	 * Checks whether there is a next entry in the iteration.
	 *
	 * @return ``true`` if the iterator has a next entry
	 */
	public abstract bool has_next ();

	/**
	 * Returns the current key in the iteration.
	 *
	 * @return the current key in the iteration
	 */
	public abstract K get_key ();

	/**
	 * Returns the value associated with the current key in the iteration.
	 *
	 * @return the value for the current key
	 */
	public abstract V get_value ();

	/**
	 * Sets the value associated with the current key in the iteration.
	 *
	 * @param value the new value for the current key
	 */
	public abstract void set_value (V value);

	/**
	 * Unsets the current entry in the iteration. The cursor is set in an
	 * in-between state. {@link get_key}, {@link get_value}, {@link set_value}
	 * and {@link unset} will fail until the next move of the cursor (calling
	 * {@link next}).
	 */
	public abstract void unset ();
	
	/**
	 * Determines wheather the call to {@link get_key}, {@link get_value} and 
	 * {@link set_value} is legal. It is false at the beginning and after
	 * {@link unset} call and true otherwise.
	 */
	public abstract bool valid { get; }
	
	/**
	 * Determines wheather the call to {@link set_value} is legal assuming the
	 * iterator is valid. The value must not change in runtime hence the user
	 * of iterator may cache it.
	 */
	public abstract bool mutable { get; }
	
	/**
	 * Determines wheather the call to {@link unset} is legal assuming the
	 * iterator is valid. The value must not change in runtime hence the user
	 * of iterator may cache it.
	 */
	public abstract bool read_only { get; }
	
	/**
	 * Standard aggragation function.
	 *
	 * It takes a function, seed and first element, returns the new seed and
	 * progress to next element when the operation repeats.
	 *
	 * Operation moves the iterator to last element in iteration. If iterator
	 * points at some element it will be included in iteration.
	 */
	public virtual A fold<A> (FoldMapFunc<A, K, V> f, owned A seed)
	{
		if (valid)
			seed = f (get_key (), get_value (), (owned) seed);
		while (next ())
			seed = f (get_key (), get_value (), (owned) seed);
		return (owned) seed;
	}
	
	/**
	 * Apply function to each element returned by iterator. 
	 *
	 * Operation moves the iterator to last element in iteration. If iterator
	 * points at some element it will be included in iteration.
	 */
	public new virtual bool foreach (ForallMapFunc<K, V> f) {
		if (valid) {
			if (!f (get_key (), get_value ())) {
				return false;
			}
		}
		while (next ()) {
			if (!f (get_key (), get_value ())) {
				return false;
			}
		}
		return true;
	}
}

