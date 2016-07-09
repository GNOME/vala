/*
 * Valadate - Unit testing library for GObject-based libraries.
 * Copyright (C) 20016  Chris Daley <chebizarro@gmail.com>
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

namespace Valadate {

	public errordomain RunError {
		MODULE,
		GIR,
		TESTS,
		METHOD
	}


	public class TestRunner : Object {

		private Vala.CodeContext context;
		private Module module;
		private string path;
		private Test[] _tests;
		
		public Test[] tests {
			get {
				return _tests;
			}
		}

		public TestRunner(string path) {
			this.path = path;
		}

		public void load() throws RunError {
			string girdir = Path.get_dirname(path).replace(".libs", "");
			
			string girname = Path.get_basename(path);
			if(girname.has_prefix("lt-"))
				girname = girname.substring(3);
			
			string girfile = girdir + GLib.Path.DIR_SEPARATOR_S + girname + ".vapi";
			
			try {
				module = new Module(path);
				module.load_module();
				load_test_plan(girfile);

			} catch (Error e) {
				throw new RunError.MODULE(e.message);
			}
		}

		internal void load_test_plan(string girpath) {
			if (!FileUtils.test (girpath, FileTest.EXISTS))
				return;
			
			context = new Vala.CodeContext ();
			Vala.CodeContext.push (context);

			context.report.enable_warnings = false;
			context.report.set_verbose_errors (false);
			context.verbose_mode = false;
			
			File currdir = File.new_for_path(GLib.Environment.get_current_dir());
			File valadatedir = currdir.get_parent().get_child("valadate");
			File vapidir = currdir.get_parent().get_child("vapi");
			
			context.vapi_directories = {valadatedir.get_path(), vapidir.get_path()};
			
			context.add_external_package ("glib-2.0");
			context.add_external_package ("gobject-2.0");
			context.add_external_package ("gio-2.0");
			context.add_external_package ("gmodule-2.0");
			context.add_external_package ("valadate");
			
			context.add_source_file (new Vala.SourceFile (context, Vala.SourceFileType.PACKAGE, girpath));
			
			var parser = new Vala.Parser ();
			parser.parse (context);
			
			context.check ();
		
			var testexplorer = new TestExplorer(module);
			context.accept(testexplorer);
			_tests = testexplorer.get_tests();
			
		}



		public static int main (string[] args) {

			var runner = new TestRunner(args[0]);

			GLib.Test.init(ref args);

			try {
				runner.load();
			} catch (RunError err) {
				message(err.message);
				return -1;
			}

			foreach (Test test in runner.tests)
				GLib.TestSuite.get_root().add_suite(((TestCase)test).suite);

			GLib.Test.run ();
			
			runner = null;
			
			return 0;
			
		}

	
	}



}
