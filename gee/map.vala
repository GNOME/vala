/* map.vala
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
 * A map is a generic collection of key/value pairs.
 */
public abstract class Vala.Map<K,V> {
	/**
	 * The number of items in this map.
	 */
	public abstract int size { get; }

	/**
	 * Returns the keys of this map as a read-only set.
	 *
	 * @return the keys of the map
	 */
	public abstract Set<K> get_keys ();

	/**
	 * Returns the values of this map as a read-only collection.
	 *
	 * @return the values of the map
	 */
	public abstract Collection<V> get_values ();

	/**
	 * Determines whether this map contains the specified key.
	 *
	 * @param key the key to locate in the map
	 *
	 * @return    true if key is found, false otherwise
	 */
	public abstract bool contains (K key);

	/**
	 * Returns the value of the specified key in this map.
	 *
	 * @param key the key whose value is to be retrieved
	 *
	 * @return    the value associated with the key, or null if the key
	 *            couldn't be found
	 */
	public abstract V? get (K key);

	/**
	 * Inserts a new key and value into this map.
	 *
	 * @param key   the key to insert
	 * @param value the value to associate with the key
	 */
	public abstract void set (K key, V value);

	/**
	 * Removes the specified key from this map.
	 *
	 * @param key the key to remove from the map
	 *
	 * @return    true if the map has been changed, false otherwise
	 */
	public abstract bool remove (K key);

	/**
	 * Removes all items from this collection. Must not be called on
	 * read-only collections.
	 */
	public abstract void clear ();

	/**
	 * Returns a Iterator that can be used for simple iteration over a
	 * map.
	 *
	 * @return a Iterator that can be used for simple iteration over a
	 *         map
	 */
	public abstract MapIterator<K,V> map_iterator ();
}

