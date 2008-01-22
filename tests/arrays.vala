using GLib;

class Maman.Foo : Object {
	public Foo (construct string bar) {
	}

	public string bar { get; set construct; }

	static void test_integer_array () {
		stdout.printf ("One dimensional array creation and assignment: 1");

		int[] a = new int[4] {1,2};
		
		stdout.printf (" 2");
		
		a[2] = 3;
		
		stdout.printf (" 3");
		
		a[3] = 4;
		
		stdout.printf (" 4");

		int i = 0;
		if (a[0] == 1) {
			stdout.printf (" 5");
		}
		if (a[1] == 2) {
			stdout.printf (" 6");
		}
		if (a[2] == 3) {
			stdout.printf (" 7");
		}
		if (a[3] == 4) {
			stdout.printf (" 8");
		}
		if (a.length == 4) {
			stdout.printf (" 9");
		}
		a.resize (10);
		stdout.printf (" %d", a.length);
	
		stdout.printf (" 11\n");
	}

	[NoArrayLength ()]
	static string[] create_unsized_string_array () {
		return new string[] { "a", "b", "c" };
	}

	static void test_string_array () {
		stdout.printf ("String array creation and assignment: 1");
		
		var a = new string[3] { "a", "b", "c" };
		var b = new string[] { "a", "b", "c" };
		var c = create_unsized_string_array ();

		if (3 == a.length) {
			stdout.printf (" 2");
		}
		if (3 == b.length) {
			stdout.printf (" 3");
		}
		if (-1 == c.length) {
			stdout.printf (" 4");
		}
		if (null == c[3]) {
			stdout.printf (" 5");
		}

		for (int i = 0; i < a.length; ++i) {
			if (a[i] == b[i]) {
				stdout.printf (" %d", i * 2 + 6);
			}
			if (a[i] == c[i]) {
				stdout.printf (" %d", i * 2 + 7);
			}
		}

		a[2] = null;
		b[1] = null;

		stdout.printf ("\n");
	}

	[NoArrayLength ()]
	static Foo[] create_unsized_object_array () {
		return new Foo[] { new Foo ("a"), new Foo ("b"), new Foo ("c") };
	}

	static void test_object_array () {
		stdout.printf ("Object array creation and assignment: 1");

		do {	
			var a = new Foo[3] { new Foo ("a"), new Foo ("b"), new Foo ("c") };
			var b = new Foo[] { new Foo ("a"), new Foo ("b"), new Foo ("c") };
			var c = create_unsized_object_array ();

			if (3 == a.length) {
				stdout.printf (" 2");
			}
			if (3 == b.length) {
				stdout.printf (" 3");
			}
			if (-1 == c.length) {
				stdout.printf (" 4");
			}
			if (null == c[3]) {
				stdout.printf (" 5");
			}

			for (int i = 0; i < a.length; ++i) {
				if (a[i].bar == b[i].bar) {
					stdout.printf (" %d", i * 2 + 6);
				}
				if (a[i].bar == c[i].bar) {
					stdout.printf (" %d", i * 2 + 7);
				}
			}

			a[2] = null;
			b[1] = null;
		} while (false);

		stdout.printf ("\n");
	}

	static void test_switch_on_strings () {
		var tokens = new string[] { "Hello", "World", "this", "is", "Vala", "GNOME", null };
		var t4 = " 5";

		stdout.printf ("testing switch on strings:");

		foreach (weak string t in tokens) {
			switch (t) {
				case "Hello":
					stdout.printf (" 1");
					break;

				case "World":
					stdout.printf (" 2");
					break;

				case "this":
					stdout.printf (" 3");
					break;

				case ("is"):
					stdout.printf (" 4");
					break;

				case tokens[4]:
					stdout.printf (t4);
					tokens[4] = "GNOME";
					t4 = " 6";
					break;

				default:
					stdout.printf (" 7");
					break;
			}
		}

		tokens[4] = null;

		stdout.printf ("\n");
	}

	static void test_array_creation_side_effects () {
		int i = 5;
		var arr = new int[i++];
		assert (arr.length == 5);
		assert (i == 6);
	}

	static void test_element_access () {
		stdout.printf ("Element access: 1");
		
		stdout.printf (" 2");
		
		var sa = "a,b,c,d".split (",");
		int i = 3;
		
		stdout.printf (" 3");
		
		if (sa[inc()] == "a") {
			stdout.printf (" 4");
		}
		if (sa[inc()] == "b") {
			stdout.printf (" 5");
		}
		if (sa[2] == "c") {
			stdout.printf (" 6");
		}
		if (sa[i] == "d") {
			stdout.printf (" 7");
		}

		string bar = "efgh";
		counter = 0;
		if (bar[inc()] == 'e') {
			stdout.printf (" 8");
		}
		if (bar[inc()] == 'f') {
			stdout.printf (" 9");
		}
		if (bar[2] == 'g') {
			stdout.printf (" 10");
		}
		if (bar[i] == 'h') {
			stdout.printf (" 11");
		}

		stdout.printf (" 12");

		stdout.printf (" 13\n");
	}

	static void main (string[] args) {
		test_integer_array ();
		test_string_array ();
		test_object_array ();

		stdout.printf ("Array Test: 1");
		
		var bar = new Bar ();
		bar.run ();

		stdout.printf (" 5\n");

		test_switch_on_strings ();

		test_array_creation_side_effects ();

		test_element_access ();
	}
	
	public static int inc () {
		return counter++;
	}

	private static int counter = 0;
}

class Maman.Bar : Object {
	public int[] foo_numbers () {
		return new int[3] { 2, 3, 4 };
	}

	public void run () {
		foreach (int i in foo_numbers ()) {
			stdout.printf (" %d", i);
		}
	}
}

