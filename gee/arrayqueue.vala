/* arrayqueue.vala
 *
 * Copyright (C) 2012  Maciej Piechotka
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

/**
 * Resizable array implementation of the {@link Deque} interface.
 *
 * The storage array grows automatically when needed.
 *
 * This implementation is pretty good for lookups at the end or random.
 * Because they are stored in an array this structure does not fit for deleting
 * arbitrary elements. For an alternative implementation see {@link LinkedList}.
 *
 * @see LinkedList
 */
public class Vala.ArrayQueue<G> : Vala.AbstractQueue<G>, Deque<G> {
	/**
	 * Constructs a new, empty array queue.
	 *
	 * If not provided, the function parameter is requested to the
	 * {@link Functions} function factory methods.
	 *
	 * @param equal_func an optional element equality testing function
	 */
	public ArrayQueue (owned EqualDataFunc<G>? equal_func = null) {
		if (equal_func == null) {
			equal_func = Functions.get_equal_func_for (typeof (G));
		}
		this.equal_func = equal_func;
		this._items = new G[10];
	}

	[CCode (notify = false)]
	public EqualDataFunc<G> equal_func { private set; get; }

	/**
	 * {@inheritDoc}
	 */
	public override int size { get { return _length; } }

	public bool is_empty { get { return _length == 0; } }

	/**
	 * {@inheritDoc}
	 */
	public override bool read_only { get { return false; } }

	/**
	 * {@inheritDoc}
	 */
	public override int capacity { get {return Queue.UNBOUNDED_CAPACITY;} }

	/**
	 * {@inheritDoc}
	 */
	public override int remaining_capacity { get {return Queue.UNBOUNDED_CAPACITY;} }

	/**
	 * {@inheritDoc}
	 */
	public override bool is_full { get { return false; } }

	/**
	 * {@inheritDoc}
	 */
	public override Vala.Iterator<G> iterator() {
		return new Iterator<G> (this);
	}

	/**
	 * {@inheritDoc}
	 */
	public override bool add (G element) {
		return offer_tail (element);
	}

	/**
	 * {@inheritDoc}
	 */
	public override bool contains (G item) {
		return find_index(item) != -1;
	}

	/**
	 * {@inheritDoc}
	 */
	public override bool remove (G item) {
		_stamp++;
		int index = find_index (item);
		if (index == -1) {
			return false;
		} else {
			remove_at (index);
			return true;
		}
	}

	/**
	 * {@inheritDoc}
	 */
	public override void clear() {
		_stamp++;
		for (int i = 0; i < _length; i++) {
			_items[(_start + i) % _items.length] = null;
		}
		_start = _length = 0;
	}

	/**
	 * {@inheritDoc}
	 */
	public override G? peek () {
		return peek_head ();
	}

	/**
	 * {@inheritDoc}
	 */
	public override G? poll () {
		return poll_head ();
	}

	/**
	 * {@inheritDoc}
	 */
	public bool offer_head (G element) {
		grow_if_needed ();
		_start = (_items.length + _start - 1) % _items.length;
		_length++;
		_items[_start] = element;
		_stamp++;
		return true;
	}

	/**
	 * {@inheritDoc}
	 */
	public G? peek_head () {
		return _items[_start];
	}

	/**
	 * {@inheritDoc}
	 */
	public G? poll_head () {
		_stamp++;
		if (_length == 0) {
			_start = 0;
			return null;
		} else {
			_length--;
			G result = (owned)_items[_start];
			_start = (_start + 1) % _items.length;
			return (owned)result;
		}
	}

	/**
	 * {@inheritDoc}
	 */
	public int drain_head (Collection<G> recipient, int amount = -1) {
		return drain (recipient, amount);
	}

	/**
	 * {@inheritDoc}
	 */
	public bool offer_tail (G element) {
		grow_if_needed();
		_items[(_start + _length++) % _items.length] = element;
		_stamp++;
		return true;
	}

	/**
	 * {@inheritDoc}
	 */
	public G? peek_tail () {
		return _items[(_items.length + _start + _length - 1) % _items.length];
	}

	/**
	 * {@inheritDoc}
	 */
	public G? poll_tail () {
		_stamp++;
		if (_length == 0) {
			_start = 0;
			return null;
		} else {
			return (owned)_items[(_items.length + _start + --_length) % _items.length];
		}
	}

	/**
	 * {@inheritDoc}
	 */
	public int drain_tail (Collection<G> recipient, int amount = -1) {
		G? item = null;
		int drained = 0;
		while((amount == -1 || --amount >= 0) && (item = poll_tail ()) != null) {
			recipient.add(item);
			drained++;
		}
		return drained;
	}

	/**
	 * {@inheritDoc}
	 */
	private void grow_if_needed () {
		if (_items.length < _length +1 ) {
			_items.resize (2 * _items.length);
#if 0
			_items.move (0, _length, _start);
#else
			// See bug #667452
			for(int i = 0; i < _start; i++)
				_items[_length + i] = (owned)_items[i];
#endif
		}
	}

	private int find_index (G item) {
		for (int i = _start; i < int.min(_items.length, _start + _length); i++) {
			if (equal_func(item, _items[i])) {
				return i;
			}
		}
		for (int i = 0; i < _start + _length - _items.length; i++) {
			if (equal_func(item, _items[i])) {
				return i;
			}
		}
		return -1;
	}

	private void remove_at (int index) {
		int end = (_items.length + _start + _length - 1) % _items.length + 1;
		if (index == _start) {
			_items[_start++] = null;
			_length--;
			return;
		} else if (index > _start && end <= _start) {
			_items[index] = null;
			_items.move (index + 1, index, _items.length - 1);
			_items[_items.length - 1] = (owned)_items[0];
			_items.move (1, 0, end - 1);
			_length--;
		} else {
			_items[index] = null;
			_items.move (index + 1, index, end - (index + 1));
			_length--;
		}
	}

	private class Iterator<G> : GLib.Object, Traversable<G>, Vala.Iterator<G> {
		public Iterator (ArrayQueue<G> queue) {
			_queue = queue;
			_stamp = _queue._stamp;
		}

		public bool next () {
			assert (_queue._stamp == _stamp);
			if (has_next ()) {
				_offset++;
				_removed = false;
				return true;
			} else {
				return false;
			}
		}

		public bool has_next () {
			assert (_queue._stamp == _stamp);
			return _offset + 1 < _queue._length;
		}

		public new G get () {
			assert (_queue._stamp == _stamp);
			assert (_offset != -1);
			assert (!_removed);
			return _queue._items[(_queue._start + _offset) % _queue._items.length];
		}

		public void remove () {
			assert (_queue._stamp++ == _stamp++);
			_queue.remove_at((_queue._start + _offset) % _queue._items.length);
			_offset--;
			_removed = true;
		}

		public bool valid { get {return _offset != -1 && !_removed;} }

		public bool read_only { get {return false;} }

		public bool foreach (ForallFunc<G> f) {
			assert (_queue._stamp == _stamp);
			if (!valid) {
				_offset++;
				_removed = false;
			}
			for (int i = _offset; i < _queue._length; i++) {
				if (!f (_queue._items[(_queue._start + i) % _queue._items.length])) {
					_offset = i;
					return false;
				}
			}
			_offset = _queue._length - 1;
			return true;
		}

		private ArrayQueue _queue;
		private int _stamp;
		private int _offset = -1;
		private bool _removed = false;
	}

	private G[] _items;
	private int _start = 0;
	private int _length = 0;
	private int _stamp = 0;
}

