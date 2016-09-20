/* linkedlist.vala
 *
 * Copyright (C) 2004-2005  Novell, Inc
 * Copyright (C) 2005  David Waite
 * Copyright (C) 2007-2008  Jürg Billeter
 * Copyright (C) 2009  Mark Lee, Didier Villevalois
 * Copyright (C) 2010-2014  Maciej Piechotka
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
 * 	Mark Lee <marklee@src.gnome.org>
 * 	Didier 'Ptitjes Villevalois <ptitjes@free.fr>
 */

using Vala.Utils.Assume;

/**
 * Doubly-linked list implementation of the {@link List} interface.
 *
 * This implementation is pretty well designed for highly mutable data. When
 * indexed access is privileged prefer using {@link ArrayList}.
 *
 * @see ArrayList
 */
public class Vala.LinkedList<G> : AbstractBidirList<G>, Queue<G>, Deque<G> {
	private int _size = 0;
	private int _stamp = 0;
	private Node<G>? _head = null;
	private weak Node<G>? _tail = null;
	private Functions.EqualDataFuncClosure<G> _equal_func;

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
	public LinkedList (owned EqualDataFunc<G>? equal_func = null) {
		if (equal_func == null) {
			equal_func = Functions.get_equal_func_for (typeof (G));
		}
		_equal_func = new Functions.EqualDataFuncClosure<G> ((owned)equal_func);
	}

	private LinkedList.with_closures (owned Functions.EqualDataFuncClosure<G> equal_func) {
		_equal_func = equal_func;
	}

	~LinkedList () {
		this.clear ();
	}

