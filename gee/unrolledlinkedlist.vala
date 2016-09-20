/* unrolledlinkedlist.vala
 *
 * Copyright (C) 2013-2014  Maciej Piechotka
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

using Vala.Utils.Assume;

/**
 * Unrolled doubly-linked list implementation of the {@link List} interface.
 *
 * The unrolled doubly-linked list combines the advantages and disadvantages
 * of the {@link ArrayList} and {@link LinkedList} and is usually suitable when
 * modifications and read operations are balanced.
 *
 * Please note that in our benchmarks the speed of most operations (insertion,
 * deletion, sequential read) was on par or better then {@link ArrayList} and
 * {@link LinkedList} except the prepending operation.
 *
 * @see ArrayList
 * @see LinkedList
 */
public class Vala.UnrolledLinkedList<G> : AbstractBidirList<G>, Queue<G>, Deque<G> {
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

	/**
	 * Constructs a new, empty linked list.
	 *
	 * If not provided, the function parameter is requested to the
	 * {@link Functions} function factory methods.
	 *
	 * @param equal_func an optional element equality testing function
	 */
	public UnrolledLinkedList (owned EqualDataFunc<G>? equal_func = null) {
		if (equal_func == null) {
			equal_func = Functions.get_equal_func_for (typeof (G));
		}
		_equal_func = new Functions.EqualDataFuncClosure<G> ((owned)equal_func);
	}

	private UnrolledLinkedList.with_closures (owned Functions.EqualDataFuncClosure<G> equal_func) {
		_equal_func = equal_func;
	}

	~UnrolledLinkedList () {
		this.clear ();
	}

	public override bool foreach (ForallFunc<G> f) {
#if DUMP
		stdout.printf ("FOREACH BEGIN %p\n", this);
		dump ();
		try {
#endif
		for (unowned Node<G>? node = _head; node != null; node = node._next) {
			for (int pos = 0; pos < node._size; pos++) {
				if (! f(node._data[pos])) {
					return false;
				}
			}
		}
		return true;
#if DUMP
		} finally {
		dump();
		stdout.printf ("FOREACH END\n");
		}
#endif
	}

	public override int size { get {return _size;} }
	public override bool read_only { get {return false;} }

	public override Vala.Iterator<G> iterator () {
		return new Iterator<G> (this);
	}

	public override bool contains (G item) {
		return find_node (item) != null;
	}

	public override bool add (G item) {
#if DUMP
		stdout.printf ("ADD BEGIN %p (%s)\n", item, (string)item);
		dump ();
#endif
		if (_tail == null) {
#if !DISABLE_INTERNAL_ASSERTS
			assert (_head == null);
#else
			assume (_head == null);
#endif
			_tail = _head = new Node<G>();
		}
		add_to_node (_tail, item, _tail._size);
#if DUMP
		dump ();
		stdout.printf ("ADD END\n");
#endif
#if CONSISTENCY_CHECKS
		check ();
#endif
		return true;
	}
	public override bool remove (G item) {
		int pos;
		unowned Node<G>? node = find_node (item, out pos);
		if (node != null) {
			remove_from_node (node, pos);
		}
#if CONSISTENCY_CHECKS
		check ();
#endif
		return node != null;
	}

	public override void clear () {
		for (Node<G>? node = (owned)_head; node != null; node = (owned)node._next) {
			for (uint pos = 0; pos < node._size; pos++) {
				node._data[pos] = null;
			}
		}
		_head = null;
		_tail = null;
		_stamp++;
		_size = 0;
#if CONSISTENCY_CHECKS
		check ();
#endif
	}

	public override ListIterator<G> list_iterator () {
		return new Iterator<G> (this);
	}

	public override G? get (int index) {
		assert (index >= 0);
		assert (index < this._size);

#if CONSISTENCY_CHECKS
		check ();
#endif

		int pos;
		unowned Node<G>? node = find_node_by_idx (index, out pos);
#if !DISABLE_INTERNAL_ASSERTS
		assert (node != null);
#endif
		return node._data[pos];
	}

