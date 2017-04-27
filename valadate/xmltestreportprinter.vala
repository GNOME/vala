/*
 * Valadate - Unit testing library for GObject-based libraries.
 * Copyright (C) 2017 Chris Daley <chebizarro@gmail.com>
 * 
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 * 
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 * 
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
 * MA 02110-1301, USA.
 * 
 * 
 */

public class Valadate.XmlTestReportPrinter : TestReportPrinter {
	
	private const string XML_DECL ="<?xml version=\"1.0\" encoding=\"UTF-8\"?>";
	private const string TESTSUITES_XML =
		"""<testsuites disabled="" errors="" failures="" name="" """ +
		"""tests="" time=""></testsuites>""";
	
	public XmlFile xml {get;set;}

	private Xml.Node* testsuite;
	private Xml.Node* oldtestsuite;
	private int testcount = -1;
	private int casecount = -1;

	public XmlTestReportPrinter(TestConfig config) throws Error {
		base(config);
		this.config = config;
		xml = new XmlFile.from_string(XML_DECL + TESTSUITES_XML);
	}

	public override void print(TestReport report) {
		Xml.Node* root = xml.eval("//testsuites")[0];
		Xml.Node* node = report.xml.eval("//testsuite | //testcase")[0];

		if(report.test is TestSuite) {
			if(testsuite == null) {
				testcount = report.test.count;
				testsuite = root->add_child(node->copy_list());
			} else {
				oldtestsuite = testsuite;
				testsuite = testsuite->add_child(node->copy_list());
			}
		} else if (report.test is TestCase) {
			oldtestsuite = testsuite;
			testsuite = testsuite->add_child(node->copy_list());
			casecount = report.test.count;
		} else if(report.test is TestAdapter) {
			testsuite->add_child(node->copy_list());
			testcount--;
			casecount--;
			if(casecount == 0)
				testsuite = oldtestsuite;
		}		
		if(testcount == 0)
			root->doc->dump_format(stdout);
	}
}
