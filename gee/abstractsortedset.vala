/* abstractsortedset.vala
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
 * Skeletal implementation of the {@link SortedSet} interface.
 *
 * Contains common code shared by all set implementations.
 *
 * @see TreeSet
 */
public abstract class Vala.AbstractSortedSet<G> : Vala.AbstractSet<G>, SortedSet<G> {
	/**
	 * {@inheritDoc}
	 */
	public abstract G first ();

	/**
	 * {@inheritDoc}
	 */
	public abstract G last ();

	/**
	 * {@inheritDoc}
	 */
	public abstract Iterator<G>? iterator_at (G element);

	/**
	 * {@inheritDoc}
	 */
	public abstract G? lower (G element);

	/**
	 * {@inheritDoc}
	 */
	public abstract G? higher (G element);

	/**
	 * {@inheritDoc}
	 */
	public abstract G? floor (G element);

	/**
	 * {@inheritDoc}
	 */
	public abstract G? ceil (G element);

	/**
	 * {@inheritDoc}
	 */
	public abstract SortedSet<G> head_set (G before);

	/**
	 * {@inheritDoc}
	 */
	public abstract SortedSet<G> tail_set (G after);

	/**
	 * {@inheritDoc}
	 */
	public abstract SortedSet<G> sub_set (G from, G to);

	private WeakRef _read_only_view;
	construct {
		_read_only_view = WeakRef(null);
	}

	/**
	 * {@inheritDoc}
	 */
	public virtual new SortedSet<G> read_only_view {
		owned get {
			SortedSet<G>? instance = (SortedSet<G>?)_read_only_view.get ();
			if (instance == null) {
				instance = new ReadOnlySortedSet<G> (this);
				_read_only_view.set (instance);
			}
			return instance;
		}
	}
}