	public override void set (int index, G item) {
		assert (index >= 0);
		assert (index < this._size);

		int pos;
		unowned Node<G>? node = find_node_by_idx (index, out pos);
#if !DISABLE_INTERNAL_ASSERTS
		assert (node != null);
#endif
		node._data[pos] = item;
	}

	public override int index_of (G item) {
		int idx;
		if (find_node (item, null, out idx) != null) {
			return idx;
		} else {
			return -1;
		}
	}

	public override void insert (int index, G item) {
#if DUMP
		stdout.printf ("INSERT BEGIN %p (%s)\n", item, (string)item);
		dump ();
#endif
		assert (index >= 0);
		assert (index <= this._size);

		if (index != this._size) {
			int pos;
			unowned Node<G>? node = find_node_by_idx (index, out pos);
#if !DISABLE_INTERNAL_ASSERTS
			assert (node != null);
#endif
			add_to_node (node, item, pos);
		} else {
			if (index == 0) {

#if !DISABLE_INTERNAL_ASSERTS
				assert (_head == null && _tail == null);
#else
				assume (_head == null && _tail == null);
#endif
				_tail = _head = new Node<G>();
			}
			add_to_node (_tail, item, _tail._size);
		}
#if DUMP
		dump ();
		stdout.printf ("INSERT END\n");
#endif
#if CONSISTENCY_CHECKS
		check ();
#endif
	}

	public override G remove_at (int index) {
		assert (index >= 0);
		assert (index < this._size);

		int pos;
		unowned Node<G>? node = find_node_by_idx (index, out pos);
#if !DISABLE_INTERNAL_ASSERTS
		assert (node != null);
#endif
		return remove_from_node (node, pos);
	}

	public override List<G>? slice (int start, int stop) {
		assert (0 <= start && start <= stop && stop <= _size);

		UnrolledLinkedList<G> slice = new UnrolledLinkedList<G>.with_closures (_equal_func);
		slice._size = stop - start;
		unowned Node<G>? copy = slice._head = new Node<G> ();

		int orig_pos;
		unowned Node<G>? orig = find_node_by_idx (start, out orig_pos);
#if !DISABLE_INTERNAL_ASSERTS
		assert (orig != null);
#endif

		int i = 0;
		while (true) {
			int j = 0;
			while (j < NODE_SIZE && i < stop - start) {
				copy._data[j] = orig._data[orig_pos];
				i++;
				j++;
				orig_pos++;
				if (unlikely (orig_pos == orig._size)) {
					orig = orig._next;
					orig_pos = 0;
				}

			}
			copy._size = j;
			if (unlikely (!(i < stop - start))) {
				break;
			}
			copy._next = new Node<G> ();
			copy._next._prev = copy;
			copy = copy._next;
		}
		slice._tail = copy;
#if CONSISTENCY_CHECKS
		slice.check ();
#endif
		return slice;
	}

	public override BidirListIterator<G> bidir_list_iterator () {
		return new Iterator<G> (this);
	}

	public int capacity { get { return Queue.UNBOUNDED_CAPACITY; } }

	public int remaining_capacity { get { return Queue.UNBOUNDED_CAPACITY; } }

	public bool is_full { get { return false; } }

	public bool offer (G element) {
		if (_tail == null) {
#if !DISABLE_INTERNAL_ASSERTS
			assert (_head == null);
#else
			assume (_head == null);
#endif
			_tail = _head = new Node<G>();
		}
#if !DISABLE_INTERNAL_ASSERTS
		assert (_head != null && _tail != null);
#else
		assume (_head != null && _tail != null);
#endif
		add_to_node (_tail, element, _tail._size);
		return true;
	}

	public G? peek () {
		if (_head != null) {
			return _head._data[0];
		} else {
			return null;
		}
	}

	public G? poll () {
		if (_head != null) {
			return remove_from_node (_head, 0);
		} else {
			return null;
		}
	}

