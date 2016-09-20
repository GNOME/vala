/* abstractbidirsortedmap.vala
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

/**
 * Skeletal implementation of the {@link BidirSortedSet} interface.
 *
 * Contains common code shared by all set implementations.
 *
 * @see TreeSet
 */
public abstract class Vala.AbstractBidirSortedMap<K,V> : Vala.AbstractSortedMap<K,V>, BidirSortedMap<K,V> {
	/**
	 * {@inheritDoc}
	 */
	public abstract BidirMapIterator<K,V> bidir_map_iterator ();

	private WeakRef _read_only_view;
	construct {
		_read_only_view = WeakRef(null);
	}

	/**
	 * {@inheritDoc}
	 */
	public virtual new BidirSortedMap<K,V> read_only_view {
		owned get {
			BidirSortedMap<K,V>? instance = (BidirSortedMap<K,V>?)_read_only_view.get ();
			if (instance == null) {
				instance = new ReadOnlyBidirSortedMap<K,V> (this);
				_read_only_view.set (instance);
			}
			return instance;
		}
	}
}

