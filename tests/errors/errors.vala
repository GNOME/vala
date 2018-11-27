using GLib;

errordomain BarError {
	FOO,
	BAR
}

class Bar : Object {
	public void foo () throws BarError {
		stdout.printf (" 6");

		throw new BarError.FOO (" 8");

		assert_not_reached ();
	}

	public int bad () throws BarError {
		stdout.printf (" 5");

		foo ();

		assert_not_reached ();

		return 0;
	}

	public void good () throws BarError {
		stdout.printf (" 4");
	}

	public void error_cast_check (GLib.Error e) {}

	public void run () {
		stdout.printf (" 2");

		try {
			stdout.printf (" 3");

			good ();

			int i = bad ();

			good ();

			assert_not_reached ();
		} catch (BarError e) {
			stdout.printf (" 7");

			stdout.printf ("%s", e.message);

			stdout.printf (" 9");
		}

		stdout.printf (" 10");
	}

	public static void test_generic_catch () {
		try {
			throw new BarError.FOO ("error message");
		} catch (Error e) {
			if (e is BarError && e is BarError.FOO) {
				return;
			}
		}

		assert_not_reached ();
	}

	public static void test_try_without_error () {
		try {
		} catch (Error e) {
			assert_not_reached ();
		}
	}
}

void main () {
	stdout.printf ("Exception Test: 1");

	var bar = new Bar ();
	bar.run ();

	stdout.printf (" 11\n");

	Bar.test_generic_catch ();
	Bar.test_try_without_error ();
}