	public int drain (Collection<G> recipient, int amount = -1) {
		int drained = 0;
		if (amount < 0) {
			for (Node<G>? node = (owned)_head; node != null; node = (owned)node._next) {
				for (int i = 0; i < node._size; i++) {
					G data = (owned)node._data[i];
					recipient.add (data);
				}
			}
			drained = _size;
			_tail = null;
			_size = 0;
			_stamp++;
#if CONSISTENCY_CHECKS
			check ();
#endif
			return drained;
		} else {
			Node<G>? node;
			for (node = (owned)_head; node != null; node = (owned)node._next) {
				if (likely (node._size <= amount)) {
					for (int i = 0; i < node._size; i++) {
						G data = (owned)node._data[i];
						recipient.add (data);
					}
					amount -= node._size;
					drained += node._size;
					_size -= node._size;
				} else {
					for (int i = 0; i < amount; i++) {
						G data = (owned)node._data[i];
						recipient.add (data);
					}
					Memory.move(node._data, &node._data[amount], sizeof(G) * (node._size - amount));
					drained += amount;
					_size -= amount;
					node._size -= amount;
					unowned Node<G>? n = node;
					_head = (owned)node;
					if (likely (n._next != null) && unlikely (n._size + n._next._size < MERGE_THRESHOLD)) {
						merge_with_next (node);
					}
					_stamp++;
#if CONSISTENCY_CHECKS
					check ();
#endif
					return drained;
				}
			}
			_tail = null;
			_stamp++;
#if CONSISTENCY_CHECKS
			check ();
#endif
			return drained;
		}
	}

	public bool offer_head (G element) {
		if (_head == null) {
#if !DISABLE_INTERNAL_ASSERTS
			assert (_tail == null);
#else
			assume (_tail == null);
#endif
			_tail = _head = new Node<G>();
		}
		add_to_node (_head, element, 0);
		return true;
	}

	public G? peek_head () {
		return peek ();
	}

	public G? poll_head () {
		return poll ();
	}

	public int drain_head (Collection<G> recipient, int amount = -1) {
		return drain (recipient, amount);
	}

	public bool offer_tail (G element) {
		return offer (element);
	}

	public G? peek_tail () {
		if (_tail != null) {
			return _tail._data[_tail._size - 1];
		} else {
			return null;
		}
	}

	public G? poll_tail () {
		if (_head != null) {
			return remove_from_node (_tail, _tail._size - 1);
		} else {
			return null;
		}
	}

	public int drain_tail (Collection<G> recipient, int amount = -1) {
		int drained = 0;
		if (amount < 0) {
			for (unowned Node<G>? node = _tail; node != null; node = node._prev) {
				for (int i = node._size; i-- > 0;) {
					G data = (owned)node._data[i];
					recipient.add (data);
				}
				node._next = null;
			}
			drained = _size;
			_head = null;
			_tail = null;
			_size = 0;
			_stamp++;
#if CONSISTENCY_CHECKS
			check ();
#endif
			return drained;
		} else {
			for (unowned Node<G>? node = _tail; node != null;) {
				if (node._size <= amount) {
					for (int i = node._size; i-- > 0;) {
						G data = (owned)node._data[i];
						recipient.add (data);
					}
					amount -= node._size;
					drained += node._size;
					_size -= node._size;
					node = node._prev;
					if (node != null) {
						node._next = null;
					}
				} else {
					for (int i = 0; i < amount; i++) {
						G data = (owned)node._data[node._size - i - 1];
						recipient.add (data);
					}
					drained += amount;
					_size -= amount;
					node._size -= amount;
					_tail = node;
					if (likely (node._prev != null) && unlikely (node._size + node._prev._size < MERGE_THRESHOLD)) {
						merge_with_next (node._prev);
					}
					_stamp++;
#if CONSISTENCY_CHECKS
					check ();
#endif
					return drained;
				}
			}
			_head = null;
			_tail = null;
			_stamp++;
#if CONSISTENCY_CHECKS
			check ();
#endif
			return drained;
		}
	}

	private unowned Node<G>? find_node (G item, out int pos = null, out int idx = null) {
		idx = 0;
		for (unowned Node<G>? node = _head; node != null; node = node._next) {
			for (pos = 0; pos < node._size; pos++, idx++) {
				if (this.equal_func (item, node._data[pos])) {
					return node;
				}
			}
		}
		pos = -1;
		return null;
	}

