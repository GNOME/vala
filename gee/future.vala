/* future.vala
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
 * Future is a value which might not yet be computed - for example it is calculated
 * in different thread or depends on I/O value.
 *
 * All methods can be called from many threads as part of interface.
 *
 * Note: Statement that call does not block does not mean that it is lock-free.
 *   Internally the implementation is allowed to take mutex but it should guarantee
 *   that it is not for a long time (including blocking on anything else, I/O calls
 *   or callbacks).
 *
 * @see Promise
 * @see Lazy
 * @see task
 * @see async_task
 */
[GenericAccessors]
public interface Vala.Future<G> : Object {
	/**
	 * The value associated with Future. If value is not ready getting value
	 * will block until value is ready.
	 *
	 * Returned value is always the same and it is alive at least as long
	 * as the future.
	 */
	[CCode (ordering = 7)]
	public virtual new G? value {
		get {
			try {
				return wait ();
			} catch (FutureError ex) {
				return null;
			}
		}
	}

	/**
	 * Checks if value is ready. If it is calls to {@link wait} and
	 * {@link wait_until} will not block and value is returned immidiatly.
	 */
	[CCode (ordering = 8)]
	public abstract bool ready {get;}

	/**
	 * Checks the exception that have been set. I.e. if the computation
	 * has thrown the exception it should be set here and the {@link wait},
	 * {@link wait_until} and {@link wait_async} should throw
	 * {@link FutureError.EXCEPTION}.
	 */
	[CCode (ordering = 9)]
	public abstract GLib.Error? exception {get;}

	/**
	 * Waits until the value is ready.
	 *
	 * @return The {@link value} associated with future
	 * @see ready
	 * @see wait_until
	 * @see wait_async
	 */
	[CCode (ordering = 0)]
	public abstract unowned G wait () throws Vala.FutureError;

	/**
	 * Waits until the value is ready or deadline have passed.
	 *
	 * @param end_time The time when the wait should finish
	 * @param value The {@link value} associated with future if the wait was successful
	 * @return ``true`` if the value was ready within deadline or ``false`` otherwise
	 * @see ready
	 * @see wait
	 * @see wait_async
	 */
	[CCode (ordering = 1)]
	public abstract bool wait_until (int64 end_time, out unowned G? value = null) throws Vala.FutureError;

	/**
	 * Reschedules the callback until the {@link value} is available.
	 *
	 * @return The {@link value} associated with future
	 * @see ready
	 * @see wait
	 * @see wait_until
	 */
	[CCode (ordering = 2)]
	public abstract async unowned G wait_async () throws Vala.FutureError;
	public delegate A MapFunc<A, G> (G value);

	/**
	 * Maps a future value to another value by a function and returns the
	 * another value in future.
	 *
	 * Note: As time taken by function might not contribute to
	 *   {@link wait_until} and the implementation is allowed to compute
	 *   value eagerly by {@link wait_async} it is recommended to use
	 *   {@link task} and {@link flat_map} for longer computation.
	 *
	 * @param func Function applied to {@link value}
	 * @return Value returned by function
	 *
	 * @see flat_map
	 * @see light_map
	 */
	[CCode (ordering = 3)]
	public virtual Future<A> map<A> (owned MapFunc<A, G> func) {
		Promise<A> promise = new Promise<A> ();
		wait_async.begin ((obj, res) => {
			try {
				promise.set_value (func (wait_async.end (res)));
			} catch (Error ex) {
				promise.set_exception ((owned)ex);
			}
		});
		return promise.future;
	}

	public delegate unowned A LightMapFunc<A, G> (G value);

