/* lightmapfuture.vala
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
internal class Vala.LightMapFuture<A, G> : Object, Future<A> {
	public LightMapFuture (Future<G> base_future, owned Future.LightMapFunc<A, G> func) {
		_base = base_future;
		_func = (owned)func;
	}

	public bool ready {
		get {
			return _base.ready;
		}
	}

	public GLib.Error exception {
		get {
			return _base.exception;
		}
	}

	public unowned A wait () throws Vala.FutureError {
		return _func (_base.wait ());
	}

	public bool wait_until (int64 end_time, out unowned A? value = null) throws Vala.FutureError {
		unowned G arg;
		bool result;
		value = null;
		if ((result = _base.wait_until (end_time, out arg))) {
			value = _func (arg);
		}
		return result;
	}

	public async unowned A wait_async () throws Vala.FutureError {
		unowned G arg = yield _base.wait_async ();
		return _func (arg);
	}

	private Future<G> _base;
	private Future.LightMapFunc<A, G> _func;
}