	private unowned Node<G>? find_node_by_idx (int idx, out int? pos = null) {
#if !DISABLE_INTERNAL_ASSERTS
		assert (0 <= idx && idx < _size);
#else
		assume (0 <= idx && idx < _size);
#endif
		if (idx <= size/2) {
			for (unowned Node<G>? node = _head; node != null; node = node._next) {
				if (idx < node._size) {
					pos = idx;
					return node;
				}
				idx -= node._size;
			}
		}
		else {
			int start_of_node = _size;
			int count = 0;
			for (unowned Node<G>? node = _tail; node != null; node = node._prev) {
				start_of_node -= node._size;
				count += node._size;
				if (idx >= start_of_node) {
					pos = idx - start_of_node;
#if !DISABLE_INTERNAL_ASSERTS
					assert (0 <= pos && pos < node._size);
#else
					assume (0 <= pos && pos < node._size);
#endif
					return node;
				}
			}
#if !DISABLE_INTERNAL_ASSERTS
			assert (start_of_node == 0);
#endif
		}
#if !DISABLE_INTERNAL_ASSERTS
#if CONSISTENCY_CHECKS
		check ();
#endif
		assert_not_reached ();
#else
		assume (false);
		pos = -1;
		return null;
#endif
	}

	private void add_to_node (Node<G> node, G item, int pos, out unowned Node<G>? new_node = null, out int new_pos = null) {
#if !DISABLE_INTERNAL_ASSERTS
		assert (0 <= pos && pos <= node._size && node._size <= NODE_SIZE);
#else
		assume (0 <= pos && pos <= node._size && node._size <= NODE_SIZE);
#endif
		if (node._size == NODE_SIZE) {
			Node<G> next = new Node<G> ();
			next._next = (owned)node._next;
			next._prev = node;
			if (GLib.unlikely (next._next == null)) {
				_tail = next;
			} else {
				next._next._prev = next;
			}
			Memory.copy(next._data, &node._data[SPLIT_POS], sizeof(G) * (NODE_SIZE - SPLIT_POS));
			node._size = SPLIT_POS;
			next._size = NODE_SIZE - SPLIT_POS;
			node._next = (owned)next;
			if (pos > SPLIT_POS) {
				node = node._next;
				pos = pos - SPLIT_POS;
			}
		}
#if !DISABLE_INTERNAL_ASSERTS
		assert (0 <= pos && pos <= node._size && node._size < NODE_SIZE);
#else
		assume (0 <= pos && pos <= node._size && node._size < NODE_SIZE);
#endif
		Memory.move(&node._data[pos + 1], &node._data[pos], sizeof(G) * (node._size - pos));
		Memory.set(&node._data[pos], 0, sizeof(G));
		node._data[pos] = item;
		node._size++;
		_size++;
		_stamp++;
#if !DISABLE_INTERNAL_ASSERTS
		assert (node._size <= NODE_SIZE);
#else
		assume (node._size <= NODE_SIZE);
#endif
		new_node = node;
		new_pos = pos;
#if CONSISTENCY_CHECKS
		check ();
#endif
	}

