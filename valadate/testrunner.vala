/*
 * Valadate - Unit testing library for GObject-based libraries.
 * Copyright (C) 2016  Chris Daley <chebizarro@gmail.com>
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
 * Authors:
 * 	Chris Daley <chebizarro@gmail.com>
 */

public class Valadate.TestRunner {

	private class DelegateWrapper {
		public SourceFunc cb;
	}

	private uint _n_ongoing_tests = 0;
	private Queue<DelegateWrapper> _pending_tests = new Queue<DelegateWrapper> ();
	private static uint _max_n_ongoing_tests = GLib.get_num_processors ();
	private MainLoop loop;
	private TestPlan plan;

	public void run (Test test, TestResult result) {
		result.add_test (test);
		test.run (result);
		result.report ();
	}

	public int run_all (TestPlan plan) throws Error {
		this.plan = plan;

		if (plan.config.list_only) {
			list_tests (plan.root, "");
			return 0;
		} else if (plan.root.count == 0) {
			return 0;
		} else if (!plan.config.in_subprocess) {
			loop = new MainLoop ();
			Timeout.add (
				10,
				 () => {
					bool res = plan.result.report ();
					if (!res)
						loop.quit ();
					return res;

				},
				Priority.HIGH_IDLE);
			run_test_internal (plan.root, plan.result, "");
			loop.run ();
		} else {
			run_test_internal (plan.root, plan.result, "");
		}
		return 0;
	}

	private void list_tests (Test test, string path) {
		foreach (var subtest in test) {
			string testpath = "%s/%s".printf (path, subtest.name);
			if (subtest is TestAdapter)
				stdout.printf ("%s\n", testpath);
			else
				list_tests (subtest, testpath);
		}
	}

	public void run_test (Test test, TestResult result) {
		test.run (result);
	}

	private void run_test_internal (Test test, TestResult result, string path) throws Error {

		foreach (var subtest in test) {

			var testpath = "%s/%s".printf (path, subtest.name);

			if (subtest is TestCase) {
				if (!plan.config.in_subprocess)
					result.add_test (subtest);
				run_test_internal (subtest, result, testpath);
			} else if (subtest is TestSuite) {
				result.add_test (subtest);
				run_test_internal (subtest, result, testpath);
			} else if (plan.config.in_subprocess) {
				if (plan.config.running_test == testpath)
					test.run (result);
			} else if (subtest is TestAdapter) {
				subtest.name = testpath;
				result.add_test (subtest);
				run_async.begin (subtest, result);
			}
		}
	}

	private async void run_async (Test test, TestResult result) throws Error {

		var timeout = plan.config.timeout;
		var testprog = plan.assembly.clone ();
		if (_n_ongoing_tests > _max_n_ongoing_tests) {
			var wrapper = new DelegateWrapper ();
			wrapper.cb = run_async.callback;
			_pending_tests.push_tail ((owned)wrapper);
			yield;
		}

		try {
			_n_ongoing_tests++;
			var cancellable = new Cancellable ();
			var tcase = test as TestAdapter;
			if (timeout != tcase.timeout)
				timeout = tcase.timeout;

			var time = new TimeoutSource (timeout);

			cancellable.cancelled.connect (() => {
				testprog.quit ();
			});

			time.set_callback (() => {
				if (tcase.status == TestStatus.RUNNING)
					cancellable.cancel ();
				return false;
			});
			time.attach (loop.get_context ());

			testprog.run ("-r %s".printf (test.name), cancellable);
			result.add_success (test);
			result.process_buffers (test, testprog);
		} catch (IOError e) {
			result.add_error (test, "The test timed out after %d milliseconds".printf (timeout));
			result.process_buffers (test, testprog);
		} catch (Error e) {
			result.add_error (test, e.message);
			result.process_buffers (test, testprog);
		} finally {
			result.report ();
			_n_ongoing_tests--;
			var wrapper = _pending_tests.pop_head ();
			if (wrapper != null)
				wrapper.cb ();
		}
	}

	public static int main (string[] args) {
		try {
			var assembly = new TestAssembly (args);
			var testplan = new TestPlan (assembly);
			return testplan.run ();
		} catch (Error e) {
			error (e.message);
		}
	}

}
