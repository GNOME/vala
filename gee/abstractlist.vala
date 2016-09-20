/* abstractlist.vala
 *
 * Copyright (C) 2007  Jürg Billeter
 * Copyright (C) 2009  Didier Villevalois
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
 * 	Didier 'Ptitjes' Villevalois <ptitjes@free.fr>
 */

/**
 * Skeletal implementation of the {@link List} interface.
 *
 * Contains common code shared by all list implementations.
 *
 * @see ArrayList
 * @see LinkedList
 */
public abstract class Vala.AbstractList<G> : Vala.AbstractCollection<G>, List<G> {

	/**
	 * {@inheritDoc}
	 */
	public abstract ListIterator<G> list_iterator ();

	/**
	 * {@inheritDoc}
	 */
	public abstract new G? get (int index);

	/**
	 * {@inheritDoc}
	 */
	public abstract new void set (int index, G item);

	/**
	 * {@inheritDoc}
	 */
	public abstract int index_of (G item);

	/**
	 * {@inheritDoc}
	 */
	public abstract void insert (int index, G item);

	/**
	 * {@inheritDoc}
	 */
	public abstract G remove_at (int index);

	/**
	 * {@inheritDoc}
	 */
	public abstract List<G>? slice (int start, int stop);

	private WeakRef _read_only_view;
	construct {
		_read_only_view = WeakRef(null);
	}

	/**
	 * {@inheritDoc}
	 */
	public virtual new List<G> read_only_view {
		owned get {
			List<G>? instance = (List<G>?)_read_only_view.get ();
			if (instance == null) {
				instance = new ReadOnlyList<G> (this);
				_read_only_view.set (instance);
			}
			return instance;
		}
	}
}
