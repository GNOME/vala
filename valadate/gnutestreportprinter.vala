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
public class Valadate.GnuTestReportPrinter : TestReportPrinter {
	
	private const string TAP_VERSION = "13";
	
	private List<TestCase> testcases = new List<TestCase>();
	
	public GnuTestReportPrinter(TestConfig config) throws Error {
		base(config);
	}
	
	public override void print(TestReport report) {

		if(report.test is TestSuite) {
			testcases = new List<TestCase>();
		} else if(report.test is TestCase) {
			testcases.append(report.test as TestCase);
		} else if(report.test is TestAdapter) {
			var test = report.test as TestAdapter;
			var idx = testcases.index(test.parent as TestCase);
			int index = 1;
			
			if(idx > 0)
				for(int i=0; i<idx;i++)
					index += testcases.nth_data(i).count;
			
			for(int i=0;i<test.parent.count; i++) {
				if(test.parent[i] == test) {
					index += i;
				}
			}

			switch(report.test.status) {
				case TestStatus.PASSED:
					stdout.printf("PASS: %s %d - %s\n", test.parent.name, index, test.name);
					break;
				case TestStatus.SKIPPED:
					stdout.printf("SKIP: %s %d - %s # SKIP %s \n",
						test.parent.name, index, test.label, test.status_message ?? "");
					break;
				case TestStatus.TODO:
					var errs = report.xml.eval("//failure | //error");
					if(errs.size > 0)
						stdout.printf("XFAIL: %s %d - %s # TODO %s \n",
							test.parent.name, index, test.label, test.status_message ?? "");
					else
						stdout.printf("PASS: %s %d - %s # TODO %s \n",
							test.parent.name, index, test.label, test.status_message ?? "");
					break;
				case TestStatus.FAILED:
				case TestStatus.ERROR:
					stdout.printf("FAIL: %s %d - %s\n", test.parent.name, index, test.label);
					break;
				default:
					break;
			}
		}
	}
}
