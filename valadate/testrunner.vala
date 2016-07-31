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

public class Valadate.TestRunner : Object {

	private uint _n_ongoing_tests = 0;
	private Queue<DelegateWrapper> _pending_tests = new Queue<DelegateWrapper> ();

	/* Change this to change the cap on the number of concurrent operations. */
	private const uint _max_n_ongoing_tests = 15;

	private class DelegateWrapper {
		public SourceFunc cb;
	}

	private SubprocessLauncher launcher =
		new SubprocessLauncher(GLib.SubprocessFlags.STDOUT_PIPE | GLib.SubprocessFlags.STDERR_MERGE);

	private string binary;
	
	public TestRunner(string binary) {
		this.binary = binary;
		this.launcher.setenv("G_MESSAGES_DEBUG","all", true);
		this.launcher.setenv("G_DEBUG","fatal-criticals fatal-warnings gc-friendly", true);
		this.launcher.setenv("G_SLICE","always-malloc debug-blocks", true);
		GLib.set_printerr_handler (printerr_func_stack_trace);
		Log.set_default_handler (log_func_stack_trace);
	}

	private static void printerr_func_stack_trace (string? text) {
		if (text == null || str_equal (text, ""))
			return;
		stderr.printf (text);

		/* Print a stack trace since we've hit some major issue */
		GLib.on_error_stack_trace ("libtool --mode=execute gdb");
	}

	private void log_func_stack_trace (
		string? log_domain,
		LogLevelFlags log_levels,
		string message)	{
		Log.default_handler (log_domain, log_levels, message);

		/* Print a stack trace for any message at the warning level or above */
		if ((log_levels & (
			LogLevelFlags.LEVEL_WARNING |
			LogLevelFlags.LEVEL_ERROR |
			LogLevelFlags.LEVEL_CRITICAL)) != 0) {
			GLib.on_error_stack_trace ("libtool --mode=execute gdb");
		}
	}

	public void run_test(Test test, TestResult result) {
		test.run(result);
	}

	public async void run(Test test, TestResult result) {
		
		string command = "%s -r %s".printf(binary, test.name);
		string[] args;
		string buffer = null;

		if (_n_ongoing_tests > _max_n_ongoing_tests) {
			var wrapper = new DelegateWrapper();
			wrapper.cb = run.callback;
			_pending_tests.push_tail((owned)wrapper);
			yield;
		}
	
		try {
			_n_ongoing_tests++;
			
			Shell.parse_argv(command, out args);
			var process = launcher.spawnv(args);
			yield process.communicate_utf8_async(null, null, out buffer, null);
			
			if(process.wait_check())
				process_buffer(test, result, buffer);

		} catch (Error e) {
			process_buffer(test, result, buffer, true);
		} finally {
			_n_ongoing_tests--;
			var wrapper = _pending_tests.pop_head ();
			if(wrapper != null)
				wrapper.cb();
		}
	}

	public void process_buffer(Test test, TestResult result, string buffer, bool failed = false) {
		string skip = null;
		string[] message = {};
		
		foreach(string line in buffer.split("\n"))
			if (line.has_prefix("SKIP "))
				skip = line;
			else
				message += line;
		
		if (skip != null)
			result.add_skip(test, skip, string.joinv("\n",message));
		else
			if(failed)
				result.add_failure(test, string.joinv("\n",message));
			else
				result.add_success(test, string.joinv("\n",message));
	}

	public static int main (string[] args) {
		
		var bin = args[0];
		var config = new TestConfig();
		int result = config.parse(args);

		if(result >= 0)
			return result;

		var runner = new TestRunner(bin);
		var testresult = new TestResult(config);
		testresult.run(runner);

		return 0;
	}
}
