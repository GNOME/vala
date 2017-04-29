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

public class Valadate.TestResult {

	public TestConfig config { get; set; }
	public TestReportPrinter printer { get; set; }

	private Queue<TestReport> reports = new Queue<TestReport> ();
	private HashTable<Test, TestReport> tests = new HashTable<Test, TestReport> (direct_hash, direct_equal);

	public TestResult (TestConfig config) throws Error {
		this.config = config;
		if (!config.in_subprocess)
			printer = TestReportPrinter.from_config (config);
	}

	public bool report () {
		if (reports.is_empty ())
			return false;

		var rpt = reports.peek_head ();

		if (rpt.test.status == TestStatus.PASSED ||
			rpt.test.status == TestStatus.SKIPPED ||
			rpt.test.status == TestStatus.TODO ||
			rpt.test.status == TestStatus.FAILED ||
			rpt.test.status == TestStatus.ERROR) {

			printer.print (rpt);
			reports.pop_head ();
			report ();
		}
		return true;
	}

	private void update_status (Test test) {
		var rept = tests.get (test);
		if (rept == null)
			return;

		var parent = test.parent;
		if (parent == null)
			return;

		TestStatus status = TestStatus.PASSED;
		foreach (var t in parent) {
			if (t.status == TestStatus.RUNNING)
				return;
			else if (t.status == TestStatus.ERROR)
				status = TestStatus.ERROR;
			else if (t.status == TestStatus.FAILED)
				status = TestStatus.FAILED;
		}
		parent.status = status;
		update_status (parent);
	}

	public void add_test (Test test) {
		try {
			reports.push_tail (new TestReport (test, config.in_subprocess));
			tests.insert (test, reports.peek_tail ());
		} catch (Error e) {
			error (e.message);
		}
	}

	public void add_error (Test test, string error) {
		tests.get (test).add_error (error);
		update_status (test);
	}

	public void add_failure (Test test, string failure) {
		tests.get (test).add_failure (failure);
		update_status (test);
	}

	public void add_success (Test test) {
		tests.get (test).add_success ();
		update_status (test);
	}

	public void add_skip (Test test, string message) {
		tests.get (test).add_skip (message);
		update_status (test);
	}

	public void process_buffers (Test test, Assembly assembly) throws Error {

		var rept = tests.get (test);
		if (rept == null)
			return;

		var bis = new BufferedInputStream (assembly.stderr);
		bis.fill (-1);
		var xml = (string)bis.peek_buffer ();
		if (xml.length < 8)
			return;

		rept.process_buffer (xml);

		update_status (test);

		uint8 outbuffer[4096] = {};
		assembly.stdout.read_all (outbuffer, null);
		xml = ((string)outbuffer).strip ();
		int i;
		for (i=xml.length-1;i==0;i--)
			if (xml.get_char (i).isgraph ())
				break;

		xml = xml.substring (0, i+1);
		if (xml.length < 1 || xml == "\n")
			return;
		rept.add_stdout (xml);
	}
}
