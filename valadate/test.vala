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

/**
 * The Test interface is implemented by TestCase and TestSuite.
 * It is the base interface for all runnable Tests.
 */
public abstract class Valadate.Test {
	/**
	 * Runs the Tests and collects the results in a TestResult
	 *
	 * @param result the TestResult object used to store the results of the Test
	 */
	public abstract void run (TestResult result);
	/**
	 * The name of the test
	 */
	public string name { get; set; }
	/**
	 * The label of the test
	 */
	public string label { get; set; }
	/**
	 * Returns the number of tests that will be run by this test
	 * TestSuites should return the total number of tests that will
	 * be run.
	 */
	public abstract int count { get; }
	/**
	 * This is used for the iterator and does not return the number of
	 * tests that will be run
	 */
	public abstract int size { get; }
	/**
	 * The #TestStatus of the test
	 */
	public TestStatus status { get; set; default = TestStatus.NOT_RUN; }

	public double time { get; set; }

	public Test? parent { get; set; }

	public abstract Test get (int index);

	public abstract void set (int index, Test test);
}
