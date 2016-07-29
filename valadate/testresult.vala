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

	private enum TestStatus {
		NOT_RUN,
		RUNNING,
		PASSED,
		SKIPPED,
		ERROR,
		FAILED
	}
	
	private class TestReport {

		public signal void report(TestStatus status);
		
		public Test test {get;set;}
		
		public TestStatus status {get;set;}
		
		public int index {get;set;}
		
		public string message {get;set;}
		
		public TestReport(Test test, TestStatus status, int index, string? message = null) {
			this.test = test;
			this.status = status;
			this.index = index;
			this.message = message;
		}
	}

	private Queue<TestReport> reports = new Queue<TestReport>();
	private HashTable<Test, TestReport> tests = new HashTable<Test, TestReport>(direct_hash, direct_equal);
	
	public string binary {
		get {
			return config.binary;
		}
	}
	
	private TestConfig config;
	private TestRunner runner;
	private MainLoop loop;

	public TestResult(TestConfig config) {
		this.config = config;
	}
	
	public void report() {
		if (reports.is_empty()) {
			loop.quit();
			return;
		}
		var rpt = reports.peek_head();

		if (rpt.status == TestStatus.PASSED ||
			rpt.status == TestStatus.SKIPPED ||
			rpt.status == TestStatus.FAILED ||
			rpt.status == TestStatus.ERROR) {
			if (rpt.message != null)
				stdout.puts(rpt.message);
			stdout.flush();
			rpt.report(rpt.status);
			reports.pop_head();
			report();
		}
	}
	
	public void add_error(Test test, string error) {
		update_test(test, TestStatus.ERROR,"# %s\nnot ok %s %s\n".printf(error, "%d", test.name));
	}

	public void add_failure(Test test, string failure) {
		update_test(test, TestStatus.FAILED,"# %s\nnot ok %s %s\n".printf(failure, "%d", test.name));
	}

	public void add_success(Test test, string message) {
		update_test(test, TestStatus.PASSED,"# %s\nok %s %s\n".printf(message, "%d", test.name));
	}
	
	public void add_skip(Test test, string reason, string message) {
		update_test(test, TestStatus.SKIPPED,"# %s\nok %s %s # %s\n".printf(message, "%d", test.name, reason));
	}

	private void update_test(Test test, TestStatus status, string message) {
		var rept = tests.get(test);
		rept.status = status;
		rept.message = message.printf(rept.index);
	}
	
	/**
	 * Runs a the {@link Valadate.Test}s using the supplied
	 * {@link Valadate.TestRunner}.
	 * 
	 * @param runner
	 */
	public void run(TestRunner runner) {

		this.runner = runner;

		if (!config.list_only && config.runtest == null) {
			stdout.printf("# random seed: %s\n", config.seed);
			stdout.printf("1..%d\n", config.test_count);
		}

		run_test(config.root, "");

		if (config.runtest == null) {
			loop = new MainLoop();
			var time = new TimeoutSource (5);
			time.set_callback (() => {
				report();
				return true;
			});
			time.attach (loop.get_context ());
			loop.run();
		}
	}

	private int testno = 0;

	private void run_test(Test test, string path) {
		foreach(var subtest in test) {
			string testpath = "%s/%s".printf(path, subtest.name);
			if(subtest is TestCase) {
				if(config.runtest == null) {
					reports.push_tail(new TestReport(subtest, TestStatus.PASSED,-1,"# Start of %s tests\n".printf(testpath)));
					run_test(subtest, testpath);
					reports.push_tail(new TestReport(subtest, TestStatus.PASSED,-1,"# End of %s tests\n".printf(testpath)));
				} else {
					run_test(subtest, testpath);
				}
			} else if (subtest is TestSuite) {
				run_test(subtest, testpath);
				if(config.runtest == null) {
					var rpt = new TestReport(subtest, TestStatus.PASSED,-1);
					rpt.report.connect((s)=> ((TestSuite)subtest).tear_down());
					reports.push_tail(rpt);
				}
			} else if (config.list_only) {
				stdout.printf("%s\n", testpath);
			} else if (config.runtest != null) {
				if(config.runtest == testpath)
					runner.run_test(subtest, this);
			} else {
				testno++;
				subtest.name = testpath;
				var rept = new TestReport(subtest, TestStatus.RUNNING, testno);
				reports.push_tail(rept);
				tests.insert(subtest, rept);
				runner.run.begin(subtest, this);
			}
		}
	}


}
