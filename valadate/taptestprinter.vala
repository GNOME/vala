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
 
public class Valadate.TapTestReportPrinter : TestReportPrinter {
	
	private const string TAP_VERSION = "13";
	
	private List<TestCase> testcases = new List<TestCase>();
	
	public TapTestReportPrinter(TestConfig config) throws Error {
		base(config);
		if(!config.list_only) {
			stdout.printf("TAP version %s\n", TAP_VERSION);
			stdout.printf("# random seed: %s\n", config.seed);
		}
	}
	
	public override void print(TestReport report) {

		if(report.test is TestSuite && report.test.parent.name == "/") {
			stdout.printf("1..%d\n", report.test.count);
			
			var props = report.xml.eval("//properties/property");
			stdout.puts("# Environment\n");
			foreach(Xml.Node* prop in props) {
				stdout.printf("# %s : %s\n",
					prop->get_prop("name"), prop->get_prop("value"));
			}

		} else if(report.test is TestCase) {
			testcases.append(report.test as TestCase);
			stdout.printf("# Start of %s tests\n", report.test.label);

		} else if(report.test is TestAdapter) {
			var test = report.test as TestAdapter;
			var idx = testcases.index(test.parent as TestCase);
			int index = 1;
			bool lasttest = false;
			
			if(idx > 0)
				for(int i=0; i<idx;i++)
					index += testcases.nth_data(i).count;
			
			for(int i=0;i<test.parent.count; i++) {
				if(test.parent[i] == test) {
					index += i;
					lasttest = (i == test.parent.count-1);
				}
			}

			switch(report.test.status) {
				case TestStatus.PASSED:
					stdout.printf("ok %d - %s\n", index, test.label);
					break;
				case TestStatus.SKIPPED:
					stdout.printf("ok %d - %s # SKIP %s \n", index, test.label, test.status_message ?? "Skipping");
					break;
				case TestStatus.TODO:
					var errs = report.xml.eval("//failure | //error");
					if(errs.size > 0)
						stdout.printf("not ok %d - %s # TODO %s \n", index, test.label, test.status_message ?? "Todo");
					else
						stdout.printf("ok %d - %s # TODO %s \n", index, test.label, test.status_message ?? "Todo");
					break;
				case TestStatus.FAILED:
				case TestStatus.ERROR:
					stdout.printf("not ok %d - %s\n", index, test.label);
					break;
				default:
					stdout.printf("Bail out! %s\n", "There was an unexpected error");
					break;
			}
			stdout.puts("  ---\n");
			stdout.printf("  duration_ms: %.4f\n", test.time);
			var messages = report.xml.eval("//failure | //error | //info");
			foreach(Xml.Node* mess in messages) {
				stdout.printf("  message: >\n    %s\n", mess->get_prop("message"));
				stdout.printf("  severity: %s\n", mess->name);
			}
			stdout.puts("  ...\n");
			messages = report.xml.eval("//system-out | //system-err");
			foreach(Xml.Node* mess in messages)
				stdout.printf("# %s\n", string.joinv("\n# ", mess->get_content().split("\n")));
			if(lasttest)
				stdout.printf("# End of %s tests\n", test.parent.label);
			stdout.flush();
		}
	}
}
