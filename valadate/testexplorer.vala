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
 
internal class Valadate.TestExplorer : Vala.CodeVisitor {

	private TestConfig config;
	private Vala.Class testcase;
	private Vala.Class testsuite;

	private TestSuite current;

	internal delegate void* Constructor(string? name = null); 
	internal delegate void TestMethod(TestCase self);
	
	public TestExplorer(TestConfig config) {

		this.config = config;
		this.current = config.root;
	}
	
	public override void visit_class(Vala.Class class) {
		
		if (class.get_full_name() == "Valadate.TestCase") {
			testcase = class;
			return;
		}

		if (class.get_full_name() == "Valadate.TestSuite") {
			testsuite = class;
			return;
		}

		try {

			if (testcase != null &&
				class.is_subtype_of(testcase) &&
				class.is_abstract != true )
				current.add_test(visit_testcase(class));
			else if (testsuite != null &&
				class.is_subtype_of(testsuite) &&
				class.is_abstract != true )
				current.add_test(visit_testsuite(class));

		} catch (ModuleError e) {
			stderr.puts(e.message);
		}

		class.accept_children(this);

	}

	public TestCase visit_testcase(Vala.Class testclass) throws ModuleError {
		string cname = Vala.Symbol.camel_case_to_lower_case(
			testclass.default_construction_method.get_full_name().replace(".","_"));

		string tname = Vala.Symbol.camel_case_to_lower_case(
			testclass.get_full_name().replace(".","/"));

		unowned Constructor meth = (Constructor)config.module.get_method(cname);
		var current_test = meth("%s%s/".printf(config.root.name, tname)) as TestCase;
		
		foreach(var method in testclass.get_methods()) {
			if( method.name.has_prefix("test_") &&
				method.has_result != true &&
				method.get_parameters().size == 0
			) {
				unowned TestMethod testmethod = null;
				string mname = Vala.Symbol.camel_case_to_lower_case(
					method.get_full_name()
					.replace(".","_")
				);

				testmethod = (TestMethod)config.module.get_method(mname);

				if (testmethod != null)
					current_test.add_test(method.name.substring(5), ()=> {
						testmethod(current_test);
					});
			}
		}
		return current_test;
	}

	public TestSuite visit_testsuite(Vala.Class testclass) throws ModuleError {
		string cname = Vala.Symbol.camel_case_to_lower_case(
			testclass.default_construction_method.get_full_name().replace(".","_"));

		string tname = Vala.Symbol.camel_case_to_lower_case(
			testclass.get_full_name().replace(".","/"));

		unowned Constructor meth = (Constructor)config.module.get_method(cname);
		var current_test = meth("%s%s/".printf(config.root.name, tname)) as TestSuite;
		
		return current_test;
	}

	public override void visit_namespace(Vala.Namespace ns) {
		
		if (ns.name == "GLib")
			return;

		if (ns.name == "Valadate") {
			ns.accept_children(this);
			return;
		}

		if (ns.name != null) {

			string testname = Vala.Symbol.camel_case_to_lower_case(
				ns.get_full_name().replace(".","/"));

			var nstest = new TestSuite("%s%s/".printf(config.root.name, testname));

			if (current != null)
				current.add_test(nstest);

			current = nstest;
		}

	}
	
	
}
