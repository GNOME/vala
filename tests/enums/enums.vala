using GLib;

enum Maman.Foo {
	VAL2 = 2,
	VAL3,
	VAL5 = 5
}

enum Maman.Fooish {
	VAL1,
	VAL2;

	public int something () {
		return (int) this;
	}

	public const int FOO = 2;
}

class Maman.Bar : Object {
	public void run () {
		stdout.printf (" %d", Foo.VAL2);

		stdout.printf (" %d", Foo.VAL3);

		stdout.printf (" 4");

		stdout.printf (" %d", Foo.VAL5);
	}

	static void test_enums_0_conversion () {
		Foo foo = 0;
	}

	static void test_enum_methods_constants () {
		Fooish x = Fooish.VAL1;
		stdout.printf ("%d", x.something ());
		stdout.printf ("%d", Fooish.FOO);
	}

	public static int main () {
		stdout.printf ("Enum Test: 1");

		var bar = new Bar ();
		bar.run ();

		stdout.printf (" 6\n");

		test_enums_0_conversion ();
		test_enum_methods_constants ();

		return 0;
	}
}
