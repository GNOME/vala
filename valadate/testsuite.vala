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

public class Valadate.TestSuite : Object, Test {

	private List<Test> _tests = new List<Test> ();
	/**
	 * the name of the TestSuite
	 */
	public string name { get; set; }
	/**
	 * the label of the TestSuite
	 */
	public string label { get; set; }
	/**
	 * Iterator (not the actual number of Tests that will be run)
	 */
	public int size {
		get {
			return (int)_tests.length ();
		}
	}
	/**
	 * Returns the number of {@link Valadate.Test}s that will be run by
	 * this TestSuite
	 */
	public int count {
		get {
			int testcount = 0;
			_tests.foreach ((t) => {
				testcount += t.count;
			});
			return testcount;
		}
	}
	public Test? parent { get; set; }
	/**
	 * Returns a {@link GLib.List} of {@link Valadate.Test}s that will be
	 * run by this TestSuite
	 */
	public List<Test> tests {
		get {
			return _tests;
		}
	}

	public TestStatus status { get; set; default=TestStatus.NOT_RUN;}
	public double time { get; set; }
	public int skipped { get; set; }
	public int errors { get; set; }
	public int failures { get; set; }
	/**
	 * The public constructor takes an optional string parameter for the
	 * TestSuite's name
	 */
	public TestSuite (string? name = null) {
		this.name = name ?? this.get_type ().name ();
		this.label = name;
	}
	/**
	 * Adds a test to the suite.
	 */
	public void add_test (Test test) {
		test.parent = this;
		_tests.append (test);
	}
	/**
	 * Runs all of the tests in the Suite
	 */
	public void run (TestResult result) {

		if (status != TestStatus.NOT_RUN)
			return;

		_tests.foreach ((t) => {
			t.run (result);
		});
	}

	public new Test get (int index) {
		return _tests.nth_data ((uint)index);
	}

	public new void set (int index, Test test) {
		test.parent = this;
		_tests.insert_before (_tests.nth (index), test);
		var t = _tests.nth_data ((uint)index++);
		_tests.remove (t);
	}

	public virtual void set_up () {}
	public virtual void tear_down () {}
}
