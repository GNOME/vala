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
public class Valadate.TestOptions {

	private static bool _async = true;
	private static string _format = "tap";
	private static bool _keepgoing = false;
	private static bool _list;
	private static bool _quiet;
	private static string _runtest = null;
	[CCode (array_length = false, array_null_terminated = true)]
	private static string[] _skip;
	private static int _timeout = 60000;
	private static string _seed;
	private static bool _timed = true;
	private static string _testplan;
	private static bool _verbose;
	private static bool _version;
	[CCode (array_length = false, array_null_terminated = true)]
	private static string[] _paths;

	public const OptionEntry[] options = {
		{ "async", 'a', 0, OptionArg.NONE, ref _async, "Run tests asynchronously in a separate subprocess [Experimental]", null },
		{ "format", 'f', 0, OptionArg.STRING, ref _format, "Output test results using format", "FORMAT" },
		{ "", 'k', 0, OptionArg.NONE, ref _keepgoing, "Skip failed tests and continue running", null },
		{ "list", 'l', 0, OptionArg.NONE, ref _list, "List test cases available in a test executable", null },
		{ "quiet", 'q', 0, OptionArg.NONE, ref _quiet, "Run tests quietly", null },
		{ "", 'r', 0, OptionArg.STRING, ref _runtest, null, null },
		{ "skip", 's', 0, OptionArg.STRING_ARRAY, ref _skip, "Skip all tests matching", "TESTPATH..." },
		{ "timeout", 't', 0, OptionArg.INT, ref _timeout, "Default timeout for tests", "MILLISECONDS" },
		{ "seed", 0, 0, OptionArg.STRING, ref _seed, "Start tests with random seed", "SEEDSTRING" },
		{ "timed", 0, 0, OptionArg.NONE, ref _timed, "Run timed tests", null },
		{ "testplan", 0, 0, OptionArg.STRING, ref _testplan, "Run the specified TestPlan", "FILE" },
		{ "verbose", 0, 0, OptionArg.NONE, ref _verbose, "Run tests verbosely", null },
		{ "version", 0, 0, OptionArg.NONE, ref _version, "Display version number", null },
		{ "", 0, 0, OptionArg.STRING_ARRAY, ref _paths, "Only start test cases matching", "TESTPATH..." },
		{ null }
	};

	public OptionContext opt_context;

	public static string? get_current_test_path () {
		return _runtest;
	}

	public string format {
		get {
			return _format;
		}
	}

	public string seed {
		get {
			return _seed;
		}
	}

	public string? running_test {
		get {
			return _runtest;
		}
	}

	public bool run_async {
		get {
			return _async;
		}
	}

	public bool list {
		get {
			return _list;
		}
	}

	public bool keepgoing {
		get {
			return _keepgoing;
		}
	}

	public int timeout {
		get {
			return _timeout;
		}
	}

	public bool timed {
		get {
			return _timed;
		}
	}

	public string[] testpaths {
		get {
			return _paths;
		}
	}

	public TestOptions (string[] args) throws OptionError {
		_runtest = null;

		opt_context = new OptionContext ("- Valadate Testing Framework");
		opt_context.set_help_enabled (true);
		opt_context.add_main_entries (options, null);
		opt_context.parse (ref args);

		if (_seed == null)
			_seed = "R02S%08x%08x%08x%08x".printf (
				GLib.Random.next_int (),
				GLib.Random.next_int (),
				GLib.Random.next_int (),
				GLib.Random.next_int ());

	}

}
