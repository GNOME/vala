using GLib;

enum Maman.Foo {
	VAL2 = 2,
	VAL3,
	VAL5 = 5
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

	public static int main () {
		stdout.printf ("Enum Test: 1");
		
		var bar = new Bar ();
		bar.run ();

		stdout.printf (" 6\n");

		test_enums_0_conversion ();

		return 0;
	}
}

void main () {
	Maman.Bar.main ();
}

