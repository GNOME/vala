using GLib;

class Maman.Foo : Object {

	const string[] array_field = {"1", "2"};

	/* Does not work, because of bug 516287 
	static const public string s1_field = "1" + "2";
	static const string s2_field = "1" + "2";

	*/
	static void test_string_initializers () {
		/* Does not work yet. bug 530623
		// Local constant
		const string s1 = "1";
		assert (s1 == "1");
		*/

		/* Does not work yet. bug 530623 and bug 516287
		// Local constant with string concatenation
		const string s2 = "1" + "2";
		assert (s2 == "12");
		*/

		// string array
		string[] array1 = {"1", "2"};
		
		assert (array1[0] == "1");
		assert (array1[1] == "2");
		assert (array1.length == 2);

		// string array field
		assert (array_field[0] == "1");
		assert (array_field[1] == "2");
		assert (array_field.length == 2);

		/* Does not work, because of bug 516287 
		// const field string with concatenation
		assert (s1_field == "12");
		assert (s2_field == "12");
		*/
	}
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
		test_string_initializers ();

		return 0;
	}
}
