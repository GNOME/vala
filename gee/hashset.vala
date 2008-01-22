/* hashset.vala
 *
 * Copyright (C) 1995-1997  Peter Mattis, Spencer Kimball and Josh MacDonald
 * Copyright (C) 1997-2000  GLib Team and others
 * Copyright (C) 2007-2008  Jürg Billeter
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
 * Hashtable implementation of the Set interface.
 */
public class Gee.HashSet<G> : Object, Iterable<G>, Collection<G>, Set<G> {
	public int size {
		get { return _nnodes; }
	}

	public HashFunc hash_func {
		set { _hash_func = value; }
	}

	public EqualFunc equal_func {
		set { _equal_func = value; }
	}

	private int _array_size;
	private int _nnodes;
	private Node<G>[] _nodes;

	// concurrent modification protection
	private int _stamp = 0;

	private HashFunc _hash_func;
	private EqualFunc _equal_func;

	private const int MIN_SIZE = 11;
	private const int MAX_SIZE = 13845163;

	public HashSet (construct HashFunc hash_func = GLib.direct_hash, construct EqualFunc equal_func = GLib.direct_equal) {
	}

	construct {
		_array_size = MIN_SIZE;
		_nodes = new Node<G>[_array_size];
	}

	private Node<G>** lookup_node (G key) {
		uint hash_value = _hash_func (key);
		Node<G>** node = &_nodes[hash_value % _array_size];
		while ((*node) != null && (hash_value != (*node)->key_hash || !_equal_func ((*node)->key, key))) {
			node = &((*node)->next);
		}
		return node;
	}

	public bool contains (G key) {
		Node<G>** node = lookup_node (key);
		return (*node != null);
	}

	public Gee.Iterator<G> iterator () {
		return new Iterator<G> (this);
	}

	public bool add (G key) {
		Node<G>** node = lookup_node (key);
		if (*node != null) {
			return false;
		} else {
			uint hash_value = _hash_func (key);
			*node = new Node<G> (key, hash_value);
			_nnodes++;
			resize ();
			_stamp++;
			return true;
		}
	}

	public bool remove (G key) {
		Node<G>** node = lookup_node (key);
		if (*node != null) {
			(*node)->key = null;
			*node = (*node)->next;
			_nnodes--;
			resize ();
			_stamp++;
			return true;
		}
		return false;
	}

	public void clear () {
		for (int i = 0; i < _array_size; i++) {
			Node<G> node = #_nodes[i];
			while (node != null) {
				Node next = #node.next;
				node.key = null;
				node = #next;
			}
		}
		_nnodes = 0;
		resize ();
	}

	private void resize () {
		if ((_array_size >= 3 * _nnodes && _array_size >= MIN_SIZE) ||
		    (3 * _array_size <= _nnodes && _array_size < MAX_SIZE)) {
			int new_array_size = SpacedPrimes.closest (_nnodes);
			new_array_size = new_array_size.clamp (MIN_SIZE, MAX_SIZE);

			Node<G>[] new_nodes = new Node<G>[new_array_size];

			for (int i = 0; i < _array_size; i++) {
				Node<G> node;
				Node<G> next;
				for (node = #_nodes[i]; node != null; node = #next) {
					next = #node.next;
					uint hash_val = node.key_hash % new_array_size;
					node.next = #new_nodes[hash_val];
					new_nodes[hash_val] = #node;
				}
			}
			_nodes = #new_nodes;
			_array_size = new_array_size;
		}
	}

	~HashSet () {
		clear ();
	}

	private class Node<G> {
		public G key;
		public Node<G> next;
		public uint key_hash;

		public Node (G# k, uint hash) {
			key = #k;
			key_hash = hash;
		}
	}

	private class Iterator<G> : Object, Gee.Iterator<G> {
		public HashSet<G> set {
			set {
				_set = value;
				_stamp = _set._stamp;
				// find first node
				while (_node == null && _index + 1 < _set._array_size) {
					_index++;
					_node = _set._nodes[_index];
				}
			}
		}

		private HashSet<G> _set;
		private int _index = -1;
		private weak Node<G> _node;

		// concurrent modification protection
		private int _stamp = 0;

		public Iterator (construct HashSet! set) {
		}

		public bool next () {
			if (_node != null) {
				_node = _node.next;
			}
			while (_node == null && _index + 1 < _set._array_size) {
				_index++;
				_node = _set._nodes[_index];
			}
			return (_node != null);
		}

		public G get () {
			assert (_stamp == _set._stamp);
			assert (_node != null);
			return _node.key;
		}
	}
}

