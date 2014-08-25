/* multimap.vala
 *
 * Copyright (C) 2009  Ali Sabil
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
 * 	Ali Sabil <ali.sabil@gmail.com>
 */

/**
 * A map with multiple values per key.
 */
[GenericAccessors]
public interface Vala.MultiMap<K,V> : Object {
	/**
	 * The number of key/value pairs in this map.
	 */
	public abstract int size { get; }

	/**
	 * Specifies whether this collection can change - i.e. wheather {@link set},
	 * {@link remove} etc. are legal operations.
	 */
	public abstract bool read_only { get; }

	/**
	 * Returns the keys of this multimap as a read-only set.
	 *
	 * @return the keys of the map
	 */
	public abstract Set<K> get_keys ();

	/**
	 * Returns the keys of this multimap as a read-only set.
	 *
	 * @return the keys of the map
	 */
	public abstract MultiSet<K> get_all_keys ();

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
	 * @return    ``true`` if key is found, ``false`` otherwise
	 */
	public abstract bool contains (K key);

	/**
	 * Returns the values for the specified key in this map.
	 *
	 * @param key the key whose values are to be retrieved
	 *
	 * @return    a Collection of values associated with the given key
	 */
	public abstract Collection<V> get (K key);

	/**
	 * Inserts a key/value pair into this map.
	 *
	 * @param key   the key to insert
	 * @param value the value to associate with the key
	 */
	public abstract void set (K key, V value);

	/**
	 * Removes the specified key/value pair from this multimap.
	 *
	 * @param key   the key to remove from the map
	 * @param value the value to remove from the map
	 *
	 * @return      ``true`` if the map has been changed, ``false`` otherwise
	 */
	public abstract bool remove (K key, V value);

	/**
	 * Removes the specified key and all the associated values from this
	 * multimap.
	 *
	 * @param key the key to remove from the map
	 *
	 * @return    ``true`` if the map has been changed, ``false`` otherwise
	 */
	public abstract bool remove_all (K key);

	/**
	 * Removes all items from this collection.
	 */
	public abstract void clear ();

	/**
	 * Returns an iterator for this map.
	 *
	 * @return a map iterator
	 */
	public abstract MapIterator<K, V> map_iterator ();

	/**
	 * The type of the keys in this multimap.
	 */
	public Type key_type { get { return typeof (K); } }

	/**
	 * The type of the values in this multimap.
	 */
	public Type value_type { get { return typeof (V); } }
}
