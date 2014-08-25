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
 * Hash table implementation of the {@link Map} interface.
 *
 * This implementation is better fit for highly heterogenous key values.
 * In case of high key hashes redundancy or higher amount of data prefer using
 * tree implementation like {@link TreeMap}.
 *
 * @see TreeMap
 */
public class Vala.HashMap<K,V> : Vala.AbstractMap<K,V> {
	/**
	 * {@inheritDoc}
	 */
	public override int size {
		get { return _nnodes; }
	}

	/**
	 * {@inheritDoc}
	 */
	public override bool read_only {
		get { return false; }
	}

	/**
	 * {@inheritDoc}
	 */
	public override Set<K> keys {
		owned get {
			Set<K> keys = _keys;
			if (_keys == null) {
				keys = new KeySet<K,V> (this);
				_keys = keys;
				keys.add_weak_pointer ((void**) (&_keys));
			}
			return keys;
		}
	}

	/**
	 * {@inheritDoc}
	 */
	public override Collection<V> values {
		owned get {
			Collection<K> values = _values;
			if (_values == null) {
				values = new ValueCollection<K,V> (this);
				_values = values;
				values.add_weak_pointer ((void**) (&_values));
			}
			return values;
		}
	}

	/**
	 * {@inheritDoc}
	 */
	public override Set<Map.Entry<K,V>> entries {
		owned get {
			Set<Map.Entry<K,V>> entries = _entries;
			if (_entries == null) {
				entries = new EntrySet<K,V> (this);
				_entries = entries;
				entries.add_weak_pointer ((void**) (&_entries));
			}
			return entries;
		}
	}

	/**
	 * The keys' hash function.
	 */
	[CCode (notify = false)]
	public HashDataFunc<K> key_hash_func { private set; get; }

	/**
	 * The keys' equality testing function.
	 */
	[CCode (notify = false)]
	public EqualDataFunc<K> key_equal_func { private set; get; }

	/**
	 * The values' equality testing function.
	 */
	[CCode (notify = false)]
	public EqualDataFunc<V> value_equal_func { private set; get; }

	private int _array_size;
	private int _nnodes;
	private Node<K,V>[] _nodes;

	private weak Set<K> _keys;
	private weak Collection<V> _values;
	private weak Set<Map.Entry<K,V>> _entries;

	// concurrent modification protection
	private int _stamp = 0;

	private const int MIN_SIZE = 11;
	private const int MAX_SIZE = 13845163;

	/**
	 * Constructs a new, empty hash map.
	 *
	 * If not provided, the functions parameters are requested to the
	 * {@link Functions} function factory methods.
	 *
	 * @param key_hash_func an optional key hash function
	 * @param key_equal_func an optional key equality testing function
	 * @param value_equal_func an optional value equality testing function
	 */
	public HashMap (owned HashDataFunc<K>? key_hash_func = null, owned EqualDataFunc<K>? key_equal_func = null, owned EqualDataFunc<V>? value_equal_func = null) {
		if (key_hash_func == null) {
			key_hash_func = Functions.get_hash_func_for (typeof (K));
		}
		if (key_equal_func == null) {
			key_equal_func = Functions.get_equal_func_for (typeof (K));
		}
		if (value_equal_func == null) {
			value_equal_func = Functions.get_equal_func_for (typeof (V));
		}
		this.key_hash_func = key_hash_func;
		this.key_equal_func = key_equal_func;
		this.value_equal_func = value_equal_func;

		_array_size = MIN_SIZE;
		_nodes = new Node<K,V>[_array_size];
	}

	private Node<K,V>** lookup_node (K key) {
		uint hash_value = key_hash_func (key);
		Node<K,V>** node = &_nodes[hash_value % _array_size];
		while ((*node) != null && (hash_value != (*node)->key_hash || !key_equal_func ((*node)->key, key))) {
			node = &((*node)->next);
		}
		return node;
	}

	/**
	 * {@inheritDoc}
	 */
	public override bool has_key (K key) {
		Node<K,V>** node = lookup_node (key);
		return (*node != null);
	}

	/**
	 * {@inheritDoc}
	 */
	public override bool has (K key, V value) {
		Node<K,V>** node = lookup_node (key);
		return (*node != null && value_equal_func ((*node)->value, value));
	}

	/**
	 * {@inheritDoc}
	 */
	public override V? get (K key) {
		Node<K,V>* node = (*lookup_node (key));
		if (node != null) {
			return node->value;
		} else {
			return null;
		}
	}

	/**
	 * {@inheritDoc}
	 */
	public override void set (K key, V value) {
		Node<K,V>** node = lookup_node (key);
		if (*node != null) {
			(*node)->value = value;
		} else {
			uint hash_value = key_hash_func (key);
			*node = new Node<K,V> (key, value, hash_value);
			_nnodes++;
			resize ();
		}
		_stamp++;
	}

