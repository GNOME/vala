/* bidirsortedmap.vala
 *
 * Copyright (C) 2012  Maciej Piechotka
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
[GenericAccessors]
public interface Vala.BidirSortedMap<K,V> : SortedMap<K,V> {
	/**
	 * Returns a bi-directional iterator for this map.
	 *
	 * @return a bi-directional map iterator
	 */
	public abstract BidirMapIterator<K,V> bidir_map_iterator ();

	/**
	 * The read-only view of this set.
	 */
	public abstract new BidirSortedMap<K,V> read_only_view { owned get; }

	/**
	 * Returns an immutable empty sorted set.
	 *
	 * @return an immutable empty sorted set
	 */
	public static BidirSortedMap<K,V> empty<K,V> () {
		return new TreeMap<K,V> ().read_only_view;
	}
}

