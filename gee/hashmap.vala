/* hashmap.vala
 *
 * Copyright (C) 1995-1997  Peter Mattis, Spencer Kimball and Josh MacDonald
 * Copyright (C) 1997-2000  GLib Team and others
 * Copyright (C) 2007-2009  Jürg Billeter
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
 * 	Jürg Billeter <j@bitron.ch>
 */

using GLib;

/**
 * Hashtable implementation of the Map interface.
 */
public class Vala.HashMap<K,V> : Map<K,V> {
	public override int size {
		get { return _nnodes; }
	}

	public HashFunc key_hash_func {
		set { _key_hash_func = value; }
	}

	public EqualFunc key_equal_func {
		set { _key_equal_func = value; }
	}

	public EqualFunc value_equal_func {
		set { _value_equal_func = value; }
	}

	private int _array_size;
	private int _nnodes;
	private Node<K,V>[] _nodes;

	// concurrent modification protection
	private int _stamp = 0;

	private HashFunc _key_hash_func;
	private EqualFunc _key_equal_func;
	private EqualFunc _value_equal_func;

	private const int MIN_SIZE = 11;
	private const int MAX_SIZE = 13845163;

	public HashMap (HashFunc key_hash_func = GLib.direct_hash, EqualFunc key_equal_func = GLib.direct_equal, EqualFunc value_equal_func = GLib.direct_equal) {
		this.key_hash_func = key_hash_func;
		this.key_equal_func = key_equal_func;
		this.value_equal_func = value_equal_func;
		_array_size = MIN_SIZE;
		_nodes = new Node<K,V>[_array_size];
	}

	public override Set<K> get_keys () {
		return new KeySet<K,V> (this);
	}

	public override Collection<V> get_values () {
		return new ValueCollection<K,V> (this);
	}

	public override Vala.MapIterator<K,V> map_iterator () {
		return new MapIterator<K,V> (this);
	}

	private Node<K,V>** lookup_node (K key) {
		uint hash_value = _key_hash_func (key);
		Node<K,V>** node = &_nodes[hash_value % _array_size];
		while ((*node) != null && (hash_value != (*node)->key_hash || !_key_equal_func ((*node)->key, key))) {
			node = &((*node)->next);
		}
		return node;
	}

	public override bool contains (K key) {
		Node<K,V>** node = lookup_node (key);
		return (*node != null);
	}

	public override V? get (K key) {
		Node<K,V>* node = (*lookup_node (key));
		if (node != null) {
			return node->value;
		} else {
			return null;
		}
	}

	public override void set (K key, V value) {
		Node<K,V>** node = lookup_node (key);
		if (*node != null) {
			(*node)->value = value;
		} else {
			uint hash_value = _key_hash_func (key);
			*node = new Node<K,V> (key, value, hash_value);
			_nnodes++;
			resize ();
		}
		_stamp++;
	}

	public override bool remove (K key) {
		Node<K,V>** node = lookup_node (key);
		if (*node != null) {
			Node<K,V> next = (owned) (*node)->next;

			(*node)->key = null;
			(*node)->value = null;
			delete *node;

			*node = (owned) next;

			_nnodes--;
			resize ();
			_stamp++;
			return true;
		}
		return false;
	}

	public override void clear () {
		for (int i = 0; i < _array_size; i++) {
			Node<K,V> node = (owned) _nodes[i];
			while (node != null) {
				Node next = (owned) node.next;
				node.key = null;
				node.value = null;
				node = (owned) next;
			}
		}
		_nnodes = 0;
		resize ();
	}

	private void resize () {
		if ((_array_size >= 3 * _nnodes && _array_size >= MIN_SIZE) ||
		    (3 * _array_size <= _nnodes && _array_size < MAX_SIZE)) {
			int new_array_size = (int) SpacedPrimes.closest (_nnodes);
			new_array_size = new_array_size.clamp (MIN_SIZE, MAX_SIZE);

			Node<K,V>[] new_nodes = new Node<K,V>[new_array_size];

			for (int i = 0; i < _array_size; i++) {
				Node<K,V> node;
				Node<K,V> next = null;
				for (node = (owned) _nodes[i]; node != null; node = (owned) next) {
					next = (owned) node.next;
					uint hash_val = node.key_hash % new_array_size;
					node.next = (owned) new_nodes[hash_val];
					new_nodes[hash_val] = (owned) node;
				}
			}
			_nodes = (owned) new_nodes;
			_array_size = new_array_size;
		}
	}

