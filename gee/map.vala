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
 * An object that maps keys to values.
 */
[GenericAccessors]
public interface Vala.Map<K,V> : Object, Iterable<Map.Entry<K,V>> {
	/**
	 * The number of items in this map.
	 */
	public abstract int size { get; }

	/**
	 * Specifies whether this map is empty.
	 */
	public virtual bool is_empty { get { return size == 0; } }

	/**
	 * Specifies whether this collection can change - i.e. wheather {@link set},
	 * {@link remove} etc. are legal operations.
	 */
	public abstract bool read_only { get; }

	/**
	 * The read-only view of the keys of this map.
	 */
	public abstract Set<K> keys { owned get; }

	/**
	 * The read-only view of the values of this map.
	 */
	public abstract Collection<V> values { owned get; }

	/**
	 * The read-only view of the entries of this map.
	 */
	public abstract Set<Entry<K,V>> entries { owned get; }

	/**
	 * An entry of a map.
	 */
	public abstract class Entry<K,V> : Object {
		/**
		 * The key of this entry.
		 */
		public abstract K key { get; }

		/**
		 * The value of this entry.
		 */
		public abstract V value { get; set; }

		/**
		 * ``true'' if the setting value is permitted.
		 */
		public abstract bool read_only { get; }
	}

	/**
	 * Determines whether this map has the specified key.
	 *
	 * @param key the key to locate in the map
	 *
	 * @return    ``true`` if key is found, ``false`` otherwise
	 */
	public abstract bool has_key (K key);

	/**
	 * Determines whether this map contains the specified key.
	 *
	 * @param key the key to locate in the map
	 *
	 * @return    ``true`` if key is found, ``false`` otherwise
	 *
	 * @deprecated Use {@link has_key} method instead.
	 */
	[Version (deprecated = true)]
	public bool contains (K key) {
		return has_key(key);
	}

	/**
	 * Determines whether this map has the specified key/value entry.
	 *
	 * @param key the key to locate in the map
	 * @param value the corresponding value
	 *
	 * @return    ``true`` if key is found, ``false`` otherwise
	 */
	public abstract bool has (K key, V value);

	/**
	 * Returns the value of the specified key in this map.
	 *
	 * @param key the key whose value is to be retrieved
	 *
	 * @return    the value associated with the key, or ``null`` if the key
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
	 * @param key   the key to remove from the map
	 * @param value the receiver variable for the removed value
	 *
	 * @return    ``true`` if the map has been changed, ``false`` otherwise
	 */
	public abstract bool unset (K key, out V? value = null);

	/**
	 * Removes the specified key from this map.
	 *
	 * @param key   the key to remove from the map
	 * @param value the receiver variable for the removed value
	 *
	 * @return    ``true`` if the map has been changed, ``false`` otherwise
	 *
	 * @deprecated Use {@link unset} method instead.
	 */
	[Version (deprecated = true)]
	public bool remove (K key, out V? value = null) {
		return unset (key, out value);
	}

	/**
	 * Removes all items from this collection. Must not be called on
	 * read-only collections.
	 */
	public abstract void clear ();

	/**
	 * Returns an iterator for this map.
	 *
	 * @return a map iterator
	 */
	public abstract MapIterator<K,V> map_iterator ();

	/**
	 * Inserts all items that are contained in the input map to this map.
	 *
	 * @param map the map which items are inserted to this map
	 */
	public virtual void set_all (Map<K,V> map) {
		foreach (Map.Entry<K,V> entry in map.entries) {
			set (entry.key, entry.value);
		}
	}

	/**
	 * Removes all items from this map that are common to the input map
	 * and this map.
	 *
	 * @param map the map which common items are deleted from this map
	 */
	public virtual bool unset_all (Map<K,V> map) {
		bool changed = false;
		foreach (K key in map.keys) {
			changed = changed | unset (key);
		}
		return changed;
	}

	/**
	 * Removes all items from this map that are common to the input map
	 * and this map.
	 *
	 * @param map the map which common items are deleted from this map
	 *
	 * @deprecated Use {@link unset_all} method instead.
	 */
	[Version (deprecated = true)]
	public bool remove_all (Map<K,V> map) {
		return unset_all (map);
	}

	/**
	 * Returns ``true`` it this map contains all items as the input map.
	 *
	 * @param map the map which items will be compared with this map
	 */
	public virtual bool has_all (Map<K,V> map) {
		foreach (Map.Entry<K,V> entry in map.entries) {
			if (!has (entry.key, entry.value)) {
				return false;
			}
		}
		return true;
	}

	/**
	 * Returns ``true`` it this map contains all items as the input map.
	 *
	 * @param map the map which items will be compared with this map
	 *
	 * @deprecated Use {@link has_all} method instead.
	 */
	[Version (deprecated = true)]
	public bool contains_all (Map<K,V> map) {
		return has_all (map);
	}

	/**
	 * The read-only view this map.
	 */
	public abstract Map<K,V> read_only_view { owned get; }

	/**
	 * The type of the keys in this map.
	 */
	public Type key_type { get { return typeof(K); } }

	/**
	 * The type of the values in this map.
	 */
	public Type value_type { get { return typeof(V); } }

	/**
	 * Returns an immutable empty map.
	 *
	 * @return an immutable empty map
	 */
	public static Map<K,V> empty<K,V> () {
		return new HashMap<K,V> ().read_only_view;
	}
}

