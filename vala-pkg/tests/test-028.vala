using GLib;

enum Maman.Foo {
	VAL2 = 2,
	VAL3,
	VAL5 = 5
}

class Maman.Bar {
	public void run () {
		stdout.printf (" %d", Foo.VAL2);

		stdout.printf (" %d", Foo.VAL3);

		stdout.printf (" 4");
		
		stdout.printf (" %d", Foo.VAL5);
	}

	static int main (string[] args) {
		stdout.printf ("Enum Test: 1");
		
		var bar = new Bar ();
		bar.run ();

		stdout.printf (" 6\n");
		
		return 0;
	}
}
