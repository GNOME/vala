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
		
	private Vala.Class testcase;
	private Vala.Class testsuite;


	private Test[] tests;
	private TestCase current_test;
	private weak Module module;
	private weak TestResult result;

	internal delegate void* Constructor(); 
	internal delegate void TestMethod(TestCase self);
	
	public TestExplorer(Module module, TestResult result) {
		this.module = module;
		this.result = result;
	}
	
	public Test[] get_tests() {
		return tests;
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

		if (testcase != null &&
			class.is_subtype_of(testcase) &&
			class.is_abstract != true ) {

			string cname = Vala.Symbol.camel_case_to_lower_case(
				class.default_construction_method.get_full_name().replace(".","_"));

			try {
				unowned Constructor meth = (Constructor)module.get_method(cname);
				current_test = meth() as TestCase;
				current_test.name = class.get_full_name().replace("."," ");
				
				foreach(var method in class.get_methods()) {
					if( method.name.has_prefix("test_") &&
						method.has_result != true &&
						method.get_parameters().size == 0
					) {
						unowned TestMethod testmethod = null;
						string mname = Vala.Symbol.camel_case_to_lower_case(
							method.get_full_name()
							.replace(".","_")
						);

						testmethod = (TestMethod)module.get_method(mname);

						if (testmethod != null)
							current_test.add_test(method.name.substring(5).replace("_"," "), ()=> {testmethod(current_test); });

						
					}
				}
				tests += current_test;

				class.accept_children(this);
			} catch (ModuleError e) {
				stderr.puts(e.message);
			}
		}
	}

	public override void visit_namespace(Vala.Namespace ns) {
		
		if (ns.name != "GLib")
			ns.accept_children(this);
		
	}
	
	
}
