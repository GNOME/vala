/* abstractmultimap.vala
 *
 * Copyright (C) 2009  Ali Sabil
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
 * 	Ali Sabil <ali.sabil@gmail.com>
 * 	Didier 'Ptitjes Villevalois <ptitjes@free.fr>
 */

/**
 * Skeletal implementation of the {@link MultiMap} interface.
 *
 * @see HashMultiMap
 * @see TreeMultiMap
 */
public abstract class Vala.AbstractMultiMap<K,V> : Object, MultiMap<K,V> {
	public int size {
		get { return _nitems; }
	}

	public bool read_only {
		get { return false; }
	}

	protected Map<K, Collection<V>> _storage_map;
	private int _nitems = 0;

	public AbstractMultiMap (Map<K, Collection<V>> storage_map) {
		this._storage_map = storage_map;
	}

	public Set<K> get_keys () {
		return _storage_map.keys;
	}

	public MultiSet<K> get_all_keys () {
		return new AllKeys<K, V> (this);
	}

	public Collection<V> get_values () {
		return new Values<K, V> (this);
	}

	public bool contains (K key) {
		return _storage_map.has_key (key);
	}

	public new Collection<V> get (K key) {
		Collection<V>? col = _storage_map.get (key);
		return col != null ? col.read_only_view : Set.empty<V> ();
	}

	public new void set (K key, V value) {
		if (_storage_map.has_key (key)) {
			if (_storage_map.get (key).add (value)) {
				_nitems++;
			}
		} else {
			var s = create_value_storage ();
			s.add (value);
			_storage_map.set (key, s);
			_nitems++;
		}
	}

	public bool remove (K key, V value) {
		if (_storage_map.has_key (key)) {
			var values = _storage_map.get (key);
			if (values.contains (value)) {
				values.remove (value);
				_nitems--;
				if (values.size == 0) {
					_storage_map.unset (key);
				}
				return true;
			}
		}
		return false;
	}

	public bool remove_all (K key) {
		if (_storage_map.has_key (key)) {
			int size = _storage_map.get (key).size;
			if (_storage_map.unset (key)) {
				_nitems -= size;
				return true;
			}
		}
		return false;
	}

	public void clear () {
		_storage_map.clear ();
		_nitems = 0;
	}

	public Vala.MapIterator<K, V> map_iterator () {
		return new MapIterator<K, V> (_storage_map.map_iterator ());
	}

	protected abstract Collection<V> create_value_storage ();

	protected abstract MultiSet<K> create_multi_key_set ();

	protected abstract EqualDataFunc<V> get_value_equal_func ();

	private class AllKeys<K, V> : AbstractCollection<K>, MultiSet<K> {
		protected AbstractMultiMap<K, V> _multi_map;

		public AllKeys (AbstractMultiMap<K, V> multi_map) {
			_multi_map = multi_map;
		}

		public override Vala.Iterator<K> iterator () {
			return new KeyIterator<K, V> (_multi_map._storage_map.map_iterator ());
		}

		public override int size { get { return _multi_map.size; } }

		public override bool read_only { get { return true; } }

		public override bool contains (K key) {
			return _multi_map._storage_map.has_key (key);
		}

		public override bool add (K key) {
			assert_not_reached ();
		}

		public override  bool remove (K item) {
			assert_not_reached ();
		}

		public override void clear () {
			assert_not_reached ();
		}

		public int count (K item) {
			Collection<V>? collection = _multi_map._storage_map.get (item);
			return collection != null ? collection.size : 0;
		}
	}

	private class Values<K, V> : AbstractCollection<V> {
		protected AbstractMultiMap<K, V> _multi_map;

		public Values (AbstractMultiMap<K, V> multi_map) {
			_multi_map = multi_map;
		}

		public override Vala.Iterator<K> iterator () {
			return new ValueIterator<K, V> (_multi_map._storage_map.map_iterator ());
		}

		public override int size { get { return _multi_map.size; } }

		public override bool read_only { get { return true; } }

		public override bool contains (V value) {
			foreach (var col in _multi_map._storage_map.values) {
				if (col.contains (value)) {
					return true;
				}
			}
			return false;
		}

		public override bool add (V key) {
			assert_not_reached ();
		}

		public override  bool remove (V item) {
			assert_not_reached ();
		}

		public override void clear () {
			assert_not_reached ();
		}
	}

	private class MappingIterator<K, V> : Object {
		protected Vala.MapIterator<K, Collection<V>> outer;
		protected Iterator<V>? inner = null;

		public MappingIterator (Vala.MapIterator<K, Collection<V>>? outer) {
			this.outer = outer;
		}

		public bool next () {
			if (inner != null && inner.next ()) {
				return true;
			} else if (outer.next ()) {
				inner = outer.get_value ().iterator ();
				assert (inner.next ());
				return true;
			} else {
				return false;
			}
		}

		public bool has_next () {
			return inner.has_next () || outer.has_next ();
		}

		public void remove () {
			assert_not_reached ();
		}

		public virtual bool read_only {
			get {
				return true;
			}
		}

		public void unset () {
			inner.remove ();
			if (outer.get_value ().is_empty) {
				outer.unset ();
			}
		}

		public bool valid {
			get {
				return inner != null && inner.valid;
			}
		}
	}

	private class KeyIterator<K, V> : MappingIterator<K, V>, Traversable<K>, Iterator<K> {
		public KeyIterator (Vala.MapIterator<K, Collection<V>>? outer) {
			base (outer);
		}

		public new K get () {
			assert (valid);
			return outer.get_key ();
		}

		public bool foreach (ForallFunc<K> f) {
			if (inner != null && outer.valid) {
				K key = outer.get_key ();
				if (!inner.foreach ((v) => {return f (key);})) {
					return false;
				}
				outer.next ();
			}
			return outer.foreach ((key, col) => {
				return col.foreach ((v) => {return f (key);});
			});
		}
	}

	private class ValueIterator<K, V> : MappingIterator<K, V>, Traversable<V>, Iterator<V> {
		public ValueIterator (Vala.MapIterator<K, Collection<V>>? outer) {
			base (outer);
		}

		public new V get () {
			assert (valid);
			return inner.get ();
		}

		public bool foreach (ForallFunc<V> f) {
			if (inner != null && outer.valid) {
				if (!inner.foreach (f)) {
					return false;
				}
				outer.next ();
			}
			return outer.foreach ((key, col) => {
				return col.foreach (f);
			});
		}
	}

	private class MapIterator<K, V> : MappingIterator<K, V>, Vala.MapIterator<K, V> {
		public MapIterator (Vala.MapIterator<K, Collection<V>>? outer) {
			base (outer);
		}

		public K get_key () {
			assert (valid);
			return outer.get_key ();
		}

		public V get_value () {
			assert (valid);
			return inner.get ();
		}

		public void set_value (V value) {
			assert_not_reached ();
		}

		public bool mutable { get { return false; } }
	}
}
