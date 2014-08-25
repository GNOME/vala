/* unfolditerator.vala
 *
 * Copyright (C) 2011  Maciej Piechotka
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

internal class Vala.UnfoldIterator<G> : Object, Traversable<G>, Iterator<G> {
	public UnfoldIterator (owned UnfoldFunc<G> func, owned Lazy<G>? current = null) {
		_current = (owned)current;
		_func = (owned)func;
		_end = false;
	}

	public bool next () {
		if (has_next ()) {
			if (_current != null)
				_current.eval ();
			_current = (owned)_next;
			return true;
		}
		return false;
	}

	public bool has_next () {
		if (_end)
			return false;
		if (_next != null)
			return true;
		_next = _func ();
		if (_next == null)
			_end = true;
		return _next != null;
	}

	public new G get () {
		assert (_current != null);
		return _current.value;
	}

	public void remove () {
		assert_not_reached ();
	}

	public bool valid { get { return _current != null; } }
	public bool read_only { get { return true; } }

	public bool foreach (ForallFunc<G> f) {
		if (_current != null) {
			if (!f (_current.value)) {
				return false;
			}
		}
		if (_next != null) {
			_current = (owned)_next;
			if (!f (_current.value)) {
				return false;
			}
		} else if (_end) {
			return true;
		}
		if (_current == null) {
			_current = _func ();
			if (_current == null) {
				_end = true;
				return true;
			} else {
				if (!f (_current.value)) {
					return false;
				}
			}
		}
		while ((_next = _func ()) != null) {
			_current = (owned)_next;
			if (!f (_current.value)) {
				return false;
			}
		}
		_end = true;
		return true;
	}

	private UnfoldFunc<G> _func;
	private Lazy<G>? _current;
	private Lazy<G>? _next;
	private bool _end;
}
