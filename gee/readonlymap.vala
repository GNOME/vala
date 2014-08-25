/* readonlymap.vala
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
 * Read-only view for {@link Map} collections.
 *
 * This class decorates any class which implements the {@link Map} interface
 * by making it read only. Any method which normally modify data will throw an
 * error.
 *
 * @see Map
 */
internal class Vala.ReadOnlyMap<K,V> : Object, Traversable<Map.Entry<K,V>>, Iterable<Map.Entry<K,V>>, Map<K,V> {

	/**
	 * {@inheritDoc}
	 */
	public int size {
		get { return _map.size; }
	}

	/**
	 * {@inheritDoc}
	 */
	public bool is_empty {
		get { return _map.is_empty; }
	}

	/**
	 * {@inheritDoc}
	 */
	public bool read_only {
		get { return true; }
	}

	/**
	 * {@inheritDoc}
	 */
	public Set<K> keys {
		owned get {
			return _map.keys;
		}
	}

	/**
	 * {@inheritDoc}
	 */
	public Collection<V> values {
		owned get {
			return _map.values;
		}
	}

	/**
	 * {@inheritDoc}
	 */
	public Set<Map.Entry<K,V>> entries {
		owned get {
			return _map.entries;
		}
	}

	protected Map<K,V> _map;

	/**
	 * Constructs a read-only map that mirrors the content of the specified map.
	 *
	 * @param map the map to decorate.
	 */
	public ReadOnlyMap (Map<K,V> map) {
		this._map = map;
	}

	/**
	 * {@inheritDoc}
	 */
	public bool has_key (K key) {
		return _map.has_key (key);
	}

	/**
	 * {@inheritDoc}
	 */
	public bool contains (K key) {
		return _map.has_key (key);
	}

	/**
	 * {@inheritDoc}
	 */
	public bool has (K key, V value) {
		return _map.has (key, value);
	}

	/**
	 * {@inheritDoc}
	 */
	public new V? get (K key) {
		return _map.get (key);
	}

	/**
	 * Unimplemented method (read only map).
	 */
	public new void set (K key, V value) {
		assert_not_reached ();
	}

	/**
	 * Unimplemented method (read only map).
	 */
	public bool unset (K key, out V? value = null) {
		assert_not_reached ();
	}

	/**
	 * Unimplemented method (read only map).
	 */
	public bool remove (K key, out V? value = null) {
		assert_not_reached ();
	}

	/**
	 * Unimplemented method (read only map).
	 */
	public void clear () {
		assert_not_reached ();
	}

	/**
	 * {@inheritDoc}
	 */
	public Vala.MapIterator<K,V> map_iterator () {
		return new MapIterator<K,V> (_map.map_iterator ());
	}

	/**
	 * Unimplemented method (read only map).
	 */
	public void set_all (Map<K,V> map) {
		assert_not_reached ();
	}

	/**
	 * Unimplemented method (read only map).
	 */
	public bool unset_all (Map<K,V> map) {
		assert_not_reached ();
	}

	/**
	 * Unimplemented method (read only map).
	 */
	public bool remove_all (Map<K,V> map) {
		assert_not_reached ();
	}

	/**
	 * {@inheritDoc}
	 */
	public bool has_all (Map<K,V> map) {
		return _map.has_all (map);
	}

	/**
	 * {@inheritDoc}
	 */
	public bool contains_all (Map<K,V> map) {
		return _map.has_all (map);
	}

	public virtual Map<K,V> read_only_view {
		owned get { return this; }
	}

	/**
	 * {@inheritDoc}
	 */
	public Type key_type {
		get { return typeof (K); }
	}

	/**
	 * {@inheritDoc}
	 */
	public Type value_type {
		get { return typeof (V); }
	}

	/**
	 * {@inheritDoc}
	 */
	public Type element_type {
		get { return typeof (Map.Entry); }
	}

	/**
	 * {@inheritDoc}
	 */
	public Iterator<Map.Entry<K,V>> iterator () {
		return entries.iterator ();
	}

	/**
	 * {@inheritDoc}
	 */
	public bool foreach (ForallFunc<Map.Entry<K, V>> f) {
		return _map.foreach (f);
	}

	/**
	 * {@inheritDoc}
	 */
	public Iterator<A> stream<A> (owned StreamFunc<Map.Entry<K, V>, A> f) {
		return _map.stream<A> ((owned) f);
	}

	public Iterator<Map.Entry<K, V>> filter (owned Predicate<Map.Entry<K, V>> f) {
		return _map.filter ((owned)f);
	}

	public Iterator<Map.Entry<K, V>> chop (int offset, int length = -1) {
		return _map.chop (offset, length);
	}

	protected class MapIterator<K,V> : Object, Vala.MapIterator<K,V> {
		protected Vala.MapIterator<K,V> _iter;

		public MapIterator (Vala.MapIterator<K,V> iterator) {
			_iter = iterator;
		}

		public bool next () {
			return _iter.next ();
		}

		public bool has_next () {
			return _iter.has_next ();
		}

		public K get_key () {
			return _iter.get_key ();
		}

		public V get_value () {
			return _iter.get_value ();
		}

		public void set_value (V value) {
			assert_not_reached ();
		}

		public void unset () {
			assert_not_reached ();
		}

		public bool read_only {
			get {
				return true;
			}
		}

		public bool mutable {
			get {
				return false;
			}
		}

		public bool valid {
			get {
				return _iter.valid;
			}
		}
	}
}

