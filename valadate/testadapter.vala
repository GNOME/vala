/*
 * Valadate - Unit testing library for GObject-based libraries.
 * Copyright (C) 2017  Chris Daley <chebizarro@gmail.com>
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

public class Valadate.TestAdapter : Test {

	public int timeout { get; set; }

	public string status_message { get; set; }

	public override int count {
		get {
			return 1;
		}
	}

	public override int size {
		get {
			return count;
		}
	}

	public TestCase.TestMethod test;

	public override Test get (int index) {
		return this;
	}

	public override void set (int index, Test test) {
		
	}

	public TestAdapter (string name, int timeout) {
		this.name = name;
		this.timeout = timeout;
	}

	public void add_test (owned TestPlan.TestMethod testmethod) {
		this.test = () => {
			testmethod (parent as TestCase);
		};
	}

	public void add_async_test (
		TestPlan.AsyncTestMethod async_begin,
		TestPlan.AsyncTestMethodResult async_finish)
	{
		var p = parent as TestCase;
		this.test = () => {
			AsyncResult? result = null;
			var loop = new MainLoop ();
			var thread = new Thread<void*>.try (name, () => {
				async_begin (p, (o, r) => { result = r; loop.quit ();});
				return null;
			});
			Timeout.add (timeout, () => {
				loop.quit ();
				return false;
			},
			Priority.HIGH);
			loop.run ();
			if (result == null)
				throw new IOError.TIMED_OUT ("The test timed out after %d milliseconds",timeout);
			async_finish (p, result);
		};
	}

	public void add_test_method (owned TestCase.TestMethod testmethod) {
		this.test = (owned)testmethod;
	}

	public override void run (TestResult result) {
		if (status == TestStatus.SKIPPED)
			return;
		var p = parent as TestCase;
		result.add_test (this);
		p.set_up ();
		try {
			test ();
		} catch (Error e) {
			result.add_failure (this, e.message);
		}
		p.tear_down ();
		result.add_success (this);
	}
}
