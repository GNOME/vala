/* arraylist.vala
 *
 * Copyright (C) 2004-2005  Novell, Inc
 * Copyright (C) 2005  David Waite
 * Copyright (C) 2007-2008  Jürg Billeter
 * Copyright (C) 2009  Didier Villevalois
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
 * 	Jürg Billeter <j@bitron.ch>
 * 	Didier 'Ptitjes Villevalois <ptitjes@free.fr>
 */

using Vala.Utils.Assume;

/**
 * Resizable array implementation of the {@link List} interface.
 *
 * The storage array grows automatically when needed.
 *
 * This implementation is pretty good for rarely modified data. Because they are
 * stored in an array this structure does not fit for highly mutable data. For an
 * alternative implementation see {@link LinkedList}.
 *
 * @see LinkedList
 */
public class Vala.ArrayList<G> : AbstractBidirList<G> {
	/**
	 * {@inheritDoc}
	 */
	public override int size {
		get { return _size; }
	}

	/**
	 * {@inheritDoc}
	 */
	public override bool read_only {
		get { return false; }
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

	internal G[] _items;
	internal int _size;
	private Functions.EqualDataFuncClosure<G> _equal_func;

	// concurrent modification protection
	private int _stamp = 0;

	/**
	 * Constructs a new, empty array list.
	 *
	 * If not provided, the function parameter is requested to the
	 * {@link Functions} function factory methods.
	 *
	 * @param equal_func an optional element equality testing function
	 */
	public ArrayList (owned EqualDataFunc<G>? equal_func = null) {
		if (equal_func == null) {
			equal_func = Functions.get_equal_func_for (typeof (G));
		}
		_equal_func = new Functions.EqualDataFuncClosure<G>((owned)equal_func);
		_items = new G[4];
		_size = 0;
	}

	/**
	 * Constructs a new array list based on provided array.
	 *
	 * If not provided, the function parameter is requested to the
	 * {@link Functions} function factory methods.
	 *
	 * @param items initial items to be put into array
	 * @param equal_func an optional element equality testing function
	 */
	public ArrayList.wrap (owned G[] items, owned EqualDataFunc<G>? equal_func = null) {
		if (equal_func == null) {
			equal_func = Functions.get_equal_func_for (typeof (G));
		}
		_equal_func = new Functions.EqualDataFuncClosure<G>((owned)equal_func);
		_size = items.length;
		_items = do_wrap<G> ((owned)items);
	}

	internal ArrayList.with_closure (owned Functions.EqualDataFuncClosure<G> equal_func) {
		_equal_func = equal_func;
		_items = new G[4];
		_size = 0;
	}

	/**
	 * {@inheritDoc}
	 */
	public override bool foreach(ForallFunc<G> f) {
		for (int i = 0; i < _size; i++) {
			if (!f (_items[i])) {
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
	public override bool contains (G item) {
		return (index_of (item) != -1);
	}

	/**
	 * {@inheritDoc}
	 */
	public override int index_of (G item) {
		for (int index = 0; index < _size; index++) {
			if (equal_func (_items[index], item)) {
				return index;
			}
		}
		return -1;
	}

	/**
	 * {@inheritDoc}
	 */
	public override G get (int index) {
		assert (index >= 0);
		assert (index < _size);

		return _items[index];
	}

	/**
	 * {@inheritDoc}
	 */
	public override void set (int index, G item) {
		assert (index >= 0);
		assert (index < _size);

		_items[index] = item;
	}

	/**
	 * {@inheritDoc}
	 */
	public override bool add (G item) {
		if (_size == _items.length) {
			grow_if_needed (1);
		}
		_items[_size++] = item;
		_stamp++;
		return true;
	}

	/**
	 * {@inheritDoc}
	 */
	public override void insert (int index, G item) {
		assert (index >= 0);
		assert (index <= _size);

		if (_size == _items.length) {
			grow_if_needed (1);
		}
		shift (index, 1);
		_items[index] = item;
		_stamp++;
	}

	/**
	 * {@inheritDoc}
	 */
	public override bool remove (G item) {
		for (int index = 0; index < _size; index++) {
			if (equal_func (_items[index], item)) {
				remove_at (index);
				return true;
			}
		}
		return false;
	}

	/**
	 * {@inheritDoc}
	 */
	public override G remove_at (int index) {
		assert (index >= 0);
		assert (index < _size);

		G item = _items[index];
		_items[index] = null;

		shift (index + 1, -1);

		_stamp++;
		return item;
	}

	/**
	 * {@inheritDoc}
	 */
	public override void clear () {
		for (int index = 0; index < _size; index++) {
			_items[index] = null;
		}
		_size = 0;
		_stamp++;
	}

	/**
	 * {@inheritDoc}
	 */
	public override List<G>? slice (int start, int stop) {
		return_val_if_fail (start <= stop, null);
		return_val_if_fail (start >= 0, null);
		return_val_if_fail (stop <= _size, null);

		var slice = new ArrayList<G>.with_closure (_equal_func);
		for (int i = start; i < stop; i++) {
			slice.add (this[i]);
		}

		return slice;
	}

	/**
	 * {@inheritDoc}
	 */
	public bool add_all (Collection<G> collection) {
		if (collection.is_empty) {
			return false;
		}

		grow_if_needed (collection.size);
		collection.foreach ((item) => {_items[_size++] = item; return true;});
		_stamp++;
		return true;
	}

	private void shift (int start, int delta) {
#if !DISABLE_INTERNAL_ASSERTS
		assert (start >= 0);
		assert (start <= _size);
		assert (start >= -delta);
#else
		assume (start >= 0);
		assume (start <= _size);
		assume (start >= -delta);
#endif

		_items.move (start, start + delta, _size - start);

		_size += delta;
	}

	private void grow_if_needed (int new_count) {
#if !DISABLE_INTERNAL_ASSERTS
		assert (new_count >= 0);
#else
		assume (new_count >= 0);
#endif

		int minimum_size = _size + new_count;
		if (minimum_size > _items.length) {
			// double the capacity unless we add even more items at this time
			set_capacity (new_count > _items.length ? minimum_size : 2 * _items.length);
		}
	}

	private void set_capacity (int value) {
#if !DISABLE_INTERNAL_ASSERTS
		assert (value >= _size);
#endif

		_items.resize (value);
	}

	private class Iterator<G> : Object, Traversable<G>, Vala.Iterator<G>, BidirIterator<G>, ListIterator<G>, BidirListIterator<G> {
		public Iterator (ArrayList<G> list) {
			_list = list;
			_stamp = _list._stamp;
		}

		public Iterator.from_iterator (Iterator<G> iter) {
			_list = iter._list;
			_index = iter._index;
			_removed = iter._removed;
			_stamp = iter._stamp;
		}

		public bool next () {
			assert (_stamp == _list._stamp);
			if (_index + 1 < _list._size) {
				_index++;
				_removed = false;
				return true;
			}
			return false;
		}

		public bool has_next () {
			assert (_stamp == _list._stamp);
			return (_index + 1 < _list._size);
		}

		public bool first () {
			assert (_stamp == _list._stamp);
			if (_list.size == 0) {
				return false;
			}
			_index = 0;
			_removed = false;
			return true;
		}

		public new G get () {
			assert (_stamp == _list._stamp);
			assert (! _removed);
			assert (_index >= 0);
#if !DISABLE_INTERNAL_ASSERTS
			assert (_index < _list._size);
#else
			assume (_index < _list._size);
#endif
			return _list._items[_index];
		}

		public void remove () {
			assert (_stamp == _list._stamp);
			assert (! _removed && _index >= 0);
#if !DISABLE_INTERNAL_ASSERTS
			assert (_index < _list._size);
#else
			assume (_index < _list._size);
#endif
			_list.remove_at (_index);
			_index--;
			_removed = true;
			_stamp = _list._stamp;
		}

		public bool previous () {
			assert (_stamp == _list._stamp);
			if (_removed && _index >= 0) {
				_removed = false;
				return true;
			}
			if (_index > 0) {
				_index--;
				return true;
			}
			return false;
		}

		public bool has_previous () {
			assert (_stamp == _list._stamp);
			return (_index > 0 || (_removed && _index >= 0));
		}

		public bool last () {
			assert (_stamp == _list._stamp);
			if (_list.size == 0) {
				return false;
			}
			_index = _list._size - 1;
			return true;
		}

		public new void set (G item) {
			assert (_stamp == _list._stamp);
			assert (! _removed);
			assert (_index >= 0);
#if !DISABLE_INTERNAL_ASSERTS
			assert (_index < _list._size);
#else
			assume (_index < _list._size);
#endif
			_list._items[_index] = item;
			_stamp = ++_list._stamp;
		}

		public void insert (G item) {
			assert (_stamp == _list._stamp);
			assert (_index < _list._size);
			if (_index == -1) {
				_list.insert (0, item);
				_removed = true;
			}
			if (_removed) {
				_list.insert (_index + 1, item);
			} else {
				_list.insert (_index, item);
			}
			_index++;
			_stamp = _list._stamp;
		}

		public void add (G item) {
			assert (_stamp == _list._stamp);
			assert (_index < _list._size);
			_list.insert (_index + 1, item);
			_index++;
			_removed = false;
			_stamp = _list._stamp;
		}

		public int index () {
			assert (_stamp == _list._stamp);
			assert (_index >= 0);
			assert (_index < _list._size);
			return _index;
		}

		public bool read_only {
			get {
				return false;
			}
		}

		public bool valid {
			get {
				return _index >= 0 && _index < _list._size && ! _removed;
			}
		}

		public bool foreach (ForallFunc<G> f) {
			assert (_stamp == _list._stamp);
			if (_index < 0 || _removed) {
				_index++;
			}
			while (_index < _list._size) {
				if (!f (_list._items[_index])) {
					return false;
				}
				_index++;
			}
			_index = _list._size - 1;
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

		protected ArrayList<G> _list;
		protected int _index = -1;
		protected bool _removed = false;
		protected int _stamp = 0;
	}

	private static G[] do_wrap<G> (owned G[] data) {
		var t = typeof (G);
		if (t == typeof (bool)) {
			return wrap_bool<G> ((bool[])data);
		} else if (t == typeof (char)) {
			return wrap_char<G> ((char[])data);
		} else if (t == typeof (uchar)) {
			return wrap_uchar<G> ((uchar[])data);
		} else if (t == typeof (int)) {
			return wrap_int<G> ((int[])data);
		} else if (t == typeof (uint)) {
			return wrap_uint<G> ((uint[])data);
		} else if (t == typeof (int64)) {
			return wrap_int64<G> ((int64[])data);
		} else if (t == typeof (uint64)) {
			return wrap_uint64<G> ((uint64[])data);
		} else if (t == typeof (long)) {
			return wrap_long<G> ((long[])data);
		} else if (t == typeof (ulong)) {
			return wrap_ulong<G> ((ulong[])data);
		} else if (t == typeof (float)) {
			return wrap_float<G> ((float?[])data);
		} else if (t == typeof (double)) {
			return wrap_double<G> ((double?[])data);
		} else {
			return (owned)data;
		}
	}

	private static G[] wrap_bool<G> (bool[] data) {
		G[] arr = new G[data.length];
		for (uint i = 0; i < data.length; i++) {
			arr[i] = data[i];
		}
		return arr;
	}

	private static G[] wrap_char<G> (char[] data) {
		G[] arr = new G[data.length];
		for (uint i = 0; i < data.length; i++) {
			arr[i] = data[i];
		}
		return arr;
	}

	private static G[] wrap_uchar<G> (uchar[] data) {
		G[] arr = new G[data.length];
		for (uint i = 0; i < data.length; i++) {
			arr[i] = data[i];
		}
		return arr;
	}

	private static G[] wrap_int<G> (int[] data) {
		G[] arr = new G[data.length];
		for (uint i = 0; i < data.length; i++) {
			arr[i] = data[i];
		}
		return arr;
	}

	private static G[] wrap_uint<G> (uint[] data) {
		G[] arr = new G[data.length];
		for (uint i = 0; i < data.length; i++) {
			arr[i] = data[i];
		}
		return arr;
	}

	private static G[] wrap_int64<G> (int64[] data) {
		G[] arr = new G[data.length];
		for (uint i = 0; i < data.length; i++) {
			arr[i] = data[i];
		}
		return arr;
	}

	private static G[] wrap_uint64<G> (uint64[] data) {
		G[] arr = new G[data.length];
		for (uint i = 0; i < data.length; i++) {
			arr[i] = data[i];
		}
		return arr;
	}

	private static G[] wrap_long<G> (long[] data) {
		G[] arr = new G[data.length];
		for (uint i = 0; i < data.length; i++) {
			arr[i] = data[i];
		}
		return arr;
	}

	private static G[] wrap_ulong<G> (ulong[] data) {
		G[] arr = new G[data.length];
		for (uint i = 0; i < data.length; i++) {
			arr[i] = data[i];
		}
		return arr;
	}

	private static G[] wrap_float<G> (float?[] data) {
		G[] arr = new G[data.length];
		for (uint i = 0; i < data.length; i++) {
			arr[i] = data[i];
		}
		return arr;
	}

	private static G[] wrap_double<G> (double?[] data) {
		G[] arr = new G[data.length];
		for (uint i = 0; i < data.length; i++) {
			arr[i] = data[i];
		}
		return arr;
	}
}

