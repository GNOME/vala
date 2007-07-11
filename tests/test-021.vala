using GLib;

class Maman.Foo {
	static int main (string[] args) {
		stdout.printf ("String Test: 1");

		stdout.printf (" 2" + " 3");

		string s = " 4";
		s += " 5";
		stdout.printf ("%s", s);

		string t = " 5 6 7 8".substring (2, 4);
		stdout.printf ("%s", t);

		stdout.printf (" 8\n");

		return 0;
	}
}