	/**
	 * {@inheritDoc}
	 */
	public override bool unset (K key, out V? value = null) {
		bool b = unset_helper (key, out value);
		if(b) {
			resize();
		}
		return b;
	}

	/**
	 * {@inheritDoc}
	 */
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

	/**
	 * {@inheritDoc}
	 */
	public override Vala.MapIterator<K,V> map_iterator () {
		return new MapIterator<K,V> (this);
	}

	private inline bool unset_helper (K key, out V? value = null) {
		Node<K,V>** node = lookup_node (key);
		if (*node != null) {
			Node<K,V> next = (owned) (*node)->next;

			value = (owned) (*node)->value;

			(*node)->key = null;
			(*node)->value = null;
			delete *node;

			*node = (owned) next;

			_nnodes--;
			_stamp++;
			return true;
		} else {
			value = null;
		}
		return false;
	}

	private inline void resize () {
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

	~HashMap () {
		clear ();
	}

	[Compact]
	private class Node<K,V> {
		public K key;
		public V value;
		public Node<K,V> next;
		public uint key_hash;
		public unowned Map.Entry<K,V>? entry;

		public Node (owned K k, owned V v, uint hash) {
			key = (owned) k;
			value = (owned) v;
			key_hash = hash;
			 entry = null;
		}
	}

	private class Entry<K,V> : Map.Entry<K,V> {
		private unowned Node<K,V> _node;

		public static Map.Entry<K,V> entry_for<K,V> (Node<K,V> node) {
			Map.Entry<K,V> result = node.entry;
			if (node.entry == null) {
				result = new Entry<K,V> (node);
				node.entry = result;
				result.add_weak_pointer ((void**) (&node.entry));
			}
			return result;
		}

		public Entry (Node<K,V> node) {
			_node = node;
		}

		public override K key { get { return _node.key; } }

		public override V value {
			get { return _node.value; }
			set { _node.value = value; }
		}

		public override bool read_only { get { return false; } }
	}

	private class KeySet<K,V> : AbstractSet<K> {
		private HashMap<K,V> _map;

		public KeySet (HashMap map) {
			_map = map;
		}

		public override Iterator<K> iterator () {
			return new KeyIterator<K,V> (_map);
		}

		public override int size {
			get { return _map.size; }
		}

		public override bool read_only {
			get { return true; }
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
			return _map.has_key (key);
		}

		public bool add_all (Collection<K> collection) {
			assert_not_reached ();
		}

		public bool remove_all (Collection<K> collection) {
			assert_not_reached ();
		}

		public bool retain_all (Collection<K> collection) {
			assert_not_reached ();
		}

	}

	private class ValueCollection<K,V> : AbstractCollection<V> {
		private HashMap<K,V> _map;

		public ValueCollection (HashMap map) {
			_map = map;
		}

		public override Iterator<V> iterator () {
			return new ValueIterator<K,V> (_map);
		}

		public override int size {
			get { return _map.size; }
		}

		public override bool read_only {
			get { return true; }
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
				if (_map.value_equal_func (it.get (), value)) {
					return true;
				}
			}
			return false;
		}

		public bool add_all (Collection<V> collection) {
			assert_not_reached ();
		}

		public bool remove_all (Collection<V> collection) {
			assert_not_reached ();
		}

		public bool retain_all (Collection<V> collection) {
			assert_not_reached ();
		}
	}

	private class EntrySet<K,V> : AbstractSet<Map.Entry<K, V>> {
		private HashMap<K,V> _map;

		public EntrySet (HashMap<K,V> map) {
			_map = map;
		}

		public override Iterator<Map.Entry<K, V>> iterator () {
			return new EntryIterator<K,V> (_map);
		}

		public override int size {
			get { return _map.size; }
		}

		public override bool read_only {
			get { return true; }
		}

		public override bool add (Map.Entry<K, V> entry) {
			assert_not_reached ();
		}

		public override void clear () {
			assert_not_reached ();
		}

		public override bool remove (Map.Entry<K, V> entry) {
			assert_not_reached ();
		}

		public override bool contains (Map.Entry<K, V> entry) {
			return _map.has (entry.key, entry.value);
		}

		public bool add_all (Collection<Map.Entry<K, V>> entries) {
			assert_not_reached ();
		}

		public bool remove_all (Collection<Map.Entry<K, V>> entries) {
			assert_not_reached ();
		}

		public bool retain_all (Collection<Map.Entry<K, V>> entries) {
			assert_not_reached ();
		}
	}

