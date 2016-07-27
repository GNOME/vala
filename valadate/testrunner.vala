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

	private SubprocessLauncher launcher =
		new SubprocessLauncher(GLib.SubprocessFlags.STDOUT_PIPE | GLib.SubprocessFlags.STDERR_MERGE);
	
	private string binary;
	
	public TestRunner(string binary) {
		this.binary = binary;
		this.launcher.setenv("G_MESSAGES_DEBUG","all", true);
		this.launcher.setenv("G_DEBUG","fatal-criticals fatal-warnings gc-friendly", true);
		this.launcher.setenv("G_SLICE","always-malloc debug-blocks", true);
	}
	
	public void run_test(Test test, TestResult result) {
		test.run(result);
	}

	public void run(Test test, TestResult result) {
		
		string command = "%s -r %s".printf(binary, test.name);

		string[] args;

		string buffer = null;
		
		try {
			Shell.parse_argv(command, out args);

			var process = launcher.spawnv(args);
			process.communicate_utf8(null, null, out buffer, null);
			
			if(process.wait_check()) {
				result.add_success(test, buffer);
			}
		} catch (Error e) {
			result.add_error(test, buffer);
		}
		

	}


	public static int main (string[] args) {

		var config = new TestConfig();
		
		int result = config.parse(args);
		if(result >= 0)
			return result;

		var runner = new TestRunner(config.binary);
		var testresult = new TestResult(config);
		
		testresult.run(runner);

		return 0;
	}


}
