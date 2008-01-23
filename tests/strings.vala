using GLib;

class Maman.Foo : Object {
	static void test_string_operators () {
		// string == operator compares content not reference
		string s1 = "string";
		string s2 = "string";
		bool eq = (s1 == s2);
		assert (eq);

		// allow null string comparison
		s1 = null;
		s2 = null;
		eq = (s1 == s2);
		assert (eq);
	}

	static int main (string[] args) {
		stdout.printf ("String Test: 1");

		stdout.printf (" 2" + " 3");

		string s = " 4";
		s += " 5";
		stdout.printf ("%s", s);

		string t = " 5 6 7 8".substring (2, 4);
		stdout.printf ("%s", t);

		stdout.printf (" 8\n");

		test_string_operators ();

		return 0;
	}
}
