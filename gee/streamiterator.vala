/* streamiterator.vala
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

internal class Vala.StreamIterator<A, G> : GLib.Object, Traversable<A>, Iterator<A> {
	public StreamIterator (Iterator<G> outer, owned StreamFunc<A, G> func) {
		_outer = outer;
		_func = (owned)func;
		_current = null;
		_need_next = true;
		_finished = false;

		_state = _func (Traversable.Stream.YIELD, null, out _current);
		switch (_state) {
		case Traversable.Stream.WAIT:
		case Traversable.Stream.YIELD:
			_need_next = !_outer.valid;
			break;
		case Traversable.Stream.CONTINUE:
			if (_outer.valid) {
				_state = _func (_state, new Lazy<G> (() => {
					return _outer.get ();
				}), out _current);
				switch (_state) {
				case Traversable.Stream.YIELD:
				case Traversable.Stream.CONTINUE:
				case Traversable.Stream.WAIT:
					break;
				case Traversable.Stream.END:
					_finished = true;
					return;
				default:
					assert_not_reached ();
				}
			}
			break;
		case Traversable.Stream.END:
			_finished = true;
			return;
		}
	}

	public bool foreach (ForallFunc<A> f) {
		Lazy<G>? current = null;
		if (_current != null) {
			if (!f (_current.value)) {
				return false;
			}
		}
		if (_next != null) {
			current = (owned)_next;
			if (!f (current.value)) {
				return false;
			}
		} else if (_finished) {
			return true;
		}
		unowned Iterator<G> outer = _outer;
		unowned StreamFunc<A, G> func = _func;
		Traversable.Stream state = _state;
		bool need_next = _need_next;
		bool result = true;
		Lazy<A>? next_current;
		Lazy<G>? outer_value = _outer_value;
		while ((next_current = yield_next<A, G>(outer, func, ref state, ref need_next, ref outer_value)) != null) {
			current = (owned)next_current;
			if (!f (current.value)) {
				result = false;
				break;
			}
		}
		_state = state;
		_need_next = need_next;
		_finished = result;
		_current = (owned)current;
		_outer_value = (owned)outer_value;
		return result;
	}

	public bool next () {
		if (has_next ()) {
			if (_current != null) {
				_current.eval ();
			}
			_current = (owned)_next;
			return true;
		} else {
			return false;
		}
	}

	public bool has_next () {
		if (_finished) {
			return false;
		}
		if (_next != null) {
			return true;
		}
		_next = yield_next<A, G> (_outer, _func, ref _state, ref _need_next, ref _outer_value);
		_finished = _next == null;
		return !_finished;
	}

	public new A get () {
		assert (_current != null);
		return _current.value;
	}

	public void remove () {
		assert_not_reached ();
	}

	public bool valid { get { return _current != null; } }
	public bool read_only { get { return true; } }

	private static inline Lazy<A>? yield_next<A, G> (Iterator<G> outer, StreamFunc<A, G> func, ref Traversable.Stream state, ref bool need_next, ref Lazy<G>? outer_value) {
		Lazy<A>? value = null;
		if (state != Traversable.Stream.CONTINUE)
			state = func (state, null, out value);
		while (true) {
			switch (state) {
			case Traversable.Stream.YIELD:
				return value;
			case Traversable.Stream.CONTINUE:
				if (outer_value != null) {
					outer_value.eval ();
				}
				if (need_next) {
					if (!outer.has_next ()) {
						state = func (Traversable.Stream.END, null, out value);
						continue;
					}
					outer_value = new Lazy<G> (() => {
						assert (outer.next ());
						return outer.get ();
					});
				} else {
					need_next = true;
					outer_value = new Lazy<G> (() => {
						return outer.get ();
					});
				}
				state = func (state, outer_value, out value);
				break;
			case Traversable.Stream.WAIT:
				state = func (state, null, out value);
				break;
			case Traversable.Stream.END:
				return null;
			default:
				assert_not_reached ();
			}
		}
	}

	private Iterator<G> _outer;
	private StreamFunc<A, G> _func;
	private Lazy<G>? _outer_value;
	private Lazy<A>? _current;
	private Lazy<A>? _next;
	private Traversable.Stream _state;
	private bool _need_next;
	private bool _finished;
}

