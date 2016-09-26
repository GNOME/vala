/* 
 * Valadate - Unit testing library for GObject-based libraries.
 *
 * testcase.vala
 * Copyright (C) 2016 Chris Daley
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

public errordomain Valadate.TestError {
	NOT_FOUND
}

/**
 * The TestMethod delegate represents a {@link Valadate.Test} method
 * that can be added to a TestCase and run
 */
public delegate void Valadate.TestMethod ();

public abstract class Valadate.TestCase : Object, Test, TestFixture {

	/**
	 * the name of the TestCase
	 */
	public string name { get; set; }

	/**
	 * Returns the number of {@link Valadate.Test}s that will be run by this TestCase
	 */
	public int count {
		get {
			int testcount = 0;
			tests.foreach ((t) => {
				testcount += t.count;
			});
			return testcount;
		}
	}

	public string bug_base { get; set; }

	private List<Test> tests = new List<Test>();

	/**
	 * The public constructor takes an optional string parameter for the
	 * TestCase's name
	 */
	public TestCase (string? name = null) {
		Object (name : name);
	}

	construct {
		if (name == null)
			name = get_type ().name ();
	}

	public void add_test (string testname, owned TestMethod test) {
		var adaptor = new TestAdaptor (testname, (owned) test, this);
		tests.append (adaptor);
	}

	public Test get_test (int index) {
		return tests.nth_data (index);
	}

	public void bug (string reference)
		requires (bug_base != null)
	{
		stdout.printf ("MSG Bug Reference: %s%s", bug_base, reference);
		stdout.flush ();
	}

	public void skip (string message) {
		stderr.printf ("SKIP %s", message);
		stdout.flush ();
	}

	public void fail (string? message = null) {
		error ("FAIL %s", message ?? "");
	}

	public virtual void run (TestResult result) {
	}

	public virtual void set_up() {
	}

	public virtual void tear_down() {
	}
}

private class Valadate.TestAdaptor : Object, Test {

	public string name { get; set; }

	public int count {
		get {
			return 1;
		}
	}

	private TestMethod test;
	private unowned TestCase testcase;

	public TestAdaptor (string name, owned TestMethod test, TestCase testcase) {
		this.test = (owned) test;
		this.name = name;
		this.testcase = testcase;
	}

	public Test get_test (int index) {
		return this;
	}

	public void run (TestResult result) {
		this.testcase.set_up ();
		this.test ();
		this.testcase.tear_down ();
	}
}
