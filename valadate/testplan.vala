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

public class Valadate.TestPlan : Vala.CodeVisitor {

	[CCode (has_target = false)]
	public delegate void TestMethod (TestCase self) throws Error;

	public delegate void AsyncTestMethod (TestCase self, AsyncReadyCallback cb);
	public delegate void AsyncTestMethodResult (TestCase self, AsyncResult res) throws Error;

	public delegate Type GetType ();

	public File plan { get; set; }

	public TestAssembly assembly { get; set; }

	public TestOptions options { get; set; }

	public TestConfig config { get; set; }

	public TestResult result { get; set; }

	public TestRunner runner { get; set; }

	public TestSuite root { get; set; }

	private Vala.CodeContext context;
	private TestGatherer gatherer;
	private delegate TestCase Constructor ();
	private TestSuite testsuite;
	private TestCase testcase;

	public TestPlan (TestAssembly assembly) throws Error {

		this.assembly = assembly;
		options = assembly.options;

		var plan_name = Path.get_basename (assembly.binary.get_path ());
		if (plan_name.has_prefix ("lt-"))
			plan_name = plan_name.substring (3);

		plan = assembly.srcdir.get_child (plan_name + ".vapi");
		if (!plan.query_exists ()) {
			plan = assembly.builddir.get_child (plan_name + ".vapi");
			if (!plan.query_exists ())
				throw new TestConfigError.TESTPLAN ("Test Plan %s Not Found in %s or %s", plan_name, assembly.srcdir.get_path (), assembly.builddir.get_path ());
		}
		config = new TestConfig (options);
		runner = new TestRunner ();
		result = new TestResult (config);
		testsuite = root = new TestSuite ("/");
		setup_context ();
		load_test_plan ();
	}

	public int run () throws Error {
		return runner.run_all (this);
	}

	private void setup_context () {
		context = new Vala.CodeContext ();
		Vala.CodeContext.push (context);
		context.report.enable_warnings = false;
		context.report.set_verbose_errors (false);
		context.verbose_mode = false;
	}

	public void load_test_plan () throws Error {
		context.add_source_file (new Vala.SourceFile (
			context, Vala.SourceFileType.PACKAGE, plan.get_path ()));
		var parser = new Vala.Parser ();
		parser.parse (context);
		gatherer = new TestGatherer (assembly);
		context.accept (gatherer);
		context.accept (this);
	}

	public override void visit_namespace (Vala.Namespace ns) {
		if (ns.name != null) {
			var currpath = "/" + ns.get_full_name ().replace (".","/");
			if (config.in_subprocess)
				if (!options.running_test.has_prefix (currpath))
					return;

			if (currpath.last_index_of ("/") == 0)
				testsuite = root;

			var ts = new TestSuite (ns.name);
			testsuite.add_test (ts);
			testsuite = ts;
		}
		ns.accept_children (this);
	}

	public override void visit_class (Vala.Class cls) {

		var label = "/%s".printf (cls.get_full_name ().replace (".","/"));

		if(!in_testpath (label))
			return;

		try {
			if (is_subtype_of (cls, typeof (TestCase)) && !cls.is_abstract) {
				unowned Constructor ctor = get_constructor (cls);
				testcase = ctor ();
				testcase.name = cls.name;
				testcase.label = label;
				testsuite.add_test (testcase);
				visit_testcase (cls);

			} else if (is_subtype_of (cls,typeof (TestSuite))) {
				visit_testsuite (cls);
			}
		} catch (Error e) {
			error (e.message);
		}
		cls.accept_children (this);
	}

	private bool in_testpath (string path) {
		if (config.testpath == null)
			return true;

		var paths = path.split ("/");
		var testpaths = config.testpath.split ("/");

		for (int i = 1; i < int.max (testpaths.length, paths.length); i++) {
			if (testpaths[i] == null || paths[i] == null)
				break;
			if (testpaths[i] == "" || paths[i] == "")
				break;
			if (testpaths[i] != paths[i])
				return false;
		}
		return true;
	}

	private bool is_subtype_of (Vala.Class cls, Type type) {
		var t = Type.from_name (cls.get_full_name ().replace (".",""));
		if (t.is_a (type))
			return true;
		return false;
	}

