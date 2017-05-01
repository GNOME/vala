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

public errordomain Valadate.TestConfigError {
	MODULE,
	TESTPLAN,
	METHOD,
	TEST_PRINTER
}

public enum Valadate.TestFormat {
	GNU,
	TAP,
	XML
}

public class Valadate.TestConfig {

	private static string _format = "tap";
	private static bool _keepgoing = false;
	private static bool _list;
	private static string _running_test = null;
	private static int _timeout = 60000;
	private static string _seed;
	private static bool _timed = true;
	private static bool _version;
	private static string _path = null;

	public const OptionEntry[] options = {
		{ "format", 'f', 0, OptionArg.STRING, ref _format, "Output test results using format", "FORMAT" },
		{ "", 'k', 0, OptionArg.NONE, ref _keepgoing, "Skip failed tests and continue running", null },
		{ "list", 'l', 0, OptionArg.NONE, ref _list, "List test cases available in a test executable", null },
		{ "", 'r', 0, OptionArg.STRING, ref _running_test, null, null },
		{ "timeout", 't', 0, OptionArg.INT, ref _timeout, "Default timeout for tests", "MILLISECONDS" },
		{ "seed", 0, 0, OptionArg.STRING, ref _seed, "Start tests with random seed", "SEEDSTRING" },
		{ "version", 0, 0, OptionArg.NONE, ref _version, "Display version number", null },
		{ "path", 'p', 0, OptionArg.STRING, ref _path, "Only start test cases matching", "TESTPATH..." },
		{ null }
	};

	public OptionContext opt_context;

	public virtual string format {
		get {
			return _format;
		}
	}

	public virtual string seed {
		get {
			return _seed;
		}
	}

	public string? testpath {
		get {
			return _path;
		}
	}

	public string? running_test {
		get {
			return _running_test;
		}
	}

	public bool in_subprocess {
		get {
			return _running_test != null;
		}
	}

	public virtual bool list_only {
		get {
			return _list;
		}
	}

	public virtual bool keep_going {
		get {
			return _keepgoing;
		}
	}

	public virtual int timeout {
		get {
			return _timeout;
		}
	}

	public virtual bool timed {
		get {
			return _timed;
		}
	}

	public TestConfig (string[] args) {
		_running_test = null;

		try {
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

		} catch (OptionError e) {
			stdout.printf ("%s\n", e.message);
			stdout.printf ("Run '%s --help' to see a full list of available command line options.\n", args[0]);
		}
	}
}
