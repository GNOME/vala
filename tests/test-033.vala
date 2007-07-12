using GLib;

[ErrorDomain]
enum Maman.BarError {
	FOO,
	BAR
}

class Maman.Bar {
	public void foo () throws BarError {
		stdout.printf (" 6");

		throw new BarError.FOO (" 8");

		stdout.printf (" BAD");
	}

	public int bad () throws BarError {
		stdout.printf (" 5");

		foo ();

		stdout.printf (" BAD");
	}

	public void good () throws BarError {
		stdout.printf (" 4");
	}

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
	}

	static int main (string[] args) {
		stdout.printf ("Exception Test: 1");
		
		var bar = new Bar ();
		bar.run ();

		stdout.printf (" 11\n");
		
		return 0;
	}
}
