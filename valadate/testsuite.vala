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

	/**
	 * The TestMethod delegate represents a {@link Valadate.Test} method
	 * that can be added to a TestCase and run
	 */
	public delegate void TestMethod ();


	private HashTable<string, Test> _tests =
		new HashTable<string, Test> (str_hash, str_equal);
	
	private List<weak Test> _values;
	
	/**
	 * the name of the TestSuite
	 */
	public string name { get; set; }

	/**
	 * Returns the number of {@link Valadate.Test}s that will be run by 
	 * this TestSuite
	 */
	public int count {
		get {
			return (int)_tests.size();
		}
	}

	/**
	 * Returns a {@link GLib.List} of {@link Valadate.Test}s that will be
	 * run by this TestSuite
	 */
	public List<weak Test> tests {
		get {
			_values = _tests.get_values();
			return _values;
		}
	}

	/**
	 * The public constructor takes an optional string parameter for the
	 * TestSuite's name
	 */
	public TestSuite(string? name = null) {
		this.name = name;
	}

	/**
	 * Adds a test to the suite.
	 */
	public void add_test(string name, Test test) {
		_tests.set(name, test);
	}

	public void add_test_method(string name, owned TestMethod test) {
		var adaptor = new TestAdaptor ((owned)test);
		_tests.set(name, adaptor);
	}


	public void run(TestResult result) {
		_tests.foreach((k,t) => { run_test(t, result); });
	}

	public void run_test(Test test, TestResult result) {
		result.run(test);
	}
	
	public new unowned Test? get(string name) {
		return _tests.lookup(name);
	}

	public new void set(string name, Test test) {
		_tests.set(name, test);
	}
	
	private class TestAdaptor : Object, Test {

		private TestSuite.TestMethod test;

		public int count {
			get {
				return 1;
			}
		}
		
		public TestAdaptor(owned TestSuite.TestMethod test) {
			this.test = (owned)test;
		}

		public void run(TestResult test) {
			this.test();
		}

	}
	
	
}