	private G remove_from_node (Node<G> node, int pos, out unowned Node<G>? new_node = null, out int new_pos = null) {
#if !DISABLE_INTERNAL_ASSERTS
		assert ((0 <= pos && pos <= node._size) && pos <= NODE_SIZE);
#else
		assume ((0 <= pos && pos <= node._size) && pos <= NODE_SIZE);
#endif
		G item = (owned)node._data[pos];
		Memory.move(&node._data[pos], &node._data[pos + 1], sizeof(G) * (node._size - (pos + 1)));
		node._size--;
		_size--;
		_stamp++;
#if !DISABLE_INTERNAL_ASSERTS
		assert (node._size >= 0);
		assert (_size >= 0);
#else
		assume (node._size >= 0);
		assume (_size >= 0);
#endif
		if (unlikely (node._size == 0)) {
			new_node = node._prev;
			if (likely (node._prev != null)) {
				new_pos = node._prev._size - 1;
			} else {
				new_pos = -1;
			}
			delete_node (node);
		} else if (likely (node._prev != null) && unlikely (node._size + node._prev._size < MERGE_THRESHOLD)) {
			new_node = node._prev;
			new_pos = node._prev._size + pos - 1;
			merge_with_next (node._prev);
		} else if (likely (node._next != null) && unlikely (node._size + node._next._size < MERGE_THRESHOLD)) {
			merge_with_next (node);
			new_node = node;
			new_pos = pos - 1;
		} else {
			if (pos != 0) {
				new_node = node;
				new_pos = pos - 1;
			} else {
				new_node = node._prev;
				if (likely (node._prev != null)) {
					new_pos = node._prev._size - 1;
				} else {
					new_pos = -1;
				}
			}
		}
#if CONSISTENCY_CHECKS
		check ();
#endif
		return item;
	}

	private void merge_with_next (Node<G>? node) {
#if !DISABLE_INTERNAL_ASSERTS
		assert (node._next != null);
		assert (node._size + node._next._size <= NODE_SIZE);
#else
		assume (node._next != null);
		assume (node._size + node._next._size <= NODE_SIZE);
#endif
		unowned Node<G> next = node._next;
		Memory.copy(&node._data[node._size], next._data, sizeof(G) * next._size);
		node._size += next._size;
#if !DISABLE_INTERNAL_ASSERTS
		assert (node._size <= NODE_SIZE);
#else
		assume (node._size <= NODE_SIZE);
#endif
		delete_node (next);
#if CONSISTENCY_CHECKS
		check ();
#endif
	}

	private void delete_node (Node<G>? node) {
		if (likely (node._next != null)) {
			node._next._prev = node._prev;
		} else {
			_tail = node._prev;
		}
		if (GLib.likely (node._prev != null)) {
			node._prev._next = (owned)node._next;
		} else {
			_head = (owned)node._next;
		}
	}

#if DUMP
	private void dump () {
		stdout.printf ("UnrolledLinkedList %p\n  Size %d\n", this, _size);
		for (unowned Node<G>? node = _head; node != null; node = node._next) {
			stdout.printf ("  Node %p\n    Prev %p\n    Next %p\n", node, node._prev, node._next);
			for (int i = 0; i < node._size; i++) {
				stdout.printf ("    %d: %p (\"%s\")\n", i, node._data[i], (string)node._data[i]);
			}
		}
	}
#endif
#if CONSISTENCY_CHECKS
	private void check () {
		int size = 0;
		for (unowned Node<G>? node = _head; node != null; node = node._next) {
			size += node._size;
		}
		assert (size == _size);
		size = 0;
		for (unowned Node<G>? node = _tail; node != null; node = node._prev) {
			size += node._size;
		}
		assert (size == _size);
	}
#endif

	private int _size = 0;
	private int _stamp = 0;
	private Node<G>? _head = null;
	private unowned Node<G>? _tail = null;
	private Functions.EqualDataFuncClosure<G> _equal_func;
	private const int NODE_SIZE = 29; // Chosen for node to be multiply cache line (4 on 64 bit and 2 on 32 bit)
	private const int SPLIT_POS = (NODE_SIZE - 1)/2 + 1;
	private const int MERGE_THRESHOLD = (NODE_SIZE * 4)/5;

	private class Iterator<G> : Object, Vala.Traversable<G>, Vala.Iterator<G>, ListIterator<G>, BidirIterator<G>, BidirListIterator<G> {
		public Iterator (UnrolledLinkedList<G> list) {
			this._list = list;
			this._stamp = list._stamp;
		}

		public Iterator.from_iterator (Iterator<G> iter) {
			_list = iter._list;
			_stamp = iter._stamp;
			_current = iter._current;
			_pos = iter._pos;
			_deleted = iter._deleted;
			_index = iter._index;
		}

