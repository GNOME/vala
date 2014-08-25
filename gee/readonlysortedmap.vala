/* readonlysortedmap.vala
 *
 * Copyright (C) 2009-2011  Maciej Piechotka
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

/**
 * Read-only view for {@link SortedMap} collections.
 *
 * This class decorates any class which implements the {@link SortedMap} interface
 * by making it read only. Any method which normally modify data will throw an
 * error.
 *
 * @see SortedMap
 */
internal class Vala.ReadOnlySortedMap<K,V> : ReadOnlyMap<K,V>, SortedMap<K,V> {
	/**
	 * Constructs a read-only map that mirrors the content of the specified map.
	 *
	 * @param map the map to decorate.
	 */
	public ReadOnlySortedMap (Map<K,V> map) {
		base (map);
	}

	/**
	 * {@inheritDoc}
	 */
	public SortedMap<K,V> head_map (K before) {
		return (_map as SortedMap<K,V>).head_map (before).read_only_view;
	}

	/**
	 * {@inheritDoc}
	 */
	public SortedMap<K,V> tail_map (K after) {
		return (_map as SortedMap<K,V>).tail_map (after).read_only_view;
	}

	/**
	 * {@inheritDoc}
	 */
	public SortedMap<K,V> sub_map (K from, K to) {
		return (_map as SortedMap<K,V>).sub_map (from, to).read_only_view;
	}

	/**
	 * {@inheritDoc}
	 */
	public SortedSet<K> ascending_keys {
		owned get {
			return (_map as SortedMap<K,V>).ascending_keys.read_only_view;
		}
	}

	/**
	 * {@inheritDoc}
	 */
	public SortedSet<Map.Entry<K,V>> ascending_entries {
		owned get {
			return (_map as SortedMap<K,V>).ascending_entries.read_only_view;
		}
	}

	/**
	 * {@inheritDoc}
	 */
	public new SortedMap<K, V> read_only_view {
		owned get {
			return this;
		}
	}
}

