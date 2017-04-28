/* 
 * Valadate - Unit testing library for GObject-based libraries.
 *
 * testcase.vala
 * Copyright (C) 2016-2017 Chris Daley
 * Copyright (C) 2009-2012 Julien Peeters
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
 * 	Julien Peeters <contact@julienpeeters.fr>
 */

public abstract class Valadate.TestCase : Object, Test {
	/**
	 * The TestMethod delegate represents a {@link Valadate.Test} method
	 * that can be added to a TestCase and run
	 */
	public delegate void TestMethod () throws Error;
	/**
	 * the name of the TestCase
	 */
	public string name { get; set; }
	/**
	 * the label of the TestCase
	 */
	public string label { get; set; }
	/**
	 * Returns the number of {@link Valadate.Test}s that will be run by this TestCase
	 */
	public int count {
		get {
			int testcount = 0;
			_tests.foreach((t) => {
				testcount += t.count;
			});
			return testcount;
		}
	}

	public int size {
		get {
			int testcount = 0;
			_tests.foreach((t) => {
				testcount += t.count;
			});
			return testcount;
		}
	}

	public Test? parent {get;set;}

	public TestStatus status {get;set;default=TestStatus.NOT_RUN;}
	public string status_message {get;set;}
	public double time {get;set;}

	public string bug_base {get;set;}
	
	private List<Test> _tests = new List<Test>();

	private Test current_test;
	private TestResult current_result;

	public new Test get(int index) {
		return _tests.nth_data((uint)index);
	}

	public new void set(int index, Test test) {
		test.parent = this;
		_tests.insert_before(_tests.nth(index), test);
		var t = _tests.nth_data((uint)index++);
		_tests.remove(t);
	}

	public void add_test(Test test) {
		test.parent = this;
		_tests.append(test);
	}

	public void add_test_method(string testname, owned TestMethod test, int timeout, string? label = null) {
		var adapter = new TestAdapter (testname, timeout);
		adapter.add_test_method((owned)test);
		adapter.label = label;
		adapter.parent = this;
		_tests.append(adapter);
	}
	
	public virtual void run(TestResult result) {
		if(status != TestStatus.NOT_RUN)
			return;
		current_result = result;
		_tests.foreach((t) => {
			current_test = t;
			t.run(result);
		});
	}

	public void bug(string reference)
		requires(bug_base != null)
	{
		info("Bug Reference: %s%s",bug_base, reference);
	}

	public void skip(string message) {
		current_result.add_skip(current_test, message);
	}

	public void fail(string? message = null) {
		current_result.add_failure(current_test, message);
	}

	public virtual void set_up() {}

	public virtual void tear_down() {}
}
