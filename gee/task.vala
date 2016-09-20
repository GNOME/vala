/* task.vala
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
namespace Vala {
	[CCode (scope = "async")]
	public delegate G Task<G>();

	/**
	 * Schedules a task to execute asynchroniously. Internally one
	 * of threads from pool will execute the task.
	 *
	 * Note: There is limited number of threads unless environment variable
	 *   ``GEE_NUM_THREADS`` is set to -1. It is not adviced to call I/O or
	 *   block inside the taks. If necessary it is possible to create a new one
	 *   by anyther call.
	 *
	 * @param task Task to be executed
	 * @return Future value returned by task
	 * @see async_task
	 */
	public Future<G> task<G>(owned Task<G> task) throws GLib.ThreadError {
		TaskData<G> tdata = new TaskData<G>();
		tdata.function = (owned)task;
		tdata.promise = new Promise<G>();
		Future<G> result = tdata.promise.future;
		TaskData.get_async_pool ().add ((owned)tdata);
		return result;
	}

	/**
	 * Continues the execution asynchroniously in helper thread. Internally
	 * one of threads from pool will execute the task.
	 *
	 * Note: There is limited number of threads unless environment variable
	 *   ``GEE_NUM_THREADS`` is set to -1. It is not adviced to call I/O or
	 *   block inside the taks. If necessary it is possible to create a new one
	 *   by anyther call.
	 *
	 * @see task
	 */
	public async void async_task() throws GLib.ThreadError {
		task<bool>(async_task.callback);
	}

	[CCode (cheader_filename = "sys/sysinfo.h", cname = "get_nprocs")]
	private extern static int get_nprocs ();

	[Compact]
	internal class TaskData<G> {
		public Task<G> function;
		public Promise<G> promise;
		public void run() {
			promise.set_value(function());
		}
		private static GLib.Once<ThreadPool<TaskData>> async_pool;
		internal static unowned ThreadPool<TaskData> get_async_pool () {
			return async_pool.once(() => {
				int num_threads = get_nprocs ();
				string? gee_num_threads_str = Environment.get_variable("GEE_NUM_THREADS");
				if (gee_num_threads_str != null) {
					int64 result;
					if (int64.try_parse (gee_num_threads_str, out result)) {
						num_threads = (int)result;
					}
				}
				try {
					return new ThreadPool<TaskData>.with_owned_data((tdata) => {
						tdata.run();
					}, num_threads, false);
				} catch (ThreadError err) {
					Process.abort ();
				}
			});
		}
	}
}

