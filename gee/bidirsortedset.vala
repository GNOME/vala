/* bidirsortedset.vala
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
public interface Vala.BidirSortedSet<G> : SortedSet<G> {
	/**
	 * Returns a {@link BidirIterator} that can be used for bi-directional
	 * iteration over this sorted set.
	 *
	 * @return a {@link BidirIterator} over this sorted set
	 */
	public abstract BidirIterator<G> bidir_iterator ();

	/**
	 * The read-only view of this set.
	 */
	public abstract new BidirSortedSet<G> read_only_view { owned get; }

	/**
	 * Returns an immutable empty sorted set.
	 *
	 * @return an immutable empty sorted set
	 */
	public static BidirSortedSet<G> empty<G> () {
		return new TreeSet<G> ().read_only_view;
	}
}

