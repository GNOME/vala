/* teeiterator.vala
 *
 * Copyright (C) 2013  Maciej Piechotka
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

internal class Vala.TeeIterator<G> : Object, Traversable<G>, Iterator<G> {
	internal TeeIterator (Node<G>? head, bool valid) {
		_head = head;
		_valid = valid;
	}

	public bool foreach (ForallFunc<G> f) {
		Node<G> head = (owned)_head;
		bool valid = _valid;
		if (valid) {
			if (!f (head._data.get ())) {
				return false;
			}
		}
		unowned Node<G>? next_head = head._next.value;
		while (next_head != null) {
			head = next_head;
			valid = true;
			if (!f (head._data.get ())) {
				_head = (owned)head;
				_valid = valid;
				return false;
			}
		}
		_head = (owned)head;
		_valid = valid;
		return true;
	}

	public Iterator<G>[] tee (uint forks) {
		if (forks == 0) {
			return new Iterator<G>[0];
		} else {
			Iterator<G>[] result = new Iterator<G>[forks];
			result[0] = this;
			for (uint i = 1; i < forks; i++) {
				result[i] = new TeeIterator<G> (_head, _valid);
			}
			return result;
		}
	}

	public bool next () {
		unowned Node<G>? next = _head._next.value;
		if (next != null) {
			_head = next;
			_valid = true;
			return true;
		} else {
			return false;
		}
	}

	public bool has_next () {
		return _head._next.get () != null;
	}

	public new G get () {
		return _head._data.get ();
	}

	public void remove () {
		assert_not_reached ();
	}

	public bool valid { get { return _valid; } }

	public bool read_only { get { return true; } }

	private Node<G> _head;
	private bool _valid;

	internal static Lazy<Node<G>?> create_nodes<G> (Iterator<G> iterator, Lazy<G> dependent) {
		return new Lazy<Node<G>?>(() => {
			dependent.eval ();
			if (!iterator.next ())
				return null;
			Lazy<G> data = new Lazy<G> (() => {return iterator.get ();});
			Lazy<Node<G>?> next = create_nodes<G> (iterator, data);
			return new Node<G> ((owned)data, (owned)next);
		});
	}

	internal class Node<G> {
		public Node (owned Lazy<G> data, owned Lazy<Node<G>?> next) {
			_data = (owned)data;
			_next = (owned)next;
		}
		public Lazy<G> _data;
		public Lazy<Node<G>?> _next;
	}

}

