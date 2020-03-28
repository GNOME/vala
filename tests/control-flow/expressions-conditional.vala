using GLib;

class Maman.Bar : Object {
	private static string get_number () {
		return false ? "BAD" : "4";
	}

	public static int main () {
		stdout.printf ("Conditional Expression Test: 1");

		stdout.printf (" %d", false ? -1 : 2);

		stdout.printf (" 3");

		stdout.printf (" %s", get_number ());

		stdout.printf (" 5\n");

		return 0;
	}
}
