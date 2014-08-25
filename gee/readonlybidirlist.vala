/* readonlybidirlist.vala
 *
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
 * 	Maciej Piechotka <uzytkownik2@gmail.com>
 */

internal class Vala.ReadOnlyBidirList<G> : Vala.ReadOnlyList<G>, BidirList<G> {

	/**
	 * Constructs a read-only list that mirrors the content of the specified
	 * list.
	 *
	 * @param list the list to decorate.
	 */
	public ReadOnlyBidirList (BidirList<G> list) {
		base (list);
	}

	/**
	 * {@inheritDoc}
	 */
	public BidirListIterator<G> bidir_list_iterator () {
		return new Iterator<G> (((Vala.BidirList<G>) _collection).bidir_list_iterator ());
	}

	/**
	 * The read-only view of this list.
	 */
	public virtual new BidirList<G> read_only_view { owned get { return this; } }

	private class Iterator<G> : ReadOnlyList.Iterator<G>, BidirIterator<G>, BidirListIterator<G> {
		public Iterator (ListIterator<G> iterator) {
			base (iterator);
		}

		public bool previous () {
			return ((BidirIterator<G>) _iter).previous ();
		}

		public bool has_previous () {
			return ((BidirIterator<G>) _iter).has_previous ();
		}

		public bool first () {
			return ((BidirIterator<G>) _iter).first ();
		}

		public bool last () {
			return ((BidirIterator<G>) _iter).last ();
		}

		public void insert (G item) {
			assert_not_reached ();
		}
	}
}