	~HashSet () {
		clear ();
	}

	[Compact]
	private class Node<K,V> {
		public K key;
		public V value;
		public Node<K,V> next;
		public uint key_hash;

		public Node (owned K k, owned V v, uint hash) {
			key = (owned) k;
			value = (owned) v;
			key_hash = hash;
		}
	}

	private class KeySet<K,V> : Set<K> {
		public HashMap<K,V> map {
			set { _map = value; }
		}

		private HashMap<K,V> _map;

		public KeySet (HashMap map) {
			this.map = map;
		}

		public override Type get_element_type () {
			return typeof (K);
		}

		public override Iterator<K> iterator () {
			return new KeyIterator<K,V> (_map);
		}

		public override int size {
			get { return _map.size; }
		}

		public override bool add (K key) {
			assert_not_reached ();
		}

		public override void clear () {
			assert_not_reached ();
		}

		public override bool remove (K key) {
			assert_not_reached ();
		}

		public override bool contains (K key) {
			return _map.contains (key);
		}
	}

	private class MapIterator<K,V> : Vala.MapIterator<K, V> {
		public HashMap<K,V> map {
			set {
				_map = value;
				_stamp = _map._stamp;
			}
		}

		private HashMap<K,V> _map;
		private int _index = -1;
		private weak Node<K,V> _node;

		// concurrent modification protection
		private int _stamp;

		public MapIterator (HashMap map) {
			this.map = map;
		}

		public override bool next () {
			if (_node != null) {
				_node = _node.next;
			}
			while (_node == null && _index + 1 < _map._array_size) {
				_index++;
				_node = _map._nodes[_index];
			}
			return (_node != null);
		}

		public override K? get_key () {
			assert (_stamp == _map._stamp);
			assert (_node != null);
			return _node.key;
		}

		public override V? get_value () {
			assert (_stamp == _map._stamp);
			assert (_node != null);
			return _node.value;
		}
	}

	private class KeyIterator<K,V> : Iterator<K> {
		public HashMap<K,V> map {
			set {
				_map = value;
				_stamp = _map._stamp;
			}
		}

		private HashMap<K,V> _map;
		private int _index = -1;
		private weak Node<K,V> _node;

		// concurrent modification protection
		private int _stamp;

		public KeyIterator (HashMap map) {
			this.map = map;
		}

		public override bool next () {
			if (_node != null) {
				_node = _node.next;
			}
			while (_node == null && _index + 1 < _map._array_size) {
				_index++;
				_node = _map._nodes[_index];
			}
			return (_node != null);
		}

		public override K? get () {
			assert (_stamp == _map._stamp);
			assert (_node != null);
			return _node.key;
		}
	}

	private class ValueCollection<K,V> : Collection<V> {
		public HashMap<K,V> map {
			set { _map = value; }
		}

		private HashMap<K,V> _map;

		public ValueCollection (HashMap map) {
			this.map = map;
		}

		public override Type get_element_type () {
			return typeof (V);
		}

		public override Iterator<V> iterator () {
			return new ValueIterator<K,V> (_map);
		}

		public override int size {
			get { return _map.size; }
		}

		public override bool add (V value) {
			assert_not_reached ();
		}

		public override void clear () {
			assert_not_reached ();
		}

		public override bool remove (V value) {
			assert_not_reached ();
		}

		public override bool contains (V value) {
			Iterator<V> it = iterator ();
			while (it.next ()) {
				if (_map._value_equal_func (it.get (), value)) {
					return true;
				}
			}
			return false;
		}
	}

	private class ValueIterator<K,V> : Iterator<V> {
		public HashMap<K,V> map {
			set {
				_map = value;
				_stamp = _map._stamp;
			}
		}

		private HashMap<V,K> _map;
		private int _index = -1;
		private weak Node<K,V> _node;

		// concurrent modification protection
		private int _stamp;

		public ValueIterator (HashMap map) {
			this.map = map;
		}

		public override bool next () {
			if (_node != null) {
				_node = _node.next;
			}
			while (_node == null && _index + 1 < _map._array_size) {
				_index++;
				_node = _map._nodes[_index];
			}
			return (_node != null);
		}

		public override V? get () {
			assert (_stamp == _map._stamp);
			assert (_node != null);
			return _node.value;
		}
	}
}

