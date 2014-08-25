/* abstractcollection.vala
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
 * Skeletal implementation of the {@link Collection} interface.
 *
 * Contains common code shared by all collection implementations.
 *
 * @see AbstractList
 * @see AbstractSet
 * @see AbstractMultiSet
 */
public abstract class Vala.AbstractCollection<G> : Object, Traversable<G>, Iterable<G>, Collection<G> {
	/**
	 * {@inheritDoc}
	 */
	public abstract int size { get; }

	/**
	 * {@inheritDoc}
	 */
	public abstract bool read_only { get; }

	/**
	 * {@inheritDoc}
	 */
	public abstract bool contains (G item);

	/**
	 * {@inheritDoc}
	 */
	public abstract bool add (G item);

	/**
	 * {@inheritDoc}
	 */
	public abstract bool remove (G item);

	/**
	 * {@inheritDoc}
	 */
	public abstract void clear ();

	/**
	 * {@inheritDoc}
	 */
	public abstract Iterator<G> iterator ();

	public virtual bool foreach (ForallFunc<G> f) {
		return iterator ().foreach (f);
	}

	private weak Collection<G> _read_only_view;

	/**
	 * {@inheritDoc}
	 */
	public virtual Collection<G> read_only_view {
		owned get {
			Collection<G> instance = _read_only_view;
			if (_read_only_view == null) {
				instance = new ReadOnlyCollection<G> (this);
				_read_only_view = instance;
				instance.add_weak_pointer ((void**) (&_read_only_view));
			}
			return instance;
		}
	}
}
