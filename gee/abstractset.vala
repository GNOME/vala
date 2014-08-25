/* abstractset.vala
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
 * 	Julien Peeters <contact@julienpeeters.fr>
 */

/**
 * Skeletal implementation of the {@link Set} interface.
 *
 * Contains common code shared by all set implementations.
 *
 * @see HashSet
 * @see TreeSet
 */
public abstract class Vala.AbstractSet<G> : Vala.AbstractCollection<G>, Set<G> {

	private weak Set<G> _read_only_view;

	/**
	 * {@inheritDoc}
	 */
	public virtual new Set<G> read_only_view {
		owned get {
			Set<G> instance = _read_only_view;
			if (_read_only_view == null) {
				instance = new ReadOnlySet<G> (this);
				_read_only_view = instance;
				instance.add_weak_pointer ((void**) (&_read_only_view));
			}
			return instance;
		}
	}
}
