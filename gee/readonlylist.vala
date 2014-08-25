/* readonlylist.vala
 *
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
 * Read-only view for {@link List} collections.
 *
 * This class decorates any class which implements the {@link List}
 * interface by making it read only. Any method which normally modify data will
 * throw an error.
 *
 * @see List
 */
internal class Vala.ReadOnlyList<G> : Vala.ReadOnlyCollection<G>, List<G> {

	/**
	 * Constructs a read-only list that mirrors the content of the specified
	 * list.
	 *
	 * @param list the list to decorate.
	 */
	public ReadOnlyList (List<G> list) {
		base (list);
	}

	/**
	 * {@inheritDoc}
	 */
	public ListIterator<G> list_iterator () {
		return new Iterator<G> (((Vala.List<G>) _collection).list_iterator ());
	}

	/**
	 * {@inheritDoc}
	 */
	public int index_of (G item) {
		return ((Vala.List<G>) _collection).index_of (item);
	}

	/**
	 * Unimplemented method (read only list).
	 */
	public void insert (int index, G item) {
		assert_not_reached ();
	}

	/**
	 * Unimplemented method (read only list).
	 */
	public G remove_at (int index) {
		assert_not_reached ();
	}

	/**
	 * {@inheritDoc}
	 */
	public new G? get (int index) {
		return ((Vala.List<G>) _collection).get (index);
	}

	/**
	 * Unimplemented method (read only list).
	 */
	public new void set (int index, G o) {
		assert_not_reached ();
	}

	/**
	 * {@inheritDoc}
	 */
	public List<G>? slice (int start, int stop) {
		return ((Vala.List<G>) _collection).slice (start, stop);
	}

	/**
	 * {@inheritDoc}
	 */
	public G? first () {
		return ((Vala.List<G>) _collection).first ();
	}

	/**
	 * {@inheritDoc}
	 */
	public G? last () {
		return ((Vala.List<G>) _collection).last ();
	}

	/**
	 * Unimplemented method (read only list).
	 */
	public void insert_all (int index, Collection<G> collection) {
		assert_not_reached ();
	}

	/**
	 * {@inheritDoc}
	 */
	public void sort (owned CompareDataFunc<G>? compare = null) {
		assert_not_reached ();
	}

	/**
	 * {@inheritDoc}
	 */
	public virtual new List<G> read_only_view {
		owned get { return this; }
	}


	protected class Iterator<G> : ReadOnlyCollection.Iterator<G>, ListIterator<G> {
		public Iterator (ListIterator<G> iterator) {
			base (iterator);
		}

		public new void set (G item) {
			assert_not_reached ();
		}

		public void add (G item) {
			assert_not_reached ();
		}

		public int index () {
			return ((ListIterator<G>) _iter).index ();
		}
	}
}