	/**
	 * Maps a future value to another value by a function and returns the
	 * another value in future.
	 *
	 * Note: The function may be reevaluated at any time and it might
	 *   be called lazily. Therefore it is recommended for it to be
	 *   idempotent. If the function needs to be called eagerly or have
	 *   side-effects it is recommended to use {@link map}.
	 *
	 * Note: As time taken by function does not contribute to
	 *   {@link wait_until} and the implementation is allowed to compute
	 *   value eagerly by {@link wait_async} it is recommended to use
	 *   {@link task} and {@link flat_map} for longer computation.
	 *
	 * @param func Function applied to {@link value}
	 * @return Value returned by function
	 *
	 * @see flat_map
	 * @see map
	 */
	[CCode (ordering = 10, cname = "gee_future_light_map_fixed", vfunc_name = "light_map_fixed")]
	public virtual Future<A> light_map<A> (owned LightMapFunc<A, G> func) {
		return new LightMapFuture<A, G> (this, func);
	}

	[CCode (ordering = 4, cname = "gee_future_light_map", vfunc_name = "light_map")]
	public virtual Future<A> light_map_broken<A> (LightMapFunc<A, G> func) {
		return light_map<A> (func);
	}

	[CCode (scope = "async")]
	public delegate C ZipFunc<A, B, C>(A a, B b);

	/**
	 * Combines values of two futures using a function returning the combined
	 * value in future (call does not block).
	 *
	 * Note: As time taken by function does not contribute to
	 *   {@link wait_until} and the implementation is allowed to compute
	 *   value eagerly by {@link wait_async} it is recommended to return a
	 *   future from {@link task} and use {@link flat_map} for longer computation.
	 *
	 * @param zip_func Function applied to values
	 * @param second Second parameter
	 * @return A combine value
	 */
	[CCode (ordering = 5)]
	public virtual Future<B> zip<A, B> (owned ZipFunc<G, A, B> zip_func, Future<A> second) {
		Promise<B> promise = new Promise<B> ();
		do_zip.begin<G, A, B> ((owned) zip_func, this, second, promise, (obj, res) => {do_zip.end<G, A, B> (res);});
		return promise.future;
	}

	private static async void do_zip<A, B, C> (owned ZipFunc<A, B, C> zip_func, Future<A> first, Future<B> second, Promise<C> result) {
		try {
			A left = yield first.wait_async ();
			B right = yield second.wait_async ();
			result.set_value (zip_func (left, right));
		} catch (Error ex) {
			result.set_exception ((owned)ex);
		}
	}

	public delegate Vala.Future<A> FlatMapFunc<A, G>(G value);

	/**
	 * Maps a future value to another future value which is returned (call does not block).
	 *
	 * Note: As time taken by function does not contribute to
	 *   {@link wait_until} and the implementation is allowed to compute
	 *   value eagerly by {@link wait_async} it is recommended to put the
	 *   larger computation inside the returned future for example by
	 *   {@link task}
	 *
	 * @param func Function applied to {@link value}
	 * @return Value of a future returned by function
	 *
	 * @see map
	 */
	[CCode (ordering = 6)]
	public virtual Vala.Future<A> flat_map<A>(owned FlatMapFunc<A, G> func) {
		Promise<A> promise = new Promise<A> ();
		do_flat_map.begin<G, A> ((owned)func, this, promise, (obj, res) => {do_flat_map.end<G, A> (res);});
		return promise.future;
	}

	private static async void do_flat_map<A, B> (owned FlatMapFunc<B, A> func, Future<A> future, Promise<B> promise) {
		try {
			A input = yield future.wait_async ();
			B output = yield func (input).wait_async ();
			promise.set_value ((owned)output);
		} catch (Error ex) {
			promise.set_exception ((owned)ex);
		}
	}

	internal struct SourceFuncArrayElement {
		public SourceFuncArrayElement (owned SourceFunc func) {
			this.func = (owned)func;
		}
		public SourceFunc func;
	}
}

public errordomain Vala.FutureError {
	/**
	 * The promise have been abandon - this indicates an error in program.
	 */
	ABANDON_PROMISE,
	/**
	 * Exception field has been set.
	 */
	EXCEPTION
}
