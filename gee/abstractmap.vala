/* abstractmap.vala
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
 * 	Tomaž Vajngerl <quikee@gmail.com>
 */

/**
 * Skeletal implementation of the {@link Map} interface.
 *
 * Contains common code shared by all map implementations.
 *
 * @see HashMap
 * @see TreeMap
 */
public abstract class Vala.AbstractMap<K,V> : Object, Traversable<Map.Entry<K,V>>, Iterable<Map.Entry<K,V>>, Map<K,V> {

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
	public abstract Set<K> keys { owned get; }

	/**
	 * {@inheritDoc}
	 */
	public abstract Collection<V> values { owned get; }

	/**
	 * {@inheritDoc}
	 */
	public abstract Set<Map.Entry<K,V>> entries { owned get; }

	/**
	 * {@inheritDoc}
	 */
	public abstract bool has_key (K key);

	/**
	 * {@inheritDoc}
	 */
	public abstract bool has (K key, V value);

	/**
	 * {@inheritDoc}
	 */
	public abstract new V? get (K key);

	/**
	 * {@inheritDoc}
	 */
	public abstract new void set (K key, V value);

	/**
	 * {@inheritDoc}
	 */
	public abstract bool unset (K key, out V? value = null);

	/**
	 * {@inheritDoc}
	 */
	public abstract MapIterator<K,V> map_iterator ();

	/**
	 * {@inheritDoc}
	 */
	public abstract void clear ();

	private weak Map<K,V> _read_only_view;

	/**
	 * {@inheritDoc}
	 */
	public virtual Map<K,V> read_only_view {
		owned get {
			Map<K,V> instance = _read_only_view;
			if (_read_only_view == null) {
				instance = new ReadOnlyMap<K,V> (this);
				_read_only_view = instance;
				instance.add_weak_pointer ((void**) (&_read_only_view));
			}
			return instance;
		}
	}

	/**
	 * {@inheritDoc}
	 */
	public Iterator<Map.Entry<K,V>> iterator () {
		return entries.iterator ();
	}

	/**
	 * {@inheritDoc}
	 */
	public virtual bool foreach (ForallFunc<Map.Entry<K,V>> f) {
		return iterator ().foreach (f);
	}

	/**
	 * {@inheritDoc}
	 */
	public virtual Iterator<A> stream<A> (owned StreamFunc<Map.Entry<K,V>, A> f) {
		return iterator ().stream<A> ((owned) f);
	}
}
