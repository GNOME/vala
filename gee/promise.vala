/* promise.vala
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

using GLib;

/**
 * Promise allows to set a value with associated {@link Future}. Please note that
 * value can be stored only once.
 *
 * Typically the producer will create promise and return {@link future} while
 * keeping the promise to itself. Then when value is ready it can call {@link set_value}.
 *
 * @see Future
 * @see task
 */
public class Vala.Promise<G> {
	public Promise () {
		_future = new Future<G> ();
	}

	~Promise () {
		_future.abandon ();
	}

	/**
	 * {@link Future} value of this promise
	 */
	public Vala.Future<G> future {
		get {
			return _future;
		}
	}

	/**
	 * Sets the value of the future.
	 *
	 * @param value Value of future
	 */
	public void set_value (owned G value) {
		_future.set_value ((owned)value);
	}

	/**
	 * Sets the exception.
	 *
	 * @param exception Exception thrown
	 */
	public void set_exception (owned GLib.Error exception) {
		_future.set_exception ((owned)exception);
	}

	private class Future<G> : Object, Vala.Future<G> {
		public Future () {
			_when_done = new Vala.Future.SourceFuncArrayElement<G>[0];
		}

		public bool ready {
			get {
				_mutex.lock ();
				bool result = _state != State.INIT;
				_mutex.unlock ();
				return result;
			}
		}

		public GLib.Error? exception {
			get {
				return _exception;
			}
		}

		public unowned G wait () throws FutureError {
			_mutex.lock ();
			State state = _state;
			if (_state == State.INIT) {
				_set.wait (_mutex);
				state = _state;
			}
			assert (state != State.INIT);
			_mutex.unlock ();
			switch (state) {
			case State.ABANDON:
				throw new FutureError.ABANDON_PROMISE ("Promise has been abandon");
			case State.EXCEPTION:
				throw new FutureError.EXCEPTION ("Exception has been thrown");
			case State.READY:
				return _value;
			default:
				assert_not_reached ();
			}
		}

		public bool wait_until (int64 end_time, out unowned G? value = null) throws FutureError {
			_mutex.lock ();
			State state = _state;
			if (state == State.INIT) {
				_set.wait_until (_mutex, end_time);
				state = _state;
			}
			_mutex.unlock ();
			switch (state) {
			case State.INIT:
				value = null;
				return false;
			case State.ABANDON:
				throw new FutureError.ABANDON_PROMISE ("Promise has been abandon");
			case State.EXCEPTION:
				throw new FutureError.EXCEPTION ("Exception has been thrown");
			case State.READY:
				value = _value;
				return true;
			default:
				assert_not_reached ();
			}
		}

		public async unowned G wait_async () throws Vala.FutureError {
			_mutex.lock ();
			State state = _state;
			if (state == State.INIT) {
				_when_done += SourceFuncArrayElement(wait_async.callback);
				yield Vala.Utils.Async.yield_and_unlock (_mutex);
				state = _state;
			} else {
				_mutex.unlock ();
			}
			assert (state != State.INIT);
			switch (state) {
			case State.ABANDON:
				throw new FutureError.ABANDON_PROMISE ("Promise has been abandon");
			case State.EXCEPTION:
				throw new FutureError.EXCEPTION ("Exception has been thrown");
			case State.READY:
				return _value;
			default:
				assert_not_reached ();
			}
		}

		internal void set_value (owned G value) {
			_mutex.lock ();
			assert (_state == State.INIT);
			_state = State.READY;
			_value = (owned)value;
			_set.broadcast ();
			_mutex.unlock ();
			Vala.Future.SourceFuncArrayElement<G>[] when_done = (owned)_when_done;
			for (int i = 0; i < when_done.length; i++) {
				when_done[i].func ();
			}
		}

		internal void set_exception (owned GLib.Error? exception) {
			_mutex.lock ();
			assert (_state == State.INIT);
			_state = State.EXCEPTION;
			_exception = (owned)exception;
			_set.broadcast ();
			_mutex.unlock ();
			Vala.Future.SourceFuncArrayElement<G>[] when_done = (owned)_when_done;
			for (int i = 0; i < when_done.length; i++) {
				when_done[i].func ();
			}
		}

		internal void abandon () {
			_mutex.lock ();
			if (_state != State.INIT) {
				_mutex.unlock ();
				return;
			}
			assert (_state == State.INIT);
			_state = State.ABANDON;
			_set.broadcast ();
			_mutex.unlock ();
			Vala.Future.SourceFuncArrayElement<G>[] when_done = (owned)_when_done;
			for (int i = 0; i < when_done.length; i++) {
				when_done[i].func ();
			}
		}

		private Mutex _mutex = Mutex ();
		private Cond _set = Cond ();
		private State _state;
		private G? _value;
		private GLib.Error? _exception;
		private Vala.Future.SourceFuncArrayElement<G>[]? _when_done;

		private enum State {
			INIT,
			ABANDON,
			EXCEPTION,
			READY
		}
	}
	private Future<G> _future;
}