	/**
	 * {@inheritDoc}
	 */
	public override bool foreach(ForallFunc<G> f) {
		for (weak Node<G>? node = _head; node != null; node = node.next) {
			if (!f (node.data)) {
				return false;
			}
		}
		return true;
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
	public override ListIterator<G> list_iterator () {
		return new Iterator<G> (this);
	}

	/**
	 * {@inheritDoc}
	 */
	public override BidirListIterator<G> bidir_list_iterator () {
		return new Iterator<G> (this);
	}

	/**
	 * {@inheritDoc}
	 */
	public override int size {
		get { return this._size; }
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
	public override bool contains (G item) {
		return this.index_of (item) != -1;
	}

	/**
	 * {@inheritDoc}
	 */
	public override bool add (G item) {
		Node<G> n = new Node<G> (item);
		if (this._head == null && this._tail == null) {
			this._tail = n;
			this._head = (owned) n;
		} else {
			n.prev = this._tail;
			this._tail.next = (owned) n;
			this._tail = this._tail.next;
		}

		// Adding items to the list during iterations is allowed.
		//++this._stamp;

		this._size++;
		return true;
	}

	/**
	 * {@inheritDoc}
	 */
	public override bool remove (G item) { // Should remove only the first occurence (a test should be added)
		for (weak Node<G> n = this._head; n != null; n = n.next) {
			if (this.equal_func (item, n.data)) {
				this._remove_node (n);
				return true;
			}
		}
		return false;
	}

	/**
	 * {@inheritDoc}
	 */
	public override void clear () {
		while (_head != null) {
			_remove_node (_head);
		}

		++this._stamp;
		this._head = null;
		this._tail = null;
		this._size = 0;
	}

	/**
	 * {@inheritDoc}
	 */
	public override G get (int index) {
		assert (index >= 0);
		assert (index < this._size);

		unowned Node<G>? n = this._get_node_at (index);
#if !DISABLE_INTERNAL_ASSERTS
		assert (n != null);
#endif
		return n.data;
	}

	/**
	 * {@inheritDoc}
	 */
	public override void set (int index, G item) {
		assert (index >= 0);
		assert (index < this._size);

		unowned Node<G>? n = this._get_node_at (index);
		return_if_fail (n != null);
		n.data = item;
	}

	/**
	 * {@inheritDoc}
	 */
	public override int index_of (G item) {
		int idx = 0;
		for (weak Node<G>? node = _head; node != null; node = node.next, idx++) {
			if (this.equal_func (item, node.data)) {
				return idx;
			}
		}
		return -1;
	}

	/**
	 * {@inheritDoc}
	 */
	public override void insert (int index, G item) {
		assert (index >= 0);
		assert (index <= this._size);

		if (index == this._size) {
			this.add (item);
		} else {
			Node<G> n = new Node<G> (item);
			if (index == 0) {
				n.next = (owned) this._head;
				n.next.prev = n;
				this._head = (owned)n;
			} else {
				weak Node prev = this._head;
				for (int i = 0; i < index - 1; i++) {
					prev = prev.next;
				}
				n.prev = prev;
				n.next = (owned) prev.next;
				n.next.prev = n;
				prev.next = (owned) n;
			}

			// Adding items to the list during iterations is allowed.
			//++this._stamp;

			this._size++;
		}
	}

	/**
	 * {@inheritDoc}
	 */
	public override G remove_at (int index) {
		assert (index >= 0);
		assert (index < this._size);

		unowned Node<G>? n = this._get_node_at (index);
#if !DISABLE_INTERNAL_ASSERTS
		assert (n != null);
#endif
		G element = n.data;
		this._remove_node (n);
		return element;
	}

	/**
	 * {@inheritDoc}
	 */
	public override List<G>? slice (int start, int stop) {
		return_val_if_fail (start <= stop, null);
		return_val_if_fail (start >= 0, null);
		return_val_if_fail (stop <= this._size, null);

		List<G> slice = new LinkedList<G>.with_closures (_equal_func);
		weak Node<G> n = this._get_node_at (start);
		for (int i = start; i < stop; i++) {
			slice.add (n.data);
			n = n.next;
		}

		return slice;
	}

	/**
	 * {@inheritDoc}
	 */
	public G first () {
		assert (_size > 0);
		return _head.data;
	}

	/**
	 * {@inheritDoc}
	 */
	public G last () {
		assert (_size > 0);
		return _tail.data;
	}

	/**
	 * {@inheritDoc}
	 */
	public int capacity {
		get { return UNBOUNDED_CAPACITY; }
	}

	/**
	 * {@inheritDoc}
	 */
	public int remaining_capacity {
		get { return UNBOUNDED_CAPACITY; }
	}

	/**
	 * {@inheritDoc}
	 */
	public bool is_full {
		get { return false; }
	}

	/**
	 * {@inheritDoc}
	 */
	public bool offer (G element) {
		return offer_tail (element);
	}

	/**
	 * {@inheritDoc}
	 */
	public G? peek () {
		return peek_head ();
	}

	/**
	 * {@inheritDoc}
	 */
	public G? poll () {
		return poll_head ();
	}

	/**
	 * {@inheritDoc}
	 */
	public int drain (Collection<G> recipient, int amount = -1) {
		return drain_head (recipient, amount);
	}

	/**
	 * {@inheritDoc}
	 */
	public bool offer_head (G element) {
		insert (0, element);
		return true;
	}

	/**
	 * {@inheritDoc}
	 */
	public G? peek_head () {
		if (this._size == 0) {
			return null;
		}
		return get (0);
	}

	/**
	 * {@inheritDoc}
	 */
	public G? poll_head () {
		if (this._size == 0) {
			return null;
		}
		return remove_at (0);
	}

	/**
	 * {@inheritDoc}
	 */
	public int drain_head (Collection<G> recipient, int amount = -1) {
		if (amount == -1) {
			amount = this._size;
		}
		for (int i = 0; i < amount; i++) {
			if (this._size == 0) {
				return i;
			}
			recipient.add (remove_at (0));
		}
		return amount;
	}

	/**
	 * {@inheritDoc}
	 */
	public bool offer_tail (G element) {
		return add (element);
	}

	/**
	 * {@inheritDoc}
	 */
	public G? peek_tail () {
		if (this._size == 0) {
			return null;
		}
		return get (_size - 1);
	}

	/**
	 * {@inheritDoc}
	 */
	public G? poll_tail () {
		if (this._size == 0) {
			return null;
		}
		return remove_at (_size - 1);
	}

	/**
	 * {@inheritDoc}
	 */
	public int drain_tail (Collection<G> recipient, int amount = -1) {
		if (amount == -1) {
			amount = this._size;
		}
		for (int i = 0; i < amount; i++) {
			if (this._size == 0) {
				return i;
			}
			recipient.add (remove_at (this._size - 1));
		}
		return amount;
	}

	[Compact]
	private class Node<G> { // Maybe a compact class should be used?
		public G data;
		public weak Node<G>? prev = null;
		public Node<G>? next = null;
		public Node (owned G data) {
			this.data = data;
		}
	}

	private class Iterator<G> : Object, Traversable<G>, Vala.Iterator<G>, BidirIterator<G>, ListIterator<G>, BidirListIterator<G> {
		public Iterator (LinkedList<G> list) {
			this._list = list;
			this._position = null;
			this._index = -1;
			this._stamp = list._stamp;
		}

		public Iterator.from_iterator (Iterator<G> iter) {
			_removed = iter._removed;
			_position = iter._position;
			_stamp = iter._stamp;
			_list = iter._list;
			_index = iter._index;
		}

		public bool next () {
			assert (this._stamp == this._list._stamp);

			if (GLib.unlikely (_position == null)) {
#if !DISABLE_INTERNAL_ASSERTS
				assert (!_removed);
#else
				assume (!_removed);
#endif
				if (_list._head != null) {
					_position = _list._head;
					_index = 0;
					return true;
				} else {
					return false;
				}
			} else {
				if (_position.next != null) {
					_position = _position.next;
					_index++;
					_removed = false;
					return true;
				} else {
					return false;
				}
			}
		}

		public bool has_next () {
			assert (_stamp == _list._stamp);

			if (GLib.unlikely (_position == null)) {
				return _list._head != null;
			} else {
				return _position.next != null;
			}
		}

		public bool first () {
			assert (_stamp == _list._stamp);

			if (_list.size == 0) {
				return false;
			}
			_position = _list._head;
			_index = 0;
			_removed = false;
#if !DISABLE_INTERNAL_ASSERTS
			assert (_position != null);
#endif
			return true;
		}

		public new G get () {
			assert (_stamp == _list._stamp);
			assert (_position != null && !_removed);

			return _position.data;
		}

		public void remove () {
			assert (_stamp == _list._stamp);
			assert (_position != null && !_removed);

			unowned Node<G>? new_position = _position.prev;
			_list._remove_node (_position);
			_position = new_position;
			if (_position != null) {
				_removed = true;
			}
			_index--;
			_stamp = _list._stamp;
		}

		public bool previous () {
			assert (_stamp == _list._stamp);

			if (GLib.likely (_position != null)) {
				if (GLib.unlikely (_removed)) {
					_removed = false;
					return true;
				} else if (GLib.likely(_position.prev != null)) {
					_position = _position.prev;
					_index--;
					return true;
				} else {
					return false;
				}
			} else {
				return false;
			}
		}

		public bool has_previous () {
			assert (_stamp == _list._stamp);

			if (GLib.likely (_position != null)) {
				if (GLib.unlikely (_removed)) {
					return true;
				} else {
					return _position.prev != null;
				}
			} else {
				return false;
			}
		}

		public bool last () {
			assert (_stamp == _list._stamp);

			if (_list.size == 0) {
				return false;
			}
			_position = _list._tail;
			_index = _list._size - 1;
#if !DISABLE_INTERNAL_ASSERTS
			assert (_position != null);
#endif
			return true;
		}

		public new void set (G item) {
			assert (_stamp == _list._stamp);
			assert (_position != null && !_removed);

			_position.data = item;
		}

		public void insert (G item) {
			assert (_stamp == _list._stamp);

			Node<G> n = new Node<G> (item);
			unowned Node<G> n_ref = n;
			if (_position == null) {
				Node<G>? position = (owned)_list._head;
				if (position != null) {
					position.prev = n;
					n.next = (owned)position;
				} else {
#if !DISABLE_INTERNAL_ASSERTS
					assert (_list._tail == null);
#endif
					_list._tail = n;
				}
				if (_position == null) {
					_position = n_ref;
				}
				_list._head = (owned)n;
			} else {
				if (_removed) {
					if (_position.next != null) {
						n.next = (owned)_position.next;
						n.next.prev = n;
					} else {
						_list._tail = n;
					}
					n.prev = _position;
					_position.next = (owned)n;
					_position = n_ref;
				} else {
					n.prev = _position.prev;
					_position.prev = n;
					if (n.prev != null) {
						n.next = (owned)n.prev.next;
						n.prev.next = (owned)n;
					} else {
						n.next = (owned)_list._head;
						_list._head = (owned)n;
					}
				}
			}
			_list._size++;
			_index++;
			_stamp = _list._stamp;
		}

		public void add (G item) {
			assert (_stamp == _list._stamp);

			Node<G> n = new Node<G> (item);
			unowned Node<G> n_ref = n;
			if (_position == null) {
				Node<G> position = (owned)_list._head;
				position.prev = n;
				n.next = (owned)position;
				_list._head = (owned) n;
			} else {
				if (_position.next != null) {
					_position.next.prev = n;
					n.next = (owned)_position.next;
				} else {
					_list._tail = n;
				}
				_position.next = (owned)n;
				_position.next.prev = _position;
			}
			_position = n_ref;
			_removed = false;
			_list._size++;
			_index++;
			_stamp = _list._stamp;
		}

		public int index () {
			assert (_stamp == _list._stamp);
			assert (_position != null && !_removed);

			return _index;
		}

		public bool read_only {
			get {
				return false;
			}
		}

		public bool valid {
			get {
				return !_removed && _position != null;
			}
		}

		public bool foreach (ForallFunc<G> f) {
			assert (_stamp == _list._stamp);
			if (_position == null) {
				_position = _list._head;
			}
			if (_removed) {
				_position = _position.next;
				_removed = false;
			}
			while (_position != null) {
				if (!f (_position.data)) {
					return false;
				}
				_position = _position.next;
			}
			_position = _list._tail;
			return true;
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

		protected bool _removed = false;
		protected unowned Node<G>? _position;
		protected int _stamp;
		protected LinkedList<G> _list;
		protected int _index;
	}

	private unowned Node<G>? _get_node_at (int index) {
		unowned Node<G>? n = null;;
		if (index == 0) {
			n = this._head;
		} else if (index == this._size - 1) {
			n = this._tail;
		} else if (index <= this._size / 2) {
			n = this._head;
			for (int i = 0; index != i; i++) {
				n = n.next;
			}
		} else {
			n = this._tail;
			for (int i = this._size - 1; index != i; i--) {
				n = n.prev;
			}
		}
		return n;
	}

	private void _remove_node (Node<G> _n) {
		Node<G> n;
		weak Node<G> next;
		if (_n == this._head) {
			n = (owned) this._head;
			next = this._head = (owned) n.next;
		} else {
			n = (owned) _n.prev.next;
			next = n.prev.next = (owned) n.next;
		}
		if (n == this._tail) {
			this._tail = n.prev;
		} else {
			next.prev = n.prev;
		}
		n.prev = null;
		n.next = null;
		n.data = null;
		++this._stamp;
		this._size--;
	}
}

