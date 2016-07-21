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

	private TestConfig config;

	private TestResult result;

	private SubprocessLauncher launcher =
		new SubprocessLauncher(GLib.SubprocessFlags.STDOUT_PIPE | GLib.SubprocessFlags.STDERR_PIPE);
	
	
	public TestRunner(TestConfig config) {
		this.config = config;
	}

	public void run(TestResult result) {
		
		this.result = result;
		
		if (TestConfig.runtest != null && config.root.count == 1) {
			config.root.run(result);
			return;
		}
		
		run_test(config.root);
		
	}


	private void run_test(Test test) {
		
		message(test.count.to_string());
		
		if (test.count > 1) {
			foreach(var subtest in test) {
				run_test(subtest);
			}
		} else {
			string command = "%s -r ".printf(config.binary);

			string[] args;
			Shell.parse_argv(command, out args);

			var process = launcher.spawnv(args);
			var stderr_pipe = process.get_stderr_pipe();

			uint8 buffer[1028];
			var err = stderr_pipe.read(buffer);

		}
	}


	public static int main (string[] args) {

		var config = new TestConfig();
		
		int result = config.parse(args);
		if(result >= 0)
			return result;

		var runner = new TestRunner(config);
		var testresult = new TestResult();
		
		try {
			runner.run(testresult);
		} catch (ConfigError err) {
			stderr.puts(err.message);
			return 1;
		}

		return 0;
	}


}