	private unowned Constructor get_constructor (Vala.Class cls) throws Error {
		var attr = new Vala.CCodeAttribute (cls.default_construction_method);
		return (Constructor)assembly.get_method (attr.name);
	}

	public void visit_testcase (Vala.Class cls)  {

		var t = Type.from_name (cls.get_full_name ().replace (".",""));
		var p = t.parent ();
		if (p != typeof (TestCase)) {
			var basecls = gatherer.classes.get (p);
			if (basecls != null)
				visit_testcase (basecls);
		}

		foreach (var method in cls.get_methods ()) {

			var currpath = "%s/%s".printf (testcase.label, method.name);

			if (config.in_subprocess)
				if (options.running_test != currpath)
					continue;

			if (!is_test (method))
				continue;

			var added = false;
			foreach (var test in testcase)
				if (test.name == method.name)
					added=true;
			if (added)
				continue;

			var adapter = new TestAdapter (method.name, config.timeout);
			annotate_label (adapter);
			annotate (adapter, method);

			if (config.in_subprocess && adapter.status != TestStatus.SKIPPED) {
				var attr = new Vala.CCodeAttribute (method);

				if (method.coroutine) {
					try {
						unowned TestPlan.AsyncTestMethod beginmethod = (TestPlan.AsyncTestMethod)assembly.get_method (attr.name);
						unowned TestPlan.AsyncTestMethodResult testmethod = (TestPlan.AsyncTestMethodResult)assembly.get_method (attr.finish_real_name);
						adapter.add_async_test (beginmethod, testmethod);
					} catch (Error e) {
						var message = e.message;
						adapter.add_test_method (()=> {debug (message);});
					}
				} else {
					try {
						TestPlan.TestMethod testmethod = (TestPlan.TestMethod)assembly.get_method (attr.name);
						adapter.add_test ((owned)testmethod);
					} catch (Error e) {
						var message = e.message;
						adapter.add_test_method (()=> {debug (message);});
					}
				}
			}
			adapter.label = "%s/%s".printf (testcase.label,adapter.label);
			testcase.add_test (adapter);
		}

	}

	private void annotate_label (Test test) {
		if (test.name.has_prefix ("test_")) {
			test.label = test.name.substring (5);
		} else if (test.name.has_prefix ("_test_")) {
			test.label = test.name.substring (6);
			test.status = TestStatus.SKIPPED;
		} else if (test.name.has_prefix ("todo_test_")) {
			test.label = test.name.substring (10);
			test.status = TestStatus.TODO;
		} else {
			test.label = test.name;
		}
		test.label = test.label.replace ("_", " ");
	}

	private void annotate (TestAdapter adapter, Vala.Method method) {

		foreach (var attr in method.attributes) {
			if (attr.name == "Test") {
				if (attr.has_argument ("name"))
					adapter.label = attr.get_string ("name");
				if (attr.has_argument ("skip")) {
					adapter.status = TestStatus.SKIPPED;
					adapter.status_message = attr.get_string ("skip");
				} else if (attr.has_argument ("todo")) {
					adapter.status = TestStatus.SKIPPED;
					adapter.status_message = attr.get_string ("todo");
				} else if (attr.has_argument ("timeout")) {
					adapter.timeout = int.parse (attr.get_string ("timeout"));
				}
			}
		}
	}

	private bool is_test (Vala.Method method) {
		bool istest = false;

		if (method.is_virtual)
			foreach (var test in testcase)
				if (test.name == method.name)
					return false;

		if (method.name.has_prefix ("test_") ||
			method.name.has_prefix ("_test_") ||
			method.name.has_prefix ("todo_test_"))
			istest = true;

		foreach (var attr in method.attributes)
			if (attr.name == "Test")
				istest = true;

		if (method.has_result)
			istest = false;

		if (method.get_parameters ().size > 0)
			istest = false;

		return istest;
	}

	public void visit_testsuite (Vala.Class testclass) throws Error {
		unowned Constructor meth = get_constructor (testclass);
		var tsuite = meth () as TestSuite;
		tsuite.name = testclass.name;
		tsuite.label = "/%s".printf (testclass.get_full_name ().replace (".","/"));;
		testsuite.add_test (tsuite);
		testsuite = tsuite;
	}
}
