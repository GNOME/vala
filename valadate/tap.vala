/*
 * Valadate - Unit testing library for GObject-based libraries.
 * Ported from JTap - http://svn.solucorp.qc.ca/repos/solucorp/JTap/trunk/
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
 */

public class Valadate.Tap : Object {
	
	private const string version = "1.0";
	
	private bool plan_set = false;
	private bool no_plan = false;
	private bool skip_all = false;
	private bool test_died = false;
	private int expected_tests = 0;
	private int executed_tests = 0;
	private int failed_tests = 0;
	private bool _exit = true;
	private string? todo = null;
	

	public Tap(bool really_exit = true) {
		_exit = really_exit;
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

	public int plan_no_plan() {
		if (plan_set)
			die("You tried to plan twice!");

		plan_set = true;
		no_plan = true;
		return 1;
	}


	public int plan_skip_all(string reason) {
		if (plan_set)
			die("You tried to plan twice!");

		print_plan(0, "Skip " + reason);

		skip_all = true;
		plan_set = true;

		exit(0);
		return 0;
	}


	public int plan_tests(int tests) {
		if (plan_set)
			die("You tried to plan twice!");

		if (tests == 0)
			die("You said to run 0 tests!  You've got to run something.");

		print_plan(tests);
		expected_tests = tests;

		plan_set = true;

		return tests;
	}


	private void print_plan(int expected_tests, string? directive = null) {
		stdout.puts("1.." + expected_tests.to_string());
		if (directive != null)
			stdout.puts(" # " + directive);

		stdout.puts("\n");
		stdout.flush();
	}

	public bool pass(string name) {
		return ok(true, name);
	}

	public bool fail(string name) {
		return ok(false, name);
	}

	/*
		This is the workhorse method that actually
		prints the tests result.
	*/
	public bool ok(bool result, string? name= null) {
		if (!plan_set)
			die("You tried to run a test without a plan!  Gotta have a plan.");

		executed_tests++;

		if (!result) {
			stdout.puts("not ");
			failed_tests++;
		}
		stdout.puts("ok " + executed_tests.to_string());

		if (name != null) {
			stdout.puts(" - ");
			stdout.puts(name.replace("#", "\\\\#"));
		}

		if (todo != null) {
			stdout.puts(" # TODO " + todo);
			if (!result)
				failed_tests--;
		}

		stdout.puts("\n");
		stdout.flush();

		if (!result) {
			/*
			string file = null;
			string clas = null;
			string func = null;
			int line = 0;

			try {
				for (int i = 0 ; i < stack.length ; i++) {
					Class c = Class.forName(stack[i].getClassName());
					if (! Tap.class.isAssignableFrom(c)) {
						// We are outside a Tap object, so this is probably the callpoint
						file = stack[i].getFileName();
						clas = c.getName();
						func = stack[i].getMethodName();
						line = stack[i].getLineNumber();
						break;
					}
				}
			}
			catch (Exception e) {
				e.printStackTrace();
			}
	
			if (name != null) {		
				diag("  Failed " + (todo == null ? "" : "(TODO) ") + "test '" + name + "'");
				diag("  in " + file + ":" + func + "() at line " + line + ".");
			}
			else {
				diag("  Failed " + (todo == null ? "" : "(TODO) ") + "test in " + file + ":" + func + "() at line " + line + ".");
			}*/
		}

		return result;
	}

	private bool equals(Value result, Value expected) {
		bool r;

		if ((result.peek_pointer() == null)&&(expected.peek_pointer() == null))
			r = true;
		else if ((result.peek_pointer() == null)||(expected.peek_pointer() == null))
			r = false;
		else
			r = (result == expected);

		return r;
	}


	private bool matches(Value result, string? pattern) {
		bool r;

		if ((result.peek_pointer() == null)||(pattern == null))
			r = false;
		else
			r = (result.get_string() == pattern);

		return r;
	}


	private void is_diag(Value result, Value expected) {
		diag("         got: '" + result.get_string() + "'");
		diag("    expected: '" + expected.get_string() + "'");
	}


	public bool is(Value result, Value expected, string? name = null) {
		bool r = ok(equals(result, expected), name);
		if (!r)
			is_diag(result, expected);
		return r;
	}


	public bool isnt(Value result, Value expected, string? name = null) {
		bool r = ok(!equals(result, expected), name);
		if (! r)
			is_diag(result, expected);
		return r;
	}

	public bool like(Value result, string pattern, string? name = null) {
		bool r = ok(matches(result, pattern), name);
		if (!r)
			diag("    " + result.get_string() + " doesn't match '" + pattern + "'");
		return r;
	}

	public bool unlike(Value result, string pattern, string? name = null) {
		bool r = ok(! matches(result, pattern), name);
		if (! r)
			diag("    " + result.get_string() + " matches '" + pattern + "'");
		return r;
	}

	public bool isa_ok(Value o, Type c, string? name = null) {

		bool r = false;
		if ((o.peek_pointer() == null)||(c == Type.INVALID))
			r = false ;
		else
			r = ok(c.is_a(o.type()), name);

		if (!r)
			diag("    Value isn't a '" + c.name() + "' it's a '" + o.type().name() + "'");

		return r;
	}


	public void skip(string reason, int n = 1) throws TapError {
		for (int i = 0 ; i < n ; i++) {
			executed_tests++;
			stdout.puts("ok " + executed_tests.to_string() + " # skip " + reason + "\n");
			stdout.flush();
		}
		throw new TapError.SKIP(reason);
	}


	public void todo_start(string reason) {
		if (reason == "")
			reason = null;
		todo = reason;
	}


	public void todo_end() {
		todo = null;
	}


	public bool diag(string msg) {
		if (msg != null) {
			string[] lines = msg.split("\n");
			StringBuilder buf = new StringBuilder() ; 
			for (int i = 0 ; i < lines.length ; i++)
				buf.append("# " + lines[i] + "\n");
			stdout.puts(buf.str);
			stdout.flush();
		}
		return false;
	}


	
	private void die(string reason) {
		stderr.puts(reason + "\n");
        test_died = true;
		exit(255);
	}


	public void BAIL_OUT(string reason) {
		stdout.puts("Bail out! " + reason + "\n");
		stdout.flush();
		exit(255);
	}


	private int cleanup() {
		int rc = 0;

		if (! plan_set) {
			diag("Looks like your test died before it could output anything.");
			return rc;
		}

		if (test_died) {
			diag("Looks like your test died just after " + executed_tests.to_string() + ".");
			return rc;
		}

		if ((! skip_all)&&(no_plan)) {
			print_plan(executed_tests);
		}

		if ((! no_plan)&&(expected_tests < executed_tests)) {
			diag("Looks like you planned " + expected_tests.to_string() + " test" + (expected_tests > 1 ? "s" : "") + " but ran "
				+ (executed_tests - expected_tests).to_string() + " extra.");
			rc = -1;
		}

		if ((! no_plan)&&(expected_tests > executed_tests)) {
			diag("Looks like you planned " + expected_tests.to_string() + " test" + (expected_tests > 1 ? "s" : "") + " but only ran "
				+ executed_tests.to_string() + ".");
		}

		if (failed_tests > 0) {
			diag("Looks like you failed " + failed_tests.to_string() + " test" + (failed_tests > 1 ? "s" : "") + " of " + executed_tests.to_string() + ".");
		}

		return rc;
	}


	public int exit_status() {
		if ((no_plan)||(! plan_set))
			return failed_tests;

		if (expected_tests < executed_tests)
			return executed_tests - expected_tests;

		return failed_tests + (expected_tests - executed_tests);
	}


	private void exit(int rc = 0) {
		int alt_rc = cleanup();

		if (alt_rc != 0)
			rc = alt_rc;

		//if (_exit)
			//System.exit(rc);
		//else
			//throw new TapError.EXIT(rc.to_string());
	}
}

public errordomain Valadate.TapError {
	EXIT,
	SKIP
}