		public new bool foreach (ForallFunc<G> f) {
#if DUMP
			stdout.printf ("FOREACH BEGIN [%p -> %p %d]\n", this, _current, _pos);
			_list.dump ();
			try {
#endif
			assert (_list._stamp == _stamp);
#if !DISABLE_INTERNAL_ASSERTS
			assert (!(_current == null) || _pos == -1);
			assert (!(_current != null) || (0 <= _pos && _pos <= _current._size));
#else
			assume (!(_current == null) || _pos == -1);
			assume (!(_current != null) || (0 <= _pos && _pos <= _current._size));
#endif
			unowned Node<G>? current = _current;
			unowned Node<G>? prev = null;
			int pos = _pos;
			int prev_pos = -1;
			int index = _index;
			int prev_index = -1;
			bool deleted = _deleted;
			if (current == null) {
				current = _list._head;
				pos = 0;
				deleted = false;
				index = 0;
				if (unlikely (current == null)) {
					return true;
				}
			} else if (unlikely (deleted)) {
				if (unlikely(_current._size == _pos + 1)) {
					if (unlikely (_current._next != null)) {
						return true;
					}
					prev = current;
					current = _current._next;
					prev_pos = pos;
					pos = 0;
					deleted = false;
					prev_index = index++;
				} else {
					prev = current;
					prev_pos = pos++;
					deleted = false;
					prev_index = index++;
				}
			}
			for (; current != null; prev = current, current = current._next, pos = 0) {
				int size = current._size;
				for (; pos < size; prev = current, prev_pos = pos++, prev_index = index++) {
					deleted = false;
					if (!f (current._data[pos])) {
						_current = current;
						_pos = pos;
						_deleted = deleted;
						_index = index;
						return false;
					}
				}
			}
			_current = prev;
			_pos = prev_pos;
			_deleted = deleted;
			_index = prev_index;
			return true;
#if DUMP
			} finally {
			_list.dump ();
			stdout.printf ("FOREACH END [%p -> %p %d]\n", this, _current, _pos);
			}
#endif
		}

		public Vala.Iterator<G>[] tee (uint forks) {
			if (forks == 0) {
				return new Vala.Iterator<G>[0];
			} else {
				Vala.Iterator<G>[] result = new Vala.Iterator<G>[forks];
				result[0] = this;
				for (uint i = 1; i < forks; i++) {
					result[i] = new Iterator<G>.from_iterator (this);
				}
				return result;
			}
		}

		public bool next () {
#if DUMP
			stdout.printf ("NEXT BEGIN [%p -> %p %d]\n", this, _current, _pos);
			_list.dump ();
			try {
#endif
			assert (_list._stamp == _stamp);
#if !DISABLE_INTERNAL_ASSERTS
			assert (!(_current == null) || _pos == -1);
			assert (!(_current != null) || (0 <= _pos && _pos <= _current._size));
#else
			assume (!(_current == null) || _pos == -1);
			assume (!(_current != null) || (0 <= _pos && _pos <= _current._size));
#endif
			if (unlikely (_current == null)) {
				_current = _list._head;
				if (_current != null) {
					_pos = 0;
					_deleted = false;
					_index = 0;
				}
				return _current != null;
			} else if (unlikely(_current._size == _pos + 1)) {
				if (likely (_current._next != null)) {
					_current = _current._next;
					_pos = 0;
					_deleted = false;
					_index++;
					return true;
				} else {
					return false;
				}
			} else {
				_pos++;
				_deleted = false;
				_index++;
				return true;
			}
#if DUMP
			} finally {
			_list.dump ();
			stdout.printf ("NEXT END [%p -> %p %d]\n", this, _current, _pos);
			}
#endif
		}

		public bool has_next () {
			assert (_list._stamp == _stamp);
#if !DISABLE_INTERNAL_ASSERTS
			assert (!(_current == null) || _pos == -1);
			assert (!(_current != null) || (0 <= _pos && _pos <= _current._size));
#else
			assume (!(_current == null) || _pos == -1);
			assume (!(_current != null) || (0 <= _pos && _pos <= _current._size));
#endif
			if (unlikely (_current == null)) {
				return _list._head != null;
			} else if (unlikely(_current._size == _pos + 1)) {
				return _current._next != null;
			} else {
				return true;
			}
		}

