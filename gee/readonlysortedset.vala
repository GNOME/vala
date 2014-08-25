/* readonlysortedset.vala
 *
 * Copyright (C) 2009  Didier Villevalois, Maciej Piechotka
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

/**
 * Read-only view for {@link SortedSet} collections.
 *
 * This class decorates any class which implements the {@link SortedSet} interface
 * by making it read only. Any method which normally modify data will throw an
 * error.
 *
 * @see SortedSet
 */
internal class Vala.ReadOnlySortedSet<G> : ReadOnlySet<G>, SortedSet<G> {
	/**
	 * Constructs a read-only set that mirrors the content of the specified set.
	 *
	 * @param set the set to decorate.
	 */
	public ReadOnlySortedSet (SortedSet<G> set) {
		base (set);
	}

	/**
	 * {@inheritDoc}
	 */
	public G first () {
		return (_collection as SortedSet<G>).first ();
	}

	/**
	 * {@inheritDoc}
	 */
	public G last () {
		return (_collection as SortedSet<G>).last ();
	}

	/**
	 * {@inheritDoc}
	 */
	public Vala.Iterator<G>? iterator_at (G element) {
		var iter = (_collection as SortedSet<G>).iterator_at (element);
		return (iter != null) ? new Iterator<G> (iter) : null;
	}

	/**
	 * {@inheritDoc}
	 */
	public G? lower (G element) {
		return (_collection as SortedSet<G>).lower (element);
	}

	/**
	 * {@inheritDoc}
	 */
	public G? higher (G element) {
		return (_collection as SortedSet<G>).higher (element);
	}

	/**
	 * {@inheritDoc}
	 */
	public G? floor (G element) {
		return (_collection as SortedSet<G>).floor (element);
	}

	/**
	 * {@inheritDoc}
	 */
	public G? ceil (G element) {
		return (_collection as SortedSet<G>).ceil (element);
	}

	/**
	 * {@inheritDoc}
	 */
	public SortedSet<G> head_set (G before) {
		return (_collection as SortedSet<G>).head_set (before).read_only_view;
	}

	/**
	 * {@inheritDoc}
	 */
	public SortedSet<G> tail_set (G after) {
		return(_collection as SortedSet<G>).tail_set (after).read_only_view;
	}

	/**
	 * {@inheritDoc}
	 */
	public SortedSet<G> sub_set (G from, G to) {
		return (_collection as SortedSet<G>).sub_set (from, to).read_only_view;
	}

	/**
	 * {@inheritDoc}
	 */
	public new SortedSet<G> read_only_view {
		owned get {
			return this;
		}
	}
}

