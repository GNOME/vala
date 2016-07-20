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
public class Valadate.TestResult : Object {

	public signal void test_error(Test test, string error);
	public signal void test_failure(Test test, string error);
	public signal void test_complete(Test test);
	public signal void test_start(Test test);
	
	internal List<TestFailure> errors = new List<TestFailure>();
	internal List<TestFailure> failures = new List<TestFailure>();

	public bool should_stop {get;set;default=false;}
	
	public int error_count {
		get {
			return (int)errors.length();
		}
	}

	public int failure_count {
		get {
			return (int)failures.length();
		}
	}

	public int run_count {get;private set;default=0;}
	
	public bool success {
		get {
			return (failure_count == 0 && error_count == 0);
		}
	}
	
	public void add_error(Test test, string error) {
		errors.append(new TestFailure(test, error));
		test_error(test, error);
	}

	public void add_failure(Test test, string failure) {
		failures.append(new TestFailure(test, failure));
		test_failure(test, failure);
	}

	public void start_test(Test test) {
		run_count += test.count;
		test_start(test);
	}
	
	/**
	 * Runs a {@link Valadate.Test}
	 */
	public void run(Test test) {

		test_start(test);

		test.run(this);

		test_complete(test);
	}
}