		public new G get () {
			assert (_list._stamp == _stamp);
			assert (_current != null && !_deleted);
#if !DISABLE_INTERNAL_ASSERTS
			assert (0 <= _pos && _pos < _current._size);
#else
			assume (0 <= _pos && _pos < _current._size);
#endif
			return _current._data[_pos];
		}

		public void remove () {
#if DUMP
			stdout.printf ("REMOVE BEGIN [%p -> %p %d]\n", this, _current, _pos);
			_list.dump ();
#endif
			assert (_list._stamp == _stamp);
			assert (_current != null && !_deleted);
#if !DISABLE_INTERNAL_ASSERTS
			assert (0 <= _pos && _pos <= _current._size);
#else
			assume (0 <= _pos && _pos <= _current._size);
#endif
			_list.remove_from_node (_current, _pos, out _current, out _pos);
			_deleted = true;
			_index--;
			_stamp++;
#if DUMP
			_list.dump ();
			stdout.printf ("REMOVE END [%p -> %p %d]\n", this, _current, _pos);
#endif
		}

		public bool valid {
			get {
				assert (_list._stamp == _stamp);
#if !DISABLE_INTERNAL_ASSERTS
				assert (!(_current == null) || _pos == -1);
				assert (!(_current != null) || (0 <= _pos && _pos <= _current._size));
#else
				assume (!(_current == null) || _pos == -1);
				assume (!(_current != null) || (0 <= _pos && _pos <= _current._size));
#endif
				return _current != null && !_deleted;
			}
		}

		public bool read_only { get { return false; } }

		public bool previous () {
			assert (_list._stamp == _stamp);
#if !DISABLE_INTERNAL_ASSERTS
			assert (!(_current == null) || _pos == -1);
			assert (!(_current != null) || (0 <= _pos && _pos <= _current._size));
#else
			assume (!(_current == null) || _pos == -1);
			assume (!(_current != null) || (0 <= _pos && _pos <= _current._size));
#endif
			if (unlikely (_deleted)) {
				_deleted = false;
				return _current != null;
			} else if (unlikely (_current == null)) {
				return false;
			} else if (unlikely (_pos == 0)) {
				if (likely (_current._prev != null)) {
					_current = _current._prev;
					_pos = _current._size - 1;
					_index--;
					return true;
				} else {
					return false;
				}
			} else {
				_pos--;
				_index--;
				return true;
			}
		}

		public bool has_previous () {
			assert (_list._stamp == _stamp);
#if !DISABLE_INTERNAL_ASSERTS
			assert (!(_current == null) || _pos == -1);
			assert (!(_current != null) || (0 <= _pos && _pos <= _current._size));
#else
			assume (!(_current == null) || _pos == -1);
			assume (!(_current != null) || (0 <= _pos && _pos <= _current._size));
#endif
			if (unlikely (_deleted)) {
				return _current != null;
			} else if (unlikely (_current == null)) {
				return false;
			} else if (unlikely (_pos == 0)) {
				return _current._prev != null;
			} else {
				return true;
			}
		}

		public bool first () {
			assert (_list._stamp == _stamp);
#if !DISABLE_INTERNAL_ASSERTS
			assert (!(_current == null) || _pos == -1);
			assert (!(_current != null) || (0 <= _pos && _pos <= _current._size));
#else
			assume (!(_current == null) || _pos == -1);
			assume (!(_current != null) || (0 <= _pos && _pos <= _current._size));
#endif
			_current = _list._head;
			_deleted = false;
			if (_current != null) {
				_pos = 0;
			} else {
				_pos = -1;
			}
			_index = 0;
			return _current != null;
		}

		public bool last () {
			assert (_list._stamp == _stamp);
#if !DISABLE_INTERNAL_ASSERTS
			assert (!(_current == null) || _pos == -1);
			assert (!(_current != null) || (0 <= _pos && _pos <= _current._size));
#else
			assume (!(_current == null) || _pos == -1);
			assume (!(_current != null) || (0 <= _pos && _pos <= _current._size));
#endif
			_current = _list._tail;
			_deleted = false;
			if (_current != null) {
				_pos = _current._size - 1;
			} else {
				_pos = -1;
			}
			_index = _list._size - 1;
			return _current != null;
		}

