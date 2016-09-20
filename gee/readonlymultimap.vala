/* readonlymultimap.vala
 *
 * Copyright (C) 2013  Maciej Piechotka
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
 * 	Maciej Piechotka <uzytkownik2@gmail.com>
 */

using GLib;

/**
 * Read-only view for {@link MultiMap} collections.
 *
 * This class decorates any class which implements the {@link MultiMap}
 * interface by making it read only. Any method which normally modify data will
 * throw an error.
 *
 * @see MultiMap
 */
internal class Vala.ReadOnlyMultiMap<K, V> : Object, MultiMap<K, V> {
	/**
	 * Constructs a read-only multi-set that mirrors the content of the specified
	 * list.
	 *
	 * @param multiset the multi-set to decorate.
	 */
	public ReadOnlyMultiMap (MultiMap<K, V> multimap) {
		this._multimap = multimap;
	}

	/**
	 * {@inheritDoc}
	 */
	public int size { get { return _multimap.size; } }

	/**
	 * {@inheritDoc}
	 */
	public bool read_only { get { return true; } }

	/**
	 * {@inheritDoc}
	 */
	public Set<K> get_keys () {
		return _multimap.get_keys ();
	}

	/**
	 * {@inheritDoc}
	 */
	public MultiSet<K> get_all_keys () {
		return _multimap.get_all_keys ();
	}

	/**
	 * {@inheritDoc}
	 */
	public Collection<V> get_values () {
		return _multimap.get_values ();
	}

	/**
	 * {@inheritDoc}
	 */
	public bool contains (K key) {
		return _multimap.contains (key);
	}

	/**
	 * {@inheritDoc}
	 */
	public new Collection<V> get (K key) {
		return _multimap.get (key);
	}

	/**
	 * {@inheritDoc}
	 */
	public new void set (K key, V value) {
		assert_not_reached ();
	}

	/**
	 * {@inheritDoc}
	 */
	public bool remove (K key, V value) {
		assert_not_reached ();
	}

	/**
	 * {@inheritDoc}
	 */
	public bool remove_all (K key) {
		assert_not_reached ();
	}

	/**
	 * {@inheritDoc}
	 */
	public void clear () {
		assert_not_reached ();
	}

	/**
	 * {@inheritDoc}
	 */
	public MapIterator<K, V> map_iterator () {
		return new ReadOnlyMap.MapIterator<K, V> (_multimap.map_iterator ());
	}

	/**
	 * {@inheritDoc}
	 */
	public virtual new MultiMap<K, V> read_only_view { owned get { return this; } }

	private MultiMap<K, V> _multimap;
}
