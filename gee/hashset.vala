/* hashset.vala
 *
 * Copyright (C) 1995-1997  Peter Mattis, Spencer Kimball and Josh MacDonald
 * Copyright (C) 1997-2000  GLib Team and others
 * Copyright (C) 2007-2009  Jürg Billeter
 * Copyright (C) 2009-2014  Maciej Piechotka
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

namespace Vala {
	/**
	 * A function producing a hash for an object. Two hashes of equal
	 * objects (as specified by corresponding {@link EqualDataFunc}) have to
	 * be equal.
	 *
	 * Note: Hash for a given object //must not// change during the lifetime
	 *   of delegate.
	 *
	 * @param v Hashed value
	 * @return Hash for given value
	 *
	 * @see Hashable
	 */
	public delegate uint HashDataFunc<T> (T v);
	/**
	 * A function comparing two object defining equivalence relationship.
	 *
	 * In other words if `equal_to` is `EqualDataFunc` then:
	 *
	 *  * It must be reflexive: for all objects `a` it holds that
	 *    `equal_to(a, a)`.
	 *  * It must be symmetric: for all objects `a` and `b` if
	 *    `equal_to(a, b)` then `equal_to(b, a)`.
	 *  * It must be transitive: if `equal_to(a, b)` and `equal_to(b, c)`
	 *    then `equal_to(a, c)`
	 *
	 * Note: The relationship //must not// change during lifetime of the
	 *   delegate.
	 *
	 * @param a First value
	 * @param b Second value
	 * @return Whether values are equal
	 *
	 * @see Hashable
	 */
	public delegate bool EqualDataFunc<T> (T a, T b);
}

/**
 * Hash table implementation of the {@link Set} interface.
 *
 * This implementation is better fit for highly heterogenous values.
 * In case of high value hashes redundancy or higher amount of data prefer using
 * tree implementation like {@link TreeSet}.
 *
 * @see TreeSet
 */
public class Vala.HashSet<G> : AbstractSet<G> {
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
	 * The elements' hash function.
	 */
	[CCode (notify = false)]
	public HashDataFunc<G> hash_func {
		private set {}
		get {
			return _hash_func.func;
		}
	}

	/**
	 * The elements' equality testing function.
	 */
	[CCode (notify = false)]
	public EqualDataFunc<G> equal_func {
		private set {}
		get {
			return _equal_func.func;
		}
	}

	private int _array_size;
	private int _nnodes;
	private Node<G>[] _nodes;
	private Functions.HashDataFuncClosure<G> _hash_func;
	private Functions.EqualDataFuncClosure<G> _equal_func;

	// concurrent modification protection
	private int _stamp = 0;

	private const int MIN_SIZE = 11;
	private const int MAX_SIZE = 13845163;

	/**
	 * Constructs a new, empty hash set.
	 *
	 * If not provided, the functions parameters are requested to the
	 * {@link Functions} function factory methods.
	 *
	 * @param hash_func an optional hash function
	 * @param equal_func an optional equality testing function
	 */
	public HashSet (owned HashDataFunc<G>? hash_func = null, owned EqualDataFunc<G>? equal_func = null) {
		if (hash_func == null) {
			hash_func = Functions.get_hash_func_for (typeof (G));
		}
		if (equal_func == null) {
			equal_func = Functions.get_equal_func_for (typeof (G));
		}
		_hash_func = new Functions.HashDataFuncClosure<G> ((owned)hash_func);
		_equal_func = new Functions.EqualDataFuncClosure<G> ((owned)equal_func);
		_array_size = MIN_SIZE;
		_nodes = new Node<G>[_array_size];
	}

	internal HashSet.with_closures (owned Functions.HashDataFuncClosure<G> hash_func, owned Functions.EqualDataFuncClosure<G> equal_func) {
		_hash_func = hash_func;
		_equal_func = equal_func;
		_array_size = MIN_SIZE;
		_nodes = new Node<G>[_array_size];
	}

	private Node<G>** lookup_node (G key) {
		uint hash_value = hash_func (key);
		Node<G>** node = &_nodes[hash_value % _array_size];
		while ((*node) != null && (hash_value != (*node)->key_hash || !equal_func ((*node)->key, key))) {
			node = &((*node)->next);
		}
		return node;
	}

	/**
	 * {@inheritDoc}
	 */
	public override bool contains (G key) {
		Node<G>** node = lookup_node (key);
		return (*node != null);
	}

	/**
	 * {@inheritDoc}
	 */
	public override Vala.Iterator<G> iterator () {
		return new Iterator<G> (this);
	}

	/**
	 * {@inheritDoc}
	 */
	public override bool add (G key) {
		Node<G>** node = lookup_node (key);
		if (*node != null) {
			return false;
		} else {
			uint hash_value = hash_func (key);
			*node = new Node<G> (key, hash_value);
			_nnodes++;
			resize ();
			_stamp++;
			return true;
		}
	}