		public new void set (G item) {
			assert (_list._stamp == _stamp);
#if !DISABLE_INTERNAL_ASSERTS
			assert (!(_current == null) || _pos == -1);
			assert (!(_current != null) || (0 <= _pos && _pos <= _current._size));
#else
			assume (!(_current == null) || _pos == -1);
			assume (!(_current != null) || (0 <= _pos && _pos <= _current._size));
#endif
			_current._data[_pos] = item;
			_list._stamp++;
			_stamp++;
		}

		public void add (G item) {
#if DUMP
			stdout.printf ("ADD BEGIN %p (%s) [%p -> %p %d]\n", item, (string)item, this, _current, _pos);
			_list.dump ();
#endif
			assert (_list._stamp == _stamp);
#if !DISABLE_INTERNAL_ASSERTS
			assert (!(_current == null) || _pos == -1);
			assert (!(_current != null) || (0 <= _pos && _pos <= _current._size));
#else
			assume (!(_current == null) || _pos == -1);
			assume (!(_current != null) || (0 <= _pos && _pos <= _current._size));
#endif
			if (likely (_current != null)) {
				_list.add_to_node (_current, item, _pos + 1, out _current, out _pos);
			} else {
				if (likely (_list._head != null)) {
					_current = _list._head;
				} else {
					_current = _list._tail = _list._head = new Node<G>();
				}
				_list.add_to_node (_current, item, 0);
				_pos = 0;
			}
			_stamp++;
			_index++;
			_deleted = false;
#if DUMP
			_list.dump ();
			stdout.printf ("ADD END [%p -> %p %d]\n", this, _current, _pos);
#endif
		}

		public int index () {
			assert (_list._stamp == _stamp);
			assert (_current != null);
#if !DISABLE_INTERNAL_ASSERTS
			assert (0 <= _pos && _pos <= _current._size);
#else
			assume (0 <= _pos && _pos <= _current._size);
#endif
			return _index;
		}

		public void insert (G item) {
#if DUMP
			stdout.printf ("INSERT BEGIN %p (%s) [%p -> %p %d]\n", item, (string)item, this, _current, _pos);
			_list.dump ();
#endif
			assert (_list._stamp == _stamp);

			if (unlikely (_deleted)) {
				if (unlikely (_current == null)) {
					if (likely (_list._head != null)) {
						_current = _list._head;
						_pos = -1;
					} else {
						_current = _list._tail = _list._head = new Node<G>();
						_pos = -1;
					}
				}
				_list.add_to_node (_current, item, _pos + 1, out _current, out _pos);
				if (unlikely (_pos == 0)) {
#if !DISABLE_INTERNAL_ASSERTS
					assert (_current._prev != null);
#endif
					_current = _current._prev;
					_pos = _current._prev._size - 1;
				} else {
					_pos--;
				}
			} else {
				_list.add_to_node (_current, item, _pos, out _current, out _pos);
				if (unlikely (_pos + 1 == _current._size)) {
#if !DISABLE_INTERNAL_ASSERTS
					assert (_current._next != null);
#endif
					_current = _current._next;
					_pos = 0;
				} else {
					_pos++;
				}
			}
			_stamp++;
			_index++;
#if DUMP
			_list.dump ();
			stdout.printf ("INSERT END [%p -> %p %d]\n", this, _current, _pos);
#endif
		}

		private UnrolledLinkedList<G>? _list;
		private int _stamp;
		private unowned Node<G>? _current = null;
		private int _pos = -1;
		private bool _deleted = false;
		private int _index = -1;
	}

	[Compact]
	private class Node<G> {
		public unowned Node<G>? _prev = null;
		public Node<G>? _next = null;
		public int _size = 0;
		public G _data[29 /* NODE_SIZE */];
	}
}

