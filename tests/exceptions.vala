using GLib;
using Gee;

errordomain Maman.BarError {
	FOO,
	BAR,
	LIST
}

class Maman.Bar : Object {
	public void foo () throws BarError {
		stdout.printf (" 6");

		throw new BarError.FOO (" 8");

		stdout.printf (" BAD");
	}

	public int bad () throws BarError {
		stdout.printf (" 5");

		foo ();

		stdout.printf (" BAD");

		return 0;
	}

	public void good () throws BarError {
		stdout.printf (" 4");
	}

	public Gee.List<string> list () throws BarError {
		Gee.List<string> result = new ArrayList<string> ();

		result.add (" FOO");
		result.add (" BAR");

		throw new BarError.LIST (" 12");

		return result;
	}

	public void error_cast_check (GLib.Error e) {}

	public void run () {
		stdout.printf (" 2");

		try {
			stdout.printf (" 3");

			good ();

			int i = bad ();

			good ();

			stdout.printf (" BAD");
		} catch (BarError e) {
			stdout.printf (" 7");

			stdout.printf ("%s", e.message);

			stdout.printf (" 9");
		}

		stdout.printf (" 10");

		try {
			foreach (string s in list ()) {
				stdout.printf (" BAD");

				stdout.printf (" %s", s);

				stdout.printf (" BAD");
			}
		} catch (BarError e) {
			stdout.printf (" 11");

			stdout.printf ("%s", e.message);

			stdout.printf (" 13");
		}

		// test implicit cast to GLib.Error
		error_cast_check (new BarError.FOO ("FOO"));

		stdout.printf (" 14");
	}

	static void test_generic_catch () {
		try {
			throw new BarError.FOO ("error message");
		} catch (Error e) {
			return;
		}

		assert_not_reached ();
	}

	static int main (string[] args) {
		stdout.printf ("Exception Test: 1");
		
		var bar = new Bar ();
		bar.run ();

		stdout.printf (" 15\n");

		test_generic_catch ();

		return 0;
	}
}
