/* lazy.vala
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

namespace Vala {
	public delegate G LazyFunc<G> ();
}

/**
 * Represents a lazy value. I.e. value that is computed on demand.
 *
 * This class is not thread-safe.
 */
public class Vala.Lazy<G> {
	public Lazy (owned LazyFunc<G> func) {
		_func = (owned)func;
	}

	public Lazy.from_value (G item) {
		_value = item;
	}

	public void eval () {
		if (_func != null) {
			_value = _func ();
			_func = null;
		}
	}

	public new G get () {
		eval ();
		return _value;
	}

	public new G value {
		get {
			eval ();
			return _value;
		}
	}

	/**
	 * Provides a future for a lazy value.
	 *
	 * Note: The future can be requested only once and all access must be
	 *   done through it.
	 */
	public Vala.Future<G>? future {
		owned get {
			return new Future<G> (this);
		}
	}

	private LazyFunc<G>? _func;
	private G? _value;

	private class Future<G> : Object, Vala.Future<G> {
		public Future (Lazy<G> lazy) {
			_lazy = lazy;
			_when_done = new Vala.Future.SourceFuncArrayElement<G>[0];
		}

		public bool ready {
			get {
				_mutex.lock ();
				bool result = _lazy._func == null;
				_mutex.unlock ();
				return result;
			}
		}

		public GLib.Error? exception {get {return null;}}

		public unowned G wait () throws Vala.FutureError {
			_mutex.lock ();
			if (_lazy._func != null) {
				if (_state == State.EVAL) {
					_eval.wait (_mutex);
					_mutex.unlock ();
				} else {
					do_eval ();
				}
			} else {
				_mutex.unlock ();
			}
			return _lazy._value;
		}

		public unowned bool wait_until (int64 end_time, out unowned G? value = null) throws Vala.FutureError {
			_mutex.lock ();
			if (_lazy._func != null) {
				if (_state == State.EVAL) {
					bool res = _eval.wait_until (_mutex, end_time);
					_mutex.unlock ();
					if (!res) {
						value = null;
						return false;
					}
				} else {
					do_eval ();
				}
			} else {
				_mutex.unlock ();
			}
			value = _lazy._value;
			return true;
		}

		public async unowned G wait_async () throws Vala.FutureError {
			_mutex.lock ();
			if (_lazy._func != null) {
				if (_state == State.EVAL) {
					_when_done += SourceFuncArrayElement(wait_async.callback);
					yield Vala.Utils.Async.yield_and_unlock (_mutex);
				} else {
					do_eval ();
				}
			} else {
				_mutex.unlock ();
			}
			return _lazy.value;
		}

		private void do_eval () {
			_state = State.EVAL;
			_mutex.unlock ();

			_lazy._value = _lazy._func ();

			_mutex.lock ();
			_lazy._func = null;
			_state = State.UNLOCK;
			_eval.broadcast ();
			_mutex.unlock ();

			Vala.Future.SourceFuncArrayElement<G>[] when_done = (owned)_when_done;
			for (int i = 0; i < when_done.length; i++) {
				when_done[i].func ();
			}
		}

		private Mutex _mutex = Mutex ();
		private Cond _eval = Cond ();
		private Lazy<G> _lazy;
		private State _state = State.UNLOCK;
		private Vala.Future.SourceFuncArrayElement<G>[]? _when_done;
		private enum State {
			UNLOCK,
			EVAL
		}
	}
}
