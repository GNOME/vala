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

	private HashTable<string, Test> tests =
		new HashTable<string, Test> (str_hash, str_equal);
	
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
			return (int)tests.size();
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
		tests.set(name, test);
	}


	public void run(TestResult result) {
		tests.foreach((k,t) => { run_test(t, result); });
	}

	public void run_test(Test test, TestResult result) {
		result.run(test);
	}


	
}
