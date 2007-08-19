using GLib;

class Maman.Foo {
	public Foo (construct string bar) {
	}

	public ~Foo () {
		stdout.printf (" %s", _bar);
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

	static void main (string[] args) {
		test_integer_array ();
		test_string_array ();
		test_object_array ();
	}
}
