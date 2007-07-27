/* readonlycollection.vala
 *
 * Copyright (C) 2007  Jürg Billeter
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public
 * License as published by the Free Software Foundation; either
 * version 2 of the License, or (at your option) any later version.

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
 * Represents a read-only collection of items.
 */
public class Gee.ReadOnlyCollection<G> : Iterable<G>, Collection<G> {
	public int size {
		get { return _collection.size; }
	}

	public Collection<G> collection {
		set { _collection = value; }
	}

	private Collection<G> _collection;

	public ReadOnlyCollection (construct Collection<G> collection = null) {
	}

	public Gee.Iterator<G> iterator () {
		if (_collection == null) {
			return new Iterator<G> ();
		}

		return _collection.iterator ();
	}

	public bool contains (G item) {
		if (_collection == null) {
			return false;
		}

		return _collection.contains (item);
	}

	public bool add (G item) {
		assert_not_reached ();
		return false;
	}

	public bool remove (G item) {
		assert_not_reached ();
		return false;
	}

	public void clear () {
		assert_not_reached ();
	}

	private class Iterator<G> : Gee.Iterator<G> {
		public bool next () {
			return false;
		}

		public G get () {
			return null;
		}
	}
}