	private abstract class NodeIterator<K,V> : Object {
		protected HashMap<K,V> _map;
		protected int _index = -1;
		protected weak Node<K,V> _node;
		protected weak Node<K,V> _next;

		// concurrent modification protection
		protected int _stamp;

		public NodeIterator (HashMap map) {
			_map = map;
			_stamp = _map._stamp;
		}

		public bool next () {
			assert (_stamp == _map._stamp);
			if (!has_next ()) {
				return false;
			}
			_node = _next;
			_next = null;
			return (_node != null);
		}

		public bool has_next () {
			assert (_stamp == _map._stamp);
			if (_next == null) {
				_next = _node;
				if (_next != null) {
					_next = _next.next;
				}
				while (_next == null && _index + 1 < _map._array_size) {
					_index++;
					_next = _map._nodes[_index];
				}
			}
			return (_next != null);
		}

		public virtual bool read_only {
			get {
				return true;
			}
		}

		public bool valid {
			get {
				return _node != null;
			}
		}
	}

	private class KeyIterator<K,V> : NodeIterator<K,V>, Traversable<K>, Iterator<K> {
		public KeyIterator (HashMap map) {
			base (map);
		}

		public new K get () {
			assert (_stamp == _map._stamp);
			assert (_node != null);
			return _node.key;
		}

		public void remove () {
			assert_not_reached ();
		}

		public bool foreach(ForallFunc<K> f) {
			if (_node != null) {
				if (!f(_node.key)) {
					return false;
				}
				if(_next == null) {
					_next = _node.next;
				}
			}
			do {
				while(_next != null) {
					_node = _next;
					if (!f(_node.key)) {
						return false;
					}
					_next = _next.next;
				}
                                if (_index + 1 < _map._array_size) {
					_next = _map._nodes[++_index];
				} else {
					return true;
				}
			} while(true);
		}
	}

	private class MapIterator<K,V> : NodeIterator<K,V>, Vala.MapIterator<K,V> {
		public MapIterator (HashMap map) {
			base (map);
		}

		public new K get_key () {
			assert (_stamp == _map._stamp);
			assert (_node != null);
			return _node.key;
		}

		public void unset () {
			assert (_stamp == _map._stamp);
			assert (_node != null);
			has_next ();
			_map.unset_helper (_node.key);
			_node = null;
			_stamp = _map._stamp;
		}

		public V get_value () {
			assert (_stamp == _map._stamp);
			assert (_node != null);
			return _node.value;
		}

		public void set_value (V value) {
			assert (_stamp == _map._stamp);
			assert (_node != null);
			_map.set (_node.key, value);
			_stamp = _map._stamp;
		}

		public bool mutable {
			get {
				return true;
			}
		}

		public override bool read_only {
			get {
				return false;
			}
		}
	}

	private class ValueIterator<K,V> : NodeIterator<K,V>, Traversable<V>, Iterator<V> {
		public ValueIterator (HashMap map) {
			base (map);
		}

		public new V get () {
			assert (_stamp == _map._stamp);
			assert (_node != null);
			return _node.value;
		}

		public void remove () {
			assert_not_reached ();
		}

		public bool foreach(ForallFunc<V> f) {
			if (_node != null) {
				if (!f(_node.value)) {
					return false;
				}
				if(_next == null) {
					_next = _node.next;
				}
			}
			do {
				while(_next != null) {
					_node = _next;
					if (!f(_node.value)) {
						return false;
					}
					_next = _next.next;
				}
                                if (_index + 1 < _map._array_size) {
					_next = _map._nodes[++_index];
				} else {
					return true;
				}
			} while(true);
		}
	}

	private class EntryIterator<K,V> : NodeIterator<K,V>, Traversable<Map.Entry<K,V>>, Iterator<Map.Entry<K,V>> {
		public EntryIterator (HashMap map) {
			base (map);
		}

		public new Map.Entry<K,V> get () {
			assert (_stamp == _map._stamp);
			assert (_node != null);
			return Entry<K,V>.entry_for<K,V> (_node);
		}

		public void remove () {
			assert_not_reached ();
		}

		public bool foreach(ForallFunc<Map.Entry<K,V>> f) {
			if (_node != null) {
				if (!f(Entry<K,V>.entry_for<K,V> (_node))) {
					return false;
				}
				if(_next == null) {
					_next = _node.next;
				}
			}
			do {
				while(_next != null) {
					_node = _next;
					if (!f(Entry<K,V>.entry_for<K,V> (_node))) {
						return false;
					}
					_next = _next.next;
				}
                                if (_index + 1 < _map._array_size) {
					_next = _map._nodes[++_index];
				} else {
					return true;
				}
			} while(true);
		}
	}
}