	/**
	 * {@inheritDoc}
	 */
	public override bool remove (G key) {
		bool b = remove_helper(key);
		if(b) {
			resize ();
		}
		return b;
	}

	/**
	 * {@inheritDoc}
	 */
	public override void clear () {
		for (int i = 0; i < _array_size; i++) {
			Node<G> node = (owned) _nodes[i];
			while (node != null) {
				Node next = (owned) node.next;
				node.key = null;
				node = (owned) next;
			}
		}
		_nnodes = 0;
		resize ();
	}

	/**
	 * {@inheritDoc}
	 */
	public override bool foreach (ForallFunc<G> f) {
		for (int i = 0; i < _array_size; i++) {
			for (unowned Node<G>? current = _nodes[i]; current != null; current = current.next) {
				if (!f (current.key)) {
					return false;
				}
			}
		}
		return true;
	}

	private inline bool remove_helper (G key) {
		Node<G>** node = lookup_node (key);
		if (*node != null) {
			assert (*node != null);
			Node<G> next = (owned) (*node)->next;

			(*node)->key = null;
			delete *node;

			*node = (owned) next;

			_nnodes--;
			_stamp++;
			return true;
		}
		return false;
	}

	private void resize () {
		if ((_array_size >= 3 * _nnodes && _array_size >= MIN_SIZE) ||
		    (3 * _array_size <= _nnodes && _array_size < MAX_SIZE)) {
			int new_array_size = (int) SpacedPrimes.closest (_nnodes);
			new_array_size = new_array_size.clamp (MIN_SIZE, MAX_SIZE);

			Node<G>[] new_nodes = new Node<G>[new_array_size];

			for (int i = 0; i < _array_size; i++) {
				Node<G> node;
				Node<G> next = null;
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
	private class Node<G> {
		public G key;
		public Node<G> next;
		public uint key_hash;

		public Node (owned G k, uint hash) {
			key = (owned) k;
			key_hash = hash;
		}
	}

	private class Iterator<G> : Object, Traversable<G>, Vala.Iterator<G> {
		public Iterator (HashSet<G> set) {
			_set = set;
			_stamp = _set._stamp;
		}

		public Iterator.from_iterator (Iterator<G> iter) {
			_set = iter._set;
			_index = iter._index;
			_node = iter._node;
			_next = iter._next;
		}

		public bool next () {
			assert (_stamp == _set._stamp);
			if (!has_next ()) {
				return false;
			}
			_node = _next;
			_next = null;
			return (_node != null);
		}

		public bool has_next () {
			assert (_stamp == _set._stamp);
			if (_next == null) {
				_next = _node;
				if (_next != null) {
					_next = _next.next;
				}
				while (_next == null && _index + 1 < _set._array_size) {
					_index++;
					_next = _set._nodes[_index];
				}
			}
			return (_next != null);
		}

		public new G get () {
			assert (_stamp == _set._stamp);
			assert (_node != null);
			return _node.key;
		}

		public void remove () {
			assert (_stamp == _set._stamp);
			assert (_node != null);
			has_next ();
			_set.remove_helper (_node.key);
			_node = null;
			_stamp = _set._stamp;
		}

		public bool read_only {
			get {
				return false;
			}
		}

		public bool valid {
			get {
				return _node != null;
			}
		}

		public bool foreach (ForallFunc<G> f) {
			assert (_stamp == _set._stamp);
			unowned Node<G>? node = _node, next = _next, current = null, prev = null;
			if (node != null) {
				if (!f (node.key)) {
					return false;
				}
				prev = node;
				current = node.next;
			}
			if (next != null) {
				if (!f (next.key)) {
					_node = next;
					_next = null;
					return false;
				}
				prev = next;
				current = next.next;
			}
			do {
				while (current != null) {
					if (!f (current.key)) {
						_node = current;
						_next = null;
						return false;
					}
					prev = current;
					current = current.next;
				}
				while (current == null && _index + 1 < _set._array_size) {
					_index++;
					current = _set._nodes[_index];
				}
			} while (current != null);
			_node = prev;
			_next = null;
			return true;
		}

		public Vala.Iterator<G>[] tee (uint forks) {
			if (forks == 0) {
				return new Vala.Iterator<G>[0];
			} else {
				Vala.Iterator<G>[] result = new Vala.Iterator<G>[forks];
				result[0] = this;
				for (uint i = 1; i < forks; i++) {
					result[0] = new Iterator<G>.from_iterator (this);
				}
				return result;
			}
		}

		protected HashSet<G> _set;
		protected int _index = -1;
		protected weak Node<G> _node;
		protected weak Node<G> _next;
		protected int _stamp = 0;
	}
}

