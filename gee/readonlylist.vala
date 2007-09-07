/* readonlylist.vala
 *
 * Copyright (C) 2007  Jürg Billeter
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
 * Represents a read-only collection of items in a well-defined order.
 */
public class Gee.ReadOnlyList<G> : Object, Iterable<G>, Collection<G>, List<G> {
	public int size {
		get { return _list.size; }
	}

	public List<G> list {
		set { _list = value; }
	}

	private List<G> _list;

	public ReadOnlyList (construct List<G> list = null) {
	}

	public Gee.Iterator<G> iterator () {
		if (_list == null) {
			return new Iterator<G> ();
		}

		return _list.iterator ();
	}

	public bool contains (G item) {
		if (_list == null) {
			return false;
		}

		return _list.contains (item);
	}

	public int index_of (G item) {
		if (_list == null) {
			return -1;
		}

		return _list.index_of (item);
	}

	public bool add (G item) {
		assert_not_reached ();
		return false;
	}

	public bool remove (G item) {
		assert_not_reached ();
		return false;
	}

	public void insert (int index, G item) {
		assert_not_reached ();
	}

	public void remove_at (int index) {
		assert_not_reached ();
	}

	public G get (int index) {
		if (_list == null) {
			return null;
		}

		return _list.get (index);
	}

	public void set (int index, G o) {
		assert_not_reached ();
	}

	public void clear () {
		assert_not_reached ();
	}

	class Iterator<G> : Object, Gee.Iterator<G> {
		public bool next () {
			return false;
		}

		public G get () {
			return null;
		}
	}
}

