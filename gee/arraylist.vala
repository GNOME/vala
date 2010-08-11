/* arraylist.vala
 *
 * Copyright (C) 2004-2005  Novell, Inc
 * Copyright (C) 2005  David Waite
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
 * Arrays of arbitrary elements which grow automatically as elements are added.
 */
public class Vala.ArrayList<G> : List<G> {
	public override int size {
		get { return _size; }
	}

	public EqualFunc equal_func {
		set { _equal_func = value; }
	}

	private G[] _items = new G[4];
	private int _size;
	private EqualFunc _equal_func;

	// concurrent modification protection
	private int _stamp = 0;

	public ArrayList (EqualFunc equal_func = GLib.direct_equal) {
		this.equal_func = equal_func;
	}

	public override Type get_element_type () {
		return typeof (G);
	}

	public override Vala.Iterator<G> iterator () {
		return new Iterator<G> (this);
	}

	public override bool contains (G item) {
		return (index_of (item) != -1);
	}

	public override int index_of (G item) {
		for (int index = 0; index < _size; index++) {
			if (_equal_func (_items[index], item)) {
				return index;
			}
		}
		return -1;
	}

	public override G? get (int index) {
		assert (index >= 0 && index < _size);

		return _items[index];
	}

	public override void set (int index, G item) {
		assert (index >= 0 && index < _size);

		_items[index] = item;
	}

	public override bool add (G item) {
		if (_size == _items.length) {
			grow_if_needed (1);
		}
		_items[_size++] = item;
		_stamp++;
		return true;
	}

	public override void insert (int index, G item) {
		assert (index >= 0 && index <= _size);

		if (_size == _items.length) {
			grow_if_needed (1);
		}
		shift (index, 1);
		_items[index] = item;
		_stamp++;
	}

	public override bool remove (G item) {
		for (int index = 0; index < _size; index++) {
			if (_equal_func (_items[index], item)) {
				remove_at (index);
				return true;
			}
		}
		return false;
	}

	public override void remove_at (int index) {
		assert (index >= 0 && index < _size);

		_items[index] = null;

		shift (index + 1, -1);

		_stamp++;
	}

	public override void clear () {
		for (int index = 0; index < _size; index++) {
			_items[index] = null;
		}
		_size = 0;
		_stamp++;
	}

	private void shift (int start, int delta) {
		assert (start >= 0 && start <= _size && start >= -delta);

		_items.move (start, start + delta, _size - start);

		_size += delta;
	}

	private void grow_if_needed (int new_count) {
		assert (new_count >= 0);

		int minimum_size = _size + new_count;
		if (minimum_size > _items.length) {
			// double the capacity unless we add even more items at this time
			set_capacity (new_count > _items.length ? minimum_size : 2 * _items.length);
		}
	}

	private void set_capacity (int value) {
		assert (value >= _size);

		_items.resize (value);
	}

	private class Iterator<G> : Vala.Iterator<G> {
		public ArrayList<G> list {
			set {
				_list = value;
				_stamp = _list._stamp;
			}
		}

		private ArrayList<G> _list;
		private int _index = -1;

		// concurrent modification protection
		public int _stamp = 0;

		public Iterator (ArrayList list) {
			this.list = list;
		}

		public override bool next () {
			assert (_stamp == _list._stamp);
			if (_index < _list._size) {
				_index++;
			}
			return (_index < _list._size);
		}

		public override G? get () {
			assert (_stamp == _list._stamp);

			if (_index < 0 || _index >= _list._size) {
				return null;
			}

			return _list.get (_index);
		}
	}
}

