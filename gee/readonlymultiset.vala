/* readonlymultiset.vala
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
 * Read-only view for {@link MultiSet} collections.
 *
 * This class decorates any class which implements the {@link Collection}
 * interface by making it read only. Any method which normally modify data will
 * throw an error.
 *
 * @see MultiSet
 */
internal class Vala.ReadOnlyMultiSet<G> : Vala.ReadOnlyCollection<G>, MultiSet<G> {
	/**
	 * Constructs a read-only multi-set that mirrors the content of the specified
	 * list.
	 *
	 * @param multiset the multi-set to decorate.
	 */
	public ReadOnlyMultiSet (MultiSet<G> multiset) {
		base (multiset);
	}

	/**
	 * {@inheritDoc}
	 */
	public int count (G item) {
		return ((Vala.MultiSet<G>) _collection).count (item);
	}

	/**
	 * {@inheritDoc}
	 */
	public virtual new MultiSet<G> read_only_view { owned get { return this; } }
}

