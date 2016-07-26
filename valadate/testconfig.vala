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

public class Valadate.TestConfig : Object {

	private static string _seed;
	private static string testplan;
	private static string _runtest;
	private static string format = "tap";
	private static bool fatal_warnings;
	private static bool list;
	private static bool quiet;
	private static bool timed;
	private static bool verbose;
	private static bool version;
	private static bool vala_version;

	[CCode (array_length = false, array_null_terminated = true)]
	private static string[] paths;
	[CCode (array_length = false, array_null_terminated = true)]
	private static string[] skip;


	public string seed {
		get {
			return _seed;
		}
	}

	public string runtest {
		get {
			return _runtest;
		}
	}

	public bool list_only {
		get {
			return list;
		}
	}

	public string binary {get;set;}

	public TestSuite root {get;set;}

	public int test_count {get;set;default=0;}

	public OptionContext opt_context;

	private Vala.CodeContext context;
	internal Module module;


	public const OptionEntry[] options = {
		{ "seed", 0, 0, OptionArg.STRING, ref _seed, "Start tests with random seed", "SEEDSTRING" },
		{ "format", 'f', 0, OptionArg.STRING, ref format, "Output test results using format", "FORMAT" },
		{ "g-fatal-warnings", 0, 0, OptionArg.NONE, ref fatal_warnings, "Make all warnings fatal", null },
		{ "list", 'l', 0, OptionArg.NONE, ref list, "List test cases available in a test executable", null },
		{ "skip", 's', 0, OptionArg.STRING_ARRAY, ref skip, "Skip all tests matching", "TESTPATH..." },
		{ "quiet", 'q', 0, OptionArg.NONE, ref quiet, "Run tests quietly", null },
		{ "timed", 0, 0, OptionArg.NONE, ref timed, "Run timed tests", null },
		{ "testplan", 0, 0, OptionArg.STRING, ref testplan, "Run the specified TestPlan", "FILE" },
		{ "", 'r', 0, OptionArg.STRING, ref _runtest, null, null },
		{ "verbose", 0, 0, OptionArg.NONE, ref verbose, "Run tests verbosely", null },
		{ "version", 0, 0, OptionArg.NONE, ref version, "Display version number", null },
		{ "vala-version", 0, 0, OptionArg.NONE, ref vala_version, "Display Vala version number", null },
		{ "", 0, 0, OptionArg.STRING_ARRAY, ref paths, "Only start test cases matching", "TESTPATH..." },
		{ null }
	};


	public TestConfig() {
		opt_context = new OptionContext ("- Valadate Testing Framework");
		opt_context.set_help_enabled (true);
		opt_context.add_main_entries (options, null);
	}

	private void setup_context() {
		context = new Vala.CodeContext ();
		Vala.CodeContext.push (context);
		context.report.enable_warnings = false;
		context.report.set_verbose_errors (false);
		context.verbose_mode = false;
	}

	public int parse(string[] args) {
		binary = args[0];
		GLib.Environment.set_prgname(binary);

		try {
			opt_context.parse (ref args);
		} catch (OptionError e) {
			stdout.printf ("%s\n", e.message);
			stdout.printf ("Run '%s --help' to see a full list of available command line options.\n", args[0]);
			return 1;
		}

		if (version) {
			stdout.printf ("Valadate %s\n", "1.0");
			return 0;
		} else if (vala_version) {
			stdout.printf ("Vala %s\n", Config.PACKAGE_SUFFIX.substring (1));
			return 0;
		}
		
		if(_seed == null)
			_seed = "R02S%08x%08x%08x%08x".printf(
				GLib.Random.next_int(),
				GLib.Random.next_int(),
				GLib.Random.next_int(),
				GLib.Random.next_int());
		
		root = new TestSuite("/");
		
		try {
			load();
		} catch (ConfigError e) {
			stdout.printf ("%s\n", e.message);
			return 1;
		}
		
		return -1;
	}

	private void load() throws ConfigError {
		string testdir = Path.get_dirname(binary).replace(".libs", "");
		
		string testplan = Path.get_basename(binary);
		if(testplan.has_prefix("lt-"))
			testplan = testplan.substring(3);
		
		string testplanfile = testdir + GLib.Path.DIR_SEPARATOR_S + testplan + ".vapi";
		
		if (!FileUtils.test (testplanfile, FileTest.EXISTS))
			throw new ConfigError.TESTPLAN("Test Plan %s Not Found!", testplanfile);
		
		try {
			module = new Module(binary);
			module.load_module();
			load_test_plan(testplanfile);
		} catch (ModuleError e) {
			throw new ConfigError.MODULE(e.message);
		}
	}


	internal void load_test_plan(string path) throws ConfigError {
		setup_context();

		context.add_source_file (new Vala.SourceFile (context, Vala.SourceFileType.PACKAGE, path));
		
		var parser = new Vala.Parser ();
		parser.parse (context);
			
		var testexplorer = new TestExplorer(this);
		context.accept(testexplorer);
	}

}

public errordomain Valadate.ConfigError {
	MODULE,
	TESTPLAN
}
